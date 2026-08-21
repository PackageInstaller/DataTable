return {
	Play113122001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113122001
		arg_1_1.duration_ = 7

		local var_1_0 = {
			ja = 7,
			ko = 5.933,
			zh = 6.833,
			en = 5.433
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
				arg_1_0:Play113122002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F02_1"

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
				local var_4_5 = arg_1_1.bgs_.F02_1

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
					if iter_4_0 ~= "F02_1" then
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

			local var_4_28 = 2
			local var_4_29 = 0.566666666666667

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

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
			local var_4_35 = 0.3

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

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[215].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6045")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(113122001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122001", "story_v_out_113122.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_out_113122", "113122001", "story_v_out_113122.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_113122", "113122001", "story_v_out_113122.awb")

						arg_1_1:RecordAudio("113122001", var_4_44)
						arg_1_1:RecordAudio("113122001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_113122", "113122001", "story_v_out_113122.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_113122", "113122001", "story_v_out_113122.awb")
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
	Play113122002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 113122002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play113122003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.65

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

				local var_12_2 = arg_9_1:GetWordFromCfg(113122002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 26
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
	Play113122003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 113122003
		arg_13_1.duration_ = 3.8

		local var_13_0 = {
			ja = 3.8,
			ko = 2.866,
			zh = 3.3,
			en = 3
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
				arg_13_0:Play113122004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "6046_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "6046_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["6046_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos6046_story = var_16_5.localPosition

				local var_16_7 = GameObjectTools.GetOrAddComponent(var_16_5.gameObject, typeof(DynamicBoneHelper))

				if var_16_7 then
					var_16_7:EnableDynamicBone(false)
				end
			end

			local var_16_8 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_6) / var_16_8
				local var_16_10 = Vector3.New(-0.7, -0.5, -6.3)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos6046_story, var_16_10, var_16_9)

				local var_16_11 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_11.x, var_16_11.y, var_16_11.z)

				local var_16_12 = var_16_5.localEulerAngles

				var_16_12.z = 0
				var_16_12.x = 0
				var_16_5.localEulerAngles = var_16_12
			end

			if arg_13_1.time_ >= var_16_6 + var_16_8 and arg_13_1.time_ < var_16_6 + var_16_8 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_16_13 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_13.x, var_16_13.y, var_16_13.z)

				local var_16_14 = var_16_5.localEulerAngles

				var_16_14.z = 0
				var_16_14.x = 0
				var_16_5.localEulerAngles = var_16_14

				local var_16_15 = GameObjectTools.GetOrAddComponent(var_16_5.gameObject, typeof(DynamicBoneHelper))

				if var_16_15 then
					var_16_15:EnableDynamicBone(true)
				end
			end

			local var_16_16 = 0

			if var_16_16 < arg_13_1.time_ and arg_13_1.time_ <= var_16_16 + arg_16_0 then
				arg_13_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_16_17 = 0

			if var_16_17 < arg_13_1.time_ and arg_13_1.time_ <= var_16_17 + arg_16_0 then
				arg_13_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_16_18 = arg_13_1.actors_["6046_story"]
			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 and not isNil(var_16_18) and arg_13_1.var_.characterEffect6046_story == nil then
				arg_13_1.var_.characterEffect6046_story = var_16_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_20 = 0.2

			if var_16_19 <= arg_13_1.time_ and arg_13_1.time_ < var_16_19 + var_16_20 and not isNil(var_16_18) then
				local var_16_21 = (arg_13_1.time_ - var_16_19) / var_16_20

				if arg_13_1.var_.characterEffect6046_story and not isNil(var_16_18) then
					arg_13_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_19 + var_16_20 and arg_13_1.time_ < var_16_19 + var_16_20 + arg_16_0 and not isNil(var_16_18) and arg_13_1.var_.characterEffect6046_story then
				arg_13_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_16_22 = 0
			local var_16_23 = 0.25

			if var_16_22 < arg_13_1.time_ and arg_13_1.time_ <= var_16_22 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_24 = arg_13_1:FormatText(StoryNameCfg[214].name)

				arg_13_1.leftNameTxt_.text = var_16_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_25 = arg_13_1:GetWordFromCfg(113122003)
				local var_16_26 = arg_13_1:FormatText(var_16_25.content)

				arg_13_1.text_.text = var_16_26

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_27 = 10
				local var_16_28 = utf8.len(var_16_26)
				local var_16_29 = var_16_27 <= 0 and var_16_23 or var_16_23 * (var_16_28 / var_16_27)

				if var_16_29 > 0 and var_16_23 < var_16_29 then
					arg_13_1.talkMaxDuration = var_16_29

					if var_16_29 + var_16_22 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_29 + var_16_22
					end
				end

				arg_13_1.text_.text = var_16_26
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122003", "story_v_out_113122.awb") ~= 0 then
					local var_16_30 = manager.audio:GetVoiceLength("story_v_out_113122", "113122003", "story_v_out_113122.awb") / 1000

					if var_16_30 + var_16_22 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_30 + var_16_22
					end

					if var_16_25.prefab_name ~= "" and arg_13_1.actors_[var_16_25.prefab_name] ~= nil then
						local var_16_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_25.prefab_name].transform, "story_v_out_113122", "113122003", "story_v_out_113122.awb")

						arg_13_1:RecordAudio("113122003", var_16_31)
						arg_13_1:RecordAudio("113122003", var_16_31)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_113122", "113122003", "story_v_out_113122.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_113122", "113122003", "story_v_out_113122.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_32 = math.max(var_16_23, arg_13_1.talkMaxDuration)

			if var_16_22 <= arg_13_1.time_ and arg_13_1.time_ < var_16_22 + var_16_32 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_22) / var_16_32

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_22 + var_16_32 and arg_13_1.time_ < var_16_22 + var_16_32 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
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
	Play113122004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 113122004
		arg_17_1.duration_ = 5.23

		local var_17_0 = {
			ja = 5.233,
			ko = 4.966,
			zh = 3.133,
			en = 2.533
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
				arg_17_0:Play113122005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["6046_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect6046_story == nil then
				arg_17_1.var_.characterEffect6046_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect6046_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect6046_story.fillFlat = true
					arg_17_1.var_.characterEffect6046_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect6046_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect6046_story.fillFlat = true
				arg_17_1.var_.characterEffect6046_story.fillRatio = var_20_5
			end

			local var_20_6 = "10006ui_story"

			if arg_17_1.actors_[var_20_6] == nil then
				local var_20_7 = Asset.Load("Char/" .. "10006ui_story")

				if not isNil(var_20_7) then
					local var_20_8 = Object.Instantiate(Asset.Load("Char/" .. "10006ui_story"), arg_17_1.stage_.transform)

					var_20_8.name = var_20_6
					var_20_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_6] = var_20_8

					local var_20_9 = var_20_8:GetComponentInChildren(typeof(CharacterEffect))

					var_20_9.enabled = true

					local var_20_10 = GameObjectTools.GetOrAddComponent(var_20_8, typeof(DynamicBoneHelper))

					if var_20_10 then
						var_20_10:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_9.transform, false)

					arg_17_1.var_[var_20_6 .. "Animator"] = var_20_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_6 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_6 .. "LipSync"] = var_20_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_11 = arg_17_1.actors_["10006ui_story"].transform
			local var_20_12 = 0

			if var_20_12 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.var_.moveOldPos10006ui_story = var_20_11.localPosition
			end

			local var_20_13 = 0.001

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_13 then
				local var_20_14 = (arg_17_1.time_ - var_20_12) / var_20_13
				local var_20_15 = Vector3.New(0.7, -0.98, -5.65)

				var_20_11.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10006ui_story, var_20_15, var_20_14)

				local var_20_16 = manager.ui.mainCamera.transform.position - var_20_11.position

				var_20_11.forward = Vector3.New(var_20_16.x, var_20_16.y, var_20_16.z)

				local var_20_17 = var_20_11.localEulerAngles

				var_20_17.z = 0
				var_20_17.x = 0
				var_20_11.localEulerAngles = var_20_17
			end

			if arg_17_1.time_ >= var_20_12 + var_20_13 and arg_17_1.time_ < var_20_12 + var_20_13 + arg_20_0 then
				var_20_11.localPosition = Vector3.New(0.7, -0.98, -5.65)

				local var_20_18 = manager.ui.mainCamera.transform.position - var_20_11.position

				var_20_11.forward = Vector3.New(var_20_18.x, var_20_18.y, var_20_18.z)

				local var_20_19 = var_20_11.localEulerAngles

				var_20_19.z = 0
				var_20_19.x = 0
				var_20_11.localEulerAngles = var_20_19
			end

			local var_20_20 = 0

			if var_20_20 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				arg_17_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action7_1")
			end

			local var_20_21 = 0

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_20_22 = arg_17_1.actors_["10006ui_story"]
			local var_20_23 = 0

			if var_20_23 < arg_17_1.time_ and arg_17_1.time_ <= var_20_23 + arg_20_0 and not isNil(var_20_22) and arg_17_1.var_.characterEffect10006ui_story == nil then
				arg_17_1.var_.characterEffect10006ui_story = var_20_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_24 = 0.2

			if var_20_23 <= arg_17_1.time_ and arg_17_1.time_ < var_20_23 + var_20_24 and not isNil(var_20_22) then
				local var_20_25 = (arg_17_1.time_ - var_20_23) / var_20_24

				if arg_17_1.var_.characterEffect10006ui_story and not isNil(var_20_22) then
					arg_17_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_23 + var_20_24 and arg_17_1.time_ < var_20_23 + var_20_24 + arg_20_0 and not isNil(var_20_22) and arg_17_1.var_.characterEffect10006ui_story then
				arg_17_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_20_26 = 0
			local var_20_27 = 0.225

			if var_20_26 < arg_17_1.time_ and arg_17_1.time_ <= var_20_26 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_28 = arg_17_1:FormatText(StoryNameCfg[212].name)

				arg_17_1.leftNameTxt_.text = var_20_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_29 = arg_17_1:GetWordFromCfg(113122004)
				local var_20_30 = arg_17_1:FormatText(var_20_29.content)

				arg_17_1.text_.text = var_20_30

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_31 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122004", "story_v_out_113122.awb") ~= 0 then
					local var_20_34 = manager.audio:GetVoiceLength("story_v_out_113122", "113122004", "story_v_out_113122.awb") / 1000

					if var_20_34 + var_20_26 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_34 + var_20_26
					end

					if var_20_29.prefab_name ~= "" and arg_17_1.actors_[var_20_29.prefab_name] ~= nil then
						local var_20_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_29.prefab_name].transform, "story_v_out_113122", "113122004", "story_v_out_113122.awb")

						arg_17_1:RecordAudio("113122004", var_20_35)
						arg_17_1:RecordAudio("113122004", var_20_35)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_113122", "113122004", "story_v_out_113122.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_113122", "113122004", "story_v_out_113122.awb")
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
				actorName = "10006ui_story",
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
	Play113122005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 113122005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play113122006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["6046_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos6046_story = var_24_0.localPosition

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0.gameObject, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end
			end

			local var_24_3 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_3 then
				local var_24_4 = (arg_21_1.time_ - var_24_1) / var_24_3
				local var_24_5 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos6046_story, var_24_5, var_24_4)

				local var_24_6 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_6.x, var_24_6.y, var_24_6.z)

				local var_24_7 = var_24_0.localEulerAngles

				var_24_7.z = 0
				var_24_7.x = 0
				var_24_0.localEulerAngles = var_24_7
			end

			if arg_21_1.time_ >= var_24_1 + var_24_3 and arg_21_1.time_ < var_24_1 + var_24_3 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, 100, 0)

				local var_24_8 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_8.x, var_24_8.y, var_24_8.z)

				local var_24_9 = var_24_0.localEulerAngles

				var_24_9.z = 0
				var_24_9.x = 0
				var_24_0.localEulerAngles = var_24_9

				local var_24_10 = GameObjectTools.GetOrAddComponent(var_24_0.gameObject, typeof(DynamicBoneHelper))

				if var_24_10 then
					var_24_10:EnableDynamicBone(true)
				end
			end

			local var_24_11 = arg_21_1.actors_["10006ui_story"].transform
			local var_24_12 = 0

			if var_24_12 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.var_.moveOldPos10006ui_story = var_24_11.localPosition
			end

			local var_24_13 = 0.001

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_13 then
				local var_24_14 = (arg_21_1.time_ - var_24_12) / var_24_13
				local var_24_15 = Vector3.New(0, 100, 0)

				var_24_11.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10006ui_story, var_24_15, var_24_14)

				local var_24_16 = manager.ui.mainCamera.transform.position - var_24_11.position

				var_24_11.forward = Vector3.New(var_24_16.x, var_24_16.y, var_24_16.z)

				local var_24_17 = var_24_11.localEulerAngles

				var_24_17.z = 0
				var_24_17.x = 0
				var_24_11.localEulerAngles = var_24_17
			end

			if arg_21_1.time_ >= var_24_12 + var_24_13 and arg_21_1.time_ < var_24_12 + var_24_13 + arg_24_0 then
				var_24_11.localPosition = Vector3.New(0, 100, 0)

				local var_24_18 = manager.ui.mainCamera.transform.position - var_24_11.position

				var_24_11.forward = Vector3.New(var_24_18.x, var_24_18.y, var_24_18.z)

				local var_24_19 = var_24_11.localEulerAngles

				var_24_19.z = 0
				var_24_19.x = 0
				var_24_11.localEulerAngles = var_24_19
			end

			local var_24_20 = 0
			local var_24_21 = 0.775

			if var_24_20 < arg_21_1.time_ and arg_21_1.time_ <= var_24_20 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_22 = arg_21_1:GetWordFromCfg(113122005)
				local var_24_23 = arg_21_1:FormatText(var_24_22.content)

				arg_21_1.text_.text = var_24_23

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_24 = 31
				local var_24_25 = utf8.len(var_24_23)
				local var_24_26 = var_24_24 <= 0 and var_24_21 or var_24_21 * (var_24_25 / var_24_24)

				if var_24_26 > 0 and var_24_21 < var_24_26 then
					arg_21_1.talkMaxDuration = var_24_26

					if var_24_26 + var_24_20 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_26 + var_24_20
					end
				end

				arg_21_1.text_.text = var_24_23
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_27 = math.max(var_24_21, arg_21_1.talkMaxDuration)

			if var_24_20 <= arg_21_1.time_ and arg_21_1.time_ < var_24_20 + var_24_27 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_20) / var_24_27

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_20 + var_24_27 and arg_21_1.time_ < var_24_20 + var_24_27 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10006ui_story",
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
	Play113122006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 113122006
		arg_25_1.duration_ = 7.47

		local var_25_0 = {
			ja = 7.466,
			ko = 5.933,
			zh = 6.4,
			en = 4.333
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
				arg_25_0:Play113122007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "6045_story"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Char/" .. "6045_story")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_25_1.stage_.transform)

					var_28_2.name = var_28_0
					var_28_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_0] = var_28_2

					local var_28_3 = var_28_2:GetComponentInChildren(typeof(CharacterEffect))

					var_28_3.enabled = true

					local var_28_4 = GameObjectTools.GetOrAddComponent(var_28_2, typeof(DynamicBoneHelper))

					if var_28_4 then
						var_28_4:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_3.transform, false)

					arg_25_1.var_[var_28_0 .. "Animator"] = var_28_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_0 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_0 .. "LipSync"] = var_28_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_5 = arg_25_1.actors_["6045_story"].transform
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.var_.moveOldPos6045_story = var_28_5.localPosition

				local var_28_7 = GameObjectTools.GetOrAddComponent(var_28_5.gameObject, typeof(DynamicBoneHelper))

				if var_28_7 then
					var_28_7:EnableDynamicBone(false)
				end
			end

			local var_28_8 = 0.001

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_8 then
				local var_28_9 = (arg_25_1.time_ - var_28_6) / var_28_8
				local var_28_10 = Vector3.New(-0.7, -0.5, -6.3)

				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos6045_story, var_28_10, var_28_9)

				local var_28_11 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_11.x, var_28_11.y, var_28_11.z)

				local var_28_12 = var_28_5.localEulerAngles

				var_28_12.z = 0
				var_28_12.x = 0
				var_28_5.localEulerAngles = var_28_12
			end

			if arg_25_1.time_ >= var_28_6 + var_28_8 and arg_25_1.time_ < var_28_6 + var_28_8 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_28_13 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_13.x, var_28_13.y, var_28_13.z)

				local var_28_14 = var_28_5.localEulerAngles

				var_28_14.z = 0
				var_28_14.x = 0
				var_28_5.localEulerAngles = var_28_14

				local var_28_15 = GameObjectTools.GetOrAddComponent(var_28_5.gameObject, typeof(DynamicBoneHelper))

				if var_28_15 then
					var_28_15:EnableDynamicBone(true)
				end
			end

			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_28_17 = 0

			if var_28_17 < arg_25_1.time_ and arg_25_1.time_ <= var_28_17 + arg_28_0 then
				arg_25_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_28_18 = arg_25_1.actors_["6045_story"]
			local var_28_19 = 0

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 and not isNil(var_28_18) and arg_25_1.var_.characterEffect6045_story == nil then
				arg_25_1.var_.characterEffect6045_story = var_28_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_20 = 0.2

			if var_28_19 <= arg_25_1.time_ and arg_25_1.time_ < var_28_19 + var_28_20 and not isNil(var_28_18) then
				local var_28_21 = (arg_25_1.time_ - var_28_19) / var_28_20

				if arg_25_1.var_.characterEffect6045_story and not isNil(var_28_18) then
					arg_25_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_19 + var_28_20 and arg_25_1.time_ < var_28_19 + var_28_20 + arg_28_0 and not isNil(var_28_18) and arg_25_1.var_.characterEffect6045_story then
				arg_25_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_28_22 = 0
			local var_28_23 = 0.35

			if var_28_22 < arg_25_1.time_ and arg_25_1.time_ <= var_28_22 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_24 = arg_25_1:FormatText(StoryNameCfg[215].name)

				arg_25_1.leftNameTxt_.text = var_28_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_25 = arg_25_1:GetWordFromCfg(113122006)
				local var_28_26 = arg_25_1:FormatText(var_28_25.content)

				arg_25_1.text_.text = var_28_26

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_27 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122006", "story_v_out_113122.awb") ~= 0 then
					local var_28_30 = manager.audio:GetVoiceLength("story_v_out_113122", "113122006", "story_v_out_113122.awb") / 1000

					if var_28_30 + var_28_22 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_30 + var_28_22
					end

					if var_28_25.prefab_name ~= "" and arg_25_1.actors_[var_28_25.prefab_name] ~= nil then
						local var_28_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_25.prefab_name].transform, "story_v_out_113122", "113122006", "story_v_out_113122.awb")

						arg_25_1:RecordAudio("113122006", var_28_31)
						arg_25_1:RecordAudio("113122006", var_28_31)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_113122", "113122006", "story_v_out_113122.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_113122", "113122006", "story_v_out_113122.awb")
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
				actorName = "6045_story",
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
	Play113122007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 113122007
		arg_29_1.duration_ = 5

		local var_29_0 = {
			ja = 5,
			ko = 3.8,
			zh = 4.066,
			en = 3.833
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
				arg_29_0:Play113122008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["6046_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos6046_story = var_32_0.localPosition

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0.gameObject, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end
			end

			local var_32_3 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_3 then
				local var_32_4 = (arg_29_1.time_ - var_32_1) / var_32_3
				local var_32_5 = Vector3.New(0.7, -0.5, -6.3)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos6046_story, var_32_5, var_32_4)

				local var_32_6 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_6.x, var_32_6.y, var_32_6.z)

				local var_32_7 = var_32_0.localEulerAngles

				var_32_7.z = 0
				var_32_7.x = 0
				var_32_0.localEulerAngles = var_32_7
			end

			if arg_29_1.time_ >= var_32_1 + var_32_3 and arg_29_1.time_ < var_32_1 + var_32_3 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_32_8 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_8.x, var_32_8.y, var_32_8.z)

				local var_32_9 = var_32_0.localEulerAngles

				var_32_9.z = 0
				var_32_9.x = 0
				var_32_0.localEulerAngles = var_32_9

				local var_32_10 = GameObjectTools.GetOrAddComponent(var_32_0.gameObject, typeof(DynamicBoneHelper))

				if var_32_10 then
					var_32_10:EnableDynamicBone(true)
				end
			end

			local var_32_11 = 0

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action2_1")
			end

			local var_32_12 = 0

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_32_13 = arg_29_1.actors_["6046_story"]
			local var_32_14 = 0

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 and not isNil(var_32_13) and arg_29_1.var_.characterEffect6046_story == nil then
				arg_29_1.var_.characterEffect6046_story = var_32_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_15 = 0.2

			if var_32_14 <= arg_29_1.time_ and arg_29_1.time_ < var_32_14 + var_32_15 and not isNil(var_32_13) then
				local var_32_16 = (arg_29_1.time_ - var_32_14) / var_32_15

				if arg_29_1.var_.characterEffect6046_story and not isNil(var_32_13) then
					arg_29_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_14 + var_32_15 and arg_29_1.time_ < var_32_14 + var_32_15 + arg_32_0 and not isNil(var_32_13) and arg_29_1.var_.characterEffect6046_story then
				arg_29_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_32_17 = arg_29_1.actors_["6045_story"]
			local var_32_18 = 0

			if var_32_18 < arg_29_1.time_ and arg_29_1.time_ <= var_32_18 + arg_32_0 and not isNil(var_32_17) and arg_29_1.var_.characterEffect6045_story == nil then
				arg_29_1.var_.characterEffect6045_story = var_32_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_19 = 0.2

			if var_32_18 <= arg_29_1.time_ and arg_29_1.time_ < var_32_18 + var_32_19 and not isNil(var_32_17) then
				local var_32_20 = (arg_29_1.time_ - var_32_18) / var_32_19

				if arg_29_1.var_.characterEffect6045_story and not isNil(var_32_17) then
					local var_32_21 = Mathf.Lerp(0, 0.5, var_32_20)

					arg_29_1.var_.characterEffect6045_story.fillFlat = true
					arg_29_1.var_.characterEffect6045_story.fillRatio = var_32_21
				end
			end

			if arg_29_1.time_ >= var_32_18 + var_32_19 and arg_29_1.time_ < var_32_18 + var_32_19 + arg_32_0 and not isNil(var_32_17) and arg_29_1.var_.characterEffect6045_story then
				local var_32_22 = 0.5

				arg_29_1.var_.characterEffect6045_story.fillFlat = true
				arg_29_1.var_.characterEffect6045_story.fillRatio = var_32_22
			end

			local var_32_23 = 0
			local var_32_24 = 0.325

			if var_32_23 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_25 = arg_29_1:FormatText(StoryNameCfg[214].name)

				arg_29_1.leftNameTxt_.text = var_32_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_26 = arg_29_1:GetWordFromCfg(113122007)
				local var_32_27 = arg_29_1:FormatText(var_32_26.content)

				arg_29_1.text_.text = var_32_27

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_28 = 13
				local var_32_29 = utf8.len(var_32_27)
				local var_32_30 = var_32_28 <= 0 and var_32_24 or var_32_24 * (var_32_29 / var_32_28)

				if var_32_30 > 0 and var_32_24 < var_32_30 then
					arg_29_1.talkMaxDuration = var_32_30

					if var_32_30 + var_32_23 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_30 + var_32_23
					end
				end

				arg_29_1.text_.text = var_32_27
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122007", "story_v_out_113122.awb") ~= 0 then
					local var_32_31 = manager.audio:GetVoiceLength("story_v_out_113122", "113122007", "story_v_out_113122.awb") / 1000

					if var_32_31 + var_32_23 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_31 + var_32_23
					end

					if var_32_26.prefab_name ~= "" and arg_29_1.actors_[var_32_26.prefab_name] ~= nil then
						local var_32_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_26.prefab_name].transform, "story_v_out_113122", "113122007", "story_v_out_113122.awb")

						arg_29_1:RecordAudio("113122007", var_32_32)
						arg_29_1:RecordAudio("113122007", var_32_32)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_113122", "113122007", "story_v_out_113122.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_113122", "113122007", "story_v_out_113122.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_33 = math.max(var_32_24, arg_29_1.talkMaxDuration)

			if var_32_23 <= arg_29_1.time_ and arg_29_1.time_ < var_32_23 + var_32_33 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_23) / var_32_33

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_23 + var_32_33 and arg_29_1.time_ < var_32_23 + var_32_33 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
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
	Play113122008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 113122008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play113122009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["6046_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos6046_story = var_36_0.localPosition

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0.gameObject, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end
			end

			local var_36_3 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_3 then
				local var_36_4 = (arg_33_1.time_ - var_36_1) / var_36_3
				local var_36_5 = Vector3.New(0, 100, 0)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos6046_story, var_36_5, var_36_4)

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

				local var_36_10 = GameObjectTools.GetOrAddComponent(var_36_0.gameObject, typeof(DynamicBoneHelper))

				if var_36_10 then
					var_36_10:EnableDynamicBone(true)
				end
			end

			local var_36_11 = arg_33_1.actors_["6045_story"].transform
			local var_36_12 = 0

			if var_36_12 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 then
				arg_33_1.var_.moveOldPos6045_story = var_36_11.localPosition

				local var_36_13 = GameObjectTools.GetOrAddComponent(var_36_11.gameObject, typeof(DynamicBoneHelper))

				if var_36_13 then
					var_36_13:EnableDynamicBone(false)
				end
			end

			local var_36_14 = 0.001

			if var_36_12 <= arg_33_1.time_ and arg_33_1.time_ < var_36_12 + var_36_14 then
				local var_36_15 = (arg_33_1.time_ - var_36_12) / var_36_14
				local var_36_16 = Vector3.New(0, 100, 0)

				var_36_11.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos6045_story, var_36_16, var_36_15)

				local var_36_17 = manager.ui.mainCamera.transform.position - var_36_11.position

				var_36_11.forward = Vector3.New(var_36_17.x, var_36_17.y, var_36_17.z)

				local var_36_18 = var_36_11.localEulerAngles

				var_36_18.z = 0
				var_36_18.x = 0
				var_36_11.localEulerAngles = var_36_18
			end

			if arg_33_1.time_ >= var_36_12 + var_36_14 and arg_33_1.time_ < var_36_12 + var_36_14 + arg_36_0 then
				var_36_11.localPosition = Vector3.New(0, 100, 0)

				local var_36_19 = manager.ui.mainCamera.transform.position - var_36_11.position

				var_36_11.forward = Vector3.New(var_36_19.x, var_36_19.y, var_36_19.z)

				local var_36_20 = var_36_11.localEulerAngles

				var_36_20.z = 0
				var_36_20.x = 0
				var_36_11.localEulerAngles = var_36_20

				local var_36_21 = GameObjectTools.GetOrAddComponent(var_36_11.gameObject, typeof(DynamicBoneHelper))

				if var_36_21 then
					var_36_21:EnableDynamicBone(true)
				end
			end

			local var_36_22 = 0
			local var_36_23 = 0.85

			if var_36_22 < arg_33_1.time_ and arg_33_1.time_ <= var_36_22 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_24 = arg_33_1:GetWordFromCfg(113122008)
				local var_36_25 = arg_33_1:FormatText(var_36_24.content)

				arg_33_1.text_.text = var_36_25

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_26 = 34
				local var_36_27 = utf8.len(var_36_25)
				local var_36_28 = var_36_26 <= 0 and var_36_23 or var_36_23 * (var_36_27 / var_36_26)

				if var_36_28 > 0 and var_36_23 < var_36_28 then
					arg_33_1.talkMaxDuration = var_36_28

					if var_36_28 + var_36_22 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_28 + var_36_22
					end
				end

				arg_33_1.text_.text = var_36_25
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_29 = math.max(var_36_23, arg_33_1.talkMaxDuration)

			if var_36_22 <= arg_33_1.time_ and arg_33_1.time_ < var_36_22 + var_36_29 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_22) / var_36_29

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_22 + var_36_29 and arg_33_1.time_ < var_36_22 + var_36_29 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play113122009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 113122009
		arg_37_1.duration_ = 1.27

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play113122010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 1

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				local var_40_2 = "play"
				local var_40_3 = "effect"

				arg_37_1:AudioAction(var_40_2, var_40_3, "se_story_10", "se_story_10_mouse", "")
			end

			local var_40_4 = 0
			local var_40_5 = 0.125

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_6 = arg_37_1:FormatText(StoryNameCfg[220].name)

				arg_37_1.leftNameTxt_.text = var_40_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(113122009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 5
				local var_40_10 = utf8.len(var_40_8)
				local var_40_11 = var_40_9 <= 0 and var_40_5 or var_40_5 * (var_40_10 / var_40_9)

				if var_40_11 > 0 and var_40_5 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122009", "story_v_out_113122.awb") ~= 0 then
					local var_40_12 = manager.audio:GetVoiceLength("story_v_out_113122", "113122009", "story_v_out_113122.awb") / 1000

					if var_40_12 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_4
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_113122", "113122009", "story_v_out_113122.awb")

						arg_37_1:RecordAudio("113122009", var_40_13)
						arg_37_1:RecordAudio("113122009", var_40_13)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_113122", "113122009", "story_v_out_113122.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_113122", "113122009", "story_v_out_113122.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_14 and arg_37_1.time_ < var_40_4 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play113122010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 113122010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play113122011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.9

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:GetWordFromCfg(113122010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 36
				local var_44_5 = utf8.len(var_44_3)
				local var_44_6 = var_44_4 <= 0 and var_44_1 or var_44_1 * (var_44_5 / var_44_4)

				if var_44_6 > 0 and var_44_1 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_7 and arg_41_1.time_ < var_44_0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play113122011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 113122011
		arg_45_1.duration_ = 3.83

		local var_45_0 = {
			ja = 3.466,
			ko = 3.166,
			zh = 3.833,
			en = 3.066
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
				arg_45_0:Play113122012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["6045_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos6045_story = var_48_0.localPosition

				local var_48_2 = GameObjectTools.GetOrAddComponent(var_48_0.gameObject, typeof(DynamicBoneHelper))

				if var_48_2 then
					var_48_2:EnableDynamicBone(false)
				end
			end

			local var_48_3 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_3 then
				local var_48_4 = (arg_45_1.time_ - var_48_1) / var_48_3
				local var_48_5 = Vector3.New(0, -0.5, -6.3)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos6045_story, var_48_5, var_48_4)

				local var_48_6 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_6.x, var_48_6.y, var_48_6.z)

				local var_48_7 = var_48_0.localEulerAngles

				var_48_7.z = 0
				var_48_7.x = 0
				var_48_0.localEulerAngles = var_48_7
			end

			if arg_45_1.time_ >= var_48_1 + var_48_3 and arg_45_1.time_ < var_48_1 + var_48_3 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_48_8 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_8.x, var_48_8.y, var_48_8.z)

				local var_48_9 = var_48_0.localEulerAngles

				var_48_9.z = 0
				var_48_9.x = 0
				var_48_0.localEulerAngles = var_48_9

				local var_48_10 = GameObjectTools.GetOrAddComponent(var_48_0.gameObject, typeof(DynamicBoneHelper))

				if var_48_10 then
					var_48_10:EnableDynamicBone(true)
				end
			end

			local var_48_11 = 0

			if var_48_11 < arg_45_1.time_ and arg_45_1.time_ <= var_48_11 + arg_48_0 then
				arg_45_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_48_12 = 0

			if var_48_12 < arg_45_1.time_ and arg_45_1.time_ <= var_48_12 + arg_48_0 then
				arg_45_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_48_13 = arg_45_1.actors_["6045_story"]
			local var_48_14 = 0

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 and not isNil(var_48_13) and arg_45_1.var_.characterEffect6045_story == nil then
				arg_45_1.var_.characterEffect6045_story = var_48_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_15 = 0.2

			if var_48_14 <= arg_45_1.time_ and arg_45_1.time_ < var_48_14 + var_48_15 and not isNil(var_48_13) then
				local var_48_16 = (arg_45_1.time_ - var_48_14) / var_48_15

				if arg_45_1.var_.characterEffect6045_story and not isNil(var_48_13) then
					arg_45_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_14 + var_48_15 and arg_45_1.time_ < var_48_14 + var_48_15 + arg_48_0 and not isNil(var_48_13) and arg_45_1.var_.characterEffect6045_story then
				arg_45_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_48_17 = 0
			local var_48_18 = 0.325

			if var_48_17 < arg_45_1.time_ and arg_45_1.time_ <= var_48_17 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_19 = arg_45_1:FormatText(StoryNameCfg[215].name)

				arg_45_1.leftNameTxt_.text = var_48_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_20 = arg_45_1:GetWordFromCfg(113122011)
				local var_48_21 = arg_45_1:FormatText(var_48_20.content)

				arg_45_1.text_.text = var_48_21

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_22 = 13
				local var_48_23 = utf8.len(var_48_21)
				local var_48_24 = var_48_22 <= 0 and var_48_18 or var_48_18 * (var_48_23 / var_48_22)

				if var_48_24 > 0 and var_48_18 < var_48_24 then
					arg_45_1.talkMaxDuration = var_48_24

					if var_48_24 + var_48_17 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_24 + var_48_17
					end
				end

				arg_45_1.text_.text = var_48_21
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122011", "story_v_out_113122.awb") ~= 0 then
					local var_48_25 = manager.audio:GetVoiceLength("story_v_out_113122", "113122011", "story_v_out_113122.awb") / 1000

					if var_48_25 + var_48_17 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_25 + var_48_17
					end

					if var_48_20.prefab_name ~= "" and arg_45_1.actors_[var_48_20.prefab_name] ~= nil then
						local var_48_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_20.prefab_name].transform, "story_v_out_113122", "113122011", "story_v_out_113122.awb")

						arg_45_1:RecordAudio("113122011", var_48_26)
						arg_45_1:RecordAudio("113122011", var_48_26)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_113122", "113122011", "story_v_out_113122.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_113122", "113122011", "story_v_out_113122.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_27 = math.max(var_48_18, arg_45_1.talkMaxDuration)

			if var_48_17 <= arg_45_1.time_ and arg_45_1.time_ < var_48_17 + var_48_27 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_17) / var_48_27

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_17 + var_48_27 and arg_45_1.time_ < var_48_17 + var_48_27 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play113122012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 113122012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play113122013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["6045_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos6045_story = var_52_0.localPosition

				local var_52_2 = GameObjectTools.GetOrAddComponent(var_52_0.gameObject, typeof(DynamicBoneHelper))

				if var_52_2 then
					var_52_2:EnableDynamicBone(false)
				end
			end

			local var_52_3 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_3 then
				local var_52_4 = (arg_49_1.time_ - var_52_1) / var_52_3
				local var_52_5 = Vector3.New(0, 100, 0)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos6045_story, var_52_5, var_52_4)

				local var_52_6 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_6.x, var_52_6.y, var_52_6.z)

				local var_52_7 = var_52_0.localEulerAngles

				var_52_7.z = 0
				var_52_7.x = 0
				var_52_0.localEulerAngles = var_52_7
			end

			if arg_49_1.time_ >= var_52_1 + var_52_3 and arg_49_1.time_ < var_52_1 + var_52_3 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, 100, 0)

				local var_52_8 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_8.x, var_52_8.y, var_52_8.z)

				local var_52_9 = var_52_0.localEulerAngles

				var_52_9.z = 0
				var_52_9.x = 0
				var_52_0.localEulerAngles = var_52_9

				local var_52_10 = GameObjectTools.GetOrAddComponent(var_52_0.gameObject, typeof(DynamicBoneHelper))

				if var_52_10 then
					var_52_10:EnableDynamicBone(true)
				end
			end

			local var_52_11 = 0
			local var_52_12 = 1

			if var_52_11 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				local var_52_13 = "play"
				local var_52_14 = "effect"

				arg_49_1:AudioAction(var_52_13, var_52_14, "se_story_10", "se_story_10_wood", "")
			end

			local var_52_15 = 0
			local var_52_16 = 1.025

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_17 = arg_49_1:GetWordFromCfg(113122012)
				local var_52_18 = arg_49_1:FormatText(var_52_17.content)

				arg_49_1.text_.text = var_52_18

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_19 = 41
				local var_52_20 = utf8.len(var_52_18)
				local var_52_21 = var_52_19 <= 0 and var_52_16 or var_52_16 * (var_52_20 / var_52_19)

				if var_52_21 > 0 and var_52_16 < var_52_21 then
					arg_49_1.talkMaxDuration = var_52_21

					if var_52_21 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_21 + var_52_15
					end
				end

				arg_49_1.text_.text = var_52_18
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_22 = math.max(var_52_16, arg_49_1.talkMaxDuration)

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_22 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_15) / var_52_22

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_15 + var_52_22 and arg_49_1.time_ < var_52_15 + var_52_22 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play113122013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 113122013
		arg_53_1.duration_ = 5.93

		local var_53_0 = {
			ja = 5.933,
			ko = 3.533,
			zh = 5.366,
			en = 5.033
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
				arg_53_0:Play113122014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = manager.ui.mainCamera.transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.shakeOldPos = var_56_0.localPosition
			end

			local var_56_2 = 0.6

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / 0.066
				local var_56_4, var_56_5 = math.modf(var_56_3)

				var_56_0.localPosition = Vector3.New(var_56_5 * 0.13, var_56_5 * 0.13, var_56_5 * 0.13) + arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = arg_53_1.var_.shakeOldPos
			end

			local var_56_6 = 0

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			local var_56_7 = 0.6

			if arg_53_1.time_ >= var_56_6 + var_56_7 and arg_53_1.time_ < var_56_6 + var_56_7 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			local var_56_8 = 0
			local var_56_9 = 0.475

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_10 = arg_53_1:FormatText(StoryNameCfg[215].name)

				arg_53_1.leftNameTxt_.text = var_56_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6045")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_11 = arg_53_1:GetWordFromCfg(113122013)
				local var_56_12 = arg_53_1:FormatText(var_56_11.content)

				arg_53_1.text_.text = var_56_12

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 19
				local var_56_14 = utf8.len(var_56_12)
				local var_56_15 = var_56_13 <= 0 and var_56_9 or var_56_9 * (var_56_14 / var_56_13)

				if var_56_15 > 0 and var_56_9 < var_56_15 then
					arg_53_1.talkMaxDuration = var_56_15

					if var_56_15 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_15 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_12
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122013", "story_v_out_113122.awb") ~= 0 then
					local var_56_16 = manager.audio:GetVoiceLength("story_v_out_113122", "113122013", "story_v_out_113122.awb") / 1000

					if var_56_16 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_16 + var_56_8
					end

					if var_56_11.prefab_name ~= "" and arg_53_1.actors_[var_56_11.prefab_name] ~= nil then
						local var_56_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_11.prefab_name].transform, "story_v_out_113122", "113122013", "story_v_out_113122.awb")

						arg_53_1:RecordAudio("113122013", var_56_17)
						arg_53_1:RecordAudio("113122013", var_56_17)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_113122", "113122013", "story_v_out_113122.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_113122", "113122013", "story_v_out_113122.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_18 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_18 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_18

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_18 and arg_53_1.time_ < var_56_8 + var_56_18 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play113122014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 113122014
		arg_57_1.duration_ = 6.53

		local var_57_0 = {
			ja = 6.533,
			ko = 4.766,
			zh = 5.533,
			en = 5.633
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
				arg_57_0:Play113122015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["6046_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos6046_story = var_60_0.localPosition

				local var_60_2 = GameObjectTools.GetOrAddComponent(var_60_0.gameObject, typeof(DynamicBoneHelper))

				if var_60_2 then
					var_60_2:EnableDynamicBone(false)
				end
			end

			local var_60_3 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_3 then
				local var_60_4 = (arg_57_1.time_ - var_60_1) / var_60_3
				local var_60_5 = Vector3.New(-0.7, -0.5, -6.3)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos6046_story, var_60_5, var_60_4)

				local var_60_6 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_6.x, var_60_6.y, var_60_6.z)

				local var_60_7 = var_60_0.localEulerAngles

				var_60_7.z = 0
				var_60_7.x = 0
				var_60_0.localEulerAngles = var_60_7
			end

			if arg_57_1.time_ >= var_60_1 + var_60_3 and arg_57_1.time_ < var_60_1 + var_60_3 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_60_8 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_8.x, var_60_8.y, var_60_8.z)

				local var_60_9 = var_60_0.localEulerAngles

				var_60_9.z = 0
				var_60_9.x = 0
				var_60_0.localEulerAngles = var_60_9

				local var_60_10 = GameObjectTools.GetOrAddComponent(var_60_0.gameObject, typeof(DynamicBoneHelper))

				if var_60_10 then
					var_60_10:EnableDynamicBone(true)
				end
			end

			local var_60_11 = 0

			if var_60_11 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_60_12 = 0

			if var_60_12 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 then
				arg_57_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_60_13 = arg_57_1.actors_["6046_story"]
			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 and not isNil(var_60_13) and arg_57_1.var_.characterEffect6046_story == nil then
				arg_57_1.var_.characterEffect6046_story = var_60_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_15 = 0.2

			if var_60_14 <= arg_57_1.time_ and arg_57_1.time_ < var_60_14 + var_60_15 and not isNil(var_60_13) then
				local var_60_16 = (arg_57_1.time_ - var_60_14) / var_60_15

				if arg_57_1.var_.characterEffect6046_story and not isNil(var_60_13) then
					arg_57_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_14 + var_60_15 and arg_57_1.time_ < var_60_14 + var_60_15 + arg_60_0 and not isNil(var_60_13) and arg_57_1.var_.characterEffect6046_story then
				arg_57_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_60_17 = 0
			local var_60_18 = 0.7

			if var_60_17 < arg_57_1.time_ and arg_57_1.time_ <= var_60_17 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_19 = arg_57_1:FormatText(StoryNameCfg[214].name)

				arg_57_1.leftNameTxt_.text = var_60_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_20 = arg_57_1:GetWordFromCfg(113122014)
				local var_60_21 = arg_57_1:FormatText(var_60_20.content)

				arg_57_1.text_.text = var_60_21

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_22 = 28
				local var_60_23 = utf8.len(var_60_21)
				local var_60_24 = var_60_22 <= 0 and var_60_18 or var_60_18 * (var_60_23 / var_60_22)

				if var_60_24 > 0 and var_60_18 < var_60_24 then
					arg_57_1.talkMaxDuration = var_60_24

					if var_60_24 + var_60_17 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_24 + var_60_17
					end
				end

				arg_57_1.text_.text = var_60_21
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122014", "story_v_out_113122.awb") ~= 0 then
					local var_60_25 = manager.audio:GetVoiceLength("story_v_out_113122", "113122014", "story_v_out_113122.awb") / 1000

					if var_60_25 + var_60_17 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_25 + var_60_17
					end

					if var_60_20.prefab_name ~= "" and arg_57_1.actors_[var_60_20.prefab_name] ~= nil then
						local var_60_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_20.prefab_name].transform, "story_v_out_113122", "113122014", "story_v_out_113122.awb")

						arg_57_1:RecordAudio("113122014", var_60_26)
						arg_57_1:RecordAudio("113122014", var_60_26)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_113122", "113122014", "story_v_out_113122.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_113122", "113122014", "story_v_out_113122.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_27 = math.max(var_60_18, arg_57_1.talkMaxDuration)

			if var_60_17 <= arg_57_1.time_ and arg_57_1.time_ < var_60_17 + var_60_27 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_17) / var_60_27

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_17 + var_60_27 and arg_57_1.time_ < var_60_17 + var_60_27 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
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
	Play113122015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 113122015
		arg_61_1.duration_ = 5.83

		local var_61_0 = {
			ja = 5.833,
			ko = 3.2,
			zh = 3.766,
			en = 3.766
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
				arg_61_0:Play113122016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046actionlink/6046action442")
			end

			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_64_2 = 0
			local var_64_3 = 0.325

			if var_64_2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_4 = arg_61_1:FormatText(StoryNameCfg[214].name)

				arg_61_1.leftNameTxt_.text = var_64_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_5 = arg_61_1:GetWordFromCfg(113122015)
				local var_64_6 = arg_61_1:FormatText(var_64_5.content)

				arg_61_1.text_.text = var_64_6

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122015", "story_v_out_113122.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_113122", "113122015", "story_v_out_113122.awb") / 1000

					if var_64_10 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_2
					end

					if var_64_5.prefab_name ~= "" and arg_61_1.actors_[var_64_5.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_5.prefab_name].transform, "story_v_out_113122", "113122015", "story_v_out_113122.awb")

						arg_61_1:RecordAudio("113122015", var_64_11)
						arg_61_1:RecordAudio("113122015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_113122", "113122015", "story_v_out_113122.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_113122", "113122015", "story_v_out_113122.awb")
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
	Play113122016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 113122016
		arg_65_1.duration_ = 5.87

		local var_65_0 = {
			ja = 5.866,
			ko = 4.4,
			zh = 5.1,
			en = 5.2
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
				arg_65_0:Play113122017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = "1097ui_story"

			if arg_65_1.actors_[var_68_0] == nil then
				local var_68_1 = Asset.Load("Char/" .. "1097ui_story")

				if not isNil(var_68_1) then
					local var_68_2 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_65_1.stage_.transform)

					var_68_2.name = var_68_0
					var_68_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_65_1.actors_[var_68_0] = var_68_2

					local var_68_3 = var_68_2:GetComponentInChildren(typeof(CharacterEffect))

					var_68_3.enabled = true

					local var_68_4 = GameObjectTools.GetOrAddComponent(var_68_2, typeof(DynamicBoneHelper))

					if var_68_4 then
						var_68_4:EnableDynamicBone(false)
					end

					arg_65_1:ShowWeapon(var_68_3.transform, false)

					arg_65_1.var_[var_68_0 .. "Animator"] = var_68_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_65_1.var_[var_68_0 .. "Animator"].applyRootMotion = true
					arg_65_1.var_[var_68_0 .. "LipSync"] = var_68_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_68_5 = arg_65_1.actors_["1097ui_story"].transform
			local var_68_6 = 0

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.var_.moveOldPos1097ui_story = var_68_5.localPosition
			end

			local var_68_7 = 0.001

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_7 then
				local var_68_8 = (arg_65_1.time_ - var_68_6) / var_68_7
				local var_68_9 = Vector3.New(0.7, -0.54, -6.3)

				var_68_5.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1097ui_story, var_68_9, var_68_8)

				local var_68_10 = manager.ui.mainCamera.transform.position - var_68_5.position

				var_68_5.forward = Vector3.New(var_68_10.x, var_68_10.y, var_68_10.z)

				local var_68_11 = var_68_5.localEulerAngles

				var_68_11.z = 0
				var_68_11.x = 0
				var_68_5.localEulerAngles = var_68_11
			end

			if arg_65_1.time_ >= var_68_6 + var_68_7 and arg_65_1.time_ < var_68_6 + var_68_7 + arg_68_0 then
				var_68_5.localPosition = Vector3.New(0.7, -0.54, -6.3)

				local var_68_12 = manager.ui.mainCamera.transform.position - var_68_5.position

				var_68_5.forward = Vector3.New(var_68_12.x, var_68_12.y, var_68_12.z)

				local var_68_13 = var_68_5.localEulerAngles

				var_68_13.z = 0
				var_68_13.x = 0
				var_68_5.localEulerAngles = var_68_13
			end

			local var_68_14 = 0

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 then
				arg_65_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action4_1")
			end

			local var_68_15 = 0

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_68_16 = arg_65_1.actors_["1097ui_story"]
			local var_68_17 = 0

			if var_68_17 < arg_65_1.time_ and arg_65_1.time_ <= var_68_17 + arg_68_0 and not isNil(var_68_16) and arg_65_1.var_.characterEffect1097ui_story == nil then
				arg_65_1.var_.characterEffect1097ui_story = var_68_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_18 = 0.2

			if var_68_17 <= arg_65_1.time_ and arg_65_1.time_ < var_68_17 + var_68_18 and not isNil(var_68_16) then
				local var_68_19 = (arg_65_1.time_ - var_68_17) / var_68_18

				if arg_65_1.var_.characterEffect1097ui_story and not isNil(var_68_16) then
					arg_65_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_17 + var_68_18 and arg_65_1.time_ < var_68_17 + var_68_18 + arg_68_0 and not isNil(var_68_16) and arg_65_1.var_.characterEffect1097ui_story then
				arg_65_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_68_20 = arg_65_1.actors_["6046_story"]
			local var_68_21 = 0

			if var_68_21 < arg_65_1.time_ and arg_65_1.time_ <= var_68_21 + arg_68_0 and not isNil(var_68_20) and arg_65_1.var_.characterEffect6046_story == nil then
				arg_65_1.var_.characterEffect6046_story = var_68_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_22 = 0.2

			if var_68_21 <= arg_65_1.time_ and arg_65_1.time_ < var_68_21 + var_68_22 and not isNil(var_68_20) then
				local var_68_23 = (arg_65_1.time_ - var_68_21) / var_68_22

				if arg_65_1.var_.characterEffect6046_story and not isNil(var_68_20) then
					local var_68_24 = Mathf.Lerp(0, 0.5, var_68_23)

					arg_65_1.var_.characterEffect6046_story.fillFlat = true
					arg_65_1.var_.characterEffect6046_story.fillRatio = var_68_24
				end
			end

			if arg_65_1.time_ >= var_68_21 + var_68_22 and arg_65_1.time_ < var_68_21 + var_68_22 + arg_68_0 and not isNil(var_68_20) and arg_65_1.var_.characterEffect6046_story then
				local var_68_25 = 0.5

				arg_65_1.var_.characterEffect6046_story.fillFlat = true
				arg_65_1.var_.characterEffect6046_story.fillRatio = var_68_25
			end

			local var_68_26 = 0
			local var_68_27 = 0.275

			if var_68_26 < arg_65_1.time_ and arg_65_1.time_ <= var_68_26 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_28 = arg_65_1:FormatText(StoryNameCfg[216].name)

				arg_65_1.leftNameTxt_.text = var_68_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_29 = arg_65_1:GetWordFromCfg(113122016)
				local var_68_30 = arg_65_1:FormatText(var_68_29.content)

				arg_65_1.text_.text = var_68_30

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_31 = 11
				local var_68_32 = utf8.len(var_68_30)
				local var_68_33 = var_68_31 <= 0 and var_68_27 or var_68_27 * (var_68_32 / var_68_31)

				if var_68_33 > 0 and var_68_27 < var_68_33 then
					arg_65_1.talkMaxDuration = var_68_33

					if var_68_33 + var_68_26 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_33 + var_68_26
					end
				end

				arg_65_1.text_.text = var_68_30
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122016", "story_v_out_113122.awb") ~= 0 then
					local var_68_34 = manager.audio:GetVoiceLength("story_v_out_113122", "113122016", "story_v_out_113122.awb") / 1000

					if var_68_34 + var_68_26 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_34 + var_68_26
					end

					if var_68_29.prefab_name ~= "" and arg_65_1.actors_[var_68_29.prefab_name] ~= nil then
						local var_68_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_29.prefab_name].transform, "story_v_out_113122", "113122016", "story_v_out_113122.awb")

						arg_65_1:RecordAudio("113122016", var_68_35)
						arg_65_1:RecordAudio("113122016", var_68_35)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_113122", "113122016", "story_v_out_113122.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_113122", "113122016", "story_v_out_113122.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_36 = math.max(var_68_27, arg_65_1.talkMaxDuration)

			if var_68_26 <= arg_65_1.time_ and arg_65_1.time_ < var_68_26 + var_68_36 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_26) / var_68_36

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_26 + var_68_36 and arg_65_1.time_ < var_68_26 + var_68_36 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play113122017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 113122017
		arg_69_1.duration_ = 6.73

		local var_69_0 = {
			ja = 6.733,
			ko = 6.333,
			zh = 5.833,
			en = 5.7
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
				arg_69_0:Play113122018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1097ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1097ui_story == nil then
				arg_69_1.var_.characterEffect1097ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1097ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1097ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1097ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1097ui_story.fillRatio = var_72_5
			end

			local var_72_6 = arg_69_1.actors_["6045_story"].transform
			local var_72_7 = 0

			if var_72_7 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 then
				arg_69_1.var_.moveOldPos6045_story = var_72_6.localPosition

				local var_72_8 = GameObjectTools.GetOrAddComponent(var_72_6.gameObject, typeof(DynamicBoneHelper))

				if var_72_8 then
					var_72_8:EnableDynamicBone(false)
				end
			end

			local var_72_9 = 0.001

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_9 then
				local var_72_10 = (arg_69_1.time_ - var_72_7) / var_72_9
				local var_72_11 = Vector3.New(-0.7, -0.5, -6.3)

				var_72_6.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos6045_story, var_72_11, var_72_10)

				local var_72_12 = manager.ui.mainCamera.transform.position - var_72_6.position

				var_72_6.forward = Vector3.New(var_72_12.x, var_72_12.y, var_72_12.z)

				local var_72_13 = var_72_6.localEulerAngles

				var_72_13.z = 0
				var_72_13.x = 0
				var_72_6.localEulerAngles = var_72_13
			end

			if arg_69_1.time_ >= var_72_7 + var_72_9 and arg_69_1.time_ < var_72_7 + var_72_9 + arg_72_0 then
				var_72_6.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_72_14 = manager.ui.mainCamera.transform.position - var_72_6.position

				var_72_6.forward = Vector3.New(var_72_14.x, var_72_14.y, var_72_14.z)

				local var_72_15 = var_72_6.localEulerAngles

				var_72_15.z = 0
				var_72_15.x = 0
				var_72_6.localEulerAngles = var_72_15

				local var_72_16 = GameObjectTools.GetOrAddComponent(var_72_6.gameObject, typeof(DynamicBoneHelper))

				if var_72_16 then
					var_72_16:EnableDynamicBone(true)
				end
			end

			local var_72_17 = 0

			if var_72_17 < arg_69_1.time_ and arg_69_1.time_ <= var_72_17 + arg_72_0 then
				arg_69_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_72_18 = 0

			if var_72_18 < arg_69_1.time_ and arg_69_1.time_ <= var_72_18 + arg_72_0 then
				arg_69_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_72_19 = arg_69_1.actors_["6045_story"]
			local var_72_20 = 0

			if var_72_20 < arg_69_1.time_ and arg_69_1.time_ <= var_72_20 + arg_72_0 and not isNil(var_72_19) and arg_69_1.var_.characterEffect6045_story == nil then
				arg_69_1.var_.characterEffect6045_story = var_72_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_21 = 0.2

			if var_72_20 <= arg_69_1.time_ and arg_69_1.time_ < var_72_20 + var_72_21 and not isNil(var_72_19) then
				local var_72_22 = (arg_69_1.time_ - var_72_20) / var_72_21

				if arg_69_1.var_.characterEffect6045_story and not isNil(var_72_19) then
					arg_69_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_20 + var_72_21 and arg_69_1.time_ < var_72_20 + var_72_21 + arg_72_0 and not isNil(var_72_19) and arg_69_1.var_.characterEffect6045_story then
				arg_69_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_72_23 = arg_69_1.actors_["6046_story"].transform
			local var_72_24 = 0

			if var_72_24 < arg_69_1.time_ and arg_69_1.time_ <= var_72_24 + arg_72_0 then
				arg_69_1.var_.moveOldPos6046_story = var_72_23.localPosition

				local var_72_25 = GameObjectTools.GetOrAddComponent(var_72_23.gameObject, typeof(DynamicBoneHelper))

				if var_72_25 then
					var_72_25:EnableDynamicBone(false)
				end
			end

			local var_72_26 = 0.001

			if var_72_24 <= arg_69_1.time_ and arg_69_1.time_ < var_72_24 + var_72_26 then
				local var_72_27 = (arg_69_1.time_ - var_72_24) / var_72_26
				local var_72_28 = Vector3.New(0, 100, 0)

				var_72_23.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos6046_story, var_72_28, var_72_27)

				local var_72_29 = manager.ui.mainCamera.transform.position - var_72_23.position

				var_72_23.forward = Vector3.New(var_72_29.x, var_72_29.y, var_72_29.z)

				local var_72_30 = var_72_23.localEulerAngles

				var_72_30.z = 0
				var_72_30.x = 0
				var_72_23.localEulerAngles = var_72_30
			end

			if arg_69_1.time_ >= var_72_24 + var_72_26 and arg_69_1.time_ < var_72_24 + var_72_26 + arg_72_0 then
				var_72_23.localPosition = Vector3.New(0, 100, 0)

				local var_72_31 = manager.ui.mainCamera.transform.position - var_72_23.position

				var_72_23.forward = Vector3.New(var_72_31.x, var_72_31.y, var_72_31.z)

				local var_72_32 = var_72_23.localEulerAngles

				var_72_32.z = 0
				var_72_32.x = 0
				var_72_23.localEulerAngles = var_72_32

				local var_72_33 = GameObjectTools.GetOrAddComponent(var_72_23.gameObject, typeof(DynamicBoneHelper))

				if var_72_33 then
					var_72_33:EnableDynamicBone(true)
				end
			end

			local var_72_34 = 0

			if var_72_34 < arg_69_1.time_ and arg_69_1.time_ <= var_72_34 + arg_72_0 then
				arg_69_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action4_2")
			end

			local var_72_35 = 0

			if var_72_35 < arg_69_1.time_ and arg_69_1.time_ <= var_72_35 + arg_72_0 then
				arg_69_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_72_36 = 0
			local var_72_37 = 0.4

			if var_72_36 < arg_69_1.time_ and arg_69_1.time_ <= var_72_36 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_38 = arg_69_1:FormatText(StoryNameCfg[215].name)

				arg_69_1.leftNameTxt_.text = var_72_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_39 = arg_69_1:GetWordFromCfg(113122017)
				local var_72_40 = arg_69_1:FormatText(var_72_39.content)

				arg_69_1.text_.text = var_72_40

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_41 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122017", "story_v_out_113122.awb") ~= 0 then
					local var_72_44 = manager.audio:GetVoiceLength("story_v_out_113122", "113122017", "story_v_out_113122.awb") / 1000

					if var_72_44 + var_72_36 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_44 + var_72_36
					end

					if var_72_39.prefab_name ~= "" and arg_69_1.actors_[var_72_39.prefab_name] ~= nil then
						local var_72_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_39.prefab_name].transform, "story_v_out_113122", "113122017", "story_v_out_113122.awb")

						arg_69_1:RecordAudio("113122017", var_72_45)
						arg_69_1:RecordAudio("113122017", var_72_45)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_113122", "113122017", "story_v_out_113122.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_113122", "113122017", "story_v_out_113122.awb")
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
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play113122018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 113122018
		arg_73_1.duration_ = 3.1

		local var_73_0 = {
			ja = 3.1,
			ko = 2.733,
			zh = 2.866,
			en = 2.8
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
				arg_73_0:Play113122019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["6045_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect6045_story == nil then
				arg_73_1.var_.characterEffect6045_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect6045_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect6045_story.fillFlat = true
					arg_73_1.var_.characterEffect6045_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect6045_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect6045_story.fillFlat = true
				arg_73_1.var_.characterEffect6045_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 0.25

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[214].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6046")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_9 = arg_73_1:GetWordFromCfg(113122018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 10
				local var_76_12 = utf8.len(var_76_10)
				local var_76_13 = var_76_11 <= 0 and var_76_7 or var_76_7 * (var_76_12 / var_76_11)

				if var_76_13 > 0 and var_76_7 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_10
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122018", "story_v_out_113122.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_out_113122", "113122018", "story_v_out_113122.awb") / 1000

					if var_76_14 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_6
					end

					if var_76_9.prefab_name ~= "" and arg_73_1.actors_[var_76_9.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_9.prefab_name].transform, "story_v_out_113122", "113122018", "story_v_out_113122.awb")

						arg_73_1:RecordAudio("113122018", var_76_15)
						arg_73_1:RecordAudio("113122018", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_113122", "113122018", "story_v_out_113122.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_113122", "113122018", "story_v_out_113122.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_16 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_16 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_16

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_16 and arg_73_1.time_ < var_76_6 + var_76_16 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play113122019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 113122019
		arg_77_1.duration_ = 14.97

		local var_77_0 = {
			ja = 14.966,
			ko = 12.366,
			zh = 11.466,
			en = 12.066
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
				arg_77_0:Play113122020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_80_1 = arg_77_1.actors_["1097ui_story"]
			local var_80_2 = 0

			if var_80_2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1097ui_story == nil then
				arg_77_1.var_.characterEffect1097ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_3 = 0.2

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_3 and not isNil(var_80_1) then
				local var_80_4 = (arg_77_1.time_ - var_80_2) / var_80_3

				if arg_77_1.var_.characterEffect1097ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_2 + var_80_3 and arg_77_1.time_ < var_80_2 + var_80_3 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1097ui_story then
				arg_77_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_80_5 = 0
			local var_80_6 = 0.95

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_7 = arg_77_1:FormatText(StoryNameCfg[216].name)

				arg_77_1.leftNameTxt_.text = var_80_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:GetWordFromCfg(113122019)
				local var_80_9 = arg_77_1:FormatText(var_80_8.content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 38
				local var_80_11 = utf8.len(var_80_9)
				local var_80_12 = var_80_10 <= 0 and var_80_6 or var_80_6 * (var_80_11 / var_80_10)

				if var_80_12 > 0 and var_80_6 < var_80_12 then
					arg_77_1.talkMaxDuration = var_80_12

					if var_80_12 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_9
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122019", "story_v_out_113122.awb") ~= 0 then
					local var_80_13 = manager.audio:GetVoiceLength("story_v_out_113122", "113122019", "story_v_out_113122.awb") / 1000

					if var_80_13 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_5
					end

					if var_80_8.prefab_name ~= "" and arg_77_1.actors_[var_80_8.prefab_name] ~= nil then
						local var_80_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_8.prefab_name].transform, "story_v_out_113122", "113122019", "story_v_out_113122.awb")

						arg_77_1:RecordAudio("113122019", var_80_14)
						arg_77_1:RecordAudio("113122019", var_80_14)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_113122", "113122019", "story_v_out_113122.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_113122", "113122019", "story_v_out_113122.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_15 = math.max(var_80_6, arg_77_1.talkMaxDuration)

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_15 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_5) / var_80_15

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_5 + var_80_15 and arg_77_1.time_ < var_80_5 + var_80_15 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play113122020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 113122020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play113122021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1097ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1097ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0, 100, 0)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1097ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, 100, 0)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = arg_81_1.actors_["6045_story"].transform
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 then
				arg_81_1.var_.moveOldPos6045_story = var_84_9.localPosition

				local var_84_11 = GameObjectTools.GetOrAddComponent(var_84_9.gameObject, typeof(DynamicBoneHelper))

				if var_84_11 then
					var_84_11:EnableDynamicBone(false)
				end
			end

			local var_84_12 = 0.001

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_12 then
				local var_84_13 = (arg_81_1.time_ - var_84_10) / var_84_12
				local var_84_14 = Vector3.New(0, 100, 0)

				var_84_9.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos6045_story, var_84_14, var_84_13)

				local var_84_15 = manager.ui.mainCamera.transform.position - var_84_9.position

				var_84_9.forward = Vector3.New(var_84_15.x, var_84_15.y, var_84_15.z)

				local var_84_16 = var_84_9.localEulerAngles

				var_84_16.z = 0
				var_84_16.x = 0
				var_84_9.localEulerAngles = var_84_16
			end

			if arg_81_1.time_ >= var_84_10 + var_84_12 and arg_81_1.time_ < var_84_10 + var_84_12 + arg_84_0 then
				var_84_9.localPosition = Vector3.New(0, 100, 0)

				local var_84_17 = manager.ui.mainCamera.transform.position - var_84_9.position

				var_84_9.forward = Vector3.New(var_84_17.x, var_84_17.y, var_84_17.z)

				local var_84_18 = var_84_9.localEulerAngles

				var_84_18.z = 0
				var_84_18.x = 0
				var_84_9.localEulerAngles = var_84_18

				local var_84_19 = GameObjectTools.GetOrAddComponent(var_84_9.gameObject, typeof(DynamicBoneHelper))

				if var_84_19 then
					var_84_19:EnableDynamicBone(true)
				end
			end

			local var_84_20 = 0
			local var_84_21 = 0.325

			if var_84_20 < arg_81_1.time_ and arg_81_1.time_ <= var_84_20 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_22 = arg_81_1:GetWordFromCfg(113122020)
				local var_84_23 = arg_81_1:FormatText(var_84_22.content)

				arg_81_1.text_.text = var_84_23

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_24 = 13
				local var_84_25 = utf8.len(var_84_23)
				local var_84_26 = var_84_24 <= 0 and var_84_21 or var_84_21 * (var_84_25 / var_84_24)

				if var_84_26 > 0 and var_84_21 < var_84_26 then
					arg_81_1.talkMaxDuration = var_84_26

					if var_84_26 + var_84_20 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_26 + var_84_20
					end
				end

				arg_81_1.text_.text = var_84_23
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_27 = math.max(var_84_21, arg_81_1.talkMaxDuration)

			if var_84_20 <= arg_81_1.time_ and arg_81_1.time_ < var_84_20 + var_84_27 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_20) / var_84_27

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_20 + var_84_27 and arg_81_1.time_ < var_84_20 + var_84_27 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play113122021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 113122021
		arg_85_1.duration_ = 8.9

		local var_85_0 = {
			ja = 8.9,
			ko = 6.633,
			zh = 7.333,
			en = 6.9
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
				arg_85_0:Play113122022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1097ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1097ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1097ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = 0

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 then
				arg_85_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 then
				arg_85_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_88_11 = arg_85_1.actors_["1097ui_story"]
			local var_88_12 = 0

			if var_88_12 < arg_85_1.time_ and arg_85_1.time_ <= var_88_12 + arg_88_0 and not isNil(var_88_11) and arg_85_1.var_.characterEffect1097ui_story == nil then
				arg_85_1.var_.characterEffect1097ui_story = var_88_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_13 = 0.2

			if var_88_12 <= arg_85_1.time_ and arg_85_1.time_ < var_88_12 + var_88_13 and not isNil(var_88_11) then
				local var_88_14 = (arg_85_1.time_ - var_88_12) / var_88_13

				if arg_85_1.var_.characterEffect1097ui_story and not isNil(var_88_11) then
					arg_85_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_12 + var_88_13 and arg_85_1.time_ < var_88_12 + var_88_13 + arg_88_0 and not isNil(var_88_11) and arg_85_1.var_.characterEffect1097ui_story then
				arg_85_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_88_15 = 0
			local var_88_16 = 0.4

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_17 = arg_85_1:FormatText(StoryNameCfg[216].name)

				arg_85_1.leftNameTxt_.text = var_88_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_18 = arg_85_1:GetWordFromCfg(113122021)
				local var_88_19 = arg_85_1:FormatText(var_88_18.content)

				arg_85_1.text_.text = var_88_19

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_20 = 16
				local var_88_21 = utf8.len(var_88_19)
				local var_88_22 = var_88_20 <= 0 and var_88_16 or var_88_16 * (var_88_21 / var_88_20)

				if var_88_22 > 0 and var_88_16 < var_88_22 then
					arg_85_1.talkMaxDuration = var_88_22

					if var_88_22 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_22 + var_88_15
					end
				end

				arg_85_1.text_.text = var_88_19
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122021", "story_v_out_113122.awb") ~= 0 then
					local var_88_23 = manager.audio:GetVoiceLength("story_v_out_113122", "113122021", "story_v_out_113122.awb") / 1000

					if var_88_23 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_15
					end

					if var_88_18.prefab_name ~= "" and arg_85_1.actors_[var_88_18.prefab_name] ~= nil then
						local var_88_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_18.prefab_name].transform, "story_v_out_113122", "113122021", "story_v_out_113122.awb")

						arg_85_1:RecordAudio("113122021", var_88_24)
						arg_85_1:RecordAudio("113122021", var_88_24)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_113122", "113122021", "story_v_out_113122.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_113122", "113122021", "story_v_out_113122.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = math.max(var_88_16, arg_85_1.talkMaxDuration)

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_25 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_15) / var_88_25

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_15 + var_88_25 and arg_85_1.time_ < var_88_15 + var_88_25 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play113122022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 113122022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play113122023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1097ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1097ui_story == nil then
				arg_89_1.var_.characterEffect1097ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1097ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1097ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1097ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1097ui_story.fillRatio = var_92_5
			end

			local var_92_6 = 0
			local var_92_7 = 1.05

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(113122022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 42
				local var_92_11 = utf8.len(var_92_9)
				local var_92_12 = var_92_10 <= 0 and var_92_7 or var_92_7 * (var_92_11 / var_92_10)

				if var_92_12 > 0 and var_92_7 < var_92_12 then
					arg_89_1.talkMaxDuration = var_92_12

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_13 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_13 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_13

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_13 and arg_89_1.time_ < var_92_6 + var_92_13 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play113122023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 113122023
		arg_93_1.duration_ = 8.03

		local var_93_0 = {
			ja = 5.566,
			ko = 8.033,
			zh = 5.766,
			en = 5.9
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
				arg_93_0:Play113122024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10006ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos10006ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0.7, -0.98, -5.65)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10006ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0.7, -0.98, -5.65)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = 0

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 then
				arg_93_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action6_1")
			end

			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 then
				arg_93_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_96_11 = arg_93_1.actors_["10006ui_story"]
			local var_96_12 = 0

			if var_96_12 < arg_93_1.time_ and arg_93_1.time_ <= var_96_12 + arg_96_0 and not isNil(var_96_11) and arg_93_1.var_.characterEffect10006ui_story == nil then
				arg_93_1.var_.characterEffect10006ui_story = var_96_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_13 = 0.2

			if var_96_12 <= arg_93_1.time_ and arg_93_1.time_ < var_96_12 + var_96_13 and not isNil(var_96_11) then
				local var_96_14 = (arg_93_1.time_ - var_96_12) / var_96_13

				if arg_93_1.var_.characterEffect10006ui_story and not isNil(var_96_11) then
					arg_93_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_12 + var_96_13 and arg_93_1.time_ < var_96_12 + var_96_13 + arg_96_0 and not isNil(var_96_11) and arg_93_1.var_.characterEffect10006ui_story then
				arg_93_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_96_15 = 0
			local var_96_16 = 0.55

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_17 = arg_93_1:FormatText(StoryNameCfg[212].name)

				arg_93_1.leftNameTxt_.text = var_96_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_18 = arg_93_1:GetWordFromCfg(113122023)
				local var_96_19 = arg_93_1:FormatText(var_96_18.content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_20 = 22
				local var_96_21 = utf8.len(var_96_19)
				local var_96_22 = var_96_20 <= 0 and var_96_16 or var_96_16 * (var_96_21 / var_96_20)

				if var_96_22 > 0 and var_96_16 < var_96_22 then
					arg_93_1.talkMaxDuration = var_96_22

					if var_96_22 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_22 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_19
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122023", "story_v_out_113122.awb") ~= 0 then
					local var_96_23 = manager.audio:GetVoiceLength("story_v_out_113122", "113122023", "story_v_out_113122.awb") / 1000

					if var_96_23 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_15
					end

					if var_96_18.prefab_name ~= "" and arg_93_1.actors_[var_96_18.prefab_name] ~= nil then
						local var_96_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_18.prefab_name].transform, "story_v_out_113122", "113122023", "story_v_out_113122.awb")

						arg_93_1:RecordAudio("113122023", var_96_24)
						arg_93_1:RecordAudio("113122023", var_96_24)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_113122", "113122023", "story_v_out_113122.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_113122", "113122023", "story_v_out_113122.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_25 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_25 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_25

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_25 and arg_93_1.time_ < var_96_15 + var_96_25 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play113122024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 113122024
		arg_97_1.duration_ = 12.6

		local var_97_0 = {
			ja = 12.6,
			ko = 9.3,
			zh = 6.766,
			en = 11.7
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
				arg_97_0:Play113122025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10006ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10006ui_story == nil then
				arg_97_1.var_.characterEffect10006ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect10006ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10006ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10006ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10006ui_story.fillRatio = var_100_5
			end

			local var_100_6 = 0

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_100_7 = 0

			if var_100_7 < arg_97_1.time_ and arg_97_1.time_ <= var_100_7 + arg_100_0 then
				arg_97_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_100_8 = arg_97_1.actors_["1097ui_story"]
			local var_100_9 = 0

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.characterEffect1097ui_story == nil then
				arg_97_1.var_.characterEffect1097ui_story = var_100_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_10 = 0.2

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_10 and not isNil(var_100_8) then
				local var_100_11 = (arg_97_1.time_ - var_100_9) / var_100_10

				if arg_97_1.var_.characterEffect1097ui_story and not isNil(var_100_8) then
					arg_97_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_9 + var_100_10 and arg_97_1.time_ < var_100_9 + var_100_10 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.characterEffect1097ui_story then
				arg_97_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_100_12 = 0
			local var_100_13 = 0.75

			if var_100_12 < arg_97_1.time_ and arg_97_1.time_ <= var_100_12 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_14 = arg_97_1:FormatText(StoryNameCfg[216].name)

				arg_97_1.leftNameTxt_.text = var_100_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_15 = arg_97_1:GetWordFromCfg(113122024)
				local var_100_16 = arg_97_1:FormatText(var_100_15.content)

				arg_97_1.text_.text = var_100_16

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_17 = 30
				local var_100_18 = utf8.len(var_100_16)
				local var_100_19 = var_100_17 <= 0 and var_100_13 or var_100_13 * (var_100_18 / var_100_17)

				if var_100_19 > 0 and var_100_13 < var_100_19 then
					arg_97_1.talkMaxDuration = var_100_19

					if var_100_19 + var_100_12 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_19 + var_100_12
					end
				end

				arg_97_1.text_.text = var_100_16
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122024", "story_v_out_113122.awb") ~= 0 then
					local var_100_20 = manager.audio:GetVoiceLength("story_v_out_113122", "113122024", "story_v_out_113122.awb") / 1000

					if var_100_20 + var_100_12 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_20 + var_100_12
					end

					if var_100_15.prefab_name ~= "" and arg_97_1.actors_[var_100_15.prefab_name] ~= nil then
						local var_100_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_15.prefab_name].transform, "story_v_out_113122", "113122024", "story_v_out_113122.awb")

						arg_97_1:RecordAudio("113122024", var_100_21)
						arg_97_1:RecordAudio("113122024", var_100_21)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_113122", "113122024", "story_v_out_113122.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_113122", "113122024", "story_v_out_113122.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_22 = math.max(var_100_13, arg_97_1.talkMaxDuration)

			if var_100_12 <= arg_97_1.time_ and arg_97_1.time_ < var_100_12 + var_100_22 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_12) / var_100_22

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_12 + var_100_22 and arg_97_1.time_ < var_100_12 + var_100_22 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play113122025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 113122025
		arg_101_1.duration_ = 5.9

		local var_101_0 = {
			ja = 5.566,
			ko = 4.5,
			zh = 5.9,
			en = 5.6
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
				arg_101_0:Play113122026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["6046_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos6046_story = var_104_0.localPosition

				local var_104_2 = GameObjectTools.GetOrAddComponent(var_104_0.gameObject, typeof(DynamicBoneHelper))

				if var_104_2 then
					var_104_2:EnableDynamicBone(false)
				end
			end

			local var_104_3 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_3 then
				local var_104_4 = (arg_101_1.time_ - var_104_1) / var_104_3
				local var_104_5 = Vector3.New(0.7, -0.5, -6.3)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos6046_story, var_104_5, var_104_4)

				local var_104_6 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_6.x, var_104_6.y, var_104_6.z)

				local var_104_7 = var_104_0.localEulerAngles

				var_104_7.z = 0
				var_104_7.x = 0
				var_104_0.localEulerAngles = var_104_7
			end

			if arg_101_1.time_ >= var_104_1 + var_104_3 and arg_101_1.time_ < var_104_1 + var_104_3 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_104_8 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_8.x, var_104_8.y, var_104_8.z)

				local var_104_9 = var_104_0.localEulerAngles

				var_104_9.z = 0
				var_104_9.x = 0
				var_104_0.localEulerAngles = var_104_9

				local var_104_10 = GameObjectTools.GetOrAddComponent(var_104_0.gameObject, typeof(DynamicBoneHelper))

				if var_104_10 then
					var_104_10:EnableDynamicBone(true)
				end
			end

			local var_104_11 = 0

			if var_104_11 < arg_101_1.time_ and arg_101_1.time_ <= var_104_11 + arg_104_0 then
				arg_101_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_104_12 = 0

			if var_104_12 < arg_101_1.time_ and arg_101_1.time_ <= var_104_12 + arg_104_0 then
				arg_101_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_104_13 = arg_101_1.actors_["6046_story"]
			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 and not isNil(var_104_13) and arg_101_1.var_.characterEffect6046_story == nil then
				arg_101_1.var_.characterEffect6046_story = var_104_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_15 = 0.2

			if var_104_14 <= arg_101_1.time_ and arg_101_1.time_ < var_104_14 + var_104_15 and not isNil(var_104_13) then
				local var_104_16 = (arg_101_1.time_ - var_104_14) / var_104_15

				if arg_101_1.var_.characterEffect6046_story and not isNil(var_104_13) then
					arg_101_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_14 + var_104_15 and arg_101_1.time_ < var_104_14 + var_104_15 + arg_104_0 and not isNil(var_104_13) and arg_101_1.var_.characterEffect6046_story then
				arg_101_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_104_17 = arg_101_1.actors_["10006ui_story"].transform
			local var_104_18 = 0

			if var_104_18 < arg_101_1.time_ and arg_101_1.time_ <= var_104_18 + arg_104_0 then
				arg_101_1.var_.moveOldPos10006ui_story = var_104_17.localPosition
			end

			local var_104_19 = 0.001

			if var_104_18 <= arg_101_1.time_ and arg_101_1.time_ < var_104_18 + var_104_19 then
				local var_104_20 = (arg_101_1.time_ - var_104_18) / var_104_19
				local var_104_21 = Vector3.New(0, 100, 0)

				var_104_17.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10006ui_story, var_104_21, var_104_20)

				local var_104_22 = manager.ui.mainCamera.transform.position - var_104_17.position

				var_104_17.forward = Vector3.New(var_104_22.x, var_104_22.y, var_104_22.z)

				local var_104_23 = var_104_17.localEulerAngles

				var_104_23.z = 0
				var_104_23.x = 0
				var_104_17.localEulerAngles = var_104_23
			end

			if arg_101_1.time_ >= var_104_18 + var_104_19 and arg_101_1.time_ < var_104_18 + var_104_19 + arg_104_0 then
				var_104_17.localPosition = Vector3.New(0, 100, 0)

				local var_104_24 = manager.ui.mainCamera.transform.position - var_104_17.position

				var_104_17.forward = Vector3.New(var_104_24.x, var_104_24.y, var_104_24.z)

				local var_104_25 = var_104_17.localEulerAngles

				var_104_25.z = 0
				var_104_25.x = 0
				var_104_17.localEulerAngles = var_104_25
			end

			local var_104_26 = arg_101_1.actors_["1097ui_story"]
			local var_104_27 = 0

			if var_104_27 < arg_101_1.time_ and arg_101_1.time_ <= var_104_27 + arg_104_0 and not isNil(var_104_26) and arg_101_1.var_.characterEffect1097ui_story == nil then
				arg_101_1.var_.characterEffect1097ui_story = var_104_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_28 = 0.2

			if var_104_27 <= arg_101_1.time_ and arg_101_1.time_ < var_104_27 + var_104_28 and not isNil(var_104_26) then
				local var_104_29 = (arg_101_1.time_ - var_104_27) / var_104_28

				if arg_101_1.var_.characterEffect1097ui_story and not isNil(var_104_26) then
					local var_104_30 = Mathf.Lerp(0, 0.5, var_104_29)

					arg_101_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1097ui_story.fillRatio = var_104_30
				end
			end

			if arg_101_1.time_ >= var_104_27 + var_104_28 and arg_101_1.time_ < var_104_27 + var_104_28 + arg_104_0 and not isNil(var_104_26) and arg_101_1.var_.characterEffect1097ui_story then
				local var_104_31 = 0.5

				arg_101_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1097ui_story.fillRatio = var_104_31
			end

			local var_104_32 = 0
			local var_104_33 = 0.5

			if var_104_32 < arg_101_1.time_ and arg_101_1.time_ <= var_104_32 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_34 = arg_101_1:FormatText(StoryNameCfg[214].name)

				arg_101_1.leftNameTxt_.text = var_104_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_35 = arg_101_1:GetWordFromCfg(113122025)
				local var_104_36 = arg_101_1:FormatText(var_104_35.content)

				arg_101_1.text_.text = var_104_36

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_37 = 20
				local var_104_38 = utf8.len(var_104_36)
				local var_104_39 = var_104_37 <= 0 and var_104_33 or var_104_33 * (var_104_38 / var_104_37)

				if var_104_39 > 0 and var_104_33 < var_104_39 then
					arg_101_1.talkMaxDuration = var_104_39

					if var_104_39 + var_104_32 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_39 + var_104_32
					end
				end

				arg_101_1.text_.text = var_104_36
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122025", "story_v_out_113122.awb") ~= 0 then
					local var_104_40 = manager.audio:GetVoiceLength("story_v_out_113122", "113122025", "story_v_out_113122.awb") / 1000

					if var_104_40 + var_104_32 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_40 + var_104_32
					end

					if var_104_35.prefab_name ~= "" and arg_101_1.actors_[var_104_35.prefab_name] ~= nil then
						local var_104_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_35.prefab_name].transform, "story_v_out_113122", "113122025", "story_v_out_113122.awb")

						arg_101_1:RecordAudio("113122025", var_104_41)
						arg_101_1:RecordAudio("113122025", var_104_41)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_113122", "113122025", "story_v_out_113122.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_113122", "113122025", "story_v_out_113122.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_42 = math.max(var_104_33, arg_101_1.talkMaxDuration)

			if var_104_32 <= arg_101_1.time_ and arg_101_1.time_ < var_104_32 + var_104_42 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_32) / var_104_42

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_32 + var_104_42 and arg_101_1.time_ < var_104_32 + var_104_42 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play113122026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 113122026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play113122027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["6046_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos6046_story = var_108_0.localPosition

				local var_108_2 = GameObjectTools.GetOrAddComponent(var_108_0.gameObject, typeof(DynamicBoneHelper))

				if var_108_2 then
					var_108_2:EnableDynamicBone(false)
				end
			end

			local var_108_3 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_3 then
				local var_108_4 = (arg_105_1.time_ - var_108_1) / var_108_3
				local var_108_5 = Vector3.New(0, 100, 0)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos6046_story, var_108_5, var_108_4)

				local var_108_6 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_6.x, var_108_6.y, var_108_6.z)

				local var_108_7 = var_108_0.localEulerAngles

				var_108_7.z = 0
				var_108_7.x = 0
				var_108_0.localEulerAngles = var_108_7
			end

			if arg_105_1.time_ >= var_108_1 + var_108_3 and arg_105_1.time_ < var_108_1 + var_108_3 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, 100, 0)

				local var_108_8 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_8.x, var_108_8.y, var_108_8.z)

				local var_108_9 = var_108_0.localEulerAngles

				var_108_9.z = 0
				var_108_9.x = 0
				var_108_0.localEulerAngles = var_108_9

				local var_108_10 = GameObjectTools.GetOrAddComponent(var_108_0.gameObject, typeof(DynamicBoneHelper))

				if var_108_10 then
					var_108_10:EnableDynamicBone(true)
				end
			end

			local var_108_11 = arg_105_1.actors_["1097ui_story"].transform
			local var_108_12 = 0

			if var_108_12 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				arg_105_1.var_.moveOldPos1097ui_story = var_108_11.localPosition
			end

			local var_108_13 = 0.001

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_13 then
				local var_108_14 = (arg_105_1.time_ - var_108_12) / var_108_13
				local var_108_15 = Vector3.New(0, 100, 0)

				var_108_11.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1097ui_story, var_108_15, var_108_14)

				local var_108_16 = manager.ui.mainCamera.transform.position - var_108_11.position

				var_108_11.forward = Vector3.New(var_108_16.x, var_108_16.y, var_108_16.z)

				local var_108_17 = var_108_11.localEulerAngles

				var_108_17.z = 0
				var_108_17.x = 0
				var_108_11.localEulerAngles = var_108_17
			end

			if arg_105_1.time_ >= var_108_12 + var_108_13 and arg_105_1.time_ < var_108_12 + var_108_13 + arg_108_0 then
				var_108_11.localPosition = Vector3.New(0, 100, 0)

				local var_108_18 = manager.ui.mainCamera.transform.position - var_108_11.position

				var_108_11.forward = Vector3.New(var_108_18.x, var_108_18.y, var_108_18.z)

				local var_108_19 = var_108_11.localEulerAngles

				var_108_19.z = 0
				var_108_19.x = 0
				var_108_11.localEulerAngles = var_108_19
			end

			local var_108_20 = 0
			local var_108_21 = 0.6

			if var_108_20 < arg_105_1.time_ and arg_105_1.time_ <= var_108_20 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_22 = arg_105_1:GetWordFromCfg(113122026)
				local var_108_23 = arg_105_1:FormatText(var_108_22.content)

				arg_105_1.text_.text = var_108_23

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_24 = 24
				local var_108_25 = utf8.len(var_108_23)
				local var_108_26 = var_108_24 <= 0 and var_108_21 or var_108_21 * (var_108_25 / var_108_24)

				if var_108_26 > 0 and var_108_21 < var_108_26 then
					arg_105_1.talkMaxDuration = var_108_26

					if var_108_26 + var_108_20 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_26 + var_108_20
					end
				end

				arg_105_1.text_.text = var_108_23
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_27 = math.max(var_108_21, arg_105_1.talkMaxDuration)

			if var_108_20 <= arg_105_1.time_ and arg_105_1.time_ < var_108_20 + var_108_27 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_20) / var_108_27

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_20 + var_108_27 and arg_105_1.time_ < var_108_20 + var_108_27 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play113122027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 113122027
		arg_109_1.duration_ = 8.67

		local var_109_0 = {
			ja = 8.266,
			ko = 5.366,
			zh = 7.566,
			en = 8.666
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
				arg_109_0:Play113122028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["6046_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos6046_story = var_112_0.localPosition

				local var_112_2 = GameObjectTools.GetOrAddComponent(var_112_0.gameObject, typeof(DynamicBoneHelper))

				if var_112_2 then
					var_112_2:EnableDynamicBone(false)
				end
			end

			local var_112_3 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_3 then
				local var_112_4 = (arg_109_1.time_ - var_112_1) / var_112_3
				local var_112_5 = Vector3.New(-0.7, -0.5, -6.3)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos6046_story, var_112_5, var_112_4)

				local var_112_6 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_6.x, var_112_6.y, var_112_6.z)

				local var_112_7 = var_112_0.localEulerAngles

				var_112_7.z = 0
				var_112_7.x = 0
				var_112_0.localEulerAngles = var_112_7
			end

			if arg_109_1.time_ >= var_112_1 + var_112_3 and arg_109_1.time_ < var_112_1 + var_112_3 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_112_8 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_8.x, var_112_8.y, var_112_8.z)

				local var_112_9 = var_112_0.localEulerAngles

				var_112_9.z = 0
				var_112_9.x = 0
				var_112_0.localEulerAngles = var_112_9

				local var_112_10 = GameObjectTools.GetOrAddComponent(var_112_0.gameObject, typeof(DynamicBoneHelper))

				if var_112_10 then
					var_112_10:EnableDynamicBone(true)
				end
			end

			local var_112_11 = 0

			if var_112_11 < arg_109_1.time_ and arg_109_1.time_ <= var_112_11 + arg_112_0 then
				arg_109_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_112_12 = 0

			if var_112_12 < arg_109_1.time_ and arg_109_1.time_ <= var_112_12 + arg_112_0 then
				arg_109_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_112_13 = arg_109_1.actors_["6046_story"]
			local var_112_14 = 0

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 and not isNil(var_112_13) and arg_109_1.var_.characterEffect6046_story == nil then
				arg_109_1.var_.characterEffect6046_story = var_112_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_15 = 0.2

			if var_112_14 <= arg_109_1.time_ and arg_109_1.time_ < var_112_14 + var_112_15 and not isNil(var_112_13) then
				local var_112_16 = (arg_109_1.time_ - var_112_14) / var_112_15

				if arg_109_1.var_.characterEffect6046_story and not isNil(var_112_13) then
					arg_109_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_14 + var_112_15 and arg_109_1.time_ < var_112_14 + var_112_15 + arg_112_0 and not isNil(var_112_13) and arg_109_1.var_.characterEffect6046_story then
				arg_109_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_112_17 = 0
			local var_112_18 = 0.75

			if var_112_17 < arg_109_1.time_ and arg_109_1.time_ <= var_112_17 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_19 = arg_109_1:FormatText(StoryNameCfg[214].name)

				arg_109_1.leftNameTxt_.text = var_112_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_20 = arg_109_1:GetWordFromCfg(113122027)
				local var_112_21 = arg_109_1:FormatText(var_112_20.content)

				arg_109_1.text_.text = var_112_21

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_22 = 30
				local var_112_23 = utf8.len(var_112_21)
				local var_112_24 = var_112_22 <= 0 and var_112_18 or var_112_18 * (var_112_23 / var_112_22)

				if var_112_24 > 0 and var_112_18 < var_112_24 then
					arg_109_1.talkMaxDuration = var_112_24

					if var_112_24 + var_112_17 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_24 + var_112_17
					end
				end

				arg_109_1.text_.text = var_112_21
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122027", "story_v_out_113122.awb") ~= 0 then
					local var_112_25 = manager.audio:GetVoiceLength("story_v_out_113122", "113122027", "story_v_out_113122.awb") / 1000

					if var_112_25 + var_112_17 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_25 + var_112_17
					end

					if var_112_20.prefab_name ~= "" and arg_109_1.actors_[var_112_20.prefab_name] ~= nil then
						local var_112_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_20.prefab_name].transform, "story_v_out_113122", "113122027", "story_v_out_113122.awb")

						arg_109_1:RecordAudio("113122027", var_112_26)
						arg_109_1:RecordAudio("113122027", var_112_26)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_113122", "113122027", "story_v_out_113122.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_113122", "113122027", "story_v_out_113122.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_27 = math.max(var_112_18, arg_109_1.talkMaxDuration)

			if var_112_17 <= arg_109_1.time_ and arg_109_1.time_ < var_112_17 + var_112_27 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_17) / var_112_27

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_17 + var_112_27 and arg_109_1.time_ < var_112_17 + var_112_27 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play113122028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 113122028
		arg_113_1.duration_ = 2.43

		local var_113_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.433,
			en = 1.999999999999
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
				arg_113_0:Play113122029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10006ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos10006ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0.7, -0.98, -5.65)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10006ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0.7, -0.98, -5.65)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = 0

			if var_116_9 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 then
				arg_113_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action1_1")
			end

			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 then
				arg_113_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_116_11 = arg_113_1.actors_["10006ui_story"]
			local var_116_12 = 0

			if var_116_12 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 and not isNil(var_116_11) and arg_113_1.var_.characterEffect10006ui_story == nil then
				arg_113_1.var_.characterEffect10006ui_story = var_116_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_13 = 0.2

			if var_116_12 <= arg_113_1.time_ and arg_113_1.time_ < var_116_12 + var_116_13 and not isNil(var_116_11) then
				local var_116_14 = (arg_113_1.time_ - var_116_12) / var_116_13

				if arg_113_1.var_.characterEffect10006ui_story and not isNil(var_116_11) then
					arg_113_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_12 + var_116_13 and arg_113_1.time_ < var_116_12 + var_116_13 + arg_116_0 and not isNil(var_116_11) and arg_113_1.var_.characterEffect10006ui_story then
				arg_113_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_116_15 = arg_113_1.actors_["6046_story"]
			local var_116_16 = 0

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 and not isNil(var_116_15) and arg_113_1.var_.characterEffect6046_story == nil then
				arg_113_1.var_.characterEffect6046_story = var_116_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_17 = 0.2

			if var_116_16 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_17 and not isNil(var_116_15) then
				local var_116_18 = (arg_113_1.time_ - var_116_16) / var_116_17

				if arg_113_1.var_.characterEffect6046_story and not isNil(var_116_15) then
					local var_116_19 = Mathf.Lerp(0, 0.5, var_116_18)

					arg_113_1.var_.characterEffect6046_story.fillFlat = true
					arg_113_1.var_.characterEffect6046_story.fillRatio = var_116_19
				end
			end

			if arg_113_1.time_ >= var_116_16 + var_116_17 and arg_113_1.time_ < var_116_16 + var_116_17 + arg_116_0 and not isNil(var_116_15) and arg_113_1.var_.characterEffect6046_story then
				local var_116_20 = 0.5

				arg_113_1.var_.characterEffect6046_story.fillFlat = true
				arg_113_1.var_.characterEffect6046_story.fillRatio = var_116_20
			end

			local var_116_21 = 0
			local var_116_22 = 0.1

			if var_116_21 < arg_113_1.time_ and arg_113_1.time_ <= var_116_21 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_23 = arg_113_1:FormatText(StoryNameCfg[212].name)

				arg_113_1.leftNameTxt_.text = var_116_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_24 = arg_113_1:GetWordFromCfg(113122028)
				local var_116_25 = arg_113_1:FormatText(var_116_24.content)

				arg_113_1.text_.text = var_116_25

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_26 = 4
				local var_116_27 = utf8.len(var_116_25)
				local var_116_28 = var_116_26 <= 0 and var_116_22 or var_116_22 * (var_116_27 / var_116_26)

				if var_116_28 > 0 and var_116_22 < var_116_28 then
					arg_113_1.talkMaxDuration = var_116_28

					if var_116_28 + var_116_21 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_28 + var_116_21
					end
				end

				arg_113_1.text_.text = var_116_25
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122028", "story_v_out_113122.awb") ~= 0 then
					local var_116_29 = manager.audio:GetVoiceLength("story_v_out_113122", "113122028", "story_v_out_113122.awb") / 1000

					if var_116_29 + var_116_21 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_29 + var_116_21
					end

					if var_116_24.prefab_name ~= "" and arg_113_1.actors_[var_116_24.prefab_name] ~= nil then
						local var_116_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_24.prefab_name].transform, "story_v_out_113122", "113122028", "story_v_out_113122.awb")

						arg_113_1:RecordAudio("113122028", var_116_30)
						arg_113_1:RecordAudio("113122028", var_116_30)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_113122", "113122028", "story_v_out_113122.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_113122", "113122028", "story_v_out_113122.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_31 = math.max(var_116_22, arg_113_1.talkMaxDuration)

			if var_116_21 <= arg_113_1.time_ and arg_113_1.time_ < var_116_21 + var_116_31 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_21) / var_116_31

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_21 + var_116_31 and arg_113_1.time_ < var_116_21 + var_116_31 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play113122029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 113122029
		arg_117_1.duration_ = 6.87

		local var_117_0 = {
			ja = 2.833,
			ko = 1.4,
			zh = 6.866,
			en = 4.066
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
				arg_117_0:Play113122030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10006ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect10006ui_story == nil then
				arg_117_1.var_.characterEffect10006ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.2

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect10006ui_story and not isNil(var_120_0) then
					local var_120_4 = Mathf.Lerp(0, 0.5, var_120_3)

					arg_117_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10006ui_story.fillRatio = var_120_4
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect10006ui_story then
				local var_120_5 = 0.5

				arg_117_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10006ui_story.fillRatio = var_120_5
			end

			local var_120_6 = 0
			local var_120_7 = 0.475

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_8 = arg_117_1:FormatText(StoryNameCfg[36].name)

				arg_117_1.leftNameTxt_.text = var_120_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_9 = arg_117_1:GetWordFromCfg(113122029)
				local var_120_10 = arg_117_1:FormatText(var_120_9.content)

				arg_117_1.text_.text = var_120_10

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 18
				local var_120_12 = utf8.len(var_120_10)
				local var_120_13 = var_120_11 <= 0 and var_120_7 or var_120_7 * (var_120_12 / var_120_11)

				if var_120_13 > 0 and var_120_7 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_10
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122029", "story_v_out_113122.awb") ~= 0 then
					local var_120_14 = manager.audio:GetVoiceLength("story_v_out_113122", "113122029", "story_v_out_113122.awb") / 1000

					if var_120_14 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_14 + var_120_6
					end

					if var_120_9.prefab_name ~= "" and arg_117_1.actors_[var_120_9.prefab_name] ~= nil then
						local var_120_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_9.prefab_name].transform, "story_v_out_113122", "113122029", "story_v_out_113122.awb")

						arg_117_1:RecordAudio("113122029", var_120_15)
						arg_117_1:RecordAudio("113122029", var_120_15)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_113122", "113122029", "story_v_out_113122.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_113122", "113122029", "story_v_out_113122.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_16 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_16 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_16

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_16 and arg_117_1.time_ < var_120_6 + var_120_16 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play113122030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 113122030
		arg_121_1.duration_ = 15.7

		local var_121_0 = {
			ja = 15.7,
			ko = 11.2,
			zh = 7.466,
			en = 12.133
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
				arg_121_0:Play113122031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action6_1")
			end

			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_124_2 = arg_121_1.actors_["10006ui_story"]
			local var_124_3 = 0

			if var_124_3 < arg_121_1.time_ and arg_121_1.time_ <= var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect10006ui_story == nil then
				arg_121_1.var_.characterEffect10006ui_story = var_124_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_4 = 0.2

			if var_124_3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_3 + var_124_4 and not isNil(var_124_2) then
				local var_124_5 = (arg_121_1.time_ - var_124_3) / var_124_4

				if arg_121_1.var_.characterEffect10006ui_story and not isNil(var_124_2) then
					arg_121_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_3 + var_124_4 and arg_121_1.time_ < var_124_3 + var_124_4 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect10006ui_story then
				arg_121_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_124_6 = 0
			local var_124_7 = 1

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_8 = arg_121_1:FormatText(StoryNameCfg[212].name)

				arg_121_1.leftNameTxt_.text = var_124_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_9 = arg_121_1:GetWordFromCfg(113122030)
				local var_124_10 = arg_121_1:FormatText(var_124_9.content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122030", "story_v_out_113122.awb") ~= 0 then
					local var_124_14 = manager.audio:GetVoiceLength("story_v_out_113122", "113122030", "story_v_out_113122.awb") / 1000

					if var_124_14 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_6
					end

					if var_124_9.prefab_name ~= "" and arg_121_1.actors_[var_124_9.prefab_name] ~= nil then
						local var_124_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_9.prefab_name].transform, "story_v_out_113122", "113122030", "story_v_out_113122.awb")

						arg_121_1:RecordAudio("113122030", var_124_15)
						arg_121_1:RecordAudio("113122030", var_124_15)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_113122", "113122030", "story_v_out_113122.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_113122", "113122030", "story_v_out_113122.awb")
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
	Play113122031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 113122031
		arg_125_1.duration_ = 10.73

		local var_125_0 = {
			ja = 10.733,
			ko = 6.666,
			zh = 4.966,
			en = 6.066
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
				arg_125_0:Play113122032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_128_1 = 0
			local var_128_2 = 0.65

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_3 = arg_125_1:FormatText(StoryNameCfg[212].name)

				arg_125_1.leftNameTxt_.text = var_128_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_4 = arg_125_1:GetWordFromCfg(113122031)
				local var_128_5 = arg_125_1:FormatText(var_128_4.content)

				arg_125_1.text_.text = var_128_5

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_6 = 26
				local var_128_7 = utf8.len(var_128_5)
				local var_128_8 = var_128_6 <= 0 and var_128_2 or var_128_2 * (var_128_7 / var_128_6)

				if var_128_8 > 0 and var_128_2 < var_128_8 then
					arg_125_1.talkMaxDuration = var_128_8

					if var_128_8 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_1
					end
				end

				arg_125_1.text_.text = var_128_5
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122031", "story_v_out_113122.awb") ~= 0 then
					local var_128_9 = manager.audio:GetVoiceLength("story_v_out_113122", "113122031", "story_v_out_113122.awb") / 1000

					if var_128_9 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_1
					end

					if var_128_4.prefab_name ~= "" and arg_125_1.actors_[var_128_4.prefab_name] ~= nil then
						local var_128_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_4.prefab_name].transform, "story_v_out_113122", "113122031", "story_v_out_113122.awb")

						arg_125_1:RecordAudio("113122031", var_128_10)
						arg_125_1:RecordAudio("113122031", var_128_10)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_113122", "113122031", "story_v_out_113122.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_113122", "113122031", "story_v_out_113122.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_11 = math.max(var_128_2, arg_125_1.talkMaxDuration)

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_11 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_1) / var_128_11

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_1 + var_128_11 and arg_125_1.time_ < var_128_1 + var_128_11 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play113122032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 113122032
		arg_129_1.duration_ = 1.83

		local var_129_0 = {
			ja = 1.666,
			ko = 1.266,
			zh = 1.6,
			en = 1.833
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
				arg_129_0:Play113122033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10006ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10006ui_story == nil then
				arg_129_1.var_.characterEffect10006ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.2

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect10006ui_story and not isNil(var_132_0) then
					local var_132_4 = Mathf.Lerp(0, 0.5, var_132_3)

					arg_129_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10006ui_story.fillRatio = var_132_4
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10006ui_story then
				local var_132_5 = 0.5

				arg_129_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10006ui_story.fillRatio = var_132_5
			end

			local var_132_6 = 0
			local var_132_7 = 0.075

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_8 = arg_129_1:FormatText(StoryNameCfg[216].name)

				arg_129_1.leftNameTxt_.text = var_132_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_9 = arg_129_1:GetWordFromCfg(113122032)
				local var_132_10 = arg_129_1:FormatText(var_132_9.content)

				arg_129_1.text_.text = var_132_10

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 3
				local var_132_12 = utf8.len(var_132_10)
				local var_132_13 = var_132_11 <= 0 and var_132_7 or var_132_7 * (var_132_12 / var_132_11)

				if var_132_13 > 0 and var_132_7 < var_132_13 then
					arg_129_1.talkMaxDuration = var_132_13

					if var_132_13 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_10
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122032", "story_v_out_113122.awb") ~= 0 then
					local var_132_14 = manager.audio:GetVoiceLength("story_v_out_113122", "113122032", "story_v_out_113122.awb") / 1000

					if var_132_14 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_14 + var_132_6
					end

					if var_132_9.prefab_name ~= "" and arg_129_1.actors_[var_132_9.prefab_name] ~= nil then
						local var_132_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_9.prefab_name].transform, "story_v_out_113122", "113122032", "story_v_out_113122.awb")

						arg_129_1:RecordAudio("113122032", var_132_15)
						arg_129_1:RecordAudio("113122032", var_132_15)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_113122", "113122032", "story_v_out_113122.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_113122", "113122032", "story_v_out_113122.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_16 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_16 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_16

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_16 and arg_129_1.time_ < var_132_6 + var_132_16 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play113122033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 113122033
		arg_133_1.duration_ = 11.1

		local var_133_0 = {
			ja = 11.1,
			ko = 8.8,
			zh = 7.9,
			en = 5.7
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
				arg_133_0:Play113122034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046actionlink/6046action442")
			end

			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_136_2 = arg_133_1.actors_["6046_story"]
			local var_136_3 = 0

			if var_136_3 < arg_133_1.time_ and arg_133_1.time_ <= var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect6046_story == nil then
				arg_133_1.var_.characterEffect6046_story = var_136_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_4 = 0.2

			if var_136_3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_3 + var_136_4 and not isNil(var_136_2) then
				local var_136_5 = (arg_133_1.time_ - var_136_3) / var_136_4

				if arg_133_1.var_.characterEffect6046_story and not isNil(var_136_2) then
					arg_133_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_3 + var_136_4 and arg_133_1.time_ < var_136_3 + var_136_4 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect6046_story then
				arg_133_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_136_6 = 0
			local var_136_7 = 0.775

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_8 = arg_133_1:FormatText(StoryNameCfg[214].name)

				arg_133_1.leftNameTxt_.text = var_136_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_9 = arg_133_1:GetWordFromCfg(113122033)
				local var_136_10 = arg_133_1:FormatText(var_136_9.content)

				arg_133_1.text_.text = var_136_10

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122033", "story_v_out_113122.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_out_113122", "113122033", "story_v_out_113122.awb") / 1000

					if var_136_14 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_6
					end

					if var_136_9.prefab_name ~= "" and arg_133_1.actors_[var_136_9.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_9.prefab_name].transform, "story_v_out_113122", "113122033", "story_v_out_113122.awb")

						arg_133_1:RecordAudio("113122033", var_136_15)
						arg_133_1:RecordAudio("113122033", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_113122", "113122033", "story_v_out_113122.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_113122", "113122033", "story_v_out_113122.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_16 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_16 and arg_133_1.time_ < var_136_6 + var_136_16 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play113122034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 113122034
		arg_137_1.duration_ = 20.5

		local var_137_0 = {
			ja = 20.133,
			ko = 14.433,
			zh = 10.9,
			en = 20.5
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
				arg_137_0:Play113122035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["6046_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect6046_story == nil then
				arg_137_1.var_.characterEffect6046_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect6046_story and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect6046_story.fillFlat = true
					arg_137_1.var_.characterEffect6046_story.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect6046_story then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect6046_story.fillFlat = true
				arg_137_1.var_.characterEffect6046_story.fillRatio = var_140_5
			end

			local var_140_6 = 0

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006actionlink/10006action464")
			end

			local var_140_7 = 0

			if var_140_7 < arg_137_1.time_ and arg_137_1.time_ <= var_140_7 + arg_140_0 then
				arg_137_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_140_8 = arg_137_1.actors_["10006ui_story"]
			local var_140_9 = 0

			if var_140_9 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 and not isNil(var_140_8) and arg_137_1.var_.characterEffect10006ui_story == nil then
				arg_137_1.var_.characterEffect10006ui_story = var_140_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_10 = 0.2

			if var_140_9 <= arg_137_1.time_ and arg_137_1.time_ < var_140_9 + var_140_10 and not isNil(var_140_8) then
				local var_140_11 = (arg_137_1.time_ - var_140_9) / var_140_10

				if arg_137_1.var_.characterEffect10006ui_story and not isNil(var_140_8) then
					arg_137_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_9 + var_140_10 and arg_137_1.time_ < var_140_9 + var_140_10 + arg_140_0 and not isNil(var_140_8) and arg_137_1.var_.characterEffect10006ui_story then
				arg_137_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_140_12 = 0
			local var_140_13 = 1.275

			if var_140_12 < arg_137_1.time_ and arg_137_1.time_ <= var_140_12 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_14 = arg_137_1:FormatText(StoryNameCfg[212].name)

				arg_137_1.leftNameTxt_.text = var_140_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_15 = arg_137_1:GetWordFromCfg(113122034)
				local var_140_16 = arg_137_1:FormatText(var_140_15.content)

				arg_137_1.text_.text = var_140_16

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_17 = 51
				local var_140_18 = utf8.len(var_140_16)
				local var_140_19 = var_140_17 <= 0 and var_140_13 or var_140_13 * (var_140_18 / var_140_17)

				if var_140_19 > 0 and var_140_13 < var_140_19 then
					arg_137_1.talkMaxDuration = var_140_19

					if var_140_19 + var_140_12 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_19 + var_140_12
					end
				end

				arg_137_1.text_.text = var_140_16
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122034", "story_v_out_113122.awb") ~= 0 then
					local var_140_20 = manager.audio:GetVoiceLength("story_v_out_113122", "113122034", "story_v_out_113122.awb") / 1000

					if var_140_20 + var_140_12 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_20 + var_140_12
					end

					if var_140_15.prefab_name ~= "" and arg_137_1.actors_[var_140_15.prefab_name] ~= nil then
						local var_140_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_15.prefab_name].transform, "story_v_out_113122", "113122034", "story_v_out_113122.awb")

						arg_137_1:RecordAudio("113122034", var_140_21)
						arg_137_1:RecordAudio("113122034", var_140_21)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_113122", "113122034", "story_v_out_113122.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_113122", "113122034", "story_v_out_113122.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_22 = math.max(var_140_13, arg_137_1.talkMaxDuration)

			if var_140_12 <= arg_137_1.time_ and arg_137_1.time_ < var_140_12 + var_140_22 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_12) / var_140_22

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_12 + var_140_22 and arg_137_1.time_ < var_140_12 + var_140_22 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play113122035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 113122035
		arg_141_1.duration_ = 4.43

		local var_141_0 = {
			ja = 4.433,
			ko = 3.3,
			zh = 3.966,
			en = 3.266
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
				arg_141_0:Play113122036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10006ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10006ui_story == nil then
				arg_141_1.var_.characterEffect10006ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.2

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect10006ui_story and not isNil(var_144_0) then
					local var_144_4 = Mathf.Lerp(0, 0.5, var_144_3)

					arg_141_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10006ui_story.fillRatio = var_144_4
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10006ui_story then
				local var_144_5 = 0.5

				arg_141_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10006ui_story.fillRatio = var_144_5
			end

			local var_144_6 = 0

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action2_2")
			end

			local var_144_7 = 0

			if var_144_7 < arg_141_1.time_ and arg_141_1.time_ <= var_144_7 + arg_144_0 then
				arg_141_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_144_8 = arg_141_1.actors_["6046_story"]
			local var_144_9 = 0

			if var_144_9 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.characterEffect6046_story == nil then
				arg_141_1.var_.characterEffect6046_story = var_144_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_10 = 0.2

			if var_144_9 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_10 and not isNil(var_144_8) then
				local var_144_11 = (arg_141_1.time_ - var_144_9) / var_144_10

				if arg_141_1.var_.characterEffect6046_story and not isNil(var_144_8) then
					arg_141_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_9 + var_144_10 and arg_141_1.time_ < var_144_9 + var_144_10 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.characterEffect6046_story then
				arg_141_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_144_12 = 0

			if var_144_12 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 then
				arg_141_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action4_2")
			end

			local var_144_13 = 0
			local var_144_14 = 0.375

			if var_144_13 < arg_141_1.time_ and arg_141_1.time_ <= var_144_13 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_15 = arg_141_1:FormatText(StoryNameCfg[214].name)

				arg_141_1.leftNameTxt_.text = var_144_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_16 = arg_141_1:GetWordFromCfg(113122035)
				local var_144_17 = arg_141_1:FormatText(var_144_16.content)

				arg_141_1.text_.text = var_144_17

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_18 = 15
				local var_144_19 = utf8.len(var_144_17)
				local var_144_20 = var_144_18 <= 0 and var_144_14 or var_144_14 * (var_144_19 / var_144_18)

				if var_144_20 > 0 and var_144_14 < var_144_20 then
					arg_141_1.talkMaxDuration = var_144_20

					if var_144_20 + var_144_13 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_20 + var_144_13
					end
				end

				arg_141_1.text_.text = var_144_17
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122035", "story_v_out_113122.awb") ~= 0 then
					local var_144_21 = manager.audio:GetVoiceLength("story_v_out_113122", "113122035", "story_v_out_113122.awb") / 1000

					if var_144_21 + var_144_13 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_21 + var_144_13
					end

					if var_144_16.prefab_name ~= "" and arg_141_1.actors_[var_144_16.prefab_name] ~= nil then
						local var_144_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_16.prefab_name].transform, "story_v_out_113122", "113122035", "story_v_out_113122.awb")

						arg_141_1:RecordAudio("113122035", var_144_22)
						arg_141_1:RecordAudio("113122035", var_144_22)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_113122", "113122035", "story_v_out_113122.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_113122", "113122035", "story_v_out_113122.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_23 = math.max(var_144_14, arg_141_1.talkMaxDuration)

			if var_144_13 <= arg_141_1.time_ and arg_141_1.time_ < var_144_13 + var_144_23 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_13) / var_144_23

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_13 + var_144_23 and arg_141_1.time_ < var_144_13 + var_144_23 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play113122036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 113122036
		arg_145_1.duration_ = 5.37

		local var_145_0 = {
			ja = 5.366,
			ko = 4.6,
			zh = 5.166,
			en = 4
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
				arg_145_0:Play113122037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["6046_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect6046_story == nil then
				arg_145_1.var_.characterEffect6046_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.2

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect6046_story and not isNil(var_148_0) then
					local var_148_4 = Mathf.Lerp(0, 0.5, var_148_3)

					arg_145_1.var_.characterEffect6046_story.fillFlat = true
					arg_145_1.var_.characterEffect6046_story.fillRatio = var_148_4
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect6046_story then
				local var_148_5 = 0.5

				arg_145_1.var_.characterEffect6046_story.fillFlat = true
				arg_145_1.var_.characterEffect6046_story.fillRatio = var_148_5
			end

			local var_148_6 = 0
			local var_148_7 = 0.275

			if var_148_6 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_8 = arg_145_1:FormatText(StoryNameCfg[215].name)

				arg_145_1.leftNameTxt_.text = var_148_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6045")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_9 = arg_145_1:GetWordFromCfg(113122036)
				local var_148_10 = arg_145_1:FormatText(var_148_9.content)

				arg_145_1.text_.text = var_148_10

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_11 = 11
				local var_148_12 = utf8.len(var_148_10)
				local var_148_13 = var_148_11 <= 0 and var_148_7 or var_148_7 * (var_148_12 / var_148_11)

				if var_148_13 > 0 and var_148_7 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13

					if var_148_13 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_6
					end
				end

				arg_145_1.text_.text = var_148_10
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122036", "story_v_out_113122.awb") ~= 0 then
					local var_148_14 = manager.audio:GetVoiceLength("story_v_out_113122", "113122036", "story_v_out_113122.awb") / 1000

					if var_148_14 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_14 + var_148_6
					end

					if var_148_9.prefab_name ~= "" and arg_145_1.actors_[var_148_9.prefab_name] ~= nil then
						local var_148_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_9.prefab_name].transform, "story_v_out_113122", "113122036", "story_v_out_113122.awb")

						arg_145_1:RecordAudio("113122036", var_148_15)
						arg_145_1:RecordAudio("113122036", var_148_15)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_113122", "113122036", "story_v_out_113122.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_113122", "113122036", "story_v_out_113122.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_16 = math.max(var_148_7, arg_145_1.talkMaxDuration)

			if var_148_6 <= arg_145_1.time_ and arg_145_1.time_ < var_148_6 + var_148_16 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_6) / var_148_16

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_6 + var_148_16 and arg_145_1.time_ < var_148_6 + var_148_16 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play113122037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 113122037
		arg_149_1.duration_ = 4.73

		local var_149_0 = {
			ja = 3.6,
			ko = 3.5,
			zh = 4.733,
			en = 3.5
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
				arg_149_0:Play113122038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_152_2 = arg_149_1.actors_["6046_story"]
			local var_152_3 = 0

			if var_152_3 < arg_149_1.time_ and arg_149_1.time_ <= var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect6046_story == nil then
				arg_149_1.var_.characterEffect6046_story = var_152_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_4 = 0.2

			if var_152_3 <= arg_149_1.time_ and arg_149_1.time_ < var_152_3 + var_152_4 and not isNil(var_152_2) then
				local var_152_5 = (arg_149_1.time_ - var_152_3) / var_152_4

				if arg_149_1.var_.characterEffect6046_story and not isNil(var_152_2) then
					arg_149_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_3 + var_152_4 and arg_149_1.time_ < var_152_3 + var_152_4 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect6046_story then
				arg_149_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_152_6 = 0
			local var_152_7 = 0.3

			if var_152_6 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_8 = arg_149_1:FormatText(StoryNameCfg[214].name)

				arg_149_1.leftNameTxt_.text = var_152_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_9 = arg_149_1:GetWordFromCfg(113122037)
				local var_152_10 = arg_149_1:FormatText(var_152_9.content)

				arg_149_1.text_.text = var_152_10

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 12
				local var_152_12 = utf8.len(var_152_10)
				local var_152_13 = var_152_11 <= 0 and var_152_7 or var_152_7 * (var_152_12 / var_152_11)

				if var_152_13 > 0 and var_152_7 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_10
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122037", "story_v_out_113122.awb") ~= 0 then
					local var_152_14 = manager.audio:GetVoiceLength("story_v_out_113122", "113122037", "story_v_out_113122.awb") / 1000

					if var_152_14 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_14 + var_152_6
					end

					if var_152_9.prefab_name ~= "" and arg_149_1.actors_[var_152_9.prefab_name] ~= nil then
						local var_152_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_9.prefab_name].transform, "story_v_out_113122", "113122037", "story_v_out_113122.awb")

						arg_149_1:RecordAudio("113122037", var_152_15)
						arg_149_1:RecordAudio("113122037", var_152_15)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_113122", "113122037", "story_v_out_113122.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_113122", "113122037", "story_v_out_113122.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_16 = math.max(var_152_7, arg_149_1.talkMaxDuration)

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_16 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_6) / var_152_16

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_6 + var_152_16 and arg_149_1.time_ < var_152_6 + var_152_16 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play113122038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 113122038
		arg_153_1.duration_ = 5.87

		local var_153_0 = {
			ja = 5.866,
			ko = 3.9,
			zh = 4.333,
			en = 4.833
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
				arg_153_0:Play113122039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["6046_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos6046_story = var_156_0.localPosition

				local var_156_2 = GameObjectTools.GetOrAddComponent(var_156_0.gameObject, typeof(DynamicBoneHelper))

				if var_156_2 then
					var_156_2:EnableDynamicBone(false)
				end
			end

			local var_156_3 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_3 then
				local var_156_4 = (arg_153_1.time_ - var_156_1) / var_156_3
				local var_156_5 = Vector3.New(0, 100, 0)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos6046_story, var_156_5, var_156_4)

				local var_156_6 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_6.x, var_156_6.y, var_156_6.z)

				local var_156_7 = var_156_0.localEulerAngles

				var_156_7.z = 0
				var_156_7.x = 0
				var_156_0.localEulerAngles = var_156_7
			end

			if arg_153_1.time_ >= var_156_1 + var_156_3 and arg_153_1.time_ < var_156_1 + var_156_3 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(0, 100, 0)

				local var_156_8 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_8.x, var_156_8.y, var_156_8.z)

				local var_156_9 = var_156_0.localEulerAngles

				var_156_9.z = 0
				var_156_9.x = 0
				var_156_0.localEulerAngles = var_156_9

				local var_156_10 = GameObjectTools.GetOrAddComponent(var_156_0.gameObject, typeof(DynamicBoneHelper))

				if var_156_10 then
					var_156_10:EnableDynamicBone(true)
				end
			end

			local var_156_11 = arg_153_1.actors_["10006ui_story"].transform
			local var_156_12 = 0

			if var_156_12 < arg_153_1.time_ and arg_153_1.time_ <= var_156_12 + arg_156_0 then
				arg_153_1.var_.moveOldPos10006ui_story = var_156_11.localPosition
			end

			local var_156_13 = 0.001

			if var_156_12 <= arg_153_1.time_ and arg_153_1.time_ < var_156_12 + var_156_13 then
				local var_156_14 = (arg_153_1.time_ - var_156_12) / var_156_13
				local var_156_15 = Vector3.New(0, 100, 0)

				var_156_11.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10006ui_story, var_156_15, var_156_14)

				local var_156_16 = manager.ui.mainCamera.transform.position - var_156_11.position

				var_156_11.forward = Vector3.New(var_156_16.x, var_156_16.y, var_156_16.z)

				local var_156_17 = var_156_11.localEulerAngles

				var_156_17.z = 0
				var_156_17.x = 0
				var_156_11.localEulerAngles = var_156_17
			end

			if arg_153_1.time_ >= var_156_12 + var_156_13 and arg_153_1.time_ < var_156_12 + var_156_13 + arg_156_0 then
				var_156_11.localPosition = Vector3.New(0, 100, 0)

				local var_156_18 = manager.ui.mainCamera.transform.position - var_156_11.position

				var_156_11.forward = Vector3.New(var_156_18.x, var_156_18.y, var_156_18.z)

				local var_156_19 = var_156_11.localEulerAngles

				var_156_19.z = 0
				var_156_19.x = 0
				var_156_11.localEulerAngles = var_156_19
			end

			local var_156_20 = arg_153_1.actors_["1097ui_story"].transform
			local var_156_21 = 0

			if var_156_21 < arg_153_1.time_ and arg_153_1.time_ <= var_156_21 + arg_156_0 then
				arg_153_1.var_.moveOldPos1097ui_story = var_156_20.localPosition
			end

			local var_156_22 = 0.001

			if var_156_21 <= arg_153_1.time_ and arg_153_1.time_ < var_156_21 + var_156_22 then
				local var_156_23 = (arg_153_1.time_ - var_156_21) / var_156_22
				local var_156_24 = Vector3.New(0, -0.54, -6.3)

				var_156_20.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1097ui_story, var_156_24, var_156_23)

				local var_156_25 = manager.ui.mainCamera.transform.position - var_156_20.position

				var_156_20.forward = Vector3.New(var_156_25.x, var_156_25.y, var_156_25.z)

				local var_156_26 = var_156_20.localEulerAngles

				var_156_26.z = 0
				var_156_26.x = 0
				var_156_20.localEulerAngles = var_156_26
			end

			if arg_153_1.time_ >= var_156_21 + var_156_22 and arg_153_1.time_ < var_156_21 + var_156_22 + arg_156_0 then
				var_156_20.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_156_27 = manager.ui.mainCamera.transform.position - var_156_20.position

				var_156_20.forward = Vector3.New(var_156_27.x, var_156_27.y, var_156_27.z)

				local var_156_28 = var_156_20.localEulerAngles

				var_156_28.z = 0
				var_156_28.x = 0
				var_156_20.localEulerAngles = var_156_28
			end

			local var_156_29 = 0

			if var_156_29 < arg_153_1.time_ and arg_153_1.time_ <= var_156_29 + arg_156_0 then
				arg_153_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_156_30 = 0

			if var_156_30 < arg_153_1.time_ and arg_153_1.time_ <= var_156_30 + arg_156_0 then
				arg_153_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_156_31 = arg_153_1.actors_["1097ui_story"]
			local var_156_32 = 0

			if var_156_32 < arg_153_1.time_ and arg_153_1.time_ <= var_156_32 + arg_156_0 and not isNil(var_156_31) and arg_153_1.var_.characterEffect1097ui_story == nil then
				arg_153_1.var_.characterEffect1097ui_story = var_156_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_33 = 0.2

			if var_156_32 <= arg_153_1.time_ and arg_153_1.time_ < var_156_32 + var_156_33 and not isNil(var_156_31) then
				local var_156_34 = (arg_153_1.time_ - var_156_32) / var_156_33

				if arg_153_1.var_.characterEffect1097ui_story and not isNil(var_156_31) then
					arg_153_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_32 + var_156_33 and arg_153_1.time_ < var_156_32 + var_156_33 + arg_156_0 and not isNil(var_156_31) and arg_153_1.var_.characterEffect1097ui_story then
				arg_153_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_156_35 = 0
			local var_156_36 = 0.4

			if var_156_35 < arg_153_1.time_ and arg_153_1.time_ <= var_156_35 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_37 = arg_153_1:FormatText(StoryNameCfg[216].name)

				arg_153_1.leftNameTxt_.text = var_156_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_38 = arg_153_1:GetWordFromCfg(113122038)
				local var_156_39 = arg_153_1:FormatText(var_156_38.content)

				arg_153_1.text_.text = var_156_39

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_40 = 16
				local var_156_41 = utf8.len(var_156_39)
				local var_156_42 = var_156_40 <= 0 and var_156_36 or var_156_36 * (var_156_41 / var_156_40)

				if var_156_42 > 0 and var_156_36 < var_156_42 then
					arg_153_1.talkMaxDuration = var_156_42

					if var_156_42 + var_156_35 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_42 + var_156_35
					end
				end

				arg_153_1.text_.text = var_156_39
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122038", "story_v_out_113122.awb") ~= 0 then
					local var_156_43 = manager.audio:GetVoiceLength("story_v_out_113122", "113122038", "story_v_out_113122.awb") / 1000

					if var_156_43 + var_156_35 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_43 + var_156_35
					end

					if var_156_38.prefab_name ~= "" and arg_153_1.actors_[var_156_38.prefab_name] ~= nil then
						local var_156_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_38.prefab_name].transform, "story_v_out_113122", "113122038", "story_v_out_113122.awb")

						arg_153_1:RecordAudio("113122038", var_156_44)
						arg_153_1:RecordAudio("113122038", var_156_44)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_113122", "113122038", "story_v_out_113122.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_113122", "113122038", "story_v_out_113122.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_45 = math.max(var_156_36, arg_153_1.talkMaxDuration)

			if var_156_35 <= arg_153_1.time_ and arg_153_1.time_ < var_156_35 + var_156_45 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_35) / var_156_45

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_35 + var_156_45 and arg_153_1.time_ < var_156_35 + var_156_45 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play113122039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 113122039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play113122040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1097ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos1097ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(0, 100, 0)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1097ui_story, var_160_4, var_160_3)

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

			local var_160_9 = 0
			local var_160_10 = 1.05

			if var_160_9 < arg_157_1.time_ and arg_157_1.time_ <= var_160_9 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_11 = arg_157_1:GetWordFromCfg(113122039)
				local var_160_12 = arg_157_1:FormatText(var_160_11.content)

				arg_157_1.text_.text = var_160_12

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 42
				local var_160_14 = utf8.len(var_160_12)
				local var_160_15 = var_160_13 <= 0 and var_160_10 or var_160_10 * (var_160_14 / var_160_13)

				if var_160_15 > 0 and var_160_10 < var_160_15 then
					arg_157_1.talkMaxDuration = var_160_15

					if var_160_15 + var_160_9 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_15 + var_160_9
					end
				end

				arg_157_1.text_.text = var_160_12
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_10, arg_157_1.talkMaxDuration)

			if var_160_9 <= arg_157_1.time_ and arg_157_1.time_ < var_160_9 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_9) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_9 + var_160_16 and arg_157_1.time_ < var_160_9 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play113122040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 113122040
		arg_161_1.duration_ = 14.4

		local var_161_0 = {
			ja = 14.4,
			ko = 13,
			zh = 12.4,
			en = 11.6
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
				arg_161_0:Play113122041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 4.5

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_164_1 = arg_161_1.actors_["1097ui_story"]
			local var_164_2 = 0

			if var_164_2 < arg_161_1.time_ and arg_161_1.time_ <= var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1097ui_story == nil then
				arg_161_1.var_.characterEffect1097ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_3 = 0.2

			if var_164_2 <= arg_161_1.time_ and arg_161_1.time_ < var_164_2 + var_164_3 and not isNil(var_164_1) then
				local var_164_4 = (arg_161_1.time_ - var_164_2) / var_164_3

				if arg_161_1.var_.characterEffect1097ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_2 + var_164_3 and arg_161_1.time_ < var_164_2 + var_164_3 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1097ui_story then
				arg_161_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_164_5 = 0

			if var_164_5 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 then
				arg_161_1.mask_.enabled = true
				arg_161_1.mask_.raycastTarget = true

				arg_161_1:SetGaussion(false)
			end

			local var_164_6 = 2

			if var_164_5 <= arg_161_1.time_ and arg_161_1.time_ < var_164_5 + var_164_6 then
				local var_164_7 = (arg_161_1.time_ - var_164_5) / var_164_6
				local var_164_8 = Color.New(0, 0, 0)

				var_164_8.a = Mathf.Lerp(0, 1, var_164_7)
				arg_161_1.mask_.color = var_164_8
			end

			if arg_161_1.time_ >= var_164_5 + var_164_6 and arg_161_1.time_ < var_164_5 + var_164_6 + arg_164_0 then
				local var_164_9 = Color.New(0, 0, 0)

				var_164_9.a = 1
				arg_161_1.mask_.color = var_164_9
			end

			local var_164_10 = 2.5

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 then
				arg_161_1.mask_.enabled = true
				arg_161_1.mask_.raycastTarget = true

				arg_161_1:SetGaussion(false)
			end

			local var_164_11 = 2

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_11 then
				local var_164_12 = (arg_161_1.time_ - var_164_10) / var_164_11
				local var_164_13 = Color.New(0, 0, 0)

				var_164_13.a = Mathf.Lerp(1, 0, var_164_12)
				arg_161_1.mask_.color = var_164_13
			end

			if arg_161_1.time_ >= var_164_10 + var_164_11 and arg_161_1.time_ < var_164_10 + var_164_11 + arg_164_0 then
				local var_164_14 = Color.New(0, 0, 0)
				local var_164_15 = 0

				arg_161_1.mask_.enabled = false
				var_164_14.a = var_164_15
				arg_161_1.mask_.color = var_164_14
			end

			local var_164_16 = 2

			if var_164_16 < arg_161_1.time_ and arg_161_1.time_ <= var_164_16 + arg_164_0 then
				arg_161_1.allBtn_.enabled = false
			end

			local var_164_17 = 0.5

			if arg_161_1.time_ >= var_164_16 + var_164_17 and arg_161_1.time_ < var_164_16 + var_164_17 + arg_164_0 then
				arg_161_1.allBtn_.enabled = true
			end

			local var_164_18 = 4.5

			if var_164_18 < arg_161_1.time_ and arg_161_1.time_ <= var_164_18 + arg_164_0 then
				arg_161_1.allBtn_.enabled = false
			end

			local var_164_19 = 0.725

			if arg_161_1.time_ >= var_164_18 + var_164_19 and arg_161_1.time_ < var_164_18 + var_164_19 + arg_164_0 then
				arg_161_1.allBtn_.enabled = true
			end

			if arg_161_1.frameCnt_ <= 1 then
				arg_161_1.dialog_:SetActive(false)
			end

			local var_164_20 = 4.5
			local var_164_21 = 0.725

			if var_164_20 < arg_161_1.time_ and arg_161_1.time_ <= var_164_20 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0

				arg_161_1.dialog_:SetActive(true)

				arg_161_1.dialogCg_.alpha = 0

				local var_164_22 = LeanTween.value(arg_161_1.dialog_, 0, 1, 0.3)

				var_164_22:setOnUpdate(LuaHelper.FloatAction(function(arg_165_0)
					arg_161_1.dialogCg_.alpha = arg_165_0
				end))
				var_164_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_161_1.dialog_)
					var_164_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_161_1.duration_ = arg_161_1.duration_ + 0.3

				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_23 = arg_161_1:FormatText(StoryNameCfg[216].name)

				arg_161_1.leftNameTxt_.text = var_164_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_24 = arg_161_1:GetWordFromCfg(113122040)
				local var_164_25 = arg_161_1:FormatText(var_164_24.content)

				arg_161_1.text_.text = var_164_25

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_26 = 29
				local var_164_27 = utf8.len(var_164_25)
				local var_164_28 = var_164_26 <= 0 and var_164_21 or var_164_21 * (var_164_27 / var_164_26)

				if var_164_28 > 0 and var_164_21 < var_164_28 then
					arg_161_1.talkMaxDuration = var_164_28
					var_164_20 = var_164_20 + 0.3

					if var_164_28 + var_164_20 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_28 + var_164_20
					end
				end

				arg_161_1.text_.text = var_164_25
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122040", "story_v_out_113122.awb") ~= 0 then
					local var_164_29 = manager.audio:GetVoiceLength("story_v_out_113122", "113122040", "story_v_out_113122.awb") / 1000

					if var_164_29 + var_164_20 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_29 + var_164_20
					end

					if var_164_24.prefab_name ~= "" and arg_161_1.actors_[var_164_24.prefab_name] ~= nil then
						local var_164_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_24.prefab_name].transform, "story_v_out_113122", "113122040", "story_v_out_113122.awb")

						arg_161_1:RecordAudio("113122040", var_164_30)
						arg_161_1:RecordAudio("113122040", var_164_30)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_113122", "113122040", "story_v_out_113122.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_113122", "113122040", "story_v_out_113122.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_31 = var_164_20 + 0.3
			local var_164_32 = math.max(var_164_21, arg_161_1.talkMaxDuration)

			if var_164_31 <= arg_161_1.time_ and arg_161_1.time_ < var_164_31 + var_164_32 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_31) / var_164_32

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_31 + var_164_32 and arg_161_1.time_ < var_164_31 + var_164_32 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play113122041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 113122041
		arg_167_1.duration_ = 4.8

		local var_167_0 = {
			ja = 4.8,
			ko = 3.3,
			zh = 3,
			en = 3.866
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
				arg_167_0:Play113122042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1097ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1097ui_story == nil then
				arg_167_1.var_.characterEffect1097ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.2

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect1097ui_story and not isNil(var_170_0) then
					local var_170_4 = Mathf.Lerp(0, 0.5, var_170_3)

					arg_167_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1097ui_story.fillRatio = var_170_4
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1097ui_story then
				local var_170_5 = 0.5

				arg_167_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1097ui_story.fillRatio = var_170_5
			end

			local var_170_6 = 0
			local var_170_7 = 0.275

			if var_170_6 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_8 = arg_167_1:FormatText(StoryNameCfg[212].name)

				arg_167_1.leftNameTxt_.text = var_170_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_9 = arg_167_1:GetWordFromCfg(113122041)
				local var_170_10 = arg_167_1:FormatText(var_170_9.content)

				arg_167_1.text_.text = var_170_10

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_11 = 11
				local var_170_12 = utf8.len(var_170_10)
				local var_170_13 = var_170_11 <= 0 and var_170_7 or var_170_7 * (var_170_12 / var_170_11)

				if var_170_13 > 0 and var_170_7 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_6
					end
				end

				arg_167_1.text_.text = var_170_10
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122041", "story_v_out_113122.awb") ~= 0 then
					local var_170_14 = manager.audio:GetVoiceLength("story_v_out_113122", "113122041", "story_v_out_113122.awb") / 1000

					if var_170_14 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_14 + var_170_6
					end

					if var_170_9.prefab_name ~= "" and arg_167_1.actors_[var_170_9.prefab_name] ~= nil then
						local var_170_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_9.prefab_name].transform, "story_v_out_113122", "113122041", "story_v_out_113122.awb")

						arg_167_1:RecordAudio("113122041", var_170_15)
						arg_167_1:RecordAudio("113122041", var_170_15)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_113122", "113122041", "story_v_out_113122.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_113122", "113122041", "story_v_out_113122.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_16 = math.max(var_170_7, arg_167_1.talkMaxDuration)

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_16 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_6) / var_170_16

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_6 + var_170_16 and arg_167_1.time_ < var_170_6 + var_170_16 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play113122042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 113122042
		arg_171_1.duration_ = 11.9

		local var_171_0 = {
			ja = 10.666,
			ko = 8.8,
			zh = 7.433,
			en = 11.9
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
				arg_171_0:Play113122043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_174_2 = arg_171_1.actors_["1097ui_story"]
			local var_174_3 = 0

			if var_174_3 < arg_171_1.time_ and arg_171_1.time_ <= var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.characterEffect1097ui_story == nil then
				arg_171_1.var_.characterEffect1097ui_story = var_174_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_4 = 0.2

			if var_174_3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_3 + var_174_4 and not isNil(var_174_2) then
				local var_174_5 = (arg_171_1.time_ - var_174_3) / var_174_4

				if arg_171_1.var_.characterEffect1097ui_story and not isNil(var_174_2) then
					arg_171_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_3 + var_174_4 and arg_171_1.time_ < var_174_3 + var_174_4 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.characterEffect1097ui_story then
				arg_171_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_174_6 = arg_171_1.actors_["1097ui_story"].transform
			local var_174_7 = 0

			if var_174_7 < arg_171_1.time_ and arg_171_1.time_ <= var_174_7 + arg_174_0 then
				arg_171_1.var_.moveOldPos1097ui_story = var_174_6.localPosition
			end

			local var_174_8 = 0.001

			if var_174_7 <= arg_171_1.time_ and arg_171_1.time_ < var_174_7 + var_174_8 then
				local var_174_9 = (arg_171_1.time_ - var_174_7) / var_174_8
				local var_174_10 = Vector3.New(0, -0.54, -6.3)

				var_174_6.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1097ui_story, var_174_10, var_174_9)

				local var_174_11 = manager.ui.mainCamera.transform.position - var_174_6.position

				var_174_6.forward = Vector3.New(var_174_11.x, var_174_11.y, var_174_11.z)

				local var_174_12 = var_174_6.localEulerAngles

				var_174_12.z = 0
				var_174_12.x = 0
				var_174_6.localEulerAngles = var_174_12
			end

			if arg_171_1.time_ >= var_174_7 + var_174_8 and arg_171_1.time_ < var_174_7 + var_174_8 + arg_174_0 then
				var_174_6.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_174_13 = manager.ui.mainCamera.transform.position - var_174_6.position

				var_174_6.forward = Vector3.New(var_174_13.x, var_174_13.y, var_174_13.z)

				local var_174_14 = var_174_6.localEulerAngles

				var_174_14.z = 0
				var_174_14.x = 0
				var_174_6.localEulerAngles = var_174_14
			end

			local var_174_15 = 0
			local var_174_16 = 0.85

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_17 = arg_171_1:FormatText(StoryNameCfg[216].name)

				arg_171_1.leftNameTxt_.text = var_174_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_18 = arg_171_1:GetWordFromCfg(113122042)
				local var_174_19 = arg_171_1:FormatText(var_174_18.content)

				arg_171_1.text_.text = var_174_19

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_20 = 34
				local var_174_21 = utf8.len(var_174_19)
				local var_174_22 = var_174_20 <= 0 and var_174_16 or var_174_16 * (var_174_21 / var_174_20)

				if var_174_22 > 0 and var_174_16 < var_174_22 then
					arg_171_1.talkMaxDuration = var_174_22

					if var_174_22 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_22 + var_174_15
					end
				end

				arg_171_1.text_.text = var_174_19
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122042", "story_v_out_113122.awb") ~= 0 then
					local var_174_23 = manager.audio:GetVoiceLength("story_v_out_113122", "113122042", "story_v_out_113122.awb") / 1000

					if var_174_23 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_23 + var_174_15
					end

					if var_174_18.prefab_name ~= "" and arg_171_1.actors_[var_174_18.prefab_name] ~= nil then
						local var_174_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_18.prefab_name].transform, "story_v_out_113122", "113122042", "story_v_out_113122.awb")

						arg_171_1:RecordAudio("113122042", var_174_24)
						arg_171_1:RecordAudio("113122042", var_174_24)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_113122", "113122042", "story_v_out_113122.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_113122", "113122042", "story_v_out_113122.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_25 = math.max(var_174_16, arg_171_1.talkMaxDuration)

			if var_174_15 <= arg_171_1.time_ and arg_171_1.time_ < var_174_15 + var_174_25 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_15) / var_174_25

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_15 + var_174_25 and arg_171_1.time_ < var_174_15 + var_174_25 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play113122043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 113122043
		arg_175_1.duration_ = 5.63

		local var_175_0 = {
			ja = 4.466,
			ko = 4.4,
			zh = 4.2,
			en = 5.633
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
				arg_175_0:Play113122044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1097ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1097ui_story == nil then
				arg_175_1.var_.characterEffect1097ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.2

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect1097ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1097ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1097ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1097ui_story.fillRatio = var_178_5
			end

			local var_178_6 = 0
			local var_178_7 = 0.3

			if var_178_6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_8 = arg_175_1:FormatText(StoryNameCfg[212].name)

				arg_175_1.leftNameTxt_.text = var_178_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_9 = arg_175_1:GetWordFromCfg(113122043)
				local var_178_10 = arg_175_1:FormatText(var_178_9.content)

				arg_175_1.text_.text = var_178_10

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_11 = 12
				local var_178_12 = utf8.len(var_178_10)
				local var_178_13 = var_178_11 <= 0 and var_178_7 or var_178_7 * (var_178_12 / var_178_11)

				if var_178_13 > 0 and var_178_7 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_6
					end
				end

				arg_175_1.text_.text = var_178_10
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122043", "story_v_out_113122.awb") ~= 0 then
					local var_178_14 = manager.audio:GetVoiceLength("story_v_out_113122", "113122043", "story_v_out_113122.awb") / 1000

					if var_178_14 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_6
					end

					if var_178_9.prefab_name ~= "" and arg_175_1.actors_[var_178_9.prefab_name] ~= nil then
						local var_178_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_9.prefab_name].transform, "story_v_out_113122", "113122043", "story_v_out_113122.awb")

						arg_175_1:RecordAudio("113122043", var_178_15)
						arg_175_1:RecordAudio("113122043", var_178_15)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_113122", "113122043", "story_v_out_113122.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_113122", "113122043", "story_v_out_113122.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = math.max(var_178_7, arg_175_1.talkMaxDuration)

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_6) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_6 + var_178_16 and arg_175_1.time_ < var_178_6 + var_178_16 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play113122044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 113122044
		arg_179_1.duration_ = 6.2

		local var_179_0 = {
			ja = 6.2,
			ko = 5.333,
			zh = 3.566,
			en = 4.7
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
				arg_179_0:Play113122045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_182_1 = arg_179_1.actors_["1097ui_story"]
			local var_182_2 = 0

			if var_182_2 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1097ui_story == nil then
				arg_179_1.var_.characterEffect1097ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_3 = 0.2

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_3 and not isNil(var_182_1) then
				local var_182_4 = (arg_179_1.time_ - var_182_2) / var_182_3

				if arg_179_1.var_.characterEffect1097ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_2 + var_182_3 and arg_179_1.time_ < var_182_2 + var_182_3 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1097ui_story then
				arg_179_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_182_5 = 0

			if var_182_5 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action5_1")
			end

			local var_182_6 = arg_179_1.actors_["1097ui_story"].transform
			local var_182_7 = 0

			if var_182_7 < arg_179_1.time_ and arg_179_1.time_ <= var_182_7 + arg_182_0 then
				arg_179_1.var_.moveOldPos1097ui_story = var_182_6.localPosition

				local var_182_8 = "1097ui_story"

				arg_179_1:ShowWeapon(arg_179_1.var_[var_182_8 .. "Animator"].transform, true)
			end

			local var_182_9 = 0.001

			if var_182_7 <= arg_179_1.time_ and arg_179_1.time_ < var_182_7 + var_182_9 then
				local var_182_10 = (arg_179_1.time_ - var_182_7) / var_182_9
				local var_182_11 = Vector3.New(0, -0.54, -6.3)

				var_182_6.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1097ui_story, var_182_11, var_182_10)

				local var_182_12 = manager.ui.mainCamera.transform.position - var_182_6.position

				var_182_6.forward = Vector3.New(var_182_12.x, var_182_12.y, var_182_12.z)

				local var_182_13 = var_182_6.localEulerAngles

				var_182_13.z = 0
				var_182_13.x = 0
				var_182_6.localEulerAngles = var_182_13
			end

			if arg_179_1.time_ >= var_182_7 + var_182_9 and arg_179_1.time_ < var_182_7 + var_182_9 + arg_182_0 then
				var_182_6.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_182_14 = manager.ui.mainCamera.transform.position - var_182_6.position

				var_182_6.forward = Vector3.New(var_182_14.x, var_182_14.y, var_182_14.z)

				local var_182_15 = var_182_6.localEulerAngles

				var_182_15.z = 0
				var_182_15.x = 0
				var_182_6.localEulerAngles = var_182_15
			end

			local var_182_16 = arg_179_1.actors_["1097ui_story"].transform
			local var_182_17 = 0

			if var_182_17 < arg_179_1.time_ and arg_179_1.time_ <= var_182_17 + arg_182_0 then
				local var_182_18 = arg_179_1.var_.effect1097ui_storyyanwu2
				local var_182_19
				local var_182_20 = var_182_16

				if not var_182_18 then
					var_182_18 = Object.Instantiate(Asset.Load("Effect/Hero/1097/fx_1097_story_smoke"), var_182_20)
					var_182_18.name = "yanwu2"
					arg_179_1.var_.effect1097ui_storyyanwu2 = var_182_18
				else
					var_182_18.transform:SetParent(var_182_20)
				end

				var_182_18.transform.localPosition = Vector3.New(0, 1.28, 0.3)
				var_182_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_182_21 = arg_179_1.actors_["1097ui_story"].transform
			local var_182_22 = 2

			if var_182_22 < arg_179_1.time_ and arg_179_1.time_ <= var_182_22 + arg_182_0 then
				local var_182_23 = arg_179_1.var_.effect1097ui_storyyanwu2

				if var_182_23 then
					Object.Destroy(var_182_23)

					arg_179_1.var_.effect1097ui_storyyanwu2 = nil
				end
			end

			local var_182_24 = 0
			local var_182_25 = 0.35

			if var_182_24 < arg_179_1.time_ and arg_179_1.time_ <= var_182_24 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_26 = arg_179_1:FormatText(StoryNameCfg[216].name)

				arg_179_1.leftNameTxt_.text = var_182_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_27 = arg_179_1:GetWordFromCfg(113122044)
				local var_182_28 = arg_179_1:FormatText(var_182_27.content)

				arg_179_1.text_.text = var_182_28

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_29 = 14
				local var_182_30 = utf8.len(var_182_28)
				local var_182_31 = var_182_29 <= 0 and var_182_25 or var_182_25 * (var_182_30 / var_182_29)

				if var_182_31 > 0 and var_182_25 < var_182_31 then
					arg_179_1.talkMaxDuration = var_182_31

					if var_182_31 + var_182_24 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_31 + var_182_24
					end
				end

				arg_179_1.text_.text = var_182_28
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122044", "story_v_out_113122.awb") ~= 0 then
					local var_182_32 = manager.audio:GetVoiceLength("story_v_out_113122", "113122044", "story_v_out_113122.awb") / 1000

					if var_182_32 + var_182_24 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_32 + var_182_24
					end

					if var_182_27.prefab_name ~= "" and arg_179_1.actors_[var_182_27.prefab_name] ~= nil then
						local var_182_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_27.prefab_name].transform, "story_v_out_113122", "113122044", "story_v_out_113122.awb")

						arg_179_1:RecordAudio("113122044", var_182_33)
						arg_179_1:RecordAudio("113122044", var_182_33)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_113122", "113122044", "story_v_out_113122.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_113122", "113122044", "story_v_out_113122.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_34 = math.max(var_182_25, arg_179_1.talkMaxDuration)

			if var_182_24 <= arg_179_1.time_ and arg_179_1.time_ < var_182_24 + var_182_34 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_24) / var_182_34

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_24 + var_182_34 and arg_179_1.time_ < var_182_24 + var_182_34 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play113122045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 113122045
		arg_183_1.duration_ = 20.42

		local var_183_0 = {
			ja = 19.8826666666667,
			ko = 20.4166666666667,
			zh = 18.6496666666667,
			en = 17.0826666666667
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
			arg_183_1.auto_ = false
		end

		function arg_183_1.playNext_(arg_185_0)
			arg_183_1.onStoryFinished_()
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_1 = 2

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_1 then
				local var_186_2 = (arg_183_1.time_ - var_186_0) / var_186_1
				local var_186_3 = Color.New(0, 0, 0)

				var_186_3.a = Mathf.Lerp(0, 1, var_186_2)
				arg_183_1.mask_.color = var_186_3
			end

			if arg_183_1.time_ >= var_186_0 + var_186_1 and arg_183_1.time_ < var_186_0 + var_186_1 + arg_186_0 then
				local var_186_4 = Color.New(0, 0, 0)

				var_186_4.a = 1
				arg_183_1.mask_.color = var_186_4
			end

			local var_186_5 = 2.5

			if var_186_5 < arg_183_1.time_ and arg_183_1.time_ <= var_186_5 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_6 = 2

			if var_186_5 <= arg_183_1.time_ and arg_183_1.time_ < var_186_5 + var_186_6 then
				local var_186_7 = (arg_183_1.time_ - var_186_5) / var_186_6
				local var_186_8 = Color.New(0, 0, 0)

				var_186_8.a = Mathf.Lerp(1, 0, var_186_7)
				arg_183_1.mask_.color = var_186_8
			end

			if arg_183_1.time_ >= var_186_5 + var_186_6 and arg_183_1.time_ < var_186_5 + var_186_6 + arg_186_0 then
				local var_186_9 = Color.New(0, 0, 0)
				local var_186_10 = 0

				arg_183_1.mask_.enabled = false
				var_186_9.a = var_186_10
				arg_183_1.mask_.color = var_186_9
			end

			local var_186_11 = 5

			if var_186_11 < arg_183_1.time_ and arg_183_1.time_ <= var_186_11 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_12 = 2.5

			if var_186_11 <= arg_183_1.time_ and arg_183_1.time_ < var_186_11 + var_186_12 then
				local var_186_13 = (arg_183_1.time_ - var_186_11) / var_186_12
				local var_186_14 = Color.New(0, 0, 0)

				var_186_14.a = Mathf.Lerp(0, 1, var_186_13)
				arg_183_1.mask_.color = var_186_14
			end

			if arg_183_1.time_ >= var_186_11 + var_186_12 and arg_183_1.time_ < var_186_11 + var_186_12 + arg_186_0 then
				local var_186_15 = Color.New(0, 0, 0)

				var_186_15.a = 1
				arg_183_1.mask_.color = var_186_15
			end

			local var_186_16 = 7.5

			if var_186_16 < arg_183_1.time_ and arg_183_1.time_ <= var_186_16 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_17 = 0.0166666666666667

			if var_186_16 <= arg_183_1.time_ and arg_183_1.time_ < var_186_16 + var_186_17 then
				local var_186_18 = (arg_183_1.time_ - var_186_16) / var_186_17
				local var_186_19 = Color.New(0, 0, 0)

				var_186_19.a = Mathf.Lerp(1, 0, var_186_18)
				arg_183_1.mask_.color = var_186_19
			end

			if arg_183_1.time_ >= var_186_16 + var_186_17 and arg_183_1.time_ < var_186_16 + var_186_17 + arg_186_0 then
				local var_186_20 = Color.New(0, 0, 0)
				local var_186_21 = 0

				arg_183_1.mask_.enabled = false
				var_186_20.a = var_186_21
				arg_183_1.mask_.color = var_186_20
			end

			local var_186_22 = 2

			if var_186_22 < arg_183_1.time_ and arg_183_1.time_ <= var_186_22 + arg_186_0 then
				arg_183_1.allBtn_.enabled = false
			end

			local var_186_23 = 0.5

			if arg_183_1.time_ >= var_186_22 + var_186_23 and arg_183_1.time_ < var_186_22 + var_186_23 + arg_186_0 then
				arg_183_1.allBtn_.enabled = true
			end

			local var_186_24 = 4.5

			if var_186_24 < arg_183_1.time_ and arg_183_1.time_ <= var_186_24 + arg_186_0 then
				arg_183_1.allBtn_.enabled = false
			end

			local var_186_25 = 0.5

			if arg_183_1.time_ >= var_186_24 + var_186_25 and arg_183_1.time_ < var_186_24 + var_186_25 + arg_186_0 then
				arg_183_1.allBtn_.enabled = true
			end

			local var_186_26 = "STblack"

			if arg_183_1.bgs_[var_186_26] == nil then
				local var_186_27 = Object.Instantiate(arg_183_1.paintGo_)

				var_186_27:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_186_26)
				var_186_27.name = var_186_26
				var_186_27.transform.parent = arg_183_1.stage_.transform
				var_186_27.transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.bgs_[var_186_26] = var_186_27
			end

			local var_186_28 = 7.5

			if var_186_28 < arg_183_1.time_ and arg_183_1.time_ <= var_186_28 + arg_186_0 then
				local var_186_29 = manager.ui.mainCamera.transform.localPosition
				local var_186_30 = Vector3.New(0, 0, 10) + Vector3.New(var_186_29.x, var_186_29.y, 0)
				local var_186_31 = arg_183_1.bgs_.STblack

				var_186_31.transform.localPosition = var_186_30
				var_186_31.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_186_32 = var_186_31:GetComponent("SpriteRenderer")

				if var_186_32 and var_186_32.sprite then
					local var_186_33 = (var_186_31.transform.localPosition - var_186_29).z
					local var_186_34 = manager.ui.mainCameraCom_
					local var_186_35 = 2 * var_186_33 * Mathf.Tan(var_186_34.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_186_36 = var_186_35 * var_186_34.aspect
					local var_186_37 = var_186_32.sprite.bounds.size.x
					local var_186_38 = var_186_32.sprite.bounds.size.y
					local var_186_39 = var_186_36 / var_186_37
					local var_186_40 = var_186_35 / var_186_38
					local var_186_41 = var_186_40 < var_186_39 and var_186_39 or var_186_40

					var_186_31.transform.localScale = Vector3.New(var_186_41, var_186_41, 0)
				end

				for iter_186_0, iter_186_1 in pairs(arg_183_1.bgs_) do
					if iter_186_0 ~= "STblack" then
						iter_186_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_186_42 = arg_183_1.actors_["1097ui_story"].transform
			local var_186_43 = 1.966

			if var_186_43 < arg_183_1.time_ and arg_183_1.time_ <= var_186_43 + arg_186_0 then
				arg_183_1.var_.moveOldPos1097ui_story = var_186_42.localPosition
			end

			local var_186_44 = 0.001

			if var_186_43 <= arg_183_1.time_ and arg_183_1.time_ < var_186_43 + var_186_44 then
				local var_186_45 = (arg_183_1.time_ - var_186_43) / var_186_44
				local var_186_46 = Vector3.New(0, 100, 0)

				var_186_42.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1097ui_story, var_186_46, var_186_45)

				local var_186_47 = manager.ui.mainCamera.transform.position - var_186_42.position

				var_186_42.forward = Vector3.New(var_186_47.x, var_186_47.y, var_186_47.z)

				local var_186_48 = var_186_42.localEulerAngles

				var_186_48.z = 0
				var_186_48.x = 0
				var_186_42.localEulerAngles = var_186_48
			end

			if arg_183_1.time_ >= var_186_43 + var_186_44 and arg_183_1.time_ < var_186_43 + var_186_44 + arg_186_0 then
				var_186_42.localPosition = Vector3.New(0, 100, 0)

				local var_186_49 = manager.ui.mainCamera.transform.position - var_186_42.position

				var_186_42.forward = Vector3.New(var_186_49.x, var_186_49.y, var_186_49.z)

				local var_186_50 = var_186_42.localEulerAngles

				var_186_50.z = 0
				var_186_50.x = 0
				var_186_42.localEulerAngles = var_186_50
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_51 = 7.51666666666667
			local var_186_52 = 1

			if var_186_51 < arg_183_1.time_ and arg_183_1.time_ <= var_186_51 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_53 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_53:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_183_1.dialogCg_.alpha = arg_187_0
				end))
				var_186_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_54 = arg_183_1:FormatText(StoryNameCfg[212].name)

				arg_183_1.leftNameTxt_.text = var_186_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_55 = arg_183_1:GetWordFromCfg(113122045)
				local var_186_56 = arg_183_1:FormatText(var_186_55.content)

				arg_183_1.text_.text = var_186_56

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_57 = 40
				local var_186_58 = utf8.len(var_186_56)
				local var_186_59 = var_186_57 <= 0 and var_186_52 or var_186_52 * (var_186_58 / var_186_57)

				if var_186_59 > 0 and var_186_52 < var_186_59 then
					arg_183_1.talkMaxDuration = var_186_59
					var_186_51 = var_186_51 + 0.3

					if var_186_59 + var_186_51 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_59 + var_186_51
					end
				end

				arg_183_1.text_.text = var_186_56
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122045", "story_v_out_113122.awb") ~= 0 then
					local var_186_60 = manager.audio:GetVoiceLength("story_v_out_113122", "113122045", "story_v_out_113122.awb") / 1000

					if var_186_60 + var_186_51 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_60 + var_186_51
					end

					if var_186_55.prefab_name ~= "" and arg_183_1.actors_[var_186_55.prefab_name] ~= nil then
						local var_186_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_55.prefab_name].transform, "story_v_out_113122", "113122045", "story_v_out_113122.awb")

						arg_183_1:RecordAudio("113122045", var_186_61)
						arg_183_1:RecordAudio("113122045", var_186_61)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_113122", "113122045", "story_v_out_113122.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_113122", "113122045", "story_v_out_113122.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_62 = var_186_51 + 0.3
			local var_186_63 = math.max(var_186_52, arg_183_1.talkMaxDuration)

			if var_186_62 <= arg_183_1.time_ and arg_183_1.time_ < var_186_62 + var_186_63 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_62) / var_186_63

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_62 + var_186_63 and arg_183_1.time_ < var_186_62 + var_186_63 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F02_1",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_113122.awb"
	}
}
