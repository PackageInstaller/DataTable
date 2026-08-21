return {
	Play321231001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321231001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play321231002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L12f"

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
				local var_4_5 = arg_1_1.bgs_.L12f

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
					if iter_4_0 ~= "L12f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.999999999998

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

			local var_4_24 = 0
			local var_4_25 = 0.2

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

			local var_4_30 = 0.3
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_36 = 1.999999999999
			local var_4_37 = 0.3

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_39

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

				local var_4_40 = arg_1_1:GetWordFromCfg(321231001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 12
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_37 or var_4_37 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_37 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_36 = var_4_36 + 0.3

					if var_4_44 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_36 + 0.3
			local var_4_46 = math.max(var_4_37, arg_1_1.talkMaxDuration)

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
	Play321231002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321231002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321231003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.7

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

				local var_12_2 = arg_9_1:GetWordFromCfg(321231002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 68
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
	Play321231003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321231003
		arg_13_1.duration_ = 5.07

		local var_13_0 = {
			zh = 5.066,
			ja = 1.999999999999
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
				arg_13_0:Play321231004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "404001ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["404001ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos404001ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0, -1.55, -5.5)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos404001ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["404001ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect404001ui_story == nil then
				arg_13_1.var_.characterEffect404001ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect404001ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect404001ui_story then
				arg_13_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action8_2")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_16_20 = 0
			local var_16_21 = 0.425

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[668].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(321231003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 17
				local var_16_26 = utf8.len(var_16_24)
				local var_16_27 = var_16_25 <= 0 and var_16_21 or var_16_21 * (var_16_26 / var_16_25)

				if var_16_27 > 0 and var_16_21 < var_16_27 then
					arg_13_1.talkMaxDuration = var_16_27

					if var_16_27 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_20
					end
				end

				arg_13_1.text_.text = var_16_24
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231003", "story_v_out_321231.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_out_321231", "321231003", "story_v_out_321231.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_out_321231", "321231003", "story_v_out_321231.awb")

						arg_13_1:RecordAudio("321231003", var_16_29)
						arg_13_1:RecordAudio("321231003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_321231", "321231003", "story_v_out_321231.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_321231", "321231003", "story_v_out_321231.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_30 = math.max(var_16_21, arg_13_1.talkMaxDuration)

			if var_16_20 <= arg_13_1.time_ and arg_13_1.time_ < var_16_20 + var_16_30 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_20) / var_16_30

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_20 + var_16_30 and arg_13_1.time_ < var_16_20 + var_16_30 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play321231004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321231004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play321231005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["404001ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect404001ui_story == nil then
				arg_17_1.var_.characterEffect404001ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect404001ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_17_1.var_.characterEffect404001ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect404001ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_17_1.var_.characterEffect404001ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.975

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_8 = arg_17_1:GetWordFromCfg(321231004)
				local var_20_9 = arg_17_1:FormatText(var_20_8.content)

				arg_17_1.text_.text = var_20_9

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 39
				local var_20_11 = utf8.len(var_20_9)
				local var_20_12 = var_20_10 <= 0 and var_20_7 or var_20_7 * (var_20_11 / var_20_10)

				if var_20_12 > 0 and var_20_7 < var_20_12 then
					arg_17_1.talkMaxDuration = var_20_12

					if var_20_12 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_9
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_13 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_13 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_13

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_13 and arg_17_1.time_ < var_20_6 + var_20_13 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play321231005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321231005
		arg_21_1.duration_ = 3

		local var_21_0 = {
			zh = 2.233,
			ja = 3
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
				arg_21_0:Play321231006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["404001ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos404001ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos404001ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, 100, 0)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = "1284ui_story"

			if arg_21_1.actors_[var_24_9] == nil then
				local var_24_10 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_24_10) then
					local var_24_11 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_21_1.stage_.transform)

					var_24_11.name = var_24_9
					var_24_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_9] = var_24_11

					local var_24_12 = var_24_11:GetComponentInChildren(typeof(CharacterEffect))

					var_24_12.enabled = true

					local var_24_13 = GameObjectTools.GetOrAddComponent(var_24_11, typeof(DynamicBoneHelper))

					if var_24_13 then
						var_24_13:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_12.transform, false)

					arg_21_1.var_[var_24_9 .. "Animator"] = var_24_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_9 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_9 .. "LipSync"] = var_24_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_14 = arg_21_1.actors_["1284ui_story"].transform
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.var_.moveOldPos1284ui_story = var_24_14.localPosition
			end

			local var_24_16 = 0.001

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16
				local var_24_18 = Vector3.New(0, -0.985, -6.22)

				var_24_14.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1284ui_story, var_24_18, var_24_17)

				local var_24_19 = manager.ui.mainCamera.transform.position - var_24_14.position

				var_24_14.forward = Vector3.New(var_24_19.x, var_24_19.y, var_24_19.z)

				local var_24_20 = var_24_14.localEulerAngles

				var_24_20.z = 0
				var_24_20.x = 0
				var_24_14.localEulerAngles = var_24_20
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 then
				var_24_14.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_24_21 = manager.ui.mainCamera.transform.position - var_24_14.position

				var_24_14.forward = Vector3.New(var_24_21.x, var_24_21.y, var_24_21.z)

				local var_24_22 = var_24_14.localEulerAngles

				var_24_22.z = 0
				var_24_22.x = 0
				var_24_14.localEulerAngles = var_24_22
			end

			local var_24_23 = arg_21_1.actors_["1284ui_story"]
			local var_24_24 = 0

			if var_24_24 < arg_21_1.time_ and arg_21_1.time_ <= var_24_24 + arg_24_0 and not isNil(var_24_23) and arg_21_1.var_.characterEffect1284ui_story == nil then
				arg_21_1.var_.characterEffect1284ui_story = var_24_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_25 = 0.200000002980232

			if var_24_24 <= arg_21_1.time_ and arg_21_1.time_ < var_24_24 + var_24_25 and not isNil(var_24_23) then
				local var_24_26 = (arg_21_1.time_ - var_24_24) / var_24_25

				if arg_21_1.var_.characterEffect1284ui_story and not isNil(var_24_23) then
					arg_21_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_24 + var_24_25 and arg_21_1.time_ < var_24_24 + var_24_25 + arg_24_0 and not isNil(var_24_23) and arg_21_1.var_.characterEffect1284ui_story then
				arg_21_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_24_27 = 0

			if var_24_27 < arg_21_1.time_ and arg_21_1.time_ <= var_24_27 + arg_24_0 then
				arg_21_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_24_28 = 0

			if var_24_28 < arg_21_1.time_ and arg_21_1.time_ <= var_24_28 + arg_24_0 then
				arg_21_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_24_29 = 0
			local var_24_30 = 0.2

			if var_24_29 < arg_21_1.time_ and arg_21_1.time_ <= var_24_29 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_31 = arg_21_1:FormatText(StoryNameCfg[6].name)

				arg_21_1.leftNameTxt_.text = var_24_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_32 = arg_21_1:GetWordFromCfg(321231005)
				local var_24_33 = arg_21_1:FormatText(var_24_32.content)

				arg_21_1.text_.text = var_24_33

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_34 = 8
				local var_24_35 = utf8.len(var_24_33)
				local var_24_36 = var_24_34 <= 0 and var_24_30 or var_24_30 * (var_24_35 / var_24_34)

				if var_24_36 > 0 and var_24_30 < var_24_36 then
					arg_21_1.talkMaxDuration = var_24_36

					if var_24_36 + var_24_29 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_36 + var_24_29
					end
				end

				arg_21_1.text_.text = var_24_33
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231005", "story_v_out_321231.awb") ~= 0 then
					local var_24_37 = manager.audio:GetVoiceLength("story_v_out_321231", "321231005", "story_v_out_321231.awb") / 1000

					if var_24_37 + var_24_29 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_37 + var_24_29
					end

					if var_24_32.prefab_name ~= "" and arg_21_1.actors_[var_24_32.prefab_name] ~= nil then
						local var_24_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_32.prefab_name].transform, "story_v_out_321231", "321231005", "story_v_out_321231.awb")

						arg_21_1:RecordAudio("321231005", var_24_38)
						arg_21_1:RecordAudio("321231005", var_24_38)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_321231", "321231005", "story_v_out_321231.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_321231", "321231005", "story_v_out_321231.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_39 = math.max(var_24_30, arg_21_1.talkMaxDuration)

			if var_24_29 <= arg_21_1.time_ and arg_21_1.time_ < var_24_29 + var_24_39 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_29) / var_24_39

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_29 + var_24_39 and arg_21_1.time_ < var_24_29 + var_24_39 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play321231006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321231006
		arg_25_1.duration_ = 10.47

		local var_25_0 = {
			zh = 7.166,
			ja = 10.466
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
				arg_25_0:Play321231007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["404001ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect404001ui_story == nil then
				arg_25_1.var_.characterEffect404001ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect404001ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect404001ui_story then
				arg_25_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_28_4 = arg_25_1.actors_["1284ui_story"]
			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect1284ui_story == nil then
				arg_25_1.var_.characterEffect1284ui_story = var_28_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.200000002980232

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_6 and not isNil(var_28_4) then
				local var_28_7 = (arg_25_1.time_ - var_28_5) / var_28_6

				if arg_25_1.var_.characterEffect1284ui_story and not isNil(var_28_4) then
					local var_28_8 = Mathf.Lerp(0, 0.5, var_28_7)

					arg_25_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1284ui_story.fillRatio = var_28_8
				end
			end

			if arg_25_1.time_ >= var_28_5 + var_28_6 and arg_25_1.time_ < var_28_5 + var_28_6 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect1284ui_story then
				local var_28_9 = 0.5

				arg_25_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1284ui_story.fillRatio = var_28_9
			end

			local var_28_10 = 0
			local var_28_11 = 0.675

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_12 = arg_25_1:FormatText(StoryNameCfg[668].name)

				arg_25_1.leftNameTxt_.text = var_28_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_13 = arg_25_1:GetWordFromCfg(321231006)
				local var_28_14 = arg_25_1:FormatText(var_28_13.content)

				arg_25_1.text_.text = var_28_14

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_15 = 27
				local var_28_16 = utf8.len(var_28_14)
				local var_28_17 = var_28_15 <= 0 and var_28_11 or var_28_11 * (var_28_16 / var_28_15)

				if var_28_17 > 0 and var_28_11 < var_28_17 then
					arg_25_1.talkMaxDuration = var_28_17

					if var_28_17 + var_28_10 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_17 + var_28_10
					end
				end

				arg_25_1.text_.text = var_28_14
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231006", "story_v_out_321231.awb") ~= 0 then
					local var_28_18 = manager.audio:GetVoiceLength("story_v_out_321231", "321231006", "story_v_out_321231.awb") / 1000

					if var_28_18 + var_28_10 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_18 + var_28_10
					end

					if var_28_13.prefab_name ~= "" and arg_25_1.actors_[var_28_13.prefab_name] ~= nil then
						local var_28_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_13.prefab_name].transform, "story_v_out_321231", "321231006", "story_v_out_321231.awb")

						arg_25_1:RecordAudio("321231006", var_28_19)
						arg_25_1:RecordAudio("321231006", var_28_19)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_321231", "321231006", "story_v_out_321231.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_321231", "321231006", "story_v_out_321231.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_20 = math.max(var_28_11, arg_25_1.talkMaxDuration)

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_20 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_10) / var_28_20

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_10 + var_28_20 and arg_25_1.time_ < var_28_10 + var_28_20 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play321231007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321231007
		arg_29_1.duration_ = 3

		local var_29_0 = {
			zh = 1.999999999999,
			ja = 3
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
				arg_29_0:Play321231008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1284ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1284ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0, -0.985, -6.22)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1284ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["1284ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1284ui_story == nil then
				arg_29_1.var_.characterEffect1284ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect1284ui_story and not isNil(var_32_9) then
					arg_29_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1284ui_story then
				arg_29_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_32_13 = arg_29_1.actors_["404001ui_story"]
			local var_32_14 = 0

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 and not isNil(var_32_13) and arg_29_1.var_.characterEffect404001ui_story == nil then
				arg_29_1.var_.characterEffect404001ui_story = var_32_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_15 = 0.200000002980232

			if var_32_14 <= arg_29_1.time_ and arg_29_1.time_ < var_32_14 + var_32_15 and not isNil(var_32_13) then
				local var_32_16 = (arg_29_1.time_ - var_32_14) / var_32_15

				if arg_29_1.var_.characterEffect404001ui_story and not isNil(var_32_13) then
					local var_32_17 = Mathf.Lerp(0, 0.5, var_32_16)

					arg_29_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_29_1.var_.characterEffect404001ui_story.fillRatio = var_32_17
				end
			end

			if arg_29_1.time_ >= var_32_14 + var_32_15 and arg_29_1.time_ < var_32_14 + var_32_15 + arg_32_0 and not isNil(var_32_13) and arg_29_1.var_.characterEffect404001ui_story then
				local var_32_18 = 0.5

				arg_29_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_29_1.var_.characterEffect404001ui_story.fillRatio = var_32_18
			end

			local var_32_19 = 0

			if var_32_19 < arg_29_1.time_ and arg_29_1.time_ <= var_32_19 + arg_32_0 then
				arg_29_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			local var_32_20 = 0
			local var_32_21 = 0.2

			if var_32_20 < arg_29_1.time_ and arg_29_1.time_ <= var_32_20 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_22 = arg_29_1:FormatText(StoryNameCfg[6].name)

				arg_29_1.leftNameTxt_.text = var_32_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_23 = arg_29_1:GetWordFromCfg(321231007)
				local var_32_24 = arg_29_1:FormatText(var_32_23.content)

				arg_29_1.text_.text = var_32_24

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_25 = 8
				local var_32_26 = utf8.len(var_32_24)
				local var_32_27 = var_32_25 <= 0 and var_32_21 or var_32_21 * (var_32_26 / var_32_25)

				if var_32_27 > 0 and var_32_21 < var_32_27 then
					arg_29_1.talkMaxDuration = var_32_27

					if var_32_27 + var_32_20 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_27 + var_32_20
					end
				end

				arg_29_1.text_.text = var_32_24
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231007", "story_v_out_321231.awb") ~= 0 then
					local var_32_28 = manager.audio:GetVoiceLength("story_v_out_321231", "321231007", "story_v_out_321231.awb") / 1000

					if var_32_28 + var_32_20 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_28 + var_32_20
					end

					if var_32_23.prefab_name ~= "" and arg_29_1.actors_[var_32_23.prefab_name] ~= nil then
						local var_32_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_23.prefab_name].transform, "story_v_out_321231", "321231007", "story_v_out_321231.awb")

						arg_29_1:RecordAudio("321231007", var_32_29)
						arg_29_1:RecordAudio("321231007", var_32_29)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321231", "321231007", "story_v_out_321231.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321231", "321231007", "story_v_out_321231.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_30 = math.max(var_32_21, arg_29_1.talkMaxDuration)

			if var_32_20 <= arg_29_1.time_ and arg_29_1.time_ < var_32_20 + var_32_30 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_20) / var_32_30

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_20 + var_32_30 and arg_29_1.time_ < var_32_20 + var_32_30 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play321231008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321231008
		arg_33_1.duration_ = 10.6

		local var_33_0 = {
			zh = 6.1,
			ja = 10.6
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
				arg_33_0:Play321231009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["404001ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect404001ui_story == nil then
				arg_33_1.var_.characterEffect404001ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect404001ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect404001ui_story then
				arg_33_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_36_4 = arg_33_1.actors_["1284ui_story"]
			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1284ui_story == nil then
				arg_33_1.var_.characterEffect1284ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_6 and not isNil(var_36_4) then
				local var_36_7 = (arg_33_1.time_ - var_36_5) / var_36_6

				if arg_33_1.var_.characterEffect1284ui_story and not isNil(var_36_4) then
					local var_36_8 = Mathf.Lerp(0, 0.5, var_36_7)

					arg_33_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1284ui_story.fillRatio = var_36_8
				end
			end

			if arg_33_1.time_ >= var_36_5 + var_36_6 and arg_33_1.time_ < var_36_5 + var_36_6 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1284ui_story then
				local var_36_9 = 0.5

				arg_33_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1284ui_story.fillRatio = var_36_9
			end

			local var_36_10 = 0
			local var_36_11 = 0.55

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_12 = arg_33_1:FormatText(StoryNameCfg[668].name)

				arg_33_1.leftNameTxt_.text = var_36_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_13 = arg_33_1:GetWordFromCfg(321231008)
				local var_36_14 = arg_33_1:FormatText(var_36_13.content)

				arg_33_1.text_.text = var_36_14

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_15 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231008", "story_v_out_321231.awb") ~= 0 then
					local var_36_18 = manager.audio:GetVoiceLength("story_v_out_321231", "321231008", "story_v_out_321231.awb") / 1000

					if var_36_18 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_10
					end

					if var_36_13.prefab_name ~= "" and arg_33_1.actors_[var_36_13.prefab_name] ~= nil then
						local var_36_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_13.prefab_name].transform, "story_v_out_321231", "321231008", "story_v_out_321231.awb")

						arg_33_1:RecordAudio("321231008", var_36_19)
						arg_33_1:RecordAudio("321231008", var_36_19)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321231", "321231008", "story_v_out_321231.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321231", "321231008", "story_v_out_321231.awb")
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
	Play321231009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321231009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play321231010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["404001ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect404001ui_story == nil then
				arg_37_1.var_.characterEffect404001ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect404001ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_37_1.var_.characterEffect404001ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect404001ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_37_1.var_.characterEffect404001ui_story.fillRatio = var_40_5
			end

			local var_40_6 = arg_37_1.actors_["1284ui_story"].transform
			local var_40_7 = 0

			if var_40_7 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.var_.moveOldPos1284ui_story = var_40_6.localPosition
			end

			local var_40_8 = 0.001

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_8 then
				local var_40_9 = (arg_37_1.time_ - var_40_7) / var_40_8
				local var_40_10 = Vector3.New(0, 100, 0)

				var_40_6.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1284ui_story, var_40_10, var_40_9)

				local var_40_11 = manager.ui.mainCamera.transform.position - var_40_6.position

				var_40_6.forward = Vector3.New(var_40_11.x, var_40_11.y, var_40_11.z)

				local var_40_12 = var_40_6.localEulerAngles

				var_40_12.z = 0
				var_40_12.x = 0
				var_40_6.localEulerAngles = var_40_12
			end

			if arg_37_1.time_ >= var_40_7 + var_40_8 and arg_37_1.time_ < var_40_7 + var_40_8 + arg_40_0 then
				var_40_6.localPosition = Vector3.New(0, 100, 0)

				local var_40_13 = manager.ui.mainCamera.transform.position - var_40_6.position

				var_40_6.forward = Vector3.New(var_40_13.x, var_40_13.y, var_40_13.z)

				local var_40_14 = var_40_6.localEulerAngles

				var_40_14.z = 0
				var_40_14.x = 0
				var_40_6.localEulerAngles = var_40_14
			end

			local var_40_15 = 0
			local var_40_16 = 1.15

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_17 = arg_37_1:GetWordFromCfg(321231009)
				local var_40_18 = arg_37_1:FormatText(var_40_17.content)

				arg_37_1.text_.text = var_40_18

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_19 = 46
				local var_40_20 = utf8.len(var_40_18)
				local var_40_21 = var_40_19 <= 0 and var_40_16 or var_40_16 * (var_40_20 / var_40_19)

				if var_40_21 > 0 and var_40_16 < var_40_21 then
					arg_37_1.talkMaxDuration = var_40_21

					if var_40_21 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_21 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_18
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_22 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_22 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_22

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_22 and arg_37_1.time_ < var_40_15 + var_40_22 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play321231010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321231010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play321231011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.5

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

				local var_44_2 = arg_41_1:GetWordFromCfg(321231010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 20
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
	Play321231011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 321231011
		arg_45_1.duration_ = 5.73

		local var_45_0 = {
			zh = 5.066,
			ja = 5.733
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
				arg_45_0:Play321231012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["404001ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos404001ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, -1.55, -5.5)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos404001ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["404001ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect404001ui_story == nil then
				arg_45_1.var_.characterEffect404001ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 and not isNil(var_48_9) then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect404001ui_story and not isNil(var_48_9) then
					arg_45_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect404001ui_story then
				arg_45_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_48_13 = 0

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 then
				arg_45_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action8_2")
			end

			local var_48_14 = 0
			local var_48_15 = 0.4

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_16 = arg_45_1:FormatText(StoryNameCfg[668].name)

				arg_45_1.leftNameTxt_.text = var_48_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_17 = arg_45_1:GetWordFromCfg(321231011)
				local var_48_18 = arg_45_1:FormatText(var_48_17.content)

				arg_45_1.text_.text = var_48_18

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_19 = 16
				local var_48_20 = utf8.len(var_48_18)
				local var_48_21 = var_48_19 <= 0 and var_48_15 or var_48_15 * (var_48_20 / var_48_19)

				if var_48_21 > 0 and var_48_15 < var_48_21 then
					arg_45_1.talkMaxDuration = var_48_21

					if var_48_21 + var_48_14 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_21 + var_48_14
					end
				end

				arg_45_1.text_.text = var_48_18
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231011", "story_v_out_321231.awb") ~= 0 then
					local var_48_22 = manager.audio:GetVoiceLength("story_v_out_321231", "321231011", "story_v_out_321231.awb") / 1000

					if var_48_22 + var_48_14 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_22 + var_48_14
					end

					if var_48_17.prefab_name ~= "" and arg_45_1.actors_[var_48_17.prefab_name] ~= nil then
						local var_48_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_17.prefab_name].transform, "story_v_out_321231", "321231011", "story_v_out_321231.awb")

						arg_45_1:RecordAudio("321231011", var_48_23)
						arg_45_1:RecordAudio("321231011", var_48_23)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_321231", "321231011", "story_v_out_321231.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_321231", "321231011", "story_v_out_321231.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_24 = math.max(var_48_15, arg_45_1.talkMaxDuration)

			if var_48_14 <= arg_45_1.time_ and arg_45_1.time_ < var_48_14 + var_48_24 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_14) / var_48_24

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_14 + var_48_24 and arg_45_1.time_ < var_48_14 + var_48_24 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play321231012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 321231012
		arg_49_1.duration_ = 7.6

		local var_49_0 = {
			zh = 4.333,
			ja = 7.6
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
				arg_49_0:Play321231013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.475

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[668].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(321231012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 19
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231012", "story_v_out_321231.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_321231", "321231012", "story_v_out_321231.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_321231", "321231012", "story_v_out_321231.awb")

						arg_49_1:RecordAudio("321231012", var_52_9)
						arg_49_1:RecordAudio("321231012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_321231", "321231012", "story_v_out_321231.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_321231", "321231012", "story_v_out_321231.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play321231013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 321231013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play321231014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["404001ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect404001ui_story == nil then
				arg_53_1.var_.characterEffect404001ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect404001ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_53_1.var_.characterEffect404001ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect404001ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_53_1.var_.characterEffect404001ui_story.fillRatio = var_56_5
			end

			local var_56_6 = 0
			local var_56_7 = 0.1

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_8 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_9 = arg_53_1:GetWordFromCfg(321231013)
				local var_56_10 = arg_53_1:FormatText(var_56_9.content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 4
				local var_56_12 = utf8.len(var_56_10)
				local var_56_13 = var_56_11 <= 0 and var_56_7 or var_56_7 * (var_56_12 / var_56_11)

				if var_56_13 > 0 and var_56_7 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_10
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_14 and arg_53_1.time_ < var_56_6 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play321231014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 321231014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play321231015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.3

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(321231014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 12
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_8 and arg_57_1.time_ < var_60_0 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play321231015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 321231015
		arg_61_1.duration_ = 8.1

		local var_61_0 = {
			zh = 2.5,
			ja = 8.1
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
				arg_61_0:Play321231016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["404001ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos404001ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0, 100, 0)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos404001ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, 100, 0)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = 0
			local var_64_10 = 0.375

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_11 = arg_61_1:FormatText(StoryNameCfg[36].name)

				arg_61_1.leftNameTxt_.text = var_64_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_12 = arg_61_1:GetWordFromCfg(321231015)
				local var_64_13 = arg_61_1:FormatText(var_64_12.content)

				arg_61_1.text_.text = var_64_13

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_14 = 15
				local var_64_15 = utf8.len(var_64_13)
				local var_64_16 = var_64_14 <= 0 and var_64_10 or var_64_10 * (var_64_15 / var_64_14)

				if var_64_16 > 0 and var_64_10 < var_64_16 then
					arg_61_1.talkMaxDuration = var_64_16

					if var_64_16 + var_64_9 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_16 + var_64_9
					end
				end

				arg_61_1.text_.text = var_64_13
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231015", "story_v_out_321231.awb") ~= 0 then
					local var_64_17 = manager.audio:GetVoiceLength("story_v_out_321231", "321231015", "story_v_out_321231.awb") / 1000

					if var_64_17 + var_64_9 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_17 + var_64_9
					end

					if var_64_12.prefab_name ~= "" and arg_61_1.actors_[var_64_12.prefab_name] ~= nil then
						local var_64_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_12.prefab_name].transform, "story_v_out_321231", "321231015", "story_v_out_321231.awb")

						arg_61_1:RecordAudio("321231015", var_64_18)
						arg_61_1:RecordAudio("321231015", var_64_18)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_321231", "321231015", "story_v_out_321231.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_321231", "321231015", "story_v_out_321231.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_19 = math.max(var_64_10, arg_61_1.talkMaxDuration)

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_19 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_9) / var_64_19

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_9 + var_64_19 and arg_61_1.time_ < var_64_9 + var_64_19 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play321231016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 321231016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play321231017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 1

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				local var_68_2 = "play"
				local var_68_3 = "effect"

				arg_65_1:AudioAction(var_68_2, var_68_3, "se_story_1310", "se_story_1310_car01", "")
			end

			local var_68_4 = 0
			local var_68_5 = 1

			if var_68_4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(321231016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_8 = 40
				local var_68_9 = utf8.len(var_68_7)
				local var_68_10 = var_68_8 <= 0 and var_68_5 or var_68_5 * (var_68_9 / var_68_8)

				if var_68_10 > 0 and var_68_5 < var_68_10 then
					arg_65_1.talkMaxDuration = var_68_10

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_11 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_11 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_11

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_11 and arg_65_1.time_ < var_68_4 + var_68_11 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play321231017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 321231017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play321231018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.075

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[7].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(321231017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 3
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
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_8 and arg_69_1.time_ < var_72_0 + var_72_8 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play321231018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 321231018
		arg_73_1.duration_ = 5.23

		local var_73_0 = {
			zh = 3.866,
			ja = 5.233
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
				arg_73_0:Play321231019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.35

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[668].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(321231018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 14
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231018", "story_v_out_321231.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_321231", "321231018", "story_v_out_321231.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_321231", "321231018", "story_v_out_321231.awb")

						arg_73_1:RecordAudio("321231018", var_76_9)
						arg_73_1:RecordAudio("321231018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_321231", "321231018", "story_v_out_321231.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_321231", "321231018", "story_v_out_321231.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play321231019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 321231019
		arg_77_1.duration_ = 5.4

		local var_77_0 = {
			zh = 4.733,
			ja = 5.4
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
				arg_77_0:Play321231020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["404001ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect404001ui_story == nil then
				arg_77_1.var_.characterEffect404001ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect404001ui_story and not isNil(var_80_0) then
					local var_80_4 = Mathf.Lerp(0, 0.5, var_80_3)

					arg_77_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_77_1.var_.characterEffect404001ui_story.fillRatio = var_80_4
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect404001ui_story then
				local var_80_5 = 0.5

				arg_77_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_77_1.var_.characterEffect404001ui_story.fillRatio = var_80_5
			end

			local var_80_6 = 0
			local var_80_7 = 0.525

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_8 = arg_77_1:FormatText(StoryNameCfg[1180].name)

				arg_77_1.leftNameTxt_.text = var_80_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_9 = arg_77_1:GetWordFromCfg(321231019)
				local var_80_10 = arg_77_1:FormatText(var_80_9.content)

				arg_77_1.text_.text = var_80_10

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 21
				local var_80_12 = utf8.len(var_80_10)
				local var_80_13 = var_80_11 <= 0 and var_80_7 or var_80_7 * (var_80_12 / var_80_11)

				if var_80_13 > 0 and var_80_7 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_10
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231019", "story_v_out_321231.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_321231", "321231019", "story_v_out_321231.awb") / 1000

					if var_80_14 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_6
					end

					if var_80_9.prefab_name ~= "" and arg_77_1.actors_[var_80_9.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_9.prefab_name].transform, "story_v_out_321231", "321231019", "story_v_out_321231.awb")

						arg_77_1:RecordAudio("321231019", var_80_15)
						arg_77_1:RecordAudio("321231019", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_321231", "321231019", "story_v_out_321231.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_321231", "321231019", "story_v_out_321231.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_16 and arg_77_1.time_ < var_80_6 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play321231020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 321231020
		arg_81_1.duration_ = 1

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"

			SetActive(arg_81_1.choicesGo_, true)

			for iter_82_0, iter_82_1 in ipairs(arg_81_1.choices_) do
				local var_82_0 = iter_82_0 <= 1

				SetActive(iter_82_1.go, var_82_0)
			end

			arg_81_1.choices_[1].txt.text = arg_81_1:FormatText(StoryChoiceCfg[1270].name)
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play321231021(arg_81_1)
			end

			arg_81_1:RecordChoiceLog(321231020, 1270)
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["404001ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos404001ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0, 100, 0)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos404001ui_story, var_84_4, var_84_3)

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

			local var_84_9 = 0

			if var_84_9 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 then
				arg_81_1.allBtn_.enabled = false
			end

			local var_84_10 = 0.6

			if arg_81_1.time_ >= var_84_9 + var_84_10 and arg_81_1.time_ < var_84_9 + var_84_10 + arg_84_0 then
				arg_81_1.allBtn_.enabled = true
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play321231021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 321231021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play321231022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.034000001847744
			local var_88_1 = 1

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				local var_88_2 = "play"
				local var_88_3 = "effect"

				arg_85_1:AudioAction(var_88_2, var_88_3, "se_story_1310", "se_story_1310_clap", "")
			end

			local var_88_4 = 0
			local var_88_5 = 0.6

			if var_88_4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(321231021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_8 = 24
				local var_88_9 = utf8.len(var_88_7)
				local var_88_10 = var_88_8 <= 0 and var_88_5 or var_88_5 * (var_88_9 / var_88_8)

				if var_88_10 > 0 and var_88_5 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_11 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_11 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_11

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_11 and arg_85_1.time_ < var_88_4 + var_88_11 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play321231022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 321231022
		arg_89_1.duration_ = 8.63

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play321231023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 2

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				local var_92_1 = manager.ui.mainCamera.transform.localPosition
				local var_92_2 = Vector3.New(0, 0, 10) + Vector3.New(var_92_1.x, var_92_1.y, 0)
				local var_92_3 = arg_89_1.bgs_.L12f

				var_92_3.transform.localPosition = var_92_2
				var_92_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_92_4 = var_92_3:GetComponent("SpriteRenderer")

				if var_92_4 and var_92_4.sprite then
					local var_92_5 = (var_92_3.transform.localPosition - var_92_1).z
					local var_92_6 = manager.ui.mainCameraCom_
					local var_92_7 = 2 * var_92_5 * Mathf.Tan(var_92_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_92_8 = var_92_7 * var_92_6.aspect
					local var_92_9 = var_92_4.sprite.bounds.size.x
					local var_92_10 = var_92_4.sprite.bounds.size.y
					local var_92_11 = var_92_8 / var_92_9
					local var_92_12 = var_92_7 / var_92_10
					local var_92_13 = var_92_12 < var_92_11 and var_92_11 or var_92_12

					var_92_3.transform.localScale = Vector3.New(var_92_13, var_92_13, 0)
				end

				for iter_92_0, iter_92_1 in pairs(arg_89_1.bgs_) do
					if iter_92_0 ~= "L12f" then
						iter_92_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_92_14 = 3.63333333333333

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1.allBtn_.enabled = false
			end

			local var_92_15 = 0.3

			if arg_89_1.time_ >= var_92_14 + var_92_15 and arg_89_1.time_ < var_92_14 + var_92_15 + arg_92_0 then
				arg_89_1.allBtn_.enabled = true
			end

			local var_92_16 = 0

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_17 = 2

			if var_92_16 <= arg_89_1.time_ and arg_89_1.time_ < var_92_16 + var_92_17 then
				local var_92_18 = (arg_89_1.time_ - var_92_16) / var_92_17
				local var_92_19 = Color.New(0, 0, 0)

				var_92_19.a = Mathf.Lerp(0, 1, var_92_18)
				arg_89_1.mask_.color = var_92_19
			end

			if arg_89_1.time_ >= var_92_16 + var_92_17 and arg_89_1.time_ < var_92_16 + var_92_17 + arg_92_0 then
				local var_92_20 = Color.New(0, 0, 0)

				var_92_20.a = 1
				arg_89_1.mask_.color = var_92_20
			end

			local var_92_21 = 2

			if var_92_21 < arg_89_1.time_ and arg_89_1.time_ <= var_92_21 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_22 = 2

			if var_92_21 <= arg_89_1.time_ and arg_89_1.time_ < var_92_21 + var_92_22 then
				local var_92_23 = (arg_89_1.time_ - var_92_21) / var_92_22
				local var_92_24 = Color.New(0, 0, 0)

				var_92_24.a = Mathf.Lerp(1, 0, var_92_23)
				arg_89_1.mask_.color = var_92_24
			end

			if arg_89_1.time_ >= var_92_21 + var_92_22 and arg_89_1.time_ < var_92_21 + var_92_22 + arg_92_0 then
				local var_92_25 = Color.New(0, 0, 0)
				local var_92_26 = 0

				arg_89_1.mask_.enabled = false
				var_92_25.a = var_92_26
				arg_89_1.mask_.color = var_92_25
			end

			local var_92_27 = 3.73333333333333
			local var_92_28 = 1

			if var_92_27 < arg_89_1.time_ and arg_89_1.time_ <= var_92_27 + arg_92_0 then
				local var_92_29 = "play"
				local var_92_30 = "effect"

				arg_89_1:AudioAction(var_92_29, var_92_30, "se_story_1311", "se_story_1311_car02", "")
			end

			if arg_89_1.frameCnt_ <= 1 then
				arg_89_1.dialog_:SetActive(false)
			end

			local var_92_31 = 3.63333333333333
			local var_92_32 = 0.975

			if var_92_31 < arg_89_1.time_ and arg_89_1.time_ <= var_92_31 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0

				arg_89_1.dialog_:SetActive(true)

				arg_89_1.dialogCg_.alpha = 0

				local var_92_33 = LeanTween.value(arg_89_1.dialog_, 0, 1, 0.3)

				var_92_33:setOnUpdate(LuaHelper.FloatAction(function(arg_93_0)
					arg_89_1.dialogCg_.alpha = arg_93_0
				end))
				var_92_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_89_1.dialog_)
					var_92_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_89_1.duration_ = arg_89_1.duration_ + 0.3

				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_34 = arg_89_1:GetWordFromCfg(321231022)
				local var_92_35 = arg_89_1:FormatText(var_92_34.content)

				arg_89_1.text_.text = var_92_35

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_36 = 39
				local var_92_37 = utf8.len(var_92_35)
				local var_92_38 = var_92_36 <= 0 and var_92_32 or var_92_32 * (var_92_37 / var_92_36)

				if var_92_38 > 0 and var_92_32 < var_92_38 then
					arg_89_1.talkMaxDuration = var_92_38
					var_92_31 = var_92_31 + 0.3

					if var_92_38 + var_92_31 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_38 + var_92_31
					end
				end

				arg_89_1.text_.text = var_92_35
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_39 = var_92_31 + 0.3
			local var_92_40 = math.max(var_92_32, arg_89_1.talkMaxDuration)

			if var_92_39 <= arg_89_1.time_ and arg_89_1.time_ < var_92_39 + var_92_40 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_39) / var_92_40

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_39 + var_92_40 and arg_89_1.time_ < var_92_39 + var_92_40 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play321231023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 321231023
		arg_95_1.duration_ = 2.03

		local var_95_0 = {
			zh = 1.999999999999,
			ja = 2.033
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
				arg_95_0:Play321231024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1284ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1284ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(0, -0.985, -6.22)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1284ui_story, var_98_4, var_98_3)

				local var_98_5 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_5.x, var_98_5.y, var_98_5.z)

				local var_98_6 = var_98_0.localEulerAngles

				var_98_6.z = 0
				var_98_6.x = 0
				var_98_0.localEulerAngles = var_98_6
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_98_7 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_7.x, var_98_7.y, var_98_7.z)

				local var_98_8 = var_98_0.localEulerAngles

				var_98_8.z = 0
				var_98_8.x = 0
				var_98_0.localEulerAngles = var_98_8
			end

			local var_98_9 = arg_95_1.actors_["1284ui_story"]
			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1284ui_story == nil then
				arg_95_1.var_.characterEffect1284ui_story = var_98_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_11 = 0.200000002980232

			if var_98_10 <= arg_95_1.time_ and arg_95_1.time_ < var_98_10 + var_98_11 and not isNil(var_98_9) then
				local var_98_12 = (arg_95_1.time_ - var_98_10) / var_98_11

				if arg_95_1.var_.characterEffect1284ui_story and not isNil(var_98_9) then
					arg_95_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_10 + var_98_11 and arg_95_1.time_ < var_98_10 + var_98_11 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1284ui_story then
				arg_95_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_98_13 = 0

			if var_98_13 < arg_95_1.time_ and arg_95_1.time_ <= var_98_13 + arg_98_0 then
				arg_95_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action8_1")
			end

			local var_98_14 = 0

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_98_15 = 0
			local var_98_16 = 0.225

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_17 = arg_95_1:FormatText(StoryNameCfg[6].name)

				arg_95_1.leftNameTxt_.text = var_98_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_18 = arg_95_1:GetWordFromCfg(321231023)
				local var_98_19 = arg_95_1:FormatText(var_98_18.content)

				arg_95_1.text_.text = var_98_19

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_20 = 9
				local var_98_21 = utf8.len(var_98_19)
				local var_98_22 = var_98_20 <= 0 and var_98_16 or var_98_16 * (var_98_21 / var_98_20)

				if var_98_22 > 0 and var_98_16 < var_98_22 then
					arg_95_1.talkMaxDuration = var_98_22

					if var_98_22 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_22 + var_98_15
					end
				end

				arg_95_1.text_.text = var_98_19
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231023", "story_v_out_321231.awb") ~= 0 then
					local var_98_23 = manager.audio:GetVoiceLength("story_v_out_321231", "321231023", "story_v_out_321231.awb") / 1000

					if var_98_23 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_23 + var_98_15
					end

					if var_98_18.prefab_name ~= "" and arg_95_1.actors_[var_98_18.prefab_name] ~= nil then
						local var_98_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_18.prefab_name].transform, "story_v_out_321231", "321231023", "story_v_out_321231.awb")

						arg_95_1:RecordAudio("321231023", var_98_24)
						arg_95_1:RecordAudio("321231023", var_98_24)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_321231", "321231023", "story_v_out_321231.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_321231", "321231023", "story_v_out_321231.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_25 = math.max(var_98_16, arg_95_1.talkMaxDuration)

			if var_98_15 <= arg_95_1.time_ and arg_95_1.time_ < var_98_15 + var_98_25 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_15) / var_98_25

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_15 + var_98_25 and arg_95_1.time_ < var_98_15 + var_98_25 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play321231024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 321231024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play321231025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1284ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1284ui_story == nil then
				arg_99_1.var_.characterEffect1284ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect1284ui_story and not isNil(var_102_0) then
					local var_102_4 = Mathf.Lerp(0, 0.5, var_102_3)

					arg_99_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1284ui_story.fillRatio = var_102_4
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1284ui_story then
				local var_102_5 = 0.5

				arg_99_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1284ui_story.fillRatio = var_102_5
			end

			local var_102_6 = 0.4
			local var_102_7 = 1

			if var_102_6 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				local var_102_8 = "play"
				local var_102_9 = "effect"

				arg_99_1:AudioAction(var_102_8, var_102_9, "se_story_1311", "se_story_1311_car01", "")
			end

			local var_102_10 = 0
			local var_102_11 = 1

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_12 = arg_99_1:GetWordFromCfg(321231024)
				local var_102_13 = arg_99_1:FormatText(var_102_12.content)

				arg_99_1.text_.text = var_102_13

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_14 = 40
				local var_102_15 = utf8.len(var_102_13)
				local var_102_16 = var_102_14 <= 0 and var_102_11 or var_102_11 * (var_102_15 / var_102_14)

				if var_102_16 > 0 and var_102_11 < var_102_16 then
					arg_99_1.talkMaxDuration = var_102_16

					if var_102_16 + var_102_10 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_16 + var_102_10
					end
				end

				arg_99_1.text_.text = var_102_13
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_17 = math.max(var_102_11, arg_99_1.talkMaxDuration)

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_17 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_10) / var_102_17

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_10 + var_102_17 and arg_99_1.time_ < var_102_10 + var_102_17 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play321231025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 321231025
		arg_103_1.duration_ = 7.77

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play321231026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = "MS2107"

			if arg_103_1.bgs_[var_106_0] == nil then
				local var_106_1 = Object.Instantiate(arg_103_1.paintGo_)

				var_106_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_106_0)
				var_106_1.name = var_106_0
				var_106_1.transform.parent = arg_103_1.stage_.transform
				var_106_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.bgs_[var_106_0] = var_106_1
			end

			local var_106_2 = 1

			if var_106_2 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 then
				local var_106_3 = manager.ui.mainCamera.transform.localPosition
				local var_106_4 = Vector3.New(0, 0, 10) + Vector3.New(var_106_3.x, var_106_3.y, 0)
				local var_106_5 = arg_103_1.bgs_.MS2107

				var_106_5.transform.localPosition = var_106_4
				var_106_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_6 = var_106_5:GetComponent("SpriteRenderer")

				if var_106_6 and var_106_6.sprite then
					local var_106_7 = (var_106_5.transform.localPosition - var_106_3).z
					local var_106_8 = manager.ui.mainCameraCom_
					local var_106_9 = 2 * var_106_7 * Mathf.Tan(var_106_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_106_10 = var_106_9 * var_106_8.aspect
					local var_106_11 = var_106_6.sprite.bounds.size.x
					local var_106_12 = var_106_6.sprite.bounds.size.y
					local var_106_13 = var_106_10 / var_106_11
					local var_106_14 = var_106_9 / var_106_12
					local var_106_15 = var_106_14 < var_106_13 and var_106_13 or var_106_14

					var_106_5.transform.localScale = Vector3.New(var_106_15, var_106_15, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "MS2107" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_16 = 2.700000000001

			if var_106_16 < arg_103_1.time_ and arg_103_1.time_ <= var_106_16 + arg_106_0 then
				arg_103_1.allBtn_.enabled = false
			end

			local var_106_17 = 0.3

			if arg_103_1.time_ >= var_106_16 + var_106_17 and arg_103_1.time_ < var_106_16 + var_106_17 + arg_106_0 then
				arg_103_1.allBtn_.enabled = true
			end

			local var_106_18 = 0

			if var_106_18 < arg_103_1.time_ and arg_103_1.time_ <= var_106_18 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_19 = 1

			if var_106_18 <= arg_103_1.time_ and arg_103_1.time_ < var_106_18 + var_106_19 then
				local var_106_20 = (arg_103_1.time_ - var_106_18) / var_106_19
				local var_106_21 = Color.New(0, 0, 0)

				var_106_21.a = Mathf.Lerp(0, 1, var_106_20)
				arg_103_1.mask_.color = var_106_21
			end

			if arg_103_1.time_ >= var_106_18 + var_106_19 and arg_103_1.time_ < var_106_18 + var_106_19 + arg_106_0 then
				local var_106_22 = Color.New(0, 0, 0)

				var_106_22.a = 1
				arg_103_1.mask_.color = var_106_22
			end

			local var_106_23 = 1.000000000001

			if var_106_23 < arg_103_1.time_ and arg_103_1.time_ <= var_106_23 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_24 = 2

			if var_106_23 <= arg_103_1.time_ and arg_103_1.time_ < var_106_23 + var_106_24 then
				local var_106_25 = (arg_103_1.time_ - var_106_23) / var_106_24
				local var_106_26 = Color.New(1, 1, 1)

				var_106_26.a = Mathf.Lerp(1, 0, var_106_25)
				arg_103_1.mask_.color = var_106_26
			end

			if arg_103_1.time_ >= var_106_23 + var_106_24 and arg_103_1.time_ < var_106_23 + var_106_24 + arg_106_0 then
				local var_106_27 = Color.New(1, 1, 1)
				local var_106_28 = 0

				arg_103_1.mask_.enabled = false
				var_106_27.a = var_106_28
				arg_103_1.mask_.color = var_106_27
			end

			local var_106_29 = arg_103_1.actors_["1284ui_story"].transform
			local var_106_30 = 0.965999998152256

			if var_106_30 < arg_103_1.time_ and arg_103_1.time_ <= var_106_30 + arg_106_0 then
				arg_103_1.var_.moveOldPos1284ui_story = var_106_29.localPosition
			end

			local var_106_31 = 0.001

			if var_106_30 <= arg_103_1.time_ and arg_103_1.time_ < var_106_30 + var_106_31 then
				local var_106_32 = (arg_103_1.time_ - var_106_30) / var_106_31
				local var_106_33 = Vector3.New(0, 100, 0)

				var_106_29.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1284ui_story, var_106_33, var_106_32)

				local var_106_34 = manager.ui.mainCamera.transform.position - var_106_29.position

				var_106_29.forward = Vector3.New(var_106_34.x, var_106_34.y, var_106_34.z)

				local var_106_35 = var_106_29.localEulerAngles

				var_106_35.z = 0
				var_106_35.x = 0
				var_106_29.localEulerAngles = var_106_35
			end

			if arg_103_1.time_ >= var_106_30 + var_106_31 and arg_103_1.time_ < var_106_30 + var_106_31 + arg_106_0 then
				var_106_29.localPosition = Vector3.New(0, 100, 0)

				local var_106_36 = manager.ui.mainCamera.transform.position - var_106_29.position

				var_106_29.forward = Vector3.New(var_106_36.x, var_106_36.y, var_106_36.z)

				local var_106_37 = var_106_29.localEulerAngles

				var_106_37.z = 0
				var_106_37.x = 0
				var_106_29.localEulerAngles = var_106_37
			end

			local var_106_38 = manager.ui.mainCamera.transform
			local var_106_39 = 1

			if var_106_39 < arg_103_1.time_ and arg_103_1.time_ <= var_106_39 + arg_106_0 then
				local var_106_40 = arg_103_1.var_.effectfengchang1
				local var_106_41
				local var_106_42 = var_106_38

				if not var_106_40 then
					var_106_40 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_in_keep"), var_106_42)
					var_106_40.name = "fengchang1"
					arg_103_1.var_.effectfengchang1 = var_106_40
				else
					var_106_40.transform:SetParent(var_106_42)
				end

				var_106_40.transform.localPosition = Vector3.New(0, 0, 0)
				var_106_40.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_106_43 = manager.ui.mainCamera.transform
			local var_106_44 = 1

			if var_106_44 < arg_103_1.time_ and arg_103_1.time_ <= var_106_44 + arg_106_0 then
				local var_106_45 = arg_103_1.var_.effectfengchang2
				local var_106_46
				local var_106_47 = var_106_43

				if not var_106_45 then
					var_106_45 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_106_47)
					var_106_45.name = "fengchang2"
					arg_103_1.var_.effectfengchang2 = var_106_45
				else
					var_106_45.transform:SetParent(var_106_47)
				end

				var_106_45.transform.localPosition = Vector3.New(0, 0, 0)
				var_106_45.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_106_48 = manager.ui.mainCamera.transform
			local var_106_49 = 3.000000000001

			if var_106_49 < arg_103_1.time_ and arg_103_1.time_ <= var_106_49 + arg_106_0 then
				local var_106_50 = arg_103_1.var_.effectfengchang2

				if var_106_50 then
					Object.Destroy(var_106_50)

					arg_103_1.var_.effectfengchang2 = nil
				end
			end

			local var_106_51 = arg_103_1.bgs_.MS2107.transform
			local var_106_52 = 1.000000000001

			if var_106_52 < arg_103_1.time_ and arg_103_1.time_ <= var_106_52 + arg_106_0 then
				arg_103_1.var_.moveOldPosMS2107 = var_106_51.localPosition
			end

			local var_106_53 = 2.5

			if var_106_52 <= arg_103_1.time_ and arg_103_1.time_ < var_106_52 + var_106_53 then
				local var_106_54 = (arg_103_1.time_ - var_106_52) / var_106_53
				local var_106_55 = Vector3.New(0, 1, 9.5)

				var_106_51.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPosMS2107, var_106_55, var_106_54)
			end

			if arg_103_1.time_ >= var_106_52 + var_106_53 and arg_103_1.time_ < var_106_52 + var_106_53 + arg_106_0 then
				var_106_51.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_106_56 = 0.965999998152256
			local var_106_57 = 1

			if var_106_56 < arg_103_1.time_ and arg_103_1.time_ <= var_106_56 + arg_106_0 then
				local var_106_58 = "play"
				local var_106_59 = "effect"

				arg_103_1:AudioAction(var_106_58, var_106_59, "se_story_140", "se_story_140_amb_wind_thunder", "")
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_60 = 2.76666666666767
			local var_106_61 = 1.425

			if var_106_60 < arg_103_1.time_ and arg_103_1.time_ <= var_106_60 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_62 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_62:setOnUpdate(LuaHelper.FloatAction(function(arg_107_0)
					arg_103_1.dialogCg_.alpha = arg_107_0
				end))
				var_106_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_63 = arg_103_1:GetWordFromCfg(321231025)
				local var_106_64 = arg_103_1:FormatText(var_106_63.content)

				arg_103_1.text_.text = var_106_64

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_65 = 57
				local var_106_66 = utf8.len(var_106_64)
				local var_106_67 = var_106_65 <= 0 and var_106_61 or var_106_61 * (var_106_66 / var_106_65)

				if var_106_67 > 0 and var_106_61 < var_106_67 then
					arg_103_1.talkMaxDuration = var_106_67
					var_106_60 = var_106_60 + 0.3

					if var_106_67 + var_106_60 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_67 + var_106_60
					end
				end

				arg_103_1.text_.text = var_106_64
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_68 = var_106_60 + 0.3
			local var_106_69 = math.max(var_106_61, arg_103_1.talkMaxDuration)

			if var_106_68 <= arg_103_1.time_ and arg_103_1.time_ < var_106_68 + var_106_69 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_68) / var_106_69

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_68 + var_106_69 and arg_103_1.time_ < var_106_68 + var_106_69 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "MS2107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.5,
				className = "StoryMoveNode",
				startTime = 1.000000000001,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play321231026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 321231026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play321231027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 1.4

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_2 = arg_109_1:GetWordFromCfg(321231026)
				local var_112_3 = arg_109_1:FormatText(var_112_2.content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 56
				local var_112_5 = utf8.len(var_112_3)
				local var_112_6 = var_112_4 <= 0 and var_112_1 or var_112_1 * (var_112_5 / var_112_4)

				if var_112_6 > 0 and var_112_1 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_7 and arg_109_1.time_ < var_112_0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play321231027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 321231027
		arg_113_1.duration_ = 3.33

		local var_113_0 = {
			zh = 3.333,
			ja = 3.233
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
				arg_113_0:Play321231028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1284ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1284ui_story == nil then
				arg_113_1.var_.characterEffect1284ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1284ui_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1284ui_story then
				arg_113_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_116_4 = 0
			local var_116_5 = 0.4

			if var_116_4 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_6 = arg_113_1:FormatText(StoryNameCfg[6].name)

				arg_113_1.leftNameTxt_.text = var_116_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_7 = arg_113_1:GetWordFromCfg(321231027)
				local var_116_8 = arg_113_1:FormatText(var_116_7.content)

				arg_113_1.text_.text = var_116_8

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 16
				local var_116_10 = utf8.len(var_116_8)
				local var_116_11 = var_116_9 <= 0 and var_116_5 or var_116_5 * (var_116_10 / var_116_9)

				if var_116_11 > 0 and var_116_5 < var_116_11 then
					arg_113_1.talkMaxDuration = var_116_11

					if var_116_11 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_8
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231027", "story_v_out_321231.awb") ~= 0 then
					local var_116_12 = manager.audio:GetVoiceLength("story_v_out_321231", "321231027", "story_v_out_321231.awb") / 1000

					if var_116_12 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_4
					end

					if var_116_7.prefab_name ~= "" and arg_113_1.actors_[var_116_7.prefab_name] ~= nil then
						local var_116_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_7.prefab_name].transform, "story_v_out_321231", "321231027", "story_v_out_321231.awb")

						arg_113_1:RecordAudio("321231027", var_116_13)
						arg_113_1:RecordAudio("321231027", var_116_13)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_321231", "321231027", "story_v_out_321231.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_321231", "321231027", "story_v_out_321231.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_14 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_14 and arg_113_1.time_ < var_116_4 + var_116_14 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play321231028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 321231028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play321231029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1284ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1284ui_story == nil then
				arg_117_1.var_.characterEffect1284ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect1284ui_story and not isNil(var_120_0) then
					local var_120_4 = Mathf.Lerp(0, 0.5, var_120_3)

					arg_117_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1284ui_story.fillRatio = var_120_4
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1284ui_story then
				local var_120_5 = 0.5

				arg_117_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1284ui_story.fillRatio = var_120_5
			end

			local var_120_6 = 0.766666666666667
			local var_120_7 = 1

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				local var_120_8 = "play"
				local var_120_9 = "effect"

				arg_117_1:AudioAction(var_120_8, var_120_9, "se_story_140", "se_story_140_dark", "")
			end

			local var_120_10 = 0
			local var_120_11 = 1.025

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_12 = arg_117_1:GetWordFromCfg(321231028)
				local var_120_13 = arg_117_1:FormatText(var_120_12.content)

				arg_117_1.text_.text = var_120_13

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_14 = 41
				local var_120_15 = utf8.len(var_120_13)
				local var_120_16 = var_120_14 <= 0 and var_120_11 or var_120_11 * (var_120_15 / var_120_14)

				if var_120_16 > 0 and var_120_11 < var_120_16 then
					arg_117_1.talkMaxDuration = var_120_16

					if var_120_16 + var_120_10 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_16 + var_120_10
					end
				end

				arg_117_1.text_.text = var_120_13
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_17 = math.max(var_120_11, arg_117_1.talkMaxDuration)

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_17 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_10) / var_120_17

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_10 + var_120_17 and arg_117_1.time_ < var_120_10 + var_120_17 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play321231029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 321231029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play321231030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.1

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[7].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:GetWordFromCfg(321231029)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 4
				local var_124_6 = utf8.len(var_124_4)
				local var_124_7 = var_124_5 <= 0 and var_124_1 or var_124_1 * (var_124_6 / var_124_5)

				if var_124_7 > 0 and var_124_1 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_8 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_8 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_8

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_8 and arg_121_1.time_ < var_124_0 + var_124_8 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play321231030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 321231030
		arg_125_1.duration_ = 3.13

		local var_125_0 = {
			zh = 2.5,
			ja = 3.133
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
				arg_125_0:Play321231031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1284ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1284ui_story == nil then
				arg_125_1.var_.characterEffect1284ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1284ui_story and not isNil(var_128_0) then
					arg_125_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1284ui_story then
				arg_125_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_128_4 = 0
			local var_128_5 = 0.225

			if var_128_4 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_6 = arg_125_1:FormatText(StoryNameCfg[6].name)

				arg_125_1.leftNameTxt_.text = var_128_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_7 = arg_125_1:GetWordFromCfg(321231030)
				local var_128_8 = arg_125_1:FormatText(var_128_7.content)

				arg_125_1.text_.text = var_128_8

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 9
				local var_128_10 = utf8.len(var_128_8)
				local var_128_11 = var_128_9 <= 0 and var_128_5 or var_128_5 * (var_128_10 / var_128_9)

				if var_128_11 > 0 and var_128_5 < var_128_11 then
					arg_125_1.talkMaxDuration = var_128_11

					if var_128_11 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_11 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_8
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231030", "story_v_out_321231.awb") ~= 0 then
					local var_128_12 = manager.audio:GetVoiceLength("story_v_out_321231", "321231030", "story_v_out_321231.awb") / 1000

					if var_128_12 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_12 + var_128_4
					end

					if var_128_7.prefab_name ~= "" and arg_125_1.actors_[var_128_7.prefab_name] ~= nil then
						local var_128_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_7.prefab_name].transform, "story_v_out_321231", "321231030", "story_v_out_321231.awb")

						arg_125_1:RecordAudio("321231030", var_128_13)
						arg_125_1:RecordAudio("321231030", var_128_13)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_321231", "321231030", "story_v_out_321231.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_321231", "321231030", "story_v_out_321231.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_14 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_14 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_14

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_14 and arg_125_1.time_ < var_128_4 + var_128_14 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play321231031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 321231031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play321231032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1284ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1284ui_story == nil then
				arg_129_1.var_.characterEffect1284ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect1284ui_story and not isNil(var_132_0) then
					local var_132_4 = Mathf.Lerp(0, 0.5, var_132_3)

					arg_129_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1284ui_story.fillRatio = var_132_4
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1284ui_story then
				local var_132_5 = 0.5

				arg_129_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1284ui_story.fillRatio = var_132_5
			end

			local var_132_6 = 0
			local var_132_7 = 0.15

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_8 = arg_129_1:FormatText(StoryNameCfg[7].name)

				arg_129_1.leftNameTxt_.text = var_132_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_9 = arg_129_1:GetWordFromCfg(321231031)
				local var_132_10 = arg_129_1:FormatText(var_132_9.content)

				arg_129_1.text_.text = var_132_10

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 6
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
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_14 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_14 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_14

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_14 and arg_129_1.time_ < var_132_6 + var_132_14 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play321231032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 321231032
		arg_133_1.duration_ = 5.33

		local var_133_0 = {
			zh = 5.133,
			ja = 5.333
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
				arg_133_0:Play321231033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1284ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1284ui_story == nil then
				arg_133_1.var_.characterEffect1284ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1284ui_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1284ui_story then
				arg_133_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_136_4 = 0
			local var_136_5 = 0.5

			if var_136_4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_6 = arg_133_1:FormatText(StoryNameCfg[6].name)

				arg_133_1.leftNameTxt_.text = var_136_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_7 = arg_133_1:GetWordFromCfg(321231032)
				local var_136_8 = arg_133_1:FormatText(var_136_7.content)

				arg_133_1.text_.text = var_136_8

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 20
				local var_136_10 = utf8.len(var_136_8)
				local var_136_11 = var_136_9 <= 0 and var_136_5 or var_136_5 * (var_136_10 / var_136_9)

				if var_136_11 > 0 and var_136_5 < var_136_11 then
					arg_133_1.talkMaxDuration = var_136_11

					if var_136_11 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_8
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231032", "story_v_out_321231.awb") ~= 0 then
					local var_136_12 = manager.audio:GetVoiceLength("story_v_out_321231", "321231032", "story_v_out_321231.awb") / 1000

					if var_136_12 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_4
					end

					if var_136_7.prefab_name ~= "" and arg_133_1.actors_[var_136_7.prefab_name] ~= nil then
						local var_136_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_7.prefab_name].transform, "story_v_out_321231", "321231032", "story_v_out_321231.awb")

						arg_133_1:RecordAudio("321231032", var_136_13)
						arg_133_1:RecordAudio("321231032", var_136_13)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_321231", "321231032", "story_v_out_321231.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_321231", "321231032", "story_v_out_321231.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_14 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_14

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_14 and arg_133_1.time_ < var_136_4 + var_136_14 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play321231033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 321231033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play321231034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1284ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1284ui_story == nil then
				arg_137_1.var_.characterEffect1284ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1284ui_story and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1284ui_story.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1284ui_story then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1284ui_story.fillRatio = var_140_5
			end

			local var_140_6 = 0
			local var_140_7 = 0.75

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_8 = arg_137_1:GetWordFromCfg(321231033)
				local var_140_9 = arg_137_1:FormatText(var_140_8.content)

				arg_137_1.text_.text = var_140_9

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_10 = 30
				local var_140_11 = utf8.len(var_140_9)
				local var_140_12 = var_140_10 <= 0 and var_140_7 or var_140_7 * (var_140_11 / var_140_10)

				if var_140_12 > 0 and var_140_7 < var_140_12 then
					arg_137_1.talkMaxDuration = var_140_12

					if var_140_12 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_12 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_9
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_13 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_13 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_13

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_13 and arg_137_1.time_ < var_140_6 + var_140_13 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play321231034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 321231034
		arg_141_1.duration_ = 7

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play321231035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = "MS2107a"

			if arg_141_1.bgs_[var_144_0] == nil then
				local var_144_1 = Object.Instantiate(arg_141_1.paintGo_)

				var_144_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_144_0)
				var_144_1.name = var_144_0
				var_144_1.transform.parent = arg_141_1.stage_.transform
				var_144_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_141_1.bgs_[var_144_0] = var_144_1
			end

			local var_144_2 = 0.433333333333333

			if var_144_2 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				local var_144_3 = manager.ui.mainCamera.transform.localPosition
				local var_144_4 = Vector3.New(0, 0, 10) + Vector3.New(var_144_3.x, var_144_3.y, 0)
				local var_144_5 = arg_141_1.bgs_.MS2107a

				var_144_5.transform.localPosition = var_144_4
				var_144_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_144_6 = var_144_5:GetComponent("SpriteRenderer")

				if var_144_6 and var_144_6.sprite then
					local var_144_7 = (var_144_5.transform.localPosition - var_144_3).z
					local var_144_8 = manager.ui.mainCameraCom_
					local var_144_9 = 2 * var_144_7 * Mathf.Tan(var_144_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_144_10 = var_144_9 * var_144_8.aspect
					local var_144_11 = var_144_6.sprite.bounds.size.x
					local var_144_12 = var_144_6.sprite.bounds.size.y
					local var_144_13 = var_144_10 / var_144_11
					local var_144_14 = var_144_9 / var_144_12
					local var_144_15 = var_144_14 < var_144_13 and var_144_13 or var_144_14

					var_144_5.transform.localScale = Vector3.New(var_144_15, var_144_15, 0)
				end

				for iter_144_0, iter_144_1 in pairs(arg_141_1.bgs_) do
					if iter_144_0 ~= "MS2107a" then
						iter_144_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_144_16 = 2

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			local var_144_17 = 0.3

			if arg_141_1.time_ >= var_144_16 + var_144_17 and arg_141_1.time_ < var_144_16 + var_144_17 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end

			local var_144_18 = manager.ui.mainCamera.transform
			local var_144_19 = 0.433333333333333

			if var_144_19 < arg_141_1.time_ and arg_141_1.time_ <= var_144_19 + arg_144_0 then
				arg_141_1.var_.shakeOldPos = var_144_18.localPosition
			end

			local var_144_20 = 0.6

			if var_144_19 <= arg_141_1.time_ and arg_141_1.time_ < var_144_19 + var_144_20 then
				local var_144_21 = (arg_141_1.time_ - var_144_19) / 0.066
				local var_144_22, var_144_23 = math.modf(var_144_21)

				var_144_18.localPosition = Vector3.New(var_144_23 * 0.13, var_144_23 * 0.13, var_144_23 * 0.13) + arg_141_1.var_.shakeOldPos
			end

			if arg_141_1.time_ >= var_144_19 + var_144_20 and arg_141_1.time_ < var_144_19 + var_144_20 + arg_144_0 then
				var_144_18.localPosition = arg_141_1.var_.shakeOldPos
			end

			local var_144_24 = 0.433333333333333

			if var_144_24 < arg_141_1.time_ and arg_141_1.time_ <= var_144_24 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = false

				arg_141_1:SetGaussion(false)
			end

			local var_144_25 = 0.5

			if var_144_24 <= arg_141_1.time_ and arg_141_1.time_ < var_144_24 + var_144_25 then
				local var_144_26 = (arg_141_1.time_ - var_144_24) / var_144_25
				local var_144_27 = Color.New(1, 1, 1)

				var_144_27.a = Mathf.Lerp(1, 0, var_144_26)
				arg_141_1.mask_.color = var_144_27
			end

			if arg_141_1.time_ >= var_144_24 + var_144_25 and arg_141_1.time_ < var_144_24 + var_144_25 + arg_144_0 then
				local var_144_28 = Color.New(1, 1, 1)
				local var_144_29 = 0

				arg_141_1.mask_.enabled = false
				var_144_28.a = var_144_29
				arg_141_1.mask_.color = var_144_28
			end

			local var_144_30 = 0.433333333333333
			local var_144_31 = 1

			if var_144_30 < arg_141_1.time_ and arg_141_1.time_ <= var_144_30 + arg_144_0 then
				local var_144_32 = "play"
				local var_144_33 = "effect"

				arg_141_1:AudioAction(var_144_32, var_144_33, "se_story_140", "se_story_140_scythe2", "")
			end

			if arg_141_1.frameCnt_ <= 1 then
				arg_141_1.dialog_:SetActive(false)
			end

			local var_144_34 = 2
			local var_144_35 = 1.425

			if var_144_34 < arg_141_1.time_ and arg_141_1.time_ <= var_144_34 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_36 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_36:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_37 = arg_141_1:GetWordFromCfg(321231034)
				local var_144_38 = arg_141_1:FormatText(var_144_37.content)

				arg_141_1.text_.text = var_144_38

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_39 = 57
				local var_144_40 = utf8.len(var_144_38)
				local var_144_41 = var_144_39 <= 0 and var_144_35 or var_144_35 * (var_144_40 / var_144_39)

				if var_144_41 > 0 and var_144_35 < var_144_41 then
					arg_141_1.talkMaxDuration = var_144_41
					var_144_34 = var_144_34 + 0.3

					if var_144_41 + var_144_34 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_41 + var_144_34
					end
				end

				arg_141_1.text_.text = var_144_38
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_42 = var_144_34 + 0.3
			local var_144_43 = math.max(var_144_35, arg_141_1.talkMaxDuration)

			if var_144_42 <= arg_141_1.time_ and arg_141_1.time_ < var_144_42 + var_144_43 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_42) / var_144_43

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_42 + var_144_43 and arg_141_1.time_ < var_144_42 + var_144_43 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play321231035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 321231035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play321231036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.3

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[7].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:GetWordFromCfg(321231035)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 12
				local var_150_6 = utf8.len(var_150_4)
				local var_150_7 = var_150_5 <= 0 and var_150_1 or var_150_1 * (var_150_6 / var_150_5)

				if var_150_7 > 0 and var_150_1 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_8 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_8 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_8

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_8 and arg_147_1.time_ < var_150_0 + var_150_8 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play321231036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 321231036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play321231037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.1
			local var_154_1 = 1

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				local var_154_2 = "play"
				local var_154_3 = "effect"

				arg_151_1:AudioAction(var_154_2, var_154_3, "se_story_222_00", "se_story_222_00_rockcollapse", "")
			end

			local var_154_4 = 0
			local var_154_5 = 1.675

			if var_154_4 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:GetWordFromCfg(321231036)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_8 = 67
				local var_154_9 = utf8.len(var_154_7)
				local var_154_10 = var_154_8 <= 0 and var_154_5 or var_154_5 * (var_154_9 / var_154_8)

				if var_154_10 > 0 and var_154_5 < var_154_10 then
					arg_151_1.talkMaxDuration = var_154_10

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_11 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_11 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_11

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_11 and arg_151_1.time_ < var_154_4 + var_154_11 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play321231037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 321231037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play321231038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.775

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_2 = arg_155_1:GetWordFromCfg(321231037)
				local var_158_3 = arg_155_1:FormatText(var_158_2.content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 31
				local var_158_5 = utf8.len(var_158_3)
				local var_158_6 = var_158_4 <= 0 and var_158_1 or var_158_1 * (var_158_5 / var_158_4)

				if var_158_6 > 0 and var_158_1 < var_158_6 then
					arg_155_1.talkMaxDuration = var_158_6

					if var_158_6 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_6 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_7 and arg_155_1.time_ < var_158_0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play321231038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 321231038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play321231039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.2

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				local var_162_2 = "play"
				local var_162_3 = "music"

				arg_159_1:AudioAction(var_162_2, var_162_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_162_4 = ""
				local var_162_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_162_5 ~= "" then
					if arg_159_1.bgmTxt_.text ~= var_162_5 and arg_159_1.bgmTxt_.text ~= "" then
						if arg_159_1.bgmTxt2_.text ~= "" then
							arg_159_1.bgmTxt_.text = arg_159_1.bgmTxt2_.text
						end

						arg_159_1.bgmTxt2_.text = var_162_5

						arg_159_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_159_1.bgmTxt_.text = var_162_5
						arg_159_1.bgmTxt2_.text = var_162_5
					end

					if arg_159_1.bgmTimer then
						arg_159_1.bgmTimer:Stop()

						arg_159_1.bgmTimer = nil
					end

					if arg_159_1.settingData.show_music_name == 1 then
						arg_159_1.musicController:SetSelectedState("show")
						arg_159_1.musicAnimator_:Play("open", 0, 0)

						if arg_159_1.settingData.music_time ~= 0 then
							arg_159_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_159_1.settingData.music_time), function()
								if arg_159_1 == nil or isNil(arg_159_1.bgmTxt_) then
									return
								end

								arg_159_1.musicController:SetSelectedState("hide")
								arg_159_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_162_6 = 0
			local var_162_7 = 0.2

			if var_162_6 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_8 = arg_159_1:FormatText(StoryNameCfg[7].name)

				arg_159_1.leftNameTxt_.text = var_162_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_9 = arg_159_1:GetWordFromCfg(321231038)
				local var_162_10 = arg_159_1:FormatText(var_162_9.content)

				arg_159_1.text_.text = var_162_10

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 8
				local var_162_12 = utf8.len(var_162_10)
				local var_162_13 = var_162_11 <= 0 and var_162_7 or var_162_7 * (var_162_12 / var_162_11)

				if var_162_13 > 0 and var_162_7 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_6
					end
				end

				arg_159_1.text_.text = var_162_10
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_14 and arg_159_1.time_ < var_162_6 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play321231039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 321231039
		arg_164_1.duration_ = 6.76

		local var_164_0 = {
			zh = 6.724999999999,
			ja = 6.757999999999
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
				arg_164_0:Play321231040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = "Q01f"

			if arg_164_1.bgs_[var_167_0] == nil then
				local var_167_1 = Object.Instantiate(arg_164_1.paintGo_)

				var_167_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_167_0)
				var_167_1.name = var_167_0
				var_167_1.transform.parent = arg_164_1.stage_.transform
				var_167_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_164_1.bgs_[var_167_0] = var_167_1
			end

			local var_167_2 = 2

			if var_167_2 < arg_164_1.time_ and arg_164_1.time_ <= var_167_2 + arg_167_0 then
				local var_167_3 = manager.ui.mainCamera.transform.localPosition
				local var_167_4 = Vector3.New(0, 0, 10) + Vector3.New(var_167_3.x, var_167_3.y, 0)
				local var_167_5 = arg_164_1.bgs_.Q01f

				var_167_5.transform.localPosition = var_167_4
				var_167_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_167_6 = var_167_5:GetComponent("SpriteRenderer")

				if var_167_6 and var_167_6.sprite then
					local var_167_7 = (var_167_5.transform.localPosition - var_167_3).z
					local var_167_8 = manager.ui.mainCameraCom_
					local var_167_9 = 2 * var_167_7 * Mathf.Tan(var_167_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_167_10 = var_167_9 * var_167_8.aspect
					local var_167_11 = var_167_6.sprite.bounds.size.x
					local var_167_12 = var_167_6.sprite.bounds.size.y
					local var_167_13 = var_167_10 / var_167_11
					local var_167_14 = var_167_9 / var_167_12
					local var_167_15 = var_167_14 < var_167_13 and var_167_13 or var_167_14

					var_167_5.transform.localScale = Vector3.New(var_167_15, var_167_15, 0)
				end

				for iter_167_0, iter_167_1 in pairs(arg_164_1.bgs_) do
					if iter_167_0 ~= "Q01f" then
						iter_167_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_167_16 = 3.924999999999

			if var_167_16 < arg_164_1.time_ and arg_164_1.time_ <= var_167_16 + arg_167_0 then
				arg_164_1.allBtn_.enabled = false
			end

			local var_167_17 = 0.3

			if arg_164_1.time_ >= var_167_16 + var_167_17 and arg_164_1.time_ < var_167_16 + var_167_17 + arg_167_0 then
				arg_164_1.allBtn_.enabled = true
			end

			local var_167_18 = 0

			if var_167_18 < arg_164_1.time_ and arg_164_1.time_ <= var_167_18 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_19 = 2

			if var_167_18 <= arg_164_1.time_ and arg_164_1.time_ < var_167_18 + var_167_19 then
				local var_167_20 = (arg_164_1.time_ - var_167_18) / var_167_19
				local var_167_21 = Color.New(0, 0, 0)

				var_167_21.a = Mathf.Lerp(0, 1, var_167_20)
				arg_164_1.mask_.color = var_167_21
			end

			if arg_164_1.time_ >= var_167_18 + var_167_19 and arg_164_1.time_ < var_167_18 + var_167_19 + arg_167_0 then
				local var_167_22 = Color.New(0, 0, 0)

				var_167_22.a = 1
				arg_164_1.mask_.color = var_167_22
			end

			local var_167_23 = 2

			if var_167_23 < arg_164_1.time_ and arg_164_1.time_ <= var_167_23 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_24 = 2

			if var_167_23 <= arg_164_1.time_ and arg_164_1.time_ < var_167_23 + var_167_24 then
				local var_167_25 = (arg_164_1.time_ - var_167_23) / var_167_24
				local var_167_26 = Color.New(0, 0, 0)

				var_167_26.a = Mathf.Lerp(1, 0, var_167_25)
				arg_164_1.mask_.color = var_167_26
			end

			if arg_164_1.time_ >= var_167_23 + var_167_24 and arg_164_1.time_ < var_167_23 + var_167_24 + arg_167_0 then
				local var_167_27 = Color.New(0, 0, 0)
				local var_167_28 = 0

				arg_164_1.mask_.enabled = false
				var_167_27.a = var_167_28
				arg_164_1.mask_.color = var_167_27
			end

			local var_167_29 = manager.ui.mainCamera.transform
			local var_167_30 = 2

			if var_167_30 < arg_164_1.time_ and arg_164_1.time_ <= var_167_30 + arg_167_0 then
				local var_167_31 = arg_164_1.var_.effectfengchang1

				if var_167_31 then
					Object.Destroy(var_167_31)

					arg_164_1.var_.effectfengchang1 = nil
				end
			end

			local var_167_32 = 0
			local var_167_33 = 0.2

			if var_167_32 < arg_164_1.time_ and arg_164_1.time_ <= var_167_32 + arg_167_0 then
				local var_167_34 = "play"
				local var_167_35 = "music"

				arg_164_1:AudioAction(var_167_34, var_167_35, "ui_battle", "ui_battle_stopbgm", "")

				local var_167_36 = ""
				local var_167_37 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_167_37 ~= "" then
					if arg_164_1.bgmTxt_.text ~= var_167_37 and arg_164_1.bgmTxt_.text ~= "" then
						if arg_164_1.bgmTxt2_.text ~= "" then
							arg_164_1.bgmTxt_.text = arg_164_1.bgmTxt2_.text
						end

						arg_164_1.bgmTxt2_.text = var_167_37

						arg_164_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_164_1.bgmTxt_.text = var_167_37
						arg_164_1.bgmTxt2_.text = var_167_37
					end

					if arg_164_1.bgmTimer then
						arg_164_1.bgmTimer:Stop()

						arg_164_1.bgmTimer = nil
					end

					if arg_164_1.settingData.show_music_name == 1 then
						arg_164_1.musicController:SetSelectedState("show")
						arg_164_1.musicAnimator_:Play("open", 0, 0)

						if arg_164_1.settingData.music_time ~= 0 then
							arg_164_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_164_1.settingData.music_time), function()
								if arg_164_1 == nil or isNil(arg_164_1.bgmTxt_) then
									return
								end

								arg_164_1.musicController:SetSelectedState("hide")
								arg_164_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_167_38 = 1.8
			local var_167_39 = 1

			if var_167_38 < arg_164_1.time_ and arg_164_1.time_ <= var_167_38 + arg_167_0 then
				local var_167_40 = "play"
				local var_167_41 = "music"

				arg_164_1:AudioAction(var_167_40, var_167_41, "bgm_activity_4_0_story_osiris_room", "bgm_activity_4_0_story_osiris_room", "bgm_activity_4_0_story_osiris_room.awb")

				local var_167_42 = ""
				local var_167_43 = manager.audio:GetAudioName("bgm_activity_4_0_story_osiris_room", "bgm_activity_4_0_story_osiris_room")

				if var_167_43 ~= "" then
					if arg_164_1.bgmTxt_.text ~= var_167_43 and arg_164_1.bgmTxt_.text ~= "" then
						if arg_164_1.bgmTxt2_.text ~= "" then
							arg_164_1.bgmTxt_.text = arg_164_1.bgmTxt2_.text
						end

						arg_164_1.bgmTxt2_.text = var_167_43

						arg_164_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_164_1.bgmTxt_.text = var_167_43
						arg_164_1.bgmTxt2_.text = var_167_43
					end

					if arg_164_1.bgmTimer then
						arg_164_1.bgmTimer:Stop()

						arg_164_1.bgmTimer = nil
					end

					if arg_164_1.settingData.show_music_name == 1 then
						arg_164_1.musicController:SetSelectedState("show")
						arg_164_1.musicAnimator_:Play("open", 0, 0)

						if arg_164_1.settingData.music_time ~= 0 then
							arg_164_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_164_1.settingData.music_time), function()
								if arg_164_1 == nil or isNil(arg_164_1.bgmTxt_) then
									return
								end

								arg_164_1.musicController:SetSelectedState("hide")
								arg_164_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_167_44 = 0.3
			local var_167_45 = 1

			if var_167_44 < arg_164_1.time_ and arg_164_1.time_ <= var_167_44 + arg_167_0 then
				local var_167_46 = "stop"
				local var_167_47 = "effect"

				arg_164_1:AudioAction(var_167_46, var_167_47, "se_story_140", "se_story_140_amb_wind_thunder", "")
			end

			if arg_164_1.frameCnt_ <= 1 then
				arg_164_1.dialog_:SetActive(false)
			end

			local var_167_48 = 3.924999999999
			local var_167_49 = 0.075

			if var_167_48 < arg_164_1.time_ and arg_164_1.time_ <= var_167_48 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				arg_164_1.dialog_:SetActive(true)

				arg_164_1.dialogCg_.alpha = 0

				local var_167_50 = LeanTween.value(arg_164_1.dialog_, 0, 1, 0.3)

				var_167_50:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_164_1.dialogCg_.alpha = arg_170_0
				end))
				var_167_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_164_1.dialog_)
					var_167_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_164_1.duration_ = arg_164_1.duration_ + 0.3

				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_51 = arg_164_1:FormatText(StoryNameCfg[37].name)

				arg_164_1.leftNameTxt_.text = var_167_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_52 = arg_164_1:GetWordFromCfg(321231039)
				local var_167_53 = arg_164_1:FormatText(var_167_52.content)

				arg_164_1.text_.text = var_167_53

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_54 = 3
				local var_167_55 = utf8.len(var_167_53)
				local var_167_56 = var_167_54 <= 0 and var_167_49 or var_167_49 * (var_167_55 / var_167_54)

				if var_167_56 > 0 and var_167_49 < var_167_56 then
					arg_164_1.talkMaxDuration = var_167_56
					var_167_48 = var_167_48 + 0.3

					if var_167_56 + var_167_48 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_56 + var_167_48
					end
				end

				arg_164_1.text_.text = var_167_53
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231039", "story_v_out_321231.awb") ~= 0 then
					local var_167_57 = manager.audio:GetVoiceLength("story_v_out_321231", "321231039", "story_v_out_321231.awb") / 1000

					if var_167_57 + var_167_48 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_57 + var_167_48
					end

					if var_167_52.prefab_name ~= "" and arg_164_1.actors_[var_167_52.prefab_name] ~= nil then
						local var_167_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_52.prefab_name].transform, "story_v_out_321231", "321231039", "story_v_out_321231.awb")

						arg_164_1:RecordAudio("321231039", var_167_58)
						arg_164_1:RecordAudio("321231039", var_167_58)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_321231", "321231039", "story_v_out_321231.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_321231", "321231039", "story_v_out_321231.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_59 = var_167_48 + 0.3
			local var_167_60 = math.max(var_167_49, arg_164_1.talkMaxDuration)

			if var_167_59 <= arg_164_1.time_ and arg_164_1.time_ < var_167_59 + var_167_60 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_59) / var_167_60

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_59 + var_167_60 and arg_164_1.time_ < var_167_59 + var_167_60 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play321231040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 321231040
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play321231041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = "1011ui_story"

			if arg_172_1.actors_[var_175_0] == nil then
				local var_175_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_175_1) then
					local var_175_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_172_1.stage_.transform)

					var_175_2.name = var_175_0
					var_175_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_172_1.actors_[var_175_0] = var_175_2

					local var_175_3 = var_175_2:GetComponentInChildren(typeof(CharacterEffect))

					var_175_3.enabled = true

					local var_175_4 = GameObjectTools.GetOrAddComponent(var_175_2, typeof(DynamicBoneHelper))

					if var_175_4 then
						var_175_4:EnableDynamicBone(false)
					end

					arg_172_1:ShowWeapon(var_175_3.transform, false)

					arg_172_1.var_[var_175_0 .. "Animator"] = var_175_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_172_1.var_[var_175_0 .. "Animator"].applyRootMotion = true
					arg_172_1.var_[var_175_0 .. "LipSync"] = var_175_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_175_5 = arg_172_1.actors_["1011ui_story"]
			local var_175_6 = 0

			if var_175_6 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 and not isNil(var_175_5) and arg_172_1.var_.characterEffect1011ui_story == nil then
				arg_172_1.var_.characterEffect1011ui_story = var_175_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_7 = 0.200000002980232

			if var_175_6 <= arg_172_1.time_ and arg_172_1.time_ < var_175_6 + var_175_7 and not isNil(var_175_5) then
				local var_175_8 = (arg_172_1.time_ - var_175_6) / var_175_7

				if arg_172_1.var_.characterEffect1011ui_story and not isNil(var_175_5) then
					local var_175_9 = Mathf.Lerp(0, 0.5, var_175_8)

					arg_172_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1011ui_story.fillRatio = var_175_9
				end
			end

			if arg_172_1.time_ >= var_175_6 + var_175_7 and arg_172_1.time_ < var_175_6 + var_175_7 + arg_175_0 and not isNil(var_175_5) and arg_172_1.var_.characterEffect1011ui_story then
				local var_175_10 = 0.5

				arg_172_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1011ui_story.fillRatio = var_175_10
			end

			local var_175_11 = 0.034000001847744
			local var_175_12 = 1

			if var_175_11 < arg_172_1.time_ and arg_172_1.time_ <= var_175_11 + arg_175_0 then
				local var_175_13 = "play"
				local var_175_14 = "effect"

				arg_172_1:AudioAction(var_175_13, var_175_14, "se_story_140", "se_story_140_water", "")
			end

			local var_175_15 = 0
			local var_175_16 = 0.8

			if var_175_15 < arg_172_1.time_ and arg_172_1.time_ <= var_175_15 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_17 = arg_172_1:GetWordFromCfg(321231040)
				local var_175_18 = arg_172_1:FormatText(var_175_17.content)

				arg_172_1.text_.text = var_175_18

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_19 = 32
				local var_175_20 = utf8.len(var_175_18)
				local var_175_21 = var_175_19 <= 0 and var_175_16 or var_175_16 * (var_175_20 / var_175_19)

				if var_175_21 > 0 and var_175_16 < var_175_21 then
					arg_172_1.talkMaxDuration = var_175_21

					if var_175_21 + var_175_15 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_21 + var_175_15
					end
				end

				arg_172_1.text_.text = var_175_18
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_22 = math.max(var_175_16, arg_172_1.talkMaxDuration)

			if var_175_15 <= arg_172_1.time_ and arg_172_1.time_ < var_175_15 + var_175_22 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_15) / var_175_22

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_15 + var_175_22 and arg_172_1.time_ < var_175_15 + var_175_22 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play321231041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 321231041
		arg_176_1.duration_ = 4.07

		local var_176_0 = {
			zh = 4.066,
			ja = 2.3
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
				arg_176_0:Play321231042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1011ui_story"].transform
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.var_.moveOldPos1011ui_story = var_179_0.localPosition
			end

			local var_179_2 = 0.001

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2
				local var_179_4 = Vector3.New(0, -0.71, -6)

				var_179_0.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1011ui_story, var_179_4, var_179_3)

				local var_179_5 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_5.x, var_179_5.y, var_179_5.z)

				local var_179_6 = var_179_0.localEulerAngles

				var_179_6.z = 0
				var_179_6.x = 0
				var_179_0.localEulerAngles = var_179_6
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 then
				var_179_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_179_7 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_7.x, var_179_7.y, var_179_7.z)

				local var_179_8 = var_179_0.localEulerAngles

				var_179_8.z = 0
				var_179_8.x = 0
				var_179_0.localEulerAngles = var_179_8
			end

			local var_179_9 = arg_176_1.actors_["1011ui_story"]
			local var_179_10 = 0

			if var_179_10 < arg_176_1.time_ and arg_176_1.time_ <= var_179_10 + arg_179_0 and not isNil(var_179_9) and arg_176_1.var_.characterEffect1011ui_story == nil then
				arg_176_1.var_.characterEffect1011ui_story = var_179_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_11 = 0.200000002980232

			if var_179_10 <= arg_176_1.time_ and arg_176_1.time_ < var_179_10 + var_179_11 and not isNil(var_179_9) then
				local var_179_12 = (arg_176_1.time_ - var_179_10) / var_179_11

				if arg_176_1.var_.characterEffect1011ui_story and not isNil(var_179_9) then
					arg_176_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_10 + var_179_11 and arg_176_1.time_ < var_179_10 + var_179_11 + arg_179_0 and not isNil(var_179_9) and arg_176_1.var_.characterEffect1011ui_story then
				arg_176_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_179_13 = 0

			if var_179_13 < arg_176_1.time_ and arg_176_1.time_ <= var_179_13 + arg_179_0 then
				arg_176_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			local var_179_14 = 0

			if var_179_14 < arg_176_1.time_ and arg_176_1.time_ <= var_179_14 + arg_179_0 then
				arg_176_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_179_15 = 0
			local var_179_16 = 0.225

			if var_179_15 < arg_176_1.time_ and arg_176_1.time_ <= var_179_15 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_17 = arg_176_1:FormatText(StoryNameCfg[37].name)

				arg_176_1.leftNameTxt_.text = var_179_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_18 = arg_176_1:GetWordFromCfg(321231041)
				local var_179_19 = arg_176_1:FormatText(var_179_18.content)

				arg_176_1.text_.text = var_179_19

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_20 = 9
				local var_179_21 = utf8.len(var_179_19)
				local var_179_22 = var_179_20 <= 0 and var_179_16 or var_179_16 * (var_179_21 / var_179_20)

				if var_179_22 > 0 and var_179_16 < var_179_22 then
					arg_176_1.talkMaxDuration = var_179_22

					if var_179_22 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_22 + var_179_15
					end
				end

				arg_176_1.text_.text = var_179_19
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231041", "story_v_out_321231.awb") ~= 0 then
					local var_179_23 = manager.audio:GetVoiceLength("story_v_out_321231", "321231041", "story_v_out_321231.awb") / 1000

					if var_179_23 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_23 + var_179_15
					end

					if var_179_18.prefab_name ~= "" and arg_176_1.actors_[var_179_18.prefab_name] ~= nil then
						local var_179_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_18.prefab_name].transform, "story_v_out_321231", "321231041", "story_v_out_321231.awb")

						arg_176_1:RecordAudio("321231041", var_179_24)
						arg_176_1:RecordAudio("321231041", var_179_24)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_321231", "321231041", "story_v_out_321231.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_321231", "321231041", "story_v_out_321231.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_25 = math.max(var_179_16, arg_176_1.talkMaxDuration)

			if var_179_15 <= arg_176_1.time_ and arg_176_1.time_ < var_179_15 + var_179_25 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_15) / var_179_25

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_15 + var_179_25 and arg_176_1.time_ < var_179_15 + var_179_25 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play321231042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 321231042
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play321231043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1011ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1011ui_story == nil then
				arg_180_1.var_.characterEffect1011ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect1011ui_story and not isNil(var_183_0) then
					local var_183_4 = Mathf.Lerp(0, 0.5, var_183_3)

					arg_180_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1011ui_story.fillRatio = var_183_4
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1011ui_story then
				local var_183_5 = 0.5

				arg_180_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1011ui_story.fillRatio = var_183_5
			end

			local var_183_6 = arg_180_1.actors_["1011ui_story"].transform
			local var_183_7 = 0

			if var_183_7 < arg_180_1.time_ and arg_180_1.time_ <= var_183_7 + arg_183_0 then
				arg_180_1.var_.moveOldPos1011ui_story = var_183_6.localPosition
			end

			local var_183_8 = 0.001

			if var_183_7 <= arg_180_1.time_ and arg_180_1.time_ < var_183_7 + var_183_8 then
				local var_183_9 = (arg_180_1.time_ - var_183_7) / var_183_8
				local var_183_10 = Vector3.New(0, 100, 0)

				var_183_6.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1011ui_story, var_183_10, var_183_9)

				local var_183_11 = manager.ui.mainCamera.transform.position - var_183_6.position

				var_183_6.forward = Vector3.New(var_183_11.x, var_183_11.y, var_183_11.z)

				local var_183_12 = var_183_6.localEulerAngles

				var_183_12.z = 0
				var_183_12.x = 0
				var_183_6.localEulerAngles = var_183_12
			end

			if arg_180_1.time_ >= var_183_7 + var_183_8 and arg_180_1.time_ < var_183_7 + var_183_8 + arg_183_0 then
				var_183_6.localPosition = Vector3.New(0, 100, 0)

				local var_183_13 = manager.ui.mainCamera.transform.position - var_183_6.position

				var_183_6.forward = Vector3.New(var_183_13.x, var_183_13.y, var_183_13.z)

				local var_183_14 = var_183_6.localEulerAngles

				var_183_14.z = 0
				var_183_14.x = 0
				var_183_6.localEulerAngles = var_183_14
			end

			local var_183_15 = 0
			local var_183_16 = 1.6

			if var_183_15 < arg_180_1.time_ and arg_180_1.time_ <= var_183_15 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_17 = arg_180_1:GetWordFromCfg(321231042)
				local var_183_18 = arg_180_1:FormatText(var_183_17.content)

				arg_180_1.text_.text = var_183_18

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_19 = 64
				local var_183_20 = utf8.len(var_183_18)
				local var_183_21 = var_183_19 <= 0 and var_183_16 or var_183_16 * (var_183_20 / var_183_19)

				if var_183_21 > 0 and var_183_16 < var_183_21 then
					arg_180_1.talkMaxDuration = var_183_21

					if var_183_21 + var_183_15 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_21 + var_183_15
					end
				end

				arg_180_1.text_.text = var_183_18
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_22 = math.max(var_183_16, arg_180_1.talkMaxDuration)

			if var_183_15 <= arg_180_1.time_ and arg_180_1.time_ < var_183_15 + var_183_22 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_15) / var_183_22

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_15 + var_183_22 and arg_180_1.time_ < var_183_15 + var_183_22 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play321231043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 321231043
		arg_184_1.duration_ = 6.3

		local var_184_0 = {
			zh = 4,
			ja = 6.3
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
				arg_184_0:Play321231044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1011ui_story"].transform
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.var_.moveOldPos1011ui_story = var_187_0.localPosition
			end

			local var_187_2 = 0.001

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2
				local var_187_4 = Vector3.New(0, -0.71, -6)

				var_187_0.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1011ui_story, var_187_4, var_187_3)

				local var_187_5 = manager.ui.mainCamera.transform.position - var_187_0.position

				var_187_0.forward = Vector3.New(var_187_5.x, var_187_5.y, var_187_5.z)

				local var_187_6 = var_187_0.localEulerAngles

				var_187_6.z = 0
				var_187_6.x = 0
				var_187_0.localEulerAngles = var_187_6
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 then
				var_187_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_187_7 = manager.ui.mainCamera.transform.position - var_187_0.position

				var_187_0.forward = Vector3.New(var_187_7.x, var_187_7.y, var_187_7.z)

				local var_187_8 = var_187_0.localEulerAngles

				var_187_8.z = 0
				var_187_8.x = 0
				var_187_0.localEulerAngles = var_187_8
			end

			local var_187_9 = arg_184_1.actors_["1011ui_story"]
			local var_187_10 = 0

			if var_187_10 < arg_184_1.time_ and arg_184_1.time_ <= var_187_10 + arg_187_0 and not isNil(var_187_9) and arg_184_1.var_.characterEffect1011ui_story == nil then
				arg_184_1.var_.characterEffect1011ui_story = var_187_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_11 = 0.200000002980232

			if var_187_10 <= arg_184_1.time_ and arg_184_1.time_ < var_187_10 + var_187_11 and not isNil(var_187_9) then
				local var_187_12 = (arg_184_1.time_ - var_187_10) / var_187_11

				if arg_184_1.var_.characterEffect1011ui_story and not isNil(var_187_9) then
					arg_184_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_10 + var_187_11 and arg_184_1.time_ < var_187_10 + var_187_11 + arg_187_0 and not isNil(var_187_9) and arg_184_1.var_.characterEffect1011ui_story then
				arg_184_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_187_13 = 0

			if var_187_13 < arg_184_1.time_ and arg_184_1.time_ <= var_187_13 + arg_187_0 then
				arg_184_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_2")
			end

			local var_187_14 = 0

			if var_187_14 < arg_184_1.time_ and arg_184_1.time_ <= var_187_14 + arg_187_0 then
				arg_184_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_187_15 = 0
			local var_187_16 = 0.25

			if var_187_15 < arg_184_1.time_ and arg_184_1.time_ <= var_187_15 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_17 = arg_184_1:FormatText(StoryNameCfg[37].name)

				arg_184_1.leftNameTxt_.text = var_187_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_18 = arg_184_1:GetWordFromCfg(321231043)
				local var_187_19 = arg_184_1:FormatText(var_187_18.content)

				arg_184_1.text_.text = var_187_19

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_20 = 10
				local var_187_21 = utf8.len(var_187_19)
				local var_187_22 = var_187_20 <= 0 and var_187_16 or var_187_16 * (var_187_21 / var_187_20)

				if var_187_22 > 0 and var_187_16 < var_187_22 then
					arg_184_1.talkMaxDuration = var_187_22

					if var_187_22 + var_187_15 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_22 + var_187_15
					end
				end

				arg_184_1.text_.text = var_187_19
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231043", "story_v_out_321231.awb") ~= 0 then
					local var_187_23 = manager.audio:GetVoiceLength("story_v_out_321231", "321231043", "story_v_out_321231.awb") / 1000

					if var_187_23 + var_187_15 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_23 + var_187_15
					end

					if var_187_18.prefab_name ~= "" and arg_184_1.actors_[var_187_18.prefab_name] ~= nil then
						local var_187_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_18.prefab_name].transform, "story_v_out_321231", "321231043", "story_v_out_321231.awb")

						arg_184_1:RecordAudio("321231043", var_187_24)
						arg_184_1:RecordAudio("321231043", var_187_24)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_321231", "321231043", "story_v_out_321231.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_321231", "321231043", "story_v_out_321231.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_25 = math.max(var_187_16, arg_184_1.talkMaxDuration)

			if var_187_15 <= arg_184_1.time_ and arg_184_1.time_ < var_187_15 + var_187_25 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_15) / var_187_25

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_15 + var_187_25 and arg_184_1.time_ < var_187_15 + var_187_25 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play321231044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 321231044
		arg_188_1.duration_ = 5.5

		local var_188_0 = {
			zh = 5.366,
			ja = 5.5
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
				arg_188_0:Play321231045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0
			local var_191_1 = 0.475

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_2 = arg_188_1:FormatText(StoryNameCfg[37].name)

				arg_188_1.leftNameTxt_.text = var_191_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_3 = arg_188_1:GetWordFromCfg(321231044)
				local var_191_4 = arg_188_1:FormatText(var_191_3.content)

				arg_188_1.text_.text = var_191_4

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_5 = 19
				local var_191_6 = utf8.len(var_191_4)
				local var_191_7 = var_191_5 <= 0 and var_191_1 or var_191_1 * (var_191_6 / var_191_5)

				if var_191_7 > 0 and var_191_1 < var_191_7 then
					arg_188_1.talkMaxDuration = var_191_7

					if var_191_7 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_7 + var_191_0
					end
				end

				arg_188_1.text_.text = var_191_4
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231044", "story_v_out_321231.awb") ~= 0 then
					local var_191_8 = manager.audio:GetVoiceLength("story_v_out_321231", "321231044", "story_v_out_321231.awb") / 1000

					if var_191_8 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_8 + var_191_0
					end

					if var_191_3.prefab_name ~= "" and arg_188_1.actors_[var_191_3.prefab_name] ~= nil then
						local var_191_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_3.prefab_name].transform, "story_v_out_321231", "321231044", "story_v_out_321231.awb")

						arg_188_1:RecordAudio("321231044", var_191_9)
						arg_188_1:RecordAudio("321231044", var_191_9)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_321231", "321231044", "story_v_out_321231.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_321231", "321231044", "story_v_out_321231.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_10 = math.max(var_191_1, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_10 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_0) / var_191_10

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_10 and arg_188_1.time_ < var_191_0 + var_191_10 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play321231045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 321231045
		arg_192_1.duration_ = 8.5

		local var_192_0 = {
			zh = 6.2,
			ja = 8.5
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
				arg_192_0:Play321231046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 0.725

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_2 = arg_192_1:FormatText(StoryNameCfg[37].name)

				arg_192_1.leftNameTxt_.text = var_195_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_3 = arg_192_1:GetWordFromCfg(321231045)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 29
				local var_195_6 = utf8.len(var_195_4)
				local var_195_7 = var_195_5 <= 0 and var_195_1 or var_195_1 * (var_195_6 / var_195_5)

				if var_195_7 > 0 and var_195_1 < var_195_7 then
					arg_192_1.talkMaxDuration = var_195_7

					if var_195_7 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_7 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231045", "story_v_out_321231.awb") ~= 0 then
					local var_195_8 = manager.audio:GetVoiceLength("story_v_out_321231", "321231045", "story_v_out_321231.awb") / 1000

					if var_195_8 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_8 + var_195_0
					end

					if var_195_3.prefab_name ~= "" and arg_192_1.actors_[var_195_3.prefab_name] ~= nil then
						local var_195_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_3.prefab_name].transform, "story_v_out_321231", "321231045", "story_v_out_321231.awb")

						arg_192_1:RecordAudio("321231045", var_195_9)
						arg_192_1:RecordAudio("321231045", var_195_9)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_321231", "321231045", "story_v_out_321231.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_321231", "321231045", "story_v_out_321231.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_10 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_10 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_10

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_10 and arg_192_1.time_ < var_195_0 + var_195_10 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play321231046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 321231046
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play321231047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1011ui_story"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos1011ui_story = var_199_0.localPosition
			end

			local var_199_2 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2
				local var_199_4 = Vector3.New(0, 100, 0)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1011ui_story, var_199_4, var_199_3)

				local var_199_5 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_5.x, var_199_5.y, var_199_5.z)

				local var_199_6 = var_199_0.localEulerAngles

				var_199_6.z = 0
				var_199_6.x = 0
				var_199_0.localEulerAngles = var_199_6
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(0, 100, 0)

				local var_199_7 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_7.x, var_199_7.y, var_199_7.z)

				local var_199_8 = var_199_0.localEulerAngles

				var_199_8.z = 0
				var_199_8.x = 0
				var_199_0.localEulerAngles = var_199_8
			end

			local var_199_9 = arg_196_1.actors_["1011ui_story"]
			local var_199_10 = 0

			if var_199_10 < arg_196_1.time_ and arg_196_1.time_ <= var_199_10 + arg_199_0 and not isNil(var_199_9) and arg_196_1.var_.characterEffect1011ui_story == nil then
				arg_196_1.var_.characterEffect1011ui_story = var_199_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_11 = 0.200000002980232

			if var_199_10 <= arg_196_1.time_ and arg_196_1.time_ < var_199_10 + var_199_11 and not isNil(var_199_9) then
				local var_199_12 = (arg_196_1.time_ - var_199_10) / var_199_11

				if arg_196_1.var_.characterEffect1011ui_story and not isNil(var_199_9) then
					local var_199_13 = Mathf.Lerp(0, 0.5, var_199_12)

					arg_196_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1011ui_story.fillRatio = var_199_13
				end
			end

			if arg_196_1.time_ >= var_199_10 + var_199_11 and arg_196_1.time_ < var_199_10 + var_199_11 + arg_199_0 and not isNil(var_199_9) and arg_196_1.var_.characterEffect1011ui_story then
				local var_199_14 = 0.5

				arg_196_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1011ui_story.fillRatio = var_199_14
			end

			local var_199_15 = 0
			local var_199_16 = 1.25

			if var_199_15 < arg_196_1.time_ and arg_196_1.time_ <= var_199_15 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_17 = arg_196_1:GetWordFromCfg(321231046)
				local var_199_18 = arg_196_1:FormatText(var_199_17.content)

				arg_196_1.text_.text = var_199_18

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_19 = 50
				local var_199_20 = utf8.len(var_199_18)
				local var_199_21 = var_199_19 <= 0 and var_199_16 or var_199_16 * (var_199_20 / var_199_19)

				if var_199_21 > 0 and var_199_16 < var_199_21 then
					arg_196_1.talkMaxDuration = var_199_21

					if var_199_21 + var_199_15 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_21 + var_199_15
					end
				end

				arg_196_1.text_.text = var_199_18
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_22 = math.max(var_199_16, arg_196_1.talkMaxDuration)

			if var_199_15 <= arg_196_1.time_ and arg_196_1.time_ < var_199_15 + var_199_22 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_15) / var_199_22

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_15 + var_199_22 and arg_196_1.time_ < var_199_15 + var_199_22 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play321231047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 321231047
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play321231048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 1

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_2 = arg_200_1:GetWordFromCfg(321231047)
				local var_203_3 = arg_200_1:FormatText(var_203_2.content)

				arg_200_1.text_.text = var_203_3

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 40
				local var_203_5 = utf8.len(var_203_3)
				local var_203_6 = var_203_4 <= 0 and var_203_1 or var_203_1 * (var_203_5 / var_203_4)

				if var_203_6 > 0 and var_203_1 < var_203_6 then
					arg_200_1.talkMaxDuration = var_203_6

					if var_203_6 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_6 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_3
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_7 and arg_200_1.time_ < var_203_0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play321231048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 321231048
		arg_204_1.duration_ = 3.33

		local var_204_0 = {
			zh = 3.3,
			ja = 3.333
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
				arg_204_0:Play321231049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1011ui_story"].transform
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1.var_.moveOldPos1011ui_story = var_207_0.localPosition
			end

			local var_207_2 = 0.001

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2
				local var_207_4 = Vector3.New(0, -0.71, -6)

				var_207_0.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1011ui_story, var_207_4, var_207_3)

				local var_207_5 = manager.ui.mainCamera.transform.position - var_207_0.position

				var_207_0.forward = Vector3.New(var_207_5.x, var_207_5.y, var_207_5.z)

				local var_207_6 = var_207_0.localEulerAngles

				var_207_6.z = 0
				var_207_6.x = 0
				var_207_0.localEulerAngles = var_207_6
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 then
				var_207_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_207_7 = manager.ui.mainCamera.transform.position - var_207_0.position

				var_207_0.forward = Vector3.New(var_207_7.x, var_207_7.y, var_207_7.z)

				local var_207_8 = var_207_0.localEulerAngles

				var_207_8.z = 0
				var_207_8.x = 0
				var_207_0.localEulerAngles = var_207_8
			end

			local var_207_9 = arg_204_1.actors_["1011ui_story"]
			local var_207_10 = 0

			if var_207_10 < arg_204_1.time_ and arg_204_1.time_ <= var_207_10 + arg_207_0 and not isNil(var_207_9) and arg_204_1.var_.characterEffect1011ui_story == nil then
				arg_204_1.var_.characterEffect1011ui_story = var_207_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_11 = 0.200000002980232

			if var_207_10 <= arg_204_1.time_ and arg_204_1.time_ < var_207_10 + var_207_11 and not isNil(var_207_9) then
				local var_207_12 = (arg_204_1.time_ - var_207_10) / var_207_11

				if arg_204_1.var_.characterEffect1011ui_story and not isNil(var_207_9) then
					arg_204_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_10 + var_207_11 and arg_204_1.time_ < var_207_10 + var_207_11 + arg_207_0 and not isNil(var_207_9) and arg_204_1.var_.characterEffect1011ui_story then
				arg_204_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_207_13 = 0

			if var_207_13 < arg_204_1.time_ and arg_204_1.time_ <= var_207_13 + arg_207_0 then
				arg_204_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_207_14 = 0

			if var_207_14 < arg_204_1.time_ and arg_204_1.time_ <= var_207_14 + arg_207_0 then
				arg_204_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva", "EmotionTimelineAnimator")
			end

			local var_207_15 = 0
			local var_207_16 = 0.25

			if var_207_15 < arg_204_1.time_ and arg_204_1.time_ <= var_207_15 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_17 = arg_204_1:FormatText(StoryNameCfg[37].name)

				arg_204_1.leftNameTxt_.text = var_207_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_18 = arg_204_1:GetWordFromCfg(321231048)
				local var_207_19 = arg_204_1:FormatText(var_207_18.content)

				arg_204_1.text_.text = var_207_19

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_20 = 10
				local var_207_21 = utf8.len(var_207_19)
				local var_207_22 = var_207_20 <= 0 and var_207_16 or var_207_16 * (var_207_21 / var_207_20)

				if var_207_22 > 0 and var_207_16 < var_207_22 then
					arg_204_1.talkMaxDuration = var_207_22

					if var_207_22 + var_207_15 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_22 + var_207_15
					end
				end

				arg_204_1.text_.text = var_207_19
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231048", "story_v_out_321231.awb") ~= 0 then
					local var_207_23 = manager.audio:GetVoiceLength("story_v_out_321231", "321231048", "story_v_out_321231.awb") / 1000

					if var_207_23 + var_207_15 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_23 + var_207_15
					end

					if var_207_18.prefab_name ~= "" and arg_204_1.actors_[var_207_18.prefab_name] ~= nil then
						local var_207_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_18.prefab_name].transform, "story_v_out_321231", "321231048", "story_v_out_321231.awb")

						arg_204_1:RecordAudio("321231048", var_207_24)
						arg_204_1:RecordAudio("321231048", var_207_24)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_321231", "321231048", "story_v_out_321231.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_321231", "321231048", "story_v_out_321231.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_25 = math.max(var_207_16, arg_204_1.talkMaxDuration)

			if var_207_15 <= arg_204_1.time_ and arg_204_1.time_ < var_207_15 + var_207_25 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_15) / var_207_25

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_15 + var_207_25 and arg_204_1.time_ < var_207_15 + var_207_25 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play321231049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 321231049
		arg_208_1.duration_ = 1.93

		local var_208_0 = {
			zh = 1.933,
			ja = 1.833
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
				arg_208_0:Play321231050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["1011ui_story"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1011ui_story == nil then
				arg_208_1.var_.characterEffect1011ui_story = var_211_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.200000002980232

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.characterEffect1011ui_story and not isNil(var_211_0) then
					local var_211_4 = Mathf.Lerp(0, 0.5, var_211_3)

					arg_208_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1011ui_story.fillRatio = var_211_4
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1011ui_story then
				local var_211_5 = 0.5

				arg_208_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1011ui_story.fillRatio = var_211_5
			end

			local var_211_6 = 0
			local var_211_7 = 0.075

			if var_211_6 < arg_208_1.time_ and arg_208_1.time_ <= var_211_6 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_8 = arg_208_1:FormatText(StoryNameCfg[36].name)

				arg_208_1.leftNameTxt_.text = var_211_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4047")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_9 = arg_208_1:GetWordFromCfg(321231049)
				local var_211_10 = arg_208_1:FormatText(var_211_9.content)

				arg_208_1.text_.text = var_211_10

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_11 = 3
				local var_211_12 = utf8.len(var_211_10)
				local var_211_13 = var_211_11 <= 0 and var_211_7 or var_211_7 * (var_211_12 / var_211_11)

				if var_211_13 > 0 and var_211_7 < var_211_13 then
					arg_208_1.talkMaxDuration = var_211_13

					if var_211_13 + var_211_6 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_13 + var_211_6
					end
				end

				arg_208_1.text_.text = var_211_10
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231049", "story_v_out_321231.awb") ~= 0 then
					local var_211_14 = manager.audio:GetVoiceLength("story_v_out_321231", "321231049", "story_v_out_321231.awb") / 1000

					if var_211_14 + var_211_6 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_14 + var_211_6
					end

					if var_211_9.prefab_name ~= "" and arg_208_1.actors_[var_211_9.prefab_name] ~= nil then
						local var_211_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_9.prefab_name].transform, "story_v_out_321231", "321231049", "story_v_out_321231.awb")

						arg_208_1:RecordAudio("321231049", var_211_15)
						arg_208_1:RecordAudio("321231049", var_211_15)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_321231", "321231049", "story_v_out_321231.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_321231", "321231049", "story_v_out_321231.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_16 = math.max(var_211_7, arg_208_1.talkMaxDuration)

			if var_211_6 <= arg_208_1.time_ and arg_208_1.time_ < var_211_6 + var_211_16 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_6) / var_211_16

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_6 + var_211_16 and arg_208_1.time_ < var_211_6 + var_211_16 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play321231050 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 321231050
		arg_212_1.duration_ = 2

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play321231051(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1011ui_story"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1011ui_story == nil then
				arg_212_1.var_.characterEffect1011ui_story = var_215_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.characterEffect1011ui_story and not isNil(var_215_0) then
					arg_212_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1011ui_story then
				arg_212_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_215_4 = 0

			if var_215_4 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_215_5 = 0

			if var_215_5 < arg_212_1.time_ and arg_212_1.time_ <= var_215_5 + arg_215_0 then
				arg_212_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action8_1")
			end

			local var_215_6 = 0
			local var_215_7 = 0.05

			if var_215_6 < arg_212_1.time_ and arg_212_1.time_ <= var_215_6 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_8 = arg_212_1:FormatText(StoryNameCfg[37].name)

				arg_212_1.leftNameTxt_.text = var_215_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_9 = arg_212_1:GetWordFromCfg(321231050)
				local var_215_10 = arg_212_1:FormatText(var_215_9.content)

				arg_212_1.text_.text = var_215_10

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_11 = 2
				local var_215_12 = utf8.len(var_215_10)
				local var_215_13 = var_215_11 <= 0 and var_215_7 or var_215_7 * (var_215_12 / var_215_11)

				if var_215_13 > 0 and var_215_7 < var_215_13 then
					arg_212_1.talkMaxDuration = var_215_13

					if var_215_13 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_6
					end
				end

				arg_212_1.text_.text = var_215_10
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231050", "story_v_out_321231.awb") ~= 0 then
					local var_215_14 = manager.audio:GetVoiceLength("story_v_out_321231", "321231050", "story_v_out_321231.awb") / 1000

					if var_215_14 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_14 + var_215_6
					end

					if var_215_9.prefab_name ~= "" and arg_212_1.actors_[var_215_9.prefab_name] ~= nil then
						local var_215_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_9.prefab_name].transform, "story_v_out_321231", "321231050", "story_v_out_321231.awb")

						arg_212_1:RecordAudio("321231050", var_215_15)
						arg_212_1:RecordAudio("321231050", var_215_15)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_321231", "321231050", "story_v_out_321231.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_321231", "321231050", "story_v_out_321231.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_16 = math.max(var_215_7, arg_212_1.talkMaxDuration)

			if var_215_6 <= arg_212_1.time_ and arg_212_1.time_ < var_215_6 + var_215_16 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_6) / var_215_16

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_6 + var_215_16 and arg_212_1.time_ < var_215_6 + var_215_16 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play321231051 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 321231051
		arg_216_1.duration_ = 5.63

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play321231052(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1011ui_story"].transform
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.var_.moveOldPos1011ui_story = var_219_0.localPosition
			end

			local var_219_2 = 0.001

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2
				local var_219_4 = Vector3.New(0, 100, 0)

				var_219_0.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1011ui_story, var_219_4, var_219_3)

				local var_219_5 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_5.x, var_219_5.y, var_219_5.z)

				local var_219_6 = var_219_0.localEulerAngles

				var_219_6.z = 0
				var_219_6.x = 0
				var_219_0.localEulerAngles = var_219_6
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 then
				var_219_0.localPosition = Vector3.New(0, 100, 0)

				local var_219_7 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_7.x, var_219_7.y, var_219_7.z)

				local var_219_8 = var_219_0.localEulerAngles

				var_219_8.z = 0
				var_219_8.x = 0
				var_219_0.localEulerAngles = var_219_8
			end

			local var_219_9 = arg_216_1.actors_["1011ui_story"]
			local var_219_10 = 0

			if var_219_10 < arg_216_1.time_ and arg_216_1.time_ <= var_219_10 + arg_219_0 and not isNil(var_219_9) and arg_216_1.var_.characterEffect1011ui_story == nil then
				arg_216_1.var_.characterEffect1011ui_story = var_219_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_11 = 0.200000002980232

			if var_219_10 <= arg_216_1.time_ and arg_216_1.time_ < var_219_10 + var_219_11 and not isNil(var_219_9) then
				local var_219_12 = (arg_216_1.time_ - var_219_10) / var_219_11

				if arg_216_1.var_.characterEffect1011ui_story and not isNil(var_219_9) then
					local var_219_13 = Mathf.Lerp(0, 0.5, var_219_12)

					arg_216_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1011ui_story.fillRatio = var_219_13
				end
			end

			if arg_216_1.time_ >= var_219_10 + var_219_11 and arg_216_1.time_ < var_219_10 + var_219_11 + arg_219_0 and not isNil(var_219_9) and arg_216_1.var_.characterEffect1011ui_story then
				local var_219_14 = 0.5

				arg_216_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1011ui_story.fillRatio = var_219_14
			end

			local var_219_15 = 0

			if var_219_15 < arg_216_1.time_ and arg_216_1.time_ <= var_219_15 + arg_219_0 then
				arg_216_1.mask_.enabled = true
				arg_216_1.mask_.raycastTarget = false

				arg_216_1:SetGaussion(false)
			end

			local var_219_16 = 1

			if var_219_15 <= arg_216_1.time_ and arg_216_1.time_ < var_219_15 + var_219_16 then
				local var_219_17 = (arg_216_1.time_ - var_219_15) / var_219_16
				local var_219_18 = Color.New(1, 1, 1)

				var_219_18.a = Mathf.Lerp(1, 0, var_219_17)
				arg_216_1.mask_.color = var_219_18
			end

			if arg_216_1.time_ >= var_219_15 + var_219_16 and arg_216_1.time_ < var_219_15 + var_219_16 + arg_219_0 then
				local var_219_19 = Color.New(1, 1, 1)
				local var_219_20 = 0

				arg_216_1.mask_.enabled = false
				var_219_19.a = var_219_20
				arg_216_1.mask_.color = var_219_19
			end

			local var_219_21 = manager.ui.mainCamera.transform
			local var_219_22 = 0

			if var_219_22 < arg_216_1.time_ and arg_216_1.time_ <= var_219_22 + arg_219_0 then
				local var_219_23 = arg_216_1.var_.effectshuizhu1
				local var_219_24
				local var_219_25 = var_219_21

				if not var_219_23 then
					var_219_23 = Object.Instantiate(Asset.Load("Effect/Scene/fx_raindrop"), var_219_25)
					var_219_23.name = "shuizhu1"
					arg_216_1.var_.effectshuizhu1 = var_219_23
				else
					var_219_23.transform:SetParent(var_219_25)
				end

				var_219_23.transform.localPosition = Vector3.New(0, 0, 0)
				var_219_23.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_219_26 = 0.034000001847744
			local var_219_27 = 1

			if var_219_26 < arg_216_1.time_ and arg_216_1.time_ <= var_219_26 + arg_219_0 then
				local var_219_28 = "play"
				local var_219_29 = "effect"

				arg_216_1:AudioAction(var_219_28, var_219_29, "se_story_140", "se_story_140_fight_water", "")
			end

			if arg_216_1.frameCnt_ <= 1 then
				arg_216_1.dialog_:SetActive(false)
			end

			local var_219_30 = 0.633333333333333
			local var_219_31 = 1.325

			if var_219_30 < arg_216_1.time_ and arg_216_1.time_ <= var_219_30 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0

				arg_216_1.dialog_:SetActive(true)

				arg_216_1.dialogCg_.alpha = 0

				local var_219_32 = LeanTween.value(arg_216_1.dialog_, 0, 1, 0.3)

				var_219_32:setOnUpdate(LuaHelper.FloatAction(function(arg_220_0)
					arg_216_1.dialogCg_.alpha = arg_220_0
				end))
				var_219_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_216_1.dialog_)
					var_219_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_216_1.duration_ = arg_216_1.duration_ + 0.3

				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_33 = arg_216_1:GetWordFromCfg(321231051)
				local var_219_34 = arg_216_1:FormatText(var_219_33.content)

				arg_216_1.text_.text = var_219_34

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_35 = 53
				local var_219_36 = utf8.len(var_219_34)
				local var_219_37 = var_219_35 <= 0 and var_219_31 or var_219_31 * (var_219_36 / var_219_35)

				if var_219_37 > 0 and var_219_31 < var_219_37 then
					arg_216_1.talkMaxDuration = var_219_37
					var_219_30 = var_219_30 + 0.3

					if var_219_37 + var_219_30 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_37 + var_219_30
					end
				end

				arg_216_1.text_.text = var_219_34
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_38 = var_219_30 + 0.3
			local var_219_39 = math.max(var_219_31, arg_216_1.talkMaxDuration)

			if var_219_38 <= arg_216_1.time_ and arg_216_1.time_ < var_219_38 + var_219_39 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_38) / var_219_39

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_38 + var_219_39 and arg_216_1.time_ < var_219_38 + var_219_39 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play321231052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 321231052
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play321231053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = manager.ui.mainCamera.transform
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				local var_225_2 = arg_222_1.var_.effectshuizhu1

				if var_225_2 then
					Object.Destroy(var_225_2)

					arg_222_1.var_.effectshuizhu1 = nil
				end
			end

			local var_225_3 = 0
			local var_225_4 = 1.425

			if var_225_3 < arg_222_1.time_ and arg_222_1.time_ <= var_225_3 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_5 = arg_222_1:GetWordFromCfg(321231052)
				local var_225_6 = arg_222_1:FormatText(var_225_5.content)

				arg_222_1.text_.text = var_225_6

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_7 = 57
				local var_225_8 = utf8.len(var_225_6)
				local var_225_9 = var_225_7 <= 0 and var_225_4 or var_225_4 * (var_225_8 / var_225_7)

				if var_225_9 > 0 and var_225_4 < var_225_9 then
					arg_222_1.talkMaxDuration = var_225_9

					if var_225_9 + var_225_3 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_9 + var_225_3
					end
				end

				arg_222_1.text_.text = var_225_6
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_10 = math.max(var_225_4, arg_222_1.talkMaxDuration)

			if var_225_3 <= arg_222_1.time_ and arg_222_1.time_ < var_225_3 + var_225_10 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_3) / var_225_10

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_3 + var_225_10 and arg_222_1.time_ < var_225_3 + var_225_10 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play321231053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 321231053
		arg_226_1.duration_ = 6.03

		local var_226_0 = {
			zh = 6.033,
			ja = 4.133
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
				arg_226_0:Play321231054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1011ui_story"].transform
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.var_.moveOldPos1011ui_story = var_229_0.localPosition
			end

			local var_229_2 = 0.001

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2
				local var_229_4 = Vector3.New(0, -0.71, -6)

				var_229_0.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1011ui_story, var_229_4, var_229_3)

				local var_229_5 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_5.x, var_229_5.y, var_229_5.z)

				local var_229_6 = var_229_0.localEulerAngles

				var_229_6.z = 0
				var_229_6.x = 0
				var_229_0.localEulerAngles = var_229_6
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 then
				var_229_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_229_7 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_7.x, var_229_7.y, var_229_7.z)

				local var_229_8 = var_229_0.localEulerAngles

				var_229_8.z = 0
				var_229_8.x = 0
				var_229_0.localEulerAngles = var_229_8
			end

			local var_229_9 = arg_226_1.actors_["1011ui_story"]
			local var_229_10 = 0

			if var_229_10 < arg_226_1.time_ and arg_226_1.time_ <= var_229_10 + arg_229_0 and not isNil(var_229_9) and arg_226_1.var_.characterEffect1011ui_story == nil then
				arg_226_1.var_.characterEffect1011ui_story = var_229_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_11 = 0.200000002980232

			if var_229_10 <= arg_226_1.time_ and arg_226_1.time_ < var_229_10 + var_229_11 and not isNil(var_229_9) then
				local var_229_12 = (arg_226_1.time_ - var_229_10) / var_229_11

				if arg_226_1.var_.characterEffect1011ui_story and not isNil(var_229_9) then
					arg_226_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_10 + var_229_11 and arg_226_1.time_ < var_229_10 + var_229_11 + arg_229_0 and not isNil(var_229_9) and arg_226_1.var_.characterEffect1011ui_story then
				arg_226_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_229_13 = 0

			if var_229_13 < arg_226_1.time_ and arg_226_1.time_ <= var_229_13 + arg_229_0 then
				arg_226_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action486")
			end

			local var_229_14 = 0

			if var_229_14 < arg_226_1.time_ and arg_226_1.time_ <= var_229_14 + arg_229_0 then
				arg_226_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_229_15 = 0
			local var_229_16 = 0.2

			if var_229_15 < arg_226_1.time_ and arg_226_1.time_ <= var_229_15 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_17 = arg_226_1:FormatText(StoryNameCfg[37].name)

				arg_226_1.leftNameTxt_.text = var_229_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_18 = arg_226_1:GetWordFromCfg(321231053)
				local var_229_19 = arg_226_1:FormatText(var_229_18.content)

				arg_226_1.text_.text = var_229_19

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_20 = 8
				local var_229_21 = utf8.len(var_229_19)
				local var_229_22 = var_229_20 <= 0 and var_229_16 or var_229_16 * (var_229_21 / var_229_20)

				if var_229_22 > 0 and var_229_16 < var_229_22 then
					arg_226_1.talkMaxDuration = var_229_22

					if var_229_22 + var_229_15 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_22 + var_229_15
					end
				end

				arg_226_1.text_.text = var_229_19
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231053", "story_v_out_321231.awb") ~= 0 then
					local var_229_23 = manager.audio:GetVoiceLength("story_v_out_321231", "321231053", "story_v_out_321231.awb") / 1000

					if var_229_23 + var_229_15 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_23 + var_229_15
					end

					if var_229_18.prefab_name ~= "" and arg_226_1.actors_[var_229_18.prefab_name] ~= nil then
						local var_229_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_18.prefab_name].transform, "story_v_out_321231", "321231053", "story_v_out_321231.awb")

						arg_226_1:RecordAudio("321231053", var_229_24)
						arg_226_1:RecordAudio("321231053", var_229_24)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_321231", "321231053", "story_v_out_321231.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_321231", "321231053", "story_v_out_321231.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_25 = math.max(var_229_16, arg_226_1.talkMaxDuration)

			if var_229_15 <= arg_226_1.time_ and arg_226_1.time_ < var_229_15 + var_229_25 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_15) / var_229_25

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_15 + var_229_25 and arg_226_1.time_ < var_229_15 + var_229_25 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play321231054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 321231054
		arg_230_1.duration_ = 2.77

		local var_230_0 = {
			zh = 1.733,
			ja = 2.766
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
			arg_230_1.auto_ = false
		end

		function arg_230_1.playNext_(arg_232_0)
			arg_230_1.onStoryFinished_()
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0
			local var_233_1 = 0.125

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_2 = arg_230_1:FormatText(StoryNameCfg[37].name)

				arg_230_1.leftNameTxt_.text = var_233_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_3 = arg_230_1:GetWordFromCfg(321231054)
				local var_233_4 = arg_230_1:FormatText(var_233_3.content)

				arg_230_1.text_.text = var_233_4

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 5
				local var_233_6 = utf8.len(var_233_4)
				local var_233_7 = var_233_5 <= 0 and var_233_1 or var_233_1 * (var_233_6 / var_233_5)

				if var_233_7 > 0 and var_233_1 < var_233_7 then
					arg_230_1.talkMaxDuration = var_233_7

					if var_233_7 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_7 + var_233_0
					end
				end

				arg_230_1.text_.text = var_233_4
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321231", "321231054", "story_v_out_321231.awb") ~= 0 then
					local var_233_8 = manager.audio:GetVoiceLength("story_v_out_321231", "321231054", "story_v_out_321231.awb") / 1000

					if var_233_8 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_8 + var_233_0
					end

					if var_233_3.prefab_name ~= "" and arg_230_1.actors_[var_233_3.prefab_name] ~= nil then
						local var_233_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_3.prefab_name].transform, "story_v_out_321231", "321231054", "story_v_out_321231.awb")

						arg_230_1:RecordAudio("321231054", var_233_9)
						arg_230_1:RecordAudio("321231054", var_233_9)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_321231", "321231054", "story_v_out_321231.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_321231", "321231054", "story_v_out_321231.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_10 = math.max(var_233_1, arg_230_1.talkMaxDuration)

			if var_233_0 <= arg_230_1.time_ and arg_230_1.time_ < var_233_0 + var_233_10 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_0) / var_233_10

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_0 + var_233_10 and arg_230_1.time_ < var_233_0 + var_233_10 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L12f",
		"TextureConfig/Background/MS2107",
		"TextureConfig/Background/MS2107a",
		"TextureConfig/Background/Q01f"
	},
	voices = {
		"story_v_out_321231.awb"
	}
}
