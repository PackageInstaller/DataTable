return {
	Play114803001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114803001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play114803002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST01"

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
				local var_4_5 = arg_1_1.bgs_.ST01

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
					if iter_4_0 ~= "ST01" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.ST01
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueST01 = var_4_18.color.a
					arg_1_1.var_.alphaMatValueST01 = var_4_18
				end

				arg_1_1.var_.alphaOldValueST01 = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueST01, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueST01 then
					local var_4_22 = arg_1_1.var_.alphaMatValueST01.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueST01.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueST01 then
				local var_4_23 = arg_1_1.var_.alphaMatValueST01
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0
			local var_4_26 = 1

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_27 = "play"
				local var_4_28 = "music"

				arg_1_1:AudioAction(var_4_27, var_4_28, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_29 = ""
				local var_4_30 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_30 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_30 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_30

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_30
						arg_1_1.bgmTxt2_.text = var_4_30
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

			local var_4_31 = 2
			local var_4_32 = 3

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				local var_4_33 = "play"
				local var_4_34 = "music"

				arg_1_1:AudioAction(var_4_33, var_4_34, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_35 = ""
				local var_4_36 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if var_4_36 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_36 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_36

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_36
						arg_1_1.bgmTxt2_.text = var_4_36
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

			local var_4_37 = 2
			local var_4_38 = 0.775

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_39 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_39:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_40 = arg_1_1:GetWordFromCfg(114803001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 31
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_38 or var_4_38 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_38 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_37 = var_4_37 + 0.3

					if var_4_44 + var_4_37 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_37
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_37 + 0.3
			local var_4_46 = math.max(var_4_38, arg_1_1.talkMaxDuration)

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
	Play114803002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114803002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play114803003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1

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

				local var_12_2 = arg_9_1:GetWordFromCfg(114803002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 40
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
	Play114803003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114803003
		arg_13_1.duration_ = 6.17

		local var_13_0 = {
			ja = 5.966,
			ko = 6.166,
			zh = 5.9,
			en = 6
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
				arg_13_0:Play114803004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1148ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["1148ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1148ui_story = var_16_5.localPosition

				local var_16_7 = "1148ui_story"

				arg_13_1:ShowWeapon(arg_13_1.var_[var_16_7 .. "Animator"].transform, false)
			end

			local var_16_8 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_6) / var_16_8
				local var_16_10 = Vector3.New(0, -0.8, -6.2)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1148ui_story, var_16_10, var_16_9)

				local var_16_11 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_11.x, var_16_11.y, var_16_11.z)

				local var_16_12 = var_16_5.localEulerAngles

				var_16_12.z = 0
				var_16_12.x = 0
				var_16_5.localEulerAngles = var_16_12
			end

			if arg_13_1.time_ >= var_16_6 + var_16_8 and arg_13_1.time_ < var_16_6 + var_16_8 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_16_13 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_13.x, var_16_13.y, var_16_13.z)

				local var_16_14 = var_16_5.localEulerAngles

				var_16_14.z = 0
				var_16_14.x = 0
				var_16_5.localEulerAngles = var_16_14
			end

			local var_16_15 = arg_13_1.actors_["1148ui_story"]
			local var_16_16 = 0.0166666666666667

			if var_16_16 < arg_13_1.time_ and arg_13_1.time_ <= var_16_16 + arg_16_0 and not isNil(var_16_15) and arg_13_1.var_.characterEffect1148ui_story == nil then
				arg_13_1.var_.characterEffect1148ui_story = var_16_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_17 = 0.2

			if var_16_16 <= arg_13_1.time_ and arg_13_1.time_ < var_16_16 + var_16_17 and not isNil(var_16_15) then
				local var_16_18 = (arg_13_1.time_ - var_16_16) / var_16_17

				if arg_13_1.var_.characterEffect1148ui_story and not isNil(var_16_15) then
					arg_13_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_16 + var_16_17 and arg_13_1.time_ < var_16_16 + var_16_17 + arg_16_0 and not isNil(var_16_15) and arg_13_1.var_.characterEffect1148ui_story then
				arg_13_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_16_19 = 0.0166666666666667

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_16_20 = 0.0166666666666667

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_16_21 = 0
			local var_16_22 = 0.625

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_23 = arg_13_1:FormatText(StoryNameCfg[8].name)

				arg_13_1.leftNameTxt_.text = var_16_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_24 = arg_13_1:GetWordFromCfg(114803003)
				local var_16_25 = arg_13_1:FormatText(var_16_24.content)

				arg_13_1.text_.text = var_16_25

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_26 = 25
				local var_16_27 = utf8.len(var_16_25)
				local var_16_28 = var_16_26 <= 0 and var_16_22 or var_16_22 * (var_16_27 / var_16_26)

				if var_16_28 > 0 and var_16_22 < var_16_28 then
					arg_13_1.talkMaxDuration = var_16_28

					if var_16_28 + var_16_21 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_21
					end
				end

				arg_13_1.text_.text = var_16_25
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803003", "story_v_side_old_114803.awb") ~= 0 then
					local var_16_29 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803003", "story_v_side_old_114803.awb") / 1000

					if var_16_29 + var_16_21 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_29 + var_16_21
					end

					if var_16_24.prefab_name ~= "" and arg_13_1.actors_[var_16_24.prefab_name] ~= nil then
						local var_16_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_24.prefab_name].transform, "story_v_side_old_114803", "114803003", "story_v_side_old_114803.awb")

						arg_13_1:RecordAudio("114803003", var_16_30)
						arg_13_1:RecordAudio("114803003", var_16_30)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803003", "story_v_side_old_114803.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803003", "story_v_side_old_114803.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_31 = math.max(var_16_22, arg_13_1.talkMaxDuration)

			if var_16_21 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_31 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_21) / var_16_31

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_21 + var_16_31 and arg_13_1.time_ < var_16_21 + var_16_31 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play114803004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114803004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play114803005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1148ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1148ui_story == nil then
				arg_17_1.var_.characterEffect1148ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1148ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1148ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1148ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1148ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_20_7 = 0
			local var_20_8 = 0.2

			if var_20_7 < arg_17_1.time_ and arg_17_1.time_ <= var_20_7 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_9 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_10 = arg_17_1:GetWordFromCfg(114803004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_12 = 8
				local var_20_13 = utf8.len(var_20_11)
				local var_20_14 = var_20_12 <= 0 and var_20_8 or var_20_8 * (var_20_13 / var_20_12)

				if var_20_14 > 0 and var_20_8 < var_20_14 then
					arg_17_1.talkMaxDuration = var_20_14

					if var_20_14 + var_20_7 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_7
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_15 = math.max(var_20_8, arg_17_1.talkMaxDuration)

			if var_20_7 <= arg_17_1.time_ and arg_17_1.time_ < var_20_7 + var_20_15 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_7) / var_20_15

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_7 + var_20_15 and arg_17_1.time_ < var_20_7 + var_20_15 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play114803005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114803005
		arg_21_1.duration_ = 6.6

		local var_21_0 = {
			ja = 6.6,
			ko = 6.333,
			zh = 4.033,
			en = 6.2
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
				arg_21_0:Play114803006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1148ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1148ui_story == nil then
				arg_21_1.var_.characterEffect1148ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1148ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1148ui_story then
				arg_21_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_24_4 = 0

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action434")
			end

			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_24_6 = 0
			local var_24_7 = 0.525

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[8].name)

				arg_21_1.leftNameTxt_.text = var_24_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_9 = arg_21_1:GetWordFromCfg(114803005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 21
				local var_24_12 = utf8.len(var_24_10)
				local var_24_13 = var_24_11 <= 0 and var_24_7 or var_24_7 * (var_24_12 / var_24_11)

				if var_24_13 > 0 and var_24_7 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_10
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803005", "story_v_side_old_114803.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803005", "story_v_side_old_114803.awb") / 1000

					if var_24_14 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_6
					end

					if var_24_9.prefab_name ~= "" and arg_21_1.actors_[var_24_9.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_9.prefab_name].transform, "story_v_side_old_114803", "114803005", "story_v_side_old_114803.awb")

						arg_21_1:RecordAudio("114803005", var_24_15)
						arg_21_1:RecordAudio("114803005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803005", "story_v_side_old_114803.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803005", "story_v_side_old_114803.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_16 and arg_21_1.time_ < var_24_6 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play114803006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114803006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play114803007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1148ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1148ui_story == nil then
				arg_25_1.var_.characterEffect1148ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1148ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1148ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1148ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1148ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_28_7 = 0
			local var_28_8 = 0.55

			if var_28_7 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_9 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_10 = arg_25_1:GetWordFromCfg(114803006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_12 = 22
				local var_28_13 = utf8.len(var_28_11)
				local var_28_14 = var_28_12 <= 0 and var_28_8 or var_28_8 * (var_28_13 / var_28_12)

				if var_28_14 > 0 and var_28_8 < var_28_14 then
					arg_25_1.talkMaxDuration = var_28_14

					if var_28_14 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_7
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_15 = math.max(var_28_8, arg_25_1.talkMaxDuration)

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_15 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_7) / var_28_15

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_7 + var_28_15 and arg_25_1.time_ < var_28_7 + var_28_15 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play114803007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114803007
		arg_29_1.duration_ = 7.9

		local var_29_0 = {
			ja = 7.9,
			ko = 6.966,
			zh = 5.5,
			en = 7.4
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
				arg_29_0:Play114803008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1148ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1148ui_story == nil then
				arg_29_1.var_.characterEffect1148ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1148ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1148ui_story then
				arg_29_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_32_4 = 0

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action445")
			end

			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_32_6 = 0
			local var_32_7 = 0.7

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_8 = arg_29_1:FormatText(StoryNameCfg[8].name)

				arg_29_1.leftNameTxt_.text = var_32_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_9 = arg_29_1:GetWordFromCfg(114803007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 28
				local var_32_12 = utf8.len(var_32_10)
				local var_32_13 = var_32_11 <= 0 and var_32_7 or var_32_7 * (var_32_12 / var_32_11)

				if var_32_13 > 0 and var_32_7 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803007", "story_v_side_old_114803.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803007", "story_v_side_old_114803.awb") / 1000

					if var_32_14 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_6
					end

					if var_32_9.prefab_name ~= "" and arg_29_1.actors_[var_32_9.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_9.prefab_name].transform, "story_v_side_old_114803", "114803007", "story_v_side_old_114803.awb")

						arg_29_1:RecordAudio("114803007", var_32_15)
						arg_29_1:RecordAudio("114803007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803007", "story_v_side_old_114803.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803007", "story_v_side_old_114803.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_16 and arg_29_1.time_ < var_32_6 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play114803008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114803008
		arg_33_1.duration_ = 9.77

		local var_33_0 = {
			ja = 5.6,
			ko = 9.266,
			zh = 7.133,
			en = 9.766
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
				arg_33_0:Play114803009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action454")
			end

			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_36_2 = 0
			local var_36_3 = 0.775

			if var_36_2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_4 = arg_33_1:FormatText(StoryNameCfg[8].name)

				arg_33_1.leftNameTxt_.text = var_36_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_5 = arg_33_1:GetWordFromCfg(114803008)
				local var_36_6 = arg_33_1:FormatText(var_36_5.content)

				arg_33_1.text_.text = var_36_6

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 31
				local var_36_8 = utf8.len(var_36_6)
				local var_36_9 = var_36_7 <= 0 and var_36_3 or var_36_3 * (var_36_8 / var_36_7)

				if var_36_9 > 0 and var_36_3 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_6
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803008", "story_v_side_old_114803.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803008", "story_v_side_old_114803.awb") / 1000

					if var_36_10 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_2
					end

					if var_36_5.prefab_name ~= "" and arg_33_1.actors_[var_36_5.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_5.prefab_name].transform, "story_v_side_old_114803", "114803008", "story_v_side_old_114803.awb")

						arg_33_1:RecordAudio("114803008", var_36_11)
						arg_33_1:RecordAudio("114803008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803008", "story_v_side_old_114803.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803008", "story_v_side_old_114803.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_12 and arg_33_1.time_ < var_36_2 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play114803009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114803009
		arg_37_1.duration_ = 10.57

		local var_37_0 = {
			ja = 10.566,
			ko = 7.133,
			zh = 6.766,
			en = 7.533
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play114803010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action445")
			end

			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_40_2 = 0
			local var_40_3 = 0.825

			if var_40_2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_4 = arg_37_1:FormatText(StoryNameCfg[8].name)

				arg_37_1.leftNameTxt_.text = var_40_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_5 = arg_37_1:GetWordFromCfg(114803009)
				local var_40_6 = arg_37_1:FormatText(var_40_5.content)

				arg_37_1.text_.text = var_40_6

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 33
				local var_40_8 = utf8.len(var_40_6)
				local var_40_9 = var_40_7 <= 0 and var_40_3 or var_40_3 * (var_40_8 / var_40_7)

				if var_40_9 > 0 and var_40_3 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_6
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803009", "story_v_side_old_114803.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803009", "story_v_side_old_114803.awb") / 1000

					if var_40_10 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_2
					end

					if var_40_5.prefab_name ~= "" and arg_37_1.actors_[var_40_5.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_5.prefab_name].transform, "story_v_side_old_114803", "114803009", "story_v_side_old_114803.awb")

						arg_37_1:RecordAudio("114803009", var_40_11)
						arg_37_1:RecordAudio("114803009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803009", "story_v_side_old_114803.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803009", "story_v_side_old_114803.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_12 and arg_37_1.time_ < var_40_2 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play114803010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114803010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play114803011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1148ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1148ui_story == nil then
				arg_41_1.var_.characterEffect1148ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1148ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1148ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1148ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1148ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.275

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

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(114803010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 11
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
	Play114803011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114803011
		arg_45_1.duration_ = 11.03

		local var_45_0 = {
			ja = 11.033,
			ko = 5.766,
			zh = 4.766,
			en = 5.9
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
				arg_45_0:Play114803012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1148ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1148ui_story == nil then
				arg_45_1.var_.characterEffect1148ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1148ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1148ui_story then
				arg_45_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_48_4 = 0

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action457")
			end

			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_48_6 = 0
			local var_48_7 = 0.6

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[8].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_9 = arg_45_1:GetWordFromCfg(114803011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 24
				local var_48_12 = utf8.len(var_48_10)
				local var_48_13 = var_48_11 <= 0 and var_48_7 or var_48_7 * (var_48_12 / var_48_11)

				if var_48_13 > 0 and var_48_7 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_10
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803011", "story_v_side_old_114803.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803011", "story_v_side_old_114803.awb") / 1000

					if var_48_14 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_6
					end

					if var_48_9.prefab_name ~= "" and arg_45_1.actors_[var_48_9.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_9.prefab_name].transform, "story_v_side_old_114803", "114803011", "story_v_side_old_114803.awb")

						arg_45_1:RecordAudio("114803011", var_48_15)
						arg_45_1:RecordAudio("114803011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803011", "story_v_side_old_114803.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803011", "story_v_side_old_114803.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_16 and arg_45_1.time_ < var_48_6 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play114803012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114803012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play114803013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1148ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1148ui_story == nil then
				arg_49_1.var_.characterEffect1148ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1148ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1148ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1148ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1148ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_52_7 = 0
			local var_52_8 = 0.05

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_9 = arg_49_1:FormatText(StoryNameCfg[7].name)

				arg_49_1.leftNameTxt_.text = var_52_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_10 = arg_49_1:GetWordFromCfg(114803012)
				local var_52_11 = arg_49_1:FormatText(var_52_10.content)

				arg_49_1.text_.text = var_52_11

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_12 = 2
				local var_52_13 = utf8.len(var_52_11)
				local var_52_14 = var_52_12 <= 0 and var_52_8 or var_52_8 * (var_52_13 / var_52_12)

				if var_52_14 > 0 and var_52_8 < var_52_14 then
					arg_49_1.talkMaxDuration = var_52_14

					if var_52_14 + var_52_7 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_7
					end
				end

				arg_49_1.text_.text = var_52_11
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_15 = math.max(var_52_8, arg_49_1.talkMaxDuration)

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_15 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_7) / var_52_15

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_7 + var_52_15 and arg_49_1.time_ < var_52_7 + var_52_15 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play114803013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114803013
		arg_53_1.duration_ = 4.63

		local var_53_0 = {
			ja = 4.633,
			ko = 2.633,
			zh = 2.7,
			en = 2.9
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
				arg_53_0:Play114803014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1148ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1148ui_story == nil then
				arg_53_1.var_.characterEffect1148ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1148ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1148ui_story then
				arg_53_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_56_4 = 0

			if var_56_4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action473")
			end

			local var_56_5 = 0

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_56_6 = 0
			local var_56_7 = 0.275

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_8 = arg_53_1:FormatText(StoryNameCfg[8].name)

				arg_53_1.leftNameTxt_.text = var_56_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_9 = arg_53_1:GetWordFromCfg(114803013)
				local var_56_10 = arg_53_1:FormatText(var_56_9.content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 11
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

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803013", "story_v_side_old_114803.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803013", "story_v_side_old_114803.awb") / 1000

					if var_56_14 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_6
					end

					if var_56_9.prefab_name ~= "" and arg_53_1.actors_[var_56_9.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_9.prefab_name].transform, "story_v_side_old_114803", "114803013", "story_v_side_old_114803.awb")

						arg_53_1:RecordAudio("114803013", var_56_15)
						arg_53_1:RecordAudio("114803013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803013", "story_v_side_old_114803.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803013", "story_v_side_old_114803.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_16 and arg_53_1.time_ < var_56_6 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play114803014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114803014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play114803015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1148ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1148ui_story == nil then
				arg_57_1.var_.characterEffect1148ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1148ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1148ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1148ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1148ui_story.fillRatio = var_60_5
			end

			local var_60_6 = 0

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_60_7 = 0
			local var_60_8 = 0.225

			if var_60_7 < arg_57_1.time_ and arg_57_1.time_ <= var_60_7 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_9 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_9

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

				local var_60_10 = arg_57_1:GetWordFromCfg(114803014)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_12 = 9
				local var_60_13 = utf8.len(var_60_11)
				local var_60_14 = var_60_12 <= 0 and var_60_8 or var_60_8 * (var_60_13 / var_60_12)

				if var_60_14 > 0 and var_60_8 < var_60_14 then
					arg_57_1.talkMaxDuration = var_60_14

					if var_60_14 + var_60_7 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_7
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_15 = math.max(var_60_8, arg_57_1.talkMaxDuration)

			if var_60_7 <= arg_57_1.time_ and arg_57_1.time_ < var_60_7 + var_60_15 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_7) / var_60_15

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_7 + var_60_15 and arg_57_1.time_ < var_60_7 + var_60_15 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play114803015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114803015
		arg_61_1.duration_ = 9.63

		local var_61_0 = {
			ja = 9.633,
			ko = 4.6,
			zh = 3.4,
			en = 3.9
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
				arg_61_0:Play114803016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1148ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1148ui_story == nil then
				arg_61_1.var_.characterEffect1148ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1148ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1148ui_story then
				arg_61_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_64_4 = 0

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action434")
			end

			local var_64_5 = 0

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_64_6 = 0
			local var_64_7 = 0.375

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_8 = arg_61_1:FormatText(StoryNameCfg[8].name)

				arg_61_1.leftNameTxt_.text = var_64_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_9 = arg_61_1:GetWordFromCfg(114803015)
				local var_64_10 = arg_61_1:FormatText(var_64_9.content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 15
				local var_64_12 = utf8.len(var_64_10)
				local var_64_13 = var_64_11 <= 0 and var_64_7 or var_64_7 * (var_64_12 / var_64_11)

				if var_64_13 > 0 and var_64_7 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_10
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803015", "story_v_side_old_114803.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803015", "story_v_side_old_114803.awb") / 1000

					if var_64_14 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_6
					end

					if var_64_9.prefab_name ~= "" and arg_61_1.actors_[var_64_9.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_9.prefab_name].transform, "story_v_side_old_114803", "114803015", "story_v_side_old_114803.awb")

						arg_61_1:RecordAudio("114803015", var_64_15)
						arg_61_1:RecordAudio("114803015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803015", "story_v_side_old_114803.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803015", "story_v_side_old_114803.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_16 and arg_61_1.time_ < var_64_6 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play114803016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114803016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play114803017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_68_1 = 0
			local var_68_2 = 0.45

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(114803016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 18
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_2 or var_68_2 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_2 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_8 and arg_65_1.time_ < var_68_1 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play114803017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114803017
		arg_69_1.duration_ = 8.5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play114803018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = "D02a"

			if arg_69_1.bgs_[var_72_0] == nil then
				local var_72_1 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_72_0)
				var_72_1.name = var_72_0
				var_72_1.transform.parent = arg_69_1.stage_.transform
				var_72_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_[var_72_0] = var_72_1
			end

			local var_72_2 = 1.5

			if var_72_2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				local var_72_3 = manager.ui.mainCamera.transform.localPosition
				local var_72_4 = Vector3.New(0, 0, 10) + Vector3.New(var_72_3.x, var_72_3.y, 0)
				local var_72_5 = arg_69_1.bgs_.D02a

				var_72_5.transform.localPosition = var_72_4
				var_72_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_6 = var_72_5:GetComponent("SpriteRenderer")

				if var_72_6 and var_72_6.sprite then
					local var_72_7 = (var_72_5.transform.localPosition - var_72_3).z
					local var_72_8 = manager.ui.mainCameraCom_
					local var_72_9 = 2 * var_72_7 * Mathf.Tan(var_72_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_72_10 = var_72_9 * var_72_8.aspect
					local var_72_11 = var_72_6.sprite.bounds.size.x
					local var_72_12 = var_72_6.sprite.bounds.size.y
					local var_72_13 = var_72_10 / var_72_11
					local var_72_14 = var_72_9 / var_72_12
					local var_72_15 = var_72_14 < var_72_13 and var_72_13 or var_72_14

					var_72_5.transform.localScale = Vector3.New(var_72_15, var_72_15, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "D02a" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_16 = arg_69_1.actors_["1148ui_story"].transform
			local var_72_17 = 0

			if var_72_17 < arg_69_1.time_ and arg_69_1.time_ <= var_72_17 + arg_72_0 then
				arg_69_1.var_.moveOldPos1148ui_story = var_72_16.localPosition
			end

			local var_72_18 = 0.001

			if var_72_17 <= arg_69_1.time_ and arg_69_1.time_ < var_72_17 + var_72_18 then
				local var_72_19 = (arg_69_1.time_ - var_72_17) / var_72_18
				local var_72_20 = Vector3.New(0, 100, 0)

				var_72_16.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1148ui_story, var_72_20, var_72_19)

				local var_72_21 = manager.ui.mainCamera.transform.position - var_72_16.position

				var_72_16.forward = Vector3.New(var_72_21.x, var_72_21.y, var_72_21.z)

				local var_72_22 = var_72_16.localEulerAngles

				var_72_22.z = 0
				var_72_22.x = 0
				var_72_16.localEulerAngles = var_72_22
			end

			if arg_69_1.time_ >= var_72_17 + var_72_18 and arg_69_1.time_ < var_72_17 + var_72_18 + arg_72_0 then
				var_72_16.localPosition = Vector3.New(0, 100, 0)

				local var_72_23 = manager.ui.mainCamera.transform.position - var_72_16.position

				var_72_16.forward = Vector3.New(var_72_23.x, var_72_23.y, var_72_23.z)

				local var_72_24 = var_72_16.localEulerAngles

				var_72_24.z = 0
				var_72_24.x = 0
				var_72_16.localEulerAngles = var_72_24
			end

			local var_72_25 = arg_69_1.bgs_.ST01
			local var_72_26 = 0

			if var_72_26 < arg_69_1.time_ and arg_69_1.time_ <= var_72_26 + arg_72_0 then
				local var_72_27 = var_72_25:GetComponent("SpriteRenderer")

				if var_72_27 then
					arg_69_1.var_.alphaOldValueST01 = var_72_27.color.a
					arg_69_1.var_.alphaMatValueST01 = var_72_27
				end

				arg_69_1.var_.alphaOldValueST01 = 1
			end

			local var_72_28 = 1.5

			if var_72_26 <= arg_69_1.time_ and arg_69_1.time_ < var_72_26 + var_72_28 then
				local var_72_29 = (arg_69_1.time_ - var_72_26) / var_72_28
				local var_72_30 = Mathf.Lerp(arg_69_1.var_.alphaOldValueST01, 0, var_72_29)

				if arg_69_1.var_.alphaMatValueST01 then
					local var_72_31 = arg_69_1.var_.alphaMatValueST01.color

					var_72_31.a = var_72_30
					arg_69_1.var_.alphaMatValueST01.color = var_72_31
				end
			end

			if arg_69_1.time_ >= var_72_26 + var_72_28 and arg_69_1.time_ < var_72_26 + var_72_28 + arg_72_0 and arg_69_1.var_.alphaMatValueST01 then
				local var_72_32 = arg_69_1.var_.alphaMatValueST01
				local var_72_33 = var_72_32.color

				var_72_33.a = 0
				var_72_32.color = var_72_33
			end

			local var_72_34 = arg_69_1.bgs_.D02a
			local var_72_35 = 1.5

			if var_72_35 < arg_69_1.time_ and arg_69_1.time_ <= var_72_35 + arg_72_0 then
				local var_72_36 = var_72_34:GetComponent("SpriteRenderer")

				if var_72_36 then
					arg_69_1.var_.alphaOldValueD02a = var_72_36.color.a
					arg_69_1.var_.alphaMatValueD02a = var_72_36
				end

				arg_69_1.var_.alphaOldValueD02a = 0
			end

			local var_72_37 = 1.5

			if var_72_35 <= arg_69_1.time_ and arg_69_1.time_ < var_72_35 + var_72_37 then
				local var_72_38 = (arg_69_1.time_ - var_72_35) / var_72_37
				local var_72_39 = Mathf.Lerp(arg_69_1.var_.alphaOldValueD02a, 1, var_72_38)

				if arg_69_1.var_.alphaMatValueD02a then
					local var_72_40 = arg_69_1.var_.alphaMatValueD02a.color

					var_72_40.a = var_72_39
					arg_69_1.var_.alphaMatValueD02a.color = var_72_40
				end
			end

			if arg_69_1.time_ >= var_72_35 + var_72_37 and arg_69_1.time_ < var_72_35 + var_72_37 + arg_72_0 and arg_69_1.var_.alphaMatValueD02a then
				local var_72_41 = arg_69_1.var_.alphaMatValueD02a
				local var_72_42 = var_72_41.color

				var_72_42.a = 1
				var_72_41.color = var_72_42
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_43 = 3.5
			local var_72_44 = 1.65

			if var_72_43 < arg_69_1.time_ and arg_69_1.time_ <= var_72_43 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_45 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_45:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_46 = arg_69_1:GetWordFromCfg(114803017)
				local var_72_47 = arg_69_1:FormatText(var_72_46.content)

				arg_69_1.text_.text = var_72_47

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_48 = 66
				local var_72_49 = utf8.len(var_72_47)
				local var_72_50 = var_72_48 <= 0 and var_72_44 or var_72_44 * (var_72_49 / var_72_48)

				if var_72_50 > 0 and var_72_44 < var_72_50 then
					arg_69_1.talkMaxDuration = var_72_50
					var_72_43 = var_72_43 + 0.3

					if var_72_50 + var_72_43 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_50 + var_72_43
					end
				end

				arg_69_1.text_.text = var_72_47
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_51 = var_72_43 + 0.3
			local var_72_52 = math.max(var_72_44, arg_69_1.talkMaxDuration)

			if var_72_51 <= arg_69_1.time_ and arg_69_1.time_ < var_72_51 + var_72_52 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_51) / var_72_52

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_51 + var_72_52 and arg_69_1.time_ < var_72_51 + var_72_52 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play114803018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 114803018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play114803019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = "1080ui_story"

			if arg_75_1.actors_[var_78_0] == nil then
				local var_78_1 = Asset.Load("Char/" .. "1080ui_story")

				if not isNil(var_78_1) then
					local var_78_2 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_75_1.stage_.transform)

					var_78_2.name = var_78_0
					var_78_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_75_1.actors_[var_78_0] = var_78_2

					local var_78_3 = var_78_2:GetComponentInChildren(typeof(CharacterEffect))

					var_78_3.enabled = true

					local var_78_4 = GameObjectTools.GetOrAddComponent(var_78_2, typeof(DynamicBoneHelper))

					if var_78_4 then
						var_78_4:EnableDynamicBone(false)
					end

					arg_75_1:ShowWeapon(var_78_3.transform, false)

					arg_75_1.var_[var_78_0 .. "Animator"] = var_78_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_75_1.var_[var_78_0 .. "Animator"].applyRootMotion = true
					arg_75_1.var_[var_78_0 .. "LipSync"] = var_78_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_78_5 = arg_75_1.actors_["1080ui_story"].transform
			local var_78_6 = 0

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.var_.moveOldPos1080ui_story = var_78_5.localPosition

				local var_78_7 = "1080ui_story"

				arg_75_1:ShowWeapon(arg_75_1.var_[var_78_7 .. "Animator"].transform, false)
			end

			local var_78_8 = 0.001

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_8 then
				local var_78_9 = (arg_75_1.time_ - var_78_6) / var_78_8
				local var_78_10 = Vector3.New(0, -1.01, -6.05)

				var_78_5.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1080ui_story, var_78_10, var_78_9)

				local var_78_11 = manager.ui.mainCamera.transform.position - var_78_5.position

				var_78_5.forward = Vector3.New(var_78_11.x, var_78_11.y, var_78_11.z)

				local var_78_12 = var_78_5.localEulerAngles

				var_78_12.z = 0
				var_78_12.x = 0
				var_78_5.localEulerAngles = var_78_12
			end

			if arg_75_1.time_ >= var_78_6 + var_78_8 and arg_75_1.time_ < var_78_6 + var_78_8 + arg_78_0 then
				var_78_5.localPosition = Vector3.New(0, -1.01, -6.05)

				local var_78_13 = manager.ui.mainCamera.transform.position - var_78_5.position

				var_78_5.forward = Vector3.New(var_78_13.x, var_78_13.y, var_78_13.z)

				local var_78_14 = var_78_5.localEulerAngles

				var_78_14.z = 0
				var_78_14.x = 0
				var_78_5.localEulerAngles = var_78_14
			end

			local var_78_15 = 0
			local var_78_16 = 1.375

			if var_78_15 < arg_75_1.time_ and arg_75_1.time_ <= var_78_15 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_17 = arg_75_1:GetWordFromCfg(114803018)
				local var_78_18 = arg_75_1:FormatText(var_78_17.content)

				arg_75_1.text_.text = var_78_18

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_19 = 55
				local var_78_20 = utf8.len(var_78_18)
				local var_78_21 = var_78_19 <= 0 and var_78_16 or var_78_16 * (var_78_20 / var_78_19)

				if var_78_21 > 0 and var_78_16 < var_78_21 then
					arg_75_1.talkMaxDuration = var_78_21

					if var_78_21 + var_78_15 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_21 + var_78_15
					end
				end

				arg_75_1.text_.text = var_78_18
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_22 = math.max(var_78_16, arg_75_1.talkMaxDuration)

			if var_78_15 <= arg_75_1.time_ and arg_75_1.time_ < var_78_15 + var_78_22 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_15) / var_78_22

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_15 + var_78_22 and arg_75_1.time_ < var_78_15 + var_78_22 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play114803019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 114803019
		arg_79_1.duration_ = 7.43

		local var_79_0 = {
			ja = 7.433,
			ko = 6.2,
			zh = 6.566,
			en = 7
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play114803020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1080ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1080ui_story == nil then
				arg_79_1.var_.characterEffect1080ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.2

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect1080ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1080ui_story then
				arg_79_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_82_4 = 0

			if var_82_4 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			local var_82_5 = 0

			if var_82_5 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_82_6 = 0
			local var_82_7 = 0.55

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_8 = arg_79_1:FormatText(StoryNameCfg[55].name)

				arg_79_1.leftNameTxt_.text = var_82_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_9 = arg_79_1:GetWordFromCfg(114803019)
				local var_82_10 = arg_79_1:FormatText(var_82_9.content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_11 = 22
				local var_82_12 = utf8.len(var_82_10)
				local var_82_13 = var_82_11 <= 0 and var_82_7 or var_82_7 * (var_82_12 / var_82_11)

				if var_82_13 > 0 and var_82_7 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_6
					end
				end

				arg_79_1.text_.text = var_82_10
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803019", "story_v_side_old_114803.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803019", "story_v_side_old_114803.awb") / 1000

					if var_82_14 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_6
					end

					if var_82_9.prefab_name ~= "" and arg_79_1.actors_[var_82_9.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_9.prefab_name].transform, "story_v_side_old_114803", "114803019", "story_v_side_old_114803.awb")

						arg_79_1:RecordAudio("114803019", var_82_15)
						arg_79_1:RecordAudio("114803019", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803019", "story_v_side_old_114803.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803019", "story_v_side_old_114803.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_16 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_16 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_16

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_16 and arg_79_1.time_ < var_82_6 + var_82_16 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play114803020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 114803020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play114803021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1080ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1080ui_story == nil then
				arg_83_1.var_.characterEffect1080ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.2

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect1080ui_story and not isNil(var_86_0) then
					local var_86_4 = Mathf.Lerp(0, 0.5, var_86_3)

					arg_83_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1080ui_story.fillRatio = var_86_4
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1080ui_story then
				local var_86_5 = 0.5

				arg_83_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1080ui_story.fillRatio = var_86_5
			end

			local var_86_6 = 0
			local var_86_7 = 0.2

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_8 = arg_83_1:FormatText(StoryNameCfg[7].name)

				arg_83_1.leftNameTxt_.text = var_86_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_9 = arg_83_1:GetWordFromCfg(114803020)
				local var_86_10 = arg_83_1:FormatText(var_86_9.content)

				arg_83_1.text_.text = var_86_10

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_11 = 8
				local var_86_12 = utf8.len(var_86_10)
				local var_86_13 = var_86_11 <= 0 and var_86_7 or var_86_7 * (var_86_12 / var_86_11)

				if var_86_13 > 0 and var_86_7 < var_86_13 then
					arg_83_1.talkMaxDuration = var_86_13

					if var_86_13 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_13 + var_86_6
					end
				end

				arg_83_1.text_.text = var_86_10
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_14 = math.max(var_86_7, arg_83_1.talkMaxDuration)

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_14 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_6) / var_86_14

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_6 + var_86_14 and arg_83_1.time_ < var_86_6 + var_86_14 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play114803021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 114803021
		arg_87_1.duration_ = 12.03

		local var_87_0 = {
			ja = 12.033,
			ko = 10.3,
			zh = 10.466,
			en = 8.833
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play114803022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1080ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1080ui_story = var_90_0.localPosition

				local var_90_2 = "1080ui_story"

				arg_87_1:ShowWeapon(arg_87_1.var_[var_90_2 .. "Animator"].transform, false)
			end

			local var_90_3 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_3 then
				local var_90_4 = (arg_87_1.time_ - var_90_1) / var_90_3
				local var_90_5 = Vector3.New(0.7, -1.01, -6.05)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1080ui_story, var_90_5, var_90_4)

				local var_90_6 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_6.x, var_90_6.y, var_90_6.z)

				local var_90_7 = var_90_0.localEulerAngles

				var_90_7.z = 0
				var_90_7.x = 0
				var_90_0.localEulerAngles = var_90_7
			end

			if arg_87_1.time_ >= var_90_1 + var_90_3 and arg_87_1.time_ < var_90_1 + var_90_3 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0.7, -1.01, -6.05)

				local var_90_8 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_8.x, var_90_8.y, var_90_8.z)

				local var_90_9 = var_90_0.localEulerAngles

				var_90_9.z = 0
				var_90_9.x = 0
				var_90_0.localEulerAngles = var_90_9
			end

			local var_90_10 = arg_87_1.actors_["1148ui_story"].transform
			local var_90_11 = 0

			if var_90_11 < arg_87_1.time_ and arg_87_1.time_ <= var_90_11 + arg_90_0 then
				arg_87_1.var_.moveOldPos1148ui_story = var_90_10.localPosition

				local var_90_12 = "1148ui_story"

				arg_87_1:ShowWeapon(arg_87_1.var_[var_90_12 .. "Animator"].transform, false)
			end

			local var_90_13 = 0.001

			if var_90_11 <= arg_87_1.time_ and arg_87_1.time_ < var_90_11 + var_90_13 then
				local var_90_14 = (arg_87_1.time_ - var_90_11) / var_90_13
				local var_90_15 = Vector3.New(-0.7, -0.8, -6.2)

				var_90_10.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1148ui_story, var_90_15, var_90_14)

				local var_90_16 = manager.ui.mainCamera.transform.position - var_90_10.position

				var_90_10.forward = Vector3.New(var_90_16.x, var_90_16.y, var_90_16.z)

				local var_90_17 = var_90_10.localEulerAngles

				var_90_17.z = 0
				var_90_17.x = 0
				var_90_10.localEulerAngles = var_90_17
			end

			if arg_87_1.time_ >= var_90_11 + var_90_13 and arg_87_1.time_ < var_90_11 + var_90_13 + arg_90_0 then
				var_90_10.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_90_18 = manager.ui.mainCamera.transform.position - var_90_10.position

				var_90_10.forward = Vector3.New(var_90_18.x, var_90_18.y, var_90_18.z)

				local var_90_19 = var_90_10.localEulerAngles

				var_90_19.z = 0
				var_90_19.x = 0
				var_90_10.localEulerAngles = var_90_19
			end

			local var_90_20 = 0.0166666666666667

			if var_90_20 < arg_87_1.time_ and arg_87_1.time_ <= var_90_20 + arg_90_0 then
				arg_87_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_90_21 = arg_87_1.actors_["1148ui_story"]
			local var_90_22 = 0.0166666666666667

			if var_90_22 < arg_87_1.time_ and arg_87_1.time_ <= var_90_22 + arg_90_0 and not isNil(var_90_21) and arg_87_1.var_.characterEffect1148ui_story == nil then
				arg_87_1.var_.characterEffect1148ui_story = var_90_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_23 = 0.2

			if var_90_22 <= arg_87_1.time_ and arg_87_1.time_ < var_90_22 + var_90_23 and not isNil(var_90_21) then
				local var_90_24 = (arg_87_1.time_ - var_90_22) / var_90_23

				if arg_87_1.var_.characterEffect1148ui_story and not isNil(var_90_21) then
					arg_87_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_22 + var_90_23 and arg_87_1.time_ < var_90_22 + var_90_23 + arg_90_0 and not isNil(var_90_21) and arg_87_1.var_.characterEffect1148ui_story then
				arg_87_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_90_25 = arg_87_1.actors_["1080ui_story"]
			local var_90_26 = 0.0166666666666667

			if var_90_26 < arg_87_1.time_ and arg_87_1.time_ <= var_90_26 + arg_90_0 and not isNil(var_90_25) and arg_87_1.var_.characterEffect1080ui_story == nil then
				arg_87_1.var_.characterEffect1080ui_story = var_90_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_27 = 0.183333333333333

			if var_90_26 <= arg_87_1.time_ and arg_87_1.time_ < var_90_26 + var_90_27 and not isNil(var_90_25) then
				local var_90_28 = (arg_87_1.time_ - var_90_26) / var_90_27

				if arg_87_1.var_.characterEffect1080ui_story and not isNil(var_90_25) then
					local var_90_29 = Mathf.Lerp(0, 0.5, var_90_28)

					arg_87_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1080ui_story.fillRatio = var_90_29
				end
			end

			if arg_87_1.time_ >= var_90_26 + var_90_27 and arg_87_1.time_ < var_90_26 + var_90_27 + arg_90_0 and not isNil(var_90_25) and arg_87_1.var_.characterEffect1080ui_story then
				local var_90_30 = 0.5

				arg_87_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1080ui_story.fillRatio = var_90_30
			end

			local var_90_31 = 0.0166666666666667

			if var_90_31 < arg_87_1.time_ and arg_87_1.time_ <= var_90_31 + arg_90_0 then
				arg_87_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_90_32 = 0.0166666666666667

			if var_90_32 < arg_87_1.time_ and arg_87_1.time_ <= var_90_32 + arg_90_0 then
				arg_87_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_90_33 = 0
			local var_90_34 = 0.925

			if var_90_33 < arg_87_1.time_ and arg_87_1.time_ <= var_90_33 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_35 = arg_87_1:FormatText(StoryNameCfg[8].name)

				arg_87_1.leftNameTxt_.text = var_90_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_36 = arg_87_1:GetWordFromCfg(114803021)
				local var_90_37 = arg_87_1:FormatText(var_90_36.content)

				arg_87_1.text_.text = var_90_37

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_38 = 37
				local var_90_39 = utf8.len(var_90_37)
				local var_90_40 = var_90_38 <= 0 and var_90_34 or var_90_34 * (var_90_39 / var_90_38)

				if var_90_40 > 0 and var_90_34 < var_90_40 then
					arg_87_1.talkMaxDuration = var_90_40

					if var_90_40 + var_90_33 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_40 + var_90_33
					end
				end

				arg_87_1.text_.text = var_90_37
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803021", "story_v_side_old_114803.awb") ~= 0 then
					local var_90_41 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803021", "story_v_side_old_114803.awb") / 1000

					if var_90_41 + var_90_33 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_41 + var_90_33
					end

					if var_90_36.prefab_name ~= "" and arg_87_1.actors_[var_90_36.prefab_name] ~= nil then
						local var_90_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_36.prefab_name].transform, "story_v_side_old_114803", "114803021", "story_v_side_old_114803.awb")

						arg_87_1:RecordAudio("114803021", var_90_42)
						arg_87_1:RecordAudio("114803021", var_90_42)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803021", "story_v_side_old_114803.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803021", "story_v_side_old_114803.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_43 = math.max(var_90_34, arg_87_1.talkMaxDuration)

			if var_90_33 <= arg_87_1.time_ and arg_87_1.time_ < var_90_33 + var_90_43 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_33) / var_90_43

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_33 + var_90_43 and arg_87_1.time_ < var_90_33 + var_90_43 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play114803022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 114803022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play114803023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1148ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1148ui_story == nil then
				arg_91_1.var_.characterEffect1148ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.2

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect1148ui_story and not isNil(var_94_0) then
					local var_94_4 = Mathf.Lerp(0, 0.5, var_94_3)

					arg_91_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1148ui_story.fillRatio = var_94_4
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1148ui_story then
				local var_94_5 = 0.5

				arg_91_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1148ui_story.fillRatio = var_94_5
			end

			local var_94_6 = 0

			if var_94_6 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_94_7 = 0

			if var_94_7 < arg_91_1.time_ and arg_91_1.time_ <= var_94_7 + arg_94_0 then
				arg_91_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_94_8 = 0
			local var_94_9 = 1.4

			if var_94_8 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_10 = arg_91_1:GetWordFromCfg(114803022)
				local var_94_11 = arg_91_1:FormatText(var_94_10.content)

				arg_91_1.text_.text = var_94_11

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_12 = 56
				local var_94_13 = utf8.len(var_94_11)
				local var_94_14 = var_94_12 <= 0 and var_94_9 or var_94_9 * (var_94_13 / var_94_12)

				if var_94_14 > 0 and var_94_9 < var_94_14 then
					arg_91_1.talkMaxDuration = var_94_14

					if var_94_14 + var_94_8 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_14 + var_94_8
					end
				end

				arg_91_1.text_.text = var_94_11
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_15 = math.max(var_94_9, arg_91_1.talkMaxDuration)

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_15 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_8) / var_94_15

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_8 + var_94_15 and arg_91_1.time_ < var_94_8 + var_94_15 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play114803023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 114803023
		arg_95_1.duration_ = 13.27

		local var_95_0 = {
			ja = 13.266,
			ko = 10.066,
			zh = 9.533,
			en = 11.533
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
				arg_95_0:Play114803024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1148ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1148ui_story == nil then
				arg_95_1.var_.characterEffect1148ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.2

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1148ui_story and not isNil(var_98_0) then
					arg_95_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1148ui_story then
				arg_95_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_98_4 = 0

			if var_98_4 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_98_5 = 0

			if var_98_5 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_98_6 = 0
			local var_98_7 = 0.9

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_8 = arg_95_1:FormatText(StoryNameCfg[8].name)

				arg_95_1.leftNameTxt_.text = var_98_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_9 = arg_95_1:GetWordFromCfg(114803023)
				local var_98_10 = arg_95_1:FormatText(var_98_9.content)

				arg_95_1.text_.text = var_98_10

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 36
				local var_98_12 = utf8.len(var_98_10)
				local var_98_13 = var_98_11 <= 0 and var_98_7 or var_98_7 * (var_98_12 / var_98_11)

				if var_98_13 > 0 and var_98_7 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_10
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803023", "story_v_side_old_114803.awb") ~= 0 then
					local var_98_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803023", "story_v_side_old_114803.awb") / 1000

					if var_98_14 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_14 + var_98_6
					end

					if var_98_9.prefab_name ~= "" and arg_95_1.actors_[var_98_9.prefab_name] ~= nil then
						local var_98_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_9.prefab_name].transform, "story_v_side_old_114803", "114803023", "story_v_side_old_114803.awb")

						arg_95_1:RecordAudio("114803023", var_98_15)
						arg_95_1:RecordAudio("114803023", var_98_15)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803023", "story_v_side_old_114803.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803023", "story_v_side_old_114803.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_16 = math.max(var_98_7, arg_95_1.talkMaxDuration)

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_16 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_6) / var_98_16

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_6 + var_98_16 and arg_95_1.time_ < var_98_6 + var_98_16 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play114803024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 114803024
		arg_99_1.duration_ = 11.7

		local var_99_0 = {
			ja = 11.7,
			ko = 7.1,
			zh = 7.6,
			en = 8.466
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play114803025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action476")
			end

			local var_102_2 = 0

			if var_102_2 < arg_99_1.time_ and arg_99_1.time_ <= var_102_2 + arg_102_0 then
				arg_99_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_102_3 = 0
			local var_102_4 = 0.625

			if var_102_3 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_5 = arg_99_1:FormatText(StoryNameCfg[8].name)

				arg_99_1.leftNameTxt_.text = var_102_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_6 = arg_99_1:GetWordFromCfg(114803024)
				local var_102_7 = arg_99_1:FormatText(var_102_6.content)

				arg_99_1.text_.text = var_102_7

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_8 = 25
				local var_102_9 = utf8.len(var_102_7)
				local var_102_10 = var_102_8 <= 0 and var_102_4 or var_102_4 * (var_102_9 / var_102_8)

				if var_102_10 > 0 and var_102_4 < var_102_10 then
					arg_99_1.talkMaxDuration = var_102_10

					if var_102_10 + var_102_3 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_3
					end
				end

				arg_99_1.text_.text = var_102_7
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803024", "story_v_side_old_114803.awb") ~= 0 then
					local var_102_11 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803024", "story_v_side_old_114803.awb") / 1000

					if var_102_11 + var_102_3 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_11 + var_102_3
					end

					if var_102_6.prefab_name ~= "" and arg_99_1.actors_[var_102_6.prefab_name] ~= nil then
						local var_102_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_6.prefab_name].transform, "story_v_side_old_114803", "114803024", "story_v_side_old_114803.awb")

						arg_99_1:RecordAudio("114803024", var_102_12)
						arg_99_1:RecordAudio("114803024", var_102_12)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803024", "story_v_side_old_114803.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803024", "story_v_side_old_114803.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_13 = math.max(var_102_4, arg_99_1.talkMaxDuration)

			if var_102_3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_3 + var_102_13 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_3) / var_102_13

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_3 + var_102_13 and arg_99_1.time_ < var_102_3 + var_102_13 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play114803025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 114803025
		arg_103_1.duration_ = 7.17

		local var_103_0 = {
			ja = 2.6,
			ko = 6.1,
			zh = 6.766,
			en = 7.166
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play114803026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1080ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1080ui_story == nil then
				arg_103_1.var_.characterEffect1080ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.2

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect1080ui_story and not isNil(var_106_0) then
					arg_103_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1080ui_story then
				arg_103_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_106_4 = 0

			if var_106_4 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action467")
			end

			local var_106_5 = 0

			if var_106_5 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_106_6 = 0

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_106_7 = arg_103_1.actors_["1148ui_story"]
			local var_106_8 = 0

			if var_106_8 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 and not isNil(var_106_7) and arg_103_1.var_.characterEffect1148ui_story == nil then
				arg_103_1.var_.characterEffect1148ui_story = var_106_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_9 = 0.2

			if var_106_8 <= arg_103_1.time_ and arg_103_1.time_ < var_106_8 + var_106_9 and not isNil(var_106_7) then
				local var_106_10 = (arg_103_1.time_ - var_106_8) / var_106_9

				if arg_103_1.var_.characterEffect1148ui_story and not isNil(var_106_7) then
					local var_106_11 = Mathf.Lerp(0, 0.5, var_106_10)

					arg_103_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1148ui_story.fillRatio = var_106_11
				end
			end

			if arg_103_1.time_ >= var_106_8 + var_106_9 and arg_103_1.time_ < var_106_8 + var_106_9 + arg_106_0 and not isNil(var_106_7) and arg_103_1.var_.characterEffect1148ui_story then
				local var_106_12 = 0.5

				arg_103_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1148ui_story.fillRatio = var_106_12
			end

			local var_106_13 = 0
			local var_106_14 = 0.45

			if var_106_13 < arg_103_1.time_ and arg_103_1.time_ <= var_106_13 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_15 = arg_103_1:FormatText(StoryNameCfg[55].name)

				arg_103_1.leftNameTxt_.text = var_106_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_16 = arg_103_1:GetWordFromCfg(114803025)
				local var_106_17 = arg_103_1:FormatText(var_106_16.content)

				arg_103_1.text_.text = var_106_17

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_18 = 18
				local var_106_19 = utf8.len(var_106_17)
				local var_106_20 = var_106_18 <= 0 and var_106_14 or var_106_14 * (var_106_19 / var_106_18)

				if var_106_20 > 0 and var_106_14 < var_106_20 then
					arg_103_1.talkMaxDuration = var_106_20

					if var_106_20 + var_106_13 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_20 + var_106_13
					end
				end

				arg_103_1.text_.text = var_106_17
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803025", "story_v_side_old_114803.awb") ~= 0 then
					local var_106_21 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803025", "story_v_side_old_114803.awb") / 1000

					if var_106_21 + var_106_13 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_21 + var_106_13
					end

					if var_106_16.prefab_name ~= "" and arg_103_1.actors_[var_106_16.prefab_name] ~= nil then
						local var_106_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_16.prefab_name].transform, "story_v_side_old_114803", "114803025", "story_v_side_old_114803.awb")

						arg_103_1:RecordAudio("114803025", var_106_22)
						arg_103_1:RecordAudio("114803025", var_106_22)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803025", "story_v_side_old_114803.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803025", "story_v_side_old_114803.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_23 = math.max(var_106_14, arg_103_1.talkMaxDuration)

			if var_106_13 <= arg_103_1.time_ and arg_103_1.time_ < var_106_13 + var_106_23 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_13) / var_106_23

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_13 + var_106_23 and arg_103_1.time_ < var_106_13 + var_106_23 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play114803026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 114803026
		arg_107_1.duration_ = 12.73

		local var_107_0 = {
			ja = 9.666,
			ko = 10.866,
			zh = 12.733,
			en = 12.1
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play114803027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1148ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1148ui_story == nil then
				arg_107_1.var_.characterEffect1148ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.2

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect1148ui_story and not isNil(var_110_0) then
					arg_107_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1148ui_story then
				arg_107_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_110_4 = 0

			if var_110_4 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action467")
			end

			local var_110_5 = 0

			if var_110_5 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 then
				arg_107_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_110_6 = 0

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_110_7 = 0
			local var_110_8 = 1.125

			if var_110_7 < arg_107_1.time_ and arg_107_1.time_ <= var_110_7 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_9 = arg_107_1:FormatText(StoryNameCfg[8].name)

				arg_107_1.leftNameTxt_.text = var_110_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_10 = arg_107_1:GetWordFromCfg(114803026)
				local var_110_11 = arg_107_1:FormatText(var_110_10.content)

				arg_107_1.text_.text = var_110_11

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_12 = 45
				local var_110_13 = utf8.len(var_110_11)
				local var_110_14 = var_110_12 <= 0 and var_110_8 or var_110_8 * (var_110_13 / var_110_12)

				if var_110_14 > 0 and var_110_8 < var_110_14 then
					arg_107_1.talkMaxDuration = var_110_14

					if var_110_14 + var_110_7 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_7
					end
				end

				arg_107_1.text_.text = var_110_11
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803026", "story_v_side_old_114803.awb") ~= 0 then
					local var_110_15 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803026", "story_v_side_old_114803.awb") / 1000

					if var_110_15 + var_110_7 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_15 + var_110_7
					end

					if var_110_10.prefab_name ~= "" and arg_107_1.actors_[var_110_10.prefab_name] ~= nil then
						local var_110_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_10.prefab_name].transform, "story_v_side_old_114803", "114803026", "story_v_side_old_114803.awb")

						arg_107_1:RecordAudio("114803026", var_110_16)
						arg_107_1:RecordAudio("114803026", var_110_16)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803026", "story_v_side_old_114803.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803026", "story_v_side_old_114803.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_17 = math.max(var_110_8, arg_107_1.talkMaxDuration)

			if var_110_7 <= arg_107_1.time_ and arg_107_1.time_ < var_110_7 + var_110_17 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_7) / var_110_17

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_7 + var_110_17 and arg_107_1.time_ < var_110_7 + var_110_17 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play114803027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 114803027
		arg_111_1.duration_ = 11.1

		local var_111_0 = {
			ja = 11.1,
			ko = 5.033,
			zh = 5.766,
			en = 8.266
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play114803028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_114_2 = 0
			local var_114_3 = 0.625

			if var_114_2 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_4 = arg_111_1:FormatText(StoryNameCfg[8].name)

				arg_111_1.leftNameTxt_.text = var_114_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_5 = arg_111_1:GetWordFromCfg(114803027)
				local var_114_6 = arg_111_1:FormatText(var_114_5.content)

				arg_111_1.text_.text = var_114_6

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 25
				local var_114_8 = utf8.len(var_114_6)
				local var_114_9 = var_114_7 <= 0 and var_114_3 or var_114_3 * (var_114_8 / var_114_7)

				if var_114_9 > 0 and var_114_3 < var_114_9 then
					arg_111_1.talkMaxDuration = var_114_9

					if var_114_9 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_9 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_6
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803027", "story_v_side_old_114803.awb") ~= 0 then
					local var_114_10 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803027", "story_v_side_old_114803.awb") / 1000

					if var_114_10 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_2
					end

					if var_114_5.prefab_name ~= "" and arg_111_1.actors_[var_114_5.prefab_name] ~= nil then
						local var_114_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_5.prefab_name].transform, "story_v_side_old_114803", "114803027", "story_v_side_old_114803.awb")

						arg_111_1:RecordAudio("114803027", var_114_11)
						arg_111_1:RecordAudio("114803027", var_114_11)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803027", "story_v_side_old_114803.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803027", "story_v_side_old_114803.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_12 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_12 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_12

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_12 and arg_111_1.time_ < var_114_2 + var_114_12 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play114803028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 114803028
		arg_115_1.duration_ = 2.9

		local var_115_0 = {
			ja = 2.666,
			ko = 2.533,
			zh = 2.333,
			en = 2.9
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play114803029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1080ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1080ui_story == nil then
				arg_115_1.var_.characterEffect1080ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.2

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1080ui_story and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1080ui_story then
				arg_115_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_118_4 = 0

			if var_118_4 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action472")
			end

			local var_118_5 = 0

			if var_118_5 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_118_6 = arg_115_1.actors_["1148ui_story"]
			local var_118_7 = 0

			if var_118_7 < arg_115_1.time_ and arg_115_1.time_ <= var_118_7 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect1148ui_story == nil then
				arg_115_1.var_.characterEffect1148ui_story = var_118_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_8 = 0.2

			if var_118_7 <= arg_115_1.time_ and arg_115_1.time_ < var_118_7 + var_118_8 and not isNil(var_118_6) then
				local var_118_9 = (arg_115_1.time_ - var_118_7) / var_118_8

				if arg_115_1.var_.characterEffect1148ui_story and not isNil(var_118_6) then
					local var_118_10 = Mathf.Lerp(0, 0.5, var_118_9)

					arg_115_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1148ui_story.fillRatio = var_118_10
				end
			end

			if arg_115_1.time_ >= var_118_7 + var_118_8 and arg_115_1.time_ < var_118_7 + var_118_8 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect1148ui_story then
				local var_118_11 = 0.5

				arg_115_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1148ui_story.fillRatio = var_118_11
			end

			local var_118_12 = 0

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_118_13 = 0
			local var_118_14 = 0.175

			if var_118_13 < arg_115_1.time_ and arg_115_1.time_ <= var_118_13 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_15 = arg_115_1:FormatText(StoryNameCfg[55].name)

				arg_115_1.leftNameTxt_.text = var_118_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_16 = arg_115_1:GetWordFromCfg(114803028)
				local var_118_17 = arg_115_1:FormatText(var_118_16.content)

				arg_115_1.text_.text = var_118_17

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_18 = 7
				local var_118_19 = utf8.len(var_118_17)
				local var_118_20 = var_118_18 <= 0 and var_118_14 or var_118_14 * (var_118_19 / var_118_18)

				if var_118_20 > 0 and var_118_14 < var_118_20 then
					arg_115_1.talkMaxDuration = var_118_20

					if var_118_20 + var_118_13 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_20 + var_118_13
					end
				end

				arg_115_1.text_.text = var_118_17
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803028", "story_v_side_old_114803.awb") ~= 0 then
					local var_118_21 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803028", "story_v_side_old_114803.awb") / 1000

					if var_118_21 + var_118_13 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_21 + var_118_13
					end

					if var_118_16.prefab_name ~= "" and arg_115_1.actors_[var_118_16.prefab_name] ~= nil then
						local var_118_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_16.prefab_name].transform, "story_v_side_old_114803", "114803028", "story_v_side_old_114803.awb")

						arg_115_1:RecordAudio("114803028", var_118_22)
						arg_115_1:RecordAudio("114803028", var_118_22)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803028", "story_v_side_old_114803.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803028", "story_v_side_old_114803.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_23 = math.max(var_118_14, arg_115_1.talkMaxDuration)

			if var_118_13 <= arg_115_1.time_ and arg_115_1.time_ < var_118_13 + var_118_23 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_13) / var_118_23

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_13 + var_118_23 and arg_115_1.time_ < var_118_13 + var_118_23 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play114803029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 114803029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play114803030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1148ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos1148ui_story = var_122_0.localPosition

				local var_122_2 = "1148ui_story"

				arg_119_1:ShowWeapon(arg_119_1.var_[var_122_2 .. "Animator"].transform, false)
			end

			local var_122_3 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_3 then
				local var_122_4 = (arg_119_1.time_ - var_122_1) / var_122_3
				local var_122_5 = Vector3.New(0, -0.8, -6.2)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1148ui_story, var_122_5, var_122_4)

				local var_122_6 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_6.x, var_122_6.y, var_122_6.z)

				local var_122_7 = var_122_0.localEulerAngles

				var_122_7.z = 0
				var_122_7.x = 0
				var_122_0.localEulerAngles = var_122_7
			end

			if arg_119_1.time_ >= var_122_1 + var_122_3 and arg_119_1.time_ < var_122_1 + var_122_3 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_122_8 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_8.x, var_122_8.y, var_122_8.z)

				local var_122_9 = var_122_0.localEulerAngles

				var_122_9.z = 0
				var_122_9.x = 0
				var_122_0.localEulerAngles = var_122_9
			end

			local var_122_10 = 0.0166666666666667

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_122_11 = arg_119_1.actors_["1080ui_story"].transform
			local var_122_12 = 0

			if var_122_12 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 then
				arg_119_1.var_.moveOldPos1080ui_story = var_122_11.localPosition
			end

			local var_122_13 = 0.001

			if var_122_12 <= arg_119_1.time_ and arg_119_1.time_ < var_122_12 + var_122_13 then
				local var_122_14 = (arg_119_1.time_ - var_122_12) / var_122_13
				local var_122_15 = Vector3.New(0, 100, 0)

				var_122_11.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1080ui_story, var_122_15, var_122_14)

				local var_122_16 = manager.ui.mainCamera.transform.position - var_122_11.position

				var_122_11.forward = Vector3.New(var_122_16.x, var_122_16.y, var_122_16.z)

				local var_122_17 = var_122_11.localEulerAngles

				var_122_17.z = 0
				var_122_17.x = 0
				var_122_11.localEulerAngles = var_122_17
			end

			if arg_119_1.time_ >= var_122_12 + var_122_13 and arg_119_1.time_ < var_122_12 + var_122_13 + arg_122_0 then
				var_122_11.localPosition = Vector3.New(0, 100, 0)

				local var_122_18 = manager.ui.mainCamera.transform.position - var_122_11.position

				var_122_11.forward = Vector3.New(var_122_18.x, var_122_18.y, var_122_18.z)

				local var_122_19 = var_122_11.localEulerAngles

				var_122_19.z = 0
				var_122_19.x = 0
				var_122_11.localEulerAngles = var_122_19
			end

			local var_122_20 = 0.0166666666666667

			if var_122_20 < arg_119_1.time_ and arg_119_1.time_ <= var_122_20 + arg_122_0 then
				arg_119_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_122_21 = 0
			local var_122_22 = 1.025

			if var_122_21 < arg_119_1.time_ and arg_119_1.time_ <= var_122_21 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_23 = arg_119_1:GetWordFromCfg(114803029)
				local var_122_24 = arg_119_1:FormatText(var_122_23.content)

				arg_119_1.text_.text = var_122_24

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_25 = 41
				local var_122_26 = utf8.len(var_122_24)
				local var_122_27 = var_122_25 <= 0 and var_122_22 or var_122_22 * (var_122_26 / var_122_25)

				if var_122_27 > 0 and var_122_22 < var_122_27 then
					arg_119_1.talkMaxDuration = var_122_27

					if var_122_27 + var_122_21 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_27 + var_122_21
					end
				end

				arg_119_1.text_.text = var_122_24
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_28 = math.max(var_122_22, arg_119_1.talkMaxDuration)

			if var_122_21 <= arg_119_1.time_ and arg_119_1.time_ < var_122_21 + var_122_28 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_21) / var_122_28

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_21 + var_122_28 and arg_119_1.time_ < var_122_21 + var_122_28 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play114803030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 114803030
		arg_123_1.duration_ = 4.37

		local var_123_0 = {
			ja = 4.366,
			ko = 3.833,
			zh = 2.533,
			en = 3.566
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play114803031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1148ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1148ui_story == nil then
				arg_123_1.var_.characterEffect1148ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.2

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect1148ui_story and not isNil(var_126_0) then
					arg_123_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1148ui_story then
				arg_123_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_126_4 = 0

			if var_126_4 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_126_5 = 0

			if var_126_5 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_126_6 = 0
			local var_126_7 = 0.2

			if var_126_6 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_8 = arg_123_1:FormatText(StoryNameCfg[8].name)

				arg_123_1.leftNameTxt_.text = var_126_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_9 = arg_123_1:GetWordFromCfg(114803030)
				local var_126_10 = arg_123_1:FormatText(var_126_9.content)

				arg_123_1.text_.text = var_126_10

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_11 = 8
				local var_126_12 = utf8.len(var_126_10)
				local var_126_13 = var_126_11 <= 0 and var_126_7 or var_126_7 * (var_126_12 / var_126_11)

				if var_126_13 > 0 and var_126_7 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_6
					end
				end

				arg_123_1.text_.text = var_126_10
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803030", "story_v_side_old_114803.awb") ~= 0 then
					local var_126_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803030", "story_v_side_old_114803.awb") / 1000

					if var_126_14 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_6
					end

					if var_126_9.prefab_name ~= "" and arg_123_1.actors_[var_126_9.prefab_name] ~= nil then
						local var_126_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_9.prefab_name].transform, "story_v_side_old_114803", "114803030", "story_v_side_old_114803.awb")

						arg_123_1:RecordAudio("114803030", var_126_15)
						arg_123_1:RecordAudio("114803030", var_126_15)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803030", "story_v_side_old_114803.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803030", "story_v_side_old_114803.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_16 = math.max(var_126_7, arg_123_1.talkMaxDuration)

			if var_126_6 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_16 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_6) / var_126_16

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_6 + var_126_16 and arg_123_1.time_ < var_126_6 + var_126_16 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play114803031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 114803031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play114803032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1148ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1148ui_story == nil then
				arg_127_1.var_.characterEffect1148ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.2

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect1148ui_story and not isNil(var_130_0) then
					local var_130_4 = Mathf.Lerp(0, 0.5, var_130_3)

					arg_127_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1148ui_story.fillRatio = var_130_4
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1148ui_story then
				local var_130_5 = 0.5

				arg_127_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1148ui_story.fillRatio = var_130_5
			end

			local var_130_6 = 0

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_130_7 = 0
			local var_130_8 = 0.25

			if var_130_7 < arg_127_1.time_ and arg_127_1.time_ <= var_130_7 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_9 = arg_127_1:FormatText(StoryNameCfg[7].name)

				arg_127_1.leftNameTxt_.text = var_130_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_10 = arg_127_1:GetWordFromCfg(114803031)
				local var_130_11 = arg_127_1:FormatText(var_130_10.content)

				arg_127_1.text_.text = var_130_11

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_12 = 10
				local var_130_13 = utf8.len(var_130_11)
				local var_130_14 = var_130_12 <= 0 and var_130_8 or var_130_8 * (var_130_13 / var_130_12)

				if var_130_14 > 0 and var_130_8 < var_130_14 then
					arg_127_1.talkMaxDuration = var_130_14

					if var_130_14 + var_130_7 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_14 + var_130_7
					end
				end

				arg_127_1.text_.text = var_130_11
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_15 = math.max(var_130_8, arg_127_1.talkMaxDuration)

			if var_130_7 <= arg_127_1.time_ and arg_127_1.time_ < var_130_7 + var_130_15 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_7) / var_130_15

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_7 + var_130_15 and arg_127_1.time_ < var_130_7 + var_130_15 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play114803032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 114803032
		arg_131_1.duration_ = 4.63

		local var_131_0 = {
			ja = 4.633,
			ko = 4.433,
			zh = 4.166,
			en = 4.1
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play114803033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1148ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1148ui_story == nil then
				arg_131_1.var_.characterEffect1148ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.2

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect1148ui_story and not isNil(var_134_0) then
					arg_131_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1148ui_story then
				arg_131_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_134_4 = 0

			if var_134_4 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action434")
			end

			local var_134_5 = 0

			if var_134_5 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 then
				arg_131_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_134_6 = 0
			local var_134_7 = 0.475

			if var_134_6 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_8 = arg_131_1:FormatText(StoryNameCfg[8].name)

				arg_131_1.leftNameTxt_.text = var_134_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_9 = arg_131_1:GetWordFromCfg(114803032)
				local var_134_10 = arg_131_1:FormatText(var_134_9.content)

				arg_131_1.text_.text = var_134_10

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 19
				local var_134_12 = utf8.len(var_134_10)
				local var_134_13 = var_134_11 <= 0 and var_134_7 or var_134_7 * (var_134_12 / var_134_11)

				if var_134_13 > 0 and var_134_7 < var_134_13 then
					arg_131_1.talkMaxDuration = var_134_13

					if var_134_13 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_13 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_10
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803032", "story_v_side_old_114803.awb") ~= 0 then
					local var_134_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803032", "story_v_side_old_114803.awb") / 1000

					if var_134_14 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_6
					end

					if var_134_9.prefab_name ~= "" and arg_131_1.actors_[var_134_9.prefab_name] ~= nil then
						local var_134_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_9.prefab_name].transform, "story_v_side_old_114803", "114803032", "story_v_side_old_114803.awb")

						arg_131_1:RecordAudio("114803032", var_134_15)
						arg_131_1:RecordAudio("114803032", var_134_15)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803032", "story_v_side_old_114803.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803032", "story_v_side_old_114803.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_16 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_16 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_16

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_16 and arg_131_1.time_ < var_134_6 + var_134_16 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play114803033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 114803033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play114803034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1148ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1148ui_story == nil then
				arg_135_1.var_.characterEffect1148ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.2

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1148ui_story and not isNil(var_138_0) then
					local var_138_4 = Mathf.Lerp(0, 0.5, var_138_3)

					arg_135_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1148ui_story.fillRatio = var_138_4
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1148ui_story then
				local var_138_5 = 0.5

				arg_135_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1148ui_story.fillRatio = var_138_5
			end

			local var_138_6 = 0

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_138_7 = 0
			local var_138_8 = 0.3

			if var_138_7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_7 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_9 = arg_135_1:FormatText(StoryNameCfg[7].name)

				arg_135_1.leftNameTxt_.text = var_138_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_10 = arg_135_1:GetWordFromCfg(114803033)
				local var_138_11 = arg_135_1:FormatText(var_138_10.content)

				arg_135_1.text_.text = var_138_11

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_12 = 12
				local var_138_13 = utf8.len(var_138_11)
				local var_138_14 = var_138_12 <= 0 and var_138_8 or var_138_8 * (var_138_13 / var_138_12)

				if var_138_14 > 0 and var_138_8 < var_138_14 then
					arg_135_1.talkMaxDuration = var_138_14

					if var_138_14 + var_138_7 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_14 + var_138_7
					end
				end

				arg_135_1.text_.text = var_138_11
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_15 = math.max(var_138_8, arg_135_1.talkMaxDuration)

			if var_138_7 <= arg_135_1.time_ and arg_135_1.time_ < var_138_7 + var_138_15 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_7) / var_138_15

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_7 + var_138_15 and arg_135_1.time_ < var_138_7 + var_138_15 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play114803034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 114803034
		arg_139_1.duration_ = 11.1

		local var_139_0 = {
			ja = 11.1,
			ko = 9.266,
			zh = 7.166,
			en = 8.5
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play114803035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1148ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1148ui_story == nil then
				arg_139_1.var_.characterEffect1148ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.2

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect1148ui_story and not isNil(var_142_0) then
					arg_139_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1148ui_story then
				arg_139_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_142_4 = 0

			if var_142_4 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_142_5 = 0
			local var_142_6 = 0.85

			if var_142_5 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_7 = arg_139_1:FormatText(StoryNameCfg[8].name)

				arg_139_1.leftNameTxt_.text = var_142_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_8 = arg_139_1:GetWordFromCfg(114803034)
				local var_142_9 = arg_139_1:FormatText(var_142_8.content)

				arg_139_1.text_.text = var_142_9

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_10 = 34
				local var_142_11 = utf8.len(var_142_9)
				local var_142_12 = var_142_10 <= 0 and var_142_6 or var_142_6 * (var_142_11 / var_142_10)

				if var_142_12 > 0 and var_142_6 < var_142_12 then
					arg_139_1.talkMaxDuration = var_142_12

					if var_142_12 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_12 + var_142_5
					end
				end

				arg_139_1.text_.text = var_142_9
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803034", "story_v_side_old_114803.awb") ~= 0 then
					local var_142_13 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803034", "story_v_side_old_114803.awb") / 1000

					if var_142_13 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_5
					end

					if var_142_8.prefab_name ~= "" and arg_139_1.actors_[var_142_8.prefab_name] ~= nil then
						local var_142_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_8.prefab_name].transform, "story_v_side_old_114803", "114803034", "story_v_side_old_114803.awb")

						arg_139_1:RecordAudio("114803034", var_142_14)
						arg_139_1:RecordAudio("114803034", var_142_14)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803034", "story_v_side_old_114803.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803034", "story_v_side_old_114803.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_15 = math.max(var_142_6, arg_139_1.talkMaxDuration)

			if var_142_5 <= arg_139_1.time_ and arg_139_1.time_ < var_142_5 + var_142_15 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_5) / var_142_15

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_5 + var_142_15 and arg_139_1.time_ < var_142_5 + var_142_15 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play114803035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 114803035
		arg_143_1.duration_ = 7.17

		local var_143_0 = {
			ja = 6.466,
			ko = 5.8,
			zh = 6,
			en = 7.166
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play114803036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action446")
			end

			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_146_2 = 0
			local var_146_3 = 0.625

			if var_146_2 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_4 = arg_143_1:FormatText(StoryNameCfg[8].name)

				arg_143_1.leftNameTxt_.text = var_146_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_5 = arg_143_1:GetWordFromCfg(114803035)
				local var_146_6 = arg_143_1:FormatText(var_146_5.content)

				arg_143_1.text_.text = var_146_6

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 25
				local var_146_8 = utf8.len(var_146_6)
				local var_146_9 = var_146_7 <= 0 and var_146_3 or var_146_3 * (var_146_8 / var_146_7)

				if var_146_9 > 0 and var_146_3 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_2
					end
				end

				arg_143_1.text_.text = var_146_6
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803035", "story_v_side_old_114803.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803035", "story_v_side_old_114803.awb") / 1000

					if var_146_10 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_2
					end

					if var_146_5.prefab_name ~= "" and arg_143_1.actors_[var_146_5.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_5.prefab_name].transform, "story_v_side_old_114803", "114803035", "story_v_side_old_114803.awb")

						arg_143_1:RecordAudio("114803035", var_146_11)
						arg_143_1:RecordAudio("114803035", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803035", "story_v_side_old_114803.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803035", "story_v_side_old_114803.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_3, arg_143_1.talkMaxDuration)

			if var_146_2 <= arg_143_1.time_ and arg_143_1.time_ < var_146_2 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_2) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_2 + var_146_12 and arg_143_1.time_ < var_146_2 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play114803036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 114803036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play114803037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1148ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1148ui_story == nil then
				arg_147_1.var_.characterEffect1148ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.2

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect1148ui_story and not isNil(var_150_0) then
					local var_150_4 = Mathf.Lerp(0, 0.5, var_150_3)

					arg_147_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1148ui_story.fillRatio = var_150_4
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1148ui_story then
				local var_150_5 = 0.5

				arg_147_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1148ui_story.fillRatio = var_150_5
			end

			local var_150_6 = 0

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_150_7 = 0
			local var_150_8 = 0.325

			if var_150_7 < arg_147_1.time_ and arg_147_1.time_ <= var_150_7 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_9 = arg_147_1:FormatText(StoryNameCfg[7].name)

				arg_147_1.leftNameTxt_.text = var_150_9

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

				local var_150_10 = arg_147_1:GetWordFromCfg(114803036)
				local var_150_11 = arg_147_1:FormatText(var_150_10.content)

				arg_147_1.text_.text = var_150_11

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_12 = 13
				local var_150_13 = utf8.len(var_150_11)
				local var_150_14 = var_150_12 <= 0 and var_150_8 or var_150_8 * (var_150_13 / var_150_12)

				if var_150_14 > 0 and var_150_8 < var_150_14 then
					arg_147_1.talkMaxDuration = var_150_14

					if var_150_14 + var_150_7 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_14 + var_150_7
					end
				end

				arg_147_1.text_.text = var_150_11
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_15 = math.max(var_150_8, arg_147_1.talkMaxDuration)

			if var_150_7 <= arg_147_1.time_ and arg_147_1.time_ < var_150_7 + var_150_15 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_7) / var_150_15

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_7 + var_150_15 and arg_147_1.time_ < var_150_7 + var_150_15 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play114803037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 114803037
		arg_151_1.duration_ = 13.03

		local var_151_0 = {
			ja = 12.933,
			ko = 13.033,
			zh = 9.233,
			en = 10.166
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play114803038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1148ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1148ui_story == nil then
				arg_151_1.var_.characterEffect1148ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1148ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1148ui_story then
				arg_151_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_154_4 = 0

			if var_154_4 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action464")
			end

			local var_154_5 = 0

			if var_154_5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_154_6 = 0
			local var_154_7 = 1.225

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_8 = arg_151_1:FormatText(StoryNameCfg[8].name)

				arg_151_1.leftNameTxt_.text = var_154_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_9 = arg_151_1:GetWordFromCfg(114803037)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 49
				local var_154_12 = utf8.len(var_154_10)
				local var_154_13 = var_154_11 <= 0 and var_154_7 or var_154_7 * (var_154_12 / var_154_11)

				if var_154_13 > 0 and var_154_7 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_10
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803037", "story_v_side_old_114803.awb") ~= 0 then
					local var_154_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803037", "story_v_side_old_114803.awb") / 1000

					if var_154_14 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_6
					end

					if var_154_9.prefab_name ~= "" and arg_151_1.actors_[var_154_9.prefab_name] ~= nil then
						local var_154_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_9.prefab_name].transform, "story_v_side_old_114803", "114803037", "story_v_side_old_114803.awb")

						arg_151_1:RecordAudio("114803037", var_154_15)
						arg_151_1:RecordAudio("114803037", var_154_15)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803037", "story_v_side_old_114803.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803037", "story_v_side_old_114803.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_16 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_16 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_16

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_16 and arg_151_1.time_ < var_154_6 + var_154_16 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play114803038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 114803038
		arg_155_1.duration_ = 12.3

		local var_155_0 = {
			ja = 8.533,
			ko = 11.866,
			zh = 12.066,
			en = 12.3
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play114803039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_158_1 = 0
			local var_158_2 = 1.375

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_3 = arg_155_1:FormatText(StoryNameCfg[8].name)

				arg_155_1.leftNameTxt_.text = var_158_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_4 = arg_155_1:GetWordFromCfg(114803038)
				local var_158_5 = arg_155_1:FormatText(var_158_4.content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_6 = 55
				local var_158_7 = utf8.len(var_158_5)
				local var_158_8 = var_158_6 <= 0 and var_158_2 or var_158_2 * (var_158_7 / var_158_6)

				if var_158_8 > 0 and var_158_2 < var_158_8 then
					arg_155_1.talkMaxDuration = var_158_8

					if var_158_8 + var_158_1 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_1
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803038", "story_v_side_old_114803.awb") ~= 0 then
					local var_158_9 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803038", "story_v_side_old_114803.awb") / 1000

					if var_158_9 + var_158_1 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_9 + var_158_1
					end

					if var_158_4.prefab_name ~= "" and arg_155_1.actors_[var_158_4.prefab_name] ~= nil then
						local var_158_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_4.prefab_name].transform, "story_v_side_old_114803", "114803038", "story_v_side_old_114803.awb")

						arg_155_1:RecordAudio("114803038", var_158_10)
						arg_155_1:RecordAudio("114803038", var_158_10)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803038", "story_v_side_old_114803.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803038", "story_v_side_old_114803.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_11 = math.max(var_158_2, arg_155_1.talkMaxDuration)

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_11 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_1) / var_158_11

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_1 + var_158_11 and arg_155_1.time_ < var_158_1 + var_158_11 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play114803039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 114803039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play114803040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1148ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1148ui_story == nil then
				arg_159_1.var_.characterEffect1148ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.2

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect1148ui_story and not isNil(var_162_0) then
					local var_162_4 = Mathf.Lerp(0, 0.5, var_162_3)

					arg_159_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1148ui_story.fillRatio = var_162_4
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1148ui_story then
				local var_162_5 = 0.5

				arg_159_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1148ui_story.fillRatio = var_162_5
			end

			local var_162_6 = 0

			if var_162_6 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_162_7 = 0
			local var_162_8 = 0.1

			if var_162_7 < arg_159_1.time_ and arg_159_1.time_ <= var_162_7 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_9 = arg_159_1:FormatText(StoryNameCfg[7].name)

				arg_159_1.leftNameTxt_.text = var_162_9

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

				local var_162_10 = arg_159_1:GetWordFromCfg(114803039)
				local var_162_11 = arg_159_1:FormatText(var_162_10.content)

				arg_159_1.text_.text = var_162_11

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_12 = 4
				local var_162_13 = utf8.len(var_162_11)
				local var_162_14 = var_162_12 <= 0 and var_162_8 or var_162_8 * (var_162_13 / var_162_12)

				if var_162_14 > 0 and var_162_8 < var_162_14 then
					arg_159_1.talkMaxDuration = var_162_14

					if var_162_14 + var_162_7 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_14 + var_162_7
					end
				end

				arg_159_1.text_.text = var_162_11
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_15 = math.max(var_162_8, arg_159_1.talkMaxDuration)

			if var_162_7 <= arg_159_1.time_ and arg_159_1.time_ < var_162_7 + var_162_15 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_7) / var_162_15

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_7 + var_162_15 and arg_159_1.time_ < var_162_7 + var_162_15 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play114803040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 114803040
		arg_163_1.duration_ = 8.9

		local var_163_0 = {
			ja = 8.9,
			ko = 7.933,
			zh = 7.8,
			en = 5.733
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play114803041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1148ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1148ui_story == nil then
				arg_163_1.var_.characterEffect1148ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.2

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1148ui_story and not isNil(var_166_0) then
					arg_163_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1148ui_story then
				arg_163_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_166_4 = 0

			if var_166_4 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action446")
			end

			local var_166_5 = 0

			if var_166_5 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_166_6 = 0
			local var_166_7 = 1

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_8 = arg_163_1:FormatText(StoryNameCfg[8].name)

				arg_163_1.leftNameTxt_.text = var_166_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_9 = arg_163_1:GetWordFromCfg(114803040)
				local var_166_10 = arg_163_1:FormatText(var_166_9.content)

				arg_163_1.text_.text = var_166_10

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 40
				local var_166_12 = utf8.len(var_166_10)
				local var_166_13 = var_166_11 <= 0 and var_166_7 or var_166_7 * (var_166_12 / var_166_11)

				if var_166_13 > 0 and var_166_7 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_10
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803040", "story_v_side_old_114803.awb") ~= 0 then
					local var_166_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803040", "story_v_side_old_114803.awb") / 1000

					if var_166_14 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_6
					end

					if var_166_9.prefab_name ~= "" and arg_163_1.actors_[var_166_9.prefab_name] ~= nil then
						local var_166_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_9.prefab_name].transform, "story_v_side_old_114803", "114803040", "story_v_side_old_114803.awb")

						arg_163_1:RecordAudio("114803040", var_166_15)
						arg_163_1:RecordAudio("114803040", var_166_15)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803040", "story_v_side_old_114803.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803040", "story_v_side_old_114803.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_16 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_16 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_16

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_16 and arg_163_1.time_ < var_166_6 + var_166_16 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play114803041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 114803041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play114803042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_2")
			end

			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_170_2 = 0
			local var_170_3 = 0.95

			if var_170_2 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_4 = arg_167_1:GetWordFromCfg(114803041)
				local var_170_5 = arg_167_1:FormatText(var_170_4.content)

				arg_167_1.text_.text = var_170_5

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_6 = 38
				local var_170_7 = utf8.len(var_170_5)
				local var_170_8 = var_170_6 <= 0 and var_170_3 or var_170_3 * (var_170_7 / var_170_6)

				if var_170_8 > 0 and var_170_3 < var_170_8 then
					arg_167_1.talkMaxDuration = var_170_8

					if var_170_8 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_2
					end
				end

				arg_167_1.text_.text = var_170_5
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_9 = math.max(var_170_3, arg_167_1.talkMaxDuration)

			if var_170_2 <= arg_167_1.time_ and arg_167_1.time_ < var_170_2 + var_170_9 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_2) / var_170_9

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_2 + var_170_9 and arg_167_1.time_ < var_170_2 + var_170_9 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play114803042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 114803042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play114803043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_174_1 = 0
			local var_174_2 = 0.3

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:GetWordFromCfg(114803042)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 12
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_2 or var_174_2 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_2 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_1
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_8 = math.max(var_174_2, arg_171_1.talkMaxDuration)

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_8 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_1) / var_174_8

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_1 + var_174_8 and arg_171_1.time_ < var_174_1 + var_174_8 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play114803043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 114803043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play114803044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1148ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1148ui_story == nil then
				arg_175_1.var_.characterEffect1148ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.2

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect1148ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1148ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1148ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1148ui_story.fillRatio = var_178_5
			end

			local var_178_6 = 0
			local var_178_7 = 0.225

			if var_178_6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_8 = arg_175_1:FormatText(StoryNameCfg[7].name)

				arg_175_1.leftNameTxt_.text = var_178_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_9 = arg_175_1:GetWordFromCfg(114803043)
				local var_178_10 = arg_175_1:FormatText(var_178_9.content)

				arg_175_1.text_.text = var_178_10

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_11 = 9
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
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_14 = math.max(var_178_7, arg_175_1.talkMaxDuration)

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_14 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_6) / var_178_14

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_6 + var_178_14 and arg_175_1.time_ < var_178_6 + var_178_14 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play114803044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 114803044
		arg_179_1.duration_ = 7.77

		local var_179_0 = {
			ja = 7.333,
			ko = 7.233,
			zh = 7.766,
			en = 6.7
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
				arg_179_0:Play114803045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1148ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1148ui_story == nil then
				arg_179_1.var_.characterEffect1148ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.2

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect1148ui_story and not isNil(var_182_0) then
					arg_179_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1148ui_story then
				arg_179_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_182_4 = 3.60822483003176e-16

			if var_182_4 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_182_5 = 0

			if var_182_5 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_182_6 = 0
			local var_182_7 = 0.8

			if var_182_6 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_8 = arg_179_1:FormatText(StoryNameCfg[8].name)

				arg_179_1.leftNameTxt_.text = var_182_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_9 = arg_179_1:GetWordFromCfg(114803044)
				local var_182_10 = arg_179_1:FormatText(var_182_9.content)

				arg_179_1.text_.text = var_182_10

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_11 = 32
				local var_182_12 = utf8.len(var_182_10)
				local var_182_13 = var_182_11 <= 0 and var_182_7 or var_182_7 * (var_182_12 / var_182_11)

				if var_182_13 > 0 and var_182_7 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_6
					end
				end

				arg_179_1.text_.text = var_182_10
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803044", "story_v_side_old_114803.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803044", "story_v_side_old_114803.awb") / 1000

					if var_182_14 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_6
					end

					if var_182_9.prefab_name ~= "" and arg_179_1.actors_[var_182_9.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_9.prefab_name].transform, "story_v_side_old_114803", "114803044", "story_v_side_old_114803.awb")

						arg_179_1:RecordAudio("114803044", var_182_15)
						arg_179_1:RecordAudio("114803044", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803044", "story_v_side_old_114803.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803044", "story_v_side_old_114803.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_16 = math.max(var_182_7, arg_179_1.talkMaxDuration)

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_16 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_16

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_16 and arg_179_1.time_ < var_182_6 + var_182_16 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play114803045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 114803045
		arg_183_1.duration_ = 5.03

		local var_183_0 = {
			ja = 3.766,
			ko = 3.266,
			zh = 2.766,
			en = 5.033
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
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play114803046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_186_2 = 0
			local var_186_3 = 0.275

			if var_186_2 < arg_183_1.time_ and arg_183_1.time_ <= var_186_2 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_4 = arg_183_1:FormatText(StoryNameCfg[8].name)

				arg_183_1.leftNameTxt_.text = var_186_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_5 = arg_183_1:GetWordFromCfg(114803045)
				local var_186_6 = arg_183_1:FormatText(var_186_5.content)

				arg_183_1.text_.text = var_186_6

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_7 = 11
				local var_186_8 = utf8.len(var_186_6)
				local var_186_9 = var_186_7 <= 0 and var_186_3 or var_186_3 * (var_186_8 / var_186_7)

				if var_186_9 > 0 and var_186_3 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_2 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_2
					end
				end

				arg_183_1.text_.text = var_186_6
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803045", "story_v_side_old_114803.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803045", "story_v_side_old_114803.awb") / 1000

					if var_186_10 + var_186_2 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_2
					end

					if var_186_5.prefab_name ~= "" and arg_183_1.actors_[var_186_5.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_5.prefab_name].transform, "story_v_side_old_114803", "114803045", "story_v_side_old_114803.awb")

						arg_183_1:RecordAudio("114803045", var_186_11)
						arg_183_1:RecordAudio("114803045", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803045", "story_v_side_old_114803.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803045", "story_v_side_old_114803.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_12 = math.max(var_186_3, arg_183_1.talkMaxDuration)

			if var_186_2 <= arg_183_1.time_ and arg_183_1.time_ < var_186_2 + var_186_12 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_2) / var_186_12

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_2 + var_186_12 and arg_183_1.time_ < var_186_2 + var_186_12 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play114803046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 114803046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play114803047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1148ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1148ui_story == nil then
				arg_187_1.var_.characterEffect1148ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.2

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1148ui_story and not isNil(var_190_0) then
					local var_190_4 = Mathf.Lerp(0, 0.5, var_190_3)

					arg_187_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1148ui_story.fillRatio = var_190_4
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1148ui_story then
				local var_190_5 = 0.5

				arg_187_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1148ui_story.fillRatio = var_190_5
			end

			local var_190_6 = 0

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_190_7 = 0
			local var_190_8 = 0.25

			if var_190_7 < arg_187_1.time_ and arg_187_1.time_ <= var_190_7 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_9 = arg_187_1:FormatText(StoryNameCfg[7].name)

				arg_187_1.leftNameTxt_.text = var_190_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_10 = arg_187_1:GetWordFromCfg(114803046)
				local var_190_11 = arg_187_1:FormatText(var_190_10.content)

				arg_187_1.text_.text = var_190_11

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_12 = 10
				local var_190_13 = utf8.len(var_190_11)
				local var_190_14 = var_190_12 <= 0 and var_190_8 or var_190_8 * (var_190_13 / var_190_12)

				if var_190_14 > 0 and var_190_8 < var_190_14 then
					arg_187_1.talkMaxDuration = var_190_14

					if var_190_14 + var_190_7 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_14 + var_190_7
					end
				end

				arg_187_1.text_.text = var_190_11
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_15 = math.max(var_190_8, arg_187_1.talkMaxDuration)

			if var_190_7 <= arg_187_1.time_ and arg_187_1.time_ < var_190_7 + var_190_15 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_7) / var_190_15

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_7 + var_190_15 and arg_187_1.time_ < var_190_7 + var_190_15 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play114803047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 114803047
		arg_191_1.duration_ = 5.33

		local var_191_0 = {
			ja = 5.333,
			ko = 4.666,
			zh = 3.633,
			en = 3.8
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play114803048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1148ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1148ui_story == nil then
				arg_191_1.var_.characterEffect1148ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.2

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect1148ui_story and not isNil(var_194_0) then
					arg_191_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1148ui_story then
				arg_191_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_194_4 = 0

			if var_194_4 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_194_5 = 0

			if var_194_5 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_194_6 = 0
			local var_194_7 = 0.5

			if var_194_6 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_8 = arg_191_1:FormatText(StoryNameCfg[8].name)

				arg_191_1.leftNameTxt_.text = var_194_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_9 = arg_191_1:GetWordFromCfg(114803047)
				local var_194_10 = arg_191_1:FormatText(var_194_9.content)

				arg_191_1.text_.text = var_194_10

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 20
				local var_194_12 = utf8.len(var_194_10)
				local var_194_13 = var_194_11 <= 0 and var_194_7 or var_194_7 * (var_194_12 / var_194_11)

				if var_194_13 > 0 and var_194_7 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_6
					end
				end

				arg_191_1.text_.text = var_194_10
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803047", "story_v_side_old_114803.awb") ~= 0 then
					local var_194_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803047", "story_v_side_old_114803.awb") / 1000

					if var_194_14 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_14 + var_194_6
					end

					if var_194_9.prefab_name ~= "" and arg_191_1.actors_[var_194_9.prefab_name] ~= nil then
						local var_194_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_9.prefab_name].transform, "story_v_side_old_114803", "114803047", "story_v_side_old_114803.awb")

						arg_191_1:RecordAudio("114803047", var_194_15)
						arg_191_1:RecordAudio("114803047", var_194_15)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803047", "story_v_side_old_114803.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803047", "story_v_side_old_114803.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_16 = math.max(var_194_7, arg_191_1.talkMaxDuration)

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_16 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_6) / var_194_16

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_6 + var_194_16 and arg_191_1.time_ < var_194_6 + var_194_16 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play114803048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 114803048
		arg_195_1.duration_ = 8.5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play114803049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = "ST02"

			if arg_195_1.bgs_[var_198_0] == nil then
				local var_198_1 = Object.Instantiate(arg_195_1.paintGo_)

				var_198_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_198_0)
				var_198_1.name = var_198_0
				var_198_1.transform.parent = arg_195_1.stage_.transform
				var_198_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_195_1.bgs_[var_198_0] = var_198_1
			end

			local var_198_2 = 1.5

			if var_198_2 < arg_195_1.time_ and arg_195_1.time_ <= var_198_2 + arg_198_0 then
				local var_198_3 = manager.ui.mainCamera.transform.localPosition
				local var_198_4 = Vector3.New(0, 0, 10) + Vector3.New(var_198_3.x, var_198_3.y, 0)
				local var_198_5 = arg_195_1.bgs_.ST02

				var_198_5.transform.localPosition = var_198_4
				var_198_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_198_6 = var_198_5:GetComponent("SpriteRenderer")

				if var_198_6 and var_198_6.sprite then
					local var_198_7 = (var_198_5.transform.localPosition - var_198_3).z
					local var_198_8 = manager.ui.mainCameraCom_
					local var_198_9 = 2 * var_198_7 * Mathf.Tan(var_198_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_198_10 = var_198_9 * var_198_8.aspect
					local var_198_11 = var_198_6.sprite.bounds.size.x
					local var_198_12 = var_198_6.sprite.bounds.size.y
					local var_198_13 = var_198_10 / var_198_11
					local var_198_14 = var_198_9 / var_198_12
					local var_198_15 = var_198_14 < var_198_13 and var_198_13 or var_198_14

					var_198_5.transform.localScale = Vector3.New(var_198_15, var_198_15, 0)
				end

				for iter_198_0, iter_198_1 in pairs(arg_195_1.bgs_) do
					if iter_198_0 ~= "ST02" then
						iter_198_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_198_16 = arg_195_1.actors_["1148ui_story"].transform
			local var_198_17 = 0

			if var_198_17 < arg_195_1.time_ and arg_195_1.time_ <= var_198_17 + arg_198_0 then
				arg_195_1.var_.moveOldPos1148ui_story = var_198_16.localPosition
			end

			local var_198_18 = 0.001

			if var_198_17 <= arg_195_1.time_ and arg_195_1.time_ < var_198_17 + var_198_18 then
				local var_198_19 = (arg_195_1.time_ - var_198_17) / var_198_18
				local var_198_20 = Vector3.New(0, 100, 0)

				var_198_16.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1148ui_story, var_198_20, var_198_19)

				local var_198_21 = manager.ui.mainCamera.transform.position - var_198_16.position

				var_198_16.forward = Vector3.New(var_198_21.x, var_198_21.y, var_198_21.z)

				local var_198_22 = var_198_16.localEulerAngles

				var_198_22.z = 0
				var_198_22.x = 0
				var_198_16.localEulerAngles = var_198_22
			end

			if arg_195_1.time_ >= var_198_17 + var_198_18 and arg_195_1.time_ < var_198_17 + var_198_18 + arg_198_0 then
				var_198_16.localPosition = Vector3.New(0, 100, 0)

				local var_198_23 = manager.ui.mainCamera.transform.position - var_198_16.position

				var_198_16.forward = Vector3.New(var_198_23.x, var_198_23.y, var_198_23.z)

				local var_198_24 = var_198_16.localEulerAngles

				var_198_24.z = 0
				var_198_24.x = 0
				var_198_16.localEulerAngles = var_198_24
			end

			local var_198_25 = arg_195_1.bgs_.D02a
			local var_198_26 = 0

			if var_198_26 < arg_195_1.time_ and arg_195_1.time_ <= var_198_26 + arg_198_0 then
				local var_198_27 = var_198_25:GetComponent("SpriteRenderer")

				if var_198_27 then
					arg_195_1.var_.alphaOldValueD02a = var_198_27.color.a
					arg_195_1.var_.alphaMatValueD02a = var_198_27
				end

				arg_195_1.var_.alphaOldValueD02a = 1
			end

			local var_198_28 = 1.5

			if var_198_26 <= arg_195_1.time_ and arg_195_1.time_ < var_198_26 + var_198_28 then
				local var_198_29 = (arg_195_1.time_ - var_198_26) / var_198_28
				local var_198_30 = Mathf.Lerp(arg_195_1.var_.alphaOldValueD02a, 0, var_198_29)

				if arg_195_1.var_.alphaMatValueD02a then
					local var_198_31 = arg_195_1.var_.alphaMatValueD02a.color

					var_198_31.a = var_198_30
					arg_195_1.var_.alphaMatValueD02a.color = var_198_31
				end
			end

			if arg_195_1.time_ >= var_198_26 + var_198_28 and arg_195_1.time_ < var_198_26 + var_198_28 + arg_198_0 and arg_195_1.var_.alphaMatValueD02a then
				local var_198_32 = arg_195_1.var_.alphaMatValueD02a
				local var_198_33 = var_198_32.color

				var_198_33.a = 0
				var_198_32.color = var_198_33
			end

			local var_198_34 = arg_195_1.bgs_.ST02
			local var_198_35 = 1.5

			if var_198_35 < arg_195_1.time_ and arg_195_1.time_ <= var_198_35 + arg_198_0 then
				local var_198_36 = var_198_34:GetComponent("SpriteRenderer")

				if var_198_36 then
					arg_195_1.var_.alphaOldValueST02 = var_198_36.color.a
					arg_195_1.var_.alphaMatValueST02 = var_198_36
				end

				arg_195_1.var_.alphaOldValueST02 = 0
			end

			local var_198_37 = 1.5

			if var_198_35 <= arg_195_1.time_ and arg_195_1.time_ < var_198_35 + var_198_37 then
				local var_198_38 = (arg_195_1.time_ - var_198_35) / var_198_37
				local var_198_39 = Mathf.Lerp(arg_195_1.var_.alphaOldValueST02, 1, var_198_38)

				if arg_195_1.var_.alphaMatValueST02 then
					local var_198_40 = arg_195_1.var_.alphaMatValueST02.color

					var_198_40.a = var_198_39
					arg_195_1.var_.alphaMatValueST02.color = var_198_40
				end
			end

			if arg_195_1.time_ >= var_198_35 + var_198_37 and arg_195_1.time_ < var_198_35 + var_198_37 + arg_198_0 and arg_195_1.var_.alphaMatValueST02 then
				local var_198_41 = arg_195_1.var_.alphaMatValueST02
				local var_198_42 = var_198_41.color

				var_198_42.a = 1
				var_198_41.color = var_198_42
			end

			if arg_195_1.frameCnt_ <= 1 then
				arg_195_1.dialog_:SetActive(false)
			end

			local var_198_43 = 3.5
			local var_198_44 = 1.3

			if var_198_43 < arg_195_1.time_ and arg_195_1.time_ <= var_198_43 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0

				arg_195_1.dialog_:SetActive(true)

				arg_195_1.dialogCg_.alpha = 0

				local var_198_45 = LeanTween.value(arg_195_1.dialog_, 0, 1, 0.3)

				var_198_45:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_195_1.dialogCg_.alpha = arg_199_0
				end))
				var_198_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_195_1.dialog_)
					var_198_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_195_1.duration_ = arg_195_1.duration_ + 0.3

				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_46 = arg_195_1:GetWordFromCfg(114803048)
				local var_198_47 = arg_195_1:FormatText(var_198_46.content)

				arg_195_1.text_.text = var_198_47

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_48 = 52
				local var_198_49 = utf8.len(var_198_47)
				local var_198_50 = var_198_48 <= 0 and var_198_44 or var_198_44 * (var_198_49 / var_198_48)

				if var_198_50 > 0 and var_198_44 < var_198_50 then
					arg_195_1.talkMaxDuration = var_198_50
					var_198_43 = var_198_43 + 0.3

					if var_198_50 + var_198_43 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_50 + var_198_43
					end
				end

				arg_195_1.text_.text = var_198_47
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_51 = var_198_43 + 0.3
			local var_198_52 = math.max(var_198_44, arg_195_1.talkMaxDuration)

			if var_198_51 <= arg_195_1.time_ and arg_195_1.time_ < var_198_51 + var_198_52 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_51) / var_198_52

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_51 + var_198_52 and arg_195_1.time_ < var_198_51 + var_198_52 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play114803049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 114803049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play114803050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.75

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_2 = arg_201_1:GetWordFromCfg(114803049)
				local var_204_3 = arg_201_1:FormatText(var_204_2.content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 30
				local var_204_5 = utf8.len(var_204_3)
				local var_204_6 = var_204_4 <= 0 and var_204_1 or var_204_1 * (var_204_5 / var_204_4)

				if var_204_6 > 0 and var_204_1 < var_204_6 then
					arg_201_1.talkMaxDuration = var_204_6

					if var_204_6 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_6 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_7 and arg_201_1.time_ < var_204_0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play114803050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 114803050
		arg_205_1.duration_ = 3.33

		local var_205_0 = {
			ja = 3.333,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_205_0:Play114803051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1148ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1148ui_story = var_208_0.localPosition

				local var_208_2 = "1148ui_story"

				arg_205_1:ShowWeapon(arg_205_1.var_[var_208_2 .. "Animator"].transform, false)
			end

			local var_208_3 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_3 then
				local var_208_4 = (arg_205_1.time_ - var_208_1) / var_208_3
				local var_208_5 = Vector3.New(0, -0.8, -6.2)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1148ui_story, var_208_5, var_208_4)

				local var_208_6 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_6.x, var_208_6.y, var_208_6.z)

				local var_208_7 = var_208_0.localEulerAngles

				var_208_7.z = 0
				var_208_7.x = 0
				var_208_0.localEulerAngles = var_208_7
			end

			if arg_205_1.time_ >= var_208_1 + var_208_3 and arg_205_1.time_ < var_208_1 + var_208_3 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_208_8 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_8.x, var_208_8.y, var_208_8.z)

				local var_208_9 = var_208_0.localEulerAngles

				var_208_9.z = 0
				var_208_9.x = 0
				var_208_0.localEulerAngles = var_208_9
			end

			local var_208_10 = arg_205_1.actors_["1148ui_story"]
			local var_208_11 = 0.0166666666666667

			if var_208_11 < arg_205_1.time_ and arg_205_1.time_ <= var_208_11 + arg_208_0 and not isNil(var_208_10) and arg_205_1.var_.characterEffect1148ui_story == nil then
				arg_205_1.var_.characterEffect1148ui_story = var_208_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_12 = 0.2

			if var_208_11 <= arg_205_1.time_ and arg_205_1.time_ < var_208_11 + var_208_12 and not isNil(var_208_10) then
				local var_208_13 = (arg_205_1.time_ - var_208_11) / var_208_12

				if arg_205_1.var_.characterEffect1148ui_story and not isNil(var_208_10) then
					arg_205_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_11 + var_208_12 and arg_205_1.time_ < var_208_11 + var_208_12 + arg_208_0 and not isNil(var_208_10) and arg_205_1.var_.characterEffect1148ui_story then
				arg_205_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_208_14 = 0.0166666666666667

			if var_208_14 < arg_205_1.time_ and arg_205_1.time_ <= var_208_14 + arg_208_0 then
				arg_205_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action2_1")
			end

			local var_208_15 = 0.0166666666666667

			if var_208_15 < arg_205_1.time_ and arg_205_1.time_ <= var_208_15 + arg_208_0 then
				arg_205_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_208_16 = 0
			local var_208_17 = 0.125

			if var_208_16 < arg_205_1.time_ and arg_205_1.time_ <= var_208_16 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_18 = arg_205_1:FormatText(StoryNameCfg[8].name)

				arg_205_1.leftNameTxt_.text = var_208_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_19 = arg_205_1:GetWordFromCfg(114803050)
				local var_208_20 = arg_205_1:FormatText(var_208_19.content)

				arg_205_1.text_.text = var_208_20

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_21 = 5
				local var_208_22 = utf8.len(var_208_20)
				local var_208_23 = var_208_21 <= 0 and var_208_17 or var_208_17 * (var_208_22 / var_208_21)

				if var_208_23 > 0 and var_208_17 < var_208_23 then
					arg_205_1.talkMaxDuration = var_208_23

					if var_208_23 + var_208_16 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_23 + var_208_16
					end
				end

				arg_205_1.text_.text = var_208_20
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803050", "story_v_side_old_114803.awb") ~= 0 then
					local var_208_24 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803050", "story_v_side_old_114803.awb") / 1000

					if var_208_24 + var_208_16 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_24 + var_208_16
					end

					if var_208_19.prefab_name ~= "" and arg_205_1.actors_[var_208_19.prefab_name] ~= nil then
						local var_208_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_19.prefab_name].transform, "story_v_side_old_114803", "114803050", "story_v_side_old_114803.awb")

						arg_205_1:RecordAudio("114803050", var_208_25)
						arg_205_1:RecordAudio("114803050", var_208_25)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803050", "story_v_side_old_114803.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803050", "story_v_side_old_114803.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_26 = math.max(var_208_17, arg_205_1.talkMaxDuration)

			if var_208_16 <= arg_205_1.time_ and arg_205_1.time_ < var_208_16 + var_208_26 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_16) / var_208_26

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_16 + var_208_26 and arg_205_1.time_ < var_208_16 + var_208_26 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play114803051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 114803051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play114803052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1148ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1148ui_story == nil then
				arg_209_1.var_.characterEffect1148ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.2

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect1148ui_story and not isNil(var_212_0) then
					local var_212_4 = Mathf.Lerp(0, 0.5, var_212_3)

					arg_209_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1148ui_story.fillRatio = var_212_4
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1148ui_story then
				local var_212_5 = 0.5

				arg_209_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1148ui_story.fillRatio = var_212_5
			end

			local var_212_6 = 0

			if var_212_6 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_212_7 = 0
			local var_212_8 = 0.125

			if var_212_7 < arg_209_1.time_ and arg_209_1.time_ <= var_212_7 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_9 = arg_209_1:FormatText(StoryNameCfg[7].name)

				arg_209_1.leftNameTxt_.text = var_212_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_10 = arg_209_1:GetWordFromCfg(114803051)
				local var_212_11 = arg_209_1:FormatText(var_212_10.content)

				arg_209_1.text_.text = var_212_11

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_12 = 5
				local var_212_13 = utf8.len(var_212_11)
				local var_212_14 = var_212_12 <= 0 and var_212_8 or var_212_8 * (var_212_13 / var_212_12)

				if var_212_14 > 0 and var_212_8 < var_212_14 then
					arg_209_1.talkMaxDuration = var_212_14

					if var_212_14 + var_212_7 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_7
					end
				end

				arg_209_1.text_.text = var_212_11
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_15 = math.max(var_212_8, arg_209_1.talkMaxDuration)

			if var_212_7 <= arg_209_1.time_ and arg_209_1.time_ < var_212_7 + var_212_15 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_7) / var_212_15

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_7 + var_212_15 and arg_209_1.time_ < var_212_7 + var_212_15 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play114803052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 114803052
		arg_213_1.duration_ = 9.4

		local var_213_0 = {
			ja = 9.4,
			ko = 8.3,
			zh = 6.2,
			en = 8.166
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
				arg_213_0:Play114803053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1148ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1148ui_story == nil then
				arg_213_1.var_.characterEffect1148ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.2

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect1148ui_story and not isNil(var_216_0) then
					arg_213_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1148ui_story then
				arg_213_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_216_4 = 0

			if var_216_4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action427")
			end

			local var_216_5 = 0

			if var_216_5 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_216_6 = 0
			local var_216_7 = 0.75

			if var_216_6 < arg_213_1.time_ and arg_213_1.time_ <= var_216_6 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_8 = arg_213_1:FormatText(StoryNameCfg[8].name)

				arg_213_1.leftNameTxt_.text = var_216_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_9 = arg_213_1:GetWordFromCfg(114803052)
				local var_216_10 = arg_213_1:FormatText(var_216_9.content)

				arg_213_1.text_.text = var_216_10

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_11 = 30
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

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803052", "story_v_side_old_114803.awb") ~= 0 then
					local var_216_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803052", "story_v_side_old_114803.awb") / 1000

					if var_216_14 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_14 + var_216_6
					end

					if var_216_9.prefab_name ~= "" and arg_213_1.actors_[var_216_9.prefab_name] ~= nil then
						local var_216_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_9.prefab_name].transform, "story_v_side_old_114803", "114803052", "story_v_side_old_114803.awb")

						arg_213_1:RecordAudio("114803052", var_216_15)
						arg_213_1:RecordAudio("114803052", var_216_15)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803052", "story_v_side_old_114803.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803052", "story_v_side_old_114803.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_16 = math.max(var_216_7, arg_213_1.talkMaxDuration)

			if var_216_6 <= arg_213_1.time_ and arg_213_1.time_ < var_216_6 + var_216_16 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_6) / var_216_16

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_6 + var_216_16 and arg_213_1.time_ < var_216_6 + var_216_16 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play114803053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 114803053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play114803054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_220_2 = 0
			local var_220_3 = 0.9

			if var_220_2 < arg_217_1.time_ and arg_217_1.time_ <= var_220_2 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_4 = arg_217_1:GetWordFromCfg(114803053)
				local var_220_5 = arg_217_1:FormatText(var_220_4.content)

				arg_217_1.text_.text = var_220_5

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_6 = 36
				local var_220_7 = utf8.len(var_220_5)
				local var_220_8 = var_220_6 <= 0 and var_220_3 or var_220_3 * (var_220_7 / var_220_6)

				if var_220_8 > 0 and var_220_3 < var_220_8 then
					arg_217_1.talkMaxDuration = var_220_8

					if var_220_8 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_2
					end
				end

				arg_217_1.text_.text = var_220_5
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_9 = math.max(var_220_3, arg_217_1.talkMaxDuration)

			if var_220_2 <= arg_217_1.time_ and arg_217_1.time_ < var_220_2 + var_220_9 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_2) / var_220_9

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_2 + var_220_9 and arg_217_1.time_ < var_220_2 + var_220_9 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play114803054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 114803054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play114803055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_224_2 = 0
			local var_224_3 = 1.225

			if var_224_2 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_4 = arg_221_1:GetWordFromCfg(114803054)
				local var_224_5 = arg_221_1:FormatText(var_224_4.content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_6 = 49
				local var_224_7 = utf8.len(var_224_5)
				local var_224_8 = var_224_6 <= 0 and var_224_3 or var_224_3 * (var_224_7 / var_224_6)

				if var_224_8 > 0 and var_224_3 < var_224_8 then
					arg_221_1.talkMaxDuration = var_224_8

					if var_224_8 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_2
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_9 = math.max(var_224_3, arg_221_1.talkMaxDuration)

			if var_224_2 <= arg_221_1.time_ and arg_221_1.time_ < var_224_2 + var_224_9 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_2) / var_224_9

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_2 + var_224_9 and arg_221_1.time_ < var_224_2 + var_224_9 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play114803055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 114803055
		arg_225_1.duration_ = 4.37

		local var_225_0 = {
			ja = 4.366,
			ko = 2.9,
			zh = 2.566,
			en = 1.999999999999
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play114803056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1148ui_story"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos1148ui_story = var_228_0.localPosition

				local var_228_2 = "1148ui_story"

				arg_225_1:ShowWeapon(arg_225_1.var_[var_228_2 .. "Animator"].transform, false)
			end

			local var_228_3 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_3 then
				local var_228_4 = (arg_225_1.time_ - var_228_1) / var_228_3
				local var_228_5 = Vector3.New(-0.7, -0.8, -6.2)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1148ui_story, var_228_5, var_228_4)

				local var_228_6 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_6.x, var_228_6.y, var_228_6.z)

				local var_228_7 = var_228_0.localEulerAngles

				var_228_7.z = 0
				var_228_7.x = 0
				var_228_0.localEulerAngles = var_228_7
			end

			if arg_225_1.time_ >= var_228_1 + var_228_3 and arg_225_1.time_ < var_228_1 + var_228_3 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_228_8 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_8.x, var_228_8.y, var_228_8.z)

				local var_228_9 = var_228_0.localEulerAngles

				var_228_9.z = 0
				var_228_9.x = 0
				var_228_0.localEulerAngles = var_228_9
			end

			local var_228_10 = 0.0166666666666667

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 then
				arg_225_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_228_11 = "1027ui_story"

			if arg_225_1.actors_[var_228_11] == nil then
				local var_228_12 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_228_12) then
					local var_228_13 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_225_1.stage_.transform)

					var_228_13.name = var_228_11
					var_228_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_225_1.actors_[var_228_11] = var_228_13

					local var_228_14 = var_228_13:GetComponentInChildren(typeof(CharacterEffect))

					var_228_14.enabled = true

					local var_228_15 = GameObjectTools.GetOrAddComponent(var_228_13, typeof(DynamicBoneHelper))

					if var_228_15 then
						var_228_15:EnableDynamicBone(false)
					end

					arg_225_1:ShowWeapon(var_228_14.transform, false)

					arg_225_1.var_[var_228_11 .. "Animator"] = var_228_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_225_1.var_[var_228_11 .. "Animator"].applyRootMotion = true
					arg_225_1.var_[var_228_11 .. "LipSync"] = var_228_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_228_16 = arg_225_1.actors_["1027ui_story"].transform
			local var_228_17 = 0

			if var_228_17 < arg_225_1.time_ and arg_225_1.time_ <= var_228_17 + arg_228_0 then
				arg_225_1.var_.moveOldPos1027ui_story = var_228_16.localPosition

				local var_228_18 = "1027ui_story"

				arg_225_1:ShowWeapon(arg_225_1.var_[var_228_18 .. "Animator"].transform, false)
			end

			local var_228_19 = 0.001

			if var_228_17 <= arg_225_1.time_ and arg_225_1.time_ < var_228_17 + var_228_19 then
				local var_228_20 = (arg_225_1.time_ - var_228_17) / var_228_19
				local var_228_21 = Vector3.New(0.7, -0.81, -5.8)

				var_228_16.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1027ui_story, var_228_21, var_228_20)

				local var_228_22 = manager.ui.mainCamera.transform.position - var_228_16.position

				var_228_16.forward = Vector3.New(var_228_22.x, var_228_22.y, var_228_22.z)

				local var_228_23 = var_228_16.localEulerAngles

				var_228_23.z = 0
				var_228_23.x = 0
				var_228_16.localEulerAngles = var_228_23
			end

			if arg_225_1.time_ >= var_228_17 + var_228_19 and arg_225_1.time_ < var_228_17 + var_228_19 + arg_228_0 then
				var_228_16.localPosition = Vector3.New(0.7, -0.81, -5.8)

				local var_228_24 = manager.ui.mainCamera.transform.position - var_228_16.position

				var_228_16.forward = Vector3.New(var_228_24.x, var_228_24.y, var_228_24.z)

				local var_228_25 = var_228_16.localEulerAngles

				var_228_25.z = 0
				var_228_25.x = 0
				var_228_16.localEulerAngles = var_228_25
			end

			local var_228_26 = 0.0166666666666667

			if var_228_26 < arg_225_1.time_ and arg_225_1.time_ <= var_228_26 + arg_228_0 then
				arg_225_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action5_1")
			end

			local var_228_27 = arg_225_1.actors_["1027ui_story"]
			local var_228_28 = 0

			if var_228_28 < arg_225_1.time_ and arg_225_1.time_ <= var_228_28 + arg_228_0 and not isNil(var_228_27) and arg_225_1.var_.characterEffect1027ui_story == nil then
				arg_225_1.var_.characterEffect1027ui_story = var_228_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_29 = 0.2

			if var_228_28 <= arg_225_1.time_ and arg_225_1.time_ < var_228_28 + var_228_29 and not isNil(var_228_27) then
				local var_228_30 = (arg_225_1.time_ - var_228_28) / var_228_29

				if arg_225_1.var_.characterEffect1027ui_story and not isNil(var_228_27) then
					arg_225_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_28 + var_228_29 and arg_225_1.time_ < var_228_28 + var_228_29 + arg_228_0 and not isNil(var_228_27) and arg_225_1.var_.characterEffect1027ui_story then
				arg_225_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_228_31 = 0.0166666666666667

			if var_228_31 < arg_225_1.time_ and arg_225_1.time_ <= var_228_31 + arg_228_0 then
				arg_225_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_228_32 = arg_225_1.actors_["1148ui_story"]
			local var_228_33 = 0

			if var_228_33 < arg_225_1.time_ and arg_225_1.time_ <= var_228_33 + arg_228_0 and not isNil(var_228_32) and arg_225_1.var_.characterEffect1148ui_story == nil then
				arg_225_1.var_.characterEffect1148ui_story = var_228_32:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_34 = 0.2

			if var_228_33 <= arg_225_1.time_ and arg_225_1.time_ < var_228_33 + var_228_34 and not isNil(var_228_32) then
				local var_228_35 = (arg_225_1.time_ - var_228_33) / var_228_34

				if arg_225_1.var_.characterEffect1148ui_story and not isNil(var_228_32) then
					local var_228_36 = Mathf.Lerp(0, 0.5, var_228_35)

					arg_225_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1148ui_story.fillRatio = var_228_36
				end
			end

			if arg_225_1.time_ >= var_228_33 + var_228_34 and arg_225_1.time_ < var_228_33 + var_228_34 + arg_228_0 and not isNil(var_228_32) and arg_225_1.var_.characterEffect1148ui_story then
				local var_228_37 = 0.5

				arg_225_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1148ui_story.fillRatio = var_228_37
			end

			local var_228_38 = 0.0166666666666667

			if var_228_38 < arg_225_1.time_ and arg_225_1.time_ <= var_228_38 + arg_228_0 then
				arg_225_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_228_39 = 0
			local var_228_40 = 0.175

			if var_228_39 < arg_225_1.time_ and arg_225_1.time_ <= var_228_39 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_41 = arg_225_1:FormatText(StoryNameCfg[56].name)

				arg_225_1.leftNameTxt_.text = var_228_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_42 = arg_225_1:GetWordFromCfg(114803055)
				local var_228_43 = arg_225_1:FormatText(var_228_42.content)

				arg_225_1.text_.text = var_228_43

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_44 = 7
				local var_228_45 = utf8.len(var_228_43)
				local var_228_46 = var_228_44 <= 0 and var_228_40 or var_228_40 * (var_228_45 / var_228_44)

				if var_228_46 > 0 and var_228_40 < var_228_46 then
					arg_225_1.talkMaxDuration = var_228_46

					if var_228_46 + var_228_39 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_46 + var_228_39
					end
				end

				arg_225_1.text_.text = var_228_43
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803055", "story_v_side_old_114803.awb") ~= 0 then
					local var_228_47 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803055", "story_v_side_old_114803.awb") / 1000

					if var_228_47 + var_228_39 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_47 + var_228_39
					end

					if var_228_42.prefab_name ~= "" and arg_225_1.actors_[var_228_42.prefab_name] ~= nil then
						local var_228_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_42.prefab_name].transform, "story_v_side_old_114803", "114803055", "story_v_side_old_114803.awb")

						arg_225_1:RecordAudio("114803055", var_228_48)
						arg_225_1:RecordAudio("114803055", var_228_48)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803055", "story_v_side_old_114803.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803055", "story_v_side_old_114803.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_49 = math.max(var_228_40, arg_225_1.talkMaxDuration)

			if var_228_39 <= arg_225_1.time_ and arg_225_1.time_ < var_228_39 + var_228_49 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_39) / var_228_49

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_39 + var_228_49 and arg_225_1.time_ < var_228_39 + var_228_49 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play114803056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 114803056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play114803057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action5_2")
			end

			local var_232_1 = arg_229_1.actors_["1027ui_story"]
			local var_232_2 = 0

			if var_232_2 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1027ui_story == nil then
				arg_229_1.var_.characterEffect1027ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_3 = 0.2

			if var_232_2 <= arg_229_1.time_ and arg_229_1.time_ < var_232_2 + var_232_3 and not isNil(var_232_1) then
				local var_232_4 = (arg_229_1.time_ - var_232_2) / var_232_3

				if arg_229_1.var_.characterEffect1027ui_story and not isNil(var_232_1) then
					local var_232_5 = Mathf.Lerp(0, 0.5, var_232_4)

					arg_229_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1027ui_story.fillRatio = var_232_5
				end
			end

			if arg_229_1.time_ >= var_232_2 + var_232_3 and arg_229_1.time_ < var_232_2 + var_232_3 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1027ui_story then
				local var_232_6 = 0.5

				arg_229_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1027ui_story.fillRatio = var_232_6
			end

			local var_232_7 = 0

			if var_232_7 < arg_229_1.time_ and arg_229_1.time_ <= var_232_7 + arg_232_0 then
				arg_229_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_232_8 = 0

			if var_232_8 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 then
				arg_229_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_232_9 = 0
			local var_232_10 = 0.625

			if var_232_9 < arg_229_1.time_ and arg_229_1.time_ <= var_232_9 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_11 = arg_229_1:GetWordFromCfg(114803056)
				local var_232_12 = arg_229_1:FormatText(var_232_11.content)

				arg_229_1.text_.text = var_232_12

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_13 = 25
				local var_232_14 = utf8.len(var_232_12)
				local var_232_15 = var_232_13 <= 0 and var_232_10 or var_232_10 * (var_232_14 / var_232_13)

				if var_232_15 > 0 and var_232_10 < var_232_15 then
					arg_229_1.talkMaxDuration = var_232_15

					if var_232_15 + var_232_9 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_15 + var_232_9
					end
				end

				arg_229_1.text_.text = var_232_12
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_16 = math.max(var_232_10, arg_229_1.talkMaxDuration)

			if var_232_9 <= arg_229_1.time_ and arg_229_1.time_ < var_232_9 + var_232_16 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_9) / var_232_16

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_9 + var_232_16 and arg_229_1.time_ < var_232_9 + var_232_16 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play114803057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 114803057
		arg_233_1.duration_ = 6.2

		local var_233_0 = {
			ja = 5.233,
			ko = 6.2,
			zh = 5.7,
			en = 5.966
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play114803058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1027ui_story"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1027ui_story == nil then
				arg_233_1.var_.characterEffect1027ui_story = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.2

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect1027ui_story and not isNil(var_236_0) then
					arg_233_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1027ui_story then
				arg_233_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_236_4 = 0

			if var_236_4 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_236_5 = 0

			if var_236_5 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_236_6 = 0

			if var_236_6 < arg_233_1.time_ and arg_233_1.time_ <= var_236_6 + arg_236_0 then
				arg_233_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_236_7 = 0
			local var_236_8 = 0.475

			if var_236_7 < arg_233_1.time_ and arg_233_1.time_ <= var_236_7 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_9 = arg_233_1:FormatText(StoryNameCfg[56].name)

				arg_233_1.leftNameTxt_.text = var_236_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_10 = arg_233_1:GetWordFromCfg(114803057)
				local var_236_11 = arg_233_1:FormatText(var_236_10.content)

				arg_233_1.text_.text = var_236_11

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_12 = 19
				local var_236_13 = utf8.len(var_236_11)
				local var_236_14 = var_236_12 <= 0 and var_236_8 or var_236_8 * (var_236_13 / var_236_12)

				if var_236_14 > 0 and var_236_8 < var_236_14 then
					arg_233_1.talkMaxDuration = var_236_14

					if var_236_14 + var_236_7 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_14 + var_236_7
					end
				end

				arg_233_1.text_.text = var_236_11
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803057", "story_v_side_old_114803.awb") ~= 0 then
					local var_236_15 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803057", "story_v_side_old_114803.awb") / 1000

					if var_236_15 + var_236_7 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_15 + var_236_7
					end

					if var_236_10.prefab_name ~= "" and arg_233_1.actors_[var_236_10.prefab_name] ~= nil then
						local var_236_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_10.prefab_name].transform, "story_v_side_old_114803", "114803057", "story_v_side_old_114803.awb")

						arg_233_1:RecordAudio("114803057", var_236_16)
						arg_233_1:RecordAudio("114803057", var_236_16)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803057", "story_v_side_old_114803.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803057", "story_v_side_old_114803.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_17 = math.max(var_236_8, arg_233_1.talkMaxDuration)

			if var_236_7 <= arg_233_1.time_ and arg_233_1.time_ < var_236_7 + var_236_17 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_7) / var_236_17

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_7 + var_236_17 and arg_233_1.time_ < var_236_7 + var_236_17 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play114803058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 114803058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play114803059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1027ui_story"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1027ui_story == nil then
				arg_237_1.var_.characterEffect1027ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.2

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.characterEffect1027ui_story and not isNil(var_240_0) then
					local var_240_4 = Mathf.Lerp(0, 0.5, var_240_3)

					arg_237_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1027ui_story.fillRatio = var_240_4
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1027ui_story then
				local var_240_5 = 0.5

				arg_237_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1027ui_story.fillRatio = var_240_5
			end

			local var_240_6 = 0

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_240_7 = 0

			if var_240_7 < arg_237_1.time_ and arg_237_1.time_ <= var_240_7 + arg_240_0 then
				arg_237_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_240_8 = 0
			local var_240_9 = 1

			if var_240_8 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				local var_240_10 = "play"
				local var_240_11 = "effect"

				arg_237_1:AudioAction(var_240_10, var_240_11, "se_story_side_1148", "se_story_1148_applause", "")
			end

			local var_240_12 = 0
			local var_240_13 = 0.95

			if var_240_12 < arg_237_1.time_ and arg_237_1.time_ <= var_240_12 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_14 = arg_237_1:GetWordFromCfg(114803058)
				local var_240_15 = arg_237_1:FormatText(var_240_14.content)

				arg_237_1.text_.text = var_240_15

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_16 = 38
				local var_240_17 = utf8.len(var_240_15)
				local var_240_18 = var_240_16 <= 0 and var_240_13 or var_240_13 * (var_240_17 / var_240_16)

				if var_240_18 > 0 and var_240_13 < var_240_18 then
					arg_237_1.talkMaxDuration = var_240_18

					if var_240_18 + var_240_12 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_18 + var_240_12
					end
				end

				arg_237_1.text_.text = var_240_15
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_19 = math.max(var_240_13, arg_237_1.talkMaxDuration)

			if var_240_12 <= arg_237_1.time_ and arg_237_1.time_ < var_240_12 + var_240_19 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_12) / var_240_19

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_12 + var_240_19 and arg_237_1.time_ < var_240_12 + var_240_19 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play114803059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 114803059
		arg_241_1.duration_ = 9.47

		local var_241_0 = {
			ja = 9.466,
			ko = 5.566,
			zh = 7.233,
			en = 8.7
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
				arg_241_0:Play114803060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1148ui_story"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1148ui_story == nil then
				arg_241_1.var_.characterEffect1148ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.2

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.characterEffect1148ui_story and not isNil(var_244_0) then
					arg_241_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1148ui_story then
				arg_241_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_244_4 = 0

			if var_244_4 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_244_5 = 0

			if var_244_5 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 then
				arg_241_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_244_6 = 0

			if var_244_6 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 then
				arg_241_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_244_7 = 0
			local var_244_8 = 0.45

			if var_244_7 < arg_241_1.time_ and arg_241_1.time_ <= var_244_7 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_9 = arg_241_1:FormatText(StoryNameCfg[8].name)

				arg_241_1.leftNameTxt_.text = var_244_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_10 = arg_241_1:GetWordFromCfg(114803059)
				local var_244_11 = arg_241_1:FormatText(var_244_10.content)

				arg_241_1.text_.text = var_244_11

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_12 = 18
				local var_244_13 = utf8.len(var_244_11)
				local var_244_14 = var_244_12 <= 0 and var_244_8 or var_244_8 * (var_244_13 / var_244_12)

				if var_244_14 > 0 and var_244_8 < var_244_14 then
					arg_241_1.talkMaxDuration = var_244_14

					if var_244_14 + var_244_7 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_14 + var_244_7
					end
				end

				arg_241_1.text_.text = var_244_11
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803059", "story_v_side_old_114803.awb") ~= 0 then
					local var_244_15 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803059", "story_v_side_old_114803.awb") / 1000

					if var_244_15 + var_244_7 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_15 + var_244_7
					end

					if var_244_10.prefab_name ~= "" and arg_241_1.actors_[var_244_10.prefab_name] ~= nil then
						local var_244_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_10.prefab_name].transform, "story_v_side_old_114803", "114803059", "story_v_side_old_114803.awb")

						arg_241_1:RecordAudio("114803059", var_244_16)
						arg_241_1:RecordAudio("114803059", var_244_16)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803059", "story_v_side_old_114803.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803059", "story_v_side_old_114803.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_17 = math.max(var_244_8, arg_241_1.talkMaxDuration)

			if var_244_7 <= arg_241_1.time_ and arg_241_1.time_ < var_244_7 + var_244_17 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_7) / var_244_17

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_7 + var_244_17 and arg_241_1.time_ < var_244_7 + var_244_17 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play114803060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 114803060
		arg_245_1.duration_ = 5.53

		local var_245_0 = {
			ja = 4.633,
			ko = 5.533,
			zh = 4.733,
			en = 5.433
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
				arg_245_0:Play114803061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action475")
			end

			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_248_2 = 0

			if var_248_2 < arg_245_1.time_ and arg_245_1.time_ <= var_248_2 + arg_248_0 then
				arg_245_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_248_3 = 0
			local var_248_4 = 0.65

			if var_248_3 < arg_245_1.time_ and arg_245_1.time_ <= var_248_3 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_5 = arg_245_1:FormatText(StoryNameCfg[8].name)

				arg_245_1.leftNameTxt_.text = var_248_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_6 = arg_245_1:GetWordFromCfg(114803060)
				local var_248_7 = arg_245_1:FormatText(var_248_6.content)

				arg_245_1.text_.text = var_248_7

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_8 = 26
				local var_248_9 = utf8.len(var_248_7)
				local var_248_10 = var_248_8 <= 0 and var_248_4 or var_248_4 * (var_248_9 / var_248_8)

				if var_248_10 > 0 and var_248_4 < var_248_10 then
					arg_245_1.talkMaxDuration = var_248_10

					if var_248_10 + var_248_3 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_3
					end
				end

				arg_245_1.text_.text = var_248_7
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803060", "story_v_side_old_114803.awb") ~= 0 then
					local var_248_11 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803060", "story_v_side_old_114803.awb") / 1000

					if var_248_11 + var_248_3 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_11 + var_248_3
					end

					if var_248_6.prefab_name ~= "" and arg_245_1.actors_[var_248_6.prefab_name] ~= nil then
						local var_248_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_6.prefab_name].transform, "story_v_side_old_114803", "114803060", "story_v_side_old_114803.awb")

						arg_245_1:RecordAudio("114803060", var_248_12)
						arg_245_1:RecordAudio("114803060", var_248_12)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803060", "story_v_side_old_114803.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803060", "story_v_side_old_114803.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_13 = math.max(var_248_4, arg_245_1.talkMaxDuration)

			if var_248_3 <= arg_245_1.time_ and arg_245_1.time_ < var_248_3 + var_248_13 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_3) / var_248_13

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_3 + var_248_13 and arg_245_1.time_ < var_248_3 + var_248_13 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play114803061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 114803061
		arg_249_1.duration_ = 9.3

		local var_249_0 = {
			ja = 9.3,
			ko = 4.566,
			zh = 4.533,
			en = 5.766
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
				arg_249_0:Play114803062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1027ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1027ui_story == nil then
				arg_249_1.var_.characterEffect1027ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.2

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect1027ui_story and not isNil(var_252_0) then
					arg_249_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1027ui_story then
				arg_249_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_252_4 = 0

			if var_252_4 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action424")
			end

			local var_252_5 = arg_249_1.actors_["1148ui_story"]
			local var_252_6 = 0

			if var_252_6 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.characterEffect1148ui_story == nil then
				arg_249_1.var_.characterEffect1148ui_story = var_252_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_7 = 0.2

			if var_252_6 <= arg_249_1.time_ and arg_249_1.time_ < var_252_6 + var_252_7 and not isNil(var_252_5) then
				local var_252_8 = (arg_249_1.time_ - var_252_6) / var_252_7

				if arg_249_1.var_.characterEffect1148ui_story and not isNil(var_252_5) then
					local var_252_9 = Mathf.Lerp(0, 0.5, var_252_8)

					arg_249_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1148ui_story.fillRatio = var_252_9
				end
			end

			if arg_249_1.time_ >= var_252_6 + var_252_7 and arg_249_1.time_ < var_252_6 + var_252_7 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.characterEffect1148ui_story then
				local var_252_10 = 0.5

				arg_249_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1148ui_story.fillRatio = var_252_10
			end

			local var_252_11 = 0

			if var_252_11 < arg_249_1.time_ and arg_249_1.time_ <= var_252_11 + arg_252_0 then
				arg_249_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_252_12 = 0

			if var_252_12 < arg_249_1.time_ and arg_249_1.time_ <= var_252_12 + arg_252_0 then
				arg_249_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_252_13 = 0
			local var_252_14 = 0.55

			if var_252_13 < arg_249_1.time_ and arg_249_1.time_ <= var_252_13 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_15 = arg_249_1:FormatText(StoryNameCfg[56].name)

				arg_249_1.leftNameTxt_.text = var_252_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_16 = arg_249_1:GetWordFromCfg(114803061)
				local var_252_17 = arg_249_1:FormatText(var_252_16.content)

				arg_249_1.text_.text = var_252_17

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_18 = 22
				local var_252_19 = utf8.len(var_252_17)
				local var_252_20 = var_252_18 <= 0 and var_252_14 or var_252_14 * (var_252_19 / var_252_18)

				if var_252_20 > 0 and var_252_14 < var_252_20 then
					arg_249_1.talkMaxDuration = var_252_20

					if var_252_20 + var_252_13 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_20 + var_252_13
					end
				end

				arg_249_1.text_.text = var_252_17
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803061", "story_v_side_old_114803.awb") ~= 0 then
					local var_252_21 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803061", "story_v_side_old_114803.awb") / 1000

					if var_252_21 + var_252_13 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_21 + var_252_13
					end

					if var_252_16.prefab_name ~= "" and arg_249_1.actors_[var_252_16.prefab_name] ~= nil then
						local var_252_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_16.prefab_name].transform, "story_v_side_old_114803", "114803061", "story_v_side_old_114803.awb")

						arg_249_1:RecordAudio("114803061", var_252_22)
						arg_249_1:RecordAudio("114803061", var_252_22)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803061", "story_v_side_old_114803.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803061", "story_v_side_old_114803.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_23 = math.max(var_252_14, arg_249_1.talkMaxDuration)

			if var_252_13 <= arg_249_1.time_ and arg_249_1.time_ < var_252_13 + var_252_23 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_13) / var_252_23

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_13 + var_252_23 and arg_249_1.time_ < var_252_13 + var_252_23 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play114803062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 114803062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play114803063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.0166666666666667

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			local var_256_1 = arg_253_1.actors_["1027ui_story"].transform
			local var_256_2 = 0

			if var_256_2 < arg_253_1.time_ and arg_253_1.time_ <= var_256_2 + arg_256_0 then
				arg_253_1.var_.moveOldPos1027ui_story = var_256_1.localPosition
			end

			local var_256_3 = 0.001

			if var_256_2 <= arg_253_1.time_ and arg_253_1.time_ < var_256_2 + var_256_3 then
				local var_256_4 = (arg_253_1.time_ - var_256_2) / var_256_3
				local var_256_5 = Vector3.New(0, 100, 0)

				var_256_1.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1027ui_story, var_256_5, var_256_4)

				local var_256_6 = manager.ui.mainCamera.transform.position - var_256_1.position

				var_256_1.forward = Vector3.New(var_256_6.x, var_256_6.y, var_256_6.z)

				local var_256_7 = var_256_1.localEulerAngles

				var_256_7.z = 0
				var_256_7.x = 0
				var_256_1.localEulerAngles = var_256_7
			end

			if arg_253_1.time_ >= var_256_2 + var_256_3 and arg_253_1.time_ < var_256_2 + var_256_3 + arg_256_0 then
				var_256_1.localPosition = Vector3.New(0, 100, 0)

				local var_256_8 = manager.ui.mainCamera.transform.position - var_256_1.position

				var_256_1.forward = Vector3.New(var_256_8.x, var_256_8.y, var_256_8.z)

				local var_256_9 = var_256_1.localEulerAngles

				var_256_9.z = 0
				var_256_9.x = 0
				var_256_1.localEulerAngles = var_256_9
			end

			local var_256_10 = arg_253_1.actors_["1080ui_story"].transform
			local var_256_11 = 0

			if var_256_11 < arg_253_1.time_ and arg_253_1.time_ <= var_256_11 + arg_256_0 then
				arg_253_1.var_.moveOldPos1080ui_story = var_256_10.localPosition

				local var_256_12 = "1080ui_story"

				arg_253_1:ShowWeapon(arg_253_1.var_[var_256_12 .. "Animator"].transform, false)
			end

			local var_256_13 = 0.001

			if var_256_11 <= arg_253_1.time_ and arg_253_1.time_ < var_256_11 + var_256_13 then
				local var_256_14 = (arg_253_1.time_ - var_256_11) / var_256_13
				local var_256_15 = Vector3.New(0.7, -1.01, -6.05)

				var_256_10.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1080ui_story, var_256_15, var_256_14)

				local var_256_16 = manager.ui.mainCamera.transform.position - var_256_10.position

				var_256_10.forward = Vector3.New(var_256_16.x, var_256_16.y, var_256_16.z)

				local var_256_17 = var_256_10.localEulerAngles

				var_256_17.z = 0
				var_256_17.x = 0
				var_256_10.localEulerAngles = var_256_17
			end

			if arg_253_1.time_ >= var_256_11 + var_256_13 and arg_253_1.time_ < var_256_11 + var_256_13 + arg_256_0 then
				var_256_10.localPosition = Vector3.New(0.7, -1.01, -6.05)

				local var_256_18 = manager.ui.mainCamera.transform.position - var_256_10.position

				var_256_10.forward = Vector3.New(var_256_18.x, var_256_18.y, var_256_18.z)

				local var_256_19 = var_256_10.localEulerAngles

				var_256_19.z = 0
				var_256_19.x = 0
				var_256_10.localEulerAngles = var_256_19
			end

			local var_256_20 = 0.0166666666666667

			if var_256_20 < arg_253_1.time_ and arg_253_1.time_ <= var_256_20 + arg_256_0 then
				arg_253_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			local var_256_21 = 0.0166666666666667

			if var_256_21 < arg_253_1.time_ and arg_253_1.time_ <= var_256_21 + arg_256_0 then
				arg_253_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_256_22 = 0.0166666666666667

			if var_256_22 < arg_253_1.time_ and arg_253_1.time_ <= var_256_22 + arg_256_0 then
				arg_253_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_256_23 = 0
			local var_256_24 = 0.875

			if var_256_23 < arg_253_1.time_ and arg_253_1.time_ <= var_256_23 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_25 = arg_253_1:GetWordFromCfg(114803062)
				local var_256_26 = arg_253_1:FormatText(var_256_25.content)

				arg_253_1.text_.text = var_256_26

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_27 = 35
				local var_256_28 = utf8.len(var_256_26)
				local var_256_29 = var_256_27 <= 0 and var_256_24 or var_256_24 * (var_256_28 / var_256_27)

				if var_256_29 > 0 and var_256_24 < var_256_29 then
					arg_253_1.talkMaxDuration = var_256_29

					if var_256_29 + var_256_23 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_29 + var_256_23
					end
				end

				arg_253_1.text_.text = var_256_26
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_30 = math.max(var_256_24, arg_253_1.talkMaxDuration)

			if var_256_23 <= arg_253_1.time_ and arg_253_1.time_ < var_256_23 + var_256_30 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_23) / var_256_30

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_23 + var_256_30 and arg_253_1.time_ < var_256_23 + var_256_30 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play114803063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 114803063
		arg_257_1.duration_ = 7.73

		local var_257_0 = {
			ja = 7.733,
			ko = 3.166,
			zh = 2.6,
			en = 3
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
				arg_257_0:Play114803064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1148ui_story"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1148ui_story == nil then
				arg_257_1.var_.characterEffect1148ui_story = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.2

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect1148ui_story and not isNil(var_260_0) then
					arg_257_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1148ui_story then
				arg_257_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_260_4 = 0

			if var_260_4 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_260_5 = 0
			local var_260_6 = 0.225

			if var_260_5 < arg_257_1.time_ and arg_257_1.time_ <= var_260_5 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_7 = arg_257_1:FormatText(StoryNameCfg[8].name)

				arg_257_1.leftNameTxt_.text = var_260_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_8 = arg_257_1:GetWordFromCfg(114803063)
				local var_260_9 = arg_257_1:FormatText(var_260_8.content)

				arg_257_1.text_.text = var_260_9

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_10 = 9
				local var_260_11 = utf8.len(var_260_9)
				local var_260_12 = var_260_10 <= 0 and var_260_6 or var_260_6 * (var_260_11 / var_260_10)

				if var_260_12 > 0 and var_260_6 < var_260_12 then
					arg_257_1.talkMaxDuration = var_260_12

					if var_260_12 + var_260_5 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_12 + var_260_5
					end
				end

				arg_257_1.text_.text = var_260_9
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803063", "story_v_side_old_114803.awb") ~= 0 then
					local var_260_13 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803063", "story_v_side_old_114803.awb") / 1000

					if var_260_13 + var_260_5 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_5
					end

					if var_260_8.prefab_name ~= "" and arg_257_1.actors_[var_260_8.prefab_name] ~= nil then
						local var_260_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_8.prefab_name].transform, "story_v_side_old_114803", "114803063", "story_v_side_old_114803.awb")

						arg_257_1:RecordAudio("114803063", var_260_14)
						arg_257_1:RecordAudio("114803063", var_260_14)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803063", "story_v_side_old_114803.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803063", "story_v_side_old_114803.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_15 = math.max(var_260_6, arg_257_1.talkMaxDuration)

			if var_260_5 <= arg_257_1.time_ and arg_257_1.time_ < var_260_5 + var_260_15 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_5) / var_260_15

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_5 + var_260_15 and arg_257_1.time_ < var_260_5 + var_260_15 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play114803064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 114803064
		arg_261_1.duration_ = 10.8

		local var_261_0 = {
			ja = 10.8,
			ko = 6,
			zh = 8.3,
			en = 8.833
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play114803065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1080ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1080ui_story == nil then
				arg_261_1.var_.characterEffect1080ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.2

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect1080ui_story and not isNil(var_264_0) then
					arg_261_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1080ui_story then
				arg_261_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_264_4 = 0

			if var_264_4 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_264_5 = 0

			if var_264_5 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_264_6 = arg_261_1.actors_["1148ui_story"]
			local var_264_7 = 0

			if var_264_7 < arg_261_1.time_ and arg_261_1.time_ <= var_264_7 + arg_264_0 and not isNil(var_264_6) and arg_261_1.var_.characterEffect1148ui_story == nil then
				arg_261_1.var_.characterEffect1148ui_story = var_264_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_8 = 0.2

			if var_264_7 <= arg_261_1.time_ and arg_261_1.time_ < var_264_7 + var_264_8 and not isNil(var_264_6) then
				local var_264_9 = (arg_261_1.time_ - var_264_7) / var_264_8

				if arg_261_1.var_.characterEffect1148ui_story and not isNil(var_264_6) then
					local var_264_10 = Mathf.Lerp(0, 0.5, var_264_9)

					arg_261_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1148ui_story.fillRatio = var_264_10
				end
			end

			if arg_261_1.time_ >= var_264_7 + var_264_8 and arg_261_1.time_ < var_264_7 + var_264_8 + arg_264_0 and not isNil(var_264_6) and arg_261_1.var_.characterEffect1148ui_story then
				local var_264_11 = 0.5

				arg_261_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1148ui_story.fillRatio = var_264_11
			end

			local var_264_12 = 0
			local var_264_13 = 0.8

			if var_264_12 < arg_261_1.time_ and arg_261_1.time_ <= var_264_12 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_14 = arg_261_1:FormatText(StoryNameCfg[55].name)

				arg_261_1.leftNameTxt_.text = var_264_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_15 = arg_261_1:GetWordFromCfg(114803064)
				local var_264_16 = arg_261_1:FormatText(var_264_15.content)

				arg_261_1.text_.text = var_264_16

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_17 = 32
				local var_264_18 = utf8.len(var_264_16)
				local var_264_19 = var_264_17 <= 0 and var_264_13 or var_264_13 * (var_264_18 / var_264_17)

				if var_264_19 > 0 and var_264_13 < var_264_19 then
					arg_261_1.talkMaxDuration = var_264_19

					if var_264_19 + var_264_12 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_19 + var_264_12
					end
				end

				arg_261_1.text_.text = var_264_16
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803064", "story_v_side_old_114803.awb") ~= 0 then
					local var_264_20 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803064", "story_v_side_old_114803.awb") / 1000

					if var_264_20 + var_264_12 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_20 + var_264_12
					end

					if var_264_15.prefab_name ~= "" and arg_261_1.actors_[var_264_15.prefab_name] ~= nil then
						local var_264_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_15.prefab_name].transform, "story_v_side_old_114803", "114803064", "story_v_side_old_114803.awb")

						arg_261_1:RecordAudio("114803064", var_264_21)
						arg_261_1:RecordAudio("114803064", var_264_21)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803064", "story_v_side_old_114803.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803064", "story_v_side_old_114803.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_22 = math.max(var_264_13, arg_261_1.talkMaxDuration)

			if var_264_12 <= arg_261_1.time_ and arg_261_1.time_ < var_264_12 + var_264_22 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_12) / var_264_22

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_12 + var_264_22 and arg_261_1.time_ < var_264_12 + var_264_22 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play114803065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 114803065
		arg_265_1.duration_ = 2.43

		local var_265_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.433
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
				arg_265_0:Play114803066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action2_1")
			end

			local var_268_1 = arg_265_1.actors_["1148ui_story"]
			local var_268_2 = 0

			if var_268_2 < arg_265_1.time_ and arg_265_1.time_ <= var_268_2 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1148ui_story == nil then
				arg_265_1.var_.characterEffect1148ui_story = var_268_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_3 = 0.2

			if var_268_2 <= arg_265_1.time_ and arg_265_1.time_ < var_268_2 + var_268_3 and not isNil(var_268_1) then
				local var_268_4 = (arg_265_1.time_ - var_268_2) / var_268_3

				if arg_265_1.var_.characterEffect1148ui_story and not isNil(var_268_1) then
					arg_265_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_2 + var_268_3 and arg_265_1.time_ < var_268_2 + var_268_3 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1148ui_story then
				arg_265_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_268_5 = 0

			if var_268_5 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_268_6 = 0

			if var_268_6 < arg_265_1.time_ and arg_265_1.time_ <= var_268_6 + arg_268_0 then
				arg_265_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_268_7 = arg_265_1.actors_["1080ui_story"]
			local var_268_8 = 0

			if var_268_8 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 and not isNil(var_268_7) and arg_265_1.var_.characterEffect1080ui_story == nil then
				arg_265_1.var_.characterEffect1080ui_story = var_268_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_9 = 0.2

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_9 and not isNil(var_268_7) then
				local var_268_10 = (arg_265_1.time_ - var_268_8) / var_268_9

				if arg_265_1.var_.characterEffect1080ui_story and not isNil(var_268_7) then
					local var_268_11 = Mathf.Lerp(0, 0.5, var_268_10)

					arg_265_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1080ui_story.fillRatio = var_268_11
				end
			end

			if arg_265_1.time_ >= var_268_8 + var_268_9 and arg_265_1.time_ < var_268_8 + var_268_9 + arg_268_0 and not isNil(var_268_7) and arg_265_1.var_.characterEffect1080ui_story then
				local var_268_12 = 0.5

				arg_265_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1080ui_story.fillRatio = var_268_12
			end

			local var_268_13 = 0
			local var_268_14 = 0.125

			if var_268_13 < arg_265_1.time_ and arg_265_1.time_ <= var_268_13 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_15 = arg_265_1:FormatText(StoryNameCfg[8].name)

				arg_265_1.leftNameTxt_.text = var_268_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_16 = arg_265_1:GetWordFromCfg(114803065)
				local var_268_17 = arg_265_1:FormatText(var_268_16.content)

				arg_265_1.text_.text = var_268_17

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_18 = 5
				local var_268_19 = utf8.len(var_268_17)
				local var_268_20 = var_268_18 <= 0 and var_268_14 or var_268_14 * (var_268_19 / var_268_18)

				if var_268_20 > 0 and var_268_14 < var_268_20 then
					arg_265_1.talkMaxDuration = var_268_20

					if var_268_20 + var_268_13 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_20 + var_268_13
					end
				end

				arg_265_1.text_.text = var_268_17
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803065", "story_v_side_old_114803.awb") ~= 0 then
					local var_268_21 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803065", "story_v_side_old_114803.awb") / 1000

					if var_268_21 + var_268_13 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_21 + var_268_13
					end

					if var_268_16.prefab_name ~= "" and arg_265_1.actors_[var_268_16.prefab_name] ~= nil then
						local var_268_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_16.prefab_name].transform, "story_v_side_old_114803", "114803065", "story_v_side_old_114803.awb")

						arg_265_1:RecordAudio("114803065", var_268_22)
						arg_265_1:RecordAudio("114803065", var_268_22)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803065", "story_v_side_old_114803.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803065", "story_v_side_old_114803.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_23 = math.max(var_268_14, arg_265_1.talkMaxDuration)

			if var_268_13 <= arg_265_1.time_ and arg_265_1.time_ < var_268_13 + var_268_23 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_13) / var_268_23

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_13 + var_268_23 and arg_265_1.time_ < var_268_13 + var_268_23 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play114803066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 114803066
		arg_269_1.duration_ = 8.4

		local var_269_0 = {
			ja = 5.966,
			ko = 8.4,
			zh = 6.6,
			en = 7.5
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play114803067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1080ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1080ui_story == nil then
				arg_269_1.var_.characterEffect1080ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.2

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect1080ui_story and not isNil(var_272_0) then
					arg_269_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1080ui_story then
				arg_269_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_272_4 = 0

			if var_272_4 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action427")
			end

			local var_272_5 = arg_269_1.actors_["1148ui_story"]
			local var_272_6 = 0

			if var_272_6 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 and not isNil(var_272_5) and arg_269_1.var_.characterEffect1148ui_story == nil then
				arg_269_1.var_.characterEffect1148ui_story = var_272_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_7 = 0.2

			if var_272_6 <= arg_269_1.time_ and arg_269_1.time_ < var_272_6 + var_272_7 and not isNil(var_272_5) then
				local var_272_8 = (arg_269_1.time_ - var_272_6) / var_272_7

				if arg_269_1.var_.characterEffect1148ui_story and not isNil(var_272_5) then
					local var_272_9 = Mathf.Lerp(0, 0.5, var_272_8)

					arg_269_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1148ui_story.fillRatio = var_272_9
				end
			end

			if arg_269_1.time_ >= var_272_6 + var_272_7 and arg_269_1.time_ < var_272_6 + var_272_7 + arg_272_0 and not isNil(var_272_5) and arg_269_1.var_.characterEffect1148ui_story then
				local var_272_10 = 0.5

				arg_269_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1148ui_story.fillRatio = var_272_10
			end

			local var_272_11 = 0

			if var_272_11 < arg_269_1.time_ and arg_269_1.time_ <= var_272_11 + arg_272_0 then
				arg_269_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_272_12 = 0

			if var_272_12 < arg_269_1.time_ and arg_269_1.time_ <= var_272_12 + arg_272_0 then
				arg_269_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_272_13 = 0
			local var_272_14 = 0.8

			if var_272_13 < arg_269_1.time_ and arg_269_1.time_ <= var_272_13 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_15 = arg_269_1:FormatText(StoryNameCfg[55].name)

				arg_269_1.leftNameTxt_.text = var_272_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_16 = arg_269_1:GetWordFromCfg(114803066)
				local var_272_17 = arg_269_1:FormatText(var_272_16.content)

				arg_269_1.text_.text = var_272_17

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_18 = 32
				local var_272_19 = utf8.len(var_272_17)
				local var_272_20 = var_272_18 <= 0 and var_272_14 or var_272_14 * (var_272_19 / var_272_18)

				if var_272_20 > 0 and var_272_14 < var_272_20 then
					arg_269_1.talkMaxDuration = var_272_20

					if var_272_20 + var_272_13 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_20 + var_272_13
					end
				end

				arg_269_1.text_.text = var_272_17
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803066", "story_v_side_old_114803.awb") ~= 0 then
					local var_272_21 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803066", "story_v_side_old_114803.awb") / 1000

					if var_272_21 + var_272_13 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_21 + var_272_13
					end

					if var_272_16.prefab_name ~= "" and arg_269_1.actors_[var_272_16.prefab_name] ~= nil then
						local var_272_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_16.prefab_name].transform, "story_v_side_old_114803", "114803066", "story_v_side_old_114803.awb")

						arg_269_1:RecordAudio("114803066", var_272_22)
						arg_269_1:RecordAudio("114803066", var_272_22)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803066", "story_v_side_old_114803.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803066", "story_v_side_old_114803.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_23 = math.max(var_272_14, arg_269_1.talkMaxDuration)

			if var_272_13 <= arg_269_1.time_ and arg_269_1.time_ < var_272_13 + var_272_23 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_13) / var_272_23

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_13 + var_272_23 and arg_269_1.time_ < var_272_13 + var_272_23 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play114803067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 114803067
		arg_273_1.duration_ = 7.4

		local var_273_0 = {
			ja = 7.4,
			ko = 1.999999999999,
			zh = 3.333,
			en = 3.733
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
				arg_273_0:Play114803068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1148ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1148ui_story == nil then
				arg_273_1.var_.characterEffect1148ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.2

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect1148ui_story and not isNil(var_276_0) then
					arg_273_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1148ui_story then
				arg_273_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_276_4 = 0

			if var_276_4 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action427")
			end

			local var_276_5 = arg_273_1.actors_["1080ui_story"]
			local var_276_6 = 0

			if var_276_6 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 and not isNil(var_276_5) and arg_273_1.var_.characterEffect1080ui_story == nil then
				arg_273_1.var_.characterEffect1080ui_story = var_276_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_7 = 0.2

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_7 and not isNil(var_276_5) then
				local var_276_8 = (arg_273_1.time_ - var_276_6) / var_276_7

				if arg_273_1.var_.characterEffect1080ui_story and not isNil(var_276_5) then
					local var_276_9 = Mathf.Lerp(0, 0.5, var_276_8)

					arg_273_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1080ui_story.fillRatio = var_276_9
				end
			end

			if arg_273_1.time_ >= var_276_6 + var_276_7 and arg_273_1.time_ < var_276_6 + var_276_7 + arg_276_0 and not isNil(var_276_5) and arg_273_1.var_.characterEffect1080ui_story then
				local var_276_10 = 0.5

				arg_273_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1080ui_story.fillRatio = var_276_10
			end

			local var_276_11 = 0

			if var_276_11 < arg_273_1.time_ and arg_273_1.time_ <= var_276_11 + arg_276_0 then
				arg_273_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_276_12 = 0
			local var_276_13 = 0.3

			if var_276_12 < arg_273_1.time_ and arg_273_1.time_ <= var_276_12 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_14 = arg_273_1:FormatText(StoryNameCfg[8].name)

				arg_273_1.leftNameTxt_.text = var_276_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_15 = arg_273_1:GetWordFromCfg(114803067)
				local var_276_16 = arg_273_1:FormatText(var_276_15.content)

				arg_273_1.text_.text = var_276_16

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_17 = 12
				local var_276_18 = utf8.len(var_276_16)
				local var_276_19 = var_276_17 <= 0 and var_276_13 or var_276_13 * (var_276_18 / var_276_17)

				if var_276_19 > 0 and var_276_13 < var_276_19 then
					arg_273_1.talkMaxDuration = var_276_19

					if var_276_19 + var_276_12 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_19 + var_276_12
					end
				end

				arg_273_1.text_.text = var_276_16
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803067", "story_v_side_old_114803.awb") ~= 0 then
					local var_276_20 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803067", "story_v_side_old_114803.awb") / 1000

					if var_276_20 + var_276_12 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_20 + var_276_12
					end

					if var_276_15.prefab_name ~= "" and arg_273_1.actors_[var_276_15.prefab_name] ~= nil then
						local var_276_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_15.prefab_name].transform, "story_v_side_old_114803", "114803067", "story_v_side_old_114803.awb")

						arg_273_1:RecordAudio("114803067", var_276_21)
						arg_273_1:RecordAudio("114803067", var_276_21)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803067", "story_v_side_old_114803.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803067", "story_v_side_old_114803.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_22 = math.max(var_276_13, arg_273_1.talkMaxDuration)

			if var_276_12 <= arg_273_1.time_ and arg_273_1.time_ < var_276_12 + var_276_22 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_12) / var_276_22

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_12 + var_276_22 and arg_273_1.time_ < var_276_12 + var_276_22 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play114803068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 114803068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play114803069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1080ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos1080ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(0, 100, 0)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1080ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0, 100, 0)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = arg_277_1.actors_["1148ui_story"].transform
			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 then
				arg_277_1.var_.moveOldPos1148ui_story = var_280_9.localPosition

				local var_280_11 = "1148ui_story"

				arg_277_1:ShowWeapon(arg_277_1.var_[var_280_11 .. "Animator"].transform, false)
			end

			local var_280_12 = 0.001

			if var_280_10 <= arg_277_1.time_ and arg_277_1.time_ < var_280_10 + var_280_12 then
				local var_280_13 = (arg_277_1.time_ - var_280_10) / var_280_12
				local var_280_14 = Vector3.New(0, -0.8, -6.2)

				var_280_9.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1148ui_story, var_280_14, var_280_13)

				local var_280_15 = manager.ui.mainCamera.transform.position - var_280_9.position

				var_280_9.forward = Vector3.New(var_280_15.x, var_280_15.y, var_280_15.z)

				local var_280_16 = var_280_9.localEulerAngles

				var_280_16.z = 0
				var_280_16.x = 0
				var_280_9.localEulerAngles = var_280_16
			end

			if arg_277_1.time_ >= var_280_10 + var_280_12 and arg_277_1.time_ < var_280_10 + var_280_12 + arg_280_0 then
				var_280_9.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_280_17 = manager.ui.mainCamera.transform.position - var_280_9.position

				var_280_9.forward = Vector3.New(var_280_17.x, var_280_17.y, var_280_17.z)

				local var_280_18 = var_280_9.localEulerAngles

				var_280_18.z = 0
				var_280_18.x = 0
				var_280_9.localEulerAngles = var_280_18
			end

			local var_280_19 = 0.0166666666666667

			if var_280_19 < arg_277_1.time_ and arg_277_1.time_ <= var_280_19 + arg_280_0 then
				arg_277_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_280_20 = 0.0166666666666667

			if var_280_20 < arg_277_1.time_ and arg_277_1.time_ <= var_280_20 + arg_280_0 then
				arg_277_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_280_21 = 0
			local var_280_22 = 0.8

			if var_280_21 < arg_277_1.time_ and arg_277_1.time_ <= var_280_21 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_23 = arg_277_1:GetWordFromCfg(114803068)
				local var_280_24 = arg_277_1:FormatText(var_280_23.content)

				arg_277_1.text_.text = var_280_24

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_25 = 32
				local var_280_26 = utf8.len(var_280_24)
				local var_280_27 = var_280_25 <= 0 and var_280_22 or var_280_22 * (var_280_26 / var_280_25)

				if var_280_27 > 0 and var_280_22 < var_280_27 then
					arg_277_1.talkMaxDuration = var_280_27

					if var_280_27 + var_280_21 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_27 + var_280_21
					end
				end

				arg_277_1.text_.text = var_280_24
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_28 = math.max(var_280_22, arg_277_1.talkMaxDuration)

			if var_280_21 <= arg_277_1.time_ and arg_277_1.time_ < var_280_21 + var_280_28 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_21) / var_280_28

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_21 + var_280_28 and arg_277_1.time_ < var_280_21 + var_280_28 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play114803069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 114803069
		arg_281_1.duration_ = 8.5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play114803070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 1.5

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				local var_284_1 = manager.ui.mainCamera.transform.localPosition
				local var_284_2 = Vector3.New(0, 0, 10) + Vector3.New(var_284_1.x, var_284_1.y, 0)
				local var_284_3 = arg_281_1.bgs_.ST01

				var_284_3.transform.localPosition = var_284_2
				var_284_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_284_4 = var_284_3:GetComponent("SpriteRenderer")

				if var_284_4 and var_284_4.sprite then
					local var_284_5 = (var_284_3.transform.localPosition - var_284_1).z
					local var_284_6 = manager.ui.mainCameraCom_
					local var_284_7 = 2 * var_284_5 * Mathf.Tan(var_284_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_284_8 = var_284_7 * var_284_6.aspect
					local var_284_9 = var_284_4.sprite.bounds.size.x
					local var_284_10 = var_284_4.sprite.bounds.size.y
					local var_284_11 = var_284_8 / var_284_9
					local var_284_12 = var_284_7 / var_284_10
					local var_284_13 = var_284_12 < var_284_11 and var_284_11 or var_284_12

					var_284_3.transform.localScale = Vector3.New(var_284_13, var_284_13, 0)
				end

				for iter_284_0, iter_284_1 in pairs(arg_281_1.bgs_) do
					if iter_284_0 ~= "ST01" then
						iter_284_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_284_14 = arg_281_1.actors_["1148ui_story"].transform
			local var_284_15 = 0

			if var_284_15 < arg_281_1.time_ and arg_281_1.time_ <= var_284_15 + arg_284_0 then
				arg_281_1.var_.moveOldPos1148ui_story = var_284_14.localPosition
			end

			local var_284_16 = 0.001

			if var_284_15 <= arg_281_1.time_ and arg_281_1.time_ < var_284_15 + var_284_16 then
				local var_284_17 = (arg_281_1.time_ - var_284_15) / var_284_16
				local var_284_18 = Vector3.New(0, 100, 0)

				var_284_14.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1148ui_story, var_284_18, var_284_17)

				local var_284_19 = manager.ui.mainCamera.transform.position - var_284_14.position

				var_284_14.forward = Vector3.New(var_284_19.x, var_284_19.y, var_284_19.z)

				local var_284_20 = var_284_14.localEulerAngles

				var_284_20.z = 0
				var_284_20.x = 0
				var_284_14.localEulerAngles = var_284_20
			end

			if arg_281_1.time_ >= var_284_15 + var_284_16 and arg_281_1.time_ < var_284_15 + var_284_16 + arg_284_0 then
				var_284_14.localPosition = Vector3.New(0, 100, 0)

				local var_284_21 = manager.ui.mainCamera.transform.position - var_284_14.position

				var_284_14.forward = Vector3.New(var_284_21.x, var_284_21.y, var_284_21.z)

				local var_284_22 = var_284_14.localEulerAngles

				var_284_22.z = 0
				var_284_22.x = 0
				var_284_14.localEulerAngles = var_284_22
			end

			local var_284_23 = arg_281_1.bgs_.ST02
			local var_284_24 = 0

			if var_284_24 < arg_281_1.time_ and arg_281_1.time_ <= var_284_24 + arg_284_0 then
				local var_284_25 = var_284_23:GetComponent("SpriteRenderer")

				if var_284_25 then
					arg_281_1.var_.alphaOldValueST02 = var_284_25.color.a
					arg_281_1.var_.alphaMatValueST02 = var_284_25
				end

				arg_281_1.var_.alphaOldValueST02 = 1
			end

			local var_284_26 = 1.5

			if var_284_24 <= arg_281_1.time_ and arg_281_1.time_ < var_284_24 + var_284_26 then
				local var_284_27 = (arg_281_1.time_ - var_284_24) / var_284_26
				local var_284_28 = Mathf.Lerp(arg_281_1.var_.alphaOldValueST02, 0, var_284_27)

				if arg_281_1.var_.alphaMatValueST02 then
					local var_284_29 = arg_281_1.var_.alphaMatValueST02.color

					var_284_29.a = var_284_28
					arg_281_1.var_.alphaMatValueST02.color = var_284_29
				end
			end

			if arg_281_1.time_ >= var_284_24 + var_284_26 and arg_281_1.time_ < var_284_24 + var_284_26 + arg_284_0 and arg_281_1.var_.alphaMatValueST02 then
				local var_284_30 = arg_281_1.var_.alphaMatValueST02
				local var_284_31 = var_284_30.color

				var_284_31.a = 0
				var_284_30.color = var_284_31
			end

			local var_284_32 = arg_281_1.bgs_.ST01
			local var_284_33 = 1.5

			if var_284_33 < arg_281_1.time_ and arg_281_1.time_ <= var_284_33 + arg_284_0 then
				local var_284_34 = var_284_32:GetComponent("SpriteRenderer")

				if var_284_34 then
					arg_281_1.var_.alphaOldValueST01 = var_284_34.color.a
					arg_281_1.var_.alphaMatValueST01 = var_284_34
				end

				arg_281_1.var_.alphaOldValueST01 = 0
			end

			local var_284_35 = 1.5

			if var_284_33 <= arg_281_1.time_ and arg_281_1.time_ < var_284_33 + var_284_35 then
				local var_284_36 = (arg_281_1.time_ - var_284_33) / var_284_35
				local var_284_37 = Mathf.Lerp(arg_281_1.var_.alphaOldValueST01, 1, var_284_36)

				if arg_281_1.var_.alphaMatValueST01 then
					local var_284_38 = arg_281_1.var_.alphaMatValueST01.color

					var_284_38.a = var_284_37
					arg_281_1.var_.alphaMatValueST01.color = var_284_38
				end
			end

			if arg_281_1.time_ >= var_284_33 + var_284_35 and arg_281_1.time_ < var_284_33 + var_284_35 + arg_284_0 and arg_281_1.var_.alphaMatValueST01 then
				local var_284_39 = arg_281_1.var_.alphaMatValueST01
				local var_284_40 = var_284_39.color

				var_284_40.a = 1
				var_284_39.color = var_284_40
			end

			if arg_281_1.frameCnt_ <= 1 then
				arg_281_1.dialog_:SetActive(false)
			end

			local var_284_41 = 3.5
			local var_284_42 = 0.95

			if var_284_41 < arg_281_1.time_ and arg_281_1.time_ <= var_284_41 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0

				arg_281_1.dialog_:SetActive(true)

				arg_281_1.dialogCg_.alpha = 0

				local var_284_43 = LeanTween.value(arg_281_1.dialog_, 0, 1, 0.3)

				var_284_43:setOnUpdate(LuaHelper.FloatAction(function(arg_285_0)
					arg_281_1.dialogCg_.alpha = arg_285_0
				end))
				var_284_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_281_1.dialog_)
					var_284_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_281_1.duration_ = arg_281_1.duration_ + 0.3

				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_44 = arg_281_1:GetWordFromCfg(114803069)
				local var_284_45 = arg_281_1:FormatText(var_284_44.content)

				arg_281_1.text_.text = var_284_45

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_46 = 38
				local var_284_47 = utf8.len(var_284_45)
				local var_284_48 = var_284_46 <= 0 and var_284_42 or var_284_42 * (var_284_47 / var_284_46)

				if var_284_48 > 0 and var_284_42 < var_284_48 then
					arg_281_1.talkMaxDuration = var_284_48
					var_284_41 = var_284_41 + 0.3

					if var_284_48 + var_284_41 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_48 + var_284_41
					end
				end

				arg_281_1.text_.text = var_284_45
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_49 = var_284_41 + 0.3
			local var_284_50 = math.max(var_284_42, arg_281_1.talkMaxDuration)

			if var_284_49 <= arg_281_1.time_ and arg_281_1.time_ < var_284_49 + var_284_50 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_49) / var_284_50

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_49 + var_284_50 and arg_281_1.time_ < var_284_49 + var_284_50 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play114803070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 114803070
		arg_287_1.duration_ = 9.13

		local var_287_0 = {
			ja = 9.133,
			ko = 5.7,
			zh = 5.866,
			en = 6.2
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
				arg_287_0:Play114803071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1148ui_story"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos1148ui_story = var_290_0.localPosition

				local var_290_2 = "1148ui_story"

				arg_287_1:ShowWeapon(arg_287_1.var_[var_290_2 .. "Animator"].transform, false)
			end

			local var_290_3 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_3 then
				local var_290_4 = (arg_287_1.time_ - var_290_1) / var_290_3
				local var_290_5 = Vector3.New(0, -0.8, -6.2)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1148ui_story, var_290_5, var_290_4)

				local var_290_6 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_6.x, var_290_6.y, var_290_6.z)

				local var_290_7 = var_290_0.localEulerAngles

				var_290_7.z = 0
				var_290_7.x = 0
				var_290_0.localEulerAngles = var_290_7
			end

			if arg_287_1.time_ >= var_290_1 + var_290_3 and arg_287_1.time_ < var_290_1 + var_290_3 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_290_8 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_8.x, var_290_8.y, var_290_8.z)

				local var_290_9 = var_290_0.localEulerAngles

				var_290_9.z = 0
				var_290_9.x = 0
				var_290_0.localEulerAngles = var_290_9
			end

			local var_290_10 = arg_287_1.actors_["1148ui_story"]
			local var_290_11 = 0

			if var_290_11 < arg_287_1.time_ and arg_287_1.time_ <= var_290_11 + arg_290_0 and not isNil(var_290_10) and arg_287_1.var_.characterEffect1148ui_story == nil then
				arg_287_1.var_.characterEffect1148ui_story = var_290_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_12 = 0.2

			if var_290_11 <= arg_287_1.time_ and arg_287_1.time_ < var_290_11 + var_290_12 and not isNil(var_290_10) then
				local var_290_13 = (arg_287_1.time_ - var_290_11) / var_290_12

				if arg_287_1.var_.characterEffect1148ui_story and not isNil(var_290_10) then
					arg_287_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_11 + var_290_12 and arg_287_1.time_ < var_290_11 + var_290_12 + arg_290_0 and not isNil(var_290_10) and arg_287_1.var_.characterEffect1148ui_story then
				arg_287_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_290_14 = 0.0166666666666667

			if var_290_14 < arg_287_1.time_ and arg_287_1.time_ <= var_290_14 + arg_290_0 then
				arg_287_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_290_15 = 0.0166666666666667

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				arg_287_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_290_16 = 0
			local var_290_17 = 0.625

			if var_290_16 < arg_287_1.time_ and arg_287_1.time_ <= var_290_16 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_18 = arg_287_1:FormatText(StoryNameCfg[8].name)

				arg_287_1.leftNameTxt_.text = var_290_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_19 = arg_287_1:GetWordFromCfg(114803070)
				local var_290_20 = arg_287_1:FormatText(var_290_19.content)

				arg_287_1.text_.text = var_290_20

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_21 = 25
				local var_290_22 = utf8.len(var_290_20)
				local var_290_23 = var_290_21 <= 0 and var_290_17 or var_290_17 * (var_290_22 / var_290_21)

				if var_290_23 > 0 and var_290_17 < var_290_23 then
					arg_287_1.talkMaxDuration = var_290_23

					if var_290_23 + var_290_16 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_23 + var_290_16
					end
				end

				arg_287_1.text_.text = var_290_20
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803070", "story_v_side_old_114803.awb") ~= 0 then
					local var_290_24 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803070", "story_v_side_old_114803.awb") / 1000

					if var_290_24 + var_290_16 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_24 + var_290_16
					end

					if var_290_19.prefab_name ~= "" and arg_287_1.actors_[var_290_19.prefab_name] ~= nil then
						local var_290_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_19.prefab_name].transform, "story_v_side_old_114803", "114803070", "story_v_side_old_114803.awb")

						arg_287_1:RecordAudio("114803070", var_290_25)
						arg_287_1:RecordAudio("114803070", var_290_25)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803070", "story_v_side_old_114803.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803070", "story_v_side_old_114803.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_26 = math.max(var_290_17, arg_287_1.talkMaxDuration)

			if var_290_16 <= arg_287_1.time_ and arg_287_1.time_ < var_290_16 + var_290_26 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_16) / var_290_26

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_16 + var_290_26 and arg_287_1.time_ < var_290_16 + var_290_26 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play114803071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 114803071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play114803072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_2")
			end

			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_294_2 = 0
			local var_294_3 = 1.35

			if var_294_2 < arg_291_1.time_ and arg_291_1.time_ <= var_294_2 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_4 = arg_291_1:GetWordFromCfg(114803071)
				local var_294_5 = arg_291_1:FormatText(var_294_4.content)

				arg_291_1.text_.text = var_294_5

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_6 = 54
				local var_294_7 = utf8.len(var_294_5)
				local var_294_8 = var_294_6 <= 0 and var_294_3 or var_294_3 * (var_294_7 / var_294_6)

				if var_294_8 > 0 and var_294_3 < var_294_8 then
					arg_291_1.talkMaxDuration = var_294_8

					if var_294_8 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_2
					end
				end

				arg_291_1.text_.text = var_294_5
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_9 = math.max(var_294_3, arg_291_1.talkMaxDuration)

			if var_294_2 <= arg_291_1.time_ and arg_291_1.time_ < var_294_2 + var_294_9 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_2) / var_294_9

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_2 + var_294_9 and arg_291_1.time_ < var_294_2 + var_294_9 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play114803072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 114803072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play114803073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_298_1 = 0
			local var_298_2 = 0.25

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_3 = arg_295_1:GetWordFromCfg(114803072)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 10
				local var_298_6 = utf8.len(var_298_4)
				local var_298_7 = var_298_5 <= 0 and var_298_2 or var_298_2 * (var_298_6 / var_298_5)

				if var_298_7 > 0 and var_298_2 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_1 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_1
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_8 = math.max(var_298_2, arg_295_1.talkMaxDuration)

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_8 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_1) / var_298_8

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_1 + var_298_8 and arg_295_1.time_ < var_298_1 + var_298_8 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play114803073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 114803073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play114803074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1148ui_story"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1148ui_story == nil then
				arg_299_1.var_.characterEffect1148ui_story = var_302_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.2

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.characterEffect1148ui_story and not isNil(var_302_0) then
					local var_302_4 = Mathf.Lerp(0, 0.5, var_302_3)

					arg_299_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1148ui_story.fillRatio = var_302_4
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1148ui_story then
				local var_302_5 = 0.5

				arg_299_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1148ui_story.fillRatio = var_302_5
			end

			local var_302_6 = 0

			if var_302_6 < arg_299_1.time_ and arg_299_1.time_ <= var_302_6 + arg_302_0 then
				arg_299_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_302_7 = 0
			local var_302_8 = 0.125

			if var_302_7 < arg_299_1.time_ and arg_299_1.time_ <= var_302_7 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_9 = arg_299_1:FormatText(StoryNameCfg[7].name)

				arg_299_1.leftNameTxt_.text = var_302_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_10 = arg_299_1:GetWordFromCfg(114803073)
				local var_302_11 = arg_299_1:FormatText(var_302_10.content)

				arg_299_1.text_.text = var_302_11

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_12 = 5
				local var_302_13 = utf8.len(var_302_11)
				local var_302_14 = var_302_12 <= 0 and var_302_8 or var_302_8 * (var_302_13 / var_302_12)

				if var_302_14 > 0 and var_302_8 < var_302_14 then
					arg_299_1.talkMaxDuration = var_302_14

					if var_302_14 + var_302_7 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_14 + var_302_7
					end
				end

				arg_299_1.text_.text = var_302_11
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_15 = math.max(var_302_8, arg_299_1.talkMaxDuration)

			if var_302_7 <= arg_299_1.time_ and arg_299_1.time_ < var_302_7 + var_302_15 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_7) / var_302_15

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_7 + var_302_15 and arg_299_1.time_ < var_302_7 + var_302_15 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play114803074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 114803074
		arg_303_1.duration_ = 8.7

		local var_303_0 = {
			ja = 8.7,
			ko = 5.066,
			zh = 4.8,
			en = 6.933
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
				arg_303_0:Play114803075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1148ui_story"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1148ui_story == nil then
				arg_303_1.var_.characterEffect1148ui_story = var_306_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.2

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.characterEffect1148ui_story and not isNil(var_306_0) then
					arg_303_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1148ui_story then
				arg_303_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_306_4 = 0

			if var_306_4 < arg_303_1.time_ and arg_303_1.time_ <= var_306_4 + arg_306_0 then
				arg_303_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_306_5 = 0

			if var_306_5 < arg_303_1.time_ and arg_303_1.time_ <= var_306_5 + arg_306_0 then
				arg_303_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_306_6 = 0
			local var_306_7 = 0.55

			if var_306_6 < arg_303_1.time_ and arg_303_1.time_ <= var_306_6 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_8 = arg_303_1:FormatText(StoryNameCfg[8].name)

				arg_303_1.leftNameTxt_.text = var_306_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_9 = arg_303_1:GetWordFromCfg(114803074)
				local var_306_10 = arg_303_1:FormatText(var_306_9.content)

				arg_303_1.text_.text = var_306_10

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_11 = 22
				local var_306_12 = utf8.len(var_306_10)
				local var_306_13 = var_306_11 <= 0 and var_306_7 or var_306_7 * (var_306_12 / var_306_11)

				if var_306_13 > 0 and var_306_7 < var_306_13 then
					arg_303_1.talkMaxDuration = var_306_13

					if var_306_13 + var_306_6 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_13 + var_306_6
					end
				end

				arg_303_1.text_.text = var_306_10
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803074", "story_v_side_old_114803.awb") ~= 0 then
					local var_306_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803074", "story_v_side_old_114803.awb") / 1000

					if var_306_14 + var_306_6 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_14 + var_306_6
					end

					if var_306_9.prefab_name ~= "" and arg_303_1.actors_[var_306_9.prefab_name] ~= nil then
						local var_306_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_9.prefab_name].transform, "story_v_side_old_114803", "114803074", "story_v_side_old_114803.awb")

						arg_303_1:RecordAudio("114803074", var_306_15)
						arg_303_1:RecordAudio("114803074", var_306_15)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803074", "story_v_side_old_114803.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803074", "story_v_side_old_114803.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_16 = math.max(var_306_7, arg_303_1.talkMaxDuration)

			if var_306_6 <= arg_303_1.time_ and arg_303_1.time_ < var_306_6 + var_306_16 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_6) / var_306_16

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_6 + var_306_16 and arg_303_1.time_ < var_306_6 + var_306_16 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play114803075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 114803075
		arg_307_1.duration_ = 7.3

		local var_307_0 = {
			ja = 7.3,
			ko = 5.333,
			zh = 5.433,
			en = 7.3
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play114803076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_310_1 = 0
			local var_310_2 = 0.75

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_3 = arg_307_1:FormatText(StoryNameCfg[8].name)

				arg_307_1.leftNameTxt_.text = var_310_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_4 = arg_307_1:GetWordFromCfg(114803075)
				local var_310_5 = arg_307_1:FormatText(var_310_4.content)

				arg_307_1.text_.text = var_310_5

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_6 = 30
				local var_310_7 = utf8.len(var_310_5)
				local var_310_8 = var_310_6 <= 0 and var_310_2 or var_310_2 * (var_310_7 / var_310_6)

				if var_310_8 > 0 and var_310_2 < var_310_8 then
					arg_307_1.talkMaxDuration = var_310_8

					if var_310_8 + var_310_1 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_1
					end
				end

				arg_307_1.text_.text = var_310_5
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803075", "story_v_side_old_114803.awb") ~= 0 then
					local var_310_9 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803075", "story_v_side_old_114803.awb") / 1000

					if var_310_9 + var_310_1 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_9 + var_310_1
					end

					if var_310_4.prefab_name ~= "" and arg_307_1.actors_[var_310_4.prefab_name] ~= nil then
						local var_310_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_4.prefab_name].transform, "story_v_side_old_114803", "114803075", "story_v_side_old_114803.awb")

						arg_307_1:RecordAudio("114803075", var_310_10)
						arg_307_1:RecordAudio("114803075", var_310_10)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803075", "story_v_side_old_114803.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803075", "story_v_side_old_114803.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_11 = math.max(var_310_2, arg_307_1.talkMaxDuration)

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_11 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_1) / var_310_11

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_1 + var_310_11 and arg_307_1.time_ < var_310_1 + var_310_11 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play114803076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 114803076
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play114803077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1148ui_story"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1148ui_story == nil then
				arg_311_1.var_.characterEffect1148ui_story = var_314_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.2

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.characterEffect1148ui_story and not isNil(var_314_0) then
					local var_314_4 = Mathf.Lerp(0, 0.5, var_314_3)

					arg_311_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1148ui_story.fillRatio = var_314_4
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1148ui_story then
				local var_314_5 = 0.5

				arg_311_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1148ui_story.fillRatio = var_314_5
			end

			local var_314_6 = 0

			if var_314_6 < arg_311_1.time_ and arg_311_1.time_ <= var_314_6 + arg_314_0 then
				arg_311_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_314_7 = 0
			local var_314_8 = 0.25

			if var_314_7 < arg_311_1.time_ and arg_311_1.time_ <= var_314_7 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_9 = arg_311_1:FormatText(StoryNameCfg[7].name)

				arg_311_1.leftNameTxt_.text = var_314_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_10 = arg_311_1:GetWordFromCfg(114803076)
				local var_314_11 = arg_311_1:FormatText(var_314_10.content)

				arg_311_1.text_.text = var_314_11

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_12 = 10
				local var_314_13 = utf8.len(var_314_11)
				local var_314_14 = var_314_12 <= 0 and var_314_8 or var_314_8 * (var_314_13 / var_314_12)

				if var_314_14 > 0 and var_314_8 < var_314_14 then
					arg_311_1.talkMaxDuration = var_314_14

					if var_314_14 + var_314_7 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_14 + var_314_7
					end
				end

				arg_311_1.text_.text = var_314_11
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_15 = math.max(var_314_8, arg_311_1.talkMaxDuration)

			if var_314_7 <= arg_311_1.time_ and arg_311_1.time_ < var_314_7 + var_314_15 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_7) / var_314_15

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_7 + var_314_15 and arg_311_1.time_ < var_314_7 + var_314_15 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play114803077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 114803077
		arg_315_1.duration_ = 6.37

		local var_315_0 = {
			ja = 5.766,
			ko = 6.366,
			zh = 5.233,
			en = 5.7
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
				arg_315_0:Play114803078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1148ui_story"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect1148ui_story == nil then
				arg_315_1.var_.characterEffect1148ui_story = var_318_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.2

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.characterEffect1148ui_story and not isNil(var_318_0) then
					arg_315_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect1148ui_story then
				arg_315_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_318_4 = 0

			if var_318_4 < arg_315_1.time_ and arg_315_1.time_ <= var_318_4 + arg_318_0 then
				arg_315_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action445")
			end

			local var_318_5 = 0

			if var_318_5 < arg_315_1.time_ and arg_315_1.time_ <= var_318_5 + arg_318_0 then
				arg_315_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_318_6 = 0
			local var_318_7 = 0.625

			if var_318_6 < arg_315_1.time_ and arg_315_1.time_ <= var_318_6 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_8 = arg_315_1:FormatText(StoryNameCfg[8].name)

				arg_315_1.leftNameTxt_.text = var_318_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_9 = arg_315_1:GetWordFromCfg(114803077)
				local var_318_10 = arg_315_1:FormatText(var_318_9.content)

				arg_315_1.text_.text = var_318_10

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_11 = 25
				local var_318_12 = utf8.len(var_318_10)
				local var_318_13 = var_318_11 <= 0 and var_318_7 or var_318_7 * (var_318_12 / var_318_11)

				if var_318_13 > 0 and var_318_7 < var_318_13 then
					arg_315_1.talkMaxDuration = var_318_13

					if var_318_13 + var_318_6 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_13 + var_318_6
					end
				end

				arg_315_1.text_.text = var_318_10
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803077", "story_v_side_old_114803.awb") ~= 0 then
					local var_318_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803077", "story_v_side_old_114803.awb") / 1000

					if var_318_14 + var_318_6 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_14 + var_318_6
					end

					if var_318_9.prefab_name ~= "" and arg_315_1.actors_[var_318_9.prefab_name] ~= nil then
						local var_318_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_9.prefab_name].transform, "story_v_side_old_114803", "114803077", "story_v_side_old_114803.awb")

						arg_315_1:RecordAudio("114803077", var_318_15)
						arg_315_1:RecordAudio("114803077", var_318_15)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803077", "story_v_side_old_114803.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803077", "story_v_side_old_114803.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_16 = math.max(var_318_7, arg_315_1.talkMaxDuration)

			if var_318_6 <= arg_315_1.time_ and arg_315_1.time_ < var_318_6 + var_318_16 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_6) / var_318_16

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_6 + var_318_16 and arg_315_1.time_ < var_318_6 + var_318_16 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play114803078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 114803078
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play114803079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["1148ui_story"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1148ui_story == nil then
				arg_319_1.var_.characterEffect1148ui_story = var_322_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.2

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.characterEffect1148ui_story and not isNil(var_322_0) then
					local var_322_4 = Mathf.Lerp(0, 0.5, var_322_3)

					arg_319_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1148ui_story.fillRatio = var_322_4
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1148ui_story then
				local var_322_5 = 0.5

				arg_319_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1148ui_story.fillRatio = var_322_5
			end

			local var_322_6 = 0

			if var_322_6 < arg_319_1.time_ and arg_319_1.time_ <= var_322_6 + arg_322_0 then
				arg_319_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_322_7 = 0
			local var_322_8 = 0.225

			if var_322_7 < arg_319_1.time_ and arg_319_1.time_ <= var_322_7 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_9 = arg_319_1:FormatText(StoryNameCfg[7].name)

				arg_319_1.leftNameTxt_.text = var_322_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_10 = arg_319_1:GetWordFromCfg(114803078)
				local var_322_11 = arg_319_1:FormatText(var_322_10.content)

				arg_319_1.text_.text = var_322_11

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_12 = 9
				local var_322_13 = utf8.len(var_322_11)
				local var_322_14 = var_322_12 <= 0 and var_322_8 or var_322_8 * (var_322_13 / var_322_12)

				if var_322_14 > 0 and var_322_8 < var_322_14 then
					arg_319_1.talkMaxDuration = var_322_14

					if var_322_14 + var_322_7 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_14 + var_322_7
					end
				end

				arg_319_1.text_.text = var_322_11
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_15 = math.max(var_322_8, arg_319_1.talkMaxDuration)

			if var_322_7 <= arg_319_1.time_ and arg_319_1.time_ < var_322_7 + var_322_15 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_7) / var_322_15

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_7 + var_322_15 and arg_319_1.time_ < var_322_7 + var_322_15 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play114803079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 114803079
		arg_323_1.duration_ = 12.63

		local var_323_0 = {
			ja = 7.4,
			ko = 9.2,
			zh = 11.2,
			en = 12.633
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
				arg_323_0:Play114803080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1148ui_story"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1148ui_story == nil then
				arg_323_1.var_.characterEffect1148ui_story = var_326_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.2

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.characterEffect1148ui_story and not isNil(var_326_0) then
					arg_323_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1148ui_story then
				arg_323_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_326_4 = 0

			if var_326_4 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action456")
			end

			local var_326_5 = 0

			if var_326_5 < arg_323_1.time_ and arg_323_1.time_ <= var_326_5 + arg_326_0 then
				arg_323_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_326_6 = 0
			local var_326_7 = 1.125

			if var_326_6 < arg_323_1.time_ and arg_323_1.time_ <= var_326_6 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_8 = arg_323_1:FormatText(StoryNameCfg[8].name)

				arg_323_1.leftNameTxt_.text = var_326_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_9 = arg_323_1:GetWordFromCfg(114803079)
				local var_326_10 = arg_323_1:FormatText(var_326_9.content)

				arg_323_1.text_.text = var_326_10

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_11 = 45
				local var_326_12 = utf8.len(var_326_10)
				local var_326_13 = var_326_11 <= 0 and var_326_7 or var_326_7 * (var_326_12 / var_326_11)

				if var_326_13 > 0 and var_326_7 < var_326_13 then
					arg_323_1.talkMaxDuration = var_326_13

					if var_326_13 + var_326_6 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_13 + var_326_6
					end
				end

				arg_323_1.text_.text = var_326_10
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803079", "story_v_side_old_114803.awb") ~= 0 then
					local var_326_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803079", "story_v_side_old_114803.awb") / 1000

					if var_326_14 + var_326_6 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_14 + var_326_6
					end

					if var_326_9.prefab_name ~= "" and arg_323_1.actors_[var_326_9.prefab_name] ~= nil then
						local var_326_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_9.prefab_name].transform, "story_v_side_old_114803", "114803079", "story_v_side_old_114803.awb")

						arg_323_1:RecordAudio("114803079", var_326_15)
						arg_323_1:RecordAudio("114803079", var_326_15)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803079", "story_v_side_old_114803.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803079", "story_v_side_old_114803.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_16 = math.max(var_326_7, arg_323_1.talkMaxDuration)

			if var_326_6 <= arg_323_1.time_ and arg_323_1.time_ < var_326_6 + var_326_16 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_6) / var_326_16

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_6 + var_326_16 and arg_323_1.time_ < var_326_6 + var_326_16 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play114803080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 114803080
		arg_327_1.duration_ = 8.53

		local var_327_0 = {
			ja = 8.533,
			ko = 3.9,
			zh = 4.4,
			en = 3.6
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
				arg_327_0:Play114803081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0

			if var_330_0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				arg_327_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action463")
			end

			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_330_2 = 0
			local var_330_3 = 0.35

			if var_330_2 < arg_327_1.time_ and arg_327_1.time_ <= var_330_2 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_4 = arg_327_1:FormatText(StoryNameCfg[8].name)

				arg_327_1.leftNameTxt_.text = var_330_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_5 = arg_327_1:GetWordFromCfg(114803080)
				local var_330_6 = arg_327_1:FormatText(var_330_5.content)

				arg_327_1.text_.text = var_330_6

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_7 = 14
				local var_330_8 = utf8.len(var_330_6)
				local var_330_9 = var_330_7 <= 0 and var_330_3 or var_330_3 * (var_330_8 / var_330_7)

				if var_330_9 > 0 and var_330_3 < var_330_9 then
					arg_327_1.talkMaxDuration = var_330_9

					if var_330_9 + var_330_2 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_9 + var_330_2
					end
				end

				arg_327_1.text_.text = var_330_6
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803080", "story_v_side_old_114803.awb") ~= 0 then
					local var_330_10 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803080", "story_v_side_old_114803.awb") / 1000

					if var_330_10 + var_330_2 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_10 + var_330_2
					end

					if var_330_5.prefab_name ~= "" and arg_327_1.actors_[var_330_5.prefab_name] ~= nil then
						local var_330_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_5.prefab_name].transform, "story_v_side_old_114803", "114803080", "story_v_side_old_114803.awb")

						arg_327_1:RecordAudio("114803080", var_330_11)
						arg_327_1:RecordAudio("114803080", var_330_11)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803080", "story_v_side_old_114803.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803080", "story_v_side_old_114803.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_12 = math.max(var_330_3, arg_327_1.talkMaxDuration)

			if var_330_2 <= arg_327_1.time_ and arg_327_1.time_ < var_330_2 + var_330_12 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_2) / var_330_12

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_2 + var_330_12 and arg_327_1.time_ < var_330_2 + var_330_12 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play114803081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 114803081
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play114803082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				arg_331_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_334_1 = 0
			local var_334_2 = 1.35

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_3 = arg_331_1:GetWordFromCfg(114803081)
				local var_334_4 = arg_331_1:FormatText(var_334_3.content)

				arg_331_1.text_.text = var_334_4

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 54
				local var_334_6 = utf8.len(var_334_4)
				local var_334_7 = var_334_5 <= 0 and var_334_2 or var_334_2 * (var_334_6 / var_334_5)

				if var_334_7 > 0 and var_334_2 < var_334_7 then
					arg_331_1.talkMaxDuration = var_334_7

					if var_334_7 + var_334_1 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_7 + var_334_1
					end
				end

				arg_331_1.text_.text = var_334_4
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_8 = math.max(var_334_2, arg_331_1.talkMaxDuration)

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_8 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_1) / var_334_8

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_1 + var_334_8 and arg_331_1.time_ < var_334_1 + var_334_8 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play114803082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 114803082
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play114803083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_2")
			end

			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_338_2 = 0
			local var_338_3 = 0.9

			if var_338_2 < arg_335_1.time_ and arg_335_1.time_ <= var_338_2 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_4 = arg_335_1:GetWordFromCfg(114803082)
				local var_338_5 = arg_335_1:FormatText(var_338_4.content)

				arg_335_1.text_.text = var_338_5

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_6 = 36
				local var_338_7 = utf8.len(var_338_5)
				local var_338_8 = var_338_6 <= 0 and var_338_3 or var_338_3 * (var_338_7 / var_338_6)

				if var_338_8 > 0 and var_338_3 < var_338_8 then
					arg_335_1.talkMaxDuration = var_338_8

					if var_338_8 + var_338_2 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_2
					end
				end

				arg_335_1.text_.text = var_338_5
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_9 = math.max(var_338_3, arg_335_1.talkMaxDuration)

			if var_338_2 <= arg_335_1.time_ and arg_335_1.time_ < var_338_2 + var_338_9 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_2) / var_338_9

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_2 + var_338_9 and arg_335_1.time_ < var_338_2 + var_338_9 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play114803083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 114803083
		arg_339_1.duration_ = 12.57

		local var_339_0 = {
			ja = 12.566,
			ko = 8.433,
			zh = 8.8,
			en = 10.566
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play114803084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				arg_339_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_342_2 = 0
			local var_342_3 = 0.95

			if var_342_2 < arg_339_1.time_ and arg_339_1.time_ <= var_342_2 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_4 = arg_339_1:FormatText(StoryNameCfg[8].name)

				arg_339_1.leftNameTxt_.text = var_342_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_5 = arg_339_1:GetWordFromCfg(114803083)
				local var_342_6 = arg_339_1:FormatText(var_342_5.content)

				arg_339_1.text_.text = var_342_6

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_7 = 38
				local var_342_8 = utf8.len(var_342_6)
				local var_342_9 = var_342_7 <= 0 and var_342_3 or var_342_3 * (var_342_8 / var_342_7)

				if var_342_9 > 0 and var_342_3 < var_342_9 then
					arg_339_1.talkMaxDuration = var_342_9

					if var_342_9 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_9 + var_342_2
					end
				end

				arg_339_1.text_.text = var_342_6
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803083", "story_v_side_old_114803.awb") ~= 0 then
					local var_342_10 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803083", "story_v_side_old_114803.awb") / 1000

					if var_342_10 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_2
					end

					if var_342_5.prefab_name ~= "" and arg_339_1.actors_[var_342_5.prefab_name] ~= nil then
						local var_342_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_5.prefab_name].transform, "story_v_side_old_114803", "114803083", "story_v_side_old_114803.awb")

						arg_339_1:RecordAudio("114803083", var_342_11)
						arg_339_1:RecordAudio("114803083", var_342_11)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803083", "story_v_side_old_114803.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803083", "story_v_side_old_114803.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_12 = math.max(var_342_3, arg_339_1.talkMaxDuration)

			if var_342_2 <= arg_339_1.time_ and arg_339_1.time_ < var_342_2 + var_342_12 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_2) / var_342_12

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_2 + var_342_12 and arg_339_1.time_ < var_342_2 + var_342_12 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play114803084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 114803084
		arg_343_1.duration_ = 12.57

		local var_343_0 = {
			ja = 11.8,
			ko = 9.566,
			zh = 10.8,
			en = 12.566
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play114803085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_346_1 = 0
			local var_346_2 = 1.125

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_3 = arg_343_1:FormatText(StoryNameCfg[8].name)

				arg_343_1.leftNameTxt_.text = var_346_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_4 = arg_343_1:GetWordFromCfg(114803084)
				local var_346_5 = arg_343_1:FormatText(var_346_4.content)

				arg_343_1.text_.text = var_346_5

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_6 = 45
				local var_346_7 = utf8.len(var_346_5)
				local var_346_8 = var_346_6 <= 0 and var_346_2 or var_346_2 * (var_346_7 / var_346_6)

				if var_346_8 > 0 and var_346_2 < var_346_8 then
					arg_343_1.talkMaxDuration = var_346_8

					if var_346_8 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_8 + var_346_1
					end
				end

				arg_343_1.text_.text = var_346_5
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803084", "story_v_side_old_114803.awb") ~= 0 then
					local var_346_9 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803084", "story_v_side_old_114803.awb") / 1000

					if var_346_9 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_9 + var_346_1
					end

					if var_346_4.prefab_name ~= "" and arg_343_1.actors_[var_346_4.prefab_name] ~= nil then
						local var_346_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_4.prefab_name].transform, "story_v_side_old_114803", "114803084", "story_v_side_old_114803.awb")

						arg_343_1:RecordAudio("114803084", var_346_10)
						arg_343_1:RecordAudio("114803084", var_346_10)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803084", "story_v_side_old_114803.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803084", "story_v_side_old_114803.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_11 = math.max(var_346_2, arg_343_1.talkMaxDuration)

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_11 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_1) / var_346_11

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_1 + var_346_11 and arg_343_1.time_ < var_346_1 + var_346_11 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play114803085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 114803085
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play114803086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["1148ui_story"]
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect1148ui_story == nil then
				arg_347_1.var_.characterEffect1148ui_story = var_350_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_2 = 0.2

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 and not isNil(var_350_0) then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2

				if arg_347_1.var_.characterEffect1148ui_story and not isNil(var_350_0) then
					local var_350_4 = Mathf.Lerp(0, 0.5, var_350_3)

					arg_347_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1148ui_story.fillRatio = var_350_4
				end
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect1148ui_story then
				local var_350_5 = 0.5

				arg_347_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1148ui_story.fillRatio = var_350_5
			end

			local var_350_6 = 0

			if var_350_6 < arg_347_1.time_ and arg_347_1.time_ <= var_350_6 + arg_350_0 then
				arg_347_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_350_7 = 0
			local var_350_8 = 0.1

			if var_350_7 < arg_347_1.time_ and arg_347_1.time_ <= var_350_7 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_9 = arg_347_1:FormatText(StoryNameCfg[7].name)

				arg_347_1.leftNameTxt_.text = var_350_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_10 = arg_347_1:GetWordFromCfg(114803085)
				local var_350_11 = arg_347_1:FormatText(var_350_10.content)

				arg_347_1.text_.text = var_350_11

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_12 = 4
				local var_350_13 = utf8.len(var_350_11)
				local var_350_14 = var_350_12 <= 0 and var_350_8 or var_350_8 * (var_350_13 / var_350_12)

				if var_350_14 > 0 and var_350_8 < var_350_14 then
					arg_347_1.talkMaxDuration = var_350_14

					if var_350_14 + var_350_7 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_14 + var_350_7
					end
				end

				arg_347_1.text_.text = var_350_11
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_15 = math.max(var_350_8, arg_347_1.talkMaxDuration)

			if var_350_7 <= arg_347_1.time_ and arg_347_1.time_ < var_350_7 + var_350_15 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_7) / var_350_15

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_7 + var_350_15 and arg_347_1.time_ < var_350_7 + var_350_15 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play114803086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 114803086
		arg_351_1.duration_ = 3.63

		local var_351_0 = {
			ja = 2.733,
			ko = 3.3,
			zh = 3.566,
			en = 3.633
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play114803087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1148ui_story"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1148ui_story == nil then
				arg_351_1.var_.characterEffect1148ui_story = var_354_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.2

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.characterEffect1148ui_story and not isNil(var_354_0) then
					arg_351_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1148ui_story then
				arg_351_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_354_4 = 0

			if var_354_4 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action446")
			end

			local var_354_5 = 0

			if var_354_5 < arg_351_1.time_ and arg_351_1.time_ <= var_354_5 + arg_354_0 then
				arg_351_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_354_6 = 0
			local var_354_7 = 0.25

			if var_354_6 < arg_351_1.time_ and arg_351_1.time_ <= var_354_6 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_8 = arg_351_1:FormatText(StoryNameCfg[8].name)

				arg_351_1.leftNameTxt_.text = var_354_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_9 = arg_351_1:GetWordFromCfg(114803086)
				local var_354_10 = arg_351_1:FormatText(var_354_9.content)

				arg_351_1.text_.text = var_354_10

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_11 = 10
				local var_354_12 = utf8.len(var_354_10)
				local var_354_13 = var_354_11 <= 0 and var_354_7 or var_354_7 * (var_354_12 / var_354_11)

				if var_354_13 > 0 and var_354_7 < var_354_13 then
					arg_351_1.talkMaxDuration = var_354_13

					if var_354_13 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_13 + var_354_6
					end
				end

				arg_351_1.text_.text = var_354_10
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803086", "story_v_side_old_114803.awb") ~= 0 then
					local var_354_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803086", "story_v_side_old_114803.awb") / 1000

					if var_354_14 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_14 + var_354_6
					end

					if var_354_9.prefab_name ~= "" and arg_351_1.actors_[var_354_9.prefab_name] ~= nil then
						local var_354_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_9.prefab_name].transform, "story_v_side_old_114803", "114803086", "story_v_side_old_114803.awb")

						arg_351_1:RecordAudio("114803086", var_354_15)
						arg_351_1:RecordAudio("114803086", var_354_15)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803086", "story_v_side_old_114803.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803086", "story_v_side_old_114803.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_16 = math.max(var_354_7, arg_351_1.talkMaxDuration)

			if var_354_6 <= arg_351_1.time_ and arg_351_1.time_ < var_354_6 + var_354_16 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_6) / var_354_16

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_6 + var_354_16 and arg_351_1.time_ < var_354_6 + var_354_16 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play114803087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 114803087
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play114803088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["1148ui_story"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1148ui_story == nil then
				arg_355_1.var_.characterEffect1148ui_story = var_358_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.2

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 and not isNil(var_358_0) then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.characterEffect1148ui_story and not isNil(var_358_0) then
					local var_358_4 = Mathf.Lerp(0, 0.5, var_358_3)

					arg_355_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1148ui_story.fillRatio = var_358_4
				end
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1148ui_story then
				local var_358_5 = 0.5

				arg_355_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1148ui_story.fillRatio = var_358_5
			end

			local var_358_6 = 0

			if var_358_6 < arg_355_1.time_ and arg_355_1.time_ <= var_358_6 + arg_358_0 then
				arg_355_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_358_7 = 0
			local var_358_8 = 0.125

			if var_358_7 < arg_355_1.time_ and arg_355_1.time_ <= var_358_7 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_9 = arg_355_1:FormatText(StoryNameCfg[7].name)

				arg_355_1.leftNameTxt_.text = var_358_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_10 = arg_355_1:GetWordFromCfg(114803087)
				local var_358_11 = arg_355_1:FormatText(var_358_10.content)

				arg_355_1.text_.text = var_358_11

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_12 = 5
				local var_358_13 = utf8.len(var_358_11)
				local var_358_14 = var_358_12 <= 0 and var_358_8 or var_358_8 * (var_358_13 / var_358_12)

				if var_358_14 > 0 and var_358_8 < var_358_14 then
					arg_355_1.talkMaxDuration = var_358_14

					if var_358_14 + var_358_7 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_14 + var_358_7
					end
				end

				arg_355_1.text_.text = var_358_11
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_15 = math.max(var_358_8, arg_355_1.talkMaxDuration)

			if var_358_7 <= arg_355_1.time_ and arg_355_1.time_ < var_358_7 + var_358_15 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_7) / var_358_15

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_7 + var_358_15 and arg_355_1.time_ < var_358_7 + var_358_15 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play114803088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 114803088
		arg_359_1.duration_ = 5.17

		local var_359_0 = {
			ja = 4.7,
			ko = 4.433,
			zh = 4.133,
			en = 5.166
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play114803089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1148ui_story"]
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.characterEffect1148ui_story == nil then
				arg_359_1.var_.characterEffect1148ui_story = var_362_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.2

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 and not isNil(var_362_0) then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2

				if arg_359_1.var_.characterEffect1148ui_story and not isNil(var_362_0) then
					arg_359_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.characterEffect1148ui_story then
				arg_359_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_362_4 = 0

			if var_362_4 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action467")
			end

			local var_362_5 = 0

			if var_362_5 < arg_359_1.time_ and arg_359_1.time_ <= var_362_5 + arg_362_0 then
				arg_359_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_362_6 = 0
			local var_362_7 = 0.4

			if var_362_6 < arg_359_1.time_ and arg_359_1.time_ <= var_362_6 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_8 = arg_359_1:FormatText(StoryNameCfg[8].name)

				arg_359_1.leftNameTxt_.text = var_362_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_9 = arg_359_1:GetWordFromCfg(114803088)
				local var_362_10 = arg_359_1:FormatText(var_362_9.content)

				arg_359_1.text_.text = var_362_10

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_11 = 16
				local var_362_12 = utf8.len(var_362_10)
				local var_362_13 = var_362_11 <= 0 and var_362_7 or var_362_7 * (var_362_12 / var_362_11)

				if var_362_13 > 0 and var_362_7 < var_362_13 then
					arg_359_1.talkMaxDuration = var_362_13

					if var_362_13 + var_362_6 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_13 + var_362_6
					end
				end

				arg_359_1.text_.text = var_362_10
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803088", "story_v_side_old_114803.awb") ~= 0 then
					local var_362_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803088", "story_v_side_old_114803.awb") / 1000

					if var_362_14 + var_362_6 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_14 + var_362_6
					end

					if var_362_9.prefab_name ~= "" and arg_359_1.actors_[var_362_9.prefab_name] ~= nil then
						local var_362_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_9.prefab_name].transform, "story_v_side_old_114803", "114803088", "story_v_side_old_114803.awb")

						arg_359_1:RecordAudio("114803088", var_362_15)
						arg_359_1:RecordAudio("114803088", var_362_15)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803088", "story_v_side_old_114803.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803088", "story_v_side_old_114803.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_16 = math.max(var_362_7, arg_359_1.talkMaxDuration)

			if var_362_6 <= arg_359_1.time_ and arg_359_1.time_ < var_362_6 + var_362_16 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_6) / var_362_16

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_6 + var_362_16 and arg_359_1.time_ < var_362_6 + var_362_16 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play114803089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 114803089
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play114803090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["1148ui_story"]
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1148ui_story == nil then
				arg_363_1.var_.characterEffect1148ui_story = var_366_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.2

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 and not isNil(var_366_0) then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2

				if arg_363_1.var_.characterEffect1148ui_story and not isNil(var_366_0) then
					local var_366_4 = Mathf.Lerp(0, 0.5, var_366_3)

					arg_363_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1148ui_story.fillRatio = var_366_4
				end
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1148ui_story then
				local var_366_5 = 0.5

				arg_363_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1148ui_story.fillRatio = var_366_5
			end

			local var_366_6 = 0

			if var_366_6 < arg_363_1.time_ and arg_363_1.time_ <= var_366_6 + arg_366_0 then
				arg_363_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_366_7 = 0
			local var_366_8 = 0.85

			if var_366_7 < arg_363_1.time_ and arg_363_1.time_ <= var_366_7 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_9 = arg_363_1:GetWordFromCfg(114803089)
				local var_366_10 = arg_363_1:FormatText(var_366_9.content)

				arg_363_1.text_.text = var_366_10

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_11 = 34
				local var_366_12 = utf8.len(var_366_10)
				local var_366_13 = var_366_11 <= 0 and var_366_8 or var_366_8 * (var_366_12 / var_366_11)

				if var_366_13 > 0 and var_366_8 < var_366_13 then
					arg_363_1.talkMaxDuration = var_366_13

					if var_366_13 + var_366_7 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_13 + var_366_7
					end
				end

				arg_363_1.text_.text = var_366_10
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_14 = math.max(var_366_8, arg_363_1.talkMaxDuration)

			if var_366_7 <= arg_363_1.time_ and arg_363_1.time_ < var_366_7 + var_366_14 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_7) / var_366_14

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_7 + var_366_14 and arg_363_1.time_ < var_366_7 + var_366_14 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play114803090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 114803090
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play114803091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_370_1 = 0
			local var_370_2 = 1.425

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_3 = arg_367_1:GetWordFromCfg(114803090)
				local var_370_4 = arg_367_1:FormatText(var_370_3.content)

				arg_367_1.text_.text = var_370_4

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 57
				local var_370_6 = utf8.len(var_370_4)
				local var_370_7 = var_370_5 <= 0 and var_370_2 or var_370_2 * (var_370_6 / var_370_5)

				if var_370_7 > 0 and var_370_2 < var_370_7 then
					arg_367_1.talkMaxDuration = var_370_7

					if var_370_7 + var_370_1 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_1
					end
				end

				arg_367_1.text_.text = var_370_4
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_8 = math.max(var_370_2, arg_367_1.talkMaxDuration)

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_8 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_1) / var_370_8

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_1 + var_370_8 and arg_367_1.time_ < var_370_1 + var_370_8 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play114803091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 114803091
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play114803092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0

			if var_374_0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_374_1 = 0
			local var_374_2 = 0.875

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_3 = arg_371_1:GetWordFromCfg(114803091)
				local var_374_4 = arg_371_1:FormatText(var_374_3.content)

				arg_371_1.text_.text = var_374_4

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_5 = 35
				local var_374_6 = utf8.len(var_374_4)
				local var_374_7 = var_374_5 <= 0 and var_374_2 or var_374_2 * (var_374_6 / var_374_5)

				if var_374_7 > 0 and var_374_2 < var_374_7 then
					arg_371_1.talkMaxDuration = var_374_7

					if var_374_7 + var_374_1 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_7 + var_374_1
					end
				end

				arg_371_1.text_.text = var_374_4
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_8 = math.max(var_374_2, arg_371_1.talkMaxDuration)

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_8 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_1) / var_374_8

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_1 + var_374_8 and arg_371_1.time_ < var_374_1 + var_374_8 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play114803092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 114803092
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play114803093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0

			if var_378_0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_378_1 = 0
			local var_378_2 = 0.35

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_3 = arg_375_1:FormatText(StoryNameCfg[7].name)

				arg_375_1.leftNameTxt_.text = var_378_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_4 = arg_375_1:GetWordFromCfg(114803092)
				local var_378_5 = arg_375_1:FormatText(var_378_4.content)

				arg_375_1.text_.text = var_378_5

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_6 = 14
				local var_378_7 = utf8.len(var_378_5)
				local var_378_8 = var_378_6 <= 0 and var_378_2 or var_378_2 * (var_378_7 / var_378_6)

				if var_378_8 > 0 and var_378_2 < var_378_8 then
					arg_375_1.talkMaxDuration = var_378_8

					if var_378_8 + var_378_1 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_8 + var_378_1
					end
				end

				arg_375_1.text_.text = var_378_5
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_9 = math.max(var_378_2, arg_375_1.talkMaxDuration)

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_9 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_1) / var_378_9

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_1 + var_378_9 and arg_375_1.time_ < var_378_1 + var_378_9 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play114803093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 114803093
		arg_379_1.duration_ = 2.8

		local var_379_0 = {
			ja = 2.266,
			ko = 1.999999999999,
			zh = 2.2,
			en = 2.8
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play114803094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1148ui_story"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1148ui_story == nil then
				arg_379_1.var_.characterEffect1148ui_story = var_382_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.2

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.characterEffect1148ui_story and not isNil(var_382_0) then
					arg_379_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1148ui_story then
				arg_379_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_382_4 = 0

			if var_382_4 < arg_379_1.time_ and arg_379_1.time_ <= var_382_4 + arg_382_0 then
				arg_379_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action475")
			end

			local var_382_5 = 0

			if var_382_5 < arg_379_1.time_ and arg_379_1.time_ <= var_382_5 + arg_382_0 then
				arg_379_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_382_6 = 0
			local var_382_7 = 0.15

			if var_382_6 < arg_379_1.time_ and arg_379_1.time_ <= var_382_6 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_8 = arg_379_1:FormatText(StoryNameCfg[8].name)

				arg_379_1.leftNameTxt_.text = var_382_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_9 = arg_379_1:GetWordFromCfg(114803093)
				local var_382_10 = arg_379_1:FormatText(var_382_9.content)

				arg_379_1.text_.text = var_382_10

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_11 = 6
				local var_382_12 = utf8.len(var_382_10)
				local var_382_13 = var_382_11 <= 0 and var_382_7 or var_382_7 * (var_382_12 / var_382_11)

				if var_382_13 > 0 and var_382_7 < var_382_13 then
					arg_379_1.talkMaxDuration = var_382_13

					if var_382_13 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_13 + var_382_6
					end
				end

				arg_379_1.text_.text = var_382_10
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803093", "story_v_side_old_114803.awb") ~= 0 then
					local var_382_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803093", "story_v_side_old_114803.awb") / 1000

					if var_382_14 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_14 + var_382_6
					end

					if var_382_9.prefab_name ~= "" and arg_379_1.actors_[var_382_9.prefab_name] ~= nil then
						local var_382_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_9.prefab_name].transform, "story_v_side_old_114803", "114803093", "story_v_side_old_114803.awb")

						arg_379_1:RecordAudio("114803093", var_382_15)
						arg_379_1:RecordAudio("114803093", var_382_15)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803093", "story_v_side_old_114803.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803093", "story_v_side_old_114803.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_16 = math.max(var_382_7, arg_379_1.talkMaxDuration)

			if var_382_6 <= arg_379_1.time_ and arg_379_1.time_ < var_382_6 + var_382_16 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_6) / var_382_16

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_6 + var_382_16 and arg_379_1.time_ < var_382_6 + var_382_16 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play114803094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 114803094
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play114803095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1148ui_story"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1148ui_story == nil then
				arg_383_1.var_.characterEffect1148ui_story = var_386_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.2

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 and not isNil(var_386_0) then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.characterEffect1148ui_story and not isNil(var_386_0) then
					local var_386_4 = Mathf.Lerp(0, 0.5, var_386_3)

					arg_383_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1148ui_story.fillRatio = var_386_4
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1148ui_story then
				local var_386_5 = 0.5

				arg_383_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1148ui_story.fillRatio = var_386_5
			end

			local var_386_6 = 0

			if var_386_6 < arg_383_1.time_ and arg_383_1.time_ <= var_386_6 + arg_386_0 then
				arg_383_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_386_7 = 0
			local var_386_8 = 0.875

			if var_386_7 < arg_383_1.time_ and arg_383_1.time_ <= var_386_7 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_9 = arg_383_1:GetWordFromCfg(114803094)
				local var_386_10 = arg_383_1:FormatText(var_386_9.content)

				arg_383_1.text_.text = var_386_10

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_11 = 35
				local var_386_12 = utf8.len(var_386_10)
				local var_386_13 = var_386_11 <= 0 and var_386_8 or var_386_8 * (var_386_12 / var_386_11)

				if var_386_13 > 0 and var_386_8 < var_386_13 then
					arg_383_1.talkMaxDuration = var_386_13

					if var_386_13 + var_386_7 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_13 + var_386_7
					end
				end

				arg_383_1.text_.text = var_386_10
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_14 = math.max(var_386_8, arg_383_1.talkMaxDuration)

			if var_386_7 <= arg_383_1.time_ and arg_383_1.time_ < var_386_7 + var_386_14 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_7) / var_386_14

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_7 + var_386_14 and arg_383_1.time_ < var_386_7 + var_386_14 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play114803095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 114803095
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play114803096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0
			local var_390_1 = 1.45

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_2 = arg_387_1:GetWordFromCfg(114803095)
				local var_390_3 = arg_387_1:FormatText(var_390_2.content)

				arg_387_1.text_.text = var_390_3

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_4 = 58
				local var_390_5 = utf8.len(var_390_3)
				local var_390_6 = var_390_4 <= 0 and var_390_1 or var_390_1 * (var_390_5 / var_390_4)

				if var_390_6 > 0 and var_390_1 < var_390_6 then
					arg_387_1.talkMaxDuration = var_390_6

					if var_390_6 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_6 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_3
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_7 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_7 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_7

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_7 and arg_387_1.time_ < var_390_0 + var_390_7 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play114803096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 114803096
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, true)

		arg_391_1.tipsText_.text = StoryTipsCfg[114801].name

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"

			SetActive(arg_391_1.choicesGo_, true)

			for iter_392_0, iter_392_1 in ipairs(arg_391_1.choices_) do
				local var_392_0 = iter_392_0 <= 2

				SetActive(iter_392_1.go, var_392_0)
			end

			arg_391_1.choices_[1].txt.text = arg_391_1:FormatText(StoryChoiceCfg[90].name)
			arg_391_1.choices_[2].txt.text = arg_391_1:FormatText(StoryChoiceCfg[91].name)
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				PlayerAction.UseStoryTrigger(1148012, 211480103, 114803096, 1)
				arg_391_0:Play114803098(arg_391_1)
			end

			if arg_393_0 == 2 then
				PlayerAction.UseStoryTrigger(1148012, 211480103, 114803096, 2)
				arg_391_0:Play114803107(arg_391_1)
			end

			arg_391_1:RecordChoiceLog(114803096, 90, 91)
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0
			local var_394_1 = 0.775

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

				local var_394_2 = arg_391_1:GetWordFromCfg(114803096)
				local var_394_3 = arg_391_1:FormatText(var_394_2.content)

				arg_391_1.text_.text = var_394_3

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_4 = 31
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
	Play114803098 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 114803098
		arg_395_1.duration_ = 6.47

		local var_395_0 = {
			ja = 6.466,
			ko = 6.3,
			zh = 4,
			en = 3.9
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play114803099(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = arg_395_1.actors_["1148ui_story"]
			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.characterEffect1148ui_story == nil then
				arg_395_1.var_.characterEffect1148ui_story = var_398_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.2

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_2 and not isNil(var_398_0) then
				local var_398_3 = (arg_395_1.time_ - var_398_1) / var_398_2

				if arg_395_1.var_.characterEffect1148ui_story and not isNil(var_398_0) then
					arg_395_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= var_398_1 + var_398_2 and arg_395_1.time_ < var_398_1 + var_398_2 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.characterEffect1148ui_story then
				arg_395_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_398_4 = 0

			if var_398_4 < arg_395_1.time_ and arg_395_1.time_ <= var_398_4 + arg_398_0 then
				arg_395_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action453")
			end

			local var_398_5 = 0

			if var_398_5 < arg_395_1.time_ and arg_395_1.time_ <= var_398_5 + arg_398_0 then
				arg_395_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_398_6 = 0
			local var_398_7 = 0.375

			if var_398_6 < arg_395_1.time_ and arg_395_1.time_ <= var_398_6 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_8 = arg_395_1:FormatText(StoryNameCfg[8].name)

				arg_395_1.leftNameTxt_.text = var_398_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_9 = arg_395_1:GetWordFromCfg(114803098)
				local var_398_10 = arg_395_1:FormatText(var_398_9.content)

				arg_395_1.text_.text = var_398_10

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_11 = 18
				local var_398_12 = utf8.len(var_398_10)
				local var_398_13 = var_398_11 <= 0 and var_398_7 or var_398_7 * (var_398_12 / var_398_11)

				if var_398_13 > 0 and var_398_7 < var_398_13 then
					arg_395_1.talkMaxDuration = var_398_13

					if var_398_13 + var_398_6 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_13 + var_398_6
					end
				end

				arg_395_1.text_.text = var_398_10
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803098", "story_v_side_old_114803.awb") ~= 0 then
					local var_398_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803098", "story_v_side_old_114803.awb") / 1000

					if var_398_14 + var_398_6 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_14 + var_398_6
					end

					if var_398_9.prefab_name ~= "" and arg_395_1.actors_[var_398_9.prefab_name] ~= nil then
						local var_398_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_9.prefab_name].transform, "story_v_side_old_114803", "114803098", "story_v_side_old_114803.awb")

						arg_395_1:RecordAudio("114803098", var_398_15)
						arg_395_1:RecordAudio("114803098", var_398_15)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803098", "story_v_side_old_114803.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803098", "story_v_side_old_114803.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_16 = math.max(var_398_7, arg_395_1.talkMaxDuration)

			if var_398_6 <= arg_395_1.time_ and arg_395_1.time_ < var_398_6 + var_398_16 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_6) / var_398_16

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_6 + var_398_16 and arg_395_1.time_ < var_398_6 + var_398_16 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play114803099 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 114803099
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play114803100(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["1148ui_story"]
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1148ui_story == nil then
				arg_399_1.var_.characterEffect1148ui_story = var_402_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_2 = 0.2

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_2 and not isNil(var_402_0) then
				local var_402_3 = (arg_399_1.time_ - var_402_1) / var_402_2

				if arg_399_1.var_.characterEffect1148ui_story and not isNil(var_402_0) then
					local var_402_4 = Mathf.Lerp(0, 0.5, var_402_3)

					arg_399_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1148ui_story.fillRatio = var_402_4
				end
			end

			if arg_399_1.time_ >= var_402_1 + var_402_2 and arg_399_1.time_ < var_402_1 + var_402_2 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1148ui_story then
				local var_402_5 = 0.5

				arg_399_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1148ui_story.fillRatio = var_402_5
			end

			local var_402_6 = 0

			if var_402_6 < arg_399_1.time_ and arg_399_1.time_ <= var_402_6 + arg_402_0 then
				arg_399_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_402_7 = 0
			local var_402_8 = 0.275

			if var_402_7 < arg_399_1.time_ and arg_399_1.time_ <= var_402_7 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_9 = arg_399_1:FormatText(StoryNameCfg[7].name)

				arg_399_1.leftNameTxt_.text = var_402_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_10 = arg_399_1:GetWordFromCfg(114803099)
				local var_402_11 = arg_399_1:FormatText(var_402_10.content)

				arg_399_1.text_.text = var_402_11

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_12 = 11
				local var_402_13 = utf8.len(var_402_11)
				local var_402_14 = var_402_12 <= 0 and var_402_8 or var_402_8 * (var_402_13 / var_402_12)

				if var_402_14 > 0 and var_402_8 < var_402_14 then
					arg_399_1.talkMaxDuration = var_402_14

					if var_402_14 + var_402_7 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_14 + var_402_7
					end
				end

				arg_399_1.text_.text = var_402_11
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_15 = math.max(var_402_8, arg_399_1.talkMaxDuration)

			if var_402_7 <= arg_399_1.time_ and arg_399_1.time_ < var_402_7 + var_402_15 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_7) / var_402_15

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_7 + var_402_15 and arg_399_1.time_ < var_402_7 + var_402_15 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play114803100 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 114803100
		arg_403_1.duration_ = 7.67

		local var_403_0 = {
			ja = 7.666,
			ko = 6.166,
			zh = 5.533,
			en = 6.5
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
				arg_403_0:Play114803101(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["1148ui_story"]
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.characterEffect1148ui_story == nil then
				arg_403_1.var_.characterEffect1148ui_story = var_406_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.2

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_2 and not isNil(var_406_0) then
				local var_406_3 = (arg_403_1.time_ - var_406_1) / var_406_2

				if arg_403_1.var_.characterEffect1148ui_story and not isNil(var_406_0) then
					arg_403_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= var_406_1 + var_406_2 and arg_403_1.time_ < var_406_1 + var_406_2 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.characterEffect1148ui_story then
				arg_403_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_406_4 = 0

			if var_406_4 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action437")
			end

			local var_406_5 = 0

			if var_406_5 < arg_403_1.time_ and arg_403_1.time_ <= var_406_5 + arg_406_0 then
				arg_403_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_406_6 = 0
			local var_406_7 = 0.675

			if var_406_6 < arg_403_1.time_ and arg_403_1.time_ <= var_406_6 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_8 = arg_403_1:FormatText(StoryNameCfg[8].name)

				arg_403_1.leftNameTxt_.text = var_406_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_9 = arg_403_1:GetWordFromCfg(114803100)
				local var_406_10 = arg_403_1:FormatText(var_406_9.content)

				arg_403_1.text_.text = var_406_10

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_11 = 27
				local var_406_12 = utf8.len(var_406_10)
				local var_406_13 = var_406_11 <= 0 and var_406_7 or var_406_7 * (var_406_12 / var_406_11)

				if var_406_13 > 0 and var_406_7 < var_406_13 then
					arg_403_1.talkMaxDuration = var_406_13

					if var_406_13 + var_406_6 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_13 + var_406_6
					end
				end

				arg_403_1.text_.text = var_406_10
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803100", "story_v_side_old_114803.awb") ~= 0 then
					local var_406_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803100", "story_v_side_old_114803.awb") / 1000

					if var_406_14 + var_406_6 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_14 + var_406_6
					end

					if var_406_9.prefab_name ~= "" and arg_403_1.actors_[var_406_9.prefab_name] ~= nil then
						local var_406_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_9.prefab_name].transform, "story_v_side_old_114803", "114803100", "story_v_side_old_114803.awb")

						arg_403_1:RecordAudio("114803100", var_406_15)
						arg_403_1:RecordAudio("114803100", var_406_15)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803100", "story_v_side_old_114803.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803100", "story_v_side_old_114803.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_16 = math.max(var_406_7, arg_403_1.talkMaxDuration)

			if var_406_6 <= arg_403_1.time_ and arg_403_1.time_ < var_406_6 + var_406_16 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_6) / var_406_16

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_6 + var_406_16 and arg_403_1.time_ < var_406_6 + var_406_16 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play114803101 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 114803101
		arg_407_1.duration_ = 8.57

		local var_407_0 = {
			ja = 7.766,
			ko = 7.8,
			zh = 8.566,
			en = 6
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
				arg_407_0:Play114803102(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0

			if var_410_0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_410_1 = 0
			local var_410_2 = 0.8

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_3 = arg_407_1:FormatText(StoryNameCfg[8].name)

				arg_407_1.leftNameTxt_.text = var_410_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_4 = arg_407_1:GetWordFromCfg(114803101)
				local var_410_5 = arg_407_1:FormatText(var_410_4.content)

				arg_407_1.text_.text = var_410_5

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_6 = 32
				local var_410_7 = utf8.len(var_410_5)
				local var_410_8 = var_410_6 <= 0 and var_410_2 or var_410_2 * (var_410_7 / var_410_6)

				if var_410_8 > 0 and var_410_2 < var_410_8 then
					arg_407_1.talkMaxDuration = var_410_8

					if var_410_8 + var_410_1 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_8 + var_410_1
					end
				end

				arg_407_1.text_.text = var_410_5
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803101", "story_v_side_old_114803.awb") ~= 0 then
					local var_410_9 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803101", "story_v_side_old_114803.awb") / 1000

					if var_410_9 + var_410_1 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_9 + var_410_1
					end

					if var_410_4.prefab_name ~= "" and arg_407_1.actors_[var_410_4.prefab_name] ~= nil then
						local var_410_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_4.prefab_name].transform, "story_v_side_old_114803", "114803101", "story_v_side_old_114803.awb")

						arg_407_1:RecordAudio("114803101", var_410_10)
						arg_407_1:RecordAudio("114803101", var_410_10)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803101", "story_v_side_old_114803.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803101", "story_v_side_old_114803.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_11 = math.max(var_410_2, arg_407_1.talkMaxDuration)

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_11 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_1) / var_410_11

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_1 + var_410_11 and arg_407_1.time_ < var_410_1 + var_410_11 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play114803102 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 114803102
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play114803103(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1148ui_story"]
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.characterEffect1148ui_story == nil then
				arg_411_1.var_.characterEffect1148ui_story = var_414_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_2 = 0.2

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 and not isNil(var_414_0) then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2

				if arg_411_1.var_.characterEffect1148ui_story and not isNil(var_414_0) then
					local var_414_4 = Mathf.Lerp(0, 0.5, var_414_3)

					arg_411_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1148ui_story.fillRatio = var_414_4
				end
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.characterEffect1148ui_story then
				local var_414_5 = 0.5

				arg_411_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1148ui_story.fillRatio = var_414_5
			end

			local var_414_6 = 0

			if var_414_6 < arg_411_1.time_ and arg_411_1.time_ <= var_414_6 + arg_414_0 then
				arg_411_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_414_7 = 0
			local var_414_8 = 0.125

			if var_414_7 < arg_411_1.time_ and arg_411_1.time_ <= var_414_7 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_9 = arg_411_1:FormatText(StoryNameCfg[7].name)

				arg_411_1.leftNameTxt_.text = var_414_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_10 = arg_411_1:GetWordFromCfg(114803102)
				local var_414_11 = arg_411_1:FormatText(var_414_10.content)

				arg_411_1.text_.text = var_414_11

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_12 = 5
				local var_414_13 = utf8.len(var_414_11)
				local var_414_14 = var_414_12 <= 0 and var_414_8 or var_414_8 * (var_414_13 / var_414_12)

				if var_414_14 > 0 and var_414_8 < var_414_14 then
					arg_411_1.talkMaxDuration = var_414_14

					if var_414_14 + var_414_7 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_14 + var_414_7
					end
				end

				arg_411_1.text_.text = var_414_11
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_15 = math.max(var_414_8, arg_411_1.talkMaxDuration)

			if var_414_7 <= arg_411_1.time_ and arg_411_1.time_ < var_414_7 + var_414_15 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_7) / var_414_15

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_7 + var_414_15 and arg_411_1.time_ < var_414_7 + var_414_15 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play114803103 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 114803103
		arg_415_1.duration_ = 9.47

		local var_415_0 = {
			ja = 7.5,
			ko = 9.466,
			zh = 7.266,
			en = 8.3
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play114803104(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["1148ui_story"]
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.characterEffect1148ui_story == nil then
				arg_415_1.var_.characterEffect1148ui_story = var_418_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_2 = 0.2

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 and not isNil(var_418_0) then
				local var_418_3 = (arg_415_1.time_ - var_418_1) / var_418_2

				if arg_415_1.var_.characterEffect1148ui_story and not isNil(var_418_0) then
					arg_415_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.characterEffect1148ui_story then
				arg_415_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_418_4 = 0

			if var_418_4 < arg_415_1.time_ and arg_415_1.time_ <= var_418_4 + arg_418_0 then
				arg_415_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action476")
			end

			local var_418_5 = 0

			if var_418_5 < arg_415_1.time_ and arg_415_1.time_ <= var_418_5 + arg_418_0 then
				arg_415_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_418_6 = 0
			local var_418_7 = 0.875

			if var_418_6 < arg_415_1.time_ and arg_415_1.time_ <= var_418_6 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_8 = arg_415_1:FormatText(StoryNameCfg[8].name)

				arg_415_1.leftNameTxt_.text = var_418_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_9 = arg_415_1:GetWordFromCfg(114803103)
				local var_418_10 = arg_415_1:FormatText(var_418_9.content)

				arg_415_1.text_.text = var_418_10

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_11 = 35
				local var_418_12 = utf8.len(var_418_10)
				local var_418_13 = var_418_11 <= 0 and var_418_7 or var_418_7 * (var_418_12 / var_418_11)

				if var_418_13 > 0 and var_418_7 < var_418_13 then
					arg_415_1.talkMaxDuration = var_418_13

					if var_418_13 + var_418_6 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_13 + var_418_6
					end
				end

				arg_415_1.text_.text = var_418_10
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803103", "story_v_side_old_114803.awb") ~= 0 then
					local var_418_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803103", "story_v_side_old_114803.awb") / 1000

					if var_418_14 + var_418_6 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_14 + var_418_6
					end

					if var_418_9.prefab_name ~= "" and arg_415_1.actors_[var_418_9.prefab_name] ~= nil then
						local var_418_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_9.prefab_name].transform, "story_v_side_old_114803", "114803103", "story_v_side_old_114803.awb")

						arg_415_1:RecordAudio("114803103", var_418_15)
						arg_415_1:RecordAudio("114803103", var_418_15)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803103", "story_v_side_old_114803.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803103", "story_v_side_old_114803.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_16 = math.max(var_418_7, arg_415_1.talkMaxDuration)

			if var_418_6 <= arg_415_1.time_ and arg_415_1.time_ < var_418_6 + var_418_16 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_6) / var_418_16

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_6 + var_418_16 and arg_415_1.time_ < var_418_6 + var_418_16 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play114803104 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 114803104
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play114803105(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["1148ui_story"]
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 and not isNil(var_422_0) and arg_419_1.var_.characterEffect1148ui_story == nil then
				arg_419_1.var_.characterEffect1148ui_story = var_422_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_2 = 0.2

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 and not isNil(var_422_0) then
				local var_422_3 = (arg_419_1.time_ - var_422_1) / var_422_2

				if arg_419_1.var_.characterEffect1148ui_story and not isNil(var_422_0) then
					local var_422_4 = Mathf.Lerp(0, 0.5, var_422_3)

					arg_419_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_419_1.var_.characterEffect1148ui_story.fillRatio = var_422_4
				end
			end

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 and not isNil(var_422_0) and arg_419_1.var_.characterEffect1148ui_story then
				local var_422_5 = 0.5

				arg_419_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_419_1.var_.characterEffect1148ui_story.fillRatio = var_422_5
			end

			local var_422_6 = 0

			if var_422_6 < arg_419_1.time_ and arg_419_1.time_ <= var_422_6 + arg_422_0 then
				arg_419_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_422_7 = 0
			local var_422_8 = 0.625

			if var_422_7 < arg_419_1.time_ and arg_419_1.time_ <= var_422_7 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_9 = arg_419_1:GetWordFromCfg(114803104)
				local var_422_10 = arg_419_1:FormatText(var_422_9.content)

				arg_419_1.text_.text = var_422_10

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_11 = 25
				local var_422_12 = utf8.len(var_422_10)
				local var_422_13 = var_422_11 <= 0 and var_422_8 or var_422_8 * (var_422_12 / var_422_11)

				if var_422_13 > 0 and var_422_8 < var_422_13 then
					arg_419_1.talkMaxDuration = var_422_13

					if var_422_13 + var_422_7 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_13 + var_422_7
					end
				end

				arg_419_1.text_.text = var_422_10
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_14 = math.max(var_422_8, arg_419_1.talkMaxDuration)

			if var_422_7 <= arg_419_1.time_ and arg_419_1.time_ < var_422_7 + var_422_14 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_7) / var_422_14

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_7 + var_422_14 and arg_419_1.time_ < var_422_7 + var_422_14 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play114803105 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 114803105
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play114803115(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_426_1 = 0
			local var_426_2 = 0.1

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_3 = arg_423_1:FormatText(StoryNameCfg[7].name)

				arg_423_1.leftNameTxt_.text = var_426_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_4 = arg_423_1:GetWordFromCfg(114803105)
				local var_426_5 = arg_423_1:FormatText(var_426_4.content)

				arg_423_1.text_.text = var_426_5

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_6 = 4
				local var_426_7 = utf8.len(var_426_5)
				local var_426_8 = var_426_6 <= 0 and var_426_2 or var_426_2 * (var_426_7 / var_426_6)

				if var_426_8 > 0 and var_426_2 < var_426_8 then
					arg_423_1.talkMaxDuration = var_426_8

					if var_426_8 + var_426_1 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_8 + var_426_1
					end
				end

				arg_423_1.text_.text = var_426_5
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_9 = math.max(var_426_2, arg_423_1.talkMaxDuration)

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_9 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_1) / var_426_9

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_1 + var_426_9 and arg_423_1.time_ < var_426_1 + var_426_9 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play114803115 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 114803115
		arg_427_1.duration_ = 5.97

		local var_427_0 = {
			ja = 3.9,
			ko = 5.966,
			zh = 4.666,
			en = 4.533
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
				arg_427_0:Play114803116(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["1148ui_story"]
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect1148ui_story == nil then
				arg_427_1.var_.characterEffect1148ui_story = var_430_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_2 = 0.2

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_2 and not isNil(var_430_0) then
				local var_430_3 = (arg_427_1.time_ - var_430_1) / var_430_2

				if arg_427_1.var_.characterEffect1148ui_story and not isNil(var_430_0) then
					arg_427_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= var_430_1 + var_430_2 and arg_427_1.time_ < var_430_1 + var_430_2 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect1148ui_story then
				arg_427_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_430_4 = 0

			if var_430_4 < arg_427_1.time_ and arg_427_1.time_ <= var_430_4 + arg_430_0 then
				arg_427_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action465")
			end

			local var_430_5 = 0

			if var_430_5 < arg_427_1.time_ and arg_427_1.time_ <= var_430_5 + arg_430_0 then
				arg_427_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_430_6 = 0
			local var_430_7 = 0.525

			if var_430_6 < arg_427_1.time_ and arg_427_1.time_ <= var_430_6 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_8 = arg_427_1:FormatText(StoryNameCfg[8].name)

				arg_427_1.leftNameTxt_.text = var_430_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_9 = arg_427_1:GetWordFromCfg(114803115)
				local var_430_10 = arg_427_1:FormatText(var_430_9.content)

				arg_427_1.text_.text = var_430_10

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_11 = 21
				local var_430_12 = utf8.len(var_430_10)
				local var_430_13 = var_430_11 <= 0 and var_430_7 or var_430_7 * (var_430_12 / var_430_11)

				if var_430_13 > 0 and var_430_7 < var_430_13 then
					arg_427_1.talkMaxDuration = var_430_13

					if var_430_13 + var_430_6 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_13 + var_430_6
					end
				end

				arg_427_1.text_.text = var_430_10
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803115", "story_v_side_old_114803.awb") ~= 0 then
					local var_430_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803115", "story_v_side_old_114803.awb") / 1000

					if var_430_14 + var_430_6 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_14 + var_430_6
					end

					if var_430_9.prefab_name ~= "" and arg_427_1.actors_[var_430_9.prefab_name] ~= nil then
						local var_430_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_9.prefab_name].transform, "story_v_side_old_114803", "114803115", "story_v_side_old_114803.awb")

						arg_427_1:RecordAudio("114803115", var_430_15)
						arg_427_1:RecordAudio("114803115", var_430_15)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803115", "story_v_side_old_114803.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803115", "story_v_side_old_114803.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_16 = math.max(var_430_7, arg_427_1.talkMaxDuration)

			if var_430_6 <= arg_427_1.time_ and arg_427_1.time_ < var_430_6 + var_430_16 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_6) / var_430_16

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_6 + var_430_16 and arg_427_1.time_ < var_430_6 + var_430_16 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play114803116 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 114803116
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play114803117(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1148ui_story"]
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1148ui_story == nil then
				arg_431_1.var_.characterEffect1148ui_story = var_434_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_2 = 0.2

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 and not isNil(var_434_0) then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2

				if arg_431_1.var_.characterEffect1148ui_story and not isNil(var_434_0) then
					local var_434_4 = Mathf.Lerp(0, 0.5, var_434_3)

					arg_431_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1148ui_story.fillRatio = var_434_4
				end
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1148ui_story then
				local var_434_5 = 0.5

				arg_431_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1148ui_story.fillRatio = var_434_5
			end

			local var_434_6 = 0

			if var_434_6 < arg_431_1.time_ and arg_431_1.time_ <= var_434_6 + arg_434_0 then
				arg_431_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_434_7 = 0
			local var_434_8 = 0.25

			if var_434_7 < arg_431_1.time_ and arg_431_1.time_ <= var_434_7 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_9 = arg_431_1:FormatText(StoryNameCfg[7].name)

				arg_431_1.leftNameTxt_.text = var_434_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_10 = arg_431_1:GetWordFromCfg(114803116)
				local var_434_11 = arg_431_1:FormatText(var_434_10.content)

				arg_431_1.text_.text = var_434_11

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_12 = 10
				local var_434_13 = utf8.len(var_434_11)
				local var_434_14 = var_434_12 <= 0 and var_434_8 or var_434_8 * (var_434_13 / var_434_12)

				if var_434_14 > 0 and var_434_8 < var_434_14 then
					arg_431_1.talkMaxDuration = var_434_14

					if var_434_14 + var_434_7 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_14 + var_434_7
					end
				end

				arg_431_1.text_.text = var_434_11
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_15 = math.max(var_434_8, arg_431_1.talkMaxDuration)

			if var_434_7 <= arg_431_1.time_ and arg_431_1.time_ < var_434_7 + var_434_15 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_7) / var_434_15

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_7 + var_434_15 and arg_431_1.time_ < var_434_7 + var_434_15 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play114803117 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 114803117
		arg_435_1.duration_ = 8.93

		local var_435_0 = {
			ja = 8.933,
			ko = 6.633,
			zh = 5.566,
			en = 6.466
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play114803118(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1148ui_story"]
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1148ui_story == nil then
				arg_435_1.var_.characterEffect1148ui_story = var_438_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_2 = 0.2

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 and not isNil(var_438_0) then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2

				if arg_435_1.var_.characterEffect1148ui_story and not isNil(var_438_0) then
					arg_435_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1148ui_story then
				arg_435_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_438_4 = 0

			if var_438_4 < arg_435_1.time_ and arg_435_1.time_ <= var_438_4 + arg_438_0 then
				arg_435_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action453")
			end

			local var_438_5 = 0

			if var_438_5 < arg_435_1.time_ and arg_435_1.time_ <= var_438_5 + arg_438_0 then
				arg_435_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_438_6 = 0
			local var_438_7 = 0.6

			if var_438_6 < arg_435_1.time_ and arg_435_1.time_ <= var_438_6 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_8 = arg_435_1:FormatText(StoryNameCfg[8].name)

				arg_435_1.leftNameTxt_.text = var_438_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_9 = arg_435_1:GetWordFromCfg(114803117)
				local var_438_10 = arg_435_1:FormatText(var_438_9.content)

				arg_435_1.text_.text = var_438_10

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_11 = 24
				local var_438_12 = utf8.len(var_438_10)
				local var_438_13 = var_438_11 <= 0 and var_438_7 or var_438_7 * (var_438_12 / var_438_11)

				if var_438_13 > 0 and var_438_7 < var_438_13 then
					arg_435_1.talkMaxDuration = var_438_13

					if var_438_13 + var_438_6 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_13 + var_438_6
					end
				end

				arg_435_1.text_.text = var_438_10
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803117", "story_v_side_old_114803.awb") ~= 0 then
					local var_438_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803117", "story_v_side_old_114803.awb") / 1000

					if var_438_14 + var_438_6 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_14 + var_438_6
					end

					if var_438_9.prefab_name ~= "" and arg_435_1.actors_[var_438_9.prefab_name] ~= nil then
						local var_438_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_9.prefab_name].transform, "story_v_side_old_114803", "114803117", "story_v_side_old_114803.awb")

						arg_435_1:RecordAudio("114803117", var_438_15)
						arg_435_1:RecordAudio("114803117", var_438_15)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803117", "story_v_side_old_114803.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803117", "story_v_side_old_114803.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_16 = math.max(var_438_7, arg_435_1.talkMaxDuration)

			if var_438_6 <= arg_435_1.time_ and arg_435_1.time_ < var_438_6 + var_438_16 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_6) / var_438_16

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_6 + var_438_16 and arg_435_1.time_ < var_438_6 + var_438_16 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play114803118 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 114803118
		arg_439_1.duration_ = 8.87

		local var_439_0 = {
			ja = 8.866,
			ko = 7.4,
			zh = 8.6,
			en = 8.8
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play114803119(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action437")
			end

			local var_442_1 = 0

			if var_442_1 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 then
				arg_439_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_442_2 = 0
			local var_442_3 = 0.875

			if var_442_2 < arg_439_1.time_ and arg_439_1.time_ <= var_442_2 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_4 = arg_439_1:FormatText(StoryNameCfg[8].name)

				arg_439_1.leftNameTxt_.text = var_442_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_5 = arg_439_1:GetWordFromCfg(114803118)
				local var_442_6 = arg_439_1:FormatText(var_442_5.content)

				arg_439_1.text_.text = var_442_6

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_7 = 35
				local var_442_8 = utf8.len(var_442_6)
				local var_442_9 = var_442_7 <= 0 and var_442_3 or var_442_3 * (var_442_8 / var_442_7)

				if var_442_9 > 0 and var_442_3 < var_442_9 then
					arg_439_1.talkMaxDuration = var_442_9

					if var_442_9 + var_442_2 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_9 + var_442_2
					end
				end

				arg_439_1.text_.text = var_442_6
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803118", "story_v_side_old_114803.awb") ~= 0 then
					local var_442_10 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803118", "story_v_side_old_114803.awb") / 1000

					if var_442_10 + var_442_2 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_10 + var_442_2
					end

					if var_442_5.prefab_name ~= "" and arg_439_1.actors_[var_442_5.prefab_name] ~= nil then
						local var_442_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_5.prefab_name].transform, "story_v_side_old_114803", "114803118", "story_v_side_old_114803.awb")

						arg_439_1:RecordAudio("114803118", var_442_11)
						arg_439_1:RecordAudio("114803118", var_442_11)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803118", "story_v_side_old_114803.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803118", "story_v_side_old_114803.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_12 = math.max(var_442_3, arg_439_1.talkMaxDuration)

			if var_442_2 <= arg_439_1.time_ and arg_439_1.time_ < var_442_2 + var_442_12 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_2) / var_442_12

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_2 + var_442_12 and arg_439_1.time_ < var_442_2 + var_442_12 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play114803119 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 114803119
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play114803120(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = arg_443_1.actors_["1148ui_story"]
			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 and not isNil(var_446_0) and arg_443_1.var_.characterEffect1148ui_story == nil then
				arg_443_1.var_.characterEffect1148ui_story = var_446_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_2 = 0.2

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_2 and not isNil(var_446_0) then
				local var_446_3 = (arg_443_1.time_ - var_446_1) / var_446_2

				if arg_443_1.var_.characterEffect1148ui_story and not isNil(var_446_0) then
					local var_446_4 = Mathf.Lerp(0, 0.5, var_446_3)

					arg_443_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_443_1.var_.characterEffect1148ui_story.fillRatio = var_446_4
				end
			end

			if arg_443_1.time_ >= var_446_1 + var_446_2 and arg_443_1.time_ < var_446_1 + var_446_2 + arg_446_0 and not isNil(var_446_0) and arg_443_1.var_.characterEffect1148ui_story then
				local var_446_5 = 0.5

				arg_443_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_443_1.var_.characterEffect1148ui_story.fillRatio = var_446_5
			end

			local var_446_6 = 0

			if var_446_6 < arg_443_1.time_ and arg_443_1.time_ <= var_446_6 + arg_446_0 then
				arg_443_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_446_7 = 0
			local var_446_8 = 0.225

			if var_446_7 < arg_443_1.time_ and arg_443_1.time_ <= var_446_7 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_9 = arg_443_1:FormatText(StoryNameCfg[7].name)

				arg_443_1.leftNameTxt_.text = var_446_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_10 = arg_443_1:GetWordFromCfg(114803119)
				local var_446_11 = arg_443_1:FormatText(var_446_10.content)

				arg_443_1.text_.text = var_446_11

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_12 = 9
				local var_446_13 = utf8.len(var_446_11)
				local var_446_14 = var_446_12 <= 0 and var_446_8 or var_446_8 * (var_446_13 / var_446_12)

				if var_446_14 > 0 and var_446_8 < var_446_14 then
					arg_443_1.talkMaxDuration = var_446_14

					if var_446_14 + var_446_7 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_14 + var_446_7
					end
				end

				arg_443_1.text_.text = var_446_11
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_15 = math.max(var_446_8, arg_443_1.talkMaxDuration)

			if var_446_7 <= arg_443_1.time_ and arg_443_1.time_ < var_446_7 + var_446_15 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_7) / var_446_15

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_7 + var_446_15 and arg_443_1.time_ < var_446_7 + var_446_15 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play114803120 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 114803120
		arg_447_1.duration_ = 14.7

		local var_447_0 = {
			ja = 14.7,
			ko = 10.7,
			zh = 10.5,
			en = 11.833
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play114803121(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = arg_447_1.actors_["1148ui_story"]
			local var_450_1 = 0

			if var_450_1 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 and not isNil(var_450_0) and arg_447_1.var_.characterEffect1148ui_story == nil then
				arg_447_1.var_.characterEffect1148ui_story = var_450_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_2 = 0.2

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_2 and not isNil(var_450_0) then
				local var_450_3 = (arg_447_1.time_ - var_450_1) / var_450_2

				if arg_447_1.var_.characterEffect1148ui_story and not isNil(var_450_0) then
					arg_447_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_447_1.time_ >= var_450_1 + var_450_2 and arg_447_1.time_ < var_450_1 + var_450_2 + arg_450_0 and not isNil(var_450_0) and arg_447_1.var_.characterEffect1148ui_story then
				arg_447_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_450_4 = 0

			if var_450_4 < arg_447_1.time_ and arg_447_1.time_ <= var_450_4 + arg_450_0 then
				arg_447_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action474")
			end

			local var_450_5 = 0

			if var_450_5 < arg_447_1.time_ and arg_447_1.time_ <= var_450_5 + arg_450_0 then
				arg_447_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_450_6 = 0
			local var_450_7 = 1.2

			if var_450_6 < arg_447_1.time_ and arg_447_1.time_ <= var_450_6 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_8 = arg_447_1:FormatText(StoryNameCfg[8].name)

				arg_447_1.leftNameTxt_.text = var_450_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_9 = arg_447_1:GetWordFromCfg(114803120)
				local var_450_10 = arg_447_1:FormatText(var_450_9.content)

				arg_447_1.text_.text = var_450_10

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_11 = 48
				local var_450_12 = utf8.len(var_450_10)
				local var_450_13 = var_450_11 <= 0 and var_450_7 or var_450_7 * (var_450_12 / var_450_11)

				if var_450_13 > 0 and var_450_7 < var_450_13 then
					arg_447_1.talkMaxDuration = var_450_13

					if var_450_13 + var_450_6 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_13 + var_450_6
					end
				end

				arg_447_1.text_.text = var_450_10
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803120", "story_v_side_old_114803.awb") ~= 0 then
					local var_450_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803120", "story_v_side_old_114803.awb") / 1000

					if var_450_14 + var_450_6 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_14 + var_450_6
					end

					if var_450_9.prefab_name ~= "" and arg_447_1.actors_[var_450_9.prefab_name] ~= nil then
						local var_450_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_9.prefab_name].transform, "story_v_side_old_114803", "114803120", "story_v_side_old_114803.awb")

						arg_447_1:RecordAudio("114803120", var_450_15)
						arg_447_1:RecordAudio("114803120", var_450_15)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803120", "story_v_side_old_114803.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803120", "story_v_side_old_114803.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_16 = math.max(var_450_7, arg_447_1.talkMaxDuration)

			if var_450_6 <= arg_447_1.time_ and arg_447_1.time_ < var_450_6 + var_450_16 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_6) / var_450_16

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_6 + var_450_16 and arg_447_1.time_ < var_450_6 + var_450_16 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play114803121 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 114803121
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
			arg_451_1.auto_ = false
		end

		function arg_451_1.playNext_(arg_453_0)
			arg_451_1.onStoryFinished_()
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0

			if var_454_0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_0 + arg_454_0 then
				arg_451_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_454_1 = arg_451_1.actors_["1148ui_story"]
			local var_454_2 = 0

			if var_454_2 < arg_451_1.time_ and arg_451_1.time_ <= var_454_2 + arg_454_0 and not isNil(var_454_1) and arg_451_1.var_.characterEffect1148ui_story == nil then
				arg_451_1.var_.characterEffect1148ui_story = var_454_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_3 = 0.2

			if var_454_2 <= arg_451_1.time_ and arg_451_1.time_ < var_454_2 + var_454_3 and not isNil(var_454_1) then
				local var_454_4 = (arg_451_1.time_ - var_454_2) / var_454_3

				if arg_451_1.var_.characterEffect1148ui_story and not isNil(var_454_1) then
					local var_454_5 = Mathf.Lerp(0, 0.5, var_454_4)

					arg_451_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_451_1.var_.characterEffect1148ui_story.fillRatio = var_454_5
				end
			end

			if arg_451_1.time_ >= var_454_2 + var_454_3 and arg_451_1.time_ < var_454_2 + var_454_3 + arg_454_0 and not isNil(var_454_1) and arg_451_1.var_.characterEffect1148ui_story then
				local var_454_6 = 0.5

				arg_451_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_451_1.var_.characterEffect1148ui_story.fillRatio = var_454_6
			end

			local var_454_7 = 0
			local var_454_8 = 0.275

			if var_454_7 < arg_451_1.time_ and arg_451_1.time_ <= var_454_7 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_9 = arg_451_1:FormatText(StoryNameCfg[7].name)

				arg_451_1.leftNameTxt_.text = var_454_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_10 = arg_451_1:GetWordFromCfg(114803121)
				local var_454_11 = arg_451_1:FormatText(var_454_10.content)

				arg_451_1.text_.text = var_454_11

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_12 = 11
				local var_454_13 = utf8.len(var_454_11)
				local var_454_14 = var_454_12 <= 0 and var_454_8 or var_454_8 * (var_454_13 / var_454_12)

				if var_454_14 > 0 and var_454_8 < var_454_14 then
					arg_451_1.talkMaxDuration = var_454_14

					if var_454_14 + var_454_7 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_14 + var_454_7
					end
				end

				arg_451_1.text_.text = var_454_11
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_15 = math.max(var_454_8, arg_451_1.talkMaxDuration)

			if var_454_7 <= arg_451_1.time_ and arg_451_1.time_ < var_454_7 + var_454_15 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_7) / var_454_15

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_7 + var_454_15 and arg_451_1.time_ < var_454_7 + var_454_15 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play114803107 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 114803107
		arg_455_1.duration_ = 6.53

		local var_455_0 = {
			ja = 4.266,
			ko = 6.533,
			zh = 4.9,
			en = 5.466
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play114803108(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.actors_["1148ui_story"]
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.characterEffect1148ui_story == nil then
				arg_455_1.var_.characterEffect1148ui_story = var_458_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_2 = 0.2

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_2 and not isNil(var_458_0) then
				local var_458_3 = (arg_455_1.time_ - var_458_1) / var_458_2

				if arg_455_1.var_.characterEffect1148ui_story and not isNil(var_458_0) then
					arg_455_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_455_1.time_ >= var_458_1 + var_458_2 and arg_455_1.time_ < var_458_1 + var_458_2 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.characterEffect1148ui_story then
				arg_455_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_458_4 = "1148ui_story"

			if arg_455_1.actors_[var_458_4] == nil then
				local var_458_5 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_458_5) then
					local var_458_6 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_455_1.stage_.transform)

					var_458_6.name = var_458_4
					var_458_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_455_1.actors_[var_458_4] = var_458_6

					local var_458_7 = var_458_6:GetComponentInChildren(typeof(CharacterEffect))

					var_458_7.enabled = true

					local var_458_8 = GameObjectTools.GetOrAddComponent(var_458_6, typeof(DynamicBoneHelper))

					if var_458_8 then
						var_458_8:EnableDynamicBone(false)
					end

					arg_455_1:ShowWeapon(var_458_7.transform, false)

					arg_455_1.var_[var_458_4 .. "Animator"] = var_458_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_455_1.var_[var_458_4 .. "Animator"].applyRootMotion = true
					arg_455_1.var_[var_458_4 .. "LipSync"] = var_458_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_458_9 = 0

			if var_458_9 < arg_455_1.time_ and arg_455_1.time_ <= var_458_9 + arg_458_0 then
				arg_455_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action457")
			end

			local var_458_10 = "1148ui_story"

			if arg_455_1.actors_[var_458_10] == nil then
				local var_458_11 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_458_11) then
					local var_458_12 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_455_1.stage_.transform)

					var_458_12.name = var_458_10
					var_458_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_455_1.actors_[var_458_10] = var_458_12

					local var_458_13 = var_458_12:GetComponentInChildren(typeof(CharacterEffect))

					var_458_13.enabled = true

					local var_458_14 = GameObjectTools.GetOrAddComponent(var_458_12, typeof(DynamicBoneHelper))

					if var_458_14 then
						var_458_14:EnableDynamicBone(false)
					end

					arg_455_1:ShowWeapon(var_458_13.transform, false)

					arg_455_1.var_[var_458_10 .. "Animator"] = var_458_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_455_1.var_[var_458_10 .. "Animator"].applyRootMotion = true
					arg_455_1.var_[var_458_10 .. "LipSync"] = var_458_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_458_15 = 0

			if var_458_15 < arg_455_1.time_ and arg_455_1.time_ <= var_458_15 + arg_458_0 then
				arg_455_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_458_16 = 0
			local var_458_17 = 0.375

			if var_458_16 < arg_455_1.time_ and arg_455_1.time_ <= var_458_16 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_18 = arg_455_1:FormatText(StoryNameCfg[8].name)

				arg_455_1.leftNameTxt_.text = var_458_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_19 = arg_455_1:GetWordFromCfg(114803107)
				local var_458_20 = arg_455_1:FormatText(var_458_19.content)

				arg_455_1.text_.text = var_458_20

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_21 = 21
				local var_458_22 = utf8.len(var_458_20)
				local var_458_23 = var_458_21 <= 0 and var_458_17 or var_458_17 * (var_458_22 / var_458_21)

				if var_458_23 > 0 and var_458_17 < var_458_23 then
					arg_455_1.talkMaxDuration = var_458_23

					if var_458_23 + var_458_16 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_23 + var_458_16
					end
				end

				arg_455_1.text_.text = var_458_20
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803107", "story_v_side_old_114803.awb") ~= 0 then
					local var_458_24 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803107", "story_v_side_old_114803.awb") / 1000

					if var_458_24 + var_458_16 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_24 + var_458_16
					end

					if var_458_19.prefab_name ~= "" and arg_455_1.actors_[var_458_19.prefab_name] ~= nil then
						local var_458_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_19.prefab_name].transform, "story_v_side_old_114803", "114803107", "story_v_side_old_114803.awb")

						arg_455_1:RecordAudio("114803107", var_458_25)
						arg_455_1:RecordAudio("114803107", var_458_25)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803107", "story_v_side_old_114803.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803107", "story_v_side_old_114803.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_26 = math.max(var_458_17, arg_455_1.talkMaxDuration)

			if var_458_16 <= arg_455_1.time_ and arg_455_1.time_ < var_458_16 + var_458_26 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_16) / var_458_26

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_16 + var_458_26 and arg_455_1.time_ < var_458_16 + var_458_26 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play114803108 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 114803108
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play114803109(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = arg_459_1.actors_["1148ui_story"]
			local var_462_1 = 0

			if var_462_1 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 and not isNil(var_462_0) and arg_459_1.var_.characterEffect1148ui_story == nil then
				arg_459_1.var_.characterEffect1148ui_story = var_462_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_2 = 0.2

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_2 and not isNil(var_462_0) then
				local var_462_3 = (arg_459_1.time_ - var_462_1) / var_462_2

				if arg_459_1.var_.characterEffect1148ui_story and not isNil(var_462_0) then
					local var_462_4 = Mathf.Lerp(0, 0.5, var_462_3)

					arg_459_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_459_1.var_.characterEffect1148ui_story.fillRatio = var_462_4
				end
			end

			if arg_459_1.time_ >= var_462_1 + var_462_2 and arg_459_1.time_ < var_462_1 + var_462_2 + arg_462_0 and not isNil(var_462_0) and arg_459_1.var_.characterEffect1148ui_story then
				local var_462_5 = 0.5

				arg_459_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_459_1.var_.characterEffect1148ui_story.fillRatio = var_462_5
			end

			local var_462_6 = 0

			if var_462_6 < arg_459_1.time_ and arg_459_1.time_ <= var_462_6 + arg_462_0 then
				arg_459_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_462_7 = 0
			local var_462_8 = 0.15

			if var_462_7 < arg_459_1.time_ and arg_459_1.time_ <= var_462_7 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_9 = arg_459_1:FormatText(StoryNameCfg[7].name)

				arg_459_1.leftNameTxt_.text = var_462_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, true)
				arg_459_1.iconController_:SetSelectedState("hero")

				arg_459_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_459_1.callingController_:SetSelectedState("normal")

				arg_459_1.keyicon_.color = Color.New(1, 1, 1)
				arg_459_1.icon_.color = Color.New(1, 1, 1)

				local var_462_10 = arg_459_1:GetWordFromCfg(114803108)
				local var_462_11 = arg_459_1:FormatText(var_462_10.content)

				arg_459_1.text_.text = var_462_11

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_12 = 6
				local var_462_13 = utf8.len(var_462_11)
				local var_462_14 = var_462_12 <= 0 and var_462_8 or var_462_8 * (var_462_13 / var_462_12)

				if var_462_14 > 0 and var_462_8 < var_462_14 then
					arg_459_1.talkMaxDuration = var_462_14

					if var_462_14 + var_462_7 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_14 + var_462_7
					end
				end

				arg_459_1.text_.text = var_462_11
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_15 = math.max(var_462_8, arg_459_1.talkMaxDuration)

			if var_462_7 <= arg_459_1.time_ and arg_459_1.time_ < var_462_7 + var_462_15 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_7) / var_462_15

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_7 + var_462_15 and arg_459_1.time_ < var_462_7 + var_462_15 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play114803109 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 114803109
		arg_463_1.duration_ = 4.8

		local var_463_0 = {
			ja = 4.633,
			ko = 4.8,
			zh = 4.433,
			en = 3.3
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play114803110(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = arg_463_1.actors_["1148ui_story"]
			local var_466_1 = 0

			if var_466_1 < arg_463_1.time_ and arg_463_1.time_ <= var_466_1 + arg_466_0 and not isNil(var_466_0) and arg_463_1.var_.characterEffect1148ui_story == nil then
				arg_463_1.var_.characterEffect1148ui_story = var_466_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_2 = 0.2

			if var_466_1 <= arg_463_1.time_ and arg_463_1.time_ < var_466_1 + var_466_2 and not isNil(var_466_0) then
				local var_466_3 = (arg_463_1.time_ - var_466_1) / var_466_2

				if arg_463_1.var_.characterEffect1148ui_story and not isNil(var_466_0) then
					arg_463_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_463_1.time_ >= var_466_1 + var_466_2 and arg_463_1.time_ < var_466_1 + var_466_2 + arg_466_0 and not isNil(var_466_0) and arg_463_1.var_.characterEffect1148ui_story then
				arg_463_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_466_4 = 0

			if var_466_4 < arg_463_1.time_ and arg_463_1.time_ <= var_466_4 + arg_466_0 then
				arg_463_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_466_5 = 0

			if var_466_5 < arg_463_1.time_ and arg_463_1.time_ <= var_466_5 + arg_466_0 then
				arg_463_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_466_6 = 0
			local var_466_7 = 0.525

			if var_466_6 < arg_463_1.time_ and arg_463_1.time_ <= var_466_6 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_8 = arg_463_1:FormatText(StoryNameCfg[8].name)

				arg_463_1.leftNameTxt_.text = var_466_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_9 = arg_463_1:GetWordFromCfg(114803109)
				local var_466_10 = arg_463_1:FormatText(var_466_9.content)

				arg_463_1.text_.text = var_466_10

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_11 = 21
				local var_466_12 = utf8.len(var_466_10)
				local var_466_13 = var_466_11 <= 0 and var_466_7 or var_466_7 * (var_466_12 / var_466_11)

				if var_466_13 > 0 and var_466_7 < var_466_13 then
					arg_463_1.talkMaxDuration = var_466_13

					if var_466_13 + var_466_6 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_13 + var_466_6
					end
				end

				arg_463_1.text_.text = var_466_10
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803109", "story_v_side_old_114803.awb") ~= 0 then
					local var_466_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803109", "story_v_side_old_114803.awb") / 1000

					if var_466_14 + var_466_6 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_14 + var_466_6
					end

					if var_466_9.prefab_name ~= "" and arg_463_1.actors_[var_466_9.prefab_name] ~= nil then
						local var_466_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_9.prefab_name].transform, "story_v_side_old_114803", "114803109", "story_v_side_old_114803.awb")

						arg_463_1:RecordAudio("114803109", var_466_15)
						arg_463_1:RecordAudio("114803109", var_466_15)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803109", "story_v_side_old_114803.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803109", "story_v_side_old_114803.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_16 = math.max(var_466_7, arg_463_1.talkMaxDuration)

			if var_466_6 <= arg_463_1.time_ and arg_463_1.time_ < var_466_6 + var_466_16 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_6) / var_466_16

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_6 + var_466_16 and arg_463_1.time_ < var_466_6 + var_466_16 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play114803110 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 114803110
		arg_467_1.duration_ = 8.43

		local var_467_0 = {
			ja = 6.133,
			ko = 8.433,
			zh = 7.233,
			en = 5.5
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play114803111(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0

			if var_470_0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_0 + arg_470_0 then
				arg_467_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_470_1 = 0
			local var_470_2 = 0.775

			if var_470_1 < arg_467_1.time_ and arg_467_1.time_ <= var_470_1 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				local var_470_3 = arg_467_1:FormatText(StoryNameCfg[8].name)

				arg_467_1.leftNameTxt_.text = var_470_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_4 = arg_467_1:GetWordFromCfg(114803110)
				local var_470_5 = arg_467_1:FormatText(var_470_4.content)

				arg_467_1.text_.text = var_470_5

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_6 = 31
				local var_470_7 = utf8.len(var_470_5)
				local var_470_8 = var_470_6 <= 0 and var_470_2 or var_470_2 * (var_470_7 / var_470_6)

				if var_470_8 > 0 and var_470_2 < var_470_8 then
					arg_467_1.talkMaxDuration = var_470_8

					if var_470_8 + var_470_1 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_8 + var_470_1
					end
				end

				arg_467_1.text_.text = var_470_5
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803110", "story_v_side_old_114803.awb") ~= 0 then
					local var_470_9 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803110", "story_v_side_old_114803.awb") / 1000

					if var_470_9 + var_470_1 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_9 + var_470_1
					end

					if var_470_4.prefab_name ~= "" and arg_467_1.actors_[var_470_4.prefab_name] ~= nil then
						local var_470_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_4.prefab_name].transform, "story_v_side_old_114803", "114803110", "story_v_side_old_114803.awb")

						arg_467_1:RecordAudio("114803110", var_470_10)
						arg_467_1:RecordAudio("114803110", var_470_10)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803110", "story_v_side_old_114803.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803110", "story_v_side_old_114803.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_11 = math.max(var_470_2, arg_467_1.talkMaxDuration)

			if var_470_1 <= arg_467_1.time_ and arg_467_1.time_ < var_470_1 + var_470_11 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_1) / var_470_11

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_1 + var_470_11 and arg_467_1.time_ < var_470_1 + var_470_11 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play114803111 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 114803111
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play114803112(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0

			if var_474_0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_0 + arg_474_0 then
				arg_471_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_474_1 = 0
			local var_474_2 = 0.775

			if var_474_1 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_3 = arg_471_1:GetWordFromCfg(114803111)
				local var_474_4 = arg_471_1:FormatText(var_474_3.content)

				arg_471_1.text_.text = var_474_4

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_5 = 31
				local var_474_6 = utf8.len(var_474_4)
				local var_474_7 = var_474_5 <= 0 and var_474_2 or var_474_2 * (var_474_6 / var_474_5)

				if var_474_7 > 0 and var_474_2 < var_474_7 then
					arg_471_1.talkMaxDuration = var_474_7

					if var_474_7 + var_474_1 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_7 + var_474_1
					end
				end

				arg_471_1.text_.text = var_474_4
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_8 = math.max(var_474_2, arg_471_1.talkMaxDuration)

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_8 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_1) / var_474_8

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_1 + var_474_8 and arg_471_1.time_ < var_474_1 + var_474_8 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play114803112 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 114803112
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play114803113(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0

			if var_478_0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_0 + arg_478_0 then
				arg_475_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_478_1 = 0
			local var_478_2 = 1.075

			if var_478_1 < arg_475_1.time_ and arg_475_1.time_ <= var_478_1 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_3 = arg_475_1:FormatText(StoryNameCfg[7].name)

				arg_475_1.leftNameTxt_.text = var_478_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, true)
				arg_475_1.iconController_:SetSelectedState("hero")

				arg_475_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_475_1.callingController_:SetSelectedState("normal")

				arg_475_1.keyicon_.color = Color.New(1, 1, 1)
				arg_475_1.icon_.color = Color.New(1, 1, 1)

				local var_478_4 = arg_475_1:GetWordFromCfg(114803112)
				local var_478_5 = arg_475_1:FormatText(var_478_4.content)

				arg_475_1.text_.text = var_478_5

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_6 = 43
				local var_478_7 = utf8.len(var_478_5)
				local var_478_8 = var_478_6 <= 0 and var_478_2 or var_478_2 * (var_478_7 / var_478_6)

				if var_478_8 > 0 and var_478_2 < var_478_8 then
					arg_475_1.talkMaxDuration = var_478_8

					if var_478_8 + var_478_1 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_8 + var_478_1
					end
				end

				arg_475_1.text_.text = var_478_5
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_9 = math.max(var_478_2, arg_475_1.talkMaxDuration)

			if var_478_1 <= arg_475_1.time_ and arg_475_1.time_ < var_478_1 + var_478_9 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_1) / var_478_9

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_1 + var_478_9 and arg_475_1.time_ < var_478_1 + var_478_9 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play114803113 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 114803113
		arg_479_1.duration_ = 2

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play114803114(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = arg_479_1.actors_["1148ui_story"]
			local var_482_1 = 0

			if var_482_1 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.characterEffect1148ui_story == nil then
				arg_479_1.var_.characterEffect1148ui_story = var_482_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_2 = 0.2

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_2 and not isNil(var_482_0) then
				local var_482_3 = (arg_479_1.time_ - var_482_1) / var_482_2

				if arg_479_1.var_.characterEffect1148ui_story and not isNil(var_482_0) then
					arg_479_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_479_1.time_ >= var_482_1 + var_482_2 and arg_479_1.time_ < var_482_1 + var_482_2 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.characterEffect1148ui_story then
				arg_479_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_482_4 = 0

			if var_482_4 < arg_479_1.time_ and arg_479_1.time_ <= var_482_4 + arg_482_0 then
				arg_479_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_1")
			end

			local var_482_5 = 0

			if var_482_5 < arg_479_1.time_ and arg_479_1.time_ <= var_482_5 + arg_482_0 then
				arg_479_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_482_6 = 0
			local var_482_7 = 0.075

			if var_482_6 < arg_479_1.time_ and arg_479_1.time_ <= var_482_6 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_8 = arg_479_1:FormatText(StoryNameCfg[8].name)

				arg_479_1.leftNameTxt_.text = var_482_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_9 = arg_479_1:GetWordFromCfg(114803113)
				local var_482_10 = arg_479_1:FormatText(var_482_9.content)

				arg_479_1.text_.text = var_482_10

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_11 = 3
				local var_482_12 = utf8.len(var_482_10)
				local var_482_13 = var_482_11 <= 0 and var_482_7 or var_482_7 * (var_482_12 / var_482_11)

				if var_482_13 > 0 and var_482_7 < var_482_13 then
					arg_479_1.talkMaxDuration = var_482_13

					if var_482_13 + var_482_6 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_13 + var_482_6
					end
				end

				arg_479_1.text_.text = var_482_10
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114803", "114803113", "story_v_side_old_114803.awb") ~= 0 then
					local var_482_14 = manager.audio:GetVoiceLength("story_v_side_old_114803", "114803113", "story_v_side_old_114803.awb") / 1000

					if var_482_14 + var_482_6 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_14 + var_482_6
					end

					if var_482_9.prefab_name ~= "" and arg_479_1.actors_[var_482_9.prefab_name] ~= nil then
						local var_482_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_9.prefab_name].transform, "story_v_side_old_114803", "114803113", "story_v_side_old_114803.awb")

						arg_479_1:RecordAudio("114803113", var_482_15)
						arg_479_1:RecordAudio("114803113", var_482_15)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_side_old_114803", "114803113", "story_v_side_old_114803.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_side_old_114803", "114803113", "story_v_side_old_114803.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_16 = math.max(var_482_7, arg_479_1.talkMaxDuration)

			if var_482_6 <= arg_479_1.time_ and arg_479_1.time_ < var_482_6 + var_482_16 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_6) / var_482_16

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_6 + var_482_16 and arg_479_1.time_ < var_482_6 + var_482_16 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play114803114 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 114803114
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play114803115(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = arg_483_1.actors_["1148ui_story"]
			local var_486_1 = 0

			if var_486_1 < arg_483_1.time_ and arg_483_1.time_ <= var_486_1 + arg_486_0 and not isNil(var_486_0) and arg_483_1.var_.characterEffect1148ui_story == nil then
				arg_483_1.var_.characterEffect1148ui_story = var_486_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_2 = 0.2

			if var_486_1 <= arg_483_1.time_ and arg_483_1.time_ < var_486_1 + var_486_2 and not isNil(var_486_0) then
				local var_486_3 = (arg_483_1.time_ - var_486_1) / var_486_2

				if arg_483_1.var_.characterEffect1148ui_story and not isNil(var_486_0) then
					local var_486_4 = Mathf.Lerp(0, 0.5, var_486_3)

					arg_483_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_483_1.var_.characterEffect1148ui_story.fillRatio = var_486_4
				end
			end

			if arg_483_1.time_ >= var_486_1 + var_486_2 and arg_483_1.time_ < var_486_1 + var_486_2 + arg_486_0 and not isNil(var_486_0) and arg_483_1.var_.characterEffect1148ui_story then
				local var_486_5 = 0.5

				arg_483_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_483_1.var_.characterEffect1148ui_story.fillRatio = var_486_5
			end

			local var_486_6 = 0

			if var_486_6 < arg_483_1.time_ and arg_483_1.time_ <= var_486_6 + arg_486_0 then
				arg_483_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_486_7 = 0
			local var_486_8 = 0.4

			if var_486_7 < arg_483_1.time_ and arg_483_1.time_ <= var_486_7 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_9 = arg_483_1:GetWordFromCfg(114803114)
				local var_486_10 = arg_483_1:FormatText(var_486_9.content)

				arg_483_1.text_.text = var_486_10

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_11 = 16
				local var_486_12 = utf8.len(var_486_10)
				local var_486_13 = var_486_11 <= 0 and var_486_8 or var_486_8 * (var_486_12 / var_486_11)

				if var_486_13 > 0 and var_486_8 < var_486_13 then
					arg_483_1.talkMaxDuration = var_486_13

					if var_486_13 + var_486_7 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_13 + var_486_7
					end
				end

				arg_483_1.text_.text = var_486_10
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_14 = math.max(var_486_8, arg_483_1.talkMaxDuration)

			if var_486_7 <= arg_483_1.time_ and arg_483_1.time_ < var_486_7 + var_486_14 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_7) / var_486_14

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_7 + var_486_14 and arg_483_1.time_ < var_486_7 + var_486_14 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/D02a",
		"TextureConfig/Background/ST02"
	},
	voices = {
		"story_v_side_old_114803.awb"
	}
}
