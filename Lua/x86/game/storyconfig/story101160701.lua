return {
	Play116071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116071001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST18"

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
				if arg_1_0.sceneSettingEffect_ then
					arg_1_1.sceneSettingEffect_.enabled = false
				end

				arg_1_1.sceneSettingGo_:SetActive(true)

				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.ST18

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
					if iter_4_0 ~= "ST18" then
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

			local var_4_28 = 1.23333333333333
			local var_4_29 = 1.09166666666667

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

			local var_4_33 = 1.36666666666667
			local var_4_34 = 0.958333333332333

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
			local var_4_40 = 0.325

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_42 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_43 = arg_1_1:GetWordFromCfg(116071001)
				local var_4_44 = arg_1_1:FormatText(var_4_43.content)

				arg_1_1.text_.text = var_4_44

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_45 = 13
				local var_4_46 = utf8.len(var_4_44)
				local var_4_47 = var_4_45 <= 0 and var_4_40 or var_4_40 * (var_4_46 / var_4_45)

				if var_4_47 > 0 and var_4_40 < var_4_47 then
					arg_1_1.talkMaxDuration = var_4_47
					var_4_39 = var_4_39 + 0.3

					if var_4_47 + var_4_39 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_39
					end
				end

				arg_1_1.text_.text = var_4_44
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_48 = var_4_39 + 0.3
			local var_4_49 = math.max(var_4_40, arg_1_1.talkMaxDuration)

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_49 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_48) / var_4_49

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116071002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 116071002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play116071003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = "10025ui_story"

			if arg_10_1.actors_[var_13_0] == nil then
				local var_13_1 = Asset.Load("Char/" .. "10025ui_story")

				if not isNil(var_13_1) then
					local var_13_2 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_10_1.stage_.transform)

					var_13_2.name = var_13_0
					var_13_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_10_1.actors_[var_13_0] = var_13_2

					local var_13_3 = var_13_2:GetComponentInChildren(typeof(CharacterEffect))

					var_13_3.enabled = true

					local var_13_4 = GameObjectTools.GetOrAddComponent(var_13_2, typeof(DynamicBoneHelper))

					if var_13_4 then
						var_13_4:EnableDynamicBone(false)
					end

					arg_10_1:ShowWeapon(var_13_3.transform, false)

					arg_10_1.var_[var_13_0 .. "Animator"] = var_13_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_10_1.var_[var_13_0 .. "Animator"].applyRootMotion = true
					arg_10_1.var_[var_13_0 .. "LipSync"] = var_13_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_13_5 = arg_10_1.actors_["10025ui_story"]
			local var_13_6 = 0

			if var_13_6 < arg_10_1.time_ and arg_10_1.time_ <= var_13_6 + arg_13_0 and not isNil(var_13_5) and arg_10_1.var_.characterEffect10025ui_story == nil then
				arg_10_1.var_.characterEffect10025ui_story = var_13_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_7 = 0.2

			if var_13_6 <= arg_10_1.time_ and arg_10_1.time_ < var_13_6 + var_13_7 and not isNil(var_13_5) then
				local var_13_8 = (arg_10_1.time_ - var_13_6) / var_13_7

				if arg_10_1.var_.characterEffect10025ui_story and not isNil(var_13_5) then
					arg_10_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_10_1.time_ >= var_13_6 + var_13_7 and arg_10_1.time_ < var_13_6 + var_13_7 + arg_13_0 and not isNil(var_13_5) and arg_10_1.var_.characterEffect10025ui_story then
				arg_10_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_13_9 = 0

			if var_13_9 < arg_10_1.time_ and arg_10_1.time_ <= var_13_9 + arg_13_0 then
				arg_10_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_13_10 = 0

			if var_13_10 < arg_10_1.time_ and arg_10_1.time_ <= var_13_10 + arg_13_0 then
				arg_10_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_13_11 = arg_10_1.actors_["10025ui_story"].transform
			local var_13_12 = 0

			if var_13_12 < arg_10_1.time_ and arg_10_1.time_ <= var_13_12 + arg_13_0 then
				arg_10_1.var_.moveOldPos10025ui_story = var_13_11.localPosition
			end

			local var_13_13 = 0.001

			if var_13_12 <= arg_10_1.time_ and arg_10_1.time_ < var_13_12 + var_13_13 then
				local var_13_14 = (arg_10_1.time_ - var_13_12) / var_13_13
				local var_13_15 = Vector3.New(0, -1.1, -5.9)

				var_13_11.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos10025ui_story, var_13_15, var_13_14)

				local var_13_16 = manager.ui.mainCamera.transform.position - var_13_11.position

				var_13_11.forward = Vector3.New(var_13_16.x, var_13_16.y, var_13_16.z)

				local var_13_17 = var_13_11.localEulerAngles

				var_13_17.z = 0
				var_13_17.x = 0
				var_13_11.localEulerAngles = var_13_17
			end

			if arg_10_1.time_ >= var_13_12 + var_13_13 and arg_10_1.time_ < var_13_12 + var_13_13 + arg_13_0 then
				var_13_11.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_13_18 = manager.ui.mainCamera.transform.position - var_13_11.position

				var_13_11.forward = Vector3.New(var_13_18.x, var_13_18.y, var_13_18.z)

				local var_13_19 = var_13_11.localEulerAngles

				var_13_19.z = 0
				var_13_19.x = 0
				var_13_11.localEulerAngles = var_13_19
			end

			local var_13_20 = 0
			local var_13_21 = 0.45

			if var_13_20 < arg_10_1.time_ and arg_10_1.time_ <= var_13_20 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_22 = arg_10_1:GetWordFromCfg(116071002)
				local var_13_23 = arg_10_1:FormatText(var_13_22.content)

				arg_10_1.text_.text = var_13_23

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_24 = 18
				local var_13_25 = utf8.len(var_13_23)
				local var_13_26 = var_13_24 <= 0 and var_13_21 or var_13_21 * (var_13_25 / var_13_24)

				if var_13_26 > 0 and var_13_21 < var_13_26 then
					arg_10_1.talkMaxDuration = var_13_26

					if var_13_26 + var_13_20 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_26 + var_13_20
					end
				end

				arg_10_1.text_.text = var_13_23
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_27 = math.max(var_13_21, arg_10_1.talkMaxDuration)

			if var_13_20 <= arg_10_1.time_ and arg_10_1.time_ < var_13_20 + var_13_27 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_20) / var_13_27

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_20 + var_13_27 and arg_10_1.time_ < var_13_20 + var_13_27 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
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

		arg_10_1:InitPlayNodeList()
	end,
	Play116071003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 116071003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play116071004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = arg_14_1.actors_["10025ui_story"]
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 and not isNil(var_17_0) and arg_14_1.var_.characterEffect10025ui_story == nil then
				arg_14_1.var_.characterEffect10025ui_story = var_17_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_2 = 0.2

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_2 and not isNil(var_17_0) then
				local var_17_3 = (arg_14_1.time_ - var_17_1) / var_17_2

				if arg_14_1.var_.characterEffect10025ui_story and not isNil(var_17_0) then
					local var_17_4 = Mathf.Lerp(0, 0.5, var_17_3)

					arg_14_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_14_1.var_.characterEffect10025ui_story.fillRatio = var_17_4
				end
			end

			if arg_14_1.time_ >= var_17_1 + var_17_2 and arg_14_1.time_ < var_17_1 + var_17_2 + arg_17_0 and not isNil(var_17_0) and arg_14_1.var_.characterEffect10025ui_story then
				local var_17_5 = 0.5

				arg_14_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_14_1.var_.characterEffect10025ui_story.fillRatio = var_17_5
			end

			local var_17_6 = 0
			local var_17_7 = 0.425

			if var_17_6 < arg_14_1.time_ and arg_14_1.time_ <= var_17_6 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_8 = arg_14_1:FormatText(StoryNameCfg[7].name)

				arg_14_1.leftNameTxt_.text = var_17_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_9 = arg_14_1:GetWordFromCfg(116071003)
				local var_17_10 = arg_14_1:FormatText(var_17_9.content)

				arg_14_1.text_.text = var_17_10

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_11 = 17
				local var_17_12 = utf8.len(var_17_10)
				local var_17_13 = var_17_11 <= 0 and var_17_7 or var_17_7 * (var_17_12 / var_17_11)

				if var_17_13 > 0 and var_17_7 < var_17_13 then
					arg_14_1.talkMaxDuration = var_17_13

					if var_17_13 + var_17_6 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_13 + var_17_6
					end
				end

				arg_14_1.text_.text = var_17_10
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_14 = math.max(var_17_7, arg_14_1.talkMaxDuration)

			if var_17_6 <= arg_14_1.time_ and arg_14_1.time_ < var_17_6 + var_17_14 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_6) / var_17_14

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_6 + var_17_14 and arg_14_1.time_ < var_17_6 + var_17_14 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play116071004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 116071004
		arg_18_1.duration_ = 2

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play116071005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["10025ui_story"]
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.characterEffect10025ui_story == nil then
				arg_18_1.var_.characterEffect10025ui_story = var_21_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_2 = 0.2

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 and not isNil(var_21_0) then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2

				if arg_18_1.var_.characterEffect10025ui_story and not isNil(var_21_0) then
					arg_18_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.characterEffect10025ui_story then
				arg_18_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_21_4 = 0

			if var_21_4 < arg_18_1.time_ and arg_18_1.time_ <= var_21_4 + arg_21_0 then
				arg_18_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			local var_21_5 = 0

			if var_21_5 < arg_18_1.time_ and arg_18_1.time_ <= var_21_5 + arg_21_0 then
				arg_18_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_21_6 = 0
			local var_21_7 = 0.1

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
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_9 = arg_18_1:GetWordFromCfg(116071004)
				local var_21_10 = arg_18_1:FormatText(var_21_9.content)

				arg_18_1.text_.text = var_21_10

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_11 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071004", "story_v_out_116071.awb") ~= 0 then
					local var_21_14 = manager.audio:GetVoiceLength("story_v_out_116071", "116071004", "story_v_out_116071.awb") / 1000

					if var_21_14 + var_21_6 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_14 + var_21_6
					end

					if var_21_9.prefab_name ~= "" and arg_18_1.actors_[var_21_9.prefab_name] ~= nil then
						local var_21_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_9.prefab_name].transform, "story_v_out_116071", "116071004", "story_v_out_116071.awb")

						arg_18_1:RecordAudio("116071004", var_21_15)
						arg_18_1:RecordAudio("116071004", var_21_15)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_116071", "116071004", "story_v_out_116071.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_116071", "116071004", "story_v_out_116071.awb")
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
	Play116071005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 116071005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play116071006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["10025ui_story"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect10025ui_story == nil then
				arg_22_1.var_.characterEffect10025ui_story = var_25_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_2 = 0.2

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.characterEffect10025ui_story and not isNil(var_25_0) then
					local var_25_4 = Mathf.Lerp(0, 0.5, var_25_3)

					arg_22_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_22_1.var_.characterEffect10025ui_story.fillRatio = var_25_4
				end
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect10025ui_story then
				local var_25_5 = 0.5

				arg_22_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_22_1.var_.characterEffect10025ui_story.fillRatio = var_25_5
			end

			local var_25_6 = 0
			local var_25_7 = 0.85

			if var_25_6 < arg_22_1.time_ and arg_22_1.time_ <= var_25_6 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_8 = arg_22_1:FormatText(StoryNameCfg[7].name)

				arg_22_1.leftNameTxt_.text = var_25_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_9 = arg_22_1:GetWordFromCfg(116071005)
				local var_25_10 = arg_22_1:FormatText(var_25_9.content)

				arg_22_1.text_.text = var_25_10

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_11 = 34
				local var_25_12 = utf8.len(var_25_10)
				local var_25_13 = var_25_11 <= 0 and var_25_7 or var_25_7 * (var_25_12 / var_25_11)

				if var_25_13 > 0 and var_25_7 < var_25_13 then
					arg_22_1.talkMaxDuration = var_25_13

					if var_25_13 + var_25_6 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_13 + var_25_6
					end
				end

				arg_22_1.text_.text = var_25_10
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_14 = math.max(var_25_7, arg_22_1.talkMaxDuration)

			if var_25_6 <= arg_22_1.time_ and arg_22_1.time_ < var_25_6 + var_25_14 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_6) / var_25_14

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_6 + var_25_14 and arg_22_1.time_ < var_25_6 + var_25_14 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play116071006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 116071006
		arg_26_1.duration_ = 6.57

		local var_26_0 = {
			zh = 5,
			ja = 6.566
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
				arg_26_0:Play116071007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["10025ui_story"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect10025ui_story == nil then
				arg_26_1.var_.characterEffect10025ui_story = var_29_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_2 = 0.2

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.characterEffect10025ui_story and not isNil(var_29_0) then
					arg_26_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect10025ui_story then
				arg_26_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_29_4 = 0

			if var_29_4 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				arg_26_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_29_5 = 0
			local var_29_6 = 0.45

			if var_29_5 < arg_26_1.time_ and arg_26_1.time_ <= var_29_5 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_7 = arg_26_1:FormatText(StoryNameCfg[328].name)

				arg_26_1.leftNameTxt_.text = var_29_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_8 = arg_26_1:GetWordFromCfg(116071006)
				local var_29_9 = arg_26_1:FormatText(var_29_8.content)

				arg_26_1.text_.text = var_29_9

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_10 = 18
				local var_29_11 = utf8.len(var_29_9)
				local var_29_12 = var_29_10 <= 0 and var_29_6 or var_29_6 * (var_29_11 / var_29_10)

				if var_29_12 > 0 and var_29_6 < var_29_12 then
					arg_26_1.talkMaxDuration = var_29_12

					if var_29_12 + var_29_5 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_12 + var_29_5
					end
				end

				arg_26_1.text_.text = var_29_9
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071006", "story_v_out_116071.awb") ~= 0 then
					local var_29_13 = manager.audio:GetVoiceLength("story_v_out_116071", "116071006", "story_v_out_116071.awb") / 1000

					if var_29_13 + var_29_5 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_13 + var_29_5
					end

					if var_29_8.prefab_name ~= "" and arg_26_1.actors_[var_29_8.prefab_name] ~= nil then
						local var_29_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_8.prefab_name].transform, "story_v_out_116071", "116071006", "story_v_out_116071.awb")

						arg_26_1:RecordAudio("116071006", var_29_14)
						arg_26_1:RecordAudio("116071006", var_29_14)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_116071", "116071006", "story_v_out_116071.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_116071", "116071006", "story_v_out_116071.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_15 = math.max(var_29_6, arg_26_1.talkMaxDuration)

			if var_29_5 <= arg_26_1.time_ and arg_26_1.time_ < var_29_5 + var_29_15 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_5) / var_29_15

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_5 + var_29_15 and arg_26_1.time_ < var_29_5 + var_29_15 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play116071007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 116071007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play116071008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["10025ui_story"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect10025ui_story == nil then
				arg_30_1.var_.characterEffect10025ui_story = var_33_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.2

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.characterEffect10025ui_story and not isNil(var_33_0) then
					local var_33_4 = Mathf.Lerp(0, 0.5, var_33_3)

					arg_30_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_30_1.var_.characterEffect10025ui_story.fillRatio = var_33_4
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect10025ui_story then
				local var_33_5 = 0.5

				arg_30_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_30_1.var_.characterEffect10025ui_story.fillRatio = var_33_5
			end

			local var_33_6 = 0
			local var_33_7 = 0.125

			if var_33_6 < arg_30_1.time_ and arg_30_1.time_ <= var_33_6 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_8 = arg_30_1:FormatText(StoryNameCfg[7].name)

				arg_30_1.leftNameTxt_.text = var_33_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_9 = arg_30_1:GetWordFromCfg(116071007)
				local var_33_10 = arg_30_1:FormatText(var_33_9.content)

				arg_30_1.text_.text = var_33_10

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_11 = 5
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
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_14 = math.max(var_33_7, arg_30_1.talkMaxDuration)

			if var_33_6 <= arg_30_1.time_ and arg_30_1.time_ < var_33_6 + var_33_14 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_6) / var_33_14

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_6 + var_33_14 and arg_30_1.time_ < var_33_6 + var_33_14 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play116071008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 116071008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play116071009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["10025ui_story"].transform
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.var_.moveOldPos10025ui_story = var_37_0.localPosition
			end

			local var_37_2 = 0.001

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2
				local var_37_4 = Vector3.New(0, 100, 0)

				var_37_0.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos10025ui_story, var_37_4, var_37_3)

				local var_37_5 = manager.ui.mainCamera.transform.position - var_37_0.position

				var_37_0.forward = Vector3.New(var_37_5.x, var_37_5.y, var_37_5.z)

				local var_37_6 = var_37_0.localEulerAngles

				var_37_6.z = 0
				var_37_6.x = 0
				var_37_0.localEulerAngles = var_37_6
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 then
				var_37_0.localPosition = Vector3.New(0, 100, 0)

				local var_37_7 = manager.ui.mainCamera.transform.position - var_37_0.position

				var_37_0.forward = Vector3.New(var_37_7.x, var_37_7.y, var_37_7.z)

				local var_37_8 = var_37_0.localEulerAngles

				var_37_8.z = 0
				var_37_8.x = 0
				var_37_0.localEulerAngles = var_37_8
			end

			local var_37_9 = 0
			local var_37_10 = 1.5

			if var_37_9 < arg_34_1.time_ and arg_34_1.time_ <= var_37_9 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_11 = arg_34_1:GetWordFromCfg(116071008)
				local var_37_12 = arg_34_1:FormatText(var_37_11.content)

				arg_34_1.text_.text = var_37_12

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_13 = 60
				local var_37_14 = utf8.len(var_37_12)
				local var_37_15 = var_37_13 <= 0 and var_37_10 or var_37_10 * (var_37_14 / var_37_13)

				if var_37_15 > 0 and var_37_10 < var_37_15 then
					arg_34_1.talkMaxDuration = var_37_15

					if var_37_15 + var_37_9 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_15 + var_37_9
					end
				end

				arg_34_1.text_.text = var_37_12
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_16 = math.max(var_37_10, arg_34_1.talkMaxDuration)

			if var_37_9 <= arg_34_1.time_ and arg_34_1.time_ < var_37_9 + var_37_16 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_9) / var_37_16

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_9 + var_37_16 and arg_34_1.time_ < var_37_9 + var_37_16 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
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

		arg_34_1:InitPlayNodeList()
	end,
	Play116071009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 116071009
		arg_38_1.duration_ = 2

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play116071010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["10025ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect10025ui_story == nil then
				arg_38_1.var_.characterEffect10025ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.2

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect10025ui_story and not isNil(var_41_0) then
					arg_38_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect10025ui_story then
				arg_38_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_41_4 = 0

			if var_41_4 < arg_38_1.time_ and arg_38_1.time_ <= var_41_4 + arg_41_0 then
				arg_38_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_41_5 = 0

			if var_41_5 < arg_38_1.time_ and arg_38_1.time_ <= var_41_5 + arg_41_0 then
				arg_38_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_41_6 = arg_38_1.actors_["10025ui_story"].transform
			local var_41_7 = 0

			if var_41_7 < arg_38_1.time_ and arg_38_1.time_ <= var_41_7 + arg_41_0 then
				arg_38_1.var_.moveOldPos10025ui_story = var_41_6.localPosition
			end

			local var_41_8 = 0.001

			if var_41_7 <= arg_38_1.time_ and arg_38_1.time_ < var_41_7 + var_41_8 then
				local var_41_9 = (arg_38_1.time_ - var_41_7) / var_41_8
				local var_41_10 = Vector3.New(0, -1.1, -5.9)

				var_41_6.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos10025ui_story, var_41_10, var_41_9)

				local var_41_11 = manager.ui.mainCamera.transform.position - var_41_6.position

				var_41_6.forward = Vector3.New(var_41_11.x, var_41_11.y, var_41_11.z)

				local var_41_12 = var_41_6.localEulerAngles

				var_41_12.z = 0
				var_41_12.x = 0
				var_41_6.localEulerAngles = var_41_12
			end

			if arg_38_1.time_ >= var_41_7 + var_41_8 and arg_38_1.time_ < var_41_7 + var_41_8 + arg_41_0 then
				var_41_6.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_41_13 = manager.ui.mainCamera.transform.position - var_41_6.position

				var_41_6.forward = Vector3.New(var_41_13.x, var_41_13.y, var_41_13.z)

				local var_41_14 = var_41_6.localEulerAngles

				var_41_14.z = 0
				var_41_14.x = 0
				var_41_6.localEulerAngles = var_41_14
			end

			local var_41_15 = 0
			local var_41_16 = 0.1

			if var_41_15 < arg_38_1.time_ and arg_38_1.time_ <= var_41_15 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_17 = arg_38_1:FormatText(StoryNameCfg[328].name)

				arg_38_1.leftNameTxt_.text = var_41_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_18 = arg_38_1:GetWordFromCfg(116071009)
				local var_41_19 = arg_38_1:FormatText(var_41_18.content)

				arg_38_1.text_.text = var_41_19

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_20 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071009", "story_v_out_116071.awb") ~= 0 then
					local var_41_23 = manager.audio:GetVoiceLength("story_v_out_116071", "116071009", "story_v_out_116071.awb") / 1000

					if var_41_23 + var_41_15 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_23 + var_41_15
					end

					if var_41_18.prefab_name ~= "" and arg_38_1.actors_[var_41_18.prefab_name] ~= nil then
						local var_41_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_18.prefab_name].transform, "story_v_out_116071", "116071009", "story_v_out_116071.awb")

						arg_38_1:RecordAudio("116071009", var_41_24)
						arg_38_1:RecordAudio("116071009", var_41_24)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_116071", "116071009", "story_v_out_116071.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_116071", "116071009", "story_v_out_116071.awb")
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
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play116071010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 116071010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play116071011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["10025ui_story"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect10025ui_story == nil then
				arg_42_1.var_.characterEffect10025ui_story = var_45_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.2

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.characterEffect10025ui_story and not isNil(var_45_0) then
					local var_45_4 = Mathf.Lerp(0, 0.5, var_45_3)

					arg_42_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_42_1.var_.characterEffect10025ui_story.fillRatio = var_45_4
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect10025ui_story then
				local var_45_5 = 0.5

				arg_42_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_42_1.var_.characterEffect10025ui_story.fillRatio = var_45_5
			end

			local var_45_6 = 0
			local var_45_7 = 0.25

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_8 = arg_42_1:FormatText(StoryNameCfg[7].name)

				arg_42_1.leftNameTxt_.text = var_45_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_9 = arg_42_1:GetWordFromCfg(116071010)
				local var_45_10 = arg_42_1:FormatText(var_45_9.content)

				arg_42_1.text_.text = var_45_10

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_11 = 10
				local var_45_12 = utf8.len(var_45_10)
				local var_45_13 = var_45_11 <= 0 and var_45_7 or var_45_7 * (var_45_12 / var_45_11)

				if var_45_13 > 0 and var_45_7 < var_45_13 then
					arg_42_1.talkMaxDuration = var_45_13

					if var_45_13 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_13 + var_45_6
					end
				end

				arg_42_1.text_.text = var_45_10
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_14 = math.max(var_45_7, arg_42_1.talkMaxDuration)

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_14 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_6) / var_45_14

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_6 + var_45_14 and arg_42_1.time_ < var_45_6 + var_45_14 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play116071011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 116071011
		arg_46_1.duration_ = 9.37

		local var_46_0 = {
			zh = 5.066,
			ja = 9.366
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
				arg_46_0:Play116071012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["10025ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect10025ui_story == nil then
				arg_46_1.var_.characterEffect10025ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.2

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect10025ui_story and not isNil(var_49_0) then
					arg_46_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect10025ui_story then
				arg_46_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_49_4 = 0

			if var_49_4 < arg_46_1.time_ and arg_46_1.time_ <= var_49_4 + arg_49_0 then
				arg_46_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_49_5 = 0
			local var_49_6 = 0.5

			if var_49_5 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_7 = arg_46_1:FormatText(StoryNameCfg[328].name)

				arg_46_1.leftNameTxt_.text = var_49_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_8 = arg_46_1:GetWordFromCfg(116071011)
				local var_49_9 = arg_46_1:FormatText(var_49_8.content)

				arg_46_1.text_.text = var_49_9

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_10 = 20
				local var_49_11 = utf8.len(var_49_9)
				local var_49_12 = var_49_10 <= 0 and var_49_6 or var_49_6 * (var_49_11 / var_49_10)

				if var_49_12 > 0 and var_49_6 < var_49_12 then
					arg_46_1.talkMaxDuration = var_49_12

					if var_49_12 + var_49_5 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_12 + var_49_5
					end
				end

				arg_46_1.text_.text = var_49_9
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071011", "story_v_out_116071.awb") ~= 0 then
					local var_49_13 = manager.audio:GetVoiceLength("story_v_out_116071", "116071011", "story_v_out_116071.awb") / 1000

					if var_49_13 + var_49_5 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_13 + var_49_5
					end

					if var_49_8.prefab_name ~= "" and arg_46_1.actors_[var_49_8.prefab_name] ~= nil then
						local var_49_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_8.prefab_name].transform, "story_v_out_116071", "116071011", "story_v_out_116071.awb")

						arg_46_1:RecordAudio("116071011", var_49_14)
						arg_46_1:RecordAudio("116071011", var_49_14)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_116071", "116071011", "story_v_out_116071.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_116071", "116071011", "story_v_out_116071.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_15 = math.max(var_49_6, arg_46_1.talkMaxDuration)

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_15 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_5) / var_49_15

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_5 + var_49_15 and arg_46_1.time_ < var_49_5 + var_49_15 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play116071012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 116071012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play116071013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["10025ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect10025ui_story == nil then
				arg_50_1.var_.characterEffect10025ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.2

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect10025ui_story and not isNil(var_53_0) then
					local var_53_4 = Mathf.Lerp(0, 0.5, var_53_3)

					arg_50_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_50_1.var_.characterEffect10025ui_story.fillRatio = var_53_4
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect10025ui_story then
				local var_53_5 = 0.5

				arg_50_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_50_1.var_.characterEffect10025ui_story.fillRatio = var_53_5
			end

			local var_53_6 = 0
			local var_53_7 = 0.575

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_8 = arg_50_1:FormatText(StoryNameCfg[7].name)

				arg_50_1.leftNameTxt_.text = var_53_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_9 = arg_50_1:GetWordFromCfg(116071012)
				local var_53_10 = arg_50_1:FormatText(var_53_9.content)

				arg_50_1.text_.text = var_53_10

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 23
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
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_14 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_14 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_14

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_14 and arg_50_1.time_ < var_53_6 + var_53_14 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play116071013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 116071013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play116071014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 0.8

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_2 = arg_54_1:GetWordFromCfg(116071013)
				local var_57_3 = arg_54_1:FormatText(var_57_2.content)

				arg_54_1.text_.text = var_57_3

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 32
				local var_57_5 = utf8.len(var_57_3)
				local var_57_6 = var_57_4 <= 0 and var_57_1 or var_57_1 * (var_57_5 / var_57_4)

				if var_57_6 > 0 and var_57_1 < var_57_6 then
					arg_54_1.talkMaxDuration = var_57_6

					if var_57_6 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_6 + var_57_0
					end
				end

				arg_54_1.text_.text = var_57_3
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_1, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_7 and arg_54_1.time_ < var_57_0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play116071014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 116071014
		arg_58_1.duration_ = 10.13

		local var_58_0 = {
			zh = 8.433,
			ja = 10.133
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
				arg_58_0:Play116071015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["10025ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect10025ui_story == nil then
				arg_58_1.var_.characterEffect10025ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.2

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect10025ui_story and not isNil(var_61_0) then
					arg_58_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect10025ui_story then
				arg_58_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_61_4 = 0

			if var_61_4 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
				arg_58_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_61_5 = 0

			if var_61_5 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 then
				arg_58_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_2")
			end

			local var_61_6 = 0
			local var_61_7 = 0.625

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_8 = arg_58_1:FormatText(StoryNameCfg[328].name)

				arg_58_1.leftNameTxt_.text = var_61_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_9 = arg_58_1:GetWordFromCfg(116071014)
				local var_61_10 = arg_58_1:FormatText(var_61_9.content)

				arg_58_1.text_.text = var_61_10

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 25
				local var_61_12 = utf8.len(var_61_10)
				local var_61_13 = var_61_11 <= 0 and var_61_7 or var_61_7 * (var_61_12 / var_61_11)

				if var_61_13 > 0 and var_61_7 < var_61_13 then
					arg_58_1.talkMaxDuration = var_61_13

					if var_61_13 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_6
					end
				end

				arg_58_1.text_.text = var_61_10
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071014", "story_v_out_116071.awb") ~= 0 then
					local var_61_14 = manager.audio:GetVoiceLength("story_v_out_116071", "116071014", "story_v_out_116071.awb") / 1000

					if var_61_14 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_14 + var_61_6
					end

					if var_61_9.prefab_name ~= "" and arg_58_1.actors_[var_61_9.prefab_name] ~= nil then
						local var_61_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_9.prefab_name].transform, "story_v_out_116071", "116071014", "story_v_out_116071.awb")

						arg_58_1:RecordAudio("116071014", var_61_15)
						arg_58_1:RecordAudio("116071014", var_61_15)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_116071", "116071014", "story_v_out_116071.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_116071", "116071014", "story_v_out_116071.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_16 = math.max(var_61_7, arg_58_1.talkMaxDuration)

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_16 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_6) / var_61_16

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_6 + var_61_16 and arg_58_1.time_ < var_61_6 + var_61_16 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play116071015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 116071015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play116071016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["10025ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect10025ui_story == nil then
				arg_62_1.var_.characterEffect10025ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.2

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect10025ui_story and not isNil(var_65_0) then
					local var_65_4 = Mathf.Lerp(0, 0.5, var_65_3)

					arg_62_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_62_1.var_.characterEffect10025ui_story.fillRatio = var_65_4
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect10025ui_story then
				local var_65_5 = 0.5

				arg_62_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_62_1.var_.characterEffect10025ui_story.fillRatio = var_65_5
			end

			local var_65_6 = 0
			local var_65_7 = 0.275

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_8 = arg_62_1:FormatText(StoryNameCfg[7].name)

				arg_62_1.leftNameTxt_.text = var_65_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_9 = arg_62_1:GetWordFromCfg(116071015)
				local var_65_10 = arg_62_1:FormatText(var_65_9.content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 11
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
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_14 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_14 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_14

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_14 and arg_62_1.time_ < var_65_6 + var_65_14 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play116071016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 116071016
		arg_66_1.duration_ = 16.53

		local var_66_0 = {
			zh = 6.9,
			ja = 16.533
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
				arg_66_0:Play116071017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["10025ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect10025ui_story == nil then
				arg_66_1.var_.characterEffect10025ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.2

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect10025ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect10025ui_story then
				arg_66_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_69_4 = 0

			if var_69_4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_69_6 = 0
			local var_69_7 = 0.5

			if var_69_6 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_8 = arg_66_1:FormatText(StoryNameCfg[328].name)

				arg_66_1.leftNameTxt_.text = var_69_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_9 = arg_66_1:GetWordFromCfg(116071016)
				local var_69_10 = arg_66_1:FormatText(var_69_9.content)

				arg_66_1.text_.text = var_69_10

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_11 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071016", "story_v_out_116071.awb") ~= 0 then
					local var_69_14 = manager.audio:GetVoiceLength("story_v_out_116071", "116071016", "story_v_out_116071.awb") / 1000

					if var_69_14 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_14 + var_69_6
					end

					if var_69_9.prefab_name ~= "" and arg_66_1.actors_[var_69_9.prefab_name] ~= nil then
						local var_69_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_9.prefab_name].transform, "story_v_out_116071", "116071016", "story_v_out_116071.awb")

						arg_66_1:RecordAudio("116071016", var_69_15)
						arg_66_1:RecordAudio("116071016", var_69_15)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_116071", "116071016", "story_v_out_116071.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_116071", "116071016", "story_v_out_116071.awb")
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
	Play116071017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 116071017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play116071018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["10025ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10025ui_story == nil then
				arg_70_1.var_.characterEffect10025ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.2

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect10025ui_story and not isNil(var_73_0) then
					local var_73_4 = Mathf.Lerp(0, 0.5, var_73_3)

					arg_70_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_70_1.var_.characterEffect10025ui_story.fillRatio = var_73_4
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10025ui_story then
				local var_73_5 = 0.5

				arg_70_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_70_1.var_.characterEffect10025ui_story.fillRatio = var_73_5
			end

			local var_73_6 = 0
			local var_73_7 = 0.625

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_8 = arg_70_1:FormatText(StoryNameCfg[7].name)

				arg_70_1.leftNameTxt_.text = var_73_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_9 = arg_70_1:GetWordFromCfg(116071017)
				local var_73_10 = arg_70_1:FormatText(var_73_9.content)

				arg_70_1.text_.text = var_73_10

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 25
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
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_14 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_14 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_14

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_14 and arg_70_1.time_ < var_73_6 + var_73_14 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play116071018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 116071018
		arg_74_1.duration_ = 3.4

		local var_74_0 = {
			zh = 1.999999999999,
			ja = 3.4
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
				arg_74_0:Play116071019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["10025ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect10025ui_story == nil then
				arg_74_1.var_.characterEffect10025ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.2

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect10025ui_story and not isNil(var_77_0) then
					arg_74_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect10025ui_story then
				arg_74_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_77_4 = 0

			if var_77_4 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_77_5 = 0
			local var_77_6 = 0.2

			if var_77_5 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_7 = arg_74_1:FormatText(StoryNameCfg[328].name)

				arg_74_1.leftNameTxt_.text = var_77_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_8 = arg_74_1:GetWordFromCfg(116071018)
				local var_77_9 = arg_74_1:FormatText(var_77_8.content)

				arg_74_1.text_.text = var_77_9

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_10 = 8
				local var_77_11 = utf8.len(var_77_9)
				local var_77_12 = var_77_10 <= 0 and var_77_6 or var_77_6 * (var_77_11 / var_77_10)

				if var_77_12 > 0 and var_77_6 < var_77_12 then
					arg_74_1.talkMaxDuration = var_77_12

					if var_77_12 + var_77_5 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_12 + var_77_5
					end
				end

				arg_74_1.text_.text = var_77_9
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071018", "story_v_out_116071.awb") ~= 0 then
					local var_77_13 = manager.audio:GetVoiceLength("story_v_out_116071", "116071018", "story_v_out_116071.awb") / 1000

					if var_77_13 + var_77_5 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_13 + var_77_5
					end

					if var_77_8.prefab_name ~= "" and arg_74_1.actors_[var_77_8.prefab_name] ~= nil then
						local var_77_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_8.prefab_name].transform, "story_v_out_116071", "116071018", "story_v_out_116071.awb")

						arg_74_1:RecordAudio("116071018", var_77_14)
						arg_74_1:RecordAudio("116071018", var_77_14)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_116071", "116071018", "story_v_out_116071.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_116071", "116071018", "story_v_out_116071.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_15 = math.max(var_77_6, arg_74_1.talkMaxDuration)

			if var_77_5 <= arg_74_1.time_ and arg_74_1.time_ < var_77_5 + var_77_15 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_5) / var_77_15

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_5 + var_77_15 and arg_74_1.time_ < var_77_5 + var_77_15 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play116071019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 116071019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play116071020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["10025ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect10025ui_story == nil then
				arg_78_1.var_.characterEffect10025ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.2

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect10025ui_story and not isNil(var_81_0) then
					local var_81_4 = Mathf.Lerp(0, 0.5, var_81_3)

					arg_78_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_78_1.var_.characterEffect10025ui_story.fillRatio = var_81_4
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect10025ui_story then
				local var_81_5 = 0.5

				arg_78_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_78_1.var_.characterEffect10025ui_story.fillRatio = var_81_5
			end

			local var_81_6 = 0
			local var_81_7 = 0.575

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_8 = arg_78_1:FormatText(StoryNameCfg[7].name)

				arg_78_1.leftNameTxt_.text = var_81_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_9 = arg_78_1:GetWordFromCfg(116071019)
				local var_81_10 = arg_78_1:FormatText(var_81_9.content)

				arg_78_1.text_.text = var_81_10

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_11 = 23
				local var_81_12 = utf8.len(var_81_10)
				local var_81_13 = var_81_11 <= 0 and var_81_7 or var_81_7 * (var_81_12 / var_81_11)

				if var_81_13 > 0 and var_81_7 < var_81_13 then
					arg_78_1.talkMaxDuration = var_81_13

					if var_81_13 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_13 + var_81_6
					end
				end

				arg_78_1.text_.text = var_81_10
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_14 = math.max(var_81_7, arg_78_1.talkMaxDuration)

			if var_81_6 <= arg_78_1.time_ and arg_78_1.time_ < var_81_6 + var_81_14 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_6) / var_81_14

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_6 + var_81_14 and arg_78_1.time_ < var_81_6 + var_81_14 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play116071020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 116071020
		arg_82_1.duration_ = 5.37

		local var_82_0 = {
			zh = 5.366,
			ja = 3.8
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play116071021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["10025ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10025ui_story == nil then
				arg_82_1.var_.characterEffect10025ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.2

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect10025ui_story and not isNil(var_85_0) then
					arg_82_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10025ui_story then
				arg_82_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_85_4 = 0

			if var_85_4 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			local var_85_5 = 0

			if var_85_5 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 then
				arg_82_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_85_6 = 0
			local var_85_7 = 0.4

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_8 = arg_82_1:FormatText(StoryNameCfg[328].name)

				arg_82_1.leftNameTxt_.text = var_85_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_9 = arg_82_1:GetWordFromCfg(116071020)
				local var_85_10 = arg_82_1:FormatText(var_85_9.content)

				arg_82_1.text_.text = var_85_10

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_11 = 16
				local var_85_12 = utf8.len(var_85_10)
				local var_85_13 = var_85_11 <= 0 and var_85_7 or var_85_7 * (var_85_12 / var_85_11)

				if var_85_13 > 0 and var_85_7 < var_85_13 then
					arg_82_1.talkMaxDuration = var_85_13

					if var_85_13 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_13 + var_85_6
					end
				end

				arg_82_1.text_.text = var_85_10
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071020", "story_v_out_116071.awb") ~= 0 then
					local var_85_14 = manager.audio:GetVoiceLength("story_v_out_116071", "116071020", "story_v_out_116071.awb") / 1000

					if var_85_14 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_14 + var_85_6
					end

					if var_85_9.prefab_name ~= "" and arg_82_1.actors_[var_85_9.prefab_name] ~= nil then
						local var_85_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_9.prefab_name].transform, "story_v_out_116071", "116071020", "story_v_out_116071.awb")

						arg_82_1:RecordAudio("116071020", var_85_15)
						arg_82_1:RecordAudio("116071020", var_85_15)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_116071", "116071020", "story_v_out_116071.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_116071", "116071020", "story_v_out_116071.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_16 = math.max(var_85_7, arg_82_1.talkMaxDuration)

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_16 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_6) / var_85_16

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_6 + var_85_16 and arg_82_1.time_ < var_85_6 + var_85_16 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play116071021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 116071021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play116071022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10025ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect10025ui_story == nil then
				arg_86_1.var_.characterEffect10025ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.2

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect10025ui_story and not isNil(var_89_0) then
					local var_89_4 = Mathf.Lerp(0, 0.5, var_89_3)

					arg_86_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10025ui_story.fillRatio = var_89_4
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect10025ui_story then
				local var_89_5 = 0.5

				arg_86_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10025ui_story.fillRatio = var_89_5
			end

			local var_89_6 = 0
			local var_89_7 = 0.375

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_8 = arg_86_1:FormatText(StoryNameCfg[7].name)

				arg_86_1.leftNameTxt_.text = var_89_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_9 = arg_86_1:GetWordFromCfg(116071021)
				local var_89_10 = arg_86_1:FormatText(var_89_9.content)

				arg_86_1.text_.text = var_89_10

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_11 = 15
				local var_89_12 = utf8.len(var_89_10)
				local var_89_13 = var_89_11 <= 0 and var_89_7 or var_89_7 * (var_89_12 / var_89_11)

				if var_89_13 > 0 and var_89_7 < var_89_13 then
					arg_86_1.talkMaxDuration = var_89_13

					if var_89_13 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_13 + var_89_6
					end
				end

				arg_86_1.text_.text = var_89_10
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_14 = math.max(var_89_7, arg_86_1.talkMaxDuration)

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_14 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_6) / var_89_14

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_6 + var_89_14 and arg_86_1.time_ < var_89_6 + var_89_14 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play116071022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 116071022
		arg_90_1.duration_ = 2.7

		local var_90_0 = {
			zh = 2.7,
			ja = 1.999999999999
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play116071023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["10025ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect10025ui_story == nil then
				arg_90_1.var_.characterEffect10025ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.2

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect10025ui_story and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect10025ui_story then
				arg_90_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_93_4 = 0

			if var_93_4 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action7_1")
			end

			local var_93_5 = 0

			if var_93_5 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 then
				arg_90_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_93_6 = 0
			local var_93_7 = 0.1

			if var_93_6 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_8 = arg_90_1:FormatText(StoryNameCfg[328].name)

				arg_90_1.leftNameTxt_.text = var_93_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_9 = arg_90_1:GetWordFromCfg(116071022)
				local var_93_10 = arg_90_1:FormatText(var_93_9.content)

				arg_90_1.text_.text = var_93_10

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_11 = 4
				local var_93_12 = utf8.len(var_93_10)
				local var_93_13 = var_93_11 <= 0 and var_93_7 or var_93_7 * (var_93_12 / var_93_11)

				if var_93_13 > 0 and var_93_7 < var_93_13 then
					arg_90_1.talkMaxDuration = var_93_13

					if var_93_13 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_6
					end
				end

				arg_90_1.text_.text = var_93_10
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071022", "story_v_out_116071.awb") ~= 0 then
					local var_93_14 = manager.audio:GetVoiceLength("story_v_out_116071", "116071022", "story_v_out_116071.awb") / 1000

					if var_93_14 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_14 + var_93_6
					end

					if var_93_9.prefab_name ~= "" and arg_90_1.actors_[var_93_9.prefab_name] ~= nil then
						local var_93_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_9.prefab_name].transform, "story_v_out_116071", "116071022", "story_v_out_116071.awb")

						arg_90_1:RecordAudio("116071022", var_93_15)
						arg_90_1:RecordAudio("116071022", var_93_15)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_116071", "116071022", "story_v_out_116071.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_116071", "116071022", "story_v_out_116071.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_16 = math.max(var_93_7, arg_90_1.talkMaxDuration)

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_16 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_6) / var_93_16

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_6 + var_93_16 and arg_90_1.time_ < var_93_6 + var_93_16 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play116071023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 116071023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play116071024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["10025ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect10025ui_story == nil then
				arg_94_1.var_.characterEffect10025ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.2

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect10025ui_story and not isNil(var_97_0) then
					local var_97_4 = Mathf.Lerp(0, 0.5, var_97_3)

					arg_94_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_94_1.var_.characterEffect10025ui_story.fillRatio = var_97_4
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect10025ui_story then
				local var_97_5 = 0.5

				arg_94_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_94_1.var_.characterEffect10025ui_story.fillRatio = var_97_5
			end

			local var_97_6 = arg_94_1.actors_["10025ui_story"].transform
			local var_97_7 = 0

			if var_97_7 < arg_94_1.time_ and arg_94_1.time_ <= var_97_7 + arg_97_0 then
				arg_94_1.var_.moveOldPos10025ui_story = var_97_6.localPosition
			end

			local var_97_8 = 0.001

			if var_97_7 <= arg_94_1.time_ and arg_94_1.time_ < var_97_7 + var_97_8 then
				local var_97_9 = (arg_94_1.time_ - var_97_7) / var_97_8
				local var_97_10 = Vector3.New(0, 100, 0)

				var_97_6.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos10025ui_story, var_97_10, var_97_9)

				local var_97_11 = manager.ui.mainCamera.transform.position - var_97_6.position

				var_97_6.forward = Vector3.New(var_97_11.x, var_97_11.y, var_97_11.z)

				local var_97_12 = var_97_6.localEulerAngles

				var_97_12.z = 0
				var_97_12.x = 0
				var_97_6.localEulerAngles = var_97_12
			end

			if arg_94_1.time_ >= var_97_7 + var_97_8 and arg_94_1.time_ < var_97_7 + var_97_8 + arg_97_0 then
				var_97_6.localPosition = Vector3.New(0, 100, 0)

				local var_97_13 = manager.ui.mainCamera.transform.position - var_97_6.position

				var_97_6.forward = Vector3.New(var_97_13.x, var_97_13.y, var_97_13.z)

				local var_97_14 = var_97_6.localEulerAngles

				var_97_14.z = 0
				var_97_14.x = 0
				var_97_6.localEulerAngles = var_97_14
			end

			local var_97_15 = 0
			local var_97_16 = 0.65

			if var_97_15 < arg_94_1.time_ and arg_94_1.time_ <= var_97_15 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_17 = arg_94_1:GetWordFromCfg(116071023)
				local var_97_18 = arg_94_1:FormatText(var_97_17.content)

				arg_94_1.text_.text = var_97_18

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_19 = 26
				local var_97_20 = utf8.len(var_97_18)
				local var_97_21 = var_97_19 <= 0 and var_97_16 or var_97_16 * (var_97_20 / var_97_19)

				if var_97_21 > 0 and var_97_16 < var_97_21 then
					arg_94_1.talkMaxDuration = var_97_21

					if var_97_21 + var_97_15 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_21 + var_97_15
					end
				end

				arg_94_1.text_.text = var_97_18
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_22 = math.max(var_97_16, arg_94_1.talkMaxDuration)

			if var_97_15 <= arg_94_1.time_ and arg_94_1.time_ < var_97_15 + var_97_22 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_15) / var_97_22

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_15 + var_97_22 and arg_94_1.time_ < var_97_15 + var_97_22 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
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

		arg_94_1:InitPlayNodeList()
	end,
	Play116071024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 116071024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play116071025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 0.6

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_2 = arg_98_1:FormatText(StoryNameCfg[7].name)

				arg_98_1.leftNameTxt_.text = var_101_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_3 = arg_98_1:GetWordFromCfg(116071024)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 24
				local var_101_6 = utf8.len(var_101_4)
				local var_101_7 = var_101_5 <= 0 and var_101_1 or var_101_1 * (var_101_6 / var_101_5)

				if var_101_7 > 0 and var_101_1 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_8 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_8 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_8

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_8 and arg_98_1.time_ < var_101_0 + var_101_8 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play116071025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 116071025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play116071026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["10025ui_story"].transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos10025ui_story = var_105_0.localPosition
			end

			local var_105_2 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2
				local var_105_4 = Vector3.New(0, -1.1, -5.9)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10025ui_story, var_105_4, var_105_3)

				local var_105_5 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_5.x, var_105_5.y, var_105_5.z)

				local var_105_6 = var_105_0.localEulerAngles

				var_105_6.z = 0
				var_105_6.x = 0
				var_105_0.localEulerAngles = var_105_6
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_105_7 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_7.x, var_105_7.y, var_105_7.z)

				local var_105_8 = var_105_0.localEulerAngles

				var_105_8.z = 0
				var_105_8.x = 0
				var_105_0.localEulerAngles = var_105_8
			end

			local var_105_9 = 0

			if var_105_9 < arg_102_1.time_ and arg_102_1.time_ <= var_105_9 + arg_105_0 then
				arg_102_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_105_10 = arg_102_1.actors_["10025ui_story"]
			local var_105_11 = 0

			if var_105_11 < arg_102_1.time_ and arg_102_1.time_ <= var_105_11 + arg_105_0 and not isNil(var_105_10) and arg_102_1.var_.characterEffect10025ui_story == nil then
				arg_102_1.var_.characterEffect10025ui_story = var_105_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_12 = 0.2

			if var_105_11 <= arg_102_1.time_ and arg_102_1.time_ < var_105_11 + var_105_12 and not isNil(var_105_10) then
				local var_105_13 = (arg_102_1.time_ - var_105_11) / var_105_12

				if arg_102_1.var_.characterEffect10025ui_story and not isNil(var_105_10) then
					local var_105_14 = Mathf.Lerp(0, 0.5, var_105_13)

					arg_102_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_102_1.var_.characterEffect10025ui_story.fillRatio = var_105_14
				end
			end

			if arg_102_1.time_ >= var_105_11 + var_105_12 and arg_102_1.time_ < var_105_11 + var_105_12 + arg_105_0 and not isNil(var_105_10) and arg_102_1.var_.characterEffect10025ui_story then
				local var_105_15 = 0.5

				arg_102_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_102_1.var_.characterEffect10025ui_story.fillRatio = var_105_15
			end

			local var_105_16 = 0

			if var_105_16 < arg_102_1.time_ and arg_102_1.time_ <= var_105_16 + arg_105_0 then
				arg_102_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			local var_105_17 = 0
			local var_105_18 = 0.175

			if var_105_17 < arg_102_1.time_ and arg_102_1.time_ <= var_105_17 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_19 = arg_102_1:FormatText(StoryNameCfg[7].name)

				arg_102_1.leftNameTxt_.text = var_105_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_20 = arg_102_1:GetWordFromCfg(116071025)
				local var_105_21 = arg_102_1:FormatText(var_105_20.content)

				arg_102_1.text_.text = var_105_21

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_22 = 7
				local var_105_23 = utf8.len(var_105_21)
				local var_105_24 = var_105_22 <= 0 and var_105_18 or var_105_18 * (var_105_23 / var_105_22)

				if var_105_24 > 0 and var_105_18 < var_105_24 then
					arg_102_1.talkMaxDuration = var_105_24

					if var_105_24 + var_105_17 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_24 + var_105_17
					end
				end

				arg_102_1.text_.text = var_105_21
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_25 = math.max(var_105_18, arg_102_1.talkMaxDuration)

			if var_105_17 <= arg_102_1.time_ and arg_102_1.time_ < var_105_17 + var_105_25 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_17) / var_105_25

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_17 + var_105_25 and arg_102_1.time_ < var_105_17 + var_105_25 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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

		arg_102_1:InitPlayNodeList()
	end,
	Play116071026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 116071026
		arg_106_1.duration_ = 3.7

		local var_106_0 = {
			zh = 3.7,
			ja = 2.766
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
				arg_106_0:Play116071027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["10025ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect10025ui_story == nil then
				arg_106_1.var_.characterEffect10025ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.2

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect10025ui_story and not isNil(var_109_0) then
					arg_106_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect10025ui_story then
				arg_106_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_109_4 = 0

			if var_109_4 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_1")
			end

			local var_109_5 = 0

			if var_109_5 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 then
				arg_106_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_109_6 = 0
			local var_109_7 = 0.2

			if var_109_6 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_8 = arg_106_1:FormatText(StoryNameCfg[328].name)

				arg_106_1.leftNameTxt_.text = var_109_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_9 = arg_106_1:GetWordFromCfg(116071026)
				local var_109_10 = arg_106_1:FormatText(var_109_9.content)

				arg_106_1.text_.text = var_109_10

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_11 = 8
				local var_109_12 = utf8.len(var_109_10)
				local var_109_13 = var_109_11 <= 0 and var_109_7 or var_109_7 * (var_109_12 / var_109_11)

				if var_109_13 > 0 and var_109_7 < var_109_13 then
					arg_106_1.talkMaxDuration = var_109_13

					if var_109_13 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_13 + var_109_6
					end
				end

				arg_106_1.text_.text = var_109_10
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071026", "story_v_out_116071.awb") ~= 0 then
					local var_109_14 = manager.audio:GetVoiceLength("story_v_out_116071", "116071026", "story_v_out_116071.awb") / 1000

					if var_109_14 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_14 + var_109_6
					end

					if var_109_9.prefab_name ~= "" and arg_106_1.actors_[var_109_9.prefab_name] ~= nil then
						local var_109_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_9.prefab_name].transform, "story_v_out_116071", "116071026", "story_v_out_116071.awb")

						arg_106_1:RecordAudio("116071026", var_109_15)
						arg_106_1:RecordAudio("116071026", var_109_15)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_116071", "116071026", "story_v_out_116071.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_116071", "116071026", "story_v_out_116071.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_16 = math.max(var_109_7, arg_106_1.talkMaxDuration)

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_16 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_6) / var_109_16

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_6 + var_109_16 and arg_106_1.time_ < var_109_6 + var_109_16 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play116071027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 116071027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play116071028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["10025ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect10025ui_story == nil then
				arg_110_1.var_.characterEffect10025ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.2

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect10025ui_story and not isNil(var_113_0) then
					local var_113_4 = Mathf.Lerp(0, 0.5, var_113_3)

					arg_110_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_110_1.var_.characterEffect10025ui_story.fillRatio = var_113_4
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect10025ui_story then
				local var_113_5 = 0.5

				arg_110_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_110_1.var_.characterEffect10025ui_story.fillRatio = var_113_5
			end

			local var_113_6 = 0
			local var_113_7 = 0.475

			if var_113_6 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_8 = arg_110_1:FormatText(StoryNameCfg[7].name)

				arg_110_1.leftNameTxt_.text = var_113_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_9 = arg_110_1:GetWordFromCfg(116071027)
				local var_113_10 = arg_110_1:FormatText(var_113_9.content)

				arg_110_1.text_.text = var_113_10

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_11 = 19
				local var_113_12 = utf8.len(var_113_10)
				local var_113_13 = var_113_11 <= 0 and var_113_7 or var_113_7 * (var_113_12 / var_113_11)

				if var_113_13 > 0 and var_113_7 < var_113_13 then
					arg_110_1.talkMaxDuration = var_113_13

					if var_113_13 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_13 + var_113_6
					end
				end

				arg_110_1.text_.text = var_113_10
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_14 = math.max(var_113_7, arg_110_1.talkMaxDuration)

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_14 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_6) / var_113_14

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_6 + var_113_14 and arg_110_1.time_ < var_113_6 + var_113_14 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play116071028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 116071028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play116071029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["10025ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect10025ui_story == nil then
				arg_114_1.var_.characterEffect10025ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.2

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect10025ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect10025ui_story then
				arg_114_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_117_4 = 0

			if var_117_4 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action438")
			end

			local var_117_5 = 0

			if var_117_5 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 then
				arg_114_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_117_6 = 0
			local var_117_7 = 0.325

			if var_117_6 < arg_114_1.time_ and arg_114_1.time_ <= var_117_6 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_8 = arg_114_1:GetWordFromCfg(116071028)
				local var_117_9 = arg_114_1:FormatText(var_117_8.content)

				arg_114_1.text_.text = var_117_9

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_10 = 13
				local var_117_11 = utf8.len(var_117_9)
				local var_117_12 = var_117_10 <= 0 and var_117_7 or var_117_7 * (var_117_11 / var_117_10)

				if var_117_12 > 0 and var_117_7 < var_117_12 then
					arg_114_1.talkMaxDuration = var_117_12

					if var_117_12 + var_117_6 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_12 + var_117_6
					end
				end

				arg_114_1.text_.text = var_117_9
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_13 = math.max(var_117_7, arg_114_1.talkMaxDuration)

			if var_117_6 <= arg_114_1.time_ and arg_114_1.time_ < var_117_6 + var_117_13 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_6) / var_117_13

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_6 + var_117_13 and arg_114_1.time_ < var_117_6 + var_117_13 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play116071029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 116071029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play116071030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["10025ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect10025ui_story == nil then
				arg_118_1.var_.characterEffect10025ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.2

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect10025ui_story and not isNil(var_121_0) then
					local var_121_4 = Mathf.Lerp(0, 0.5, var_121_3)

					arg_118_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_118_1.var_.characterEffect10025ui_story.fillRatio = var_121_4
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect10025ui_story then
				local var_121_5 = 0.5

				arg_118_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_118_1.var_.characterEffect10025ui_story.fillRatio = var_121_5
			end

			local var_121_6 = 0
			local var_121_7 = 0.475

			if var_121_6 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_8 = arg_118_1:FormatText(StoryNameCfg[7].name)

				arg_118_1.leftNameTxt_.text = var_121_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_9 = arg_118_1:GetWordFromCfg(116071029)
				local var_121_10 = arg_118_1:FormatText(var_121_9.content)

				arg_118_1.text_.text = var_121_10

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_11 = 19
				local var_121_12 = utf8.len(var_121_10)
				local var_121_13 = var_121_11 <= 0 and var_121_7 or var_121_7 * (var_121_12 / var_121_11)

				if var_121_13 > 0 and var_121_7 < var_121_13 then
					arg_118_1.talkMaxDuration = var_121_13

					if var_121_13 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_13 + var_121_6
					end
				end

				arg_118_1.text_.text = var_121_10
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_14 = math.max(var_121_7, arg_118_1.talkMaxDuration)

			if var_121_6 <= arg_118_1.time_ and arg_118_1.time_ < var_121_6 + var_121_14 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_6) / var_121_14

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_6 + var_121_14 and arg_118_1.time_ < var_121_6 + var_121_14 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play116071030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 116071030
		arg_122_1.duration_ = 7.1

		local var_122_0 = {
			zh = 4.1,
			ja = 7.1
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play116071031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["10025ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect10025ui_story == nil then
				arg_122_1.var_.characterEffect10025ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.2

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect10025ui_story and not isNil(var_125_0) then
					arg_122_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect10025ui_story then
				arg_122_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_125_4 = 0

			if var_125_4 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action485")
			end

			local var_125_5 = 0

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 then
				arg_122_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_125_6 = 0
			local var_125_7 = 0.275

			if var_125_6 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_8 = arg_122_1:FormatText(StoryNameCfg[328].name)

				arg_122_1.leftNameTxt_.text = var_125_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_9 = arg_122_1:GetWordFromCfg(116071030)
				local var_125_10 = arg_122_1:FormatText(var_125_9.content)

				arg_122_1.text_.text = var_125_10

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_11 = 11
				local var_125_12 = utf8.len(var_125_10)
				local var_125_13 = var_125_11 <= 0 and var_125_7 or var_125_7 * (var_125_12 / var_125_11)

				if var_125_13 > 0 and var_125_7 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_6
					end
				end

				arg_122_1.text_.text = var_125_10
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071030", "story_v_out_116071.awb") ~= 0 then
					local var_125_14 = manager.audio:GetVoiceLength("story_v_out_116071", "116071030", "story_v_out_116071.awb") / 1000

					if var_125_14 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_6
					end

					if var_125_9.prefab_name ~= "" and arg_122_1.actors_[var_125_9.prefab_name] ~= nil then
						local var_125_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_9.prefab_name].transform, "story_v_out_116071", "116071030", "story_v_out_116071.awb")

						arg_122_1:RecordAudio("116071030", var_125_15)
						arg_122_1:RecordAudio("116071030", var_125_15)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_116071", "116071030", "story_v_out_116071.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_116071", "116071030", "story_v_out_116071.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_16 = math.max(var_125_7, arg_122_1.talkMaxDuration)

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_16 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_6) / var_125_16

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_6 + var_125_16 and arg_122_1.time_ < var_125_6 + var_125_16 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play116071031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 116071031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play116071032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["10025ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect10025ui_story == nil then
				arg_126_1.var_.characterEffect10025ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.2

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect10025ui_story and not isNil(var_129_0) then
					local var_129_4 = Mathf.Lerp(0, 0.5, var_129_3)

					arg_126_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_126_1.var_.characterEffect10025ui_story.fillRatio = var_129_4
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect10025ui_story then
				local var_129_5 = 0.5

				arg_126_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_126_1.var_.characterEffect10025ui_story.fillRatio = var_129_5
			end

			local var_129_6 = 0
			local var_129_7 = 1

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_8 = arg_126_1:FormatText(StoryNameCfg[7].name)

				arg_126_1.leftNameTxt_.text = var_129_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_9 = arg_126_1:GetWordFromCfg(116071031)
				local var_129_10 = arg_126_1:FormatText(var_129_9.content)

				arg_126_1.text_.text = var_129_10

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_11 = 40
				local var_129_12 = utf8.len(var_129_10)
				local var_129_13 = var_129_11 <= 0 and var_129_7 or var_129_7 * (var_129_12 / var_129_11)

				if var_129_13 > 0 and var_129_7 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_6
					end
				end

				arg_126_1.text_.text = var_129_10
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_14 = math.max(var_129_7, arg_126_1.talkMaxDuration)

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_14 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_6) / var_129_14

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_6 + var_129_14 and arg_126_1.time_ < var_129_6 + var_129_14 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play116071032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 116071032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play116071033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 0.725

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_2 = arg_130_1:GetWordFromCfg(116071032)
				local var_133_3 = arg_130_1:FormatText(var_133_2.content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 29
				local var_133_5 = utf8.len(var_133_3)
				local var_133_6 = var_133_4 <= 0 and var_133_1 or var_133_1 * (var_133_5 / var_133_4)

				if var_133_6 > 0 and var_133_1 < var_133_6 then
					arg_130_1.talkMaxDuration = var_133_6

					if var_133_6 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_7 and arg_130_1.time_ < var_133_0 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play116071033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 116071033
		arg_134_1.duration_ = 8

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play116071034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = "SK0110"

			if arg_134_1.bgs_[var_137_0] == nil then
				local var_137_1 = Object.Instantiate(arg_134_1.paintGo_)

				var_137_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_137_0)
				var_137_1.name = var_137_0
				var_137_1.transform.parent = arg_134_1.stage_.transform
				var_137_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_134_1.bgs_[var_137_0] = var_137_1
			end

			local var_137_2 = 2

			if var_137_2 < arg_134_1.time_ and arg_134_1.time_ <= var_137_2 + arg_137_0 then
				local var_137_3 = manager.ui.mainCamera.transform.localPosition
				local var_137_4 = Vector3.New(0, 0, 10) + Vector3.New(var_137_3.x, var_137_3.y, 0)
				local var_137_5 = arg_134_1.bgs_.SK0110

				var_137_5.transform.localPosition = var_137_4
				var_137_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_137_6 = var_137_5:GetComponent("SpriteRenderer")

				if var_137_6 and var_137_6.sprite then
					local var_137_7 = (var_137_5.transform.localPosition - var_137_3).z
					local var_137_8 = manager.ui.mainCameraCom_
					local var_137_9 = 2 * var_137_7 * Mathf.Tan(var_137_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_137_10 = var_137_9 * var_137_8.aspect
					local var_137_11 = var_137_6.sprite.bounds.size.x
					local var_137_12 = var_137_6.sprite.bounds.size.y
					local var_137_13 = var_137_10 / var_137_11
					local var_137_14 = var_137_9 / var_137_12
					local var_137_15 = var_137_14 < var_137_13 and var_137_13 or var_137_14

					var_137_5.transform.localScale = Vector3.New(var_137_15, var_137_15, 0)
				end

				for iter_137_0, iter_137_1 in pairs(arg_134_1.bgs_) do
					if iter_137_0 ~= "SK0110" then
						iter_137_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_137_16 = 0

			if var_137_16 < arg_134_1.time_ and arg_134_1.time_ <= var_137_16 + arg_137_0 then
				arg_134_1.mask_.enabled = true
				arg_134_1.mask_.raycastTarget = true

				arg_134_1:SetGaussion(false)
			end

			local var_137_17 = 2

			if var_137_16 <= arg_134_1.time_ and arg_134_1.time_ < var_137_16 + var_137_17 then
				local var_137_18 = (arg_134_1.time_ - var_137_16) / var_137_17
				local var_137_19 = Color.New(0, 0, 0)

				var_137_19.a = Mathf.Lerp(0, 1, var_137_18)
				arg_134_1.mask_.color = var_137_19
			end

			if arg_134_1.time_ >= var_137_16 + var_137_17 and arg_134_1.time_ < var_137_16 + var_137_17 + arg_137_0 then
				local var_137_20 = Color.New(0, 0, 0)

				var_137_20.a = 1
				arg_134_1.mask_.color = var_137_20
			end

			local var_137_21 = 2

			if var_137_21 < arg_134_1.time_ and arg_134_1.time_ <= var_137_21 + arg_137_0 then
				arg_134_1.mask_.enabled = true
				arg_134_1.mask_.raycastTarget = true

				arg_134_1:SetGaussion(false)
			end

			local var_137_22 = 2

			if var_137_21 <= arg_134_1.time_ and arg_134_1.time_ < var_137_21 + var_137_22 then
				local var_137_23 = (arg_134_1.time_ - var_137_21) / var_137_22
				local var_137_24 = Color.New(0, 0, 0)

				var_137_24.a = Mathf.Lerp(1, 0, var_137_23)
				arg_134_1.mask_.color = var_137_24
			end

			if arg_134_1.time_ >= var_137_21 + var_137_22 and arg_134_1.time_ < var_137_21 + var_137_22 + arg_137_0 then
				local var_137_25 = Color.New(0, 0, 0)
				local var_137_26 = 0

				arg_134_1.mask_.enabled = false
				var_137_25.a = var_137_26
				arg_134_1.mask_.color = var_137_25
			end

			local var_137_27 = arg_134_1.actors_["10025ui_story"].transform
			local var_137_28 = 1.966

			if var_137_28 < arg_134_1.time_ and arg_134_1.time_ <= var_137_28 + arg_137_0 then
				arg_134_1.var_.moveOldPos10025ui_story = var_137_27.localPosition
			end

			local var_137_29 = 0.001

			if var_137_28 <= arg_134_1.time_ and arg_134_1.time_ < var_137_28 + var_137_29 then
				local var_137_30 = (arg_134_1.time_ - var_137_28) / var_137_29
				local var_137_31 = Vector3.New(0, 100, 0)

				var_137_27.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos10025ui_story, var_137_31, var_137_30)

				local var_137_32 = manager.ui.mainCamera.transform.position - var_137_27.position

				var_137_27.forward = Vector3.New(var_137_32.x, var_137_32.y, var_137_32.z)

				local var_137_33 = var_137_27.localEulerAngles

				var_137_33.z = 0
				var_137_33.x = 0
				var_137_27.localEulerAngles = var_137_33
			end

			if arg_134_1.time_ >= var_137_28 + var_137_29 and arg_134_1.time_ < var_137_28 + var_137_29 + arg_137_0 then
				var_137_27.localPosition = Vector3.New(0, 100, 0)

				local var_137_34 = manager.ui.mainCamera.transform.position - var_137_27.position

				var_137_27.forward = Vector3.New(var_137_34.x, var_137_34.y, var_137_34.z)

				local var_137_35 = var_137_27.localEulerAngles

				var_137_35.z = 0
				var_137_35.x = 0
				var_137_27.localEulerAngles = var_137_35
			end

			local var_137_36 = arg_134_1.bgs_.SK0110.transform
			local var_137_37 = 2

			if var_137_37 < arg_134_1.time_ and arg_134_1.time_ <= var_137_37 + arg_137_0 then
				arg_134_1.var_.moveOldPosSK0110 = var_137_36.localPosition
			end

			local var_137_38 = 0.001

			if var_137_37 <= arg_134_1.time_ and arg_134_1.time_ < var_137_37 + var_137_38 then
				local var_137_39 = (arg_134_1.time_ - var_137_37) / var_137_38
				local var_137_40 = Vector3.New(0, 5, 5)

				var_137_36.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPosSK0110, var_137_40, var_137_39)
			end

			if arg_134_1.time_ >= var_137_37 + var_137_38 and arg_134_1.time_ < var_137_37 + var_137_38 + arg_137_0 then
				var_137_36.localPosition = Vector3.New(0, 5, 5)
			end

			local var_137_41 = arg_134_1.bgs_.SK0110.transform
			local var_137_42 = 2.034

			if var_137_42 < arg_134_1.time_ and arg_134_1.time_ <= var_137_42 + arg_137_0 then
				arg_134_1.var_.moveOldPosSK0110 = var_137_41.localPosition
			end

			local var_137_43 = 5

			if var_137_42 <= arg_134_1.time_ and arg_134_1.time_ < var_137_42 + var_137_43 then
				local var_137_44 = (arg_134_1.time_ - var_137_42) / var_137_43
				local var_137_45 = Vector3.New(0, 4.5, 5)

				var_137_41.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPosSK0110, var_137_45, var_137_44)
			end

			if arg_134_1.time_ >= var_137_42 + var_137_43 and arg_134_1.time_ < var_137_42 + var_137_43 + arg_137_0 then
				var_137_41.localPosition = Vector3.New(0, 4.5, 5)
			end

			local var_137_46 = 4

			if var_137_46 < arg_134_1.time_ and arg_134_1.time_ <= var_137_46 + arg_137_0 then
				arg_134_1.allBtn_.enabled = false
			end

			local var_137_47 = 3.034

			if arg_134_1.time_ >= var_137_46 + var_137_47 and arg_134_1.time_ < var_137_46 + var_137_47 + arg_137_0 then
				arg_134_1.allBtn_.enabled = true
			end

			local var_137_48 = 2.034

			if var_137_48 < arg_134_1.time_ and arg_134_1.time_ <= var_137_48 + arg_137_0 then
				arg_134_1.fswbg_:SetActive(true)
				arg_134_1.dialog_:SetActive(false)

				arg_134_1.fswtw_.percent = 0

				local var_137_49 = arg_134_1:GetWordFromCfg(116071033)
				local var_137_50 = arg_134_1:FormatText(var_137_49.content)

				arg_134_1.fswt_.text = var_137_50

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.fswt_)

				arg_134_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_134_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_134_1.fswtw_:SetDirty()

				arg_134_1.typewritterCharCountI18N = 0

				SetActive(arg_134_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_134_1:ShowNextGo(false)
			end

			local var_137_51 = 4

			if var_137_51 < arg_134_1.time_ and arg_134_1.time_ <= var_137_51 + arg_137_0 then
				arg_134_1.var_.oldValueTypewriter = arg_134_1.fswtw_.percent

				SetActive(arg_134_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_134_1:ShowNextGo(false)
			end

			local var_137_52 = 24
			local var_137_53 = 4
			local var_137_54 = arg_134_1:GetWordFromCfg(116071033)
			local var_137_55 = arg_134_1:FormatText(var_137_54.content)
			local var_137_56, var_137_57 = arg_134_1:GetPercentByPara(var_137_55, 1)

			if var_137_51 < arg_134_1.time_ and arg_134_1.time_ <= var_137_51 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0

				local var_137_58 = var_137_52 <= 0 and var_137_53 or var_137_53 * ((var_137_57 - arg_134_1.typewritterCharCountI18N) / var_137_52)

				if var_137_58 > 0 and var_137_53 < var_137_58 then
					arg_134_1.talkMaxDuration = var_137_58

					if var_137_58 + var_137_51 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_58 + var_137_51
					end
				end
			end

			local var_137_59 = 4
			local var_137_60 = math.max(var_137_59, arg_134_1.talkMaxDuration)

			if var_137_51 <= arg_134_1.time_ and arg_134_1.time_ < var_137_51 + var_137_60 then
				local var_137_61 = (arg_134_1.time_ - var_137_51) / var_137_60

				arg_134_1.fswtw_.percent = Mathf.Lerp(arg_134_1.var_.oldValueTypewriter, var_137_56, var_137_61)
				arg_134_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_134_1.fswtw_:SetDirty()
			end

			if arg_134_1.time_ >= var_137_51 + var_137_60 and arg_134_1.time_ < var_137_51 + var_137_60 + arg_137_0 then
				arg_134_1.fswtw_.percent = var_137_56

				arg_134_1.fswtw_:SetDirty()
				arg_134_1:ShowNextGo(true)

				arg_134_1.typewritterCharCountI18N = var_137_57
			end

			local var_137_62 = 4

			if var_137_62 < arg_134_1.time_ and arg_134_1.time_ <= var_137_62 + arg_137_0 then
				local var_137_63 = arg_134_1.fswbg_.transform:Find("textbox/adapt/content") or arg_134_1.fswbg_.transform:Find("textbox/content")
				local var_137_64 = arg_134_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_137_65 = var_137_63:GetComponent("Text")
				local var_137_66 = var_137_63:GetComponent("RectTransform")

				var_137_65.alignment = UnityEngine.TextAnchor.MiddleLeft
				var_137_66.offsetMin = Vector2.New(150, 250)
				var_137_66.offsetMax = Vector2.New(0, 0)
			end

			local var_137_67 = 0
			local var_137_68 = 1

			if var_137_67 < arg_134_1.time_ and arg_134_1.time_ <= var_137_67 + arg_137_0 then
				local var_137_69 = "play"
				local var_137_70 = "music"

				arg_134_1:AudioAction(var_137_69, var_137_70, "ui_battle", "ui_battle_stopbgm", "")

				local var_137_71 = ""
				local var_137_72 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_137_72 ~= "" then
					if arg_134_1.bgmTxt_.text ~= var_137_72 and arg_134_1.bgmTxt_.text ~= "" then
						if arg_134_1.bgmTxt2_.text ~= "" then
							arg_134_1.bgmTxt_.text = arg_134_1.bgmTxt2_.text
						end

						arg_134_1.bgmTxt2_.text = var_137_72

						arg_134_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_134_1.bgmTxt_.text = var_137_72
						arg_134_1.bgmTxt2_.text = var_137_72
					end

					if arg_134_1.bgmTimer then
						arg_134_1.bgmTimer:Stop()

						arg_134_1.bgmTimer = nil
					end

					if arg_134_1.settingData.show_music_name == 1 then
						arg_134_1.musicController:SetSelectedState("show")
						arg_134_1.musicAnimator_:Play("open", 0, 0)

						if arg_134_1.settingData.music_time ~= 0 then
							arg_134_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_134_1.settingData.music_time), function()
								if arg_134_1 == nil or isNil(arg_134_1.bgmTxt_) then
									return
								end

								arg_134_1.musicController:SetSelectedState("hide")
								arg_134_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_137_73 = 2
			local var_137_74 = 1.5

			if var_137_73 < arg_134_1.time_ and arg_134_1.time_ <= var_137_73 + arg_137_0 then
				local var_137_75 = "play"
				local var_137_76 = "music"

				arg_134_1:AudioAction(var_137_75, var_137_76, "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				local var_137_77 = ""

				if var_137_77 ~= "" then
					if arg_134_1.bgmTxt_.text ~= var_137_77 and arg_134_1.bgmTxt_.text ~= "" then
						if arg_134_1.bgmTxt2_.text ~= "" then
							arg_134_1.bgmTxt_.text = arg_134_1.bgmTxt2_.text
						end

						arg_134_1.bgmTxt2_.text = var_137_77

						arg_134_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_134_1.bgmTxt_.text = var_137_77
						arg_134_1.bgmTxt2_.text = var_137_77
					end

					if arg_134_1.bgmTimer then
						arg_134_1.bgmTimer:Stop()

						arg_134_1.bgmTimer = nil
					end

					if arg_134_1.settingData.show_music_name == 1 then
						arg_134_1.musicController:SetSelectedState("show")
						arg_134_1.musicAnimator_:Play("open", 0, 0)

						if arg_134_1.settingData.music_time ~= 0 then
							arg_134_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_134_1.settingData.music_time), function()
								if arg_134_1 == nil or isNil(arg_134_1.bgmTxt_) then
									return
								end

								arg_134_1.musicController:SetSelectedState("hide")
								arg_134_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_137_78 = 2.2
			local var_137_79 = 0.733333333333333

			if var_137_78 < arg_134_1.time_ and arg_134_1.time_ <= var_137_78 + arg_137_0 then
				local var_137_80 = "play"
				local var_137_81 = "music"

				arg_134_1:AudioAction(var_137_80, var_137_81, "bgm_activity_1_6_story_story", "story", "bgm_activity_1_6_story_story.awb")

				local var_137_82 = ""
				local var_137_83 = MusicRecordCfg[97].musicName

				if var_137_83 ~= "" then
					if arg_134_1.bgmTxt_.text ~= var_137_83 and arg_134_1.bgmTxt_.text ~= "" then
						if arg_134_1.bgmTxt2_.text ~= "" then
							arg_134_1.bgmTxt_.text = arg_134_1.bgmTxt2_.text
						end

						arg_134_1.bgmTxt2_.text = var_137_83

						arg_134_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_134_1.bgmTxt_.text = var_137_83
						arg_134_1.bgmTxt2_.text = var_137_83
					end

					if arg_134_1.bgmTimer then
						arg_134_1.bgmTimer:Stop()

						arg_134_1.bgmTimer = nil
					end

					if arg_134_1.settingData.show_music_name == 1 then
						arg_134_1.musicController:SetSelectedState("show")
						arg_134_1.musicAnimator_:Play("open", 0, 0)

						if arg_134_1.settingData.music_time ~= 0 then
							arg_134_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_134_1.settingData.music_time), function()
								if arg_134_1 == nil or isNil(arg_134_1.bgmTxt_) then
									return
								end

								arg_134_1.musicController:SetSelectedState("hide")
								arg_134_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "SK0110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play116071034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 116071034
		arg_141_1.duration_ = 5.37

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play116071035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.var_.oldValueTypewriter = arg_141_1.fswtw_.percent

				SetActive(arg_141_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_141_1:ShowNextGo(false)
			end

			local var_144_1 = 43
			local var_144_2 = 5.375
			local var_144_3 = arg_141_1:GetWordFromCfg(116071033)
			local var_144_4 = arg_141_1:FormatText(var_144_3.content)
			local var_144_5, var_144_6 = arg_141_1:GetPercentByPara(var_144_4, 2)

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				local var_144_7 = var_144_1 <= 0 and var_144_2 or var_144_2 * ((var_144_6 - arg_141_1.typewritterCharCountI18N) / var_144_1)

				if var_144_7 > 0 and var_144_2 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_0
					end
				end
			end

			local var_144_8 = 5.375
			local var_144_9 = math.max(var_144_8, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_9 then
				local var_144_10 = (arg_141_1.time_ - var_144_0) / var_144_9

				arg_141_1.fswtw_.percent = Mathf.Lerp(arg_141_1.var_.oldValueTypewriter, var_144_5, var_144_10)
				arg_141_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_141_1.fswtw_:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_9 and arg_141_1.time_ < var_144_0 + var_144_9 + arg_144_0 then
				arg_141_1.fswtw_.percent = var_144_5

				arg_141_1.fswtw_:SetDirty()
				arg_141_1:ShowNextGo(true)

				arg_141_1.typewritterCharCountI18N = var_144_6
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play116071035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 116071035
		arg_145_1.duration_ = 3.5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play116071036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.var_.oldValueTypewriter = arg_145_1.fswtw_.percent

				SetActive(arg_145_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_145_1:ShowNextGo(false)
			end

			local var_148_1 = 21
			local var_148_2 = 3.5
			local var_148_3 = arg_145_1:GetWordFromCfg(116071033)
			local var_148_4 = arg_145_1:FormatText(var_148_3.content)
			local var_148_5, var_148_6 = arg_145_1:GetPercentByPara(var_148_4, 3)

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				local var_148_7 = var_148_1 <= 0 and var_148_2 or var_148_2 * ((var_148_6 - arg_145_1.typewritterCharCountI18N) / var_148_1)

				if var_148_7 > 0 and var_148_2 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_0
					end
				end
			end

			local var_148_8 = 3.5
			local var_148_9 = math.max(var_148_8, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_9 then
				local var_148_10 = (arg_145_1.time_ - var_148_0) / var_148_9

				arg_145_1.fswtw_.percent = Mathf.Lerp(arg_145_1.var_.oldValueTypewriter, var_148_5, var_148_10)
				arg_145_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_145_1.fswtw_:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_9 and arg_145_1.time_ < var_148_0 + var_148_9 + arg_148_0 then
				arg_145_1.fswtw_.percent = var_148_5

				arg_145_1.fswtw_:SetDirty()
				arg_145_1:ShowNextGo(true)

				arg_145_1.typewritterCharCountI18N = var_148_6
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play116071036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 116071036
		arg_149_1.duration_ = 1.3

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play116071037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.fswbg_:SetActive(true)
				arg_149_1.dialog_:SetActive(false)

				arg_149_1.fswtw_.percent = 0

				local var_152_1 = arg_149_1:GetWordFromCfg(116071036)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.fswt_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.fswt_)

				arg_149_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_149_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_149_1.fswtw_:SetDirty()

				arg_149_1.typewritterCharCountI18N = 0

				SetActive(arg_149_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_149_1:ShowNextGo(false)
			end

			local var_152_3 = 0.0166666666666667

			if var_152_3 < arg_149_1.time_ and arg_149_1.time_ <= var_152_3 + arg_152_0 then
				arg_149_1.var_.oldValueTypewriter = arg_149_1.fswtw_.percent

				SetActive(arg_149_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_149_1:ShowNextGo(false)
			end

			local var_152_4 = 5
			local var_152_5 = 0.833333333333333
			local var_152_6 = arg_149_1:GetWordFromCfg(116071036)
			local var_152_7 = arg_149_1:FormatText(var_152_6.content)
			local var_152_8, var_152_9 = arg_149_1:GetPercentByPara(var_152_7, 1)

			if var_152_3 < arg_149_1.time_ and arg_149_1.time_ <= var_152_3 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				local var_152_10 = var_152_4 <= 0 and var_152_5 or var_152_5 * ((var_152_9 - arg_149_1.typewritterCharCountI18N) / var_152_4)

				if var_152_10 > 0 and var_152_5 < var_152_10 then
					arg_149_1.talkMaxDuration = var_152_10

					if var_152_10 + var_152_3 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_3
					end
				end
			end

			local var_152_11 = 0.833333333333333
			local var_152_12 = math.max(var_152_11, arg_149_1.talkMaxDuration)

			if var_152_3 <= arg_149_1.time_ and arg_149_1.time_ < var_152_3 + var_152_12 then
				local var_152_13 = (arg_149_1.time_ - var_152_3) / var_152_12

				arg_149_1.fswtw_.percent = Mathf.Lerp(arg_149_1.var_.oldValueTypewriter, var_152_8, var_152_13)
				arg_149_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_149_1.fswtw_:SetDirty()
			end

			if arg_149_1.time_ >= var_152_3 + var_152_12 and arg_149_1.time_ < var_152_3 + var_152_12 + arg_152_0 then
				arg_149_1.fswtw_.percent = var_152_8

				arg_149_1.fswtw_:SetDirty()
				arg_149_1:ShowNextGo(true)

				arg_149_1.typewritterCharCountI18N = var_152_9
			end

			local var_152_14 = 0

			if var_152_14 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 then
				local var_152_15 = arg_149_1.fswbg_.transform:Find("textbox/adapt/content") or arg_149_1.fswbg_.transform:Find("textbox/content")
				local var_152_16 = arg_149_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_152_17 = var_152_15:GetComponent("Text")
				local var_152_18 = var_152_15:GetComponent("RectTransform")

				var_152_17.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_152_18.offsetMin = Vector2.New(0, 0)
				var_152_18.offsetMax = Vector2.New(1000, -400)
			end

			local var_152_19 = 0
			local var_152_20 = 1.302
			local var_152_21 = manager.audio:GetVoiceLength("story_v_out_116071", "116071036", "story_v_out_116071.awb") / 1000

			if var_152_21 > 0 and var_152_20 < var_152_21 and var_152_21 + var_152_19 > arg_149_1.duration_ then
				local var_152_22 = var_152_21

				arg_149_1.duration_ = var_152_21 + var_152_19
			end

			if var_152_19 < arg_149_1.time_ and arg_149_1.time_ <= var_152_19 + arg_152_0 then
				local var_152_23 = "play"
				local var_152_24 = "voice"

				arg_149_1:AudioAction(var_152_23, var_152_24, "story_v_out_116071", "116071036", "story_v_out_116071.awb")
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play116071037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 116071037
		arg_153_1.duration_ = 9.2

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play116071038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.fswbg_:SetActive(true)
				arg_153_1.dialog_:SetActive(false)

				arg_153_1.fswtw_.percent = 0

				local var_156_1 = arg_153_1:GetWordFromCfg(116071037)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.fswt_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.fswt_)

				arg_153_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_153_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_153_1.fswtw_:SetDirty()

				arg_153_1.typewritterCharCountI18N = 0

				SetActive(arg_153_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_153_1:ShowNextGo(false)
			end

			local var_156_3 = 0.0333333333333332

			if var_156_3 < arg_153_1.time_ and arg_153_1.time_ <= var_156_3 + arg_156_0 then
				arg_153_1.var_.oldValueTypewriter = arg_153_1.fswtw_.percent

				SetActive(arg_153_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_153_1:ShowNextGo(false)
			end

			local var_156_4 = 55
			local var_156_5 = 9.16666666666667
			local var_156_6 = arg_153_1:GetWordFromCfg(116071037)
			local var_156_7 = arg_153_1:FormatText(var_156_6.content)
			local var_156_8, var_156_9 = arg_153_1:GetPercentByPara(var_156_7, 2)

			if var_156_3 < arg_153_1.time_ and arg_153_1.time_ <= var_156_3 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				local var_156_10 = var_156_4 <= 0 and var_156_5 or var_156_5 * ((var_156_9 - arg_153_1.typewritterCharCountI18N) / var_156_4)

				if var_156_10 > 0 and var_156_5 < var_156_10 then
					arg_153_1.talkMaxDuration = var_156_10

					if var_156_10 + var_156_3 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_3
					end
				end
			end

			local var_156_11 = 9.16666666666667
			local var_156_12 = math.max(var_156_11, arg_153_1.talkMaxDuration)

			if var_156_3 <= arg_153_1.time_ and arg_153_1.time_ < var_156_3 + var_156_12 then
				local var_156_13 = (arg_153_1.time_ - var_156_3) / var_156_12

				arg_153_1.fswtw_.percent = Mathf.Lerp(arg_153_1.var_.oldValueTypewriter, var_156_8, var_156_13)
				arg_153_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_153_1.fswtw_:SetDirty()
			end

			if arg_153_1.time_ >= var_156_3 + var_156_12 and arg_153_1.time_ < var_156_3 + var_156_12 + arg_156_0 then
				arg_153_1.fswtw_.percent = var_156_8

				arg_153_1.fswtw_:SetDirty()
				arg_153_1:ShowNextGo(true)

				arg_153_1.typewritterCharCountI18N = var_156_9
			end

			local var_156_14 = 0

			if var_156_14 < arg_153_1.time_ and arg_153_1.time_ <= var_156_14 + arg_156_0 then
				local var_156_15 = arg_153_1.fswbg_.transform:Find("textbox/adapt/content") or arg_153_1.fswbg_.transform:Find("textbox/content")
				local var_156_16 = arg_153_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_156_17 = var_156_15:GetComponent("Text")
				local var_156_18 = var_156_15:GetComponent("RectTransform")

				var_156_17.alignment = UnityEngine.TextAnchor.MiddleLeft
				var_156_18.offsetMin = Vector2.New(150, 250)
				var_156_18.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play116071038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 116071038
		arg_157_1.duration_ = 6.67

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play116071039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.var_.oldValueTypewriter = arg_157_1.fswtw_.percent

				SetActive(arg_157_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_157_1:ShowNextGo(false)
			end

			local var_160_1 = 40
			local var_160_2 = 6.66666666666667
			local var_160_3 = arg_157_1:GetWordFromCfg(116071037)
			local var_160_4 = arg_157_1:FormatText(var_160_3.content)
			local var_160_5, var_160_6 = arg_157_1:GetPercentByPara(var_160_4, 3)

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				local var_160_7 = var_160_1 <= 0 and var_160_2 or var_160_2 * ((var_160_6 - arg_157_1.typewritterCharCountI18N) / var_160_1)

				if var_160_7 > 0 and var_160_2 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_0
					end
				end
			end

			local var_160_8 = 6.66666666666667
			local var_160_9 = math.max(var_160_8, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_9 then
				local var_160_10 = (arg_157_1.time_ - var_160_0) / var_160_9

				arg_157_1.fswtw_.percent = Mathf.Lerp(arg_157_1.var_.oldValueTypewriter, var_160_5, var_160_10)
				arg_157_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_157_1.fswtw_:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_9 and arg_157_1.time_ < var_160_0 + var_160_9 + arg_160_0 then
				arg_157_1.fswtw_.percent = var_160_5

				arg_157_1.fswtw_:SetDirty()
				arg_157_1:ShowNextGo(true)

				arg_157_1.typewritterCharCountI18N = var_160_6
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play116071039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 116071039
		arg_161_1.duration_ = 5.7

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play116071040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.fswbg_:SetActive(true)
				arg_161_1.dialog_:SetActive(false)

				arg_161_1.fswtw_.percent = 0

				local var_164_1 = arg_161_1:GetWordFromCfg(116071039)
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

			local var_164_3 = 0.0333333333333332

			if var_164_3 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 then
				arg_161_1.var_.oldValueTypewriter = arg_161_1.fswtw_.percent

				SetActive(arg_161_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_161_1:ShowNextGo(false)
			end

			local var_164_4 = 34
			local var_164_5 = 5.66666666666667
			local var_164_6 = arg_161_1:GetWordFromCfg(116071039)
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

			local var_164_11 = 5.66666666666667
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
	Play116071040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 116071040
		arg_165_1.duration_ = 4

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play116071041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.var_.oldValueTypewriter = arg_165_1.fswtw_.percent

				SetActive(arg_165_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_165_1:ShowNextGo(false)
			end

			local var_168_1 = 24
			local var_168_2 = 4
			local var_168_3 = arg_165_1:GetWordFromCfg(116071039)
			local var_168_4 = arg_165_1:FormatText(var_168_3.content)
			local var_168_5, var_168_6 = arg_165_1:GetPercentByPara(var_168_4, 2)

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				local var_168_7 = var_168_1 <= 0 and var_168_2 or var_168_2 * ((var_168_6 - arg_165_1.typewritterCharCountI18N) / var_168_1)

				if var_168_7 > 0 and var_168_2 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end
			end

			local var_168_8 = 4
			local var_168_9 = math.max(var_168_8, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_9 then
				local var_168_10 = (arg_165_1.time_ - var_168_0) / var_168_9

				arg_165_1.fswtw_.percent = Mathf.Lerp(arg_165_1.var_.oldValueTypewriter, var_168_5, var_168_10)
				arg_165_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_165_1.fswtw_:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_9 and arg_165_1.time_ < var_168_0 + var_168_9 + arg_168_0 then
				arg_165_1.fswtw_.percent = var_168_5

				arg_165_1.fswtw_:SetDirty()
				arg_165_1:ShowNextGo(true)

				arg_165_1.typewritterCharCountI18N = var_168_6
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play116071041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 116071041
		arg_169_1.duration_ = 4.67

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play116071042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.var_.oldValueTypewriter = arg_169_1.fswtw_.percent

				SetActive(arg_169_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_169_1:ShowNextGo(false)
			end

			local var_172_1 = 28
			local var_172_2 = 4.66666666666667
			local var_172_3 = arg_169_1:GetWordFromCfg(116071039)
			local var_172_4 = arg_169_1:FormatText(var_172_3.content)
			local var_172_5, var_172_6 = arg_169_1:GetPercentByPara(var_172_4, 3)

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				local var_172_7 = var_172_1 <= 0 and var_172_2 or var_172_2 * ((var_172_6 - arg_169_1.typewritterCharCountI18N) / var_172_1)

				if var_172_7 > 0 and var_172_2 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_0
					end
				end
			end

			local var_172_8 = 4.66666666666667
			local var_172_9 = math.max(var_172_8, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_9 then
				local var_172_10 = (arg_169_1.time_ - var_172_0) / var_172_9

				arg_169_1.fswtw_.percent = Mathf.Lerp(arg_169_1.var_.oldValueTypewriter, var_172_5, var_172_10)
				arg_169_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_169_1.fswtw_:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_9 and arg_169_1.time_ < var_172_0 + var_172_9 + arg_172_0 then
				arg_169_1.fswtw_.percent = var_172_5

				arg_169_1.fswtw_:SetDirty()
				arg_169_1:ShowNextGo(true)

				arg_169_1.typewritterCharCountI18N = var_172_6
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play116071042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 116071042
		arg_173_1.duration_ = 7

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play116071043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.bgs_.SK0110.transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPosSK0110 = var_176_0.localPosition
			end

			local var_176_2 = 5

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(0, 4, 5)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPosSK0110, var_176_4, var_176_3)
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0, 4, 5)
			end

			local var_176_5 = 0

			if var_176_5 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 then
				arg_173_1.allBtn_.enabled = false
			end

			local var_176_6 = 5

			if arg_173_1.time_ >= var_176_5 + var_176_6 and arg_173_1.time_ < var_176_5 + var_176_6 + arg_176_0 then
				arg_173_1.allBtn_.enabled = true
			end

			local var_176_7 = 0

			if var_176_7 < arg_173_1.time_ and arg_173_1.time_ <= var_176_7 + arg_176_0 then
				arg_173_1.var_.oldValueTypewriter = arg_173_1.fswtw_.percent

				SetActive(arg_173_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_173_1:ShowNextGo(false)
			end

			local var_176_8 = 42
			local var_176_9 = 7
			local var_176_10 = arg_173_1:GetWordFromCfg(116071039)
			local var_176_11 = arg_173_1:FormatText(var_176_10.content)
			local var_176_12, var_176_13 = arg_173_1:GetPercentByPara(var_176_11, 4)

			if var_176_7 < arg_173_1.time_ and arg_173_1.time_ <= var_176_7 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0

				local var_176_14 = var_176_8 <= 0 and var_176_9 or var_176_9 * ((var_176_13 - arg_173_1.typewritterCharCountI18N) / var_176_8)

				if var_176_14 > 0 and var_176_9 < var_176_14 then
					arg_173_1.talkMaxDuration = var_176_14

					if var_176_14 + var_176_7 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_7
					end
				end
			end

			local var_176_15 = 7
			local var_176_16 = math.max(var_176_15, arg_173_1.talkMaxDuration)

			if var_176_7 <= arg_173_1.time_ and arg_173_1.time_ < var_176_7 + var_176_16 then
				local var_176_17 = (arg_173_1.time_ - var_176_7) / var_176_16

				arg_173_1.fswtw_.percent = Mathf.Lerp(arg_173_1.var_.oldValueTypewriter, var_176_12, var_176_17)
				arg_173_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_173_1.fswtw_:SetDirty()
			end

			if arg_173_1.time_ >= var_176_7 + var_176_16 and arg_173_1.time_ < var_176_7 + var_176_16 + arg_176_0 then
				arg_173_1.fswtw_.percent = var_176_12

				arg_173_1.fswtw_:SetDirty()
				arg_173_1:ShowNextGo(true)

				arg_173_1.typewritterCharCountI18N = var_176_13
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play116071043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 116071043
		arg_177_1.duration_ = 5.19

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play116071044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.fswbg_:SetActive(true)
				arg_177_1.dialog_:SetActive(false)

				arg_177_1.fswtw_.percent = 0

				local var_180_1 = arg_177_1:GetWordFromCfg(116071043)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.fswt_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.fswt_)

				arg_177_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_177_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_177_1.fswtw_:SetDirty()

				arg_177_1.typewritterCharCountI18N = 0

				SetActive(arg_177_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_177_1:ShowNextGo(false)
			end

			local var_180_3 = 0.0166666666666667

			if var_180_3 < arg_177_1.time_ and arg_177_1.time_ <= var_180_3 + arg_180_0 then
				arg_177_1.var_.oldValueTypewriter = arg_177_1.fswtw_.percent

				SetActive(arg_177_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_177_1:ShowNextGo(false)
			end

			local var_180_4 = 13
			local var_180_5 = 2.16666666666667
			local var_180_6 = arg_177_1:GetWordFromCfg(116071043)
			local var_180_7 = arg_177_1:FormatText(var_180_6.content)
			local var_180_8, var_180_9 = arg_177_1:GetPercentByPara(var_180_7, 1)

			if var_180_3 < arg_177_1.time_ and arg_177_1.time_ <= var_180_3 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				local var_180_10 = var_180_4 <= 0 and var_180_5 or var_180_5 * ((var_180_9 - arg_177_1.typewritterCharCountI18N) / var_180_4)

				if var_180_10 > 0 and var_180_5 < var_180_10 then
					arg_177_1.talkMaxDuration = var_180_10

					if var_180_10 + var_180_3 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_3
					end
				end
			end

			local var_180_11 = 2.16666666666667
			local var_180_12 = math.max(var_180_11, arg_177_1.talkMaxDuration)

			if var_180_3 <= arg_177_1.time_ and arg_177_1.time_ < var_180_3 + var_180_12 then
				local var_180_13 = (arg_177_1.time_ - var_180_3) / var_180_12

				arg_177_1.fswtw_.percent = Mathf.Lerp(arg_177_1.var_.oldValueTypewriter, var_180_8, var_180_13)
				arg_177_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_177_1.fswtw_:SetDirty()
			end

			if arg_177_1.time_ >= var_180_3 + var_180_12 and arg_177_1.time_ < var_180_3 + var_180_12 + arg_180_0 then
				arg_177_1.fswtw_.percent = var_180_8

				arg_177_1.fswtw_:SetDirty()
				arg_177_1:ShowNextGo(true)

				arg_177_1.typewritterCharCountI18N = var_180_9
			end

			local var_180_14 = 0

			if var_180_14 < arg_177_1.time_ and arg_177_1.time_ <= var_180_14 + arg_180_0 then
				local var_180_15 = arg_177_1.fswbg_.transform:Find("textbox/adapt/content") or arg_177_1.fswbg_.transform:Find("textbox/content")
				local var_180_16 = arg_177_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_180_17 = var_180_15:GetComponent("Text")
				local var_180_18 = var_180_15:GetComponent("RectTransform")

				var_180_17.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_180_18.offsetMin = Vector2.New(0, 0)
				var_180_18.offsetMax = Vector2.New(1000, -400)
			end

			local var_180_19 = 0
			local var_180_20 = 5.192
			local var_180_21 = manager.audio:GetVoiceLength("story_v_out_116071", "116071043", "story_v_out_116071.awb") / 1000

			if var_180_21 > 0 and var_180_20 < var_180_21 and var_180_21 + var_180_19 > arg_177_1.duration_ then
				local var_180_22 = var_180_21

				arg_177_1.duration_ = var_180_21 + var_180_19
			end

			if var_180_19 < arg_177_1.time_ and arg_177_1.time_ <= var_180_19 + arg_180_0 then
				local var_180_23 = "play"
				local var_180_24 = "voice"

				arg_177_1:AudioAction(var_180_23, var_180_24, "story_v_out_116071", "116071043", "story_v_out_116071.awb")
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play116071044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 116071044
		arg_181_1.duration_ = 1.7

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play116071045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.fswbg_:SetActive(true)
				arg_181_1.dialog_:SetActive(false)

				arg_181_1.fswtw_.percent = 0

				local var_184_1 = arg_181_1:GetWordFromCfg(116071044)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.fswt_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.fswt_)

				arg_181_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_181_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_181_1.fswtw_:SetDirty()

				arg_181_1.typewritterCharCountI18N = 0

				SetActive(arg_181_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_181_1:ShowNextGo(false)
			end

			local var_184_3 = 0.0333333333333332

			if var_184_3 < arg_181_1.time_ and arg_181_1.time_ <= var_184_3 + arg_184_0 then
				arg_181_1.var_.oldValueTypewriter = arg_181_1.fswtw_.percent

				SetActive(arg_181_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_181_1:ShowNextGo(false)
			end

			local var_184_4 = 10
			local var_184_5 = 1.66666666666667
			local var_184_6 = arg_181_1:GetWordFromCfg(116071044)
			local var_184_7 = arg_181_1:FormatText(var_184_6.content)
			local var_184_8, var_184_9 = arg_181_1:GetPercentByPara(var_184_7, 1)

			if var_184_3 < arg_181_1.time_ and arg_181_1.time_ <= var_184_3 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0

				local var_184_10 = var_184_4 <= 0 and var_184_5 or var_184_5 * ((var_184_9 - arg_181_1.typewritterCharCountI18N) / var_184_4)

				if var_184_10 > 0 and var_184_5 < var_184_10 then
					arg_181_1.talkMaxDuration = var_184_10

					if var_184_10 + var_184_3 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_3
					end
				end
			end

			local var_184_11 = 1.66666666666667
			local var_184_12 = math.max(var_184_11, arg_181_1.talkMaxDuration)

			if var_184_3 <= arg_181_1.time_ and arg_181_1.time_ < var_184_3 + var_184_12 then
				local var_184_13 = (arg_181_1.time_ - var_184_3) / var_184_12

				arg_181_1.fswtw_.percent = Mathf.Lerp(arg_181_1.var_.oldValueTypewriter, var_184_8, var_184_13)
				arg_181_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_181_1.fswtw_:SetDirty()
			end

			if arg_181_1.time_ >= var_184_3 + var_184_12 and arg_181_1.time_ < var_184_3 + var_184_12 + arg_184_0 then
				arg_181_1.fswtw_.percent = var_184_8

				arg_181_1.fswtw_:SetDirty()
				arg_181_1:ShowNextGo(true)

				arg_181_1.typewritterCharCountI18N = var_184_9
			end

			local var_184_14 = 0

			if var_184_14 < arg_181_1.time_ and arg_181_1.time_ <= var_184_14 + arg_184_0 then
				local var_184_15 = arg_181_1.fswbg_.transform:Find("textbox/adapt/content") or arg_181_1.fswbg_.transform:Find("textbox/content")
				local var_184_16 = arg_181_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_184_17 = var_184_15:GetComponent("Text")
				local var_184_18 = var_184_15:GetComponent("RectTransform")

				var_184_17.alignment = UnityEngine.TextAnchor.MiddleLeft
				var_184_18.offsetMin = Vector2.New(150, 250)
				var_184_18.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play116071045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 116071045
		arg_185_1.duration_ = 9.5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play116071046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.bgs_.SK0110.transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPosSK0110 = var_188_0.localPosition
			end

			local var_188_2 = 8

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2
				local var_188_4 = Vector3.New(0, 2, 5)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPosSK0110, var_188_4, var_188_3)
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(0, 2, 5)
			end

			local var_188_5 = 0

			if var_188_5 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1.allBtn_.enabled = false
			end

			local var_188_6 = 7.999999999999

			if arg_185_1.time_ >= var_188_5 + var_188_6 and arg_185_1.time_ < var_188_5 + var_188_6 + arg_188_0 then
				arg_185_1.allBtn_.enabled = true
			end

			local var_188_7 = 0

			if var_188_7 < arg_185_1.time_ and arg_185_1.time_ <= var_188_7 + arg_188_0 then
				arg_185_1.var_.oldValueTypewriter = arg_185_1.fswtw_.percent

				SetActive(arg_185_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_185_1:ShowNextGo(false)
			end

			local var_188_8 = 57
			local var_188_9 = 9.5
			local var_188_10 = arg_185_1:GetWordFromCfg(116071044)
			local var_188_11 = arg_185_1:FormatText(var_188_10.content)
			local var_188_12, var_188_13 = arg_185_1:GetPercentByPara(var_188_11, 3)

			if var_188_7 < arg_185_1.time_ and arg_185_1.time_ <= var_188_7 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				local var_188_14 = var_188_8 <= 0 and var_188_9 or var_188_9 * ((var_188_13 - arg_185_1.typewritterCharCountI18N) / var_188_8)

				if var_188_14 > 0 and var_188_9 < var_188_14 then
					arg_185_1.talkMaxDuration = var_188_14

					if var_188_14 + var_188_7 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_7
					end
				end
			end

			local var_188_15 = 9.5
			local var_188_16 = math.max(var_188_15, arg_185_1.talkMaxDuration)

			if var_188_7 <= arg_185_1.time_ and arg_185_1.time_ < var_188_7 + var_188_16 then
				local var_188_17 = (arg_185_1.time_ - var_188_7) / var_188_16

				arg_185_1.fswtw_.percent = Mathf.Lerp(arg_185_1.var_.oldValueTypewriter, var_188_12, var_188_17)
				arg_185_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_185_1.fswtw_:SetDirty()
			end

			if arg_185_1.time_ >= var_188_7 + var_188_16 and arg_185_1.time_ < var_188_7 + var_188_16 + arg_188_0 then
				arg_185_1.fswtw_.percent = var_188_12

				arg_185_1.fswtw_:SetDirty()
				arg_185_1:ShowNextGo(true)

				arg_185_1.typewritterCharCountI18N = var_188_13
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 8,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play116071046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 116071046
		arg_189_1.duration_ = 8.52

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play116071047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = "SK0110b"

			if arg_189_1.bgs_[var_192_0] == nil then
				local var_192_1 = Object.Instantiate(arg_189_1.paintGo_)

				var_192_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_192_0)
				var_192_1.name = var_192_0
				var_192_1.transform.parent = arg_189_1.stage_.transform
				var_192_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.bgs_[var_192_0] = var_192_1
			end

			local var_192_2 = 0

			if var_192_2 < arg_189_1.time_ and arg_189_1.time_ <= var_192_2 + arg_192_0 then
				local var_192_3 = manager.ui.mainCamera.transform.localPosition
				local var_192_4 = Vector3.New(0, 0, 10) + Vector3.New(var_192_3.x, var_192_3.y, 0)
				local var_192_5 = arg_189_1.bgs_.SK0110b

				var_192_5.transform.localPosition = var_192_4
				var_192_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_192_6 = var_192_5:GetComponent("SpriteRenderer")

				if var_192_6 and var_192_6.sprite then
					local var_192_7 = (var_192_5.transform.localPosition - var_192_3).z
					local var_192_8 = manager.ui.mainCameraCom_
					local var_192_9 = 2 * var_192_7 * Mathf.Tan(var_192_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_192_10 = var_192_9 * var_192_8.aspect
					local var_192_11 = var_192_6.sprite.bounds.size.x
					local var_192_12 = var_192_6.sprite.bounds.size.y
					local var_192_13 = var_192_10 / var_192_11
					local var_192_14 = var_192_9 / var_192_12
					local var_192_15 = var_192_14 < var_192_13 and var_192_13 or var_192_14

					var_192_5.transform.localScale = Vector3.New(var_192_15, var_192_15, 0)
				end

				for iter_192_0, iter_192_1 in pairs(arg_189_1.bgs_) do
					if iter_192_0 ~= "SK0110b" then
						iter_192_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_192_16 = 0

			if var_192_16 < arg_189_1.time_ and arg_189_1.time_ <= var_192_16 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_17 = 2

			if var_192_16 <= arg_189_1.time_ and arg_189_1.time_ < var_192_16 + var_192_17 then
				local var_192_18 = (arg_189_1.time_ - var_192_16) / var_192_17
				local var_192_19 = Color.New(1, 1, 1)

				var_192_19.a = Mathf.Lerp(1, 0, var_192_18)
				arg_189_1.mask_.color = var_192_19
			end

			if arg_189_1.time_ >= var_192_16 + var_192_17 and arg_189_1.time_ < var_192_16 + var_192_17 + arg_192_0 then
				local var_192_20 = Color.New(1, 1, 1)
				local var_192_21 = 0

				arg_189_1.mask_.enabled = false
				var_192_20.a = var_192_21
				arg_189_1.mask_.color = var_192_20
			end

			local var_192_22 = 2
			local var_192_23 = 1

			if var_192_22 < arg_189_1.time_ and arg_189_1.time_ <= var_192_22 + arg_192_0 then
				local var_192_24 = "play"
				local var_192_25 = "effect"

				arg_189_1:AudioAction(var_192_24, var_192_25, "se_story_16", "se_story_16_thunder02", "")
			end

			local var_192_26 = arg_189_1.bgs_.SK0110b.transform
			local var_192_27 = 0

			if var_192_27 < arg_189_1.time_ and arg_189_1.time_ <= var_192_27 + arg_192_0 then
				arg_189_1.var_.moveOldPosSK0110b = var_192_26.localPosition
			end

			local var_192_28 = 0.001

			if var_192_27 <= arg_189_1.time_ and arg_189_1.time_ < var_192_27 + var_192_28 then
				local var_192_29 = (arg_189_1.time_ - var_192_27) / var_192_28
				local var_192_30 = Vector3.New(0, 2, 5)

				var_192_26.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPosSK0110b, var_192_30, var_192_29)
			end

			if arg_189_1.time_ >= var_192_27 + var_192_28 and arg_189_1.time_ < var_192_27 + var_192_28 + arg_192_0 then
				var_192_26.localPosition = Vector3.New(0, 2, 5)
			end

			local var_192_31 = 2.025

			if var_192_31 < arg_189_1.time_ and arg_189_1.time_ <= var_192_31 + arg_192_0 then
				arg_189_1.var_.oldValueTypewriter = arg_189_1.fswtw_.percent

				SetActive(arg_189_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_189_1:ShowNextGo(false)
			end

			local var_192_32 = 39
			local var_192_33 = 6.5
			local var_192_34 = arg_189_1:GetWordFromCfg(116071044)
			local var_192_35 = arg_189_1:FormatText(var_192_34.content)
			local var_192_36, var_192_37 = arg_189_1:GetPercentByPara(var_192_35, 4)

			if var_192_31 < arg_189_1.time_ and arg_189_1.time_ <= var_192_31 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				local var_192_38 = var_192_32 <= 0 and var_192_33 or var_192_33 * ((var_192_37 - arg_189_1.typewritterCharCountI18N) / var_192_32)

				if var_192_38 > 0 and var_192_33 < var_192_38 then
					arg_189_1.talkMaxDuration = var_192_38

					if var_192_38 + var_192_31 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_38 + var_192_31
					end
				end
			end

			local var_192_39 = 6.5
			local var_192_40 = math.max(var_192_39, arg_189_1.talkMaxDuration)

			if var_192_31 <= arg_189_1.time_ and arg_189_1.time_ < var_192_31 + var_192_40 then
				local var_192_41 = (arg_189_1.time_ - var_192_31) / var_192_40

				arg_189_1.fswtw_.percent = Mathf.Lerp(arg_189_1.var_.oldValueTypewriter, var_192_36, var_192_41)
				arg_189_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_189_1.fswtw_:SetDirty()
			end

			if arg_189_1.time_ >= var_192_31 + var_192_40 and arg_189_1.time_ < var_192_31 + var_192_40 + arg_192_0 then
				arg_189_1.fswtw_.percent = var_192_36

				arg_189_1.fswtw_:SetDirty()
				arg_189_1:ShowNextGo(true)

				arg_189_1.typewritterCharCountI18N = var_192_37
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0110b",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play116071047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 116071047
		arg_193_1.duration_ = 4.03

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play116071048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.fswbg_:SetActive(true)
				arg_193_1.dialog_:SetActive(false)

				arg_193_1.fswtw_.percent = 0

				local var_196_1 = arg_193_1:GetWordFromCfg(116071047)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.fswt_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.fswt_)

				arg_193_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_193_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_193_1.fswtw_:SetDirty()

				arg_193_1.typewritterCharCountI18N = 0

				SetActive(arg_193_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_193_1:ShowNextGo(false)
			end

			local var_196_3 = 0.0166666666666667

			if var_196_3 < arg_193_1.time_ and arg_193_1.time_ <= var_196_3 + arg_196_0 then
				arg_193_1.var_.oldValueTypewriter = arg_193_1.fswtw_.percent

				SetActive(arg_193_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_193_1:ShowNextGo(false)
			end

			local var_196_4 = 8
			local var_196_5 = 1.33333333333333
			local var_196_6 = arg_193_1:GetWordFromCfg(116071047)
			local var_196_7 = arg_193_1:FormatText(var_196_6.content)
			local var_196_8, var_196_9 = arg_193_1:GetPercentByPara(var_196_7, 1)

			if var_196_3 < arg_193_1.time_ and arg_193_1.time_ <= var_196_3 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				local var_196_10 = var_196_4 <= 0 and var_196_5 or var_196_5 * ((var_196_9 - arg_193_1.typewritterCharCountI18N) / var_196_4)

				if var_196_10 > 0 and var_196_5 < var_196_10 then
					arg_193_1.talkMaxDuration = var_196_10

					if var_196_10 + var_196_3 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_3
					end
				end
			end

			local var_196_11 = 1.33333333333333
			local var_196_12 = math.max(var_196_11, arg_193_1.talkMaxDuration)

			if var_196_3 <= arg_193_1.time_ and arg_193_1.time_ < var_196_3 + var_196_12 then
				local var_196_13 = (arg_193_1.time_ - var_196_3) / var_196_12

				arg_193_1.fswtw_.percent = Mathf.Lerp(arg_193_1.var_.oldValueTypewriter, var_196_8, var_196_13)
				arg_193_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_193_1.fswtw_:SetDirty()
			end

			if arg_193_1.time_ >= var_196_3 + var_196_12 and arg_193_1.time_ < var_196_3 + var_196_12 + arg_196_0 then
				arg_193_1.fswtw_.percent = var_196_8

				arg_193_1.fswtw_:SetDirty()
				arg_193_1:ShowNextGo(true)

				arg_193_1.typewritterCharCountI18N = var_196_9
			end

			local var_196_14 = 0

			if var_196_14 < arg_193_1.time_ and arg_193_1.time_ <= var_196_14 + arg_196_0 then
				local var_196_15 = arg_193_1.fswbg_.transform:Find("textbox/adapt/content") or arg_193_1.fswbg_.transform:Find("textbox/content")
				local var_196_16 = arg_193_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_196_17 = var_196_15:GetComponent("Text")
				local var_196_18 = var_196_15:GetComponent("RectTransform")

				var_196_17.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_196_18.offsetMin = Vector2.New(0, 0)
				var_196_18.offsetMax = Vector2.New(1000, -400)
			end

			local var_196_19 = 0
			local var_196_20 = 4.028
			local var_196_21 = manager.audio:GetVoiceLength("story_v_out_116071", "116071047", "story_v_out_116071.awb") / 1000

			if var_196_21 > 0 and var_196_20 < var_196_21 and var_196_21 + var_196_19 > arg_193_1.duration_ then
				local var_196_22 = var_196_21

				arg_193_1.duration_ = var_196_21 + var_196_19
			end

			if var_196_19 < arg_193_1.time_ and arg_193_1.time_ <= var_196_19 + arg_196_0 then
				local var_196_23 = "play"
				local var_196_24 = "voice"

				arg_193_1:AudioAction(var_196_23, var_196_24, "story_v_out_116071", "116071047", "story_v_out_116071.awb")
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play116071048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 116071048
		arg_197_1.duration_ = 5.56

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play116071049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.fswbg_:SetActive(true)
				arg_197_1.dialog_:SetActive(false)

				arg_197_1.fswtw_.percent = 0

				local var_200_1 = arg_197_1:GetWordFromCfg(116071048)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.fswt_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.fswt_)

				arg_197_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_197_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_197_1.fswtw_:SetDirty()

				arg_197_1.typewritterCharCountI18N = 0

				SetActive(arg_197_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_197_1:ShowNextGo(false)
			end

			local var_200_3 = 0.0166666666666667

			if var_200_3 < arg_197_1.time_ and arg_197_1.time_ <= var_200_3 + arg_200_0 then
				arg_197_1.var_.oldValueTypewriter = arg_197_1.fswtw_.percent

				SetActive(arg_197_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_197_1:ShowNextGo(false)
			end

			local var_200_4 = 11
			local var_200_5 = 1.83333333333333
			local var_200_6 = arg_197_1:GetWordFromCfg(116071048)
			local var_200_7 = arg_197_1:FormatText(var_200_6.content)
			local var_200_8, var_200_9 = arg_197_1:GetPercentByPara(var_200_7, 1)

			if var_200_3 < arg_197_1.time_ and arg_197_1.time_ <= var_200_3 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				local var_200_10 = var_200_4 <= 0 and var_200_5 or var_200_5 * ((var_200_9 - arg_197_1.typewritterCharCountI18N) / var_200_4)

				if var_200_10 > 0 and var_200_5 < var_200_10 then
					arg_197_1.talkMaxDuration = var_200_10

					if var_200_10 + var_200_3 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_3
					end
				end
			end

			local var_200_11 = 1.83333333333333
			local var_200_12 = math.max(var_200_11, arg_197_1.talkMaxDuration)

			if var_200_3 <= arg_197_1.time_ and arg_197_1.time_ < var_200_3 + var_200_12 then
				local var_200_13 = (arg_197_1.time_ - var_200_3) / var_200_12

				arg_197_1.fswtw_.percent = Mathf.Lerp(arg_197_1.var_.oldValueTypewriter, var_200_8, var_200_13)
				arg_197_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_197_1.fswtw_:SetDirty()
			end

			if arg_197_1.time_ >= var_200_3 + var_200_12 and arg_197_1.time_ < var_200_3 + var_200_12 + arg_200_0 then
				arg_197_1.fswtw_.percent = var_200_8

				arg_197_1.fswtw_:SetDirty()
				arg_197_1:ShowNextGo(true)

				arg_197_1.typewritterCharCountI18N = var_200_9
			end

			local var_200_14 = 0
			local var_200_15 = 5.556
			local var_200_16 = manager.audio:GetVoiceLength("story_v_out_116071", "116071048", "story_v_out_116071.awb") / 1000

			if var_200_16 > 0 and var_200_15 < var_200_16 and var_200_16 + var_200_14 > arg_197_1.duration_ then
				local var_200_17 = var_200_16

				arg_197_1.duration_ = var_200_16 + var_200_14
			end

			if var_200_14 < arg_197_1.time_ and arg_197_1.time_ <= var_200_14 + arg_200_0 then
				local var_200_18 = "play"
				local var_200_19 = "voice"

				arg_197_1:AudioAction(var_200_18, var_200_19, "story_v_out_116071", "116071048", "story_v_out_116071.awb")
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play116071049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 116071049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play116071050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.fswbg_:SetActive(false)
				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_201_1:ShowNextGo(false)
			end

			local var_204_1 = 0
			local var_204_2 = 0.725

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				arg_201_1.dialog_:SetActive(true)

				arg_201_1.dialogCg_.alpha = 0

				local var_204_3 = LeanTween.value(arg_201_1.dialog_, 0, 1, 0.3)

				var_204_3:setOnUpdate(LuaHelper.FloatAction(function(arg_205_0)
					arg_201_1.dialogCg_.alpha = arg_205_0
				end))
				var_204_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_201_1.dialog_)
					var_204_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_201_1.duration_ = arg_201_1.duration_ + 0.3

				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_4 = arg_201_1:FormatText(StoryNameCfg[7].name)

				arg_201_1.leftNameTxt_.text = var_204_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_5 = arg_201_1:GetWordFromCfg(116071049)
				local var_204_6 = arg_201_1:FormatText(var_204_5.content)

				arg_201_1.text_.text = var_204_6

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_7 = 29
				local var_204_8 = utf8.len(var_204_6)
				local var_204_9 = var_204_7 <= 0 and var_204_2 or var_204_2 * (var_204_8 / var_204_7)

				if var_204_9 > 0 and var_204_2 < var_204_9 then
					arg_201_1.talkMaxDuration = var_204_9
					var_204_1 = var_204_1 + 0.3

					if var_204_9 + var_204_1 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_9 + var_204_1
					end
				end

				arg_201_1.text_.text = var_204_6
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = var_204_1 + 0.3
			local var_204_11 = math.max(var_204_2, arg_201_1.talkMaxDuration)

			if var_204_10 <= arg_201_1.time_ and arg_201_1.time_ < var_204_10 + var_204_11 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_10) / var_204_11

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_10 + var_204_11 and arg_201_1.time_ < var_204_10 + var_204_11 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play116071050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 116071050
		arg_207_1.duration_ = 9

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play116071051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = "ST01a"

			if arg_207_1.bgs_[var_210_0] == nil then
				local var_210_1 = Object.Instantiate(arg_207_1.paintGo_)

				var_210_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_210_0)
				var_210_1.name = var_210_0
				var_210_1.transform.parent = arg_207_1.stage_.transform
				var_210_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.bgs_[var_210_0] = var_210_1
			end

			local var_210_2 = 2

			if var_210_2 < arg_207_1.time_ and arg_207_1.time_ <= var_210_2 + arg_210_0 then
				local var_210_3 = manager.ui.mainCamera.transform.localPosition
				local var_210_4 = Vector3.New(0, 0, 10) + Vector3.New(var_210_3.x, var_210_3.y, 0)
				local var_210_5 = arg_207_1.bgs_.ST01a

				var_210_5.transform.localPosition = var_210_4
				var_210_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_6 = var_210_5:GetComponent("SpriteRenderer")

				if var_210_6 and var_210_6.sprite then
					local var_210_7 = (var_210_5.transform.localPosition - var_210_3).z
					local var_210_8 = manager.ui.mainCameraCom_
					local var_210_9 = 2 * var_210_7 * Mathf.Tan(var_210_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_210_10 = var_210_9 * var_210_8.aspect
					local var_210_11 = var_210_6.sprite.bounds.size.x
					local var_210_12 = var_210_6.sprite.bounds.size.y
					local var_210_13 = var_210_10 / var_210_11
					local var_210_14 = var_210_9 / var_210_12
					local var_210_15 = var_210_14 < var_210_13 and var_210_13 or var_210_14

					var_210_5.transform.localScale = Vector3.New(var_210_15, var_210_15, 0)
				end

				for iter_210_0, iter_210_1 in pairs(arg_207_1.bgs_) do
					if iter_210_0 ~= "ST01a" then
						iter_210_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_210_16 = 0

			if var_210_16 < arg_207_1.time_ and arg_207_1.time_ <= var_210_16 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_17 = 2

			if var_210_16 <= arg_207_1.time_ and arg_207_1.time_ < var_210_16 + var_210_17 then
				local var_210_18 = (arg_207_1.time_ - var_210_16) / var_210_17
				local var_210_19 = Color.New(0, 0, 0)

				var_210_19.a = Mathf.Lerp(0, 1, var_210_18)
				arg_207_1.mask_.color = var_210_19
			end

			if arg_207_1.time_ >= var_210_16 + var_210_17 and arg_207_1.time_ < var_210_16 + var_210_17 + arg_210_0 then
				local var_210_20 = Color.New(0, 0, 0)

				var_210_20.a = 1
				arg_207_1.mask_.color = var_210_20
			end

			local var_210_21 = 2

			if var_210_21 < arg_207_1.time_ and arg_207_1.time_ <= var_210_21 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_22 = 2

			if var_210_21 <= arg_207_1.time_ and arg_207_1.time_ < var_210_21 + var_210_22 then
				local var_210_23 = (arg_207_1.time_ - var_210_21) / var_210_22
				local var_210_24 = Color.New(0, 0, 0)

				var_210_24.a = Mathf.Lerp(1, 0, var_210_23)
				arg_207_1.mask_.color = var_210_24
			end

			if arg_207_1.time_ >= var_210_21 + var_210_22 and arg_207_1.time_ < var_210_21 + var_210_22 + arg_210_0 then
				local var_210_25 = Color.New(0, 0, 0)
				local var_210_26 = 0

				arg_207_1.mask_.enabled = false
				var_210_25.a = var_210_26
				arg_207_1.mask_.color = var_210_25
			end

			if arg_207_1.frameCnt_ <= 1 then
				arg_207_1.dialog_:SetActive(false)
			end

			local var_210_27 = 4
			local var_210_28 = 0.6

			if var_210_27 < arg_207_1.time_ and arg_207_1.time_ <= var_210_27 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0

				arg_207_1.dialog_:SetActive(true)

				arg_207_1.dialogCg_.alpha = 0

				local var_210_29 = LeanTween.value(arg_207_1.dialog_, 0, 1, 0.3)

				var_210_29:setOnUpdate(LuaHelper.FloatAction(function(arg_211_0)
					arg_207_1.dialogCg_.alpha = arg_211_0
				end))
				var_210_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_207_1.dialog_)
					var_210_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_207_1.duration_ = arg_207_1.duration_ + 0.3

				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_30 = arg_207_1:GetWordFromCfg(116071050)
				local var_210_31 = arg_207_1:FormatText(var_210_30.content)

				arg_207_1.text_.text = var_210_31

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_32 = 24
				local var_210_33 = utf8.len(var_210_31)
				local var_210_34 = var_210_32 <= 0 and var_210_28 or var_210_28 * (var_210_33 / var_210_32)

				if var_210_34 > 0 and var_210_28 < var_210_34 then
					arg_207_1.talkMaxDuration = var_210_34
					var_210_27 = var_210_27 + 0.3

					if var_210_34 + var_210_27 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_34 + var_210_27
					end
				end

				arg_207_1.text_.text = var_210_31
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_35 = var_210_27 + 0.3
			local var_210_36 = math.max(var_210_28, arg_207_1.talkMaxDuration)

			if var_210_35 <= arg_207_1.time_ and arg_207_1.time_ < var_210_35 + var_210_36 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_35) / var_210_36

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_35 + var_210_36 and arg_207_1.time_ < var_210_35 + var_210_36 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play116071051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 116071051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play116071052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.775

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_2 = arg_213_1:GetWordFromCfg(116071051)
				local var_216_3 = arg_213_1:FormatText(var_216_2.content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 31
				local var_216_5 = utf8.len(var_216_3)
				local var_216_6 = var_216_4 <= 0 and var_216_1 or var_216_1 * (var_216_5 / var_216_4)

				if var_216_6 > 0 and var_216_1 < var_216_6 then
					arg_213_1.talkMaxDuration = var_216_6

					if var_216_6 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_7 and arg_213_1.time_ < var_216_0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play116071052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 116071052
		arg_217_1.duration_ = 5.07

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play116071053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 2

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.fswbg_:SetActive(true)
				arg_217_1.dialog_:SetActive(false)

				arg_217_1.fswtw_.percent = 0

				local var_220_1 = arg_217_1:GetWordFromCfg(116071052)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.fswt_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.fswt_)

				arg_217_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_217_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_217_1.fswtw_:SetDirty()

				arg_217_1.typewritterCharCountI18N = 0

				SetActive(arg_217_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_217_1:ShowNextGo(false)
			end

			local var_220_3 = 2.86666666666667

			if var_220_3 < arg_217_1.time_ and arg_217_1.time_ <= var_220_3 + arg_220_0 then
				arg_217_1.var_.oldValueTypewriter = arg_217_1.fswtw_.percent

				SetActive(arg_217_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_217_1:ShowNextGo(false)
			end

			local var_220_4 = 17
			local var_220_5 = 1.13333333333333
			local var_220_6 = arg_217_1:GetWordFromCfg(116071052)
			local var_220_7 = arg_217_1:FormatText(var_220_6.content)
			local var_220_8, var_220_9 = arg_217_1:GetPercentByPara(var_220_7, 1)

			if var_220_3 < arg_217_1.time_ and arg_217_1.time_ <= var_220_3 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0

				local var_220_10 = var_220_4 <= 0 and var_220_5 or var_220_5 * ((var_220_9 - arg_217_1.typewritterCharCountI18N) / var_220_4)

				if var_220_10 > 0 and var_220_5 < var_220_10 then
					arg_217_1.talkMaxDuration = var_220_10

					if var_220_10 + var_220_3 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_3
					end
				end
			end

			local var_220_11 = 1.13333333333333
			local var_220_12 = math.max(var_220_11, arg_217_1.talkMaxDuration)

			if var_220_3 <= arg_217_1.time_ and arg_217_1.time_ < var_220_3 + var_220_12 then
				local var_220_13 = (arg_217_1.time_ - var_220_3) / var_220_12

				arg_217_1.fswtw_.percent = Mathf.Lerp(arg_217_1.var_.oldValueTypewriter, var_220_8, var_220_13)
				arg_217_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_217_1.fswtw_:SetDirty()
			end

			if arg_217_1.time_ >= var_220_3 + var_220_12 and arg_217_1.time_ < var_220_3 + var_220_12 + arg_220_0 then
				arg_217_1.fswtw_.percent = var_220_8

				arg_217_1.fswtw_:SetDirty()
				arg_217_1:ShowNextGo(true)

				arg_217_1.typewritterCharCountI18N = var_220_9
			end

			local var_220_14 = 2.85

			if var_220_14 < arg_217_1.time_ and arg_217_1.time_ <= var_220_14 + arg_220_0 then
				local var_220_15 = arg_217_1.fswbg_.transform:Find("textbox/adapt/content") or arg_217_1.fswbg_.transform:Find("textbox/content")
				local var_220_16 = arg_217_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_220_17 = var_220_15:GetComponent("Text")
				local var_220_18 = var_220_15:GetComponent("RectTransform")

				var_220_17.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_220_18.offsetMin = Vector2.New(0, 0)
				var_220_18.offsetMax = Vector2.New(0, 0)
			end

			local var_220_19 = 0

			if var_220_19 < arg_217_1.time_ and arg_217_1.time_ <= var_220_19 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_20 = 2

			if var_220_19 <= arg_217_1.time_ and arg_217_1.time_ < var_220_19 + var_220_20 then
				local var_220_21 = (arg_217_1.time_ - var_220_19) / var_220_20
				local var_220_22 = Color.New(0, 0, 0)

				var_220_22.a = Mathf.Lerp(0, 1, var_220_21)
				arg_217_1.mask_.color = var_220_22
			end

			if arg_217_1.time_ >= var_220_19 + var_220_20 and arg_217_1.time_ < var_220_19 + var_220_20 + arg_220_0 then
				local var_220_23 = Color.New(0, 0, 0)

				var_220_23.a = 1
				arg_217_1.mask_.color = var_220_23
			end

			local var_220_24 = 2

			if var_220_24 < arg_217_1.time_ and arg_217_1.time_ <= var_220_24 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_25 = 2

			if var_220_24 <= arg_217_1.time_ and arg_217_1.time_ < var_220_24 + var_220_25 then
				local var_220_26 = (arg_217_1.time_ - var_220_24) / var_220_25
				local var_220_27 = Color.New(0, 0, 0)

				var_220_27.a = Mathf.Lerp(1, 0, var_220_26)
				arg_217_1.mask_.color = var_220_27
			end

			if arg_217_1.time_ >= var_220_24 + var_220_25 and arg_217_1.time_ < var_220_24 + var_220_25 + arg_220_0 then
				local var_220_28 = Color.New(0, 0, 0)
				local var_220_29 = 0

				arg_217_1.mask_.enabled = false
				var_220_28.a = var_220_29
				arg_217_1.mask_.color = var_220_28
			end

			local var_220_30 = "STblack"

			if arg_217_1.bgs_[var_220_30] == nil then
				local var_220_31 = Object.Instantiate(arg_217_1.paintGo_)

				var_220_31:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_220_30)
				var_220_31.name = var_220_30
				var_220_31.transform.parent = arg_217_1.stage_.transform
				var_220_31.transform.localPosition = Vector3.New(0, 100, 0)
				arg_217_1.bgs_[var_220_30] = var_220_31
			end

			local var_220_32 = 2

			if var_220_32 < arg_217_1.time_ and arg_217_1.time_ <= var_220_32 + arg_220_0 then
				local var_220_33 = manager.ui.mainCamera.transform.localPosition
				local var_220_34 = Vector3.New(0, 0, 10) + Vector3.New(var_220_33.x, var_220_33.y, 0)
				local var_220_35 = arg_217_1.bgs_.STblack

				var_220_35.transform.localPosition = var_220_34
				var_220_35.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_220_36 = var_220_35:GetComponent("SpriteRenderer")

				if var_220_36 and var_220_36.sprite then
					local var_220_37 = (var_220_35.transform.localPosition - var_220_33).z
					local var_220_38 = manager.ui.mainCameraCom_
					local var_220_39 = 2 * var_220_37 * Mathf.Tan(var_220_38.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_220_40 = var_220_39 * var_220_38.aspect
					local var_220_41 = var_220_36.sprite.bounds.size.x
					local var_220_42 = var_220_36.sprite.bounds.size.y
					local var_220_43 = var_220_40 / var_220_41
					local var_220_44 = var_220_39 / var_220_42
					local var_220_45 = var_220_44 < var_220_43 and var_220_43 or var_220_44

					var_220_35.transform.localScale = Vector3.New(var_220_45, var_220_45, 0)
				end

				for iter_220_0, iter_220_1 in pairs(arg_217_1.bgs_) do
					if iter_220_0 ~= "STblack" then
						iter_220_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play116071053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 116071053
		arg_221_1.duration_ = 1.82

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play116071054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.fswbg_:SetActive(true)
				arg_221_1.dialog_:SetActive(false)

				arg_221_1.fswtw_.percent = 0

				local var_224_1 = arg_221_1:GetWordFromCfg(116071053)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.fswt_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.fswt_)

				arg_221_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_221_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_221_1.fswtw_:SetDirty()

				arg_221_1.typewritterCharCountI18N = 0

				SetActive(arg_221_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_221_1:ShowNextGo(false)
			end

			local var_224_3 = 0.0166666666666667

			if var_224_3 < arg_221_1.time_ and arg_221_1.time_ <= var_224_3 + arg_224_0 then
				arg_221_1.var_.oldValueTypewriter = arg_221_1.fswtw_.percent

				SetActive(arg_221_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_221_1:ShowNextGo(false)
			end

			local var_224_4 = 27
			local var_224_5 = 1.8
			local var_224_6 = arg_221_1:GetWordFromCfg(116071053)
			local var_224_7 = arg_221_1:FormatText(var_224_6.content)
			local var_224_8, var_224_9 = arg_221_1:GetPercentByPara(var_224_7, 1)

			if var_224_3 < arg_221_1.time_ and arg_221_1.time_ <= var_224_3 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				local var_224_10 = var_224_4 <= 0 and var_224_5 or var_224_5 * ((var_224_9 - arg_221_1.typewritterCharCountI18N) / var_224_4)

				if var_224_10 > 0 and var_224_5 < var_224_10 then
					arg_221_1.talkMaxDuration = var_224_10

					if var_224_10 + var_224_3 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_3
					end
				end
			end

			local var_224_11 = 1.8
			local var_224_12 = math.max(var_224_11, arg_221_1.talkMaxDuration)

			if var_224_3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_3 + var_224_12 then
				local var_224_13 = (arg_221_1.time_ - var_224_3) / var_224_12

				arg_221_1.fswtw_.percent = Mathf.Lerp(arg_221_1.var_.oldValueTypewriter, var_224_8, var_224_13)
				arg_221_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_221_1.fswtw_:SetDirty()
			end

			if arg_221_1.time_ >= var_224_3 + var_224_12 and arg_221_1.time_ < var_224_3 + var_224_12 + arg_224_0 then
				arg_221_1.fswtw_.percent = var_224_8

				arg_221_1.fswtw_:SetDirty()
				arg_221_1:ShowNextGo(true)

				arg_221_1.typewritterCharCountI18N = var_224_9
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play116071054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 116071054
		arg_225_1.duration_ = 1.47

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
			arg_225_1.auto_ = false
		end

		function arg_225_1.playNext_(arg_227_0)
			arg_225_1.onStoryFinished_()
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.fswbg_:SetActive(true)
				arg_225_1.dialog_:SetActive(false)

				arg_225_1.fswtw_.percent = 0

				local var_228_1 = arg_225_1:GetWordFromCfg(116071054)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.fswt_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.fswt_)

				arg_225_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_225_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_225_1.fswtw_:SetDirty()

				arg_225_1.typewritterCharCountI18N = 0

				SetActive(arg_225_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_225_1:ShowNextGo(false)
			end

			local var_228_3 = 0.0166666666666667

			if var_228_3 < arg_225_1.time_ and arg_225_1.time_ <= var_228_3 + arg_228_0 then
				arg_225_1.var_.oldValueTypewriter = arg_225_1.fswtw_.percent

				SetActive(arg_225_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_225_1:ShowNextGo(false)
			end

			local var_228_4 = 19
			local var_228_5 = 1.26666666666667
			local var_228_6 = arg_225_1:GetWordFromCfg(116071054)
			local var_228_7 = arg_225_1:FormatText(var_228_6.content)
			local var_228_8, var_228_9 = arg_225_1:GetPercentByPara(var_228_7, 1)

			if var_228_3 < arg_225_1.time_ and arg_225_1.time_ <= var_228_3 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0

				local var_228_10 = var_228_4 <= 0 and var_228_5 or var_228_5 * ((var_228_9 - arg_225_1.typewritterCharCountI18N) / var_228_4)

				if var_228_10 > 0 and var_228_5 < var_228_10 then
					arg_225_1.talkMaxDuration = var_228_10

					if var_228_10 + var_228_3 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_3
					end
				end
			end

			local var_228_11 = 1.26666666666667
			local var_228_12 = math.max(var_228_11, arg_225_1.talkMaxDuration)

			if var_228_3 <= arg_225_1.time_ and arg_225_1.time_ < var_228_3 + var_228_12 then
				local var_228_13 = (arg_225_1.time_ - var_228_3) / var_228_12

				arg_225_1.fswtw_.percent = Mathf.Lerp(arg_225_1.var_.oldValueTypewriter, var_228_8, var_228_13)
				arg_225_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_225_1.fswtw_:SetDirty()
			end

			if arg_225_1.time_ >= var_228_3 + var_228_12 and arg_225_1.time_ < var_228_3 + var_228_12 + arg_228_0 then
				arg_225_1.fswtw_.percent = var_228_8

				arg_225_1.fswtw_:SetDirty()
				arg_225_1:ShowNextGo(true)

				arg_225_1.typewritterCharCountI18N = var_228_9
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST18",
		"TextureConfig/Background/SK0110",
		"TextureConfig/Background/SK0110b",
		"TextureConfig/Background/ST01a",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_116071.awb"
	}
}
