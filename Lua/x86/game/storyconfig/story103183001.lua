return {
	Play318301001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 318301001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play318301002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack"

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
				local var_4_5 = arg_1_1.bgs_.STblack

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
					if iter_4_0 ~= "STblack" then
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
			local var_4_23 = 0.533333333333333

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

			local var_4_28 = 0.8
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_4_story_firework", "bgm_activity_2_4_story_firework", "bgm_activity_2_4_story_firework.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_4_story_firework", "bgm_activity_2_4_story_firework")

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
			local var_4_35 = 0.75

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

				local var_4_37 = arg_1_1:GetWordFromCfg(318301001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 30
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
	Play318301002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 318301002
		arg_9_1.duration_ = 5.7

		local var_9_0 = {
			zh = 4.066666666666,
			ja = 5.7
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
				arg_9_0:Play318301003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "K11g"

			if arg_9_1.bgs_[var_12_0] == nil then
				local var_12_1 = Object.Instantiate(arg_9_1.paintGo_)

				var_12_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_12_0)
				var_12_1.name = var_12_0
				var_12_1.transform.parent = arg_9_1.stage_.transform
				var_12_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.bgs_[var_12_0] = var_12_1
			end

			local var_12_2 = 0

			if var_12_2 < arg_9_1.time_ and arg_9_1.time_ <= var_12_2 + arg_12_0 then
				local var_12_3 = manager.ui.mainCamera.transform.localPosition
				local var_12_4 = Vector3.New(0, 0, 10) + Vector3.New(var_12_3.x, var_12_3.y, 0)
				local var_12_5 = arg_9_1.bgs_.K11g

				var_12_5.transform.localPosition = var_12_4
				var_12_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_12_6 = var_12_5:GetComponent("SpriteRenderer")

				if var_12_6 and var_12_6.sprite then
					local var_12_7 = (var_12_5.transform.localPosition - var_12_3).z
					local var_12_8 = manager.ui.mainCameraCom_
					local var_12_9 = 2 * var_12_7 * Mathf.Tan(var_12_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_12_10 = var_12_9 * var_12_8.aspect
					local var_12_11 = var_12_6.sprite.bounds.size.x
					local var_12_12 = var_12_6.sprite.bounds.size.y
					local var_12_13 = var_12_10 / var_12_11
					local var_12_14 = var_12_9 / var_12_12
					local var_12_15 = var_12_14 < var_12_13 and var_12_13 or var_12_14

					var_12_5.transform.localScale = Vector3.New(var_12_15, var_12_15, 0)
				end

				for iter_12_0, iter_12_1 in pairs(arg_9_1.bgs_) do
					if iter_12_0 ~= "K11g" then
						iter_12_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_12_16 = 0

			if var_12_16 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 then
				arg_9_1.mask_.enabled = true
				arg_9_1.mask_.raycastTarget = true

				arg_9_1:SetGaussion(false)
			end

			local var_12_17 = 2

			if var_12_16 <= arg_9_1.time_ and arg_9_1.time_ < var_12_16 + var_12_17 then
				local var_12_18 = (arg_9_1.time_ - var_12_16) / var_12_17
				local var_12_19 = Color.New(0, 0, 0)

				var_12_19.a = Mathf.Lerp(1, 0, var_12_18)
				arg_9_1.mask_.color = var_12_19
			end

			if arg_9_1.time_ >= var_12_16 + var_12_17 and arg_9_1.time_ < var_12_16 + var_12_17 + arg_12_0 then
				local var_12_20 = Color.New(0, 0, 0)
				local var_12_21 = 0

				arg_9_1.mask_.enabled = false
				var_12_20.a = var_12_21
				arg_9_1.mask_.color = var_12_20
			end

			local var_12_22 = "1049ui_story"

			if arg_9_1.actors_[var_12_22] == nil then
				local var_12_23 = Asset.Load("Char/" .. "1049ui_story")

				if not isNil(var_12_23) then
					local var_12_24 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_9_1.stage_.transform)

					var_12_24.name = var_12_22
					var_12_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_22] = var_12_24

					local var_12_25 = var_12_24:GetComponentInChildren(typeof(CharacterEffect))

					var_12_25.enabled = true

					local var_12_26 = GameObjectTools.GetOrAddComponent(var_12_24, typeof(DynamicBoneHelper))

					if var_12_26 then
						var_12_26:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_25.transform, false)

					arg_9_1.var_[var_12_22 .. "Animator"] = var_12_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_22 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_22 .. "LipSync"] = var_12_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_27 = arg_9_1.actors_["1049ui_story"].transform
			local var_12_28 = 1.8

			if var_12_28 < arg_9_1.time_ and arg_9_1.time_ <= var_12_28 + arg_12_0 then
				arg_9_1.var_.moveOldPos1049ui_story = var_12_27.localPosition
			end

			local var_12_29 = 0.001

			if var_12_28 <= arg_9_1.time_ and arg_9_1.time_ < var_12_28 + var_12_29 then
				local var_12_30 = (arg_9_1.time_ - var_12_28) / var_12_29
				local var_12_31 = Vector3.New(0, -1.2, -6)

				var_12_27.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1049ui_story, var_12_31, var_12_30)

				local var_12_32 = manager.ui.mainCamera.transform.position - var_12_27.position

				var_12_27.forward = Vector3.New(var_12_32.x, var_12_32.y, var_12_32.z)

				local var_12_33 = var_12_27.localEulerAngles

				var_12_33.z = 0
				var_12_33.x = 0
				var_12_27.localEulerAngles = var_12_33
			end

			if arg_9_1.time_ >= var_12_28 + var_12_29 and arg_9_1.time_ < var_12_28 + var_12_29 + arg_12_0 then
				var_12_27.localPosition = Vector3.New(0, -1.2, -6)

				local var_12_34 = manager.ui.mainCamera.transform.position - var_12_27.position

				var_12_27.forward = Vector3.New(var_12_34.x, var_12_34.y, var_12_34.z)

				local var_12_35 = var_12_27.localEulerAngles

				var_12_35.z = 0
				var_12_35.x = 0
				var_12_27.localEulerAngles = var_12_35
			end

			local var_12_36 = arg_9_1.actors_["1049ui_story"]
			local var_12_37 = 1.8

			if var_12_37 < arg_9_1.time_ and arg_9_1.time_ <= var_12_37 + arg_12_0 and not isNil(var_12_36) and arg_9_1.var_.characterEffect1049ui_story == nil then
				arg_9_1.var_.characterEffect1049ui_story = var_12_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_38 = 0.200000002980232

			if var_12_37 <= arg_9_1.time_ and arg_9_1.time_ < var_12_37 + var_12_38 and not isNil(var_12_36) then
				local var_12_39 = (arg_9_1.time_ - var_12_37) / var_12_38

				if arg_9_1.var_.characterEffect1049ui_story and not isNil(var_12_36) then
					arg_9_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_37 + var_12_38 and arg_9_1.time_ < var_12_37 + var_12_38 + arg_12_0 and not isNil(var_12_36) and arg_9_1.var_.characterEffect1049ui_story then
				arg_9_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_12_40 = 1.8

			if var_12_40 < arg_9_1.time_ and arg_9_1.time_ <= var_12_40 + arg_12_0 then
				arg_9_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_12_41 = 1.8

			if var_12_41 < arg_9_1.time_ and arg_9_1.time_ <= var_12_41 + arg_12_0 then
				arg_9_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_9_1.frameCnt_ <= 1 then
				arg_9_1.dialog_:SetActive(false)
			end

			local var_12_42 = 2
			local var_12_43 = 0.25

			if var_12_42 < arg_9_1.time_ and arg_9_1.time_ <= var_12_42 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_44 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_44:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_45 = arg_9_1:FormatText(StoryNameCfg[562].name)

				arg_9_1.leftNameTxt_.text = var_12_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_46 = arg_9_1:GetWordFromCfg(318301002)
				local var_12_47 = arg_9_1:FormatText(var_12_46.content)

				arg_9_1.text_.text = var_12_47

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_48 = 10
				local var_12_49 = utf8.len(var_12_47)
				local var_12_50 = var_12_48 <= 0 and var_12_43 or var_12_43 * (var_12_49 / var_12_48)

				if var_12_50 > 0 and var_12_43 < var_12_50 then
					arg_9_1.talkMaxDuration = var_12_50
					var_12_42 = var_12_42 + 0.3

					if var_12_50 + var_12_42 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_50 + var_12_42
					end
				end

				arg_9_1.text_.text = var_12_47
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301002", "story_v_out_318301.awb") ~= 0 then
					local var_12_51 = manager.audio:GetVoiceLength("story_v_out_318301", "318301002", "story_v_out_318301.awb") / 1000

					if var_12_51 + var_12_42 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_51 + var_12_42
					end

					if var_12_46.prefab_name ~= "" and arg_9_1.actors_[var_12_46.prefab_name] ~= nil then
						local var_12_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_46.prefab_name].transform, "story_v_out_318301", "318301002", "story_v_out_318301.awb")

						arg_9_1:RecordAudio("318301002", var_12_52)
						arg_9_1:RecordAudio("318301002", var_12_52)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_318301", "318301002", "story_v_out_318301.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_318301", "318301002", "story_v_out_318301.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_53 = var_12_42 + 0.3
			local var_12_54 = math.max(var_12_43, arg_9_1.talkMaxDuration)

			if var_12_53 <= arg_9_1.time_ and arg_9_1.time_ < var_12_53 + var_12_54 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_53) / var_12_54

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_53 + var_12_54 and arg_9_1.time_ < var_12_53 + var_12_54 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play318301003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 318301003
		arg_15_1.duration_ = 15.1

		local var_15_0 = {
			zh = 7.7,
			ja = 15.1
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
				arg_15_0:Play318301004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 0.625

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_2 = arg_15_1:FormatText(StoryNameCfg[562].name)

				arg_15_1.leftNameTxt_.text = var_18_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_3 = arg_15_1:GetWordFromCfg(318301003)
				local var_18_4 = arg_15_1:FormatText(var_18_3.content)

				arg_15_1.text_.text = var_18_4

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 25
				local var_18_6 = utf8.len(var_18_4)
				local var_18_7 = var_18_5 <= 0 and var_18_1 or var_18_1 * (var_18_6 / var_18_5)

				if var_18_7 > 0 and var_18_1 < var_18_7 then
					arg_15_1.talkMaxDuration = var_18_7

					if var_18_7 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_7 + var_18_0
					end
				end

				arg_15_1.text_.text = var_18_4
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301003", "story_v_out_318301.awb") ~= 0 then
					local var_18_8 = manager.audio:GetVoiceLength("story_v_out_318301", "318301003", "story_v_out_318301.awb") / 1000

					if var_18_8 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_8 + var_18_0
					end

					if var_18_3.prefab_name ~= "" and arg_15_1.actors_[var_18_3.prefab_name] ~= nil then
						local var_18_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_3.prefab_name].transform, "story_v_out_318301", "318301003", "story_v_out_318301.awb")

						arg_15_1:RecordAudio("318301003", var_18_9)
						arg_15_1:RecordAudio("318301003", var_18_9)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_318301", "318301003", "story_v_out_318301.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_318301", "318301003", "story_v_out_318301.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_10 = math.max(var_18_1, arg_15_1.talkMaxDuration)

			if var_18_0 <= arg_15_1.time_ and arg_15_1.time_ < var_18_0 + var_18_10 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_0) / var_18_10

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_0 + var_18_10 and arg_15_1.time_ < var_18_0 + var_18_10 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play318301004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 318301004
		arg_19_1.duration_ = 5.23

		local var_19_0 = {
			zh = 3.766,
			ja = 5.233
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play318301005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = "1199ui_story"

			if arg_19_1.actors_[var_22_0] == nil then
				local var_22_1 = Asset.Load("Char/" .. "1199ui_story")

				if not isNil(var_22_1) then
					local var_22_2 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_19_1.stage_.transform)

					var_22_2.name = var_22_0
					var_22_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_19_1.actors_[var_22_0] = var_22_2

					local var_22_3 = var_22_2:GetComponentInChildren(typeof(CharacterEffect))

					var_22_3.enabled = true

					local var_22_4 = GameObjectTools.GetOrAddComponent(var_22_2, typeof(DynamicBoneHelper))

					if var_22_4 then
						var_22_4:EnableDynamicBone(false)
					end

					arg_19_1:ShowWeapon(var_22_3.transform, false)

					arg_19_1.var_[var_22_0 .. "Animator"] = var_22_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_19_1.var_[var_22_0 .. "Animator"].applyRootMotion = true
					arg_19_1.var_[var_22_0 .. "LipSync"] = var_22_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_22_5 = arg_19_1.actors_["1199ui_story"].transform
			local var_22_6 = 0

			if var_22_6 < arg_19_1.time_ and arg_19_1.time_ <= var_22_6 + arg_22_0 then
				arg_19_1.var_.moveOldPos1199ui_story = var_22_5.localPosition
			end

			local var_22_7 = 0.001

			if var_22_6 <= arg_19_1.time_ and arg_19_1.time_ < var_22_6 + var_22_7 then
				local var_22_8 = (arg_19_1.time_ - var_22_6) / var_22_7
				local var_22_9 = Vector3.New(0, -1.08, -5.9)

				var_22_5.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1199ui_story, var_22_9, var_22_8)

				local var_22_10 = manager.ui.mainCamera.transform.position - var_22_5.position

				var_22_5.forward = Vector3.New(var_22_10.x, var_22_10.y, var_22_10.z)

				local var_22_11 = var_22_5.localEulerAngles

				var_22_11.z = 0
				var_22_11.x = 0
				var_22_5.localEulerAngles = var_22_11
			end

			if arg_19_1.time_ >= var_22_6 + var_22_7 and arg_19_1.time_ < var_22_6 + var_22_7 + arg_22_0 then
				var_22_5.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_22_12 = manager.ui.mainCamera.transform.position - var_22_5.position

				var_22_5.forward = Vector3.New(var_22_12.x, var_22_12.y, var_22_12.z)

				local var_22_13 = var_22_5.localEulerAngles

				var_22_13.z = 0
				var_22_13.x = 0
				var_22_5.localEulerAngles = var_22_13
			end

			local var_22_14 = arg_19_1.actors_["1199ui_story"]
			local var_22_15 = 0

			if var_22_15 < arg_19_1.time_ and arg_19_1.time_ <= var_22_15 + arg_22_0 and not isNil(var_22_14) and arg_19_1.var_.characterEffect1199ui_story == nil then
				arg_19_1.var_.characterEffect1199ui_story = var_22_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_16 = 0.200000002980232

			if var_22_15 <= arg_19_1.time_ and arg_19_1.time_ < var_22_15 + var_22_16 and not isNil(var_22_14) then
				local var_22_17 = (arg_19_1.time_ - var_22_15) / var_22_16

				if arg_19_1.var_.characterEffect1199ui_story and not isNil(var_22_14) then
					arg_19_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= var_22_15 + var_22_16 and arg_19_1.time_ < var_22_15 + var_22_16 + arg_22_0 and not isNil(var_22_14) and arg_19_1.var_.characterEffect1199ui_story then
				arg_19_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_22_18 = 0

			if var_22_18 < arg_19_1.time_ and arg_19_1.time_ <= var_22_18 + arg_22_0 then
				arg_19_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action3_1")
			end

			local var_22_19 = 0

			if var_22_19 < arg_19_1.time_ and arg_19_1.time_ <= var_22_19 + arg_22_0 then
				arg_19_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_22_20 = arg_19_1.actors_["1049ui_story"].transform
			local var_22_21 = 0

			if var_22_21 < arg_19_1.time_ and arg_19_1.time_ <= var_22_21 + arg_22_0 then
				arg_19_1.var_.moveOldPos1049ui_story = var_22_20.localPosition
			end

			local var_22_22 = 0.001

			if var_22_21 <= arg_19_1.time_ and arg_19_1.time_ < var_22_21 + var_22_22 then
				local var_22_23 = (arg_19_1.time_ - var_22_21) / var_22_22
				local var_22_24 = Vector3.New(0, 100, 0)

				var_22_20.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1049ui_story, var_22_24, var_22_23)

				local var_22_25 = manager.ui.mainCamera.transform.position - var_22_20.position

				var_22_20.forward = Vector3.New(var_22_25.x, var_22_25.y, var_22_25.z)

				local var_22_26 = var_22_20.localEulerAngles

				var_22_26.z = 0
				var_22_26.x = 0
				var_22_20.localEulerAngles = var_22_26
			end

			if arg_19_1.time_ >= var_22_21 + var_22_22 and arg_19_1.time_ < var_22_21 + var_22_22 + arg_22_0 then
				var_22_20.localPosition = Vector3.New(0, 100, 0)

				local var_22_27 = manager.ui.mainCamera.transform.position - var_22_20.position

				var_22_20.forward = Vector3.New(var_22_27.x, var_22_27.y, var_22_27.z)

				local var_22_28 = var_22_20.localEulerAngles

				var_22_28.z = 0
				var_22_28.x = 0
				var_22_20.localEulerAngles = var_22_28
			end

			local var_22_29 = arg_19_1.actors_["1049ui_story"]
			local var_22_30 = 0

			if var_22_30 < arg_19_1.time_ and arg_19_1.time_ <= var_22_30 + arg_22_0 and not isNil(var_22_29) and arg_19_1.var_.characterEffect1049ui_story == nil then
				arg_19_1.var_.characterEffect1049ui_story = var_22_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_31 = 0.200000002980232

			if var_22_30 <= arg_19_1.time_ and arg_19_1.time_ < var_22_30 + var_22_31 and not isNil(var_22_29) then
				local var_22_32 = (arg_19_1.time_ - var_22_30) / var_22_31

				if arg_19_1.var_.characterEffect1049ui_story and not isNil(var_22_29) then
					local var_22_33 = Mathf.Lerp(0, 0.5, var_22_32)

					arg_19_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1049ui_story.fillRatio = var_22_33
				end
			end

			if arg_19_1.time_ >= var_22_30 + var_22_31 and arg_19_1.time_ < var_22_30 + var_22_31 + arg_22_0 and not isNil(var_22_29) and arg_19_1.var_.characterEffect1049ui_story then
				local var_22_34 = 0.5

				arg_19_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1049ui_story.fillRatio = var_22_34
			end

			local var_22_35 = 0
			local var_22_36 = 0.275

			if var_22_35 < arg_19_1.time_ and arg_19_1.time_ <= var_22_35 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_37 = arg_19_1:FormatText(StoryNameCfg[84].name)

				arg_19_1.leftNameTxt_.text = var_22_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_38 = arg_19_1:GetWordFromCfg(318301004)
				local var_22_39 = arg_19_1:FormatText(var_22_38.content)

				arg_19_1.text_.text = var_22_39

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_40 = 11
				local var_22_41 = utf8.len(var_22_39)
				local var_22_42 = var_22_40 <= 0 and var_22_36 or var_22_36 * (var_22_41 / var_22_40)

				if var_22_42 > 0 and var_22_36 < var_22_42 then
					arg_19_1.talkMaxDuration = var_22_42

					if var_22_42 + var_22_35 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_42 + var_22_35
					end
				end

				arg_19_1.text_.text = var_22_39
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301004", "story_v_out_318301.awb") ~= 0 then
					local var_22_43 = manager.audio:GetVoiceLength("story_v_out_318301", "318301004", "story_v_out_318301.awb") / 1000

					if var_22_43 + var_22_35 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_43 + var_22_35
					end

					if var_22_38.prefab_name ~= "" and arg_19_1.actors_[var_22_38.prefab_name] ~= nil then
						local var_22_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_38.prefab_name].transform, "story_v_out_318301", "318301004", "story_v_out_318301.awb")

						arg_19_1:RecordAudio("318301004", var_22_44)
						arg_19_1:RecordAudio("318301004", var_22_44)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_318301", "318301004", "story_v_out_318301.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_318301", "318301004", "story_v_out_318301.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_45 = math.max(var_22_36, arg_19_1.talkMaxDuration)

			if var_22_35 <= arg_19_1.time_ and arg_19_1.time_ < var_22_35 + var_22_45 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_35) / var_22_45

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_35 + var_22_45 and arg_19_1.time_ < var_22_35 + var_22_45 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play318301005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 318301005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play318301006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1199ui_story"].transform
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.var_.moveOldPos1199ui_story = var_26_0.localPosition
			end

			local var_26_2 = 0.001

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2
				local var_26_4 = Vector3.New(0, 100, 0)

				var_26_0.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1199ui_story, var_26_4, var_26_3)

				local var_26_5 = manager.ui.mainCamera.transform.position - var_26_0.position

				var_26_0.forward = Vector3.New(var_26_5.x, var_26_5.y, var_26_5.z)

				local var_26_6 = var_26_0.localEulerAngles

				var_26_6.z = 0
				var_26_6.x = 0
				var_26_0.localEulerAngles = var_26_6
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 then
				var_26_0.localPosition = Vector3.New(0, 100, 0)

				local var_26_7 = manager.ui.mainCamera.transform.position - var_26_0.position

				var_26_0.forward = Vector3.New(var_26_7.x, var_26_7.y, var_26_7.z)

				local var_26_8 = var_26_0.localEulerAngles

				var_26_8.z = 0
				var_26_8.x = 0
				var_26_0.localEulerAngles = var_26_8
			end

			local var_26_9 = arg_23_1.actors_["1199ui_story"]
			local var_26_10 = 0

			if var_26_10 < arg_23_1.time_ and arg_23_1.time_ <= var_26_10 + arg_26_0 and not isNil(var_26_9) and arg_23_1.var_.characterEffect1199ui_story == nil then
				arg_23_1.var_.characterEffect1199ui_story = var_26_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_11 = 0.200000002980232

			if var_26_10 <= arg_23_1.time_ and arg_23_1.time_ < var_26_10 + var_26_11 and not isNil(var_26_9) then
				local var_26_12 = (arg_23_1.time_ - var_26_10) / var_26_11

				if arg_23_1.var_.characterEffect1199ui_story and not isNil(var_26_9) then
					local var_26_13 = Mathf.Lerp(0, 0.5, var_26_12)

					arg_23_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1199ui_story.fillRatio = var_26_13
				end
			end

			if arg_23_1.time_ >= var_26_10 + var_26_11 and arg_23_1.time_ < var_26_10 + var_26_11 + arg_26_0 and not isNil(var_26_9) and arg_23_1.var_.characterEffect1199ui_story then
				local var_26_14 = 0.5

				arg_23_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1199ui_story.fillRatio = var_26_14
			end

			local var_26_15 = 0
			local var_26_16 = 0.6

			if var_26_15 < arg_23_1.time_ and arg_23_1.time_ <= var_26_15 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_17 = arg_23_1:GetWordFromCfg(318301005)
				local var_26_18 = arg_23_1:FormatText(var_26_17.content)

				arg_23_1.text_.text = var_26_18

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_19 = 24
				local var_26_20 = utf8.len(var_26_18)
				local var_26_21 = var_26_19 <= 0 and var_26_16 or var_26_16 * (var_26_20 / var_26_19)

				if var_26_21 > 0 and var_26_16 < var_26_21 then
					arg_23_1.talkMaxDuration = var_26_21

					if var_26_21 + var_26_15 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_21 + var_26_15
					end
				end

				arg_23_1.text_.text = var_26_18
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_22 = math.max(var_26_16, arg_23_1.talkMaxDuration)

			if var_26_15 <= arg_23_1.time_ and arg_23_1.time_ < var_26_15 + var_26_22 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_15) / var_26_22

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_15 + var_26_22 and arg_23_1.time_ < var_26_15 + var_26_22 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play318301006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 318301006
		arg_27_1.duration_ = 3.17

		local var_27_0 = {
			zh = 3,
			ja = 3.166
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
				arg_27_0:Play318301007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1049ui_story"].transform
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.var_.moveOldPos1049ui_story = var_30_0.localPosition
			end

			local var_30_2 = 0.001

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2
				local var_30_4 = Vector3.New(0, -1.2, -6)

				var_30_0.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1049ui_story, var_30_4, var_30_3)

				local var_30_5 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_5.x, var_30_5.y, var_30_5.z)

				local var_30_6 = var_30_0.localEulerAngles

				var_30_6.z = 0
				var_30_6.x = 0
				var_30_0.localEulerAngles = var_30_6
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 then
				var_30_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_30_7 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_7.x, var_30_7.y, var_30_7.z)

				local var_30_8 = var_30_0.localEulerAngles

				var_30_8.z = 0
				var_30_8.x = 0
				var_30_0.localEulerAngles = var_30_8
			end

			local var_30_9 = arg_27_1.actors_["1049ui_story"]
			local var_30_10 = 0

			if var_30_10 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 and not isNil(var_30_9) and arg_27_1.var_.characterEffect1049ui_story == nil then
				arg_27_1.var_.characterEffect1049ui_story = var_30_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_11 = 0.200000002980232

			if var_30_10 <= arg_27_1.time_ and arg_27_1.time_ < var_30_10 + var_30_11 and not isNil(var_30_9) then
				local var_30_12 = (arg_27_1.time_ - var_30_10) / var_30_11

				if arg_27_1.var_.characterEffect1049ui_story and not isNil(var_30_9) then
					arg_27_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_10 + var_30_11 and arg_27_1.time_ < var_30_10 + var_30_11 + arg_30_0 and not isNil(var_30_9) and arg_27_1.var_.characterEffect1049ui_story then
				arg_27_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_30_13 = 0

			if var_30_13 < arg_27_1.time_ and arg_27_1.time_ <= var_30_13 + arg_30_0 then
				arg_27_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_30_14 = 0

			if var_30_14 < arg_27_1.time_ and arg_27_1.time_ <= var_30_14 + arg_30_0 then
				arg_27_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_30_15 = 0
			local var_30_16 = 0.325

			if var_30_15 < arg_27_1.time_ and arg_27_1.time_ <= var_30_15 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_17 = arg_27_1:FormatText(StoryNameCfg[562].name)

				arg_27_1.leftNameTxt_.text = var_30_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_18 = arg_27_1:GetWordFromCfg(318301006)
				local var_30_19 = arg_27_1:FormatText(var_30_18.content)

				arg_27_1.text_.text = var_30_19

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_20 = 13
				local var_30_21 = utf8.len(var_30_19)
				local var_30_22 = var_30_20 <= 0 and var_30_16 or var_30_16 * (var_30_21 / var_30_20)

				if var_30_22 > 0 and var_30_16 < var_30_22 then
					arg_27_1.talkMaxDuration = var_30_22

					if var_30_22 + var_30_15 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_22 + var_30_15
					end
				end

				arg_27_1.text_.text = var_30_19
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301006", "story_v_out_318301.awb") ~= 0 then
					local var_30_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301006", "story_v_out_318301.awb") / 1000

					if var_30_23 + var_30_15 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_23 + var_30_15
					end

					if var_30_18.prefab_name ~= "" and arg_27_1.actors_[var_30_18.prefab_name] ~= nil then
						local var_30_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_18.prefab_name].transform, "story_v_out_318301", "318301006", "story_v_out_318301.awb")

						arg_27_1:RecordAudio("318301006", var_30_24)
						arg_27_1:RecordAudio("318301006", var_30_24)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_318301", "318301006", "story_v_out_318301.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_318301", "318301006", "story_v_out_318301.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_25 = math.max(var_30_16, arg_27_1.talkMaxDuration)

			if var_30_15 <= arg_27_1.time_ and arg_27_1.time_ < var_30_15 + var_30_25 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_15) / var_30_25

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_15 + var_30_25 and arg_27_1.time_ < var_30_15 + var_30_25 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play318301007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 318301007
		arg_31_1.duration_ = 3.3

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play318301008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1199ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos1199ui_story = var_34_0.localPosition
			end

			local var_34_2 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2
				local var_34_4 = Vector3.New(0, -1.08, -5.9)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1199ui_story, var_34_4, var_34_3)

				local var_34_5 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_5.x, var_34_5.y, var_34_5.z)

				local var_34_6 = var_34_0.localEulerAngles

				var_34_6.z = 0
				var_34_6.x = 0
				var_34_0.localEulerAngles = var_34_6
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_34_7 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_7.x, var_34_7.y, var_34_7.z)

				local var_34_8 = var_34_0.localEulerAngles

				var_34_8.z = 0
				var_34_8.x = 0
				var_34_0.localEulerAngles = var_34_8
			end

			local var_34_9 = arg_31_1.actors_["1199ui_story"]
			local var_34_10 = 0

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 and not isNil(var_34_9) and arg_31_1.var_.characterEffect1199ui_story == nil then
				arg_31_1.var_.characterEffect1199ui_story = var_34_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_11 = 0.200000002980232

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_11 and not isNil(var_34_9) then
				local var_34_12 = (arg_31_1.time_ - var_34_10) / var_34_11

				if arg_31_1.var_.characterEffect1199ui_story and not isNil(var_34_9) then
					arg_31_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_10 + var_34_11 and arg_31_1.time_ < var_34_10 + var_34_11 + arg_34_0 and not isNil(var_34_9) and arg_31_1.var_.characterEffect1199ui_story then
				arg_31_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_34_13 = 0

			if var_34_13 < arg_31_1.time_ and arg_31_1.time_ <= var_34_13 + arg_34_0 then
				arg_31_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action3_2")
			end

			local var_34_14 = 0

			if var_34_14 < arg_31_1.time_ and arg_31_1.time_ <= var_34_14 + arg_34_0 then
				arg_31_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_34_15 = arg_31_1.actors_["1049ui_story"].transform
			local var_34_16 = 0

			if var_34_16 < arg_31_1.time_ and arg_31_1.time_ <= var_34_16 + arg_34_0 then
				arg_31_1.var_.moveOldPos1049ui_story = var_34_15.localPosition
			end

			local var_34_17 = 0.001

			if var_34_16 <= arg_31_1.time_ and arg_31_1.time_ < var_34_16 + var_34_17 then
				local var_34_18 = (arg_31_1.time_ - var_34_16) / var_34_17
				local var_34_19 = Vector3.New(0, 100, 0)

				var_34_15.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1049ui_story, var_34_19, var_34_18)

				local var_34_20 = manager.ui.mainCamera.transform.position - var_34_15.position

				var_34_15.forward = Vector3.New(var_34_20.x, var_34_20.y, var_34_20.z)

				local var_34_21 = var_34_15.localEulerAngles

				var_34_21.z = 0
				var_34_21.x = 0
				var_34_15.localEulerAngles = var_34_21
			end

			if arg_31_1.time_ >= var_34_16 + var_34_17 and arg_31_1.time_ < var_34_16 + var_34_17 + arg_34_0 then
				var_34_15.localPosition = Vector3.New(0, 100, 0)

				local var_34_22 = manager.ui.mainCamera.transform.position - var_34_15.position

				var_34_15.forward = Vector3.New(var_34_22.x, var_34_22.y, var_34_22.z)

				local var_34_23 = var_34_15.localEulerAngles

				var_34_23.z = 0
				var_34_23.x = 0
				var_34_15.localEulerAngles = var_34_23
			end

			local var_34_24 = arg_31_1.actors_["1049ui_story"]
			local var_34_25 = 0

			if var_34_25 < arg_31_1.time_ and arg_31_1.time_ <= var_34_25 + arg_34_0 and not isNil(var_34_24) and arg_31_1.var_.characterEffect1049ui_story == nil then
				arg_31_1.var_.characterEffect1049ui_story = var_34_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_26 = 0.200000002980232

			if var_34_25 <= arg_31_1.time_ and arg_31_1.time_ < var_34_25 + var_34_26 and not isNil(var_34_24) then
				local var_34_27 = (arg_31_1.time_ - var_34_25) / var_34_26

				if arg_31_1.var_.characterEffect1049ui_story and not isNil(var_34_24) then
					local var_34_28 = Mathf.Lerp(0, 0.5, var_34_27)

					arg_31_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1049ui_story.fillRatio = var_34_28
				end
			end

			if arg_31_1.time_ >= var_34_25 + var_34_26 and arg_31_1.time_ < var_34_25 + var_34_26 + arg_34_0 and not isNil(var_34_24) and arg_31_1.var_.characterEffect1049ui_story then
				local var_34_29 = 0.5

				arg_31_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1049ui_story.fillRatio = var_34_29
			end

			local var_34_30 = 0
			local var_34_31 = 0.225

			if var_34_30 < arg_31_1.time_ and arg_31_1.time_ <= var_34_30 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_32 = arg_31_1:FormatText(StoryNameCfg[84].name)

				arg_31_1.leftNameTxt_.text = var_34_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_33 = arg_31_1:GetWordFromCfg(318301007)
				local var_34_34 = arg_31_1:FormatText(var_34_33.content)

				arg_31_1.text_.text = var_34_34

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_35 = 9
				local var_34_36 = utf8.len(var_34_34)
				local var_34_37 = var_34_35 <= 0 and var_34_31 or var_34_31 * (var_34_36 / var_34_35)

				if var_34_37 > 0 and var_34_31 < var_34_37 then
					arg_31_1.talkMaxDuration = var_34_37

					if var_34_37 + var_34_30 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_37 + var_34_30
					end
				end

				arg_31_1.text_.text = var_34_34
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301007", "story_v_out_318301.awb") ~= 0 then
					local var_34_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301007", "story_v_out_318301.awb") / 1000

					if var_34_38 + var_34_30 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_38 + var_34_30
					end

					if var_34_33.prefab_name ~= "" and arg_31_1.actors_[var_34_33.prefab_name] ~= nil then
						local var_34_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_33.prefab_name].transform, "story_v_out_318301", "318301007", "story_v_out_318301.awb")

						arg_31_1:RecordAudio("318301007", var_34_39)
						arg_31_1:RecordAudio("318301007", var_34_39)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_318301", "318301007", "story_v_out_318301.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_318301", "318301007", "story_v_out_318301.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_40 = math.max(var_34_31, arg_31_1.talkMaxDuration)

			if var_34_30 <= arg_31_1.time_ and arg_31_1.time_ < var_34_30 + var_34_40 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_30) / var_34_40

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_30 + var_34_40 and arg_31_1.time_ < var_34_30 + var_34_40 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play318301008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 318301008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play318301009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1199ui_story"].transform
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.moveOldPos1199ui_story = var_38_0.localPosition
			end

			local var_38_2 = 0.001

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2
				local var_38_4 = Vector3.New(0, 100, 0)

				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1199ui_story, var_38_4, var_38_3)

				local var_38_5 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_5.x, var_38_5.y, var_38_5.z)

				local var_38_6 = var_38_0.localEulerAngles

				var_38_6.z = 0
				var_38_6.x = 0
				var_38_0.localEulerAngles = var_38_6
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(0, 100, 0)

				local var_38_7 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_7.x, var_38_7.y, var_38_7.z)

				local var_38_8 = var_38_0.localEulerAngles

				var_38_8.z = 0
				var_38_8.x = 0
				var_38_0.localEulerAngles = var_38_8
			end

			local var_38_9 = arg_35_1.actors_["1199ui_story"]
			local var_38_10 = 0

			if var_38_10 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 and not isNil(var_38_9) and arg_35_1.var_.characterEffect1199ui_story == nil then
				arg_35_1.var_.characterEffect1199ui_story = var_38_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_11 = 0.200000002980232

			if var_38_10 <= arg_35_1.time_ and arg_35_1.time_ < var_38_10 + var_38_11 and not isNil(var_38_9) then
				local var_38_12 = (arg_35_1.time_ - var_38_10) / var_38_11

				if arg_35_1.var_.characterEffect1199ui_story and not isNil(var_38_9) then
					local var_38_13 = Mathf.Lerp(0, 0.5, var_38_12)

					arg_35_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1199ui_story.fillRatio = var_38_13
				end
			end

			if arg_35_1.time_ >= var_38_10 + var_38_11 and arg_35_1.time_ < var_38_10 + var_38_11 + arg_38_0 and not isNil(var_38_9) and arg_35_1.var_.characterEffect1199ui_story then
				local var_38_14 = 0.5

				arg_35_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1199ui_story.fillRatio = var_38_14
			end

			local var_38_15 = 0
			local var_38_16 = 1.275

			if var_38_15 < arg_35_1.time_ and arg_35_1.time_ <= var_38_15 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_17 = arg_35_1:GetWordFromCfg(318301008)
				local var_38_18 = arg_35_1:FormatText(var_38_17.content)

				arg_35_1.text_.text = var_38_18

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_19 = 51
				local var_38_20 = utf8.len(var_38_18)
				local var_38_21 = var_38_19 <= 0 and var_38_16 or var_38_16 * (var_38_20 / var_38_19)

				if var_38_21 > 0 and var_38_16 < var_38_21 then
					arg_35_1.talkMaxDuration = var_38_21

					if var_38_21 + var_38_15 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_21 + var_38_15
					end
				end

				arg_35_1.text_.text = var_38_18
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_22 = math.max(var_38_16, arg_35_1.talkMaxDuration)

			if var_38_15 <= arg_35_1.time_ and arg_35_1.time_ < var_38_15 + var_38_22 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_15) / var_38_22

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_15 + var_38_22 and arg_35_1.time_ < var_38_15 + var_38_22 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play318301009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 318301009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play318301010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.8

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_2 = arg_39_1:GetWordFromCfg(318301009)
				local var_42_3 = arg_39_1:FormatText(var_42_2.content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 32
				local var_42_5 = utf8.len(var_42_3)
				local var_42_6 = var_42_4 <= 0 and var_42_1 or var_42_1 * (var_42_5 / var_42_4)

				if var_42_6 > 0 and var_42_1 < var_42_6 then
					arg_39_1.talkMaxDuration = var_42_6

					if var_42_6 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_6 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_7 and arg_39_1.time_ < var_42_0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play318301010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 318301010
		arg_43_1.duration_ = 4.83

		local var_43_0 = {
			zh = 3.766,
			ja = 4.833
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
				arg_43_0:Play318301011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1199ui_story"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos1199ui_story = var_46_0.localPosition
			end

			local var_46_2 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2
				local var_46_4 = Vector3.New(0, -1.08, -5.9)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1199ui_story, var_46_4, var_46_3)

				local var_46_5 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_5.x, var_46_5.y, var_46_5.z)

				local var_46_6 = var_46_0.localEulerAngles

				var_46_6.z = 0
				var_46_6.x = 0
				var_46_0.localEulerAngles = var_46_6
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_46_7 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_7.x, var_46_7.y, var_46_7.z)

				local var_46_8 = var_46_0.localEulerAngles

				var_46_8.z = 0
				var_46_8.x = 0
				var_46_0.localEulerAngles = var_46_8
			end

			local var_46_9 = arg_43_1.actors_["1199ui_story"]
			local var_46_10 = 0

			if var_46_10 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect1199ui_story == nil then
				arg_43_1.var_.characterEffect1199ui_story = var_46_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_11 = 0.200000002980232

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_11 and not isNil(var_46_9) then
				local var_46_12 = (arg_43_1.time_ - var_46_10) / var_46_11

				if arg_43_1.var_.characterEffect1199ui_story and not isNil(var_46_9) then
					arg_43_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_10 + var_46_11 and arg_43_1.time_ < var_46_10 + var_46_11 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect1199ui_story then
				arg_43_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_46_13 = 0

			if var_46_13 < arg_43_1.time_ and arg_43_1.time_ <= var_46_13 + arg_46_0 then
				arg_43_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			local var_46_14 = 0

			if var_46_14 < arg_43_1.time_ and arg_43_1.time_ <= var_46_14 + arg_46_0 then
				arg_43_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_15 = 0
			local var_46_16 = 0.225

			if var_46_15 < arg_43_1.time_ and arg_43_1.time_ <= var_46_15 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_17 = arg_43_1:FormatText(StoryNameCfg[84].name)

				arg_43_1.leftNameTxt_.text = var_46_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_18 = arg_43_1:GetWordFromCfg(318301010)
				local var_46_19 = arg_43_1:FormatText(var_46_18.content)

				arg_43_1.text_.text = var_46_19

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_20 = 9
				local var_46_21 = utf8.len(var_46_19)
				local var_46_22 = var_46_20 <= 0 and var_46_16 or var_46_16 * (var_46_21 / var_46_20)

				if var_46_22 > 0 and var_46_16 < var_46_22 then
					arg_43_1.talkMaxDuration = var_46_22

					if var_46_22 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_22 + var_46_15
					end
				end

				arg_43_1.text_.text = var_46_19
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301010", "story_v_out_318301.awb") ~= 0 then
					local var_46_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301010", "story_v_out_318301.awb") / 1000

					if var_46_23 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_23 + var_46_15
					end

					if var_46_18.prefab_name ~= "" and arg_43_1.actors_[var_46_18.prefab_name] ~= nil then
						local var_46_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_18.prefab_name].transform, "story_v_out_318301", "318301010", "story_v_out_318301.awb")

						arg_43_1:RecordAudio("318301010", var_46_24)
						arg_43_1:RecordAudio("318301010", var_46_24)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_318301", "318301010", "story_v_out_318301.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_318301", "318301010", "story_v_out_318301.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_25 = math.max(var_46_16, arg_43_1.talkMaxDuration)

			if var_46_15 <= arg_43_1.time_ and arg_43_1.time_ < var_46_15 + var_46_25 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_15) / var_46_25

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_15 + var_46_25 and arg_43_1.time_ < var_46_15 + var_46_25 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play318301011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 318301011
		arg_47_1.duration_ = 2.93

		local var_47_0 = {
			zh = 1.999999999999,
			ja = 2.933
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
				arg_47_0:Play318301012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_50_2 = 0
			local var_50_3 = 0.125

			if var_50_2 < arg_47_1.time_ and arg_47_1.time_ <= var_50_2 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_4 = arg_47_1:FormatText(StoryNameCfg[84].name)

				arg_47_1.leftNameTxt_.text = var_50_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_5 = arg_47_1:GetWordFromCfg(318301011)
				local var_50_6 = arg_47_1:FormatText(var_50_5.content)

				arg_47_1.text_.text = var_50_6

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_7 = 5
				local var_50_8 = utf8.len(var_50_6)
				local var_50_9 = var_50_7 <= 0 and var_50_3 or var_50_3 * (var_50_8 / var_50_7)

				if var_50_9 > 0 and var_50_3 < var_50_9 then
					arg_47_1.talkMaxDuration = var_50_9

					if var_50_9 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_2
					end
				end

				arg_47_1.text_.text = var_50_6
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301011", "story_v_out_318301.awb") ~= 0 then
					local var_50_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301011", "story_v_out_318301.awb") / 1000

					if var_50_10 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_2
					end

					if var_50_5.prefab_name ~= "" and arg_47_1.actors_[var_50_5.prefab_name] ~= nil then
						local var_50_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_5.prefab_name].transform, "story_v_out_318301", "318301011", "story_v_out_318301.awb")

						arg_47_1:RecordAudio("318301011", var_50_11)
						arg_47_1:RecordAudio("318301011", var_50_11)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_318301", "318301011", "story_v_out_318301.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_318301", "318301011", "story_v_out_318301.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_12 = math.max(var_50_3, arg_47_1.talkMaxDuration)

			if var_50_2 <= arg_47_1.time_ and arg_47_1.time_ < var_50_2 + var_50_12 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_2) / var_50_12

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_2 + var_50_12 and arg_47_1.time_ < var_50_2 + var_50_12 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play318301012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 318301012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play318301013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1199ui_story"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos1199ui_story = var_54_0.localPosition
			end

			local var_54_2 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2
				local var_54_4 = Vector3.New(0, 100, 0)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1199ui_story, var_54_4, var_54_3)

				local var_54_5 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_5.x, var_54_5.y, var_54_5.z)

				local var_54_6 = var_54_0.localEulerAngles

				var_54_6.z = 0
				var_54_6.x = 0
				var_54_0.localEulerAngles = var_54_6
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(0, 100, 0)

				local var_54_7 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_7.x, var_54_7.y, var_54_7.z)

				local var_54_8 = var_54_0.localEulerAngles

				var_54_8.z = 0
				var_54_8.x = 0
				var_54_0.localEulerAngles = var_54_8
			end

			local var_54_9 = arg_51_1.actors_["1199ui_story"]
			local var_54_10 = 0

			if var_54_10 < arg_51_1.time_ and arg_51_1.time_ <= var_54_10 + arg_54_0 and not isNil(var_54_9) and arg_51_1.var_.characterEffect1199ui_story == nil then
				arg_51_1.var_.characterEffect1199ui_story = var_54_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_11 = 0.200000002980232

			if var_54_10 <= arg_51_1.time_ and arg_51_1.time_ < var_54_10 + var_54_11 and not isNil(var_54_9) then
				local var_54_12 = (arg_51_1.time_ - var_54_10) / var_54_11

				if arg_51_1.var_.characterEffect1199ui_story and not isNil(var_54_9) then
					local var_54_13 = Mathf.Lerp(0, 0.5, var_54_12)

					arg_51_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1199ui_story.fillRatio = var_54_13
				end
			end

			if arg_51_1.time_ >= var_54_10 + var_54_11 and arg_51_1.time_ < var_54_10 + var_54_11 + arg_54_0 and not isNil(var_54_9) and arg_51_1.var_.characterEffect1199ui_story then
				local var_54_14 = 0.5

				arg_51_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1199ui_story.fillRatio = var_54_14
			end

			local var_54_15 = 0
			local var_54_16 = 0.7

			if var_54_15 < arg_51_1.time_ and arg_51_1.time_ <= var_54_15 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_17 = arg_51_1:GetWordFromCfg(318301012)
				local var_54_18 = arg_51_1:FormatText(var_54_17.content)

				arg_51_1.text_.text = var_54_18

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_19 = 28
				local var_54_20 = utf8.len(var_54_18)
				local var_54_21 = var_54_19 <= 0 and var_54_16 or var_54_16 * (var_54_20 / var_54_19)

				if var_54_21 > 0 and var_54_16 < var_54_21 then
					arg_51_1.talkMaxDuration = var_54_21

					if var_54_21 + var_54_15 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_21 + var_54_15
					end
				end

				arg_51_1.text_.text = var_54_18
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_22 = math.max(var_54_16, arg_51_1.talkMaxDuration)

			if var_54_15 <= arg_51_1.time_ and arg_51_1.time_ < var_54_15 + var_54_22 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_15) / var_54_22

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_15 + var_54_22 and arg_51_1.time_ < var_54_15 + var_54_22 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play318301013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 318301013
		arg_55_1.duration_ = 3.3

		local var_55_0 = {
			zh = 1.4,
			ja = 3.3
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
				arg_55_0:Play318301014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1049ui_story"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1049ui_story = var_58_0.localPosition
			end

			local var_58_2 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2
				local var_58_4 = Vector3.New(0, -1.2, -6)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1049ui_story, var_58_4, var_58_3)

				local var_58_5 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_5.x, var_58_5.y, var_58_5.z)

				local var_58_6 = var_58_0.localEulerAngles

				var_58_6.z = 0
				var_58_6.x = 0
				var_58_0.localEulerAngles = var_58_6
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_58_7 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_7.x, var_58_7.y, var_58_7.z)

				local var_58_8 = var_58_0.localEulerAngles

				var_58_8.z = 0
				var_58_8.x = 0
				var_58_0.localEulerAngles = var_58_8
			end

			local var_58_9 = arg_55_1.actors_["1049ui_story"]
			local var_58_10 = 0

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 and not isNil(var_58_9) and arg_55_1.var_.characterEffect1049ui_story == nil then
				arg_55_1.var_.characterEffect1049ui_story = var_58_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_11 = 0.200000002980232

			if var_58_10 <= arg_55_1.time_ and arg_55_1.time_ < var_58_10 + var_58_11 and not isNil(var_58_9) then
				local var_58_12 = (arg_55_1.time_ - var_58_10) / var_58_11

				if arg_55_1.var_.characterEffect1049ui_story and not isNil(var_58_9) then
					arg_55_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_10 + var_58_11 and arg_55_1.time_ < var_58_10 + var_58_11 + arg_58_0 and not isNil(var_58_9) and arg_55_1.var_.characterEffect1049ui_story then
				arg_55_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_58_13 = 0

			if var_58_13 < arg_55_1.time_ and arg_55_1.time_ <= var_58_13 + arg_58_0 then
				arg_55_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_58_14 = 0

			if var_58_14 < arg_55_1.time_ and arg_55_1.time_ <= var_58_14 + arg_58_0 then
				arg_55_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_15 = 0
			local var_58_16 = 0.15

			if var_58_15 < arg_55_1.time_ and arg_55_1.time_ <= var_58_15 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_17 = arg_55_1:FormatText(StoryNameCfg[562].name)

				arg_55_1.leftNameTxt_.text = var_58_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_18 = arg_55_1:GetWordFromCfg(318301013)
				local var_58_19 = arg_55_1:FormatText(var_58_18.content)

				arg_55_1.text_.text = var_58_19

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_20 = 6
				local var_58_21 = utf8.len(var_58_19)
				local var_58_22 = var_58_20 <= 0 and var_58_16 or var_58_16 * (var_58_21 / var_58_20)

				if var_58_22 > 0 and var_58_16 < var_58_22 then
					arg_55_1.talkMaxDuration = var_58_22

					if var_58_22 + var_58_15 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_22 + var_58_15
					end
				end

				arg_55_1.text_.text = var_58_19
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301013", "story_v_out_318301.awb") ~= 0 then
					local var_58_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301013", "story_v_out_318301.awb") / 1000

					if var_58_23 + var_58_15 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_23 + var_58_15
					end

					if var_58_18.prefab_name ~= "" and arg_55_1.actors_[var_58_18.prefab_name] ~= nil then
						local var_58_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_18.prefab_name].transform, "story_v_out_318301", "318301013", "story_v_out_318301.awb")

						arg_55_1:RecordAudio("318301013", var_58_24)
						arg_55_1:RecordAudio("318301013", var_58_24)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_318301", "318301013", "story_v_out_318301.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_318301", "318301013", "story_v_out_318301.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_25 = math.max(var_58_16, arg_55_1.talkMaxDuration)

			if var_58_15 <= arg_55_1.time_ and arg_55_1.time_ < var_58_15 + var_58_25 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_15) / var_58_25

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_15 + var_58_25 and arg_55_1.time_ < var_58_15 + var_58_25 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play318301014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 318301014
		arg_59_1.duration_ = 3.1

		local var_59_0 = {
			zh = 1.999999999999,
			ja = 3.1
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play318301015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1199ui_story"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos1199ui_story = var_62_0.localPosition
			end

			local var_62_2 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2
				local var_62_4 = Vector3.New(0, -1.08, -5.9)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1199ui_story, var_62_4, var_62_3)

				local var_62_5 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_5.x, var_62_5.y, var_62_5.z)

				local var_62_6 = var_62_0.localEulerAngles

				var_62_6.z = 0
				var_62_6.x = 0
				var_62_0.localEulerAngles = var_62_6
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_62_7 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_7.x, var_62_7.y, var_62_7.z)

				local var_62_8 = var_62_0.localEulerAngles

				var_62_8.z = 0
				var_62_8.x = 0
				var_62_0.localEulerAngles = var_62_8
			end

			local var_62_9 = arg_59_1.actors_["1199ui_story"]
			local var_62_10 = 0

			if var_62_10 < arg_59_1.time_ and arg_59_1.time_ <= var_62_10 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect1199ui_story == nil then
				arg_59_1.var_.characterEffect1199ui_story = var_62_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_11 = 0.200000002980232

			if var_62_10 <= arg_59_1.time_ and arg_59_1.time_ < var_62_10 + var_62_11 and not isNil(var_62_9) then
				local var_62_12 = (arg_59_1.time_ - var_62_10) / var_62_11

				if arg_59_1.var_.characterEffect1199ui_story and not isNil(var_62_9) then
					arg_59_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_10 + var_62_11 and arg_59_1.time_ < var_62_10 + var_62_11 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect1199ui_story then
				arg_59_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_62_13 = 0

			if var_62_13 < arg_59_1.time_ and arg_59_1.time_ <= var_62_13 + arg_62_0 then
				arg_59_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action3_1")
			end

			local var_62_14 = 0

			if var_62_14 < arg_59_1.time_ and arg_59_1.time_ <= var_62_14 + arg_62_0 then
				arg_59_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_15 = arg_59_1.actors_["1049ui_story"].transform
			local var_62_16 = 0

			if var_62_16 < arg_59_1.time_ and arg_59_1.time_ <= var_62_16 + arg_62_0 then
				arg_59_1.var_.moveOldPos1049ui_story = var_62_15.localPosition
			end

			local var_62_17 = 0.001

			if var_62_16 <= arg_59_1.time_ and arg_59_1.time_ < var_62_16 + var_62_17 then
				local var_62_18 = (arg_59_1.time_ - var_62_16) / var_62_17
				local var_62_19 = Vector3.New(0, 100, 0)

				var_62_15.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1049ui_story, var_62_19, var_62_18)

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

			local var_62_24 = arg_59_1.actors_["1049ui_story"]
			local var_62_25 = 0

			if var_62_25 < arg_59_1.time_ and arg_59_1.time_ <= var_62_25 + arg_62_0 and not isNil(var_62_24) and arg_59_1.var_.characterEffect1049ui_story == nil then
				arg_59_1.var_.characterEffect1049ui_story = var_62_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_26 = 0.200000002980232

			if var_62_25 <= arg_59_1.time_ and arg_59_1.time_ < var_62_25 + var_62_26 and not isNil(var_62_24) then
				local var_62_27 = (arg_59_1.time_ - var_62_25) / var_62_26

				if arg_59_1.var_.characterEffect1049ui_story and not isNil(var_62_24) then
					local var_62_28 = Mathf.Lerp(0, 0.5, var_62_27)

					arg_59_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1049ui_story.fillRatio = var_62_28
				end
			end

			if arg_59_1.time_ >= var_62_25 + var_62_26 and arg_59_1.time_ < var_62_25 + var_62_26 + arg_62_0 and not isNil(var_62_24) and arg_59_1.var_.characterEffect1049ui_story then
				local var_62_29 = 0.5

				arg_59_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1049ui_story.fillRatio = var_62_29
			end

			local var_62_30 = 0
			local var_62_31 = 0.175

			if var_62_30 < arg_59_1.time_ and arg_59_1.time_ <= var_62_30 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_32 = arg_59_1:FormatText(StoryNameCfg[84].name)

				arg_59_1.leftNameTxt_.text = var_62_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_33 = arg_59_1:GetWordFromCfg(318301014)
				local var_62_34 = arg_59_1:FormatText(var_62_33.content)

				arg_59_1.text_.text = var_62_34

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_35 = 7
				local var_62_36 = utf8.len(var_62_34)
				local var_62_37 = var_62_35 <= 0 and var_62_31 or var_62_31 * (var_62_36 / var_62_35)

				if var_62_37 > 0 and var_62_31 < var_62_37 then
					arg_59_1.talkMaxDuration = var_62_37

					if var_62_37 + var_62_30 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_37 + var_62_30
					end
				end

				arg_59_1.text_.text = var_62_34
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301014", "story_v_out_318301.awb") ~= 0 then
					local var_62_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301014", "story_v_out_318301.awb") / 1000

					if var_62_38 + var_62_30 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_38 + var_62_30
					end

					if var_62_33.prefab_name ~= "" and arg_59_1.actors_[var_62_33.prefab_name] ~= nil then
						local var_62_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_33.prefab_name].transform, "story_v_out_318301", "318301014", "story_v_out_318301.awb")

						arg_59_1:RecordAudio("318301014", var_62_39)
						arg_59_1:RecordAudio("318301014", var_62_39)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_318301", "318301014", "story_v_out_318301.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_318301", "318301014", "story_v_out_318301.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_40 = math.max(var_62_31, arg_59_1.talkMaxDuration)

			if var_62_30 <= arg_59_1.time_ and arg_59_1.time_ < var_62_30 + var_62_40 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_30) / var_62_40

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_30 + var_62_40 and arg_59_1.time_ < var_62_30 + var_62_40 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play318301015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 318301015
		arg_63_1.duration_ = 5.43

		local var_63_0 = {
			zh = 4.7,
			ja = 5.433
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play318301016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1049ui_story"].transform
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.var_.moveOldPos1049ui_story = var_66_0.localPosition
			end

			local var_66_2 = 0.001

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2
				local var_66_4 = Vector3.New(0, -1.2, -6)

				var_66_0.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1049ui_story, var_66_4, var_66_3)

				local var_66_5 = manager.ui.mainCamera.transform.position - var_66_0.position

				var_66_0.forward = Vector3.New(var_66_5.x, var_66_5.y, var_66_5.z)

				local var_66_6 = var_66_0.localEulerAngles

				var_66_6.z = 0
				var_66_6.x = 0
				var_66_0.localEulerAngles = var_66_6
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 then
				var_66_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_66_7 = manager.ui.mainCamera.transform.position - var_66_0.position

				var_66_0.forward = Vector3.New(var_66_7.x, var_66_7.y, var_66_7.z)

				local var_66_8 = var_66_0.localEulerAngles

				var_66_8.z = 0
				var_66_8.x = 0
				var_66_0.localEulerAngles = var_66_8
			end

			local var_66_9 = arg_63_1.actors_["1049ui_story"]
			local var_66_10 = 0

			if var_66_10 < arg_63_1.time_ and arg_63_1.time_ <= var_66_10 + arg_66_0 and not isNil(var_66_9) and arg_63_1.var_.characterEffect1049ui_story == nil then
				arg_63_1.var_.characterEffect1049ui_story = var_66_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_11 = 0.200000002980232

			if var_66_10 <= arg_63_1.time_ and arg_63_1.time_ < var_66_10 + var_66_11 and not isNil(var_66_9) then
				local var_66_12 = (arg_63_1.time_ - var_66_10) / var_66_11

				if arg_63_1.var_.characterEffect1049ui_story and not isNil(var_66_9) then
					arg_63_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_10 + var_66_11 and arg_63_1.time_ < var_66_10 + var_66_11 + arg_66_0 and not isNil(var_66_9) and arg_63_1.var_.characterEffect1049ui_story then
				arg_63_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_66_13 = 0

			if var_66_13 < arg_63_1.time_ and arg_63_1.time_ <= var_66_13 + arg_66_0 then
				arg_63_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_66_14 = 0

			if var_66_14 < arg_63_1.time_ and arg_63_1.time_ <= var_66_14 + arg_66_0 then
				arg_63_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_66_15 = arg_63_1.actors_["1199ui_story"].transform
			local var_66_16 = 0

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				arg_63_1.var_.moveOldPos1199ui_story = var_66_15.localPosition
			end

			local var_66_17 = 0.001

			if var_66_16 <= arg_63_1.time_ and arg_63_1.time_ < var_66_16 + var_66_17 then
				local var_66_18 = (arg_63_1.time_ - var_66_16) / var_66_17
				local var_66_19 = Vector3.New(0, 100, 0)

				var_66_15.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1199ui_story, var_66_19, var_66_18)

				local var_66_20 = manager.ui.mainCamera.transform.position - var_66_15.position

				var_66_15.forward = Vector3.New(var_66_20.x, var_66_20.y, var_66_20.z)

				local var_66_21 = var_66_15.localEulerAngles

				var_66_21.z = 0
				var_66_21.x = 0
				var_66_15.localEulerAngles = var_66_21
			end

			if arg_63_1.time_ >= var_66_16 + var_66_17 and arg_63_1.time_ < var_66_16 + var_66_17 + arg_66_0 then
				var_66_15.localPosition = Vector3.New(0, 100, 0)

				local var_66_22 = manager.ui.mainCamera.transform.position - var_66_15.position

				var_66_15.forward = Vector3.New(var_66_22.x, var_66_22.y, var_66_22.z)

				local var_66_23 = var_66_15.localEulerAngles

				var_66_23.z = 0
				var_66_23.x = 0
				var_66_15.localEulerAngles = var_66_23
			end

			local var_66_24 = arg_63_1.actors_["1199ui_story"]
			local var_66_25 = 0

			if var_66_25 < arg_63_1.time_ and arg_63_1.time_ <= var_66_25 + arg_66_0 and not isNil(var_66_24) and arg_63_1.var_.characterEffect1199ui_story == nil then
				arg_63_1.var_.characterEffect1199ui_story = var_66_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_26 = 0.200000002980232

			if var_66_25 <= arg_63_1.time_ and arg_63_1.time_ < var_66_25 + var_66_26 and not isNil(var_66_24) then
				local var_66_27 = (arg_63_1.time_ - var_66_25) / var_66_26

				if arg_63_1.var_.characterEffect1199ui_story and not isNil(var_66_24) then
					local var_66_28 = Mathf.Lerp(0, 0.5, var_66_27)

					arg_63_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1199ui_story.fillRatio = var_66_28
				end
			end

			if arg_63_1.time_ >= var_66_25 + var_66_26 and arg_63_1.time_ < var_66_25 + var_66_26 + arg_66_0 and not isNil(var_66_24) and arg_63_1.var_.characterEffect1199ui_story then
				local var_66_29 = 0.5

				arg_63_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1199ui_story.fillRatio = var_66_29
			end

			local var_66_30 = 0
			local var_66_31 = 0.25

			if var_66_30 < arg_63_1.time_ and arg_63_1.time_ <= var_66_30 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_32 = arg_63_1:FormatText(StoryNameCfg[562].name)

				arg_63_1.leftNameTxt_.text = var_66_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_33 = arg_63_1:GetWordFromCfg(318301015)
				local var_66_34 = arg_63_1:FormatText(var_66_33.content)

				arg_63_1.text_.text = var_66_34

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_35 = 10
				local var_66_36 = utf8.len(var_66_34)
				local var_66_37 = var_66_35 <= 0 and var_66_31 or var_66_31 * (var_66_36 / var_66_35)

				if var_66_37 > 0 and var_66_31 < var_66_37 then
					arg_63_1.talkMaxDuration = var_66_37

					if var_66_37 + var_66_30 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_37 + var_66_30
					end
				end

				arg_63_1.text_.text = var_66_34
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301015", "story_v_out_318301.awb") ~= 0 then
					local var_66_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301015", "story_v_out_318301.awb") / 1000

					if var_66_38 + var_66_30 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_38 + var_66_30
					end

					if var_66_33.prefab_name ~= "" and arg_63_1.actors_[var_66_33.prefab_name] ~= nil then
						local var_66_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_33.prefab_name].transform, "story_v_out_318301", "318301015", "story_v_out_318301.awb")

						arg_63_1:RecordAudio("318301015", var_66_39)
						arg_63_1:RecordAudio("318301015", var_66_39)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_318301", "318301015", "story_v_out_318301.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_318301", "318301015", "story_v_out_318301.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_40 = math.max(var_66_31, arg_63_1.talkMaxDuration)

			if var_66_30 <= arg_63_1.time_ and arg_63_1.time_ < var_66_30 + var_66_40 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_30) / var_66_40

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_30 + var_66_40 and arg_63_1.time_ < var_66_30 + var_66_40 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play318301016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 318301016
		arg_67_1.duration_ = 3.73

		local var_67_0 = {
			zh = 3.733,
			ja = 2.5
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play318301017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1199ui_story"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1199ui_story = var_70_0.localPosition
			end

			local var_70_2 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2
				local var_70_4 = Vector3.New(0, -1.08, -5.9)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1199ui_story, var_70_4, var_70_3)

				local var_70_5 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_5.x, var_70_5.y, var_70_5.z)

				local var_70_6 = var_70_0.localEulerAngles

				var_70_6.z = 0
				var_70_6.x = 0
				var_70_0.localEulerAngles = var_70_6
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_70_7 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_7.x, var_70_7.y, var_70_7.z)

				local var_70_8 = var_70_0.localEulerAngles

				var_70_8.z = 0
				var_70_8.x = 0
				var_70_0.localEulerAngles = var_70_8
			end

			local var_70_9 = arg_67_1.actors_["1199ui_story"]
			local var_70_10 = 0

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 and not isNil(var_70_9) and arg_67_1.var_.characterEffect1199ui_story == nil then
				arg_67_1.var_.characterEffect1199ui_story = var_70_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_11 = 0.200000002980232

			if var_70_10 <= arg_67_1.time_ and arg_67_1.time_ < var_70_10 + var_70_11 and not isNil(var_70_9) then
				local var_70_12 = (arg_67_1.time_ - var_70_10) / var_70_11

				if arg_67_1.var_.characterEffect1199ui_story and not isNil(var_70_9) then
					arg_67_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_10 + var_70_11 and arg_67_1.time_ < var_70_10 + var_70_11 + arg_70_0 and not isNil(var_70_9) and arg_67_1.var_.characterEffect1199ui_story then
				arg_67_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_70_13 = 0

			if var_70_13 < arg_67_1.time_ and arg_67_1.time_ <= var_70_13 + arg_70_0 then
				arg_67_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			local var_70_14 = 0

			if var_70_14 < arg_67_1.time_ and arg_67_1.time_ <= var_70_14 + arg_70_0 then
				arg_67_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_70_15 = arg_67_1.actors_["1049ui_story"].transform
			local var_70_16 = 0

			if var_70_16 < arg_67_1.time_ and arg_67_1.time_ <= var_70_16 + arg_70_0 then
				arg_67_1.var_.moveOldPos1049ui_story = var_70_15.localPosition
			end

			local var_70_17 = 0.001

			if var_70_16 <= arg_67_1.time_ and arg_67_1.time_ < var_70_16 + var_70_17 then
				local var_70_18 = (arg_67_1.time_ - var_70_16) / var_70_17
				local var_70_19 = Vector3.New(0, 100, 0)

				var_70_15.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1049ui_story, var_70_19, var_70_18)

				local var_70_20 = manager.ui.mainCamera.transform.position - var_70_15.position

				var_70_15.forward = Vector3.New(var_70_20.x, var_70_20.y, var_70_20.z)

				local var_70_21 = var_70_15.localEulerAngles

				var_70_21.z = 0
				var_70_21.x = 0
				var_70_15.localEulerAngles = var_70_21
			end

			if arg_67_1.time_ >= var_70_16 + var_70_17 and arg_67_1.time_ < var_70_16 + var_70_17 + arg_70_0 then
				var_70_15.localPosition = Vector3.New(0, 100, 0)

				local var_70_22 = manager.ui.mainCamera.transform.position - var_70_15.position

				var_70_15.forward = Vector3.New(var_70_22.x, var_70_22.y, var_70_22.z)

				local var_70_23 = var_70_15.localEulerAngles

				var_70_23.z = 0
				var_70_23.x = 0
				var_70_15.localEulerAngles = var_70_23
			end

			local var_70_24 = arg_67_1.actors_["1049ui_story"]
			local var_70_25 = 0

			if var_70_25 < arg_67_1.time_ and arg_67_1.time_ <= var_70_25 + arg_70_0 and not isNil(var_70_24) and arg_67_1.var_.characterEffect1049ui_story == nil then
				arg_67_1.var_.characterEffect1049ui_story = var_70_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_26 = 0.200000002980232

			if var_70_25 <= arg_67_1.time_ and arg_67_1.time_ < var_70_25 + var_70_26 and not isNil(var_70_24) then
				local var_70_27 = (arg_67_1.time_ - var_70_25) / var_70_26

				if arg_67_1.var_.characterEffect1049ui_story and not isNil(var_70_24) then
					local var_70_28 = Mathf.Lerp(0, 0.5, var_70_27)

					arg_67_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1049ui_story.fillRatio = var_70_28
				end
			end

			if arg_67_1.time_ >= var_70_25 + var_70_26 and arg_67_1.time_ < var_70_25 + var_70_26 + arg_70_0 and not isNil(var_70_24) and arg_67_1.var_.characterEffect1049ui_story then
				local var_70_29 = 0.5

				arg_67_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1049ui_story.fillRatio = var_70_29
			end

			local var_70_30 = 0
			local var_70_31 = 0.275

			if var_70_30 < arg_67_1.time_ and arg_67_1.time_ <= var_70_30 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_32 = arg_67_1:FormatText(StoryNameCfg[84].name)

				arg_67_1.leftNameTxt_.text = var_70_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_33 = arg_67_1:GetWordFromCfg(318301016)
				local var_70_34 = arg_67_1:FormatText(var_70_33.content)

				arg_67_1.text_.text = var_70_34

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_35 = 11
				local var_70_36 = utf8.len(var_70_34)
				local var_70_37 = var_70_35 <= 0 and var_70_31 or var_70_31 * (var_70_36 / var_70_35)

				if var_70_37 > 0 and var_70_31 < var_70_37 then
					arg_67_1.talkMaxDuration = var_70_37

					if var_70_37 + var_70_30 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_37 + var_70_30
					end
				end

				arg_67_1.text_.text = var_70_34
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301016", "story_v_out_318301.awb") ~= 0 then
					local var_70_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301016", "story_v_out_318301.awb") / 1000

					if var_70_38 + var_70_30 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_38 + var_70_30
					end

					if var_70_33.prefab_name ~= "" and arg_67_1.actors_[var_70_33.prefab_name] ~= nil then
						local var_70_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_33.prefab_name].transform, "story_v_out_318301", "318301016", "story_v_out_318301.awb")

						arg_67_1:RecordAudio("318301016", var_70_39)
						arg_67_1:RecordAudio("318301016", var_70_39)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_318301", "318301016", "story_v_out_318301.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_318301", "318301016", "story_v_out_318301.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_40 = math.max(var_70_31, arg_67_1.talkMaxDuration)

			if var_70_30 <= arg_67_1.time_ and arg_67_1.time_ < var_70_30 + var_70_40 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_30) / var_70_40

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_30 + var_70_40 and arg_67_1.time_ < var_70_30 + var_70_40 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play318301017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 318301017
		arg_71_1.duration_ = 9

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play318301018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = "K13f"

			if arg_71_1.bgs_[var_74_0] == nil then
				local var_74_1 = Object.Instantiate(arg_71_1.paintGo_)

				var_74_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_74_0)
				var_74_1.name = var_74_0
				var_74_1.transform.parent = arg_71_1.stage_.transform
				var_74_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.bgs_[var_74_0] = var_74_1
			end

			local var_74_2 = 2

			if var_74_2 < arg_71_1.time_ and arg_71_1.time_ <= var_74_2 + arg_74_0 then
				local var_74_3 = manager.ui.mainCamera.transform.localPosition
				local var_74_4 = Vector3.New(0, 0, 10) + Vector3.New(var_74_3.x, var_74_3.y, 0)
				local var_74_5 = arg_71_1.bgs_.K13f

				var_74_5.transform.localPosition = var_74_4
				var_74_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_6 = var_74_5:GetComponent("SpriteRenderer")

				if var_74_6 and var_74_6.sprite then
					local var_74_7 = (var_74_5.transform.localPosition - var_74_3).z
					local var_74_8 = manager.ui.mainCameraCom_
					local var_74_9 = 2 * var_74_7 * Mathf.Tan(var_74_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_74_10 = var_74_9 * var_74_8.aspect
					local var_74_11 = var_74_6.sprite.bounds.size.x
					local var_74_12 = var_74_6.sprite.bounds.size.y
					local var_74_13 = var_74_10 / var_74_11
					local var_74_14 = var_74_9 / var_74_12
					local var_74_15 = var_74_14 < var_74_13 and var_74_13 or var_74_14

					var_74_5.transform.localScale = Vector3.New(var_74_15, var_74_15, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "K13f" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_74_16 = 0

			if var_74_16 < arg_71_1.time_ and arg_71_1.time_ <= var_74_16 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_17 = 2

			if var_74_16 <= arg_71_1.time_ and arg_71_1.time_ < var_74_16 + var_74_17 then
				local var_74_18 = (arg_71_1.time_ - var_74_16) / var_74_17
				local var_74_19 = Color.New(0, 0, 0)

				var_74_19.a = Mathf.Lerp(0, 1, var_74_18)
				arg_71_1.mask_.color = var_74_19
			end

			if arg_71_1.time_ >= var_74_16 + var_74_17 and arg_71_1.time_ < var_74_16 + var_74_17 + arg_74_0 then
				local var_74_20 = Color.New(0, 0, 0)

				var_74_20.a = 1
				arg_71_1.mask_.color = var_74_20
			end

			local var_74_21 = 2

			if var_74_21 < arg_71_1.time_ and arg_71_1.time_ <= var_74_21 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_22 = 2

			if var_74_21 <= arg_71_1.time_ and arg_71_1.time_ < var_74_21 + var_74_22 then
				local var_74_23 = (arg_71_1.time_ - var_74_21) / var_74_22
				local var_74_24 = Color.New(0, 0, 0)

				var_74_24.a = Mathf.Lerp(1, 0, var_74_23)
				arg_71_1.mask_.color = var_74_24
			end

			if arg_71_1.time_ >= var_74_21 + var_74_22 and arg_71_1.time_ < var_74_21 + var_74_22 + arg_74_0 then
				local var_74_25 = Color.New(0, 0, 0)
				local var_74_26 = 0

				arg_71_1.mask_.enabled = false
				var_74_25.a = var_74_26
				arg_71_1.mask_.color = var_74_25
			end

			local var_74_27 = arg_71_1.actors_["1199ui_story"].transform
			local var_74_28 = 1.96599999815226

			if var_74_28 < arg_71_1.time_ and arg_71_1.time_ <= var_74_28 + arg_74_0 then
				arg_71_1.var_.moveOldPos1199ui_story = var_74_27.localPosition
			end

			local var_74_29 = 0.001

			if var_74_28 <= arg_71_1.time_ and arg_71_1.time_ < var_74_28 + var_74_29 then
				local var_74_30 = (arg_71_1.time_ - var_74_28) / var_74_29
				local var_74_31 = Vector3.New(0, 100, 0)

				var_74_27.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1199ui_story, var_74_31, var_74_30)

				local var_74_32 = manager.ui.mainCamera.transform.position - var_74_27.position

				var_74_27.forward = Vector3.New(var_74_32.x, var_74_32.y, var_74_32.z)

				local var_74_33 = var_74_27.localEulerAngles

				var_74_33.z = 0
				var_74_33.x = 0
				var_74_27.localEulerAngles = var_74_33
			end

			if arg_71_1.time_ >= var_74_28 + var_74_29 and arg_71_1.time_ < var_74_28 + var_74_29 + arg_74_0 then
				var_74_27.localPosition = Vector3.New(0, 100, 0)

				local var_74_34 = manager.ui.mainCamera.transform.position - var_74_27.position

				var_74_27.forward = Vector3.New(var_74_34.x, var_74_34.y, var_74_34.z)

				local var_74_35 = var_74_27.localEulerAngles

				var_74_35.z = 0
				var_74_35.x = 0
				var_74_27.localEulerAngles = var_74_35
			end

			local var_74_36 = arg_71_1.actors_["1199ui_story"]
			local var_74_37 = 1.96599999815226

			if var_74_37 < arg_71_1.time_ and arg_71_1.time_ <= var_74_37 + arg_74_0 and not isNil(var_74_36) and arg_71_1.var_.characterEffect1199ui_story == nil then
				arg_71_1.var_.characterEffect1199ui_story = var_74_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_38 = 0.034000001847744

			if var_74_37 <= arg_71_1.time_ and arg_71_1.time_ < var_74_37 + var_74_38 and not isNil(var_74_36) then
				local var_74_39 = (arg_71_1.time_ - var_74_37) / var_74_38

				if arg_71_1.var_.characterEffect1199ui_story and not isNil(var_74_36) then
					local var_74_40 = Mathf.Lerp(0, 0.5, var_74_39)

					arg_71_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1199ui_story.fillRatio = var_74_40
				end
			end

			if arg_71_1.time_ >= var_74_37 + var_74_38 and arg_71_1.time_ < var_74_37 + var_74_38 + arg_74_0 and not isNil(var_74_36) and arg_71_1.var_.characterEffect1199ui_story then
				local var_74_41 = 0.5

				arg_71_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1199ui_story.fillRatio = var_74_41
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_42 = 4
			local var_74_43 = 0.925

			if var_74_42 < arg_71_1.time_ and arg_71_1.time_ <= var_74_42 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_44 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_44:setOnUpdate(LuaHelper.FloatAction(function(arg_75_0)
					arg_71_1.dialogCg_.alpha = arg_75_0
				end))
				var_74_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_45 = arg_71_1:GetWordFromCfg(318301017)
				local var_74_46 = arg_71_1:FormatText(var_74_45.content)

				arg_71_1.text_.text = var_74_46

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_47 = 37
				local var_74_48 = utf8.len(var_74_46)
				local var_74_49 = var_74_47 <= 0 and var_74_43 or var_74_43 * (var_74_48 / var_74_47)

				if var_74_49 > 0 and var_74_43 < var_74_49 then
					arg_71_1.talkMaxDuration = var_74_49
					var_74_42 = var_74_42 + 0.3

					if var_74_49 + var_74_42 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_49 + var_74_42
					end
				end

				arg_71_1.text_.text = var_74_46
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_50 = var_74_42 + 0.3
			local var_74_51 = math.max(var_74_43, arg_71_1.talkMaxDuration)

			if var_74_50 <= arg_71_1.time_ and arg_71_1.time_ < var_74_50 + var_74_51 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_50) / var_74_51

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_50 + var_74_51 and arg_71_1.time_ < var_74_50 + var_74_51 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play318301018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 318301018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play318301019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.7

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

				local var_80_2 = arg_77_1:GetWordFromCfg(318301018)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 28
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
	Play318301019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 318301019
		arg_81_1.duration_ = 4.83

		local var_81_0 = {
			zh = 4.833,
			ja = 3.5
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
				arg_81_0:Play318301020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = "1093ui_story"

			if arg_81_1.actors_[var_84_0] == nil then
				local var_84_1 = Asset.Load("Char/" .. "1093ui_story")

				if not isNil(var_84_1) then
					local var_84_2 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_81_1.stage_.transform)

					var_84_2.name = var_84_0
					var_84_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_81_1.actors_[var_84_0] = var_84_2

					local var_84_3 = var_84_2:GetComponentInChildren(typeof(CharacterEffect))

					var_84_3.enabled = true

					local var_84_4 = GameObjectTools.GetOrAddComponent(var_84_2, typeof(DynamicBoneHelper))

					if var_84_4 then
						var_84_4:EnableDynamicBone(false)
					end

					arg_81_1:ShowWeapon(var_84_3.transform, false)

					arg_81_1.var_[var_84_0 .. "Animator"] = var_84_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_81_1.var_[var_84_0 .. "Animator"].applyRootMotion = true
					arg_81_1.var_[var_84_0 .. "LipSync"] = var_84_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_84_5 = arg_81_1.actors_["1093ui_story"].transform
			local var_84_6 = 0

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.var_.moveOldPos1093ui_story = var_84_5.localPosition
			end

			local var_84_7 = 0.001

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_7 then
				local var_84_8 = (arg_81_1.time_ - var_84_6) / var_84_7
				local var_84_9 = Vector3.New(0, -1.11, -5.88)

				var_84_5.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1093ui_story, var_84_9, var_84_8)

				local var_84_10 = manager.ui.mainCamera.transform.position - var_84_5.position

				var_84_5.forward = Vector3.New(var_84_10.x, var_84_10.y, var_84_10.z)

				local var_84_11 = var_84_5.localEulerAngles

				var_84_11.z = 0
				var_84_11.x = 0
				var_84_5.localEulerAngles = var_84_11
			end

			if arg_81_1.time_ >= var_84_6 + var_84_7 and arg_81_1.time_ < var_84_6 + var_84_7 + arg_84_0 then
				var_84_5.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_84_12 = manager.ui.mainCamera.transform.position - var_84_5.position

				var_84_5.forward = Vector3.New(var_84_12.x, var_84_12.y, var_84_12.z)

				local var_84_13 = var_84_5.localEulerAngles

				var_84_13.z = 0
				var_84_13.x = 0
				var_84_5.localEulerAngles = var_84_13
			end

			local var_84_14 = arg_81_1.actors_["1093ui_story"]
			local var_84_15 = 0

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 and not isNil(var_84_14) and arg_81_1.var_.characterEffect1093ui_story == nil then
				arg_81_1.var_.characterEffect1093ui_story = var_84_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_16 = 0.200000002980232

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_16 and not isNil(var_84_14) then
				local var_84_17 = (arg_81_1.time_ - var_84_15) / var_84_16

				if arg_81_1.var_.characterEffect1093ui_story and not isNil(var_84_14) then
					arg_81_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_15 + var_84_16 and arg_81_1.time_ < var_84_15 + var_84_16 + arg_84_0 and not isNil(var_84_14) and arg_81_1.var_.characterEffect1093ui_story then
				arg_81_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_84_18 = 0

			if var_84_18 < arg_81_1.time_ and arg_81_1.time_ <= var_84_18 + arg_84_0 then
				arg_81_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			local var_84_19 = 0

			if var_84_19 < arg_81_1.time_ and arg_81_1.time_ <= var_84_19 + arg_84_0 then
				arg_81_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_84_20 = 0
			local var_84_21 = 0.5

			if var_84_20 < arg_81_1.time_ and arg_81_1.time_ <= var_84_20 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_22 = arg_81_1:FormatText(StoryNameCfg[73].name)

				arg_81_1.leftNameTxt_.text = var_84_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_23 = arg_81_1:GetWordFromCfg(318301019)
				local var_84_24 = arg_81_1:FormatText(var_84_23.content)

				arg_81_1.text_.text = var_84_24

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_25 = 20
				local var_84_26 = utf8.len(var_84_24)
				local var_84_27 = var_84_25 <= 0 and var_84_21 or var_84_21 * (var_84_26 / var_84_25)

				if var_84_27 > 0 and var_84_21 < var_84_27 then
					arg_81_1.talkMaxDuration = var_84_27

					if var_84_27 + var_84_20 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_27 + var_84_20
					end
				end

				arg_81_1.text_.text = var_84_24
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301019", "story_v_out_318301.awb") ~= 0 then
					local var_84_28 = manager.audio:GetVoiceLength("story_v_out_318301", "318301019", "story_v_out_318301.awb") / 1000

					if var_84_28 + var_84_20 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_28 + var_84_20
					end

					if var_84_23.prefab_name ~= "" and arg_81_1.actors_[var_84_23.prefab_name] ~= nil then
						local var_84_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_23.prefab_name].transform, "story_v_out_318301", "318301019", "story_v_out_318301.awb")

						arg_81_1:RecordAudio("318301019", var_84_29)
						arg_81_1:RecordAudio("318301019", var_84_29)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_318301", "318301019", "story_v_out_318301.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_318301", "318301019", "story_v_out_318301.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_30 = math.max(var_84_21, arg_81_1.talkMaxDuration)

			if var_84_20 <= arg_81_1.time_ and arg_81_1.time_ < var_84_20 + var_84_30 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_20) / var_84_30

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_20 + var_84_30 and arg_81_1.time_ < var_84_20 + var_84_30 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play318301020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 318301020
		arg_85_1.duration_ = 8.4

		local var_85_0 = {
			zh = 7.366,
			ja = 8.4
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
				arg_85_0:Play318301021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.825

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[73].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(318301020)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 33
				local var_88_6 = utf8.len(var_88_4)
				local var_88_7 = var_88_5 <= 0 and var_88_1 or var_88_1 * (var_88_6 / var_88_5)

				if var_88_7 > 0 and var_88_1 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301020", "story_v_out_318301.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_318301", "318301020", "story_v_out_318301.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_318301", "318301020", "story_v_out_318301.awb")

						arg_85_1:RecordAudio("318301020", var_88_9)
						arg_85_1:RecordAudio("318301020", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_318301", "318301020", "story_v_out_318301.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_318301", "318301020", "story_v_out_318301.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_10 and arg_85_1.time_ < var_88_0 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play318301021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 318301021
		arg_89_1.duration_ = 6

		local var_89_0 = {
			zh = 4.7,
			ja = 6
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
				arg_89_0:Play318301022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.45

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[73].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(318301021)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301021", "story_v_out_318301.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_318301", "318301021", "story_v_out_318301.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_318301", "318301021", "story_v_out_318301.awb")

						arg_89_1:RecordAudio("318301021", var_92_9)
						arg_89_1:RecordAudio("318301021", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_318301", "318301021", "story_v_out_318301.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_318301", "318301021", "story_v_out_318301.awb")
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
	Play318301022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 318301022
		arg_93_1.duration_ = 3.53

		local var_93_0 = {
			zh = 3.533,
			ja = 2.3
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
				arg_93_0:Play318301023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = "1055ui_story"

			if arg_93_1.actors_[var_96_0] == nil then
				local var_96_1 = Asset.Load("Char/" .. "1055ui_story")

				if not isNil(var_96_1) then
					local var_96_2 = Object.Instantiate(Asset.Load("Char/" .. "1055ui_story"), arg_93_1.stage_.transform)

					var_96_2.name = var_96_0
					var_96_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_93_1.actors_[var_96_0] = var_96_2

					local var_96_3 = var_96_2:GetComponentInChildren(typeof(CharacterEffect))

					var_96_3.enabled = true

					local var_96_4 = GameObjectTools.GetOrAddComponent(var_96_2, typeof(DynamicBoneHelper))

					if var_96_4 then
						var_96_4:EnableDynamicBone(false)
					end

					arg_93_1:ShowWeapon(var_96_3.transform, false)

					arg_93_1.var_[var_96_0 .. "Animator"] = var_96_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_93_1.var_[var_96_0 .. "Animator"].applyRootMotion = true
					arg_93_1.var_[var_96_0 .. "LipSync"] = var_96_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_96_5 = arg_93_1.actors_["1055ui_story"].transform
			local var_96_6 = 0

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.var_.moveOldPos1055ui_story = var_96_5.localPosition
			end

			local var_96_7 = 0.001

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_7 then
				local var_96_8 = (arg_93_1.time_ - var_96_6) / var_96_7
				local var_96_9 = Vector3.New(0, -0.965, -6.2)

				var_96_5.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1055ui_story, var_96_9, var_96_8)

				local var_96_10 = manager.ui.mainCamera.transform.position - var_96_5.position

				var_96_5.forward = Vector3.New(var_96_10.x, var_96_10.y, var_96_10.z)

				local var_96_11 = var_96_5.localEulerAngles

				var_96_11.z = 0
				var_96_11.x = 0
				var_96_5.localEulerAngles = var_96_11
			end

			if arg_93_1.time_ >= var_96_6 + var_96_7 and arg_93_1.time_ < var_96_6 + var_96_7 + arg_96_0 then
				var_96_5.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_96_12 = manager.ui.mainCamera.transform.position - var_96_5.position

				var_96_5.forward = Vector3.New(var_96_12.x, var_96_12.y, var_96_12.z)

				local var_96_13 = var_96_5.localEulerAngles

				var_96_13.z = 0
				var_96_13.x = 0
				var_96_5.localEulerAngles = var_96_13
			end

			local var_96_14 = arg_93_1.actors_["1055ui_story"]
			local var_96_15 = 0

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 and not isNil(var_96_14) and arg_93_1.var_.characterEffect1055ui_story == nil then
				arg_93_1.var_.characterEffect1055ui_story = var_96_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_16 = 0.200000002980232

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_16 and not isNil(var_96_14) then
				local var_96_17 = (arg_93_1.time_ - var_96_15) / var_96_16

				if arg_93_1.var_.characterEffect1055ui_story and not isNil(var_96_14) then
					arg_93_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_15 + var_96_16 and arg_93_1.time_ < var_96_15 + var_96_16 + arg_96_0 and not isNil(var_96_14) and arg_93_1.var_.characterEffect1055ui_story then
				arg_93_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_96_18 = 0

			if var_96_18 < arg_93_1.time_ and arg_93_1.time_ <= var_96_18 + arg_96_0 then
				arg_93_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action2_1")
			end

			local var_96_19 = 0

			if var_96_19 < arg_93_1.time_ and arg_93_1.time_ <= var_96_19 + arg_96_0 then
				arg_93_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_96_20 = arg_93_1.actors_["1093ui_story"].transform
			local var_96_21 = 0

			if var_96_21 < arg_93_1.time_ and arg_93_1.time_ <= var_96_21 + arg_96_0 then
				arg_93_1.var_.moveOldPos1093ui_story = var_96_20.localPosition
			end

			local var_96_22 = 0.001

			if var_96_21 <= arg_93_1.time_ and arg_93_1.time_ < var_96_21 + var_96_22 then
				local var_96_23 = (arg_93_1.time_ - var_96_21) / var_96_22
				local var_96_24 = Vector3.New(0, 100, 0)

				var_96_20.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1093ui_story, var_96_24, var_96_23)

				local var_96_25 = manager.ui.mainCamera.transform.position - var_96_20.position

				var_96_20.forward = Vector3.New(var_96_25.x, var_96_25.y, var_96_25.z)

				local var_96_26 = var_96_20.localEulerAngles

				var_96_26.z = 0
				var_96_26.x = 0
				var_96_20.localEulerAngles = var_96_26
			end

			if arg_93_1.time_ >= var_96_21 + var_96_22 and arg_93_1.time_ < var_96_21 + var_96_22 + arg_96_0 then
				var_96_20.localPosition = Vector3.New(0, 100, 0)

				local var_96_27 = manager.ui.mainCamera.transform.position - var_96_20.position

				var_96_20.forward = Vector3.New(var_96_27.x, var_96_27.y, var_96_27.z)

				local var_96_28 = var_96_20.localEulerAngles

				var_96_28.z = 0
				var_96_28.x = 0
				var_96_20.localEulerAngles = var_96_28
			end

			local var_96_29 = arg_93_1.actors_["1093ui_story"]
			local var_96_30 = 0

			if var_96_30 < arg_93_1.time_ and arg_93_1.time_ <= var_96_30 + arg_96_0 and not isNil(var_96_29) and arg_93_1.var_.characterEffect1093ui_story == nil then
				arg_93_1.var_.characterEffect1093ui_story = var_96_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_31 = 0.200000002980232

			if var_96_30 <= arg_93_1.time_ and arg_93_1.time_ < var_96_30 + var_96_31 and not isNil(var_96_29) then
				local var_96_32 = (arg_93_1.time_ - var_96_30) / var_96_31

				if arg_93_1.var_.characterEffect1093ui_story and not isNil(var_96_29) then
					local var_96_33 = Mathf.Lerp(0, 0.5, var_96_32)

					arg_93_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1093ui_story.fillRatio = var_96_33
				end
			end

			if arg_93_1.time_ >= var_96_30 + var_96_31 and arg_93_1.time_ < var_96_30 + var_96_31 + arg_96_0 and not isNil(var_96_29) and arg_93_1.var_.characterEffect1093ui_story then
				local var_96_34 = 0.5

				arg_93_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1093ui_story.fillRatio = var_96_34
			end

			local var_96_35 = 0
			local var_96_36 = 0.35

			if var_96_35 < arg_93_1.time_ and arg_93_1.time_ <= var_96_35 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_37 = arg_93_1:FormatText(StoryNameCfg[481].name)

				arg_93_1.leftNameTxt_.text = var_96_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_38 = arg_93_1:GetWordFromCfg(318301022)
				local var_96_39 = arg_93_1:FormatText(var_96_38.content)

				arg_93_1.text_.text = var_96_39

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_40 = 14
				local var_96_41 = utf8.len(var_96_39)
				local var_96_42 = var_96_40 <= 0 and var_96_36 or var_96_36 * (var_96_41 / var_96_40)

				if var_96_42 > 0 and var_96_36 < var_96_42 then
					arg_93_1.talkMaxDuration = var_96_42

					if var_96_42 + var_96_35 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_42 + var_96_35
					end
				end

				arg_93_1.text_.text = var_96_39
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301022", "story_v_out_318301.awb") ~= 0 then
					local var_96_43 = manager.audio:GetVoiceLength("story_v_out_318301", "318301022", "story_v_out_318301.awb") / 1000

					if var_96_43 + var_96_35 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_43 + var_96_35
					end

					if var_96_38.prefab_name ~= "" and arg_93_1.actors_[var_96_38.prefab_name] ~= nil then
						local var_96_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_38.prefab_name].transform, "story_v_out_318301", "318301022", "story_v_out_318301.awb")

						arg_93_1:RecordAudio("318301022", var_96_44)
						arg_93_1:RecordAudio("318301022", var_96_44)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_318301", "318301022", "story_v_out_318301.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_318301", "318301022", "story_v_out_318301.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_45 = math.max(var_96_36, arg_93_1.talkMaxDuration)

			if var_96_35 <= arg_93_1.time_ and arg_93_1.time_ < var_96_35 + var_96_45 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_35) / var_96_45

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_35 + var_96_45 and arg_93_1.time_ < var_96_35 + var_96_45 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play318301023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 318301023
		arg_97_1.duration_ = 3.9

		local var_97_0 = {
			zh = 3.333,
			ja = 3.9
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
				arg_97_0:Play318301024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = "1150ui_story"

			if arg_97_1.actors_[var_100_0] == nil then
				local var_100_1 = Asset.Load("Char/" .. "1150ui_story")

				if not isNil(var_100_1) then
					local var_100_2 = Object.Instantiate(Asset.Load("Char/" .. "1150ui_story"), arg_97_1.stage_.transform)

					var_100_2.name = var_100_0
					var_100_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_97_1.actors_[var_100_0] = var_100_2

					local var_100_3 = var_100_2:GetComponentInChildren(typeof(CharacterEffect))

					var_100_3.enabled = true

					local var_100_4 = GameObjectTools.GetOrAddComponent(var_100_2, typeof(DynamicBoneHelper))

					if var_100_4 then
						var_100_4:EnableDynamicBone(false)
					end

					arg_97_1:ShowWeapon(var_100_3.transform, false)

					arg_97_1.var_[var_100_0 .. "Animator"] = var_100_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_97_1.var_[var_100_0 .. "Animator"].applyRootMotion = true
					arg_97_1.var_[var_100_0 .. "LipSync"] = var_100_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_100_5 = arg_97_1.actors_["1150ui_story"].transform
			local var_100_6 = 0

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.var_.moveOldPos1150ui_story = var_100_5.localPosition
			end

			local var_100_7 = 0.001

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_7 then
				local var_100_8 = (arg_97_1.time_ - var_100_6) / var_100_7
				local var_100_9 = Vector3.New(0, -1.01, -6.2)

				var_100_5.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1150ui_story, var_100_9, var_100_8)

				local var_100_10 = manager.ui.mainCamera.transform.position - var_100_5.position

				var_100_5.forward = Vector3.New(var_100_10.x, var_100_10.y, var_100_10.z)

				local var_100_11 = var_100_5.localEulerAngles

				var_100_11.z = 0
				var_100_11.x = 0
				var_100_5.localEulerAngles = var_100_11
			end

			if arg_97_1.time_ >= var_100_6 + var_100_7 and arg_97_1.time_ < var_100_6 + var_100_7 + arg_100_0 then
				var_100_5.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_100_12 = manager.ui.mainCamera.transform.position - var_100_5.position

				var_100_5.forward = Vector3.New(var_100_12.x, var_100_12.y, var_100_12.z)

				local var_100_13 = var_100_5.localEulerAngles

				var_100_13.z = 0
				var_100_13.x = 0
				var_100_5.localEulerAngles = var_100_13
			end

			local var_100_14 = arg_97_1.actors_["1150ui_story"]
			local var_100_15 = 0

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 and not isNil(var_100_14) and arg_97_1.var_.characterEffect1150ui_story == nil then
				arg_97_1.var_.characterEffect1150ui_story = var_100_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_16 = 0.200000002980232

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_16 and not isNil(var_100_14) then
				local var_100_17 = (arg_97_1.time_ - var_100_15) / var_100_16

				if arg_97_1.var_.characterEffect1150ui_story and not isNil(var_100_14) then
					arg_97_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_15 + var_100_16 and arg_97_1.time_ < var_100_15 + var_100_16 + arg_100_0 and not isNil(var_100_14) and arg_97_1.var_.characterEffect1150ui_story then
				arg_97_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_100_18 = 0

			if var_100_18 < arg_97_1.time_ and arg_97_1.time_ <= var_100_18 + arg_100_0 then
				arg_97_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_100_19 = 0

			if var_100_19 < arg_97_1.time_ and arg_97_1.time_ <= var_100_19 + arg_100_0 then
				arg_97_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_100_20 = arg_97_1.actors_["1055ui_story"].transform
			local var_100_21 = 0

			if var_100_21 < arg_97_1.time_ and arg_97_1.time_ <= var_100_21 + arg_100_0 then
				arg_97_1.var_.moveOldPos1055ui_story = var_100_20.localPosition
			end

			local var_100_22 = 0.001

			if var_100_21 <= arg_97_1.time_ and arg_97_1.time_ < var_100_21 + var_100_22 then
				local var_100_23 = (arg_97_1.time_ - var_100_21) / var_100_22
				local var_100_24 = Vector3.New(0, 100, 0)

				var_100_20.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1055ui_story, var_100_24, var_100_23)

				local var_100_25 = manager.ui.mainCamera.transform.position - var_100_20.position

				var_100_20.forward = Vector3.New(var_100_25.x, var_100_25.y, var_100_25.z)

				local var_100_26 = var_100_20.localEulerAngles

				var_100_26.z = 0
				var_100_26.x = 0
				var_100_20.localEulerAngles = var_100_26
			end

			if arg_97_1.time_ >= var_100_21 + var_100_22 and arg_97_1.time_ < var_100_21 + var_100_22 + arg_100_0 then
				var_100_20.localPosition = Vector3.New(0, 100, 0)

				local var_100_27 = manager.ui.mainCamera.transform.position - var_100_20.position

				var_100_20.forward = Vector3.New(var_100_27.x, var_100_27.y, var_100_27.z)

				local var_100_28 = var_100_20.localEulerAngles

				var_100_28.z = 0
				var_100_28.x = 0
				var_100_20.localEulerAngles = var_100_28
			end

			local var_100_29 = arg_97_1.actors_["1055ui_story"]
			local var_100_30 = 0

			if var_100_30 < arg_97_1.time_ and arg_97_1.time_ <= var_100_30 + arg_100_0 and not isNil(var_100_29) and arg_97_1.var_.characterEffect1055ui_story == nil then
				arg_97_1.var_.characterEffect1055ui_story = var_100_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_31 = 0.200000002980232

			if var_100_30 <= arg_97_1.time_ and arg_97_1.time_ < var_100_30 + var_100_31 and not isNil(var_100_29) then
				local var_100_32 = (arg_97_1.time_ - var_100_30) / var_100_31

				if arg_97_1.var_.characterEffect1055ui_story and not isNil(var_100_29) then
					local var_100_33 = Mathf.Lerp(0, 0.5, var_100_32)

					arg_97_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1055ui_story.fillRatio = var_100_33
				end
			end

			if arg_97_1.time_ >= var_100_30 + var_100_31 and arg_97_1.time_ < var_100_30 + var_100_31 + arg_100_0 and not isNil(var_100_29) and arg_97_1.var_.characterEffect1055ui_story then
				local var_100_34 = 0.5

				arg_97_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1055ui_story.fillRatio = var_100_34
			end

			local var_100_35 = 0
			local var_100_36 = 0.35

			if var_100_35 < arg_97_1.time_ and arg_97_1.time_ <= var_100_35 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_37 = arg_97_1:FormatText(StoryNameCfg[74].name)

				arg_97_1.leftNameTxt_.text = var_100_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_38 = arg_97_1:GetWordFromCfg(318301023)
				local var_100_39 = arg_97_1:FormatText(var_100_38.content)

				arg_97_1.text_.text = var_100_39

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_40 = 14
				local var_100_41 = utf8.len(var_100_39)
				local var_100_42 = var_100_40 <= 0 and var_100_36 or var_100_36 * (var_100_41 / var_100_40)

				if var_100_42 > 0 and var_100_36 < var_100_42 then
					arg_97_1.talkMaxDuration = var_100_42

					if var_100_42 + var_100_35 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_42 + var_100_35
					end
				end

				arg_97_1.text_.text = var_100_39
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301023", "story_v_out_318301.awb") ~= 0 then
					local var_100_43 = manager.audio:GetVoiceLength("story_v_out_318301", "318301023", "story_v_out_318301.awb") / 1000

					if var_100_43 + var_100_35 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_43 + var_100_35
					end

					if var_100_38.prefab_name ~= "" and arg_97_1.actors_[var_100_38.prefab_name] ~= nil then
						local var_100_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_38.prefab_name].transform, "story_v_out_318301", "318301023", "story_v_out_318301.awb")

						arg_97_1:RecordAudio("318301023", var_100_44)
						arg_97_1:RecordAudio("318301023", var_100_44)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_318301", "318301023", "story_v_out_318301.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_318301", "318301023", "story_v_out_318301.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_45 = math.max(var_100_36, arg_97_1.talkMaxDuration)

			if var_100_35 <= arg_97_1.time_ and arg_97_1.time_ < var_100_35 + var_100_45 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_35) / var_100_45

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_35 + var_100_45 and arg_97_1.time_ < var_100_35 + var_100_45 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play318301024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 318301024
		arg_101_1.duration_ = 5.7

		local var_101_0 = {
			zh = 3.233,
			ja = 5.7
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
				arg_101_0:Play318301025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1093ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1093ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0, -1.11, -5.88)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1093ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["1093ui_story"]
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1093ui_story == nil then
				arg_101_1.var_.characterEffect1093ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect1093ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1093ui_story then
				arg_101_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_2")
			end

			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_15 = arg_101_1.actors_["1150ui_story"].transform
			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				arg_101_1.var_.moveOldPos1150ui_story = var_104_15.localPosition
			end

			local var_104_17 = 0.001

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_17 then
				local var_104_18 = (arg_101_1.time_ - var_104_16) / var_104_17
				local var_104_19 = Vector3.New(0, 100, 0)

				var_104_15.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1150ui_story, var_104_19, var_104_18)

				local var_104_20 = manager.ui.mainCamera.transform.position - var_104_15.position

				var_104_15.forward = Vector3.New(var_104_20.x, var_104_20.y, var_104_20.z)

				local var_104_21 = var_104_15.localEulerAngles

				var_104_21.z = 0
				var_104_21.x = 0
				var_104_15.localEulerAngles = var_104_21
			end

			if arg_101_1.time_ >= var_104_16 + var_104_17 and arg_101_1.time_ < var_104_16 + var_104_17 + arg_104_0 then
				var_104_15.localPosition = Vector3.New(0, 100, 0)

				local var_104_22 = manager.ui.mainCamera.transform.position - var_104_15.position

				var_104_15.forward = Vector3.New(var_104_22.x, var_104_22.y, var_104_22.z)

				local var_104_23 = var_104_15.localEulerAngles

				var_104_23.z = 0
				var_104_23.x = 0
				var_104_15.localEulerAngles = var_104_23
			end

			local var_104_24 = arg_101_1.actors_["1150ui_story"]
			local var_104_25 = 0

			if var_104_25 < arg_101_1.time_ and arg_101_1.time_ <= var_104_25 + arg_104_0 and not isNil(var_104_24) and arg_101_1.var_.characterEffect1150ui_story == nil then
				arg_101_1.var_.characterEffect1150ui_story = var_104_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_26 = 0.200000002980232

			if var_104_25 <= arg_101_1.time_ and arg_101_1.time_ < var_104_25 + var_104_26 and not isNil(var_104_24) then
				local var_104_27 = (arg_101_1.time_ - var_104_25) / var_104_26

				if arg_101_1.var_.characterEffect1150ui_story and not isNil(var_104_24) then
					local var_104_28 = Mathf.Lerp(0, 0.5, var_104_27)

					arg_101_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1150ui_story.fillRatio = var_104_28
				end
			end

			if arg_101_1.time_ >= var_104_25 + var_104_26 and arg_101_1.time_ < var_104_25 + var_104_26 + arg_104_0 and not isNil(var_104_24) and arg_101_1.var_.characterEffect1150ui_story then
				local var_104_29 = 0.5

				arg_101_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1150ui_story.fillRatio = var_104_29
			end

			local var_104_30 = 0
			local var_104_31 = 0.275

			if var_104_30 < arg_101_1.time_ and arg_101_1.time_ <= var_104_30 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_32 = arg_101_1:FormatText(StoryNameCfg[73].name)

				arg_101_1.leftNameTxt_.text = var_104_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_33 = arg_101_1:GetWordFromCfg(318301024)
				local var_104_34 = arg_101_1:FormatText(var_104_33.content)

				arg_101_1.text_.text = var_104_34

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_35 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301024", "story_v_out_318301.awb") ~= 0 then
					local var_104_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301024", "story_v_out_318301.awb") / 1000

					if var_104_38 + var_104_30 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_38 + var_104_30
					end

					if var_104_33.prefab_name ~= "" and arg_101_1.actors_[var_104_33.prefab_name] ~= nil then
						local var_104_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_33.prefab_name].transform, "story_v_out_318301", "318301024", "story_v_out_318301.awb")

						arg_101_1:RecordAudio("318301024", var_104_39)
						arg_101_1:RecordAudio("318301024", var_104_39)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_318301", "318301024", "story_v_out_318301.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_318301", "318301024", "story_v_out_318301.awb")
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
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play318301025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 318301025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play318301026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1093ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos1093ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0, 100, 0)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1093ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, 100, 0)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = arg_105_1.actors_["1093ui_story"]
			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect1093ui_story == nil then
				arg_105_1.var_.characterEffect1093ui_story = var_108_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_11 = 0.200000002980232

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_11 and not isNil(var_108_9) then
				local var_108_12 = (arg_105_1.time_ - var_108_10) / var_108_11

				if arg_105_1.var_.characterEffect1093ui_story and not isNil(var_108_9) then
					local var_108_13 = Mathf.Lerp(0, 0.5, var_108_12)

					arg_105_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1093ui_story.fillRatio = var_108_13
				end
			end

			if arg_105_1.time_ >= var_108_10 + var_108_11 and arg_105_1.time_ < var_108_10 + var_108_11 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect1093ui_story then
				local var_108_14 = 0.5

				arg_105_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1093ui_story.fillRatio = var_108_14
			end

			local var_108_15 = 0
			local var_108_16 = 0.625

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_17 = arg_105_1:GetWordFromCfg(318301025)
				local var_108_18 = arg_105_1:FormatText(var_108_17.content)

				arg_105_1.text_.text = var_108_18

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_19 = 25
				local var_108_20 = utf8.len(var_108_18)
				local var_108_21 = var_108_19 <= 0 and var_108_16 or var_108_16 * (var_108_20 / var_108_19)

				if var_108_21 > 0 and var_108_16 < var_108_21 then
					arg_105_1.talkMaxDuration = var_108_21

					if var_108_21 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_21 + var_108_15
					end
				end

				arg_105_1.text_.text = var_108_18
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_22 = math.max(var_108_16, arg_105_1.talkMaxDuration)

			if var_108_15 <= arg_105_1.time_ and arg_105_1.time_ < var_108_15 + var_108_22 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_15) / var_108_22

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_15 + var_108_22 and arg_105_1.time_ < var_108_15 + var_108_22 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play318301026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 318301026
		arg_109_1.duration_ = 2.47

		local var_109_0 = {
			zh = 1.2,
			ja = 2.466
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
				arg_109_0:Play318301027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1093ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1093ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0, -1.11, -5.88)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1093ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["1093ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1093ui_story == nil then
				arg_109_1.var_.characterEffect1093ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect1093ui_story and not isNil(var_112_9) then
					arg_109_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1093ui_story then
				arg_109_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_112_13 = 0

			if var_112_13 < arg_109_1.time_ and arg_109_1.time_ <= var_112_13 + arg_112_0 then
				arg_109_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_112_14 = 0

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_15 = 0
			local var_112_16 = 0.1

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_17 = arg_109_1:FormatText(StoryNameCfg[73].name)

				arg_109_1.leftNameTxt_.text = var_112_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_18 = arg_109_1:GetWordFromCfg(318301026)
				local var_112_19 = arg_109_1:FormatText(var_112_18.content)

				arg_109_1.text_.text = var_112_19

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_20 = 4
				local var_112_21 = utf8.len(var_112_19)
				local var_112_22 = var_112_20 <= 0 and var_112_16 or var_112_16 * (var_112_21 / var_112_20)

				if var_112_22 > 0 and var_112_16 < var_112_22 then
					arg_109_1.talkMaxDuration = var_112_22

					if var_112_22 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_22 + var_112_15
					end
				end

				arg_109_1.text_.text = var_112_19
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301026", "story_v_out_318301.awb") ~= 0 then
					local var_112_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301026", "story_v_out_318301.awb") / 1000

					if var_112_23 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_15
					end

					if var_112_18.prefab_name ~= "" and arg_109_1.actors_[var_112_18.prefab_name] ~= nil then
						local var_112_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_18.prefab_name].transform, "story_v_out_318301", "318301026", "story_v_out_318301.awb")

						arg_109_1:RecordAudio("318301026", var_112_24)
						arg_109_1:RecordAudio("318301026", var_112_24)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_318301", "318301026", "story_v_out_318301.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_318301", "318301026", "story_v_out_318301.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_25 = math.max(var_112_16, arg_109_1.talkMaxDuration)

			if var_112_15 <= arg_109_1.time_ and arg_109_1.time_ < var_112_15 + var_112_25 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_15) / var_112_25

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_15 + var_112_25 and arg_109_1.time_ < var_112_15 + var_112_25 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play318301027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 318301027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play318301028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1093ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1093ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0, 100, 0)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1093ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, 100, 0)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["1093ui_story"]
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1093ui_story == nil then
				arg_113_1.var_.characterEffect1093ui_story = var_116_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.200000002980232

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 and not isNil(var_116_9) then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11

				if arg_113_1.var_.characterEffect1093ui_story and not isNil(var_116_9) then
					local var_116_13 = Mathf.Lerp(0, 0.5, var_116_12)

					arg_113_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1093ui_story.fillRatio = var_116_13
				end
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1093ui_story then
				local var_116_14 = 0.5

				arg_113_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1093ui_story.fillRatio = var_116_14
			end

			local var_116_15 = 0
			local var_116_16 = 0.425

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_17 = arg_113_1:FormatText(StoryNameCfg[7].name)

				arg_113_1.leftNameTxt_.text = var_116_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_18 = arg_113_1:GetWordFromCfg(318301027)
				local var_116_19 = arg_113_1:FormatText(var_116_18.content)

				arg_113_1.text_.text = var_116_19

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_20 = 17
				local var_116_21 = utf8.len(var_116_19)
				local var_116_22 = var_116_20 <= 0 and var_116_16 or var_116_16 * (var_116_21 / var_116_20)

				if var_116_22 > 0 and var_116_16 < var_116_22 then
					arg_113_1.talkMaxDuration = var_116_22

					if var_116_22 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_22 + var_116_15
					end
				end

				arg_113_1.text_.text = var_116_19
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_23 = math.max(var_116_16, arg_113_1.talkMaxDuration)

			if var_116_15 <= arg_113_1.time_ and arg_113_1.time_ < var_116_15 + var_116_23 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_15) / var_116_23

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_15 + var_116_23 and arg_113_1.time_ < var_116_15 + var_116_23 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play318301028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 318301028
		arg_117_1.duration_ = 9.33

		local var_117_0 = {
			zh = 6.1,
			ja = 9.333
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
				arg_117_0:Play318301029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1199ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1199ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(0, -1.08, -5.9)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1199ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = arg_117_1.actors_["1199ui_story"]
			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1199ui_story == nil then
				arg_117_1.var_.characterEffect1199ui_story = var_120_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_11 = 0.200000002980232

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 and not isNil(var_120_9) then
				local var_120_12 = (arg_117_1.time_ - var_120_10) / var_120_11

				if arg_117_1.var_.characterEffect1199ui_story and not isNil(var_120_9) then
					arg_117_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1199ui_story then
				arg_117_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_120_13 = 0

			if var_120_13 < arg_117_1.time_ and arg_117_1.time_ <= var_120_13 + arg_120_0 then
				arg_117_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			local var_120_14 = 0

			if var_120_14 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_15 = 0
			local var_120_16 = 0.625

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_17 = arg_117_1:FormatText(StoryNameCfg[84].name)

				arg_117_1.leftNameTxt_.text = var_120_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_18 = arg_117_1:GetWordFromCfg(318301028)
				local var_120_19 = arg_117_1:FormatText(var_120_18.content)

				arg_117_1.text_.text = var_120_19

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_20 = 25
				local var_120_21 = utf8.len(var_120_19)
				local var_120_22 = var_120_20 <= 0 and var_120_16 or var_120_16 * (var_120_21 / var_120_20)

				if var_120_22 > 0 and var_120_16 < var_120_22 then
					arg_117_1.talkMaxDuration = var_120_22

					if var_120_22 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_22 + var_120_15
					end
				end

				arg_117_1.text_.text = var_120_19
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301028", "story_v_out_318301.awb") ~= 0 then
					local var_120_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301028", "story_v_out_318301.awb") / 1000

					if var_120_23 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_23 + var_120_15
					end

					if var_120_18.prefab_name ~= "" and arg_117_1.actors_[var_120_18.prefab_name] ~= nil then
						local var_120_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_18.prefab_name].transform, "story_v_out_318301", "318301028", "story_v_out_318301.awb")

						arg_117_1:RecordAudio("318301028", var_120_24)
						arg_117_1:RecordAudio("318301028", var_120_24)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_318301", "318301028", "story_v_out_318301.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_318301", "318301028", "story_v_out_318301.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_25 = math.max(var_120_16, arg_117_1.talkMaxDuration)

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_25 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_15) / var_120_25

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_15 + var_120_25 and arg_117_1.time_ < var_120_15 + var_120_25 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play318301029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 318301029
		arg_121_1.duration_ = 5.53

		local var_121_0 = {
			zh = 1.999999999999,
			ja = 5.533
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
				arg_121_0:Play318301030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1150ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos1150ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0, -1.01, -6.2)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1150ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["1150ui_story"]
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect1150ui_story == nil then
				arg_121_1.var_.characterEffect1150ui_story = var_124_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.200000002980232

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 and not isNil(var_124_9) then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11

				if arg_121_1.var_.characterEffect1150ui_story and not isNil(var_124_9) then
					arg_121_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect1150ui_story then
				arg_121_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_124_13 = 0

			if var_124_13 < arg_121_1.time_ and arg_121_1.time_ <= var_124_13 + arg_124_0 then
				arg_121_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action5_1")
			end

			local var_124_14 = 0

			if var_124_14 < arg_121_1.time_ and arg_121_1.time_ <= var_124_14 + arg_124_0 then
				arg_121_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_15 = arg_121_1.actors_["1199ui_story"].transform
			local var_124_16 = 0

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1.var_.moveOldPos1199ui_story = var_124_15.localPosition
			end

			local var_124_17 = 0.001

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_17 then
				local var_124_18 = (arg_121_1.time_ - var_124_16) / var_124_17
				local var_124_19 = Vector3.New(0, 100, 0)

				var_124_15.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1199ui_story, var_124_19, var_124_18)

				local var_124_20 = manager.ui.mainCamera.transform.position - var_124_15.position

				var_124_15.forward = Vector3.New(var_124_20.x, var_124_20.y, var_124_20.z)

				local var_124_21 = var_124_15.localEulerAngles

				var_124_21.z = 0
				var_124_21.x = 0
				var_124_15.localEulerAngles = var_124_21
			end

			if arg_121_1.time_ >= var_124_16 + var_124_17 and arg_121_1.time_ < var_124_16 + var_124_17 + arg_124_0 then
				var_124_15.localPosition = Vector3.New(0, 100, 0)

				local var_124_22 = manager.ui.mainCamera.transform.position - var_124_15.position

				var_124_15.forward = Vector3.New(var_124_22.x, var_124_22.y, var_124_22.z)

				local var_124_23 = var_124_15.localEulerAngles

				var_124_23.z = 0
				var_124_23.x = 0
				var_124_15.localEulerAngles = var_124_23
			end

			local var_124_24 = arg_121_1.actors_["1199ui_story"]
			local var_124_25 = 0

			if var_124_25 < arg_121_1.time_ and arg_121_1.time_ <= var_124_25 + arg_124_0 and not isNil(var_124_24) and arg_121_1.var_.characterEffect1199ui_story == nil then
				arg_121_1.var_.characterEffect1199ui_story = var_124_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_26 = 0.200000002980232

			if var_124_25 <= arg_121_1.time_ and arg_121_1.time_ < var_124_25 + var_124_26 and not isNil(var_124_24) then
				local var_124_27 = (arg_121_1.time_ - var_124_25) / var_124_26

				if arg_121_1.var_.characterEffect1199ui_story and not isNil(var_124_24) then
					local var_124_28 = Mathf.Lerp(0, 0.5, var_124_27)

					arg_121_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1199ui_story.fillRatio = var_124_28
				end
			end

			if arg_121_1.time_ >= var_124_25 + var_124_26 and arg_121_1.time_ < var_124_25 + var_124_26 + arg_124_0 and not isNil(var_124_24) and arg_121_1.var_.characterEffect1199ui_story then
				local var_124_29 = 0.5

				arg_121_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1199ui_story.fillRatio = var_124_29
			end

			local var_124_30 = 0
			local var_124_31 = 0.2

			if var_124_30 < arg_121_1.time_ and arg_121_1.time_ <= var_124_30 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_32 = arg_121_1:FormatText(StoryNameCfg[74].name)

				arg_121_1.leftNameTxt_.text = var_124_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_33 = arg_121_1:GetWordFromCfg(318301029)
				local var_124_34 = arg_121_1:FormatText(var_124_33.content)

				arg_121_1.text_.text = var_124_34

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_35 = 8
				local var_124_36 = utf8.len(var_124_34)
				local var_124_37 = var_124_35 <= 0 and var_124_31 or var_124_31 * (var_124_36 / var_124_35)

				if var_124_37 > 0 and var_124_31 < var_124_37 then
					arg_121_1.talkMaxDuration = var_124_37

					if var_124_37 + var_124_30 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_37 + var_124_30
					end
				end

				arg_121_1.text_.text = var_124_34
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301029", "story_v_out_318301.awb") ~= 0 then
					local var_124_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301029", "story_v_out_318301.awb") / 1000

					if var_124_38 + var_124_30 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_38 + var_124_30
					end

					if var_124_33.prefab_name ~= "" and arg_121_1.actors_[var_124_33.prefab_name] ~= nil then
						local var_124_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_33.prefab_name].transform, "story_v_out_318301", "318301029", "story_v_out_318301.awb")

						arg_121_1:RecordAudio("318301029", var_124_39)
						arg_121_1:RecordAudio("318301029", var_124_39)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_318301", "318301029", "story_v_out_318301.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_318301", "318301029", "story_v_out_318301.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_40 = math.max(var_124_31, arg_121_1.talkMaxDuration)

			if var_124_30 <= arg_121_1.time_ and arg_121_1.time_ < var_124_30 + var_124_40 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_30) / var_124_40

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_30 + var_124_40 and arg_121_1.time_ < var_124_30 + var_124_40 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play318301030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 318301030
		arg_125_1.duration_ = 7

		local var_125_0 = {
			zh = 7,
			ja = 4.033
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
				arg_125_0:Play318301031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1199ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1199ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0, -1.08, -5.9)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1199ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["1199ui_story"]
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1199ui_story == nil then
				arg_125_1.var_.characterEffect1199ui_story = var_128_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_11 = 0.200000002980232

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_11 and not isNil(var_128_9) then
				local var_128_12 = (arg_125_1.time_ - var_128_10) / var_128_11

				if arg_125_1.var_.characterEffect1199ui_story and not isNil(var_128_9) then
					arg_125_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_10 + var_128_11 and arg_125_1.time_ < var_128_10 + var_128_11 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1199ui_story then
				arg_125_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_128_13 = 0

			if var_128_13 < arg_125_1.time_ and arg_125_1.time_ <= var_128_13 + arg_128_0 then
				arg_125_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			local var_128_14 = 0

			if var_128_14 < arg_125_1.time_ and arg_125_1.time_ <= var_128_14 + arg_128_0 then
				arg_125_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_15 = arg_125_1.actors_["1150ui_story"].transform
			local var_128_16 = 0

			if var_128_16 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 then
				arg_125_1.var_.moveOldPos1150ui_story = var_128_15.localPosition
			end

			local var_128_17 = 0.001

			if var_128_16 <= arg_125_1.time_ and arg_125_1.time_ < var_128_16 + var_128_17 then
				local var_128_18 = (arg_125_1.time_ - var_128_16) / var_128_17
				local var_128_19 = Vector3.New(0, 100, 0)

				var_128_15.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1150ui_story, var_128_19, var_128_18)

				local var_128_20 = manager.ui.mainCamera.transform.position - var_128_15.position

				var_128_15.forward = Vector3.New(var_128_20.x, var_128_20.y, var_128_20.z)

				local var_128_21 = var_128_15.localEulerAngles

				var_128_21.z = 0
				var_128_21.x = 0
				var_128_15.localEulerAngles = var_128_21
			end

			if arg_125_1.time_ >= var_128_16 + var_128_17 and arg_125_1.time_ < var_128_16 + var_128_17 + arg_128_0 then
				var_128_15.localPosition = Vector3.New(0, 100, 0)

				local var_128_22 = manager.ui.mainCamera.transform.position - var_128_15.position

				var_128_15.forward = Vector3.New(var_128_22.x, var_128_22.y, var_128_22.z)

				local var_128_23 = var_128_15.localEulerAngles

				var_128_23.z = 0
				var_128_23.x = 0
				var_128_15.localEulerAngles = var_128_23
			end

			local var_128_24 = arg_125_1.actors_["1150ui_story"]
			local var_128_25 = 0

			if var_128_25 < arg_125_1.time_ and arg_125_1.time_ <= var_128_25 + arg_128_0 and not isNil(var_128_24) and arg_125_1.var_.characterEffect1150ui_story == nil then
				arg_125_1.var_.characterEffect1150ui_story = var_128_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_26 = 0.200000002980232

			if var_128_25 <= arg_125_1.time_ and arg_125_1.time_ < var_128_25 + var_128_26 and not isNil(var_128_24) then
				local var_128_27 = (arg_125_1.time_ - var_128_25) / var_128_26

				if arg_125_1.var_.characterEffect1150ui_story and not isNil(var_128_24) then
					local var_128_28 = Mathf.Lerp(0, 0.5, var_128_27)

					arg_125_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1150ui_story.fillRatio = var_128_28
				end
			end

			if arg_125_1.time_ >= var_128_25 + var_128_26 and arg_125_1.time_ < var_128_25 + var_128_26 + arg_128_0 and not isNil(var_128_24) and arg_125_1.var_.characterEffect1150ui_story then
				local var_128_29 = 0.5

				arg_125_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1150ui_story.fillRatio = var_128_29
			end

			local var_128_30 = 0
			local var_128_31 = 0.6

			if var_128_30 < arg_125_1.time_ and arg_125_1.time_ <= var_128_30 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_32 = arg_125_1:FormatText(StoryNameCfg[84].name)

				arg_125_1.leftNameTxt_.text = var_128_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_33 = arg_125_1:GetWordFromCfg(318301030)
				local var_128_34 = arg_125_1:FormatText(var_128_33.content)

				arg_125_1.text_.text = var_128_34

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_35 = 24
				local var_128_36 = utf8.len(var_128_34)
				local var_128_37 = var_128_35 <= 0 and var_128_31 or var_128_31 * (var_128_36 / var_128_35)

				if var_128_37 > 0 and var_128_31 < var_128_37 then
					arg_125_1.talkMaxDuration = var_128_37

					if var_128_37 + var_128_30 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_37 + var_128_30
					end
				end

				arg_125_1.text_.text = var_128_34
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301030", "story_v_out_318301.awb") ~= 0 then
					local var_128_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301030", "story_v_out_318301.awb") / 1000

					if var_128_38 + var_128_30 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_38 + var_128_30
					end

					if var_128_33.prefab_name ~= "" and arg_125_1.actors_[var_128_33.prefab_name] ~= nil then
						local var_128_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_33.prefab_name].transform, "story_v_out_318301", "318301030", "story_v_out_318301.awb")

						arg_125_1:RecordAudio("318301030", var_128_39)
						arg_125_1:RecordAudio("318301030", var_128_39)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_318301", "318301030", "story_v_out_318301.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_318301", "318301030", "story_v_out_318301.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_40 = math.max(var_128_31, arg_125_1.talkMaxDuration)

			if var_128_30 <= arg_125_1.time_ and arg_125_1.time_ < var_128_30 + var_128_40 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_30) / var_128_40

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_30 + var_128_40 and arg_125_1.time_ < var_128_30 + var_128_40 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play318301031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 318301031
		arg_129_1.duration_ = 2.83

		local var_129_0 = {
			zh = 2.833,
			ja = 2.633
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
				arg_129_0:Play318301032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1093ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos1093ui_story = var_132_0.localPosition
			end

			local var_132_2 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2
				local var_132_4 = Vector3.New(0, -1.11, -5.88)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1093ui_story, var_132_4, var_132_3)

				local var_132_5 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_5.x, var_132_5.y, var_132_5.z)

				local var_132_6 = var_132_0.localEulerAngles

				var_132_6.z = 0
				var_132_6.x = 0
				var_132_0.localEulerAngles = var_132_6
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_132_7 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_7.x, var_132_7.y, var_132_7.z)

				local var_132_8 = var_132_0.localEulerAngles

				var_132_8.z = 0
				var_132_8.x = 0
				var_132_0.localEulerAngles = var_132_8
			end

			local var_132_9 = arg_129_1.actors_["1093ui_story"]
			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect1093ui_story == nil then
				arg_129_1.var_.characterEffect1093ui_story = var_132_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_11 = 0.200000002980232

			if var_132_10 <= arg_129_1.time_ and arg_129_1.time_ < var_132_10 + var_132_11 and not isNil(var_132_9) then
				local var_132_12 = (arg_129_1.time_ - var_132_10) / var_132_11

				if arg_129_1.var_.characterEffect1093ui_story and not isNil(var_132_9) then
					arg_129_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_10 + var_132_11 and arg_129_1.time_ < var_132_10 + var_132_11 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect1093ui_story then
				arg_129_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_132_13 = 0

			if var_132_13 < arg_129_1.time_ and arg_129_1.time_ <= var_132_13 + arg_132_0 then
				arg_129_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			local var_132_14 = 0

			if var_132_14 < arg_129_1.time_ and arg_129_1.time_ <= var_132_14 + arg_132_0 then
				arg_129_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_15 = arg_129_1.actors_["1199ui_story"].transform
			local var_132_16 = 0

			if var_132_16 < arg_129_1.time_ and arg_129_1.time_ <= var_132_16 + arg_132_0 then
				arg_129_1.var_.moveOldPos1199ui_story = var_132_15.localPosition
			end

			local var_132_17 = 0.001

			if var_132_16 <= arg_129_1.time_ and arg_129_1.time_ < var_132_16 + var_132_17 then
				local var_132_18 = (arg_129_1.time_ - var_132_16) / var_132_17
				local var_132_19 = Vector3.New(0, 100, 0)

				var_132_15.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1199ui_story, var_132_19, var_132_18)

				local var_132_20 = manager.ui.mainCamera.transform.position - var_132_15.position

				var_132_15.forward = Vector3.New(var_132_20.x, var_132_20.y, var_132_20.z)

				local var_132_21 = var_132_15.localEulerAngles

				var_132_21.z = 0
				var_132_21.x = 0
				var_132_15.localEulerAngles = var_132_21
			end

			if arg_129_1.time_ >= var_132_16 + var_132_17 and arg_129_1.time_ < var_132_16 + var_132_17 + arg_132_0 then
				var_132_15.localPosition = Vector3.New(0, 100, 0)

				local var_132_22 = manager.ui.mainCamera.transform.position - var_132_15.position

				var_132_15.forward = Vector3.New(var_132_22.x, var_132_22.y, var_132_22.z)

				local var_132_23 = var_132_15.localEulerAngles

				var_132_23.z = 0
				var_132_23.x = 0
				var_132_15.localEulerAngles = var_132_23
			end

			local var_132_24 = arg_129_1.actors_["1199ui_story"]
			local var_132_25 = 0

			if var_132_25 < arg_129_1.time_ and arg_129_1.time_ <= var_132_25 + arg_132_0 and not isNil(var_132_24) and arg_129_1.var_.characterEffect1199ui_story == nil then
				arg_129_1.var_.characterEffect1199ui_story = var_132_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_26 = 0.200000002980232

			if var_132_25 <= arg_129_1.time_ and arg_129_1.time_ < var_132_25 + var_132_26 and not isNil(var_132_24) then
				local var_132_27 = (arg_129_1.time_ - var_132_25) / var_132_26

				if arg_129_1.var_.characterEffect1199ui_story and not isNil(var_132_24) then
					local var_132_28 = Mathf.Lerp(0, 0.5, var_132_27)

					arg_129_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1199ui_story.fillRatio = var_132_28
				end
			end

			if arg_129_1.time_ >= var_132_25 + var_132_26 and arg_129_1.time_ < var_132_25 + var_132_26 + arg_132_0 and not isNil(var_132_24) and arg_129_1.var_.characterEffect1199ui_story then
				local var_132_29 = 0.5

				arg_129_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1199ui_story.fillRatio = var_132_29
			end

			local var_132_30 = 0
			local var_132_31 = 0.25

			if var_132_30 < arg_129_1.time_ and arg_129_1.time_ <= var_132_30 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_32 = arg_129_1:FormatText(StoryNameCfg[73].name)

				arg_129_1.leftNameTxt_.text = var_132_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_33 = arg_129_1:GetWordFromCfg(318301031)
				local var_132_34 = arg_129_1:FormatText(var_132_33.content)

				arg_129_1.text_.text = var_132_34

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_35 = 10
				local var_132_36 = utf8.len(var_132_34)
				local var_132_37 = var_132_35 <= 0 and var_132_31 or var_132_31 * (var_132_36 / var_132_35)

				if var_132_37 > 0 and var_132_31 < var_132_37 then
					arg_129_1.talkMaxDuration = var_132_37

					if var_132_37 + var_132_30 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_37 + var_132_30
					end
				end

				arg_129_1.text_.text = var_132_34
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301031", "story_v_out_318301.awb") ~= 0 then
					local var_132_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301031", "story_v_out_318301.awb") / 1000

					if var_132_38 + var_132_30 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_38 + var_132_30
					end

					if var_132_33.prefab_name ~= "" and arg_129_1.actors_[var_132_33.prefab_name] ~= nil then
						local var_132_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_33.prefab_name].transform, "story_v_out_318301", "318301031", "story_v_out_318301.awb")

						arg_129_1:RecordAudio("318301031", var_132_39)
						arg_129_1:RecordAudio("318301031", var_132_39)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_318301", "318301031", "story_v_out_318301.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_318301", "318301031", "story_v_out_318301.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_40 = math.max(var_132_31, arg_129_1.talkMaxDuration)

			if var_132_30 <= arg_129_1.time_ and arg_129_1.time_ < var_132_30 + var_132_40 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_30) / var_132_40

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_30 + var_132_40 and arg_129_1.time_ < var_132_30 + var_132_40 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play318301032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 318301032
		arg_133_1.duration_ = 3.3

		local var_133_0 = {
			zh = 1.999999999999,
			ja = 3.3
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
				arg_133_0:Play318301033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1199ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos1199ui_story = var_136_0.localPosition
			end

			local var_136_2 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2
				local var_136_4 = Vector3.New(0, -1.08, -5.9)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1199ui_story, var_136_4, var_136_3)

				local var_136_5 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_5.x, var_136_5.y, var_136_5.z)

				local var_136_6 = var_136_0.localEulerAngles

				var_136_6.z = 0
				var_136_6.x = 0
				var_136_0.localEulerAngles = var_136_6
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_136_7 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_7.x, var_136_7.y, var_136_7.z)

				local var_136_8 = var_136_0.localEulerAngles

				var_136_8.z = 0
				var_136_8.x = 0
				var_136_0.localEulerAngles = var_136_8
			end

			local var_136_9 = arg_133_1.actors_["1199ui_story"]
			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect1199ui_story == nil then
				arg_133_1.var_.characterEffect1199ui_story = var_136_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_11 = 0.200000002980232

			if var_136_10 <= arg_133_1.time_ and arg_133_1.time_ < var_136_10 + var_136_11 and not isNil(var_136_9) then
				local var_136_12 = (arg_133_1.time_ - var_136_10) / var_136_11

				if arg_133_1.var_.characterEffect1199ui_story and not isNil(var_136_9) then
					arg_133_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_10 + var_136_11 and arg_133_1.time_ < var_136_10 + var_136_11 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect1199ui_story then
				arg_133_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_136_13 = 0

			if var_136_13 < arg_133_1.time_ and arg_133_1.time_ <= var_136_13 + arg_136_0 then
				arg_133_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			local var_136_14 = 0

			if var_136_14 < arg_133_1.time_ and arg_133_1.time_ <= var_136_14 + arg_136_0 then
				arg_133_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_136_15 = arg_133_1.actors_["1093ui_story"].transform
			local var_136_16 = 0

			if var_136_16 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 then
				arg_133_1.var_.moveOldPos1093ui_story = var_136_15.localPosition
			end

			local var_136_17 = 0.001

			if var_136_16 <= arg_133_1.time_ and arg_133_1.time_ < var_136_16 + var_136_17 then
				local var_136_18 = (arg_133_1.time_ - var_136_16) / var_136_17
				local var_136_19 = Vector3.New(0, 100, 0)

				var_136_15.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1093ui_story, var_136_19, var_136_18)

				local var_136_20 = manager.ui.mainCamera.transform.position - var_136_15.position

				var_136_15.forward = Vector3.New(var_136_20.x, var_136_20.y, var_136_20.z)

				local var_136_21 = var_136_15.localEulerAngles

				var_136_21.z = 0
				var_136_21.x = 0
				var_136_15.localEulerAngles = var_136_21
			end

			if arg_133_1.time_ >= var_136_16 + var_136_17 and arg_133_1.time_ < var_136_16 + var_136_17 + arg_136_0 then
				var_136_15.localPosition = Vector3.New(0, 100, 0)

				local var_136_22 = manager.ui.mainCamera.transform.position - var_136_15.position

				var_136_15.forward = Vector3.New(var_136_22.x, var_136_22.y, var_136_22.z)

				local var_136_23 = var_136_15.localEulerAngles

				var_136_23.z = 0
				var_136_23.x = 0
				var_136_15.localEulerAngles = var_136_23
			end

			local var_136_24 = arg_133_1.actors_["1093ui_story"]
			local var_136_25 = 0

			if var_136_25 < arg_133_1.time_ and arg_133_1.time_ <= var_136_25 + arg_136_0 and not isNil(var_136_24) and arg_133_1.var_.characterEffect1093ui_story == nil then
				arg_133_1.var_.characterEffect1093ui_story = var_136_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_26 = 0.200000002980232

			if var_136_25 <= arg_133_1.time_ and arg_133_1.time_ < var_136_25 + var_136_26 and not isNil(var_136_24) then
				local var_136_27 = (arg_133_1.time_ - var_136_25) / var_136_26

				if arg_133_1.var_.characterEffect1093ui_story and not isNil(var_136_24) then
					local var_136_28 = Mathf.Lerp(0, 0.5, var_136_27)

					arg_133_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1093ui_story.fillRatio = var_136_28
				end
			end

			if arg_133_1.time_ >= var_136_25 + var_136_26 and arg_133_1.time_ < var_136_25 + var_136_26 + arg_136_0 and not isNil(var_136_24) and arg_133_1.var_.characterEffect1093ui_story then
				local var_136_29 = 0.5

				arg_133_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1093ui_story.fillRatio = var_136_29
			end

			local var_136_30 = 0
			local var_136_31 = 0.15

			if var_136_30 < arg_133_1.time_ and arg_133_1.time_ <= var_136_30 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_32 = arg_133_1:FormatText(StoryNameCfg[84].name)

				arg_133_1.leftNameTxt_.text = var_136_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_33 = arg_133_1:GetWordFromCfg(318301032)
				local var_136_34 = arg_133_1:FormatText(var_136_33.content)

				arg_133_1.text_.text = var_136_34

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_35 = 6
				local var_136_36 = utf8.len(var_136_34)
				local var_136_37 = var_136_35 <= 0 and var_136_31 or var_136_31 * (var_136_36 / var_136_35)

				if var_136_37 > 0 and var_136_31 < var_136_37 then
					arg_133_1.talkMaxDuration = var_136_37

					if var_136_37 + var_136_30 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_37 + var_136_30
					end
				end

				arg_133_1.text_.text = var_136_34
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301032", "story_v_out_318301.awb") ~= 0 then
					local var_136_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301032", "story_v_out_318301.awb") / 1000

					if var_136_38 + var_136_30 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_38 + var_136_30
					end

					if var_136_33.prefab_name ~= "" and arg_133_1.actors_[var_136_33.prefab_name] ~= nil then
						local var_136_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_33.prefab_name].transform, "story_v_out_318301", "318301032", "story_v_out_318301.awb")

						arg_133_1:RecordAudio("318301032", var_136_39)
						arg_133_1:RecordAudio("318301032", var_136_39)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_318301", "318301032", "story_v_out_318301.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_318301", "318301032", "story_v_out_318301.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_40 = math.max(var_136_31, arg_133_1.talkMaxDuration)

			if var_136_30 <= arg_133_1.time_ and arg_133_1.time_ < var_136_30 + var_136_40 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_30) / var_136_40

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_30 + var_136_40 and arg_133_1.time_ < var_136_30 + var_136_40 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play318301033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 318301033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play318301034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1199ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos1199ui_story = var_140_0.localPosition
			end

			local var_140_2 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2
				local var_140_4 = Vector3.New(0, 100, 0)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1199ui_story, var_140_4, var_140_3)

				local var_140_5 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_5.x, var_140_5.y, var_140_5.z)

				local var_140_6 = var_140_0.localEulerAngles

				var_140_6.z = 0
				var_140_6.x = 0
				var_140_0.localEulerAngles = var_140_6
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, 100, 0)

				local var_140_7 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_7.x, var_140_7.y, var_140_7.z)

				local var_140_8 = var_140_0.localEulerAngles

				var_140_8.z = 0
				var_140_8.x = 0
				var_140_0.localEulerAngles = var_140_8
			end

			local var_140_9 = arg_137_1.actors_["1199ui_story"]
			local var_140_10 = 0

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 and not isNil(var_140_9) and arg_137_1.var_.characterEffect1199ui_story == nil then
				arg_137_1.var_.characterEffect1199ui_story = var_140_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_11 = 0.200000002980232

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_11 and not isNil(var_140_9) then
				local var_140_12 = (arg_137_1.time_ - var_140_10) / var_140_11

				if arg_137_1.var_.characterEffect1199ui_story and not isNil(var_140_9) then
					local var_140_13 = Mathf.Lerp(0, 0.5, var_140_12)

					arg_137_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1199ui_story.fillRatio = var_140_13
				end
			end

			if arg_137_1.time_ >= var_140_10 + var_140_11 and arg_137_1.time_ < var_140_10 + var_140_11 + arg_140_0 and not isNil(var_140_9) and arg_137_1.var_.characterEffect1199ui_story then
				local var_140_14 = 0.5

				arg_137_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1199ui_story.fillRatio = var_140_14
			end

			local var_140_15 = 0
			local var_140_16 = 0.825

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_17 = arg_137_1:GetWordFromCfg(318301033)
				local var_140_18 = arg_137_1:FormatText(var_140_17.content)

				arg_137_1.text_.text = var_140_18

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_19 = 33
				local var_140_20 = utf8.len(var_140_18)
				local var_140_21 = var_140_19 <= 0 and var_140_16 or var_140_16 * (var_140_20 / var_140_19)

				if var_140_21 > 0 and var_140_16 < var_140_21 then
					arg_137_1.talkMaxDuration = var_140_21

					if var_140_21 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_21 + var_140_15
					end
				end

				arg_137_1.text_.text = var_140_18
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_22 = math.max(var_140_16, arg_137_1.talkMaxDuration)

			if var_140_15 <= arg_137_1.time_ and arg_137_1.time_ < var_140_15 + var_140_22 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_15) / var_140_22

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_15 + var_140_22 and arg_137_1.time_ < var_140_15 + var_140_22 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play318301034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 318301034
		arg_141_1.duration_ = 2.77

		local var_141_0 = {
			zh = 2.6,
			ja = 2.766
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
				arg_141_0:Play318301035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1199ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1199ui_story = var_144_0.localPosition
			end

			local var_144_2 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2
				local var_144_4 = Vector3.New(0, -1.08, -5.9)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1199ui_story, var_144_4, var_144_3)

				local var_144_5 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_5.x, var_144_5.y, var_144_5.z)

				local var_144_6 = var_144_0.localEulerAngles

				var_144_6.z = 0
				var_144_6.x = 0
				var_144_0.localEulerAngles = var_144_6
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_144_7 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_7.x, var_144_7.y, var_144_7.z)

				local var_144_8 = var_144_0.localEulerAngles

				var_144_8.z = 0
				var_144_8.x = 0
				var_144_0.localEulerAngles = var_144_8
			end

			local var_144_9 = arg_141_1.actors_["1199ui_story"]
			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1199ui_story == nil then
				arg_141_1.var_.characterEffect1199ui_story = var_144_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_11 = 0.200000002980232

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_11 and not isNil(var_144_9) then
				local var_144_12 = (arg_141_1.time_ - var_144_10) / var_144_11

				if arg_141_1.var_.characterEffect1199ui_story and not isNil(var_144_9) then
					arg_141_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_10 + var_144_11 and arg_141_1.time_ < var_144_10 + var_144_11 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1199ui_story then
				arg_141_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_144_13 = 0

			if var_144_13 < arg_141_1.time_ and arg_141_1.time_ <= var_144_13 + arg_144_0 then
				arg_141_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			local var_144_14 = 0

			if var_144_14 < arg_141_1.time_ and arg_141_1.time_ <= var_144_14 + arg_144_0 then
				arg_141_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_144_15 = 0
			local var_144_16 = 0.175

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_17 = arg_141_1:FormatText(StoryNameCfg[84].name)

				arg_141_1.leftNameTxt_.text = var_144_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_18 = arg_141_1:GetWordFromCfg(318301034)
				local var_144_19 = arg_141_1:FormatText(var_144_18.content)

				arg_141_1.text_.text = var_144_19

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_20 = 7
				local var_144_21 = utf8.len(var_144_19)
				local var_144_22 = var_144_20 <= 0 and var_144_16 or var_144_16 * (var_144_21 / var_144_20)

				if var_144_22 > 0 and var_144_16 < var_144_22 then
					arg_141_1.talkMaxDuration = var_144_22

					if var_144_22 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_22 + var_144_15
					end
				end

				arg_141_1.text_.text = var_144_19
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301034", "story_v_out_318301.awb") ~= 0 then
					local var_144_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301034", "story_v_out_318301.awb") / 1000

					if var_144_23 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_23 + var_144_15
					end

					if var_144_18.prefab_name ~= "" and arg_141_1.actors_[var_144_18.prefab_name] ~= nil then
						local var_144_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_18.prefab_name].transform, "story_v_out_318301", "318301034", "story_v_out_318301.awb")

						arg_141_1:RecordAudio("318301034", var_144_24)
						arg_141_1:RecordAudio("318301034", var_144_24)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_318301", "318301034", "story_v_out_318301.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_318301", "318301034", "story_v_out_318301.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_25 = math.max(var_144_16, arg_141_1.talkMaxDuration)

			if var_144_15 <= arg_141_1.time_ and arg_141_1.time_ < var_144_15 + var_144_25 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_15) / var_144_25

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_15 + var_144_25 and arg_141_1.time_ < var_144_15 + var_144_25 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play318301035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 318301035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play318301036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1199ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1199ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0, 100, 0)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1199ui_story, var_148_4, var_148_3)

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

			local var_148_9 = arg_145_1.actors_["1199ui_story"]
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect1199ui_story == nil then
				arg_145_1.var_.characterEffect1199ui_story = var_148_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_11 = 0.200000002980232

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 and not isNil(var_148_9) then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11

				if arg_145_1.var_.characterEffect1199ui_story and not isNil(var_148_9) then
					local var_148_13 = Mathf.Lerp(0, 0.5, var_148_12)

					arg_145_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1199ui_story.fillRatio = var_148_13
				end
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect1199ui_story then
				local var_148_14 = 0.5

				arg_145_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1199ui_story.fillRatio = var_148_14
			end

			local var_148_15 = 0
			local var_148_16 = 0.475

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_17 = arg_145_1:FormatText(StoryNameCfg[7].name)

				arg_145_1.leftNameTxt_.text = var_148_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_18 = arg_145_1:GetWordFromCfg(318301035)
				local var_148_19 = arg_145_1:FormatText(var_148_18.content)

				arg_145_1.text_.text = var_148_19

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 19
				local var_148_21 = utf8.len(var_148_19)
				local var_148_22 = var_148_20 <= 0 and var_148_16 or var_148_16 * (var_148_21 / var_148_20)

				if var_148_22 > 0 and var_148_16 < var_148_22 then
					arg_145_1.talkMaxDuration = var_148_22

					if var_148_22 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_22 + var_148_15
					end
				end

				arg_145_1.text_.text = var_148_19
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_23 = math.max(var_148_16, arg_145_1.talkMaxDuration)

			if var_148_15 <= arg_145_1.time_ and arg_145_1.time_ < var_148_15 + var_148_23 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_15) / var_148_23

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_15 + var_148_23 and arg_145_1.time_ < var_148_15 + var_148_23 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play318301036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 318301036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play318301037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.7

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[7].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:GetWordFromCfg(318301036)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 28
				local var_152_6 = utf8.len(var_152_4)
				local var_152_7 = var_152_5 <= 0 and var_152_1 or var_152_1 * (var_152_6 / var_152_5)

				if var_152_7 > 0 and var_152_1 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_8 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_8 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_8

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_8 and arg_149_1.time_ < var_152_0 + var_152_8 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play318301037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 318301037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play318301038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.7

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_2 = arg_153_1:GetWordFromCfg(318301037)
				local var_156_3 = arg_153_1:FormatText(var_156_2.content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 28
				local var_156_5 = utf8.len(var_156_3)
				local var_156_6 = var_156_4 <= 0 and var_156_1 or var_156_1 * (var_156_5 / var_156_4)

				if var_156_6 > 0 and var_156_1 < var_156_6 then
					arg_153_1.talkMaxDuration = var_156_6

					if var_156_6 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_7 and arg_153_1.time_ < var_156_0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play318301038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 318301038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play318301039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 1.05

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[7].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_3 = arg_157_1:GetWordFromCfg(318301038)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 42
				local var_160_6 = utf8.len(var_160_4)
				local var_160_7 = var_160_5 <= 0 and var_160_1 or var_160_1 * (var_160_6 / var_160_5)

				if var_160_7 > 0 and var_160_1 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_8 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_8 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_8

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_8 and arg_157_1.time_ < var_160_0 + var_160_8 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play318301039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 318301039
		arg_161_1.duration_ = 2.1

		local var_161_0 = {
			zh = 1.999999999999,
			ja = 2.1
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
				arg_161_0:Play318301040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1150ui_story"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos1150ui_story = var_164_0.localPosition
			end

			local var_164_2 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2
				local var_164_4 = Vector3.New(0, -1.01, -6.2)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1150ui_story, var_164_4, var_164_3)

				local var_164_5 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_5.x, var_164_5.y, var_164_5.z)

				local var_164_6 = var_164_0.localEulerAngles

				var_164_6.z = 0
				var_164_6.x = 0
				var_164_0.localEulerAngles = var_164_6
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_164_7 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_7.x, var_164_7.y, var_164_7.z)

				local var_164_8 = var_164_0.localEulerAngles

				var_164_8.z = 0
				var_164_8.x = 0
				var_164_0.localEulerAngles = var_164_8
			end

			local var_164_9 = arg_161_1.actors_["1150ui_story"]
			local var_164_10 = 0

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 and not isNil(var_164_9) and arg_161_1.var_.characterEffect1150ui_story == nil then
				arg_161_1.var_.characterEffect1150ui_story = var_164_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_11 = 0.200000002980232

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_11 and not isNil(var_164_9) then
				local var_164_12 = (arg_161_1.time_ - var_164_10) / var_164_11

				if arg_161_1.var_.characterEffect1150ui_story and not isNil(var_164_9) then
					arg_161_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_10 + var_164_11 and arg_161_1.time_ < var_164_10 + var_164_11 + arg_164_0 and not isNil(var_164_9) and arg_161_1.var_.characterEffect1150ui_story then
				arg_161_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_164_13 = 0

			if var_164_13 < arg_161_1.time_ and arg_161_1.time_ <= var_164_13 + arg_164_0 then
				arg_161_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_164_14 = 0

			if var_164_14 < arg_161_1.time_ and arg_161_1.time_ <= var_164_14 + arg_164_0 then
				arg_161_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_15 = 0
			local var_164_16 = 0.05

			if var_164_15 < arg_161_1.time_ and arg_161_1.time_ <= var_164_15 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_17 = arg_161_1:FormatText(StoryNameCfg[74].name)

				arg_161_1.leftNameTxt_.text = var_164_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_18 = arg_161_1:GetWordFromCfg(318301039)
				local var_164_19 = arg_161_1:FormatText(var_164_18.content)

				arg_161_1.text_.text = var_164_19

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_20 = 2
				local var_164_21 = utf8.len(var_164_19)
				local var_164_22 = var_164_20 <= 0 and var_164_16 or var_164_16 * (var_164_21 / var_164_20)

				if var_164_22 > 0 and var_164_16 < var_164_22 then
					arg_161_1.talkMaxDuration = var_164_22

					if var_164_22 + var_164_15 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_22 + var_164_15
					end
				end

				arg_161_1.text_.text = var_164_19
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301039", "story_v_out_318301.awb") ~= 0 then
					local var_164_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301039", "story_v_out_318301.awb") / 1000

					if var_164_23 + var_164_15 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_23 + var_164_15
					end

					if var_164_18.prefab_name ~= "" and arg_161_1.actors_[var_164_18.prefab_name] ~= nil then
						local var_164_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_18.prefab_name].transform, "story_v_out_318301", "318301039", "story_v_out_318301.awb")

						arg_161_1:RecordAudio("318301039", var_164_24)
						arg_161_1:RecordAudio("318301039", var_164_24)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_318301", "318301039", "story_v_out_318301.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_318301", "318301039", "story_v_out_318301.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_25 = math.max(var_164_16, arg_161_1.talkMaxDuration)

			if var_164_15 <= arg_161_1.time_ and arg_161_1.time_ < var_164_15 + var_164_25 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_15) / var_164_25

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_15 + var_164_25 and arg_161_1.time_ < var_164_15 + var_164_25 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play318301040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 318301040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play318301041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1150ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1150ui_story = var_168_0.localPosition
			end

			local var_168_2 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2
				local var_168_4 = Vector3.New(0, 100, 0)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1150ui_story, var_168_4, var_168_3)

				local var_168_5 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_5.x, var_168_5.y, var_168_5.z)

				local var_168_6 = var_168_0.localEulerAngles

				var_168_6.z = 0
				var_168_6.x = 0
				var_168_0.localEulerAngles = var_168_6
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(0, 100, 0)

				local var_168_7 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_7.x, var_168_7.y, var_168_7.z)

				local var_168_8 = var_168_0.localEulerAngles

				var_168_8.z = 0
				var_168_8.x = 0
				var_168_0.localEulerAngles = var_168_8
			end

			local var_168_9 = arg_165_1.actors_["1150ui_story"]
			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1150ui_story == nil then
				arg_165_1.var_.characterEffect1150ui_story = var_168_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_11 = 0.200000002980232

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_11 and not isNil(var_168_9) then
				local var_168_12 = (arg_165_1.time_ - var_168_10) / var_168_11

				if arg_165_1.var_.characterEffect1150ui_story and not isNil(var_168_9) then
					local var_168_13 = Mathf.Lerp(0, 0.5, var_168_12)

					arg_165_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1150ui_story.fillRatio = var_168_13
				end
			end

			if arg_165_1.time_ >= var_168_10 + var_168_11 and arg_165_1.time_ < var_168_10 + var_168_11 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1150ui_story then
				local var_168_14 = 0.5

				arg_165_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1150ui_story.fillRatio = var_168_14
			end

			local var_168_15 = 0
			local var_168_16 = 0.25

			if var_168_15 < arg_165_1.time_ and arg_165_1.time_ <= var_168_15 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_17 = arg_165_1:FormatText(StoryNameCfg[7].name)

				arg_165_1.leftNameTxt_.text = var_168_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_18 = arg_165_1:GetWordFromCfg(318301040)
				local var_168_19 = arg_165_1:FormatText(var_168_18.content)

				arg_165_1.text_.text = var_168_19

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_20 = 10
				local var_168_21 = utf8.len(var_168_19)
				local var_168_22 = var_168_20 <= 0 and var_168_16 or var_168_16 * (var_168_21 / var_168_20)

				if var_168_22 > 0 and var_168_16 < var_168_22 then
					arg_165_1.talkMaxDuration = var_168_22

					if var_168_22 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_22 + var_168_15
					end
				end

				arg_165_1.text_.text = var_168_19
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_23 = math.max(var_168_16, arg_165_1.talkMaxDuration)

			if var_168_15 <= arg_165_1.time_ and arg_165_1.time_ < var_168_15 + var_168_23 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_15) / var_168_23

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_15 + var_168_23 and arg_165_1.time_ < var_168_15 + var_168_23 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play318301041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 318301041
		arg_169_1.duration_ = 8.7

		local var_169_0 = {
			zh = 8.5,
			ja = 8.7
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
				arg_169_0:Play318301042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1093ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1093ui_story = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(0, -1.11, -5.88)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1093ui_story, var_172_4, var_172_3)

				local var_172_5 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_5.x, var_172_5.y, var_172_5.z)

				local var_172_6 = var_172_0.localEulerAngles

				var_172_6.z = 0
				var_172_6.x = 0
				var_172_0.localEulerAngles = var_172_6
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_172_7 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_7.x, var_172_7.y, var_172_7.z)

				local var_172_8 = var_172_0.localEulerAngles

				var_172_8.z = 0
				var_172_8.x = 0
				var_172_0.localEulerAngles = var_172_8
			end

			local var_172_9 = arg_169_1.actors_["1093ui_story"]
			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1093ui_story == nil then
				arg_169_1.var_.characterEffect1093ui_story = var_172_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_11 = 0.200000002980232

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_11 and not isNil(var_172_9) then
				local var_172_12 = (arg_169_1.time_ - var_172_10) / var_172_11

				if arg_169_1.var_.characterEffect1093ui_story and not isNil(var_172_9) then
					arg_169_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_10 + var_172_11 and arg_169_1.time_ < var_172_10 + var_172_11 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1093ui_story then
				arg_169_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_172_13 = 0

			if var_172_13 < arg_169_1.time_ and arg_169_1.time_ <= var_172_13 + arg_172_0 then
				arg_169_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			local var_172_14 = 0

			if var_172_14 < arg_169_1.time_ and arg_169_1.time_ <= var_172_14 + arg_172_0 then
				arg_169_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_172_15 = 0
			local var_172_16 = 0.975

			if var_172_15 < arg_169_1.time_ and arg_169_1.time_ <= var_172_15 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_17 = arg_169_1:FormatText(StoryNameCfg[73].name)

				arg_169_1.leftNameTxt_.text = var_172_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_18 = arg_169_1:GetWordFromCfg(318301041)
				local var_172_19 = arg_169_1:FormatText(var_172_18.content)

				arg_169_1.text_.text = var_172_19

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_20 = 39
				local var_172_21 = utf8.len(var_172_19)
				local var_172_22 = var_172_20 <= 0 and var_172_16 or var_172_16 * (var_172_21 / var_172_20)

				if var_172_22 > 0 and var_172_16 < var_172_22 then
					arg_169_1.talkMaxDuration = var_172_22

					if var_172_22 + var_172_15 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_22 + var_172_15
					end
				end

				arg_169_1.text_.text = var_172_19
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301041", "story_v_out_318301.awb") ~= 0 then
					local var_172_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301041", "story_v_out_318301.awb") / 1000

					if var_172_23 + var_172_15 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_23 + var_172_15
					end

					if var_172_18.prefab_name ~= "" and arg_169_1.actors_[var_172_18.prefab_name] ~= nil then
						local var_172_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_18.prefab_name].transform, "story_v_out_318301", "318301041", "story_v_out_318301.awb")

						arg_169_1:RecordAudio("318301041", var_172_24)
						arg_169_1:RecordAudio("318301041", var_172_24)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_318301", "318301041", "story_v_out_318301.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_318301", "318301041", "story_v_out_318301.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_25 = math.max(var_172_16, arg_169_1.talkMaxDuration)

			if var_172_15 <= arg_169_1.time_ and arg_169_1.time_ < var_172_15 + var_172_25 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_15) / var_172_25

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_15 + var_172_25 and arg_169_1.time_ < var_172_15 + var_172_25 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play318301042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 318301042
		arg_173_1.duration_ = 2

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play318301043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1150ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos1150ui_story = var_176_0.localPosition
			end

			local var_176_2 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(0, -1.01, -6.2)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1150ui_story, var_176_4, var_176_3)

				local var_176_5 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_5.x, var_176_5.y, var_176_5.z)

				local var_176_6 = var_176_0.localEulerAngles

				var_176_6.z = 0
				var_176_6.x = 0
				var_176_0.localEulerAngles = var_176_6
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_176_7 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_7.x, var_176_7.y, var_176_7.z)

				local var_176_8 = var_176_0.localEulerAngles

				var_176_8.z = 0
				var_176_8.x = 0
				var_176_0.localEulerAngles = var_176_8
			end

			local var_176_9 = arg_173_1.actors_["1150ui_story"]
			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect1150ui_story == nil then
				arg_173_1.var_.characterEffect1150ui_story = var_176_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_11 = 0.200000002980232

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_11 and not isNil(var_176_9) then
				local var_176_12 = (arg_173_1.time_ - var_176_10) / var_176_11

				if arg_173_1.var_.characterEffect1150ui_story and not isNil(var_176_9) then
					arg_173_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_10 + var_176_11 and arg_173_1.time_ < var_176_10 + var_176_11 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect1150ui_story then
				arg_173_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_176_13 = 0

			if var_176_13 < arg_173_1.time_ and arg_173_1.time_ <= var_176_13 + arg_176_0 then
				arg_173_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_14 = arg_173_1.actors_["1093ui_story"].transform
			local var_176_15 = 0

			if var_176_15 < arg_173_1.time_ and arg_173_1.time_ <= var_176_15 + arg_176_0 then
				arg_173_1.var_.moveOldPos1093ui_story = var_176_14.localPosition
			end

			local var_176_16 = 0.001

			if var_176_15 <= arg_173_1.time_ and arg_173_1.time_ < var_176_15 + var_176_16 then
				local var_176_17 = (arg_173_1.time_ - var_176_15) / var_176_16
				local var_176_18 = Vector3.New(0, 100, 0)

				var_176_14.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1093ui_story, var_176_18, var_176_17)

				local var_176_19 = manager.ui.mainCamera.transform.position - var_176_14.position

				var_176_14.forward = Vector3.New(var_176_19.x, var_176_19.y, var_176_19.z)

				local var_176_20 = var_176_14.localEulerAngles

				var_176_20.z = 0
				var_176_20.x = 0
				var_176_14.localEulerAngles = var_176_20
			end

			if arg_173_1.time_ >= var_176_15 + var_176_16 and arg_173_1.time_ < var_176_15 + var_176_16 + arg_176_0 then
				var_176_14.localPosition = Vector3.New(0, 100, 0)

				local var_176_21 = manager.ui.mainCamera.transform.position - var_176_14.position

				var_176_14.forward = Vector3.New(var_176_21.x, var_176_21.y, var_176_21.z)

				local var_176_22 = var_176_14.localEulerAngles

				var_176_22.z = 0
				var_176_22.x = 0
				var_176_14.localEulerAngles = var_176_22
			end

			local var_176_23 = arg_173_1.actors_["1093ui_story"]
			local var_176_24 = 0

			if var_176_24 < arg_173_1.time_ and arg_173_1.time_ <= var_176_24 + arg_176_0 and not isNil(var_176_23) and arg_173_1.var_.characterEffect1093ui_story == nil then
				arg_173_1.var_.characterEffect1093ui_story = var_176_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_25 = 0.200000002980232

			if var_176_24 <= arg_173_1.time_ and arg_173_1.time_ < var_176_24 + var_176_25 and not isNil(var_176_23) then
				local var_176_26 = (arg_173_1.time_ - var_176_24) / var_176_25

				if arg_173_1.var_.characterEffect1093ui_story and not isNil(var_176_23) then
					local var_176_27 = Mathf.Lerp(0, 0.5, var_176_26)

					arg_173_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1093ui_story.fillRatio = var_176_27
				end
			end

			if arg_173_1.time_ >= var_176_24 + var_176_25 and arg_173_1.time_ < var_176_24 + var_176_25 + arg_176_0 and not isNil(var_176_23) and arg_173_1.var_.characterEffect1093ui_story then
				local var_176_28 = 0.5

				arg_173_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1093ui_story.fillRatio = var_176_28
			end

			local var_176_29 = 0
			local var_176_30 = 0.1

			if var_176_29 < arg_173_1.time_ and arg_173_1.time_ <= var_176_29 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_31 = arg_173_1:FormatText(StoryNameCfg[74].name)

				arg_173_1.leftNameTxt_.text = var_176_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_32 = arg_173_1:GetWordFromCfg(318301042)
				local var_176_33 = arg_173_1:FormatText(var_176_32.content)

				arg_173_1.text_.text = var_176_33

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_34 = 4
				local var_176_35 = utf8.len(var_176_33)
				local var_176_36 = var_176_34 <= 0 and var_176_30 or var_176_30 * (var_176_35 / var_176_34)

				if var_176_36 > 0 and var_176_30 < var_176_36 then
					arg_173_1.talkMaxDuration = var_176_36

					if var_176_36 + var_176_29 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_36 + var_176_29
					end
				end

				arg_173_1.text_.text = var_176_33
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301042", "story_v_out_318301.awb") ~= 0 then
					local var_176_37 = manager.audio:GetVoiceLength("story_v_out_318301", "318301042", "story_v_out_318301.awb") / 1000

					if var_176_37 + var_176_29 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_37 + var_176_29
					end

					if var_176_32.prefab_name ~= "" and arg_173_1.actors_[var_176_32.prefab_name] ~= nil then
						local var_176_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_32.prefab_name].transform, "story_v_out_318301", "318301042", "story_v_out_318301.awb")

						arg_173_1:RecordAudio("318301042", var_176_38)
						arg_173_1:RecordAudio("318301042", var_176_38)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_318301", "318301042", "story_v_out_318301.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_318301", "318301042", "story_v_out_318301.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_39 = math.max(var_176_30, arg_173_1.talkMaxDuration)

			if var_176_29 <= arg_173_1.time_ and arg_173_1.time_ < var_176_29 + var_176_39 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_29) / var_176_39

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_29 + var_176_39 and arg_173_1.time_ < var_176_29 + var_176_39 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play318301043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 318301043
		arg_177_1.duration_ = 6.1

		local var_177_0 = {
			zh = 4.966,
			ja = 6.1
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
				arg_177_0:Play318301044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1199ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1199ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(0, -1.08, -5.9)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1199ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = arg_177_1.actors_["1199ui_story"]
			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1199ui_story == nil then
				arg_177_1.var_.characterEffect1199ui_story = var_180_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_11 = 0.200000002980232

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_11 and not isNil(var_180_9) then
				local var_180_12 = (arg_177_1.time_ - var_180_10) / var_180_11

				if arg_177_1.var_.characterEffect1199ui_story and not isNil(var_180_9) then
					arg_177_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_10 + var_180_11 and arg_177_1.time_ < var_180_10 + var_180_11 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1199ui_story then
				arg_177_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_180_13 = 0

			if var_180_13 < arg_177_1.time_ and arg_177_1.time_ <= var_180_13 + arg_180_0 then
				arg_177_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			local var_180_14 = 0

			if var_180_14 < arg_177_1.time_ and arg_177_1.time_ <= var_180_14 + arg_180_0 then
				arg_177_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_180_15 = arg_177_1.actors_["1150ui_story"].transform
			local var_180_16 = 0

			if var_180_16 < arg_177_1.time_ and arg_177_1.time_ <= var_180_16 + arg_180_0 then
				arg_177_1.var_.moveOldPos1150ui_story = var_180_15.localPosition
			end

			local var_180_17 = 0.001

			if var_180_16 <= arg_177_1.time_ and arg_177_1.time_ < var_180_16 + var_180_17 then
				local var_180_18 = (arg_177_1.time_ - var_180_16) / var_180_17
				local var_180_19 = Vector3.New(0, 100, 0)

				var_180_15.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1150ui_story, var_180_19, var_180_18)

				local var_180_20 = manager.ui.mainCamera.transform.position - var_180_15.position

				var_180_15.forward = Vector3.New(var_180_20.x, var_180_20.y, var_180_20.z)

				local var_180_21 = var_180_15.localEulerAngles

				var_180_21.z = 0
				var_180_21.x = 0
				var_180_15.localEulerAngles = var_180_21
			end

			if arg_177_1.time_ >= var_180_16 + var_180_17 and arg_177_1.time_ < var_180_16 + var_180_17 + arg_180_0 then
				var_180_15.localPosition = Vector3.New(0, 100, 0)

				local var_180_22 = manager.ui.mainCamera.transform.position - var_180_15.position

				var_180_15.forward = Vector3.New(var_180_22.x, var_180_22.y, var_180_22.z)

				local var_180_23 = var_180_15.localEulerAngles

				var_180_23.z = 0
				var_180_23.x = 0
				var_180_15.localEulerAngles = var_180_23
			end

			local var_180_24 = arg_177_1.actors_["1150ui_story"]
			local var_180_25 = 0

			if var_180_25 < arg_177_1.time_ and arg_177_1.time_ <= var_180_25 + arg_180_0 and not isNil(var_180_24) and arg_177_1.var_.characterEffect1150ui_story == nil then
				arg_177_1.var_.characterEffect1150ui_story = var_180_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_26 = 0.200000002980232

			if var_180_25 <= arg_177_1.time_ and arg_177_1.time_ < var_180_25 + var_180_26 and not isNil(var_180_24) then
				local var_180_27 = (arg_177_1.time_ - var_180_25) / var_180_26

				if arg_177_1.var_.characterEffect1150ui_story and not isNil(var_180_24) then
					local var_180_28 = Mathf.Lerp(0, 0.5, var_180_27)

					arg_177_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1150ui_story.fillRatio = var_180_28
				end
			end

			if arg_177_1.time_ >= var_180_25 + var_180_26 and arg_177_1.time_ < var_180_25 + var_180_26 + arg_180_0 and not isNil(var_180_24) and arg_177_1.var_.characterEffect1150ui_story then
				local var_180_29 = 0.5

				arg_177_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1150ui_story.fillRatio = var_180_29
			end

			local var_180_30 = 0
			local var_180_31 = 0.475

			if var_180_30 < arg_177_1.time_ and arg_177_1.time_ <= var_180_30 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_32 = arg_177_1:FormatText(StoryNameCfg[84].name)

				arg_177_1.leftNameTxt_.text = var_180_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_33 = arg_177_1:GetWordFromCfg(318301043)
				local var_180_34 = arg_177_1:FormatText(var_180_33.content)

				arg_177_1.text_.text = var_180_34

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_35 = 19
				local var_180_36 = utf8.len(var_180_34)
				local var_180_37 = var_180_35 <= 0 and var_180_31 or var_180_31 * (var_180_36 / var_180_35)

				if var_180_37 > 0 and var_180_31 < var_180_37 then
					arg_177_1.talkMaxDuration = var_180_37

					if var_180_37 + var_180_30 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_37 + var_180_30
					end
				end

				arg_177_1.text_.text = var_180_34
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301043", "story_v_out_318301.awb") ~= 0 then
					local var_180_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301043", "story_v_out_318301.awb") / 1000

					if var_180_38 + var_180_30 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_38 + var_180_30
					end

					if var_180_33.prefab_name ~= "" and arg_177_1.actors_[var_180_33.prefab_name] ~= nil then
						local var_180_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_33.prefab_name].transform, "story_v_out_318301", "318301043", "story_v_out_318301.awb")

						arg_177_1:RecordAudio("318301043", var_180_39)
						arg_177_1:RecordAudio("318301043", var_180_39)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_318301", "318301043", "story_v_out_318301.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_318301", "318301043", "story_v_out_318301.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_40 = math.max(var_180_31, arg_177_1.talkMaxDuration)

			if var_180_30 <= arg_177_1.time_ and arg_177_1.time_ < var_180_30 + var_180_40 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_30) / var_180_40

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_30 + var_180_40 and arg_177_1.time_ < var_180_30 + var_180_40 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play318301044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 318301044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play318301045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1199ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1199ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0, 100, 0)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1199ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0, 100, 0)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = arg_181_1.actors_["1199ui_story"]
			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect1199ui_story == nil then
				arg_181_1.var_.characterEffect1199ui_story = var_184_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_11 = 0.200000002980232

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_11 and not isNil(var_184_9) then
				local var_184_12 = (arg_181_1.time_ - var_184_10) / var_184_11

				if arg_181_1.var_.characterEffect1199ui_story and not isNil(var_184_9) then
					local var_184_13 = Mathf.Lerp(0, 0.5, var_184_12)

					arg_181_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1199ui_story.fillRatio = var_184_13
				end
			end

			if arg_181_1.time_ >= var_184_10 + var_184_11 and arg_181_1.time_ < var_184_10 + var_184_11 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect1199ui_story then
				local var_184_14 = 0.5

				arg_181_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1199ui_story.fillRatio = var_184_14
			end

			local var_184_15 = 0
			local var_184_16 = 0.6

			if var_184_15 < arg_181_1.time_ and arg_181_1.time_ <= var_184_15 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_17 = arg_181_1:GetWordFromCfg(318301044)
				local var_184_18 = arg_181_1:FormatText(var_184_17.content)

				arg_181_1.text_.text = var_184_18

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_19 = 24
				local var_184_20 = utf8.len(var_184_18)
				local var_184_21 = var_184_19 <= 0 and var_184_16 or var_184_16 * (var_184_20 / var_184_19)

				if var_184_21 > 0 and var_184_16 < var_184_21 then
					arg_181_1.talkMaxDuration = var_184_21

					if var_184_21 + var_184_15 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_21 + var_184_15
					end
				end

				arg_181_1.text_.text = var_184_18
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_22 = math.max(var_184_16, arg_181_1.talkMaxDuration)

			if var_184_15 <= arg_181_1.time_ and arg_181_1.time_ < var_184_15 + var_184_22 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_15) / var_184_22

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_15 + var_184_22 and arg_181_1.time_ < var_184_15 + var_184_22 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play318301045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 318301045
		arg_185_1.duration_ = 3.6

		local var_185_0 = {
			zh = 1.999999999999,
			ja = 3.6
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
				arg_185_0:Play318301046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1150ui_story"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos1150ui_story = var_188_0.localPosition
			end

			local var_188_2 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2
				local var_188_4 = Vector3.New(0, -1.01, -6.2)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1150ui_story, var_188_4, var_188_3)

				local var_188_5 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_5.x, var_188_5.y, var_188_5.z)

				local var_188_6 = var_188_0.localEulerAngles

				var_188_6.z = 0
				var_188_6.x = 0
				var_188_0.localEulerAngles = var_188_6
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_188_7 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_7.x, var_188_7.y, var_188_7.z)

				local var_188_8 = var_188_0.localEulerAngles

				var_188_8.z = 0
				var_188_8.x = 0
				var_188_0.localEulerAngles = var_188_8
			end

			local var_188_9 = arg_185_1.actors_["1150ui_story"]
			local var_188_10 = 0

			if var_188_10 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 and not isNil(var_188_9) and arg_185_1.var_.characterEffect1150ui_story == nil then
				arg_185_1.var_.characterEffect1150ui_story = var_188_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_11 = 0.200000002980232

			if var_188_10 <= arg_185_1.time_ and arg_185_1.time_ < var_188_10 + var_188_11 and not isNil(var_188_9) then
				local var_188_12 = (arg_185_1.time_ - var_188_10) / var_188_11

				if arg_185_1.var_.characterEffect1150ui_story and not isNil(var_188_9) then
					arg_185_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_10 + var_188_11 and arg_185_1.time_ < var_188_10 + var_188_11 + arg_188_0 and not isNil(var_188_9) and arg_185_1.var_.characterEffect1150ui_story then
				arg_185_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_188_13 = 0

			if var_188_13 < arg_185_1.time_ and arg_185_1.time_ <= var_188_13 + arg_188_0 then
				arg_185_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action5_1")
			end

			local var_188_14 = 0

			if var_188_14 < arg_185_1.time_ and arg_185_1.time_ <= var_188_14 + arg_188_0 then
				arg_185_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_188_15 = 0
			local var_188_16 = 0.125

			if var_188_15 < arg_185_1.time_ and arg_185_1.time_ <= var_188_15 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_17 = arg_185_1:FormatText(StoryNameCfg[74].name)

				arg_185_1.leftNameTxt_.text = var_188_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_18 = arg_185_1:GetWordFromCfg(318301045)
				local var_188_19 = arg_185_1:FormatText(var_188_18.content)

				arg_185_1.text_.text = var_188_19

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_20 = 5
				local var_188_21 = utf8.len(var_188_19)
				local var_188_22 = var_188_20 <= 0 and var_188_16 or var_188_16 * (var_188_21 / var_188_20)

				if var_188_22 > 0 and var_188_16 < var_188_22 then
					arg_185_1.talkMaxDuration = var_188_22

					if var_188_22 + var_188_15 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_22 + var_188_15
					end
				end

				arg_185_1.text_.text = var_188_19
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301045", "story_v_out_318301.awb") ~= 0 then
					local var_188_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301045", "story_v_out_318301.awb") / 1000

					if var_188_23 + var_188_15 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_23 + var_188_15
					end

					if var_188_18.prefab_name ~= "" and arg_185_1.actors_[var_188_18.prefab_name] ~= nil then
						local var_188_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_18.prefab_name].transform, "story_v_out_318301", "318301045", "story_v_out_318301.awb")

						arg_185_1:RecordAudio("318301045", var_188_24)
						arg_185_1:RecordAudio("318301045", var_188_24)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_318301", "318301045", "story_v_out_318301.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_318301", "318301045", "story_v_out_318301.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_25 = math.max(var_188_16, arg_185_1.talkMaxDuration)

			if var_188_15 <= arg_185_1.time_ and arg_185_1.time_ < var_188_15 + var_188_25 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_15) / var_188_25

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_15 + var_188_25 and arg_185_1.time_ < var_188_15 + var_188_25 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play318301046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 318301046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play318301047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1150ui_story"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1150ui_story = var_192_0.localPosition
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(0, 100, 0)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1150ui_story, var_192_4, var_192_3)

				local var_192_5 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_5.x, var_192_5.y, var_192_5.z)

				local var_192_6 = var_192_0.localEulerAngles

				var_192_6.z = 0
				var_192_6.x = 0
				var_192_0.localEulerAngles = var_192_6
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0, 100, 0)

				local var_192_7 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_7.x, var_192_7.y, var_192_7.z)

				local var_192_8 = var_192_0.localEulerAngles

				var_192_8.z = 0
				var_192_8.x = 0
				var_192_0.localEulerAngles = var_192_8
			end

			local var_192_9 = arg_189_1.actors_["1150ui_story"]
			local var_192_10 = 0

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1150ui_story == nil then
				arg_189_1.var_.characterEffect1150ui_story = var_192_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_11 = 0.200000002980232

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_11 and not isNil(var_192_9) then
				local var_192_12 = (arg_189_1.time_ - var_192_10) / var_192_11

				if arg_189_1.var_.characterEffect1150ui_story and not isNil(var_192_9) then
					local var_192_13 = Mathf.Lerp(0, 0.5, var_192_12)

					arg_189_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1150ui_story.fillRatio = var_192_13
				end
			end

			if arg_189_1.time_ >= var_192_10 + var_192_11 and arg_189_1.time_ < var_192_10 + var_192_11 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1150ui_story then
				local var_192_14 = 0.5

				arg_189_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1150ui_story.fillRatio = var_192_14
			end

			local var_192_15 = 0
			local var_192_16 = 0.575

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_17 = arg_189_1:FormatText(StoryNameCfg[7].name)

				arg_189_1.leftNameTxt_.text = var_192_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_18 = arg_189_1:GetWordFromCfg(318301046)
				local var_192_19 = arg_189_1:FormatText(var_192_18.content)

				arg_189_1.text_.text = var_192_19

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_20 = 23
				local var_192_21 = utf8.len(var_192_19)
				local var_192_22 = var_192_20 <= 0 and var_192_16 or var_192_16 * (var_192_21 / var_192_20)

				if var_192_22 > 0 and var_192_16 < var_192_22 then
					arg_189_1.talkMaxDuration = var_192_22

					if var_192_22 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_22 + var_192_15
					end
				end

				arg_189_1.text_.text = var_192_19
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_23 = math.max(var_192_16, arg_189_1.talkMaxDuration)

			if var_192_15 <= arg_189_1.time_ and arg_189_1.time_ < var_192_15 + var_192_23 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_15) / var_192_23

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_15 + var_192_23 and arg_189_1.time_ < var_192_15 + var_192_23 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play318301047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 318301047
		arg_193_1.duration_ = 2.87

		local var_193_0 = {
			zh = 2.866,
			ja = 2.333
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
				arg_193_0:Play318301048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1055ui_story"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1055ui_story = var_196_0.localPosition
			end

			local var_196_2 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(0, -0.965, -6.2)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1055ui_story, var_196_4, var_196_3)

				local var_196_5 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_5.x, var_196_5.y, var_196_5.z)

				local var_196_6 = var_196_0.localEulerAngles

				var_196_6.z = 0
				var_196_6.x = 0
				var_196_0.localEulerAngles = var_196_6
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_196_7 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_7.x, var_196_7.y, var_196_7.z)

				local var_196_8 = var_196_0.localEulerAngles

				var_196_8.z = 0
				var_196_8.x = 0
				var_196_0.localEulerAngles = var_196_8
			end

			local var_196_9 = arg_193_1.actors_["1055ui_story"]
			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect1055ui_story == nil then
				arg_193_1.var_.characterEffect1055ui_story = var_196_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_11 = 0.200000002980232

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_11 and not isNil(var_196_9) then
				local var_196_12 = (arg_193_1.time_ - var_196_10) / var_196_11

				if arg_193_1.var_.characterEffect1055ui_story and not isNil(var_196_9) then
					arg_193_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_10 + var_196_11 and arg_193_1.time_ < var_196_10 + var_196_11 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect1055ui_story then
				arg_193_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_196_13 = 0

			if var_196_13 < arg_193_1.time_ and arg_193_1.time_ <= var_196_13 + arg_196_0 then
				arg_193_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_196_14 = 0

			if var_196_14 < arg_193_1.time_ and arg_193_1.time_ <= var_196_14 + arg_196_0 then
				arg_193_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_196_15 = 0
			local var_196_16 = 0.275

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_17 = arg_193_1:FormatText(StoryNameCfg[481].name)

				arg_193_1.leftNameTxt_.text = var_196_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_18 = arg_193_1:GetWordFromCfg(318301047)
				local var_196_19 = arg_193_1:FormatText(var_196_18.content)

				arg_193_1.text_.text = var_196_19

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_20 = 11
				local var_196_21 = utf8.len(var_196_19)
				local var_196_22 = var_196_20 <= 0 and var_196_16 or var_196_16 * (var_196_21 / var_196_20)

				if var_196_22 > 0 and var_196_16 < var_196_22 then
					arg_193_1.talkMaxDuration = var_196_22

					if var_196_22 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_22 + var_196_15
					end
				end

				arg_193_1.text_.text = var_196_19
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301047", "story_v_out_318301.awb") ~= 0 then
					local var_196_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301047", "story_v_out_318301.awb") / 1000

					if var_196_23 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_23 + var_196_15
					end

					if var_196_18.prefab_name ~= "" and arg_193_1.actors_[var_196_18.prefab_name] ~= nil then
						local var_196_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_18.prefab_name].transform, "story_v_out_318301", "318301047", "story_v_out_318301.awb")

						arg_193_1:RecordAudio("318301047", var_196_24)
						arg_193_1:RecordAudio("318301047", var_196_24)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_318301", "318301047", "story_v_out_318301.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_318301", "318301047", "story_v_out_318301.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_25 = math.max(var_196_16, arg_193_1.talkMaxDuration)

			if var_196_15 <= arg_193_1.time_ and arg_193_1.time_ < var_196_15 + var_196_25 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_15) / var_196_25

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_15 + var_196_25 and arg_193_1.time_ < var_196_15 + var_196_25 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play318301048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 318301048
		arg_197_1.duration_ = 3.9

		local var_197_0 = {
			zh = 3.833,
			ja = 3.9
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
				arg_197_0:Play318301049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1093ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos1093ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0, -1.11, -5.88)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1093ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = arg_197_1.actors_["1093ui_story"]
			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1093ui_story == nil then
				arg_197_1.var_.characterEffect1093ui_story = var_200_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_11 = 0.200000002980232

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 and not isNil(var_200_9) then
				local var_200_12 = (arg_197_1.time_ - var_200_10) / var_200_11

				if arg_197_1.var_.characterEffect1093ui_story and not isNil(var_200_9) then
					arg_197_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1093ui_story then
				arg_197_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_200_13 = 0

			if var_200_13 < arg_197_1.time_ and arg_197_1.time_ <= var_200_13 + arg_200_0 then
				arg_197_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action468")
			end

			local var_200_14 = 0

			if var_200_14 < arg_197_1.time_ and arg_197_1.time_ <= var_200_14 + arg_200_0 then
				arg_197_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_200_15 = arg_197_1.actors_["1055ui_story"].transform
			local var_200_16 = 0

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1.var_.moveOldPos1055ui_story = var_200_15.localPosition
			end

			local var_200_17 = 0.001

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_17 then
				local var_200_18 = (arg_197_1.time_ - var_200_16) / var_200_17
				local var_200_19 = Vector3.New(0, 100, 0)

				var_200_15.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1055ui_story, var_200_19, var_200_18)

				local var_200_20 = manager.ui.mainCamera.transform.position - var_200_15.position

				var_200_15.forward = Vector3.New(var_200_20.x, var_200_20.y, var_200_20.z)

				local var_200_21 = var_200_15.localEulerAngles

				var_200_21.z = 0
				var_200_21.x = 0
				var_200_15.localEulerAngles = var_200_21
			end

			if arg_197_1.time_ >= var_200_16 + var_200_17 and arg_197_1.time_ < var_200_16 + var_200_17 + arg_200_0 then
				var_200_15.localPosition = Vector3.New(0, 100, 0)

				local var_200_22 = manager.ui.mainCamera.transform.position - var_200_15.position

				var_200_15.forward = Vector3.New(var_200_22.x, var_200_22.y, var_200_22.z)

				local var_200_23 = var_200_15.localEulerAngles

				var_200_23.z = 0
				var_200_23.x = 0
				var_200_15.localEulerAngles = var_200_23
			end

			local var_200_24 = arg_197_1.actors_["1055ui_story"]
			local var_200_25 = 0

			if var_200_25 < arg_197_1.time_ and arg_197_1.time_ <= var_200_25 + arg_200_0 and not isNil(var_200_24) and arg_197_1.var_.characterEffect1055ui_story == nil then
				arg_197_1.var_.characterEffect1055ui_story = var_200_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_26 = 0.200000002980232

			if var_200_25 <= arg_197_1.time_ and arg_197_1.time_ < var_200_25 + var_200_26 and not isNil(var_200_24) then
				local var_200_27 = (arg_197_1.time_ - var_200_25) / var_200_26

				if arg_197_1.var_.characterEffect1055ui_story and not isNil(var_200_24) then
					local var_200_28 = Mathf.Lerp(0, 0.5, var_200_27)

					arg_197_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1055ui_story.fillRatio = var_200_28
				end
			end

			if arg_197_1.time_ >= var_200_25 + var_200_26 and arg_197_1.time_ < var_200_25 + var_200_26 + arg_200_0 and not isNil(var_200_24) and arg_197_1.var_.characterEffect1055ui_story then
				local var_200_29 = 0.5

				arg_197_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1055ui_story.fillRatio = var_200_29
			end

			local var_200_30 = 0
			local var_200_31 = 0.425

			if var_200_30 < arg_197_1.time_ and arg_197_1.time_ <= var_200_30 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_32 = arg_197_1:FormatText(StoryNameCfg[73].name)

				arg_197_1.leftNameTxt_.text = var_200_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_33 = arg_197_1:GetWordFromCfg(318301048)
				local var_200_34 = arg_197_1:FormatText(var_200_33.content)

				arg_197_1.text_.text = var_200_34

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_35 = 17
				local var_200_36 = utf8.len(var_200_34)
				local var_200_37 = var_200_35 <= 0 and var_200_31 or var_200_31 * (var_200_36 / var_200_35)

				if var_200_37 > 0 and var_200_31 < var_200_37 then
					arg_197_1.talkMaxDuration = var_200_37

					if var_200_37 + var_200_30 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_37 + var_200_30
					end
				end

				arg_197_1.text_.text = var_200_34
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301048", "story_v_out_318301.awb") ~= 0 then
					local var_200_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301048", "story_v_out_318301.awb") / 1000

					if var_200_38 + var_200_30 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_38 + var_200_30
					end

					if var_200_33.prefab_name ~= "" and arg_197_1.actors_[var_200_33.prefab_name] ~= nil then
						local var_200_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_33.prefab_name].transform, "story_v_out_318301", "318301048", "story_v_out_318301.awb")

						arg_197_1:RecordAudio("318301048", var_200_39)
						arg_197_1:RecordAudio("318301048", var_200_39)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_318301", "318301048", "story_v_out_318301.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_318301", "318301048", "story_v_out_318301.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_40 = math.max(var_200_31, arg_197_1.talkMaxDuration)

			if var_200_30 <= arg_197_1.time_ and arg_197_1.time_ < var_200_30 + var_200_40 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_30) / var_200_40

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_30 + var_200_40 and arg_197_1.time_ < var_200_30 + var_200_40 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play318301049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 318301049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play318301050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1093ui_story"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos1093ui_story = var_204_0.localPosition
			end

			local var_204_2 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2
				local var_204_4 = Vector3.New(0, 100, 0)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1093ui_story, var_204_4, var_204_3)

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

			local var_204_9 = arg_201_1.actors_["1093ui_story"]
			local var_204_10 = 0

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 and not isNil(var_204_9) and arg_201_1.var_.characterEffect1093ui_story == nil then
				arg_201_1.var_.characterEffect1093ui_story = var_204_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_11 = 0.200000002980232

			if var_204_10 <= arg_201_1.time_ and arg_201_1.time_ < var_204_10 + var_204_11 and not isNil(var_204_9) then
				local var_204_12 = (arg_201_1.time_ - var_204_10) / var_204_11

				if arg_201_1.var_.characterEffect1093ui_story and not isNil(var_204_9) then
					local var_204_13 = Mathf.Lerp(0, 0.5, var_204_12)

					arg_201_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1093ui_story.fillRatio = var_204_13
				end
			end

			if arg_201_1.time_ >= var_204_10 + var_204_11 and arg_201_1.time_ < var_204_10 + var_204_11 + arg_204_0 and not isNil(var_204_9) and arg_201_1.var_.characterEffect1093ui_story then
				local var_204_14 = 0.5

				arg_201_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1093ui_story.fillRatio = var_204_14
			end

			local var_204_15 = 0
			local var_204_16 = 0.65

			if var_204_15 < arg_201_1.time_ and arg_201_1.time_ <= var_204_15 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_17 = arg_201_1:GetWordFromCfg(318301049)
				local var_204_18 = arg_201_1:FormatText(var_204_17.content)

				arg_201_1.text_.text = var_204_18

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_19 = 26
				local var_204_20 = utf8.len(var_204_18)
				local var_204_21 = var_204_19 <= 0 and var_204_16 or var_204_16 * (var_204_20 / var_204_19)

				if var_204_21 > 0 and var_204_16 < var_204_21 then
					arg_201_1.talkMaxDuration = var_204_21

					if var_204_21 + var_204_15 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_21 + var_204_15
					end
				end

				arg_201_1.text_.text = var_204_18
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_22 = math.max(var_204_16, arg_201_1.talkMaxDuration)

			if var_204_15 <= arg_201_1.time_ and arg_201_1.time_ < var_204_15 + var_204_22 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_15) / var_204_22

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_15 + var_204_22 and arg_201_1.time_ < var_204_15 + var_204_22 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play318301050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 318301050
		arg_205_1.duration_ = 2.9

		local var_205_0 = {
			zh = 2.9,
			ja = 2.066
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
				arg_205_0:Play318301051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1093ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1093ui_story = var_208_0.localPosition
			end

			local var_208_2 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2
				local var_208_4 = Vector3.New(0, -1.11, -5.88)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1093ui_story, var_208_4, var_208_3)

				local var_208_5 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_5.x, var_208_5.y, var_208_5.z)

				local var_208_6 = var_208_0.localEulerAngles

				var_208_6.z = 0
				var_208_6.x = 0
				var_208_0.localEulerAngles = var_208_6
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_208_7 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_7.x, var_208_7.y, var_208_7.z)

				local var_208_8 = var_208_0.localEulerAngles

				var_208_8.z = 0
				var_208_8.x = 0
				var_208_0.localEulerAngles = var_208_8
			end

			local var_208_9 = arg_205_1.actors_["1093ui_story"]
			local var_208_10 = 0

			if var_208_10 < arg_205_1.time_ and arg_205_1.time_ <= var_208_10 + arg_208_0 and not isNil(var_208_9) and arg_205_1.var_.characterEffect1093ui_story == nil then
				arg_205_1.var_.characterEffect1093ui_story = var_208_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_11 = 0.200000002980232

			if var_208_10 <= arg_205_1.time_ and arg_205_1.time_ < var_208_10 + var_208_11 and not isNil(var_208_9) then
				local var_208_12 = (arg_205_1.time_ - var_208_10) / var_208_11

				if arg_205_1.var_.characterEffect1093ui_story and not isNil(var_208_9) then
					arg_205_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_10 + var_208_11 and arg_205_1.time_ < var_208_10 + var_208_11 + arg_208_0 and not isNil(var_208_9) and arg_205_1.var_.characterEffect1093ui_story then
				arg_205_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_208_13 = 0

			if var_208_13 < arg_205_1.time_ and arg_205_1.time_ <= var_208_13 + arg_208_0 then
				arg_205_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action8_2")
			end

			local var_208_14 = 0

			if var_208_14 < arg_205_1.time_ and arg_205_1.time_ <= var_208_14 + arg_208_0 then
				arg_205_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_208_15 = 0
			local var_208_16 = 0.25

			if var_208_15 < arg_205_1.time_ and arg_205_1.time_ <= var_208_15 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_17 = arg_205_1:FormatText(StoryNameCfg[73].name)

				arg_205_1.leftNameTxt_.text = var_208_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_18 = arg_205_1:GetWordFromCfg(318301050)
				local var_208_19 = arg_205_1:FormatText(var_208_18.content)

				arg_205_1.text_.text = var_208_19

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_20 = 10
				local var_208_21 = utf8.len(var_208_19)
				local var_208_22 = var_208_20 <= 0 and var_208_16 or var_208_16 * (var_208_21 / var_208_20)

				if var_208_22 > 0 and var_208_16 < var_208_22 then
					arg_205_1.talkMaxDuration = var_208_22

					if var_208_22 + var_208_15 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_22 + var_208_15
					end
				end

				arg_205_1.text_.text = var_208_19
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301050", "story_v_out_318301.awb") ~= 0 then
					local var_208_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301050", "story_v_out_318301.awb") / 1000

					if var_208_23 + var_208_15 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_23 + var_208_15
					end

					if var_208_18.prefab_name ~= "" and arg_205_1.actors_[var_208_18.prefab_name] ~= nil then
						local var_208_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_18.prefab_name].transform, "story_v_out_318301", "318301050", "story_v_out_318301.awb")

						arg_205_1:RecordAudio("318301050", var_208_24)
						arg_205_1:RecordAudio("318301050", var_208_24)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_318301", "318301050", "story_v_out_318301.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_318301", "318301050", "story_v_out_318301.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_25 = math.max(var_208_16, arg_205_1.talkMaxDuration)

			if var_208_15 <= arg_205_1.time_ and arg_205_1.time_ < var_208_15 + var_208_25 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_15) / var_208_25

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_15 + var_208_25 and arg_205_1.time_ < var_208_15 + var_208_25 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play318301051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 318301051
		arg_209_1.duration_ = 5.33

		local var_209_0 = {
			zh = 3.633,
			ja = 5.333
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
				arg_209_0:Play318301052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1150ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1150ui_story = var_212_0.localPosition
			end

			local var_212_2 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2
				local var_212_4 = Vector3.New(0, -1.01, -6.2)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1150ui_story, var_212_4, var_212_3)

				local var_212_5 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_5.x, var_212_5.y, var_212_5.z)

				local var_212_6 = var_212_0.localEulerAngles

				var_212_6.z = 0
				var_212_6.x = 0
				var_212_0.localEulerAngles = var_212_6
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_212_7 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_7.x, var_212_7.y, var_212_7.z)

				local var_212_8 = var_212_0.localEulerAngles

				var_212_8.z = 0
				var_212_8.x = 0
				var_212_0.localEulerAngles = var_212_8
			end

			local var_212_9 = arg_209_1.actors_["1150ui_story"]
			local var_212_10 = 0

			if var_212_10 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect1150ui_story == nil then
				arg_209_1.var_.characterEffect1150ui_story = var_212_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_11 = 0.200000002980232

			if var_212_10 <= arg_209_1.time_ and arg_209_1.time_ < var_212_10 + var_212_11 and not isNil(var_212_9) then
				local var_212_12 = (arg_209_1.time_ - var_212_10) / var_212_11

				if arg_209_1.var_.characterEffect1150ui_story and not isNil(var_212_9) then
					arg_209_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_10 + var_212_11 and arg_209_1.time_ < var_212_10 + var_212_11 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect1150ui_story then
				arg_209_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_212_13 = 0

			if var_212_13 < arg_209_1.time_ and arg_209_1.time_ <= var_212_13 + arg_212_0 then
				arg_209_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_212_14 = 0

			if var_212_14 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 then
				arg_209_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_212_15 = arg_209_1.actors_["1093ui_story"].transform
			local var_212_16 = 0

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1.var_.moveOldPos1093ui_story = var_212_15.localPosition
			end

			local var_212_17 = 0.001

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_17 then
				local var_212_18 = (arg_209_1.time_ - var_212_16) / var_212_17
				local var_212_19 = Vector3.New(0, 100, 0)

				var_212_15.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1093ui_story, var_212_19, var_212_18)

				local var_212_20 = manager.ui.mainCamera.transform.position - var_212_15.position

				var_212_15.forward = Vector3.New(var_212_20.x, var_212_20.y, var_212_20.z)

				local var_212_21 = var_212_15.localEulerAngles

				var_212_21.z = 0
				var_212_21.x = 0
				var_212_15.localEulerAngles = var_212_21
			end

			if arg_209_1.time_ >= var_212_16 + var_212_17 and arg_209_1.time_ < var_212_16 + var_212_17 + arg_212_0 then
				var_212_15.localPosition = Vector3.New(0, 100, 0)

				local var_212_22 = manager.ui.mainCamera.transform.position - var_212_15.position

				var_212_15.forward = Vector3.New(var_212_22.x, var_212_22.y, var_212_22.z)

				local var_212_23 = var_212_15.localEulerAngles

				var_212_23.z = 0
				var_212_23.x = 0
				var_212_15.localEulerAngles = var_212_23
			end

			local var_212_24 = arg_209_1.actors_["1093ui_story"]
			local var_212_25 = 0

			if var_212_25 < arg_209_1.time_ and arg_209_1.time_ <= var_212_25 + arg_212_0 and not isNil(var_212_24) and arg_209_1.var_.characterEffect1093ui_story == nil then
				arg_209_1.var_.characterEffect1093ui_story = var_212_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_26 = 0.200000002980232

			if var_212_25 <= arg_209_1.time_ and arg_209_1.time_ < var_212_25 + var_212_26 and not isNil(var_212_24) then
				local var_212_27 = (arg_209_1.time_ - var_212_25) / var_212_26

				if arg_209_1.var_.characterEffect1093ui_story and not isNil(var_212_24) then
					local var_212_28 = Mathf.Lerp(0, 0.5, var_212_27)

					arg_209_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1093ui_story.fillRatio = var_212_28
				end
			end

			if arg_209_1.time_ >= var_212_25 + var_212_26 and arg_209_1.time_ < var_212_25 + var_212_26 + arg_212_0 and not isNil(var_212_24) and arg_209_1.var_.characterEffect1093ui_story then
				local var_212_29 = 0.5

				arg_209_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1093ui_story.fillRatio = var_212_29
			end

			local var_212_30 = 0
			local var_212_31 = 0.45

			if var_212_30 < arg_209_1.time_ and arg_209_1.time_ <= var_212_30 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_32 = arg_209_1:FormatText(StoryNameCfg[74].name)

				arg_209_1.leftNameTxt_.text = var_212_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_33 = arg_209_1:GetWordFromCfg(318301051)
				local var_212_34 = arg_209_1:FormatText(var_212_33.content)

				arg_209_1.text_.text = var_212_34

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_35 = 18
				local var_212_36 = utf8.len(var_212_34)
				local var_212_37 = var_212_35 <= 0 and var_212_31 or var_212_31 * (var_212_36 / var_212_35)

				if var_212_37 > 0 and var_212_31 < var_212_37 then
					arg_209_1.talkMaxDuration = var_212_37

					if var_212_37 + var_212_30 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_37 + var_212_30
					end
				end

				arg_209_1.text_.text = var_212_34
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301051", "story_v_out_318301.awb") ~= 0 then
					local var_212_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301051", "story_v_out_318301.awb") / 1000

					if var_212_38 + var_212_30 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_38 + var_212_30
					end

					if var_212_33.prefab_name ~= "" and arg_209_1.actors_[var_212_33.prefab_name] ~= nil then
						local var_212_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_33.prefab_name].transform, "story_v_out_318301", "318301051", "story_v_out_318301.awb")

						arg_209_1:RecordAudio("318301051", var_212_39)
						arg_209_1:RecordAudio("318301051", var_212_39)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_318301", "318301051", "story_v_out_318301.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_318301", "318301051", "story_v_out_318301.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_40 = math.max(var_212_31, arg_209_1.talkMaxDuration)

			if var_212_30 <= arg_209_1.time_ and arg_209_1.time_ < var_212_30 + var_212_40 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_30) / var_212_40

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_30 + var_212_40 and arg_209_1.time_ < var_212_30 + var_212_40 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play318301052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 318301052
		arg_213_1.duration_ = 3.97

		local var_213_0 = {
			zh = 3.6,
			ja = 3.966
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
				arg_213_0:Play318301053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1055ui_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos1055ui_story = var_216_0.localPosition
			end

			local var_216_2 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2
				local var_216_4 = Vector3.New(0, -0.965, -6.2)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1055ui_story, var_216_4, var_216_3)

				local var_216_5 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_5.x, var_216_5.y, var_216_5.z)

				local var_216_6 = var_216_0.localEulerAngles

				var_216_6.z = 0
				var_216_6.x = 0
				var_216_0.localEulerAngles = var_216_6
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_216_7 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_7.x, var_216_7.y, var_216_7.z)

				local var_216_8 = var_216_0.localEulerAngles

				var_216_8.z = 0
				var_216_8.x = 0
				var_216_0.localEulerAngles = var_216_8
			end

			local var_216_9 = arg_213_1.actors_["1055ui_story"]
			local var_216_10 = 0

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 and not isNil(var_216_9) and arg_213_1.var_.characterEffect1055ui_story == nil then
				arg_213_1.var_.characterEffect1055ui_story = var_216_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_11 = 0.200000002980232

			if var_216_10 <= arg_213_1.time_ and arg_213_1.time_ < var_216_10 + var_216_11 and not isNil(var_216_9) then
				local var_216_12 = (arg_213_1.time_ - var_216_10) / var_216_11

				if arg_213_1.var_.characterEffect1055ui_story and not isNil(var_216_9) then
					arg_213_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_10 + var_216_11 and arg_213_1.time_ < var_216_10 + var_216_11 + arg_216_0 and not isNil(var_216_9) and arg_213_1.var_.characterEffect1055ui_story then
				arg_213_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_216_13 = 0

			if var_216_13 < arg_213_1.time_ and arg_213_1.time_ <= var_216_13 + arg_216_0 then
				arg_213_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_216_14 = 0

			if var_216_14 < arg_213_1.time_ and arg_213_1.time_ <= var_216_14 + arg_216_0 then
				arg_213_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_216_15 = arg_213_1.actors_["1150ui_story"].transform
			local var_216_16 = 0

			if var_216_16 < arg_213_1.time_ and arg_213_1.time_ <= var_216_16 + arg_216_0 then
				arg_213_1.var_.moveOldPos1150ui_story = var_216_15.localPosition
			end

			local var_216_17 = 0.001

			if var_216_16 <= arg_213_1.time_ and arg_213_1.time_ < var_216_16 + var_216_17 then
				local var_216_18 = (arg_213_1.time_ - var_216_16) / var_216_17
				local var_216_19 = Vector3.New(0, 100, 0)

				var_216_15.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1150ui_story, var_216_19, var_216_18)

				local var_216_20 = manager.ui.mainCamera.transform.position - var_216_15.position

				var_216_15.forward = Vector3.New(var_216_20.x, var_216_20.y, var_216_20.z)

				local var_216_21 = var_216_15.localEulerAngles

				var_216_21.z = 0
				var_216_21.x = 0
				var_216_15.localEulerAngles = var_216_21
			end

			if arg_213_1.time_ >= var_216_16 + var_216_17 and arg_213_1.time_ < var_216_16 + var_216_17 + arg_216_0 then
				var_216_15.localPosition = Vector3.New(0, 100, 0)

				local var_216_22 = manager.ui.mainCamera.transform.position - var_216_15.position

				var_216_15.forward = Vector3.New(var_216_22.x, var_216_22.y, var_216_22.z)

				local var_216_23 = var_216_15.localEulerAngles

				var_216_23.z = 0
				var_216_23.x = 0
				var_216_15.localEulerAngles = var_216_23
			end

			local var_216_24 = arg_213_1.actors_["1150ui_story"]
			local var_216_25 = 0

			if var_216_25 < arg_213_1.time_ and arg_213_1.time_ <= var_216_25 + arg_216_0 and not isNil(var_216_24) and arg_213_1.var_.characterEffect1150ui_story == nil then
				arg_213_1.var_.characterEffect1150ui_story = var_216_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_26 = 0.200000002980232

			if var_216_25 <= arg_213_1.time_ and arg_213_1.time_ < var_216_25 + var_216_26 and not isNil(var_216_24) then
				local var_216_27 = (arg_213_1.time_ - var_216_25) / var_216_26

				if arg_213_1.var_.characterEffect1150ui_story and not isNil(var_216_24) then
					local var_216_28 = Mathf.Lerp(0, 0.5, var_216_27)

					arg_213_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1150ui_story.fillRatio = var_216_28
				end
			end

			if arg_213_1.time_ >= var_216_25 + var_216_26 and arg_213_1.time_ < var_216_25 + var_216_26 + arg_216_0 and not isNil(var_216_24) and arg_213_1.var_.characterEffect1150ui_story then
				local var_216_29 = 0.5

				arg_213_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1150ui_story.fillRatio = var_216_29
			end

			local var_216_30 = 0
			local var_216_31 = 0.3

			if var_216_30 < arg_213_1.time_ and arg_213_1.time_ <= var_216_30 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_32 = arg_213_1:FormatText(StoryNameCfg[481].name)

				arg_213_1.leftNameTxt_.text = var_216_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_33 = arg_213_1:GetWordFromCfg(318301052)
				local var_216_34 = arg_213_1:FormatText(var_216_33.content)

				arg_213_1.text_.text = var_216_34

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_35 = 12
				local var_216_36 = utf8.len(var_216_34)
				local var_216_37 = var_216_35 <= 0 and var_216_31 or var_216_31 * (var_216_36 / var_216_35)

				if var_216_37 > 0 and var_216_31 < var_216_37 then
					arg_213_1.talkMaxDuration = var_216_37

					if var_216_37 + var_216_30 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_37 + var_216_30
					end
				end

				arg_213_1.text_.text = var_216_34
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301052", "story_v_out_318301.awb") ~= 0 then
					local var_216_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301052", "story_v_out_318301.awb") / 1000

					if var_216_38 + var_216_30 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_38 + var_216_30
					end

					if var_216_33.prefab_name ~= "" and arg_213_1.actors_[var_216_33.prefab_name] ~= nil then
						local var_216_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_33.prefab_name].transform, "story_v_out_318301", "318301052", "story_v_out_318301.awb")

						arg_213_1:RecordAudio("318301052", var_216_39)
						arg_213_1:RecordAudio("318301052", var_216_39)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_318301", "318301052", "story_v_out_318301.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_318301", "318301052", "story_v_out_318301.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_40 = math.max(var_216_31, arg_213_1.talkMaxDuration)

			if var_216_30 <= arg_213_1.time_ and arg_213_1.time_ < var_216_30 + var_216_40 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_30) / var_216_40

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_30 + var_216_40 and arg_213_1.time_ < var_216_30 + var_216_40 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play318301053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 318301053
		arg_217_1.duration_ = 13.5

		local var_217_0 = {
			zh = 6.333,
			ja = 13.5
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
				arg_217_0:Play318301054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1093ui_story"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos1093ui_story = var_220_0.localPosition
			end

			local var_220_2 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2
				local var_220_4 = Vector3.New(0, -1.11, -5.88)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1093ui_story, var_220_4, var_220_3)

				local var_220_5 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_5.x, var_220_5.y, var_220_5.z)

				local var_220_6 = var_220_0.localEulerAngles

				var_220_6.z = 0
				var_220_6.x = 0
				var_220_0.localEulerAngles = var_220_6
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_220_7 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_7.x, var_220_7.y, var_220_7.z)

				local var_220_8 = var_220_0.localEulerAngles

				var_220_8.z = 0
				var_220_8.x = 0
				var_220_0.localEulerAngles = var_220_8
			end

			local var_220_9 = arg_217_1.actors_["1093ui_story"]
			local var_220_10 = 0

			if var_220_10 < arg_217_1.time_ and arg_217_1.time_ <= var_220_10 + arg_220_0 and not isNil(var_220_9) and arg_217_1.var_.characterEffect1093ui_story == nil then
				arg_217_1.var_.characterEffect1093ui_story = var_220_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_11 = 0.200000002980232

			if var_220_10 <= arg_217_1.time_ and arg_217_1.time_ < var_220_10 + var_220_11 and not isNil(var_220_9) then
				local var_220_12 = (arg_217_1.time_ - var_220_10) / var_220_11

				if arg_217_1.var_.characterEffect1093ui_story and not isNil(var_220_9) then
					arg_217_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_10 + var_220_11 and arg_217_1.time_ < var_220_10 + var_220_11 + arg_220_0 and not isNil(var_220_9) and arg_217_1.var_.characterEffect1093ui_story then
				arg_217_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_220_13 = 0

			if var_220_13 < arg_217_1.time_ and arg_217_1.time_ <= var_220_13 + arg_220_0 then
				arg_217_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action7_1")
			end

			local var_220_14 = 0

			if var_220_14 < arg_217_1.time_ and arg_217_1.time_ <= var_220_14 + arg_220_0 then
				arg_217_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_220_15 = arg_217_1.actors_["1055ui_story"].transform
			local var_220_16 = 0

			if var_220_16 < arg_217_1.time_ and arg_217_1.time_ <= var_220_16 + arg_220_0 then
				arg_217_1.var_.moveOldPos1055ui_story = var_220_15.localPosition
			end

			local var_220_17 = 0.001

			if var_220_16 <= arg_217_1.time_ and arg_217_1.time_ < var_220_16 + var_220_17 then
				local var_220_18 = (arg_217_1.time_ - var_220_16) / var_220_17
				local var_220_19 = Vector3.New(0, 100, 0)

				var_220_15.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1055ui_story, var_220_19, var_220_18)

				local var_220_20 = manager.ui.mainCamera.transform.position - var_220_15.position

				var_220_15.forward = Vector3.New(var_220_20.x, var_220_20.y, var_220_20.z)

				local var_220_21 = var_220_15.localEulerAngles

				var_220_21.z = 0
				var_220_21.x = 0
				var_220_15.localEulerAngles = var_220_21
			end

			if arg_217_1.time_ >= var_220_16 + var_220_17 and arg_217_1.time_ < var_220_16 + var_220_17 + arg_220_0 then
				var_220_15.localPosition = Vector3.New(0, 100, 0)

				local var_220_22 = manager.ui.mainCamera.transform.position - var_220_15.position

				var_220_15.forward = Vector3.New(var_220_22.x, var_220_22.y, var_220_22.z)

				local var_220_23 = var_220_15.localEulerAngles

				var_220_23.z = 0
				var_220_23.x = 0
				var_220_15.localEulerAngles = var_220_23
			end

			local var_220_24 = arg_217_1.actors_["1055ui_story"]
			local var_220_25 = 0

			if var_220_25 < arg_217_1.time_ and arg_217_1.time_ <= var_220_25 + arg_220_0 and not isNil(var_220_24) and arg_217_1.var_.characterEffect1055ui_story == nil then
				arg_217_1.var_.characterEffect1055ui_story = var_220_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_26 = 0.200000002980232

			if var_220_25 <= arg_217_1.time_ and arg_217_1.time_ < var_220_25 + var_220_26 and not isNil(var_220_24) then
				local var_220_27 = (arg_217_1.time_ - var_220_25) / var_220_26

				if arg_217_1.var_.characterEffect1055ui_story and not isNil(var_220_24) then
					local var_220_28 = Mathf.Lerp(0, 0.5, var_220_27)

					arg_217_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1055ui_story.fillRatio = var_220_28
				end
			end

			if arg_217_1.time_ >= var_220_25 + var_220_26 and arg_217_1.time_ < var_220_25 + var_220_26 + arg_220_0 and not isNil(var_220_24) and arg_217_1.var_.characterEffect1055ui_story then
				local var_220_29 = 0.5

				arg_217_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1055ui_story.fillRatio = var_220_29
			end

			local var_220_30 = 0
			local var_220_31 = 0.625

			if var_220_30 < arg_217_1.time_ and arg_217_1.time_ <= var_220_30 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_32 = arg_217_1:FormatText(StoryNameCfg[73].name)

				arg_217_1.leftNameTxt_.text = var_220_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_33 = arg_217_1:GetWordFromCfg(318301053)
				local var_220_34 = arg_217_1:FormatText(var_220_33.content)

				arg_217_1.text_.text = var_220_34

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_35 = 25
				local var_220_36 = utf8.len(var_220_34)
				local var_220_37 = var_220_35 <= 0 and var_220_31 or var_220_31 * (var_220_36 / var_220_35)

				if var_220_37 > 0 and var_220_31 < var_220_37 then
					arg_217_1.talkMaxDuration = var_220_37

					if var_220_37 + var_220_30 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_37 + var_220_30
					end
				end

				arg_217_1.text_.text = var_220_34
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301053", "story_v_out_318301.awb") ~= 0 then
					local var_220_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301053", "story_v_out_318301.awb") / 1000

					if var_220_38 + var_220_30 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_38 + var_220_30
					end

					if var_220_33.prefab_name ~= "" and arg_217_1.actors_[var_220_33.prefab_name] ~= nil then
						local var_220_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_33.prefab_name].transform, "story_v_out_318301", "318301053", "story_v_out_318301.awb")

						arg_217_1:RecordAudio("318301053", var_220_39)
						arg_217_1:RecordAudio("318301053", var_220_39)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_318301", "318301053", "story_v_out_318301.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_318301", "318301053", "story_v_out_318301.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_40 = math.max(var_220_31, arg_217_1.talkMaxDuration)

			if var_220_30 <= arg_217_1.time_ and arg_217_1.time_ < var_220_30 + var_220_40 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_30) / var_220_40

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_30 + var_220_40 and arg_217_1.time_ < var_220_30 + var_220_40 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play318301054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 318301054
		arg_221_1.duration_ = 8.63

		local var_221_0 = {
			zh = 6.033,
			ja = 8.633
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
				arg_221_0:Play318301055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1055ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1055ui_story = var_224_0.localPosition
			end

			local var_224_2 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2
				local var_224_4 = Vector3.New(0, -0.965, -6.2)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1055ui_story, var_224_4, var_224_3)

				local var_224_5 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_5.x, var_224_5.y, var_224_5.z)

				local var_224_6 = var_224_0.localEulerAngles

				var_224_6.z = 0
				var_224_6.x = 0
				var_224_0.localEulerAngles = var_224_6
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_224_7 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_7.x, var_224_7.y, var_224_7.z)

				local var_224_8 = var_224_0.localEulerAngles

				var_224_8.z = 0
				var_224_8.x = 0
				var_224_0.localEulerAngles = var_224_8
			end

			local var_224_9 = arg_221_1.actors_["1055ui_story"]
			local var_224_10 = 0

			if var_224_10 < arg_221_1.time_ and arg_221_1.time_ <= var_224_10 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect1055ui_story == nil then
				arg_221_1.var_.characterEffect1055ui_story = var_224_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_11 = 0.200000002980232

			if var_224_10 <= arg_221_1.time_ and arg_221_1.time_ < var_224_10 + var_224_11 and not isNil(var_224_9) then
				local var_224_12 = (arg_221_1.time_ - var_224_10) / var_224_11

				if arg_221_1.var_.characterEffect1055ui_story and not isNil(var_224_9) then
					arg_221_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_10 + var_224_11 and arg_221_1.time_ < var_224_10 + var_224_11 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect1055ui_story then
				arg_221_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_224_13 = 0

			if var_224_13 < arg_221_1.time_ and arg_221_1.time_ <= var_224_13 + arg_224_0 then
				arg_221_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_224_14 = 0

			if var_224_14 < arg_221_1.time_ and arg_221_1.time_ <= var_224_14 + arg_224_0 then
				arg_221_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_224_15 = arg_221_1.actors_["1093ui_story"].transform
			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 then
				arg_221_1.var_.moveOldPos1093ui_story = var_224_15.localPosition
			end

			local var_224_17 = 0.001

			if var_224_16 <= arg_221_1.time_ and arg_221_1.time_ < var_224_16 + var_224_17 then
				local var_224_18 = (arg_221_1.time_ - var_224_16) / var_224_17
				local var_224_19 = Vector3.New(0, 100, 0)

				var_224_15.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1093ui_story, var_224_19, var_224_18)

				local var_224_20 = manager.ui.mainCamera.transform.position - var_224_15.position

				var_224_15.forward = Vector3.New(var_224_20.x, var_224_20.y, var_224_20.z)

				local var_224_21 = var_224_15.localEulerAngles

				var_224_21.z = 0
				var_224_21.x = 0
				var_224_15.localEulerAngles = var_224_21
			end

			if arg_221_1.time_ >= var_224_16 + var_224_17 and arg_221_1.time_ < var_224_16 + var_224_17 + arg_224_0 then
				var_224_15.localPosition = Vector3.New(0, 100, 0)

				local var_224_22 = manager.ui.mainCamera.transform.position - var_224_15.position

				var_224_15.forward = Vector3.New(var_224_22.x, var_224_22.y, var_224_22.z)

				local var_224_23 = var_224_15.localEulerAngles

				var_224_23.z = 0
				var_224_23.x = 0
				var_224_15.localEulerAngles = var_224_23
			end

			local var_224_24 = arg_221_1.actors_["1093ui_story"]
			local var_224_25 = 0

			if var_224_25 < arg_221_1.time_ and arg_221_1.time_ <= var_224_25 + arg_224_0 and not isNil(var_224_24) and arg_221_1.var_.characterEffect1093ui_story == nil then
				arg_221_1.var_.characterEffect1093ui_story = var_224_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_26 = 0.200000002980232

			if var_224_25 <= arg_221_1.time_ and arg_221_1.time_ < var_224_25 + var_224_26 and not isNil(var_224_24) then
				local var_224_27 = (arg_221_1.time_ - var_224_25) / var_224_26

				if arg_221_1.var_.characterEffect1093ui_story and not isNil(var_224_24) then
					local var_224_28 = Mathf.Lerp(0, 0.5, var_224_27)

					arg_221_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1093ui_story.fillRatio = var_224_28
				end
			end

			if arg_221_1.time_ >= var_224_25 + var_224_26 and arg_221_1.time_ < var_224_25 + var_224_26 + arg_224_0 and not isNil(var_224_24) and arg_221_1.var_.characterEffect1093ui_story then
				local var_224_29 = 0.5

				arg_221_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1093ui_story.fillRatio = var_224_29
			end

			local var_224_30 = 0
			local var_224_31 = 0.55

			if var_224_30 < arg_221_1.time_ and arg_221_1.time_ <= var_224_30 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_32 = arg_221_1:FormatText(StoryNameCfg[481].name)

				arg_221_1.leftNameTxt_.text = var_224_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_33 = arg_221_1:GetWordFromCfg(318301054)
				local var_224_34 = arg_221_1:FormatText(var_224_33.content)

				arg_221_1.text_.text = var_224_34

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_35 = 22
				local var_224_36 = utf8.len(var_224_34)
				local var_224_37 = var_224_35 <= 0 and var_224_31 or var_224_31 * (var_224_36 / var_224_35)

				if var_224_37 > 0 and var_224_31 < var_224_37 then
					arg_221_1.talkMaxDuration = var_224_37

					if var_224_37 + var_224_30 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_37 + var_224_30
					end
				end

				arg_221_1.text_.text = var_224_34
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301054", "story_v_out_318301.awb") ~= 0 then
					local var_224_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301054", "story_v_out_318301.awb") / 1000

					if var_224_38 + var_224_30 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_38 + var_224_30
					end

					if var_224_33.prefab_name ~= "" and arg_221_1.actors_[var_224_33.prefab_name] ~= nil then
						local var_224_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_33.prefab_name].transform, "story_v_out_318301", "318301054", "story_v_out_318301.awb")

						arg_221_1:RecordAudio("318301054", var_224_39)
						arg_221_1:RecordAudio("318301054", var_224_39)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_318301", "318301054", "story_v_out_318301.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_318301", "318301054", "story_v_out_318301.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_40 = math.max(var_224_31, arg_221_1.talkMaxDuration)

			if var_224_30 <= arg_221_1.time_ and arg_221_1.time_ < var_224_30 + var_224_40 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_30) / var_224_40

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_30 + var_224_40 and arg_221_1.time_ < var_224_30 + var_224_40 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play318301055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 318301055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play318301056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1055ui_story"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos1055ui_story = var_228_0.localPosition
			end

			local var_228_2 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2
				local var_228_4 = Vector3.New(0, 100, 0)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1055ui_story, var_228_4, var_228_3)

				local var_228_5 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_5.x, var_228_5.y, var_228_5.z)

				local var_228_6 = var_228_0.localEulerAngles

				var_228_6.z = 0
				var_228_6.x = 0
				var_228_0.localEulerAngles = var_228_6
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0, 100, 0)

				local var_228_7 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_7.x, var_228_7.y, var_228_7.z)

				local var_228_8 = var_228_0.localEulerAngles

				var_228_8.z = 0
				var_228_8.x = 0
				var_228_0.localEulerAngles = var_228_8
			end

			local var_228_9 = arg_225_1.actors_["1055ui_story"]
			local var_228_10 = 0

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect1055ui_story == nil then
				arg_225_1.var_.characterEffect1055ui_story = var_228_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_11 = 0.200000002980232

			if var_228_10 <= arg_225_1.time_ and arg_225_1.time_ < var_228_10 + var_228_11 and not isNil(var_228_9) then
				local var_228_12 = (arg_225_1.time_ - var_228_10) / var_228_11

				if arg_225_1.var_.characterEffect1055ui_story and not isNil(var_228_9) then
					local var_228_13 = Mathf.Lerp(0, 0.5, var_228_12)

					arg_225_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1055ui_story.fillRatio = var_228_13
				end
			end

			if arg_225_1.time_ >= var_228_10 + var_228_11 and arg_225_1.time_ < var_228_10 + var_228_11 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect1055ui_story then
				local var_228_14 = 0.5

				arg_225_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1055ui_story.fillRatio = var_228_14
			end

			local var_228_15 = 0
			local var_228_16 = 0.65

			if var_228_15 < arg_225_1.time_ and arg_225_1.time_ <= var_228_15 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_17 = arg_225_1:GetWordFromCfg(318301055)
				local var_228_18 = arg_225_1:FormatText(var_228_17.content)

				arg_225_1.text_.text = var_228_18

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_19 = 26
				local var_228_20 = utf8.len(var_228_18)
				local var_228_21 = var_228_19 <= 0 and var_228_16 or var_228_16 * (var_228_20 / var_228_19)

				if var_228_21 > 0 and var_228_16 < var_228_21 then
					arg_225_1.talkMaxDuration = var_228_21

					if var_228_21 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_21 + var_228_15
					end
				end

				arg_225_1.text_.text = var_228_18
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_22 = math.max(var_228_16, arg_225_1.talkMaxDuration)

			if var_228_15 <= arg_225_1.time_ and arg_225_1.time_ < var_228_15 + var_228_22 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_15) / var_228_22

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_15 + var_228_22 and arg_225_1.time_ < var_228_15 + var_228_22 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play318301056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 318301056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play318301057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.65

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[7].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:GetWordFromCfg(318301056)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 26
				local var_232_6 = utf8.len(var_232_4)
				local var_232_7 = var_232_5 <= 0 and var_232_1 or var_232_1 * (var_232_6 / var_232_5)

				if var_232_7 > 0 and var_232_1 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_8 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_8 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_8

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_8 and arg_229_1.time_ < var_232_0 + var_232_8 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play318301057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 318301057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play318301058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 0.425

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_2 = arg_233_1:FormatText(StoryNameCfg[7].name)

				arg_233_1.leftNameTxt_.text = var_236_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_3 = arg_233_1:GetWordFromCfg(318301057)
				local var_236_4 = arg_233_1:FormatText(var_236_3.content)

				arg_233_1.text_.text = var_236_4

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 17
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
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_8 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_8 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_8

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_8 and arg_233_1.time_ < var_236_0 + var_236_8 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play318301058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 318301058
		arg_237_1.duration_ = 2.43

		local var_237_0 = {
			zh = 1.466,
			ja = 2.433
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
				arg_237_0:Play318301059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1093ui_story"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos1093ui_story = var_240_0.localPosition
			end

			local var_240_2 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2
				local var_240_4 = Vector3.New(0, -1.11, -5.88)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1093ui_story, var_240_4, var_240_3)

				local var_240_5 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_5.x, var_240_5.y, var_240_5.z)

				local var_240_6 = var_240_0.localEulerAngles

				var_240_6.z = 0
				var_240_6.x = 0
				var_240_0.localEulerAngles = var_240_6
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_240_7 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_7.x, var_240_7.y, var_240_7.z)

				local var_240_8 = var_240_0.localEulerAngles

				var_240_8.z = 0
				var_240_8.x = 0
				var_240_0.localEulerAngles = var_240_8
			end

			local var_240_9 = arg_237_1.actors_["1093ui_story"]
			local var_240_10 = 0

			if var_240_10 < arg_237_1.time_ and arg_237_1.time_ <= var_240_10 + arg_240_0 and not isNil(var_240_9) and arg_237_1.var_.characterEffect1093ui_story == nil then
				arg_237_1.var_.characterEffect1093ui_story = var_240_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_11 = 0.200000002980232

			if var_240_10 <= arg_237_1.time_ and arg_237_1.time_ < var_240_10 + var_240_11 and not isNil(var_240_9) then
				local var_240_12 = (arg_237_1.time_ - var_240_10) / var_240_11

				if arg_237_1.var_.characterEffect1093ui_story and not isNil(var_240_9) then
					arg_237_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_10 + var_240_11 and arg_237_1.time_ < var_240_10 + var_240_11 + arg_240_0 and not isNil(var_240_9) and arg_237_1.var_.characterEffect1093ui_story then
				arg_237_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_240_13 = 0

			if var_240_13 < arg_237_1.time_ and arg_237_1.time_ <= var_240_13 + arg_240_0 then
				arg_237_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_240_14 = 0

			if var_240_14 < arg_237_1.time_ and arg_237_1.time_ <= var_240_14 + arg_240_0 then
				arg_237_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_240_15 = 0
			local var_240_16 = 0.125

			if var_240_15 < arg_237_1.time_ and arg_237_1.time_ <= var_240_15 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_17 = arg_237_1:FormatText(StoryNameCfg[73].name)

				arg_237_1.leftNameTxt_.text = var_240_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_18 = arg_237_1:GetWordFromCfg(318301058)
				local var_240_19 = arg_237_1:FormatText(var_240_18.content)

				arg_237_1.text_.text = var_240_19

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_20 = 5
				local var_240_21 = utf8.len(var_240_19)
				local var_240_22 = var_240_20 <= 0 and var_240_16 or var_240_16 * (var_240_21 / var_240_20)

				if var_240_22 > 0 and var_240_16 < var_240_22 then
					arg_237_1.talkMaxDuration = var_240_22

					if var_240_22 + var_240_15 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_22 + var_240_15
					end
				end

				arg_237_1.text_.text = var_240_19
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301058", "story_v_out_318301.awb") ~= 0 then
					local var_240_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301058", "story_v_out_318301.awb") / 1000

					if var_240_23 + var_240_15 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_23 + var_240_15
					end

					if var_240_18.prefab_name ~= "" and arg_237_1.actors_[var_240_18.prefab_name] ~= nil then
						local var_240_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_18.prefab_name].transform, "story_v_out_318301", "318301058", "story_v_out_318301.awb")

						arg_237_1:RecordAudio("318301058", var_240_24)
						arg_237_1:RecordAudio("318301058", var_240_24)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_318301", "318301058", "story_v_out_318301.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_318301", "318301058", "story_v_out_318301.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_25 = math.max(var_240_16, arg_237_1.talkMaxDuration)

			if var_240_15 <= arg_237_1.time_ and arg_237_1.time_ < var_240_15 + var_240_25 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_15) / var_240_25

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_15 + var_240_25 and arg_237_1.time_ < var_240_15 + var_240_25 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play318301059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 318301059
		arg_241_1.duration_ = 4.8

		local var_241_0 = {
			zh = 2.666,
			ja = 4.8
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
				arg_241_0:Play318301060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1093ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1093ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(0, -1.11, -5.88)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1093ui_story, var_244_4, var_244_3)

				local var_244_5 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_5.x, var_244_5.y, var_244_5.z)

				local var_244_6 = var_244_0.localEulerAngles

				var_244_6.z = 0
				var_244_6.x = 0
				var_244_0.localEulerAngles = var_244_6
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_244_7 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_7.x, var_244_7.y, var_244_7.z)

				local var_244_8 = var_244_0.localEulerAngles

				var_244_8.z = 0
				var_244_8.x = 0
				var_244_0.localEulerAngles = var_244_8
			end

			local var_244_9 = arg_241_1.actors_["1093ui_story"]
			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1093ui_story == nil then
				arg_241_1.var_.characterEffect1093ui_story = var_244_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_11 = 0.200000002980232

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_11 and not isNil(var_244_9) then
				local var_244_12 = (arg_241_1.time_ - var_244_10) / var_244_11

				if arg_241_1.var_.characterEffect1093ui_story and not isNil(var_244_9) then
					arg_241_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_10 + var_244_11 and arg_241_1.time_ < var_244_10 + var_244_11 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1093ui_story then
				arg_241_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_244_13 = 0

			if var_244_13 < arg_241_1.time_ and arg_241_1.time_ <= var_244_13 + arg_244_0 then
				arg_241_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_244_14 = 0

			if var_244_14 < arg_241_1.time_ and arg_241_1.time_ <= var_244_14 + arg_244_0 then
				arg_241_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_244_15 = 0
			local var_244_16 = 0.35

			if var_244_15 < arg_241_1.time_ and arg_241_1.time_ <= var_244_15 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_17 = arg_241_1:FormatText(StoryNameCfg[73].name)

				arg_241_1.leftNameTxt_.text = var_244_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_18 = arg_241_1:GetWordFromCfg(318301059)
				local var_244_19 = arg_241_1:FormatText(var_244_18.content)

				arg_241_1.text_.text = var_244_19

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_20 = 14
				local var_244_21 = utf8.len(var_244_19)
				local var_244_22 = var_244_20 <= 0 and var_244_16 or var_244_16 * (var_244_21 / var_244_20)

				if var_244_22 > 0 and var_244_16 < var_244_22 then
					arg_241_1.talkMaxDuration = var_244_22

					if var_244_22 + var_244_15 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_22 + var_244_15
					end
				end

				arg_241_1.text_.text = var_244_19
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301059", "story_v_out_318301.awb") ~= 0 then
					local var_244_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301059", "story_v_out_318301.awb") / 1000

					if var_244_23 + var_244_15 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_23 + var_244_15
					end

					if var_244_18.prefab_name ~= "" and arg_241_1.actors_[var_244_18.prefab_name] ~= nil then
						local var_244_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_18.prefab_name].transform, "story_v_out_318301", "318301059", "story_v_out_318301.awb")

						arg_241_1:RecordAudio("318301059", var_244_24)
						arg_241_1:RecordAudio("318301059", var_244_24)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_318301", "318301059", "story_v_out_318301.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_318301", "318301059", "story_v_out_318301.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_25 = math.max(var_244_16, arg_241_1.talkMaxDuration)

			if var_244_15 <= arg_241_1.time_ and arg_241_1.time_ < var_244_15 + var_244_25 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_15) / var_244_25

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_15 + var_244_25 and arg_241_1.time_ < var_244_15 + var_244_25 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play318301060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 318301060
		arg_245_1.duration_ = 7

		local var_245_0 = {
			zh = 7,
			ja = 6.366
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
				arg_245_0:Play318301061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.75

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[73].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:GetWordFromCfg(318301060)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 30
				local var_248_6 = utf8.len(var_248_4)
				local var_248_7 = var_248_5 <= 0 and var_248_1 or var_248_1 * (var_248_6 / var_248_5)

				if var_248_7 > 0 and var_248_1 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301060", "story_v_out_318301.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_318301", "318301060", "story_v_out_318301.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_318301", "318301060", "story_v_out_318301.awb")

						arg_245_1:RecordAudio("318301060", var_248_9)
						arg_245_1:RecordAudio("318301060", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_318301", "318301060", "story_v_out_318301.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_318301", "318301060", "story_v_out_318301.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_10 and arg_245_1.time_ < var_248_0 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play318301061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 318301061
		arg_249_1.duration_ = 5.6

		local var_249_0 = {
			zh = 4.5,
			ja = 5.6
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
				arg_249_0:Play318301062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1150ui_story"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos1150ui_story = var_252_0.localPosition
			end

			local var_252_2 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2
				local var_252_4 = Vector3.New(0, -1.01, -6.2)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1150ui_story, var_252_4, var_252_3)

				local var_252_5 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_5.x, var_252_5.y, var_252_5.z)

				local var_252_6 = var_252_0.localEulerAngles

				var_252_6.z = 0
				var_252_6.x = 0
				var_252_0.localEulerAngles = var_252_6
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_252_7 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_7.x, var_252_7.y, var_252_7.z)

				local var_252_8 = var_252_0.localEulerAngles

				var_252_8.z = 0
				var_252_8.x = 0
				var_252_0.localEulerAngles = var_252_8
			end

			local var_252_9 = arg_249_1.actors_["1150ui_story"]
			local var_252_10 = 0

			if var_252_10 < arg_249_1.time_ and arg_249_1.time_ <= var_252_10 + arg_252_0 and not isNil(var_252_9) and arg_249_1.var_.characterEffect1150ui_story == nil then
				arg_249_1.var_.characterEffect1150ui_story = var_252_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_11 = 0.200000002980232

			if var_252_10 <= arg_249_1.time_ and arg_249_1.time_ < var_252_10 + var_252_11 and not isNil(var_252_9) then
				local var_252_12 = (arg_249_1.time_ - var_252_10) / var_252_11

				if arg_249_1.var_.characterEffect1150ui_story and not isNil(var_252_9) then
					arg_249_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_10 + var_252_11 and arg_249_1.time_ < var_252_10 + var_252_11 + arg_252_0 and not isNil(var_252_9) and arg_249_1.var_.characterEffect1150ui_story then
				arg_249_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_252_13 = 0

			if var_252_13 < arg_249_1.time_ and arg_249_1.time_ <= var_252_13 + arg_252_0 then
				arg_249_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_252_14 = 0

			if var_252_14 < arg_249_1.time_ and arg_249_1.time_ <= var_252_14 + arg_252_0 then
				arg_249_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_252_15 = arg_249_1.actors_["1093ui_story"].transform
			local var_252_16 = 0

			if var_252_16 < arg_249_1.time_ and arg_249_1.time_ <= var_252_16 + arg_252_0 then
				arg_249_1.var_.moveOldPos1093ui_story = var_252_15.localPosition
			end

			local var_252_17 = 0.001

			if var_252_16 <= arg_249_1.time_ and arg_249_1.time_ < var_252_16 + var_252_17 then
				local var_252_18 = (arg_249_1.time_ - var_252_16) / var_252_17
				local var_252_19 = Vector3.New(0, 100, 0)

				var_252_15.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1093ui_story, var_252_19, var_252_18)

				local var_252_20 = manager.ui.mainCamera.transform.position - var_252_15.position

				var_252_15.forward = Vector3.New(var_252_20.x, var_252_20.y, var_252_20.z)

				local var_252_21 = var_252_15.localEulerAngles

				var_252_21.z = 0
				var_252_21.x = 0
				var_252_15.localEulerAngles = var_252_21
			end

			if arg_249_1.time_ >= var_252_16 + var_252_17 and arg_249_1.time_ < var_252_16 + var_252_17 + arg_252_0 then
				var_252_15.localPosition = Vector3.New(0, 100, 0)

				local var_252_22 = manager.ui.mainCamera.transform.position - var_252_15.position

				var_252_15.forward = Vector3.New(var_252_22.x, var_252_22.y, var_252_22.z)

				local var_252_23 = var_252_15.localEulerAngles

				var_252_23.z = 0
				var_252_23.x = 0
				var_252_15.localEulerAngles = var_252_23
			end

			local var_252_24 = arg_249_1.actors_["1093ui_story"]
			local var_252_25 = 0

			if var_252_25 < arg_249_1.time_ and arg_249_1.time_ <= var_252_25 + arg_252_0 and not isNil(var_252_24) and arg_249_1.var_.characterEffect1093ui_story == nil then
				arg_249_1.var_.characterEffect1093ui_story = var_252_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_26 = 0.200000002980232

			if var_252_25 <= arg_249_1.time_ and arg_249_1.time_ < var_252_25 + var_252_26 and not isNil(var_252_24) then
				local var_252_27 = (arg_249_1.time_ - var_252_25) / var_252_26

				if arg_249_1.var_.characterEffect1093ui_story and not isNil(var_252_24) then
					local var_252_28 = Mathf.Lerp(0, 0.5, var_252_27)

					arg_249_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1093ui_story.fillRatio = var_252_28
				end
			end

			if arg_249_1.time_ >= var_252_25 + var_252_26 and arg_249_1.time_ < var_252_25 + var_252_26 + arg_252_0 and not isNil(var_252_24) and arg_249_1.var_.characterEffect1093ui_story then
				local var_252_29 = 0.5

				arg_249_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1093ui_story.fillRatio = var_252_29
			end

			local var_252_30 = 0
			local var_252_31 = 0.525

			if var_252_30 < arg_249_1.time_ and arg_249_1.time_ <= var_252_30 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_32 = arg_249_1:FormatText(StoryNameCfg[74].name)

				arg_249_1.leftNameTxt_.text = var_252_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_33 = arg_249_1:GetWordFromCfg(318301061)
				local var_252_34 = arg_249_1:FormatText(var_252_33.content)

				arg_249_1.text_.text = var_252_34

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_35 = 21
				local var_252_36 = utf8.len(var_252_34)
				local var_252_37 = var_252_35 <= 0 and var_252_31 or var_252_31 * (var_252_36 / var_252_35)

				if var_252_37 > 0 and var_252_31 < var_252_37 then
					arg_249_1.talkMaxDuration = var_252_37

					if var_252_37 + var_252_30 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_37 + var_252_30
					end
				end

				arg_249_1.text_.text = var_252_34
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301061", "story_v_out_318301.awb") ~= 0 then
					local var_252_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301061", "story_v_out_318301.awb") / 1000

					if var_252_38 + var_252_30 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_38 + var_252_30
					end

					if var_252_33.prefab_name ~= "" and arg_249_1.actors_[var_252_33.prefab_name] ~= nil then
						local var_252_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_33.prefab_name].transform, "story_v_out_318301", "318301061", "story_v_out_318301.awb")

						arg_249_1:RecordAudio("318301061", var_252_39)
						arg_249_1:RecordAudio("318301061", var_252_39)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_318301", "318301061", "story_v_out_318301.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_318301", "318301061", "story_v_out_318301.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_40 = math.max(var_252_31, arg_249_1.talkMaxDuration)

			if var_252_30 <= arg_249_1.time_ and arg_249_1.time_ < var_252_30 + var_252_40 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_30) / var_252_40

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_30 + var_252_40 and arg_249_1.time_ < var_252_30 + var_252_40 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play318301062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 318301062
		arg_253_1.duration_ = 3.1

		local var_253_0 = {
			zh = 3.1,
			ja = 2.666
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
				arg_253_0:Play318301063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1093ui_story"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos1093ui_story = var_256_0.localPosition
			end

			local var_256_2 = 0.001

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2
				local var_256_4 = Vector3.New(0, -1.11, -5.88)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1093ui_story, var_256_4, var_256_3)

				local var_256_5 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_5.x, var_256_5.y, var_256_5.z)

				local var_256_6 = var_256_0.localEulerAngles

				var_256_6.z = 0
				var_256_6.x = 0
				var_256_0.localEulerAngles = var_256_6
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_256_7 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_7.x, var_256_7.y, var_256_7.z)

				local var_256_8 = var_256_0.localEulerAngles

				var_256_8.z = 0
				var_256_8.x = 0
				var_256_0.localEulerAngles = var_256_8
			end

			local var_256_9 = arg_253_1.actors_["1093ui_story"]
			local var_256_10 = 0

			if var_256_10 < arg_253_1.time_ and arg_253_1.time_ <= var_256_10 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect1093ui_story == nil then
				arg_253_1.var_.characterEffect1093ui_story = var_256_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_11 = 0.200000002980232

			if var_256_10 <= arg_253_1.time_ and arg_253_1.time_ < var_256_10 + var_256_11 and not isNil(var_256_9) then
				local var_256_12 = (arg_253_1.time_ - var_256_10) / var_256_11

				if arg_253_1.var_.characterEffect1093ui_story and not isNil(var_256_9) then
					arg_253_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_10 + var_256_11 and arg_253_1.time_ < var_256_10 + var_256_11 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect1093ui_story then
				arg_253_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_256_13 = 0

			if var_256_13 < arg_253_1.time_ and arg_253_1.time_ <= var_256_13 + arg_256_0 then
				arg_253_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action9_1")
			end

			local var_256_14 = 0

			if var_256_14 < arg_253_1.time_ and arg_253_1.time_ <= var_256_14 + arg_256_0 then
				arg_253_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_256_15 = arg_253_1.actors_["1150ui_story"].transform
			local var_256_16 = 0

			if var_256_16 < arg_253_1.time_ and arg_253_1.time_ <= var_256_16 + arg_256_0 then
				arg_253_1.var_.moveOldPos1150ui_story = var_256_15.localPosition
			end

			local var_256_17 = 0.001

			if var_256_16 <= arg_253_1.time_ and arg_253_1.time_ < var_256_16 + var_256_17 then
				local var_256_18 = (arg_253_1.time_ - var_256_16) / var_256_17
				local var_256_19 = Vector3.New(0, 100, 0)

				var_256_15.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1150ui_story, var_256_19, var_256_18)

				local var_256_20 = manager.ui.mainCamera.transform.position - var_256_15.position

				var_256_15.forward = Vector3.New(var_256_20.x, var_256_20.y, var_256_20.z)

				local var_256_21 = var_256_15.localEulerAngles

				var_256_21.z = 0
				var_256_21.x = 0
				var_256_15.localEulerAngles = var_256_21
			end

			if arg_253_1.time_ >= var_256_16 + var_256_17 and arg_253_1.time_ < var_256_16 + var_256_17 + arg_256_0 then
				var_256_15.localPosition = Vector3.New(0, 100, 0)

				local var_256_22 = manager.ui.mainCamera.transform.position - var_256_15.position

				var_256_15.forward = Vector3.New(var_256_22.x, var_256_22.y, var_256_22.z)

				local var_256_23 = var_256_15.localEulerAngles

				var_256_23.z = 0
				var_256_23.x = 0
				var_256_15.localEulerAngles = var_256_23
			end

			local var_256_24 = arg_253_1.actors_["1150ui_story"]
			local var_256_25 = 0

			if var_256_25 < arg_253_1.time_ and arg_253_1.time_ <= var_256_25 + arg_256_0 and not isNil(var_256_24) and arg_253_1.var_.characterEffect1150ui_story == nil then
				arg_253_1.var_.characterEffect1150ui_story = var_256_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_26 = 0.200000002980232

			if var_256_25 <= arg_253_1.time_ and arg_253_1.time_ < var_256_25 + var_256_26 and not isNil(var_256_24) then
				local var_256_27 = (arg_253_1.time_ - var_256_25) / var_256_26

				if arg_253_1.var_.characterEffect1150ui_story and not isNil(var_256_24) then
					local var_256_28 = Mathf.Lerp(0, 0.5, var_256_27)

					arg_253_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1150ui_story.fillRatio = var_256_28
				end
			end

			if arg_253_1.time_ >= var_256_25 + var_256_26 and arg_253_1.time_ < var_256_25 + var_256_26 + arg_256_0 and not isNil(var_256_24) and arg_253_1.var_.characterEffect1150ui_story then
				local var_256_29 = 0.5

				arg_253_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1150ui_story.fillRatio = var_256_29
			end

			local var_256_30 = 0
			local var_256_31 = 0.2

			if var_256_30 < arg_253_1.time_ and arg_253_1.time_ <= var_256_30 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_32 = arg_253_1:FormatText(StoryNameCfg[73].name)

				arg_253_1.leftNameTxt_.text = var_256_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_33 = arg_253_1:GetWordFromCfg(318301062)
				local var_256_34 = arg_253_1:FormatText(var_256_33.content)

				arg_253_1.text_.text = var_256_34

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_35 = 8
				local var_256_36 = utf8.len(var_256_34)
				local var_256_37 = var_256_35 <= 0 and var_256_31 or var_256_31 * (var_256_36 / var_256_35)

				if var_256_37 > 0 and var_256_31 < var_256_37 then
					arg_253_1.talkMaxDuration = var_256_37

					if var_256_37 + var_256_30 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_37 + var_256_30
					end
				end

				arg_253_1.text_.text = var_256_34
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301062", "story_v_out_318301.awb") ~= 0 then
					local var_256_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301062", "story_v_out_318301.awb") / 1000

					if var_256_38 + var_256_30 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_38 + var_256_30
					end

					if var_256_33.prefab_name ~= "" and arg_253_1.actors_[var_256_33.prefab_name] ~= nil then
						local var_256_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_33.prefab_name].transform, "story_v_out_318301", "318301062", "story_v_out_318301.awb")

						arg_253_1:RecordAudio("318301062", var_256_39)
						arg_253_1:RecordAudio("318301062", var_256_39)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_318301", "318301062", "story_v_out_318301.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_318301", "318301062", "story_v_out_318301.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_40 = math.max(var_256_31, arg_253_1.talkMaxDuration)

			if var_256_30 <= arg_253_1.time_ and arg_253_1.time_ < var_256_30 + var_256_40 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_30) / var_256_40

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_30 + var_256_40 and arg_253_1.time_ < var_256_30 + var_256_40 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play318301063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 318301063
		arg_257_1.duration_ = 9

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play318301064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = "K13g"

			if arg_257_1.bgs_[var_260_0] == nil then
				local var_260_1 = Object.Instantiate(arg_257_1.paintGo_)

				var_260_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_260_0)
				var_260_1.name = var_260_0
				var_260_1.transform.parent = arg_257_1.stage_.transform
				var_260_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.bgs_[var_260_0] = var_260_1
			end

			local var_260_2 = 2

			if var_260_2 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				local var_260_3 = manager.ui.mainCamera.transform.localPosition
				local var_260_4 = Vector3.New(0, 0, 10) + Vector3.New(var_260_3.x, var_260_3.y, 0)
				local var_260_5 = arg_257_1.bgs_.K13g

				var_260_5.transform.localPosition = var_260_4
				var_260_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_260_6 = var_260_5:GetComponent("SpriteRenderer")

				if var_260_6 and var_260_6.sprite then
					local var_260_7 = (var_260_5.transform.localPosition - var_260_3).z
					local var_260_8 = manager.ui.mainCameraCom_
					local var_260_9 = 2 * var_260_7 * Mathf.Tan(var_260_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_260_10 = var_260_9 * var_260_8.aspect
					local var_260_11 = var_260_6.sprite.bounds.size.x
					local var_260_12 = var_260_6.sprite.bounds.size.y
					local var_260_13 = var_260_10 / var_260_11
					local var_260_14 = var_260_9 / var_260_12
					local var_260_15 = var_260_14 < var_260_13 and var_260_13 or var_260_14

					var_260_5.transform.localScale = Vector3.New(var_260_15, var_260_15, 0)
				end

				for iter_260_0, iter_260_1 in pairs(arg_257_1.bgs_) do
					if iter_260_0 ~= "K13g" then
						iter_260_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_260_16 = 0

			if var_260_16 < arg_257_1.time_ and arg_257_1.time_ <= var_260_16 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_17 = 2

			if var_260_16 <= arg_257_1.time_ and arg_257_1.time_ < var_260_16 + var_260_17 then
				local var_260_18 = (arg_257_1.time_ - var_260_16) / var_260_17
				local var_260_19 = Color.New(0, 0, 0)

				var_260_19.a = Mathf.Lerp(0, 1, var_260_18)
				arg_257_1.mask_.color = var_260_19
			end

			if arg_257_1.time_ >= var_260_16 + var_260_17 and arg_257_1.time_ < var_260_16 + var_260_17 + arg_260_0 then
				local var_260_20 = Color.New(0, 0, 0)

				var_260_20.a = 1
				arg_257_1.mask_.color = var_260_20
			end

			local var_260_21 = 2

			if var_260_21 < arg_257_1.time_ and arg_257_1.time_ <= var_260_21 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_22 = 2

			if var_260_21 <= arg_257_1.time_ and arg_257_1.time_ < var_260_21 + var_260_22 then
				local var_260_23 = (arg_257_1.time_ - var_260_21) / var_260_22
				local var_260_24 = Color.New(0, 0, 0)

				var_260_24.a = Mathf.Lerp(1, 0, var_260_23)
				arg_257_1.mask_.color = var_260_24
			end

			if arg_257_1.time_ >= var_260_21 + var_260_22 and arg_257_1.time_ < var_260_21 + var_260_22 + arg_260_0 then
				local var_260_25 = Color.New(0, 0, 0)
				local var_260_26 = 0

				arg_257_1.mask_.enabled = false
				var_260_25.a = var_260_26
				arg_257_1.mask_.color = var_260_25
			end

			local var_260_27 = arg_257_1.actors_["1093ui_story"].transform
			local var_260_28 = 1.96599999815226

			if var_260_28 < arg_257_1.time_ and arg_257_1.time_ <= var_260_28 + arg_260_0 then
				arg_257_1.var_.moveOldPos1093ui_story = var_260_27.localPosition
			end

			local var_260_29 = 0.001

			if var_260_28 <= arg_257_1.time_ and arg_257_1.time_ < var_260_28 + var_260_29 then
				local var_260_30 = (arg_257_1.time_ - var_260_28) / var_260_29
				local var_260_31 = Vector3.New(0, 100, 0)

				var_260_27.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1093ui_story, var_260_31, var_260_30)

				local var_260_32 = manager.ui.mainCamera.transform.position - var_260_27.position

				var_260_27.forward = Vector3.New(var_260_32.x, var_260_32.y, var_260_32.z)

				local var_260_33 = var_260_27.localEulerAngles

				var_260_33.z = 0
				var_260_33.x = 0
				var_260_27.localEulerAngles = var_260_33
			end

			if arg_257_1.time_ >= var_260_28 + var_260_29 and arg_257_1.time_ < var_260_28 + var_260_29 + arg_260_0 then
				var_260_27.localPosition = Vector3.New(0, 100, 0)

				local var_260_34 = manager.ui.mainCamera.transform.position - var_260_27.position

				var_260_27.forward = Vector3.New(var_260_34.x, var_260_34.y, var_260_34.z)

				local var_260_35 = var_260_27.localEulerAngles

				var_260_35.z = 0
				var_260_35.x = 0
				var_260_27.localEulerAngles = var_260_35
			end

			local var_260_36 = arg_257_1.actors_["1093ui_story"]
			local var_260_37 = 1.96599999815226

			if var_260_37 < arg_257_1.time_ and arg_257_1.time_ <= var_260_37 + arg_260_0 and not isNil(var_260_36) and arg_257_1.var_.characterEffect1093ui_story == nil then
				arg_257_1.var_.characterEffect1093ui_story = var_260_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_38 = 0.034000001847744

			if var_260_37 <= arg_257_1.time_ and arg_257_1.time_ < var_260_37 + var_260_38 and not isNil(var_260_36) then
				local var_260_39 = (arg_257_1.time_ - var_260_37) / var_260_38

				if arg_257_1.var_.characterEffect1093ui_story and not isNil(var_260_36) then
					local var_260_40 = Mathf.Lerp(0, 0.5, var_260_39)

					arg_257_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1093ui_story.fillRatio = var_260_40
				end
			end

			if arg_257_1.time_ >= var_260_37 + var_260_38 and arg_257_1.time_ < var_260_37 + var_260_38 + arg_260_0 and not isNil(var_260_36) and arg_257_1.var_.characterEffect1093ui_story then
				local var_260_41 = 0.5

				arg_257_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1093ui_story.fillRatio = var_260_41
			end

			if arg_257_1.frameCnt_ <= 1 then
				arg_257_1.dialog_:SetActive(false)
			end

			local var_260_42 = 4
			local var_260_43 = 0.625

			if var_260_42 < arg_257_1.time_ and arg_257_1.time_ <= var_260_42 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0

				arg_257_1.dialog_:SetActive(true)

				arg_257_1.dialogCg_.alpha = 0

				local var_260_44 = LeanTween.value(arg_257_1.dialog_, 0, 1, 0.3)

				var_260_44:setOnUpdate(LuaHelper.FloatAction(function(arg_261_0)
					arg_257_1.dialogCg_.alpha = arg_261_0
				end))
				var_260_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_257_1.dialog_)
					var_260_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_257_1.duration_ = arg_257_1.duration_ + 0.3

				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_45 = arg_257_1:GetWordFromCfg(318301063)
				local var_260_46 = arg_257_1:FormatText(var_260_45.content)

				arg_257_1.text_.text = var_260_46

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_47 = 25
				local var_260_48 = utf8.len(var_260_46)
				local var_260_49 = var_260_47 <= 0 and var_260_43 or var_260_43 * (var_260_48 / var_260_47)

				if var_260_49 > 0 and var_260_43 < var_260_49 then
					arg_257_1.talkMaxDuration = var_260_49
					var_260_42 = var_260_42 + 0.3

					if var_260_49 + var_260_42 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_49 + var_260_42
					end
				end

				arg_257_1.text_.text = var_260_46
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_50 = var_260_42 + 0.3
			local var_260_51 = math.max(var_260_43, arg_257_1.talkMaxDuration)

			if var_260_50 <= arg_257_1.time_ and arg_257_1.time_ < var_260_50 + var_260_51 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_50) / var_260_51

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_50 + var_260_51 and arg_257_1.time_ < var_260_50 + var_260_51 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play318301064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 318301064
		arg_263_1.duration_ = 1.97

		local var_263_0 = {
			zh = 1.633,
			ja = 1.966
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play318301065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1093ui_story"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos1093ui_story = var_266_0.localPosition
			end

			local var_266_2 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2
				local var_266_4 = Vector3.New(0, -1.11, -5.88)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1093ui_story, var_266_4, var_266_3)

				local var_266_5 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_5.x, var_266_5.y, var_266_5.z)

				local var_266_6 = var_266_0.localEulerAngles

				var_266_6.z = 0
				var_266_6.x = 0
				var_266_0.localEulerAngles = var_266_6
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_266_7 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_7.x, var_266_7.y, var_266_7.z)

				local var_266_8 = var_266_0.localEulerAngles

				var_266_8.z = 0
				var_266_8.x = 0
				var_266_0.localEulerAngles = var_266_8
			end

			local var_266_9 = arg_263_1.actors_["1093ui_story"]
			local var_266_10 = 0

			if var_266_10 < arg_263_1.time_ and arg_263_1.time_ <= var_266_10 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect1093ui_story == nil then
				arg_263_1.var_.characterEffect1093ui_story = var_266_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_11 = 0.200000002980232

			if var_266_10 <= arg_263_1.time_ and arg_263_1.time_ < var_266_10 + var_266_11 and not isNil(var_266_9) then
				local var_266_12 = (arg_263_1.time_ - var_266_10) / var_266_11

				if arg_263_1.var_.characterEffect1093ui_story and not isNil(var_266_9) then
					arg_263_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_10 + var_266_11 and arg_263_1.time_ < var_266_10 + var_266_11 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect1093ui_story then
				arg_263_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_266_13 = 0

			if var_266_13 < arg_263_1.time_ and arg_263_1.time_ <= var_266_13 + arg_266_0 then
				arg_263_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_266_14 = 0

			if var_266_14 < arg_263_1.time_ and arg_263_1.time_ <= var_266_14 + arg_266_0 then
				arg_263_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_266_15 = 0
			local var_266_16 = 0.175

			if var_266_15 < arg_263_1.time_ and arg_263_1.time_ <= var_266_15 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_17 = arg_263_1:FormatText(StoryNameCfg[73].name)

				arg_263_1.leftNameTxt_.text = var_266_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_18 = arg_263_1:GetWordFromCfg(318301064)
				local var_266_19 = arg_263_1:FormatText(var_266_18.content)

				arg_263_1.text_.text = var_266_19

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_20 = 7
				local var_266_21 = utf8.len(var_266_19)
				local var_266_22 = var_266_20 <= 0 and var_266_16 or var_266_16 * (var_266_21 / var_266_20)

				if var_266_22 > 0 and var_266_16 < var_266_22 then
					arg_263_1.talkMaxDuration = var_266_22

					if var_266_22 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_22 + var_266_15
					end
				end

				arg_263_1.text_.text = var_266_19
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301064", "story_v_out_318301.awb") ~= 0 then
					local var_266_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301064", "story_v_out_318301.awb") / 1000

					if var_266_23 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_23 + var_266_15
					end

					if var_266_18.prefab_name ~= "" and arg_263_1.actors_[var_266_18.prefab_name] ~= nil then
						local var_266_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_18.prefab_name].transform, "story_v_out_318301", "318301064", "story_v_out_318301.awb")

						arg_263_1:RecordAudio("318301064", var_266_24)
						arg_263_1:RecordAudio("318301064", var_266_24)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_318301", "318301064", "story_v_out_318301.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_318301", "318301064", "story_v_out_318301.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_25 = math.max(var_266_16, arg_263_1.talkMaxDuration)

			if var_266_15 <= arg_263_1.time_ and arg_263_1.time_ < var_266_15 + var_266_25 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_15) / var_266_25

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_15 + var_266_25 and arg_263_1.time_ < var_266_15 + var_266_25 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play318301065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 318301065
		arg_267_1.duration_ = 5.1

		local var_267_0 = {
			zh = 4.3,
			ja = 5.1
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play318301066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 0.45

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_2 = arg_267_1:FormatText(StoryNameCfg[73].name)

				arg_267_1.leftNameTxt_.text = var_270_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_3 = arg_267_1:GetWordFromCfg(318301065)
				local var_270_4 = arg_267_1:FormatText(var_270_3.content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 18
				local var_270_6 = utf8.len(var_270_4)
				local var_270_7 = var_270_5 <= 0 and var_270_1 or var_270_1 * (var_270_6 / var_270_5)

				if var_270_7 > 0 and var_270_1 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_4
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301065", "story_v_out_318301.awb") ~= 0 then
					local var_270_8 = manager.audio:GetVoiceLength("story_v_out_318301", "318301065", "story_v_out_318301.awb") / 1000

					if var_270_8 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_8 + var_270_0
					end

					if var_270_3.prefab_name ~= "" and arg_267_1.actors_[var_270_3.prefab_name] ~= nil then
						local var_270_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_3.prefab_name].transform, "story_v_out_318301", "318301065", "story_v_out_318301.awb")

						arg_267_1:RecordAudio("318301065", var_270_9)
						arg_267_1:RecordAudio("318301065", var_270_9)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_318301", "318301065", "story_v_out_318301.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_318301", "318301065", "story_v_out_318301.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_10 and arg_267_1.time_ < var_270_0 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play318301066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 318301066
		arg_271_1.duration_ = 2.8

		local var_271_0 = {
			zh = 2.533,
			ja = 2.8
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play318301067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = "1015ui_story"

			if arg_271_1.actors_[var_274_0] == nil then
				local var_274_1 = Asset.Load("Char/" .. "1015ui_story")

				if not isNil(var_274_1) then
					local var_274_2 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_271_1.stage_.transform)

					var_274_2.name = var_274_0
					var_274_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_271_1.actors_[var_274_0] = var_274_2

					local var_274_3 = var_274_2:GetComponentInChildren(typeof(CharacterEffect))

					var_274_3.enabled = true

					local var_274_4 = GameObjectTools.GetOrAddComponent(var_274_2, typeof(DynamicBoneHelper))

					if var_274_4 then
						var_274_4:EnableDynamicBone(false)
					end

					arg_271_1:ShowWeapon(var_274_3.transform, false)

					arg_271_1.var_[var_274_0 .. "Animator"] = var_274_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_271_1.var_[var_274_0 .. "Animator"].applyRootMotion = true
					arg_271_1.var_[var_274_0 .. "LipSync"] = var_274_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_274_5 = arg_271_1.actors_["1015ui_story"].transform
			local var_274_6 = 0

			if var_274_6 < arg_271_1.time_ and arg_271_1.time_ <= var_274_6 + arg_274_0 then
				arg_271_1.var_.moveOldPos1015ui_story = var_274_5.localPosition
			end

			local var_274_7 = 0.001

			if var_274_6 <= arg_271_1.time_ and arg_271_1.time_ < var_274_6 + var_274_7 then
				local var_274_8 = (arg_271_1.time_ - var_274_6) / var_274_7
				local var_274_9 = Vector3.New(0, -1.15, -6.2)

				var_274_5.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1015ui_story, var_274_9, var_274_8)

				local var_274_10 = manager.ui.mainCamera.transform.position - var_274_5.position

				var_274_5.forward = Vector3.New(var_274_10.x, var_274_10.y, var_274_10.z)

				local var_274_11 = var_274_5.localEulerAngles

				var_274_11.z = 0
				var_274_11.x = 0
				var_274_5.localEulerAngles = var_274_11
			end

			if arg_271_1.time_ >= var_274_6 + var_274_7 and arg_271_1.time_ < var_274_6 + var_274_7 + arg_274_0 then
				var_274_5.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_274_12 = manager.ui.mainCamera.transform.position - var_274_5.position

				var_274_5.forward = Vector3.New(var_274_12.x, var_274_12.y, var_274_12.z)

				local var_274_13 = var_274_5.localEulerAngles

				var_274_13.z = 0
				var_274_13.x = 0
				var_274_5.localEulerAngles = var_274_13
			end

			local var_274_14 = arg_271_1.actors_["1015ui_story"]
			local var_274_15 = 0

			if var_274_15 < arg_271_1.time_ and arg_271_1.time_ <= var_274_15 + arg_274_0 and not isNil(var_274_14) and arg_271_1.var_.characterEffect1015ui_story == nil then
				arg_271_1.var_.characterEffect1015ui_story = var_274_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_16 = 0.200000002980232

			if var_274_15 <= arg_271_1.time_ and arg_271_1.time_ < var_274_15 + var_274_16 and not isNil(var_274_14) then
				local var_274_17 = (arg_271_1.time_ - var_274_15) / var_274_16

				if arg_271_1.var_.characterEffect1015ui_story and not isNil(var_274_14) then
					arg_271_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_15 + var_274_16 and arg_271_1.time_ < var_274_15 + var_274_16 + arg_274_0 and not isNil(var_274_14) and arg_271_1.var_.characterEffect1015ui_story then
				arg_271_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_274_18 = 0

			if var_274_18 < arg_271_1.time_ and arg_271_1.time_ <= var_274_18 + arg_274_0 then
				arg_271_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_274_19 = 0

			if var_274_19 < arg_271_1.time_ and arg_271_1.time_ <= var_274_19 + arg_274_0 then
				arg_271_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_274_20 = arg_271_1.actors_["1093ui_story"].transform
			local var_274_21 = 0

			if var_274_21 < arg_271_1.time_ and arg_271_1.time_ <= var_274_21 + arg_274_0 then
				arg_271_1.var_.moveOldPos1093ui_story = var_274_20.localPosition
			end

			local var_274_22 = 0.001

			if var_274_21 <= arg_271_1.time_ and arg_271_1.time_ < var_274_21 + var_274_22 then
				local var_274_23 = (arg_271_1.time_ - var_274_21) / var_274_22
				local var_274_24 = Vector3.New(0, 100, 0)

				var_274_20.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1093ui_story, var_274_24, var_274_23)

				local var_274_25 = manager.ui.mainCamera.transform.position - var_274_20.position

				var_274_20.forward = Vector3.New(var_274_25.x, var_274_25.y, var_274_25.z)

				local var_274_26 = var_274_20.localEulerAngles

				var_274_26.z = 0
				var_274_26.x = 0
				var_274_20.localEulerAngles = var_274_26
			end

			if arg_271_1.time_ >= var_274_21 + var_274_22 and arg_271_1.time_ < var_274_21 + var_274_22 + arg_274_0 then
				var_274_20.localPosition = Vector3.New(0, 100, 0)

				local var_274_27 = manager.ui.mainCamera.transform.position - var_274_20.position

				var_274_20.forward = Vector3.New(var_274_27.x, var_274_27.y, var_274_27.z)

				local var_274_28 = var_274_20.localEulerAngles

				var_274_28.z = 0
				var_274_28.x = 0
				var_274_20.localEulerAngles = var_274_28
			end

			local var_274_29 = arg_271_1.actors_["1093ui_story"]
			local var_274_30 = 0

			if var_274_30 < arg_271_1.time_ and arg_271_1.time_ <= var_274_30 + arg_274_0 and not isNil(var_274_29) and arg_271_1.var_.characterEffect1093ui_story == nil then
				arg_271_1.var_.characterEffect1093ui_story = var_274_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_31 = 0.200000002980232

			if var_274_30 <= arg_271_1.time_ and arg_271_1.time_ < var_274_30 + var_274_31 and not isNil(var_274_29) then
				local var_274_32 = (arg_271_1.time_ - var_274_30) / var_274_31

				if arg_271_1.var_.characterEffect1093ui_story and not isNil(var_274_29) then
					local var_274_33 = Mathf.Lerp(0, 0.5, var_274_32)

					arg_271_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1093ui_story.fillRatio = var_274_33
				end
			end

			if arg_271_1.time_ >= var_274_30 + var_274_31 and arg_271_1.time_ < var_274_30 + var_274_31 + arg_274_0 and not isNil(var_274_29) and arg_271_1.var_.characterEffect1093ui_story then
				local var_274_34 = 0.5

				arg_271_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1093ui_story.fillRatio = var_274_34
			end

			local var_274_35 = 0
			local var_274_36 = 0.375

			if var_274_35 < arg_271_1.time_ and arg_271_1.time_ <= var_274_35 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_37 = arg_271_1:FormatText(StoryNameCfg[479].name)

				arg_271_1.leftNameTxt_.text = var_274_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_38 = arg_271_1:GetWordFromCfg(318301066)
				local var_274_39 = arg_271_1:FormatText(var_274_38.content)

				arg_271_1.text_.text = var_274_39

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_40 = 15
				local var_274_41 = utf8.len(var_274_39)
				local var_274_42 = var_274_40 <= 0 and var_274_36 or var_274_36 * (var_274_41 / var_274_40)

				if var_274_42 > 0 and var_274_36 < var_274_42 then
					arg_271_1.talkMaxDuration = var_274_42

					if var_274_42 + var_274_35 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_42 + var_274_35
					end
				end

				arg_271_1.text_.text = var_274_39
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301066", "story_v_out_318301.awb") ~= 0 then
					local var_274_43 = manager.audio:GetVoiceLength("story_v_out_318301", "318301066", "story_v_out_318301.awb") / 1000

					if var_274_43 + var_274_35 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_43 + var_274_35
					end

					if var_274_38.prefab_name ~= "" and arg_271_1.actors_[var_274_38.prefab_name] ~= nil then
						local var_274_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_38.prefab_name].transform, "story_v_out_318301", "318301066", "story_v_out_318301.awb")

						arg_271_1:RecordAudio("318301066", var_274_44)
						arg_271_1:RecordAudio("318301066", var_274_44)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_318301", "318301066", "story_v_out_318301.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_318301", "318301066", "story_v_out_318301.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_45 = math.max(var_274_36, arg_271_1.talkMaxDuration)

			if var_274_35 <= arg_271_1.time_ and arg_271_1.time_ < var_274_35 + var_274_45 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_35) / var_274_45

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_35 + var_274_45 and arg_271_1.time_ < var_274_35 + var_274_45 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play318301067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 318301067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play318301068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1015ui_story"].transform
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.var_.moveOldPos1015ui_story = var_278_0.localPosition
			end

			local var_278_2 = 0.001

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2
				local var_278_4 = Vector3.New(0, 100, 0)

				var_278_0.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1015ui_story, var_278_4, var_278_3)

				local var_278_5 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_5.x, var_278_5.y, var_278_5.z)

				local var_278_6 = var_278_0.localEulerAngles

				var_278_6.z = 0
				var_278_6.x = 0
				var_278_0.localEulerAngles = var_278_6
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 then
				var_278_0.localPosition = Vector3.New(0, 100, 0)

				local var_278_7 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_7.x, var_278_7.y, var_278_7.z)

				local var_278_8 = var_278_0.localEulerAngles

				var_278_8.z = 0
				var_278_8.x = 0
				var_278_0.localEulerAngles = var_278_8
			end

			local var_278_9 = arg_275_1.actors_["1015ui_story"]
			local var_278_10 = 0

			if var_278_10 < arg_275_1.time_ and arg_275_1.time_ <= var_278_10 + arg_278_0 and not isNil(var_278_9) and arg_275_1.var_.characterEffect1015ui_story == nil then
				arg_275_1.var_.characterEffect1015ui_story = var_278_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_11 = 0.200000002980232

			if var_278_10 <= arg_275_1.time_ and arg_275_1.time_ < var_278_10 + var_278_11 and not isNil(var_278_9) then
				local var_278_12 = (arg_275_1.time_ - var_278_10) / var_278_11

				if arg_275_1.var_.characterEffect1015ui_story and not isNil(var_278_9) then
					local var_278_13 = Mathf.Lerp(0, 0.5, var_278_12)

					arg_275_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1015ui_story.fillRatio = var_278_13
				end
			end

			if arg_275_1.time_ >= var_278_10 + var_278_11 and arg_275_1.time_ < var_278_10 + var_278_11 + arg_278_0 and not isNil(var_278_9) and arg_275_1.var_.characterEffect1015ui_story then
				local var_278_14 = 0.5

				arg_275_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1015ui_story.fillRatio = var_278_14
			end

			local var_278_15 = 0
			local var_278_16 = 0.775

			if var_278_15 < arg_275_1.time_ and arg_275_1.time_ <= var_278_15 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_17 = arg_275_1:GetWordFromCfg(318301067)
				local var_278_18 = arg_275_1:FormatText(var_278_17.content)

				arg_275_1.text_.text = var_278_18

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_19 = 31
				local var_278_20 = utf8.len(var_278_18)
				local var_278_21 = var_278_19 <= 0 and var_278_16 or var_278_16 * (var_278_20 / var_278_19)

				if var_278_21 > 0 and var_278_16 < var_278_21 then
					arg_275_1.talkMaxDuration = var_278_21

					if var_278_21 + var_278_15 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_21 + var_278_15
					end
				end

				arg_275_1.text_.text = var_278_18
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_22 = math.max(var_278_16, arg_275_1.talkMaxDuration)

			if var_278_15 <= arg_275_1.time_ and arg_275_1.time_ < var_278_15 + var_278_22 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_15) / var_278_22

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_15 + var_278_22 and arg_275_1.time_ < var_278_15 + var_278_22 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play318301068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 318301068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play318301069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0
			local var_282_1 = 0.925

			if var_282_0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_2 = arg_279_1:GetWordFromCfg(318301068)
				local var_282_3 = arg_279_1:FormatText(var_282_2.content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_4 = 37
				local var_282_5 = utf8.len(var_282_3)
				local var_282_6 = var_282_4 <= 0 and var_282_1 or var_282_1 * (var_282_5 / var_282_4)

				if var_282_6 > 0 and var_282_1 < var_282_6 then
					arg_279_1.talkMaxDuration = var_282_6

					if var_282_6 + var_282_0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_6 + var_282_0
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_7 = math.max(var_282_1, arg_279_1.talkMaxDuration)

			if var_282_0 <= arg_279_1.time_ and arg_279_1.time_ < var_282_0 + var_282_7 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_0) / var_282_7

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_0 + var_282_7 and arg_279_1.time_ < var_282_0 + var_282_7 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play318301069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 318301069
		arg_283_1.duration_ = 3.9

		local var_283_0 = {
			zh = 3.9,
			ja = 3.066
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
				arg_283_0:Play318301070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = manager.ui.mainCamera.transform
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.var_.shakeOldPos = var_286_0.localPosition
			end

			local var_286_2 = 0.6

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / 0.066
				local var_286_4, var_286_5 = math.modf(var_286_3)

				var_286_0.localPosition = Vector3.New(var_286_5 * 0.13, var_286_5 * 0.13, var_286_5 * 0.13) + arg_283_1.var_.shakeOldPos
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 then
				var_286_0.localPosition = arg_283_1.var_.shakeOldPos
			end

			local var_286_6 = 0

			if var_286_6 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.allBtn_.enabled = false
			end

			local var_286_7 = 0.6

			if arg_283_1.time_ >= var_286_6 + var_286_7 and arg_283_1.time_ < var_286_6 + var_286_7 + arg_286_0 then
				arg_283_1.allBtn_.enabled = true
			end

			local var_286_8 = 0
			local var_286_9 = 0.175

			if var_286_8 < arg_283_1.time_ and arg_283_1.time_ <= var_286_8 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_10 = arg_283_1:FormatText(StoryNameCfg[479].name)

				arg_283_1.leftNameTxt_.text = var_286_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_11 = arg_283_1:GetWordFromCfg(318301069)
				local var_286_12 = arg_283_1:FormatText(var_286_11.content)

				arg_283_1.text_.text = var_286_12

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_13 = 7
				local var_286_14 = utf8.len(var_286_12)
				local var_286_15 = var_286_13 <= 0 and var_286_9 or var_286_9 * (var_286_14 / var_286_13)

				if var_286_15 > 0 and var_286_9 < var_286_15 then
					arg_283_1.talkMaxDuration = var_286_15

					if var_286_15 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_15 + var_286_8
					end
				end

				arg_283_1.text_.text = var_286_12
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301069", "story_v_out_318301.awb") ~= 0 then
					local var_286_16 = manager.audio:GetVoiceLength("story_v_out_318301", "318301069", "story_v_out_318301.awb") / 1000

					if var_286_16 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_16 + var_286_8
					end

					if var_286_11.prefab_name ~= "" and arg_283_1.actors_[var_286_11.prefab_name] ~= nil then
						local var_286_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_11.prefab_name].transform, "story_v_out_318301", "318301069", "story_v_out_318301.awb")

						arg_283_1:RecordAudio("318301069", var_286_17)
						arg_283_1:RecordAudio("318301069", var_286_17)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_318301", "318301069", "story_v_out_318301.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_318301", "318301069", "story_v_out_318301.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_18 = math.max(var_286_9, arg_283_1.talkMaxDuration)

			if var_286_8 <= arg_283_1.time_ and arg_283_1.time_ < var_286_8 + var_286_18 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_8) / var_286_18

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_8 + var_286_18 and arg_283_1.time_ < var_286_8 + var_286_18 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play318301070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 318301070
		arg_287_1.duration_ = 4.37

		local var_287_0 = {
			zh = 4.366,
			ja = 3.4
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
				arg_287_0:Play318301071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1093ui_story"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos1093ui_story = var_290_0.localPosition
			end

			local var_290_2 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2
				local var_290_4 = Vector3.New(0, -1.11, -5.88)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1093ui_story, var_290_4, var_290_3)

				local var_290_5 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_5.x, var_290_5.y, var_290_5.z)

				local var_290_6 = var_290_0.localEulerAngles

				var_290_6.z = 0
				var_290_6.x = 0
				var_290_0.localEulerAngles = var_290_6
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_290_7 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_7.x, var_290_7.y, var_290_7.z)

				local var_290_8 = var_290_0.localEulerAngles

				var_290_8.z = 0
				var_290_8.x = 0
				var_290_0.localEulerAngles = var_290_8
			end

			local var_290_9 = arg_287_1.actors_["1093ui_story"]
			local var_290_10 = 0

			if var_290_10 < arg_287_1.time_ and arg_287_1.time_ <= var_290_10 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect1093ui_story == nil then
				arg_287_1.var_.characterEffect1093ui_story = var_290_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_11 = 0.200000002980232

			if var_290_10 <= arg_287_1.time_ and arg_287_1.time_ < var_290_10 + var_290_11 and not isNil(var_290_9) then
				local var_290_12 = (arg_287_1.time_ - var_290_10) / var_290_11

				if arg_287_1.var_.characterEffect1093ui_story and not isNil(var_290_9) then
					arg_287_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_10 + var_290_11 and arg_287_1.time_ < var_290_10 + var_290_11 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect1093ui_story then
				arg_287_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_290_13 = 0

			if var_290_13 < arg_287_1.time_ and arg_287_1.time_ <= var_290_13 + arg_290_0 then
				arg_287_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_290_14 = 0

			if var_290_14 < arg_287_1.time_ and arg_287_1.time_ <= var_290_14 + arg_290_0 then
				arg_287_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_290_15 = arg_287_1.actors_["1015ui_story"].transform
			local var_290_16 = 0

			if var_290_16 < arg_287_1.time_ and arg_287_1.time_ <= var_290_16 + arg_290_0 then
				arg_287_1.var_.moveOldPos1015ui_story = var_290_15.localPosition
			end

			local var_290_17 = 0.001

			if var_290_16 <= arg_287_1.time_ and arg_287_1.time_ < var_290_16 + var_290_17 then
				local var_290_18 = (arg_287_1.time_ - var_290_16) / var_290_17
				local var_290_19 = Vector3.New(0, 100, 0)

				var_290_15.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1015ui_story, var_290_19, var_290_18)

				local var_290_20 = manager.ui.mainCamera.transform.position - var_290_15.position

				var_290_15.forward = Vector3.New(var_290_20.x, var_290_20.y, var_290_20.z)

				local var_290_21 = var_290_15.localEulerAngles

				var_290_21.z = 0
				var_290_21.x = 0
				var_290_15.localEulerAngles = var_290_21
			end

			if arg_287_1.time_ >= var_290_16 + var_290_17 and arg_287_1.time_ < var_290_16 + var_290_17 + arg_290_0 then
				var_290_15.localPosition = Vector3.New(0, 100, 0)

				local var_290_22 = manager.ui.mainCamera.transform.position - var_290_15.position

				var_290_15.forward = Vector3.New(var_290_22.x, var_290_22.y, var_290_22.z)

				local var_290_23 = var_290_15.localEulerAngles

				var_290_23.z = 0
				var_290_23.x = 0
				var_290_15.localEulerAngles = var_290_23
			end

			local var_290_24 = arg_287_1.actors_["1015ui_story"]
			local var_290_25 = 0

			if var_290_25 < arg_287_1.time_ and arg_287_1.time_ <= var_290_25 + arg_290_0 and not isNil(var_290_24) and arg_287_1.var_.characterEffect1015ui_story == nil then
				arg_287_1.var_.characterEffect1015ui_story = var_290_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_26 = 0.200000002980232

			if var_290_25 <= arg_287_1.time_ and arg_287_1.time_ < var_290_25 + var_290_26 and not isNil(var_290_24) then
				local var_290_27 = (arg_287_1.time_ - var_290_25) / var_290_26

				if arg_287_1.var_.characterEffect1015ui_story and not isNil(var_290_24) then
					local var_290_28 = Mathf.Lerp(0, 0.5, var_290_27)

					arg_287_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1015ui_story.fillRatio = var_290_28
				end
			end

			if arg_287_1.time_ >= var_290_25 + var_290_26 and arg_287_1.time_ < var_290_25 + var_290_26 + arg_290_0 and not isNil(var_290_24) and arg_287_1.var_.characterEffect1015ui_story then
				local var_290_29 = 0.5

				arg_287_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1015ui_story.fillRatio = var_290_29
			end

			local var_290_30 = 0
			local var_290_31 = 0.55

			if var_290_30 < arg_287_1.time_ and arg_287_1.time_ <= var_290_30 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_32 = arg_287_1:FormatText(StoryNameCfg[73].name)

				arg_287_1.leftNameTxt_.text = var_290_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_33 = arg_287_1:GetWordFromCfg(318301070)
				local var_290_34 = arg_287_1:FormatText(var_290_33.content)

				arg_287_1.text_.text = var_290_34

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_35 = 22
				local var_290_36 = utf8.len(var_290_34)
				local var_290_37 = var_290_35 <= 0 and var_290_31 or var_290_31 * (var_290_36 / var_290_35)

				if var_290_37 > 0 and var_290_31 < var_290_37 then
					arg_287_1.talkMaxDuration = var_290_37

					if var_290_37 + var_290_30 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_37 + var_290_30
					end
				end

				arg_287_1.text_.text = var_290_34
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301070", "story_v_out_318301.awb") ~= 0 then
					local var_290_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301070", "story_v_out_318301.awb") / 1000

					if var_290_38 + var_290_30 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_38 + var_290_30
					end

					if var_290_33.prefab_name ~= "" and arg_287_1.actors_[var_290_33.prefab_name] ~= nil then
						local var_290_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_33.prefab_name].transform, "story_v_out_318301", "318301070", "story_v_out_318301.awb")

						arg_287_1:RecordAudio("318301070", var_290_39)
						arg_287_1:RecordAudio("318301070", var_290_39)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_318301", "318301070", "story_v_out_318301.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_318301", "318301070", "story_v_out_318301.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_40 = math.max(var_290_31, arg_287_1.talkMaxDuration)

			if var_290_30 <= arg_287_1.time_ and arg_287_1.time_ < var_290_30 + var_290_40 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_30) / var_290_40

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_30 + var_290_40 and arg_287_1.time_ < var_290_30 + var_290_40 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play318301071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 318301071
		arg_291_1.duration_ = 5.23

		local var_291_0 = {
			zh = 3.266,
			ja = 5.233
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play318301072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0
			local var_294_1 = 0.375

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_2 = arg_291_1:FormatText(StoryNameCfg[73].name)

				arg_291_1.leftNameTxt_.text = var_294_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_3 = arg_291_1:GetWordFromCfg(318301071)
				local var_294_4 = arg_291_1:FormatText(var_294_3.content)

				arg_291_1.text_.text = var_294_4

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 15
				local var_294_6 = utf8.len(var_294_4)
				local var_294_7 = var_294_5 <= 0 and var_294_1 or var_294_1 * (var_294_6 / var_294_5)

				if var_294_7 > 0 and var_294_1 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_4
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301071", "story_v_out_318301.awb") ~= 0 then
					local var_294_8 = manager.audio:GetVoiceLength("story_v_out_318301", "318301071", "story_v_out_318301.awb") / 1000

					if var_294_8 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_0
					end

					if var_294_3.prefab_name ~= "" and arg_291_1.actors_[var_294_3.prefab_name] ~= nil then
						local var_294_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_3.prefab_name].transform, "story_v_out_318301", "318301071", "story_v_out_318301.awb")

						arg_291_1:RecordAudio("318301071", var_294_9)
						arg_291_1:RecordAudio("318301071", var_294_9)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_318301", "318301071", "story_v_out_318301.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_318301", "318301071", "story_v_out_318301.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_10 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_10 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_10

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_10 and arg_291_1.time_ < var_294_0 + var_294_10 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play318301072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 318301072
		arg_295_1.duration_ = 3

		local var_295_0 = {
			zh = 2.166,
			ja = 3
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play318301073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1015ui_story"].transform
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.var_.moveOldPos1015ui_story = var_298_0.localPosition
			end

			local var_298_2 = 0.001

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2
				local var_298_4 = Vector3.New(0, -1.15, -6.2)

				var_298_0.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1015ui_story, var_298_4, var_298_3)

				local var_298_5 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_5.x, var_298_5.y, var_298_5.z)

				local var_298_6 = var_298_0.localEulerAngles

				var_298_6.z = 0
				var_298_6.x = 0
				var_298_0.localEulerAngles = var_298_6
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 then
				var_298_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_298_7 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_7.x, var_298_7.y, var_298_7.z)

				local var_298_8 = var_298_0.localEulerAngles

				var_298_8.z = 0
				var_298_8.x = 0
				var_298_0.localEulerAngles = var_298_8
			end

			local var_298_9 = arg_295_1.actors_["1015ui_story"]
			local var_298_10 = 0

			if var_298_10 < arg_295_1.time_ and arg_295_1.time_ <= var_298_10 + arg_298_0 and not isNil(var_298_9) and arg_295_1.var_.characterEffect1015ui_story == nil then
				arg_295_1.var_.characterEffect1015ui_story = var_298_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_11 = 0.200000002980232

			if var_298_10 <= arg_295_1.time_ and arg_295_1.time_ < var_298_10 + var_298_11 and not isNil(var_298_9) then
				local var_298_12 = (arg_295_1.time_ - var_298_10) / var_298_11

				if arg_295_1.var_.characterEffect1015ui_story and not isNil(var_298_9) then
					arg_295_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= var_298_10 + var_298_11 and arg_295_1.time_ < var_298_10 + var_298_11 + arg_298_0 and not isNil(var_298_9) and arg_295_1.var_.characterEffect1015ui_story then
				arg_295_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_298_13 = 0

			if var_298_13 < arg_295_1.time_ and arg_295_1.time_ <= var_298_13 + arg_298_0 then
				arg_295_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_298_14 = 0

			if var_298_14 < arg_295_1.time_ and arg_295_1.time_ <= var_298_14 + arg_298_0 then
				arg_295_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_298_15 = arg_295_1.actors_["1093ui_story"].transform
			local var_298_16 = 0

			if var_298_16 < arg_295_1.time_ and arg_295_1.time_ <= var_298_16 + arg_298_0 then
				arg_295_1.var_.moveOldPos1093ui_story = var_298_15.localPosition
			end

			local var_298_17 = 0.001

			if var_298_16 <= arg_295_1.time_ and arg_295_1.time_ < var_298_16 + var_298_17 then
				local var_298_18 = (arg_295_1.time_ - var_298_16) / var_298_17
				local var_298_19 = Vector3.New(0, 100, 0)

				var_298_15.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1093ui_story, var_298_19, var_298_18)

				local var_298_20 = manager.ui.mainCamera.transform.position - var_298_15.position

				var_298_15.forward = Vector3.New(var_298_20.x, var_298_20.y, var_298_20.z)

				local var_298_21 = var_298_15.localEulerAngles

				var_298_21.z = 0
				var_298_21.x = 0
				var_298_15.localEulerAngles = var_298_21
			end

			if arg_295_1.time_ >= var_298_16 + var_298_17 and arg_295_1.time_ < var_298_16 + var_298_17 + arg_298_0 then
				var_298_15.localPosition = Vector3.New(0, 100, 0)

				local var_298_22 = manager.ui.mainCamera.transform.position - var_298_15.position

				var_298_15.forward = Vector3.New(var_298_22.x, var_298_22.y, var_298_22.z)

				local var_298_23 = var_298_15.localEulerAngles

				var_298_23.z = 0
				var_298_23.x = 0
				var_298_15.localEulerAngles = var_298_23
			end

			local var_298_24 = arg_295_1.actors_["1093ui_story"]
			local var_298_25 = 0

			if var_298_25 < arg_295_1.time_ and arg_295_1.time_ <= var_298_25 + arg_298_0 and not isNil(var_298_24) and arg_295_1.var_.characterEffect1093ui_story == nil then
				arg_295_1.var_.characterEffect1093ui_story = var_298_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_26 = 0.200000002980232

			if var_298_25 <= arg_295_1.time_ and arg_295_1.time_ < var_298_25 + var_298_26 and not isNil(var_298_24) then
				local var_298_27 = (arg_295_1.time_ - var_298_25) / var_298_26

				if arg_295_1.var_.characterEffect1093ui_story and not isNil(var_298_24) then
					local var_298_28 = Mathf.Lerp(0, 0.5, var_298_27)

					arg_295_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1093ui_story.fillRatio = var_298_28
				end
			end

			if arg_295_1.time_ >= var_298_25 + var_298_26 and arg_295_1.time_ < var_298_25 + var_298_26 + arg_298_0 and not isNil(var_298_24) and arg_295_1.var_.characterEffect1093ui_story then
				local var_298_29 = 0.5

				arg_295_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1093ui_story.fillRatio = var_298_29
			end

			local var_298_30 = 0
			local var_298_31 = 0.1

			if var_298_30 < arg_295_1.time_ and arg_295_1.time_ <= var_298_30 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_32 = arg_295_1:FormatText(StoryNameCfg[479].name)

				arg_295_1.leftNameTxt_.text = var_298_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_33 = arg_295_1:GetWordFromCfg(318301072)
				local var_298_34 = arg_295_1:FormatText(var_298_33.content)

				arg_295_1.text_.text = var_298_34

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_35 = 4
				local var_298_36 = utf8.len(var_298_34)
				local var_298_37 = var_298_35 <= 0 and var_298_31 or var_298_31 * (var_298_36 / var_298_35)

				if var_298_37 > 0 and var_298_31 < var_298_37 then
					arg_295_1.talkMaxDuration = var_298_37

					if var_298_37 + var_298_30 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_37 + var_298_30
					end
				end

				arg_295_1.text_.text = var_298_34
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301072", "story_v_out_318301.awb") ~= 0 then
					local var_298_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301072", "story_v_out_318301.awb") / 1000

					if var_298_38 + var_298_30 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_38 + var_298_30
					end

					if var_298_33.prefab_name ~= "" and arg_295_1.actors_[var_298_33.prefab_name] ~= nil then
						local var_298_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_33.prefab_name].transform, "story_v_out_318301", "318301072", "story_v_out_318301.awb")

						arg_295_1:RecordAudio("318301072", var_298_39)
						arg_295_1:RecordAudio("318301072", var_298_39)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_318301", "318301072", "story_v_out_318301.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_318301", "318301072", "story_v_out_318301.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_40 = math.max(var_298_31, arg_295_1.talkMaxDuration)

			if var_298_30 <= arg_295_1.time_ and arg_295_1.time_ < var_298_30 + var_298_40 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_30) / var_298_40

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_30 + var_298_40 and arg_295_1.time_ < var_298_30 + var_298_40 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play318301073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 318301073
		arg_299_1.duration_ = 3.13

		local var_299_0 = {
			zh = 3.133,
			ja = 2.1
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play318301074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0
			local var_302_1 = 0.325

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_2 = arg_299_1:FormatText(StoryNameCfg[479].name)

				arg_299_1.leftNameTxt_.text = var_302_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_3 = arg_299_1:GetWordFromCfg(318301073)
				local var_302_4 = arg_299_1:FormatText(var_302_3.content)

				arg_299_1.text_.text = var_302_4

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 13
				local var_302_6 = utf8.len(var_302_4)
				local var_302_7 = var_302_5 <= 0 and var_302_1 or var_302_1 * (var_302_6 / var_302_5)

				if var_302_7 > 0 and var_302_1 < var_302_7 then
					arg_299_1.talkMaxDuration = var_302_7

					if var_302_7 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_7 + var_302_0
					end
				end

				arg_299_1.text_.text = var_302_4
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301073", "story_v_out_318301.awb") ~= 0 then
					local var_302_8 = manager.audio:GetVoiceLength("story_v_out_318301", "318301073", "story_v_out_318301.awb") / 1000

					if var_302_8 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_8 + var_302_0
					end

					if var_302_3.prefab_name ~= "" and arg_299_1.actors_[var_302_3.prefab_name] ~= nil then
						local var_302_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_3.prefab_name].transform, "story_v_out_318301", "318301073", "story_v_out_318301.awb")

						arg_299_1:RecordAudio("318301073", var_302_9)
						arg_299_1:RecordAudio("318301073", var_302_9)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_318301", "318301073", "story_v_out_318301.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_318301", "318301073", "story_v_out_318301.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_10 = math.max(var_302_1, arg_299_1.talkMaxDuration)

			if var_302_0 <= arg_299_1.time_ and arg_299_1.time_ < var_302_0 + var_302_10 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_0) / var_302_10

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_0 + var_302_10 and arg_299_1.time_ < var_302_0 + var_302_10 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play318301074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 318301074
		arg_303_1.duration_ = 5.03

		local var_303_0 = {
			zh = 3.9,
			ja = 5.033
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play318301075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1093ui_story"].transform
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.var_.moveOldPos1093ui_story = var_306_0.localPosition
			end

			local var_306_2 = 0.001

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2
				local var_306_4 = Vector3.New(0, -1.11, -5.88)

				var_306_0.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1093ui_story, var_306_4, var_306_3)

				local var_306_5 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_5.x, var_306_5.y, var_306_5.z)

				local var_306_6 = var_306_0.localEulerAngles

				var_306_6.z = 0
				var_306_6.x = 0
				var_306_0.localEulerAngles = var_306_6
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 then
				var_306_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_306_7 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_7.x, var_306_7.y, var_306_7.z)

				local var_306_8 = var_306_0.localEulerAngles

				var_306_8.z = 0
				var_306_8.x = 0
				var_306_0.localEulerAngles = var_306_8
			end

			local var_306_9 = arg_303_1.actors_["1093ui_story"]
			local var_306_10 = 0

			if var_306_10 < arg_303_1.time_ and arg_303_1.time_ <= var_306_10 + arg_306_0 and not isNil(var_306_9) and arg_303_1.var_.characterEffect1093ui_story == nil then
				arg_303_1.var_.characterEffect1093ui_story = var_306_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_11 = 0.200000002980232

			if var_306_10 <= arg_303_1.time_ and arg_303_1.time_ < var_306_10 + var_306_11 and not isNil(var_306_9) then
				local var_306_12 = (arg_303_1.time_ - var_306_10) / var_306_11

				if arg_303_1.var_.characterEffect1093ui_story and not isNil(var_306_9) then
					arg_303_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= var_306_10 + var_306_11 and arg_303_1.time_ < var_306_10 + var_306_11 + arg_306_0 and not isNil(var_306_9) and arg_303_1.var_.characterEffect1093ui_story then
				arg_303_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_306_13 = 0

			if var_306_13 < arg_303_1.time_ and arg_303_1.time_ <= var_306_13 + arg_306_0 then
				arg_303_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			local var_306_14 = 0

			if var_306_14 < arg_303_1.time_ and arg_303_1.time_ <= var_306_14 + arg_306_0 then
				arg_303_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_306_15 = arg_303_1.actors_["1015ui_story"].transform
			local var_306_16 = 0

			if var_306_16 < arg_303_1.time_ and arg_303_1.time_ <= var_306_16 + arg_306_0 then
				arg_303_1.var_.moveOldPos1015ui_story = var_306_15.localPosition
			end

			local var_306_17 = 0.001

			if var_306_16 <= arg_303_1.time_ and arg_303_1.time_ < var_306_16 + var_306_17 then
				local var_306_18 = (arg_303_1.time_ - var_306_16) / var_306_17
				local var_306_19 = Vector3.New(0, 100, 0)

				var_306_15.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1015ui_story, var_306_19, var_306_18)

				local var_306_20 = manager.ui.mainCamera.transform.position - var_306_15.position

				var_306_15.forward = Vector3.New(var_306_20.x, var_306_20.y, var_306_20.z)

				local var_306_21 = var_306_15.localEulerAngles

				var_306_21.z = 0
				var_306_21.x = 0
				var_306_15.localEulerAngles = var_306_21
			end

			if arg_303_1.time_ >= var_306_16 + var_306_17 and arg_303_1.time_ < var_306_16 + var_306_17 + arg_306_0 then
				var_306_15.localPosition = Vector3.New(0, 100, 0)

				local var_306_22 = manager.ui.mainCamera.transform.position - var_306_15.position

				var_306_15.forward = Vector3.New(var_306_22.x, var_306_22.y, var_306_22.z)

				local var_306_23 = var_306_15.localEulerAngles

				var_306_23.z = 0
				var_306_23.x = 0
				var_306_15.localEulerAngles = var_306_23
			end

			local var_306_24 = arg_303_1.actors_["1015ui_story"]
			local var_306_25 = 0

			if var_306_25 < arg_303_1.time_ and arg_303_1.time_ <= var_306_25 + arg_306_0 and not isNil(var_306_24) and arg_303_1.var_.characterEffect1015ui_story == nil then
				arg_303_1.var_.characterEffect1015ui_story = var_306_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_26 = 0.200000002980232

			if var_306_25 <= arg_303_1.time_ and arg_303_1.time_ < var_306_25 + var_306_26 and not isNil(var_306_24) then
				local var_306_27 = (arg_303_1.time_ - var_306_25) / var_306_26

				if arg_303_1.var_.characterEffect1015ui_story and not isNil(var_306_24) then
					local var_306_28 = Mathf.Lerp(0, 0.5, var_306_27)

					arg_303_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1015ui_story.fillRatio = var_306_28
				end
			end

			if arg_303_1.time_ >= var_306_25 + var_306_26 and arg_303_1.time_ < var_306_25 + var_306_26 + arg_306_0 and not isNil(var_306_24) and arg_303_1.var_.characterEffect1015ui_story then
				local var_306_29 = 0.5

				arg_303_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1015ui_story.fillRatio = var_306_29
			end

			local var_306_30 = 0
			local var_306_31 = 0.45

			if var_306_30 < arg_303_1.time_ and arg_303_1.time_ <= var_306_30 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_32 = arg_303_1:FormatText(StoryNameCfg[73].name)

				arg_303_1.leftNameTxt_.text = var_306_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_33 = arg_303_1:GetWordFromCfg(318301074)
				local var_306_34 = arg_303_1:FormatText(var_306_33.content)

				arg_303_1.text_.text = var_306_34

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_35 = 18
				local var_306_36 = utf8.len(var_306_34)
				local var_306_37 = var_306_35 <= 0 and var_306_31 or var_306_31 * (var_306_36 / var_306_35)

				if var_306_37 > 0 and var_306_31 < var_306_37 then
					arg_303_1.talkMaxDuration = var_306_37

					if var_306_37 + var_306_30 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_37 + var_306_30
					end
				end

				arg_303_1.text_.text = var_306_34
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301074", "story_v_out_318301.awb") ~= 0 then
					local var_306_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301074", "story_v_out_318301.awb") / 1000

					if var_306_38 + var_306_30 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_38 + var_306_30
					end

					if var_306_33.prefab_name ~= "" and arg_303_1.actors_[var_306_33.prefab_name] ~= nil then
						local var_306_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_33.prefab_name].transform, "story_v_out_318301", "318301074", "story_v_out_318301.awb")

						arg_303_1:RecordAudio("318301074", var_306_39)
						arg_303_1:RecordAudio("318301074", var_306_39)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_318301", "318301074", "story_v_out_318301.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_318301", "318301074", "story_v_out_318301.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_40 = math.max(var_306_31, arg_303_1.talkMaxDuration)

			if var_306_30 <= arg_303_1.time_ and arg_303_1.time_ < var_306_30 + var_306_40 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_30) / var_306_40

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_30 + var_306_40 and arg_303_1.time_ < var_306_30 + var_306_40 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play318301075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 318301075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play318301076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1093ui_story"].transform
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.var_.moveOldPos1093ui_story = var_310_0.localPosition
			end

			local var_310_2 = 0.001

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2
				local var_310_4 = Vector3.New(0, 100, 0)

				var_310_0.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1093ui_story, var_310_4, var_310_3)

				local var_310_5 = manager.ui.mainCamera.transform.position - var_310_0.position

				var_310_0.forward = Vector3.New(var_310_5.x, var_310_5.y, var_310_5.z)

				local var_310_6 = var_310_0.localEulerAngles

				var_310_6.z = 0
				var_310_6.x = 0
				var_310_0.localEulerAngles = var_310_6
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 then
				var_310_0.localPosition = Vector3.New(0, 100, 0)

				local var_310_7 = manager.ui.mainCamera.transform.position - var_310_0.position

				var_310_0.forward = Vector3.New(var_310_7.x, var_310_7.y, var_310_7.z)

				local var_310_8 = var_310_0.localEulerAngles

				var_310_8.z = 0
				var_310_8.x = 0
				var_310_0.localEulerAngles = var_310_8
			end

			local var_310_9 = arg_307_1.actors_["1093ui_story"]
			local var_310_10 = 0

			if var_310_10 < arg_307_1.time_ and arg_307_1.time_ <= var_310_10 + arg_310_0 and not isNil(var_310_9) and arg_307_1.var_.characterEffect1093ui_story == nil then
				arg_307_1.var_.characterEffect1093ui_story = var_310_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_11 = 0.200000002980232

			if var_310_10 <= arg_307_1.time_ and arg_307_1.time_ < var_310_10 + var_310_11 and not isNil(var_310_9) then
				local var_310_12 = (arg_307_1.time_ - var_310_10) / var_310_11

				if arg_307_1.var_.characterEffect1093ui_story and not isNil(var_310_9) then
					local var_310_13 = Mathf.Lerp(0, 0.5, var_310_12)

					arg_307_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1093ui_story.fillRatio = var_310_13
				end
			end

			if arg_307_1.time_ >= var_310_10 + var_310_11 and arg_307_1.time_ < var_310_10 + var_310_11 + arg_310_0 and not isNil(var_310_9) and arg_307_1.var_.characterEffect1093ui_story then
				local var_310_14 = 0.5

				arg_307_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1093ui_story.fillRatio = var_310_14
			end

			local var_310_15 = 0
			local var_310_16 = 0.575

			if var_310_15 < arg_307_1.time_ and arg_307_1.time_ <= var_310_15 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_17 = arg_307_1:GetWordFromCfg(318301075)
				local var_310_18 = arg_307_1:FormatText(var_310_17.content)

				arg_307_1.text_.text = var_310_18

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_19 = 23
				local var_310_20 = utf8.len(var_310_18)
				local var_310_21 = var_310_19 <= 0 and var_310_16 or var_310_16 * (var_310_20 / var_310_19)

				if var_310_21 > 0 and var_310_16 < var_310_21 then
					arg_307_1.talkMaxDuration = var_310_21

					if var_310_21 + var_310_15 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_21 + var_310_15
					end
				end

				arg_307_1.text_.text = var_310_18
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_22 = math.max(var_310_16, arg_307_1.talkMaxDuration)

			if var_310_15 <= arg_307_1.time_ and arg_307_1.time_ < var_310_15 + var_310_22 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_15) / var_310_22

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_15 + var_310_22 and arg_307_1.time_ < var_310_15 + var_310_22 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play318301076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 318301076
		arg_311_1.duration_ = 5.27

		local var_311_0 = {
			zh = 5.266,
			ja = 5
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play318301077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1093ui_story"].transform
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.var_.moveOldPos1093ui_story = var_314_0.localPosition
			end

			local var_314_2 = 0.001

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2
				local var_314_4 = Vector3.New(0, -1.11, -5.88)

				var_314_0.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1093ui_story, var_314_4, var_314_3)

				local var_314_5 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_5.x, var_314_5.y, var_314_5.z)

				local var_314_6 = var_314_0.localEulerAngles

				var_314_6.z = 0
				var_314_6.x = 0
				var_314_0.localEulerAngles = var_314_6
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 then
				var_314_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_314_7 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_7.x, var_314_7.y, var_314_7.z)

				local var_314_8 = var_314_0.localEulerAngles

				var_314_8.z = 0
				var_314_8.x = 0
				var_314_0.localEulerAngles = var_314_8
			end

			local var_314_9 = arg_311_1.actors_["1093ui_story"]
			local var_314_10 = 0

			if var_314_10 < arg_311_1.time_ and arg_311_1.time_ <= var_314_10 + arg_314_0 and not isNil(var_314_9) and arg_311_1.var_.characterEffect1093ui_story == nil then
				arg_311_1.var_.characterEffect1093ui_story = var_314_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_11 = 0.200000002980232

			if var_314_10 <= arg_311_1.time_ and arg_311_1.time_ < var_314_10 + var_314_11 and not isNil(var_314_9) then
				local var_314_12 = (arg_311_1.time_ - var_314_10) / var_314_11

				if arg_311_1.var_.characterEffect1093ui_story and not isNil(var_314_9) then
					arg_311_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= var_314_10 + var_314_11 and arg_311_1.time_ < var_314_10 + var_314_11 + arg_314_0 and not isNil(var_314_9) and arg_311_1.var_.characterEffect1093ui_story then
				arg_311_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_314_13 = 0
			local var_314_14 = 0.6

			if var_314_13 < arg_311_1.time_ and arg_311_1.time_ <= var_314_13 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_15 = arg_311_1:FormatText(StoryNameCfg[73].name)

				arg_311_1.leftNameTxt_.text = var_314_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_16 = arg_311_1:GetWordFromCfg(318301076)
				local var_314_17 = arg_311_1:FormatText(var_314_16.content)

				arg_311_1.text_.text = var_314_17

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_18 = 24
				local var_314_19 = utf8.len(var_314_17)
				local var_314_20 = var_314_18 <= 0 and var_314_14 or var_314_14 * (var_314_19 / var_314_18)

				if var_314_20 > 0 and var_314_14 < var_314_20 then
					arg_311_1.talkMaxDuration = var_314_20

					if var_314_20 + var_314_13 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_20 + var_314_13
					end
				end

				arg_311_1.text_.text = var_314_17
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301076", "story_v_out_318301.awb") ~= 0 then
					local var_314_21 = manager.audio:GetVoiceLength("story_v_out_318301", "318301076", "story_v_out_318301.awb") / 1000

					if var_314_21 + var_314_13 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_21 + var_314_13
					end

					if var_314_16.prefab_name ~= "" and arg_311_1.actors_[var_314_16.prefab_name] ~= nil then
						local var_314_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_16.prefab_name].transform, "story_v_out_318301", "318301076", "story_v_out_318301.awb")

						arg_311_1:RecordAudio("318301076", var_314_22)
						arg_311_1:RecordAudio("318301076", var_314_22)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_318301", "318301076", "story_v_out_318301.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_318301", "318301076", "story_v_out_318301.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_23 = math.max(var_314_14, arg_311_1.talkMaxDuration)

			if var_314_13 <= arg_311_1.time_ and arg_311_1.time_ < var_314_13 + var_314_23 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_13) / var_314_23

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_13 + var_314_23 and arg_311_1.time_ < var_314_13 + var_314_23 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play318301077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 318301077
		arg_315_1.duration_ = 4.77

		local var_315_0 = {
			zh = 4.766,
			ja = 2.966
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play318301078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0
			local var_318_1 = 0.55

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_2 = arg_315_1:FormatText(StoryNameCfg[73].name)

				arg_315_1.leftNameTxt_.text = var_318_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_3 = arg_315_1:GetWordFromCfg(318301077)
				local var_318_4 = arg_315_1:FormatText(var_318_3.content)

				arg_315_1.text_.text = var_318_4

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 22
				local var_318_6 = utf8.len(var_318_4)
				local var_318_7 = var_318_5 <= 0 and var_318_1 or var_318_1 * (var_318_6 / var_318_5)

				if var_318_7 > 0 and var_318_1 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_0
					end
				end

				arg_315_1.text_.text = var_318_4
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301077", "story_v_out_318301.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_out_318301", "318301077", "story_v_out_318301.awb") / 1000

					if var_318_8 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_0
					end

					if var_318_3.prefab_name ~= "" and arg_315_1.actors_[var_318_3.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_3.prefab_name].transform, "story_v_out_318301", "318301077", "story_v_out_318301.awb")

						arg_315_1:RecordAudio("318301077", var_318_9)
						arg_315_1:RecordAudio("318301077", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_318301", "318301077", "story_v_out_318301.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_318301", "318301077", "story_v_out_318301.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_10 = math.max(var_318_1, arg_315_1.talkMaxDuration)

			if var_318_0 <= arg_315_1.time_ and arg_315_1.time_ < var_318_0 + var_318_10 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_0) / var_318_10

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_0 + var_318_10 and arg_315_1.time_ < var_318_0 + var_318_10 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play318301078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 318301078
		arg_319_1.duration_ = 4.2

		local var_319_0 = {
			zh = 2.4,
			ja = 4.2
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play318301079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0

			if var_322_0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				arg_319_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_322_1 = 0
			local var_322_2 = 0.275

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_3 = arg_319_1:FormatText(StoryNameCfg[73].name)

				arg_319_1.leftNameTxt_.text = var_322_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_4 = arg_319_1:GetWordFromCfg(318301078)
				local var_322_5 = arg_319_1:FormatText(var_322_4.content)

				arg_319_1.text_.text = var_322_5

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_6 = 11
				local var_322_7 = utf8.len(var_322_5)
				local var_322_8 = var_322_6 <= 0 and var_322_2 or var_322_2 * (var_322_7 / var_322_6)

				if var_322_8 > 0 and var_322_2 < var_322_8 then
					arg_319_1.talkMaxDuration = var_322_8

					if var_322_8 + var_322_1 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_8 + var_322_1
					end
				end

				arg_319_1.text_.text = var_322_5
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301078", "story_v_out_318301.awb") ~= 0 then
					local var_322_9 = manager.audio:GetVoiceLength("story_v_out_318301", "318301078", "story_v_out_318301.awb") / 1000

					if var_322_9 + var_322_1 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_9 + var_322_1
					end

					if var_322_4.prefab_name ~= "" and arg_319_1.actors_[var_322_4.prefab_name] ~= nil then
						local var_322_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_4.prefab_name].transform, "story_v_out_318301", "318301078", "story_v_out_318301.awb")

						arg_319_1:RecordAudio("318301078", var_322_10)
						arg_319_1:RecordAudio("318301078", var_322_10)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_318301", "318301078", "story_v_out_318301.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_318301", "318301078", "story_v_out_318301.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_11 = math.max(var_322_2, arg_319_1.talkMaxDuration)

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_11 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_1) / var_322_11

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_1 + var_322_11 and arg_319_1.time_ < var_322_1 + var_322_11 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play318301079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 318301079
		arg_323_1.duration_ = 5.7

		local var_323_0 = {
			zh = 5.7,
			ja = 4.7
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play318301080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1015ui_story"].transform
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.var_.moveOldPos1015ui_story = var_326_0.localPosition
			end

			local var_326_2 = 0.001

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2
				local var_326_4 = Vector3.New(0, -1.15, -6.2)

				var_326_0.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1015ui_story, var_326_4, var_326_3)

				local var_326_5 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_5.x, var_326_5.y, var_326_5.z)

				local var_326_6 = var_326_0.localEulerAngles

				var_326_6.z = 0
				var_326_6.x = 0
				var_326_0.localEulerAngles = var_326_6
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 then
				var_326_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_326_7 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_7.x, var_326_7.y, var_326_7.z)

				local var_326_8 = var_326_0.localEulerAngles

				var_326_8.z = 0
				var_326_8.x = 0
				var_326_0.localEulerAngles = var_326_8
			end

			local var_326_9 = arg_323_1.actors_["1015ui_story"]
			local var_326_10 = 0

			if var_326_10 < arg_323_1.time_ and arg_323_1.time_ <= var_326_10 + arg_326_0 and not isNil(var_326_9) and arg_323_1.var_.characterEffect1015ui_story == nil then
				arg_323_1.var_.characterEffect1015ui_story = var_326_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_11 = 0.200000002980232

			if var_326_10 <= arg_323_1.time_ and arg_323_1.time_ < var_326_10 + var_326_11 and not isNil(var_326_9) then
				local var_326_12 = (arg_323_1.time_ - var_326_10) / var_326_11

				if arg_323_1.var_.characterEffect1015ui_story and not isNil(var_326_9) then
					arg_323_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_10 + var_326_11 and arg_323_1.time_ < var_326_10 + var_326_11 + arg_326_0 and not isNil(var_326_9) and arg_323_1.var_.characterEffect1015ui_story then
				arg_323_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_326_13 = 0

			if var_326_13 < arg_323_1.time_ and arg_323_1.time_ <= var_326_13 + arg_326_0 then
				arg_323_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_326_14 = 0

			if var_326_14 < arg_323_1.time_ and arg_323_1.time_ <= var_326_14 + arg_326_0 then
				arg_323_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_326_15 = arg_323_1.actors_["1093ui_story"].transform
			local var_326_16 = 0

			if var_326_16 < arg_323_1.time_ and arg_323_1.time_ <= var_326_16 + arg_326_0 then
				arg_323_1.var_.moveOldPos1093ui_story = var_326_15.localPosition
			end

			local var_326_17 = 0.001

			if var_326_16 <= arg_323_1.time_ and arg_323_1.time_ < var_326_16 + var_326_17 then
				local var_326_18 = (arg_323_1.time_ - var_326_16) / var_326_17
				local var_326_19 = Vector3.New(0, 100, 0)

				var_326_15.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1093ui_story, var_326_19, var_326_18)

				local var_326_20 = manager.ui.mainCamera.transform.position - var_326_15.position

				var_326_15.forward = Vector3.New(var_326_20.x, var_326_20.y, var_326_20.z)

				local var_326_21 = var_326_15.localEulerAngles

				var_326_21.z = 0
				var_326_21.x = 0
				var_326_15.localEulerAngles = var_326_21
			end

			if arg_323_1.time_ >= var_326_16 + var_326_17 and arg_323_1.time_ < var_326_16 + var_326_17 + arg_326_0 then
				var_326_15.localPosition = Vector3.New(0, 100, 0)

				local var_326_22 = manager.ui.mainCamera.transform.position - var_326_15.position

				var_326_15.forward = Vector3.New(var_326_22.x, var_326_22.y, var_326_22.z)

				local var_326_23 = var_326_15.localEulerAngles

				var_326_23.z = 0
				var_326_23.x = 0
				var_326_15.localEulerAngles = var_326_23
			end

			local var_326_24 = arg_323_1.actors_["1093ui_story"]
			local var_326_25 = 0

			if var_326_25 < arg_323_1.time_ and arg_323_1.time_ <= var_326_25 + arg_326_0 and not isNil(var_326_24) and arg_323_1.var_.characterEffect1093ui_story == nil then
				arg_323_1.var_.characterEffect1093ui_story = var_326_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_26 = 0.200000002980232

			if var_326_25 <= arg_323_1.time_ and arg_323_1.time_ < var_326_25 + var_326_26 and not isNil(var_326_24) then
				local var_326_27 = (arg_323_1.time_ - var_326_25) / var_326_26

				if arg_323_1.var_.characterEffect1093ui_story and not isNil(var_326_24) then
					local var_326_28 = Mathf.Lerp(0, 0.5, var_326_27)

					arg_323_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1093ui_story.fillRatio = var_326_28
				end
			end

			if arg_323_1.time_ >= var_326_25 + var_326_26 and arg_323_1.time_ < var_326_25 + var_326_26 + arg_326_0 and not isNil(var_326_24) and arg_323_1.var_.characterEffect1093ui_story then
				local var_326_29 = 0.5

				arg_323_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1093ui_story.fillRatio = var_326_29
			end

			local var_326_30 = 0
			local var_326_31 = 0.525

			if var_326_30 < arg_323_1.time_ and arg_323_1.time_ <= var_326_30 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_32 = arg_323_1:FormatText(StoryNameCfg[479].name)

				arg_323_1.leftNameTxt_.text = var_326_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_33 = arg_323_1:GetWordFromCfg(318301079)
				local var_326_34 = arg_323_1:FormatText(var_326_33.content)

				arg_323_1.text_.text = var_326_34

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_35 = 21
				local var_326_36 = utf8.len(var_326_34)
				local var_326_37 = var_326_35 <= 0 and var_326_31 or var_326_31 * (var_326_36 / var_326_35)

				if var_326_37 > 0 and var_326_31 < var_326_37 then
					arg_323_1.talkMaxDuration = var_326_37

					if var_326_37 + var_326_30 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_37 + var_326_30
					end
				end

				arg_323_1.text_.text = var_326_34
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301079", "story_v_out_318301.awb") ~= 0 then
					local var_326_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301079", "story_v_out_318301.awb") / 1000

					if var_326_38 + var_326_30 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_38 + var_326_30
					end

					if var_326_33.prefab_name ~= "" and arg_323_1.actors_[var_326_33.prefab_name] ~= nil then
						local var_326_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_33.prefab_name].transform, "story_v_out_318301", "318301079", "story_v_out_318301.awb")

						arg_323_1:RecordAudio("318301079", var_326_39)
						arg_323_1:RecordAudio("318301079", var_326_39)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_318301", "318301079", "story_v_out_318301.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_318301", "318301079", "story_v_out_318301.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_40 = math.max(var_326_31, arg_323_1.talkMaxDuration)

			if var_326_30 <= arg_323_1.time_ and arg_323_1.time_ < var_326_30 + var_326_40 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_30) / var_326_40

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_30 + var_326_40 and arg_323_1.time_ < var_326_30 + var_326_40 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play318301080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 318301080
		arg_327_1.duration_ = 6

		local var_327_0 = {
			zh = 4.3,
			ja = 6
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play318301081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1093ui_story"].transform
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.var_.moveOldPos1093ui_story = var_330_0.localPosition
			end

			local var_330_2 = 0.001

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2
				local var_330_4 = Vector3.New(0, -1.11, -5.88)

				var_330_0.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1093ui_story, var_330_4, var_330_3)

				local var_330_5 = manager.ui.mainCamera.transform.position - var_330_0.position

				var_330_0.forward = Vector3.New(var_330_5.x, var_330_5.y, var_330_5.z)

				local var_330_6 = var_330_0.localEulerAngles

				var_330_6.z = 0
				var_330_6.x = 0
				var_330_0.localEulerAngles = var_330_6
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 then
				var_330_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_330_7 = manager.ui.mainCamera.transform.position - var_330_0.position

				var_330_0.forward = Vector3.New(var_330_7.x, var_330_7.y, var_330_7.z)

				local var_330_8 = var_330_0.localEulerAngles

				var_330_8.z = 0
				var_330_8.x = 0
				var_330_0.localEulerAngles = var_330_8
			end

			local var_330_9 = arg_327_1.actors_["1093ui_story"]
			local var_330_10 = 0

			if var_330_10 < arg_327_1.time_ and arg_327_1.time_ <= var_330_10 + arg_330_0 and not isNil(var_330_9) and arg_327_1.var_.characterEffect1093ui_story == nil then
				arg_327_1.var_.characterEffect1093ui_story = var_330_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_11 = 0.200000002980232

			if var_330_10 <= arg_327_1.time_ and arg_327_1.time_ < var_330_10 + var_330_11 and not isNil(var_330_9) then
				local var_330_12 = (arg_327_1.time_ - var_330_10) / var_330_11

				if arg_327_1.var_.characterEffect1093ui_story and not isNil(var_330_9) then
					arg_327_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= var_330_10 + var_330_11 and arg_327_1.time_ < var_330_10 + var_330_11 + arg_330_0 and not isNil(var_330_9) and arg_327_1.var_.characterEffect1093ui_story then
				arg_327_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_330_13 = 0

			if var_330_13 < arg_327_1.time_ and arg_327_1.time_ <= var_330_13 + arg_330_0 then
				arg_327_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_330_14 = 0

			if var_330_14 < arg_327_1.time_ and arg_327_1.time_ <= var_330_14 + arg_330_0 then
				arg_327_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_330_15 = arg_327_1.actors_["1015ui_story"].transform
			local var_330_16 = 0

			if var_330_16 < arg_327_1.time_ and arg_327_1.time_ <= var_330_16 + arg_330_0 then
				arg_327_1.var_.moveOldPos1015ui_story = var_330_15.localPosition
			end

			local var_330_17 = 0.001

			if var_330_16 <= arg_327_1.time_ and arg_327_1.time_ < var_330_16 + var_330_17 then
				local var_330_18 = (arg_327_1.time_ - var_330_16) / var_330_17
				local var_330_19 = Vector3.New(0, 100, 0)

				var_330_15.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1015ui_story, var_330_19, var_330_18)

				local var_330_20 = manager.ui.mainCamera.transform.position - var_330_15.position

				var_330_15.forward = Vector3.New(var_330_20.x, var_330_20.y, var_330_20.z)

				local var_330_21 = var_330_15.localEulerAngles

				var_330_21.z = 0
				var_330_21.x = 0
				var_330_15.localEulerAngles = var_330_21
			end

			if arg_327_1.time_ >= var_330_16 + var_330_17 and arg_327_1.time_ < var_330_16 + var_330_17 + arg_330_0 then
				var_330_15.localPosition = Vector3.New(0, 100, 0)

				local var_330_22 = manager.ui.mainCamera.transform.position - var_330_15.position

				var_330_15.forward = Vector3.New(var_330_22.x, var_330_22.y, var_330_22.z)

				local var_330_23 = var_330_15.localEulerAngles

				var_330_23.z = 0
				var_330_23.x = 0
				var_330_15.localEulerAngles = var_330_23
			end

			local var_330_24 = arg_327_1.actors_["1015ui_story"]
			local var_330_25 = 0

			if var_330_25 < arg_327_1.time_ and arg_327_1.time_ <= var_330_25 + arg_330_0 and not isNil(var_330_24) and arg_327_1.var_.characterEffect1015ui_story == nil then
				arg_327_1.var_.characterEffect1015ui_story = var_330_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_26 = 0.200000002980232

			if var_330_25 <= arg_327_1.time_ and arg_327_1.time_ < var_330_25 + var_330_26 and not isNil(var_330_24) then
				local var_330_27 = (arg_327_1.time_ - var_330_25) / var_330_26

				if arg_327_1.var_.characterEffect1015ui_story and not isNil(var_330_24) then
					local var_330_28 = Mathf.Lerp(0, 0.5, var_330_27)

					arg_327_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1015ui_story.fillRatio = var_330_28
				end
			end

			if arg_327_1.time_ >= var_330_25 + var_330_26 and arg_327_1.time_ < var_330_25 + var_330_26 + arg_330_0 and not isNil(var_330_24) and arg_327_1.var_.characterEffect1015ui_story then
				local var_330_29 = 0.5

				arg_327_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1015ui_story.fillRatio = var_330_29
			end

			local var_330_30 = 0
			local var_330_31 = 0.475

			if var_330_30 < arg_327_1.time_ and arg_327_1.time_ <= var_330_30 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_32 = arg_327_1:FormatText(StoryNameCfg[73].name)

				arg_327_1.leftNameTxt_.text = var_330_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_33 = arg_327_1:GetWordFromCfg(318301080)
				local var_330_34 = arg_327_1:FormatText(var_330_33.content)

				arg_327_1.text_.text = var_330_34

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_35 = 19
				local var_330_36 = utf8.len(var_330_34)
				local var_330_37 = var_330_35 <= 0 and var_330_31 or var_330_31 * (var_330_36 / var_330_35)

				if var_330_37 > 0 and var_330_31 < var_330_37 then
					arg_327_1.talkMaxDuration = var_330_37

					if var_330_37 + var_330_30 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_37 + var_330_30
					end
				end

				arg_327_1.text_.text = var_330_34
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301080", "story_v_out_318301.awb") ~= 0 then
					local var_330_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301080", "story_v_out_318301.awb") / 1000

					if var_330_38 + var_330_30 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_38 + var_330_30
					end

					if var_330_33.prefab_name ~= "" and arg_327_1.actors_[var_330_33.prefab_name] ~= nil then
						local var_330_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_33.prefab_name].transform, "story_v_out_318301", "318301080", "story_v_out_318301.awb")

						arg_327_1:RecordAudio("318301080", var_330_39)
						arg_327_1:RecordAudio("318301080", var_330_39)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_318301", "318301080", "story_v_out_318301.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_318301", "318301080", "story_v_out_318301.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_40 = math.max(var_330_31, arg_327_1.talkMaxDuration)

			if var_330_30 <= arg_327_1.time_ and arg_327_1.time_ < var_330_30 + var_330_40 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_30) / var_330_40

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_30 + var_330_40 and arg_327_1.time_ < var_330_30 + var_330_40 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play318301081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 318301081
		arg_331_1.duration_ = 9

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play318301082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = "ST06"

			if arg_331_1.bgs_[var_334_0] == nil then
				local var_334_1 = Object.Instantiate(arg_331_1.paintGo_)

				var_334_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_334_0)
				var_334_1.name = var_334_0
				var_334_1.transform.parent = arg_331_1.stage_.transform
				var_334_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_331_1.bgs_[var_334_0] = var_334_1
			end

			local var_334_2 = 2

			if var_334_2 < arg_331_1.time_ and arg_331_1.time_ <= var_334_2 + arg_334_0 then
				local var_334_3 = manager.ui.mainCamera.transform.localPosition
				local var_334_4 = Vector3.New(0, 0, 10) + Vector3.New(var_334_3.x, var_334_3.y, 0)
				local var_334_5 = arg_331_1.bgs_.ST06

				var_334_5.transform.localPosition = var_334_4
				var_334_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_334_6 = var_334_5:GetComponent("SpriteRenderer")

				if var_334_6 and var_334_6.sprite then
					local var_334_7 = (var_334_5.transform.localPosition - var_334_3).z
					local var_334_8 = manager.ui.mainCameraCom_
					local var_334_9 = 2 * var_334_7 * Mathf.Tan(var_334_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_334_10 = var_334_9 * var_334_8.aspect
					local var_334_11 = var_334_6.sprite.bounds.size.x
					local var_334_12 = var_334_6.sprite.bounds.size.y
					local var_334_13 = var_334_10 / var_334_11
					local var_334_14 = var_334_9 / var_334_12
					local var_334_15 = var_334_14 < var_334_13 and var_334_13 or var_334_14

					var_334_5.transform.localScale = Vector3.New(var_334_15, var_334_15, 0)
				end

				for iter_334_0, iter_334_1 in pairs(arg_331_1.bgs_) do
					if iter_334_0 ~= "ST06" then
						iter_334_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_334_16 = 0

			if var_334_16 < arg_331_1.time_ and arg_331_1.time_ <= var_334_16 + arg_334_0 then
				arg_331_1.mask_.enabled = true
				arg_331_1.mask_.raycastTarget = true

				arg_331_1:SetGaussion(false)
			end

			local var_334_17 = 2

			if var_334_16 <= arg_331_1.time_ and arg_331_1.time_ < var_334_16 + var_334_17 then
				local var_334_18 = (arg_331_1.time_ - var_334_16) / var_334_17
				local var_334_19 = Color.New(0, 0, 0)

				var_334_19.a = Mathf.Lerp(0, 1, var_334_18)
				arg_331_1.mask_.color = var_334_19
			end

			if arg_331_1.time_ >= var_334_16 + var_334_17 and arg_331_1.time_ < var_334_16 + var_334_17 + arg_334_0 then
				local var_334_20 = Color.New(0, 0, 0)

				var_334_20.a = 1
				arg_331_1.mask_.color = var_334_20
			end

			local var_334_21 = 2

			if var_334_21 < arg_331_1.time_ and arg_331_1.time_ <= var_334_21 + arg_334_0 then
				arg_331_1.mask_.enabled = true
				arg_331_1.mask_.raycastTarget = true

				arg_331_1:SetGaussion(false)
			end

			local var_334_22 = 2

			if var_334_21 <= arg_331_1.time_ and arg_331_1.time_ < var_334_21 + var_334_22 then
				local var_334_23 = (arg_331_1.time_ - var_334_21) / var_334_22
				local var_334_24 = Color.New(0, 0, 0)

				var_334_24.a = Mathf.Lerp(1, 0, var_334_23)
				arg_331_1.mask_.color = var_334_24
			end

			if arg_331_1.time_ >= var_334_21 + var_334_22 and arg_331_1.time_ < var_334_21 + var_334_22 + arg_334_0 then
				local var_334_25 = Color.New(0, 0, 0)
				local var_334_26 = 0

				arg_331_1.mask_.enabled = false
				var_334_25.a = var_334_26
				arg_331_1.mask_.color = var_334_25
			end

			local var_334_27 = arg_331_1.actors_["1093ui_story"].transform
			local var_334_28 = 1.96599999815226

			if var_334_28 < arg_331_1.time_ and arg_331_1.time_ <= var_334_28 + arg_334_0 then
				arg_331_1.var_.moveOldPos1093ui_story = var_334_27.localPosition
			end

			local var_334_29 = 0.001

			if var_334_28 <= arg_331_1.time_ and arg_331_1.time_ < var_334_28 + var_334_29 then
				local var_334_30 = (arg_331_1.time_ - var_334_28) / var_334_29
				local var_334_31 = Vector3.New(0, 100, 0)

				var_334_27.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1093ui_story, var_334_31, var_334_30)

				local var_334_32 = manager.ui.mainCamera.transform.position - var_334_27.position

				var_334_27.forward = Vector3.New(var_334_32.x, var_334_32.y, var_334_32.z)

				local var_334_33 = var_334_27.localEulerAngles

				var_334_33.z = 0
				var_334_33.x = 0
				var_334_27.localEulerAngles = var_334_33
			end

			if arg_331_1.time_ >= var_334_28 + var_334_29 and arg_331_1.time_ < var_334_28 + var_334_29 + arg_334_0 then
				var_334_27.localPosition = Vector3.New(0, 100, 0)

				local var_334_34 = manager.ui.mainCamera.transform.position - var_334_27.position

				var_334_27.forward = Vector3.New(var_334_34.x, var_334_34.y, var_334_34.z)

				local var_334_35 = var_334_27.localEulerAngles

				var_334_35.z = 0
				var_334_35.x = 0
				var_334_27.localEulerAngles = var_334_35
			end

			local var_334_36 = arg_331_1.actors_["1093ui_story"]
			local var_334_37 = 1.96599999815226

			if var_334_37 < arg_331_1.time_ and arg_331_1.time_ <= var_334_37 + arg_334_0 and not isNil(var_334_36) and arg_331_1.var_.characterEffect1093ui_story == nil then
				arg_331_1.var_.characterEffect1093ui_story = var_334_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_38 = 0.034000001847744

			if var_334_37 <= arg_331_1.time_ and arg_331_1.time_ < var_334_37 + var_334_38 and not isNil(var_334_36) then
				local var_334_39 = (arg_331_1.time_ - var_334_37) / var_334_38

				if arg_331_1.var_.characterEffect1093ui_story and not isNil(var_334_36) then
					local var_334_40 = Mathf.Lerp(0, 0.5, var_334_39)

					arg_331_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_331_1.var_.characterEffect1093ui_story.fillRatio = var_334_40
				end
			end

			if arg_331_1.time_ >= var_334_37 + var_334_38 and arg_331_1.time_ < var_334_37 + var_334_38 + arg_334_0 and not isNil(var_334_36) and arg_331_1.var_.characterEffect1093ui_story then
				local var_334_41 = 0.5

				arg_331_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_331_1.var_.characterEffect1093ui_story.fillRatio = var_334_41
			end

			if arg_331_1.frameCnt_ <= 1 then
				arg_331_1.dialog_:SetActive(false)
			end

			local var_334_42 = 4
			local var_334_43 = 0.9

			if var_334_42 < arg_331_1.time_ and arg_331_1.time_ <= var_334_42 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0

				arg_331_1.dialog_:SetActive(true)

				arg_331_1.dialogCg_.alpha = 0

				local var_334_44 = LeanTween.value(arg_331_1.dialog_, 0, 1, 0.3)

				var_334_44:setOnUpdate(LuaHelper.FloatAction(function(arg_335_0)
					arg_331_1.dialogCg_.alpha = arg_335_0
				end))
				var_334_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_331_1.dialog_)
					var_334_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_331_1.duration_ = arg_331_1.duration_ + 0.3

				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_45 = arg_331_1:GetWordFromCfg(318301081)
				local var_334_46 = arg_331_1:FormatText(var_334_45.content)

				arg_331_1.text_.text = var_334_46

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_47 = 36
				local var_334_48 = utf8.len(var_334_46)
				local var_334_49 = var_334_47 <= 0 and var_334_43 or var_334_43 * (var_334_48 / var_334_47)

				if var_334_49 > 0 and var_334_43 < var_334_49 then
					arg_331_1.talkMaxDuration = var_334_49
					var_334_42 = var_334_42 + 0.3

					if var_334_49 + var_334_42 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_49 + var_334_42
					end
				end

				arg_331_1.text_.text = var_334_46
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_50 = var_334_42 + 0.3
			local var_334_51 = math.max(var_334_43, arg_331_1.talkMaxDuration)

			if var_334_50 <= arg_331_1.time_ and arg_331_1.time_ < var_334_50 + var_334_51 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_50) / var_334_51

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_50 + var_334_51 and arg_331_1.time_ < var_334_50 + var_334_51 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play318301082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 318301082
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play318301083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0
			local var_340_1 = 1.225

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_2 = arg_337_1:GetWordFromCfg(318301082)
				local var_340_3 = arg_337_1:FormatText(var_340_2.content)

				arg_337_1.text_.text = var_340_3

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_4 = 49
				local var_340_5 = utf8.len(var_340_3)
				local var_340_6 = var_340_4 <= 0 and var_340_1 or var_340_1 * (var_340_5 / var_340_4)

				if var_340_6 > 0 and var_340_1 < var_340_6 then
					arg_337_1.talkMaxDuration = var_340_6

					if var_340_6 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_6 + var_340_0
					end
				end

				arg_337_1.text_.text = var_340_3
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_7 = math.max(var_340_1, arg_337_1.talkMaxDuration)

			if var_340_0 <= arg_337_1.time_ and arg_337_1.time_ < var_340_0 + var_340_7 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_0) / var_340_7

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_0 + var_340_7 and arg_337_1.time_ < var_340_0 + var_340_7 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play318301083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 318301083
		arg_341_1.duration_ = 4.43

		local var_341_0 = {
			zh = 3.633,
			ja = 4.433
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
				arg_341_0:Play318301084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1049ui_story"].transform
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.var_.moveOldPos1049ui_story = var_344_0.localPosition
			end

			local var_344_2 = 0.001

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2
				local var_344_4 = Vector3.New(0, -1.2, -6)

				var_344_0.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1049ui_story, var_344_4, var_344_3)

				local var_344_5 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_5.x, var_344_5.y, var_344_5.z)

				local var_344_6 = var_344_0.localEulerAngles

				var_344_6.z = 0
				var_344_6.x = 0
				var_344_0.localEulerAngles = var_344_6
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 then
				var_344_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_344_7 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_7.x, var_344_7.y, var_344_7.z)

				local var_344_8 = var_344_0.localEulerAngles

				var_344_8.z = 0
				var_344_8.x = 0
				var_344_0.localEulerAngles = var_344_8
			end

			local var_344_9 = arg_341_1.actors_["1049ui_story"]
			local var_344_10 = 0

			if var_344_10 < arg_341_1.time_ and arg_341_1.time_ <= var_344_10 + arg_344_0 and not isNil(var_344_9) and arg_341_1.var_.characterEffect1049ui_story == nil then
				arg_341_1.var_.characterEffect1049ui_story = var_344_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_11 = 0.200000002980232

			if var_344_10 <= arg_341_1.time_ and arg_341_1.time_ < var_344_10 + var_344_11 and not isNil(var_344_9) then
				local var_344_12 = (arg_341_1.time_ - var_344_10) / var_344_11

				if arg_341_1.var_.characterEffect1049ui_story and not isNil(var_344_9) then
					arg_341_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_10 + var_344_11 and arg_341_1.time_ < var_344_10 + var_344_11 + arg_344_0 and not isNil(var_344_9) and arg_341_1.var_.characterEffect1049ui_story then
				arg_341_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_344_13 = 0

			if var_344_13 < arg_341_1.time_ and arg_341_1.time_ <= var_344_13 + arg_344_0 then
				arg_341_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_344_14 = 0

			if var_344_14 < arg_341_1.time_ and arg_341_1.time_ <= var_344_14 + arg_344_0 then
				arg_341_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_344_15 = 0
			local var_344_16 = 0.2

			if var_344_15 < arg_341_1.time_ and arg_341_1.time_ <= var_344_15 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_17 = arg_341_1:FormatText(StoryNameCfg[562].name)

				arg_341_1.leftNameTxt_.text = var_344_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_18 = arg_341_1:GetWordFromCfg(318301083)
				local var_344_19 = arg_341_1:FormatText(var_344_18.content)

				arg_341_1.text_.text = var_344_19

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_20 = 8
				local var_344_21 = utf8.len(var_344_19)
				local var_344_22 = var_344_20 <= 0 and var_344_16 or var_344_16 * (var_344_21 / var_344_20)

				if var_344_22 > 0 and var_344_16 < var_344_22 then
					arg_341_1.talkMaxDuration = var_344_22

					if var_344_22 + var_344_15 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_22 + var_344_15
					end
				end

				arg_341_1.text_.text = var_344_19
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301083", "story_v_out_318301.awb") ~= 0 then
					local var_344_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301083", "story_v_out_318301.awb") / 1000

					if var_344_23 + var_344_15 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_23 + var_344_15
					end

					if var_344_18.prefab_name ~= "" and arg_341_1.actors_[var_344_18.prefab_name] ~= nil then
						local var_344_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_18.prefab_name].transform, "story_v_out_318301", "318301083", "story_v_out_318301.awb")

						arg_341_1:RecordAudio("318301083", var_344_24)
						arg_341_1:RecordAudio("318301083", var_344_24)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_318301", "318301083", "story_v_out_318301.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_318301", "318301083", "story_v_out_318301.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_25 = math.max(var_344_16, arg_341_1.talkMaxDuration)

			if var_344_15 <= arg_341_1.time_ and arg_341_1.time_ < var_344_15 + var_344_25 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_15) / var_344_25

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_15 + var_344_25 and arg_341_1.time_ < var_344_15 + var_344_25 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play318301084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 318301084
		arg_345_1.duration_ = 4.43

		local var_345_0 = {
			zh = 3.166,
			ja = 4.433
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play318301085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = "10053ui_story"

			if arg_345_1.actors_[var_348_0] == nil then
				local var_348_1 = Asset.Load("Char/" .. "10053ui_story")

				if not isNil(var_348_1) then
					local var_348_2 = Object.Instantiate(Asset.Load("Char/" .. "10053ui_story"), arg_345_1.stage_.transform)

					var_348_2.name = var_348_0
					var_348_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_345_1.actors_[var_348_0] = var_348_2

					local var_348_3 = var_348_2:GetComponentInChildren(typeof(CharacterEffect))

					var_348_3.enabled = true

					local var_348_4 = GameObjectTools.GetOrAddComponent(var_348_2, typeof(DynamicBoneHelper))

					if var_348_4 then
						var_348_4:EnableDynamicBone(false)
					end

					arg_345_1:ShowWeapon(var_348_3.transform, false)

					arg_345_1.var_[var_348_0 .. "Animator"] = var_348_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_345_1.var_[var_348_0 .. "Animator"].applyRootMotion = true
					arg_345_1.var_[var_348_0 .. "LipSync"] = var_348_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_348_5 = arg_345_1.actors_["10053ui_story"].transform
			local var_348_6 = 0

			if var_348_6 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.var_.moveOldPos10053ui_story = var_348_5.localPosition
			end

			local var_348_7 = 0.001

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_7 then
				local var_348_8 = (arg_345_1.time_ - var_348_6) / var_348_7
				local var_348_9 = Vector3.New(0, -1.12, -5.99)

				var_348_5.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10053ui_story, var_348_9, var_348_8)

				local var_348_10 = manager.ui.mainCamera.transform.position - var_348_5.position

				var_348_5.forward = Vector3.New(var_348_10.x, var_348_10.y, var_348_10.z)

				local var_348_11 = var_348_5.localEulerAngles

				var_348_11.z = 0
				var_348_11.x = 0
				var_348_5.localEulerAngles = var_348_11
			end

			if arg_345_1.time_ >= var_348_6 + var_348_7 and arg_345_1.time_ < var_348_6 + var_348_7 + arg_348_0 then
				var_348_5.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_348_12 = manager.ui.mainCamera.transform.position - var_348_5.position

				var_348_5.forward = Vector3.New(var_348_12.x, var_348_12.y, var_348_12.z)

				local var_348_13 = var_348_5.localEulerAngles

				var_348_13.z = 0
				var_348_13.x = 0
				var_348_5.localEulerAngles = var_348_13
			end

			local var_348_14 = arg_345_1.actors_["10053ui_story"]
			local var_348_15 = 0

			if var_348_15 < arg_345_1.time_ and arg_345_1.time_ <= var_348_15 + arg_348_0 and not isNil(var_348_14) and arg_345_1.var_.characterEffect10053ui_story == nil then
				arg_345_1.var_.characterEffect10053ui_story = var_348_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_16 = 0.200000002980232

			if var_348_15 <= arg_345_1.time_ and arg_345_1.time_ < var_348_15 + var_348_16 and not isNil(var_348_14) then
				local var_348_17 = (arg_345_1.time_ - var_348_15) / var_348_16

				if arg_345_1.var_.characterEffect10053ui_story and not isNil(var_348_14) then
					arg_345_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= var_348_15 + var_348_16 and arg_345_1.time_ < var_348_15 + var_348_16 + arg_348_0 and not isNil(var_348_14) and arg_345_1.var_.characterEffect10053ui_story then
				arg_345_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_348_18 = 0

			if var_348_18 < arg_345_1.time_ and arg_345_1.time_ <= var_348_18 + arg_348_0 then
				arg_345_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_348_19 = 0

			if var_348_19 < arg_345_1.time_ and arg_345_1.time_ <= var_348_19 + arg_348_0 then
				arg_345_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_348_20 = arg_345_1.actors_["1049ui_story"].transform
			local var_348_21 = 0

			if var_348_21 < arg_345_1.time_ and arg_345_1.time_ <= var_348_21 + arg_348_0 then
				arg_345_1.var_.moveOldPos1049ui_story = var_348_20.localPosition
			end

			local var_348_22 = 0.001

			if var_348_21 <= arg_345_1.time_ and arg_345_1.time_ < var_348_21 + var_348_22 then
				local var_348_23 = (arg_345_1.time_ - var_348_21) / var_348_22
				local var_348_24 = Vector3.New(0, 100, 0)

				var_348_20.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1049ui_story, var_348_24, var_348_23)

				local var_348_25 = manager.ui.mainCamera.transform.position - var_348_20.position

				var_348_20.forward = Vector3.New(var_348_25.x, var_348_25.y, var_348_25.z)

				local var_348_26 = var_348_20.localEulerAngles

				var_348_26.z = 0
				var_348_26.x = 0
				var_348_20.localEulerAngles = var_348_26
			end

			if arg_345_1.time_ >= var_348_21 + var_348_22 and arg_345_1.time_ < var_348_21 + var_348_22 + arg_348_0 then
				var_348_20.localPosition = Vector3.New(0, 100, 0)

				local var_348_27 = manager.ui.mainCamera.transform.position - var_348_20.position

				var_348_20.forward = Vector3.New(var_348_27.x, var_348_27.y, var_348_27.z)

				local var_348_28 = var_348_20.localEulerAngles

				var_348_28.z = 0
				var_348_28.x = 0
				var_348_20.localEulerAngles = var_348_28
			end

			local var_348_29 = arg_345_1.actors_["1049ui_story"]
			local var_348_30 = 0

			if var_348_30 < arg_345_1.time_ and arg_345_1.time_ <= var_348_30 + arg_348_0 and not isNil(var_348_29) and arg_345_1.var_.characterEffect1049ui_story == nil then
				arg_345_1.var_.characterEffect1049ui_story = var_348_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_31 = 0.200000002980232

			if var_348_30 <= arg_345_1.time_ and arg_345_1.time_ < var_348_30 + var_348_31 and not isNil(var_348_29) then
				local var_348_32 = (arg_345_1.time_ - var_348_30) / var_348_31

				if arg_345_1.var_.characterEffect1049ui_story and not isNil(var_348_29) then
					local var_348_33 = Mathf.Lerp(0, 0.5, var_348_32)

					arg_345_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1049ui_story.fillRatio = var_348_33
				end
			end

			if arg_345_1.time_ >= var_348_30 + var_348_31 and arg_345_1.time_ < var_348_30 + var_348_31 + arg_348_0 and not isNil(var_348_29) and arg_345_1.var_.characterEffect1049ui_story then
				local var_348_34 = 0.5

				arg_345_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1049ui_story.fillRatio = var_348_34
			end

			local var_348_35 = 0
			local var_348_36 = 0.325

			if var_348_35 < arg_345_1.time_ and arg_345_1.time_ <= var_348_35 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_37 = arg_345_1:FormatText(StoryNameCfg[477].name)

				arg_345_1.leftNameTxt_.text = var_348_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_38 = arg_345_1:GetWordFromCfg(318301084)
				local var_348_39 = arg_345_1:FormatText(var_348_38.content)

				arg_345_1.text_.text = var_348_39

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_40 = 13
				local var_348_41 = utf8.len(var_348_39)
				local var_348_42 = var_348_40 <= 0 and var_348_36 or var_348_36 * (var_348_41 / var_348_40)

				if var_348_42 > 0 and var_348_36 < var_348_42 then
					arg_345_1.talkMaxDuration = var_348_42

					if var_348_42 + var_348_35 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_42 + var_348_35
					end
				end

				arg_345_1.text_.text = var_348_39
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301084", "story_v_out_318301.awb") ~= 0 then
					local var_348_43 = manager.audio:GetVoiceLength("story_v_out_318301", "318301084", "story_v_out_318301.awb") / 1000

					if var_348_43 + var_348_35 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_43 + var_348_35
					end

					if var_348_38.prefab_name ~= "" and arg_345_1.actors_[var_348_38.prefab_name] ~= nil then
						local var_348_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_38.prefab_name].transform, "story_v_out_318301", "318301084", "story_v_out_318301.awb")

						arg_345_1:RecordAudio("318301084", var_348_44)
						arg_345_1:RecordAudio("318301084", var_348_44)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_318301", "318301084", "story_v_out_318301.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_318301", "318301084", "story_v_out_318301.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_45 = math.max(var_348_36, arg_345_1.talkMaxDuration)

			if var_348_35 <= arg_345_1.time_ and arg_345_1.time_ < var_348_35 + var_348_45 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_35) / var_348_45

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_35 + var_348_45 and arg_345_1.time_ < var_348_35 + var_348_45 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play318301085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 318301085
		arg_349_1.duration_ = 5.93

		local var_349_0 = {
			zh = 4.233,
			ja = 5.933
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
				arg_349_0:Play318301086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1049ui_story"].transform
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.var_.moveOldPos1049ui_story = var_352_0.localPosition
			end

			local var_352_2 = 0.001

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2
				local var_352_4 = Vector3.New(0, -1.2, -6)

				var_352_0.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1049ui_story, var_352_4, var_352_3)

				local var_352_5 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_5.x, var_352_5.y, var_352_5.z)

				local var_352_6 = var_352_0.localEulerAngles

				var_352_6.z = 0
				var_352_6.x = 0
				var_352_0.localEulerAngles = var_352_6
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 then
				var_352_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_352_7 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_7.x, var_352_7.y, var_352_7.z)

				local var_352_8 = var_352_0.localEulerAngles

				var_352_8.z = 0
				var_352_8.x = 0
				var_352_0.localEulerAngles = var_352_8
			end

			local var_352_9 = arg_349_1.actors_["1049ui_story"]
			local var_352_10 = 0

			if var_352_10 < arg_349_1.time_ and arg_349_1.time_ <= var_352_10 + arg_352_0 and not isNil(var_352_9) and arg_349_1.var_.characterEffect1049ui_story == nil then
				arg_349_1.var_.characterEffect1049ui_story = var_352_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_11 = 0.200000002980232

			if var_352_10 <= arg_349_1.time_ and arg_349_1.time_ < var_352_10 + var_352_11 and not isNil(var_352_9) then
				local var_352_12 = (arg_349_1.time_ - var_352_10) / var_352_11

				if arg_349_1.var_.characterEffect1049ui_story and not isNil(var_352_9) then
					arg_349_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= var_352_10 + var_352_11 and arg_349_1.time_ < var_352_10 + var_352_11 + arg_352_0 and not isNil(var_352_9) and arg_349_1.var_.characterEffect1049ui_story then
				arg_349_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_352_13 = 0

			if var_352_13 < arg_349_1.time_ and arg_349_1.time_ <= var_352_13 + arg_352_0 then
				arg_349_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_352_14 = 0

			if var_352_14 < arg_349_1.time_ and arg_349_1.time_ <= var_352_14 + arg_352_0 then
				arg_349_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_352_15 = arg_349_1.actors_["10053ui_story"].transform
			local var_352_16 = 0

			if var_352_16 < arg_349_1.time_ and arg_349_1.time_ <= var_352_16 + arg_352_0 then
				arg_349_1.var_.moveOldPos10053ui_story = var_352_15.localPosition
			end

			local var_352_17 = 0.001

			if var_352_16 <= arg_349_1.time_ and arg_349_1.time_ < var_352_16 + var_352_17 then
				local var_352_18 = (arg_349_1.time_ - var_352_16) / var_352_17
				local var_352_19 = Vector3.New(0, 100, 0)

				var_352_15.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos10053ui_story, var_352_19, var_352_18)

				local var_352_20 = manager.ui.mainCamera.transform.position - var_352_15.position

				var_352_15.forward = Vector3.New(var_352_20.x, var_352_20.y, var_352_20.z)

				local var_352_21 = var_352_15.localEulerAngles

				var_352_21.z = 0
				var_352_21.x = 0
				var_352_15.localEulerAngles = var_352_21
			end

			if arg_349_1.time_ >= var_352_16 + var_352_17 and arg_349_1.time_ < var_352_16 + var_352_17 + arg_352_0 then
				var_352_15.localPosition = Vector3.New(0, 100, 0)

				local var_352_22 = manager.ui.mainCamera.transform.position - var_352_15.position

				var_352_15.forward = Vector3.New(var_352_22.x, var_352_22.y, var_352_22.z)

				local var_352_23 = var_352_15.localEulerAngles

				var_352_23.z = 0
				var_352_23.x = 0
				var_352_15.localEulerAngles = var_352_23
			end

			local var_352_24 = arg_349_1.actors_["10053ui_story"]
			local var_352_25 = 0

			if var_352_25 < arg_349_1.time_ and arg_349_1.time_ <= var_352_25 + arg_352_0 and not isNil(var_352_24) and arg_349_1.var_.characterEffect10053ui_story == nil then
				arg_349_1.var_.characterEffect10053ui_story = var_352_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_26 = 0.200000002980232

			if var_352_25 <= arg_349_1.time_ and arg_349_1.time_ < var_352_25 + var_352_26 and not isNil(var_352_24) then
				local var_352_27 = (arg_349_1.time_ - var_352_25) / var_352_26

				if arg_349_1.var_.characterEffect10053ui_story and not isNil(var_352_24) then
					local var_352_28 = Mathf.Lerp(0, 0.5, var_352_27)

					arg_349_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_349_1.var_.characterEffect10053ui_story.fillRatio = var_352_28
				end
			end

			if arg_349_1.time_ >= var_352_25 + var_352_26 and arg_349_1.time_ < var_352_25 + var_352_26 + arg_352_0 and not isNil(var_352_24) and arg_349_1.var_.characterEffect10053ui_story then
				local var_352_29 = 0.5

				arg_349_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_349_1.var_.characterEffect10053ui_story.fillRatio = var_352_29
			end

			local var_352_30 = 0
			local var_352_31 = 0.5

			if var_352_30 < arg_349_1.time_ and arg_349_1.time_ <= var_352_30 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_32 = arg_349_1:FormatText(StoryNameCfg[562].name)

				arg_349_1.leftNameTxt_.text = var_352_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_33 = arg_349_1:GetWordFromCfg(318301085)
				local var_352_34 = arg_349_1:FormatText(var_352_33.content)

				arg_349_1.text_.text = var_352_34

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_35 = 20
				local var_352_36 = utf8.len(var_352_34)
				local var_352_37 = var_352_35 <= 0 and var_352_31 or var_352_31 * (var_352_36 / var_352_35)

				if var_352_37 > 0 and var_352_31 < var_352_37 then
					arg_349_1.talkMaxDuration = var_352_37

					if var_352_37 + var_352_30 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_37 + var_352_30
					end
				end

				arg_349_1.text_.text = var_352_34
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301085", "story_v_out_318301.awb") ~= 0 then
					local var_352_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301085", "story_v_out_318301.awb") / 1000

					if var_352_38 + var_352_30 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_38 + var_352_30
					end

					if var_352_33.prefab_name ~= "" and arg_349_1.actors_[var_352_33.prefab_name] ~= nil then
						local var_352_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_33.prefab_name].transform, "story_v_out_318301", "318301085", "story_v_out_318301.awb")

						arg_349_1:RecordAudio("318301085", var_352_39)
						arg_349_1:RecordAudio("318301085", var_352_39)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_318301", "318301085", "story_v_out_318301.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_318301", "318301085", "story_v_out_318301.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_40 = math.max(var_352_31, arg_349_1.talkMaxDuration)

			if var_352_30 <= arg_349_1.time_ and arg_349_1.time_ < var_352_30 + var_352_40 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_30) / var_352_40

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_30 + var_352_40 and arg_349_1.time_ < var_352_30 + var_352_40 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play318301086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 318301086
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play318301087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1049ui_story"].transform
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.var_.moveOldPos1049ui_story = var_356_0.localPosition
			end

			local var_356_2 = 0.001

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2
				local var_356_4 = Vector3.New(0, 100, 0)

				var_356_0.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1049ui_story, var_356_4, var_356_3)

				local var_356_5 = manager.ui.mainCamera.transform.position - var_356_0.position

				var_356_0.forward = Vector3.New(var_356_5.x, var_356_5.y, var_356_5.z)

				local var_356_6 = var_356_0.localEulerAngles

				var_356_6.z = 0
				var_356_6.x = 0
				var_356_0.localEulerAngles = var_356_6
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 then
				var_356_0.localPosition = Vector3.New(0, 100, 0)

				local var_356_7 = manager.ui.mainCamera.transform.position - var_356_0.position

				var_356_0.forward = Vector3.New(var_356_7.x, var_356_7.y, var_356_7.z)

				local var_356_8 = var_356_0.localEulerAngles

				var_356_8.z = 0
				var_356_8.x = 0
				var_356_0.localEulerAngles = var_356_8
			end

			local var_356_9 = arg_353_1.actors_["1049ui_story"]
			local var_356_10 = 0

			if var_356_10 < arg_353_1.time_ and arg_353_1.time_ <= var_356_10 + arg_356_0 and not isNil(var_356_9) and arg_353_1.var_.characterEffect1049ui_story == nil then
				arg_353_1.var_.characterEffect1049ui_story = var_356_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_11 = 0.200000002980232

			if var_356_10 <= arg_353_1.time_ and arg_353_1.time_ < var_356_10 + var_356_11 and not isNil(var_356_9) then
				local var_356_12 = (arg_353_1.time_ - var_356_10) / var_356_11

				if arg_353_1.var_.characterEffect1049ui_story and not isNil(var_356_9) then
					local var_356_13 = Mathf.Lerp(0, 0.5, var_356_12)

					arg_353_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1049ui_story.fillRatio = var_356_13
				end
			end

			if arg_353_1.time_ >= var_356_10 + var_356_11 and arg_353_1.time_ < var_356_10 + var_356_11 + arg_356_0 and not isNil(var_356_9) and arg_353_1.var_.characterEffect1049ui_story then
				local var_356_14 = 0.5

				arg_353_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1049ui_story.fillRatio = var_356_14
			end

			local var_356_15 = 0
			local var_356_16 = 1.75

			if var_356_15 < arg_353_1.time_ and arg_353_1.time_ <= var_356_15 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_17 = arg_353_1:GetWordFromCfg(318301086)
				local var_356_18 = arg_353_1:FormatText(var_356_17.content)

				arg_353_1.text_.text = var_356_18

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_19 = 70
				local var_356_20 = utf8.len(var_356_18)
				local var_356_21 = var_356_19 <= 0 and var_356_16 or var_356_16 * (var_356_20 / var_356_19)

				if var_356_21 > 0 and var_356_16 < var_356_21 then
					arg_353_1.talkMaxDuration = var_356_21

					if var_356_21 + var_356_15 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_21 + var_356_15
					end
				end

				arg_353_1.text_.text = var_356_18
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_22 = math.max(var_356_16, arg_353_1.talkMaxDuration)

			if var_356_15 <= arg_353_1.time_ and arg_353_1.time_ < var_356_15 + var_356_22 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_15) / var_356_22

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_15 + var_356_22 and arg_353_1.time_ < var_356_15 + var_356_22 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play318301087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 318301087
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play318301088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0
			local var_360_1 = 0.825

			if var_360_0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_2 = arg_357_1:FormatText(StoryNameCfg[7].name)

				arg_357_1.leftNameTxt_.text = var_360_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_3 = arg_357_1:GetWordFromCfg(318301087)
				local var_360_4 = arg_357_1:FormatText(var_360_3.content)

				arg_357_1.text_.text = var_360_4

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_5 = 33
				local var_360_6 = utf8.len(var_360_4)
				local var_360_7 = var_360_5 <= 0 and var_360_1 or var_360_1 * (var_360_6 / var_360_5)

				if var_360_7 > 0 and var_360_1 < var_360_7 then
					arg_357_1.talkMaxDuration = var_360_7

					if var_360_7 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_0
					end
				end

				arg_357_1.text_.text = var_360_4
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_8 = math.max(var_360_1, arg_357_1.talkMaxDuration)

			if var_360_0 <= arg_357_1.time_ and arg_357_1.time_ < var_360_0 + var_360_8 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_0) / var_360_8

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_0 + var_360_8 and arg_357_1.time_ < var_360_0 + var_360_8 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play318301088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 318301088
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play318301089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0
			local var_364_1 = 0.775

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_2 = arg_361_1:FormatText(StoryNameCfg[7].name)

				arg_361_1.leftNameTxt_.text = var_364_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:GetWordFromCfg(318301088)
				local var_364_4 = arg_361_1:FormatText(var_364_3.content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 31
				local var_364_6 = utf8.len(var_364_4)
				local var_364_7 = var_364_5 <= 0 and var_364_1 or var_364_1 * (var_364_6 / var_364_5)

				if var_364_7 > 0 and var_364_1 < var_364_7 then
					arg_361_1.talkMaxDuration = var_364_7

					if var_364_7 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_0
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_8 = math.max(var_364_1, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_8 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_0) / var_364_8

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_8 and arg_361_1.time_ < var_364_0 + var_364_8 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play318301089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 318301089
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play318301090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.725

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[7].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_3 = arg_365_1:GetWordFromCfg(318301089)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 29
				local var_368_6 = utf8.len(var_368_4)
				local var_368_7 = var_368_5 <= 0 and var_368_1 or var_368_1 * (var_368_6 / var_368_5)

				if var_368_7 > 0 and var_368_1 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_4
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_8 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_8 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_8

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_8 and arg_365_1.time_ < var_368_0 + var_368_8 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play318301090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 318301090
		arg_369_1.duration_ = 3.4

		local var_369_0 = {
			zh = 3.4,
			ja = 2.5
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
				arg_369_0:Play318301091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["10053ui_story"].transform
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.var_.moveOldPos10053ui_story = var_372_0.localPosition
			end

			local var_372_2 = 0.001

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2
				local var_372_4 = Vector3.New(0, -1.12, -5.99)

				var_372_0.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos10053ui_story, var_372_4, var_372_3)

				local var_372_5 = manager.ui.mainCamera.transform.position - var_372_0.position

				var_372_0.forward = Vector3.New(var_372_5.x, var_372_5.y, var_372_5.z)

				local var_372_6 = var_372_0.localEulerAngles

				var_372_6.z = 0
				var_372_6.x = 0
				var_372_0.localEulerAngles = var_372_6
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 then
				var_372_0.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_372_7 = manager.ui.mainCamera.transform.position - var_372_0.position

				var_372_0.forward = Vector3.New(var_372_7.x, var_372_7.y, var_372_7.z)

				local var_372_8 = var_372_0.localEulerAngles

				var_372_8.z = 0
				var_372_8.x = 0
				var_372_0.localEulerAngles = var_372_8
			end

			local var_372_9 = arg_369_1.actors_["10053ui_story"]
			local var_372_10 = 0

			if var_372_10 < arg_369_1.time_ and arg_369_1.time_ <= var_372_10 + arg_372_0 and not isNil(var_372_9) and arg_369_1.var_.characterEffect10053ui_story == nil then
				arg_369_1.var_.characterEffect10053ui_story = var_372_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_11 = 0.200000002980232

			if var_372_10 <= arg_369_1.time_ and arg_369_1.time_ < var_372_10 + var_372_11 and not isNil(var_372_9) then
				local var_372_12 = (arg_369_1.time_ - var_372_10) / var_372_11

				if arg_369_1.var_.characterEffect10053ui_story and not isNil(var_372_9) then
					arg_369_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= var_372_10 + var_372_11 and arg_369_1.time_ < var_372_10 + var_372_11 + arg_372_0 and not isNil(var_372_9) and arg_369_1.var_.characterEffect10053ui_story then
				arg_369_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_372_13 = 0

			if var_372_13 < arg_369_1.time_ and arg_369_1.time_ <= var_372_13 + arg_372_0 then
				arg_369_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_372_14 = 0

			if var_372_14 < arg_369_1.time_ and arg_369_1.time_ <= var_372_14 + arg_372_0 then
				arg_369_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_372_15 = 0
			local var_372_16 = 0.275

			if var_372_15 < arg_369_1.time_ and arg_369_1.time_ <= var_372_15 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_17 = arg_369_1:FormatText(StoryNameCfg[477].name)

				arg_369_1.leftNameTxt_.text = var_372_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_18 = arg_369_1:GetWordFromCfg(318301090)
				local var_372_19 = arg_369_1:FormatText(var_372_18.content)

				arg_369_1.text_.text = var_372_19

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_20 = 11
				local var_372_21 = utf8.len(var_372_19)
				local var_372_22 = var_372_20 <= 0 and var_372_16 or var_372_16 * (var_372_21 / var_372_20)

				if var_372_22 > 0 and var_372_16 < var_372_22 then
					arg_369_1.talkMaxDuration = var_372_22

					if var_372_22 + var_372_15 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_22 + var_372_15
					end
				end

				arg_369_1.text_.text = var_372_19
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301090", "story_v_out_318301.awb") ~= 0 then
					local var_372_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301090", "story_v_out_318301.awb") / 1000

					if var_372_23 + var_372_15 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_23 + var_372_15
					end

					if var_372_18.prefab_name ~= "" and arg_369_1.actors_[var_372_18.prefab_name] ~= nil then
						local var_372_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_18.prefab_name].transform, "story_v_out_318301", "318301090", "story_v_out_318301.awb")

						arg_369_1:RecordAudio("318301090", var_372_24)
						arg_369_1:RecordAudio("318301090", var_372_24)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_318301", "318301090", "story_v_out_318301.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_318301", "318301090", "story_v_out_318301.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_25 = math.max(var_372_16, arg_369_1.talkMaxDuration)

			if var_372_15 <= arg_369_1.time_ and arg_369_1.time_ < var_372_15 + var_372_25 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_15) / var_372_25

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_15 + var_372_25 and arg_369_1.time_ < var_372_15 + var_372_25 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play318301091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 318301091
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play318301092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["10053ui_story"].transform
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.var_.moveOldPos10053ui_story = var_376_0.localPosition
			end

			local var_376_2 = 0.001

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2
				local var_376_4 = Vector3.New(0, 100, 0)

				var_376_0.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos10053ui_story, var_376_4, var_376_3)

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

			local var_376_9 = arg_373_1.actors_["10053ui_story"]
			local var_376_10 = 0

			if var_376_10 < arg_373_1.time_ and arg_373_1.time_ <= var_376_10 + arg_376_0 and not isNil(var_376_9) and arg_373_1.var_.characterEffect10053ui_story == nil then
				arg_373_1.var_.characterEffect10053ui_story = var_376_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_11 = 0.200000002980232

			if var_376_10 <= arg_373_1.time_ and arg_373_1.time_ < var_376_10 + var_376_11 and not isNil(var_376_9) then
				local var_376_12 = (arg_373_1.time_ - var_376_10) / var_376_11

				if arg_373_1.var_.characterEffect10053ui_story and not isNil(var_376_9) then
					local var_376_13 = Mathf.Lerp(0, 0.5, var_376_12)

					arg_373_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_373_1.var_.characterEffect10053ui_story.fillRatio = var_376_13
				end
			end

			if arg_373_1.time_ >= var_376_10 + var_376_11 and arg_373_1.time_ < var_376_10 + var_376_11 + arg_376_0 and not isNil(var_376_9) and arg_373_1.var_.characterEffect10053ui_story then
				local var_376_14 = 0.5

				arg_373_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_373_1.var_.characterEffect10053ui_story.fillRatio = var_376_14
			end

			local var_376_15 = 0
			local var_376_16 = 0.875

			if var_376_15 < arg_373_1.time_ and arg_373_1.time_ <= var_376_15 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_17 = arg_373_1:GetWordFromCfg(318301091)
				local var_376_18 = arg_373_1:FormatText(var_376_17.content)

				arg_373_1.text_.text = var_376_18

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_19 = 35
				local var_376_20 = utf8.len(var_376_18)
				local var_376_21 = var_376_19 <= 0 and var_376_16 or var_376_16 * (var_376_20 / var_376_19)

				if var_376_21 > 0 and var_376_16 < var_376_21 then
					arg_373_1.talkMaxDuration = var_376_21

					if var_376_21 + var_376_15 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_21 + var_376_15
					end
				end

				arg_373_1.text_.text = var_376_18
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_22 = math.max(var_376_16, arg_373_1.talkMaxDuration)

			if var_376_15 <= arg_373_1.time_ and arg_373_1.time_ < var_376_15 + var_376_22 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_15) / var_376_22

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_15 + var_376_22 and arg_373_1.time_ < var_376_15 + var_376_22 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play318301092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 318301092
		arg_377_1.duration_ = 10.07

		local var_377_0 = {
			zh = 5.2,
			ja = 10.066
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
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play318301093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["1049ui_story"].transform
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.var_.moveOldPos1049ui_story = var_380_0.localPosition
			end

			local var_380_2 = 0.001

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2
				local var_380_4 = Vector3.New(0, -1.2, -6)

				var_380_0.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1049ui_story, var_380_4, var_380_3)

				local var_380_5 = manager.ui.mainCamera.transform.position - var_380_0.position

				var_380_0.forward = Vector3.New(var_380_5.x, var_380_5.y, var_380_5.z)

				local var_380_6 = var_380_0.localEulerAngles

				var_380_6.z = 0
				var_380_6.x = 0
				var_380_0.localEulerAngles = var_380_6
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 then
				var_380_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_380_7 = manager.ui.mainCamera.transform.position - var_380_0.position

				var_380_0.forward = Vector3.New(var_380_7.x, var_380_7.y, var_380_7.z)

				local var_380_8 = var_380_0.localEulerAngles

				var_380_8.z = 0
				var_380_8.x = 0
				var_380_0.localEulerAngles = var_380_8
			end

			local var_380_9 = arg_377_1.actors_["1049ui_story"]
			local var_380_10 = 0

			if var_380_10 < arg_377_1.time_ and arg_377_1.time_ <= var_380_10 + arg_380_0 and not isNil(var_380_9) and arg_377_1.var_.characterEffect1049ui_story == nil then
				arg_377_1.var_.characterEffect1049ui_story = var_380_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_11 = 0.200000002980232

			if var_380_10 <= arg_377_1.time_ and arg_377_1.time_ < var_380_10 + var_380_11 and not isNil(var_380_9) then
				local var_380_12 = (arg_377_1.time_ - var_380_10) / var_380_11

				if arg_377_1.var_.characterEffect1049ui_story and not isNil(var_380_9) then
					arg_377_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= var_380_10 + var_380_11 and arg_377_1.time_ < var_380_10 + var_380_11 + arg_380_0 and not isNil(var_380_9) and arg_377_1.var_.characterEffect1049ui_story then
				arg_377_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_380_13 = 0

			if var_380_13 < arg_377_1.time_ and arg_377_1.time_ <= var_380_13 + arg_380_0 then
				arg_377_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_380_14 = 0

			if var_380_14 < arg_377_1.time_ and arg_377_1.time_ <= var_380_14 + arg_380_0 then
				arg_377_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_380_15 = 0
			local var_380_16 = 0.45

			if var_380_15 < arg_377_1.time_ and arg_377_1.time_ <= var_380_15 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_17 = arg_377_1:FormatText(StoryNameCfg[562].name)

				arg_377_1.leftNameTxt_.text = var_380_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_18 = arg_377_1:GetWordFromCfg(318301092)
				local var_380_19 = arg_377_1:FormatText(var_380_18.content)

				arg_377_1.text_.text = var_380_19

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_20 = 18
				local var_380_21 = utf8.len(var_380_19)
				local var_380_22 = var_380_20 <= 0 and var_380_16 or var_380_16 * (var_380_21 / var_380_20)

				if var_380_22 > 0 and var_380_16 < var_380_22 then
					arg_377_1.talkMaxDuration = var_380_22

					if var_380_22 + var_380_15 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_22 + var_380_15
					end
				end

				arg_377_1.text_.text = var_380_19
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301092", "story_v_out_318301.awb") ~= 0 then
					local var_380_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301092", "story_v_out_318301.awb") / 1000

					if var_380_23 + var_380_15 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_23 + var_380_15
					end

					if var_380_18.prefab_name ~= "" and arg_377_1.actors_[var_380_18.prefab_name] ~= nil then
						local var_380_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_18.prefab_name].transform, "story_v_out_318301", "318301092", "story_v_out_318301.awb")

						arg_377_1:RecordAudio("318301092", var_380_24)
						arg_377_1:RecordAudio("318301092", var_380_24)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_318301", "318301092", "story_v_out_318301.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_318301", "318301092", "story_v_out_318301.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_25 = math.max(var_380_16, arg_377_1.talkMaxDuration)

			if var_380_15 <= arg_377_1.time_ and arg_377_1.time_ < var_380_15 + var_380_25 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_15) / var_380_25

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_15 + var_380_25 and arg_377_1.time_ < var_380_15 + var_380_25 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play318301093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 318301093
		arg_381_1.duration_ = 5.4

		local var_381_0 = {
			zh = 5.4,
			ja = 4.266
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play318301094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0
			local var_384_1 = 0.475

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_2 = arg_381_1:FormatText(StoryNameCfg[562].name)

				arg_381_1.leftNameTxt_.text = var_384_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_3 = arg_381_1:GetWordFromCfg(318301093)
				local var_384_4 = arg_381_1:FormatText(var_384_3.content)

				arg_381_1.text_.text = var_384_4

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_5 = 19
				local var_384_6 = utf8.len(var_384_4)
				local var_384_7 = var_384_5 <= 0 and var_384_1 or var_384_1 * (var_384_6 / var_384_5)

				if var_384_7 > 0 and var_384_1 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_0
					end
				end

				arg_381_1.text_.text = var_384_4
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301093", "story_v_out_318301.awb") ~= 0 then
					local var_384_8 = manager.audio:GetVoiceLength("story_v_out_318301", "318301093", "story_v_out_318301.awb") / 1000

					if var_384_8 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_8 + var_384_0
					end

					if var_384_3.prefab_name ~= "" and arg_381_1.actors_[var_384_3.prefab_name] ~= nil then
						local var_384_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_3.prefab_name].transform, "story_v_out_318301", "318301093", "story_v_out_318301.awb")

						arg_381_1:RecordAudio("318301093", var_384_9)
						arg_381_1:RecordAudio("318301093", var_384_9)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_318301", "318301093", "story_v_out_318301.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_318301", "318301093", "story_v_out_318301.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_10 = math.max(var_384_1, arg_381_1.talkMaxDuration)

			if var_384_0 <= arg_381_1.time_ and arg_381_1.time_ < var_384_0 + var_384_10 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_0) / var_384_10

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_0 + var_384_10 and arg_381_1.time_ < var_384_0 + var_384_10 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play318301094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 318301094
		arg_385_1.duration_ = 9

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play318301095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = "K02f"

			if arg_385_1.bgs_[var_388_0] == nil then
				local var_388_1 = Object.Instantiate(arg_385_1.paintGo_)

				var_388_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_388_0)
				var_388_1.name = var_388_0
				var_388_1.transform.parent = arg_385_1.stage_.transform
				var_388_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_385_1.bgs_[var_388_0] = var_388_1
			end

			local var_388_2 = 2

			if var_388_2 < arg_385_1.time_ and arg_385_1.time_ <= var_388_2 + arg_388_0 then
				local var_388_3 = manager.ui.mainCamera.transform.localPosition
				local var_388_4 = Vector3.New(0, 0, 10) + Vector3.New(var_388_3.x, var_388_3.y, 0)
				local var_388_5 = arg_385_1.bgs_.K02f

				var_388_5.transform.localPosition = var_388_4
				var_388_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_388_6 = var_388_5:GetComponent("SpriteRenderer")

				if var_388_6 and var_388_6.sprite then
					local var_388_7 = (var_388_5.transform.localPosition - var_388_3).z
					local var_388_8 = manager.ui.mainCameraCom_
					local var_388_9 = 2 * var_388_7 * Mathf.Tan(var_388_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_388_10 = var_388_9 * var_388_8.aspect
					local var_388_11 = var_388_6.sprite.bounds.size.x
					local var_388_12 = var_388_6.sprite.bounds.size.y
					local var_388_13 = var_388_10 / var_388_11
					local var_388_14 = var_388_9 / var_388_12
					local var_388_15 = var_388_14 < var_388_13 and var_388_13 or var_388_14

					var_388_5.transform.localScale = Vector3.New(var_388_15, var_388_15, 0)
				end

				for iter_388_0, iter_388_1 in pairs(arg_385_1.bgs_) do
					if iter_388_0 ~= "K02f" then
						iter_388_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_388_16 = 0

			if var_388_16 < arg_385_1.time_ and arg_385_1.time_ <= var_388_16 + arg_388_0 then
				arg_385_1.mask_.enabled = true
				arg_385_1.mask_.raycastTarget = true

				arg_385_1:SetGaussion(false)
			end

			local var_388_17 = 2

			if var_388_16 <= arg_385_1.time_ and arg_385_1.time_ < var_388_16 + var_388_17 then
				local var_388_18 = (arg_385_1.time_ - var_388_16) / var_388_17
				local var_388_19 = Color.New(0, 0, 0)

				var_388_19.a = Mathf.Lerp(0, 1, var_388_18)
				arg_385_1.mask_.color = var_388_19
			end

			if arg_385_1.time_ >= var_388_16 + var_388_17 and arg_385_1.time_ < var_388_16 + var_388_17 + arg_388_0 then
				local var_388_20 = Color.New(0, 0, 0)

				var_388_20.a = 1
				arg_385_1.mask_.color = var_388_20
			end

			local var_388_21 = 2

			if var_388_21 < arg_385_1.time_ and arg_385_1.time_ <= var_388_21 + arg_388_0 then
				arg_385_1.mask_.enabled = true
				arg_385_1.mask_.raycastTarget = true

				arg_385_1:SetGaussion(false)
			end

			local var_388_22 = 2

			if var_388_21 <= arg_385_1.time_ and arg_385_1.time_ < var_388_21 + var_388_22 then
				local var_388_23 = (arg_385_1.time_ - var_388_21) / var_388_22
				local var_388_24 = Color.New(0, 0, 0)

				var_388_24.a = Mathf.Lerp(1, 0, var_388_23)
				arg_385_1.mask_.color = var_388_24
			end

			if arg_385_1.time_ >= var_388_21 + var_388_22 and arg_385_1.time_ < var_388_21 + var_388_22 + arg_388_0 then
				local var_388_25 = Color.New(0, 0, 0)
				local var_388_26 = 0

				arg_385_1.mask_.enabled = false
				var_388_25.a = var_388_26
				arg_385_1.mask_.color = var_388_25
			end

			local var_388_27 = arg_385_1.actors_["1049ui_story"].transform
			local var_388_28 = 1.96599999815226

			if var_388_28 < arg_385_1.time_ and arg_385_1.time_ <= var_388_28 + arg_388_0 then
				arg_385_1.var_.moveOldPos1049ui_story = var_388_27.localPosition
			end

			local var_388_29 = 0.001

			if var_388_28 <= arg_385_1.time_ and arg_385_1.time_ < var_388_28 + var_388_29 then
				local var_388_30 = (arg_385_1.time_ - var_388_28) / var_388_29
				local var_388_31 = Vector3.New(0, 100, 0)

				var_388_27.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1049ui_story, var_388_31, var_388_30)

				local var_388_32 = manager.ui.mainCamera.transform.position - var_388_27.position

				var_388_27.forward = Vector3.New(var_388_32.x, var_388_32.y, var_388_32.z)

				local var_388_33 = var_388_27.localEulerAngles

				var_388_33.z = 0
				var_388_33.x = 0
				var_388_27.localEulerAngles = var_388_33
			end

			if arg_385_1.time_ >= var_388_28 + var_388_29 and arg_385_1.time_ < var_388_28 + var_388_29 + arg_388_0 then
				var_388_27.localPosition = Vector3.New(0, 100, 0)

				local var_388_34 = manager.ui.mainCamera.transform.position - var_388_27.position

				var_388_27.forward = Vector3.New(var_388_34.x, var_388_34.y, var_388_34.z)

				local var_388_35 = var_388_27.localEulerAngles

				var_388_35.z = 0
				var_388_35.x = 0
				var_388_27.localEulerAngles = var_388_35
			end

			local var_388_36 = arg_385_1.actors_["1049ui_story"]
			local var_388_37 = 1.96599999815226

			if var_388_37 < arg_385_1.time_ and arg_385_1.time_ <= var_388_37 + arg_388_0 and not isNil(var_388_36) and arg_385_1.var_.characterEffect1049ui_story == nil then
				arg_385_1.var_.characterEffect1049ui_story = var_388_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_38 = 0.0166666666666667

			if var_388_37 <= arg_385_1.time_ and arg_385_1.time_ < var_388_37 + var_388_38 and not isNil(var_388_36) then
				local var_388_39 = (arg_385_1.time_ - var_388_37) / var_388_38

				if arg_385_1.var_.characterEffect1049ui_story and not isNil(var_388_36) then
					local var_388_40 = Mathf.Lerp(0, 0.5, var_388_39)

					arg_385_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1049ui_story.fillRatio = var_388_40
				end
			end

			if arg_385_1.time_ >= var_388_37 + var_388_38 and arg_385_1.time_ < var_388_37 + var_388_38 + arg_388_0 and not isNil(var_388_36) and arg_385_1.var_.characterEffect1049ui_story then
				local var_388_41 = 0.5

				arg_385_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1049ui_story.fillRatio = var_388_41
			end

			if arg_385_1.frameCnt_ <= 1 then
				arg_385_1.dialog_:SetActive(false)
			end

			local var_388_42 = 4
			local var_388_43 = 0.5

			if var_388_42 < arg_385_1.time_ and arg_385_1.time_ <= var_388_42 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0

				arg_385_1.dialog_:SetActive(true)

				arg_385_1.dialogCg_.alpha = 0

				local var_388_44 = LeanTween.value(arg_385_1.dialog_, 0, 1, 0.3)

				var_388_44:setOnUpdate(LuaHelper.FloatAction(function(arg_389_0)
					arg_385_1.dialogCg_.alpha = arg_389_0
				end))
				var_388_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_385_1.dialog_)
					var_388_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_385_1.duration_ = arg_385_1.duration_ + 0.3

				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_45 = arg_385_1:GetWordFromCfg(318301094)
				local var_388_46 = arg_385_1:FormatText(var_388_45.content)

				arg_385_1.text_.text = var_388_46

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_47 = 20
				local var_388_48 = utf8.len(var_388_46)
				local var_388_49 = var_388_47 <= 0 and var_388_43 or var_388_43 * (var_388_48 / var_388_47)

				if var_388_49 > 0 and var_388_43 < var_388_49 then
					arg_385_1.talkMaxDuration = var_388_49
					var_388_42 = var_388_42 + 0.3

					if var_388_49 + var_388_42 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_49 + var_388_42
					end
				end

				arg_385_1.text_.text = var_388_46
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_50 = var_388_42 + 0.3
			local var_388_51 = math.max(var_388_43, arg_385_1.talkMaxDuration)

			if var_388_50 <= arg_385_1.time_ and arg_385_1.time_ < var_388_50 + var_388_51 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_50) / var_388_51

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_50 + var_388_51 and arg_385_1.time_ < var_388_50 + var_388_51 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play318301095 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 318301095
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play318301096(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0
			local var_394_1 = 0.35

			if var_394_0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_2 = arg_391_1:GetWordFromCfg(318301095)
				local var_394_3 = arg_391_1:FormatText(var_394_2.content)

				arg_391_1.text_.text = var_394_3

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_4 = 14
				local var_394_5 = utf8.len(var_394_3)
				local var_394_6 = var_394_4 <= 0 and var_394_1 or var_394_1 * (var_394_5 / var_394_4)

				if var_394_6 > 0 and var_394_1 < var_394_6 then
					arg_391_1.talkMaxDuration = var_394_6

					if var_394_6 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_6 + var_394_0
					end
				end

				arg_391_1.text_.text = var_394_3
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_7 = math.max(var_394_1, arg_391_1.talkMaxDuration)

			if var_394_0 <= arg_391_1.time_ and arg_391_1.time_ < var_394_0 + var_394_7 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_0) / var_394_7

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_0 + var_394_7 and arg_391_1.time_ < var_394_0 + var_394_7 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play318301096 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 318301096
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play318301097(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0
			local var_398_1 = 0.825

			if var_398_0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_2 = arg_395_1:GetWordFromCfg(318301096)
				local var_398_3 = arg_395_1:FormatText(var_398_2.content)

				arg_395_1.text_.text = var_398_3

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_4 = 33
				local var_398_5 = utf8.len(var_398_3)
				local var_398_6 = var_398_4 <= 0 and var_398_1 or var_398_1 * (var_398_5 / var_398_4)

				if var_398_6 > 0 and var_398_1 < var_398_6 then
					arg_395_1.talkMaxDuration = var_398_6

					if var_398_6 + var_398_0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_6 + var_398_0
					end
				end

				arg_395_1.text_.text = var_398_3
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_7 = math.max(var_398_1, arg_395_1.talkMaxDuration)

			if var_398_0 <= arg_395_1.time_ and arg_395_1.time_ < var_398_0 + var_398_7 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_0) / var_398_7

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_0 + var_398_7 and arg_395_1.time_ < var_398_0 + var_398_7 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play318301097 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 318301097
		arg_399_1.duration_ = 2.53

		local var_399_0 = {
			zh = 2.5,
			ja = 2.533
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play318301098(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = "1058ui_story"

			if arg_399_1.actors_[var_402_0] == nil then
				local var_402_1 = Asset.Load("Char/" .. "1058ui_story")

				if not isNil(var_402_1) then
					local var_402_2 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_399_1.stage_.transform)

					var_402_2.name = var_402_0
					var_402_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_399_1.actors_[var_402_0] = var_402_2

					local var_402_3 = var_402_2:GetComponentInChildren(typeof(CharacterEffect))

					var_402_3.enabled = true

					local var_402_4 = GameObjectTools.GetOrAddComponent(var_402_2, typeof(DynamicBoneHelper))

					if var_402_4 then
						var_402_4:EnableDynamicBone(false)
					end

					arg_399_1:ShowWeapon(var_402_3.transform, false)

					arg_399_1.var_[var_402_0 .. "Animator"] = var_402_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_399_1.var_[var_402_0 .. "Animator"].applyRootMotion = true
					arg_399_1.var_[var_402_0 .. "LipSync"] = var_402_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_402_5 = arg_399_1.actors_["1058ui_story"].transform
			local var_402_6 = 0

			if var_402_6 < arg_399_1.time_ and arg_399_1.time_ <= var_402_6 + arg_402_0 then
				arg_399_1.var_.moveOldPos1058ui_story = var_402_5.localPosition
			end

			local var_402_7 = 0.001

			if var_402_6 <= arg_399_1.time_ and arg_399_1.time_ < var_402_6 + var_402_7 then
				local var_402_8 = (arg_399_1.time_ - var_402_6) / var_402_7
				local var_402_9 = Vector3.New(0, -0.95, -5.88)

				var_402_5.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1058ui_story, var_402_9, var_402_8)

				local var_402_10 = manager.ui.mainCamera.transform.position - var_402_5.position

				var_402_5.forward = Vector3.New(var_402_10.x, var_402_10.y, var_402_10.z)

				local var_402_11 = var_402_5.localEulerAngles

				var_402_11.z = 0
				var_402_11.x = 0
				var_402_5.localEulerAngles = var_402_11
			end

			if arg_399_1.time_ >= var_402_6 + var_402_7 and arg_399_1.time_ < var_402_6 + var_402_7 + arg_402_0 then
				var_402_5.localPosition = Vector3.New(0, -0.95, -5.88)

				local var_402_12 = manager.ui.mainCamera.transform.position - var_402_5.position

				var_402_5.forward = Vector3.New(var_402_12.x, var_402_12.y, var_402_12.z)

				local var_402_13 = var_402_5.localEulerAngles

				var_402_13.z = 0
				var_402_13.x = 0
				var_402_5.localEulerAngles = var_402_13
			end

			local var_402_14 = arg_399_1.actors_["1058ui_story"]
			local var_402_15 = 0

			if var_402_15 < arg_399_1.time_ and arg_399_1.time_ <= var_402_15 + arg_402_0 and not isNil(var_402_14) and arg_399_1.var_.characterEffect1058ui_story == nil then
				arg_399_1.var_.characterEffect1058ui_story = var_402_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_16 = 0.200000002980232

			if var_402_15 <= arg_399_1.time_ and arg_399_1.time_ < var_402_15 + var_402_16 and not isNil(var_402_14) then
				local var_402_17 = (arg_399_1.time_ - var_402_15) / var_402_16

				if arg_399_1.var_.characterEffect1058ui_story and not isNil(var_402_14) then
					arg_399_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= var_402_15 + var_402_16 and arg_399_1.time_ < var_402_15 + var_402_16 + arg_402_0 and not isNil(var_402_14) and arg_399_1.var_.characterEffect1058ui_story then
				arg_399_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_402_18 = 0

			if var_402_18 < arg_399_1.time_ and arg_399_1.time_ <= var_402_18 + arg_402_0 then
				arg_399_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			local var_402_19 = 0

			if var_402_19 < arg_399_1.time_ and arg_399_1.time_ <= var_402_19 + arg_402_0 then
				arg_399_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_402_20 = 0
			local var_402_21 = 0.225

			if var_402_20 < arg_399_1.time_ and arg_399_1.time_ <= var_402_20 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_22 = arg_399_1:FormatText(StoryNameCfg[92].name)

				arg_399_1.leftNameTxt_.text = var_402_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_23 = arg_399_1:GetWordFromCfg(318301097)
				local var_402_24 = arg_399_1:FormatText(var_402_23.content)

				arg_399_1.text_.text = var_402_24

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_25 = 9
				local var_402_26 = utf8.len(var_402_24)
				local var_402_27 = var_402_25 <= 0 and var_402_21 or var_402_21 * (var_402_26 / var_402_25)

				if var_402_27 > 0 and var_402_21 < var_402_27 then
					arg_399_1.talkMaxDuration = var_402_27

					if var_402_27 + var_402_20 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_27 + var_402_20
					end
				end

				arg_399_1.text_.text = var_402_24
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301097", "story_v_out_318301.awb") ~= 0 then
					local var_402_28 = manager.audio:GetVoiceLength("story_v_out_318301", "318301097", "story_v_out_318301.awb") / 1000

					if var_402_28 + var_402_20 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_28 + var_402_20
					end

					if var_402_23.prefab_name ~= "" and arg_399_1.actors_[var_402_23.prefab_name] ~= nil then
						local var_402_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_23.prefab_name].transform, "story_v_out_318301", "318301097", "story_v_out_318301.awb")

						arg_399_1:RecordAudio("318301097", var_402_29)
						arg_399_1:RecordAudio("318301097", var_402_29)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_318301", "318301097", "story_v_out_318301.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_318301", "318301097", "story_v_out_318301.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_30 = math.max(var_402_21, arg_399_1.talkMaxDuration)

			if var_402_20 <= arg_399_1.time_ and arg_399_1.time_ < var_402_20 + var_402_30 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_20) / var_402_30

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_20 + var_402_30 and arg_399_1.time_ < var_402_20 + var_402_30 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play318301098 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 318301098
		arg_403_1.duration_ = 6.5

		local var_403_0 = {
			zh = 4.8,
			ja = 6.5
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play318301099(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["1058ui_story"].transform
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 then
				arg_403_1.var_.moveOldPos1058ui_story = var_406_0.localPosition
			end

			local var_406_2 = 0.001

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_2 then
				local var_406_3 = (arg_403_1.time_ - var_406_1) / var_406_2
				local var_406_4 = Vector3.New(0, -0.95, -5.88)

				var_406_0.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1058ui_story, var_406_4, var_406_3)

				local var_406_5 = manager.ui.mainCamera.transform.position - var_406_0.position

				var_406_0.forward = Vector3.New(var_406_5.x, var_406_5.y, var_406_5.z)

				local var_406_6 = var_406_0.localEulerAngles

				var_406_6.z = 0
				var_406_6.x = 0
				var_406_0.localEulerAngles = var_406_6
			end

			if arg_403_1.time_ >= var_406_1 + var_406_2 and arg_403_1.time_ < var_406_1 + var_406_2 + arg_406_0 then
				var_406_0.localPosition = Vector3.New(0, -0.95, -5.88)

				local var_406_7 = manager.ui.mainCamera.transform.position - var_406_0.position

				var_406_0.forward = Vector3.New(var_406_7.x, var_406_7.y, var_406_7.z)

				local var_406_8 = var_406_0.localEulerAngles

				var_406_8.z = 0
				var_406_8.x = 0
				var_406_0.localEulerAngles = var_406_8
			end

			local var_406_9 = arg_403_1.actors_["1058ui_story"]
			local var_406_10 = 0

			if var_406_10 < arg_403_1.time_ and arg_403_1.time_ <= var_406_10 + arg_406_0 and not isNil(var_406_9) and arg_403_1.var_.characterEffect1058ui_story == nil then
				arg_403_1.var_.characterEffect1058ui_story = var_406_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_11 = 0.200000002980232

			if var_406_10 <= arg_403_1.time_ and arg_403_1.time_ < var_406_10 + var_406_11 and not isNil(var_406_9) then
				local var_406_12 = (arg_403_1.time_ - var_406_10) / var_406_11

				if arg_403_1.var_.characterEffect1058ui_story and not isNil(var_406_9) then
					arg_403_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= var_406_10 + var_406_11 and arg_403_1.time_ < var_406_10 + var_406_11 + arg_406_0 and not isNil(var_406_9) and arg_403_1.var_.characterEffect1058ui_story then
				arg_403_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_406_13 = 0

			if var_406_13 < arg_403_1.time_ and arg_403_1.time_ <= var_406_13 + arg_406_0 then
				arg_403_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_1")
			end

			local var_406_14 = 0

			if var_406_14 < arg_403_1.time_ and arg_403_1.time_ <= var_406_14 + arg_406_0 then
				arg_403_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_406_15 = 0
			local var_406_16 = 0.5

			if var_406_15 < arg_403_1.time_ and arg_403_1.time_ <= var_406_15 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_17 = arg_403_1:FormatText(StoryNameCfg[92].name)

				arg_403_1.leftNameTxt_.text = var_406_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_18 = arg_403_1:GetWordFromCfg(318301098)
				local var_406_19 = arg_403_1:FormatText(var_406_18.content)

				arg_403_1.text_.text = var_406_19

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_20 = 20
				local var_406_21 = utf8.len(var_406_19)
				local var_406_22 = var_406_20 <= 0 and var_406_16 or var_406_16 * (var_406_21 / var_406_20)

				if var_406_22 > 0 and var_406_16 < var_406_22 then
					arg_403_1.talkMaxDuration = var_406_22

					if var_406_22 + var_406_15 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_22 + var_406_15
					end
				end

				arg_403_1.text_.text = var_406_19
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301098", "story_v_out_318301.awb") ~= 0 then
					local var_406_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301098", "story_v_out_318301.awb") / 1000

					if var_406_23 + var_406_15 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_23 + var_406_15
					end

					if var_406_18.prefab_name ~= "" and arg_403_1.actors_[var_406_18.prefab_name] ~= nil then
						local var_406_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_18.prefab_name].transform, "story_v_out_318301", "318301098", "story_v_out_318301.awb")

						arg_403_1:RecordAudio("318301098", var_406_24)
						arg_403_1:RecordAudio("318301098", var_406_24)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_318301", "318301098", "story_v_out_318301.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_318301", "318301098", "story_v_out_318301.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_25 = math.max(var_406_16, arg_403_1.talkMaxDuration)

			if var_406_15 <= arg_403_1.time_ and arg_403_1.time_ < var_406_15 + var_406_25 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_15) / var_406_25

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_15 + var_406_25 and arg_403_1.time_ < var_406_15 + var_406_25 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play318301099 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 318301099
		arg_407_1.duration_ = 3.7

		local var_407_0 = {
			zh = 3.6,
			ja = 3.7
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play318301100(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0

			if var_410_0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_2")
			end

			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_410_2 = 0
			local var_410_3 = 0.4

			if var_410_2 < arg_407_1.time_ and arg_407_1.time_ <= var_410_2 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_4 = arg_407_1:FormatText(StoryNameCfg[92].name)

				arg_407_1.leftNameTxt_.text = var_410_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_5 = arg_407_1:GetWordFromCfg(318301099)
				local var_410_6 = arg_407_1:FormatText(var_410_5.content)

				arg_407_1.text_.text = var_410_6

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_7 = 16
				local var_410_8 = utf8.len(var_410_6)
				local var_410_9 = var_410_7 <= 0 and var_410_3 or var_410_3 * (var_410_8 / var_410_7)

				if var_410_9 > 0 and var_410_3 < var_410_9 then
					arg_407_1.talkMaxDuration = var_410_9

					if var_410_9 + var_410_2 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_9 + var_410_2
					end
				end

				arg_407_1.text_.text = var_410_6
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301099", "story_v_out_318301.awb") ~= 0 then
					local var_410_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301099", "story_v_out_318301.awb") / 1000

					if var_410_10 + var_410_2 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_10 + var_410_2
					end

					if var_410_5.prefab_name ~= "" and arg_407_1.actors_[var_410_5.prefab_name] ~= nil then
						local var_410_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_5.prefab_name].transform, "story_v_out_318301", "318301099", "story_v_out_318301.awb")

						arg_407_1:RecordAudio("318301099", var_410_11)
						arg_407_1:RecordAudio("318301099", var_410_11)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_318301", "318301099", "story_v_out_318301.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_318301", "318301099", "story_v_out_318301.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_12 = math.max(var_410_3, arg_407_1.talkMaxDuration)

			if var_410_2 <= arg_407_1.time_ and arg_407_1.time_ < var_410_2 + var_410_12 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_2) / var_410_12

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_2 + var_410_12 and arg_407_1.time_ < var_410_2 + var_410_12 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play318301100 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 318301100
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play318301101(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1058ui_story"].transform
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.var_.moveOldPos1058ui_story = var_414_0.localPosition
			end

			local var_414_2 = 0.001

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2
				local var_414_4 = Vector3.New(0, 100, 0)

				var_414_0.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1058ui_story, var_414_4, var_414_3)

				local var_414_5 = manager.ui.mainCamera.transform.position - var_414_0.position

				var_414_0.forward = Vector3.New(var_414_5.x, var_414_5.y, var_414_5.z)

				local var_414_6 = var_414_0.localEulerAngles

				var_414_6.z = 0
				var_414_6.x = 0
				var_414_0.localEulerAngles = var_414_6
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 then
				var_414_0.localPosition = Vector3.New(0, 100, 0)

				local var_414_7 = manager.ui.mainCamera.transform.position - var_414_0.position

				var_414_0.forward = Vector3.New(var_414_7.x, var_414_7.y, var_414_7.z)

				local var_414_8 = var_414_0.localEulerAngles

				var_414_8.z = 0
				var_414_8.x = 0
				var_414_0.localEulerAngles = var_414_8
			end

			local var_414_9 = arg_411_1.actors_["1058ui_story"]
			local var_414_10 = 0

			if var_414_10 < arg_411_1.time_ and arg_411_1.time_ <= var_414_10 + arg_414_0 and not isNil(var_414_9) and arg_411_1.var_.characterEffect1058ui_story == nil then
				arg_411_1.var_.characterEffect1058ui_story = var_414_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_11 = 0.200000002980232

			if var_414_10 <= arg_411_1.time_ and arg_411_1.time_ < var_414_10 + var_414_11 and not isNil(var_414_9) then
				local var_414_12 = (arg_411_1.time_ - var_414_10) / var_414_11

				if arg_411_1.var_.characterEffect1058ui_story and not isNil(var_414_9) then
					local var_414_13 = Mathf.Lerp(0, 0.5, var_414_12)

					arg_411_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1058ui_story.fillRatio = var_414_13
				end
			end

			if arg_411_1.time_ >= var_414_10 + var_414_11 and arg_411_1.time_ < var_414_10 + var_414_11 + arg_414_0 and not isNil(var_414_9) and arg_411_1.var_.characterEffect1058ui_story then
				local var_414_14 = 0.5

				arg_411_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1058ui_story.fillRatio = var_414_14
			end

			local var_414_15 = 0
			local var_414_16 = 0.875

			if var_414_15 < arg_411_1.time_ and arg_411_1.time_ <= var_414_15 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_17 = arg_411_1:GetWordFromCfg(318301100)
				local var_414_18 = arg_411_1:FormatText(var_414_17.content)

				arg_411_1.text_.text = var_414_18

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_19 = 35
				local var_414_20 = utf8.len(var_414_18)
				local var_414_21 = var_414_19 <= 0 and var_414_16 or var_414_16 * (var_414_20 / var_414_19)

				if var_414_21 > 0 and var_414_16 < var_414_21 then
					arg_411_1.talkMaxDuration = var_414_21

					if var_414_21 + var_414_15 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_21 + var_414_15
					end
				end

				arg_411_1.text_.text = var_414_18
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_22 = math.max(var_414_16, arg_411_1.talkMaxDuration)

			if var_414_15 <= arg_411_1.time_ and arg_411_1.time_ < var_414_15 + var_414_22 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_15) / var_414_22

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_15 + var_414_22 and arg_411_1.time_ < var_414_15 + var_414_22 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play318301101 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 318301101
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play318301102(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0
			local var_418_1 = 0.875

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_2 = arg_415_1:GetWordFromCfg(318301101)
				local var_418_3 = arg_415_1:FormatText(var_418_2.content)

				arg_415_1.text_.text = var_418_3

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_4 = 35
				local var_418_5 = utf8.len(var_418_3)
				local var_418_6 = var_418_4 <= 0 and var_418_1 or var_418_1 * (var_418_5 / var_418_4)

				if var_418_6 > 0 and var_418_1 < var_418_6 then
					arg_415_1.talkMaxDuration = var_418_6

					if var_418_6 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_6 + var_418_0
					end
				end

				arg_415_1.text_.text = var_418_3
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_7 = math.max(var_418_1, arg_415_1.talkMaxDuration)

			if var_418_0 <= arg_415_1.time_ and arg_415_1.time_ < var_418_0 + var_418_7 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_0) / var_418_7

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_0 + var_418_7 and arg_415_1.time_ < var_418_0 + var_418_7 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play318301102 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 318301102
		arg_419_1.duration_ = 2

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play318301103(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["1058ui_story"].transform
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.var_.moveOldPos1058ui_story = var_422_0.localPosition
			end

			local var_422_2 = 0.001

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 then
				local var_422_3 = (arg_419_1.time_ - var_422_1) / var_422_2
				local var_422_4 = Vector3.New(0, -0.95, -5.88)

				var_422_0.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1058ui_story, var_422_4, var_422_3)

				local var_422_5 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_5.x, var_422_5.y, var_422_5.z)

				local var_422_6 = var_422_0.localEulerAngles

				var_422_6.z = 0
				var_422_6.x = 0
				var_422_0.localEulerAngles = var_422_6
			end

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 then
				var_422_0.localPosition = Vector3.New(0, -0.95, -5.88)

				local var_422_7 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_7.x, var_422_7.y, var_422_7.z)

				local var_422_8 = var_422_0.localEulerAngles

				var_422_8.z = 0
				var_422_8.x = 0
				var_422_0.localEulerAngles = var_422_8
			end

			local var_422_9 = arg_419_1.actors_["1058ui_story"]
			local var_422_10 = 0

			if var_422_10 < arg_419_1.time_ and arg_419_1.time_ <= var_422_10 + arg_422_0 and not isNil(var_422_9) and arg_419_1.var_.characterEffect1058ui_story == nil then
				arg_419_1.var_.characterEffect1058ui_story = var_422_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_11 = 0.200000002980232

			if var_422_10 <= arg_419_1.time_ and arg_419_1.time_ < var_422_10 + var_422_11 and not isNil(var_422_9) then
				local var_422_12 = (arg_419_1.time_ - var_422_10) / var_422_11

				if arg_419_1.var_.characterEffect1058ui_story and not isNil(var_422_9) then
					arg_419_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= var_422_10 + var_422_11 and arg_419_1.time_ < var_422_10 + var_422_11 + arg_422_0 and not isNil(var_422_9) and arg_419_1.var_.characterEffect1058ui_story then
				arg_419_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_422_13 = 0

			if var_422_13 < arg_419_1.time_ and arg_419_1.time_ <= var_422_13 + arg_422_0 then
				arg_419_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			local var_422_14 = 0

			if var_422_14 < arg_419_1.time_ and arg_419_1.time_ <= var_422_14 + arg_422_0 then
				arg_419_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_422_15 = 0
			local var_422_16 = 0.125

			if var_422_15 < arg_419_1.time_ and arg_419_1.time_ <= var_422_15 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_17 = arg_419_1:FormatText(StoryNameCfg[92].name)

				arg_419_1.leftNameTxt_.text = var_422_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_18 = arg_419_1:GetWordFromCfg(318301102)
				local var_422_19 = arg_419_1:FormatText(var_422_18.content)

				arg_419_1.text_.text = var_422_19

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_20 = 5
				local var_422_21 = utf8.len(var_422_19)
				local var_422_22 = var_422_20 <= 0 and var_422_16 or var_422_16 * (var_422_21 / var_422_20)

				if var_422_22 > 0 and var_422_16 < var_422_22 then
					arg_419_1.talkMaxDuration = var_422_22

					if var_422_22 + var_422_15 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_22 + var_422_15
					end
				end

				arg_419_1.text_.text = var_422_19
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301102", "story_v_out_318301.awb") ~= 0 then
					local var_422_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301102", "story_v_out_318301.awb") / 1000

					if var_422_23 + var_422_15 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_23 + var_422_15
					end

					if var_422_18.prefab_name ~= "" and arg_419_1.actors_[var_422_18.prefab_name] ~= nil then
						local var_422_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_18.prefab_name].transform, "story_v_out_318301", "318301102", "story_v_out_318301.awb")

						arg_419_1:RecordAudio("318301102", var_422_24)
						arg_419_1:RecordAudio("318301102", var_422_24)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_318301", "318301102", "story_v_out_318301.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_318301", "318301102", "story_v_out_318301.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_25 = math.max(var_422_16, arg_419_1.talkMaxDuration)

			if var_422_15 <= arg_419_1.time_ and arg_419_1.time_ < var_422_15 + var_422_25 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_15) / var_422_25

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_15 + var_422_25 and arg_419_1.time_ < var_422_15 + var_422_25 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play318301103 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 318301103
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play318301104(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["1058ui_story"].transform
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
				arg_423_1.var_.moveOldPos1058ui_story = var_426_0.localPosition
			end

			local var_426_2 = 0.001

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2
				local var_426_4 = Vector3.New(0, 100, 0)

				var_426_0.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1058ui_story, var_426_4, var_426_3)

				local var_426_5 = manager.ui.mainCamera.transform.position - var_426_0.position

				var_426_0.forward = Vector3.New(var_426_5.x, var_426_5.y, var_426_5.z)

				local var_426_6 = var_426_0.localEulerAngles

				var_426_6.z = 0
				var_426_6.x = 0
				var_426_0.localEulerAngles = var_426_6
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 then
				var_426_0.localPosition = Vector3.New(0, 100, 0)

				local var_426_7 = manager.ui.mainCamera.transform.position - var_426_0.position

				var_426_0.forward = Vector3.New(var_426_7.x, var_426_7.y, var_426_7.z)

				local var_426_8 = var_426_0.localEulerAngles

				var_426_8.z = 0
				var_426_8.x = 0
				var_426_0.localEulerAngles = var_426_8
			end

			local var_426_9 = arg_423_1.actors_["1058ui_story"]
			local var_426_10 = 0

			if var_426_10 < arg_423_1.time_ and arg_423_1.time_ <= var_426_10 + arg_426_0 and not isNil(var_426_9) and arg_423_1.var_.characterEffect1058ui_story == nil then
				arg_423_1.var_.characterEffect1058ui_story = var_426_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_11 = 0.200000002980232

			if var_426_10 <= arg_423_1.time_ and arg_423_1.time_ < var_426_10 + var_426_11 and not isNil(var_426_9) then
				local var_426_12 = (arg_423_1.time_ - var_426_10) / var_426_11

				if arg_423_1.var_.characterEffect1058ui_story and not isNil(var_426_9) then
					local var_426_13 = Mathf.Lerp(0, 0.5, var_426_12)

					arg_423_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1058ui_story.fillRatio = var_426_13
				end
			end

			if arg_423_1.time_ >= var_426_10 + var_426_11 and arg_423_1.time_ < var_426_10 + var_426_11 + arg_426_0 and not isNil(var_426_9) and arg_423_1.var_.characterEffect1058ui_story then
				local var_426_14 = 0.5

				arg_423_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1058ui_story.fillRatio = var_426_14
			end

			local var_426_15 = 0
			local var_426_16 = 0.575

			if var_426_15 < arg_423_1.time_ and arg_423_1.time_ <= var_426_15 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_17 = arg_423_1:GetWordFromCfg(318301103)
				local var_426_18 = arg_423_1:FormatText(var_426_17.content)

				arg_423_1.text_.text = var_426_18

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_19 = 23
				local var_426_20 = utf8.len(var_426_18)
				local var_426_21 = var_426_19 <= 0 and var_426_16 or var_426_16 * (var_426_20 / var_426_19)

				if var_426_21 > 0 and var_426_16 < var_426_21 then
					arg_423_1.talkMaxDuration = var_426_21

					if var_426_21 + var_426_15 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_21 + var_426_15
					end
				end

				arg_423_1.text_.text = var_426_18
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_22 = math.max(var_426_16, arg_423_1.talkMaxDuration)

			if var_426_15 <= arg_423_1.time_ and arg_423_1.time_ < var_426_15 + var_426_22 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_15) / var_426_22

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_15 + var_426_22 and arg_423_1.time_ < var_426_15 + var_426_22 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play318301104 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 318301104
		arg_427_1.duration_ = 2.7

		local var_427_0 = {
			zh = 2.6,
			ja = 2.7
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play318301105(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["1058ui_story"].transform
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
				arg_427_1.var_.moveOldPos1058ui_story = var_430_0.localPosition
			end

			local var_430_2 = 0.001

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_2 then
				local var_430_3 = (arg_427_1.time_ - var_430_1) / var_430_2
				local var_430_4 = Vector3.New(0, -0.95, -5.88)

				var_430_0.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1058ui_story, var_430_4, var_430_3)

				local var_430_5 = manager.ui.mainCamera.transform.position - var_430_0.position

				var_430_0.forward = Vector3.New(var_430_5.x, var_430_5.y, var_430_5.z)

				local var_430_6 = var_430_0.localEulerAngles

				var_430_6.z = 0
				var_430_6.x = 0
				var_430_0.localEulerAngles = var_430_6
			end

			if arg_427_1.time_ >= var_430_1 + var_430_2 and arg_427_1.time_ < var_430_1 + var_430_2 + arg_430_0 then
				var_430_0.localPosition = Vector3.New(0, -0.95, -5.88)

				local var_430_7 = manager.ui.mainCamera.transform.position - var_430_0.position

				var_430_0.forward = Vector3.New(var_430_7.x, var_430_7.y, var_430_7.z)

				local var_430_8 = var_430_0.localEulerAngles

				var_430_8.z = 0
				var_430_8.x = 0
				var_430_0.localEulerAngles = var_430_8
			end

			local var_430_9 = arg_427_1.actors_["1058ui_story"]
			local var_430_10 = 0

			if var_430_10 < arg_427_1.time_ and arg_427_1.time_ <= var_430_10 + arg_430_0 and not isNil(var_430_9) and arg_427_1.var_.characterEffect1058ui_story == nil then
				arg_427_1.var_.characterEffect1058ui_story = var_430_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_11 = 0.200000002980232

			if var_430_10 <= arg_427_1.time_ and arg_427_1.time_ < var_430_10 + var_430_11 and not isNil(var_430_9) then
				local var_430_12 = (arg_427_1.time_ - var_430_10) / var_430_11

				if arg_427_1.var_.characterEffect1058ui_story and not isNil(var_430_9) then
					arg_427_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= var_430_10 + var_430_11 and arg_427_1.time_ < var_430_10 + var_430_11 + arg_430_0 and not isNil(var_430_9) and arg_427_1.var_.characterEffect1058ui_story then
				arg_427_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_430_13 = 0

			if var_430_13 < arg_427_1.time_ and arg_427_1.time_ <= var_430_13 + arg_430_0 then
				arg_427_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			local var_430_14 = 0

			if var_430_14 < arg_427_1.time_ and arg_427_1.time_ <= var_430_14 + arg_430_0 then
				arg_427_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_430_15 = 0
			local var_430_16 = 0.175

			if var_430_15 < arg_427_1.time_ and arg_427_1.time_ <= var_430_15 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_17 = arg_427_1:FormatText(StoryNameCfg[92].name)

				arg_427_1.leftNameTxt_.text = var_430_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_18 = arg_427_1:GetWordFromCfg(318301104)
				local var_430_19 = arg_427_1:FormatText(var_430_18.content)

				arg_427_1.text_.text = var_430_19

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_20 = 7
				local var_430_21 = utf8.len(var_430_19)
				local var_430_22 = var_430_20 <= 0 and var_430_16 or var_430_16 * (var_430_21 / var_430_20)

				if var_430_22 > 0 and var_430_16 < var_430_22 then
					arg_427_1.talkMaxDuration = var_430_22

					if var_430_22 + var_430_15 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_22 + var_430_15
					end
				end

				arg_427_1.text_.text = var_430_19
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301104", "story_v_out_318301.awb") ~= 0 then
					local var_430_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301104", "story_v_out_318301.awb") / 1000

					if var_430_23 + var_430_15 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_23 + var_430_15
					end

					if var_430_18.prefab_name ~= "" and arg_427_1.actors_[var_430_18.prefab_name] ~= nil then
						local var_430_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_18.prefab_name].transform, "story_v_out_318301", "318301104", "story_v_out_318301.awb")

						arg_427_1:RecordAudio("318301104", var_430_24)
						arg_427_1:RecordAudio("318301104", var_430_24)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_318301", "318301104", "story_v_out_318301.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_318301", "318301104", "story_v_out_318301.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_25 = math.max(var_430_16, arg_427_1.talkMaxDuration)

			if var_430_15 <= arg_427_1.time_ and arg_427_1.time_ < var_430_15 + var_430_25 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_15) / var_430_25

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_15 + var_430_25 and arg_427_1.time_ < var_430_15 + var_430_25 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play318301105 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 318301105
		arg_431_1.duration_ = 9

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play318301106(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = "K06g"

			if arg_431_1.bgs_[var_434_0] == nil then
				local var_434_1 = Object.Instantiate(arg_431_1.paintGo_)

				var_434_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_434_0)
				var_434_1.name = var_434_0
				var_434_1.transform.parent = arg_431_1.stage_.transform
				var_434_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_431_1.bgs_[var_434_0] = var_434_1
			end

			local var_434_2 = 2

			if var_434_2 < arg_431_1.time_ and arg_431_1.time_ <= var_434_2 + arg_434_0 then
				local var_434_3 = manager.ui.mainCamera.transform.localPosition
				local var_434_4 = Vector3.New(0, 0, 10) + Vector3.New(var_434_3.x, var_434_3.y, 0)
				local var_434_5 = arg_431_1.bgs_.K06g

				var_434_5.transform.localPosition = var_434_4
				var_434_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_434_6 = var_434_5:GetComponent("SpriteRenderer")

				if var_434_6 and var_434_6.sprite then
					local var_434_7 = (var_434_5.transform.localPosition - var_434_3).z
					local var_434_8 = manager.ui.mainCameraCom_
					local var_434_9 = 2 * var_434_7 * Mathf.Tan(var_434_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_434_10 = var_434_9 * var_434_8.aspect
					local var_434_11 = var_434_6.sprite.bounds.size.x
					local var_434_12 = var_434_6.sprite.bounds.size.y
					local var_434_13 = var_434_10 / var_434_11
					local var_434_14 = var_434_9 / var_434_12
					local var_434_15 = var_434_14 < var_434_13 and var_434_13 or var_434_14

					var_434_5.transform.localScale = Vector3.New(var_434_15, var_434_15, 0)
				end

				for iter_434_0, iter_434_1 in pairs(arg_431_1.bgs_) do
					if iter_434_0 ~= "K06g" then
						iter_434_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_434_16 = 0

			if var_434_16 < arg_431_1.time_ and arg_431_1.time_ <= var_434_16 + arg_434_0 then
				arg_431_1.mask_.enabled = true
				arg_431_1.mask_.raycastTarget = true

				arg_431_1:SetGaussion(false)
			end

			local var_434_17 = 2

			if var_434_16 <= arg_431_1.time_ and arg_431_1.time_ < var_434_16 + var_434_17 then
				local var_434_18 = (arg_431_1.time_ - var_434_16) / var_434_17
				local var_434_19 = Color.New(0, 0, 0)

				var_434_19.a = Mathf.Lerp(0, 1, var_434_18)
				arg_431_1.mask_.color = var_434_19
			end

			if arg_431_1.time_ >= var_434_16 + var_434_17 and arg_431_1.time_ < var_434_16 + var_434_17 + arg_434_0 then
				local var_434_20 = Color.New(0, 0, 0)

				var_434_20.a = 1
				arg_431_1.mask_.color = var_434_20
			end

			local var_434_21 = 2

			if var_434_21 < arg_431_1.time_ and arg_431_1.time_ <= var_434_21 + arg_434_0 then
				arg_431_1.mask_.enabled = true
				arg_431_1.mask_.raycastTarget = true

				arg_431_1:SetGaussion(false)
			end

			local var_434_22 = 2

			if var_434_21 <= arg_431_1.time_ and arg_431_1.time_ < var_434_21 + var_434_22 then
				local var_434_23 = (arg_431_1.time_ - var_434_21) / var_434_22
				local var_434_24 = Color.New(0, 0, 0)

				var_434_24.a = Mathf.Lerp(1, 0, var_434_23)
				arg_431_1.mask_.color = var_434_24
			end

			if arg_431_1.time_ >= var_434_21 + var_434_22 and arg_431_1.time_ < var_434_21 + var_434_22 + arg_434_0 then
				local var_434_25 = Color.New(0, 0, 0)
				local var_434_26 = 0

				arg_431_1.mask_.enabled = false
				var_434_25.a = var_434_26
				arg_431_1.mask_.color = var_434_25
			end

			local var_434_27 = arg_431_1.actors_["1058ui_story"].transform
			local var_434_28 = 1.96599999815226

			if var_434_28 < arg_431_1.time_ and arg_431_1.time_ <= var_434_28 + arg_434_0 then
				arg_431_1.var_.moveOldPos1058ui_story = var_434_27.localPosition
			end

			local var_434_29 = 0.001

			if var_434_28 <= arg_431_1.time_ and arg_431_1.time_ < var_434_28 + var_434_29 then
				local var_434_30 = (arg_431_1.time_ - var_434_28) / var_434_29
				local var_434_31 = Vector3.New(0, 100, 0)

				var_434_27.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1058ui_story, var_434_31, var_434_30)

				local var_434_32 = manager.ui.mainCamera.transform.position - var_434_27.position

				var_434_27.forward = Vector3.New(var_434_32.x, var_434_32.y, var_434_32.z)

				local var_434_33 = var_434_27.localEulerAngles

				var_434_33.z = 0
				var_434_33.x = 0
				var_434_27.localEulerAngles = var_434_33
			end

			if arg_431_1.time_ >= var_434_28 + var_434_29 and arg_431_1.time_ < var_434_28 + var_434_29 + arg_434_0 then
				var_434_27.localPosition = Vector3.New(0, 100, 0)

				local var_434_34 = manager.ui.mainCamera.transform.position - var_434_27.position

				var_434_27.forward = Vector3.New(var_434_34.x, var_434_34.y, var_434_34.z)

				local var_434_35 = var_434_27.localEulerAngles

				var_434_35.z = 0
				var_434_35.x = 0
				var_434_27.localEulerAngles = var_434_35
			end

			local var_434_36 = arg_431_1.actors_["1058ui_story"]
			local var_434_37 = 1.96599999815226

			if var_434_37 < arg_431_1.time_ and arg_431_1.time_ <= var_434_37 + arg_434_0 and not isNil(var_434_36) and arg_431_1.var_.characterEffect1058ui_story == nil then
				arg_431_1.var_.characterEffect1058ui_story = var_434_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_38 = 0.034000001847744

			if var_434_37 <= arg_431_1.time_ and arg_431_1.time_ < var_434_37 + var_434_38 and not isNil(var_434_36) then
				local var_434_39 = (arg_431_1.time_ - var_434_37) / var_434_38

				if arg_431_1.var_.characterEffect1058ui_story and not isNil(var_434_36) then
					local var_434_40 = Mathf.Lerp(0, 0.5, var_434_39)

					arg_431_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1058ui_story.fillRatio = var_434_40
				end
			end

			if arg_431_1.time_ >= var_434_37 + var_434_38 and arg_431_1.time_ < var_434_37 + var_434_38 + arg_434_0 and not isNil(var_434_36) and arg_431_1.var_.characterEffect1058ui_story then
				local var_434_41 = 0.5

				arg_431_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1058ui_story.fillRatio = var_434_41
			end

			local var_434_42 = 3.23333333333333
			local var_434_43 = 1

			if var_434_42 < arg_431_1.time_ and arg_431_1.time_ <= var_434_42 + arg_434_0 then
				local var_434_44 = "play"
				local var_434_45 = "effect"

				arg_431_1:AudioAction(var_434_44, var_434_45, "se_story_221_00", "se_story_221_00_firework_loop", "")
			end

			if arg_431_1.frameCnt_ <= 1 then
				arg_431_1.dialog_:SetActive(false)
			end

			local var_434_46 = 4
			local var_434_47 = 1.35

			if var_434_46 < arg_431_1.time_ and arg_431_1.time_ <= var_434_46 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0

				arg_431_1.dialog_:SetActive(true)

				arg_431_1.dialogCg_.alpha = 0

				local var_434_48 = LeanTween.value(arg_431_1.dialog_, 0, 1, 0.3)

				var_434_48:setOnUpdate(LuaHelper.FloatAction(function(arg_435_0)
					arg_431_1.dialogCg_.alpha = arg_435_0
				end))
				var_434_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_431_1.dialog_)
					var_434_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_431_1.duration_ = arg_431_1.duration_ + 0.3

				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_49 = arg_431_1:GetWordFromCfg(318301105)
				local var_434_50 = arg_431_1:FormatText(var_434_49.content)

				arg_431_1.text_.text = var_434_50

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_51 = 54
				local var_434_52 = utf8.len(var_434_50)
				local var_434_53 = var_434_51 <= 0 and var_434_47 or var_434_47 * (var_434_52 / var_434_51)

				if var_434_53 > 0 and var_434_47 < var_434_53 then
					arg_431_1.talkMaxDuration = var_434_53
					var_434_46 = var_434_46 + 0.3

					if var_434_53 + var_434_46 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_53 + var_434_46
					end
				end

				arg_431_1.text_.text = var_434_50
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_54 = var_434_46 + 0.3
			local var_434_55 = math.max(var_434_47, arg_431_1.talkMaxDuration)

			if var_434_54 <= arg_431_1.time_ and arg_431_1.time_ < var_434_54 + var_434_55 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_54) / var_434_55

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_54 + var_434_55 and arg_431_1.time_ < var_434_54 + var_434_55 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_431_1:InitPlayNodeList()
	end,
	Play318301106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 318301106
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play318301107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0
			local var_440_1 = 0.533333333333333

			if var_440_0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_0 + arg_440_0 then
				local var_440_2 = "play"
				local var_440_3 = "effect"

				arg_437_1:AudioAction(var_440_2, var_440_3, "se_story_221_00", "se_story_221_00_firework", "")
			end

			local var_440_4 = 0
			local var_440_5 = 0.775

			if var_440_4 < arg_437_1.time_ and arg_437_1.time_ <= var_440_4 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_6 = arg_437_1:GetWordFromCfg(318301106)
				local var_440_7 = arg_437_1:FormatText(var_440_6.content)

				arg_437_1.text_.text = var_440_7

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_8 = 31
				local var_440_9 = utf8.len(var_440_7)
				local var_440_10 = var_440_8 <= 0 and var_440_5 or var_440_5 * (var_440_9 / var_440_8)

				if var_440_10 > 0 and var_440_5 < var_440_10 then
					arg_437_1.talkMaxDuration = var_440_10

					if var_440_10 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_10 + var_440_4
					end
				end

				arg_437_1.text_.text = var_440_7
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_11 = math.max(var_440_5, arg_437_1.talkMaxDuration)

			if var_440_4 <= arg_437_1.time_ and arg_437_1.time_ < var_440_4 + var_440_11 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_4) / var_440_11

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_4 + var_440_11 and arg_437_1.time_ < var_440_4 + var_440_11 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play318301107 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 318301107
		arg_441_1.duration_ = 4.7

		local var_441_0 = {
			zh = 3.2,
			ja = 4.7
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play318301108(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = arg_441_1.actors_["1055ui_story"].transform
			local var_444_1 = 0

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 then
				arg_441_1.var_.moveOldPos1055ui_story = var_444_0.localPosition
			end

			local var_444_2 = 0.001

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_2 then
				local var_444_3 = (arg_441_1.time_ - var_444_1) / var_444_2
				local var_444_4 = Vector3.New(0, -0.965, -6.2)

				var_444_0.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos1055ui_story, var_444_4, var_444_3)

				local var_444_5 = manager.ui.mainCamera.transform.position - var_444_0.position

				var_444_0.forward = Vector3.New(var_444_5.x, var_444_5.y, var_444_5.z)

				local var_444_6 = var_444_0.localEulerAngles

				var_444_6.z = 0
				var_444_6.x = 0
				var_444_0.localEulerAngles = var_444_6
			end

			if arg_441_1.time_ >= var_444_1 + var_444_2 and arg_441_1.time_ < var_444_1 + var_444_2 + arg_444_0 then
				var_444_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_444_7 = manager.ui.mainCamera.transform.position - var_444_0.position

				var_444_0.forward = Vector3.New(var_444_7.x, var_444_7.y, var_444_7.z)

				local var_444_8 = var_444_0.localEulerAngles

				var_444_8.z = 0
				var_444_8.x = 0
				var_444_0.localEulerAngles = var_444_8
			end

			local var_444_9 = arg_441_1.actors_["1055ui_story"]
			local var_444_10 = 0

			if var_444_10 < arg_441_1.time_ and arg_441_1.time_ <= var_444_10 + arg_444_0 and not isNil(var_444_9) and arg_441_1.var_.characterEffect1055ui_story == nil then
				arg_441_1.var_.characterEffect1055ui_story = var_444_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_11 = 0.200000002980232

			if var_444_10 <= arg_441_1.time_ and arg_441_1.time_ < var_444_10 + var_444_11 and not isNil(var_444_9) then
				local var_444_12 = (arg_441_1.time_ - var_444_10) / var_444_11

				if arg_441_1.var_.characterEffect1055ui_story and not isNil(var_444_9) then
					arg_441_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= var_444_10 + var_444_11 and arg_441_1.time_ < var_444_10 + var_444_11 + arg_444_0 and not isNil(var_444_9) and arg_441_1.var_.characterEffect1055ui_story then
				arg_441_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_444_13 = 0

			if var_444_13 < arg_441_1.time_ and arg_441_1.time_ <= var_444_13 + arg_444_0 then
				arg_441_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_444_14 = 0

			if var_444_14 < arg_441_1.time_ and arg_441_1.time_ <= var_444_14 + arg_444_0 then
				arg_441_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_444_15 = 0
			local var_444_16 = 0.4

			if var_444_15 < arg_441_1.time_ and arg_441_1.time_ <= var_444_15 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_17 = arg_441_1:FormatText(StoryNameCfg[481].name)

				arg_441_1.leftNameTxt_.text = var_444_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_18 = arg_441_1:GetWordFromCfg(318301107)
				local var_444_19 = arg_441_1:FormatText(var_444_18.content)

				arg_441_1.text_.text = var_444_19

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_20 = 16
				local var_444_21 = utf8.len(var_444_19)
				local var_444_22 = var_444_20 <= 0 and var_444_16 or var_444_16 * (var_444_21 / var_444_20)

				if var_444_22 > 0 and var_444_16 < var_444_22 then
					arg_441_1.talkMaxDuration = var_444_22

					if var_444_22 + var_444_15 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_22 + var_444_15
					end
				end

				arg_441_1.text_.text = var_444_19
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301107", "story_v_out_318301.awb") ~= 0 then
					local var_444_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301107", "story_v_out_318301.awb") / 1000

					if var_444_23 + var_444_15 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_23 + var_444_15
					end

					if var_444_18.prefab_name ~= "" and arg_441_1.actors_[var_444_18.prefab_name] ~= nil then
						local var_444_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_18.prefab_name].transform, "story_v_out_318301", "318301107", "story_v_out_318301.awb")

						arg_441_1:RecordAudio("318301107", var_444_24)
						arg_441_1:RecordAudio("318301107", var_444_24)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_318301", "318301107", "story_v_out_318301.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_318301", "318301107", "story_v_out_318301.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_25 = math.max(var_444_16, arg_441_1.talkMaxDuration)

			if var_444_15 <= arg_441_1.time_ and arg_441_1.time_ < var_444_15 + var_444_25 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_15) / var_444_25

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_15 + var_444_25 and arg_441_1.time_ < var_444_15 + var_444_25 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play318301108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 318301108
		arg_445_1.duration_ = 5.47

		local var_445_0 = {
			zh = 5.466,
			ja = 2.9
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play318301109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				arg_445_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_448_1 = 0

			if var_448_1 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_448_2 = 0
			local var_448_3 = 0.45

			if var_448_2 < arg_445_1.time_ and arg_445_1.time_ <= var_448_2 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_4 = arg_445_1:FormatText(StoryNameCfg[481].name)

				arg_445_1.leftNameTxt_.text = var_448_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_5 = arg_445_1:GetWordFromCfg(318301108)
				local var_448_6 = arg_445_1:FormatText(var_448_5.content)

				arg_445_1.text_.text = var_448_6

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_7 = 18
				local var_448_8 = utf8.len(var_448_6)
				local var_448_9 = var_448_7 <= 0 and var_448_3 or var_448_3 * (var_448_8 / var_448_7)

				if var_448_9 > 0 and var_448_3 < var_448_9 then
					arg_445_1.talkMaxDuration = var_448_9

					if var_448_9 + var_448_2 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_9 + var_448_2
					end
				end

				arg_445_1.text_.text = var_448_6
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301108", "story_v_out_318301.awb") ~= 0 then
					local var_448_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301108", "story_v_out_318301.awb") / 1000

					if var_448_10 + var_448_2 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_10 + var_448_2
					end

					if var_448_5.prefab_name ~= "" and arg_445_1.actors_[var_448_5.prefab_name] ~= nil then
						local var_448_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_5.prefab_name].transform, "story_v_out_318301", "318301108", "story_v_out_318301.awb")

						arg_445_1:RecordAudio("318301108", var_448_11)
						arg_445_1:RecordAudio("318301108", var_448_11)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_318301", "318301108", "story_v_out_318301.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_318301", "318301108", "story_v_out_318301.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_12 = math.max(var_448_3, arg_445_1.talkMaxDuration)

			if var_448_2 <= arg_445_1.time_ and arg_445_1.time_ < var_448_2 + var_448_12 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_2) / var_448_12

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_2 + var_448_12 and arg_445_1.time_ < var_448_2 + var_448_12 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play318301109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 318301109
		arg_449_1.duration_ = 2.93

		local var_449_0 = {
			zh = 2.933,
			ja = 2.366
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play318301110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["1049ui_story"].transform
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.var_.moveOldPos1049ui_story = var_452_0.localPosition
			end

			local var_452_2 = 0.001

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2
				local var_452_4 = Vector3.New(0, -1.2, -6)

				var_452_0.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1049ui_story, var_452_4, var_452_3)

				local var_452_5 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_5.x, var_452_5.y, var_452_5.z)

				local var_452_6 = var_452_0.localEulerAngles

				var_452_6.z = 0
				var_452_6.x = 0
				var_452_0.localEulerAngles = var_452_6
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 then
				var_452_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_452_7 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_7.x, var_452_7.y, var_452_7.z)

				local var_452_8 = var_452_0.localEulerAngles

				var_452_8.z = 0
				var_452_8.x = 0
				var_452_0.localEulerAngles = var_452_8
			end

			local var_452_9 = arg_449_1.actors_["1049ui_story"]
			local var_452_10 = 0

			if var_452_10 < arg_449_1.time_ and arg_449_1.time_ <= var_452_10 + arg_452_0 and not isNil(var_452_9) and arg_449_1.var_.characterEffect1049ui_story == nil then
				arg_449_1.var_.characterEffect1049ui_story = var_452_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_11 = 0.200000002980232

			if var_452_10 <= arg_449_1.time_ and arg_449_1.time_ < var_452_10 + var_452_11 and not isNil(var_452_9) then
				local var_452_12 = (arg_449_1.time_ - var_452_10) / var_452_11

				if arg_449_1.var_.characterEffect1049ui_story and not isNil(var_452_9) then
					arg_449_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= var_452_10 + var_452_11 and arg_449_1.time_ < var_452_10 + var_452_11 + arg_452_0 and not isNil(var_452_9) and arg_449_1.var_.characterEffect1049ui_story then
				arg_449_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_452_13 = 0

			if var_452_13 < arg_449_1.time_ and arg_449_1.time_ <= var_452_13 + arg_452_0 then
				arg_449_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_452_14 = 0

			if var_452_14 < arg_449_1.time_ and arg_449_1.time_ <= var_452_14 + arg_452_0 then
				arg_449_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_452_15 = arg_449_1.actors_["1055ui_story"].transform
			local var_452_16 = 0

			if var_452_16 < arg_449_1.time_ and arg_449_1.time_ <= var_452_16 + arg_452_0 then
				arg_449_1.var_.moveOldPos1055ui_story = var_452_15.localPosition
			end

			local var_452_17 = 0.001

			if var_452_16 <= arg_449_1.time_ and arg_449_1.time_ < var_452_16 + var_452_17 then
				local var_452_18 = (arg_449_1.time_ - var_452_16) / var_452_17
				local var_452_19 = Vector3.New(0, 100, 0)

				var_452_15.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1055ui_story, var_452_19, var_452_18)

				local var_452_20 = manager.ui.mainCamera.transform.position - var_452_15.position

				var_452_15.forward = Vector3.New(var_452_20.x, var_452_20.y, var_452_20.z)

				local var_452_21 = var_452_15.localEulerAngles

				var_452_21.z = 0
				var_452_21.x = 0
				var_452_15.localEulerAngles = var_452_21
			end

			if arg_449_1.time_ >= var_452_16 + var_452_17 and arg_449_1.time_ < var_452_16 + var_452_17 + arg_452_0 then
				var_452_15.localPosition = Vector3.New(0, 100, 0)

				local var_452_22 = manager.ui.mainCamera.transform.position - var_452_15.position

				var_452_15.forward = Vector3.New(var_452_22.x, var_452_22.y, var_452_22.z)

				local var_452_23 = var_452_15.localEulerAngles

				var_452_23.z = 0
				var_452_23.x = 0
				var_452_15.localEulerAngles = var_452_23
			end

			local var_452_24 = arg_449_1.actors_["1055ui_story"]
			local var_452_25 = 0

			if var_452_25 < arg_449_1.time_ and arg_449_1.time_ <= var_452_25 + arg_452_0 and not isNil(var_452_24) and arg_449_1.var_.characterEffect1055ui_story == nil then
				arg_449_1.var_.characterEffect1055ui_story = var_452_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_26 = 0.200000002980232

			if var_452_25 <= arg_449_1.time_ and arg_449_1.time_ < var_452_25 + var_452_26 and not isNil(var_452_24) then
				local var_452_27 = (arg_449_1.time_ - var_452_25) / var_452_26

				if arg_449_1.var_.characterEffect1055ui_story and not isNil(var_452_24) then
					local var_452_28 = Mathf.Lerp(0, 0.5, var_452_27)

					arg_449_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_449_1.var_.characterEffect1055ui_story.fillRatio = var_452_28
				end
			end

			if arg_449_1.time_ >= var_452_25 + var_452_26 and arg_449_1.time_ < var_452_25 + var_452_26 + arg_452_0 and not isNil(var_452_24) and arg_449_1.var_.characterEffect1055ui_story then
				local var_452_29 = 0.5

				arg_449_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_449_1.var_.characterEffect1055ui_story.fillRatio = var_452_29
			end

			local var_452_30 = 0
			local var_452_31 = 0.175

			if var_452_30 < arg_449_1.time_ and arg_449_1.time_ <= var_452_30 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_32 = arg_449_1:FormatText(StoryNameCfg[562].name)

				arg_449_1.leftNameTxt_.text = var_452_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_33 = arg_449_1:GetWordFromCfg(318301109)
				local var_452_34 = arg_449_1:FormatText(var_452_33.content)

				arg_449_1.text_.text = var_452_34

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_35 = 7
				local var_452_36 = utf8.len(var_452_34)
				local var_452_37 = var_452_35 <= 0 and var_452_31 or var_452_31 * (var_452_36 / var_452_35)

				if var_452_37 > 0 and var_452_31 < var_452_37 then
					arg_449_1.talkMaxDuration = var_452_37

					if var_452_37 + var_452_30 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_37 + var_452_30
					end
				end

				arg_449_1.text_.text = var_452_34
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301109", "story_v_out_318301.awb") ~= 0 then
					local var_452_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301109", "story_v_out_318301.awb") / 1000

					if var_452_38 + var_452_30 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_38 + var_452_30
					end

					if var_452_33.prefab_name ~= "" and arg_449_1.actors_[var_452_33.prefab_name] ~= nil then
						local var_452_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_33.prefab_name].transform, "story_v_out_318301", "318301109", "story_v_out_318301.awb")

						arg_449_1:RecordAudio("318301109", var_452_39)
						arg_449_1:RecordAudio("318301109", var_452_39)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_318301", "318301109", "story_v_out_318301.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_318301", "318301109", "story_v_out_318301.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_40 = math.max(var_452_31, arg_449_1.talkMaxDuration)

			if var_452_30 <= arg_449_1.time_ and arg_449_1.time_ < var_452_30 + var_452_40 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_30) / var_452_40

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_30 + var_452_40 and arg_449_1.time_ < var_452_30 + var_452_40 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play318301110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 318301110
		arg_453_1.duration_ = 3.9

		local var_453_0 = {
			zh = 3.433,
			ja = 3.9
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play318301111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0

			if var_456_0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_456_1 = 0

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_456_2 = 0
			local var_456_3 = 0.325

			if var_456_2 < arg_453_1.time_ and arg_453_1.time_ <= var_456_2 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_4 = arg_453_1:FormatText(StoryNameCfg[562].name)

				arg_453_1.leftNameTxt_.text = var_456_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_5 = arg_453_1:GetWordFromCfg(318301110)
				local var_456_6 = arg_453_1:FormatText(var_456_5.content)

				arg_453_1.text_.text = var_456_6

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_7 = 13
				local var_456_8 = utf8.len(var_456_6)
				local var_456_9 = var_456_7 <= 0 and var_456_3 or var_456_3 * (var_456_8 / var_456_7)

				if var_456_9 > 0 and var_456_3 < var_456_9 then
					arg_453_1.talkMaxDuration = var_456_9

					if var_456_9 + var_456_2 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_9 + var_456_2
					end
				end

				arg_453_1.text_.text = var_456_6
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301110", "story_v_out_318301.awb") ~= 0 then
					local var_456_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301110", "story_v_out_318301.awb") / 1000

					if var_456_10 + var_456_2 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_10 + var_456_2
					end

					if var_456_5.prefab_name ~= "" and arg_453_1.actors_[var_456_5.prefab_name] ~= nil then
						local var_456_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_5.prefab_name].transform, "story_v_out_318301", "318301110", "story_v_out_318301.awb")

						arg_453_1:RecordAudio("318301110", var_456_11)
						arg_453_1:RecordAudio("318301110", var_456_11)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_318301", "318301110", "story_v_out_318301.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_318301", "318301110", "story_v_out_318301.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_12 = math.max(var_456_3, arg_453_1.talkMaxDuration)

			if var_456_2 <= arg_453_1.time_ and arg_453_1.time_ < var_456_2 + var_456_12 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_2) / var_456_12

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_2 + var_456_12 and arg_453_1.time_ < var_456_2 + var_456_12 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play318301111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 318301111
		arg_457_1.duration_ = 6.8

		local var_457_0 = {
			zh = 6.8,
			ja = 3.3
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play318301112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_460_1 = 0

			if var_460_1 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 then
				arg_457_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_460_2 = 0
			local var_460_3 = 0.475

			if var_460_2 < arg_457_1.time_ and arg_457_1.time_ <= var_460_2 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_4 = arg_457_1:FormatText(StoryNameCfg[562].name)

				arg_457_1.leftNameTxt_.text = var_460_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_5 = arg_457_1:GetWordFromCfg(318301111)
				local var_460_6 = arg_457_1:FormatText(var_460_5.content)

				arg_457_1.text_.text = var_460_6

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_7 = 19
				local var_460_8 = utf8.len(var_460_6)
				local var_460_9 = var_460_7 <= 0 and var_460_3 or var_460_3 * (var_460_8 / var_460_7)

				if var_460_9 > 0 and var_460_3 < var_460_9 then
					arg_457_1.talkMaxDuration = var_460_9

					if var_460_9 + var_460_2 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_9 + var_460_2
					end
				end

				arg_457_1.text_.text = var_460_6
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301111", "story_v_out_318301.awb") ~= 0 then
					local var_460_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301111", "story_v_out_318301.awb") / 1000

					if var_460_10 + var_460_2 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_10 + var_460_2
					end

					if var_460_5.prefab_name ~= "" and arg_457_1.actors_[var_460_5.prefab_name] ~= nil then
						local var_460_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_5.prefab_name].transform, "story_v_out_318301", "318301111", "story_v_out_318301.awb")

						arg_457_1:RecordAudio("318301111", var_460_11)
						arg_457_1:RecordAudio("318301111", var_460_11)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_318301", "318301111", "story_v_out_318301.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_318301", "318301111", "story_v_out_318301.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_12 = math.max(var_460_3, arg_457_1.talkMaxDuration)

			if var_460_2 <= arg_457_1.time_ and arg_457_1.time_ < var_460_2 + var_460_12 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_2) / var_460_12

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_2 + var_460_12 and arg_457_1.time_ < var_460_2 + var_460_12 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play318301112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 318301112
		arg_461_1.duration_ = 1

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"

			SetActive(arg_461_1.choicesGo_, true)

			for iter_462_0, iter_462_1 in ipairs(arg_461_1.choices_) do
				local var_462_0 = iter_462_0 <= 2

				SetActive(iter_462_1.go, var_462_0)
			end

			arg_461_1.choices_[1].txt.text = arg_461_1:FormatText(StoryChoiceCfg[690].name)
			arg_461_1.choices_[2].txt.text = arg_461_1:FormatText(StoryChoiceCfg[691].name)
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play318301113(arg_461_1)
			end

			if arg_463_0 == 2 then
				arg_461_0:Play318301113(arg_461_1)
			end

			arg_461_1:RecordChoiceLog(318301112, 690, 691)
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["1049ui_story"].transform
			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.var_.moveOldPos1049ui_story = var_464_0.localPosition
			end

			local var_464_2 = 0.001

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_2 then
				local var_464_3 = (arg_461_1.time_ - var_464_1) / var_464_2
				local var_464_4 = Vector3.New(0, -1.2, -6)

				var_464_0.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1049ui_story, var_464_4, var_464_3)

				local var_464_5 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_5.x, var_464_5.y, var_464_5.z)

				local var_464_6 = var_464_0.localEulerAngles

				var_464_6.z = 0
				var_464_6.x = 0
				var_464_0.localEulerAngles = var_464_6
			end

			if arg_461_1.time_ >= var_464_1 + var_464_2 and arg_461_1.time_ < var_464_1 + var_464_2 + arg_464_0 then
				var_464_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_464_7 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_7.x, var_464_7.y, var_464_7.z)

				local var_464_8 = var_464_0.localEulerAngles

				var_464_8.z = 0
				var_464_8.x = 0
				var_464_0.localEulerAngles = var_464_8
			end

			local var_464_9 = arg_461_1.actors_["1049ui_story"]
			local var_464_10 = 0

			if var_464_10 < arg_461_1.time_ and arg_461_1.time_ <= var_464_10 + arg_464_0 and not isNil(var_464_9) and arg_461_1.var_.characterEffect1049ui_story == nil then
				arg_461_1.var_.characterEffect1049ui_story = var_464_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_11 = 0.200000002980232

			if var_464_10 <= arg_461_1.time_ and arg_461_1.time_ < var_464_10 + var_464_11 and not isNil(var_464_9) then
				local var_464_12 = (arg_461_1.time_ - var_464_10) / var_464_11

				if arg_461_1.var_.characterEffect1049ui_story and not isNil(var_464_9) then
					local var_464_13 = Mathf.Lerp(0, 0.5, var_464_12)

					arg_461_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_461_1.var_.characterEffect1049ui_story.fillRatio = var_464_13
				end
			end

			if arg_461_1.time_ >= var_464_10 + var_464_11 and arg_461_1.time_ < var_464_10 + var_464_11 + arg_464_0 and not isNil(var_464_9) and arg_461_1.var_.characterEffect1049ui_story then
				local var_464_14 = 0.5

				arg_461_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_461_1.var_.characterEffect1049ui_story.fillRatio = var_464_14
			end

			local var_464_15 = 0

			if var_464_15 < arg_461_1.time_ and arg_461_1.time_ <= var_464_15 + arg_464_0 then
				arg_461_1.allBtn_.enabled = false
			end

			local var_464_16 = 0.5

			if arg_461_1.time_ >= var_464_15 + var_464_16 and arg_461_1.time_ < var_464_15 + var_464_16 + arg_464_0 then
				arg_461_1.allBtn_.enabled = true
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play318301113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 318301113
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play318301114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0
			local var_468_1 = 0.925

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_2 = arg_465_1:GetWordFromCfg(318301113)
				local var_468_3 = arg_465_1:FormatText(var_468_2.content)

				arg_465_1.text_.text = var_468_3

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_4 = 37
				local var_468_5 = utf8.len(var_468_3)
				local var_468_6 = var_468_4 <= 0 and var_468_1 or var_468_1 * (var_468_5 / var_468_4)

				if var_468_6 > 0 and var_468_1 < var_468_6 then
					arg_465_1.talkMaxDuration = var_468_6

					if var_468_6 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_6 + var_468_0
					end
				end

				arg_465_1.text_.text = var_468_3
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_7 = math.max(var_468_1, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_7 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_0) / var_468_7

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_7 and arg_465_1.time_ < var_468_0 + var_468_7 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play318301114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 318301114
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play318301115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0
			local var_472_1 = 0.375

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_2 = arg_469_1:GetWordFromCfg(318301114)
				local var_472_3 = arg_469_1:FormatText(var_472_2.content)

				arg_469_1.text_.text = var_472_3

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_4 = 15
				local var_472_5 = utf8.len(var_472_3)
				local var_472_6 = var_472_4 <= 0 and var_472_1 or var_472_1 * (var_472_5 / var_472_4)

				if var_472_6 > 0 and var_472_1 < var_472_6 then
					arg_469_1.talkMaxDuration = var_472_6

					if var_472_6 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_6 + var_472_0
					end
				end

				arg_469_1.text_.text = var_472_3
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_7 = math.max(var_472_1, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_7 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_0) / var_472_7

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_7 and arg_469_1.time_ < var_472_0 + var_472_7 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play318301115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 318301115
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play318301116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0
			local var_476_1 = 0.475

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_2 = arg_473_1:FormatText(StoryNameCfg[7].name)

				arg_473_1.leftNameTxt_.text = var_476_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_3 = arg_473_1:GetWordFromCfg(318301115)
				local var_476_4 = arg_473_1:FormatText(var_476_3.content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_5 = 19
				local var_476_6 = utf8.len(var_476_4)
				local var_476_7 = var_476_5 <= 0 and var_476_1 or var_476_1 * (var_476_6 / var_476_5)

				if var_476_7 > 0 and var_476_1 < var_476_7 then
					arg_473_1.talkMaxDuration = var_476_7

					if var_476_7 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_0
					end
				end

				arg_473_1.text_.text = var_476_4
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_8 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_8 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_8

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_8 and arg_473_1.time_ < var_476_0 + var_476_8 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play318301116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 318301116
		arg_477_1.duration_ = 5.7

		local var_477_0 = {
			zh = 2.3,
			ja = 5.7
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play318301117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["1055ui_story"].transform
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.var_.moveOldPos1055ui_story = var_480_0.localPosition
			end

			local var_480_2 = 0.001

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2
				local var_480_4 = Vector3.New(0, -0.965, -6.2)

				var_480_0.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1055ui_story, var_480_4, var_480_3)

				local var_480_5 = manager.ui.mainCamera.transform.position - var_480_0.position

				var_480_0.forward = Vector3.New(var_480_5.x, var_480_5.y, var_480_5.z)

				local var_480_6 = var_480_0.localEulerAngles

				var_480_6.z = 0
				var_480_6.x = 0
				var_480_0.localEulerAngles = var_480_6
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 then
				var_480_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_480_7 = manager.ui.mainCamera.transform.position - var_480_0.position

				var_480_0.forward = Vector3.New(var_480_7.x, var_480_7.y, var_480_7.z)

				local var_480_8 = var_480_0.localEulerAngles

				var_480_8.z = 0
				var_480_8.x = 0
				var_480_0.localEulerAngles = var_480_8
			end

			local var_480_9 = arg_477_1.actors_["1055ui_story"]
			local var_480_10 = 0

			if var_480_10 < arg_477_1.time_ and arg_477_1.time_ <= var_480_10 + arg_480_0 and not isNil(var_480_9) and arg_477_1.var_.characterEffect1055ui_story == nil then
				arg_477_1.var_.characterEffect1055ui_story = var_480_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_11 = 0.200000002980232

			if var_480_10 <= arg_477_1.time_ and arg_477_1.time_ < var_480_10 + var_480_11 and not isNil(var_480_9) then
				local var_480_12 = (arg_477_1.time_ - var_480_10) / var_480_11

				if arg_477_1.var_.characterEffect1055ui_story and not isNil(var_480_9) then
					arg_477_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= var_480_10 + var_480_11 and arg_477_1.time_ < var_480_10 + var_480_11 + arg_480_0 and not isNil(var_480_9) and arg_477_1.var_.characterEffect1055ui_story then
				arg_477_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_480_13 = 0

			if var_480_13 < arg_477_1.time_ and arg_477_1.time_ <= var_480_13 + arg_480_0 then
				arg_477_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_480_14 = 0

			if var_480_14 < arg_477_1.time_ and arg_477_1.time_ <= var_480_14 + arg_480_0 then
				arg_477_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_480_15 = arg_477_1.actors_["1049ui_story"].transform
			local var_480_16 = 0

			if var_480_16 < arg_477_1.time_ and arg_477_1.time_ <= var_480_16 + arg_480_0 then
				arg_477_1.var_.moveOldPos1049ui_story = var_480_15.localPosition
			end

			local var_480_17 = 0.001

			if var_480_16 <= arg_477_1.time_ and arg_477_1.time_ < var_480_16 + var_480_17 then
				local var_480_18 = (arg_477_1.time_ - var_480_16) / var_480_17
				local var_480_19 = Vector3.New(0, 100, 0)

				var_480_15.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1049ui_story, var_480_19, var_480_18)

				local var_480_20 = manager.ui.mainCamera.transform.position - var_480_15.position

				var_480_15.forward = Vector3.New(var_480_20.x, var_480_20.y, var_480_20.z)

				local var_480_21 = var_480_15.localEulerAngles

				var_480_21.z = 0
				var_480_21.x = 0
				var_480_15.localEulerAngles = var_480_21
			end

			if arg_477_1.time_ >= var_480_16 + var_480_17 and arg_477_1.time_ < var_480_16 + var_480_17 + arg_480_0 then
				var_480_15.localPosition = Vector3.New(0, 100, 0)

				local var_480_22 = manager.ui.mainCamera.transform.position - var_480_15.position

				var_480_15.forward = Vector3.New(var_480_22.x, var_480_22.y, var_480_22.z)

				local var_480_23 = var_480_15.localEulerAngles

				var_480_23.z = 0
				var_480_23.x = 0
				var_480_15.localEulerAngles = var_480_23
			end

			local var_480_24 = 0
			local var_480_25 = 0.275

			if var_480_24 < arg_477_1.time_ and arg_477_1.time_ <= var_480_24 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_26 = arg_477_1:FormatText(StoryNameCfg[481].name)

				arg_477_1.leftNameTxt_.text = var_480_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_27 = arg_477_1:GetWordFromCfg(318301116)
				local var_480_28 = arg_477_1:FormatText(var_480_27.content)

				arg_477_1.text_.text = var_480_28

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_29 = 11
				local var_480_30 = utf8.len(var_480_28)
				local var_480_31 = var_480_29 <= 0 and var_480_25 or var_480_25 * (var_480_30 / var_480_29)

				if var_480_31 > 0 and var_480_25 < var_480_31 then
					arg_477_1.talkMaxDuration = var_480_31

					if var_480_31 + var_480_24 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_31 + var_480_24
					end
				end

				arg_477_1.text_.text = var_480_28
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301116", "story_v_out_318301.awb") ~= 0 then
					local var_480_32 = manager.audio:GetVoiceLength("story_v_out_318301", "318301116", "story_v_out_318301.awb") / 1000

					if var_480_32 + var_480_24 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_32 + var_480_24
					end

					if var_480_27.prefab_name ~= "" and arg_477_1.actors_[var_480_27.prefab_name] ~= nil then
						local var_480_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_27.prefab_name].transform, "story_v_out_318301", "318301116", "story_v_out_318301.awb")

						arg_477_1:RecordAudio("318301116", var_480_33)
						arg_477_1:RecordAudio("318301116", var_480_33)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_318301", "318301116", "story_v_out_318301.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_318301", "318301116", "story_v_out_318301.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_34 = math.max(var_480_25, arg_477_1.talkMaxDuration)

			if var_480_24 <= arg_477_1.time_ and arg_477_1.time_ < var_480_24 + var_480_34 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_24) / var_480_34

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_24 + var_480_34 and arg_477_1.time_ < var_480_24 + var_480_34 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play318301117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 318301117
		arg_481_1.duration_ = 10.9

		local var_481_0 = {
			zh = 7.866,
			ja = 10.9
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play318301118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = "K07g"

			if arg_481_1.bgs_[var_484_0] == nil then
				local var_484_1 = Object.Instantiate(arg_481_1.paintGo_)

				var_484_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_484_0)
				var_484_1.name = var_484_0
				var_484_1.transform.parent = arg_481_1.stage_.transform
				var_484_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_481_1.bgs_[var_484_0] = var_484_1
			end

			local var_484_2 = 2

			if var_484_2 < arg_481_1.time_ and arg_481_1.time_ <= var_484_2 + arg_484_0 then
				local var_484_3 = manager.ui.mainCamera.transform.localPosition
				local var_484_4 = Vector3.New(0, 0, 10) + Vector3.New(var_484_3.x, var_484_3.y, 0)
				local var_484_5 = arg_481_1.bgs_.K07g

				var_484_5.transform.localPosition = var_484_4
				var_484_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_484_6 = var_484_5:GetComponent("SpriteRenderer")

				if var_484_6 and var_484_6.sprite then
					local var_484_7 = (var_484_5.transform.localPosition - var_484_3).z
					local var_484_8 = manager.ui.mainCameraCom_
					local var_484_9 = 2 * var_484_7 * Mathf.Tan(var_484_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_484_10 = var_484_9 * var_484_8.aspect
					local var_484_11 = var_484_6.sprite.bounds.size.x
					local var_484_12 = var_484_6.sprite.bounds.size.y
					local var_484_13 = var_484_10 / var_484_11
					local var_484_14 = var_484_9 / var_484_12
					local var_484_15 = var_484_14 < var_484_13 and var_484_13 or var_484_14

					var_484_5.transform.localScale = Vector3.New(var_484_15, var_484_15, 0)
				end

				for iter_484_0, iter_484_1 in pairs(arg_481_1.bgs_) do
					if iter_484_0 ~= "K07g" then
						iter_484_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_484_16 = 0

			if var_484_16 < arg_481_1.time_ and arg_481_1.time_ <= var_484_16 + arg_484_0 then
				arg_481_1.mask_.enabled = true
				arg_481_1.mask_.raycastTarget = true

				arg_481_1:SetGaussion(false)
			end

			local var_484_17 = 2

			if var_484_16 <= arg_481_1.time_ and arg_481_1.time_ < var_484_16 + var_484_17 then
				local var_484_18 = (arg_481_1.time_ - var_484_16) / var_484_17
				local var_484_19 = Color.New(0, 0, 0)

				var_484_19.a = Mathf.Lerp(0, 1, var_484_18)
				arg_481_1.mask_.color = var_484_19
			end

			if arg_481_1.time_ >= var_484_16 + var_484_17 and arg_481_1.time_ < var_484_16 + var_484_17 + arg_484_0 then
				local var_484_20 = Color.New(0, 0, 0)

				var_484_20.a = 1
				arg_481_1.mask_.color = var_484_20
			end

			local var_484_21 = 2

			if var_484_21 < arg_481_1.time_ and arg_481_1.time_ <= var_484_21 + arg_484_0 then
				arg_481_1.mask_.enabled = true
				arg_481_1.mask_.raycastTarget = true

				arg_481_1:SetGaussion(false)
			end

			local var_484_22 = 2

			if var_484_21 <= arg_481_1.time_ and arg_481_1.time_ < var_484_21 + var_484_22 then
				local var_484_23 = (arg_481_1.time_ - var_484_21) / var_484_22
				local var_484_24 = Color.New(0, 0, 0)

				var_484_24.a = Mathf.Lerp(1, 0, var_484_23)
				arg_481_1.mask_.color = var_484_24
			end

			if arg_481_1.time_ >= var_484_21 + var_484_22 and arg_481_1.time_ < var_484_21 + var_484_22 + arg_484_0 then
				local var_484_25 = Color.New(0, 0, 0)
				local var_484_26 = 0

				arg_481_1.mask_.enabled = false
				var_484_25.a = var_484_26
				arg_481_1.mask_.color = var_484_25
			end

			local var_484_27 = arg_481_1.actors_["1015ui_story"].transform
			local var_484_28 = 1.96599999815226

			if var_484_28 < arg_481_1.time_ and arg_481_1.time_ <= var_484_28 + arg_484_0 then
				arg_481_1.var_.moveOldPos1015ui_story = var_484_27.localPosition
			end

			local var_484_29 = 0.001

			if var_484_28 <= arg_481_1.time_ and arg_481_1.time_ < var_484_28 + var_484_29 then
				local var_484_30 = (arg_481_1.time_ - var_484_28) / var_484_29
				local var_484_31 = Vector3.New(0, -1.15, -6.2)

				var_484_27.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1015ui_story, var_484_31, var_484_30)

				local var_484_32 = manager.ui.mainCamera.transform.position - var_484_27.position

				var_484_27.forward = Vector3.New(var_484_32.x, var_484_32.y, var_484_32.z)

				local var_484_33 = var_484_27.localEulerAngles

				var_484_33.z = 0
				var_484_33.x = 0
				var_484_27.localEulerAngles = var_484_33
			end

			if arg_481_1.time_ >= var_484_28 + var_484_29 and arg_481_1.time_ < var_484_28 + var_484_29 + arg_484_0 then
				var_484_27.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_484_34 = manager.ui.mainCamera.transform.position - var_484_27.position

				var_484_27.forward = Vector3.New(var_484_34.x, var_484_34.y, var_484_34.z)

				local var_484_35 = var_484_27.localEulerAngles

				var_484_35.z = 0
				var_484_35.x = 0
				var_484_27.localEulerAngles = var_484_35
			end

			local var_484_36 = arg_481_1.actors_["1015ui_story"]
			local var_484_37 = 3.9

			if var_484_37 < arg_481_1.time_ and arg_481_1.time_ <= var_484_37 + arg_484_0 and not isNil(var_484_36) and arg_481_1.var_.characterEffect1015ui_story == nil then
				arg_481_1.var_.characterEffect1015ui_story = var_484_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_38 = 0.200000002980232

			if var_484_37 <= arg_481_1.time_ and arg_481_1.time_ < var_484_37 + var_484_38 and not isNil(var_484_36) then
				local var_484_39 = (arg_481_1.time_ - var_484_37) / var_484_38

				if arg_481_1.var_.characterEffect1015ui_story and not isNil(var_484_36) then
					arg_481_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= var_484_37 + var_484_38 and arg_481_1.time_ < var_484_37 + var_484_38 + arg_484_0 and not isNil(var_484_36) and arg_481_1.var_.characterEffect1015ui_story then
				arg_481_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_484_40 = 3.9

			if var_484_40 < arg_481_1.time_ and arg_481_1.time_ <= var_484_40 + arg_484_0 then
				arg_481_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_484_41 = 3.9

			if var_484_41 < arg_481_1.time_ and arg_481_1.time_ <= var_484_41 + arg_484_0 then
				arg_481_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_484_42 = arg_481_1.actors_["1055ui_story"].transform
			local var_484_43 = 1.96599999815226

			if var_484_43 < arg_481_1.time_ and arg_481_1.time_ <= var_484_43 + arg_484_0 then
				arg_481_1.var_.moveOldPos1055ui_story = var_484_42.localPosition
			end

			local var_484_44 = 0.001

			if var_484_43 <= arg_481_1.time_ and arg_481_1.time_ < var_484_43 + var_484_44 then
				local var_484_45 = (arg_481_1.time_ - var_484_43) / var_484_44
				local var_484_46 = Vector3.New(0, 100, 0)

				var_484_42.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1055ui_story, var_484_46, var_484_45)

				local var_484_47 = manager.ui.mainCamera.transform.position - var_484_42.position

				var_484_42.forward = Vector3.New(var_484_47.x, var_484_47.y, var_484_47.z)

				local var_484_48 = var_484_42.localEulerAngles

				var_484_48.z = 0
				var_484_48.x = 0
				var_484_42.localEulerAngles = var_484_48
			end

			if arg_481_1.time_ >= var_484_43 + var_484_44 and arg_481_1.time_ < var_484_43 + var_484_44 + arg_484_0 then
				var_484_42.localPosition = Vector3.New(0, 100, 0)

				local var_484_49 = manager.ui.mainCamera.transform.position - var_484_42.position

				var_484_42.forward = Vector3.New(var_484_49.x, var_484_49.y, var_484_49.z)

				local var_484_50 = var_484_42.localEulerAngles

				var_484_50.z = 0
				var_484_50.x = 0
				var_484_42.localEulerAngles = var_484_50
			end

			local var_484_51 = 0
			local var_484_52 = 1

			if var_484_51 < arg_481_1.time_ and arg_481_1.time_ <= var_484_51 + arg_484_0 then
				local var_484_53 = "stop"
				local var_484_54 = "effect"

				arg_481_1:AudioAction(var_484_53, var_484_54, "se_story_221_00", "se_story_221_00_firework_loop", "")
			end

			if arg_481_1.frameCnt_ <= 1 then
				arg_481_1.dialog_:SetActive(false)
			end

			local var_484_55 = 4
			local var_484_56 = 0.45

			if var_484_55 < arg_481_1.time_ and arg_481_1.time_ <= var_484_55 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0

				arg_481_1.dialog_:SetActive(true)

				arg_481_1.dialogCg_.alpha = 0

				local var_484_57 = LeanTween.value(arg_481_1.dialog_, 0, 1, 0.3)

				var_484_57:setOnUpdate(LuaHelper.FloatAction(function(arg_485_0)
					arg_481_1.dialogCg_.alpha = arg_485_0
				end))
				var_484_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_481_1.dialog_)
					var_484_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_481_1.duration_ = arg_481_1.duration_ + 0.3

				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_58 = arg_481_1:FormatText(StoryNameCfg[479].name)

				arg_481_1.leftNameTxt_.text = var_484_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_59 = arg_481_1:GetWordFromCfg(318301117)
				local var_484_60 = arg_481_1:FormatText(var_484_59.content)

				arg_481_1.text_.text = var_484_60

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_61 = 18
				local var_484_62 = utf8.len(var_484_60)
				local var_484_63 = var_484_61 <= 0 and var_484_56 or var_484_56 * (var_484_62 / var_484_61)

				if var_484_63 > 0 and var_484_56 < var_484_63 then
					arg_481_1.talkMaxDuration = var_484_63
					var_484_55 = var_484_55 + 0.3

					if var_484_63 + var_484_55 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_63 + var_484_55
					end
				end

				arg_481_1.text_.text = var_484_60
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301117", "story_v_out_318301.awb") ~= 0 then
					local var_484_64 = manager.audio:GetVoiceLength("story_v_out_318301", "318301117", "story_v_out_318301.awb") / 1000

					if var_484_64 + var_484_55 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_64 + var_484_55
					end

					if var_484_59.prefab_name ~= "" and arg_481_1.actors_[var_484_59.prefab_name] ~= nil then
						local var_484_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_59.prefab_name].transform, "story_v_out_318301", "318301117", "story_v_out_318301.awb")

						arg_481_1:RecordAudio("318301117", var_484_65)
						arg_481_1:RecordAudio("318301117", var_484_65)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_318301", "318301117", "story_v_out_318301.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_318301", "318301117", "story_v_out_318301.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_66 = var_484_55 + 0.3
			local var_484_67 = math.max(var_484_56, arg_481_1.talkMaxDuration)

			if var_484_66 <= arg_481_1.time_ and arg_481_1.time_ < var_484_66 + var_484_67 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_66) / var_484_67

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_66 + var_484_67 and arg_481_1.time_ < var_484_66 + var_484_67 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_481_1:InitPlayNodeList()
	end,
	Play318301118 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 318301118
		arg_487_1.duration_ = 7.87

		local var_487_0 = {
			zh = 6.433,
			ja = 7.866
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play318301119(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = "10014ui_story"

			if arg_487_1.actors_[var_490_0] == nil then
				local var_490_1 = Asset.Load("Char/" .. "10014ui_story")

				if not isNil(var_490_1) then
					local var_490_2 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_487_1.stage_.transform)

					var_490_2.name = var_490_0
					var_490_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_487_1.actors_[var_490_0] = var_490_2

					local var_490_3 = var_490_2:GetComponentInChildren(typeof(CharacterEffect))

					var_490_3.enabled = true

					local var_490_4 = GameObjectTools.GetOrAddComponent(var_490_2, typeof(DynamicBoneHelper))

					if var_490_4 then
						var_490_4:EnableDynamicBone(false)
					end

					arg_487_1:ShowWeapon(var_490_3.transform, false)

					arg_487_1.var_[var_490_0 .. "Animator"] = var_490_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_487_1.var_[var_490_0 .. "Animator"].applyRootMotion = true
					arg_487_1.var_[var_490_0 .. "LipSync"] = var_490_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_490_5 = arg_487_1.actors_["10014ui_story"].transform
			local var_490_6 = 0

			if var_490_6 < arg_487_1.time_ and arg_487_1.time_ <= var_490_6 + arg_490_0 then
				arg_487_1.var_.moveOldPos10014ui_story = var_490_5.localPosition
			end

			local var_490_7 = 0.001

			if var_490_6 <= arg_487_1.time_ and arg_487_1.time_ < var_490_6 + var_490_7 then
				local var_490_8 = (arg_487_1.time_ - var_490_6) / var_490_7
				local var_490_9 = Vector3.New(0, -1.06, -6.2)

				var_490_5.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos10014ui_story, var_490_9, var_490_8)

				local var_490_10 = manager.ui.mainCamera.transform.position - var_490_5.position

				var_490_5.forward = Vector3.New(var_490_10.x, var_490_10.y, var_490_10.z)

				local var_490_11 = var_490_5.localEulerAngles

				var_490_11.z = 0
				var_490_11.x = 0
				var_490_5.localEulerAngles = var_490_11
			end

			if arg_487_1.time_ >= var_490_6 + var_490_7 and arg_487_1.time_ < var_490_6 + var_490_7 + arg_490_0 then
				var_490_5.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_490_12 = manager.ui.mainCamera.transform.position - var_490_5.position

				var_490_5.forward = Vector3.New(var_490_12.x, var_490_12.y, var_490_12.z)

				local var_490_13 = var_490_5.localEulerAngles

				var_490_13.z = 0
				var_490_13.x = 0
				var_490_5.localEulerAngles = var_490_13
			end

			local var_490_14 = arg_487_1.actors_["10014ui_story"]
			local var_490_15 = 0

			if var_490_15 < arg_487_1.time_ and arg_487_1.time_ <= var_490_15 + arg_490_0 and not isNil(var_490_14) and arg_487_1.var_.characterEffect10014ui_story == nil then
				arg_487_1.var_.characterEffect10014ui_story = var_490_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_16 = 0.200000002980232

			if var_490_15 <= arg_487_1.time_ and arg_487_1.time_ < var_490_15 + var_490_16 and not isNil(var_490_14) then
				local var_490_17 = (arg_487_1.time_ - var_490_15) / var_490_16

				if arg_487_1.var_.characterEffect10014ui_story and not isNil(var_490_14) then
					arg_487_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_487_1.time_ >= var_490_15 + var_490_16 and arg_487_1.time_ < var_490_15 + var_490_16 + arg_490_0 and not isNil(var_490_14) and arg_487_1.var_.characterEffect10014ui_story then
				arg_487_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_490_18 = 0

			if var_490_18 < arg_487_1.time_ and arg_487_1.time_ <= var_490_18 + arg_490_0 then
				arg_487_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_490_19 = 0

			if var_490_19 < arg_487_1.time_ and arg_487_1.time_ <= var_490_19 + arg_490_0 then
				arg_487_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_490_20 = arg_487_1.actors_["1015ui_story"].transform
			local var_490_21 = 0

			if var_490_21 < arg_487_1.time_ and arg_487_1.time_ <= var_490_21 + arg_490_0 then
				arg_487_1.var_.moveOldPos1015ui_story = var_490_20.localPosition
			end

			local var_490_22 = 0.001

			if var_490_21 <= arg_487_1.time_ and arg_487_1.time_ < var_490_21 + var_490_22 then
				local var_490_23 = (arg_487_1.time_ - var_490_21) / var_490_22
				local var_490_24 = Vector3.New(0, 100, 0)

				var_490_20.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos1015ui_story, var_490_24, var_490_23)

				local var_490_25 = manager.ui.mainCamera.transform.position - var_490_20.position

				var_490_20.forward = Vector3.New(var_490_25.x, var_490_25.y, var_490_25.z)

				local var_490_26 = var_490_20.localEulerAngles

				var_490_26.z = 0
				var_490_26.x = 0
				var_490_20.localEulerAngles = var_490_26
			end

			if arg_487_1.time_ >= var_490_21 + var_490_22 and arg_487_1.time_ < var_490_21 + var_490_22 + arg_490_0 then
				var_490_20.localPosition = Vector3.New(0, 100, 0)

				local var_490_27 = manager.ui.mainCamera.transform.position - var_490_20.position

				var_490_20.forward = Vector3.New(var_490_27.x, var_490_27.y, var_490_27.z)

				local var_490_28 = var_490_20.localEulerAngles

				var_490_28.z = 0
				var_490_28.x = 0
				var_490_20.localEulerAngles = var_490_28
			end

			local var_490_29 = arg_487_1.actors_["1015ui_story"]
			local var_490_30 = 0

			if var_490_30 < arg_487_1.time_ and arg_487_1.time_ <= var_490_30 + arg_490_0 and not isNil(var_490_29) and arg_487_1.var_.characterEffect1015ui_story == nil then
				arg_487_1.var_.characterEffect1015ui_story = var_490_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_31 = 0.200000002980232

			if var_490_30 <= arg_487_1.time_ and arg_487_1.time_ < var_490_30 + var_490_31 and not isNil(var_490_29) then
				local var_490_32 = (arg_487_1.time_ - var_490_30) / var_490_31

				if arg_487_1.var_.characterEffect1015ui_story and not isNil(var_490_29) then
					local var_490_33 = Mathf.Lerp(0, 0.5, var_490_32)

					arg_487_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_487_1.var_.characterEffect1015ui_story.fillRatio = var_490_33
				end
			end

			if arg_487_1.time_ >= var_490_30 + var_490_31 and arg_487_1.time_ < var_490_30 + var_490_31 + arg_490_0 and not isNil(var_490_29) and arg_487_1.var_.characterEffect1015ui_story then
				local var_490_34 = 0.5

				arg_487_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_487_1.var_.characterEffect1015ui_story.fillRatio = var_490_34
			end

			local var_490_35 = arg_487_1.actors_["10014ui_story"]
			local var_490_36 = 0

			if var_490_36 < arg_487_1.time_ and arg_487_1.time_ <= var_490_36 + arg_490_0 then
				if arg_487_1.var_.characterEffect10014ui_story == nil then
					arg_487_1.var_.characterEffect10014ui_story = var_490_35:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_490_37 = arg_487_1.var_.characterEffect10014ui_story

				var_490_37.imageEffect:turnOff()

				var_490_37.interferenceEffect.enabled = true
				var_490_37.interferenceEffect.noise = 0.01
				var_490_37.interferenceEffect.simTimeScale = 1
				var_490_37.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_490_38 = arg_487_1.actors_["10014ui_story"]
			local var_490_39 = 0
			local var_490_40 = 0.5

			if var_490_39 < arg_487_1.time_ and arg_487_1.time_ <= var_490_39 + arg_490_0 then
				if arg_487_1.var_.characterEffect10014ui_story == nil then
					arg_487_1.var_.characterEffect10014ui_story = var_490_38:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_487_1.var_.characterEffect10014ui_story.imageEffect:turnOn(false)
			end

			local var_490_41 = 0
			local var_490_42 = 0.8

			if var_490_41 < arg_487_1.time_ and arg_487_1.time_ <= var_490_41 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_43 = arg_487_1:FormatText(StoryNameCfg[264].name)

				arg_487_1.leftNameTxt_.text = var_490_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_44 = arg_487_1:GetWordFromCfg(318301118)
				local var_490_45 = arg_487_1:FormatText(var_490_44.content)

				arg_487_1.text_.text = var_490_45

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_46 = 32
				local var_490_47 = utf8.len(var_490_45)
				local var_490_48 = var_490_46 <= 0 and var_490_42 or var_490_42 * (var_490_47 / var_490_46)

				if var_490_48 > 0 and var_490_42 < var_490_48 then
					arg_487_1.talkMaxDuration = var_490_48

					if var_490_48 + var_490_41 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_48 + var_490_41
					end
				end

				arg_487_1.text_.text = var_490_45
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301118", "story_v_out_318301.awb") ~= 0 then
					local var_490_49 = manager.audio:GetVoiceLength("story_v_out_318301", "318301118", "story_v_out_318301.awb") / 1000

					if var_490_49 + var_490_41 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_49 + var_490_41
					end

					if var_490_44.prefab_name ~= "" and arg_487_1.actors_[var_490_44.prefab_name] ~= nil then
						local var_490_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_44.prefab_name].transform, "story_v_out_318301", "318301118", "story_v_out_318301.awb")

						arg_487_1:RecordAudio("318301118", var_490_50)
						arg_487_1:RecordAudio("318301118", var_490_50)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_318301", "318301118", "story_v_out_318301.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_318301", "318301118", "story_v_out_318301.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_51 = math.max(var_490_42, arg_487_1.talkMaxDuration)

			if var_490_41 <= arg_487_1.time_ and arg_487_1.time_ < var_490_41 + var_490_51 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_41) / var_490_51

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_41 + var_490_51 and arg_487_1.time_ < var_490_41 + var_490_51 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_487_1:InitPlayNodeList()
	end,
	Play318301119 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 318301119
		arg_491_1.duration_ = 6.9

		local var_491_0 = {
			zh = 4.633,
			ja = 6.9
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play318301120(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = arg_491_1.actors_["1015ui_story"].transform
			local var_494_1 = 0

			if var_494_1 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 then
				arg_491_1.var_.moveOldPos1015ui_story = var_494_0.localPosition
			end

			local var_494_2 = 0.001

			if var_494_1 <= arg_491_1.time_ and arg_491_1.time_ < var_494_1 + var_494_2 then
				local var_494_3 = (arg_491_1.time_ - var_494_1) / var_494_2
				local var_494_4 = Vector3.New(0, -1.15, -6.2)

				var_494_0.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos1015ui_story, var_494_4, var_494_3)

				local var_494_5 = manager.ui.mainCamera.transform.position - var_494_0.position

				var_494_0.forward = Vector3.New(var_494_5.x, var_494_5.y, var_494_5.z)

				local var_494_6 = var_494_0.localEulerAngles

				var_494_6.z = 0
				var_494_6.x = 0
				var_494_0.localEulerAngles = var_494_6
			end

			if arg_491_1.time_ >= var_494_1 + var_494_2 and arg_491_1.time_ < var_494_1 + var_494_2 + arg_494_0 then
				var_494_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_494_7 = manager.ui.mainCamera.transform.position - var_494_0.position

				var_494_0.forward = Vector3.New(var_494_7.x, var_494_7.y, var_494_7.z)

				local var_494_8 = var_494_0.localEulerAngles

				var_494_8.z = 0
				var_494_8.x = 0
				var_494_0.localEulerAngles = var_494_8
			end

			local var_494_9 = arg_491_1.actors_["1015ui_story"]
			local var_494_10 = 0

			if var_494_10 < arg_491_1.time_ and arg_491_1.time_ <= var_494_10 + arg_494_0 and not isNil(var_494_9) and arg_491_1.var_.characterEffect1015ui_story == nil then
				arg_491_1.var_.characterEffect1015ui_story = var_494_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_11 = 0.200000002980232

			if var_494_10 <= arg_491_1.time_ and arg_491_1.time_ < var_494_10 + var_494_11 and not isNil(var_494_9) then
				local var_494_12 = (arg_491_1.time_ - var_494_10) / var_494_11

				if arg_491_1.var_.characterEffect1015ui_story and not isNil(var_494_9) then
					arg_491_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_491_1.time_ >= var_494_10 + var_494_11 and arg_491_1.time_ < var_494_10 + var_494_11 + arg_494_0 and not isNil(var_494_9) and arg_491_1.var_.characterEffect1015ui_story then
				arg_491_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_494_13 = 0

			if var_494_13 < arg_491_1.time_ and arg_491_1.time_ <= var_494_13 + arg_494_0 then
				arg_491_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_494_14 = 0

			if var_494_14 < arg_491_1.time_ and arg_491_1.time_ <= var_494_14 + arg_494_0 then
				arg_491_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_494_15 = arg_491_1.actors_["10014ui_story"].transform
			local var_494_16 = 0

			if var_494_16 < arg_491_1.time_ and arg_491_1.time_ <= var_494_16 + arg_494_0 then
				arg_491_1.var_.moveOldPos10014ui_story = var_494_15.localPosition
			end

			local var_494_17 = 0.001

			if var_494_16 <= arg_491_1.time_ and arg_491_1.time_ < var_494_16 + var_494_17 then
				local var_494_18 = (arg_491_1.time_ - var_494_16) / var_494_17
				local var_494_19 = Vector3.New(0, 100, 0)

				var_494_15.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos10014ui_story, var_494_19, var_494_18)

				local var_494_20 = manager.ui.mainCamera.transform.position - var_494_15.position

				var_494_15.forward = Vector3.New(var_494_20.x, var_494_20.y, var_494_20.z)

				local var_494_21 = var_494_15.localEulerAngles

				var_494_21.z = 0
				var_494_21.x = 0
				var_494_15.localEulerAngles = var_494_21
			end

			if arg_491_1.time_ >= var_494_16 + var_494_17 and arg_491_1.time_ < var_494_16 + var_494_17 + arg_494_0 then
				var_494_15.localPosition = Vector3.New(0, 100, 0)

				local var_494_22 = manager.ui.mainCamera.transform.position - var_494_15.position

				var_494_15.forward = Vector3.New(var_494_22.x, var_494_22.y, var_494_22.z)

				local var_494_23 = var_494_15.localEulerAngles

				var_494_23.z = 0
				var_494_23.x = 0
				var_494_15.localEulerAngles = var_494_23
			end

			local var_494_24 = arg_491_1.actors_["10014ui_story"]
			local var_494_25 = 0

			if var_494_25 < arg_491_1.time_ and arg_491_1.time_ <= var_494_25 + arg_494_0 and not isNil(var_494_24) and arg_491_1.var_.characterEffect10014ui_story == nil then
				arg_491_1.var_.characterEffect10014ui_story = var_494_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_26 = 0.200000002980232

			if var_494_25 <= arg_491_1.time_ and arg_491_1.time_ < var_494_25 + var_494_26 and not isNil(var_494_24) then
				local var_494_27 = (arg_491_1.time_ - var_494_25) / var_494_26

				if arg_491_1.var_.characterEffect10014ui_story and not isNil(var_494_24) then
					local var_494_28 = Mathf.Lerp(0, 0.5, var_494_27)

					arg_491_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_491_1.var_.characterEffect10014ui_story.fillRatio = var_494_28
				end
			end

			if arg_491_1.time_ >= var_494_25 + var_494_26 and arg_491_1.time_ < var_494_25 + var_494_26 + arg_494_0 and not isNil(var_494_24) and arg_491_1.var_.characterEffect10014ui_story then
				local var_494_29 = 0.5

				arg_491_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_491_1.var_.characterEffect10014ui_story.fillRatio = var_494_29
			end

			local var_494_30 = 0
			local var_494_31 = 0.475

			if var_494_30 < arg_491_1.time_ and arg_491_1.time_ <= var_494_30 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_32 = arg_491_1:FormatText(StoryNameCfg[479].name)

				arg_491_1.leftNameTxt_.text = var_494_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_33 = arg_491_1:GetWordFromCfg(318301119)
				local var_494_34 = arg_491_1:FormatText(var_494_33.content)

				arg_491_1.text_.text = var_494_34

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_35 = 19
				local var_494_36 = utf8.len(var_494_34)
				local var_494_37 = var_494_35 <= 0 and var_494_31 or var_494_31 * (var_494_36 / var_494_35)

				if var_494_37 > 0 and var_494_31 < var_494_37 then
					arg_491_1.talkMaxDuration = var_494_37

					if var_494_37 + var_494_30 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_37 + var_494_30
					end
				end

				arg_491_1.text_.text = var_494_34
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301119", "story_v_out_318301.awb") ~= 0 then
					local var_494_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301119", "story_v_out_318301.awb") / 1000

					if var_494_38 + var_494_30 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_38 + var_494_30
					end

					if var_494_33.prefab_name ~= "" and arg_491_1.actors_[var_494_33.prefab_name] ~= nil then
						local var_494_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_33.prefab_name].transform, "story_v_out_318301", "318301119", "story_v_out_318301.awb")

						arg_491_1:RecordAudio("318301119", var_494_39)
						arg_491_1:RecordAudio("318301119", var_494_39)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_318301", "318301119", "story_v_out_318301.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_318301", "318301119", "story_v_out_318301.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_40 = math.max(var_494_31, arg_491_1.talkMaxDuration)

			if var_494_30 <= arg_491_1.time_ and arg_491_1.time_ < var_494_30 + var_494_40 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_30) / var_494_40

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_30 + var_494_40 and arg_491_1.time_ < var_494_30 + var_494_40 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_491_1:InitPlayNodeList()
	end,
	Play318301120 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 318301120
		arg_495_1.duration_ = 7.9

		local var_495_0 = {
			zh = 7.4,
			ja = 7.9
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play318301121(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0
			local var_498_1 = 0.85

			if var_498_0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_2 = arg_495_1:FormatText(StoryNameCfg[479].name)

				arg_495_1.leftNameTxt_.text = var_498_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_3 = arg_495_1:GetWordFromCfg(318301120)
				local var_498_4 = arg_495_1:FormatText(var_498_3.content)

				arg_495_1.text_.text = var_498_4

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_5 = 34
				local var_498_6 = utf8.len(var_498_4)
				local var_498_7 = var_498_5 <= 0 and var_498_1 or var_498_1 * (var_498_6 / var_498_5)

				if var_498_7 > 0 and var_498_1 < var_498_7 then
					arg_495_1.talkMaxDuration = var_498_7

					if var_498_7 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_7 + var_498_0
					end
				end

				arg_495_1.text_.text = var_498_4
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301120", "story_v_out_318301.awb") ~= 0 then
					local var_498_8 = manager.audio:GetVoiceLength("story_v_out_318301", "318301120", "story_v_out_318301.awb") / 1000

					if var_498_8 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_8 + var_498_0
					end

					if var_498_3.prefab_name ~= "" and arg_495_1.actors_[var_498_3.prefab_name] ~= nil then
						local var_498_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_3.prefab_name].transform, "story_v_out_318301", "318301120", "story_v_out_318301.awb")

						arg_495_1:RecordAudio("318301120", var_498_9)
						arg_495_1:RecordAudio("318301120", var_498_9)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_318301", "318301120", "story_v_out_318301.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_318301", "318301120", "story_v_out_318301.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_10 = math.max(var_498_1, arg_495_1.talkMaxDuration)

			if var_498_0 <= arg_495_1.time_ and arg_495_1.time_ < var_498_0 + var_498_10 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_0) / var_498_10

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_0 + var_498_10 and arg_495_1.time_ < var_498_0 + var_498_10 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play318301121 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 318301121
		arg_499_1.duration_ = 7.8

		local var_499_0 = {
			zh = 4.633,
			ja = 7.8
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play318301122(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = arg_499_1.actors_["10014ui_story"].transform
			local var_502_1 = 0

			if var_502_1 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 then
				arg_499_1.var_.moveOldPos10014ui_story = var_502_0.localPosition
			end

			local var_502_2 = 0.001

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_2 then
				local var_502_3 = (arg_499_1.time_ - var_502_1) / var_502_2
				local var_502_4 = Vector3.New(0, -1.06, -6.2)

				var_502_0.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos10014ui_story, var_502_4, var_502_3)

				local var_502_5 = manager.ui.mainCamera.transform.position - var_502_0.position

				var_502_0.forward = Vector3.New(var_502_5.x, var_502_5.y, var_502_5.z)

				local var_502_6 = var_502_0.localEulerAngles

				var_502_6.z = 0
				var_502_6.x = 0
				var_502_0.localEulerAngles = var_502_6
			end

			if arg_499_1.time_ >= var_502_1 + var_502_2 and arg_499_1.time_ < var_502_1 + var_502_2 + arg_502_0 then
				var_502_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_502_7 = manager.ui.mainCamera.transform.position - var_502_0.position

				var_502_0.forward = Vector3.New(var_502_7.x, var_502_7.y, var_502_7.z)

				local var_502_8 = var_502_0.localEulerAngles

				var_502_8.z = 0
				var_502_8.x = 0
				var_502_0.localEulerAngles = var_502_8
			end

			local var_502_9 = arg_499_1.actors_["10014ui_story"]
			local var_502_10 = 0

			if var_502_10 < arg_499_1.time_ and arg_499_1.time_ <= var_502_10 + arg_502_0 and not isNil(var_502_9) and arg_499_1.var_.characterEffect10014ui_story == nil then
				arg_499_1.var_.characterEffect10014ui_story = var_502_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_11 = 0.200000002980232

			if var_502_10 <= arg_499_1.time_ and arg_499_1.time_ < var_502_10 + var_502_11 and not isNil(var_502_9) then
				local var_502_12 = (arg_499_1.time_ - var_502_10) / var_502_11

				if arg_499_1.var_.characterEffect10014ui_story and not isNil(var_502_9) then
					arg_499_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_499_1.time_ >= var_502_10 + var_502_11 and arg_499_1.time_ < var_502_10 + var_502_11 + arg_502_0 and not isNil(var_502_9) and arg_499_1.var_.characterEffect10014ui_story then
				arg_499_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_502_13 = 0

			if var_502_13 < arg_499_1.time_ and arg_499_1.time_ <= var_502_13 + arg_502_0 then
				arg_499_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			local var_502_14 = 0

			if var_502_14 < arg_499_1.time_ and arg_499_1.time_ <= var_502_14 + arg_502_0 then
				arg_499_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_502_15 = arg_499_1.actors_["1015ui_story"].transform
			local var_502_16 = 0

			if var_502_16 < arg_499_1.time_ and arg_499_1.time_ <= var_502_16 + arg_502_0 then
				arg_499_1.var_.moveOldPos1015ui_story = var_502_15.localPosition
			end

			local var_502_17 = 0.001

			if var_502_16 <= arg_499_1.time_ and arg_499_1.time_ < var_502_16 + var_502_17 then
				local var_502_18 = (arg_499_1.time_ - var_502_16) / var_502_17
				local var_502_19 = Vector3.New(0, 100, 0)

				var_502_15.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1015ui_story, var_502_19, var_502_18)

				local var_502_20 = manager.ui.mainCamera.transform.position - var_502_15.position

				var_502_15.forward = Vector3.New(var_502_20.x, var_502_20.y, var_502_20.z)

				local var_502_21 = var_502_15.localEulerAngles

				var_502_21.z = 0
				var_502_21.x = 0
				var_502_15.localEulerAngles = var_502_21
			end

			if arg_499_1.time_ >= var_502_16 + var_502_17 and arg_499_1.time_ < var_502_16 + var_502_17 + arg_502_0 then
				var_502_15.localPosition = Vector3.New(0, 100, 0)

				local var_502_22 = manager.ui.mainCamera.transform.position - var_502_15.position

				var_502_15.forward = Vector3.New(var_502_22.x, var_502_22.y, var_502_22.z)

				local var_502_23 = var_502_15.localEulerAngles

				var_502_23.z = 0
				var_502_23.x = 0
				var_502_15.localEulerAngles = var_502_23
			end

			local var_502_24 = arg_499_1.actors_["1015ui_story"]
			local var_502_25 = 0

			if var_502_25 < arg_499_1.time_ and arg_499_1.time_ <= var_502_25 + arg_502_0 and not isNil(var_502_24) and arg_499_1.var_.characterEffect1015ui_story == nil then
				arg_499_1.var_.characterEffect1015ui_story = var_502_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_26 = 0.200000002980232

			if var_502_25 <= arg_499_1.time_ and arg_499_1.time_ < var_502_25 + var_502_26 and not isNil(var_502_24) then
				local var_502_27 = (arg_499_1.time_ - var_502_25) / var_502_26

				if arg_499_1.var_.characterEffect1015ui_story and not isNil(var_502_24) then
					local var_502_28 = Mathf.Lerp(0, 0.5, var_502_27)

					arg_499_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_499_1.var_.characterEffect1015ui_story.fillRatio = var_502_28
				end
			end

			if arg_499_1.time_ >= var_502_25 + var_502_26 and arg_499_1.time_ < var_502_25 + var_502_26 + arg_502_0 and not isNil(var_502_24) and arg_499_1.var_.characterEffect1015ui_story then
				local var_502_29 = 0.5

				arg_499_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_499_1.var_.characterEffect1015ui_story.fillRatio = var_502_29
			end

			local var_502_30 = 0
			local var_502_31 = 0.375

			if var_502_30 < arg_499_1.time_ and arg_499_1.time_ <= var_502_30 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_32 = arg_499_1:FormatText(StoryNameCfg[264].name)

				arg_499_1.leftNameTxt_.text = var_502_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_33 = arg_499_1:GetWordFromCfg(318301121)
				local var_502_34 = arg_499_1:FormatText(var_502_33.content)

				arg_499_1.text_.text = var_502_34

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_35 = 15
				local var_502_36 = utf8.len(var_502_34)
				local var_502_37 = var_502_35 <= 0 and var_502_31 or var_502_31 * (var_502_36 / var_502_35)

				if var_502_37 > 0 and var_502_31 < var_502_37 then
					arg_499_1.talkMaxDuration = var_502_37

					if var_502_37 + var_502_30 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_37 + var_502_30
					end
				end

				arg_499_1.text_.text = var_502_34
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301121", "story_v_out_318301.awb") ~= 0 then
					local var_502_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301121", "story_v_out_318301.awb") / 1000

					if var_502_38 + var_502_30 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_38 + var_502_30
					end

					if var_502_33.prefab_name ~= "" and arg_499_1.actors_[var_502_33.prefab_name] ~= nil then
						local var_502_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_33.prefab_name].transform, "story_v_out_318301", "318301121", "story_v_out_318301.awb")

						arg_499_1:RecordAudio("318301121", var_502_39)
						arg_499_1:RecordAudio("318301121", var_502_39)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_318301", "318301121", "story_v_out_318301.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_318301", "318301121", "story_v_out_318301.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_40 = math.max(var_502_31, arg_499_1.talkMaxDuration)

			if var_502_30 <= arg_499_1.time_ and arg_499_1.time_ < var_502_30 + var_502_40 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_30) / var_502_40

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_30 + var_502_40 and arg_499_1.time_ < var_502_30 + var_502_40 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	Play318301122 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 318301122
		arg_503_1.duration_ = 9.5

		local var_503_0 = {
			zh = 6.4,
			ja = 9.5
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play318301123(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0
			local var_506_1 = 0.775

			if var_506_0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_2 = arg_503_1:FormatText(StoryNameCfg[264].name)

				arg_503_1.leftNameTxt_.text = var_506_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_3 = arg_503_1:GetWordFromCfg(318301122)
				local var_506_4 = arg_503_1:FormatText(var_506_3.content)

				arg_503_1.text_.text = var_506_4

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_5 = 31
				local var_506_6 = utf8.len(var_506_4)
				local var_506_7 = var_506_5 <= 0 and var_506_1 or var_506_1 * (var_506_6 / var_506_5)

				if var_506_7 > 0 and var_506_1 < var_506_7 then
					arg_503_1.talkMaxDuration = var_506_7

					if var_506_7 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_7 + var_506_0
					end
				end

				arg_503_1.text_.text = var_506_4
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301122", "story_v_out_318301.awb") ~= 0 then
					local var_506_8 = manager.audio:GetVoiceLength("story_v_out_318301", "318301122", "story_v_out_318301.awb") / 1000

					if var_506_8 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_8 + var_506_0
					end

					if var_506_3.prefab_name ~= "" and arg_503_1.actors_[var_506_3.prefab_name] ~= nil then
						local var_506_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_3.prefab_name].transform, "story_v_out_318301", "318301122", "story_v_out_318301.awb")

						arg_503_1:RecordAudio("318301122", var_506_9)
						arg_503_1:RecordAudio("318301122", var_506_9)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_318301", "318301122", "story_v_out_318301.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_318301", "318301122", "story_v_out_318301.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_10 = math.max(var_506_1, arg_503_1.talkMaxDuration)

			if var_506_0 <= arg_503_1.time_ and arg_503_1.time_ < var_506_0 + var_506_10 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_0) / var_506_10

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_0 + var_506_10 and arg_503_1.time_ < var_506_0 + var_506_10 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play318301123 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 318301123
		arg_507_1.duration_ = 8.07

		local var_507_0 = {
			zh = 4.533,
			ja = 8.066
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play318301124(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = arg_507_1.actors_["1015ui_story"].transform
			local var_510_1 = 0

			if var_510_1 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 then
				arg_507_1.var_.moveOldPos1015ui_story = var_510_0.localPosition
			end

			local var_510_2 = 0.001

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_2 then
				local var_510_3 = (arg_507_1.time_ - var_510_1) / var_510_2
				local var_510_4 = Vector3.New(0, -1.15, -6.2)

				var_510_0.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos1015ui_story, var_510_4, var_510_3)

				local var_510_5 = manager.ui.mainCamera.transform.position - var_510_0.position

				var_510_0.forward = Vector3.New(var_510_5.x, var_510_5.y, var_510_5.z)

				local var_510_6 = var_510_0.localEulerAngles

				var_510_6.z = 0
				var_510_6.x = 0
				var_510_0.localEulerAngles = var_510_6
			end

			if arg_507_1.time_ >= var_510_1 + var_510_2 and arg_507_1.time_ < var_510_1 + var_510_2 + arg_510_0 then
				var_510_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_510_7 = manager.ui.mainCamera.transform.position - var_510_0.position

				var_510_0.forward = Vector3.New(var_510_7.x, var_510_7.y, var_510_7.z)

				local var_510_8 = var_510_0.localEulerAngles

				var_510_8.z = 0
				var_510_8.x = 0
				var_510_0.localEulerAngles = var_510_8
			end

			local var_510_9 = arg_507_1.actors_["1015ui_story"]
			local var_510_10 = 0

			if var_510_10 < arg_507_1.time_ and arg_507_1.time_ <= var_510_10 + arg_510_0 and not isNil(var_510_9) and arg_507_1.var_.characterEffect1015ui_story == nil then
				arg_507_1.var_.characterEffect1015ui_story = var_510_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_11 = 0.200000002980232

			if var_510_10 <= arg_507_1.time_ and arg_507_1.time_ < var_510_10 + var_510_11 and not isNil(var_510_9) then
				local var_510_12 = (arg_507_1.time_ - var_510_10) / var_510_11

				if arg_507_1.var_.characterEffect1015ui_story and not isNil(var_510_9) then
					arg_507_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_507_1.time_ >= var_510_10 + var_510_11 and arg_507_1.time_ < var_510_10 + var_510_11 + arg_510_0 and not isNil(var_510_9) and arg_507_1.var_.characterEffect1015ui_story then
				arg_507_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_510_13 = 0

			if var_510_13 < arg_507_1.time_ and arg_507_1.time_ <= var_510_13 + arg_510_0 then
				arg_507_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_510_14 = 0

			if var_510_14 < arg_507_1.time_ and arg_507_1.time_ <= var_510_14 + arg_510_0 then
				arg_507_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_510_15 = arg_507_1.actors_["10014ui_story"].transform
			local var_510_16 = 0

			if var_510_16 < arg_507_1.time_ and arg_507_1.time_ <= var_510_16 + arg_510_0 then
				arg_507_1.var_.moveOldPos10014ui_story = var_510_15.localPosition
			end

			local var_510_17 = 0.001

			if var_510_16 <= arg_507_1.time_ and arg_507_1.time_ < var_510_16 + var_510_17 then
				local var_510_18 = (arg_507_1.time_ - var_510_16) / var_510_17
				local var_510_19 = Vector3.New(0, 100, 0)

				var_510_15.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos10014ui_story, var_510_19, var_510_18)

				local var_510_20 = manager.ui.mainCamera.transform.position - var_510_15.position

				var_510_15.forward = Vector3.New(var_510_20.x, var_510_20.y, var_510_20.z)

				local var_510_21 = var_510_15.localEulerAngles

				var_510_21.z = 0
				var_510_21.x = 0
				var_510_15.localEulerAngles = var_510_21
			end

			if arg_507_1.time_ >= var_510_16 + var_510_17 and arg_507_1.time_ < var_510_16 + var_510_17 + arg_510_0 then
				var_510_15.localPosition = Vector3.New(0, 100, 0)

				local var_510_22 = manager.ui.mainCamera.transform.position - var_510_15.position

				var_510_15.forward = Vector3.New(var_510_22.x, var_510_22.y, var_510_22.z)

				local var_510_23 = var_510_15.localEulerAngles

				var_510_23.z = 0
				var_510_23.x = 0
				var_510_15.localEulerAngles = var_510_23
			end

			local var_510_24 = arg_507_1.actors_["10014ui_story"]
			local var_510_25 = 0

			if var_510_25 < arg_507_1.time_ and arg_507_1.time_ <= var_510_25 + arg_510_0 and not isNil(var_510_24) and arg_507_1.var_.characterEffect10014ui_story == nil then
				arg_507_1.var_.characterEffect10014ui_story = var_510_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_26 = 0.200000002980232

			if var_510_25 <= arg_507_1.time_ and arg_507_1.time_ < var_510_25 + var_510_26 and not isNil(var_510_24) then
				local var_510_27 = (arg_507_1.time_ - var_510_25) / var_510_26

				if arg_507_1.var_.characterEffect10014ui_story and not isNil(var_510_24) then
					local var_510_28 = Mathf.Lerp(0, 0.5, var_510_27)

					arg_507_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_507_1.var_.characterEffect10014ui_story.fillRatio = var_510_28
				end
			end

			if arg_507_1.time_ >= var_510_25 + var_510_26 and arg_507_1.time_ < var_510_25 + var_510_26 + arg_510_0 and not isNil(var_510_24) and arg_507_1.var_.characterEffect10014ui_story then
				local var_510_29 = 0.5

				arg_507_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_507_1.var_.characterEffect10014ui_story.fillRatio = var_510_29
			end

			local var_510_30 = 0
			local var_510_31 = 0.45

			if var_510_30 < arg_507_1.time_ and arg_507_1.time_ <= var_510_30 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_32 = arg_507_1:FormatText(StoryNameCfg[479].name)

				arg_507_1.leftNameTxt_.text = var_510_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_33 = arg_507_1:GetWordFromCfg(318301123)
				local var_510_34 = arg_507_1:FormatText(var_510_33.content)

				arg_507_1.text_.text = var_510_34

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_35 = 18
				local var_510_36 = utf8.len(var_510_34)
				local var_510_37 = var_510_35 <= 0 and var_510_31 or var_510_31 * (var_510_36 / var_510_35)

				if var_510_37 > 0 and var_510_31 < var_510_37 then
					arg_507_1.talkMaxDuration = var_510_37

					if var_510_37 + var_510_30 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_37 + var_510_30
					end
				end

				arg_507_1.text_.text = var_510_34
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301123", "story_v_out_318301.awb") ~= 0 then
					local var_510_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301123", "story_v_out_318301.awb") / 1000

					if var_510_38 + var_510_30 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_38 + var_510_30
					end

					if var_510_33.prefab_name ~= "" and arg_507_1.actors_[var_510_33.prefab_name] ~= nil then
						local var_510_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_33.prefab_name].transform, "story_v_out_318301", "318301123", "story_v_out_318301.awb")

						arg_507_1:RecordAudio("318301123", var_510_39)
						arg_507_1:RecordAudio("318301123", var_510_39)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_318301", "318301123", "story_v_out_318301.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_318301", "318301123", "story_v_out_318301.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_40 = math.max(var_510_31, arg_507_1.talkMaxDuration)

			if var_510_30 <= arg_507_1.time_ and arg_507_1.time_ < var_510_30 + var_510_40 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_30) / var_510_40

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_30 + var_510_40 and arg_507_1.time_ < var_510_30 + var_510_40 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_507_1:InitPlayNodeList()
	end,
	Play318301124 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 318301124
		arg_511_1.duration_ = 4.1

		local var_511_0 = {
			zh = 3.366,
			ja = 4.1
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play318301125(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["10014ui_story"].transform
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				arg_511_1.var_.moveOldPos10014ui_story = var_514_0.localPosition
			end

			local var_514_2 = 0.001

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_2 then
				local var_514_3 = (arg_511_1.time_ - var_514_1) / var_514_2
				local var_514_4 = Vector3.New(0, -1.06, -6.2)

				var_514_0.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos10014ui_story, var_514_4, var_514_3)

				local var_514_5 = manager.ui.mainCamera.transform.position - var_514_0.position

				var_514_0.forward = Vector3.New(var_514_5.x, var_514_5.y, var_514_5.z)

				local var_514_6 = var_514_0.localEulerAngles

				var_514_6.z = 0
				var_514_6.x = 0
				var_514_0.localEulerAngles = var_514_6
			end

			if arg_511_1.time_ >= var_514_1 + var_514_2 and arg_511_1.time_ < var_514_1 + var_514_2 + arg_514_0 then
				var_514_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_514_7 = manager.ui.mainCamera.transform.position - var_514_0.position

				var_514_0.forward = Vector3.New(var_514_7.x, var_514_7.y, var_514_7.z)

				local var_514_8 = var_514_0.localEulerAngles

				var_514_8.z = 0
				var_514_8.x = 0
				var_514_0.localEulerAngles = var_514_8
			end

			local var_514_9 = arg_511_1.actors_["10014ui_story"]
			local var_514_10 = 0

			if var_514_10 < arg_511_1.time_ and arg_511_1.time_ <= var_514_10 + arg_514_0 and not isNil(var_514_9) and arg_511_1.var_.characterEffect10014ui_story == nil then
				arg_511_1.var_.characterEffect10014ui_story = var_514_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_11 = 0.200000002980232

			if var_514_10 <= arg_511_1.time_ and arg_511_1.time_ < var_514_10 + var_514_11 and not isNil(var_514_9) then
				local var_514_12 = (arg_511_1.time_ - var_514_10) / var_514_11

				if arg_511_1.var_.characterEffect10014ui_story and not isNil(var_514_9) then
					arg_511_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= var_514_10 + var_514_11 and arg_511_1.time_ < var_514_10 + var_514_11 + arg_514_0 and not isNil(var_514_9) and arg_511_1.var_.characterEffect10014ui_story then
				arg_511_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_514_13 = 0

			if var_514_13 < arg_511_1.time_ and arg_511_1.time_ <= var_514_13 + arg_514_0 then
				arg_511_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_514_14 = arg_511_1.actors_["1015ui_story"].transform
			local var_514_15 = 0

			if var_514_15 < arg_511_1.time_ and arg_511_1.time_ <= var_514_15 + arg_514_0 then
				arg_511_1.var_.moveOldPos1015ui_story = var_514_14.localPosition
			end

			local var_514_16 = 0.001

			if var_514_15 <= arg_511_1.time_ and arg_511_1.time_ < var_514_15 + var_514_16 then
				local var_514_17 = (arg_511_1.time_ - var_514_15) / var_514_16
				local var_514_18 = Vector3.New(0, 100, 0)

				var_514_14.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos1015ui_story, var_514_18, var_514_17)

				local var_514_19 = manager.ui.mainCamera.transform.position - var_514_14.position

				var_514_14.forward = Vector3.New(var_514_19.x, var_514_19.y, var_514_19.z)

				local var_514_20 = var_514_14.localEulerAngles

				var_514_20.z = 0
				var_514_20.x = 0
				var_514_14.localEulerAngles = var_514_20
			end

			if arg_511_1.time_ >= var_514_15 + var_514_16 and arg_511_1.time_ < var_514_15 + var_514_16 + arg_514_0 then
				var_514_14.localPosition = Vector3.New(0, 100, 0)

				local var_514_21 = manager.ui.mainCamera.transform.position - var_514_14.position

				var_514_14.forward = Vector3.New(var_514_21.x, var_514_21.y, var_514_21.z)

				local var_514_22 = var_514_14.localEulerAngles

				var_514_22.z = 0
				var_514_22.x = 0
				var_514_14.localEulerAngles = var_514_22
			end

			local var_514_23 = arg_511_1.actors_["1015ui_story"]
			local var_514_24 = 0

			if var_514_24 < arg_511_1.time_ and arg_511_1.time_ <= var_514_24 + arg_514_0 and not isNil(var_514_23) and arg_511_1.var_.characterEffect1015ui_story == nil then
				arg_511_1.var_.characterEffect1015ui_story = var_514_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_25 = 0.200000002980232

			if var_514_24 <= arg_511_1.time_ and arg_511_1.time_ < var_514_24 + var_514_25 and not isNil(var_514_23) then
				local var_514_26 = (arg_511_1.time_ - var_514_24) / var_514_25

				if arg_511_1.var_.characterEffect1015ui_story and not isNil(var_514_23) then
					local var_514_27 = Mathf.Lerp(0, 0.5, var_514_26)

					arg_511_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_511_1.var_.characterEffect1015ui_story.fillRatio = var_514_27
				end
			end

			if arg_511_1.time_ >= var_514_24 + var_514_25 and arg_511_1.time_ < var_514_24 + var_514_25 + arg_514_0 and not isNil(var_514_23) and arg_511_1.var_.characterEffect1015ui_story then
				local var_514_28 = 0.5

				arg_511_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_511_1.var_.characterEffect1015ui_story.fillRatio = var_514_28
			end

			local var_514_29 = 0
			local var_514_30 = 0.425

			if var_514_29 < arg_511_1.time_ and arg_511_1.time_ <= var_514_29 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_31 = arg_511_1:FormatText(StoryNameCfg[264].name)

				arg_511_1.leftNameTxt_.text = var_514_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_32 = arg_511_1:GetWordFromCfg(318301124)
				local var_514_33 = arg_511_1:FormatText(var_514_32.content)

				arg_511_1.text_.text = var_514_33

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_34 = 17
				local var_514_35 = utf8.len(var_514_33)
				local var_514_36 = var_514_34 <= 0 and var_514_30 or var_514_30 * (var_514_35 / var_514_34)

				if var_514_36 > 0 and var_514_30 < var_514_36 then
					arg_511_1.talkMaxDuration = var_514_36

					if var_514_36 + var_514_29 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_36 + var_514_29
					end
				end

				arg_511_1.text_.text = var_514_33
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301124", "story_v_out_318301.awb") ~= 0 then
					local var_514_37 = manager.audio:GetVoiceLength("story_v_out_318301", "318301124", "story_v_out_318301.awb") / 1000

					if var_514_37 + var_514_29 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_37 + var_514_29
					end

					if var_514_32.prefab_name ~= "" and arg_511_1.actors_[var_514_32.prefab_name] ~= nil then
						local var_514_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_32.prefab_name].transform, "story_v_out_318301", "318301124", "story_v_out_318301.awb")

						arg_511_1:RecordAudio("318301124", var_514_38)
						arg_511_1:RecordAudio("318301124", var_514_38)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_318301", "318301124", "story_v_out_318301.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_318301", "318301124", "story_v_out_318301.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_39 = math.max(var_514_30, arg_511_1.talkMaxDuration)

			if var_514_29 <= arg_511_1.time_ and arg_511_1.time_ < var_514_29 + var_514_39 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_29) / var_514_39

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_29 + var_514_39 and arg_511_1.time_ < var_514_29 + var_514_39 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play318301125 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 318301125
		arg_515_1.duration_ = 3.57

		local var_515_0 = {
			zh = 2.633,
			ja = 3.566
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play318301126(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 0
			local var_518_1 = 0.325

			if var_518_0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_2 = arg_515_1:FormatText(StoryNameCfg[264].name)

				arg_515_1.leftNameTxt_.text = var_518_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_3 = arg_515_1:GetWordFromCfg(318301125)
				local var_518_4 = arg_515_1:FormatText(var_518_3.content)

				arg_515_1.text_.text = var_518_4

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_5 = 13
				local var_518_6 = utf8.len(var_518_4)
				local var_518_7 = var_518_5 <= 0 and var_518_1 or var_518_1 * (var_518_6 / var_518_5)

				if var_518_7 > 0 and var_518_1 < var_518_7 then
					arg_515_1.talkMaxDuration = var_518_7

					if var_518_7 + var_518_0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_7 + var_518_0
					end
				end

				arg_515_1.text_.text = var_518_4
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301125", "story_v_out_318301.awb") ~= 0 then
					local var_518_8 = manager.audio:GetVoiceLength("story_v_out_318301", "318301125", "story_v_out_318301.awb") / 1000

					if var_518_8 + var_518_0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_8 + var_518_0
					end

					if var_518_3.prefab_name ~= "" and arg_515_1.actors_[var_518_3.prefab_name] ~= nil then
						local var_518_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_3.prefab_name].transform, "story_v_out_318301", "318301125", "story_v_out_318301.awb")

						arg_515_1:RecordAudio("318301125", var_518_9)
						arg_515_1:RecordAudio("318301125", var_518_9)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_318301", "318301125", "story_v_out_318301.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_318301", "318301125", "story_v_out_318301.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_10 = math.max(var_518_1, arg_515_1.talkMaxDuration)

			if var_518_0 <= arg_515_1.time_ and arg_515_1.time_ < var_518_0 + var_518_10 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_0) / var_518_10

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_0 + var_518_10 and arg_515_1.time_ < var_518_0 + var_518_10 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play318301126 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 318301126
		arg_519_1.duration_ = 1.57

		local var_519_0 = {
			zh = 1.533,
			ja = 1.566
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play318301127(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = arg_519_1.actors_["1015ui_story"].transform
			local var_522_1 = 0

			if var_522_1 < arg_519_1.time_ and arg_519_1.time_ <= var_522_1 + arg_522_0 then
				arg_519_1.var_.moveOldPos1015ui_story = var_522_0.localPosition
			end

			local var_522_2 = 0.001

			if var_522_1 <= arg_519_1.time_ and arg_519_1.time_ < var_522_1 + var_522_2 then
				local var_522_3 = (arg_519_1.time_ - var_522_1) / var_522_2
				local var_522_4 = Vector3.New(0, -1.15, -6.2)

				var_522_0.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos1015ui_story, var_522_4, var_522_3)

				local var_522_5 = manager.ui.mainCamera.transform.position - var_522_0.position

				var_522_0.forward = Vector3.New(var_522_5.x, var_522_5.y, var_522_5.z)

				local var_522_6 = var_522_0.localEulerAngles

				var_522_6.z = 0
				var_522_6.x = 0
				var_522_0.localEulerAngles = var_522_6
			end

			if arg_519_1.time_ >= var_522_1 + var_522_2 and arg_519_1.time_ < var_522_1 + var_522_2 + arg_522_0 then
				var_522_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_522_7 = manager.ui.mainCamera.transform.position - var_522_0.position

				var_522_0.forward = Vector3.New(var_522_7.x, var_522_7.y, var_522_7.z)

				local var_522_8 = var_522_0.localEulerAngles

				var_522_8.z = 0
				var_522_8.x = 0
				var_522_0.localEulerAngles = var_522_8
			end

			local var_522_9 = arg_519_1.actors_["1015ui_story"]
			local var_522_10 = 0

			if var_522_10 < arg_519_1.time_ and arg_519_1.time_ <= var_522_10 + arg_522_0 and not isNil(var_522_9) and arg_519_1.var_.characterEffect1015ui_story == nil then
				arg_519_1.var_.characterEffect1015ui_story = var_522_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_11 = 0.200000002980232

			if var_522_10 <= arg_519_1.time_ and arg_519_1.time_ < var_522_10 + var_522_11 and not isNil(var_522_9) then
				local var_522_12 = (arg_519_1.time_ - var_522_10) / var_522_11

				if arg_519_1.var_.characterEffect1015ui_story and not isNil(var_522_9) then
					arg_519_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= var_522_10 + var_522_11 and arg_519_1.time_ < var_522_10 + var_522_11 + arg_522_0 and not isNil(var_522_9) and arg_519_1.var_.characterEffect1015ui_story then
				arg_519_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_522_13 = 0

			if var_522_13 < arg_519_1.time_ and arg_519_1.time_ <= var_522_13 + arg_522_0 then
				arg_519_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_522_14 = 0

			if var_522_14 < arg_519_1.time_ and arg_519_1.time_ <= var_522_14 + arg_522_0 then
				arg_519_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_522_15 = arg_519_1.actors_["10014ui_story"].transform
			local var_522_16 = 0

			if var_522_16 < arg_519_1.time_ and arg_519_1.time_ <= var_522_16 + arg_522_0 then
				arg_519_1.var_.moveOldPos10014ui_story = var_522_15.localPosition
			end

			local var_522_17 = 0.001

			if var_522_16 <= arg_519_1.time_ and arg_519_1.time_ < var_522_16 + var_522_17 then
				local var_522_18 = (arg_519_1.time_ - var_522_16) / var_522_17
				local var_522_19 = Vector3.New(0, 100, 0)

				var_522_15.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10014ui_story, var_522_19, var_522_18)

				local var_522_20 = manager.ui.mainCamera.transform.position - var_522_15.position

				var_522_15.forward = Vector3.New(var_522_20.x, var_522_20.y, var_522_20.z)

				local var_522_21 = var_522_15.localEulerAngles

				var_522_21.z = 0
				var_522_21.x = 0
				var_522_15.localEulerAngles = var_522_21
			end

			if arg_519_1.time_ >= var_522_16 + var_522_17 and arg_519_1.time_ < var_522_16 + var_522_17 + arg_522_0 then
				var_522_15.localPosition = Vector3.New(0, 100, 0)

				local var_522_22 = manager.ui.mainCamera.transform.position - var_522_15.position

				var_522_15.forward = Vector3.New(var_522_22.x, var_522_22.y, var_522_22.z)

				local var_522_23 = var_522_15.localEulerAngles

				var_522_23.z = 0
				var_522_23.x = 0
				var_522_15.localEulerAngles = var_522_23
			end

			local var_522_24 = arg_519_1.actors_["10014ui_story"]
			local var_522_25 = 0

			if var_522_25 < arg_519_1.time_ and arg_519_1.time_ <= var_522_25 + arg_522_0 and not isNil(var_522_24) and arg_519_1.var_.characterEffect10014ui_story == nil then
				arg_519_1.var_.characterEffect10014ui_story = var_522_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_26 = 0.200000002980232

			if var_522_25 <= arg_519_1.time_ and arg_519_1.time_ < var_522_25 + var_522_26 and not isNil(var_522_24) then
				local var_522_27 = (arg_519_1.time_ - var_522_25) / var_522_26

				if arg_519_1.var_.characterEffect10014ui_story and not isNil(var_522_24) then
					local var_522_28 = Mathf.Lerp(0, 0.5, var_522_27)

					arg_519_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_519_1.var_.characterEffect10014ui_story.fillRatio = var_522_28
				end
			end

			if arg_519_1.time_ >= var_522_25 + var_522_26 and arg_519_1.time_ < var_522_25 + var_522_26 + arg_522_0 and not isNil(var_522_24) and arg_519_1.var_.characterEffect10014ui_story then
				local var_522_29 = 0.5

				arg_519_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_519_1.var_.characterEffect10014ui_story.fillRatio = var_522_29
			end

			local var_522_30 = 0
			local var_522_31 = 0.1

			if var_522_30 < arg_519_1.time_ and arg_519_1.time_ <= var_522_30 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_32 = arg_519_1:FormatText(StoryNameCfg[479].name)

				arg_519_1.leftNameTxt_.text = var_522_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_33 = arg_519_1:GetWordFromCfg(318301126)
				local var_522_34 = arg_519_1:FormatText(var_522_33.content)

				arg_519_1.text_.text = var_522_34

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_35 = 4
				local var_522_36 = utf8.len(var_522_34)
				local var_522_37 = var_522_35 <= 0 and var_522_31 or var_522_31 * (var_522_36 / var_522_35)

				if var_522_37 > 0 and var_522_31 < var_522_37 then
					arg_519_1.talkMaxDuration = var_522_37

					if var_522_37 + var_522_30 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_37 + var_522_30
					end
				end

				arg_519_1.text_.text = var_522_34
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301126", "story_v_out_318301.awb") ~= 0 then
					local var_522_38 = manager.audio:GetVoiceLength("story_v_out_318301", "318301126", "story_v_out_318301.awb") / 1000

					if var_522_38 + var_522_30 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_38 + var_522_30
					end

					if var_522_33.prefab_name ~= "" and arg_519_1.actors_[var_522_33.prefab_name] ~= nil then
						local var_522_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_33.prefab_name].transform, "story_v_out_318301", "318301126", "story_v_out_318301.awb")

						arg_519_1:RecordAudio("318301126", var_522_39)
						arg_519_1:RecordAudio("318301126", var_522_39)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_318301", "318301126", "story_v_out_318301.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_318301", "318301126", "story_v_out_318301.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_40 = math.max(var_522_31, arg_519_1.talkMaxDuration)

			if var_522_30 <= arg_519_1.time_ and arg_519_1.time_ < var_522_30 + var_522_40 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_30) / var_522_40

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_30 + var_522_40 and arg_519_1.time_ < var_522_30 + var_522_40 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_519_1:InitPlayNodeList()
	end,
	Play318301127 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 318301127
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play318301128(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = arg_523_1.actors_["1015ui_story"].transform
			local var_526_1 = 0

			if var_526_1 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 then
				arg_523_1.var_.moveOldPos1015ui_story = var_526_0.localPosition
			end

			local var_526_2 = 0.001

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_2 then
				local var_526_3 = (arg_523_1.time_ - var_526_1) / var_526_2
				local var_526_4 = Vector3.New(0, 100, 0)

				var_526_0.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos1015ui_story, var_526_4, var_526_3)

				local var_526_5 = manager.ui.mainCamera.transform.position - var_526_0.position

				var_526_0.forward = Vector3.New(var_526_5.x, var_526_5.y, var_526_5.z)

				local var_526_6 = var_526_0.localEulerAngles

				var_526_6.z = 0
				var_526_6.x = 0
				var_526_0.localEulerAngles = var_526_6
			end

			if arg_523_1.time_ >= var_526_1 + var_526_2 and arg_523_1.time_ < var_526_1 + var_526_2 + arg_526_0 then
				var_526_0.localPosition = Vector3.New(0, 100, 0)

				local var_526_7 = manager.ui.mainCamera.transform.position - var_526_0.position

				var_526_0.forward = Vector3.New(var_526_7.x, var_526_7.y, var_526_7.z)

				local var_526_8 = var_526_0.localEulerAngles

				var_526_8.z = 0
				var_526_8.x = 0
				var_526_0.localEulerAngles = var_526_8
			end

			local var_526_9 = arg_523_1.actors_["1015ui_story"]
			local var_526_10 = 0

			if var_526_10 < arg_523_1.time_ and arg_523_1.time_ <= var_526_10 + arg_526_0 and not isNil(var_526_9) and arg_523_1.var_.characterEffect1015ui_story == nil then
				arg_523_1.var_.characterEffect1015ui_story = var_526_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_11 = 0.200000002980232

			if var_526_10 <= arg_523_1.time_ and arg_523_1.time_ < var_526_10 + var_526_11 and not isNil(var_526_9) then
				local var_526_12 = (arg_523_1.time_ - var_526_10) / var_526_11

				if arg_523_1.var_.characterEffect1015ui_story and not isNil(var_526_9) then
					local var_526_13 = Mathf.Lerp(0, 0.5, var_526_12)

					arg_523_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_523_1.var_.characterEffect1015ui_story.fillRatio = var_526_13
				end
			end

			if arg_523_1.time_ >= var_526_10 + var_526_11 and arg_523_1.time_ < var_526_10 + var_526_11 + arg_526_0 and not isNil(var_526_9) and arg_523_1.var_.characterEffect1015ui_story then
				local var_526_14 = 0.5

				arg_523_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_523_1.var_.characterEffect1015ui_story.fillRatio = var_526_14
			end

			local var_526_15 = 0
			local var_526_16 = 0.725

			if var_526_15 < arg_523_1.time_ and arg_523_1.time_ <= var_526_15 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_17 = arg_523_1:GetWordFromCfg(318301127)
				local var_526_18 = arg_523_1:FormatText(var_526_17.content)

				arg_523_1.text_.text = var_526_18

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_19 = 29
				local var_526_20 = utf8.len(var_526_18)
				local var_526_21 = var_526_19 <= 0 and var_526_16 or var_526_16 * (var_526_20 / var_526_19)

				if var_526_21 > 0 and var_526_16 < var_526_21 then
					arg_523_1.talkMaxDuration = var_526_21

					if var_526_21 + var_526_15 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_21 + var_526_15
					end
				end

				arg_523_1.text_.text = var_526_18
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_22 = math.max(var_526_16, arg_523_1.talkMaxDuration)

			if var_526_15 <= arg_523_1.time_ and arg_523_1.time_ < var_526_15 + var_526_22 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_15) / var_526_22

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_15 + var_526_22 and arg_523_1.time_ < var_526_15 + var_526_22 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_523_1:InitPlayNodeList()
	end,
	Play318301128 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 318301128
		arg_527_1.duration_ = 6.17

		local var_527_0 = {
			zh = 4.1,
			ja = 6.166
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play318301129(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = arg_527_1.actors_["1015ui_story"].transform
			local var_530_1 = 0

			if var_530_1 < arg_527_1.time_ and arg_527_1.time_ <= var_530_1 + arg_530_0 then
				arg_527_1.var_.moveOldPos1015ui_story = var_530_0.localPosition
			end

			local var_530_2 = 0.001

			if var_530_1 <= arg_527_1.time_ and arg_527_1.time_ < var_530_1 + var_530_2 then
				local var_530_3 = (arg_527_1.time_ - var_530_1) / var_530_2
				local var_530_4 = Vector3.New(0, -1.15, -6.2)

				var_530_0.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos1015ui_story, var_530_4, var_530_3)

				local var_530_5 = manager.ui.mainCamera.transform.position - var_530_0.position

				var_530_0.forward = Vector3.New(var_530_5.x, var_530_5.y, var_530_5.z)

				local var_530_6 = var_530_0.localEulerAngles

				var_530_6.z = 0
				var_530_6.x = 0
				var_530_0.localEulerAngles = var_530_6
			end

			if arg_527_1.time_ >= var_530_1 + var_530_2 and arg_527_1.time_ < var_530_1 + var_530_2 + arg_530_0 then
				var_530_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_530_7 = manager.ui.mainCamera.transform.position - var_530_0.position

				var_530_0.forward = Vector3.New(var_530_7.x, var_530_7.y, var_530_7.z)

				local var_530_8 = var_530_0.localEulerAngles

				var_530_8.z = 0
				var_530_8.x = 0
				var_530_0.localEulerAngles = var_530_8
			end

			local var_530_9 = arg_527_1.actors_["1015ui_story"]
			local var_530_10 = 0

			if var_530_10 < arg_527_1.time_ and arg_527_1.time_ <= var_530_10 + arg_530_0 and not isNil(var_530_9) and arg_527_1.var_.characterEffect1015ui_story == nil then
				arg_527_1.var_.characterEffect1015ui_story = var_530_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_11 = 0.200000002980232

			if var_530_10 <= arg_527_1.time_ and arg_527_1.time_ < var_530_10 + var_530_11 and not isNil(var_530_9) then
				local var_530_12 = (arg_527_1.time_ - var_530_10) / var_530_11

				if arg_527_1.var_.characterEffect1015ui_story and not isNil(var_530_9) then
					arg_527_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= var_530_10 + var_530_11 and arg_527_1.time_ < var_530_10 + var_530_11 + arg_530_0 and not isNil(var_530_9) and arg_527_1.var_.characterEffect1015ui_story then
				arg_527_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_530_13 = 0

			if var_530_13 < arg_527_1.time_ and arg_527_1.time_ <= var_530_13 + arg_530_0 then
				arg_527_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_530_14 = 0

			if var_530_14 < arg_527_1.time_ and arg_527_1.time_ <= var_530_14 + arg_530_0 then
				arg_527_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_530_15 = 0
			local var_530_16 = 0.275

			if var_530_15 < arg_527_1.time_ and arg_527_1.time_ <= var_530_15 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_17 = arg_527_1:FormatText(StoryNameCfg[479].name)

				arg_527_1.leftNameTxt_.text = var_530_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_18 = arg_527_1:GetWordFromCfg(318301128)
				local var_530_19 = arg_527_1:FormatText(var_530_18.content)

				arg_527_1.text_.text = var_530_19

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_20 = 11
				local var_530_21 = utf8.len(var_530_19)
				local var_530_22 = var_530_20 <= 0 and var_530_16 or var_530_16 * (var_530_21 / var_530_20)

				if var_530_22 > 0 and var_530_16 < var_530_22 then
					arg_527_1.talkMaxDuration = var_530_22

					if var_530_22 + var_530_15 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_22 + var_530_15
					end
				end

				arg_527_1.text_.text = var_530_19
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301128", "story_v_out_318301.awb") ~= 0 then
					local var_530_23 = manager.audio:GetVoiceLength("story_v_out_318301", "318301128", "story_v_out_318301.awb") / 1000

					if var_530_23 + var_530_15 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_23 + var_530_15
					end

					if var_530_18.prefab_name ~= "" and arg_527_1.actors_[var_530_18.prefab_name] ~= nil then
						local var_530_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_18.prefab_name].transform, "story_v_out_318301", "318301128", "story_v_out_318301.awb")

						arg_527_1:RecordAudio("318301128", var_530_24)
						arg_527_1:RecordAudio("318301128", var_530_24)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_318301", "318301128", "story_v_out_318301.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_318301", "318301128", "story_v_out_318301.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_25 = math.max(var_530_16, arg_527_1.talkMaxDuration)

			if var_530_15 <= arg_527_1.time_ and arg_527_1.time_ < var_530_15 + var_530_25 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_15) / var_530_25

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_15 + var_530_25 and arg_527_1.time_ < var_530_15 + var_530_25 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_527_1:InitPlayNodeList()
	end,
	Play318301129 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 318301129
		arg_531_1.duration_ = 9

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play318301130(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = "K05g"

			if arg_531_1.bgs_[var_534_0] == nil then
				local var_534_1 = Object.Instantiate(arg_531_1.paintGo_)

				var_534_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_534_0)
				var_534_1.name = var_534_0
				var_534_1.transform.parent = arg_531_1.stage_.transform
				var_534_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_531_1.bgs_[var_534_0] = var_534_1
			end

			local var_534_2 = 2

			if var_534_2 < arg_531_1.time_ and arg_531_1.time_ <= var_534_2 + arg_534_0 then
				local var_534_3 = manager.ui.mainCamera.transform.localPosition
				local var_534_4 = Vector3.New(0, 0, 10) + Vector3.New(var_534_3.x, var_534_3.y, 0)
				local var_534_5 = arg_531_1.bgs_.K05g

				var_534_5.transform.localPosition = var_534_4
				var_534_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_534_6 = var_534_5:GetComponent("SpriteRenderer")

				if var_534_6 and var_534_6.sprite then
					local var_534_7 = (var_534_5.transform.localPosition - var_534_3).z
					local var_534_8 = manager.ui.mainCameraCom_
					local var_534_9 = 2 * var_534_7 * Mathf.Tan(var_534_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_534_10 = var_534_9 * var_534_8.aspect
					local var_534_11 = var_534_6.sprite.bounds.size.x
					local var_534_12 = var_534_6.sprite.bounds.size.y
					local var_534_13 = var_534_10 / var_534_11
					local var_534_14 = var_534_9 / var_534_12
					local var_534_15 = var_534_14 < var_534_13 and var_534_13 or var_534_14

					var_534_5.transform.localScale = Vector3.New(var_534_15, var_534_15, 0)
				end

				for iter_534_0, iter_534_1 in pairs(arg_531_1.bgs_) do
					if iter_534_0 ~= "K05g" then
						iter_534_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_534_16 = 0

			if var_534_16 < arg_531_1.time_ and arg_531_1.time_ <= var_534_16 + arg_534_0 then
				arg_531_1.mask_.enabled = true
				arg_531_1.mask_.raycastTarget = true

				arg_531_1:SetGaussion(false)
			end

			local var_534_17 = 2

			if var_534_16 <= arg_531_1.time_ and arg_531_1.time_ < var_534_16 + var_534_17 then
				local var_534_18 = (arg_531_1.time_ - var_534_16) / var_534_17
				local var_534_19 = Color.New(0, 0, 0)

				var_534_19.a = Mathf.Lerp(0, 1, var_534_18)
				arg_531_1.mask_.color = var_534_19
			end

			if arg_531_1.time_ >= var_534_16 + var_534_17 and arg_531_1.time_ < var_534_16 + var_534_17 + arg_534_0 then
				local var_534_20 = Color.New(0, 0, 0)

				var_534_20.a = 1
				arg_531_1.mask_.color = var_534_20
			end

			local var_534_21 = 2

			if var_534_21 < arg_531_1.time_ and arg_531_1.time_ <= var_534_21 + arg_534_0 then
				arg_531_1.mask_.enabled = true
				arg_531_1.mask_.raycastTarget = true

				arg_531_1:SetGaussion(false)
			end

			local var_534_22 = 2

			if var_534_21 <= arg_531_1.time_ and arg_531_1.time_ < var_534_21 + var_534_22 then
				local var_534_23 = (arg_531_1.time_ - var_534_21) / var_534_22
				local var_534_24 = Color.New(0, 0, 0)

				var_534_24.a = Mathf.Lerp(1, 0, var_534_23)
				arg_531_1.mask_.color = var_534_24
			end

			if arg_531_1.time_ >= var_534_21 + var_534_22 and arg_531_1.time_ < var_534_21 + var_534_22 + arg_534_0 then
				local var_534_25 = Color.New(0, 0, 0)
				local var_534_26 = 0

				arg_531_1.mask_.enabled = false
				var_534_25.a = var_534_26
				arg_531_1.mask_.color = var_534_25
			end

			local var_534_27 = arg_531_1.actors_["1015ui_story"].transform
			local var_534_28 = 1.96599999815226

			if var_534_28 < arg_531_1.time_ and arg_531_1.time_ <= var_534_28 + arg_534_0 then
				arg_531_1.var_.moveOldPos1015ui_story = var_534_27.localPosition
			end

			local var_534_29 = 0.001

			if var_534_28 <= arg_531_1.time_ and arg_531_1.time_ < var_534_28 + var_534_29 then
				local var_534_30 = (arg_531_1.time_ - var_534_28) / var_534_29
				local var_534_31 = Vector3.New(0, 100, 0)

				var_534_27.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos1015ui_story, var_534_31, var_534_30)

				local var_534_32 = manager.ui.mainCamera.transform.position - var_534_27.position

				var_534_27.forward = Vector3.New(var_534_32.x, var_534_32.y, var_534_32.z)

				local var_534_33 = var_534_27.localEulerAngles

				var_534_33.z = 0
				var_534_33.x = 0
				var_534_27.localEulerAngles = var_534_33
			end

			if arg_531_1.time_ >= var_534_28 + var_534_29 and arg_531_1.time_ < var_534_28 + var_534_29 + arg_534_0 then
				var_534_27.localPosition = Vector3.New(0, 100, 0)

				local var_534_34 = manager.ui.mainCamera.transform.position - var_534_27.position

				var_534_27.forward = Vector3.New(var_534_34.x, var_534_34.y, var_534_34.z)

				local var_534_35 = var_534_27.localEulerAngles

				var_534_35.z = 0
				var_534_35.x = 0
				var_534_27.localEulerAngles = var_534_35
			end

			local var_534_36 = arg_531_1.actors_["1015ui_story"]
			local var_534_37 = 1.96599999815226

			if var_534_37 < arg_531_1.time_ and arg_531_1.time_ <= var_534_37 + arg_534_0 and not isNil(var_534_36) and arg_531_1.var_.characterEffect1015ui_story == nil then
				arg_531_1.var_.characterEffect1015ui_story = var_534_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_38 = 0.034000001847744

			if var_534_37 <= arg_531_1.time_ and arg_531_1.time_ < var_534_37 + var_534_38 and not isNil(var_534_36) then
				local var_534_39 = (arg_531_1.time_ - var_534_37) / var_534_38

				if arg_531_1.var_.characterEffect1015ui_story and not isNil(var_534_36) then
					local var_534_40 = Mathf.Lerp(0, 0.5, var_534_39)

					arg_531_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_531_1.var_.characterEffect1015ui_story.fillRatio = var_534_40
				end
			end

			if arg_531_1.time_ >= var_534_37 + var_534_38 and arg_531_1.time_ < var_534_37 + var_534_38 + arg_534_0 and not isNil(var_534_36) and arg_531_1.var_.characterEffect1015ui_story then
				local var_534_41 = 0.5

				arg_531_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_531_1.var_.characterEffect1015ui_story.fillRatio = var_534_41
			end

			if arg_531_1.frameCnt_ <= 1 then
				arg_531_1.dialog_:SetActive(false)
			end

			local var_534_42 = 4
			local var_534_43 = 1.1

			if var_534_42 < arg_531_1.time_ and arg_531_1.time_ <= var_534_42 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0

				arg_531_1.dialog_:SetActive(true)

				arg_531_1.dialogCg_.alpha = 0

				local var_534_44 = LeanTween.value(arg_531_1.dialog_, 0, 1, 0.3)

				var_534_44:setOnUpdate(LuaHelper.FloatAction(function(arg_535_0)
					arg_531_1.dialogCg_.alpha = arg_535_0
				end))
				var_534_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_531_1.dialog_)
					var_534_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_531_1.duration_ = arg_531_1.duration_ + 0.3

				SetActive(arg_531_1.leftNameGo_, false)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_45 = arg_531_1:GetWordFromCfg(318301129)
				local var_534_46 = arg_531_1:FormatText(var_534_45.content)

				arg_531_1.text_.text = var_534_46

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_47 = 44
				local var_534_48 = utf8.len(var_534_46)
				local var_534_49 = var_534_47 <= 0 and var_534_43 or var_534_43 * (var_534_48 / var_534_47)

				if var_534_49 > 0 and var_534_43 < var_534_49 then
					arg_531_1.talkMaxDuration = var_534_49
					var_534_42 = var_534_42 + 0.3

					if var_534_49 + var_534_42 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_49 + var_534_42
					end
				end

				arg_531_1.text_.text = var_534_46
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_50 = var_534_42 + 0.3
			local var_534_51 = math.max(var_534_43, arg_531_1.talkMaxDuration)

			if var_534_50 <= arg_531_1.time_ and arg_531_1.time_ < var_534_50 + var_534_51 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_50) / var_534_51

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_50 + var_534_51 and arg_531_1.time_ < var_534_50 + var_534_51 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play318301130 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 318301130
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play318301131(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0
			local var_540_1 = 0.225

			if var_540_0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_2 = arg_537_1:FormatText(StoryNameCfg[7].name)

				arg_537_1.leftNameTxt_.text = var_540_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, true)
				arg_537_1.iconController_:SetSelectedState("hero")

				arg_537_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_537_1.callingController_:SetSelectedState("normal")

				arg_537_1.keyicon_.color = Color.New(1, 1, 1)
				arg_537_1.icon_.color = Color.New(1, 1, 1)

				local var_540_3 = arg_537_1:GetWordFromCfg(318301130)
				local var_540_4 = arg_537_1:FormatText(var_540_3.content)

				arg_537_1.text_.text = var_540_4

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_5 = 9
				local var_540_6 = utf8.len(var_540_4)
				local var_540_7 = var_540_5 <= 0 and var_540_1 or var_540_1 * (var_540_6 / var_540_5)

				if var_540_7 > 0 and var_540_1 < var_540_7 then
					arg_537_1.talkMaxDuration = var_540_7

					if var_540_7 + var_540_0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_7 + var_540_0
					end
				end

				arg_537_1.text_.text = var_540_4
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_8 = math.max(var_540_1, arg_537_1.talkMaxDuration)

			if var_540_0 <= arg_537_1.time_ and arg_537_1.time_ < var_540_0 + var_540_8 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_0) / var_540_8

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_0 + var_540_8 and arg_537_1.time_ < var_540_0 + var_540_8 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play318301131 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 318301131
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play318301132(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0
			local var_544_1 = 0.533333333333333

			if var_544_0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_0 + arg_544_0 then
				local var_544_2 = "play"
				local var_544_3 = "effect"

				arg_541_1:AudioAction(var_544_2, var_544_3, "se_story_side_1148", "se_story_1148_vibrate", "")
			end

			local var_544_4 = 0
			local var_544_5 = 1

			if var_544_4 < arg_541_1.time_ and arg_541_1.time_ <= var_544_4 + arg_544_0 then
				local var_544_6 = "play"
				local var_544_7 = "music"

				arg_541_1:AudioAction(var_544_6, var_544_7, "ui_battle", "ui_battle_stopbgm", "")

				local var_544_8 = ""
				local var_544_9 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_544_9 ~= "" then
					if arg_541_1.bgmTxt_.text ~= var_544_9 and arg_541_1.bgmTxt_.text ~= "" then
						if arg_541_1.bgmTxt2_.text ~= "" then
							arg_541_1.bgmTxt_.text = arg_541_1.bgmTxt2_.text
						end

						arg_541_1.bgmTxt2_.text = var_544_9

						arg_541_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_541_1.bgmTxt_.text = var_544_9
						arg_541_1.bgmTxt2_.text = var_544_9
					end

					if arg_541_1.bgmTimer then
						arg_541_1.bgmTimer:Stop()

						arg_541_1.bgmTimer = nil
					end

					if arg_541_1.settingData.show_music_name == 1 then
						arg_541_1.musicController:SetSelectedState("show")
						arg_541_1.musicAnimator_:Play("open", 0, 0)

						if arg_541_1.settingData.music_time ~= 0 then
							arg_541_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_541_1.settingData.music_time), function()
								if arg_541_1 == nil or isNil(arg_541_1.bgmTxt_) then
									return
								end

								arg_541_1.musicController:SetSelectedState("hide")
								arg_541_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_544_10 = 0
			local var_544_11 = 0.3

			if var_544_10 < arg_541_1.time_ and arg_541_1.time_ <= var_544_10 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, false)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_12 = arg_541_1:GetWordFromCfg(318301131)
				local var_544_13 = arg_541_1:FormatText(var_544_12.content)

				arg_541_1.text_.text = var_544_13

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_14 = 12
				local var_544_15 = utf8.len(var_544_13)
				local var_544_16 = var_544_14 <= 0 and var_544_11 or var_544_11 * (var_544_15 / var_544_14)

				if var_544_16 > 0 and var_544_11 < var_544_16 then
					arg_541_1.talkMaxDuration = var_544_16

					if var_544_16 + var_544_10 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_16 + var_544_10
					end
				end

				arg_541_1.text_.text = var_544_13
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_17 = math.max(var_544_11, arg_541_1.talkMaxDuration)

			if var_544_10 <= arg_541_1.time_ and arg_541_1.time_ < var_544_10 + var_544_17 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_10) / var_544_17

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_10 + var_544_17 and arg_541_1.time_ < var_544_10 + var_544_17 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play318301132 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 318301132
		arg_546_1.duration_ = 5

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play318301133(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0
			local var_549_1 = 0.1

			if var_549_0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				local var_549_2 = arg_546_1:FormatText(StoryNameCfg[7].name)

				arg_546_1.leftNameTxt_.text = var_549_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, true)
				arg_546_1.iconController_:SetSelectedState("hero")

				arg_546_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_546_1.callingController_:SetSelectedState("normal")

				arg_546_1.keyicon_.color = Color.New(1, 1, 1)
				arg_546_1.icon_.color = Color.New(1, 1, 1)

				local var_549_3 = arg_546_1:GetWordFromCfg(318301132)
				local var_549_4 = arg_546_1:FormatText(var_549_3.content)

				arg_546_1.text_.text = var_549_4

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_5 = 4
				local var_549_6 = utf8.len(var_549_4)
				local var_549_7 = var_549_5 <= 0 and var_549_1 or var_549_1 * (var_549_6 / var_549_5)

				if var_549_7 > 0 and var_549_1 < var_549_7 then
					arg_546_1.talkMaxDuration = var_549_7

					if var_549_7 + var_549_0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_7 + var_549_0
					end
				end

				arg_546_1.text_.text = var_549_4
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)
				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_8 = math.max(var_549_1, arg_546_1.talkMaxDuration)

			if var_549_0 <= arg_546_1.time_ and arg_546_1.time_ < var_549_0 + var_549_8 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_0) / var_549_8

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_0 + var_549_8 and arg_546_1.time_ < var_549_0 + var_549_8 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play318301133 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 318301133
		arg_550_1.duration_ = 2.93

		local var_550_0 = {
			zh = 2.633,
			ja = 2.933
		}
		local var_550_1 = manager.audio:GetLocalizationFlag()

		if var_550_0[var_550_1] ~= nil then
			arg_550_1.duration_ = var_550_0[var_550_1]
		end

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play318301134(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 0
			local var_553_1 = 0.325

			if var_553_0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_0 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, true)

				local var_553_2 = arg_550_1:FormatText(StoryNameCfg[13].name)

				arg_550_1.leftNameTxt_.text = var_553_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_550_1.leftNameTxt_.transform)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1.leftNameTxt_.text)
				SetActive(arg_550_1.iconTrs_.gameObject, true)
				arg_550_1.iconController_:SetSelectedState("hero")

				arg_550_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_550_1.callingController_:SetSelectedState("normal")

				arg_550_1.keyicon_.color = Color.New(1, 1, 1)
				arg_550_1.icon_.color = Color.New(1, 1, 1)

				local var_553_3 = arg_550_1:GetWordFromCfg(318301133)
				local var_553_4 = arg_550_1:FormatText(var_553_3.content)

				arg_550_1.text_.text = var_553_4

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_5 = 13
				local var_553_6 = utf8.len(var_553_4)
				local var_553_7 = var_553_5 <= 0 and var_553_1 or var_553_1 * (var_553_6 / var_553_5)

				if var_553_7 > 0 and var_553_1 < var_553_7 then
					arg_550_1.talkMaxDuration = var_553_7

					if var_553_7 + var_553_0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_7 + var_553_0
					end
				end

				arg_550_1.text_.text = var_553_4
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301133", "story_v_out_318301.awb") ~= 0 then
					local var_553_8 = manager.audio:GetVoiceLength("story_v_out_318301", "318301133", "story_v_out_318301.awb") / 1000

					if var_553_8 + var_553_0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_8 + var_553_0
					end

					if var_553_3.prefab_name ~= "" and arg_550_1.actors_[var_553_3.prefab_name] ~= nil then
						local var_553_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_550_1.actors_[var_553_3.prefab_name].transform, "story_v_out_318301", "318301133", "story_v_out_318301.awb")

						arg_550_1:RecordAudio("318301133", var_553_9)
						arg_550_1:RecordAudio("318301133", var_553_9)
					else
						arg_550_1:AudioAction("play", "voice", "story_v_out_318301", "318301133", "story_v_out_318301.awb")
					end

					arg_550_1:RecordHistoryTalkVoice("story_v_out_318301", "318301133", "story_v_out_318301.awb")
				end

				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_10 = math.max(var_553_1, arg_550_1.talkMaxDuration)

			if var_553_0 <= arg_550_1.time_ and arg_550_1.time_ < var_553_0 + var_553_10 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_0) / var_553_10

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_0 + var_553_10 and arg_550_1.time_ < var_553_0 + var_553_10 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play318301134 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 318301134
		arg_554_1.duration_ = 3.17

		local var_554_0 = {
			zh = 1.4,
			ja = 3.166
		}
		local var_554_1 = manager.audio:GetLocalizationFlag()

		if var_554_0[var_554_1] ~= nil then
			arg_554_1.duration_ = var_554_0[var_554_1]
		end

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play318301135(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = 0
			local var_557_1 = 0.2

			if var_557_0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_0 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				local var_557_2 = arg_554_1:FormatText(StoryNameCfg[13].name)

				arg_554_1.leftNameTxt_.text = var_557_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, true)
				arg_554_1.iconController_:SetSelectedState("hero")

				arg_554_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_554_1.callingController_:SetSelectedState("normal")

				arg_554_1.keyicon_.color = Color.New(1, 1, 1)
				arg_554_1.icon_.color = Color.New(1, 1, 1)

				local var_557_3 = arg_554_1:GetWordFromCfg(318301134)
				local var_557_4 = arg_554_1:FormatText(var_557_3.content)

				arg_554_1.text_.text = var_557_4

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_5 = 8
				local var_557_6 = utf8.len(var_557_4)
				local var_557_7 = var_557_5 <= 0 and var_557_1 or var_557_1 * (var_557_6 / var_557_5)

				if var_557_7 > 0 and var_557_1 < var_557_7 then
					arg_554_1.talkMaxDuration = var_557_7

					if var_557_7 + var_557_0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_7 + var_557_0
					end
				end

				arg_554_1.text_.text = var_557_4
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301134", "story_v_out_318301.awb") ~= 0 then
					local var_557_8 = manager.audio:GetVoiceLength("story_v_out_318301", "318301134", "story_v_out_318301.awb") / 1000

					if var_557_8 + var_557_0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_8 + var_557_0
					end

					if var_557_3.prefab_name ~= "" and arg_554_1.actors_[var_557_3.prefab_name] ~= nil then
						local var_557_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_3.prefab_name].transform, "story_v_out_318301", "318301134", "story_v_out_318301.awb")

						arg_554_1:RecordAudio("318301134", var_557_9)
						arg_554_1:RecordAudio("318301134", var_557_9)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_out_318301", "318301134", "story_v_out_318301.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_out_318301", "318301134", "story_v_out_318301.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_10 = math.max(var_557_1, arg_554_1.talkMaxDuration)

			if var_557_0 <= arg_554_1.time_ and arg_554_1.time_ < var_557_0 + var_557_10 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_0) / var_557_10

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_0 + var_557_10 and arg_554_1.time_ < var_557_0 + var_557_10 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play318301135 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 318301135
		arg_558_1.duration_ = 5

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play318301136(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = "1019ui_story"

			if arg_558_1.actors_[var_561_0] == nil then
				local var_561_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_561_1) then
					local var_561_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_558_1.stage_.transform)

					var_561_2.name = var_561_0
					var_561_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_558_1.actors_[var_561_0] = var_561_2

					local var_561_3 = var_561_2:GetComponentInChildren(typeof(CharacterEffect))

					var_561_3.enabled = true

					local var_561_4 = GameObjectTools.GetOrAddComponent(var_561_2, typeof(DynamicBoneHelper))

					if var_561_4 then
						var_561_4:EnableDynamicBone(false)
					end

					arg_558_1:ShowWeapon(var_561_3.transform, false)

					arg_558_1.var_[var_561_0 .. "Animator"] = var_561_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_558_1.var_[var_561_0 .. "Animator"].applyRootMotion = true
					arg_558_1.var_[var_561_0 .. "LipSync"] = var_561_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_561_5 = arg_558_1.actors_["1019ui_story"].transform
			local var_561_6 = 0

			if var_561_6 < arg_558_1.time_ and arg_558_1.time_ <= var_561_6 + arg_561_0 then
				arg_558_1.var_.moveOldPos1019ui_story = var_561_5.localPosition
			end

			local var_561_7 = 0.001

			if var_561_6 <= arg_558_1.time_ and arg_558_1.time_ < var_561_6 + var_561_7 then
				local var_561_8 = (arg_558_1.time_ - var_561_6) / var_561_7
				local var_561_9 = Vector3.New(0, 100, 0)

				var_561_5.localPosition = Vector3.Lerp(arg_558_1.var_.moveOldPos1019ui_story, var_561_9, var_561_8)

				local var_561_10 = manager.ui.mainCamera.transform.position - var_561_5.position

				var_561_5.forward = Vector3.New(var_561_10.x, var_561_10.y, var_561_10.z)

				local var_561_11 = var_561_5.localEulerAngles

				var_561_11.z = 0
				var_561_11.x = 0
				var_561_5.localEulerAngles = var_561_11
			end

			if arg_558_1.time_ >= var_561_6 + var_561_7 and arg_558_1.time_ < var_561_6 + var_561_7 + arg_561_0 then
				var_561_5.localPosition = Vector3.New(0, 100, 0)

				local var_561_12 = manager.ui.mainCamera.transform.position - var_561_5.position

				var_561_5.forward = Vector3.New(var_561_12.x, var_561_12.y, var_561_12.z)

				local var_561_13 = var_561_5.localEulerAngles

				var_561_13.z = 0
				var_561_13.x = 0
				var_561_5.localEulerAngles = var_561_13
			end

			local var_561_14 = arg_558_1.actors_["1019ui_story"]
			local var_561_15 = 0

			if var_561_15 < arg_558_1.time_ and arg_558_1.time_ <= var_561_15 + arg_561_0 and not isNil(var_561_14) and arg_558_1.var_.characterEffect1019ui_story == nil then
				arg_558_1.var_.characterEffect1019ui_story = var_561_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_16 = 0.200000002980232

			if var_561_15 <= arg_558_1.time_ and arg_558_1.time_ < var_561_15 + var_561_16 and not isNil(var_561_14) then
				local var_561_17 = (arg_558_1.time_ - var_561_15) / var_561_16

				if arg_558_1.var_.characterEffect1019ui_story and not isNil(var_561_14) then
					local var_561_18 = Mathf.Lerp(0, 0.5, var_561_17)

					arg_558_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_558_1.var_.characterEffect1019ui_story.fillRatio = var_561_18
				end
			end

			if arg_558_1.time_ >= var_561_15 + var_561_16 and arg_558_1.time_ < var_561_15 + var_561_16 + arg_561_0 and not isNil(var_561_14) and arg_558_1.var_.characterEffect1019ui_story then
				local var_561_19 = 0.5

				arg_558_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_558_1.var_.characterEffect1019ui_story.fillRatio = var_561_19
			end

			local var_561_20 = 0
			local var_561_21 = 0.9

			if var_561_20 < arg_558_1.time_ and arg_558_1.time_ <= var_561_20 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, false)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_22 = arg_558_1:GetWordFromCfg(318301135)
				local var_561_23 = arg_558_1:FormatText(var_561_22.content)

				arg_558_1.text_.text = var_561_23

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_24 = 36
				local var_561_25 = utf8.len(var_561_23)
				local var_561_26 = var_561_24 <= 0 and var_561_21 or var_561_21 * (var_561_25 / var_561_24)

				if var_561_26 > 0 and var_561_21 < var_561_26 then
					arg_558_1.talkMaxDuration = var_561_26

					if var_561_26 + var_561_20 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_26 + var_561_20
					end
				end

				arg_558_1.text_.text = var_561_23
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)
				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_27 = math.max(var_561_21, arg_558_1.talkMaxDuration)

			if var_561_20 <= arg_558_1.time_ and arg_558_1.time_ < var_561_20 + var_561_27 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_20) / var_561_27

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_20 + var_561_27 and arg_558_1.time_ < var_561_20 + var_561_27 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {
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

		arg_558_1:InitPlayNodeList()
	end,
	Play318301136 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 318301136
		arg_562_1.duration_ = 5

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
			arg_562_1.auto_ = false
		end

		function arg_562_1.playNext_(arg_564_0)
			arg_562_1.onStoryFinished_()
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = 0
			local var_565_1 = 0.875

			if var_565_0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, false)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_2 = arg_562_1:GetWordFromCfg(318301136)
				local var_565_3 = arg_562_1:FormatText(var_565_2.content)

				arg_562_1.text_.text = var_565_3

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_4 = 35
				local var_565_5 = utf8.len(var_565_3)
				local var_565_6 = var_565_4 <= 0 and var_565_1 or var_565_1 * (var_565_5 / var_565_4)

				if var_565_6 > 0 and var_565_1 < var_565_6 then
					arg_562_1.talkMaxDuration = var_565_6

					if var_565_6 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_6 + var_565_0
					end
				end

				arg_562_1.text_.text = var_565_3
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)
				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_7 = math.max(var_565_1, arg_562_1.talkMaxDuration)

			if var_565_0 <= arg_562_1.time_ and arg_562_1.time_ < var_565_0 + var_565_7 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_0) / var_565_7

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_0 + var_565_7 and arg_562_1.time_ < var_565_0 + var_565_7 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/K11g",
		"TextureConfig/Background/K13f",
		"TextureConfig/Background/K13g",
		"TextureConfig/Background/ST06",
		"TextureConfig/Background/K02f",
		"TextureConfig/Background/K06g",
		"TextureConfig/Background/K07g",
		"TextureConfig/Background/K05g"
	},
	voices = {
		"story_v_out_318301.awb"
	}
}
