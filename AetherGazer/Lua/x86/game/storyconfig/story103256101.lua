return {
	Play325611001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325611001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325611002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J26h"

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
				local var_4_5 = arg_1_1.bgs_.J26h

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
					if iter_4_0 ~= "J26h" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.999999999999

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

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_122_01", "se_story_122_01_battleground_loop", "")
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

			local var_4_34 = 1.999999999999
			local var_4_35 = 0.5

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

				local var_4_37 = arg_1_1:GetWordFromCfg(325611001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 20
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
	Play325611002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325611002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325611003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1

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

				local var_11_2 = arg_8_1:GetWordFromCfg(325611002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 40
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
	Play325611003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325611003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325611004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.325

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

				local var_15_2 = arg_12_1:GetWordFromCfg(325611003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 53
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
	Play325611004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325611004
		arg_16_1.duration_ = 6.3

		local var_16_0 = {
			zh = 5.266,
			ja = 6.3
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
				arg_16_0:Play325611005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "6148ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["6148ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos6148ui_story = var_19_5.localPosition

				local var_19_7 = GameObjectTools.GetOrAddComponent(var_19_5.gameObject, typeof(DynamicBoneHelper))

				if var_19_7 then
					var_19_7:EnableDynamicBone(false)
				end
			end

			local var_19_8 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_8 then
				local var_19_9 = (arg_16_1.time_ - var_19_6) / var_19_8
				local var_19_10 = Vector3.New(0, -0.985, -6)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos6148ui_story, var_19_10, var_19_9)

				local var_19_11 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_11.x, var_19_11.y, var_19_11.z)

				local var_19_12 = var_19_5.localEulerAngles

				var_19_12.z = 0
				var_19_12.x = 0
				var_19_5.localEulerAngles = var_19_12
			end

			if arg_16_1.time_ >= var_19_6 + var_19_8 and arg_16_1.time_ < var_19_6 + var_19_8 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(0, -0.985, -6)

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

			local var_19_16 = arg_16_1.actors_["6148ui_story"]
			local var_19_17 = 0

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 and not isNil(var_19_16) and arg_16_1.var_.characterEffect6148ui_story == nil then
				arg_16_1.var_.characterEffect6148ui_story = var_19_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_18 = 0.200000002980232

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_18 and not isNil(var_19_16) then
				local var_19_19 = (arg_16_1.time_ - var_19_17) / var_19_18

				if arg_16_1.var_.characterEffect6148ui_story and not isNil(var_19_16) then
					arg_16_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_17 + var_19_18 and arg_16_1.time_ < var_19_17 + var_19_18 + arg_19_0 and not isNil(var_19_16) and arg_16_1.var_.characterEffect6148ui_story then
				arg_16_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_19_20 = 0

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_19_21 = 0

			if var_19_21 < arg_16_1.time_ and arg_16_1.time_ <= var_19_21 + arg_19_0 then
				arg_16_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_19_22 = 0
			local var_19_23 = 0.525

			if var_19_22 < arg_16_1.time_ and arg_16_1.time_ <= var_19_22 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_24 = arg_16_1:FormatText(StoryNameCfg[1488].name)

				arg_16_1.leftNameTxt_.text = var_19_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_25 = arg_16_1:GetWordFromCfg(325611004)
				local var_19_26 = arg_16_1:FormatText(var_19_25.content)

				arg_16_1.text_.text = var_19_26

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_27 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611004", "story_v_out_325611.awb") ~= 0 then
					local var_19_30 = manager.audio:GetVoiceLength("story_v_out_325611", "325611004", "story_v_out_325611.awb") / 1000

					if var_19_30 + var_19_22 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_30 + var_19_22
					end

					if var_19_25.prefab_name ~= "" and arg_16_1.actors_[var_19_25.prefab_name] ~= nil then
						local var_19_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_25.prefab_name].transform, "story_v_out_325611", "325611004", "story_v_out_325611.awb")

						arg_16_1:RecordAudio("325611004", var_19_31)
						arg_16_1:RecordAudio("325611004", var_19_31)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325611", "325611004", "story_v_out_325611.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325611", "325611004", "story_v_out_325611.awb")
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
				actorName = "6148ui_story",
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
	Play325611005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325611005
		arg_20_1.duration_ = 4.4

		local var_20_0 = {
			zh = 3.3,
			ja = 4.4
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
				arg_20_0:Play325611006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.425

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[1488].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_3 = arg_20_1:GetWordFromCfg(325611005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 17
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611005", "story_v_out_325611.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_325611", "325611005", "story_v_out_325611.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_325611", "325611005", "story_v_out_325611.awb")

						arg_20_1:RecordAudio("325611005", var_23_9)
						arg_20_1:RecordAudio("325611005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325611", "325611005", "story_v_out_325611.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325611", "325611005", "story_v_out_325611.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_10 and arg_20_1.time_ < var_23_0 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play325611006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325611006
		arg_24_1.duration_ = 2.93

		local var_24_0 = {
			zh = 2.366,
			ja = 2.933
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
				arg_24_0:Play325611007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["6148ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos6148ui_story = var_27_0.localPosition

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end
			end

			local var_27_3 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_3 then
				local var_27_4 = (arg_24_1.time_ - var_27_1) / var_27_3
				local var_27_5 = Vector3.New(-0.7, -0.985, -6)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos6148ui_story, var_27_5, var_27_4)

				local var_27_6 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_6.x, var_27_6.y, var_27_6.z)

				local var_27_7 = var_27_0.localEulerAngles

				var_27_7.z = 0
				var_27_7.x = 0
				var_27_0.localEulerAngles = var_27_7
			end

			if arg_24_1.time_ >= var_27_1 + var_27_3 and arg_24_1.time_ < var_27_1 + var_27_3 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(-0.7, -0.985, -6)

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

			local var_27_11 = "10175ui_story"

			if arg_24_1.actors_[var_27_11] == nil then
				local var_27_12 = Asset.Load("Char/" .. "10175ui_story")

				if not isNil(var_27_12) then
					local var_27_13 = Object.Instantiate(Asset.Load("Char/" .. "10175ui_story"), arg_24_1.stage_.transform)

					var_27_13.name = var_27_11
					var_27_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_11] = var_27_13

					local var_27_14 = var_27_13:GetComponentInChildren(typeof(CharacterEffect))

					var_27_14.enabled = true

					local var_27_15 = GameObjectTools.GetOrAddComponent(var_27_13, typeof(DynamicBoneHelper))

					if var_27_15 then
						var_27_15:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_14.transform, false)

					arg_24_1.var_[var_27_11 .. "Animator"] = var_27_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_11 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_11 .. "LipSync"] = var_27_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_16 = arg_24_1.actors_["10175ui_story"].transform
			local var_27_17 = 0

			if var_27_17 < arg_24_1.time_ and arg_24_1.time_ <= var_27_17 + arg_27_0 then
				arg_24_1.var_.moveOldPos10175ui_story = var_27_16.localPosition

				local var_27_18 = GameObjectTools.GetOrAddComponent(var_27_16.gameObject, typeof(DynamicBoneHelper))

				if var_27_18 then
					var_27_18:EnableDynamicBone(false)
				end
			end

			local var_27_19 = 0.001

			if var_27_17 <= arg_24_1.time_ and arg_24_1.time_ < var_27_17 + var_27_19 then
				local var_27_20 = (arg_24_1.time_ - var_27_17) / var_27_19
				local var_27_21 = Vector3.New(0.7, -1, -6.05)

				var_27_16.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10175ui_story, var_27_21, var_27_20)

				local var_27_22 = manager.ui.mainCamera.transform.position - var_27_16.position

				var_27_16.forward = Vector3.New(var_27_22.x, var_27_22.y, var_27_22.z)

				local var_27_23 = var_27_16.localEulerAngles

				var_27_23.z = 0
				var_27_23.x = 0
				var_27_16.localEulerAngles = var_27_23
			end

			if arg_24_1.time_ >= var_27_17 + var_27_19 and arg_24_1.time_ < var_27_17 + var_27_19 + arg_27_0 then
				var_27_16.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_27_24 = manager.ui.mainCamera.transform.position - var_27_16.position

				var_27_16.forward = Vector3.New(var_27_24.x, var_27_24.y, var_27_24.z)

				local var_27_25 = var_27_16.localEulerAngles

				var_27_25.z = 0
				var_27_25.x = 0
				var_27_16.localEulerAngles = var_27_25

				local var_27_26 = GameObjectTools.GetOrAddComponent(var_27_16.gameObject, typeof(DynamicBoneHelper))

				if var_27_26 then
					var_27_26:EnableDynamicBone(true)
				end
			end

			local var_27_27 = arg_24_1.actors_["10175ui_story"]
			local var_27_28 = 0

			if var_27_28 < arg_24_1.time_ and arg_24_1.time_ <= var_27_28 + arg_27_0 and not isNil(var_27_27) and arg_24_1.var_.characterEffect10175ui_story == nil then
				arg_24_1.var_.characterEffect10175ui_story = var_27_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_29 = 0.200000002980232

			if var_27_28 <= arg_24_1.time_ and arg_24_1.time_ < var_27_28 + var_27_29 and not isNil(var_27_27) then
				local var_27_30 = (arg_24_1.time_ - var_27_28) / var_27_29

				if arg_24_1.var_.characterEffect10175ui_story and not isNil(var_27_27) then
					arg_24_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_28 + var_27_29 and arg_24_1.time_ < var_27_28 + var_27_29 + arg_27_0 and not isNil(var_27_27) and arg_24_1.var_.characterEffect10175ui_story then
				arg_24_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_27_31 = arg_24_1.actors_["6148ui_story"]
			local var_27_32 = 0

			if var_27_32 < arg_24_1.time_ and arg_24_1.time_ <= var_27_32 + arg_27_0 and not isNil(var_27_31) and arg_24_1.var_.characterEffect6148ui_story == nil then
				arg_24_1.var_.characterEffect6148ui_story = var_27_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_33 = 0.200000002980232

			if var_27_32 <= arg_24_1.time_ and arg_24_1.time_ < var_27_32 + var_27_33 and not isNil(var_27_31) then
				local var_27_34 = (arg_24_1.time_ - var_27_32) / var_27_33

				if arg_24_1.var_.characterEffect6148ui_story and not isNil(var_27_31) then
					local var_27_35 = Mathf.Lerp(0, 0.5, var_27_34)

					arg_24_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_24_1.var_.characterEffect6148ui_story.fillRatio = var_27_35
				end
			end

			if arg_24_1.time_ >= var_27_32 + var_27_33 and arg_24_1.time_ < var_27_32 + var_27_33 + arg_27_0 and not isNil(var_27_31) and arg_24_1.var_.characterEffect6148ui_story then
				local var_27_36 = 0.5

				arg_24_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_24_1.var_.characterEffect6148ui_story.fillRatio = var_27_36
			end

			local var_27_37 = 0

			if var_27_37 < arg_24_1.time_ and arg_24_1.time_ <= var_27_37 + arg_27_0 then
				arg_24_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			local var_27_38 = 0

			if var_27_38 < arg_24_1.time_ and arg_24_1.time_ <= var_27_38 + arg_27_0 then
				arg_24_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_27_39 = 0
			local var_27_40 = 0.325

			if var_27_39 < arg_24_1.time_ and arg_24_1.time_ <= var_27_39 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_41 = arg_24_1:FormatText(StoryNameCfg[1473].name)

				arg_24_1.leftNameTxt_.text = var_27_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_42 = arg_24_1:GetWordFromCfg(325611006)
				local var_27_43 = arg_24_1:FormatText(var_27_42.content)

				arg_24_1.text_.text = var_27_43

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_44 = 13
				local var_27_45 = utf8.len(var_27_43)
				local var_27_46 = var_27_44 <= 0 and var_27_40 or var_27_40 * (var_27_45 / var_27_44)

				if var_27_46 > 0 and var_27_40 < var_27_46 then
					arg_24_1.talkMaxDuration = var_27_46

					if var_27_46 + var_27_39 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_46 + var_27_39
					end
				end

				arg_24_1.text_.text = var_27_43
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611006", "story_v_out_325611.awb") ~= 0 then
					local var_27_47 = manager.audio:GetVoiceLength("story_v_out_325611", "325611006", "story_v_out_325611.awb") / 1000

					if var_27_47 + var_27_39 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_47 + var_27_39
					end

					if var_27_42.prefab_name ~= "" and arg_24_1.actors_[var_27_42.prefab_name] ~= nil then
						local var_27_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_42.prefab_name].transform, "story_v_out_325611", "325611006", "story_v_out_325611.awb")

						arg_24_1:RecordAudio("325611006", var_27_48)
						arg_24_1:RecordAudio("325611006", var_27_48)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325611", "325611006", "story_v_out_325611.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325611", "325611006", "story_v_out_325611.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_49 = math.max(var_27_40, arg_24_1.talkMaxDuration)

			if var_27_39 <= arg_24_1.time_ and arg_24_1.time_ < var_27_39 + var_27_49 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_39) / var_27_49

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_39 + var_27_49 and arg_24_1.time_ < var_27_39 + var_27_49 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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

		arg_24_1:InitPlayNodeList()
	end,
	Play325611007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325611007
		arg_28_1.duration_ = 2.83

		local var_28_0 = {
			zh = 2.833,
			ja = 2.2
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
				arg_28_0:Play325611008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["6148ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect6148ui_story == nil then
				arg_28_1.var_.characterEffect6148ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect6148ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect6148ui_story then
				arg_28_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["10175ui_story"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect10175ui_story == nil then
				arg_28_1.var_.characterEffect10175ui_story = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.200000002980232

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect10175ui_story and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10175ui_story.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect10175ui_story then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10175ui_story.fillRatio = var_31_9
			end

			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_31_11 = 0

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_31_12 = 0
			local var_31_13 = 0.3

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_14 = arg_28_1:FormatText(StoryNameCfg[1488].name)

				arg_28_1.leftNameTxt_.text = var_31_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_15 = arg_28_1:GetWordFromCfg(325611007)
				local var_31_16 = arg_28_1:FormatText(var_31_15.content)

				arg_28_1.text_.text = var_31_16

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_17 = 12
				local var_31_18 = utf8.len(var_31_16)
				local var_31_19 = var_31_17 <= 0 and var_31_13 or var_31_13 * (var_31_18 / var_31_17)

				if var_31_19 > 0 and var_31_13 < var_31_19 then
					arg_28_1.talkMaxDuration = var_31_19

					if var_31_19 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_19 + var_31_12
					end
				end

				arg_28_1.text_.text = var_31_16
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611007", "story_v_out_325611.awb") ~= 0 then
					local var_31_20 = manager.audio:GetVoiceLength("story_v_out_325611", "325611007", "story_v_out_325611.awb") / 1000

					if var_31_20 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_20 + var_31_12
					end

					if var_31_15.prefab_name ~= "" and arg_28_1.actors_[var_31_15.prefab_name] ~= nil then
						local var_31_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_15.prefab_name].transform, "story_v_out_325611", "325611007", "story_v_out_325611.awb")

						arg_28_1:RecordAudio("325611007", var_31_21)
						arg_28_1:RecordAudio("325611007", var_31_21)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325611", "325611007", "story_v_out_325611.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325611", "325611007", "story_v_out_325611.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_22 = math.max(var_31_13, arg_28_1.talkMaxDuration)

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_22 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_12) / var_31_22

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_12 + var_31_22 and arg_28_1.time_ < var_31_12 + var_31_22 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play325611008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325611008
		arg_32_1.duration_ = 4.7

		local var_32_0 = {
			zh = 3.033,
			ja = 4.7
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
				arg_32_0:Play325611009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10175ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect10175ui_story == nil then
				arg_32_1.var_.characterEffect10175ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect10175ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect10175ui_story then
				arg_32_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["6148ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect6148ui_story == nil then
				arg_32_1.var_.characterEffect6148ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.200000002980232

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect6148ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_32_1.var_.characterEffect6148ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect6148ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_32_1.var_.characterEffect6148ui_story.fillRatio = var_35_9
			end

			local var_35_10 = 0
			local var_35_11 = 0.425

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_12 = arg_32_1:FormatText(StoryNameCfg[1473].name)

				arg_32_1.leftNameTxt_.text = var_35_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_13 = arg_32_1:GetWordFromCfg(325611008)
				local var_35_14 = arg_32_1:FormatText(var_35_13.content)

				arg_32_1.text_.text = var_35_14

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_15 = 17
				local var_35_16 = utf8.len(var_35_14)
				local var_35_17 = var_35_15 <= 0 and var_35_11 or var_35_11 * (var_35_16 / var_35_15)

				if var_35_17 > 0 and var_35_11 < var_35_17 then
					arg_32_1.talkMaxDuration = var_35_17

					if var_35_17 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_17 + var_35_10
					end
				end

				arg_32_1.text_.text = var_35_14
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611008", "story_v_out_325611.awb") ~= 0 then
					local var_35_18 = manager.audio:GetVoiceLength("story_v_out_325611", "325611008", "story_v_out_325611.awb") / 1000

					if var_35_18 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_10
					end

					if var_35_13.prefab_name ~= "" and arg_32_1.actors_[var_35_13.prefab_name] ~= nil then
						local var_35_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_13.prefab_name].transform, "story_v_out_325611", "325611008", "story_v_out_325611.awb")

						arg_32_1:RecordAudio("325611008", var_35_19)
						arg_32_1:RecordAudio("325611008", var_35_19)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325611", "325611008", "story_v_out_325611.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325611", "325611008", "story_v_out_325611.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_20 = math.max(var_35_11, arg_32_1.talkMaxDuration)

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_20 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_10) / var_35_20

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_10 + var_35_20 and arg_32_1.time_ < var_35_10 + var_35_20 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play325611009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325611009
		arg_36_1.duration_ = 4.93

		local var_36_0 = {
			zh = 3.3,
			ja = 4.933
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
				arg_36_0:Play325611010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_1")
			end

			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_39_2 = 0
			local var_39_3 = 0.425

			if var_39_2 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_4 = arg_36_1:FormatText(StoryNameCfg[1473].name)

				arg_36_1.leftNameTxt_.text = var_39_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_5 = arg_36_1:GetWordFromCfg(325611009)
				local var_39_6 = arg_36_1:FormatText(var_39_5.content)

				arg_36_1.text_.text = var_39_6

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_7 = 17
				local var_39_8 = utf8.len(var_39_6)
				local var_39_9 = var_39_7 <= 0 and var_39_3 or var_39_3 * (var_39_8 / var_39_7)

				if var_39_9 > 0 and var_39_3 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_2
					end
				end

				arg_36_1.text_.text = var_39_6
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611009", "story_v_out_325611.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_out_325611", "325611009", "story_v_out_325611.awb") / 1000

					if var_39_10 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_2
					end

					if var_39_5.prefab_name ~= "" and arg_36_1.actors_[var_39_5.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_5.prefab_name].transform, "story_v_out_325611", "325611009", "story_v_out_325611.awb")

						arg_36_1:RecordAudio("325611009", var_39_11)
						arg_36_1:RecordAudio("325611009", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325611", "325611009", "story_v_out_325611.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325611", "325611009", "story_v_out_325611.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_12 = math.max(var_39_3, arg_36_1.talkMaxDuration)

			if var_39_2 <= arg_36_1.time_ and arg_36_1.time_ < var_39_2 + var_39_12 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_2) / var_39_12

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_2 + var_39_12 and arg_36_1.time_ < var_39_2 + var_39_12 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play325611010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325611010
		arg_40_1.duration_ = 4.73

		local var_40_0 = {
			zh = 4,
			ja = 4.733
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
				arg_40_0:Play325611011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10175ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos10175ui_story = var_43_0.localPosition

				local var_43_2 = GameObjectTools.GetOrAddComponent(var_43_0.gameObject, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(false)
				end
			end

			local var_43_3 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_3 then
				local var_43_4 = (arg_40_1.time_ - var_43_1) / var_43_3
				local var_43_5 = Vector3.New(0, 100, 0)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10175ui_story, var_43_5, var_43_4)

				local var_43_6 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_6.x, var_43_6.y, var_43_6.z)

				local var_43_7 = var_43_0.localEulerAngles

				var_43_7.z = 0
				var_43_7.x = 0
				var_43_0.localEulerAngles = var_43_7
			end

			if arg_40_1.time_ >= var_43_1 + var_43_3 and arg_40_1.time_ < var_43_1 + var_43_3 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(0, 100, 0)

				local var_43_8 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_8.x, var_43_8.y, var_43_8.z)

				local var_43_9 = var_43_0.localEulerAngles

				var_43_9.z = 0
				var_43_9.x = 0
				var_43_0.localEulerAngles = var_43_9

				local var_43_10 = GameObjectTools.GetOrAddComponent(var_43_0.gameObject, typeof(DynamicBoneHelper))

				if var_43_10 then
					var_43_10:EnableDynamicBone(true)
				end
			end

			local var_43_11 = "1054ui_story"

			if arg_40_1.actors_[var_43_11] == nil then
				local var_43_12 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_43_12) then
					local var_43_13 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_40_1.stage_.transform)

					var_43_13.name = var_43_11
					var_43_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_40_1.actors_[var_43_11] = var_43_13

					local var_43_14 = var_43_13:GetComponentInChildren(typeof(CharacterEffect))

					var_43_14.enabled = true

					local var_43_15 = GameObjectTools.GetOrAddComponent(var_43_13, typeof(DynamicBoneHelper))

					if var_43_15 then
						var_43_15:EnableDynamicBone(false)
					end

					arg_40_1:ShowWeapon(var_43_14.transform, false)

					arg_40_1.var_[var_43_11 .. "Animator"] = var_43_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_40_1.var_[var_43_11 .. "Animator"].applyRootMotion = true
					arg_40_1.var_[var_43_11 .. "LipSync"] = var_43_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_43_16 = arg_40_1.actors_["1054ui_story"].transform
			local var_43_17 = 0

			if var_43_17 < arg_40_1.time_ and arg_40_1.time_ <= var_43_17 + arg_43_0 then
				arg_40_1.var_.moveOldPos1054ui_story = var_43_16.localPosition

				local var_43_18 = GameObjectTools.GetOrAddComponent(var_43_16.gameObject, typeof(DynamicBoneHelper))

				if var_43_18 then
					var_43_18:EnableDynamicBone(false)
				end
			end

			local var_43_19 = 0.001

			if var_43_17 <= arg_40_1.time_ and arg_40_1.time_ < var_43_17 + var_43_19 then
				local var_43_20 = (arg_40_1.time_ - var_43_17) / var_43_19
				local var_43_21 = Vector3.New(0, -0.985, -6)

				var_43_16.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1054ui_story, var_43_21, var_43_20)

				local var_43_22 = manager.ui.mainCamera.transform.position - var_43_16.position

				var_43_16.forward = Vector3.New(var_43_22.x, var_43_22.y, var_43_22.z)

				local var_43_23 = var_43_16.localEulerAngles

				var_43_23.z = 0
				var_43_23.x = 0
				var_43_16.localEulerAngles = var_43_23
			end

			if arg_40_1.time_ >= var_43_17 + var_43_19 and arg_40_1.time_ < var_43_17 + var_43_19 + arg_43_0 then
				var_43_16.localPosition = Vector3.New(0, -0.985, -6)

				local var_43_24 = manager.ui.mainCamera.transform.position - var_43_16.position

				var_43_16.forward = Vector3.New(var_43_24.x, var_43_24.y, var_43_24.z)

				local var_43_25 = var_43_16.localEulerAngles

				var_43_25.z = 0
				var_43_25.x = 0
				var_43_16.localEulerAngles = var_43_25

				local var_43_26 = GameObjectTools.GetOrAddComponent(var_43_16.gameObject, typeof(DynamicBoneHelper))

				if var_43_26 then
					var_43_26:EnableDynamicBone(true)
				end
			end

			local var_43_27 = arg_40_1.actors_["6148ui_story"].transform
			local var_43_28 = 0

			if var_43_28 < arg_40_1.time_ and arg_40_1.time_ <= var_43_28 + arg_43_0 then
				arg_40_1.var_.moveOldPos6148ui_story = var_43_27.localPosition

				local var_43_29 = GameObjectTools.GetOrAddComponent(var_43_27.gameObject, typeof(DynamicBoneHelper))

				if var_43_29 then
					var_43_29:EnableDynamicBone(false)
				end
			end

			local var_43_30 = 0.001

			if var_43_28 <= arg_40_1.time_ and arg_40_1.time_ < var_43_28 + var_43_30 then
				local var_43_31 = (arg_40_1.time_ - var_43_28) / var_43_30
				local var_43_32 = Vector3.New(0, 100, 0)

				var_43_27.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos6148ui_story, var_43_32, var_43_31)

				local var_43_33 = manager.ui.mainCamera.transform.position - var_43_27.position

				var_43_27.forward = Vector3.New(var_43_33.x, var_43_33.y, var_43_33.z)

				local var_43_34 = var_43_27.localEulerAngles

				var_43_34.z = 0
				var_43_34.x = 0
				var_43_27.localEulerAngles = var_43_34
			end

			if arg_40_1.time_ >= var_43_28 + var_43_30 and arg_40_1.time_ < var_43_28 + var_43_30 + arg_43_0 then
				var_43_27.localPosition = Vector3.New(0, 100, 0)

				local var_43_35 = manager.ui.mainCamera.transform.position - var_43_27.position

				var_43_27.forward = Vector3.New(var_43_35.x, var_43_35.y, var_43_35.z)

				local var_43_36 = var_43_27.localEulerAngles

				var_43_36.z = 0
				var_43_36.x = 0
				var_43_27.localEulerAngles = var_43_36

				local var_43_37 = GameObjectTools.GetOrAddComponent(var_43_27.gameObject, typeof(DynamicBoneHelper))

				if var_43_37 then
					var_43_37:EnableDynamicBone(true)
				end
			end

			local var_43_38 = arg_40_1.actors_["1054ui_story"]
			local var_43_39 = 0

			if var_43_39 < arg_40_1.time_ and arg_40_1.time_ <= var_43_39 + arg_43_0 and not isNil(var_43_38) and arg_40_1.var_.characterEffect1054ui_story == nil then
				arg_40_1.var_.characterEffect1054ui_story = var_43_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_40 = 0.200000002980232

			if var_43_39 <= arg_40_1.time_ and arg_40_1.time_ < var_43_39 + var_43_40 and not isNil(var_43_38) then
				local var_43_41 = (arg_40_1.time_ - var_43_39) / var_43_40

				if arg_40_1.var_.characterEffect1054ui_story and not isNil(var_43_38) then
					arg_40_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_39 + var_43_40 and arg_40_1.time_ < var_43_39 + var_43_40 + arg_43_0 and not isNil(var_43_38) and arg_40_1.var_.characterEffect1054ui_story then
				arg_40_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_43_42 = arg_40_1.actors_["10175ui_story"]
			local var_43_43 = 0

			if var_43_43 < arg_40_1.time_ and arg_40_1.time_ <= var_43_43 + arg_43_0 and not isNil(var_43_42) and arg_40_1.var_.characterEffect10175ui_story == nil then
				arg_40_1.var_.characterEffect10175ui_story = var_43_42:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_44 = 0.200000002980232

			if var_43_43 <= arg_40_1.time_ and arg_40_1.time_ < var_43_43 + var_43_44 and not isNil(var_43_42) then
				local var_43_45 = (arg_40_1.time_ - var_43_43) / var_43_44

				if arg_40_1.var_.characterEffect10175ui_story and not isNil(var_43_42) then
					local var_43_46 = Mathf.Lerp(0, 0.5, var_43_45)

					arg_40_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10175ui_story.fillRatio = var_43_46
				end
			end

			if arg_40_1.time_ >= var_43_43 + var_43_44 and arg_40_1.time_ < var_43_43 + var_43_44 + arg_43_0 and not isNil(var_43_42) and arg_40_1.var_.characterEffect10175ui_story then
				local var_43_47 = 0.5

				arg_40_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10175ui_story.fillRatio = var_43_47
			end

			local var_43_48 = 0

			if var_43_48 < arg_40_1.time_ and arg_40_1.time_ <= var_43_48 + arg_43_0 then
				arg_40_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_43_49 = 0

			if var_43_49 < arg_40_1.time_ and arg_40_1.time_ <= var_43_49 + arg_43_0 then
				arg_40_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_43_50 = 0
			local var_43_51 = 0.375

			if var_43_50 < arg_40_1.time_ and arg_40_1.time_ <= var_43_50 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_52 = arg_40_1:FormatText(StoryNameCfg[1487].name)

				arg_40_1.leftNameTxt_.text = var_43_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_53 = arg_40_1:GetWordFromCfg(325611010)
				local var_43_54 = arg_40_1:FormatText(var_43_53.content)

				arg_40_1.text_.text = var_43_54

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_55 = 15
				local var_43_56 = utf8.len(var_43_54)
				local var_43_57 = var_43_55 <= 0 and var_43_51 or var_43_51 * (var_43_56 / var_43_55)

				if var_43_57 > 0 and var_43_51 < var_43_57 then
					arg_40_1.talkMaxDuration = var_43_57

					if var_43_57 + var_43_50 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_57 + var_43_50
					end
				end

				arg_40_1.text_.text = var_43_54
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611010", "story_v_out_325611.awb") ~= 0 then
					local var_43_58 = manager.audio:GetVoiceLength("story_v_out_325611", "325611010", "story_v_out_325611.awb") / 1000

					if var_43_58 + var_43_50 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_58 + var_43_50
					end

					if var_43_53.prefab_name ~= "" and arg_40_1.actors_[var_43_53.prefab_name] ~= nil then
						local var_43_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_53.prefab_name].transform, "story_v_out_325611", "325611010", "story_v_out_325611.awb")

						arg_40_1:RecordAudio("325611010", var_43_59)
						arg_40_1:RecordAudio("325611010", var_43_59)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325611", "325611010", "story_v_out_325611.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325611", "325611010", "story_v_out_325611.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_60 = math.max(var_43_51, arg_40_1.talkMaxDuration)

			if var_43_50 <= arg_40_1.time_ and arg_40_1.time_ < var_43_50 + var_43_60 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_50) / var_43_60

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_50 + var_43_60 and arg_40_1.time_ < var_43_50 + var_43_60 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play325611011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325611011
		arg_44_1.duration_ = 9.2

		local var_44_0 = {
			zh = 6.733,
			ja = 9.2
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
				arg_44_0:Play325611012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1054ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1054ui_story = var_47_0.localPosition

				local var_47_2 = GameObjectTools.GetOrAddComponent(var_47_0.gameObject, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(false)
				end
			end

			local var_47_3 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_3 then
				local var_47_4 = (arg_44_1.time_ - var_47_1) / var_47_3
				local var_47_5 = Vector3.New(-0.7, -0.985, -6)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1054ui_story, var_47_5, var_47_4)

				local var_47_6 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_6.x, var_47_6.y, var_47_6.z)

				local var_47_7 = var_47_0.localEulerAngles

				var_47_7.z = 0
				var_47_7.x = 0
				var_47_0.localEulerAngles = var_47_7
			end

			if arg_44_1.time_ >= var_47_1 + var_47_3 and arg_44_1.time_ < var_47_1 + var_47_3 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(-0.7, -0.985, -6)

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

			local var_47_11 = arg_44_1.actors_["10175ui_story"].transform
			local var_47_12 = 0

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.var_.moveOldPos10175ui_story = var_47_11.localPosition

				local var_47_13 = GameObjectTools.GetOrAddComponent(var_47_11.gameObject, typeof(DynamicBoneHelper))

				if var_47_13 then
					var_47_13:EnableDynamicBone(false)
				end
			end

			local var_47_14 = 0.001

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_14 then
				local var_47_15 = (arg_44_1.time_ - var_47_12) / var_47_14
				local var_47_16 = Vector3.New(0.7, -1, -6.05)

				var_47_11.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10175ui_story, var_47_16, var_47_15)

				local var_47_17 = manager.ui.mainCamera.transform.position - var_47_11.position

				var_47_11.forward = Vector3.New(var_47_17.x, var_47_17.y, var_47_17.z)

				local var_47_18 = var_47_11.localEulerAngles

				var_47_18.z = 0
				var_47_18.x = 0
				var_47_11.localEulerAngles = var_47_18
			end

			if arg_44_1.time_ >= var_47_12 + var_47_14 and arg_44_1.time_ < var_47_12 + var_47_14 + arg_47_0 then
				var_47_11.localPosition = Vector3.New(0.7, -1, -6.05)

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

			local var_47_22 = arg_44_1.actors_["10175ui_story"]
			local var_47_23 = 0

			if var_47_23 < arg_44_1.time_ and arg_44_1.time_ <= var_47_23 + arg_47_0 and not isNil(var_47_22) and arg_44_1.var_.characterEffect10175ui_story == nil then
				arg_44_1.var_.characterEffect10175ui_story = var_47_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_24 = 0.200000002980232

			if var_47_23 <= arg_44_1.time_ and arg_44_1.time_ < var_47_23 + var_47_24 and not isNil(var_47_22) then
				local var_47_25 = (arg_44_1.time_ - var_47_23) / var_47_24

				if arg_44_1.var_.characterEffect10175ui_story and not isNil(var_47_22) then
					arg_44_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_23 + var_47_24 and arg_44_1.time_ < var_47_23 + var_47_24 + arg_47_0 and not isNil(var_47_22) and arg_44_1.var_.characterEffect10175ui_story then
				arg_44_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_47_26 = arg_44_1.actors_["1054ui_story"]
			local var_47_27 = 0

			if var_47_27 < arg_44_1.time_ and arg_44_1.time_ <= var_47_27 + arg_47_0 and not isNil(var_47_26) and arg_44_1.var_.characterEffect1054ui_story == nil then
				arg_44_1.var_.characterEffect1054ui_story = var_47_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_28 = 0.200000002980232

			if var_47_27 <= arg_44_1.time_ and arg_44_1.time_ < var_47_27 + var_47_28 and not isNil(var_47_26) then
				local var_47_29 = (arg_44_1.time_ - var_47_27) / var_47_28

				if arg_44_1.var_.characterEffect1054ui_story and not isNil(var_47_26) then
					local var_47_30 = Mathf.Lerp(0, 0.5, var_47_29)

					arg_44_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1054ui_story.fillRatio = var_47_30
				end
			end

			if arg_44_1.time_ >= var_47_27 + var_47_28 and arg_44_1.time_ < var_47_27 + var_47_28 + arg_47_0 and not isNil(var_47_26) and arg_44_1.var_.characterEffect1054ui_story then
				local var_47_31 = 0.5

				arg_44_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1054ui_story.fillRatio = var_47_31
			end

			local var_47_32 = 0
			local var_47_33 = 0.575

			if var_47_32 < arg_44_1.time_ and arg_44_1.time_ <= var_47_32 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_34 = arg_44_1:FormatText(StoryNameCfg[1473].name)

				arg_44_1.leftNameTxt_.text = var_47_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_35 = arg_44_1:GetWordFromCfg(325611011)
				local var_47_36 = arg_44_1:FormatText(var_47_35.content)

				arg_44_1.text_.text = var_47_36

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_37 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611011", "story_v_out_325611.awb") ~= 0 then
					local var_47_40 = manager.audio:GetVoiceLength("story_v_out_325611", "325611011", "story_v_out_325611.awb") / 1000

					if var_47_40 + var_47_32 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_40 + var_47_32
					end

					if var_47_35.prefab_name ~= "" and arg_44_1.actors_[var_47_35.prefab_name] ~= nil then
						local var_47_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_35.prefab_name].transform, "story_v_out_325611", "325611011", "story_v_out_325611.awb")

						arg_44_1:RecordAudio("325611011", var_47_41)
						arg_44_1:RecordAudio("325611011", var_47_41)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325611", "325611011", "story_v_out_325611.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325611", "325611011", "story_v_out_325611.awb")
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
				actorName = "1054ui_story",
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

		arg_44_1:InitPlayNodeList()
	end,
	Play325611012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325611012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play325611013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10175ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos10175ui_story = var_51_0.localPosition

				local var_51_2 = GameObjectTools.GetOrAddComponent(var_51_0.gameObject, typeof(DynamicBoneHelper))

				if var_51_2 then
					var_51_2:EnableDynamicBone(false)
				end
			end

			local var_51_3 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_3 then
				local var_51_4 = (arg_48_1.time_ - var_51_1) / var_51_3
				local var_51_5 = Vector3.New(0, 100, 0)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10175ui_story, var_51_5, var_51_4)

				local var_51_6 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_6.x, var_51_6.y, var_51_6.z)

				local var_51_7 = var_51_0.localEulerAngles

				var_51_7.z = 0
				var_51_7.x = 0
				var_51_0.localEulerAngles = var_51_7
			end

			if arg_48_1.time_ >= var_51_1 + var_51_3 and arg_48_1.time_ < var_51_1 + var_51_3 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(0, 100, 0)

				local var_51_8 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_8.x, var_51_8.y, var_51_8.z)

				local var_51_9 = var_51_0.localEulerAngles

				var_51_9.z = 0
				var_51_9.x = 0
				var_51_0.localEulerAngles = var_51_9

				local var_51_10 = GameObjectTools.GetOrAddComponent(var_51_0.gameObject, typeof(DynamicBoneHelper))

				if var_51_10 then
					var_51_10:EnableDynamicBone(true)
				end
			end

			local var_51_11 = arg_48_1.actors_["1054ui_story"].transform
			local var_51_12 = 0

			if var_51_12 < arg_48_1.time_ and arg_48_1.time_ <= var_51_12 + arg_51_0 then
				arg_48_1.var_.moveOldPos1054ui_story = var_51_11.localPosition

				local var_51_13 = GameObjectTools.GetOrAddComponent(var_51_11.gameObject, typeof(DynamicBoneHelper))

				if var_51_13 then
					var_51_13:EnableDynamicBone(false)
				end
			end

			local var_51_14 = 0.001

			if var_51_12 <= arg_48_1.time_ and arg_48_1.time_ < var_51_12 + var_51_14 then
				local var_51_15 = (arg_48_1.time_ - var_51_12) / var_51_14
				local var_51_16 = Vector3.New(0, 100, 0)

				var_51_11.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1054ui_story, var_51_16, var_51_15)

				local var_51_17 = manager.ui.mainCamera.transform.position - var_51_11.position

				var_51_11.forward = Vector3.New(var_51_17.x, var_51_17.y, var_51_17.z)

				local var_51_18 = var_51_11.localEulerAngles

				var_51_18.z = 0
				var_51_18.x = 0
				var_51_11.localEulerAngles = var_51_18
			end

			if arg_48_1.time_ >= var_51_12 + var_51_14 and arg_48_1.time_ < var_51_12 + var_51_14 + arg_51_0 then
				var_51_11.localPosition = Vector3.New(0, 100, 0)

				local var_51_19 = manager.ui.mainCamera.transform.position - var_51_11.position

				var_51_11.forward = Vector3.New(var_51_19.x, var_51_19.y, var_51_19.z)

				local var_51_20 = var_51_11.localEulerAngles

				var_51_20.z = 0
				var_51_20.x = 0
				var_51_11.localEulerAngles = var_51_20

				local var_51_21 = GameObjectTools.GetOrAddComponent(var_51_11.gameObject, typeof(DynamicBoneHelper))

				if var_51_21 then
					var_51_21:EnableDynamicBone(true)
				end
			end

			local var_51_22 = arg_48_1.actors_["10175ui_story"]
			local var_51_23 = 0

			if var_51_23 < arg_48_1.time_ and arg_48_1.time_ <= var_51_23 + arg_51_0 and not isNil(var_51_22) and arg_48_1.var_.characterEffect10175ui_story == nil then
				arg_48_1.var_.characterEffect10175ui_story = var_51_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_24 = 0.200000002980232

			if var_51_23 <= arg_48_1.time_ and arg_48_1.time_ < var_51_23 + var_51_24 and not isNil(var_51_22) then
				local var_51_25 = (arg_48_1.time_ - var_51_23) / var_51_24

				if arg_48_1.var_.characterEffect10175ui_story and not isNil(var_51_22) then
					local var_51_26 = Mathf.Lerp(0, 0.5, var_51_25)

					arg_48_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10175ui_story.fillRatio = var_51_26
				end
			end

			if arg_48_1.time_ >= var_51_23 + var_51_24 and arg_48_1.time_ < var_51_23 + var_51_24 + arg_51_0 and not isNil(var_51_22) and arg_48_1.var_.characterEffect10175ui_story then
				local var_51_27 = 0.5

				arg_48_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10175ui_story.fillRatio = var_51_27
			end

			local var_51_28 = 0
			local var_51_29 = 0.95

			if var_51_28 < arg_48_1.time_ and arg_48_1.time_ <= var_51_28 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_30 = arg_48_1:GetWordFromCfg(325611012)
				local var_51_31 = arg_48_1:FormatText(var_51_30.content)

				arg_48_1.text_.text = var_51_31

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_32 = 38
				local var_51_33 = utf8.len(var_51_31)
				local var_51_34 = var_51_32 <= 0 and var_51_29 or var_51_29 * (var_51_33 / var_51_32)

				if var_51_34 > 0 and var_51_29 < var_51_34 then
					arg_48_1.talkMaxDuration = var_51_34

					if var_51_34 + var_51_28 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_34 + var_51_28
					end
				end

				arg_48_1.text_.text = var_51_31
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_35 = math.max(var_51_29, arg_48_1.talkMaxDuration)

			if var_51_28 <= arg_48_1.time_ and arg_48_1.time_ < var_51_28 + var_51_35 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_28) / var_51_35

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_28 + var_51_35 and arg_48_1.time_ < var_51_28 + var_51_35 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play325611013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325611013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play325611014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 1

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_2 = arg_52_1:GetWordFromCfg(325611013)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 40
				local var_55_5 = utf8.len(var_55_3)
				local var_55_6 = var_55_4 <= 0 and var_55_1 or var_55_1 * (var_55_5 / var_55_4)

				if var_55_6 > 0 and var_55_1 < var_55_6 then
					arg_52_1.talkMaxDuration = var_55_6

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_7 and arg_52_1.time_ < var_55_0 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play325611014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325611014
		arg_56_1.duration_ = 4.47

		local var_56_0 = {
			zh = 4.4,
			ja = 4.466
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
				arg_56_0:Play325611015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10175ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos10175ui_story = var_59_0.localPosition

				local var_59_2 = GameObjectTools.GetOrAddComponent(var_59_0.gameObject, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(false)
				end
			end

			local var_59_3 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_3 then
				local var_59_4 = (arg_56_1.time_ - var_59_1) / var_59_3
				local var_59_5 = Vector3.New(0, -1, -6.05)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10175ui_story, var_59_5, var_59_4)

				local var_59_6 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_6.x, var_59_6.y, var_59_6.z)

				local var_59_7 = var_59_0.localEulerAngles

				var_59_7.z = 0
				var_59_7.x = 0
				var_59_0.localEulerAngles = var_59_7
			end

			if arg_56_1.time_ >= var_59_1 + var_59_3 and arg_56_1.time_ < var_59_1 + var_59_3 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, -1, -6.05)

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

			local var_59_11 = arg_56_1.actors_["10175ui_story"]
			local var_59_12 = 0

			if var_59_12 < arg_56_1.time_ and arg_56_1.time_ <= var_59_12 + arg_59_0 and not isNil(var_59_11) and arg_56_1.var_.characterEffect10175ui_story == nil then
				arg_56_1.var_.characterEffect10175ui_story = var_59_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_13 = 0.200000002980232

			if var_59_12 <= arg_56_1.time_ and arg_56_1.time_ < var_59_12 + var_59_13 and not isNil(var_59_11) then
				local var_59_14 = (arg_56_1.time_ - var_59_12) / var_59_13

				if arg_56_1.var_.characterEffect10175ui_story and not isNil(var_59_11) then
					arg_56_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_12 + var_59_13 and arg_56_1.time_ < var_59_12 + var_59_13 + arg_59_0 and not isNil(var_59_11) and arg_56_1.var_.characterEffect10175ui_story then
				arg_56_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_59_15 = 0

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_2")
			end

			local var_59_16 = 0

			if var_59_16 < arg_56_1.time_ and arg_56_1.time_ <= var_59_16 + arg_59_0 then
				arg_56_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaB", "EmotionTimelineAnimator")
			end

			local var_59_17 = 0
			local var_59_18 = 0.375

			if var_59_17 < arg_56_1.time_ and arg_56_1.time_ <= var_59_17 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_19 = arg_56_1:FormatText(StoryNameCfg[1473].name)

				arg_56_1.leftNameTxt_.text = var_59_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_20 = arg_56_1:GetWordFromCfg(325611014)
				local var_59_21 = arg_56_1:FormatText(var_59_20.content)

				arg_56_1.text_.text = var_59_21

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_22 = 15
				local var_59_23 = utf8.len(var_59_21)
				local var_59_24 = var_59_22 <= 0 and var_59_18 or var_59_18 * (var_59_23 / var_59_22)

				if var_59_24 > 0 and var_59_18 < var_59_24 then
					arg_56_1.talkMaxDuration = var_59_24

					if var_59_24 + var_59_17 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_24 + var_59_17
					end
				end

				arg_56_1.text_.text = var_59_21
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611014", "story_v_out_325611.awb") ~= 0 then
					local var_59_25 = manager.audio:GetVoiceLength("story_v_out_325611", "325611014", "story_v_out_325611.awb") / 1000

					if var_59_25 + var_59_17 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_25 + var_59_17
					end

					if var_59_20.prefab_name ~= "" and arg_56_1.actors_[var_59_20.prefab_name] ~= nil then
						local var_59_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_20.prefab_name].transform, "story_v_out_325611", "325611014", "story_v_out_325611.awb")

						arg_56_1:RecordAudio("325611014", var_59_26)
						arg_56_1:RecordAudio("325611014", var_59_26)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325611", "325611014", "story_v_out_325611.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325611", "325611014", "story_v_out_325611.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_27 = math.max(var_59_18, arg_56_1.talkMaxDuration)

			if var_59_17 <= arg_56_1.time_ and arg_56_1.time_ < var_59_17 + var_59_27 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_17) / var_59_27

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_17 + var_59_27 and arg_56_1.time_ < var_59_17 + var_59_27 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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
	Play325611015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325611015
		arg_60_1.duration_ = 4.1

		local var_60_0 = {
			zh = 3.733,
			ja = 4.1
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
				arg_60_0:Play325611016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10175ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos10175ui_story = var_63_0.localPosition

				local var_63_2 = GameObjectTools.GetOrAddComponent(var_63_0.gameObject, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(false)
				end
			end

			local var_63_3 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_3 then
				local var_63_4 = (arg_60_1.time_ - var_63_1) / var_63_3
				local var_63_5 = Vector3.New(-0.7, -1, -6.05)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10175ui_story, var_63_5, var_63_4)

				local var_63_6 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_6.x, var_63_6.y, var_63_6.z)

				local var_63_7 = var_63_0.localEulerAngles

				var_63_7.z = 0
				var_63_7.x = 0
				var_63_0.localEulerAngles = var_63_7
			end

			if arg_60_1.time_ >= var_63_1 + var_63_3 and arg_60_1.time_ < var_63_1 + var_63_3 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(-0.7, -1, -6.05)

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

			local var_63_11 = arg_60_1.actors_["6148ui_story"].transform
			local var_63_12 = 0

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1.var_.moveOldPos6148ui_story = var_63_11.localPosition

				local var_63_13 = GameObjectTools.GetOrAddComponent(var_63_11.gameObject, typeof(DynamicBoneHelper))

				if var_63_13 then
					var_63_13:EnableDynamicBone(false)
				end
			end

			local var_63_14 = 0.001

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_14 then
				local var_63_15 = (arg_60_1.time_ - var_63_12) / var_63_14
				local var_63_16 = Vector3.New(0.7, -0.985, -6)

				var_63_11.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos6148ui_story, var_63_16, var_63_15)

				local var_63_17 = manager.ui.mainCamera.transform.position - var_63_11.position

				var_63_11.forward = Vector3.New(var_63_17.x, var_63_17.y, var_63_17.z)

				local var_63_18 = var_63_11.localEulerAngles

				var_63_18.z = 0
				var_63_18.x = 0
				var_63_11.localEulerAngles = var_63_18
			end

			if arg_60_1.time_ >= var_63_12 + var_63_14 and arg_60_1.time_ < var_63_12 + var_63_14 + arg_63_0 then
				var_63_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_63_19 = manager.ui.mainCamera.transform.position - var_63_11.position

				var_63_11.forward = Vector3.New(var_63_19.x, var_63_19.y, var_63_19.z)

				local var_63_20 = var_63_11.localEulerAngles

				var_63_20.z = 0
				var_63_20.x = 0
				var_63_11.localEulerAngles = var_63_20

				local var_63_21 = GameObjectTools.GetOrAddComponent(var_63_11.gameObject, typeof(DynamicBoneHelper))

				if var_63_21 then
					var_63_21:EnableDynamicBone(true)
				end
			end

			local var_63_22 = arg_60_1.actors_["6148ui_story"]
			local var_63_23 = 0

			if var_63_23 < arg_60_1.time_ and arg_60_1.time_ <= var_63_23 + arg_63_0 and not isNil(var_63_22) and arg_60_1.var_.characterEffect6148ui_story == nil then
				arg_60_1.var_.characterEffect6148ui_story = var_63_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_24 = 0.200000002980232

			if var_63_23 <= arg_60_1.time_ and arg_60_1.time_ < var_63_23 + var_63_24 and not isNil(var_63_22) then
				local var_63_25 = (arg_60_1.time_ - var_63_23) / var_63_24

				if arg_60_1.var_.characterEffect6148ui_story and not isNil(var_63_22) then
					arg_60_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_23 + var_63_24 and arg_60_1.time_ < var_63_23 + var_63_24 + arg_63_0 and not isNil(var_63_22) and arg_60_1.var_.characterEffect6148ui_story then
				arg_60_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_63_26 = arg_60_1.actors_["10175ui_story"]
			local var_63_27 = 0

			if var_63_27 < arg_60_1.time_ and arg_60_1.time_ <= var_63_27 + arg_63_0 and not isNil(var_63_26) and arg_60_1.var_.characterEffect10175ui_story == nil then
				arg_60_1.var_.characterEffect10175ui_story = var_63_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_28 = 0.200000002980232

			if var_63_27 <= arg_60_1.time_ and arg_60_1.time_ < var_63_27 + var_63_28 and not isNil(var_63_26) then
				local var_63_29 = (arg_60_1.time_ - var_63_27) / var_63_28

				if arg_60_1.var_.characterEffect10175ui_story and not isNil(var_63_26) then
					local var_63_30 = Mathf.Lerp(0, 0.5, var_63_29)

					arg_60_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_60_1.var_.characterEffect10175ui_story.fillRatio = var_63_30
				end
			end

			if arg_60_1.time_ >= var_63_27 + var_63_28 and arg_60_1.time_ < var_63_27 + var_63_28 + arg_63_0 and not isNil(var_63_26) and arg_60_1.var_.characterEffect10175ui_story then
				local var_63_31 = 0.5

				arg_60_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_60_1.var_.characterEffect10175ui_story.fillRatio = var_63_31
			end

			local var_63_32 = 0

			if var_63_32 < arg_60_1.time_ and arg_60_1.time_ <= var_63_32 + arg_63_0 then
				arg_60_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_63_33 = 0

			if var_63_33 < arg_60_1.time_ and arg_60_1.time_ <= var_63_33 + arg_63_0 then
				arg_60_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_63_34 = 0
			local var_63_35 = 0.375

			if var_63_34 < arg_60_1.time_ and arg_60_1.time_ <= var_63_34 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_36 = arg_60_1:FormatText(StoryNameCfg[1488].name)

				arg_60_1.leftNameTxt_.text = var_63_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_37 = arg_60_1:GetWordFromCfg(325611015)
				local var_63_38 = arg_60_1:FormatText(var_63_37.content)

				arg_60_1.text_.text = var_63_38

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_39 = 15
				local var_63_40 = utf8.len(var_63_38)
				local var_63_41 = var_63_39 <= 0 and var_63_35 or var_63_35 * (var_63_40 / var_63_39)

				if var_63_41 > 0 and var_63_35 < var_63_41 then
					arg_60_1.talkMaxDuration = var_63_41

					if var_63_41 + var_63_34 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_41 + var_63_34
					end
				end

				arg_60_1.text_.text = var_63_38
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611015", "story_v_out_325611.awb") ~= 0 then
					local var_63_42 = manager.audio:GetVoiceLength("story_v_out_325611", "325611015", "story_v_out_325611.awb") / 1000

					if var_63_42 + var_63_34 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_42 + var_63_34
					end

					if var_63_37.prefab_name ~= "" and arg_60_1.actors_[var_63_37.prefab_name] ~= nil then
						local var_63_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_37.prefab_name].transform, "story_v_out_325611", "325611015", "story_v_out_325611.awb")

						arg_60_1:RecordAudio("325611015", var_63_43)
						arg_60_1:RecordAudio("325611015", var_63_43)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325611", "325611015", "story_v_out_325611.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325611", "325611015", "story_v_out_325611.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_44 = math.max(var_63_35, arg_60_1.talkMaxDuration)

			if var_63_34 <= arg_60_1.time_ and arg_60_1.time_ < var_63_34 + var_63_44 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_34) / var_63_44

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_34 + var_63_44 and arg_60_1.time_ < var_63_34 + var_63_44 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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
				actorName = "6148ui_story",
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
	Play325611016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325611016
		arg_64_1.duration_ = 7.5

		local var_64_0 = {
			zh = 5.2,
			ja = 7.5
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play325611017(arg_64_1)
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
					arg_64_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10175ui_story then
				arg_64_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["6148ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect6148ui_story == nil then
				arg_64_1.var_.characterEffect6148ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.200000002980232

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect6148ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_64_1.var_.characterEffect6148ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect6148ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_64_1.var_.characterEffect6148ui_story.fillRatio = var_67_9
			end

			local var_67_10 = 0
			local var_67_11 = 0.575

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_12 = arg_64_1:FormatText(StoryNameCfg[1473].name)

				arg_64_1.leftNameTxt_.text = var_67_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_13 = arg_64_1:GetWordFromCfg(325611016)
				local var_67_14 = arg_64_1:FormatText(var_67_13.content)

				arg_64_1.text_.text = var_67_14

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_15 = 23
				local var_67_16 = utf8.len(var_67_14)
				local var_67_17 = var_67_15 <= 0 and var_67_11 or var_67_11 * (var_67_16 / var_67_15)

				if var_67_17 > 0 and var_67_11 < var_67_17 then
					arg_64_1.talkMaxDuration = var_67_17

					if var_67_17 + var_67_10 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_17 + var_67_10
					end
				end

				arg_64_1.text_.text = var_67_14
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611016", "story_v_out_325611.awb") ~= 0 then
					local var_67_18 = manager.audio:GetVoiceLength("story_v_out_325611", "325611016", "story_v_out_325611.awb") / 1000

					if var_67_18 + var_67_10 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_18 + var_67_10
					end

					if var_67_13.prefab_name ~= "" and arg_64_1.actors_[var_67_13.prefab_name] ~= nil then
						local var_67_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_13.prefab_name].transform, "story_v_out_325611", "325611016", "story_v_out_325611.awb")

						arg_64_1:RecordAudio("325611016", var_67_19)
						arg_64_1:RecordAudio("325611016", var_67_19)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_325611", "325611016", "story_v_out_325611.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_325611", "325611016", "story_v_out_325611.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_20 = math.max(var_67_11, arg_64_1.talkMaxDuration)

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_20 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_10) / var_67_20

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_10 + var_67_20 and arg_64_1.time_ < var_67_10 + var_67_20 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play325611017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325611017
		arg_68_1.duration_ = 5.33

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play325611018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10175ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos10175ui_story = var_71_0.localPosition

				local var_71_2 = GameObjectTools.GetOrAddComponent(var_71_0.gameObject, typeof(DynamicBoneHelper))

				if var_71_2 then
					var_71_2:EnableDynamicBone(false)
				end
			end

			local var_71_3 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_3 then
				local var_71_4 = (arg_68_1.time_ - var_71_1) / var_71_3
				local var_71_5 = Vector3.New(0, 100, 0)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10175ui_story, var_71_5, var_71_4)

				local var_71_6 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_6.x, var_71_6.y, var_71_6.z)

				local var_71_7 = var_71_0.localEulerAngles

				var_71_7.z = 0
				var_71_7.x = 0
				var_71_0.localEulerAngles = var_71_7
			end

			if arg_68_1.time_ >= var_71_1 + var_71_3 and arg_68_1.time_ < var_71_1 + var_71_3 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0, 100, 0)

				local var_71_8 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_8.x, var_71_8.y, var_71_8.z)

				local var_71_9 = var_71_0.localEulerAngles

				var_71_9.z = 0
				var_71_9.x = 0
				var_71_0.localEulerAngles = var_71_9

				local var_71_10 = GameObjectTools.GetOrAddComponent(var_71_0.gameObject, typeof(DynamicBoneHelper))

				if var_71_10 then
					var_71_10:EnableDynamicBone(true)
				end
			end

			local var_71_11 = arg_68_1.actors_["6148ui_story"].transform
			local var_71_12 = 0

			if var_71_12 < arg_68_1.time_ and arg_68_1.time_ <= var_71_12 + arg_71_0 then
				arg_68_1.var_.moveOldPos6148ui_story = var_71_11.localPosition

				local var_71_13 = GameObjectTools.GetOrAddComponent(var_71_11.gameObject, typeof(DynamicBoneHelper))

				if var_71_13 then
					var_71_13:EnableDynamicBone(false)
				end
			end

			local var_71_14 = 0.001

			if var_71_12 <= arg_68_1.time_ and arg_68_1.time_ < var_71_12 + var_71_14 then
				local var_71_15 = (arg_68_1.time_ - var_71_12) / var_71_14
				local var_71_16 = Vector3.New(0, 100, 0)

				var_71_11.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos6148ui_story, var_71_16, var_71_15)

				local var_71_17 = manager.ui.mainCamera.transform.position - var_71_11.position

				var_71_11.forward = Vector3.New(var_71_17.x, var_71_17.y, var_71_17.z)

				local var_71_18 = var_71_11.localEulerAngles

				var_71_18.z = 0
				var_71_18.x = 0
				var_71_11.localEulerAngles = var_71_18
			end

			if arg_68_1.time_ >= var_71_12 + var_71_14 and arg_68_1.time_ < var_71_12 + var_71_14 + arg_71_0 then
				var_71_11.localPosition = Vector3.New(0, 100, 0)

				local var_71_19 = manager.ui.mainCamera.transform.position - var_71_11.position

				var_71_11.forward = Vector3.New(var_71_19.x, var_71_19.y, var_71_19.z)

				local var_71_20 = var_71_11.localEulerAngles

				var_71_20.z = 0
				var_71_20.x = 0
				var_71_11.localEulerAngles = var_71_20

				local var_71_21 = GameObjectTools.GetOrAddComponent(var_71_11.gameObject, typeof(DynamicBoneHelper))

				if var_71_21 then
					var_71_21:EnableDynamicBone(true)
				end
			end

			local var_71_22 = arg_68_1.actors_["10175ui_story"]
			local var_71_23 = 0

			if var_71_23 < arg_68_1.time_ and arg_68_1.time_ <= var_71_23 + arg_71_0 and not isNil(var_71_22) and arg_68_1.var_.characterEffect10175ui_story == nil then
				arg_68_1.var_.characterEffect10175ui_story = var_71_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_24 = 0.200000002980232

			if var_71_23 <= arg_68_1.time_ and arg_68_1.time_ < var_71_23 + var_71_24 and not isNil(var_71_22) then
				local var_71_25 = (arg_68_1.time_ - var_71_23) / var_71_24

				if arg_68_1.var_.characterEffect10175ui_story and not isNil(var_71_22) then
					local var_71_26 = Mathf.Lerp(0, 0.5, var_71_25)

					arg_68_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_68_1.var_.characterEffect10175ui_story.fillRatio = var_71_26
				end
			end

			if arg_68_1.time_ >= var_71_23 + var_71_24 and arg_68_1.time_ < var_71_23 + var_71_24 + arg_71_0 and not isNil(var_71_22) and arg_68_1.var_.characterEffect10175ui_story then
				local var_71_27 = 0.5

				arg_68_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_68_1.var_.characterEffect10175ui_story.fillRatio = var_71_27
			end

			local var_71_28 = manager.ui.mainCamera.transform
			local var_71_29 = 0

			if var_71_29 < arg_68_1.time_ and arg_68_1.time_ <= var_71_29 + arg_71_0 then
				local var_71_30 = arg_68_1.var_.effectpikaidaolu1
				local var_71_31
				local var_71_32 = var_71_28

				if not var_71_30 then
					var_71_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), var_71_32)
					var_71_30.name = "pikaidaolu1"
					arg_68_1.var_.effectpikaidaolu1 = var_71_30
				else
					var_71_30.transform:SetParent(var_71_32)
				end

				var_71_30.transform.localPosition = Vector3.New(0, 0, 0)
				var_71_30.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_71_33 = manager.ui.mainCamera.transform
			local var_71_34 = 0

			if var_71_34 < arg_68_1.time_ and arg_68_1.time_ <= var_71_34 + arg_71_0 then
				local var_71_35 = arg_68_1.var_.effectpikaidaolu2
				local var_71_36
				local var_71_37 = var_71_33

				if not var_71_35 then
					var_71_35 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), var_71_37)
					var_71_35.name = "pikaidaolu2"
					arg_68_1.var_.effectpikaidaolu2 = var_71_35
				else
					var_71_35.transform:SetParent(var_71_37)
				end

				var_71_35.transform.localPosition = Vector3.New(0, 0, 0)
				var_71_35.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_71_38 = manager.ui.mainCamera.transform
			local var_71_39 = 0

			if var_71_39 < arg_68_1.time_ and arg_68_1.time_ <= var_71_39 + arg_71_0 then
				arg_68_1.var_.shakeOldPos = var_71_38.localPosition
			end

			local var_71_40 = 0.6

			if var_71_39 <= arg_68_1.time_ and arg_68_1.time_ < var_71_39 + var_71_40 then
				local var_71_41 = (arg_68_1.time_ - var_71_39) / 0.066
				local var_71_42, var_71_43 = math.modf(var_71_41)

				var_71_38.localPosition = Vector3.New(var_71_43 * 0.13, var_71_43 * 0.13, var_71_43 * 0.13) + arg_68_1.var_.shakeOldPos
			end

			if arg_68_1.time_ >= var_71_39 + var_71_40 and arg_68_1.time_ < var_71_39 + var_71_40 + arg_71_0 then
				var_71_38.localPosition = arg_68_1.var_.shakeOldPos
			end

			local var_71_44 = 0

			if var_71_44 < arg_68_1.time_ and arg_68_1.time_ <= var_71_44 + arg_71_0 then
				arg_68_1.allBtn_.enabled = false
			end

			local var_71_45 = 1.46666666666667

			if arg_68_1.time_ >= var_71_44 + var_71_45 and arg_68_1.time_ < var_71_44 + var_71_45 + arg_71_0 then
				arg_68_1.allBtn_.enabled = true
			end

			if arg_68_1.frameCnt_ <= 1 then
				arg_68_1.dialog_:SetActive(false)
			end

			local var_71_46 = 0.333333333333333
			local var_71_47 = 1.35

			if var_71_46 < arg_68_1.time_ and arg_68_1.time_ <= var_71_46 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0

				arg_68_1.dialog_:SetActive(true)

				arg_68_1.dialogCg_.alpha = 0

				local var_71_48 = LeanTween.value(arg_68_1.dialog_, 0, 1, 0.3)

				var_71_48:setOnUpdate(LuaHelper.FloatAction(function(arg_72_0)
					arg_68_1.dialogCg_.alpha = arg_72_0
				end))
				var_71_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_68_1.dialog_)
					var_71_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_68_1.duration_ = arg_68_1.duration_ + 0.3

				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_49 = arg_68_1:GetWordFromCfg(325611017)
				local var_71_50 = arg_68_1:FormatText(var_71_49.content)

				arg_68_1.text_.text = var_71_50

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_51 = 54
				local var_71_52 = utf8.len(var_71_50)
				local var_71_53 = var_71_51 <= 0 and var_71_47 or var_71_47 * (var_71_52 / var_71_51)

				if var_71_53 > 0 and var_71_47 < var_71_53 then
					arg_68_1.talkMaxDuration = var_71_53
					var_71_46 = var_71_46 + 0.3

					if var_71_53 + var_71_46 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_53 + var_71_46
					end
				end

				arg_68_1.text_.text = var_71_50
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_54 = var_71_46 + 0.3
			local var_71_55 = math.max(var_71_47, arg_68_1.talkMaxDuration)

			if var_71_54 <= arg_68_1.time_ and arg_68_1.time_ < var_71_54 + var_71_55 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_54) / var_71_55

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_54 + var_71_55 and arg_68_1.time_ < var_71_54 + var_71_55 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play325611018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325611018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play325611019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 1.15

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_2 = arg_74_1:GetWordFromCfg(325611018)
				local var_77_3 = arg_74_1:FormatText(var_77_2.content)

				arg_74_1.text_.text = var_77_3

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 46
				local var_77_5 = utf8.len(var_77_3)
				local var_77_6 = var_77_4 <= 0 and var_77_1 or var_77_1 * (var_77_5 / var_77_4)

				if var_77_6 > 0 and var_77_1 < var_77_6 then
					arg_74_1.talkMaxDuration = var_77_6

					if var_77_6 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_3
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_7 and arg_74_1.time_ < var_77_0 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play325611019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 325611019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play325611020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 1.275

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_2 = arg_78_1:GetWordFromCfg(325611019)
				local var_81_3 = arg_78_1:FormatText(var_81_2.content)

				arg_78_1.text_.text = var_81_3

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_4 = 51
				local var_81_5 = utf8.len(var_81_3)
				local var_81_6 = var_81_4 <= 0 and var_81_1 or var_81_1 * (var_81_5 / var_81_4)

				if var_81_6 > 0 and var_81_1 < var_81_6 then
					arg_78_1.talkMaxDuration = var_81_6

					if var_81_6 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_6 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_3
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_7 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_7 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_7

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_7 and arg_78_1.time_ < var_81_0 + var_81_7 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play325611020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325611020
		arg_82_1.duration_ = 2

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play325611021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1054ui_story"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos1054ui_story = var_85_0.localPosition

				local var_85_2 = GameObjectTools.GetOrAddComponent(var_85_0.gameObject, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(false)
				end
			end

			local var_85_3 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_3 then
				local var_85_4 = (arg_82_1.time_ - var_85_1) / var_85_3
				local var_85_5 = Vector3.New(-0.7, -0.985, -6)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1054ui_story, var_85_5, var_85_4)

				local var_85_6 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_6.x, var_85_6.y, var_85_6.z)

				local var_85_7 = var_85_0.localEulerAngles

				var_85_7.z = 0
				var_85_7.x = 0
				var_85_0.localEulerAngles = var_85_7
			end

			if arg_82_1.time_ >= var_85_1 + var_85_3 and arg_82_1.time_ < var_85_1 + var_85_3 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(-0.7, -0.985, -6)

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

			local var_85_11 = arg_82_1.actors_["6148ui_story"].transform
			local var_85_12 = 0

			if var_85_12 < arg_82_1.time_ and arg_82_1.time_ <= var_85_12 + arg_85_0 then
				arg_82_1.var_.moveOldPos6148ui_story = var_85_11.localPosition

				local var_85_13 = GameObjectTools.GetOrAddComponent(var_85_11.gameObject, typeof(DynamicBoneHelper))

				if var_85_13 then
					var_85_13:EnableDynamicBone(false)
				end
			end

			local var_85_14 = 0.001

			if var_85_12 <= arg_82_1.time_ and arg_82_1.time_ < var_85_12 + var_85_14 then
				local var_85_15 = (arg_82_1.time_ - var_85_12) / var_85_14
				local var_85_16 = Vector3.New(0.7, -0.985, -6)

				var_85_11.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos6148ui_story, var_85_16, var_85_15)

				local var_85_17 = manager.ui.mainCamera.transform.position - var_85_11.position

				var_85_11.forward = Vector3.New(var_85_17.x, var_85_17.y, var_85_17.z)

				local var_85_18 = var_85_11.localEulerAngles

				var_85_18.z = 0
				var_85_18.x = 0
				var_85_11.localEulerAngles = var_85_18
			end

			if arg_82_1.time_ >= var_85_12 + var_85_14 and arg_82_1.time_ < var_85_12 + var_85_14 + arg_85_0 then
				var_85_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_85_19 = manager.ui.mainCamera.transform.position - var_85_11.position

				var_85_11.forward = Vector3.New(var_85_19.x, var_85_19.y, var_85_19.z)

				local var_85_20 = var_85_11.localEulerAngles

				var_85_20.z = 0
				var_85_20.x = 0
				var_85_11.localEulerAngles = var_85_20

				local var_85_21 = GameObjectTools.GetOrAddComponent(var_85_11.gameObject, typeof(DynamicBoneHelper))

				if var_85_21 then
					var_85_21:EnableDynamicBone(true)
				end
			end

			local var_85_22 = 0

			if var_85_22 < arg_82_1.time_ and arg_82_1.time_ <= var_85_22 + arg_85_0 then
				arg_82_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_85_23 = 0

			if var_85_23 < arg_82_1.time_ and arg_82_1.time_ <= var_85_23 + arg_85_0 then
				arg_82_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_85_24 = 0

			if var_85_24 < arg_82_1.time_ and arg_82_1.time_ <= var_85_24 + arg_85_0 then
				arg_82_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_85_25 = 0

			if var_85_25 < arg_82_1.time_ and arg_82_1.time_ <= var_85_25 + arg_85_0 then
				arg_82_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_85_26 = arg_82_1.actors_["6148ui_story"]
			local var_85_27 = 0

			if var_85_27 < arg_82_1.time_ and arg_82_1.time_ <= var_85_27 + arg_85_0 and not isNil(var_85_26) and arg_82_1.var_.characterEffect6148ui_story == nil then
				arg_82_1.var_.characterEffect6148ui_story = var_85_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_28 = 0.200000002980232

			if var_85_27 <= arg_82_1.time_ and arg_82_1.time_ < var_85_27 + var_85_28 and not isNil(var_85_26) then
				local var_85_29 = (arg_82_1.time_ - var_85_27) / var_85_28

				if arg_82_1.var_.characterEffect6148ui_story and not isNil(var_85_26) then
					arg_82_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_27 + var_85_28 and arg_82_1.time_ < var_85_27 + var_85_28 + arg_85_0 and not isNil(var_85_26) and arg_82_1.var_.characterEffect6148ui_story then
				arg_82_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_85_30 = arg_82_1.actors_["1054ui_story"]
			local var_85_31 = 0

			if var_85_31 < arg_82_1.time_ and arg_82_1.time_ <= var_85_31 + arg_85_0 and not isNil(var_85_30) and arg_82_1.var_.characterEffect1054ui_story == nil then
				arg_82_1.var_.characterEffect1054ui_story = var_85_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_32 = 0.200000002980232

			if var_85_31 <= arg_82_1.time_ and arg_82_1.time_ < var_85_31 + var_85_32 and not isNil(var_85_30) then
				local var_85_33 = (arg_82_1.time_ - var_85_31) / var_85_32

				if arg_82_1.var_.characterEffect1054ui_story and not isNil(var_85_30) then
					arg_82_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_31 + var_85_32 and arg_82_1.time_ < var_85_31 + var_85_32 + arg_85_0 and not isNil(var_85_30) and arg_82_1.var_.characterEffect1054ui_story then
				arg_82_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_85_34 = 0
			local var_85_35 = 0.075

			if var_85_34 < arg_82_1.time_ and arg_82_1.time_ <= var_85_34 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_36 = arg_82_1:FormatText(StoryNameCfg[1489].name)

				arg_82_1.leftNameTxt_.text = var_85_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_37 = arg_82_1:GetWordFromCfg(325611020)
				local var_85_38 = arg_82_1:FormatText(var_85_37.content)

				arg_82_1.text_.text = var_85_38

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_39 = 3
				local var_85_40 = utf8.len(var_85_38)
				local var_85_41 = var_85_39 <= 0 and var_85_35 or var_85_35 * (var_85_40 / var_85_39)

				if var_85_41 > 0 and var_85_35 < var_85_41 then
					arg_82_1.talkMaxDuration = var_85_41

					if var_85_41 + var_85_34 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_41 + var_85_34
					end
				end

				arg_82_1.text_.text = var_85_38
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611020", "story_v_out_325611.awb") ~= 0 then
					local var_85_42 = manager.audio:GetVoiceLength("story_v_out_325611", "325611020", "story_v_out_325611.awb") / 1000

					if var_85_42 + var_85_34 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_42 + var_85_34
					end

					if var_85_37.prefab_name ~= "" and arg_82_1.actors_[var_85_37.prefab_name] ~= nil then
						local var_85_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_37.prefab_name].transform, "story_v_out_325611", "325611020", "story_v_out_325611.awb")

						arg_82_1:RecordAudio("325611020", var_85_43)
						arg_82_1:RecordAudio("325611020", var_85_43)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_325611", "325611020", "story_v_out_325611.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_325611", "325611020", "story_v_out_325611.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_44 = math.max(var_85_35, arg_82_1.talkMaxDuration)

			if var_85_34 <= arg_82_1.time_ and arg_82_1.time_ < var_85_34 + var_85_44 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_34) / var_85_44

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_34 + var_85_44 and arg_82_1.time_ < var_85_34 + var_85_44 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play325611021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325611021
		arg_86_1.duration_ = 4.83

		local var_86_0 = {
			zh = 3.5,
			ja = 4.833
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
				arg_86_0:Play325611022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10175ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos10175ui_story = var_89_0.localPosition

				local var_89_2 = GameObjectTools.GetOrAddComponent(var_89_0.gameObject, typeof(DynamicBoneHelper))

				if var_89_2 then
					var_89_2:EnableDynamicBone(false)
				end
			end

			local var_89_3 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_3 then
				local var_89_4 = (arg_86_1.time_ - var_89_1) / var_89_3
				local var_89_5 = Vector3.New(0, -1, -6.05)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10175ui_story, var_89_5, var_89_4)

				local var_89_6 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_6.x, var_89_6.y, var_89_6.z)

				local var_89_7 = var_89_0.localEulerAngles

				var_89_7.z = 0
				var_89_7.x = 0
				var_89_0.localEulerAngles = var_89_7
			end

			if arg_86_1.time_ >= var_89_1 + var_89_3 and arg_86_1.time_ < var_89_1 + var_89_3 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_89_8 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_8.x, var_89_8.y, var_89_8.z)

				local var_89_9 = var_89_0.localEulerAngles

				var_89_9.z = 0
				var_89_9.x = 0
				var_89_0.localEulerAngles = var_89_9

				local var_89_10 = GameObjectTools.GetOrAddComponent(var_89_0.gameObject, typeof(DynamicBoneHelper))

				if var_89_10 then
					var_89_10:EnableDynamicBone(true)
				end
			end

			local var_89_11 = arg_86_1.actors_["6148ui_story"].transform
			local var_89_12 = 0

			if var_89_12 < arg_86_1.time_ and arg_86_1.time_ <= var_89_12 + arg_89_0 then
				arg_86_1.var_.moveOldPos6148ui_story = var_89_11.localPosition

				local var_89_13 = GameObjectTools.GetOrAddComponent(var_89_11.gameObject, typeof(DynamicBoneHelper))

				if var_89_13 then
					var_89_13:EnableDynamicBone(false)
				end
			end

			local var_89_14 = 0.001

			if var_89_12 <= arg_86_1.time_ and arg_86_1.time_ < var_89_12 + var_89_14 then
				local var_89_15 = (arg_86_1.time_ - var_89_12) / var_89_14
				local var_89_16 = Vector3.New(0, 100, 0)

				var_89_11.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos6148ui_story, var_89_16, var_89_15)

				local var_89_17 = manager.ui.mainCamera.transform.position - var_89_11.position

				var_89_11.forward = Vector3.New(var_89_17.x, var_89_17.y, var_89_17.z)

				local var_89_18 = var_89_11.localEulerAngles

				var_89_18.z = 0
				var_89_18.x = 0
				var_89_11.localEulerAngles = var_89_18
			end

			if arg_86_1.time_ >= var_89_12 + var_89_14 and arg_86_1.time_ < var_89_12 + var_89_14 + arg_89_0 then
				var_89_11.localPosition = Vector3.New(0, 100, 0)

				local var_89_19 = manager.ui.mainCamera.transform.position - var_89_11.position

				var_89_11.forward = Vector3.New(var_89_19.x, var_89_19.y, var_89_19.z)

				local var_89_20 = var_89_11.localEulerAngles

				var_89_20.z = 0
				var_89_20.x = 0
				var_89_11.localEulerAngles = var_89_20

				local var_89_21 = GameObjectTools.GetOrAddComponent(var_89_11.gameObject, typeof(DynamicBoneHelper))

				if var_89_21 then
					var_89_21:EnableDynamicBone(true)
				end
			end

			local var_89_22 = arg_86_1.actors_["1054ui_story"].transform
			local var_89_23 = 0

			if var_89_23 < arg_86_1.time_ and arg_86_1.time_ <= var_89_23 + arg_89_0 then
				arg_86_1.var_.moveOldPos1054ui_story = var_89_22.localPosition

				local var_89_24 = GameObjectTools.GetOrAddComponent(var_89_22.gameObject, typeof(DynamicBoneHelper))

				if var_89_24 then
					var_89_24:EnableDynamicBone(false)
				end
			end

			local var_89_25 = 0.001

			if var_89_23 <= arg_86_1.time_ and arg_86_1.time_ < var_89_23 + var_89_25 then
				local var_89_26 = (arg_86_1.time_ - var_89_23) / var_89_25
				local var_89_27 = Vector3.New(0, 100, 0)

				var_89_22.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1054ui_story, var_89_27, var_89_26)

				local var_89_28 = manager.ui.mainCamera.transform.position - var_89_22.position

				var_89_22.forward = Vector3.New(var_89_28.x, var_89_28.y, var_89_28.z)

				local var_89_29 = var_89_22.localEulerAngles

				var_89_29.z = 0
				var_89_29.x = 0
				var_89_22.localEulerAngles = var_89_29
			end

			if arg_86_1.time_ >= var_89_23 + var_89_25 and arg_86_1.time_ < var_89_23 + var_89_25 + arg_89_0 then
				var_89_22.localPosition = Vector3.New(0, 100, 0)

				local var_89_30 = manager.ui.mainCamera.transform.position - var_89_22.position

				var_89_22.forward = Vector3.New(var_89_30.x, var_89_30.y, var_89_30.z)

				local var_89_31 = var_89_22.localEulerAngles

				var_89_31.z = 0
				var_89_31.x = 0
				var_89_22.localEulerAngles = var_89_31

				local var_89_32 = GameObjectTools.GetOrAddComponent(var_89_22.gameObject, typeof(DynamicBoneHelper))

				if var_89_32 then
					var_89_32:EnableDynamicBone(true)
				end
			end

			local var_89_33 = arg_86_1.actors_["10175ui_story"]
			local var_89_34 = 0

			if var_89_34 < arg_86_1.time_ and arg_86_1.time_ <= var_89_34 + arg_89_0 and not isNil(var_89_33) and arg_86_1.var_.characterEffect10175ui_story == nil then
				arg_86_1.var_.characterEffect10175ui_story = var_89_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_35 = 0.200000002980232

			if var_89_34 <= arg_86_1.time_ and arg_86_1.time_ < var_89_34 + var_89_35 and not isNil(var_89_33) then
				local var_89_36 = (arg_86_1.time_ - var_89_34) / var_89_35

				if arg_86_1.var_.characterEffect10175ui_story and not isNil(var_89_33) then
					arg_86_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_34 + var_89_35 and arg_86_1.time_ < var_89_34 + var_89_35 + arg_89_0 and not isNil(var_89_33) and arg_86_1.var_.characterEffect10175ui_story then
				arg_86_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_89_37 = 0

			if var_89_37 < arg_86_1.time_ and arg_86_1.time_ <= var_89_37 + arg_89_0 then
				arg_86_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_1")
			end

			local var_89_38 = 0

			if var_89_38 < arg_86_1.time_ and arg_86_1.time_ <= var_89_38 + arg_89_0 then
				arg_86_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_89_39 = 0
			local var_89_40 = 0.325

			if var_89_39 < arg_86_1.time_ and arg_86_1.time_ <= var_89_39 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_41 = arg_86_1:FormatText(StoryNameCfg[1473].name)

				arg_86_1.leftNameTxt_.text = var_89_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_42 = arg_86_1:GetWordFromCfg(325611021)
				local var_89_43 = arg_86_1:FormatText(var_89_42.content)

				arg_86_1.text_.text = var_89_43

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_44 = 13
				local var_89_45 = utf8.len(var_89_43)
				local var_89_46 = var_89_44 <= 0 and var_89_40 or var_89_40 * (var_89_45 / var_89_44)

				if var_89_46 > 0 and var_89_40 < var_89_46 then
					arg_86_1.talkMaxDuration = var_89_46

					if var_89_46 + var_89_39 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_46 + var_89_39
					end
				end

				arg_86_1.text_.text = var_89_43
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611021", "story_v_out_325611.awb") ~= 0 then
					local var_89_47 = manager.audio:GetVoiceLength("story_v_out_325611", "325611021", "story_v_out_325611.awb") / 1000

					if var_89_47 + var_89_39 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_47 + var_89_39
					end

					if var_89_42.prefab_name ~= "" and arg_86_1.actors_[var_89_42.prefab_name] ~= nil then
						local var_89_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_42.prefab_name].transform, "story_v_out_325611", "325611021", "story_v_out_325611.awb")

						arg_86_1:RecordAudio("325611021", var_89_48)
						arg_86_1:RecordAudio("325611021", var_89_48)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_325611", "325611021", "story_v_out_325611.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_325611", "325611021", "story_v_out_325611.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_49 = math.max(var_89_40, arg_86_1.talkMaxDuration)

			if var_89_39 <= arg_86_1.time_ and arg_86_1.time_ < var_89_39 + var_89_49 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_39) / var_89_49

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_39 + var_89_49 and arg_86_1.time_ < var_89_39 + var_89_49 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play325611022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 325611022
		arg_90_1.duration_ = 2.73

		local var_90_0 = {
			zh = 1.999999999999,
			ja = 2.733
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
				arg_90_0:Play325611023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["10175ui_story"].transform
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.var_.moveOldPos10175ui_story = var_93_0.localPosition

				local var_93_2 = GameObjectTools.GetOrAddComponent(var_93_0.gameObject, typeof(DynamicBoneHelper))

				if var_93_2 then
					var_93_2:EnableDynamicBone(false)
				end
			end

			local var_93_3 = 0.001

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_3 then
				local var_93_4 = (arg_90_1.time_ - var_93_1) / var_93_3
				local var_93_5 = Vector3.New(-0.7, -1, -6.05)

				var_93_0.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10175ui_story, var_93_5, var_93_4)

				local var_93_6 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_6.x, var_93_6.y, var_93_6.z)

				local var_93_7 = var_93_0.localEulerAngles

				var_93_7.z = 0
				var_93_7.x = 0
				var_93_0.localEulerAngles = var_93_7
			end

			if arg_90_1.time_ >= var_93_1 + var_93_3 and arg_90_1.time_ < var_93_1 + var_93_3 + arg_93_0 then
				var_93_0.localPosition = Vector3.New(-0.7, -1, -6.05)

				local var_93_8 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_8.x, var_93_8.y, var_93_8.z)

				local var_93_9 = var_93_0.localEulerAngles

				var_93_9.z = 0
				var_93_9.x = 0
				var_93_0.localEulerAngles = var_93_9

				local var_93_10 = GameObjectTools.GetOrAddComponent(var_93_0.gameObject, typeof(DynamicBoneHelper))

				if var_93_10 then
					var_93_10:EnableDynamicBone(true)
				end
			end

			local var_93_11 = "1170ui_story"

			if arg_90_1.actors_[var_93_11] == nil then
				local var_93_12 = Asset.Load("Char/" .. "1170ui_story")

				if not isNil(var_93_12) then
					local var_93_13 = Object.Instantiate(Asset.Load("Char/" .. "1170ui_story"), arg_90_1.stage_.transform)

					var_93_13.name = var_93_11
					var_93_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_90_1.actors_[var_93_11] = var_93_13

					local var_93_14 = var_93_13:GetComponentInChildren(typeof(CharacterEffect))

					var_93_14.enabled = true

					local var_93_15 = GameObjectTools.GetOrAddComponent(var_93_13, typeof(DynamicBoneHelper))

					if var_93_15 then
						var_93_15:EnableDynamicBone(false)
					end

					arg_90_1:ShowWeapon(var_93_14.transform, false)

					arg_90_1.var_[var_93_11 .. "Animator"] = var_93_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_90_1.var_[var_93_11 .. "Animator"].applyRootMotion = true
					arg_90_1.var_[var_93_11 .. "LipSync"] = var_93_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_93_16 = arg_90_1.actors_["1170ui_story"].transform
			local var_93_17 = 0

			if var_93_17 < arg_90_1.time_ and arg_90_1.time_ <= var_93_17 + arg_93_0 then
				arg_90_1.var_.moveOldPos1170ui_story = var_93_16.localPosition

				local var_93_18 = GameObjectTools.GetOrAddComponent(var_93_16.gameObject, typeof(DynamicBoneHelper))

				if var_93_18 then
					var_93_18:EnableDynamicBone(false)
				end
			end

			local var_93_19 = 0.001

			if var_93_17 <= arg_90_1.time_ and arg_90_1.time_ < var_93_17 + var_93_19 then
				local var_93_20 = (arg_90_1.time_ - var_93_17) / var_93_19
				local var_93_21 = Vector3.New(0.74, -0.95, -6.08)

				var_93_16.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1170ui_story, var_93_21, var_93_20)

				local var_93_22 = manager.ui.mainCamera.transform.position - var_93_16.position

				var_93_16.forward = Vector3.New(var_93_22.x, var_93_22.y, var_93_22.z)

				local var_93_23 = var_93_16.localEulerAngles

				var_93_23.z = 0
				var_93_23.x = 0
				var_93_16.localEulerAngles = var_93_23
			end

			if arg_90_1.time_ >= var_93_17 + var_93_19 and arg_90_1.time_ < var_93_17 + var_93_19 + arg_93_0 then
				var_93_16.localPosition = Vector3.New(0.74, -0.95, -6.08)

				local var_93_24 = manager.ui.mainCamera.transform.position - var_93_16.position

				var_93_16.forward = Vector3.New(var_93_24.x, var_93_24.y, var_93_24.z)

				local var_93_25 = var_93_16.localEulerAngles

				var_93_25.z = 0
				var_93_25.x = 0
				var_93_16.localEulerAngles = var_93_25

				local var_93_26 = GameObjectTools.GetOrAddComponent(var_93_16.gameObject, typeof(DynamicBoneHelper))

				if var_93_26 then
					var_93_26:EnableDynamicBone(true)
				end
			end

			local var_93_27 = arg_90_1.actors_["1170ui_story"]
			local var_93_28 = 0

			if var_93_28 < arg_90_1.time_ and arg_90_1.time_ <= var_93_28 + arg_93_0 and not isNil(var_93_27) and arg_90_1.var_.characterEffect1170ui_story == nil then
				arg_90_1.var_.characterEffect1170ui_story = var_93_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_29 = 0.200000002980232

			if var_93_28 <= arg_90_1.time_ and arg_90_1.time_ < var_93_28 + var_93_29 and not isNil(var_93_27) then
				local var_93_30 = (arg_90_1.time_ - var_93_28) / var_93_29

				if arg_90_1.var_.characterEffect1170ui_story and not isNil(var_93_27) then
					arg_90_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_28 + var_93_29 and arg_90_1.time_ < var_93_28 + var_93_29 + arg_93_0 and not isNil(var_93_27) and arg_90_1.var_.characterEffect1170ui_story then
				arg_90_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_93_31 = arg_90_1.actors_["10175ui_story"]
			local var_93_32 = 0

			if var_93_32 < arg_90_1.time_ and arg_90_1.time_ <= var_93_32 + arg_93_0 and not isNil(var_93_31) and arg_90_1.var_.characterEffect10175ui_story == nil then
				arg_90_1.var_.characterEffect10175ui_story = var_93_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_33 = 0.200000002980232

			if var_93_32 <= arg_90_1.time_ and arg_90_1.time_ < var_93_32 + var_93_33 and not isNil(var_93_31) then
				local var_93_34 = (arg_90_1.time_ - var_93_32) / var_93_33

				if arg_90_1.var_.characterEffect10175ui_story and not isNil(var_93_31) then
					local var_93_35 = Mathf.Lerp(0, 0.5, var_93_34)

					arg_90_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_90_1.var_.characterEffect10175ui_story.fillRatio = var_93_35
				end
			end

			if arg_90_1.time_ >= var_93_32 + var_93_33 and arg_90_1.time_ < var_93_32 + var_93_33 + arg_93_0 and not isNil(var_93_31) and arg_90_1.var_.characterEffect10175ui_story then
				local var_93_36 = 0.5

				arg_90_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_90_1.var_.characterEffect10175ui_story.fillRatio = var_93_36
			end

			local var_93_37 = 0

			if var_93_37 < arg_90_1.time_ and arg_90_1.time_ <= var_93_37 + arg_93_0 then
				arg_90_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action1_1")
			end

			local var_93_38 = 0

			if var_93_38 < arg_90_1.time_ and arg_90_1.time_ <= var_93_38 + arg_93_0 then
				arg_90_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_93_39 = 0
			local var_93_40 = 0.225

			if var_93_39 < arg_90_1.time_ and arg_90_1.time_ <= var_93_39 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_41 = arg_90_1:FormatText(StoryNameCfg[318].name)

				arg_90_1.leftNameTxt_.text = var_93_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_42 = arg_90_1:GetWordFromCfg(325611022)
				local var_93_43 = arg_90_1:FormatText(var_93_42.content)

				arg_90_1.text_.text = var_93_43

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_44 = 9
				local var_93_45 = utf8.len(var_93_43)
				local var_93_46 = var_93_44 <= 0 and var_93_40 or var_93_40 * (var_93_45 / var_93_44)

				if var_93_46 > 0 and var_93_40 < var_93_46 then
					arg_90_1.talkMaxDuration = var_93_46

					if var_93_46 + var_93_39 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_46 + var_93_39
					end
				end

				arg_90_1.text_.text = var_93_43
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611022", "story_v_out_325611.awb") ~= 0 then
					local var_93_47 = manager.audio:GetVoiceLength("story_v_out_325611", "325611022", "story_v_out_325611.awb") / 1000

					if var_93_47 + var_93_39 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_47 + var_93_39
					end

					if var_93_42.prefab_name ~= "" and arg_90_1.actors_[var_93_42.prefab_name] ~= nil then
						local var_93_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_42.prefab_name].transform, "story_v_out_325611", "325611022", "story_v_out_325611.awb")

						arg_90_1:RecordAudio("325611022", var_93_48)
						arg_90_1:RecordAudio("325611022", var_93_48)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_325611", "325611022", "story_v_out_325611.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_325611", "325611022", "story_v_out_325611.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_49 = math.max(var_93_40, arg_90_1.talkMaxDuration)

			if var_93_39 <= arg_90_1.time_ and arg_90_1.time_ < var_93_39 + var_93_49 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_39) / var_93_49

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_39 + var_93_49 and arg_90_1.time_ < var_93_39 + var_93_49 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play325611023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 325611023
		arg_94_1.duration_ = 5.23

		local var_94_0 = {
			zh = 2.8,
			ja = 5.233
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
				arg_94_0:Play325611024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["10175ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect10175ui_story == nil then
				arg_94_1.var_.characterEffect10175ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect10175ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect10175ui_story then
				arg_94_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_97_4 = arg_94_1.actors_["1170ui_story"]
			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect1170ui_story == nil then
				arg_94_1.var_.characterEffect1170ui_story = var_97_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_6 = 0.200000002980232

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_6 and not isNil(var_97_4) then
				local var_97_7 = (arg_94_1.time_ - var_97_5) / var_97_6

				if arg_94_1.var_.characterEffect1170ui_story and not isNil(var_97_4) then
					local var_97_8 = Mathf.Lerp(0, 0.5, var_97_7)

					arg_94_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1170ui_story.fillRatio = var_97_8
				end
			end

			if arg_94_1.time_ >= var_97_5 + var_97_6 and arg_94_1.time_ < var_97_5 + var_97_6 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect1170ui_story then
				local var_97_9 = 0.5

				arg_94_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1170ui_story.fillRatio = var_97_9
			end

			local var_97_10 = "1071ui_story"

			if arg_94_1.actors_[var_97_10] == nil then
				local var_97_11 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_97_11) then
					local var_97_12 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_94_1.stage_.transform)

					var_97_12.name = var_97_10
					var_97_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_94_1.actors_[var_97_10] = var_97_12

					local var_97_13 = var_97_12:GetComponentInChildren(typeof(CharacterEffect))

					var_97_13.enabled = true

					local var_97_14 = GameObjectTools.GetOrAddComponent(var_97_12, typeof(DynamicBoneHelper))

					if var_97_14 then
						var_97_14:EnableDynamicBone(false)
					end

					arg_94_1:ShowWeapon(var_97_13.transform, false)

					arg_94_1.var_[var_97_10 .. "Animator"] = var_97_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_94_1.var_[var_97_10 .. "Animator"].applyRootMotion = true
					arg_94_1.var_[var_97_10 .. "LipSync"] = var_97_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_97_15 = 0

			if var_97_15 < arg_94_1.time_ and arg_94_1.time_ <= var_97_15 + arg_97_0 then
				arg_94_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_97_16 = 0
			local var_97_17 = 0.325

			if var_97_16 < arg_94_1.time_ and arg_94_1.time_ <= var_97_16 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_18 = arg_94_1:FormatText(StoryNameCfg[1473].name)

				arg_94_1.leftNameTxt_.text = var_97_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_19 = arg_94_1:GetWordFromCfg(325611023)
				local var_97_20 = arg_94_1:FormatText(var_97_19.content)

				arg_94_1.text_.text = var_97_20

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_21 = 13
				local var_97_22 = utf8.len(var_97_20)
				local var_97_23 = var_97_21 <= 0 and var_97_17 or var_97_17 * (var_97_22 / var_97_21)

				if var_97_23 > 0 and var_97_17 < var_97_23 then
					arg_94_1.talkMaxDuration = var_97_23

					if var_97_23 + var_97_16 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_23 + var_97_16
					end
				end

				arg_94_1.text_.text = var_97_20
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611023", "story_v_out_325611.awb") ~= 0 then
					local var_97_24 = manager.audio:GetVoiceLength("story_v_out_325611", "325611023", "story_v_out_325611.awb") / 1000

					if var_97_24 + var_97_16 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_24 + var_97_16
					end

					if var_97_19.prefab_name ~= "" and arg_94_1.actors_[var_97_19.prefab_name] ~= nil then
						local var_97_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_19.prefab_name].transform, "story_v_out_325611", "325611023", "story_v_out_325611.awb")

						arg_94_1:RecordAudio("325611023", var_97_25)
						arg_94_1:RecordAudio("325611023", var_97_25)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_325611", "325611023", "story_v_out_325611.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_325611", "325611023", "story_v_out_325611.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_26 = math.max(var_97_17, arg_94_1.talkMaxDuration)

			if var_97_16 <= arg_94_1.time_ and arg_94_1.time_ < var_97_16 + var_97_26 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_16) / var_97_26

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_16 + var_97_26 and arg_94_1.time_ < var_97_16 + var_97_26 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play325611024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 325611024
		arg_98_1.duration_ = 12.67

		local var_98_0 = {
			zh = 8.5,
			ja = 12.666
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
				arg_98_0:Play325611025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["10175ui_story"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos10175ui_story = var_101_0.localPosition

				local var_101_2 = GameObjectTools.GetOrAddComponent(var_101_0.gameObject, typeof(DynamicBoneHelper))

				if var_101_2 then
					var_101_2:EnableDynamicBone(false)
				end
			end

			local var_101_3 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_3 then
				local var_101_4 = (arg_98_1.time_ - var_101_1) / var_101_3
				local var_101_5 = Vector3.New(0, 100, 0)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10175ui_story, var_101_5, var_101_4)

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

			local var_101_11 = arg_98_1.actors_["1071ui_story"].transform
			local var_101_12 = 0

			if var_101_12 < arg_98_1.time_ and arg_98_1.time_ <= var_101_12 + arg_101_0 then
				arg_98_1.var_.moveOldPos1071ui_story = var_101_11.localPosition
			end

			local var_101_13 = 0.001

			if var_101_12 <= arg_98_1.time_ and arg_98_1.time_ < var_101_12 + var_101_13 then
				local var_101_14 = (arg_98_1.time_ - var_101_12) / var_101_13
				local var_101_15 = Vector3.New(0, -1.05, -6.2)

				var_101_11.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1071ui_story, var_101_15, var_101_14)

				local var_101_16 = manager.ui.mainCamera.transform.position - var_101_11.position

				var_101_11.forward = Vector3.New(var_101_16.x, var_101_16.y, var_101_16.z)

				local var_101_17 = var_101_11.localEulerAngles

				var_101_17.z = 0
				var_101_17.x = 0
				var_101_11.localEulerAngles = var_101_17
			end

			if arg_98_1.time_ >= var_101_12 + var_101_13 and arg_98_1.time_ < var_101_12 + var_101_13 + arg_101_0 then
				var_101_11.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_101_18 = manager.ui.mainCamera.transform.position - var_101_11.position

				var_101_11.forward = Vector3.New(var_101_18.x, var_101_18.y, var_101_18.z)

				local var_101_19 = var_101_11.localEulerAngles

				var_101_19.z = 0
				var_101_19.x = 0
				var_101_11.localEulerAngles = var_101_19
			end

			local var_101_20 = arg_98_1.actors_["1170ui_story"].transform
			local var_101_21 = 0

			if var_101_21 < arg_98_1.time_ and arg_98_1.time_ <= var_101_21 + arg_101_0 then
				arg_98_1.var_.moveOldPos1170ui_story = var_101_20.localPosition

				local var_101_22 = GameObjectTools.GetOrAddComponent(var_101_20.gameObject, typeof(DynamicBoneHelper))

				if var_101_22 then
					var_101_22:EnableDynamicBone(false)
				end
			end

			local var_101_23 = 0.001

			if var_101_21 <= arg_98_1.time_ and arg_98_1.time_ < var_101_21 + var_101_23 then
				local var_101_24 = (arg_98_1.time_ - var_101_21) / var_101_23
				local var_101_25 = Vector3.New(0, 100, 0)

				var_101_20.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1170ui_story, var_101_25, var_101_24)

				local var_101_26 = manager.ui.mainCamera.transform.position - var_101_20.position

				var_101_20.forward = Vector3.New(var_101_26.x, var_101_26.y, var_101_26.z)

				local var_101_27 = var_101_20.localEulerAngles

				var_101_27.z = 0
				var_101_27.x = 0
				var_101_20.localEulerAngles = var_101_27
			end

			if arg_98_1.time_ >= var_101_21 + var_101_23 and arg_98_1.time_ < var_101_21 + var_101_23 + arg_101_0 then
				var_101_20.localPosition = Vector3.New(0, 100, 0)

				local var_101_28 = manager.ui.mainCamera.transform.position - var_101_20.position

				var_101_20.forward = Vector3.New(var_101_28.x, var_101_28.y, var_101_28.z)

				local var_101_29 = var_101_20.localEulerAngles

				var_101_29.z = 0
				var_101_29.x = 0
				var_101_20.localEulerAngles = var_101_29

				local var_101_30 = GameObjectTools.GetOrAddComponent(var_101_20.gameObject, typeof(DynamicBoneHelper))

				if var_101_30 then
					var_101_30:EnableDynamicBone(true)
				end
			end

			local var_101_31 = arg_98_1.actors_["1071ui_story"]
			local var_101_32 = 0

			if var_101_32 < arg_98_1.time_ and arg_98_1.time_ <= var_101_32 + arg_101_0 and not isNil(var_101_31) and arg_98_1.var_.characterEffect1071ui_story == nil then
				arg_98_1.var_.characterEffect1071ui_story = var_101_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_33 = 0.200000002980232

			if var_101_32 <= arg_98_1.time_ and arg_98_1.time_ < var_101_32 + var_101_33 and not isNil(var_101_31) then
				local var_101_34 = (arg_98_1.time_ - var_101_32) / var_101_33

				if arg_98_1.var_.characterEffect1071ui_story and not isNil(var_101_31) then
					arg_98_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_32 + var_101_33 and arg_98_1.time_ < var_101_32 + var_101_33 + arg_101_0 and not isNil(var_101_31) and arg_98_1.var_.characterEffect1071ui_story then
				arg_98_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_101_35 = arg_98_1.actors_["10175ui_story"]
			local var_101_36 = 0

			if var_101_36 < arg_98_1.time_ and arg_98_1.time_ <= var_101_36 + arg_101_0 and not isNil(var_101_35) and arg_98_1.var_.characterEffect10175ui_story == nil then
				arg_98_1.var_.characterEffect10175ui_story = var_101_35:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_37 = 0.200000002980232

			if var_101_36 <= arg_98_1.time_ and arg_98_1.time_ < var_101_36 + var_101_37 and not isNil(var_101_35) then
				local var_101_38 = (arg_98_1.time_ - var_101_36) / var_101_37

				if arg_98_1.var_.characterEffect10175ui_story and not isNil(var_101_35) then
					local var_101_39 = Mathf.Lerp(0, 0.5, var_101_38)

					arg_98_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_98_1.var_.characterEffect10175ui_story.fillRatio = var_101_39
				end
			end

			if arg_98_1.time_ >= var_101_36 + var_101_37 and arg_98_1.time_ < var_101_36 + var_101_37 + arg_101_0 and not isNil(var_101_35) and arg_98_1.var_.characterEffect10175ui_story then
				local var_101_40 = 0.5

				arg_98_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_98_1.var_.characterEffect10175ui_story.fillRatio = var_101_40
			end

			local var_101_41 = 0

			if var_101_41 < arg_98_1.time_ and arg_98_1.time_ <= var_101_41 + arg_101_0 then
				arg_98_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_101_42 = 0
			local var_101_43 = 1.025

			if var_101_42 < arg_98_1.time_ and arg_98_1.time_ <= var_101_42 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_44 = arg_98_1:FormatText(StoryNameCfg[384].name)

				arg_98_1.leftNameTxt_.text = var_101_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_45 = arg_98_1:GetWordFromCfg(325611024)
				local var_101_46 = arg_98_1:FormatText(var_101_45.content)

				arg_98_1.text_.text = var_101_46

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_47 = 41
				local var_101_48 = utf8.len(var_101_46)
				local var_101_49 = var_101_47 <= 0 and var_101_43 or var_101_43 * (var_101_48 / var_101_47)

				if var_101_49 > 0 and var_101_43 < var_101_49 then
					arg_98_1.talkMaxDuration = var_101_49

					if var_101_49 + var_101_42 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_49 + var_101_42
					end
				end

				arg_98_1.text_.text = var_101_46
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611024", "story_v_out_325611.awb") ~= 0 then
					local var_101_50 = manager.audio:GetVoiceLength("story_v_out_325611", "325611024", "story_v_out_325611.awb") / 1000

					if var_101_50 + var_101_42 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_50 + var_101_42
					end

					if var_101_45.prefab_name ~= "" and arg_98_1.actors_[var_101_45.prefab_name] ~= nil then
						local var_101_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_45.prefab_name].transform, "story_v_out_325611", "325611024", "story_v_out_325611.awb")

						arg_98_1:RecordAudio("325611024", var_101_51)
						arg_98_1:RecordAudio("325611024", var_101_51)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_325611", "325611024", "story_v_out_325611.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_325611", "325611024", "story_v_out_325611.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_52 = math.max(var_101_43, arg_98_1.talkMaxDuration)

			if var_101_42 <= arg_98_1.time_ and arg_98_1.time_ < var_101_42 + var_101_52 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_42) / var_101_52

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_42 + var_101_52 and arg_98_1.time_ < var_101_42 + var_101_52 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
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
	Play325611025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325611025
		arg_102_1.duration_ = 12.2

		local var_102_0 = {
			zh = 6.733,
			ja = 12.2
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play325611026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.9

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_2 = arg_102_1:FormatText(StoryNameCfg[384].name)

				arg_102_1.leftNameTxt_.text = var_105_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_3 = arg_102_1:GetWordFromCfg(325611025)
				local var_105_4 = arg_102_1:FormatText(var_105_3.content)

				arg_102_1.text_.text = var_105_4

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 36
				local var_105_6 = utf8.len(var_105_4)
				local var_105_7 = var_105_5 <= 0 and var_105_1 or var_105_1 * (var_105_6 / var_105_5)

				if var_105_7 > 0 and var_105_1 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_4
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611025", "story_v_out_325611.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_325611", "325611025", "story_v_out_325611.awb") / 1000

					if var_105_8 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_0
					end

					if var_105_3.prefab_name ~= "" and arg_102_1.actors_[var_105_3.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_3.prefab_name].transform, "story_v_out_325611", "325611025", "story_v_out_325611.awb")

						arg_102_1:RecordAudio("325611025", var_105_9)
						arg_102_1:RecordAudio("325611025", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_325611", "325611025", "story_v_out_325611.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_325611", "325611025", "story_v_out_325611.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_10 and arg_102_1.time_ < var_105_0 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play325611026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 325611026
		arg_106_1.duration_ = 7.6

		local var_106_0 = {
			zh = 6.133,
			ja = 7.6
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
				arg_106_0:Play325611027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1071ui_story"].transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.moveOldPos1071ui_story = var_109_0.localPosition
			end

			local var_109_2 = 0.001

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2
				local var_109_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_109_0.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1071ui_story, var_109_4, var_109_3)

				local var_109_5 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_5.x, var_109_5.y, var_109_5.z)

				local var_109_6 = var_109_0.localEulerAngles

				var_109_6.z = 0
				var_109_6.x = 0
				var_109_0.localEulerAngles = var_109_6
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 then
				var_109_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_109_7 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_7.x, var_109_7.y, var_109_7.z)

				local var_109_8 = var_109_0.localEulerAngles

				var_109_8.z = 0
				var_109_8.x = 0
				var_109_0.localEulerAngles = var_109_8
			end

			local var_109_9 = arg_106_1.actors_["10175ui_story"].transform
			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 then
				arg_106_1.var_.moveOldPos10175ui_story = var_109_9.localPosition

				local var_109_11 = GameObjectTools.GetOrAddComponent(var_109_9.gameObject, typeof(DynamicBoneHelper))

				if var_109_11 then
					var_109_11:EnableDynamicBone(false)
				end
			end

			local var_109_12 = 0.001

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_12 then
				local var_109_13 = (arg_106_1.time_ - var_109_10) / var_109_12
				local var_109_14 = Vector3.New(0.7, -1, -6.05)

				var_109_9.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10175ui_story, var_109_14, var_109_13)

				local var_109_15 = manager.ui.mainCamera.transform.position - var_109_9.position

				var_109_9.forward = Vector3.New(var_109_15.x, var_109_15.y, var_109_15.z)

				local var_109_16 = var_109_9.localEulerAngles

				var_109_16.z = 0
				var_109_16.x = 0
				var_109_9.localEulerAngles = var_109_16
			end

			if arg_106_1.time_ >= var_109_10 + var_109_12 and arg_106_1.time_ < var_109_10 + var_109_12 + arg_109_0 then
				var_109_9.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_109_17 = manager.ui.mainCamera.transform.position - var_109_9.position

				var_109_9.forward = Vector3.New(var_109_17.x, var_109_17.y, var_109_17.z)

				local var_109_18 = var_109_9.localEulerAngles

				var_109_18.z = 0
				var_109_18.x = 0
				var_109_9.localEulerAngles = var_109_18

				local var_109_19 = GameObjectTools.GetOrAddComponent(var_109_9.gameObject, typeof(DynamicBoneHelper))

				if var_109_19 then
					var_109_19:EnableDynamicBone(true)
				end
			end

			local var_109_20 = arg_106_1.actors_["10175ui_story"]
			local var_109_21 = 0

			if var_109_21 < arg_106_1.time_ and arg_106_1.time_ <= var_109_21 + arg_109_0 and not isNil(var_109_20) and arg_106_1.var_.characterEffect10175ui_story == nil then
				arg_106_1.var_.characterEffect10175ui_story = var_109_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_22 = 0.200000002980232

			if var_109_21 <= arg_106_1.time_ and arg_106_1.time_ < var_109_21 + var_109_22 and not isNil(var_109_20) then
				local var_109_23 = (arg_106_1.time_ - var_109_21) / var_109_22

				if arg_106_1.var_.characterEffect10175ui_story and not isNil(var_109_20) then
					arg_106_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_21 + var_109_22 and arg_106_1.time_ < var_109_21 + var_109_22 + arg_109_0 and not isNil(var_109_20) and arg_106_1.var_.characterEffect10175ui_story then
				arg_106_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_109_24 = arg_106_1.actors_["1071ui_story"]
			local var_109_25 = 0

			if var_109_25 < arg_106_1.time_ and arg_106_1.time_ <= var_109_25 + arg_109_0 and not isNil(var_109_24) and arg_106_1.var_.characterEffect1071ui_story == nil then
				arg_106_1.var_.characterEffect1071ui_story = var_109_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_26 = 0.200000002980232

			if var_109_25 <= arg_106_1.time_ and arg_106_1.time_ < var_109_25 + var_109_26 and not isNil(var_109_24) then
				local var_109_27 = (arg_106_1.time_ - var_109_25) / var_109_26

				if arg_106_1.var_.characterEffect1071ui_story and not isNil(var_109_24) then
					local var_109_28 = Mathf.Lerp(0, 0.5, var_109_27)

					arg_106_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1071ui_story.fillRatio = var_109_28
				end
			end

			if arg_106_1.time_ >= var_109_25 + var_109_26 and arg_106_1.time_ < var_109_25 + var_109_26 + arg_109_0 and not isNil(var_109_24) and arg_106_1.var_.characterEffect1071ui_story then
				local var_109_29 = 0.5

				arg_106_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1071ui_story.fillRatio = var_109_29
			end

			local var_109_30 = 0

			if var_109_30 < arg_106_1.time_ and arg_106_1.time_ <= var_109_30 + arg_109_0 then
				arg_106_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			local var_109_31 = 0

			if var_109_31 < arg_106_1.time_ and arg_106_1.time_ <= var_109_31 + arg_109_0 then
				arg_106_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_109_32 = 0
			local var_109_33 = 0.6

			if var_109_32 < arg_106_1.time_ and arg_106_1.time_ <= var_109_32 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_34 = arg_106_1:FormatText(StoryNameCfg[1473].name)

				arg_106_1.leftNameTxt_.text = var_109_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_35 = arg_106_1:GetWordFromCfg(325611026)
				local var_109_36 = arg_106_1:FormatText(var_109_35.content)

				arg_106_1.text_.text = var_109_36

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_37 = 24
				local var_109_38 = utf8.len(var_109_36)
				local var_109_39 = var_109_37 <= 0 and var_109_33 or var_109_33 * (var_109_38 / var_109_37)

				if var_109_39 > 0 and var_109_33 < var_109_39 then
					arg_106_1.talkMaxDuration = var_109_39

					if var_109_39 + var_109_32 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_39 + var_109_32
					end
				end

				arg_106_1.text_.text = var_109_36
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611026", "story_v_out_325611.awb") ~= 0 then
					local var_109_40 = manager.audio:GetVoiceLength("story_v_out_325611", "325611026", "story_v_out_325611.awb") / 1000

					if var_109_40 + var_109_32 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_40 + var_109_32
					end

					if var_109_35.prefab_name ~= "" and arg_106_1.actors_[var_109_35.prefab_name] ~= nil then
						local var_109_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_35.prefab_name].transform, "story_v_out_325611", "325611026", "story_v_out_325611.awb")

						arg_106_1:RecordAudio("325611026", var_109_41)
						arg_106_1:RecordAudio("325611026", var_109_41)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_325611", "325611026", "story_v_out_325611.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_325611", "325611026", "story_v_out_325611.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_42 = math.max(var_109_33, arg_106_1.talkMaxDuration)

			if var_109_32 <= arg_106_1.time_ and arg_106_1.time_ < var_109_32 + var_109_42 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_32) / var_109_42

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_32 + var_109_42 and arg_106_1.time_ < var_109_32 + var_109_42 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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

		arg_106_1:InitPlayNodeList()
	end,
	Play325611027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 325611027
		arg_110_1.duration_ = 7.93

		local var_110_0 = {
			zh = 4.9,
			ja = 7.933
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
				arg_110_0:Play325611028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.625

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[1473].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_3 = arg_110_1:GetWordFromCfg(325611027)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 25
				local var_113_6 = utf8.len(var_113_4)
				local var_113_7 = var_113_5 <= 0 and var_113_1 or var_113_1 * (var_113_6 / var_113_5)

				if var_113_7 > 0 and var_113_1 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611027", "story_v_out_325611.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_325611", "325611027", "story_v_out_325611.awb") / 1000

					if var_113_8 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_0
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_325611", "325611027", "story_v_out_325611.awb")

						arg_110_1:RecordAudio("325611027", var_113_9)
						arg_110_1:RecordAudio("325611027", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_325611", "325611027", "story_v_out_325611.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_325611", "325611027", "story_v_out_325611.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_10 and arg_110_1.time_ < var_113_0 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play325611028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 325611028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play325611029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["10175ui_story"].transform
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.var_.moveOldPos10175ui_story = var_117_0.localPosition

				local var_117_2 = GameObjectTools.GetOrAddComponent(var_117_0.gameObject, typeof(DynamicBoneHelper))

				if var_117_2 then
					var_117_2:EnableDynamicBone(false)
				end
			end

			local var_117_3 = 0.001

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_3 then
				local var_117_4 = (arg_114_1.time_ - var_117_1) / var_117_3
				local var_117_5 = Vector3.New(0, 100, 0)

				var_117_0.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10175ui_story, var_117_5, var_117_4)

				local var_117_6 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_6.x, var_117_6.y, var_117_6.z)

				local var_117_7 = var_117_0.localEulerAngles

				var_117_7.z = 0
				var_117_7.x = 0
				var_117_0.localEulerAngles = var_117_7
			end

			if arg_114_1.time_ >= var_117_1 + var_117_3 and arg_114_1.time_ < var_117_1 + var_117_3 + arg_117_0 then
				var_117_0.localPosition = Vector3.New(0, 100, 0)

				local var_117_8 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_8.x, var_117_8.y, var_117_8.z)

				local var_117_9 = var_117_0.localEulerAngles

				var_117_9.z = 0
				var_117_9.x = 0
				var_117_0.localEulerAngles = var_117_9

				local var_117_10 = GameObjectTools.GetOrAddComponent(var_117_0.gameObject, typeof(DynamicBoneHelper))

				if var_117_10 then
					var_117_10:EnableDynamicBone(true)
				end
			end

			local var_117_11 = arg_114_1.actors_["10175ui_story"]
			local var_117_12 = 0

			if var_117_12 < arg_114_1.time_ and arg_114_1.time_ <= var_117_12 + arg_117_0 and not isNil(var_117_11) and arg_114_1.var_.characterEffect10175ui_story == nil then
				arg_114_1.var_.characterEffect10175ui_story = var_117_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_13 = 0.200000002980232

			if var_117_12 <= arg_114_1.time_ and arg_114_1.time_ < var_117_12 + var_117_13 and not isNil(var_117_11) then
				local var_117_14 = (arg_114_1.time_ - var_117_12) / var_117_13

				if arg_114_1.var_.characterEffect10175ui_story and not isNil(var_117_11) then
					local var_117_15 = Mathf.Lerp(0, 0.5, var_117_14)

					arg_114_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_114_1.var_.characterEffect10175ui_story.fillRatio = var_117_15
				end
			end

			if arg_114_1.time_ >= var_117_12 + var_117_13 and arg_114_1.time_ < var_117_12 + var_117_13 + arg_117_0 and not isNil(var_117_11) and arg_114_1.var_.characterEffect10175ui_story then
				local var_117_16 = 0.5

				arg_114_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_114_1.var_.characterEffect10175ui_story.fillRatio = var_117_16
			end

			local var_117_17 = arg_114_1.actors_["1071ui_story"].transform
			local var_117_18 = 0

			if var_117_18 < arg_114_1.time_ and arg_114_1.time_ <= var_117_18 + arg_117_0 then
				arg_114_1.var_.moveOldPos1071ui_story = var_117_17.localPosition
			end

			local var_117_19 = 0.001

			if var_117_18 <= arg_114_1.time_ and arg_114_1.time_ < var_117_18 + var_117_19 then
				local var_117_20 = (arg_114_1.time_ - var_117_18) / var_117_19
				local var_117_21 = Vector3.New(0, 100, 0)

				var_117_17.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1071ui_story, var_117_21, var_117_20)

				local var_117_22 = manager.ui.mainCamera.transform.position - var_117_17.position

				var_117_17.forward = Vector3.New(var_117_22.x, var_117_22.y, var_117_22.z)

				local var_117_23 = var_117_17.localEulerAngles

				var_117_23.z = 0
				var_117_23.x = 0
				var_117_17.localEulerAngles = var_117_23
			end

			if arg_114_1.time_ >= var_117_18 + var_117_19 and arg_114_1.time_ < var_117_18 + var_117_19 + arg_117_0 then
				var_117_17.localPosition = Vector3.New(0, 100, 0)

				local var_117_24 = manager.ui.mainCamera.transform.position - var_117_17.position

				var_117_17.forward = Vector3.New(var_117_24.x, var_117_24.y, var_117_24.z)

				local var_117_25 = var_117_17.localEulerAngles

				var_117_25.z = 0
				var_117_25.x = 0
				var_117_17.localEulerAngles = var_117_25
			end

			local var_117_26 = 0
			local var_117_27 = 1.025

			if var_117_26 < arg_114_1.time_ and arg_114_1.time_ <= var_117_26 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_28 = arg_114_1:GetWordFromCfg(325611028)
				local var_117_29 = arg_114_1:FormatText(var_117_28.content)

				arg_114_1.text_.text = var_117_29

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_30 = 41
				local var_117_31 = utf8.len(var_117_29)
				local var_117_32 = var_117_30 <= 0 and var_117_27 or var_117_27 * (var_117_31 / var_117_30)

				if var_117_32 > 0 and var_117_27 < var_117_32 then
					arg_114_1.talkMaxDuration = var_117_32

					if var_117_32 + var_117_26 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_32 + var_117_26
					end
				end

				arg_114_1.text_.text = var_117_29
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_33 = math.max(var_117_27, arg_114_1.talkMaxDuration)

			if var_117_26 <= arg_114_1.time_ and arg_114_1.time_ < var_117_26 + var_117_33 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_26) / var_117_33

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_26 + var_117_33 and arg_114_1.time_ < var_117_26 + var_117_33 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
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
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play325611029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 325611029
		arg_118_1.duration_ = 9

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play325611030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = "J21h"

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
				local var_121_5 = arg_118_1.bgs_.J21h

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
					if iter_121_0 ~= "J21h" then
						iter_121_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_121_16 = 4

			if var_121_16 < arg_118_1.time_ and arg_118_1.time_ <= var_121_16 + arg_121_0 then
				arg_118_1.allBtn_.enabled = false
			end

			local var_121_17 = 0.3

			if arg_118_1.time_ >= var_121_16 + var_121_17 and arg_118_1.time_ < var_121_16 + var_121_17 + arg_121_0 then
				arg_118_1.allBtn_.enabled = true
			end

			local var_121_18 = 0

			if var_121_18 < arg_118_1.time_ and arg_118_1.time_ <= var_121_18 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_19 = 2

			if var_121_18 <= arg_118_1.time_ and arg_118_1.time_ < var_121_18 + var_121_19 then
				local var_121_20 = (arg_118_1.time_ - var_121_18) / var_121_19
				local var_121_21 = Color.New(0, 0, 0)

				var_121_21.a = Mathf.Lerp(0, 1, var_121_20)
				arg_118_1.mask_.color = var_121_21
			end

			if arg_118_1.time_ >= var_121_18 + var_121_19 and arg_118_1.time_ < var_121_18 + var_121_19 + arg_121_0 then
				local var_121_22 = Color.New(0, 0, 0)

				var_121_22.a = 1
				arg_118_1.mask_.color = var_121_22
			end

			local var_121_23 = 2

			if var_121_23 < arg_118_1.time_ and arg_118_1.time_ <= var_121_23 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_24 = 2

			if var_121_23 <= arg_118_1.time_ and arg_118_1.time_ < var_121_23 + var_121_24 then
				local var_121_25 = (arg_118_1.time_ - var_121_23) / var_121_24
				local var_121_26 = Color.New(0, 0, 0)

				var_121_26.a = Mathf.Lerp(1, 0, var_121_25)
				arg_118_1.mask_.color = var_121_26
			end

			if arg_118_1.time_ >= var_121_23 + var_121_24 and arg_118_1.time_ < var_121_23 + var_121_24 + arg_121_0 then
				local var_121_27 = Color.New(0, 0, 0)
				local var_121_28 = 0

				arg_118_1.mask_.enabled = false
				var_121_27.a = var_121_28
				arg_118_1.mask_.color = var_121_27
			end

			local var_121_29 = 0.1
			local var_121_30 = 1

			if var_121_29 < arg_118_1.time_ and arg_118_1.time_ <= var_121_29 + arg_121_0 then
				local var_121_31 = "stop"
				local var_121_32 = "effect"

				arg_118_1:AudioAction(var_121_31, var_121_32, "se_story_122_01", "se_story_122_01_battleground_loop", "")
			end

			local var_121_33 = 0.1
			local var_121_34 = 1

			if var_121_33 < arg_118_1.time_ and arg_118_1.time_ <= var_121_33 + arg_121_0 then
				local var_121_35 = "play"
				local var_121_36 = "effect"

				arg_118_1:AudioAction(var_121_35, var_121_36, "se_story_148", "se_story_148_amb_wind", "")
			end

			if arg_118_1.frameCnt_ <= 1 then
				arg_118_1.dialog_:SetActive(false)
			end

			local var_121_37 = 4
			local var_121_38 = 1.625

			if var_121_37 < arg_118_1.time_ and arg_118_1.time_ <= var_121_37 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0

				arg_118_1.dialog_:SetActive(true)

				arg_118_1.dialogCg_.alpha = 0

				local var_121_39 = LeanTween.value(arg_118_1.dialog_, 0, 1, 0.3)

				var_121_39:setOnUpdate(LuaHelper.FloatAction(function(arg_122_0)
					arg_118_1.dialogCg_.alpha = arg_122_0
				end))
				var_121_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_118_1.dialog_)
					var_121_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_118_1.duration_ = arg_118_1.duration_ + 0.3

				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_40 = arg_118_1:GetWordFromCfg(325611029)
				local var_121_41 = arg_118_1:FormatText(var_121_40.content)

				arg_118_1.text_.text = var_121_41

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_42 = 65
				local var_121_43 = utf8.len(var_121_41)
				local var_121_44 = var_121_42 <= 0 and var_121_38 or var_121_38 * (var_121_43 / var_121_42)

				if var_121_44 > 0 and var_121_38 < var_121_44 then
					arg_118_1.talkMaxDuration = var_121_44
					var_121_37 = var_121_37 + 0.3

					if var_121_44 + var_121_37 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_44 + var_121_37
					end
				end

				arg_118_1.text_.text = var_121_41
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_45 = var_121_37 + 0.3
			local var_121_46 = math.max(var_121_38, arg_118_1.talkMaxDuration)

			if var_121_45 <= arg_118_1.time_ and arg_118_1.time_ < var_121_45 + var_121_46 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_45) / var_121_46

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_45 + var_121_46 and arg_118_1.time_ < var_121_45 + var_121_46 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play325611030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 325611030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play325611031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.975

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_2 = arg_124_1:GetWordFromCfg(325611030)
				local var_127_3 = arg_124_1:FormatText(var_127_2.content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 39
				local var_127_5 = utf8.len(var_127_3)
				local var_127_6 = var_127_4 <= 0 and var_127_1 or var_127_1 * (var_127_5 / var_127_4)

				if var_127_6 > 0 and var_127_1 < var_127_6 then
					arg_124_1.talkMaxDuration = var_127_6

					if var_127_6 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_6 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_7 and arg_124_1.time_ < var_127_0 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play325611031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 325611031
		arg_128_1.duration_ = 4.6

		local var_128_0 = {
			zh = 2.466,
			ja = 4.6
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
				arg_128_0:Play325611032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["10175ui_story"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos10175ui_story = var_131_0.localPosition

				local var_131_2 = GameObjectTools.GetOrAddComponent(var_131_0.gameObject, typeof(DynamicBoneHelper))

				if var_131_2 then
					var_131_2:EnableDynamicBone(false)
				end
			end

			local var_131_3 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_3 then
				local var_131_4 = (arg_128_1.time_ - var_131_1) / var_131_3
				local var_131_5 = Vector3.New(0, -1, -6.05)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10175ui_story, var_131_5, var_131_4)

				local var_131_6 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_6.x, var_131_6.y, var_131_6.z)

				local var_131_7 = var_131_0.localEulerAngles

				var_131_7.z = 0
				var_131_7.x = 0
				var_131_0.localEulerAngles = var_131_7
			end

			if arg_128_1.time_ >= var_131_1 + var_131_3 and arg_128_1.time_ < var_131_1 + var_131_3 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_131_8 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_8.x, var_131_8.y, var_131_8.z)

				local var_131_9 = var_131_0.localEulerAngles

				var_131_9.z = 0
				var_131_9.x = 0
				var_131_0.localEulerAngles = var_131_9

				local var_131_10 = GameObjectTools.GetOrAddComponent(var_131_0.gameObject, typeof(DynamicBoneHelper))

				if var_131_10 then
					var_131_10:EnableDynamicBone(true)
				end
			end

			local var_131_11 = arg_128_1.actors_["10175ui_story"]
			local var_131_12 = 0

			if var_131_12 < arg_128_1.time_ and arg_128_1.time_ <= var_131_12 + arg_131_0 and not isNil(var_131_11) and arg_128_1.var_.characterEffect10175ui_story == nil then
				arg_128_1.var_.characterEffect10175ui_story = var_131_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_13 = 0.200000002980232

			if var_131_12 <= arg_128_1.time_ and arg_128_1.time_ < var_131_12 + var_131_13 and not isNil(var_131_11) then
				local var_131_14 = (arg_128_1.time_ - var_131_12) / var_131_13

				if arg_128_1.var_.characterEffect10175ui_story and not isNil(var_131_11) then
					arg_128_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_12 + var_131_13 and arg_128_1.time_ < var_131_12 + var_131_13 + arg_131_0 and not isNil(var_131_11) and arg_128_1.var_.characterEffect10175ui_story then
				arg_128_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_131_15 = 0

			if var_131_15 < arg_128_1.time_ and arg_128_1.time_ <= var_131_15 + arg_131_0 then
				arg_128_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			local var_131_16 = 0

			if var_131_16 < arg_128_1.time_ and arg_128_1.time_ <= var_131_16 + arg_131_0 then
				arg_128_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_131_17 = 0
			local var_131_18 = 0.225

			if var_131_17 < arg_128_1.time_ and arg_128_1.time_ <= var_131_17 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_19 = arg_128_1:FormatText(StoryNameCfg[1473].name)

				arg_128_1.leftNameTxt_.text = var_131_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_20 = arg_128_1:GetWordFromCfg(325611031)
				local var_131_21 = arg_128_1:FormatText(var_131_20.content)

				arg_128_1.text_.text = var_131_21

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_22 = 9
				local var_131_23 = utf8.len(var_131_21)
				local var_131_24 = var_131_22 <= 0 and var_131_18 or var_131_18 * (var_131_23 / var_131_22)

				if var_131_24 > 0 and var_131_18 < var_131_24 then
					arg_128_1.talkMaxDuration = var_131_24

					if var_131_24 + var_131_17 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_24 + var_131_17
					end
				end

				arg_128_1.text_.text = var_131_21
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611031", "story_v_out_325611.awb") ~= 0 then
					local var_131_25 = manager.audio:GetVoiceLength("story_v_out_325611", "325611031", "story_v_out_325611.awb") / 1000

					if var_131_25 + var_131_17 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_25 + var_131_17
					end

					if var_131_20.prefab_name ~= "" and arg_128_1.actors_[var_131_20.prefab_name] ~= nil then
						local var_131_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_20.prefab_name].transform, "story_v_out_325611", "325611031", "story_v_out_325611.awb")

						arg_128_1:RecordAudio("325611031", var_131_26)
						arg_128_1:RecordAudio("325611031", var_131_26)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_325611", "325611031", "story_v_out_325611.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_325611", "325611031", "story_v_out_325611.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_27 = math.max(var_131_18, arg_128_1.talkMaxDuration)

			if var_131_17 <= arg_128_1.time_ and arg_128_1.time_ < var_131_17 + var_131_27 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_17) / var_131_27

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_17 + var_131_27 and arg_128_1.time_ < var_131_17 + var_131_27 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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

		arg_128_1:InitPlayNodeList()
	end,
	Play325611032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 325611032
		arg_132_1.duration_ = 3.33

		local var_132_0 = {
			zh = 3.333,
			ja = 2.8
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
				arg_132_0:Play325611033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["10175ui_story"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos10175ui_story = var_135_0.localPosition

				local var_135_2 = GameObjectTools.GetOrAddComponent(var_135_0.gameObject, typeof(DynamicBoneHelper))

				if var_135_2 then
					var_135_2:EnableDynamicBone(false)
				end
			end

			local var_135_3 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_3 then
				local var_135_4 = (arg_132_1.time_ - var_135_1) / var_135_3
				local var_135_5 = Vector3.New(-0.7, -1, -6.05)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10175ui_story, var_135_5, var_135_4)

				local var_135_6 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_6.x, var_135_6.y, var_135_6.z)

				local var_135_7 = var_135_0.localEulerAngles

				var_135_7.z = 0
				var_135_7.x = 0
				var_135_0.localEulerAngles = var_135_7
			end

			if arg_132_1.time_ >= var_135_1 + var_135_3 and arg_132_1.time_ < var_135_1 + var_135_3 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(-0.7, -1, -6.05)

				local var_135_8 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_8.x, var_135_8.y, var_135_8.z)

				local var_135_9 = var_135_0.localEulerAngles

				var_135_9.z = 0
				var_135_9.x = 0
				var_135_0.localEulerAngles = var_135_9

				local var_135_10 = GameObjectTools.GetOrAddComponent(var_135_0.gameObject, typeof(DynamicBoneHelper))

				if var_135_10 then
					var_135_10:EnableDynamicBone(true)
				end
			end

			local var_135_11 = "10167ui_story"

			if arg_132_1.actors_[var_135_11] == nil then
				local var_135_12 = Asset.Load("Char/" .. "10167ui_story")

				if not isNil(var_135_12) then
					local var_135_13 = Object.Instantiate(Asset.Load("Char/" .. "10167ui_story"), arg_132_1.stage_.transform)

					var_135_13.name = var_135_11
					var_135_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_132_1.actors_[var_135_11] = var_135_13

					local var_135_14 = var_135_13:GetComponentInChildren(typeof(CharacterEffect))

					var_135_14.enabled = true

					local var_135_15 = GameObjectTools.GetOrAddComponent(var_135_13, typeof(DynamicBoneHelper))

					if var_135_15 then
						var_135_15:EnableDynamicBone(false)
					end

					arg_132_1:ShowWeapon(var_135_14.transform, false)

					arg_132_1.var_[var_135_11 .. "Animator"] = var_135_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_132_1.var_[var_135_11 .. "Animator"].applyRootMotion = true
					arg_132_1.var_[var_135_11 .. "LipSync"] = var_135_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_135_16 = arg_132_1.actors_["10167ui_story"].transform
			local var_135_17 = 0

			if var_135_17 < arg_132_1.time_ and arg_132_1.time_ <= var_135_17 + arg_135_0 then
				arg_132_1.var_.moveOldPos10167ui_story = var_135_16.localPosition

				local var_135_18 = GameObjectTools.GetOrAddComponent(var_135_16.gameObject, typeof(DynamicBoneHelper))

				if var_135_18 then
					var_135_18:EnableDynamicBone(false)
				end
			end

			local var_135_19 = 0.001

			if var_135_17 <= arg_132_1.time_ and arg_132_1.time_ < var_135_17 + var_135_19 then
				local var_135_20 = (arg_132_1.time_ - var_135_17) / var_135_19
				local var_135_21 = Vector3.New(0.7, -1.28, -5.73)

				var_135_16.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10167ui_story, var_135_21, var_135_20)

				local var_135_22 = manager.ui.mainCamera.transform.position - var_135_16.position

				var_135_16.forward = Vector3.New(var_135_22.x, var_135_22.y, var_135_22.z)

				local var_135_23 = var_135_16.localEulerAngles

				var_135_23.z = 0
				var_135_23.x = 0
				var_135_16.localEulerAngles = var_135_23
			end

			if arg_132_1.time_ >= var_135_17 + var_135_19 and arg_132_1.time_ < var_135_17 + var_135_19 + arg_135_0 then
				var_135_16.localPosition = Vector3.New(0.7, -1.28, -5.73)

				local var_135_24 = manager.ui.mainCamera.transform.position - var_135_16.position

				var_135_16.forward = Vector3.New(var_135_24.x, var_135_24.y, var_135_24.z)

				local var_135_25 = var_135_16.localEulerAngles

				var_135_25.z = 0
				var_135_25.x = 0
				var_135_16.localEulerAngles = var_135_25

				local var_135_26 = GameObjectTools.GetOrAddComponent(var_135_16.gameObject, typeof(DynamicBoneHelper))

				if var_135_26 then
					var_135_26:EnableDynamicBone(true)
				end
			end

			local var_135_27 = arg_132_1.actors_["10167ui_story"]
			local var_135_28 = 0

			if var_135_28 < arg_132_1.time_ and arg_132_1.time_ <= var_135_28 + arg_135_0 and not isNil(var_135_27) and arg_132_1.var_.characterEffect10167ui_story == nil then
				arg_132_1.var_.characterEffect10167ui_story = var_135_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_29 = 0.200000002980232

			if var_135_28 <= arg_132_1.time_ and arg_132_1.time_ < var_135_28 + var_135_29 and not isNil(var_135_27) then
				local var_135_30 = (arg_132_1.time_ - var_135_28) / var_135_29

				if arg_132_1.var_.characterEffect10167ui_story and not isNil(var_135_27) then
					arg_132_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_28 + var_135_29 and arg_132_1.time_ < var_135_28 + var_135_29 + arg_135_0 and not isNil(var_135_27) and arg_132_1.var_.characterEffect10167ui_story then
				arg_132_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_135_31 = arg_132_1.actors_["10175ui_story"]
			local var_135_32 = 0

			if var_135_32 < arg_132_1.time_ and arg_132_1.time_ <= var_135_32 + arg_135_0 and not isNil(var_135_31) and arg_132_1.var_.characterEffect10175ui_story == nil then
				arg_132_1.var_.characterEffect10175ui_story = var_135_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_33 = 0.200000002980232

			if var_135_32 <= arg_132_1.time_ and arg_132_1.time_ < var_135_32 + var_135_33 and not isNil(var_135_31) then
				local var_135_34 = (arg_132_1.time_ - var_135_32) / var_135_33

				if arg_132_1.var_.characterEffect10175ui_story and not isNil(var_135_31) then
					local var_135_35 = Mathf.Lerp(0, 0.5, var_135_34)

					arg_132_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_132_1.var_.characterEffect10175ui_story.fillRatio = var_135_35
				end
			end

			if arg_132_1.time_ >= var_135_32 + var_135_33 and arg_132_1.time_ < var_135_32 + var_135_33 + arg_135_0 and not isNil(var_135_31) and arg_132_1.var_.characterEffect10175ui_story then
				local var_135_36 = 0.5

				arg_132_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_132_1.var_.characterEffect10175ui_story.fillRatio = var_135_36
			end

			local var_135_37 = 0

			if var_135_37 < arg_132_1.time_ and arg_132_1.time_ <= var_135_37 + arg_135_0 then
				arg_132_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			local var_135_38 = 0

			if var_135_38 < arg_132_1.time_ and arg_132_1.time_ <= var_135_38 + arg_135_0 then
				arg_132_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_135_39 = 0
			local var_135_40 = 0.2

			if var_135_39 < arg_132_1.time_ and arg_132_1.time_ <= var_135_39 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_41 = arg_132_1:FormatText(StoryNameCfg[1447].name)

				arg_132_1.leftNameTxt_.text = var_135_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_42 = arg_132_1:GetWordFromCfg(325611032)
				local var_135_43 = arg_132_1:FormatText(var_135_42.content)

				arg_132_1.text_.text = var_135_43

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_44 = 8
				local var_135_45 = utf8.len(var_135_43)
				local var_135_46 = var_135_44 <= 0 and var_135_40 or var_135_40 * (var_135_45 / var_135_44)

				if var_135_46 > 0 and var_135_40 < var_135_46 then
					arg_132_1.talkMaxDuration = var_135_46

					if var_135_46 + var_135_39 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_46 + var_135_39
					end
				end

				arg_132_1.text_.text = var_135_43
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611032", "story_v_out_325611.awb") ~= 0 then
					local var_135_47 = manager.audio:GetVoiceLength("story_v_out_325611", "325611032", "story_v_out_325611.awb") / 1000

					if var_135_47 + var_135_39 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_47 + var_135_39
					end

					if var_135_42.prefab_name ~= "" and arg_132_1.actors_[var_135_42.prefab_name] ~= nil then
						local var_135_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_42.prefab_name].transform, "story_v_out_325611", "325611032", "story_v_out_325611.awb")

						arg_132_1:RecordAudio("325611032", var_135_48)
						arg_132_1:RecordAudio("325611032", var_135_48)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_325611", "325611032", "story_v_out_325611.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_325611", "325611032", "story_v_out_325611.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_49 = math.max(var_135_40, arg_132_1.talkMaxDuration)

			if var_135_39 <= arg_132_1.time_ and arg_132_1.time_ < var_135_39 + var_135_49 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_39) / var_135_49

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_39 + var_135_49 and arg_132_1.time_ < var_135_39 + var_135_49 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
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

		arg_132_1:InitPlayNodeList()
	end,
	Play325611033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 325611033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play325611034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["10167ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect10167ui_story == nil then
				arg_136_1.var_.characterEffect10167ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect10167ui_story and not isNil(var_139_0) then
					local var_139_4 = Mathf.Lerp(0, 0.5, var_139_3)

					arg_136_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_136_1.var_.characterEffect10167ui_story.fillRatio = var_139_4
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect10167ui_story then
				local var_139_5 = 0.5

				arg_136_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_136_1.var_.characterEffect10167ui_story.fillRatio = var_139_5
			end

			local var_139_6 = 0
			local var_139_7 = 0.7

			if var_139_6 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_8 = arg_136_1:GetWordFromCfg(325611033)
				local var_139_9 = arg_136_1:FormatText(var_139_8.content)

				arg_136_1.text_.text = var_139_9

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_10 = 28
				local var_139_11 = utf8.len(var_139_9)
				local var_139_12 = var_139_10 <= 0 and var_139_7 or var_139_7 * (var_139_11 / var_139_10)

				if var_139_12 > 0 and var_139_7 < var_139_12 then
					arg_136_1.talkMaxDuration = var_139_12

					if var_139_12 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_12 + var_139_6
					end
				end

				arg_136_1.text_.text = var_139_9
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_13 = math.max(var_139_7, arg_136_1.talkMaxDuration)

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_13 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_6) / var_139_13

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_6 + var_139_13 and arg_136_1.time_ < var_139_6 + var_139_13 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play325611034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 325611034
		arg_140_1.duration_ = 6.97

		local var_140_0 = {
			zh = 5.866,
			ja = 6.966
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
				arg_140_0:Play325611035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["10175ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect10175ui_story == nil then
				arg_140_1.var_.characterEffect10175ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect10175ui_story and not isNil(var_143_0) then
					arg_140_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect10175ui_story then
				arg_140_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_143_4 = 0
			local var_143_5 = 0.65

			if var_143_4 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_6 = arg_140_1:FormatText(StoryNameCfg[1473].name)

				arg_140_1.leftNameTxt_.text = var_143_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_7 = arg_140_1:GetWordFromCfg(325611034)
				local var_143_8 = arg_140_1:FormatText(var_143_7.content)

				arg_140_1.text_.text = var_143_8

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_9 = 26
				local var_143_10 = utf8.len(var_143_8)
				local var_143_11 = var_143_9 <= 0 and var_143_5 or var_143_5 * (var_143_10 / var_143_9)

				if var_143_11 > 0 and var_143_5 < var_143_11 then
					arg_140_1.talkMaxDuration = var_143_11

					if var_143_11 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_11 + var_143_4
					end
				end

				arg_140_1.text_.text = var_143_8
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611034", "story_v_out_325611.awb") ~= 0 then
					local var_143_12 = manager.audio:GetVoiceLength("story_v_out_325611", "325611034", "story_v_out_325611.awb") / 1000

					if var_143_12 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_12 + var_143_4
					end

					if var_143_7.prefab_name ~= "" and arg_140_1.actors_[var_143_7.prefab_name] ~= nil then
						local var_143_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_7.prefab_name].transform, "story_v_out_325611", "325611034", "story_v_out_325611.awb")

						arg_140_1:RecordAudio("325611034", var_143_13)
						arg_140_1:RecordAudio("325611034", var_143_13)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_325611", "325611034", "story_v_out_325611.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_325611", "325611034", "story_v_out_325611.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_14 = math.max(var_143_5, arg_140_1.talkMaxDuration)

			if var_143_4 <= arg_140_1.time_ and arg_140_1.time_ < var_143_4 + var_143_14 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_4) / var_143_14

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_4 + var_143_14 and arg_140_1.time_ < var_143_4 + var_143_14 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play325611035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 325611035
		arg_144_1.duration_ = 10.3

		local var_144_0 = {
			zh = 6.166,
			ja = 10.3
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
				arg_144_0:Play325611036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["10167ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect10167ui_story == nil then
				arg_144_1.var_.characterEffect10167ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect10167ui_story and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect10167ui_story then
				arg_144_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_147_4 = arg_144_1.actors_["10175ui_story"]
			local var_147_5 = 0

			if var_147_5 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.characterEffect10175ui_story == nil then
				arg_144_1.var_.characterEffect10175ui_story = var_147_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_6 = 0.200000002980232

			if var_147_5 <= arg_144_1.time_ and arg_144_1.time_ < var_147_5 + var_147_6 and not isNil(var_147_4) then
				local var_147_7 = (arg_144_1.time_ - var_147_5) / var_147_6

				if arg_144_1.var_.characterEffect10175ui_story and not isNil(var_147_4) then
					local var_147_8 = Mathf.Lerp(0, 0.5, var_147_7)

					arg_144_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_144_1.var_.characterEffect10175ui_story.fillRatio = var_147_8
				end
			end

			if arg_144_1.time_ >= var_147_5 + var_147_6 and arg_144_1.time_ < var_147_5 + var_147_6 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.characterEffect10175ui_story then
				local var_147_9 = 0.5

				arg_144_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_144_1.var_.characterEffect10175ui_story.fillRatio = var_147_9
			end

			local var_147_10 = 0
			local var_147_11 = 0.675

			if var_147_10 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_12 = arg_144_1:FormatText(StoryNameCfg[1447].name)

				arg_144_1.leftNameTxt_.text = var_147_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_13 = arg_144_1:GetWordFromCfg(325611035)
				local var_147_14 = arg_144_1:FormatText(var_147_13.content)

				arg_144_1.text_.text = var_147_14

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_15 = 27
				local var_147_16 = utf8.len(var_147_14)
				local var_147_17 = var_147_15 <= 0 and var_147_11 or var_147_11 * (var_147_16 / var_147_15)

				if var_147_17 > 0 and var_147_11 < var_147_17 then
					arg_144_1.talkMaxDuration = var_147_17

					if var_147_17 + var_147_10 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_17 + var_147_10
					end
				end

				arg_144_1.text_.text = var_147_14
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611035", "story_v_out_325611.awb") ~= 0 then
					local var_147_18 = manager.audio:GetVoiceLength("story_v_out_325611", "325611035", "story_v_out_325611.awb") / 1000

					if var_147_18 + var_147_10 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_18 + var_147_10
					end

					if var_147_13.prefab_name ~= "" and arg_144_1.actors_[var_147_13.prefab_name] ~= nil then
						local var_147_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_13.prefab_name].transform, "story_v_out_325611", "325611035", "story_v_out_325611.awb")

						arg_144_1:RecordAudio("325611035", var_147_19)
						arg_144_1:RecordAudio("325611035", var_147_19)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_325611", "325611035", "story_v_out_325611.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_325611", "325611035", "story_v_out_325611.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_20 = math.max(var_147_11, arg_144_1.talkMaxDuration)

			if var_147_10 <= arg_144_1.time_ and arg_144_1.time_ < var_147_10 + var_147_20 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_10) / var_147_20

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_10 + var_147_20 and arg_144_1.time_ < var_147_10 + var_147_20 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play325611036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 325611036
		arg_148_1.duration_ = 13.53

		local var_148_0 = {
			zh = 11.433,
			ja = 13.533
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
				arg_148_0:Play325611037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action16_1")
			end

			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_151_2 = 0
			local var_151_3 = 1.1

			if var_151_2 < arg_148_1.time_ and arg_148_1.time_ <= var_151_2 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_4 = arg_148_1:FormatText(StoryNameCfg[1447].name)

				arg_148_1.leftNameTxt_.text = var_151_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_5 = arg_148_1:GetWordFromCfg(325611036)
				local var_151_6 = arg_148_1:FormatText(var_151_5.content)

				arg_148_1.text_.text = var_151_6

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_7 = 44
				local var_151_8 = utf8.len(var_151_6)
				local var_151_9 = var_151_7 <= 0 and var_151_3 or var_151_3 * (var_151_8 / var_151_7)

				if var_151_9 > 0 and var_151_3 < var_151_9 then
					arg_148_1.talkMaxDuration = var_151_9

					if var_151_9 + var_151_2 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_9 + var_151_2
					end
				end

				arg_148_1.text_.text = var_151_6
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611036", "story_v_out_325611.awb") ~= 0 then
					local var_151_10 = manager.audio:GetVoiceLength("story_v_out_325611", "325611036", "story_v_out_325611.awb") / 1000

					if var_151_10 + var_151_2 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_10 + var_151_2
					end

					if var_151_5.prefab_name ~= "" and arg_148_1.actors_[var_151_5.prefab_name] ~= nil then
						local var_151_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_5.prefab_name].transform, "story_v_out_325611", "325611036", "story_v_out_325611.awb")

						arg_148_1:RecordAudio("325611036", var_151_11)
						arg_148_1:RecordAudio("325611036", var_151_11)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_325611", "325611036", "story_v_out_325611.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_325611", "325611036", "story_v_out_325611.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_12 = math.max(var_151_3, arg_148_1.talkMaxDuration)

			if var_151_2 <= arg_148_1.time_ and arg_148_1.time_ < var_151_2 + var_151_12 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_2) / var_151_12

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_2 + var_151_12 and arg_148_1.time_ < var_151_2 + var_151_12 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play325611037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 325611037
		arg_152_1.duration_ = 5.57

		local var_152_0 = {
			zh = 3.8,
			ja = 5.566
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
				arg_152_0:Play325611038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["10175ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect10175ui_story == nil then
				arg_152_1.var_.characterEffect10175ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect10175ui_story and not isNil(var_155_0) then
					arg_152_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect10175ui_story then
				arg_152_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_155_4 = arg_152_1.actors_["10167ui_story"]
			local var_155_5 = 0

			if var_155_5 < arg_152_1.time_ and arg_152_1.time_ <= var_155_5 + arg_155_0 and not isNil(var_155_4) and arg_152_1.var_.characterEffect10167ui_story == nil then
				arg_152_1.var_.characterEffect10167ui_story = var_155_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_6 = 0.200000002980232

			if var_155_5 <= arg_152_1.time_ and arg_152_1.time_ < var_155_5 + var_155_6 and not isNil(var_155_4) then
				local var_155_7 = (arg_152_1.time_ - var_155_5) / var_155_6

				if arg_152_1.var_.characterEffect10167ui_story and not isNil(var_155_4) then
					local var_155_8 = Mathf.Lerp(0, 0.5, var_155_7)

					arg_152_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_152_1.var_.characterEffect10167ui_story.fillRatio = var_155_8
				end
			end

			if arg_152_1.time_ >= var_155_5 + var_155_6 and arg_152_1.time_ < var_155_5 + var_155_6 + arg_155_0 and not isNil(var_155_4) and arg_152_1.var_.characterEffect10167ui_story then
				local var_155_9 = 0.5

				arg_152_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_152_1.var_.characterEffect10167ui_story.fillRatio = var_155_9
			end

			local var_155_10 = 0

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 then
				arg_152_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action4_1")
			end

			local var_155_11 = 0

			if var_155_11 < arg_152_1.time_ and arg_152_1.time_ <= var_155_11 + arg_155_0 then
				arg_152_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_155_12 = 0
			local var_155_13 = 0.475

			if var_155_12 < arg_152_1.time_ and arg_152_1.time_ <= var_155_12 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_14 = arg_152_1:FormatText(StoryNameCfg[1473].name)

				arg_152_1.leftNameTxt_.text = var_155_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_15 = arg_152_1:GetWordFromCfg(325611037)
				local var_155_16 = arg_152_1:FormatText(var_155_15.content)

				arg_152_1.text_.text = var_155_16

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_17 = 19
				local var_155_18 = utf8.len(var_155_16)
				local var_155_19 = var_155_17 <= 0 and var_155_13 or var_155_13 * (var_155_18 / var_155_17)

				if var_155_19 > 0 and var_155_13 < var_155_19 then
					arg_152_1.talkMaxDuration = var_155_19

					if var_155_19 + var_155_12 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_19 + var_155_12
					end
				end

				arg_152_1.text_.text = var_155_16
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611037", "story_v_out_325611.awb") ~= 0 then
					local var_155_20 = manager.audio:GetVoiceLength("story_v_out_325611", "325611037", "story_v_out_325611.awb") / 1000

					if var_155_20 + var_155_12 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_20 + var_155_12
					end

					if var_155_15.prefab_name ~= "" and arg_152_1.actors_[var_155_15.prefab_name] ~= nil then
						local var_155_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_15.prefab_name].transform, "story_v_out_325611", "325611037", "story_v_out_325611.awb")

						arg_152_1:RecordAudio("325611037", var_155_21)
						arg_152_1:RecordAudio("325611037", var_155_21)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_325611", "325611037", "story_v_out_325611.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_325611", "325611037", "story_v_out_325611.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_22 = math.max(var_155_13, arg_152_1.talkMaxDuration)

			if var_155_12 <= arg_152_1.time_ and arg_152_1.time_ < var_155_12 + var_155_22 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_12) / var_155_22

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_12 + var_155_22 and arg_152_1.time_ < var_155_12 + var_155_22 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play325611038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 325611038
		arg_156_1.duration_ = 8.13

		local var_156_0 = {
			zh = 5.7,
			ja = 8.133
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
				arg_156_0:Play325611039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["10175ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos10175ui_story = var_159_0.localPosition

				local var_159_2 = GameObjectTools.GetOrAddComponent(var_159_0.gameObject, typeof(DynamicBoneHelper))

				if var_159_2 then
					var_159_2:EnableDynamicBone(false)
				end
			end

			local var_159_3 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_3 then
				local var_159_4 = (arg_156_1.time_ - var_159_1) / var_159_3
				local var_159_5 = Vector3.New(0, 100, 0)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10175ui_story, var_159_5, var_159_4)

				local var_159_6 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_6.x, var_159_6.y, var_159_6.z)

				local var_159_7 = var_159_0.localEulerAngles

				var_159_7.z = 0
				var_159_7.x = 0
				var_159_0.localEulerAngles = var_159_7
			end

			if arg_156_1.time_ >= var_159_1 + var_159_3 and arg_156_1.time_ < var_159_1 + var_159_3 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(0, 100, 0)

				local var_159_8 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_8.x, var_159_8.y, var_159_8.z)

				local var_159_9 = var_159_0.localEulerAngles

				var_159_9.z = 0
				var_159_9.x = 0
				var_159_0.localEulerAngles = var_159_9

				local var_159_10 = GameObjectTools.GetOrAddComponent(var_159_0.gameObject, typeof(DynamicBoneHelper))

				if var_159_10 then
					var_159_10:EnableDynamicBone(true)
				end
			end

			local var_159_11 = arg_156_1.actors_["1071ui_story"].transform
			local var_159_12 = 0

			if var_159_12 < arg_156_1.time_ and arg_156_1.time_ <= var_159_12 + arg_159_0 then
				arg_156_1.var_.moveOldPos1071ui_story = var_159_11.localPosition
			end

			local var_159_13 = 0.001

			if var_159_12 <= arg_156_1.time_ and arg_156_1.time_ < var_159_12 + var_159_13 then
				local var_159_14 = (arg_156_1.time_ - var_159_12) / var_159_13
				local var_159_15 = Vector3.New(0, -1.05, -6.2)

				var_159_11.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1071ui_story, var_159_15, var_159_14)

				local var_159_16 = manager.ui.mainCamera.transform.position - var_159_11.position

				var_159_11.forward = Vector3.New(var_159_16.x, var_159_16.y, var_159_16.z)

				local var_159_17 = var_159_11.localEulerAngles

				var_159_17.z = 0
				var_159_17.x = 0
				var_159_11.localEulerAngles = var_159_17
			end

			if arg_156_1.time_ >= var_159_12 + var_159_13 and arg_156_1.time_ < var_159_12 + var_159_13 + arg_159_0 then
				var_159_11.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_159_18 = manager.ui.mainCamera.transform.position - var_159_11.position

				var_159_11.forward = Vector3.New(var_159_18.x, var_159_18.y, var_159_18.z)

				local var_159_19 = var_159_11.localEulerAngles

				var_159_19.z = 0
				var_159_19.x = 0
				var_159_11.localEulerAngles = var_159_19
			end

			local var_159_20 = arg_156_1.actors_["10167ui_story"].transform
			local var_159_21 = 0

			if var_159_21 < arg_156_1.time_ and arg_156_1.time_ <= var_159_21 + arg_159_0 then
				arg_156_1.var_.moveOldPos10167ui_story = var_159_20.localPosition

				local var_159_22 = GameObjectTools.GetOrAddComponent(var_159_20.gameObject, typeof(DynamicBoneHelper))

				if var_159_22 then
					var_159_22:EnableDynamicBone(false)
				end
			end

			local var_159_23 = 0.001

			if var_159_21 <= arg_156_1.time_ and arg_156_1.time_ < var_159_21 + var_159_23 then
				local var_159_24 = (arg_156_1.time_ - var_159_21) / var_159_23
				local var_159_25 = Vector3.New(0, 100, 0)

				var_159_20.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10167ui_story, var_159_25, var_159_24)

				local var_159_26 = manager.ui.mainCamera.transform.position - var_159_20.position

				var_159_20.forward = Vector3.New(var_159_26.x, var_159_26.y, var_159_26.z)

				local var_159_27 = var_159_20.localEulerAngles

				var_159_27.z = 0
				var_159_27.x = 0
				var_159_20.localEulerAngles = var_159_27
			end

			if arg_156_1.time_ >= var_159_21 + var_159_23 and arg_156_1.time_ < var_159_21 + var_159_23 + arg_159_0 then
				var_159_20.localPosition = Vector3.New(0, 100, 0)

				local var_159_28 = manager.ui.mainCamera.transform.position - var_159_20.position

				var_159_20.forward = Vector3.New(var_159_28.x, var_159_28.y, var_159_28.z)

				local var_159_29 = var_159_20.localEulerAngles

				var_159_29.z = 0
				var_159_29.x = 0
				var_159_20.localEulerAngles = var_159_29

				local var_159_30 = GameObjectTools.GetOrAddComponent(var_159_20.gameObject, typeof(DynamicBoneHelper))

				if var_159_30 then
					var_159_30:EnableDynamicBone(true)
				end
			end

			local var_159_31 = arg_156_1.actors_["1071ui_story"]
			local var_159_32 = 0

			if var_159_32 < arg_156_1.time_ and arg_156_1.time_ <= var_159_32 + arg_159_0 and not isNil(var_159_31) and arg_156_1.var_.characterEffect1071ui_story == nil then
				arg_156_1.var_.characterEffect1071ui_story = var_159_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_33 = 0.200000002980232

			if var_159_32 <= arg_156_1.time_ and arg_156_1.time_ < var_159_32 + var_159_33 and not isNil(var_159_31) then
				local var_159_34 = (arg_156_1.time_ - var_159_32) / var_159_33

				if arg_156_1.var_.characterEffect1071ui_story and not isNil(var_159_31) then
					arg_156_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_32 + var_159_33 and arg_156_1.time_ < var_159_32 + var_159_33 + arg_159_0 and not isNil(var_159_31) and arg_156_1.var_.characterEffect1071ui_story then
				arg_156_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_159_35 = arg_156_1.actors_["10175ui_story"]
			local var_159_36 = 0

			if var_159_36 < arg_156_1.time_ and arg_156_1.time_ <= var_159_36 + arg_159_0 and not isNil(var_159_35) and arg_156_1.var_.characterEffect10175ui_story == nil then
				arg_156_1.var_.characterEffect10175ui_story = var_159_35:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_37 = 0.200000002980232

			if var_159_36 <= arg_156_1.time_ and arg_156_1.time_ < var_159_36 + var_159_37 and not isNil(var_159_35) then
				local var_159_38 = (arg_156_1.time_ - var_159_36) / var_159_37

				if arg_156_1.var_.characterEffect10175ui_story and not isNil(var_159_35) then
					local var_159_39 = Mathf.Lerp(0, 0.5, var_159_38)

					arg_156_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_156_1.var_.characterEffect10175ui_story.fillRatio = var_159_39
				end
			end

			if arg_156_1.time_ >= var_159_36 + var_159_37 and arg_156_1.time_ < var_159_36 + var_159_37 + arg_159_0 and not isNil(var_159_35) and arg_156_1.var_.characterEffect10175ui_story then
				local var_159_40 = 0.5

				arg_156_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_156_1.var_.characterEffect10175ui_story.fillRatio = var_159_40
			end

			local var_159_41 = 0

			if var_159_41 < arg_156_1.time_ and arg_156_1.time_ <= var_159_41 + arg_159_0 then
				arg_156_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_159_42 = 0
			local var_159_43 = 0.65

			if var_159_42 < arg_156_1.time_ and arg_156_1.time_ <= var_159_42 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_44 = arg_156_1:FormatText(StoryNameCfg[384].name)

				arg_156_1.leftNameTxt_.text = var_159_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_45 = arg_156_1:GetWordFromCfg(325611038)
				local var_159_46 = arg_156_1:FormatText(var_159_45.content)

				arg_156_1.text_.text = var_159_46

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_47 = 26
				local var_159_48 = utf8.len(var_159_46)
				local var_159_49 = var_159_47 <= 0 and var_159_43 or var_159_43 * (var_159_48 / var_159_47)

				if var_159_49 > 0 and var_159_43 < var_159_49 then
					arg_156_1.talkMaxDuration = var_159_49

					if var_159_49 + var_159_42 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_49 + var_159_42
					end
				end

				arg_156_1.text_.text = var_159_46
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611038", "story_v_out_325611.awb") ~= 0 then
					local var_159_50 = manager.audio:GetVoiceLength("story_v_out_325611", "325611038", "story_v_out_325611.awb") / 1000

					if var_159_50 + var_159_42 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_50 + var_159_42
					end

					if var_159_45.prefab_name ~= "" and arg_156_1.actors_[var_159_45.prefab_name] ~= nil then
						local var_159_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_45.prefab_name].transform, "story_v_out_325611", "325611038", "story_v_out_325611.awb")

						arg_156_1:RecordAudio("325611038", var_159_51)
						arg_156_1:RecordAudio("325611038", var_159_51)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_325611", "325611038", "story_v_out_325611.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_325611", "325611038", "story_v_out_325611.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_52 = math.max(var_159_43, arg_156_1.talkMaxDuration)

			if var_159_42 <= arg_156_1.time_ and arg_156_1.time_ < var_159_42 + var_159_52 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_42) / var_159_52

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_42 + var_159_52 and arg_156_1.time_ < var_159_42 + var_159_52 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
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
				actorName = "1071ui_story",
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

		arg_156_1:InitPlayNodeList()
	end,
	Play325611039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 325611039
		arg_160_1.duration_ = 11.97

		local var_160_0 = {
			zh = 9.533,
			ja = 11.966
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
				arg_160_0:Play325611040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1071ui_story"].transform
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.var_.moveOldPos1071ui_story = var_163_0.localPosition
			end

			local var_163_2 = 0.001

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2
				local var_163_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_163_0.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1071ui_story, var_163_4, var_163_3)

				local var_163_5 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_5.x, var_163_5.y, var_163_5.z)

				local var_163_6 = var_163_0.localEulerAngles

				var_163_6.z = 0
				var_163_6.x = 0
				var_163_0.localEulerAngles = var_163_6
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 then
				var_163_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_163_7 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_7.x, var_163_7.y, var_163_7.z)

				local var_163_8 = var_163_0.localEulerAngles

				var_163_8.z = 0
				var_163_8.x = 0
				var_163_0.localEulerAngles = var_163_8
			end

			local var_163_9 = arg_160_1.actors_["10167ui_story"].transform
			local var_163_10 = 0

			if var_163_10 < arg_160_1.time_ and arg_160_1.time_ <= var_163_10 + arg_163_0 then
				arg_160_1.var_.moveOldPos10167ui_story = var_163_9.localPosition

				local var_163_11 = GameObjectTools.GetOrAddComponent(var_163_9.gameObject, typeof(DynamicBoneHelper))

				if var_163_11 then
					var_163_11:EnableDynamicBone(false)
				end
			end

			local var_163_12 = 0.001

			if var_163_10 <= arg_160_1.time_ and arg_160_1.time_ < var_163_10 + var_163_12 then
				local var_163_13 = (arg_160_1.time_ - var_163_10) / var_163_12
				local var_163_14 = Vector3.New(0.7, -1.28, -5.73)

				var_163_9.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10167ui_story, var_163_14, var_163_13)

				local var_163_15 = manager.ui.mainCamera.transform.position - var_163_9.position

				var_163_9.forward = Vector3.New(var_163_15.x, var_163_15.y, var_163_15.z)

				local var_163_16 = var_163_9.localEulerAngles

				var_163_16.z = 0
				var_163_16.x = 0
				var_163_9.localEulerAngles = var_163_16
			end

			if arg_160_1.time_ >= var_163_10 + var_163_12 and arg_160_1.time_ < var_163_10 + var_163_12 + arg_163_0 then
				var_163_9.localPosition = Vector3.New(0.7, -1.28, -5.73)

				local var_163_17 = manager.ui.mainCamera.transform.position - var_163_9.position

				var_163_9.forward = Vector3.New(var_163_17.x, var_163_17.y, var_163_17.z)

				local var_163_18 = var_163_9.localEulerAngles

				var_163_18.z = 0
				var_163_18.x = 0
				var_163_9.localEulerAngles = var_163_18

				local var_163_19 = GameObjectTools.GetOrAddComponent(var_163_9.gameObject, typeof(DynamicBoneHelper))

				if var_163_19 then
					var_163_19:EnableDynamicBone(true)
				end
			end

			local var_163_20 = arg_160_1.actors_["10167ui_story"]
			local var_163_21 = 0

			if var_163_21 < arg_160_1.time_ and arg_160_1.time_ <= var_163_21 + arg_163_0 and not isNil(var_163_20) and arg_160_1.var_.characterEffect10167ui_story == nil then
				arg_160_1.var_.characterEffect10167ui_story = var_163_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_22 = 0.200000002980232

			if var_163_21 <= arg_160_1.time_ and arg_160_1.time_ < var_163_21 + var_163_22 and not isNil(var_163_20) then
				local var_163_23 = (arg_160_1.time_ - var_163_21) / var_163_22

				if arg_160_1.var_.characterEffect10167ui_story and not isNil(var_163_20) then
					arg_160_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_21 + var_163_22 and arg_160_1.time_ < var_163_21 + var_163_22 + arg_163_0 and not isNil(var_163_20) and arg_160_1.var_.characterEffect10167ui_story then
				arg_160_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_163_24 = arg_160_1.actors_["1071ui_story"]
			local var_163_25 = 0

			if var_163_25 < arg_160_1.time_ and arg_160_1.time_ <= var_163_25 + arg_163_0 and not isNil(var_163_24) and arg_160_1.var_.characterEffect1071ui_story == nil then
				arg_160_1.var_.characterEffect1071ui_story = var_163_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_26 = 0.200000002980232

			if var_163_25 <= arg_160_1.time_ and arg_160_1.time_ < var_163_25 + var_163_26 and not isNil(var_163_24) then
				local var_163_27 = (arg_160_1.time_ - var_163_25) / var_163_26

				if arg_160_1.var_.characterEffect1071ui_story and not isNil(var_163_24) then
					local var_163_28 = Mathf.Lerp(0, 0.5, var_163_27)

					arg_160_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1071ui_story.fillRatio = var_163_28
				end
			end

			if arg_160_1.time_ >= var_163_25 + var_163_26 and arg_160_1.time_ < var_163_25 + var_163_26 + arg_163_0 and not isNil(var_163_24) and arg_160_1.var_.characterEffect1071ui_story then
				local var_163_29 = 0.5

				arg_160_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1071ui_story.fillRatio = var_163_29
			end

			local var_163_30 = 0
			local var_163_31 = 0.975

			if var_163_30 < arg_160_1.time_ and arg_160_1.time_ <= var_163_30 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_32 = arg_160_1:FormatText(StoryNameCfg[1447].name)

				arg_160_1.leftNameTxt_.text = var_163_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_33 = arg_160_1:GetWordFromCfg(325611039)
				local var_163_34 = arg_160_1:FormatText(var_163_33.content)

				arg_160_1.text_.text = var_163_34

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_35 = 39
				local var_163_36 = utf8.len(var_163_34)
				local var_163_37 = var_163_35 <= 0 and var_163_31 or var_163_31 * (var_163_36 / var_163_35)

				if var_163_37 > 0 and var_163_31 < var_163_37 then
					arg_160_1.talkMaxDuration = var_163_37

					if var_163_37 + var_163_30 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_37 + var_163_30
					end
				end

				arg_160_1.text_.text = var_163_34
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611039", "story_v_out_325611.awb") ~= 0 then
					local var_163_38 = manager.audio:GetVoiceLength("story_v_out_325611", "325611039", "story_v_out_325611.awb") / 1000

					if var_163_38 + var_163_30 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_38 + var_163_30
					end

					if var_163_33.prefab_name ~= "" and arg_160_1.actors_[var_163_33.prefab_name] ~= nil then
						local var_163_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_33.prefab_name].transform, "story_v_out_325611", "325611039", "story_v_out_325611.awb")

						arg_160_1:RecordAudio("325611039", var_163_39)
						arg_160_1:RecordAudio("325611039", var_163_39)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_325611", "325611039", "story_v_out_325611.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_325611", "325611039", "story_v_out_325611.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_40 = math.max(var_163_31, arg_160_1.talkMaxDuration)

			if var_163_30 <= arg_160_1.time_ and arg_160_1.time_ < var_163_30 + var_163_40 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_30) / var_163_40

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_30 + var_163_40 and arg_160_1.time_ < var_163_30 + var_163_40 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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

		arg_160_1:InitPlayNodeList()
	end,
	Play325611040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 325611040
		arg_164_1.duration_ = 6.37

		local var_164_0 = {
			zh = 6.366,
			ja = 5.966
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play325611041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action16_2")
			end

			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_167_2 = 0
			local var_167_3 = 0.625

			if var_167_2 < arg_164_1.time_ and arg_164_1.time_ <= var_167_2 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_4 = arg_164_1:FormatText(StoryNameCfg[1447].name)

				arg_164_1.leftNameTxt_.text = var_167_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_5 = arg_164_1:GetWordFromCfg(325611040)
				local var_167_6 = arg_164_1:FormatText(var_167_5.content)

				arg_164_1.text_.text = var_167_6

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_7 = 25
				local var_167_8 = utf8.len(var_167_6)
				local var_167_9 = var_167_7 <= 0 and var_167_3 or var_167_3 * (var_167_8 / var_167_7)

				if var_167_9 > 0 and var_167_3 < var_167_9 then
					arg_164_1.talkMaxDuration = var_167_9

					if var_167_9 + var_167_2 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_9 + var_167_2
					end
				end

				arg_164_1.text_.text = var_167_6
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611040", "story_v_out_325611.awb") ~= 0 then
					local var_167_10 = manager.audio:GetVoiceLength("story_v_out_325611", "325611040", "story_v_out_325611.awb") / 1000

					if var_167_10 + var_167_2 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_10 + var_167_2
					end

					if var_167_5.prefab_name ~= "" and arg_164_1.actors_[var_167_5.prefab_name] ~= nil then
						local var_167_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_5.prefab_name].transform, "story_v_out_325611", "325611040", "story_v_out_325611.awb")

						arg_164_1:RecordAudio("325611040", var_167_11)
						arg_164_1:RecordAudio("325611040", var_167_11)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_325611", "325611040", "story_v_out_325611.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_325611", "325611040", "story_v_out_325611.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_12 = math.max(var_167_3, arg_164_1.talkMaxDuration)

			if var_167_2 <= arg_164_1.time_ and arg_164_1.time_ < var_167_2 + var_167_12 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_2) / var_167_12

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_2 + var_167_12 and arg_164_1.time_ < var_167_2 + var_167_12 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play325611041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 325611041
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play325611042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["10167ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10167ui_story == nil then
				arg_168_1.var_.characterEffect10167ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect10167ui_story and not isNil(var_171_0) then
					local var_171_4 = Mathf.Lerp(0, 0.5, var_171_3)

					arg_168_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_168_1.var_.characterEffect10167ui_story.fillRatio = var_171_4
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10167ui_story then
				local var_171_5 = 0.5

				arg_168_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_168_1.var_.characterEffect10167ui_story.fillRatio = var_171_5
			end

			local var_171_6 = arg_168_1.actors_["1071ui_story"].transform
			local var_171_7 = 0

			if var_171_7 < arg_168_1.time_ and arg_168_1.time_ <= var_171_7 + arg_171_0 then
				arg_168_1.var_.moveOldPos1071ui_story = var_171_6.localPosition
			end

			local var_171_8 = 0.001

			if var_171_7 <= arg_168_1.time_ and arg_168_1.time_ < var_171_7 + var_171_8 then
				local var_171_9 = (arg_168_1.time_ - var_171_7) / var_171_8
				local var_171_10 = Vector3.New(0, 100, 0)

				var_171_6.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1071ui_story, var_171_10, var_171_9)

				local var_171_11 = manager.ui.mainCamera.transform.position - var_171_6.position

				var_171_6.forward = Vector3.New(var_171_11.x, var_171_11.y, var_171_11.z)

				local var_171_12 = var_171_6.localEulerAngles

				var_171_12.z = 0
				var_171_12.x = 0
				var_171_6.localEulerAngles = var_171_12
			end

			if arg_168_1.time_ >= var_171_7 + var_171_8 and arg_168_1.time_ < var_171_7 + var_171_8 + arg_171_0 then
				var_171_6.localPosition = Vector3.New(0, 100, 0)

				local var_171_13 = manager.ui.mainCamera.transform.position - var_171_6.position

				var_171_6.forward = Vector3.New(var_171_13.x, var_171_13.y, var_171_13.z)

				local var_171_14 = var_171_6.localEulerAngles

				var_171_14.z = 0
				var_171_14.x = 0
				var_171_6.localEulerAngles = var_171_14
			end

			local var_171_15 = arg_168_1.actors_["10167ui_story"].transform
			local var_171_16 = 0

			if var_171_16 < arg_168_1.time_ and arg_168_1.time_ <= var_171_16 + arg_171_0 then
				arg_168_1.var_.moveOldPos10167ui_story = var_171_15.localPosition

				local var_171_17 = GameObjectTools.GetOrAddComponent(var_171_15.gameObject, typeof(DynamicBoneHelper))

				if var_171_17 then
					var_171_17:EnableDynamicBone(false)
				end
			end

			local var_171_18 = 0.001

			if var_171_16 <= arg_168_1.time_ and arg_168_1.time_ < var_171_16 + var_171_18 then
				local var_171_19 = (arg_168_1.time_ - var_171_16) / var_171_18
				local var_171_20 = Vector3.New(0, 100, 0)

				var_171_15.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10167ui_story, var_171_20, var_171_19)

				local var_171_21 = manager.ui.mainCamera.transform.position - var_171_15.position

				var_171_15.forward = Vector3.New(var_171_21.x, var_171_21.y, var_171_21.z)

				local var_171_22 = var_171_15.localEulerAngles

				var_171_22.z = 0
				var_171_22.x = 0
				var_171_15.localEulerAngles = var_171_22
			end

			if arg_168_1.time_ >= var_171_16 + var_171_18 and arg_168_1.time_ < var_171_16 + var_171_18 + arg_171_0 then
				var_171_15.localPosition = Vector3.New(0, 100, 0)

				local var_171_23 = manager.ui.mainCamera.transform.position - var_171_15.position

				var_171_15.forward = Vector3.New(var_171_23.x, var_171_23.y, var_171_23.z)

				local var_171_24 = var_171_15.localEulerAngles

				var_171_24.z = 0
				var_171_24.x = 0
				var_171_15.localEulerAngles = var_171_24

				local var_171_25 = GameObjectTools.GetOrAddComponent(var_171_15.gameObject, typeof(DynamicBoneHelper))

				if var_171_25 then
					var_171_25:EnableDynamicBone(true)
				end
			end

			local var_171_26 = 0
			local var_171_27 = 1.025

			if var_171_26 < arg_168_1.time_ and arg_168_1.time_ <= var_171_26 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_28 = arg_168_1:GetWordFromCfg(325611041)
				local var_171_29 = arg_168_1:FormatText(var_171_28.content)

				arg_168_1.text_.text = var_171_29

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_30 = 41
				local var_171_31 = utf8.len(var_171_29)
				local var_171_32 = var_171_30 <= 0 and var_171_27 or var_171_27 * (var_171_31 / var_171_30)

				if var_171_32 > 0 and var_171_27 < var_171_32 then
					arg_168_1.talkMaxDuration = var_171_32

					if var_171_32 + var_171_26 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_32 + var_171_26
					end
				end

				arg_168_1.text_.text = var_171_29
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_33 = math.max(var_171_27, arg_168_1.talkMaxDuration)

			if var_171_26 <= arg_168_1.time_ and arg_168_1.time_ < var_171_26 + var_171_33 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_26) / var_171_33

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_26 + var_171_33 and arg_168_1.time_ < var_171_26 + var_171_33 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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

		arg_168_1:InitPlayNodeList()
	end,
	Play325611042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 325611042
		arg_172_1.duration_ = 5.33

		local var_172_0 = {
			zh = 5.333,
			ja = 3.233
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play325611043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10167ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect10167ui_story == nil then
				arg_172_1.var_.characterEffect10167ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect10167ui_story and not isNil(var_175_0) then
					arg_172_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect10167ui_story then
				arg_172_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_175_4 = arg_172_1.actors_["10167ui_story"].transform
			local var_175_5 = 0

			if var_175_5 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 then
				arg_172_1.var_.moveOldPos10167ui_story = var_175_4.localPosition

				local var_175_6 = GameObjectTools.GetOrAddComponent(var_175_4.gameObject, typeof(DynamicBoneHelper))

				if var_175_6 then
					var_175_6:EnableDynamicBone(false)
				end
			end

			local var_175_7 = 0.001

			if var_175_5 <= arg_172_1.time_ and arg_172_1.time_ < var_175_5 + var_175_7 then
				local var_175_8 = (arg_172_1.time_ - var_175_5) / var_175_7
				local var_175_9 = Vector3.New(0, -1.28, -5.73)

				var_175_4.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos10167ui_story, var_175_9, var_175_8)

				local var_175_10 = manager.ui.mainCamera.transform.position - var_175_4.position

				var_175_4.forward = Vector3.New(var_175_10.x, var_175_10.y, var_175_10.z)

				local var_175_11 = var_175_4.localEulerAngles

				var_175_11.z = 0
				var_175_11.x = 0
				var_175_4.localEulerAngles = var_175_11
			end

			if arg_172_1.time_ >= var_175_5 + var_175_7 and arg_172_1.time_ < var_175_5 + var_175_7 + arg_175_0 then
				var_175_4.localPosition = Vector3.New(0, -1.28, -5.73)

				local var_175_12 = manager.ui.mainCamera.transform.position - var_175_4.position

				var_175_4.forward = Vector3.New(var_175_12.x, var_175_12.y, var_175_12.z)

				local var_175_13 = var_175_4.localEulerAngles

				var_175_13.z = 0
				var_175_13.x = 0
				var_175_4.localEulerAngles = var_175_13

				local var_175_14 = GameObjectTools.GetOrAddComponent(var_175_4.gameObject, typeof(DynamicBoneHelper))

				if var_175_14 then
					var_175_14:EnableDynamicBone(true)
				end
			end

			local var_175_15 = 0
			local var_175_16 = 0.575

			if var_175_15 < arg_172_1.time_ and arg_172_1.time_ <= var_175_15 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_17 = arg_172_1:FormatText(StoryNameCfg[1447].name)

				arg_172_1.leftNameTxt_.text = var_175_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_18 = arg_172_1:GetWordFromCfg(325611042)
				local var_175_19 = arg_172_1:FormatText(var_175_18.content)

				arg_172_1.text_.text = var_175_19

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_20 = 23
				local var_175_21 = utf8.len(var_175_19)
				local var_175_22 = var_175_20 <= 0 and var_175_16 or var_175_16 * (var_175_21 / var_175_20)

				if var_175_22 > 0 and var_175_16 < var_175_22 then
					arg_172_1.talkMaxDuration = var_175_22

					if var_175_22 + var_175_15 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_22 + var_175_15
					end
				end

				arg_172_1.text_.text = var_175_19
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611042", "story_v_out_325611.awb") ~= 0 then
					local var_175_23 = manager.audio:GetVoiceLength("story_v_out_325611", "325611042", "story_v_out_325611.awb") / 1000

					if var_175_23 + var_175_15 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_23 + var_175_15
					end

					if var_175_18.prefab_name ~= "" and arg_172_1.actors_[var_175_18.prefab_name] ~= nil then
						local var_175_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_18.prefab_name].transform, "story_v_out_325611", "325611042", "story_v_out_325611.awb")

						arg_172_1:RecordAudio("325611042", var_175_24)
						arg_172_1:RecordAudio("325611042", var_175_24)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_325611", "325611042", "story_v_out_325611.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_325611", "325611042", "story_v_out_325611.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_25 = math.max(var_175_16, arg_172_1.talkMaxDuration)

			if var_175_15 <= arg_172_1.time_ and arg_172_1.time_ < var_175_15 + var_175_25 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_15) / var_175_25

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_15 + var_175_25 and arg_172_1.time_ < var_175_15 + var_175_25 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
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

		arg_172_1:InitPlayNodeList()
	end,
	Play325611043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 325611043
		arg_176_1.duration_ = 9.73

		local var_176_0 = {
			zh = 6.5,
			ja = 9.733
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play325611044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["10167ui_story"].transform
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.var_.moveOldPos10167ui_story = var_179_0.localPosition

				local var_179_2 = GameObjectTools.GetOrAddComponent(var_179_0.gameObject, typeof(DynamicBoneHelper))

				if var_179_2 then
					var_179_2:EnableDynamicBone(false)
				end
			end

			local var_179_3 = 0.001

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_3 then
				local var_179_4 = (arg_176_1.time_ - var_179_1) / var_179_3
				local var_179_5 = Vector3.New(0, 100, 0)

				var_179_0.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10167ui_story, var_179_5, var_179_4)

				local var_179_6 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_6.x, var_179_6.y, var_179_6.z)

				local var_179_7 = var_179_0.localEulerAngles

				var_179_7.z = 0
				var_179_7.x = 0
				var_179_0.localEulerAngles = var_179_7
			end

			if arg_176_1.time_ >= var_179_1 + var_179_3 and arg_176_1.time_ < var_179_1 + var_179_3 + arg_179_0 then
				var_179_0.localPosition = Vector3.New(0, 100, 0)

				local var_179_8 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_8.x, var_179_8.y, var_179_8.z)

				local var_179_9 = var_179_0.localEulerAngles

				var_179_9.z = 0
				var_179_9.x = 0
				var_179_0.localEulerAngles = var_179_9

				local var_179_10 = GameObjectTools.GetOrAddComponent(var_179_0.gameObject, typeof(DynamicBoneHelper))

				if var_179_10 then
					var_179_10:EnableDynamicBone(true)
				end
			end

			local var_179_11 = arg_176_1.actors_["10175ui_story"].transform
			local var_179_12 = 0

			if var_179_12 < arg_176_1.time_ and arg_176_1.time_ <= var_179_12 + arg_179_0 then
				arg_176_1.var_.moveOldPos10175ui_story = var_179_11.localPosition

				local var_179_13 = GameObjectTools.GetOrAddComponent(var_179_11.gameObject, typeof(DynamicBoneHelper))

				if var_179_13 then
					var_179_13:EnableDynamicBone(false)
				end
			end

			local var_179_14 = 0.001

			if var_179_12 <= arg_176_1.time_ and arg_176_1.time_ < var_179_12 + var_179_14 then
				local var_179_15 = (arg_176_1.time_ - var_179_12) / var_179_14
				local var_179_16 = Vector3.New(0, -1, -6.05)

				var_179_11.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10175ui_story, var_179_16, var_179_15)

				local var_179_17 = manager.ui.mainCamera.transform.position - var_179_11.position

				var_179_11.forward = Vector3.New(var_179_17.x, var_179_17.y, var_179_17.z)

				local var_179_18 = var_179_11.localEulerAngles

				var_179_18.z = 0
				var_179_18.x = 0
				var_179_11.localEulerAngles = var_179_18
			end

			if arg_176_1.time_ >= var_179_12 + var_179_14 and arg_176_1.time_ < var_179_12 + var_179_14 + arg_179_0 then
				var_179_11.localPosition = Vector3.New(0, -1, -6.05)

				local var_179_19 = manager.ui.mainCamera.transform.position - var_179_11.position

				var_179_11.forward = Vector3.New(var_179_19.x, var_179_19.y, var_179_19.z)

				local var_179_20 = var_179_11.localEulerAngles

				var_179_20.z = 0
				var_179_20.x = 0
				var_179_11.localEulerAngles = var_179_20

				local var_179_21 = GameObjectTools.GetOrAddComponent(var_179_11.gameObject, typeof(DynamicBoneHelper))

				if var_179_21 then
					var_179_21:EnableDynamicBone(true)
				end
			end

			local var_179_22 = arg_176_1.actors_["1071ui_story"].transform
			local var_179_23 = 0

			if var_179_23 < arg_176_1.time_ and arg_176_1.time_ <= var_179_23 + arg_179_0 then
				arg_176_1.var_.moveOldPos1071ui_story = var_179_22.localPosition
			end

			local var_179_24 = 0.001

			if var_179_23 <= arg_176_1.time_ and arg_176_1.time_ < var_179_23 + var_179_24 then
				local var_179_25 = (arg_176_1.time_ - var_179_23) / var_179_24
				local var_179_26 = Vector3.New(0, 100, 0)

				var_179_22.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1071ui_story, var_179_26, var_179_25)

				local var_179_27 = manager.ui.mainCamera.transform.position - var_179_22.position

				var_179_22.forward = Vector3.New(var_179_27.x, var_179_27.y, var_179_27.z)

				local var_179_28 = var_179_22.localEulerAngles

				var_179_28.z = 0
				var_179_28.x = 0
				var_179_22.localEulerAngles = var_179_28
			end

			if arg_176_1.time_ >= var_179_23 + var_179_24 and arg_176_1.time_ < var_179_23 + var_179_24 + arg_179_0 then
				var_179_22.localPosition = Vector3.New(0, 100, 0)

				local var_179_29 = manager.ui.mainCamera.transform.position - var_179_22.position

				var_179_22.forward = Vector3.New(var_179_29.x, var_179_29.y, var_179_29.z)

				local var_179_30 = var_179_22.localEulerAngles

				var_179_30.z = 0
				var_179_30.x = 0
				var_179_22.localEulerAngles = var_179_30
			end

			local var_179_31 = arg_176_1.actors_["10175ui_story"]
			local var_179_32 = 0

			if var_179_32 < arg_176_1.time_ and arg_176_1.time_ <= var_179_32 + arg_179_0 and not isNil(var_179_31) and arg_176_1.var_.characterEffect10175ui_story == nil then
				arg_176_1.var_.characterEffect10175ui_story = var_179_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_33 = 0.200000002980232

			if var_179_32 <= arg_176_1.time_ and arg_176_1.time_ < var_179_32 + var_179_33 and not isNil(var_179_31) then
				local var_179_34 = (arg_176_1.time_ - var_179_32) / var_179_33

				if arg_176_1.var_.characterEffect10175ui_story and not isNil(var_179_31) then
					arg_176_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_32 + var_179_33 and arg_176_1.time_ < var_179_32 + var_179_33 + arg_179_0 and not isNil(var_179_31) and arg_176_1.var_.characterEffect10175ui_story then
				arg_176_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_179_35 = arg_176_1.actors_["10167ui_story"]
			local var_179_36 = 0

			if var_179_36 < arg_176_1.time_ and arg_176_1.time_ <= var_179_36 + arg_179_0 and not isNil(var_179_35) and arg_176_1.var_.characterEffect10167ui_story == nil then
				arg_176_1.var_.characterEffect10167ui_story = var_179_35:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_37 = 0.200000002980232

			if var_179_36 <= arg_176_1.time_ and arg_176_1.time_ < var_179_36 + var_179_37 and not isNil(var_179_35) then
				local var_179_38 = (arg_176_1.time_ - var_179_36) / var_179_37

				if arg_176_1.var_.characterEffect10167ui_story and not isNil(var_179_35) then
					local var_179_39 = Mathf.Lerp(0, 0.5, var_179_38)

					arg_176_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_176_1.var_.characterEffect10167ui_story.fillRatio = var_179_39
				end
			end

			if arg_176_1.time_ >= var_179_36 + var_179_37 and arg_176_1.time_ < var_179_36 + var_179_37 + arg_179_0 and not isNil(var_179_35) and arg_176_1.var_.characterEffect10167ui_story then
				local var_179_40 = 0.5

				arg_176_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_176_1.var_.characterEffect10167ui_story.fillRatio = var_179_40
			end

			local var_179_41 = 0

			if var_179_41 < arg_176_1.time_ and arg_176_1.time_ <= var_179_41 + arg_179_0 then
				arg_176_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			local var_179_42 = 0

			if var_179_42 < arg_176_1.time_ and arg_176_1.time_ <= var_179_42 + arg_179_0 then
				arg_176_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_179_43 = 0
			local var_179_44 = 0.875

			if var_179_43 < arg_176_1.time_ and arg_176_1.time_ <= var_179_43 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_45 = arg_176_1:FormatText(StoryNameCfg[1473].name)

				arg_176_1.leftNameTxt_.text = var_179_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_46 = arg_176_1:GetWordFromCfg(325611043)
				local var_179_47 = arg_176_1:FormatText(var_179_46.content)

				arg_176_1.text_.text = var_179_47

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_48 = 35
				local var_179_49 = utf8.len(var_179_47)
				local var_179_50 = var_179_48 <= 0 and var_179_44 or var_179_44 * (var_179_49 / var_179_48)

				if var_179_50 > 0 and var_179_44 < var_179_50 then
					arg_176_1.talkMaxDuration = var_179_50

					if var_179_50 + var_179_43 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_50 + var_179_43
					end
				end

				arg_176_1.text_.text = var_179_47
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611043", "story_v_out_325611.awb") ~= 0 then
					local var_179_51 = manager.audio:GetVoiceLength("story_v_out_325611", "325611043", "story_v_out_325611.awb") / 1000

					if var_179_51 + var_179_43 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_51 + var_179_43
					end

					if var_179_46.prefab_name ~= "" and arg_176_1.actors_[var_179_46.prefab_name] ~= nil then
						local var_179_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_46.prefab_name].transform, "story_v_out_325611", "325611043", "story_v_out_325611.awb")

						arg_176_1:RecordAudio("325611043", var_179_52)
						arg_176_1:RecordAudio("325611043", var_179_52)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_325611", "325611043", "story_v_out_325611.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_325611", "325611043", "story_v_out_325611.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_53 = math.max(var_179_44, arg_176_1.talkMaxDuration)

			if var_179_43 <= arg_176_1.time_ and arg_176_1.time_ < var_179_43 + var_179_53 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_43) / var_179_53

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_43 + var_179_53 and arg_176_1.time_ < var_179_43 + var_179_53 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play325611044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 325611044
		arg_180_1.duration_ = 6.6

		local var_180_0 = {
			zh = 6.6,
			ja = 5.833
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
				arg_180_0:Play325611045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10175ui_story"].transform
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.var_.moveOldPos10175ui_story = var_183_0.localPosition

				local var_183_2 = GameObjectTools.GetOrAddComponent(var_183_0.gameObject, typeof(DynamicBoneHelper))

				if var_183_2 then
					var_183_2:EnableDynamicBone(false)
				end
			end

			local var_183_3 = 0.001

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_3 then
				local var_183_4 = (arg_180_1.time_ - var_183_1) / var_183_3
				local var_183_5 = Vector3.New(-0.7, -1, -6.05)

				var_183_0.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10175ui_story, var_183_5, var_183_4)

				local var_183_6 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_6.x, var_183_6.y, var_183_6.z)

				local var_183_7 = var_183_0.localEulerAngles

				var_183_7.z = 0
				var_183_7.x = 0
				var_183_0.localEulerAngles = var_183_7
			end

			if arg_180_1.time_ >= var_183_1 + var_183_3 and arg_180_1.time_ < var_183_1 + var_183_3 + arg_183_0 then
				var_183_0.localPosition = Vector3.New(-0.7, -1, -6.05)

				local var_183_8 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_8.x, var_183_8.y, var_183_8.z)

				local var_183_9 = var_183_0.localEulerAngles

				var_183_9.z = 0
				var_183_9.x = 0
				var_183_0.localEulerAngles = var_183_9

				local var_183_10 = GameObjectTools.GetOrAddComponent(var_183_0.gameObject, typeof(DynamicBoneHelper))

				if var_183_10 then
					var_183_10:EnableDynamicBone(true)
				end
			end

			local var_183_11 = arg_180_1.actors_["6148ui_story"].transform
			local var_183_12 = 0

			if var_183_12 < arg_180_1.time_ and arg_180_1.time_ <= var_183_12 + arg_183_0 then
				arg_180_1.var_.moveOldPos6148ui_story = var_183_11.localPosition

				local var_183_13 = GameObjectTools.GetOrAddComponent(var_183_11.gameObject, typeof(DynamicBoneHelper))

				if var_183_13 then
					var_183_13:EnableDynamicBone(false)
				end
			end

			local var_183_14 = 0.001

			if var_183_12 <= arg_180_1.time_ and arg_180_1.time_ < var_183_12 + var_183_14 then
				local var_183_15 = (arg_180_1.time_ - var_183_12) / var_183_14
				local var_183_16 = Vector3.New(0.7, -0.985, -6)

				var_183_11.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos6148ui_story, var_183_16, var_183_15)

				local var_183_17 = manager.ui.mainCamera.transform.position - var_183_11.position

				var_183_11.forward = Vector3.New(var_183_17.x, var_183_17.y, var_183_17.z)

				local var_183_18 = var_183_11.localEulerAngles

				var_183_18.z = 0
				var_183_18.x = 0
				var_183_11.localEulerAngles = var_183_18
			end

			if arg_180_1.time_ >= var_183_12 + var_183_14 and arg_180_1.time_ < var_183_12 + var_183_14 + arg_183_0 then
				var_183_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_183_19 = manager.ui.mainCamera.transform.position - var_183_11.position

				var_183_11.forward = Vector3.New(var_183_19.x, var_183_19.y, var_183_19.z)

				local var_183_20 = var_183_11.localEulerAngles

				var_183_20.z = 0
				var_183_20.x = 0
				var_183_11.localEulerAngles = var_183_20

				local var_183_21 = GameObjectTools.GetOrAddComponent(var_183_11.gameObject, typeof(DynamicBoneHelper))

				if var_183_21 then
					var_183_21:EnableDynamicBone(true)
				end
			end

			local var_183_22 = arg_180_1.actors_["6148ui_story"]
			local var_183_23 = 0

			if var_183_23 < arg_180_1.time_ and arg_180_1.time_ <= var_183_23 + arg_183_0 and not isNil(var_183_22) and arg_180_1.var_.characterEffect6148ui_story == nil then
				arg_180_1.var_.characterEffect6148ui_story = var_183_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_24 = 0.200000002980232

			if var_183_23 <= arg_180_1.time_ and arg_180_1.time_ < var_183_23 + var_183_24 and not isNil(var_183_22) then
				local var_183_25 = (arg_180_1.time_ - var_183_23) / var_183_24

				if arg_180_1.var_.characterEffect6148ui_story and not isNil(var_183_22) then
					arg_180_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_23 + var_183_24 and arg_180_1.time_ < var_183_23 + var_183_24 + arg_183_0 and not isNil(var_183_22) and arg_180_1.var_.characterEffect6148ui_story then
				arg_180_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_183_26 = arg_180_1.actors_["10175ui_story"]
			local var_183_27 = 0

			if var_183_27 < arg_180_1.time_ and arg_180_1.time_ <= var_183_27 + arg_183_0 and not isNil(var_183_26) and arg_180_1.var_.characterEffect10175ui_story == nil then
				arg_180_1.var_.characterEffect10175ui_story = var_183_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_28 = 0.200000002980232

			if var_183_27 <= arg_180_1.time_ and arg_180_1.time_ < var_183_27 + var_183_28 and not isNil(var_183_26) then
				local var_183_29 = (arg_180_1.time_ - var_183_27) / var_183_28

				if arg_180_1.var_.characterEffect10175ui_story and not isNil(var_183_26) then
					local var_183_30 = Mathf.Lerp(0, 0.5, var_183_29)

					arg_180_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_180_1.var_.characterEffect10175ui_story.fillRatio = var_183_30
				end
			end

			if arg_180_1.time_ >= var_183_27 + var_183_28 and arg_180_1.time_ < var_183_27 + var_183_28 + arg_183_0 and not isNil(var_183_26) and arg_180_1.var_.characterEffect10175ui_story then
				local var_183_31 = 0.5

				arg_180_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_180_1.var_.characterEffect10175ui_story.fillRatio = var_183_31
			end

			local var_183_32 = 0

			if var_183_32 < arg_180_1.time_ and arg_180_1.time_ <= var_183_32 + arg_183_0 then
				arg_180_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_183_33 = 0

			if var_183_33 < arg_180_1.time_ and arg_180_1.time_ <= var_183_33 + arg_183_0 then
				arg_180_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_183_34 = 0
			local var_183_35 = 0.625

			if var_183_34 < arg_180_1.time_ and arg_180_1.time_ <= var_183_34 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_36 = arg_180_1:FormatText(StoryNameCfg[1488].name)

				arg_180_1.leftNameTxt_.text = var_183_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_37 = arg_180_1:GetWordFromCfg(325611044)
				local var_183_38 = arg_180_1:FormatText(var_183_37.content)

				arg_180_1.text_.text = var_183_38

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_39 = 25
				local var_183_40 = utf8.len(var_183_38)
				local var_183_41 = var_183_39 <= 0 and var_183_35 or var_183_35 * (var_183_40 / var_183_39)

				if var_183_41 > 0 and var_183_35 < var_183_41 then
					arg_180_1.talkMaxDuration = var_183_41

					if var_183_41 + var_183_34 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_41 + var_183_34
					end
				end

				arg_180_1.text_.text = var_183_38
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611044", "story_v_out_325611.awb") ~= 0 then
					local var_183_42 = manager.audio:GetVoiceLength("story_v_out_325611", "325611044", "story_v_out_325611.awb") / 1000

					if var_183_42 + var_183_34 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_42 + var_183_34
					end

					if var_183_37.prefab_name ~= "" and arg_180_1.actors_[var_183_37.prefab_name] ~= nil then
						local var_183_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_37.prefab_name].transform, "story_v_out_325611", "325611044", "story_v_out_325611.awb")

						arg_180_1:RecordAudio("325611044", var_183_43)
						arg_180_1:RecordAudio("325611044", var_183_43)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_325611", "325611044", "story_v_out_325611.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_325611", "325611044", "story_v_out_325611.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_44 = math.max(var_183_35, arg_180_1.talkMaxDuration)

			if var_183_34 <= arg_180_1.time_ and arg_180_1.time_ < var_183_34 + var_183_44 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_34) / var_183_44

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_34 + var_183_44 and arg_180_1.time_ < var_183_34 + var_183_44 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
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
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play325611045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 325611045
		arg_184_1.duration_ = 3.1

		local var_184_0 = {
			zh = 2.733,
			ja = 3.1
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play325611046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10175ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10175ui_story == nil then
				arg_184_1.var_.characterEffect10175ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect10175ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10175ui_story then
				arg_184_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_187_4 = arg_184_1.actors_["6148ui_story"]
			local var_187_5 = 0

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 and not isNil(var_187_4) and arg_184_1.var_.characterEffect6148ui_story == nil then
				arg_184_1.var_.characterEffect6148ui_story = var_187_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_6 = 0.200000002980232

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_6 and not isNil(var_187_4) then
				local var_187_7 = (arg_184_1.time_ - var_187_5) / var_187_6

				if arg_184_1.var_.characterEffect6148ui_story and not isNil(var_187_4) then
					local var_187_8 = Mathf.Lerp(0, 0.5, var_187_7)

					arg_184_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_184_1.var_.characterEffect6148ui_story.fillRatio = var_187_8
				end
			end

			if arg_184_1.time_ >= var_187_5 + var_187_6 and arg_184_1.time_ < var_187_5 + var_187_6 + arg_187_0 and not isNil(var_187_4) and arg_184_1.var_.characterEffect6148ui_story then
				local var_187_9 = 0.5

				arg_184_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_184_1.var_.characterEffect6148ui_story.fillRatio = var_187_9
			end

			local var_187_10 = 0

			if var_187_10 < arg_184_1.time_ and arg_184_1.time_ <= var_187_10 + arg_187_0 then
				arg_184_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			local var_187_11 = 0

			if var_187_11 < arg_184_1.time_ and arg_184_1.time_ <= var_187_11 + arg_187_0 then
				arg_184_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_187_12 = 0
			local var_187_13 = 0.3

			if var_187_12 < arg_184_1.time_ and arg_184_1.time_ <= var_187_12 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_14 = arg_184_1:FormatText(StoryNameCfg[1473].name)

				arg_184_1.leftNameTxt_.text = var_187_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_15 = arg_184_1:GetWordFromCfg(325611045)
				local var_187_16 = arg_184_1:FormatText(var_187_15.content)

				arg_184_1.text_.text = var_187_16

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_17 = 12
				local var_187_18 = utf8.len(var_187_16)
				local var_187_19 = var_187_17 <= 0 and var_187_13 or var_187_13 * (var_187_18 / var_187_17)

				if var_187_19 > 0 and var_187_13 < var_187_19 then
					arg_184_1.talkMaxDuration = var_187_19

					if var_187_19 + var_187_12 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_19 + var_187_12
					end
				end

				arg_184_1.text_.text = var_187_16
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611045", "story_v_out_325611.awb") ~= 0 then
					local var_187_20 = manager.audio:GetVoiceLength("story_v_out_325611", "325611045", "story_v_out_325611.awb") / 1000

					if var_187_20 + var_187_12 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_20 + var_187_12
					end

					if var_187_15.prefab_name ~= "" and arg_184_1.actors_[var_187_15.prefab_name] ~= nil then
						local var_187_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_15.prefab_name].transform, "story_v_out_325611", "325611045", "story_v_out_325611.awb")

						arg_184_1:RecordAudio("325611045", var_187_21)
						arg_184_1:RecordAudio("325611045", var_187_21)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_325611", "325611045", "story_v_out_325611.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_325611", "325611045", "story_v_out_325611.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_22 = math.max(var_187_13, arg_184_1.talkMaxDuration)

			if var_187_12 <= arg_184_1.time_ and arg_184_1.time_ < var_187_12 + var_187_22 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_12) / var_187_22

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_12 + var_187_22 and arg_184_1.time_ < var_187_12 + var_187_22 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play325611046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 325611046
		arg_188_1.duration_ = 5.63

		local var_188_0 = {
			zh = 5.633,
			ja = 5.533
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play325611047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["6148ui_story"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos6148ui_story = var_191_0.localPosition

				local var_191_2 = GameObjectTools.GetOrAddComponent(var_191_0.gameObject, typeof(DynamicBoneHelper))

				if var_191_2 then
					var_191_2:EnableDynamicBone(false)
				end
			end

			local var_191_3 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_3 then
				local var_191_4 = (arg_188_1.time_ - var_191_1) / var_191_3
				local var_191_5 = Vector3.New(0, 100, 0)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos6148ui_story, var_191_5, var_191_4)

				local var_191_6 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_6.x, var_191_6.y, var_191_6.z)

				local var_191_7 = var_191_0.localEulerAngles

				var_191_7.z = 0
				var_191_7.x = 0
				var_191_0.localEulerAngles = var_191_7
			end

			if arg_188_1.time_ >= var_191_1 + var_191_3 and arg_188_1.time_ < var_191_1 + var_191_3 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(0, 100, 0)

				local var_191_8 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_8.x, var_191_8.y, var_191_8.z)

				local var_191_9 = var_191_0.localEulerAngles

				var_191_9.z = 0
				var_191_9.x = 0
				var_191_0.localEulerAngles = var_191_9

				local var_191_10 = GameObjectTools.GetOrAddComponent(var_191_0.gameObject, typeof(DynamicBoneHelper))

				if var_191_10 then
					var_191_10:EnableDynamicBone(true)
				end
			end

			local var_191_11 = arg_188_1.actors_["1054ui_story"].transform
			local var_191_12 = 0

			if var_191_12 < arg_188_1.time_ and arg_188_1.time_ <= var_191_12 + arg_191_0 then
				arg_188_1.var_.moveOldPos1054ui_story = var_191_11.localPosition

				local var_191_13 = GameObjectTools.GetOrAddComponent(var_191_11.gameObject, typeof(DynamicBoneHelper))

				if var_191_13 then
					var_191_13:EnableDynamicBone(false)
				end
			end

			local var_191_14 = 0.001

			if var_191_12 <= arg_188_1.time_ and arg_188_1.time_ < var_191_12 + var_191_14 then
				local var_191_15 = (arg_188_1.time_ - var_191_12) / var_191_14
				local var_191_16 = Vector3.New(0.7, -0.985, -6)

				var_191_11.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1054ui_story, var_191_16, var_191_15)

				local var_191_17 = manager.ui.mainCamera.transform.position - var_191_11.position

				var_191_11.forward = Vector3.New(var_191_17.x, var_191_17.y, var_191_17.z)

				local var_191_18 = var_191_11.localEulerAngles

				var_191_18.z = 0
				var_191_18.x = 0
				var_191_11.localEulerAngles = var_191_18
			end

			if arg_188_1.time_ >= var_191_12 + var_191_14 and arg_188_1.time_ < var_191_12 + var_191_14 + arg_191_0 then
				var_191_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_191_19 = manager.ui.mainCamera.transform.position - var_191_11.position

				var_191_11.forward = Vector3.New(var_191_19.x, var_191_19.y, var_191_19.z)

				local var_191_20 = var_191_11.localEulerAngles

				var_191_20.z = 0
				var_191_20.x = 0
				var_191_11.localEulerAngles = var_191_20

				local var_191_21 = GameObjectTools.GetOrAddComponent(var_191_11.gameObject, typeof(DynamicBoneHelper))

				if var_191_21 then
					var_191_21:EnableDynamicBone(true)
				end
			end

			local var_191_22 = arg_188_1.actors_["1054ui_story"]
			local var_191_23 = 0

			if var_191_23 < arg_188_1.time_ and arg_188_1.time_ <= var_191_23 + arg_191_0 and not isNil(var_191_22) and arg_188_1.var_.characterEffect1054ui_story == nil then
				arg_188_1.var_.characterEffect1054ui_story = var_191_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_24 = 0.200000002980232

			if var_191_23 <= arg_188_1.time_ and arg_188_1.time_ < var_191_23 + var_191_24 and not isNil(var_191_22) then
				local var_191_25 = (arg_188_1.time_ - var_191_23) / var_191_24

				if arg_188_1.var_.characterEffect1054ui_story and not isNil(var_191_22) then
					arg_188_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_23 + var_191_24 and arg_188_1.time_ < var_191_23 + var_191_24 + arg_191_0 and not isNil(var_191_22) and arg_188_1.var_.characterEffect1054ui_story then
				arg_188_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_191_26 = arg_188_1.actors_["10175ui_story"]
			local var_191_27 = 0

			if var_191_27 < arg_188_1.time_ and arg_188_1.time_ <= var_191_27 + arg_191_0 and not isNil(var_191_26) and arg_188_1.var_.characterEffect10175ui_story == nil then
				arg_188_1.var_.characterEffect10175ui_story = var_191_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_28 = 0.200000002980232

			if var_191_27 <= arg_188_1.time_ and arg_188_1.time_ < var_191_27 + var_191_28 and not isNil(var_191_26) then
				local var_191_29 = (arg_188_1.time_ - var_191_27) / var_191_28

				if arg_188_1.var_.characterEffect10175ui_story and not isNil(var_191_26) then
					local var_191_30 = Mathf.Lerp(0, 0.5, var_191_29)

					arg_188_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_188_1.var_.characterEffect10175ui_story.fillRatio = var_191_30
				end
			end

			if arg_188_1.time_ >= var_191_27 + var_191_28 and arg_188_1.time_ < var_191_27 + var_191_28 + arg_191_0 and not isNil(var_191_26) and arg_188_1.var_.characterEffect10175ui_story then
				local var_191_31 = 0.5

				arg_188_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_188_1.var_.characterEffect10175ui_story.fillRatio = var_191_31
			end

			local var_191_32 = 0

			if var_191_32 < arg_188_1.time_ and arg_188_1.time_ <= var_191_32 + arg_191_0 then
				arg_188_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_191_33 = 0

			if var_191_33 < arg_188_1.time_ and arg_188_1.time_ <= var_191_33 + arg_191_0 then
				arg_188_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_191_34 = 0
			local var_191_35 = 0.425

			if var_191_34 < arg_188_1.time_ and arg_188_1.time_ <= var_191_34 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_36 = arg_188_1:FormatText(StoryNameCfg[1487].name)

				arg_188_1.leftNameTxt_.text = var_191_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_37 = arg_188_1:GetWordFromCfg(325611046)
				local var_191_38 = arg_188_1:FormatText(var_191_37.content)

				arg_188_1.text_.text = var_191_38

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_39 = 17
				local var_191_40 = utf8.len(var_191_38)
				local var_191_41 = var_191_39 <= 0 and var_191_35 or var_191_35 * (var_191_40 / var_191_39)

				if var_191_41 > 0 and var_191_35 < var_191_41 then
					arg_188_1.talkMaxDuration = var_191_41

					if var_191_41 + var_191_34 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_41 + var_191_34
					end
				end

				arg_188_1.text_.text = var_191_38
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611046", "story_v_out_325611.awb") ~= 0 then
					local var_191_42 = manager.audio:GetVoiceLength("story_v_out_325611", "325611046", "story_v_out_325611.awb") / 1000

					if var_191_42 + var_191_34 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_42 + var_191_34
					end

					if var_191_37.prefab_name ~= "" and arg_188_1.actors_[var_191_37.prefab_name] ~= nil then
						local var_191_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_37.prefab_name].transform, "story_v_out_325611", "325611046", "story_v_out_325611.awb")

						arg_188_1:RecordAudio("325611046", var_191_43)
						arg_188_1:RecordAudio("325611046", var_191_43)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_325611", "325611046", "story_v_out_325611.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_325611", "325611046", "story_v_out_325611.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_44 = math.max(var_191_35, arg_188_1.talkMaxDuration)

			if var_191_34 <= arg_188_1.time_ and arg_188_1.time_ < var_191_34 + var_191_44 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_34) / var_191_44

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_34 + var_191_44 and arg_188_1.time_ < var_191_34 + var_191_44 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play325611047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 325611047
		arg_192_1.duration_ = 5.53

		local var_192_0 = {
			zh = 4.4,
			ja = 5.533
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play325611048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["10175ui_story"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect10175ui_story == nil then
				arg_192_1.var_.characterEffect10175ui_story = var_195_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.200000002980232

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.characterEffect10175ui_story and not isNil(var_195_0) then
					arg_192_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect10175ui_story then
				arg_192_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_195_4 = arg_192_1.actors_["1054ui_story"]
			local var_195_5 = 0

			if var_195_5 < arg_192_1.time_ and arg_192_1.time_ <= var_195_5 + arg_195_0 and not isNil(var_195_4) and arg_192_1.var_.characterEffect1054ui_story == nil then
				arg_192_1.var_.characterEffect1054ui_story = var_195_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_6 = 0.200000002980232

			if var_195_5 <= arg_192_1.time_ and arg_192_1.time_ < var_195_5 + var_195_6 and not isNil(var_195_4) then
				local var_195_7 = (arg_192_1.time_ - var_195_5) / var_195_6

				if arg_192_1.var_.characterEffect1054ui_story and not isNil(var_195_4) then
					local var_195_8 = Mathf.Lerp(0, 0.5, var_195_7)

					arg_192_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1054ui_story.fillRatio = var_195_8
				end
			end

			if arg_192_1.time_ >= var_195_5 + var_195_6 and arg_192_1.time_ < var_195_5 + var_195_6 + arg_195_0 and not isNil(var_195_4) and arg_192_1.var_.characterEffect1054ui_story then
				local var_195_9 = 0.5

				arg_192_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1054ui_story.fillRatio = var_195_9
			end

			local var_195_10 = 0
			local var_195_11 = 0.325

			if var_195_10 < arg_192_1.time_ and arg_192_1.time_ <= var_195_10 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_12 = arg_192_1:FormatText(StoryNameCfg[1473].name)

				arg_192_1.leftNameTxt_.text = var_195_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_13 = arg_192_1:GetWordFromCfg(325611047)
				local var_195_14 = arg_192_1:FormatText(var_195_13.content)

				arg_192_1.text_.text = var_195_14

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_15 = 13
				local var_195_16 = utf8.len(var_195_14)
				local var_195_17 = var_195_15 <= 0 and var_195_11 or var_195_11 * (var_195_16 / var_195_15)

				if var_195_17 > 0 and var_195_11 < var_195_17 then
					arg_192_1.talkMaxDuration = var_195_17

					if var_195_17 + var_195_10 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_17 + var_195_10
					end
				end

				arg_192_1.text_.text = var_195_14
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611047", "story_v_out_325611.awb") ~= 0 then
					local var_195_18 = manager.audio:GetVoiceLength("story_v_out_325611", "325611047", "story_v_out_325611.awb") / 1000

					if var_195_18 + var_195_10 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_18 + var_195_10
					end

					if var_195_13.prefab_name ~= "" and arg_192_1.actors_[var_195_13.prefab_name] ~= nil then
						local var_195_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_13.prefab_name].transform, "story_v_out_325611", "325611047", "story_v_out_325611.awb")

						arg_192_1:RecordAudio("325611047", var_195_19)
						arg_192_1:RecordAudio("325611047", var_195_19)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_325611", "325611047", "story_v_out_325611.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_325611", "325611047", "story_v_out_325611.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_20 = math.max(var_195_11, arg_192_1.talkMaxDuration)

			if var_195_10 <= arg_192_1.time_ and arg_192_1.time_ < var_195_10 + var_195_20 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_10) / var_195_20

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_10 + var_195_20 and arg_192_1.time_ < var_195_10 + var_195_20 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play325611048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 325611048
		arg_196_1.duration_ = 7.87

		local var_196_0 = {
			zh = 5.7,
			ja = 7.866
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
				arg_196_0:Play325611049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action2_1")
			end

			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_199_2 = 0
			local var_199_3 = 0.725

			if var_199_2 < arg_196_1.time_ and arg_196_1.time_ <= var_199_2 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_4 = arg_196_1:FormatText(StoryNameCfg[1473].name)

				arg_196_1.leftNameTxt_.text = var_199_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_5 = arg_196_1:GetWordFromCfg(325611048)
				local var_199_6 = arg_196_1:FormatText(var_199_5.content)

				arg_196_1.text_.text = var_199_6

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_7 = 29
				local var_199_8 = utf8.len(var_199_6)
				local var_199_9 = var_199_7 <= 0 and var_199_3 or var_199_3 * (var_199_8 / var_199_7)

				if var_199_9 > 0 and var_199_3 < var_199_9 then
					arg_196_1.talkMaxDuration = var_199_9

					if var_199_9 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_9 + var_199_2
					end
				end

				arg_196_1.text_.text = var_199_6
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611048", "story_v_out_325611.awb") ~= 0 then
					local var_199_10 = manager.audio:GetVoiceLength("story_v_out_325611", "325611048", "story_v_out_325611.awb") / 1000

					if var_199_10 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_10 + var_199_2
					end

					if var_199_5.prefab_name ~= "" and arg_196_1.actors_[var_199_5.prefab_name] ~= nil then
						local var_199_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_5.prefab_name].transform, "story_v_out_325611", "325611048", "story_v_out_325611.awb")

						arg_196_1:RecordAudio("325611048", var_199_11)
						arg_196_1:RecordAudio("325611048", var_199_11)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_325611", "325611048", "story_v_out_325611.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_325611", "325611048", "story_v_out_325611.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_12 = math.max(var_199_3, arg_196_1.talkMaxDuration)

			if var_199_2 <= arg_196_1.time_ and arg_196_1.time_ < var_199_2 + var_199_12 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_2) / var_199_12

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_2 + var_199_12 and arg_196_1.time_ < var_199_2 + var_199_12 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play325611049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 325611049
		arg_200_1.duration_ = 4.37

		local var_200_0 = {
			zh = 3.333,
			ja = 4.366
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
				arg_200_0:Play325611050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1054ui_story"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1054ui_story == nil then
				arg_200_1.var_.characterEffect1054ui_story = var_203_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.200000002980232

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.characterEffect1054ui_story and not isNil(var_203_0) then
					arg_200_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1054ui_story then
				arg_200_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_203_4 = arg_200_1.actors_["10175ui_story"]
			local var_203_5 = 0

			if var_203_5 < arg_200_1.time_ and arg_200_1.time_ <= var_203_5 + arg_203_0 and not isNil(var_203_4) and arg_200_1.var_.characterEffect10175ui_story == nil then
				arg_200_1.var_.characterEffect10175ui_story = var_203_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_6 = 0.200000002980232

			if var_203_5 <= arg_200_1.time_ and arg_200_1.time_ < var_203_5 + var_203_6 and not isNil(var_203_4) then
				local var_203_7 = (arg_200_1.time_ - var_203_5) / var_203_6

				if arg_200_1.var_.characterEffect10175ui_story and not isNil(var_203_4) then
					local var_203_8 = Mathf.Lerp(0, 0.5, var_203_7)

					arg_200_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_200_1.var_.characterEffect10175ui_story.fillRatio = var_203_8
				end
			end

			if arg_200_1.time_ >= var_203_5 + var_203_6 and arg_200_1.time_ < var_203_5 + var_203_6 + arg_203_0 and not isNil(var_203_4) and arg_200_1.var_.characterEffect10175ui_story then
				local var_203_9 = 0.5

				arg_200_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_200_1.var_.characterEffect10175ui_story.fillRatio = var_203_9
			end

			local var_203_10 = 0

			if var_203_10 < arg_200_1.time_ and arg_200_1.time_ <= var_203_10 + arg_203_0 then
				arg_200_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_203_11 = 0

			if var_203_11 < arg_200_1.time_ and arg_200_1.time_ <= var_203_11 + arg_203_0 then
				arg_200_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_203_12 = 0
			local var_203_13 = 0.225

			if var_203_12 < arg_200_1.time_ and arg_200_1.time_ <= var_203_12 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_14 = arg_200_1:FormatText(StoryNameCfg[1487].name)

				arg_200_1.leftNameTxt_.text = var_203_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_15 = arg_200_1:GetWordFromCfg(325611049)
				local var_203_16 = arg_200_1:FormatText(var_203_15.content)

				arg_200_1.text_.text = var_203_16

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_17 = 9
				local var_203_18 = utf8.len(var_203_16)
				local var_203_19 = var_203_17 <= 0 and var_203_13 or var_203_13 * (var_203_18 / var_203_17)

				if var_203_19 > 0 and var_203_13 < var_203_19 then
					arg_200_1.talkMaxDuration = var_203_19

					if var_203_19 + var_203_12 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_19 + var_203_12
					end
				end

				arg_200_1.text_.text = var_203_16
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611049", "story_v_out_325611.awb") ~= 0 then
					local var_203_20 = manager.audio:GetVoiceLength("story_v_out_325611", "325611049", "story_v_out_325611.awb") / 1000

					if var_203_20 + var_203_12 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_20 + var_203_12
					end

					if var_203_15.prefab_name ~= "" and arg_200_1.actors_[var_203_15.prefab_name] ~= nil then
						local var_203_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_15.prefab_name].transform, "story_v_out_325611", "325611049", "story_v_out_325611.awb")

						arg_200_1:RecordAudio("325611049", var_203_21)
						arg_200_1:RecordAudio("325611049", var_203_21)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_325611", "325611049", "story_v_out_325611.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_325611", "325611049", "story_v_out_325611.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_22 = math.max(var_203_13, arg_200_1.talkMaxDuration)

			if var_203_12 <= arg_200_1.time_ and arg_200_1.time_ < var_203_12 + var_203_22 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_12) / var_203_22

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_12 + var_203_22 and arg_200_1.time_ < var_203_12 + var_203_22 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play325611050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 325611050
		arg_204_1.duration_ = 4.83

		local var_204_0 = {
			zh = 4.833,
			ja = 3
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
				arg_204_0:Play325611051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1054ui_story"].transform
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1.var_.moveOldPos1054ui_story = var_207_0.localPosition

				local var_207_2 = GameObjectTools.GetOrAddComponent(var_207_0.gameObject, typeof(DynamicBoneHelper))

				if var_207_2 then
					var_207_2:EnableDynamicBone(false)
				end
			end

			local var_207_3 = 0.001

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_3 then
				local var_207_4 = (arg_204_1.time_ - var_207_1) / var_207_3
				local var_207_5 = Vector3.New(0, 100, 0)

				var_207_0.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1054ui_story, var_207_5, var_207_4)

				local var_207_6 = manager.ui.mainCamera.transform.position - var_207_0.position

				var_207_0.forward = Vector3.New(var_207_6.x, var_207_6.y, var_207_6.z)

				local var_207_7 = var_207_0.localEulerAngles

				var_207_7.z = 0
				var_207_7.x = 0
				var_207_0.localEulerAngles = var_207_7
			end

			if arg_204_1.time_ >= var_207_1 + var_207_3 and arg_204_1.time_ < var_207_1 + var_207_3 + arg_207_0 then
				var_207_0.localPosition = Vector3.New(0, 100, 0)

				local var_207_8 = manager.ui.mainCamera.transform.position - var_207_0.position

				var_207_0.forward = Vector3.New(var_207_8.x, var_207_8.y, var_207_8.z)

				local var_207_9 = var_207_0.localEulerAngles

				var_207_9.z = 0
				var_207_9.x = 0
				var_207_0.localEulerAngles = var_207_9

				local var_207_10 = GameObjectTools.GetOrAddComponent(var_207_0.gameObject, typeof(DynamicBoneHelper))

				if var_207_10 then
					var_207_10:EnableDynamicBone(true)
				end
			end

			local var_207_11 = arg_204_1.actors_["6148ui_story"].transform
			local var_207_12 = 0

			if var_207_12 < arg_204_1.time_ and arg_204_1.time_ <= var_207_12 + arg_207_0 then
				arg_204_1.var_.moveOldPos6148ui_story = var_207_11.localPosition

				local var_207_13 = GameObjectTools.GetOrAddComponent(var_207_11.gameObject, typeof(DynamicBoneHelper))

				if var_207_13 then
					var_207_13:EnableDynamicBone(false)
				end
			end

			local var_207_14 = 0.001

			if var_207_12 <= arg_204_1.time_ and arg_204_1.time_ < var_207_12 + var_207_14 then
				local var_207_15 = (arg_204_1.time_ - var_207_12) / var_207_14
				local var_207_16 = Vector3.New(0, -0.985, -6)

				var_207_11.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos6148ui_story, var_207_16, var_207_15)

				local var_207_17 = manager.ui.mainCamera.transform.position - var_207_11.position

				var_207_11.forward = Vector3.New(var_207_17.x, var_207_17.y, var_207_17.z)

				local var_207_18 = var_207_11.localEulerAngles

				var_207_18.z = 0
				var_207_18.x = 0
				var_207_11.localEulerAngles = var_207_18
			end

			if arg_204_1.time_ >= var_207_12 + var_207_14 and arg_204_1.time_ < var_207_12 + var_207_14 + arg_207_0 then
				var_207_11.localPosition = Vector3.New(0, -0.985, -6)

				local var_207_19 = manager.ui.mainCamera.transform.position - var_207_11.position

				var_207_11.forward = Vector3.New(var_207_19.x, var_207_19.y, var_207_19.z)

				local var_207_20 = var_207_11.localEulerAngles

				var_207_20.z = 0
				var_207_20.x = 0
				var_207_11.localEulerAngles = var_207_20

				local var_207_21 = GameObjectTools.GetOrAddComponent(var_207_11.gameObject, typeof(DynamicBoneHelper))

				if var_207_21 then
					var_207_21:EnableDynamicBone(true)
				end
			end

			local var_207_22 = arg_204_1.actors_["10175ui_story"].transform
			local var_207_23 = 0

			if var_207_23 < arg_204_1.time_ and arg_204_1.time_ <= var_207_23 + arg_207_0 then
				arg_204_1.var_.moveOldPos10175ui_story = var_207_22.localPosition

				local var_207_24 = GameObjectTools.GetOrAddComponent(var_207_22.gameObject, typeof(DynamicBoneHelper))

				if var_207_24 then
					var_207_24:EnableDynamicBone(false)
				end
			end

			local var_207_25 = 0.001

			if var_207_23 <= arg_204_1.time_ and arg_204_1.time_ < var_207_23 + var_207_25 then
				local var_207_26 = (arg_204_1.time_ - var_207_23) / var_207_25
				local var_207_27 = Vector3.New(0, 100, 0)

				var_207_22.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10175ui_story, var_207_27, var_207_26)

				local var_207_28 = manager.ui.mainCamera.transform.position - var_207_22.position

				var_207_22.forward = Vector3.New(var_207_28.x, var_207_28.y, var_207_28.z)

				local var_207_29 = var_207_22.localEulerAngles

				var_207_29.z = 0
				var_207_29.x = 0
				var_207_22.localEulerAngles = var_207_29
			end

			if arg_204_1.time_ >= var_207_23 + var_207_25 and arg_204_1.time_ < var_207_23 + var_207_25 + arg_207_0 then
				var_207_22.localPosition = Vector3.New(0, 100, 0)

				local var_207_30 = manager.ui.mainCamera.transform.position - var_207_22.position

				var_207_22.forward = Vector3.New(var_207_30.x, var_207_30.y, var_207_30.z)

				local var_207_31 = var_207_22.localEulerAngles

				var_207_31.z = 0
				var_207_31.x = 0
				var_207_22.localEulerAngles = var_207_31

				local var_207_32 = GameObjectTools.GetOrAddComponent(var_207_22.gameObject, typeof(DynamicBoneHelper))

				if var_207_32 then
					var_207_32:EnableDynamicBone(true)
				end
			end

			local var_207_33 = arg_204_1.actors_["6148ui_story"]
			local var_207_34 = 0

			if var_207_34 < arg_204_1.time_ and arg_204_1.time_ <= var_207_34 + arg_207_0 and not isNil(var_207_33) and arg_204_1.var_.characterEffect6148ui_story == nil then
				arg_204_1.var_.characterEffect6148ui_story = var_207_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_35 = 0.200000002980232

			if var_207_34 <= arg_204_1.time_ and arg_204_1.time_ < var_207_34 + var_207_35 and not isNil(var_207_33) then
				local var_207_36 = (arg_204_1.time_ - var_207_34) / var_207_35

				if arg_204_1.var_.characterEffect6148ui_story and not isNil(var_207_33) then
					arg_204_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_34 + var_207_35 and arg_204_1.time_ < var_207_34 + var_207_35 + arg_207_0 and not isNil(var_207_33) and arg_204_1.var_.characterEffect6148ui_story then
				arg_204_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_207_37 = arg_204_1.actors_["1054ui_story"]
			local var_207_38 = 0

			if var_207_38 < arg_204_1.time_ and arg_204_1.time_ <= var_207_38 + arg_207_0 and not isNil(var_207_37) and arg_204_1.var_.characterEffect1054ui_story == nil then
				arg_204_1.var_.characterEffect1054ui_story = var_207_37:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_39 = 0.200000002980232

			if var_207_38 <= arg_204_1.time_ and arg_204_1.time_ < var_207_38 + var_207_39 and not isNil(var_207_37) then
				local var_207_40 = (arg_204_1.time_ - var_207_38) / var_207_39

				if arg_204_1.var_.characterEffect1054ui_story and not isNil(var_207_37) then
					local var_207_41 = Mathf.Lerp(0, 0.5, var_207_40)

					arg_204_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1054ui_story.fillRatio = var_207_41
				end
			end

			if arg_204_1.time_ >= var_207_38 + var_207_39 and arg_204_1.time_ < var_207_38 + var_207_39 + arg_207_0 and not isNil(var_207_37) and arg_204_1.var_.characterEffect1054ui_story then
				local var_207_42 = 0.5

				arg_204_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1054ui_story.fillRatio = var_207_42
			end

			local var_207_43 = 0

			if var_207_43 < arg_204_1.time_ and arg_204_1.time_ <= var_207_43 + arg_207_0 then
				arg_204_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_207_44 = 0

			if var_207_44 < arg_204_1.time_ and arg_204_1.time_ <= var_207_44 + arg_207_0 then
				arg_204_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_207_45 = 0
			local var_207_46 = 0.55

			if var_207_45 < arg_204_1.time_ and arg_204_1.time_ <= var_207_45 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_47 = arg_204_1:FormatText(StoryNameCfg[1488].name)

				arg_204_1.leftNameTxt_.text = var_207_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_48 = arg_204_1:GetWordFromCfg(325611050)
				local var_207_49 = arg_204_1:FormatText(var_207_48.content)

				arg_204_1.text_.text = var_207_49

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_50 = 22
				local var_207_51 = utf8.len(var_207_49)
				local var_207_52 = var_207_50 <= 0 and var_207_46 or var_207_46 * (var_207_51 / var_207_50)

				if var_207_52 > 0 and var_207_46 < var_207_52 then
					arg_204_1.talkMaxDuration = var_207_52

					if var_207_52 + var_207_45 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_52 + var_207_45
					end
				end

				arg_204_1.text_.text = var_207_49
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611050", "story_v_out_325611.awb") ~= 0 then
					local var_207_53 = manager.audio:GetVoiceLength("story_v_out_325611", "325611050", "story_v_out_325611.awb") / 1000

					if var_207_53 + var_207_45 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_53 + var_207_45
					end

					if var_207_48.prefab_name ~= "" and arg_204_1.actors_[var_207_48.prefab_name] ~= nil then
						local var_207_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_48.prefab_name].transform, "story_v_out_325611", "325611050", "story_v_out_325611.awb")

						arg_204_1:RecordAudio("325611050", var_207_54)
						arg_204_1:RecordAudio("325611050", var_207_54)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_325611", "325611050", "story_v_out_325611.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_325611", "325611050", "story_v_out_325611.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_55 = math.max(var_207_46, arg_204_1.talkMaxDuration)

			if var_207_45 <= arg_204_1.time_ and arg_204_1.time_ < var_207_45 + var_207_55 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_45) / var_207_55

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_45 + var_207_55 and arg_204_1.time_ < var_207_45 + var_207_55 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
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

		arg_204_1:InitPlayNodeList()
	end,
	Play325611051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 325611051
		arg_208_1.duration_ = 10.37

		local var_208_0 = {
			zh = 7.3,
			ja = 10.366
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
				arg_208_0:Play325611052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["6148ui_story"].transform
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.var_.moveOldPos6148ui_story = var_211_0.localPosition

				local var_211_2 = GameObjectTools.GetOrAddComponent(var_211_0.gameObject, typeof(DynamicBoneHelper))

				if var_211_2 then
					var_211_2:EnableDynamicBone(false)
				end
			end

			local var_211_3 = 0.001

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_3 then
				local var_211_4 = (arg_208_1.time_ - var_211_1) / var_211_3
				local var_211_5 = Vector3.New(-0.7, -0.985, -6)

				var_211_0.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos6148ui_story, var_211_5, var_211_4)

				local var_211_6 = manager.ui.mainCamera.transform.position - var_211_0.position

				var_211_0.forward = Vector3.New(var_211_6.x, var_211_6.y, var_211_6.z)

				local var_211_7 = var_211_0.localEulerAngles

				var_211_7.z = 0
				var_211_7.x = 0
				var_211_0.localEulerAngles = var_211_7
			end

			if arg_208_1.time_ >= var_211_1 + var_211_3 and arg_208_1.time_ < var_211_1 + var_211_3 + arg_211_0 then
				var_211_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_211_8 = manager.ui.mainCamera.transform.position - var_211_0.position

				var_211_0.forward = Vector3.New(var_211_8.x, var_211_8.y, var_211_8.z)

				local var_211_9 = var_211_0.localEulerAngles

				var_211_9.z = 0
				var_211_9.x = 0
				var_211_0.localEulerAngles = var_211_9

				local var_211_10 = GameObjectTools.GetOrAddComponent(var_211_0.gameObject, typeof(DynamicBoneHelper))

				if var_211_10 then
					var_211_10:EnableDynamicBone(true)
				end
			end

			local var_211_11 = arg_208_1.actors_["1170ui_story"].transform
			local var_211_12 = 0

			if var_211_12 < arg_208_1.time_ and arg_208_1.time_ <= var_211_12 + arg_211_0 then
				arg_208_1.var_.moveOldPos1170ui_story = var_211_11.localPosition

				local var_211_13 = GameObjectTools.GetOrAddComponent(var_211_11.gameObject, typeof(DynamicBoneHelper))

				if var_211_13 then
					var_211_13:EnableDynamicBone(false)
				end
			end

			local var_211_14 = 0.001

			if var_211_12 <= arg_208_1.time_ and arg_208_1.time_ < var_211_12 + var_211_14 then
				local var_211_15 = (arg_208_1.time_ - var_211_12) / var_211_14
				local var_211_16 = Vector3.New(0.74, -0.95, -6.08)

				var_211_11.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1170ui_story, var_211_16, var_211_15)

				local var_211_17 = manager.ui.mainCamera.transform.position - var_211_11.position

				var_211_11.forward = Vector3.New(var_211_17.x, var_211_17.y, var_211_17.z)

				local var_211_18 = var_211_11.localEulerAngles

				var_211_18.z = 0
				var_211_18.x = 0
				var_211_11.localEulerAngles = var_211_18
			end

			if arg_208_1.time_ >= var_211_12 + var_211_14 and arg_208_1.time_ < var_211_12 + var_211_14 + arg_211_0 then
				var_211_11.localPosition = Vector3.New(0.74, -0.95, -6.08)

				local var_211_19 = manager.ui.mainCamera.transform.position - var_211_11.position

				var_211_11.forward = Vector3.New(var_211_19.x, var_211_19.y, var_211_19.z)

				local var_211_20 = var_211_11.localEulerAngles

				var_211_20.z = 0
				var_211_20.x = 0
				var_211_11.localEulerAngles = var_211_20

				local var_211_21 = GameObjectTools.GetOrAddComponent(var_211_11.gameObject, typeof(DynamicBoneHelper))

				if var_211_21 then
					var_211_21:EnableDynamicBone(true)
				end
			end

			local var_211_22 = arg_208_1.actors_["1170ui_story"]
			local var_211_23 = 0

			if var_211_23 < arg_208_1.time_ and arg_208_1.time_ <= var_211_23 + arg_211_0 and not isNil(var_211_22) and arg_208_1.var_.characterEffect1170ui_story == nil then
				arg_208_1.var_.characterEffect1170ui_story = var_211_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_24 = 0.200000002980232

			if var_211_23 <= arg_208_1.time_ and arg_208_1.time_ < var_211_23 + var_211_24 and not isNil(var_211_22) then
				local var_211_25 = (arg_208_1.time_ - var_211_23) / var_211_24

				if arg_208_1.var_.characterEffect1170ui_story and not isNil(var_211_22) then
					arg_208_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= var_211_23 + var_211_24 and arg_208_1.time_ < var_211_23 + var_211_24 + arg_211_0 and not isNil(var_211_22) and arg_208_1.var_.characterEffect1170ui_story then
				arg_208_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_211_26 = arg_208_1.actors_["6148ui_story"]
			local var_211_27 = 0

			if var_211_27 < arg_208_1.time_ and arg_208_1.time_ <= var_211_27 + arg_211_0 and not isNil(var_211_26) and arg_208_1.var_.characterEffect6148ui_story == nil then
				arg_208_1.var_.characterEffect6148ui_story = var_211_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_28 = 0.200000002980232

			if var_211_27 <= arg_208_1.time_ and arg_208_1.time_ < var_211_27 + var_211_28 and not isNil(var_211_26) then
				local var_211_29 = (arg_208_1.time_ - var_211_27) / var_211_28

				if arg_208_1.var_.characterEffect6148ui_story and not isNil(var_211_26) then
					local var_211_30 = Mathf.Lerp(0, 0.5, var_211_29)

					arg_208_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_208_1.var_.characterEffect6148ui_story.fillRatio = var_211_30
				end
			end

			if arg_208_1.time_ >= var_211_27 + var_211_28 and arg_208_1.time_ < var_211_27 + var_211_28 + arg_211_0 and not isNil(var_211_26) and arg_208_1.var_.characterEffect6148ui_story then
				local var_211_31 = 0.5

				arg_208_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_208_1.var_.characterEffect6148ui_story.fillRatio = var_211_31
			end

			local var_211_32 = 0

			if var_211_32 < arg_208_1.time_ and arg_208_1.time_ <= var_211_32 + arg_211_0 then
				arg_208_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action4_1")
			end

			local var_211_33 = 0

			if var_211_33 < arg_208_1.time_ and arg_208_1.time_ <= var_211_33 + arg_211_0 then
				arg_208_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_211_34 = 0
			local var_211_35 = 0.825

			if var_211_34 < arg_208_1.time_ and arg_208_1.time_ <= var_211_34 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_36 = arg_208_1:FormatText(StoryNameCfg[318].name)

				arg_208_1.leftNameTxt_.text = var_211_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_37 = arg_208_1:GetWordFromCfg(325611051)
				local var_211_38 = arg_208_1:FormatText(var_211_37.content)

				arg_208_1.text_.text = var_211_38

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_39 = 33
				local var_211_40 = utf8.len(var_211_38)
				local var_211_41 = var_211_39 <= 0 and var_211_35 or var_211_35 * (var_211_40 / var_211_39)

				if var_211_41 > 0 and var_211_35 < var_211_41 then
					arg_208_1.talkMaxDuration = var_211_41

					if var_211_41 + var_211_34 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_41 + var_211_34
					end
				end

				arg_208_1.text_.text = var_211_38
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611051", "story_v_out_325611.awb") ~= 0 then
					local var_211_42 = manager.audio:GetVoiceLength("story_v_out_325611", "325611051", "story_v_out_325611.awb") / 1000

					if var_211_42 + var_211_34 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_42 + var_211_34
					end

					if var_211_37.prefab_name ~= "" and arg_208_1.actors_[var_211_37.prefab_name] ~= nil then
						local var_211_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_37.prefab_name].transform, "story_v_out_325611", "325611051", "story_v_out_325611.awb")

						arg_208_1:RecordAudio("325611051", var_211_43)
						arg_208_1:RecordAudio("325611051", var_211_43)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_325611", "325611051", "story_v_out_325611.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_325611", "325611051", "story_v_out_325611.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_44 = math.max(var_211_35, arg_208_1.talkMaxDuration)

			if var_211_34 <= arg_208_1.time_ and arg_208_1.time_ < var_211_34 + var_211_44 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_34) / var_211_44

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_34 + var_211_44 and arg_208_1.time_ < var_211_34 + var_211_44 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
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
	Play325611052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 325611052
		arg_212_1.duration_ = 1

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play325611053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["6148ui_story"].transform
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1.var_.moveOldPos6148ui_story = var_215_0.localPosition

				local var_215_2 = GameObjectTools.GetOrAddComponent(var_215_0.gameObject, typeof(DynamicBoneHelper))

				if var_215_2 then
					var_215_2:EnableDynamicBone(false)
				end
			end

			local var_215_3 = 0.001

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_3 then
				local var_215_4 = (arg_212_1.time_ - var_215_1) / var_215_3
				local var_215_5 = Vector3.New(0, 100, 0)

				var_215_0.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos6148ui_story, var_215_5, var_215_4)

				local var_215_6 = manager.ui.mainCamera.transform.position - var_215_0.position

				var_215_0.forward = Vector3.New(var_215_6.x, var_215_6.y, var_215_6.z)

				local var_215_7 = var_215_0.localEulerAngles

				var_215_7.z = 0
				var_215_7.x = 0
				var_215_0.localEulerAngles = var_215_7
			end

			if arg_212_1.time_ >= var_215_1 + var_215_3 and arg_212_1.time_ < var_215_1 + var_215_3 + arg_215_0 then
				var_215_0.localPosition = Vector3.New(0, 100, 0)

				local var_215_8 = manager.ui.mainCamera.transform.position - var_215_0.position

				var_215_0.forward = Vector3.New(var_215_8.x, var_215_8.y, var_215_8.z)

				local var_215_9 = var_215_0.localEulerAngles

				var_215_9.z = 0
				var_215_9.x = 0
				var_215_0.localEulerAngles = var_215_9

				local var_215_10 = GameObjectTools.GetOrAddComponent(var_215_0.gameObject, typeof(DynamicBoneHelper))

				if var_215_10 then
					var_215_10:EnableDynamicBone(true)
				end
			end

			local var_215_11 = arg_212_1.actors_["1071ui_story"].transform
			local var_215_12 = 0

			if var_215_12 < arg_212_1.time_ and arg_212_1.time_ <= var_215_12 + arg_215_0 then
				arg_212_1.var_.moveOldPos1071ui_story = var_215_11.localPosition
			end

			local var_215_13 = 0.001

			if var_215_12 <= arg_212_1.time_ and arg_212_1.time_ < var_215_12 + var_215_13 then
				local var_215_14 = (arg_212_1.time_ - var_215_12) / var_215_13
				local var_215_15 = Vector3.New(0, -1.05, -6.2)

				var_215_11.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1071ui_story, var_215_15, var_215_14)

				local var_215_16 = manager.ui.mainCamera.transform.position - var_215_11.position

				var_215_11.forward = Vector3.New(var_215_16.x, var_215_16.y, var_215_16.z)

				local var_215_17 = var_215_11.localEulerAngles

				var_215_17.z = 0
				var_215_17.x = 0
				var_215_11.localEulerAngles = var_215_17
			end

			if arg_212_1.time_ >= var_215_12 + var_215_13 and arg_212_1.time_ < var_215_12 + var_215_13 + arg_215_0 then
				var_215_11.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_215_18 = manager.ui.mainCamera.transform.position - var_215_11.position

				var_215_11.forward = Vector3.New(var_215_18.x, var_215_18.y, var_215_18.z)

				local var_215_19 = var_215_11.localEulerAngles

				var_215_19.z = 0
				var_215_19.x = 0
				var_215_11.localEulerAngles = var_215_19
			end

			local var_215_20 = arg_212_1.actors_["1170ui_story"].transform
			local var_215_21 = 0

			if var_215_21 < arg_212_1.time_ and arg_212_1.time_ <= var_215_21 + arg_215_0 then
				arg_212_1.var_.moveOldPos1170ui_story = var_215_20.localPosition

				local var_215_22 = GameObjectTools.GetOrAddComponent(var_215_20.gameObject, typeof(DynamicBoneHelper))

				if var_215_22 then
					var_215_22:EnableDynamicBone(false)
				end
			end

			local var_215_23 = 0.001

			if var_215_21 <= arg_212_1.time_ and arg_212_1.time_ < var_215_21 + var_215_23 then
				local var_215_24 = (arg_212_1.time_ - var_215_21) / var_215_23
				local var_215_25 = Vector3.New(0, 100, 0)

				var_215_20.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1170ui_story, var_215_25, var_215_24)

				local var_215_26 = manager.ui.mainCamera.transform.position - var_215_20.position

				var_215_20.forward = Vector3.New(var_215_26.x, var_215_26.y, var_215_26.z)

				local var_215_27 = var_215_20.localEulerAngles

				var_215_27.z = 0
				var_215_27.x = 0
				var_215_20.localEulerAngles = var_215_27
			end

			if arg_212_1.time_ >= var_215_21 + var_215_23 and arg_212_1.time_ < var_215_21 + var_215_23 + arg_215_0 then
				var_215_20.localPosition = Vector3.New(0, 100, 0)

				local var_215_28 = manager.ui.mainCamera.transform.position - var_215_20.position

				var_215_20.forward = Vector3.New(var_215_28.x, var_215_28.y, var_215_28.z)

				local var_215_29 = var_215_20.localEulerAngles

				var_215_29.z = 0
				var_215_29.x = 0
				var_215_20.localEulerAngles = var_215_29

				local var_215_30 = GameObjectTools.GetOrAddComponent(var_215_20.gameObject, typeof(DynamicBoneHelper))

				if var_215_30 then
					var_215_30:EnableDynamicBone(true)
				end
			end

			local var_215_31 = arg_212_1.actors_["1071ui_story"]
			local var_215_32 = 0

			if var_215_32 < arg_212_1.time_ and arg_212_1.time_ <= var_215_32 + arg_215_0 and not isNil(var_215_31) and arg_212_1.var_.characterEffect1071ui_story == nil then
				arg_212_1.var_.characterEffect1071ui_story = var_215_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_33 = 0.200000002980232

			if var_215_32 <= arg_212_1.time_ and arg_212_1.time_ < var_215_32 + var_215_33 and not isNil(var_215_31) then
				local var_215_34 = (arg_212_1.time_ - var_215_32) / var_215_33

				if arg_212_1.var_.characterEffect1071ui_story and not isNil(var_215_31) then
					arg_212_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_32 + var_215_33 and arg_212_1.time_ < var_215_32 + var_215_33 + arg_215_0 and not isNil(var_215_31) and arg_212_1.var_.characterEffect1071ui_story then
				arg_212_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_215_35 = arg_212_1.actors_["1170ui_story"]
			local var_215_36 = 0

			if var_215_36 < arg_212_1.time_ and arg_212_1.time_ <= var_215_36 + arg_215_0 and not isNil(var_215_35) and arg_212_1.var_.characterEffect1170ui_story == nil then
				arg_212_1.var_.characterEffect1170ui_story = var_215_35:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_37 = 0.200000002980232

			if var_215_36 <= arg_212_1.time_ and arg_212_1.time_ < var_215_36 + var_215_37 and not isNil(var_215_35) then
				local var_215_38 = (arg_212_1.time_ - var_215_36) / var_215_37

				if arg_212_1.var_.characterEffect1170ui_story and not isNil(var_215_35) then
					local var_215_39 = Mathf.Lerp(0, 0.5, var_215_38)

					arg_212_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1170ui_story.fillRatio = var_215_39
				end
			end

			if arg_212_1.time_ >= var_215_36 + var_215_37 and arg_212_1.time_ < var_215_36 + var_215_37 + arg_215_0 and not isNil(var_215_35) and arg_212_1.var_.characterEffect1170ui_story then
				local var_215_40 = 0.5

				arg_212_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1170ui_story.fillRatio = var_215_40
			end

			local var_215_41 = 0
			local var_215_42 = 0.05

			if var_215_41 < arg_212_1.time_ and arg_212_1.time_ <= var_215_41 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_43 = arg_212_1:FormatText(StoryNameCfg[384].name)

				arg_212_1.leftNameTxt_.text = var_215_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_44 = arg_212_1:GetWordFromCfg(325611052)
				local var_215_45 = arg_212_1:FormatText(var_215_44.content)

				arg_212_1.text_.text = var_215_45

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_46 = 2
				local var_215_47 = utf8.len(var_215_45)
				local var_215_48 = var_215_46 <= 0 and var_215_42 or var_215_42 * (var_215_47 / var_215_46)

				if var_215_48 > 0 and var_215_42 < var_215_48 then
					arg_212_1.talkMaxDuration = var_215_48

					if var_215_48 + var_215_41 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_48 + var_215_41
					end
				end

				arg_212_1.text_.text = var_215_45
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611052", "story_v_out_325611.awb") ~= 0 then
					local var_215_49 = manager.audio:GetVoiceLength("story_v_out_325611", "325611052", "story_v_out_325611.awb") / 1000

					if var_215_49 + var_215_41 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_49 + var_215_41
					end

					if var_215_44.prefab_name ~= "" and arg_212_1.actors_[var_215_44.prefab_name] ~= nil then
						local var_215_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_44.prefab_name].transform, "story_v_out_325611", "325611052", "story_v_out_325611.awb")

						arg_212_1:RecordAudio("325611052", var_215_50)
						arg_212_1:RecordAudio("325611052", var_215_50)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_325611", "325611052", "story_v_out_325611.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_325611", "325611052", "story_v_out_325611.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_51 = math.max(var_215_42, arg_212_1.talkMaxDuration)

			if var_215_41 <= arg_212_1.time_ and arg_212_1.time_ < var_215_41 + var_215_51 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_41) / var_215_51

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_41 + var_215_51 and arg_212_1.time_ < var_215_41 + var_215_51 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play325611053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 325611053
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play325611054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1071ui_story"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1071ui_story == nil then
				arg_216_1.var_.characterEffect1071ui_story = var_219_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.characterEffect1071ui_story and not isNil(var_219_0) then
					local var_219_4 = Mathf.Lerp(0, 0.5, var_219_3)

					arg_216_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1071ui_story.fillRatio = var_219_4
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1071ui_story then
				local var_219_5 = 0.5

				arg_216_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1071ui_story.fillRatio = var_219_5
			end

			local var_219_6 = 0
			local var_219_7 = 1.025

			if var_219_6 < arg_216_1.time_ and arg_216_1.time_ <= var_219_6 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_8 = arg_216_1:GetWordFromCfg(325611053)
				local var_219_9 = arg_216_1:FormatText(var_219_8.content)

				arg_216_1.text_.text = var_219_9

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_10 = 41
				local var_219_11 = utf8.len(var_219_9)
				local var_219_12 = var_219_10 <= 0 and var_219_7 or var_219_7 * (var_219_11 / var_219_10)

				if var_219_12 > 0 and var_219_7 < var_219_12 then
					arg_216_1.talkMaxDuration = var_219_12

					if var_219_12 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_12 + var_219_6
					end
				end

				arg_216_1.text_.text = var_219_9
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_13 = math.max(var_219_7, arg_216_1.talkMaxDuration)

			if var_219_6 <= arg_216_1.time_ and arg_216_1.time_ < var_219_6 + var_219_13 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_6) / var_219_13

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_6 + var_219_13 and arg_216_1.time_ < var_219_6 + var_219_13 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play325611054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 325611054
		arg_220_1.duration_ = 8.8

		local var_220_0 = {
			zh = 4.966,
			ja = 8.8
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play325611055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1071ui_story"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1071ui_story == nil then
				arg_220_1.var_.characterEffect1071ui_story = var_223_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.200000002980232

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.characterEffect1071ui_story and not isNil(var_223_0) then
					arg_220_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1071ui_story then
				arg_220_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_223_4 = 0

			if var_223_4 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_223_5 = 0
			local var_223_6 = 0.575

			if var_223_5 < arg_220_1.time_ and arg_220_1.time_ <= var_223_5 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_7 = arg_220_1:FormatText(StoryNameCfg[384].name)

				arg_220_1.leftNameTxt_.text = var_223_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_8 = arg_220_1:GetWordFromCfg(325611054)
				local var_223_9 = arg_220_1:FormatText(var_223_8.content)

				arg_220_1.text_.text = var_223_9

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_10 = 23
				local var_223_11 = utf8.len(var_223_9)
				local var_223_12 = var_223_10 <= 0 and var_223_6 or var_223_6 * (var_223_11 / var_223_10)

				if var_223_12 > 0 and var_223_6 < var_223_12 then
					arg_220_1.talkMaxDuration = var_223_12

					if var_223_12 + var_223_5 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_12 + var_223_5
					end
				end

				arg_220_1.text_.text = var_223_9
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611054", "story_v_out_325611.awb") ~= 0 then
					local var_223_13 = manager.audio:GetVoiceLength("story_v_out_325611", "325611054", "story_v_out_325611.awb") / 1000

					if var_223_13 + var_223_5 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_13 + var_223_5
					end

					if var_223_8.prefab_name ~= "" and arg_220_1.actors_[var_223_8.prefab_name] ~= nil then
						local var_223_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_8.prefab_name].transform, "story_v_out_325611", "325611054", "story_v_out_325611.awb")

						arg_220_1:RecordAudio("325611054", var_223_14)
						arg_220_1:RecordAudio("325611054", var_223_14)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_325611", "325611054", "story_v_out_325611.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_325611", "325611054", "story_v_out_325611.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_15 = math.max(var_223_6, arg_220_1.talkMaxDuration)

			if var_223_5 <= arg_220_1.time_ and arg_220_1.time_ < var_223_5 + var_223_15 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_5) / var_223_15

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_5 + var_223_15 and arg_220_1.time_ < var_223_5 + var_223_15 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play325611055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 325611055
		arg_224_1.duration_ = 10.1

		local var_224_0 = {
			zh = 10.1,
			ja = 7.866
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play325611056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0
			local var_227_1 = 1.125

			if var_227_0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_2 = arg_224_1:FormatText(StoryNameCfg[384].name)

				arg_224_1.leftNameTxt_.text = var_227_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_3 = arg_224_1:GetWordFromCfg(325611055)
				local var_227_4 = arg_224_1:FormatText(var_227_3.content)

				arg_224_1.text_.text = var_227_4

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_5 = 45
				local var_227_6 = utf8.len(var_227_4)
				local var_227_7 = var_227_5 <= 0 and var_227_1 or var_227_1 * (var_227_6 / var_227_5)

				if var_227_7 > 0 and var_227_1 < var_227_7 then
					arg_224_1.talkMaxDuration = var_227_7

					if var_227_7 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_7 + var_227_0
					end
				end

				arg_224_1.text_.text = var_227_4
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611055", "story_v_out_325611.awb") ~= 0 then
					local var_227_8 = manager.audio:GetVoiceLength("story_v_out_325611", "325611055", "story_v_out_325611.awb") / 1000

					if var_227_8 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_8 + var_227_0
					end

					if var_227_3.prefab_name ~= "" and arg_224_1.actors_[var_227_3.prefab_name] ~= nil then
						local var_227_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_3.prefab_name].transform, "story_v_out_325611", "325611055", "story_v_out_325611.awb")

						arg_224_1:RecordAudio("325611055", var_227_9)
						arg_224_1:RecordAudio("325611055", var_227_9)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_325611", "325611055", "story_v_out_325611.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_325611", "325611055", "story_v_out_325611.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_10 = math.max(var_227_1, arg_224_1.talkMaxDuration)

			if var_227_0 <= arg_224_1.time_ and arg_224_1.time_ < var_227_0 + var_227_10 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_0) / var_227_10

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_0 + var_227_10 and arg_224_1.time_ < var_227_0 + var_227_10 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play325611056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 325611056
		arg_228_1.duration_ = 8.53

		local var_228_0 = {
			zh = 7.533,
			ja = 8.533
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
				arg_228_0:Play325611057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0

			if var_231_0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_0 + arg_231_0 then
				arg_228_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_2")
			end

			local var_231_1 = 0
			local var_231_2 = 0.9

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_3 = arg_228_1:FormatText(StoryNameCfg[384].name)

				arg_228_1.leftNameTxt_.text = var_231_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_4 = arg_228_1:GetWordFromCfg(325611056)
				local var_231_5 = arg_228_1:FormatText(var_231_4.content)

				arg_228_1.text_.text = var_231_5

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_6 = 36
				local var_231_7 = utf8.len(var_231_5)
				local var_231_8 = var_231_6 <= 0 and var_231_2 or var_231_2 * (var_231_7 / var_231_6)

				if var_231_8 > 0 and var_231_2 < var_231_8 then
					arg_228_1.talkMaxDuration = var_231_8

					if var_231_8 + var_231_1 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_8 + var_231_1
					end
				end

				arg_228_1.text_.text = var_231_5
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611056", "story_v_out_325611.awb") ~= 0 then
					local var_231_9 = manager.audio:GetVoiceLength("story_v_out_325611", "325611056", "story_v_out_325611.awb") / 1000

					if var_231_9 + var_231_1 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_9 + var_231_1
					end

					if var_231_4.prefab_name ~= "" and arg_228_1.actors_[var_231_4.prefab_name] ~= nil then
						local var_231_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_4.prefab_name].transform, "story_v_out_325611", "325611056", "story_v_out_325611.awb")

						arg_228_1:RecordAudio("325611056", var_231_10)
						arg_228_1:RecordAudio("325611056", var_231_10)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_325611", "325611056", "story_v_out_325611.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_325611", "325611056", "story_v_out_325611.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_11 = math.max(var_231_2, arg_228_1.talkMaxDuration)

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_11 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_1) / var_231_11

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_1 + var_231_11 and arg_228_1.time_ < var_231_1 + var_231_11 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play325611057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 325611057
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play325611058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1071ui_story"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos1071ui_story = var_235_0.localPosition
			end

			local var_235_2 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2
				local var_235_4 = Vector3.New(0, 100, 0)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1071ui_story, var_235_4, var_235_3)

				local var_235_5 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_5.x, var_235_5.y, var_235_5.z)

				local var_235_6 = var_235_0.localEulerAngles

				var_235_6.z = 0
				var_235_6.x = 0
				var_235_0.localEulerAngles = var_235_6
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(0, 100, 0)

				local var_235_7 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_7.x, var_235_7.y, var_235_7.z)

				local var_235_8 = var_235_0.localEulerAngles

				var_235_8.z = 0
				var_235_8.x = 0
				var_235_0.localEulerAngles = var_235_8
			end

			local var_235_9 = arg_232_1.actors_["1071ui_story"]
			local var_235_10 = 0

			if var_235_10 < arg_232_1.time_ and arg_232_1.time_ <= var_235_10 + arg_235_0 and not isNil(var_235_9) and arg_232_1.var_.characterEffect1071ui_story == nil then
				arg_232_1.var_.characterEffect1071ui_story = var_235_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_11 = 0.200000002980232

			if var_235_10 <= arg_232_1.time_ and arg_232_1.time_ < var_235_10 + var_235_11 and not isNil(var_235_9) then
				local var_235_12 = (arg_232_1.time_ - var_235_10) / var_235_11

				if arg_232_1.var_.characterEffect1071ui_story and not isNil(var_235_9) then
					local var_235_13 = Mathf.Lerp(0, 0.5, var_235_12)

					arg_232_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1071ui_story.fillRatio = var_235_13
				end
			end

			if arg_232_1.time_ >= var_235_10 + var_235_11 and arg_232_1.time_ < var_235_10 + var_235_11 + arg_235_0 and not isNil(var_235_9) and arg_232_1.var_.characterEffect1071ui_story then
				local var_235_14 = 0.5

				arg_232_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1071ui_story.fillRatio = var_235_14
			end

			local var_235_15 = manager.ui.mainCamera.transform
			local var_235_16 = 0

			if var_235_16 < arg_232_1.time_ and arg_232_1.time_ <= var_235_16 + arg_235_0 then
				arg_232_1.var_.shakeOldPos = var_235_15.localPosition
			end

			local var_235_17 = 0.4

			if var_235_16 <= arg_232_1.time_ and arg_232_1.time_ < var_235_16 + var_235_17 then
				local var_235_18 = (arg_232_1.time_ - var_235_16) / 0.066
				local var_235_19, var_235_20 = math.modf(var_235_18)

				var_235_15.localPosition = Vector3.New(var_235_20 * 0.13, var_235_20 * 0.13, var_235_20 * 0.13) + arg_232_1.var_.shakeOldPos
			end

			if arg_232_1.time_ >= var_235_16 + var_235_17 and arg_232_1.time_ < var_235_16 + var_235_17 + arg_235_0 then
				var_235_15.localPosition = arg_232_1.var_.shakeOldPos
			end

			local var_235_21 = 0

			if var_235_21 < arg_232_1.time_ and arg_232_1.time_ <= var_235_21 + arg_235_0 then
				arg_232_1.allBtn_.enabled = false
			end

			local var_235_22 = 0.4

			if arg_232_1.time_ >= var_235_21 + var_235_22 and arg_232_1.time_ < var_235_21 + var_235_22 + arg_235_0 then
				arg_232_1.allBtn_.enabled = true
			end

			local var_235_23 = 0
			local var_235_24 = 0.075

			if var_235_23 < arg_232_1.time_ and arg_232_1.time_ <= var_235_23 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0

				arg_232_1.dialog_:SetActive(true)

				arg_232_1.dialogCg_.alpha = 0

				local var_235_25 = LeanTween.value(arg_232_1.dialog_, 0, 1, 0.3)

				var_235_25:setOnUpdate(LuaHelper.FloatAction(function(arg_236_0)
					arg_232_1.dialogCg_.alpha = arg_236_0
				end))
				var_235_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_232_1.dialog_)
					var_235_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_232_1.duration_ = arg_232_1.duration_ + 0.3

				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_26 = arg_232_1:FormatText(StoryNameCfg[7].name)

				arg_232_1.leftNameTxt_.text = var_235_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_27 = arg_232_1:GetWordFromCfg(325611057)
				local var_235_28 = arg_232_1:FormatText(var_235_27.content)

				arg_232_1.text_.text = var_235_28

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_29 = 3
				local var_235_30 = utf8.len(var_235_28)
				local var_235_31 = var_235_29 <= 0 and var_235_24 or var_235_24 * (var_235_30 / var_235_29)

				if var_235_31 > 0 and var_235_24 < var_235_31 then
					arg_232_1.talkMaxDuration = var_235_31
					var_235_23 = var_235_23 + 0.3

					if var_235_31 + var_235_23 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_31 + var_235_23
					end
				end

				arg_232_1.text_.text = var_235_28
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_32 = var_235_23 + 0.3
			local var_235_33 = math.max(var_235_24, arg_232_1.talkMaxDuration)

			if var_235_32 <= arg_232_1.time_ and arg_232_1.time_ < var_235_32 + var_235_33 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_32) / var_235_33

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_32 + var_235_33 and arg_232_1.time_ < var_235_32 + var_235_33 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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
	Play325611058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 325611058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play325611059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0
			local var_241_1 = 1.525

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_2 = arg_238_1:GetWordFromCfg(325611058)
				local var_241_3 = arg_238_1:FormatText(var_241_2.content)

				arg_238_1.text_.text = var_241_3

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_4 = 61
				local var_241_5 = utf8.len(var_241_3)
				local var_241_6 = var_241_4 <= 0 and var_241_1 or var_241_1 * (var_241_5 / var_241_4)

				if var_241_6 > 0 and var_241_1 < var_241_6 then
					arg_238_1.talkMaxDuration = var_241_6

					if var_241_6 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_6 + var_241_0
					end
				end

				arg_238_1.text_.text = var_241_3
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_7 = math.max(var_241_1, arg_238_1.talkMaxDuration)

			if var_241_0 <= arg_238_1.time_ and arg_238_1.time_ < var_241_0 + var_241_7 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_0) / var_241_7

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_0 + var_241_7 and arg_238_1.time_ < var_241_0 + var_241_7 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play325611059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 325611059
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play325611060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0
			local var_245_1 = 0.475

			if var_245_0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_2 = arg_242_1:FormatText(StoryNameCfg[7].name)

				arg_242_1.leftNameTxt_.text = var_245_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_3 = arg_242_1:GetWordFromCfg(325611059)
				local var_245_4 = arg_242_1:FormatText(var_245_3.content)

				arg_242_1.text_.text = var_245_4

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_5 = 19
				local var_245_6 = utf8.len(var_245_4)
				local var_245_7 = var_245_5 <= 0 and var_245_1 or var_245_1 * (var_245_6 / var_245_5)

				if var_245_7 > 0 and var_245_1 < var_245_7 then
					arg_242_1.talkMaxDuration = var_245_7

					if var_245_7 + var_245_0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_7 + var_245_0
					end
				end

				arg_242_1.text_.text = var_245_4
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_8 = math.max(var_245_1, arg_242_1.talkMaxDuration)

			if var_245_0 <= arg_242_1.time_ and arg_242_1.time_ < var_245_0 + var_245_8 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_0) / var_245_8

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_0 + var_245_8 and arg_242_1.time_ < var_245_0 + var_245_8 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play325611060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 325611060
		arg_246_1.duration_ = 4.9

		local var_246_0 = {
			zh = 3.466,
			ja = 4.9
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
				arg_246_0:Play325611061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["10175ui_story"].transform
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.var_.moveOldPos10175ui_story = var_249_0.localPosition

				local var_249_2 = GameObjectTools.GetOrAddComponent(var_249_0.gameObject, typeof(DynamicBoneHelper))

				if var_249_2 then
					var_249_2:EnableDynamicBone(false)
				end
			end

			local var_249_3 = 0.001

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_3 then
				local var_249_4 = (arg_246_1.time_ - var_249_1) / var_249_3
				local var_249_5 = Vector3.New(0, -1, -6.05)

				var_249_0.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos10175ui_story, var_249_5, var_249_4)

				local var_249_6 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_6.x, var_249_6.y, var_249_6.z)

				local var_249_7 = var_249_0.localEulerAngles

				var_249_7.z = 0
				var_249_7.x = 0
				var_249_0.localEulerAngles = var_249_7
			end

			if arg_246_1.time_ >= var_249_1 + var_249_3 and arg_246_1.time_ < var_249_1 + var_249_3 + arg_249_0 then
				var_249_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_249_8 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_8.x, var_249_8.y, var_249_8.z)

				local var_249_9 = var_249_0.localEulerAngles

				var_249_9.z = 0
				var_249_9.x = 0
				var_249_0.localEulerAngles = var_249_9

				local var_249_10 = GameObjectTools.GetOrAddComponent(var_249_0.gameObject, typeof(DynamicBoneHelper))

				if var_249_10 then
					var_249_10:EnableDynamicBone(true)
				end
			end

			local var_249_11 = arg_246_1.actors_["10175ui_story"]
			local var_249_12 = 0

			if var_249_12 < arg_246_1.time_ and arg_246_1.time_ <= var_249_12 + arg_249_0 and not isNil(var_249_11) and arg_246_1.var_.characterEffect10175ui_story == nil then
				arg_246_1.var_.characterEffect10175ui_story = var_249_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_13 = 0.200000002980232

			if var_249_12 <= arg_246_1.time_ and arg_246_1.time_ < var_249_12 + var_249_13 and not isNil(var_249_11) then
				local var_249_14 = (arg_246_1.time_ - var_249_12) / var_249_13

				if arg_246_1.var_.characterEffect10175ui_story and not isNil(var_249_11) then
					arg_246_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= var_249_12 + var_249_13 and arg_246_1.time_ < var_249_12 + var_249_13 + arg_249_0 and not isNil(var_249_11) and arg_246_1.var_.characterEffect10175ui_story then
				arg_246_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_249_15 = 0
			local var_249_16 = 0.35

			if var_249_15 < arg_246_1.time_ and arg_246_1.time_ <= var_249_15 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_17 = arg_246_1:FormatText(StoryNameCfg[1473].name)

				arg_246_1.leftNameTxt_.text = var_249_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_18 = arg_246_1:GetWordFromCfg(325611060)
				local var_249_19 = arg_246_1:FormatText(var_249_18.content)

				arg_246_1.text_.text = var_249_19

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_20 = 14
				local var_249_21 = utf8.len(var_249_19)
				local var_249_22 = var_249_20 <= 0 and var_249_16 or var_249_16 * (var_249_21 / var_249_20)

				if var_249_22 > 0 and var_249_16 < var_249_22 then
					arg_246_1.talkMaxDuration = var_249_22

					if var_249_22 + var_249_15 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_22 + var_249_15
					end
				end

				arg_246_1.text_.text = var_249_19
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611060", "story_v_out_325611.awb") ~= 0 then
					local var_249_23 = manager.audio:GetVoiceLength("story_v_out_325611", "325611060", "story_v_out_325611.awb") / 1000

					if var_249_23 + var_249_15 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_23 + var_249_15
					end

					if var_249_18.prefab_name ~= "" and arg_246_1.actors_[var_249_18.prefab_name] ~= nil then
						local var_249_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_18.prefab_name].transform, "story_v_out_325611", "325611060", "story_v_out_325611.awb")

						arg_246_1:RecordAudio("325611060", var_249_24)
						arg_246_1:RecordAudio("325611060", var_249_24)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_325611", "325611060", "story_v_out_325611.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_325611", "325611060", "story_v_out_325611.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_25 = math.max(var_249_16, arg_246_1.talkMaxDuration)

			if var_249_15 <= arg_246_1.time_ and arg_246_1.time_ < var_249_15 + var_249_25 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_15) / var_249_25

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_15 + var_249_25 and arg_246_1.time_ < var_249_15 + var_249_25 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
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

		arg_246_1:InitPlayNodeList()
	end,
	Play325611061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 325611061
		arg_250_1.duration_ = 8.97

		local var_250_0 = {
			zh = 6.033,
			ja = 8.966
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play325611062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["10175ui_story"].transform
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.var_.moveOldPos10175ui_story = var_253_0.localPosition

				local var_253_2 = GameObjectTools.GetOrAddComponent(var_253_0.gameObject, typeof(DynamicBoneHelper))

				if var_253_2 then
					var_253_2:EnableDynamicBone(false)
				end
			end

			local var_253_3 = 0.001

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_3 then
				local var_253_4 = (arg_250_1.time_ - var_253_1) / var_253_3
				local var_253_5 = Vector3.New(-0.7, -1, -6.05)

				var_253_0.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10175ui_story, var_253_5, var_253_4)

				local var_253_6 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_6.x, var_253_6.y, var_253_6.z)

				local var_253_7 = var_253_0.localEulerAngles

				var_253_7.z = 0
				var_253_7.x = 0
				var_253_0.localEulerAngles = var_253_7
			end

			if arg_250_1.time_ >= var_253_1 + var_253_3 and arg_250_1.time_ < var_253_1 + var_253_3 + arg_253_0 then
				var_253_0.localPosition = Vector3.New(-0.7, -1, -6.05)

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

			local var_253_11 = arg_250_1.actors_["1071ui_story"].transform
			local var_253_12 = 0

			if var_253_12 < arg_250_1.time_ and arg_250_1.time_ <= var_253_12 + arg_253_0 then
				arg_250_1.var_.moveOldPos1071ui_story = var_253_11.localPosition
			end

			local var_253_13 = 0.001

			if var_253_12 <= arg_250_1.time_ and arg_250_1.time_ < var_253_12 + var_253_13 then
				local var_253_14 = (arg_250_1.time_ - var_253_12) / var_253_13
				local var_253_15 = Vector3.New(0.7, -1.05, -6.2)

				var_253_11.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1071ui_story, var_253_15, var_253_14)

				local var_253_16 = manager.ui.mainCamera.transform.position - var_253_11.position

				var_253_11.forward = Vector3.New(var_253_16.x, var_253_16.y, var_253_16.z)

				local var_253_17 = var_253_11.localEulerAngles

				var_253_17.z = 0
				var_253_17.x = 0
				var_253_11.localEulerAngles = var_253_17
			end

			if arg_250_1.time_ >= var_253_12 + var_253_13 and arg_250_1.time_ < var_253_12 + var_253_13 + arg_253_0 then
				var_253_11.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_253_18 = manager.ui.mainCamera.transform.position - var_253_11.position

				var_253_11.forward = Vector3.New(var_253_18.x, var_253_18.y, var_253_18.z)

				local var_253_19 = var_253_11.localEulerAngles

				var_253_19.z = 0
				var_253_19.x = 0
				var_253_11.localEulerAngles = var_253_19
			end

			local var_253_20 = arg_250_1.actors_["1071ui_story"]
			local var_253_21 = 0

			if var_253_21 < arg_250_1.time_ and arg_250_1.time_ <= var_253_21 + arg_253_0 and not isNil(var_253_20) and arg_250_1.var_.characterEffect1071ui_story == nil then
				arg_250_1.var_.characterEffect1071ui_story = var_253_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_22 = 0.200000002980232

			if var_253_21 <= arg_250_1.time_ and arg_250_1.time_ < var_253_21 + var_253_22 and not isNil(var_253_20) then
				local var_253_23 = (arg_250_1.time_ - var_253_21) / var_253_22

				if arg_250_1.var_.characterEffect1071ui_story and not isNil(var_253_20) then
					arg_250_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= var_253_21 + var_253_22 and arg_250_1.time_ < var_253_21 + var_253_22 + arg_253_0 and not isNil(var_253_20) and arg_250_1.var_.characterEffect1071ui_story then
				arg_250_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_253_24 = arg_250_1.actors_["10175ui_story"]
			local var_253_25 = 0

			if var_253_25 < arg_250_1.time_ and arg_250_1.time_ <= var_253_25 + arg_253_0 and not isNil(var_253_24) and arg_250_1.var_.characterEffect10175ui_story == nil then
				arg_250_1.var_.characterEffect10175ui_story = var_253_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_26 = 0.200000002980232

			if var_253_25 <= arg_250_1.time_ and arg_250_1.time_ < var_253_25 + var_253_26 and not isNil(var_253_24) then
				local var_253_27 = (arg_250_1.time_ - var_253_25) / var_253_26

				if arg_250_1.var_.characterEffect10175ui_story and not isNil(var_253_24) then
					local var_253_28 = Mathf.Lerp(0, 0.5, var_253_27)

					arg_250_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_250_1.var_.characterEffect10175ui_story.fillRatio = var_253_28
				end
			end

			if arg_250_1.time_ >= var_253_25 + var_253_26 and arg_250_1.time_ < var_253_25 + var_253_26 + arg_253_0 and not isNil(var_253_24) and arg_250_1.var_.characterEffect10175ui_story then
				local var_253_29 = 0.5

				arg_250_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_250_1.var_.characterEffect10175ui_story.fillRatio = var_253_29
			end

			local var_253_30 = 0
			local var_253_31 = 0.75

			if var_253_30 < arg_250_1.time_ and arg_250_1.time_ <= var_253_30 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_32 = arg_250_1:FormatText(StoryNameCfg[384].name)

				arg_250_1.leftNameTxt_.text = var_253_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_33 = arg_250_1:GetWordFromCfg(325611061)
				local var_253_34 = arg_250_1:FormatText(var_253_33.content)

				arg_250_1.text_.text = var_253_34

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_35 = 30
				local var_253_36 = utf8.len(var_253_34)
				local var_253_37 = var_253_35 <= 0 and var_253_31 or var_253_31 * (var_253_36 / var_253_35)

				if var_253_37 > 0 and var_253_31 < var_253_37 then
					arg_250_1.talkMaxDuration = var_253_37

					if var_253_37 + var_253_30 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_37 + var_253_30
					end
				end

				arg_250_1.text_.text = var_253_34
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611061", "story_v_out_325611.awb") ~= 0 then
					local var_253_38 = manager.audio:GetVoiceLength("story_v_out_325611", "325611061", "story_v_out_325611.awb") / 1000

					if var_253_38 + var_253_30 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_38 + var_253_30
					end

					if var_253_33.prefab_name ~= "" and arg_250_1.actors_[var_253_33.prefab_name] ~= nil then
						local var_253_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_33.prefab_name].transform, "story_v_out_325611", "325611061", "story_v_out_325611.awb")

						arg_250_1:RecordAudio("325611061", var_253_39)
						arg_250_1:RecordAudio("325611061", var_253_39)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_325611", "325611061", "story_v_out_325611.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_325611", "325611061", "story_v_out_325611.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_40 = math.max(var_253_31, arg_250_1.talkMaxDuration)

			if var_253_30 <= arg_250_1.time_ and arg_250_1.time_ < var_253_30 + var_253_40 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_30) / var_253_40

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_30 + var_253_40 and arg_250_1.time_ < var_253_30 + var_253_40 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
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
				actorName = "1071ui_story",
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
	Play325611062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 325611062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play325611063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1071ui_story"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1071ui_story == nil then
				arg_254_1.var_.characterEffect1071ui_story = var_257_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.characterEffect1071ui_story and not isNil(var_257_0) then
					local var_257_4 = Mathf.Lerp(0, 0.5, var_257_3)

					arg_254_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1071ui_story.fillRatio = var_257_4
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1071ui_story then
				local var_257_5 = 0.5

				arg_254_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1071ui_story.fillRatio = var_257_5
			end

			local var_257_6 = 0
			local var_257_7 = 0.6

			if var_257_6 < arg_254_1.time_ and arg_254_1.time_ <= var_257_6 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_8 = arg_254_1:FormatText(StoryNameCfg[7].name)

				arg_254_1.leftNameTxt_.text = var_257_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_9 = arg_254_1:GetWordFromCfg(325611062)
				local var_257_10 = arg_254_1:FormatText(var_257_9.content)

				arg_254_1.text_.text = var_257_10

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_11 = 24
				local var_257_12 = utf8.len(var_257_10)
				local var_257_13 = var_257_11 <= 0 and var_257_7 or var_257_7 * (var_257_12 / var_257_11)

				if var_257_13 > 0 and var_257_7 < var_257_13 then
					arg_254_1.talkMaxDuration = var_257_13

					if var_257_13 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_13 + var_257_6
					end
				end

				arg_254_1.text_.text = var_257_10
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_14 = math.max(var_257_7, arg_254_1.talkMaxDuration)

			if var_257_6 <= arg_254_1.time_ and arg_254_1.time_ < var_257_6 + var_257_14 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_6) / var_257_14

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_6 + var_257_14 and arg_254_1.time_ < var_257_6 + var_257_14 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play325611063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 325611063
		arg_258_1.duration_ = 10.67

		local var_258_0 = {
			zh = 7.5,
			ja = 10.666
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play325611064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1071ui_story"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect1071ui_story == nil then
				arg_258_1.var_.characterEffect1071ui_story = var_261_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.characterEffect1071ui_story and not isNil(var_261_0) then
					arg_258_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect1071ui_story then
				arg_258_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_261_4 = 0

			if var_261_4 < arg_258_1.time_ and arg_258_1.time_ <= var_261_4 + arg_261_0 then
				arg_258_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_261_5 = 0
			local var_261_6 = 0.775

			if var_261_5 < arg_258_1.time_ and arg_258_1.time_ <= var_261_5 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_7 = arg_258_1:FormatText(StoryNameCfg[384].name)

				arg_258_1.leftNameTxt_.text = var_261_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_8 = arg_258_1:GetWordFromCfg(325611063)
				local var_261_9 = arg_258_1:FormatText(var_261_8.content)

				arg_258_1.text_.text = var_261_9

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_10 = 31
				local var_261_11 = utf8.len(var_261_9)
				local var_261_12 = var_261_10 <= 0 and var_261_6 or var_261_6 * (var_261_11 / var_261_10)

				if var_261_12 > 0 and var_261_6 < var_261_12 then
					arg_258_1.talkMaxDuration = var_261_12

					if var_261_12 + var_261_5 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_12 + var_261_5
					end
				end

				arg_258_1.text_.text = var_261_9
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611063", "story_v_out_325611.awb") ~= 0 then
					local var_261_13 = manager.audio:GetVoiceLength("story_v_out_325611", "325611063", "story_v_out_325611.awb") / 1000

					if var_261_13 + var_261_5 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_13 + var_261_5
					end

					if var_261_8.prefab_name ~= "" and arg_258_1.actors_[var_261_8.prefab_name] ~= nil then
						local var_261_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_8.prefab_name].transform, "story_v_out_325611", "325611063", "story_v_out_325611.awb")

						arg_258_1:RecordAudio("325611063", var_261_14)
						arg_258_1:RecordAudio("325611063", var_261_14)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_325611", "325611063", "story_v_out_325611.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_325611", "325611063", "story_v_out_325611.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_15 = math.max(var_261_6, arg_258_1.talkMaxDuration)

			if var_261_5 <= arg_258_1.time_ and arg_258_1.time_ < var_261_5 + var_261_15 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_5) / var_261_15

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_5 + var_261_15 and arg_258_1.time_ < var_261_5 + var_261_15 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play325611064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 325611064
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play325611065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1071ui_story"].transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.var_.moveOldPos1071ui_story = var_265_0.localPosition
			end

			local var_265_2 = 0.001

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2
				local var_265_4 = Vector3.New(0, 100, 0)

				var_265_0.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1071ui_story, var_265_4, var_265_3)

				local var_265_5 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_5.x, var_265_5.y, var_265_5.z)

				local var_265_6 = var_265_0.localEulerAngles

				var_265_6.z = 0
				var_265_6.x = 0
				var_265_0.localEulerAngles = var_265_6
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 then
				var_265_0.localPosition = Vector3.New(0, 100, 0)

				local var_265_7 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_7.x, var_265_7.y, var_265_7.z)

				local var_265_8 = var_265_0.localEulerAngles

				var_265_8.z = 0
				var_265_8.x = 0
				var_265_0.localEulerAngles = var_265_8
			end

			local var_265_9 = arg_262_1.actors_["10175ui_story"].transform
			local var_265_10 = 0

			if var_265_10 < arg_262_1.time_ and arg_262_1.time_ <= var_265_10 + arg_265_0 then
				arg_262_1.var_.moveOldPos10175ui_story = var_265_9.localPosition

				local var_265_11 = GameObjectTools.GetOrAddComponent(var_265_9.gameObject, typeof(DynamicBoneHelper))

				if var_265_11 then
					var_265_11:EnableDynamicBone(false)
				end
			end

			local var_265_12 = 0.001

			if var_265_10 <= arg_262_1.time_ and arg_262_1.time_ < var_265_10 + var_265_12 then
				local var_265_13 = (arg_262_1.time_ - var_265_10) / var_265_12
				local var_265_14 = Vector3.New(0, 100, 0)

				var_265_9.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos10175ui_story, var_265_14, var_265_13)

				local var_265_15 = manager.ui.mainCamera.transform.position - var_265_9.position

				var_265_9.forward = Vector3.New(var_265_15.x, var_265_15.y, var_265_15.z)

				local var_265_16 = var_265_9.localEulerAngles

				var_265_16.z = 0
				var_265_16.x = 0
				var_265_9.localEulerAngles = var_265_16
			end

			if arg_262_1.time_ >= var_265_10 + var_265_12 and arg_262_1.time_ < var_265_10 + var_265_12 + arg_265_0 then
				var_265_9.localPosition = Vector3.New(0, 100, 0)

				local var_265_17 = manager.ui.mainCamera.transform.position - var_265_9.position

				var_265_9.forward = Vector3.New(var_265_17.x, var_265_17.y, var_265_17.z)

				local var_265_18 = var_265_9.localEulerAngles

				var_265_18.z = 0
				var_265_18.x = 0
				var_265_9.localEulerAngles = var_265_18

				local var_265_19 = GameObjectTools.GetOrAddComponent(var_265_9.gameObject, typeof(DynamicBoneHelper))

				if var_265_19 then
					var_265_19:EnableDynamicBone(true)
				end
			end

			local var_265_20 = arg_262_1.actors_["1071ui_story"]
			local var_265_21 = 0

			if var_265_21 < arg_262_1.time_ and arg_262_1.time_ <= var_265_21 + arg_265_0 and not isNil(var_265_20) and arg_262_1.var_.characterEffect1071ui_story == nil then
				arg_262_1.var_.characterEffect1071ui_story = var_265_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_22 = 0.200000002980232

			if var_265_21 <= arg_262_1.time_ and arg_262_1.time_ < var_265_21 + var_265_22 and not isNil(var_265_20) then
				local var_265_23 = (arg_262_1.time_ - var_265_21) / var_265_22

				if arg_262_1.var_.characterEffect1071ui_story and not isNil(var_265_20) then
					local var_265_24 = Mathf.Lerp(0, 0.5, var_265_23)

					arg_262_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1071ui_story.fillRatio = var_265_24
				end
			end

			if arg_262_1.time_ >= var_265_21 + var_265_22 and arg_262_1.time_ < var_265_21 + var_265_22 + arg_265_0 and not isNil(var_265_20) and arg_262_1.var_.characterEffect1071ui_story then
				local var_265_25 = 0.5

				arg_262_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1071ui_story.fillRatio = var_265_25
			end

			local var_265_26 = 0
			local var_265_27 = 0.775

			if var_265_26 < arg_262_1.time_ and arg_262_1.time_ <= var_265_26 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_28 = arg_262_1:GetWordFromCfg(325611064)
				local var_265_29 = arg_262_1:FormatText(var_265_28.content)

				arg_262_1.text_.text = var_265_29

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_30 = 31
				local var_265_31 = utf8.len(var_265_29)
				local var_265_32 = var_265_30 <= 0 and var_265_27 or var_265_27 * (var_265_31 / var_265_30)

				if var_265_32 > 0 and var_265_27 < var_265_32 then
					arg_262_1.talkMaxDuration = var_265_32

					if var_265_32 + var_265_26 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_32 + var_265_26
					end
				end

				arg_262_1.text_.text = var_265_29
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_33 = math.max(var_265_27, arg_262_1.talkMaxDuration)

			if var_265_26 <= arg_262_1.time_ and arg_262_1.time_ < var_265_26 + var_265_33 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_26) / var_265_33

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_26 + var_265_33 and arg_262_1.time_ < var_265_26 + var_265_33 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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

		arg_262_1:InitPlayNodeList()
	end,
	Play325611065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 325611065
		arg_266_1.duration_ = 6.6

		local var_266_0 = {
			zh = 6.5,
			ja = 6.6
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play325611066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["10167ui_story"].transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.moveOldPos10167ui_story = var_269_0.localPosition

				local var_269_2 = GameObjectTools.GetOrAddComponent(var_269_0.gameObject, typeof(DynamicBoneHelper))

				if var_269_2 then
					var_269_2:EnableDynamicBone(false)
				end
			end

			local var_269_3 = 0.001

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_3 then
				local var_269_4 = (arg_266_1.time_ - var_269_1) / var_269_3
				local var_269_5 = Vector3.New(0, -1.28, -5.73)

				var_269_0.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos10167ui_story, var_269_5, var_269_4)

				local var_269_6 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_6.x, var_269_6.y, var_269_6.z)

				local var_269_7 = var_269_0.localEulerAngles

				var_269_7.z = 0
				var_269_7.x = 0
				var_269_0.localEulerAngles = var_269_7
			end

			if arg_266_1.time_ >= var_269_1 + var_269_3 and arg_266_1.time_ < var_269_1 + var_269_3 + arg_269_0 then
				var_269_0.localPosition = Vector3.New(0, -1.28, -5.73)

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

			local var_269_11 = arg_266_1.actors_["10167ui_story"]
			local var_269_12 = 0

			if var_269_12 < arg_266_1.time_ and arg_266_1.time_ <= var_269_12 + arg_269_0 and not isNil(var_269_11) and arg_266_1.var_.characterEffect10167ui_story == nil then
				arg_266_1.var_.characterEffect10167ui_story = var_269_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_13 = 0.200000002980232

			if var_269_12 <= arg_266_1.time_ and arg_266_1.time_ < var_269_12 + var_269_13 and not isNil(var_269_11) then
				local var_269_14 = (arg_266_1.time_ - var_269_12) / var_269_13

				if arg_266_1.var_.characterEffect10167ui_story and not isNil(var_269_11) then
					arg_266_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= var_269_12 + var_269_13 and arg_266_1.time_ < var_269_12 + var_269_13 + arg_269_0 and not isNil(var_269_11) and arg_266_1.var_.characterEffect10167ui_story then
				arg_266_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_269_15 = 0

			if var_269_15 < arg_266_1.time_ and arg_266_1.time_ <= var_269_15 + arg_269_0 then
				arg_266_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			local var_269_16 = 0

			if var_269_16 < arg_266_1.time_ and arg_266_1.time_ <= var_269_16 + arg_269_0 then
				arg_266_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_269_17 = 0
			local var_269_18 = 0.675

			if var_269_17 < arg_266_1.time_ and arg_266_1.time_ <= var_269_17 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_19 = arg_266_1:FormatText(StoryNameCfg[1447].name)

				arg_266_1.leftNameTxt_.text = var_269_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_20 = arg_266_1:GetWordFromCfg(325611065)
				local var_269_21 = arg_266_1:FormatText(var_269_20.content)

				arg_266_1.text_.text = var_269_21

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_22 = 27
				local var_269_23 = utf8.len(var_269_21)
				local var_269_24 = var_269_22 <= 0 and var_269_18 or var_269_18 * (var_269_23 / var_269_22)

				if var_269_24 > 0 and var_269_18 < var_269_24 then
					arg_266_1.talkMaxDuration = var_269_24

					if var_269_24 + var_269_17 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_24 + var_269_17
					end
				end

				arg_266_1.text_.text = var_269_21
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611065", "story_v_out_325611.awb") ~= 0 then
					local var_269_25 = manager.audio:GetVoiceLength("story_v_out_325611", "325611065", "story_v_out_325611.awb") / 1000

					if var_269_25 + var_269_17 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_25 + var_269_17
					end

					if var_269_20.prefab_name ~= "" and arg_266_1.actors_[var_269_20.prefab_name] ~= nil then
						local var_269_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_20.prefab_name].transform, "story_v_out_325611", "325611065", "story_v_out_325611.awb")

						arg_266_1:RecordAudio("325611065", var_269_26)
						arg_266_1:RecordAudio("325611065", var_269_26)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_325611", "325611065", "story_v_out_325611.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_325611", "325611065", "story_v_out_325611.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_27 = math.max(var_269_18, arg_266_1.talkMaxDuration)

			if var_269_17 <= arg_266_1.time_ and arg_266_1.time_ < var_269_17 + var_269_27 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_17) / var_269_27

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_17 + var_269_27 and arg_266_1.time_ < var_269_17 + var_269_27 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
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

		arg_266_1:InitPlayNodeList()
	end,
	Play325611066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 325611066
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play325611067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["10167ui_story"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect10167ui_story == nil then
				arg_270_1.var_.characterEffect10167ui_story = var_273_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.characterEffect10167ui_story and not isNil(var_273_0) then
					local var_273_4 = Mathf.Lerp(0, 0.5, var_273_3)

					arg_270_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_270_1.var_.characterEffect10167ui_story.fillRatio = var_273_4
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect10167ui_story then
				local var_273_5 = 0.5

				arg_270_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_270_1.var_.characterEffect10167ui_story.fillRatio = var_273_5
			end

			local var_273_6 = 0
			local var_273_7 = 0.55

			if var_273_6 < arg_270_1.time_ and arg_270_1.time_ <= var_273_6 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_8 = arg_270_1:FormatText(StoryNameCfg[7].name)

				arg_270_1.leftNameTxt_.text = var_273_8

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

				local var_273_9 = arg_270_1:GetWordFromCfg(325611066)
				local var_273_10 = arg_270_1:FormatText(var_273_9.content)

				arg_270_1.text_.text = var_273_10

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_11 = 22
				local var_273_12 = utf8.len(var_273_10)
				local var_273_13 = var_273_11 <= 0 and var_273_7 or var_273_7 * (var_273_12 / var_273_11)

				if var_273_13 > 0 and var_273_7 < var_273_13 then
					arg_270_1.talkMaxDuration = var_273_13

					if var_273_13 + var_273_6 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_13 + var_273_6
					end
				end

				arg_270_1.text_.text = var_273_10
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_14 = math.max(var_273_7, arg_270_1.talkMaxDuration)

			if var_273_6 <= arg_270_1.time_ and arg_270_1.time_ < var_273_6 + var_273_14 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_6) / var_273_14

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_6 + var_273_14 and arg_270_1.time_ < var_273_6 + var_273_14 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play325611067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 325611067
		arg_274_1.duration_ = 7.67

		local var_274_0 = {
			zh = 7.433,
			ja = 7.666
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play325611068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["10167ui_story"]
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect10167ui_story == nil then
				arg_274_1.var_.characterEffect10167ui_story = var_277_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 and not isNil(var_277_0) then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2

				if arg_274_1.var_.characterEffect10167ui_story and not isNil(var_277_0) then
					arg_274_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect10167ui_story then
				arg_274_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_277_4 = 0

			if var_277_4 < arg_274_1.time_ and arg_274_1.time_ <= var_277_4 + arg_277_0 then
				arg_274_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action3_1")
			end

			local var_277_5 = 0

			if var_277_5 < arg_274_1.time_ and arg_274_1.time_ <= var_277_5 + arg_277_0 then
				arg_274_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_277_6 = 0
			local var_277_7 = 0.725

			if var_277_6 < arg_274_1.time_ and arg_274_1.time_ <= var_277_6 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_8 = arg_274_1:FormatText(StoryNameCfg[1447].name)

				arg_274_1.leftNameTxt_.text = var_277_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_9 = arg_274_1:GetWordFromCfg(325611067)
				local var_277_10 = arg_274_1:FormatText(var_277_9.content)

				arg_274_1.text_.text = var_277_10

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_11 = 29
				local var_277_12 = utf8.len(var_277_10)
				local var_277_13 = var_277_11 <= 0 and var_277_7 or var_277_7 * (var_277_12 / var_277_11)

				if var_277_13 > 0 and var_277_7 < var_277_13 then
					arg_274_1.talkMaxDuration = var_277_13

					if var_277_13 + var_277_6 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_13 + var_277_6
					end
				end

				arg_274_1.text_.text = var_277_10
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611067", "story_v_out_325611.awb") ~= 0 then
					local var_277_14 = manager.audio:GetVoiceLength("story_v_out_325611", "325611067", "story_v_out_325611.awb") / 1000

					if var_277_14 + var_277_6 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_14 + var_277_6
					end

					if var_277_9.prefab_name ~= "" and arg_274_1.actors_[var_277_9.prefab_name] ~= nil then
						local var_277_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_9.prefab_name].transform, "story_v_out_325611", "325611067", "story_v_out_325611.awb")

						arg_274_1:RecordAudio("325611067", var_277_15)
						arg_274_1:RecordAudio("325611067", var_277_15)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_325611", "325611067", "story_v_out_325611.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_325611", "325611067", "story_v_out_325611.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_16 = math.max(var_277_7, arg_274_1.talkMaxDuration)

			if var_277_6 <= arg_274_1.time_ and arg_274_1.time_ < var_277_6 + var_277_16 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_6) / var_277_16

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_6 + var_277_16 and arg_274_1.time_ < var_277_6 + var_277_16 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play325611068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 325611068
		arg_278_1.duration_ = 13.6

		local var_278_0 = {
			zh = 10.233,
			ja = 13.6
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play325611069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 1.125

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_2 = arg_278_1:FormatText(StoryNameCfg[1447].name)

				arg_278_1.leftNameTxt_.text = var_281_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_3 = arg_278_1:GetWordFromCfg(325611068)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 45
				local var_281_6 = utf8.len(var_281_4)
				local var_281_7 = var_281_5 <= 0 and var_281_1 or var_281_1 * (var_281_6 / var_281_5)

				if var_281_7 > 0 and var_281_1 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7

					if var_281_7 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_4
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611068", "story_v_out_325611.awb") ~= 0 then
					local var_281_8 = manager.audio:GetVoiceLength("story_v_out_325611", "325611068", "story_v_out_325611.awb") / 1000

					if var_281_8 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_8 + var_281_0
					end

					if var_281_3.prefab_name ~= "" and arg_278_1.actors_[var_281_3.prefab_name] ~= nil then
						local var_281_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_3.prefab_name].transform, "story_v_out_325611", "325611068", "story_v_out_325611.awb")

						arg_278_1:RecordAudio("325611068", var_281_9)
						arg_278_1:RecordAudio("325611068", var_281_9)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_325611", "325611068", "story_v_out_325611.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_325611", "325611068", "story_v_out_325611.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_10 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_10 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_10

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_10 and arg_278_1.time_ < var_281_0 + var_281_10 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play325611069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 325611069
		arg_282_1.duration_ = 8.13

		local var_282_0 = {
			zh = 4.333,
			ja = 8.133
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play325611070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["10167ui_story"].transform
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.var_.moveOldPos10167ui_story = var_285_0.localPosition

				local var_285_2 = GameObjectTools.GetOrAddComponent(var_285_0.gameObject, typeof(DynamicBoneHelper))

				if var_285_2 then
					var_285_2:EnableDynamicBone(false)
				end
			end

			local var_285_3 = 0.001

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_3 then
				local var_285_4 = (arg_282_1.time_ - var_285_1) / var_285_3
				local var_285_5 = Vector3.New(-0.96, -1.28, -5.73)

				var_285_0.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos10167ui_story, var_285_5, var_285_4)

				local var_285_6 = manager.ui.mainCamera.transform.position - var_285_0.position

				var_285_0.forward = Vector3.New(var_285_6.x, var_285_6.y, var_285_6.z)

				local var_285_7 = var_285_0.localEulerAngles

				var_285_7.z = 0
				var_285_7.x = 0
				var_285_0.localEulerAngles = var_285_7
			end

			if arg_282_1.time_ >= var_285_1 + var_285_3 and arg_282_1.time_ < var_285_1 + var_285_3 + arg_285_0 then
				var_285_0.localPosition = Vector3.New(-0.96, -1.28, -5.73)

				local var_285_8 = manager.ui.mainCamera.transform.position - var_285_0.position

				var_285_0.forward = Vector3.New(var_285_8.x, var_285_8.y, var_285_8.z)

				local var_285_9 = var_285_0.localEulerAngles

				var_285_9.z = 0
				var_285_9.x = 0
				var_285_0.localEulerAngles = var_285_9

				local var_285_10 = GameObjectTools.GetOrAddComponent(var_285_0.gameObject, typeof(DynamicBoneHelper))

				if var_285_10 then
					var_285_10:EnableDynamicBone(true)
				end
			end

			local var_285_11 = arg_282_1.actors_["10175ui_story"].transform
			local var_285_12 = 0

			if var_285_12 < arg_282_1.time_ and arg_282_1.time_ <= var_285_12 + arg_285_0 then
				arg_282_1.var_.moveOldPos10175ui_story = var_285_11.localPosition

				local var_285_13 = GameObjectTools.GetOrAddComponent(var_285_11.gameObject, typeof(DynamicBoneHelper))

				if var_285_13 then
					var_285_13:EnableDynamicBone(false)
				end
			end

			local var_285_14 = 0.001

			if var_285_12 <= arg_282_1.time_ and arg_282_1.time_ < var_285_12 + var_285_14 then
				local var_285_15 = (arg_282_1.time_ - var_285_12) / var_285_14
				local var_285_16 = Vector3.New(0.7, -1, -6.05)

				var_285_11.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos10175ui_story, var_285_16, var_285_15)

				local var_285_17 = manager.ui.mainCamera.transform.position - var_285_11.position

				var_285_11.forward = Vector3.New(var_285_17.x, var_285_17.y, var_285_17.z)

				local var_285_18 = var_285_11.localEulerAngles

				var_285_18.z = 0
				var_285_18.x = 0
				var_285_11.localEulerAngles = var_285_18
			end

			if arg_282_1.time_ >= var_285_12 + var_285_14 and arg_282_1.time_ < var_285_12 + var_285_14 + arg_285_0 then
				var_285_11.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_285_19 = manager.ui.mainCamera.transform.position - var_285_11.position

				var_285_11.forward = Vector3.New(var_285_19.x, var_285_19.y, var_285_19.z)

				local var_285_20 = var_285_11.localEulerAngles

				var_285_20.z = 0
				var_285_20.x = 0
				var_285_11.localEulerAngles = var_285_20

				local var_285_21 = GameObjectTools.GetOrAddComponent(var_285_11.gameObject, typeof(DynamicBoneHelper))

				if var_285_21 then
					var_285_21:EnableDynamicBone(true)
				end
			end

			local var_285_22 = arg_282_1.actors_["10175ui_story"]
			local var_285_23 = 0

			if var_285_23 < arg_282_1.time_ and arg_282_1.time_ <= var_285_23 + arg_285_0 and not isNil(var_285_22) and arg_282_1.var_.characterEffect10175ui_story == nil then
				arg_282_1.var_.characterEffect10175ui_story = var_285_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_24 = 0.200000002980232

			if var_285_23 <= arg_282_1.time_ and arg_282_1.time_ < var_285_23 + var_285_24 and not isNil(var_285_22) then
				local var_285_25 = (arg_282_1.time_ - var_285_23) / var_285_24

				if arg_282_1.var_.characterEffect10175ui_story and not isNil(var_285_22) then
					arg_282_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= var_285_23 + var_285_24 and arg_282_1.time_ < var_285_23 + var_285_24 + arg_285_0 and not isNil(var_285_22) and arg_282_1.var_.characterEffect10175ui_story then
				arg_282_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_285_26 = arg_282_1.actors_["10167ui_story"]
			local var_285_27 = 0

			if var_285_27 < arg_282_1.time_ and arg_282_1.time_ <= var_285_27 + arg_285_0 and not isNil(var_285_26) and arg_282_1.var_.characterEffect10167ui_story == nil then
				arg_282_1.var_.characterEffect10167ui_story = var_285_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_28 = 0.200000002980232

			if var_285_27 <= arg_282_1.time_ and arg_282_1.time_ < var_285_27 + var_285_28 and not isNil(var_285_26) then
				local var_285_29 = (arg_282_1.time_ - var_285_27) / var_285_28

				if arg_282_1.var_.characterEffect10167ui_story and not isNil(var_285_26) then
					local var_285_30 = Mathf.Lerp(0, 0.5, var_285_29)

					arg_282_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_282_1.var_.characterEffect10167ui_story.fillRatio = var_285_30
				end
			end

			if arg_282_1.time_ >= var_285_27 + var_285_28 and arg_282_1.time_ < var_285_27 + var_285_28 + arg_285_0 and not isNil(var_285_26) and arg_282_1.var_.characterEffect10167ui_story then
				local var_285_31 = 0.5

				arg_282_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_282_1.var_.characterEffect10167ui_story.fillRatio = var_285_31
			end

			local var_285_32 = 0

			if var_285_32 < arg_282_1.time_ and arg_282_1.time_ <= var_285_32 + arg_285_0 then
				arg_282_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action2_1")
			end

			local var_285_33 = 0

			if var_285_33 < arg_282_1.time_ and arg_282_1.time_ <= var_285_33 + arg_285_0 then
				arg_282_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_285_34 = 0
			local var_285_35 = 0.45

			if var_285_34 < arg_282_1.time_ and arg_282_1.time_ <= var_285_34 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_36 = arg_282_1:FormatText(StoryNameCfg[1473].name)

				arg_282_1.leftNameTxt_.text = var_285_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_37 = arg_282_1:GetWordFromCfg(325611069)
				local var_285_38 = arg_282_1:FormatText(var_285_37.content)

				arg_282_1.text_.text = var_285_38

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_39 = 18
				local var_285_40 = utf8.len(var_285_38)
				local var_285_41 = var_285_39 <= 0 and var_285_35 or var_285_35 * (var_285_40 / var_285_39)

				if var_285_41 > 0 and var_285_35 < var_285_41 then
					arg_282_1.talkMaxDuration = var_285_41

					if var_285_41 + var_285_34 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_41 + var_285_34
					end
				end

				arg_282_1.text_.text = var_285_38
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611069", "story_v_out_325611.awb") ~= 0 then
					local var_285_42 = manager.audio:GetVoiceLength("story_v_out_325611", "325611069", "story_v_out_325611.awb") / 1000

					if var_285_42 + var_285_34 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_42 + var_285_34
					end

					if var_285_37.prefab_name ~= "" and arg_282_1.actors_[var_285_37.prefab_name] ~= nil then
						local var_285_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_37.prefab_name].transform, "story_v_out_325611", "325611069", "story_v_out_325611.awb")

						arg_282_1:RecordAudio("325611069", var_285_43)
						arg_282_1:RecordAudio("325611069", var_285_43)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_325611", "325611069", "story_v_out_325611.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_325611", "325611069", "story_v_out_325611.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_44 = math.max(var_285_35, arg_282_1.talkMaxDuration)

			if var_285_34 <= arg_282_1.time_ and arg_282_1.time_ < var_285_34 + var_285_44 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_34) / var_285_44

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_34 + var_285_44 and arg_282_1.time_ < var_285_34 + var_285_44 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
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

		arg_282_1:InitPlayNodeList()
	end,
	Play325611070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 325611070
		arg_286_1.duration_ = 4.23

		local var_286_0 = {
			zh = 4.1,
			ja = 4.233
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play325611071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["10175ui_story"].transform
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.var_.moveOldPos10175ui_story = var_289_0.localPosition

				local var_289_2 = GameObjectTools.GetOrAddComponent(var_289_0.gameObject, typeof(DynamicBoneHelper))

				if var_289_2 then
					var_289_2:EnableDynamicBone(false)
				end
			end

			local var_289_3 = 0.001

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_3 then
				local var_289_4 = (arg_286_1.time_ - var_289_1) / var_289_3
				local var_289_5 = Vector3.New(0, 100, 0)

				var_289_0.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos10175ui_story, var_289_5, var_289_4)

				local var_289_6 = manager.ui.mainCamera.transform.position - var_289_0.position

				var_289_0.forward = Vector3.New(var_289_6.x, var_289_6.y, var_289_6.z)

				local var_289_7 = var_289_0.localEulerAngles

				var_289_7.z = 0
				var_289_7.x = 0
				var_289_0.localEulerAngles = var_289_7
			end

			if arg_286_1.time_ >= var_289_1 + var_289_3 and arg_286_1.time_ < var_289_1 + var_289_3 + arg_289_0 then
				var_289_0.localPosition = Vector3.New(0, 100, 0)

				local var_289_8 = manager.ui.mainCamera.transform.position - var_289_0.position

				var_289_0.forward = Vector3.New(var_289_8.x, var_289_8.y, var_289_8.z)

				local var_289_9 = var_289_0.localEulerAngles

				var_289_9.z = 0
				var_289_9.x = 0
				var_289_0.localEulerAngles = var_289_9

				local var_289_10 = GameObjectTools.GetOrAddComponent(var_289_0.gameObject, typeof(DynamicBoneHelper))

				if var_289_10 then
					var_289_10:EnableDynamicBone(true)
				end
			end

			local var_289_11 = arg_286_1.actors_["6148ui_story"].transform
			local var_289_12 = 0

			if var_289_12 < arg_286_1.time_ and arg_286_1.time_ <= var_289_12 + arg_289_0 then
				arg_286_1.var_.moveOldPos6148ui_story = var_289_11.localPosition

				local var_289_13 = GameObjectTools.GetOrAddComponent(var_289_11.gameObject, typeof(DynamicBoneHelper))

				if var_289_13 then
					var_289_13:EnableDynamicBone(false)
				end
			end

			local var_289_14 = 0.001

			if var_289_12 <= arg_286_1.time_ and arg_286_1.time_ < var_289_12 + var_289_14 then
				local var_289_15 = (arg_286_1.time_ - var_289_12) / var_289_14
				local var_289_16 = Vector3.New(0, -0.985, -6)

				var_289_11.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos6148ui_story, var_289_16, var_289_15)

				local var_289_17 = manager.ui.mainCamera.transform.position - var_289_11.position

				var_289_11.forward = Vector3.New(var_289_17.x, var_289_17.y, var_289_17.z)

				local var_289_18 = var_289_11.localEulerAngles

				var_289_18.z = 0
				var_289_18.x = 0
				var_289_11.localEulerAngles = var_289_18
			end

			if arg_286_1.time_ >= var_289_12 + var_289_14 and arg_286_1.time_ < var_289_12 + var_289_14 + arg_289_0 then
				var_289_11.localPosition = Vector3.New(0, -0.985, -6)

				local var_289_19 = manager.ui.mainCamera.transform.position - var_289_11.position

				var_289_11.forward = Vector3.New(var_289_19.x, var_289_19.y, var_289_19.z)

				local var_289_20 = var_289_11.localEulerAngles

				var_289_20.z = 0
				var_289_20.x = 0
				var_289_11.localEulerAngles = var_289_20

				local var_289_21 = GameObjectTools.GetOrAddComponent(var_289_11.gameObject, typeof(DynamicBoneHelper))

				if var_289_21 then
					var_289_21:EnableDynamicBone(true)
				end
			end

			local var_289_22 = arg_286_1.actors_["10167ui_story"].transform
			local var_289_23 = 0

			if var_289_23 < arg_286_1.time_ and arg_286_1.time_ <= var_289_23 + arg_289_0 then
				arg_286_1.var_.moveOldPos10167ui_story = var_289_22.localPosition

				local var_289_24 = GameObjectTools.GetOrAddComponent(var_289_22.gameObject, typeof(DynamicBoneHelper))

				if var_289_24 then
					var_289_24:EnableDynamicBone(false)
				end
			end

			local var_289_25 = 0.001

			if var_289_23 <= arg_286_1.time_ and arg_286_1.time_ < var_289_23 + var_289_25 then
				local var_289_26 = (arg_286_1.time_ - var_289_23) / var_289_25
				local var_289_27 = Vector3.New(0, 100, 0)

				var_289_22.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos10167ui_story, var_289_27, var_289_26)

				local var_289_28 = manager.ui.mainCamera.transform.position - var_289_22.position

				var_289_22.forward = Vector3.New(var_289_28.x, var_289_28.y, var_289_28.z)

				local var_289_29 = var_289_22.localEulerAngles

				var_289_29.z = 0
				var_289_29.x = 0
				var_289_22.localEulerAngles = var_289_29
			end

			if arg_286_1.time_ >= var_289_23 + var_289_25 and arg_286_1.time_ < var_289_23 + var_289_25 + arg_289_0 then
				var_289_22.localPosition = Vector3.New(0, 100, 0)

				local var_289_30 = manager.ui.mainCamera.transform.position - var_289_22.position

				var_289_22.forward = Vector3.New(var_289_30.x, var_289_30.y, var_289_30.z)

				local var_289_31 = var_289_22.localEulerAngles

				var_289_31.z = 0
				var_289_31.x = 0
				var_289_22.localEulerAngles = var_289_31

				local var_289_32 = GameObjectTools.GetOrAddComponent(var_289_22.gameObject, typeof(DynamicBoneHelper))

				if var_289_32 then
					var_289_32:EnableDynamicBone(true)
				end
			end

			local var_289_33 = arg_286_1.actors_["6148ui_story"]
			local var_289_34 = 0

			if var_289_34 < arg_286_1.time_ and arg_286_1.time_ <= var_289_34 + arg_289_0 and not isNil(var_289_33) and arg_286_1.var_.characterEffect6148ui_story == nil then
				arg_286_1.var_.characterEffect6148ui_story = var_289_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_35 = 0.200000002980232

			if var_289_34 <= arg_286_1.time_ and arg_286_1.time_ < var_289_34 + var_289_35 and not isNil(var_289_33) then
				local var_289_36 = (arg_286_1.time_ - var_289_34) / var_289_35

				if arg_286_1.var_.characterEffect6148ui_story and not isNil(var_289_33) then
					arg_286_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= var_289_34 + var_289_35 and arg_286_1.time_ < var_289_34 + var_289_35 + arg_289_0 and not isNil(var_289_33) and arg_286_1.var_.characterEffect6148ui_story then
				arg_286_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_289_37 = arg_286_1.actors_["10175ui_story"]
			local var_289_38 = 0

			if var_289_38 < arg_286_1.time_ and arg_286_1.time_ <= var_289_38 + arg_289_0 and not isNil(var_289_37) and arg_286_1.var_.characterEffect10175ui_story == nil then
				arg_286_1.var_.characterEffect10175ui_story = var_289_37:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_39 = 0.200000002980232

			if var_289_38 <= arg_286_1.time_ and arg_286_1.time_ < var_289_38 + var_289_39 and not isNil(var_289_37) then
				local var_289_40 = (arg_286_1.time_ - var_289_38) / var_289_39

				if arg_286_1.var_.characterEffect10175ui_story and not isNil(var_289_37) then
					local var_289_41 = Mathf.Lerp(0, 0.5, var_289_40)

					arg_286_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_286_1.var_.characterEffect10175ui_story.fillRatio = var_289_41
				end
			end

			if arg_286_1.time_ >= var_289_38 + var_289_39 and arg_286_1.time_ < var_289_38 + var_289_39 + arg_289_0 and not isNil(var_289_37) and arg_286_1.var_.characterEffect10175ui_story then
				local var_289_42 = 0.5

				arg_286_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_286_1.var_.characterEffect10175ui_story.fillRatio = var_289_42
			end

			local var_289_43 = 0

			if var_289_43 < arg_286_1.time_ and arg_286_1.time_ <= var_289_43 + arg_289_0 then
				arg_286_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_289_44 = 0

			if var_289_44 < arg_286_1.time_ and arg_286_1.time_ <= var_289_44 + arg_289_0 then
				arg_286_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_289_45 = 0
			local var_289_46 = 0.475

			if var_289_45 < arg_286_1.time_ and arg_286_1.time_ <= var_289_45 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_47 = arg_286_1:FormatText(StoryNameCfg[1488].name)

				arg_286_1.leftNameTxt_.text = var_289_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_48 = arg_286_1:GetWordFromCfg(325611070)
				local var_289_49 = arg_286_1:FormatText(var_289_48.content)

				arg_286_1.text_.text = var_289_49

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_50 = 19
				local var_289_51 = utf8.len(var_289_49)
				local var_289_52 = var_289_50 <= 0 and var_289_46 or var_289_46 * (var_289_51 / var_289_50)

				if var_289_52 > 0 and var_289_46 < var_289_52 then
					arg_286_1.talkMaxDuration = var_289_52

					if var_289_52 + var_289_45 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_52 + var_289_45
					end
				end

				arg_286_1.text_.text = var_289_49
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611070", "story_v_out_325611.awb") ~= 0 then
					local var_289_53 = manager.audio:GetVoiceLength("story_v_out_325611", "325611070", "story_v_out_325611.awb") / 1000

					if var_289_53 + var_289_45 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_53 + var_289_45
					end

					if var_289_48.prefab_name ~= "" and arg_286_1.actors_[var_289_48.prefab_name] ~= nil then
						local var_289_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_48.prefab_name].transform, "story_v_out_325611", "325611070", "story_v_out_325611.awb")

						arg_286_1:RecordAudio("325611070", var_289_54)
						arg_286_1:RecordAudio("325611070", var_289_54)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_325611", "325611070", "story_v_out_325611.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_325611", "325611070", "story_v_out_325611.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_55 = math.max(var_289_46, arg_286_1.talkMaxDuration)

			if var_289_45 <= arg_286_1.time_ and arg_286_1.time_ < var_289_45 + var_289_55 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_45) / var_289_55

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_45 + var_289_55 and arg_286_1.time_ < var_289_45 + var_289_55 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
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
				actorName = "6148ui_story",
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

		arg_286_1:InitPlayNodeList()
	end,
	Play325611071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 325611071
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play325611072(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["6148ui_story"]
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect6148ui_story == nil then
				arg_290_1.var_.characterEffect6148ui_story = var_293_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_2 = 0.200000002980232

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 and not isNil(var_293_0) then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2

				if arg_290_1.var_.characterEffect6148ui_story and not isNil(var_293_0) then
					local var_293_4 = Mathf.Lerp(0, 0.5, var_293_3)

					arg_290_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_290_1.var_.characterEffect6148ui_story.fillRatio = var_293_4
				end
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect6148ui_story then
				local var_293_5 = 0.5

				arg_290_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_290_1.var_.characterEffect6148ui_story.fillRatio = var_293_5
			end

			local var_293_6 = 0
			local var_293_7 = 0.575

			if var_293_6 < arg_290_1.time_ and arg_290_1.time_ <= var_293_6 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_8 = arg_290_1:FormatText(StoryNameCfg[7].name)

				arg_290_1.leftNameTxt_.text = var_293_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_9 = arg_290_1:GetWordFromCfg(325611071)
				local var_293_10 = arg_290_1:FormatText(var_293_9.content)

				arg_290_1.text_.text = var_293_10

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_11 = 23
				local var_293_12 = utf8.len(var_293_10)
				local var_293_13 = var_293_11 <= 0 and var_293_7 or var_293_7 * (var_293_12 / var_293_11)

				if var_293_13 > 0 and var_293_7 < var_293_13 then
					arg_290_1.talkMaxDuration = var_293_13

					if var_293_13 + var_293_6 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_13 + var_293_6
					end
				end

				arg_290_1.text_.text = var_293_10
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_14 = math.max(var_293_7, arg_290_1.talkMaxDuration)

			if var_293_6 <= arg_290_1.time_ and arg_290_1.time_ < var_293_6 + var_293_14 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_6) / var_293_14

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_6 + var_293_14 and arg_290_1.time_ < var_293_6 + var_293_14 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play325611072 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 325611072
		arg_294_1.duration_ = 5.63

		local var_294_0 = {
			zh = 3.433,
			ja = 5.633
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play325611073(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["1071ui_story"].transform
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.var_.moveOldPos1071ui_story = var_297_0.localPosition
			end

			local var_297_2 = 0.001

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2
				local var_297_4 = Vector3.New(0.7, -1.05, -6.2)

				var_297_0.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1071ui_story, var_297_4, var_297_3)

				local var_297_5 = manager.ui.mainCamera.transform.position - var_297_0.position

				var_297_0.forward = Vector3.New(var_297_5.x, var_297_5.y, var_297_5.z)

				local var_297_6 = var_297_0.localEulerAngles

				var_297_6.z = 0
				var_297_6.x = 0
				var_297_0.localEulerAngles = var_297_6
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 then
				var_297_0.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_297_7 = manager.ui.mainCamera.transform.position - var_297_0.position

				var_297_0.forward = Vector3.New(var_297_7.x, var_297_7.y, var_297_7.z)

				local var_297_8 = var_297_0.localEulerAngles

				var_297_8.z = 0
				var_297_8.x = 0
				var_297_0.localEulerAngles = var_297_8
			end

			local var_297_9 = arg_294_1.actors_["6148ui_story"].transform
			local var_297_10 = 0

			if var_297_10 < arg_294_1.time_ and arg_294_1.time_ <= var_297_10 + arg_297_0 then
				arg_294_1.var_.moveOldPos6148ui_story = var_297_9.localPosition

				local var_297_11 = GameObjectTools.GetOrAddComponent(var_297_9.gameObject, typeof(DynamicBoneHelper))

				if var_297_11 then
					var_297_11:EnableDynamicBone(false)
				end
			end

			local var_297_12 = 0.001

			if var_297_10 <= arg_294_1.time_ and arg_294_1.time_ < var_297_10 + var_297_12 then
				local var_297_13 = (arg_294_1.time_ - var_297_10) / var_297_12
				local var_297_14 = Vector3.New(-0.7, -0.985, -6)

				var_297_9.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos6148ui_story, var_297_14, var_297_13)

				local var_297_15 = manager.ui.mainCamera.transform.position - var_297_9.position

				var_297_9.forward = Vector3.New(var_297_15.x, var_297_15.y, var_297_15.z)

				local var_297_16 = var_297_9.localEulerAngles

				var_297_16.z = 0
				var_297_16.x = 0
				var_297_9.localEulerAngles = var_297_16
			end

			if arg_294_1.time_ >= var_297_10 + var_297_12 and arg_294_1.time_ < var_297_10 + var_297_12 + arg_297_0 then
				var_297_9.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_297_17 = manager.ui.mainCamera.transform.position - var_297_9.position

				var_297_9.forward = Vector3.New(var_297_17.x, var_297_17.y, var_297_17.z)

				local var_297_18 = var_297_9.localEulerAngles

				var_297_18.z = 0
				var_297_18.x = 0
				var_297_9.localEulerAngles = var_297_18

				local var_297_19 = GameObjectTools.GetOrAddComponent(var_297_9.gameObject, typeof(DynamicBoneHelper))

				if var_297_19 then
					var_297_19:EnableDynamicBone(true)
				end
			end

			local var_297_20 = arg_294_1.actors_["1071ui_story"]
			local var_297_21 = 0

			if var_297_21 < arg_294_1.time_ and arg_294_1.time_ <= var_297_21 + arg_297_0 and not isNil(var_297_20) and arg_294_1.var_.characterEffect1071ui_story == nil then
				arg_294_1.var_.characterEffect1071ui_story = var_297_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_22 = 0.200000002980232

			if var_297_21 <= arg_294_1.time_ and arg_294_1.time_ < var_297_21 + var_297_22 and not isNil(var_297_20) then
				local var_297_23 = (arg_294_1.time_ - var_297_21) / var_297_22

				if arg_294_1.var_.characterEffect1071ui_story and not isNil(var_297_20) then
					arg_294_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= var_297_21 + var_297_22 and arg_294_1.time_ < var_297_21 + var_297_22 + arg_297_0 and not isNil(var_297_20) and arg_294_1.var_.characterEffect1071ui_story then
				arg_294_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_297_24 = 0

			if var_297_24 < arg_294_1.time_ and arg_294_1.time_ <= var_297_24 + arg_297_0 then
				arg_294_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_297_25 = 0
			local var_297_26 = 0.275

			if var_297_25 < arg_294_1.time_ and arg_294_1.time_ <= var_297_25 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_27 = arg_294_1:FormatText(StoryNameCfg[384].name)

				arg_294_1.leftNameTxt_.text = var_297_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_28 = arg_294_1:GetWordFromCfg(325611072)
				local var_297_29 = arg_294_1:FormatText(var_297_28.content)

				arg_294_1.text_.text = var_297_29

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_30 = 11
				local var_297_31 = utf8.len(var_297_29)
				local var_297_32 = var_297_30 <= 0 and var_297_26 or var_297_26 * (var_297_31 / var_297_30)

				if var_297_32 > 0 and var_297_26 < var_297_32 then
					arg_294_1.talkMaxDuration = var_297_32

					if var_297_32 + var_297_25 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_32 + var_297_25
					end
				end

				arg_294_1.text_.text = var_297_29
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611072", "story_v_out_325611.awb") ~= 0 then
					local var_297_33 = manager.audio:GetVoiceLength("story_v_out_325611", "325611072", "story_v_out_325611.awb") / 1000

					if var_297_33 + var_297_25 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_33 + var_297_25
					end

					if var_297_28.prefab_name ~= "" and arg_294_1.actors_[var_297_28.prefab_name] ~= nil then
						local var_297_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_28.prefab_name].transform, "story_v_out_325611", "325611072", "story_v_out_325611.awb")

						arg_294_1:RecordAudio("325611072", var_297_34)
						arg_294_1:RecordAudio("325611072", var_297_34)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_325611", "325611072", "story_v_out_325611.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_325611", "325611072", "story_v_out_325611.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_35 = math.max(var_297_26, arg_294_1.talkMaxDuration)

			if var_297_25 <= arg_294_1.time_ and arg_294_1.time_ < var_297_25 + var_297_35 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_25) / var_297_35

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_25 + var_297_35 and arg_294_1.time_ < var_297_25 + var_297_35 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play325611073 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 325611073
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play325611074(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["1071ui_story"]
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.characterEffect1071ui_story == nil then
				arg_298_1.var_.characterEffect1071ui_story = var_301_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_2 = 0.200000002980232

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 and not isNil(var_301_0) then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2

				if arg_298_1.var_.characterEffect1071ui_story and not isNil(var_301_0) then
					local var_301_4 = Mathf.Lerp(0, 0.5, var_301_3)

					arg_298_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_298_1.var_.characterEffect1071ui_story.fillRatio = var_301_4
				end
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.characterEffect1071ui_story then
				local var_301_5 = 0.5

				arg_298_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_298_1.var_.characterEffect1071ui_story.fillRatio = var_301_5
			end

			local var_301_6 = 0
			local var_301_7 = 0.6

			if var_301_6 < arg_298_1.time_ and arg_298_1.time_ <= var_301_6 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_8 = arg_298_1:FormatText(StoryNameCfg[7].name)

				arg_298_1.leftNameTxt_.text = var_301_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_9 = arg_298_1:GetWordFromCfg(325611073)
				local var_301_10 = arg_298_1:FormatText(var_301_9.content)

				arg_298_1.text_.text = var_301_10

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_11 = 24
				local var_301_12 = utf8.len(var_301_10)
				local var_301_13 = var_301_11 <= 0 and var_301_7 or var_301_7 * (var_301_12 / var_301_11)

				if var_301_13 > 0 and var_301_7 < var_301_13 then
					arg_298_1.talkMaxDuration = var_301_13

					if var_301_13 + var_301_6 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_13 + var_301_6
					end
				end

				arg_298_1.text_.text = var_301_10
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_14 = math.max(var_301_7, arg_298_1.talkMaxDuration)

			if var_301_6 <= arg_298_1.time_ and arg_298_1.time_ < var_301_6 + var_301_14 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_6) / var_301_14

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_6 + var_301_14 and arg_298_1.time_ < var_301_6 + var_301_14 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play325611074 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 325611074
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
			arg_302_1.auto_ = false
		end

		function arg_302_1.playNext_(arg_304_0)
			arg_302_1.onStoryFinished_()
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0
			local var_305_1 = 1

			if var_305_0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_0 + arg_305_0 then
				local var_305_2 = "play"
				local var_305_3 = "effect"

				arg_302_1:AudioAction(var_305_2, var_305_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_305_4 = 0
			local var_305_5 = 0.425

			if var_305_4 < arg_302_1.time_ and arg_302_1.time_ <= var_305_4 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_6 = arg_302_1:FormatText(StoryNameCfg[7].name)

				arg_302_1.leftNameTxt_.text = var_305_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_7 = arg_302_1:GetWordFromCfg(325611074)
				local var_305_8 = arg_302_1:FormatText(var_305_7.content)

				arg_302_1.text_.text = var_305_8

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_9 = 17
				local var_305_10 = utf8.len(var_305_8)
				local var_305_11 = var_305_9 <= 0 and var_305_5 or var_305_5 * (var_305_10 / var_305_9)

				if var_305_11 > 0 and var_305_5 < var_305_11 then
					arg_302_1.talkMaxDuration = var_305_11

					if var_305_11 + var_305_4 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_11 + var_305_4
					end
				end

				arg_302_1.text_.text = var_305_8
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_12 = math.max(var_305_5, arg_302_1.talkMaxDuration)

			if var_305_4 <= arg_302_1.time_ and arg_302_1.time_ < var_305_4 + var_305_12 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_4) / var_305_12

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_4 + var_305_12 and arg_302_1.time_ < var_305_4 + var_305_12 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J26h",
		"TextureConfig/Background/J21h"
	},
	voices = {
		"story_v_out_325611.awb"
	}
}
