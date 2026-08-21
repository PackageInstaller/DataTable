return {
	Play121501001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 121501001
		arg_1_1.duration_ = 12.8

		local var_1_0 = {
			ja = 9.533,
			ko = 12.8,
			zh = 12.8
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
				arg_1_0:Play121501002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST18a"

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
				local var_4_5 = arg_1_1.bgs_.ST18a

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
					if iter_4_0 ~= "ST18a" then
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
			local var_4_23 = 0.2

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
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

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
			local var_4_35 = 0.8

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

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[319].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(121501001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501001", "story_v_out_121501.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_out_121501", "121501001", "story_v_out_121501.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_121501", "121501001", "story_v_out_121501.awb")

						arg_1_1:RecordAudio("121501001", var_4_44)
						arg_1_1:RecordAudio("121501001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_121501", "121501001", "story_v_out_121501.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_121501", "121501001", "story_v_out_121501.awb")
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
	Play121501002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 121501002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play121501003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.35

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

				local var_12_2 = arg_9_1:GetWordFromCfg(121501002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 54
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
	Play121501003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 121501003
		arg_13_1.duration_ = 2.87

		local var_13_0 = {
			ja = 2.266666666666,
			ko = 2.866,
			zh = 2.866
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
				arg_13_0:Play121501004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1033ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1033ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["1033ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1033ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(-0.7, -1.01, -6.13)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1033ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(-0.7, -1.01, -6.13)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["1033ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1033ui_story == nil then
				arg_13_1.var_.characterEffect1033ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect1033ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1033ui_story then
				arg_13_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_16_20 = "1029ui_story"

			if arg_13_1.actors_[var_16_20] == nil then
				local var_16_21 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_16_21) then
					local var_16_22 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_13_1.stage_.transform)

					var_16_22.name = var_16_20
					var_16_22.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_20] = var_16_22

					local var_16_23 = var_16_22:GetComponentInChildren(typeof(CharacterEffect))

					var_16_23.enabled = true

					local var_16_24 = GameObjectTools.GetOrAddComponent(var_16_22, typeof(DynamicBoneHelper))

					if var_16_24 then
						var_16_24:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_23.transform, false)

					arg_13_1.var_[var_16_20 .. "Animator"] = var_16_23.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_20 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_20 .. "LipSync"] = var_16_23.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_25 = arg_13_1.actors_["1029ui_story"].transform
			local var_16_26 = 0

			if var_16_26 < arg_13_1.time_ and arg_13_1.time_ <= var_16_26 + arg_16_0 then
				arg_13_1.var_.moveOldPos1029ui_story = var_16_25.localPosition
			end

			local var_16_27 = 0.001

			if var_16_26 <= arg_13_1.time_ and arg_13_1.time_ < var_16_26 + var_16_27 then
				local var_16_28 = (arg_13_1.time_ - var_16_26) / var_16_27
				local var_16_29 = Vector3.New(0.7, -1.09, -6.2)

				var_16_25.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1029ui_story, var_16_29, var_16_28)

				local var_16_30 = manager.ui.mainCamera.transform.position - var_16_25.position

				var_16_25.forward = Vector3.New(var_16_30.x, var_16_30.y, var_16_30.z)

				local var_16_31 = var_16_25.localEulerAngles

				var_16_31.z = 0
				var_16_31.x = 0
				var_16_25.localEulerAngles = var_16_31
			end

			if arg_13_1.time_ >= var_16_26 + var_16_27 and arg_13_1.time_ < var_16_26 + var_16_27 + arg_16_0 then
				var_16_25.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_16_32 = manager.ui.mainCamera.transform.position - var_16_25.position

				var_16_25.forward = Vector3.New(var_16_32.x, var_16_32.y, var_16_32.z)

				local var_16_33 = var_16_25.localEulerAngles

				var_16_33.z = 0
				var_16_33.x = 0
				var_16_25.localEulerAngles = var_16_33
			end

			local var_16_34 = arg_13_1.actors_["1029ui_story"]
			local var_16_35 = 0

			if var_16_35 < arg_13_1.time_ and arg_13_1.time_ <= var_16_35 + arg_16_0 and not isNil(var_16_34) and arg_13_1.var_.characterEffect1029ui_story == nil then
				arg_13_1.var_.characterEffect1029ui_story = var_16_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_36 = 0.200000002980232

			if var_16_35 <= arg_13_1.time_ and arg_13_1.time_ < var_16_35 + var_16_36 and not isNil(var_16_34) then
				local var_16_37 = (arg_13_1.time_ - var_16_35) / var_16_36

				if arg_13_1.var_.characterEffect1029ui_story and not isNil(var_16_34) then
					local var_16_38 = Mathf.Lerp(0, 0.5, var_16_37)

					arg_13_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1029ui_story.fillRatio = var_16_38
				end
			end

			if arg_13_1.time_ >= var_16_35 + var_16_36 and arg_13_1.time_ < var_16_35 + var_16_36 + arg_16_0 and not isNil(var_16_34) and arg_13_1.var_.characterEffect1029ui_story then
				local var_16_39 = 0.5

				arg_13_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1029ui_story.fillRatio = var_16_39
			end

			local var_16_40 = 0

			if var_16_40 < arg_13_1.time_ and arg_13_1.time_ <= var_16_40 + arg_16_0 then
				arg_13_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_16_41 = 0

			if var_16_41 < arg_13_1.time_ and arg_13_1.time_ <= var_16_41 + arg_16_0 then
				arg_13_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_16_42 = 0
			local var_16_43 = 0.275

			if var_16_42 < arg_13_1.time_ and arg_13_1.time_ <= var_16_42 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_44 = arg_13_1:FormatText(StoryNameCfg[236].name)

				arg_13_1.leftNameTxt_.text = var_16_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_45 = arg_13_1:GetWordFromCfg(121501003)
				local var_16_46 = arg_13_1:FormatText(var_16_45.content)

				arg_13_1.text_.text = var_16_46

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_47 = 11
				local var_16_48 = utf8.len(var_16_46)
				local var_16_49 = var_16_47 <= 0 and var_16_43 or var_16_43 * (var_16_48 / var_16_47)

				if var_16_49 > 0 and var_16_43 < var_16_49 then
					arg_13_1.talkMaxDuration = var_16_49

					if var_16_49 + var_16_42 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_49 + var_16_42
					end
				end

				arg_13_1.text_.text = var_16_46
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501003", "story_v_out_121501.awb") ~= 0 then
					local var_16_50 = manager.audio:GetVoiceLength("story_v_out_121501", "121501003", "story_v_out_121501.awb") / 1000

					if var_16_50 + var_16_42 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_50 + var_16_42
					end

					if var_16_45.prefab_name ~= "" and arg_13_1.actors_[var_16_45.prefab_name] ~= nil then
						local var_16_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_45.prefab_name].transform, "story_v_out_121501", "121501003", "story_v_out_121501.awb")

						arg_13_1:RecordAudio("121501003", var_16_51)
						arg_13_1:RecordAudio("121501003", var_16_51)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_121501", "121501003", "story_v_out_121501.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_121501", "121501003", "story_v_out_121501.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_52 = math.max(var_16_43, arg_13_1.talkMaxDuration)

			if var_16_42 <= arg_13_1.time_ and arg_13_1.time_ < var_16_42 + var_16_52 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_42) / var_16_52

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_42 + var_16_52 and arg_13_1.time_ < var_16_42 + var_16_52 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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
				actorName = "1029ui_story",
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
	Play121501004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 121501004
		arg_17_1.duration_ = 5.93

		local var_17_0 = {
			ja = 5.933,
			ko = 5.433,
			zh = 5.433
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
				arg_17_0:Play121501005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1033ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1033ui_story == nil then
				arg_17_1.var_.characterEffect1033ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1033ui_story and not isNil(var_20_0) then
					arg_17_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1033ui_story then
				arg_17_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_20_4 = 0

			if var_20_4 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_20_5 = 0
			local var_20_6 = 0.725

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_7 = arg_17_1:FormatText(StoryNameCfg[236].name)

				arg_17_1.leftNameTxt_.text = var_20_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_8 = arg_17_1:GetWordFromCfg(121501004)
				local var_20_9 = arg_17_1:FormatText(var_20_8.content)

				arg_17_1.text_.text = var_20_9

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 29
				local var_20_11 = utf8.len(var_20_9)
				local var_20_12 = var_20_10 <= 0 and var_20_6 or var_20_6 * (var_20_11 / var_20_10)

				if var_20_12 > 0 and var_20_6 < var_20_12 then
					arg_17_1.talkMaxDuration = var_20_12

					if var_20_12 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_9
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501004", "story_v_out_121501.awb") ~= 0 then
					local var_20_13 = manager.audio:GetVoiceLength("story_v_out_121501", "121501004", "story_v_out_121501.awb") / 1000

					if var_20_13 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_5
					end

					if var_20_8.prefab_name ~= "" and arg_17_1.actors_[var_20_8.prefab_name] ~= nil then
						local var_20_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_8.prefab_name].transform, "story_v_out_121501", "121501004", "story_v_out_121501.awb")

						arg_17_1:RecordAudio("121501004", var_20_14)
						arg_17_1:RecordAudio("121501004", var_20_14)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_121501", "121501004", "story_v_out_121501.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_121501", "121501004", "story_v_out_121501.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_15 = math.max(var_20_6, arg_17_1.talkMaxDuration)

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_15 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_5) / var_20_15

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_5 + var_20_15 and arg_17_1.time_ < var_20_5 + var_20_15 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play121501005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 121501005
		arg_21_1.duration_ = 3.2

		local var_21_0 = {
			ja = 3.2,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_21_0:Play121501006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1029ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1029ui_story == nil then
				arg_21_1.var_.characterEffect1029ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1029ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1029ui_story then
				arg_21_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_24_4 = 0

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_6 = arg_21_1.actors_["1033ui_story"]
			local var_24_7 = 0

			if var_24_7 < arg_21_1.time_ and arg_21_1.time_ <= var_24_7 + arg_24_0 and not isNil(var_24_6) and arg_21_1.var_.characterEffect1033ui_story == nil then
				arg_21_1.var_.characterEffect1033ui_story = var_24_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_8 = 0.200000002980232

			if var_24_7 <= arg_21_1.time_ and arg_21_1.time_ < var_24_7 + var_24_8 and not isNil(var_24_6) then
				local var_24_9 = (arg_21_1.time_ - var_24_7) / var_24_8

				if arg_21_1.var_.characterEffect1033ui_story and not isNil(var_24_6) then
					local var_24_10 = Mathf.Lerp(0, 0.5, var_24_9)

					arg_21_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1033ui_story.fillRatio = var_24_10
				end
			end

			if arg_21_1.time_ >= var_24_7 + var_24_8 and arg_21_1.time_ < var_24_7 + var_24_8 + arg_24_0 and not isNil(var_24_6) and arg_21_1.var_.characterEffect1033ui_story then
				local var_24_11 = 0.5

				arg_21_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1033ui_story.fillRatio = var_24_11
			end

			local var_24_12 = 0
			local var_24_13 = 0.225

			if var_24_12 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_14 = arg_21_1:FormatText(StoryNameCfg[319].name)

				arg_21_1.leftNameTxt_.text = var_24_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_15 = arg_21_1:GetWordFromCfg(121501005)
				local var_24_16 = arg_21_1:FormatText(var_24_15.content)

				arg_21_1.text_.text = var_24_16

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_17 = 9
				local var_24_18 = utf8.len(var_24_16)
				local var_24_19 = var_24_17 <= 0 and var_24_13 or var_24_13 * (var_24_18 / var_24_17)

				if var_24_19 > 0 and var_24_13 < var_24_19 then
					arg_21_1.talkMaxDuration = var_24_19

					if var_24_19 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_19 + var_24_12
					end
				end

				arg_21_1.text_.text = var_24_16
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501005", "story_v_out_121501.awb") ~= 0 then
					local var_24_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501005", "story_v_out_121501.awb") / 1000

					if var_24_20 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_20 + var_24_12
					end

					if var_24_15.prefab_name ~= "" and arg_21_1.actors_[var_24_15.prefab_name] ~= nil then
						local var_24_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_15.prefab_name].transform, "story_v_out_121501", "121501005", "story_v_out_121501.awb")

						arg_21_1:RecordAudio("121501005", var_24_21)
						arg_21_1:RecordAudio("121501005", var_24_21)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_121501", "121501005", "story_v_out_121501.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_121501", "121501005", "story_v_out_121501.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_22 = math.max(var_24_13, arg_21_1.talkMaxDuration)

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_22 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_12) / var_24_22

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_12 + var_24_22 and arg_21_1.time_ < var_24_12 + var_24_22 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play121501006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 121501006
		arg_25_1.duration_ = 2

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play121501007(arg_25_1)
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
					arg_25_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1033ui_story then
				arg_25_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_28_4 = 0

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_5 = arg_25_1.actors_["1029ui_story"]
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1029ui_story == nil then
				arg_25_1.var_.characterEffect1029ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_7 = 0.200000002980232

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_7 and not isNil(var_28_5) then
				local var_28_8 = (arg_25_1.time_ - var_28_6) / var_28_7

				if arg_25_1.var_.characterEffect1029ui_story and not isNil(var_28_5) then
					local var_28_9 = Mathf.Lerp(0, 0.5, var_28_8)

					arg_25_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1029ui_story.fillRatio = var_28_9
				end
			end

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1029ui_story then
				local var_28_10 = 0.5

				arg_25_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1029ui_story.fillRatio = var_28_10
			end

			local var_28_11 = 0
			local var_28_12 = 0.1

			if var_28_11 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_13 = arg_25_1:FormatText(StoryNameCfg[236].name)

				arg_25_1.leftNameTxt_.text = var_28_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_14 = arg_25_1:GetWordFromCfg(121501006)
				local var_28_15 = arg_25_1:FormatText(var_28_14.content)

				arg_25_1.text_.text = var_28_15

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_16 = 4
				local var_28_17 = utf8.len(var_28_15)
				local var_28_18 = var_28_16 <= 0 and var_28_12 or var_28_12 * (var_28_17 / var_28_16)

				if var_28_18 > 0 and var_28_12 < var_28_18 then
					arg_25_1.talkMaxDuration = var_28_18

					if var_28_18 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_18 + var_28_11
					end
				end

				arg_25_1.text_.text = var_28_15
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501006", "story_v_out_121501.awb") ~= 0 then
					local var_28_19 = manager.audio:GetVoiceLength("story_v_out_121501", "121501006", "story_v_out_121501.awb") / 1000

					if var_28_19 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_19 + var_28_11
					end

					if var_28_14.prefab_name ~= "" and arg_25_1.actors_[var_28_14.prefab_name] ~= nil then
						local var_28_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_14.prefab_name].transform, "story_v_out_121501", "121501006", "story_v_out_121501.awb")

						arg_25_1:RecordAudio("121501006", var_28_20)
						arg_25_1:RecordAudio("121501006", var_28_20)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_121501", "121501006", "story_v_out_121501.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_121501", "121501006", "story_v_out_121501.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_21 = math.max(var_28_12, arg_25_1.talkMaxDuration)

			if var_28_11 <= arg_25_1.time_ and arg_25_1.time_ < var_28_11 + var_28_21 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_11) / var_28_21

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_11 + var_28_21 and arg_25_1.time_ < var_28_11 + var_28_21 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play121501007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 121501007
		arg_29_1.duration_ = 9.4

		local var_29_0 = {
			ja = 9.4,
			ko = 5.366,
			zh = 5.366
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
				arg_29_0:Play121501008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1029ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1029ui_story == nil then
				arg_29_1.var_.characterEffect1029ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1029ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1029ui_story then
				arg_29_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_32_4 = 0

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_5 = arg_29_1.actors_["1033ui_story"]
			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1033ui_story == nil then
				arg_29_1.var_.characterEffect1033ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_7 = 0.200000002980232

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_7 and not isNil(var_32_5) then
				local var_32_8 = (arg_29_1.time_ - var_32_6) / var_32_7

				if arg_29_1.var_.characterEffect1033ui_story and not isNil(var_32_5) then
					local var_32_9 = Mathf.Lerp(0, 0.5, var_32_8)

					arg_29_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1033ui_story.fillRatio = var_32_9
				end
			end

			if arg_29_1.time_ >= var_32_6 + var_32_7 and arg_29_1.time_ < var_32_6 + var_32_7 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1033ui_story then
				local var_32_10 = 0.5

				arg_29_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1033ui_story.fillRatio = var_32_10
			end

			local var_32_11 = 0
			local var_32_12 = 0.625

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_13 = arg_29_1:FormatText(StoryNameCfg[319].name)

				arg_29_1.leftNameTxt_.text = var_32_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_14 = arg_29_1:GetWordFromCfg(121501007)
				local var_32_15 = arg_29_1:FormatText(var_32_14.content)

				arg_29_1.text_.text = var_32_15

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_16 = 25
				local var_32_17 = utf8.len(var_32_15)
				local var_32_18 = var_32_16 <= 0 and var_32_12 or var_32_12 * (var_32_17 / var_32_16)

				if var_32_18 > 0 and var_32_12 < var_32_18 then
					arg_29_1.talkMaxDuration = var_32_18

					if var_32_18 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_11
					end
				end

				arg_29_1.text_.text = var_32_15
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501007", "story_v_out_121501.awb") ~= 0 then
					local var_32_19 = manager.audio:GetVoiceLength("story_v_out_121501", "121501007", "story_v_out_121501.awb") / 1000

					if var_32_19 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_11
					end

					if var_32_14.prefab_name ~= "" and arg_29_1.actors_[var_32_14.prefab_name] ~= nil then
						local var_32_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_14.prefab_name].transform, "story_v_out_121501", "121501007", "story_v_out_121501.awb")

						arg_29_1:RecordAudio("121501007", var_32_20)
						arg_29_1:RecordAudio("121501007", var_32_20)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_121501", "121501007", "story_v_out_121501.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_121501", "121501007", "story_v_out_121501.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_21 = math.max(var_32_12, arg_29_1.talkMaxDuration)

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_21 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_11) / var_32_21

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_11 + var_32_21 and arg_29_1.time_ < var_32_11 + var_32_21 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play121501008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 121501008
		arg_33_1.duration_ = 14.23

		local var_33_0 = {
			ja = 14.233,
			ko = 8.566,
			zh = 8.566
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
				arg_33_0:Play121501009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1029ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1029ui_story == nil then
				arg_33_1.var_.characterEffect1029ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1029ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1029ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1029ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1029ui_story.fillRatio = var_36_5
			end

			local var_36_6 = arg_33_1.actors_["1033ui_story"]
			local var_36_7 = 0

			if var_36_7 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect1033ui_story == nil then
				arg_33_1.var_.characterEffect1033ui_story = var_36_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_8 = 0.200000002980232

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_8 and not isNil(var_36_6) then
				local var_36_9 = (arg_33_1.time_ - var_36_7) / var_36_8

				if arg_33_1.var_.characterEffect1033ui_story and not isNil(var_36_6) then
					arg_33_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_7 + var_36_8 and arg_33_1.time_ < var_36_7 + var_36_8 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect1033ui_story then
				arg_33_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_36_10 = 0
			local var_36_11 = 0.975

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_12 = arg_33_1:FormatText(StoryNameCfg[236].name)

				arg_33_1.leftNameTxt_.text = var_36_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_13 = arg_33_1:GetWordFromCfg(121501008)
				local var_36_14 = arg_33_1:FormatText(var_36_13.content)

				arg_33_1.text_.text = var_36_14

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_15 = 39
				local var_36_16 = utf8.len(var_36_14)
				local var_36_17 = var_36_15 <= 0 and var_36_11 or var_36_11 * (var_36_16 / var_36_15)

				if var_36_17 > 0 and var_36_11 < var_36_17 then
					arg_33_1.talkMaxDuration = var_36_17

					if var_36_17 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_17 + var_36_10
					end
				end

				arg_33_1.text_.text = var_36_14
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501008", "story_v_out_121501.awb") ~= 0 then
					local var_36_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501008", "story_v_out_121501.awb") / 1000

					if var_36_18 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_10
					end

					if var_36_13.prefab_name ~= "" and arg_33_1.actors_[var_36_13.prefab_name] ~= nil then
						local var_36_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_13.prefab_name].transform, "story_v_out_121501", "121501008", "story_v_out_121501.awb")

						arg_33_1:RecordAudio("121501008", var_36_19)
						arg_33_1:RecordAudio("121501008", var_36_19)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_121501", "121501008", "story_v_out_121501.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_121501", "121501008", "story_v_out_121501.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_20 = math.max(var_36_11, arg_33_1.talkMaxDuration)

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_20 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_10) / var_36_20

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_10 + var_36_20 and arg_33_1.time_ < var_36_10 + var_36_20 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play121501009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 121501009
		arg_37_1.duration_ = 9.23

		local var_37_0 = {
			ja = 9.233,
			ko = 4.833,
			zh = 4.833
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
				arg_37_0:Play121501010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.45

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[236].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(121501009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 18
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501009", "story_v_out_121501.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_121501", "121501009", "story_v_out_121501.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_121501", "121501009", "story_v_out_121501.awb")

						arg_37_1:RecordAudio("121501009", var_40_9)
						arg_37_1:RecordAudio("121501009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_121501", "121501009", "story_v_out_121501.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_121501", "121501009", "story_v_out_121501.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_10 and arg_37_1.time_ < var_40_0 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play121501010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 121501010
		arg_41_1.duration_ = 8.97

		local var_41_0 = {
			ja = 8.966,
			ko = 6.5,
			zh = 6.5
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
				arg_41_0:Play121501011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1029ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1029ui_story == nil then
				arg_41_1.var_.characterEffect1029ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1029ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1029ui_story then
				arg_41_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_44_4 = arg_41_1.actors_["1033ui_story"]
			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1033ui_story == nil then
				arg_41_1.var_.characterEffect1033ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.200000002980232

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 and not isNil(var_44_4) then
				local var_44_7 = (arg_41_1.time_ - var_44_5) / var_44_6

				if arg_41_1.var_.characterEffect1033ui_story and not isNil(var_44_4) then
					local var_44_8 = Mathf.Lerp(0, 0.5, var_44_7)

					arg_41_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1033ui_story.fillRatio = var_44_8
				end
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1033ui_story then
				local var_44_9 = 0.5

				arg_41_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1033ui_story.fillRatio = var_44_9
			end

			local var_44_10 = 0
			local var_44_11 = 0.875

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_12 = arg_41_1:FormatText(StoryNameCfg[319].name)

				arg_41_1.leftNameTxt_.text = var_44_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_13 = arg_41_1:GetWordFromCfg(121501010)
				local var_44_14 = arg_41_1:FormatText(var_44_13.content)

				arg_41_1.text_.text = var_44_14

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_15 = 35
				local var_44_16 = utf8.len(var_44_14)
				local var_44_17 = var_44_15 <= 0 and var_44_11 or var_44_11 * (var_44_16 / var_44_15)

				if var_44_17 > 0 and var_44_11 < var_44_17 then
					arg_41_1.talkMaxDuration = var_44_17

					if var_44_17 + var_44_10 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_17 + var_44_10
					end
				end

				arg_41_1.text_.text = var_44_14
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501010", "story_v_out_121501.awb") ~= 0 then
					local var_44_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501010", "story_v_out_121501.awb") / 1000

					if var_44_18 + var_44_10 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_10
					end

					if var_44_13.prefab_name ~= "" and arg_41_1.actors_[var_44_13.prefab_name] ~= nil then
						local var_44_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_13.prefab_name].transform, "story_v_out_121501", "121501010", "story_v_out_121501.awb")

						arg_41_1:RecordAudio("121501010", var_44_19)
						arg_41_1:RecordAudio("121501010", var_44_19)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_121501", "121501010", "story_v_out_121501.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_121501", "121501010", "story_v_out_121501.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_20 = math.max(var_44_11, arg_41_1.talkMaxDuration)

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_20 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_10) / var_44_20

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_10 + var_44_20 and arg_41_1.time_ < var_44_10 + var_44_20 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play121501011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 121501011
		arg_45_1.duration_ = 8.5

		local var_45_0 = {
			ja = 8.5,
			ko = 3.433,
			zh = 3.433
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
				arg_45_0:Play121501012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action442")
			end

			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_2 = 0
			local var_48_3 = 0.375

			if var_48_2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_4 = arg_45_1:FormatText(StoryNameCfg[319].name)

				arg_45_1.leftNameTxt_.text = var_48_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_5 = arg_45_1:GetWordFromCfg(121501011)
				local var_48_6 = arg_45_1:FormatText(var_48_5.content)

				arg_45_1.text_.text = var_48_6

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 15
				local var_48_8 = utf8.len(var_48_6)
				local var_48_9 = var_48_7 <= 0 and var_48_3 or var_48_3 * (var_48_8 / var_48_7)

				if var_48_9 > 0 and var_48_3 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_6
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501011", "story_v_out_121501.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_121501", "121501011", "story_v_out_121501.awb") / 1000

					if var_48_10 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_2
					end

					if var_48_5.prefab_name ~= "" and arg_45_1.actors_[var_48_5.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_5.prefab_name].transform, "story_v_out_121501", "121501011", "story_v_out_121501.awb")

						arg_45_1:RecordAudio("121501011", var_48_11)
						arg_45_1:RecordAudio("121501011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_121501", "121501011", "story_v_out_121501.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_121501", "121501011", "story_v_out_121501.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_12 and arg_45_1.time_ < var_48_2 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play121501012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 121501012
		arg_49_1.duration_ = 10.83

		local var_49_0 = {
			ja = 10.833,
			ko = 9.6,
			zh = 9.6
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
				arg_49_0:Play121501013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1033ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1033ui_story == nil then
				arg_49_1.var_.characterEffect1033ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1033ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1033ui_story then
				arg_49_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_52_4 = 0

			if var_52_4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action438")
			end

			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_6 = arg_49_1.actors_["1029ui_story"]
			local var_52_7 = 0

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1029ui_story == nil then
				arg_49_1.var_.characterEffect1029ui_story = var_52_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_8 = 0.200000002980232

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_8 and not isNil(var_52_6) then
				local var_52_9 = (arg_49_1.time_ - var_52_7) / var_52_8

				if arg_49_1.var_.characterEffect1029ui_story and not isNil(var_52_6) then
					local var_52_10 = Mathf.Lerp(0, 0.5, var_52_9)

					arg_49_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1029ui_story.fillRatio = var_52_10
				end
			end

			if arg_49_1.time_ >= var_52_7 + var_52_8 and arg_49_1.time_ < var_52_7 + var_52_8 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1029ui_story then
				local var_52_11 = 0.5

				arg_49_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1029ui_story.fillRatio = var_52_11
			end

			local var_52_12 = 0
			local var_52_13 = 1.1

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_14 = arg_49_1:FormatText(StoryNameCfg[236].name)

				arg_49_1.leftNameTxt_.text = var_52_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_15 = arg_49_1:GetWordFromCfg(121501012)
				local var_52_16 = arg_49_1:FormatText(var_52_15.content)

				arg_49_1.text_.text = var_52_16

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_17 = 44
				local var_52_18 = utf8.len(var_52_16)
				local var_52_19 = var_52_17 <= 0 and var_52_13 or var_52_13 * (var_52_18 / var_52_17)

				if var_52_19 > 0 and var_52_13 < var_52_19 then
					arg_49_1.talkMaxDuration = var_52_19

					if var_52_19 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_19 + var_52_12
					end
				end

				arg_49_1.text_.text = var_52_16
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501012", "story_v_out_121501.awb") ~= 0 then
					local var_52_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501012", "story_v_out_121501.awb") / 1000

					if var_52_20 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_20 + var_52_12
					end

					if var_52_15.prefab_name ~= "" and arg_49_1.actors_[var_52_15.prefab_name] ~= nil then
						local var_52_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_15.prefab_name].transform, "story_v_out_121501", "121501012", "story_v_out_121501.awb")

						arg_49_1:RecordAudio("121501012", var_52_21)
						arg_49_1:RecordAudio("121501012", var_52_21)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_121501", "121501012", "story_v_out_121501.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_121501", "121501012", "story_v_out_121501.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_22 = math.max(var_52_13, arg_49_1.talkMaxDuration)

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_22 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_12) / var_52_22

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_12 + var_52_22 and arg_49_1.time_ < var_52_12 + var_52_22 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play121501013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 121501013
		arg_53_1.duration_ = 10.33

		local var_53_0 = {
			ja = 10.333,
			ko = 9.6,
			zh = 9.6
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
				arg_53_0:Play121501014(arg_53_1)
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
					arg_53_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1033ui_story then
				arg_53_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_56_4 = 0

			if var_56_4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_56_5 = 0
			local var_56_6 = 1.2

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_7 = arg_53_1:FormatText(StoryNameCfg[236].name)

				arg_53_1.leftNameTxt_.text = var_56_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_8 = arg_53_1:GetWordFromCfg(121501013)
				local var_56_9 = arg_53_1:FormatText(var_56_8.content)

				arg_53_1.text_.text = var_56_9

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 49
				local var_56_11 = utf8.len(var_56_9)
				local var_56_12 = var_56_10 <= 0 and var_56_6 or var_56_6 * (var_56_11 / var_56_10)

				if var_56_12 > 0 and var_56_6 < var_56_12 then
					arg_53_1.talkMaxDuration = var_56_12

					if var_56_12 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_9
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501013", "story_v_out_121501.awb") ~= 0 then
					local var_56_13 = manager.audio:GetVoiceLength("story_v_out_121501", "121501013", "story_v_out_121501.awb") / 1000

					if var_56_13 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_5
					end

					if var_56_8.prefab_name ~= "" and arg_53_1.actors_[var_56_8.prefab_name] ~= nil then
						local var_56_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_8.prefab_name].transform, "story_v_out_121501", "121501013", "story_v_out_121501.awb")

						arg_53_1:RecordAudio("121501013", var_56_14)
						arg_53_1:RecordAudio("121501013", var_56_14)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_121501", "121501013", "story_v_out_121501.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_121501", "121501013", "story_v_out_121501.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_15 = math.max(var_56_6, arg_53_1.talkMaxDuration)

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_15 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_5) / var_56_15

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_5 + var_56_15 and arg_53_1.time_ < var_56_5 + var_56_15 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play121501014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 121501014
		arg_57_1.duration_ = 11.83

		local var_57_0 = {
			ja = 11.833,
			ko = 8.1,
			zh = 8.1
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
				arg_57_0:Play121501015(arg_57_1)
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
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1033ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1033ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1033ui_story.fillRatio = var_60_5
			end

			local var_60_6 = 0

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action2_2")
			end

			local var_60_7 = arg_57_1.actors_["1029ui_story"]
			local var_60_8 = 0

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.characterEffect1029ui_story == nil then
				arg_57_1.var_.characterEffect1029ui_story = var_60_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_9 = 0.200000002980232

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_9 and not isNil(var_60_7) then
				local var_60_10 = (arg_57_1.time_ - var_60_8) / var_60_9

				if arg_57_1.var_.characterEffect1029ui_story and not isNil(var_60_7) then
					arg_57_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_8 + var_60_9 and arg_57_1.time_ < var_60_8 + var_60_9 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.characterEffect1029ui_story then
				arg_57_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_60_11 = 0
			local var_60_12 = 0.875

			if var_60_11 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_13 = arg_57_1:FormatText(StoryNameCfg[319].name)

				arg_57_1.leftNameTxt_.text = var_60_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_14 = arg_57_1:GetWordFromCfg(121501014)
				local var_60_15 = arg_57_1:FormatText(var_60_14.content)

				arg_57_1.text_.text = var_60_15

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_16 = 35
				local var_60_17 = utf8.len(var_60_15)
				local var_60_18 = var_60_16 <= 0 and var_60_12 or var_60_12 * (var_60_17 / var_60_16)

				if var_60_18 > 0 and var_60_12 < var_60_18 then
					arg_57_1.talkMaxDuration = var_60_18

					if var_60_18 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_18 + var_60_11
					end
				end

				arg_57_1.text_.text = var_60_15
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501014", "story_v_out_121501.awb") ~= 0 then
					local var_60_19 = manager.audio:GetVoiceLength("story_v_out_121501", "121501014", "story_v_out_121501.awb") / 1000

					if var_60_19 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_19 + var_60_11
					end

					if var_60_14.prefab_name ~= "" and arg_57_1.actors_[var_60_14.prefab_name] ~= nil then
						local var_60_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_14.prefab_name].transform, "story_v_out_121501", "121501014", "story_v_out_121501.awb")

						arg_57_1:RecordAudio("121501014", var_60_20)
						arg_57_1:RecordAudio("121501014", var_60_20)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_121501", "121501014", "story_v_out_121501.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_121501", "121501014", "story_v_out_121501.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_21 = math.max(var_60_12, arg_57_1.talkMaxDuration)

			if var_60_11 <= arg_57_1.time_ and arg_57_1.time_ < var_60_11 + var_60_21 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_11) / var_60_21

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_11 + var_60_21 and arg_57_1.time_ < var_60_11 + var_60_21 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play121501015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 121501015
		arg_61_1.duration_ = 15.97

		local var_61_0 = {
			ja = 15.966,
			ko = 10.7,
			zh = 10.7
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
				arg_61_0:Play121501016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action482")
			end

			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_2 = arg_61_1.actors_["1029ui_story"]
			local var_64_3 = 0

			if var_64_3 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1029ui_story == nil then
				arg_61_1.var_.characterEffect1029ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_4 = 0.200000002980232

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_4 and not isNil(var_64_2) then
				local var_64_5 = (arg_61_1.time_ - var_64_3) / var_64_4

				if arg_61_1.var_.characterEffect1029ui_story and not isNil(var_64_2) then
					local var_64_6 = Mathf.Lerp(0, 0.5, var_64_5)

					arg_61_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1029ui_story.fillRatio = var_64_6
				end
			end

			if arg_61_1.time_ >= var_64_3 + var_64_4 and arg_61_1.time_ < var_64_3 + var_64_4 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1029ui_story then
				local var_64_7 = 0.5

				arg_61_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1029ui_story.fillRatio = var_64_7
			end

			local var_64_8 = arg_61_1.actors_["1033ui_story"]
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.characterEffect1033ui_story == nil then
				arg_61_1.var_.characterEffect1033ui_story = var_64_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_10 = 0.200000002980232

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 and not isNil(var_64_8) then
				local var_64_11 = (arg_61_1.time_ - var_64_9) / var_64_10

				if arg_61_1.var_.characterEffect1033ui_story and not isNil(var_64_8) then
					arg_61_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.characterEffect1033ui_story then
				arg_61_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_64_12 = 0
			local var_64_13 = 1.45

			if var_64_12 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_14 = arg_61_1:FormatText(StoryNameCfg[236].name)

				arg_61_1.leftNameTxt_.text = var_64_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_15 = arg_61_1:GetWordFromCfg(121501015)
				local var_64_16 = arg_61_1:FormatText(var_64_15.content)

				arg_61_1.text_.text = var_64_16

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_17 = 58
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

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501015", "story_v_out_121501.awb") ~= 0 then
					local var_64_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501015", "story_v_out_121501.awb") / 1000

					if var_64_20 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_20 + var_64_12
					end

					if var_64_15.prefab_name ~= "" and arg_61_1.actors_[var_64_15.prefab_name] ~= nil then
						local var_64_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_15.prefab_name].transform, "story_v_out_121501", "121501015", "story_v_out_121501.awb")

						arg_61_1:RecordAudio("121501015", var_64_21)
						arg_61_1:RecordAudio("121501015", var_64_21)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_121501", "121501015", "story_v_out_121501.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_121501", "121501015", "story_v_out_121501.awb")
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
	Play121501016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 121501016
		arg_65_1.duration_ = 12.33

		local var_65_0 = {
			ja = 12.333,
			ko = 11.166,
			zh = 11.166
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
				arg_65_0:Play121501017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 1.175

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[236].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(121501016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 47
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

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501016", "story_v_out_121501.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_121501", "121501016", "story_v_out_121501.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_121501", "121501016", "story_v_out_121501.awb")

						arg_65_1:RecordAudio("121501016", var_68_9)
						arg_65_1:RecordAudio("121501016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_121501", "121501016", "story_v_out_121501.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_121501", "121501016", "story_v_out_121501.awb")
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
	Play121501017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 121501017
		arg_69_1.duration_ = 11.2

		local var_69_0 = {
			ja = 11.2,
			ko = 8.3,
			zh = 8.3
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
				arg_69_0:Play121501018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_2 = arg_69_1.actors_["1029ui_story"]
			local var_72_3 = 0

			if var_72_3 < arg_69_1.time_ and arg_69_1.time_ <= var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.characterEffect1029ui_story == nil then
				arg_69_1.var_.characterEffect1029ui_story = var_72_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_4 = 0.200000002980232

			if var_72_3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_3 + var_72_4 and not isNil(var_72_2) then
				local var_72_5 = (arg_69_1.time_ - var_72_3) / var_72_4

				if arg_69_1.var_.characterEffect1029ui_story and not isNil(var_72_2) then
					arg_69_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_3 + var_72_4 and arg_69_1.time_ < var_72_3 + var_72_4 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.characterEffect1029ui_story then
				arg_69_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_72_6 = arg_69_1.actors_["1033ui_story"]
			local var_72_7 = 0

			if var_72_7 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect1033ui_story == nil then
				arg_69_1.var_.characterEffect1033ui_story = var_72_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_8 = 0.200000002980232

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_8 and not isNil(var_72_6) then
				local var_72_9 = (arg_69_1.time_ - var_72_7) / var_72_8

				if arg_69_1.var_.characterEffect1033ui_story and not isNil(var_72_6) then
					local var_72_10 = Mathf.Lerp(0, 0.5, var_72_9)

					arg_69_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1033ui_story.fillRatio = var_72_10
				end
			end

			if arg_69_1.time_ >= var_72_7 + var_72_8 and arg_69_1.time_ < var_72_7 + var_72_8 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect1033ui_story then
				local var_72_11 = 0.5

				arg_69_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1033ui_story.fillRatio = var_72_11
			end

			local var_72_12 = 0
			local var_72_13 = 1.05

			if var_72_12 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_14 = arg_69_1:FormatText(StoryNameCfg[319].name)

				arg_69_1.leftNameTxt_.text = var_72_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_15 = arg_69_1:GetWordFromCfg(121501017)
				local var_72_16 = arg_69_1:FormatText(var_72_15.content)

				arg_69_1.text_.text = var_72_16

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_17 = 42
				local var_72_18 = utf8.len(var_72_16)
				local var_72_19 = var_72_17 <= 0 and var_72_13 or var_72_13 * (var_72_18 / var_72_17)

				if var_72_19 > 0 and var_72_13 < var_72_19 then
					arg_69_1.talkMaxDuration = var_72_19

					if var_72_19 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_19 + var_72_12
					end
				end

				arg_69_1.text_.text = var_72_16
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501017", "story_v_out_121501.awb") ~= 0 then
					local var_72_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501017", "story_v_out_121501.awb") / 1000

					if var_72_20 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_20 + var_72_12
					end

					if var_72_15.prefab_name ~= "" and arg_69_1.actors_[var_72_15.prefab_name] ~= nil then
						local var_72_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_15.prefab_name].transform, "story_v_out_121501", "121501017", "story_v_out_121501.awb")

						arg_69_1:RecordAudio("121501017", var_72_21)
						arg_69_1:RecordAudio("121501017", var_72_21)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_121501", "121501017", "story_v_out_121501.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_121501", "121501017", "story_v_out_121501.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_22 = math.max(var_72_13, arg_69_1.talkMaxDuration)

			if var_72_12 <= arg_69_1.time_ and arg_69_1.time_ < var_72_12 + var_72_22 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_12) / var_72_22

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_12 + var_72_22 and arg_69_1.time_ < var_72_12 + var_72_22 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play121501018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 121501018
		arg_73_1.duration_ = 11.5

		local var_73_0 = {
			ja = 11.5,
			ko = 7.433,
			zh = 7.433
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
				arg_73_0:Play121501019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_76_1 = arg_73_1.actors_["1029ui_story"]
			local var_76_2 = 0

			if var_76_2 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1029ui_story == nil then
				arg_73_1.var_.characterEffect1029ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_3 = 0.200000002980232

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_3 and not isNil(var_76_1) then
				local var_76_4 = (arg_73_1.time_ - var_76_2) / var_76_3

				if arg_73_1.var_.characterEffect1029ui_story and not isNil(var_76_1) then
					local var_76_5 = Mathf.Lerp(0, 0.5, var_76_4)

					arg_73_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1029ui_story.fillRatio = var_76_5
				end
			end

			if arg_73_1.time_ >= var_76_2 + var_76_3 and arg_73_1.time_ < var_76_2 + var_76_3 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1029ui_story then
				local var_76_6 = 0.5

				arg_73_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1029ui_story.fillRatio = var_76_6
			end

			local var_76_7 = arg_73_1.actors_["1033ui_story"]
			local var_76_8 = 0

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.characterEffect1033ui_story == nil then
				arg_73_1.var_.characterEffect1033ui_story = var_76_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_9 = 0.200000002980232

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_9 and not isNil(var_76_7) then
				local var_76_10 = (arg_73_1.time_ - var_76_8) / var_76_9

				if arg_73_1.var_.characterEffect1033ui_story and not isNil(var_76_7) then
					arg_73_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_8 + var_76_9 and arg_73_1.time_ < var_76_8 + var_76_9 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.characterEffect1033ui_story then
				arg_73_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_76_11 = 0
			local var_76_12 = 0.825

			if var_76_11 < arg_73_1.time_ and arg_73_1.time_ <= var_76_11 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_13 = arg_73_1:FormatText(StoryNameCfg[236].name)

				arg_73_1.leftNameTxt_.text = var_76_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_14 = arg_73_1:GetWordFromCfg(121501018)
				local var_76_15 = arg_73_1:FormatText(var_76_14.content)

				arg_73_1.text_.text = var_76_15

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_16 = 33
				local var_76_17 = utf8.len(var_76_15)
				local var_76_18 = var_76_16 <= 0 and var_76_12 or var_76_12 * (var_76_17 / var_76_16)

				if var_76_18 > 0 and var_76_12 < var_76_18 then
					arg_73_1.talkMaxDuration = var_76_18

					if var_76_18 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_18 + var_76_11
					end
				end

				arg_73_1.text_.text = var_76_15
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501018", "story_v_out_121501.awb") ~= 0 then
					local var_76_19 = manager.audio:GetVoiceLength("story_v_out_121501", "121501018", "story_v_out_121501.awb") / 1000

					if var_76_19 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_19 + var_76_11
					end

					if var_76_14.prefab_name ~= "" and arg_73_1.actors_[var_76_14.prefab_name] ~= nil then
						local var_76_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_14.prefab_name].transform, "story_v_out_121501", "121501018", "story_v_out_121501.awb")

						arg_73_1:RecordAudio("121501018", var_76_20)
						arg_73_1:RecordAudio("121501018", var_76_20)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_121501", "121501018", "story_v_out_121501.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_121501", "121501018", "story_v_out_121501.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_21 = math.max(var_76_12, arg_73_1.talkMaxDuration)

			if var_76_11 <= arg_73_1.time_ and arg_73_1.time_ < var_76_11 + var_76_21 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_11) / var_76_21

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_11 + var_76_21 and arg_73_1.time_ < var_76_11 + var_76_21 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play121501019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 121501019
		arg_77_1.duration_ = 7.2

		local var_77_0 = {
			ja = 7.199999999998,
			ko = 6.932999999998,
			zh = 6.932999999998
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
				arg_77_0:Play121501020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = "ST12"

			if arg_77_1.bgs_[var_80_0] == nil then
				local var_80_1 = Object.Instantiate(arg_77_1.paintGo_)

				var_80_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_80_0)
				var_80_1.name = var_80_0
				var_80_1.transform.parent = arg_77_1.stage_.transform
				var_80_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.bgs_[var_80_0] = var_80_1
			end

			local var_80_2 = 1.999999999999

			if var_80_2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				local var_80_3 = manager.ui.mainCamera.transform.localPosition
				local var_80_4 = Vector3.New(0, 0, 10) + Vector3.New(var_80_3.x, var_80_3.y, 0)
				local var_80_5 = arg_77_1.bgs_.ST12

				var_80_5.transform.localPosition = var_80_4
				var_80_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_6 = var_80_5:GetComponent("SpriteRenderer")

				if var_80_6 and var_80_6.sprite then
					local var_80_7 = (var_80_5.transform.localPosition - var_80_3).z
					local var_80_8 = manager.ui.mainCameraCom_
					local var_80_9 = 2 * var_80_7 * Mathf.Tan(var_80_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_80_10 = var_80_9 * var_80_8.aspect
					local var_80_11 = var_80_6.sprite.bounds.size.x
					local var_80_12 = var_80_6.sprite.bounds.size.y
					local var_80_13 = var_80_10 / var_80_11
					local var_80_14 = var_80_9 / var_80_12
					local var_80_15 = var_80_14 < var_80_13 and var_80_13 or var_80_14

					var_80_5.transform.localScale = Vector3.New(var_80_15, var_80_15, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "ST12" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_16 = 0

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_17 = 2

			if var_80_16 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_17 then
				local var_80_18 = (arg_77_1.time_ - var_80_16) / var_80_17
				local var_80_19 = Color.New(0, 0, 0)

				var_80_19.a = Mathf.Lerp(0, 1, var_80_18)
				arg_77_1.mask_.color = var_80_19
			end

			if arg_77_1.time_ >= var_80_16 + var_80_17 and arg_77_1.time_ < var_80_16 + var_80_17 + arg_80_0 then
				local var_80_20 = Color.New(0, 0, 0)

				var_80_20.a = 1
				arg_77_1.mask_.color = var_80_20
			end

			local var_80_21 = 2.00000000298023

			if var_80_21 < arg_77_1.time_ and arg_77_1.time_ <= var_80_21 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_22 = 2

			if var_80_21 <= arg_77_1.time_ and arg_77_1.time_ < var_80_21 + var_80_22 then
				local var_80_23 = (arg_77_1.time_ - var_80_21) / var_80_22
				local var_80_24 = Color.New(0, 0, 0)

				var_80_24.a = Mathf.Lerp(1, 0, var_80_23)
				arg_77_1.mask_.color = var_80_24
			end

			if arg_77_1.time_ >= var_80_21 + var_80_22 and arg_77_1.time_ < var_80_21 + var_80_22 + arg_80_0 then
				local var_80_25 = Color.New(0, 0, 0)
				local var_80_26 = 0

				arg_77_1.mask_.enabled = false
				var_80_25.a = var_80_26
				arg_77_1.mask_.color = var_80_25
			end

			local var_80_27 = arg_77_1.actors_["1033ui_story"].transform
			local var_80_28 = 1.96599999815226

			if var_80_28 < arg_77_1.time_ and arg_77_1.time_ <= var_80_28 + arg_80_0 then
				arg_77_1.var_.moveOldPos1033ui_story = var_80_27.localPosition
			end

			local var_80_29 = 0.001

			if var_80_28 <= arg_77_1.time_ and arg_77_1.time_ < var_80_28 + var_80_29 then
				local var_80_30 = (arg_77_1.time_ - var_80_28) / var_80_29
				local var_80_31 = Vector3.New(0, 100, 0)

				var_80_27.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1033ui_story, var_80_31, var_80_30)

				local var_80_32 = manager.ui.mainCamera.transform.position - var_80_27.position

				var_80_27.forward = Vector3.New(var_80_32.x, var_80_32.y, var_80_32.z)

				local var_80_33 = var_80_27.localEulerAngles

				var_80_33.z = 0
				var_80_33.x = 0
				var_80_27.localEulerAngles = var_80_33
			end

			if arg_77_1.time_ >= var_80_28 + var_80_29 and arg_77_1.time_ < var_80_28 + var_80_29 + arg_80_0 then
				var_80_27.localPosition = Vector3.New(0, 100, 0)

				local var_80_34 = manager.ui.mainCamera.transform.position - var_80_27.position

				var_80_27.forward = Vector3.New(var_80_34.x, var_80_34.y, var_80_34.z)

				local var_80_35 = var_80_27.localEulerAngles

				var_80_35.z = 0
				var_80_35.x = 0
				var_80_27.localEulerAngles = var_80_35
			end

			local var_80_36 = arg_77_1.actors_["1033ui_story"]
			local var_80_37 = 1.96599999815226

			if var_80_37 < arg_77_1.time_ and arg_77_1.time_ <= var_80_37 + arg_80_0 and not isNil(var_80_36) and arg_77_1.var_.characterEffect1033ui_story == nil then
				arg_77_1.var_.characterEffect1033ui_story = var_80_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_38 = 0.034000001847744

			if var_80_37 <= arg_77_1.time_ and arg_77_1.time_ < var_80_37 + var_80_38 and not isNil(var_80_36) then
				local var_80_39 = (arg_77_1.time_ - var_80_37) / var_80_38

				if arg_77_1.var_.characterEffect1033ui_story and not isNil(var_80_36) then
					local var_80_40 = Mathf.Lerp(0, 0.5, var_80_39)

					arg_77_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1033ui_story.fillRatio = var_80_40
				end
			end

			if arg_77_1.time_ >= var_80_37 + var_80_38 and arg_77_1.time_ < var_80_37 + var_80_38 + arg_80_0 and not isNil(var_80_36) and arg_77_1.var_.characterEffect1033ui_story then
				local var_80_41 = 0.5

				arg_77_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1033ui_story.fillRatio = var_80_41
			end

			local var_80_42 = arg_77_1.actors_["1029ui_story"].transform
			local var_80_43 = 1.96599999815226

			if var_80_43 < arg_77_1.time_ and arg_77_1.time_ <= var_80_43 + arg_80_0 then
				arg_77_1.var_.moveOldPos1029ui_story = var_80_42.localPosition
			end

			local var_80_44 = 0.001

			if var_80_43 <= arg_77_1.time_ and arg_77_1.time_ < var_80_43 + var_80_44 then
				local var_80_45 = (arg_77_1.time_ - var_80_43) / var_80_44
				local var_80_46 = Vector3.New(0, 100, 0)

				var_80_42.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1029ui_story, var_80_46, var_80_45)

				local var_80_47 = manager.ui.mainCamera.transform.position - var_80_42.position

				var_80_42.forward = Vector3.New(var_80_47.x, var_80_47.y, var_80_47.z)

				local var_80_48 = var_80_42.localEulerAngles

				var_80_48.z = 0
				var_80_48.x = 0
				var_80_42.localEulerAngles = var_80_48
			end

			if arg_77_1.time_ >= var_80_43 + var_80_44 and arg_77_1.time_ < var_80_43 + var_80_44 + arg_80_0 then
				var_80_42.localPosition = Vector3.New(0, 100, 0)

				local var_80_49 = manager.ui.mainCamera.transform.position - var_80_42.position

				var_80_42.forward = Vector3.New(var_80_49.x, var_80_49.y, var_80_49.z)

				local var_80_50 = var_80_42.localEulerAngles

				var_80_50.z = 0
				var_80_50.x = 0
				var_80_42.localEulerAngles = var_80_50
			end

			local var_80_51 = arg_77_1.actors_["1029ui_story"]
			local var_80_52 = 1.96599999815226

			if var_80_52 < arg_77_1.time_ and arg_77_1.time_ <= var_80_52 + arg_80_0 and not isNil(var_80_51) and arg_77_1.var_.characterEffect1029ui_story == nil then
				arg_77_1.var_.characterEffect1029ui_story = var_80_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_53 = 0.034000001847744

			if var_80_52 <= arg_77_1.time_ and arg_77_1.time_ < var_80_52 + var_80_53 and not isNil(var_80_51) then
				local var_80_54 = (arg_77_1.time_ - var_80_52) / var_80_53

				if arg_77_1.var_.characterEffect1029ui_story and not isNil(var_80_51) then
					local var_80_55 = Mathf.Lerp(0, 0.5, var_80_54)

					arg_77_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1029ui_story.fillRatio = var_80_55
				end
			end

			if arg_77_1.time_ >= var_80_52 + var_80_53 and arg_77_1.time_ < var_80_52 + var_80_53 + arg_80_0 and not isNil(var_80_51) and arg_77_1.var_.characterEffect1029ui_story then
				local var_80_56 = 0.5

				arg_77_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1029ui_story.fillRatio = var_80_56
			end

			local var_80_57 = "1019ui_story"

			if arg_77_1.actors_[var_80_57] == nil then
				local var_80_58 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_80_58) then
					local var_80_59 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_77_1.stage_.transform)

					var_80_59.name = var_80_57
					var_80_59.transform.localPosition = Vector3.New(0, 100, 0)
					arg_77_1.actors_[var_80_57] = var_80_59

					local var_80_60 = var_80_59:GetComponentInChildren(typeof(CharacterEffect))

					var_80_60.enabled = true

					local var_80_61 = GameObjectTools.GetOrAddComponent(var_80_59, typeof(DynamicBoneHelper))

					if var_80_61 then
						var_80_61:EnableDynamicBone(false)
					end

					arg_77_1:ShowWeapon(var_80_60.transform, false)

					arg_77_1.var_[var_80_57 .. "Animator"] = var_80_60.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_77_1.var_[var_80_57 .. "Animator"].applyRootMotion = true
					arg_77_1.var_[var_80_57 .. "LipSync"] = var_80_60.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_80_62 = arg_77_1.actors_["1019ui_story"].transform
			local var_80_63 = 3.8

			if var_80_63 < arg_77_1.time_ and arg_77_1.time_ <= var_80_63 + arg_80_0 then
				arg_77_1.var_.moveOldPos1019ui_story = var_80_62.localPosition
			end

			local var_80_64 = 0.001

			if var_80_63 <= arg_77_1.time_ and arg_77_1.time_ < var_80_63 + var_80_64 then
				local var_80_65 = (arg_77_1.time_ - var_80_63) / var_80_64
				local var_80_66 = Vector3.New(-0.2, -1.08, -5.9)

				var_80_62.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1019ui_story, var_80_66, var_80_65)

				local var_80_67 = manager.ui.mainCamera.transform.position - var_80_62.position

				var_80_62.forward = Vector3.New(var_80_67.x, var_80_67.y, var_80_67.z)

				local var_80_68 = var_80_62.localEulerAngles

				var_80_68.z = 0
				var_80_68.x = 0
				var_80_62.localEulerAngles = var_80_68
			end

			if arg_77_1.time_ >= var_80_63 + var_80_64 and arg_77_1.time_ < var_80_63 + var_80_64 + arg_80_0 then
				var_80_62.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_80_69 = manager.ui.mainCamera.transform.position - var_80_62.position

				var_80_62.forward = Vector3.New(var_80_69.x, var_80_69.y, var_80_69.z)

				local var_80_70 = var_80_62.localEulerAngles

				var_80_70.z = 0
				var_80_70.x = 0
				var_80_62.localEulerAngles = var_80_70
			end

			local var_80_71 = arg_77_1.actors_["1019ui_story"]
			local var_80_72 = 3.8

			if var_80_72 < arg_77_1.time_ and arg_77_1.time_ <= var_80_72 + arg_80_0 and not isNil(var_80_71) and arg_77_1.var_.characterEffect1019ui_story == nil then
				arg_77_1.var_.characterEffect1019ui_story = var_80_71:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_73 = 0.200000002980232

			if var_80_72 <= arg_77_1.time_ and arg_77_1.time_ < var_80_72 + var_80_73 and not isNil(var_80_71) then
				local var_80_74 = (arg_77_1.time_ - var_80_72) / var_80_73

				if arg_77_1.var_.characterEffect1019ui_story and not isNil(var_80_71) then
					arg_77_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_72 + var_80_73 and arg_77_1.time_ < var_80_72 + var_80_73 + arg_80_0 and not isNil(var_80_71) and arg_77_1.var_.characterEffect1019ui_story then
				arg_77_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_80_75 = 3.8

			if var_80_75 < arg_77_1.time_ and arg_77_1.time_ <= var_80_75 + arg_80_0 then
				arg_77_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_80_76 = 3.8

			if var_80_76 < arg_77_1.time_ and arg_77_1.time_ <= var_80_76 + arg_80_0 then
				arg_77_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_77 = 3.999999999998
			local var_80_78 = 0.4

			if var_80_77 < arg_77_1.time_ and arg_77_1.time_ <= var_80_77 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_79 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_79:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_79:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_79:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_80 = arg_77_1:FormatText(StoryNameCfg[13].name)

				arg_77_1.leftNameTxt_.text = var_80_80

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_81 = arg_77_1:GetWordFromCfg(121501019)
				local var_80_82 = arg_77_1:FormatText(var_80_81.content)

				arg_77_1.text_.text = var_80_82

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_83 = 16
				local var_80_84 = utf8.len(var_80_82)
				local var_80_85 = var_80_83 <= 0 and var_80_78 or var_80_78 * (var_80_84 / var_80_83)

				if var_80_85 > 0 and var_80_78 < var_80_85 then
					arg_77_1.talkMaxDuration = var_80_85
					var_80_77 = var_80_77 + 0.3

					if var_80_85 + var_80_77 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_85 + var_80_77
					end
				end

				arg_77_1.text_.text = var_80_82
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501019", "story_v_out_121501.awb") ~= 0 then
					local var_80_86 = manager.audio:GetVoiceLength("story_v_out_121501", "121501019", "story_v_out_121501.awb") / 1000

					if var_80_86 + var_80_77 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_86 + var_80_77
					end

					if var_80_81.prefab_name ~= "" and arg_77_1.actors_[var_80_81.prefab_name] ~= nil then
						local var_80_87 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_81.prefab_name].transform, "story_v_out_121501", "121501019", "story_v_out_121501.awb")

						arg_77_1:RecordAudio("121501019", var_80_87)
						arg_77_1:RecordAudio("121501019", var_80_87)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_121501", "121501019", "story_v_out_121501.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_121501", "121501019", "story_v_out_121501.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_88 = var_80_77 + 0.3
			local var_80_89 = math.max(var_80_78, arg_77_1.talkMaxDuration)

			if var_80_88 <= arg_77_1.time_ and arg_77_1.time_ < var_80_88 + var_80_89 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_88) / var_80_89

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_88 + var_80_89 and arg_77_1.time_ < var_80_88 + var_80_89 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play121501020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 121501020
		arg_83_1.duration_ = 11.03

		local var_83_0 = {
			ja = 11.033,
			ko = 9.9,
			zh = 9.9
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play121501021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_86_1 = 0
			local var_86_2 = 1.225

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_3 = arg_83_1:FormatText(StoryNameCfg[13].name)

				arg_83_1.leftNameTxt_.text = var_86_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_4 = arg_83_1:GetWordFromCfg(121501020)
				local var_86_5 = arg_83_1:FormatText(var_86_4.content)

				arg_83_1.text_.text = var_86_5

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_6 = 49
				local var_86_7 = utf8.len(var_86_5)
				local var_86_8 = var_86_6 <= 0 and var_86_2 or var_86_2 * (var_86_7 / var_86_6)

				if var_86_8 > 0 and var_86_2 < var_86_8 then
					arg_83_1.talkMaxDuration = var_86_8

					if var_86_8 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_5
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501020", "story_v_out_121501.awb") ~= 0 then
					local var_86_9 = manager.audio:GetVoiceLength("story_v_out_121501", "121501020", "story_v_out_121501.awb") / 1000

					if var_86_9 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_1
					end

					if var_86_4.prefab_name ~= "" and arg_83_1.actors_[var_86_4.prefab_name] ~= nil then
						local var_86_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_4.prefab_name].transform, "story_v_out_121501", "121501020", "story_v_out_121501.awb")

						arg_83_1:RecordAudio("121501020", var_86_10)
						arg_83_1:RecordAudio("121501020", var_86_10)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_121501", "121501020", "story_v_out_121501.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_121501", "121501020", "story_v_out_121501.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_11 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_11 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_11

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_11 and arg_83_1.time_ < var_86_1 + var_86_11 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play121501021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 121501021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play121501022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1019ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1019ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(0, 100, 0)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1019ui_story, var_90_4, var_90_3)

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

			local var_90_9 = arg_87_1.actors_["1019ui_story"]
			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 and not isNil(var_90_9) and arg_87_1.var_.characterEffect1019ui_story == nil then
				arg_87_1.var_.characterEffect1019ui_story = var_90_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_11 = 0.200000002980232

			if var_90_10 <= arg_87_1.time_ and arg_87_1.time_ < var_90_10 + var_90_11 and not isNil(var_90_9) then
				local var_90_12 = (arg_87_1.time_ - var_90_10) / var_90_11

				if arg_87_1.var_.characterEffect1019ui_story and not isNil(var_90_9) then
					local var_90_13 = Mathf.Lerp(0, 0.5, var_90_12)

					arg_87_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1019ui_story.fillRatio = var_90_13
				end
			end

			if arg_87_1.time_ >= var_90_10 + var_90_11 and arg_87_1.time_ < var_90_10 + var_90_11 + arg_90_0 and not isNil(var_90_9) and arg_87_1.var_.characterEffect1019ui_story then
				local var_90_14 = 0.5

				arg_87_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1019ui_story.fillRatio = var_90_14
			end

			local var_90_15 = 0
			local var_90_16 = 1.625

			if var_90_15 < arg_87_1.time_ and arg_87_1.time_ <= var_90_15 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_17 = arg_87_1:GetWordFromCfg(121501021)
				local var_90_18 = arg_87_1:FormatText(var_90_17.content)

				arg_87_1.text_.text = var_90_18

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_19 = 65
				local var_90_20 = utf8.len(var_90_18)
				local var_90_21 = var_90_19 <= 0 and var_90_16 or var_90_16 * (var_90_20 / var_90_19)

				if var_90_21 > 0 and var_90_16 < var_90_21 then
					arg_87_1.talkMaxDuration = var_90_21

					if var_90_21 + var_90_15 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_21 + var_90_15
					end
				end

				arg_87_1.text_.text = var_90_18
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_22 = math.max(var_90_16, arg_87_1.talkMaxDuration)

			if var_90_15 <= arg_87_1.time_ and arg_87_1.time_ < var_90_15 + var_90_22 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_15) / var_90_22

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_15 + var_90_22 and arg_87_1.time_ < var_90_15 + var_90_22 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play121501022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 121501022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play121501023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.925

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_2 = arg_91_1:GetWordFromCfg(121501022)
				local var_94_3 = arg_91_1:FormatText(var_94_2.content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 37
				local var_94_5 = utf8.len(var_94_3)
				local var_94_6 = var_94_4 <= 0 and var_94_1 or var_94_1 * (var_94_5 / var_94_4)

				if var_94_6 > 0 and var_94_1 < var_94_6 then
					arg_91_1.talkMaxDuration = var_94_6

					if var_94_6 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_6 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_7 and arg_91_1.time_ < var_94_0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play121501023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 121501023
		arg_95_1.duration_ = 2.1

		local var_95_0 = {
			ja = 2.1,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_95_0:Play121501024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1019ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1019ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1019ui_story, var_98_4, var_98_3)

				local var_98_5 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_5.x, var_98_5.y, var_98_5.z)

				local var_98_6 = var_98_0.localEulerAngles

				var_98_6.z = 0
				var_98_6.x = 0
				var_98_0.localEulerAngles = var_98_6
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_98_7 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_7.x, var_98_7.y, var_98_7.z)

				local var_98_8 = var_98_0.localEulerAngles

				var_98_8.z = 0
				var_98_8.x = 0
				var_98_0.localEulerAngles = var_98_8
			end

			local var_98_9 = arg_95_1.actors_["1019ui_story"]
			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1019ui_story == nil then
				arg_95_1.var_.characterEffect1019ui_story = var_98_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_11 = 0.200000002980232

			if var_98_10 <= arg_95_1.time_ and arg_95_1.time_ < var_98_10 + var_98_11 and not isNil(var_98_9) then
				local var_98_12 = (arg_95_1.time_ - var_98_10) / var_98_11

				if arg_95_1.var_.characterEffect1019ui_story and not isNil(var_98_9) then
					arg_95_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_10 + var_98_11 and arg_95_1.time_ < var_98_10 + var_98_11 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1019ui_story then
				arg_95_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_98_13 = 0

			if var_98_13 < arg_95_1.time_ and arg_95_1.time_ <= var_98_13 + arg_98_0 then
				arg_95_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_98_14 = 0

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_98_15 = arg_95_1.actors_["1029ui_story"].transform
			local var_98_16 = 0

			if var_98_16 < arg_95_1.time_ and arg_95_1.time_ <= var_98_16 + arg_98_0 then
				arg_95_1.var_.moveOldPos1029ui_story = var_98_15.localPosition
			end

			local var_98_17 = 0.001

			if var_98_16 <= arg_95_1.time_ and arg_95_1.time_ < var_98_16 + var_98_17 then
				local var_98_18 = (arg_95_1.time_ - var_98_16) / var_98_17
				local var_98_19 = Vector3.New(0.7, -1.09, -6.2)

				var_98_15.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1029ui_story, var_98_19, var_98_18)

				local var_98_20 = manager.ui.mainCamera.transform.position - var_98_15.position

				var_98_15.forward = Vector3.New(var_98_20.x, var_98_20.y, var_98_20.z)

				local var_98_21 = var_98_15.localEulerAngles

				var_98_21.z = 0
				var_98_21.x = 0
				var_98_15.localEulerAngles = var_98_21
			end

			if arg_95_1.time_ >= var_98_16 + var_98_17 and arg_95_1.time_ < var_98_16 + var_98_17 + arg_98_0 then
				var_98_15.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_98_22 = manager.ui.mainCamera.transform.position - var_98_15.position

				var_98_15.forward = Vector3.New(var_98_22.x, var_98_22.y, var_98_22.z)

				local var_98_23 = var_98_15.localEulerAngles

				var_98_23.z = 0
				var_98_23.x = 0
				var_98_15.localEulerAngles = var_98_23
			end

			local var_98_24 = arg_95_1.actors_["1029ui_story"]
			local var_98_25 = 0

			if var_98_25 < arg_95_1.time_ and arg_95_1.time_ <= var_98_25 + arg_98_0 and not isNil(var_98_24) and arg_95_1.var_.characterEffect1029ui_story == nil then
				arg_95_1.var_.characterEffect1029ui_story = var_98_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_26 = 0.200000002980232

			if var_98_25 <= arg_95_1.time_ and arg_95_1.time_ < var_98_25 + var_98_26 and not isNil(var_98_24) then
				local var_98_27 = (arg_95_1.time_ - var_98_25) / var_98_26

				if arg_95_1.var_.characterEffect1029ui_story and not isNil(var_98_24) then
					local var_98_28 = Mathf.Lerp(0, 0.5, var_98_27)

					arg_95_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1029ui_story.fillRatio = var_98_28
				end
			end

			if arg_95_1.time_ >= var_98_25 + var_98_26 and arg_95_1.time_ < var_98_25 + var_98_26 + arg_98_0 and not isNil(var_98_24) and arg_95_1.var_.characterEffect1029ui_story then
				local var_98_29 = 0.5

				arg_95_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1029ui_story.fillRatio = var_98_29
			end

			local var_98_30 = 0
			local var_98_31 = 0.15

			if var_98_30 < arg_95_1.time_ and arg_95_1.time_ <= var_98_30 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_32 = arg_95_1:FormatText(StoryNameCfg[13].name)

				arg_95_1.leftNameTxt_.text = var_98_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_33 = arg_95_1:GetWordFromCfg(121501023)
				local var_98_34 = arg_95_1:FormatText(var_98_33.content)

				arg_95_1.text_.text = var_98_34

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_35 = 6
				local var_98_36 = utf8.len(var_98_34)
				local var_98_37 = var_98_35 <= 0 and var_98_31 or var_98_31 * (var_98_36 / var_98_35)

				if var_98_37 > 0 and var_98_31 < var_98_37 then
					arg_95_1.talkMaxDuration = var_98_37

					if var_98_37 + var_98_30 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_37 + var_98_30
					end
				end

				arg_95_1.text_.text = var_98_34
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501023", "story_v_out_121501.awb") ~= 0 then
					local var_98_38 = manager.audio:GetVoiceLength("story_v_out_121501", "121501023", "story_v_out_121501.awb") / 1000

					if var_98_38 + var_98_30 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_38 + var_98_30
					end

					if var_98_33.prefab_name ~= "" and arg_95_1.actors_[var_98_33.prefab_name] ~= nil then
						local var_98_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_33.prefab_name].transform, "story_v_out_121501", "121501023", "story_v_out_121501.awb")

						arg_95_1:RecordAudio("121501023", var_98_39)
						arg_95_1:RecordAudio("121501023", var_98_39)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_121501", "121501023", "story_v_out_121501.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_121501", "121501023", "story_v_out_121501.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_40 = math.max(var_98_31, arg_95_1.talkMaxDuration)

			if var_98_30 <= arg_95_1.time_ and arg_95_1.time_ < var_98_30 + var_98_40 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_30) / var_98_40

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_30 + var_98_40 and arg_95_1.time_ < var_98_30 + var_98_40 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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
				actorName = "1029ui_story",
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
	Play121501024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 121501024
		arg_99_1.duration_ = 11.37

		local var_99_0 = {
			ja = 6.2,
			ko = 11.366,
			zh = 11.366
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
				arg_99_0:Play121501025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1019ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1019ui_story == nil then
				arg_99_1.var_.characterEffect1019ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect1019ui_story and not isNil(var_102_0) then
					local var_102_4 = Mathf.Lerp(0, 0.5, var_102_3)

					arg_99_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1019ui_story.fillRatio = var_102_4
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1019ui_story then
				local var_102_5 = 0.5

				arg_99_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1019ui_story.fillRatio = var_102_5
			end

			local var_102_6 = arg_99_1.actors_["1029ui_story"]
			local var_102_7 = 0

			if var_102_7 < arg_99_1.time_ and arg_99_1.time_ <= var_102_7 + arg_102_0 and not isNil(var_102_6) and arg_99_1.var_.characterEffect1029ui_story == nil then
				arg_99_1.var_.characterEffect1029ui_story = var_102_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_8 = 0.200000002980232

			if var_102_7 <= arg_99_1.time_ and arg_99_1.time_ < var_102_7 + var_102_8 and not isNil(var_102_6) then
				local var_102_9 = (arg_99_1.time_ - var_102_7) / var_102_8

				if arg_99_1.var_.characterEffect1029ui_story and not isNil(var_102_6) then
					arg_99_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_7 + var_102_8 and arg_99_1.time_ < var_102_7 + var_102_8 + arg_102_0 and not isNil(var_102_6) and arg_99_1.var_.characterEffect1029ui_story then
				arg_99_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_102_10 = 0
			local var_102_11 = 1.075

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_12 = arg_99_1:FormatText(StoryNameCfg[319].name)

				arg_99_1.leftNameTxt_.text = var_102_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_13 = arg_99_1:GetWordFromCfg(121501024)
				local var_102_14 = arg_99_1:FormatText(var_102_13.content)

				arg_99_1.text_.text = var_102_14

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_15 = 43
				local var_102_16 = utf8.len(var_102_14)
				local var_102_17 = var_102_15 <= 0 and var_102_11 or var_102_11 * (var_102_16 / var_102_15)

				if var_102_17 > 0 and var_102_11 < var_102_17 then
					arg_99_1.talkMaxDuration = var_102_17

					if var_102_17 + var_102_10 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_17 + var_102_10
					end
				end

				arg_99_1.text_.text = var_102_14
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501024", "story_v_out_121501.awb") ~= 0 then
					local var_102_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501024", "story_v_out_121501.awb") / 1000

					if var_102_18 + var_102_10 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_18 + var_102_10
					end

					if var_102_13.prefab_name ~= "" and arg_99_1.actors_[var_102_13.prefab_name] ~= nil then
						local var_102_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_13.prefab_name].transform, "story_v_out_121501", "121501024", "story_v_out_121501.awb")

						arg_99_1:RecordAudio("121501024", var_102_19)
						arg_99_1:RecordAudio("121501024", var_102_19)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_121501", "121501024", "story_v_out_121501.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_121501", "121501024", "story_v_out_121501.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_20 = math.max(var_102_11, arg_99_1.talkMaxDuration)

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_20 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_10) / var_102_20

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_10 + var_102_20 and arg_99_1.time_ < var_102_10 + var_102_20 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play121501025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 121501025
		arg_103_1.duration_ = 6.93

		local var_103_0 = {
			ja = 6.933,
			ko = 6.566,
			zh = 6.566
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
				arg_103_0:Play121501026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1019ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1019ui_story == nil then
				arg_103_1.var_.characterEffect1019ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect1019ui_story and not isNil(var_106_0) then
					arg_103_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1019ui_story then
				arg_103_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_106_4 = arg_103_1.actors_["1029ui_story"]
			local var_106_5 = 0

			if var_106_5 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 and not isNil(var_106_4) and arg_103_1.var_.characterEffect1029ui_story == nil then
				arg_103_1.var_.characterEffect1029ui_story = var_106_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_6 = 0.200000002980232

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_6 and not isNil(var_106_4) then
				local var_106_7 = (arg_103_1.time_ - var_106_5) / var_106_6

				if arg_103_1.var_.characterEffect1029ui_story and not isNil(var_106_4) then
					local var_106_8 = Mathf.Lerp(0, 0.5, var_106_7)

					arg_103_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1029ui_story.fillRatio = var_106_8
				end
			end

			if arg_103_1.time_ >= var_106_5 + var_106_6 and arg_103_1.time_ < var_106_5 + var_106_6 + arg_106_0 and not isNil(var_106_4) and arg_103_1.var_.characterEffect1029ui_story then
				local var_106_9 = 0.5

				arg_103_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1029ui_story.fillRatio = var_106_9
			end

			local var_106_10 = 0
			local var_106_11 = 0.8

			if var_106_10 < arg_103_1.time_ and arg_103_1.time_ <= var_106_10 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_12 = arg_103_1:FormatText(StoryNameCfg[13].name)

				arg_103_1.leftNameTxt_.text = var_106_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_13 = arg_103_1:GetWordFromCfg(121501025)
				local var_106_14 = arg_103_1:FormatText(var_106_13.content)

				arg_103_1.text_.text = var_106_14

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_15 = 32
				local var_106_16 = utf8.len(var_106_14)
				local var_106_17 = var_106_15 <= 0 and var_106_11 or var_106_11 * (var_106_16 / var_106_15)

				if var_106_17 > 0 and var_106_11 < var_106_17 then
					arg_103_1.talkMaxDuration = var_106_17

					if var_106_17 + var_106_10 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_17 + var_106_10
					end
				end

				arg_103_1.text_.text = var_106_14
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501025", "story_v_out_121501.awb") ~= 0 then
					local var_106_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501025", "story_v_out_121501.awb") / 1000

					if var_106_18 + var_106_10 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_18 + var_106_10
					end

					if var_106_13.prefab_name ~= "" and arg_103_1.actors_[var_106_13.prefab_name] ~= nil then
						local var_106_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_13.prefab_name].transform, "story_v_out_121501", "121501025", "story_v_out_121501.awb")

						arg_103_1:RecordAudio("121501025", var_106_19)
						arg_103_1:RecordAudio("121501025", var_106_19)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_121501", "121501025", "story_v_out_121501.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_121501", "121501025", "story_v_out_121501.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_20 = math.max(var_106_11, arg_103_1.talkMaxDuration)

			if var_106_10 <= arg_103_1.time_ and arg_103_1.time_ < var_106_10 + var_106_20 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_10) / var_106_20

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_10 + var_106_20 and arg_103_1.time_ < var_106_10 + var_106_20 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play121501026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 121501026
		arg_107_1.duration_ = 5.7

		local var_107_0 = {
			ja = 5.133,
			ko = 5.7,
			zh = 5.7
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play121501027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1019ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1019ui_story == nil then
				arg_107_1.var_.characterEffect1019ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect1019ui_story and not isNil(var_110_0) then
					local var_110_4 = Mathf.Lerp(0, 0.5, var_110_3)

					arg_107_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1019ui_story.fillRatio = var_110_4
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1019ui_story then
				local var_110_5 = 0.5

				arg_107_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1019ui_story.fillRatio = var_110_5
			end

			local var_110_6 = arg_107_1.actors_["1029ui_story"]
			local var_110_7 = 0

			if var_110_7 < arg_107_1.time_ and arg_107_1.time_ <= var_110_7 + arg_110_0 and not isNil(var_110_6) and arg_107_1.var_.characterEffect1029ui_story == nil then
				arg_107_1.var_.characterEffect1029ui_story = var_110_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_8 = 0.200000002980232

			if var_110_7 <= arg_107_1.time_ and arg_107_1.time_ < var_110_7 + var_110_8 and not isNil(var_110_6) then
				local var_110_9 = (arg_107_1.time_ - var_110_7) / var_110_8

				if arg_107_1.var_.characterEffect1029ui_story and not isNil(var_110_6) then
					arg_107_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_7 + var_110_8 and arg_107_1.time_ < var_110_7 + var_110_8 + arg_110_0 and not isNil(var_110_6) and arg_107_1.var_.characterEffect1029ui_story then
				arg_107_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_110_10 = 0
			local var_110_11 = 0.575

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_12 = arg_107_1:FormatText(StoryNameCfg[319].name)

				arg_107_1.leftNameTxt_.text = var_110_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_13 = arg_107_1:GetWordFromCfg(121501026)
				local var_110_14 = arg_107_1:FormatText(var_110_13.content)

				arg_107_1.text_.text = var_110_14

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_15 = 23
				local var_110_16 = utf8.len(var_110_14)
				local var_110_17 = var_110_15 <= 0 and var_110_11 or var_110_11 * (var_110_16 / var_110_15)

				if var_110_17 > 0 and var_110_11 < var_110_17 then
					arg_107_1.talkMaxDuration = var_110_17

					if var_110_17 + var_110_10 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_17 + var_110_10
					end
				end

				arg_107_1.text_.text = var_110_14
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501026", "story_v_out_121501.awb") ~= 0 then
					local var_110_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501026", "story_v_out_121501.awb") / 1000

					if var_110_18 + var_110_10 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_18 + var_110_10
					end

					if var_110_13.prefab_name ~= "" and arg_107_1.actors_[var_110_13.prefab_name] ~= nil then
						local var_110_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_13.prefab_name].transform, "story_v_out_121501", "121501026", "story_v_out_121501.awb")

						arg_107_1:RecordAudio("121501026", var_110_19)
						arg_107_1:RecordAudio("121501026", var_110_19)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_121501", "121501026", "story_v_out_121501.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_121501", "121501026", "story_v_out_121501.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_20 = math.max(var_110_11, arg_107_1.talkMaxDuration)

			if var_110_10 <= arg_107_1.time_ and arg_107_1.time_ < var_110_10 + var_110_20 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_10) / var_110_20

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_10 + var_110_20 and arg_107_1.time_ < var_110_10 + var_110_20 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play121501027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 121501027
		arg_111_1.duration_ = 4.67

		local var_111_0 = {
			ja = 4.666,
			ko = 2.233,
			zh = 2.233
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
				arg_111_0:Play121501028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1019ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1019ui_story == nil then
				arg_111_1.var_.characterEffect1019ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1019ui_story and not isNil(var_114_0) then
					arg_111_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1019ui_story then
				arg_111_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_114_4 = 0

			if var_114_4 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_114_5 = 0

			if var_114_5 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_114_6 = arg_111_1.actors_["1029ui_story"]
			local var_114_7 = 0

			if var_114_7 < arg_111_1.time_ and arg_111_1.time_ <= var_114_7 + arg_114_0 and not isNil(var_114_6) and arg_111_1.var_.characterEffect1029ui_story == nil then
				arg_111_1.var_.characterEffect1029ui_story = var_114_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_8 = 0.200000002980232

			if var_114_7 <= arg_111_1.time_ and arg_111_1.time_ < var_114_7 + var_114_8 and not isNil(var_114_6) then
				local var_114_9 = (arg_111_1.time_ - var_114_7) / var_114_8

				if arg_111_1.var_.characterEffect1029ui_story and not isNil(var_114_6) then
					local var_114_10 = Mathf.Lerp(0, 0.5, var_114_9)

					arg_111_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1029ui_story.fillRatio = var_114_10
				end
			end

			if arg_111_1.time_ >= var_114_7 + var_114_8 and arg_111_1.time_ < var_114_7 + var_114_8 + arg_114_0 and not isNil(var_114_6) and arg_111_1.var_.characterEffect1029ui_story then
				local var_114_11 = 0.5

				arg_111_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1029ui_story.fillRatio = var_114_11
			end

			local var_114_12 = 0
			local var_114_13 = 0.35

			if var_114_12 < arg_111_1.time_ and arg_111_1.time_ <= var_114_12 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_14 = arg_111_1:FormatText(StoryNameCfg[13].name)

				arg_111_1.leftNameTxt_.text = var_114_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_15 = arg_111_1:GetWordFromCfg(121501027)
				local var_114_16 = arg_111_1:FormatText(var_114_15.content)

				arg_111_1.text_.text = var_114_16

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_17 = 14
				local var_114_18 = utf8.len(var_114_16)
				local var_114_19 = var_114_17 <= 0 and var_114_13 or var_114_13 * (var_114_18 / var_114_17)

				if var_114_19 > 0 and var_114_13 < var_114_19 then
					arg_111_1.talkMaxDuration = var_114_19

					if var_114_19 + var_114_12 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_19 + var_114_12
					end
				end

				arg_111_1.text_.text = var_114_16
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501027", "story_v_out_121501.awb") ~= 0 then
					local var_114_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501027", "story_v_out_121501.awb") / 1000

					if var_114_20 + var_114_12 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_20 + var_114_12
					end

					if var_114_15.prefab_name ~= "" and arg_111_1.actors_[var_114_15.prefab_name] ~= nil then
						local var_114_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_15.prefab_name].transform, "story_v_out_121501", "121501027", "story_v_out_121501.awb")

						arg_111_1:RecordAudio("121501027", var_114_21)
						arg_111_1:RecordAudio("121501027", var_114_21)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_121501", "121501027", "story_v_out_121501.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_121501", "121501027", "story_v_out_121501.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_22 = math.max(var_114_13, arg_111_1.talkMaxDuration)

			if var_114_12 <= arg_111_1.time_ and arg_111_1.time_ < var_114_12 + var_114_22 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_12) / var_114_22

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_12 + var_114_22 and arg_111_1.time_ < var_114_12 + var_114_22 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play121501028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 121501028
		arg_115_1.duration_ = 11.3

		local var_115_0 = {
			ja = 4.833,
			ko = 11.3,
			zh = 11.3
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
				arg_115_0:Play121501029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1029ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1029ui_story == nil then
				arg_115_1.var_.characterEffect1029ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1029ui_story and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1029ui_story then
				arg_115_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_118_4 = 0

			if var_118_4 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action5_1")
			end

			local var_118_5 = 0

			if var_118_5 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_118_6 = arg_115_1.actors_["1019ui_story"]
			local var_118_7 = 0

			if var_118_7 < arg_115_1.time_ and arg_115_1.time_ <= var_118_7 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect1019ui_story == nil then
				arg_115_1.var_.characterEffect1019ui_story = var_118_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_8 = 0.200000002980232

			if var_118_7 <= arg_115_1.time_ and arg_115_1.time_ < var_118_7 + var_118_8 and not isNil(var_118_6) then
				local var_118_9 = (arg_115_1.time_ - var_118_7) / var_118_8

				if arg_115_1.var_.characterEffect1019ui_story and not isNil(var_118_6) then
					local var_118_10 = Mathf.Lerp(0, 0.5, var_118_9)

					arg_115_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1019ui_story.fillRatio = var_118_10
				end
			end

			if arg_115_1.time_ >= var_118_7 + var_118_8 and arg_115_1.time_ < var_118_7 + var_118_8 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect1019ui_story then
				local var_118_11 = 0.5

				arg_115_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1019ui_story.fillRatio = var_118_11
			end

			local var_118_12 = 0
			local var_118_13 = 0.975

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_14 = arg_115_1:FormatText(StoryNameCfg[319].name)

				arg_115_1.leftNameTxt_.text = var_118_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_15 = arg_115_1:GetWordFromCfg(121501028)
				local var_118_16 = arg_115_1:FormatText(var_118_15.content)

				arg_115_1.text_.text = var_118_16

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_17 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501028", "story_v_out_121501.awb") ~= 0 then
					local var_118_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501028", "story_v_out_121501.awb") / 1000

					if var_118_20 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_20 + var_118_12
					end

					if var_118_15.prefab_name ~= "" and arg_115_1.actors_[var_118_15.prefab_name] ~= nil then
						local var_118_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_15.prefab_name].transform, "story_v_out_121501", "121501028", "story_v_out_121501.awb")

						arg_115_1:RecordAudio("121501028", var_118_21)
						arg_115_1:RecordAudio("121501028", var_118_21)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_121501", "121501028", "story_v_out_121501.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_121501", "121501028", "story_v_out_121501.awb")
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
	Play121501029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 121501029
		arg_119_1.duration_ = 8.63

		local var_119_0 = {
			ja = 8.2,
			ko = 8.633,
			zh = 8.633
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
				arg_119_0:Play121501030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1019ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1019ui_story == nil then
				arg_119_1.var_.characterEffect1019ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect1019ui_story and not isNil(var_122_0) then
					arg_119_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1019ui_story then
				arg_119_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_122_4 = 0

			if var_122_4 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action457")
			end

			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_122_6 = arg_119_1.actors_["1029ui_story"]
			local var_122_7 = 0

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect1029ui_story == nil then
				arg_119_1.var_.characterEffect1029ui_story = var_122_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_8 = 0.200000002980232

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_8 and not isNil(var_122_6) then
				local var_122_9 = (arg_119_1.time_ - var_122_7) / var_122_8

				if arg_119_1.var_.characterEffect1029ui_story and not isNil(var_122_6) then
					local var_122_10 = Mathf.Lerp(0, 0.5, var_122_9)

					arg_119_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1029ui_story.fillRatio = var_122_10
				end
			end

			if arg_119_1.time_ >= var_122_7 + var_122_8 and arg_119_1.time_ < var_122_7 + var_122_8 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect1029ui_story then
				local var_122_11 = 0.5

				arg_119_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1029ui_story.fillRatio = var_122_11
			end

			local var_122_12 = 0
			local var_122_13 = 0.8

			if var_122_12 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_14 = arg_119_1:FormatText(StoryNameCfg[13].name)

				arg_119_1.leftNameTxt_.text = var_122_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_15 = arg_119_1:GetWordFromCfg(121501029)
				local var_122_16 = arg_119_1:FormatText(var_122_15.content)

				arg_119_1.text_.text = var_122_16

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_17 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501029", "story_v_out_121501.awb") ~= 0 then
					local var_122_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501029", "story_v_out_121501.awb") / 1000

					if var_122_20 + var_122_12 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_20 + var_122_12
					end

					if var_122_15.prefab_name ~= "" and arg_119_1.actors_[var_122_15.prefab_name] ~= nil then
						local var_122_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_15.prefab_name].transform, "story_v_out_121501", "121501029", "story_v_out_121501.awb")

						arg_119_1:RecordAudio("121501029", var_122_21)
						arg_119_1:RecordAudio("121501029", var_122_21)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_121501", "121501029", "story_v_out_121501.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_121501", "121501029", "story_v_out_121501.awb")
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
	Play121501030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 121501030
		arg_123_1.duration_ = 7.67

		local var_123_0 = {
			ja = 7.666,
			ko = 5.733,
			zh = 5.733
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
				arg_123_0:Play121501031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action475")
			end

			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_2 = 0
			local var_126_3 = 0.8

			if var_126_2 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_4 = arg_123_1:FormatText(StoryNameCfg[13].name)

				arg_123_1.leftNameTxt_.text = var_126_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_5 = arg_123_1:GetWordFromCfg(121501030)
				local var_126_6 = arg_123_1:FormatText(var_126_5.content)

				arg_123_1.text_.text = var_126_6

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_7 = 32
				local var_126_8 = utf8.len(var_126_6)
				local var_126_9 = var_126_7 <= 0 and var_126_3 or var_126_3 * (var_126_8 / var_126_7)

				if var_126_9 > 0 and var_126_3 < var_126_9 then
					arg_123_1.talkMaxDuration = var_126_9

					if var_126_9 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_2
					end
				end

				arg_123_1.text_.text = var_126_6
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501030", "story_v_out_121501.awb") ~= 0 then
					local var_126_10 = manager.audio:GetVoiceLength("story_v_out_121501", "121501030", "story_v_out_121501.awb") / 1000

					if var_126_10 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_2
					end

					if var_126_5.prefab_name ~= "" and arg_123_1.actors_[var_126_5.prefab_name] ~= nil then
						local var_126_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_5.prefab_name].transform, "story_v_out_121501", "121501030", "story_v_out_121501.awb")

						arg_123_1:RecordAudio("121501030", var_126_11)
						arg_123_1:RecordAudio("121501030", var_126_11)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_121501", "121501030", "story_v_out_121501.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_121501", "121501030", "story_v_out_121501.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_12 = math.max(var_126_3, arg_123_1.talkMaxDuration)

			if var_126_2 <= arg_123_1.time_ and arg_123_1.time_ < var_126_2 + var_126_12 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_2) / var_126_12

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_2 + var_126_12 and arg_123_1.time_ < var_126_2 + var_126_12 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play121501031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 121501031
		arg_127_1.duration_ = 2.83

		local var_127_0 = {
			ja = 1.466,
			ko = 2.833,
			zh = 2.833
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
				arg_127_0:Play121501032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1019ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1019ui_story == nil then
				arg_127_1.var_.characterEffect1019ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect1019ui_story and not isNil(var_130_0) then
					local var_130_4 = Mathf.Lerp(0, 0.5, var_130_3)

					arg_127_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1019ui_story.fillRatio = var_130_4
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1019ui_story then
				local var_130_5 = 0.5

				arg_127_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1019ui_story.fillRatio = var_130_5
			end

			local var_130_6 = arg_127_1.actors_["1029ui_story"]
			local var_130_7 = 0

			if var_130_7 < arg_127_1.time_ and arg_127_1.time_ <= var_130_7 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect1029ui_story == nil then
				arg_127_1.var_.characterEffect1029ui_story = var_130_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_8 = 0.200000002980232

			if var_130_7 <= arg_127_1.time_ and arg_127_1.time_ < var_130_7 + var_130_8 and not isNil(var_130_6) then
				local var_130_9 = (arg_127_1.time_ - var_130_7) / var_130_8

				if arg_127_1.var_.characterEffect1029ui_story and not isNil(var_130_6) then
					arg_127_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_7 + var_130_8 and arg_127_1.time_ < var_130_7 + var_130_8 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect1029ui_story then
				arg_127_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_130_10 = 0
			local var_130_11 = 0.175

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_12 = arg_127_1:FormatText(StoryNameCfg[319].name)

				arg_127_1.leftNameTxt_.text = var_130_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_13 = arg_127_1:GetWordFromCfg(121501031)
				local var_130_14 = arg_127_1:FormatText(var_130_13.content)

				arg_127_1.text_.text = var_130_14

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_15 = 7
				local var_130_16 = utf8.len(var_130_14)
				local var_130_17 = var_130_15 <= 0 and var_130_11 or var_130_11 * (var_130_16 / var_130_15)

				if var_130_17 > 0 and var_130_11 < var_130_17 then
					arg_127_1.talkMaxDuration = var_130_17

					if var_130_17 + var_130_10 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_17 + var_130_10
					end
				end

				arg_127_1.text_.text = var_130_14
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501031", "story_v_out_121501.awb") ~= 0 then
					local var_130_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501031", "story_v_out_121501.awb") / 1000

					if var_130_18 + var_130_10 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_18 + var_130_10
					end

					if var_130_13.prefab_name ~= "" and arg_127_1.actors_[var_130_13.prefab_name] ~= nil then
						local var_130_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_13.prefab_name].transform, "story_v_out_121501", "121501031", "story_v_out_121501.awb")

						arg_127_1:RecordAudio("121501031", var_130_19)
						arg_127_1:RecordAudio("121501031", var_130_19)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_121501", "121501031", "story_v_out_121501.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_121501", "121501031", "story_v_out_121501.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_20 = math.max(var_130_11, arg_127_1.talkMaxDuration)

			if var_130_10 <= arg_127_1.time_ and arg_127_1.time_ < var_130_10 + var_130_20 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_10) / var_130_20

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_10 + var_130_20 and arg_127_1.time_ < var_130_10 + var_130_20 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play121501032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 121501032
		arg_131_1.duration_ = 14.93

		local var_131_0 = {
			ja = 14.933,
			ko = 11.6,
			zh = 11.6
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
				arg_131_0:Play121501033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1019ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1019ui_story == nil then
				arg_131_1.var_.characterEffect1019ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect1019ui_story and not isNil(var_134_0) then
					arg_131_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1019ui_story then
				arg_131_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_134_4 = arg_131_1.actors_["1029ui_story"]
			local var_134_5 = 0

			if var_134_5 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect1029ui_story == nil then
				arg_131_1.var_.characterEffect1029ui_story = var_134_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_6 = 0.200000002980232

			if var_134_5 <= arg_131_1.time_ and arg_131_1.time_ < var_134_5 + var_134_6 and not isNil(var_134_4) then
				local var_134_7 = (arg_131_1.time_ - var_134_5) / var_134_6

				if arg_131_1.var_.characterEffect1029ui_story and not isNil(var_134_4) then
					local var_134_8 = Mathf.Lerp(0, 0.5, var_134_7)

					arg_131_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1029ui_story.fillRatio = var_134_8
				end
			end

			if arg_131_1.time_ >= var_134_5 + var_134_6 and arg_131_1.time_ < var_134_5 + var_134_6 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect1029ui_story then
				local var_134_9 = 0.5

				arg_131_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1029ui_story.fillRatio = var_134_9
			end

			local var_134_10 = 0
			local var_134_11 = 1.25

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_12 = arg_131_1:FormatText(StoryNameCfg[13].name)

				arg_131_1.leftNameTxt_.text = var_134_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_13 = arg_131_1:GetWordFromCfg(121501032)
				local var_134_14 = arg_131_1:FormatText(var_134_13.content)

				arg_131_1.text_.text = var_134_14

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_15 = 50
				local var_134_16 = utf8.len(var_134_14)
				local var_134_17 = var_134_15 <= 0 and var_134_11 or var_134_11 * (var_134_16 / var_134_15)

				if var_134_17 > 0 and var_134_11 < var_134_17 then
					arg_131_1.talkMaxDuration = var_134_17

					if var_134_17 + var_134_10 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_17 + var_134_10
					end
				end

				arg_131_1.text_.text = var_134_14
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501032", "story_v_out_121501.awb") ~= 0 then
					local var_134_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501032", "story_v_out_121501.awb") / 1000

					if var_134_18 + var_134_10 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_18 + var_134_10
					end

					if var_134_13.prefab_name ~= "" and arg_131_1.actors_[var_134_13.prefab_name] ~= nil then
						local var_134_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_13.prefab_name].transform, "story_v_out_121501", "121501032", "story_v_out_121501.awb")

						arg_131_1:RecordAudio("121501032", var_134_19)
						arg_131_1:RecordAudio("121501032", var_134_19)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_121501", "121501032", "story_v_out_121501.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_121501", "121501032", "story_v_out_121501.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_20 = math.max(var_134_11, arg_131_1.talkMaxDuration)

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_20 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_10) / var_134_20

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_10 + var_134_20 and arg_131_1.time_ < var_134_10 + var_134_20 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play121501033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 121501033
		arg_135_1.duration_ = 10.3

		local var_135_0 = {
			ja = 10.3,
			ko = 9.966,
			zh = 9.966
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
				arg_135_0:Play121501034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 1.2

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[13].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_3 = arg_135_1:GetWordFromCfg(121501033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 48
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501033", "story_v_out_121501.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_121501", "121501033", "story_v_out_121501.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_121501", "121501033", "story_v_out_121501.awb")

						arg_135_1:RecordAudio("121501033", var_138_9)
						arg_135_1:RecordAudio("121501033", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_121501", "121501033", "story_v_out_121501.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_121501", "121501033", "story_v_out_121501.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_10 and arg_135_1.time_ < var_138_0 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play121501034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 121501034
		arg_139_1.duration_ = 7.57

		local var_139_0 = {
			ja = 7.566,
			ko = 6.7,
			zh = 6.7
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
				arg_139_0:Play121501035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action5_2")
			end

			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_2 = arg_139_1.actors_["1019ui_story"]
			local var_142_3 = 0

			if var_142_3 < arg_139_1.time_ and arg_139_1.time_ <= var_142_3 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.characterEffect1019ui_story == nil then
				arg_139_1.var_.characterEffect1019ui_story = var_142_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_4 = 0.200000002980232

			if var_142_3 <= arg_139_1.time_ and arg_139_1.time_ < var_142_3 + var_142_4 and not isNil(var_142_2) then
				local var_142_5 = (arg_139_1.time_ - var_142_3) / var_142_4

				if arg_139_1.var_.characterEffect1019ui_story and not isNil(var_142_2) then
					local var_142_6 = Mathf.Lerp(0, 0.5, var_142_5)

					arg_139_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1019ui_story.fillRatio = var_142_6
				end
			end

			if arg_139_1.time_ >= var_142_3 + var_142_4 and arg_139_1.time_ < var_142_3 + var_142_4 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.characterEffect1019ui_story then
				local var_142_7 = 0.5

				arg_139_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1019ui_story.fillRatio = var_142_7
			end

			local var_142_8 = arg_139_1.actors_["1029ui_story"]
			local var_142_9 = 0

			if var_142_9 < arg_139_1.time_ and arg_139_1.time_ <= var_142_9 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.characterEffect1029ui_story == nil then
				arg_139_1.var_.characterEffect1029ui_story = var_142_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_10 = 0.200000002980232

			if var_142_9 <= arg_139_1.time_ and arg_139_1.time_ < var_142_9 + var_142_10 and not isNil(var_142_8) then
				local var_142_11 = (arg_139_1.time_ - var_142_9) / var_142_10

				if arg_139_1.var_.characterEffect1029ui_story and not isNil(var_142_8) then
					arg_139_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_9 + var_142_10 and arg_139_1.time_ < var_142_9 + var_142_10 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.characterEffect1029ui_story then
				arg_139_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_142_12 = 0
			local var_142_13 = 0.6

			if var_142_12 < arg_139_1.time_ and arg_139_1.time_ <= var_142_12 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_14 = arg_139_1:FormatText(StoryNameCfg[319].name)

				arg_139_1.leftNameTxt_.text = var_142_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_15 = arg_139_1:GetWordFromCfg(121501034)
				local var_142_16 = arg_139_1:FormatText(var_142_15.content)

				arg_139_1.text_.text = var_142_16

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_17 = 24
				local var_142_18 = utf8.len(var_142_16)
				local var_142_19 = var_142_17 <= 0 and var_142_13 or var_142_13 * (var_142_18 / var_142_17)

				if var_142_19 > 0 and var_142_13 < var_142_19 then
					arg_139_1.talkMaxDuration = var_142_19

					if var_142_19 + var_142_12 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_19 + var_142_12
					end
				end

				arg_139_1.text_.text = var_142_16
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501034", "story_v_out_121501.awb") ~= 0 then
					local var_142_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501034", "story_v_out_121501.awb") / 1000

					if var_142_20 + var_142_12 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_20 + var_142_12
					end

					if var_142_15.prefab_name ~= "" and arg_139_1.actors_[var_142_15.prefab_name] ~= nil then
						local var_142_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_15.prefab_name].transform, "story_v_out_121501", "121501034", "story_v_out_121501.awb")

						arg_139_1:RecordAudio("121501034", var_142_21)
						arg_139_1:RecordAudio("121501034", var_142_21)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_121501", "121501034", "story_v_out_121501.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_121501", "121501034", "story_v_out_121501.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_22 = math.max(var_142_13, arg_139_1.talkMaxDuration)

			if var_142_12 <= arg_139_1.time_ and arg_139_1.time_ < var_142_12 + var_142_22 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_12) / var_142_22

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_12 + var_142_22 and arg_139_1.time_ < var_142_12 + var_142_22 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play121501035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 121501035
		arg_143_1.duration_ = 11.1

		local var_143_0 = {
			ja = 11.1,
			ko = 9.5,
			zh = 9.5
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
				arg_143_0:Play121501036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1019ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1019ui_story == nil then
				arg_143_1.var_.characterEffect1019ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1019ui_story and not isNil(var_146_0) then
					arg_143_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1019ui_story then
				arg_143_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_146_4 = 0

			if var_146_4 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_146_5 = arg_143_1.actors_["1029ui_story"]
			local var_146_6 = 0

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 and not isNil(var_146_5) and arg_143_1.var_.characterEffect1029ui_story == nil then
				arg_143_1.var_.characterEffect1029ui_story = var_146_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_7 = 0.200000002980232

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_7 and not isNil(var_146_5) then
				local var_146_8 = (arg_143_1.time_ - var_146_6) / var_146_7

				if arg_143_1.var_.characterEffect1029ui_story and not isNil(var_146_5) then
					local var_146_9 = Mathf.Lerp(0, 0.5, var_146_8)

					arg_143_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1029ui_story.fillRatio = var_146_9
				end
			end

			if arg_143_1.time_ >= var_146_6 + var_146_7 and arg_143_1.time_ < var_146_6 + var_146_7 + arg_146_0 and not isNil(var_146_5) and arg_143_1.var_.characterEffect1029ui_story then
				local var_146_10 = 0.5

				arg_143_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1029ui_story.fillRatio = var_146_10
			end

			local var_146_11 = 0
			local var_146_12 = 0.85

			if var_146_11 < arg_143_1.time_ and arg_143_1.time_ <= var_146_11 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_13 = arg_143_1:FormatText(StoryNameCfg[13].name)

				arg_143_1.leftNameTxt_.text = var_146_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_14 = arg_143_1:GetWordFromCfg(121501035)
				local var_146_15 = arg_143_1:FormatText(var_146_14.content)

				arg_143_1.text_.text = var_146_15

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_16 = 34
				local var_146_17 = utf8.len(var_146_15)
				local var_146_18 = var_146_16 <= 0 and var_146_12 or var_146_12 * (var_146_17 / var_146_16)

				if var_146_18 > 0 and var_146_12 < var_146_18 then
					arg_143_1.talkMaxDuration = var_146_18

					if var_146_18 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_18 + var_146_11
					end
				end

				arg_143_1.text_.text = var_146_15
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501035", "story_v_out_121501.awb") ~= 0 then
					local var_146_19 = manager.audio:GetVoiceLength("story_v_out_121501", "121501035", "story_v_out_121501.awb") / 1000

					if var_146_19 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_19 + var_146_11
					end

					if var_146_14.prefab_name ~= "" and arg_143_1.actors_[var_146_14.prefab_name] ~= nil then
						local var_146_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_14.prefab_name].transform, "story_v_out_121501", "121501035", "story_v_out_121501.awb")

						arg_143_1:RecordAudio("121501035", var_146_20)
						arg_143_1:RecordAudio("121501035", var_146_20)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_121501", "121501035", "story_v_out_121501.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_121501", "121501035", "story_v_out_121501.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_21 = math.max(var_146_12, arg_143_1.talkMaxDuration)

			if var_146_11 <= arg_143_1.time_ and arg_143_1.time_ < var_146_11 + var_146_21 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_11) / var_146_21

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_11 + var_146_21 and arg_143_1.time_ < var_146_11 + var_146_21 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play121501036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 121501036
		arg_147_1.duration_ = 5.97

		local var_147_0 = {
			ja = 5.966,
			ko = 3.033,
			zh = 3.033
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
				arg_147_0:Play121501037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1029ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1029ui_story == nil then
				arg_147_1.var_.characterEffect1029ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect1029ui_story and not isNil(var_150_0) then
					arg_147_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1029ui_story then
				arg_147_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_150_4 = 0

			if var_150_4 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_150_5 = 0

			if var_150_5 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_150_6 = arg_147_1.actors_["1019ui_story"]
			local var_150_7 = 0

			if var_150_7 < arg_147_1.time_ and arg_147_1.time_ <= var_150_7 + arg_150_0 and not isNil(var_150_6) and arg_147_1.var_.characterEffect1019ui_story == nil then
				arg_147_1.var_.characterEffect1019ui_story = var_150_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_8 = 0.200000002980232

			if var_150_7 <= arg_147_1.time_ and arg_147_1.time_ < var_150_7 + var_150_8 and not isNil(var_150_6) then
				local var_150_9 = (arg_147_1.time_ - var_150_7) / var_150_8

				if arg_147_1.var_.characterEffect1019ui_story and not isNil(var_150_6) then
					local var_150_10 = Mathf.Lerp(0, 0.5, var_150_9)

					arg_147_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1019ui_story.fillRatio = var_150_10
				end
			end

			if arg_147_1.time_ >= var_150_7 + var_150_8 and arg_147_1.time_ < var_150_7 + var_150_8 + arg_150_0 and not isNil(var_150_6) and arg_147_1.var_.characterEffect1019ui_story then
				local var_150_11 = 0.5

				arg_147_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1019ui_story.fillRatio = var_150_11
			end

			local var_150_12 = 0
			local var_150_13 = 0.425

			if var_150_12 < arg_147_1.time_ and arg_147_1.time_ <= var_150_12 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_14 = arg_147_1:FormatText(StoryNameCfg[319].name)

				arg_147_1.leftNameTxt_.text = var_150_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_15 = arg_147_1:GetWordFromCfg(121501036)
				local var_150_16 = arg_147_1:FormatText(var_150_15.content)

				arg_147_1.text_.text = var_150_16

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_17 = 17
				local var_150_18 = utf8.len(var_150_16)
				local var_150_19 = var_150_17 <= 0 and var_150_13 or var_150_13 * (var_150_18 / var_150_17)

				if var_150_19 > 0 and var_150_13 < var_150_19 then
					arg_147_1.talkMaxDuration = var_150_19

					if var_150_19 + var_150_12 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_19 + var_150_12
					end
				end

				arg_147_1.text_.text = var_150_16
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501036", "story_v_out_121501.awb") ~= 0 then
					local var_150_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501036", "story_v_out_121501.awb") / 1000

					if var_150_20 + var_150_12 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_20 + var_150_12
					end

					if var_150_15.prefab_name ~= "" and arg_147_1.actors_[var_150_15.prefab_name] ~= nil then
						local var_150_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_15.prefab_name].transform, "story_v_out_121501", "121501036", "story_v_out_121501.awb")

						arg_147_1:RecordAudio("121501036", var_150_21)
						arg_147_1:RecordAudio("121501036", var_150_21)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_121501", "121501036", "story_v_out_121501.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_121501", "121501036", "story_v_out_121501.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_22 = math.max(var_150_13, arg_147_1.talkMaxDuration)

			if var_150_12 <= arg_147_1.time_ and arg_147_1.time_ < var_150_12 + var_150_22 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_12) / var_150_22

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_12 + var_150_22 and arg_147_1.time_ < var_150_12 + var_150_22 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play121501037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 121501037
		arg_151_1.duration_ = 5.67

		local var_151_0 = {
			ja = 3.566,
			ko = 5.666,
			zh = 5.666
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
				arg_151_0:Play121501038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1019ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1019ui_story == nil then
				arg_151_1.var_.characterEffect1019ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1019ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1019ui_story then
				arg_151_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_154_4 = 0

			if var_154_4 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_154_5 = 0

			if var_154_5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_154_6 = arg_151_1.actors_["1029ui_story"]
			local var_154_7 = 0

			if var_154_7 < arg_151_1.time_ and arg_151_1.time_ <= var_154_7 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect1029ui_story == nil then
				arg_151_1.var_.characterEffect1029ui_story = var_154_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_8 = 0.200000002980232

			if var_154_7 <= arg_151_1.time_ and arg_151_1.time_ < var_154_7 + var_154_8 and not isNil(var_154_6) then
				local var_154_9 = (arg_151_1.time_ - var_154_7) / var_154_8

				if arg_151_1.var_.characterEffect1029ui_story and not isNil(var_154_6) then
					local var_154_10 = Mathf.Lerp(0, 0.5, var_154_9)

					arg_151_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1029ui_story.fillRatio = var_154_10
				end
			end

			if arg_151_1.time_ >= var_154_7 + var_154_8 and arg_151_1.time_ < var_154_7 + var_154_8 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect1029ui_story then
				local var_154_11 = 0.5

				arg_151_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1029ui_story.fillRatio = var_154_11
			end

			local var_154_12 = 0
			local var_154_13 = 0.75

			if var_154_12 < arg_151_1.time_ and arg_151_1.time_ <= var_154_12 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_14 = arg_151_1:FormatText(StoryNameCfg[13].name)

				arg_151_1.leftNameTxt_.text = var_154_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_15 = arg_151_1:GetWordFromCfg(121501037)
				local var_154_16 = arg_151_1:FormatText(var_154_15.content)

				arg_151_1.text_.text = var_154_16

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_17 = 30
				local var_154_18 = utf8.len(var_154_16)
				local var_154_19 = var_154_17 <= 0 and var_154_13 or var_154_13 * (var_154_18 / var_154_17)

				if var_154_19 > 0 and var_154_13 < var_154_19 then
					arg_151_1.talkMaxDuration = var_154_19

					if var_154_19 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_19 + var_154_12
					end
				end

				arg_151_1.text_.text = var_154_16
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501037", "story_v_out_121501.awb") ~= 0 then
					local var_154_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501037", "story_v_out_121501.awb") / 1000

					if var_154_20 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_20 + var_154_12
					end

					if var_154_15.prefab_name ~= "" and arg_151_1.actors_[var_154_15.prefab_name] ~= nil then
						local var_154_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_15.prefab_name].transform, "story_v_out_121501", "121501037", "story_v_out_121501.awb")

						arg_151_1:RecordAudio("121501037", var_154_21)
						arg_151_1:RecordAudio("121501037", var_154_21)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_121501", "121501037", "story_v_out_121501.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_121501", "121501037", "story_v_out_121501.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_22 = math.max(var_154_13, arg_151_1.talkMaxDuration)

			if var_154_12 <= arg_151_1.time_ and arg_151_1.time_ < var_154_12 + var_154_22 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_12) / var_154_22

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_12 + var_154_22 and arg_151_1.time_ < var_154_12 + var_154_22 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play121501038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 121501038
		arg_155_1.duration_ = 4.1

		local var_155_0 = {
			ja = 4.1,
			ko = 3.333,
			zh = 3.333
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
				arg_155_0:Play121501039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1029ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1029ui_story == nil then
				arg_155_1.var_.characterEffect1029ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect1029ui_story and not isNil(var_158_0) then
					arg_155_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1029ui_story then
				arg_155_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_158_4 = 0

			if var_158_4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_158_5 = 0

			if var_158_5 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_158_6 = arg_155_1.actors_["1019ui_story"]
			local var_158_7 = 0

			if var_158_7 < arg_155_1.time_ and arg_155_1.time_ <= var_158_7 + arg_158_0 and not isNil(var_158_6) and arg_155_1.var_.characterEffect1019ui_story == nil then
				arg_155_1.var_.characterEffect1019ui_story = var_158_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_8 = 0.200000002980232

			if var_158_7 <= arg_155_1.time_ and arg_155_1.time_ < var_158_7 + var_158_8 and not isNil(var_158_6) then
				local var_158_9 = (arg_155_1.time_ - var_158_7) / var_158_8

				if arg_155_1.var_.characterEffect1019ui_story and not isNil(var_158_6) then
					local var_158_10 = Mathf.Lerp(0, 0.5, var_158_9)

					arg_155_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1019ui_story.fillRatio = var_158_10
				end
			end

			if arg_155_1.time_ >= var_158_7 + var_158_8 and arg_155_1.time_ < var_158_7 + var_158_8 + arg_158_0 and not isNil(var_158_6) and arg_155_1.var_.characterEffect1019ui_story then
				local var_158_11 = 0.5

				arg_155_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1019ui_story.fillRatio = var_158_11
			end

			local var_158_12 = 0
			local var_158_13 = 0.25

			if var_158_12 < arg_155_1.time_ and arg_155_1.time_ <= var_158_12 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_14 = arg_155_1:FormatText(StoryNameCfg[319].name)

				arg_155_1.leftNameTxt_.text = var_158_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_15 = arg_155_1:GetWordFromCfg(121501038)
				local var_158_16 = arg_155_1:FormatText(var_158_15.content)

				arg_155_1.text_.text = var_158_16

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_17 = 10
				local var_158_18 = utf8.len(var_158_16)
				local var_158_19 = var_158_17 <= 0 and var_158_13 or var_158_13 * (var_158_18 / var_158_17)

				if var_158_19 > 0 and var_158_13 < var_158_19 then
					arg_155_1.talkMaxDuration = var_158_19

					if var_158_19 + var_158_12 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_19 + var_158_12
					end
				end

				arg_155_1.text_.text = var_158_16
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501038", "story_v_out_121501.awb") ~= 0 then
					local var_158_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501038", "story_v_out_121501.awb") / 1000

					if var_158_20 + var_158_12 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_20 + var_158_12
					end

					if var_158_15.prefab_name ~= "" and arg_155_1.actors_[var_158_15.prefab_name] ~= nil then
						local var_158_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_15.prefab_name].transform, "story_v_out_121501", "121501038", "story_v_out_121501.awb")

						arg_155_1:RecordAudio("121501038", var_158_21)
						arg_155_1:RecordAudio("121501038", var_158_21)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_121501", "121501038", "story_v_out_121501.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_121501", "121501038", "story_v_out_121501.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_22 = math.max(var_158_13, arg_155_1.talkMaxDuration)

			if var_158_12 <= arg_155_1.time_ and arg_155_1.time_ < var_158_12 + var_158_22 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_12) / var_158_22

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_12 + var_158_22 and arg_155_1.time_ < var_158_12 + var_158_22 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play121501039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 121501039
		arg_159_1.duration_ = 12.63

		local var_159_0 = {
			ja = 12.633,
			ko = 3.833,
			zh = 3.833
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play121501040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1019ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1019ui_story == nil then
				arg_159_1.var_.characterEffect1019ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect1019ui_story and not isNil(var_162_0) then
					arg_159_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1019ui_story then
				arg_159_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_162_4 = 0

			if var_162_4 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			local var_162_5 = 0

			if var_162_5 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_162_6 = arg_159_1.actors_["1029ui_story"]
			local var_162_7 = 0

			if var_162_7 < arg_159_1.time_ and arg_159_1.time_ <= var_162_7 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect1029ui_story == nil then
				arg_159_1.var_.characterEffect1029ui_story = var_162_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_8 = 0.200000002980232

			if var_162_7 <= arg_159_1.time_ and arg_159_1.time_ < var_162_7 + var_162_8 and not isNil(var_162_6) then
				local var_162_9 = (arg_159_1.time_ - var_162_7) / var_162_8

				if arg_159_1.var_.characterEffect1029ui_story and not isNil(var_162_6) then
					local var_162_10 = Mathf.Lerp(0, 0.5, var_162_9)

					arg_159_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1029ui_story.fillRatio = var_162_10
				end
			end

			if arg_159_1.time_ >= var_162_7 + var_162_8 and arg_159_1.time_ < var_162_7 + var_162_8 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect1029ui_story then
				local var_162_11 = 0.5

				arg_159_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1029ui_story.fillRatio = var_162_11
			end

			local var_162_12 = 0
			local var_162_13 = 0.5

			if var_162_12 < arg_159_1.time_ and arg_159_1.time_ <= var_162_12 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_14 = arg_159_1:FormatText(StoryNameCfg[13].name)

				arg_159_1.leftNameTxt_.text = var_162_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_15 = arg_159_1:GetWordFromCfg(121501039)
				local var_162_16 = arg_159_1:FormatText(var_162_15.content)

				arg_159_1.text_.text = var_162_16

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_17 = 20
				local var_162_18 = utf8.len(var_162_16)
				local var_162_19 = var_162_17 <= 0 and var_162_13 or var_162_13 * (var_162_18 / var_162_17)

				if var_162_19 > 0 and var_162_13 < var_162_19 then
					arg_159_1.talkMaxDuration = var_162_19

					if var_162_19 + var_162_12 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_19 + var_162_12
					end
				end

				arg_159_1.text_.text = var_162_16
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501039", "story_v_out_121501.awb") ~= 0 then
					local var_162_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501039", "story_v_out_121501.awb") / 1000

					if var_162_20 + var_162_12 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_20 + var_162_12
					end

					if var_162_15.prefab_name ~= "" and arg_159_1.actors_[var_162_15.prefab_name] ~= nil then
						local var_162_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_15.prefab_name].transform, "story_v_out_121501", "121501039", "story_v_out_121501.awb")

						arg_159_1:RecordAudio("121501039", var_162_21)
						arg_159_1:RecordAudio("121501039", var_162_21)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_121501", "121501039", "story_v_out_121501.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_121501", "121501039", "story_v_out_121501.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_22 = math.max(var_162_13, arg_159_1.talkMaxDuration)

			if var_162_12 <= arg_159_1.time_ and arg_159_1.time_ < var_162_12 + var_162_22 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_12) / var_162_22

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_12 + var_162_22 and arg_159_1.time_ < var_162_12 + var_162_22 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play121501040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 121501040
		arg_163_1.duration_ = 6.83

		local var_163_0 = {
			ja = 6.1,
			ko = 6.833,
			zh = 6.833
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
				arg_163_0:Play121501041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1019ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1019ui_story == nil then
				arg_163_1.var_.characterEffect1019ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1019ui_story and not isNil(var_166_0) then
					local var_166_4 = Mathf.Lerp(0, 0.5, var_166_3)

					arg_163_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1019ui_story.fillRatio = var_166_4
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1019ui_story then
				local var_166_5 = 0.5

				arg_163_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1019ui_story.fillRatio = var_166_5
			end

			local var_166_6 = arg_163_1.actors_["1029ui_story"]
			local var_166_7 = 0

			if var_166_7 < arg_163_1.time_ and arg_163_1.time_ <= var_166_7 + arg_166_0 and not isNil(var_166_6) and arg_163_1.var_.characterEffect1029ui_story == nil then
				arg_163_1.var_.characterEffect1029ui_story = var_166_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_8 = 0.200000002980232

			if var_166_7 <= arg_163_1.time_ and arg_163_1.time_ < var_166_7 + var_166_8 and not isNil(var_166_6) then
				local var_166_9 = (arg_163_1.time_ - var_166_7) / var_166_8

				if arg_163_1.var_.characterEffect1029ui_story and not isNil(var_166_6) then
					arg_163_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_7 + var_166_8 and arg_163_1.time_ < var_166_7 + var_166_8 + arg_166_0 and not isNil(var_166_6) and arg_163_1.var_.characterEffect1029ui_story then
				arg_163_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_166_10 = 0
			local var_166_11 = 0.825

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_12 = arg_163_1:FormatText(StoryNameCfg[319].name)

				arg_163_1.leftNameTxt_.text = var_166_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_13 = arg_163_1:GetWordFromCfg(121501040)
				local var_166_14 = arg_163_1:FormatText(var_166_13.content)

				arg_163_1.text_.text = var_166_14

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_15 = 33
				local var_166_16 = utf8.len(var_166_14)
				local var_166_17 = var_166_15 <= 0 and var_166_11 or var_166_11 * (var_166_16 / var_166_15)

				if var_166_17 > 0 and var_166_11 < var_166_17 then
					arg_163_1.talkMaxDuration = var_166_17

					if var_166_17 + var_166_10 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_17 + var_166_10
					end
				end

				arg_163_1.text_.text = var_166_14
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501040", "story_v_out_121501.awb") ~= 0 then
					local var_166_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501040", "story_v_out_121501.awb") / 1000

					if var_166_18 + var_166_10 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_18 + var_166_10
					end

					if var_166_13.prefab_name ~= "" and arg_163_1.actors_[var_166_13.prefab_name] ~= nil then
						local var_166_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_13.prefab_name].transform, "story_v_out_121501", "121501040", "story_v_out_121501.awb")

						arg_163_1:RecordAudio("121501040", var_166_19)
						arg_163_1:RecordAudio("121501040", var_166_19)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_121501", "121501040", "story_v_out_121501.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_121501", "121501040", "story_v_out_121501.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_20 = math.max(var_166_11, arg_163_1.talkMaxDuration)

			if var_166_10 <= arg_163_1.time_ and arg_163_1.time_ < var_166_10 + var_166_20 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_10) / var_166_20

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_10 + var_166_20 and arg_163_1.time_ < var_166_10 + var_166_20 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play121501041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 121501041
		arg_167_1.duration_ = 6.1

		local var_167_0 = {
			ja = 6.1,
			ko = 6.099999999999,
			zh = 6.099999999999
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
				arg_167_0:Play121501042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = "I05a"

			if arg_167_1.bgs_[var_170_0] == nil then
				local var_170_1 = Object.Instantiate(arg_167_1.paintGo_)

				var_170_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_170_0)
				var_170_1.name = var_170_0
				var_170_1.transform.parent = arg_167_1.stage_.transform
				var_170_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_167_1.bgs_[var_170_0] = var_170_1
			end

			local var_170_2 = 2

			if var_170_2 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				local var_170_3 = manager.ui.mainCamera.transform.localPosition
				local var_170_4 = Vector3.New(0, 0, 10) + Vector3.New(var_170_3.x, var_170_3.y, 0)
				local var_170_5 = arg_167_1.bgs_.I05a

				var_170_5.transform.localPosition = var_170_4
				var_170_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_170_6 = var_170_5:GetComponent("SpriteRenderer")

				if var_170_6 and var_170_6.sprite then
					local var_170_7 = (var_170_5.transform.localPosition - var_170_3).z
					local var_170_8 = manager.ui.mainCameraCom_
					local var_170_9 = 2 * var_170_7 * Mathf.Tan(var_170_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_170_10 = var_170_9 * var_170_8.aspect
					local var_170_11 = var_170_6.sprite.bounds.size.x
					local var_170_12 = var_170_6.sprite.bounds.size.y
					local var_170_13 = var_170_10 / var_170_11
					local var_170_14 = var_170_9 / var_170_12
					local var_170_15 = var_170_14 < var_170_13 and var_170_13 or var_170_14

					var_170_5.transform.localScale = Vector3.New(var_170_15, var_170_15, 0)
				end

				for iter_170_0, iter_170_1 in pairs(arg_167_1.bgs_) do
					if iter_170_0 ~= "I05a" then
						iter_170_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_170_16 = 0

			if var_170_16 < arg_167_1.time_ and arg_167_1.time_ <= var_170_16 + arg_170_0 then
				arg_167_1.mask_.enabled = true
				arg_167_1.mask_.raycastTarget = true

				arg_167_1:SetGaussion(false)
			end

			local var_170_17 = 2

			if var_170_16 <= arg_167_1.time_ and arg_167_1.time_ < var_170_16 + var_170_17 then
				local var_170_18 = (arg_167_1.time_ - var_170_16) / var_170_17
				local var_170_19 = Color.New(0, 0, 0)

				var_170_19.a = Mathf.Lerp(0, 1, var_170_18)
				arg_167_1.mask_.color = var_170_19
			end

			if arg_167_1.time_ >= var_170_16 + var_170_17 and arg_167_1.time_ < var_170_16 + var_170_17 + arg_170_0 then
				local var_170_20 = Color.New(0, 0, 0)

				var_170_20.a = 1
				arg_167_1.mask_.color = var_170_20
			end

			local var_170_21 = 2

			if var_170_21 < arg_167_1.time_ and arg_167_1.time_ <= var_170_21 + arg_170_0 then
				arg_167_1.mask_.enabled = true
				arg_167_1.mask_.raycastTarget = true

				arg_167_1:SetGaussion(false)
			end

			local var_170_22 = 2

			if var_170_21 <= arg_167_1.time_ and arg_167_1.time_ < var_170_21 + var_170_22 then
				local var_170_23 = (arg_167_1.time_ - var_170_21) / var_170_22
				local var_170_24 = Color.New(0, 0, 0)

				var_170_24.a = Mathf.Lerp(1, 0, var_170_23)
				arg_167_1.mask_.color = var_170_24
			end

			if arg_167_1.time_ >= var_170_21 + var_170_22 and arg_167_1.time_ < var_170_21 + var_170_22 + arg_170_0 then
				local var_170_25 = Color.New(0, 0, 0)
				local var_170_26 = 0

				arg_167_1.mask_.enabled = false
				var_170_25.a = var_170_26
				arg_167_1.mask_.color = var_170_25
			end

			local var_170_27 = arg_167_1.actors_["1019ui_story"].transform
			local var_170_28 = 1.96599999815226

			if var_170_28 < arg_167_1.time_ and arg_167_1.time_ <= var_170_28 + arg_170_0 then
				arg_167_1.var_.moveOldPos1019ui_story = var_170_27.localPosition
			end

			local var_170_29 = 0.001

			if var_170_28 <= arg_167_1.time_ and arg_167_1.time_ < var_170_28 + var_170_29 then
				local var_170_30 = (arg_167_1.time_ - var_170_28) / var_170_29
				local var_170_31 = Vector3.New(0, 100, 0)

				var_170_27.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1019ui_story, var_170_31, var_170_30)

				local var_170_32 = manager.ui.mainCamera.transform.position - var_170_27.position

				var_170_27.forward = Vector3.New(var_170_32.x, var_170_32.y, var_170_32.z)

				local var_170_33 = var_170_27.localEulerAngles

				var_170_33.z = 0
				var_170_33.x = 0
				var_170_27.localEulerAngles = var_170_33
			end

			if arg_167_1.time_ >= var_170_28 + var_170_29 and arg_167_1.time_ < var_170_28 + var_170_29 + arg_170_0 then
				var_170_27.localPosition = Vector3.New(0, 100, 0)

				local var_170_34 = manager.ui.mainCamera.transform.position - var_170_27.position

				var_170_27.forward = Vector3.New(var_170_34.x, var_170_34.y, var_170_34.z)

				local var_170_35 = var_170_27.localEulerAngles

				var_170_35.z = 0
				var_170_35.x = 0
				var_170_27.localEulerAngles = var_170_35
			end

			local var_170_36 = arg_167_1.actors_["1019ui_story"]
			local var_170_37 = 1.96599999815226

			if var_170_37 < arg_167_1.time_ and arg_167_1.time_ <= var_170_37 + arg_170_0 and not isNil(var_170_36) and arg_167_1.var_.characterEffect1019ui_story == nil then
				arg_167_1.var_.characterEffect1019ui_story = var_170_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_38 = 0.034000001847744

			if var_170_37 <= arg_167_1.time_ and arg_167_1.time_ < var_170_37 + var_170_38 and not isNil(var_170_36) then
				local var_170_39 = (arg_167_1.time_ - var_170_37) / var_170_38

				if arg_167_1.var_.characterEffect1019ui_story and not isNil(var_170_36) then
					local var_170_40 = Mathf.Lerp(0, 0.5, var_170_39)

					arg_167_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1019ui_story.fillRatio = var_170_40
				end
			end

			if arg_167_1.time_ >= var_170_37 + var_170_38 and arg_167_1.time_ < var_170_37 + var_170_38 + arg_170_0 and not isNil(var_170_36) and arg_167_1.var_.characterEffect1019ui_story then
				local var_170_41 = 0.5

				arg_167_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1019ui_story.fillRatio = var_170_41
			end

			local var_170_42 = arg_167_1.actors_["1029ui_story"].transform
			local var_170_43 = 1.96599999815226

			if var_170_43 < arg_167_1.time_ and arg_167_1.time_ <= var_170_43 + arg_170_0 then
				arg_167_1.var_.moveOldPos1029ui_story = var_170_42.localPosition
			end

			local var_170_44 = 0.001

			if var_170_43 <= arg_167_1.time_ and arg_167_1.time_ < var_170_43 + var_170_44 then
				local var_170_45 = (arg_167_1.time_ - var_170_43) / var_170_44
				local var_170_46 = Vector3.New(0, 100, 0)

				var_170_42.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1029ui_story, var_170_46, var_170_45)

				local var_170_47 = manager.ui.mainCamera.transform.position - var_170_42.position

				var_170_42.forward = Vector3.New(var_170_47.x, var_170_47.y, var_170_47.z)

				local var_170_48 = var_170_42.localEulerAngles

				var_170_48.z = 0
				var_170_48.x = 0
				var_170_42.localEulerAngles = var_170_48
			end

			if arg_167_1.time_ >= var_170_43 + var_170_44 and arg_167_1.time_ < var_170_43 + var_170_44 + arg_170_0 then
				var_170_42.localPosition = Vector3.New(0, 100, 0)

				local var_170_49 = manager.ui.mainCamera.transform.position - var_170_42.position

				var_170_42.forward = Vector3.New(var_170_49.x, var_170_49.y, var_170_49.z)

				local var_170_50 = var_170_42.localEulerAngles

				var_170_50.z = 0
				var_170_50.x = 0
				var_170_42.localEulerAngles = var_170_50
			end

			local var_170_51 = arg_167_1.actors_["1029ui_story"]
			local var_170_52 = 1.96599999815226

			if var_170_52 < arg_167_1.time_ and arg_167_1.time_ <= var_170_52 + arg_170_0 and not isNil(var_170_51) and arg_167_1.var_.characterEffect1029ui_story == nil then
				arg_167_1.var_.characterEffect1029ui_story = var_170_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_53 = 0.034000001847744

			if var_170_52 <= arg_167_1.time_ and arg_167_1.time_ < var_170_52 + var_170_53 and not isNil(var_170_51) then
				local var_170_54 = (arg_167_1.time_ - var_170_52) / var_170_53

				if arg_167_1.var_.characterEffect1029ui_story and not isNil(var_170_51) then
					arg_167_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_52 + var_170_53 and arg_167_1.time_ < var_170_52 + var_170_53 + arg_170_0 and not isNil(var_170_51) and arg_167_1.var_.characterEffect1029ui_story then
				arg_167_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_170_55 = 3.8

			if var_170_55 < arg_167_1.time_ and arg_167_1.time_ <= var_170_55 + arg_170_0 then
				arg_167_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_170_56 = 3.8

			if var_170_56 < arg_167_1.time_ and arg_167_1.time_ <= var_170_56 + arg_170_0 then
				arg_167_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_170_57 = arg_167_1.actors_["1029ui_story"].transform
			local var_170_58 = 3.8

			if var_170_58 < arg_167_1.time_ and arg_167_1.time_ <= var_170_58 + arg_170_0 then
				arg_167_1.var_.moveOldPos1029ui_story = var_170_57.localPosition
			end

			local var_170_59 = 0.001

			if var_170_58 <= arg_167_1.time_ and arg_167_1.time_ < var_170_58 + var_170_59 then
				local var_170_60 = (arg_167_1.time_ - var_170_58) / var_170_59
				local var_170_61 = Vector3.New(0, -1.09, -6.2)

				var_170_57.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1029ui_story, var_170_61, var_170_60)

				local var_170_62 = manager.ui.mainCamera.transform.position - var_170_57.position

				var_170_57.forward = Vector3.New(var_170_62.x, var_170_62.y, var_170_62.z)

				local var_170_63 = var_170_57.localEulerAngles

				var_170_63.z = 0
				var_170_63.x = 0
				var_170_57.localEulerAngles = var_170_63
			end

			if arg_167_1.time_ >= var_170_58 + var_170_59 and arg_167_1.time_ < var_170_58 + var_170_59 + arg_170_0 then
				var_170_57.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_170_64 = manager.ui.mainCamera.transform.position - var_170_57.position

				var_170_57.forward = Vector3.New(var_170_64.x, var_170_64.y, var_170_64.z)

				local var_170_65 = var_170_57.localEulerAngles

				var_170_65.z = 0
				var_170_65.x = 0
				var_170_57.localEulerAngles = var_170_65
			end

			local var_170_66 = arg_167_1.actors_["1029ui_story"]
			local var_170_67 = 3.8

			if var_170_67 < arg_167_1.time_ and arg_167_1.time_ <= var_170_67 + arg_170_0 and not isNil(var_170_66) and arg_167_1.var_.characterEffect1029ui_story == nil then
				arg_167_1.var_.characterEffect1029ui_story = var_170_66:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_68 = 0.200000002980232

			if var_170_67 <= arg_167_1.time_ and arg_167_1.time_ < var_170_67 + var_170_68 and not isNil(var_170_66) then
				local var_170_69 = (arg_167_1.time_ - var_170_67) / var_170_68

				if arg_167_1.var_.characterEffect1029ui_story and not isNil(var_170_66) then
					arg_167_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_67 + var_170_68 and arg_167_1.time_ < var_170_67 + var_170_68 + arg_170_0 and not isNil(var_170_66) and arg_167_1.var_.characterEffect1029ui_story then
				arg_167_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if arg_167_1.frameCnt_ <= 1 then
				arg_167_1.dialog_:SetActive(false)
			end

			local var_170_70 = 4
			local var_170_71 = 0.175

			if var_170_70 < arg_167_1.time_ and arg_167_1.time_ <= var_170_70 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0

				arg_167_1.dialog_:SetActive(true)

				arg_167_1.dialogCg_.alpha = 0

				local var_170_72 = LeanTween.value(arg_167_1.dialog_, 0, 1, 0.3)

				var_170_72:setOnUpdate(LuaHelper.FloatAction(function(arg_171_0)
					arg_167_1.dialogCg_.alpha = arg_171_0
				end))
				var_170_72:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_167_1.dialog_)
					var_170_72:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_167_1.duration_ = arg_167_1.duration_ + 0.3

				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_73 = arg_167_1:FormatText(StoryNameCfg[319].name)

				arg_167_1.leftNameTxt_.text = var_170_73

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_74 = arg_167_1:GetWordFromCfg(121501041)
				local var_170_75 = arg_167_1:FormatText(var_170_74.content)

				arg_167_1.text_.text = var_170_75

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_76 = 7
				local var_170_77 = utf8.len(var_170_75)
				local var_170_78 = var_170_76 <= 0 and var_170_71 or var_170_71 * (var_170_77 / var_170_76)

				if var_170_78 > 0 and var_170_71 < var_170_78 then
					arg_167_1.talkMaxDuration = var_170_78
					var_170_70 = var_170_70 + 0.3

					if var_170_78 + var_170_70 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_78 + var_170_70
					end
				end

				arg_167_1.text_.text = var_170_75
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501041", "story_v_out_121501.awb") ~= 0 then
					local var_170_79 = manager.audio:GetVoiceLength("story_v_out_121501", "121501041", "story_v_out_121501.awb") / 1000

					if var_170_79 + var_170_70 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_79 + var_170_70
					end

					if var_170_74.prefab_name ~= "" and arg_167_1.actors_[var_170_74.prefab_name] ~= nil then
						local var_170_80 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_74.prefab_name].transform, "story_v_out_121501", "121501041", "story_v_out_121501.awb")

						arg_167_1:RecordAudio("121501041", var_170_80)
						arg_167_1:RecordAudio("121501041", var_170_80)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_121501", "121501041", "story_v_out_121501.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_121501", "121501041", "story_v_out_121501.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_81 = var_170_70 + 0.3
			local var_170_82 = math.max(var_170_71, arg_167_1.talkMaxDuration)

			if var_170_81 <= arg_167_1.time_ and arg_167_1.time_ < var_170_81 + var_170_82 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_81) / var_170_82

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_81 + var_170_82 and arg_167_1.time_ < var_170_81 + var_170_82 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play121501042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 121501042
		arg_173_1.duration_ = 6.63

		local var_173_0 = {
			ja = 6.633,
			ko = 4.733,
			zh = 4.733
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
				arg_173_0:Play121501043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.475

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[319].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_3 = arg_173_1:GetWordFromCfg(121501042)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 19
				local var_176_6 = utf8.len(var_176_4)
				local var_176_7 = var_176_5 <= 0 and var_176_1 or var_176_1 * (var_176_6 / var_176_5)

				if var_176_7 > 0 and var_176_1 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_4
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501042", "story_v_out_121501.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_121501", "121501042", "story_v_out_121501.awb") / 1000

					if var_176_8 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_0
					end

					if var_176_3.prefab_name ~= "" and arg_173_1.actors_[var_176_3.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_3.prefab_name].transform, "story_v_out_121501", "121501042", "story_v_out_121501.awb")

						arg_173_1:RecordAudio("121501042", var_176_9)
						arg_173_1:RecordAudio("121501042", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_121501", "121501042", "story_v_out_121501.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_121501", "121501042", "story_v_out_121501.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_10 and arg_173_1.time_ < var_176_0 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play121501043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 121501043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play121501044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1029ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1029ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(0, 100, 0)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1029ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, 100, 0)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = arg_177_1.actors_["1029ui_story"]
			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1029ui_story == nil then
				arg_177_1.var_.characterEffect1029ui_story = var_180_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_11 = 0.200000002980232

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_11 and not isNil(var_180_9) then
				local var_180_12 = (arg_177_1.time_ - var_180_10) / var_180_11

				if arg_177_1.var_.characterEffect1029ui_story and not isNil(var_180_9) then
					local var_180_13 = Mathf.Lerp(0, 0.5, var_180_12)

					arg_177_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1029ui_story.fillRatio = var_180_13
				end
			end

			if arg_177_1.time_ >= var_180_10 + var_180_11 and arg_177_1.time_ < var_180_10 + var_180_11 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1029ui_story then
				local var_180_14 = 0.5

				arg_177_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1029ui_story.fillRatio = var_180_14
			end

			local var_180_15 = 0
			local var_180_16 = 0.75

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_17 = arg_177_1:GetWordFromCfg(121501043)
				local var_180_18 = arg_177_1:FormatText(var_180_17.content)

				arg_177_1.text_.text = var_180_18

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_19 = 30
				local var_180_20 = utf8.len(var_180_18)
				local var_180_21 = var_180_19 <= 0 and var_180_16 or var_180_16 * (var_180_20 / var_180_19)

				if var_180_21 > 0 and var_180_16 < var_180_21 then
					arg_177_1.talkMaxDuration = var_180_21

					if var_180_21 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_21 + var_180_15
					end
				end

				arg_177_1.text_.text = var_180_18
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_22 = math.max(var_180_16, arg_177_1.talkMaxDuration)

			if var_180_15 <= arg_177_1.time_ and arg_177_1.time_ < var_180_15 + var_180_22 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_15) / var_180_22

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_15 + var_180_22 and arg_177_1.time_ < var_180_15 + var_180_22 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play121501044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 121501044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play121501045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 1.425

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_2 = arg_181_1:GetWordFromCfg(121501044)
				local var_184_3 = arg_181_1:FormatText(var_184_2.content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 57
				local var_184_5 = utf8.len(var_184_3)
				local var_184_6 = var_184_4 <= 0 and var_184_1 or var_184_1 * (var_184_5 / var_184_4)

				if var_184_6 > 0 and var_184_1 < var_184_6 then
					arg_181_1.talkMaxDuration = var_184_6

					if var_184_6 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_7 and arg_181_1.time_ < var_184_0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play121501045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 121501045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play121501046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 1.3

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_2 = arg_185_1:GetWordFromCfg(121501045)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 52
				local var_188_5 = utf8.len(var_188_3)
				local var_188_6 = var_188_4 <= 0 and var_188_1 or var_188_1 * (var_188_5 / var_188_4)

				if var_188_6 > 0 and var_188_1 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_7 and arg_185_1.time_ < var_188_0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play121501046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 121501046
		arg_189_1.duration_ = 2.9

		local var_189_0 = {
			ja = 2.9,
			ko = 2.833,
			zh = 2.833
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
				arg_189_0:Play121501047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1029ui_story"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1029ui_story = var_192_0.localPosition
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(-0.7, -1.09, -6.2)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1029ui_story, var_192_4, var_192_3)

				local var_192_5 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_5.x, var_192_5.y, var_192_5.z)

				local var_192_6 = var_192_0.localEulerAngles

				var_192_6.z = 0
				var_192_6.x = 0
				var_192_0.localEulerAngles = var_192_6
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(-0.7, -1.09, -6.2)

				local var_192_7 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_7.x, var_192_7.y, var_192_7.z)

				local var_192_8 = var_192_0.localEulerAngles

				var_192_8.z = 0
				var_192_8.x = 0
				var_192_0.localEulerAngles = var_192_8
			end

			local var_192_9 = arg_189_1.actors_["1029ui_story"]
			local var_192_10 = 0

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1029ui_story == nil then
				arg_189_1.var_.characterEffect1029ui_story = var_192_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_11 = 0.200000002980232

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_11 and not isNil(var_192_9) then
				local var_192_12 = (arg_189_1.time_ - var_192_10) / var_192_11

				if arg_189_1.var_.characterEffect1029ui_story and not isNil(var_192_9) then
					arg_189_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_10 + var_192_11 and arg_189_1.time_ < var_192_10 + var_192_11 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1029ui_story then
				arg_189_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_192_13 = 0

			if var_192_13 < arg_189_1.time_ and arg_189_1.time_ <= var_192_13 + arg_192_0 then
				arg_189_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_192_14 = 0

			if var_192_14 < arg_189_1.time_ and arg_189_1.time_ <= var_192_14 + arg_192_0 then
				arg_189_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_192_15 = "10014ui_story"

			if arg_189_1.actors_[var_192_15] == nil then
				local var_192_16 = Asset.Load("Char/" .. "10014ui_story")

				if not isNil(var_192_16) then
					local var_192_17 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_189_1.stage_.transform)

					var_192_17.name = var_192_15
					var_192_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_189_1.actors_[var_192_15] = var_192_17

					local var_192_18 = var_192_17:GetComponentInChildren(typeof(CharacterEffect))

					var_192_18.enabled = true

					local var_192_19 = GameObjectTools.GetOrAddComponent(var_192_17, typeof(DynamicBoneHelper))

					if var_192_19 then
						var_192_19:EnableDynamicBone(false)
					end

					arg_189_1:ShowWeapon(var_192_18.transform, false)

					arg_189_1.var_[var_192_15 .. "Animator"] = var_192_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_189_1.var_[var_192_15 .. "Animator"].applyRootMotion = true
					arg_189_1.var_[var_192_15 .. "LipSync"] = var_192_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_192_20 = arg_189_1.actors_["10014ui_story"].transform
			local var_192_21 = 0

			if var_192_21 < arg_189_1.time_ and arg_189_1.time_ <= var_192_21 + arg_192_0 then
				arg_189_1.var_.moveOldPos10014ui_story = var_192_20.localPosition
			end

			local var_192_22 = 0.001

			if var_192_21 <= arg_189_1.time_ and arg_189_1.time_ < var_192_21 + var_192_22 then
				local var_192_23 = (arg_189_1.time_ - var_192_21) / var_192_22
				local var_192_24 = Vector3.New(0.7, -1.06, -6.2)

				var_192_20.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10014ui_story, var_192_24, var_192_23)

				local var_192_25 = manager.ui.mainCamera.transform.position - var_192_20.position

				var_192_20.forward = Vector3.New(var_192_25.x, var_192_25.y, var_192_25.z)

				local var_192_26 = var_192_20.localEulerAngles

				var_192_26.z = 0
				var_192_26.x = 0
				var_192_20.localEulerAngles = var_192_26
			end

			if arg_189_1.time_ >= var_192_21 + var_192_22 and arg_189_1.time_ < var_192_21 + var_192_22 + arg_192_0 then
				var_192_20.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_192_27 = manager.ui.mainCamera.transform.position - var_192_20.position

				var_192_20.forward = Vector3.New(var_192_27.x, var_192_27.y, var_192_27.z)

				local var_192_28 = var_192_20.localEulerAngles

				var_192_28.z = 0
				var_192_28.x = 0
				var_192_20.localEulerAngles = var_192_28
			end

			local var_192_29 = arg_189_1.actors_["10014ui_story"]
			local var_192_30 = 0

			if var_192_30 < arg_189_1.time_ and arg_189_1.time_ <= var_192_30 + arg_192_0 and not isNil(var_192_29) and arg_189_1.var_.characterEffect10014ui_story == nil then
				arg_189_1.var_.characterEffect10014ui_story = var_192_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_31 = 0.200000002980232

			if var_192_30 <= arg_189_1.time_ and arg_189_1.time_ < var_192_30 + var_192_31 and not isNil(var_192_29) then
				local var_192_32 = (arg_189_1.time_ - var_192_30) / var_192_31

				if arg_189_1.var_.characterEffect10014ui_story and not isNil(var_192_29) then
					local var_192_33 = Mathf.Lerp(0, 0.5, var_192_32)

					arg_189_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_189_1.var_.characterEffect10014ui_story.fillRatio = var_192_33
				end
			end

			if arg_189_1.time_ >= var_192_30 + var_192_31 and arg_189_1.time_ < var_192_30 + var_192_31 + arg_192_0 and not isNil(var_192_29) and arg_189_1.var_.characterEffect10014ui_story then
				local var_192_34 = 0.5

				arg_189_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_189_1.var_.characterEffect10014ui_story.fillRatio = var_192_34
			end

			local var_192_35 = 0

			if var_192_35 < arg_189_1.time_ and arg_189_1.time_ <= var_192_35 + arg_192_0 then
				arg_189_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_192_36 = 0
			local var_192_37 = 0.175

			if var_192_36 < arg_189_1.time_ and arg_189_1.time_ <= var_192_36 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_38 = arg_189_1:FormatText(StoryNameCfg[319].name)

				arg_189_1.leftNameTxt_.text = var_192_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_39 = arg_189_1:GetWordFromCfg(121501046)
				local var_192_40 = arg_189_1:FormatText(var_192_39.content)

				arg_189_1.text_.text = var_192_40

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_41 = 7
				local var_192_42 = utf8.len(var_192_40)
				local var_192_43 = var_192_41 <= 0 and var_192_37 or var_192_37 * (var_192_42 / var_192_41)

				if var_192_43 > 0 and var_192_37 < var_192_43 then
					arg_189_1.talkMaxDuration = var_192_43

					if var_192_43 + var_192_36 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_43 + var_192_36
					end
				end

				arg_189_1.text_.text = var_192_40
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501046", "story_v_out_121501.awb") ~= 0 then
					local var_192_44 = manager.audio:GetVoiceLength("story_v_out_121501", "121501046", "story_v_out_121501.awb") / 1000

					if var_192_44 + var_192_36 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_44 + var_192_36
					end

					if var_192_39.prefab_name ~= "" and arg_189_1.actors_[var_192_39.prefab_name] ~= nil then
						local var_192_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_39.prefab_name].transform, "story_v_out_121501", "121501046", "story_v_out_121501.awb")

						arg_189_1:RecordAudio("121501046", var_192_45)
						arg_189_1:RecordAudio("121501046", var_192_45)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_121501", "121501046", "story_v_out_121501.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_121501", "121501046", "story_v_out_121501.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_46 = math.max(var_192_37, arg_189_1.talkMaxDuration)

			if var_192_36 <= arg_189_1.time_ and arg_189_1.time_ < var_192_36 + var_192_46 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_36) / var_192_46

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_36 + var_192_46 and arg_189_1.time_ < var_192_36 + var_192_46 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play121501047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 121501047
		arg_193_1.duration_ = 6.03

		local var_193_0 = {
			ja = 6.033,
			ko = 5.9,
			zh = 5.9
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
				arg_193_0:Play121501048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10014ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect10014ui_story == nil then
				arg_193_1.var_.characterEffect10014ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect10014ui_story and not isNil(var_196_0) then
					arg_193_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect10014ui_story then
				arg_193_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_196_4 = 0

			if var_196_4 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action5_1")
			end

			local var_196_5 = 0

			if var_196_5 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_196_6 = arg_193_1.actors_["1029ui_story"]
			local var_196_7 = 0

			if var_196_7 < arg_193_1.time_ and arg_193_1.time_ <= var_196_7 + arg_196_0 and not isNil(var_196_6) and arg_193_1.var_.characterEffect1029ui_story == nil then
				arg_193_1.var_.characterEffect1029ui_story = var_196_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_8 = 0.200000002980232

			if var_196_7 <= arg_193_1.time_ and arg_193_1.time_ < var_196_7 + var_196_8 and not isNil(var_196_6) then
				local var_196_9 = (arg_193_1.time_ - var_196_7) / var_196_8

				if arg_193_1.var_.characterEffect1029ui_story and not isNil(var_196_6) then
					local var_196_10 = Mathf.Lerp(0, 0.5, var_196_9)

					arg_193_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1029ui_story.fillRatio = var_196_10
				end
			end

			if arg_193_1.time_ >= var_196_7 + var_196_8 and arg_193_1.time_ < var_196_7 + var_196_8 + arg_196_0 and not isNil(var_196_6) and arg_193_1.var_.characterEffect1029ui_story then
				local var_196_11 = 0.5

				arg_193_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1029ui_story.fillRatio = var_196_11
			end

			local var_196_12 = 0
			local var_196_13 = 0.725

			if var_196_12 < arg_193_1.time_ and arg_193_1.time_ <= var_196_12 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_14 = arg_193_1:FormatText(StoryNameCfg[264].name)

				arg_193_1.leftNameTxt_.text = var_196_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_15 = arg_193_1:GetWordFromCfg(121501047)
				local var_196_16 = arg_193_1:FormatText(var_196_15.content)

				arg_193_1.text_.text = var_196_16

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_17 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501047", "story_v_out_121501.awb") ~= 0 then
					local var_196_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501047", "story_v_out_121501.awb") / 1000

					if var_196_20 + var_196_12 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_20 + var_196_12
					end

					if var_196_15.prefab_name ~= "" and arg_193_1.actors_[var_196_15.prefab_name] ~= nil then
						local var_196_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_15.prefab_name].transform, "story_v_out_121501", "121501047", "story_v_out_121501.awb")

						arg_193_1:RecordAudio("121501047", var_196_21)
						arg_193_1:RecordAudio("121501047", var_196_21)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_121501", "121501047", "story_v_out_121501.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_121501", "121501047", "story_v_out_121501.awb")
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
	Play121501048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 121501048
		arg_197_1.duration_ = 3.87

		local var_197_0 = {
			ja = 3.866,
			ko = 2.633,
			zh = 2.633
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
				arg_197_0:Play121501049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10014ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect10014ui_story == nil then
				arg_197_1.var_.characterEffect10014ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect10014ui_story and not isNil(var_200_0) then
					local var_200_4 = Mathf.Lerp(0, 0.5, var_200_3)

					arg_197_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_197_1.var_.characterEffect10014ui_story.fillRatio = var_200_4
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect10014ui_story then
				local var_200_5 = 0.5

				arg_197_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_197_1.var_.characterEffect10014ui_story.fillRatio = var_200_5
			end

			local var_200_6 = arg_197_1.actors_["1029ui_story"]
			local var_200_7 = 0

			if var_200_7 < arg_197_1.time_ and arg_197_1.time_ <= var_200_7 + arg_200_0 and not isNil(var_200_6) and arg_197_1.var_.characterEffect1029ui_story == nil then
				arg_197_1.var_.characterEffect1029ui_story = var_200_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_8 = 0.200000002980232

			if var_200_7 <= arg_197_1.time_ and arg_197_1.time_ < var_200_7 + var_200_8 and not isNil(var_200_6) then
				local var_200_9 = (arg_197_1.time_ - var_200_7) / var_200_8

				if arg_197_1.var_.characterEffect1029ui_story and not isNil(var_200_6) then
					arg_197_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_7 + var_200_8 and arg_197_1.time_ < var_200_7 + var_200_8 + arg_200_0 and not isNil(var_200_6) and arg_197_1.var_.characterEffect1029ui_story then
				arg_197_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_200_10 = 0
			local var_200_11 = 0.35

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_12 = arg_197_1:FormatText(StoryNameCfg[319].name)

				arg_197_1.leftNameTxt_.text = var_200_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_13 = arg_197_1:GetWordFromCfg(121501048)
				local var_200_14 = arg_197_1:FormatText(var_200_13.content)

				arg_197_1.text_.text = var_200_14

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_15 = 14
				local var_200_16 = utf8.len(var_200_14)
				local var_200_17 = var_200_15 <= 0 and var_200_11 or var_200_11 * (var_200_16 / var_200_15)

				if var_200_17 > 0 and var_200_11 < var_200_17 then
					arg_197_1.talkMaxDuration = var_200_17

					if var_200_17 + var_200_10 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_17 + var_200_10
					end
				end

				arg_197_1.text_.text = var_200_14
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501048", "story_v_out_121501.awb") ~= 0 then
					local var_200_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501048", "story_v_out_121501.awb") / 1000

					if var_200_18 + var_200_10 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_18 + var_200_10
					end

					if var_200_13.prefab_name ~= "" and arg_197_1.actors_[var_200_13.prefab_name] ~= nil then
						local var_200_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_13.prefab_name].transform, "story_v_out_121501", "121501048", "story_v_out_121501.awb")

						arg_197_1:RecordAudio("121501048", var_200_19)
						arg_197_1:RecordAudio("121501048", var_200_19)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_121501", "121501048", "story_v_out_121501.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_121501", "121501048", "story_v_out_121501.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_20 = math.max(var_200_11, arg_197_1.talkMaxDuration)

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_20 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_10) / var_200_20

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_10 + var_200_20 and arg_197_1.time_ < var_200_10 + var_200_20 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play121501049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 121501049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play121501050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_204_1 = 0
			local var_204_2 = 1.125

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:GetWordFromCfg(121501049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 45
				local var_204_6 = utf8.len(var_204_4)
				local var_204_7 = var_204_5 <= 0 and var_204_2 or var_204_2 * (var_204_6 / var_204_5)

				if var_204_7 > 0 and var_204_2 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_1 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_1
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_8 = math.max(var_204_2, arg_201_1.talkMaxDuration)

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_8 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_1) / var_204_8

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_1 + var_204_8 and arg_201_1.time_ < var_204_1 + var_204_8 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play121501050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 121501050
		arg_205_1.duration_ = 10.13

		local var_205_0 = {
			ja = 10.133,
			ko = 6.9,
			zh = 6.9
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
				arg_205_0:Play121501051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014actionlink/10014action454")
			end

			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_208_2 = arg_205_1.actors_["10014ui_story"]
			local var_208_3 = 0

			if var_208_3 < arg_205_1.time_ and arg_205_1.time_ <= var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.characterEffect10014ui_story == nil then
				arg_205_1.var_.characterEffect10014ui_story = var_208_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_4 = 0.200000002980232

			if var_208_3 <= arg_205_1.time_ and arg_205_1.time_ < var_208_3 + var_208_4 and not isNil(var_208_2) then
				local var_208_5 = (arg_205_1.time_ - var_208_3) / var_208_4

				if arg_205_1.var_.characterEffect10014ui_story and not isNil(var_208_2) then
					arg_205_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_3 + var_208_4 and arg_205_1.time_ < var_208_3 + var_208_4 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.characterEffect10014ui_story then
				arg_205_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_208_6 = 0
			local var_208_7 = 0.775

			if var_208_6 < arg_205_1.time_ and arg_205_1.time_ <= var_208_6 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_8 = arg_205_1:FormatText(StoryNameCfg[264].name)

				arg_205_1.leftNameTxt_.text = var_208_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_9 = arg_205_1:GetWordFromCfg(121501050)
				local var_208_10 = arg_205_1:FormatText(var_208_9.content)

				arg_205_1.text_.text = var_208_10

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_11 = 31
				local var_208_12 = utf8.len(var_208_10)
				local var_208_13 = var_208_11 <= 0 and var_208_7 or var_208_7 * (var_208_12 / var_208_11)

				if var_208_13 > 0 and var_208_7 < var_208_13 then
					arg_205_1.talkMaxDuration = var_208_13

					if var_208_13 + var_208_6 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_13 + var_208_6
					end
				end

				arg_205_1.text_.text = var_208_10
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501050", "story_v_out_121501.awb") ~= 0 then
					local var_208_14 = manager.audio:GetVoiceLength("story_v_out_121501", "121501050", "story_v_out_121501.awb") / 1000

					if var_208_14 + var_208_6 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_14 + var_208_6
					end

					if var_208_9.prefab_name ~= "" and arg_205_1.actors_[var_208_9.prefab_name] ~= nil then
						local var_208_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_9.prefab_name].transform, "story_v_out_121501", "121501050", "story_v_out_121501.awb")

						arg_205_1:RecordAudio("121501050", var_208_15)
						arg_205_1:RecordAudio("121501050", var_208_15)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_121501", "121501050", "story_v_out_121501.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_121501", "121501050", "story_v_out_121501.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_16 = math.max(var_208_7, arg_205_1.talkMaxDuration)

			if var_208_6 <= arg_205_1.time_ and arg_205_1.time_ < var_208_6 + var_208_16 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_6) / var_208_16

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_6 + var_208_16 and arg_205_1.time_ < var_208_6 + var_208_16 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play121501051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 121501051
		arg_209_1.duration_ = 5.87

		local var_209_0 = {
			ja = 4.866,
			ko = 5.866,
			zh = 5.866
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play121501052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1029ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1029ui_story == nil then
				arg_209_1.var_.characterEffect1029ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect1029ui_story and not isNil(var_212_0) then
					arg_209_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1029ui_story then
				arg_209_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_212_4 = 0

			if var_212_4 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_212_5 = 0

			if var_212_5 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_212_6 = arg_209_1.actors_["10014ui_story"]
			local var_212_7 = 0

			if var_212_7 < arg_209_1.time_ and arg_209_1.time_ <= var_212_7 + arg_212_0 and not isNil(var_212_6) and arg_209_1.var_.characterEffect10014ui_story == nil then
				arg_209_1.var_.characterEffect10014ui_story = var_212_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_8 = 0.200000002980232

			if var_212_7 <= arg_209_1.time_ and arg_209_1.time_ < var_212_7 + var_212_8 and not isNil(var_212_6) then
				local var_212_9 = (arg_209_1.time_ - var_212_7) / var_212_8

				if arg_209_1.var_.characterEffect10014ui_story and not isNil(var_212_6) then
					local var_212_10 = Mathf.Lerp(0, 0.5, var_212_9)

					arg_209_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_209_1.var_.characterEffect10014ui_story.fillRatio = var_212_10
				end
			end

			if arg_209_1.time_ >= var_212_7 + var_212_8 and arg_209_1.time_ < var_212_7 + var_212_8 + arg_212_0 and not isNil(var_212_6) and arg_209_1.var_.characterEffect10014ui_story then
				local var_212_11 = 0.5

				arg_209_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_209_1.var_.characterEffect10014ui_story.fillRatio = var_212_11
			end

			local var_212_12 = 0
			local var_212_13 = 0.625

			if var_212_12 < arg_209_1.time_ and arg_209_1.time_ <= var_212_12 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_14 = arg_209_1:FormatText(StoryNameCfg[319].name)

				arg_209_1.leftNameTxt_.text = var_212_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_15 = arg_209_1:GetWordFromCfg(121501051)
				local var_212_16 = arg_209_1:FormatText(var_212_15.content)

				arg_209_1.text_.text = var_212_16

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_17 = 25
				local var_212_18 = utf8.len(var_212_16)
				local var_212_19 = var_212_17 <= 0 and var_212_13 or var_212_13 * (var_212_18 / var_212_17)

				if var_212_19 > 0 and var_212_13 < var_212_19 then
					arg_209_1.talkMaxDuration = var_212_19

					if var_212_19 + var_212_12 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_19 + var_212_12
					end
				end

				arg_209_1.text_.text = var_212_16
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501051", "story_v_out_121501.awb") ~= 0 then
					local var_212_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501051", "story_v_out_121501.awb") / 1000

					if var_212_20 + var_212_12 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_20 + var_212_12
					end

					if var_212_15.prefab_name ~= "" and arg_209_1.actors_[var_212_15.prefab_name] ~= nil then
						local var_212_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_15.prefab_name].transform, "story_v_out_121501", "121501051", "story_v_out_121501.awb")

						arg_209_1:RecordAudio("121501051", var_212_21)
						arg_209_1:RecordAudio("121501051", var_212_21)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_121501", "121501051", "story_v_out_121501.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_121501", "121501051", "story_v_out_121501.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_22 = math.max(var_212_13, arg_209_1.talkMaxDuration)

			if var_212_12 <= arg_209_1.time_ and arg_209_1.time_ < var_212_12 + var_212_22 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_12) / var_212_22

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_12 + var_212_22 and arg_209_1.time_ < var_212_12 + var_212_22 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play121501052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 121501052
		arg_213_1.duration_ = 4.63

		local var_213_0 = {
			ja = 4.633,
			ko = 4.533,
			zh = 4.533
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play121501053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_216_1 = 0
			local var_216_2 = 0.4

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_3 = arg_213_1:FormatText(StoryNameCfg[319].name)

				arg_213_1.leftNameTxt_.text = var_216_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_4 = arg_213_1:GetWordFromCfg(121501052)
				local var_216_5 = arg_213_1:FormatText(var_216_4.content)

				arg_213_1.text_.text = var_216_5

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_6 = 16
				local var_216_7 = utf8.len(var_216_5)
				local var_216_8 = var_216_6 <= 0 and var_216_2 or var_216_2 * (var_216_7 / var_216_6)

				if var_216_8 > 0 and var_216_2 < var_216_8 then
					arg_213_1.talkMaxDuration = var_216_8

					if var_216_8 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_1
					end
				end

				arg_213_1.text_.text = var_216_5
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501052", "story_v_out_121501.awb") ~= 0 then
					local var_216_9 = manager.audio:GetVoiceLength("story_v_out_121501", "121501052", "story_v_out_121501.awb") / 1000

					if var_216_9 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_1
					end

					if var_216_4.prefab_name ~= "" and arg_213_1.actors_[var_216_4.prefab_name] ~= nil then
						local var_216_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_4.prefab_name].transform, "story_v_out_121501", "121501052", "story_v_out_121501.awb")

						arg_213_1:RecordAudio("121501052", var_216_10)
						arg_213_1:RecordAudio("121501052", var_216_10)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_121501", "121501052", "story_v_out_121501.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_121501", "121501052", "story_v_out_121501.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_11 = math.max(var_216_2, arg_213_1.talkMaxDuration)

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_11 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_1) / var_216_11

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_1 + var_216_11 and arg_213_1.time_ < var_216_1 + var_216_11 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play121501053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 121501053
		arg_217_1.duration_ = 4.3

		local var_217_0 = {
			ja = 4.3,
			ko = 3.966,
			zh = 3.966
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play121501054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10014ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect10014ui_story == nil then
				arg_217_1.var_.characterEffect10014ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect10014ui_story and not isNil(var_220_0) then
					arg_217_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect10014ui_story then
				arg_217_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_220_4 = 0

			if var_220_4 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
				arg_217_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014actionlink/10014action442")
			end

			local var_220_5 = 0

			if var_220_5 < arg_217_1.time_ and arg_217_1.time_ <= var_220_5 + arg_220_0 then
				arg_217_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_220_6 = arg_217_1.actors_["1029ui_story"]
			local var_220_7 = 0

			if var_220_7 < arg_217_1.time_ and arg_217_1.time_ <= var_220_7 + arg_220_0 and not isNil(var_220_6) and arg_217_1.var_.characterEffect1029ui_story == nil then
				arg_217_1.var_.characterEffect1029ui_story = var_220_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_8 = 0.200000002980232

			if var_220_7 <= arg_217_1.time_ and arg_217_1.time_ < var_220_7 + var_220_8 and not isNil(var_220_6) then
				local var_220_9 = (arg_217_1.time_ - var_220_7) / var_220_8

				if arg_217_1.var_.characterEffect1029ui_story and not isNil(var_220_6) then
					local var_220_10 = Mathf.Lerp(0, 0.5, var_220_9)

					arg_217_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1029ui_story.fillRatio = var_220_10
				end
			end

			if arg_217_1.time_ >= var_220_7 + var_220_8 and arg_217_1.time_ < var_220_7 + var_220_8 + arg_220_0 and not isNil(var_220_6) and arg_217_1.var_.characterEffect1029ui_story then
				local var_220_11 = 0.5

				arg_217_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1029ui_story.fillRatio = var_220_11
			end

			local var_220_12 = 0
			local var_220_13 = 0.45

			if var_220_12 < arg_217_1.time_ and arg_217_1.time_ <= var_220_12 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_14 = arg_217_1:FormatText(StoryNameCfg[264].name)

				arg_217_1.leftNameTxt_.text = var_220_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_15 = arg_217_1:GetWordFromCfg(121501053)
				local var_220_16 = arg_217_1:FormatText(var_220_15.content)

				arg_217_1.text_.text = var_220_16

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_17 = 18
				local var_220_18 = utf8.len(var_220_16)
				local var_220_19 = var_220_17 <= 0 and var_220_13 or var_220_13 * (var_220_18 / var_220_17)

				if var_220_19 > 0 and var_220_13 < var_220_19 then
					arg_217_1.talkMaxDuration = var_220_19

					if var_220_19 + var_220_12 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_19 + var_220_12
					end
				end

				arg_217_1.text_.text = var_220_16
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501053", "story_v_out_121501.awb") ~= 0 then
					local var_220_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501053", "story_v_out_121501.awb") / 1000

					if var_220_20 + var_220_12 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_20 + var_220_12
					end

					if var_220_15.prefab_name ~= "" and arg_217_1.actors_[var_220_15.prefab_name] ~= nil then
						local var_220_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_15.prefab_name].transform, "story_v_out_121501", "121501053", "story_v_out_121501.awb")

						arg_217_1:RecordAudio("121501053", var_220_21)
						arg_217_1:RecordAudio("121501053", var_220_21)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_121501", "121501053", "story_v_out_121501.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_121501", "121501053", "story_v_out_121501.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_22 = math.max(var_220_13, arg_217_1.talkMaxDuration)

			if var_220_12 <= arg_217_1.time_ and arg_217_1.time_ < var_220_12 + var_220_22 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_12) / var_220_22

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_12 + var_220_22 and arg_217_1.time_ < var_220_12 + var_220_22 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play121501054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 121501054
		arg_221_1.duration_ = 2.5

		local var_221_0 = {
			ja = 2.5,
			ko = 1.933,
			zh = 1.933
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play121501055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1029ui_story"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1029ui_story == nil then
				arg_221_1.var_.characterEffect1029ui_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect1029ui_story and not isNil(var_224_0) then
					arg_221_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1029ui_story then
				arg_221_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_224_4 = arg_221_1.actors_["10014ui_story"]
			local var_224_5 = 0

			if var_224_5 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 and not isNil(var_224_4) and arg_221_1.var_.characterEffect10014ui_story == nil then
				arg_221_1.var_.characterEffect10014ui_story = var_224_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_6 = 0.200000002980232

			if var_224_5 <= arg_221_1.time_ and arg_221_1.time_ < var_224_5 + var_224_6 and not isNil(var_224_4) then
				local var_224_7 = (arg_221_1.time_ - var_224_5) / var_224_6

				if arg_221_1.var_.characterEffect10014ui_story and not isNil(var_224_4) then
					local var_224_8 = Mathf.Lerp(0, 0.5, var_224_7)

					arg_221_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_221_1.var_.characterEffect10014ui_story.fillRatio = var_224_8
				end
			end

			if arg_221_1.time_ >= var_224_5 + var_224_6 and arg_221_1.time_ < var_224_5 + var_224_6 + arg_224_0 and not isNil(var_224_4) and arg_221_1.var_.characterEffect10014ui_story then
				local var_224_9 = 0.5

				arg_221_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_221_1.var_.characterEffect10014ui_story.fillRatio = var_224_9
			end

			local var_224_10 = 0
			local var_224_11 = 0.2

			if var_224_10 < arg_221_1.time_ and arg_221_1.time_ <= var_224_10 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_12 = arg_221_1:FormatText(StoryNameCfg[319].name)

				arg_221_1.leftNameTxt_.text = var_224_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_13 = arg_221_1:GetWordFromCfg(121501054)
				local var_224_14 = arg_221_1:FormatText(var_224_13.content)

				arg_221_1.text_.text = var_224_14

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_15 = 8
				local var_224_16 = utf8.len(var_224_14)
				local var_224_17 = var_224_15 <= 0 and var_224_11 or var_224_11 * (var_224_16 / var_224_15)

				if var_224_17 > 0 and var_224_11 < var_224_17 then
					arg_221_1.talkMaxDuration = var_224_17

					if var_224_17 + var_224_10 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_17 + var_224_10
					end
				end

				arg_221_1.text_.text = var_224_14
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501054", "story_v_out_121501.awb") ~= 0 then
					local var_224_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501054", "story_v_out_121501.awb") / 1000

					if var_224_18 + var_224_10 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_18 + var_224_10
					end

					if var_224_13.prefab_name ~= "" and arg_221_1.actors_[var_224_13.prefab_name] ~= nil then
						local var_224_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_13.prefab_name].transform, "story_v_out_121501", "121501054", "story_v_out_121501.awb")

						arg_221_1:RecordAudio("121501054", var_224_19)
						arg_221_1:RecordAudio("121501054", var_224_19)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_121501", "121501054", "story_v_out_121501.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_121501", "121501054", "story_v_out_121501.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_20 = math.max(var_224_11, arg_221_1.talkMaxDuration)

			if var_224_10 <= arg_221_1.time_ and arg_221_1.time_ < var_224_10 + var_224_20 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_10) / var_224_20

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_10 + var_224_20 and arg_221_1.time_ < var_224_10 + var_224_20 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play121501055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 121501055
		arg_225_1.duration_ = 2.73

		local var_225_0 = {
			ja = 1.166,
			ko = 2.733,
			zh = 2.733
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play121501056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1029ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1029ui_story == nil then
				arg_225_1.var_.characterEffect1029ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1029ui_story and not isNil(var_228_0) then
					local var_228_4 = Mathf.Lerp(0, 0.5, var_228_3)

					arg_225_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1029ui_story.fillRatio = var_228_4
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1029ui_story then
				local var_228_5 = 0.5

				arg_225_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1029ui_story.fillRatio = var_228_5
			end

			local var_228_6 = arg_225_1.actors_["10014ui_story"]
			local var_228_7 = 0

			if var_228_7 < arg_225_1.time_ and arg_225_1.time_ <= var_228_7 + arg_228_0 and not isNil(var_228_6) and arg_225_1.var_.characterEffect10014ui_story == nil then
				arg_225_1.var_.characterEffect10014ui_story = var_228_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_8 = 0.200000002980232

			if var_228_7 <= arg_225_1.time_ and arg_225_1.time_ < var_228_7 + var_228_8 and not isNil(var_228_6) then
				local var_228_9 = (arg_225_1.time_ - var_228_7) / var_228_8

				if arg_225_1.var_.characterEffect10014ui_story and not isNil(var_228_6) then
					arg_225_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_7 + var_228_8 and arg_225_1.time_ < var_228_7 + var_228_8 + arg_228_0 and not isNil(var_228_6) and arg_225_1.var_.characterEffect10014ui_story then
				arg_225_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_228_10 = 0
			local var_228_11 = 0.05

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_12 = arg_225_1:FormatText(StoryNameCfg[264].name)

				arg_225_1.leftNameTxt_.text = var_228_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_13 = arg_225_1:GetWordFromCfg(121501055)
				local var_228_14 = arg_225_1:FormatText(var_228_13.content)

				arg_225_1.text_.text = var_228_14

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_15 = 2
				local var_228_16 = utf8.len(var_228_14)
				local var_228_17 = var_228_15 <= 0 and var_228_11 or var_228_11 * (var_228_16 / var_228_15)

				if var_228_17 > 0 and var_228_11 < var_228_17 then
					arg_225_1.talkMaxDuration = var_228_17

					if var_228_17 + var_228_10 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_17 + var_228_10
					end
				end

				arg_225_1.text_.text = var_228_14
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501055", "story_v_out_121501.awb") ~= 0 then
					local var_228_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501055", "story_v_out_121501.awb") / 1000

					if var_228_18 + var_228_10 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_18 + var_228_10
					end

					if var_228_13.prefab_name ~= "" and arg_225_1.actors_[var_228_13.prefab_name] ~= nil then
						local var_228_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_13.prefab_name].transform, "story_v_out_121501", "121501055", "story_v_out_121501.awb")

						arg_225_1:RecordAudio("121501055", var_228_19)
						arg_225_1:RecordAudio("121501055", var_228_19)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_121501", "121501055", "story_v_out_121501.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_121501", "121501055", "story_v_out_121501.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_20 = math.max(var_228_11, arg_225_1.talkMaxDuration)

			if var_228_10 <= arg_225_1.time_ and arg_225_1.time_ < var_228_10 + var_228_20 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_10) / var_228_20

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_10 + var_228_20 and arg_225_1.time_ < var_228_10 + var_228_20 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play121501056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 121501056
		arg_229_1.duration_ = 12.87

		local var_229_0 = {
			ja = 12.866,
			ko = 12.2,
			zh = 12.2
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play121501057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1029ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1029ui_story == nil then
				arg_229_1.var_.characterEffect1029ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect1029ui_story and not isNil(var_232_0) then
					arg_229_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1029ui_story then
				arg_229_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_232_4 = arg_229_1.actors_["10014ui_story"]
			local var_232_5 = 0

			if var_232_5 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 and not isNil(var_232_4) and arg_229_1.var_.characterEffect10014ui_story == nil then
				arg_229_1.var_.characterEffect10014ui_story = var_232_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_6 = 0.200000002980232

			if var_232_5 <= arg_229_1.time_ and arg_229_1.time_ < var_232_5 + var_232_6 and not isNil(var_232_4) then
				local var_232_7 = (arg_229_1.time_ - var_232_5) / var_232_6

				if arg_229_1.var_.characterEffect10014ui_story and not isNil(var_232_4) then
					local var_232_8 = Mathf.Lerp(0, 0.5, var_232_7)

					arg_229_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_229_1.var_.characterEffect10014ui_story.fillRatio = var_232_8
				end
			end

			if arg_229_1.time_ >= var_232_5 + var_232_6 and arg_229_1.time_ < var_232_5 + var_232_6 + arg_232_0 and not isNil(var_232_4) and arg_229_1.var_.characterEffect10014ui_story then
				local var_232_9 = 0.5

				arg_229_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_229_1.var_.characterEffect10014ui_story.fillRatio = var_232_9
			end

			local var_232_10 = 0
			local var_232_11 = 1.3

			if var_232_10 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_12 = arg_229_1:FormatText(StoryNameCfg[319].name)

				arg_229_1.leftNameTxt_.text = var_232_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_13 = arg_229_1:GetWordFromCfg(121501056)
				local var_232_14 = arg_229_1:FormatText(var_232_13.content)

				arg_229_1.text_.text = var_232_14

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_15 = 52
				local var_232_16 = utf8.len(var_232_14)
				local var_232_17 = var_232_15 <= 0 and var_232_11 or var_232_11 * (var_232_16 / var_232_15)

				if var_232_17 > 0 and var_232_11 < var_232_17 then
					arg_229_1.talkMaxDuration = var_232_17

					if var_232_17 + var_232_10 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_17 + var_232_10
					end
				end

				arg_229_1.text_.text = var_232_14
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501056", "story_v_out_121501.awb") ~= 0 then
					local var_232_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501056", "story_v_out_121501.awb") / 1000

					if var_232_18 + var_232_10 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_18 + var_232_10
					end

					if var_232_13.prefab_name ~= "" and arg_229_1.actors_[var_232_13.prefab_name] ~= nil then
						local var_232_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_13.prefab_name].transform, "story_v_out_121501", "121501056", "story_v_out_121501.awb")

						arg_229_1:RecordAudio("121501056", var_232_19)
						arg_229_1:RecordAudio("121501056", var_232_19)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_121501", "121501056", "story_v_out_121501.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_121501", "121501056", "story_v_out_121501.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_20 = math.max(var_232_11, arg_229_1.talkMaxDuration)

			if var_232_10 <= arg_229_1.time_ and arg_229_1.time_ < var_232_10 + var_232_20 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_10) / var_232_20

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_10 + var_232_20 and arg_229_1.time_ < var_232_10 + var_232_20 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play121501057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 121501057
		arg_233_1.duration_ = 10.8

		local var_233_0 = {
			ja = 10.8,
			ko = 10.666,
			zh = 10.666
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play121501058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 1.125

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_2 = arg_233_1:FormatText(StoryNameCfg[319].name)

				arg_233_1.leftNameTxt_.text = var_236_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_3 = arg_233_1:GetWordFromCfg(121501057)
				local var_236_4 = arg_233_1:FormatText(var_236_3.content)

				arg_233_1.text_.text = var_236_4

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 45
				local var_236_6 = utf8.len(var_236_4)
				local var_236_7 = var_236_5 <= 0 and var_236_1 or var_236_1 * (var_236_6 / var_236_5)

				if var_236_7 > 0 and var_236_1 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_4
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501057", "story_v_out_121501.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_out_121501", "121501057", "story_v_out_121501.awb") / 1000

					if var_236_8 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_0
					end

					if var_236_3.prefab_name ~= "" and arg_233_1.actors_[var_236_3.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_3.prefab_name].transform, "story_v_out_121501", "121501057", "story_v_out_121501.awb")

						arg_233_1:RecordAudio("121501057", var_236_9)
						arg_233_1:RecordAudio("121501057", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_121501", "121501057", "story_v_out_121501.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_121501", "121501057", "story_v_out_121501.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_10 and arg_233_1.time_ < var_236_0 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play121501058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 121501058
		arg_237_1.duration_ = 6

		local var_237_0 = {
			ja = 6,
			ko = 3.2,
			zh = 3.2
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play121501059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1029ui_story"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1029ui_story == nil then
				arg_237_1.var_.characterEffect1029ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.characterEffect1029ui_story and not isNil(var_240_0) then
					local var_240_4 = Mathf.Lerp(0, 0.5, var_240_3)

					arg_237_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1029ui_story.fillRatio = var_240_4
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1029ui_story then
				local var_240_5 = 0.5

				arg_237_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1029ui_story.fillRatio = var_240_5
			end

			local var_240_6 = arg_237_1.actors_["10014ui_story"]
			local var_240_7 = 0

			if var_240_7 < arg_237_1.time_ and arg_237_1.time_ <= var_240_7 + arg_240_0 and not isNil(var_240_6) and arg_237_1.var_.characterEffect10014ui_story == nil then
				arg_237_1.var_.characterEffect10014ui_story = var_240_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_8 = 0.200000002980232

			if var_240_7 <= arg_237_1.time_ and arg_237_1.time_ < var_240_7 + var_240_8 and not isNil(var_240_6) then
				local var_240_9 = (arg_237_1.time_ - var_240_7) / var_240_8

				if arg_237_1.var_.characterEffect10014ui_story and not isNil(var_240_6) then
					arg_237_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_7 + var_240_8 and arg_237_1.time_ < var_240_7 + var_240_8 + arg_240_0 and not isNil(var_240_6) and arg_237_1.var_.characterEffect10014ui_story then
				arg_237_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_240_10 = 0
			local var_240_11 = 0.2

			if var_240_10 < arg_237_1.time_ and arg_237_1.time_ <= var_240_10 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_12 = arg_237_1:FormatText(StoryNameCfg[264].name)

				arg_237_1.leftNameTxt_.text = var_240_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_13 = arg_237_1:GetWordFromCfg(121501058)
				local var_240_14 = arg_237_1:FormatText(var_240_13.content)

				arg_237_1.text_.text = var_240_14

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_15 = 8
				local var_240_16 = utf8.len(var_240_14)
				local var_240_17 = var_240_15 <= 0 and var_240_11 or var_240_11 * (var_240_16 / var_240_15)

				if var_240_17 > 0 and var_240_11 < var_240_17 then
					arg_237_1.talkMaxDuration = var_240_17

					if var_240_17 + var_240_10 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_17 + var_240_10
					end
				end

				arg_237_1.text_.text = var_240_14
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501058", "story_v_out_121501.awb") ~= 0 then
					local var_240_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501058", "story_v_out_121501.awb") / 1000

					if var_240_18 + var_240_10 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_18 + var_240_10
					end

					if var_240_13.prefab_name ~= "" and arg_237_1.actors_[var_240_13.prefab_name] ~= nil then
						local var_240_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_13.prefab_name].transform, "story_v_out_121501", "121501058", "story_v_out_121501.awb")

						arg_237_1:RecordAudio("121501058", var_240_19)
						arg_237_1:RecordAudio("121501058", var_240_19)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_121501", "121501058", "story_v_out_121501.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_121501", "121501058", "story_v_out_121501.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_20 = math.max(var_240_11, arg_237_1.talkMaxDuration)

			if var_240_10 <= arg_237_1.time_ and arg_237_1.time_ < var_240_10 + var_240_20 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_10) / var_240_20

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_10 + var_240_20 and arg_237_1.time_ < var_240_10 + var_240_20 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play121501059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 121501059
		arg_241_1.duration_ = 8.3

		local var_241_0 = {
			ja = 8.233,
			ko = 8.3,
			zh = 8.3
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play121501060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1029ui_story"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1029ui_story == nil then
				arg_241_1.var_.characterEffect1029ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.characterEffect1029ui_story and not isNil(var_244_0) then
					arg_241_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1029ui_story then
				arg_241_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_244_4 = arg_241_1.actors_["10014ui_story"]
			local var_244_5 = 0

			if var_244_5 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 and not isNil(var_244_4) and arg_241_1.var_.characterEffect10014ui_story == nil then
				arg_241_1.var_.characterEffect10014ui_story = var_244_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_6 = 0.200000002980232

			if var_244_5 <= arg_241_1.time_ and arg_241_1.time_ < var_244_5 + var_244_6 and not isNil(var_244_4) then
				local var_244_7 = (arg_241_1.time_ - var_244_5) / var_244_6

				if arg_241_1.var_.characterEffect10014ui_story and not isNil(var_244_4) then
					local var_244_8 = Mathf.Lerp(0, 0.5, var_244_7)

					arg_241_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_241_1.var_.characterEffect10014ui_story.fillRatio = var_244_8
				end
			end

			if arg_241_1.time_ >= var_244_5 + var_244_6 and arg_241_1.time_ < var_244_5 + var_244_6 + arg_244_0 and not isNil(var_244_4) and arg_241_1.var_.characterEffect10014ui_story then
				local var_244_9 = 0.5

				arg_241_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_241_1.var_.characterEffect10014ui_story.fillRatio = var_244_9
			end

			local var_244_10 = 0
			local var_244_11 = 0.825

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_12 = arg_241_1:FormatText(StoryNameCfg[319].name)

				arg_241_1.leftNameTxt_.text = var_244_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_13 = arg_241_1:GetWordFromCfg(121501059)
				local var_244_14 = arg_241_1:FormatText(var_244_13.content)

				arg_241_1.text_.text = var_244_14

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_15 = 33
				local var_244_16 = utf8.len(var_244_14)
				local var_244_17 = var_244_15 <= 0 and var_244_11 or var_244_11 * (var_244_16 / var_244_15)

				if var_244_17 > 0 and var_244_11 < var_244_17 then
					arg_241_1.talkMaxDuration = var_244_17

					if var_244_17 + var_244_10 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_17 + var_244_10
					end
				end

				arg_241_1.text_.text = var_244_14
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501059", "story_v_out_121501.awb") ~= 0 then
					local var_244_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501059", "story_v_out_121501.awb") / 1000

					if var_244_18 + var_244_10 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_18 + var_244_10
					end

					if var_244_13.prefab_name ~= "" and arg_241_1.actors_[var_244_13.prefab_name] ~= nil then
						local var_244_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_13.prefab_name].transform, "story_v_out_121501", "121501059", "story_v_out_121501.awb")

						arg_241_1:RecordAudio("121501059", var_244_19)
						arg_241_1:RecordAudio("121501059", var_244_19)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_121501", "121501059", "story_v_out_121501.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_121501", "121501059", "story_v_out_121501.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_20 = math.max(var_244_11, arg_241_1.talkMaxDuration)

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_20 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_10) / var_244_20

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_10 + var_244_20 and arg_241_1.time_ < var_244_10 + var_244_20 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play121501060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 121501060
		arg_245_1.duration_ = 7.43

		local var_245_0 = {
			ja = 6.866,
			ko = 7.433,
			zh = 7.433
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play121501061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1029ui_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1029ui_story == nil then
				arg_245_1.var_.characterEffect1029ui_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect1029ui_story and not isNil(var_248_0) then
					local var_248_4 = Mathf.Lerp(0, 0.5, var_248_3)

					arg_245_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1029ui_story.fillRatio = var_248_4
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1029ui_story then
				local var_248_5 = 0.5

				arg_245_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1029ui_story.fillRatio = var_248_5
			end

			local var_248_6 = arg_245_1.actors_["10014ui_story"]
			local var_248_7 = 0

			if var_248_7 < arg_245_1.time_ and arg_245_1.time_ <= var_248_7 + arg_248_0 and not isNil(var_248_6) and arg_245_1.var_.characterEffect10014ui_story == nil then
				arg_245_1.var_.characterEffect10014ui_story = var_248_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_8 = 0.200000002980232

			if var_248_7 <= arg_245_1.time_ and arg_245_1.time_ < var_248_7 + var_248_8 and not isNil(var_248_6) then
				local var_248_9 = (arg_245_1.time_ - var_248_7) / var_248_8

				if arg_245_1.var_.characterEffect10014ui_story and not isNil(var_248_6) then
					arg_245_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_7 + var_248_8 and arg_245_1.time_ < var_248_7 + var_248_8 + arg_248_0 and not isNil(var_248_6) and arg_245_1.var_.characterEffect10014ui_story then
				arg_245_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_248_10 = 0
			local var_248_11 = 0.825

			if var_248_10 < arg_245_1.time_ and arg_245_1.time_ <= var_248_10 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_12 = arg_245_1:FormatText(StoryNameCfg[264].name)

				arg_245_1.leftNameTxt_.text = var_248_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_13 = arg_245_1:GetWordFromCfg(121501060)
				local var_248_14 = arg_245_1:FormatText(var_248_13.content)

				arg_245_1.text_.text = var_248_14

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_15 = 33
				local var_248_16 = utf8.len(var_248_14)
				local var_248_17 = var_248_15 <= 0 and var_248_11 or var_248_11 * (var_248_16 / var_248_15)

				if var_248_17 > 0 and var_248_11 < var_248_17 then
					arg_245_1.talkMaxDuration = var_248_17

					if var_248_17 + var_248_10 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_17 + var_248_10
					end
				end

				arg_245_1.text_.text = var_248_14
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501060", "story_v_out_121501.awb") ~= 0 then
					local var_248_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501060", "story_v_out_121501.awb") / 1000

					if var_248_18 + var_248_10 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_18 + var_248_10
					end

					if var_248_13.prefab_name ~= "" and arg_245_1.actors_[var_248_13.prefab_name] ~= nil then
						local var_248_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_13.prefab_name].transform, "story_v_out_121501", "121501060", "story_v_out_121501.awb")

						arg_245_1:RecordAudio("121501060", var_248_19)
						arg_245_1:RecordAudio("121501060", var_248_19)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_121501", "121501060", "story_v_out_121501.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_121501", "121501060", "story_v_out_121501.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_20 = math.max(var_248_11, arg_245_1.talkMaxDuration)

			if var_248_10 <= arg_245_1.time_ and arg_245_1.time_ < var_248_10 + var_248_20 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_10) / var_248_20

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_10 + var_248_20 and arg_245_1.time_ < var_248_10 + var_248_20 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play121501061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 121501061
		arg_249_1.duration_ = 6.7

		local var_249_0 = {
			ja = 6.7,
			ko = 3.966,
			zh = 3.966
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
				arg_249_0:Play121501062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action445")
			end

			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_252_2 = arg_249_1.actors_["1029ui_story"]
			local var_252_3 = 0

			if var_252_3 < arg_249_1.time_ and arg_249_1.time_ <= var_252_3 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.characterEffect1029ui_story == nil then
				arg_249_1.var_.characterEffect1029ui_story = var_252_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_4 = 0.200000002980232

			if var_252_3 <= arg_249_1.time_ and arg_249_1.time_ < var_252_3 + var_252_4 and not isNil(var_252_2) then
				local var_252_5 = (arg_249_1.time_ - var_252_3) / var_252_4

				if arg_249_1.var_.characterEffect1029ui_story and not isNil(var_252_2) then
					arg_249_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_3 + var_252_4 and arg_249_1.time_ < var_252_3 + var_252_4 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.characterEffect1029ui_story then
				arg_249_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_252_6 = arg_249_1.actors_["10014ui_story"]
			local var_252_7 = 0

			if var_252_7 < arg_249_1.time_ and arg_249_1.time_ <= var_252_7 + arg_252_0 and not isNil(var_252_6) and arg_249_1.var_.characterEffect10014ui_story == nil then
				arg_249_1.var_.characterEffect10014ui_story = var_252_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_8 = 0.200000002980232

			if var_252_7 <= arg_249_1.time_ and arg_249_1.time_ < var_252_7 + var_252_8 and not isNil(var_252_6) then
				local var_252_9 = (arg_249_1.time_ - var_252_7) / var_252_8

				if arg_249_1.var_.characterEffect10014ui_story and not isNil(var_252_6) then
					local var_252_10 = Mathf.Lerp(0, 0.5, var_252_9)

					arg_249_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_249_1.var_.characterEffect10014ui_story.fillRatio = var_252_10
				end
			end

			if arg_249_1.time_ >= var_252_7 + var_252_8 and arg_249_1.time_ < var_252_7 + var_252_8 + arg_252_0 and not isNil(var_252_6) and arg_249_1.var_.characterEffect10014ui_story then
				local var_252_11 = 0.5

				arg_249_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_249_1.var_.characterEffect10014ui_story.fillRatio = var_252_11
			end

			local var_252_12 = 0
			local var_252_13 = 0.35

			if var_252_12 < arg_249_1.time_ and arg_249_1.time_ <= var_252_12 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_14 = arg_249_1:FormatText(StoryNameCfg[319].name)

				arg_249_1.leftNameTxt_.text = var_252_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_15 = arg_249_1:GetWordFromCfg(121501061)
				local var_252_16 = arg_249_1:FormatText(var_252_15.content)

				arg_249_1.text_.text = var_252_16

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_17 = 14
				local var_252_18 = utf8.len(var_252_16)
				local var_252_19 = var_252_17 <= 0 and var_252_13 or var_252_13 * (var_252_18 / var_252_17)

				if var_252_19 > 0 and var_252_13 < var_252_19 then
					arg_249_1.talkMaxDuration = var_252_19

					if var_252_19 + var_252_12 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_19 + var_252_12
					end
				end

				arg_249_1.text_.text = var_252_16
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501061", "story_v_out_121501.awb") ~= 0 then
					local var_252_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501061", "story_v_out_121501.awb") / 1000

					if var_252_20 + var_252_12 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_20 + var_252_12
					end

					if var_252_15.prefab_name ~= "" and arg_249_1.actors_[var_252_15.prefab_name] ~= nil then
						local var_252_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_15.prefab_name].transform, "story_v_out_121501", "121501061", "story_v_out_121501.awb")

						arg_249_1:RecordAudio("121501061", var_252_21)
						arg_249_1:RecordAudio("121501061", var_252_21)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_121501", "121501061", "story_v_out_121501.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_121501", "121501061", "story_v_out_121501.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_22 = math.max(var_252_13, arg_249_1.talkMaxDuration)

			if var_252_12 <= arg_249_1.time_ and arg_249_1.time_ < var_252_12 + var_252_22 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_12) / var_252_22

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_12 + var_252_22 and arg_249_1.time_ < var_252_12 + var_252_22 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play121501062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 121501062
		arg_253_1.duration_ = 7.27

		local var_253_0 = {
			ja = 7.266,
			ko = 6.333,
			zh = 6.333
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
				arg_253_0:Play121501063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["10014ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect10014ui_story == nil then
				arg_253_1.var_.characterEffect10014ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect10014ui_story and not isNil(var_256_0) then
					arg_253_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect10014ui_story then
				arg_253_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_256_4 = arg_253_1.actors_["1029ui_story"]
			local var_256_5 = 0

			if var_256_5 < arg_253_1.time_ and arg_253_1.time_ <= var_256_5 + arg_256_0 and not isNil(var_256_4) and arg_253_1.var_.characterEffect1029ui_story == nil then
				arg_253_1.var_.characterEffect1029ui_story = var_256_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_6 = 0.200000002980232

			if var_256_5 <= arg_253_1.time_ and arg_253_1.time_ < var_256_5 + var_256_6 and not isNil(var_256_4) then
				local var_256_7 = (arg_253_1.time_ - var_256_5) / var_256_6

				if arg_253_1.var_.characterEffect1029ui_story and not isNil(var_256_4) then
					local var_256_8 = Mathf.Lerp(0, 0.5, var_256_7)

					arg_253_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1029ui_story.fillRatio = var_256_8
				end
			end

			if arg_253_1.time_ >= var_256_5 + var_256_6 and arg_253_1.time_ < var_256_5 + var_256_6 + arg_256_0 and not isNil(var_256_4) and arg_253_1.var_.characterEffect1029ui_story then
				local var_256_9 = 0.5

				arg_253_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1029ui_story.fillRatio = var_256_9
			end

			local var_256_10 = 0
			local var_256_11 = 0.75

			if var_256_10 < arg_253_1.time_ and arg_253_1.time_ <= var_256_10 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_12 = arg_253_1:FormatText(StoryNameCfg[264].name)

				arg_253_1.leftNameTxt_.text = var_256_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_13 = arg_253_1:GetWordFromCfg(121501062)
				local var_256_14 = arg_253_1:FormatText(var_256_13.content)

				arg_253_1.text_.text = var_256_14

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_15 = 30
				local var_256_16 = utf8.len(var_256_14)
				local var_256_17 = var_256_15 <= 0 and var_256_11 or var_256_11 * (var_256_16 / var_256_15)

				if var_256_17 > 0 and var_256_11 < var_256_17 then
					arg_253_1.talkMaxDuration = var_256_17

					if var_256_17 + var_256_10 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_17 + var_256_10
					end
				end

				arg_253_1.text_.text = var_256_14
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501062", "story_v_out_121501.awb") ~= 0 then
					local var_256_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501062", "story_v_out_121501.awb") / 1000

					if var_256_18 + var_256_10 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_18 + var_256_10
					end

					if var_256_13.prefab_name ~= "" and arg_253_1.actors_[var_256_13.prefab_name] ~= nil then
						local var_256_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_13.prefab_name].transform, "story_v_out_121501", "121501062", "story_v_out_121501.awb")

						arg_253_1:RecordAudio("121501062", var_256_19)
						arg_253_1:RecordAudio("121501062", var_256_19)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_121501", "121501062", "story_v_out_121501.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_121501", "121501062", "story_v_out_121501.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_20 = math.max(var_256_11, arg_253_1.talkMaxDuration)

			if var_256_10 <= arg_253_1.time_ and arg_253_1.time_ < var_256_10 + var_256_20 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_10) / var_256_20

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_10 + var_256_20 and arg_253_1.time_ < var_256_10 + var_256_20 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play121501063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 121501063
		arg_257_1.duration_ = 8.8

		local var_257_0 = {
			ja = 8.8,
			ko = 5.533,
			zh = 5.533
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play121501064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.65

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[264].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_3 = arg_257_1:GetWordFromCfg(121501063)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 26
				local var_260_6 = utf8.len(var_260_4)
				local var_260_7 = var_260_5 <= 0 and var_260_1 or var_260_1 * (var_260_6 / var_260_5)

				if var_260_7 > 0 and var_260_1 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501063", "story_v_out_121501.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_121501", "121501063", "story_v_out_121501.awb") / 1000

					if var_260_8 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_0
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_out_121501", "121501063", "story_v_out_121501.awb")

						arg_257_1:RecordAudio("121501063", var_260_9)
						arg_257_1:RecordAudio("121501063", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_121501", "121501063", "story_v_out_121501.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_121501", "121501063", "story_v_out_121501.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_10 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_10

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_10 and arg_257_1.time_ < var_260_0 + var_260_10 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play121501064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 121501064
		arg_261_1.duration_ = 11.33

		local var_261_0 = {
			ja = 8.666,
			ko = 11.333,
			zh = 11.333
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
				arg_261_0:Play121501065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1029ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1029ui_story == nil then
				arg_261_1.var_.characterEffect1029ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect1029ui_story and not isNil(var_264_0) then
					arg_261_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1029ui_story then
				arg_261_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_264_4 = arg_261_1.actors_["10014ui_story"]
			local var_264_5 = 0

			if var_264_5 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect10014ui_story == nil then
				arg_261_1.var_.characterEffect10014ui_story = var_264_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_6 = 0.200000002980232

			if var_264_5 <= arg_261_1.time_ and arg_261_1.time_ < var_264_5 + var_264_6 and not isNil(var_264_4) then
				local var_264_7 = (arg_261_1.time_ - var_264_5) / var_264_6

				if arg_261_1.var_.characterEffect10014ui_story and not isNil(var_264_4) then
					local var_264_8 = Mathf.Lerp(0, 0.5, var_264_7)

					arg_261_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_261_1.var_.characterEffect10014ui_story.fillRatio = var_264_8
				end
			end

			if arg_261_1.time_ >= var_264_5 + var_264_6 and arg_261_1.time_ < var_264_5 + var_264_6 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect10014ui_story then
				local var_264_9 = 0.5

				arg_261_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_261_1.var_.characterEffect10014ui_story.fillRatio = var_264_9
			end

			local var_264_10 = 0
			local var_264_11 = 1.2

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_12 = arg_261_1:FormatText(StoryNameCfg[319].name)

				arg_261_1.leftNameTxt_.text = var_264_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_13 = arg_261_1:GetWordFromCfg(121501064)
				local var_264_14 = arg_261_1:FormatText(var_264_13.content)

				arg_261_1.text_.text = var_264_14

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_15 = 48
				local var_264_16 = utf8.len(var_264_14)
				local var_264_17 = var_264_15 <= 0 and var_264_11 or var_264_11 * (var_264_16 / var_264_15)

				if var_264_17 > 0 and var_264_11 < var_264_17 then
					arg_261_1.talkMaxDuration = var_264_17

					if var_264_17 + var_264_10 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_17 + var_264_10
					end
				end

				arg_261_1.text_.text = var_264_14
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501064", "story_v_out_121501.awb") ~= 0 then
					local var_264_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501064", "story_v_out_121501.awb") / 1000

					if var_264_18 + var_264_10 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_18 + var_264_10
					end

					if var_264_13.prefab_name ~= "" and arg_261_1.actors_[var_264_13.prefab_name] ~= nil then
						local var_264_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_13.prefab_name].transform, "story_v_out_121501", "121501064", "story_v_out_121501.awb")

						arg_261_1:RecordAudio("121501064", var_264_19)
						arg_261_1:RecordAudio("121501064", var_264_19)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_121501", "121501064", "story_v_out_121501.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_121501", "121501064", "story_v_out_121501.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_20 = math.max(var_264_11, arg_261_1.talkMaxDuration)

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_20 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_10) / var_264_20

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_10 + var_264_20 and arg_261_1.time_ < var_264_10 + var_264_20 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play121501065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 121501065
		arg_265_1.duration_ = 8.3

		local var_265_0 = {
			ja = 8.3,
			ko = 5.933,
			zh = 5.933
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play121501066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.725

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[319].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_3 = arg_265_1:GetWordFromCfg(121501065)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 29
				local var_268_6 = utf8.len(var_268_4)
				local var_268_7 = var_268_5 <= 0 and var_268_1 or var_268_1 * (var_268_6 / var_268_5)

				if var_268_7 > 0 and var_268_1 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501065", "story_v_out_121501.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_121501", "121501065", "story_v_out_121501.awb") / 1000

					if var_268_8 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_0
					end

					if var_268_3.prefab_name ~= "" and arg_265_1.actors_[var_268_3.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_3.prefab_name].transform, "story_v_out_121501", "121501065", "story_v_out_121501.awb")

						arg_265_1:RecordAudio("121501065", var_268_9)
						arg_265_1:RecordAudio("121501065", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_121501", "121501065", "story_v_out_121501.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_121501", "121501065", "story_v_out_121501.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_10 and arg_265_1.time_ < var_268_0 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play121501066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 121501066
		arg_269_1.duration_ = 5.73

		local var_269_0 = {
			ja = 3.066,
			ko = 5.733,
			zh = 5.733
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play121501067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_272_1 = arg_269_1.actors_["1029ui_story"]
			local var_272_2 = 0

			if var_272_2 < arg_269_1.time_ and arg_269_1.time_ <= var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1029ui_story == nil then
				arg_269_1.var_.characterEffect1029ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_3 = 0.200000002980232

			if var_272_2 <= arg_269_1.time_ and arg_269_1.time_ < var_272_2 + var_272_3 and not isNil(var_272_1) then
				local var_272_4 = (arg_269_1.time_ - var_272_2) / var_272_3

				if arg_269_1.var_.characterEffect1029ui_story and not isNil(var_272_1) then
					local var_272_5 = Mathf.Lerp(0, 0.5, var_272_4)

					arg_269_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1029ui_story.fillRatio = var_272_5
				end
			end

			if arg_269_1.time_ >= var_272_2 + var_272_3 and arg_269_1.time_ < var_272_2 + var_272_3 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1029ui_story then
				local var_272_6 = 0.5

				arg_269_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1029ui_story.fillRatio = var_272_6
			end

			local var_272_7 = arg_269_1.actors_["10014ui_story"]
			local var_272_8 = 0

			if var_272_8 < arg_269_1.time_ and arg_269_1.time_ <= var_272_8 + arg_272_0 and not isNil(var_272_7) and arg_269_1.var_.characterEffect10014ui_story == nil then
				arg_269_1.var_.characterEffect10014ui_story = var_272_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_9 = 0.200000002980232

			if var_272_8 <= arg_269_1.time_ and arg_269_1.time_ < var_272_8 + var_272_9 and not isNil(var_272_7) then
				local var_272_10 = (arg_269_1.time_ - var_272_8) / var_272_9

				if arg_269_1.var_.characterEffect10014ui_story and not isNil(var_272_7) then
					arg_269_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_8 + var_272_9 and arg_269_1.time_ < var_272_8 + var_272_9 + arg_272_0 and not isNil(var_272_7) and arg_269_1.var_.characterEffect10014ui_story then
				arg_269_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_272_11 = 0
			local var_272_12 = 0.5

			if var_272_11 < arg_269_1.time_ and arg_269_1.time_ <= var_272_11 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_13 = arg_269_1:FormatText(StoryNameCfg[264].name)

				arg_269_1.leftNameTxt_.text = var_272_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_14 = arg_269_1:GetWordFromCfg(121501066)
				local var_272_15 = arg_269_1:FormatText(var_272_14.content)

				arg_269_1.text_.text = var_272_15

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_16 = 20
				local var_272_17 = utf8.len(var_272_15)
				local var_272_18 = var_272_16 <= 0 and var_272_12 or var_272_12 * (var_272_17 / var_272_16)

				if var_272_18 > 0 and var_272_12 < var_272_18 then
					arg_269_1.talkMaxDuration = var_272_18

					if var_272_18 + var_272_11 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_18 + var_272_11
					end
				end

				arg_269_1.text_.text = var_272_15
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501066", "story_v_out_121501.awb") ~= 0 then
					local var_272_19 = manager.audio:GetVoiceLength("story_v_out_121501", "121501066", "story_v_out_121501.awb") / 1000

					if var_272_19 + var_272_11 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_19 + var_272_11
					end

					if var_272_14.prefab_name ~= "" and arg_269_1.actors_[var_272_14.prefab_name] ~= nil then
						local var_272_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_14.prefab_name].transform, "story_v_out_121501", "121501066", "story_v_out_121501.awb")

						arg_269_1:RecordAudio("121501066", var_272_20)
						arg_269_1:RecordAudio("121501066", var_272_20)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_121501", "121501066", "story_v_out_121501.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_121501", "121501066", "story_v_out_121501.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_21 = math.max(var_272_12, arg_269_1.talkMaxDuration)

			if var_272_11 <= arg_269_1.time_ and arg_269_1.time_ < var_272_11 + var_272_21 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_11) / var_272_21

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_11 + var_272_21 and arg_269_1.time_ < var_272_11 + var_272_21 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play121501067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 121501067
		arg_273_1.duration_ = 6.7

		local var_273_0 = {
			ja = 6.7,
			ko = 4.466,
			zh = 4.466
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play121501068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_276_1 = 0
			local var_276_2 = 0.6

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_3 = arg_273_1:FormatText(StoryNameCfg[264].name)

				arg_273_1.leftNameTxt_.text = var_276_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_4 = arg_273_1:GetWordFromCfg(121501067)
				local var_276_5 = arg_273_1:FormatText(var_276_4.content)

				arg_273_1.text_.text = var_276_5

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_6 = 24
				local var_276_7 = utf8.len(var_276_5)
				local var_276_8 = var_276_6 <= 0 and var_276_2 or var_276_2 * (var_276_7 / var_276_6)

				if var_276_8 > 0 and var_276_2 < var_276_8 then
					arg_273_1.talkMaxDuration = var_276_8

					if var_276_8 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_5
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501067", "story_v_out_121501.awb") ~= 0 then
					local var_276_9 = manager.audio:GetVoiceLength("story_v_out_121501", "121501067", "story_v_out_121501.awb") / 1000

					if var_276_9 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_1
					end

					if var_276_4.prefab_name ~= "" and arg_273_1.actors_[var_276_4.prefab_name] ~= nil then
						local var_276_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_4.prefab_name].transform, "story_v_out_121501", "121501067", "story_v_out_121501.awb")

						arg_273_1:RecordAudio("121501067", var_276_10)
						arg_273_1:RecordAudio("121501067", var_276_10)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_121501", "121501067", "story_v_out_121501.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_121501", "121501067", "story_v_out_121501.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_11 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_11 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_11

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_11 and arg_273_1.time_ < var_276_1 + var_276_11 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play121501068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 121501068
		arg_277_1.duration_ = 2.87

		local var_277_0 = {
			ja = 2.866,
			ko = 2.8,
			zh = 2.8
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play121501069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1029ui_story"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1029ui_story == nil then
				arg_277_1.var_.characterEffect1029ui_story = var_280_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.characterEffect1029ui_story and not isNil(var_280_0) then
					arg_277_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1029ui_story then
				arg_277_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_280_4 = 0

			if var_280_4 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action452")
			end

			local var_280_5 = 0

			if var_280_5 < arg_277_1.time_ and arg_277_1.time_ <= var_280_5 + arg_280_0 then
				arg_277_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_280_6 = arg_277_1.actors_["10014ui_story"]
			local var_280_7 = 0

			if var_280_7 < arg_277_1.time_ and arg_277_1.time_ <= var_280_7 + arg_280_0 and not isNil(var_280_6) and arg_277_1.var_.characterEffect10014ui_story == nil then
				arg_277_1.var_.characterEffect10014ui_story = var_280_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_8 = 0.200000002980232

			if var_280_7 <= arg_277_1.time_ and arg_277_1.time_ < var_280_7 + var_280_8 and not isNil(var_280_6) then
				local var_280_9 = (arg_277_1.time_ - var_280_7) / var_280_8

				if arg_277_1.var_.characterEffect10014ui_story and not isNil(var_280_6) then
					local var_280_10 = Mathf.Lerp(0, 0.5, var_280_9)

					arg_277_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_277_1.var_.characterEffect10014ui_story.fillRatio = var_280_10
				end
			end

			if arg_277_1.time_ >= var_280_7 + var_280_8 and arg_277_1.time_ < var_280_7 + var_280_8 + arg_280_0 and not isNil(var_280_6) and arg_277_1.var_.characterEffect10014ui_story then
				local var_280_11 = 0.5

				arg_277_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_277_1.var_.characterEffect10014ui_story.fillRatio = var_280_11
			end

			local var_280_12 = 0
			local var_280_13 = 0.35

			if var_280_12 < arg_277_1.time_ and arg_277_1.time_ <= var_280_12 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_14 = arg_277_1:FormatText(StoryNameCfg[319].name)

				arg_277_1.leftNameTxt_.text = var_280_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_15 = arg_277_1:GetWordFromCfg(121501068)
				local var_280_16 = arg_277_1:FormatText(var_280_15.content)

				arg_277_1.text_.text = var_280_16

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_17 = 14
				local var_280_18 = utf8.len(var_280_16)
				local var_280_19 = var_280_17 <= 0 and var_280_13 or var_280_13 * (var_280_18 / var_280_17)

				if var_280_19 > 0 and var_280_13 < var_280_19 then
					arg_277_1.talkMaxDuration = var_280_19

					if var_280_19 + var_280_12 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_19 + var_280_12
					end
				end

				arg_277_1.text_.text = var_280_16
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501068", "story_v_out_121501.awb") ~= 0 then
					local var_280_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501068", "story_v_out_121501.awb") / 1000

					if var_280_20 + var_280_12 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_20 + var_280_12
					end

					if var_280_15.prefab_name ~= "" and arg_277_1.actors_[var_280_15.prefab_name] ~= nil then
						local var_280_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_15.prefab_name].transform, "story_v_out_121501", "121501068", "story_v_out_121501.awb")

						arg_277_1:RecordAudio("121501068", var_280_21)
						arg_277_1:RecordAudio("121501068", var_280_21)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_121501", "121501068", "story_v_out_121501.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_121501", "121501068", "story_v_out_121501.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_22 = math.max(var_280_13, arg_277_1.talkMaxDuration)

			if var_280_12 <= arg_277_1.time_ and arg_277_1.time_ < var_280_12 + var_280_22 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_12) / var_280_22

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_12 + var_280_22 and arg_277_1.time_ < var_280_12 + var_280_22 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play121501069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 121501069
		arg_281_1.duration_ = 17.2

		local var_281_0 = {
			ja = 17.2,
			ko = 9.366,
			zh = 9.366
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play121501070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_284_1 = arg_281_1.actors_["1029ui_story"]
			local var_284_2 = 0

			if var_284_2 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1029ui_story == nil then
				arg_281_1.var_.characterEffect1029ui_story = var_284_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_3 = 0.200000002980232

			if var_284_2 <= arg_281_1.time_ and arg_281_1.time_ < var_284_2 + var_284_3 and not isNil(var_284_1) then
				local var_284_4 = (arg_281_1.time_ - var_284_2) / var_284_3

				if arg_281_1.var_.characterEffect1029ui_story and not isNil(var_284_1) then
					local var_284_5 = Mathf.Lerp(0, 0.5, var_284_4)

					arg_281_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1029ui_story.fillRatio = var_284_5
				end
			end

			if arg_281_1.time_ >= var_284_2 + var_284_3 and arg_281_1.time_ < var_284_2 + var_284_3 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1029ui_story then
				local var_284_6 = 0.5

				arg_281_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1029ui_story.fillRatio = var_284_6
			end

			local var_284_7 = arg_281_1.actors_["10014ui_story"]
			local var_284_8 = 0

			if var_284_8 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 and not isNil(var_284_7) and arg_281_1.var_.characterEffect10014ui_story == nil then
				arg_281_1.var_.characterEffect10014ui_story = var_284_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_9 = 0.200000002980232

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_9 and not isNil(var_284_7) then
				local var_284_10 = (arg_281_1.time_ - var_284_8) / var_284_9

				if arg_281_1.var_.characterEffect10014ui_story and not isNil(var_284_7) then
					arg_281_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_8 + var_284_9 and arg_281_1.time_ < var_284_8 + var_284_9 + arg_284_0 and not isNil(var_284_7) and arg_281_1.var_.characterEffect10014ui_story then
				arg_281_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_284_11 = 0
			local var_284_12 = 1.025

			if var_284_11 < arg_281_1.time_ and arg_281_1.time_ <= var_284_11 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_13 = arg_281_1:FormatText(StoryNameCfg[264].name)

				arg_281_1.leftNameTxt_.text = var_284_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_14 = arg_281_1:GetWordFromCfg(121501069)
				local var_284_15 = arg_281_1:FormatText(var_284_14.content)

				arg_281_1.text_.text = var_284_15

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_16 = 40
				local var_284_17 = utf8.len(var_284_15)
				local var_284_18 = var_284_16 <= 0 and var_284_12 or var_284_12 * (var_284_17 / var_284_16)

				if var_284_18 > 0 and var_284_12 < var_284_18 then
					arg_281_1.talkMaxDuration = var_284_18

					if var_284_18 + var_284_11 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_18 + var_284_11
					end
				end

				arg_281_1.text_.text = var_284_15
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501069", "story_v_out_121501.awb") ~= 0 then
					local var_284_19 = manager.audio:GetVoiceLength("story_v_out_121501", "121501069", "story_v_out_121501.awb") / 1000

					if var_284_19 + var_284_11 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_19 + var_284_11
					end

					if var_284_14.prefab_name ~= "" and arg_281_1.actors_[var_284_14.prefab_name] ~= nil then
						local var_284_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_14.prefab_name].transform, "story_v_out_121501", "121501069", "story_v_out_121501.awb")

						arg_281_1:RecordAudio("121501069", var_284_20)
						arg_281_1:RecordAudio("121501069", var_284_20)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_121501", "121501069", "story_v_out_121501.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_121501", "121501069", "story_v_out_121501.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_21 = math.max(var_284_12, arg_281_1.talkMaxDuration)

			if var_284_11 <= arg_281_1.time_ and arg_281_1.time_ < var_284_11 + var_284_21 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_11) / var_284_21

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_11 + var_284_21 and arg_281_1.time_ < var_284_11 + var_284_21 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play121501070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 121501070
		arg_285_1.duration_ = 14

		local var_285_0 = {
			ja = 14,
			ko = 7.633,
			zh = 7.633
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play121501071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.925

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_2 = arg_285_1:FormatText(StoryNameCfg[264].name)

				arg_285_1.leftNameTxt_.text = var_288_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_3 = arg_285_1:GetWordFromCfg(121501070)
				local var_288_4 = arg_285_1:FormatText(var_288_3.content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 37
				local var_288_6 = utf8.len(var_288_4)
				local var_288_7 = var_288_5 <= 0 and var_288_1 or var_288_1 * (var_288_6 / var_288_5)

				if var_288_7 > 0 and var_288_1 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501070", "story_v_out_121501.awb") ~= 0 then
					local var_288_8 = manager.audio:GetVoiceLength("story_v_out_121501", "121501070", "story_v_out_121501.awb") / 1000

					if var_288_8 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_0
					end

					if var_288_3.prefab_name ~= "" and arg_285_1.actors_[var_288_3.prefab_name] ~= nil then
						local var_288_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_3.prefab_name].transform, "story_v_out_121501", "121501070", "story_v_out_121501.awb")

						arg_285_1:RecordAudio("121501070", var_288_9)
						arg_285_1:RecordAudio("121501070", var_288_9)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_121501", "121501070", "story_v_out_121501.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_121501", "121501070", "story_v_out_121501.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_10 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_10 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_10

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_10 and arg_285_1.time_ < var_288_0 + var_288_10 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play121501071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 121501071
		arg_289_1.duration_ = 2.23

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play121501072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action2_2")
			end

			local var_292_1 = arg_289_1.actors_["1029ui_story"]
			local var_292_2 = 0

			if var_292_2 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1029ui_story == nil then
				arg_289_1.var_.characterEffect1029ui_story = var_292_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_3 = 0.200000002980232

			if var_292_2 <= arg_289_1.time_ and arg_289_1.time_ < var_292_2 + var_292_3 and not isNil(var_292_1) then
				local var_292_4 = (arg_289_1.time_ - var_292_2) / var_292_3

				if arg_289_1.var_.characterEffect1029ui_story and not isNil(var_292_1) then
					arg_289_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_2 + var_292_3 and arg_289_1.time_ < var_292_2 + var_292_3 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1029ui_story then
				arg_289_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_292_5 = arg_289_1.actors_["10014ui_story"]
			local var_292_6 = 0

			if var_292_6 < arg_289_1.time_ and arg_289_1.time_ <= var_292_6 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.characterEffect10014ui_story == nil then
				arg_289_1.var_.characterEffect10014ui_story = var_292_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_7 = 0.200000002980232

			if var_292_6 <= arg_289_1.time_ and arg_289_1.time_ < var_292_6 + var_292_7 and not isNil(var_292_5) then
				local var_292_8 = (arg_289_1.time_ - var_292_6) / var_292_7

				if arg_289_1.var_.characterEffect10014ui_story and not isNil(var_292_5) then
					local var_292_9 = Mathf.Lerp(0, 0.5, var_292_8)

					arg_289_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_289_1.var_.characterEffect10014ui_story.fillRatio = var_292_9
				end
			end

			if arg_289_1.time_ >= var_292_6 + var_292_7 and arg_289_1.time_ < var_292_6 + var_292_7 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.characterEffect10014ui_story then
				local var_292_10 = 0.5

				arg_289_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_289_1.var_.characterEffect10014ui_story.fillRatio = var_292_10
			end

			local var_292_11 = 0
			local var_292_12 = 0.225

			if var_292_11 < arg_289_1.time_ and arg_289_1.time_ <= var_292_11 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_13 = arg_289_1:FormatText(StoryNameCfg[319].name)

				arg_289_1.leftNameTxt_.text = var_292_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_14 = arg_289_1:GetWordFromCfg(121501071)
				local var_292_15 = arg_289_1:FormatText(var_292_14.content)

				arg_289_1.text_.text = var_292_15

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_16 = 9
				local var_292_17 = utf8.len(var_292_15)
				local var_292_18 = var_292_16 <= 0 and var_292_12 or var_292_12 * (var_292_17 / var_292_16)

				if var_292_18 > 0 and var_292_12 < var_292_18 then
					arg_289_1.talkMaxDuration = var_292_18

					if var_292_18 + var_292_11 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_18 + var_292_11
					end
				end

				arg_289_1.text_.text = var_292_15
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501071", "story_v_out_121501.awb") ~= 0 then
					local var_292_19 = manager.audio:GetVoiceLength("story_v_out_121501", "121501071", "story_v_out_121501.awb") / 1000

					if var_292_19 + var_292_11 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_19 + var_292_11
					end

					if var_292_14.prefab_name ~= "" and arg_289_1.actors_[var_292_14.prefab_name] ~= nil then
						local var_292_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_14.prefab_name].transform, "story_v_out_121501", "121501071", "story_v_out_121501.awb")

						arg_289_1:RecordAudio("121501071", var_292_20)
						arg_289_1:RecordAudio("121501071", var_292_20)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_121501", "121501071", "story_v_out_121501.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_121501", "121501071", "story_v_out_121501.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_21 = math.max(var_292_12, arg_289_1.talkMaxDuration)

			if var_292_11 <= arg_289_1.time_ and arg_289_1.time_ < var_292_11 + var_292_21 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_11) / var_292_21

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_11 + var_292_21 and arg_289_1.time_ < var_292_11 + var_292_21 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play121501072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 121501072
		arg_293_1.duration_ = 1.3

		local var_293_0 = {
			ja = 1.3,
			ko = 0.999999999999,
			zh = 0.999999999999
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
				arg_293_0:Play121501073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1029ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1029ui_story == nil then
				arg_293_1.var_.characterEffect1029ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect1029ui_story and not isNil(var_296_0) then
					local var_296_4 = Mathf.Lerp(0, 0.5, var_296_3)

					arg_293_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1029ui_story.fillRatio = var_296_4
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1029ui_story then
				local var_296_5 = 0.5

				arg_293_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1029ui_story.fillRatio = var_296_5
			end

			local var_296_6 = arg_293_1.actors_["10014ui_story"]
			local var_296_7 = 0

			if var_296_7 < arg_293_1.time_ and arg_293_1.time_ <= var_296_7 + arg_296_0 and not isNil(var_296_6) and arg_293_1.var_.characterEffect10014ui_story == nil then
				arg_293_1.var_.characterEffect10014ui_story = var_296_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_8 = 0.200000002980232

			if var_296_7 <= arg_293_1.time_ and arg_293_1.time_ < var_296_7 + var_296_8 and not isNil(var_296_6) then
				local var_296_9 = (arg_293_1.time_ - var_296_7) / var_296_8

				if arg_293_1.var_.characterEffect10014ui_story and not isNil(var_296_6) then
					arg_293_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_7 + var_296_8 and arg_293_1.time_ < var_296_7 + var_296_8 + arg_296_0 and not isNil(var_296_6) and arg_293_1.var_.characterEffect10014ui_story then
				arg_293_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_296_10 = 0
			local var_296_11 = 0.125

			if var_296_10 < arg_293_1.time_ and arg_293_1.time_ <= var_296_10 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_12 = arg_293_1:FormatText(StoryNameCfg[264].name)

				arg_293_1.leftNameTxt_.text = var_296_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_13 = arg_293_1:GetWordFromCfg(121501072)
				local var_296_14 = arg_293_1:FormatText(var_296_13.content)

				arg_293_1.text_.text = var_296_14

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_15 = 5
				local var_296_16 = utf8.len(var_296_14)
				local var_296_17 = var_296_15 <= 0 and var_296_11 or var_296_11 * (var_296_16 / var_296_15)

				if var_296_17 > 0 and var_296_11 < var_296_17 then
					arg_293_1.talkMaxDuration = var_296_17

					if var_296_17 + var_296_10 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_17 + var_296_10
					end
				end

				arg_293_1.text_.text = var_296_14
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501072", "story_v_out_121501.awb") ~= 0 then
					local var_296_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501072", "story_v_out_121501.awb") / 1000

					if var_296_18 + var_296_10 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_18 + var_296_10
					end

					if var_296_13.prefab_name ~= "" and arg_293_1.actors_[var_296_13.prefab_name] ~= nil then
						local var_296_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_13.prefab_name].transform, "story_v_out_121501", "121501072", "story_v_out_121501.awb")

						arg_293_1:RecordAudio("121501072", var_296_19)
						arg_293_1:RecordAudio("121501072", var_296_19)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_121501", "121501072", "story_v_out_121501.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_121501", "121501072", "story_v_out_121501.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_20 = math.max(var_296_11, arg_293_1.talkMaxDuration)

			if var_296_10 <= arg_293_1.time_ and arg_293_1.time_ < var_296_10 + var_296_20 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_10) / var_296_20

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_10 + var_296_20 and arg_293_1.time_ < var_296_10 + var_296_20 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play121501073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 121501073
		arg_297_1.duration_ = 2.03

		local var_297_0 = {
			ja = 2.033,
			ko = 1.766,
			zh = 1.766
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play121501074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1029ui_story"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1029ui_story == nil then
				arg_297_1.var_.characterEffect1029ui_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.characterEffect1029ui_story and not isNil(var_300_0) then
					arg_297_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1029ui_story then
				arg_297_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_300_4 = arg_297_1.actors_["10014ui_story"]
			local var_300_5 = 0

			if var_300_5 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 and not isNil(var_300_4) and arg_297_1.var_.characterEffect10014ui_story == nil then
				arg_297_1.var_.characterEffect10014ui_story = var_300_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_6 = 0.200000002980232

			if var_300_5 <= arg_297_1.time_ and arg_297_1.time_ < var_300_5 + var_300_6 and not isNil(var_300_4) then
				local var_300_7 = (arg_297_1.time_ - var_300_5) / var_300_6

				if arg_297_1.var_.characterEffect10014ui_story and not isNil(var_300_4) then
					local var_300_8 = Mathf.Lerp(0, 0.5, var_300_7)

					arg_297_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_297_1.var_.characterEffect10014ui_story.fillRatio = var_300_8
				end
			end

			if arg_297_1.time_ >= var_300_5 + var_300_6 and arg_297_1.time_ < var_300_5 + var_300_6 + arg_300_0 and not isNil(var_300_4) and arg_297_1.var_.characterEffect10014ui_story then
				local var_300_9 = 0.5

				arg_297_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_297_1.var_.characterEffect10014ui_story.fillRatio = var_300_9
			end

			local var_300_10 = 0
			local var_300_11 = 0.175

			if var_300_10 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_12 = arg_297_1:FormatText(StoryNameCfg[319].name)

				arg_297_1.leftNameTxt_.text = var_300_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_13 = arg_297_1:GetWordFromCfg(121501073)
				local var_300_14 = arg_297_1:FormatText(var_300_13.content)

				arg_297_1.text_.text = var_300_14

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_15 = 7
				local var_300_16 = utf8.len(var_300_14)
				local var_300_17 = var_300_15 <= 0 and var_300_11 or var_300_11 * (var_300_16 / var_300_15)

				if var_300_17 > 0 and var_300_11 < var_300_17 then
					arg_297_1.talkMaxDuration = var_300_17

					if var_300_17 + var_300_10 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_17 + var_300_10
					end
				end

				arg_297_1.text_.text = var_300_14
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501073", "story_v_out_121501.awb") ~= 0 then
					local var_300_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501073", "story_v_out_121501.awb") / 1000

					if var_300_18 + var_300_10 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_18 + var_300_10
					end

					if var_300_13.prefab_name ~= "" and arg_297_1.actors_[var_300_13.prefab_name] ~= nil then
						local var_300_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_13.prefab_name].transform, "story_v_out_121501", "121501073", "story_v_out_121501.awb")

						arg_297_1:RecordAudio("121501073", var_300_19)
						arg_297_1:RecordAudio("121501073", var_300_19)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_121501", "121501073", "story_v_out_121501.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_121501", "121501073", "story_v_out_121501.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_20 = math.max(var_300_11, arg_297_1.talkMaxDuration)

			if var_300_10 <= arg_297_1.time_ and arg_297_1.time_ < var_300_10 + var_300_20 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_10) / var_300_20

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_10 + var_300_20 and arg_297_1.time_ < var_300_10 + var_300_20 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play121501074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 121501074
		arg_301_1.duration_ = 6.7

		local var_301_0 = {
			ja = 4.666,
			ko = 6.7,
			zh = 6.7
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
				arg_301_0:Play121501075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 0.775

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[319].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_3 = arg_301_1:GetWordFromCfg(121501074)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501074", "story_v_out_121501.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_out_121501", "121501074", "story_v_out_121501.awb") / 1000

					if var_304_8 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_0
					end

					if var_304_3.prefab_name ~= "" and arg_301_1.actors_[var_304_3.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_3.prefab_name].transform, "story_v_out_121501", "121501074", "story_v_out_121501.awb")

						arg_301_1:RecordAudio("121501074", var_304_9)
						arg_301_1:RecordAudio("121501074", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_121501", "121501074", "story_v_out_121501.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_121501", "121501074", "story_v_out_121501.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_10 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_10 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_10

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_10 and arg_301_1.time_ < var_304_0 + var_304_10 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play121501075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 121501075
		arg_305_1.duration_ = 4.47

		local var_305_0 = {
			ja = 3.433,
			ko = 4.466,
			zh = 4.466
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
				arg_305_0:Play121501076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014actionlink/10014action424")
			end

			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_308_2 = arg_305_1.actors_["1029ui_story"]
			local var_308_3 = 0

			if var_308_3 < arg_305_1.time_ and arg_305_1.time_ <= var_308_3 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.characterEffect1029ui_story == nil then
				arg_305_1.var_.characterEffect1029ui_story = var_308_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_4 = 0.200000002980232

			if var_308_3 <= arg_305_1.time_ and arg_305_1.time_ < var_308_3 + var_308_4 and not isNil(var_308_2) then
				local var_308_5 = (arg_305_1.time_ - var_308_3) / var_308_4

				if arg_305_1.var_.characterEffect1029ui_story and not isNil(var_308_2) then
					local var_308_6 = Mathf.Lerp(0, 0.5, var_308_5)

					arg_305_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1029ui_story.fillRatio = var_308_6
				end
			end

			if arg_305_1.time_ >= var_308_3 + var_308_4 and arg_305_1.time_ < var_308_3 + var_308_4 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.characterEffect1029ui_story then
				local var_308_7 = 0.5

				arg_305_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1029ui_story.fillRatio = var_308_7
			end

			local var_308_8 = arg_305_1.actors_["10014ui_story"]
			local var_308_9 = 0

			if var_308_9 < arg_305_1.time_ and arg_305_1.time_ <= var_308_9 + arg_308_0 and not isNil(var_308_8) and arg_305_1.var_.characterEffect10014ui_story == nil then
				arg_305_1.var_.characterEffect10014ui_story = var_308_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_10 = 0.200000002980232

			if var_308_9 <= arg_305_1.time_ and arg_305_1.time_ < var_308_9 + var_308_10 and not isNil(var_308_8) then
				local var_308_11 = (arg_305_1.time_ - var_308_9) / var_308_10

				if arg_305_1.var_.characterEffect10014ui_story and not isNil(var_308_8) then
					arg_305_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= var_308_9 + var_308_10 and arg_305_1.time_ < var_308_9 + var_308_10 + arg_308_0 and not isNil(var_308_8) and arg_305_1.var_.characterEffect10014ui_story then
				arg_305_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_308_12 = 0
			local var_308_13 = 0.5

			if var_308_12 < arg_305_1.time_ and arg_305_1.time_ <= var_308_12 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_14 = arg_305_1:FormatText(StoryNameCfg[264].name)

				arg_305_1.leftNameTxt_.text = var_308_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_15 = arg_305_1:GetWordFromCfg(121501075)
				local var_308_16 = arg_305_1:FormatText(var_308_15.content)

				arg_305_1.text_.text = var_308_16

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_17 = 20
				local var_308_18 = utf8.len(var_308_16)
				local var_308_19 = var_308_17 <= 0 and var_308_13 or var_308_13 * (var_308_18 / var_308_17)

				if var_308_19 > 0 and var_308_13 < var_308_19 then
					arg_305_1.talkMaxDuration = var_308_19

					if var_308_19 + var_308_12 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_19 + var_308_12
					end
				end

				arg_305_1.text_.text = var_308_16
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501075", "story_v_out_121501.awb") ~= 0 then
					local var_308_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501075", "story_v_out_121501.awb") / 1000

					if var_308_20 + var_308_12 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_20 + var_308_12
					end

					if var_308_15.prefab_name ~= "" and arg_305_1.actors_[var_308_15.prefab_name] ~= nil then
						local var_308_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_15.prefab_name].transform, "story_v_out_121501", "121501075", "story_v_out_121501.awb")

						arg_305_1:RecordAudio("121501075", var_308_21)
						arg_305_1:RecordAudio("121501075", var_308_21)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_121501", "121501075", "story_v_out_121501.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_121501", "121501075", "story_v_out_121501.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_22 = math.max(var_308_13, arg_305_1.talkMaxDuration)

			if var_308_12 <= arg_305_1.time_ and arg_305_1.time_ < var_308_12 + var_308_22 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_12) / var_308_22

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_12 + var_308_22 and arg_305_1.time_ < var_308_12 + var_308_22 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play121501076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 121501076
		arg_309_1.duration_ = 5.1

		local var_309_0 = {
			ja = 5.1,
			ko = 4.366,
			zh = 4.366
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
				arg_309_0:Play121501077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1029ui_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1029ui_story == nil then
				arg_309_1.var_.characterEffect1029ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect1029ui_story and not isNil(var_312_0) then
					arg_309_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1029ui_story then
				arg_309_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_312_4 = 0

			if var_312_4 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_312_5 = 0

			if var_312_5 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 then
				arg_309_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_312_6 = arg_309_1.actors_["10014ui_story"]
			local var_312_7 = 0

			if var_312_7 < arg_309_1.time_ and arg_309_1.time_ <= var_312_7 + arg_312_0 and not isNil(var_312_6) and arg_309_1.var_.characterEffect10014ui_story == nil then
				arg_309_1.var_.characterEffect10014ui_story = var_312_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_8 = 0.200000002980232

			if var_312_7 <= arg_309_1.time_ and arg_309_1.time_ < var_312_7 + var_312_8 and not isNil(var_312_6) then
				local var_312_9 = (arg_309_1.time_ - var_312_7) / var_312_8

				if arg_309_1.var_.characterEffect10014ui_story and not isNil(var_312_6) then
					local var_312_10 = Mathf.Lerp(0, 0.5, var_312_9)

					arg_309_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_309_1.var_.characterEffect10014ui_story.fillRatio = var_312_10
				end
			end

			if arg_309_1.time_ >= var_312_7 + var_312_8 and arg_309_1.time_ < var_312_7 + var_312_8 + arg_312_0 and not isNil(var_312_6) and arg_309_1.var_.characterEffect10014ui_story then
				local var_312_11 = 0.5

				arg_309_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_309_1.var_.characterEffect10014ui_story.fillRatio = var_312_11
			end

			local var_312_12 = 0
			local var_312_13 = 0.425

			if var_312_12 < arg_309_1.time_ and arg_309_1.time_ <= var_312_12 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_14 = arg_309_1:FormatText(StoryNameCfg[319].name)

				arg_309_1.leftNameTxt_.text = var_312_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_15 = arg_309_1:GetWordFromCfg(121501076)
				local var_312_16 = arg_309_1:FormatText(var_312_15.content)

				arg_309_1.text_.text = var_312_16

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_17 = 17
				local var_312_18 = utf8.len(var_312_16)
				local var_312_19 = var_312_17 <= 0 and var_312_13 or var_312_13 * (var_312_18 / var_312_17)

				if var_312_19 > 0 and var_312_13 < var_312_19 then
					arg_309_1.talkMaxDuration = var_312_19

					if var_312_19 + var_312_12 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_19 + var_312_12
					end
				end

				arg_309_1.text_.text = var_312_16
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501076", "story_v_out_121501.awb") ~= 0 then
					local var_312_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501076", "story_v_out_121501.awb") / 1000

					if var_312_20 + var_312_12 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_20 + var_312_12
					end

					if var_312_15.prefab_name ~= "" and arg_309_1.actors_[var_312_15.prefab_name] ~= nil then
						local var_312_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_15.prefab_name].transform, "story_v_out_121501", "121501076", "story_v_out_121501.awb")

						arg_309_1:RecordAudio("121501076", var_312_21)
						arg_309_1:RecordAudio("121501076", var_312_21)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_121501", "121501076", "story_v_out_121501.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_121501", "121501076", "story_v_out_121501.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_22 = math.max(var_312_13, arg_309_1.talkMaxDuration)

			if var_312_12 <= arg_309_1.time_ and arg_309_1.time_ < var_312_12 + var_312_22 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_12) / var_312_22

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_12 + var_312_22 and arg_309_1.time_ < var_312_12 + var_312_22 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play121501077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 121501077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play121501078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1029ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1029ui_story == nil then
				arg_313_1.var_.characterEffect1029ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect1029ui_story and not isNil(var_316_0) then
					local var_316_4 = Mathf.Lerp(0, 0.5, var_316_3)

					arg_313_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1029ui_story.fillRatio = var_316_4
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1029ui_story then
				local var_316_5 = 0.5

				arg_313_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1029ui_story.fillRatio = var_316_5
			end

			local var_316_6 = 0
			local var_316_7 = 0.875

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_8 = arg_313_1:GetWordFromCfg(121501077)
				local var_316_9 = arg_313_1:FormatText(var_316_8.content)

				arg_313_1.text_.text = var_316_9

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_10 = 35
				local var_316_11 = utf8.len(var_316_9)
				local var_316_12 = var_316_10 <= 0 and var_316_7 or var_316_7 * (var_316_11 / var_316_10)

				if var_316_12 > 0 and var_316_7 < var_316_12 then
					arg_313_1.talkMaxDuration = var_316_12

					if var_316_12 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_12 + var_316_6
					end
				end

				arg_313_1.text_.text = var_316_9
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_13 = math.max(var_316_7, arg_313_1.talkMaxDuration)

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_13 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_6) / var_316_13

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_6 + var_316_13 and arg_313_1.time_ < var_316_6 + var_316_13 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play121501078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 121501078
		arg_317_1.duration_ = 10.27

		local var_317_0 = {
			ja = 10.266,
			ko = 3.5,
			zh = 3.5
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play121501079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action4_2")
			end

			local var_320_1 = arg_317_1.actors_["1029ui_story"]
			local var_320_2 = 0

			if var_320_2 < arg_317_1.time_ and arg_317_1.time_ <= var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1029ui_story == nil then
				arg_317_1.var_.characterEffect1029ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_3 = 0.200000002980232

			if var_320_2 <= arg_317_1.time_ and arg_317_1.time_ < var_320_2 + var_320_3 and not isNil(var_320_1) then
				local var_320_4 = (arg_317_1.time_ - var_320_2) / var_320_3

				if arg_317_1.var_.characterEffect1029ui_story and not isNil(var_320_1) then
					local var_320_5 = Mathf.Lerp(0, 0.5, var_320_4)

					arg_317_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1029ui_story.fillRatio = var_320_5
				end
			end

			if arg_317_1.time_ >= var_320_2 + var_320_3 and arg_317_1.time_ < var_320_2 + var_320_3 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1029ui_story then
				local var_320_6 = 0.5

				arg_317_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1029ui_story.fillRatio = var_320_6
			end

			local var_320_7 = arg_317_1.actors_["10014ui_story"]
			local var_320_8 = 0

			if var_320_8 < arg_317_1.time_ and arg_317_1.time_ <= var_320_8 + arg_320_0 and not isNil(var_320_7) and arg_317_1.var_.characterEffect10014ui_story == nil then
				arg_317_1.var_.characterEffect10014ui_story = var_320_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_9 = 0.200000002980232

			if var_320_8 <= arg_317_1.time_ and arg_317_1.time_ < var_320_8 + var_320_9 and not isNil(var_320_7) then
				local var_320_10 = (arg_317_1.time_ - var_320_8) / var_320_9

				if arg_317_1.var_.characterEffect10014ui_story and not isNil(var_320_7) then
					arg_317_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_8 + var_320_9 and arg_317_1.time_ < var_320_8 + var_320_9 + arg_320_0 and not isNil(var_320_7) and arg_317_1.var_.characterEffect10014ui_story then
				arg_317_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_320_11 = 0
			local var_320_12 = 0.45

			if var_320_11 < arg_317_1.time_ and arg_317_1.time_ <= var_320_11 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_13 = arg_317_1:FormatText(StoryNameCfg[264].name)

				arg_317_1.leftNameTxt_.text = var_320_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_14 = arg_317_1:GetWordFromCfg(121501078)
				local var_320_15 = arg_317_1:FormatText(var_320_14.content)

				arg_317_1.text_.text = var_320_15

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_16 = 18
				local var_320_17 = utf8.len(var_320_15)
				local var_320_18 = var_320_16 <= 0 and var_320_12 or var_320_12 * (var_320_17 / var_320_16)

				if var_320_18 > 0 and var_320_12 < var_320_18 then
					arg_317_1.talkMaxDuration = var_320_18

					if var_320_18 + var_320_11 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_18 + var_320_11
					end
				end

				arg_317_1.text_.text = var_320_15
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501078", "story_v_out_121501.awb") ~= 0 then
					local var_320_19 = manager.audio:GetVoiceLength("story_v_out_121501", "121501078", "story_v_out_121501.awb") / 1000

					if var_320_19 + var_320_11 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_19 + var_320_11
					end

					if var_320_14.prefab_name ~= "" and arg_317_1.actors_[var_320_14.prefab_name] ~= nil then
						local var_320_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_14.prefab_name].transform, "story_v_out_121501", "121501078", "story_v_out_121501.awb")

						arg_317_1:RecordAudio("121501078", var_320_20)
						arg_317_1:RecordAudio("121501078", var_320_20)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_121501", "121501078", "story_v_out_121501.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_121501", "121501078", "story_v_out_121501.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_21 = math.max(var_320_12, arg_317_1.talkMaxDuration)

			if var_320_11 <= arg_317_1.time_ and arg_317_1.time_ < var_320_11 + var_320_21 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_11) / var_320_21

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_11 + var_320_21 and arg_317_1.time_ < var_320_11 + var_320_21 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play121501079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 121501079
		arg_321_1.duration_ = 9.03

		local var_321_0 = {
			ja = 9.033,
			ko = 6.6,
			zh = 6.6
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play121501080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 0.825

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_2 = arg_321_1:FormatText(StoryNameCfg[264].name)

				arg_321_1.leftNameTxt_.text = var_324_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_3 = arg_321_1:GetWordFromCfg(121501079)
				local var_324_4 = arg_321_1:FormatText(var_324_3.content)

				arg_321_1.text_.text = var_324_4

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 33
				local var_324_6 = utf8.len(var_324_4)
				local var_324_7 = var_324_5 <= 0 and var_324_1 or var_324_1 * (var_324_6 / var_324_5)

				if var_324_7 > 0 and var_324_1 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_4
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501079", "story_v_out_121501.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_out_121501", "121501079", "story_v_out_121501.awb") / 1000

					if var_324_8 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_0
					end

					if var_324_3.prefab_name ~= "" and arg_321_1.actors_[var_324_3.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_3.prefab_name].transform, "story_v_out_121501", "121501079", "story_v_out_121501.awb")

						arg_321_1:RecordAudio("121501079", var_324_9)
						arg_321_1:RecordAudio("121501079", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_121501", "121501079", "story_v_out_121501.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_121501", "121501079", "story_v_out_121501.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_10 and arg_321_1.time_ < var_324_0 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play121501080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 121501080
		arg_325_1.duration_ = 3.9

		local var_325_0 = {
			ja = 3.9,
			ko = 1.833,
			zh = 1.833
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
				arg_325_0:Play121501081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1029ui_story"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1029ui_story == nil then
				arg_325_1.var_.characterEffect1029ui_story = var_328_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.characterEffect1029ui_story and not isNil(var_328_0) then
					arg_325_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1029ui_story then
				arg_325_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_328_4 = arg_325_1.actors_["10014ui_story"]
			local var_328_5 = 0

			if var_328_5 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 and not isNil(var_328_4) and arg_325_1.var_.characterEffect10014ui_story == nil then
				arg_325_1.var_.characterEffect10014ui_story = var_328_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_6 = 0.200000002980232

			if var_328_5 <= arg_325_1.time_ and arg_325_1.time_ < var_328_5 + var_328_6 and not isNil(var_328_4) then
				local var_328_7 = (arg_325_1.time_ - var_328_5) / var_328_6

				if arg_325_1.var_.characterEffect10014ui_story and not isNil(var_328_4) then
					local var_328_8 = Mathf.Lerp(0, 0.5, var_328_7)

					arg_325_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_325_1.var_.characterEffect10014ui_story.fillRatio = var_328_8
				end
			end

			if arg_325_1.time_ >= var_328_5 + var_328_6 and arg_325_1.time_ < var_328_5 + var_328_6 + arg_328_0 and not isNil(var_328_4) and arg_325_1.var_.characterEffect10014ui_story then
				local var_328_9 = 0.5

				arg_325_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_325_1.var_.characterEffect10014ui_story.fillRatio = var_328_9
			end

			local var_328_10 = 0
			local var_328_11 = 0.2

			if var_328_10 < arg_325_1.time_ and arg_325_1.time_ <= var_328_10 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_12 = arg_325_1:FormatText(StoryNameCfg[319].name)

				arg_325_1.leftNameTxt_.text = var_328_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_13 = arg_325_1:GetWordFromCfg(121501080)
				local var_328_14 = arg_325_1:FormatText(var_328_13.content)

				arg_325_1.text_.text = var_328_14

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_15 = 8
				local var_328_16 = utf8.len(var_328_14)
				local var_328_17 = var_328_15 <= 0 and var_328_11 or var_328_11 * (var_328_16 / var_328_15)

				if var_328_17 > 0 and var_328_11 < var_328_17 then
					arg_325_1.talkMaxDuration = var_328_17

					if var_328_17 + var_328_10 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_17 + var_328_10
					end
				end

				arg_325_1.text_.text = var_328_14
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501080", "story_v_out_121501.awb") ~= 0 then
					local var_328_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501080", "story_v_out_121501.awb") / 1000

					if var_328_18 + var_328_10 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_18 + var_328_10
					end

					if var_328_13.prefab_name ~= "" and arg_325_1.actors_[var_328_13.prefab_name] ~= nil then
						local var_328_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_13.prefab_name].transform, "story_v_out_121501", "121501080", "story_v_out_121501.awb")

						arg_325_1:RecordAudio("121501080", var_328_19)
						arg_325_1:RecordAudio("121501080", var_328_19)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_121501", "121501080", "story_v_out_121501.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_121501", "121501080", "story_v_out_121501.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_20 = math.max(var_328_11, arg_325_1.talkMaxDuration)

			if var_328_10 <= arg_325_1.time_ and arg_325_1.time_ < var_328_10 + var_328_20 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_10) / var_328_20

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_10 + var_328_20 and arg_325_1.time_ < var_328_10 + var_328_20 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play121501081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 121501081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play121501082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1029ui_story"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1029ui_story == nil then
				arg_329_1.var_.characterEffect1029ui_story = var_332_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.characterEffect1029ui_story and not isNil(var_332_0) then
					local var_332_4 = Mathf.Lerp(0, 0.5, var_332_3)

					arg_329_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1029ui_story.fillRatio = var_332_4
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1029ui_story then
				local var_332_5 = 0.5

				arg_329_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1029ui_story.fillRatio = var_332_5
			end

			local var_332_6 = 0
			local var_332_7 = 1.2

			if var_332_6 < arg_329_1.time_ and arg_329_1.time_ <= var_332_6 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_8 = arg_329_1:GetWordFromCfg(121501081)
				local var_332_9 = arg_329_1:FormatText(var_332_8.content)

				arg_329_1.text_.text = var_332_9

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_10 = 48
				local var_332_11 = utf8.len(var_332_9)
				local var_332_12 = var_332_10 <= 0 and var_332_7 or var_332_7 * (var_332_11 / var_332_10)

				if var_332_12 > 0 and var_332_7 < var_332_12 then
					arg_329_1.talkMaxDuration = var_332_12

					if var_332_12 + var_332_6 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_12 + var_332_6
					end
				end

				arg_329_1.text_.text = var_332_9
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_13 = math.max(var_332_7, arg_329_1.talkMaxDuration)

			if var_332_6 <= arg_329_1.time_ and arg_329_1.time_ < var_332_6 + var_332_13 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_6) / var_332_13

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_6 + var_332_13 and arg_329_1.time_ < var_332_6 + var_332_13 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play121501082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 121501082
		arg_333_1.duration_ = 8.53

		local var_333_0 = {
			ja = 8.533,
			ko = 8.2,
			zh = 8.2
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play121501083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_336_2 = arg_333_1.actors_["10014ui_story"]
			local var_336_3 = 0

			if var_336_3 < arg_333_1.time_ and arg_333_1.time_ <= var_336_3 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.characterEffect10014ui_story == nil then
				arg_333_1.var_.characterEffect10014ui_story = var_336_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_4 = 0.200000002980232

			if var_336_3 <= arg_333_1.time_ and arg_333_1.time_ < var_336_3 + var_336_4 and not isNil(var_336_2) then
				local var_336_5 = (arg_333_1.time_ - var_336_3) / var_336_4

				if arg_333_1.var_.characterEffect10014ui_story and not isNil(var_336_2) then
					arg_333_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_3 + var_336_4 and arg_333_1.time_ < var_336_3 + var_336_4 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.characterEffect10014ui_story then
				arg_333_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_336_6 = 0
			local var_336_7 = 1.1

			if var_336_6 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_8 = arg_333_1:FormatText(StoryNameCfg[264].name)

				arg_333_1.leftNameTxt_.text = var_336_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_9 = arg_333_1:GetWordFromCfg(121501082)
				local var_336_10 = arg_333_1:FormatText(var_336_9.content)

				arg_333_1.text_.text = var_336_10

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_11 = 44
				local var_336_12 = utf8.len(var_336_10)
				local var_336_13 = var_336_11 <= 0 and var_336_7 or var_336_7 * (var_336_12 / var_336_11)

				if var_336_13 > 0 and var_336_7 < var_336_13 then
					arg_333_1.talkMaxDuration = var_336_13

					if var_336_13 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_13 + var_336_6
					end
				end

				arg_333_1.text_.text = var_336_10
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501082", "story_v_out_121501.awb") ~= 0 then
					local var_336_14 = manager.audio:GetVoiceLength("story_v_out_121501", "121501082", "story_v_out_121501.awb") / 1000

					if var_336_14 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_14 + var_336_6
					end

					if var_336_9.prefab_name ~= "" and arg_333_1.actors_[var_336_9.prefab_name] ~= nil then
						local var_336_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_9.prefab_name].transform, "story_v_out_121501", "121501082", "story_v_out_121501.awb")

						arg_333_1:RecordAudio("121501082", var_336_15)
						arg_333_1:RecordAudio("121501082", var_336_15)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_121501", "121501082", "story_v_out_121501.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_121501", "121501082", "story_v_out_121501.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_16 = math.max(var_336_7, arg_333_1.talkMaxDuration)

			if var_336_6 <= arg_333_1.time_ and arg_333_1.time_ < var_336_6 + var_336_16 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_6) / var_336_16

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_6 + var_336_16 and arg_333_1.time_ < var_336_6 + var_336_16 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play121501083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 121501083
		arg_337_1.duration_ = 14.7

		local var_337_0 = {
			ja = 14.7,
			ko = 9.966,
			zh = 9.966
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play121501084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			local var_340_1 = 0
			local var_340_2 = 1.15

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_3 = arg_337_1:FormatText(StoryNameCfg[264].name)

				arg_337_1.leftNameTxt_.text = var_340_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_4 = arg_337_1:GetWordFromCfg(121501083)
				local var_340_5 = arg_337_1:FormatText(var_340_4.content)

				arg_337_1.text_.text = var_340_5

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_6 = 46
				local var_340_7 = utf8.len(var_340_5)
				local var_340_8 = var_340_6 <= 0 and var_340_2 or var_340_2 * (var_340_7 / var_340_6)

				if var_340_8 > 0 and var_340_2 < var_340_8 then
					arg_337_1.talkMaxDuration = var_340_8

					if var_340_8 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_1
					end
				end

				arg_337_1.text_.text = var_340_5
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501083", "story_v_out_121501.awb") ~= 0 then
					local var_340_9 = manager.audio:GetVoiceLength("story_v_out_121501", "121501083", "story_v_out_121501.awb") / 1000

					if var_340_9 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_9 + var_340_1
					end

					if var_340_4.prefab_name ~= "" and arg_337_1.actors_[var_340_4.prefab_name] ~= nil then
						local var_340_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_4.prefab_name].transform, "story_v_out_121501", "121501083", "story_v_out_121501.awb")

						arg_337_1:RecordAudio("121501083", var_340_10)
						arg_337_1:RecordAudio("121501083", var_340_10)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_121501", "121501083", "story_v_out_121501.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_121501", "121501083", "story_v_out_121501.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_11 = math.max(var_340_2, arg_337_1.talkMaxDuration)

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_11 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_1) / var_340_11

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_1 + var_340_11 and arg_337_1.time_ < var_340_1 + var_340_11 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play121501084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 121501084
		arg_341_1.duration_ = 2.4

		local var_341_0 = {
			ja = 2.4,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play121501085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_2")
			end

			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_344_2 = arg_341_1.actors_["1029ui_story"]
			local var_344_3 = 0

			if var_344_3 < arg_341_1.time_ and arg_341_1.time_ <= var_344_3 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.characterEffect1029ui_story == nil then
				arg_341_1.var_.characterEffect1029ui_story = var_344_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_4 = 0.200000002980232

			if var_344_3 <= arg_341_1.time_ and arg_341_1.time_ < var_344_3 + var_344_4 and not isNil(var_344_2) then
				local var_344_5 = (arg_341_1.time_ - var_344_3) / var_344_4

				if arg_341_1.var_.characterEffect1029ui_story and not isNil(var_344_2) then
					arg_341_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_3 + var_344_4 and arg_341_1.time_ < var_344_3 + var_344_4 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.characterEffect1029ui_story then
				arg_341_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_344_6 = arg_341_1.actors_["10014ui_story"]
			local var_344_7 = 0

			if var_344_7 < arg_341_1.time_ and arg_341_1.time_ <= var_344_7 + arg_344_0 and not isNil(var_344_6) and arg_341_1.var_.characterEffect10014ui_story == nil then
				arg_341_1.var_.characterEffect10014ui_story = var_344_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_8 = 0.200000002980232

			if var_344_7 <= arg_341_1.time_ and arg_341_1.time_ < var_344_7 + var_344_8 and not isNil(var_344_6) then
				local var_344_9 = (arg_341_1.time_ - var_344_7) / var_344_8

				if arg_341_1.var_.characterEffect10014ui_story and not isNil(var_344_6) then
					local var_344_10 = Mathf.Lerp(0, 0.5, var_344_9)

					arg_341_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_341_1.var_.characterEffect10014ui_story.fillRatio = var_344_10
				end
			end

			if arg_341_1.time_ >= var_344_7 + var_344_8 and arg_341_1.time_ < var_344_7 + var_344_8 + arg_344_0 and not isNil(var_344_6) and arg_341_1.var_.characterEffect10014ui_story then
				local var_344_11 = 0.5

				arg_341_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_341_1.var_.characterEffect10014ui_story.fillRatio = var_344_11
			end

			local var_344_12 = 0
			local var_344_13 = 0.15

			if var_344_12 < arg_341_1.time_ and arg_341_1.time_ <= var_344_12 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_14 = arg_341_1:FormatText(StoryNameCfg[319].name)

				arg_341_1.leftNameTxt_.text = var_344_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_15 = arg_341_1:GetWordFromCfg(121501084)
				local var_344_16 = arg_341_1:FormatText(var_344_15.content)

				arg_341_1.text_.text = var_344_16

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_17 = 6
				local var_344_18 = utf8.len(var_344_16)
				local var_344_19 = var_344_17 <= 0 and var_344_13 or var_344_13 * (var_344_18 / var_344_17)

				if var_344_19 > 0 and var_344_13 < var_344_19 then
					arg_341_1.talkMaxDuration = var_344_19

					if var_344_19 + var_344_12 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_19 + var_344_12
					end
				end

				arg_341_1.text_.text = var_344_16
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501084", "story_v_out_121501.awb") ~= 0 then
					local var_344_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501084", "story_v_out_121501.awb") / 1000

					if var_344_20 + var_344_12 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_20 + var_344_12
					end

					if var_344_15.prefab_name ~= "" and arg_341_1.actors_[var_344_15.prefab_name] ~= nil then
						local var_344_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_15.prefab_name].transform, "story_v_out_121501", "121501084", "story_v_out_121501.awb")

						arg_341_1:RecordAudio("121501084", var_344_21)
						arg_341_1:RecordAudio("121501084", var_344_21)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_121501", "121501084", "story_v_out_121501.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_121501", "121501084", "story_v_out_121501.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_22 = math.max(var_344_13, arg_341_1.talkMaxDuration)

			if var_344_12 <= arg_341_1.time_ and arg_341_1.time_ < var_344_12 + var_344_22 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_12) / var_344_22

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_12 + var_344_22 and arg_341_1.time_ < var_344_12 + var_344_22 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play121501085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 121501085
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play121501086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1029ui_story"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1029ui_story == nil then
				arg_345_1.var_.characterEffect1029ui_story = var_348_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.characterEffect1029ui_story and not isNil(var_348_0) then
					local var_348_4 = Mathf.Lerp(0, 0.5, var_348_3)

					arg_345_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1029ui_story.fillRatio = var_348_4
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1029ui_story then
				local var_348_5 = 0.5

				arg_345_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1029ui_story.fillRatio = var_348_5
			end

			local var_348_6 = 0
			local var_348_7 = 0.725

			if var_348_6 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_8 = arg_345_1:GetWordFromCfg(121501085)
				local var_348_9 = arg_345_1:FormatText(var_348_8.content)

				arg_345_1.text_.text = var_348_9

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_10 = 29
				local var_348_11 = utf8.len(var_348_9)
				local var_348_12 = var_348_10 <= 0 and var_348_7 or var_348_7 * (var_348_11 / var_348_10)

				if var_348_12 > 0 and var_348_7 < var_348_12 then
					arg_345_1.talkMaxDuration = var_348_12

					if var_348_12 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_12 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_9
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_13 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_13 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_13

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_13 and arg_345_1.time_ < var_348_6 + var_348_13 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play121501086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 121501086
		arg_349_1.duration_ = 7.53

		local var_349_0 = {
			ja = 5.166,
			ko = 7.533,
			zh = 7.533
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play121501087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["10014ui_story"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect10014ui_story == nil then
				arg_349_1.var_.characterEffect10014ui_story = var_352_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.characterEffect10014ui_story and not isNil(var_352_0) then
					arg_349_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect10014ui_story then
				arg_349_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_352_4 = 0
			local var_352_5 = 0.925

			if var_352_4 < arg_349_1.time_ and arg_349_1.time_ <= var_352_4 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_6 = arg_349_1:FormatText(StoryNameCfg[264].name)

				arg_349_1.leftNameTxt_.text = var_352_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_7 = arg_349_1:GetWordFromCfg(121501086)
				local var_352_8 = arg_349_1:FormatText(var_352_7.content)

				arg_349_1.text_.text = var_352_8

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_9 = 38
				local var_352_10 = utf8.len(var_352_8)
				local var_352_11 = var_352_9 <= 0 and var_352_5 or var_352_5 * (var_352_10 / var_352_9)

				if var_352_11 > 0 and var_352_5 < var_352_11 then
					arg_349_1.talkMaxDuration = var_352_11

					if var_352_11 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_11 + var_352_4
					end
				end

				arg_349_1.text_.text = var_352_8
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501086", "story_v_out_121501.awb") ~= 0 then
					local var_352_12 = manager.audio:GetVoiceLength("story_v_out_121501", "121501086", "story_v_out_121501.awb") / 1000

					if var_352_12 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_12 + var_352_4
					end

					if var_352_7.prefab_name ~= "" and arg_349_1.actors_[var_352_7.prefab_name] ~= nil then
						local var_352_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_7.prefab_name].transform, "story_v_out_121501", "121501086", "story_v_out_121501.awb")

						arg_349_1:RecordAudio("121501086", var_352_13)
						arg_349_1:RecordAudio("121501086", var_352_13)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_121501", "121501086", "story_v_out_121501.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_121501", "121501086", "story_v_out_121501.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_14 = math.max(var_352_5, arg_349_1.talkMaxDuration)

			if var_352_4 <= arg_349_1.time_ and arg_349_1.time_ < var_352_4 + var_352_14 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_4) / var_352_14

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_4 + var_352_14 and arg_349_1.time_ < var_352_4 + var_352_14 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play121501087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 121501087
		arg_353_1.duration_ = 9.8

		local var_353_0 = {
			ja = 8.766,
			ko = 9.8,
			zh = 9.8
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play121501088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0
			local var_356_1 = 1.025

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_2 = arg_353_1:FormatText(StoryNameCfg[264].name)

				arg_353_1.leftNameTxt_.text = var_356_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_3 = arg_353_1:GetWordFromCfg(121501087)
				local var_356_4 = arg_353_1:FormatText(var_356_3.content)

				arg_353_1.text_.text = var_356_4

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 41
				local var_356_6 = utf8.len(var_356_4)
				local var_356_7 = var_356_5 <= 0 and var_356_1 or var_356_1 * (var_356_6 / var_356_5)

				if var_356_7 > 0 and var_356_1 < var_356_7 then
					arg_353_1.talkMaxDuration = var_356_7

					if var_356_7 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_7 + var_356_0
					end
				end

				arg_353_1.text_.text = var_356_4
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501087", "story_v_out_121501.awb") ~= 0 then
					local var_356_8 = manager.audio:GetVoiceLength("story_v_out_121501", "121501087", "story_v_out_121501.awb") / 1000

					if var_356_8 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_8 + var_356_0
					end

					if var_356_3.prefab_name ~= "" and arg_353_1.actors_[var_356_3.prefab_name] ~= nil then
						local var_356_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_3.prefab_name].transform, "story_v_out_121501", "121501087", "story_v_out_121501.awb")

						arg_353_1:RecordAudio("121501087", var_356_9)
						arg_353_1:RecordAudio("121501087", var_356_9)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_121501", "121501087", "story_v_out_121501.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_121501", "121501087", "story_v_out_121501.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_10 = math.max(var_356_1, arg_353_1.talkMaxDuration)

			if var_356_0 <= arg_353_1.time_ and arg_353_1.time_ < var_356_0 + var_356_10 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_0) / var_356_10

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_0 + var_356_10 and arg_353_1.time_ < var_356_0 + var_356_10 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play121501088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 121501088
		arg_357_1.duration_ = 7.97

		local var_357_0 = {
			ja = 7.966,
			ko = 6.5,
			zh = 6.5
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play121501089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1029ui_story"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect1029ui_story == nil then
				arg_357_1.var_.characterEffect1029ui_story = var_360_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.characterEffect1029ui_story and not isNil(var_360_0) then
					arg_357_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect1029ui_story then
				arg_357_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_360_4 = arg_357_1.actors_["10014ui_story"]
			local var_360_5 = 0

			if var_360_5 < arg_357_1.time_ and arg_357_1.time_ <= var_360_5 + arg_360_0 and not isNil(var_360_4) and arg_357_1.var_.characterEffect10014ui_story == nil then
				arg_357_1.var_.characterEffect10014ui_story = var_360_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_6 = 0.200000002980232

			if var_360_5 <= arg_357_1.time_ and arg_357_1.time_ < var_360_5 + var_360_6 and not isNil(var_360_4) then
				local var_360_7 = (arg_357_1.time_ - var_360_5) / var_360_6

				if arg_357_1.var_.characterEffect10014ui_story and not isNil(var_360_4) then
					local var_360_8 = Mathf.Lerp(0, 0.5, var_360_7)

					arg_357_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_357_1.var_.characterEffect10014ui_story.fillRatio = var_360_8
				end
			end

			if arg_357_1.time_ >= var_360_5 + var_360_6 and arg_357_1.time_ < var_360_5 + var_360_6 + arg_360_0 and not isNil(var_360_4) and arg_357_1.var_.characterEffect10014ui_story then
				local var_360_9 = 0.5

				arg_357_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_357_1.var_.characterEffect10014ui_story.fillRatio = var_360_9
			end

			local var_360_10 = 0
			local var_360_11 = 0.85

			if var_360_10 < arg_357_1.time_ and arg_357_1.time_ <= var_360_10 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_12 = arg_357_1:FormatText(StoryNameCfg[319].name)

				arg_357_1.leftNameTxt_.text = var_360_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_13 = arg_357_1:GetWordFromCfg(121501088)
				local var_360_14 = arg_357_1:FormatText(var_360_13.content)

				arg_357_1.text_.text = var_360_14

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_15 = 34
				local var_360_16 = utf8.len(var_360_14)
				local var_360_17 = var_360_15 <= 0 and var_360_11 or var_360_11 * (var_360_16 / var_360_15)

				if var_360_17 > 0 and var_360_11 < var_360_17 then
					arg_357_1.talkMaxDuration = var_360_17

					if var_360_17 + var_360_10 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_17 + var_360_10
					end
				end

				arg_357_1.text_.text = var_360_14
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501088", "story_v_out_121501.awb") ~= 0 then
					local var_360_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501088", "story_v_out_121501.awb") / 1000

					if var_360_18 + var_360_10 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_18 + var_360_10
					end

					if var_360_13.prefab_name ~= "" and arg_357_1.actors_[var_360_13.prefab_name] ~= nil then
						local var_360_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_13.prefab_name].transform, "story_v_out_121501", "121501088", "story_v_out_121501.awb")

						arg_357_1:RecordAudio("121501088", var_360_19)
						arg_357_1:RecordAudio("121501088", var_360_19)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_121501", "121501088", "story_v_out_121501.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_121501", "121501088", "story_v_out_121501.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_20 = math.max(var_360_11, arg_357_1.talkMaxDuration)

			if var_360_10 <= arg_357_1.time_ and arg_357_1.time_ < var_360_10 + var_360_20 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_10) / var_360_20

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_10 + var_360_20 and arg_357_1.time_ < var_360_10 + var_360_20 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play121501089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 121501089
		arg_361_1.duration_ = 4.23

		local var_361_0 = {
			ja = 4.233,
			ko = 2.633,
			zh = 2.633
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play121501090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["1029ui_story"]
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect1029ui_story == nil then
				arg_361_1.var_.characterEffect1029ui_story = var_364_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 and not isNil(var_364_0) then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2

				if arg_361_1.var_.characterEffect1029ui_story and not isNil(var_364_0) then
					local var_364_4 = Mathf.Lerp(0, 0.5, var_364_3)

					arg_361_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1029ui_story.fillRatio = var_364_4
				end
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect1029ui_story then
				local var_364_5 = 0.5

				arg_361_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1029ui_story.fillRatio = var_364_5
			end

			local var_364_6 = arg_361_1.actors_["10014ui_story"]
			local var_364_7 = 0

			if var_364_7 < arg_361_1.time_ and arg_361_1.time_ <= var_364_7 + arg_364_0 and not isNil(var_364_6) and arg_361_1.var_.characterEffect10014ui_story == nil then
				arg_361_1.var_.characterEffect10014ui_story = var_364_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_8 = 0.200000002980232

			if var_364_7 <= arg_361_1.time_ and arg_361_1.time_ < var_364_7 + var_364_8 and not isNil(var_364_6) then
				local var_364_9 = (arg_361_1.time_ - var_364_7) / var_364_8

				if arg_361_1.var_.characterEffect10014ui_story and not isNil(var_364_6) then
					arg_361_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= var_364_7 + var_364_8 and arg_361_1.time_ < var_364_7 + var_364_8 + arg_364_0 and not isNil(var_364_6) and arg_361_1.var_.characterEffect10014ui_story then
				arg_361_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_364_10 = 0
			local var_364_11 = 0.25

			if var_364_10 < arg_361_1.time_ and arg_361_1.time_ <= var_364_10 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_12 = arg_361_1:FormatText(StoryNameCfg[264].name)

				arg_361_1.leftNameTxt_.text = var_364_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_13 = arg_361_1:GetWordFromCfg(121501089)
				local var_364_14 = arg_361_1:FormatText(var_364_13.content)

				arg_361_1.text_.text = var_364_14

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_15 = 10
				local var_364_16 = utf8.len(var_364_14)
				local var_364_17 = var_364_15 <= 0 and var_364_11 or var_364_11 * (var_364_16 / var_364_15)

				if var_364_17 > 0 and var_364_11 < var_364_17 then
					arg_361_1.talkMaxDuration = var_364_17

					if var_364_17 + var_364_10 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_17 + var_364_10
					end
				end

				arg_361_1.text_.text = var_364_14
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501089", "story_v_out_121501.awb") ~= 0 then
					local var_364_18 = manager.audio:GetVoiceLength("story_v_out_121501", "121501089", "story_v_out_121501.awb") / 1000

					if var_364_18 + var_364_10 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_18 + var_364_10
					end

					if var_364_13.prefab_name ~= "" and arg_361_1.actors_[var_364_13.prefab_name] ~= nil then
						local var_364_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_13.prefab_name].transform, "story_v_out_121501", "121501089", "story_v_out_121501.awb")

						arg_361_1:RecordAudio("121501089", var_364_19)
						arg_361_1:RecordAudio("121501089", var_364_19)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_121501", "121501089", "story_v_out_121501.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_121501", "121501089", "story_v_out_121501.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_20 = math.max(var_364_11, arg_361_1.talkMaxDuration)

			if var_364_10 <= arg_361_1.time_ and arg_361_1.time_ < var_364_10 + var_364_20 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_10) / var_364_20

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_10 + var_364_20 and arg_361_1.time_ < var_364_10 + var_364_20 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play121501090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 121501090
		arg_365_1.duration_ = 9.97

		local var_365_0 = {
			ja = 8.333,
			ko = 9.966,
			zh = 9.966
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play121501091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 then
				arg_365_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_368_2 = arg_365_1.actors_["1029ui_story"]
			local var_368_3 = 0

			if var_368_3 < arg_365_1.time_ and arg_365_1.time_ <= var_368_3 + arg_368_0 and not isNil(var_368_2) and arg_365_1.var_.characterEffect1029ui_story == nil then
				arg_365_1.var_.characterEffect1029ui_story = var_368_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_4 = 0.200000002980232

			if var_368_3 <= arg_365_1.time_ and arg_365_1.time_ < var_368_3 + var_368_4 and not isNil(var_368_2) then
				local var_368_5 = (arg_365_1.time_ - var_368_3) / var_368_4

				if arg_365_1.var_.characterEffect1029ui_story and not isNil(var_368_2) then
					arg_365_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= var_368_3 + var_368_4 and arg_365_1.time_ < var_368_3 + var_368_4 + arg_368_0 and not isNil(var_368_2) and arg_365_1.var_.characterEffect1029ui_story then
				arg_365_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_368_6 = arg_365_1.actors_["10014ui_story"]
			local var_368_7 = 0

			if var_368_7 < arg_365_1.time_ and arg_365_1.time_ <= var_368_7 + arg_368_0 and not isNil(var_368_6) and arg_365_1.var_.characterEffect10014ui_story == nil then
				arg_365_1.var_.characterEffect10014ui_story = var_368_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_8 = 0.200000002980232

			if var_368_7 <= arg_365_1.time_ and arg_365_1.time_ < var_368_7 + var_368_8 and not isNil(var_368_6) then
				local var_368_9 = (arg_365_1.time_ - var_368_7) / var_368_8

				if arg_365_1.var_.characterEffect10014ui_story and not isNil(var_368_6) then
					local var_368_10 = Mathf.Lerp(0, 0.5, var_368_9)

					arg_365_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_365_1.var_.characterEffect10014ui_story.fillRatio = var_368_10
				end
			end

			if arg_365_1.time_ >= var_368_7 + var_368_8 and arg_365_1.time_ < var_368_7 + var_368_8 + arg_368_0 and not isNil(var_368_6) and arg_365_1.var_.characterEffect10014ui_story then
				local var_368_11 = 0.5

				arg_365_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_365_1.var_.characterEffect10014ui_story.fillRatio = var_368_11
			end

			local var_368_12 = 0
			local var_368_13 = 1.125

			if var_368_12 < arg_365_1.time_ and arg_365_1.time_ <= var_368_12 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_14 = arg_365_1:FormatText(StoryNameCfg[319].name)

				arg_365_1.leftNameTxt_.text = var_368_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_15 = arg_365_1:GetWordFromCfg(121501090)
				local var_368_16 = arg_365_1:FormatText(var_368_15.content)

				arg_365_1.text_.text = var_368_16

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_17 = 45
				local var_368_18 = utf8.len(var_368_16)
				local var_368_19 = var_368_17 <= 0 and var_368_13 or var_368_13 * (var_368_18 / var_368_17)

				if var_368_19 > 0 and var_368_13 < var_368_19 then
					arg_365_1.talkMaxDuration = var_368_19

					if var_368_19 + var_368_12 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_19 + var_368_12
					end
				end

				arg_365_1.text_.text = var_368_16
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501090", "story_v_out_121501.awb") ~= 0 then
					local var_368_20 = manager.audio:GetVoiceLength("story_v_out_121501", "121501090", "story_v_out_121501.awb") / 1000

					if var_368_20 + var_368_12 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_20 + var_368_12
					end

					if var_368_15.prefab_name ~= "" and arg_365_1.actors_[var_368_15.prefab_name] ~= nil then
						local var_368_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_15.prefab_name].transform, "story_v_out_121501", "121501090", "story_v_out_121501.awb")

						arg_365_1:RecordAudio("121501090", var_368_21)
						arg_365_1:RecordAudio("121501090", var_368_21)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_121501", "121501090", "story_v_out_121501.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_121501", "121501090", "story_v_out_121501.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_22 = math.max(var_368_13, arg_365_1.talkMaxDuration)

			if var_368_12 <= arg_365_1.time_ and arg_365_1.time_ < var_368_12 + var_368_22 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_12) / var_368_22

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_12 + var_368_22 and arg_365_1.time_ < var_368_12 + var_368_22 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play121501091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 121501091
		arg_369_1.duration_ = 9.2

		local var_369_0 = {
			ja = 9.2,
			ko = 5,
			zh = 5
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play121501092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0
			local var_372_1 = 0.55

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_2 = arg_369_1:FormatText(StoryNameCfg[319].name)

				arg_369_1.leftNameTxt_.text = var_372_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_3 = arg_369_1:GetWordFromCfg(121501091)
				local var_372_4 = arg_369_1:FormatText(var_372_3.content)

				arg_369_1.text_.text = var_372_4

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 22
				local var_372_6 = utf8.len(var_372_4)
				local var_372_7 = var_372_5 <= 0 and var_372_1 or var_372_1 * (var_372_6 / var_372_5)

				if var_372_7 > 0 and var_372_1 < var_372_7 then
					arg_369_1.talkMaxDuration = var_372_7

					if var_372_7 + var_372_0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_7 + var_372_0
					end
				end

				arg_369_1.text_.text = var_372_4
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501091", "story_v_out_121501.awb") ~= 0 then
					local var_372_8 = manager.audio:GetVoiceLength("story_v_out_121501", "121501091", "story_v_out_121501.awb") / 1000

					if var_372_8 + var_372_0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_8 + var_372_0
					end

					if var_372_3.prefab_name ~= "" and arg_369_1.actors_[var_372_3.prefab_name] ~= nil then
						local var_372_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_3.prefab_name].transform, "story_v_out_121501", "121501091", "story_v_out_121501.awb")

						arg_369_1:RecordAudio("121501091", var_372_9)
						arg_369_1:RecordAudio("121501091", var_372_9)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_121501", "121501091", "story_v_out_121501.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_121501", "121501091", "story_v_out_121501.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_10 = math.max(var_372_1, arg_369_1.talkMaxDuration)

			if var_372_0 <= arg_369_1.time_ and arg_369_1.time_ < var_372_0 + var_372_10 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_0) / var_372_10

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_0 + var_372_10 and arg_369_1.time_ < var_372_0 + var_372_10 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play121501092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 121501092
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play121501093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1029ui_story"].transform
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.var_.moveOldPos1029ui_story = var_376_0.localPosition
			end

			local var_376_2 = 0.001

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2
				local var_376_4 = Vector3.New(0, 100, 0)

				var_376_0.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1029ui_story, var_376_4, var_376_3)

				local var_376_5 = manager.ui.mainCamera.transform.position - var_376_0.position

				var_376_0.forward = Vector3.New(var_376_5.x, var_376_5.y, var_376_5.z)

				local var_376_6 = var_376_0.localEulerAngles

				var_376_6.z = 0
				var_376_6.x = 0
				var_376_0.localEulerAngles = var_376_6
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 then
				var_376_0.localPosition = Vector3.New(0, 100, 0)

				local var_376_7 = manager.ui.mainCamera.transform.position - var_376_0.position

				var_376_0.forward = Vector3.New(var_376_7.x, var_376_7.y, var_376_7.z)

				local var_376_8 = var_376_0.localEulerAngles

				var_376_8.z = 0
				var_376_8.x = 0
				var_376_0.localEulerAngles = var_376_8
			end

			local var_376_9 = arg_373_1.actors_["1029ui_story"]
			local var_376_10 = 0

			if var_376_10 < arg_373_1.time_ and arg_373_1.time_ <= var_376_10 + arg_376_0 and not isNil(var_376_9) and arg_373_1.var_.characterEffect1029ui_story == nil then
				arg_373_1.var_.characterEffect1029ui_story = var_376_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_11 = 0.200000002980232

			if var_376_10 <= arg_373_1.time_ and arg_373_1.time_ < var_376_10 + var_376_11 and not isNil(var_376_9) then
				local var_376_12 = (arg_373_1.time_ - var_376_10) / var_376_11

				if arg_373_1.var_.characterEffect1029ui_story and not isNil(var_376_9) then
					local var_376_13 = Mathf.Lerp(0, 0.5, var_376_12)

					arg_373_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_373_1.var_.characterEffect1029ui_story.fillRatio = var_376_13
				end
			end

			if arg_373_1.time_ >= var_376_10 + var_376_11 and arg_373_1.time_ < var_376_10 + var_376_11 + arg_376_0 and not isNil(var_376_9) and arg_373_1.var_.characterEffect1029ui_story then
				local var_376_14 = 0.5

				arg_373_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_373_1.var_.characterEffect1029ui_story.fillRatio = var_376_14
			end

			local var_376_15 = arg_373_1.actors_["10014ui_story"].transform
			local var_376_16 = 0

			if var_376_16 < arg_373_1.time_ and arg_373_1.time_ <= var_376_16 + arg_376_0 then
				arg_373_1.var_.moveOldPos10014ui_story = var_376_15.localPosition
			end

			local var_376_17 = 0.001

			if var_376_16 <= arg_373_1.time_ and arg_373_1.time_ < var_376_16 + var_376_17 then
				local var_376_18 = (arg_373_1.time_ - var_376_16) / var_376_17
				local var_376_19 = Vector3.New(0, -1.06, -6.2)

				var_376_15.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos10014ui_story, var_376_19, var_376_18)

				local var_376_20 = manager.ui.mainCamera.transform.position - var_376_15.position

				var_376_15.forward = Vector3.New(var_376_20.x, var_376_20.y, var_376_20.z)

				local var_376_21 = var_376_15.localEulerAngles

				var_376_21.z = 0
				var_376_21.x = 0
				var_376_15.localEulerAngles = var_376_21
			end

			if arg_373_1.time_ >= var_376_16 + var_376_17 and arg_373_1.time_ < var_376_16 + var_376_17 + arg_376_0 then
				var_376_15.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_376_22 = manager.ui.mainCamera.transform.position - var_376_15.position

				var_376_15.forward = Vector3.New(var_376_22.x, var_376_22.y, var_376_22.z)

				local var_376_23 = var_376_15.localEulerAngles

				var_376_23.z = 0
				var_376_23.x = 0
				var_376_15.localEulerAngles = var_376_23
			end

			local var_376_24 = 0
			local var_376_25 = 0.7

			if var_376_24 < arg_373_1.time_ and arg_373_1.time_ <= var_376_24 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_26 = arg_373_1:GetWordFromCfg(121501092)
				local var_376_27 = arg_373_1:FormatText(var_376_26.content)

				arg_373_1.text_.text = var_376_27

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_28 = 28
				local var_376_29 = utf8.len(var_376_27)
				local var_376_30 = var_376_28 <= 0 and var_376_25 or var_376_25 * (var_376_29 / var_376_28)

				if var_376_30 > 0 and var_376_25 < var_376_30 then
					arg_373_1.talkMaxDuration = var_376_30

					if var_376_30 + var_376_24 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_30 + var_376_24
					end
				end

				arg_373_1.text_.text = var_376_27
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_31 = math.max(var_376_25, arg_373_1.talkMaxDuration)

			if var_376_24 <= arg_373_1.time_ and arg_373_1.time_ < var_376_24 + var_376_31 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_24) / var_376_31

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_24 + var_376_31 and arg_373_1.time_ < var_376_24 + var_376_31 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play121501093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 121501093
		arg_377_1.duration_ = 14.53

		local var_377_0 = {
			ja = 14.533,
			ko = 8.9,
			zh = 8.9
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
			arg_377_1.auto_ = false
		end

		function arg_377_1.playNext_(arg_379_0)
			arg_377_1.onStoryFinished_()
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0
			local var_380_1 = 1

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_2 = arg_377_1:FormatText(StoryNameCfg[319].name)

				arg_377_1.leftNameTxt_.text = var_380_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_3 = arg_377_1:GetWordFromCfg(121501093)
				local var_380_4 = arg_377_1:FormatText(var_380_3.content)

				arg_377_1.text_.text = var_380_4

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 39
				local var_380_6 = utf8.len(var_380_4)
				local var_380_7 = var_380_5 <= 0 and var_380_1 or var_380_1 * (var_380_6 / var_380_5)

				if var_380_7 > 0 and var_380_1 < var_380_7 then
					arg_377_1.talkMaxDuration = var_380_7

					if var_380_7 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_7 + var_380_0
					end
				end

				arg_377_1.text_.text = var_380_4
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121501", "121501093", "story_v_out_121501.awb") ~= 0 then
					local var_380_8 = manager.audio:GetVoiceLength("story_v_out_121501", "121501093", "story_v_out_121501.awb") / 1000

					if var_380_8 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_8 + var_380_0
					end

					if var_380_3.prefab_name ~= "" and arg_377_1.actors_[var_380_3.prefab_name] ~= nil then
						local var_380_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_3.prefab_name].transform, "story_v_out_121501", "121501093", "story_v_out_121501.awb")

						arg_377_1:RecordAudio("121501093", var_380_9)
						arg_377_1:RecordAudio("121501093", var_380_9)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_121501", "121501093", "story_v_out_121501.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_121501", "121501093", "story_v_out_121501.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_10 = math.max(var_380_1, arg_377_1.talkMaxDuration)

			if var_380_0 <= arg_377_1.time_ and arg_377_1.time_ < var_380_0 + var_380_10 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_0) / var_380_10

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_0 + var_380_10 and arg_377_1.time_ < var_380_0 + var_380_10 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST18a",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/I05a"
	},
	voices = {
		"story_v_out_121501.awb"
	}
}
