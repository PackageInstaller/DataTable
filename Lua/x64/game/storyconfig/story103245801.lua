return {
	Play324581001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324581001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324581002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J21h"

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
				local var_4_5 = arg_1_1.bgs_.J21h

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
					if iter_4_0 ~= "J21h" then
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
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_32 = 1
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet")

				if var_4_37 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_37 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_37

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_37
						arg_1_1.bgmTxt2_.text = var_4_37
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

			local var_4_38 = 2
			local var_4_39 = 1.025

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_41 = arg_1_1:GetWordFromCfg(324581001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 41
				local var_4_44 = utf8.len(var_4_42)
				local var_4_45 = var_4_43 <= 0 and var_4_39 or var_4_39 * (var_4_44 / var_4_43)

				if var_4_45 > 0 and var_4_39 < var_4_45 then
					arg_1_1.talkMaxDuration = var_4_45
					var_4_38 = var_4_38 + 0.3

					if var_4_45 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_42
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_46 = var_4_38 + 0.3
			local var_4_47 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_46) / var_4_47

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play324581002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324581002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324581003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.225

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

				local var_11_2 = arg_8_1:GetWordFromCfg(324581002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 49
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
	Play324581003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324581003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324581004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.425

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[7].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(324581003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 17
				local var_15_6 = utf8.len(var_15_4)
				local var_15_7 = var_15_5 <= 0 and var_15_1 or var_15_1 * (var_15_6 / var_15_5)

				if var_15_7 > 0 and var_15_1 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_8 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_8 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_8

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_8 and arg_12_1.time_ < var_15_0 + var_15_8 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324581004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324581004
		arg_16_1.duration_ = 2.77

		local var_16_0 = {
			zh = 2.766,
			ja = 2.366
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
				arg_16_0:Play324581005(arg_16_1)
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
				arg_16_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_19_22 = 0
			local var_19_23 = 0.275

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

				local var_19_25 = arg_16_1:GetWordFromCfg(324581004)
				local var_19_26 = arg_16_1:FormatText(var_19_25.content)

				arg_16_1.text_.text = var_19_26

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_27 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581004", "story_v_out_324581.awb") ~= 0 then
					local var_19_30 = manager.audio:GetVoiceLength("story_v_out_324581", "324581004", "story_v_out_324581.awb") / 1000

					if var_19_30 + var_19_22 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_30 + var_19_22
					end

					if var_19_25.prefab_name ~= "" and arg_16_1.actors_[var_19_25.prefab_name] ~= nil then
						local var_19_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_25.prefab_name].transform, "story_v_out_324581", "324581004", "story_v_out_324581.awb")

						arg_16_1:RecordAudio("324581004", var_19_31)
						arg_16_1:RecordAudio("324581004", var_19_31)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_324581", "324581004", "story_v_out_324581.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_324581", "324581004", "story_v_out_324581.awb")
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
	Play324581005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324581005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play324581006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["10170ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect10170ui_story == nil then
				arg_20_1.var_.characterEffect10170ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect10170ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_20_1.var_.characterEffect10170ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect10170ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_20_1.var_.characterEffect10170ui_story.fillRatio = var_23_5
			end

			local var_23_6 = 0
			local var_23_7 = 0.15

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_8

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

				local var_23_9 = arg_20_1:GetWordFromCfg(324581005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 6
				local var_23_12 = utf8.len(var_23_10)
				local var_23_13 = var_23_11 <= 0 and var_23_7 or var_23_7 * (var_23_12 / var_23_11)

				if var_23_13 > 0 and var_23_7 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_10
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_14 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_14 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_14

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_14 and arg_20_1.time_ < var_23_6 + var_23_14 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play324581006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324581006
		arg_24_1.duration_ = 5.4

		local var_24_0 = {
			zh = 5.4,
			ja = 5.1
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
				arg_24_0:Play324581007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["10170ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect10170ui_story == nil then
				arg_24_1.var_.characterEffect10170ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect10170ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect10170ui_story then
				arg_24_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_27_4 = 0

			if var_27_4 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_1")
			end

			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 then
				arg_24_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_27_6 = 0
			local var_27_7 = 0.55

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_8 = arg_24_1:FormatText(StoryNameCfg[1450].name)

				arg_24_1.leftNameTxt_.text = var_27_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_9 = arg_24_1:GetWordFromCfg(324581006)
				local var_27_10 = arg_24_1:FormatText(var_27_9.content)

				arg_24_1.text_.text = var_27_10

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 22
				local var_27_12 = utf8.len(var_27_10)
				local var_27_13 = var_27_11 <= 0 and var_27_7 or var_27_7 * (var_27_12 / var_27_11)

				if var_27_13 > 0 and var_27_7 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13

					if var_27_13 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_10
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581006", "story_v_out_324581.awb") ~= 0 then
					local var_27_14 = manager.audio:GetVoiceLength("story_v_out_324581", "324581006", "story_v_out_324581.awb") / 1000

					if var_27_14 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_14 + var_27_6
					end

					if var_27_9.prefab_name ~= "" and arg_24_1.actors_[var_27_9.prefab_name] ~= nil then
						local var_27_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_9.prefab_name].transform, "story_v_out_324581", "324581006", "story_v_out_324581.awb")

						arg_24_1:RecordAudio("324581006", var_27_15)
						arg_24_1:RecordAudio("324581006", var_27_15)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_324581", "324581006", "story_v_out_324581.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_324581", "324581006", "story_v_out_324581.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_16 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_16 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_16

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_16 and arg_24_1.time_ < var_27_6 + var_27_16 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play324581007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324581007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play324581008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["10170ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect10170ui_story == nil then
				arg_28_1.var_.characterEffect10170ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect10170ui_story and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10170ui_story.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect10170ui_story then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10170ui_story.fillRatio = var_31_5
			end

			local var_31_6 = 0
			local var_31_7 = 0.125

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_8 = arg_28_1:FormatText(StoryNameCfg[7].name)

				arg_28_1.leftNameTxt_.text = var_31_8

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

				local var_31_9 = arg_28_1:GetWordFromCfg(324581007)
				local var_31_10 = arg_28_1:FormatText(var_31_9.content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 5
				local var_31_12 = utf8.len(var_31_10)
				local var_31_13 = var_31_11 <= 0 and var_31_7 or var_31_7 * (var_31_12 / var_31_11)

				if var_31_13 > 0 and var_31_7 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_10
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_14 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_14 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_14

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_14 and arg_28_1.time_ < var_31_6 + var_31_14 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play324581008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324581008
		arg_32_1.duration_ = 2.47

		local var_32_0 = {
			zh = 2.466,
			ja = 1.233
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
				arg_32_0:Play324581009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "10165ui_story"

			if arg_32_1.actors_[var_35_0] == nil then
				local var_35_1 = Asset.Load("Char/" .. "10165ui_story")

				if not isNil(var_35_1) then
					local var_35_2 = Object.Instantiate(Asset.Load("Char/" .. "10165ui_story"), arg_32_1.stage_.transform)

					var_35_2.name = var_35_0
					var_35_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_0] = var_35_2

					local var_35_3 = var_35_2:GetComponentInChildren(typeof(CharacterEffect))

					var_35_3.enabled = true

					local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_2, typeof(DynamicBoneHelper))

					if var_35_4 then
						var_35_4:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_3.transform, false)

					arg_32_1.var_[var_35_0 .. "Animator"] = var_35_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_0 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_0 .. "LipSync"] = var_35_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_5 = arg_32_1.actors_["10165ui_story"]
			local var_35_6 = 0

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect10165ui_story == nil then
				arg_32_1.var_.characterEffect10165ui_story = var_35_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_7 = 0.200000002980232

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_7 and not isNil(var_35_5) then
				local var_35_8 = (arg_32_1.time_ - var_35_6) / var_35_7

				if arg_32_1.var_.characterEffect10165ui_story and not isNil(var_35_5) then
					arg_32_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_6 + var_35_7 and arg_32_1.time_ < var_35_6 + var_35_7 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect10165ui_story then
				arg_32_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_35_9 = 0
			local var_35_10 = 0.075

			if var_35_9 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_11 = arg_32_1:FormatText(StoryNameCfg[1446].name)

				arg_32_1.leftNameTxt_.text = var_35_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10165")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_12 = arg_32_1:GetWordFromCfg(324581008)
				local var_35_13 = arg_32_1:FormatText(var_35_12.content)

				arg_32_1.text_.text = var_35_13

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_14 = 3
				local var_35_15 = utf8.len(var_35_13)
				local var_35_16 = var_35_14 <= 0 and var_35_10 or var_35_10 * (var_35_15 / var_35_14)

				if var_35_16 > 0 and var_35_10 < var_35_16 then
					arg_32_1.talkMaxDuration = var_35_16

					if var_35_16 + var_35_9 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_16 + var_35_9
					end
				end

				arg_32_1.text_.text = var_35_13
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581008", "story_v_out_324581.awb") ~= 0 then
					local var_35_17 = manager.audio:GetVoiceLength("story_v_out_324581", "324581008", "story_v_out_324581.awb") / 1000

					if var_35_17 + var_35_9 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_17 + var_35_9
					end

					if var_35_12.prefab_name ~= "" and arg_32_1.actors_[var_35_12.prefab_name] ~= nil then
						local var_35_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_12.prefab_name].transform, "story_v_out_324581", "324581008", "story_v_out_324581.awb")

						arg_32_1:RecordAudio("324581008", var_35_18)
						arg_32_1:RecordAudio("324581008", var_35_18)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_324581", "324581008", "story_v_out_324581.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_324581", "324581008", "story_v_out_324581.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_19 = math.max(var_35_10, arg_32_1.talkMaxDuration)

			if var_35_9 <= arg_32_1.time_ and arg_32_1.time_ < var_35_9 + var_35_19 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_9) / var_35_19

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_9 + var_35_19 and arg_32_1.time_ < var_35_9 + var_35_19 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play324581009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324581009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play324581010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10170ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos10170ui_story = var_39_0.localPosition

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end
			end

			local var_39_3 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_3 then
				local var_39_4 = (arg_36_1.time_ - var_39_1) / var_39_3
				local var_39_5 = Vector3.New(0, 100, 0)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10170ui_story, var_39_5, var_39_4)

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

			local var_39_11 = arg_36_1.actors_["10165ui_story"]
			local var_39_12 = 0

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 and not isNil(var_39_11) and arg_36_1.var_.characterEffect10165ui_story == nil then
				arg_36_1.var_.characterEffect10165ui_story = var_39_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_13 = 0.200000002980232

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_13 and not isNil(var_39_11) then
				local var_39_14 = (arg_36_1.time_ - var_39_12) / var_39_13

				if arg_36_1.var_.characterEffect10165ui_story and not isNil(var_39_11) then
					local var_39_15 = Mathf.Lerp(0, 0.5, var_39_14)

					arg_36_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10165ui_story.fillRatio = var_39_15
				end
			end

			if arg_36_1.time_ >= var_39_12 + var_39_13 and arg_36_1.time_ < var_39_12 + var_39_13 + arg_39_0 and not isNil(var_39_11) and arg_36_1.var_.characterEffect10165ui_story then
				local var_39_16 = 0.5

				arg_36_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10165ui_story.fillRatio = var_39_16
			end

			local var_39_17 = 0
			local var_39_18 = 0.825

			if var_39_17 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_19 = arg_36_1:GetWordFromCfg(324581009)
				local var_39_20 = arg_36_1:FormatText(var_39_19.content)

				arg_36_1.text_.text = var_39_20

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_21 = 33
				local var_39_22 = utf8.len(var_39_20)
				local var_39_23 = var_39_21 <= 0 and var_39_18 or var_39_18 * (var_39_22 / var_39_21)

				if var_39_23 > 0 and var_39_18 < var_39_23 then
					arg_36_1.talkMaxDuration = var_39_23

					if var_39_23 + var_39_17 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_23 + var_39_17
					end
				end

				arg_36_1.text_.text = var_39_20
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_24 = math.max(var_39_18, arg_36_1.talkMaxDuration)

			if var_39_17 <= arg_36_1.time_ and arg_36_1.time_ < var_39_17 + var_39_24 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_17) / var_39_24

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_17 + var_39_24 and arg_36_1.time_ < var_39_17 + var_39_24 + arg_39_0 then
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
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play324581010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324581010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play324581011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.325

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[7].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(324581010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 13
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_8 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_8 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_8

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_8 and arg_40_1.time_ < var_43_0 + var_43_8 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play324581011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324581011
		arg_44_1.duration_ = 9

		local var_44_0 = {
			zh = 8.4,
			ja = 9
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
				arg_44_0:Play324581012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["10165ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos10165ui_story = var_47_0.localPosition

				local var_47_2 = GameObjectTools.GetOrAddComponent(var_47_0.gameObject, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(false)
				end
			end

			local var_47_3 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_3 then
				local var_47_4 = (arg_44_1.time_ - var_47_1) / var_47_3
				local var_47_5 = Vector3.New(0, -1.08, -5.83)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10165ui_story, var_47_5, var_47_4)

				local var_47_6 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_6.x, var_47_6.y, var_47_6.z)

				local var_47_7 = var_47_0.localEulerAngles

				var_47_7.z = 0
				var_47_7.x = 0
				var_47_0.localEulerAngles = var_47_7
			end

			if arg_44_1.time_ >= var_47_1 + var_47_3 and arg_44_1.time_ < var_47_1 + var_47_3 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, -1.08, -5.83)

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

			local var_47_11 = arg_44_1.actors_["10165ui_story"]
			local var_47_12 = 0

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 and not isNil(var_47_11) and arg_44_1.var_.characterEffect10165ui_story == nil then
				arg_44_1.var_.characterEffect10165ui_story = var_47_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_13 = 0.200000002980232

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_13 and not isNil(var_47_11) then
				local var_47_14 = (arg_44_1.time_ - var_47_12) / var_47_13

				if arg_44_1.var_.characterEffect10165ui_story and not isNil(var_47_11) then
					arg_44_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_12 + var_47_13 and arg_44_1.time_ < var_47_12 + var_47_13 + arg_47_0 and not isNil(var_47_11) and arg_44_1.var_.characterEffect10165ui_story then
				arg_44_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_47_15 = 0

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			local var_47_16 = "1026ui_story"

			if arg_44_1.actors_[var_47_16] == nil then
				local var_47_17 = Asset.Load("Char/" .. "1026ui_story")

				if not isNil(var_47_17) then
					local var_47_18 = Object.Instantiate(Asset.Load("Char/" .. "1026ui_story"), arg_44_1.stage_.transform)

					var_47_18.name = var_47_16
					var_47_18.transform.localPosition = Vector3.New(0, 100, 0)
					arg_44_1.actors_[var_47_16] = var_47_18

					local var_47_19 = var_47_18:GetComponentInChildren(typeof(CharacterEffect))

					var_47_19.enabled = true

					local var_47_20 = GameObjectTools.GetOrAddComponent(var_47_18, typeof(DynamicBoneHelper))

					if var_47_20 then
						var_47_20:EnableDynamicBone(false)
					end

					arg_44_1:ShowWeapon(var_47_19.transform, false)

					arg_44_1.var_[var_47_16 .. "Animator"] = var_47_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_44_1.var_[var_47_16 .. "Animator"].applyRootMotion = true
					arg_44_1.var_[var_47_16 .. "LipSync"] = var_47_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_47_21 = 0

			if var_47_21 < arg_44_1.time_ and arg_44_1.time_ <= var_47_21 + arg_47_0 then
				arg_44_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_47_22 = 0
			local var_47_23 = 0.825

			if var_47_22 < arg_44_1.time_ and arg_44_1.time_ <= var_47_22 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_24 = arg_44_1:FormatText(StoryNameCfg[1446].name)

				arg_44_1.leftNameTxt_.text = var_47_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_25 = arg_44_1:GetWordFromCfg(324581011)
				local var_47_26 = arg_44_1:FormatText(var_47_25.content)

				arg_44_1.text_.text = var_47_26

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_27 = 33
				local var_47_28 = utf8.len(var_47_26)
				local var_47_29 = var_47_27 <= 0 and var_47_23 or var_47_23 * (var_47_28 / var_47_27)

				if var_47_29 > 0 and var_47_23 < var_47_29 then
					arg_44_1.talkMaxDuration = var_47_29

					if var_47_29 + var_47_22 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_29 + var_47_22
					end
				end

				arg_44_1.text_.text = var_47_26
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581011", "story_v_out_324581.awb") ~= 0 then
					local var_47_30 = manager.audio:GetVoiceLength("story_v_out_324581", "324581011", "story_v_out_324581.awb") / 1000

					if var_47_30 + var_47_22 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_30 + var_47_22
					end

					if var_47_25.prefab_name ~= "" and arg_44_1.actors_[var_47_25.prefab_name] ~= nil then
						local var_47_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_25.prefab_name].transform, "story_v_out_324581", "324581011", "story_v_out_324581.awb")

						arg_44_1:RecordAudio("324581011", var_47_31)
						arg_44_1:RecordAudio("324581011", var_47_31)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_324581", "324581011", "story_v_out_324581.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_324581", "324581011", "story_v_out_324581.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_32 = math.max(var_47_23, arg_44_1.talkMaxDuration)

			if var_47_22 <= arg_44_1.time_ and arg_44_1.time_ < var_47_22 + var_47_32 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_22) / var_47_32

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_22 + var_47_32 and arg_44_1.time_ < var_47_22 + var_47_32 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10165ui_story",
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
	Play324581012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324581012
		arg_48_1.duration_ = 5.77

		local var_48_0 = {
			zh = 1.966,
			ja = 5.766
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
				arg_48_0:Play324581013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.3

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[1446].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:GetWordFromCfg(324581012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 12
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581012", "story_v_out_324581.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_324581", "324581012", "story_v_out_324581.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_324581", "324581012", "story_v_out_324581.awb")

						arg_48_1:RecordAudio("324581012", var_51_9)
						arg_48_1:RecordAudio("324581012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_324581", "324581012", "story_v_out_324581.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_324581", "324581012", "story_v_out_324581.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_10 and arg_48_1.time_ < var_51_0 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play324581013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324581013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play324581014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10165ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10165ui_story == nil then
				arg_52_1.var_.characterEffect10165ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect10165ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_52_1.var_.characterEffect10165ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10165ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_52_1.var_.characterEffect10165ui_story.fillRatio = var_55_5
			end

			local var_55_6 = 0
			local var_55_7 = 0.425

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_8 = arg_52_1:FormatText(StoryNameCfg[7].name)

				arg_52_1.leftNameTxt_.text = var_55_8

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

				local var_55_9 = arg_52_1:GetWordFromCfg(324581013)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 17
				local var_55_12 = utf8.len(var_55_10)
				local var_55_13 = var_55_11 <= 0 and var_55_7 or var_55_7 * (var_55_12 / var_55_11)

				if var_55_13 > 0 and var_55_7 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_6
					end
				end

				arg_52_1.text_.text = var_55_10
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_14 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_14 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_14

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_14 and arg_52_1.time_ < var_55_6 + var_55_14 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play324581014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324581014
		arg_56_1.duration_ = 7

		local var_56_0 = {
			zh = 4.866,
			ja = 7
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
				arg_56_0:Play324581015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10165ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect10165ui_story == nil then
				arg_56_1.var_.characterEffect10165ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect10165ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect10165ui_story then
				arg_56_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_59_4 = 0

			if var_59_4 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action3_1")
			end

			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_59_6 = 0
			local var_59_7 = 0.575

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_8 = arg_56_1:FormatText(StoryNameCfg[1446].name)

				arg_56_1.leftNameTxt_.text = var_59_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_9 = arg_56_1:GetWordFromCfg(324581014)
				local var_59_10 = arg_56_1:FormatText(var_59_9.content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 23
				local var_59_12 = utf8.len(var_59_10)
				local var_59_13 = var_59_11 <= 0 and var_59_7 or var_59_7 * (var_59_12 / var_59_11)

				if var_59_13 > 0 and var_59_7 < var_59_13 then
					arg_56_1.talkMaxDuration = var_59_13

					if var_59_13 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581014", "story_v_out_324581.awb") ~= 0 then
					local var_59_14 = manager.audio:GetVoiceLength("story_v_out_324581", "324581014", "story_v_out_324581.awb") / 1000

					if var_59_14 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_14 + var_59_6
					end

					if var_59_9.prefab_name ~= "" and arg_56_1.actors_[var_59_9.prefab_name] ~= nil then
						local var_59_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_9.prefab_name].transform, "story_v_out_324581", "324581014", "story_v_out_324581.awb")

						arg_56_1:RecordAudio("324581014", var_59_15)
						arg_56_1:RecordAudio("324581014", var_59_15)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_324581", "324581014", "story_v_out_324581.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_324581", "324581014", "story_v_out_324581.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_16 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_16 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_16

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_16 and arg_56_1.time_ < var_59_6 + var_59_16 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play324581015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 324581015
		arg_60_1.duration_ = 7.37

		local var_60_0 = {
			zh = 7.2,
			ja = 7.366
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
				arg_60_0:Play324581016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.725

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[1446].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_3 = arg_60_1:GetWordFromCfg(324581015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581015", "story_v_out_324581.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_324581", "324581015", "story_v_out_324581.awb") / 1000

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_324581", "324581015", "story_v_out_324581.awb")

						arg_60_1:RecordAudio("324581015", var_63_9)
						arg_60_1:RecordAudio("324581015", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_324581", "324581015", "story_v_out_324581.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_324581", "324581015", "story_v_out_324581.awb")
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
	Play324581016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 324581016
		arg_64_1.duration_ = 7.03

		local var_64_0 = {
			zh = 7.033,
			ja = 6.966
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
				arg_64_0:Play324581017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = "ST32"

			if arg_64_1.bgs_[var_67_0] == nil then
				local var_67_1 = Object.Instantiate(arg_64_1.paintGo_)

				var_67_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_67_0)
				var_67_1.name = var_67_0
				var_67_1.transform.parent = arg_64_1.stage_.transform
				var_67_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.bgs_[var_67_0] = var_67_1
			end

			local var_67_2 = 1.999999999999

			if var_67_2 < arg_64_1.time_ and arg_64_1.time_ <= var_67_2 + arg_67_0 then
				local var_67_3 = manager.ui.mainCamera.transform.localPosition
				local var_67_4 = Vector3.New(0, 0, 10) + Vector3.New(var_67_3.x, var_67_3.y, 0)
				local var_67_5 = arg_64_1.bgs_.ST32

				var_67_5.transform.localPosition = var_67_4
				var_67_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_67_6 = var_67_5:GetComponent("SpriteRenderer")

				if var_67_6 and var_67_6.sprite then
					local var_67_7 = (var_67_5.transform.localPosition - var_67_3).z
					local var_67_8 = manager.ui.mainCameraCom_
					local var_67_9 = 2 * var_67_7 * Mathf.Tan(var_67_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_67_10 = var_67_9 * var_67_8.aspect
					local var_67_11 = var_67_6.sprite.bounds.size.x
					local var_67_12 = var_67_6.sprite.bounds.size.y
					local var_67_13 = var_67_10 / var_67_11
					local var_67_14 = var_67_9 / var_67_12
					local var_67_15 = var_67_14 < var_67_13 and var_67_13 or var_67_14

					var_67_5.transform.localScale = Vector3.New(var_67_15, var_67_15, 0)
				end

				for iter_67_0, iter_67_1 in pairs(arg_64_1.bgs_) do
					if iter_67_0 ~= "ST32" then
						iter_67_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_67_16 = 3.999999999999

			if var_67_16 < arg_64_1.time_ and arg_64_1.time_ <= var_67_16 + arg_67_0 then
				arg_64_1.allBtn_.enabled = false
			end

			local var_67_17 = 0.3

			if arg_64_1.time_ >= var_67_16 + var_67_17 and arg_64_1.time_ < var_67_16 + var_67_17 + arg_67_0 then
				arg_64_1.allBtn_.enabled = true
			end

			local var_67_18 = 0

			if var_67_18 < arg_64_1.time_ and arg_64_1.time_ <= var_67_18 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_19 = 2

			if var_67_18 <= arg_64_1.time_ and arg_64_1.time_ < var_67_18 + var_67_19 then
				local var_67_20 = (arg_64_1.time_ - var_67_18) / var_67_19
				local var_67_21 = Color.New(0, 0, 0)

				var_67_21.a = Mathf.Lerp(0, 1, var_67_20)
				arg_64_1.mask_.color = var_67_21
			end

			if arg_64_1.time_ >= var_67_18 + var_67_19 and arg_64_1.time_ < var_67_18 + var_67_19 + arg_67_0 then
				local var_67_22 = Color.New(0, 0, 0)

				var_67_22.a = 1
				arg_64_1.mask_.color = var_67_22
			end

			local var_67_23 = 2

			if var_67_23 < arg_64_1.time_ and arg_64_1.time_ <= var_67_23 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_24 = 2

			if var_67_23 <= arg_64_1.time_ and arg_64_1.time_ < var_67_23 + var_67_24 then
				local var_67_25 = (arg_64_1.time_ - var_67_23) / var_67_24
				local var_67_26 = Color.New(0, 0, 0)

				var_67_26.a = Mathf.Lerp(1, 0, var_67_25)
				arg_64_1.mask_.color = var_67_26
			end

			if arg_64_1.time_ >= var_67_23 + var_67_24 and arg_64_1.time_ < var_67_23 + var_67_24 + arg_67_0 then
				local var_67_27 = Color.New(0, 0, 0)
				local var_67_28 = 0

				arg_64_1.mask_.enabled = false
				var_67_27.a = var_67_28
				arg_64_1.mask_.color = var_67_27
			end

			local var_67_29 = arg_64_1.actors_["10165ui_story"].transform
			local var_67_30 = 2

			if var_67_30 < arg_64_1.time_ and arg_64_1.time_ <= var_67_30 + arg_67_0 then
				arg_64_1.var_.moveOldPos10165ui_story = var_67_29.localPosition

				local var_67_31 = GameObjectTools.GetOrAddComponent(var_67_29.gameObject, typeof(DynamicBoneHelper))

				if var_67_31 then
					var_67_31:EnableDynamicBone(false)
				end
			end

			local var_67_32 = 0.001

			if var_67_30 <= arg_64_1.time_ and arg_64_1.time_ < var_67_30 + var_67_32 then
				local var_67_33 = (arg_64_1.time_ - var_67_30) / var_67_32
				local var_67_34 = Vector3.New(0, 100, 0)

				var_67_29.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10165ui_story, var_67_34, var_67_33)

				local var_67_35 = manager.ui.mainCamera.transform.position - var_67_29.position

				var_67_29.forward = Vector3.New(var_67_35.x, var_67_35.y, var_67_35.z)

				local var_67_36 = var_67_29.localEulerAngles

				var_67_36.z = 0
				var_67_36.x = 0
				var_67_29.localEulerAngles = var_67_36
			end

			if arg_64_1.time_ >= var_67_30 + var_67_32 and arg_64_1.time_ < var_67_30 + var_67_32 + arg_67_0 then
				var_67_29.localPosition = Vector3.New(0, 100, 0)

				local var_67_37 = manager.ui.mainCamera.transform.position - var_67_29.position

				var_67_29.forward = Vector3.New(var_67_37.x, var_67_37.y, var_67_37.z)

				local var_67_38 = var_67_29.localEulerAngles

				var_67_38.z = 0
				var_67_38.x = 0
				var_67_29.localEulerAngles = var_67_38

				local var_67_39 = GameObjectTools.GetOrAddComponent(var_67_29.gameObject, typeof(DynamicBoneHelper))

				if var_67_39 then
					var_67_39:EnableDynamicBone(true)
				end
			end

			local var_67_40 = "1071ui_story"

			if arg_64_1.actors_[var_67_40] == nil then
				local var_67_41 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_67_41) then
					local var_67_42 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_64_1.stage_.transform)

					var_67_42.name = var_67_40
					var_67_42.transform.localPosition = Vector3.New(0, 100, 0)
					arg_64_1.actors_[var_67_40] = var_67_42

					local var_67_43 = var_67_42:GetComponentInChildren(typeof(CharacterEffect))

					var_67_43.enabled = true

					local var_67_44 = GameObjectTools.GetOrAddComponent(var_67_42, typeof(DynamicBoneHelper))

					if var_67_44 then
						var_67_44:EnableDynamicBone(false)
					end

					arg_64_1:ShowWeapon(var_67_43.transform, false)

					arg_64_1.var_[var_67_40 .. "Animator"] = var_67_43.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_64_1.var_[var_67_40 .. "Animator"].applyRootMotion = true
					arg_64_1.var_[var_67_40 .. "LipSync"] = var_67_43.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_67_45 = arg_64_1.actors_["1071ui_story"].transform
			local var_67_46 = 3.8

			if var_67_46 < arg_64_1.time_ and arg_64_1.time_ <= var_67_46 + arg_67_0 then
				arg_64_1.var_.moveOldPos1071ui_story = var_67_45.localPosition
			end

			local var_67_47 = 0.001

			if var_67_46 <= arg_64_1.time_ and arg_64_1.time_ < var_67_46 + var_67_47 then
				local var_67_48 = (arg_64_1.time_ - var_67_46) / var_67_47
				local var_67_49 = Vector3.New(0, -1.05, -6.2)

				var_67_45.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1071ui_story, var_67_49, var_67_48)

				local var_67_50 = manager.ui.mainCamera.transform.position - var_67_45.position

				var_67_45.forward = Vector3.New(var_67_50.x, var_67_50.y, var_67_50.z)

				local var_67_51 = var_67_45.localEulerAngles

				var_67_51.z = 0
				var_67_51.x = 0
				var_67_45.localEulerAngles = var_67_51
			end

			if arg_64_1.time_ >= var_67_46 + var_67_47 and arg_64_1.time_ < var_67_46 + var_67_47 + arg_67_0 then
				var_67_45.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_67_52 = manager.ui.mainCamera.transform.position - var_67_45.position

				var_67_45.forward = Vector3.New(var_67_52.x, var_67_52.y, var_67_52.z)

				local var_67_53 = var_67_45.localEulerAngles

				var_67_53.z = 0
				var_67_53.x = 0
				var_67_45.localEulerAngles = var_67_53
			end

			local var_67_54 = arg_64_1.actors_["1071ui_story"]
			local var_67_55 = 3.79999999701877

			if var_67_55 < arg_64_1.time_ and arg_64_1.time_ <= var_67_55 + arg_67_0 and not isNil(var_67_54) and arg_64_1.var_.characterEffect1071ui_story == nil then
				arg_64_1.var_.characterEffect1071ui_story = var_67_54:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_56 = 0.200000002980232

			if var_67_55 <= arg_64_1.time_ and arg_64_1.time_ < var_67_55 + var_67_56 and not isNil(var_67_54) then
				local var_67_57 = (arg_64_1.time_ - var_67_55) / var_67_56

				if arg_64_1.var_.characterEffect1071ui_story and not isNil(var_67_54) then
					arg_64_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_55 + var_67_56 and arg_64_1.time_ < var_67_55 + var_67_56 + arg_67_0 and not isNil(var_67_54) and arg_64_1.var_.characterEffect1071ui_story then
				arg_64_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_67_58 = arg_64_1.actors_["10165ui_story"]
			local var_67_59 = 1.79999999701977

			if var_67_59 < arg_64_1.time_ and arg_64_1.time_ <= var_67_59 + arg_67_0 and not isNil(var_67_58) and arg_64_1.var_.characterEffect10165ui_story == nil then
				arg_64_1.var_.characterEffect10165ui_story = var_67_58:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_60 = 0.200000002980232

			if var_67_59 <= arg_64_1.time_ and arg_64_1.time_ < var_67_59 + var_67_60 and not isNil(var_67_58) then
				local var_67_61 = (arg_64_1.time_ - var_67_59) / var_67_60

				if arg_64_1.var_.characterEffect10165ui_story and not isNil(var_67_58) then
					local var_67_62 = Mathf.Lerp(0, 0.5, var_67_61)

					arg_64_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10165ui_story.fillRatio = var_67_62
				end
			end

			if arg_64_1.time_ >= var_67_59 + var_67_60 and arg_64_1.time_ < var_67_59 + var_67_60 + arg_67_0 and not isNil(var_67_58) and arg_64_1.var_.characterEffect10165ui_story then
				local var_67_63 = 0.5

				arg_64_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10165ui_story.fillRatio = var_67_63
			end

			local var_67_64 = 3.63333333333333

			if var_67_64 < arg_64_1.time_ and arg_64_1.time_ <= var_67_64 + arg_67_0 then
				arg_64_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_67_65 = 0

			if var_67_65 < arg_64_1.time_ and arg_64_1.time_ <= var_67_65 + arg_67_0 then
				arg_64_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_67_66 = 1.2
			local var_67_67 = 1

			if var_67_66 < arg_64_1.time_ and arg_64_1.time_ <= var_67_66 + arg_67_0 then
				local var_67_68 = "play"
				local var_67_69 = "effect"

				arg_64_1:AudioAction(var_67_68, var_67_69, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_67_70 = 0.1
			local var_67_71 = 1

			if var_67_70 < arg_64_1.time_ and arg_64_1.time_ <= var_67_70 + arg_67_0 then
				local var_67_72 = "stop"
				local var_67_73 = "effect"

				arg_64_1:AudioAction(var_67_72, var_67_73, "se_story_148", "se_story_148_amb_wind", "")
			end

			if arg_64_1.frameCnt_ <= 1 then
				arg_64_1.dialog_:SetActive(false)
			end

			local var_67_74 = 4
			local var_67_75 = 0.275

			if var_67_74 < arg_64_1.time_ and arg_64_1.time_ <= var_67_74 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				arg_64_1.dialog_:SetActive(true)

				arg_64_1.dialogCg_.alpha = 0

				local var_67_76 = LeanTween.value(arg_64_1.dialog_, 0, 1, 0.3)

				var_67_76:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_64_1.dialogCg_.alpha = arg_68_0
				end))
				var_67_76:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_64_1.dialog_)
					var_67_76:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_64_1.duration_ = arg_64_1.duration_ + 0.3

				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_77 = arg_64_1:FormatText(StoryNameCfg[384].name)

				arg_64_1.leftNameTxt_.text = var_67_77

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_78 = arg_64_1:GetWordFromCfg(324581016)
				local var_67_79 = arg_64_1:FormatText(var_67_78.content)

				arg_64_1.text_.text = var_67_79

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_80 = 11
				local var_67_81 = utf8.len(var_67_79)
				local var_67_82 = var_67_80 <= 0 and var_67_75 or var_67_75 * (var_67_81 / var_67_80)

				if var_67_82 > 0 and var_67_75 < var_67_82 then
					arg_64_1.talkMaxDuration = var_67_82
					var_67_74 = var_67_74 + 0.3

					if var_67_82 + var_67_74 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_82 + var_67_74
					end
				end

				arg_64_1.text_.text = var_67_79
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581016", "story_v_out_324581.awb") ~= 0 then
					local var_67_83 = manager.audio:GetVoiceLength("story_v_out_324581", "324581016", "story_v_out_324581.awb") / 1000

					if var_67_83 + var_67_74 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_83 + var_67_74
					end

					if var_67_78.prefab_name ~= "" and arg_64_1.actors_[var_67_78.prefab_name] ~= nil then
						local var_67_84 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_78.prefab_name].transform, "story_v_out_324581", "324581016", "story_v_out_324581.awb")

						arg_64_1:RecordAudio("324581016", var_67_84)
						arg_64_1:RecordAudio("324581016", var_67_84)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_324581", "324581016", "story_v_out_324581.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_324581", "324581016", "story_v_out_324581.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_85 = var_67_74 + 0.3
			local var_67_86 = math.max(var_67_75, arg_64_1.talkMaxDuration)

			if var_67_85 <= arg_64_1.time_ and arg_64_1.time_ < var_67_85 + var_67_86 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_85) / var_67_86

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_85 + var_67_86 and arg_64_1.time_ < var_67_85 + var_67_86 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10165ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play324581017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 324581017
		arg_70_1.duration_ = 9.33

		local var_70_0 = {
			zh = 6.433,
			ja = 9.333
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
				arg_70_0:Play324581018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 0.725

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[384].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_3 = arg_70_1:GetWordFromCfg(324581017)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 29
				local var_73_6 = utf8.len(var_73_4)
				local var_73_7 = var_73_5 <= 0 and var_73_1 or var_73_1 * (var_73_6 / var_73_5)

				if var_73_7 > 0 and var_73_1 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581017", "story_v_out_324581.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_324581", "324581017", "story_v_out_324581.awb") / 1000

					if var_73_8 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_0
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_324581", "324581017", "story_v_out_324581.awb")

						arg_70_1:RecordAudio("324581017", var_73_9)
						arg_70_1:RecordAudio("324581017", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_324581", "324581017", "story_v_out_324581.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_324581", "324581017", "story_v_out_324581.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_10 and arg_70_1.time_ < var_73_0 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play324581018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 324581018
		arg_74_1.duration_ = 6.13

		local var_74_0 = {
			zh = 6,
			ja = 6.133
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
				arg_74_0:Play324581019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_77_1 = 0
			local var_77_2 = 0.725

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_3 = arg_74_1:FormatText(StoryNameCfg[384].name)

				arg_74_1.leftNameTxt_.text = var_77_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_4 = arg_74_1:GetWordFromCfg(324581018)
				local var_77_5 = arg_74_1:FormatText(var_77_4.content)

				arg_74_1.text_.text = var_77_5

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_6 = 29
				local var_77_7 = utf8.len(var_77_5)
				local var_77_8 = var_77_6 <= 0 and var_77_2 or var_77_2 * (var_77_7 / var_77_6)

				if var_77_8 > 0 and var_77_2 < var_77_8 then
					arg_74_1.talkMaxDuration = var_77_8

					if var_77_8 + var_77_1 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_1
					end
				end

				arg_74_1.text_.text = var_77_5
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581018", "story_v_out_324581.awb") ~= 0 then
					local var_77_9 = manager.audio:GetVoiceLength("story_v_out_324581", "324581018", "story_v_out_324581.awb") / 1000

					if var_77_9 + var_77_1 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_9 + var_77_1
					end

					if var_77_4.prefab_name ~= "" and arg_74_1.actors_[var_77_4.prefab_name] ~= nil then
						local var_77_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_4.prefab_name].transform, "story_v_out_324581", "324581018", "story_v_out_324581.awb")

						arg_74_1:RecordAudio("324581018", var_77_10)
						arg_74_1:RecordAudio("324581018", var_77_10)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_324581", "324581018", "story_v_out_324581.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_324581", "324581018", "story_v_out_324581.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_11 = math.max(var_77_2, arg_74_1.talkMaxDuration)

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_11 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_1) / var_77_11

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_1 + var_77_11 and arg_74_1.time_ < var_77_1 + var_77_11 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play324581019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 324581019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play324581020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1071ui_story"].transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos1071ui_story = var_81_0.localPosition
			end

			local var_81_2 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2
				local var_81_4 = Vector3.New(0, 100, 0)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1071ui_story, var_81_4, var_81_3)

				local var_81_5 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_5.x, var_81_5.y, var_81_5.z)

				local var_81_6 = var_81_0.localEulerAngles

				var_81_6.z = 0
				var_81_6.x = 0
				var_81_0.localEulerAngles = var_81_6
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(0, 100, 0)

				local var_81_7 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_7.x, var_81_7.y, var_81_7.z)

				local var_81_8 = var_81_0.localEulerAngles

				var_81_8.z = 0
				var_81_8.x = 0
				var_81_0.localEulerAngles = var_81_8
			end

			local var_81_9 = arg_78_1.actors_["1071ui_story"]
			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 and not isNil(var_81_9) and arg_78_1.var_.characterEffect1071ui_story == nil then
				arg_78_1.var_.characterEffect1071ui_story = var_81_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_11 = 0.200000002980232

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_11 and not isNil(var_81_9) then
				local var_81_12 = (arg_78_1.time_ - var_81_10) / var_81_11

				if arg_78_1.var_.characterEffect1071ui_story and not isNil(var_81_9) then
					local var_81_13 = Mathf.Lerp(0, 0.5, var_81_12)

					arg_78_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1071ui_story.fillRatio = var_81_13
				end
			end

			if arg_78_1.time_ >= var_81_10 + var_81_11 and arg_78_1.time_ < var_81_10 + var_81_11 + arg_81_0 and not isNil(var_81_9) and arg_78_1.var_.characterEffect1071ui_story then
				local var_81_14 = 0.5

				arg_78_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1071ui_story.fillRatio = var_81_14
			end

			local var_81_15 = 0
			local var_81_16 = 1.275

			if var_81_15 < arg_78_1.time_ and arg_78_1.time_ <= var_81_15 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_17 = arg_78_1:GetWordFromCfg(324581019)
				local var_81_18 = arg_78_1:FormatText(var_81_17.content)

				arg_78_1.text_.text = var_81_18

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_19 = 51
				local var_81_20 = utf8.len(var_81_18)
				local var_81_21 = var_81_19 <= 0 and var_81_16 or var_81_16 * (var_81_20 / var_81_19)

				if var_81_21 > 0 and var_81_16 < var_81_21 then
					arg_78_1.talkMaxDuration = var_81_21

					if var_81_21 + var_81_15 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_21 + var_81_15
					end
				end

				arg_78_1.text_.text = var_81_18
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_22 = math.max(var_81_16, arg_78_1.talkMaxDuration)

			if var_81_15 <= arg_78_1.time_ and arg_78_1.time_ < var_81_15 + var_81_22 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_15) / var_81_22

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_15 + var_81_22 and arg_78_1.time_ < var_81_15 + var_81_22 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
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

		arg_78_1:InitPlayNodeList()
	end,
	Play324581020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 324581020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play324581021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.4

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[7].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_3 = arg_82_1:GetWordFromCfg(324581020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 16
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_8 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_8 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_8

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_8 and arg_82_1.time_ < var_85_0 + var_85_8 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play324581021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 324581021
		arg_86_1.duration_ = 3

		local var_86_0 = {
			zh = 2.4,
			ja = 3
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
				arg_86_0:Play324581022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1071ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos1071ui_story = var_89_0.localPosition
			end

			local var_89_2 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2
				local var_89_4 = Vector3.New(0, -1.05, -6.2)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1071ui_story, var_89_4, var_89_3)

				local var_89_5 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_5.x, var_89_5.y, var_89_5.z)

				local var_89_6 = var_89_0.localEulerAngles

				var_89_6.z = 0
				var_89_6.x = 0
				var_89_0.localEulerAngles = var_89_6
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_89_7 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_7.x, var_89_7.y, var_89_7.z)

				local var_89_8 = var_89_0.localEulerAngles

				var_89_8.z = 0
				var_89_8.x = 0
				var_89_0.localEulerAngles = var_89_8
			end

			local var_89_9 = arg_86_1.actors_["1071ui_story"]
			local var_89_10 = 0

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 and not isNil(var_89_9) and arg_86_1.var_.characterEffect1071ui_story == nil then
				arg_86_1.var_.characterEffect1071ui_story = var_89_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_11 = 0.200000002980232

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_11 and not isNil(var_89_9) then
				local var_89_12 = (arg_86_1.time_ - var_89_10) / var_89_11

				if arg_86_1.var_.characterEffect1071ui_story and not isNil(var_89_9) then
					arg_86_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_10 + var_89_11 and arg_86_1.time_ < var_89_10 + var_89_11 + arg_89_0 and not isNil(var_89_9) and arg_86_1.var_.characterEffect1071ui_story then
				arg_86_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_89_13 = 0

			if var_89_13 < arg_86_1.time_ and arg_86_1.time_ <= var_89_13 + arg_89_0 then
				arg_86_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_89_14 = 0
			local var_89_15 = 0.25

			if var_89_14 < arg_86_1.time_ and arg_86_1.time_ <= var_89_14 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_16 = arg_86_1:FormatText(StoryNameCfg[384].name)

				arg_86_1.leftNameTxt_.text = var_89_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_17 = arg_86_1:GetWordFromCfg(324581021)
				local var_89_18 = arg_86_1:FormatText(var_89_17.content)

				arg_86_1.text_.text = var_89_18

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_19 = 10
				local var_89_20 = utf8.len(var_89_18)
				local var_89_21 = var_89_19 <= 0 and var_89_15 or var_89_15 * (var_89_20 / var_89_19)

				if var_89_21 > 0 and var_89_15 < var_89_21 then
					arg_86_1.talkMaxDuration = var_89_21

					if var_89_21 + var_89_14 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_21 + var_89_14
					end
				end

				arg_86_1.text_.text = var_89_18
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581021", "story_v_out_324581.awb") ~= 0 then
					local var_89_22 = manager.audio:GetVoiceLength("story_v_out_324581", "324581021", "story_v_out_324581.awb") / 1000

					if var_89_22 + var_89_14 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_22 + var_89_14
					end

					if var_89_17.prefab_name ~= "" and arg_86_1.actors_[var_89_17.prefab_name] ~= nil then
						local var_89_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_17.prefab_name].transform, "story_v_out_324581", "324581021", "story_v_out_324581.awb")

						arg_86_1:RecordAudio("324581021", var_89_23)
						arg_86_1:RecordAudio("324581021", var_89_23)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_324581", "324581021", "story_v_out_324581.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_324581", "324581021", "story_v_out_324581.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_24 = math.max(var_89_15, arg_86_1.talkMaxDuration)

			if var_89_14 <= arg_86_1.time_ and arg_86_1.time_ < var_89_14 + var_89_24 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_14) / var_89_24

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_14 + var_89_24 and arg_86_1.time_ < var_89_14 + var_89_24 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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

		arg_86_1:InitPlayNodeList()
	end,
	Play324581022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 324581022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play324581023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1071ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1071ui_story == nil then
				arg_90_1.var_.characterEffect1071ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1071ui_story and not isNil(var_93_0) then
					local var_93_4 = Mathf.Lerp(0, 0.5, var_93_3)

					arg_90_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1071ui_story.fillRatio = var_93_4
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1071ui_story then
				local var_93_5 = 0.5

				arg_90_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1071ui_story.fillRatio = var_93_5
			end

			local var_93_6 = 0
			local var_93_7 = 0.425

			if var_93_6 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_8 = arg_90_1:FormatText(StoryNameCfg[7].name)

				arg_90_1.leftNameTxt_.text = var_93_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_9 = arg_90_1:GetWordFromCfg(324581022)
				local var_93_10 = arg_90_1:FormatText(var_93_9.content)

				arg_90_1.text_.text = var_93_10

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_11 = 17
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
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_14 = math.max(var_93_7, arg_90_1.talkMaxDuration)

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_14 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_6) / var_93_14

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_6 + var_93_14 and arg_90_1.time_ < var_93_6 + var_93_14 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play324581023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 324581023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play324581024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.625

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[7].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_3 = arg_94_1:GetWordFromCfg(324581023)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 25
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_8 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_8 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_8

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_8 and arg_94_1.time_ < var_97_0 + var_97_8 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play324581024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 324581024
		arg_98_1.duration_ = 8.3

		local var_98_0 = {
			zh = 5.466,
			ja = 8.3
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
				arg_98_0:Play324581025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1071ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1071ui_story == nil then
				arg_98_1.var_.characterEffect1071ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1071ui_story and not isNil(var_101_0) then
					arg_98_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1071ui_story then
				arg_98_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_101_4 = 0

			if var_101_4 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_101_5 = 0
			local var_101_6 = 0.7

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_7 = arg_98_1:FormatText(StoryNameCfg[384].name)

				arg_98_1.leftNameTxt_.text = var_101_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_8 = arg_98_1:GetWordFromCfg(324581024)
				local var_101_9 = arg_98_1:FormatText(var_101_8.content)

				arg_98_1.text_.text = var_101_9

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_10 = 28
				local var_101_11 = utf8.len(var_101_9)
				local var_101_12 = var_101_10 <= 0 and var_101_6 or var_101_6 * (var_101_11 / var_101_10)

				if var_101_12 > 0 and var_101_6 < var_101_12 then
					arg_98_1.talkMaxDuration = var_101_12

					if var_101_12 + var_101_5 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_12 + var_101_5
					end
				end

				arg_98_1.text_.text = var_101_9
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581024", "story_v_out_324581.awb") ~= 0 then
					local var_101_13 = manager.audio:GetVoiceLength("story_v_out_324581", "324581024", "story_v_out_324581.awb") / 1000

					if var_101_13 + var_101_5 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_5
					end

					if var_101_8.prefab_name ~= "" and arg_98_1.actors_[var_101_8.prefab_name] ~= nil then
						local var_101_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_8.prefab_name].transform, "story_v_out_324581", "324581024", "story_v_out_324581.awb")

						arg_98_1:RecordAudio("324581024", var_101_14)
						arg_98_1:RecordAudio("324581024", var_101_14)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_324581", "324581024", "story_v_out_324581.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_324581", "324581024", "story_v_out_324581.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_15 = math.max(var_101_6, arg_98_1.talkMaxDuration)

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_15 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_5) / var_101_15

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_5 + var_101_15 and arg_98_1.time_ < var_101_5 + var_101_15 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play324581025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 324581025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play324581026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1071ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1071ui_story == nil then
				arg_102_1.var_.characterEffect1071ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1071ui_story and not isNil(var_105_0) then
					local var_105_4 = Mathf.Lerp(0, 0.5, var_105_3)

					arg_102_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1071ui_story.fillRatio = var_105_4
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1071ui_story then
				local var_105_5 = 0.5

				arg_102_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1071ui_story.fillRatio = var_105_5
			end

			local var_105_6 = 0
			local var_105_7 = 0.175

			if var_105_6 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_8 = arg_102_1:FormatText(StoryNameCfg[7].name)

				arg_102_1.leftNameTxt_.text = var_105_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_9 = arg_102_1:GetWordFromCfg(324581025)
				local var_105_10 = arg_102_1:FormatText(var_105_9.content)

				arg_102_1.text_.text = var_105_10

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_11 = 7
				local var_105_12 = utf8.len(var_105_10)
				local var_105_13 = var_105_11 <= 0 and var_105_7 or var_105_7 * (var_105_12 / var_105_11)

				if var_105_13 > 0 and var_105_7 < var_105_13 then
					arg_102_1.talkMaxDuration = var_105_13

					if var_105_13 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_13 + var_105_6
					end
				end

				arg_102_1.text_.text = var_105_10
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_14 = math.max(var_105_7, arg_102_1.talkMaxDuration)

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_14 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_6) / var_105_14

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_6 + var_105_14 and arg_102_1.time_ < var_105_6 + var_105_14 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play324581026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 324581026
		arg_106_1.duration_ = 1.17

		local var_106_0 = {
			zh = 1.166,
			ja = 0.999999999999
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
				arg_106_0:Play324581027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["10170ui_story"].transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.moveOldPos10170ui_story = var_109_0.localPosition

				local var_109_2 = GameObjectTools.GetOrAddComponent(var_109_0.gameObject, typeof(DynamicBoneHelper))

				if var_109_2 then
					var_109_2:EnableDynamicBone(false)
				end
			end

			local var_109_3 = 0.001

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_3 then
				local var_109_4 = (arg_106_1.time_ - var_109_1) / var_109_3
				local var_109_5 = Vector3.New(-0.7, -1.03, -6.05)

				var_109_0.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10170ui_story, var_109_5, var_109_4)

				local var_109_6 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_6.x, var_109_6.y, var_109_6.z)

				local var_109_7 = var_109_0.localEulerAngles

				var_109_7.z = 0
				var_109_7.x = 0
				var_109_0.localEulerAngles = var_109_7
			end

			if arg_106_1.time_ >= var_109_1 + var_109_3 and arg_106_1.time_ < var_109_1 + var_109_3 + arg_109_0 then
				var_109_0.localPosition = Vector3.New(-0.7, -1.03, -6.05)

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

			local var_109_11 = arg_106_1.actors_["1071ui_story"].transform
			local var_109_12 = 0

			if var_109_12 < arg_106_1.time_ and arg_106_1.time_ <= var_109_12 + arg_109_0 then
				arg_106_1.var_.moveOldPos1071ui_story = var_109_11.localPosition
			end

			local var_109_13 = 0.001

			if var_109_12 <= arg_106_1.time_ and arg_106_1.time_ < var_109_12 + var_109_13 then
				local var_109_14 = (arg_106_1.time_ - var_109_12) / var_109_13
				local var_109_15 = Vector3.New(0.7, -1.05, -6.2)

				var_109_11.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1071ui_story, var_109_15, var_109_14)

				local var_109_16 = manager.ui.mainCamera.transform.position - var_109_11.position

				var_109_11.forward = Vector3.New(var_109_16.x, var_109_16.y, var_109_16.z)

				local var_109_17 = var_109_11.localEulerAngles

				var_109_17.z = 0
				var_109_17.x = 0
				var_109_11.localEulerAngles = var_109_17
			end

			if arg_106_1.time_ >= var_109_12 + var_109_13 and arg_106_1.time_ < var_109_12 + var_109_13 + arg_109_0 then
				var_109_11.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_109_18 = manager.ui.mainCamera.transform.position - var_109_11.position

				var_109_11.forward = Vector3.New(var_109_18.x, var_109_18.y, var_109_18.z)

				local var_109_19 = var_109_11.localEulerAngles

				var_109_19.z = 0
				var_109_19.x = 0
				var_109_11.localEulerAngles = var_109_19
			end

			local var_109_20 = arg_106_1.actors_["10170ui_story"]
			local var_109_21 = 0

			if var_109_21 < arg_106_1.time_ and arg_106_1.time_ <= var_109_21 + arg_109_0 and not isNil(var_109_20) and arg_106_1.var_.characterEffect10170ui_story == nil then
				arg_106_1.var_.characterEffect10170ui_story = var_109_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_22 = 0.200000002980232

			if var_109_21 <= arg_106_1.time_ and arg_106_1.time_ < var_109_21 + var_109_22 and not isNil(var_109_20) then
				local var_109_23 = (arg_106_1.time_ - var_109_21) / var_109_22

				if arg_106_1.var_.characterEffect10170ui_story and not isNil(var_109_20) then
					arg_106_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_21 + var_109_22 and arg_106_1.time_ < var_109_21 + var_109_22 + arg_109_0 and not isNil(var_109_20) and arg_106_1.var_.characterEffect10170ui_story then
				arg_106_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_109_24 = 0

			if var_109_24 < arg_106_1.time_ and arg_106_1.time_ <= var_109_24 + arg_109_0 then
				arg_106_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_109_25 = 0

			if var_109_25 < arg_106_1.time_ and arg_106_1.time_ <= var_109_25 + arg_109_0 then
				arg_106_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_109_26 = 0
			local var_109_27 = 0.1

			if var_109_26 < arg_106_1.time_ and arg_106_1.time_ <= var_109_26 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_28 = arg_106_1:FormatText(StoryNameCfg[1450].name)

				arg_106_1.leftNameTxt_.text = var_109_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_29 = arg_106_1:GetWordFromCfg(324581026)
				local var_109_30 = arg_106_1:FormatText(var_109_29.content)

				arg_106_1.text_.text = var_109_30

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_31 = 4
				local var_109_32 = utf8.len(var_109_30)
				local var_109_33 = var_109_31 <= 0 and var_109_27 or var_109_27 * (var_109_32 / var_109_31)

				if var_109_33 > 0 and var_109_27 < var_109_33 then
					arg_106_1.talkMaxDuration = var_109_33

					if var_109_33 + var_109_26 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_33 + var_109_26
					end
				end

				arg_106_1.text_.text = var_109_30
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581026", "story_v_out_324581.awb") ~= 0 then
					local var_109_34 = manager.audio:GetVoiceLength("story_v_out_324581", "324581026", "story_v_out_324581.awb") / 1000

					if var_109_34 + var_109_26 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_34 + var_109_26
					end

					if var_109_29.prefab_name ~= "" and arg_106_1.actors_[var_109_29.prefab_name] ~= nil then
						local var_109_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_29.prefab_name].transform, "story_v_out_324581", "324581026", "story_v_out_324581.awb")

						arg_106_1:RecordAudio("324581026", var_109_35)
						arg_106_1:RecordAudio("324581026", var_109_35)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_324581", "324581026", "story_v_out_324581.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_324581", "324581026", "story_v_out_324581.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_36 = math.max(var_109_27, arg_106_1.talkMaxDuration)

			if var_109_26 <= arg_106_1.time_ and arg_106_1.time_ < var_109_26 + var_109_36 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_26) / var_109_36

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_26 + var_109_36 and arg_106_1.time_ < var_109_26 + var_109_36 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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
				actorName = "1071ui_story",
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
	Play324581027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 324581027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play324581028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["10170ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect10170ui_story == nil then
				arg_110_1.var_.characterEffect10170ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect10170ui_story and not isNil(var_113_0) then
					local var_113_4 = Mathf.Lerp(0, 0.5, var_113_3)

					arg_110_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_110_1.var_.characterEffect10170ui_story.fillRatio = var_113_4
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect10170ui_story then
				local var_113_5 = 0.5

				arg_110_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_110_1.var_.characterEffect10170ui_story.fillRatio = var_113_5
			end

			local var_113_6 = 0
			local var_113_7 = 0.05

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

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_9 = arg_110_1:GetWordFromCfg(324581027)
				local var_113_10 = arg_110_1:FormatText(var_113_9.content)

				arg_110_1.text_.text = var_113_10

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_11 = 2
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
	Play324581028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 324581028
		arg_114_1.duration_ = 2.9

		local var_114_0 = {
			zh = 2.9,
			ja = 2.5
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
				arg_114_0:Play324581029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["10170ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect10170ui_story == nil then
				arg_114_1.var_.characterEffect10170ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect10170ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect10170ui_story then
				arg_114_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_117_4 = 0
			local var_117_5 = 0.275

			if var_117_4 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_6 = arg_114_1:FormatText(StoryNameCfg[1450].name)

				arg_114_1.leftNameTxt_.text = var_117_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_7 = arg_114_1:GetWordFromCfg(324581028)
				local var_117_8 = arg_114_1:FormatText(var_117_7.content)

				arg_114_1.text_.text = var_117_8

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 11
				local var_117_10 = utf8.len(var_117_8)
				local var_117_11 = var_117_9 <= 0 and var_117_5 or var_117_5 * (var_117_10 / var_117_9)

				if var_117_11 > 0 and var_117_5 < var_117_11 then
					arg_114_1.talkMaxDuration = var_117_11

					if var_117_11 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_11 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_8
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581028", "story_v_out_324581.awb") ~= 0 then
					local var_117_12 = manager.audio:GetVoiceLength("story_v_out_324581", "324581028", "story_v_out_324581.awb") / 1000

					if var_117_12 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_12 + var_117_4
					end

					if var_117_7.prefab_name ~= "" and arg_114_1.actors_[var_117_7.prefab_name] ~= nil then
						local var_117_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_7.prefab_name].transform, "story_v_out_324581", "324581028", "story_v_out_324581.awb")

						arg_114_1:RecordAudio("324581028", var_117_13)
						arg_114_1:RecordAudio("324581028", var_117_13)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_324581", "324581028", "story_v_out_324581.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_324581", "324581028", "story_v_out_324581.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_14 = math.max(var_117_5, arg_114_1.talkMaxDuration)

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_14 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_4) / var_117_14

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_4 + var_117_14 and arg_114_1.time_ < var_117_4 + var_117_14 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play324581029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 324581029
		arg_118_1.duration_ = 2.2

		local var_118_0 = {
			zh = 1.999999999999,
			ja = 2.2
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
				arg_118_0:Play324581030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1071ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1071ui_story == nil then
				arg_118_1.var_.characterEffect1071ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1071ui_story and not isNil(var_121_0) then
					arg_118_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1071ui_story then
				arg_118_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_121_4 = arg_118_1.actors_["10170ui_story"]
			local var_121_5 = 0

			if var_121_5 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect10170ui_story == nil then
				arg_118_1.var_.characterEffect10170ui_story = var_121_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_6 = 0.200000002980232

			if var_121_5 <= arg_118_1.time_ and arg_118_1.time_ < var_121_5 + var_121_6 and not isNil(var_121_4) then
				local var_121_7 = (arg_118_1.time_ - var_121_5) / var_121_6

				if arg_118_1.var_.characterEffect10170ui_story and not isNil(var_121_4) then
					local var_121_8 = Mathf.Lerp(0, 0.5, var_121_7)

					arg_118_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_118_1.var_.characterEffect10170ui_story.fillRatio = var_121_8
				end
			end

			if arg_118_1.time_ >= var_121_5 + var_121_6 and arg_118_1.time_ < var_121_5 + var_121_6 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect10170ui_story then
				local var_121_9 = 0.5

				arg_118_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_118_1.var_.characterEffect10170ui_story.fillRatio = var_121_9
			end

			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 then
				arg_118_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_2")
			end

			local var_121_11 = 0

			if var_121_11 < arg_118_1.time_ and arg_118_1.time_ <= var_121_11 + arg_121_0 then
				arg_118_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_121_12 = 0
			local var_121_13 = 0.125

			if var_121_12 < arg_118_1.time_ and arg_118_1.time_ <= var_121_12 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_14 = arg_118_1:FormatText(StoryNameCfg[384].name)

				arg_118_1.leftNameTxt_.text = var_121_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_15 = arg_118_1:GetWordFromCfg(324581029)
				local var_121_16 = arg_118_1:FormatText(var_121_15.content)

				arg_118_1.text_.text = var_121_16

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_17 = 5
				local var_121_18 = utf8.len(var_121_16)
				local var_121_19 = var_121_17 <= 0 and var_121_13 or var_121_13 * (var_121_18 / var_121_17)

				if var_121_19 > 0 and var_121_13 < var_121_19 then
					arg_118_1.talkMaxDuration = var_121_19

					if var_121_19 + var_121_12 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_19 + var_121_12
					end
				end

				arg_118_1.text_.text = var_121_16
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581029", "story_v_out_324581.awb") ~= 0 then
					local var_121_20 = manager.audio:GetVoiceLength("story_v_out_324581", "324581029", "story_v_out_324581.awb") / 1000

					if var_121_20 + var_121_12 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_20 + var_121_12
					end

					if var_121_15.prefab_name ~= "" and arg_118_1.actors_[var_121_15.prefab_name] ~= nil then
						local var_121_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_15.prefab_name].transform, "story_v_out_324581", "324581029", "story_v_out_324581.awb")

						arg_118_1:RecordAudio("324581029", var_121_21)
						arg_118_1:RecordAudio("324581029", var_121_21)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_324581", "324581029", "story_v_out_324581.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_324581", "324581029", "story_v_out_324581.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_22 = math.max(var_121_13, arg_118_1.talkMaxDuration)

			if var_121_12 <= arg_118_1.time_ and arg_118_1.time_ < var_121_12 + var_121_22 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_12) / var_121_22

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_12 + var_121_22 and arg_118_1.time_ < var_121_12 + var_121_22 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play324581030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 324581030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play324581031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1071ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1071ui_story == nil then
				arg_122_1.var_.characterEffect1071ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1071ui_story and not isNil(var_125_0) then
					local var_125_4 = Mathf.Lerp(0, 0.5, var_125_3)

					arg_122_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1071ui_story.fillRatio = var_125_4
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1071ui_story then
				local var_125_5 = 0.5

				arg_122_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1071ui_story.fillRatio = var_125_5
			end

			local var_125_6 = 0
			local var_125_7 = 1.05

			if var_125_6 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_8 = arg_122_1:GetWordFromCfg(324581030)
				local var_125_9 = arg_122_1:FormatText(var_125_8.content)

				arg_122_1.text_.text = var_125_9

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_10 = 42
				local var_125_11 = utf8.len(var_125_9)
				local var_125_12 = var_125_10 <= 0 and var_125_7 or var_125_7 * (var_125_11 / var_125_10)

				if var_125_12 > 0 and var_125_7 < var_125_12 then
					arg_122_1.talkMaxDuration = var_125_12

					if var_125_12 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_12 + var_125_6
					end
				end

				arg_122_1.text_.text = var_125_9
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_13 = math.max(var_125_7, arg_122_1.talkMaxDuration)

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_13 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_6) / var_125_13

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_6 + var_125_13 and arg_122_1.time_ < var_125_6 + var_125_13 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play324581031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 324581031
		arg_126_1.duration_ = 2.7

		local var_126_0 = {
			zh = 1.999999999999,
			ja = 2.7
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
				arg_126_0:Play324581032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1071ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1071ui_story == nil then
				arg_126_1.var_.characterEffect1071ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect1071ui_story and not isNil(var_129_0) then
					arg_126_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1071ui_story then
				arg_126_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_129_4 = 0

			if var_129_4 < arg_126_1.time_ and arg_126_1.time_ <= var_129_4 + arg_129_0 then
				arg_126_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_129_5 = 0

			if var_129_5 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 then
				arg_126_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_129_6 = 0
			local var_129_7 = 0.2

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_8 = arg_126_1:FormatText(StoryNameCfg[384].name)

				arg_126_1.leftNameTxt_.text = var_129_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_9 = arg_126_1:GetWordFromCfg(324581031)
				local var_129_10 = arg_126_1:FormatText(var_129_9.content)

				arg_126_1.text_.text = var_129_10

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_11 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581031", "story_v_out_324581.awb") ~= 0 then
					local var_129_14 = manager.audio:GetVoiceLength("story_v_out_324581", "324581031", "story_v_out_324581.awb") / 1000

					if var_129_14 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_14 + var_129_6
					end

					if var_129_9.prefab_name ~= "" and arg_126_1.actors_[var_129_9.prefab_name] ~= nil then
						local var_129_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_9.prefab_name].transform, "story_v_out_324581", "324581031", "story_v_out_324581.awb")

						arg_126_1:RecordAudio("324581031", var_129_15)
						arg_126_1:RecordAudio("324581031", var_129_15)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_324581", "324581031", "story_v_out_324581.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_324581", "324581031", "story_v_out_324581.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_16 = math.max(var_129_7, arg_126_1.talkMaxDuration)

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_16 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_6) / var_129_16

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_6 + var_129_16 and arg_126_1.time_ < var_129_6 + var_129_16 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play324581032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 324581032
		arg_130_1.duration_ = 7.07

		local var_130_0 = {
			zh = 7.066,
			ja = 6.733
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play324581033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["10170ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect10170ui_story == nil then
				arg_130_1.var_.characterEffect10170ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect10170ui_story and not isNil(var_133_0) then
					arg_130_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect10170ui_story then
				arg_130_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_133_4 = arg_130_1.actors_["1071ui_story"]
			local var_133_5 = 0

			if var_133_5 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 and not isNil(var_133_4) and arg_130_1.var_.characterEffect1071ui_story == nil then
				arg_130_1.var_.characterEffect1071ui_story = var_133_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_6 = 0.200000002980232

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_6 and not isNil(var_133_4) then
				local var_133_7 = (arg_130_1.time_ - var_133_5) / var_133_6

				if arg_130_1.var_.characterEffect1071ui_story and not isNil(var_133_4) then
					local var_133_8 = Mathf.Lerp(0, 0.5, var_133_7)

					arg_130_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1071ui_story.fillRatio = var_133_8
				end
			end

			if arg_130_1.time_ >= var_133_5 + var_133_6 and arg_130_1.time_ < var_133_5 + var_133_6 + arg_133_0 and not isNil(var_133_4) and arg_130_1.var_.characterEffect1071ui_story then
				local var_133_9 = 0.5

				arg_130_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1071ui_story.fillRatio = var_133_9
			end

			local var_133_10 = 0

			if var_133_10 < arg_130_1.time_ and arg_130_1.time_ <= var_133_10 + arg_133_0 then
				arg_130_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_1")
			end

			local var_133_11 = 0

			if var_133_11 < arg_130_1.time_ and arg_130_1.time_ <= var_133_11 + arg_133_0 then
				arg_130_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_133_12 = 0
			local var_133_13 = 0.675

			if var_133_12 < arg_130_1.time_ and arg_130_1.time_ <= var_133_12 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_14 = arg_130_1:FormatText(StoryNameCfg[1450].name)

				arg_130_1.leftNameTxt_.text = var_133_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_15 = arg_130_1:GetWordFromCfg(324581032)
				local var_133_16 = arg_130_1:FormatText(var_133_15.content)

				arg_130_1.text_.text = var_133_16

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_17 = 27
				local var_133_18 = utf8.len(var_133_16)
				local var_133_19 = var_133_17 <= 0 and var_133_13 or var_133_13 * (var_133_18 / var_133_17)

				if var_133_19 > 0 and var_133_13 < var_133_19 then
					arg_130_1.talkMaxDuration = var_133_19

					if var_133_19 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_19 + var_133_12
					end
				end

				arg_130_1.text_.text = var_133_16
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581032", "story_v_out_324581.awb") ~= 0 then
					local var_133_20 = manager.audio:GetVoiceLength("story_v_out_324581", "324581032", "story_v_out_324581.awb") / 1000

					if var_133_20 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_20 + var_133_12
					end

					if var_133_15.prefab_name ~= "" and arg_130_1.actors_[var_133_15.prefab_name] ~= nil then
						local var_133_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_15.prefab_name].transform, "story_v_out_324581", "324581032", "story_v_out_324581.awb")

						arg_130_1:RecordAudio("324581032", var_133_21)
						arg_130_1:RecordAudio("324581032", var_133_21)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_324581", "324581032", "story_v_out_324581.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_324581", "324581032", "story_v_out_324581.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_22 = math.max(var_133_13, arg_130_1.talkMaxDuration)

			if var_133_12 <= arg_130_1.time_ and arg_130_1.time_ < var_133_12 + var_133_22 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_12) / var_133_22

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_12 + var_133_22 and arg_130_1.time_ < var_133_12 + var_133_22 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play324581033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 324581033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play324581034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["10170ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect10170ui_story == nil then
				arg_134_1.var_.characterEffect10170ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect10170ui_story and not isNil(var_137_0) then
					local var_137_4 = Mathf.Lerp(0, 0.5, var_137_3)

					arg_134_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_134_1.var_.characterEffect10170ui_story.fillRatio = var_137_4
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect10170ui_story then
				local var_137_5 = 0.5

				arg_134_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_134_1.var_.characterEffect10170ui_story.fillRatio = var_137_5
			end

			local var_137_6 = 0
			local var_137_7 = 0.55

			if var_137_6 < arg_134_1.time_ and arg_134_1.time_ <= var_137_6 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_8 = arg_134_1:FormatText(StoryNameCfg[7].name)

				arg_134_1.leftNameTxt_.text = var_137_8

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

				local var_137_9 = arg_134_1:GetWordFromCfg(324581033)
				local var_137_10 = arg_134_1:FormatText(var_137_9.content)

				arg_134_1.text_.text = var_137_10

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_11 = 22
				local var_137_12 = utf8.len(var_137_10)
				local var_137_13 = var_137_11 <= 0 and var_137_7 or var_137_7 * (var_137_12 / var_137_11)

				if var_137_13 > 0 and var_137_7 < var_137_13 then
					arg_134_1.talkMaxDuration = var_137_13

					if var_137_13 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_13 + var_137_6
					end
				end

				arg_134_1.text_.text = var_137_10
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_14 = math.max(var_137_7, arg_134_1.talkMaxDuration)

			if var_137_6 <= arg_134_1.time_ and arg_134_1.time_ < var_137_6 + var_137_14 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_6) / var_137_14

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_6 + var_137_14 and arg_134_1.time_ < var_137_6 + var_137_14 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play324581034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 324581034
		arg_138_1.duration_ = 5.47

		local var_138_0 = {
			zh = 5.466,
			ja = 5.266
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
				arg_138_0:Play324581035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["10170ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect10170ui_story == nil then
				arg_138_1.var_.characterEffect10170ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect10170ui_story and not isNil(var_141_0) then
					arg_138_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect10170ui_story then
				arg_138_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_141_4 = 0
			local var_141_5 = 0.525

			if var_141_4 < arg_138_1.time_ and arg_138_1.time_ <= var_141_4 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_6 = arg_138_1:FormatText(StoryNameCfg[1450].name)

				arg_138_1.leftNameTxt_.text = var_141_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_7 = arg_138_1:GetWordFromCfg(324581034)
				local var_141_8 = arg_138_1:FormatText(var_141_7.content)

				arg_138_1.text_.text = var_141_8

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_9 = 21
				local var_141_10 = utf8.len(var_141_8)
				local var_141_11 = var_141_9 <= 0 and var_141_5 or var_141_5 * (var_141_10 / var_141_9)

				if var_141_11 > 0 and var_141_5 < var_141_11 then
					arg_138_1.talkMaxDuration = var_141_11

					if var_141_11 + var_141_4 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_11 + var_141_4
					end
				end

				arg_138_1.text_.text = var_141_8
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581034", "story_v_out_324581.awb") ~= 0 then
					local var_141_12 = manager.audio:GetVoiceLength("story_v_out_324581", "324581034", "story_v_out_324581.awb") / 1000

					if var_141_12 + var_141_4 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_12 + var_141_4
					end

					if var_141_7.prefab_name ~= "" and arg_138_1.actors_[var_141_7.prefab_name] ~= nil then
						local var_141_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_7.prefab_name].transform, "story_v_out_324581", "324581034", "story_v_out_324581.awb")

						arg_138_1:RecordAudio("324581034", var_141_13)
						arg_138_1:RecordAudio("324581034", var_141_13)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_324581", "324581034", "story_v_out_324581.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_324581", "324581034", "story_v_out_324581.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_14 = math.max(var_141_5, arg_138_1.talkMaxDuration)

			if var_141_4 <= arg_138_1.time_ and arg_138_1.time_ < var_141_4 + var_141_14 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_4) / var_141_14

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_4 + var_141_14 and arg_138_1.time_ < var_141_4 + var_141_14 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play324581035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 324581035
		arg_142_1.duration_ = 4.37

		local var_142_0 = {
			zh = 1.999999999999,
			ja = 4.366
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
				arg_142_0:Play324581036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1071ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1071ui_story == nil then
				arg_142_1.var_.characterEffect1071ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.200000002980232

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect1071ui_story and not isNil(var_145_0) then
					arg_142_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1071ui_story then
				arg_142_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_145_4 = arg_142_1.actors_["10170ui_story"]
			local var_145_5 = 0

			if var_145_5 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 and not isNil(var_145_4) and arg_142_1.var_.characterEffect10170ui_story == nil then
				arg_142_1.var_.characterEffect10170ui_story = var_145_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_6 = 0.200000002980232

			if var_145_5 <= arg_142_1.time_ and arg_142_1.time_ < var_145_5 + var_145_6 and not isNil(var_145_4) then
				local var_145_7 = (arg_142_1.time_ - var_145_5) / var_145_6

				if arg_142_1.var_.characterEffect10170ui_story and not isNil(var_145_4) then
					local var_145_8 = Mathf.Lerp(0, 0.5, var_145_7)

					arg_142_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_142_1.var_.characterEffect10170ui_story.fillRatio = var_145_8
				end
			end

			if arg_142_1.time_ >= var_145_5 + var_145_6 and arg_142_1.time_ < var_145_5 + var_145_6 + arg_145_0 and not isNil(var_145_4) and arg_142_1.var_.characterEffect10170ui_story then
				local var_145_9 = 0.5

				arg_142_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_142_1.var_.characterEffect10170ui_story.fillRatio = var_145_9
			end

			local var_145_10 = 0

			if var_145_10 < arg_142_1.time_ and arg_142_1.time_ <= var_145_10 + arg_145_0 then
				arg_142_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_145_11 = 0

			if var_145_11 < arg_142_1.time_ and arg_142_1.time_ <= var_145_11 + arg_145_0 then
				arg_142_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_145_12 = 0
			local var_145_13 = 0.2

			if var_145_12 < arg_142_1.time_ and arg_142_1.time_ <= var_145_12 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_14 = arg_142_1:FormatText(StoryNameCfg[384].name)

				arg_142_1.leftNameTxt_.text = var_145_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_15 = arg_142_1:GetWordFromCfg(324581035)
				local var_145_16 = arg_142_1:FormatText(var_145_15.content)

				arg_142_1.text_.text = var_145_16

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_17 = 8
				local var_145_18 = utf8.len(var_145_16)
				local var_145_19 = var_145_17 <= 0 and var_145_13 or var_145_13 * (var_145_18 / var_145_17)

				if var_145_19 > 0 and var_145_13 < var_145_19 then
					arg_142_1.talkMaxDuration = var_145_19

					if var_145_19 + var_145_12 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_19 + var_145_12
					end
				end

				arg_142_1.text_.text = var_145_16
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581035", "story_v_out_324581.awb") ~= 0 then
					local var_145_20 = manager.audio:GetVoiceLength("story_v_out_324581", "324581035", "story_v_out_324581.awb") / 1000

					if var_145_20 + var_145_12 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_20 + var_145_12
					end

					if var_145_15.prefab_name ~= "" and arg_142_1.actors_[var_145_15.prefab_name] ~= nil then
						local var_145_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_15.prefab_name].transform, "story_v_out_324581", "324581035", "story_v_out_324581.awb")

						arg_142_1:RecordAudio("324581035", var_145_21)
						arg_142_1:RecordAudio("324581035", var_145_21)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_324581", "324581035", "story_v_out_324581.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_324581", "324581035", "story_v_out_324581.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_22 = math.max(var_145_13, arg_142_1.talkMaxDuration)

			if var_145_12 <= arg_142_1.time_ and arg_142_1.time_ < var_145_12 + var_145_22 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_12) / var_145_22

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_12 + var_145_22 and arg_142_1.time_ < var_145_12 + var_145_22 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play324581036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 324581036
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play324581037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1071ui_story"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1071ui_story == nil then
				arg_146_1.var_.characterEffect1071ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect1071ui_story and not isNil(var_149_0) then
					local var_149_4 = Mathf.Lerp(0, 0.5, var_149_3)

					arg_146_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1071ui_story.fillRatio = var_149_4
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1071ui_story then
				local var_149_5 = 0.5

				arg_146_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1071ui_story.fillRatio = var_149_5
			end

			local var_149_6 = 0
			local var_149_7 = 0.275

			if var_149_6 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_8 = arg_146_1:FormatText(StoryNameCfg[7].name)

				arg_146_1.leftNameTxt_.text = var_149_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_9 = arg_146_1:GetWordFromCfg(324581036)
				local var_149_10 = arg_146_1:FormatText(var_149_9.content)

				arg_146_1.text_.text = var_149_10

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_11 = 11
				local var_149_12 = utf8.len(var_149_10)
				local var_149_13 = var_149_11 <= 0 and var_149_7 or var_149_7 * (var_149_12 / var_149_11)

				if var_149_13 > 0 and var_149_7 < var_149_13 then
					arg_146_1.talkMaxDuration = var_149_13

					if var_149_13 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_13 + var_149_6
					end
				end

				arg_146_1.text_.text = var_149_10
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_14 = math.max(var_149_7, arg_146_1.talkMaxDuration)

			if var_149_6 <= arg_146_1.time_ and arg_146_1.time_ < var_149_6 + var_149_14 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_6) / var_149_14

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_6 + var_149_14 and arg_146_1.time_ < var_149_6 + var_149_14 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play324581037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 324581037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play324581038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 0.9

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_2 = arg_150_1:FormatText(StoryNameCfg[7].name)

				arg_150_1.leftNameTxt_.text = var_153_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_3 = arg_150_1:GetWordFromCfg(324581037)
				local var_153_4 = arg_150_1:FormatText(var_153_3.content)

				arg_150_1.text_.text = var_153_4

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 36
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
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_8 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_8 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_8

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_8 and arg_150_1.time_ < var_153_0 + var_153_8 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play324581038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 324581038
		arg_154_1.duration_ = 3.17

		local var_154_0 = {
			zh = 3.166,
			ja = 2.733
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
				arg_154_0:Play324581039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["10170ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect10170ui_story == nil then
				arg_154_1.var_.characterEffect10170ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect10170ui_story and not isNil(var_157_0) then
					arg_154_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect10170ui_story then
				arg_154_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_157_4 = 0

			if var_157_4 < arg_154_1.time_ and arg_154_1.time_ <= var_157_4 + arg_157_0 then
				arg_154_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170actionlink/10170action4230")
			end

			local var_157_5 = 0

			if var_157_5 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 then
				arg_154_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_157_6 = 0
			local var_157_7 = 0.375

			if var_157_6 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_8 = arg_154_1:FormatText(StoryNameCfg[1450].name)

				arg_154_1.leftNameTxt_.text = var_157_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_9 = arg_154_1:GetWordFromCfg(324581038)
				local var_157_10 = arg_154_1:FormatText(var_157_9.content)

				arg_154_1.text_.text = var_157_10

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_11 = 15
				local var_157_12 = utf8.len(var_157_10)
				local var_157_13 = var_157_11 <= 0 and var_157_7 or var_157_7 * (var_157_12 / var_157_11)

				if var_157_13 > 0 and var_157_7 < var_157_13 then
					arg_154_1.talkMaxDuration = var_157_13

					if var_157_13 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_13 + var_157_6
					end
				end

				arg_154_1.text_.text = var_157_10
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581038", "story_v_out_324581.awb") ~= 0 then
					local var_157_14 = manager.audio:GetVoiceLength("story_v_out_324581", "324581038", "story_v_out_324581.awb") / 1000

					if var_157_14 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_14 + var_157_6
					end

					if var_157_9.prefab_name ~= "" and arg_154_1.actors_[var_157_9.prefab_name] ~= nil then
						local var_157_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_9.prefab_name].transform, "story_v_out_324581", "324581038", "story_v_out_324581.awb")

						arg_154_1:RecordAudio("324581038", var_157_15)
						arg_154_1:RecordAudio("324581038", var_157_15)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_324581", "324581038", "story_v_out_324581.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_324581", "324581038", "story_v_out_324581.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_16 = math.max(var_157_7, arg_154_1.talkMaxDuration)

			if var_157_6 <= arg_154_1.time_ and arg_154_1.time_ < var_157_6 + var_157_16 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_6) / var_157_16

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_6 + var_157_16 and arg_154_1.time_ < var_157_6 + var_157_16 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play324581039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 324581039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play324581040(arg_158_1)
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

			local var_161_11 = arg_158_1.actors_["1071ui_story"].transform
			local var_161_12 = 0

			if var_161_12 < arg_158_1.time_ and arg_158_1.time_ <= var_161_12 + arg_161_0 then
				arg_158_1.var_.moveOldPos1071ui_story = var_161_11.localPosition
			end

			local var_161_13 = 0.001

			if var_161_12 <= arg_158_1.time_ and arg_158_1.time_ < var_161_12 + var_161_13 then
				local var_161_14 = (arg_158_1.time_ - var_161_12) / var_161_13
				local var_161_15 = Vector3.New(0, 100, 0)

				var_161_11.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1071ui_story, var_161_15, var_161_14)

				local var_161_16 = manager.ui.mainCamera.transform.position - var_161_11.position

				var_161_11.forward = Vector3.New(var_161_16.x, var_161_16.y, var_161_16.z)

				local var_161_17 = var_161_11.localEulerAngles

				var_161_17.z = 0
				var_161_17.x = 0
				var_161_11.localEulerAngles = var_161_17
			end

			if arg_158_1.time_ >= var_161_12 + var_161_13 and arg_158_1.time_ < var_161_12 + var_161_13 + arg_161_0 then
				var_161_11.localPosition = Vector3.New(0, 100, 0)

				local var_161_18 = manager.ui.mainCamera.transform.position - var_161_11.position

				var_161_11.forward = Vector3.New(var_161_18.x, var_161_18.y, var_161_18.z)

				local var_161_19 = var_161_11.localEulerAngles

				var_161_19.z = 0
				var_161_19.x = 0
				var_161_11.localEulerAngles = var_161_19
			end

			local var_161_20 = arg_158_1.actors_["10170ui_story"]
			local var_161_21 = 0

			if var_161_21 < arg_158_1.time_ and arg_158_1.time_ <= var_161_21 + arg_161_0 and not isNil(var_161_20) and arg_158_1.var_.characterEffect10170ui_story == nil then
				arg_158_1.var_.characterEffect10170ui_story = var_161_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_22 = 0.200000002980232

			if var_161_21 <= arg_158_1.time_ and arg_158_1.time_ < var_161_21 + var_161_22 and not isNil(var_161_20) then
				local var_161_23 = (arg_158_1.time_ - var_161_21) / var_161_22

				if arg_158_1.var_.characterEffect10170ui_story and not isNil(var_161_20) then
					local var_161_24 = Mathf.Lerp(0, 0.5, var_161_23)

					arg_158_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_158_1.var_.characterEffect10170ui_story.fillRatio = var_161_24
				end
			end

			if arg_158_1.time_ >= var_161_21 + var_161_22 and arg_158_1.time_ < var_161_21 + var_161_22 + arg_161_0 and not isNil(var_161_20) and arg_158_1.var_.characterEffect10170ui_story then
				local var_161_25 = 0.5

				arg_158_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_158_1.var_.characterEffect10170ui_story.fillRatio = var_161_25
			end

			local var_161_26 = 0
			local var_161_27 = 1.275

			if var_161_26 < arg_158_1.time_ and arg_158_1.time_ <= var_161_26 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_28 = arg_158_1:GetWordFromCfg(324581039)
				local var_161_29 = arg_158_1:FormatText(var_161_28.content)

				arg_158_1.text_.text = var_161_29

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_30 = 51
				local var_161_31 = utf8.len(var_161_29)
				local var_161_32 = var_161_30 <= 0 and var_161_27 or var_161_27 * (var_161_31 / var_161_30)

				if var_161_32 > 0 and var_161_27 < var_161_32 then
					arg_158_1.talkMaxDuration = var_161_32

					if var_161_32 + var_161_26 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_32 + var_161_26
					end
				end

				arg_158_1.text_.text = var_161_29
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_33 = math.max(var_161_27, arg_158_1.talkMaxDuration)

			if var_161_26 <= arg_158_1.time_ and arg_158_1.time_ < var_161_26 + var_161_33 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_26) / var_161_33

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_26 + var_161_33 and arg_158_1.time_ < var_161_26 + var_161_33 + arg_161_0 then
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

		arg_158_1:InitPlayNodeList()
	end,
	Play324581040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 324581040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play324581041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 1.525

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_2 = arg_162_1:GetWordFromCfg(324581040)
				local var_165_3 = arg_162_1:FormatText(var_165_2.content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 61
				local var_165_5 = utf8.len(var_165_3)
				local var_165_6 = var_165_4 <= 0 and var_165_1 or var_165_1 * (var_165_5 / var_165_4)

				if var_165_6 > 0 and var_165_1 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_7 and arg_162_1.time_ < var_165_0 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play324581041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 324581041
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play324581042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0
			local var_169_1 = 0.675

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_2 = arg_166_1:GetWordFromCfg(324581041)
				local var_169_3 = arg_166_1:FormatText(var_169_2.content)

				arg_166_1.text_.text = var_169_3

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_4 = 27
				local var_169_5 = utf8.len(var_169_3)
				local var_169_6 = var_169_4 <= 0 and var_169_1 or var_169_1 * (var_169_5 / var_169_4)

				if var_169_6 > 0 and var_169_1 < var_169_6 then
					arg_166_1.talkMaxDuration = var_169_6

					if var_169_6 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_6 + var_169_0
					end
				end

				arg_166_1.text_.text = var_169_3
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_7 = math.max(var_169_1, arg_166_1.talkMaxDuration)

			if var_169_0 <= arg_166_1.time_ and arg_166_1.time_ < var_169_0 + var_169_7 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_0) / var_169_7

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_0 + var_169_7 and arg_166_1.time_ < var_169_0 + var_169_7 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play324581042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 324581042
		arg_170_1.duration_ = 2

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play324581043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["10170ui_story"].transform
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.var_.moveOldPos10170ui_story = var_173_0.localPosition

				local var_173_2 = GameObjectTools.GetOrAddComponent(var_173_0.gameObject, typeof(DynamicBoneHelper))

				if var_173_2 then
					var_173_2:EnableDynamicBone(false)
				end
			end

			local var_173_3 = 0.001

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_3 then
				local var_173_4 = (arg_170_1.time_ - var_173_1) / var_173_3
				local var_173_5 = Vector3.New(0, -1.03, -6.05)

				var_173_0.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos10170ui_story, var_173_5, var_173_4)

				local var_173_6 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_6.x, var_173_6.y, var_173_6.z)

				local var_173_7 = var_173_0.localEulerAngles

				var_173_7.z = 0
				var_173_7.x = 0
				var_173_0.localEulerAngles = var_173_7
			end

			if arg_170_1.time_ >= var_173_1 + var_173_3 and arg_170_1.time_ < var_173_1 + var_173_3 + arg_173_0 then
				var_173_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_173_8 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_8.x, var_173_8.y, var_173_8.z)

				local var_173_9 = var_173_0.localEulerAngles

				var_173_9.z = 0
				var_173_9.x = 0
				var_173_0.localEulerAngles = var_173_9

				local var_173_10 = GameObjectTools.GetOrAddComponent(var_173_0.gameObject, typeof(DynamicBoneHelper))

				if var_173_10 then
					var_173_10:EnableDynamicBone(true)
				end
			end

			local var_173_11 = arg_170_1.actors_["10170ui_story"]
			local var_173_12 = 0

			if var_173_12 < arg_170_1.time_ and arg_170_1.time_ <= var_173_12 + arg_173_0 and not isNil(var_173_11) and arg_170_1.var_.characterEffect10170ui_story == nil then
				arg_170_1.var_.characterEffect10170ui_story = var_173_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_13 = 0.200000002980232

			if var_173_12 <= arg_170_1.time_ and arg_170_1.time_ < var_173_12 + var_173_13 and not isNil(var_173_11) then
				local var_173_14 = (arg_170_1.time_ - var_173_12) / var_173_13

				if arg_170_1.var_.characterEffect10170ui_story and not isNil(var_173_11) then
					arg_170_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= var_173_12 + var_173_13 and arg_170_1.time_ < var_173_12 + var_173_13 + arg_173_0 and not isNil(var_173_11) and arg_170_1.var_.characterEffect10170ui_story then
				arg_170_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_173_15 = 0

			if var_173_15 < arg_170_1.time_ and arg_170_1.time_ <= var_173_15 + arg_173_0 then
				arg_170_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action30_2")
			end

			local var_173_16 = 0

			if var_173_16 < arg_170_1.time_ and arg_170_1.time_ <= var_173_16 + arg_173_0 then
				arg_170_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_173_17 = 0
			local var_173_18 = 0.175

			if var_173_17 < arg_170_1.time_ and arg_170_1.time_ <= var_173_17 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_19 = arg_170_1:FormatText(StoryNameCfg[1450].name)

				arg_170_1.leftNameTxt_.text = var_173_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_20 = arg_170_1:GetWordFromCfg(324581042)
				local var_173_21 = arg_170_1:FormatText(var_173_20.content)

				arg_170_1.text_.text = var_173_21

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_22 = 7
				local var_173_23 = utf8.len(var_173_21)
				local var_173_24 = var_173_22 <= 0 and var_173_18 or var_173_18 * (var_173_23 / var_173_22)

				if var_173_24 > 0 and var_173_18 < var_173_24 then
					arg_170_1.talkMaxDuration = var_173_24

					if var_173_24 + var_173_17 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_24 + var_173_17
					end
				end

				arg_170_1.text_.text = var_173_21
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324581", "324581042", "story_v_out_324581.awb") ~= 0 then
					local var_173_25 = manager.audio:GetVoiceLength("story_v_out_324581", "324581042", "story_v_out_324581.awb") / 1000

					if var_173_25 + var_173_17 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_25 + var_173_17
					end

					if var_173_20.prefab_name ~= "" and arg_170_1.actors_[var_173_20.prefab_name] ~= nil then
						local var_173_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_20.prefab_name].transform, "story_v_out_324581", "324581042", "story_v_out_324581.awb")

						arg_170_1:RecordAudio("324581042", var_173_26)
						arg_170_1:RecordAudio("324581042", var_173_26)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_324581", "324581042", "story_v_out_324581.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_324581", "324581042", "story_v_out_324581.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_27 = math.max(var_173_18, arg_170_1.talkMaxDuration)

			if var_173_17 <= arg_170_1.time_ and arg_170_1.time_ < var_173_17 + var_173_27 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_17) / var_173_27

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_17 + var_173_27 and arg_170_1.time_ < var_173_17 + var_173_27 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
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

		arg_170_1:InitPlayNodeList()
	end,
	Play324581043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 324581043
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
			arg_174_1.auto_ = false
		end

		function arg_174_1.playNext_(arg_176_0)
			arg_174_1.onStoryFinished_()
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["10170ui_story"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect10170ui_story == nil then
				arg_174_1.var_.characterEffect10170ui_story = var_177_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.200000002980232

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.characterEffect10170ui_story and not isNil(var_177_0) then
					local var_177_4 = Mathf.Lerp(0, 0.5, var_177_3)

					arg_174_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_174_1.var_.characterEffect10170ui_story.fillRatio = var_177_4
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect10170ui_story then
				local var_177_5 = 0.5

				arg_174_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_174_1.var_.characterEffect10170ui_story.fillRatio = var_177_5
			end

			local var_177_6 = 0
			local var_177_7 = 0.65

			if var_177_6 < arg_174_1.time_ and arg_174_1.time_ <= var_177_6 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_8 = arg_174_1:FormatText(StoryNameCfg[7].name)

				arg_174_1.leftNameTxt_.text = var_177_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_9 = arg_174_1:GetWordFromCfg(324581043)
				local var_177_10 = arg_174_1:FormatText(var_177_9.content)

				arg_174_1.text_.text = var_177_10

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_11 = 26
				local var_177_12 = utf8.len(var_177_10)
				local var_177_13 = var_177_11 <= 0 and var_177_7 or var_177_7 * (var_177_12 / var_177_11)

				if var_177_13 > 0 and var_177_7 < var_177_13 then
					arg_174_1.talkMaxDuration = var_177_13

					if var_177_13 + var_177_6 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_13 + var_177_6
					end
				end

				arg_174_1.text_.text = var_177_10
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_14 = math.max(var_177_7, arg_174_1.talkMaxDuration)

			if var_177_6 <= arg_174_1.time_ and arg_174_1.time_ < var_177_6 + var_177_14 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_6) / var_177_14

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_6 + var_177_14 and arg_174_1.time_ < var_177_6 + var_177_14 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J21h",
		"TextureConfig/Background/ST32"
	},
	voices = {
		"story_v_out_324581.awb"
	}
}
