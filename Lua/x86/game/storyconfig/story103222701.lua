return {
	Play322271001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322271001
		arg_1_1.duration_ = 6.99

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322271002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.9

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "ST0512"

			if arg_1_1.bgs_[var_4_2] == nil then
				local var_4_3 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_2)
				var_4_3.name = var_4_2
				var_4_3.transform.parent = arg_1_1.stage_.transform
				var_4_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_2] = var_4_3
			end

			local var_4_4 = 0

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				local var_4_5 = manager.ui.mainCamera.transform.localPosition
				local var_4_6 = Vector3.New(0, 0, 10) + Vector3.New(var_4_5.x, var_4_5.y, 0)
				local var_4_7 = arg_1_1.bgs_.ST0512

				var_4_7.transform.localPosition = var_4_6
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = (var_4_7.transform.localPosition - var_4_5).z
					local var_4_10 = manager.ui.mainCameraCom_
					local var_4_11 = 2 * var_4_9 * Mathf.Tan(var_4_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_12 = var_4_11 * var_4_10.aspect
					local var_4_13 = var_4_8.sprite.bounds.size.x
					local var_4_14 = var_4_8.sprite.bounds.size.y
					local var_4_15 = var_4_12 / var_4_13
					local var_4_16 = var_4_11 / var_4_14
					local var_4_17 = var_4_16 < var_4_15 and var_4_15 or var_4_16

					var_4_7.transform.localScale = Vector3.New(var_4_17, var_4_17, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0512" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			local var_4_30 = 0.500666666666667
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_4_5_story_watcher_ruin", "bgm_activity_4_5_story_watcher_ruin", "bgm_activity_4_5_story_watcher_ruin.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_4_5_story_watcher_ruin", "bgm_activity_4_5_story_watcher_ruin")

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

			local var_4_36 = 0.2
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_145", "se_story_145_amb_ST0512", "")
			end

			local var_4_40 = 2.63333333333333
			local var_4_41 = 1

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				local var_4_42 = "play"
				local var_4_43 = "effect"

				arg_1_1:AudioAction(var_4_42, var_4_43, "se_story_145", "se_story_145_summon_slime1", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_44 = 1.98843149817549
			local var_4_45 = 1.45

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_46 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_46:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_47 = arg_1_1:GetWordFromCfg(322271001)
				local var_4_48 = arg_1_1:FormatText(var_4_47.content)

				arg_1_1.text_.text = var_4_48

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_49 = 58
				local var_4_50 = utf8.len(var_4_48)
				local var_4_51 = var_4_49 <= 0 and var_4_45 or var_4_45 * (var_4_50 / var_4_49)

				if var_4_51 > 0 and var_4_45 < var_4_51 then
					arg_1_1.talkMaxDuration = var_4_51
					var_4_44 = var_4_44 + 0.3

					if var_4_51 + var_4_44 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_51 + var_4_44
					end
				end

				arg_1_1.text_.text = var_4_48
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_52 = var_4_44 + 0.3
			local var_4_53 = math.max(var_4_45, arg_1_1.talkMaxDuration)

			if var_4_52 <= arg_1_1.time_ and arg_1_1.time_ < var_4_52 + var_4_53 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_52) / var_4_53

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_52 + var_4_53 and arg_1_1.time_ < var_4_52 + var_4_53 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play322271002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322271002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play322271003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.125

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[7].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(322271002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 5
				local var_12_6 = utf8.len(var_12_4)
				local var_12_7 = var_12_5 <= 0 and var_12_1 or var_12_1 * (var_12_6 / var_12_5)

				if var_12_7 > 0 and var_12_1 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_8 and arg_9_1.time_ < var_12_0 + var_12_8 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play322271003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322271003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play322271004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10149ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "10149ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "10149ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["10149ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos10149ui_story = var_16_5.localPosition

				local var_16_7 = GameObjectTools.GetOrAddComponent(var_16_5.gameObject, typeof(DynamicBoneHelper))

				if var_16_7 then
					var_16_7:EnableDynamicBone(false)
				end
			end

			local var_16_8 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_6) / var_16_8
				local var_16_10 = Vector3.New(0, -1.05, -5.8)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10149ui_story, var_16_10, var_16_9)

				local var_16_11 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_11.x, var_16_11.y, var_16_11.z)

				local var_16_12 = var_16_5.localEulerAngles

				var_16_12.z = 0
				var_16_12.x = 0
				var_16_5.localEulerAngles = var_16_12
			end

			if arg_13_1.time_ >= var_16_6 + var_16_8 and arg_13_1.time_ < var_16_6 + var_16_8 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -1.05, -5.8)

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

			local var_16_16 = arg_13_1.actors_["10149ui_story"]
			local var_16_17 = 0

			if var_16_17 < arg_13_1.time_ and arg_13_1.time_ <= var_16_17 + arg_16_0 and not isNil(var_16_16) and arg_13_1.var_.characterEffect10149ui_story == nil then
				arg_13_1.var_.characterEffect10149ui_story = var_16_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_18 = 0.200000002980232

			if var_16_17 <= arg_13_1.time_ and arg_13_1.time_ < var_16_17 + var_16_18 and not isNil(var_16_16) then
				local var_16_19 = (arg_13_1.time_ - var_16_17) / var_16_18

				if arg_13_1.var_.characterEffect10149ui_story and not isNil(var_16_16) then
					arg_13_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_17 + var_16_18 and arg_13_1.time_ < var_16_17 + var_16_18 + arg_16_0 and not isNil(var_16_16) and arg_13_1.var_.characterEffect10149ui_story then
				arg_13_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_16_20 = 0

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action4_1")
			end

			local var_16_21 = 0

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_16_22 = 0

			if var_16_22 < arg_13_1.time_ and arg_13_1.time_ <= var_16_22 + arg_16_0 then
				local var_16_23 = arg_13_1.actors_["10149ui_story"]

				if not isNil(var_16_23) then
					local var_16_24 = GameObjectTools.GetOrAddComponent(var_16_23, typeof(DynamicBoneHelper))

					if var_16_24 then
						var_16_24:EnableDynamicBone(true)
					end
				end
			end

			local var_16_25 = 0
			local var_16_26 = 0.35

			if var_16_25 < arg_13_1.time_ and arg_13_1.time_ <= var_16_25 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_27 = arg_13_1:FormatText(StoryNameCfg[1371].name)

				arg_13_1.leftNameTxt_.text = var_16_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_28 = arg_13_1:GetWordFromCfg(322271003)
				local var_16_29 = arg_13_1:FormatText(var_16_28.content)

				arg_13_1.text_.text = var_16_29

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_30 = 14
				local var_16_31 = utf8.len(var_16_29)
				local var_16_32 = var_16_30 <= 0 and var_16_26 or var_16_26 * (var_16_31 / var_16_30)

				if var_16_32 > 0 and var_16_26 < var_16_32 then
					arg_13_1.talkMaxDuration = var_16_32

					if var_16_32 + var_16_25 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_32 + var_16_25
					end
				end

				arg_13_1.text_.text = var_16_29
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271003", "story_v_out_322271.awb") ~= 0 then
					local var_16_33 = manager.audio:GetVoiceLength("story_v_out_322271", "322271003", "story_v_out_322271.awb") / 1000

					if var_16_33 + var_16_25 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_33 + var_16_25
					end

					if var_16_28.prefab_name ~= "" and arg_13_1.actors_[var_16_28.prefab_name] ~= nil then
						local var_16_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_28.prefab_name].transform, "story_v_out_322271", "322271003", "story_v_out_322271.awb")

						arg_13_1:RecordAudio("322271003", var_16_34)
						arg_13_1:RecordAudio("322271003", var_16_34)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_322271", "322271003", "story_v_out_322271.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_322271", "322271003", "story_v_out_322271.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_35 = math.max(var_16_26, arg_13_1.talkMaxDuration)

			if var_16_25 <= arg_13_1.time_ and arg_13_1.time_ < var_16_25 + var_16_35 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_25) / var_16_35

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_25 + var_16_35 and arg_13_1.time_ < var_16_25 + var_16_35 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
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
	Play322271004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322271004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play322271005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10149ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10149ui_story == nil then
				arg_17_1.var_.characterEffect10149ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect10149ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10149ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10149ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10149ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.525

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_9 = arg_17_1:GetWordFromCfg(322271004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 21
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
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_14 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_14 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_14

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_14 and arg_17_1.time_ < var_20_6 + var_20_14 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play322271005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322271005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play322271006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10149ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10149ui_story = var_24_0.localPosition

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0.gameObject, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end
			end

			local var_24_3 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_3 then
				local var_24_4 = (arg_21_1.time_ - var_24_1) / var_24_3
				local var_24_5 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10149ui_story, var_24_5, var_24_4)

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

			local var_24_11 = 0
			local var_24_12 = 1.05

			if var_24_11 < arg_21_1.time_ and arg_21_1.time_ <= var_24_11 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_13 = arg_21_1:GetWordFromCfg(322271005)
				local var_24_14 = arg_21_1:FormatText(var_24_13.content)

				arg_21_1.text_.text = var_24_14

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_15 = 42
				local var_24_16 = utf8.len(var_24_14)
				local var_24_17 = var_24_15 <= 0 and var_24_12 or var_24_12 * (var_24_16 / var_24_15)

				if var_24_17 > 0 and var_24_12 < var_24_17 then
					arg_21_1.talkMaxDuration = var_24_17

					if var_24_17 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_17 + var_24_11
					end
				end

				arg_21_1.text_.text = var_24_14
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_18 = math.max(var_24_12, arg_21_1.talkMaxDuration)

			if var_24_11 <= arg_21_1.time_ and arg_21_1.time_ < var_24_11 + var_24_18 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_11) / var_24_18

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_11 + var_24_18 and arg_21_1.time_ < var_24_11 + var_24_18 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
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
	Play322271006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322271006
		arg_25_1.duration_ = 7.97

		local var_25_0 = {
			zh = 7.766,
			ja = 7.966
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
				arg_25_0:Play322271007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10149ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos10149ui_story = var_28_0.localPosition

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0.gameObject, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end
			end

			local var_28_3 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_3 then
				local var_28_4 = (arg_25_1.time_ - var_28_1) / var_28_3
				local var_28_5 = Vector3.New(0, -1.05, -5.8)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10149ui_story, var_28_5, var_28_4)

				local var_28_6 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_6.x, var_28_6.y, var_28_6.z)

				local var_28_7 = var_28_0.localEulerAngles

				var_28_7.z = 0
				var_28_7.x = 0
				var_28_0.localEulerAngles = var_28_7
			end

			if arg_25_1.time_ >= var_28_1 + var_28_3 and arg_25_1.time_ < var_28_1 + var_28_3 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -1.05, -5.8)

				local var_28_8 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_8.x, var_28_8.y, var_28_8.z)

				local var_28_9 = var_28_0.localEulerAngles

				var_28_9.z = 0
				var_28_9.x = 0
				var_28_0.localEulerAngles = var_28_9

				local var_28_10 = GameObjectTools.GetOrAddComponent(var_28_0.gameObject, typeof(DynamicBoneHelper))

				if var_28_10 then
					var_28_10:EnableDynamicBone(true)
				end
			end

			local var_28_11 = arg_25_1.actors_["10149ui_story"]
			local var_28_12 = 0

			if var_28_12 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.characterEffect10149ui_story == nil then
				arg_25_1.var_.characterEffect10149ui_story = var_28_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_13 = 0.200000002980232

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_13 and not isNil(var_28_11) then
				local var_28_14 = (arg_25_1.time_ - var_28_12) / var_28_13

				if arg_25_1.var_.characterEffect10149ui_story and not isNil(var_28_11) then
					arg_25_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_12 + var_28_13 and arg_25_1.time_ < var_28_12 + var_28_13 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.characterEffect10149ui_story then
				arg_25_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action4_2")
			end

			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_28_17 = 0

			if var_28_17 < arg_25_1.time_ and arg_25_1.time_ <= var_28_17 + arg_28_0 then
				local var_28_18 = arg_25_1.actors_["10149ui_story"]

				if not isNil(var_28_18) then
					local var_28_19 = GameObjectTools.GetOrAddComponent(var_28_18, typeof(DynamicBoneHelper))

					if var_28_19 then
						var_28_19:EnableDynamicBone(true)
					end
				end
			end

			local var_28_20 = 0
			local var_28_21 = 0.65

			if var_28_20 < arg_25_1.time_ and arg_25_1.time_ <= var_28_20 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_22 = arg_25_1:FormatText(StoryNameCfg[1371].name)

				arg_25_1.leftNameTxt_.text = var_28_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_23 = arg_25_1:GetWordFromCfg(322271006)
				local var_28_24 = arg_25_1:FormatText(var_28_23.content)

				arg_25_1.text_.text = var_28_24

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_25 = 26
				local var_28_26 = utf8.len(var_28_24)
				local var_28_27 = var_28_25 <= 0 and var_28_21 or var_28_21 * (var_28_26 / var_28_25)

				if var_28_27 > 0 and var_28_21 < var_28_27 then
					arg_25_1.talkMaxDuration = var_28_27

					if var_28_27 + var_28_20 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_27 + var_28_20
					end
				end

				arg_25_1.text_.text = var_28_24
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271006", "story_v_out_322271.awb") ~= 0 then
					local var_28_28 = manager.audio:GetVoiceLength("story_v_out_322271", "322271006", "story_v_out_322271.awb") / 1000

					if var_28_28 + var_28_20 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_28 + var_28_20
					end

					if var_28_23.prefab_name ~= "" and arg_25_1.actors_[var_28_23.prefab_name] ~= nil then
						local var_28_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_23.prefab_name].transform, "story_v_out_322271", "322271006", "story_v_out_322271.awb")

						arg_25_1:RecordAudio("322271006", var_28_29)
						arg_25_1:RecordAudio("322271006", var_28_29)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_322271", "322271006", "story_v_out_322271.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_322271", "322271006", "story_v_out_322271.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_30 = math.max(var_28_21, arg_25_1.talkMaxDuration)

			if var_28_20 <= arg_25_1.time_ and arg_25_1.time_ < var_28_20 + var_28_30 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_20) / var_28_30

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_20 + var_28_30 and arg_25_1.time_ < var_28_20 + var_28_30 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
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
	Play322271007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 322271007
		arg_29_1.duration_ = 11.2

		local var_29_0 = {
			zh = 11.2,
			ja = 10.4
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
				arg_29_0:Play322271008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1.225

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[1371].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(322271007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 48
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271007", "story_v_out_322271.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271007", "story_v_out_322271.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_322271", "322271007", "story_v_out_322271.awb")

						arg_29_1:RecordAudio("322271007", var_32_9)
						arg_29_1:RecordAudio("322271007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_322271", "322271007", "story_v_out_322271.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_322271", "322271007", "story_v_out_322271.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play322271008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322271008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play322271009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10149ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10149ui_story == nil then
				arg_33_1.var_.characterEffect10149ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect10149ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10149ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10149ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10149ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.7

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(322271008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 28
				local var_36_11 = utf8.len(var_36_9)
				local var_36_12 = var_36_10 <= 0 and var_36_7 or var_36_7 * (var_36_11 / var_36_10)

				if var_36_12 > 0 and var_36_7 < var_36_12 then
					arg_33_1.talkMaxDuration = var_36_12

					if var_36_12 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_13 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_13 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_13

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_13 and arg_33_1.time_ < var_36_6 + var_36_13 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play322271009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322271009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play322271010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10149ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10149ui_story == nil then
				arg_37_1.var_.characterEffect10149ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect10149ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10149ui_story then
				arg_37_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_40_4 = 0

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action3_1")
			end

			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				local var_40_6 = arg_37_1.actors_["10149ui_story"]

				if not isNil(var_40_6) then
					local var_40_7 = GameObjectTools.GetOrAddComponent(var_40_6, typeof(DynamicBoneHelper))

					if var_40_7 then
						var_40_7:EnableDynamicBone(true)
					end
				end
			end

			local var_40_8 = 0
			local var_40_9 = 0.425

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_10 = arg_37_1:FormatText(StoryNameCfg[1371].name)

				arg_37_1.leftNameTxt_.text = var_40_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_11 = arg_37_1:GetWordFromCfg(322271009)
				local var_40_12 = arg_37_1:FormatText(var_40_11.content)

				arg_37_1.text_.text = var_40_12

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 17
				local var_40_14 = utf8.len(var_40_12)
				local var_40_15 = var_40_13 <= 0 and var_40_9 or var_40_9 * (var_40_14 / var_40_13)

				if var_40_15 > 0 and var_40_9 < var_40_15 then
					arg_37_1.talkMaxDuration = var_40_15

					if var_40_15 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_15 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_12
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271009", "story_v_out_322271.awb") ~= 0 then
					local var_40_16 = manager.audio:GetVoiceLength("story_v_out_322271", "322271009", "story_v_out_322271.awb") / 1000

					if var_40_16 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_16 + var_40_8
					end

					if var_40_11.prefab_name ~= "" and arg_37_1.actors_[var_40_11.prefab_name] ~= nil then
						local var_40_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_11.prefab_name].transform, "story_v_out_322271", "322271009", "story_v_out_322271.awb")

						arg_37_1:RecordAudio("322271009", var_40_17)
						arg_37_1:RecordAudio("322271009", var_40_17)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_322271", "322271009", "story_v_out_322271.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_322271", "322271009", "story_v_out_322271.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_18 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_18 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_18

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_18 and arg_37_1.time_ < var_40_8 + var_40_18 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play322271010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322271010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play322271011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10149ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10149ui_story == nil then
				arg_41_1.var_.characterEffect10149ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect10149ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10149ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10149ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10149ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.475

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(322271010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 19
				local var_44_12 = utf8.len(var_44_10)
				local var_44_13 = var_44_11 <= 0 and var_44_7 or var_44_7 * (var_44_12 / var_44_11)

				if var_44_13 > 0 and var_44_7 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play322271011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322271011
		arg_45_1.duration_ = 6

		local var_45_0 = {
			zh = 6,
			ja = 4.7
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
				arg_45_0:Play322271012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10149ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10149ui_story == nil then
				arg_45_1.var_.characterEffect10149ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect10149ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10149ui_story then
				arg_45_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_48_4 = 0
			local var_48_5 = 0.375

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_6 = arg_45_1:FormatText(StoryNameCfg[1371].name)

				arg_45_1.leftNameTxt_.text = var_48_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:GetWordFromCfg(322271011)
				local var_48_8 = arg_45_1:FormatText(var_48_7.content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 15
				local var_48_10 = utf8.len(var_48_8)
				local var_48_11 = var_48_9 <= 0 and var_48_5 or var_48_5 * (var_48_10 / var_48_9)

				if var_48_11 > 0 and var_48_5 < var_48_11 then
					arg_45_1.talkMaxDuration = var_48_11

					if var_48_11 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271011", "story_v_out_322271.awb") ~= 0 then
					local var_48_12 = manager.audio:GetVoiceLength("story_v_out_322271", "322271011", "story_v_out_322271.awb") / 1000

					if var_48_12 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_4
					end

					if var_48_7.prefab_name ~= "" and arg_45_1.actors_[var_48_7.prefab_name] ~= nil then
						local var_48_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_7.prefab_name].transform, "story_v_out_322271", "322271011", "story_v_out_322271.awb")

						arg_45_1:RecordAudio("322271011", var_48_13)
						arg_45_1:RecordAudio("322271011", var_48_13)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_322271", "322271011", "story_v_out_322271.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_322271", "322271011", "story_v_out_322271.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_14 and arg_45_1.time_ < var_48_4 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play322271012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322271012
		arg_49_1.duration_ = 17.2

		local var_49_0 = {
			zh = 11.233,
			ja = 17.2
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
				arg_49_0:Play322271013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action3_2")
			end

			local var_52_1 = 0
			local var_52_2 = 1.15

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_3 = arg_49_1:FormatText(StoryNameCfg[1371].name)

				arg_49_1.leftNameTxt_.text = var_52_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(322271012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_6 = 46
				local var_52_7 = utf8.len(var_52_5)
				local var_52_8 = var_52_6 <= 0 and var_52_2 or var_52_2 * (var_52_7 / var_52_6)

				if var_52_8 > 0 and var_52_2 < var_52_8 then
					arg_49_1.talkMaxDuration = var_52_8

					if var_52_8 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271012", "story_v_out_322271.awb") ~= 0 then
					local var_52_9 = manager.audio:GetVoiceLength("story_v_out_322271", "322271012", "story_v_out_322271.awb") / 1000

					if var_52_9 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_1
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_out_322271", "322271012", "story_v_out_322271.awb")

						arg_49_1:RecordAudio("322271012", var_52_10)
						arg_49_1:RecordAudio("322271012", var_52_10)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_322271", "322271012", "story_v_out_322271.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_322271", "322271012", "story_v_out_322271.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_11 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_11 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_11

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_11 and arg_49_1.time_ < var_52_1 + var_52_11 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play322271013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322271013
		arg_53_1.duration_ = 1

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"

			SetActive(arg_53_1.choicesGo_, true)

			for iter_54_0, iter_54_1 in ipairs(arg_53_1.choices_) do
				local var_54_0 = iter_54_0 <= 2

				SetActive(iter_54_1.go, var_54_0)
			end

			arg_53_1.choices_[1].txt.text = arg_53_1:FormatText(StoryChoiceCfg[1417].name)
			arg_53_1.choices_[2].txt.text = arg_53_1:FormatText(StoryChoiceCfg[1418].name)
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play322271014(arg_53_1)
			end

			if arg_55_0 == 2 then
				arg_53_0:Play322271014(arg_53_1)
			end

			arg_53_1:RecordChoiceLog(322271013, 1417, 1418)
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10149ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect10149ui_story == nil then
				arg_53_1.var_.characterEffect10149ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect10149ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10149ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect10149ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10149ui_story.fillRatio = var_56_5
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play322271014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 322271014
		arg_57_1.duration_ = 3.4

		local var_57_0 = {
			zh = 2.666,
			ja = 3.4
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
				arg_57_0:Play322271015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10149ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect10149ui_story == nil then
				arg_57_1.var_.characterEffect10149ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect10149ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect10149ui_story then
				arg_57_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_60_4 = 0
			local var_60_5 = 0.35

			if var_60_4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_6 = arg_57_1:FormatText(StoryNameCfg[1371].name)

				arg_57_1.leftNameTxt_.text = var_60_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_7 = arg_57_1:GetWordFromCfg(322271014)
				local var_60_8 = arg_57_1:FormatText(var_60_7.content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 14
				local var_60_10 = utf8.len(var_60_8)
				local var_60_11 = var_60_9 <= 0 and var_60_5 or var_60_5 * (var_60_10 / var_60_9)

				if var_60_11 > 0 and var_60_5 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271014", "story_v_out_322271.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_out_322271", "322271014", "story_v_out_322271.awb") / 1000

					if var_60_12 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_4
					end

					if var_60_7.prefab_name ~= "" and arg_57_1.actors_[var_60_7.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_7.prefab_name].transform, "story_v_out_322271", "322271014", "story_v_out_322271.awb")

						arg_57_1:RecordAudio("322271014", var_60_13)
						arg_57_1:RecordAudio("322271014", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_322271", "322271014", "story_v_out_322271.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_322271", "322271014", "story_v_out_322271.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_14 and arg_57_1.time_ < var_60_4 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play322271015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322271015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play322271016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10149ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos10149ui_story = var_64_0.localPosition

				local var_64_2 = GameObjectTools.GetOrAddComponent(var_64_0.gameObject, typeof(DynamicBoneHelper))

				if var_64_2 then
					var_64_2:EnableDynamicBone(false)
				end
			end

			local var_64_3 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_3 then
				local var_64_4 = (arg_61_1.time_ - var_64_1) / var_64_3
				local var_64_5 = Vector3.New(0, 100, 0)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10149ui_story, var_64_5, var_64_4)

				local var_64_6 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_6.x, var_64_6.y, var_64_6.z)

				local var_64_7 = var_64_0.localEulerAngles

				var_64_7.z = 0
				var_64_7.x = 0
				var_64_0.localEulerAngles = var_64_7
			end

			if arg_61_1.time_ >= var_64_1 + var_64_3 and arg_61_1.time_ < var_64_1 + var_64_3 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, 100, 0)

				local var_64_8 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_8.x, var_64_8.y, var_64_8.z)

				local var_64_9 = var_64_0.localEulerAngles

				var_64_9.z = 0
				var_64_9.x = 0
				var_64_0.localEulerAngles = var_64_9

				local var_64_10 = GameObjectTools.GetOrAddComponent(var_64_0.gameObject, typeof(DynamicBoneHelper))

				if var_64_10 then
					var_64_10:EnableDynamicBone(true)
				end
			end

			local var_64_11 = arg_61_1.actors_["10149ui_story"]
			local var_64_12 = 0

			if var_64_12 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 and not isNil(var_64_11) and arg_61_1.var_.characterEffect10149ui_story == nil then
				arg_61_1.var_.characterEffect10149ui_story = var_64_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_13 = 0.200000002980232

			if var_64_12 <= arg_61_1.time_ and arg_61_1.time_ < var_64_12 + var_64_13 and not isNil(var_64_11) then
				local var_64_14 = (arg_61_1.time_ - var_64_12) / var_64_13

				if arg_61_1.var_.characterEffect10149ui_story and not isNil(var_64_11) then
					local var_64_15 = Mathf.Lerp(0, 0.5, var_64_14)

					arg_61_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10149ui_story.fillRatio = var_64_15
				end
			end

			if arg_61_1.time_ >= var_64_12 + var_64_13 and arg_61_1.time_ < var_64_12 + var_64_13 + arg_64_0 and not isNil(var_64_11) and arg_61_1.var_.characterEffect10149ui_story then
				local var_64_16 = 0.5

				arg_61_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10149ui_story.fillRatio = var_64_16
			end

			local var_64_17 = 0.200000002980232
			local var_64_18 = 1

			if var_64_17 < arg_61_1.time_ and arg_61_1.time_ <= var_64_17 + arg_64_0 then
				local var_64_19 = "play"
				local var_64_20 = "effect"

				arg_61_1:AudioAction(var_64_19, var_64_20, "se_story_145", "se_story_145_gear1", "")
			end

			local var_64_21 = 0
			local var_64_22 = 0.55

			if var_64_21 < arg_61_1.time_ and arg_61_1.time_ <= var_64_21 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_23 = arg_61_1:GetWordFromCfg(322271015)
				local var_64_24 = arg_61_1:FormatText(var_64_23.content)

				arg_61_1.text_.text = var_64_24

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_25 = 22
				local var_64_26 = utf8.len(var_64_24)
				local var_64_27 = var_64_25 <= 0 and var_64_22 or var_64_22 * (var_64_26 / var_64_25)

				if var_64_27 > 0 and var_64_22 < var_64_27 then
					arg_61_1.talkMaxDuration = var_64_27

					if var_64_27 + var_64_21 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_27 + var_64_21
					end
				end

				arg_61_1.text_.text = var_64_24
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_28 = math.max(var_64_22, arg_61_1.talkMaxDuration)

			if var_64_21 <= arg_61_1.time_ and arg_61_1.time_ < var_64_21 + var_64_28 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_21) / var_64_28

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_21 + var_64_28 and arg_61_1.time_ < var_64_21 + var_64_28 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
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
	Play322271016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 322271016
		arg_65_1.duration_ = 11.07

		local var_65_0 = {
			zh = 6.466,
			ja = 11.066
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
				arg_65_0:Play322271017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10149ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10149ui_story = var_68_0.localPosition

				local var_68_2 = GameObjectTools.GetOrAddComponent(var_68_0.gameObject, typeof(DynamicBoneHelper))

				if var_68_2 then
					var_68_2:EnableDynamicBone(false)
				end
			end

			local var_68_3 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_3 then
				local var_68_4 = (arg_65_1.time_ - var_68_1) / var_68_3
				local var_68_5 = Vector3.New(0, -1.05, -5.8)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10149ui_story, var_68_5, var_68_4)

				local var_68_6 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_6.x, var_68_6.y, var_68_6.z)

				local var_68_7 = var_68_0.localEulerAngles

				var_68_7.z = 0
				var_68_7.x = 0
				var_68_0.localEulerAngles = var_68_7
			end

			if arg_65_1.time_ >= var_68_1 + var_68_3 and arg_65_1.time_ < var_68_1 + var_68_3 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, -1.05, -5.8)

				local var_68_8 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_8.x, var_68_8.y, var_68_8.z)

				local var_68_9 = var_68_0.localEulerAngles

				var_68_9.z = 0
				var_68_9.x = 0
				var_68_0.localEulerAngles = var_68_9

				local var_68_10 = GameObjectTools.GetOrAddComponent(var_68_0.gameObject, typeof(DynamicBoneHelper))

				if var_68_10 then
					var_68_10:EnableDynamicBone(true)
				end
			end

			local var_68_11 = arg_65_1.actors_["10149ui_story"]
			local var_68_12 = 0

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 and not isNil(var_68_11) and arg_65_1.var_.characterEffect10149ui_story == nil then
				arg_65_1.var_.characterEffect10149ui_story = var_68_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_13 = 0.200000002980232

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_13 and not isNil(var_68_11) then
				local var_68_14 = (arg_65_1.time_ - var_68_12) / var_68_13

				if arg_65_1.var_.characterEffect10149ui_story and not isNil(var_68_11) then
					arg_65_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_12 + var_68_13 and arg_65_1.time_ < var_68_12 + var_68_13 + arg_68_0 and not isNil(var_68_11) and arg_65_1.var_.characterEffect10149ui_story then
				arg_65_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_68_15 = 0

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action1_1")
			end

			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_68_17 = 0

			if var_68_17 < arg_65_1.time_ and arg_65_1.time_ <= var_68_17 + arg_68_0 then
				local var_68_18 = arg_65_1.actors_["10149ui_story"]

				if not isNil(var_68_18) then
					local var_68_19 = GameObjectTools.GetOrAddComponent(var_68_18, typeof(DynamicBoneHelper))

					if var_68_19 then
						var_68_19:EnableDynamicBone(true)
					end
				end
			end

			local var_68_20 = 0
			local var_68_21 = 0.725

			if var_68_20 < arg_65_1.time_ and arg_65_1.time_ <= var_68_20 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_22 = arg_65_1:FormatText(StoryNameCfg[1371].name)

				arg_65_1.leftNameTxt_.text = var_68_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_23 = arg_65_1:GetWordFromCfg(322271016)
				local var_68_24 = arg_65_1:FormatText(var_68_23.content)

				arg_65_1.text_.text = var_68_24

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_25 = 29
				local var_68_26 = utf8.len(var_68_24)
				local var_68_27 = var_68_25 <= 0 and var_68_21 or var_68_21 * (var_68_26 / var_68_25)

				if var_68_27 > 0 and var_68_21 < var_68_27 then
					arg_65_1.talkMaxDuration = var_68_27

					if var_68_27 + var_68_20 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_27 + var_68_20
					end
				end

				arg_65_1.text_.text = var_68_24
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271016", "story_v_out_322271.awb") ~= 0 then
					local var_68_28 = manager.audio:GetVoiceLength("story_v_out_322271", "322271016", "story_v_out_322271.awb") / 1000

					if var_68_28 + var_68_20 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_28 + var_68_20
					end

					if var_68_23.prefab_name ~= "" and arg_65_1.actors_[var_68_23.prefab_name] ~= nil then
						local var_68_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_23.prefab_name].transform, "story_v_out_322271", "322271016", "story_v_out_322271.awb")

						arg_65_1:RecordAudio("322271016", var_68_29)
						arg_65_1:RecordAudio("322271016", var_68_29)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_322271", "322271016", "story_v_out_322271.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_322271", "322271016", "story_v_out_322271.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_30 = math.max(var_68_21, arg_65_1.talkMaxDuration)

			if var_68_20 <= arg_65_1.time_ and arg_65_1.time_ < var_68_20 + var_68_30 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_20) / var_68_30

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_20 + var_68_30 and arg_65_1.time_ < var_68_20 + var_68_30 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
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
	Play322271017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 322271017
		arg_69_1.duration_ = 12.93

		local var_69_0 = {
			zh = 7.3,
			ja = 12.933
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
				arg_69_0:Play322271018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.875

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[1371].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(322271017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271017", "story_v_out_322271.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271017", "story_v_out_322271.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_322271", "322271017", "story_v_out_322271.awb")

						arg_69_1:RecordAudio("322271017", var_72_9)
						arg_69_1:RecordAudio("322271017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_322271", "322271017", "story_v_out_322271.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_322271", "322271017", "story_v_out_322271.awb")
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
	Play322271018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 322271018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play322271019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10149ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10149ui_story == nil then
				arg_73_1.var_.characterEffect10149ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect10149ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10149ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10149ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10149ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 0.575

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[7].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_9 = arg_73_1:GetWordFromCfg(322271018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 23
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
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_14 and arg_73_1.time_ < var_76_6 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play322271019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 322271019
		arg_77_1.duration_ = 4.07

		local var_77_0 = {
			zh = 4.066,
			ja = 2.566
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
				arg_77_0:Play322271020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10149ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect10149ui_story == nil then
				arg_77_1.var_.characterEffect10149ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect10149ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect10149ui_story then
				arg_77_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_80_4 = 0

			if var_80_4 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action3_1")
			end

			local var_80_5 = 0
			local var_80_6 = 0.275

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_7 = arg_77_1:FormatText(StoryNameCfg[1371].name)

				arg_77_1.leftNameTxt_.text = var_80_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:GetWordFromCfg(322271019)
				local var_80_9 = arg_77_1:FormatText(var_80_8.content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271019", "story_v_out_322271.awb") ~= 0 then
					local var_80_13 = manager.audio:GetVoiceLength("story_v_out_322271", "322271019", "story_v_out_322271.awb") / 1000

					if var_80_13 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_5
					end

					if var_80_8.prefab_name ~= "" and arg_77_1.actors_[var_80_8.prefab_name] ~= nil then
						local var_80_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_8.prefab_name].transform, "story_v_out_322271", "322271019", "story_v_out_322271.awb")

						arg_77_1:RecordAudio("322271019", var_80_14)
						arg_77_1:RecordAudio("322271019", var_80_14)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_322271", "322271019", "story_v_out_322271.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_322271", "322271019", "story_v_out_322271.awb")
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
	Play322271020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 322271020
		arg_81_1.duration_ = 6.7

		local var_81_0 = {
			zh = 5,
			ja = 6.7
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
				arg_81_0:Play322271021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.575

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[1371].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(322271020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271020", "story_v_out_322271.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271020", "story_v_out_322271.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_322271", "322271020", "story_v_out_322271.awb")

						arg_81_1:RecordAudio("322271020", var_84_9)
						arg_81_1:RecordAudio("322271020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_322271", "322271020", "story_v_out_322271.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_322271", "322271020", "story_v_out_322271.awb")
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
	Play322271021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 322271021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play322271022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10149ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10149ui_story == nil then
				arg_85_1.var_.characterEffect10149ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect10149ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10149ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10149ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10149ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.325

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[7].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_9 = arg_85_1:GetWordFromCfg(322271021)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 13
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
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_14 and arg_85_1.time_ < var_88_6 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play322271022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 322271022
		arg_89_1.duration_ = 9.47

		local var_89_0 = {
			zh = 6.5,
			ja = 9.466
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
				arg_89_0:Play322271023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10149ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10149ui_story == nil then
				arg_89_1.var_.characterEffect10149ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect10149ui_story and not isNil(var_92_0) then
					arg_89_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10149ui_story then
				arg_89_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_92_4 = 0

			if var_92_4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action3_2")
			end

			local var_92_5 = 0

			if var_92_5 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_92_6 = 0

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				local var_92_7 = arg_89_1.actors_["10149ui_story"]

				if not isNil(var_92_7) then
					local var_92_8 = GameObjectTools.GetOrAddComponent(var_92_7, typeof(DynamicBoneHelper))

					if var_92_8 then
						var_92_8:EnableDynamicBone(true)
					end
				end
			end

			local var_92_9 = 0
			local var_92_10 = 0.475

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_11 = arg_89_1:FormatText(StoryNameCfg[1371].name)

				arg_89_1.leftNameTxt_.text = var_92_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_12 = arg_89_1:GetWordFromCfg(322271022)
				local var_92_13 = arg_89_1:FormatText(var_92_12.content)

				arg_89_1.text_.text = var_92_13

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_14 = 19
				local var_92_15 = utf8.len(var_92_13)
				local var_92_16 = var_92_14 <= 0 and var_92_10 or var_92_10 * (var_92_15 / var_92_14)

				if var_92_16 > 0 and var_92_10 < var_92_16 then
					arg_89_1.talkMaxDuration = var_92_16

					if var_92_16 + var_92_9 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_16 + var_92_9
					end
				end

				arg_89_1.text_.text = var_92_13
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271022", "story_v_out_322271.awb") ~= 0 then
					local var_92_17 = manager.audio:GetVoiceLength("story_v_out_322271", "322271022", "story_v_out_322271.awb") / 1000

					if var_92_17 + var_92_9 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_17 + var_92_9
					end

					if var_92_12.prefab_name ~= "" and arg_89_1.actors_[var_92_12.prefab_name] ~= nil then
						local var_92_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_12.prefab_name].transform, "story_v_out_322271", "322271022", "story_v_out_322271.awb")

						arg_89_1:RecordAudio("322271022", var_92_18)
						arg_89_1:RecordAudio("322271022", var_92_18)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_322271", "322271022", "story_v_out_322271.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_322271", "322271022", "story_v_out_322271.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_19 = math.max(var_92_10, arg_89_1.talkMaxDuration)

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_19 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_9) / var_92_19

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_9 + var_92_19 and arg_89_1.time_ < var_92_9 + var_92_19 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play322271023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 322271023
		arg_93_1.duration_ = 10.67

		local var_93_0 = {
			zh = 6.5,
			ja = 10.666
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
				arg_93_0:Play322271024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.725

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[1371].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(322271023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271023", "story_v_out_322271.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271023", "story_v_out_322271.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_322271", "322271023", "story_v_out_322271.awb")

						arg_93_1:RecordAudio("322271023", var_96_9)
						arg_93_1:RecordAudio("322271023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_322271", "322271023", "story_v_out_322271.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_322271", "322271023", "story_v_out_322271.awb")
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
	Play322271024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 322271024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play322271025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10149ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10149ui_story == nil then
				arg_97_1.var_.characterEffect10149ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect10149ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10149ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10149ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10149ui_story.fillRatio = var_100_5
			end

			local var_100_6 = 0
			local var_100_7 = 0.6

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_8 = arg_97_1:FormatText(StoryNameCfg[7].name)

				arg_97_1.leftNameTxt_.text = var_100_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_9 = arg_97_1:GetWordFromCfg(322271024)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 24
				local var_100_12 = utf8.len(var_100_10)
				local var_100_13 = var_100_11 <= 0 and var_100_7 or var_100_7 * (var_100_12 / var_100_11)

				if var_100_13 > 0 and var_100_7 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_14 and arg_97_1.time_ < var_100_6 + var_100_14 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play322271025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 322271025
		arg_101_1.duration_ = 2.2

		local var_101_0 = {
			zh = 1.366,
			ja = 2.2
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
				arg_101_0:Play322271026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10149ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10149ui_story == nil then
				arg_101_1.var_.characterEffect10149ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect10149ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10149ui_story then
				arg_101_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_104_4 = 0
			local var_104_5 = 0.125

			if var_104_4 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_6 = arg_101_1:FormatText(StoryNameCfg[1371].name)

				arg_101_1.leftNameTxt_.text = var_104_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_7 = arg_101_1:GetWordFromCfg(322271025)
				local var_104_8 = arg_101_1:FormatText(var_104_7.content)

				arg_101_1.text_.text = var_104_8

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 5
				local var_104_10 = utf8.len(var_104_8)
				local var_104_11 = var_104_9 <= 0 and var_104_5 or var_104_5 * (var_104_10 / var_104_9)

				if var_104_11 > 0 and var_104_5 < var_104_11 then
					arg_101_1.talkMaxDuration = var_104_11

					if var_104_11 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_8
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271025", "story_v_out_322271.awb") ~= 0 then
					local var_104_12 = manager.audio:GetVoiceLength("story_v_out_322271", "322271025", "story_v_out_322271.awb") / 1000

					if var_104_12 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_4
					end

					if var_104_7.prefab_name ~= "" and arg_101_1.actors_[var_104_7.prefab_name] ~= nil then
						local var_104_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_7.prefab_name].transform, "story_v_out_322271", "322271025", "story_v_out_322271.awb")

						arg_101_1:RecordAudio("322271025", var_104_13)
						arg_101_1:RecordAudio("322271025", var_104_13)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_322271", "322271025", "story_v_out_322271.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_322271", "322271025", "story_v_out_322271.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_14 and arg_101_1.time_ < var_104_4 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play322271026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 322271026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play322271027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10149ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect10149ui_story == nil then
				arg_105_1.var_.characterEffect10149ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect10149ui_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10149ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect10149ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10149ui_story.fillRatio = var_108_5
			end

			local var_108_6 = 0
			local var_108_7 = 0.4

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_8 = arg_105_1:FormatText(StoryNameCfg[7].name)

				arg_105_1.leftNameTxt_.text = var_108_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_9 = arg_105_1:GetWordFromCfg(322271026)
				local var_108_10 = arg_105_1:FormatText(var_108_9.content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 16
				local var_108_12 = utf8.len(var_108_10)
				local var_108_13 = var_108_11 <= 0 and var_108_7 or var_108_7 * (var_108_12 / var_108_11)

				if var_108_13 > 0 and var_108_7 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_14 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_14 and arg_105_1.time_ < var_108_6 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play322271027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 322271027
		arg_109_1.duration_ = 10.13

		local var_109_0 = {
			zh = 6.466,
			ja = 10.133
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
				arg_109_0:Play322271028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10149ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10149ui_story == nil then
				arg_109_1.var_.characterEffect10149ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect10149ui_story and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10149ui_story then
				arg_109_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_112_4 = 0

			if var_112_4 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action1_1")
			end

			local var_112_5 = 0

			if var_112_5 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_112_6 = 0

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				local var_112_7 = arg_109_1.actors_["10149ui_story"]

				if not isNil(var_112_7) then
					local var_112_8 = GameObjectTools.GetOrAddComponent(var_112_7, typeof(DynamicBoneHelper))

					if var_112_8 then
						var_112_8:EnableDynamicBone(true)
					end
				end
			end

			local var_112_9 = 0
			local var_112_10 = 0.6

			if var_112_9 < arg_109_1.time_ and arg_109_1.time_ <= var_112_9 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_11 = arg_109_1:FormatText(StoryNameCfg[1371].name)

				arg_109_1.leftNameTxt_.text = var_112_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_12 = arg_109_1:GetWordFromCfg(322271027)
				local var_112_13 = arg_109_1:FormatText(var_112_12.content)

				arg_109_1.text_.text = var_112_13

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_14 = 24
				local var_112_15 = utf8.len(var_112_13)
				local var_112_16 = var_112_14 <= 0 and var_112_10 or var_112_10 * (var_112_15 / var_112_14)

				if var_112_16 > 0 and var_112_10 < var_112_16 then
					arg_109_1.talkMaxDuration = var_112_16

					if var_112_16 + var_112_9 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_16 + var_112_9
					end
				end

				arg_109_1.text_.text = var_112_13
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271027", "story_v_out_322271.awb") ~= 0 then
					local var_112_17 = manager.audio:GetVoiceLength("story_v_out_322271", "322271027", "story_v_out_322271.awb") / 1000

					if var_112_17 + var_112_9 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_17 + var_112_9
					end

					if var_112_12.prefab_name ~= "" and arg_109_1.actors_[var_112_12.prefab_name] ~= nil then
						local var_112_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_12.prefab_name].transform, "story_v_out_322271", "322271027", "story_v_out_322271.awb")

						arg_109_1:RecordAudio("322271027", var_112_18)
						arg_109_1:RecordAudio("322271027", var_112_18)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_322271", "322271027", "story_v_out_322271.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_322271", "322271027", "story_v_out_322271.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_19 = math.max(var_112_10, arg_109_1.talkMaxDuration)

			if var_112_9 <= arg_109_1.time_ and arg_109_1.time_ < var_112_9 + var_112_19 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_9) / var_112_19

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_9 + var_112_19 and arg_109_1.time_ < var_112_9 + var_112_19 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play322271028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 322271028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play322271029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10149ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect10149ui_story == nil then
				arg_113_1.var_.characterEffect10149ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect10149ui_story and not isNil(var_116_0) then
					local var_116_4 = Mathf.Lerp(0, 0.5, var_116_3)

					arg_113_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10149ui_story.fillRatio = var_116_4
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect10149ui_story then
				local var_116_5 = 0.5

				arg_113_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10149ui_story.fillRatio = var_116_5
			end

			local var_116_6 = 0
			local var_116_7 = 1.325

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_8 = arg_113_1:FormatText(StoryNameCfg[7].name)

				arg_113_1.leftNameTxt_.text = var_116_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_9 = arg_113_1:GetWordFromCfg(322271028)
				local var_116_10 = arg_113_1:FormatText(var_116_9.content)

				arg_113_1.text_.text = var_116_10

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 53
				local var_116_12 = utf8.len(var_116_10)
				local var_116_13 = var_116_11 <= 0 and var_116_7 or var_116_7 * (var_116_12 / var_116_11)

				if var_116_13 > 0 and var_116_7 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_10
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_14 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_14 and arg_113_1.time_ < var_116_6 + var_116_14 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play322271029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 322271029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play322271030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.8

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[7].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_3 = arg_117_1:GetWordFromCfg(322271029)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 32
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
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_8 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_8 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_8

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_8 and arg_117_1.time_ < var_120_0 + var_120_8 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play322271030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 322271030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play322271031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10149ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect10149ui_story == nil then
				arg_121_1.var_.characterEffect10149ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect10149ui_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect10149ui_story then
				arg_121_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_124_4 = 0

			if var_124_4 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action9_1")
			end

			local var_124_5 = 0

			if var_124_5 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				local var_124_6 = arg_121_1.actors_["10149ui_story"]

				if not isNil(var_124_6) then
					local var_124_7 = GameObjectTools.GetOrAddComponent(var_124_6, typeof(DynamicBoneHelper))

					if var_124_7 then
						var_124_7:EnableDynamicBone(true)
					end
				end
			end

			local var_124_8 = 0
			local var_124_9 = 0.3

			if var_124_8 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_10 = arg_121_1:FormatText(StoryNameCfg[1371].name)

				arg_121_1.leftNameTxt_.text = var_124_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_11 = arg_121_1:GetWordFromCfg(322271030)
				local var_124_12 = arg_121_1:FormatText(var_124_11.content)

				arg_121_1.text_.text = var_124_12

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 12
				local var_124_14 = utf8.len(var_124_12)
				local var_124_15 = var_124_13 <= 0 and var_124_9 or var_124_9 * (var_124_14 / var_124_13)

				if var_124_15 > 0 and var_124_9 < var_124_15 then
					arg_121_1.talkMaxDuration = var_124_15

					if var_124_15 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_15 + var_124_8
					end
				end

				arg_121_1.text_.text = var_124_12
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271030", "story_v_out_322271.awb") ~= 0 then
					local var_124_16 = manager.audio:GetVoiceLength("story_v_out_322271", "322271030", "story_v_out_322271.awb") / 1000

					if var_124_16 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_16 + var_124_8
					end

					if var_124_11.prefab_name ~= "" and arg_121_1.actors_[var_124_11.prefab_name] ~= nil then
						local var_124_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_11.prefab_name].transform, "story_v_out_322271", "322271030", "story_v_out_322271.awb")

						arg_121_1:RecordAudio("322271030", var_124_17)
						arg_121_1:RecordAudio("322271030", var_124_17)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_322271", "322271030", "story_v_out_322271.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_322271", "322271030", "story_v_out_322271.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_18 = math.max(var_124_9, arg_121_1.talkMaxDuration)

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_18 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_8) / var_124_18

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_8 + var_124_18 and arg_121_1.time_ < var_124_8 + var_124_18 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play322271031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 322271031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play322271032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10149ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect10149ui_story == nil then
				arg_125_1.var_.characterEffect10149ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect10149ui_story and not isNil(var_128_0) then
					local var_128_4 = Mathf.Lerp(0, 0.5, var_128_3)

					arg_125_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10149ui_story.fillRatio = var_128_4
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect10149ui_story then
				local var_128_5 = 0.5

				arg_125_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10149ui_story.fillRatio = var_128_5
			end

			local var_128_6 = 0
			local var_128_7 = 1.05

			if var_128_6 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_8 = arg_125_1:FormatText(StoryNameCfg[7].name)

				arg_125_1.leftNameTxt_.text = var_128_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_9 = arg_125_1:GetWordFromCfg(322271031)
				local var_128_10 = arg_125_1:FormatText(var_128_9.content)

				arg_125_1.text_.text = var_128_10

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_11 = 42
				local var_128_12 = utf8.len(var_128_10)
				local var_128_13 = var_128_11 <= 0 and var_128_7 or var_128_7 * (var_128_12 / var_128_11)

				if var_128_13 > 0 and var_128_7 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_10
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_14 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_14 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_14

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_14 and arg_125_1.time_ < var_128_6 + var_128_14 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play322271032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 322271032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play322271033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 1.375

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[7].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(322271032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 55
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_8 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_8 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_8

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_8 and arg_129_1.time_ < var_132_0 + var_132_8 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play322271033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 322271033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play322271034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10149ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos10149ui_story = var_136_0.localPosition

				local var_136_2 = GameObjectTools.GetOrAddComponent(var_136_0.gameObject, typeof(DynamicBoneHelper))

				if var_136_2 then
					var_136_2:EnableDynamicBone(false)
				end
			end

			local var_136_3 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_3 then
				local var_136_4 = (arg_133_1.time_ - var_136_1) / var_136_3
				local var_136_5 = Vector3.New(0, 100, 0)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10149ui_story, var_136_5, var_136_4)

				local var_136_6 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_6.x, var_136_6.y, var_136_6.z)

				local var_136_7 = var_136_0.localEulerAngles

				var_136_7.z = 0
				var_136_7.x = 0
				var_136_0.localEulerAngles = var_136_7
			end

			if arg_133_1.time_ >= var_136_1 + var_136_3 and arg_133_1.time_ < var_136_1 + var_136_3 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0, 100, 0)

				local var_136_8 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_8.x, var_136_8.y, var_136_8.z)

				local var_136_9 = var_136_0.localEulerAngles

				var_136_9.z = 0
				var_136_9.x = 0
				var_136_0.localEulerAngles = var_136_9

				local var_136_10 = GameObjectTools.GetOrAddComponent(var_136_0.gameObject, typeof(DynamicBoneHelper))

				if var_136_10 then
					var_136_10:EnableDynamicBone(true)
				end
			end

			local var_136_11 = 0
			local var_136_12 = 1.1

			if var_136_11 < arg_133_1.time_ and arg_133_1.time_ <= var_136_11 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_13 = arg_133_1:GetWordFromCfg(322271033)
				local var_136_14 = arg_133_1:FormatText(var_136_13.content)

				arg_133_1.text_.text = var_136_14

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_15 = 44
				local var_136_16 = utf8.len(var_136_14)
				local var_136_17 = var_136_15 <= 0 and var_136_12 or var_136_12 * (var_136_16 / var_136_15)

				if var_136_17 > 0 and var_136_12 < var_136_17 then
					arg_133_1.talkMaxDuration = var_136_17

					if var_136_17 + var_136_11 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_17 + var_136_11
					end
				end

				arg_133_1.text_.text = var_136_14
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_18 = math.max(var_136_12, arg_133_1.talkMaxDuration)

			if var_136_11 <= arg_133_1.time_ and arg_133_1.time_ < var_136_11 + var_136_18 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_11) / var_136_18

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_11 + var_136_18 and arg_133_1.time_ < var_136_11 + var_136_18 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
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
	Play322271034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 322271034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play322271035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.625

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_2 = arg_137_1:GetWordFromCfg(322271034)
				local var_140_3 = arg_137_1:FormatText(var_140_2.content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 25
				local var_140_5 = utf8.len(var_140_3)
				local var_140_6 = var_140_4 <= 0 and var_140_1 or var_140_1 * (var_140_5 / var_140_4)

				if var_140_6 > 0 and var_140_1 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_7 and arg_137_1.time_ < var_140_0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play322271035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 322271035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play322271036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10149ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos10149ui_story = var_144_0.localPosition

				local var_144_2 = GameObjectTools.GetOrAddComponent(var_144_0.gameObject, typeof(DynamicBoneHelper))

				if var_144_2 then
					var_144_2:EnableDynamicBone(false)
				end
			end

			local var_144_3 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_3 then
				local var_144_4 = (arg_141_1.time_ - var_144_1) / var_144_3
				local var_144_5 = Vector3.New(0, -1.05, -5.8)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10149ui_story, var_144_5, var_144_4)

				local var_144_6 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_6.x, var_144_6.y, var_144_6.z)

				local var_144_7 = var_144_0.localEulerAngles

				var_144_7.z = 0
				var_144_7.x = 0
				var_144_0.localEulerAngles = var_144_7
			end

			if arg_141_1.time_ >= var_144_1 + var_144_3 and arg_141_1.time_ < var_144_1 + var_144_3 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, -1.05, -5.8)

				local var_144_8 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_8.x, var_144_8.y, var_144_8.z)

				local var_144_9 = var_144_0.localEulerAngles

				var_144_9.z = 0
				var_144_9.x = 0
				var_144_0.localEulerAngles = var_144_9

				local var_144_10 = GameObjectTools.GetOrAddComponent(var_144_0.gameObject, typeof(DynamicBoneHelper))

				if var_144_10 then
					var_144_10:EnableDynamicBone(true)
				end
			end

			local var_144_11 = arg_141_1.actors_["10149ui_story"]
			local var_144_12 = 0

			if var_144_12 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 and not isNil(var_144_11) and arg_141_1.var_.characterEffect10149ui_story == nil then
				arg_141_1.var_.characterEffect10149ui_story = var_144_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_13 = 0.200000002980232

			if var_144_12 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_13 and not isNil(var_144_11) then
				local var_144_14 = (arg_141_1.time_ - var_144_12) / var_144_13

				if arg_141_1.var_.characterEffect10149ui_story and not isNil(var_144_11) then
					arg_141_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_12 + var_144_13 and arg_141_1.time_ < var_144_12 + var_144_13 + arg_144_0 and not isNil(var_144_11) and arg_141_1.var_.characterEffect10149ui_story then
				arg_141_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_144_15 = 0

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action9_2")
			end

			local var_144_16 = 0

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 then
				arg_141_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_144_17 = 0

			if var_144_17 < arg_141_1.time_ and arg_141_1.time_ <= var_144_17 + arg_144_0 then
				local var_144_18 = arg_141_1.actors_["10149ui_story"]

				if not isNil(var_144_18) then
					local var_144_19 = GameObjectTools.GetOrAddComponent(var_144_18, typeof(DynamicBoneHelper))

					if var_144_19 then
						var_144_19:EnableDynamicBone(true)
					end
				end
			end

			local var_144_20 = 0
			local var_144_21 = 0.475

			if var_144_20 < arg_141_1.time_ and arg_141_1.time_ <= var_144_20 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_22 = arg_141_1:FormatText(StoryNameCfg[1371].name)

				arg_141_1.leftNameTxt_.text = var_144_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_23 = arg_141_1:GetWordFromCfg(322271035)
				local var_144_24 = arg_141_1:FormatText(var_144_23.content)

				arg_141_1.text_.text = var_144_24

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_25 = 19
				local var_144_26 = utf8.len(var_144_24)
				local var_144_27 = var_144_25 <= 0 and var_144_21 or var_144_21 * (var_144_26 / var_144_25)

				if var_144_27 > 0 and var_144_21 < var_144_27 then
					arg_141_1.talkMaxDuration = var_144_27

					if var_144_27 + var_144_20 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_27 + var_144_20
					end
				end

				arg_141_1.text_.text = var_144_24
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271035", "story_v_out_322271.awb") ~= 0 then
					local var_144_28 = manager.audio:GetVoiceLength("story_v_out_322271", "322271035", "story_v_out_322271.awb") / 1000

					if var_144_28 + var_144_20 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_28 + var_144_20
					end

					if var_144_23.prefab_name ~= "" and arg_141_1.actors_[var_144_23.prefab_name] ~= nil then
						local var_144_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_23.prefab_name].transform, "story_v_out_322271", "322271035", "story_v_out_322271.awb")

						arg_141_1:RecordAudio("322271035", var_144_29)
						arg_141_1:RecordAudio("322271035", var_144_29)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_322271", "322271035", "story_v_out_322271.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_322271", "322271035", "story_v_out_322271.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_30 = math.max(var_144_21, arg_141_1.talkMaxDuration)

			if var_144_20 <= arg_141_1.time_ and arg_141_1.time_ < var_144_20 + var_144_30 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_20) / var_144_30

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_20 + var_144_30 and arg_141_1.time_ < var_144_20 + var_144_30 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
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
	Play322271036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 322271036
		arg_145_1.duration_ = 12.87

		local var_145_0 = {
			zh = 9.666,
			ja = 12.866
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
				arg_145_0:Play322271037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 1.1

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[1371].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:GetWordFromCfg(322271036)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 44
				local var_148_6 = utf8.len(var_148_4)
				local var_148_7 = var_148_5 <= 0 and var_148_1 or var_148_1 * (var_148_6 / var_148_5)

				if var_148_7 > 0 and var_148_1 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271036", "story_v_out_322271.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271036", "story_v_out_322271.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_322271", "322271036", "story_v_out_322271.awb")

						arg_145_1:RecordAudio("322271036", var_148_9)
						arg_145_1:RecordAudio("322271036", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_322271", "322271036", "story_v_out_322271.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_322271", "322271036", "story_v_out_322271.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_10 and arg_145_1.time_ < var_148_0 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play322271037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 322271037
		arg_149_1.duration_ = 9.37

		local var_149_0 = {
			zh = 7.433,
			ja = 9.366
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
				arg_149_0:Play322271038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.95

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[1371].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:GetWordFromCfg(322271037)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271037", "story_v_out_322271.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271037", "story_v_out_322271.awb") / 1000

					if var_152_8 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_0
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_322271", "322271037", "story_v_out_322271.awb")

						arg_149_1:RecordAudio("322271037", var_152_9)
						arg_149_1:RecordAudio("322271037", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_322271", "322271037", "story_v_out_322271.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_322271", "322271037", "story_v_out_322271.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_10 and arg_149_1.time_ < var_152_0 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play322271038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 322271038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play322271039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10149ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect10149ui_story == nil then
				arg_153_1.var_.characterEffect10149ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect10149ui_story and not isNil(var_156_0) then
					local var_156_4 = Mathf.Lerp(0, 0.5, var_156_3)

					arg_153_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_153_1.var_.characterEffect10149ui_story.fillRatio = var_156_4
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect10149ui_story then
				local var_156_5 = 0.5

				arg_153_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_153_1.var_.characterEffect10149ui_story.fillRatio = var_156_5
			end

			local var_156_6 = 0
			local var_156_7 = 0.325

			if var_156_6 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_8 = arg_153_1:FormatText(StoryNameCfg[7].name)

				arg_153_1.leftNameTxt_.text = var_156_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_9 = arg_153_1:GetWordFromCfg(322271038)
				local var_156_10 = arg_153_1:FormatText(var_156_9.content)

				arg_153_1.text_.text = var_156_10

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_11 = 13
				local var_156_12 = utf8.len(var_156_10)
				local var_156_13 = var_156_11 <= 0 and var_156_7 or var_156_7 * (var_156_12 / var_156_11)

				if var_156_13 > 0 and var_156_7 < var_156_13 then
					arg_153_1.talkMaxDuration = var_156_13

					if var_156_13 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_10
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_14 = math.max(var_156_7, arg_153_1.talkMaxDuration)

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_14 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_6) / var_156_14

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_6 + var_156_14 and arg_153_1.time_ < var_156_6 + var_156_14 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play322271039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 322271039
		arg_157_1.duration_ = 6.2

		local var_157_0 = {
			zh = 6.2,
			ja = 5.233
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
				arg_157_0:Play322271040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10149ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect10149ui_story == nil then
				arg_157_1.var_.characterEffect10149ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect10149ui_story and not isNil(var_160_0) then
					arg_157_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect10149ui_story then
				arg_157_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_160_4 = 0
			local var_160_5 = 0.55

			if var_160_4 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_6 = arg_157_1:FormatText(StoryNameCfg[1371].name)

				arg_157_1.leftNameTxt_.text = var_160_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_7 = arg_157_1:GetWordFromCfg(322271039)
				local var_160_8 = arg_157_1:FormatText(var_160_7.content)

				arg_157_1.text_.text = var_160_8

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 22
				local var_160_10 = utf8.len(var_160_8)
				local var_160_11 = var_160_9 <= 0 and var_160_5 or var_160_5 * (var_160_10 / var_160_9)

				if var_160_11 > 0 and var_160_5 < var_160_11 then
					arg_157_1.talkMaxDuration = var_160_11

					if var_160_11 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_11 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_8
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271039", "story_v_out_322271.awb") ~= 0 then
					local var_160_12 = manager.audio:GetVoiceLength("story_v_out_322271", "322271039", "story_v_out_322271.awb") / 1000

					if var_160_12 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_12 + var_160_4
					end

					if var_160_7.prefab_name ~= "" and arg_157_1.actors_[var_160_7.prefab_name] ~= nil then
						local var_160_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_7.prefab_name].transform, "story_v_out_322271", "322271039", "story_v_out_322271.awb")

						arg_157_1:RecordAudio("322271039", var_160_13)
						arg_157_1:RecordAudio("322271039", var_160_13)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_322271", "322271039", "story_v_out_322271.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_322271", "322271039", "story_v_out_322271.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_14 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_14 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_14

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_14 and arg_157_1.time_ < var_160_4 + var_160_14 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play322271040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 322271040
		arg_161_1.duration_ = 12.93

		local var_161_0 = {
			zh = 7.966,
			ja = 12.933
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
				arg_161_0:Play322271041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 1.025

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[1371].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(322271040)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 41
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271040", "story_v_out_322271.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271040", "story_v_out_322271.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_322271", "322271040", "story_v_out_322271.awb")

						arg_161_1:RecordAudio("322271040", var_164_9)
						arg_161_1:RecordAudio("322271040", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_322271", "322271040", "story_v_out_322271.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_322271", "322271040", "story_v_out_322271.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_10 and arg_161_1.time_ < var_164_0 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play322271041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 322271041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play322271042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10149ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect10149ui_story == nil then
				arg_165_1.var_.characterEffect10149ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect10149ui_story and not isNil(var_168_0) then
					local var_168_4 = Mathf.Lerp(0, 0.5, var_168_3)

					arg_165_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10149ui_story.fillRatio = var_168_4
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect10149ui_story then
				local var_168_5 = 0.5

				arg_165_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10149ui_story.fillRatio = var_168_5
			end

			local var_168_6 = 0
			local var_168_7 = 0.35

			if var_168_6 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_8 = arg_165_1:FormatText(StoryNameCfg[7].name)

				arg_165_1.leftNameTxt_.text = var_168_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_9 = arg_165_1:GetWordFromCfg(322271041)
				local var_168_10 = arg_165_1:FormatText(var_168_9.content)

				arg_165_1.text_.text = var_168_10

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_11 = 14
				local var_168_12 = utf8.len(var_168_10)
				local var_168_13 = var_168_11 <= 0 and var_168_7 or var_168_7 * (var_168_12 / var_168_11)

				if var_168_13 > 0 and var_168_7 < var_168_13 then
					arg_165_1.talkMaxDuration = var_168_13

					if var_168_13 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_13 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_10
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_14 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_14 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_14

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_14 and arg_165_1.time_ < var_168_6 + var_168_14 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play322271042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 322271042
		arg_169_1.duration_ = 5.57

		local var_169_0 = {
			zh = 5.266,
			ja = 5.566
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
				arg_169_0:Play322271043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10149ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect10149ui_story == nil then
				arg_169_1.var_.characterEffect10149ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect10149ui_story and not isNil(var_172_0) then
					arg_169_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect10149ui_story then
				arg_169_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_172_4 = 0

			if var_172_4 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				local var_172_5 = arg_169_1.actors_["10149ui_story"]

				if not isNil(var_172_5) then
					local var_172_6 = GameObjectTools.GetOrAddComponent(var_172_5, typeof(DynamicBoneHelper))

					if var_172_6 then
						var_172_6:EnableDynamicBone(true)
					end
				end
			end

			local var_172_7 = 0

			if var_172_7 < arg_169_1.time_ and arg_169_1.time_ <= var_172_7 + arg_172_0 then
				arg_169_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action4_1")
			end

			local var_172_8 = 0
			local var_172_9 = 0.625

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_10 = arg_169_1:FormatText(StoryNameCfg[1371].name)

				arg_169_1.leftNameTxt_.text = var_172_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_11 = arg_169_1:GetWordFromCfg(322271042)
				local var_172_12 = arg_169_1:FormatText(var_172_11.content)

				arg_169_1.text_.text = var_172_12

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_13 = 25
				local var_172_14 = utf8.len(var_172_12)
				local var_172_15 = var_172_13 <= 0 and var_172_9 or var_172_9 * (var_172_14 / var_172_13)

				if var_172_15 > 0 and var_172_9 < var_172_15 then
					arg_169_1.talkMaxDuration = var_172_15

					if var_172_15 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_15 + var_172_8
					end
				end

				arg_169_1.text_.text = var_172_12
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271042", "story_v_out_322271.awb") ~= 0 then
					local var_172_16 = manager.audio:GetVoiceLength("story_v_out_322271", "322271042", "story_v_out_322271.awb") / 1000

					if var_172_16 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_16 + var_172_8
					end

					if var_172_11.prefab_name ~= "" and arg_169_1.actors_[var_172_11.prefab_name] ~= nil then
						local var_172_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_11.prefab_name].transform, "story_v_out_322271", "322271042", "story_v_out_322271.awb")

						arg_169_1:RecordAudio("322271042", var_172_17)
						arg_169_1:RecordAudio("322271042", var_172_17)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_322271", "322271042", "story_v_out_322271.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_322271", "322271042", "story_v_out_322271.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_18 = math.max(var_172_9, arg_169_1.talkMaxDuration)

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_18 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_8) / var_172_18

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_8 + var_172_18 and arg_169_1.time_ < var_172_8 + var_172_18 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play322271043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 322271043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play322271044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10149ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos10149ui_story = var_176_0.localPosition

				local var_176_2 = GameObjectTools.GetOrAddComponent(var_176_0.gameObject, typeof(DynamicBoneHelper))

				if var_176_2 then
					var_176_2:EnableDynamicBone(false)
				end
			end

			local var_176_3 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_3 then
				local var_176_4 = (arg_173_1.time_ - var_176_1) / var_176_3
				local var_176_5 = Vector3.New(0, 100, 0)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10149ui_story, var_176_5, var_176_4)

				local var_176_6 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_6.x, var_176_6.y, var_176_6.z)

				local var_176_7 = var_176_0.localEulerAngles

				var_176_7.z = 0
				var_176_7.x = 0
				var_176_0.localEulerAngles = var_176_7
			end

			if arg_173_1.time_ >= var_176_1 + var_176_3 and arg_173_1.time_ < var_176_1 + var_176_3 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0, 100, 0)

				local var_176_8 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_8.x, var_176_8.y, var_176_8.z)

				local var_176_9 = var_176_0.localEulerAngles

				var_176_9.z = 0
				var_176_9.x = 0
				var_176_0.localEulerAngles = var_176_9

				local var_176_10 = GameObjectTools.GetOrAddComponent(var_176_0.gameObject, typeof(DynamicBoneHelper))

				if var_176_10 then
					var_176_10:EnableDynamicBone(true)
				end
			end

			local var_176_11 = 0.55
			local var_176_12 = 1

			if var_176_11 < arg_173_1.time_ and arg_173_1.time_ <= var_176_11 + arg_176_0 then
				local var_176_13 = "play"
				local var_176_14 = "effect"

				arg_173_1:AudioAction(var_176_13, var_176_14, "se_story_145", "se_story_145_gear2", "")
			end

			local var_176_15 = 0
			local var_176_16 = 1.55

			if var_176_15 < arg_173_1.time_ and arg_173_1.time_ <= var_176_15 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_17 = arg_173_1:GetWordFromCfg(322271043)
				local var_176_18 = arg_173_1:FormatText(var_176_17.content)

				arg_173_1.text_.text = var_176_18

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_19 = 62
				local var_176_20 = utf8.len(var_176_18)
				local var_176_21 = var_176_19 <= 0 and var_176_16 or var_176_16 * (var_176_20 / var_176_19)

				if var_176_21 > 0 and var_176_16 < var_176_21 then
					arg_173_1.talkMaxDuration = var_176_21

					if var_176_21 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_21 + var_176_15
					end
				end

				arg_173_1.text_.text = var_176_18
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_22 = math.max(var_176_16, arg_173_1.talkMaxDuration)

			if var_176_15 <= arg_173_1.time_ and arg_173_1.time_ < var_176_15 + var_176_22 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_15) / var_176_22

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_15 + var_176_22 and arg_173_1.time_ < var_176_15 + var_176_22 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
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
	Play322271044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 322271044
		arg_177_1.duration_ = 11.57

		local var_177_0 = {
			zh = 5.733,
			ja = 11.566
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
				arg_177_0:Play322271045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10149ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos10149ui_story = var_180_0.localPosition

				local var_180_2 = GameObjectTools.GetOrAddComponent(var_180_0.gameObject, typeof(DynamicBoneHelper))

				if var_180_2 then
					var_180_2:EnableDynamicBone(false)
				end
			end

			local var_180_3 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_3 then
				local var_180_4 = (arg_177_1.time_ - var_180_1) / var_180_3
				local var_180_5 = Vector3.New(0, -1.05, -5.8)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10149ui_story, var_180_5, var_180_4)

				local var_180_6 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_6.x, var_180_6.y, var_180_6.z)

				local var_180_7 = var_180_0.localEulerAngles

				var_180_7.z = 0
				var_180_7.x = 0
				var_180_0.localEulerAngles = var_180_7
			end

			if arg_177_1.time_ >= var_180_1 + var_180_3 and arg_177_1.time_ < var_180_1 + var_180_3 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, -1.05, -5.8)

				local var_180_8 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_8.x, var_180_8.y, var_180_8.z)

				local var_180_9 = var_180_0.localEulerAngles

				var_180_9.z = 0
				var_180_9.x = 0
				var_180_0.localEulerAngles = var_180_9

				local var_180_10 = GameObjectTools.GetOrAddComponent(var_180_0.gameObject, typeof(DynamicBoneHelper))

				if var_180_10 then
					var_180_10:EnableDynamicBone(true)
				end
			end

			local var_180_11 = arg_177_1.actors_["10149ui_story"]
			local var_180_12 = 0

			if var_180_12 < arg_177_1.time_ and arg_177_1.time_ <= var_180_12 + arg_180_0 and not isNil(var_180_11) and arg_177_1.var_.characterEffect10149ui_story == nil then
				arg_177_1.var_.characterEffect10149ui_story = var_180_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_13 = 0.200000002980232

			if var_180_12 <= arg_177_1.time_ and arg_177_1.time_ < var_180_12 + var_180_13 and not isNil(var_180_11) then
				local var_180_14 = (arg_177_1.time_ - var_180_12) / var_180_13

				if arg_177_1.var_.characterEffect10149ui_story and not isNil(var_180_11) then
					arg_177_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_12 + var_180_13 and arg_177_1.time_ < var_180_12 + var_180_13 + arg_180_0 and not isNil(var_180_11) and arg_177_1.var_.characterEffect10149ui_story then
				arg_177_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_180_15 = 0

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 then
				arg_177_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action4_2")
			end

			local var_180_16 = 0

			if var_180_16 < arg_177_1.time_ and arg_177_1.time_ <= var_180_16 + arg_180_0 then
				arg_177_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_180_17 = 0

			if var_180_17 < arg_177_1.time_ and arg_177_1.time_ <= var_180_17 + arg_180_0 then
				local var_180_18 = arg_177_1.actors_["10149ui_story"]

				if not isNil(var_180_18) then
					local var_180_19 = GameObjectTools.GetOrAddComponent(var_180_18, typeof(DynamicBoneHelper))

					if var_180_19 then
						var_180_19:EnableDynamicBone(true)
					end
				end
			end

			local var_180_20 = 0
			local var_180_21 = 0.625

			if var_180_20 < arg_177_1.time_ and arg_177_1.time_ <= var_180_20 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_22 = arg_177_1:FormatText(StoryNameCfg[1371].name)

				arg_177_1.leftNameTxt_.text = var_180_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_23 = arg_177_1:GetWordFromCfg(322271044)
				local var_180_24 = arg_177_1:FormatText(var_180_23.content)

				arg_177_1.text_.text = var_180_24

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_25 = 25
				local var_180_26 = utf8.len(var_180_24)
				local var_180_27 = var_180_25 <= 0 and var_180_21 or var_180_21 * (var_180_26 / var_180_25)

				if var_180_27 > 0 and var_180_21 < var_180_27 then
					arg_177_1.talkMaxDuration = var_180_27

					if var_180_27 + var_180_20 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_27 + var_180_20
					end
				end

				arg_177_1.text_.text = var_180_24
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271044", "story_v_out_322271.awb") ~= 0 then
					local var_180_28 = manager.audio:GetVoiceLength("story_v_out_322271", "322271044", "story_v_out_322271.awb") / 1000

					if var_180_28 + var_180_20 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_28 + var_180_20
					end

					if var_180_23.prefab_name ~= "" and arg_177_1.actors_[var_180_23.prefab_name] ~= nil then
						local var_180_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_23.prefab_name].transform, "story_v_out_322271", "322271044", "story_v_out_322271.awb")

						arg_177_1:RecordAudio("322271044", var_180_29)
						arg_177_1:RecordAudio("322271044", var_180_29)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_322271", "322271044", "story_v_out_322271.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_322271", "322271044", "story_v_out_322271.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_30 = math.max(var_180_21, arg_177_1.talkMaxDuration)

			if var_180_20 <= arg_177_1.time_ and arg_177_1.time_ < var_180_20 + var_180_30 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_20) / var_180_30

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_20 + var_180_30 and arg_177_1.time_ < var_180_20 + var_180_30 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
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
	Play322271045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 322271045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play322271046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10149ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect10149ui_story == nil then
				arg_181_1.var_.characterEffect10149ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect10149ui_story and not isNil(var_184_0) then
					local var_184_4 = Mathf.Lerp(0, 0.5, var_184_3)

					arg_181_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10149ui_story.fillRatio = var_184_4
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect10149ui_story then
				local var_184_5 = 0.5

				arg_181_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10149ui_story.fillRatio = var_184_5
			end

			local var_184_6 = 0
			local var_184_7 = 0.275

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_8 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_9 = arg_181_1:GetWordFromCfg(322271045)
				local var_184_10 = arg_181_1:FormatText(var_184_9.content)

				arg_181_1.text_.text = var_184_10

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 11
				local var_184_12 = utf8.len(var_184_10)
				local var_184_13 = var_184_11 <= 0 and var_184_7 or var_184_7 * (var_184_12 / var_184_11)

				if var_184_13 > 0 and var_184_7 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_10
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play322271046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 322271046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play322271047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10149ui_story"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos10149ui_story = var_188_0.localPosition

				local var_188_2 = GameObjectTools.GetOrAddComponent(var_188_0.gameObject, typeof(DynamicBoneHelper))

				if var_188_2 then
					var_188_2:EnableDynamicBone(false)
				end
			end

			local var_188_3 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_3 then
				local var_188_4 = (arg_185_1.time_ - var_188_1) / var_188_3
				local var_188_5 = Vector3.New(0, 100, 0)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10149ui_story, var_188_5, var_188_4)

				local var_188_6 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_6.x, var_188_6.y, var_188_6.z)

				local var_188_7 = var_188_0.localEulerAngles

				var_188_7.z = 0
				var_188_7.x = 0
				var_188_0.localEulerAngles = var_188_7
			end

			if arg_185_1.time_ >= var_188_1 + var_188_3 and arg_185_1.time_ < var_188_1 + var_188_3 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(0, 100, 0)

				local var_188_8 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_8.x, var_188_8.y, var_188_8.z)

				local var_188_9 = var_188_0.localEulerAngles

				var_188_9.z = 0
				var_188_9.x = 0
				var_188_0.localEulerAngles = var_188_9

				local var_188_10 = GameObjectTools.GetOrAddComponent(var_188_0.gameObject, typeof(DynamicBoneHelper))

				if var_188_10 then
					var_188_10:EnableDynamicBone(true)
				end
			end

			local var_188_11 = 0
			local var_188_12 = 1.525

			if var_188_11 < arg_185_1.time_ and arg_185_1.time_ <= var_188_11 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_13 = arg_185_1:GetWordFromCfg(322271046)
				local var_188_14 = arg_185_1:FormatText(var_188_13.content)

				arg_185_1.text_.text = var_188_14

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_15 = 61
				local var_188_16 = utf8.len(var_188_14)
				local var_188_17 = var_188_15 <= 0 and var_188_12 or var_188_12 * (var_188_16 / var_188_15)

				if var_188_17 > 0 and var_188_12 < var_188_17 then
					arg_185_1.talkMaxDuration = var_188_17

					if var_188_17 + var_188_11 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_17 + var_188_11
					end
				end

				arg_185_1.text_.text = var_188_14
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_18 = math.max(var_188_12, arg_185_1.talkMaxDuration)

			if var_188_11 <= arg_185_1.time_ and arg_185_1.time_ < var_188_11 + var_188_18 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_11) / var_188_18

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_11 + var_188_18 and arg_185_1.time_ < var_188_11 + var_188_18 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
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
	Play322271047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 322271047
		arg_189_1.duration_ = 5

		local var_189_0 = {
			zh = 4.999999999999,
			ja = 5
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
				arg_189_0:Play322271048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10149ui_story"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos10149ui_story = var_192_0.localPosition

				local var_192_2 = GameObjectTools.GetOrAddComponent(var_192_0.gameObject, typeof(DynamicBoneHelper))

				if var_192_2 then
					var_192_2:EnableDynamicBone(false)
				end
			end

			local var_192_3 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_3 then
				local var_192_4 = (arg_189_1.time_ - var_192_1) / var_192_3
				local var_192_5 = Vector3.New(0, -1.05, -5.8)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10149ui_story, var_192_5, var_192_4)

				local var_192_6 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_6.x, var_192_6.y, var_192_6.z)

				local var_192_7 = var_192_0.localEulerAngles

				var_192_7.z = 0
				var_192_7.x = 0
				var_192_0.localEulerAngles = var_192_7
			end

			if arg_189_1.time_ >= var_192_1 + var_192_3 and arg_189_1.time_ < var_192_1 + var_192_3 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0, -1.05, -5.8)

				local var_192_8 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_8.x, var_192_8.y, var_192_8.z)

				local var_192_9 = var_192_0.localEulerAngles

				var_192_9.z = 0
				var_192_9.x = 0
				var_192_0.localEulerAngles = var_192_9

				local var_192_10 = GameObjectTools.GetOrAddComponent(var_192_0.gameObject, typeof(DynamicBoneHelper))

				if var_192_10 then
					var_192_10:EnableDynamicBone(true)
				end
			end

			local var_192_11 = arg_189_1.actors_["10149ui_story"]
			local var_192_12 = 0

			if var_192_12 < arg_189_1.time_ and arg_189_1.time_ <= var_192_12 + arg_192_0 and not isNil(var_192_11) and arg_189_1.var_.characterEffect10149ui_story == nil then
				arg_189_1.var_.characterEffect10149ui_story = var_192_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_13 = 0.200000002980232

			if var_192_12 <= arg_189_1.time_ and arg_189_1.time_ < var_192_12 + var_192_13 and not isNil(var_192_11) then
				local var_192_14 = (arg_189_1.time_ - var_192_12) / var_192_13

				if arg_189_1.var_.characterEffect10149ui_story and not isNil(var_192_11) then
					arg_189_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_12 + var_192_13 and arg_189_1.time_ < var_192_12 + var_192_13 + arg_192_0 and not isNil(var_192_11) and arg_189_1.var_.characterEffect10149ui_story then
				arg_189_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_192_15 = 0

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action1_1")
			end

			local var_192_16 = 0

			if var_192_16 < arg_189_1.time_ and arg_189_1.time_ <= var_192_16 + arg_192_0 then
				arg_189_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_192_17 = 0

			if var_192_17 < arg_189_1.time_ and arg_189_1.time_ <= var_192_17 + arg_192_0 then
				local var_192_18 = arg_189_1.actors_["10149ui_story"]

				if not isNil(var_192_18) then
					local var_192_19 = GameObjectTools.GetOrAddComponent(var_192_18, typeof(DynamicBoneHelper))

					if var_192_19 then
						var_192_19:EnableDynamicBone(true)
					end
				end
			end

			local var_192_20 = 0
			local var_192_21 = 0.375

			if var_192_20 < arg_189_1.time_ and arg_189_1.time_ <= var_192_20 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_22 = arg_189_1:FormatText(StoryNameCfg[1371].name)

				arg_189_1.leftNameTxt_.text = var_192_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_23 = arg_189_1:GetWordFromCfg(322271047)
				local var_192_24 = arg_189_1:FormatText(var_192_23.content)

				arg_189_1.text_.text = var_192_24

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_25 = 15
				local var_192_26 = utf8.len(var_192_24)
				local var_192_27 = var_192_25 <= 0 and var_192_21 or var_192_21 * (var_192_26 / var_192_25)

				if var_192_27 > 0 and var_192_21 < var_192_27 then
					arg_189_1.talkMaxDuration = var_192_27

					if var_192_27 + var_192_20 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_27 + var_192_20
					end
				end

				arg_189_1.text_.text = var_192_24
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271047", "story_v_out_322271.awb") ~= 0 then
					local var_192_28 = manager.audio:GetVoiceLength("story_v_out_322271", "322271047", "story_v_out_322271.awb") / 1000

					if var_192_28 + var_192_20 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_28 + var_192_20
					end

					if var_192_23.prefab_name ~= "" and arg_189_1.actors_[var_192_23.prefab_name] ~= nil then
						local var_192_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_23.prefab_name].transform, "story_v_out_322271", "322271047", "story_v_out_322271.awb")

						arg_189_1:RecordAudio("322271047", var_192_29)
						arg_189_1:RecordAudio("322271047", var_192_29)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_322271", "322271047", "story_v_out_322271.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_322271", "322271047", "story_v_out_322271.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_30 = math.max(var_192_21, arg_189_1.talkMaxDuration)

			if var_192_20 <= arg_189_1.time_ and arg_189_1.time_ < var_192_20 + var_192_30 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_20) / var_192_30

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_20 + var_192_30 and arg_189_1.time_ < var_192_20 + var_192_30 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
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
	Play322271048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 322271048
		arg_193_1.duration_ = 5.4

		local var_193_0 = {
			zh = 3.466,
			ja = 5.4
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
				arg_193_0:Play322271049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.275

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[1371].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:GetWordFromCfg(322271048)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 11
				local var_196_6 = utf8.len(var_196_4)
				local var_196_7 = var_196_5 <= 0 and var_196_1 or var_196_1 * (var_196_6 / var_196_5)

				if var_196_7 > 0 and var_196_1 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271048", "story_v_out_322271.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271048", "story_v_out_322271.awb") / 1000

					if var_196_8 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_0
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_322271", "322271048", "story_v_out_322271.awb")

						arg_193_1:RecordAudio("322271048", var_196_9)
						arg_193_1:RecordAudio("322271048", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_322271", "322271048", "story_v_out_322271.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_322271", "322271048", "story_v_out_322271.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_10 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_10 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_10

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_10 and arg_193_1.time_ < var_196_0 + var_196_10 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play322271049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 322271049
		arg_197_1.duration_ = 9

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play322271050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = "H02"

			if arg_197_1.bgs_[var_200_0] == nil then
				local var_200_1 = Object.Instantiate(arg_197_1.paintGo_)

				var_200_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_200_0)
				var_200_1.name = var_200_0
				var_200_1.transform.parent = arg_197_1.stage_.transform
				var_200_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.bgs_[var_200_0] = var_200_1
			end

			local var_200_2 = 2

			if var_200_2 < arg_197_1.time_ and arg_197_1.time_ <= var_200_2 + arg_200_0 then
				local var_200_3 = manager.ui.mainCamera.transform.localPosition
				local var_200_4 = Vector3.New(0, 0, 10) + Vector3.New(var_200_3.x, var_200_3.y, 0)
				local var_200_5 = arg_197_1.bgs_.H02

				var_200_5.transform.localPosition = var_200_4
				var_200_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_6 = var_200_5:GetComponent("SpriteRenderer")

				if var_200_6 and var_200_6.sprite then
					local var_200_7 = (var_200_5.transform.localPosition - var_200_3).z
					local var_200_8 = manager.ui.mainCameraCom_
					local var_200_9 = 2 * var_200_7 * Mathf.Tan(var_200_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_200_10 = var_200_9 * var_200_8.aspect
					local var_200_11 = var_200_6.sprite.bounds.size.x
					local var_200_12 = var_200_6.sprite.bounds.size.y
					local var_200_13 = var_200_10 / var_200_11
					local var_200_14 = var_200_9 / var_200_12
					local var_200_15 = var_200_14 < var_200_13 and var_200_13 or var_200_14

					var_200_5.transform.localScale = Vector3.New(var_200_15, var_200_15, 0)
				end

				for iter_200_0, iter_200_1 in pairs(arg_197_1.bgs_) do
					if iter_200_0 ~= "H02" then
						iter_200_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_200_16 = 4

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1.allBtn_.enabled = false
			end

			local var_200_17 = 1.06666666666667

			if arg_197_1.time_ >= var_200_16 + var_200_17 and arg_197_1.time_ < var_200_16 + var_200_17 + arg_200_0 then
				arg_197_1.allBtn_.enabled = true
			end

			local var_200_18 = 0

			if var_200_18 < arg_197_1.time_ and arg_197_1.time_ <= var_200_18 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_19 = 2

			if var_200_18 <= arg_197_1.time_ and arg_197_1.time_ < var_200_18 + var_200_19 then
				local var_200_20 = (arg_197_1.time_ - var_200_18) / var_200_19
				local var_200_21 = Color.New(0, 0, 0)

				var_200_21.a = Mathf.Lerp(0, 1, var_200_20)
				arg_197_1.mask_.color = var_200_21
			end

			if arg_197_1.time_ >= var_200_18 + var_200_19 and arg_197_1.time_ < var_200_18 + var_200_19 + arg_200_0 then
				local var_200_22 = Color.New(0, 0, 0)

				var_200_22.a = 1
				arg_197_1.mask_.color = var_200_22
			end

			local var_200_23 = 2

			if var_200_23 < arg_197_1.time_ and arg_197_1.time_ <= var_200_23 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_24 = 2

			if var_200_23 <= arg_197_1.time_ and arg_197_1.time_ < var_200_23 + var_200_24 then
				local var_200_25 = (arg_197_1.time_ - var_200_23) / var_200_24
				local var_200_26 = Color.New(0, 0, 0)

				var_200_26.a = Mathf.Lerp(1, 0, var_200_25)
				arg_197_1.mask_.color = var_200_26
			end

			if arg_197_1.time_ >= var_200_23 + var_200_24 and arg_197_1.time_ < var_200_23 + var_200_24 + arg_200_0 then
				local var_200_27 = Color.New(0, 0, 0)
				local var_200_28 = 0

				arg_197_1.mask_.enabled = false
				var_200_27.a = var_200_28
				arg_197_1.mask_.color = var_200_27
			end

			local var_200_29 = arg_197_1.actors_["10149ui_story"].transform
			local var_200_30 = 2

			if var_200_30 < arg_197_1.time_ and arg_197_1.time_ <= var_200_30 + arg_200_0 then
				arg_197_1.var_.moveOldPos10149ui_story = var_200_29.localPosition

				local var_200_31 = GameObjectTools.GetOrAddComponent(var_200_29.gameObject, typeof(DynamicBoneHelper))

				if var_200_31 then
					var_200_31:EnableDynamicBone(false)
				end
			end

			local var_200_32 = 0.001

			if var_200_30 <= arg_197_1.time_ and arg_197_1.time_ < var_200_30 + var_200_32 then
				local var_200_33 = (arg_197_1.time_ - var_200_30) / var_200_32
				local var_200_34 = Vector3.New(0, 100, 0)

				var_200_29.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10149ui_story, var_200_34, var_200_33)

				local var_200_35 = manager.ui.mainCamera.transform.position - var_200_29.position

				var_200_29.forward = Vector3.New(var_200_35.x, var_200_35.y, var_200_35.z)

				local var_200_36 = var_200_29.localEulerAngles

				var_200_36.z = 0
				var_200_36.x = 0
				var_200_29.localEulerAngles = var_200_36
			end

			if arg_197_1.time_ >= var_200_30 + var_200_32 and arg_197_1.time_ < var_200_30 + var_200_32 + arg_200_0 then
				var_200_29.localPosition = Vector3.New(0, 100, 0)

				local var_200_37 = manager.ui.mainCamera.transform.position - var_200_29.position

				var_200_29.forward = Vector3.New(var_200_37.x, var_200_37.y, var_200_37.z)

				local var_200_38 = var_200_29.localEulerAngles

				var_200_38.z = 0
				var_200_38.x = 0
				var_200_29.localEulerAngles = var_200_38

				local var_200_39 = GameObjectTools.GetOrAddComponent(var_200_29.gameObject, typeof(DynamicBoneHelper))

				if var_200_39 then
					var_200_39:EnableDynamicBone(true)
				end
			end

			local var_200_40 = 0
			local var_200_41 = 0.3

			if var_200_40 < arg_197_1.time_ and arg_197_1.time_ <= var_200_40 + arg_200_0 then
				local var_200_42 = "play"
				local var_200_43 = "music"

				arg_197_1:AudioAction(var_200_42, var_200_43, "ui_battle", "ui_battle_stopbgm", "")

				local var_200_44 = ""
				local var_200_45 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_200_45 ~= "" then
					if arg_197_1.bgmTxt_.text ~= var_200_45 and arg_197_1.bgmTxt_.text ~= "" then
						if arg_197_1.bgmTxt2_.text ~= "" then
							arg_197_1.bgmTxt_.text = arg_197_1.bgmTxt2_.text
						end

						arg_197_1.bgmTxt2_.text = var_200_45

						arg_197_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_197_1.bgmTxt_.text = var_200_45
						arg_197_1.bgmTxt2_.text = var_200_45
					end

					if arg_197_1.bgmTimer then
						arg_197_1.bgmTimer:Stop()

						arg_197_1.bgmTimer = nil
					end

					if arg_197_1.settingData.show_music_name == 1 then
						arg_197_1.musicController:SetSelectedState("show")
						arg_197_1.musicAnimator_:Play("open", 0, 0)

						if arg_197_1.settingData.music_time ~= 0 then
							arg_197_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_197_1.settingData.music_time), function()
								if arg_197_1 == nil or isNil(arg_197_1.bgmTxt_) then
									return
								end

								arg_197_1.musicController:SetSelectedState("hide")
								arg_197_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_200_46 = 0.500666666666667
			local var_200_47 = 1

			if var_200_46 < arg_197_1.time_ and arg_197_1.time_ <= var_200_46 + arg_200_0 then
				local var_200_48 = "play"
				local var_200_49 = "music"

				arg_197_1:AudioAction(var_200_48, var_200_49, "bgm_activity_4_5_story_ainsoph_first", "bgm_activity_4_5_story_ainsoph_first", "bgm_activity_4_5_story_ainsoph_first.awb")

				local var_200_50 = ""
				local var_200_51 = manager.audio:GetAudioName("bgm_activity_4_5_story_ainsoph_first", "bgm_activity_4_5_story_ainsoph_first")

				if var_200_51 ~= "" then
					if arg_197_1.bgmTxt_.text ~= var_200_51 and arg_197_1.bgmTxt_.text ~= "" then
						if arg_197_1.bgmTxt2_.text ~= "" then
							arg_197_1.bgmTxt_.text = arg_197_1.bgmTxt2_.text
						end

						arg_197_1.bgmTxt2_.text = var_200_51

						arg_197_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_197_1.bgmTxt_.text = var_200_51
						arg_197_1.bgmTxt2_.text = var_200_51
					end

					if arg_197_1.bgmTimer then
						arg_197_1.bgmTimer:Stop()

						arg_197_1.bgmTimer = nil
					end

					if arg_197_1.settingData.show_music_name == 1 then
						arg_197_1.musicController:SetSelectedState("show")
						arg_197_1.musicAnimator_:Play("open", 0, 0)

						if arg_197_1.settingData.music_time ~= 0 then
							arg_197_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_197_1.settingData.music_time), function()
								if arg_197_1 == nil or isNil(arg_197_1.bgmTxt_) then
									return
								end

								arg_197_1.musicController:SetSelectedState("hide")
								arg_197_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_200_52 = 1.63333333333333
			local var_200_53 = 1

			if var_200_52 < arg_197_1.time_ and arg_197_1.time_ <= var_200_52 + arg_200_0 then
				local var_200_54 = "play"
				local var_200_55 = "effect"

				arg_197_1:AudioAction(var_200_54, var_200_55, "se_story_133", "se_story_133_sea", "")
			end

			local var_200_56 = 0.1
			local var_200_57 = 1

			if var_200_56 < arg_197_1.time_ and arg_197_1.time_ <= var_200_56 + arg_200_0 then
				local var_200_58 = "stop"
				local var_200_59 = "effect"

				arg_197_1:AudioAction(var_200_58, var_200_59, "se_story_145", "se_story_145_amb_ST0512", "")
			end

			if arg_197_1.frameCnt_ <= 1 then
				arg_197_1.dialog_:SetActive(false)
			end

			local var_200_60 = 4
			local var_200_61 = 1.15

			if var_200_60 < arg_197_1.time_ and arg_197_1.time_ <= var_200_60 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				arg_197_1.dialog_:SetActive(true)

				arg_197_1.dialogCg_.alpha = 0

				local var_200_62 = LeanTween.value(arg_197_1.dialog_, 0, 1, 0.3)

				var_200_62:setOnUpdate(LuaHelper.FloatAction(function(arg_203_0)
					arg_197_1.dialogCg_.alpha = arg_203_0
				end))
				var_200_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_197_1.dialog_)
					var_200_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_197_1.duration_ = arg_197_1.duration_ + 0.3

				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_63 = arg_197_1:GetWordFromCfg(322271049)
				local var_200_64 = arg_197_1:FormatText(var_200_63.content)

				arg_197_1.text_.text = var_200_64

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_65 = 46
				local var_200_66 = utf8.len(var_200_64)
				local var_200_67 = var_200_65 <= 0 and var_200_61 or var_200_61 * (var_200_66 / var_200_65)

				if var_200_67 > 0 and var_200_61 < var_200_67 then
					arg_197_1.talkMaxDuration = var_200_67
					var_200_60 = var_200_60 + 0.3

					if var_200_67 + var_200_60 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_67 + var_200_60
					end
				end

				arg_197_1.text_.text = var_200_64
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_68 = var_200_60 + 0.3
			local var_200_69 = math.max(var_200_61, arg_197_1.talkMaxDuration)

			if var_200_68 <= arg_197_1.time_ and arg_197_1.time_ < var_200_68 + var_200_69 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_68) / var_200_69

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_68 + var_200_69 and arg_197_1.time_ < var_200_68 + var_200_69 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play322271050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 322271050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play322271051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.525

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[7].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_3 = arg_205_1:GetWordFromCfg(322271050)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 21
				local var_208_6 = utf8.len(var_208_4)
				local var_208_7 = var_208_5 <= 0 and var_208_1 or var_208_1 * (var_208_6 / var_208_5)

				if var_208_7 > 0 and var_208_1 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_8 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_8 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_8

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_8 and arg_205_1.time_ < var_208_0 + var_208_8 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play322271051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 322271051
		arg_209_1.duration_ = 2

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play322271052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = "1020ui_story"

			if arg_209_1.actors_[var_212_0] == nil then
				local var_212_1 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_212_1) then
					local var_212_2 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_209_1.stage_.transform)

					var_212_2.name = var_212_0
					var_212_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_209_1.actors_[var_212_0] = var_212_2

					local var_212_3 = var_212_2:GetComponentInChildren(typeof(CharacterEffect))

					var_212_3.enabled = true

					local var_212_4 = GameObjectTools.GetOrAddComponent(var_212_2, typeof(DynamicBoneHelper))

					if var_212_4 then
						var_212_4:EnableDynamicBone(false)
					end

					arg_209_1:ShowWeapon(var_212_3.transform, false)

					arg_209_1.var_[var_212_0 .. "Animator"] = var_212_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_209_1.var_[var_212_0 .. "Animator"].applyRootMotion = true
					arg_209_1.var_[var_212_0 .. "LipSync"] = var_212_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_212_5 = arg_209_1.actors_["1020ui_story"].transform
			local var_212_6 = 0

			if var_212_6 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.var_.moveOldPos1020ui_story = var_212_5.localPosition
			end

			local var_212_7 = 0.001

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_7 then
				local var_212_8 = (arg_209_1.time_ - var_212_6) / var_212_7
				local var_212_9 = Vector3.New(0, -0.85, -6.25)

				var_212_5.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1020ui_story, var_212_9, var_212_8)

				local var_212_10 = manager.ui.mainCamera.transform.position - var_212_5.position

				var_212_5.forward = Vector3.New(var_212_10.x, var_212_10.y, var_212_10.z)

				local var_212_11 = var_212_5.localEulerAngles

				var_212_11.z = 0
				var_212_11.x = 0
				var_212_5.localEulerAngles = var_212_11
			end

			if arg_209_1.time_ >= var_212_6 + var_212_7 and arg_209_1.time_ < var_212_6 + var_212_7 + arg_212_0 then
				var_212_5.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_212_12 = manager.ui.mainCamera.transform.position - var_212_5.position

				var_212_5.forward = Vector3.New(var_212_12.x, var_212_12.y, var_212_12.z)

				local var_212_13 = var_212_5.localEulerAngles

				var_212_13.z = 0
				var_212_13.x = 0
				var_212_5.localEulerAngles = var_212_13
			end

			local var_212_14 = arg_209_1.actors_["1020ui_story"]
			local var_212_15 = 0

			if var_212_15 < arg_209_1.time_ and arg_209_1.time_ <= var_212_15 + arg_212_0 and not isNil(var_212_14) and arg_209_1.var_.characterEffect1020ui_story == nil then
				arg_209_1.var_.characterEffect1020ui_story = var_212_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_16 = 0.200000002980232

			if var_212_15 <= arg_209_1.time_ and arg_209_1.time_ < var_212_15 + var_212_16 and not isNil(var_212_14) then
				local var_212_17 = (arg_209_1.time_ - var_212_15) / var_212_16

				if arg_209_1.var_.characterEffect1020ui_story and not isNil(var_212_14) then
					arg_209_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_15 + var_212_16 and arg_209_1.time_ < var_212_15 + var_212_16 + arg_212_0 and not isNil(var_212_14) and arg_209_1.var_.characterEffect1020ui_story then
				arg_209_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_212_18 = 0

			if var_212_18 < arg_209_1.time_ and arg_209_1.time_ <= var_212_18 + arg_212_0 then
				arg_209_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			local var_212_19 = 0

			if var_212_19 < arg_209_1.time_ and arg_209_1.time_ <= var_212_19 + arg_212_0 then
				arg_209_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_212_20 = 0
			local var_212_21 = 0.15

			if var_212_20 < arg_209_1.time_ and arg_209_1.time_ <= var_212_20 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_22 = arg_209_1:FormatText(StoryNameCfg[613].name)

				arg_209_1.leftNameTxt_.text = var_212_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_23 = arg_209_1:GetWordFromCfg(322271051)
				local var_212_24 = arg_209_1:FormatText(var_212_23.content)

				arg_209_1.text_.text = var_212_24

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_25 = 6
				local var_212_26 = utf8.len(var_212_24)
				local var_212_27 = var_212_25 <= 0 and var_212_21 or var_212_21 * (var_212_26 / var_212_25)

				if var_212_27 > 0 and var_212_21 < var_212_27 then
					arg_209_1.talkMaxDuration = var_212_27

					if var_212_27 + var_212_20 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_27 + var_212_20
					end
				end

				arg_209_1.text_.text = var_212_24
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271051", "story_v_out_322271.awb") ~= 0 then
					local var_212_28 = manager.audio:GetVoiceLength("story_v_out_322271", "322271051", "story_v_out_322271.awb") / 1000

					if var_212_28 + var_212_20 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_28 + var_212_20
					end

					if var_212_23.prefab_name ~= "" and arg_209_1.actors_[var_212_23.prefab_name] ~= nil then
						local var_212_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_23.prefab_name].transform, "story_v_out_322271", "322271051", "story_v_out_322271.awb")

						arg_209_1:RecordAudio("322271051", var_212_29)
						arg_209_1:RecordAudio("322271051", var_212_29)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_322271", "322271051", "story_v_out_322271.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_322271", "322271051", "story_v_out_322271.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_30 = math.max(var_212_21, arg_209_1.talkMaxDuration)

			if var_212_20 <= arg_209_1.time_ and arg_209_1.time_ < var_212_20 + var_212_30 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_20) / var_212_30

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_20 + var_212_30 and arg_209_1.time_ < var_212_20 + var_212_30 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play322271052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 322271052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play322271053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1020ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1020ui_story == nil then
				arg_213_1.var_.characterEffect1020ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect1020ui_story and not isNil(var_216_0) then
					local var_216_4 = Mathf.Lerp(0, 0.5, var_216_3)

					arg_213_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1020ui_story.fillRatio = var_216_4
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1020ui_story then
				local var_216_5 = 0.5

				arg_213_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1020ui_story.fillRatio = var_216_5
			end

			local var_216_6 = 0
			local var_216_7 = 0.05

			if var_216_6 < arg_213_1.time_ and arg_213_1.time_ <= var_216_6 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_8 = arg_213_1:FormatText(StoryNameCfg[7].name)

				arg_213_1.leftNameTxt_.text = var_216_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_9 = arg_213_1:GetWordFromCfg(322271052)
				local var_216_10 = arg_213_1:FormatText(var_216_9.content)

				arg_213_1.text_.text = var_216_10

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_11 = 2
				local var_216_12 = utf8.len(var_216_10)
				local var_216_13 = var_216_11 <= 0 and var_216_7 or var_216_7 * (var_216_12 / var_216_11)

				if var_216_13 > 0 and var_216_7 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_6
					end
				end

				arg_213_1.text_.text = var_216_10
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_14 = math.max(var_216_7, arg_213_1.talkMaxDuration)

			if var_216_6 <= arg_213_1.time_ and arg_213_1.time_ < var_216_6 + var_216_14 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_6) / var_216_14

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_6 + var_216_14 and arg_213_1.time_ < var_216_6 + var_216_14 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play322271053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 322271053
		arg_217_1.duration_ = 5.13

		local var_217_0 = {
			zh = 4.566,
			ja = 5.133
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
				arg_217_0:Play322271054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1020ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1020ui_story == nil then
				arg_217_1.var_.characterEffect1020ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect1020ui_story and not isNil(var_220_0) then
					arg_217_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1020ui_story then
				arg_217_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_220_4 = 0
			local var_220_5 = 0.45

			if var_220_4 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_6 = arg_217_1:FormatText(StoryNameCfg[613].name)

				arg_217_1.leftNameTxt_.text = var_220_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_7 = arg_217_1:GetWordFromCfg(322271053)
				local var_220_8 = arg_217_1:FormatText(var_220_7.content)

				arg_217_1.text_.text = var_220_8

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_9 = 18
				local var_220_10 = utf8.len(var_220_8)
				local var_220_11 = var_220_9 <= 0 and var_220_5 or var_220_5 * (var_220_10 / var_220_9)

				if var_220_11 > 0 and var_220_5 < var_220_11 then
					arg_217_1.talkMaxDuration = var_220_11

					if var_220_11 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_11 + var_220_4
					end
				end

				arg_217_1.text_.text = var_220_8
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271053", "story_v_out_322271.awb") ~= 0 then
					local var_220_12 = manager.audio:GetVoiceLength("story_v_out_322271", "322271053", "story_v_out_322271.awb") / 1000

					if var_220_12 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_12 + var_220_4
					end

					if var_220_7.prefab_name ~= "" and arg_217_1.actors_[var_220_7.prefab_name] ~= nil then
						local var_220_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_7.prefab_name].transform, "story_v_out_322271", "322271053", "story_v_out_322271.awb")

						arg_217_1:RecordAudio("322271053", var_220_13)
						arg_217_1:RecordAudio("322271053", var_220_13)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_322271", "322271053", "story_v_out_322271.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_322271", "322271053", "story_v_out_322271.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_14 = math.max(var_220_5, arg_217_1.talkMaxDuration)

			if var_220_4 <= arg_217_1.time_ and arg_217_1.time_ < var_220_4 + var_220_14 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_4) / var_220_14

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_4 + var_220_14 and arg_217_1.time_ < var_220_4 + var_220_14 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play322271054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 322271054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play322271055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1020ui_story"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1020ui_story == nil then
				arg_221_1.var_.characterEffect1020ui_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect1020ui_story and not isNil(var_224_0) then
					local var_224_4 = Mathf.Lerp(0, 0.5, var_224_3)

					arg_221_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1020ui_story.fillRatio = var_224_4
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1020ui_story then
				local var_224_5 = 0.5

				arg_221_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1020ui_story.fillRatio = var_224_5
			end

			local var_224_6 = 0
			local var_224_7 = 0.9

			if var_224_6 < arg_221_1.time_ and arg_221_1.time_ <= var_224_6 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_8 = arg_221_1:FormatText(StoryNameCfg[7].name)

				arg_221_1.leftNameTxt_.text = var_224_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_9 = arg_221_1:GetWordFromCfg(322271054)
				local var_224_10 = arg_221_1:FormatText(var_224_9.content)

				arg_221_1.text_.text = var_224_10

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_11 = 36
				local var_224_12 = utf8.len(var_224_10)
				local var_224_13 = var_224_11 <= 0 and var_224_7 or var_224_7 * (var_224_12 / var_224_11)

				if var_224_13 > 0 and var_224_7 < var_224_13 then
					arg_221_1.talkMaxDuration = var_224_13

					if var_224_13 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_6
					end
				end

				arg_221_1.text_.text = var_224_10
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_14 = math.max(var_224_7, arg_221_1.talkMaxDuration)

			if var_224_6 <= arg_221_1.time_ and arg_221_1.time_ < var_224_6 + var_224_14 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_6) / var_224_14

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_6 + var_224_14 and arg_221_1.time_ < var_224_6 + var_224_14 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play322271055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 322271055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play322271056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.575

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[7].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(322271055)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 23
				local var_228_6 = utf8.len(var_228_4)
				local var_228_7 = var_228_5 <= 0 and var_228_1 or var_228_1 * (var_228_6 / var_228_5)

				if var_228_7 > 0 and var_228_1 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_8 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_8 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_8

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_8 and arg_225_1.time_ < var_228_0 + var_228_8 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play322271056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 322271056
		arg_229_1.duration_ = 5.57

		local var_229_0 = {
			zh = 3.4,
			ja = 5.566
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
				arg_229_0:Play322271057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1020ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1020ui_story == nil then
				arg_229_1.var_.characterEffect1020ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect1020ui_story and not isNil(var_232_0) then
					arg_229_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1020ui_story then
				arg_229_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_232_4 = 0

			if var_232_4 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_232_5 = 0
			local var_232_6 = 0.375

			if var_232_5 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_7 = arg_229_1:FormatText(StoryNameCfg[613].name)

				arg_229_1.leftNameTxt_.text = var_232_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_8 = arg_229_1:GetWordFromCfg(322271056)
				local var_232_9 = arg_229_1:FormatText(var_232_8.content)

				arg_229_1.text_.text = var_232_9

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_10 = 15
				local var_232_11 = utf8.len(var_232_9)
				local var_232_12 = var_232_10 <= 0 and var_232_6 or var_232_6 * (var_232_11 / var_232_10)

				if var_232_12 > 0 and var_232_6 < var_232_12 then
					arg_229_1.talkMaxDuration = var_232_12

					if var_232_12 + var_232_5 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_12 + var_232_5
					end
				end

				arg_229_1.text_.text = var_232_9
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271056", "story_v_out_322271.awb") ~= 0 then
					local var_232_13 = manager.audio:GetVoiceLength("story_v_out_322271", "322271056", "story_v_out_322271.awb") / 1000

					if var_232_13 + var_232_5 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_13 + var_232_5
					end

					if var_232_8.prefab_name ~= "" and arg_229_1.actors_[var_232_8.prefab_name] ~= nil then
						local var_232_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_8.prefab_name].transform, "story_v_out_322271", "322271056", "story_v_out_322271.awb")

						arg_229_1:RecordAudio("322271056", var_232_14)
						arg_229_1:RecordAudio("322271056", var_232_14)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_322271", "322271056", "story_v_out_322271.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_322271", "322271056", "story_v_out_322271.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_15 = math.max(var_232_6, arg_229_1.talkMaxDuration)

			if var_232_5 <= arg_229_1.time_ and arg_229_1.time_ < var_232_5 + var_232_15 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_5) / var_232_15

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_5 + var_232_15 and arg_229_1.time_ < var_232_5 + var_232_15 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play322271057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 322271057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play322271058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1020ui_story"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1020ui_story == nil then
				arg_233_1.var_.characterEffect1020ui_story = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect1020ui_story and not isNil(var_236_0) then
					local var_236_4 = Mathf.Lerp(0, 0.5, var_236_3)

					arg_233_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1020ui_story.fillRatio = var_236_4
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1020ui_story then
				local var_236_5 = 0.5

				arg_233_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1020ui_story.fillRatio = var_236_5
			end

			local var_236_6 = 0
			local var_236_7 = 0.7

			if var_236_6 < arg_233_1.time_ and arg_233_1.time_ <= var_236_6 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_8 = arg_233_1:FormatText(StoryNameCfg[7].name)

				arg_233_1.leftNameTxt_.text = var_236_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_9 = arg_233_1:GetWordFromCfg(322271057)
				local var_236_10 = arg_233_1:FormatText(var_236_9.content)

				arg_233_1.text_.text = var_236_10

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_11 = 28
				local var_236_12 = utf8.len(var_236_10)
				local var_236_13 = var_236_11 <= 0 and var_236_7 or var_236_7 * (var_236_12 / var_236_11)

				if var_236_13 > 0 and var_236_7 < var_236_13 then
					arg_233_1.talkMaxDuration = var_236_13

					if var_236_13 + var_236_6 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_13 + var_236_6
					end
				end

				arg_233_1.text_.text = var_236_10
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_14 = math.max(var_236_7, arg_233_1.talkMaxDuration)

			if var_236_6 <= arg_233_1.time_ and arg_233_1.time_ < var_236_6 + var_236_14 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_6) / var_236_14

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_6 + var_236_14 and arg_233_1.time_ < var_236_6 + var_236_14 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play322271058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 322271058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play322271059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 0.65

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_2 = arg_237_1:FormatText(StoryNameCfg[7].name)

				arg_237_1.leftNameTxt_.text = var_240_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:GetWordFromCfg(322271058)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 26
				local var_240_6 = utf8.len(var_240_4)
				local var_240_7 = var_240_5 <= 0 and var_240_1 or var_240_1 * (var_240_6 / var_240_5)

				if var_240_7 > 0 and var_240_1 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_8 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_8 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_8

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_8 and arg_237_1.time_ < var_240_0 + var_240_8 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play322271059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 322271059
		arg_241_1.duration_ = 4.5

		local var_241_0 = {
			zh = 2.4,
			ja = 4.5
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
				arg_241_0:Play322271060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1020ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1020ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(0, -0.85, -6.25)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1020ui_story, var_244_4, var_244_3)

				local var_244_5 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_5.x, var_244_5.y, var_244_5.z)

				local var_244_6 = var_244_0.localEulerAngles

				var_244_6.z = 0
				var_244_6.x = 0
				var_244_0.localEulerAngles = var_244_6
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_244_7 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_7.x, var_244_7.y, var_244_7.z)

				local var_244_8 = var_244_0.localEulerAngles

				var_244_8.z = 0
				var_244_8.x = 0
				var_244_0.localEulerAngles = var_244_8
			end

			local var_244_9 = arg_241_1.actors_["1020ui_story"]
			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1020ui_story == nil then
				arg_241_1.var_.characterEffect1020ui_story = var_244_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_11 = 0.200000002980232

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_11 and not isNil(var_244_9) then
				local var_244_12 = (arg_241_1.time_ - var_244_10) / var_244_11

				if arg_241_1.var_.characterEffect1020ui_story and not isNil(var_244_9) then
					arg_241_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_10 + var_244_11 and arg_241_1.time_ < var_244_10 + var_244_11 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1020ui_story then
				arg_241_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_244_13 = 0

			if var_244_13 < arg_241_1.time_ and arg_241_1.time_ <= var_244_13 + arg_244_0 then
				arg_241_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_244_14 = 0

			if var_244_14 < arg_241_1.time_ and arg_241_1.time_ <= var_244_14 + arg_244_0 then
				arg_241_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_244_15 = 0
			local var_244_16 = 0.2

			if var_244_15 < arg_241_1.time_ and arg_241_1.time_ <= var_244_15 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_17 = arg_241_1:FormatText(StoryNameCfg[613].name)

				arg_241_1.leftNameTxt_.text = var_244_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_18 = arg_241_1:GetWordFromCfg(322271059)
				local var_244_19 = arg_241_1:FormatText(var_244_18.content)

				arg_241_1.text_.text = var_244_19

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_20 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271059", "story_v_out_322271.awb") ~= 0 then
					local var_244_23 = manager.audio:GetVoiceLength("story_v_out_322271", "322271059", "story_v_out_322271.awb") / 1000

					if var_244_23 + var_244_15 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_23 + var_244_15
					end

					if var_244_18.prefab_name ~= "" and arg_241_1.actors_[var_244_18.prefab_name] ~= nil then
						local var_244_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_18.prefab_name].transform, "story_v_out_322271", "322271059", "story_v_out_322271.awb")

						arg_241_1:RecordAudio("322271059", var_244_24)
						arg_241_1:RecordAudio("322271059", var_244_24)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_322271", "322271059", "story_v_out_322271.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_322271", "322271059", "story_v_out_322271.awb")
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
				actorName = "1020ui_story",
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
	Play322271060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 322271060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play322271061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1020ui_story"].transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.var_.moveOldPos1020ui_story = var_248_0.localPosition
			end

			local var_248_2 = 0.001

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2
				local var_248_4 = Vector3.New(0, 100, 0)

				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1020ui_story, var_248_4, var_248_3)

				local var_248_5 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_5.x, var_248_5.y, var_248_5.z)

				local var_248_6 = var_248_0.localEulerAngles

				var_248_6.z = 0
				var_248_6.x = 0
				var_248_0.localEulerAngles = var_248_6
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 then
				var_248_0.localPosition = Vector3.New(0, 100, 0)

				local var_248_7 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_7.x, var_248_7.y, var_248_7.z)

				local var_248_8 = var_248_0.localEulerAngles

				var_248_8.z = 0
				var_248_8.x = 0
				var_248_0.localEulerAngles = var_248_8
			end

			local var_248_9 = 0.6
			local var_248_10 = 1

			if var_248_9 < arg_245_1.time_ and arg_245_1.time_ <= var_248_9 + arg_248_0 then
				local var_248_11 = "play"
				local var_248_12 = "effect"

				arg_245_1:AudioAction(var_248_11, var_248_12, "se_story_145", "se_story_145_cloth_sand", "")
			end

			local var_248_13 = manager.ui.mainCamera.transform
			local var_248_14 = 0.6

			if var_248_14 < arg_245_1.time_ and arg_245_1.time_ <= var_248_14 + arg_248_0 then
				arg_245_1.var_.shakeOldPos = var_248_13.localPosition
			end

			local var_248_15 = 0.233333333333333

			if var_248_14 <= arg_245_1.time_ and arg_245_1.time_ < var_248_14 + var_248_15 then
				local var_248_16 = (arg_245_1.time_ - var_248_14) / 0.132
				local var_248_17, var_248_18 = math.modf(var_248_16)

				var_248_13.localPosition = Vector3.New(var_248_18 * 0.13, var_248_18 * 0.13, var_248_18 * 0.13) + arg_245_1.var_.shakeOldPos
			end

			if arg_245_1.time_ >= var_248_14 + var_248_15 and arg_245_1.time_ < var_248_14 + var_248_15 + arg_248_0 then
				var_248_13.localPosition = arg_245_1.var_.shakeOldPos
			end

			local var_248_19 = manager.ui.mainCamera.transform
			local var_248_20 = 0.933333333333333

			if var_248_20 < arg_245_1.time_ and arg_245_1.time_ <= var_248_20 + arg_248_0 then
				arg_245_1.var_.shakeOldPos = var_248_19.localPosition
			end

			local var_248_21 = 0.2

			if var_248_20 <= arg_245_1.time_ and arg_245_1.time_ < var_248_20 + var_248_21 then
				local var_248_22 = (arg_245_1.time_ - var_248_20) / 0.132
				local var_248_23, var_248_24 = math.modf(var_248_22)

				var_248_19.localPosition = Vector3.New(var_248_24 * 0.13, var_248_24 * 0.13, var_248_24 * 0.13) + arg_245_1.var_.shakeOldPos
			end

			if arg_245_1.time_ >= var_248_20 + var_248_21 and arg_245_1.time_ < var_248_20 + var_248_21 + arg_248_0 then
				var_248_19.localPosition = arg_245_1.var_.shakeOldPos
			end

			local var_248_25 = manager.ui.mainCamera.transform
			local var_248_26 = 1.23333333333333

			if var_248_26 < arg_245_1.time_ and arg_245_1.time_ <= var_248_26 + arg_248_0 then
				arg_245_1.var_.shakeOldPos = var_248_25.localPosition
			end

			local var_248_27 = 0.233333333333333

			if var_248_26 <= arg_245_1.time_ and arg_245_1.time_ < var_248_26 + var_248_27 then
				local var_248_28 = (arg_245_1.time_ - var_248_26) / 0.132
				local var_248_29, var_248_30 = math.modf(var_248_28)

				var_248_25.localPosition = Vector3.New(var_248_30 * 0.13, var_248_30 * 0.13, var_248_30 * 0.13) + arg_245_1.var_.shakeOldPos
			end

			if arg_245_1.time_ >= var_248_26 + var_248_27 and arg_245_1.time_ < var_248_26 + var_248_27 + arg_248_0 then
				var_248_25.localPosition = arg_245_1.var_.shakeOldPos
			end

			local var_248_31 = 0
			local var_248_32 = 1.075

			if var_248_31 < arg_245_1.time_ and arg_245_1.time_ <= var_248_31 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_33 = arg_245_1:GetWordFromCfg(322271060)
				local var_248_34 = arg_245_1:FormatText(var_248_33.content)

				arg_245_1.text_.text = var_248_34

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_35 = 43
				local var_248_36 = utf8.len(var_248_34)
				local var_248_37 = var_248_35 <= 0 and var_248_32 or var_248_32 * (var_248_36 / var_248_35)

				if var_248_37 > 0 and var_248_32 < var_248_37 then
					arg_245_1.talkMaxDuration = var_248_37

					if var_248_37 + var_248_31 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_37 + var_248_31
					end
				end

				arg_245_1.text_.text = var_248_34
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_38 = math.max(var_248_32, arg_245_1.talkMaxDuration)

			if var_248_31 <= arg_245_1.time_ and arg_245_1.time_ < var_248_31 + var_248_38 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_31) / var_248_38

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_31 + var_248_38 and arg_245_1.time_ < var_248_31 + var_248_38 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play322271061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 322271061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play322271062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.4

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_2 = arg_249_1:GetWordFromCfg(322271061)
				local var_252_3 = arg_249_1:FormatText(var_252_2.content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 16
				local var_252_5 = utf8.len(var_252_3)
				local var_252_6 = var_252_4 <= 0 and var_252_1 or var_252_1 * (var_252_5 / var_252_4)

				if var_252_6 > 0 and var_252_1 < var_252_6 then
					arg_249_1.talkMaxDuration = var_252_6

					if var_252_6 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_7 and arg_249_1.time_ < var_252_0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play322271062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 322271062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play322271063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.2

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[7].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:GetWordFromCfg(322271062)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 8
				local var_256_6 = utf8.len(var_256_4)
				local var_256_7 = var_256_5 <= 0 and var_256_1 or var_256_1 * (var_256_6 / var_256_5)

				if var_256_7 > 0 and var_256_1 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_8 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_8 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_8

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_8 and arg_253_1.time_ < var_256_0 + var_256_8 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play322271063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 322271063
		arg_257_1.duration_ = 4.97

		local var_257_0 = {
			zh = 2.8,
			ja = 4.966
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
				arg_257_0:Play322271064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1020ui_story"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos1020ui_story = var_260_0.localPosition
			end

			local var_260_2 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2
				local var_260_4 = Vector3.New(0, -0.85, -6.25)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1020ui_story, var_260_4, var_260_3)

				local var_260_5 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_5.x, var_260_5.y, var_260_5.z)

				local var_260_6 = var_260_0.localEulerAngles

				var_260_6.z = 0
				var_260_6.x = 0
				var_260_0.localEulerAngles = var_260_6
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_260_7 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_7.x, var_260_7.y, var_260_7.z)

				local var_260_8 = var_260_0.localEulerAngles

				var_260_8.z = 0
				var_260_8.x = 0
				var_260_0.localEulerAngles = var_260_8
			end

			local var_260_9 = arg_257_1.actors_["1020ui_story"]
			local var_260_10 = 0

			if var_260_10 < arg_257_1.time_ and arg_257_1.time_ <= var_260_10 + arg_260_0 and not isNil(var_260_9) and arg_257_1.var_.characterEffect1020ui_story == nil then
				arg_257_1.var_.characterEffect1020ui_story = var_260_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_11 = 0.200000002980232

			if var_260_10 <= arg_257_1.time_ and arg_257_1.time_ < var_260_10 + var_260_11 and not isNil(var_260_9) then
				local var_260_12 = (arg_257_1.time_ - var_260_10) / var_260_11

				if arg_257_1.var_.characterEffect1020ui_story and not isNil(var_260_9) then
					arg_257_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_10 + var_260_11 and arg_257_1.time_ < var_260_10 + var_260_11 + arg_260_0 and not isNil(var_260_9) and arg_257_1.var_.characterEffect1020ui_story then
				arg_257_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_260_13 = 0

			if var_260_13 < arg_257_1.time_ and arg_257_1.time_ <= var_260_13 + arg_260_0 then
				arg_257_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			local var_260_14 = 0

			if var_260_14 < arg_257_1.time_ and arg_257_1.time_ <= var_260_14 + arg_260_0 then
				arg_257_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_260_15 = 0
			local var_260_16 = 0.35

			if var_260_15 < arg_257_1.time_ and arg_257_1.time_ <= var_260_15 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_17 = arg_257_1:FormatText(StoryNameCfg[613].name)

				arg_257_1.leftNameTxt_.text = var_260_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_18 = arg_257_1:GetWordFromCfg(322271063)
				local var_260_19 = arg_257_1:FormatText(var_260_18.content)

				arg_257_1.text_.text = var_260_19

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_20 = 14
				local var_260_21 = utf8.len(var_260_19)
				local var_260_22 = var_260_20 <= 0 and var_260_16 or var_260_16 * (var_260_21 / var_260_20)

				if var_260_22 > 0 and var_260_16 < var_260_22 then
					arg_257_1.talkMaxDuration = var_260_22

					if var_260_22 + var_260_15 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_22 + var_260_15
					end
				end

				arg_257_1.text_.text = var_260_19
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271063", "story_v_out_322271.awb") ~= 0 then
					local var_260_23 = manager.audio:GetVoiceLength("story_v_out_322271", "322271063", "story_v_out_322271.awb") / 1000

					if var_260_23 + var_260_15 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_23 + var_260_15
					end

					if var_260_18.prefab_name ~= "" and arg_257_1.actors_[var_260_18.prefab_name] ~= nil then
						local var_260_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_18.prefab_name].transform, "story_v_out_322271", "322271063", "story_v_out_322271.awb")

						arg_257_1:RecordAudio("322271063", var_260_24)
						arg_257_1:RecordAudio("322271063", var_260_24)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_322271", "322271063", "story_v_out_322271.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_322271", "322271063", "story_v_out_322271.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_25 = math.max(var_260_16, arg_257_1.talkMaxDuration)

			if var_260_15 <= arg_257_1.time_ and arg_257_1.time_ < var_260_15 + var_260_25 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_15) / var_260_25

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_15 + var_260_25 and arg_257_1.time_ < var_260_15 + var_260_25 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play322271064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 322271064
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play322271065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1020ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1020ui_story == nil then
				arg_261_1.var_.characterEffect1020ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect1020ui_story and not isNil(var_264_0) then
					local var_264_4 = Mathf.Lerp(0, 0.5, var_264_3)

					arg_261_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1020ui_story.fillRatio = var_264_4
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1020ui_story then
				local var_264_5 = 0.5

				arg_261_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1020ui_story.fillRatio = var_264_5
			end

			local var_264_6 = 0
			local var_264_7 = 0.525

			if var_264_6 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_8 = arg_261_1:GetWordFromCfg(322271064)
				local var_264_9 = arg_261_1:FormatText(var_264_8.content)

				arg_261_1.text_.text = var_264_9

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_10 = 21
				local var_264_11 = utf8.len(var_264_9)
				local var_264_12 = var_264_10 <= 0 and var_264_7 or var_264_7 * (var_264_11 / var_264_10)

				if var_264_12 > 0 and var_264_7 < var_264_12 then
					arg_261_1.talkMaxDuration = var_264_12

					if var_264_12 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_12 + var_264_6
					end
				end

				arg_261_1.text_.text = var_264_9
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_13 = math.max(var_264_7, arg_261_1.talkMaxDuration)

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_13 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_6) / var_264_13

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_6 + var_264_13 and arg_261_1.time_ < var_264_6 + var_264_13 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play322271065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 322271065
		arg_265_1.duration_ = 11.23

		local var_265_0 = {
			zh = 7.5,
			ja = 11.233
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
				arg_265_0:Play322271066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1020ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1020ui_story == nil then
				arg_265_1.var_.characterEffect1020ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect1020ui_story and not isNil(var_268_0) then
					arg_265_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1020ui_story then
				arg_265_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_268_4 = 0

			if var_268_4 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			local var_268_5 = 0

			if var_268_5 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_268_6 = 0
			local var_268_7 = 0.925

			if var_268_6 < arg_265_1.time_ and arg_265_1.time_ <= var_268_6 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_8 = arg_265_1:FormatText(StoryNameCfg[613].name)

				arg_265_1.leftNameTxt_.text = var_268_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_9 = arg_265_1:GetWordFromCfg(322271065)
				local var_268_10 = arg_265_1:FormatText(var_268_9.content)

				arg_265_1.text_.text = var_268_10

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_11 = 37
				local var_268_12 = utf8.len(var_268_10)
				local var_268_13 = var_268_11 <= 0 and var_268_7 or var_268_7 * (var_268_12 / var_268_11)

				if var_268_13 > 0 and var_268_7 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13

					if var_268_13 + var_268_6 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_6
					end
				end

				arg_265_1.text_.text = var_268_10
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271065", "story_v_out_322271.awb") ~= 0 then
					local var_268_14 = manager.audio:GetVoiceLength("story_v_out_322271", "322271065", "story_v_out_322271.awb") / 1000

					if var_268_14 + var_268_6 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_14 + var_268_6
					end

					if var_268_9.prefab_name ~= "" and arg_265_1.actors_[var_268_9.prefab_name] ~= nil then
						local var_268_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_9.prefab_name].transform, "story_v_out_322271", "322271065", "story_v_out_322271.awb")

						arg_265_1:RecordAudio("322271065", var_268_15)
						arg_265_1:RecordAudio("322271065", var_268_15)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_322271", "322271065", "story_v_out_322271.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_322271", "322271065", "story_v_out_322271.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_16 = math.max(var_268_7, arg_265_1.talkMaxDuration)

			if var_268_6 <= arg_265_1.time_ and arg_265_1.time_ < var_268_6 + var_268_16 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_6) / var_268_16

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_6 + var_268_16 and arg_265_1.time_ < var_268_6 + var_268_16 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play322271066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 322271066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play322271067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1020ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1020ui_story == nil then
				arg_269_1.var_.characterEffect1020ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect1020ui_story and not isNil(var_272_0) then
					local var_272_4 = Mathf.Lerp(0, 0.5, var_272_3)

					arg_269_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1020ui_story.fillRatio = var_272_4
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1020ui_story then
				local var_272_5 = 0.5

				arg_269_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1020ui_story.fillRatio = var_272_5
			end

			local var_272_6 = 0
			local var_272_7 = 0.95

			if var_272_6 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_8 = arg_269_1:FormatText(StoryNameCfg[7].name)

				arg_269_1.leftNameTxt_.text = var_272_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_9 = arg_269_1:GetWordFromCfg(322271066)
				local var_272_10 = arg_269_1:FormatText(var_272_9.content)

				arg_269_1.text_.text = var_272_10

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_11 = 38
				local var_272_12 = utf8.len(var_272_10)
				local var_272_13 = var_272_11 <= 0 and var_272_7 or var_272_7 * (var_272_12 / var_272_11)

				if var_272_13 > 0 and var_272_7 < var_272_13 then
					arg_269_1.talkMaxDuration = var_272_13

					if var_272_13 + var_272_6 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_13 + var_272_6
					end
				end

				arg_269_1.text_.text = var_272_10
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_14 = math.max(var_272_7, arg_269_1.talkMaxDuration)

			if var_272_6 <= arg_269_1.time_ and arg_269_1.time_ < var_272_6 + var_272_14 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_6) / var_272_14

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_6 + var_272_14 and arg_269_1.time_ < var_272_6 + var_272_14 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play322271067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 322271067
		arg_273_1.duration_ = 4.37

		local var_273_0 = {
			zh = 2.933,
			ja = 4.366
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
				arg_273_0:Play322271068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1020ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1020ui_story == nil then
				arg_273_1.var_.characterEffect1020ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect1020ui_story and not isNil(var_276_0) then
					arg_273_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1020ui_story then
				arg_273_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_276_4 = 0

			if var_276_4 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_2")
			end

			local var_276_5 = 0

			if var_276_5 < arg_273_1.time_ and arg_273_1.time_ <= var_276_5 + arg_276_0 then
				arg_273_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_276_6 = 0
			local var_276_7 = 0.35

			if var_276_6 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_8 = arg_273_1:FormatText(StoryNameCfg[613].name)

				arg_273_1.leftNameTxt_.text = var_276_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_9 = arg_273_1:GetWordFromCfg(322271067)
				local var_276_10 = arg_273_1:FormatText(var_276_9.content)

				arg_273_1.text_.text = var_276_10

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 14
				local var_276_12 = utf8.len(var_276_10)
				local var_276_13 = var_276_11 <= 0 and var_276_7 or var_276_7 * (var_276_12 / var_276_11)

				if var_276_13 > 0 and var_276_7 < var_276_13 then
					arg_273_1.talkMaxDuration = var_276_13

					if var_276_13 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_13 + var_276_6
					end
				end

				arg_273_1.text_.text = var_276_10
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271067", "story_v_out_322271.awb") ~= 0 then
					local var_276_14 = manager.audio:GetVoiceLength("story_v_out_322271", "322271067", "story_v_out_322271.awb") / 1000

					if var_276_14 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_14 + var_276_6
					end

					if var_276_9.prefab_name ~= "" and arg_273_1.actors_[var_276_9.prefab_name] ~= nil then
						local var_276_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_9.prefab_name].transform, "story_v_out_322271", "322271067", "story_v_out_322271.awb")

						arg_273_1:RecordAudio("322271067", var_276_15)
						arg_273_1:RecordAudio("322271067", var_276_15)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_322271", "322271067", "story_v_out_322271.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_322271", "322271067", "story_v_out_322271.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_16 = math.max(var_276_7, arg_273_1.talkMaxDuration)

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_16 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_6) / var_276_16

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_6 + var_276_16 and arg_273_1.time_ < var_276_6 + var_276_16 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play322271068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 322271068
		arg_277_1.duration_ = 5.53

		local var_277_0 = {
			zh = 1.733,
			ja = 5.533
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
				arg_277_0:Play322271069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.225

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[613].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_3 = arg_277_1:GetWordFromCfg(322271068)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 9
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271068", "story_v_out_322271.awb") ~= 0 then
					local var_280_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271068", "story_v_out_322271.awb") / 1000

					if var_280_8 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_0
					end

					if var_280_3.prefab_name ~= "" and arg_277_1.actors_[var_280_3.prefab_name] ~= nil then
						local var_280_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_3.prefab_name].transform, "story_v_out_322271", "322271068", "story_v_out_322271.awb")

						arg_277_1:RecordAudio("322271068", var_280_9)
						arg_277_1:RecordAudio("322271068", var_280_9)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322271", "322271068", "story_v_out_322271.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322271", "322271068", "story_v_out_322271.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_10 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_10 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_10

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_10 and arg_277_1.time_ < var_280_0 + var_280_10 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play322271069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 322271069
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play322271070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1020ui_story"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1020ui_story == nil then
				arg_281_1.var_.characterEffect1020ui_story = var_284_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.characterEffect1020ui_story and not isNil(var_284_0) then
					local var_284_4 = Mathf.Lerp(0, 0.5, var_284_3)

					arg_281_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1020ui_story.fillRatio = var_284_4
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1020ui_story then
				local var_284_5 = 0.5

				arg_281_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1020ui_story.fillRatio = var_284_5
			end

			local var_284_6 = 0
			local var_284_7 = 0.675

			if var_284_6 < arg_281_1.time_ and arg_281_1.time_ <= var_284_6 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_8 = arg_281_1:FormatText(StoryNameCfg[7].name)

				arg_281_1.leftNameTxt_.text = var_284_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_9 = arg_281_1:GetWordFromCfg(322271069)
				local var_284_10 = arg_281_1:FormatText(var_284_9.content)

				arg_281_1.text_.text = var_284_10

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_11 = 27
				local var_284_12 = utf8.len(var_284_10)
				local var_284_13 = var_284_11 <= 0 and var_284_7 or var_284_7 * (var_284_12 / var_284_11)

				if var_284_13 > 0 and var_284_7 < var_284_13 then
					arg_281_1.talkMaxDuration = var_284_13

					if var_284_13 + var_284_6 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_13 + var_284_6
					end
				end

				arg_281_1.text_.text = var_284_10
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_14 = math.max(var_284_7, arg_281_1.talkMaxDuration)

			if var_284_6 <= arg_281_1.time_ and arg_281_1.time_ < var_284_6 + var_284_14 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_6) / var_284_14

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_6 + var_284_14 and arg_281_1.time_ < var_284_6 + var_284_14 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play322271070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 322271070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play322271071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 1.2

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_2 = arg_285_1:FormatText(StoryNameCfg[7].name)

				arg_285_1.leftNameTxt_.text = var_288_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_3 = arg_285_1:GetWordFromCfg(322271070)
				local var_288_4 = arg_285_1:FormatText(var_288_3.content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 48
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
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_8 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_8 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_8

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_8 and arg_285_1.time_ < var_288_0 + var_288_8 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play322271071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 322271071
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play322271072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 1.05

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_2 = arg_289_1:FormatText(StoryNameCfg[7].name)

				arg_289_1.leftNameTxt_.text = var_292_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_3 = arg_289_1:GetWordFromCfg(322271071)
				local var_292_4 = arg_289_1:FormatText(var_292_3.content)

				arg_289_1.text_.text = var_292_4

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 42
				local var_292_6 = utf8.len(var_292_4)
				local var_292_7 = var_292_5 <= 0 and var_292_1 or var_292_1 * (var_292_6 / var_292_5)

				if var_292_7 > 0 and var_292_1 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_4
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_8 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_8 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_8

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_8 and arg_289_1.time_ < var_292_0 + var_292_8 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play322271072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 322271072
		arg_293_1.duration_ = 16.5

		local var_293_0 = {
			zh = 9.466,
			ja = 16.5
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
				arg_293_0:Play322271073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1020ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1020ui_story == nil then
				arg_293_1.var_.characterEffect1020ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect1020ui_story and not isNil(var_296_0) then
					arg_293_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1020ui_story then
				arg_293_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_296_4 = 0

			if var_296_4 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			local var_296_5 = 0
			local var_296_6 = 1.125

			if var_296_5 < arg_293_1.time_ and arg_293_1.time_ <= var_296_5 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_7 = arg_293_1:FormatText(StoryNameCfg[613].name)

				arg_293_1.leftNameTxt_.text = var_296_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_8 = arg_293_1:GetWordFromCfg(322271072)
				local var_296_9 = arg_293_1:FormatText(var_296_8.content)

				arg_293_1.text_.text = var_296_9

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_10 = 45
				local var_296_11 = utf8.len(var_296_9)
				local var_296_12 = var_296_10 <= 0 and var_296_6 or var_296_6 * (var_296_11 / var_296_10)

				if var_296_12 > 0 and var_296_6 < var_296_12 then
					arg_293_1.talkMaxDuration = var_296_12

					if var_296_12 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_12 + var_296_5
					end
				end

				arg_293_1.text_.text = var_296_9
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271072", "story_v_out_322271.awb") ~= 0 then
					local var_296_13 = manager.audio:GetVoiceLength("story_v_out_322271", "322271072", "story_v_out_322271.awb") / 1000

					if var_296_13 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_13 + var_296_5
					end

					if var_296_8.prefab_name ~= "" and arg_293_1.actors_[var_296_8.prefab_name] ~= nil then
						local var_296_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_8.prefab_name].transform, "story_v_out_322271", "322271072", "story_v_out_322271.awb")

						arg_293_1:RecordAudio("322271072", var_296_14)
						arg_293_1:RecordAudio("322271072", var_296_14)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_322271", "322271072", "story_v_out_322271.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_322271", "322271072", "story_v_out_322271.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_15 = math.max(var_296_6, arg_293_1.talkMaxDuration)

			if var_296_5 <= arg_293_1.time_ and arg_293_1.time_ < var_296_5 + var_296_15 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_5) / var_296_15

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_5 + var_296_15 and arg_293_1.time_ < var_296_5 + var_296_15 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play322271073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 322271073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play322271074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1020ui_story"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos1020ui_story = var_300_0.localPosition
			end

			local var_300_2 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2
				local var_300_4 = Vector3.New(0, 100, 0)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1020ui_story, var_300_4, var_300_3)

				local var_300_5 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_5.x, var_300_5.y, var_300_5.z)

				local var_300_6 = var_300_0.localEulerAngles

				var_300_6.z = 0
				var_300_6.x = 0
				var_300_0.localEulerAngles = var_300_6
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(0, 100, 0)

				local var_300_7 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_7.x, var_300_7.y, var_300_7.z)

				local var_300_8 = var_300_0.localEulerAngles

				var_300_8.z = 0
				var_300_8.x = 0
				var_300_0.localEulerAngles = var_300_8
			end

			local var_300_9 = 0
			local var_300_10 = 0.9

			if var_300_9 < arg_297_1.time_ and arg_297_1.time_ <= var_300_9 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_11 = arg_297_1:FormatText(StoryNameCfg[7].name)

				arg_297_1.leftNameTxt_.text = var_300_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_12 = arg_297_1:GetWordFromCfg(322271073)
				local var_300_13 = arg_297_1:FormatText(var_300_12.content)

				arg_297_1.text_.text = var_300_13

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_14 = 36
				local var_300_15 = utf8.len(var_300_13)
				local var_300_16 = var_300_14 <= 0 and var_300_10 or var_300_10 * (var_300_15 / var_300_14)

				if var_300_16 > 0 and var_300_10 < var_300_16 then
					arg_297_1.talkMaxDuration = var_300_16

					if var_300_16 + var_300_9 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_16 + var_300_9
					end
				end

				arg_297_1.text_.text = var_300_13
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_17 = math.max(var_300_10, arg_297_1.talkMaxDuration)

			if var_300_9 <= arg_297_1.time_ and arg_297_1.time_ < var_300_9 + var_300_17 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_9) / var_300_17

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_9 + var_300_17 and arg_297_1.time_ < var_300_9 + var_300_17 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play322271074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 322271074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
			arg_301_1.auto_ = false
		end

		function arg_301_1.playNext_(arg_303_0)
			arg_301_1.onStoryFinished_()
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 0.5

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[7].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_3 = arg_301_1:GetWordFromCfg(322271074)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 20
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
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_8 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_8 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_8

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_8 and arg_301_1.time_ < var_304_0 + var_304_8 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0512",
		"TextureConfig/Background/H02"
	},
	voices = {
		"story_v_out_322271.awb"
	}
}
