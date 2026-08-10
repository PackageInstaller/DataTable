return {
	Play325571001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325571001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325571002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2006a"

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
				local var_4_5 = arg_1_1.bgs_.ST2006a

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
					if iter_4_0 ~= "ST2006a" then
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

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_148", "se_story_148_amb_wind", "")
			end

			local var_4_28 = 0
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan")

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
			local var_4_35 = 1.125

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

				local var_4_37 = arg_1_1:GetWordFromCfg(325571001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 45
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
	Play325571002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325571002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325571003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.4

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

				local var_11_2 = arg_8_1:GetWordFromCfg(325571002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 56
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
	Play325571003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325571003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325571004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.175

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

				local var_15_2 = arg_12_1:GetWordFromCfg(325571003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 47
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
	Play325571004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325571004
		arg_16_1.duration_ = 3.33

		local var_16_0 = {
			zh = 2.933,
			ja = 3.333
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
				arg_16_0:Play325571005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "10167ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "10167ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "10167ui_story"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["10167ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos10167ui_story = var_19_5.localPosition

				local var_19_7 = GameObjectTools.GetOrAddComponent(var_19_5.gameObject, typeof(DynamicBoneHelper))

				if var_19_7 then
					var_19_7:EnableDynamicBone(false)
				end
			end

			local var_19_8 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_8 then
				local var_19_9 = (arg_16_1.time_ - var_19_6) / var_19_8
				local var_19_10 = Vector3.New(0, -1.28, -5.73)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10167ui_story, var_19_10, var_19_9)

				local var_19_11 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_11.x, var_19_11.y, var_19_11.z)

				local var_19_12 = var_19_5.localEulerAngles

				var_19_12.z = 0
				var_19_12.x = 0
				var_19_5.localEulerAngles = var_19_12
			end

			if arg_16_1.time_ >= var_19_6 + var_19_8 and arg_16_1.time_ < var_19_6 + var_19_8 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(0, -1.28, -5.73)

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

			local var_19_16 = arg_16_1.actors_["10167ui_story"]
			local var_19_17 = 0

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 and not isNil(var_19_16) and arg_16_1.var_.characterEffect10167ui_story == nil then
				arg_16_1.var_.characterEffect10167ui_story = var_19_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_18 = 0.200000002980232

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_18 and not isNil(var_19_16) then
				local var_19_19 = (arg_16_1.time_ - var_19_17) / var_19_18

				if arg_16_1.var_.characterEffect10167ui_story and not isNil(var_19_16) then
					arg_16_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_17 + var_19_18 and arg_16_1.time_ < var_19_17 + var_19_18 + arg_19_0 and not isNil(var_19_16) and arg_16_1.var_.characterEffect10167ui_story then
				arg_16_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_19_20 = 0

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			local var_19_21 = 0

			if var_19_21 < arg_16_1.time_ and arg_16_1.time_ <= var_19_21 + arg_19_0 then
				arg_16_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_19_22 = 0
			local var_19_23 = 0.325

			if var_19_22 < arg_16_1.time_ and arg_16_1.time_ <= var_19_22 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_24 = arg_16_1:FormatText(StoryNameCfg[1447].name)

				arg_16_1.leftNameTxt_.text = var_19_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_25 = arg_16_1:GetWordFromCfg(325571004)
				local var_19_26 = arg_16_1:FormatText(var_19_25.content)

				arg_16_1.text_.text = var_19_26

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_27 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571004", "story_v_out_325571.awb") ~= 0 then
					local var_19_30 = manager.audio:GetVoiceLength("story_v_out_325571", "325571004", "story_v_out_325571.awb") / 1000

					if var_19_30 + var_19_22 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_30 + var_19_22
					end

					if var_19_25.prefab_name ~= "" and arg_16_1.actors_[var_19_25.prefab_name] ~= nil then
						local var_19_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_25.prefab_name].transform, "story_v_out_325571", "325571004", "story_v_out_325571.awb")

						arg_16_1:RecordAudio("325571004", var_19_31)
						arg_16_1:RecordAudio("325571004", var_19_31)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325571", "325571004", "story_v_out_325571.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325571", "325571004", "story_v_out_325571.awb")
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
				actorName = "10167ui_story",
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
	Play325571005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325571005
		arg_20_1.duration_ = 4.17

		local var_20_0 = {
			zh = 2.733,
			ja = 4.166
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325571006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["10167ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos10167ui_story = var_23_0.localPosition

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0.gameObject, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end
			end

			local var_23_3 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_3 then
				local var_23_4 = (arg_20_1.time_ - var_23_1) / var_23_3
				local var_23_5 = Vector3.New(-0.96, -1.28, -5.73)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10167ui_story, var_23_5, var_23_4)

				local var_23_6 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_6.x, var_23_6.y, var_23_6.z)

				local var_23_7 = var_23_0.localEulerAngles

				var_23_7.z = 0
				var_23_7.x = 0
				var_23_0.localEulerAngles = var_23_7
			end

			if arg_20_1.time_ >= var_23_1 + var_23_3 and arg_20_1.time_ < var_23_1 + var_23_3 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(-0.96, -1.28, -5.73)

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

			local var_23_11 = "10175ui_story"

			if arg_20_1.actors_[var_23_11] == nil then
				local var_23_12 = Asset.Load("Char/" .. "10175ui_story")

				if not isNil(var_23_12) then
					local var_23_13 = Object.Instantiate(Asset.Load("Char/" .. "10175ui_story"), arg_20_1.stage_.transform)

					var_23_13.name = var_23_11
					var_23_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_11] = var_23_13

					local var_23_14 = var_23_13:GetComponentInChildren(typeof(CharacterEffect))

					var_23_14.enabled = true

					local var_23_15 = GameObjectTools.GetOrAddComponent(var_23_13, typeof(DynamicBoneHelper))

					if var_23_15 then
						var_23_15:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_14.transform, false)

					arg_20_1.var_[var_23_11 .. "Animator"] = var_23_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_11 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_11 .. "LipSync"] = var_23_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_16 = arg_20_1.actors_["10175ui_story"].transform
			local var_23_17 = 0

			if var_23_17 < arg_20_1.time_ and arg_20_1.time_ <= var_23_17 + arg_23_0 then
				arg_20_1.var_.moveOldPos10175ui_story = var_23_16.localPosition

				local var_23_18 = GameObjectTools.GetOrAddComponent(var_23_16.gameObject, typeof(DynamicBoneHelper))

				if var_23_18 then
					var_23_18:EnableDynamicBone(false)
				end
			end

			local var_23_19 = 0.001

			if var_23_17 <= arg_20_1.time_ and arg_20_1.time_ < var_23_17 + var_23_19 then
				local var_23_20 = (arg_20_1.time_ - var_23_17) / var_23_19
				local var_23_21 = Vector3.New(0.7, -1, -6.05)

				var_23_16.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10175ui_story, var_23_21, var_23_20)

				local var_23_22 = manager.ui.mainCamera.transform.position - var_23_16.position

				var_23_16.forward = Vector3.New(var_23_22.x, var_23_22.y, var_23_22.z)

				local var_23_23 = var_23_16.localEulerAngles

				var_23_23.z = 0
				var_23_23.x = 0
				var_23_16.localEulerAngles = var_23_23
			end

			if arg_20_1.time_ >= var_23_17 + var_23_19 and arg_20_1.time_ < var_23_17 + var_23_19 + arg_23_0 then
				var_23_16.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_23_24 = manager.ui.mainCamera.transform.position - var_23_16.position

				var_23_16.forward = Vector3.New(var_23_24.x, var_23_24.y, var_23_24.z)

				local var_23_25 = var_23_16.localEulerAngles

				var_23_25.z = 0
				var_23_25.x = 0
				var_23_16.localEulerAngles = var_23_25

				local var_23_26 = GameObjectTools.GetOrAddComponent(var_23_16.gameObject, typeof(DynamicBoneHelper))

				if var_23_26 then
					var_23_26:EnableDynamicBone(true)
				end
			end

			local var_23_27 = arg_20_1.actors_["10175ui_story"]
			local var_23_28 = 0

			if var_23_28 < arg_20_1.time_ and arg_20_1.time_ <= var_23_28 + arg_23_0 and not isNil(var_23_27) and arg_20_1.var_.characterEffect10175ui_story == nil then
				arg_20_1.var_.characterEffect10175ui_story = var_23_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_29 = 0.200000002980232

			if var_23_28 <= arg_20_1.time_ and arg_20_1.time_ < var_23_28 + var_23_29 and not isNil(var_23_27) then
				local var_23_30 = (arg_20_1.time_ - var_23_28) / var_23_29

				if arg_20_1.var_.characterEffect10175ui_story and not isNil(var_23_27) then
					arg_20_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_28 + var_23_29 and arg_20_1.time_ < var_23_28 + var_23_29 + arg_23_0 and not isNil(var_23_27) and arg_20_1.var_.characterEffect10175ui_story then
				arg_20_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_23_31 = arg_20_1.actors_["10167ui_story"]
			local var_23_32 = 0

			if var_23_32 < arg_20_1.time_ and arg_20_1.time_ <= var_23_32 + arg_23_0 and not isNil(var_23_31) and arg_20_1.var_.characterEffect10167ui_story == nil then
				arg_20_1.var_.characterEffect10167ui_story = var_23_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_33 = 0.200000002980232

			if var_23_32 <= arg_20_1.time_ and arg_20_1.time_ < var_23_32 + var_23_33 and not isNil(var_23_31) then
				local var_23_34 = (arg_20_1.time_ - var_23_32) / var_23_33

				if arg_20_1.var_.characterEffect10167ui_story and not isNil(var_23_31) then
					local var_23_35 = Mathf.Lerp(0, 0.5, var_23_34)

					arg_20_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_20_1.var_.characterEffect10167ui_story.fillRatio = var_23_35
				end
			end

			if arg_20_1.time_ >= var_23_32 + var_23_33 and arg_20_1.time_ < var_23_32 + var_23_33 + arg_23_0 and not isNil(var_23_31) and arg_20_1.var_.characterEffect10167ui_story then
				local var_23_36 = 0.5

				arg_20_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_20_1.var_.characterEffect10167ui_story.fillRatio = var_23_36
			end

			local var_23_37 = 0

			if var_23_37 < arg_20_1.time_ and arg_20_1.time_ <= var_23_37 + arg_23_0 then
				arg_20_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			local var_23_38 = 0

			if var_23_38 < arg_20_1.time_ and arg_20_1.time_ <= var_23_38 + arg_23_0 then
				arg_20_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_23_39 = 0
			local var_23_40 = 0.475

			if var_23_39 < arg_20_1.time_ and arg_20_1.time_ <= var_23_39 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_41 = arg_20_1:FormatText(StoryNameCfg[1473].name)

				arg_20_1.leftNameTxt_.text = var_23_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_42 = arg_20_1:GetWordFromCfg(325571005)
				local var_23_43 = arg_20_1:FormatText(var_23_42.content)

				arg_20_1.text_.text = var_23_43

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_44 = 19
				local var_23_45 = utf8.len(var_23_43)
				local var_23_46 = var_23_44 <= 0 and var_23_40 or var_23_40 * (var_23_45 / var_23_44)

				if var_23_46 > 0 and var_23_40 < var_23_46 then
					arg_20_1.talkMaxDuration = var_23_46

					if var_23_46 + var_23_39 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_46 + var_23_39
					end
				end

				arg_20_1.text_.text = var_23_43
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571005", "story_v_out_325571.awb") ~= 0 then
					local var_23_47 = manager.audio:GetVoiceLength("story_v_out_325571", "325571005", "story_v_out_325571.awb") / 1000

					if var_23_47 + var_23_39 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_47 + var_23_39
					end

					if var_23_42.prefab_name ~= "" and arg_20_1.actors_[var_23_42.prefab_name] ~= nil then
						local var_23_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_42.prefab_name].transform, "story_v_out_325571", "325571005", "story_v_out_325571.awb")

						arg_20_1:RecordAudio("325571005", var_23_48)
						arg_20_1:RecordAudio("325571005", var_23_48)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325571", "325571005", "story_v_out_325571.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325571", "325571005", "story_v_out_325571.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_49 = math.max(var_23_40, arg_20_1.talkMaxDuration)

			if var_23_39 <= arg_20_1.time_ and arg_20_1.time_ < var_23_39 + var_23_49 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_39) / var_23_49

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_39 + var_23_49 and arg_20_1.time_ < var_23_39 + var_23_49 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
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
	Play325571006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325571006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play325571007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["10175ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos10175ui_story = var_27_0.localPosition

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end
			end

			local var_27_3 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_3 then
				local var_27_4 = (arg_24_1.time_ - var_27_1) / var_27_3
				local var_27_5 = Vector3.New(0, 100, 0)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10175ui_story, var_27_5, var_27_4)

				local var_27_6 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_6.x, var_27_6.y, var_27_6.z)

				local var_27_7 = var_27_0.localEulerAngles

				var_27_7.z = 0
				var_27_7.x = 0
				var_27_0.localEulerAngles = var_27_7
			end

			if arg_24_1.time_ >= var_27_1 + var_27_3 and arg_24_1.time_ < var_27_1 + var_27_3 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_27_11 = arg_24_1.actors_["10167ui_story"].transform
			local var_27_12 = 0

			if var_27_12 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				arg_24_1.var_.moveOldPos10167ui_story = var_27_11.localPosition

				local var_27_13 = GameObjectTools.GetOrAddComponent(var_27_11.gameObject, typeof(DynamicBoneHelper))

				if var_27_13 then
					var_27_13:EnableDynamicBone(false)
				end
			end

			local var_27_14 = 0.001

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_14 then
				local var_27_15 = (arg_24_1.time_ - var_27_12) / var_27_14
				local var_27_16 = Vector3.New(0, 100, 0)

				var_27_11.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10167ui_story, var_27_16, var_27_15)

				local var_27_17 = manager.ui.mainCamera.transform.position - var_27_11.position

				var_27_11.forward = Vector3.New(var_27_17.x, var_27_17.y, var_27_17.z)

				local var_27_18 = var_27_11.localEulerAngles

				var_27_18.z = 0
				var_27_18.x = 0
				var_27_11.localEulerAngles = var_27_18
			end

			if arg_24_1.time_ >= var_27_12 + var_27_14 and arg_24_1.time_ < var_27_12 + var_27_14 + arg_27_0 then
				var_27_11.localPosition = Vector3.New(0, 100, 0)

				local var_27_19 = manager.ui.mainCamera.transform.position - var_27_11.position

				var_27_11.forward = Vector3.New(var_27_19.x, var_27_19.y, var_27_19.z)

				local var_27_20 = var_27_11.localEulerAngles

				var_27_20.z = 0
				var_27_20.x = 0
				var_27_11.localEulerAngles = var_27_20

				local var_27_21 = GameObjectTools.GetOrAddComponent(var_27_11.gameObject, typeof(DynamicBoneHelper))

				if var_27_21 then
					var_27_21:EnableDynamicBone(true)
				end
			end

			local var_27_22 = arg_24_1.actors_["10175ui_story"]
			local var_27_23 = 0

			if var_27_23 < arg_24_1.time_ and arg_24_1.time_ <= var_27_23 + arg_27_0 and not isNil(var_27_22) and arg_24_1.var_.characterEffect10175ui_story == nil then
				arg_24_1.var_.characterEffect10175ui_story = var_27_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_24 = 0.200000002980232

			if var_27_23 <= arg_24_1.time_ and arg_24_1.time_ < var_27_23 + var_27_24 and not isNil(var_27_22) then
				local var_27_25 = (arg_24_1.time_ - var_27_23) / var_27_24

				if arg_24_1.var_.characterEffect10175ui_story and not isNil(var_27_22) then
					local var_27_26 = Mathf.Lerp(0, 0.5, var_27_25)

					arg_24_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_24_1.var_.characterEffect10175ui_story.fillRatio = var_27_26
				end
			end

			if arg_24_1.time_ >= var_27_23 + var_27_24 and arg_24_1.time_ < var_27_23 + var_27_24 + arg_27_0 and not isNil(var_27_22) and arg_24_1.var_.characterEffect10175ui_story then
				local var_27_27 = 0.5

				arg_24_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_24_1.var_.characterEffect10175ui_story.fillRatio = var_27_27
			end

			local var_27_28 = 0
			local var_27_29 = 0.975

			if var_27_28 < arg_24_1.time_ and arg_24_1.time_ <= var_27_28 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_30 = arg_24_1:GetWordFromCfg(325571006)
				local var_27_31 = arg_24_1:FormatText(var_27_30.content)

				arg_24_1.text_.text = var_27_31

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_32 = 39
				local var_27_33 = utf8.len(var_27_31)
				local var_27_34 = var_27_32 <= 0 and var_27_29 or var_27_29 * (var_27_33 / var_27_32)

				if var_27_34 > 0 and var_27_29 < var_27_34 then
					arg_24_1.talkMaxDuration = var_27_34

					if var_27_34 + var_27_28 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_34 + var_27_28
					end
				end

				arg_24_1.text_.text = var_27_31
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_35 = math.max(var_27_29, arg_24_1.talkMaxDuration)

			if var_27_28 <= arg_24_1.time_ and arg_24_1.time_ < var_27_28 + var_27_35 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_28) / var_27_35

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_28 + var_27_35 and arg_24_1.time_ < var_27_28 + var_27_35 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10167ui_story",
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
	Play325571007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325571007
		arg_28_1.duration_ = 8.57

		local var_28_0 = {
			zh = 8.566,
			ja = 5.6
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play325571008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "10176ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "10176ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "10176ui_story"), arg_28_1.stage_.transform)

					var_31_2.name = var_31_0
					var_31_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_28_1.actors_[var_31_0] = var_31_2

					local var_31_3 = var_31_2:GetComponentInChildren(typeof(CharacterEffect))

					var_31_3.enabled = true

					local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_2, typeof(DynamicBoneHelper))

					if var_31_4 then
						var_31_4:EnableDynamicBone(false)
					end

					arg_28_1:ShowWeapon(var_31_3.transform, false)

					arg_28_1.var_[var_31_0 .. "Animator"] = var_31_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_28_1.var_[var_31_0 .. "Animator"].applyRootMotion = true
					arg_28_1.var_[var_31_0 .. "LipSync"] = var_31_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_31_5 = arg_28_1.actors_["10176ui_story"].transform
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.var_.moveOldPos10176ui_story = var_31_5.localPosition

				local var_31_7 = GameObjectTools.GetOrAddComponent(var_31_5.gameObject, typeof(DynamicBoneHelper))

				if var_31_7 then
					var_31_7:EnableDynamicBone(false)
				end
			end

			local var_31_8 = 0.001

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_8 then
				local var_31_9 = (arg_28_1.time_ - var_31_6) / var_31_8
				local var_31_10 = Vector3.New(-0.02, -1.09, -6.12)

				var_31_5.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10176ui_story, var_31_10, var_31_9)

				local var_31_11 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_11.x, var_31_11.y, var_31_11.z)

				local var_31_12 = var_31_5.localEulerAngles

				var_31_12.z = 0
				var_31_12.x = 0
				var_31_5.localEulerAngles = var_31_12
			end

			if arg_28_1.time_ >= var_31_6 + var_31_8 and arg_28_1.time_ < var_31_6 + var_31_8 + arg_31_0 then
				var_31_5.localPosition = Vector3.New(-0.02, -1.09, -6.12)

				local var_31_13 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_13.x, var_31_13.y, var_31_13.z)

				local var_31_14 = var_31_5.localEulerAngles

				var_31_14.z = 0
				var_31_14.x = 0
				var_31_5.localEulerAngles = var_31_14

				local var_31_15 = GameObjectTools.GetOrAddComponent(var_31_5.gameObject, typeof(DynamicBoneHelper))

				if var_31_15 then
					var_31_15:EnableDynamicBone(true)
				end
			end

			local var_31_16 = arg_28_1.actors_["10176ui_story"]
			local var_31_17 = 0

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect10176ui_story == nil then
				arg_28_1.var_.characterEffect10176ui_story = var_31_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_18 = 0.200000002980232

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_18 and not isNil(var_31_16) then
				local var_31_19 = (arg_28_1.time_ - var_31_17) / var_31_18

				if arg_28_1.var_.characterEffect10176ui_story and not isNil(var_31_16) then
					arg_28_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_17 + var_31_18 and arg_28_1.time_ < var_31_17 + var_31_18 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect10176ui_story then
				arg_28_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_31_20 = 0

			if var_31_20 < arg_28_1.time_ and arg_28_1.time_ <= var_31_20 + arg_31_0 then
				arg_28_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action4_1")
			end

			local var_31_21 = 0

			if var_31_21 < arg_28_1.time_ and arg_28_1.time_ <= var_31_21 + arg_31_0 then
				arg_28_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_31_22 = 0
			local var_31_23 = 0.55

			if var_31_22 < arg_28_1.time_ and arg_28_1.time_ <= var_31_22 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_24 = arg_28_1:FormatText(StoryNameCfg[1510].name)

				arg_28_1.leftNameTxt_.text = var_31_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_25 = arg_28_1:GetWordFromCfg(325571007)
				local var_31_26 = arg_28_1:FormatText(var_31_25.content)

				arg_28_1.text_.text = var_31_26

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_27 = 22
				local var_31_28 = utf8.len(var_31_26)
				local var_31_29 = var_31_27 <= 0 and var_31_23 or var_31_23 * (var_31_28 / var_31_27)

				if var_31_29 > 0 and var_31_23 < var_31_29 then
					arg_28_1.talkMaxDuration = var_31_29

					if var_31_29 + var_31_22 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_29 + var_31_22
					end
				end

				arg_28_1.text_.text = var_31_26
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571007", "story_v_out_325571.awb") ~= 0 then
					local var_31_30 = manager.audio:GetVoiceLength("story_v_out_325571", "325571007", "story_v_out_325571.awb") / 1000

					if var_31_30 + var_31_22 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_30 + var_31_22
					end

					if var_31_25.prefab_name ~= "" and arg_28_1.actors_[var_31_25.prefab_name] ~= nil then
						local var_31_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_25.prefab_name].transform, "story_v_out_325571", "325571007", "story_v_out_325571.awb")

						arg_28_1:RecordAudio("325571007", var_31_31)
						arg_28_1:RecordAudio("325571007", var_31_31)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325571", "325571007", "story_v_out_325571.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325571", "325571007", "story_v_out_325571.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_32 = math.max(var_31_23, arg_28_1.talkMaxDuration)

			if var_31_22 <= arg_28_1.time_ and arg_28_1.time_ < var_31_22 + var_31_32 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_22) / var_31_32

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_22 + var_31_32 and arg_28_1.time_ < var_31_22 + var_31_32 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
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
	Play325571008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325571008
		arg_32_1.duration_ = 5.97

		local var_32_0 = {
			zh = 4.4,
			ja = 5.966
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325571009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10176ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos10176ui_story = var_35_0.localPosition

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end
			end

			local var_35_3 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_3 then
				local var_35_4 = (arg_32_1.time_ - var_35_1) / var_35_3
				local var_35_5 = Vector3.New(-0.7, -1.09, -6.12)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10176ui_story, var_35_5, var_35_4)

				local var_35_6 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_6.x, var_35_6.y, var_35_6.z)

				local var_35_7 = var_35_0.localEulerAngles

				var_35_7.z = 0
				var_35_7.x = 0
				var_35_0.localEulerAngles = var_35_7
			end

			if arg_32_1.time_ >= var_35_1 + var_35_3 and arg_32_1.time_ < var_35_1 + var_35_3 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(-0.7, -1.09, -6.12)

				local var_35_8 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_8.x, var_35_8.y, var_35_8.z)

				local var_35_9 = var_35_0.localEulerAngles

				var_35_9.z = 0
				var_35_9.x = 0
				var_35_0.localEulerAngles = var_35_9

				local var_35_10 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_10 then
					var_35_10:EnableDynamicBone(true)
				end
			end

			local var_35_11 = arg_32_1.actors_["10175ui_story"].transform
			local var_35_12 = 0

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.var_.moveOldPos10175ui_story = var_35_11.localPosition

				local var_35_13 = GameObjectTools.GetOrAddComponent(var_35_11.gameObject, typeof(DynamicBoneHelper))

				if var_35_13 then
					var_35_13:EnableDynamicBone(false)
				end
			end

			local var_35_14 = 0.001

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_14 then
				local var_35_15 = (arg_32_1.time_ - var_35_12) / var_35_14
				local var_35_16 = Vector3.New(0.7, -1, -6.05)

				var_35_11.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10175ui_story, var_35_16, var_35_15)

				local var_35_17 = manager.ui.mainCamera.transform.position - var_35_11.position

				var_35_11.forward = Vector3.New(var_35_17.x, var_35_17.y, var_35_17.z)

				local var_35_18 = var_35_11.localEulerAngles

				var_35_18.z = 0
				var_35_18.x = 0
				var_35_11.localEulerAngles = var_35_18
			end

			if arg_32_1.time_ >= var_35_12 + var_35_14 and arg_32_1.time_ < var_35_12 + var_35_14 + arg_35_0 then
				var_35_11.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_35_19 = manager.ui.mainCamera.transform.position - var_35_11.position

				var_35_11.forward = Vector3.New(var_35_19.x, var_35_19.y, var_35_19.z)

				local var_35_20 = var_35_11.localEulerAngles

				var_35_20.z = 0
				var_35_20.x = 0
				var_35_11.localEulerAngles = var_35_20

				local var_35_21 = GameObjectTools.GetOrAddComponent(var_35_11.gameObject, typeof(DynamicBoneHelper))

				if var_35_21 then
					var_35_21:EnableDynamicBone(true)
				end
			end

			local var_35_22 = arg_32_1.actors_["10175ui_story"]
			local var_35_23 = 0

			if var_35_23 < arg_32_1.time_ and arg_32_1.time_ <= var_35_23 + arg_35_0 and not isNil(var_35_22) and arg_32_1.var_.characterEffect10175ui_story == nil then
				arg_32_1.var_.characterEffect10175ui_story = var_35_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_24 = 0.200000002980232

			if var_35_23 <= arg_32_1.time_ and arg_32_1.time_ < var_35_23 + var_35_24 and not isNil(var_35_22) then
				local var_35_25 = (arg_32_1.time_ - var_35_23) / var_35_24

				if arg_32_1.var_.characterEffect10175ui_story and not isNil(var_35_22) then
					arg_32_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_23 + var_35_24 and arg_32_1.time_ < var_35_23 + var_35_24 + arg_35_0 and not isNil(var_35_22) and arg_32_1.var_.characterEffect10175ui_story then
				arg_32_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_35_26 = arg_32_1.actors_["10176ui_story"]
			local var_35_27 = 0

			if var_35_27 < arg_32_1.time_ and arg_32_1.time_ <= var_35_27 + arg_35_0 and not isNil(var_35_26) and arg_32_1.var_.characterEffect10176ui_story == nil then
				arg_32_1.var_.characterEffect10176ui_story = var_35_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_28 = 0.200000002980232

			if var_35_27 <= arg_32_1.time_ and arg_32_1.time_ < var_35_27 + var_35_28 and not isNil(var_35_26) then
				local var_35_29 = (arg_32_1.time_ - var_35_27) / var_35_28

				if arg_32_1.var_.characterEffect10176ui_story and not isNil(var_35_26) then
					local var_35_30 = Mathf.Lerp(0, 0.5, var_35_29)

					arg_32_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_32_1.var_.characterEffect10176ui_story.fillRatio = var_35_30
				end
			end

			if arg_32_1.time_ >= var_35_27 + var_35_28 and arg_32_1.time_ < var_35_27 + var_35_28 + arg_35_0 and not isNil(var_35_26) and arg_32_1.var_.characterEffect10176ui_story then
				local var_35_31 = 0.5

				arg_32_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_32_1.var_.characterEffect10176ui_story.fillRatio = var_35_31
			end

			local var_35_32 = 0
			local var_35_33 = 0.575

			if var_35_32 < arg_32_1.time_ and arg_32_1.time_ <= var_35_32 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_34 = arg_32_1:FormatText(StoryNameCfg[1473].name)

				arg_32_1.leftNameTxt_.text = var_35_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_35 = arg_32_1:GetWordFromCfg(325571008)
				local var_35_36 = arg_32_1:FormatText(var_35_35.content)

				arg_32_1.text_.text = var_35_36

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_37 = 23
				local var_35_38 = utf8.len(var_35_36)
				local var_35_39 = var_35_37 <= 0 and var_35_33 or var_35_33 * (var_35_38 / var_35_37)

				if var_35_39 > 0 and var_35_33 < var_35_39 then
					arg_32_1.talkMaxDuration = var_35_39

					if var_35_39 + var_35_32 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_39 + var_35_32
					end
				end

				arg_32_1.text_.text = var_35_36
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571008", "story_v_out_325571.awb") ~= 0 then
					local var_35_40 = manager.audio:GetVoiceLength("story_v_out_325571", "325571008", "story_v_out_325571.awb") / 1000

					if var_35_40 + var_35_32 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_40 + var_35_32
					end

					if var_35_35.prefab_name ~= "" and arg_32_1.actors_[var_35_35.prefab_name] ~= nil then
						local var_35_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_35.prefab_name].transform, "story_v_out_325571", "325571008", "story_v_out_325571.awb")

						arg_32_1:RecordAudio("325571008", var_35_41)
						arg_32_1:RecordAudio("325571008", var_35_41)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325571", "325571008", "story_v_out_325571.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325571", "325571008", "story_v_out_325571.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_42 = math.max(var_35_33, arg_32_1.talkMaxDuration)

			if var_35_32 <= arg_32_1.time_ and arg_32_1.time_ < var_35_32 + var_35_42 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_32) / var_35_42

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_32 + var_35_42 and arg_32_1.time_ < var_35_32 + var_35_42 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play325571009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325571009
		arg_36_1.duration_ = 6.6

		local var_36_0 = {
			zh = 6.233,
			ja = 6.6
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
				arg_36_0:Play325571010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10175ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos10175ui_story = var_39_0.localPosition

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end
			end

			local var_39_3 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_3 then
				local var_39_4 = (arg_36_1.time_ - var_39_1) / var_39_3
				local var_39_5 = Vector3.New(0, 100, 0)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10175ui_story, var_39_5, var_39_4)

				local var_39_6 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_6.x, var_39_6.y, var_39_6.z)

				local var_39_7 = var_39_0.localEulerAngles

				var_39_7.z = 0
				var_39_7.x = 0
				var_39_0.localEulerAngles = var_39_7
			end

			if arg_36_1.time_ >= var_39_1 + var_39_3 and arg_36_1.time_ < var_39_1 + var_39_3 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, 100, 0)

				local var_39_8 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_8.x, var_39_8.y, var_39_8.z)

				local var_39_9 = var_39_0.localEulerAngles

				var_39_9.z = 0
				var_39_9.x = 0
				var_39_0.localEulerAngles = var_39_9

				local var_39_10 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_10 then
					var_39_10:EnableDynamicBone(true)
				end
			end

			local var_39_11 = arg_36_1.actors_["10176ui_story"].transform
			local var_39_12 = 0

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.var_.moveOldPos10176ui_story = var_39_11.localPosition

				local var_39_13 = GameObjectTools.GetOrAddComponent(var_39_11.gameObject, typeof(DynamicBoneHelper))

				if var_39_13 then
					var_39_13:EnableDynamicBone(false)
				end
			end

			local var_39_14 = 0.001

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_14 then
				local var_39_15 = (arg_36_1.time_ - var_39_12) / var_39_14
				local var_39_16 = Vector3.New(0, 100, 0)

				var_39_11.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10176ui_story, var_39_16, var_39_15)

				local var_39_17 = manager.ui.mainCamera.transform.position - var_39_11.position

				var_39_11.forward = Vector3.New(var_39_17.x, var_39_17.y, var_39_17.z)

				local var_39_18 = var_39_11.localEulerAngles

				var_39_18.z = 0
				var_39_18.x = 0
				var_39_11.localEulerAngles = var_39_18
			end

			if arg_36_1.time_ >= var_39_12 + var_39_14 and arg_36_1.time_ < var_39_12 + var_39_14 + arg_39_0 then
				var_39_11.localPosition = Vector3.New(0, 100, 0)

				local var_39_19 = manager.ui.mainCamera.transform.position - var_39_11.position

				var_39_11.forward = Vector3.New(var_39_19.x, var_39_19.y, var_39_19.z)

				local var_39_20 = var_39_11.localEulerAngles

				var_39_20.z = 0
				var_39_20.x = 0
				var_39_11.localEulerAngles = var_39_20

				local var_39_21 = GameObjectTools.GetOrAddComponent(var_39_11.gameObject, typeof(DynamicBoneHelper))

				if var_39_21 then
					var_39_21:EnableDynamicBone(true)
				end
			end

			local var_39_22 = arg_36_1.actors_["10167ui_story"].transform
			local var_39_23 = 0

			if var_39_23 < arg_36_1.time_ and arg_36_1.time_ <= var_39_23 + arg_39_0 then
				arg_36_1.var_.moveOldPos10167ui_story = var_39_22.localPosition

				local var_39_24 = GameObjectTools.GetOrAddComponent(var_39_22.gameObject, typeof(DynamicBoneHelper))

				if var_39_24 then
					var_39_24:EnableDynamicBone(false)
				end
			end

			local var_39_25 = 0.001

			if var_39_23 <= arg_36_1.time_ and arg_36_1.time_ < var_39_23 + var_39_25 then
				local var_39_26 = (arg_36_1.time_ - var_39_23) / var_39_25
				local var_39_27 = Vector3.New(0, -1.28, -5.73)

				var_39_22.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10167ui_story, var_39_27, var_39_26)

				local var_39_28 = manager.ui.mainCamera.transform.position - var_39_22.position

				var_39_22.forward = Vector3.New(var_39_28.x, var_39_28.y, var_39_28.z)

				local var_39_29 = var_39_22.localEulerAngles

				var_39_29.z = 0
				var_39_29.x = 0
				var_39_22.localEulerAngles = var_39_29
			end

			if arg_36_1.time_ >= var_39_23 + var_39_25 and arg_36_1.time_ < var_39_23 + var_39_25 + arg_39_0 then
				var_39_22.localPosition = Vector3.New(0, -1.28, -5.73)

				local var_39_30 = manager.ui.mainCamera.transform.position - var_39_22.position

				var_39_22.forward = Vector3.New(var_39_30.x, var_39_30.y, var_39_30.z)

				local var_39_31 = var_39_22.localEulerAngles

				var_39_31.z = 0
				var_39_31.x = 0
				var_39_22.localEulerAngles = var_39_31

				local var_39_32 = GameObjectTools.GetOrAddComponent(var_39_22.gameObject, typeof(DynamicBoneHelper))

				if var_39_32 then
					var_39_32:EnableDynamicBone(true)
				end
			end

			local var_39_33 = arg_36_1.actors_["10167ui_story"]
			local var_39_34 = 0

			if var_39_34 < arg_36_1.time_ and arg_36_1.time_ <= var_39_34 + arg_39_0 and not isNil(var_39_33) and arg_36_1.var_.characterEffect10167ui_story == nil then
				arg_36_1.var_.characterEffect10167ui_story = var_39_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_35 = 0.200000002980232

			if var_39_34 <= arg_36_1.time_ and arg_36_1.time_ < var_39_34 + var_39_35 and not isNil(var_39_33) then
				local var_39_36 = (arg_36_1.time_ - var_39_34) / var_39_35

				if arg_36_1.var_.characterEffect10167ui_story and not isNil(var_39_33) then
					arg_36_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_34 + var_39_35 and arg_36_1.time_ < var_39_34 + var_39_35 + arg_39_0 and not isNil(var_39_33) and arg_36_1.var_.characterEffect10167ui_story then
				arg_36_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_39_37 = arg_36_1.actors_["10175ui_story"]
			local var_39_38 = 0

			if var_39_38 < arg_36_1.time_ and arg_36_1.time_ <= var_39_38 + arg_39_0 and not isNil(var_39_37) and arg_36_1.var_.characterEffect10175ui_story == nil then
				arg_36_1.var_.characterEffect10175ui_story = var_39_37:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_39 = 0.200000002980232

			if var_39_38 <= arg_36_1.time_ and arg_36_1.time_ < var_39_38 + var_39_39 and not isNil(var_39_37) then
				local var_39_40 = (arg_36_1.time_ - var_39_38) / var_39_39

				if arg_36_1.var_.characterEffect10175ui_story and not isNil(var_39_37) then
					local var_39_41 = Mathf.Lerp(0, 0.5, var_39_40)

					arg_36_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10175ui_story.fillRatio = var_39_41
				end
			end

			if arg_36_1.time_ >= var_39_38 + var_39_39 and arg_36_1.time_ < var_39_38 + var_39_39 + arg_39_0 and not isNil(var_39_37) and arg_36_1.var_.characterEffect10175ui_story then
				local var_39_42 = 0.5

				arg_36_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10175ui_story.fillRatio = var_39_42
			end

			local var_39_43 = 0
			local var_39_44 = 0.625

			if var_39_43 < arg_36_1.time_ and arg_36_1.time_ <= var_39_43 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_45 = arg_36_1:FormatText(StoryNameCfg[1447].name)

				arg_36_1.leftNameTxt_.text = var_39_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_46 = arg_36_1:GetWordFromCfg(325571009)
				local var_39_47 = arg_36_1:FormatText(var_39_46.content)

				arg_36_1.text_.text = var_39_47

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_48 = 25
				local var_39_49 = utf8.len(var_39_47)
				local var_39_50 = var_39_48 <= 0 and var_39_44 or var_39_44 * (var_39_49 / var_39_48)

				if var_39_50 > 0 and var_39_44 < var_39_50 then
					arg_36_1.talkMaxDuration = var_39_50

					if var_39_50 + var_39_43 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_50 + var_39_43
					end
				end

				arg_36_1.text_.text = var_39_47
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571009", "story_v_out_325571.awb") ~= 0 then
					local var_39_51 = manager.audio:GetVoiceLength("story_v_out_325571", "325571009", "story_v_out_325571.awb") / 1000

					if var_39_51 + var_39_43 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_51 + var_39_43
					end

					if var_39_46.prefab_name ~= "" and arg_36_1.actors_[var_39_46.prefab_name] ~= nil then
						local var_39_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_46.prefab_name].transform, "story_v_out_325571", "325571009", "story_v_out_325571.awb")

						arg_36_1:RecordAudio("325571009", var_39_52)
						arg_36_1:RecordAudio("325571009", var_39_52)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325571", "325571009", "story_v_out_325571.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325571", "325571009", "story_v_out_325571.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_53 = math.max(var_39_44, arg_36_1.talkMaxDuration)

			if var_39_43 <= arg_36_1.time_ and arg_36_1.time_ < var_39_43 + var_39_53 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_43) / var_39_53

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_43 + var_39_53 and arg_36_1.time_ < var_39_43 + var_39_53 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play325571010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325571010
		arg_40_1.duration_ = 11.93

		local var_40_0 = {
			zh = 11.033,
			ja = 11.933
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play325571011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_1")
			end

			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_43_2 = 0
			local var_43_3 = 1.15

			if var_43_2 < arg_40_1.time_ and arg_40_1.time_ <= var_43_2 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_4 = arg_40_1:FormatText(StoryNameCfg[1447].name)

				arg_40_1.leftNameTxt_.text = var_43_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_5 = arg_40_1:GetWordFromCfg(325571010)
				local var_43_6 = arg_40_1:FormatText(var_43_5.content)

				arg_40_1.text_.text = var_43_6

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_7 = 46
				local var_43_8 = utf8.len(var_43_6)
				local var_43_9 = var_43_7 <= 0 and var_43_3 or var_43_3 * (var_43_8 / var_43_7)

				if var_43_9 > 0 and var_43_3 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_2
					end
				end

				arg_40_1.text_.text = var_43_6
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571010", "story_v_out_325571.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_325571", "325571010", "story_v_out_325571.awb") / 1000

					if var_43_10 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_2
					end

					if var_43_5.prefab_name ~= "" and arg_40_1.actors_[var_43_5.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_5.prefab_name].transform, "story_v_out_325571", "325571010", "story_v_out_325571.awb")

						arg_40_1:RecordAudio("325571010", var_43_11)
						arg_40_1:RecordAudio("325571010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325571", "325571010", "story_v_out_325571.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325571", "325571010", "story_v_out_325571.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_3, arg_40_1.talkMaxDuration)

			if var_43_2 <= arg_40_1.time_ and arg_40_1.time_ < var_43_2 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_2) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_2 + var_43_12 and arg_40_1.time_ < var_43_2 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325571011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325571011
		arg_44_1.duration_ = 8.4

		local var_44_0 = {
			zh = 8.4,
			ja = 7.866
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play325571012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["10167ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos10167ui_story = var_47_0.localPosition

				local var_47_2 = GameObjectTools.GetOrAddComponent(var_47_0.gameObject, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(false)
				end
			end

			local var_47_3 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_3 then
				local var_47_4 = (arg_44_1.time_ - var_47_1) / var_47_3
				local var_47_5 = Vector3.New(-0.96, -1.28, -5.73)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10167ui_story, var_47_5, var_47_4)

				local var_47_6 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_6.x, var_47_6.y, var_47_6.z)

				local var_47_7 = var_47_0.localEulerAngles

				var_47_7.z = 0
				var_47_7.x = 0
				var_47_0.localEulerAngles = var_47_7
			end

			if arg_44_1.time_ >= var_47_1 + var_47_3 and arg_44_1.time_ < var_47_1 + var_47_3 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(-0.96, -1.28, -5.73)

				local var_47_8 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_8.x, var_47_8.y, var_47_8.z)

				local var_47_9 = var_47_0.localEulerAngles

				var_47_9.z = 0
				var_47_9.x = 0
				var_47_0.localEulerAngles = var_47_9

				local var_47_10 = GameObjectTools.GetOrAddComponent(var_47_0.gameObject, typeof(DynamicBoneHelper))

				if var_47_10 then
					var_47_10:EnableDynamicBone(true)
				end
			end

			local var_47_11 = arg_44_1.actors_["10176ui_story"].transform
			local var_47_12 = 0

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.var_.moveOldPos10176ui_story = var_47_11.localPosition

				local var_47_13 = GameObjectTools.GetOrAddComponent(var_47_11.gameObject, typeof(DynamicBoneHelper))

				if var_47_13 then
					var_47_13:EnableDynamicBone(false)
				end
			end

			local var_47_14 = 0.001

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_14 then
				local var_47_15 = (arg_44_1.time_ - var_47_12) / var_47_14
				local var_47_16 = Vector3.New(0.79, -1.09, -6.12)

				var_47_11.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10176ui_story, var_47_16, var_47_15)

				local var_47_17 = manager.ui.mainCamera.transform.position - var_47_11.position

				var_47_11.forward = Vector3.New(var_47_17.x, var_47_17.y, var_47_17.z)

				local var_47_18 = var_47_11.localEulerAngles

				var_47_18.z = 0
				var_47_18.x = 0
				var_47_11.localEulerAngles = var_47_18
			end

			if arg_44_1.time_ >= var_47_12 + var_47_14 and arg_44_1.time_ < var_47_12 + var_47_14 + arg_47_0 then
				var_47_11.localPosition = Vector3.New(0.79, -1.09, -6.12)

				local var_47_19 = manager.ui.mainCamera.transform.position - var_47_11.position

				var_47_11.forward = Vector3.New(var_47_19.x, var_47_19.y, var_47_19.z)

				local var_47_20 = var_47_11.localEulerAngles

				var_47_20.z = 0
				var_47_20.x = 0
				var_47_11.localEulerAngles = var_47_20

				local var_47_21 = GameObjectTools.GetOrAddComponent(var_47_11.gameObject, typeof(DynamicBoneHelper))

				if var_47_21 then
					var_47_21:EnableDynamicBone(true)
				end
			end

			local var_47_22 = arg_44_1.actors_["10176ui_story"]
			local var_47_23 = 0

			if var_47_23 < arg_44_1.time_ and arg_44_1.time_ <= var_47_23 + arg_47_0 and not isNil(var_47_22) and arg_44_1.var_.characterEffect10176ui_story == nil then
				arg_44_1.var_.characterEffect10176ui_story = var_47_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_24 = 0.200000002980232

			if var_47_23 <= arg_44_1.time_ and arg_44_1.time_ < var_47_23 + var_47_24 and not isNil(var_47_22) then
				local var_47_25 = (arg_44_1.time_ - var_47_23) / var_47_24

				if arg_44_1.var_.characterEffect10176ui_story and not isNil(var_47_22) then
					arg_44_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_23 + var_47_24 and arg_44_1.time_ < var_47_23 + var_47_24 + arg_47_0 and not isNil(var_47_22) and arg_44_1.var_.characterEffect10176ui_story then
				arg_44_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_47_26 = arg_44_1.actors_["10167ui_story"]
			local var_47_27 = 0

			if var_47_27 < arg_44_1.time_ and arg_44_1.time_ <= var_47_27 + arg_47_0 and not isNil(var_47_26) and arg_44_1.var_.characterEffect10167ui_story == nil then
				arg_44_1.var_.characterEffect10167ui_story = var_47_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_28 = 0.200000002980232

			if var_47_27 <= arg_44_1.time_ and arg_44_1.time_ < var_47_27 + var_47_28 and not isNil(var_47_26) then
				local var_47_29 = (arg_44_1.time_ - var_47_27) / var_47_28

				if arg_44_1.var_.characterEffect10167ui_story and not isNil(var_47_26) then
					local var_47_30 = Mathf.Lerp(0, 0.5, var_47_29)

					arg_44_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_44_1.var_.characterEffect10167ui_story.fillRatio = var_47_30
				end
			end

			if arg_44_1.time_ >= var_47_27 + var_47_28 and arg_44_1.time_ < var_47_27 + var_47_28 + arg_47_0 and not isNil(var_47_26) and arg_44_1.var_.characterEffect10167ui_story then
				local var_47_31 = 0.5

				arg_44_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_44_1.var_.characterEffect10167ui_story.fillRatio = var_47_31
			end

			local var_47_32 = 0
			local var_47_33 = 0.65

			if var_47_32 < arg_44_1.time_ and arg_44_1.time_ <= var_47_32 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_34 = arg_44_1:FormatText(StoryNameCfg[1510].name)

				arg_44_1.leftNameTxt_.text = var_47_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_35 = arg_44_1:GetWordFromCfg(325571011)
				local var_47_36 = arg_44_1:FormatText(var_47_35.content)

				arg_44_1.text_.text = var_47_36

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_37 = 26
				local var_47_38 = utf8.len(var_47_36)
				local var_47_39 = var_47_37 <= 0 and var_47_33 or var_47_33 * (var_47_38 / var_47_37)

				if var_47_39 > 0 and var_47_33 < var_47_39 then
					arg_44_1.talkMaxDuration = var_47_39

					if var_47_39 + var_47_32 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_39 + var_47_32
					end
				end

				arg_44_1.text_.text = var_47_36
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571011", "story_v_out_325571.awb") ~= 0 then
					local var_47_40 = manager.audio:GetVoiceLength("story_v_out_325571", "325571011", "story_v_out_325571.awb") / 1000

					if var_47_40 + var_47_32 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_40 + var_47_32
					end

					if var_47_35.prefab_name ~= "" and arg_44_1.actors_[var_47_35.prefab_name] ~= nil then
						local var_47_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_35.prefab_name].transform, "story_v_out_325571", "325571011", "story_v_out_325571.awb")

						arg_44_1:RecordAudio("325571011", var_47_41)
						arg_44_1:RecordAudio("325571011", var_47_41)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325571", "325571011", "story_v_out_325571.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325571", "325571011", "story_v_out_325571.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_42 = math.max(var_47_33, arg_44_1.talkMaxDuration)

			if var_47_32 <= arg_44_1.time_ and arg_44_1.time_ < var_47_32 + var_47_42 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_32) / var_47_42

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_32 + var_47_42 and arg_44_1.time_ < var_47_32 + var_47_42 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play325571012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325571012
		arg_48_1.duration_ = 8.77

		local var_48_0 = {
			zh = 7.8,
			ja = 8.766
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play325571013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10167ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10167ui_story == nil then
				arg_48_1.var_.characterEffect10167ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect10167ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10167ui_story then
				arg_48_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["10176ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect10176ui_story == nil then
				arg_48_1.var_.characterEffect10176ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.200000002980232

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect10176ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10176ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect10176ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10176ui_story.fillRatio = var_51_9
			end

			local var_51_10 = 0
			local var_51_11 = 0.775

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_12 = arg_48_1:FormatText(StoryNameCfg[1447].name)

				arg_48_1.leftNameTxt_.text = var_51_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_13 = arg_48_1:GetWordFromCfg(325571012)
				local var_51_14 = arg_48_1:FormatText(var_51_13.content)

				arg_48_1.text_.text = var_51_14

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_15 = 31
				local var_51_16 = utf8.len(var_51_14)
				local var_51_17 = var_51_15 <= 0 and var_51_11 or var_51_11 * (var_51_16 / var_51_15)

				if var_51_17 > 0 and var_51_11 < var_51_17 then
					arg_48_1.talkMaxDuration = var_51_17

					if var_51_17 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_17 + var_51_10
					end
				end

				arg_48_1.text_.text = var_51_14
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571012", "story_v_out_325571.awb") ~= 0 then
					local var_51_18 = manager.audio:GetVoiceLength("story_v_out_325571", "325571012", "story_v_out_325571.awb") / 1000

					if var_51_18 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_18 + var_51_10
					end

					if var_51_13.prefab_name ~= "" and arg_48_1.actors_[var_51_13.prefab_name] ~= nil then
						local var_51_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_13.prefab_name].transform, "story_v_out_325571", "325571012", "story_v_out_325571.awb")

						arg_48_1:RecordAudio("325571012", var_51_19)
						arg_48_1:RecordAudio("325571012", var_51_19)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325571", "325571012", "story_v_out_325571.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325571", "325571012", "story_v_out_325571.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_20 = math.max(var_51_11, arg_48_1.talkMaxDuration)

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_20 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_10) / var_51_20

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_10 + var_51_20 and arg_48_1.time_ < var_51_10 + var_51_20 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play325571013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325571013
		arg_52_1.duration_ = 6.37

		local var_52_0 = {
			zh = 6.366,
			ja = 5.633
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play325571015(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10176ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10176ui_story == nil then
				arg_52_1.var_.characterEffect10176ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect10176ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10176ui_story then
				arg_52_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["10167ui_story"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect10167ui_story == nil then
				arg_52_1.var_.characterEffect10167ui_story = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.200000002980232

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect10167ui_story and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_52_1.var_.characterEffect10167ui_story.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect10167ui_story then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_52_1.var_.characterEffect10167ui_story.fillRatio = var_55_9
			end

			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action4_2")
			end

			local var_55_11 = 0

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_55_12 = 0
			local var_55_13 = 0.575

			if var_55_12 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_14 = arg_52_1:FormatText(StoryNameCfg[1510].name)

				arg_52_1.leftNameTxt_.text = var_55_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_15 = arg_52_1:GetWordFromCfg(325571013)
				local var_55_16 = arg_52_1:FormatText(var_55_15.content)

				arg_52_1.text_.text = var_55_16

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_17 = 23
				local var_55_18 = utf8.len(var_55_16)
				local var_55_19 = var_55_17 <= 0 and var_55_13 or var_55_13 * (var_55_18 / var_55_17)

				if var_55_19 > 0 and var_55_13 < var_55_19 then
					arg_52_1.talkMaxDuration = var_55_19

					if var_55_19 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_19 + var_55_12
					end
				end

				arg_52_1.text_.text = var_55_16
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571013", "story_v_out_325571.awb") ~= 0 then
					local var_55_20 = manager.audio:GetVoiceLength("story_v_out_325571", "325571013", "story_v_out_325571.awb") / 1000

					if var_55_20 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_20 + var_55_12
					end

					if var_55_15.prefab_name ~= "" and arg_52_1.actors_[var_55_15.prefab_name] ~= nil then
						local var_55_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_15.prefab_name].transform, "story_v_out_325571", "325571013", "story_v_out_325571.awb")

						arg_52_1:RecordAudio("325571013", var_55_21)
						arg_52_1:RecordAudio("325571013", var_55_21)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_325571", "325571013", "story_v_out_325571.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_325571", "325571013", "story_v_out_325571.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_22 = math.max(var_55_13, arg_52_1.talkMaxDuration)

			if var_55_12 <= arg_52_1.time_ and arg_52_1.time_ < var_55_12 + var_55_22 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_12) / var_55_22

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_12 + var_55_22 and arg_52_1.time_ < var_55_12 + var_55_22 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play325571015 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325571015
		arg_56_1.duration_ = 5.7

		local var_56_0 = {
			zh = 4.9,
			ja = 5.7
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
				arg_56_0:Play325571016(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10176ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos10176ui_story = var_59_0.localPosition

				local var_59_2 = GameObjectTools.GetOrAddComponent(var_59_0.gameObject, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(false)
				end
			end

			local var_59_3 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_3 then
				local var_59_4 = (arg_56_1.time_ - var_59_1) / var_59_3
				local var_59_5 = Vector3.New(0, 100, 0)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10176ui_story, var_59_5, var_59_4)

				local var_59_6 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_6.x, var_59_6.y, var_59_6.z)

				local var_59_7 = var_59_0.localEulerAngles

				var_59_7.z = 0
				var_59_7.x = 0
				var_59_0.localEulerAngles = var_59_7
			end

			if arg_56_1.time_ >= var_59_1 + var_59_3 and arg_56_1.time_ < var_59_1 + var_59_3 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_59_11 = arg_56_1.actors_["10175ui_story"].transform
			local var_59_12 = 0

			if var_59_12 < arg_56_1.time_ and arg_56_1.time_ <= var_59_12 + arg_59_0 then
				arg_56_1.var_.moveOldPos10175ui_story = var_59_11.localPosition

				local var_59_13 = GameObjectTools.GetOrAddComponent(var_59_11.gameObject, typeof(DynamicBoneHelper))

				if var_59_13 then
					var_59_13:EnableDynamicBone(false)
				end
			end

			local var_59_14 = 0.001

			if var_59_12 <= arg_56_1.time_ and arg_56_1.time_ < var_59_12 + var_59_14 then
				local var_59_15 = (arg_56_1.time_ - var_59_12) / var_59_14
				local var_59_16 = Vector3.New(0.7, -1, -6.05)

				var_59_11.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10175ui_story, var_59_16, var_59_15)

				local var_59_17 = manager.ui.mainCamera.transform.position - var_59_11.position

				var_59_11.forward = Vector3.New(var_59_17.x, var_59_17.y, var_59_17.z)

				local var_59_18 = var_59_11.localEulerAngles

				var_59_18.z = 0
				var_59_18.x = 0
				var_59_11.localEulerAngles = var_59_18
			end

			if arg_56_1.time_ >= var_59_12 + var_59_14 and arg_56_1.time_ < var_59_12 + var_59_14 + arg_59_0 then
				var_59_11.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_59_19 = manager.ui.mainCamera.transform.position - var_59_11.position

				var_59_11.forward = Vector3.New(var_59_19.x, var_59_19.y, var_59_19.z)

				local var_59_20 = var_59_11.localEulerAngles

				var_59_20.z = 0
				var_59_20.x = 0
				var_59_11.localEulerAngles = var_59_20

				local var_59_21 = GameObjectTools.GetOrAddComponent(var_59_11.gameObject, typeof(DynamicBoneHelper))

				if var_59_21 then
					var_59_21:EnableDynamicBone(true)
				end
			end

			local var_59_22 = arg_56_1.actors_["10175ui_story"]
			local var_59_23 = 0

			if var_59_23 < arg_56_1.time_ and arg_56_1.time_ <= var_59_23 + arg_59_0 and not isNil(var_59_22) and arg_56_1.var_.characterEffect10175ui_story == nil then
				arg_56_1.var_.characterEffect10175ui_story = var_59_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_24 = 0.200000002980232

			if var_59_23 <= arg_56_1.time_ and arg_56_1.time_ < var_59_23 + var_59_24 and not isNil(var_59_22) then
				local var_59_25 = (arg_56_1.time_ - var_59_23) / var_59_24

				if arg_56_1.var_.characterEffect10175ui_story and not isNil(var_59_22) then
					arg_56_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_23 + var_59_24 and arg_56_1.time_ < var_59_23 + var_59_24 + arg_59_0 and not isNil(var_59_22) and arg_56_1.var_.characterEffect10175ui_story then
				arg_56_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_59_26 = arg_56_1.actors_["10176ui_story"]
			local var_59_27 = 0

			if var_59_27 < arg_56_1.time_ and arg_56_1.time_ <= var_59_27 + arg_59_0 and not isNil(var_59_26) and arg_56_1.var_.characterEffect10176ui_story == nil then
				arg_56_1.var_.characterEffect10176ui_story = var_59_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_28 = 0.200000002980232

			if var_59_27 <= arg_56_1.time_ and arg_56_1.time_ < var_59_27 + var_59_28 and not isNil(var_59_26) then
				local var_59_29 = (arg_56_1.time_ - var_59_27) / var_59_28

				if arg_56_1.var_.characterEffect10176ui_story and not isNil(var_59_26) then
					local var_59_30 = Mathf.Lerp(0, 0.5, var_59_29)

					arg_56_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10176ui_story.fillRatio = var_59_30
				end
			end

			if arg_56_1.time_ >= var_59_27 + var_59_28 and arg_56_1.time_ < var_59_27 + var_59_28 + arg_59_0 and not isNil(var_59_26) and arg_56_1.var_.characterEffect10176ui_story then
				local var_59_31 = 0.5

				arg_56_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10176ui_story.fillRatio = var_59_31
			end

			local var_59_32 = 0

			if var_59_32 < arg_56_1.time_ and arg_56_1.time_ <= var_59_32 + arg_59_0 then
				arg_56_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_1")
			end

			local var_59_33 = 0

			if var_59_33 < arg_56_1.time_ and arg_56_1.time_ <= var_59_33 + arg_59_0 then
				arg_56_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_59_34 = 0
			local var_59_35 = 0.55

			if var_59_34 < arg_56_1.time_ and arg_56_1.time_ <= var_59_34 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_36 = arg_56_1:FormatText(StoryNameCfg[1473].name)

				arg_56_1.leftNameTxt_.text = var_59_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_37 = arg_56_1:GetWordFromCfg(325571015)
				local var_59_38 = arg_56_1:FormatText(var_59_37.content)

				arg_56_1.text_.text = var_59_38

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_39 = 22
				local var_59_40 = utf8.len(var_59_38)
				local var_59_41 = var_59_39 <= 0 and var_59_35 or var_59_35 * (var_59_40 / var_59_39)

				if var_59_41 > 0 and var_59_35 < var_59_41 then
					arg_56_1.talkMaxDuration = var_59_41

					if var_59_41 + var_59_34 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_41 + var_59_34
					end
				end

				arg_56_1.text_.text = var_59_38
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571015", "story_v_out_325571.awb") ~= 0 then
					local var_59_42 = manager.audio:GetVoiceLength("story_v_out_325571", "325571015", "story_v_out_325571.awb") / 1000

					if var_59_42 + var_59_34 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_42 + var_59_34
					end

					if var_59_37.prefab_name ~= "" and arg_56_1.actors_[var_59_37.prefab_name] ~= nil then
						local var_59_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_37.prefab_name].transform, "story_v_out_325571", "325571015", "story_v_out_325571.awb")

						arg_56_1:RecordAudio("325571015", var_59_43)
						arg_56_1:RecordAudio("325571015", var_59_43)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325571", "325571015", "story_v_out_325571.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325571", "325571015", "story_v_out_325571.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_44 = math.max(var_59_35, arg_56_1.talkMaxDuration)

			if var_59_34 <= arg_56_1.time_ and arg_56_1.time_ < var_59_34 + var_59_44 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_34) / var_59_44

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_34 + var_59_44 and arg_56_1.time_ < var_59_34 + var_59_44 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
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
	Play325571016 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325571016
		arg_60_1.duration_ = 6.9

		local var_60_0 = {
			zh = 6,
			ja = 6.9
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
				arg_60_0:Play325571017(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.75

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[1473].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_3 = arg_60_1:GetWordFromCfg(325571016)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 30
				local var_63_6 = utf8.len(var_63_4)
				local var_63_7 = var_63_5 <= 0 and var_63_1 or var_63_1 * (var_63_6 / var_63_5)

				if var_63_7 > 0 and var_63_1 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571016", "story_v_out_325571.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_325571", "325571016", "story_v_out_325571.awb") / 1000

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_325571", "325571016", "story_v_out_325571.awb")

						arg_60_1:RecordAudio("325571016", var_63_9)
						arg_60_1:RecordAudio("325571016", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325571", "325571016", "story_v_out_325571.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325571", "325571016", "story_v_out_325571.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_10 and arg_60_1.time_ < var_63_0 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play325571017 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325571017
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play325571018(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10175ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10175ui_story == nil then
				arg_64_1.var_.characterEffect10175ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect10175ui_story and not isNil(var_67_0) then
					local var_67_4 = Mathf.Lerp(0, 0.5, var_67_3)

					arg_64_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10175ui_story.fillRatio = var_67_4
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10175ui_story then
				local var_67_5 = 0.5

				arg_64_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10175ui_story.fillRatio = var_67_5
			end

			local var_67_6 = 0
			local var_67_7 = 1.375

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_8 = arg_64_1:GetWordFromCfg(325571017)
				local var_67_9 = arg_64_1:FormatText(var_67_8.content)

				arg_64_1.text_.text = var_67_9

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_10 = 55
				local var_67_11 = utf8.len(var_67_9)
				local var_67_12 = var_67_10 <= 0 and var_67_7 or var_67_7 * (var_67_11 / var_67_10)

				if var_67_12 > 0 and var_67_7 < var_67_12 then
					arg_64_1.talkMaxDuration = var_67_12

					if var_67_12 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_12 + var_67_6
					end
				end

				arg_64_1.text_.text = var_67_9
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_13 = math.max(var_67_7, arg_64_1.talkMaxDuration)

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_13 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_6) / var_67_13

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_6 + var_67_13 and arg_64_1.time_ < var_67_6 + var_67_13 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play325571018 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325571018
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play325571019(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 1.05

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_2 = arg_68_1:GetWordFromCfg(325571018)
				local var_71_3 = arg_68_1:FormatText(var_71_2.content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 42
				local var_71_5 = utf8.len(var_71_3)
				local var_71_6 = var_71_4 <= 0 and var_71_1 or var_71_1 * (var_71_5 / var_71_4)

				if var_71_6 > 0 and var_71_1 < var_71_6 then
					arg_68_1.talkMaxDuration = var_71_6

					if var_71_6 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_7 and arg_68_1.time_ < var_71_0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play325571019 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325571019
		arg_72_1.duration_ = 7.67

		local var_72_0 = {
			zh = 7.666,
			ja = 4.533
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play325571020(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["10175ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos10175ui_story = var_75_0.localPosition

				local var_75_2 = GameObjectTools.GetOrAddComponent(var_75_0.gameObject, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(false)
				end
			end

			local var_75_3 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_3 then
				local var_75_4 = (arg_72_1.time_ - var_75_1) / var_75_3
				local var_75_5 = Vector3.New(0, 100, 0)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10175ui_story, var_75_5, var_75_4)

				local var_75_6 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_6.x, var_75_6.y, var_75_6.z)

				local var_75_7 = var_75_0.localEulerAngles

				var_75_7.z = 0
				var_75_7.x = 0
				var_75_0.localEulerAngles = var_75_7
			end

			if arg_72_1.time_ >= var_75_1 + var_75_3 and arg_72_1.time_ < var_75_1 + var_75_3 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(0, 100, 0)

				local var_75_8 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_8.x, var_75_8.y, var_75_8.z)

				local var_75_9 = var_75_0.localEulerAngles

				var_75_9.z = 0
				var_75_9.x = 0
				var_75_0.localEulerAngles = var_75_9

				local var_75_10 = GameObjectTools.GetOrAddComponent(var_75_0.gameObject, typeof(DynamicBoneHelper))

				if var_75_10 then
					var_75_10:EnableDynamicBone(true)
				end
			end

			local var_75_11 = arg_72_1.actors_["10176ui_story"].transform
			local var_75_12 = 0

			if var_75_12 < arg_72_1.time_ and arg_72_1.time_ <= var_75_12 + arg_75_0 then
				arg_72_1.var_.moveOldPos10176ui_story = var_75_11.localPosition

				local var_75_13 = GameObjectTools.GetOrAddComponent(var_75_11.gameObject, typeof(DynamicBoneHelper))

				if var_75_13 then
					var_75_13:EnableDynamicBone(false)
				end
			end

			local var_75_14 = 0.001

			if var_75_12 <= arg_72_1.time_ and arg_72_1.time_ < var_75_12 + var_75_14 then
				local var_75_15 = (arg_72_1.time_ - var_75_12) / var_75_14
				local var_75_16 = Vector3.New(0.79, -1.09, -6.12)

				var_75_11.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10176ui_story, var_75_16, var_75_15)

				local var_75_17 = manager.ui.mainCamera.transform.position - var_75_11.position

				var_75_11.forward = Vector3.New(var_75_17.x, var_75_17.y, var_75_17.z)

				local var_75_18 = var_75_11.localEulerAngles

				var_75_18.z = 0
				var_75_18.x = 0
				var_75_11.localEulerAngles = var_75_18
			end

			if arg_72_1.time_ >= var_75_12 + var_75_14 and arg_72_1.time_ < var_75_12 + var_75_14 + arg_75_0 then
				var_75_11.localPosition = Vector3.New(0.79, -1.09, -6.12)

				local var_75_19 = manager.ui.mainCamera.transform.position - var_75_11.position

				var_75_11.forward = Vector3.New(var_75_19.x, var_75_19.y, var_75_19.z)

				local var_75_20 = var_75_11.localEulerAngles

				var_75_20.z = 0
				var_75_20.x = 0
				var_75_11.localEulerAngles = var_75_20

				local var_75_21 = GameObjectTools.GetOrAddComponent(var_75_11.gameObject, typeof(DynamicBoneHelper))

				if var_75_21 then
					var_75_21:EnableDynamicBone(true)
				end
			end

			local var_75_22 = arg_72_1.actors_["10176ui_story"]
			local var_75_23 = 0

			if var_75_23 < arg_72_1.time_ and arg_72_1.time_ <= var_75_23 + arg_75_0 and not isNil(var_75_22) and arg_72_1.var_.characterEffect10176ui_story == nil then
				arg_72_1.var_.characterEffect10176ui_story = var_75_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_24 = 0.200000002980232

			if var_75_23 <= arg_72_1.time_ and arg_72_1.time_ < var_75_23 + var_75_24 and not isNil(var_75_22) then
				local var_75_25 = (arg_72_1.time_ - var_75_23) / var_75_24

				if arg_72_1.var_.characterEffect10176ui_story and not isNil(var_75_22) then
					arg_72_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_23 + var_75_24 and arg_72_1.time_ < var_75_23 + var_75_24 + arg_75_0 and not isNil(var_75_22) and arg_72_1.var_.characterEffect10176ui_story then
				arg_72_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_75_26 = 0

			if var_75_26 < arg_72_1.time_ and arg_72_1.time_ <= var_75_26 + arg_75_0 then
				arg_72_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action1_1")
			end

			local var_75_27 = 0

			if var_75_27 < arg_72_1.time_ and arg_72_1.time_ <= var_75_27 + arg_75_0 then
				arg_72_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_75_28 = 0
			local var_75_29 = 0.55

			if var_75_28 < arg_72_1.time_ and arg_72_1.time_ <= var_75_28 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_30 = arg_72_1:FormatText(StoryNameCfg[1510].name)

				arg_72_1.leftNameTxt_.text = var_75_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_31 = arg_72_1:GetWordFromCfg(325571019)
				local var_75_32 = arg_72_1:FormatText(var_75_31.content)

				arg_72_1.text_.text = var_75_32

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_33 = 22
				local var_75_34 = utf8.len(var_75_32)
				local var_75_35 = var_75_33 <= 0 and var_75_29 or var_75_29 * (var_75_34 / var_75_33)

				if var_75_35 > 0 and var_75_29 < var_75_35 then
					arg_72_1.talkMaxDuration = var_75_35

					if var_75_35 + var_75_28 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_35 + var_75_28
					end
				end

				arg_72_1.text_.text = var_75_32
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571019", "story_v_out_325571.awb") ~= 0 then
					local var_75_36 = manager.audio:GetVoiceLength("story_v_out_325571", "325571019", "story_v_out_325571.awb") / 1000

					if var_75_36 + var_75_28 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_36 + var_75_28
					end

					if var_75_31.prefab_name ~= "" and arg_72_1.actors_[var_75_31.prefab_name] ~= nil then
						local var_75_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_31.prefab_name].transform, "story_v_out_325571", "325571019", "story_v_out_325571.awb")

						arg_72_1:RecordAudio("325571019", var_75_37)
						arg_72_1:RecordAudio("325571019", var_75_37)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_325571", "325571019", "story_v_out_325571.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_325571", "325571019", "story_v_out_325571.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_38 = math.max(var_75_29, arg_72_1.talkMaxDuration)

			if var_75_28 <= arg_72_1.time_ and arg_72_1.time_ < var_75_28 + var_75_38 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_28) / var_75_38

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_28 + var_75_38 and arg_72_1.time_ < var_75_28 + var_75_38 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play325571020 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325571020
		arg_76_1.duration_ = 4.57

		local var_76_0 = {
			zh = 4.466,
			ja = 4.566
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play325571021(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.475

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_2 = arg_76_1:FormatText(StoryNameCfg[1510].name)

				arg_76_1.leftNameTxt_.text = var_79_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_3 = arg_76_1:GetWordFromCfg(325571020)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 19
				local var_79_6 = utf8.len(var_79_4)
				local var_79_7 = var_79_5 <= 0 and var_79_1 or var_79_1 * (var_79_6 / var_79_5)

				if var_79_7 > 0 and var_79_1 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571020", "story_v_out_325571.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_out_325571", "325571020", "story_v_out_325571.awb") / 1000

					if var_79_8 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_0
					end

					if var_79_3.prefab_name ~= "" and arg_76_1.actors_[var_79_3.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_3.prefab_name].transform, "story_v_out_325571", "325571020", "story_v_out_325571.awb")

						arg_76_1:RecordAudio("325571020", var_79_9)
						arg_76_1:RecordAudio("325571020", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_325571", "325571020", "story_v_out_325571.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_325571", "325571020", "story_v_out_325571.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_10 and arg_76_1.time_ < var_79_0 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play325571021 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325571021
		arg_80_1.duration_ = 6.57

		local var_80_0 = {
			zh = 4.933,
			ja = 6.566
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play325571022(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["10167ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect10167ui_story == nil then
				arg_80_1.var_.characterEffect10167ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect10167ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect10167ui_story then
				arg_80_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_83_4 = arg_80_1.actors_["10176ui_story"]
			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect10176ui_story == nil then
				arg_80_1.var_.characterEffect10176ui_story = var_83_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_6 = 0.200000002980232

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_6 and not isNil(var_83_4) then
				local var_83_7 = (arg_80_1.time_ - var_83_5) / var_83_6

				if arg_80_1.var_.characterEffect10176ui_story and not isNil(var_83_4) then
					local var_83_8 = Mathf.Lerp(0, 0.5, var_83_7)

					arg_80_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_80_1.var_.characterEffect10176ui_story.fillRatio = var_83_8
				end
			end

			if arg_80_1.time_ >= var_83_5 + var_83_6 and arg_80_1.time_ < var_83_5 + var_83_6 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect10176ui_story then
				local var_83_9 = 0.5

				arg_80_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_80_1.var_.characterEffect10176ui_story.fillRatio = var_83_9
			end

			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_2")
			end

			local var_83_11 = 0

			if var_83_11 < arg_80_1.time_ and arg_80_1.time_ <= var_83_11 + arg_83_0 then
				arg_80_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_83_12 = 0
			local var_83_13 = 0.55

			if var_83_12 < arg_80_1.time_ and arg_80_1.time_ <= var_83_12 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_14 = arg_80_1:FormatText(StoryNameCfg[1447].name)

				arg_80_1.leftNameTxt_.text = var_83_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_15 = arg_80_1:GetWordFromCfg(325571021)
				local var_83_16 = arg_80_1:FormatText(var_83_15.content)

				arg_80_1.text_.text = var_83_16

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_17 = 22
				local var_83_18 = utf8.len(var_83_16)
				local var_83_19 = var_83_17 <= 0 and var_83_13 or var_83_13 * (var_83_18 / var_83_17)

				if var_83_19 > 0 and var_83_13 < var_83_19 then
					arg_80_1.talkMaxDuration = var_83_19

					if var_83_19 + var_83_12 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_19 + var_83_12
					end
				end

				arg_80_1.text_.text = var_83_16
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571021", "story_v_out_325571.awb") ~= 0 then
					local var_83_20 = manager.audio:GetVoiceLength("story_v_out_325571", "325571021", "story_v_out_325571.awb") / 1000

					if var_83_20 + var_83_12 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_20 + var_83_12
					end

					if var_83_15.prefab_name ~= "" and arg_80_1.actors_[var_83_15.prefab_name] ~= nil then
						local var_83_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_15.prefab_name].transform, "story_v_out_325571", "325571021", "story_v_out_325571.awb")

						arg_80_1:RecordAudio("325571021", var_83_21)
						arg_80_1:RecordAudio("325571021", var_83_21)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_325571", "325571021", "story_v_out_325571.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_325571", "325571021", "story_v_out_325571.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_22 = math.max(var_83_13, arg_80_1.talkMaxDuration)

			if var_83_12 <= arg_80_1.time_ and arg_80_1.time_ < var_83_12 + var_83_22 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_12) / var_83_22

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_12 + var_83_22 and arg_80_1.time_ < var_83_12 + var_83_22 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play325571022 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 325571022
		arg_84_1.duration_ = 4.67

		local var_84_0 = {
			zh = 4.666,
			ja = 4.266
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play325571023(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["10176ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect10176ui_story == nil then
				arg_84_1.var_.characterEffect10176ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect10176ui_story and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect10176ui_story then
				arg_84_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_87_4 = arg_84_1.actors_["10167ui_story"]
			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect10167ui_story == nil then
				arg_84_1.var_.characterEffect10167ui_story = var_87_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_6 = 0.200000002980232

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_6 and not isNil(var_87_4) then
				local var_87_7 = (arg_84_1.time_ - var_87_5) / var_87_6

				if arg_84_1.var_.characterEffect10167ui_story and not isNil(var_87_4) then
					local var_87_8 = Mathf.Lerp(0, 0.5, var_87_7)

					arg_84_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_84_1.var_.characterEffect10167ui_story.fillRatio = var_87_8
				end
			end

			if arg_84_1.time_ >= var_87_5 + var_87_6 and arg_84_1.time_ < var_87_5 + var_87_6 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect10167ui_story then
				local var_87_9 = 0.5

				arg_84_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_84_1.var_.characterEffect10167ui_story.fillRatio = var_87_9
			end

			local var_87_10 = 0

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 then
				arg_84_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action4_1")
			end

			local var_87_11 = 0

			if var_87_11 < arg_84_1.time_ and arg_84_1.time_ <= var_87_11 + arg_87_0 then
				arg_84_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_87_12 = 0
			local var_87_13 = 0.5

			if var_87_12 < arg_84_1.time_ and arg_84_1.time_ <= var_87_12 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_14 = arg_84_1:FormatText(StoryNameCfg[1510].name)

				arg_84_1.leftNameTxt_.text = var_87_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_15 = arg_84_1:GetWordFromCfg(325571022)
				local var_87_16 = arg_84_1:FormatText(var_87_15.content)

				arg_84_1.text_.text = var_87_16

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_17 = 20
				local var_87_18 = utf8.len(var_87_16)
				local var_87_19 = var_87_17 <= 0 and var_87_13 or var_87_13 * (var_87_18 / var_87_17)

				if var_87_19 > 0 and var_87_13 < var_87_19 then
					arg_84_1.talkMaxDuration = var_87_19

					if var_87_19 + var_87_12 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_19 + var_87_12
					end
				end

				arg_84_1.text_.text = var_87_16
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571022", "story_v_out_325571.awb") ~= 0 then
					local var_87_20 = manager.audio:GetVoiceLength("story_v_out_325571", "325571022", "story_v_out_325571.awb") / 1000

					if var_87_20 + var_87_12 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_20 + var_87_12
					end

					if var_87_15.prefab_name ~= "" and arg_84_1.actors_[var_87_15.prefab_name] ~= nil then
						local var_87_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_15.prefab_name].transform, "story_v_out_325571", "325571022", "story_v_out_325571.awb")

						arg_84_1:RecordAudio("325571022", var_87_21)
						arg_84_1:RecordAudio("325571022", var_87_21)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_325571", "325571022", "story_v_out_325571.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_325571", "325571022", "story_v_out_325571.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_22 = math.max(var_87_13, arg_84_1.talkMaxDuration)

			if var_87_12 <= arg_84_1.time_ and arg_84_1.time_ < var_87_12 + var_87_22 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_12) / var_87_22

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_12 + var_87_22 and arg_84_1.time_ < var_87_12 + var_87_22 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play325571023 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 325571023
		arg_88_1.duration_ = 10.03

		local var_88_0 = {
			zh = 7.033,
			ja = 10.033
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play325571024(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["10167ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect10167ui_story == nil then
				arg_88_1.var_.characterEffect10167ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect10167ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect10167ui_story then
				arg_88_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_91_4 = arg_88_1.actors_["10176ui_story"]
			local var_91_5 = 0

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect10176ui_story == nil then
				arg_88_1.var_.characterEffect10176ui_story = var_91_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_6 = 0.200000002980232

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_6 and not isNil(var_91_4) then
				local var_91_7 = (arg_88_1.time_ - var_91_5) / var_91_6

				if arg_88_1.var_.characterEffect10176ui_story and not isNil(var_91_4) then
					local var_91_8 = Mathf.Lerp(0, 0.5, var_91_7)

					arg_88_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_88_1.var_.characterEffect10176ui_story.fillRatio = var_91_8
				end
			end

			if arg_88_1.time_ >= var_91_5 + var_91_6 and arg_88_1.time_ < var_91_5 + var_91_6 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect10176ui_story then
				local var_91_9 = 0.5

				arg_88_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_88_1.var_.characterEffect10176ui_story.fillRatio = var_91_9
			end

			local var_91_10 = 0
			local var_91_11 = 0.825

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_12 = arg_88_1:FormatText(StoryNameCfg[1447].name)

				arg_88_1.leftNameTxt_.text = var_91_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_13 = arg_88_1:GetWordFromCfg(325571023)
				local var_91_14 = arg_88_1:FormatText(var_91_13.content)

				arg_88_1.text_.text = var_91_14

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_15 = 33
				local var_91_16 = utf8.len(var_91_14)
				local var_91_17 = var_91_15 <= 0 and var_91_11 or var_91_11 * (var_91_16 / var_91_15)

				if var_91_17 > 0 and var_91_11 < var_91_17 then
					arg_88_1.talkMaxDuration = var_91_17

					if var_91_17 + var_91_10 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_17 + var_91_10
					end
				end

				arg_88_1.text_.text = var_91_14
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571023", "story_v_out_325571.awb") ~= 0 then
					local var_91_18 = manager.audio:GetVoiceLength("story_v_out_325571", "325571023", "story_v_out_325571.awb") / 1000

					if var_91_18 + var_91_10 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_18 + var_91_10
					end

					if var_91_13.prefab_name ~= "" and arg_88_1.actors_[var_91_13.prefab_name] ~= nil then
						local var_91_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_13.prefab_name].transform, "story_v_out_325571", "325571023", "story_v_out_325571.awb")

						arg_88_1:RecordAudio("325571023", var_91_19)
						arg_88_1:RecordAudio("325571023", var_91_19)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_325571", "325571023", "story_v_out_325571.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_325571", "325571023", "story_v_out_325571.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_20 = math.max(var_91_11, arg_88_1.talkMaxDuration)

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_20 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_10) / var_91_20

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_10 + var_91_20 and arg_88_1.time_ < var_91_10 + var_91_20 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play325571024 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325571024
		arg_92_1.duration_ = 3

		local var_92_0 = {
			zh = 2.6,
			ja = 3
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
				arg_92_0:Play325571025(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["10176ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos10176ui_story = var_95_0.localPosition

				local var_95_2 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(false)
				end
			end

			local var_95_3 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_3 then
				local var_95_4 = (arg_92_1.time_ - var_95_1) / var_95_3
				local var_95_5 = Vector3.New(0, 100, 0)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10176ui_story, var_95_5, var_95_4)

				local var_95_6 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_6.x, var_95_6.y, var_95_6.z)

				local var_95_7 = var_95_0.localEulerAngles

				var_95_7.z = 0
				var_95_7.x = 0
				var_95_0.localEulerAngles = var_95_7
			end

			if arg_92_1.time_ >= var_95_1 + var_95_3 and arg_92_1.time_ < var_95_1 + var_95_3 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(0, 100, 0)

				local var_95_8 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_8.x, var_95_8.y, var_95_8.z)

				local var_95_9 = var_95_0.localEulerAngles

				var_95_9.z = 0
				var_95_9.x = 0
				var_95_0.localEulerAngles = var_95_9

				local var_95_10 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_10 then
					var_95_10:EnableDynamicBone(true)
				end
			end

			local var_95_11 = arg_92_1.actors_["10175ui_story"].transform
			local var_95_12 = 0

			if var_95_12 < arg_92_1.time_ and arg_92_1.time_ <= var_95_12 + arg_95_0 then
				arg_92_1.var_.moveOldPos10175ui_story = var_95_11.localPosition

				local var_95_13 = GameObjectTools.GetOrAddComponent(var_95_11.gameObject, typeof(DynamicBoneHelper))

				if var_95_13 then
					var_95_13:EnableDynamicBone(false)
				end
			end

			local var_95_14 = 0.001

			if var_95_12 <= arg_92_1.time_ and arg_92_1.time_ < var_95_12 + var_95_14 then
				local var_95_15 = (arg_92_1.time_ - var_95_12) / var_95_14
				local var_95_16 = Vector3.New(0.7, -1, -6.05)

				var_95_11.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10175ui_story, var_95_16, var_95_15)

				local var_95_17 = manager.ui.mainCamera.transform.position - var_95_11.position

				var_95_11.forward = Vector3.New(var_95_17.x, var_95_17.y, var_95_17.z)

				local var_95_18 = var_95_11.localEulerAngles

				var_95_18.z = 0
				var_95_18.x = 0
				var_95_11.localEulerAngles = var_95_18
			end

			if arg_92_1.time_ >= var_95_12 + var_95_14 and arg_92_1.time_ < var_95_12 + var_95_14 + arg_95_0 then
				var_95_11.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_95_19 = manager.ui.mainCamera.transform.position - var_95_11.position

				var_95_11.forward = Vector3.New(var_95_19.x, var_95_19.y, var_95_19.z)

				local var_95_20 = var_95_11.localEulerAngles

				var_95_20.z = 0
				var_95_20.x = 0
				var_95_11.localEulerAngles = var_95_20

				local var_95_21 = GameObjectTools.GetOrAddComponent(var_95_11.gameObject, typeof(DynamicBoneHelper))

				if var_95_21 then
					var_95_21:EnableDynamicBone(true)
				end
			end

			local var_95_22 = arg_92_1.actors_["10175ui_story"]
			local var_95_23 = 0

			if var_95_23 < arg_92_1.time_ and arg_92_1.time_ <= var_95_23 + arg_95_0 and not isNil(var_95_22) and arg_92_1.var_.characterEffect10175ui_story == nil then
				arg_92_1.var_.characterEffect10175ui_story = var_95_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_24 = 0.200000002980232

			if var_95_23 <= arg_92_1.time_ and arg_92_1.time_ < var_95_23 + var_95_24 and not isNil(var_95_22) then
				local var_95_25 = (arg_92_1.time_ - var_95_23) / var_95_24

				if arg_92_1.var_.characterEffect10175ui_story and not isNil(var_95_22) then
					arg_92_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_23 + var_95_24 and arg_92_1.time_ < var_95_23 + var_95_24 + arg_95_0 and not isNil(var_95_22) and arg_92_1.var_.characterEffect10175ui_story then
				arg_92_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_95_26 = arg_92_1.actors_["10167ui_story"]
			local var_95_27 = 0

			if var_95_27 < arg_92_1.time_ and arg_92_1.time_ <= var_95_27 + arg_95_0 and not isNil(var_95_26) and arg_92_1.var_.characterEffect10167ui_story == nil then
				arg_92_1.var_.characterEffect10167ui_story = var_95_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_28 = 0.200000002980232

			if var_95_27 <= arg_92_1.time_ and arg_92_1.time_ < var_95_27 + var_95_28 and not isNil(var_95_26) then
				local var_95_29 = (arg_92_1.time_ - var_95_27) / var_95_28

				if arg_92_1.var_.characterEffect10167ui_story and not isNil(var_95_26) then
					local var_95_30 = Mathf.Lerp(0, 0.5, var_95_29)

					arg_92_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_92_1.var_.characterEffect10167ui_story.fillRatio = var_95_30
				end
			end

			if arg_92_1.time_ >= var_95_27 + var_95_28 and arg_92_1.time_ < var_95_27 + var_95_28 + arg_95_0 and not isNil(var_95_26) and arg_92_1.var_.characterEffect10167ui_story then
				local var_95_31 = 0.5

				arg_92_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_92_1.var_.characterEffect10167ui_story.fillRatio = var_95_31
			end

			local var_95_32 = 0

			if var_95_32 < arg_92_1.time_ and arg_92_1.time_ <= var_95_32 + arg_95_0 then
				arg_92_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			local var_95_33 = 0

			if var_95_33 < arg_92_1.time_ and arg_92_1.time_ <= var_95_33 + arg_95_0 then
				arg_92_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_95_34 = 0
			local var_95_35 = 0.25

			if var_95_34 < arg_92_1.time_ and arg_92_1.time_ <= var_95_34 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_36 = arg_92_1:FormatText(StoryNameCfg[1473].name)

				arg_92_1.leftNameTxt_.text = var_95_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_37 = arg_92_1:GetWordFromCfg(325571024)
				local var_95_38 = arg_92_1:FormatText(var_95_37.content)

				arg_92_1.text_.text = var_95_38

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_39 = 10
				local var_95_40 = utf8.len(var_95_38)
				local var_95_41 = var_95_39 <= 0 and var_95_35 or var_95_35 * (var_95_40 / var_95_39)

				if var_95_41 > 0 and var_95_35 < var_95_41 then
					arg_92_1.talkMaxDuration = var_95_41

					if var_95_41 + var_95_34 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_41 + var_95_34
					end
				end

				arg_92_1.text_.text = var_95_38
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571024", "story_v_out_325571.awb") ~= 0 then
					local var_95_42 = manager.audio:GetVoiceLength("story_v_out_325571", "325571024", "story_v_out_325571.awb") / 1000

					if var_95_42 + var_95_34 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_42 + var_95_34
					end

					if var_95_37.prefab_name ~= "" and arg_92_1.actors_[var_95_37.prefab_name] ~= nil then
						local var_95_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_37.prefab_name].transform, "story_v_out_325571", "325571024", "story_v_out_325571.awb")

						arg_92_1:RecordAudio("325571024", var_95_43)
						arg_92_1:RecordAudio("325571024", var_95_43)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_325571", "325571024", "story_v_out_325571.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_325571", "325571024", "story_v_out_325571.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_44 = math.max(var_95_35, arg_92_1.talkMaxDuration)

			if var_95_34 <= arg_92_1.time_ and arg_92_1.time_ < var_95_34 + var_95_44 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_34) / var_95_44

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_34 + var_95_44 and arg_92_1.time_ < var_95_34 + var_95_44 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play325571025 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325571025
		arg_96_1.duration_ = 7.5

		local var_96_0 = {
			zh = 7.5,
			ja = 7.4
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play325571026(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 0.925

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_2 = arg_96_1:FormatText(StoryNameCfg[1473].name)

				arg_96_1.leftNameTxt_.text = var_99_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_3 = arg_96_1:GetWordFromCfg(325571025)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 37
				local var_99_6 = utf8.len(var_99_4)
				local var_99_7 = var_99_5 <= 0 and var_99_1 or var_99_1 * (var_99_6 / var_99_5)

				if var_99_7 > 0 and var_99_1 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571025", "story_v_out_325571.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_325571", "325571025", "story_v_out_325571.awb") / 1000

					if var_99_8 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_0
					end

					if var_99_3.prefab_name ~= "" and arg_96_1.actors_[var_99_3.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_3.prefab_name].transform, "story_v_out_325571", "325571025", "story_v_out_325571.awb")

						arg_96_1:RecordAudio("325571025", var_99_9)
						arg_96_1:RecordAudio("325571025", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_325571", "325571025", "story_v_out_325571.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_325571", "325571025", "story_v_out_325571.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_10 and arg_96_1.time_ < var_99_0 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play325571026 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 325571026
		arg_100_1.duration_ = 14.4

		local var_100_0 = {
			zh = 8.733,
			ja = 14.4
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play325571027(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action5_1")
			end

			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_103_2 = 0
			local var_103_3 = 1.025

			if var_103_2 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_4 = arg_100_1:FormatText(StoryNameCfg[1473].name)

				arg_100_1.leftNameTxt_.text = var_103_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_5 = arg_100_1:GetWordFromCfg(325571026)
				local var_103_6 = arg_100_1:FormatText(var_103_5.content)

				arg_100_1.text_.text = var_103_6

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 41
				local var_103_8 = utf8.len(var_103_6)
				local var_103_9 = var_103_7 <= 0 and var_103_3 or var_103_3 * (var_103_8 / var_103_7)

				if var_103_9 > 0 and var_103_3 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_2
					end
				end

				arg_100_1.text_.text = var_103_6
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571026", "story_v_out_325571.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_out_325571", "325571026", "story_v_out_325571.awb") / 1000

					if var_103_10 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_2
					end

					if var_103_5.prefab_name ~= "" and arg_100_1.actors_[var_103_5.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_5.prefab_name].transform, "story_v_out_325571", "325571026", "story_v_out_325571.awb")

						arg_100_1:RecordAudio("325571026", var_103_11)
						arg_100_1:RecordAudio("325571026", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_325571", "325571026", "story_v_out_325571.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_325571", "325571026", "story_v_out_325571.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_12 = math.max(var_103_3, arg_100_1.talkMaxDuration)

			if var_103_2 <= arg_100_1.time_ and arg_100_1.time_ < var_103_2 + var_103_12 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_2) / var_103_12

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_2 + var_103_12 and arg_100_1.time_ < var_103_2 + var_103_12 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play325571027 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 325571027
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play325571028(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["10175ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect10175ui_story == nil then
				arg_104_1.var_.characterEffect10175ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect10175ui_story and not isNil(var_107_0) then
					local var_107_4 = Mathf.Lerp(0, 0.5, var_107_3)

					arg_104_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_104_1.var_.characterEffect10175ui_story.fillRatio = var_107_4
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect10175ui_story then
				local var_107_5 = 0.5

				arg_104_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_104_1.var_.characterEffect10175ui_story.fillRatio = var_107_5
			end

			local var_107_6 = 0
			local var_107_7 = 1.05

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_8 = arg_104_1:GetWordFromCfg(325571027)
				local var_107_9 = arg_104_1:FormatText(var_107_8.content)

				arg_104_1.text_.text = var_107_9

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_10 = 42
				local var_107_11 = utf8.len(var_107_9)
				local var_107_12 = var_107_10 <= 0 and var_107_7 or var_107_7 * (var_107_11 / var_107_10)

				if var_107_12 > 0 and var_107_7 < var_107_12 then
					arg_104_1.talkMaxDuration = var_107_12

					if var_107_12 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_12 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_9
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_13 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_13 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_13

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_13 and arg_104_1.time_ < var_107_6 + var_107_13 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play325571028 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 325571028
		arg_108_1.duration_ = 10.97

		local var_108_0 = {
			zh = 6.5,
			ja = 10.966
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play325571029(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["10175ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect10175ui_story == nil then
				arg_108_1.var_.characterEffect10175ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect10175ui_story and not isNil(var_111_0) then
					arg_108_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect10175ui_story then
				arg_108_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_111_4 = 0

			if var_111_4 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action5_2")
			end

			local var_111_5 = 0

			if var_111_5 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_111_6 = 0
			local var_111_7 = 0.775

			if var_111_6 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_8 = arg_108_1:FormatText(StoryNameCfg[1473].name)

				arg_108_1.leftNameTxt_.text = var_111_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_9 = arg_108_1:GetWordFromCfg(325571028)
				local var_111_10 = arg_108_1:FormatText(var_111_9.content)

				arg_108_1.text_.text = var_111_10

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_11 = 31
				local var_111_12 = utf8.len(var_111_10)
				local var_111_13 = var_111_11 <= 0 and var_111_7 or var_111_7 * (var_111_12 / var_111_11)

				if var_111_13 > 0 and var_111_7 < var_111_13 then
					arg_108_1.talkMaxDuration = var_111_13

					if var_111_13 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_13 + var_111_6
					end
				end

				arg_108_1.text_.text = var_111_10
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571028", "story_v_out_325571.awb") ~= 0 then
					local var_111_14 = manager.audio:GetVoiceLength("story_v_out_325571", "325571028", "story_v_out_325571.awb") / 1000

					if var_111_14 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_14 + var_111_6
					end

					if var_111_9.prefab_name ~= "" and arg_108_1.actors_[var_111_9.prefab_name] ~= nil then
						local var_111_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_9.prefab_name].transform, "story_v_out_325571", "325571028", "story_v_out_325571.awb")

						arg_108_1:RecordAudio("325571028", var_111_15)
						arg_108_1:RecordAudio("325571028", var_111_15)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_325571", "325571028", "story_v_out_325571.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_325571", "325571028", "story_v_out_325571.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_16 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_16 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_16

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_16 and arg_108_1.time_ < var_111_6 + var_111_16 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play325571029 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 325571029
		arg_112_1.duration_ = 2

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play325571030(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["10167ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect10167ui_story == nil then
				arg_112_1.var_.characterEffect10167ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect10167ui_story and not isNil(var_115_0) then
					arg_112_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect10167ui_story then
				arg_112_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_115_4 = arg_112_1.actors_["10175ui_story"]
			local var_115_5 = 0

			if var_115_5 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect10175ui_story == nil then
				arg_112_1.var_.characterEffect10175ui_story = var_115_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_6 = 0.200000002980232

			if var_115_5 <= arg_112_1.time_ and arg_112_1.time_ < var_115_5 + var_115_6 and not isNil(var_115_4) then
				local var_115_7 = (arg_112_1.time_ - var_115_5) / var_115_6

				if arg_112_1.var_.characterEffect10175ui_story and not isNil(var_115_4) then
					local var_115_8 = Mathf.Lerp(0, 0.5, var_115_7)

					arg_112_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_112_1.var_.characterEffect10175ui_story.fillRatio = var_115_8
				end
			end

			if arg_112_1.time_ >= var_115_5 + var_115_6 and arg_112_1.time_ < var_115_5 + var_115_6 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect10175ui_story then
				local var_115_9 = 0.5

				arg_112_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_112_1.var_.characterEffect10175ui_story.fillRatio = var_115_9
			end

			local var_115_10 = 0

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 then
				arg_112_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action16_1")
			end

			local var_115_11 = 0

			if var_115_11 < arg_112_1.time_ and arg_112_1.time_ <= var_115_11 + arg_115_0 then
				arg_112_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_115_12 = 0
			local var_115_13 = 0.075

			if var_115_12 < arg_112_1.time_ and arg_112_1.time_ <= var_115_12 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_14 = arg_112_1:FormatText(StoryNameCfg[1447].name)

				arg_112_1.leftNameTxt_.text = var_115_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_15 = arg_112_1:GetWordFromCfg(325571029)
				local var_115_16 = arg_112_1:FormatText(var_115_15.content)

				arg_112_1.text_.text = var_115_16

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_17 = 3
				local var_115_18 = utf8.len(var_115_16)
				local var_115_19 = var_115_17 <= 0 and var_115_13 or var_115_13 * (var_115_18 / var_115_17)

				if var_115_19 > 0 and var_115_13 < var_115_19 then
					arg_112_1.talkMaxDuration = var_115_19

					if var_115_19 + var_115_12 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_19 + var_115_12
					end
				end

				arg_112_1.text_.text = var_115_16
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571029", "story_v_out_325571.awb") ~= 0 then
					local var_115_20 = manager.audio:GetVoiceLength("story_v_out_325571", "325571029", "story_v_out_325571.awb") / 1000

					if var_115_20 + var_115_12 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_20 + var_115_12
					end

					if var_115_15.prefab_name ~= "" and arg_112_1.actors_[var_115_15.prefab_name] ~= nil then
						local var_115_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_15.prefab_name].transform, "story_v_out_325571", "325571029", "story_v_out_325571.awb")

						arg_112_1:RecordAudio("325571029", var_115_21)
						arg_112_1:RecordAudio("325571029", var_115_21)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_325571", "325571029", "story_v_out_325571.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_325571", "325571029", "story_v_out_325571.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_22 = math.max(var_115_13, arg_112_1.talkMaxDuration)

			if var_115_12 <= arg_112_1.time_ and arg_112_1.time_ < var_115_12 + var_115_22 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_12) / var_115_22

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_12 + var_115_22 and arg_112_1.time_ < var_115_12 + var_115_22 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play325571030 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 325571030
		arg_116_1.duration_ = 7.67

		local var_116_0 = {
			zh = 5.3,
			ja = 7.666
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play325571031(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["10175ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect10175ui_story == nil then
				arg_116_1.var_.characterEffect10175ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect10175ui_story and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect10175ui_story then
				arg_116_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_119_4 = arg_116_1.actors_["10167ui_story"]
			local var_119_5 = 0

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 and not isNil(var_119_4) and arg_116_1.var_.characterEffect10167ui_story == nil then
				arg_116_1.var_.characterEffect10167ui_story = var_119_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_6 = 0.200000002980232

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_6 and not isNil(var_119_4) then
				local var_119_7 = (arg_116_1.time_ - var_119_5) / var_119_6

				if arg_116_1.var_.characterEffect10167ui_story and not isNil(var_119_4) then
					local var_119_8 = Mathf.Lerp(0, 0.5, var_119_7)

					arg_116_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_116_1.var_.characterEffect10167ui_story.fillRatio = var_119_8
				end
			end

			if arg_116_1.time_ >= var_119_5 + var_119_6 and arg_116_1.time_ < var_119_5 + var_119_6 + arg_119_0 and not isNil(var_119_4) and arg_116_1.var_.characterEffect10167ui_story then
				local var_119_9 = 0.5

				arg_116_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_116_1.var_.characterEffect10167ui_story.fillRatio = var_119_9
			end

			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 then
				arg_116_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_1")
			end

			local var_119_11 = 0

			if var_119_11 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_119_12 = 0
			local var_119_13 = 0.625

			if var_119_12 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_14 = arg_116_1:FormatText(StoryNameCfg[1473].name)

				arg_116_1.leftNameTxt_.text = var_119_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_15 = arg_116_1:GetWordFromCfg(325571030)
				local var_119_16 = arg_116_1:FormatText(var_119_15.content)

				arg_116_1.text_.text = var_119_16

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_17 = 25
				local var_119_18 = utf8.len(var_119_16)
				local var_119_19 = var_119_17 <= 0 and var_119_13 or var_119_13 * (var_119_18 / var_119_17)

				if var_119_19 > 0 and var_119_13 < var_119_19 then
					arg_116_1.talkMaxDuration = var_119_19

					if var_119_19 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_19 + var_119_12
					end
				end

				arg_116_1.text_.text = var_119_16
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571030", "story_v_out_325571.awb") ~= 0 then
					local var_119_20 = manager.audio:GetVoiceLength("story_v_out_325571", "325571030", "story_v_out_325571.awb") / 1000

					if var_119_20 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_20 + var_119_12
					end

					if var_119_15.prefab_name ~= "" and arg_116_1.actors_[var_119_15.prefab_name] ~= nil then
						local var_119_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_15.prefab_name].transform, "story_v_out_325571", "325571030", "story_v_out_325571.awb")

						arg_116_1:RecordAudio("325571030", var_119_21)
						arg_116_1:RecordAudio("325571030", var_119_21)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_325571", "325571030", "story_v_out_325571.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_325571", "325571030", "story_v_out_325571.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_22 = math.max(var_119_13, arg_116_1.talkMaxDuration)

			if var_119_12 <= arg_116_1.time_ and arg_116_1.time_ < var_119_12 + var_119_22 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_12) / var_119_22

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_12 + var_119_22 and arg_116_1.time_ < var_119_12 + var_119_22 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play325571031 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 325571031
		arg_120_1.duration_ = 15.53

		local var_120_0 = {
			zh = 9.7,
			ja = 15.533
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play325571032(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 1.075

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[1473].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_3 = arg_120_1:GetWordFromCfg(325571031)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 43
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571031", "story_v_out_325571.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_325571", "325571031", "story_v_out_325571.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_325571", "325571031", "story_v_out_325571.awb")

						arg_120_1:RecordAudio("325571031", var_123_9)
						arg_120_1:RecordAudio("325571031", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_325571", "325571031", "story_v_out_325571.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_325571", "325571031", "story_v_out_325571.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_10 and arg_120_1.time_ < var_123_0 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play325571032 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 325571032
		arg_124_1.duration_ = 2

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play325571033(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["10167ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect10167ui_story == nil then
				arg_124_1.var_.characterEffect10167ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect10167ui_story and not isNil(var_127_0) then
					arg_124_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect10167ui_story then
				arg_124_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_127_4 = arg_124_1.actors_["10175ui_story"]
			local var_127_5 = 0

			if var_127_5 < arg_124_1.time_ and arg_124_1.time_ <= var_127_5 + arg_127_0 and not isNil(var_127_4) and arg_124_1.var_.characterEffect10175ui_story == nil then
				arg_124_1.var_.characterEffect10175ui_story = var_127_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_6 = 0.200000002980232

			if var_127_5 <= arg_124_1.time_ and arg_124_1.time_ < var_127_5 + var_127_6 and not isNil(var_127_4) then
				local var_127_7 = (arg_124_1.time_ - var_127_5) / var_127_6

				if arg_124_1.var_.characterEffect10175ui_story and not isNil(var_127_4) then
					local var_127_8 = Mathf.Lerp(0, 0.5, var_127_7)

					arg_124_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_124_1.var_.characterEffect10175ui_story.fillRatio = var_127_8
				end
			end

			if arg_124_1.time_ >= var_127_5 + var_127_6 and arg_124_1.time_ < var_127_5 + var_127_6 + arg_127_0 and not isNil(var_127_4) and arg_124_1.var_.characterEffect10175ui_story then
				local var_127_9 = 0.5

				arg_124_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_124_1.var_.characterEffect10175ui_story.fillRatio = var_127_9
			end

			local var_127_10 = 0

			if var_127_10 < arg_124_1.time_ and arg_124_1.time_ <= var_127_10 + arg_127_0 then
				arg_124_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action16_2")
			end

			local var_127_11 = 0

			if var_127_11 < arg_124_1.time_ and arg_124_1.time_ <= var_127_11 + arg_127_0 then
				arg_124_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_127_12 = 0
			local var_127_13 = 0.05

			if var_127_12 < arg_124_1.time_ and arg_124_1.time_ <= var_127_12 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_14 = arg_124_1:FormatText(StoryNameCfg[1447].name)

				arg_124_1.leftNameTxt_.text = var_127_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_15 = arg_124_1:GetWordFromCfg(325571032)
				local var_127_16 = arg_124_1:FormatText(var_127_15.content)

				arg_124_1.text_.text = var_127_16

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_17 = 2
				local var_127_18 = utf8.len(var_127_16)
				local var_127_19 = var_127_17 <= 0 and var_127_13 or var_127_13 * (var_127_18 / var_127_17)

				if var_127_19 > 0 and var_127_13 < var_127_19 then
					arg_124_1.talkMaxDuration = var_127_19

					if var_127_19 + var_127_12 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_19 + var_127_12
					end
				end

				arg_124_1.text_.text = var_127_16
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571032", "story_v_out_325571.awb") ~= 0 then
					local var_127_20 = manager.audio:GetVoiceLength("story_v_out_325571", "325571032", "story_v_out_325571.awb") / 1000

					if var_127_20 + var_127_12 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_20 + var_127_12
					end

					if var_127_15.prefab_name ~= "" and arg_124_1.actors_[var_127_15.prefab_name] ~= nil then
						local var_127_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_15.prefab_name].transform, "story_v_out_325571", "325571032", "story_v_out_325571.awb")

						arg_124_1:RecordAudio("325571032", var_127_21)
						arg_124_1:RecordAudio("325571032", var_127_21)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_325571", "325571032", "story_v_out_325571.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_325571", "325571032", "story_v_out_325571.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_22 = math.max(var_127_13, arg_124_1.talkMaxDuration)

			if var_127_12 <= arg_124_1.time_ and arg_124_1.time_ < var_127_12 + var_127_22 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_12) / var_127_22

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_12 + var_127_22 and arg_124_1.time_ < var_127_12 + var_127_22 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play325571033 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 325571033
		arg_128_1.duration_ = 8.53

		local var_128_0 = {
			zh = 7.6,
			ja = 8.533
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play325571034(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["10175ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect10175ui_story == nil then
				arg_128_1.var_.characterEffect10175ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect10175ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect10175ui_story then
				arg_128_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_131_4 = arg_128_1.actors_["10167ui_story"]
			local var_131_5 = 0

			if var_131_5 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect10167ui_story == nil then
				arg_128_1.var_.characterEffect10167ui_story = var_131_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_6 = 0.200000002980232

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_6 and not isNil(var_131_4) then
				local var_131_7 = (arg_128_1.time_ - var_131_5) / var_131_6

				if arg_128_1.var_.characterEffect10167ui_story and not isNil(var_131_4) then
					local var_131_8 = Mathf.Lerp(0, 0.5, var_131_7)

					arg_128_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_128_1.var_.characterEffect10167ui_story.fillRatio = var_131_8
				end
			end

			if arg_128_1.time_ >= var_131_5 + var_131_6 and arg_128_1.time_ < var_131_5 + var_131_6 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect10167ui_story then
				local var_131_9 = 0.5

				arg_128_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_128_1.var_.characterEffect10167ui_story.fillRatio = var_131_9
			end

			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 then
				arg_128_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175actionlink/10175action4392")
			end

			local var_131_11 = 0

			if var_131_11 < arg_128_1.time_ and arg_128_1.time_ <= var_131_11 + arg_131_0 then
				arg_128_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_131_12 = 0
			local var_131_13 = 0.9

			if var_131_12 < arg_128_1.time_ and arg_128_1.time_ <= var_131_12 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_14 = arg_128_1:FormatText(StoryNameCfg[1473].name)

				arg_128_1.leftNameTxt_.text = var_131_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_15 = arg_128_1:GetWordFromCfg(325571033)
				local var_131_16 = arg_128_1:FormatText(var_131_15.content)

				arg_128_1.text_.text = var_131_16

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_17 = 36
				local var_131_18 = utf8.len(var_131_16)
				local var_131_19 = var_131_17 <= 0 and var_131_13 or var_131_13 * (var_131_18 / var_131_17)

				if var_131_19 > 0 and var_131_13 < var_131_19 then
					arg_128_1.talkMaxDuration = var_131_19

					if var_131_19 + var_131_12 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_19 + var_131_12
					end
				end

				arg_128_1.text_.text = var_131_16
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571033", "story_v_out_325571.awb") ~= 0 then
					local var_131_20 = manager.audio:GetVoiceLength("story_v_out_325571", "325571033", "story_v_out_325571.awb") / 1000

					if var_131_20 + var_131_12 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_20 + var_131_12
					end

					if var_131_15.prefab_name ~= "" and arg_128_1.actors_[var_131_15.prefab_name] ~= nil then
						local var_131_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_15.prefab_name].transform, "story_v_out_325571", "325571033", "story_v_out_325571.awb")

						arg_128_1:RecordAudio("325571033", var_131_21)
						arg_128_1:RecordAudio("325571033", var_131_21)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_325571", "325571033", "story_v_out_325571.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_325571", "325571033", "story_v_out_325571.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_22 = math.max(var_131_13, arg_128_1.talkMaxDuration)

			if var_131_12 <= arg_128_1.time_ and arg_128_1.time_ < var_131_12 + var_131_22 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_12) / var_131_22

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_12 + var_131_22 and arg_128_1.time_ < var_131_12 + var_131_22 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play325571034 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 325571034
		arg_132_1.duration_ = 7.53

		local var_132_0 = {
			zh = 4.4,
			ja = 7.533
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play325571035(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 0.575

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_2 = arg_132_1:FormatText(StoryNameCfg[1473].name)

				arg_132_1.leftNameTxt_.text = var_135_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_3 = arg_132_1:GetWordFromCfg(325571034)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 23
				local var_135_6 = utf8.len(var_135_4)
				local var_135_7 = var_135_5 <= 0 and var_135_1 or var_135_1 * (var_135_6 / var_135_5)

				if var_135_7 > 0 and var_135_1 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571034", "story_v_out_325571.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_325571", "325571034", "story_v_out_325571.awb") / 1000

					if var_135_8 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_0
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_325571", "325571034", "story_v_out_325571.awb")

						arg_132_1:RecordAudio("325571034", var_135_9)
						arg_132_1:RecordAudio("325571034", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_325571", "325571034", "story_v_out_325571.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_325571", "325571034", "story_v_out_325571.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_10 and arg_132_1.time_ < var_135_0 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play325571035 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 325571035
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play325571036(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["10175ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect10175ui_story == nil then
				arg_136_1.var_.characterEffect10175ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect10175ui_story and not isNil(var_139_0) then
					local var_139_4 = Mathf.Lerp(0, 0.5, var_139_3)

					arg_136_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_136_1.var_.characterEffect10175ui_story.fillRatio = var_139_4
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect10175ui_story then
				local var_139_5 = 0.5

				arg_136_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_136_1.var_.characterEffect10175ui_story.fillRatio = var_139_5
			end

			local var_139_6 = 0

			if var_139_6 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_1")
			end

			local var_139_7 = 0

			if var_139_7 < arg_136_1.time_ and arg_136_1.time_ <= var_139_7 + arg_139_0 then
				arg_136_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_139_8 = 0
			local var_139_9 = 0.95

			if var_139_8 < arg_136_1.time_ and arg_136_1.time_ <= var_139_8 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_10 = arg_136_1:GetWordFromCfg(325571035)
				local var_139_11 = arg_136_1:FormatText(var_139_10.content)

				arg_136_1.text_.text = var_139_11

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_12 = 38
				local var_139_13 = utf8.len(var_139_11)
				local var_139_14 = var_139_12 <= 0 and var_139_9 or var_139_9 * (var_139_13 / var_139_12)

				if var_139_14 > 0 and var_139_9 < var_139_14 then
					arg_136_1.talkMaxDuration = var_139_14

					if var_139_14 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_14 + var_139_8
					end
				end

				arg_136_1.text_.text = var_139_11
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_15 = math.max(var_139_9, arg_136_1.talkMaxDuration)

			if var_139_8 <= arg_136_1.time_ and arg_136_1.time_ < var_139_8 + var_139_15 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_8) / var_139_15

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_8 + var_139_15 and arg_136_1.time_ < var_139_8 + var_139_15 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play325571036 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 325571036
		arg_140_1.duration_ = 4.63

		local var_140_0 = {
			zh = 4.3,
			ja = 4.633
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play325571037(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["10167ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect10167ui_story == nil then
				arg_140_1.var_.characterEffect10167ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect10167ui_story and not isNil(var_143_0) then
					arg_140_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect10167ui_story then
				arg_140_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_143_4 = 0

			if var_143_4 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_143_5 = 0
			local var_143_6 = 0.35

			if var_143_5 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_7 = arg_140_1:FormatText(StoryNameCfg[1447].name)

				arg_140_1.leftNameTxt_.text = var_143_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_8 = arg_140_1:GetWordFromCfg(325571036)
				local var_143_9 = arg_140_1:FormatText(var_143_8.content)

				arg_140_1.text_.text = var_143_9

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_10 = 14
				local var_143_11 = utf8.len(var_143_9)
				local var_143_12 = var_143_10 <= 0 and var_143_6 or var_143_6 * (var_143_11 / var_143_10)

				if var_143_12 > 0 and var_143_6 < var_143_12 then
					arg_140_1.talkMaxDuration = var_143_12

					if var_143_12 + var_143_5 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_12 + var_143_5
					end
				end

				arg_140_1.text_.text = var_143_9
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571036", "story_v_out_325571.awb") ~= 0 then
					local var_143_13 = manager.audio:GetVoiceLength("story_v_out_325571", "325571036", "story_v_out_325571.awb") / 1000

					if var_143_13 + var_143_5 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_5
					end

					if var_143_8.prefab_name ~= "" and arg_140_1.actors_[var_143_8.prefab_name] ~= nil then
						local var_143_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_8.prefab_name].transform, "story_v_out_325571", "325571036", "story_v_out_325571.awb")

						arg_140_1:RecordAudio("325571036", var_143_14)
						arg_140_1:RecordAudio("325571036", var_143_14)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_325571", "325571036", "story_v_out_325571.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_325571", "325571036", "story_v_out_325571.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_15 = math.max(var_143_6, arg_140_1.talkMaxDuration)

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_15 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_5) / var_143_15

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_5 + var_143_15 and arg_140_1.time_ < var_143_5 + var_143_15 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play325571037 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 325571037
		arg_144_1.duration_ = 9.17

		local var_144_0 = {
			zh = 6.7,
			ja = 9.166
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play325571038(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.675

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[1447].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_3 = arg_144_1:GetWordFromCfg(325571037)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 27
				local var_147_6 = utf8.len(var_147_4)
				local var_147_7 = var_147_5 <= 0 and var_147_1 or var_147_1 * (var_147_6 / var_147_5)

				if var_147_7 > 0 and var_147_1 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571037", "story_v_out_325571.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_325571", "325571037", "story_v_out_325571.awb") / 1000

					if var_147_8 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_0
					end

					if var_147_3.prefab_name ~= "" and arg_144_1.actors_[var_147_3.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_3.prefab_name].transform, "story_v_out_325571", "325571037", "story_v_out_325571.awb")

						arg_144_1:RecordAudio("325571037", var_147_9)
						arg_144_1:RecordAudio("325571037", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_325571", "325571037", "story_v_out_325571.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_325571", "325571037", "story_v_out_325571.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_10 and arg_144_1.time_ < var_147_0 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play325571038 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 325571038
		arg_148_1.duration_ = 9.47

		local var_148_0 = {
			zh = 7.733,
			ja = 9.466
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play325571039(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["10175ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect10175ui_story == nil then
				arg_148_1.var_.characterEffect10175ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect10175ui_story and not isNil(var_151_0) then
					arg_148_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect10175ui_story then
				arg_148_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_151_4 = arg_148_1.actors_["10167ui_story"]
			local var_151_5 = 0

			if var_151_5 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 and not isNil(var_151_4) and arg_148_1.var_.characterEffect10167ui_story == nil then
				arg_148_1.var_.characterEffect10167ui_story = var_151_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_6 = 0.200000002980232

			if var_151_5 <= arg_148_1.time_ and arg_148_1.time_ < var_151_5 + var_151_6 and not isNil(var_151_4) then
				local var_151_7 = (arg_148_1.time_ - var_151_5) / var_151_6

				if arg_148_1.var_.characterEffect10167ui_story and not isNil(var_151_4) then
					local var_151_8 = Mathf.Lerp(0, 0.5, var_151_7)

					arg_148_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_148_1.var_.characterEffect10167ui_story.fillRatio = var_151_8
				end
			end

			if arg_148_1.time_ >= var_151_5 + var_151_6 and arg_148_1.time_ < var_151_5 + var_151_6 + arg_151_0 and not isNil(var_151_4) and arg_148_1.var_.characterEffect10167ui_story then
				local var_151_9 = 0.5

				arg_148_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_148_1.var_.characterEffect10167ui_story.fillRatio = var_151_9
			end

			local var_151_10 = 0

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 then
				arg_148_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action2_2")
			end

			local var_151_11 = 0

			if var_151_11 < arg_148_1.time_ and arg_148_1.time_ <= var_151_11 + arg_151_0 then
				arg_148_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_151_12 = 0
			local var_151_13 = 0.875

			if var_151_12 < arg_148_1.time_ and arg_148_1.time_ <= var_151_12 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_14 = arg_148_1:FormatText(StoryNameCfg[1473].name)

				arg_148_1.leftNameTxt_.text = var_151_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_15 = arg_148_1:GetWordFromCfg(325571038)
				local var_151_16 = arg_148_1:FormatText(var_151_15.content)

				arg_148_1.text_.text = var_151_16

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_17 = 35
				local var_151_18 = utf8.len(var_151_16)
				local var_151_19 = var_151_17 <= 0 and var_151_13 or var_151_13 * (var_151_18 / var_151_17)

				if var_151_19 > 0 and var_151_13 < var_151_19 then
					arg_148_1.talkMaxDuration = var_151_19

					if var_151_19 + var_151_12 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_19 + var_151_12
					end
				end

				arg_148_1.text_.text = var_151_16
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571038", "story_v_out_325571.awb") ~= 0 then
					local var_151_20 = manager.audio:GetVoiceLength("story_v_out_325571", "325571038", "story_v_out_325571.awb") / 1000

					if var_151_20 + var_151_12 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_20 + var_151_12
					end

					if var_151_15.prefab_name ~= "" and arg_148_1.actors_[var_151_15.prefab_name] ~= nil then
						local var_151_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_15.prefab_name].transform, "story_v_out_325571", "325571038", "story_v_out_325571.awb")

						arg_148_1:RecordAudio("325571038", var_151_21)
						arg_148_1:RecordAudio("325571038", var_151_21)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_325571", "325571038", "story_v_out_325571.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_325571", "325571038", "story_v_out_325571.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_22 = math.max(var_151_13, arg_148_1.talkMaxDuration)

			if var_151_12 <= arg_148_1.time_ and arg_148_1.time_ < var_151_12 + var_151_22 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_12) / var_151_22

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_12 + var_151_22 and arg_148_1.time_ < var_151_12 + var_151_22 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play325571039 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 325571039
		arg_152_1.duration_ = 6.87

		local var_152_0 = {
			zh = 5.9,
			ja = 6.866
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play325571040(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["10175ui_story"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos10175ui_story = var_155_0.localPosition

				local var_155_2 = GameObjectTools.GetOrAddComponent(var_155_0.gameObject, typeof(DynamicBoneHelper))

				if var_155_2 then
					var_155_2:EnableDynamicBone(false)
				end
			end

			local var_155_3 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_3 then
				local var_155_4 = (arg_152_1.time_ - var_155_1) / var_155_3
				local var_155_5 = Vector3.New(0, 100, 0)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10175ui_story, var_155_5, var_155_4)

				local var_155_6 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_6.x, var_155_6.y, var_155_6.z)

				local var_155_7 = var_155_0.localEulerAngles

				var_155_7.z = 0
				var_155_7.x = 0
				var_155_0.localEulerAngles = var_155_7
			end

			if arg_152_1.time_ >= var_155_1 + var_155_3 and arg_152_1.time_ < var_155_1 + var_155_3 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(0, 100, 0)

				local var_155_8 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_8.x, var_155_8.y, var_155_8.z)

				local var_155_9 = var_155_0.localEulerAngles

				var_155_9.z = 0
				var_155_9.x = 0
				var_155_0.localEulerAngles = var_155_9

				local var_155_10 = GameObjectTools.GetOrAddComponent(var_155_0.gameObject, typeof(DynamicBoneHelper))

				if var_155_10 then
					var_155_10:EnableDynamicBone(true)
				end
			end

			local var_155_11 = arg_152_1.actors_["10176ui_story"].transform
			local var_155_12 = 0

			if var_155_12 < arg_152_1.time_ and arg_152_1.time_ <= var_155_12 + arg_155_0 then
				arg_152_1.var_.moveOldPos10176ui_story = var_155_11.localPosition

				local var_155_13 = GameObjectTools.GetOrAddComponent(var_155_11.gameObject, typeof(DynamicBoneHelper))

				if var_155_13 then
					var_155_13:EnableDynamicBone(false)
				end
			end

			local var_155_14 = 0.001

			if var_155_12 <= arg_152_1.time_ and arg_152_1.time_ < var_155_12 + var_155_14 then
				local var_155_15 = (arg_152_1.time_ - var_155_12) / var_155_14
				local var_155_16 = Vector3.New(0.79, -1.09, -6.12)

				var_155_11.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10176ui_story, var_155_16, var_155_15)

				local var_155_17 = manager.ui.mainCamera.transform.position - var_155_11.position

				var_155_11.forward = Vector3.New(var_155_17.x, var_155_17.y, var_155_17.z)

				local var_155_18 = var_155_11.localEulerAngles

				var_155_18.z = 0
				var_155_18.x = 0
				var_155_11.localEulerAngles = var_155_18
			end

			if arg_152_1.time_ >= var_155_12 + var_155_14 and arg_152_1.time_ < var_155_12 + var_155_14 + arg_155_0 then
				var_155_11.localPosition = Vector3.New(0.79, -1.09, -6.12)

				local var_155_19 = manager.ui.mainCamera.transform.position - var_155_11.position

				var_155_11.forward = Vector3.New(var_155_19.x, var_155_19.y, var_155_19.z)

				local var_155_20 = var_155_11.localEulerAngles

				var_155_20.z = 0
				var_155_20.x = 0
				var_155_11.localEulerAngles = var_155_20

				local var_155_21 = GameObjectTools.GetOrAddComponent(var_155_11.gameObject, typeof(DynamicBoneHelper))

				if var_155_21 then
					var_155_21:EnableDynamicBone(true)
				end
			end

			local var_155_22 = arg_152_1.actors_["10176ui_story"]
			local var_155_23 = 0

			if var_155_23 < arg_152_1.time_ and arg_152_1.time_ <= var_155_23 + arg_155_0 and not isNil(var_155_22) and arg_152_1.var_.characterEffect10176ui_story == nil then
				arg_152_1.var_.characterEffect10176ui_story = var_155_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_24 = 0.200000002980232

			if var_155_23 <= arg_152_1.time_ and arg_152_1.time_ < var_155_23 + var_155_24 and not isNil(var_155_22) then
				local var_155_25 = (arg_152_1.time_ - var_155_23) / var_155_24

				if arg_152_1.var_.characterEffect10176ui_story and not isNil(var_155_22) then
					arg_152_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_23 + var_155_24 and arg_152_1.time_ < var_155_23 + var_155_24 + arg_155_0 and not isNil(var_155_22) and arg_152_1.var_.characterEffect10176ui_story then
				arg_152_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_155_26 = arg_152_1.actors_["10175ui_story"]
			local var_155_27 = 0

			if var_155_27 < arg_152_1.time_ and arg_152_1.time_ <= var_155_27 + arg_155_0 and not isNil(var_155_26) and arg_152_1.var_.characterEffect10175ui_story == nil then
				arg_152_1.var_.characterEffect10175ui_story = var_155_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_28 = 0.200000002980232

			if var_155_27 <= arg_152_1.time_ and arg_152_1.time_ < var_155_27 + var_155_28 and not isNil(var_155_26) then
				local var_155_29 = (arg_152_1.time_ - var_155_27) / var_155_28

				if arg_152_1.var_.characterEffect10175ui_story and not isNil(var_155_26) then
					local var_155_30 = Mathf.Lerp(0, 0.5, var_155_29)

					arg_152_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_152_1.var_.characterEffect10175ui_story.fillRatio = var_155_30
				end
			end

			if arg_152_1.time_ >= var_155_27 + var_155_28 and arg_152_1.time_ < var_155_27 + var_155_28 + arg_155_0 and not isNil(var_155_26) and arg_152_1.var_.characterEffect10175ui_story then
				local var_155_31 = 0.5

				arg_152_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_152_1.var_.characterEffect10175ui_story.fillRatio = var_155_31
			end

			local var_155_32 = 0
			local var_155_33 = 0.5

			if var_155_32 < arg_152_1.time_ and arg_152_1.time_ <= var_155_32 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_34 = arg_152_1:FormatText(StoryNameCfg[1510].name)

				arg_152_1.leftNameTxt_.text = var_155_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_35 = arg_152_1:GetWordFromCfg(325571039)
				local var_155_36 = arg_152_1:FormatText(var_155_35.content)

				arg_152_1.text_.text = var_155_36

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_37 = 20
				local var_155_38 = utf8.len(var_155_36)
				local var_155_39 = var_155_37 <= 0 and var_155_33 or var_155_33 * (var_155_38 / var_155_37)

				if var_155_39 > 0 and var_155_33 < var_155_39 then
					arg_152_1.talkMaxDuration = var_155_39

					if var_155_39 + var_155_32 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_39 + var_155_32
					end
				end

				arg_152_1.text_.text = var_155_36
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571039", "story_v_out_325571.awb") ~= 0 then
					local var_155_40 = manager.audio:GetVoiceLength("story_v_out_325571", "325571039", "story_v_out_325571.awb") / 1000

					if var_155_40 + var_155_32 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_40 + var_155_32
					end

					if var_155_35.prefab_name ~= "" and arg_152_1.actors_[var_155_35.prefab_name] ~= nil then
						local var_155_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_35.prefab_name].transform, "story_v_out_325571", "325571039", "story_v_out_325571.awb")

						arg_152_1:RecordAudio("325571039", var_155_41)
						arg_152_1:RecordAudio("325571039", var_155_41)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_325571", "325571039", "story_v_out_325571.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_325571", "325571039", "story_v_out_325571.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_42 = math.max(var_155_33, arg_152_1.talkMaxDuration)

			if var_155_32 <= arg_152_1.time_ and arg_152_1.time_ < var_155_32 + var_155_42 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_32) / var_155_42

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_32 + var_155_42 and arg_152_1.time_ < var_155_32 + var_155_42 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play325571040 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 325571040
		arg_156_1.duration_ = 7.3

		local var_156_0 = {
			zh = 7.3,
			ja = 6.4
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play325571041(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176actionlink/10176action445")
			end

			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_159_2 = 0
			local var_159_3 = 0.6

			if var_159_2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_2 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_4 = arg_156_1:FormatText(StoryNameCfg[1510].name)

				arg_156_1.leftNameTxt_.text = var_159_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_5 = arg_156_1:GetWordFromCfg(325571040)
				local var_159_6 = arg_156_1:FormatText(var_159_5.content)

				arg_156_1.text_.text = var_159_6

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_7 = 24
				local var_159_8 = utf8.len(var_159_6)
				local var_159_9 = var_159_7 <= 0 and var_159_3 or var_159_3 * (var_159_8 / var_159_7)

				if var_159_9 > 0 and var_159_3 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_2 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_2
					end
				end

				arg_156_1.text_.text = var_159_6
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571040", "story_v_out_325571.awb") ~= 0 then
					local var_159_10 = manager.audio:GetVoiceLength("story_v_out_325571", "325571040", "story_v_out_325571.awb") / 1000

					if var_159_10 + var_159_2 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_2
					end

					if var_159_5.prefab_name ~= "" and arg_156_1.actors_[var_159_5.prefab_name] ~= nil then
						local var_159_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_5.prefab_name].transform, "story_v_out_325571", "325571040", "story_v_out_325571.awb")

						arg_156_1:RecordAudio("325571040", var_159_11)
						arg_156_1:RecordAudio("325571040", var_159_11)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_325571", "325571040", "story_v_out_325571.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_325571", "325571040", "story_v_out_325571.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_12 = math.max(var_159_3, arg_156_1.talkMaxDuration)

			if var_159_2 <= arg_156_1.time_ and arg_156_1.time_ < var_159_2 + var_159_12 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_2) / var_159_12

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_2 + var_159_12 and arg_156_1.time_ < var_159_2 + var_159_12 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play325571041 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 325571041
		arg_160_1.duration_ = 8.03

		local var_160_0 = {
			zh = 8.03199999815225,
			ja = 7.56599999815226
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play325571042(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = "J21h"

			if arg_160_1.bgs_[var_163_0] == nil then
				local var_163_1 = Object.Instantiate(arg_160_1.paintGo_)

				var_163_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_163_0)
				var_163_1.name = var_163_0
				var_163_1.transform.parent = arg_160_1.stage_.transform
				var_163_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.bgs_[var_163_0] = var_163_1
			end

			local var_163_2 = 1.96599999815226

			if var_163_2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				local var_163_3 = manager.ui.mainCamera.transform.localPosition
				local var_163_4 = Vector3.New(0, 0, 10) + Vector3.New(var_163_3.x, var_163_3.y, 0)
				local var_163_5 = arg_160_1.bgs_.J21h

				var_163_5.transform.localPosition = var_163_4
				var_163_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_6 = var_163_5:GetComponent("SpriteRenderer")

				if var_163_6 and var_163_6.sprite then
					local var_163_7 = (var_163_5.transform.localPosition - var_163_3).z
					local var_163_8 = manager.ui.mainCameraCom_
					local var_163_9 = 2 * var_163_7 * Mathf.Tan(var_163_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_163_10 = var_163_9 * var_163_8.aspect
					local var_163_11 = var_163_6.sprite.bounds.size.x
					local var_163_12 = var_163_6.sprite.bounds.size.y
					local var_163_13 = var_163_10 / var_163_11
					local var_163_14 = var_163_9 / var_163_12
					local var_163_15 = var_163_14 < var_163_13 and var_163_13 or var_163_14

					var_163_5.transform.localScale = Vector3.New(var_163_15, var_163_15, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "J21h" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_16 = 3.999999999999

			if var_163_16 < arg_160_1.time_ and arg_160_1.time_ <= var_163_16 + arg_163_0 then
				arg_160_1.allBtn_.enabled = false
			end

			local var_163_17 = 0.3

			if arg_160_1.time_ >= var_163_16 + var_163_17 and arg_160_1.time_ < var_163_16 + var_163_17 + arg_163_0 then
				arg_160_1.allBtn_.enabled = true
			end

			local var_163_18 = 0

			if var_163_18 < arg_160_1.time_ and arg_160_1.time_ <= var_163_18 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_19 = 2

			if var_163_18 <= arg_160_1.time_ and arg_160_1.time_ < var_163_18 + var_163_19 then
				local var_163_20 = (arg_160_1.time_ - var_163_18) / var_163_19
				local var_163_21 = Color.New(0, 0, 0)

				var_163_21.a = Mathf.Lerp(0, 1, var_163_20)
				arg_160_1.mask_.color = var_163_21
			end

			if arg_160_1.time_ >= var_163_18 + var_163_19 and arg_160_1.time_ < var_163_18 + var_163_19 + arg_163_0 then
				local var_163_22 = Color.New(0, 0, 0)

				var_163_22.a = 1
				arg_160_1.mask_.color = var_163_22
			end

			local var_163_23 = 2

			if var_163_23 < arg_160_1.time_ and arg_160_1.time_ <= var_163_23 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_24 = 2

			if var_163_23 <= arg_160_1.time_ and arg_160_1.time_ < var_163_23 + var_163_24 then
				local var_163_25 = (arg_160_1.time_ - var_163_23) / var_163_24
				local var_163_26 = Color.New(0, 0, 0)

				var_163_26.a = Mathf.Lerp(1, 0, var_163_25)
				arg_160_1.mask_.color = var_163_26
			end

			if arg_160_1.time_ >= var_163_23 + var_163_24 and arg_160_1.time_ < var_163_23 + var_163_24 + arg_163_0 then
				local var_163_27 = Color.New(0, 0, 0)
				local var_163_28 = 0

				arg_160_1.mask_.enabled = false
				var_163_27.a = var_163_28
				arg_160_1.mask_.color = var_163_27
			end

			local var_163_29 = arg_160_1.actors_["10176ui_story"].transform
			local var_163_30 = 1.96599999815226

			if var_163_30 < arg_160_1.time_ and arg_160_1.time_ <= var_163_30 + arg_163_0 then
				arg_160_1.var_.moveOldPos10176ui_story = var_163_29.localPosition

				local var_163_31 = GameObjectTools.GetOrAddComponent(var_163_29.gameObject, typeof(DynamicBoneHelper))

				if var_163_31 then
					var_163_31:EnableDynamicBone(false)
				end
			end

			local var_163_32 = 0.001

			if var_163_30 <= arg_160_1.time_ and arg_160_1.time_ < var_163_30 + var_163_32 then
				local var_163_33 = (arg_160_1.time_ - var_163_30) / var_163_32
				local var_163_34 = Vector3.New(0, 100, 0)

				var_163_29.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10176ui_story, var_163_34, var_163_33)

				local var_163_35 = manager.ui.mainCamera.transform.position - var_163_29.position

				var_163_29.forward = Vector3.New(var_163_35.x, var_163_35.y, var_163_35.z)

				local var_163_36 = var_163_29.localEulerAngles

				var_163_36.z = 0
				var_163_36.x = 0
				var_163_29.localEulerAngles = var_163_36
			end

			if arg_160_1.time_ >= var_163_30 + var_163_32 and arg_160_1.time_ < var_163_30 + var_163_32 + arg_163_0 then
				var_163_29.localPosition = Vector3.New(0, 100, 0)

				local var_163_37 = manager.ui.mainCamera.transform.position - var_163_29.position

				var_163_29.forward = Vector3.New(var_163_37.x, var_163_37.y, var_163_37.z)

				local var_163_38 = var_163_29.localEulerAngles

				var_163_38.z = 0
				var_163_38.x = 0
				var_163_29.localEulerAngles = var_163_38

				local var_163_39 = GameObjectTools.GetOrAddComponent(var_163_29.gameObject, typeof(DynamicBoneHelper))

				if var_163_39 then
					var_163_39:EnableDynamicBone(true)
				end
			end

			local var_163_40 = "10166ui_story"

			if arg_160_1.actors_[var_163_40] == nil then
				local var_163_41 = Asset.Load("Char/" .. "10166ui_story")

				if not isNil(var_163_41) then
					local var_163_42 = Object.Instantiate(Asset.Load("Char/" .. "10166ui_story"), arg_160_1.stage_.transform)

					var_163_42.name = var_163_40
					var_163_42.transform.localPosition = Vector3.New(0, 100, 0)
					arg_160_1.actors_[var_163_40] = var_163_42

					local var_163_43 = var_163_42:GetComponentInChildren(typeof(CharacterEffect))

					var_163_43.enabled = true

					local var_163_44 = GameObjectTools.GetOrAddComponent(var_163_42, typeof(DynamicBoneHelper))

					if var_163_44 then
						var_163_44:EnableDynamicBone(false)
					end

					arg_160_1:ShowWeapon(var_163_43.transform, false)

					arg_160_1.var_[var_163_40 .. "Animator"] = var_163_43.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_160_1.var_[var_163_40 .. "Animator"].applyRootMotion = true
					arg_160_1.var_[var_163_40 .. "LipSync"] = var_163_43.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_163_45 = arg_160_1.actors_["10166ui_story"].transform
			local var_163_46 = 3.8

			if var_163_46 < arg_160_1.time_ and arg_160_1.time_ <= var_163_46 + arg_163_0 then
				arg_160_1.var_.moveOldPos10166ui_story = var_163_45.localPosition

				local var_163_47 = GameObjectTools.GetOrAddComponent(var_163_45.gameObject, typeof(DynamicBoneHelper))

				if var_163_47 then
					var_163_47:EnableDynamicBone(false)
				end
			end

			local var_163_48 = 0.001

			if var_163_46 <= arg_160_1.time_ and arg_160_1.time_ < var_163_46 + var_163_48 then
				local var_163_49 = (arg_160_1.time_ - var_163_46) / var_163_48
				local var_163_50 = Vector3.New(0, -1.28, -5.73)

				var_163_45.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10166ui_story, var_163_50, var_163_49)

				local var_163_51 = manager.ui.mainCamera.transform.position - var_163_45.position

				var_163_45.forward = Vector3.New(var_163_51.x, var_163_51.y, var_163_51.z)

				local var_163_52 = var_163_45.localEulerAngles

				var_163_52.z = 0
				var_163_52.x = 0
				var_163_45.localEulerAngles = var_163_52
			end

			if arg_160_1.time_ >= var_163_46 + var_163_48 and arg_160_1.time_ < var_163_46 + var_163_48 + arg_163_0 then
				var_163_45.localPosition = Vector3.New(0, -1.28, -5.73)

				local var_163_53 = manager.ui.mainCamera.transform.position - var_163_45.position

				var_163_45.forward = Vector3.New(var_163_53.x, var_163_53.y, var_163_53.z)

				local var_163_54 = var_163_45.localEulerAngles

				var_163_54.z = 0
				var_163_54.x = 0
				var_163_45.localEulerAngles = var_163_54

				local var_163_55 = GameObjectTools.GetOrAddComponent(var_163_45.gameObject, typeof(DynamicBoneHelper))

				if var_163_55 then
					var_163_55:EnableDynamicBone(true)
				end
			end

			local var_163_56 = arg_160_1.actors_["10167ui_story"].transform
			local var_163_57 = 1.96599999815226

			if var_163_57 < arg_160_1.time_ and arg_160_1.time_ <= var_163_57 + arg_163_0 then
				arg_160_1.var_.moveOldPos10167ui_story = var_163_56.localPosition

				local var_163_58 = GameObjectTools.GetOrAddComponent(var_163_56.gameObject, typeof(DynamicBoneHelper))

				if var_163_58 then
					var_163_58:EnableDynamicBone(false)
				end
			end

			local var_163_59 = 0.001

			if var_163_57 <= arg_160_1.time_ and arg_160_1.time_ < var_163_57 + var_163_59 then
				local var_163_60 = (arg_160_1.time_ - var_163_57) / var_163_59
				local var_163_61 = Vector3.New(0, 100, 0)

				var_163_56.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10167ui_story, var_163_61, var_163_60)

				local var_163_62 = manager.ui.mainCamera.transform.position - var_163_56.position

				var_163_56.forward = Vector3.New(var_163_62.x, var_163_62.y, var_163_62.z)

				local var_163_63 = var_163_56.localEulerAngles

				var_163_63.z = 0
				var_163_63.x = 0
				var_163_56.localEulerAngles = var_163_63
			end

			if arg_160_1.time_ >= var_163_57 + var_163_59 and arg_160_1.time_ < var_163_57 + var_163_59 + arg_163_0 then
				var_163_56.localPosition = Vector3.New(0, 100, 0)

				local var_163_64 = manager.ui.mainCamera.transform.position - var_163_56.position

				var_163_56.forward = Vector3.New(var_163_64.x, var_163_64.y, var_163_64.z)

				local var_163_65 = var_163_56.localEulerAngles

				var_163_65.z = 0
				var_163_65.x = 0
				var_163_56.localEulerAngles = var_163_65

				local var_163_66 = GameObjectTools.GetOrAddComponent(var_163_56.gameObject, typeof(DynamicBoneHelper))

				if var_163_66 then
					var_163_66:EnableDynamicBone(true)
				end
			end

			local var_163_67 = arg_160_1.actors_["10166ui_story"]
			local var_163_68 = 3.8

			if var_163_68 < arg_160_1.time_ and arg_160_1.time_ <= var_163_68 + arg_163_0 and not isNil(var_163_67) and arg_160_1.var_.characterEffect10166ui_story == nil then
				arg_160_1.var_.characterEffect10166ui_story = var_163_67:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_69 = 0.200000002980232

			if var_163_68 <= arg_160_1.time_ and arg_160_1.time_ < var_163_68 + var_163_69 and not isNil(var_163_67) then
				local var_163_70 = (arg_160_1.time_ - var_163_68) / var_163_69

				if arg_160_1.var_.characterEffect10166ui_story and not isNil(var_163_67) then
					arg_160_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_68 + var_163_69 and arg_160_1.time_ < var_163_68 + var_163_69 + arg_163_0 and not isNil(var_163_67) and arg_160_1.var_.characterEffect10166ui_story then
				arg_160_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_163_71 = 3.8

			if var_163_71 < arg_160_1.time_ and arg_160_1.time_ <= var_163_71 + arg_163_0 then
				arg_160_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action3_1")
			end

			local var_163_72 = 3.8

			if var_163_72 < arg_160_1.time_ and arg_160_1.time_ <= var_163_72 + arg_163_0 then
				arg_160_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if arg_160_1.frameCnt_ <= 1 then
				arg_160_1.dialog_:SetActive(false)
			end

			local var_163_73 = 3.96599999815226
			local var_163_74 = 0.425

			if var_163_73 < arg_160_1.time_ and arg_160_1.time_ <= var_163_73 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				arg_160_1.dialog_:SetActive(true)

				arg_160_1.dialogCg_.alpha = 0

				local var_163_75 = LeanTween.value(arg_160_1.dialog_, 0, 1, 0.3)

				var_163_75:setOnUpdate(LuaHelper.FloatAction(function(arg_164_0)
					arg_160_1.dialogCg_.alpha = arg_164_0
				end))
				var_163_75:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_160_1.dialog_)
					var_163_75:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_160_1.duration_ = arg_160_1.duration_ + 0.3

				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_76 = arg_160_1:FormatText(StoryNameCfg[1530].name)

				arg_160_1.leftNameTxt_.text = var_163_76

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_77 = arg_160_1:GetWordFromCfg(325571041)
				local var_163_78 = arg_160_1:FormatText(var_163_77.content)

				arg_160_1.text_.text = var_163_78

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_79 = 17
				local var_163_80 = utf8.len(var_163_78)
				local var_163_81 = var_163_79 <= 0 and var_163_74 or var_163_74 * (var_163_80 / var_163_79)

				if var_163_81 > 0 and var_163_74 < var_163_81 then
					arg_160_1.talkMaxDuration = var_163_81
					var_163_73 = var_163_73 + 0.3

					if var_163_81 + var_163_73 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_81 + var_163_73
					end
				end

				arg_160_1.text_.text = var_163_78
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571041", "story_v_out_325571.awb") ~= 0 then
					local var_163_82 = manager.audio:GetVoiceLength("story_v_out_325571", "325571041", "story_v_out_325571.awb") / 1000

					if var_163_82 + var_163_73 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_82 + var_163_73
					end

					if var_163_77.prefab_name ~= "" and arg_160_1.actors_[var_163_77.prefab_name] ~= nil then
						local var_163_83 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_77.prefab_name].transform, "story_v_out_325571", "325571041", "story_v_out_325571.awb")

						arg_160_1:RecordAudio("325571041", var_163_83)
						arg_160_1:RecordAudio("325571041", var_163_83)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_325571", "325571041", "story_v_out_325571.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_325571", "325571041", "story_v_out_325571.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_84 = var_163_73 + 0.3
			local var_163_85 = math.max(var_163_74, arg_160_1.talkMaxDuration)

			if var_163_84 <= arg_160_1.time_ and arg_160_1.time_ < var_163_84 + var_163_85 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_84) / var_163_85

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_84 + var_163_85 and arg_160_1.time_ < var_163_84 + var_163_85 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play325571042 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 325571042
		arg_166_1.duration_ = 4.1

		local var_166_0 = {
			zh = 4.1,
			ja = 3.1
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
				arg_166_0:Play325571043(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0
			local var_169_1 = 0.35

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_2 = arg_166_1:FormatText(StoryNameCfg[1530].name)

				arg_166_1.leftNameTxt_.text = var_169_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_3 = arg_166_1:GetWordFromCfg(325571042)
				local var_169_4 = arg_166_1:FormatText(var_169_3.content)

				arg_166_1.text_.text = var_169_4

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 14
				local var_169_6 = utf8.len(var_169_4)
				local var_169_7 = var_169_5 <= 0 and var_169_1 or var_169_1 * (var_169_6 / var_169_5)

				if var_169_7 > 0 and var_169_1 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_0
					end
				end

				arg_166_1.text_.text = var_169_4
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571042", "story_v_out_325571.awb") ~= 0 then
					local var_169_8 = manager.audio:GetVoiceLength("story_v_out_325571", "325571042", "story_v_out_325571.awb") / 1000

					if var_169_8 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_8 + var_169_0
					end

					if var_169_3.prefab_name ~= "" and arg_166_1.actors_[var_169_3.prefab_name] ~= nil then
						local var_169_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_3.prefab_name].transform, "story_v_out_325571", "325571042", "story_v_out_325571.awb")

						arg_166_1:RecordAudio("325571042", var_169_9)
						arg_166_1:RecordAudio("325571042", var_169_9)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_325571", "325571042", "story_v_out_325571.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_325571", "325571042", "story_v_out_325571.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_10 = math.max(var_169_1, arg_166_1.talkMaxDuration)

			if var_169_0 <= arg_166_1.time_ and arg_166_1.time_ < var_169_0 + var_169_10 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_0) / var_169_10

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_0 + var_169_10 and arg_166_1.time_ < var_169_0 + var_169_10 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play325571043 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 325571043
		arg_170_1.duration_ = 4.2

		local var_170_0 = {
			zh = 3.2,
			ja = 4.2
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play325571044(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["10166ui_story"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect10166ui_story == nil then
				arg_170_1.var_.characterEffect10166ui_story = var_173_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.200000002980232

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.characterEffect10166ui_story and not isNil(var_173_0) then
					local var_173_4 = Mathf.Lerp(0, 0.5, var_173_3)

					arg_170_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_170_1.var_.characterEffect10166ui_story.fillRatio = var_173_4
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect10166ui_story then
				local var_173_5 = 0.5

				arg_170_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_170_1.var_.characterEffect10166ui_story.fillRatio = var_173_5
			end

			local var_173_6 = 0
			local var_173_7 = 0.325

			if var_173_6 < arg_170_1.time_ and arg_170_1.time_ <= var_173_6 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_8 = arg_170_1:FormatText(StoryNameCfg[1531].name)

				arg_170_1.leftNameTxt_.text = var_173_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10166")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_9 = arg_170_1:GetWordFromCfg(325571043)
				local var_173_10 = arg_170_1:FormatText(var_173_9.content)

				arg_170_1.text_.text = var_173_10

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_11 = 13
				local var_173_12 = utf8.len(var_173_10)
				local var_173_13 = var_173_11 <= 0 and var_173_7 or var_173_7 * (var_173_12 / var_173_11)

				if var_173_13 > 0 and var_173_7 < var_173_13 then
					arg_170_1.talkMaxDuration = var_173_13

					if var_173_13 + var_173_6 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_13 + var_173_6
					end
				end

				arg_170_1.text_.text = var_173_10
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571043", "story_v_out_325571.awb") ~= 0 then
					local var_173_14 = manager.audio:GetVoiceLength("story_v_out_325571", "325571043", "story_v_out_325571.awb") / 1000

					if var_173_14 + var_173_6 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_14 + var_173_6
					end

					if var_173_9.prefab_name ~= "" and arg_170_1.actors_[var_173_9.prefab_name] ~= nil then
						local var_173_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_9.prefab_name].transform, "story_v_out_325571", "325571043", "story_v_out_325571.awb")

						arg_170_1:RecordAudio("325571043", var_173_15)
						arg_170_1:RecordAudio("325571043", var_173_15)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_325571", "325571043", "story_v_out_325571.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_325571", "325571043", "story_v_out_325571.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_16 = math.max(var_173_7, arg_170_1.talkMaxDuration)

			if var_173_6 <= arg_170_1.time_ and arg_170_1.time_ < var_173_6 + var_173_16 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_6) / var_173_16

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_6 + var_173_16 and arg_170_1.time_ < var_173_6 + var_173_16 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play325571044 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 325571044
		arg_174_1.duration_ = 7.97

		local var_174_0 = {
			zh = 6.166,
			ja = 7.966
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
				arg_174_0:Play325571045(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["10166ui_story"].transform
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.var_.moveOldPos10166ui_story = var_177_0.localPosition

				local var_177_2 = GameObjectTools.GetOrAddComponent(var_177_0.gameObject, typeof(DynamicBoneHelper))

				if var_177_2 then
					var_177_2:EnableDynamicBone(false)
				end
			end

			local var_177_3 = 0.001

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_3 then
				local var_177_4 = (arg_174_1.time_ - var_177_1) / var_177_3
				local var_177_5 = Vector3.New(0, 100, 0)

				var_177_0.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10166ui_story, var_177_5, var_177_4)

				local var_177_6 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_6.x, var_177_6.y, var_177_6.z)

				local var_177_7 = var_177_0.localEulerAngles

				var_177_7.z = 0
				var_177_7.x = 0
				var_177_0.localEulerAngles = var_177_7
			end

			if arg_174_1.time_ >= var_177_1 + var_177_3 and arg_174_1.time_ < var_177_1 + var_177_3 + arg_177_0 then
				var_177_0.localPosition = Vector3.New(0, 100, 0)

				local var_177_8 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_8.x, var_177_8.y, var_177_8.z)

				local var_177_9 = var_177_0.localEulerAngles

				var_177_9.z = 0
				var_177_9.x = 0
				var_177_0.localEulerAngles = var_177_9

				local var_177_10 = GameObjectTools.GetOrAddComponent(var_177_0.gameObject, typeof(DynamicBoneHelper))

				if var_177_10 then
					var_177_10:EnableDynamicBone(true)
				end
			end

			local var_177_11 = "10162ui_story"

			if arg_174_1.actors_[var_177_11] == nil then
				local var_177_12 = Asset.Load("Char/" .. "10162ui_story")

				if not isNil(var_177_12) then
					local var_177_13 = Object.Instantiate(Asset.Load("Char/" .. "10162ui_story"), arg_174_1.stage_.transform)

					var_177_13.name = var_177_11
					var_177_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_174_1.actors_[var_177_11] = var_177_13

					local var_177_14 = var_177_13:GetComponentInChildren(typeof(CharacterEffect))

					var_177_14.enabled = true

					local var_177_15 = GameObjectTools.GetOrAddComponent(var_177_13, typeof(DynamicBoneHelper))

					if var_177_15 then
						var_177_15:EnableDynamicBone(false)
					end

					arg_174_1:ShowWeapon(var_177_14.transform, false)

					arg_174_1.var_[var_177_11 .. "Animator"] = var_177_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_174_1.var_[var_177_11 .. "Animator"].applyRootMotion = true
					arg_174_1.var_[var_177_11 .. "LipSync"] = var_177_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_177_16 = arg_174_1.actors_["10162ui_story"].transform
			local var_177_17 = 0

			if var_177_17 < arg_174_1.time_ and arg_174_1.time_ <= var_177_17 + arg_177_0 then
				arg_174_1.var_.moveOldPos10162ui_story = var_177_16.localPosition

				local var_177_18 = GameObjectTools.GetOrAddComponent(var_177_16.gameObject, typeof(DynamicBoneHelper))

				if var_177_18 then
					var_177_18:EnableDynamicBone(false)
				end
			end

			local var_177_19 = 0.001

			if var_177_17 <= arg_174_1.time_ and arg_174_1.time_ < var_177_17 + var_177_19 then
				local var_177_20 = (arg_174_1.time_ - var_177_17) / var_177_19
				local var_177_21 = Vector3.New(0, -1.08, -5.83)

				var_177_16.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10162ui_story, var_177_21, var_177_20)

				local var_177_22 = manager.ui.mainCamera.transform.position - var_177_16.position

				var_177_16.forward = Vector3.New(var_177_22.x, var_177_22.y, var_177_22.z)

				local var_177_23 = var_177_16.localEulerAngles

				var_177_23.z = 0
				var_177_23.x = 0
				var_177_16.localEulerAngles = var_177_23
			end

			if arg_174_1.time_ >= var_177_17 + var_177_19 and arg_174_1.time_ < var_177_17 + var_177_19 + arg_177_0 then
				var_177_16.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_177_24 = manager.ui.mainCamera.transform.position - var_177_16.position

				var_177_16.forward = Vector3.New(var_177_24.x, var_177_24.y, var_177_24.z)

				local var_177_25 = var_177_16.localEulerAngles

				var_177_25.z = 0
				var_177_25.x = 0
				var_177_16.localEulerAngles = var_177_25

				local var_177_26 = GameObjectTools.GetOrAddComponent(var_177_16.gameObject, typeof(DynamicBoneHelper))

				if var_177_26 then
					var_177_26:EnableDynamicBone(true)
				end
			end

			local var_177_27 = arg_174_1.actors_["10162ui_story"]
			local var_177_28 = 0

			if var_177_28 < arg_174_1.time_ and arg_174_1.time_ <= var_177_28 + arg_177_0 and not isNil(var_177_27) and arg_174_1.var_.characterEffect10162ui_story == nil then
				arg_174_1.var_.characterEffect10162ui_story = var_177_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_29 = 0.200000002980232

			if var_177_28 <= arg_174_1.time_ and arg_174_1.time_ < var_177_28 + var_177_29 and not isNil(var_177_27) then
				local var_177_30 = (arg_174_1.time_ - var_177_28) / var_177_29

				if arg_174_1.var_.characterEffect10162ui_story and not isNil(var_177_27) then
					arg_174_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= var_177_28 + var_177_29 and arg_174_1.time_ < var_177_28 + var_177_29 + arg_177_0 and not isNil(var_177_27) and arg_174_1.var_.characterEffect10162ui_story then
				arg_174_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_177_31 = arg_174_1.actors_["10166ui_story"]
			local var_177_32 = 0

			if var_177_32 < arg_174_1.time_ and arg_174_1.time_ <= var_177_32 + arg_177_0 and not isNil(var_177_31) and arg_174_1.var_.characterEffect10166ui_story == nil then
				arg_174_1.var_.characterEffect10166ui_story = var_177_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_33 = 0.200000002980232

			if var_177_32 <= arg_174_1.time_ and arg_174_1.time_ < var_177_32 + var_177_33 and not isNil(var_177_31) then
				local var_177_34 = (arg_174_1.time_ - var_177_32) / var_177_33

				if arg_174_1.var_.characterEffect10166ui_story and not isNil(var_177_31) then
					local var_177_35 = Mathf.Lerp(0, 0.5, var_177_34)

					arg_174_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_174_1.var_.characterEffect10166ui_story.fillRatio = var_177_35
				end
			end

			if arg_174_1.time_ >= var_177_32 + var_177_33 and arg_174_1.time_ < var_177_32 + var_177_33 + arg_177_0 and not isNil(var_177_31) and arg_174_1.var_.characterEffect10166ui_story then
				local var_177_36 = 0.5

				arg_174_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_174_1.var_.characterEffect10166ui_story.fillRatio = var_177_36
			end

			local var_177_37 = 0

			if var_177_37 < arg_174_1.time_ and arg_174_1.time_ <= var_177_37 + arg_177_0 then
				arg_174_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_1")
			end

			local var_177_38 = 0

			if var_177_38 < arg_174_1.time_ and arg_174_1.time_ <= var_177_38 + arg_177_0 then
				arg_174_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_177_39 = 0
			local var_177_40 = 0.625

			if var_177_39 < arg_174_1.time_ and arg_174_1.time_ <= var_177_39 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_41 = arg_174_1:FormatText(StoryNameCfg[1532].name)

				arg_174_1.leftNameTxt_.text = var_177_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_42 = arg_174_1:GetWordFromCfg(325571044)
				local var_177_43 = arg_174_1:FormatText(var_177_42.content)

				arg_174_1.text_.text = var_177_43

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_44 = 25
				local var_177_45 = utf8.len(var_177_43)
				local var_177_46 = var_177_44 <= 0 and var_177_40 or var_177_40 * (var_177_45 / var_177_44)

				if var_177_46 > 0 and var_177_40 < var_177_46 then
					arg_174_1.talkMaxDuration = var_177_46

					if var_177_46 + var_177_39 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_46 + var_177_39
					end
				end

				arg_174_1.text_.text = var_177_43
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571044", "story_v_out_325571.awb") ~= 0 then
					local var_177_47 = manager.audio:GetVoiceLength("story_v_out_325571", "325571044", "story_v_out_325571.awb") / 1000

					if var_177_47 + var_177_39 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_47 + var_177_39
					end

					if var_177_42.prefab_name ~= "" and arg_174_1.actors_[var_177_42.prefab_name] ~= nil then
						local var_177_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_42.prefab_name].transform, "story_v_out_325571", "325571044", "story_v_out_325571.awb")

						arg_174_1:RecordAudio("325571044", var_177_48)
						arg_174_1:RecordAudio("325571044", var_177_48)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_325571", "325571044", "story_v_out_325571.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_325571", "325571044", "story_v_out_325571.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_49 = math.max(var_177_40, arg_174_1.talkMaxDuration)

			if var_177_39 <= arg_174_1.time_ and arg_174_1.time_ < var_177_39 + var_177_49 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_39) / var_177_49

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_39 + var_177_49 and arg_174_1.time_ < var_177_39 + var_177_49 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play325571045 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 325571045
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play325571046(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["10162ui_story"].transform
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.var_.moveOldPos10162ui_story = var_181_0.localPosition

				local var_181_2 = GameObjectTools.GetOrAddComponent(var_181_0.gameObject, typeof(DynamicBoneHelper))

				if var_181_2 then
					var_181_2:EnableDynamicBone(false)
				end
			end

			local var_181_3 = 0.001

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_3 then
				local var_181_4 = (arg_178_1.time_ - var_181_1) / var_181_3
				local var_181_5 = Vector3.New(0, 100, 0)

				var_181_0.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10162ui_story, var_181_5, var_181_4)

				local var_181_6 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_6.x, var_181_6.y, var_181_6.z)

				local var_181_7 = var_181_0.localEulerAngles

				var_181_7.z = 0
				var_181_7.x = 0
				var_181_0.localEulerAngles = var_181_7
			end

			if arg_178_1.time_ >= var_181_1 + var_181_3 and arg_178_1.time_ < var_181_1 + var_181_3 + arg_181_0 then
				var_181_0.localPosition = Vector3.New(0, 100, 0)

				local var_181_8 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_8.x, var_181_8.y, var_181_8.z)

				local var_181_9 = var_181_0.localEulerAngles

				var_181_9.z = 0
				var_181_9.x = 0
				var_181_0.localEulerAngles = var_181_9

				local var_181_10 = GameObjectTools.GetOrAddComponent(var_181_0.gameObject, typeof(DynamicBoneHelper))

				if var_181_10 then
					var_181_10:EnableDynamicBone(true)
				end
			end

			local var_181_11 = arg_178_1.actors_["10162ui_story"]
			local var_181_12 = 0

			if var_181_12 < arg_178_1.time_ and arg_178_1.time_ <= var_181_12 + arg_181_0 and not isNil(var_181_11) and arg_178_1.var_.characterEffect10162ui_story == nil then
				arg_178_1.var_.characterEffect10162ui_story = var_181_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_13 = 0.200000002980232

			if var_181_12 <= arg_178_1.time_ and arg_178_1.time_ < var_181_12 + var_181_13 and not isNil(var_181_11) then
				local var_181_14 = (arg_178_1.time_ - var_181_12) / var_181_13

				if arg_178_1.var_.characterEffect10162ui_story and not isNil(var_181_11) then
					local var_181_15 = Mathf.Lerp(0, 0.5, var_181_14)

					arg_178_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_178_1.var_.characterEffect10162ui_story.fillRatio = var_181_15
				end
			end

			if arg_178_1.time_ >= var_181_12 + var_181_13 and arg_178_1.time_ < var_181_12 + var_181_13 + arg_181_0 and not isNil(var_181_11) and arg_178_1.var_.characterEffect10162ui_story then
				local var_181_16 = 0.5

				arg_178_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_178_1.var_.characterEffect10162ui_story.fillRatio = var_181_16
			end

			local var_181_17 = 0
			local var_181_18 = 1.05

			if var_181_17 < arg_178_1.time_ and arg_178_1.time_ <= var_181_17 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_19 = arg_178_1:GetWordFromCfg(325571045)
				local var_181_20 = arg_178_1:FormatText(var_181_19.content)

				arg_178_1.text_.text = var_181_20

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_21 = 42
				local var_181_22 = utf8.len(var_181_20)
				local var_181_23 = var_181_21 <= 0 and var_181_18 or var_181_18 * (var_181_22 / var_181_21)

				if var_181_23 > 0 and var_181_18 < var_181_23 then
					arg_178_1.talkMaxDuration = var_181_23

					if var_181_23 + var_181_17 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_23 + var_181_17
					end
				end

				arg_178_1.text_.text = var_181_20
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_24 = math.max(var_181_18, arg_178_1.talkMaxDuration)

			if var_181_17 <= arg_178_1.time_ and arg_178_1.time_ < var_181_17 + var_181_24 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_17) / var_181_24

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_17 + var_181_24 and arg_178_1.time_ < var_181_17 + var_181_24 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play325571046 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 325571046
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play325571047(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0
			local var_185_1 = 1.725

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_2 = arg_182_1:GetWordFromCfg(325571046)
				local var_185_3 = arg_182_1:FormatText(var_185_2.content)

				arg_182_1.text_.text = var_185_3

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_4 = 69
				local var_185_5 = utf8.len(var_185_3)
				local var_185_6 = var_185_4 <= 0 and var_185_1 or var_185_1 * (var_185_5 / var_185_4)

				if var_185_6 > 0 and var_185_1 < var_185_6 then
					arg_182_1.talkMaxDuration = var_185_6

					if var_185_6 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_6 + var_185_0
					end
				end

				arg_182_1.text_.text = var_185_3
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_7 = math.max(var_185_1, arg_182_1.talkMaxDuration)

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_7 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_0) / var_185_7

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_0 + var_185_7 and arg_182_1.time_ < var_185_0 + var_185_7 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play325571047 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 325571047
		arg_186_1.duration_ = 6.63

		local var_186_0 = {
			zh = 6.633,
			ja = 5.833
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
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play325571048(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["10166ui_story"].transform
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1.var_.moveOldPos10166ui_story = var_189_0.localPosition

				local var_189_2 = GameObjectTools.GetOrAddComponent(var_189_0.gameObject, typeof(DynamicBoneHelper))

				if var_189_2 then
					var_189_2:EnableDynamicBone(false)
				end
			end

			local var_189_3 = 0.001

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_3 then
				local var_189_4 = (arg_186_1.time_ - var_189_1) / var_189_3
				local var_189_5 = Vector3.New(0, -1.28, -5.73)

				var_189_0.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10166ui_story, var_189_5, var_189_4)

				local var_189_6 = manager.ui.mainCamera.transform.position - var_189_0.position

				var_189_0.forward = Vector3.New(var_189_6.x, var_189_6.y, var_189_6.z)

				local var_189_7 = var_189_0.localEulerAngles

				var_189_7.z = 0
				var_189_7.x = 0
				var_189_0.localEulerAngles = var_189_7
			end

			if arg_186_1.time_ >= var_189_1 + var_189_3 and arg_186_1.time_ < var_189_1 + var_189_3 + arg_189_0 then
				var_189_0.localPosition = Vector3.New(0, -1.28, -5.73)

				local var_189_8 = manager.ui.mainCamera.transform.position - var_189_0.position

				var_189_0.forward = Vector3.New(var_189_8.x, var_189_8.y, var_189_8.z)

				local var_189_9 = var_189_0.localEulerAngles

				var_189_9.z = 0
				var_189_9.x = 0
				var_189_0.localEulerAngles = var_189_9

				local var_189_10 = GameObjectTools.GetOrAddComponent(var_189_0.gameObject, typeof(DynamicBoneHelper))

				if var_189_10 then
					var_189_10:EnableDynamicBone(true)
				end
			end

			local var_189_11 = arg_186_1.actors_["10166ui_story"]
			local var_189_12 = 0

			if var_189_12 < arg_186_1.time_ and arg_186_1.time_ <= var_189_12 + arg_189_0 and not isNil(var_189_11) and arg_186_1.var_.characterEffect10166ui_story == nil then
				arg_186_1.var_.characterEffect10166ui_story = var_189_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_13 = 0.200000002980232

			if var_189_12 <= arg_186_1.time_ and arg_186_1.time_ < var_189_12 + var_189_13 and not isNil(var_189_11) then
				local var_189_14 = (arg_186_1.time_ - var_189_12) / var_189_13

				if arg_186_1.var_.characterEffect10166ui_story and not isNil(var_189_11) then
					arg_186_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_12 + var_189_13 and arg_186_1.time_ < var_189_12 + var_189_13 + arg_189_0 and not isNil(var_189_11) and arg_186_1.var_.characterEffect10166ui_story then
				arg_186_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_189_15 = 0

			if var_189_15 < arg_186_1.time_ and arg_186_1.time_ <= var_189_15 + arg_189_0 then
				arg_186_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action3_2")
			end

			local var_189_16 = 0

			if var_189_16 < arg_186_1.time_ and arg_186_1.time_ <= var_189_16 + arg_189_0 then
				arg_186_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_189_17 = 0
			local var_189_18 = 0.325

			if var_189_17 < arg_186_1.time_ and arg_186_1.time_ <= var_189_17 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_19 = arg_186_1:FormatText(StoryNameCfg[1530].name)

				arg_186_1.leftNameTxt_.text = var_189_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_20 = arg_186_1:GetWordFromCfg(325571047)
				local var_189_21 = arg_186_1:FormatText(var_189_20.content)

				arg_186_1.text_.text = var_189_21

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_22 = 13
				local var_189_23 = utf8.len(var_189_21)
				local var_189_24 = var_189_22 <= 0 and var_189_18 or var_189_18 * (var_189_23 / var_189_22)

				if var_189_24 > 0 and var_189_18 < var_189_24 then
					arg_186_1.talkMaxDuration = var_189_24

					if var_189_24 + var_189_17 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_24 + var_189_17
					end
				end

				arg_186_1.text_.text = var_189_21
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571047", "story_v_out_325571.awb") ~= 0 then
					local var_189_25 = manager.audio:GetVoiceLength("story_v_out_325571", "325571047", "story_v_out_325571.awb") / 1000

					if var_189_25 + var_189_17 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_25 + var_189_17
					end

					if var_189_20.prefab_name ~= "" and arg_186_1.actors_[var_189_20.prefab_name] ~= nil then
						local var_189_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_20.prefab_name].transform, "story_v_out_325571", "325571047", "story_v_out_325571.awb")

						arg_186_1:RecordAudio("325571047", var_189_26)
						arg_186_1:RecordAudio("325571047", var_189_26)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_325571", "325571047", "story_v_out_325571.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_325571", "325571047", "story_v_out_325571.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_27 = math.max(var_189_18, arg_186_1.talkMaxDuration)

			if var_189_17 <= arg_186_1.time_ and arg_186_1.time_ < var_189_17 + var_189_27 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_17) / var_189_27

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_17 + var_189_27 and arg_186_1.time_ < var_189_17 + var_189_27 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
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
	Play325571048 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 325571048
		arg_190_1.duration_ = 5.63

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play325571049(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["10166ui_story"].transform
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.var_.moveOldPos10166ui_story = var_193_0.localPosition

				local var_193_2 = GameObjectTools.GetOrAddComponent(var_193_0.gameObject, typeof(DynamicBoneHelper))

				if var_193_2 then
					var_193_2:EnableDynamicBone(false)
				end
			end

			local var_193_3 = 0.001

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_3 then
				local var_193_4 = (arg_190_1.time_ - var_193_1) / var_193_3
				local var_193_5 = Vector3.New(0, 100, 0)

				var_193_0.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos10166ui_story, var_193_5, var_193_4)

				local var_193_6 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_6.x, var_193_6.y, var_193_6.z)

				local var_193_7 = var_193_0.localEulerAngles

				var_193_7.z = 0
				var_193_7.x = 0
				var_193_0.localEulerAngles = var_193_7
			end

			if arg_190_1.time_ >= var_193_1 + var_193_3 and arg_190_1.time_ < var_193_1 + var_193_3 + arg_193_0 then
				var_193_0.localPosition = Vector3.New(0, 100, 0)

				local var_193_8 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_8.x, var_193_8.y, var_193_8.z)

				local var_193_9 = var_193_0.localEulerAngles

				var_193_9.z = 0
				var_193_9.x = 0
				var_193_0.localEulerAngles = var_193_9

				local var_193_10 = GameObjectTools.GetOrAddComponent(var_193_0.gameObject, typeof(DynamicBoneHelper))

				if var_193_10 then
					var_193_10:EnableDynamicBone(true)
				end
			end

			local var_193_11 = arg_190_1.actors_["10166ui_story"]
			local var_193_12 = 0

			if var_193_12 < arg_190_1.time_ and arg_190_1.time_ <= var_193_12 + arg_193_0 and not isNil(var_193_11) and arg_190_1.var_.characterEffect10166ui_story == nil then
				arg_190_1.var_.characterEffect10166ui_story = var_193_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_13 = 0.200000002980232

			if var_193_12 <= arg_190_1.time_ and arg_190_1.time_ < var_193_12 + var_193_13 and not isNil(var_193_11) then
				local var_193_14 = (arg_190_1.time_ - var_193_12) / var_193_13

				if arg_190_1.var_.characterEffect10166ui_story and not isNil(var_193_11) then
					local var_193_15 = Mathf.Lerp(0, 0.5, var_193_14)

					arg_190_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_190_1.var_.characterEffect10166ui_story.fillRatio = var_193_15
				end
			end

			if arg_190_1.time_ >= var_193_12 + var_193_13 and arg_190_1.time_ < var_193_12 + var_193_13 + arg_193_0 and not isNil(var_193_11) and arg_190_1.var_.characterEffect10166ui_story then
				local var_193_16 = 0.5

				arg_190_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_190_1.var_.characterEffect10166ui_story.fillRatio = var_193_16
			end

			local var_193_17 = manager.ui.mainCamera.transform
			local var_193_18 = 0

			if var_193_18 < arg_190_1.time_ and arg_190_1.time_ <= var_193_18 + arg_193_0 then
				local var_193_19 = arg_190_1.var_.effectshuaijiao1
				local var_193_20
				local var_193_21 = var_193_17

				if not var_193_19 then
					var_193_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), var_193_21)
					var_193_19.name = "shuaijiao1"
					arg_190_1.var_.effectshuaijiao1 = var_193_19
				else
					var_193_19.transform:SetParent(var_193_21)
				end

				var_193_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_193_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_193_22 = manager.ui.mainCamera.transform
			local var_193_23 = 2.16666666666667

			if var_193_23 < arg_190_1.time_ and arg_190_1.time_ <= var_193_23 + arg_193_0 then
				local var_193_24 = arg_190_1.var_.effectshuaijiao1

				if var_193_24 then
					Object.Destroy(var_193_24)

					arg_190_1.var_.effectshuaijiao1 = nil
				end
			end

			local var_193_25 = arg_190_1.bgs_.J21h.transform
			local var_193_26 = 0

			if var_193_26 < arg_190_1.time_ and arg_190_1.time_ <= var_193_26 + arg_193_0 then
				arg_190_1.var_.moveOldPosJ21h = var_193_25.localPosition
			end

			local var_193_27 = 0.633333333333333

			if var_193_26 <= arg_190_1.time_ and arg_190_1.time_ < var_193_26 + var_193_27 then
				local var_193_28 = (arg_190_1.time_ - var_193_26) / var_193_27
				local var_193_29 = Vector3.New(0, 1, 9.5)

				var_193_25.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPosJ21h, var_193_29, var_193_28)
			end

			if arg_190_1.time_ >= var_193_26 + var_193_27 and arg_190_1.time_ < var_193_26 + var_193_27 + arg_193_0 then
				var_193_25.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_193_30 = 0

			if var_193_30 < arg_190_1.time_ and arg_190_1.time_ <= var_193_30 + arg_193_0 then
				arg_190_1.allBtn_.enabled = false
			end

			local var_193_31 = 2.16666666666667

			if arg_190_1.time_ >= var_193_30 + var_193_31 and arg_190_1.time_ < var_193_30 + var_193_31 + arg_193_0 then
				arg_190_1.allBtn_.enabled = true
			end

			local var_193_32 = 0.1
			local var_193_33 = 1

			if var_193_32 < arg_190_1.time_ and arg_190_1.time_ <= var_193_32 + arg_193_0 then
				local var_193_34 = "play"
				local var_193_35 = "effect"

				arg_190_1:AudioAction(var_193_34, var_193_35, "se_story_131", "se_story_131__fallmetal", "")
			end

			if arg_190_1.frameCnt_ <= 1 then
				arg_190_1.dialog_:SetActive(false)
			end

			local var_193_36 = 0.633333333333333
			local var_193_37 = 1.525

			if var_193_36 < arg_190_1.time_ and arg_190_1.time_ <= var_193_36 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0

				arg_190_1.dialog_:SetActive(true)

				arg_190_1.dialogCg_.alpha = 0

				local var_193_38 = LeanTween.value(arg_190_1.dialog_, 0, 1, 0.3)

				var_193_38:setOnUpdate(LuaHelper.FloatAction(function(arg_194_0)
					arg_190_1.dialogCg_.alpha = arg_194_0
				end))
				var_193_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_190_1.dialog_)
					var_193_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_190_1.duration_ = arg_190_1.duration_ + 0.3

				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_39 = arg_190_1:GetWordFromCfg(325571048)
				local var_193_40 = arg_190_1:FormatText(var_193_39.content)

				arg_190_1.text_.text = var_193_40

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_41 = 61
				local var_193_42 = utf8.len(var_193_40)
				local var_193_43 = var_193_41 <= 0 and var_193_37 or var_193_37 * (var_193_42 / var_193_41)

				if var_193_43 > 0 and var_193_37 < var_193_43 then
					arg_190_1.talkMaxDuration = var_193_43
					var_193_36 = var_193_36 + 0.3

					if var_193_43 + var_193_36 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_43 + var_193_36
					end
				end

				arg_190_1.text_.text = var_193_40
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_44 = var_193_36 + 0.3
			local var_193_45 = math.max(var_193_37, arg_190_1.talkMaxDuration)

			if var_193_44 <= arg_190_1.time_ and arg_190_1.time_ < var_193_44 + var_193_45 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_44) / var_193_45

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_44 + var_193_45 and arg_190_1.time_ < var_193_44 + var_193_45 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
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
				actorName = "J21h",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.633333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play325571049 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 325571049
		arg_196_1.duration_ = 2.83

		local var_196_0 = {
			zh = 1.999999999999,
			ja = 2.833
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play325571050(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["10166ui_story"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos10166ui_story = var_199_0.localPosition

				local var_199_2 = GameObjectTools.GetOrAddComponent(var_199_0.gameObject, typeof(DynamicBoneHelper))

				if var_199_2 then
					var_199_2:EnableDynamicBone(false)
				end
			end

			local var_199_3 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_3 then
				local var_199_4 = (arg_196_1.time_ - var_199_1) / var_199_3
				local var_199_5 = Vector3.New(0, -1.28, -5.73)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10166ui_story, var_199_5, var_199_4)

				local var_199_6 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_6.x, var_199_6.y, var_199_6.z)

				local var_199_7 = var_199_0.localEulerAngles

				var_199_7.z = 0
				var_199_7.x = 0
				var_199_0.localEulerAngles = var_199_7
			end

			if arg_196_1.time_ >= var_199_1 + var_199_3 and arg_196_1.time_ < var_199_1 + var_199_3 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(0, -1.28, -5.73)

				local var_199_8 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_8.x, var_199_8.y, var_199_8.z)

				local var_199_9 = var_199_0.localEulerAngles

				var_199_9.z = 0
				var_199_9.x = 0
				var_199_0.localEulerAngles = var_199_9

				local var_199_10 = GameObjectTools.GetOrAddComponent(var_199_0.gameObject, typeof(DynamicBoneHelper))

				if var_199_10 then
					var_199_10:EnableDynamicBone(true)
				end
			end

			local var_199_11 = arg_196_1.actors_["10166ui_story"]
			local var_199_12 = 0

			if var_199_12 < arg_196_1.time_ and arg_196_1.time_ <= var_199_12 + arg_199_0 and not isNil(var_199_11) and arg_196_1.var_.characterEffect10166ui_story == nil then
				arg_196_1.var_.characterEffect10166ui_story = var_199_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_13 = 0.200000002980232

			if var_199_12 <= arg_196_1.time_ and arg_196_1.time_ < var_199_12 + var_199_13 and not isNil(var_199_11) then
				local var_199_14 = (arg_196_1.time_ - var_199_12) / var_199_13

				if arg_196_1.var_.characterEffect10166ui_story and not isNil(var_199_11) then
					arg_196_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= var_199_12 + var_199_13 and arg_196_1.time_ < var_199_12 + var_199_13 + arg_199_0 and not isNil(var_199_11) and arg_196_1.var_.characterEffect10166ui_story then
				arg_196_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_199_15 = 0

			if var_199_15 < arg_196_1.time_ and arg_196_1.time_ <= var_199_15 + arg_199_0 then
				arg_196_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_1")
			end

			local var_199_16 = 0

			if var_199_16 < arg_196_1.time_ and arg_196_1.time_ <= var_199_16 + arg_199_0 then
				arg_196_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_199_17 = 0
			local var_199_18 = 0.2

			if var_199_17 < arg_196_1.time_ and arg_196_1.time_ <= var_199_17 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_19 = arg_196_1:FormatText(StoryNameCfg[1530].name)

				arg_196_1.leftNameTxt_.text = var_199_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_20 = arg_196_1:GetWordFromCfg(325571049)
				local var_199_21 = arg_196_1:FormatText(var_199_20.content)

				arg_196_1.text_.text = var_199_21

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_22 = 8
				local var_199_23 = utf8.len(var_199_21)
				local var_199_24 = var_199_22 <= 0 and var_199_18 or var_199_18 * (var_199_23 / var_199_22)

				if var_199_24 > 0 and var_199_18 < var_199_24 then
					arg_196_1.talkMaxDuration = var_199_24

					if var_199_24 + var_199_17 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_24 + var_199_17
					end
				end

				arg_196_1.text_.text = var_199_21
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571049", "story_v_out_325571.awb") ~= 0 then
					local var_199_25 = manager.audio:GetVoiceLength("story_v_out_325571", "325571049", "story_v_out_325571.awb") / 1000

					if var_199_25 + var_199_17 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_25 + var_199_17
					end

					if var_199_20.prefab_name ~= "" and arg_196_1.actors_[var_199_20.prefab_name] ~= nil then
						local var_199_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_20.prefab_name].transform, "story_v_out_325571", "325571049", "story_v_out_325571.awb")

						arg_196_1:RecordAudio("325571049", var_199_26)
						arg_196_1:RecordAudio("325571049", var_199_26)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_325571", "325571049", "story_v_out_325571.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_325571", "325571049", "story_v_out_325571.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_27 = math.max(var_199_18, arg_196_1.talkMaxDuration)

			if var_199_17 <= arg_196_1.time_ and arg_196_1.time_ < var_199_17 + var_199_27 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_17) / var_199_27

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_17 + var_199_27 and arg_196_1.time_ < var_199_17 + var_199_27 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play325571050 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 325571050
		arg_200_1.duration_ = 10.57

		local var_200_0 = {
			zh = 10.1,
			ja = 10.566
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play325571051(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["10166ui_story"].transform
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.var_.moveOldPos10166ui_story = var_203_0.localPosition

				local var_203_2 = GameObjectTools.GetOrAddComponent(var_203_0.gameObject, typeof(DynamicBoneHelper))

				if var_203_2 then
					var_203_2:EnableDynamicBone(false)
				end
			end

			local var_203_3 = 0.001

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_3 then
				local var_203_4 = (arg_200_1.time_ - var_203_1) / var_203_3
				local var_203_5 = Vector3.New(-0.96, -1.28, -5.73)

				var_203_0.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10166ui_story, var_203_5, var_203_4)

				local var_203_6 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_6.x, var_203_6.y, var_203_6.z)

				local var_203_7 = var_203_0.localEulerAngles

				var_203_7.z = 0
				var_203_7.x = 0
				var_203_0.localEulerAngles = var_203_7
			end

			if arg_200_1.time_ >= var_203_1 + var_203_3 and arg_200_1.time_ < var_203_1 + var_203_3 + arg_203_0 then
				var_203_0.localPosition = Vector3.New(-0.96, -1.28, -5.73)

				local var_203_8 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_8.x, var_203_8.y, var_203_8.z)

				local var_203_9 = var_203_0.localEulerAngles

				var_203_9.z = 0
				var_203_9.x = 0
				var_203_0.localEulerAngles = var_203_9

				local var_203_10 = GameObjectTools.GetOrAddComponent(var_203_0.gameObject, typeof(DynamicBoneHelper))

				if var_203_10 then
					var_203_10:EnableDynamicBone(true)
				end
			end

			local var_203_11 = arg_200_1.actors_["10162ui_story"].transform
			local var_203_12 = 0

			if var_203_12 < arg_200_1.time_ and arg_200_1.time_ <= var_203_12 + arg_203_0 then
				arg_200_1.var_.moveOldPos10162ui_story = var_203_11.localPosition

				local var_203_13 = GameObjectTools.GetOrAddComponent(var_203_11.gameObject, typeof(DynamicBoneHelper))

				if var_203_13 then
					var_203_13:EnableDynamicBone(false)
				end
			end

			local var_203_14 = 0.001

			if var_203_12 <= arg_200_1.time_ and arg_200_1.time_ < var_203_12 + var_203_14 then
				local var_203_15 = (arg_200_1.time_ - var_203_12) / var_203_14
				local var_203_16 = Vector3.New(0.7, -1.08, -5.83)

				var_203_11.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10162ui_story, var_203_16, var_203_15)

				local var_203_17 = manager.ui.mainCamera.transform.position - var_203_11.position

				var_203_11.forward = Vector3.New(var_203_17.x, var_203_17.y, var_203_17.z)

				local var_203_18 = var_203_11.localEulerAngles

				var_203_18.z = 0
				var_203_18.x = 0
				var_203_11.localEulerAngles = var_203_18
			end

			if arg_200_1.time_ >= var_203_12 + var_203_14 and arg_200_1.time_ < var_203_12 + var_203_14 + arg_203_0 then
				var_203_11.localPosition = Vector3.New(0.7, -1.08, -5.83)

				local var_203_19 = manager.ui.mainCamera.transform.position - var_203_11.position

				var_203_11.forward = Vector3.New(var_203_19.x, var_203_19.y, var_203_19.z)

				local var_203_20 = var_203_11.localEulerAngles

				var_203_20.z = 0
				var_203_20.x = 0
				var_203_11.localEulerAngles = var_203_20

				local var_203_21 = GameObjectTools.GetOrAddComponent(var_203_11.gameObject, typeof(DynamicBoneHelper))

				if var_203_21 then
					var_203_21:EnableDynamicBone(true)
				end
			end

			local var_203_22 = arg_200_1.actors_["10162ui_story"]
			local var_203_23 = 0

			if var_203_23 < arg_200_1.time_ and arg_200_1.time_ <= var_203_23 + arg_203_0 and not isNil(var_203_22) and arg_200_1.var_.characterEffect10162ui_story == nil then
				arg_200_1.var_.characterEffect10162ui_story = var_203_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_24 = 0.200000002980232

			if var_203_23 <= arg_200_1.time_ and arg_200_1.time_ < var_203_23 + var_203_24 and not isNil(var_203_22) then
				local var_203_25 = (arg_200_1.time_ - var_203_23) / var_203_24

				if arg_200_1.var_.characterEffect10162ui_story and not isNil(var_203_22) then
					arg_200_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= var_203_23 + var_203_24 and arg_200_1.time_ < var_203_23 + var_203_24 + arg_203_0 and not isNil(var_203_22) and arg_200_1.var_.characterEffect10162ui_story then
				arg_200_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_203_26 = arg_200_1.actors_["10166ui_story"]
			local var_203_27 = 0

			if var_203_27 < arg_200_1.time_ and arg_200_1.time_ <= var_203_27 + arg_203_0 and not isNil(var_203_26) and arg_200_1.var_.characterEffect10166ui_story == nil then
				arg_200_1.var_.characterEffect10166ui_story = var_203_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_28 = 0.200000002980232

			if var_203_27 <= arg_200_1.time_ and arg_200_1.time_ < var_203_27 + var_203_28 and not isNil(var_203_26) then
				local var_203_29 = (arg_200_1.time_ - var_203_27) / var_203_28

				if arg_200_1.var_.characterEffect10166ui_story and not isNil(var_203_26) then
					local var_203_30 = Mathf.Lerp(0, 0.5, var_203_29)

					arg_200_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_200_1.var_.characterEffect10166ui_story.fillRatio = var_203_30
				end
			end

			if arg_200_1.time_ >= var_203_27 + var_203_28 and arg_200_1.time_ < var_203_27 + var_203_28 + arg_203_0 and not isNil(var_203_26) and arg_200_1.var_.characterEffect10166ui_story then
				local var_203_31 = 0.5

				arg_200_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_200_1.var_.characterEffect10166ui_story.fillRatio = var_203_31
			end

			local var_203_32 = 0

			if var_203_32 < arg_200_1.time_ and arg_200_1.time_ <= var_203_32 + arg_203_0 then
				arg_200_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_1")
			end

			local var_203_33 = 0

			if var_203_33 < arg_200_1.time_ and arg_200_1.time_ <= var_203_33 + arg_203_0 then
				arg_200_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_203_34 = 0
			local var_203_35 = 1.25

			if var_203_34 < arg_200_1.time_ and arg_200_1.time_ <= var_203_34 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_36 = arg_200_1:FormatText(StoryNameCfg[1533].name)

				arg_200_1.leftNameTxt_.text = var_203_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_37 = arg_200_1:GetWordFromCfg(325571050)
				local var_203_38 = arg_200_1:FormatText(var_203_37.content)

				arg_200_1.text_.text = var_203_38

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_39 = 50
				local var_203_40 = utf8.len(var_203_38)
				local var_203_41 = var_203_39 <= 0 and var_203_35 or var_203_35 * (var_203_40 / var_203_39)

				if var_203_41 > 0 and var_203_35 < var_203_41 then
					arg_200_1.talkMaxDuration = var_203_41

					if var_203_41 + var_203_34 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_41 + var_203_34
					end
				end

				arg_200_1.text_.text = var_203_38
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571050", "story_v_out_325571.awb") ~= 0 then
					local var_203_42 = manager.audio:GetVoiceLength("story_v_out_325571", "325571050", "story_v_out_325571.awb") / 1000

					if var_203_42 + var_203_34 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_42 + var_203_34
					end

					if var_203_37.prefab_name ~= "" and arg_200_1.actors_[var_203_37.prefab_name] ~= nil then
						local var_203_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_37.prefab_name].transform, "story_v_out_325571", "325571050", "story_v_out_325571.awb")

						arg_200_1:RecordAudio("325571050", var_203_43)
						arg_200_1:RecordAudio("325571050", var_203_43)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_325571", "325571050", "story_v_out_325571.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_325571", "325571050", "story_v_out_325571.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_44 = math.max(var_203_35, arg_200_1.talkMaxDuration)

			if var_203_34 <= arg_200_1.time_ and arg_200_1.time_ < var_203_34 + var_203_44 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_34) / var_203_44

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_34 + var_203_44 and arg_200_1.time_ < var_203_34 + var_203_44 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play325571051 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 325571051
		arg_204_1.duration_ = 8.9

		local var_204_0 = {
			zh = 5.5,
			ja = 8.9
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play325571052(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162actionlink/10162action41216")
			end

			local var_207_1 = 0
			local var_207_2 = 0.575

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_3 = arg_204_1:FormatText(StoryNameCfg[1533].name)

				arg_204_1.leftNameTxt_.text = var_207_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_4 = arg_204_1:GetWordFromCfg(325571051)
				local var_207_5 = arg_204_1:FormatText(var_207_4.content)

				arg_204_1.text_.text = var_207_5

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_6 = 23
				local var_207_7 = utf8.len(var_207_5)
				local var_207_8 = var_207_6 <= 0 and var_207_2 or var_207_2 * (var_207_7 / var_207_6)

				if var_207_8 > 0 and var_207_2 < var_207_8 then
					arg_204_1.talkMaxDuration = var_207_8

					if var_207_8 + var_207_1 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_8 + var_207_1
					end
				end

				arg_204_1.text_.text = var_207_5
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571051", "story_v_out_325571.awb") ~= 0 then
					local var_207_9 = manager.audio:GetVoiceLength("story_v_out_325571", "325571051", "story_v_out_325571.awb") / 1000

					if var_207_9 + var_207_1 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_9 + var_207_1
					end

					if var_207_4.prefab_name ~= "" and arg_204_1.actors_[var_207_4.prefab_name] ~= nil then
						local var_207_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_4.prefab_name].transform, "story_v_out_325571", "325571051", "story_v_out_325571.awb")

						arg_204_1:RecordAudio("325571051", var_207_10)
						arg_204_1:RecordAudio("325571051", var_207_10)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_325571", "325571051", "story_v_out_325571.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_325571", "325571051", "story_v_out_325571.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_11 = math.max(var_207_2, arg_204_1.talkMaxDuration)

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_11 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_1) / var_207_11

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_1 + var_207_11 and arg_204_1.time_ < var_207_1 + var_207_11 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play325571052 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 325571052
		arg_208_1.duration_ = 2.57

		local var_208_0 = {
			zh = 1.266,
			ja = 2.566
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play325571053(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["10166ui_story"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect10166ui_story == nil then
				arg_208_1.var_.characterEffect10166ui_story = var_211_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.200000002980232

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.characterEffect10166ui_story and not isNil(var_211_0) then
					arg_208_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect10166ui_story then
				arg_208_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_211_4 = arg_208_1.actors_["10162ui_story"]
			local var_211_5 = 0

			if var_211_5 < arg_208_1.time_ and arg_208_1.time_ <= var_211_5 + arg_211_0 and not isNil(var_211_4) and arg_208_1.var_.characterEffect10162ui_story == nil then
				arg_208_1.var_.characterEffect10162ui_story = var_211_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_6 = 0.200000002980232

			if var_211_5 <= arg_208_1.time_ and arg_208_1.time_ < var_211_5 + var_211_6 and not isNil(var_211_4) then
				local var_211_7 = (arg_208_1.time_ - var_211_5) / var_211_6

				if arg_208_1.var_.characterEffect10162ui_story and not isNil(var_211_4) then
					local var_211_8 = Mathf.Lerp(0, 0.5, var_211_7)

					arg_208_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_208_1.var_.characterEffect10162ui_story.fillRatio = var_211_8
				end
			end

			if arg_208_1.time_ >= var_211_5 + var_211_6 and arg_208_1.time_ < var_211_5 + var_211_6 + arg_211_0 and not isNil(var_211_4) and arg_208_1.var_.characterEffect10162ui_story then
				local var_211_9 = 0.5

				arg_208_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_208_1.var_.characterEffect10162ui_story.fillRatio = var_211_9
			end

			local var_211_10 = manager.ui.mainCamera.transform
			local var_211_11 = 0

			if var_211_11 < arg_208_1.time_ and arg_208_1.time_ <= var_211_11 + arg_211_0 then
				arg_208_1.var_.shakeOldPos = var_211_10.localPosition
			end

			local var_211_12 = 0.4

			if var_211_11 <= arg_208_1.time_ and arg_208_1.time_ < var_211_11 + var_211_12 then
				local var_211_13 = (arg_208_1.time_ - var_211_11) / 0.066
				local var_211_14, var_211_15 = math.modf(var_211_13)

				var_211_10.localPosition = Vector3.New(var_211_15 * 0.13, var_211_15 * 0.13, var_211_15 * 0.13) + arg_208_1.var_.shakeOldPos
			end

			if arg_208_1.time_ >= var_211_11 + var_211_12 and arg_208_1.time_ < var_211_11 + var_211_12 + arg_211_0 then
				var_211_10.localPosition = arg_208_1.var_.shakeOldPos
			end

			local var_211_16 = 0

			if var_211_16 < arg_208_1.time_ and arg_208_1.time_ <= var_211_16 + arg_211_0 then
				arg_208_1.allBtn_.enabled = false
			end

			local var_211_17 = 0.4

			if arg_208_1.time_ >= var_211_16 + var_211_17 and arg_208_1.time_ < var_211_16 + var_211_17 + arg_211_0 then
				arg_208_1.allBtn_.enabled = true
			end

			local var_211_18 = arg_208_1.actors_["10166ui_story"].transform
			local var_211_19 = 0

			if var_211_19 < arg_208_1.time_ and arg_208_1.time_ <= var_211_19 + arg_211_0 then
				arg_208_1.var_.moveOldPos10166ui_story = var_211_18.localPosition

				local var_211_20 = GameObjectTools.GetOrAddComponent(var_211_18.gameObject, typeof(DynamicBoneHelper))

				if var_211_20 then
					var_211_20:EnableDynamicBone(false)
				end
			end

			local var_211_21 = 0.001

			if var_211_19 <= arg_208_1.time_ and arg_208_1.time_ < var_211_19 + var_211_21 then
				local var_211_22 = (arg_208_1.time_ - var_211_19) / var_211_21
				local var_211_23 = Vector3.New(0, 100, 0)

				var_211_18.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10166ui_story, var_211_23, var_211_22)

				local var_211_24 = manager.ui.mainCamera.transform.position - var_211_18.position

				var_211_18.forward = Vector3.New(var_211_24.x, var_211_24.y, var_211_24.z)

				local var_211_25 = var_211_18.localEulerAngles

				var_211_25.z = 0
				var_211_25.x = 0
				var_211_18.localEulerAngles = var_211_25
			end

			if arg_208_1.time_ >= var_211_19 + var_211_21 and arg_208_1.time_ < var_211_19 + var_211_21 + arg_211_0 then
				var_211_18.localPosition = Vector3.New(0, 100, 0)

				local var_211_26 = manager.ui.mainCamera.transform.position - var_211_18.position

				var_211_18.forward = Vector3.New(var_211_26.x, var_211_26.y, var_211_26.z)

				local var_211_27 = var_211_18.localEulerAngles

				var_211_27.z = 0
				var_211_27.x = 0
				var_211_18.localEulerAngles = var_211_27

				local var_211_28 = GameObjectTools.GetOrAddComponent(var_211_18.gameObject, typeof(DynamicBoneHelper))

				if var_211_28 then
					var_211_28:EnableDynamicBone(true)
				end
			end

			local var_211_29 = arg_208_1.actors_["10162ui_story"].transform
			local var_211_30 = 0

			if var_211_30 < arg_208_1.time_ and arg_208_1.time_ <= var_211_30 + arg_211_0 then
				arg_208_1.var_.moveOldPos10162ui_story = var_211_29.localPosition

				local var_211_31 = GameObjectTools.GetOrAddComponent(var_211_29.gameObject, typeof(DynamicBoneHelper))

				if var_211_31 then
					var_211_31:EnableDynamicBone(false)
				end
			end

			local var_211_32 = 0.001

			if var_211_30 <= arg_208_1.time_ and arg_208_1.time_ < var_211_30 + var_211_32 then
				local var_211_33 = (arg_208_1.time_ - var_211_30) / var_211_32
				local var_211_34 = Vector3.New(0, 100, 0)

				var_211_29.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10162ui_story, var_211_34, var_211_33)

				local var_211_35 = manager.ui.mainCamera.transform.position - var_211_29.position

				var_211_29.forward = Vector3.New(var_211_35.x, var_211_35.y, var_211_35.z)

				local var_211_36 = var_211_29.localEulerAngles

				var_211_36.z = 0
				var_211_36.x = 0
				var_211_29.localEulerAngles = var_211_36
			end

			if arg_208_1.time_ >= var_211_30 + var_211_32 and arg_208_1.time_ < var_211_30 + var_211_32 + arg_211_0 then
				var_211_29.localPosition = Vector3.New(0, 100, 0)

				local var_211_37 = manager.ui.mainCamera.transform.position - var_211_29.position

				var_211_29.forward = Vector3.New(var_211_37.x, var_211_37.y, var_211_37.z)

				local var_211_38 = var_211_29.localEulerAngles

				var_211_38.z = 0
				var_211_38.x = 0
				var_211_29.localEulerAngles = var_211_38

				local var_211_39 = GameObjectTools.GetOrAddComponent(var_211_29.gameObject, typeof(DynamicBoneHelper))

				if var_211_39 then
					var_211_39:EnableDynamicBone(true)
				end
			end

			local var_211_40 = arg_208_1.actors_["10166ui_story"]
			local var_211_41 = 0

			if var_211_41 < arg_208_1.time_ and arg_208_1.time_ <= var_211_41 + arg_211_0 and not isNil(var_211_40) and arg_208_1.var_.characterEffect10166ui_story == nil then
				arg_208_1.var_.characterEffect10166ui_story = var_211_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_42 = 0.200000002980232

			if var_211_41 <= arg_208_1.time_ and arg_208_1.time_ < var_211_41 + var_211_42 and not isNil(var_211_40) then
				local var_211_43 = (arg_208_1.time_ - var_211_41) / var_211_42

				if arg_208_1.var_.characterEffect10166ui_story and not isNil(var_211_40) then
					local var_211_44 = Mathf.Lerp(0, 0.5, var_211_43)

					arg_208_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_208_1.var_.characterEffect10166ui_story.fillRatio = var_211_44
				end
			end

			if arg_208_1.time_ >= var_211_41 + var_211_42 and arg_208_1.time_ < var_211_41 + var_211_42 + arg_211_0 and not isNil(var_211_40) and arg_208_1.var_.characterEffect10166ui_story then
				local var_211_45 = 0.5

				arg_208_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_208_1.var_.characterEffect10166ui_story.fillRatio = var_211_45
			end

			local var_211_46 = 0
			local var_211_47 = 0.125

			if var_211_46 < arg_208_1.time_ and arg_208_1.time_ <= var_211_46 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_48 = arg_208_1:FormatText(StoryNameCfg[1531].name)

				arg_208_1.leftNameTxt_.text = var_211_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10166")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_49 = arg_208_1:GetWordFromCfg(325571052)
				local var_211_50 = arg_208_1:FormatText(var_211_49.content)

				arg_208_1.text_.text = var_211_50

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_51 = 5
				local var_211_52 = utf8.len(var_211_50)
				local var_211_53 = var_211_51 <= 0 and var_211_47 or var_211_47 * (var_211_52 / var_211_51)

				if var_211_53 > 0 and var_211_47 < var_211_53 then
					arg_208_1.talkMaxDuration = var_211_53

					if var_211_53 + var_211_46 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_53 + var_211_46
					end
				end

				arg_208_1.text_.text = var_211_50
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571052", "story_v_out_325571.awb") ~= 0 then
					local var_211_54 = manager.audio:GetVoiceLength("story_v_out_325571", "325571052", "story_v_out_325571.awb") / 1000

					if var_211_54 + var_211_46 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_54 + var_211_46
					end

					if var_211_49.prefab_name ~= "" and arg_208_1.actors_[var_211_49.prefab_name] ~= nil then
						local var_211_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_49.prefab_name].transform, "story_v_out_325571", "325571052", "story_v_out_325571.awb")

						arg_208_1:RecordAudio("325571052", var_211_55)
						arg_208_1:RecordAudio("325571052", var_211_55)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_325571", "325571052", "story_v_out_325571.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_325571", "325571052", "story_v_out_325571.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_56 = math.max(var_211_47, arg_208_1.talkMaxDuration)

			if var_211_46 <= arg_208_1.time_ and arg_208_1.time_ < var_211_46 + var_211_56 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_46) / var_211_56

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_46 + var_211_56 and arg_208_1.time_ < var_211_46 + var_211_56 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play325571053 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 325571053
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play325571054(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0
			local var_215_1 = 1

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				local var_215_2 = "play"
				local var_215_3 = "effect"

				arg_212_1:AudioAction(var_215_2, var_215_3, "se_story_side_1037", "se_story_1037_fall", "")
			end

			local var_215_4 = 0
			local var_215_5 = 1.275

			if var_215_4 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_6 = arg_212_1:GetWordFromCfg(325571053)
				local var_215_7 = arg_212_1:FormatText(var_215_6.content)

				arg_212_1.text_.text = var_215_7

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_8 = 51
				local var_215_9 = utf8.len(var_215_7)
				local var_215_10 = var_215_8 <= 0 and var_215_5 or var_215_5 * (var_215_9 / var_215_8)

				if var_215_10 > 0 and var_215_5 < var_215_10 then
					arg_212_1.talkMaxDuration = var_215_10

					if var_215_10 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_10 + var_215_4
					end
				end

				arg_212_1.text_.text = var_215_7
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_11 = math.max(var_215_5, arg_212_1.talkMaxDuration)

			if var_215_4 <= arg_212_1.time_ and arg_212_1.time_ < var_215_4 + var_215_11 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_4) / var_215_11

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_4 + var_215_11 and arg_212_1.time_ < var_215_4 + var_215_11 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play325571054 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 325571054
		arg_216_1.duration_ = 6.6

		local var_216_0 = {
			zh = 4.4,
			ja = 6.6
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play325571055(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["10166ui_story"].transform
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.var_.moveOldPos10166ui_story = var_219_0.localPosition

				local var_219_2 = GameObjectTools.GetOrAddComponent(var_219_0.gameObject, typeof(DynamicBoneHelper))

				if var_219_2 then
					var_219_2:EnableDynamicBone(false)
				end
			end

			local var_219_3 = 0.001

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_3 then
				local var_219_4 = (arg_216_1.time_ - var_219_1) / var_219_3
				local var_219_5 = Vector3.New(0, -1.28, -5.73)

				var_219_0.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10166ui_story, var_219_5, var_219_4)

				local var_219_6 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_6.x, var_219_6.y, var_219_6.z)

				local var_219_7 = var_219_0.localEulerAngles

				var_219_7.z = 0
				var_219_7.x = 0
				var_219_0.localEulerAngles = var_219_7
			end

			if arg_216_1.time_ >= var_219_1 + var_219_3 and arg_216_1.time_ < var_219_1 + var_219_3 + arg_219_0 then
				var_219_0.localPosition = Vector3.New(0, -1.28, -5.73)

				local var_219_8 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_8.x, var_219_8.y, var_219_8.z)

				local var_219_9 = var_219_0.localEulerAngles

				var_219_9.z = 0
				var_219_9.x = 0
				var_219_0.localEulerAngles = var_219_9

				local var_219_10 = GameObjectTools.GetOrAddComponent(var_219_0.gameObject, typeof(DynamicBoneHelper))

				if var_219_10 then
					var_219_10:EnableDynamicBone(true)
				end
			end

			local var_219_11 = arg_216_1.actors_["10166ui_story"]
			local var_219_12 = 0

			if var_219_12 < arg_216_1.time_ and arg_216_1.time_ <= var_219_12 + arg_219_0 and not isNil(var_219_11) and arg_216_1.var_.characterEffect10166ui_story == nil then
				arg_216_1.var_.characterEffect10166ui_story = var_219_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_13 = 0.200000002980232

			if var_219_12 <= arg_216_1.time_ and arg_216_1.time_ < var_219_12 + var_219_13 and not isNil(var_219_11) then
				local var_219_14 = (arg_216_1.time_ - var_219_12) / var_219_13

				if arg_216_1.var_.characterEffect10166ui_story and not isNil(var_219_11) then
					arg_216_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_12 + var_219_13 and arg_216_1.time_ < var_219_12 + var_219_13 + arg_219_0 and not isNil(var_219_11) and arg_216_1.var_.characterEffect10166ui_story then
				arg_216_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_219_15 = 0

			if var_219_15 < arg_216_1.time_ and arg_216_1.time_ <= var_219_15 + arg_219_0 then
				arg_216_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			local var_219_16 = 0

			if var_219_16 < arg_216_1.time_ and arg_216_1.time_ <= var_219_16 + arg_219_0 then
				arg_216_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_219_17 = 0
			local var_219_18 = 0.45

			if var_219_17 < arg_216_1.time_ and arg_216_1.time_ <= var_219_17 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_19 = arg_216_1:FormatText(StoryNameCfg[1530].name)

				arg_216_1.leftNameTxt_.text = var_219_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_20 = arg_216_1:GetWordFromCfg(325571054)
				local var_219_21 = arg_216_1:FormatText(var_219_20.content)

				arg_216_1.text_.text = var_219_21

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_22 = 18
				local var_219_23 = utf8.len(var_219_21)
				local var_219_24 = var_219_22 <= 0 and var_219_18 or var_219_18 * (var_219_23 / var_219_22)

				if var_219_24 > 0 and var_219_18 < var_219_24 then
					arg_216_1.talkMaxDuration = var_219_24

					if var_219_24 + var_219_17 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_24 + var_219_17
					end
				end

				arg_216_1.text_.text = var_219_21
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571054", "story_v_out_325571.awb") ~= 0 then
					local var_219_25 = manager.audio:GetVoiceLength("story_v_out_325571", "325571054", "story_v_out_325571.awb") / 1000

					if var_219_25 + var_219_17 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_25 + var_219_17
					end

					if var_219_20.prefab_name ~= "" and arg_216_1.actors_[var_219_20.prefab_name] ~= nil then
						local var_219_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_20.prefab_name].transform, "story_v_out_325571", "325571054", "story_v_out_325571.awb")

						arg_216_1:RecordAudio("325571054", var_219_26)
						arg_216_1:RecordAudio("325571054", var_219_26)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_325571", "325571054", "story_v_out_325571.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_325571", "325571054", "story_v_out_325571.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_27 = math.max(var_219_18, arg_216_1.talkMaxDuration)

			if var_219_17 <= arg_216_1.time_ and arg_216_1.time_ < var_219_17 + var_219_27 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_17) / var_219_27

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_17 + var_219_27 and arg_216_1.time_ < var_219_17 + var_219_27 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play325571055 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 325571055
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play325571056(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["10166ui_story"].transform
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.var_.moveOldPos10166ui_story = var_223_0.localPosition

				local var_223_2 = GameObjectTools.GetOrAddComponent(var_223_0.gameObject, typeof(DynamicBoneHelper))

				if var_223_2 then
					var_223_2:EnableDynamicBone(false)
				end
			end

			local var_223_3 = 0.001

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_3 then
				local var_223_4 = (arg_220_1.time_ - var_223_1) / var_223_3
				local var_223_5 = Vector3.New(0, 100, 0)

				var_223_0.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10166ui_story, var_223_5, var_223_4)

				local var_223_6 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_6.x, var_223_6.y, var_223_6.z)

				local var_223_7 = var_223_0.localEulerAngles

				var_223_7.z = 0
				var_223_7.x = 0
				var_223_0.localEulerAngles = var_223_7
			end

			if arg_220_1.time_ >= var_223_1 + var_223_3 and arg_220_1.time_ < var_223_1 + var_223_3 + arg_223_0 then
				var_223_0.localPosition = Vector3.New(0, 100, 0)

				local var_223_8 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_8.x, var_223_8.y, var_223_8.z)

				local var_223_9 = var_223_0.localEulerAngles

				var_223_9.z = 0
				var_223_9.x = 0
				var_223_0.localEulerAngles = var_223_9

				local var_223_10 = GameObjectTools.GetOrAddComponent(var_223_0.gameObject, typeof(DynamicBoneHelper))

				if var_223_10 then
					var_223_10:EnableDynamicBone(true)
				end
			end

			local var_223_11 = arg_220_1.actors_["10166ui_story"]
			local var_223_12 = 0

			if var_223_12 < arg_220_1.time_ and arg_220_1.time_ <= var_223_12 + arg_223_0 and not isNil(var_223_11) and arg_220_1.var_.characterEffect10166ui_story == nil then
				arg_220_1.var_.characterEffect10166ui_story = var_223_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_13 = 0.200000002980232

			if var_223_12 <= arg_220_1.time_ and arg_220_1.time_ < var_223_12 + var_223_13 and not isNil(var_223_11) then
				local var_223_14 = (arg_220_1.time_ - var_223_12) / var_223_13

				if arg_220_1.var_.characterEffect10166ui_story and not isNil(var_223_11) then
					local var_223_15 = Mathf.Lerp(0, 0.5, var_223_14)

					arg_220_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_220_1.var_.characterEffect10166ui_story.fillRatio = var_223_15
				end
			end

			if arg_220_1.time_ >= var_223_12 + var_223_13 and arg_220_1.time_ < var_223_12 + var_223_13 + arg_223_0 and not isNil(var_223_11) and arg_220_1.var_.characterEffect10166ui_story then
				local var_223_16 = 0.5

				arg_220_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_220_1.var_.characterEffect10166ui_story.fillRatio = var_223_16
			end

			local var_223_17 = 0
			local var_223_18 = 0.725

			if var_223_17 < arg_220_1.time_ and arg_220_1.time_ <= var_223_17 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_19 = arg_220_1:GetWordFromCfg(325571055)
				local var_223_20 = arg_220_1:FormatText(var_223_19.content)

				arg_220_1.text_.text = var_223_20

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_21 = 29
				local var_223_22 = utf8.len(var_223_20)
				local var_223_23 = var_223_21 <= 0 and var_223_18 or var_223_18 * (var_223_22 / var_223_21)

				if var_223_23 > 0 and var_223_18 < var_223_23 then
					arg_220_1.talkMaxDuration = var_223_23

					if var_223_23 + var_223_17 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_23 + var_223_17
					end
				end

				arg_220_1.text_.text = var_223_20
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_24 = math.max(var_223_18, arg_220_1.talkMaxDuration)

			if var_223_17 <= arg_220_1.time_ and arg_220_1.time_ < var_223_17 + var_223_24 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_17) / var_223_24

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_17 + var_223_24 and arg_220_1.time_ < var_223_17 + var_223_24 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play325571056 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 325571056
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play325571057(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0
			local var_227_1 = 1

			if var_227_0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, false)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_2 = arg_224_1:GetWordFromCfg(325571056)
				local var_227_3 = arg_224_1:FormatText(var_227_2.content)

				arg_224_1.text_.text = var_227_3

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_4 = 40
				local var_227_5 = utf8.len(var_227_3)
				local var_227_6 = var_227_4 <= 0 and var_227_1 or var_227_1 * (var_227_5 / var_227_4)

				if var_227_6 > 0 and var_227_1 < var_227_6 then
					arg_224_1.talkMaxDuration = var_227_6

					if var_227_6 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_6 + var_227_0
					end
				end

				arg_224_1.text_.text = var_227_3
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_7 = math.max(var_227_1, arg_224_1.talkMaxDuration)

			if var_227_0 <= arg_224_1.time_ and arg_224_1.time_ < var_227_0 + var_227_7 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_0) / var_227_7

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_0 + var_227_7 and arg_224_1.time_ < var_227_0 + var_227_7 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play325571057 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 325571057
		arg_228_1.duration_ = 7.9

		local var_228_0 = {
			zh = 6.9,
			ja = 7.9
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play325571058(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["10162ui_story"].transform
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.var_.moveOldPos10162ui_story = var_231_0.localPosition

				local var_231_2 = GameObjectTools.GetOrAddComponent(var_231_0.gameObject, typeof(DynamicBoneHelper))

				if var_231_2 then
					var_231_2:EnableDynamicBone(false)
				end
			end

			local var_231_3 = 0.001

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_3 then
				local var_231_4 = (arg_228_1.time_ - var_231_1) / var_231_3
				local var_231_5 = Vector3.New(0, -1.08, -5.83)

				var_231_0.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10162ui_story, var_231_5, var_231_4)

				local var_231_6 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_6.x, var_231_6.y, var_231_6.z)

				local var_231_7 = var_231_0.localEulerAngles

				var_231_7.z = 0
				var_231_7.x = 0
				var_231_0.localEulerAngles = var_231_7
			end

			if arg_228_1.time_ >= var_231_1 + var_231_3 and arg_228_1.time_ < var_231_1 + var_231_3 + arg_231_0 then
				var_231_0.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_231_8 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_8.x, var_231_8.y, var_231_8.z)

				local var_231_9 = var_231_0.localEulerAngles

				var_231_9.z = 0
				var_231_9.x = 0
				var_231_0.localEulerAngles = var_231_9

				local var_231_10 = GameObjectTools.GetOrAddComponent(var_231_0.gameObject, typeof(DynamicBoneHelper))

				if var_231_10 then
					var_231_10:EnableDynamicBone(true)
				end
			end

			local var_231_11 = arg_228_1.actors_["10162ui_story"]
			local var_231_12 = 0

			if var_231_12 < arg_228_1.time_ and arg_228_1.time_ <= var_231_12 + arg_231_0 and not isNil(var_231_11) and arg_228_1.var_.characterEffect10162ui_story == nil then
				arg_228_1.var_.characterEffect10162ui_story = var_231_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_13 = 0.200000002980232

			if var_231_12 <= arg_228_1.time_ and arg_228_1.time_ < var_231_12 + var_231_13 and not isNil(var_231_11) then
				local var_231_14 = (arg_228_1.time_ - var_231_12) / var_231_13

				if arg_228_1.var_.characterEffect10162ui_story and not isNil(var_231_11) then
					arg_228_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_12 + var_231_13 and arg_228_1.time_ < var_231_12 + var_231_13 + arg_231_0 and not isNil(var_231_11) and arg_228_1.var_.characterEffect10162ui_story then
				arg_228_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_231_15 = 0

			if var_231_15 < arg_228_1.time_ and arg_228_1.time_ <= var_231_15 + arg_231_0 then
				arg_228_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_1")
			end

			local var_231_16 = 0

			if var_231_16 < arg_228_1.time_ and arg_228_1.time_ <= var_231_16 + arg_231_0 then
				arg_228_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_231_17 = 0
			local var_231_18 = 0.725

			if var_231_17 < arg_228_1.time_ and arg_228_1.time_ <= var_231_17 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_19 = arg_228_1:FormatText(StoryNameCfg[1532].name)

				arg_228_1.leftNameTxt_.text = var_231_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_20 = arg_228_1:GetWordFromCfg(325571057)
				local var_231_21 = arg_228_1:FormatText(var_231_20.content)

				arg_228_1.text_.text = var_231_21

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_22 = 29
				local var_231_23 = utf8.len(var_231_21)
				local var_231_24 = var_231_22 <= 0 and var_231_18 or var_231_18 * (var_231_23 / var_231_22)

				if var_231_24 > 0 and var_231_18 < var_231_24 then
					arg_228_1.talkMaxDuration = var_231_24

					if var_231_24 + var_231_17 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_24 + var_231_17
					end
				end

				arg_228_1.text_.text = var_231_21
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571057", "story_v_out_325571.awb") ~= 0 then
					local var_231_25 = manager.audio:GetVoiceLength("story_v_out_325571", "325571057", "story_v_out_325571.awb") / 1000

					if var_231_25 + var_231_17 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_25 + var_231_17
					end

					if var_231_20.prefab_name ~= "" and arg_228_1.actors_[var_231_20.prefab_name] ~= nil then
						local var_231_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_20.prefab_name].transform, "story_v_out_325571", "325571057", "story_v_out_325571.awb")

						arg_228_1:RecordAudio("325571057", var_231_26)
						arg_228_1:RecordAudio("325571057", var_231_26)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_325571", "325571057", "story_v_out_325571.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_325571", "325571057", "story_v_out_325571.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_27 = math.max(var_231_18, arg_228_1.talkMaxDuration)

			if var_231_17 <= arg_228_1.time_ and arg_228_1.time_ < var_231_17 + var_231_27 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_17) / var_231_27

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_17 + var_231_27 and arg_228_1.time_ < var_231_17 + var_231_27 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play325571058 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 325571058
		arg_232_1.duration_ = 3.1

		local var_232_0 = {
			zh = 2.466,
			ja = 3.1
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play325571059(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["10162ui_story"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos10162ui_story = var_235_0.localPosition

				local var_235_2 = GameObjectTools.GetOrAddComponent(var_235_0.gameObject, typeof(DynamicBoneHelper))

				if var_235_2 then
					var_235_2:EnableDynamicBone(false)
				end
			end

			local var_235_3 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_3 then
				local var_235_4 = (arg_232_1.time_ - var_235_1) / var_235_3
				local var_235_5 = Vector3.New(0, -1.08, -5.83)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10162ui_story, var_235_5, var_235_4)

				local var_235_6 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_6.x, var_235_6.y, var_235_6.z)

				local var_235_7 = var_235_0.localEulerAngles

				var_235_7.z = 0
				var_235_7.x = 0
				var_235_0.localEulerAngles = var_235_7
			end

			if arg_232_1.time_ >= var_235_1 + var_235_3 and arg_232_1.time_ < var_235_1 + var_235_3 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_235_8 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_8.x, var_235_8.y, var_235_8.z)

				local var_235_9 = var_235_0.localEulerAngles

				var_235_9.z = 0
				var_235_9.x = 0
				var_235_0.localEulerAngles = var_235_9

				local var_235_10 = GameObjectTools.GetOrAddComponent(var_235_0.gameObject, typeof(DynamicBoneHelper))

				if var_235_10 then
					var_235_10:EnableDynamicBone(true)
				end
			end

			local var_235_11 = arg_232_1.actors_["10166ui_story"].transform
			local var_235_12 = 0

			if var_235_12 < arg_232_1.time_ and arg_232_1.time_ <= var_235_12 + arg_235_0 then
				arg_232_1.var_.moveOldPos10166ui_story = var_235_11.localPosition

				local var_235_13 = GameObjectTools.GetOrAddComponent(var_235_11.gameObject, typeof(DynamicBoneHelper))

				if var_235_13 then
					var_235_13:EnableDynamicBone(false)
				end
			end

			local var_235_14 = 0.001

			if var_235_12 <= arg_232_1.time_ and arg_232_1.time_ < var_235_12 + var_235_14 then
				local var_235_15 = (arg_232_1.time_ - var_235_12) / var_235_14
				local var_235_16 = Vector3.New(0, 100, 0)

				var_235_11.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10166ui_story, var_235_16, var_235_15)

				local var_235_17 = manager.ui.mainCamera.transform.position - var_235_11.position

				var_235_11.forward = Vector3.New(var_235_17.x, var_235_17.y, var_235_17.z)

				local var_235_18 = var_235_11.localEulerAngles

				var_235_18.z = 0
				var_235_18.x = 0
				var_235_11.localEulerAngles = var_235_18
			end

			if arg_232_1.time_ >= var_235_12 + var_235_14 and arg_232_1.time_ < var_235_12 + var_235_14 + arg_235_0 then
				var_235_11.localPosition = Vector3.New(0, 100, 0)

				local var_235_19 = manager.ui.mainCamera.transform.position - var_235_11.position

				var_235_11.forward = Vector3.New(var_235_19.x, var_235_19.y, var_235_19.z)

				local var_235_20 = var_235_11.localEulerAngles

				var_235_20.z = 0
				var_235_20.x = 0
				var_235_11.localEulerAngles = var_235_20

				local var_235_21 = GameObjectTools.GetOrAddComponent(var_235_11.gameObject, typeof(DynamicBoneHelper))

				if var_235_21 then
					var_235_21:EnableDynamicBone(true)
				end
			end

			local var_235_22 = arg_232_1.actors_["10166ui_story"]
			local var_235_23 = 0

			if var_235_23 < arg_232_1.time_ and arg_232_1.time_ <= var_235_23 + arg_235_0 and not isNil(var_235_22) and arg_232_1.var_.characterEffect10166ui_story == nil then
				arg_232_1.var_.characterEffect10166ui_story = var_235_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_24 = 0.200000002980232

			if var_235_23 <= arg_232_1.time_ and arg_232_1.time_ < var_235_23 + var_235_24 and not isNil(var_235_22) then
				local var_235_25 = (arg_232_1.time_ - var_235_23) / var_235_24

				if arg_232_1.var_.characterEffect10166ui_story and not isNil(var_235_22) then
					arg_232_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= var_235_23 + var_235_24 and arg_232_1.time_ < var_235_23 + var_235_24 + arg_235_0 and not isNil(var_235_22) and arg_232_1.var_.characterEffect10166ui_story then
				arg_232_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_235_26 = arg_232_1.actors_["10162ui_story"]
			local var_235_27 = 0

			if var_235_27 < arg_232_1.time_ and arg_232_1.time_ <= var_235_27 + arg_235_0 and not isNil(var_235_26) and arg_232_1.var_.characterEffect10162ui_story == nil then
				arg_232_1.var_.characterEffect10162ui_story = var_235_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_28 = 0.200000002980232

			if var_235_27 <= arg_232_1.time_ and arg_232_1.time_ < var_235_27 + var_235_28 and not isNil(var_235_26) then
				local var_235_29 = (arg_232_1.time_ - var_235_27) / var_235_28

				if arg_232_1.var_.characterEffect10162ui_story and not isNil(var_235_26) then
					local var_235_30 = Mathf.Lerp(0, 0.5, var_235_29)

					arg_232_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_232_1.var_.characterEffect10162ui_story.fillRatio = var_235_30
				end
			end

			if arg_232_1.time_ >= var_235_27 + var_235_28 and arg_232_1.time_ < var_235_27 + var_235_28 + arg_235_0 and not isNil(var_235_26) and arg_232_1.var_.characterEffect10162ui_story then
				local var_235_31 = 0.5

				arg_232_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_232_1.var_.characterEffect10162ui_story.fillRatio = var_235_31
			end

			local var_235_32 = 0

			if var_235_32 < arg_232_1.time_ and arg_232_1.time_ <= var_235_32 + arg_235_0 then
				arg_232_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			local var_235_33 = 0

			if var_235_33 < arg_232_1.time_ and arg_232_1.time_ <= var_235_33 + arg_235_0 then
				arg_232_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_235_34 = 0
			local var_235_35 = 0.2

			if var_235_34 < arg_232_1.time_ and arg_232_1.time_ <= var_235_34 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_36 = arg_232_1:FormatText(StoryNameCfg[1531].name)

				arg_232_1.leftNameTxt_.text = var_235_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10166")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_37 = arg_232_1:GetWordFromCfg(325571058)
				local var_235_38 = arg_232_1:FormatText(var_235_37.content)

				arg_232_1.text_.text = var_235_38

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_39 = 8
				local var_235_40 = utf8.len(var_235_38)
				local var_235_41 = var_235_39 <= 0 and var_235_35 or var_235_35 * (var_235_40 / var_235_39)

				if var_235_41 > 0 and var_235_35 < var_235_41 then
					arg_232_1.talkMaxDuration = var_235_41

					if var_235_41 + var_235_34 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_41 + var_235_34
					end
				end

				arg_232_1.text_.text = var_235_38
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571058", "story_v_out_325571.awb") ~= 0 then
					local var_235_42 = manager.audio:GetVoiceLength("story_v_out_325571", "325571058", "story_v_out_325571.awb") / 1000

					if var_235_42 + var_235_34 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_42 + var_235_34
					end

					if var_235_37.prefab_name ~= "" and arg_232_1.actors_[var_235_37.prefab_name] ~= nil then
						local var_235_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_37.prefab_name].transform, "story_v_out_325571", "325571058", "story_v_out_325571.awb")

						arg_232_1:RecordAudio("325571058", var_235_43)
						arg_232_1:RecordAudio("325571058", var_235_43)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_325571", "325571058", "story_v_out_325571.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_325571", "325571058", "story_v_out_325571.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_44 = math.max(var_235_35, arg_232_1.talkMaxDuration)

			if var_235_34 <= arg_232_1.time_ and arg_232_1.time_ < var_235_34 + var_235_44 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_34) / var_235_44

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_34 + var_235_44 and arg_232_1.time_ < var_235_34 + var_235_44 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play325571059 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 325571059
		arg_236_1.duration_ = 6.17

		local var_236_0 = {
			zh = 5.9,
			ja = 6.166
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play325571060(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["10166ui_story"].transform
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.var_.moveOldPos10166ui_story = var_239_0.localPosition

				local var_239_2 = GameObjectTools.GetOrAddComponent(var_239_0.gameObject, typeof(DynamicBoneHelper))

				if var_239_2 then
					var_239_2:EnableDynamicBone(false)
				end
			end

			local var_239_3 = 0.001

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_3 then
				local var_239_4 = (arg_236_1.time_ - var_239_1) / var_239_3
				local var_239_5 = Vector3.New(0, -1.28, -5.73)

				var_239_0.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10166ui_story, var_239_5, var_239_4)

				local var_239_6 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_6.x, var_239_6.y, var_239_6.z)

				local var_239_7 = var_239_0.localEulerAngles

				var_239_7.z = 0
				var_239_7.x = 0
				var_239_0.localEulerAngles = var_239_7
			end

			if arg_236_1.time_ >= var_239_1 + var_239_3 and arg_236_1.time_ < var_239_1 + var_239_3 + arg_239_0 then
				var_239_0.localPosition = Vector3.New(0, -1.28, -5.73)

				local var_239_8 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_8.x, var_239_8.y, var_239_8.z)

				local var_239_9 = var_239_0.localEulerAngles

				var_239_9.z = 0
				var_239_9.x = 0
				var_239_0.localEulerAngles = var_239_9

				local var_239_10 = GameObjectTools.GetOrAddComponent(var_239_0.gameObject, typeof(DynamicBoneHelper))

				if var_239_10 then
					var_239_10:EnableDynamicBone(true)
				end
			end

			local var_239_11 = arg_236_1.actors_["10162ui_story"].transform
			local var_239_12 = 0

			if var_239_12 < arg_236_1.time_ and arg_236_1.time_ <= var_239_12 + arg_239_0 then
				arg_236_1.var_.moveOldPos10162ui_story = var_239_11.localPosition

				local var_239_13 = GameObjectTools.GetOrAddComponent(var_239_11.gameObject, typeof(DynamicBoneHelper))

				if var_239_13 then
					var_239_13:EnableDynamicBone(false)
				end
			end

			local var_239_14 = 0.001

			if var_239_12 <= arg_236_1.time_ and arg_236_1.time_ < var_239_12 + var_239_14 then
				local var_239_15 = (arg_236_1.time_ - var_239_12) / var_239_14
				local var_239_16 = Vector3.New(0, 100, 0)

				var_239_11.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10162ui_story, var_239_16, var_239_15)

				local var_239_17 = manager.ui.mainCamera.transform.position - var_239_11.position

				var_239_11.forward = Vector3.New(var_239_17.x, var_239_17.y, var_239_17.z)

				local var_239_18 = var_239_11.localEulerAngles

				var_239_18.z = 0
				var_239_18.x = 0
				var_239_11.localEulerAngles = var_239_18
			end

			if arg_236_1.time_ >= var_239_12 + var_239_14 and arg_236_1.time_ < var_239_12 + var_239_14 + arg_239_0 then
				var_239_11.localPosition = Vector3.New(0, 100, 0)

				local var_239_19 = manager.ui.mainCamera.transform.position - var_239_11.position

				var_239_11.forward = Vector3.New(var_239_19.x, var_239_19.y, var_239_19.z)

				local var_239_20 = var_239_11.localEulerAngles

				var_239_20.z = 0
				var_239_20.x = 0
				var_239_11.localEulerAngles = var_239_20

				local var_239_21 = GameObjectTools.GetOrAddComponent(var_239_11.gameObject, typeof(DynamicBoneHelper))

				if var_239_21 then
					var_239_21:EnableDynamicBone(true)
				end
			end

			local var_239_22 = 0
			local var_239_23 = 0.6

			if var_239_22 < arg_236_1.time_ and arg_236_1.time_ <= var_239_22 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_24 = arg_236_1:FormatText(StoryNameCfg[1530].name)

				arg_236_1.leftNameTxt_.text = var_239_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_25 = arg_236_1:GetWordFromCfg(325571059)
				local var_239_26 = arg_236_1:FormatText(var_239_25.content)

				arg_236_1.text_.text = var_239_26

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_27 = 24
				local var_239_28 = utf8.len(var_239_26)
				local var_239_29 = var_239_27 <= 0 and var_239_23 or var_239_23 * (var_239_28 / var_239_27)

				if var_239_29 > 0 and var_239_23 < var_239_29 then
					arg_236_1.talkMaxDuration = var_239_29

					if var_239_29 + var_239_22 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_29 + var_239_22
					end
				end

				arg_236_1.text_.text = var_239_26
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571059", "story_v_out_325571.awb") ~= 0 then
					local var_239_30 = manager.audio:GetVoiceLength("story_v_out_325571", "325571059", "story_v_out_325571.awb") / 1000

					if var_239_30 + var_239_22 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_30 + var_239_22
					end

					if var_239_25.prefab_name ~= "" and arg_236_1.actors_[var_239_25.prefab_name] ~= nil then
						local var_239_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_25.prefab_name].transform, "story_v_out_325571", "325571059", "story_v_out_325571.awb")

						arg_236_1:RecordAudio("325571059", var_239_31)
						arg_236_1:RecordAudio("325571059", var_239_31)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_325571", "325571059", "story_v_out_325571.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_325571", "325571059", "story_v_out_325571.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_32 = math.max(var_239_23, arg_236_1.talkMaxDuration)

			if var_239_22 <= arg_236_1.time_ and arg_236_1.time_ < var_239_22 + var_239_32 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_22) / var_239_32

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_22 + var_239_32 and arg_236_1.time_ < var_239_22 + var_239_32 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play325571060 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 325571060
		arg_240_1.duration_ = 2.13

		local var_240_0 = {
			zh = 2.133,
			ja = 1.999999999999
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play325571061(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["10166ui_story"].transform
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.var_.moveOldPos10166ui_story = var_243_0.localPosition

				local var_243_2 = GameObjectTools.GetOrAddComponent(var_243_0.gameObject, typeof(DynamicBoneHelper))

				if var_243_2 then
					var_243_2:EnableDynamicBone(false)
				end
			end

			local var_243_3 = 0.001

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_3 then
				local var_243_4 = (arg_240_1.time_ - var_243_1) / var_243_3
				local var_243_5 = Vector3.New(0, 100, 0)

				var_243_0.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10166ui_story, var_243_5, var_243_4)

				local var_243_6 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_6.x, var_243_6.y, var_243_6.z)

				local var_243_7 = var_243_0.localEulerAngles

				var_243_7.z = 0
				var_243_7.x = 0
				var_243_0.localEulerAngles = var_243_7
			end

			if arg_240_1.time_ >= var_243_1 + var_243_3 and arg_240_1.time_ < var_243_1 + var_243_3 + arg_243_0 then
				var_243_0.localPosition = Vector3.New(0, 100, 0)

				local var_243_8 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_8.x, var_243_8.y, var_243_8.z)

				local var_243_9 = var_243_0.localEulerAngles

				var_243_9.z = 0
				var_243_9.x = 0
				var_243_0.localEulerAngles = var_243_9

				local var_243_10 = GameObjectTools.GetOrAddComponent(var_243_0.gameObject, typeof(DynamicBoneHelper))

				if var_243_10 then
					var_243_10:EnableDynamicBone(true)
				end
			end

			local var_243_11 = arg_240_1.actors_["10175ui_story"].transform
			local var_243_12 = 0

			if var_243_12 < arg_240_1.time_ and arg_240_1.time_ <= var_243_12 + arg_243_0 then
				arg_240_1.var_.moveOldPos10175ui_story = var_243_11.localPosition

				local var_243_13 = GameObjectTools.GetOrAddComponent(var_243_11.gameObject, typeof(DynamicBoneHelper))

				if var_243_13 then
					var_243_13:EnableDynamicBone(false)
				end
			end

			local var_243_14 = 0.001

			if var_243_12 <= arg_240_1.time_ and arg_240_1.time_ < var_243_12 + var_243_14 then
				local var_243_15 = (arg_240_1.time_ - var_243_12) / var_243_14
				local var_243_16 = Vector3.New(0, -1, -6.05)

				var_243_11.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10175ui_story, var_243_16, var_243_15)

				local var_243_17 = manager.ui.mainCamera.transform.position - var_243_11.position

				var_243_11.forward = Vector3.New(var_243_17.x, var_243_17.y, var_243_17.z)

				local var_243_18 = var_243_11.localEulerAngles

				var_243_18.z = 0
				var_243_18.x = 0
				var_243_11.localEulerAngles = var_243_18
			end

			if arg_240_1.time_ >= var_243_12 + var_243_14 and arg_240_1.time_ < var_243_12 + var_243_14 + arg_243_0 then
				var_243_11.localPosition = Vector3.New(0, -1, -6.05)

				local var_243_19 = manager.ui.mainCamera.transform.position - var_243_11.position

				var_243_11.forward = Vector3.New(var_243_19.x, var_243_19.y, var_243_19.z)

				local var_243_20 = var_243_11.localEulerAngles

				var_243_20.z = 0
				var_243_20.x = 0
				var_243_11.localEulerAngles = var_243_20

				local var_243_21 = GameObjectTools.GetOrAddComponent(var_243_11.gameObject, typeof(DynamicBoneHelper))

				if var_243_21 then
					var_243_21:EnableDynamicBone(true)
				end
			end

			local var_243_22 = arg_240_1.actors_["10175ui_story"]
			local var_243_23 = 0

			if var_243_23 < arg_240_1.time_ and arg_240_1.time_ <= var_243_23 + arg_243_0 and not isNil(var_243_22) and arg_240_1.var_.characterEffect10175ui_story == nil then
				arg_240_1.var_.characterEffect10175ui_story = var_243_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_24 = 0.200000002980232

			if var_243_23 <= arg_240_1.time_ and arg_240_1.time_ < var_243_23 + var_243_24 and not isNil(var_243_22) then
				local var_243_25 = (arg_240_1.time_ - var_243_23) / var_243_24

				if arg_240_1.var_.characterEffect10175ui_story and not isNil(var_243_22) then
					arg_240_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= var_243_23 + var_243_24 and arg_240_1.time_ < var_243_23 + var_243_24 + arg_243_0 and not isNil(var_243_22) and arg_240_1.var_.characterEffect10175ui_story then
				arg_240_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_243_26 = arg_240_1.actors_["10166ui_story"]
			local var_243_27 = 0

			if var_243_27 < arg_240_1.time_ and arg_240_1.time_ <= var_243_27 + arg_243_0 and not isNil(var_243_26) and arg_240_1.var_.characterEffect10166ui_story == nil then
				arg_240_1.var_.characterEffect10166ui_story = var_243_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_28 = 0.200000002980232

			if var_243_27 <= arg_240_1.time_ and arg_240_1.time_ < var_243_27 + var_243_28 and not isNil(var_243_26) then
				local var_243_29 = (arg_240_1.time_ - var_243_27) / var_243_28

				if arg_240_1.var_.characterEffect10166ui_story and not isNil(var_243_26) then
					local var_243_30 = Mathf.Lerp(0, 0.5, var_243_29)

					arg_240_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_240_1.var_.characterEffect10166ui_story.fillRatio = var_243_30
				end
			end

			if arg_240_1.time_ >= var_243_27 + var_243_28 and arg_240_1.time_ < var_243_27 + var_243_28 + arg_243_0 and not isNil(var_243_26) and arg_240_1.var_.characterEffect10166ui_story then
				local var_243_31 = 0.5

				arg_240_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_240_1.var_.characterEffect10166ui_story.fillRatio = var_243_31
			end

			local var_243_32 = 0

			if var_243_32 < arg_240_1.time_ and arg_240_1.time_ <= var_243_32 + arg_243_0 then
				arg_240_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			local var_243_33 = 0

			if var_243_33 < arg_240_1.time_ and arg_240_1.time_ <= var_243_33 + arg_243_0 then
				arg_240_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_243_34 = 0
			local var_243_35 = 0.15

			if var_243_34 < arg_240_1.time_ and arg_240_1.time_ <= var_243_34 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_36 = arg_240_1:FormatText(StoryNameCfg[1473].name)

				arg_240_1.leftNameTxt_.text = var_243_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_37 = arg_240_1:GetWordFromCfg(325571060)
				local var_243_38 = arg_240_1:FormatText(var_243_37.content)

				arg_240_1.text_.text = var_243_38

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_39 = 6
				local var_243_40 = utf8.len(var_243_38)
				local var_243_41 = var_243_39 <= 0 and var_243_35 or var_243_35 * (var_243_40 / var_243_39)

				if var_243_41 > 0 and var_243_35 < var_243_41 then
					arg_240_1.talkMaxDuration = var_243_41

					if var_243_41 + var_243_34 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_41 + var_243_34
					end
				end

				arg_240_1.text_.text = var_243_38
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571060", "story_v_out_325571.awb") ~= 0 then
					local var_243_42 = manager.audio:GetVoiceLength("story_v_out_325571", "325571060", "story_v_out_325571.awb") / 1000

					if var_243_42 + var_243_34 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_42 + var_243_34
					end

					if var_243_37.prefab_name ~= "" and arg_240_1.actors_[var_243_37.prefab_name] ~= nil then
						local var_243_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_37.prefab_name].transform, "story_v_out_325571", "325571060", "story_v_out_325571.awb")

						arg_240_1:RecordAudio("325571060", var_243_43)
						arg_240_1:RecordAudio("325571060", var_243_43)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_325571", "325571060", "story_v_out_325571.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_325571", "325571060", "story_v_out_325571.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_44 = math.max(var_243_35, arg_240_1.talkMaxDuration)

			if var_243_34 <= arg_240_1.time_ and arg_240_1.time_ < var_243_34 + var_243_44 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_34) / var_243_44

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_34 + var_243_44 and arg_240_1.time_ < var_243_34 + var_243_44 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play325571061 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 325571061
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play325571062(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["10175ui_story"].transform
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.var_.moveOldPos10175ui_story = var_247_0.localPosition

				local var_247_2 = GameObjectTools.GetOrAddComponent(var_247_0.gameObject, typeof(DynamicBoneHelper))

				if var_247_2 then
					var_247_2:EnableDynamicBone(false)
				end
			end

			local var_247_3 = 0.001

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_3 then
				local var_247_4 = (arg_244_1.time_ - var_247_1) / var_247_3
				local var_247_5 = Vector3.New(0, 100, 0)

				var_247_0.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10175ui_story, var_247_5, var_247_4)

				local var_247_6 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_6.x, var_247_6.y, var_247_6.z)

				local var_247_7 = var_247_0.localEulerAngles

				var_247_7.z = 0
				var_247_7.x = 0
				var_247_0.localEulerAngles = var_247_7
			end

			if arg_244_1.time_ >= var_247_1 + var_247_3 and arg_244_1.time_ < var_247_1 + var_247_3 + arg_247_0 then
				var_247_0.localPosition = Vector3.New(0, 100, 0)

				local var_247_8 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_8.x, var_247_8.y, var_247_8.z)

				local var_247_9 = var_247_0.localEulerAngles

				var_247_9.z = 0
				var_247_9.x = 0
				var_247_0.localEulerAngles = var_247_9

				local var_247_10 = GameObjectTools.GetOrAddComponent(var_247_0.gameObject, typeof(DynamicBoneHelper))

				if var_247_10 then
					var_247_10:EnableDynamicBone(true)
				end
			end

			local var_247_11 = arg_244_1.actors_["10175ui_story"]
			local var_247_12 = 0

			if var_247_12 < arg_244_1.time_ and arg_244_1.time_ <= var_247_12 + arg_247_0 and not isNil(var_247_11) and arg_244_1.var_.characterEffect10175ui_story == nil then
				arg_244_1.var_.characterEffect10175ui_story = var_247_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_13 = 0.200000002980232

			if var_247_12 <= arg_244_1.time_ and arg_244_1.time_ < var_247_12 + var_247_13 and not isNil(var_247_11) then
				local var_247_14 = (arg_244_1.time_ - var_247_12) / var_247_13

				if arg_244_1.var_.characterEffect10175ui_story and not isNil(var_247_11) then
					local var_247_15 = Mathf.Lerp(0, 0.5, var_247_14)

					arg_244_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_244_1.var_.characterEffect10175ui_story.fillRatio = var_247_15
				end
			end

			if arg_244_1.time_ >= var_247_12 + var_247_13 and arg_244_1.time_ < var_247_12 + var_247_13 + arg_247_0 and not isNil(var_247_11) and arg_244_1.var_.characterEffect10175ui_story then
				local var_247_16 = 0.5

				arg_244_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_244_1.var_.characterEffect10175ui_story.fillRatio = var_247_16
			end

			local var_247_17 = 0
			local var_247_18 = 1.75

			if var_247_17 < arg_244_1.time_ and arg_244_1.time_ <= var_247_17 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_19 = arg_244_1:GetWordFromCfg(325571061)
				local var_247_20 = arg_244_1:FormatText(var_247_19.content)

				arg_244_1.text_.text = var_247_20

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_21 = 70
				local var_247_22 = utf8.len(var_247_20)
				local var_247_23 = var_247_21 <= 0 and var_247_18 or var_247_18 * (var_247_22 / var_247_21)

				if var_247_23 > 0 and var_247_18 < var_247_23 then
					arg_244_1.talkMaxDuration = var_247_23

					if var_247_23 + var_247_17 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_23 + var_247_17
					end
				end

				arg_244_1.text_.text = var_247_20
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_24 = math.max(var_247_18, arg_244_1.talkMaxDuration)

			if var_247_17 <= arg_244_1.time_ and arg_244_1.time_ < var_247_17 + var_247_24 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_17) / var_247_24

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_17 + var_247_24 and arg_244_1.time_ < var_247_17 + var_247_24 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play325571062 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 325571062
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play325571063(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 0.8

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_2 = arg_248_1:GetWordFromCfg(325571062)
				local var_251_3 = arg_248_1:FormatText(var_251_2.content)

				arg_248_1.text_.text = var_251_3

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 32
				local var_251_5 = utf8.len(var_251_3)
				local var_251_6 = var_251_4 <= 0 and var_251_1 or var_251_1 * (var_251_5 / var_251_4)

				if var_251_6 > 0 and var_251_1 < var_251_6 then
					arg_248_1.talkMaxDuration = var_251_6

					if var_251_6 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_6 + var_251_0
					end
				end

				arg_248_1.text_.text = var_251_3
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_1, arg_248_1.talkMaxDuration)

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_0) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_0 + var_251_7 and arg_248_1.time_ < var_251_0 + var_251_7 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play325571063 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 325571063
		arg_252_1.duration_ = 10.03

		local var_252_0 = {
			zh = 7.466,
			ja = 10.033
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play325571064(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["10175ui_story"].transform
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.var_.moveOldPos10175ui_story = var_255_0.localPosition

				local var_255_2 = GameObjectTools.GetOrAddComponent(var_255_0.gameObject, typeof(DynamicBoneHelper))

				if var_255_2 then
					var_255_2:EnableDynamicBone(false)
				end
			end

			local var_255_3 = 0.001

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_3 then
				local var_255_4 = (arg_252_1.time_ - var_255_1) / var_255_3
				local var_255_5 = Vector3.New(0, -1, -6.05)

				var_255_0.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10175ui_story, var_255_5, var_255_4)

				local var_255_6 = manager.ui.mainCamera.transform.position - var_255_0.position

				var_255_0.forward = Vector3.New(var_255_6.x, var_255_6.y, var_255_6.z)

				local var_255_7 = var_255_0.localEulerAngles

				var_255_7.z = 0
				var_255_7.x = 0
				var_255_0.localEulerAngles = var_255_7
			end

			if arg_252_1.time_ >= var_255_1 + var_255_3 and arg_252_1.time_ < var_255_1 + var_255_3 + arg_255_0 then
				var_255_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_255_8 = manager.ui.mainCamera.transform.position - var_255_0.position

				var_255_0.forward = Vector3.New(var_255_8.x, var_255_8.y, var_255_8.z)

				local var_255_9 = var_255_0.localEulerAngles

				var_255_9.z = 0
				var_255_9.x = 0
				var_255_0.localEulerAngles = var_255_9

				local var_255_10 = GameObjectTools.GetOrAddComponent(var_255_0.gameObject, typeof(DynamicBoneHelper))

				if var_255_10 then
					var_255_10:EnableDynamicBone(true)
				end
			end

			local var_255_11 = arg_252_1.actors_["10175ui_story"]
			local var_255_12 = 0

			if var_255_12 < arg_252_1.time_ and arg_252_1.time_ <= var_255_12 + arg_255_0 and not isNil(var_255_11) and arg_252_1.var_.characterEffect10175ui_story == nil then
				arg_252_1.var_.characterEffect10175ui_story = var_255_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_13 = 0.200000002980232

			if var_255_12 <= arg_252_1.time_ and arg_252_1.time_ < var_255_12 + var_255_13 and not isNil(var_255_11) then
				local var_255_14 = (arg_252_1.time_ - var_255_12) / var_255_13

				if arg_252_1.var_.characterEffect10175ui_story and not isNil(var_255_11) then
					arg_252_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= var_255_12 + var_255_13 and arg_252_1.time_ < var_255_12 + var_255_13 + arg_255_0 and not isNil(var_255_11) and arg_252_1.var_.characterEffect10175ui_story then
				arg_252_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_255_15 = 0

			if var_255_15 < arg_252_1.time_ and arg_252_1.time_ <= var_255_15 + arg_255_0 then
				arg_252_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action2_1")
			end

			local var_255_16 = 0

			if var_255_16 < arg_252_1.time_ and arg_252_1.time_ <= var_255_16 + arg_255_0 then
				arg_252_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_255_17 = 0
			local var_255_18 = 0.675

			if var_255_17 < arg_252_1.time_ and arg_252_1.time_ <= var_255_17 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_19 = arg_252_1:FormatText(StoryNameCfg[1473].name)

				arg_252_1.leftNameTxt_.text = var_255_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_20 = arg_252_1:GetWordFromCfg(325571063)
				local var_255_21 = arg_252_1:FormatText(var_255_20.content)

				arg_252_1.text_.text = var_255_21

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_22 = 27
				local var_255_23 = utf8.len(var_255_21)
				local var_255_24 = var_255_22 <= 0 and var_255_18 or var_255_18 * (var_255_23 / var_255_22)

				if var_255_24 > 0 and var_255_18 < var_255_24 then
					arg_252_1.talkMaxDuration = var_255_24

					if var_255_24 + var_255_17 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_24 + var_255_17
					end
				end

				arg_252_1.text_.text = var_255_21
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571063", "story_v_out_325571.awb") ~= 0 then
					local var_255_25 = manager.audio:GetVoiceLength("story_v_out_325571", "325571063", "story_v_out_325571.awb") / 1000

					if var_255_25 + var_255_17 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_25 + var_255_17
					end

					if var_255_20.prefab_name ~= "" and arg_252_1.actors_[var_255_20.prefab_name] ~= nil then
						local var_255_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_20.prefab_name].transform, "story_v_out_325571", "325571063", "story_v_out_325571.awb")

						arg_252_1:RecordAudio("325571063", var_255_26)
						arg_252_1:RecordAudio("325571063", var_255_26)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_325571", "325571063", "story_v_out_325571.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_325571", "325571063", "story_v_out_325571.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_27 = math.max(var_255_18, arg_252_1.talkMaxDuration)

			if var_255_17 <= arg_252_1.time_ and arg_252_1.time_ < var_255_17 + var_255_27 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_17) / var_255_27

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_17 + var_255_27 and arg_252_1.time_ < var_255_17 + var_255_27 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play325571064 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 325571064
		arg_256_1.duration_ = 18.43

		local var_256_0 = {
			zh = 10.333,
			ja = 18.433
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play325571065(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0
			local var_259_1 = 1.1

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_2 = arg_256_1:FormatText(StoryNameCfg[1473].name)

				arg_256_1.leftNameTxt_.text = var_259_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_3 = arg_256_1:GetWordFromCfg(325571064)
				local var_259_4 = arg_256_1:FormatText(var_259_3.content)

				arg_256_1.text_.text = var_259_4

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 44
				local var_259_6 = utf8.len(var_259_4)
				local var_259_7 = var_259_5 <= 0 and var_259_1 or var_259_1 * (var_259_6 / var_259_5)

				if var_259_7 > 0 and var_259_1 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_0
					end
				end

				arg_256_1.text_.text = var_259_4
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571064", "story_v_out_325571.awb") ~= 0 then
					local var_259_8 = manager.audio:GetVoiceLength("story_v_out_325571", "325571064", "story_v_out_325571.awb") / 1000

					if var_259_8 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_0
					end

					if var_259_3.prefab_name ~= "" and arg_256_1.actors_[var_259_3.prefab_name] ~= nil then
						local var_259_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_3.prefab_name].transform, "story_v_out_325571", "325571064", "story_v_out_325571.awb")

						arg_256_1:RecordAudio("325571064", var_259_9)
						arg_256_1:RecordAudio("325571064", var_259_9)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_325571", "325571064", "story_v_out_325571.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_325571", "325571064", "story_v_out_325571.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_10 = math.max(var_259_1, arg_256_1.talkMaxDuration)

			if var_259_0 <= arg_256_1.time_ and arg_256_1.time_ < var_259_0 + var_259_10 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_0) / var_259_10

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_0 + var_259_10 and arg_256_1.time_ < var_259_0 + var_259_10 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play325571065 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 325571065
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play325571066(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["10175ui_story"].transform
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 then
				arg_260_1.var_.moveOldPos10175ui_story = var_263_0.localPosition

				local var_263_2 = GameObjectTools.GetOrAddComponent(var_263_0.gameObject, typeof(DynamicBoneHelper))

				if var_263_2 then
					var_263_2:EnableDynamicBone(false)
				end
			end

			local var_263_3 = 0.001

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_3 then
				local var_263_4 = (arg_260_1.time_ - var_263_1) / var_263_3
				local var_263_5 = Vector3.New(0, 100, 0)

				var_263_0.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10175ui_story, var_263_5, var_263_4)

				local var_263_6 = manager.ui.mainCamera.transform.position - var_263_0.position

				var_263_0.forward = Vector3.New(var_263_6.x, var_263_6.y, var_263_6.z)

				local var_263_7 = var_263_0.localEulerAngles

				var_263_7.z = 0
				var_263_7.x = 0
				var_263_0.localEulerAngles = var_263_7
			end

			if arg_260_1.time_ >= var_263_1 + var_263_3 and arg_260_1.time_ < var_263_1 + var_263_3 + arg_263_0 then
				var_263_0.localPosition = Vector3.New(0, 100, 0)

				local var_263_8 = manager.ui.mainCamera.transform.position - var_263_0.position

				var_263_0.forward = Vector3.New(var_263_8.x, var_263_8.y, var_263_8.z)

				local var_263_9 = var_263_0.localEulerAngles

				var_263_9.z = 0
				var_263_9.x = 0
				var_263_0.localEulerAngles = var_263_9

				local var_263_10 = GameObjectTools.GetOrAddComponent(var_263_0.gameObject, typeof(DynamicBoneHelper))

				if var_263_10 then
					var_263_10:EnableDynamicBone(true)
				end
			end

			local var_263_11 = arg_260_1.actors_["10175ui_story"]
			local var_263_12 = 0

			if var_263_12 < arg_260_1.time_ and arg_260_1.time_ <= var_263_12 + arg_263_0 and not isNil(var_263_11) and arg_260_1.var_.characterEffect10175ui_story == nil then
				arg_260_1.var_.characterEffect10175ui_story = var_263_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_13 = 0.200000002980232

			if var_263_12 <= arg_260_1.time_ and arg_260_1.time_ < var_263_12 + var_263_13 and not isNil(var_263_11) then
				local var_263_14 = (arg_260_1.time_ - var_263_12) / var_263_13

				if arg_260_1.var_.characterEffect10175ui_story and not isNil(var_263_11) then
					local var_263_15 = Mathf.Lerp(0, 0.5, var_263_14)

					arg_260_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_260_1.var_.characterEffect10175ui_story.fillRatio = var_263_15
				end
			end

			if arg_260_1.time_ >= var_263_12 + var_263_13 and arg_260_1.time_ < var_263_12 + var_263_13 + arg_263_0 and not isNil(var_263_11) and arg_260_1.var_.characterEffect10175ui_story then
				local var_263_16 = 0.5

				arg_260_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_260_1.var_.characterEffect10175ui_story.fillRatio = var_263_16
			end

			local var_263_17 = 0
			local var_263_18 = 0.875

			if var_263_17 < arg_260_1.time_ and arg_260_1.time_ <= var_263_17 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_19 = arg_260_1:GetWordFromCfg(325571065)
				local var_263_20 = arg_260_1:FormatText(var_263_19.content)

				arg_260_1.text_.text = var_263_20

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_21 = 35
				local var_263_22 = utf8.len(var_263_20)
				local var_263_23 = var_263_21 <= 0 and var_263_18 or var_263_18 * (var_263_22 / var_263_21)

				if var_263_23 > 0 and var_263_18 < var_263_23 then
					arg_260_1.talkMaxDuration = var_263_23

					if var_263_23 + var_263_17 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_23 + var_263_17
					end
				end

				arg_260_1.text_.text = var_263_20
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_24 = math.max(var_263_18, arg_260_1.talkMaxDuration)

			if var_263_17 <= arg_260_1.time_ and arg_260_1.time_ < var_263_17 + var_263_24 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_17) / var_263_24

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_17 + var_263_24 and arg_260_1.time_ < var_263_17 + var_263_24 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play325571066 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 325571066
		arg_264_1.duration_ = 3.17

		local var_264_0 = {
			zh = 2.7,
			ja = 3.166
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play325571067(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["10175ui_story"].transform
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.var_.moveOldPos10175ui_story = var_267_0.localPosition

				local var_267_2 = GameObjectTools.GetOrAddComponent(var_267_0.gameObject, typeof(DynamicBoneHelper))

				if var_267_2 then
					var_267_2:EnableDynamicBone(false)
				end
			end

			local var_267_3 = 0.001

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_3 then
				local var_267_4 = (arg_264_1.time_ - var_267_1) / var_267_3
				local var_267_5 = Vector3.New(0, -1, -6.05)

				var_267_0.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10175ui_story, var_267_5, var_267_4)

				local var_267_6 = manager.ui.mainCamera.transform.position - var_267_0.position

				var_267_0.forward = Vector3.New(var_267_6.x, var_267_6.y, var_267_6.z)

				local var_267_7 = var_267_0.localEulerAngles

				var_267_7.z = 0
				var_267_7.x = 0
				var_267_0.localEulerAngles = var_267_7
			end

			if arg_264_1.time_ >= var_267_1 + var_267_3 and arg_264_1.time_ < var_267_1 + var_267_3 + arg_267_0 then
				var_267_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_267_8 = manager.ui.mainCamera.transform.position - var_267_0.position

				var_267_0.forward = Vector3.New(var_267_8.x, var_267_8.y, var_267_8.z)

				local var_267_9 = var_267_0.localEulerAngles

				var_267_9.z = 0
				var_267_9.x = 0
				var_267_0.localEulerAngles = var_267_9

				local var_267_10 = GameObjectTools.GetOrAddComponent(var_267_0.gameObject, typeof(DynamicBoneHelper))

				if var_267_10 then
					var_267_10:EnableDynamicBone(true)
				end
			end

			local var_267_11 = arg_264_1.actors_["10175ui_story"]
			local var_267_12 = 0

			if var_267_12 < arg_264_1.time_ and arg_264_1.time_ <= var_267_12 + arg_267_0 and not isNil(var_267_11) and arg_264_1.var_.characterEffect10175ui_story == nil then
				arg_264_1.var_.characterEffect10175ui_story = var_267_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_13 = 0.200000002980232

			if var_267_12 <= arg_264_1.time_ and arg_264_1.time_ < var_267_12 + var_267_13 and not isNil(var_267_11) then
				local var_267_14 = (arg_264_1.time_ - var_267_12) / var_267_13

				if arg_264_1.var_.characterEffect10175ui_story and not isNil(var_267_11) then
					arg_264_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= var_267_12 + var_267_13 and arg_264_1.time_ < var_267_12 + var_267_13 + arg_267_0 and not isNil(var_267_11) and arg_264_1.var_.characterEffect10175ui_story then
				arg_264_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_267_15 = 0

			if var_267_15 < arg_264_1.time_ and arg_264_1.time_ <= var_267_15 + arg_267_0 then
				arg_264_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action2_2")
			end

			local var_267_16 = 0

			if var_267_16 < arg_264_1.time_ and arg_264_1.time_ <= var_267_16 + arg_267_0 then
				arg_264_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_267_17 = 0
			local var_267_18 = 0.25

			if var_267_17 < arg_264_1.time_ and arg_264_1.time_ <= var_267_17 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_19 = arg_264_1:FormatText(StoryNameCfg[1473].name)

				arg_264_1.leftNameTxt_.text = var_267_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_20 = arg_264_1:GetWordFromCfg(325571066)
				local var_267_21 = arg_264_1:FormatText(var_267_20.content)

				arg_264_1.text_.text = var_267_21

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_22 = 10
				local var_267_23 = utf8.len(var_267_21)
				local var_267_24 = var_267_22 <= 0 and var_267_18 or var_267_18 * (var_267_23 / var_267_22)

				if var_267_24 > 0 and var_267_18 < var_267_24 then
					arg_264_1.talkMaxDuration = var_267_24

					if var_267_24 + var_267_17 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_24 + var_267_17
					end
				end

				arg_264_1.text_.text = var_267_21
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571066", "story_v_out_325571.awb") ~= 0 then
					local var_267_25 = manager.audio:GetVoiceLength("story_v_out_325571", "325571066", "story_v_out_325571.awb") / 1000

					if var_267_25 + var_267_17 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_25 + var_267_17
					end

					if var_267_20.prefab_name ~= "" and arg_264_1.actors_[var_267_20.prefab_name] ~= nil then
						local var_267_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_20.prefab_name].transform, "story_v_out_325571", "325571066", "story_v_out_325571.awb")

						arg_264_1:RecordAudio("325571066", var_267_26)
						arg_264_1:RecordAudio("325571066", var_267_26)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_325571", "325571066", "story_v_out_325571.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_325571", "325571066", "story_v_out_325571.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_27 = math.max(var_267_18, arg_264_1.talkMaxDuration)

			if var_267_17 <= arg_264_1.time_ and arg_264_1.time_ < var_267_17 + var_267_27 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_17) / var_267_27

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_17 + var_267_27 and arg_264_1.time_ < var_267_17 + var_267_27 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play325571067 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 325571067
		arg_268_1.duration_ = 11.7

		local var_268_0 = {
			zh = 11.7,
			ja = 10
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play325571068(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0
			local var_271_1 = 1.325

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_2 = arg_268_1:FormatText(StoryNameCfg[1473].name)

				arg_268_1.leftNameTxt_.text = var_271_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_3 = arg_268_1:GetWordFromCfg(325571067)
				local var_271_4 = arg_268_1:FormatText(var_271_3.content)

				arg_268_1.text_.text = var_271_4

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_5 = 53
				local var_271_6 = utf8.len(var_271_4)
				local var_271_7 = var_271_5 <= 0 and var_271_1 or var_271_1 * (var_271_6 / var_271_5)

				if var_271_7 > 0 and var_271_1 < var_271_7 then
					arg_268_1.talkMaxDuration = var_271_7

					if var_271_7 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_7 + var_271_0
					end
				end

				arg_268_1.text_.text = var_271_4
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571067", "story_v_out_325571.awb") ~= 0 then
					local var_271_8 = manager.audio:GetVoiceLength("story_v_out_325571", "325571067", "story_v_out_325571.awb") / 1000

					if var_271_8 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_8 + var_271_0
					end

					if var_271_3.prefab_name ~= "" and arg_268_1.actors_[var_271_3.prefab_name] ~= nil then
						local var_271_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_3.prefab_name].transform, "story_v_out_325571", "325571067", "story_v_out_325571.awb")

						arg_268_1:RecordAudio("325571067", var_271_9)
						arg_268_1:RecordAudio("325571067", var_271_9)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_325571", "325571067", "story_v_out_325571.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_325571", "325571067", "story_v_out_325571.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_10 = math.max(var_271_1, arg_268_1.talkMaxDuration)

			if var_271_0 <= arg_268_1.time_ and arg_268_1.time_ < var_271_0 + var_271_10 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_0) / var_271_10

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_0 + var_271_10 and arg_268_1.time_ < var_271_0 + var_271_10 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play325571068 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 325571068
		arg_272_1.duration_ = 10.83

		local var_272_0 = {
			zh = 6.2,
			ja = 10.833
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play325571069(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_1")
			end

			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				arg_272_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_275_2 = 0
			local var_275_3 = 0.6

			if var_275_2 < arg_272_1.time_ and arg_272_1.time_ <= var_275_2 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_4 = arg_272_1:FormatText(StoryNameCfg[1473].name)

				arg_272_1.leftNameTxt_.text = var_275_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_5 = arg_272_1:GetWordFromCfg(325571068)
				local var_275_6 = arg_272_1:FormatText(var_275_5.content)

				arg_272_1.text_.text = var_275_6

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_7 = 24
				local var_275_8 = utf8.len(var_275_6)
				local var_275_9 = var_275_7 <= 0 and var_275_3 or var_275_3 * (var_275_8 / var_275_7)

				if var_275_9 > 0 and var_275_3 < var_275_9 then
					arg_272_1.talkMaxDuration = var_275_9

					if var_275_9 + var_275_2 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_9 + var_275_2
					end
				end

				arg_272_1.text_.text = var_275_6
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571068", "story_v_out_325571.awb") ~= 0 then
					local var_275_10 = manager.audio:GetVoiceLength("story_v_out_325571", "325571068", "story_v_out_325571.awb") / 1000

					if var_275_10 + var_275_2 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_10 + var_275_2
					end

					if var_275_5.prefab_name ~= "" and arg_272_1.actors_[var_275_5.prefab_name] ~= nil then
						local var_275_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_5.prefab_name].transform, "story_v_out_325571", "325571068", "story_v_out_325571.awb")

						arg_272_1:RecordAudio("325571068", var_275_11)
						arg_272_1:RecordAudio("325571068", var_275_11)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_325571", "325571068", "story_v_out_325571.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_325571", "325571068", "story_v_out_325571.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_12 = math.max(var_275_3, arg_272_1.talkMaxDuration)

			if var_275_2 <= arg_272_1.time_ and arg_272_1.time_ < var_275_2 + var_275_12 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_2) / var_275_12

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_2 + var_275_12 and arg_272_1.time_ < var_275_2 + var_275_12 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play325571069 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 325571069
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play325571070(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["10175ui_story"].transform
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.var_.moveOldPos10175ui_story = var_279_0.localPosition

				local var_279_2 = GameObjectTools.GetOrAddComponent(var_279_0.gameObject, typeof(DynamicBoneHelper))

				if var_279_2 then
					var_279_2:EnableDynamicBone(false)
				end
			end

			local var_279_3 = 0.001

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_3 then
				local var_279_4 = (arg_276_1.time_ - var_279_1) / var_279_3
				local var_279_5 = Vector3.New(0, 100, 0)

				var_279_0.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10175ui_story, var_279_5, var_279_4)

				local var_279_6 = manager.ui.mainCamera.transform.position - var_279_0.position

				var_279_0.forward = Vector3.New(var_279_6.x, var_279_6.y, var_279_6.z)

				local var_279_7 = var_279_0.localEulerAngles

				var_279_7.z = 0
				var_279_7.x = 0
				var_279_0.localEulerAngles = var_279_7
			end

			if arg_276_1.time_ >= var_279_1 + var_279_3 and arg_276_1.time_ < var_279_1 + var_279_3 + arg_279_0 then
				var_279_0.localPosition = Vector3.New(0, 100, 0)

				local var_279_8 = manager.ui.mainCamera.transform.position - var_279_0.position

				var_279_0.forward = Vector3.New(var_279_8.x, var_279_8.y, var_279_8.z)

				local var_279_9 = var_279_0.localEulerAngles

				var_279_9.z = 0
				var_279_9.x = 0
				var_279_0.localEulerAngles = var_279_9

				local var_279_10 = GameObjectTools.GetOrAddComponent(var_279_0.gameObject, typeof(DynamicBoneHelper))

				if var_279_10 then
					var_279_10:EnableDynamicBone(true)
				end
			end

			local var_279_11 = arg_276_1.actors_["10175ui_story"]
			local var_279_12 = 0

			if var_279_12 < arg_276_1.time_ and arg_276_1.time_ <= var_279_12 + arg_279_0 and not isNil(var_279_11) and arg_276_1.var_.characterEffect10175ui_story == nil then
				arg_276_1.var_.characterEffect10175ui_story = var_279_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_13 = 0.200000002980232

			if var_279_12 <= arg_276_1.time_ and arg_276_1.time_ < var_279_12 + var_279_13 and not isNil(var_279_11) then
				local var_279_14 = (arg_276_1.time_ - var_279_12) / var_279_13

				if arg_276_1.var_.characterEffect10175ui_story and not isNil(var_279_11) then
					local var_279_15 = Mathf.Lerp(0, 0.5, var_279_14)

					arg_276_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_276_1.var_.characterEffect10175ui_story.fillRatio = var_279_15
				end
			end

			if arg_276_1.time_ >= var_279_12 + var_279_13 and arg_276_1.time_ < var_279_12 + var_279_13 + arg_279_0 and not isNil(var_279_11) and arg_276_1.var_.characterEffect10175ui_story then
				local var_279_16 = 0.5

				arg_276_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_276_1.var_.characterEffect10175ui_story.fillRatio = var_279_16
			end

			local var_279_17 = 0
			local var_279_18 = 1.1

			if var_279_17 < arg_276_1.time_ and arg_276_1.time_ <= var_279_17 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_19 = arg_276_1:GetWordFromCfg(325571069)
				local var_279_20 = arg_276_1:FormatText(var_279_19.content)

				arg_276_1.text_.text = var_279_20

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_21 = 44
				local var_279_22 = utf8.len(var_279_20)
				local var_279_23 = var_279_21 <= 0 and var_279_18 or var_279_18 * (var_279_22 / var_279_21)

				if var_279_23 > 0 and var_279_18 < var_279_23 then
					arg_276_1.talkMaxDuration = var_279_23

					if var_279_23 + var_279_17 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_23 + var_279_17
					end
				end

				arg_276_1.text_.text = var_279_20
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_24 = math.max(var_279_18, arg_276_1.talkMaxDuration)

			if var_279_17 <= arg_276_1.time_ and arg_276_1.time_ < var_279_17 + var_279_24 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_17) / var_279_24

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_17 + var_279_24 and arg_276_1.time_ < var_279_17 + var_279_24 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play325571070 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 325571070
		arg_280_1.duration_ = 11.17

		local var_280_0 = {
			zh = 7.5,
			ja = 11.166
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play325571071(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["10175ui_story"].transform
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.var_.moveOldPos10175ui_story = var_283_0.localPosition

				local var_283_2 = GameObjectTools.GetOrAddComponent(var_283_0.gameObject, typeof(DynamicBoneHelper))

				if var_283_2 then
					var_283_2:EnableDynamicBone(false)
				end
			end

			local var_283_3 = 0.001

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_3 then
				local var_283_4 = (arg_280_1.time_ - var_283_1) / var_283_3
				local var_283_5 = Vector3.New(0, -1, -6.05)

				var_283_0.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10175ui_story, var_283_5, var_283_4)

				local var_283_6 = manager.ui.mainCamera.transform.position - var_283_0.position

				var_283_0.forward = Vector3.New(var_283_6.x, var_283_6.y, var_283_6.z)

				local var_283_7 = var_283_0.localEulerAngles

				var_283_7.z = 0
				var_283_7.x = 0
				var_283_0.localEulerAngles = var_283_7
			end

			if arg_280_1.time_ >= var_283_1 + var_283_3 and arg_280_1.time_ < var_283_1 + var_283_3 + arg_283_0 then
				var_283_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_283_8 = manager.ui.mainCamera.transform.position - var_283_0.position

				var_283_0.forward = Vector3.New(var_283_8.x, var_283_8.y, var_283_8.z)

				local var_283_9 = var_283_0.localEulerAngles

				var_283_9.z = 0
				var_283_9.x = 0
				var_283_0.localEulerAngles = var_283_9

				local var_283_10 = GameObjectTools.GetOrAddComponent(var_283_0.gameObject, typeof(DynamicBoneHelper))

				if var_283_10 then
					var_283_10:EnableDynamicBone(true)
				end
			end

			local var_283_11 = arg_280_1.actors_["10175ui_story"]
			local var_283_12 = 0

			if var_283_12 < arg_280_1.time_ and arg_280_1.time_ <= var_283_12 + arg_283_0 and not isNil(var_283_11) and arg_280_1.var_.characterEffect10175ui_story == nil then
				arg_280_1.var_.characterEffect10175ui_story = var_283_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_13 = 0.200000002980232

			if var_283_12 <= arg_280_1.time_ and arg_280_1.time_ < var_283_12 + var_283_13 and not isNil(var_283_11) then
				local var_283_14 = (arg_280_1.time_ - var_283_12) / var_283_13

				if arg_280_1.var_.characterEffect10175ui_story and not isNil(var_283_11) then
					arg_280_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= var_283_12 + var_283_13 and arg_280_1.time_ < var_283_12 + var_283_13 + arg_283_0 and not isNil(var_283_11) and arg_280_1.var_.characterEffect10175ui_story then
				arg_280_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_283_15 = 0
			local var_283_16 = 0.85

			if var_283_15 < arg_280_1.time_ and arg_280_1.time_ <= var_283_15 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_17 = arg_280_1:FormatText(StoryNameCfg[1473].name)

				arg_280_1.leftNameTxt_.text = var_283_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_18 = arg_280_1:GetWordFromCfg(325571070)
				local var_283_19 = arg_280_1:FormatText(var_283_18.content)

				arg_280_1.text_.text = var_283_19

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_20 = 34
				local var_283_21 = utf8.len(var_283_19)
				local var_283_22 = var_283_20 <= 0 and var_283_16 or var_283_16 * (var_283_21 / var_283_20)

				if var_283_22 > 0 and var_283_16 < var_283_22 then
					arg_280_1.talkMaxDuration = var_283_22

					if var_283_22 + var_283_15 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_22 + var_283_15
					end
				end

				arg_280_1.text_.text = var_283_19
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571070", "story_v_out_325571.awb") ~= 0 then
					local var_283_23 = manager.audio:GetVoiceLength("story_v_out_325571", "325571070", "story_v_out_325571.awb") / 1000

					if var_283_23 + var_283_15 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_23 + var_283_15
					end

					if var_283_18.prefab_name ~= "" and arg_280_1.actors_[var_283_18.prefab_name] ~= nil then
						local var_283_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_18.prefab_name].transform, "story_v_out_325571", "325571070", "story_v_out_325571.awb")

						arg_280_1:RecordAudio("325571070", var_283_24)
						arg_280_1:RecordAudio("325571070", var_283_24)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_325571", "325571070", "story_v_out_325571.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_325571", "325571070", "story_v_out_325571.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_25 = math.max(var_283_16, arg_280_1.talkMaxDuration)

			if var_283_15 <= arg_280_1.time_ and arg_280_1.time_ < var_283_15 + var_283_25 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_15) / var_283_25

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_15 + var_283_25 and arg_280_1.time_ < var_283_15 + var_283_25 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play325571071 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 325571071
		arg_284_1.duration_ = 8

		local var_284_0 = {
			zh = 7.133,
			ja = 8
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play325571072(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0

			if var_287_0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				arg_284_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_2")
			end

			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_287_2 = 0
			local var_287_3 = 0.8

			if var_287_2 < arg_284_1.time_ and arg_284_1.time_ <= var_287_2 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_4 = arg_284_1:FormatText(StoryNameCfg[1473].name)

				arg_284_1.leftNameTxt_.text = var_287_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_5 = arg_284_1:GetWordFromCfg(325571071)
				local var_287_6 = arg_284_1:FormatText(var_287_5.content)

				arg_284_1.text_.text = var_287_6

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_7 = 32
				local var_287_8 = utf8.len(var_287_6)
				local var_287_9 = var_287_7 <= 0 and var_287_3 or var_287_3 * (var_287_8 / var_287_7)

				if var_287_9 > 0 and var_287_3 < var_287_9 then
					arg_284_1.talkMaxDuration = var_287_9

					if var_287_9 + var_287_2 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_9 + var_287_2
					end
				end

				arg_284_1.text_.text = var_287_6
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571071", "story_v_out_325571.awb") ~= 0 then
					local var_287_10 = manager.audio:GetVoiceLength("story_v_out_325571", "325571071", "story_v_out_325571.awb") / 1000

					if var_287_10 + var_287_2 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_10 + var_287_2
					end

					if var_287_5.prefab_name ~= "" and arg_284_1.actors_[var_287_5.prefab_name] ~= nil then
						local var_287_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_5.prefab_name].transform, "story_v_out_325571", "325571071", "story_v_out_325571.awb")

						arg_284_1:RecordAudio("325571071", var_287_11)
						arg_284_1:RecordAudio("325571071", var_287_11)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_325571", "325571071", "story_v_out_325571.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_325571", "325571071", "story_v_out_325571.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_12 = math.max(var_287_3, arg_284_1.talkMaxDuration)

			if var_287_2 <= arg_284_1.time_ and arg_284_1.time_ < var_287_2 + var_287_12 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_2) / var_287_12

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_2 + var_287_12 and arg_284_1.time_ < var_287_2 + var_287_12 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play325571072 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 325571072
		arg_288_1.duration_ = 17.7

		local var_288_0 = {
			zh = 12.8,
			ja = 17.7
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play325571073(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0
			local var_291_1 = 1.5

			if var_291_0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_2 = arg_288_1:FormatText(StoryNameCfg[1473].name)

				arg_288_1.leftNameTxt_.text = var_291_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_3 = arg_288_1:GetWordFromCfg(325571072)
				local var_291_4 = arg_288_1:FormatText(var_291_3.content)

				arg_288_1.text_.text = var_291_4

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_5 = 60
				local var_291_6 = utf8.len(var_291_4)
				local var_291_7 = var_291_5 <= 0 and var_291_1 or var_291_1 * (var_291_6 / var_291_5)

				if var_291_7 > 0 and var_291_1 < var_291_7 then
					arg_288_1.talkMaxDuration = var_291_7

					if var_291_7 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_0
					end
				end

				arg_288_1.text_.text = var_291_4
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571072", "story_v_out_325571.awb") ~= 0 then
					local var_291_8 = manager.audio:GetVoiceLength("story_v_out_325571", "325571072", "story_v_out_325571.awb") / 1000

					if var_291_8 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_0
					end

					if var_291_3.prefab_name ~= "" and arg_288_1.actors_[var_291_3.prefab_name] ~= nil then
						local var_291_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_3.prefab_name].transform, "story_v_out_325571", "325571072", "story_v_out_325571.awb")

						arg_288_1:RecordAudio("325571072", var_291_9)
						arg_288_1:RecordAudio("325571072", var_291_9)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_325571", "325571072", "story_v_out_325571.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_325571", "325571072", "story_v_out_325571.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_10 = math.max(var_291_1, arg_288_1.talkMaxDuration)

			if var_291_0 <= arg_288_1.time_ and arg_288_1.time_ < var_291_0 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_0) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_0 + var_291_10 and arg_288_1.time_ < var_291_0 + var_291_10 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play325571073 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 325571073
		arg_292_1.duration_ = 14.7

		local var_292_0 = {
			zh = 10.466,
			ja = 14.7
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play325571074(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0

			if var_295_0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				arg_292_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action2_1")
			end

			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_295_2 = 0
			local var_295_3 = 1.025

			if var_295_2 < arg_292_1.time_ and arg_292_1.time_ <= var_295_2 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_4 = arg_292_1:FormatText(StoryNameCfg[1473].name)

				arg_292_1.leftNameTxt_.text = var_295_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_5 = arg_292_1:GetWordFromCfg(325571073)
				local var_295_6 = arg_292_1:FormatText(var_295_5.content)

				arg_292_1.text_.text = var_295_6

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_7 = 41
				local var_295_8 = utf8.len(var_295_6)
				local var_295_9 = var_295_7 <= 0 and var_295_3 or var_295_3 * (var_295_8 / var_295_7)

				if var_295_9 > 0 and var_295_3 < var_295_9 then
					arg_292_1.talkMaxDuration = var_295_9

					if var_295_9 + var_295_2 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_9 + var_295_2
					end
				end

				arg_292_1.text_.text = var_295_6
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571073", "story_v_out_325571.awb") ~= 0 then
					local var_295_10 = manager.audio:GetVoiceLength("story_v_out_325571", "325571073", "story_v_out_325571.awb") / 1000

					if var_295_10 + var_295_2 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_10 + var_295_2
					end

					if var_295_5.prefab_name ~= "" and arg_292_1.actors_[var_295_5.prefab_name] ~= nil then
						local var_295_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_5.prefab_name].transform, "story_v_out_325571", "325571073", "story_v_out_325571.awb")

						arg_292_1:RecordAudio("325571073", var_295_11)
						arg_292_1:RecordAudio("325571073", var_295_11)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_325571", "325571073", "story_v_out_325571.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_325571", "325571073", "story_v_out_325571.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_12 = math.max(var_295_3, arg_292_1.talkMaxDuration)

			if var_295_2 <= arg_292_1.time_ and arg_292_1.time_ < var_295_2 + var_295_12 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_2) / var_295_12

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_2 + var_295_12 and arg_292_1.time_ < var_295_2 + var_295_12 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play325571074 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 325571074
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play325571075(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["10175ui_story"].transform
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.var_.moveOldPos10175ui_story = var_299_0.localPosition

				local var_299_2 = GameObjectTools.GetOrAddComponent(var_299_0.gameObject, typeof(DynamicBoneHelper))

				if var_299_2 then
					var_299_2:EnableDynamicBone(false)
				end
			end

			local var_299_3 = 0.001

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_3 then
				local var_299_4 = (arg_296_1.time_ - var_299_1) / var_299_3
				local var_299_5 = Vector3.New(0, 100, 0)

				var_299_0.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10175ui_story, var_299_5, var_299_4)

				local var_299_6 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_6.x, var_299_6.y, var_299_6.z)

				local var_299_7 = var_299_0.localEulerAngles

				var_299_7.z = 0
				var_299_7.x = 0
				var_299_0.localEulerAngles = var_299_7
			end

			if arg_296_1.time_ >= var_299_1 + var_299_3 and arg_296_1.time_ < var_299_1 + var_299_3 + arg_299_0 then
				var_299_0.localPosition = Vector3.New(0, 100, 0)

				local var_299_8 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_8.x, var_299_8.y, var_299_8.z)

				local var_299_9 = var_299_0.localEulerAngles

				var_299_9.z = 0
				var_299_9.x = 0
				var_299_0.localEulerAngles = var_299_9

				local var_299_10 = GameObjectTools.GetOrAddComponent(var_299_0.gameObject, typeof(DynamicBoneHelper))

				if var_299_10 then
					var_299_10:EnableDynamicBone(true)
				end
			end

			local var_299_11 = arg_296_1.actors_["10175ui_story"]
			local var_299_12 = 0

			if var_299_12 < arg_296_1.time_ and arg_296_1.time_ <= var_299_12 + arg_299_0 and not isNil(var_299_11) and arg_296_1.var_.characterEffect10175ui_story == nil then
				arg_296_1.var_.characterEffect10175ui_story = var_299_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_13 = 0.200000002980232

			if var_299_12 <= arg_296_1.time_ and arg_296_1.time_ < var_299_12 + var_299_13 and not isNil(var_299_11) then
				local var_299_14 = (arg_296_1.time_ - var_299_12) / var_299_13

				if arg_296_1.var_.characterEffect10175ui_story and not isNil(var_299_11) then
					local var_299_15 = Mathf.Lerp(0, 0.5, var_299_14)

					arg_296_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_296_1.var_.characterEffect10175ui_story.fillRatio = var_299_15
				end
			end

			if arg_296_1.time_ >= var_299_12 + var_299_13 and arg_296_1.time_ < var_299_12 + var_299_13 + arg_299_0 and not isNil(var_299_11) and arg_296_1.var_.characterEffect10175ui_story then
				local var_299_16 = 0.5

				arg_296_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_296_1.var_.characterEffect10175ui_story.fillRatio = var_299_16
			end

			local var_299_17 = 0
			local var_299_18 = 1.075

			if var_299_17 < arg_296_1.time_ and arg_296_1.time_ <= var_299_17 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_19 = arg_296_1:GetWordFromCfg(325571074)
				local var_299_20 = arg_296_1:FormatText(var_299_19.content)

				arg_296_1.text_.text = var_299_20

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_21 = 43
				local var_299_22 = utf8.len(var_299_20)
				local var_299_23 = var_299_21 <= 0 and var_299_18 or var_299_18 * (var_299_22 / var_299_21)

				if var_299_23 > 0 and var_299_18 < var_299_23 then
					arg_296_1.talkMaxDuration = var_299_23

					if var_299_23 + var_299_17 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_23 + var_299_17
					end
				end

				arg_296_1.text_.text = var_299_20
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_24 = math.max(var_299_18, arg_296_1.talkMaxDuration)

			if var_299_17 <= arg_296_1.time_ and arg_296_1.time_ < var_299_17 + var_299_24 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_17) / var_299_24

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_17 + var_299_24 and arg_296_1.time_ < var_299_17 + var_299_24 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play325571075 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 325571075
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play325571076(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0
			local var_303_1 = 0.625

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_2 = arg_300_1:GetWordFromCfg(325571075)
				local var_303_3 = arg_300_1:FormatText(var_303_2.content)

				arg_300_1.text_.text = var_303_3

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_4 = 25
				local var_303_5 = utf8.len(var_303_3)
				local var_303_6 = var_303_4 <= 0 and var_303_1 or var_303_1 * (var_303_5 / var_303_4)

				if var_303_6 > 0 and var_303_1 < var_303_6 then
					arg_300_1.talkMaxDuration = var_303_6

					if var_303_6 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_6 + var_303_0
					end
				end

				arg_300_1.text_.text = var_303_3
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_7 = math.max(var_303_1, arg_300_1.talkMaxDuration)

			if var_303_0 <= arg_300_1.time_ and arg_300_1.time_ < var_303_0 + var_303_7 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_0) / var_303_7

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_0 + var_303_7 and arg_300_1.time_ < var_303_0 + var_303_7 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play325571076 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 325571076
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
			arg_304_1.auto_ = false
		end

		function arg_304_1.playNext_(arg_306_0)
			arg_304_1.onStoryFinished_()
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 1

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				local var_307_2 = "play"
				local var_307_3 = "effect"

				arg_304_1:AudioAction(var_307_2, var_307_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_307_4 = 0
			local var_307_5 = 1.175

			if var_307_4 < arg_304_1.time_ and arg_304_1.time_ <= var_307_4 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_6 = arg_304_1:GetWordFromCfg(325571076)
				local var_307_7 = arg_304_1:FormatText(var_307_6.content)

				arg_304_1.text_.text = var_307_7

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_8 = 47
				local var_307_9 = utf8.len(var_307_7)
				local var_307_10 = var_307_8 <= 0 and var_307_5 or var_307_5 * (var_307_9 / var_307_8)

				if var_307_10 > 0 and var_307_5 < var_307_10 then
					arg_304_1.talkMaxDuration = var_307_10

					if var_307_10 + var_307_4 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_10 + var_307_4
					end
				end

				arg_304_1.text_.text = var_307_7
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_11 = math.max(var_307_5, arg_304_1.talkMaxDuration)

			if var_307_4 <= arg_304_1.time_ and arg_304_1.time_ < var_307_4 + var_307_11 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_4) / var_307_11

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_4 + var_307_11 and arg_304_1.time_ < var_307_4 + var_307_11 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2006a",
		"TextureConfig/Background/J21h"
	},
	voices = {
		"story_v_out_325571.awb"
	}
}
