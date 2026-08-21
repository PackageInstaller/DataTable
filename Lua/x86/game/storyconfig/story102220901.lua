return {
	Play222091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 222091001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play222091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J13f"

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
				local var_4_5 = arg_1_1.bgs_.J13f

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
					if iter_4_0 ~= "J13f" then
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
			local var_4_23 = 0.0666666666666667

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

			local var_4_28 = 0.1
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_0_warchess", "bgm_activity_2_0_warchess", "bgm_activity_2_0_warchess.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_0_warchess", "bgm_activity_2_0_warchess")

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

				local var_4_37 = arg_1_1:GetWordFromCfg(222091001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 33
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
	Play222091002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 222091002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play222091003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.75

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

				local var_12_2 = arg_9_1:GetWordFromCfg(222091002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 30
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
	Play222091003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 222091003
		arg_13_1.duration_ = 2.17

		local var_13_0 = {
			ja = 2.166,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_13_0:Play222091004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10039ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "10039ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "10039ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["10039ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos10039ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(-0.7, -0.8, -6.2)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10039ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["10039ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect10039ui_story == nil then
				arg_13_1.var_.characterEffect10039ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect10039ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect10039ui_story then
				arg_13_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_16_20 = 0
			local var_16_21 = 0.1

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[472].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(222091003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 4
				local var_16_26 = utf8.len(var_16_24)
				local var_16_27 = var_16_25 <= 0 and var_16_21 or var_16_21 * (var_16_26 / var_16_25)

				if var_16_27 > 0 and var_16_21 < var_16_27 then
					arg_13_1.talkMaxDuration = var_16_27

					if var_16_27 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_20
					end
				end

				arg_13_1.text_.text = var_16_24
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091003", "story_v_out_222091.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_out_222091", "222091003", "story_v_out_222091.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_out_222091", "222091003", "story_v_out_222091.awb")

						arg_13_1:RecordAudio("222091003", var_16_29)
						arg_13_1:RecordAudio("222091003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_222091", "222091003", "story_v_out_222091.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_222091", "222091003", "story_v_out_222091.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_30 = math.max(var_16_21, arg_13_1.talkMaxDuration)

			if var_16_20 <= arg_13_1.time_ and arg_13_1.time_ < var_16_20 + var_16_30 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_20) / var_16_30

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_20 + var_16_30 and arg_13_1.time_ < var_16_20 + var_16_30 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play222091004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 222091004
		arg_17_1.duration_ = 5.1

		local var_17_0 = {
			ja = 5.1,
			ko = 2.933,
			zh = 2.933
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
				arg_17_0:Play222091005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1070ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1070ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_17_1.stage_.transform)

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

			local var_20_5 = arg_17_1.actors_["1070ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos1070ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(0.7, -0.95, -6.05)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1070ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["1070ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1070ui_story == nil then
				arg_17_1.var_.characterEffect1070ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.200000002980232

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect1070ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1070ui_story then
				arg_17_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_20 = arg_17_1.actors_["10039ui_story"]
			local var_20_21 = 0

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 and not isNil(var_20_20) and arg_17_1.var_.characterEffect10039ui_story == nil then
				arg_17_1.var_.characterEffect10039ui_story = var_20_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_22 = 0.200000002980232

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_22 and not isNil(var_20_20) then
				local var_20_23 = (arg_17_1.time_ - var_20_21) / var_20_22

				if arg_17_1.var_.characterEffect10039ui_story and not isNil(var_20_20) then
					local var_20_24 = Mathf.Lerp(0, 0.5, var_20_23)

					arg_17_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10039ui_story.fillRatio = var_20_24
				end
			end

			if arg_17_1.time_ >= var_20_21 + var_20_22 and arg_17_1.time_ < var_20_21 + var_20_22 + arg_20_0 and not isNil(var_20_20) and arg_17_1.var_.characterEffect10039ui_story then
				local var_20_25 = 0.5

				arg_17_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10039ui_story.fillRatio = var_20_25
			end

			local var_20_26 = 0
			local var_20_27 = 0.35

			if var_20_26 < arg_17_1.time_ and arg_17_1.time_ <= var_20_26 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_28 = arg_17_1:FormatText(StoryNameCfg[318].name)

				arg_17_1.leftNameTxt_.text = var_20_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_29 = arg_17_1:GetWordFromCfg(222091004)
				local var_20_30 = arg_17_1:FormatText(var_20_29.content)

				arg_17_1.text_.text = var_20_30

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_31 = 14
				local var_20_32 = utf8.len(var_20_30)
				local var_20_33 = var_20_31 <= 0 and var_20_27 or var_20_27 * (var_20_32 / var_20_31)

				if var_20_33 > 0 and var_20_27 < var_20_33 then
					arg_17_1.talkMaxDuration = var_20_33

					if var_20_33 + var_20_26 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_33 + var_20_26
					end
				end

				arg_17_1.text_.text = var_20_30
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091004", "story_v_out_222091.awb") ~= 0 then
					local var_20_34 = manager.audio:GetVoiceLength("story_v_out_222091", "222091004", "story_v_out_222091.awb") / 1000

					if var_20_34 + var_20_26 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_34 + var_20_26
					end

					if var_20_29.prefab_name ~= "" and arg_17_1.actors_[var_20_29.prefab_name] ~= nil then
						local var_20_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_29.prefab_name].transform, "story_v_out_222091", "222091004", "story_v_out_222091.awb")

						arg_17_1:RecordAudio("222091004", var_20_35)
						arg_17_1:RecordAudio("222091004", var_20_35)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_222091", "222091004", "story_v_out_222091.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_222091", "222091004", "story_v_out_222091.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_36 = math.max(var_20_27, arg_17_1.talkMaxDuration)

			if var_20_26 <= arg_17_1.time_ and arg_17_1.time_ < var_20_26 + var_20_36 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_26) / var_20_36

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_26 + var_20_36 and arg_17_1.time_ < var_20_26 + var_20_36 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play222091005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 222091005
		arg_21_1.duration_ = 4.13

		local var_21_0 = {
			ja = 3.4,
			ko = 4.1,
			zh = 4.133
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
				arg_21_0:Play222091006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1070ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1070ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1070ui_story, var_24_4, var_24_3)

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

			local var_24_9 = arg_21_1.actors_["1070ui_story"]
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1070ui_story == nil then
				arg_21_1.var_.characterEffect1070ui_story = var_24_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 and not isNil(var_24_9) then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11

				if arg_21_1.var_.characterEffect1070ui_story and not isNil(var_24_9) then
					local var_24_13 = Mathf.Lerp(0, 0.5, var_24_12)

					arg_21_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1070ui_story.fillRatio = var_24_13
				end
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1070ui_story then
				local var_24_14 = 0.5

				arg_21_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1070ui_story.fillRatio = var_24_14
			end

			local var_24_15 = arg_21_1.actors_["10039ui_story"].transform
			local var_24_16 = 0

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.var_.moveOldPos10039ui_story = var_24_15.localPosition
			end

			local var_24_17 = 0.001

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_17 then
				local var_24_18 = (arg_21_1.time_ - var_24_16) / var_24_17
				local var_24_19 = Vector3.New(0, 100, 0)

				var_24_15.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10039ui_story, var_24_19, var_24_18)

				local var_24_20 = manager.ui.mainCamera.transform.position - var_24_15.position

				var_24_15.forward = Vector3.New(var_24_20.x, var_24_20.y, var_24_20.z)

				local var_24_21 = var_24_15.localEulerAngles

				var_24_21.z = 0
				var_24_21.x = 0
				var_24_15.localEulerAngles = var_24_21
			end

			if arg_21_1.time_ >= var_24_16 + var_24_17 and arg_21_1.time_ < var_24_16 + var_24_17 + arg_24_0 then
				var_24_15.localPosition = Vector3.New(0, 100, 0)

				local var_24_22 = manager.ui.mainCamera.transform.position - var_24_15.position

				var_24_15.forward = Vector3.New(var_24_22.x, var_24_22.y, var_24_22.z)

				local var_24_23 = var_24_15.localEulerAngles

				var_24_23.z = 0
				var_24_23.x = 0
				var_24_15.localEulerAngles = var_24_23
			end

			local var_24_24 = arg_21_1.actors_["10039ui_story"]
			local var_24_25 = 0

			if var_24_25 < arg_21_1.time_ and arg_21_1.time_ <= var_24_25 + arg_24_0 and not isNil(var_24_24) and arg_21_1.var_.characterEffect10039ui_story == nil then
				arg_21_1.var_.characterEffect10039ui_story = var_24_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_26 = 0.200000002980232

			if var_24_25 <= arg_21_1.time_ and arg_21_1.time_ < var_24_25 + var_24_26 and not isNil(var_24_24) then
				local var_24_27 = (arg_21_1.time_ - var_24_25) / var_24_26

				if arg_21_1.var_.characterEffect10039ui_story and not isNil(var_24_24) then
					local var_24_28 = Mathf.Lerp(0, 0.5, var_24_27)

					arg_21_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10039ui_story.fillRatio = var_24_28
				end
			end

			if arg_21_1.time_ >= var_24_25 + var_24_26 and arg_21_1.time_ < var_24_25 + var_24_26 + arg_24_0 and not isNil(var_24_24) and arg_21_1.var_.characterEffect10039ui_story then
				local var_24_29 = 0.5

				arg_21_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10039ui_story.fillRatio = var_24_29
			end

			local var_24_30 = "1074ui_story"

			if arg_21_1.actors_[var_24_30] == nil then
				local var_24_31 = Asset.Load("Char/" .. "1074ui_story")

				if not isNil(var_24_31) then
					local var_24_32 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_21_1.stage_.transform)

					var_24_32.name = var_24_30
					var_24_32.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_30] = var_24_32

					local var_24_33 = var_24_32:GetComponentInChildren(typeof(CharacterEffect))

					var_24_33.enabled = true

					local var_24_34 = GameObjectTools.GetOrAddComponent(var_24_32, typeof(DynamicBoneHelper))

					if var_24_34 then
						var_24_34:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_33.transform, false)

					arg_21_1.var_[var_24_30 .. "Animator"] = var_24_33.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_30 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_30 .. "LipSync"] = var_24_33.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_35 = arg_21_1.actors_["1074ui_story"].transform
			local var_24_36 = 0

			if var_24_36 < arg_21_1.time_ and arg_21_1.time_ <= var_24_36 + arg_24_0 then
				arg_21_1.var_.moveOldPos1074ui_story = var_24_35.localPosition
			end

			local var_24_37 = 0.001

			if var_24_36 <= arg_21_1.time_ and arg_21_1.time_ < var_24_36 + var_24_37 then
				local var_24_38 = (arg_21_1.time_ - var_24_36) / var_24_37
				local var_24_39 = Vector3.New(0, -1.055, -6.12)

				var_24_35.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1074ui_story, var_24_39, var_24_38)

				local var_24_40 = manager.ui.mainCamera.transform.position - var_24_35.position

				var_24_35.forward = Vector3.New(var_24_40.x, var_24_40.y, var_24_40.z)

				local var_24_41 = var_24_35.localEulerAngles

				var_24_41.z = 0
				var_24_41.x = 0
				var_24_35.localEulerAngles = var_24_41
			end

			if arg_21_1.time_ >= var_24_36 + var_24_37 and arg_21_1.time_ < var_24_36 + var_24_37 + arg_24_0 then
				var_24_35.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_24_42 = manager.ui.mainCamera.transform.position - var_24_35.position

				var_24_35.forward = Vector3.New(var_24_42.x, var_24_42.y, var_24_42.z)

				local var_24_43 = var_24_35.localEulerAngles

				var_24_43.z = 0
				var_24_43.x = 0
				var_24_35.localEulerAngles = var_24_43
			end

			local var_24_44 = arg_21_1.actors_["1074ui_story"]
			local var_24_45 = 0

			if var_24_45 < arg_21_1.time_ and arg_21_1.time_ <= var_24_45 + arg_24_0 and not isNil(var_24_44) and arg_21_1.var_.characterEffect1074ui_story == nil then
				arg_21_1.var_.characterEffect1074ui_story = var_24_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_46 = 0.200000002980232

			if var_24_45 <= arg_21_1.time_ and arg_21_1.time_ < var_24_45 + var_24_46 and not isNil(var_24_44) then
				local var_24_47 = (arg_21_1.time_ - var_24_45) / var_24_46

				if arg_21_1.var_.characterEffect1074ui_story and not isNil(var_24_44) then
					arg_21_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_45 + var_24_46 and arg_21_1.time_ < var_24_45 + var_24_46 + arg_24_0 and not isNil(var_24_44) and arg_21_1.var_.characterEffect1074ui_story then
				arg_21_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_24_48 = 0

			if var_24_48 < arg_21_1.time_ and arg_21_1.time_ <= var_24_48 + arg_24_0 then
				arg_21_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_24_49 = 0

			if var_24_49 < arg_21_1.time_ and arg_21_1.time_ <= var_24_49 + arg_24_0 then
				arg_21_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_50 = 0
			local var_24_51 = 0.125

			if var_24_50 < arg_21_1.time_ and arg_21_1.time_ <= var_24_50 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_52 = arg_21_1:FormatText(StoryNameCfg[410].name)

				arg_21_1.leftNameTxt_.text = var_24_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_53 = arg_21_1:GetWordFromCfg(222091005)
				local var_24_54 = arg_21_1:FormatText(var_24_53.content)

				arg_21_1.text_.text = var_24_54

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_55 = 5
				local var_24_56 = utf8.len(var_24_54)
				local var_24_57 = var_24_55 <= 0 and var_24_51 or var_24_51 * (var_24_56 / var_24_55)

				if var_24_57 > 0 and var_24_51 < var_24_57 then
					arg_21_1.talkMaxDuration = var_24_57

					if var_24_57 + var_24_50 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_57 + var_24_50
					end
				end

				arg_21_1.text_.text = var_24_54
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091005", "story_v_out_222091.awb") ~= 0 then
					local var_24_58 = manager.audio:GetVoiceLength("story_v_out_222091", "222091005", "story_v_out_222091.awb") / 1000

					if var_24_58 + var_24_50 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_58 + var_24_50
					end

					if var_24_53.prefab_name ~= "" and arg_21_1.actors_[var_24_53.prefab_name] ~= nil then
						local var_24_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_53.prefab_name].transform, "story_v_out_222091", "222091005", "story_v_out_222091.awb")

						arg_21_1:RecordAudio("222091005", var_24_59)
						arg_21_1:RecordAudio("222091005", var_24_59)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_222091", "222091005", "story_v_out_222091.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_222091", "222091005", "story_v_out_222091.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_60 = math.max(var_24_51, arg_21_1.talkMaxDuration)

			if var_24_50 <= arg_21_1.time_ and arg_21_1.time_ < var_24_50 + var_24_60 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_50) / var_24_60

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_50 + var_24_60 and arg_21_1.time_ < var_24_50 + var_24_60 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222091006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 222091006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play222091007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1074ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1074ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1074ui_story, var_28_4, var_28_3)

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

			local var_28_9 = arg_25_1.actors_["1074ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1074ui_story == nil then
				arg_25_1.var_.characterEffect1074ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect1074ui_story and not isNil(var_28_9) then
					local var_28_13 = Mathf.Lerp(0, 0.5, var_28_12)

					arg_25_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1074ui_story.fillRatio = var_28_13
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1074ui_story then
				local var_28_14 = 0.5

				arg_25_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1074ui_story.fillRatio = var_28_14
			end

			local var_28_15 = 0
			local var_28_16 = 0.8

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_17 = arg_25_1:GetWordFromCfg(222091006)
				local var_28_18 = arg_25_1:FormatText(var_28_17.content)

				arg_25_1.text_.text = var_28_18

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_19 = 32
				local var_28_20 = utf8.len(var_28_18)
				local var_28_21 = var_28_19 <= 0 and var_28_16 or var_28_16 * (var_28_20 / var_28_19)

				if var_28_21 > 0 and var_28_16 < var_28_21 then
					arg_25_1.talkMaxDuration = var_28_21

					if var_28_21 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_21 + var_28_15
					end
				end

				arg_25_1.text_.text = var_28_18
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_22 = math.max(var_28_16, arg_25_1.talkMaxDuration)

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_22 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_15) / var_28_22

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_15 + var_28_22 and arg_25_1.time_ < var_28_15 + var_28_22 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222091007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 222091007
		arg_29_1.duration_ = 7.67

		local var_29_0 = {
			ja = 7.666,
			ko = 6.6,
			zh = 6.633
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
				arg_29_0:Play222091008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1074ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1074ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1074ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["1074ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1074ui_story == nil then
				arg_29_1.var_.characterEffect1074ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect1074ui_story and not isNil(var_32_9) then
					arg_29_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1074ui_story then
				arg_29_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_32_13 = 0

			if var_32_13 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 then
				arg_29_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_32_14 = 0

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
				arg_29_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_15 = 0
			local var_32_16 = 0.575

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_17 = arg_29_1:FormatText(StoryNameCfg[410].name)

				arg_29_1.leftNameTxt_.text = var_32_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_18 = arg_29_1:GetWordFromCfg(222091007)
				local var_32_19 = arg_29_1:FormatText(var_32_18.content)

				arg_29_1.text_.text = var_32_19

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_20 = 23
				local var_32_21 = utf8.len(var_32_19)
				local var_32_22 = var_32_20 <= 0 and var_32_16 or var_32_16 * (var_32_21 / var_32_20)

				if var_32_22 > 0 and var_32_16 < var_32_22 then
					arg_29_1.talkMaxDuration = var_32_22

					if var_32_22 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_22 + var_32_15
					end
				end

				arg_29_1.text_.text = var_32_19
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091007", "story_v_out_222091.awb") ~= 0 then
					local var_32_23 = manager.audio:GetVoiceLength("story_v_out_222091", "222091007", "story_v_out_222091.awb") / 1000

					if var_32_23 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_15
					end

					if var_32_18.prefab_name ~= "" and arg_29_1.actors_[var_32_18.prefab_name] ~= nil then
						local var_32_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_18.prefab_name].transform, "story_v_out_222091", "222091007", "story_v_out_222091.awb")

						arg_29_1:RecordAudio("222091007", var_32_24)
						arg_29_1:RecordAudio("222091007", var_32_24)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_222091", "222091007", "story_v_out_222091.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_222091", "222091007", "story_v_out_222091.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_25 = math.max(var_32_16, arg_29_1.talkMaxDuration)

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_25 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_15) / var_32_25

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_15 + var_32_25 and arg_29_1.time_ < var_32_15 + var_32_25 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222091008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 222091008
		arg_33_1.duration_ = 4.37

		local var_33_0 = {
			ja = 4.366,
			ko = 2.066,
			zh = 2.066
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
				arg_33_0:Play222091009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10039ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10039ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0.7, -0.8, -6.2)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10039ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["10039ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect10039ui_story == nil then
				arg_33_1.var_.characterEffect10039ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect10039ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect10039ui_story then
				arg_33_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_15 = arg_33_1.actors_["1074ui_story"]
			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.characterEffect1074ui_story == nil then
				arg_33_1.var_.characterEffect1074ui_story = var_36_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_17 = 0.200000002980232

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 and not isNil(var_36_15) then
				local var_36_18 = (arg_33_1.time_ - var_36_16) / var_36_17

				if arg_33_1.var_.characterEffect1074ui_story and not isNil(var_36_15) then
					local var_36_19 = Mathf.Lerp(0, 0.5, var_36_18)

					arg_33_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1074ui_story.fillRatio = var_36_19
				end
			end

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.characterEffect1074ui_story then
				local var_36_20 = 0.5

				arg_33_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1074ui_story.fillRatio = var_36_20
			end

			local var_36_21 = 0
			local var_36_22 = 0.125

			if var_36_21 < arg_33_1.time_ and arg_33_1.time_ <= var_36_21 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_23 = arg_33_1:FormatText(StoryNameCfg[472].name)

				arg_33_1.leftNameTxt_.text = var_36_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_24 = arg_33_1:GetWordFromCfg(222091008)
				local var_36_25 = arg_33_1:FormatText(var_36_24.content)

				arg_33_1.text_.text = var_36_25

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_26 = 5
				local var_36_27 = utf8.len(var_36_25)
				local var_36_28 = var_36_26 <= 0 and var_36_22 or var_36_22 * (var_36_27 / var_36_26)

				if var_36_28 > 0 and var_36_22 < var_36_28 then
					arg_33_1.talkMaxDuration = var_36_28

					if var_36_28 + var_36_21 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_28 + var_36_21
					end
				end

				arg_33_1.text_.text = var_36_25
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091008", "story_v_out_222091.awb") ~= 0 then
					local var_36_29 = manager.audio:GetVoiceLength("story_v_out_222091", "222091008", "story_v_out_222091.awb") / 1000

					if var_36_29 + var_36_21 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_29 + var_36_21
					end

					if var_36_24.prefab_name ~= "" and arg_33_1.actors_[var_36_24.prefab_name] ~= nil then
						local var_36_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_24.prefab_name].transform, "story_v_out_222091", "222091008", "story_v_out_222091.awb")

						arg_33_1:RecordAudio("222091008", var_36_30)
						arg_33_1:RecordAudio("222091008", var_36_30)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_222091", "222091008", "story_v_out_222091.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_222091", "222091008", "story_v_out_222091.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_31 = math.max(var_36_22, arg_33_1.talkMaxDuration)

			if var_36_21 <= arg_33_1.time_ and arg_33_1.time_ < var_36_21 + var_36_31 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_21) / var_36_31

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_21 + var_36_31 and arg_33_1.time_ < var_36_21 + var_36_31 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play222091009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 222091009
		arg_37_1.duration_ = 10.03

		local var_37_0 = {
			ja = 10.033,
			ko = 4.466,
			zh = 4.466
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
				arg_37_0:Play222091010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1074ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1074ui_story == nil then
				arg_37_1.var_.characterEffect1074ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1074ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1074ui_story then
				arg_37_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_40_4 = 0

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_6 = arg_37_1.actors_["10039ui_story"]
			local var_40_7 = 0

			if var_40_7 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 and not isNil(var_40_6) and arg_37_1.var_.characterEffect10039ui_story == nil then
				arg_37_1.var_.characterEffect10039ui_story = var_40_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_8 = 0.200000002980232

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_8 and not isNil(var_40_6) then
				local var_40_9 = (arg_37_1.time_ - var_40_7) / var_40_8

				if arg_37_1.var_.characterEffect10039ui_story and not isNil(var_40_6) then
					local var_40_10 = Mathf.Lerp(0, 0.5, var_40_9)

					arg_37_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10039ui_story.fillRatio = var_40_10
				end
			end

			if arg_37_1.time_ >= var_40_7 + var_40_8 and arg_37_1.time_ < var_40_7 + var_40_8 + arg_40_0 and not isNil(var_40_6) and arg_37_1.var_.characterEffect10039ui_story then
				local var_40_11 = 0.5

				arg_37_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10039ui_story.fillRatio = var_40_11
			end

			local var_40_12 = 0
			local var_40_13 = 0.3

			if var_40_12 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_14 = arg_37_1:FormatText(StoryNameCfg[410].name)

				arg_37_1.leftNameTxt_.text = var_40_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_15 = arg_37_1:GetWordFromCfg(222091009)
				local var_40_16 = arg_37_1:FormatText(var_40_15.content)

				arg_37_1.text_.text = var_40_16

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_17 = 12
				local var_40_18 = utf8.len(var_40_16)
				local var_40_19 = var_40_17 <= 0 and var_40_13 or var_40_13 * (var_40_18 / var_40_17)

				if var_40_19 > 0 and var_40_13 < var_40_19 then
					arg_37_1.talkMaxDuration = var_40_19

					if var_40_19 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_12
					end
				end

				arg_37_1.text_.text = var_40_16
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091009", "story_v_out_222091.awb") ~= 0 then
					local var_40_20 = manager.audio:GetVoiceLength("story_v_out_222091", "222091009", "story_v_out_222091.awb") / 1000

					if var_40_20 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_20 + var_40_12
					end

					if var_40_15.prefab_name ~= "" and arg_37_1.actors_[var_40_15.prefab_name] ~= nil then
						local var_40_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_15.prefab_name].transform, "story_v_out_222091", "222091009", "story_v_out_222091.awb")

						arg_37_1:RecordAudio("222091009", var_40_21)
						arg_37_1:RecordAudio("222091009", var_40_21)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_222091", "222091009", "story_v_out_222091.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_222091", "222091009", "story_v_out_222091.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_22 = math.max(var_40_13, arg_37_1.talkMaxDuration)

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_22 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_12) / var_40_22

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_12 + var_40_22 and arg_37_1.time_ < var_40_12 + var_40_22 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play222091010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 222091010
		arg_41_1.duration_ = 15.1

		local var_41_0 = {
			ja = 15.1,
			ko = 7.766,
			zh = 7.766
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
				arg_41_0:Play222091011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10039ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10039ui_story == nil then
				arg_41_1.var_.characterEffect10039ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect10039ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10039ui_story then
				arg_41_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action5_1")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_44_6 = arg_41_1.actors_["1074ui_story"]
			local var_44_7 = 0

			if var_44_7 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1074ui_story == nil then
				arg_41_1.var_.characterEffect1074ui_story = var_44_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_8 = 0.200000002980232

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_8 and not isNil(var_44_6) then
				local var_44_9 = (arg_41_1.time_ - var_44_7) / var_44_8

				if arg_41_1.var_.characterEffect1074ui_story and not isNil(var_44_6) then
					local var_44_10 = Mathf.Lerp(0, 0.5, var_44_9)

					arg_41_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1074ui_story.fillRatio = var_44_10
				end
			end

			if arg_41_1.time_ >= var_44_7 + var_44_8 and arg_41_1.time_ < var_44_7 + var_44_8 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1074ui_story then
				local var_44_11 = 0.5

				arg_41_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1074ui_story.fillRatio = var_44_11
			end

			local var_44_12 = 0
			local var_44_13 = 0.675

			if var_44_12 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_14 = arg_41_1:FormatText(StoryNameCfg[472].name)

				arg_41_1.leftNameTxt_.text = var_44_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_15 = arg_41_1:GetWordFromCfg(222091010)
				local var_44_16 = arg_41_1:FormatText(var_44_15.content)

				arg_41_1.text_.text = var_44_16

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_17 = 27
				local var_44_18 = utf8.len(var_44_16)
				local var_44_19 = var_44_17 <= 0 and var_44_13 or var_44_13 * (var_44_18 / var_44_17)

				if var_44_19 > 0 and var_44_13 < var_44_19 then
					arg_41_1.talkMaxDuration = var_44_19

					if var_44_19 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_12
					end
				end

				arg_41_1.text_.text = var_44_16
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091010", "story_v_out_222091.awb") ~= 0 then
					local var_44_20 = manager.audio:GetVoiceLength("story_v_out_222091", "222091010", "story_v_out_222091.awb") / 1000

					if var_44_20 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_20 + var_44_12
					end

					if var_44_15.prefab_name ~= "" and arg_41_1.actors_[var_44_15.prefab_name] ~= nil then
						local var_44_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_15.prefab_name].transform, "story_v_out_222091", "222091010", "story_v_out_222091.awb")

						arg_41_1:RecordAudio("222091010", var_44_21)
						arg_41_1:RecordAudio("222091010", var_44_21)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_222091", "222091010", "story_v_out_222091.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_222091", "222091010", "story_v_out_222091.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_22 = math.max(var_44_13, arg_41_1.talkMaxDuration)

			if var_44_12 <= arg_41_1.time_ and arg_41_1.time_ < var_44_12 + var_44_22 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_12) / var_44_22

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_12 + var_44_22 and arg_41_1.time_ < var_44_12 + var_44_22 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play222091011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 222091011
		arg_45_1.duration_ = 5.57

		local var_45_0 = {
			ja = 5.566,
			ko = 4.066,
			zh = 4.066
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
				arg_45_0:Play222091012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_48_1 = 0
			local var_48_2 = 0.375

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_3 = arg_45_1:FormatText(StoryNameCfg[472].name)

				arg_45_1.leftNameTxt_.text = var_48_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:GetWordFromCfg(222091011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 15
				local var_48_7 = utf8.len(var_48_5)
				local var_48_8 = var_48_6 <= 0 and var_48_2 or var_48_2 * (var_48_7 / var_48_6)

				if var_48_8 > 0 and var_48_2 < var_48_8 then
					arg_45_1.talkMaxDuration = var_48_8

					if var_48_8 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091011", "story_v_out_222091.awb") ~= 0 then
					local var_48_9 = manager.audio:GetVoiceLength("story_v_out_222091", "222091011", "story_v_out_222091.awb") / 1000

					if var_48_9 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_1
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_222091", "222091011", "story_v_out_222091.awb")

						arg_45_1:RecordAudio("222091011", var_48_10)
						arg_45_1:RecordAudio("222091011", var_48_10)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_222091", "222091011", "story_v_out_222091.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_222091", "222091011", "story_v_out_222091.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_11 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_11 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_11

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_11 and arg_45_1.time_ < var_48_1 + var_48_11 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play222091012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 222091012
		arg_49_1.duration_ = 12.47

		local var_49_0 = {
			ja = 12.466,
			ko = 11.6,
			zh = 11.633
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
				arg_49_0:Play222091013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 1.075

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[472].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(222091012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091012", "story_v_out_222091.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_222091", "222091012", "story_v_out_222091.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_222091", "222091012", "story_v_out_222091.awb")

						arg_49_1:RecordAudio("222091012", var_52_9)
						arg_49_1:RecordAudio("222091012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_222091", "222091012", "story_v_out_222091.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_222091", "222091012", "story_v_out_222091.awb")
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
	Play222091013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 222091013
		arg_53_1.duration_ = 14.7

		local var_53_0 = {
			ja = 14.7,
			ko = 10.533,
			zh = 10.533
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
				arg_53_0:Play222091014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.975

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[472].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(222091013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 39
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091013", "story_v_out_222091.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_222091", "222091013", "story_v_out_222091.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_222091", "222091013", "story_v_out_222091.awb")

						arg_53_1:RecordAudio("222091013", var_56_9)
						arg_53_1:RecordAudio("222091013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_222091", "222091013", "story_v_out_222091.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_222091", "222091013", "story_v_out_222091.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play222091014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 222091014
		arg_57_1.duration_ = 17.2

		local var_57_0 = {
			ja = 17.2,
			ko = 9.233,
			zh = 9.233
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
				arg_57_0:Play222091015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action5_2")
			end

			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_60_2 = 0
			local var_60_3 = 0.925

			if var_60_2 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_4 = arg_57_1:FormatText(StoryNameCfg[472].name)

				arg_57_1.leftNameTxt_.text = var_60_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_5 = arg_57_1:GetWordFromCfg(222091014)
				local var_60_6 = arg_57_1:FormatText(var_60_5.content)

				arg_57_1.text_.text = var_60_6

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 37
				local var_60_8 = utf8.len(var_60_6)
				local var_60_9 = var_60_7 <= 0 and var_60_3 or var_60_3 * (var_60_8 / var_60_7)

				if var_60_9 > 0 and var_60_3 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_6
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091014", "story_v_out_222091.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_222091", "222091014", "story_v_out_222091.awb") / 1000

					if var_60_10 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_2
					end

					if var_60_5.prefab_name ~= "" and arg_57_1.actors_[var_60_5.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_5.prefab_name].transform, "story_v_out_222091", "222091014", "story_v_out_222091.awb")

						arg_57_1:RecordAudio("222091014", var_60_11)
						arg_57_1:RecordAudio("222091014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_222091", "222091014", "story_v_out_222091.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_222091", "222091014", "story_v_out_222091.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_12 and arg_57_1.time_ < var_60_2 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play222091015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 222091015
		arg_61_1.duration_ = 5.97

		local var_61_0 = {
			ja = 5.966,
			ko = 3.833,
			zh = 3.833
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
				arg_61_0:Play222091016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1074ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1074ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0, 100, 0)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1074ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, 100, 0)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["1074ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1074ui_story == nil then
				arg_61_1.var_.characterEffect1074ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect1074ui_story and not isNil(var_64_9) then
					local var_64_13 = Mathf.Lerp(0, 0.5, var_64_12)

					arg_61_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1074ui_story.fillRatio = var_64_13
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1074ui_story then
				local var_64_14 = 0.5

				arg_61_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1074ui_story.fillRatio = var_64_14
			end

			local var_64_15 = arg_61_1.actors_["1070ui_story"].transform
			local var_64_16 = 0

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.var_.moveOldPos1070ui_story = var_64_15.localPosition
			end

			local var_64_17 = 0.001

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_17 then
				local var_64_18 = (arg_61_1.time_ - var_64_16) / var_64_17
				local var_64_19 = Vector3.New(-0.7, -0.95, -6.05)

				var_64_15.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1070ui_story, var_64_19, var_64_18)

				local var_64_20 = manager.ui.mainCamera.transform.position - var_64_15.position

				var_64_15.forward = Vector3.New(var_64_20.x, var_64_20.y, var_64_20.z)

				local var_64_21 = var_64_15.localEulerAngles

				var_64_21.z = 0
				var_64_21.x = 0
				var_64_15.localEulerAngles = var_64_21
			end

			if arg_61_1.time_ >= var_64_16 + var_64_17 and arg_61_1.time_ < var_64_16 + var_64_17 + arg_64_0 then
				var_64_15.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_64_22 = manager.ui.mainCamera.transform.position - var_64_15.position

				var_64_15.forward = Vector3.New(var_64_22.x, var_64_22.y, var_64_22.z)

				local var_64_23 = var_64_15.localEulerAngles

				var_64_23.z = 0
				var_64_23.x = 0
				var_64_15.localEulerAngles = var_64_23
			end

			local var_64_24 = arg_61_1.actors_["1070ui_story"]
			local var_64_25 = 0

			if var_64_25 < arg_61_1.time_ and arg_61_1.time_ <= var_64_25 + arg_64_0 and not isNil(var_64_24) and arg_61_1.var_.characterEffect1070ui_story == nil then
				arg_61_1.var_.characterEffect1070ui_story = var_64_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_26 = 0.200000002980232

			if var_64_25 <= arg_61_1.time_ and arg_61_1.time_ < var_64_25 + var_64_26 and not isNil(var_64_24) then
				local var_64_27 = (arg_61_1.time_ - var_64_25) / var_64_26

				if arg_61_1.var_.characterEffect1070ui_story and not isNil(var_64_24) then
					arg_61_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_25 + var_64_26 and arg_61_1.time_ < var_64_25 + var_64_26 + arg_64_0 and not isNil(var_64_24) and arg_61_1.var_.characterEffect1070ui_story then
				arg_61_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_64_28 = 0

			if var_64_28 < arg_61_1.time_ and arg_61_1.time_ <= var_64_28 + arg_64_0 then
				arg_61_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_64_29 = 0

			if var_64_29 < arg_61_1.time_ and arg_61_1.time_ <= var_64_29 + arg_64_0 then
				arg_61_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_64_30 = arg_61_1.actors_["10039ui_story"]
			local var_64_31 = 0

			if var_64_31 < arg_61_1.time_ and arg_61_1.time_ <= var_64_31 + arg_64_0 and not isNil(var_64_30) and arg_61_1.var_.characterEffect10039ui_story == nil then
				arg_61_1.var_.characterEffect10039ui_story = var_64_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_32 = 0.200000002980232

			if var_64_31 <= arg_61_1.time_ and arg_61_1.time_ < var_64_31 + var_64_32 and not isNil(var_64_30) then
				local var_64_33 = (arg_61_1.time_ - var_64_31) / var_64_32

				if arg_61_1.var_.characterEffect10039ui_story and not isNil(var_64_30) then
					local var_64_34 = Mathf.Lerp(0, 0.5, var_64_33)

					arg_61_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10039ui_story.fillRatio = var_64_34
				end
			end

			if arg_61_1.time_ >= var_64_31 + var_64_32 and arg_61_1.time_ < var_64_31 + var_64_32 + arg_64_0 and not isNil(var_64_30) and arg_61_1.var_.characterEffect10039ui_story then
				local var_64_35 = 0.5

				arg_61_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10039ui_story.fillRatio = var_64_35
			end

			local var_64_36 = 0
			local var_64_37 = 0.35

			if var_64_36 < arg_61_1.time_ and arg_61_1.time_ <= var_64_36 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_38 = arg_61_1:FormatText(StoryNameCfg[318].name)

				arg_61_1.leftNameTxt_.text = var_64_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_39 = arg_61_1:GetWordFromCfg(222091015)
				local var_64_40 = arg_61_1:FormatText(var_64_39.content)

				arg_61_1.text_.text = var_64_40

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_41 = 14
				local var_64_42 = utf8.len(var_64_40)
				local var_64_43 = var_64_41 <= 0 and var_64_37 or var_64_37 * (var_64_42 / var_64_41)

				if var_64_43 > 0 and var_64_37 < var_64_43 then
					arg_61_1.talkMaxDuration = var_64_43

					if var_64_43 + var_64_36 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_43 + var_64_36
					end
				end

				arg_61_1.text_.text = var_64_40
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091015", "story_v_out_222091.awb") ~= 0 then
					local var_64_44 = manager.audio:GetVoiceLength("story_v_out_222091", "222091015", "story_v_out_222091.awb") / 1000

					if var_64_44 + var_64_36 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_44 + var_64_36
					end

					if var_64_39.prefab_name ~= "" and arg_61_1.actors_[var_64_39.prefab_name] ~= nil then
						local var_64_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_39.prefab_name].transform, "story_v_out_222091", "222091015", "story_v_out_222091.awb")

						arg_61_1:RecordAudio("222091015", var_64_45)
						arg_61_1:RecordAudio("222091015", var_64_45)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_222091", "222091015", "story_v_out_222091.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_222091", "222091015", "story_v_out_222091.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_46 = math.max(var_64_37, arg_61_1.talkMaxDuration)

			if var_64_36 <= arg_61_1.time_ and arg_61_1.time_ < var_64_36 + var_64_46 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_36) / var_64_46

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_36 + var_64_46 and arg_61_1.time_ < var_64_36 + var_64_46 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play222091016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 222091016
		arg_65_1.duration_ = 15.7

		local var_65_0 = {
			ja = 15.7,
			ko = 8.133,
			zh = 8.133
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
				arg_65_0:Play222091017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10039ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10039ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0, 100, 0)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10039ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, 100, 0)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["10039ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect10039ui_story == nil then
				arg_65_1.var_.characterEffect10039ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect10039ui_story and not isNil(var_68_9) then
					local var_68_13 = Mathf.Lerp(0, 0.5, var_68_12)

					arg_65_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10039ui_story.fillRatio = var_68_13
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect10039ui_story then
				local var_68_14 = 0.5

				arg_65_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10039ui_story.fillRatio = var_68_14
			end

			local var_68_15 = arg_65_1.actors_["1074ui_story"].transform
			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.var_.moveOldPos1074ui_story = var_68_15.localPosition
			end

			local var_68_17 = 0.001

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17
				local var_68_19 = Vector3.New(0.7, -1.055, -6.12)

				var_68_15.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1074ui_story, var_68_19, var_68_18)

				local var_68_20 = manager.ui.mainCamera.transform.position - var_68_15.position

				var_68_15.forward = Vector3.New(var_68_20.x, var_68_20.y, var_68_20.z)

				local var_68_21 = var_68_15.localEulerAngles

				var_68_21.z = 0
				var_68_21.x = 0
				var_68_15.localEulerAngles = var_68_21
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 then
				var_68_15.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_68_22 = manager.ui.mainCamera.transform.position - var_68_15.position

				var_68_15.forward = Vector3.New(var_68_22.x, var_68_22.y, var_68_22.z)

				local var_68_23 = var_68_15.localEulerAngles

				var_68_23.z = 0
				var_68_23.x = 0
				var_68_15.localEulerAngles = var_68_23
			end

			local var_68_24 = arg_65_1.actors_["1074ui_story"]
			local var_68_25 = 0

			if var_68_25 < arg_65_1.time_ and arg_65_1.time_ <= var_68_25 + arg_68_0 and not isNil(var_68_24) and arg_65_1.var_.characterEffect1074ui_story == nil then
				arg_65_1.var_.characterEffect1074ui_story = var_68_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_26 = 0.200000002980232

			if var_68_25 <= arg_65_1.time_ and arg_65_1.time_ < var_68_25 + var_68_26 and not isNil(var_68_24) then
				local var_68_27 = (arg_65_1.time_ - var_68_25) / var_68_26

				if arg_65_1.var_.characterEffect1074ui_story and not isNil(var_68_24) then
					arg_65_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_25 + var_68_26 and arg_65_1.time_ < var_68_25 + var_68_26 + arg_68_0 and not isNil(var_68_24) and arg_65_1.var_.characterEffect1074ui_story then
				arg_65_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_68_28 = 0

			if var_68_28 < arg_65_1.time_ and arg_65_1.time_ <= var_68_28 + arg_68_0 then
				arg_65_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_68_29 = 0

			if var_68_29 < arg_65_1.time_ and arg_65_1.time_ <= var_68_29 + arg_68_0 then
				arg_65_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_68_30 = arg_65_1.actors_["1070ui_story"]
			local var_68_31 = 0

			if var_68_31 < arg_65_1.time_ and arg_65_1.time_ <= var_68_31 + arg_68_0 and not isNil(var_68_30) and arg_65_1.var_.characterEffect1070ui_story == nil then
				arg_65_1.var_.characterEffect1070ui_story = var_68_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_32 = 0.200000002980232

			if var_68_31 <= arg_65_1.time_ and arg_65_1.time_ < var_68_31 + var_68_32 and not isNil(var_68_30) then
				local var_68_33 = (arg_65_1.time_ - var_68_31) / var_68_32

				if arg_65_1.var_.characterEffect1070ui_story and not isNil(var_68_30) then
					local var_68_34 = Mathf.Lerp(0, 0.5, var_68_33)

					arg_65_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1070ui_story.fillRatio = var_68_34
				end
			end

			if arg_65_1.time_ >= var_68_31 + var_68_32 and arg_65_1.time_ < var_68_31 + var_68_32 + arg_68_0 and not isNil(var_68_30) and arg_65_1.var_.characterEffect1070ui_story then
				local var_68_35 = 0.5

				arg_65_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1070ui_story.fillRatio = var_68_35
			end

			local var_68_36 = 0
			local var_68_37 = 0.9

			if var_68_36 < arg_65_1.time_ and arg_65_1.time_ <= var_68_36 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_38 = arg_65_1:FormatText(StoryNameCfg[410].name)

				arg_65_1.leftNameTxt_.text = var_68_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_39 = arg_65_1:GetWordFromCfg(222091016)
				local var_68_40 = arg_65_1:FormatText(var_68_39.content)

				arg_65_1.text_.text = var_68_40

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_41 = 36
				local var_68_42 = utf8.len(var_68_40)
				local var_68_43 = var_68_41 <= 0 and var_68_37 or var_68_37 * (var_68_42 / var_68_41)

				if var_68_43 > 0 and var_68_37 < var_68_43 then
					arg_65_1.talkMaxDuration = var_68_43

					if var_68_43 + var_68_36 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_43 + var_68_36
					end
				end

				arg_65_1.text_.text = var_68_40
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091016", "story_v_out_222091.awb") ~= 0 then
					local var_68_44 = manager.audio:GetVoiceLength("story_v_out_222091", "222091016", "story_v_out_222091.awb") / 1000

					if var_68_44 + var_68_36 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_44 + var_68_36
					end

					if var_68_39.prefab_name ~= "" and arg_65_1.actors_[var_68_39.prefab_name] ~= nil then
						local var_68_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_39.prefab_name].transform, "story_v_out_222091", "222091016", "story_v_out_222091.awb")

						arg_65_1:RecordAudio("222091016", var_68_45)
						arg_65_1:RecordAudio("222091016", var_68_45)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_222091", "222091016", "story_v_out_222091.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_222091", "222091016", "story_v_out_222091.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_46 = math.max(var_68_37, arg_65_1.talkMaxDuration)

			if var_68_36 <= arg_65_1.time_ and arg_65_1.time_ < var_68_36 + var_68_46 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_36) / var_68_46

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_36 + var_68_46 and arg_65_1.time_ < var_68_36 + var_68_46 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222091017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 222091017
		arg_69_1.duration_ = 12.4

		local var_69_0 = {
			ja = 12.4,
			ko = 5,
			zh = 5
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
				arg_69_0:Play222091018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1070ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1070ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(0, 100, 0)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1070ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, 100, 0)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = arg_69_1.actors_["1070ui_story"]
			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect1070ui_story == nil then
				arg_69_1.var_.characterEffect1070ui_story = var_72_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_11 = 0.200000002980232

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_11 and not isNil(var_72_9) then
				local var_72_12 = (arg_69_1.time_ - var_72_10) / var_72_11

				if arg_69_1.var_.characterEffect1070ui_story and not isNil(var_72_9) then
					local var_72_13 = Mathf.Lerp(0, 0.5, var_72_12)

					arg_69_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1070ui_story.fillRatio = var_72_13
				end
			end

			if arg_69_1.time_ >= var_72_10 + var_72_11 and arg_69_1.time_ < var_72_10 + var_72_11 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect1070ui_story then
				local var_72_14 = 0.5

				arg_69_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1070ui_story.fillRatio = var_72_14
			end

			local var_72_15 = arg_69_1.actors_["10039ui_story"].transform
			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.var_.moveOldPos10039ui_story = var_72_15.localPosition
			end

			local var_72_17 = 0.001

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_17 then
				local var_72_18 = (arg_69_1.time_ - var_72_16) / var_72_17
				local var_72_19 = Vector3.New(-0.7, -0.8, -6.2)

				var_72_15.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10039ui_story, var_72_19, var_72_18)

				local var_72_20 = manager.ui.mainCamera.transform.position - var_72_15.position

				var_72_15.forward = Vector3.New(var_72_20.x, var_72_20.y, var_72_20.z)

				local var_72_21 = var_72_15.localEulerAngles

				var_72_21.z = 0
				var_72_21.x = 0
				var_72_15.localEulerAngles = var_72_21
			end

			if arg_69_1.time_ >= var_72_16 + var_72_17 and arg_69_1.time_ < var_72_16 + var_72_17 + arg_72_0 then
				var_72_15.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_72_22 = manager.ui.mainCamera.transform.position - var_72_15.position

				var_72_15.forward = Vector3.New(var_72_22.x, var_72_22.y, var_72_22.z)

				local var_72_23 = var_72_15.localEulerAngles

				var_72_23.z = 0
				var_72_23.x = 0
				var_72_15.localEulerAngles = var_72_23
			end

			local var_72_24 = arg_69_1.actors_["10039ui_story"]
			local var_72_25 = 0

			if var_72_25 < arg_69_1.time_ and arg_69_1.time_ <= var_72_25 + arg_72_0 and not isNil(var_72_24) and arg_69_1.var_.characterEffect10039ui_story == nil then
				arg_69_1.var_.characterEffect10039ui_story = var_72_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_26 = 0.200000002980232

			if var_72_25 <= arg_69_1.time_ and arg_69_1.time_ < var_72_25 + var_72_26 and not isNil(var_72_24) then
				local var_72_27 = (arg_69_1.time_ - var_72_25) / var_72_26

				if arg_69_1.var_.characterEffect10039ui_story and not isNil(var_72_24) then
					arg_69_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_25 + var_72_26 and arg_69_1.time_ < var_72_25 + var_72_26 + arg_72_0 and not isNil(var_72_24) and arg_69_1.var_.characterEffect10039ui_story then
				arg_69_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_72_28 = 0

			if var_72_28 < arg_69_1.time_ and arg_69_1.time_ <= var_72_28 + arg_72_0 then
				arg_69_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_72_29 = 0

			if var_72_29 < arg_69_1.time_ and arg_69_1.time_ <= var_72_29 + arg_72_0 then
				arg_69_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_30 = arg_69_1.actors_["1074ui_story"]
			local var_72_31 = 0

			if var_72_31 < arg_69_1.time_ and arg_69_1.time_ <= var_72_31 + arg_72_0 and not isNil(var_72_30) and arg_69_1.var_.characterEffect1074ui_story == nil then
				arg_69_1.var_.characterEffect1074ui_story = var_72_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_32 = 0.200000002980232

			if var_72_31 <= arg_69_1.time_ and arg_69_1.time_ < var_72_31 + var_72_32 and not isNil(var_72_30) then
				local var_72_33 = (arg_69_1.time_ - var_72_31) / var_72_32

				if arg_69_1.var_.characterEffect1074ui_story and not isNil(var_72_30) then
					local var_72_34 = Mathf.Lerp(0, 0.5, var_72_33)

					arg_69_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1074ui_story.fillRatio = var_72_34
				end
			end

			if arg_69_1.time_ >= var_72_31 + var_72_32 and arg_69_1.time_ < var_72_31 + var_72_32 + arg_72_0 and not isNil(var_72_30) and arg_69_1.var_.characterEffect1074ui_story then
				local var_72_35 = 0.5

				arg_69_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1074ui_story.fillRatio = var_72_35
			end

			local var_72_36 = 0
			local var_72_37 = 0.525

			if var_72_36 < arg_69_1.time_ and arg_69_1.time_ <= var_72_36 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_38 = arg_69_1:FormatText(StoryNameCfg[472].name)

				arg_69_1.leftNameTxt_.text = var_72_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_39 = arg_69_1:GetWordFromCfg(222091017)
				local var_72_40 = arg_69_1:FormatText(var_72_39.content)

				arg_69_1.text_.text = var_72_40

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_41 = 21
				local var_72_42 = utf8.len(var_72_40)
				local var_72_43 = var_72_41 <= 0 and var_72_37 or var_72_37 * (var_72_42 / var_72_41)

				if var_72_43 > 0 and var_72_37 < var_72_43 then
					arg_69_1.talkMaxDuration = var_72_43

					if var_72_43 + var_72_36 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_43 + var_72_36
					end
				end

				arg_69_1.text_.text = var_72_40
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091017", "story_v_out_222091.awb") ~= 0 then
					local var_72_44 = manager.audio:GetVoiceLength("story_v_out_222091", "222091017", "story_v_out_222091.awb") / 1000

					if var_72_44 + var_72_36 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_44 + var_72_36
					end

					if var_72_39.prefab_name ~= "" and arg_69_1.actors_[var_72_39.prefab_name] ~= nil then
						local var_72_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_39.prefab_name].transform, "story_v_out_222091", "222091017", "story_v_out_222091.awb")

						arg_69_1:RecordAudio("222091017", var_72_45)
						arg_69_1:RecordAudio("222091017", var_72_45)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_222091", "222091017", "story_v_out_222091.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_222091", "222091017", "story_v_out_222091.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_46 = math.max(var_72_37, arg_69_1.talkMaxDuration)

			if var_72_36 <= arg_69_1.time_ and arg_69_1.time_ < var_72_36 + var_72_46 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_36) / var_72_46

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_36 + var_72_46 and arg_69_1.time_ < var_72_36 + var_72_46 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play222091018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 222091018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play222091019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10039ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10039ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0, 100, 0)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10039ui_story, var_76_4, var_76_3)

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

			local var_76_9 = arg_73_1.actors_["10039ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect10039ui_story == nil then
				arg_73_1.var_.characterEffect10039ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 and not isNil(var_76_9) then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect10039ui_story and not isNil(var_76_9) then
					local var_76_13 = Mathf.Lerp(0, 0.5, var_76_12)

					arg_73_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10039ui_story.fillRatio = var_76_13
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect10039ui_story then
				local var_76_14 = 0.5

				arg_73_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10039ui_story.fillRatio = var_76_14
			end

			local var_76_15 = arg_73_1.actors_["1074ui_story"].transform
			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.var_.moveOldPos1074ui_story = var_76_15.localPosition
			end

			local var_76_17 = 0.001

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_17 then
				local var_76_18 = (arg_73_1.time_ - var_76_16) / var_76_17
				local var_76_19 = Vector3.New(0, 100, 0)

				var_76_15.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1074ui_story, var_76_19, var_76_18)

				local var_76_20 = manager.ui.mainCamera.transform.position - var_76_15.position

				var_76_15.forward = Vector3.New(var_76_20.x, var_76_20.y, var_76_20.z)

				local var_76_21 = var_76_15.localEulerAngles

				var_76_21.z = 0
				var_76_21.x = 0
				var_76_15.localEulerAngles = var_76_21
			end

			if arg_73_1.time_ >= var_76_16 + var_76_17 and arg_73_1.time_ < var_76_16 + var_76_17 + arg_76_0 then
				var_76_15.localPosition = Vector3.New(0, 100, 0)

				local var_76_22 = manager.ui.mainCamera.transform.position - var_76_15.position

				var_76_15.forward = Vector3.New(var_76_22.x, var_76_22.y, var_76_22.z)

				local var_76_23 = var_76_15.localEulerAngles

				var_76_23.z = 0
				var_76_23.x = 0
				var_76_15.localEulerAngles = var_76_23
			end

			local var_76_24 = arg_73_1.actors_["1074ui_story"]
			local var_76_25 = 0

			if var_76_25 < arg_73_1.time_ and arg_73_1.time_ <= var_76_25 + arg_76_0 and not isNil(var_76_24) and arg_73_1.var_.characterEffect1074ui_story == nil then
				arg_73_1.var_.characterEffect1074ui_story = var_76_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_26 = 0.200000002980232

			if var_76_25 <= arg_73_1.time_ and arg_73_1.time_ < var_76_25 + var_76_26 and not isNil(var_76_24) then
				local var_76_27 = (arg_73_1.time_ - var_76_25) / var_76_26

				if arg_73_1.var_.characterEffect1074ui_story and not isNil(var_76_24) then
					local var_76_28 = Mathf.Lerp(0, 0.5, var_76_27)

					arg_73_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1074ui_story.fillRatio = var_76_28
				end
			end

			if arg_73_1.time_ >= var_76_25 + var_76_26 and arg_73_1.time_ < var_76_25 + var_76_26 + arg_76_0 and not isNil(var_76_24) and arg_73_1.var_.characterEffect1074ui_story then
				local var_76_29 = 0.5

				arg_73_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1074ui_story.fillRatio = var_76_29
			end

			local var_76_30 = 0
			local var_76_31 = 1.125

			if var_76_30 < arg_73_1.time_ and arg_73_1.time_ <= var_76_30 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_32 = arg_73_1:GetWordFromCfg(222091018)
				local var_76_33 = arg_73_1:FormatText(var_76_32.content)

				arg_73_1.text_.text = var_76_33

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_34 = 45
				local var_76_35 = utf8.len(var_76_33)
				local var_76_36 = var_76_34 <= 0 and var_76_31 or var_76_31 * (var_76_35 / var_76_34)

				if var_76_36 > 0 and var_76_31 < var_76_36 then
					arg_73_1.talkMaxDuration = var_76_36

					if var_76_36 + var_76_30 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_36 + var_76_30
					end
				end

				arg_73_1.text_.text = var_76_33
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_37 = math.max(var_76_31, arg_73_1.talkMaxDuration)

			if var_76_30 <= arg_73_1.time_ and arg_73_1.time_ < var_76_30 + var_76_37 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_30) / var_76_37

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_30 + var_76_37 and arg_73_1.time_ < var_76_30 + var_76_37 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222091019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 222091019
		arg_77_1.duration_ = 4.23

		local var_77_0 = {
			ja = 4.233,
			ko = 2.866,
			zh = 2.866
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
				arg_77_0:Play222091020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1070ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1070ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1070ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["1070ui_story"]
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect1070ui_story == nil then
				arg_77_1.var_.characterEffect1070ui_story = var_80_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_11 = 0.200000002980232

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 and not isNil(var_80_9) then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11

				if arg_77_1.var_.characterEffect1070ui_story and not isNil(var_80_9) then
					arg_77_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect1070ui_story then
				arg_77_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_80_13 = 0

			if var_80_13 < arg_77_1.time_ and arg_77_1.time_ <= var_80_13 + arg_80_0 then
				arg_77_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_80_14 = 0

			if var_80_14 < arg_77_1.time_ and arg_77_1.time_ <= var_80_14 + arg_80_0 then
				arg_77_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_15 = 0
			local var_80_16 = 0.4

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_17 = arg_77_1:FormatText(StoryNameCfg[318].name)

				arg_77_1.leftNameTxt_.text = var_80_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_18 = arg_77_1:GetWordFromCfg(222091019)
				local var_80_19 = arg_77_1:FormatText(var_80_18.content)

				arg_77_1.text_.text = var_80_19

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_20 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091019", "story_v_out_222091.awb") ~= 0 then
					local var_80_23 = manager.audio:GetVoiceLength("story_v_out_222091", "222091019", "story_v_out_222091.awb") / 1000

					if var_80_23 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_23 + var_80_15
					end

					if var_80_18.prefab_name ~= "" and arg_77_1.actors_[var_80_18.prefab_name] ~= nil then
						local var_80_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_18.prefab_name].transform, "story_v_out_222091", "222091019", "story_v_out_222091.awb")

						arg_77_1:RecordAudio("222091019", var_80_24)
						arg_77_1:RecordAudio("222091019", var_80_24)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_222091", "222091019", "story_v_out_222091.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_222091", "222091019", "story_v_out_222091.awb")
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
				actorName = "1070ui_story",
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
	Play222091020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 222091020
		arg_81_1.duration_ = 13.93

		local var_81_0 = {
			ja = 13.933,
			ko = 6.233,
			zh = 6.233
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
				arg_81_0:Play222091021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1074ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1074ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0.7, -1.055, -6.12)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1074ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = arg_81_1.actors_["1074ui_story"]
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect1074ui_story == nil then
				arg_81_1.var_.characterEffect1074ui_story = var_84_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.200000002980232

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 and not isNil(var_84_9) then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11

				if arg_81_1.var_.characterEffect1074ui_story and not isNil(var_84_9) then
					arg_81_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect1074ui_story then
				arg_81_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_84_13 = 0

			if var_84_13 < arg_81_1.time_ and arg_81_1.time_ <= var_84_13 + arg_84_0 then
				arg_81_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_84_14 = 0

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_15 = arg_81_1.actors_["1070ui_story"]
			local var_84_16 = 0

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 and not isNil(var_84_15) and arg_81_1.var_.characterEffect1070ui_story == nil then
				arg_81_1.var_.characterEffect1070ui_story = var_84_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_17 = 0.200000002980232

			if var_84_16 <= arg_81_1.time_ and arg_81_1.time_ < var_84_16 + var_84_17 and not isNil(var_84_15) then
				local var_84_18 = (arg_81_1.time_ - var_84_16) / var_84_17

				if arg_81_1.var_.characterEffect1070ui_story and not isNil(var_84_15) then
					local var_84_19 = Mathf.Lerp(0, 0.5, var_84_18)

					arg_81_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1070ui_story.fillRatio = var_84_19
				end
			end

			if arg_81_1.time_ >= var_84_16 + var_84_17 and arg_81_1.time_ < var_84_16 + var_84_17 + arg_84_0 and not isNil(var_84_15) and arg_81_1.var_.characterEffect1070ui_story then
				local var_84_20 = 0.5

				arg_81_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1070ui_story.fillRatio = var_84_20
			end

			local var_84_21 = 0
			local var_84_22 = 0.75

			if var_84_21 < arg_81_1.time_ and arg_81_1.time_ <= var_84_21 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_23 = arg_81_1:FormatText(StoryNameCfg[410].name)

				arg_81_1.leftNameTxt_.text = var_84_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_24 = arg_81_1:GetWordFromCfg(222091020)
				local var_84_25 = arg_81_1:FormatText(var_84_24.content)

				arg_81_1.text_.text = var_84_25

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_26 = 30
				local var_84_27 = utf8.len(var_84_25)
				local var_84_28 = var_84_26 <= 0 and var_84_22 or var_84_22 * (var_84_27 / var_84_26)

				if var_84_28 > 0 and var_84_22 < var_84_28 then
					arg_81_1.talkMaxDuration = var_84_28

					if var_84_28 + var_84_21 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_28 + var_84_21
					end
				end

				arg_81_1.text_.text = var_84_25
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091020", "story_v_out_222091.awb") ~= 0 then
					local var_84_29 = manager.audio:GetVoiceLength("story_v_out_222091", "222091020", "story_v_out_222091.awb") / 1000

					if var_84_29 + var_84_21 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_29 + var_84_21
					end

					if var_84_24.prefab_name ~= "" and arg_81_1.actors_[var_84_24.prefab_name] ~= nil then
						local var_84_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_24.prefab_name].transform, "story_v_out_222091", "222091020", "story_v_out_222091.awb")

						arg_81_1:RecordAudio("222091020", var_84_30)
						arg_81_1:RecordAudio("222091020", var_84_30)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_222091", "222091020", "story_v_out_222091.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_222091", "222091020", "story_v_out_222091.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_31 = math.max(var_84_22, arg_81_1.talkMaxDuration)

			if var_84_21 <= arg_81_1.time_ and arg_81_1.time_ < var_84_21 + var_84_31 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_21) / var_84_31

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_21 + var_84_31 and arg_81_1.time_ < var_84_21 + var_84_31 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222091021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 222091021
		arg_85_1.duration_ = 13.07

		local var_85_0 = {
			ja = 13.066,
			ko = 12.466,
			zh = 12.466
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
				arg_85_0:Play222091022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1074ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1074ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(0, 100, 0)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1074ui_story, var_88_4, var_88_3)

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

			local var_88_9 = arg_85_1.actors_["1074ui_story"]
			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1074ui_story == nil then
				arg_85_1.var_.characterEffect1074ui_story = var_88_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_11 = 0.200000002980232

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 and not isNil(var_88_9) then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11

				if arg_85_1.var_.characterEffect1074ui_story and not isNil(var_88_9) then
					local var_88_13 = Mathf.Lerp(0, 0.5, var_88_12)

					arg_85_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1074ui_story.fillRatio = var_88_13
				end
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1074ui_story then
				local var_88_14 = 0.5

				arg_85_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1074ui_story.fillRatio = var_88_14
			end

			local var_88_15 = arg_85_1.actors_["1070ui_story"].transform
			local var_88_16 = 0

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				arg_85_1.var_.moveOldPos1070ui_story = var_88_15.localPosition
			end

			local var_88_17 = 0.001

			if var_88_16 <= arg_85_1.time_ and arg_85_1.time_ < var_88_16 + var_88_17 then
				local var_88_18 = (arg_85_1.time_ - var_88_16) / var_88_17
				local var_88_19 = Vector3.New(0, 100, 0)

				var_88_15.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1070ui_story, var_88_19, var_88_18)

				local var_88_20 = manager.ui.mainCamera.transform.position - var_88_15.position

				var_88_15.forward = Vector3.New(var_88_20.x, var_88_20.y, var_88_20.z)

				local var_88_21 = var_88_15.localEulerAngles

				var_88_21.z = 0
				var_88_21.x = 0
				var_88_15.localEulerAngles = var_88_21
			end

			if arg_85_1.time_ >= var_88_16 + var_88_17 and arg_85_1.time_ < var_88_16 + var_88_17 + arg_88_0 then
				var_88_15.localPosition = Vector3.New(0, 100, 0)

				local var_88_22 = manager.ui.mainCamera.transform.position - var_88_15.position

				var_88_15.forward = Vector3.New(var_88_22.x, var_88_22.y, var_88_22.z)

				local var_88_23 = var_88_15.localEulerAngles

				var_88_23.z = 0
				var_88_23.x = 0
				var_88_15.localEulerAngles = var_88_23
			end

			local var_88_24 = arg_85_1.actors_["1070ui_story"]
			local var_88_25 = 0

			if var_88_25 < arg_85_1.time_ and arg_85_1.time_ <= var_88_25 + arg_88_0 and not isNil(var_88_24) and arg_85_1.var_.characterEffect1070ui_story == nil then
				arg_85_1.var_.characterEffect1070ui_story = var_88_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_26 = 0.200000002980232

			if var_88_25 <= arg_85_1.time_ and arg_85_1.time_ < var_88_25 + var_88_26 and not isNil(var_88_24) then
				local var_88_27 = (arg_85_1.time_ - var_88_25) / var_88_26

				if arg_85_1.var_.characterEffect1070ui_story and not isNil(var_88_24) then
					local var_88_28 = Mathf.Lerp(0, 0.5, var_88_27)

					arg_85_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1070ui_story.fillRatio = var_88_28
				end
			end

			if arg_85_1.time_ >= var_88_25 + var_88_26 and arg_85_1.time_ < var_88_25 + var_88_26 + arg_88_0 and not isNil(var_88_24) and arg_85_1.var_.characterEffect1070ui_story then
				local var_88_29 = 0.5

				arg_85_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1070ui_story.fillRatio = var_88_29
			end

			local var_88_30 = arg_85_1.actors_["10039ui_story"].transform
			local var_88_31 = 0

			if var_88_31 < arg_85_1.time_ and arg_85_1.time_ <= var_88_31 + arg_88_0 then
				arg_85_1.var_.moveOldPos10039ui_story = var_88_30.localPosition
			end

			local var_88_32 = 0.001

			if var_88_31 <= arg_85_1.time_ and arg_85_1.time_ < var_88_31 + var_88_32 then
				local var_88_33 = (arg_85_1.time_ - var_88_31) / var_88_32
				local var_88_34 = Vector3.New(0, -0.8, -6.2)

				var_88_30.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10039ui_story, var_88_34, var_88_33)

				local var_88_35 = manager.ui.mainCamera.transform.position - var_88_30.position

				var_88_30.forward = Vector3.New(var_88_35.x, var_88_35.y, var_88_35.z)

				local var_88_36 = var_88_30.localEulerAngles

				var_88_36.z = 0
				var_88_36.x = 0
				var_88_30.localEulerAngles = var_88_36
			end

			if arg_85_1.time_ >= var_88_31 + var_88_32 and arg_85_1.time_ < var_88_31 + var_88_32 + arg_88_0 then
				var_88_30.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_88_37 = manager.ui.mainCamera.transform.position - var_88_30.position

				var_88_30.forward = Vector3.New(var_88_37.x, var_88_37.y, var_88_37.z)

				local var_88_38 = var_88_30.localEulerAngles

				var_88_38.z = 0
				var_88_38.x = 0
				var_88_30.localEulerAngles = var_88_38
			end

			local var_88_39 = arg_85_1.actors_["10039ui_story"]
			local var_88_40 = 0

			if var_88_40 < arg_85_1.time_ and arg_85_1.time_ <= var_88_40 + arg_88_0 and not isNil(var_88_39) and arg_85_1.var_.characterEffect10039ui_story == nil then
				arg_85_1.var_.characterEffect10039ui_story = var_88_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_41 = 0.200000002980232

			if var_88_40 <= arg_85_1.time_ and arg_85_1.time_ < var_88_40 + var_88_41 and not isNil(var_88_39) then
				local var_88_42 = (arg_85_1.time_ - var_88_40) / var_88_41

				if arg_85_1.var_.characterEffect10039ui_story and not isNil(var_88_39) then
					arg_85_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_40 + var_88_41 and arg_85_1.time_ < var_88_40 + var_88_41 + arg_88_0 and not isNil(var_88_39) and arg_85_1.var_.characterEffect10039ui_story then
				arg_85_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_88_43 = 0

			if var_88_43 < arg_85_1.time_ and arg_85_1.time_ <= var_88_43 + arg_88_0 then
				arg_85_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_1")
			end

			local var_88_44 = 0

			if var_88_44 < arg_85_1.time_ and arg_85_1.time_ <= var_88_44 + arg_88_0 then
				arg_85_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_88_45 = 0
			local var_88_46 = 0.975

			if var_88_45 < arg_85_1.time_ and arg_85_1.time_ <= var_88_45 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_47 = arg_85_1:FormatText(StoryNameCfg[472].name)

				arg_85_1.leftNameTxt_.text = var_88_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_48 = arg_85_1:GetWordFromCfg(222091021)
				local var_88_49 = arg_85_1:FormatText(var_88_48.content)

				arg_85_1.text_.text = var_88_49

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_50 = 39
				local var_88_51 = utf8.len(var_88_49)
				local var_88_52 = var_88_50 <= 0 and var_88_46 or var_88_46 * (var_88_51 / var_88_50)

				if var_88_52 > 0 and var_88_46 < var_88_52 then
					arg_85_1.talkMaxDuration = var_88_52

					if var_88_52 + var_88_45 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_52 + var_88_45
					end
				end

				arg_85_1.text_.text = var_88_49
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091021", "story_v_out_222091.awb") ~= 0 then
					local var_88_53 = manager.audio:GetVoiceLength("story_v_out_222091", "222091021", "story_v_out_222091.awb") / 1000

					if var_88_53 + var_88_45 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_53 + var_88_45
					end

					if var_88_48.prefab_name ~= "" and arg_85_1.actors_[var_88_48.prefab_name] ~= nil then
						local var_88_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_48.prefab_name].transform, "story_v_out_222091", "222091021", "story_v_out_222091.awb")

						arg_85_1:RecordAudio("222091021", var_88_54)
						arg_85_1:RecordAudio("222091021", var_88_54)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_222091", "222091021", "story_v_out_222091.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_222091", "222091021", "story_v_out_222091.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_55 = math.max(var_88_46, arg_85_1.talkMaxDuration)

			if var_88_45 <= arg_85_1.time_ and arg_85_1.time_ < var_88_45 + var_88_55 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_45) / var_88_55

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_45 + var_88_55 and arg_85_1.time_ < var_88_45 + var_88_55 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play222091022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 222091022
		arg_89_1.duration_ = 21.1

		local var_89_0 = {
			ja = 21.1,
			ko = 9.7,
			zh = 9.733
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
				arg_89_0:Play222091023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_2")
			end

			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_92_2 = 0
			local var_92_3 = 0.925

			if var_92_2 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_4 = arg_89_1:FormatText(StoryNameCfg[472].name)

				arg_89_1.leftNameTxt_.text = var_92_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_5 = arg_89_1:GetWordFromCfg(222091022)
				local var_92_6 = arg_89_1:FormatText(var_92_5.content)

				arg_89_1.text_.text = var_92_6

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 37
				local var_92_8 = utf8.len(var_92_6)
				local var_92_9 = var_92_7 <= 0 and var_92_3 or var_92_3 * (var_92_8 / var_92_7)

				if var_92_9 > 0 and var_92_3 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_2
					end
				end

				arg_89_1.text_.text = var_92_6
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091022", "story_v_out_222091.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_222091", "222091022", "story_v_out_222091.awb") / 1000

					if var_92_10 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_2
					end

					if var_92_5.prefab_name ~= "" and arg_89_1.actors_[var_92_5.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_5.prefab_name].transform, "story_v_out_222091", "222091022", "story_v_out_222091.awb")

						arg_89_1:RecordAudio("222091022", var_92_11)
						arg_89_1:RecordAudio("222091022", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_222091", "222091022", "story_v_out_222091.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_222091", "222091022", "story_v_out_222091.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_3, arg_89_1.talkMaxDuration)

			if var_92_2 <= arg_89_1.time_ and arg_89_1.time_ < var_92_2 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_2) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_2 + var_92_12 and arg_89_1.time_ < var_92_2 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play222091023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 222091023
		arg_93_1.duration_ = 12.73

		local var_93_0 = {
			ja = 12.733,
			ko = 10.266,
			zh = 10.266
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
				arg_93_0:Play222091024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_96_1 = 0
			local var_96_2 = 1.025

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_3 = arg_93_1:FormatText(StoryNameCfg[472].name)

				arg_93_1.leftNameTxt_.text = var_96_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_4 = arg_93_1:GetWordFromCfg(222091023)
				local var_96_5 = arg_93_1:FormatText(var_96_4.content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_6 = 41
				local var_96_7 = utf8.len(var_96_5)
				local var_96_8 = var_96_6 <= 0 and var_96_2 or var_96_2 * (var_96_7 / var_96_6)

				if var_96_8 > 0 and var_96_2 < var_96_8 then
					arg_93_1.talkMaxDuration = var_96_8

					if var_96_8 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091023", "story_v_out_222091.awb") ~= 0 then
					local var_96_9 = manager.audio:GetVoiceLength("story_v_out_222091", "222091023", "story_v_out_222091.awb") / 1000

					if var_96_9 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_1
					end

					if var_96_4.prefab_name ~= "" and arg_93_1.actors_[var_96_4.prefab_name] ~= nil then
						local var_96_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_4.prefab_name].transform, "story_v_out_222091", "222091023", "story_v_out_222091.awb")

						arg_93_1:RecordAudio("222091023", var_96_10)
						arg_93_1:RecordAudio("222091023", var_96_10)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_222091", "222091023", "story_v_out_222091.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_222091", "222091023", "story_v_out_222091.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_11 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_11 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_11

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_11 and arg_93_1.time_ < var_96_1 + var_96_11 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play222091024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 222091024
		arg_97_1.duration_ = 12.6

		local var_97_0 = {
			ja = 12.6,
			ko = 3.633,
			zh = 3.666
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
				arg_97_0:Play222091025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10039ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10039ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(-0.7, -0.8, -6.2)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10039ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["10039ui_story"]
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect10039ui_story == nil then
				arg_97_1.var_.characterEffect10039ui_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 and not isNil(var_100_9) then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11

				if arg_97_1.var_.characterEffect10039ui_story and not isNil(var_100_9) then
					local var_100_13 = Mathf.Lerp(0, 0.5, var_100_12)

					arg_97_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10039ui_story.fillRatio = var_100_13
				end
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect10039ui_story then
				local var_100_14 = 0.5

				arg_97_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10039ui_story.fillRatio = var_100_14
			end

			local var_100_15 = arg_97_1.actors_["1074ui_story"].transform
			local var_100_16 = 0

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 then
				arg_97_1.var_.moveOldPos1074ui_story = var_100_15.localPosition
			end

			local var_100_17 = 0.001

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_17 then
				local var_100_18 = (arg_97_1.time_ - var_100_16) / var_100_17
				local var_100_19 = Vector3.New(0.7, -1.055, -6.12)

				var_100_15.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1074ui_story, var_100_19, var_100_18)

				local var_100_20 = manager.ui.mainCamera.transform.position - var_100_15.position

				var_100_15.forward = Vector3.New(var_100_20.x, var_100_20.y, var_100_20.z)

				local var_100_21 = var_100_15.localEulerAngles

				var_100_21.z = 0
				var_100_21.x = 0
				var_100_15.localEulerAngles = var_100_21
			end

			if arg_97_1.time_ >= var_100_16 + var_100_17 and arg_97_1.time_ < var_100_16 + var_100_17 + arg_100_0 then
				var_100_15.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_100_22 = manager.ui.mainCamera.transform.position - var_100_15.position

				var_100_15.forward = Vector3.New(var_100_22.x, var_100_22.y, var_100_22.z)

				local var_100_23 = var_100_15.localEulerAngles

				var_100_23.z = 0
				var_100_23.x = 0
				var_100_15.localEulerAngles = var_100_23
			end

			local var_100_24 = arg_97_1.actors_["1074ui_story"]
			local var_100_25 = 0

			if var_100_25 < arg_97_1.time_ and arg_97_1.time_ <= var_100_25 + arg_100_0 and not isNil(var_100_24) and arg_97_1.var_.characterEffect1074ui_story == nil then
				arg_97_1.var_.characterEffect1074ui_story = var_100_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_26 = 0.200000002980232

			if var_100_25 <= arg_97_1.time_ and arg_97_1.time_ < var_100_25 + var_100_26 and not isNil(var_100_24) then
				local var_100_27 = (arg_97_1.time_ - var_100_25) / var_100_26

				if arg_97_1.var_.characterEffect1074ui_story and not isNil(var_100_24) then
					arg_97_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_25 + var_100_26 and arg_97_1.time_ < var_100_25 + var_100_26 + arg_100_0 and not isNil(var_100_24) and arg_97_1.var_.characterEffect1074ui_story then
				arg_97_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_100_28 = 0

			if var_100_28 < arg_97_1.time_ and arg_97_1.time_ <= var_100_28 + arg_100_0 then
				arg_97_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_100_29 = 0

			if var_100_29 < arg_97_1.time_ and arg_97_1.time_ <= var_100_29 + arg_100_0 then
				arg_97_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_30 = 0
			local var_100_31 = 0.375

			if var_100_30 < arg_97_1.time_ and arg_97_1.time_ <= var_100_30 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_32 = arg_97_1:FormatText(StoryNameCfg[410].name)

				arg_97_1.leftNameTxt_.text = var_100_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_33 = arg_97_1:GetWordFromCfg(222091024)
				local var_100_34 = arg_97_1:FormatText(var_100_33.content)

				arg_97_1.text_.text = var_100_34

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_35 = 15
				local var_100_36 = utf8.len(var_100_34)
				local var_100_37 = var_100_35 <= 0 and var_100_31 or var_100_31 * (var_100_36 / var_100_35)

				if var_100_37 > 0 and var_100_31 < var_100_37 then
					arg_97_1.talkMaxDuration = var_100_37

					if var_100_37 + var_100_30 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_37 + var_100_30
					end
				end

				arg_97_1.text_.text = var_100_34
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091024", "story_v_out_222091.awb") ~= 0 then
					local var_100_38 = manager.audio:GetVoiceLength("story_v_out_222091", "222091024", "story_v_out_222091.awb") / 1000

					if var_100_38 + var_100_30 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_38 + var_100_30
					end

					if var_100_33.prefab_name ~= "" and arg_97_1.actors_[var_100_33.prefab_name] ~= nil then
						local var_100_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_33.prefab_name].transform, "story_v_out_222091", "222091024", "story_v_out_222091.awb")

						arg_97_1:RecordAudio("222091024", var_100_39)
						arg_97_1:RecordAudio("222091024", var_100_39)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_222091", "222091024", "story_v_out_222091.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_222091", "222091024", "story_v_out_222091.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_40 = math.max(var_100_31, arg_97_1.talkMaxDuration)

			if var_100_30 <= arg_97_1.time_ and arg_97_1.time_ < var_100_30 + var_100_40 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_30) / var_100_40

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_30 + var_100_40 and arg_97_1.time_ < var_100_30 + var_100_40 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222091025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 222091025
		arg_101_1.duration_ = 9.4

		local var_101_0 = {
			ja = 9.4,
			ko = 5.066,
			zh = 5.066
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
				arg_101_0:Play222091026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10039ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10039ui_story == nil then
				arg_101_1.var_.characterEffect10039ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect10039ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10039ui_story then
				arg_101_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_104_4 = 0

			if var_104_4 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_1")
			end

			local var_104_5 = 0

			if var_104_5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_6 = arg_101_1.actors_["1074ui_story"]
			local var_104_7 = 0

			if var_104_7 < arg_101_1.time_ and arg_101_1.time_ <= var_104_7 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect1074ui_story == nil then
				arg_101_1.var_.characterEffect1074ui_story = var_104_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_8 = 0.200000002980232

			if var_104_7 <= arg_101_1.time_ and arg_101_1.time_ < var_104_7 + var_104_8 and not isNil(var_104_6) then
				local var_104_9 = (arg_101_1.time_ - var_104_7) / var_104_8

				if arg_101_1.var_.characterEffect1074ui_story and not isNil(var_104_6) then
					local var_104_10 = Mathf.Lerp(0, 0.5, var_104_9)

					arg_101_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1074ui_story.fillRatio = var_104_10
				end
			end

			if arg_101_1.time_ >= var_104_7 + var_104_8 and arg_101_1.time_ < var_104_7 + var_104_8 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect1074ui_story then
				local var_104_11 = 0.5

				arg_101_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1074ui_story.fillRatio = var_104_11
			end

			local var_104_12 = 0
			local var_104_13 = 0.525

			if var_104_12 < arg_101_1.time_ and arg_101_1.time_ <= var_104_12 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_14 = arg_101_1:FormatText(StoryNameCfg[472].name)

				arg_101_1.leftNameTxt_.text = var_104_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_15 = arg_101_1:GetWordFromCfg(222091025)
				local var_104_16 = arg_101_1:FormatText(var_104_15.content)

				arg_101_1.text_.text = var_104_16

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_17 = 21
				local var_104_18 = utf8.len(var_104_16)
				local var_104_19 = var_104_17 <= 0 and var_104_13 or var_104_13 * (var_104_18 / var_104_17)

				if var_104_19 > 0 and var_104_13 < var_104_19 then
					arg_101_1.talkMaxDuration = var_104_19

					if var_104_19 + var_104_12 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_19 + var_104_12
					end
				end

				arg_101_1.text_.text = var_104_16
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091025", "story_v_out_222091.awb") ~= 0 then
					local var_104_20 = manager.audio:GetVoiceLength("story_v_out_222091", "222091025", "story_v_out_222091.awb") / 1000

					if var_104_20 + var_104_12 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_20 + var_104_12
					end

					if var_104_15.prefab_name ~= "" and arg_101_1.actors_[var_104_15.prefab_name] ~= nil then
						local var_104_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_15.prefab_name].transform, "story_v_out_222091", "222091025", "story_v_out_222091.awb")

						arg_101_1:RecordAudio("222091025", var_104_21)
						arg_101_1:RecordAudio("222091025", var_104_21)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_222091", "222091025", "story_v_out_222091.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_222091", "222091025", "story_v_out_222091.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_22 = math.max(var_104_13, arg_101_1.talkMaxDuration)

			if var_104_12 <= arg_101_1.time_ and arg_101_1.time_ < var_104_12 + var_104_22 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_12) / var_104_22

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_12 + var_104_22 and arg_101_1.time_ < var_104_12 + var_104_22 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play222091026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 222091026
		arg_105_1.duration_ = 18.17

		local var_105_0 = {
			ja = 18.166,
			ko = 13.6,
			zh = 13.6
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
				arg_105_0:Play222091027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_108_1 = 0
			local var_108_2 = 1.225

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_3 = arg_105_1:FormatText(StoryNameCfg[472].name)

				arg_105_1.leftNameTxt_.text = var_108_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(222091026)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_6 = 49
				local var_108_7 = utf8.len(var_108_5)
				local var_108_8 = var_108_6 <= 0 and var_108_2 or var_108_2 * (var_108_7 / var_108_6)

				if var_108_8 > 0 and var_108_2 < var_108_8 then
					arg_105_1.talkMaxDuration = var_108_8

					if var_108_8 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091026", "story_v_out_222091.awb") ~= 0 then
					local var_108_9 = manager.audio:GetVoiceLength("story_v_out_222091", "222091026", "story_v_out_222091.awb") / 1000

					if var_108_9 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_1
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_out_222091", "222091026", "story_v_out_222091.awb")

						arg_105_1:RecordAudio("222091026", var_108_10)
						arg_105_1:RecordAudio("222091026", var_108_10)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_222091", "222091026", "story_v_out_222091.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_222091", "222091026", "story_v_out_222091.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_11 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_11 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_11

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_11 and arg_105_1.time_ < var_108_1 + var_108_11 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play222091027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 222091027
		arg_109_1.duration_ = 10.7

		local var_109_0 = {
			ja = 10.7,
			ko = 7.2,
			zh = 7.2
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
				arg_109_0:Play222091028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1074ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1074ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0.7, -1.055, -6.12)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1074ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["1074ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1074ui_story == nil then
				arg_109_1.var_.characterEffect1074ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect1074ui_story and not isNil(var_112_9) then
					arg_109_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1074ui_story then
				arg_109_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_112_13 = 0

			if var_112_13 < arg_109_1.time_ and arg_109_1.time_ <= var_112_13 + arg_112_0 then
				arg_109_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_112_14 = 0

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_15 = arg_109_1.actors_["10039ui_story"]
			local var_112_16 = 0

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 and not isNil(var_112_15) and arg_109_1.var_.characterEffect10039ui_story == nil then
				arg_109_1.var_.characterEffect10039ui_story = var_112_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_17 = 0.200000002980232

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_17 and not isNil(var_112_15) then
				local var_112_18 = (arg_109_1.time_ - var_112_16) / var_112_17

				if arg_109_1.var_.characterEffect10039ui_story and not isNil(var_112_15) then
					local var_112_19 = Mathf.Lerp(0, 0.5, var_112_18)

					arg_109_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10039ui_story.fillRatio = var_112_19
				end
			end

			if arg_109_1.time_ >= var_112_16 + var_112_17 and arg_109_1.time_ < var_112_16 + var_112_17 + arg_112_0 and not isNil(var_112_15) and arg_109_1.var_.characterEffect10039ui_story then
				local var_112_20 = 0.5

				arg_109_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10039ui_story.fillRatio = var_112_20
			end

			local var_112_21 = 0
			local var_112_22 = 0.6

			if var_112_21 < arg_109_1.time_ and arg_109_1.time_ <= var_112_21 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_23 = arg_109_1:FormatText(StoryNameCfg[410].name)

				arg_109_1.leftNameTxt_.text = var_112_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_24 = arg_109_1:GetWordFromCfg(222091027)
				local var_112_25 = arg_109_1:FormatText(var_112_24.content)

				arg_109_1.text_.text = var_112_25

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_26 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091027", "story_v_out_222091.awb") ~= 0 then
					local var_112_29 = manager.audio:GetVoiceLength("story_v_out_222091", "222091027", "story_v_out_222091.awb") / 1000

					if var_112_29 + var_112_21 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_29 + var_112_21
					end

					if var_112_24.prefab_name ~= "" and arg_109_1.actors_[var_112_24.prefab_name] ~= nil then
						local var_112_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_24.prefab_name].transform, "story_v_out_222091", "222091027", "story_v_out_222091.awb")

						arg_109_1:RecordAudio("222091027", var_112_30)
						arg_109_1:RecordAudio("222091027", var_112_30)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_222091", "222091027", "story_v_out_222091.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_222091", "222091027", "story_v_out_222091.awb")
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
				actorName = "1074ui_story",
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
	Play222091028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 222091028
		arg_113_1.duration_ = 14.87

		local var_113_0 = {
			ja = 14.866,
			ko = 9.233,
			zh = 9.233
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
				arg_113_0:Play222091029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10039ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect10039ui_story == nil then
				arg_113_1.var_.characterEffect10039ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect10039ui_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect10039ui_story then
				arg_113_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_116_4 = 0

			if var_116_4 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_2")
			end

			local var_116_5 = 0

			if var_116_5 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_116_6 = arg_113_1.actors_["1074ui_story"]
			local var_116_7 = 0

			if var_116_7 < arg_113_1.time_ and arg_113_1.time_ <= var_116_7 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect1074ui_story == nil then
				arg_113_1.var_.characterEffect1074ui_story = var_116_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_8 = 0.200000002980232

			if var_116_7 <= arg_113_1.time_ and arg_113_1.time_ < var_116_7 + var_116_8 and not isNil(var_116_6) then
				local var_116_9 = (arg_113_1.time_ - var_116_7) / var_116_8

				if arg_113_1.var_.characterEffect1074ui_story and not isNil(var_116_6) then
					local var_116_10 = Mathf.Lerp(0, 0.5, var_116_9)

					arg_113_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1074ui_story.fillRatio = var_116_10
				end
			end

			if arg_113_1.time_ >= var_116_7 + var_116_8 and arg_113_1.time_ < var_116_7 + var_116_8 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect1074ui_story then
				local var_116_11 = 0.5

				arg_113_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1074ui_story.fillRatio = var_116_11
			end

			local var_116_12 = 0
			local var_116_13 = 0.95

			if var_116_12 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_14 = arg_113_1:FormatText(StoryNameCfg[472].name)

				arg_113_1.leftNameTxt_.text = var_116_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_15 = arg_113_1:GetWordFromCfg(222091028)
				local var_116_16 = arg_113_1:FormatText(var_116_15.content)

				arg_113_1.text_.text = var_116_16

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_17 = 38
				local var_116_18 = utf8.len(var_116_16)
				local var_116_19 = var_116_17 <= 0 and var_116_13 or var_116_13 * (var_116_18 / var_116_17)

				if var_116_19 > 0 and var_116_13 < var_116_19 then
					arg_113_1.talkMaxDuration = var_116_19

					if var_116_19 + var_116_12 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_19 + var_116_12
					end
				end

				arg_113_1.text_.text = var_116_16
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091028", "story_v_out_222091.awb") ~= 0 then
					local var_116_20 = manager.audio:GetVoiceLength("story_v_out_222091", "222091028", "story_v_out_222091.awb") / 1000

					if var_116_20 + var_116_12 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_20 + var_116_12
					end

					if var_116_15.prefab_name ~= "" and arg_113_1.actors_[var_116_15.prefab_name] ~= nil then
						local var_116_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_15.prefab_name].transform, "story_v_out_222091", "222091028", "story_v_out_222091.awb")

						arg_113_1:RecordAudio("222091028", var_116_21)
						arg_113_1:RecordAudio("222091028", var_116_21)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_222091", "222091028", "story_v_out_222091.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_222091", "222091028", "story_v_out_222091.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_22 = math.max(var_116_13, arg_113_1.talkMaxDuration)

			if var_116_12 <= arg_113_1.time_ and arg_113_1.time_ < var_116_12 + var_116_22 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_12) / var_116_22

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_12 + var_116_22 and arg_113_1.time_ < var_116_12 + var_116_22 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play222091029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 222091029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play222091030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10039ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect10039ui_story == nil then
				arg_117_1.var_.characterEffect10039ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect10039ui_story and not isNil(var_120_0) then
					local var_120_4 = Mathf.Lerp(0, 0.5, var_120_3)

					arg_117_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10039ui_story.fillRatio = var_120_4
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect10039ui_story then
				local var_120_5 = 0.5

				arg_117_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10039ui_story.fillRatio = var_120_5
			end

			local var_120_6 = 0
			local var_120_7 = 0.4

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:GetWordFromCfg(222091029)
				local var_120_9 = arg_117_1:FormatText(var_120_8.content)

				arg_117_1.text_.text = var_120_9

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_10 = 16
				local var_120_11 = utf8.len(var_120_9)
				local var_120_12 = var_120_10 <= 0 and var_120_7 or var_120_7 * (var_120_11 / var_120_10)

				if var_120_12 > 0 and var_120_7 < var_120_12 then
					arg_117_1.talkMaxDuration = var_120_12

					if var_120_12 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_9
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_13 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_13 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_13

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_13 and arg_117_1.time_ < var_120_6 + var_120_13 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play222091030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 222091030
		arg_121_1.duration_ = 14.1

		local var_121_0 = {
			ja = 14.1,
			ko = 5.833,
			zh = 5.833
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
				arg_121_0:Play222091031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10039ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect10039ui_story == nil then
				arg_121_1.var_.characterEffect10039ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect10039ui_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect10039ui_story then
				arg_121_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_124_4 = 0

			if var_124_4 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_124_5 = 0

			if var_124_5 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				arg_121_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_124_6 = 0
			local var_124_7 = 0.475

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_8 = arg_121_1:FormatText(StoryNameCfg[472].name)

				arg_121_1.leftNameTxt_.text = var_124_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_9 = arg_121_1:GetWordFromCfg(222091030)
				local var_124_10 = arg_121_1:FormatText(var_124_9.content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 19
				local var_124_12 = utf8.len(var_124_10)
				local var_124_13 = var_124_11 <= 0 and var_124_7 or var_124_7 * (var_124_12 / var_124_11)

				if var_124_13 > 0 and var_124_7 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_10
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091030", "story_v_out_222091.awb") ~= 0 then
					local var_124_14 = manager.audio:GetVoiceLength("story_v_out_222091", "222091030", "story_v_out_222091.awb") / 1000

					if var_124_14 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_6
					end

					if var_124_9.prefab_name ~= "" and arg_121_1.actors_[var_124_9.prefab_name] ~= nil then
						local var_124_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_9.prefab_name].transform, "story_v_out_222091", "222091030", "story_v_out_222091.awb")

						arg_121_1:RecordAudio("222091030", var_124_15)
						arg_121_1:RecordAudio("222091030", var_124_15)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_222091", "222091030", "story_v_out_222091.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_222091", "222091030", "story_v_out_222091.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_16 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_16 and arg_121_1.time_ < var_124_6 + var_124_16 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play222091031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 222091031
		arg_125_1.duration_ = 9.17

		local var_125_0 = {
			ja = 8.266,
			ko = 9.133,
			zh = 9.166
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
				arg_125_0:Play222091032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.825

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[472].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:GetWordFromCfg(222091031)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 33
				local var_128_6 = utf8.len(var_128_4)
				local var_128_7 = var_128_5 <= 0 and var_128_1 or var_128_1 * (var_128_6 / var_128_5)

				if var_128_7 > 0 and var_128_1 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_4
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091031", "story_v_out_222091.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_222091", "222091031", "story_v_out_222091.awb") / 1000

					if var_128_8 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_0
					end

					if var_128_3.prefab_name ~= "" and arg_125_1.actors_[var_128_3.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_3.prefab_name].transform, "story_v_out_222091", "222091031", "story_v_out_222091.awb")

						arg_125_1:RecordAudio("222091031", var_128_9)
						arg_125_1:RecordAudio("222091031", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_222091", "222091031", "story_v_out_222091.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_222091", "222091031", "story_v_out_222091.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_10 and arg_125_1.time_ < var_128_0 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play222091032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 222091032
		arg_129_1.duration_ = 2

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play222091033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_132_1 = 0
			local var_132_2 = 0.075

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_3 = arg_129_1:FormatText(StoryNameCfg[472].name)

				arg_129_1.leftNameTxt_.text = var_132_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_4 = arg_129_1:GetWordFromCfg(222091032)
				local var_132_5 = arg_129_1:FormatText(var_132_4.content)

				arg_129_1.text_.text = var_132_5

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_6 = 3
				local var_132_7 = utf8.len(var_132_5)
				local var_132_8 = var_132_6 <= 0 and var_132_2 or var_132_2 * (var_132_7 / var_132_6)

				if var_132_8 > 0 and var_132_2 < var_132_8 then
					arg_129_1.talkMaxDuration = var_132_8

					if var_132_8 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_5
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091032", "story_v_out_222091.awb") ~= 0 then
					local var_132_9 = manager.audio:GetVoiceLength("story_v_out_222091", "222091032", "story_v_out_222091.awb") / 1000

					if var_132_9 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_1
					end

					if var_132_4.prefab_name ~= "" and arg_129_1.actors_[var_132_4.prefab_name] ~= nil then
						local var_132_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_4.prefab_name].transform, "story_v_out_222091", "222091032", "story_v_out_222091.awb")

						arg_129_1:RecordAudio("222091032", var_132_10)
						arg_129_1:RecordAudio("222091032", var_132_10)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_222091", "222091032", "story_v_out_222091.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_222091", "222091032", "story_v_out_222091.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_11 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_11 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_11

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_11 and arg_129_1.time_ < var_132_1 + var_132_11 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play222091033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 222091033
		arg_133_1.duration_ = 9.8

		local var_133_0 = {
			ja = 9.8,
			ko = 4.666,
			zh = 4.666
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
				arg_133_0:Play222091034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1074ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos1074ui_story = var_136_0.localPosition
			end

			local var_136_2 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2
				local var_136_4 = Vector3.New(0, 100, 0)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1074ui_story, var_136_4, var_136_3)

				local var_136_5 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_5.x, var_136_5.y, var_136_5.z)

				local var_136_6 = var_136_0.localEulerAngles

				var_136_6.z = 0
				var_136_6.x = 0
				var_136_0.localEulerAngles = var_136_6
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0, 100, 0)

				local var_136_7 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_7.x, var_136_7.y, var_136_7.z)

				local var_136_8 = var_136_0.localEulerAngles

				var_136_8.z = 0
				var_136_8.x = 0
				var_136_0.localEulerAngles = var_136_8
			end

			local var_136_9 = arg_133_1.actors_["1074ui_story"]
			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect1074ui_story == nil then
				arg_133_1.var_.characterEffect1074ui_story = var_136_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_11 = 0.200000002980232

			if var_136_10 <= arg_133_1.time_ and arg_133_1.time_ < var_136_10 + var_136_11 and not isNil(var_136_9) then
				local var_136_12 = (arg_133_1.time_ - var_136_10) / var_136_11

				if arg_133_1.var_.characterEffect1074ui_story and not isNil(var_136_9) then
					local var_136_13 = Mathf.Lerp(0, 0.5, var_136_12)

					arg_133_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1074ui_story.fillRatio = var_136_13
				end
			end

			if arg_133_1.time_ >= var_136_10 + var_136_11 and arg_133_1.time_ < var_136_10 + var_136_11 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect1074ui_story then
				local var_136_14 = 0.5

				arg_133_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1074ui_story.fillRatio = var_136_14
			end

			local var_136_15 = arg_133_1.actors_["1070ui_story"].transform
			local var_136_16 = 0

			if var_136_16 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 then
				arg_133_1.var_.moveOldPos1070ui_story = var_136_15.localPosition
			end

			local var_136_17 = 0.001

			if var_136_16 <= arg_133_1.time_ and arg_133_1.time_ < var_136_16 + var_136_17 then
				local var_136_18 = (arg_133_1.time_ - var_136_16) / var_136_17
				local var_136_19 = Vector3.New(0.7, -0.95, -6.05)

				var_136_15.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1070ui_story, var_136_19, var_136_18)

				local var_136_20 = manager.ui.mainCamera.transform.position - var_136_15.position

				var_136_15.forward = Vector3.New(var_136_20.x, var_136_20.y, var_136_20.z)

				local var_136_21 = var_136_15.localEulerAngles

				var_136_21.z = 0
				var_136_21.x = 0
				var_136_15.localEulerAngles = var_136_21
			end

			if arg_133_1.time_ >= var_136_16 + var_136_17 and arg_133_1.time_ < var_136_16 + var_136_17 + arg_136_0 then
				var_136_15.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_136_22 = manager.ui.mainCamera.transform.position - var_136_15.position

				var_136_15.forward = Vector3.New(var_136_22.x, var_136_22.y, var_136_22.z)

				local var_136_23 = var_136_15.localEulerAngles

				var_136_23.z = 0
				var_136_23.x = 0
				var_136_15.localEulerAngles = var_136_23
			end

			local var_136_24 = arg_133_1.actors_["1070ui_story"]
			local var_136_25 = 0

			if var_136_25 < arg_133_1.time_ and arg_133_1.time_ <= var_136_25 + arg_136_0 and not isNil(var_136_24) and arg_133_1.var_.characterEffect1070ui_story == nil then
				arg_133_1.var_.characterEffect1070ui_story = var_136_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_26 = 0.200000002980232

			if var_136_25 <= arg_133_1.time_ and arg_133_1.time_ < var_136_25 + var_136_26 and not isNil(var_136_24) then
				local var_136_27 = (arg_133_1.time_ - var_136_25) / var_136_26

				if arg_133_1.var_.characterEffect1070ui_story and not isNil(var_136_24) then
					arg_133_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_25 + var_136_26 and arg_133_1.time_ < var_136_25 + var_136_26 + arg_136_0 and not isNil(var_136_24) and arg_133_1.var_.characterEffect1070ui_story then
				arg_133_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_136_28 = 0

			if var_136_28 < arg_133_1.time_ and arg_133_1.time_ <= var_136_28 + arg_136_0 then
				arg_133_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_136_29 = 0

			if var_136_29 < arg_133_1.time_ and arg_133_1.time_ <= var_136_29 + arg_136_0 then
				arg_133_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_136_30 = arg_133_1.actors_["10039ui_story"]
			local var_136_31 = 0

			if var_136_31 < arg_133_1.time_ and arg_133_1.time_ <= var_136_31 + arg_136_0 and not isNil(var_136_30) and arg_133_1.var_.characterEffect10039ui_story == nil then
				arg_133_1.var_.characterEffect10039ui_story = var_136_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_32 = 0.200000002980232

			if var_136_31 <= arg_133_1.time_ and arg_133_1.time_ < var_136_31 + var_136_32 and not isNil(var_136_30) then
				local var_136_33 = (arg_133_1.time_ - var_136_31) / var_136_32

				if arg_133_1.var_.characterEffect10039ui_story and not isNil(var_136_30) then
					local var_136_34 = Mathf.Lerp(0, 0.5, var_136_33)

					arg_133_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10039ui_story.fillRatio = var_136_34
				end
			end

			if arg_133_1.time_ >= var_136_31 + var_136_32 and arg_133_1.time_ < var_136_31 + var_136_32 + arg_136_0 and not isNil(var_136_30) and arg_133_1.var_.characterEffect10039ui_story then
				local var_136_35 = 0.5

				arg_133_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10039ui_story.fillRatio = var_136_35
			end

			local var_136_36 = 0
			local var_136_37 = 0.525

			if var_136_36 < arg_133_1.time_ and arg_133_1.time_ <= var_136_36 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_38 = arg_133_1:FormatText(StoryNameCfg[318].name)

				arg_133_1.leftNameTxt_.text = var_136_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_39 = arg_133_1:GetWordFromCfg(222091033)
				local var_136_40 = arg_133_1:FormatText(var_136_39.content)

				arg_133_1.text_.text = var_136_40

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_41 = 21
				local var_136_42 = utf8.len(var_136_40)
				local var_136_43 = var_136_41 <= 0 and var_136_37 or var_136_37 * (var_136_42 / var_136_41)

				if var_136_43 > 0 and var_136_37 < var_136_43 then
					arg_133_1.talkMaxDuration = var_136_43

					if var_136_43 + var_136_36 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_43 + var_136_36
					end
				end

				arg_133_1.text_.text = var_136_40
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091033", "story_v_out_222091.awb") ~= 0 then
					local var_136_44 = manager.audio:GetVoiceLength("story_v_out_222091", "222091033", "story_v_out_222091.awb") / 1000

					if var_136_44 + var_136_36 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_44 + var_136_36
					end

					if var_136_39.prefab_name ~= "" and arg_133_1.actors_[var_136_39.prefab_name] ~= nil then
						local var_136_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_39.prefab_name].transform, "story_v_out_222091", "222091033", "story_v_out_222091.awb")

						arg_133_1:RecordAudio("222091033", var_136_45)
						arg_133_1:RecordAudio("222091033", var_136_45)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_222091", "222091033", "story_v_out_222091.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_222091", "222091033", "story_v_out_222091.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_46 = math.max(var_136_37, arg_133_1.talkMaxDuration)

			if var_136_36 <= arg_133_1.time_ and arg_133_1.time_ < var_136_36 + var_136_46 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_36) / var_136_46

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_36 + var_136_46 and arg_133_1.time_ < var_136_36 + var_136_46 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play222091034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 222091034
		arg_137_1.duration_ = 10.77

		local var_137_0 = {
			ja = 10.766,
			ko = 3.933,
			zh = 3.933
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
				arg_137_0:Play222091035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_2 = 0
			local var_140_3 = 0.55

			if var_140_2 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_4 = arg_137_1:FormatText(StoryNameCfg[318].name)

				arg_137_1.leftNameTxt_.text = var_140_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_5 = arg_137_1:GetWordFromCfg(222091034)
				local var_140_6 = arg_137_1:FormatText(var_140_5.content)

				arg_137_1.text_.text = var_140_6

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_7 = 22
				local var_140_8 = utf8.len(var_140_6)
				local var_140_9 = var_140_7 <= 0 and var_140_3 or var_140_3 * (var_140_8 / var_140_7)

				if var_140_9 > 0 and var_140_3 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_6
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091034", "story_v_out_222091.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_out_222091", "222091034", "story_v_out_222091.awb") / 1000

					if var_140_10 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_2
					end

					if var_140_5.prefab_name ~= "" and arg_137_1.actors_[var_140_5.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_5.prefab_name].transform, "story_v_out_222091", "222091034", "story_v_out_222091.awb")

						arg_137_1:RecordAudio("222091034", var_140_11)
						arg_137_1:RecordAudio("222091034", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_222091", "222091034", "story_v_out_222091.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_222091", "222091034", "story_v_out_222091.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_12 and arg_137_1.time_ < var_140_2 + var_140_12 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play222091035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 222091035
		arg_141_1.duration_ = 14.83

		local var_141_0 = {
			ja = 14.833,
			ko = 5.1,
			zh = 5.1
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
				arg_141_0:Play222091036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_2 = 0
			local var_144_3 = 0.775

			if var_144_2 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_4 = arg_141_1:FormatText(StoryNameCfg[318].name)

				arg_141_1.leftNameTxt_.text = var_144_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_5 = arg_141_1:GetWordFromCfg(222091035)
				local var_144_6 = arg_141_1:FormatText(var_144_5.content)

				arg_141_1.text_.text = var_144_6

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_7 = 31
				local var_144_8 = utf8.len(var_144_6)
				local var_144_9 = var_144_7 <= 0 and var_144_3 or var_144_3 * (var_144_8 / var_144_7)

				if var_144_9 > 0 and var_144_3 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_2
					end
				end

				arg_141_1.text_.text = var_144_6
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091035", "story_v_out_222091.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_222091", "222091035", "story_v_out_222091.awb") / 1000

					if var_144_10 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_2
					end

					if var_144_5.prefab_name ~= "" and arg_141_1.actors_[var_144_5.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_5.prefab_name].transform, "story_v_out_222091", "222091035", "story_v_out_222091.awb")

						arg_141_1:RecordAudio("222091035", var_144_11)
						arg_141_1:RecordAudio("222091035", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_222091", "222091035", "story_v_out_222091.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_222091", "222091035", "story_v_out_222091.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_3, arg_141_1.talkMaxDuration)

			if var_144_2 <= arg_141_1.time_ and arg_141_1.time_ < var_144_2 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_2) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_2 + var_144_12 and arg_141_1.time_ < var_144_2 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play222091036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 222091036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play222091037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1070ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1070ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0, 100, 0)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1070ui_story, var_148_4, var_148_3)

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

			local var_148_9 = arg_145_1.actors_["1070ui_story"]
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect1070ui_story == nil then
				arg_145_1.var_.characterEffect1070ui_story = var_148_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_11 = 0.200000002980232

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 and not isNil(var_148_9) then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11

				if arg_145_1.var_.characterEffect1070ui_story and not isNil(var_148_9) then
					local var_148_13 = Mathf.Lerp(0, 0.5, var_148_12)

					arg_145_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1070ui_story.fillRatio = var_148_13
				end
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect1070ui_story then
				local var_148_14 = 0.5

				arg_145_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1070ui_story.fillRatio = var_148_14
			end

			local var_148_15 = arg_145_1.actors_["10039ui_story"].transform
			local var_148_16 = 0

			if var_148_16 < arg_145_1.time_ and arg_145_1.time_ <= var_148_16 + arg_148_0 then
				arg_145_1.var_.moveOldPos10039ui_story = var_148_15.localPosition
			end

			local var_148_17 = 0.001

			if var_148_16 <= arg_145_1.time_ and arg_145_1.time_ < var_148_16 + var_148_17 then
				local var_148_18 = (arg_145_1.time_ - var_148_16) / var_148_17
				local var_148_19 = Vector3.New(0, 100, 0)

				var_148_15.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10039ui_story, var_148_19, var_148_18)

				local var_148_20 = manager.ui.mainCamera.transform.position - var_148_15.position

				var_148_15.forward = Vector3.New(var_148_20.x, var_148_20.y, var_148_20.z)

				local var_148_21 = var_148_15.localEulerAngles

				var_148_21.z = 0
				var_148_21.x = 0
				var_148_15.localEulerAngles = var_148_21
			end

			if arg_145_1.time_ >= var_148_16 + var_148_17 and arg_145_1.time_ < var_148_16 + var_148_17 + arg_148_0 then
				var_148_15.localPosition = Vector3.New(0, 100, 0)

				local var_148_22 = manager.ui.mainCamera.transform.position - var_148_15.position

				var_148_15.forward = Vector3.New(var_148_22.x, var_148_22.y, var_148_22.z)

				local var_148_23 = var_148_15.localEulerAngles

				var_148_23.z = 0
				var_148_23.x = 0
				var_148_15.localEulerAngles = var_148_23
			end

			local var_148_24 = arg_145_1.actors_["10039ui_story"]
			local var_148_25 = 0

			if var_148_25 < arg_145_1.time_ and arg_145_1.time_ <= var_148_25 + arg_148_0 and not isNil(var_148_24) and arg_145_1.var_.characterEffect10039ui_story == nil then
				arg_145_1.var_.characterEffect10039ui_story = var_148_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_26 = 0.200000002980232

			if var_148_25 <= arg_145_1.time_ and arg_145_1.time_ < var_148_25 + var_148_26 and not isNil(var_148_24) then
				local var_148_27 = (arg_145_1.time_ - var_148_25) / var_148_26

				if arg_145_1.var_.characterEffect10039ui_story and not isNil(var_148_24) then
					local var_148_28 = Mathf.Lerp(0, 0.5, var_148_27)

					arg_145_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10039ui_story.fillRatio = var_148_28
				end
			end

			if arg_145_1.time_ >= var_148_25 + var_148_26 and arg_145_1.time_ < var_148_25 + var_148_26 + arg_148_0 and not isNil(var_148_24) and arg_145_1.var_.characterEffect10039ui_story then
				local var_148_29 = 0.5

				arg_145_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10039ui_story.fillRatio = var_148_29
			end

			local var_148_30 = 0
			local var_148_31 = 1.025

			if var_148_30 < arg_145_1.time_ and arg_145_1.time_ <= var_148_30 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_32 = arg_145_1:GetWordFromCfg(222091036)
				local var_148_33 = arg_145_1:FormatText(var_148_32.content)

				arg_145_1.text_.text = var_148_33

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_34 = 41
				local var_148_35 = utf8.len(var_148_33)
				local var_148_36 = var_148_34 <= 0 and var_148_31 or var_148_31 * (var_148_35 / var_148_34)

				if var_148_36 > 0 and var_148_31 < var_148_36 then
					arg_145_1.talkMaxDuration = var_148_36

					if var_148_36 + var_148_30 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_36 + var_148_30
					end
				end

				arg_145_1.text_.text = var_148_33
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_37 = math.max(var_148_31, arg_145_1.talkMaxDuration)

			if var_148_30 <= arg_145_1.time_ and arg_145_1.time_ < var_148_30 + var_148_37 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_30) / var_148_37

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_30 + var_148_37 and arg_145_1.time_ < var_148_30 + var_148_37 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play222091037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 222091037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play222091038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.775

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_2 = arg_149_1:GetWordFromCfg(222091037)
				local var_152_3 = arg_149_1:FormatText(var_152_2.content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 31
				local var_152_5 = utf8.len(var_152_3)
				local var_152_6 = var_152_4 <= 0 and var_152_1 or var_152_1 * (var_152_5 / var_152_4)

				if var_152_6 > 0 and var_152_1 < var_152_6 then
					arg_149_1.talkMaxDuration = var_152_6

					if var_152_6 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_7 and arg_149_1.time_ < var_152_0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play222091038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 222091038
		arg_153_1.duration_ = 10.5

		local var_153_0 = {
			ja = 10.5,
			ko = 8.133,
			zh = 8.333
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
				arg_153_0:Play222091039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1074ui_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos1074ui_story = var_156_0.localPosition
			end

			local var_156_2 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2
				local var_156_4 = Vector3.New(0, -1.055, -6.12)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1074ui_story, var_156_4, var_156_3)

				local var_156_5 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_5.x, var_156_5.y, var_156_5.z)

				local var_156_6 = var_156_0.localEulerAngles

				var_156_6.z = 0
				var_156_6.x = 0
				var_156_0.localEulerAngles = var_156_6
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_156_7 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_7.x, var_156_7.y, var_156_7.z)

				local var_156_8 = var_156_0.localEulerAngles

				var_156_8.z = 0
				var_156_8.x = 0
				var_156_0.localEulerAngles = var_156_8
			end

			local var_156_9 = arg_153_1.actors_["1074ui_story"]
			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1074ui_story == nil then
				arg_153_1.var_.characterEffect1074ui_story = var_156_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_11 = 0.200000002980232

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_11 and not isNil(var_156_9) then
				local var_156_12 = (arg_153_1.time_ - var_156_10) / var_156_11

				if arg_153_1.var_.characterEffect1074ui_story and not isNil(var_156_9) then
					arg_153_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_10 + var_156_11 and arg_153_1.time_ < var_156_10 + var_156_11 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1074ui_story then
				arg_153_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_156_13 = 0

			if var_156_13 < arg_153_1.time_ and arg_153_1.time_ <= var_156_13 + arg_156_0 then
				arg_153_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_156_14 = 0

			if var_156_14 < arg_153_1.time_ and arg_153_1.time_ <= var_156_14 + arg_156_0 then
				arg_153_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_156_15 = 0
			local var_156_16 = 0.675

			if var_156_15 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_17 = arg_153_1:FormatText(StoryNameCfg[410].name)

				arg_153_1.leftNameTxt_.text = var_156_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_18 = arg_153_1:GetWordFromCfg(222091038)
				local var_156_19 = arg_153_1:FormatText(var_156_18.content)

				arg_153_1.text_.text = var_156_19

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_20 = 27
				local var_156_21 = utf8.len(var_156_19)
				local var_156_22 = var_156_20 <= 0 and var_156_16 or var_156_16 * (var_156_21 / var_156_20)

				if var_156_22 > 0 and var_156_16 < var_156_22 then
					arg_153_1.talkMaxDuration = var_156_22

					if var_156_22 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_22 + var_156_15
					end
				end

				arg_153_1.text_.text = var_156_19
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091038", "story_v_out_222091.awb") ~= 0 then
					local var_156_23 = manager.audio:GetVoiceLength("story_v_out_222091", "222091038", "story_v_out_222091.awb") / 1000

					if var_156_23 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_23 + var_156_15
					end

					if var_156_18.prefab_name ~= "" and arg_153_1.actors_[var_156_18.prefab_name] ~= nil then
						local var_156_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_18.prefab_name].transform, "story_v_out_222091", "222091038", "story_v_out_222091.awb")

						arg_153_1:RecordAudio("222091038", var_156_24)
						arg_153_1:RecordAudio("222091038", var_156_24)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_222091", "222091038", "story_v_out_222091.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_222091", "222091038", "story_v_out_222091.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_25 = math.max(var_156_16, arg_153_1.talkMaxDuration)

			if var_156_15 <= arg_153_1.time_ and arg_153_1.time_ < var_156_15 + var_156_25 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_15) / var_156_25

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_15 + var_156_25 and arg_153_1.time_ < var_156_15 + var_156_25 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222091039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 222091039
		arg_157_1.duration_ = 4.77

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play222091040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1074ui_story"].transform
			local var_160_1 = 1.96599999815226

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos1074ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(0, 100, 0)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1074ui_story, var_160_4, var_160_3)

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

			local var_160_9 = arg_157_1.actors_["1074ui_story"]
			local var_160_10 = 1.96599999815226

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect1074ui_story == nil then
				arg_157_1.var_.characterEffect1074ui_story = var_160_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_11 = 0.034000001847744

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 and not isNil(var_160_9) then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11

				if arg_157_1.var_.characterEffect1074ui_story and not isNil(var_160_9) then
					local var_160_13 = Mathf.Lerp(0, 0.5, var_160_12)

					arg_157_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1074ui_story.fillRatio = var_160_13
				end
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect1074ui_story then
				local var_160_14 = 0.5

				arg_157_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1074ui_story.fillRatio = var_160_14
			end

			local var_160_15 = 2

			if var_160_15 < arg_157_1.time_ and arg_157_1.time_ <= var_160_15 + arg_160_0 then
				arg_157_1.fswbg_:SetActive(true)
				arg_157_1.dialog_:SetActive(false)

				arg_157_1.fswtw_.percent = 0

				local var_160_16 = arg_157_1:GetWordFromCfg(222091039)
				local var_160_17 = arg_157_1:FormatText(var_160_16.content)

				arg_157_1.fswt_.text = var_160_17

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.fswt_)

				arg_157_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_157_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_157_1.fswtw_:SetDirty()

				arg_157_1.typewritterCharCountI18N = 0

				SetActive(arg_157_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_157_1:ShowNextGo(false)
			end

			local var_160_18 = 2.01666666666667

			if var_160_18 < arg_157_1.time_ and arg_157_1.time_ <= var_160_18 + arg_160_0 then
				arg_157_1.var_.oldValueTypewriter = arg_157_1.fswtw_.percent

				SetActive(arg_157_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_157_1:ShowNextGo(false)
			end

			local var_160_19 = 41
			local var_160_20 = 2.73333333333333
			local var_160_21 = arg_157_1:GetWordFromCfg(222091039)
			local var_160_22 = arg_157_1:FormatText(var_160_21.content)
			local var_160_23, var_160_24 = arg_157_1:GetPercentByPara(var_160_22, 1)

			if var_160_18 < arg_157_1.time_ and arg_157_1.time_ <= var_160_18 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				local var_160_25 = var_160_19 <= 0 and var_160_20 or var_160_20 * ((var_160_24 - arg_157_1.typewritterCharCountI18N) / var_160_19)

				if var_160_25 > 0 and var_160_20 < var_160_25 then
					arg_157_1.talkMaxDuration = var_160_25

					if var_160_25 + var_160_18 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_25 + var_160_18
					end
				end
			end

			local var_160_26 = 2.73333333333333
			local var_160_27 = math.max(var_160_26, arg_157_1.talkMaxDuration)

			if var_160_18 <= arg_157_1.time_ and arg_157_1.time_ < var_160_18 + var_160_27 then
				local var_160_28 = (arg_157_1.time_ - var_160_18) / var_160_27

				arg_157_1.fswtw_.percent = Mathf.Lerp(arg_157_1.var_.oldValueTypewriter, var_160_23, var_160_28)
				arg_157_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_157_1.fswtw_:SetDirty()
			end

			if arg_157_1.time_ >= var_160_18 + var_160_27 and arg_157_1.time_ < var_160_18 + var_160_27 + arg_160_0 then
				arg_157_1.fswtw_.percent = var_160_23

				arg_157_1.fswtw_:SetDirty()
				arg_157_1:ShowNextGo(true)

				arg_157_1.typewritterCharCountI18N = var_160_24
			end

			local var_160_29 = 0

			if var_160_29 < arg_157_1.time_ and arg_157_1.time_ <= var_160_29 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_30 = 2

			if var_160_29 <= arg_157_1.time_ and arg_157_1.time_ < var_160_29 + var_160_30 then
				local var_160_31 = (arg_157_1.time_ - var_160_29) / var_160_30
				local var_160_32 = Color.New(0, 0, 0)

				var_160_32.a = Mathf.Lerp(0, 1, var_160_31)
				arg_157_1.mask_.color = var_160_32
			end

			if arg_157_1.time_ >= var_160_29 + var_160_30 and arg_157_1.time_ < var_160_29 + var_160_30 + arg_160_0 then
				local var_160_33 = Color.New(0, 0, 0)

				var_160_33.a = 1
				arg_157_1.mask_.color = var_160_33
			end

			local var_160_34 = 2

			if var_160_34 < arg_157_1.time_ and arg_157_1.time_ <= var_160_34 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_35 = 2

			if var_160_34 <= arg_157_1.time_ and arg_157_1.time_ < var_160_34 + var_160_35 then
				local var_160_36 = (arg_157_1.time_ - var_160_34) / var_160_35
				local var_160_37 = Color.New(0, 0, 0)

				var_160_37.a = Mathf.Lerp(1, 0, var_160_36)
				arg_157_1.mask_.color = var_160_37
			end

			if arg_157_1.time_ >= var_160_34 + var_160_35 and arg_157_1.time_ < var_160_34 + var_160_35 + arg_160_0 then
				local var_160_38 = Color.New(0, 0, 0)
				local var_160_39 = 0

				arg_157_1.mask_.enabled = false
				var_160_38.a = var_160_39
				arg_157_1.mask_.color = var_160_38
			end

			local var_160_40 = 2

			if var_160_40 < arg_157_1.time_ and arg_157_1.time_ <= var_160_40 + arg_160_0 then
				local var_160_41 = arg_157_1.fswbg_.transform:Find("textbox/adapt/content") or arg_157_1.fswbg_.transform:Find("textbox/content")
				local var_160_42 = arg_157_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_160_43 = var_160_41:GetComponent("Text")
				local var_160_44 = var_160_41:GetComponent("RectTransform")

				var_160_43.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_160_44.offsetMin = Vector2.New(0, 0)
				var_160_44.offsetMax = Vector2.New(0, 0)
			end

			local var_160_45 = "STblack"

			if arg_157_1.bgs_[var_160_45] == nil then
				local var_160_46 = Object.Instantiate(arg_157_1.paintGo_)

				var_160_46:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_160_45)
				var_160_46.name = var_160_45
				var_160_46.transform.parent = arg_157_1.stage_.transform
				var_160_46.transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.bgs_[var_160_45] = var_160_46
			end

			local var_160_47 = 2

			if var_160_47 < arg_157_1.time_ and arg_157_1.time_ <= var_160_47 + arg_160_0 then
				local var_160_48 = manager.ui.mainCamera.transform.localPosition
				local var_160_49 = Vector3.New(0, 0, 10) + Vector3.New(var_160_48.x, var_160_48.y, 0)
				local var_160_50 = arg_157_1.bgs_.STblack

				var_160_50.transform.localPosition = var_160_49
				var_160_50.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_160_51 = var_160_50:GetComponent("SpriteRenderer")

				if var_160_51 and var_160_51.sprite then
					local var_160_52 = (var_160_50.transform.localPosition - var_160_48).z
					local var_160_53 = manager.ui.mainCameraCom_
					local var_160_54 = 2 * var_160_52 * Mathf.Tan(var_160_53.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_160_55 = var_160_54 * var_160_53.aspect
					local var_160_56 = var_160_51.sprite.bounds.size.x
					local var_160_57 = var_160_51.sprite.bounds.size.y
					local var_160_58 = var_160_55 / var_160_56
					local var_160_59 = var_160_54 / var_160_57
					local var_160_60 = var_160_59 < var_160_58 and var_160_58 or var_160_59

					var_160_50.transform.localScale = Vector3.New(var_160_60, var_160_60, 0)
				end

				for iter_160_0, iter_160_1 in pairs(arg_157_1.bgs_) do
					if iter_160_0 ~= "STblack" then
						iter_160_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play222091040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 222091040
		arg_161_1.duration_ = 2.87

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play222091041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.fswbg_:SetActive(true)
				arg_161_1.dialog_:SetActive(false)

				arg_161_1.fswtw_.percent = 0

				local var_164_1 = arg_161_1:GetWordFromCfg(222091040)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.fswt_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.fswt_)

				arg_161_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_161_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_161_1.fswtw_:SetDirty()

				arg_161_1.typewritterCharCountI18N = 0

				SetActive(arg_161_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_161_1:ShowNextGo(false)
			end

			local var_164_3 = 0.0166666666666666

			if var_164_3 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 then
				arg_161_1.var_.oldValueTypewriter = arg_161_1.fswtw_.percent

				SetActive(arg_161_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_161_1:ShowNextGo(false)
			end

			local var_164_4 = 37
			local var_164_5 = 2.46666666666667
			local var_164_6 = arg_161_1:GetWordFromCfg(222091040)
			local var_164_7 = arg_161_1:FormatText(var_164_6.content)
			local var_164_8, var_164_9 = arg_161_1:GetPercentByPara(var_164_7, 1)

			if var_164_3 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0

				local var_164_10 = var_164_4 <= 0 and var_164_5 or var_164_5 * ((var_164_9 - arg_161_1.typewritterCharCountI18N) / var_164_4)

				if var_164_10 > 0 and var_164_5 < var_164_10 then
					arg_161_1.talkMaxDuration = var_164_10

					if var_164_10 + var_164_3 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_3
					end
				end
			end

			local var_164_11 = 2.46666666666667
			local var_164_12 = math.max(var_164_11, arg_161_1.talkMaxDuration)

			if var_164_3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_3 + var_164_12 then
				local var_164_13 = (arg_161_1.time_ - var_164_3) / var_164_12

				arg_161_1.fswtw_.percent = Mathf.Lerp(arg_161_1.var_.oldValueTypewriter, var_164_8, var_164_13)
				arg_161_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_161_1.fswtw_:SetDirty()
			end

			if arg_161_1.time_ >= var_164_3 + var_164_12 and arg_161_1.time_ < var_164_3 + var_164_12 + arg_164_0 then
				arg_161_1.fswtw_.percent = var_164_8

				arg_161_1.fswtw_:SetDirty()
				arg_161_1:ShowNextGo(true)

				arg_161_1.typewritterCharCountI18N = var_164_9
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play222091041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 222091041
		arg_165_1.duration_ = 3.03

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play222091042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.fswbg_:SetActive(true)
				arg_165_1.dialog_:SetActive(false)

				arg_165_1.fswtw_.percent = 0

				local var_168_1 = arg_165_1:GetWordFromCfg(222091041)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.fswt_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.fswt_)

				arg_165_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_165_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_165_1.fswtw_:SetDirty()

				arg_165_1.typewritterCharCountI18N = 0

				SetActive(arg_165_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_165_1:ShowNextGo(false)
			end

			local var_168_3 = 0.0166666666666666

			if var_168_3 < arg_165_1.time_ and arg_165_1.time_ <= var_168_3 + arg_168_0 then
				arg_165_1.var_.oldValueTypewriter = arg_165_1.fswtw_.percent

				SetActive(arg_165_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_165_1:ShowNextGo(false)
			end

			local var_168_4 = 52
			local var_168_5 = 2.73333333333333
			local var_168_6 = arg_165_1:GetWordFromCfg(222091041)
			local var_168_7 = arg_165_1:FormatText(var_168_6.content)
			local var_168_8, var_168_9 = arg_165_1:GetPercentByPara(var_168_7, 1)

			if var_168_3 < arg_165_1.time_ and arg_165_1.time_ <= var_168_3 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				local var_168_10 = var_168_4 <= 0 and var_168_5 or var_168_5 * ((var_168_9 - arg_165_1.typewritterCharCountI18N) / var_168_4)

				if var_168_10 > 0 and var_168_5 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10

					if var_168_10 + var_168_3 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_3
					end
				end
			end

			local var_168_11 = 2.73333333333333
			local var_168_12 = math.max(var_168_11, arg_165_1.talkMaxDuration)

			if var_168_3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_3 + var_168_12 then
				local var_168_13 = (arg_165_1.time_ - var_168_3) / var_168_12

				arg_165_1.fswtw_.percent = Mathf.Lerp(arg_165_1.var_.oldValueTypewriter, var_168_8, var_168_13)
				arg_165_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_165_1.fswtw_:SetDirty()
			end

			if arg_165_1.time_ >= var_168_3 + var_168_12 and arg_165_1.time_ < var_168_3 + var_168_12 + arg_168_0 then
				arg_165_1.fswtw_.percent = var_168_8

				arg_165_1.fswtw_:SetDirty()
				arg_165_1:ShowNextGo(true)

				arg_165_1.typewritterCharCountI18N = var_168_9
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play222091042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 222091042
		arg_169_1.duration_ = 2.68

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play222091043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.fswbg_:SetActive(true)
				arg_169_1.dialog_:SetActive(false)

				arg_169_1.fswtw_.percent = 0

				local var_172_1 = arg_169_1:GetWordFromCfg(222091042)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.fswt_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.fswt_)

				arg_169_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_169_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_169_1.fswtw_:SetDirty()

				arg_169_1.typewritterCharCountI18N = 0

				SetActive(arg_169_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_169_1:ShowNextGo(false)
			end

			local var_172_3 = 0.0166666666666666

			if var_172_3 < arg_169_1.time_ and arg_169_1.time_ <= var_172_3 + arg_172_0 then
				arg_169_1.var_.oldValueTypewriter = arg_169_1.fswtw_.percent

				SetActive(arg_169_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_169_1:ShowNextGo(false)
			end

			local var_172_4 = 35
			local var_172_5 = 2.33333333333333
			local var_172_6 = arg_169_1:GetWordFromCfg(222091042)
			local var_172_7 = arg_169_1:FormatText(var_172_6.content)
			local var_172_8, var_172_9 = arg_169_1:GetPercentByPara(var_172_7, 1)

			if var_172_3 < arg_169_1.time_ and arg_169_1.time_ <= var_172_3 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				local var_172_10 = var_172_4 <= 0 and var_172_5 or var_172_5 * ((var_172_9 - arg_169_1.typewritterCharCountI18N) / var_172_4)

				if var_172_10 > 0 and var_172_5 < var_172_10 then
					arg_169_1.talkMaxDuration = var_172_10

					if var_172_10 + var_172_3 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_3
					end
				end
			end

			local var_172_11 = 2.33333333333333
			local var_172_12 = math.max(var_172_11, arg_169_1.talkMaxDuration)

			if var_172_3 <= arg_169_1.time_ and arg_169_1.time_ < var_172_3 + var_172_12 then
				local var_172_13 = (arg_169_1.time_ - var_172_3) / var_172_12

				arg_169_1.fswtw_.percent = Mathf.Lerp(arg_169_1.var_.oldValueTypewriter, var_172_8, var_172_13)
				arg_169_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_169_1.fswtw_:SetDirty()
			end

			if arg_169_1.time_ >= var_172_3 + var_172_12 and arg_169_1.time_ < var_172_3 + var_172_12 + arg_172_0 then
				arg_169_1.fswtw_.percent = var_172_8

				arg_169_1.fswtw_:SetDirty()
				arg_169_1:ShowNextGo(true)

				arg_169_1.typewritterCharCountI18N = var_172_9
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play222091043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 222091043
		arg_173_1.duration_ = 9

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play222091044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = "ST47"

			if arg_173_1.bgs_[var_176_0] == nil then
				local var_176_1 = Object.Instantiate(arg_173_1.paintGo_)

				var_176_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_176_0)
				var_176_1.name = var_176_0
				var_176_1.transform.parent = arg_173_1.stage_.transform
				var_176_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_173_1.bgs_[var_176_0] = var_176_1
			end

			local var_176_2 = 2

			if var_176_2 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				local var_176_3 = manager.ui.mainCamera.transform.localPosition
				local var_176_4 = Vector3.New(0, 0, 10) + Vector3.New(var_176_3.x, var_176_3.y, 0)
				local var_176_5 = arg_173_1.bgs_.ST47

				var_176_5.transform.localPosition = var_176_4
				var_176_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_176_6 = var_176_5:GetComponent("SpriteRenderer")

				if var_176_6 and var_176_6.sprite then
					local var_176_7 = (var_176_5.transform.localPosition - var_176_3).z
					local var_176_8 = manager.ui.mainCameraCom_
					local var_176_9 = 2 * var_176_7 * Mathf.Tan(var_176_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_176_10 = var_176_9 * var_176_8.aspect
					local var_176_11 = var_176_6.sprite.bounds.size.x
					local var_176_12 = var_176_6.sprite.bounds.size.y
					local var_176_13 = var_176_10 / var_176_11
					local var_176_14 = var_176_9 / var_176_12
					local var_176_15 = var_176_14 < var_176_13 and var_176_13 or var_176_14

					var_176_5.transform.localScale = Vector3.New(var_176_15, var_176_15, 0)
				end

				for iter_176_0, iter_176_1 in pairs(arg_173_1.bgs_) do
					if iter_176_0 ~= "ST47" then
						iter_176_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_176_16 = 0

			if var_176_16 < arg_173_1.time_ and arg_173_1.time_ <= var_176_16 + arg_176_0 then
				arg_173_1.mask_.enabled = true
				arg_173_1.mask_.raycastTarget = true

				arg_173_1:SetGaussion(false)
			end

			local var_176_17 = 2

			if var_176_16 <= arg_173_1.time_ and arg_173_1.time_ < var_176_16 + var_176_17 then
				local var_176_18 = (arg_173_1.time_ - var_176_16) / var_176_17
				local var_176_19 = Color.New(0, 0, 0)

				var_176_19.a = Mathf.Lerp(0, 1, var_176_18)
				arg_173_1.mask_.color = var_176_19
			end

			if arg_173_1.time_ >= var_176_16 + var_176_17 and arg_173_1.time_ < var_176_16 + var_176_17 + arg_176_0 then
				local var_176_20 = Color.New(0, 0, 0)

				var_176_20.a = 1
				arg_173_1.mask_.color = var_176_20
			end

			local var_176_21 = 2

			if var_176_21 < arg_173_1.time_ and arg_173_1.time_ <= var_176_21 + arg_176_0 then
				arg_173_1.mask_.enabled = true
				arg_173_1.mask_.raycastTarget = true

				arg_173_1:SetGaussion(false)
			end

			local var_176_22 = 2

			if var_176_21 <= arg_173_1.time_ and arg_173_1.time_ < var_176_21 + var_176_22 then
				local var_176_23 = (arg_173_1.time_ - var_176_21) / var_176_22
				local var_176_24 = Color.New(0, 0, 0)

				var_176_24.a = Mathf.Lerp(1, 0, var_176_23)
				arg_173_1.mask_.color = var_176_24
			end

			if arg_173_1.time_ >= var_176_21 + var_176_22 and arg_173_1.time_ < var_176_21 + var_176_22 + arg_176_0 then
				local var_176_25 = Color.New(0, 0, 0)
				local var_176_26 = 0

				arg_173_1.mask_.enabled = false
				var_176_25.a = var_176_26
				arg_173_1.mask_.color = var_176_25
			end

			local var_176_27 = 1.98333333333333

			if var_176_27 < arg_173_1.time_ and arg_173_1.time_ <= var_176_27 + arg_176_0 then
				arg_173_1.fswbg_:SetActive(false)
				arg_173_1.dialog_:SetActive(false)
				SetActive(arg_173_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_173_1:ShowNextGo(false)
			end

			if arg_173_1.frameCnt_ <= 1 then
				arg_173_1.dialog_:SetActive(false)
			end

			local var_176_28 = 4
			local var_176_29 = 0.4

			if var_176_28 < arg_173_1.time_ and arg_173_1.time_ <= var_176_28 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0

				arg_173_1.dialog_:SetActive(true)

				arg_173_1.dialogCg_.alpha = 0

				local var_176_30 = LeanTween.value(arg_173_1.dialog_, 0, 1, 0.3)

				var_176_30:setOnUpdate(LuaHelper.FloatAction(function(arg_177_0)
					arg_173_1.dialogCg_.alpha = arg_177_0
				end))
				var_176_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_173_1.dialog_)
					var_176_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_173_1.duration_ = arg_173_1.duration_ + 0.3

				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_31 = arg_173_1:GetWordFromCfg(222091043)
				local var_176_32 = arg_173_1:FormatText(var_176_31.content)

				arg_173_1.text_.text = var_176_32

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_33 = 16
				local var_176_34 = utf8.len(var_176_32)
				local var_176_35 = var_176_33 <= 0 and var_176_29 or var_176_29 * (var_176_34 / var_176_33)

				if var_176_35 > 0 and var_176_29 < var_176_35 then
					arg_173_1.talkMaxDuration = var_176_35
					var_176_28 = var_176_28 + 0.3

					if var_176_35 + var_176_28 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_35 + var_176_28
					end
				end

				arg_173_1.text_.text = var_176_32
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_36 = var_176_28 + 0.3
			local var_176_37 = math.max(var_176_29, arg_173_1.talkMaxDuration)

			if var_176_36 <= arg_173_1.time_ and arg_173_1.time_ < var_176_36 + var_176_37 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_36) / var_176_37

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_36 + var_176_37 and arg_173_1.time_ < var_176_36 + var_176_37 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play222091044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 222091044
		arg_179_1.duration_ = 11.23

		local var_179_0 = {
			ja = 10.4,
			ko = 11.233,
			zh = 11.233
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
				arg_179_0:Play222091045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 1.15

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[473].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:GetWordFromCfg(222091044)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 46
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091044", "story_v_out_222091.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_222091", "222091044", "story_v_out_222091.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_222091", "222091044", "story_v_out_222091.awb")

						arg_179_1:RecordAudio("222091044", var_182_9)
						arg_179_1:RecordAudio("222091044", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_222091", "222091044", "story_v_out_222091.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_222091", "222091044", "story_v_out_222091.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_10 and arg_179_1.time_ < var_182_0 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play222091045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 222091045
		arg_183_1.duration_ = 17

		local var_183_0 = {
			ja = 17,
			ko = 14.733,
			zh = 14.733
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
				arg_183_0:Play222091046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 1.55

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[473].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:GetWordFromCfg(222091045)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 62
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091045", "story_v_out_222091.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_222091", "222091045", "story_v_out_222091.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_222091", "222091045", "story_v_out_222091.awb")

						arg_183_1:RecordAudio("222091045", var_186_9)
						arg_183_1:RecordAudio("222091045", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_222091", "222091045", "story_v_out_222091.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_222091", "222091045", "story_v_out_222091.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_10 and arg_183_1.time_ < var_186_0 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play222091046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 222091046
		arg_187_1.duration_ = 23.73

		local var_187_0 = {
			ja = 23.733,
			ko = 17.2,
			zh = 17.2
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
				arg_187_0:Play222091047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 1.95

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[473].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:GetWordFromCfg(222091046)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 78
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

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091046", "story_v_out_222091.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_222091", "222091046", "story_v_out_222091.awb") / 1000

					if var_190_8 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_0
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_out_222091", "222091046", "story_v_out_222091.awb")

						arg_187_1:RecordAudio("222091046", var_190_9)
						arg_187_1:RecordAudio("222091046", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_222091", "222091046", "story_v_out_222091.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_222091", "222091046", "story_v_out_222091.awb")
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
	Play222091047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 222091047
		arg_191_1.duration_ = 15.6

		local var_191_0 = {
			ja = 15.6,
			ko = 11.2,
			zh = 11.2
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
				arg_191_0:Play222091048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 1.325

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[473].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:GetWordFromCfg(222091047)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 53
				local var_194_6 = utf8.len(var_194_4)
				local var_194_7 = var_194_5 <= 0 and var_194_1 or var_194_1 * (var_194_6 / var_194_5)

				if var_194_7 > 0 and var_194_1 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_4
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091047", "story_v_out_222091.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_222091", "222091047", "story_v_out_222091.awb") / 1000

					if var_194_8 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_0
					end

					if var_194_3.prefab_name ~= "" and arg_191_1.actors_[var_194_3.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_3.prefab_name].transform, "story_v_out_222091", "222091047", "story_v_out_222091.awb")

						arg_191_1:RecordAudio("222091047", var_194_9)
						arg_191_1:RecordAudio("222091047", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_222091", "222091047", "story_v_out_222091.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_222091", "222091047", "story_v_out_222091.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_10 and arg_191_1.time_ < var_194_0 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play222091048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 222091048
		arg_195_1.duration_ = 20.63

		local var_195_0 = {
			ja = 20.633,
			ko = 12.9,
			zh = 12.866
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
				arg_195_0:Play222091049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 1.45

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[473].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:GetWordFromCfg(222091048)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 58
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

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091048", "story_v_out_222091.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_222091", "222091048", "story_v_out_222091.awb") / 1000

					if var_198_8 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_0
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_222091", "222091048", "story_v_out_222091.awb")

						arg_195_1:RecordAudio("222091048", var_198_9)
						arg_195_1:RecordAudio("222091048", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_222091", "222091048", "story_v_out_222091.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_222091", "222091048", "story_v_out_222091.awb")
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
	Play222091049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 222091049
		arg_199_1.duration_ = 12.83

		local var_199_0 = {
			ja = 12.833,
			ko = 7.266,
			zh = 7.266
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
				arg_199_0:Play222091050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = manager.ui.mainCamera.transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.shakeOldPos = var_202_0.localPosition
			end

			local var_202_2 = 0.6

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / 0.066
				local var_202_4, var_202_5 = math.modf(var_202_3)

				var_202_0.localPosition = Vector3.New(var_202_5 * 0.13, var_202_5 * 0.13, var_202_5 * 0.13) + arg_199_1.var_.shakeOldPos
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 then
				var_202_0.localPosition = arg_199_1.var_.shakeOldPos
			end

			local var_202_6 = 0

			if var_202_6 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.allBtn_.enabled = false
			end

			local var_202_7 = 0.6

			if arg_199_1.time_ >= var_202_6 + var_202_7 and arg_199_1.time_ < var_202_6 + var_202_7 + arg_202_0 then
				arg_199_1.allBtn_.enabled = true
			end

			local var_202_8 = 0
			local var_202_9 = 0.7

			if var_202_8 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_10 = arg_199_1:FormatText(StoryNameCfg[473].name)

				arg_199_1.leftNameTxt_.text = var_202_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_11 = arg_199_1:GetWordFromCfg(222091049)
				local var_202_12 = arg_199_1:FormatText(var_202_11.content)

				arg_199_1.text_.text = var_202_12

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_13 = 28
				local var_202_14 = utf8.len(var_202_12)
				local var_202_15 = var_202_13 <= 0 and var_202_9 or var_202_9 * (var_202_14 / var_202_13)

				if var_202_15 > 0 and var_202_9 < var_202_15 then
					arg_199_1.talkMaxDuration = var_202_15

					if var_202_15 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_15 + var_202_8
					end
				end

				arg_199_1.text_.text = var_202_12
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091049", "story_v_out_222091.awb") ~= 0 then
					local var_202_16 = manager.audio:GetVoiceLength("story_v_out_222091", "222091049", "story_v_out_222091.awb") / 1000

					if var_202_16 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_16 + var_202_8
					end

					if var_202_11.prefab_name ~= "" and arg_199_1.actors_[var_202_11.prefab_name] ~= nil then
						local var_202_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_11.prefab_name].transform, "story_v_out_222091", "222091049", "story_v_out_222091.awb")

						arg_199_1:RecordAudio("222091049", var_202_17)
						arg_199_1:RecordAudio("222091049", var_202_17)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_222091", "222091049", "story_v_out_222091.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_222091", "222091049", "story_v_out_222091.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_18 = math.max(var_202_9, arg_199_1.talkMaxDuration)

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_18 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_8) / var_202_18

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_8 + var_202_18 and arg_199_1.time_ < var_202_8 + var_202_18 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play222091050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 222091050
		arg_203_1.duration_ = 11.5

		local var_203_0 = {
			ja = 11.5,
			ko = 10.933,
			zh = 10.933
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
				arg_203_0:Play222091051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1074ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos1074ui_story = var_206_0.localPosition
			end

			local var_206_2 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2
				local var_206_4 = Vector3.New(0, -1.055, -6.12)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1074ui_story, var_206_4, var_206_3)

				local var_206_5 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_5.x, var_206_5.y, var_206_5.z)

				local var_206_6 = var_206_0.localEulerAngles

				var_206_6.z = 0
				var_206_6.x = 0
				var_206_0.localEulerAngles = var_206_6
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_206_7 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_7.x, var_206_7.y, var_206_7.z)

				local var_206_8 = var_206_0.localEulerAngles

				var_206_8.z = 0
				var_206_8.x = 0
				var_206_0.localEulerAngles = var_206_8
			end

			local var_206_9 = arg_203_1.actors_["1074ui_story"]
			local var_206_10 = 0

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect1074ui_story == nil then
				arg_203_1.var_.characterEffect1074ui_story = var_206_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_11 = 0.200000002980232

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_11 and not isNil(var_206_9) then
				local var_206_12 = (arg_203_1.time_ - var_206_10) / var_206_11

				if arg_203_1.var_.characterEffect1074ui_story and not isNil(var_206_9) then
					arg_203_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_10 + var_206_11 and arg_203_1.time_ < var_206_10 + var_206_11 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect1074ui_story then
				arg_203_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_206_13 = 0

			if var_206_13 < arg_203_1.time_ and arg_203_1.time_ <= var_206_13 + arg_206_0 then
				arg_203_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_206_14 = 0

			if var_206_14 < arg_203_1.time_ and arg_203_1.time_ <= var_206_14 + arg_206_0 then
				arg_203_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_15 = 0
			local var_206_16 = 1.05

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_17 = arg_203_1:FormatText(StoryNameCfg[410].name)

				arg_203_1.leftNameTxt_.text = var_206_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_18 = arg_203_1:GetWordFromCfg(222091050)
				local var_206_19 = arg_203_1:FormatText(var_206_18.content)

				arg_203_1.text_.text = var_206_19

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_20 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091050", "story_v_out_222091.awb") ~= 0 then
					local var_206_23 = manager.audio:GetVoiceLength("story_v_out_222091", "222091050", "story_v_out_222091.awb") / 1000

					if var_206_23 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_23 + var_206_15
					end

					if var_206_18.prefab_name ~= "" and arg_203_1.actors_[var_206_18.prefab_name] ~= nil then
						local var_206_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_18.prefab_name].transform, "story_v_out_222091", "222091050", "story_v_out_222091.awb")

						arg_203_1:RecordAudio("222091050", var_206_24)
						arg_203_1:RecordAudio("222091050", var_206_24)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_222091", "222091050", "story_v_out_222091.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_222091", "222091050", "story_v_out_222091.awb")
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
				actorName = "1074ui_story",
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
	Play222091051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 222091051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play222091052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1074ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos1074ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(0, 100, 0)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1074ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0, 100, 0)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["1074ui_story"]
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect1074ui_story == nil then
				arg_207_1.var_.characterEffect1074ui_story = var_210_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_11 = 0.200000002980232

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_11 and not isNil(var_210_9) then
				local var_210_12 = (arg_207_1.time_ - var_210_10) / var_210_11

				if arg_207_1.var_.characterEffect1074ui_story and not isNil(var_210_9) then
					local var_210_13 = Mathf.Lerp(0, 0.5, var_210_12)

					arg_207_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1074ui_story.fillRatio = var_210_13
				end
			end

			if arg_207_1.time_ >= var_210_10 + var_210_11 and arg_207_1.time_ < var_210_10 + var_210_11 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect1074ui_story then
				local var_210_14 = 0.5

				arg_207_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1074ui_story.fillRatio = var_210_14
			end

			local var_210_15 = 0
			local var_210_16 = 0.85

			if var_210_15 < arg_207_1.time_ and arg_207_1.time_ <= var_210_15 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_17 = arg_207_1:GetWordFromCfg(222091051)
				local var_210_18 = arg_207_1:FormatText(var_210_17.content)

				arg_207_1.text_.text = var_210_18

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_19 = 34
				local var_210_20 = utf8.len(var_210_18)
				local var_210_21 = var_210_19 <= 0 and var_210_16 or var_210_16 * (var_210_20 / var_210_19)

				if var_210_21 > 0 and var_210_16 < var_210_21 then
					arg_207_1.talkMaxDuration = var_210_21

					if var_210_21 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_21 + var_210_15
					end
				end

				arg_207_1.text_.text = var_210_18
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_22 = math.max(var_210_16, arg_207_1.talkMaxDuration)

			if var_210_15 <= arg_207_1.time_ and arg_207_1.time_ < var_210_15 + var_210_22 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_15) / var_210_22

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_15 + var_210_22 and arg_207_1.time_ < var_210_15 + var_210_22 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222091052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 222091052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play222091053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 1.4

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:GetWordFromCfg(222091052)
				local var_214_3 = arg_211_1:FormatText(var_214_2.content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 56
				local var_214_5 = utf8.len(var_214_3)
				local var_214_6 = var_214_4 <= 0 and var_214_1 or var_214_1 * (var_214_5 / var_214_4)

				if var_214_6 > 0 and var_214_1 < var_214_6 then
					arg_211_1.talkMaxDuration = var_214_6

					if var_214_6 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_7 and arg_211_1.time_ < var_214_0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play222091053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 222091053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play222091054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 0.875

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_2 = arg_215_1:GetWordFromCfg(222091053)
				local var_218_3 = arg_215_1:FormatText(var_218_2.content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 35
				local var_218_5 = utf8.len(var_218_3)
				local var_218_6 = var_218_4 <= 0 and var_218_1 or var_218_1 * (var_218_5 / var_218_4)

				if var_218_6 > 0 and var_218_1 < var_218_6 then
					arg_215_1.talkMaxDuration = var_218_6

					if var_218_6 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_7 and arg_215_1.time_ < var_218_0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play222091054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 222091054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play222091055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.925

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_2 = arg_219_1:GetWordFromCfg(222091054)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 37
				local var_222_5 = utf8.len(var_222_3)
				local var_222_6 = var_222_4 <= 0 and var_222_1 or var_222_1 * (var_222_5 / var_222_4)

				if var_222_6 > 0 and var_222_1 < var_222_6 then
					arg_219_1.talkMaxDuration = var_222_6

					if var_222_6 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_7 and arg_219_1.time_ < var_222_0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play222091055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 222091055
		arg_223_1.duration_ = 12.93

		local var_223_0 = {
			ja = 12.933,
			ko = 9.4,
			zh = 9.4
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
				arg_223_0:Play222091056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1074ui_story"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos1074ui_story = var_226_0.localPosition
			end

			local var_226_2 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2
				local var_226_4 = Vector3.New(0, -1.055, -6.12)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1074ui_story, var_226_4, var_226_3)

				local var_226_5 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_5.x, var_226_5.y, var_226_5.z)

				local var_226_6 = var_226_0.localEulerAngles

				var_226_6.z = 0
				var_226_6.x = 0
				var_226_0.localEulerAngles = var_226_6
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_226_7 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_7.x, var_226_7.y, var_226_7.z)

				local var_226_8 = var_226_0.localEulerAngles

				var_226_8.z = 0
				var_226_8.x = 0
				var_226_0.localEulerAngles = var_226_8
			end

			local var_226_9 = arg_223_1.actors_["1074ui_story"]
			local var_226_10 = 0

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect1074ui_story == nil then
				arg_223_1.var_.characterEffect1074ui_story = var_226_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_11 = 0.200000002980232

			if var_226_10 <= arg_223_1.time_ and arg_223_1.time_ < var_226_10 + var_226_11 and not isNil(var_226_9) then
				local var_226_12 = (arg_223_1.time_ - var_226_10) / var_226_11

				if arg_223_1.var_.characterEffect1074ui_story and not isNil(var_226_9) then
					local var_226_13 = Mathf.Lerp(0, 0.5, var_226_12)

					arg_223_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1074ui_story.fillRatio = var_226_13
				end
			end

			if arg_223_1.time_ >= var_226_10 + var_226_11 and arg_223_1.time_ < var_226_10 + var_226_11 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect1074ui_story then
				local var_226_14 = 0.5

				arg_223_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1074ui_story.fillRatio = var_226_14
			end

			local var_226_15 = 0
			local var_226_16 = 1.175

			if var_226_15 < arg_223_1.time_ and arg_223_1.time_ <= var_226_15 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_17 = arg_223_1:FormatText(StoryNameCfg[473].name)

				arg_223_1.leftNameTxt_.text = var_226_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_18 = arg_223_1:GetWordFromCfg(222091055)
				local var_226_19 = arg_223_1:FormatText(var_226_18.content)

				arg_223_1.text_.text = var_226_19

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_20 = 47
				local var_226_21 = utf8.len(var_226_19)
				local var_226_22 = var_226_20 <= 0 and var_226_16 or var_226_16 * (var_226_21 / var_226_20)

				if var_226_22 > 0 and var_226_16 < var_226_22 then
					arg_223_1.talkMaxDuration = var_226_22

					if var_226_22 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_22 + var_226_15
					end
				end

				arg_223_1.text_.text = var_226_19
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091055", "story_v_out_222091.awb") ~= 0 then
					local var_226_23 = manager.audio:GetVoiceLength("story_v_out_222091", "222091055", "story_v_out_222091.awb") / 1000

					if var_226_23 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_23 + var_226_15
					end

					if var_226_18.prefab_name ~= "" and arg_223_1.actors_[var_226_18.prefab_name] ~= nil then
						local var_226_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_18.prefab_name].transform, "story_v_out_222091", "222091055", "story_v_out_222091.awb")

						arg_223_1:RecordAudio("222091055", var_226_24)
						arg_223_1:RecordAudio("222091055", var_226_24)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_222091", "222091055", "story_v_out_222091.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_222091", "222091055", "story_v_out_222091.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_25 = math.max(var_226_16, arg_223_1.talkMaxDuration)

			if var_226_15 <= arg_223_1.time_ and arg_223_1.time_ < var_226_15 + var_226_25 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_15) / var_226_25

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_15 + var_226_25 and arg_223_1.time_ < var_226_15 + var_226_25 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222091056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 222091056
		arg_227_1.duration_ = 14.4

		local var_227_0 = {
			ja = 14.4,
			ko = 9.2,
			zh = 9.2
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
				arg_227_0:Play222091057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 1.175

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[473].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:GetWordFromCfg(222091056)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 47
				local var_230_6 = utf8.len(var_230_4)
				local var_230_7 = var_230_5 <= 0 and var_230_1 or var_230_1 * (var_230_6 / var_230_5)

				if var_230_7 > 0 and var_230_1 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_4
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091056", "story_v_out_222091.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_222091", "222091056", "story_v_out_222091.awb") / 1000

					if var_230_8 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_0
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_out_222091", "222091056", "story_v_out_222091.awb")

						arg_227_1:RecordAudio("222091056", var_230_9)
						arg_227_1:RecordAudio("222091056", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_222091", "222091056", "story_v_out_222091.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_222091", "222091056", "story_v_out_222091.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_10 and arg_227_1.time_ < var_230_0 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play222091057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 222091057
		arg_231_1.duration_ = 6.6

		local var_231_0 = {
			ja = 6.6,
			ko = 4.3,
			zh = 4.3
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
				arg_231_0:Play222091058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1074ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1074ui_story == nil then
				arg_231_1.var_.characterEffect1074ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect1074ui_story and not isNil(var_234_0) then
					arg_231_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1074ui_story then
				arg_231_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_234_4 = 0

			if var_234_4 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_234_5 = 0

			if var_234_5 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_234_6 = 0
			local var_234_7 = 0.5

			if var_234_6 < arg_231_1.time_ and arg_231_1.time_ <= var_234_6 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_8 = arg_231_1:FormatText(StoryNameCfg[410].name)

				arg_231_1.leftNameTxt_.text = var_234_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_9 = arg_231_1:GetWordFromCfg(222091057)
				local var_234_10 = arg_231_1:FormatText(var_234_9.content)

				arg_231_1.text_.text = var_234_10

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_11 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091057", "story_v_out_222091.awb") ~= 0 then
					local var_234_14 = manager.audio:GetVoiceLength("story_v_out_222091", "222091057", "story_v_out_222091.awb") / 1000

					if var_234_14 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_14 + var_234_6
					end

					if var_234_9.prefab_name ~= "" and arg_231_1.actors_[var_234_9.prefab_name] ~= nil then
						local var_234_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_9.prefab_name].transform, "story_v_out_222091", "222091057", "story_v_out_222091.awb")

						arg_231_1:RecordAudio("222091057", var_234_15)
						arg_231_1:RecordAudio("222091057", var_234_15)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_222091", "222091057", "story_v_out_222091.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_222091", "222091057", "story_v_out_222091.awb")
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
	Play222091058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 222091058
		arg_235_1.duration_ = 9.2

		local var_235_0 = {
			ja = 9.2,
			ko = 5.6,
			zh = 5.6
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
				arg_235_0:Play222091059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1074ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1074ui_story == nil then
				arg_235_1.var_.characterEffect1074ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect1074ui_story and not isNil(var_238_0) then
					local var_238_4 = Mathf.Lerp(0, 0.5, var_238_3)

					arg_235_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1074ui_story.fillRatio = var_238_4
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1074ui_story then
				local var_238_5 = 0.5

				arg_235_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1074ui_story.fillRatio = var_238_5
			end

			local var_238_6 = 0
			local var_238_7 = 0.575

			if var_238_6 < arg_235_1.time_ and arg_235_1.time_ <= var_238_6 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_8 = arg_235_1:FormatText(StoryNameCfg[473].name)

				arg_235_1.leftNameTxt_.text = var_238_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_9 = arg_235_1:GetWordFromCfg(222091058)
				local var_238_10 = arg_235_1:FormatText(var_238_9.content)

				arg_235_1.text_.text = var_238_10

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_11 = 23
				local var_238_12 = utf8.len(var_238_10)
				local var_238_13 = var_238_11 <= 0 and var_238_7 or var_238_7 * (var_238_12 / var_238_11)

				if var_238_13 > 0 and var_238_7 < var_238_13 then
					arg_235_1.talkMaxDuration = var_238_13

					if var_238_13 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_13 + var_238_6
					end
				end

				arg_235_1.text_.text = var_238_10
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091058", "story_v_out_222091.awb") ~= 0 then
					local var_238_14 = manager.audio:GetVoiceLength("story_v_out_222091", "222091058", "story_v_out_222091.awb") / 1000

					if var_238_14 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_14 + var_238_6
					end

					if var_238_9.prefab_name ~= "" and arg_235_1.actors_[var_238_9.prefab_name] ~= nil then
						local var_238_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_9.prefab_name].transform, "story_v_out_222091", "222091058", "story_v_out_222091.awb")

						arg_235_1:RecordAudio("222091058", var_238_15)
						arg_235_1:RecordAudio("222091058", var_238_15)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_222091", "222091058", "story_v_out_222091.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_222091", "222091058", "story_v_out_222091.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_16 = math.max(var_238_7, arg_235_1.talkMaxDuration)

			if var_238_6 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_16 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_6) / var_238_16

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_6 + var_238_16 and arg_235_1.time_ < var_238_6 + var_238_16 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play222091059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 222091059
		arg_239_1.duration_ = 6.77

		local var_239_0 = {
			ja = 6.366,
			ko = 6.766,
			zh = 6.766
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
				arg_239_0:Play222091060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.65

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[473].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:GetWordFromCfg(222091059)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 26
				local var_242_6 = utf8.len(var_242_4)
				local var_242_7 = var_242_5 <= 0 and var_242_1 or var_242_1 * (var_242_6 / var_242_5)

				if var_242_7 > 0 and var_242_1 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091059", "story_v_out_222091.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_222091", "222091059", "story_v_out_222091.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_222091", "222091059", "story_v_out_222091.awb")

						arg_239_1:RecordAudio("222091059", var_242_9)
						arg_239_1:RecordAudio("222091059", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_222091", "222091059", "story_v_out_222091.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_222091", "222091059", "story_v_out_222091.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_10 and arg_239_1.time_ < var_242_0 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play222091060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 222091060
		arg_243_1.duration_ = 4.43

		local var_243_0 = {
			ja = 4.433,
			ko = 3.1,
			zh = 3.1
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
				arg_243_0:Play222091061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1074ui_story"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1074ui_story == nil then
				arg_243_1.var_.characterEffect1074ui_story = var_246_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.characterEffect1074ui_story and not isNil(var_246_0) then
					arg_243_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1074ui_story then
				arg_243_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_246_4 = 0

			if var_246_4 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			local var_246_5 = 0

			if var_246_5 < arg_243_1.time_ and arg_243_1.time_ <= var_246_5 + arg_246_0 then
				arg_243_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_246_6 = 0
			local var_246_7 = 0.3

			if var_246_6 < arg_243_1.time_ and arg_243_1.time_ <= var_246_6 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_8 = arg_243_1:FormatText(StoryNameCfg[410].name)

				arg_243_1.leftNameTxt_.text = var_246_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_9 = arg_243_1:GetWordFromCfg(222091060)
				local var_246_10 = arg_243_1:FormatText(var_246_9.content)

				arg_243_1.text_.text = var_246_10

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_11 = 12
				local var_246_12 = utf8.len(var_246_10)
				local var_246_13 = var_246_11 <= 0 and var_246_7 or var_246_7 * (var_246_12 / var_246_11)

				if var_246_13 > 0 and var_246_7 < var_246_13 then
					arg_243_1.talkMaxDuration = var_246_13

					if var_246_13 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_13 + var_246_6
					end
				end

				arg_243_1.text_.text = var_246_10
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222091", "222091060", "story_v_out_222091.awb") ~= 0 then
					local var_246_14 = manager.audio:GetVoiceLength("story_v_out_222091", "222091060", "story_v_out_222091.awb") / 1000

					if var_246_14 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_14 + var_246_6
					end

					if var_246_9.prefab_name ~= "" and arg_243_1.actors_[var_246_9.prefab_name] ~= nil then
						local var_246_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_9.prefab_name].transform, "story_v_out_222091", "222091060", "story_v_out_222091.awb")

						arg_243_1:RecordAudio("222091060", var_246_15)
						arg_243_1:RecordAudio("222091060", var_246_15)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_222091", "222091060", "story_v_out_222091.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_222091", "222091060", "story_v_out_222091.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_16 = math.max(var_246_7, arg_243_1.talkMaxDuration)

			if var_246_6 <= arg_243_1.time_ and arg_243_1.time_ < var_246_6 + var_246_16 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_6) / var_246_16

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_6 + var_246_16 and arg_243_1.time_ < var_246_6 + var_246_16 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play222091061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 222091061
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play222091062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1074ui_story"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos1074ui_story = var_250_0.localPosition
			end

			local var_250_2 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2
				local var_250_4 = Vector3.New(0, 100, 0)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1074ui_story, var_250_4, var_250_3)

				local var_250_5 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_5.x, var_250_5.y, var_250_5.z)

				local var_250_6 = var_250_0.localEulerAngles

				var_250_6.z = 0
				var_250_6.x = 0
				var_250_0.localEulerAngles = var_250_6
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(0, 100, 0)

				local var_250_7 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_7.x, var_250_7.y, var_250_7.z)

				local var_250_8 = var_250_0.localEulerAngles

				var_250_8.z = 0
				var_250_8.x = 0
				var_250_0.localEulerAngles = var_250_8
			end

			local var_250_9 = arg_247_1.actors_["1074ui_story"]
			local var_250_10 = 0

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect1074ui_story == nil then
				arg_247_1.var_.characterEffect1074ui_story = var_250_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_11 = 0.200000002980232

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_11 and not isNil(var_250_9) then
				local var_250_12 = (arg_247_1.time_ - var_250_10) / var_250_11

				if arg_247_1.var_.characterEffect1074ui_story and not isNil(var_250_9) then
					local var_250_13 = Mathf.Lerp(0, 0.5, var_250_12)

					arg_247_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1074ui_story.fillRatio = var_250_13
				end
			end

			if arg_247_1.time_ >= var_250_10 + var_250_11 and arg_247_1.time_ < var_250_10 + var_250_11 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect1074ui_story then
				local var_250_14 = 0.5

				arg_247_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1074ui_story.fillRatio = var_250_14
			end

			local var_250_15 = 0
			local var_250_16 = 1

			if var_250_15 < arg_247_1.time_ and arg_247_1.time_ <= var_250_15 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_17 = arg_247_1:GetWordFromCfg(222091061)
				local var_250_18 = arg_247_1:FormatText(var_250_17.content)

				arg_247_1.text_.text = var_250_18

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_19 = 40
				local var_250_20 = utf8.len(var_250_18)
				local var_250_21 = var_250_19 <= 0 and var_250_16 or var_250_16 * (var_250_20 / var_250_19)

				if var_250_21 > 0 and var_250_16 < var_250_21 then
					arg_247_1.talkMaxDuration = var_250_21

					if var_250_21 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_21 + var_250_15
					end
				end

				arg_247_1.text_.text = var_250_18
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_22 = math.max(var_250_16, arg_247_1.talkMaxDuration)

			if var_250_15 <= arg_247_1.time_ and arg_247_1.time_ < var_250_15 + var_250_22 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_15) / var_250_22

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_15 + var_250_22 and arg_247_1.time_ < var_250_15 + var_250_22 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222091062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 222091062
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
			local var_254_0 = 0
			local var_254_1 = 0.725

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_2 = arg_251_1:GetWordFromCfg(222091062)
				local var_254_3 = arg_251_1:FormatText(var_254_2.content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 29
				local var_254_5 = utf8.len(var_254_3)
				local var_254_6 = var_254_4 <= 0 and var_254_1 or var_254_1 * (var_254_5 / var_254_4)

				if var_254_6 > 0 and var_254_1 < var_254_6 then
					arg_251_1.talkMaxDuration = var_254_6

					if var_254_6 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_6 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_7 and arg_251_1.time_ < var_254_0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J13f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST47"
	},
	voices = {
		"story_v_out_222091.awb"
	}
}
