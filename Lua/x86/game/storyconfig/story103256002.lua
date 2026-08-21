return {
	Play325602001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325602001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325602002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J25f"

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
				local var_4_5 = arg_1_1.bgs_.J25f

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
					if iter_4_0 ~= "J25f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

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

			local var_4_24 = 0.1
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_121_00", "se_story_121_00_dooropen_loop", "")
			end

			local var_4_28 = 0
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_5_1_story_boss", "bgm_activity_5_1_story_boss", "bgm_activity_5_1_story_boss.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_5_1_story_boss", "bgm_activity_5_1_story_boss")

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
			local var_4_35 = 0.9

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
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

				local var_4_37 = arg_1_1:GetWordFromCfg(325602001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 36
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
	Play325602002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325602002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325602003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.125

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(325602002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 45
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_7 and arg_8_1.time_ < var_11_0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play325602003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325602003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325602004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.775

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(325602003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 71
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_7 and arg_12_1.time_ < var_15_0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325602004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325602004
		arg_16_1.duration_ = 2.2

		local var_16_0 = {
			zh = 2.2,
			ja = 1.999999999999
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325602005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "10170ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "10170ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "10170ui_story"), arg_16_1.stage_.transform)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

					var_19_3.enabled = true

					local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

					if var_19_4 then
						var_19_4:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_3.transform, false)

					arg_16_1.var_[var_19_0 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_0 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_0 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_5 = arg_16_1.actors_["10170ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos10170ui_story = var_19_5.localPosition

				local var_19_7 = GameObjectTools.GetOrAddComponent(var_19_5.gameObject, typeof(DynamicBoneHelper))

				if var_19_7 then
					var_19_7:EnableDynamicBone(false)
				end
			end

			local var_19_8 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_8 then
				local var_19_9 = (arg_16_1.time_ - var_19_6) / var_19_8
				local var_19_10 = Vector3.New(0, -1.03, -6.05)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10170ui_story, var_19_10, var_19_9)

				local var_19_11 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_11.x, var_19_11.y, var_19_11.z)

				local var_19_12 = var_19_5.localEulerAngles

				var_19_12.z = 0
				var_19_12.x = 0
				var_19_5.localEulerAngles = var_19_12
			end

			if arg_16_1.time_ >= var_19_6 + var_19_8 and arg_16_1.time_ < var_19_6 + var_19_8 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_19_13 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_13.x, var_19_13.y, var_19_13.z)

				local var_19_14 = var_19_5.localEulerAngles

				var_19_14.z = 0
				var_19_14.x = 0
				var_19_5.localEulerAngles = var_19_14

				local var_19_15 = GameObjectTools.GetOrAddComponent(var_19_5.gameObject, typeof(DynamicBoneHelper))

				if var_19_15 then
					var_19_15:EnableDynamicBone(true)
				end
			end

			local var_19_16 = arg_16_1.actors_["10170ui_story"]
			local var_19_17 = 0

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 and not isNil(var_19_16) and arg_16_1.var_.characterEffect10170ui_story == nil then
				arg_16_1.var_.characterEffect10170ui_story = var_19_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_18 = 0.200000002980232

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_18 and not isNil(var_19_16) then
				local var_19_19 = (arg_16_1.time_ - var_19_17) / var_19_18

				if arg_16_1.var_.characterEffect10170ui_story and not isNil(var_19_16) then
					arg_16_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_17 + var_19_18 and arg_16_1.time_ < var_19_17 + var_19_18 + arg_19_0 and not isNil(var_19_16) and arg_16_1.var_.characterEffect10170ui_story then
				arg_16_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_19_20 = 0

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_19_21 = 0

			if var_19_21 < arg_16_1.time_ and arg_16_1.time_ <= var_19_21 + arg_19_0 then
				arg_16_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_19_22 = 0
			local var_19_23 = 0.225

			if var_19_22 < arg_16_1.time_ and arg_16_1.time_ <= var_19_22 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_24 = arg_16_1:FormatText(StoryNameCfg[1450].name)

				arg_16_1.leftNameTxt_.text = var_19_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_25 = arg_16_1:GetWordFromCfg(325602004)
				local var_19_26 = arg_16_1:FormatText(var_19_25.content)

				arg_16_1.text_.text = var_19_26

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_27 = 9
				local var_19_28 = utf8.len(var_19_26)
				local var_19_29 = var_19_27 <= 0 and var_19_23 or var_19_23 * (var_19_28 / var_19_27)

				if var_19_29 > 0 and var_19_23 < var_19_29 then
					arg_16_1.talkMaxDuration = var_19_29

					if var_19_29 + var_19_22 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_29 + var_19_22
					end
				end

				arg_16_1.text_.text = var_19_26
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602004", "story_v_out_325602.awb") ~= 0 then
					local var_19_30 = manager.audio:GetVoiceLength("story_v_out_325602", "325602004", "story_v_out_325602.awb") / 1000

					if var_19_30 + var_19_22 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_30 + var_19_22
					end

					if var_19_25.prefab_name ~= "" and arg_16_1.actors_[var_19_25.prefab_name] ~= nil then
						local var_19_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_25.prefab_name].transform, "story_v_out_325602", "325602004", "story_v_out_325602.awb")

						arg_16_1:RecordAudio("325602004", var_19_31)
						arg_16_1:RecordAudio("325602004", var_19_31)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325602", "325602004", "story_v_out_325602.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325602", "325602004", "story_v_out_325602.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_32 = math.max(var_19_23, arg_16_1.talkMaxDuration)

			if var_19_22 <= arg_16_1.time_ and arg_16_1.time_ < var_19_22 + var_19_32 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_22) / var_19_32

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_22 + var_19_32 and arg_16_1.time_ < var_19_22 + var_19_32 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play325602005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325602005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325602006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["10170ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos10170ui_story = var_23_0.localPosition

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0.gameObject, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end
			end

			local var_23_3 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_3 then
				local var_23_4 = (arg_20_1.time_ - var_23_1) / var_23_3
				local var_23_5 = Vector3.New(0, 100, 0)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10170ui_story, var_23_5, var_23_4)

				local var_23_6 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_6.x, var_23_6.y, var_23_6.z)

				local var_23_7 = var_23_0.localEulerAngles

				var_23_7.z = 0
				var_23_7.x = 0
				var_23_0.localEulerAngles = var_23_7
			end

			if arg_20_1.time_ >= var_23_1 + var_23_3 and arg_20_1.time_ < var_23_1 + var_23_3 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0, 100, 0)

				local var_23_8 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_8.x, var_23_8.y, var_23_8.z)

				local var_23_9 = var_23_0.localEulerAngles

				var_23_9.z = 0
				var_23_9.x = 0
				var_23_0.localEulerAngles = var_23_9

				local var_23_10 = GameObjectTools.GetOrAddComponent(var_23_0.gameObject, typeof(DynamicBoneHelper))

				if var_23_10 then
					var_23_10:EnableDynamicBone(true)
				end
			end

			local var_23_11 = arg_20_1.actors_["10170ui_story"]
			local var_23_12 = 0

			if var_23_12 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect10170ui_story == nil then
				arg_20_1.var_.characterEffect10170ui_story = var_23_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_13 = 0.200000002980232

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_13 and not isNil(var_23_11) then
				local var_23_14 = (arg_20_1.time_ - var_23_12) / var_23_13

				if arg_20_1.var_.characterEffect10170ui_story and not isNil(var_23_11) then
					local var_23_15 = Mathf.Lerp(0, 0.5, var_23_14)

					arg_20_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_20_1.var_.characterEffect10170ui_story.fillRatio = var_23_15
				end
			end

			if arg_20_1.time_ >= var_23_12 + var_23_13 and arg_20_1.time_ < var_23_12 + var_23_13 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect10170ui_story then
				local var_23_16 = 0.5

				arg_20_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_20_1.var_.characterEffect10170ui_story.fillRatio = var_23_16
			end

			local var_23_17 = 0
			local var_23_18 = 0.725

			if var_23_17 < arg_20_1.time_ and arg_20_1.time_ <= var_23_17 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_19 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_20 = arg_20_1:GetWordFromCfg(325602005)
				local var_23_21 = arg_20_1:FormatText(var_23_20.content)

				arg_20_1.text_.text = var_23_21

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_22 = 29
				local var_23_23 = utf8.len(var_23_21)
				local var_23_24 = var_23_22 <= 0 and var_23_18 or var_23_18 * (var_23_23 / var_23_22)

				if var_23_24 > 0 and var_23_18 < var_23_24 then
					arg_20_1.talkMaxDuration = var_23_24

					if var_23_24 + var_23_17 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_24 + var_23_17
					end
				end

				arg_20_1.text_.text = var_23_21
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_25 = math.max(var_23_18, arg_20_1.talkMaxDuration)

			if var_23_17 <= arg_20_1.time_ and arg_20_1.time_ < var_23_17 + var_23_25 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_17) / var_23_25

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_17 + var_23_25 and arg_20_1.time_ < var_23_17 + var_23_25 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play325602006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325602006
		arg_24_1.duration_ = 3.17

		local var_24_0 = {
			zh = 2.4,
			ja = 3.166
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play325602007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["10170ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos10170ui_story = var_27_0.localPosition

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end
			end

			local var_27_3 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_3 then
				local var_27_4 = (arg_24_1.time_ - var_27_1) / var_27_3
				local var_27_5 = Vector3.New(0, -1.03, -6.05)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10170ui_story, var_27_5, var_27_4)

				local var_27_6 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_6.x, var_27_6.y, var_27_6.z)

				local var_27_7 = var_27_0.localEulerAngles

				var_27_7.z = 0
				var_27_7.x = 0
				var_27_0.localEulerAngles = var_27_7
			end

			if arg_24_1.time_ >= var_27_1 + var_27_3 and arg_24_1.time_ < var_27_1 + var_27_3 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_27_8 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_8.x, var_27_8.y, var_27_8.z)

				local var_27_9 = var_27_0.localEulerAngles

				var_27_9.z = 0
				var_27_9.x = 0
				var_27_0.localEulerAngles = var_27_9

				local var_27_10 = GameObjectTools.GetOrAddComponent(var_27_0.gameObject, typeof(DynamicBoneHelper))

				if var_27_10 then
					var_27_10:EnableDynamicBone(true)
				end
			end

			local var_27_11 = arg_24_1.actors_["10170ui_story"]
			local var_27_12 = 0

			if var_27_12 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 and not isNil(var_27_11) and arg_24_1.var_.characterEffect10170ui_story == nil then
				arg_24_1.var_.characterEffect10170ui_story = var_27_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_13 = 0.200000002980232

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_13 and not isNil(var_27_11) then
				local var_27_14 = (arg_24_1.time_ - var_27_12) / var_27_13

				if arg_24_1.var_.characterEffect10170ui_story and not isNil(var_27_11) then
					arg_24_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_12 + var_27_13 and arg_24_1.time_ < var_27_12 + var_27_13 + arg_27_0 and not isNil(var_27_11) and arg_24_1.var_.characterEffect10170ui_story then
				arg_24_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_27_15 = 0
			local var_27_16 = 0.25

			if var_27_15 < arg_24_1.time_ and arg_24_1.time_ <= var_27_15 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_17 = arg_24_1:FormatText(StoryNameCfg[1450].name)

				arg_24_1.leftNameTxt_.text = var_27_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_18 = arg_24_1:GetWordFromCfg(325602006)
				local var_27_19 = arg_24_1:FormatText(var_27_18.content)

				arg_24_1.text_.text = var_27_19

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_20 = 10
				local var_27_21 = utf8.len(var_27_19)
				local var_27_22 = var_27_20 <= 0 and var_27_16 or var_27_16 * (var_27_21 / var_27_20)

				if var_27_22 > 0 and var_27_16 < var_27_22 then
					arg_24_1.talkMaxDuration = var_27_22

					if var_27_22 + var_27_15 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_22 + var_27_15
					end
				end

				arg_24_1.text_.text = var_27_19
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602006", "story_v_out_325602.awb") ~= 0 then
					local var_27_23 = manager.audio:GetVoiceLength("story_v_out_325602", "325602006", "story_v_out_325602.awb") / 1000

					if var_27_23 + var_27_15 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_23 + var_27_15
					end

					if var_27_18.prefab_name ~= "" and arg_24_1.actors_[var_27_18.prefab_name] ~= nil then
						local var_27_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_18.prefab_name].transform, "story_v_out_325602", "325602006", "story_v_out_325602.awb")

						arg_24_1:RecordAudio("325602006", var_27_24)
						arg_24_1:RecordAudio("325602006", var_27_24)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325602", "325602006", "story_v_out_325602.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325602", "325602006", "story_v_out_325602.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_25 = math.max(var_27_16, arg_24_1.talkMaxDuration)

			if var_27_15 <= arg_24_1.time_ and arg_24_1.time_ < var_27_15 + var_27_25 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_15) / var_27_25

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_15 + var_27_25 and arg_24_1.time_ < var_27_15 + var_27_25 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play325602007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325602007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play325602008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["10170ui_story"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos10170ui_story = var_31_0.localPosition

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0.gameObject, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end
			end

			local var_31_3 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_3 then
				local var_31_4 = (arg_28_1.time_ - var_31_1) / var_31_3
				local var_31_5 = Vector3.New(0, 100, 0)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10170ui_story, var_31_5, var_31_4)

				local var_31_6 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_6.x, var_31_6.y, var_31_6.z)

				local var_31_7 = var_31_0.localEulerAngles

				var_31_7.z = 0
				var_31_7.x = 0
				var_31_0.localEulerAngles = var_31_7
			end

			if arg_28_1.time_ >= var_31_1 + var_31_3 and arg_28_1.time_ < var_31_1 + var_31_3 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(0, 100, 0)

				local var_31_8 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_8.x, var_31_8.y, var_31_8.z)

				local var_31_9 = var_31_0.localEulerAngles

				var_31_9.z = 0
				var_31_9.x = 0
				var_31_0.localEulerAngles = var_31_9

				local var_31_10 = GameObjectTools.GetOrAddComponent(var_31_0.gameObject, typeof(DynamicBoneHelper))

				if var_31_10 then
					var_31_10:EnableDynamicBone(true)
				end
			end

			local var_31_11 = arg_28_1.actors_["10170ui_story"]
			local var_31_12 = 0

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 and not isNil(var_31_11) and arg_28_1.var_.characterEffect10170ui_story == nil then
				arg_28_1.var_.characterEffect10170ui_story = var_31_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_13 = 0.200000002980232

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_13 and not isNil(var_31_11) then
				local var_31_14 = (arg_28_1.time_ - var_31_12) / var_31_13

				if arg_28_1.var_.characterEffect10170ui_story and not isNil(var_31_11) then
					local var_31_15 = Mathf.Lerp(0, 0.5, var_31_14)

					arg_28_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10170ui_story.fillRatio = var_31_15
				end
			end

			if arg_28_1.time_ >= var_31_12 + var_31_13 and arg_28_1.time_ < var_31_12 + var_31_13 + arg_31_0 and not isNil(var_31_11) and arg_28_1.var_.characterEffect10170ui_story then
				local var_31_16 = 0.5

				arg_28_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10170ui_story.fillRatio = var_31_16
			end

			local var_31_17 = 0
			local var_31_18 = 0.1

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_19 = arg_28_1:FormatText(StoryNameCfg[7].name)

				arg_28_1.leftNameTxt_.text = var_31_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_20 = arg_28_1:GetWordFromCfg(325602007)
				local var_31_21 = arg_28_1:FormatText(var_31_20.content)

				arg_28_1.text_.text = var_31_21

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_22 = 4
				local var_31_23 = utf8.len(var_31_21)
				local var_31_24 = var_31_22 <= 0 and var_31_18 or var_31_18 * (var_31_23 / var_31_22)

				if var_31_24 > 0 and var_31_18 < var_31_24 then
					arg_28_1.talkMaxDuration = var_31_24

					if var_31_24 + var_31_17 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_24 + var_31_17
					end
				end

				arg_28_1.text_.text = var_31_21
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_25 = math.max(var_31_18, arg_28_1.talkMaxDuration)

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_25 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_17) / var_31_25

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_17 + var_31_25 and arg_28_1.time_ < var_31_17 + var_31_25 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play325602008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325602008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325602009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.825

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_2 = arg_32_1:GetWordFromCfg(325602008)
				local var_35_3 = arg_32_1:FormatText(var_35_2.content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 33
				local var_35_5 = utf8.len(var_35_3)
				local var_35_6 = var_35_4 <= 0 and var_35_1 or var_35_1 * (var_35_5 / var_35_4)

				if var_35_6 > 0 and var_35_1 < var_35_6 then
					arg_32_1.talkMaxDuration = var_35_6

					if var_35_6 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_7 and arg_32_1.time_ < var_35_0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play325602009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325602009
		arg_36_1.duration_ = 7.27

		local var_36_0 = {
			zh = 6.5,
			ja = 7.266
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play325602010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = "J27f"

			if arg_36_1.bgs_[var_39_0] == nil then
				local var_39_1 = Object.Instantiate(arg_36_1.paintGo_)

				var_39_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_39_0)
				var_39_1.name = var_39_0
				var_39_1.transform.parent = arg_36_1.stage_.transform
				var_39_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.bgs_[var_39_0] = var_39_1
			end

			local var_39_2 = 1.13333333333333

			if var_39_2 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				local var_39_3 = manager.ui.mainCamera.transform.localPosition
				local var_39_4 = Vector3.New(0, 0, 10) + Vector3.New(var_39_3.x, var_39_3.y, 0)
				local var_39_5 = arg_36_1.bgs_.J27f

				var_39_5.transform.localPosition = var_39_4
				var_39_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_39_6 = var_39_5:GetComponent("SpriteRenderer")

				if var_39_6 and var_39_6.sprite then
					local var_39_7 = (var_39_5.transform.localPosition - var_39_3).z
					local var_39_8 = manager.ui.mainCameraCom_
					local var_39_9 = 2 * var_39_7 * Mathf.Tan(var_39_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_39_10 = var_39_9 * var_39_8.aspect
					local var_39_11 = var_39_6.sprite.bounds.size.x
					local var_39_12 = var_39_6.sprite.bounds.size.y
					local var_39_13 = var_39_10 / var_39_11
					local var_39_14 = var_39_9 / var_39_12
					local var_39_15 = var_39_14 < var_39_13 and var_39_13 or var_39_14

					var_39_5.transform.localScale = Vector3.New(var_39_15, var_39_15, 0)
				end

				for iter_39_0, iter_39_1 in pairs(arg_36_1.bgs_) do
					if iter_39_0 ~= "J27f" then
						iter_39_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_39_16 = 2

			if var_39_16 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			local var_39_17 = 0.3

			if arg_36_1.time_ >= var_39_16 + var_39_17 and arg_36_1.time_ < var_39_16 + var_39_17 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end

			local var_39_18 = manager.ui.mainCamera.transform
			local var_39_19 = 0

			if var_39_19 < arg_36_1.time_ and arg_36_1.time_ <= var_39_19 + arg_39_0 then
				local var_39_20 = arg_36_1.var_.effectshunjianhuiyi1
				local var_39_21
				local var_39_22 = var_39_18

				if not var_39_20 then
					var_39_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_39_22)
					var_39_20.name = "shunjianhuiyi1"
					arg_36_1.var_.effectshunjianhuiyi1 = var_39_20
				else
					var_39_20.transform:SetParent(var_39_22)
				end

				var_39_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_39_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_39_23 = arg_36_1.actors_["10170ui_story"].transform
			local var_39_24 = 0

			if var_39_24 < arg_36_1.time_ and arg_36_1.time_ <= var_39_24 + arg_39_0 then
				arg_36_1.var_.moveOldPos10170ui_story = var_39_23.localPosition

				local var_39_25 = GameObjectTools.GetOrAddComponent(var_39_23.gameObject, typeof(DynamicBoneHelper))

				if var_39_25 then
					var_39_25:EnableDynamicBone(false)
				end
			end

			local var_39_26 = 0.001

			if var_39_24 <= arg_36_1.time_ and arg_36_1.time_ < var_39_24 + var_39_26 then
				local var_39_27 = (arg_36_1.time_ - var_39_24) / var_39_26
				local var_39_28 = Vector3.New(0, 100, 0)

				var_39_23.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10170ui_story, var_39_28, var_39_27)

				local var_39_29 = manager.ui.mainCamera.transform.position - var_39_23.position

				var_39_23.forward = Vector3.New(var_39_29.x, var_39_29.y, var_39_29.z)

				local var_39_30 = var_39_23.localEulerAngles

				var_39_30.z = 0
				var_39_30.x = 0
				var_39_23.localEulerAngles = var_39_30
			end

			if arg_36_1.time_ >= var_39_24 + var_39_26 and arg_36_1.time_ < var_39_24 + var_39_26 + arg_39_0 then
				var_39_23.localPosition = Vector3.New(0, 100, 0)

				local var_39_31 = manager.ui.mainCamera.transform.position - var_39_23.position

				var_39_23.forward = Vector3.New(var_39_31.x, var_39_31.y, var_39_31.z)

				local var_39_32 = var_39_23.localEulerAngles

				var_39_32.z = 0
				var_39_32.x = 0
				var_39_23.localEulerAngles = var_39_32

				local var_39_33 = GameObjectTools.GetOrAddComponent(var_39_23.gameObject, typeof(DynamicBoneHelper))

				if var_39_33 then
					var_39_33:EnableDynamicBone(true)
				end
			end

			local var_39_34 = arg_36_1.actors_["10170ui_story"]
			local var_39_35 = 0

			if var_39_35 < arg_36_1.time_ and arg_36_1.time_ <= var_39_35 + arg_39_0 and not isNil(var_39_34) and arg_36_1.var_.characterEffect10170ui_story == nil then
				arg_36_1.var_.characterEffect10170ui_story = var_39_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_36 = 0.034000001847744

			if var_39_35 <= arg_36_1.time_ and arg_36_1.time_ < var_39_35 + var_39_36 and not isNil(var_39_34) then
				local var_39_37 = (arg_36_1.time_ - var_39_35) / var_39_36

				if arg_36_1.var_.characterEffect10170ui_story and not isNil(var_39_34) then
					arg_36_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_35 + var_39_36 and arg_36_1.time_ < var_39_35 + var_39_36 + arg_39_0 and not isNil(var_39_34) and arg_36_1.var_.characterEffect10170ui_story then
				arg_36_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_39_38 = arg_36_1.actors_["10170ui_story"].transform
			local var_39_39 = 1.7

			if var_39_39 < arg_36_1.time_ and arg_36_1.time_ <= var_39_39 + arg_39_0 then
				arg_36_1.var_.moveOldPos10170ui_story = var_39_38.localPosition

				local var_39_40 = GameObjectTools.GetOrAddComponent(var_39_38.gameObject, typeof(DynamicBoneHelper))

				if var_39_40 then
					var_39_40:EnableDynamicBone(false)
				end
			end

			local var_39_41 = 0.001

			if var_39_39 <= arg_36_1.time_ and arg_36_1.time_ < var_39_39 + var_39_41 then
				local var_39_42 = (arg_36_1.time_ - var_39_39) / var_39_41
				local var_39_43 = Vector3.New(0, -1.03, -6.05)

				var_39_38.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10170ui_story, var_39_43, var_39_42)

				local var_39_44 = manager.ui.mainCamera.transform.position - var_39_38.position

				var_39_38.forward = Vector3.New(var_39_44.x, var_39_44.y, var_39_44.z)

				local var_39_45 = var_39_38.localEulerAngles

				var_39_45.z = 0
				var_39_45.x = 0
				var_39_38.localEulerAngles = var_39_45
			end

			if arg_36_1.time_ >= var_39_39 + var_39_41 and arg_36_1.time_ < var_39_39 + var_39_41 + arg_39_0 then
				var_39_38.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_39_46 = manager.ui.mainCamera.transform.position - var_39_38.position

				var_39_38.forward = Vector3.New(var_39_46.x, var_39_46.y, var_39_46.z)

				local var_39_47 = var_39_38.localEulerAngles

				var_39_47.z = 0
				var_39_47.x = 0
				var_39_38.localEulerAngles = var_39_47

				local var_39_48 = GameObjectTools.GetOrAddComponent(var_39_38.gameObject, typeof(DynamicBoneHelper))

				if var_39_48 then
					var_39_48:EnableDynamicBone(true)
				end
			end

			local var_39_49 = arg_36_1.actors_["10170ui_story"]
			local var_39_50 = 1.7

			if var_39_50 < arg_36_1.time_ and arg_36_1.time_ <= var_39_50 + arg_39_0 and not isNil(var_39_49) and arg_36_1.var_.characterEffect10170ui_story == nil then
				arg_36_1.var_.characterEffect10170ui_story = var_39_49:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_51 = 0.200000002980232

			if var_39_50 <= arg_36_1.time_ and arg_36_1.time_ < var_39_50 + var_39_51 and not isNil(var_39_49) then
				local var_39_52 = (arg_36_1.time_ - var_39_50) / var_39_51

				if arg_36_1.var_.characterEffect10170ui_story and not isNil(var_39_49) then
					arg_36_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_50 + var_39_51 and arg_36_1.time_ < var_39_50 + var_39_51 + arg_39_0 and not isNil(var_39_49) and arg_36_1.var_.characterEffect10170ui_story then
				arg_36_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_39_53 = 1.7

			if var_39_53 < arg_36_1.time_ and arg_36_1.time_ <= var_39_53 + arg_39_0 then
				arg_36_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_39_54 = 1.7

			if var_39_54 < arg_36_1.time_ and arg_36_1.time_ <= var_39_54 + arg_39_0 then
				arg_36_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_39_55 = 1.11666666666667

			arg_36_1.isInRecall_ = true

			if var_39_55 < arg_36_1.time_ and arg_36_1.time_ <= var_39_55 + arg_39_0 then
				arg_36_1.screenFilterGo_:SetActive(true)

				arg_36_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_36_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_36_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_39_2, iter_39_3 in pairs(arg_36_1.actors_) do
					local var_39_56 = iter_39_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_39_4, iter_39_5 in ipairs(var_39_56) do
						if iter_39_5.color.r > 0.51 then
							iter_39_5.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_39_5.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_39_57 = 0.0166666666666667

			if var_39_55 <= arg_36_1.time_ and arg_36_1.time_ < var_39_55 + var_39_57 then
				local var_39_58 = (arg_36_1.time_ - var_39_55) / var_39_57

				arg_36_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_39_58)
			end

			if arg_36_1.time_ >= var_39_55 + var_39_57 and arg_36_1.time_ < var_39_55 + var_39_57 + arg_39_0 then
				arg_36_1.screenFilterEffect_.weight = 1
			end

			if arg_36_1.frameCnt_ <= 1 then
				arg_36_1.dialog_:SetActive(false)
			end

			local var_39_59 = 2
			local var_39_60 = 0.575

			if var_39_59 < arg_36_1.time_ and arg_36_1.time_ <= var_39_59 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				arg_36_1.dialog_:SetActive(true)

				arg_36_1.dialogCg_.alpha = 0

				local var_39_61 = LeanTween.value(arg_36_1.dialog_, 0, 1, 0.3)

				var_39_61:setOnUpdate(LuaHelper.FloatAction(function(arg_40_0)
					arg_36_1.dialogCg_.alpha = arg_40_0
				end))
				var_39_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_36_1.dialog_)
					var_39_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_36_1.duration_ = arg_36_1.duration_ + 0.3

				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_62 = arg_36_1:FormatText(StoryNameCfg[1450].name)

				arg_36_1.leftNameTxt_.text = var_39_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_63 = arg_36_1:GetWordFromCfg(325602009)
				local var_39_64 = arg_36_1:FormatText(var_39_63.content)

				arg_36_1.text_.text = var_39_64

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_65 = 23
				local var_39_66 = utf8.len(var_39_64)
				local var_39_67 = var_39_65 <= 0 and var_39_60 or var_39_60 * (var_39_66 / var_39_65)

				if var_39_67 > 0 and var_39_60 < var_39_67 then
					arg_36_1.talkMaxDuration = var_39_67
					var_39_59 = var_39_59 + 0.3

					if var_39_67 + var_39_59 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_67 + var_39_59
					end
				end

				arg_36_1.text_.text = var_39_64
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602009", "story_v_out_325602.awb") ~= 0 then
					local var_39_68 = manager.audio:GetVoiceLength("story_v_out_325602", "325602009", "story_v_out_325602.awb") / 1000

					if var_39_68 + var_39_59 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_68 + var_39_59
					end

					if var_39_63.prefab_name ~= "" and arg_36_1.actors_[var_39_63.prefab_name] ~= nil then
						local var_39_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_63.prefab_name].transform, "story_v_out_325602", "325602009", "story_v_out_325602.awb")

						arg_36_1:RecordAudio("325602009", var_39_69)
						arg_36_1:RecordAudio("325602009", var_39_69)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325602", "325602009", "story_v_out_325602.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325602", "325602009", "story_v_out_325602.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_70 = var_39_59 + 0.3
			local var_39_71 = math.max(var_39_60, arg_36_1.talkMaxDuration)

			if var_39_70 <= arg_36_1.time_ and arg_36_1.time_ < var_39_70 + var_39_71 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_70) / var_39_71

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_70 + var_39_71 and arg_36_1.time_ < var_39_70 + var_39_71 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play325602010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 325602010
		arg_42_1.duration_ = 6.83

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play325602011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0.983333333333333

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				local var_45_1 = manager.ui.mainCamera.transform.localPosition
				local var_45_2 = Vector3.New(0, 0, 10) + Vector3.New(var_45_1.x, var_45_1.y, 0)
				local var_45_3 = arg_42_1.bgs_.J25f

				var_45_3.transform.localPosition = var_45_2
				var_45_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_45_4 = var_45_3:GetComponent("SpriteRenderer")

				if var_45_4 and var_45_4.sprite then
					local var_45_5 = (var_45_3.transform.localPosition - var_45_1).z
					local var_45_6 = manager.ui.mainCameraCom_
					local var_45_7 = 2 * var_45_5 * Mathf.Tan(var_45_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_45_8 = var_45_7 * var_45_6.aspect
					local var_45_9 = var_45_4.sprite.bounds.size.x
					local var_45_10 = var_45_4.sprite.bounds.size.y
					local var_45_11 = var_45_8 / var_45_9
					local var_45_12 = var_45_7 / var_45_10
					local var_45_13 = var_45_12 < var_45_11 and var_45_11 or var_45_12

					var_45_3.transform.localScale = Vector3.New(var_45_13, var_45_13, 0)
				end

				for iter_45_0, iter_45_1 in pairs(arg_42_1.bgs_) do
					if iter_45_0 ~= "J25f" then
						iter_45_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_45_14 = 2

			if var_45_14 < arg_42_1.time_ and arg_42_1.time_ <= var_45_14 + arg_45_0 then
				arg_42_1.allBtn_.enabled = false
			end

			local var_45_15 = 0.3

			if arg_42_1.time_ >= var_45_14 + var_45_15 and arg_42_1.time_ < var_45_14 + var_45_15 + arg_45_0 then
				arg_42_1.allBtn_.enabled = true
			end

			local var_45_16 = arg_42_1.actors_["10170ui_story"].transform
			local var_45_17 = 0

			if var_45_17 < arg_42_1.time_ and arg_42_1.time_ <= var_45_17 + arg_45_0 then
				arg_42_1.var_.moveOldPos10170ui_story = var_45_16.localPosition

				local var_45_18 = GameObjectTools.GetOrAddComponent(var_45_16.gameObject, typeof(DynamicBoneHelper))

				if var_45_18 then
					var_45_18:EnableDynamicBone(false)
				end
			end

			local var_45_19 = 0.001

			if var_45_17 <= arg_42_1.time_ and arg_42_1.time_ < var_45_17 + var_45_19 then
				local var_45_20 = (arg_42_1.time_ - var_45_17) / var_45_19
				local var_45_21 = Vector3.New(0, 100, 0)

				var_45_16.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10170ui_story, var_45_21, var_45_20)

				local var_45_22 = manager.ui.mainCamera.transform.position - var_45_16.position

				var_45_16.forward = Vector3.New(var_45_22.x, var_45_22.y, var_45_22.z)

				local var_45_23 = var_45_16.localEulerAngles

				var_45_23.z = 0
				var_45_23.x = 0
				var_45_16.localEulerAngles = var_45_23
			end

			if arg_42_1.time_ >= var_45_17 + var_45_19 and arg_42_1.time_ < var_45_17 + var_45_19 + arg_45_0 then
				var_45_16.localPosition = Vector3.New(0, 100, 0)

				local var_45_24 = manager.ui.mainCamera.transform.position - var_45_16.position

				var_45_16.forward = Vector3.New(var_45_24.x, var_45_24.y, var_45_24.z)

				local var_45_25 = var_45_16.localEulerAngles

				var_45_25.z = 0
				var_45_25.x = 0
				var_45_16.localEulerAngles = var_45_25

				local var_45_26 = GameObjectTools.GetOrAddComponent(var_45_16.gameObject, typeof(DynamicBoneHelper))

				if var_45_26 then
					var_45_26:EnableDynamicBone(true)
				end
			end

			local var_45_27 = arg_42_1.actors_["10170ui_story"]
			local var_45_28 = 2

			if var_45_28 < arg_42_1.time_ and arg_42_1.time_ <= var_45_28 + arg_45_0 and not isNil(var_45_27) and arg_42_1.var_.characterEffect10170ui_story == nil then
				arg_42_1.var_.characterEffect10170ui_story = var_45_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_29 = 0.200000002980232

			if var_45_28 <= arg_42_1.time_ and arg_42_1.time_ < var_45_28 + var_45_29 and not isNil(var_45_27) then
				local var_45_30 = (arg_42_1.time_ - var_45_28) / var_45_29

				if arg_42_1.var_.characterEffect10170ui_story and not isNil(var_45_27) then
					local var_45_31 = Mathf.Lerp(0, 0.5, var_45_30)

					arg_42_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_42_1.var_.characterEffect10170ui_story.fillRatio = var_45_31
				end
			end

			if arg_42_1.time_ >= var_45_28 + var_45_29 and arg_42_1.time_ < var_45_28 + var_45_29 + arg_45_0 and not isNil(var_45_27) and arg_42_1.var_.characterEffect10170ui_story then
				local var_45_32 = 0.5

				arg_42_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_42_1.var_.characterEffect10170ui_story.fillRatio = var_45_32
			end

			local var_45_33 = manager.ui.mainCamera.transform
			local var_45_34 = 0

			if var_45_34 < arg_42_1.time_ and arg_42_1.time_ <= var_45_34 + arg_45_0 then
				local var_45_35 = arg_42_1.var_.effectshunjianhuiyi1
				local var_45_36
				local var_45_37 = var_45_33

				if not var_45_35 then
					var_45_35 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_45_37)
					var_45_35.name = "shunjianhuiyi1"
					arg_42_1.var_.effectshunjianhuiyi1 = var_45_35
				else
					var_45_35.transform:SetParent(var_45_37)
				end

				var_45_35.transform.localPosition = Vector3.New(0, 0, 0)
				var_45_35.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_45_38 = 0.983333333333333

			arg_42_1.isInRecall_ = false

			if var_45_38 < arg_42_1.time_ and arg_42_1.time_ <= var_45_38 + arg_45_0 then
				arg_42_1.screenFilterGo_:SetActive(false)

				for iter_45_2, iter_45_3 in pairs(arg_42_1.actors_) do
					local var_45_39 = iter_45_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_45_4, iter_45_5 in ipairs(var_45_39) do
						if iter_45_5.color.r > 0.51 then
							iter_45_5.color = Color.New(1, 1, 1)
						else
							iter_45_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_45_40 = 0.0166666666666667

			if var_45_38 <= arg_42_1.time_ and arg_42_1.time_ < var_45_38 + var_45_40 then
				local var_45_41 = (arg_42_1.time_ - var_45_38) / var_45_40

				arg_42_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_45_41)
			end

			if arg_42_1.time_ >= var_45_38 + var_45_40 and arg_42_1.time_ < var_45_38 + var_45_40 + arg_45_0 then
				arg_42_1.screenFilterEffect_.weight = 0
			end

			if arg_42_1.frameCnt_ <= 1 then
				arg_42_1.dialog_:SetActive(false)
			end

			local var_45_42 = 1.83333333333333
			local var_45_43 = 0.05

			if var_45_42 < arg_42_1.time_ and arg_42_1.time_ <= var_45_42 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				arg_42_1.dialog_:SetActive(true)

				arg_42_1.dialogCg_.alpha = 0

				local var_45_44 = LeanTween.value(arg_42_1.dialog_, 0, 1, 0.3)

				var_45_44:setOnUpdate(LuaHelper.FloatAction(function(arg_46_0)
					arg_42_1.dialogCg_.alpha = arg_46_0
				end))
				var_45_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_42_1.dialog_)
					var_45_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_42_1.duration_ = arg_42_1.duration_ + 0.3

				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_45 = arg_42_1:FormatText(StoryNameCfg[7].name)

				arg_42_1.leftNameTxt_.text = var_45_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_46 = arg_42_1:GetWordFromCfg(325602010)
				local var_45_47 = arg_42_1:FormatText(var_45_46.content)

				arg_42_1.text_.text = var_45_47

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_48 = 2
				local var_45_49 = utf8.len(var_45_47)
				local var_45_50 = var_45_48 <= 0 and var_45_43 or var_45_43 * (var_45_49 / var_45_48)

				if var_45_50 > 0 and var_45_43 < var_45_50 then
					arg_42_1.talkMaxDuration = var_45_50
					var_45_42 = var_45_42 + 0.3

					if var_45_50 + var_45_42 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_50 + var_45_42
					end
				end

				arg_42_1.text_.text = var_45_47
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_51 = var_45_42 + 0.3
			local var_45_52 = math.max(var_45_43, arg_42_1.talkMaxDuration)

			if var_45_51 <= arg_42_1.time_ and arg_42_1.time_ < var_45_51 + var_45_52 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_51) / var_45_52

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_51 + var_45_52 and arg_42_1.time_ < var_45_51 + var_45_52 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play325602011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325602011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play325602012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 1.375

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(325602011)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 55
				local var_51_5 = utf8.len(var_51_3)
				local var_51_6 = var_51_4 <= 0 and var_51_1 or var_51_1 * (var_51_5 / var_51_4)

				if var_51_6 > 0 and var_51_1 < var_51_6 then
					arg_48_1.talkMaxDuration = var_51_6

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_7 and arg_48_1.time_ < var_51_0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play325602012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325602012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play325602013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.15

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[7].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(325602012)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 6
				local var_55_6 = utf8.len(var_55_4)
				local var_55_7 = var_55_5 <= 0 and var_55_1 or var_55_1 * (var_55_6 / var_55_5)

				if var_55_7 > 0 and var_55_1 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_8 and arg_52_1.time_ < var_55_0 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play325602013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325602013
		arg_56_1.duration_ = 4.57

		local var_56_0 = {
			zh = 1.833,
			ja = 4.566
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play325602014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10170ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos10170ui_story = var_59_0.localPosition

				local var_59_2 = GameObjectTools.GetOrAddComponent(var_59_0.gameObject, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(false)
				end
			end

			local var_59_3 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_3 then
				local var_59_4 = (arg_56_1.time_ - var_59_1) / var_59_3
				local var_59_5 = Vector3.New(0, -1.03, -6.05)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10170ui_story, var_59_5, var_59_4)

				local var_59_6 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_6.x, var_59_6.y, var_59_6.z)

				local var_59_7 = var_59_0.localEulerAngles

				var_59_7.z = 0
				var_59_7.x = 0
				var_59_0.localEulerAngles = var_59_7
			end

			if arg_56_1.time_ >= var_59_1 + var_59_3 and arg_56_1.time_ < var_59_1 + var_59_3 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_59_8 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_8.x, var_59_8.y, var_59_8.z)

				local var_59_9 = var_59_0.localEulerAngles

				var_59_9.z = 0
				var_59_9.x = 0
				var_59_0.localEulerAngles = var_59_9

				local var_59_10 = GameObjectTools.GetOrAddComponent(var_59_0.gameObject, typeof(DynamicBoneHelper))

				if var_59_10 then
					var_59_10:EnableDynamicBone(true)
				end
			end

			local var_59_11 = arg_56_1.actors_["10170ui_story"]
			local var_59_12 = 0

			if var_59_12 < arg_56_1.time_ and arg_56_1.time_ <= var_59_12 + arg_59_0 and not isNil(var_59_11) and arg_56_1.var_.characterEffect10170ui_story == nil then
				arg_56_1.var_.characterEffect10170ui_story = var_59_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_13 = 0.200000002980232

			if var_59_12 <= arg_56_1.time_ and arg_56_1.time_ < var_59_12 + var_59_13 and not isNil(var_59_11) then
				local var_59_14 = (arg_56_1.time_ - var_59_12) / var_59_13

				if arg_56_1.var_.characterEffect10170ui_story and not isNil(var_59_11) then
					arg_56_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_12 + var_59_13 and arg_56_1.time_ < var_59_12 + var_59_13 + arg_59_0 and not isNil(var_59_11) and arg_56_1.var_.characterEffect10170ui_story then
				arg_56_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_59_15 = 0
			local var_59_16 = 0.15

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_17 = arg_56_1:FormatText(StoryNameCfg[1450].name)

				arg_56_1.leftNameTxt_.text = var_59_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_18 = arg_56_1:GetWordFromCfg(325602013)
				local var_59_19 = arg_56_1:FormatText(var_59_18.content)

				arg_56_1.text_.text = var_59_19

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_20 = 6
				local var_59_21 = utf8.len(var_59_19)
				local var_59_22 = var_59_20 <= 0 and var_59_16 or var_59_16 * (var_59_21 / var_59_20)

				if var_59_22 > 0 and var_59_16 < var_59_22 then
					arg_56_1.talkMaxDuration = var_59_22

					if var_59_22 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_22 + var_59_15
					end
				end

				arg_56_1.text_.text = var_59_19
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602013", "story_v_out_325602.awb") ~= 0 then
					local var_59_23 = manager.audio:GetVoiceLength("story_v_out_325602", "325602013", "story_v_out_325602.awb") / 1000

					if var_59_23 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_23 + var_59_15
					end

					if var_59_18.prefab_name ~= "" and arg_56_1.actors_[var_59_18.prefab_name] ~= nil then
						local var_59_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_18.prefab_name].transform, "story_v_out_325602", "325602013", "story_v_out_325602.awb")

						arg_56_1:RecordAudio("325602013", var_59_24)
						arg_56_1:RecordAudio("325602013", var_59_24)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325602", "325602013", "story_v_out_325602.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325602", "325602013", "story_v_out_325602.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_25 = math.max(var_59_16, arg_56_1.talkMaxDuration)

			if var_59_15 <= arg_56_1.time_ and arg_56_1.time_ < var_59_15 + var_59_25 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_15) / var_59_25

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_15 + var_59_25 and arg_56_1.time_ < var_59_15 + var_59_25 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play325602014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325602014
		arg_60_1.duration_ = 4.47

		local var_60_0 = {
			zh = 3.566,
			ja = 4.466
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play325602015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10170ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos10170ui_story = var_63_0.localPosition

				local var_63_2 = GameObjectTools.GetOrAddComponent(var_63_0.gameObject, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(false)
				end
			end

			local var_63_3 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_3 then
				local var_63_4 = (arg_60_1.time_ - var_63_1) / var_63_3
				local var_63_5 = Vector3.New(0, 100, 0)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10170ui_story, var_63_5, var_63_4)

				local var_63_6 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_6.x, var_63_6.y, var_63_6.z)

				local var_63_7 = var_63_0.localEulerAngles

				var_63_7.z = 0
				var_63_7.x = 0
				var_63_0.localEulerAngles = var_63_7
			end

			if arg_60_1.time_ >= var_63_1 + var_63_3 and arg_60_1.time_ < var_63_1 + var_63_3 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0, 100, 0)

				local var_63_8 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_8.x, var_63_8.y, var_63_8.z)

				local var_63_9 = var_63_0.localEulerAngles

				var_63_9.z = 0
				var_63_9.x = 0
				var_63_0.localEulerAngles = var_63_9

				local var_63_10 = GameObjectTools.GetOrAddComponent(var_63_0.gameObject, typeof(DynamicBoneHelper))

				if var_63_10 then
					var_63_10:EnableDynamicBone(true)
				end
			end

			local var_63_11 = "10180ui_story"

			if arg_60_1.actors_[var_63_11] == nil then
				local var_63_12 = Asset.Load("Char/" .. "10180ui_story")

				if not isNil(var_63_12) then
					local var_63_13 = Object.Instantiate(Asset.Load("Char/" .. "10180ui_story"), arg_60_1.stage_.transform)

					var_63_13.name = var_63_11
					var_63_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_60_1.actors_[var_63_11] = var_63_13

					local var_63_14 = var_63_13:GetComponentInChildren(typeof(CharacterEffect))

					var_63_14.enabled = true

					local var_63_15 = GameObjectTools.GetOrAddComponent(var_63_13, typeof(DynamicBoneHelper))

					if var_63_15 then
						var_63_15:EnableDynamicBone(false)
					end

					arg_60_1:ShowWeapon(var_63_14.transform, false)

					arg_60_1.var_[var_63_11 .. "Animator"] = var_63_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_60_1.var_[var_63_11 .. "Animator"].applyRootMotion = true
					arg_60_1.var_[var_63_11 .. "LipSync"] = var_63_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_63_16 = arg_60_1.actors_["10180ui_story"].transform
			local var_63_17 = 0

			if var_63_17 < arg_60_1.time_ and arg_60_1.time_ <= var_63_17 + arg_63_0 then
				arg_60_1.var_.moveOldPos10180ui_story = var_63_16.localPosition

				local var_63_18 = GameObjectTools.GetOrAddComponent(var_63_16.gameObject, typeof(DynamicBoneHelper))

				if var_63_18 then
					var_63_18:EnableDynamicBone(false)
				end
			end

			local var_63_19 = 0.001

			if var_63_17 <= arg_60_1.time_ and arg_60_1.time_ < var_63_17 + var_63_19 then
				local var_63_20 = (arg_60_1.time_ - var_63_17) / var_63_19
				local var_63_21 = Vector3.New(-0.03, -1.09, -6.14)

				var_63_16.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10180ui_story, var_63_21, var_63_20)

				local var_63_22 = manager.ui.mainCamera.transform.position - var_63_16.position

				var_63_16.forward = Vector3.New(var_63_22.x, var_63_22.y, var_63_22.z)

				local var_63_23 = var_63_16.localEulerAngles

				var_63_23.z = 0
				var_63_23.x = 0
				var_63_16.localEulerAngles = var_63_23
			end

			if arg_60_1.time_ >= var_63_17 + var_63_19 and arg_60_1.time_ < var_63_17 + var_63_19 + arg_63_0 then
				var_63_16.localPosition = Vector3.New(-0.03, -1.09, -6.14)

				local var_63_24 = manager.ui.mainCamera.transform.position - var_63_16.position

				var_63_16.forward = Vector3.New(var_63_24.x, var_63_24.y, var_63_24.z)

				local var_63_25 = var_63_16.localEulerAngles

				var_63_25.z = 0
				var_63_25.x = 0
				var_63_16.localEulerAngles = var_63_25

				local var_63_26 = GameObjectTools.GetOrAddComponent(var_63_16.gameObject, typeof(DynamicBoneHelper))

				if var_63_26 then
					var_63_26:EnableDynamicBone(true)
				end
			end

			local var_63_27 = arg_60_1.actors_["10180ui_story"]
			local var_63_28 = 0

			if var_63_28 < arg_60_1.time_ and arg_60_1.time_ <= var_63_28 + arg_63_0 and not isNil(var_63_27) and arg_60_1.var_.characterEffect10180ui_story == nil then
				arg_60_1.var_.characterEffect10180ui_story = var_63_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_29 = 0.200000002980232

			if var_63_28 <= arg_60_1.time_ and arg_60_1.time_ < var_63_28 + var_63_29 and not isNil(var_63_27) then
				local var_63_30 = (arg_60_1.time_ - var_63_28) / var_63_29

				if arg_60_1.var_.characterEffect10180ui_story and not isNil(var_63_27) then
					arg_60_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_28 + var_63_29 and arg_60_1.time_ < var_63_28 + var_63_29 + arg_63_0 and not isNil(var_63_27) and arg_60_1.var_.characterEffect10180ui_story then
				arg_60_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_63_31 = arg_60_1.actors_["10170ui_story"]
			local var_63_32 = 0

			if var_63_32 < arg_60_1.time_ and arg_60_1.time_ <= var_63_32 + arg_63_0 and not isNil(var_63_31) and arg_60_1.var_.characterEffect10170ui_story == nil then
				arg_60_1.var_.characterEffect10170ui_story = var_63_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_33 = 0.200000002980232

			if var_63_32 <= arg_60_1.time_ and arg_60_1.time_ < var_63_32 + var_63_33 and not isNil(var_63_31) then
				local var_63_34 = (arg_60_1.time_ - var_63_32) / var_63_33

				if arg_60_1.var_.characterEffect10170ui_story and not isNil(var_63_31) then
					local var_63_35 = Mathf.Lerp(0, 0.5, var_63_34)

					arg_60_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_60_1.var_.characterEffect10170ui_story.fillRatio = var_63_35
				end
			end

			if arg_60_1.time_ >= var_63_32 + var_63_33 and arg_60_1.time_ < var_63_32 + var_63_33 + arg_63_0 and not isNil(var_63_31) and arg_60_1.var_.characterEffect10170ui_story then
				local var_63_36 = 0.5

				arg_60_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_60_1.var_.characterEffect10170ui_story.fillRatio = var_63_36
			end

			local var_63_37 = 0

			if var_63_37 < arg_60_1.time_ and arg_60_1.time_ <= var_63_37 + arg_63_0 then
				arg_60_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action1_1")
			end

			local var_63_38 = 0

			if var_63_38 < arg_60_1.time_ and arg_60_1.time_ <= var_63_38 + arg_63_0 then
				arg_60_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_63_39 = 0
			local var_63_40 = 0.15

			if var_63_39 < arg_60_1.time_ and arg_60_1.time_ <= var_63_39 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_41 = arg_60_1:FormatText(StoryNameCfg[1503].name)

				arg_60_1.leftNameTxt_.text = var_63_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_42 = arg_60_1:GetWordFromCfg(325602014)
				local var_63_43 = arg_60_1:FormatText(var_63_42.content)

				arg_60_1.text_.text = var_63_43

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_44 = 6
				local var_63_45 = utf8.len(var_63_43)
				local var_63_46 = var_63_44 <= 0 and var_63_40 or var_63_40 * (var_63_45 / var_63_44)

				if var_63_46 > 0 and var_63_40 < var_63_46 then
					arg_60_1.talkMaxDuration = var_63_46

					if var_63_46 + var_63_39 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_46 + var_63_39
					end
				end

				arg_60_1.text_.text = var_63_43
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602014", "story_v_out_325602.awb") ~= 0 then
					local var_63_47 = manager.audio:GetVoiceLength("story_v_out_325602", "325602014", "story_v_out_325602.awb") / 1000

					if var_63_47 + var_63_39 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_47 + var_63_39
					end

					if var_63_42.prefab_name ~= "" and arg_60_1.actors_[var_63_42.prefab_name] ~= nil then
						local var_63_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_42.prefab_name].transform, "story_v_out_325602", "325602014", "story_v_out_325602.awb")

						arg_60_1:RecordAudio("325602014", var_63_48)
						arg_60_1:RecordAudio("325602014", var_63_48)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325602", "325602014", "story_v_out_325602.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325602", "325602014", "story_v_out_325602.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_49 = math.max(var_63_40, arg_60_1.talkMaxDuration)

			if var_63_39 <= arg_60_1.time_ and arg_60_1.time_ < var_63_39 + var_63_49 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_39) / var_63_49

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_39 + var_63_49 and arg_60_1.time_ < var_63_39 + var_63_49 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play325602015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325602015
		arg_64_1.duration_ = 6.67

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play325602016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10180ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos10180ui_story = var_67_0.localPosition

				local var_67_2 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(false)
				end
			end

			local var_67_3 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_3 then
				local var_67_4 = (arg_64_1.time_ - var_67_1) / var_67_3
				local var_67_5 = Vector3.New(0, 100, 0)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10180ui_story, var_67_5, var_67_4)

				local var_67_6 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_6.x, var_67_6.y, var_67_6.z)

				local var_67_7 = var_67_0.localEulerAngles

				var_67_7.z = 0
				var_67_7.x = 0
				var_67_0.localEulerAngles = var_67_7
			end

			if arg_64_1.time_ >= var_67_1 + var_67_3 and arg_64_1.time_ < var_67_1 + var_67_3 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, 100, 0)

				local var_67_8 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_8.x, var_67_8.y, var_67_8.z)

				local var_67_9 = var_67_0.localEulerAngles

				var_67_9.z = 0
				var_67_9.x = 0
				var_67_0.localEulerAngles = var_67_9

				local var_67_10 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_10 then
					var_67_10:EnableDynamicBone(true)
				end
			end

			local var_67_11 = arg_64_1.actors_["10180ui_story"]
			local var_67_12 = 0

			if var_67_12 < arg_64_1.time_ and arg_64_1.time_ <= var_67_12 + arg_67_0 and not isNil(var_67_11) and arg_64_1.var_.characterEffect10180ui_story == nil then
				arg_64_1.var_.characterEffect10180ui_story = var_67_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_13 = 0.200000002980232

			if var_67_12 <= arg_64_1.time_ and arg_64_1.time_ < var_67_12 + var_67_13 and not isNil(var_67_11) then
				local var_67_14 = (arg_64_1.time_ - var_67_12) / var_67_13

				if arg_64_1.var_.characterEffect10180ui_story and not isNil(var_67_11) then
					local var_67_15 = Mathf.Lerp(0, 0.5, var_67_14)

					arg_64_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10180ui_story.fillRatio = var_67_15
				end
			end

			if arg_64_1.time_ >= var_67_12 + var_67_13 and arg_64_1.time_ < var_67_12 + var_67_13 + arg_67_0 and not isNil(var_67_11) and arg_64_1.var_.characterEffect10180ui_story then
				local var_67_16 = 0.5

				arg_64_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10180ui_story.fillRatio = var_67_16
			end

			local var_67_17 = manager.ui.mainCamera.transform
			local var_67_18 = 0

			if var_67_18 < arg_64_1.time_ and arg_64_1.time_ <= var_67_18 + arg_67_0 then
				local var_67_19 = arg_64_1.var_.effectmantianheiwu1
				local var_67_20
				local var_67_21 = var_67_17

				if not var_67_19 then
					var_67_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heiwu"), var_67_21)
					var_67_19.name = "mantianheiwu1"
					arg_64_1.var_.effectmantianheiwu1 = var_67_19
				else
					var_67_19.transform:SetParent(var_67_21)
				end

				var_67_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_67_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_67_22 = manager.ui.mainCamera.transform
			local var_67_23 = 0

			if var_67_23 < arg_64_1.time_ and arg_64_1.time_ <= var_67_23 + arg_67_0 then
				local var_67_24 = arg_64_1.var_.effectmantianheiwu2
				local var_67_25
				local var_67_26 = var_67_22

				if not var_67_24 then
					var_67_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heimu_keep"), var_67_26)
					var_67_24.name = "mantianheiwu2"
					arg_64_1.var_.effectmantianheiwu2 = var_67_24
				else
					var_67_24.transform:SetParent(var_67_26)
				end

				var_67_24.transform.localPosition = Vector3.New(0, 0, 0)
				var_67_24.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_67_27 = 0.1
			local var_67_28 = 1

			if var_67_27 < arg_64_1.time_ and arg_64_1.time_ <= var_67_27 + arg_67_0 then
				local var_67_29 = "play"
				local var_67_30 = "effect"

				arg_64_1:AudioAction(var_67_29, var_67_30, "se_story_128", "se_story_128_magic", "")
			end

			local var_67_31 = 0.1
			local var_67_32 = 1

			if var_67_31 < arg_64_1.time_ and arg_64_1.time_ <= var_67_31 + arg_67_0 then
				local var_67_33 = "play"
				local var_67_34 = "effect"

				arg_64_1:AudioAction(var_67_33, var_67_34, "se_story_143", "se_story_143_magic_fire", "")
			end

			local var_67_35 = 0

			if var_67_35 < arg_64_1.time_ and arg_64_1.time_ <= var_67_35 + arg_67_0 then
				arg_64_1.allBtn_.enabled = false
			end

			local var_67_36 = 2.2

			if arg_64_1.time_ >= var_67_35 + var_67_36 and arg_64_1.time_ < var_67_35 + var_67_36 + arg_67_0 then
				arg_64_1.allBtn_.enabled = true
			end

			if arg_64_1.frameCnt_ <= 1 then
				arg_64_1.dialog_:SetActive(false)
			end

			local var_67_37 = 1.66666666666667
			local var_67_38 = 1.4

			if var_67_37 < arg_64_1.time_ and arg_64_1.time_ <= var_67_37 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				arg_64_1.dialog_:SetActive(true)

				arg_64_1.dialogCg_.alpha = 0

				local var_67_39 = LeanTween.value(arg_64_1.dialog_, 0, 1, 0.3)

				var_67_39:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_64_1.dialogCg_.alpha = arg_68_0
				end))
				var_67_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_64_1.dialog_)
					var_67_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_64_1.duration_ = arg_64_1.duration_ + 0.3

				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_40 = arg_64_1:GetWordFromCfg(325602015)
				local var_67_41 = arg_64_1:FormatText(var_67_40.content)

				arg_64_1.text_.text = var_67_41

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_42 = 56
				local var_67_43 = utf8.len(var_67_41)
				local var_67_44 = var_67_42 <= 0 and var_67_38 or var_67_38 * (var_67_43 / var_67_42)

				if var_67_44 > 0 and var_67_38 < var_67_44 then
					arg_64_1.talkMaxDuration = var_67_44
					var_67_37 = var_67_37 + 0.3

					if var_67_44 + var_67_37 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_44 + var_67_37
					end
				end

				arg_64_1.text_.text = var_67_41
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_45 = var_67_37 + 0.3
			local var_67_46 = math.max(var_67_38, arg_64_1.talkMaxDuration)

			if var_67_45 <= arg_64_1.time_ and arg_64_1.time_ < var_67_45 + var_67_46 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_45) / var_67_46

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_45 + var_67_46 and arg_64_1.time_ < var_67_45 + var_67_46 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play325602016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 325602016
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play325602017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 1.45

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_2 = arg_70_1:GetWordFromCfg(325602016)
				local var_73_3 = arg_70_1:FormatText(var_73_2.content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 58
				local var_73_5 = utf8.len(var_73_3)
				local var_73_6 = var_73_4 <= 0 and var_73_1 or var_73_1 * (var_73_5 / var_73_4)

				if var_73_6 > 0 and var_73_1 < var_73_6 then
					arg_70_1.talkMaxDuration = var_73_6

					if var_73_6 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_6 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_7 and arg_70_1.time_ < var_73_0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play325602017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325602017
		arg_74_1.duration_ = 4.37

		local var_74_0 = {
			zh = 3.433,
			ja = 4.366
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
				arg_74_0:Play325602018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.3

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[1450].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_3 = arg_74_1:GetWordFromCfg(325602017)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 12
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602017", "story_v_out_325602.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_325602", "325602017", "story_v_out_325602.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_325602", "325602017", "story_v_out_325602.awb")

						arg_74_1:RecordAudio("325602017", var_77_9)
						arg_74_1:RecordAudio("325602017", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_325602", "325602017", "story_v_out_325602.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_325602", "325602017", "story_v_out_325602.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_10 and arg_74_1.time_ < var_77_0 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play325602018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 325602018
		arg_78_1.duration_ = 3.5

		local var_78_0 = {
			zh = 2.366,
			ja = 3.5
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
				arg_78_0:Play325602019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.2

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[1450].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_3 = arg_78_1:GetWordFromCfg(325602018)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602018", "story_v_out_325602.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_325602", "325602018", "story_v_out_325602.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_325602", "325602018", "story_v_out_325602.awb")

						arg_78_1:RecordAudio("325602018", var_81_9)
						arg_78_1:RecordAudio("325602018", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_325602", "325602018", "story_v_out_325602.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_325602", "325602018", "story_v_out_325602.awb")
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
	Play325602019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325602019
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play325602020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["10170ui_story"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos10170ui_story = var_85_0.localPosition

				local var_85_2 = GameObjectTools.GetOrAddComponent(var_85_0.gameObject, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(false)
				end
			end

			local var_85_3 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_3 then
				local var_85_4 = (arg_82_1.time_ - var_85_1) / var_85_3
				local var_85_5 = Vector3.New(0, 100, 0)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10170ui_story, var_85_5, var_85_4)

				local var_85_6 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_6.x, var_85_6.y, var_85_6.z)

				local var_85_7 = var_85_0.localEulerAngles

				var_85_7.z = 0
				var_85_7.x = 0
				var_85_0.localEulerAngles = var_85_7
			end

			if arg_82_1.time_ >= var_85_1 + var_85_3 and arg_82_1.time_ < var_85_1 + var_85_3 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(0, 100, 0)

				local var_85_8 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_8.x, var_85_8.y, var_85_8.z)

				local var_85_9 = var_85_0.localEulerAngles

				var_85_9.z = 0
				var_85_9.x = 0
				var_85_0.localEulerAngles = var_85_9

				local var_85_10 = GameObjectTools.GetOrAddComponent(var_85_0.gameObject, typeof(DynamicBoneHelper))

				if var_85_10 then
					var_85_10:EnableDynamicBone(true)
				end
			end

			local var_85_11 = arg_82_1.actors_["10170ui_story"]
			local var_85_12 = 0

			if var_85_12 < arg_82_1.time_ and arg_82_1.time_ <= var_85_12 + arg_85_0 and not isNil(var_85_11) and arg_82_1.var_.characterEffect10170ui_story == nil then
				arg_82_1.var_.characterEffect10170ui_story = var_85_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_13 = 0.200000002980232

			if var_85_12 <= arg_82_1.time_ and arg_82_1.time_ < var_85_12 + var_85_13 and not isNil(var_85_11) then
				local var_85_14 = (arg_82_1.time_ - var_85_12) / var_85_13

				if arg_82_1.var_.characterEffect10170ui_story and not isNil(var_85_11) then
					local var_85_15 = Mathf.Lerp(0, 0.5, var_85_14)

					arg_82_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_82_1.var_.characterEffect10170ui_story.fillRatio = var_85_15
				end
			end

			if arg_82_1.time_ >= var_85_12 + var_85_13 and arg_82_1.time_ < var_85_12 + var_85_13 + arg_85_0 and not isNil(var_85_11) and arg_82_1.var_.characterEffect10170ui_story then
				local var_85_16 = 0.5

				arg_82_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_82_1.var_.characterEffect10170ui_story.fillRatio = var_85_16
			end

			local var_85_17 = 0
			local var_85_18 = 1.75

			if var_85_17 < arg_82_1.time_ and arg_82_1.time_ <= var_85_17 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_19 = arg_82_1:GetWordFromCfg(325602019)
				local var_85_20 = arg_82_1:FormatText(var_85_19.content)

				arg_82_1.text_.text = var_85_20

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_21 = 70
				local var_85_22 = utf8.len(var_85_20)
				local var_85_23 = var_85_21 <= 0 and var_85_18 or var_85_18 * (var_85_22 / var_85_21)

				if var_85_23 > 0 and var_85_18 < var_85_23 then
					arg_82_1.talkMaxDuration = var_85_23

					if var_85_23 + var_85_17 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_23 + var_85_17
					end
				end

				arg_82_1.text_.text = var_85_20
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_24 = math.max(var_85_18, arg_82_1.talkMaxDuration)

			if var_85_17 <= arg_82_1.time_ and arg_82_1.time_ < var_85_17 + var_85_24 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_17) / var_85_24

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_17 + var_85_24 and arg_82_1.time_ < var_85_17 + var_85_24 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play325602020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325602020
		arg_86_1.duration_ = 6.77

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play325602021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = "STblack"

			if arg_86_1.bgs_[var_89_0] == nil then
				local var_89_1 = Object.Instantiate(arg_86_1.paintGo_)

				var_89_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_89_0)
				var_89_1.name = var_89_0
				var_89_1.transform.parent = arg_86_1.stage_.transform
				var_89_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.bgs_[var_89_0] = var_89_1
			end

			local var_89_2 = 0.6

			if var_89_2 < arg_86_1.time_ and arg_86_1.time_ <= var_89_2 + arg_89_0 then
				local var_89_3 = manager.ui.mainCamera.transform.localPosition
				local var_89_4 = Vector3.New(0, 0, 10) + Vector3.New(var_89_3.x, var_89_3.y, 0)
				local var_89_5 = arg_86_1.bgs_.STblack

				var_89_5.transform.localPosition = var_89_4
				var_89_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_89_6 = var_89_5:GetComponent("SpriteRenderer")

				if var_89_6 and var_89_6.sprite then
					local var_89_7 = (var_89_5.transform.localPosition - var_89_3).z
					local var_89_8 = manager.ui.mainCameraCom_
					local var_89_9 = 2 * var_89_7 * Mathf.Tan(var_89_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_89_10 = var_89_9 * var_89_8.aspect
					local var_89_11 = var_89_6.sprite.bounds.size.x
					local var_89_12 = var_89_6.sprite.bounds.size.y
					local var_89_13 = var_89_10 / var_89_11
					local var_89_14 = var_89_9 / var_89_12
					local var_89_15 = var_89_14 < var_89_13 and var_89_13 or var_89_14

					var_89_5.transform.localScale = Vector3.New(var_89_15, var_89_15, 0)
				end

				for iter_89_0, iter_89_1 in pairs(arg_86_1.bgs_) do
					if iter_89_0 ~= "STblack" then
						iter_89_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_89_16 = manager.ui.mainCamera.transform
			local var_89_17 = 0

			if var_89_17 < arg_86_1.time_ and arg_86_1.time_ <= var_89_17 + arg_89_0 then
				local var_89_18 = arg_86_1.var_.effectpikaihongmeng1
				local var_89_19
				local var_89_20 = var_89_16

				if not var_89_18 then
					var_89_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suipian_out"), var_89_20)
					var_89_18.name = "pikaihongmeng1"
					arg_86_1.var_.effectpikaihongmeng1 = var_89_18
				else
					var_89_18.transform:SetParent(var_89_20)
				end

				var_89_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_89_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_89_21 = manager.ui.mainCamera.transform
			local var_89_22 = 0.6

			if var_89_22 < arg_86_1.time_ and arg_86_1.time_ <= var_89_22 + arg_89_0 then
				local var_89_23 = arg_86_1.var_.effectpikaihongmeng1

				if var_89_23 then
					Object.Destroy(var_89_23)

					arg_86_1.var_.effectpikaihongmeng1 = nil
				end
			end

			local var_89_24 = manager.ui.mainCamera.transform
			local var_89_25 = 0.6

			if var_89_25 < arg_86_1.time_ and arg_86_1.time_ <= var_89_25 + arg_89_0 then
				local var_89_26 = arg_86_1.var_.effectpikaihongmeng2
				local var_89_27
				local var_89_28 = var_89_24

				if not var_89_26 then
					var_89_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), var_89_28)
					var_89_26.name = "pikaihongmeng2"
					arg_86_1.var_.effectpikaihongmeng2 = var_89_26
				else
					var_89_26.transform:SetParent(var_89_28)
				end

				var_89_26.transform.localPosition = Vector3.New(0, 0, 0)
				var_89_26.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_89_29 = manager.ui.mainCamera.transform
			local var_89_30 = 2.5

			if var_89_30 < arg_86_1.time_ and arg_86_1.time_ <= var_89_30 + arg_89_0 then
				local var_89_31 = arg_86_1.var_.effectpikaihongmeng2

				if var_89_31 then
					Object.Destroy(var_89_31)

					arg_86_1.var_.effectpikaihongmeng2 = nil
				end
			end

			local var_89_32 = 0
			local var_89_33 = 1.9

			if var_89_32 < arg_86_1.time_ and arg_86_1.time_ <= var_89_32 + arg_89_0 then
				local var_89_34 = "play"
				local var_89_35 = "effect"

				arg_86_1:AudioAction(var_89_34, var_89_35, "se_story_150", "se_story_150_sword10", "")
			end

			local var_89_36 = manager.ui.mainCamera.transform
			local var_89_37 = 0.6

			if var_89_37 < arg_86_1.time_ and arg_86_1.time_ <= var_89_37 + arg_89_0 then
				local var_89_38 = arg_86_1.var_.effectmantianheiwu2

				if var_89_38 then
					Object.Destroy(var_89_38)

					arg_86_1.var_.effectmantianheiwu2 = nil
				end
			end

			if arg_86_1.frameCnt_ <= 1 then
				arg_86_1.dialog_:SetActive(false)
			end

			local var_89_39 = 1.76666666666667
			local var_89_40 = 1.725

			if var_89_39 < arg_86_1.time_ and arg_86_1.time_ <= var_89_39 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0

				arg_86_1.dialog_:SetActive(true)

				arg_86_1.dialogCg_.alpha = 0

				local var_89_41 = LeanTween.value(arg_86_1.dialog_, 0, 1, 0.3)

				var_89_41:setOnUpdate(LuaHelper.FloatAction(function(arg_90_0)
					arg_86_1.dialogCg_.alpha = arg_90_0
				end))
				var_89_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_86_1.dialog_)
					var_89_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_86_1.duration_ = arg_86_1.duration_ + 0.3

				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_42 = arg_86_1:GetWordFromCfg(325602020)
				local var_89_43 = arg_86_1:FormatText(var_89_42.content)

				arg_86_1.text_.text = var_89_43

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_44 = 69
				local var_89_45 = utf8.len(var_89_43)
				local var_89_46 = var_89_44 <= 0 and var_89_40 or var_89_40 * (var_89_45 / var_89_44)

				if var_89_46 > 0 and var_89_40 < var_89_46 then
					arg_86_1.talkMaxDuration = var_89_46
					var_89_39 = var_89_39 + 0.3

					if var_89_46 + var_89_39 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_46 + var_89_39
					end
				end

				arg_86_1.text_.text = var_89_43
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_47 = var_89_39 + 0.3
			local var_89_48 = math.max(var_89_40, arg_86_1.talkMaxDuration)

			if var_89_47 <= arg_86_1.time_ and arg_86_1.time_ < var_89_47 + var_89_48 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_47) / var_89_48

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_47 + var_89_48 and arg_86_1.time_ < var_89_47 + var_89_48 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play325602021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325602021
		arg_92_1.duration_ = 3.97

		local var_92_0 = {
			zh = 3.8,
			ja = 3.966
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play325602022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = "MS2504"

			if arg_92_1.bgs_[var_95_0] == nil then
				local var_95_1 = Object.Instantiate(arg_92_1.paintGo_)

				var_95_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_95_0)
				var_95_1.name = var_95_0
				var_95_1.transform.parent = arg_92_1.stage_.transform
				var_95_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.bgs_[var_95_0] = var_95_1
			end

			local var_95_2 = 0

			if var_95_2 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 then
				local var_95_3 = manager.ui.mainCamera.transform.localPosition
				local var_95_4 = Vector3.New(0, 0, 10) + Vector3.New(var_95_3.x, var_95_3.y, 0)
				local var_95_5 = arg_92_1.bgs_.MS2504

				var_95_5.transform.localPosition = var_95_4
				var_95_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_95_6 = var_95_5:GetComponent("SpriteRenderer")

				if var_95_6 and var_95_6.sprite then
					local var_95_7 = (var_95_5.transform.localPosition - var_95_3).z
					local var_95_8 = manager.ui.mainCameraCom_
					local var_95_9 = 2 * var_95_7 * Mathf.Tan(var_95_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_95_10 = var_95_9 * var_95_8.aspect
					local var_95_11 = var_95_6.sprite.bounds.size.x
					local var_95_12 = var_95_6.sprite.bounds.size.y
					local var_95_13 = var_95_10 / var_95_11
					local var_95_14 = var_95_9 / var_95_12
					local var_95_15 = var_95_14 < var_95_13 and var_95_13 or var_95_14

					var_95_5.transform.localScale = Vector3.New(var_95_15, var_95_15, 0)
				end

				for iter_95_0, iter_95_1 in pairs(arg_92_1.bgs_) do
					if iter_95_0 ~= "MS2504" then
						iter_95_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_95_16 = 1.999999999999

			if var_95_16 < arg_92_1.time_ and arg_92_1.time_ <= var_95_16 + arg_95_0 then
				arg_92_1.allBtn_.enabled = false
			end

			local var_95_17 = 0.3

			if arg_92_1.time_ >= var_95_16 + var_95_17 and arg_92_1.time_ < var_95_16 + var_95_17 + arg_95_0 then
				arg_92_1.allBtn_.enabled = true
			end

			local var_95_18 = 0

			if var_95_18 < arg_92_1.time_ and arg_92_1.time_ <= var_95_18 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_19 = 0.433333333333333

			if var_95_18 <= arg_92_1.time_ and arg_92_1.time_ < var_95_18 + var_95_19 then
				local var_95_20 = (arg_92_1.time_ - var_95_18) / var_95_19
				local var_95_21 = Color.New(0, 0, 0)

				var_95_21.a = Mathf.Lerp(1, 0, var_95_20)
				arg_92_1.mask_.color = var_95_21
			end

			if arg_92_1.time_ >= var_95_18 + var_95_19 and arg_92_1.time_ < var_95_18 + var_95_19 + arg_95_0 then
				local var_95_22 = Color.New(0, 0, 0)
				local var_95_23 = 0

				arg_92_1.mask_.enabled = false
				var_95_22.a = var_95_23
				arg_92_1.mask_.color = var_95_22
			end

			local var_95_24 = arg_92_1.actors_["10180ui_story"].transform
			local var_95_25 = 0

			if var_95_25 < arg_92_1.time_ and arg_92_1.time_ <= var_95_25 + arg_95_0 then
				arg_92_1.var_.moveOldPos10180ui_story = var_95_24.localPosition

				local var_95_26 = GameObjectTools.GetOrAddComponent(var_95_24.gameObject, typeof(DynamicBoneHelper))

				if var_95_26 then
					var_95_26:EnableDynamicBone(false)
				end
			end

			local var_95_27 = 0.001

			if var_95_25 <= arg_92_1.time_ and arg_92_1.time_ < var_95_25 + var_95_27 then
				local var_95_28 = (arg_92_1.time_ - var_95_25) / var_95_27
				local var_95_29 = Vector3.New(0, 100, 0)

				var_95_24.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10180ui_story, var_95_29, var_95_28)

				local var_95_30 = manager.ui.mainCamera.transform.position - var_95_24.position

				var_95_24.forward = Vector3.New(var_95_30.x, var_95_30.y, var_95_30.z)

				local var_95_31 = var_95_24.localEulerAngles

				var_95_31.z = 0
				var_95_31.x = 0
				var_95_24.localEulerAngles = var_95_31
			end

			if arg_92_1.time_ >= var_95_25 + var_95_27 and arg_92_1.time_ < var_95_25 + var_95_27 + arg_95_0 then
				var_95_24.localPosition = Vector3.New(0, 100, 0)

				local var_95_32 = manager.ui.mainCamera.transform.position - var_95_24.position

				var_95_24.forward = Vector3.New(var_95_32.x, var_95_32.y, var_95_32.z)

				local var_95_33 = var_95_24.localEulerAngles

				var_95_33.z = 0
				var_95_33.x = 0
				var_95_24.localEulerAngles = var_95_33

				local var_95_34 = GameObjectTools.GetOrAddComponent(var_95_24.gameObject, typeof(DynamicBoneHelper))

				if var_95_34 then
					var_95_34:EnableDynamicBone(true)
				end
			end

			local var_95_35 = arg_92_1.actors_["10180ui_story"]
			local var_95_36 = 0

			if var_95_36 < arg_92_1.time_ and arg_92_1.time_ <= var_95_36 + arg_95_0 and not isNil(var_95_35) and arg_92_1.var_.characterEffect10180ui_story == nil then
				arg_92_1.var_.characterEffect10180ui_story = var_95_35:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_37 = 0.0166666666666667

			if var_95_36 <= arg_92_1.time_ and arg_92_1.time_ < var_95_36 + var_95_37 and not isNil(var_95_35) then
				local var_95_38 = (arg_92_1.time_ - var_95_36) / var_95_37

				if arg_92_1.var_.characterEffect10180ui_story and not isNil(var_95_35) then
					arg_92_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_36 + var_95_37 and arg_92_1.time_ < var_95_36 + var_95_37 + arg_95_0 and not isNil(var_95_35) and arg_92_1.var_.characterEffect10180ui_story then
				arg_92_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_95_39 = arg_92_1.bgs_.MS2504.transform
			local var_95_40 = 0

			if var_95_40 < arg_92_1.time_ and arg_92_1.time_ <= var_95_40 + arg_95_0 then
				arg_92_1.var_.moveOldPosMS2504 = var_95_39.localPosition
			end

			local var_95_41 = 1

			if var_95_40 <= arg_92_1.time_ and arg_92_1.time_ < var_95_40 + var_95_41 then
				local var_95_42 = (arg_92_1.time_ - var_95_40) / var_95_41
				local var_95_43 = Vector3.New(0, 1, 9.5)

				var_95_39.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPosMS2504, var_95_43, var_95_42)
			end

			if arg_92_1.time_ >= var_95_40 + var_95_41 and arg_92_1.time_ < var_95_40 + var_95_41 + arg_95_0 then
				var_95_39.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_95_44 = arg_92_1.bgs_.MS2504.transform
			local var_95_45 = 1

			if var_95_45 < arg_92_1.time_ and arg_92_1.time_ <= var_95_45 + arg_95_0 then
				arg_92_1.var_.moveOldPosMS2504 = var_95_44.localPosition
			end

			local var_95_46 = 2.500000000001

			if var_95_45 <= arg_92_1.time_ and arg_92_1.time_ < var_95_45 + var_95_46 then
				local var_95_47 = (arg_92_1.time_ - var_95_45) / var_95_46
				local var_95_48 = Vector3.New(0, 1, 10)

				var_95_44.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPosMS2504, var_95_48, var_95_47)
			end

			if arg_92_1.time_ >= var_95_45 + var_95_46 and arg_92_1.time_ < var_95_45 + var_95_46 + arg_95_0 then
				var_95_44.localPosition = Vector3.New(0, 1, 10)
			end

			local var_95_49 = manager.ui.mainCamera.transform
			local var_95_50 = 0

			if var_95_50 < arg_92_1.time_ and arg_92_1.time_ <= var_95_50 + arg_95_0 then
				local var_95_51 = arg_92_1.var_.effectposuitexiao1
				local var_95_52
				local var_95_53 = var_95_49

				if not var_95_51 then
					var_95_51 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suipian_in"), var_95_53)
					var_95_51.name = "posuitexiao1"
					arg_92_1.var_.effectposuitexiao1 = var_95_51
				else
					var_95_51.transform:SetParent(var_95_53)
				end

				var_95_51.transform.localPosition = Vector3.New(0, 0, 0)
				var_95_51.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_95_54 = 0

			if var_95_54 < arg_92_1.time_ and arg_92_1.time_ <= var_95_54 + arg_95_0 then
				arg_92_1.allBtn_.enabled = false
			end

			local var_95_55 = 1.999999999999

			if arg_92_1.time_ >= var_95_54 + var_95_55 and arg_92_1.time_ < var_95_54 + var_95_55 + arg_95_0 then
				arg_92_1.allBtn_.enabled = true
			end

			local var_95_56 = manager.ui.mainCamera.transform
			local var_95_57 = 0

			if var_95_57 < arg_92_1.time_ and arg_92_1.time_ <= var_95_57 + arg_95_0 then
				local var_95_58 = arg_92_1.var_.effectmantianheiwu1

				if var_95_58 then
					Object.Destroy(var_95_58)

					arg_92_1.var_.effectmantianheiwu1 = nil
				end
			end

			local var_95_59 = 0.1
			local var_95_60 = 1

			if var_95_59 < arg_92_1.time_ and arg_92_1.time_ <= var_95_59 + arg_95_0 then
				local var_95_61 = "play"
				local var_95_62 = "effect"

				arg_92_1:AudioAction(var_95_61, var_95_62, "se_story_148", "se_story_148_bell_temple_china02", "")
			end

			if arg_92_1.frameCnt_ <= 1 then
				arg_92_1.dialog_:SetActive(false)
			end

			local var_95_63 = 2
			local var_95_64 = 0.125

			if var_95_63 < arg_92_1.time_ and arg_92_1.time_ <= var_95_63 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0

				arg_92_1.dialog_:SetActive(true)

				arg_92_1.dialogCg_.alpha = 0

				local var_95_65 = LeanTween.value(arg_92_1.dialog_, 0, 1, 0.3)

				var_95_65:setOnUpdate(LuaHelper.FloatAction(function(arg_96_0)
					arg_92_1.dialogCg_.alpha = arg_96_0
				end))
				var_95_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_92_1.dialog_)
					var_95_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_92_1.duration_ = arg_92_1.duration_ + 0.3

				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_66 = arg_92_1:FormatText(StoryNameCfg[1503].name)

				arg_92_1.leftNameTxt_.text = var_95_66

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_67 = arg_92_1:GetWordFromCfg(325602021)
				local var_95_68 = arg_92_1:FormatText(var_95_67.content)

				arg_92_1.text_.text = var_95_68

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_69 = 5
				local var_95_70 = utf8.len(var_95_68)
				local var_95_71 = var_95_69 <= 0 and var_95_64 or var_95_64 * (var_95_70 / var_95_69)

				if var_95_71 > 0 and var_95_64 < var_95_71 then
					arg_92_1.talkMaxDuration = var_95_71
					var_95_63 = var_95_63 + 0.3

					if var_95_71 + var_95_63 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_71 + var_95_63
					end
				end

				arg_92_1.text_.text = var_95_68
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602021", "story_v_out_325602.awb") ~= 0 then
					local var_95_72 = manager.audio:GetVoiceLength("story_v_out_325602", "325602021", "story_v_out_325602.awb") / 1000

					if var_95_72 + var_95_63 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_72 + var_95_63
					end

					if var_95_67.prefab_name ~= "" and arg_92_1.actors_[var_95_67.prefab_name] ~= nil then
						local var_95_73 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_67.prefab_name].transform, "story_v_out_325602", "325602021", "story_v_out_325602.awb")

						arg_92_1:RecordAudio("325602021", var_95_73)
						arg_92_1:RecordAudio("325602021", var_95_73)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_325602", "325602021", "story_v_out_325602.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_325602", "325602021", "story_v_out_325602.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_74 = var_95_63 + 0.3
			local var_95_75 = math.max(var_95_64, arg_92_1.talkMaxDuration)

			if var_95_74 <= arg_92_1.time_ and arg_92_1.time_ < var_95_74 + var_95_75 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_74) / var_95_75

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_74 + var_95_75 and arg_92_1.time_ < var_95_74 + var_95_75 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2504",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 0),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2504",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.500000000001,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play325602022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 325602022
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play325602023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["10180ui_story"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos10180ui_story = var_101_0.localPosition

				local var_101_2 = GameObjectTools.GetOrAddComponent(var_101_0.gameObject, typeof(DynamicBoneHelper))

				if var_101_2 then
					var_101_2:EnableDynamicBone(false)
				end
			end

			local var_101_3 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_3 then
				local var_101_4 = (arg_98_1.time_ - var_101_1) / var_101_3
				local var_101_5 = Vector3.New(0, 100, 0)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10180ui_story, var_101_5, var_101_4)

				local var_101_6 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_6.x, var_101_6.y, var_101_6.z)

				local var_101_7 = var_101_0.localEulerAngles

				var_101_7.z = 0
				var_101_7.x = 0
				var_101_0.localEulerAngles = var_101_7
			end

			if arg_98_1.time_ >= var_101_1 + var_101_3 and arg_98_1.time_ < var_101_1 + var_101_3 + arg_101_0 then
				var_101_0.localPosition = Vector3.New(0, 100, 0)

				local var_101_8 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_8.x, var_101_8.y, var_101_8.z)

				local var_101_9 = var_101_0.localEulerAngles

				var_101_9.z = 0
				var_101_9.x = 0
				var_101_0.localEulerAngles = var_101_9

				local var_101_10 = GameObjectTools.GetOrAddComponent(var_101_0.gameObject, typeof(DynamicBoneHelper))

				if var_101_10 then
					var_101_10:EnableDynamicBone(true)
				end
			end

			local var_101_11 = arg_98_1.actors_["10180ui_story"]
			local var_101_12 = 0

			if var_101_12 < arg_98_1.time_ and arg_98_1.time_ <= var_101_12 + arg_101_0 and not isNil(var_101_11) and arg_98_1.var_.characterEffect10180ui_story == nil then
				arg_98_1.var_.characterEffect10180ui_story = var_101_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_13 = 0.200000002980232

			if var_101_12 <= arg_98_1.time_ and arg_98_1.time_ < var_101_12 + var_101_13 and not isNil(var_101_11) then
				local var_101_14 = (arg_98_1.time_ - var_101_12) / var_101_13

				if arg_98_1.var_.characterEffect10180ui_story and not isNil(var_101_11) then
					local var_101_15 = Mathf.Lerp(0, 0.5, var_101_14)

					arg_98_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_98_1.var_.characterEffect10180ui_story.fillRatio = var_101_15
				end
			end

			if arg_98_1.time_ >= var_101_12 + var_101_13 and arg_98_1.time_ < var_101_12 + var_101_13 + arg_101_0 and not isNil(var_101_11) and arg_98_1.var_.characterEffect10180ui_story then
				local var_101_16 = 0.5

				arg_98_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_98_1.var_.characterEffect10180ui_story.fillRatio = var_101_16
			end

			local var_101_17 = 0
			local var_101_18 = 1.025

			if var_101_17 < arg_98_1.time_ and arg_98_1.time_ <= var_101_17 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_19 = arg_98_1:GetWordFromCfg(325602022)
				local var_101_20 = arg_98_1:FormatText(var_101_19.content)

				arg_98_1.text_.text = var_101_20

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_21 = 41
				local var_101_22 = utf8.len(var_101_20)
				local var_101_23 = var_101_21 <= 0 and var_101_18 or var_101_18 * (var_101_22 / var_101_21)

				if var_101_23 > 0 and var_101_18 < var_101_23 then
					arg_98_1.talkMaxDuration = var_101_23

					if var_101_23 + var_101_17 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_23 + var_101_17
					end
				end

				arg_98_1.text_.text = var_101_20
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_24 = math.max(var_101_18, arg_98_1.talkMaxDuration)

			if var_101_17 <= arg_98_1.time_ and arg_98_1.time_ < var_101_17 + var_101_24 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_17) / var_101_24

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_17 + var_101_24 and arg_98_1.time_ < var_101_17 + var_101_24 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play325602023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325602023
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play325602024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 1.675

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

				local var_105_2 = arg_102_1:GetWordFromCfg(325602023)
				local var_105_3 = arg_102_1:FormatText(var_105_2.content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 67
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
	Play325602024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 325602024
		arg_106_1.duration_ = 9.73

		local var_106_0 = {
			zh = 4.1,
			ja = 9.733
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
				arg_106_0:Play325602025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["10180ui_story"].transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.moveOldPos10180ui_story = var_109_0.localPosition

				local var_109_2 = GameObjectTools.GetOrAddComponent(var_109_0.gameObject, typeof(DynamicBoneHelper))

				if var_109_2 then
					var_109_2:EnableDynamicBone(false)
				end
			end

			local var_109_3 = 0.001

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_3 then
				local var_109_4 = (arg_106_1.time_ - var_109_1) / var_109_3
				local var_109_5 = Vector3.New(0, 100, 0)

				var_109_0.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10180ui_story, var_109_5, var_109_4)

				local var_109_6 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_6.x, var_109_6.y, var_109_6.z)

				local var_109_7 = var_109_0.localEulerAngles

				var_109_7.z = 0
				var_109_7.x = 0
				var_109_0.localEulerAngles = var_109_7
			end

			if arg_106_1.time_ >= var_109_1 + var_109_3 and arg_106_1.time_ < var_109_1 + var_109_3 + arg_109_0 then
				var_109_0.localPosition = Vector3.New(0, 100, 0)

				local var_109_8 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_8.x, var_109_8.y, var_109_8.z)

				local var_109_9 = var_109_0.localEulerAngles

				var_109_9.z = 0
				var_109_9.x = 0
				var_109_0.localEulerAngles = var_109_9

				local var_109_10 = GameObjectTools.GetOrAddComponent(var_109_0.gameObject, typeof(DynamicBoneHelper))

				if var_109_10 then
					var_109_10:EnableDynamicBone(true)
				end
			end

			local var_109_11 = arg_106_1.actors_["10180ui_story"]
			local var_109_12 = 0

			if var_109_12 < arg_106_1.time_ and arg_106_1.time_ <= var_109_12 + arg_109_0 and not isNil(var_109_11) and arg_106_1.var_.characterEffect10180ui_story == nil then
				arg_106_1.var_.characterEffect10180ui_story = var_109_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_13 = 0.200000002980232

			if var_109_12 <= arg_106_1.time_ and arg_106_1.time_ < var_109_12 + var_109_13 and not isNil(var_109_11) then
				local var_109_14 = (arg_106_1.time_ - var_109_12) / var_109_13

				if arg_106_1.var_.characterEffect10180ui_story and not isNil(var_109_11) then
					arg_106_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_12 + var_109_13 and arg_106_1.time_ < var_109_12 + var_109_13 + arg_109_0 and not isNil(var_109_11) and arg_106_1.var_.characterEffect10180ui_story then
				arg_106_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_109_15 = 0
			local var_109_16 = 0.35

			if var_109_15 < arg_106_1.time_ and arg_106_1.time_ <= var_109_15 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_17 = arg_106_1:FormatText(StoryNameCfg[1503].name)

				arg_106_1.leftNameTxt_.text = var_109_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_18 = arg_106_1:GetWordFromCfg(325602024)
				local var_109_19 = arg_106_1:FormatText(var_109_18.content)

				arg_106_1.text_.text = var_109_19

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_20 = 14
				local var_109_21 = utf8.len(var_109_19)
				local var_109_22 = var_109_20 <= 0 and var_109_16 or var_109_16 * (var_109_21 / var_109_20)

				if var_109_22 > 0 and var_109_16 < var_109_22 then
					arg_106_1.talkMaxDuration = var_109_22

					if var_109_22 + var_109_15 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_22 + var_109_15
					end
				end

				arg_106_1.text_.text = var_109_19
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602024", "story_v_out_325602.awb") ~= 0 then
					local var_109_23 = manager.audio:GetVoiceLength("story_v_out_325602", "325602024", "story_v_out_325602.awb") / 1000

					if var_109_23 + var_109_15 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_23 + var_109_15
					end

					if var_109_18.prefab_name ~= "" and arg_106_1.actors_[var_109_18.prefab_name] ~= nil then
						local var_109_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_18.prefab_name].transform, "story_v_out_325602", "325602024", "story_v_out_325602.awb")

						arg_106_1:RecordAudio("325602024", var_109_24)
						arg_106_1:RecordAudio("325602024", var_109_24)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_325602", "325602024", "story_v_out_325602.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_325602", "325602024", "story_v_out_325602.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_25 = math.max(var_109_16, arg_106_1.talkMaxDuration)

			if var_109_15 <= arg_106_1.time_ and arg_106_1.time_ < var_109_15 + var_109_25 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_15) / var_109_25

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_15 + var_109_25 and arg_106_1.time_ < var_109_15 + var_109_25 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play325602025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 325602025
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play325602026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["10180ui_story"].transform
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.var_.moveOldPos10180ui_story = var_113_0.localPosition

				local var_113_2 = GameObjectTools.GetOrAddComponent(var_113_0.gameObject, typeof(DynamicBoneHelper))

				if var_113_2 then
					var_113_2:EnableDynamicBone(false)
				end
			end

			local var_113_3 = 0.001

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_3 then
				local var_113_4 = (arg_110_1.time_ - var_113_1) / var_113_3
				local var_113_5 = Vector3.New(0, 100, 0)

				var_113_0.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10180ui_story, var_113_5, var_113_4)

				local var_113_6 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_6.x, var_113_6.y, var_113_6.z)

				local var_113_7 = var_113_0.localEulerAngles

				var_113_7.z = 0
				var_113_7.x = 0
				var_113_0.localEulerAngles = var_113_7
			end

			if arg_110_1.time_ >= var_113_1 + var_113_3 and arg_110_1.time_ < var_113_1 + var_113_3 + arg_113_0 then
				var_113_0.localPosition = Vector3.New(0, 100, 0)

				local var_113_8 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_8.x, var_113_8.y, var_113_8.z)

				local var_113_9 = var_113_0.localEulerAngles

				var_113_9.z = 0
				var_113_9.x = 0
				var_113_0.localEulerAngles = var_113_9

				local var_113_10 = GameObjectTools.GetOrAddComponent(var_113_0.gameObject, typeof(DynamicBoneHelper))

				if var_113_10 then
					var_113_10:EnableDynamicBone(true)
				end
			end

			local var_113_11 = arg_110_1.actors_["10180ui_story"]
			local var_113_12 = 0

			if var_113_12 < arg_110_1.time_ and arg_110_1.time_ <= var_113_12 + arg_113_0 and not isNil(var_113_11) and arg_110_1.var_.characterEffect10180ui_story == nil then
				arg_110_1.var_.characterEffect10180ui_story = var_113_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_13 = 0.200000002980232

			if var_113_12 <= arg_110_1.time_ and arg_110_1.time_ < var_113_12 + var_113_13 and not isNil(var_113_11) then
				local var_113_14 = (arg_110_1.time_ - var_113_12) / var_113_13

				if arg_110_1.var_.characterEffect10180ui_story and not isNil(var_113_11) then
					local var_113_15 = Mathf.Lerp(0, 0.5, var_113_14)

					arg_110_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_110_1.var_.characterEffect10180ui_story.fillRatio = var_113_15
				end
			end

			if arg_110_1.time_ >= var_113_12 + var_113_13 and arg_110_1.time_ < var_113_12 + var_113_13 + arg_113_0 and not isNil(var_113_11) and arg_110_1.var_.characterEffect10180ui_story then
				local var_113_16 = 0.5

				arg_110_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_110_1.var_.characterEffect10180ui_story.fillRatio = var_113_16
			end

			local var_113_17 = 0
			local var_113_18 = 0.325

			if var_113_17 < arg_110_1.time_ and arg_110_1.time_ <= var_113_17 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_19 = arg_110_1:FormatText(StoryNameCfg[7].name)

				arg_110_1.leftNameTxt_.text = var_113_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_20 = arg_110_1:GetWordFromCfg(325602025)
				local var_113_21 = arg_110_1:FormatText(var_113_20.content)

				arg_110_1.text_.text = var_113_21

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_22 = 13
				local var_113_23 = utf8.len(var_113_21)
				local var_113_24 = var_113_22 <= 0 and var_113_18 or var_113_18 * (var_113_23 / var_113_22)

				if var_113_24 > 0 and var_113_18 < var_113_24 then
					arg_110_1.talkMaxDuration = var_113_24

					if var_113_24 + var_113_17 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_24 + var_113_17
					end
				end

				arg_110_1.text_.text = var_113_21
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_25 = math.max(var_113_18, arg_110_1.talkMaxDuration)

			if var_113_17 <= arg_110_1.time_ and arg_110_1.time_ < var_113_17 + var_113_25 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_17) / var_113_25

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_17 + var_113_25 and arg_110_1.time_ < var_113_17 + var_113_25 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
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
	Play325602026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 325602026
		arg_114_1.duration_ = 10.5

		local var_114_0 = {
			zh = 6.333,
			ja = 10.5
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
				arg_114_0:Play325602027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.575

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[1503].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_3 = arg_114_1:GetWordFromCfg(325602026)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602026", "story_v_out_325602.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_325602", "325602026", "story_v_out_325602.awb") / 1000

					if var_117_8 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_0
					end

					if var_117_3.prefab_name ~= "" and arg_114_1.actors_[var_117_3.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_3.prefab_name].transform, "story_v_out_325602", "325602026", "story_v_out_325602.awb")

						arg_114_1:RecordAudio("325602026", var_117_9)
						arg_114_1:RecordAudio("325602026", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_325602", "325602026", "story_v_out_325602.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_325602", "325602026", "story_v_out_325602.awb")
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
	Play325602027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 325602027
		arg_118_1.duration_ = 15.37

		local var_118_0 = {
			zh = 8.5,
			ja = 15.366
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play325602028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 0.775

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_2 = arg_118_1:FormatText(StoryNameCfg[1503].name)

				arg_118_1.leftNameTxt_.text = var_121_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_3 = arg_118_1:GetWordFromCfg(325602027)
				local var_121_4 = arg_118_1:FormatText(var_121_3.content)

				arg_118_1.text_.text = var_121_4

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 31
				local var_121_6 = utf8.len(var_121_4)
				local var_121_7 = var_121_5 <= 0 and var_121_1 or var_121_1 * (var_121_6 / var_121_5)

				if var_121_7 > 0 and var_121_1 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_4
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602027", "story_v_out_325602.awb") ~= 0 then
					local var_121_8 = manager.audio:GetVoiceLength("story_v_out_325602", "325602027", "story_v_out_325602.awb") / 1000

					if var_121_8 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_0
					end

					if var_121_3.prefab_name ~= "" and arg_118_1.actors_[var_121_3.prefab_name] ~= nil then
						local var_121_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_3.prefab_name].transform, "story_v_out_325602", "325602027", "story_v_out_325602.awb")

						arg_118_1:RecordAudio("325602027", var_121_9)
						arg_118_1:RecordAudio("325602027", var_121_9)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_325602", "325602027", "story_v_out_325602.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_325602", "325602027", "story_v_out_325602.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_10 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_10 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_10

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_10 and arg_118_1.time_ < var_121_0 + var_121_10 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play325602028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 325602028
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play325602029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 0.2

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_2 = arg_122_1:FormatText(StoryNameCfg[7].name)

				arg_122_1.leftNameTxt_.text = var_125_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_3 = arg_122_1:GetWordFromCfg(325602028)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 8
				local var_125_6 = utf8.len(var_125_4)
				local var_125_7 = var_125_5 <= 0 and var_125_1 or var_125_1 * (var_125_6 / var_125_5)

				if var_125_7 > 0 and var_125_1 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_8 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_8 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_8

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_8 and arg_122_1.time_ < var_125_0 + var_125_8 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play325602029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 325602029
		arg_126_1.duration_ = 12.4

		local var_126_0 = {
			zh = 6.1,
			ja = 12.4
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
				arg_126_0:Play325602030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0
			local var_129_1 = 0.6

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_2 = arg_126_1:FormatText(StoryNameCfg[1503].name)

				arg_126_1.leftNameTxt_.text = var_129_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_3 = arg_126_1:GetWordFromCfg(325602029)
				local var_129_4 = arg_126_1:FormatText(var_129_3.content)

				arg_126_1.text_.text = var_129_4

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 24
				local var_129_6 = utf8.len(var_129_4)
				local var_129_7 = var_129_5 <= 0 and var_129_1 or var_129_1 * (var_129_6 / var_129_5)

				if var_129_7 > 0 and var_129_1 < var_129_7 then
					arg_126_1.talkMaxDuration = var_129_7

					if var_129_7 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_7 + var_129_0
					end
				end

				arg_126_1.text_.text = var_129_4
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602029", "story_v_out_325602.awb") ~= 0 then
					local var_129_8 = manager.audio:GetVoiceLength("story_v_out_325602", "325602029", "story_v_out_325602.awb") / 1000

					if var_129_8 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_8 + var_129_0
					end

					if var_129_3.prefab_name ~= "" and arg_126_1.actors_[var_129_3.prefab_name] ~= nil then
						local var_129_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_3.prefab_name].transform, "story_v_out_325602", "325602029", "story_v_out_325602.awb")

						arg_126_1:RecordAudio("325602029", var_129_9)
						arg_126_1:RecordAudio("325602029", var_129_9)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_325602", "325602029", "story_v_out_325602.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_325602", "325602029", "story_v_out_325602.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_10 = math.max(var_129_1, arg_126_1.talkMaxDuration)

			if var_129_0 <= arg_126_1.time_ and arg_126_1.time_ < var_129_0 + var_129_10 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_0) / var_129_10

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_0 + var_129_10 and arg_126_1.time_ < var_129_0 + var_129_10 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play325602030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 325602030
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play325602031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["10180ui_story"].transform
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.var_.moveOldPos10180ui_story = var_133_0.localPosition

				local var_133_2 = GameObjectTools.GetOrAddComponent(var_133_0.gameObject, typeof(DynamicBoneHelper))

				if var_133_2 then
					var_133_2:EnableDynamicBone(false)
				end
			end

			local var_133_3 = 0.001

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_3 then
				local var_133_4 = (arg_130_1.time_ - var_133_1) / var_133_3
				local var_133_5 = Vector3.New(0, 100, 0)

				var_133_0.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10180ui_story, var_133_5, var_133_4)

				local var_133_6 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_6.x, var_133_6.y, var_133_6.z)

				local var_133_7 = var_133_0.localEulerAngles

				var_133_7.z = 0
				var_133_7.x = 0
				var_133_0.localEulerAngles = var_133_7
			end

			if arg_130_1.time_ >= var_133_1 + var_133_3 and arg_130_1.time_ < var_133_1 + var_133_3 + arg_133_0 then
				var_133_0.localPosition = Vector3.New(0, 100, 0)

				local var_133_8 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_8.x, var_133_8.y, var_133_8.z)

				local var_133_9 = var_133_0.localEulerAngles

				var_133_9.z = 0
				var_133_9.x = 0
				var_133_0.localEulerAngles = var_133_9

				local var_133_10 = GameObjectTools.GetOrAddComponent(var_133_0.gameObject, typeof(DynamicBoneHelper))

				if var_133_10 then
					var_133_10:EnableDynamicBone(true)
				end
			end

			local var_133_11 = arg_130_1.actors_["10180ui_story"]
			local var_133_12 = 0

			if var_133_12 < arg_130_1.time_ and arg_130_1.time_ <= var_133_12 + arg_133_0 and not isNil(var_133_11) and arg_130_1.var_.characterEffect10180ui_story == nil then
				arg_130_1.var_.characterEffect10180ui_story = var_133_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_13 = 0.200000002980232

			if var_133_12 <= arg_130_1.time_ and arg_130_1.time_ < var_133_12 + var_133_13 and not isNil(var_133_11) then
				local var_133_14 = (arg_130_1.time_ - var_133_12) / var_133_13

				if arg_130_1.var_.characterEffect10180ui_story and not isNil(var_133_11) then
					local var_133_15 = Mathf.Lerp(0, 0.5, var_133_14)

					arg_130_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_130_1.var_.characterEffect10180ui_story.fillRatio = var_133_15
				end
			end

			if arg_130_1.time_ >= var_133_12 + var_133_13 and arg_130_1.time_ < var_133_12 + var_133_13 + arg_133_0 and not isNil(var_133_11) and arg_130_1.var_.characterEffect10180ui_story then
				local var_133_16 = 0.5

				arg_130_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_130_1.var_.characterEffect10180ui_story.fillRatio = var_133_16
			end

			local var_133_17 = 0
			local var_133_18 = 0.6

			if var_133_17 < arg_130_1.time_ and arg_130_1.time_ <= var_133_17 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_19 = arg_130_1:FormatText(StoryNameCfg[7].name)

				arg_130_1.leftNameTxt_.text = var_133_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_20 = arg_130_1:GetWordFromCfg(325602030)
				local var_133_21 = arg_130_1:FormatText(var_133_20.content)

				arg_130_1.text_.text = var_133_21

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_22 = 24
				local var_133_23 = utf8.len(var_133_21)
				local var_133_24 = var_133_22 <= 0 and var_133_18 or var_133_18 * (var_133_23 / var_133_22)

				if var_133_24 > 0 and var_133_18 < var_133_24 then
					arg_130_1.talkMaxDuration = var_133_24

					if var_133_24 + var_133_17 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_24 + var_133_17
					end
				end

				arg_130_1.text_.text = var_133_21
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_25 = math.max(var_133_18, arg_130_1.talkMaxDuration)

			if var_133_17 <= arg_130_1.time_ and arg_130_1.time_ < var_133_17 + var_133_25 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_17) / var_133_25

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_17 + var_133_25 and arg_130_1.time_ < var_133_17 + var_133_25 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play325602031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 325602031
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play325602032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 1

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_2 = arg_134_1:FormatText(StoryNameCfg[7].name)

				arg_134_1.leftNameTxt_.text = var_137_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_3 = arg_134_1:GetWordFromCfg(325602031)
				local var_137_4 = arg_134_1:FormatText(var_137_3.content)

				arg_134_1.text_.text = var_137_4

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 40
				local var_137_6 = utf8.len(var_137_4)
				local var_137_7 = var_137_5 <= 0 and var_137_1 or var_137_1 * (var_137_6 / var_137_5)

				if var_137_7 > 0 and var_137_1 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_4
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_8 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_8 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_8

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_8 and arg_134_1.time_ < var_137_0 + var_137_8 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play325602032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 325602032
		arg_138_1.duration_ = 14.33

		local var_138_0 = {
			zh = 12.133,
			ja = 14.333
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
				arg_138_0:Play325602033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["10180ui_story"].transform
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.var_.moveOldPos10180ui_story = var_141_0.localPosition

				local var_141_2 = GameObjectTools.GetOrAddComponent(var_141_0.gameObject, typeof(DynamicBoneHelper))

				if var_141_2 then
					var_141_2:EnableDynamicBone(false)
				end
			end

			local var_141_3 = 0.001

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_3 then
				local var_141_4 = (arg_138_1.time_ - var_141_1) / var_141_3
				local var_141_5 = Vector3.New(0, 100, 0)

				var_141_0.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10180ui_story, var_141_5, var_141_4)

				local var_141_6 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_6.x, var_141_6.y, var_141_6.z)

				local var_141_7 = var_141_0.localEulerAngles

				var_141_7.z = 0
				var_141_7.x = 0
				var_141_0.localEulerAngles = var_141_7
			end

			if arg_138_1.time_ >= var_141_1 + var_141_3 and arg_138_1.time_ < var_141_1 + var_141_3 + arg_141_0 then
				var_141_0.localPosition = Vector3.New(0, 100, 0)

				local var_141_8 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_8.x, var_141_8.y, var_141_8.z)

				local var_141_9 = var_141_0.localEulerAngles

				var_141_9.z = 0
				var_141_9.x = 0
				var_141_0.localEulerAngles = var_141_9

				local var_141_10 = GameObjectTools.GetOrAddComponent(var_141_0.gameObject, typeof(DynamicBoneHelper))

				if var_141_10 then
					var_141_10:EnableDynamicBone(true)
				end
			end

			local var_141_11 = arg_138_1.actors_["10180ui_story"]
			local var_141_12 = 0

			if var_141_12 < arg_138_1.time_ and arg_138_1.time_ <= var_141_12 + arg_141_0 and not isNil(var_141_11) and arg_138_1.var_.characterEffect10180ui_story == nil then
				arg_138_1.var_.characterEffect10180ui_story = var_141_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_13 = 0.200000002980232

			if var_141_12 <= arg_138_1.time_ and arg_138_1.time_ < var_141_12 + var_141_13 and not isNil(var_141_11) then
				local var_141_14 = (arg_138_1.time_ - var_141_12) / var_141_13

				if arg_138_1.var_.characterEffect10180ui_story and not isNil(var_141_11) then
					arg_138_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_12 + var_141_13 and arg_138_1.time_ < var_141_12 + var_141_13 + arg_141_0 and not isNil(var_141_11) and arg_138_1.var_.characterEffect10180ui_story then
				arg_138_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_141_15 = 0
			local var_141_16 = 1.025

			if var_141_15 < arg_138_1.time_ and arg_138_1.time_ <= var_141_15 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_17 = arg_138_1:FormatText(StoryNameCfg[1503].name)

				arg_138_1.leftNameTxt_.text = var_141_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_18 = arg_138_1:GetWordFromCfg(325602032)
				local var_141_19 = arg_138_1:FormatText(var_141_18.content)

				arg_138_1.text_.text = var_141_19

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_20 = 41
				local var_141_21 = utf8.len(var_141_19)
				local var_141_22 = var_141_20 <= 0 and var_141_16 or var_141_16 * (var_141_21 / var_141_20)

				if var_141_22 > 0 and var_141_16 < var_141_22 then
					arg_138_1.talkMaxDuration = var_141_22

					if var_141_22 + var_141_15 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_22 + var_141_15
					end
				end

				arg_138_1.text_.text = var_141_19
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602032", "story_v_out_325602.awb") ~= 0 then
					local var_141_23 = manager.audio:GetVoiceLength("story_v_out_325602", "325602032", "story_v_out_325602.awb") / 1000

					if var_141_23 + var_141_15 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_23 + var_141_15
					end

					if var_141_18.prefab_name ~= "" and arg_138_1.actors_[var_141_18.prefab_name] ~= nil then
						local var_141_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_18.prefab_name].transform, "story_v_out_325602", "325602032", "story_v_out_325602.awb")

						arg_138_1:RecordAudio("325602032", var_141_24)
						arg_138_1:RecordAudio("325602032", var_141_24)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_325602", "325602032", "story_v_out_325602.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_325602", "325602032", "story_v_out_325602.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_25 = math.max(var_141_16, arg_138_1.talkMaxDuration)

			if var_141_15 <= arg_138_1.time_ and arg_138_1.time_ < var_141_15 + var_141_25 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_15) / var_141_25

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_15 + var_141_25 and arg_138_1.time_ < var_141_15 + var_141_25 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play325602033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 325602033
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play325602034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["10180ui_story"].transform
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.var_.moveOldPos10180ui_story = var_145_0.localPosition

				local var_145_2 = GameObjectTools.GetOrAddComponent(var_145_0.gameObject, typeof(DynamicBoneHelper))

				if var_145_2 then
					var_145_2:EnableDynamicBone(false)
				end
			end

			local var_145_3 = 0.001

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_3 then
				local var_145_4 = (arg_142_1.time_ - var_145_1) / var_145_3
				local var_145_5 = Vector3.New(0, 100, 0)

				var_145_0.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10180ui_story, var_145_5, var_145_4)

				local var_145_6 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_6.x, var_145_6.y, var_145_6.z)

				local var_145_7 = var_145_0.localEulerAngles

				var_145_7.z = 0
				var_145_7.x = 0
				var_145_0.localEulerAngles = var_145_7
			end

			if arg_142_1.time_ >= var_145_1 + var_145_3 and arg_142_1.time_ < var_145_1 + var_145_3 + arg_145_0 then
				var_145_0.localPosition = Vector3.New(0, 100, 0)

				local var_145_8 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_8.x, var_145_8.y, var_145_8.z)

				local var_145_9 = var_145_0.localEulerAngles

				var_145_9.z = 0
				var_145_9.x = 0
				var_145_0.localEulerAngles = var_145_9

				local var_145_10 = GameObjectTools.GetOrAddComponent(var_145_0.gameObject, typeof(DynamicBoneHelper))

				if var_145_10 then
					var_145_10:EnableDynamicBone(true)
				end
			end

			local var_145_11 = arg_142_1.actors_["10180ui_story"]
			local var_145_12 = 0

			if var_145_12 < arg_142_1.time_ and arg_142_1.time_ <= var_145_12 + arg_145_0 and not isNil(var_145_11) and arg_142_1.var_.characterEffect10180ui_story == nil then
				arg_142_1.var_.characterEffect10180ui_story = var_145_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_13 = 0.200000002980232

			if var_145_12 <= arg_142_1.time_ and arg_142_1.time_ < var_145_12 + var_145_13 and not isNil(var_145_11) then
				local var_145_14 = (arg_142_1.time_ - var_145_12) / var_145_13

				if arg_142_1.var_.characterEffect10180ui_story and not isNil(var_145_11) then
					local var_145_15 = Mathf.Lerp(0, 0.5, var_145_14)

					arg_142_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_142_1.var_.characterEffect10180ui_story.fillRatio = var_145_15
				end
			end

			if arg_142_1.time_ >= var_145_12 + var_145_13 and arg_142_1.time_ < var_145_12 + var_145_13 + arg_145_0 and not isNil(var_145_11) and arg_142_1.var_.characterEffect10180ui_story then
				local var_145_16 = 0.5

				arg_142_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_142_1.var_.characterEffect10180ui_story.fillRatio = var_145_16
			end

			local var_145_17 = 0
			local var_145_18 = 0.975

			if var_145_17 < arg_142_1.time_ and arg_142_1.time_ <= var_145_17 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_19 = arg_142_1:FormatText(StoryNameCfg[7].name)

				arg_142_1.leftNameTxt_.text = var_145_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_20 = arg_142_1:GetWordFromCfg(325602033)
				local var_145_21 = arg_142_1:FormatText(var_145_20.content)

				arg_142_1.text_.text = var_145_21

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_22 = 39
				local var_145_23 = utf8.len(var_145_21)
				local var_145_24 = var_145_22 <= 0 and var_145_18 or var_145_18 * (var_145_23 / var_145_22)

				if var_145_24 > 0 and var_145_18 < var_145_24 then
					arg_142_1.talkMaxDuration = var_145_24

					if var_145_24 + var_145_17 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_24 + var_145_17
					end
				end

				arg_142_1.text_.text = var_145_21
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_25 = math.max(var_145_18, arg_142_1.talkMaxDuration)

			if var_145_17 <= arg_142_1.time_ and arg_142_1.time_ < var_145_17 + var_145_25 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_17) / var_145_25

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_17 + var_145_25 and arg_142_1.time_ < var_145_17 + var_145_25 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
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
	Play325602034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 325602034
		arg_146_1.duration_ = 20.6

		local var_146_0 = {
			zh = 9.733,
			ja = 20.6
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
				arg_146_0:Play325602035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["10180ui_story"].transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.moveOldPos10180ui_story = var_149_0.localPosition

				local var_149_2 = GameObjectTools.GetOrAddComponent(var_149_0.gameObject, typeof(DynamicBoneHelper))

				if var_149_2 then
					var_149_2:EnableDynamicBone(false)
				end
			end

			local var_149_3 = 0.001

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_3 then
				local var_149_4 = (arg_146_1.time_ - var_149_1) / var_149_3
				local var_149_5 = Vector3.New(0, 100, 0)

				var_149_0.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos10180ui_story, var_149_5, var_149_4)

				local var_149_6 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_6.x, var_149_6.y, var_149_6.z)

				local var_149_7 = var_149_0.localEulerAngles

				var_149_7.z = 0
				var_149_7.x = 0
				var_149_0.localEulerAngles = var_149_7
			end

			if arg_146_1.time_ >= var_149_1 + var_149_3 and arg_146_1.time_ < var_149_1 + var_149_3 + arg_149_0 then
				var_149_0.localPosition = Vector3.New(0, 100, 0)

				local var_149_8 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_8.x, var_149_8.y, var_149_8.z)

				local var_149_9 = var_149_0.localEulerAngles

				var_149_9.z = 0
				var_149_9.x = 0
				var_149_0.localEulerAngles = var_149_9

				local var_149_10 = GameObjectTools.GetOrAddComponent(var_149_0.gameObject, typeof(DynamicBoneHelper))

				if var_149_10 then
					var_149_10:EnableDynamicBone(true)
				end
			end

			local var_149_11 = arg_146_1.actors_["10180ui_story"]
			local var_149_12 = 0

			if var_149_12 < arg_146_1.time_ and arg_146_1.time_ <= var_149_12 + arg_149_0 and not isNil(var_149_11) and arg_146_1.var_.characterEffect10180ui_story == nil then
				arg_146_1.var_.characterEffect10180ui_story = var_149_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_13 = 0.200000002980232

			if var_149_12 <= arg_146_1.time_ and arg_146_1.time_ < var_149_12 + var_149_13 and not isNil(var_149_11) then
				local var_149_14 = (arg_146_1.time_ - var_149_12) / var_149_13

				if arg_146_1.var_.characterEffect10180ui_story and not isNil(var_149_11) then
					arg_146_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_12 + var_149_13 and arg_146_1.time_ < var_149_12 + var_149_13 + arg_149_0 and not isNil(var_149_11) and arg_146_1.var_.characterEffect10180ui_story then
				arg_146_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_149_15 = 0
			local var_149_16 = 0.925

			if var_149_15 < arg_146_1.time_ and arg_146_1.time_ <= var_149_15 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_17 = arg_146_1:FormatText(StoryNameCfg[1503].name)

				arg_146_1.leftNameTxt_.text = var_149_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_18 = arg_146_1:GetWordFromCfg(325602034)
				local var_149_19 = arg_146_1:FormatText(var_149_18.content)

				arg_146_1.text_.text = var_149_19

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_20 = 37
				local var_149_21 = utf8.len(var_149_19)
				local var_149_22 = var_149_20 <= 0 and var_149_16 or var_149_16 * (var_149_21 / var_149_20)

				if var_149_22 > 0 and var_149_16 < var_149_22 then
					arg_146_1.talkMaxDuration = var_149_22

					if var_149_22 + var_149_15 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_22 + var_149_15
					end
				end

				arg_146_1.text_.text = var_149_19
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602034", "story_v_out_325602.awb") ~= 0 then
					local var_149_23 = manager.audio:GetVoiceLength("story_v_out_325602", "325602034", "story_v_out_325602.awb") / 1000

					if var_149_23 + var_149_15 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_23 + var_149_15
					end

					if var_149_18.prefab_name ~= "" and arg_146_1.actors_[var_149_18.prefab_name] ~= nil then
						local var_149_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_18.prefab_name].transform, "story_v_out_325602", "325602034", "story_v_out_325602.awb")

						arg_146_1:RecordAudio("325602034", var_149_24)
						arg_146_1:RecordAudio("325602034", var_149_24)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_325602", "325602034", "story_v_out_325602.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_325602", "325602034", "story_v_out_325602.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_25 = math.max(var_149_16, arg_146_1.talkMaxDuration)

			if var_149_15 <= arg_146_1.time_ and arg_146_1.time_ < var_149_15 + var_149_25 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_15) / var_149_25

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_15 + var_149_25 and arg_146_1.time_ < var_149_15 + var_149_25 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
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
	Play325602035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 325602035
		arg_150_1.duration_ = 5.57

		local var_150_0 = {
			zh = 4.5,
			ja = 5.566
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
				arg_150_0:Play325602036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 0.325

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_2 = arg_150_1:FormatText(StoryNameCfg[1503].name)

				arg_150_1.leftNameTxt_.text = var_153_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_3 = arg_150_1:GetWordFromCfg(325602035)
				local var_153_4 = arg_150_1:FormatText(var_153_3.content)

				arg_150_1.text_.text = var_153_4

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 13
				local var_153_6 = utf8.len(var_153_4)
				local var_153_7 = var_153_5 <= 0 and var_153_1 or var_153_1 * (var_153_6 / var_153_5)

				if var_153_7 > 0 and var_153_1 < var_153_7 then
					arg_150_1.talkMaxDuration = var_153_7

					if var_153_7 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_7 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_4
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602035", "story_v_out_325602.awb") ~= 0 then
					local var_153_8 = manager.audio:GetVoiceLength("story_v_out_325602", "325602035", "story_v_out_325602.awb") / 1000

					if var_153_8 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_8 + var_153_0
					end

					if var_153_3.prefab_name ~= "" and arg_150_1.actors_[var_153_3.prefab_name] ~= nil then
						local var_153_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_3.prefab_name].transform, "story_v_out_325602", "325602035", "story_v_out_325602.awb")

						arg_150_1:RecordAudio("325602035", var_153_9)
						arg_150_1:RecordAudio("325602035", var_153_9)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_325602", "325602035", "story_v_out_325602.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_325602", "325602035", "story_v_out_325602.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_10 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_10 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_10

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_10 and arg_150_1.time_ < var_153_0 + var_153_10 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play325602036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 325602036
		arg_154_1.duration_ = 1.83

		local var_154_0 = {
			zh = 1.766,
			ja = 1.833
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
				arg_154_0:Play325602037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["10180ui_story"].transform
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.var_.moveOldPos10180ui_story = var_157_0.localPosition

				local var_157_2 = GameObjectTools.GetOrAddComponent(var_157_0.gameObject, typeof(DynamicBoneHelper))

				if var_157_2 then
					var_157_2:EnableDynamicBone(false)
				end
			end

			local var_157_3 = 0.001

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_3 then
				local var_157_4 = (arg_154_1.time_ - var_157_1) / var_157_3
				local var_157_5 = Vector3.New(0, 100, 0)

				var_157_0.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos10180ui_story, var_157_5, var_157_4)

				local var_157_6 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_6.x, var_157_6.y, var_157_6.z)

				local var_157_7 = var_157_0.localEulerAngles

				var_157_7.z = 0
				var_157_7.x = 0
				var_157_0.localEulerAngles = var_157_7
			end

			if arg_154_1.time_ >= var_157_1 + var_157_3 and arg_154_1.time_ < var_157_1 + var_157_3 + arg_157_0 then
				var_157_0.localPosition = Vector3.New(0, 100, 0)

				local var_157_8 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_8.x, var_157_8.y, var_157_8.z)

				local var_157_9 = var_157_0.localEulerAngles

				var_157_9.z = 0
				var_157_9.x = 0
				var_157_0.localEulerAngles = var_157_9

				local var_157_10 = GameObjectTools.GetOrAddComponent(var_157_0.gameObject, typeof(DynamicBoneHelper))

				if var_157_10 then
					var_157_10:EnableDynamicBone(true)
				end
			end

			local var_157_11 = arg_154_1.actors_["10170ui_story"].transform
			local var_157_12 = 0

			if var_157_12 < arg_154_1.time_ and arg_154_1.time_ <= var_157_12 + arg_157_0 then
				arg_154_1.var_.moveOldPos10170ui_story = var_157_11.localPosition

				local var_157_13 = GameObjectTools.GetOrAddComponent(var_157_11.gameObject, typeof(DynamicBoneHelper))

				if var_157_13 then
					var_157_13:EnableDynamicBone(false)
				end
			end

			local var_157_14 = 0.001

			if var_157_12 <= arg_154_1.time_ and arg_154_1.time_ < var_157_12 + var_157_14 then
				local var_157_15 = (arg_154_1.time_ - var_157_12) / var_157_14
				local var_157_16 = Vector3.New(0, 100, 0)

				var_157_11.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos10170ui_story, var_157_16, var_157_15)

				local var_157_17 = manager.ui.mainCamera.transform.position - var_157_11.position

				var_157_11.forward = Vector3.New(var_157_17.x, var_157_17.y, var_157_17.z)

				local var_157_18 = var_157_11.localEulerAngles

				var_157_18.z = 0
				var_157_18.x = 0
				var_157_11.localEulerAngles = var_157_18
			end

			if arg_154_1.time_ >= var_157_12 + var_157_14 and arg_154_1.time_ < var_157_12 + var_157_14 + arg_157_0 then
				var_157_11.localPosition = Vector3.New(0, 100, 0)

				local var_157_19 = manager.ui.mainCamera.transform.position - var_157_11.position

				var_157_11.forward = Vector3.New(var_157_19.x, var_157_19.y, var_157_19.z)

				local var_157_20 = var_157_11.localEulerAngles

				var_157_20.z = 0
				var_157_20.x = 0
				var_157_11.localEulerAngles = var_157_20

				local var_157_21 = GameObjectTools.GetOrAddComponent(var_157_11.gameObject, typeof(DynamicBoneHelper))

				if var_157_21 then
					var_157_21:EnableDynamicBone(true)
				end
			end

			local var_157_22 = arg_154_1.actors_["10170ui_story"]
			local var_157_23 = 0

			if var_157_23 < arg_154_1.time_ and arg_154_1.time_ <= var_157_23 + arg_157_0 and not isNil(var_157_22) and arg_154_1.var_.characterEffect10170ui_story == nil then
				arg_154_1.var_.characterEffect10170ui_story = var_157_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_24 = 0.200000002980232

			if var_157_23 <= arg_154_1.time_ and arg_154_1.time_ < var_157_23 + var_157_24 and not isNil(var_157_22) then
				local var_157_25 = (arg_154_1.time_ - var_157_23) / var_157_24

				if arg_154_1.var_.characterEffect10170ui_story and not isNil(var_157_22) then
					arg_154_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_23 + var_157_24 and arg_154_1.time_ < var_157_23 + var_157_24 + arg_157_0 and not isNil(var_157_22) and arg_154_1.var_.characterEffect10170ui_story then
				arg_154_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_157_26 = arg_154_1.actors_["10180ui_story"]
			local var_157_27 = 0

			if var_157_27 < arg_154_1.time_ and arg_154_1.time_ <= var_157_27 + arg_157_0 and not isNil(var_157_26) and arg_154_1.var_.characterEffect10180ui_story == nil then
				arg_154_1.var_.characterEffect10180ui_story = var_157_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_28 = 0.200000002980232

			if var_157_27 <= arg_154_1.time_ and arg_154_1.time_ < var_157_27 + var_157_28 and not isNil(var_157_26) then
				local var_157_29 = (arg_154_1.time_ - var_157_27) / var_157_28

				if arg_154_1.var_.characterEffect10180ui_story and not isNil(var_157_26) then
					local var_157_30 = Mathf.Lerp(0, 0.5, var_157_29)

					arg_154_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_154_1.var_.characterEffect10180ui_story.fillRatio = var_157_30
				end
			end

			if arg_154_1.time_ >= var_157_27 + var_157_28 and arg_154_1.time_ < var_157_27 + var_157_28 + arg_157_0 and not isNil(var_157_26) and arg_154_1.var_.characterEffect10180ui_story then
				local var_157_31 = 0.5

				arg_154_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_154_1.var_.characterEffect10180ui_story.fillRatio = var_157_31
			end

			local var_157_32 = 0
			local var_157_33 = 0.225

			if var_157_32 < arg_154_1.time_ and arg_154_1.time_ <= var_157_32 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_34 = arg_154_1:FormatText(StoryNameCfg[1450].name)

				arg_154_1.leftNameTxt_.text = var_157_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_35 = arg_154_1:GetWordFromCfg(325602036)
				local var_157_36 = arg_154_1:FormatText(var_157_35.content)

				arg_154_1.text_.text = var_157_36

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_37 = 9
				local var_157_38 = utf8.len(var_157_36)
				local var_157_39 = var_157_37 <= 0 and var_157_33 or var_157_33 * (var_157_38 / var_157_37)

				if var_157_39 > 0 and var_157_33 < var_157_39 then
					arg_154_1.talkMaxDuration = var_157_39

					if var_157_39 + var_157_32 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_39 + var_157_32
					end
				end

				arg_154_1.text_.text = var_157_36
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602036", "story_v_out_325602.awb") ~= 0 then
					local var_157_40 = manager.audio:GetVoiceLength("story_v_out_325602", "325602036", "story_v_out_325602.awb") / 1000

					if var_157_40 + var_157_32 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_40 + var_157_32
					end

					if var_157_35.prefab_name ~= "" and arg_154_1.actors_[var_157_35.prefab_name] ~= nil then
						local var_157_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_35.prefab_name].transform, "story_v_out_325602", "325602036", "story_v_out_325602.awb")

						arg_154_1:RecordAudio("325602036", var_157_41)
						arg_154_1:RecordAudio("325602036", var_157_41)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_325602", "325602036", "story_v_out_325602.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_325602", "325602036", "story_v_out_325602.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_42 = math.max(var_157_33, arg_154_1.talkMaxDuration)

			if var_157_32 <= arg_154_1.time_ and arg_154_1.time_ < var_157_32 + var_157_42 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_32) / var_157_42

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_32 + var_157_42 and arg_154_1.time_ < var_157_32 + var_157_42 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play325602037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 325602037
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play325602038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["10170ui_story"].transform
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.var_.moveOldPos10170ui_story = var_161_0.localPosition

				local var_161_2 = GameObjectTools.GetOrAddComponent(var_161_0.gameObject, typeof(DynamicBoneHelper))

				if var_161_2 then
					var_161_2:EnableDynamicBone(false)
				end
			end

			local var_161_3 = 0.001

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_3 then
				local var_161_4 = (arg_158_1.time_ - var_161_1) / var_161_3
				local var_161_5 = Vector3.New(0, 100, 0)

				var_161_0.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos10170ui_story, var_161_5, var_161_4)

				local var_161_6 = manager.ui.mainCamera.transform.position - var_161_0.position

				var_161_0.forward = Vector3.New(var_161_6.x, var_161_6.y, var_161_6.z)

				local var_161_7 = var_161_0.localEulerAngles

				var_161_7.z = 0
				var_161_7.x = 0
				var_161_0.localEulerAngles = var_161_7
			end

			if arg_158_1.time_ >= var_161_1 + var_161_3 and arg_158_1.time_ < var_161_1 + var_161_3 + arg_161_0 then
				var_161_0.localPosition = Vector3.New(0, 100, 0)

				local var_161_8 = manager.ui.mainCamera.transform.position - var_161_0.position

				var_161_0.forward = Vector3.New(var_161_8.x, var_161_8.y, var_161_8.z)

				local var_161_9 = var_161_0.localEulerAngles

				var_161_9.z = 0
				var_161_9.x = 0
				var_161_0.localEulerAngles = var_161_9

				local var_161_10 = GameObjectTools.GetOrAddComponent(var_161_0.gameObject, typeof(DynamicBoneHelper))

				if var_161_10 then
					var_161_10:EnableDynamicBone(true)
				end
			end

			local var_161_11 = arg_158_1.actors_["10170ui_story"]
			local var_161_12 = 0

			if var_161_12 < arg_158_1.time_ and arg_158_1.time_ <= var_161_12 + arg_161_0 and not isNil(var_161_11) and arg_158_1.var_.characterEffect10170ui_story == nil then
				arg_158_1.var_.characterEffect10170ui_story = var_161_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_13 = 0.200000002980232

			if var_161_12 <= arg_158_1.time_ and arg_158_1.time_ < var_161_12 + var_161_13 and not isNil(var_161_11) then
				local var_161_14 = (arg_158_1.time_ - var_161_12) / var_161_13

				if arg_158_1.var_.characterEffect10170ui_story and not isNil(var_161_11) then
					local var_161_15 = Mathf.Lerp(0, 0.5, var_161_14)

					arg_158_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_158_1.var_.characterEffect10170ui_story.fillRatio = var_161_15
				end
			end

			if arg_158_1.time_ >= var_161_12 + var_161_13 and arg_158_1.time_ < var_161_12 + var_161_13 + arg_161_0 and not isNil(var_161_11) and arg_158_1.var_.characterEffect10170ui_story then
				local var_161_16 = 0.5

				arg_158_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_158_1.var_.characterEffect10170ui_story.fillRatio = var_161_16
			end

			local var_161_17 = 0
			local var_161_18 = 0.075

			if var_161_17 < arg_158_1.time_ and arg_158_1.time_ <= var_161_17 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_19 = arg_158_1:FormatText(StoryNameCfg[7].name)

				arg_158_1.leftNameTxt_.text = var_161_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_20 = arg_158_1:GetWordFromCfg(325602037)
				local var_161_21 = arg_158_1:FormatText(var_161_20.content)

				arg_158_1.text_.text = var_161_21

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_22 = 3
				local var_161_23 = utf8.len(var_161_21)
				local var_161_24 = var_161_22 <= 0 and var_161_18 or var_161_18 * (var_161_23 / var_161_22)

				if var_161_24 > 0 and var_161_18 < var_161_24 then
					arg_158_1.talkMaxDuration = var_161_24

					if var_161_24 + var_161_17 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_24 + var_161_17
					end
				end

				arg_158_1.text_.text = var_161_21
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_25 = math.max(var_161_18, arg_158_1.talkMaxDuration)

			if var_161_17 <= arg_158_1.time_ and arg_158_1.time_ < var_161_17 + var_161_25 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_17) / var_161_25

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_17 + var_161_25 and arg_158_1.time_ < var_161_17 + var_161_25 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play325602038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 325602038
		arg_162_1.duration_ = 1.6

		local var_162_0 = {
			zh = 1.533,
			ja = 1.6
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
				arg_162_0:Play325602039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 0.175

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_2 = arg_162_1:FormatText(StoryNameCfg[1450].name)

				arg_162_1.leftNameTxt_.text = var_165_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_3 = arg_162_1:GetWordFromCfg(325602038)
				local var_165_4 = arg_162_1:FormatText(var_165_3.content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 7
				local var_165_6 = utf8.len(var_165_4)
				local var_165_7 = var_165_5 <= 0 and var_165_1 or var_165_1 * (var_165_6 / var_165_5)

				if var_165_7 > 0 and var_165_1 < var_165_7 then
					arg_162_1.talkMaxDuration = var_165_7

					if var_165_7 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602038", "story_v_out_325602.awb") ~= 0 then
					local var_165_8 = manager.audio:GetVoiceLength("story_v_out_325602", "325602038", "story_v_out_325602.awb") / 1000

					if var_165_8 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_8 + var_165_0
					end

					if var_165_3.prefab_name ~= "" and arg_162_1.actors_[var_165_3.prefab_name] ~= nil then
						local var_165_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_3.prefab_name].transform, "story_v_out_325602", "325602038", "story_v_out_325602.awb")

						arg_162_1:RecordAudio("325602038", var_165_9)
						arg_162_1:RecordAudio("325602038", var_165_9)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_325602", "325602038", "story_v_out_325602.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_325602", "325602038", "story_v_out_325602.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_10 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_10 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_10

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_10 and arg_162_1.time_ < var_165_0 + var_165_10 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play325602039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 325602039
		arg_166_1.duration_ = 5.2

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play325602040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["10170ui_story"].transform
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.var_.moveOldPos10170ui_story = var_169_0.localPosition

				local var_169_2 = GameObjectTools.GetOrAddComponent(var_169_0.gameObject, typeof(DynamicBoneHelper))

				if var_169_2 then
					var_169_2:EnableDynamicBone(false)
				end
			end

			local var_169_3 = 0.001

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_3 then
				local var_169_4 = (arg_166_1.time_ - var_169_1) / var_169_3
				local var_169_5 = Vector3.New(0, 100, 0)

				var_169_0.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10170ui_story, var_169_5, var_169_4)

				local var_169_6 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_6.x, var_169_6.y, var_169_6.z)

				local var_169_7 = var_169_0.localEulerAngles

				var_169_7.z = 0
				var_169_7.x = 0
				var_169_0.localEulerAngles = var_169_7
			end

			if arg_166_1.time_ >= var_169_1 + var_169_3 and arg_166_1.time_ < var_169_1 + var_169_3 + arg_169_0 then
				var_169_0.localPosition = Vector3.New(0, 100, 0)

				local var_169_8 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_8.x, var_169_8.y, var_169_8.z)

				local var_169_9 = var_169_0.localEulerAngles

				var_169_9.z = 0
				var_169_9.x = 0
				var_169_0.localEulerAngles = var_169_9

				local var_169_10 = GameObjectTools.GetOrAddComponent(var_169_0.gameObject, typeof(DynamicBoneHelper))

				if var_169_10 then
					var_169_10:EnableDynamicBone(true)
				end
			end

			local var_169_11 = arg_166_1.actors_["10170ui_story"]
			local var_169_12 = 0

			if var_169_12 < arg_166_1.time_ and arg_166_1.time_ <= var_169_12 + arg_169_0 and not isNil(var_169_11) and arg_166_1.var_.characterEffect10170ui_story == nil then
				arg_166_1.var_.characterEffect10170ui_story = var_169_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_13 = 0.200000002980232

			if var_169_12 <= arg_166_1.time_ and arg_166_1.time_ < var_169_12 + var_169_13 and not isNil(var_169_11) then
				local var_169_14 = (arg_166_1.time_ - var_169_12) / var_169_13

				if arg_166_1.var_.characterEffect10170ui_story and not isNil(var_169_11) then
					local var_169_15 = Mathf.Lerp(0, 0.5, var_169_14)

					arg_166_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_166_1.var_.characterEffect10170ui_story.fillRatio = var_169_15
				end
			end

			if arg_166_1.time_ >= var_169_12 + var_169_13 and arg_166_1.time_ < var_169_12 + var_169_13 + arg_169_0 and not isNil(var_169_11) and arg_166_1.var_.characterEffect10170ui_story then
				local var_169_16 = 0.5

				arg_166_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_166_1.var_.characterEffect10170ui_story.fillRatio = var_169_16
			end

			local var_169_17 = manager.ui.mainCamera.transform
			local var_169_18 = 0.200000002980232

			if var_169_18 < arg_166_1.time_ and arg_166_1.time_ <= var_169_18 + arg_169_0 then
				arg_166_1.var_.shakeOldPos = var_169_17.localPosition
			end

			local var_169_19 = 0.433333330353101

			if var_169_18 <= arg_166_1.time_ and arg_166_1.time_ < var_169_18 + var_169_19 then
				local var_169_20 = (arg_166_1.time_ - var_169_18) / 0.066
				local var_169_21, var_169_22 = math.modf(var_169_20)

				var_169_17.localPosition = Vector3.New(var_169_22 * 0.13, var_169_22 * 0.13, var_169_22 * 0.13) + arg_166_1.var_.shakeOldPos
			end

			if arg_166_1.time_ >= var_169_18 + var_169_19 and arg_166_1.time_ < var_169_18 + var_169_19 + arg_169_0 then
				var_169_17.localPosition = arg_166_1.var_.shakeOldPos
			end

			local var_169_23 = 0

			if var_169_23 < arg_166_1.time_ and arg_166_1.time_ <= var_169_23 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			local var_169_24 = 1

			if arg_166_1.time_ >= var_169_23 + var_169_24 and arg_166_1.time_ < var_169_23 + var_169_24 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end

			if arg_166_1.frameCnt_ <= 1 then
				arg_166_1.dialog_:SetActive(false)
			end

			local var_169_25 = 0.200000002980232
			local var_169_26 = 1.325

			if var_169_25 < arg_166_1.time_ and arg_166_1.time_ <= var_169_25 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0

				arg_166_1.dialog_:SetActive(true)

				arg_166_1.dialogCg_.alpha = 0

				local var_169_27 = LeanTween.value(arg_166_1.dialog_, 0, 1, 0.3)

				var_169_27:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_166_1.dialogCg_.alpha = arg_170_0
				end))
				var_169_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_166_1.dialog_)
					var_169_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_166_1.duration_ = arg_166_1.duration_ + 0.3

				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_28 = arg_166_1:GetWordFromCfg(325602039)
				local var_169_29 = arg_166_1:FormatText(var_169_28.content)

				arg_166_1.text_.text = var_169_29

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_30 = 53
				local var_169_31 = utf8.len(var_169_29)
				local var_169_32 = var_169_30 <= 0 and var_169_26 or var_169_26 * (var_169_31 / var_169_30)

				if var_169_32 > 0 and var_169_26 < var_169_32 then
					arg_166_1.talkMaxDuration = var_169_32
					var_169_25 = var_169_25 + 0.3

					if var_169_32 + var_169_25 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_32 + var_169_25
					end
				end

				arg_166_1.text_.text = var_169_29
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_33 = var_169_25 + 0.3
			local var_169_34 = math.max(var_169_26, arg_166_1.talkMaxDuration)

			if var_169_33 <= arg_166_1.time_ and arg_166_1.time_ < var_169_33 + var_169_34 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_33) / var_169_34

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_33 + var_169_34 and arg_166_1.time_ < var_169_33 + var_169_34 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play325602040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 325602040
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play325602041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0
			local var_175_1 = 1.025

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_2 = arg_172_1:GetWordFromCfg(325602040)
				local var_175_3 = arg_172_1:FormatText(var_175_2.content)

				arg_172_1.text_.text = var_175_3

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 41
				local var_175_5 = utf8.len(var_175_3)
				local var_175_6 = var_175_4 <= 0 and var_175_1 or var_175_1 * (var_175_5 / var_175_4)

				if var_175_6 > 0 and var_175_1 < var_175_6 then
					arg_172_1.talkMaxDuration = var_175_6

					if var_175_6 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_6 + var_175_0
					end
				end

				arg_172_1.text_.text = var_175_3
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_1, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_0) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_7 and arg_172_1.time_ < var_175_0 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play325602041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 325602041
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play325602042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = manager.ui.mainCamera.transform
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				local var_179_2 = arg_176_1.var_.effectwangshucijian1
				local var_179_3
				local var_179_4 = var_179_0

				if not var_179_2 then
					var_179_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), var_179_4)
					var_179_2.name = "wangshucijian1"
					arg_176_1.var_.effectwangshucijian1 = var_179_2
				else
					var_179_2.transform:SetParent(var_179_4)
				end

				var_179_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_179_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_179_5 = 0
			local var_179_6 = 1.425

			if var_179_5 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_7 = arg_176_1:GetWordFromCfg(325602041)
				local var_179_8 = arg_176_1:FormatText(var_179_7.content)

				arg_176_1.text_.text = var_179_8

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_9 = 57
				local var_179_10 = utf8.len(var_179_8)
				local var_179_11 = var_179_9 <= 0 and var_179_6 or var_179_6 * (var_179_10 / var_179_9)

				if var_179_11 > 0 and var_179_6 < var_179_11 then
					arg_176_1.talkMaxDuration = var_179_11

					if var_179_11 + var_179_5 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_11 + var_179_5
					end
				end

				arg_176_1.text_.text = var_179_8
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_12 = math.max(var_179_6, arg_176_1.talkMaxDuration)

			if var_179_5 <= arg_176_1.time_ and arg_176_1.time_ < var_179_5 + var_179_12 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_5) / var_179_12

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_5 + var_179_12 and arg_176_1.time_ < var_179_5 + var_179_12 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play325602042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 325602042
		arg_180_1.duration_ = 2.9

		local var_180_0 = {
			zh = 2.133,
			ja = 2.9
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play325602043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0
			local var_183_1 = 0.175

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_2 = arg_180_1:FormatText(StoryNameCfg[1503].name)

				arg_180_1.leftNameTxt_.text = var_183_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_3 = arg_180_1:GetWordFromCfg(325602042)
				local var_183_4 = arg_180_1:FormatText(var_183_3.content)

				arg_180_1.text_.text = var_183_4

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_5 = 7
				local var_183_6 = utf8.len(var_183_4)
				local var_183_7 = var_183_5 <= 0 and var_183_1 or var_183_1 * (var_183_6 / var_183_5)

				if var_183_7 > 0 and var_183_1 < var_183_7 then
					arg_180_1.talkMaxDuration = var_183_7

					if var_183_7 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_0
					end
				end

				arg_180_1.text_.text = var_183_4
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602042", "story_v_out_325602.awb") ~= 0 then
					local var_183_8 = manager.audio:GetVoiceLength("story_v_out_325602", "325602042", "story_v_out_325602.awb") / 1000

					if var_183_8 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_8 + var_183_0
					end

					if var_183_3.prefab_name ~= "" and arg_180_1.actors_[var_183_3.prefab_name] ~= nil then
						local var_183_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_3.prefab_name].transform, "story_v_out_325602", "325602042", "story_v_out_325602.awb")

						arg_180_1:RecordAudio("325602042", var_183_9)
						arg_180_1:RecordAudio("325602042", var_183_9)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_325602", "325602042", "story_v_out_325602.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_325602", "325602042", "story_v_out_325602.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_10 = math.max(var_183_1, arg_180_1.talkMaxDuration)

			if var_183_0 <= arg_180_1.time_ and arg_180_1.time_ < var_183_0 + var_183_10 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_0) / var_183_10

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_0 + var_183_10 and arg_180_1.time_ < var_183_0 + var_183_10 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play325602043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 325602043
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play325602044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10180ui_story"].transform
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.var_.moveOldPos10180ui_story = var_187_0.localPosition

				local var_187_2 = GameObjectTools.GetOrAddComponent(var_187_0.gameObject, typeof(DynamicBoneHelper))

				if var_187_2 then
					var_187_2:EnableDynamicBone(false)
				end
			end

			local var_187_3 = 0.001

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_3 then
				local var_187_4 = (arg_184_1.time_ - var_187_1) / var_187_3
				local var_187_5 = Vector3.New(0, 100, 0)

				var_187_0.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10180ui_story, var_187_5, var_187_4)

				local var_187_6 = manager.ui.mainCamera.transform.position - var_187_0.position

				var_187_0.forward = Vector3.New(var_187_6.x, var_187_6.y, var_187_6.z)

				local var_187_7 = var_187_0.localEulerAngles

				var_187_7.z = 0
				var_187_7.x = 0
				var_187_0.localEulerAngles = var_187_7
			end

			if arg_184_1.time_ >= var_187_1 + var_187_3 and arg_184_1.time_ < var_187_1 + var_187_3 + arg_187_0 then
				var_187_0.localPosition = Vector3.New(0, 100, 0)

				local var_187_8 = manager.ui.mainCamera.transform.position - var_187_0.position

				var_187_0.forward = Vector3.New(var_187_8.x, var_187_8.y, var_187_8.z)

				local var_187_9 = var_187_0.localEulerAngles

				var_187_9.z = 0
				var_187_9.x = 0
				var_187_0.localEulerAngles = var_187_9

				local var_187_10 = GameObjectTools.GetOrAddComponent(var_187_0.gameObject, typeof(DynamicBoneHelper))

				if var_187_10 then
					var_187_10:EnableDynamicBone(true)
				end
			end

			local var_187_11 = arg_184_1.actors_["10180ui_story"]
			local var_187_12 = 0

			if var_187_12 < arg_184_1.time_ and arg_184_1.time_ <= var_187_12 + arg_187_0 and not isNil(var_187_11) and arg_184_1.var_.characterEffect10180ui_story == nil then
				arg_184_1.var_.characterEffect10180ui_story = var_187_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_13 = 0.200000002980232

			if var_187_12 <= arg_184_1.time_ and arg_184_1.time_ < var_187_12 + var_187_13 and not isNil(var_187_11) then
				local var_187_14 = (arg_184_1.time_ - var_187_12) / var_187_13

				if arg_184_1.var_.characterEffect10180ui_story and not isNil(var_187_11) then
					local var_187_15 = Mathf.Lerp(0, 0.5, var_187_14)

					arg_184_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_184_1.var_.characterEffect10180ui_story.fillRatio = var_187_15
				end
			end

			if arg_184_1.time_ >= var_187_12 + var_187_13 and arg_184_1.time_ < var_187_12 + var_187_13 + arg_187_0 and not isNil(var_187_11) and arg_184_1.var_.characterEffect10180ui_story then
				local var_187_16 = 0.5

				arg_184_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_184_1.var_.characterEffect10180ui_story.fillRatio = var_187_16
			end

			local var_187_17 = 0.1
			local var_187_18 = 1

			if var_187_17 < arg_184_1.time_ and arg_184_1.time_ <= var_187_17 + arg_187_0 then
				local var_187_19 = "play"
				local var_187_20 = "effect"

				arg_184_1:AudioAction(var_187_19, var_187_20, "se_story_143", "se_story_143_magic_fire", "")
			end

			local var_187_21 = 0
			local var_187_22 = 0.925

			if var_187_21 < arg_184_1.time_ and arg_184_1.time_ <= var_187_21 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_23 = arg_184_1:GetWordFromCfg(325602043)
				local var_187_24 = arg_184_1:FormatText(var_187_23.content)

				arg_184_1.text_.text = var_187_24

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_25 = 37
				local var_187_26 = utf8.len(var_187_24)
				local var_187_27 = var_187_25 <= 0 and var_187_22 or var_187_22 * (var_187_26 / var_187_25)

				if var_187_27 > 0 and var_187_22 < var_187_27 then
					arg_184_1.talkMaxDuration = var_187_27

					if var_187_27 + var_187_21 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_27 + var_187_21
					end
				end

				arg_184_1.text_.text = var_187_24
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_28 = math.max(var_187_22, arg_184_1.talkMaxDuration)

			if var_187_21 <= arg_184_1.time_ and arg_184_1.time_ < var_187_21 + var_187_28 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_21) / var_187_28

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_21 + var_187_28 and arg_184_1.time_ < var_187_21 + var_187_28 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play325602044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 325602044
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play325602045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0
			local var_191_1 = 1.4

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_2 = arg_188_1:GetWordFromCfg(325602044)
				local var_191_3 = arg_188_1:FormatText(var_191_2.content)

				arg_188_1.text_.text = var_191_3

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_4 = 56
				local var_191_5 = utf8.len(var_191_3)
				local var_191_6 = var_191_4 <= 0 and var_191_1 or var_191_1 * (var_191_5 / var_191_4)

				if var_191_6 > 0 and var_191_1 < var_191_6 then
					arg_188_1.talkMaxDuration = var_191_6

					if var_191_6 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_6 + var_191_0
					end
				end

				arg_188_1.text_.text = var_191_3
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_7 = math.max(var_191_1, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_7 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_0) / var_191_7

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_7 and arg_188_1.time_ < var_191_0 + var_191_7 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play325602045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 325602045
		arg_192_1.duration_ = 9

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play325602046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 2

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				local var_195_1 = manager.ui.mainCamera.transform.localPosition
				local var_195_2 = Vector3.New(0, 0, 10) + Vector3.New(var_195_1.x, var_195_1.y, 0)
				local var_195_3 = arg_192_1.bgs_.J25f

				var_195_3.transform.localPosition = var_195_2
				var_195_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_195_4 = var_195_3:GetComponent("SpriteRenderer")

				if var_195_4 and var_195_4.sprite then
					local var_195_5 = (var_195_3.transform.localPosition - var_195_1).z
					local var_195_6 = manager.ui.mainCameraCom_
					local var_195_7 = 2 * var_195_5 * Mathf.Tan(var_195_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_195_8 = var_195_7 * var_195_6.aspect
					local var_195_9 = var_195_4.sprite.bounds.size.x
					local var_195_10 = var_195_4.sprite.bounds.size.y
					local var_195_11 = var_195_8 / var_195_9
					local var_195_12 = var_195_7 / var_195_10
					local var_195_13 = var_195_12 < var_195_11 and var_195_11 or var_195_12

					var_195_3.transform.localScale = Vector3.New(var_195_13, var_195_13, 0)
				end

				for iter_195_0, iter_195_1 in pairs(arg_192_1.bgs_) do
					if iter_195_0 ~= "J25f" then
						iter_195_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_195_14 = 3.999999999999

			if var_195_14 < arg_192_1.time_ and arg_192_1.time_ <= var_195_14 + arg_195_0 then
				arg_192_1.allBtn_.enabled = false
			end

			local var_195_15 = 0.3

			if arg_192_1.time_ >= var_195_14 + var_195_15 and arg_192_1.time_ < var_195_14 + var_195_15 + arg_195_0 then
				arg_192_1.allBtn_.enabled = true
			end

			local var_195_16 = 0

			if var_195_16 < arg_192_1.time_ and arg_192_1.time_ <= var_195_16 + arg_195_0 then
				arg_192_1.mask_.enabled = true
				arg_192_1.mask_.raycastTarget = true

				arg_192_1:SetGaussion(false)
			end

			local var_195_17 = 2

			if var_195_16 <= arg_192_1.time_ and arg_192_1.time_ < var_195_16 + var_195_17 then
				local var_195_18 = (arg_192_1.time_ - var_195_16) / var_195_17
				local var_195_19 = Color.New(0, 0, 0)

				var_195_19.a = Mathf.Lerp(0, 1, var_195_18)
				arg_192_1.mask_.color = var_195_19
			end

			if arg_192_1.time_ >= var_195_16 + var_195_17 and arg_192_1.time_ < var_195_16 + var_195_17 + arg_195_0 then
				local var_195_20 = Color.New(0, 0, 0)

				var_195_20.a = 1
				arg_192_1.mask_.color = var_195_20
			end

			local var_195_21 = 2

			if var_195_21 < arg_192_1.time_ and arg_192_1.time_ <= var_195_21 + arg_195_0 then
				arg_192_1.mask_.enabled = true
				arg_192_1.mask_.raycastTarget = true

				arg_192_1:SetGaussion(false)
			end

			local var_195_22 = 2

			if var_195_21 <= arg_192_1.time_ and arg_192_1.time_ < var_195_21 + var_195_22 then
				local var_195_23 = (arg_192_1.time_ - var_195_21) / var_195_22
				local var_195_24 = Color.New(0, 0, 0)

				var_195_24.a = Mathf.Lerp(1, 0, var_195_23)
				arg_192_1.mask_.color = var_195_24
			end

			if arg_192_1.time_ >= var_195_21 + var_195_22 and arg_192_1.time_ < var_195_21 + var_195_22 + arg_195_0 then
				local var_195_25 = Color.New(0, 0, 0)
				local var_195_26 = 0

				arg_192_1.mask_.enabled = false
				var_195_25.a = var_195_26
				arg_192_1.mask_.color = var_195_25
			end

			local var_195_27 = manager.ui.mainCamera.transform
			local var_195_28 = 2

			if var_195_28 < arg_192_1.time_ and arg_192_1.time_ <= var_195_28 + arg_195_0 then
				local var_195_29 = arg_192_1.var_.effectposuitexiao1

				if var_195_29 then
					Object.Destroy(var_195_29)

					arg_192_1.var_.effectposuitexiao1 = nil
				end
			end

			if arg_192_1.frameCnt_ <= 1 then
				arg_192_1.dialog_:SetActive(false)
			end

			local var_195_30 = 4
			local var_195_31 = 0.875

			if var_195_30 < arg_192_1.time_ and arg_192_1.time_ <= var_195_30 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				arg_192_1.dialog_:SetActive(true)

				arg_192_1.dialogCg_.alpha = 0

				local var_195_32 = LeanTween.value(arg_192_1.dialog_, 0, 1, 0.3)

				var_195_32:setOnUpdate(LuaHelper.FloatAction(function(arg_196_0)
					arg_192_1.dialogCg_.alpha = arg_196_0
				end))
				var_195_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_192_1.dialog_)
					var_195_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_192_1.duration_ = arg_192_1.duration_ + 0.3

				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_33 = arg_192_1:GetWordFromCfg(325602045)
				local var_195_34 = arg_192_1:FormatText(var_195_33.content)

				arg_192_1.text_.text = var_195_34

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_35 = 35
				local var_195_36 = utf8.len(var_195_34)
				local var_195_37 = var_195_35 <= 0 and var_195_31 or var_195_31 * (var_195_36 / var_195_35)

				if var_195_37 > 0 and var_195_31 < var_195_37 then
					arg_192_1.talkMaxDuration = var_195_37
					var_195_30 = var_195_30 + 0.3

					if var_195_37 + var_195_30 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_37 + var_195_30
					end
				end

				arg_192_1.text_.text = var_195_34
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_38 = var_195_30 + 0.3
			local var_195_39 = math.max(var_195_31, arg_192_1.talkMaxDuration)

			if var_195_38 <= arg_192_1.time_ and arg_192_1.time_ < var_195_38 + var_195_39 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_38) / var_195_39

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_38 + var_195_39 and arg_192_1.time_ < var_195_38 + var_195_39 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play325602046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 325602046
		arg_198_1.duration_ = 5.9

		local var_198_0 = {
			zh = 3.1,
			ja = 5.9
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play325602047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["10180ui_story"].transform
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.var_.moveOldPos10180ui_story = var_201_0.localPosition

				local var_201_2 = GameObjectTools.GetOrAddComponent(var_201_0.gameObject, typeof(DynamicBoneHelper))

				if var_201_2 then
					var_201_2:EnableDynamicBone(false)
				end
			end

			local var_201_3 = 0.001

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_3 then
				local var_201_4 = (arg_198_1.time_ - var_201_1) / var_201_3
				local var_201_5 = Vector3.New(-0.03, -1.09, -6.14)

				var_201_0.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos10180ui_story, var_201_5, var_201_4)

				local var_201_6 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_6.x, var_201_6.y, var_201_6.z)

				local var_201_7 = var_201_0.localEulerAngles

				var_201_7.z = 0
				var_201_7.x = 0
				var_201_0.localEulerAngles = var_201_7
			end

			if arg_198_1.time_ >= var_201_1 + var_201_3 and arg_198_1.time_ < var_201_1 + var_201_3 + arg_201_0 then
				var_201_0.localPosition = Vector3.New(-0.03, -1.09, -6.14)

				local var_201_8 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_8.x, var_201_8.y, var_201_8.z)

				local var_201_9 = var_201_0.localEulerAngles

				var_201_9.z = 0
				var_201_9.x = 0
				var_201_0.localEulerAngles = var_201_9

				local var_201_10 = GameObjectTools.GetOrAddComponent(var_201_0.gameObject, typeof(DynamicBoneHelper))

				if var_201_10 then
					var_201_10:EnableDynamicBone(true)
				end
			end

			local var_201_11 = arg_198_1.actors_["10180ui_story"]
			local var_201_12 = 0

			if var_201_12 < arg_198_1.time_ and arg_198_1.time_ <= var_201_12 + arg_201_0 and not isNil(var_201_11) and arg_198_1.var_.characterEffect10180ui_story == nil then
				arg_198_1.var_.characterEffect10180ui_story = var_201_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_13 = 0.200000002980232

			if var_201_12 <= arg_198_1.time_ and arg_198_1.time_ < var_201_12 + var_201_13 and not isNil(var_201_11) then
				local var_201_14 = (arg_198_1.time_ - var_201_12) / var_201_13

				if arg_198_1.var_.characterEffect10180ui_story and not isNil(var_201_11) then
					arg_198_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= var_201_12 + var_201_13 and arg_198_1.time_ < var_201_12 + var_201_13 + arg_201_0 and not isNil(var_201_11) and arg_198_1.var_.characterEffect10180ui_story then
				arg_198_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_201_15 = 0

			if var_201_15 < arg_198_1.time_ and arg_198_1.time_ <= var_201_15 + arg_201_0 then
				arg_198_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action1_1")
			end

			local var_201_16 = 0

			if var_201_16 < arg_198_1.time_ and arg_198_1.time_ <= var_201_16 + arg_201_0 then
				arg_198_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_201_17 = 0
			local var_201_18 = 0.35

			if var_201_17 < arg_198_1.time_ and arg_198_1.time_ <= var_201_17 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_19 = arg_198_1:FormatText(StoryNameCfg[1503].name)

				arg_198_1.leftNameTxt_.text = var_201_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_20 = arg_198_1:GetWordFromCfg(325602046)
				local var_201_21 = arg_198_1:FormatText(var_201_20.content)

				arg_198_1.text_.text = var_201_21

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_22 = 14
				local var_201_23 = utf8.len(var_201_21)
				local var_201_24 = var_201_22 <= 0 and var_201_18 or var_201_18 * (var_201_23 / var_201_22)

				if var_201_24 > 0 and var_201_18 < var_201_24 then
					arg_198_1.talkMaxDuration = var_201_24

					if var_201_24 + var_201_17 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_24 + var_201_17
					end
				end

				arg_198_1.text_.text = var_201_21
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602046", "story_v_out_325602.awb") ~= 0 then
					local var_201_25 = manager.audio:GetVoiceLength("story_v_out_325602", "325602046", "story_v_out_325602.awb") / 1000

					if var_201_25 + var_201_17 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_25 + var_201_17
					end

					if var_201_20.prefab_name ~= "" and arg_198_1.actors_[var_201_20.prefab_name] ~= nil then
						local var_201_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_20.prefab_name].transform, "story_v_out_325602", "325602046", "story_v_out_325602.awb")

						arg_198_1:RecordAudio("325602046", var_201_26)
						arg_198_1:RecordAudio("325602046", var_201_26)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_325602", "325602046", "story_v_out_325602.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_325602", "325602046", "story_v_out_325602.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_27 = math.max(var_201_18, arg_198_1.talkMaxDuration)

			if var_201_17 <= arg_198_1.time_ and arg_198_1.time_ < var_201_17 + var_201_27 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_17) / var_201_27

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_17 + var_201_27 and arg_198_1.time_ < var_201_17 + var_201_27 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play325602047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 325602047
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play325602048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["10180ui_story"].transform
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.var_.moveOldPos10180ui_story = var_205_0.localPosition

				local var_205_2 = GameObjectTools.GetOrAddComponent(var_205_0.gameObject, typeof(DynamicBoneHelper))

				if var_205_2 then
					var_205_2:EnableDynamicBone(false)
				end
			end

			local var_205_3 = 0.001

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_3 then
				local var_205_4 = (arg_202_1.time_ - var_205_1) / var_205_3
				local var_205_5 = Vector3.New(0, 100, 0)

				var_205_0.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos10180ui_story, var_205_5, var_205_4)

				local var_205_6 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_6.x, var_205_6.y, var_205_6.z)

				local var_205_7 = var_205_0.localEulerAngles

				var_205_7.z = 0
				var_205_7.x = 0
				var_205_0.localEulerAngles = var_205_7
			end

			if arg_202_1.time_ >= var_205_1 + var_205_3 and arg_202_1.time_ < var_205_1 + var_205_3 + arg_205_0 then
				var_205_0.localPosition = Vector3.New(0, 100, 0)

				local var_205_8 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_8.x, var_205_8.y, var_205_8.z)

				local var_205_9 = var_205_0.localEulerAngles

				var_205_9.z = 0
				var_205_9.x = 0
				var_205_0.localEulerAngles = var_205_9

				local var_205_10 = GameObjectTools.GetOrAddComponent(var_205_0.gameObject, typeof(DynamicBoneHelper))

				if var_205_10 then
					var_205_10:EnableDynamicBone(true)
				end
			end

			local var_205_11 = arg_202_1.actors_["10180ui_story"]
			local var_205_12 = 0

			if var_205_12 < arg_202_1.time_ and arg_202_1.time_ <= var_205_12 + arg_205_0 and not isNil(var_205_11) and arg_202_1.var_.characterEffect10180ui_story == nil then
				arg_202_1.var_.characterEffect10180ui_story = var_205_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_13 = 0.200000002980232

			if var_205_12 <= arg_202_1.time_ and arg_202_1.time_ < var_205_12 + var_205_13 and not isNil(var_205_11) then
				local var_205_14 = (arg_202_1.time_ - var_205_12) / var_205_13

				if arg_202_1.var_.characterEffect10180ui_story and not isNil(var_205_11) then
					local var_205_15 = Mathf.Lerp(0, 0.5, var_205_14)

					arg_202_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_202_1.var_.characterEffect10180ui_story.fillRatio = var_205_15
				end
			end

			if arg_202_1.time_ >= var_205_12 + var_205_13 and arg_202_1.time_ < var_205_12 + var_205_13 + arg_205_0 and not isNil(var_205_11) and arg_202_1.var_.characterEffect10180ui_story then
				local var_205_16 = 0.5

				arg_202_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_202_1.var_.characterEffect10180ui_story.fillRatio = var_205_16
			end

			local var_205_17 = 0
			local var_205_18 = 0.15

			if var_205_17 < arg_202_1.time_ and arg_202_1.time_ <= var_205_17 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_19 = arg_202_1:FormatText(StoryNameCfg[7].name)

				arg_202_1.leftNameTxt_.text = var_205_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_20 = arg_202_1:GetWordFromCfg(325602047)
				local var_205_21 = arg_202_1:FormatText(var_205_20.content)

				arg_202_1.text_.text = var_205_21

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_22 = 6
				local var_205_23 = utf8.len(var_205_21)
				local var_205_24 = var_205_22 <= 0 and var_205_18 or var_205_18 * (var_205_23 / var_205_22)

				if var_205_24 > 0 and var_205_18 < var_205_24 then
					arg_202_1.talkMaxDuration = var_205_24

					if var_205_24 + var_205_17 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_24 + var_205_17
					end
				end

				arg_202_1.text_.text = var_205_21
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_25 = math.max(var_205_18, arg_202_1.talkMaxDuration)

			if var_205_17 <= arg_202_1.time_ and arg_202_1.time_ < var_205_17 + var_205_25 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_17) / var_205_25

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_17 + var_205_25 and arg_202_1.time_ < var_205_17 + var_205_25 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play325602048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 325602048
		arg_206_1.duration_ = 13.7

		local var_206_0 = {
			zh = 5.9,
			ja = 13.7
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play325602049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["10180ui_story"].transform
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.var_.moveOldPos10180ui_story = var_209_0.localPosition

				local var_209_2 = GameObjectTools.GetOrAddComponent(var_209_0.gameObject, typeof(DynamicBoneHelper))

				if var_209_2 then
					var_209_2:EnableDynamicBone(false)
				end
			end

			local var_209_3 = 0.001

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_3 then
				local var_209_4 = (arg_206_1.time_ - var_209_1) / var_209_3
				local var_209_5 = Vector3.New(-0.03, -1.09, -6.14)

				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos10180ui_story, var_209_5, var_209_4)

				local var_209_6 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_6.x, var_209_6.y, var_209_6.z)

				local var_209_7 = var_209_0.localEulerAngles

				var_209_7.z = 0
				var_209_7.x = 0
				var_209_0.localEulerAngles = var_209_7
			end

			if arg_206_1.time_ >= var_209_1 + var_209_3 and arg_206_1.time_ < var_209_1 + var_209_3 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(-0.03, -1.09, -6.14)

				local var_209_8 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_8.x, var_209_8.y, var_209_8.z)

				local var_209_9 = var_209_0.localEulerAngles

				var_209_9.z = 0
				var_209_9.x = 0
				var_209_0.localEulerAngles = var_209_9

				local var_209_10 = GameObjectTools.GetOrAddComponent(var_209_0.gameObject, typeof(DynamicBoneHelper))

				if var_209_10 then
					var_209_10:EnableDynamicBone(true)
				end
			end

			local var_209_11 = arg_206_1.actors_["10180ui_story"]
			local var_209_12 = 0

			if var_209_12 < arg_206_1.time_ and arg_206_1.time_ <= var_209_12 + arg_209_0 and not isNil(var_209_11) and arg_206_1.var_.characterEffect10180ui_story == nil then
				arg_206_1.var_.characterEffect10180ui_story = var_209_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_13 = 0.200000002980232

			if var_209_12 <= arg_206_1.time_ and arg_206_1.time_ < var_209_12 + var_209_13 and not isNil(var_209_11) then
				local var_209_14 = (arg_206_1.time_ - var_209_12) / var_209_13

				if arg_206_1.var_.characterEffect10180ui_story and not isNil(var_209_11) then
					arg_206_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_12 + var_209_13 and arg_206_1.time_ < var_209_12 + var_209_13 + arg_209_0 and not isNil(var_209_11) and arg_206_1.var_.characterEffect10180ui_story then
				arg_206_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_209_15 = 0
			local var_209_16 = 0.575

			if var_209_15 < arg_206_1.time_ and arg_206_1.time_ <= var_209_15 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_17 = arg_206_1:FormatText(StoryNameCfg[1503].name)

				arg_206_1.leftNameTxt_.text = var_209_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_18 = arg_206_1:GetWordFromCfg(325602048)
				local var_209_19 = arg_206_1:FormatText(var_209_18.content)

				arg_206_1.text_.text = var_209_19

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_20 = 23
				local var_209_21 = utf8.len(var_209_19)
				local var_209_22 = var_209_20 <= 0 and var_209_16 or var_209_16 * (var_209_21 / var_209_20)

				if var_209_22 > 0 and var_209_16 < var_209_22 then
					arg_206_1.talkMaxDuration = var_209_22

					if var_209_22 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_22 + var_209_15
					end
				end

				arg_206_1.text_.text = var_209_19
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602048", "story_v_out_325602.awb") ~= 0 then
					local var_209_23 = manager.audio:GetVoiceLength("story_v_out_325602", "325602048", "story_v_out_325602.awb") / 1000

					if var_209_23 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_23 + var_209_15
					end

					if var_209_18.prefab_name ~= "" and arg_206_1.actors_[var_209_18.prefab_name] ~= nil then
						local var_209_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_18.prefab_name].transform, "story_v_out_325602", "325602048", "story_v_out_325602.awb")

						arg_206_1:RecordAudio("325602048", var_209_24)
						arg_206_1:RecordAudio("325602048", var_209_24)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_325602", "325602048", "story_v_out_325602.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_325602", "325602048", "story_v_out_325602.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_25 = math.max(var_209_16, arg_206_1.talkMaxDuration)

			if var_209_15 <= arg_206_1.time_ and arg_206_1.time_ < var_209_15 + var_209_25 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_15) / var_209_25

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_15 + var_209_25 and arg_206_1.time_ < var_209_15 + var_209_25 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play325602049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 325602049
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play325602050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["10180ui_story"].transform
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.var_.moveOldPos10180ui_story = var_213_0.localPosition

				local var_213_2 = GameObjectTools.GetOrAddComponent(var_213_0.gameObject, typeof(DynamicBoneHelper))

				if var_213_2 then
					var_213_2:EnableDynamicBone(false)
				end
			end

			local var_213_3 = 0.001

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_3 then
				local var_213_4 = (arg_210_1.time_ - var_213_1) / var_213_3
				local var_213_5 = Vector3.New(0, 100, 0)

				var_213_0.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos10180ui_story, var_213_5, var_213_4)

				local var_213_6 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_6.x, var_213_6.y, var_213_6.z)

				local var_213_7 = var_213_0.localEulerAngles

				var_213_7.z = 0
				var_213_7.x = 0
				var_213_0.localEulerAngles = var_213_7
			end

			if arg_210_1.time_ >= var_213_1 + var_213_3 and arg_210_1.time_ < var_213_1 + var_213_3 + arg_213_0 then
				var_213_0.localPosition = Vector3.New(0, 100, 0)

				local var_213_8 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_8.x, var_213_8.y, var_213_8.z)

				local var_213_9 = var_213_0.localEulerAngles

				var_213_9.z = 0
				var_213_9.x = 0
				var_213_0.localEulerAngles = var_213_9

				local var_213_10 = GameObjectTools.GetOrAddComponent(var_213_0.gameObject, typeof(DynamicBoneHelper))

				if var_213_10 then
					var_213_10:EnableDynamicBone(true)
				end
			end

			local var_213_11 = arg_210_1.actors_["10180ui_story"]
			local var_213_12 = 0

			if var_213_12 < arg_210_1.time_ and arg_210_1.time_ <= var_213_12 + arg_213_0 and not isNil(var_213_11) and arg_210_1.var_.characterEffect10180ui_story == nil then
				arg_210_1.var_.characterEffect10180ui_story = var_213_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_13 = 0.200000002980232

			if var_213_12 <= arg_210_1.time_ and arg_210_1.time_ < var_213_12 + var_213_13 and not isNil(var_213_11) then
				local var_213_14 = (arg_210_1.time_ - var_213_12) / var_213_13

				if arg_210_1.var_.characterEffect10180ui_story and not isNil(var_213_11) then
					local var_213_15 = Mathf.Lerp(0, 0.5, var_213_14)

					arg_210_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_210_1.var_.characterEffect10180ui_story.fillRatio = var_213_15
				end
			end

			if arg_210_1.time_ >= var_213_12 + var_213_13 and arg_210_1.time_ < var_213_12 + var_213_13 + arg_213_0 and not isNil(var_213_11) and arg_210_1.var_.characterEffect10180ui_story then
				local var_213_16 = 0.5

				arg_210_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_210_1.var_.characterEffect10180ui_story.fillRatio = var_213_16
			end

			local var_213_17 = 0
			local var_213_18 = 1.225

			if var_213_17 < arg_210_1.time_ and arg_210_1.time_ <= var_213_17 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_19 = arg_210_1:GetWordFromCfg(325602049)
				local var_213_20 = arg_210_1:FormatText(var_213_19.content)

				arg_210_1.text_.text = var_213_20

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_21 = 49
				local var_213_22 = utf8.len(var_213_20)
				local var_213_23 = var_213_21 <= 0 and var_213_18 or var_213_18 * (var_213_22 / var_213_21)

				if var_213_23 > 0 and var_213_18 < var_213_23 then
					arg_210_1.talkMaxDuration = var_213_23

					if var_213_23 + var_213_17 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_23 + var_213_17
					end
				end

				arg_210_1.text_.text = var_213_20
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_24 = math.max(var_213_18, arg_210_1.talkMaxDuration)

			if var_213_17 <= arg_210_1.time_ and arg_210_1.time_ < var_213_17 + var_213_24 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_17) / var_213_24

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_17 + var_213_24 and arg_210_1.time_ < var_213_17 + var_213_24 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play325602050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 325602050
		arg_214_1.duration_ = 2.6

		local var_214_0 = {
			zh = 2.6,
			ja = 2
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play325602051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["10170ui_story"].transform
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.var_.moveOldPos10170ui_story = var_217_0.localPosition

				local var_217_2 = GameObjectTools.GetOrAddComponent(var_217_0.gameObject, typeof(DynamicBoneHelper))

				if var_217_2 then
					var_217_2:EnableDynamicBone(false)
				end
			end

			local var_217_3 = 0.001

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_3 then
				local var_217_4 = (arg_214_1.time_ - var_217_1) / var_217_3
				local var_217_5 = Vector3.New(0, -1.03, -6.05)

				var_217_0.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10170ui_story, var_217_5, var_217_4)

				local var_217_6 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_6.x, var_217_6.y, var_217_6.z)

				local var_217_7 = var_217_0.localEulerAngles

				var_217_7.z = 0
				var_217_7.x = 0
				var_217_0.localEulerAngles = var_217_7
			end

			if arg_214_1.time_ >= var_217_1 + var_217_3 and arg_214_1.time_ < var_217_1 + var_217_3 + arg_217_0 then
				var_217_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_217_8 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_8.x, var_217_8.y, var_217_8.z)

				local var_217_9 = var_217_0.localEulerAngles

				var_217_9.z = 0
				var_217_9.x = 0
				var_217_0.localEulerAngles = var_217_9

				local var_217_10 = GameObjectTools.GetOrAddComponent(var_217_0.gameObject, typeof(DynamicBoneHelper))

				if var_217_10 then
					var_217_10:EnableDynamicBone(true)
				end
			end

			local var_217_11 = arg_214_1.actors_["10170ui_story"]
			local var_217_12 = 0

			if var_217_12 < arg_214_1.time_ and arg_214_1.time_ <= var_217_12 + arg_217_0 and not isNil(var_217_11) and arg_214_1.var_.characterEffect10170ui_story == nil then
				arg_214_1.var_.characterEffect10170ui_story = var_217_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_13 = 0.200000002980232

			if var_217_12 <= arg_214_1.time_ and arg_214_1.time_ < var_217_12 + var_217_13 and not isNil(var_217_11) then
				local var_217_14 = (arg_214_1.time_ - var_217_12) / var_217_13

				if arg_214_1.var_.characterEffect10170ui_story and not isNil(var_217_11) then
					arg_214_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_12 + var_217_13 and arg_214_1.time_ < var_217_12 + var_217_13 + arg_217_0 and not isNil(var_217_11) and arg_214_1.var_.characterEffect10170ui_story then
				arg_214_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_217_15 = 0

			if var_217_15 < arg_214_1.time_ and arg_214_1.time_ <= var_217_15 + arg_217_0 then
				arg_214_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_217_16 = 0

			if var_217_16 < arg_214_1.time_ and arg_214_1.time_ <= var_217_16 + arg_217_0 then
				arg_214_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_217_17 = 0
			local var_217_18 = 0.225

			if var_217_17 < arg_214_1.time_ and arg_214_1.time_ <= var_217_17 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_19 = arg_214_1:FormatText(StoryNameCfg[1450].name)

				arg_214_1.leftNameTxt_.text = var_217_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_20 = arg_214_1:GetWordFromCfg(325602050)
				local var_217_21 = arg_214_1:FormatText(var_217_20.content)

				arg_214_1.text_.text = var_217_21

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_22 = 9
				local var_217_23 = utf8.len(var_217_21)
				local var_217_24 = var_217_22 <= 0 and var_217_18 or var_217_18 * (var_217_23 / var_217_22)

				if var_217_24 > 0 and var_217_18 < var_217_24 then
					arg_214_1.talkMaxDuration = var_217_24

					if var_217_24 + var_217_17 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_24 + var_217_17
					end
				end

				arg_214_1.text_.text = var_217_21
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602050", "story_v_out_325602.awb") ~= 0 then
					local var_217_25 = manager.audio:GetVoiceLength("story_v_out_325602", "325602050", "story_v_out_325602.awb") / 1000

					if var_217_25 + var_217_17 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_25 + var_217_17
					end

					if var_217_20.prefab_name ~= "" and arg_214_1.actors_[var_217_20.prefab_name] ~= nil then
						local var_217_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_20.prefab_name].transform, "story_v_out_325602", "325602050", "story_v_out_325602.awb")

						arg_214_1:RecordAudio("325602050", var_217_26)
						arg_214_1:RecordAudio("325602050", var_217_26)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_325602", "325602050", "story_v_out_325602.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_325602", "325602050", "story_v_out_325602.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_27 = math.max(var_217_18, arg_214_1.talkMaxDuration)

			if var_217_17 <= arg_214_1.time_ and arg_214_1.time_ < var_217_17 + var_217_27 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_17) / var_217_27

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_17 + var_217_27 and arg_214_1.time_ < var_217_17 + var_217_27 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play325602051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 325602051
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play325602052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["10170ui_story"].transform
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.var_.moveOldPos10170ui_story = var_221_0.localPosition

				local var_221_2 = GameObjectTools.GetOrAddComponent(var_221_0.gameObject, typeof(DynamicBoneHelper))

				if var_221_2 then
					var_221_2:EnableDynamicBone(false)
				end
			end

			local var_221_3 = 0.001

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_3 then
				local var_221_4 = (arg_218_1.time_ - var_221_1) / var_221_3
				local var_221_5 = Vector3.New(0, 100, 0)

				var_221_0.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10170ui_story, var_221_5, var_221_4)

				local var_221_6 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_6.x, var_221_6.y, var_221_6.z)

				local var_221_7 = var_221_0.localEulerAngles

				var_221_7.z = 0
				var_221_7.x = 0
				var_221_0.localEulerAngles = var_221_7
			end

			if arg_218_1.time_ >= var_221_1 + var_221_3 and arg_218_1.time_ < var_221_1 + var_221_3 + arg_221_0 then
				var_221_0.localPosition = Vector3.New(0, 100, 0)

				local var_221_8 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_8.x, var_221_8.y, var_221_8.z)

				local var_221_9 = var_221_0.localEulerAngles

				var_221_9.z = 0
				var_221_9.x = 0
				var_221_0.localEulerAngles = var_221_9

				local var_221_10 = GameObjectTools.GetOrAddComponent(var_221_0.gameObject, typeof(DynamicBoneHelper))

				if var_221_10 then
					var_221_10:EnableDynamicBone(true)
				end
			end

			local var_221_11 = arg_218_1.actors_["10170ui_story"]
			local var_221_12 = 0

			if var_221_12 < arg_218_1.time_ and arg_218_1.time_ <= var_221_12 + arg_221_0 and not isNil(var_221_11) and arg_218_1.var_.characterEffect10170ui_story == nil then
				arg_218_1.var_.characterEffect10170ui_story = var_221_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_13 = 0.200000002980232

			if var_221_12 <= arg_218_1.time_ and arg_218_1.time_ < var_221_12 + var_221_13 and not isNil(var_221_11) then
				local var_221_14 = (arg_218_1.time_ - var_221_12) / var_221_13

				if arg_218_1.var_.characterEffect10170ui_story and not isNil(var_221_11) then
					local var_221_15 = Mathf.Lerp(0, 0.5, var_221_14)

					arg_218_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_218_1.var_.characterEffect10170ui_story.fillRatio = var_221_15
				end
			end

			if arg_218_1.time_ >= var_221_12 + var_221_13 and arg_218_1.time_ < var_221_12 + var_221_13 + arg_221_0 and not isNil(var_221_11) and arg_218_1.var_.characterEffect10170ui_story then
				local var_221_16 = 0.5

				arg_218_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_218_1.var_.characterEffect10170ui_story.fillRatio = var_221_16
			end

			local var_221_17 = 0
			local var_221_18 = 0.725

			if var_221_17 < arg_218_1.time_ and arg_218_1.time_ <= var_221_17 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_19 = arg_218_1:FormatText(StoryNameCfg[7].name)

				arg_218_1.leftNameTxt_.text = var_221_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_20 = arg_218_1:GetWordFromCfg(325602051)
				local var_221_21 = arg_218_1:FormatText(var_221_20.content)

				arg_218_1.text_.text = var_221_21

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_22 = 29
				local var_221_23 = utf8.len(var_221_21)
				local var_221_24 = var_221_22 <= 0 and var_221_18 or var_221_18 * (var_221_23 / var_221_22)

				if var_221_24 > 0 and var_221_18 < var_221_24 then
					arg_218_1.talkMaxDuration = var_221_24

					if var_221_24 + var_221_17 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_24 + var_221_17
					end
				end

				arg_218_1.text_.text = var_221_21
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_25 = math.max(var_221_18, arg_218_1.talkMaxDuration)

			if var_221_17 <= arg_218_1.time_ and arg_218_1.time_ < var_221_17 + var_221_25 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_17) / var_221_25

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_17 + var_221_25 and arg_218_1.time_ < var_221_17 + var_221_25 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play325602052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 325602052
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play325602053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 1.45

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_2 = arg_222_1:GetWordFromCfg(325602052)
				local var_225_3 = arg_222_1:FormatText(var_225_2.content)

				arg_222_1.text_.text = var_225_3

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 58
				local var_225_5 = utf8.len(var_225_3)
				local var_225_6 = var_225_4 <= 0 and var_225_1 or var_225_1 * (var_225_5 / var_225_4)

				if var_225_6 > 0 and var_225_1 < var_225_6 then
					arg_222_1.talkMaxDuration = var_225_6

					if var_225_6 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_6 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_3
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_7 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_7 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_7

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_7 and arg_222_1.time_ < var_225_0 + var_225_7 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play325602053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 325602053
		arg_226_1.duration_ = 6.6

		local var_226_0 = {
			zh = 4.633,
			ja = 6.6
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play325602054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["10180ui_story"].transform
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.var_.moveOldPos10180ui_story = var_229_0.localPosition

				local var_229_2 = GameObjectTools.GetOrAddComponent(var_229_0.gameObject, typeof(DynamicBoneHelper))

				if var_229_2 then
					var_229_2:EnableDynamicBone(false)
				end
			end

			local var_229_3 = 0.001

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_3 then
				local var_229_4 = (arg_226_1.time_ - var_229_1) / var_229_3
				local var_229_5 = Vector3.New(-0.03, -1.09, -6.14)

				var_229_0.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10180ui_story, var_229_5, var_229_4)

				local var_229_6 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_6.x, var_229_6.y, var_229_6.z)

				local var_229_7 = var_229_0.localEulerAngles

				var_229_7.z = 0
				var_229_7.x = 0
				var_229_0.localEulerAngles = var_229_7
			end

			if arg_226_1.time_ >= var_229_1 + var_229_3 and arg_226_1.time_ < var_229_1 + var_229_3 + arg_229_0 then
				var_229_0.localPosition = Vector3.New(-0.03, -1.09, -6.14)

				local var_229_8 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_8.x, var_229_8.y, var_229_8.z)

				local var_229_9 = var_229_0.localEulerAngles

				var_229_9.z = 0
				var_229_9.x = 0
				var_229_0.localEulerAngles = var_229_9

				local var_229_10 = GameObjectTools.GetOrAddComponent(var_229_0.gameObject, typeof(DynamicBoneHelper))

				if var_229_10 then
					var_229_10:EnableDynamicBone(true)
				end
			end

			local var_229_11 = arg_226_1.actors_["10180ui_story"]
			local var_229_12 = 0

			if var_229_12 < arg_226_1.time_ and arg_226_1.time_ <= var_229_12 + arg_229_0 and not isNil(var_229_11) and arg_226_1.var_.characterEffect10180ui_story == nil then
				arg_226_1.var_.characterEffect10180ui_story = var_229_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_13 = 0.200000002980232

			if var_229_12 <= arg_226_1.time_ and arg_226_1.time_ < var_229_12 + var_229_13 and not isNil(var_229_11) then
				local var_229_14 = (arg_226_1.time_ - var_229_12) / var_229_13

				if arg_226_1.var_.characterEffect10180ui_story and not isNil(var_229_11) then
					arg_226_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_12 + var_229_13 and arg_226_1.time_ < var_229_12 + var_229_13 + arg_229_0 and not isNil(var_229_11) and arg_226_1.var_.characterEffect10180ui_story then
				arg_226_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_229_15 = 0

			if var_229_15 < arg_226_1.time_ and arg_226_1.time_ <= var_229_15 + arg_229_0 then
				arg_226_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action8_1")
			end

			local var_229_16 = 0

			if var_229_16 < arg_226_1.time_ and arg_226_1.time_ <= var_229_16 + arg_229_0 then
				arg_226_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_229_17 = 0
			local var_229_18 = 0.45

			if var_229_17 < arg_226_1.time_ and arg_226_1.time_ <= var_229_17 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_19 = arg_226_1:FormatText(StoryNameCfg[1503].name)

				arg_226_1.leftNameTxt_.text = var_229_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_20 = arg_226_1:GetWordFromCfg(325602053)
				local var_229_21 = arg_226_1:FormatText(var_229_20.content)

				arg_226_1.text_.text = var_229_21

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_22 = 18
				local var_229_23 = utf8.len(var_229_21)
				local var_229_24 = var_229_22 <= 0 and var_229_18 or var_229_18 * (var_229_23 / var_229_22)

				if var_229_24 > 0 and var_229_18 < var_229_24 then
					arg_226_1.talkMaxDuration = var_229_24

					if var_229_24 + var_229_17 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_24 + var_229_17
					end
				end

				arg_226_1.text_.text = var_229_21
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602053", "story_v_out_325602.awb") ~= 0 then
					local var_229_25 = manager.audio:GetVoiceLength("story_v_out_325602", "325602053", "story_v_out_325602.awb") / 1000

					if var_229_25 + var_229_17 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_25 + var_229_17
					end

					if var_229_20.prefab_name ~= "" and arg_226_1.actors_[var_229_20.prefab_name] ~= nil then
						local var_229_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_20.prefab_name].transform, "story_v_out_325602", "325602053", "story_v_out_325602.awb")

						arg_226_1:RecordAudio("325602053", var_229_26)
						arg_226_1:RecordAudio("325602053", var_229_26)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_325602", "325602053", "story_v_out_325602.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_325602", "325602053", "story_v_out_325602.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_27 = math.max(var_229_18, arg_226_1.talkMaxDuration)

			if var_229_17 <= arg_226_1.time_ and arg_226_1.time_ < var_229_17 + var_229_27 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_17) / var_229_27

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_17 + var_229_27 and arg_226_1.time_ < var_229_17 + var_229_27 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play325602054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 325602054
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play325602055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["10180ui_story"].transform
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.var_.moveOldPos10180ui_story = var_233_0.localPosition

				local var_233_2 = GameObjectTools.GetOrAddComponent(var_233_0.gameObject, typeof(DynamicBoneHelper))

				if var_233_2 then
					var_233_2:EnableDynamicBone(false)
				end
			end

			local var_233_3 = 0.001

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_3 then
				local var_233_4 = (arg_230_1.time_ - var_233_1) / var_233_3
				local var_233_5 = Vector3.New(0, 100, 0)

				var_233_0.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10180ui_story, var_233_5, var_233_4)

				local var_233_6 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_6.x, var_233_6.y, var_233_6.z)

				local var_233_7 = var_233_0.localEulerAngles

				var_233_7.z = 0
				var_233_7.x = 0
				var_233_0.localEulerAngles = var_233_7
			end

			if arg_230_1.time_ >= var_233_1 + var_233_3 and arg_230_1.time_ < var_233_1 + var_233_3 + arg_233_0 then
				var_233_0.localPosition = Vector3.New(0, 100, 0)

				local var_233_8 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_8.x, var_233_8.y, var_233_8.z)

				local var_233_9 = var_233_0.localEulerAngles

				var_233_9.z = 0
				var_233_9.x = 0
				var_233_0.localEulerAngles = var_233_9

				local var_233_10 = GameObjectTools.GetOrAddComponent(var_233_0.gameObject, typeof(DynamicBoneHelper))

				if var_233_10 then
					var_233_10:EnableDynamicBone(true)
				end
			end

			local var_233_11 = arg_230_1.actors_["10180ui_story"]
			local var_233_12 = 0

			if var_233_12 < arg_230_1.time_ and arg_230_1.time_ <= var_233_12 + arg_233_0 and not isNil(var_233_11) and arg_230_1.var_.characterEffect10180ui_story == nil then
				arg_230_1.var_.characterEffect10180ui_story = var_233_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_13 = 0.200000002980232

			if var_233_12 <= arg_230_1.time_ and arg_230_1.time_ < var_233_12 + var_233_13 and not isNil(var_233_11) then
				local var_233_14 = (arg_230_1.time_ - var_233_12) / var_233_13

				if arg_230_1.var_.characterEffect10180ui_story and not isNil(var_233_11) then
					local var_233_15 = Mathf.Lerp(0, 0.5, var_233_14)

					arg_230_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_230_1.var_.characterEffect10180ui_story.fillRatio = var_233_15
				end
			end

			if arg_230_1.time_ >= var_233_12 + var_233_13 and arg_230_1.time_ < var_233_12 + var_233_13 + arg_233_0 and not isNil(var_233_11) and arg_230_1.var_.characterEffect10180ui_story then
				local var_233_16 = 0.5

				arg_230_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_230_1.var_.characterEffect10180ui_story.fillRatio = var_233_16
			end

			local var_233_17 = 0
			local var_233_18 = 0.15

			if var_233_17 < arg_230_1.time_ and arg_230_1.time_ <= var_233_17 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_19 = arg_230_1:FormatText(StoryNameCfg[7].name)

				arg_230_1.leftNameTxt_.text = var_233_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_20 = arg_230_1:GetWordFromCfg(325602054)
				local var_233_21 = arg_230_1:FormatText(var_233_20.content)

				arg_230_1.text_.text = var_233_21

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_22 = 6
				local var_233_23 = utf8.len(var_233_21)
				local var_233_24 = var_233_22 <= 0 and var_233_18 or var_233_18 * (var_233_23 / var_233_22)

				if var_233_24 > 0 and var_233_18 < var_233_24 then
					arg_230_1.talkMaxDuration = var_233_24

					if var_233_24 + var_233_17 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_24 + var_233_17
					end
				end

				arg_230_1.text_.text = var_233_21
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_25 = math.max(var_233_18, arg_230_1.talkMaxDuration)

			if var_233_17 <= arg_230_1.time_ and arg_230_1.time_ < var_233_17 + var_233_25 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_17) / var_233_25

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_17 + var_233_25 and arg_230_1.time_ < var_233_17 + var_233_25 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play325602055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 325602055
		arg_234_1.duration_ = 6.13

		local var_234_0 = {
			zh = 6.133,
			ja = 5.366
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play325602056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["10180ui_story"].transform
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.var_.moveOldPos10180ui_story = var_237_0.localPosition

				local var_237_2 = GameObjectTools.GetOrAddComponent(var_237_0.gameObject, typeof(DynamicBoneHelper))

				if var_237_2 then
					var_237_2:EnableDynamicBone(false)
				end
			end

			local var_237_3 = 0.001

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_3 then
				local var_237_4 = (arg_234_1.time_ - var_237_1) / var_237_3
				local var_237_5 = Vector3.New(-0.03, -1.09, -6.14)

				var_237_0.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10180ui_story, var_237_5, var_237_4)

				local var_237_6 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_6.x, var_237_6.y, var_237_6.z)

				local var_237_7 = var_237_0.localEulerAngles

				var_237_7.z = 0
				var_237_7.x = 0
				var_237_0.localEulerAngles = var_237_7
			end

			if arg_234_1.time_ >= var_237_1 + var_237_3 and arg_234_1.time_ < var_237_1 + var_237_3 + arg_237_0 then
				var_237_0.localPosition = Vector3.New(-0.03, -1.09, -6.14)

				local var_237_8 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_8.x, var_237_8.y, var_237_8.z)

				local var_237_9 = var_237_0.localEulerAngles

				var_237_9.z = 0
				var_237_9.x = 0
				var_237_0.localEulerAngles = var_237_9

				local var_237_10 = GameObjectTools.GetOrAddComponent(var_237_0.gameObject, typeof(DynamicBoneHelper))

				if var_237_10 then
					var_237_10:EnableDynamicBone(true)
				end
			end

			local var_237_11 = arg_234_1.actors_["10180ui_story"]
			local var_237_12 = 0

			if var_237_12 < arg_234_1.time_ and arg_234_1.time_ <= var_237_12 + arg_237_0 and not isNil(var_237_11) and arg_234_1.var_.characterEffect10180ui_story == nil then
				arg_234_1.var_.characterEffect10180ui_story = var_237_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_13 = 0.200000002980232

			if var_237_12 <= arg_234_1.time_ and arg_234_1.time_ < var_237_12 + var_237_13 and not isNil(var_237_11) then
				local var_237_14 = (arg_234_1.time_ - var_237_12) / var_237_13

				if arg_234_1.var_.characterEffect10180ui_story and not isNil(var_237_11) then
					arg_234_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= var_237_12 + var_237_13 and arg_234_1.time_ < var_237_12 + var_237_13 + arg_237_0 and not isNil(var_237_11) and arg_234_1.var_.characterEffect10180ui_story then
				arg_234_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_237_15 = 0
			local var_237_16 = 0.6

			if var_237_15 < arg_234_1.time_ and arg_234_1.time_ <= var_237_15 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_17 = arg_234_1:FormatText(StoryNameCfg[1503].name)

				arg_234_1.leftNameTxt_.text = var_237_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_18 = arg_234_1:GetWordFromCfg(325602055)
				local var_237_19 = arg_234_1:FormatText(var_237_18.content)

				arg_234_1.text_.text = var_237_19

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_20 = 24
				local var_237_21 = utf8.len(var_237_19)
				local var_237_22 = var_237_20 <= 0 and var_237_16 or var_237_16 * (var_237_21 / var_237_20)

				if var_237_22 > 0 and var_237_16 < var_237_22 then
					arg_234_1.talkMaxDuration = var_237_22

					if var_237_22 + var_237_15 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_22 + var_237_15
					end
				end

				arg_234_1.text_.text = var_237_19
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602055", "story_v_out_325602.awb") ~= 0 then
					local var_237_23 = manager.audio:GetVoiceLength("story_v_out_325602", "325602055", "story_v_out_325602.awb") / 1000

					if var_237_23 + var_237_15 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_23 + var_237_15
					end

					if var_237_18.prefab_name ~= "" and arg_234_1.actors_[var_237_18.prefab_name] ~= nil then
						local var_237_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_18.prefab_name].transform, "story_v_out_325602", "325602055", "story_v_out_325602.awb")

						arg_234_1:RecordAudio("325602055", var_237_24)
						arg_234_1:RecordAudio("325602055", var_237_24)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_325602", "325602055", "story_v_out_325602.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_325602", "325602055", "story_v_out_325602.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_25 = math.max(var_237_16, arg_234_1.talkMaxDuration)

			if var_237_15 <= arg_234_1.time_ and arg_234_1.time_ < var_237_15 + var_237_25 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_15) / var_237_25

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_15 + var_237_25 and arg_234_1.time_ < var_237_15 + var_237_25 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play325602056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 325602056
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play325602057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["10180ui_story"].transform
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.var_.moveOldPos10180ui_story = var_241_0.localPosition

				local var_241_2 = GameObjectTools.GetOrAddComponent(var_241_0.gameObject, typeof(DynamicBoneHelper))

				if var_241_2 then
					var_241_2:EnableDynamicBone(false)
				end
			end

			local var_241_3 = 0.001

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_3 then
				local var_241_4 = (arg_238_1.time_ - var_241_1) / var_241_3
				local var_241_5 = Vector3.New(0, 100, 0)

				var_241_0.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos10180ui_story, var_241_5, var_241_4)

				local var_241_6 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_6.x, var_241_6.y, var_241_6.z)

				local var_241_7 = var_241_0.localEulerAngles

				var_241_7.z = 0
				var_241_7.x = 0
				var_241_0.localEulerAngles = var_241_7
			end

			if arg_238_1.time_ >= var_241_1 + var_241_3 and arg_238_1.time_ < var_241_1 + var_241_3 + arg_241_0 then
				var_241_0.localPosition = Vector3.New(0, 100, 0)

				local var_241_8 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_8.x, var_241_8.y, var_241_8.z)

				local var_241_9 = var_241_0.localEulerAngles

				var_241_9.z = 0
				var_241_9.x = 0
				var_241_0.localEulerAngles = var_241_9

				local var_241_10 = GameObjectTools.GetOrAddComponent(var_241_0.gameObject, typeof(DynamicBoneHelper))

				if var_241_10 then
					var_241_10:EnableDynamicBone(true)
				end
			end

			local var_241_11 = arg_238_1.actors_["10180ui_story"]
			local var_241_12 = 0

			if var_241_12 < arg_238_1.time_ and arg_238_1.time_ <= var_241_12 + arg_241_0 and not isNil(var_241_11) and arg_238_1.var_.characterEffect10180ui_story == nil then
				arg_238_1.var_.characterEffect10180ui_story = var_241_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_13 = 0.200000002980232

			if var_241_12 <= arg_238_1.time_ and arg_238_1.time_ < var_241_12 + var_241_13 and not isNil(var_241_11) then
				local var_241_14 = (arg_238_1.time_ - var_241_12) / var_241_13

				if arg_238_1.var_.characterEffect10180ui_story and not isNil(var_241_11) then
					local var_241_15 = Mathf.Lerp(0, 0.5, var_241_14)

					arg_238_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_238_1.var_.characterEffect10180ui_story.fillRatio = var_241_15
				end
			end

			if arg_238_1.time_ >= var_241_12 + var_241_13 and arg_238_1.time_ < var_241_12 + var_241_13 + arg_241_0 and not isNil(var_241_11) and arg_238_1.var_.characterEffect10180ui_story then
				local var_241_16 = 0.5

				arg_238_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_238_1.var_.characterEffect10180ui_story.fillRatio = var_241_16
			end

			local var_241_17 = 0
			local var_241_18 = 1.65

			if var_241_17 < arg_238_1.time_ and arg_238_1.time_ <= var_241_17 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_19 = arg_238_1:GetWordFromCfg(325602056)
				local var_241_20 = arg_238_1:FormatText(var_241_19.content)

				arg_238_1.text_.text = var_241_20

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_21 = 66
				local var_241_22 = utf8.len(var_241_20)
				local var_241_23 = var_241_21 <= 0 and var_241_18 or var_241_18 * (var_241_22 / var_241_21)

				if var_241_23 > 0 and var_241_18 < var_241_23 then
					arg_238_1.talkMaxDuration = var_241_23

					if var_241_23 + var_241_17 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_23 + var_241_17
					end
				end

				arg_238_1.text_.text = var_241_20
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_24 = math.max(var_241_18, arg_238_1.talkMaxDuration)

			if var_241_17 <= arg_238_1.time_ and arg_238_1.time_ < var_241_17 + var_241_24 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_17) / var_241_24

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_17 + var_241_24 and arg_238_1.time_ < var_241_17 + var_241_24 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play325602057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 325602057
		arg_242_1.duration_ = 16.83

		local var_242_0 = {
			zh = 8.333,
			ja = 16.833
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play325602058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["10180ui_story"].transform
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.var_.moveOldPos10180ui_story = var_245_0.localPosition

				local var_245_2 = GameObjectTools.GetOrAddComponent(var_245_0.gameObject, typeof(DynamicBoneHelper))

				if var_245_2 then
					var_245_2:EnableDynamicBone(false)
				end
			end

			local var_245_3 = 0.001

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_3 then
				local var_245_4 = (arg_242_1.time_ - var_245_1) / var_245_3
				local var_245_5 = Vector3.New(-0.03, -1.09, -6.14)

				var_245_0.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10180ui_story, var_245_5, var_245_4)

				local var_245_6 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_6.x, var_245_6.y, var_245_6.z)

				local var_245_7 = var_245_0.localEulerAngles

				var_245_7.z = 0
				var_245_7.x = 0
				var_245_0.localEulerAngles = var_245_7
			end

			if arg_242_1.time_ >= var_245_1 + var_245_3 and arg_242_1.time_ < var_245_1 + var_245_3 + arg_245_0 then
				var_245_0.localPosition = Vector3.New(-0.03, -1.09, -6.14)

				local var_245_8 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_8.x, var_245_8.y, var_245_8.z)

				local var_245_9 = var_245_0.localEulerAngles

				var_245_9.z = 0
				var_245_9.x = 0
				var_245_0.localEulerAngles = var_245_9

				local var_245_10 = GameObjectTools.GetOrAddComponent(var_245_0.gameObject, typeof(DynamicBoneHelper))

				if var_245_10 then
					var_245_10:EnableDynamicBone(true)
				end
			end

			local var_245_11 = arg_242_1.actors_["10180ui_story"]
			local var_245_12 = 0

			if var_245_12 < arg_242_1.time_ and arg_242_1.time_ <= var_245_12 + arg_245_0 and not isNil(var_245_11) and arg_242_1.var_.characterEffect10180ui_story == nil then
				arg_242_1.var_.characterEffect10180ui_story = var_245_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_13 = 0.200000002980232

			if var_245_12 <= arg_242_1.time_ and arg_242_1.time_ < var_245_12 + var_245_13 and not isNil(var_245_11) then
				local var_245_14 = (arg_242_1.time_ - var_245_12) / var_245_13

				if arg_242_1.var_.characterEffect10180ui_story and not isNil(var_245_11) then
					arg_242_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= var_245_12 + var_245_13 and arg_242_1.time_ < var_245_12 + var_245_13 + arg_245_0 and not isNil(var_245_11) and arg_242_1.var_.characterEffect10180ui_story then
				arg_242_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_245_15 = 0
			local var_245_16 = 0.825

			if var_245_15 < arg_242_1.time_ and arg_242_1.time_ <= var_245_15 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_17 = arg_242_1:FormatText(StoryNameCfg[1503].name)

				arg_242_1.leftNameTxt_.text = var_245_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_18 = arg_242_1:GetWordFromCfg(325602057)
				local var_245_19 = arg_242_1:FormatText(var_245_18.content)

				arg_242_1.text_.text = var_245_19

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_20 = 33
				local var_245_21 = utf8.len(var_245_19)
				local var_245_22 = var_245_20 <= 0 and var_245_16 or var_245_16 * (var_245_21 / var_245_20)

				if var_245_22 > 0 and var_245_16 < var_245_22 then
					arg_242_1.talkMaxDuration = var_245_22

					if var_245_22 + var_245_15 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_22 + var_245_15
					end
				end

				arg_242_1.text_.text = var_245_19
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602057", "story_v_out_325602.awb") ~= 0 then
					local var_245_23 = manager.audio:GetVoiceLength("story_v_out_325602", "325602057", "story_v_out_325602.awb") / 1000

					if var_245_23 + var_245_15 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_23 + var_245_15
					end

					if var_245_18.prefab_name ~= "" and arg_242_1.actors_[var_245_18.prefab_name] ~= nil then
						local var_245_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_18.prefab_name].transform, "story_v_out_325602", "325602057", "story_v_out_325602.awb")

						arg_242_1:RecordAudio("325602057", var_245_24)
						arg_242_1:RecordAudio("325602057", var_245_24)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_325602", "325602057", "story_v_out_325602.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_325602", "325602057", "story_v_out_325602.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_25 = math.max(var_245_16, arg_242_1.talkMaxDuration)

			if var_245_15 <= arg_242_1.time_ and arg_242_1.time_ < var_245_15 + var_245_25 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_15) / var_245_25

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_15 + var_245_25 and arg_242_1.time_ < var_245_15 + var_245_25 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play325602058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 325602058
		arg_246_1.duration_ = 11.6

		local var_246_0 = {
			zh = 6.366,
			ja = 11.6
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play325602059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 0.425

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_2 = arg_246_1:FormatText(StoryNameCfg[1503].name)

				arg_246_1.leftNameTxt_.text = var_249_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_3 = arg_246_1:GetWordFromCfg(325602058)
				local var_249_4 = arg_246_1:FormatText(var_249_3.content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 17
				local var_249_6 = utf8.len(var_249_4)
				local var_249_7 = var_249_5 <= 0 and var_249_1 or var_249_1 * (var_249_6 / var_249_5)

				if var_249_7 > 0 and var_249_1 < var_249_7 then
					arg_246_1.talkMaxDuration = var_249_7

					if var_249_7 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_7 + var_249_0
					end
				end

				arg_246_1.text_.text = var_249_4
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602058", "story_v_out_325602.awb") ~= 0 then
					local var_249_8 = manager.audio:GetVoiceLength("story_v_out_325602", "325602058", "story_v_out_325602.awb") / 1000

					if var_249_8 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_8 + var_249_0
					end

					if var_249_3.prefab_name ~= "" and arg_246_1.actors_[var_249_3.prefab_name] ~= nil then
						local var_249_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_3.prefab_name].transform, "story_v_out_325602", "325602058", "story_v_out_325602.awb")

						arg_246_1:RecordAudio("325602058", var_249_9)
						arg_246_1:RecordAudio("325602058", var_249_9)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_325602", "325602058", "story_v_out_325602.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_325602", "325602058", "story_v_out_325602.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_10 = math.max(var_249_1, arg_246_1.talkMaxDuration)

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_10 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_0) / var_249_10

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_0 + var_249_10 and arg_246_1.time_ < var_249_0 + var_249_10 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play325602059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 325602059
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play325602060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["10180ui_story"].transform
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.var_.moveOldPos10180ui_story = var_253_0.localPosition

				local var_253_2 = GameObjectTools.GetOrAddComponent(var_253_0.gameObject, typeof(DynamicBoneHelper))

				if var_253_2 then
					var_253_2:EnableDynamicBone(false)
				end
			end

			local var_253_3 = 0.001

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_3 then
				local var_253_4 = (arg_250_1.time_ - var_253_1) / var_253_3
				local var_253_5 = Vector3.New(0, 100, 0)

				var_253_0.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10180ui_story, var_253_5, var_253_4)

				local var_253_6 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_6.x, var_253_6.y, var_253_6.z)

				local var_253_7 = var_253_0.localEulerAngles

				var_253_7.z = 0
				var_253_7.x = 0
				var_253_0.localEulerAngles = var_253_7
			end

			if arg_250_1.time_ >= var_253_1 + var_253_3 and arg_250_1.time_ < var_253_1 + var_253_3 + arg_253_0 then
				var_253_0.localPosition = Vector3.New(0, 100, 0)

				local var_253_8 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_8.x, var_253_8.y, var_253_8.z)

				local var_253_9 = var_253_0.localEulerAngles

				var_253_9.z = 0
				var_253_9.x = 0
				var_253_0.localEulerAngles = var_253_9

				local var_253_10 = GameObjectTools.GetOrAddComponent(var_253_0.gameObject, typeof(DynamicBoneHelper))

				if var_253_10 then
					var_253_10:EnableDynamicBone(true)
				end
			end

			local var_253_11 = arg_250_1.actors_["10180ui_story"]
			local var_253_12 = 0

			if var_253_12 < arg_250_1.time_ and arg_250_1.time_ <= var_253_12 + arg_253_0 and not isNil(var_253_11) and arg_250_1.var_.characterEffect10180ui_story == nil then
				arg_250_1.var_.characterEffect10180ui_story = var_253_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_13 = 0.200000002980232

			if var_253_12 <= arg_250_1.time_ and arg_250_1.time_ < var_253_12 + var_253_13 and not isNil(var_253_11) then
				local var_253_14 = (arg_250_1.time_ - var_253_12) / var_253_13

				if arg_250_1.var_.characterEffect10180ui_story and not isNil(var_253_11) then
					local var_253_15 = Mathf.Lerp(0, 0.5, var_253_14)

					arg_250_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_250_1.var_.characterEffect10180ui_story.fillRatio = var_253_15
				end
			end

			if arg_250_1.time_ >= var_253_12 + var_253_13 and arg_250_1.time_ < var_253_12 + var_253_13 + arg_253_0 and not isNil(var_253_11) and arg_250_1.var_.characterEffect10180ui_story then
				local var_253_16 = 0.5

				arg_250_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_250_1.var_.characterEffect10180ui_story.fillRatio = var_253_16
			end

			local var_253_17 = manager.ui.mainCamera.transform
			local var_253_18 = 0

			if var_253_18 < arg_250_1.time_ and arg_250_1.time_ <= var_253_18 + arg_253_0 then
				local var_253_19 = arg_250_1.var_.effectgongonglikai
				local var_253_20
				local var_253_21 = var_253_17

				if not var_253_19 then
					var_253_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heiwu"), var_253_21)
					var_253_19.name = "gongonglikai"
					arg_250_1.var_.effectgongonglikai = var_253_19
				else
					var_253_19.transform:SetParent(var_253_21)
				end

				var_253_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_253_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_253_22 = manager.ui.mainCamera.transform
			local var_253_23 = 4

			if var_253_23 < arg_250_1.time_ and arg_250_1.time_ <= var_253_23 + arg_253_0 then
				local var_253_24 = arg_250_1.var_.effectgongonglikai

				if var_253_24 then
					Object.Destroy(var_253_24)

					arg_250_1.var_.effectgongonglikai = nil
				end
			end

			local var_253_25 = 0
			local var_253_26 = 1.7

			if var_253_25 < arg_250_1.time_ and arg_250_1.time_ <= var_253_25 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_27 = arg_250_1:GetWordFromCfg(325602059)
				local var_253_28 = arg_250_1:FormatText(var_253_27.content)

				arg_250_1.text_.text = var_253_28

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_29 = 68
				local var_253_30 = utf8.len(var_253_28)
				local var_253_31 = var_253_29 <= 0 and var_253_26 or var_253_26 * (var_253_30 / var_253_29)

				if var_253_31 > 0 and var_253_26 < var_253_31 then
					arg_250_1.talkMaxDuration = var_253_31

					if var_253_31 + var_253_25 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_31 + var_253_25
					end
				end

				arg_250_1.text_.text = var_253_28
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_32 = math.max(var_253_26, arg_250_1.talkMaxDuration)

			if var_253_25 <= arg_250_1.time_ and arg_250_1.time_ < var_253_25 + var_253_32 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_25) / var_253_32

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_25 + var_253_32 and arg_250_1.time_ < var_253_25 + var_253_32 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play325602060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 325602060
		arg_254_1.duration_ = 1.83

		local var_254_0 = {
			zh = 1.466,
			ja = 1.833
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play325602061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["10170ui_story"].transform
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.var_.moveOldPos10170ui_story = var_257_0.localPosition

				local var_257_2 = GameObjectTools.GetOrAddComponent(var_257_0.gameObject, typeof(DynamicBoneHelper))

				if var_257_2 then
					var_257_2:EnableDynamicBone(false)
				end
			end

			local var_257_3 = 0.001

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_3 then
				local var_257_4 = (arg_254_1.time_ - var_257_1) / var_257_3
				local var_257_5 = Vector3.New(0, -1.03, -6.05)

				var_257_0.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos10170ui_story, var_257_5, var_257_4)

				local var_257_6 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_6.x, var_257_6.y, var_257_6.z)

				local var_257_7 = var_257_0.localEulerAngles

				var_257_7.z = 0
				var_257_7.x = 0
				var_257_0.localEulerAngles = var_257_7
			end

			if arg_254_1.time_ >= var_257_1 + var_257_3 and arg_254_1.time_ < var_257_1 + var_257_3 + arg_257_0 then
				var_257_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_257_8 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_8.x, var_257_8.y, var_257_8.z)

				local var_257_9 = var_257_0.localEulerAngles

				var_257_9.z = 0
				var_257_9.x = 0
				var_257_0.localEulerAngles = var_257_9

				local var_257_10 = GameObjectTools.GetOrAddComponent(var_257_0.gameObject, typeof(DynamicBoneHelper))

				if var_257_10 then
					var_257_10:EnableDynamicBone(true)
				end
			end

			local var_257_11 = arg_254_1.actors_["10170ui_story"]
			local var_257_12 = 0

			if var_257_12 < arg_254_1.time_ and arg_254_1.time_ <= var_257_12 + arg_257_0 and not isNil(var_257_11) and arg_254_1.var_.characterEffect10170ui_story == nil then
				arg_254_1.var_.characterEffect10170ui_story = var_257_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_13 = 0.200000002980232

			if var_257_12 <= arg_254_1.time_ and arg_254_1.time_ < var_257_12 + var_257_13 and not isNil(var_257_11) then
				local var_257_14 = (arg_254_1.time_ - var_257_12) / var_257_13

				if arg_254_1.var_.characterEffect10170ui_story and not isNil(var_257_11) then
					arg_254_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= var_257_12 + var_257_13 and arg_254_1.time_ < var_257_12 + var_257_13 + arg_257_0 and not isNil(var_257_11) and arg_254_1.var_.characterEffect10170ui_story then
				arg_254_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_257_15 = 0
			local var_257_16 = 0.15

			if var_257_15 < arg_254_1.time_ and arg_254_1.time_ <= var_257_15 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_17 = arg_254_1:FormatText(StoryNameCfg[1450].name)

				arg_254_1.leftNameTxt_.text = var_257_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_18 = arg_254_1:GetWordFromCfg(325602060)
				local var_257_19 = arg_254_1:FormatText(var_257_18.content)

				arg_254_1.text_.text = var_257_19

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_20 = 6
				local var_257_21 = utf8.len(var_257_19)
				local var_257_22 = var_257_20 <= 0 and var_257_16 or var_257_16 * (var_257_21 / var_257_20)

				if var_257_22 > 0 and var_257_16 < var_257_22 then
					arg_254_1.talkMaxDuration = var_257_22

					if var_257_22 + var_257_15 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_22 + var_257_15
					end
				end

				arg_254_1.text_.text = var_257_19
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602060", "story_v_out_325602.awb") ~= 0 then
					local var_257_23 = manager.audio:GetVoiceLength("story_v_out_325602", "325602060", "story_v_out_325602.awb") / 1000

					if var_257_23 + var_257_15 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_23 + var_257_15
					end

					if var_257_18.prefab_name ~= "" and arg_254_1.actors_[var_257_18.prefab_name] ~= nil then
						local var_257_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_18.prefab_name].transform, "story_v_out_325602", "325602060", "story_v_out_325602.awb")

						arg_254_1:RecordAudio("325602060", var_257_24)
						arg_254_1:RecordAudio("325602060", var_257_24)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_325602", "325602060", "story_v_out_325602.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_325602", "325602060", "story_v_out_325602.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_25 = math.max(var_257_16, arg_254_1.talkMaxDuration)

			if var_257_15 <= arg_254_1.time_ and arg_254_1.time_ < var_257_15 + var_257_25 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_15) / var_257_25

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_15 + var_257_25 and arg_254_1.time_ < var_257_15 + var_257_25 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play325602061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 325602061
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play325602062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["10170ui_story"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos10170ui_story = var_261_0.localPosition

				local var_261_2 = GameObjectTools.GetOrAddComponent(var_261_0.gameObject, typeof(DynamicBoneHelper))

				if var_261_2 then
					var_261_2:EnableDynamicBone(false)
				end
			end

			local var_261_3 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_3 then
				local var_261_4 = (arg_258_1.time_ - var_261_1) / var_261_3
				local var_261_5 = Vector3.New(0, 100, 0)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos10170ui_story, var_261_5, var_261_4)

				local var_261_6 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_6.x, var_261_6.y, var_261_6.z)

				local var_261_7 = var_261_0.localEulerAngles

				var_261_7.z = 0
				var_261_7.x = 0
				var_261_0.localEulerAngles = var_261_7
			end

			if arg_258_1.time_ >= var_261_1 + var_261_3 and arg_258_1.time_ < var_261_1 + var_261_3 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(0, 100, 0)

				local var_261_8 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_8.x, var_261_8.y, var_261_8.z)

				local var_261_9 = var_261_0.localEulerAngles

				var_261_9.z = 0
				var_261_9.x = 0
				var_261_0.localEulerAngles = var_261_9

				local var_261_10 = GameObjectTools.GetOrAddComponent(var_261_0.gameObject, typeof(DynamicBoneHelper))

				if var_261_10 then
					var_261_10:EnableDynamicBone(true)
				end
			end

			local var_261_11 = arg_258_1.actors_["10170ui_story"]
			local var_261_12 = 0

			if var_261_12 < arg_258_1.time_ and arg_258_1.time_ <= var_261_12 + arg_261_0 and not isNil(var_261_11) and arg_258_1.var_.characterEffect10170ui_story == nil then
				arg_258_1.var_.characterEffect10170ui_story = var_261_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_13 = 0.200000002980232

			if var_261_12 <= arg_258_1.time_ and arg_258_1.time_ < var_261_12 + var_261_13 and not isNil(var_261_11) then
				local var_261_14 = (arg_258_1.time_ - var_261_12) / var_261_13

				if arg_258_1.var_.characterEffect10170ui_story and not isNil(var_261_11) then
					local var_261_15 = Mathf.Lerp(0, 0.5, var_261_14)

					arg_258_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_258_1.var_.characterEffect10170ui_story.fillRatio = var_261_15
				end
			end

			if arg_258_1.time_ >= var_261_12 + var_261_13 and arg_258_1.time_ < var_261_12 + var_261_13 + arg_261_0 and not isNil(var_261_11) and arg_258_1.var_.characterEffect10170ui_story then
				local var_261_16 = 0.5

				arg_258_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_258_1.var_.characterEffect10170ui_story.fillRatio = var_261_16
			end

			local var_261_17 = 0
			local var_261_18 = 0.25

			if var_261_17 < arg_258_1.time_ and arg_258_1.time_ <= var_261_17 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_19 = arg_258_1:FormatText(StoryNameCfg[7].name)

				arg_258_1.leftNameTxt_.text = var_261_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_20 = arg_258_1:GetWordFromCfg(325602061)
				local var_261_21 = arg_258_1:FormatText(var_261_20.content)

				arg_258_1.text_.text = var_261_21

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_22 = 10
				local var_261_23 = utf8.len(var_261_21)
				local var_261_24 = var_261_22 <= 0 and var_261_18 or var_261_18 * (var_261_23 / var_261_22)

				if var_261_24 > 0 and var_261_18 < var_261_24 then
					arg_258_1.talkMaxDuration = var_261_24

					if var_261_24 + var_261_17 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_24 + var_261_17
					end
				end

				arg_258_1.text_.text = var_261_21
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_25 = math.max(var_261_18, arg_258_1.talkMaxDuration)

			if var_261_17 <= arg_258_1.time_ and arg_258_1.time_ < var_261_17 + var_261_25 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_17) / var_261_25

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_17 + var_261_25 and arg_258_1.time_ < var_261_17 + var_261_25 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play325602062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 325602062
		arg_262_1.duration_ = 4.9

		local var_262_0 = {
			zh = 4.5,
			ja = 4.9
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play325602063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["10170ui_story"].transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.var_.moveOldPos10170ui_story = var_265_0.localPosition

				local var_265_2 = GameObjectTools.GetOrAddComponent(var_265_0.gameObject, typeof(DynamicBoneHelper))

				if var_265_2 then
					var_265_2:EnableDynamicBone(false)
				end
			end

			local var_265_3 = 0.001

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_3 then
				local var_265_4 = (arg_262_1.time_ - var_265_1) / var_265_3
				local var_265_5 = Vector3.New(0, -1.03, -6.05)

				var_265_0.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos10170ui_story, var_265_5, var_265_4)

				local var_265_6 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_6.x, var_265_6.y, var_265_6.z)

				local var_265_7 = var_265_0.localEulerAngles

				var_265_7.z = 0
				var_265_7.x = 0
				var_265_0.localEulerAngles = var_265_7
			end

			if arg_262_1.time_ >= var_265_1 + var_265_3 and arg_262_1.time_ < var_265_1 + var_265_3 + arg_265_0 then
				var_265_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_265_8 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_8.x, var_265_8.y, var_265_8.z)

				local var_265_9 = var_265_0.localEulerAngles

				var_265_9.z = 0
				var_265_9.x = 0
				var_265_0.localEulerAngles = var_265_9

				local var_265_10 = GameObjectTools.GetOrAddComponent(var_265_0.gameObject, typeof(DynamicBoneHelper))

				if var_265_10 then
					var_265_10:EnableDynamicBone(true)
				end
			end

			local var_265_11 = arg_262_1.actors_["10170ui_story"]
			local var_265_12 = 0

			if var_265_12 < arg_262_1.time_ and arg_262_1.time_ <= var_265_12 + arg_265_0 and not isNil(var_265_11) and arg_262_1.var_.characterEffect10170ui_story == nil then
				arg_262_1.var_.characterEffect10170ui_story = var_265_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_13 = 0.200000002980232

			if var_265_12 <= arg_262_1.time_ and arg_262_1.time_ < var_265_12 + var_265_13 and not isNil(var_265_11) then
				local var_265_14 = (arg_262_1.time_ - var_265_12) / var_265_13

				if arg_262_1.var_.characterEffect10170ui_story and not isNil(var_265_11) then
					arg_262_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= var_265_12 + var_265_13 and arg_262_1.time_ < var_265_12 + var_265_13 + arg_265_0 and not isNil(var_265_11) and arg_262_1.var_.characterEffect10170ui_story then
				arg_262_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_265_15 = 0
			local var_265_16 = 0.4

			if var_265_15 < arg_262_1.time_ and arg_262_1.time_ <= var_265_15 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_17 = arg_262_1:FormatText(StoryNameCfg[1450].name)

				arg_262_1.leftNameTxt_.text = var_265_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_18 = arg_262_1:GetWordFromCfg(325602062)
				local var_265_19 = arg_262_1:FormatText(var_265_18.content)

				arg_262_1.text_.text = var_265_19

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_20 = 16
				local var_265_21 = utf8.len(var_265_19)
				local var_265_22 = var_265_20 <= 0 and var_265_16 or var_265_16 * (var_265_21 / var_265_20)

				if var_265_22 > 0 and var_265_16 < var_265_22 then
					arg_262_1.talkMaxDuration = var_265_22

					if var_265_22 + var_265_15 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_22 + var_265_15
					end
				end

				arg_262_1.text_.text = var_265_19
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602062", "story_v_out_325602.awb") ~= 0 then
					local var_265_23 = manager.audio:GetVoiceLength("story_v_out_325602", "325602062", "story_v_out_325602.awb") / 1000

					if var_265_23 + var_265_15 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_23 + var_265_15
					end

					if var_265_18.prefab_name ~= "" and arg_262_1.actors_[var_265_18.prefab_name] ~= nil then
						local var_265_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_18.prefab_name].transform, "story_v_out_325602", "325602062", "story_v_out_325602.awb")

						arg_262_1:RecordAudio("325602062", var_265_24)
						arg_262_1:RecordAudio("325602062", var_265_24)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_325602", "325602062", "story_v_out_325602.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_325602", "325602062", "story_v_out_325602.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_25 = math.max(var_265_16, arg_262_1.talkMaxDuration)

			if var_265_15 <= arg_262_1.time_ and arg_262_1.time_ < var_265_15 + var_265_25 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_15) / var_265_25

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_15 + var_265_25 and arg_262_1.time_ < var_265_15 + var_265_25 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play325602063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 325602063
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play325602064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["10170ui_story"].transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.moveOldPos10170ui_story = var_269_0.localPosition

				local var_269_2 = GameObjectTools.GetOrAddComponent(var_269_0.gameObject, typeof(DynamicBoneHelper))

				if var_269_2 then
					var_269_2:EnableDynamicBone(false)
				end
			end

			local var_269_3 = 0.001

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_3 then
				local var_269_4 = (arg_266_1.time_ - var_269_1) / var_269_3
				local var_269_5 = Vector3.New(0, 100, 0)

				var_269_0.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos10170ui_story, var_269_5, var_269_4)

				local var_269_6 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_6.x, var_269_6.y, var_269_6.z)

				local var_269_7 = var_269_0.localEulerAngles

				var_269_7.z = 0
				var_269_7.x = 0
				var_269_0.localEulerAngles = var_269_7
			end

			if arg_266_1.time_ >= var_269_1 + var_269_3 and arg_266_1.time_ < var_269_1 + var_269_3 + arg_269_0 then
				var_269_0.localPosition = Vector3.New(0, 100, 0)

				local var_269_8 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_8.x, var_269_8.y, var_269_8.z)

				local var_269_9 = var_269_0.localEulerAngles

				var_269_9.z = 0
				var_269_9.x = 0
				var_269_0.localEulerAngles = var_269_9

				local var_269_10 = GameObjectTools.GetOrAddComponent(var_269_0.gameObject, typeof(DynamicBoneHelper))

				if var_269_10 then
					var_269_10:EnableDynamicBone(true)
				end
			end

			local var_269_11 = arg_266_1.actors_["10170ui_story"]
			local var_269_12 = 0

			if var_269_12 < arg_266_1.time_ and arg_266_1.time_ <= var_269_12 + arg_269_0 and not isNil(var_269_11) and arg_266_1.var_.characterEffect10170ui_story == nil then
				arg_266_1.var_.characterEffect10170ui_story = var_269_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_13 = 0.200000002980232

			if var_269_12 <= arg_266_1.time_ and arg_266_1.time_ < var_269_12 + var_269_13 and not isNil(var_269_11) then
				local var_269_14 = (arg_266_1.time_ - var_269_12) / var_269_13

				if arg_266_1.var_.characterEffect10170ui_story and not isNil(var_269_11) then
					local var_269_15 = Mathf.Lerp(0, 0.5, var_269_14)

					arg_266_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_266_1.var_.characterEffect10170ui_story.fillRatio = var_269_15
				end
			end

			if arg_266_1.time_ >= var_269_12 + var_269_13 and arg_266_1.time_ < var_269_12 + var_269_13 + arg_269_0 and not isNil(var_269_11) and arg_266_1.var_.characterEffect10170ui_story then
				local var_269_16 = 0.5

				arg_266_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_266_1.var_.characterEffect10170ui_story.fillRatio = var_269_16
			end

			local var_269_17 = 0
			local var_269_18 = 0.95

			if var_269_17 < arg_266_1.time_ and arg_266_1.time_ <= var_269_17 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_19 = arg_266_1:GetWordFromCfg(325602063)
				local var_269_20 = arg_266_1:FormatText(var_269_19.content)

				arg_266_1.text_.text = var_269_20

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_21 = 38
				local var_269_22 = utf8.len(var_269_20)
				local var_269_23 = var_269_21 <= 0 and var_269_18 or var_269_18 * (var_269_22 / var_269_21)

				if var_269_23 > 0 and var_269_18 < var_269_23 then
					arg_266_1.talkMaxDuration = var_269_23

					if var_269_23 + var_269_17 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_23 + var_269_17
					end
				end

				arg_266_1.text_.text = var_269_20
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_24 = math.max(var_269_18, arg_266_1.talkMaxDuration)

			if var_269_17 <= arg_266_1.time_ and arg_266_1.time_ < var_269_17 + var_269_24 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_17) / var_269_24

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_17 + var_269_24 and arg_266_1.time_ < var_269_17 + var_269_24 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play325602064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 325602064
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play325602065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 0.425

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[7].name)

				arg_270_1.leftNameTxt_.text = var_273_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_3 = arg_270_1:GetWordFromCfg(325602064)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 17
				local var_273_6 = utf8.len(var_273_4)
				local var_273_7 = var_273_5 <= 0 and var_273_1 or var_273_1 * (var_273_6 / var_273_5)

				if var_273_7 > 0 and var_273_1 < var_273_7 then
					arg_270_1.talkMaxDuration = var_273_7

					if var_273_7 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_4
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_8 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_8 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_8

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_8 and arg_270_1.time_ < var_273_0 + var_273_8 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play325602065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 325602065
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play325602066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 1.225

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_2 = arg_274_1:GetWordFromCfg(325602065)
				local var_277_3 = arg_274_1:FormatText(var_277_2.content)

				arg_274_1.text_.text = var_277_3

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_4 = 49
				local var_277_5 = utf8.len(var_277_3)
				local var_277_6 = var_277_4 <= 0 and var_277_1 or var_277_1 * (var_277_5 / var_277_4)

				if var_277_6 > 0 and var_277_1 < var_277_6 then
					arg_274_1.talkMaxDuration = var_277_6

					if var_277_6 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_6 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_3
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_7 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_7 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_7

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_7 and arg_274_1.time_ < var_277_0 + var_277_7 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play325602066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 325602066
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
			arg_278_1.auto_ = false
		end

		function arg_278_1.playNext_(arg_280_0)
			arg_278_1.onStoryFinished_()
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 1

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				local var_281_2 = "play"
				local var_281_3 = "effect"

				arg_278_1:AudioAction(var_281_2, var_281_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_281_4 = 0
			local var_281_5 = 0.575

			if var_281_4 < arg_278_1.time_ and arg_278_1.time_ <= var_281_4 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_6 = arg_278_1:GetWordFromCfg(325602066)
				local var_281_7 = arg_278_1:FormatText(var_281_6.content)

				arg_278_1.text_.text = var_281_7

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_8 = 23
				local var_281_9 = utf8.len(var_281_7)
				local var_281_10 = var_281_8 <= 0 and var_281_5 or var_281_5 * (var_281_9 / var_281_8)

				if var_281_10 > 0 and var_281_5 < var_281_10 then
					arg_278_1.talkMaxDuration = var_281_10

					if var_281_10 + var_281_4 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_10 + var_281_4
					end
				end

				arg_278_1.text_.text = var_281_7
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_11 = math.max(var_281_5, arg_278_1.talkMaxDuration)

			if var_281_4 <= arg_278_1.time_ and arg_278_1.time_ < var_281_4 + var_281_11 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_4) / var_281_11

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_4 + var_281_11 and arg_278_1.time_ < var_281_4 + var_281_11 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J25f",
		"TextureConfig/Background/J27f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/MS2504"
	},
	voices = {
		"story_v_out_325602.awb"
	}
}
