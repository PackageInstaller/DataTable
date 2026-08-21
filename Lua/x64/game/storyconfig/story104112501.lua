return {
	Play411251001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411251001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play411251002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST77"

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
				local var_4_5 = arg_1_1.bgs_.ST77

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
					if iter_4_0 ~= "ST77" then
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
			local var_4_23 = 0.3

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

			local var_4_28 = 0.433333333333333
			local var_4_29 = 0.3

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				local var_4_32 = ""

				if var_4_32 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_32 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_32

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_32
						arg_1_1.bgmTxt2_.text = var_4_32
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

			local var_4_33 = 0.466666666666667
			local var_4_34 = 0.3

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "music"

				arg_1_1:AudioAction(var_4_35, var_4_36, "bgm_activity_1_6_story_story", "dialog_init", "bgm_activity_1_6_story_story.awb")

				local var_4_37 = ""
				local var_4_38 = MusicRecordCfg[95].musicName

				if var_4_38 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_38 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_38

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_38
						arg_1_1.bgmTxt2_.text = var_4_38
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

			local var_4_39 = 2
			local var_4_40 = 0.825

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_41 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_41:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_42 = arg_1_1:GetWordFromCfg(411251001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 33
				local var_4_45 = utf8.len(var_4_43)
				local var_4_46 = var_4_44 <= 0 and var_4_40 or var_4_40 * (var_4_45 / var_4_44)

				if var_4_46 > 0 and var_4_40 < var_4_46 then
					arg_1_1.talkMaxDuration = var_4_46
					var_4_39 = var_4_39 + 0.3

					if var_4_46 + var_4_39 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_46 + var_4_39
					end
				end

				arg_1_1.text_.text = var_4_43
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_39 + 0.3
			local var_4_48 = math.max(var_4_40, arg_1_1.talkMaxDuration)

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
	Play411251002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 411251002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play411251003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0
			local var_13_1 = 0.775

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_2 = arg_10_1:GetWordFromCfg(411251002)
				local var_13_3 = arg_10_1:FormatText(var_13_2.content)

				arg_10_1.text_.text = var_13_3

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_4 = 31
				local var_13_5 = utf8.len(var_13_3)
				local var_13_6 = var_13_4 <= 0 and var_13_1 or var_13_1 * (var_13_5 / var_13_4)

				if var_13_6 > 0 and var_13_1 < var_13_6 then
					arg_10_1.talkMaxDuration = var_13_6

					if var_13_6 + var_13_0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_6 + var_13_0
					end
				end

				arg_10_1.text_.text = var_13_3
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_7 = math.max(var_13_1, arg_10_1.talkMaxDuration)

			if var_13_0 <= arg_10_1.time_ and arg_10_1.time_ < var_13_0 + var_13_7 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_0) / var_13_7

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_0 + var_13_7 and arg_10_1.time_ < var_13_0 + var_13_7 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play411251003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 411251003
		arg_14_1.duration_ = 5.13

		local var_14_0 = {
			zh = 4.7,
			ja = 5.133
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play411251004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = "10058ui_story"

			if arg_14_1.actors_[var_17_0] == nil then
				local var_17_1 = Asset.Load("Char/" .. "10058ui_story")

				if not isNil(var_17_1) then
					local var_17_2 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_14_1.stage_.transform)

					var_17_2.name = var_17_0
					var_17_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_14_1.actors_[var_17_0] = var_17_2

					local var_17_3 = var_17_2:GetComponentInChildren(typeof(CharacterEffect))

					var_17_3.enabled = true

					local var_17_4 = GameObjectTools.GetOrAddComponent(var_17_2, typeof(DynamicBoneHelper))

					if var_17_4 then
						var_17_4:EnableDynamicBone(false)
					end

					arg_14_1:ShowWeapon(var_17_3.transform, false)

					arg_14_1.var_[var_17_0 .. "Animator"] = var_17_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_14_1.var_[var_17_0 .. "Animator"].applyRootMotion = true
					arg_14_1.var_[var_17_0 .. "LipSync"] = var_17_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_17_5 = arg_14_1.actors_["10058ui_story"].transform
			local var_17_6 = 0

			if var_17_6 < arg_14_1.time_ and arg_14_1.time_ <= var_17_6 + arg_17_0 then
				arg_14_1.var_.moveOldPos10058ui_story = var_17_5.localPosition
			end

			local var_17_7 = 0.001

			if var_17_6 <= arg_14_1.time_ and arg_14_1.time_ < var_17_6 + var_17_7 then
				local var_17_8 = (arg_14_1.time_ - var_17_6) / var_17_7
				local var_17_9 = Vector3.New(0, -0.98, -6.1)

				var_17_5.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos10058ui_story, var_17_9, var_17_8)

				local var_17_10 = manager.ui.mainCamera.transform.position - var_17_5.position

				var_17_5.forward = Vector3.New(var_17_10.x, var_17_10.y, var_17_10.z)

				local var_17_11 = var_17_5.localEulerAngles

				var_17_11.z = 0
				var_17_11.x = 0
				var_17_5.localEulerAngles = var_17_11
			end

			if arg_14_1.time_ >= var_17_6 + var_17_7 and arg_14_1.time_ < var_17_6 + var_17_7 + arg_17_0 then
				var_17_5.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_17_12 = manager.ui.mainCamera.transform.position - var_17_5.position

				var_17_5.forward = Vector3.New(var_17_12.x, var_17_12.y, var_17_12.z)

				local var_17_13 = var_17_5.localEulerAngles

				var_17_13.z = 0
				var_17_13.x = 0
				var_17_5.localEulerAngles = var_17_13
			end

			local var_17_14 = arg_14_1.actors_["10058ui_story"]
			local var_17_15 = 0

			if var_17_15 < arg_14_1.time_ and arg_14_1.time_ <= var_17_15 + arg_17_0 and not isNil(var_17_14) and arg_14_1.var_.characterEffect10058ui_story == nil then
				arg_14_1.var_.characterEffect10058ui_story = var_17_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_16 = 0.200000002980232

			if var_17_15 <= arg_14_1.time_ and arg_14_1.time_ < var_17_15 + var_17_16 and not isNil(var_17_14) then
				local var_17_17 = (arg_14_1.time_ - var_17_15) / var_17_16

				if arg_14_1.var_.characterEffect10058ui_story and not isNil(var_17_14) then
					arg_14_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_14_1.time_ >= var_17_15 + var_17_16 and arg_14_1.time_ < var_17_15 + var_17_16 + arg_17_0 and not isNil(var_17_14) and arg_14_1.var_.characterEffect10058ui_story then
				arg_14_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_17_18 = 0

			if var_17_18 < arg_14_1.time_ and arg_14_1.time_ <= var_17_18 + arg_17_0 then
				arg_14_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_17_19 = 0

			if var_17_19 < arg_14_1.time_ and arg_14_1.time_ <= var_17_19 + arg_17_0 then
				arg_14_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_17_20 = 0
			local var_17_21 = 0.45

			if var_17_20 < arg_14_1.time_ and arg_14_1.time_ <= var_17_20 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_22 = arg_14_1:FormatText(StoryNameCfg[471].name)

				arg_14_1.leftNameTxt_.text = var_17_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_23 = arg_14_1:GetWordFromCfg(411251003)
				local var_17_24 = arg_14_1:FormatText(var_17_23.content)

				arg_14_1.text_.text = var_17_24

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_25 = 18
				local var_17_26 = utf8.len(var_17_24)
				local var_17_27 = var_17_25 <= 0 and var_17_21 or var_17_21 * (var_17_26 / var_17_25)

				if var_17_27 > 0 and var_17_21 < var_17_27 then
					arg_14_1.talkMaxDuration = var_17_27

					if var_17_27 + var_17_20 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_27 + var_17_20
					end
				end

				arg_14_1.text_.text = var_17_24
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251003", "story_v_out_411251.awb") ~= 0 then
					local var_17_28 = manager.audio:GetVoiceLength("story_v_out_411251", "411251003", "story_v_out_411251.awb") / 1000

					if var_17_28 + var_17_20 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_28 + var_17_20
					end

					if var_17_23.prefab_name ~= "" and arg_14_1.actors_[var_17_23.prefab_name] ~= nil then
						local var_17_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_23.prefab_name].transform, "story_v_out_411251", "411251003", "story_v_out_411251.awb")

						arg_14_1:RecordAudio("411251003", var_17_29)
						arg_14_1:RecordAudio("411251003", var_17_29)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_411251", "411251003", "story_v_out_411251.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_411251", "411251003", "story_v_out_411251.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_30 = math.max(var_17_21, arg_14_1.talkMaxDuration)

			if var_17_20 <= arg_14_1.time_ and arg_14_1.time_ < var_17_20 + var_17_30 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_20) / var_17_30

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_20 + var_17_30 and arg_14_1.time_ < var_17_20 + var_17_30 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play411251004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 411251004
		arg_18_1.duration_ = 5.4

		local var_18_0 = {
			zh = 5.4,
			ja = 3
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play411251005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["10058ui_story"]
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.characterEffect10058ui_story == nil then
				arg_18_1.var_.characterEffect10058ui_story = var_21_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_2 = 0.200000002980232

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 and not isNil(var_21_0) then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2

				if arg_18_1.var_.characterEffect10058ui_story and not isNil(var_21_0) then
					local var_21_4 = Mathf.Lerp(0, 0.5, var_21_3)

					arg_18_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_18_1.var_.characterEffect10058ui_story.fillRatio = var_21_4
				end
			end

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.characterEffect10058ui_story then
				local var_21_5 = 0.5

				arg_18_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_18_1.var_.characterEffect10058ui_story.fillRatio = var_21_5
			end

			local var_21_6 = 0
			local var_21_7 = 0.2

			if var_21_6 < arg_18_1.time_ and arg_18_1.time_ <= var_21_6 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_8 = arg_18_1:FormatText(StoryNameCfg[328].name)

				arg_18_1.leftNameTxt_.text = var_21_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_9 = arg_18_1:GetWordFromCfg(411251004)
				local var_21_10 = arg_18_1:FormatText(var_21_9.content)

				arg_18_1.text_.text = var_21_10

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_11 = 8
				local var_21_12 = utf8.len(var_21_10)
				local var_21_13 = var_21_11 <= 0 and var_21_7 or var_21_7 * (var_21_12 / var_21_11)

				if var_21_13 > 0 and var_21_7 < var_21_13 then
					arg_18_1.talkMaxDuration = var_21_13

					if var_21_13 + var_21_6 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_13 + var_21_6
					end
				end

				arg_18_1.text_.text = var_21_10
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251004", "story_v_out_411251.awb") ~= 0 then
					local var_21_14 = manager.audio:GetVoiceLength("story_v_out_411251", "411251004", "story_v_out_411251.awb") / 1000

					if var_21_14 + var_21_6 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_14 + var_21_6
					end

					if var_21_9.prefab_name ~= "" and arg_18_1.actors_[var_21_9.prefab_name] ~= nil then
						local var_21_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_9.prefab_name].transform, "story_v_out_411251", "411251004", "story_v_out_411251.awb")

						arg_18_1:RecordAudio("411251004", var_21_15)
						arg_18_1:RecordAudio("411251004", var_21_15)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_411251", "411251004", "story_v_out_411251.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_411251", "411251004", "story_v_out_411251.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_16 = math.max(var_21_7, arg_18_1.talkMaxDuration)

			if var_21_6 <= arg_18_1.time_ and arg_18_1.time_ < var_21_6 + var_21_16 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_6) / var_21_16

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_6 + var_21_16 and arg_18_1.time_ < var_21_6 + var_21_16 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play411251005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 411251005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play411251006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0
			local var_25_1 = 0.6

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_2 = arg_22_1:GetWordFromCfg(411251005)
				local var_25_3 = arg_22_1:FormatText(var_25_2.content)

				arg_22_1.text_.text = var_25_3

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 24
				local var_25_5 = utf8.len(var_25_3)
				local var_25_6 = var_25_4 <= 0 and var_25_1 or var_25_1 * (var_25_5 / var_25_4)

				if var_25_6 > 0 and var_25_1 < var_25_6 then
					arg_22_1.talkMaxDuration = var_25_6

					if var_25_6 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_6 + var_25_0
					end
				end

				arg_22_1.text_.text = var_25_3
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_7 = math.max(var_25_1, arg_22_1.talkMaxDuration)

			if var_25_0 <= arg_22_1.time_ and arg_22_1.time_ < var_25_0 + var_25_7 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_0) / var_25_7

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_0 + var_25_7 and arg_22_1.time_ < var_25_0 + var_25_7 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play411251006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 411251006
		arg_26_1.duration_ = 5.53

		local var_26_0 = {
			zh = 4.6,
			ja = 5.533
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play411251007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["10058ui_story"].transform
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 then
				arg_26_1.var_.moveOldPos10058ui_story = var_29_0.localPosition
			end

			local var_29_2 = 0.001

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2
				local var_29_4 = Vector3.New(0, -0.98, -6.1)

				var_29_0.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos10058ui_story, var_29_4, var_29_3)

				local var_29_5 = manager.ui.mainCamera.transform.position - var_29_0.position

				var_29_0.forward = Vector3.New(var_29_5.x, var_29_5.y, var_29_5.z)

				local var_29_6 = var_29_0.localEulerAngles

				var_29_6.z = 0
				var_29_6.x = 0
				var_29_0.localEulerAngles = var_29_6
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 then
				var_29_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_29_7 = manager.ui.mainCamera.transform.position - var_29_0.position

				var_29_0.forward = Vector3.New(var_29_7.x, var_29_7.y, var_29_7.z)

				local var_29_8 = var_29_0.localEulerAngles

				var_29_8.z = 0
				var_29_8.x = 0
				var_29_0.localEulerAngles = var_29_8
			end

			local var_29_9 = arg_26_1.actors_["10058ui_story"]
			local var_29_10 = 0

			if var_29_10 < arg_26_1.time_ and arg_26_1.time_ <= var_29_10 + arg_29_0 and not isNil(var_29_9) and arg_26_1.var_.characterEffect10058ui_story == nil then
				arg_26_1.var_.characterEffect10058ui_story = var_29_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_11 = 0.200000002980232

			if var_29_10 <= arg_26_1.time_ and arg_26_1.time_ < var_29_10 + var_29_11 and not isNil(var_29_9) then
				local var_29_12 = (arg_26_1.time_ - var_29_10) / var_29_11

				if arg_26_1.var_.characterEffect10058ui_story and not isNil(var_29_9) then
					arg_26_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= var_29_10 + var_29_11 and arg_26_1.time_ < var_29_10 + var_29_11 + arg_29_0 and not isNil(var_29_9) and arg_26_1.var_.characterEffect10058ui_story then
				arg_26_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_29_13 = 0

			if var_29_13 < arg_26_1.time_ and arg_26_1.time_ <= var_29_13 + arg_29_0 then
				arg_26_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			local var_29_14 = 0

			if var_29_14 < arg_26_1.time_ and arg_26_1.time_ <= var_29_14 + arg_29_0 then
				arg_26_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_29_15 = 0
			local var_29_16 = 0.425

			if var_29_15 < arg_26_1.time_ and arg_26_1.time_ <= var_29_15 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_17 = arg_26_1:FormatText(StoryNameCfg[471].name)

				arg_26_1.leftNameTxt_.text = var_29_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_18 = arg_26_1:GetWordFromCfg(411251006)
				local var_29_19 = arg_26_1:FormatText(var_29_18.content)

				arg_26_1.text_.text = var_29_19

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_20 = 17
				local var_29_21 = utf8.len(var_29_19)
				local var_29_22 = var_29_20 <= 0 and var_29_16 or var_29_16 * (var_29_21 / var_29_20)

				if var_29_22 > 0 and var_29_16 < var_29_22 then
					arg_26_1.talkMaxDuration = var_29_22

					if var_29_22 + var_29_15 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_22 + var_29_15
					end
				end

				arg_26_1.text_.text = var_29_19
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251006", "story_v_out_411251.awb") ~= 0 then
					local var_29_23 = manager.audio:GetVoiceLength("story_v_out_411251", "411251006", "story_v_out_411251.awb") / 1000

					if var_29_23 + var_29_15 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_23 + var_29_15
					end

					if var_29_18.prefab_name ~= "" and arg_26_1.actors_[var_29_18.prefab_name] ~= nil then
						local var_29_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_18.prefab_name].transform, "story_v_out_411251", "411251006", "story_v_out_411251.awb")

						arg_26_1:RecordAudio("411251006", var_29_24)
						arg_26_1:RecordAudio("411251006", var_29_24)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_411251", "411251006", "story_v_out_411251.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_411251", "411251006", "story_v_out_411251.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_25 = math.max(var_29_16, arg_26_1.talkMaxDuration)

			if var_29_15 <= arg_26_1.time_ and arg_26_1.time_ < var_29_15 + var_29_25 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_15) / var_29_25

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_15 + var_29_25 and arg_26_1.time_ < var_29_15 + var_29_25 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play411251007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 411251007
		arg_30_1.duration_ = 2.73

		local var_30_0 = {
			zh = 0.999999999999,
			ja = 2.733
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play411251008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["10058ui_story"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect10058ui_story == nil then
				arg_30_1.var_.characterEffect10058ui_story = var_33_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.200000002980232

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.characterEffect10058ui_story and not isNil(var_33_0) then
					local var_33_4 = Mathf.Lerp(0, 0.5, var_33_3)

					arg_30_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_30_1.var_.characterEffect10058ui_story.fillRatio = var_33_4
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect10058ui_story then
				local var_33_5 = 0.5

				arg_30_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_30_1.var_.characterEffect10058ui_story.fillRatio = var_33_5
			end

			local var_33_6 = 0
			local var_33_7 = 0.05

			if var_33_6 < arg_30_1.time_ and arg_30_1.time_ <= var_33_6 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_8 = arg_30_1:FormatText(StoryNameCfg[328].name)

				arg_30_1.leftNameTxt_.text = var_33_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_9 = arg_30_1:GetWordFromCfg(411251007)
				local var_33_10 = arg_30_1:FormatText(var_33_9.content)

				arg_30_1.text_.text = var_33_10

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_11 = 2
				local var_33_12 = utf8.len(var_33_10)
				local var_33_13 = var_33_11 <= 0 and var_33_7 or var_33_7 * (var_33_12 / var_33_11)

				if var_33_13 > 0 and var_33_7 < var_33_13 then
					arg_30_1.talkMaxDuration = var_33_13

					if var_33_13 + var_33_6 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_13 + var_33_6
					end
				end

				arg_30_1.text_.text = var_33_10
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251007", "story_v_out_411251.awb") ~= 0 then
					local var_33_14 = manager.audio:GetVoiceLength("story_v_out_411251", "411251007", "story_v_out_411251.awb") / 1000

					if var_33_14 + var_33_6 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_14 + var_33_6
					end

					if var_33_9.prefab_name ~= "" and arg_30_1.actors_[var_33_9.prefab_name] ~= nil then
						local var_33_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_9.prefab_name].transform, "story_v_out_411251", "411251007", "story_v_out_411251.awb")

						arg_30_1:RecordAudio("411251007", var_33_15)
						arg_30_1:RecordAudio("411251007", var_33_15)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_411251", "411251007", "story_v_out_411251.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_411251", "411251007", "story_v_out_411251.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_16 = math.max(var_33_7, arg_30_1.talkMaxDuration)

			if var_33_6 <= arg_30_1.time_ and arg_30_1.time_ < var_33_6 + var_33_16 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_6) / var_33_16

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_6 + var_33_16 and arg_30_1.time_ < var_33_6 + var_33_16 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play411251008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 411251008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play411251009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0
			local var_37_1 = 1.05

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_2 = arg_34_1:GetWordFromCfg(411251008)
				local var_37_3 = arg_34_1:FormatText(var_37_2.content)

				arg_34_1.text_.text = var_37_3

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_4 = 44
				local var_37_5 = utf8.len(var_37_3)
				local var_37_6 = var_37_4 <= 0 and var_37_1 or var_37_1 * (var_37_5 / var_37_4)

				if var_37_6 > 0 and var_37_1 < var_37_6 then
					arg_34_1.talkMaxDuration = var_37_6

					if var_37_6 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_6 + var_37_0
					end
				end

				arg_34_1.text_.text = var_37_3
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_7 = math.max(var_37_1, arg_34_1.talkMaxDuration)

			if var_37_0 <= arg_34_1.time_ and arg_34_1.time_ < var_37_0 + var_37_7 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_0) / var_37_7

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_0 + var_37_7 and arg_34_1.time_ < var_37_0 + var_37_7 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play411251009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 411251009
		arg_38_1.duration_ = 2

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play411251010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["10058ui_story"].transform
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.var_.moveOldPos10058ui_story = var_41_0.localPosition
			end

			local var_41_2 = 0.001

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2
				local var_41_4 = Vector3.New(0, -0.98, -6.1)

				var_41_0.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos10058ui_story, var_41_4, var_41_3)

				local var_41_5 = manager.ui.mainCamera.transform.position - var_41_0.position

				var_41_0.forward = Vector3.New(var_41_5.x, var_41_5.y, var_41_5.z)

				local var_41_6 = var_41_0.localEulerAngles

				var_41_6.z = 0
				var_41_6.x = 0
				var_41_0.localEulerAngles = var_41_6
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 then
				var_41_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_41_7 = manager.ui.mainCamera.transform.position - var_41_0.position

				var_41_0.forward = Vector3.New(var_41_7.x, var_41_7.y, var_41_7.z)

				local var_41_8 = var_41_0.localEulerAngles

				var_41_8.z = 0
				var_41_8.x = 0
				var_41_0.localEulerAngles = var_41_8
			end

			local var_41_9 = arg_38_1.actors_["10058ui_story"]
			local var_41_10 = 0

			if var_41_10 < arg_38_1.time_ and arg_38_1.time_ <= var_41_10 + arg_41_0 and not isNil(var_41_9) and arg_38_1.var_.characterEffect10058ui_story == nil then
				arg_38_1.var_.characterEffect10058ui_story = var_41_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_11 = 0.200000002980232

			if var_41_10 <= arg_38_1.time_ and arg_38_1.time_ < var_41_10 + var_41_11 and not isNil(var_41_9) then
				local var_41_12 = (arg_38_1.time_ - var_41_10) / var_41_11

				if arg_38_1.var_.characterEffect10058ui_story and not isNil(var_41_9) then
					arg_38_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_10 + var_41_11 and arg_38_1.time_ < var_41_10 + var_41_11 + arg_41_0 and not isNil(var_41_9) and arg_38_1.var_.characterEffect10058ui_story then
				arg_38_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_41_13 = 0

			if var_41_13 < arg_38_1.time_ and arg_38_1.time_ <= var_41_13 + arg_41_0 then
				arg_38_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			local var_41_14 = 0

			if var_41_14 < arg_38_1.time_ and arg_38_1.time_ <= var_41_14 + arg_41_0 then
				arg_38_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_41_15 = 0
			local var_41_16 = 0.05

			if var_41_15 < arg_38_1.time_ and arg_38_1.time_ <= var_41_15 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_17 = arg_38_1:FormatText(StoryNameCfg[471].name)

				arg_38_1.leftNameTxt_.text = var_41_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_18 = arg_38_1:GetWordFromCfg(411251009)
				local var_41_19 = arg_38_1:FormatText(var_41_18.content)

				arg_38_1.text_.text = var_41_19

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_20 = 2
				local var_41_21 = utf8.len(var_41_19)
				local var_41_22 = var_41_20 <= 0 and var_41_16 or var_41_16 * (var_41_21 / var_41_20)

				if var_41_22 > 0 and var_41_16 < var_41_22 then
					arg_38_1.talkMaxDuration = var_41_22

					if var_41_22 + var_41_15 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_22 + var_41_15
					end
				end

				arg_38_1.text_.text = var_41_19
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251009", "story_v_out_411251.awb") ~= 0 then
					local var_41_23 = manager.audio:GetVoiceLength("story_v_out_411251", "411251009", "story_v_out_411251.awb") / 1000

					if var_41_23 + var_41_15 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_23 + var_41_15
					end

					if var_41_18.prefab_name ~= "" and arg_38_1.actors_[var_41_18.prefab_name] ~= nil then
						local var_41_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_18.prefab_name].transform, "story_v_out_411251", "411251009", "story_v_out_411251.awb")

						arg_38_1:RecordAudio("411251009", var_41_24)
						arg_38_1:RecordAudio("411251009", var_41_24)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_411251", "411251009", "story_v_out_411251.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_411251", "411251009", "story_v_out_411251.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_25 = math.max(var_41_16, arg_38_1.talkMaxDuration)

			if var_41_15 <= arg_38_1.time_ and arg_38_1.time_ < var_41_15 + var_41_25 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_15) / var_41_25

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_15 + var_41_25 and arg_38_1.time_ < var_41_15 + var_41_25 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play411251010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 411251010
		arg_42_1.duration_ = 5.37

		local var_42_0 = {
			zh = 5.366,
			ja = 4.766
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play411251011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0
			local var_45_1 = 0.575

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_2 = arg_42_1:FormatText(StoryNameCfg[471].name)

				arg_42_1.leftNameTxt_.text = var_45_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_3 = arg_42_1:GetWordFromCfg(411251010)
				local var_45_4 = arg_42_1:FormatText(var_45_3.content)

				arg_42_1.text_.text = var_45_4

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 23
				local var_45_6 = utf8.len(var_45_4)
				local var_45_7 = var_45_5 <= 0 and var_45_1 or var_45_1 * (var_45_6 / var_45_5)

				if var_45_7 > 0 and var_45_1 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_0
					end
				end

				arg_42_1.text_.text = var_45_4
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251010", "story_v_out_411251.awb") ~= 0 then
					local var_45_8 = manager.audio:GetVoiceLength("story_v_out_411251", "411251010", "story_v_out_411251.awb") / 1000

					if var_45_8 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_8 + var_45_0
					end

					if var_45_3.prefab_name ~= "" and arg_42_1.actors_[var_45_3.prefab_name] ~= nil then
						local var_45_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_3.prefab_name].transform, "story_v_out_411251", "411251010", "story_v_out_411251.awb")

						arg_42_1:RecordAudio("411251010", var_45_9)
						arg_42_1:RecordAudio("411251010", var_45_9)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_411251", "411251010", "story_v_out_411251.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_411251", "411251010", "story_v_out_411251.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_10 = math.max(var_45_1, arg_42_1.talkMaxDuration)

			if var_45_0 <= arg_42_1.time_ and arg_42_1.time_ < var_45_0 + var_45_10 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_0) / var_45_10

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_0 + var_45_10 and arg_42_1.time_ < var_45_0 + var_45_10 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play411251011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 411251011
		arg_46_1.duration_ = 4.87

		local var_46_0 = {
			zh = 4.866,
			ja = 3.733
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play411251012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["10058ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect10058ui_story == nil then
				arg_46_1.var_.characterEffect10058ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.200000002980232

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect10058ui_story and not isNil(var_49_0) then
					local var_49_4 = Mathf.Lerp(0, 0.5, var_49_3)

					arg_46_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_46_1.var_.characterEffect10058ui_story.fillRatio = var_49_4
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect10058ui_story then
				local var_49_5 = 0.5

				arg_46_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_46_1.var_.characterEffect10058ui_story.fillRatio = var_49_5
			end

			local var_49_6 = 0
			local var_49_7 = 0.35

			if var_49_6 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_8 = arg_46_1:FormatText(StoryNameCfg[328].name)

				arg_46_1.leftNameTxt_.text = var_49_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_9 = arg_46_1:GetWordFromCfg(411251011)
				local var_49_10 = arg_46_1:FormatText(var_49_9.content)

				arg_46_1.text_.text = var_49_10

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_11 = 14
				local var_49_12 = utf8.len(var_49_10)
				local var_49_13 = var_49_11 <= 0 and var_49_7 or var_49_7 * (var_49_12 / var_49_11)

				if var_49_13 > 0 and var_49_7 < var_49_13 then
					arg_46_1.talkMaxDuration = var_49_13

					if var_49_13 + var_49_6 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_13 + var_49_6
					end
				end

				arg_46_1.text_.text = var_49_10
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251011", "story_v_out_411251.awb") ~= 0 then
					local var_49_14 = manager.audio:GetVoiceLength("story_v_out_411251", "411251011", "story_v_out_411251.awb") / 1000

					if var_49_14 + var_49_6 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_14 + var_49_6
					end

					if var_49_9.prefab_name ~= "" and arg_46_1.actors_[var_49_9.prefab_name] ~= nil then
						local var_49_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_9.prefab_name].transform, "story_v_out_411251", "411251011", "story_v_out_411251.awb")

						arg_46_1:RecordAudio("411251011", var_49_15)
						arg_46_1:RecordAudio("411251011", var_49_15)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_411251", "411251011", "story_v_out_411251.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_411251", "411251011", "story_v_out_411251.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_16 = math.max(var_49_7, arg_46_1.talkMaxDuration)

			if var_49_6 <= arg_46_1.time_ and arg_46_1.time_ < var_49_6 + var_49_16 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_6) / var_49_16

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_6 + var_49_16 and arg_46_1.time_ < var_49_6 + var_49_16 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play411251012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 411251012
		arg_50_1.duration_ = 6.03

		local var_50_0 = {
			zh = 2.833,
			ja = 6.033
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play411251013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["10058ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect10058ui_story == nil then
				arg_50_1.var_.characterEffect10058ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.200000002980232

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect10058ui_story and not isNil(var_53_0) then
					arg_50_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect10058ui_story then
				arg_50_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_53_4 = 0

			if var_53_4 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_53_5 = 0

			if var_53_5 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_53_6 = 0
			local var_53_7 = 0.3

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_8 = arg_50_1:FormatText(StoryNameCfg[471].name)

				arg_50_1.leftNameTxt_.text = var_53_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_9 = arg_50_1:GetWordFromCfg(411251012)
				local var_53_10 = arg_50_1:FormatText(var_53_9.content)

				arg_50_1.text_.text = var_53_10

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 12
				local var_53_12 = utf8.len(var_53_10)
				local var_53_13 = var_53_11 <= 0 and var_53_7 or var_53_7 * (var_53_12 / var_53_11)

				if var_53_13 > 0 and var_53_7 < var_53_13 then
					arg_50_1.talkMaxDuration = var_53_13

					if var_53_13 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_13 + var_53_6
					end
				end

				arg_50_1.text_.text = var_53_10
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251012", "story_v_out_411251.awb") ~= 0 then
					local var_53_14 = manager.audio:GetVoiceLength("story_v_out_411251", "411251012", "story_v_out_411251.awb") / 1000

					if var_53_14 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_14 + var_53_6
					end

					if var_53_9.prefab_name ~= "" and arg_50_1.actors_[var_53_9.prefab_name] ~= nil then
						local var_53_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_9.prefab_name].transform, "story_v_out_411251", "411251012", "story_v_out_411251.awb")

						arg_50_1:RecordAudio("411251012", var_53_15)
						arg_50_1:RecordAudio("411251012", var_53_15)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_411251", "411251012", "story_v_out_411251.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_411251", "411251012", "story_v_out_411251.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_16 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_16 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_16

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_16 and arg_50_1.time_ < var_53_6 + var_53_16 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play411251013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 411251013
		arg_54_1.duration_ = 2.3

		local var_54_0 = {
			zh = 1.8,
			ja = 2.3
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play411251014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["10058ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect10058ui_story == nil then
				arg_54_1.var_.characterEffect10058ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect10058ui_story and not isNil(var_57_0) then
					local var_57_4 = Mathf.Lerp(0, 0.5, var_57_3)

					arg_54_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_54_1.var_.characterEffect10058ui_story.fillRatio = var_57_4
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect10058ui_story then
				local var_57_5 = 0.5

				arg_54_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_54_1.var_.characterEffect10058ui_story.fillRatio = var_57_5
			end

			local var_57_6 = 0
			local var_57_7 = 0.075

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_8 = arg_54_1:FormatText(StoryNameCfg[328].name)

				arg_54_1.leftNameTxt_.text = var_57_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_9 = arg_54_1:GetWordFromCfg(411251013)
				local var_57_10 = arg_54_1:FormatText(var_57_9.content)

				arg_54_1.text_.text = var_57_10

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_11 = 3
				local var_57_12 = utf8.len(var_57_10)
				local var_57_13 = var_57_11 <= 0 and var_57_7 or var_57_7 * (var_57_12 / var_57_11)

				if var_57_13 > 0 and var_57_7 < var_57_13 then
					arg_54_1.talkMaxDuration = var_57_13

					if var_57_13 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_13 + var_57_6
					end
				end

				arg_54_1.text_.text = var_57_10
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251013", "story_v_out_411251.awb") ~= 0 then
					local var_57_14 = manager.audio:GetVoiceLength("story_v_out_411251", "411251013", "story_v_out_411251.awb") / 1000

					if var_57_14 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_14 + var_57_6
					end

					if var_57_9.prefab_name ~= "" and arg_54_1.actors_[var_57_9.prefab_name] ~= nil then
						local var_57_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_9.prefab_name].transform, "story_v_out_411251", "411251013", "story_v_out_411251.awb")

						arg_54_1:RecordAudio("411251013", var_57_15)
						arg_54_1:RecordAudio("411251013", var_57_15)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_411251", "411251013", "story_v_out_411251.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_411251", "411251013", "story_v_out_411251.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_16 = math.max(var_57_7, arg_54_1.talkMaxDuration)

			if var_57_6 <= arg_54_1.time_ and arg_54_1.time_ < var_57_6 + var_57_16 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_6) / var_57_16

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_6 + var_57_16 and arg_54_1.time_ < var_57_6 + var_57_16 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play411251014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 411251014
		arg_58_1.duration_ = 8.9

		local var_58_0 = {
			zh = 8.9,
			ja = 6.433
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play411251015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["10058ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect10058ui_story == nil then
				arg_58_1.var_.characterEffect10058ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect10058ui_story and not isNil(var_61_0) then
					arg_58_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect10058ui_story then
				arg_58_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_61_4 = 0
			local var_61_5 = 0.95

			if var_61_4 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_6 = arg_58_1:FormatText(StoryNameCfg[471].name)

				arg_58_1.leftNameTxt_.text = var_61_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_7 = arg_58_1:GetWordFromCfg(411251014)
				local var_61_8 = arg_58_1:FormatText(var_61_7.content)

				arg_58_1.text_.text = var_61_8

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_9 = 38
				local var_61_10 = utf8.len(var_61_8)
				local var_61_11 = var_61_9 <= 0 and var_61_5 or var_61_5 * (var_61_10 / var_61_9)

				if var_61_11 > 0 and var_61_5 < var_61_11 then
					arg_58_1.talkMaxDuration = var_61_11

					if var_61_11 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_11 + var_61_4
					end
				end

				arg_58_1.text_.text = var_61_8
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251014", "story_v_out_411251.awb") ~= 0 then
					local var_61_12 = manager.audio:GetVoiceLength("story_v_out_411251", "411251014", "story_v_out_411251.awb") / 1000

					if var_61_12 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_12 + var_61_4
					end

					if var_61_7.prefab_name ~= "" and arg_58_1.actors_[var_61_7.prefab_name] ~= nil then
						local var_61_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_7.prefab_name].transform, "story_v_out_411251", "411251014", "story_v_out_411251.awb")

						arg_58_1:RecordAudio("411251014", var_61_13)
						arg_58_1:RecordAudio("411251014", var_61_13)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_411251", "411251014", "story_v_out_411251.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_411251", "411251014", "story_v_out_411251.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_14 = math.max(var_61_5, arg_58_1.talkMaxDuration)

			if var_61_4 <= arg_58_1.time_ and arg_58_1.time_ < var_61_4 + var_61_14 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_4) / var_61_14

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_4 + var_61_14 and arg_58_1.time_ < var_61_4 + var_61_14 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play411251015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 411251015
		arg_62_1.duration_ = 3.93

		local var_62_0 = {
			zh = 3.933,
			ja = 3.833
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play411251016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["10058ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect10058ui_story == nil then
				arg_62_1.var_.characterEffect10058ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect10058ui_story and not isNil(var_65_0) then
					local var_65_4 = Mathf.Lerp(0, 0.5, var_65_3)

					arg_62_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_62_1.var_.characterEffect10058ui_story.fillRatio = var_65_4
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect10058ui_story then
				local var_65_5 = 0.5

				arg_62_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_62_1.var_.characterEffect10058ui_story.fillRatio = var_65_5
			end

			local var_65_6 = 0
			local var_65_7 = 0.225

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_8 = arg_62_1:FormatText(StoryNameCfg[328].name)

				arg_62_1.leftNameTxt_.text = var_65_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_9 = arg_62_1:GetWordFromCfg(411251015)
				local var_65_10 = arg_62_1:FormatText(var_65_9.content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 9
				local var_65_12 = utf8.len(var_65_10)
				local var_65_13 = var_65_11 <= 0 and var_65_7 or var_65_7 * (var_65_12 / var_65_11)

				if var_65_13 > 0 and var_65_7 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_6
					end
				end

				arg_62_1.text_.text = var_65_10
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251015", "story_v_out_411251.awb") ~= 0 then
					local var_65_14 = manager.audio:GetVoiceLength("story_v_out_411251", "411251015", "story_v_out_411251.awb") / 1000

					if var_65_14 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_14 + var_65_6
					end

					if var_65_9.prefab_name ~= "" and arg_62_1.actors_[var_65_9.prefab_name] ~= nil then
						local var_65_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_9.prefab_name].transform, "story_v_out_411251", "411251015", "story_v_out_411251.awb")

						arg_62_1:RecordAudio("411251015", var_65_15)
						arg_62_1:RecordAudio("411251015", var_65_15)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_411251", "411251015", "story_v_out_411251.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_411251", "411251015", "story_v_out_411251.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_16 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_16 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_16

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_16 and arg_62_1.time_ < var_65_6 + var_65_16 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play411251016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 411251016
		arg_66_1.duration_ = 7.13

		local var_66_0 = {
			zh = 6.766,
			ja = 7.133
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play411251017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["10058ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect10058ui_story == nil then
				arg_66_1.var_.characterEffect10058ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect10058ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect10058ui_story then
				arg_66_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_69_4 = 0

			if var_69_4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_69_6 = 0
			local var_69_7 = 0.75

			if var_69_6 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_8 = arg_66_1:FormatText(StoryNameCfg[471].name)

				arg_66_1.leftNameTxt_.text = var_69_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_9 = arg_66_1:GetWordFromCfg(411251016)
				local var_69_10 = arg_66_1:FormatText(var_69_9.content)

				arg_66_1.text_.text = var_69_10

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_11 = 30
				local var_69_12 = utf8.len(var_69_10)
				local var_69_13 = var_69_11 <= 0 and var_69_7 or var_69_7 * (var_69_12 / var_69_11)

				if var_69_13 > 0 and var_69_7 < var_69_13 then
					arg_66_1.talkMaxDuration = var_69_13

					if var_69_13 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_13 + var_69_6
					end
				end

				arg_66_1.text_.text = var_69_10
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251016", "story_v_out_411251.awb") ~= 0 then
					local var_69_14 = manager.audio:GetVoiceLength("story_v_out_411251", "411251016", "story_v_out_411251.awb") / 1000

					if var_69_14 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_14 + var_69_6
					end

					if var_69_9.prefab_name ~= "" and arg_66_1.actors_[var_69_9.prefab_name] ~= nil then
						local var_69_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_9.prefab_name].transform, "story_v_out_411251", "411251016", "story_v_out_411251.awb")

						arg_66_1:RecordAudio("411251016", var_69_15)
						arg_66_1:RecordAudio("411251016", var_69_15)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_411251", "411251016", "story_v_out_411251.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_411251", "411251016", "story_v_out_411251.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_16 = math.max(var_69_7, arg_66_1.talkMaxDuration)

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_16 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_6) / var_69_16

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_6 + var_69_16 and arg_66_1.time_ < var_69_6 + var_69_16 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play411251017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 411251017
		arg_70_1.duration_ = 5.47

		local var_70_0 = {
			zh = 3.633,
			ja = 5.466
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play411251018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["10058ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10058ui_story == nil then
				arg_70_1.var_.characterEffect10058ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect10058ui_story and not isNil(var_73_0) then
					local var_73_4 = Mathf.Lerp(0, 0.5, var_73_3)

					arg_70_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_70_1.var_.characterEffect10058ui_story.fillRatio = var_73_4
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10058ui_story then
				local var_73_5 = 0.5

				arg_70_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_70_1.var_.characterEffect10058ui_story.fillRatio = var_73_5
			end

			local var_73_6 = 0
			local var_73_7 = 0.3

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_8 = arg_70_1:FormatText(StoryNameCfg[328].name)

				arg_70_1.leftNameTxt_.text = var_73_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_9 = arg_70_1:GetWordFromCfg(411251017)
				local var_73_10 = arg_70_1:FormatText(var_73_9.content)

				arg_70_1.text_.text = var_73_10

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 12
				local var_73_12 = utf8.len(var_73_10)
				local var_73_13 = var_73_11 <= 0 and var_73_7 or var_73_7 * (var_73_12 / var_73_11)

				if var_73_13 > 0 and var_73_7 < var_73_13 then
					arg_70_1.talkMaxDuration = var_73_13

					if var_73_13 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_13 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_10
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251017", "story_v_out_411251.awb") ~= 0 then
					local var_73_14 = manager.audio:GetVoiceLength("story_v_out_411251", "411251017", "story_v_out_411251.awb") / 1000

					if var_73_14 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_14 + var_73_6
					end

					if var_73_9.prefab_name ~= "" and arg_70_1.actors_[var_73_9.prefab_name] ~= nil then
						local var_73_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_9.prefab_name].transform, "story_v_out_411251", "411251017", "story_v_out_411251.awb")

						arg_70_1:RecordAudio("411251017", var_73_15)
						arg_70_1:RecordAudio("411251017", var_73_15)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_411251", "411251017", "story_v_out_411251.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_411251", "411251017", "story_v_out_411251.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_16 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_16 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_16

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_16 and arg_70_1.time_ < var_73_6 + var_73_16 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play411251018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 411251018
		arg_74_1.duration_ = 10.5

		local var_74_0 = {
			zh = 10.5,
			ja = 8.8
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play411251019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["10058ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect10058ui_story == nil then
				arg_74_1.var_.characterEffect10058ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.200000002980232

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect10058ui_story and not isNil(var_77_0) then
					arg_74_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect10058ui_story then
				arg_74_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_77_4 = 0
			local var_77_5 = 1.225

			if var_77_4 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_6 = arg_74_1:FormatText(StoryNameCfg[471].name)

				arg_74_1.leftNameTxt_.text = var_77_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_7 = arg_74_1:GetWordFromCfg(411251018)
				local var_77_8 = arg_74_1:FormatText(var_77_7.content)

				arg_74_1.text_.text = var_77_8

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_9 = 49
				local var_77_10 = utf8.len(var_77_8)
				local var_77_11 = var_77_9 <= 0 and var_77_5 or var_77_5 * (var_77_10 / var_77_9)

				if var_77_11 > 0 and var_77_5 < var_77_11 then
					arg_74_1.talkMaxDuration = var_77_11

					if var_77_11 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_11 + var_77_4
					end
				end

				arg_74_1.text_.text = var_77_8
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251018", "story_v_out_411251.awb") ~= 0 then
					local var_77_12 = manager.audio:GetVoiceLength("story_v_out_411251", "411251018", "story_v_out_411251.awb") / 1000

					if var_77_12 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_12 + var_77_4
					end

					if var_77_7.prefab_name ~= "" and arg_74_1.actors_[var_77_7.prefab_name] ~= nil then
						local var_77_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_7.prefab_name].transform, "story_v_out_411251", "411251018", "story_v_out_411251.awb")

						arg_74_1:RecordAudio("411251018", var_77_13)
						arg_74_1:RecordAudio("411251018", var_77_13)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_411251", "411251018", "story_v_out_411251.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_411251", "411251018", "story_v_out_411251.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_14 = math.max(var_77_5, arg_74_1.talkMaxDuration)

			if var_77_4 <= arg_74_1.time_ and arg_74_1.time_ < var_77_4 + var_77_14 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_4) / var_77_14

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_4 + var_77_14 and arg_74_1.time_ < var_77_4 + var_77_14 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play411251019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 411251019
		arg_78_1.duration_ = 4.83

		local var_78_0 = {
			zh = 4.833,
			ja = 4.366
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play411251020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.475

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[471].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_3 = arg_78_1:GetWordFromCfg(411251019)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 19
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251019", "story_v_out_411251.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_411251", "411251019", "story_v_out_411251.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_411251", "411251019", "story_v_out_411251.awb")

						arg_78_1:RecordAudio("411251019", var_81_9)
						arg_78_1:RecordAudio("411251019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_411251", "411251019", "story_v_out_411251.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_411251", "411251019", "story_v_out_411251.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_10 and arg_78_1.time_ < var_81_0 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play411251020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 411251020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play411251021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["10058ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10058ui_story == nil then
				arg_82_1.var_.characterEffect10058ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.200000002980232

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect10058ui_story and not isNil(var_85_0) then
					local var_85_4 = Mathf.Lerp(0, 0.5, var_85_3)

					arg_82_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_82_1.var_.characterEffect10058ui_story.fillRatio = var_85_4
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10058ui_story then
				local var_85_5 = 0.5

				arg_82_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_82_1.var_.characterEffect10058ui_story.fillRatio = var_85_5
			end

			local var_85_6 = 0
			local var_85_7 = 1.25

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_8 = arg_82_1:GetWordFromCfg(411251020)
				local var_85_9 = arg_82_1:FormatText(var_85_8.content)

				arg_82_1.text_.text = var_85_9

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_10 = 50
				local var_85_11 = utf8.len(var_85_9)
				local var_85_12 = var_85_10 <= 0 and var_85_7 or var_85_7 * (var_85_11 / var_85_10)

				if var_85_12 > 0 and var_85_7 < var_85_12 then
					arg_82_1.talkMaxDuration = var_85_12

					if var_85_12 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_12 + var_85_6
					end
				end

				arg_82_1.text_.text = var_85_9
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_13 = math.max(var_85_7, arg_82_1.talkMaxDuration)

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_13 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_6) / var_85_13

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_6 + var_85_13 and arg_82_1.time_ < var_85_6 + var_85_13 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play411251021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 411251021
		arg_86_1.duration_ = 5.8

		local var_86_0 = {
			zh = 3.733,
			ja = 5.8
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play411251022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 0.3

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_2 = arg_86_1:FormatText(StoryNameCfg[328].name)

				arg_86_1.leftNameTxt_.text = var_89_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_3 = arg_86_1:GetWordFromCfg(411251021)
				local var_89_4 = arg_86_1:FormatText(var_89_3.content)

				arg_86_1.text_.text = var_89_4

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 12
				local var_89_6 = utf8.len(var_89_4)
				local var_89_7 = var_89_5 <= 0 and var_89_1 or var_89_1 * (var_89_6 / var_89_5)

				if var_89_7 > 0 and var_89_1 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_4
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251021", "story_v_out_411251.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_411251", "411251021", "story_v_out_411251.awb") / 1000

					if var_89_8 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_0
					end

					if var_89_3.prefab_name ~= "" and arg_86_1.actors_[var_89_3.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_3.prefab_name].transform, "story_v_out_411251", "411251021", "story_v_out_411251.awb")

						arg_86_1:RecordAudio("411251021", var_89_9)
						arg_86_1:RecordAudio("411251021", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_411251", "411251021", "story_v_out_411251.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_411251", "411251021", "story_v_out_411251.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_10 and arg_86_1.time_ < var_89_0 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play411251022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 411251022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play411251023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.525

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_2 = arg_90_1:GetWordFromCfg(411251022)
				local var_93_3 = arg_90_1:FormatText(var_93_2.content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 21
				local var_93_5 = utf8.len(var_93_3)
				local var_93_6 = var_93_4 <= 0 and var_93_1 or var_93_1 * (var_93_5 / var_93_4)

				if var_93_6 > 0 and var_93_1 < var_93_6 then
					arg_90_1.talkMaxDuration = var_93_6

					if var_93_6 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_7 and arg_90_1.time_ < var_93_0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play411251023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 411251023
		arg_94_1.duration_ = 9.83

		local var_94_0 = {
			zh = 6.433,
			ja = 9.833
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play411251024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["10058ui_story"].transform
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1.var_.moveOldPos10058ui_story = var_97_0.localPosition
			end

			local var_97_2 = 0.001

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2
				local var_97_4 = Vector3.New(0, -0.98, -6.1)

				var_97_0.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos10058ui_story, var_97_4, var_97_3)

				local var_97_5 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_5.x, var_97_5.y, var_97_5.z)

				local var_97_6 = var_97_0.localEulerAngles

				var_97_6.z = 0
				var_97_6.x = 0
				var_97_0.localEulerAngles = var_97_6
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 then
				var_97_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_97_7 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_7.x, var_97_7.y, var_97_7.z)

				local var_97_8 = var_97_0.localEulerAngles

				var_97_8.z = 0
				var_97_8.x = 0
				var_97_0.localEulerAngles = var_97_8
			end

			local var_97_9 = arg_94_1.actors_["10058ui_story"]
			local var_97_10 = 0

			if var_97_10 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 and not isNil(var_97_9) and arg_94_1.var_.characterEffect10058ui_story == nil then
				arg_94_1.var_.characterEffect10058ui_story = var_97_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_11 = 0.200000002980232

			if var_97_10 <= arg_94_1.time_ and arg_94_1.time_ < var_97_10 + var_97_11 and not isNil(var_97_9) then
				local var_97_12 = (arg_94_1.time_ - var_97_10) / var_97_11

				if arg_94_1.var_.characterEffect10058ui_story and not isNil(var_97_9) then
					arg_94_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_10 + var_97_11 and arg_94_1.time_ < var_97_10 + var_97_11 + arg_97_0 and not isNil(var_97_9) and arg_94_1.var_.characterEffect10058ui_story then
				arg_94_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_97_13 = 0
			local var_97_14 = 0.75

			if var_97_13 < arg_94_1.time_ and arg_94_1.time_ <= var_97_13 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_15 = arg_94_1:FormatText(StoryNameCfg[471].name)

				arg_94_1.leftNameTxt_.text = var_97_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_16 = arg_94_1:GetWordFromCfg(411251023)
				local var_97_17 = arg_94_1:FormatText(var_97_16.content)

				arg_94_1.text_.text = var_97_17

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_18 = 30
				local var_97_19 = utf8.len(var_97_17)
				local var_97_20 = var_97_18 <= 0 and var_97_14 or var_97_14 * (var_97_19 / var_97_18)

				if var_97_20 > 0 and var_97_14 < var_97_20 then
					arg_94_1.talkMaxDuration = var_97_20

					if var_97_20 + var_97_13 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_20 + var_97_13
					end
				end

				arg_94_1.text_.text = var_97_17
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251023", "story_v_out_411251.awb") ~= 0 then
					local var_97_21 = manager.audio:GetVoiceLength("story_v_out_411251", "411251023", "story_v_out_411251.awb") / 1000

					if var_97_21 + var_97_13 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_21 + var_97_13
					end

					if var_97_16.prefab_name ~= "" and arg_94_1.actors_[var_97_16.prefab_name] ~= nil then
						local var_97_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_16.prefab_name].transform, "story_v_out_411251", "411251023", "story_v_out_411251.awb")

						arg_94_1:RecordAudio("411251023", var_97_22)
						arg_94_1:RecordAudio("411251023", var_97_22)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_411251", "411251023", "story_v_out_411251.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_411251", "411251023", "story_v_out_411251.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_23 = math.max(var_97_14, arg_94_1.talkMaxDuration)

			if var_97_13 <= arg_94_1.time_ and arg_94_1.time_ < var_97_13 + var_97_23 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_13) / var_97_23

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_13 + var_97_23 and arg_94_1.time_ < var_97_13 + var_97_23 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play411251024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 411251024
		arg_98_1.duration_ = 6.63

		local var_98_0 = {
			zh = 6.633,
			ja = 6.333
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play411251025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["10058ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10058ui_story == nil then
				arg_98_1.var_.characterEffect10058ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect10058ui_story and not isNil(var_101_0) then
					local var_101_4 = Mathf.Lerp(0, 0.5, var_101_3)

					arg_98_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_98_1.var_.characterEffect10058ui_story.fillRatio = var_101_4
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10058ui_story then
				local var_101_5 = 0.5

				arg_98_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_98_1.var_.characterEffect10058ui_story.fillRatio = var_101_5
			end

			local var_101_6 = 0
			local var_101_7 = 0.4

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_8 = arg_98_1:FormatText(StoryNameCfg[328].name)

				arg_98_1.leftNameTxt_.text = var_101_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_9 = arg_98_1:GetWordFromCfg(411251024)
				local var_101_10 = arg_98_1:FormatText(var_101_9.content)

				arg_98_1.text_.text = var_101_10

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_11 = 16
				local var_101_12 = utf8.len(var_101_10)
				local var_101_13 = var_101_11 <= 0 and var_101_7 or var_101_7 * (var_101_12 / var_101_11)

				if var_101_13 > 0 and var_101_7 < var_101_13 then
					arg_98_1.talkMaxDuration = var_101_13

					if var_101_13 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_6
					end
				end

				arg_98_1.text_.text = var_101_10
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251024", "story_v_out_411251.awb") ~= 0 then
					local var_101_14 = manager.audio:GetVoiceLength("story_v_out_411251", "411251024", "story_v_out_411251.awb") / 1000

					if var_101_14 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_14 + var_101_6
					end

					if var_101_9.prefab_name ~= "" and arg_98_1.actors_[var_101_9.prefab_name] ~= nil then
						local var_101_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_9.prefab_name].transform, "story_v_out_411251", "411251024", "story_v_out_411251.awb")

						arg_98_1:RecordAudio("411251024", var_101_15)
						arg_98_1:RecordAudio("411251024", var_101_15)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_411251", "411251024", "story_v_out_411251.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_411251", "411251024", "story_v_out_411251.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_16 = math.max(var_101_7, arg_98_1.talkMaxDuration)

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_16 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_6) / var_101_16

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_6 + var_101_16 and arg_98_1.time_ < var_101_6 + var_101_16 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play411251025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 411251025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play411251026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 1.3

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_2 = arg_102_1:GetWordFromCfg(411251025)
				local var_105_3 = arg_102_1:FormatText(var_105_2.content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 52
				local var_105_5 = utf8.len(var_105_3)
				local var_105_6 = var_105_4 <= 0 and var_105_1 or var_105_1 * (var_105_5 / var_105_4)

				if var_105_6 > 0 and var_105_1 < var_105_6 then
					arg_102_1.talkMaxDuration = var_105_6

					if var_105_6 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_6 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_7 and arg_102_1.time_ < var_105_0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play411251026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 411251026
		arg_106_1.duration_ = 5.17

		local var_106_0 = {
			zh = 3.933,
			ja = 5.166
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play411251027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.25

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[328].name)

				arg_106_1.leftNameTxt_.text = var_109_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:GetWordFromCfg(411251026)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 10
				local var_109_6 = utf8.len(var_109_4)
				local var_109_7 = var_109_5 <= 0 and var_109_1 or var_109_1 * (var_109_6 / var_109_5)

				if var_109_7 > 0 and var_109_1 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_4
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251026", "story_v_out_411251.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_411251", "411251026", "story_v_out_411251.awb") / 1000

					if var_109_8 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_0
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_411251", "411251026", "story_v_out_411251.awb")

						arg_106_1:RecordAudio("411251026", var_109_9)
						arg_106_1:RecordAudio("411251026", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_411251", "411251026", "story_v_out_411251.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_411251", "411251026", "story_v_out_411251.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_10 and arg_106_1.time_ < var_109_0 + var_109_10 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play411251027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 411251027
		arg_110_1.duration_ = 2.3

		local var_110_0 = {
			zh = 2.3,
			ja = 1.999999999999
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play411251028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["10058ui_story"].transform
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.var_.moveOldPos10058ui_story = var_113_0.localPosition
			end

			local var_113_2 = 0.001

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2
				local var_113_4 = Vector3.New(0, -0.98, -6.1)

				var_113_0.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10058ui_story, var_113_4, var_113_3)

				local var_113_5 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_5.x, var_113_5.y, var_113_5.z)

				local var_113_6 = var_113_0.localEulerAngles

				var_113_6.z = 0
				var_113_6.x = 0
				var_113_0.localEulerAngles = var_113_6
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 then
				var_113_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_113_7 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_7.x, var_113_7.y, var_113_7.z)

				local var_113_8 = var_113_0.localEulerAngles

				var_113_8.z = 0
				var_113_8.x = 0
				var_113_0.localEulerAngles = var_113_8
			end

			local var_113_9 = arg_110_1.actors_["10058ui_story"]
			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 and not isNil(var_113_9) and arg_110_1.var_.characterEffect10058ui_story == nil then
				arg_110_1.var_.characterEffect10058ui_story = var_113_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_11 = 0.200000002980232

			if var_113_10 <= arg_110_1.time_ and arg_110_1.time_ < var_113_10 + var_113_11 and not isNil(var_113_9) then
				local var_113_12 = (arg_110_1.time_ - var_113_10) / var_113_11

				if arg_110_1.var_.characterEffect10058ui_story and not isNil(var_113_9) then
					arg_110_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_10 + var_113_11 and arg_110_1.time_ < var_113_10 + var_113_11 + arg_113_0 and not isNil(var_113_9) and arg_110_1.var_.characterEffect10058ui_story then
				arg_110_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_113_13 = 0

			if var_113_13 < arg_110_1.time_ and arg_110_1.time_ <= var_113_13 + arg_113_0 then
				arg_110_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_113_14 = 0

			if var_113_14 < arg_110_1.time_ and arg_110_1.time_ <= var_113_14 + arg_113_0 then
				arg_110_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_113_15 = 0
			local var_113_16 = 0.15

			if var_113_15 < arg_110_1.time_ and arg_110_1.time_ <= var_113_15 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_17 = arg_110_1:FormatText(StoryNameCfg[471].name)

				arg_110_1.leftNameTxt_.text = var_113_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_18 = arg_110_1:GetWordFromCfg(411251027)
				local var_113_19 = arg_110_1:FormatText(var_113_18.content)

				arg_110_1.text_.text = var_113_19

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_20 = 6
				local var_113_21 = utf8.len(var_113_19)
				local var_113_22 = var_113_20 <= 0 and var_113_16 or var_113_16 * (var_113_21 / var_113_20)

				if var_113_22 > 0 and var_113_16 < var_113_22 then
					arg_110_1.talkMaxDuration = var_113_22

					if var_113_22 + var_113_15 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_22 + var_113_15
					end
				end

				arg_110_1.text_.text = var_113_19
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251027", "story_v_out_411251.awb") ~= 0 then
					local var_113_23 = manager.audio:GetVoiceLength("story_v_out_411251", "411251027", "story_v_out_411251.awb") / 1000

					if var_113_23 + var_113_15 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_23 + var_113_15
					end

					if var_113_18.prefab_name ~= "" and arg_110_1.actors_[var_113_18.prefab_name] ~= nil then
						local var_113_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_18.prefab_name].transform, "story_v_out_411251", "411251027", "story_v_out_411251.awb")

						arg_110_1:RecordAudio("411251027", var_113_24)
						arg_110_1:RecordAudio("411251027", var_113_24)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_411251", "411251027", "story_v_out_411251.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_411251", "411251027", "story_v_out_411251.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_25 = math.max(var_113_16, arg_110_1.talkMaxDuration)

			if var_113_15 <= arg_110_1.time_ and arg_110_1.time_ < var_113_15 + var_113_25 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_15) / var_113_25

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_15 + var_113_25 and arg_110_1.time_ < var_113_15 + var_113_25 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play411251028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 411251028
		arg_114_1.duration_ = 4.13

		local var_114_0 = {
			zh = 4.133,
			ja = 1.7
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play411251029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.45

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[471].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_3 = arg_114_1:GetWordFromCfg(411251028)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 18
				local var_117_6 = utf8.len(var_117_4)
				local var_117_7 = var_117_5 <= 0 and var_117_1 or var_117_1 * (var_117_6 / var_117_5)

				if var_117_7 > 0 and var_117_1 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251028", "story_v_out_411251.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_411251", "411251028", "story_v_out_411251.awb") / 1000

					if var_117_8 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_0
					end

					if var_117_3.prefab_name ~= "" and arg_114_1.actors_[var_117_3.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_3.prefab_name].transform, "story_v_out_411251", "411251028", "story_v_out_411251.awb")

						arg_114_1:RecordAudio("411251028", var_117_9)
						arg_114_1:RecordAudio("411251028", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_411251", "411251028", "story_v_out_411251.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_411251", "411251028", "story_v_out_411251.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_10 and arg_114_1.time_ < var_117_0 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play411251029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 411251029
		arg_118_1.duration_ = 9

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play411251030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = "L01f"

			if arg_118_1.bgs_[var_121_0] == nil then
				local var_121_1 = Object.Instantiate(arg_118_1.paintGo_)

				var_121_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_121_0)
				var_121_1.name = var_121_0
				var_121_1.transform.parent = arg_118_1.stage_.transform
				var_121_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_118_1.bgs_[var_121_0] = var_121_1
			end

			local var_121_2 = 2

			if var_121_2 < arg_118_1.time_ and arg_118_1.time_ <= var_121_2 + arg_121_0 then
				local var_121_3 = manager.ui.mainCamera.transform.localPosition
				local var_121_4 = Vector3.New(0, 0, 10) + Vector3.New(var_121_3.x, var_121_3.y, 0)
				local var_121_5 = arg_118_1.bgs_.L01f

				var_121_5.transform.localPosition = var_121_4
				var_121_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_121_6 = var_121_5:GetComponent("SpriteRenderer")

				if var_121_6 and var_121_6.sprite then
					local var_121_7 = (var_121_5.transform.localPosition - var_121_3).z
					local var_121_8 = manager.ui.mainCameraCom_
					local var_121_9 = 2 * var_121_7 * Mathf.Tan(var_121_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_121_10 = var_121_9 * var_121_8.aspect
					local var_121_11 = var_121_6.sprite.bounds.size.x
					local var_121_12 = var_121_6.sprite.bounds.size.y
					local var_121_13 = var_121_10 / var_121_11
					local var_121_14 = var_121_9 / var_121_12
					local var_121_15 = var_121_14 < var_121_13 and var_121_13 or var_121_14

					var_121_5.transform.localScale = Vector3.New(var_121_15, var_121_15, 0)
				end

				for iter_121_0, iter_121_1 in pairs(arg_118_1.bgs_) do
					if iter_121_0 ~= "L01f" then
						iter_121_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_121_16 = 0

			if var_121_16 < arg_118_1.time_ and arg_118_1.time_ <= var_121_16 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_17 = 2

			if var_121_16 <= arg_118_1.time_ and arg_118_1.time_ < var_121_16 + var_121_17 then
				local var_121_18 = (arg_118_1.time_ - var_121_16) / var_121_17
				local var_121_19 = Color.New(0, 0, 0)

				var_121_19.a = Mathf.Lerp(0, 1, var_121_18)
				arg_118_1.mask_.color = var_121_19
			end

			if arg_118_1.time_ >= var_121_16 + var_121_17 and arg_118_1.time_ < var_121_16 + var_121_17 + arg_121_0 then
				local var_121_20 = Color.New(0, 0, 0)

				var_121_20.a = 1
				arg_118_1.mask_.color = var_121_20
			end

			local var_121_21 = 2

			if var_121_21 < arg_118_1.time_ and arg_118_1.time_ <= var_121_21 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_22 = 2

			if var_121_21 <= arg_118_1.time_ and arg_118_1.time_ < var_121_21 + var_121_22 then
				local var_121_23 = (arg_118_1.time_ - var_121_21) / var_121_22
				local var_121_24 = Color.New(0, 0, 0)

				var_121_24.a = Mathf.Lerp(1, 0, var_121_23)
				arg_118_1.mask_.color = var_121_24
			end

			if arg_118_1.time_ >= var_121_21 + var_121_22 and arg_118_1.time_ < var_121_21 + var_121_22 + arg_121_0 then
				local var_121_25 = Color.New(0, 0, 0)
				local var_121_26 = 0

				arg_118_1.mask_.enabled = false
				var_121_25.a = var_121_26
				arg_118_1.mask_.color = var_121_25
			end

			local var_121_27 = arg_118_1.actors_["10058ui_story"].transform
			local var_121_28 = 2

			if var_121_28 < arg_118_1.time_ and arg_118_1.time_ <= var_121_28 + arg_121_0 then
				arg_118_1.var_.moveOldPos10058ui_story = var_121_27.localPosition
			end

			local var_121_29 = 0.001

			if var_121_28 <= arg_118_1.time_ and arg_118_1.time_ < var_121_28 + var_121_29 then
				local var_121_30 = (arg_118_1.time_ - var_121_28) / var_121_29
				local var_121_31 = Vector3.New(0, 100, 0)

				var_121_27.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos10058ui_story, var_121_31, var_121_30)

				local var_121_32 = manager.ui.mainCamera.transform.position - var_121_27.position

				var_121_27.forward = Vector3.New(var_121_32.x, var_121_32.y, var_121_32.z)

				local var_121_33 = var_121_27.localEulerAngles

				var_121_33.z = 0
				var_121_33.x = 0
				var_121_27.localEulerAngles = var_121_33
			end

			if arg_118_1.time_ >= var_121_28 + var_121_29 and arg_118_1.time_ < var_121_28 + var_121_29 + arg_121_0 then
				var_121_27.localPosition = Vector3.New(0, 100, 0)

				local var_121_34 = manager.ui.mainCamera.transform.position - var_121_27.position

				var_121_27.forward = Vector3.New(var_121_34.x, var_121_34.y, var_121_34.z)

				local var_121_35 = var_121_27.localEulerAngles

				var_121_35.z = 0
				var_121_35.x = 0
				var_121_27.localEulerAngles = var_121_35
			end

			local var_121_36 = arg_118_1.actors_["10058ui_story"]
			local var_121_37 = 2

			if var_121_37 < arg_118_1.time_ and arg_118_1.time_ <= var_121_37 + arg_121_0 and not isNil(var_121_36) and arg_118_1.var_.characterEffect10058ui_story == nil then
				arg_118_1.var_.characterEffect10058ui_story = var_121_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_38 = 0.200000002980232

			if var_121_37 <= arg_118_1.time_ and arg_118_1.time_ < var_121_37 + var_121_38 and not isNil(var_121_36) then
				local var_121_39 = (arg_118_1.time_ - var_121_37) / var_121_38

				if arg_118_1.var_.characterEffect10058ui_story and not isNil(var_121_36) then
					local var_121_40 = Mathf.Lerp(0, 0.5, var_121_39)

					arg_118_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_118_1.var_.characterEffect10058ui_story.fillRatio = var_121_40
				end
			end

			if arg_118_1.time_ >= var_121_37 + var_121_38 and arg_118_1.time_ < var_121_37 + var_121_38 + arg_121_0 and not isNil(var_121_36) and arg_118_1.var_.characterEffect10058ui_story then
				local var_121_41 = 0.5

				arg_118_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_118_1.var_.characterEffect10058ui_story.fillRatio = var_121_41
			end

			local var_121_42 = 0
			local var_121_43 = 0.3

			if var_121_42 < arg_118_1.time_ and arg_118_1.time_ <= var_121_42 + arg_121_0 then
				local var_121_44 = "play"
				local var_121_45 = "music"

				arg_118_1:AudioAction(var_121_44, var_121_45, "ui_battle", "ui_battle_stopbgm", "")

				local var_121_46 = ""
				local var_121_47 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_121_47 ~= "" then
					if arg_118_1.bgmTxt_.text ~= var_121_47 and arg_118_1.bgmTxt_.text ~= "" then
						if arg_118_1.bgmTxt2_.text ~= "" then
							arg_118_1.bgmTxt_.text = arg_118_1.bgmTxt2_.text
						end

						arg_118_1.bgmTxt2_.text = var_121_47

						arg_118_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_118_1.bgmTxt_.text = var_121_47
						arg_118_1.bgmTxt2_.text = var_121_47
					end

					if arg_118_1.bgmTimer then
						arg_118_1.bgmTimer:Stop()

						arg_118_1.bgmTimer = nil
					end

					if arg_118_1.settingData.show_music_name == 1 then
						arg_118_1.musicController:SetSelectedState("show")
						arg_118_1.musicAnimator_:Play("open", 0, 0)

						if arg_118_1.settingData.music_time ~= 0 then
							arg_118_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_118_1.settingData.music_time), function()
								if arg_118_1 == nil or isNil(arg_118_1.bgmTxt_) then
									return
								end

								arg_118_1.musicController:SetSelectedState("hide")
								arg_118_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_121_48 = 0.433333333333333
			local var_121_49 = 0.3

			if var_121_48 < arg_118_1.time_ and arg_118_1.time_ <= var_121_48 + arg_121_0 then
				local var_121_50 = "play"
				local var_121_51 = "music"

				arg_118_1:AudioAction(var_121_50, var_121_51, "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_121_52 = ""
				local var_121_53 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

				if var_121_53 ~= "" then
					if arg_118_1.bgmTxt_.text ~= var_121_53 and arg_118_1.bgmTxt_.text ~= "" then
						if arg_118_1.bgmTxt2_.text ~= "" then
							arg_118_1.bgmTxt_.text = arg_118_1.bgmTxt2_.text
						end

						arg_118_1.bgmTxt2_.text = var_121_53

						arg_118_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_118_1.bgmTxt_.text = var_121_53
						arg_118_1.bgmTxt2_.text = var_121_53
					end

					if arg_118_1.bgmTimer then
						arg_118_1.bgmTimer:Stop()

						arg_118_1.bgmTimer = nil
					end

					if arg_118_1.settingData.show_music_name == 1 then
						arg_118_1.musicController:SetSelectedState("show")
						arg_118_1.musicAnimator_:Play("open", 0, 0)

						if arg_118_1.settingData.music_time ~= 0 then
							arg_118_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_118_1.settingData.music_time), function()
								if arg_118_1 == nil or isNil(arg_118_1.bgmTxt_) then
									return
								end

								arg_118_1.musicController:SetSelectedState("hide")
								arg_118_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_118_1.frameCnt_ <= 1 then
				arg_118_1.dialog_:SetActive(false)
			end

			local var_121_54 = 4
			local var_121_55 = 1.125

			if var_121_54 < arg_118_1.time_ and arg_118_1.time_ <= var_121_54 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0

				arg_118_1.dialog_:SetActive(true)

				arg_118_1.dialogCg_.alpha = 0

				local var_121_56 = LeanTween.value(arg_118_1.dialog_, 0, 1, 0.3)

				var_121_56:setOnUpdate(LuaHelper.FloatAction(function(arg_124_0)
					arg_118_1.dialogCg_.alpha = arg_124_0
				end))
				var_121_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_118_1.dialog_)
					var_121_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_118_1.duration_ = arg_118_1.duration_ + 0.3

				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_57 = arg_118_1:GetWordFromCfg(411251029)
				local var_121_58 = arg_118_1:FormatText(var_121_57.content)

				arg_118_1.text_.text = var_121_58

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_59 = 45
				local var_121_60 = utf8.len(var_121_58)
				local var_121_61 = var_121_59 <= 0 and var_121_55 or var_121_55 * (var_121_60 / var_121_59)

				if var_121_61 > 0 and var_121_55 < var_121_61 then
					arg_118_1.talkMaxDuration = var_121_61
					var_121_54 = var_121_54 + 0.3

					if var_121_61 + var_121_54 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_61 + var_121_54
					end
				end

				arg_118_1.text_.text = var_121_58
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_62 = var_121_54 + 0.3
			local var_121_63 = math.max(var_121_55, arg_118_1.talkMaxDuration)

			if var_121_62 <= arg_118_1.time_ and arg_118_1.time_ < var_121_62 + var_121_63 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_62) / var_121_63

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_62 + var_121_63 and arg_118_1.time_ < var_121_62 + var_121_63 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play411251030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 411251030
		arg_126_1.duration_ = 2.77

		local var_126_0 = {
			zh = 2.766,
			ja = 2.333
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play411251031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = "4040ui_story"

			if arg_126_1.actors_[var_129_0] == nil then
				local var_129_1 = Asset.Load("Char/" .. "4040ui_story")

				if not isNil(var_129_1) then
					local var_129_2 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_126_1.stage_.transform)

					var_129_2.name = var_129_0
					var_129_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_126_1.actors_[var_129_0] = var_129_2

					local var_129_3 = var_129_2:GetComponentInChildren(typeof(CharacterEffect))

					var_129_3.enabled = true

					local var_129_4 = GameObjectTools.GetOrAddComponent(var_129_2, typeof(DynamicBoneHelper))

					if var_129_4 then
						var_129_4:EnableDynamicBone(false)
					end

					arg_126_1:ShowWeapon(var_129_3.transform, false)

					arg_126_1.var_[var_129_0 .. "Animator"] = var_129_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_126_1.var_[var_129_0 .. "Animator"].applyRootMotion = true
					arg_126_1.var_[var_129_0 .. "LipSync"] = var_129_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_129_5 = arg_126_1.actors_["4040ui_story"].transform
			local var_129_6 = 0

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.var_.moveOldPos4040ui_story = var_129_5.localPosition
			end

			local var_129_7 = 0.001

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_7 then
				local var_129_8 = (arg_126_1.time_ - var_129_6) / var_129_7
				local var_129_9 = Vector3.New(0, -1.55, -5.5)

				var_129_5.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos4040ui_story, var_129_9, var_129_8)

				local var_129_10 = manager.ui.mainCamera.transform.position - var_129_5.position

				var_129_5.forward = Vector3.New(var_129_10.x, var_129_10.y, var_129_10.z)

				local var_129_11 = var_129_5.localEulerAngles

				var_129_11.z = 0
				var_129_11.x = 0
				var_129_5.localEulerAngles = var_129_11
			end

			if arg_126_1.time_ >= var_129_6 + var_129_7 and arg_126_1.time_ < var_129_6 + var_129_7 + arg_129_0 then
				var_129_5.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_129_12 = manager.ui.mainCamera.transform.position - var_129_5.position

				var_129_5.forward = Vector3.New(var_129_12.x, var_129_12.y, var_129_12.z)

				local var_129_13 = var_129_5.localEulerAngles

				var_129_13.z = 0
				var_129_13.x = 0
				var_129_5.localEulerAngles = var_129_13
			end

			local var_129_14 = arg_126_1.actors_["4040ui_story"]
			local var_129_15 = 0

			if var_129_15 < arg_126_1.time_ and arg_126_1.time_ <= var_129_15 + arg_129_0 and not isNil(var_129_14) and arg_126_1.var_.characterEffect4040ui_story == nil then
				arg_126_1.var_.characterEffect4040ui_story = var_129_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_16 = 0.200000002980232

			if var_129_15 <= arg_126_1.time_ and arg_126_1.time_ < var_129_15 + var_129_16 and not isNil(var_129_14) then
				local var_129_17 = (arg_126_1.time_ - var_129_15) / var_129_16

				if arg_126_1.var_.characterEffect4040ui_story and not isNil(var_129_14) then
					arg_126_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_15 + var_129_16 and arg_126_1.time_ < var_129_15 + var_129_16 + arg_129_0 and not isNil(var_129_14) and arg_126_1.var_.characterEffect4040ui_story then
				arg_126_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_129_18 = 0

			if var_129_18 < arg_126_1.time_ and arg_126_1.time_ <= var_129_18 + arg_129_0 then
				arg_126_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_129_19 = 0

			if var_129_19 < arg_126_1.time_ and arg_126_1.time_ <= var_129_19 + arg_129_0 then
				arg_126_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_129_20 = 0
			local var_129_21 = 0.2

			if var_129_20 < arg_126_1.time_ and arg_126_1.time_ <= var_129_20 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_22 = arg_126_1:FormatText(StoryNameCfg[668].name)

				arg_126_1.leftNameTxt_.text = var_129_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_23 = arg_126_1:GetWordFromCfg(411251030)
				local var_129_24 = arg_126_1:FormatText(var_129_23.content)

				arg_126_1.text_.text = var_129_24

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_25 = 8
				local var_129_26 = utf8.len(var_129_24)
				local var_129_27 = var_129_25 <= 0 and var_129_21 or var_129_21 * (var_129_26 / var_129_25)

				if var_129_27 > 0 and var_129_21 < var_129_27 then
					arg_126_1.talkMaxDuration = var_129_27

					if var_129_27 + var_129_20 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_27 + var_129_20
					end
				end

				arg_126_1.text_.text = var_129_24
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251030", "story_v_out_411251.awb") ~= 0 then
					local var_129_28 = manager.audio:GetVoiceLength("story_v_out_411251", "411251030", "story_v_out_411251.awb") / 1000

					if var_129_28 + var_129_20 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_28 + var_129_20
					end

					if var_129_23.prefab_name ~= "" and arg_126_1.actors_[var_129_23.prefab_name] ~= nil then
						local var_129_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_23.prefab_name].transform, "story_v_out_411251", "411251030", "story_v_out_411251.awb")

						arg_126_1:RecordAudio("411251030", var_129_29)
						arg_126_1:RecordAudio("411251030", var_129_29)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_411251", "411251030", "story_v_out_411251.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_411251", "411251030", "story_v_out_411251.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_30 = math.max(var_129_21, arg_126_1.talkMaxDuration)

			if var_129_20 <= arg_126_1.time_ and arg_126_1.time_ < var_129_20 + var_129_30 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_20) / var_129_30

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_20 + var_129_30 and arg_126_1.time_ < var_129_20 + var_129_30 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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

		arg_126_1:InitPlayNodeList()
	end,
	Play411251031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 411251031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play411251032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["4040ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect4040ui_story == nil then
				arg_130_1.var_.characterEffect4040ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect4040ui_story and not isNil(var_133_0) then
					local var_133_4 = Mathf.Lerp(0, 0.5, var_133_3)

					arg_130_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_130_1.var_.characterEffect4040ui_story.fillRatio = var_133_4
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect4040ui_story then
				local var_133_5 = 0.5

				arg_130_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_130_1.var_.characterEffect4040ui_story.fillRatio = var_133_5
			end

			local var_133_6 = 0
			local var_133_7 = 1.1

			if var_133_6 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_8 = arg_130_1:GetWordFromCfg(411251031)
				local var_133_9 = arg_130_1:FormatText(var_133_8.content)

				arg_130_1.text_.text = var_133_9

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_10 = 44
				local var_133_11 = utf8.len(var_133_9)
				local var_133_12 = var_133_10 <= 0 and var_133_7 or var_133_7 * (var_133_11 / var_133_10)

				if var_133_12 > 0 and var_133_7 < var_133_12 then
					arg_130_1.talkMaxDuration = var_133_12

					if var_133_12 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_12 + var_133_6
					end
				end

				arg_130_1.text_.text = var_133_9
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_13 = math.max(var_133_7, arg_130_1.talkMaxDuration)

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_13 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_6) / var_133_13

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_6 + var_133_13 and arg_130_1.time_ < var_133_6 + var_133_13 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play411251032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 411251032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play411251033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 0.3

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				local var_137_2 = "play"
				local var_137_3 = "effect"

				arg_134_1:AudioAction(var_137_2, var_137_3, "se_story", "se_story_communication", "")
			end

			local var_137_4 = 0
			local var_137_5 = 0.75

			if var_137_4 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_6 = arg_134_1:GetWordFromCfg(411251032)
				local var_137_7 = arg_134_1:FormatText(var_137_6.content)

				arg_134_1.text_.text = var_137_7

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_8 = 30
				local var_137_9 = utf8.len(var_137_7)
				local var_137_10 = var_137_8 <= 0 and var_137_5 or var_137_5 * (var_137_9 / var_137_8)

				if var_137_10 > 0 and var_137_5 < var_137_10 then
					arg_134_1.talkMaxDuration = var_137_10

					if var_137_10 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_10 + var_137_4
					end
				end

				arg_134_1.text_.text = var_137_7
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_11 = math.max(var_137_5, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_11 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_4) / var_137_11

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_11 and arg_134_1.time_ < var_137_4 + var_137_11 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play411251033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 411251033
		arg_138_1.duration_ = 2.5

		local var_138_0 = {
			zh = 2.033,
			ja = 2.5
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play411251034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["4040ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect4040ui_story == nil then
				arg_138_1.var_.characterEffect4040ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect4040ui_story and not isNil(var_141_0) then
					arg_138_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect4040ui_story then
				arg_138_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_141_4 = 0

			if var_141_4 < arg_138_1.time_ and arg_138_1.time_ <= var_141_4 + arg_141_0 then
				arg_138_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_141_5 = 0
			local var_141_6 = 0.175

			if var_141_5 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_7 = arg_138_1:FormatText(StoryNameCfg[668].name)

				arg_138_1.leftNameTxt_.text = var_141_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_8 = arg_138_1:GetWordFromCfg(411251033)
				local var_141_9 = arg_138_1:FormatText(var_141_8.content)

				arg_138_1.text_.text = var_141_9

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_10 = 7
				local var_141_11 = utf8.len(var_141_9)
				local var_141_12 = var_141_10 <= 0 and var_141_6 or var_141_6 * (var_141_11 / var_141_10)

				if var_141_12 > 0 and var_141_6 < var_141_12 then
					arg_138_1.talkMaxDuration = var_141_12

					if var_141_12 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_12 + var_141_5
					end
				end

				arg_138_1.text_.text = var_141_9
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251033", "story_v_out_411251.awb") ~= 0 then
					local var_141_13 = manager.audio:GetVoiceLength("story_v_out_411251", "411251033", "story_v_out_411251.awb") / 1000

					if var_141_13 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_13 + var_141_5
					end

					if var_141_8.prefab_name ~= "" and arg_138_1.actors_[var_141_8.prefab_name] ~= nil then
						local var_141_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_8.prefab_name].transform, "story_v_out_411251", "411251033", "story_v_out_411251.awb")

						arg_138_1:RecordAudio("411251033", var_141_14)
						arg_138_1:RecordAudio("411251033", var_141_14)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_411251", "411251033", "story_v_out_411251.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_411251", "411251033", "story_v_out_411251.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_15 = math.max(var_141_6, arg_138_1.talkMaxDuration)

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_15 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_5) / var_141_15

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_5 + var_141_15 and arg_138_1.time_ < var_141_5 + var_141_15 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play411251034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 411251034
		arg_142_1.duration_ = 4.43

		local var_142_0 = {
			zh = 4.433,
			ja = 4.266
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play411251035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["4040ui_story"].transform
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.var_.moveOldPos4040ui_story = var_145_0.localPosition
			end

			local var_145_2 = 0.001

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2
				local var_145_4 = Vector3.New(0, 100, 0)

				var_145_0.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos4040ui_story, var_145_4, var_145_3)

				local var_145_5 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_5.x, var_145_5.y, var_145_5.z)

				local var_145_6 = var_145_0.localEulerAngles

				var_145_6.z = 0
				var_145_6.x = 0
				var_145_0.localEulerAngles = var_145_6
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 then
				var_145_0.localPosition = Vector3.New(0, 100, 0)

				local var_145_7 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_7.x, var_145_7.y, var_145_7.z)

				local var_145_8 = var_145_0.localEulerAngles

				var_145_8.z = 0
				var_145_8.x = 0
				var_145_0.localEulerAngles = var_145_8
			end

			local var_145_9 = arg_142_1.actors_["4040ui_story"]
			local var_145_10 = 0

			if var_145_10 < arg_142_1.time_ and arg_142_1.time_ <= var_145_10 + arg_145_0 and not isNil(var_145_9) and arg_142_1.var_.characterEffect4040ui_story == nil then
				arg_142_1.var_.characterEffect4040ui_story = var_145_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_11 = 0.200000002980232

			if var_145_10 <= arg_142_1.time_ and arg_142_1.time_ < var_145_10 + var_145_11 and not isNil(var_145_9) then
				local var_145_12 = (arg_142_1.time_ - var_145_10) / var_145_11

				if arg_142_1.var_.characterEffect4040ui_story and not isNil(var_145_9) then
					local var_145_13 = Mathf.Lerp(0, 0.5, var_145_12)

					arg_142_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_142_1.var_.characterEffect4040ui_story.fillRatio = var_145_13
				end
			end

			if arg_142_1.time_ >= var_145_10 + var_145_11 and arg_142_1.time_ < var_145_10 + var_145_11 + arg_145_0 and not isNil(var_145_9) and arg_142_1.var_.characterEffect4040ui_story then
				local var_145_14 = 0.5

				arg_142_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_142_1.var_.characterEffect4040ui_story.fillRatio = var_145_14
			end

			local var_145_15 = arg_142_1.actors_["10058ui_story"].transform
			local var_145_16 = 0

			if var_145_16 < arg_142_1.time_ and arg_142_1.time_ <= var_145_16 + arg_145_0 then
				arg_142_1.var_.moveOldPos10058ui_story = var_145_15.localPosition
			end

			local var_145_17 = 0.001

			if var_145_16 <= arg_142_1.time_ and arg_142_1.time_ < var_145_16 + var_145_17 then
				local var_145_18 = (arg_142_1.time_ - var_145_16) / var_145_17
				local var_145_19 = Vector3.New(0, -0.98, -6.1)

				var_145_15.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10058ui_story, var_145_19, var_145_18)

				local var_145_20 = manager.ui.mainCamera.transform.position - var_145_15.position

				var_145_15.forward = Vector3.New(var_145_20.x, var_145_20.y, var_145_20.z)

				local var_145_21 = var_145_15.localEulerAngles

				var_145_21.z = 0
				var_145_21.x = 0
				var_145_15.localEulerAngles = var_145_21
			end

			if arg_142_1.time_ >= var_145_16 + var_145_17 and arg_142_1.time_ < var_145_16 + var_145_17 + arg_145_0 then
				var_145_15.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_145_22 = manager.ui.mainCamera.transform.position - var_145_15.position

				var_145_15.forward = Vector3.New(var_145_22.x, var_145_22.y, var_145_22.z)

				local var_145_23 = var_145_15.localEulerAngles

				var_145_23.z = 0
				var_145_23.x = 0
				var_145_15.localEulerAngles = var_145_23
			end

			local var_145_24 = arg_142_1.actors_["10058ui_story"]
			local var_145_25 = 0

			if var_145_25 < arg_142_1.time_ and arg_142_1.time_ <= var_145_25 + arg_145_0 and not isNil(var_145_24) and arg_142_1.var_.characterEffect10058ui_story == nil then
				arg_142_1.var_.characterEffect10058ui_story = var_145_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_26 = 0.200000002980232

			if var_145_25 <= arg_142_1.time_ and arg_142_1.time_ < var_145_25 + var_145_26 and not isNil(var_145_24) then
				local var_145_27 = (arg_142_1.time_ - var_145_25) / var_145_26

				if arg_142_1.var_.characterEffect10058ui_story and not isNil(var_145_24) then
					arg_142_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_25 + var_145_26 and arg_142_1.time_ < var_145_25 + var_145_26 + arg_145_0 and not isNil(var_145_24) and arg_142_1.var_.characterEffect10058ui_story then
				arg_142_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_145_28 = 0

			if var_145_28 < arg_142_1.time_ and arg_142_1.time_ <= var_145_28 + arg_145_0 then
				arg_142_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_145_29 = 0

			if var_145_29 < arg_142_1.time_ and arg_142_1.time_ <= var_145_29 + arg_145_0 then
				arg_142_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_145_30 = arg_142_1.actors_["10058ui_story"]
			local var_145_31 = 0

			if var_145_31 < arg_142_1.time_ and arg_142_1.time_ <= var_145_31 + arg_145_0 then
				if arg_142_1.var_.characterEffect10058ui_story == nil then
					arg_142_1.var_.characterEffect10058ui_story = var_145_30:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_145_32 = arg_142_1.var_.characterEffect10058ui_story

				var_145_32.imageEffect:turnOff()

				var_145_32.interferenceEffect.enabled = true
				var_145_32.interferenceEffect.noise = 0.001
				var_145_32.interferenceEffect.simTimeScale = 1
				var_145_32.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_145_33 = arg_142_1.actors_["10058ui_story"]
			local var_145_34 = 0
			local var_145_35 = 2

			if var_145_34 < arg_142_1.time_ and arg_142_1.time_ <= var_145_34 + arg_145_0 then
				if arg_142_1.var_.characterEffect10058ui_story == nil then
					arg_142_1.var_.characterEffect10058ui_story = var_145_33:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_142_1.var_.characterEffect10058ui_story.imageEffect:turnOn(false)
			end

			local var_145_36 = 0
			local var_145_37 = 0.525

			if var_145_36 < arg_142_1.time_ and arg_142_1.time_ <= var_145_36 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_38 = arg_142_1:FormatText(StoryNameCfg[471].name)

				arg_142_1.leftNameTxt_.text = var_145_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_39 = arg_142_1:GetWordFromCfg(411251034)
				local var_145_40 = arg_142_1:FormatText(var_145_39.content)

				arg_142_1.text_.text = var_145_40

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_41 = 21
				local var_145_42 = utf8.len(var_145_40)
				local var_145_43 = var_145_41 <= 0 and var_145_37 or var_145_37 * (var_145_42 / var_145_41)

				if var_145_43 > 0 and var_145_37 < var_145_43 then
					arg_142_1.talkMaxDuration = var_145_43

					if var_145_43 + var_145_36 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_43 + var_145_36
					end
				end

				arg_142_1.text_.text = var_145_40
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251034", "story_v_out_411251.awb") ~= 0 then
					local var_145_44 = manager.audio:GetVoiceLength("story_v_out_411251", "411251034", "story_v_out_411251.awb") / 1000

					if var_145_44 + var_145_36 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_44 + var_145_36
					end

					if var_145_39.prefab_name ~= "" and arg_142_1.actors_[var_145_39.prefab_name] ~= nil then
						local var_145_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_39.prefab_name].transform, "story_v_out_411251", "411251034", "story_v_out_411251.awb")

						arg_142_1:RecordAudio("411251034", var_145_45)
						arg_142_1:RecordAudio("411251034", var_145_45)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_411251", "411251034", "story_v_out_411251.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_411251", "411251034", "story_v_out_411251.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_46 = math.max(var_145_37, arg_142_1.talkMaxDuration)

			if var_145_36 <= arg_142_1.time_ and arg_142_1.time_ < var_145_36 + var_145_46 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_36) / var_145_46

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_36 + var_145_46 and arg_142_1.time_ < var_145_36 + var_145_46 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
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
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play411251035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 411251035
		arg_146_1.duration_ = 9.87

		local var_146_0 = {
			zh = 6.866,
			ja = 9.866
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play411251036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["4040ui_story"].transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.moveOldPos4040ui_story = var_149_0.localPosition
			end

			local var_149_2 = 0.001

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2
				local var_149_4 = Vector3.New(-0.7, -1.55, -5.5)

				var_149_0.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos4040ui_story, var_149_4, var_149_3)

				local var_149_5 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_5.x, var_149_5.y, var_149_5.z)

				local var_149_6 = var_149_0.localEulerAngles

				var_149_6.z = 0
				var_149_6.x = 0
				var_149_0.localEulerAngles = var_149_6
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 then
				var_149_0.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_149_7 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_7.x, var_149_7.y, var_149_7.z)

				local var_149_8 = var_149_0.localEulerAngles

				var_149_8.z = 0
				var_149_8.x = 0
				var_149_0.localEulerAngles = var_149_8
			end

			local var_149_9 = arg_146_1.actors_["4040ui_story"]
			local var_149_10 = 0

			if var_149_10 < arg_146_1.time_ and arg_146_1.time_ <= var_149_10 + arg_149_0 and not isNil(var_149_9) and arg_146_1.var_.characterEffect4040ui_story == nil then
				arg_146_1.var_.characterEffect4040ui_story = var_149_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_11 = 0.200000002980232

			if var_149_10 <= arg_146_1.time_ and arg_146_1.time_ < var_149_10 + var_149_11 and not isNil(var_149_9) then
				local var_149_12 = (arg_146_1.time_ - var_149_10) / var_149_11

				if arg_146_1.var_.characterEffect4040ui_story and not isNil(var_149_9) then
					arg_146_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_10 + var_149_11 and arg_146_1.time_ < var_149_10 + var_149_11 + arg_149_0 and not isNil(var_149_9) and arg_146_1.var_.characterEffect4040ui_story then
				arg_146_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_149_13 = 0

			if var_149_13 < arg_146_1.time_ and arg_146_1.time_ <= var_149_13 + arg_149_0 then
				arg_146_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_149_14 = 0

			if var_149_14 < arg_146_1.time_ and arg_146_1.time_ <= var_149_14 + arg_149_0 then
				arg_146_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_149_15 = arg_146_1.actors_["10058ui_story"].transform
			local var_149_16 = 0

			if var_149_16 < arg_146_1.time_ and arg_146_1.time_ <= var_149_16 + arg_149_0 then
				arg_146_1.var_.moveOldPos10058ui_story = var_149_15.localPosition
			end

			local var_149_17 = 0.001

			if var_149_16 <= arg_146_1.time_ and arg_146_1.time_ < var_149_16 + var_149_17 then
				local var_149_18 = (arg_146_1.time_ - var_149_16) / var_149_17
				local var_149_19 = Vector3.New(0.7, -0.98, -6.1)

				var_149_15.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos10058ui_story, var_149_19, var_149_18)

				local var_149_20 = manager.ui.mainCamera.transform.position - var_149_15.position

				var_149_15.forward = Vector3.New(var_149_20.x, var_149_20.y, var_149_20.z)

				local var_149_21 = var_149_15.localEulerAngles

				var_149_21.z = 0
				var_149_21.x = 0
				var_149_15.localEulerAngles = var_149_21
			end

			if arg_146_1.time_ >= var_149_16 + var_149_17 and arg_146_1.time_ < var_149_16 + var_149_17 + arg_149_0 then
				var_149_15.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_149_22 = manager.ui.mainCamera.transform.position - var_149_15.position

				var_149_15.forward = Vector3.New(var_149_22.x, var_149_22.y, var_149_22.z)

				local var_149_23 = var_149_15.localEulerAngles

				var_149_23.z = 0
				var_149_23.x = 0
				var_149_15.localEulerAngles = var_149_23
			end

			local var_149_24 = arg_146_1.actors_["10058ui_story"]
			local var_149_25 = 0

			if var_149_25 < arg_146_1.time_ and arg_146_1.time_ <= var_149_25 + arg_149_0 and not isNil(var_149_24) and arg_146_1.var_.characterEffect10058ui_story == nil then
				arg_146_1.var_.characterEffect10058ui_story = var_149_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_26 = 0.200000002980232

			if var_149_25 <= arg_146_1.time_ and arg_146_1.time_ < var_149_25 + var_149_26 and not isNil(var_149_24) then
				local var_149_27 = (arg_146_1.time_ - var_149_25) / var_149_26

				if arg_146_1.var_.characterEffect10058ui_story and not isNil(var_149_24) then
					local var_149_28 = Mathf.Lerp(0, 0.5, var_149_27)

					arg_146_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_146_1.var_.characterEffect10058ui_story.fillRatio = var_149_28
				end
			end

			if arg_146_1.time_ >= var_149_25 + var_149_26 and arg_146_1.time_ < var_149_25 + var_149_26 + arg_149_0 and not isNil(var_149_24) and arg_146_1.var_.characterEffect10058ui_story then
				local var_149_29 = 0.5

				arg_146_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_146_1.var_.characterEffect10058ui_story.fillRatio = var_149_29
			end

			local var_149_30 = 0
			local var_149_31 = 0.8

			if var_149_30 < arg_146_1.time_ and arg_146_1.time_ <= var_149_30 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_32 = arg_146_1:FormatText(StoryNameCfg[668].name)

				arg_146_1.leftNameTxt_.text = var_149_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_33 = arg_146_1:GetWordFromCfg(411251035)
				local var_149_34 = arg_146_1:FormatText(var_149_33.content)

				arg_146_1.text_.text = var_149_34

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_35 = 32
				local var_149_36 = utf8.len(var_149_34)
				local var_149_37 = var_149_35 <= 0 and var_149_31 or var_149_31 * (var_149_36 / var_149_35)

				if var_149_37 > 0 and var_149_31 < var_149_37 then
					arg_146_1.talkMaxDuration = var_149_37

					if var_149_37 + var_149_30 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_37 + var_149_30
					end
				end

				arg_146_1.text_.text = var_149_34
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251035", "story_v_out_411251.awb") ~= 0 then
					local var_149_38 = manager.audio:GetVoiceLength("story_v_out_411251", "411251035", "story_v_out_411251.awb") / 1000

					if var_149_38 + var_149_30 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_38 + var_149_30
					end

					if var_149_33.prefab_name ~= "" and arg_146_1.actors_[var_149_33.prefab_name] ~= nil then
						local var_149_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_33.prefab_name].transform, "story_v_out_411251", "411251035", "story_v_out_411251.awb")

						arg_146_1:RecordAudio("411251035", var_149_39)
						arg_146_1:RecordAudio("411251035", var_149_39)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_411251", "411251035", "story_v_out_411251.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_411251", "411251035", "story_v_out_411251.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_40 = math.max(var_149_31, arg_146_1.talkMaxDuration)

			if var_149_30 <= arg_146_1.time_ and arg_146_1.time_ < var_149_30 + var_149_40 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_30) / var_149_40

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_30 + var_149_40 and arg_146_1.time_ < var_149_30 + var_149_40 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
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
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play411251036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 411251036
		arg_150_1.duration_ = 2.37

		local var_150_0 = {
			zh = 2.366,
			ja = 2.3
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play411251037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["4040ui_story"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect4040ui_story == nil then
				arg_150_1.var_.characterEffect4040ui_story = var_153_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.200000002980232

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.characterEffect4040ui_story and not isNil(var_153_0) then
					local var_153_4 = Mathf.Lerp(0, 0.5, var_153_3)

					arg_150_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_150_1.var_.characterEffect4040ui_story.fillRatio = var_153_4
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect4040ui_story then
				local var_153_5 = 0.5

				arg_150_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_150_1.var_.characterEffect4040ui_story.fillRatio = var_153_5
			end

			local var_153_6 = arg_150_1.actors_["10058ui_story"]
			local var_153_7 = 0

			if var_153_7 < arg_150_1.time_ and arg_150_1.time_ <= var_153_7 + arg_153_0 and not isNil(var_153_6) and arg_150_1.var_.characterEffect10058ui_story == nil then
				arg_150_1.var_.characterEffect10058ui_story = var_153_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_8 = 0.200000002980232

			if var_153_7 <= arg_150_1.time_ and arg_150_1.time_ < var_153_7 + var_153_8 and not isNil(var_153_6) then
				local var_153_9 = (arg_150_1.time_ - var_153_7) / var_153_8

				if arg_150_1.var_.characterEffect10058ui_story and not isNil(var_153_6) then
					arg_150_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_7 + var_153_8 and arg_150_1.time_ < var_153_7 + var_153_8 + arg_153_0 and not isNil(var_153_6) and arg_150_1.var_.characterEffect10058ui_story then
				arg_150_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_153_10 = 0
			local var_153_11 = 0.3

			if var_153_10 < arg_150_1.time_ and arg_150_1.time_ <= var_153_10 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_12 = arg_150_1:FormatText(StoryNameCfg[471].name)

				arg_150_1.leftNameTxt_.text = var_153_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_13 = arg_150_1:GetWordFromCfg(411251036)
				local var_153_14 = arg_150_1:FormatText(var_153_13.content)

				arg_150_1.text_.text = var_153_14

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_15 = 12
				local var_153_16 = utf8.len(var_153_14)
				local var_153_17 = var_153_15 <= 0 and var_153_11 or var_153_11 * (var_153_16 / var_153_15)

				if var_153_17 > 0 and var_153_11 < var_153_17 then
					arg_150_1.talkMaxDuration = var_153_17

					if var_153_17 + var_153_10 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_17 + var_153_10
					end
				end

				arg_150_1.text_.text = var_153_14
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251036", "story_v_out_411251.awb") ~= 0 then
					local var_153_18 = manager.audio:GetVoiceLength("story_v_out_411251", "411251036", "story_v_out_411251.awb") / 1000

					if var_153_18 + var_153_10 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_18 + var_153_10
					end

					if var_153_13.prefab_name ~= "" and arg_150_1.actors_[var_153_13.prefab_name] ~= nil then
						local var_153_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_13.prefab_name].transform, "story_v_out_411251", "411251036", "story_v_out_411251.awb")

						arg_150_1:RecordAudio("411251036", var_153_19)
						arg_150_1:RecordAudio("411251036", var_153_19)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_411251", "411251036", "story_v_out_411251.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_411251", "411251036", "story_v_out_411251.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_20 = math.max(var_153_11, arg_150_1.talkMaxDuration)

			if var_153_10 <= arg_150_1.time_ and arg_150_1.time_ < var_153_10 + var_153_20 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_10) / var_153_20

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_10 + var_153_20 and arg_150_1.time_ < var_153_10 + var_153_20 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play411251037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 411251037
		arg_154_1.duration_ = 7.27

		local var_154_0 = {
			zh = 7.266,
			ja = 5.866
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play411251038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["4040ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect4040ui_story == nil then
				arg_154_1.var_.characterEffect4040ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect4040ui_story and not isNil(var_157_0) then
					arg_154_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect4040ui_story then
				arg_154_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_157_4 = arg_154_1.actors_["10058ui_story"]
			local var_157_5 = 0

			if var_157_5 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 and not isNil(var_157_4) and arg_154_1.var_.characterEffect10058ui_story == nil then
				arg_154_1.var_.characterEffect10058ui_story = var_157_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_6 = 0.200000002980232

			if var_157_5 <= arg_154_1.time_ and arg_154_1.time_ < var_157_5 + var_157_6 and not isNil(var_157_4) then
				local var_157_7 = (arg_154_1.time_ - var_157_5) / var_157_6

				if arg_154_1.var_.characterEffect10058ui_story and not isNil(var_157_4) then
					local var_157_8 = Mathf.Lerp(0, 0.5, var_157_7)

					arg_154_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_154_1.var_.characterEffect10058ui_story.fillRatio = var_157_8
				end
			end

			if arg_154_1.time_ >= var_157_5 + var_157_6 and arg_154_1.time_ < var_157_5 + var_157_6 + arg_157_0 and not isNil(var_157_4) and arg_154_1.var_.characterEffect10058ui_story then
				local var_157_9 = 0.5

				arg_154_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_154_1.var_.characterEffect10058ui_story.fillRatio = var_157_9
			end

			local var_157_10 = 0
			local var_157_11 = 0.75

			if var_157_10 < arg_154_1.time_ and arg_154_1.time_ <= var_157_10 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_12 = arg_154_1:FormatText(StoryNameCfg[668].name)

				arg_154_1.leftNameTxt_.text = var_157_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_13 = arg_154_1:GetWordFromCfg(411251037)
				local var_157_14 = arg_154_1:FormatText(var_157_13.content)

				arg_154_1.text_.text = var_157_14

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_15 = 30
				local var_157_16 = utf8.len(var_157_14)
				local var_157_17 = var_157_15 <= 0 and var_157_11 or var_157_11 * (var_157_16 / var_157_15)

				if var_157_17 > 0 and var_157_11 < var_157_17 then
					arg_154_1.talkMaxDuration = var_157_17

					if var_157_17 + var_157_10 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_17 + var_157_10
					end
				end

				arg_154_1.text_.text = var_157_14
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251037", "story_v_out_411251.awb") ~= 0 then
					local var_157_18 = manager.audio:GetVoiceLength("story_v_out_411251", "411251037", "story_v_out_411251.awb") / 1000

					if var_157_18 + var_157_10 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_18 + var_157_10
					end

					if var_157_13.prefab_name ~= "" and arg_154_1.actors_[var_157_13.prefab_name] ~= nil then
						local var_157_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_13.prefab_name].transform, "story_v_out_411251", "411251037", "story_v_out_411251.awb")

						arg_154_1:RecordAudio("411251037", var_157_19)
						arg_154_1:RecordAudio("411251037", var_157_19)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_411251", "411251037", "story_v_out_411251.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_411251", "411251037", "story_v_out_411251.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_20 = math.max(var_157_11, arg_154_1.talkMaxDuration)

			if var_157_10 <= arg_154_1.time_ and arg_154_1.time_ < var_157_10 + var_157_20 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_10) / var_157_20

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_10 + var_157_20 and arg_154_1.time_ < var_157_10 + var_157_20 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play411251038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 411251038
		arg_158_1.duration_ = 5.9

		local var_158_0 = {
			zh = 4.833,
			ja = 5.9
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
				arg_158_0:Play411251039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["4040ui_story"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect4040ui_story == nil then
				arg_158_1.var_.characterEffect4040ui_story = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect4040ui_story and not isNil(var_161_0) then
					local var_161_4 = Mathf.Lerp(0, 0.5, var_161_3)

					arg_158_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_158_1.var_.characterEffect4040ui_story.fillRatio = var_161_4
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect4040ui_story then
				local var_161_5 = 0.5

				arg_158_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_158_1.var_.characterEffect4040ui_story.fillRatio = var_161_5
			end

			local var_161_6 = arg_158_1.actors_["10058ui_story"]
			local var_161_7 = 0

			if var_161_7 < arg_158_1.time_ and arg_158_1.time_ <= var_161_7 + arg_161_0 and not isNil(var_161_6) and arg_158_1.var_.characterEffect10058ui_story == nil then
				arg_158_1.var_.characterEffect10058ui_story = var_161_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_8 = 0.200000002980232

			if var_161_7 <= arg_158_1.time_ and arg_158_1.time_ < var_161_7 + var_161_8 and not isNil(var_161_6) then
				local var_161_9 = (arg_158_1.time_ - var_161_7) / var_161_8

				if arg_158_1.var_.characterEffect10058ui_story and not isNil(var_161_6) then
					arg_158_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= var_161_7 + var_161_8 and arg_158_1.time_ < var_161_7 + var_161_8 + arg_161_0 and not isNil(var_161_6) and arg_158_1.var_.characterEffect10058ui_story then
				arg_158_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_161_10 = 0
			local var_161_11 = 0.625

			if var_161_10 < arg_158_1.time_ and arg_158_1.time_ <= var_161_10 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_12 = arg_158_1:FormatText(StoryNameCfg[471].name)

				arg_158_1.leftNameTxt_.text = var_161_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_13 = arg_158_1:GetWordFromCfg(411251038)
				local var_161_14 = arg_158_1:FormatText(var_161_13.content)

				arg_158_1.text_.text = var_161_14

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_15 = 25
				local var_161_16 = utf8.len(var_161_14)
				local var_161_17 = var_161_15 <= 0 and var_161_11 or var_161_11 * (var_161_16 / var_161_15)

				if var_161_17 > 0 and var_161_11 < var_161_17 then
					arg_158_1.talkMaxDuration = var_161_17

					if var_161_17 + var_161_10 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_17 + var_161_10
					end
				end

				arg_158_1.text_.text = var_161_14
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251038", "story_v_out_411251.awb") ~= 0 then
					local var_161_18 = manager.audio:GetVoiceLength("story_v_out_411251", "411251038", "story_v_out_411251.awb") / 1000

					if var_161_18 + var_161_10 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_18 + var_161_10
					end

					if var_161_13.prefab_name ~= "" and arg_158_1.actors_[var_161_13.prefab_name] ~= nil then
						local var_161_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_13.prefab_name].transform, "story_v_out_411251", "411251038", "story_v_out_411251.awb")

						arg_158_1:RecordAudio("411251038", var_161_19)
						arg_158_1:RecordAudio("411251038", var_161_19)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_411251", "411251038", "story_v_out_411251.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_411251", "411251038", "story_v_out_411251.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_20 = math.max(var_161_11, arg_158_1.talkMaxDuration)

			if var_161_10 <= arg_158_1.time_ and arg_158_1.time_ < var_161_10 + var_161_20 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_10) / var_161_20

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_10 + var_161_20 and arg_158_1.time_ < var_161_10 + var_161_20 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play411251039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 411251039
		arg_162_1.duration_ = 6.6

		local var_162_0 = {
			zh = 4.4,
			ja = 6.6
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
				arg_162_0:Play411251040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["4040ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect4040ui_story == nil then
				arg_162_1.var_.characterEffect4040ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.200000002980232

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect4040ui_story and not isNil(var_165_0) then
					arg_162_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect4040ui_story then
				arg_162_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_165_4 = arg_162_1.actors_["10058ui_story"]
			local var_165_5 = 0

			if var_165_5 < arg_162_1.time_ and arg_162_1.time_ <= var_165_5 + arg_165_0 and not isNil(var_165_4) and arg_162_1.var_.characterEffect10058ui_story == nil then
				arg_162_1.var_.characterEffect10058ui_story = var_165_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_6 = 0.200000002980232

			if var_165_5 <= arg_162_1.time_ and arg_162_1.time_ < var_165_5 + var_165_6 and not isNil(var_165_4) then
				local var_165_7 = (arg_162_1.time_ - var_165_5) / var_165_6

				if arg_162_1.var_.characterEffect10058ui_story and not isNil(var_165_4) then
					local var_165_8 = Mathf.Lerp(0, 0.5, var_165_7)

					arg_162_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_162_1.var_.characterEffect10058ui_story.fillRatio = var_165_8
				end
			end

			if arg_162_1.time_ >= var_165_5 + var_165_6 and arg_162_1.time_ < var_165_5 + var_165_6 + arg_165_0 and not isNil(var_165_4) and arg_162_1.var_.characterEffect10058ui_story then
				local var_165_9 = 0.5

				arg_162_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_162_1.var_.characterEffect10058ui_story.fillRatio = var_165_9
			end

			local var_165_10 = 0

			if var_165_10 < arg_162_1.time_ and arg_162_1.time_ <= var_165_10 + arg_165_0 then
				arg_162_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040actionlink/4040action454")
			end

			local var_165_11 = 0

			if var_165_11 < arg_162_1.time_ and arg_162_1.time_ <= var_165_11 + arg_165_0 then
				arg_162_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_165_12 = 0
			local var_165_13 = 0.525

			if var_165_12 < arg_162_1.time_ and arg_162_1.time_ <= var_165_12 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_14 = arg_162_1:FormatText(StoryNameCfg[668].name)

				arg_162_1.leftNameTxt_.text = var_165_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_15 = arg_162_1:GetWordFromCfg(411251039)
				local var_165_16 = arg_162_1:FormatText(var_165_15.content)

				arg_162_1.text_.text = var_165_16

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_17 = 21
				local var_165_18 = utf8.len(var_165_16)
				local var_165_19 = var_165_17 <= 0 and var_165_13 or var_165_13 * (var_165_18 / var_165_17)

				if var_165_19 > 0 and var_165_13 < var_165_19 then
					arg_162_1.talkMaxDuration = var_165_19

					if var_165_19 + var_165_12 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_19 + var_165_12
					end
				end

				arg_162_1.text_.text = var_165_16
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251039", "story_v_out_411251.awb") ~= 0 then
					local var_165_20 = manager.audio:GetVoiceLength("story_v_out_411251", "411251039", "story_v_out_411251.awb") / 1000

					if var_165_20 + var_165_12 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_20 + var_165_12
					end

					if var_165_15.prefab_name ~= "" and arg_162_1.actors_[var_165_15.prefab_name] ~= nil then
						local var_165_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_15.prefab_name].transform, "story_v_out_411251", "411251039", "story_v_out_411251.awb")

						arg_162_1:RecordAudio("411251039", var_165_21)
						arg_162_1:RecordAudio("411251039", var_165_21)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_411251", "411251039", "story_v_out_411251.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_411251", "411251039", "story_v_out_411251.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_22 = math.max(var_165_13, arg_162_1.talkMaxDuration)

			if var_165_12 <= arg_162_1.time_ and arg_162_1.time_ < var_165_12 + var_165_22 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_12) / var_165_22

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_12 + var_165_22 and arg_162_1.time_ < var_165_12 + var_165_22 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play411251040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 411251040
		arg_166_1.duration_ = 5.4

		local var_166_0 = {
			zh = 5.4,
			ja = 4.6
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play411251041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["4040ui_story"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect4040ui_story == nil then
				arg_166_1.var_.characterEffect4040ui_story = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.200000002980232

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect4040ui_story and not isNil(var_169_0) then
					local var_169_4 = Mathf.Lerp(0, 0.5, var_169_3)

					arg_166_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_166_1.var_.characterEffect4040ui_story.fillRatio = var_169_4
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect4040ui_story then
				local var_169_5 = 0.5

				arg_166_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_166_1.var_.characterEffect4040ui_story.fillRatio = var_169_5
			end

			local var_169_6 = arg_166_1.actors_["10058ui_story"]
			local var_169_7 = 0

			if var_169_7 < arg_166_1.time_ and arg_166_1.time_ <= var_169_7 + arg_169_0 and not isNil(var_169_6) and arg_166_1.var_.characterEffect10058ui_story == nil then
				arg_166_1.var_.characterEffect10058ui_story = var_169_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_8 = 0.200000002980232

			if var_169_7 <= arg_166_1.time_ and arg_166_1.time_ < var_169_7 + var_169_8 and not isNil(var_169_6) then
				local var_169_9 = (arg_166_1.time_ - var_169_7) / var_169_8

				if arg_166_1.var_.characterEffect10058ui_story and not isNil(var_169_6) then
					arg_166_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_7 + var_169_8 and arg_166_1.time_ < var_169_7 + var_169_8 + arg_169_0 and not isNil(var_169_6) and arg_166_1.var_.characterEffect10058ui_story then
				arg_166_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_169_10 = 0
			local var_169_11 = 0.625

			if var_169_10 < arg_166_1.time_ and arg_166_1.time_ <= var_169_10 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_12 = arg_166_1:FormatText(StoryNameCfg[471].name)

				arg_166_1.leftNameTxt_.text = var_169_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_13 = arg_166_1:GetWordFromCfg(411251040)
				local var_169_14 = arg_166_1:FormatText(var_169_13.content)

				arg_166_1.text_.text = var_169_14

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_15 = 25
				local var_169_16 = utf8.len(var_169_14)
				local var_169_17 = var_169_15 <= 0 and var_169_11 or var_169_11 * (var_169_16 / var_169_15)

				if var_169_17 > 0 and var_169_11 < var_169_17 then
					arg_166_1.talkMaxDuration = var_169_17

					if var_169_17 + var_169_10 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_17 + var_169_10
					end
				end

				arg_166_1.text_.text = var_169_14
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251040", "story_v_out_411251.awb") ~= 0 then
					local var_169_18 = manager.audio:GetVoiceLength("story_v_out_411251", "411251040", "story_v_out_411251.awb") / 1000

					if var_169_18 + var_169_10 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_18 + var_169_10
					end

					if var_169_13.prefab_name ~= "" and arg_166_1.actors_[var_169_13.prefab_name] ~= nil then
						local var_169_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_13.prefab_name].transform, "story_v_out_411251", "411251040", "story_v_out_411251.awb")

						arg_166_1:RecordAudio("411251040", var_169_19)
						arg_166_1:RecordAudio("411251040", var_169_19)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_411251", "411251040", "story_v_out_411251.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_411251", "411251040", "story_v_out_411251.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_20 = math.max(var_169_11, arg_166_1.talkMaxDuration)

			if var_169_10 <= arg_166_1.time_ and arg_166_1.time_ < var_169_10 + var_169_20 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_10) / var_169_20

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_10 + var_169_20 and arg_166_1.time_ < var_169_10 + var_169_20 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play411251041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 411251041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play411251042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["10058ui_story"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect10058ui_story == nil then
				arg_170_1.var_.characterEffect10058ui_story = var_173_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.200000002980232

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.characterEffect10058ui_story and not isNil(var_173_0) then
					local var_173_4 = Mathf.Lerp(0, 0.5, var_173_3)

					arg_170_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_170_1.var_.characterEffect10058ui_story.fillRatio = var_173_4
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect10058ui_story then
				local var_173_5 = 0.5

				arg_170_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_170_1.var_.characterEffect10058ui_story.fillRatio = var_173_5
			end

			local var_173_6 = 0

			if var_173_6 < arg_170_1.time_ and arg_170_1.time_ <= var_173_6 + arg_173_0 then
				arg_170_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_2")
			end

			local var_173_7 = 0
			local var_173_8 = 0.975

			if var_173_7 < arg_170_1.time_ and arg_170_1.time_ <= var_173_7 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_9 = arg_170_1:GetWordFromCfg(411251041)
				local var_173_10 = arg_170_1:FormatText(var_173_9.content)

				arg_170_1.text_.text = var_173_10

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_11 = 39
				local var_173_12 = utf8.len(var_173_10)
				local var_173_13 = var_173_11 <= 0 and var_173_8 or var_173_8 * (var_173_12 / var_173_11)

				if var_173_13 > 0 and var_173_8 < var_173_13 then
					arg_170_1.talkMaxDuration = var_173_13

					if var_173_13 + var_173_7 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_13 + var_173_7
					end
				end

				arg_170_1.text_.text = var_173_10
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_14 = math.max(var_173_8, arg_170_1.talkMaxDuration)

			if var_173_7 <= arg_170_1.time_ and arg_170_1.time_ < var_173_7 + var_173_14 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_7) / var_173_14

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_7 + var_173_14 and arg_170_1.time_ < var_173_7 + var_173_14 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play411251042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 411251042
		arg_174_1.duration_ = 3.17

		local var_174_0 = {
			zh = 2.3,
			ja = 3.166
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play411251043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["4040ui_story"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect4040ui_story == nil then
				arg_174_1.var_.characterEffect4040ui_story = var_177_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.200000002980232

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.characterEffect4040ui_story and not isNil(var_177_0) then
					arg_174_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect4040ui_story then
				arg_174_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_177_4 = arg_174_1.actors_["10058ui_story"]
			local var_177_5 = 0

			if var_177_5 < arg_174_1.time_ and arg_174_1.time_ <= var_177_5 + arg_177_0 and not isNil(var_177_4) and arg_174_1.var_.characterEffect10058ui_story == nil then
				arg_174_1.var_.characterEffect10058ui_story = var_177_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_6 = 0.200000002980232

			if var_177_5 <= arg_174_1.time_ and arg_174_1.time_ < var_177_5 + var_177_6 and not isNil(var_177_4) then
				local var_177_7 = (arg_174_1.time_ - var_177_5) / var_177_6

				if arg_174_1.var_.characterEffect10058ui_story and not isNil(var_177_4) then
					local var_177_8 = Mathf.Lerp(0, 0.5, var_177_7)

					arg_174_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_174_1.var_.characterEffect10058ui_story.fillRatio = var_177_8
				end
			end

			if arg_174_1.time_ >= var_177_5 + var_177_6 and arg_174_1.time_ < var_177_5 + var_177_6 + arg_177_0 and not isNil(var_177_4) and arg_174_1.var_.characterEffect10058ui_story then
				local var_177_9 = 0.5

				arg_174_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_174_1.var_.characterEffect10058ui_story.fillRatio = var_177_9
			end

			local var_177_10 = 0
			local var_177_11 = 0.3

			if var_177_10 < arg_174_1.time_ and arg_174_1.time_ <= var_177_10 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_12 = arg_174_1:FormatText(StoryNameCfg[668].name)

				arg_174_1.leftNameTxt_.text = var_177_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_13 = arg_174_1:GetWordFromCfg(411251042)
				local var_177_14 = arg_174_1:FormatText(var_177_13.content)

				arg_174_1.text_.text = var_177_14

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_15 = 12
				local var_177_16 = utf8.len(var_177_14)
				local var_177_17 = var_177_15 <= 0 and var_177_11 or var_177_11 * (var_177_16 / var_177_15)

				if var_177_17 > 0 and var_177_11 < var_177_17 then
					arg_174_1.talkMaxDuration = var_177_17

					if var_177_17 + var_177_10 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_17 + var_177_10
					end
				end

				arg_174_1.text_.text = var_177_14
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251042", "story_v_out_411251.awb") ~= 0 then
					local var_177_18 = manager.audio:GetVoiceLength("story_v_out_411251", "411251042", "story_v_out_411251.awb") / 1000

					if var_177_18 + var_177_10 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_18 + var_177_10
					end

					if var_177_13.prefab_name ~= "" and arg_174_1.actors_[var_177_13.prefab_name] ~= nil then
						local var_177_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_13.prefab_name].transform, "story_v_out_411251", "411251042", "story_v_out_411251.awb")

						arg_174_1:RecordAudio("411251042", var_177_19)
						arg_174_1:RecordAudio("411251042", var_177_19)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_411251", "411251042", "story_v_out_411251.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_411251", "411251042", "story_v_out_411251.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_20 = math.max(var_177_11, arg_174_1.talkMaxDuration)

			if var_177_10 <= arg_174_1.time_ and arg_174_1.time_ < var_177_10 + var_177_20 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_10) / var_177_20

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_10 + var_177_20 and arg_174_1.time_ < var_177_10 + var_177_20 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play411251043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 411251043
		arg_178_1.duration_ = 3.9

		local var_178_0 = {
			zh = 1.5,
			ja = 3.9
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
				arg_178_0:Play411251044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["4040ui_story"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect4040ui_story == nil then
				arg_178_1.var_.characterEffect4040ui_story = var_181_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.200000002980232

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.characterEffect4040ui_story and not isNil(var_181_0) then
					local var_181_4 = Mathf.Lerp(0, 0.5, var_181_3)

					arg_178_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_178_1.var_.characterEffect4040ui_story.fillRatio = var_181_4
				end
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect4040ui_story then
				local var_181_5 = 0.5

				arg_178_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_178_1.var_.characterEffect4040ui_story.fillRatio = var_181_5
			end

			local var_181_6 = arg_178_1.actors_["10058ui_story"]
			local var_181_7 = 0

			if var_181_7 < arg_178_1.time_ and arg_178_1.time_ <= var_181_7 + arg_181_0 and not isNil(var_181_6) and arg_178_1.var_.characterEffect10058ui_story == nil then
				arg_178_1.var_.characterEffect10058ui_story = var_181_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_8 = 0.200000002980232

			if var_181_7 <= arg_178_1.time_ and arg_178_1.time_ < var_181_7 + var_181_8 and not isNil(var_181_6) then
				local var_181_9 = (arg_178_1.time_ - var_181_7) / var_181_8

				if arg_178_1.var_.characterEffect10058ui_story and not isNil(var_181_6) then
					arg_178_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_7 + var_181_8 and arg_178_1.time_ < var_181_7 + var_181_8 + arg_181_0 and not isNil(var_181_6) and arg_178_1.var_.characterEffect10058ui_story then
				arg_178_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_181_10 = 0
			local var_181_11 = 0.175

			if var_181_10 < arg_178_1.time_ and arg_178_1.time_ <= var_181_10 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_12 = arg_178_1:FormatText(StoryNameCfg[471].name)

				arg_178_1.leftNameTxt_.text = var_181_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_13 = arg_178_1:GetWordFromCfg(411251043)
				local var_181_14 = arg_178_1:FormatText(var_181_13.content)

				arg_178_1.text_.text = var_181_14

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_15 = 7
				local var_181_16 = utf8.len(var_181_14)
				local var_181_17 = var_181_15 <= 0 and var_181_11 or var_181_11 * (var_181_16 / var_181_15)

				if var_181_17 > 0 and var_181_11 < var_181_17 then
					arg_178_1.talkMaxDuration = var_181_17

					if var_181_17 + var_181_10 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_17 + var_181_10
					end
				end

				arg_178_1.text_.text = var_181_14
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251043", "story_v_out_411251.awb") ~= 0 then
					local var_181_18 = manager.audio:GetVoiceLength("story_v_out_411251", "411251043", "story_v_out_411251.awb") / 1000

					if var_181_18 + var_181_10 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_18 + var_181_10
					end

					if var_181_13.prefab_name ~= "" and arg_178_1.actors_[var_181_13.prefab_name] ~= nil then
						local var_181_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_13.prefab_name].transform, "story_v_out_411251", "411251043", "story_v_out_411251.awb")

						arg_178_1:RecordAudio("411251043", var_181_19)
						arg_178_1:RecordAudio("411251043", var_181_19)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_411251", "411251043", "story_v_out_411251.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_411251", "411251043", "story_v_out_411251.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_20 = math.max(var_181_11, arg_178_1.talkMaxDuration)

			if var_181_10 <= arg_178_1.time_ and arg_178_1.time_ < var_181_10 + var_181_20 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_10) / var_181_20

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_10 + var_181_20 and arg_178_1.time_ < var_181_10 + var_181_20 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play411251044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 411251044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play411251045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["4040ui_story"].transform
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.var_.moveOldPos4040ui_story = var_185_0.localPosition
			end

			local var_185_2 = 0.001

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2
				local var_185_4 = Vector3.New(0, 100, 0)

				var_185_0.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos4040ui_story, var_185_4, var_185_3)

				local var_185_5 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_5.x, var_185_5.y, var_185_5.z)

				local var_185_6 = var_185_0.localEulerAngles

				var_185_6.z = 0
				var_185_6.x = 0
				var_185_0.localEulerAngles = var_185_6
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 then
				var_185_0.localPosition = Vector3.New(0, 100, 0)

				local var_185_7 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_7.x, var_185_7.y, var_185_7.z)

				local var_185_8 = var_185_0.localEulerAngles

				var_185_8.z = 0
				var_185_8.x = 0
				var_185_0.localEulerAngles = var_185_8
			end

			local var_185_9 = arg_182_1.actors_["4040ui_story"]
			local var_185_10 = 0

			if var_185_10 < arg_182_1.time_ and arg_182_1.time_ <= var_185_10 + arg_185_0 and not isNil(var_185_9) and arg_182_1.var_.characterEffect4040ui_story == nil then
				arg_182_1.var_.characterEffect4040ui_story = var_185_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_11 = 0.200000002980232

			if var_185_10 <= arg_182_1.time_ and arg_182_1.time_ < var_185_10 + var_185_11 and not isNil(var_185_9) then
				local var_185_12 = (arg_182_1.time_ - var_185_10) / var_185_11

				if arg_182_1.var_.characterEffect4040ui_story and not isNil(var_185_9) then
					local var_185_13 = Mathf.Lerp(0, 0.5, var_185_12)

					arg_182_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_182_1.var_.characterEffect4040ui_story.fillRatio = var_185_13
				end
			end

			if arg_182_1.time_ >= var_185_10 + var_185_11 and arg_182_1.time_ < var_185_10 + var_185_11 + arg_185_0 and not isNil(var_185_9) and arg_182_1.var_.characterEffect4040ui_story then
				local var_185_14 = 0.5

				arg_182_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_182_1.var_.characterEffect4040ui_story.fillRatio = var_185_14
			end

			local var_185_15 = arg_182_1.actors_["10058ui_story"].transform
			local var_185_16 = 0

			if var_185_16 < arg_182_1.time_ and arg_182_1.time_ <= var_185_16 + arg_185_0 then
				arg_182_1.var_.moveOldPos10058ui_story = var_185_15.localPosition
			end

			local var_185_17 = 0.001

			if var_185_16 <= arg_182_1.time_ and arg_182_1.time_ < var_185_16 + var_185_17 then
				local var_185_18 = (arg_182_1.time_ - var_185_16) / var_185_17
				local var_185_19 = Vector3.New(0, 100, 0)

				var_185_15.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10058ui_story, var_185_19, var_185_18)

				local var_185_20 = manager.ui.mainCamera.transform.position - var_185_15.position

				var_185_15.forward = Vector3.New(var_185_20.x, var_185_20.y, var_185_20.z)

				local var_185_21 = var_185_15.localEulerAngles

				var_185_21.z = 0
				var_185_21.x = 0
				var_185_15.localEulerAngles = var_185_21
			end

			if arg_182_1.time_ >= var_185_16 + var_185_17 and arg_182_1.time_ < var_185_16 + var_185_17 + arg_185_0 then
				var_185_15.localPosition = Vector3.New(0, 100, 0)

				local var_185_22 = manager.ui.mainCamera.transform.position - var_185_15.position

				var_185_15.forward = Vector3.New(var_185_22.x, var_185_22.y, var_185_22.z)

				local var_185_23 = var_185_15.localEulerAngles

				var_185_23.z = 0
				var_185_23.x = 0
				var_185_15.localEulerAngles = var_185_23
			end

			local var_185_24 = arg_182_1.actors_["10058ui_story"]
			local var_185_25 = 0

			if var_185_25 < arg_182_1.time_ and arg_182_1.time_ <= var_185_25 + arg_185_0 and not isNil(var_185_24) and arg_182_1.var_.characterEffect10058ui_story == nil then
				arg_182_1.var_.characterEffect10058ui_story = var_185_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_26 = 0.200000002980232

			if var_185_25 <= arg_182_1.time_ and arg_182_1.time_ < var_185_25 + var_185_26 and not isNil(var_185_24) then
				local var_185_27 = (arg_182_1.time_ - var_185_25) / var_185_26

				if arg_182_1.var_.characterEffect10058ui_story and not isNil(var_185_24) then
					local var_185_28 = Mathf.Lerp(0, 0.5, var_185_27)

					arg_182_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_182_1.var_.characterEffect10058ui_story.fillRatio = var_185_28
				end
			end

			if arg_182_1.time_ >= var_185_25 + var_185_26 and arg_182_1.time_ < var_185_25 + var_185_26 + arg_185_0 and not isNil(var_185_24) and arg_182_1.var_.characterEffect10058ui_story then
				local var_185_29 = 0.5

				arg_182_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_182_1.var_.characterEffect10058ui_story.fillRatio = var_185_29
			end

			local var_185_30 = 0
			local var_185_31 = 1.05

			if var_185_30 < arg_182_1.time_ and arg_182_1.time_ <= var_185_30 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_32 = arg_182_1:GetWordFromCfg(411251044)
				local var_185_33 = arg_182_1:FormatText(var_185_32.content)

				arg_182_1.text_.text = var_185_33

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_34 = 42
				local var_185_35 = utf8.len(var_185_33)
				local var_185_36 = var_185_34 <= 0 and var_185_31 or var_185_31 * (var_185_35 / var_185_34)

				if var_185_36 > 0 and var_185_31 < var_185_36 then
					arg_182_1.talkMaxDuration = var_185_36

					if var_185_36 + var_185_30 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_36 + var_185_30
					end
				end

				arg_182_1.text_.text = var_185_33
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_37 = math.max(var_185_31, arg_182_1.talkMaxDuration)

			if var_185_30 <= arg_182_1.time_ and arg_182_1.time_ < var_185_30 + var_185_37 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_30) / var_185_37

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_30 + var_185_37 and arg_182_1.time_ < var_185_30 + var_185_37 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
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
				actorName = "10058ui_story",
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
	Play411251045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 411251045
		arg_186_1.duration_ = 6.6

		local var_186_0 = {
			zh = 6.066,
			ja = 6.6
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
			arg_186_1.auto_ = false
		end

		function arg_186_1.playNext_(arg_188_0)
			arg_186_1.onStoryFinished_()
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["4040ui_story"].transform
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1.var_.moveOldPos4040ui_story = var_189_0.localPosition
			end

			local var_189_2 = 0.001

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2
				local var_189_4 = Vector3.New(0, -1.55, -5.5)

				var_189_0.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos4040ui_story, var_189_4, var_189_3)

				local var_189_5 = manager.ui.mainCamera.transform.position - var_189_0.position

				var_189_0.forward = Vector3.New(var_189_5.x, var_189_5.y, var_189_5.z)

				local var_189_6 = var_189_0.localEulerAngles

				var_189_6.z = 0
				var_189_6.x = 0
				var_189_0.localEulerAngles = var_189_6
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 then
				var_189_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_189_7 = manager.ui.mainCamera.transform.position - var_189_0.position

				var_189_0.forward = Vector3.New(var_189_7.x, var_189_7.y, var_189_7.z)

				local var_189_8 = var_189_0.localEulerAngles

				var_189_8.z = 0
				var_189_8.x = 0
				var_189_0.localEulerAngles = var_189_8
			end

			local var_189_9 = arg_186_1.actors_["4040ui_story"]
			local var_189_10 = 0

			if var_189_10 < arg_186_1.time_ and arg_186_1.time_ <= var_189_10 + arg_189_0 and not isNil(var_189_9) and arg_186_1.var_.characterEffect4040ui_story == nil then
				arg_186_1.var_.characterEffect4040ui_story = var_189_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_11 = 0.200000002980232

			if var_189_10 <= arg_186_1.time_ and arg_186_1.time_ < var_189_10 + var_189_11 and not isNil(var_189_9) then
				local var_189_12 = (arg_186_1.time_ - var_189_10) / var_189_11

				if arg_186_1.var_.characterEffect4040ui_story and not isNil(var_189_9) then
					arg_186_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_10 + var_189_11 and arg_186_1.time_ < var_189_10 + var_189_11 + arg_189_0 and not isNil(var_189_9) and arg_186_1.var_.characterEffect4040ui_story then
				arg_186_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_189_13 = 0

			if var_189_13 < arg_186_1.time_ and arg_186_1.time_ <= var_189_13 + arg_189_0 then
				arg_186_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_189_14 = 0

			if var_189_14 < arg_186_1.time_ and arg_186_1.time_ <= var_189_14 + arg_189_0 then
				arg_186_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_189_15 = 0
			local var_189_16 = 0.6

			if var_189_15 < arg_186_1.time_ and arg_186_1.time_ <= var_189_15 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_17 = arg_186_1:FormatText(StoryNameCfg[668].name)

				arg_186_1.leftNameTxt_.text = var_189_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_18 = arg_186_1:GetWordFromCfg(411251045)
				local var_189_19 = arg_186_1:FormatText(var_189_18.content)

				arg_186_1.text_.text = var_189_19

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_20 = 24
				local var_189_21 = utf8.len(var_189_19)
				local var_189_22 = var_189_20 <= 0 and var_189_16 or var_189_16 * (var_189_21 / var_189_20)

				if var_189_22 > 0 and var_189_16 < var_189_22 then
					arg_186_1.talkMaxDuration = var_189_22

					if var_189_22 + var_189_15 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_22 + var_189_15
					end
				end

				arg_186_1.text_.text = var_189_19
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411251", "411251045", "story_v_out_411251.awb") ~= 0 then
					local var_189_23 = manager.audio:GetVoiceLength("story_v_out_411251", "411251045", "story_v_out_411251.awb") / 1000

					if var_189_23 + var_189_15 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_23 + var_189_15
					end

					if var_189_18.prefab_name ~= "" and arg_186_1.actors_[var_189_18.prefab_name] ~= nil then
						local var_189_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_18.prefab_name].transform, "story_v_out_411251", "411251045", "story_v_out_411251.awb")

						arg_186_1:RecordAudio("411251045", var_189_24)
						arg_186_1:RecordAudio("411251045", var_189_24)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_411251", "411251045", "story_v_out_411251.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_411251", "411251045", "story_v_out_411251.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_25 = math.max(var_189_16, arg_186_1.talkMaxDuration)

			if var_189_15 <= arg_186_1.time_ and arg_186_1.time_ < var_189_15 + var_189_25 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_15) / var_189_25

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_15 + var_189_25 and arg_186_1.time_ < var_189_15 + var_189_25 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
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

		arg_186_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST77",
		"TextureConfig/Background/L01f"
	},
	voices = {
		"story_v_out_411251.awb"
	}
}
