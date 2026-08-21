return {
	Play317302001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317302001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317302002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "D999"

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
				local var_4_5 = arg_1_1.bgs_.D999

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
					if iter_4_0 ~= "D999" then
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
			local var_4_23 = 0.2

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

			local var_4_28 = 0.3
			local var_4_29 = 0.7

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_6_story_sasanami_quiet", "bgm_activity_2_6_story_sasanami_quiet", "bgm_activity_2_6_story_sasanami_quiet.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_6_story_sasanami_quiet", "bgm_activity_2_6_story_sasanami_quiet")

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
			local var_4_35 = 1.5

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

				local var_4_37 = arg_1_1:GetWordFromCfg(317302001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 60
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
	Play317302002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 317302002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play317302003(arg_9_1)
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

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(317302002)
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
	Play317302003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 317302003
		arg_13_1.duration_ = 7.33

		local var_13_0 = {
			zh = 4.833,
			ja = 7.333
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
				arg_13_0:Play317302004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1015ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1015ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["1015ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1015ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0, -1.15, -6.2)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1015ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["1015ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1015ui_story == nil then
				arg_13_1.var_.characterEffect1015ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect1015ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1015ui_story then
				arg_13_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_20 = 0
			local var_16_21 = 0.625

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[479].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(317302003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302003", "story_v_out_317302.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_out_317302", "317302003", "story_v_out_317302.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_out_317302", "317302003", "story_v_out_317302.awb")

						arg_13_1:RecordAudio("317302003", var_16_29)
						arg_13_1:RecordAudio("317302003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_317302", "317302003", "story_v_out_317302.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_317302", "317302003", "story_v_out_317302.awb")
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
				actorName = "1015ui_story",
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
	Play317302004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 317302004
		arg_17_1.duration_ = 4.73

		local var_17_0 = {
			zh = 2.566,
			ja = 4.733
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play317302005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.325

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[479].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:GetWordFromCfg(317302004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 13
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302004", "story_v_out_317302.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_317302", "317302004", "story_v_out_317302.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_317302", "317302004", "story_v_out_317302.awb")

						arg_17_1:RecordAudio("317302004", var_20_9)
						arg_17_1:RecordAudio("317302004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_317302", "317302004", "story_v_out_317302.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_317302", "317302004", "story_v_out_317302.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play317302005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 317302005
		arg_21_1.duration_ = 11.3

		local var_21_0 = {
			zh = 6.866,
			ja = 11.3
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
				arg_21_0:Play317302006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "1093ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "1093ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_21_1.stage_.transform)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentInChildren(typeof(CharacterEffect))

					var_24_3.enabled = true

					local var_24_4 = GameObjectTools.GetOrAddComponent(var_24_2, typeof(DynamicBoneHelper))

					if var_24_4 then
						var_24_4:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_3.transform, false)

					arg_21_1.var_[var_24_0 .. "Animator"] = var_24_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_0 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_0 .. "LipSync"] = var_24_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_5 = arg_21_1.actors_["1093ui_story"].transform
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.var_.moveOldPos1093ui_story = var_24_5.localPosition
			end

			local var_24_7 = 0.001

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7
				local var_24_9 = Vector3.New(-0.7, -1.11, -5.88)

				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1093ui_story, var_24_9, var_24_8)

				local var_24_10 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_10.x, var_24_10.y, var_24_10.z)

				local var_24_11 = var_24_5.localEulerAngles

				var_24_11.z = 0
				var_24_11.x = 0
				var_24_5.localEulerAngles = var_24_11
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(-0.7, -1.11, -5.88)

				local var_24_12 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_12.x, var_24_12.y, var_24_12.z)

				local var_24_13 = var_24_5.localEulerAngles

				var_24_13.z = 0
				var_24_13.x = 0
				var_24_5.localEulerAngles = var_24_13
			end

			local var_24_14 = arg_21_1.actors_["1093ui_story"]
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect1093ui_story == nil then
				arg_21_1.var_.characterEffect1093ui_story = var_24_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_16 = 0.200000002980232

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 and not isNil(var_24_14) then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16

				if arg_21_1.var_.characterEffect1093ui_story and not isNil(var_24_14) then
					arg_21_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect1093ui_story then
				arg_21_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_24_18 = 0

			if var_24_18 < arg_21_1.time_ and arg_21_1.time_ <= var_24_18 + arg_24_0 then
				arg_21_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_24_19 = 0

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 then
				arg_21_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_20 = arg_21_1.actors_["1015ui_story"].transform
			local var_24_21 = 0

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 then
				arg_21_1.var_.moveOldPos1015ui_story = var_24_20.localPosition
			end

			local var_24_22 = 0.001

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_22 then
				local var_24_23 = (arg_21_1.time_ - var_24_21) / var_24_22
				local var_24_24 = Vector3.New(0, 100, 0)

				var_24_20.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1015ui_story, var_24_24, var_24_23)

				local var_24_25 = manager.ui.mainCamera.transform.position - var_24_20.position

				var_24_20.forward = Vector3.New(var_24_25.x, var_24_25.y, var_24_25.z)

				local var_24_26 = var_24_20.localEulerAngles

				var_24_26.z = 0
				var_24_26.x = 0
				var_24_20.localEulerAngles = var_24_26
			end

			if arg_21_1.time_ >= var_24_21 + var_24_22 and arg_21_1.time_ < var_24_21 + var_24_22 + arg_24_0 then
				var_24_20.localPosition = Vector3.New(0, 100, 0)

				local var_24_27 = manager.ui.mainCamera.transform.position - var_24_20.position

				var_24_20.forward = Vector3.New(var_24_27.x, var_24_27.y, var_24_27.z)

				local var_24_28 = var_24_20.localEulerAngles

				var_24_28.z = 0
				var_24_28.x = 0
				var_24_20.localEulerAngles = var_24_28
			end

			local var_24_29 = arg_21_1.actors_["1015ui_story"]
			local var_24_30 = 0

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 and not isNil(var_24_29) and arg_21_1.var_.characterEffect1015ui_story == nil then
				arg_21_1.var_.characterEffect1015ui_story = var_24_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_31 = 0.200000002980232

			if var_24_30 <= arg_21_1.time_ and arg_21_1.time_ < var_24_30 + var_24_31 and not isNil(var_24_29) then
				local var_24_32 = (arg_21_1.time_ - var_24_30) / var_24_31

				if arg_21_1.var_.characterEffect1015ui_story and not isNil(var_24_29) then
					local var_24_33 = Mathf.Lerp(0, 0.5, var_24_32)

					arg_21_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1015ui_story.fillRatio = var_24_33
				end
			end

			if arg_21_1.time_ >= var_24_30 + var_24_31 and arg_21_1.time_ < var_24_30 + var_24_31 + arg_24_0 and not isNil(var_24_29) and arg_21_1.var_.characterEffect1015ui_story then
				local var_24_34 = 0.5

				arg_21_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1015ui_story.fillRatio = var_24_34
			end

			local var_24_35 = "1199ui_story"

			if arg_21_1.actors_[var_24_35] == nil then
				local var_24_36 = Asset.Load("Char/" .. "1199ui_story")

				if not isNil(var_24_36) then
					local var_24_37 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_21_1.stage_.transform)

					var_24_37.name = var_24_35
					var_24_37.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_35] = var_24_37

					local var_24_38 = var_24_37:GetComponentInChildren(typeof(CharacterEffect))

					var_24_38.enabled = true

					local var_24_39 = GameObjectTools.GetOrAddComponent(var_24_37, typeof(DynamicBoneHelper))

					if var_24_39 then
						var_24_39:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_38.transform, false)

					arg_21_1.var_[var_24_35 .. "Animator"] = var_24_38.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_35 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_35 .. "LipSync"] = var_24_38.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_40 = arg_21_1.actors_["1199ui_story"].transform
			local var_24_41 = 0

			if var_24_41 < arg_21_1.time_ and arg_21_1.time_ <= var_24_41 + arg_24_0 then
				arg_21_1.var_.moveOldPos1199ui_story = var_24_40.localPosition
			end

			local var_24_42 = 0.001

			if var_24_41 <= arg_21_1.time_ and arg_21_1.time_ < var_24_41 + var_24_42 then
				local var_24_43 = (arg_21_1.time_ - var_24_41) / var_24_42
				local var_24_44 = Vector3.New(0.7, -1.08, -5.9)

				var_24_40.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1199ui_story, var_24_44, var_24_43)

				local var_24_45 = manager.ui.mainCamera.transform.position - var_24_40.position

				var_24_40.forward = Vector3.New(var_24_45.x, var_24_45.y, var_24_45.z)

				local var_24_46 = var_24_40.localEulerAngles

				var_24_46.z = 0
				var_24_46.x = 0
				var_24_40.localEulerAngles = var_24_46
			end

			if arg_21_1.time_ >= var_24_41 + var_24_42 and arg_21_1.time_ < var_24_41 + var_24_42 + arg_24_0 then
				var_24_40.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_24_47 = manager.ui.mainCamera.transform.position - var_24_40.position

				var_24_40.forward = Vector3.New(var_24_47.x, var_24_47.y, var_24_47.z)

				local var_24_48 = var_24_40.localEulerAngles

				var_24_48.z = 0
				var_24_48.x = 0
				var_24_40.localEulerAngles = var_24_48
			end

			local var_24_49 = 0

			if var_24_49 < arg_21_1.time_ and arg_21_1.time_ <= var_24_49 + arg_24_0 then
				arg_21_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			local var_24_50 = arg_21_1.actors_["1199ui_story"]
			local var_24_51 = 0

			if var_24_51 < arg_21_1.time_ and arg_21_1.time_ <= var_24_51 + arg_24_0 and not isNil(var_24_50) and arg_21_1.var_.characterEffect1199ui_story == nil then
				arg_21_1.var_.characterEffect1199ui_story = var_24_50:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_52 = 0.0166666666666667

			if var_24_51 <= arg_21_1.time_ and arg_21_1.time_ < var_24_51 + var_24_52 and not isNil(var_24_50) then
				local var_24_53 = (arg_21_1.time_ - var_24_51) / var_24_52

				if arg_21_1.var_.characterEffect1199ui_story and not isNil(var_24_50) then
					local var_24_54 = Mathf.Lerp(0, 0.5, var_24_53)

					arg_21_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1199ui_story.fillRatio = var_24_54
				end
			end

			if arg_21_1.time_ >= var_24_51 + var_24_52 and arg_21_1.time_ < var_24_51 + var_24_52 + arg_24_0 and not isNil(var_24_50) and arg_21_1.var_.characterEffect1199ui_story then
				local var_24_55 = 0.5

				arg_21_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1199ui_story.fillRatio = var_24_55
			end

			local var_24_56 = 0
			local var_24_57 = 0.675

			if var_24_56 < arg_21_1.time_ and arg_21_1.time_ <= var_24_56 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_58 = arg_21_1:FormatText(StoryNameCfg[73].name)

				arg_21_1.leftNameTxt_.text = var_24_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_59 = arg_21_1:GetWordFromCfg(317302005)
				local var_24_60 = arg_21_1:FormatText(var_24_59.content)

				arg_21_1.text_.text = var_24_60

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_61 = 27
				local var_24_62 = utf8.len(var_24_60)
				local var_24_63 = var_24_61 <= 0 and var_24_57 or var_24_57 * (var_24_62 / var_24_61)

				if var_24_63 > 0 and var_24_57 < var_24_63 then
					arg_21_1.talkMaxDuration = var_24_63

					if var_24_63 + var_24_56 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_63 + var_24_56
					end
				end

				arg_21_1.text_.text = var_24_60
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302005", "story_v_out_317302.awb") ~= 0 then
					local var_24_64 = manager.audio:GetVoiceLength("story_v_out_317302", "317302005", "story_v_out_317302.awb") / 1000

					if var_24_64 + var_24_56 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_64 + var_24_56
					end

					if var_24_59.prefab_name ~= "" and arg_21_1.actors_[var_24_59.prefab_name] ~= nil then
						local var_24_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_59.prefab_name].transform, "story_v_out_317302", "317302005", "story_v_out_317302.awb")

						arg_21_1:RecordAudio("317302005", var_24_65)
						arg_21_1:RecordAudio("317302005", var_24_65)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_317302", "317302005", "story_v_out_317302.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_317302", "317302005", "story_v_out_317302.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_66 = math.max(var_24_57, arg_21_1.talkMaxDuration)

			if var_24_56 <= arg_21_1.time_ and arg_21_1.time_ < var_24_56 + var_24_66 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_56) / var_24_66

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_56 + var_24_66 and arg_21_1.time_ < var_24_56 + var_24_66 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play317302006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 317302006
		arg_25_1.duration_ = 13.6

		local var_25_0 = {
			zh = 13.6,
			ja = 9.4
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
				arg_25_0:Play317302007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1199ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1199ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0.7, -1.08, -5.9)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1199ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["1199ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1199ui_story == nil then
				arg_25_1.var_.characterEffect1199ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect1199ui_story and not isNil(var_28_9) then
					arg_25_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1199ui_story then
				arg_25_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_28_13 = 0

			if var_28_13 < arg_25_1.time_ and arg_25_1.time_ <= var_28_13 + arg_28_0 then
				arg_25_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			local var_28_14 = 0

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_15 = arg_25_1.actors_["1093ui_story"]
			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.characterEffect1093ui_story == nil then
				arg_25_1.var_.characterEffect1093ui_story = var_28_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_17 = 0.200000002980232

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 and not isNil(var_28_15) then
				local var_28_18 = (arg_25_1.time_ - var_28_16) / var_28_17

				if arg_25_1.var_.characterEffect1093ui_story and not isNil(var_28_15) then
					local var_28_19 = Mathf.Lerp(0, 0.5, var_28_18)

					arg_25_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1093ui_story.fillRatio = var_28_19
				end
			end

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.characterEffect1093ui_story then
				local var_28_20 = 0.5

				arg_25_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1093ui_story.fillRatio = var_28_20
			end

			local var_28_21 = 0
			local var_28_22 = 1.5

			if var_28_21 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_23 = arg_25_1:FormatText(StoryNameCfg[84].name)

				arg_25_1.leftNameTxt_.text = var_28_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_24 = arg_25_1:GetWordFromCfg(317302006)
				local var_28_25 = arg_25_1:FormatText(var_28_24.content)

				arg_25_1.text_.text = var_28_25

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_26 = 60
				local var_28_27 = utf8.len(var_28_25)
				local var_28_28 = var_28_26 <= 0 and var_28_22 or var_28_22 * (var_28_27 / var_28_26)

				if var_28_28 > 0 and var_28_22 < var_28_28 then
					arg_25_1.talkMaxDuration = var_28_28

					if var_28_28 + var_28_21 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_28 + var_28_21
					end
				end

				arg_25_1.text_.text = var_28_25
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302006", "story_v_out_317302.awb") ~= 0 then
					local var_28_29 = manager.audio:GetVoiceLength("story_v_out_317302", "317302006", "story_v_out_317302.awb") / 1000

					if var_28_29 + var_28_21 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_29 + var_28_21
					end

					if var_28_24.prefab_name ~= "" and arg_25_1.actors_[var_28_24.prefab_name] ~= nil then
						local var_28_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_24.prefab_name].transform, "story_v_out_317302", "317302006", "story_v_out_317302.awb")

						arg_25_1:RecordAudio("317302006", var_28_30)
						arg_25_1:RecordAudio("317302006", var_28_30)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_317302", "317302006", "story_v_out_317302.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_317302", "317302006", "story_v_out_317302.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_31 = math.max(var_28_22, arg_25_1.talkMaxDuration)

			if var_28_21 <= arg_25_1.time_ and arg_25_1.time_ < var_28_21 + var_28_31 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_21) / var_28_31

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_21 + var_28_31 and arg_25_1.time_ < var_28_21 + var_28_31 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play317302007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 317302007
		arg_29_1.duration_ = 7

		local var_29_0 = {
			zh = 3.666,
			ja = 7
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
				arg_29_0:Play317302008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1093ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1093ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0, 100, 0)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1093ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, 100, 0)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["1093ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1093ui_story == nil then
				arg_29_1.var_.characterEffect1093ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect1093ui_story and not isNil(var_32_9) then
					local var_32_13 = Mathf.Lerp(0, 0.5, var_32_12)

					arg_29_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1093ui_story.fillRatio = var_32_13
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1093ui_story then
				local var_32_14 = 0.5

				arg_29_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1093ui_story.fillRatio = var_32_14
			end

			local var_32_15 = arg_29_1.actors_["1199ui_story"].transform
			local var_32_16 = 0

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.var_.moveOldPos1199ui_story = var_32_15.localPosition
			end

			local var_32_17 = 0.001

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_17 then
				local var_32_18 = (arg_29_1.time_ - var_32_16) / var_32_17
				local var_32_19 = Vector3.New(0, 100, 0)

				var_32_15.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1199ui_story, var_32_19, var_32_18)

				local var_32_20 = manager.ui.mainCamera.transform.position - var_32_15.position

				var_32_15.forward = Vector3.New(var_32_20.x, var_32_20.y, var_32_20.z)

				local var_32_21 = var_32_15.localEulerAngles

				var_32_21.z = 0
				var_32_21.x = 0
				var_32_15.localEulerAngles = var_32_21
			end

			if arg_29_1.time_ >= var_32_16 + var_32_17 and arg_29_1.time_ < var_32_16 + var_32_17 + arg_32_0 then
				var_32_15.localPosition = Vector3.New(0, 100, 0)

				local var_32_22 = manager.ui.mainCamera.transform.position - var_32_15.position

				var_32_15.forward = Vector3.New(var_32_22.x, var_32_22.y, var_32_22.z)

				local var_32_23 = var_32_15.localEulerAngles

				var_32_23.z = 0
				var_32_23.x = 0
				var_32_15.localEulerAngles = var_32_23
			end

			local var_32_24 = arg_29_1.actors_["1199ui_story"]
			local var_32_25 = 0

			if var_32_25 < arg_29_1.time_ and arg_29_1.time_ <= var_32_25 + arg_32_0 and not isNil(var_32_24) and arg_29_1.var_.characterEffect1199ui_story == nil then
				arg_29_1.var_.characterEffect1199ui_story = var_32_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_26 = 0.200000002980232

			if var_32_25 <= arg_29_1.time_ and arg_29_1.time_ < var_32_25 + var_32_26 and not isNil(var_32_24) then
				local var_32_27 = (arg_29_1.time_ - var_32_25) / var_32_26

				if arg_29_1.var_.characterEffect1199ui_story and not isNil(var_32_24) then
					local var_32_28 = Mathf.Lerp(0, 0.5, var_32_27)

					arg_29_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1199ui_story.fillRatio = var_32_28
				end
			end

			if arg_29_1.time_ >= var_32_25 + var_32_26 and arg_29_1.time_ < var_32_25 + var_32_26 + arg_32_0 and not isNil(var_32_24) and arg_29_1.var_.characterEffect1199ui_story then
				local var_32_29 = 0.5

				arg_29_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1199ui_story.fillRatio = var_32_29
			end

			local var_32_30 = arg_29_1.actors_["1015ui_story"].transform
			local var_32_31 = 0

			if var_32_31 < arg_29_1.time_ and arg_29_1.time_ <= var_32_31 + arg_32_0 then
				arg_29_1.var_.moveOldPos1015ui_story = var_32_30.localPosition
			end

			local var_32_32 = 0.001

			if var_32_31 <= arg_29_1.time_ and arg_29_1.time_ < var_32_31 + var_32_32 then
				local var_32_33 = (arg_29_1.time_ - var_32_31) / var_32_32
				local var_32_34 = Vector3.New(0, -1.15, -6.2)

				var_32_30.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1015ui_story, var_32_34, var_32_33)

				local var_32_35 = manager.ui.mainCamera.transform.position - var_32_30.position

				var_32_30.forward = Vector3.New(var_32_35.x, var_32_35.y, var_32_35.z)

				local var_32_36 = var_32_30.localEulerAngles

				var_32_36.z = 0
				var_32_36.x = 0
				var_32_30.localEulerAngles = var_32_36
			end

			if arg_29_1.time_ >= var_32_31 + var_32_32 and arg_29_1.time_ < var_32_31 + var_32_32 + arg_32_0 then
				var_32_30.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_32_37 = manager.ui.mainCamera.transform.position - var_32_30.position

				var_32_30.forward = Vector3.New(var_32_37.x, var_32_37.y, var_32_37.z)

				local var_32_38 = var_32_30.localEulerAngles

				var_32_38.z = 0
				var_32_38.x = 0
				var_32_30.localEulerAngles = var_32_38
			end

			local var_32_39 = arg_29_1.actors_["1015ui_story"]
			local var_32_40 = 0

			if var_32_40 < arg_29_1.time_ and arg_29_1.time_ <= var_32_40 + arg_32_0 and not isNil(var_32_39) and arg_29_1.var_.characterEffect1015ui_story == nil then
				arg_29_1.var_.characterEffect1015ui_story = var_32_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_41 = 0.200000002980232

			if var_32_40 <= arg_29_1.time_ and arg_29_1.time_ < var_32_40 + var_32_41 and not isNil(var_32_39) then
				local var_32_42 = (arg_29_1.time_ - var_32_40) / var_32_41

				if arg_29_1.var_.characterEffect1015ui_story and not isNil(var_32_39) then
					arg_29_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_40 + var_32_41 and arg_29_1.time_ < var_32_40 + var_32_41 + arg_32_0 and not isNil(var_32_39) and arg_29_1.var_.characterEffect1015ui_story then
				arg_29_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_32_43 = 0

			if var_32_43 < arg_29_1.time_ and arg_29_1.time_ <= var_32_43 + arg_32_0 then
				arg_29_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_32_44 = 0

			if var_32_44 < arg_29_1.time_ and arg_29_1.time_ <= var_32_44 + arg_32_0 then
				arg_29_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_45 = 0
			local var_32_46 = 0.525

			if var_32_45 < arg_29_1.time_ and arg_29_1.time_ <= var_32_45 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_47 = arg_29_1:FormatText(StoryNameCfg[479].name)

				arg_29_1.leftNameTxt_.text = var_32_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_48 = arg_29_1:GetWordFromCfg(317302007)
				local var_32_49 = arg_29_1:FormatText(var_32_48.content)

				arg_29_1.text_.text = var_32_49

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_50 = 21
				local var_32_51 = utf8.len(var_32_49)
				local var_32_52 = var_32_50 <= 0 and var_32_46 or var_32_46 * (var_32_51 / var_32_50)

				if var_32_52 > 0 and var_32_46 < var_32_52 then
					arg_29_1.talkMaxDuration = var_32_52

					if var_32_52 + var_32_45 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_52 + var_32_45
					end
				end

				arg_29_1.text_.text = var_32_49
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302007", "story_v_out_317302.awb") ~= 0 then
					local var_32_53 = manager.audio:GetVoiceLength("story_v_out_317302", "317302007", "story_v_out_317302.awb") / 1000

					if var_32_53 + var_32_45 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_53 + var_32_45
					end

					if var_32_48.prefab_name ~= "" and arg_29_1.actors_[var_32_48.prefab_name] ~= nil then
						local var_32_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_48.prefab_name].transform, "story_v_out_317302", "317302007", "story_v_out_317302.awb")

						arg_29_1:RecordAudio("317302007", var_32_54)
						arg_29_1:RecordAudio("317302007", var_32_54)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_317302", "317302007", "story_v_out_317302.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_317302", "317302007", "story_v_out_317302.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_55 = math.max(var_32_46, arg_29_1.talkMaxDuration)

			if var_32_45 <= arg_29_1.time_ and arg_29_1.time_ < var_32_45 + var_32_55 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_45) / var_32_55

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_45 + var_32_55 and arg_29_1.time_ < var_32_45 + var_32_55 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play317302008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 317302008
		arg_33_1.duration_ = 4.73

		local var_33_0 = {
			zh = 1.999999999999,
			ja = 4.733
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
				arg_33_0:Play317302009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1199ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1199ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0, -1.08, -5.9)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1199ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["1199ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1199ui_story == nil then
				arg_33_1.var_.characterEffect1199ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect1199ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1199ui_story then
				arg_33_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_2")
			end

			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_15 = arg_33_1.actors_["1015ui_story"].transform
			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.var_.moveOldPos1015ui_story = var_36_15.localPosition
			end

			local var_36_17 = 0.001

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 then
				local var_36_18 = (arg_33_1.time_ - var_36_16) / var_36_17
				local var_36_19 = Vector3.New(0, 100, 0)

				var_36_15.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1015ui_story, var_36_19, var_36_18)

				local var_36_20 = manager.ui.mainCamera.transform.position - var_36_15.position

				var_36_15.forward = Vector3.New(var_36_20.x, var_36_20.y, var_36_20.z)

				local var_36_21 = var_36_15.localEulerAngles

				var_36_21.z = 0
				var_36_21.x = 0
				var_36_15.localEulerAngles = var_36_21
			end

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 then
				var_36_15.localPosition = Vector3.New(0, 100, 0)

				local var_36_22 = manager.ui.mainCamera.transform.position - var_36_15.position

				var_36_15.forward = Vector3.New(var_36_22.x, var_36_22.y, var_36_22.z)

				local var_36_23 = var_36_15.localEulerAngles

				var_36_23.z = 0
				var_36_23.x = 0
				var_36_15.localEulerAngles = var_36_23
			end

			local var_36_24 = arg_33_1.actors_["1015ui_story"]
			local var_36_25 = 0

			if var_36_25 < arg_33_1.time_ and arg_33_1.time_ <= var_36_25 + arg_36_0 and not isNil(var_36_24) and arg_33_1.var_.characterEffect1015ui_story == nil then
				arg_33_1.var_.characterEffect1015ui_story = var_36_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_26 = 0.200000002980232

			if var_36_25 <= arg_33_1.time_ and arg_33_1.time_ < var_36_25 + var_36_26 and not isNil(var_36_24) then
				local var_36_27 = (arg_33_1.time_ - var_36_25) / var_36_26

				if arg_33_1.var_.characterEffect1015ui_story and not isNil(var_36_24) then
					local var_36_28 = Mathf.Lerp(0, 0.5, var_36_27)

					arg_33_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1015ui_story.fillRatio = var_36_28
				end
			end

			if arg_33_1.time_ >= var_36_25 + var_36_26 and arg_33_1.time_ < var_36_25 + var_36_26 + arg_36_0 and not isNil(var_36_24) and arg_33_1.var_.characterEffect1015ui_story then
				local var_36_29 = 0.5

				arg_33_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1015ui_story.fillRatio = var_36_29
			end

			local var_36_30 = 0
			local var_36_31 = 0.275

			if var_36_30 < arg_33_1.time_ and arg_33_1.time_ <= var_36_30 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_32 = arg_33_1:FormatText(StoryNameCfg[84].name)

				arg_33_1.leftNameTxt_.text = var_36_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_33 = arg_33_1:GetWordFromCfg(317302008)
				local var_36_34 = arg_33_1:FormatText(var_36_33.content)

				arg_33_1.text_.text = var_36_34

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_35 = 11
				local var_36_36 = utf8.len(var_36_34)
				local var_36_37 = var_36_35 <= 0 and var_36_31 or var_36_31 * (var_36_36 / var_36_35)

				if var_36_37 > 0 and var_36_31 < var_36_37 then
					arg_33_1.talkMaxDuration = var_36_37

					if var_36_37 + var_36_30 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_37 + var_36_30
					end
				end

				arg_33_1.text_.text = var_36_34
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302008", "story_v_out_317302.awb") ~= 0 then
					local var_36_38 = manager.audio:GetVoiceLength("story_v_out_317302", "317302008", "story_v_out_317302.awb") / 1000

					if var_36_38 + var_36_30 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_38 + var_36_30
					end

					if var_36_33.prefab_name ~= "" and arg_33_1.actors_[var_36_33.prefab_name] ~= nil then
						local var_36_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_33.prefab_name].transform, "story_v_out_317302", "317302008", "story_v_out_317302.awb")

						arg_33_1:RecordAudio("317302008", var_36_39)
						arg_33_1:RecordAudio("317302008", var_36_39)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_317302", "317302008", "story_v_out_317302.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_317302", "317302008", "story_v_out_317302.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_40 = math.max(var_36_31, arg_33_1.talkMaxDuration)

			if var_36_30 <= arg_33_1.time_ and arg_33_1.time_ < var_36_30 + var_36_40 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_30) / var_36_40

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_30 + var_36_40 and arg_33_1.time_ < var_36_30 + var_36_40 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play317302009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 317302009
		arg_37_1.duration_ = 7.73

		local var_37_0 = {
			zh = 7.733,
			ja = 6.566
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
				arg_37_0:Play317302010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 1.05

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[84].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(317302009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 42
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302009", "story_v_out_317302.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_317302", "317302009", "story_v_out_317302.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_317302", "317302009", "story_v_out_317302.awb")

						arg_37_1:RecordAudio("317302009", var_40_9)
						arg_37_1:RecordAudio("317302009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_317302", "317302009", "story_v_out_317302.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_317302", "317302009", "story_v_out_317302.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_10 and arg_37_1.time_ < var_40_0 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play317302010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 317302010
		arg_41_1.duration_ = 7.57

		local var_41_0 = {
			zh = 4.5,
			ja = 7.566
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play317302011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_44_1 = 0
			local var_44_2 = 0.5

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_3 = arg_41_1:FormatText(StoryNameCfg[84].name)

				arg_41_1.leftNameTxt_.text = var_44_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(317302010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_6 = 20
				local var_44_7 = utf8.len(var_44_5)
				local var_44_8 = var_44_6 <= 0 and var_44_2 or var_44_2 * (var_44_7 / var_44_6)

				if var_44_8 > 0 and var_44_2 < var_44_8 then
					arg_41_1.talkMaxDuration = var_44_8

					if var_44_8 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302010", "story_v_out_317302.awb") ~= 0 then
					local var_44_9 = manager.audio:GetVoiceLength("story_v_out_317302", "317302010", "story_v_out_317302.awb") / 1000

					if var_44_9 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_1
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_317302", "317302010", "story_v_out_317302.awb")

						arg_41_1:RecordAudio("317302010", var_44_10)
						arg_41_1:RecordAudio("317302010", var_44_10)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_317302", "317302010", "story_v_out_317302.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_317302", "317302010", "story_v_out_317302.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_11 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_11 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_11

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_11 and arg_41_1.time_ < var_44_1 + var_44_11 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play317302011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 317302011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play317302012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1199ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1199ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, 100, 0)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1199ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, 100, 0)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = 0
			local var_48_10 = 0.775

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_11 = arg_45_1:GetWordFromCfg(317302011)
				local var_48_12 = arg_45_1:FormatText(var_48_11.content)

				arg_45_1.text_.text = var_48_12

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 31
				local var_48_14 = utf8.len(var_48_12)
				local var_48_15 = var_48_13 <= 0 and var_48_10 or var_48_10 * (var_48_14 / var_48_13)

				if var_48_15 > 0 and var_48_10 < var_48_15 then
					arg_45_1.talkMaxDuration = var_48_15

					if var_48_15 + var_48_9 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_9
					end
				end

				arg_45_1.text_.text = var_48_12
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_10, arg_45_1.talkMaxDuration)

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_9) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_9 + var_48_16 and arg_45_1.time_ < var_48_9 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play317302012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 317302012
		arg_49_1.duration_ = 10.7

		local var_49_0 = {
			zh = 7,
			ja = 10.7
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
				arg_49_0:Play317302013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1015ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1015ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(0, -1.15, -6.2)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1015ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["1015ui_story"]
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1015ui_story == nil then
				arg_49_1.var_.characterEffect1015ui_story = var_52_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 and not isNil(var_52_9) then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11

				if arg_49_1.var_.characterEffect1015ui_story and not isNil(var_52_9) then
					arg_49_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1015ui_story then
				arg_49_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_52_13 = 0

			if var_52_13 < arg_49_1.time_ and arg_49_1.time_ <= var_52_13 + arg_52_0 then
				arg_49_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action6_1")
			end

			local var_52_14 = 0

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_15 = 0
			local var_52_16 = 0.625

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_17 = arg_49_1:FormatText(StoryNameCfg[479].name)

				arg_49_1.leftNameTxt_.text = var_52_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:GetWordFromCfg(317302012)
				local var_52_19 = arg_49_1:FormatText(var_52_18.content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 25
				local var_52_21 = utf8.len(var_52_19)
				local var_52_22 = var_52_20 <= 0 and var_52_16 or var_52_16 * (var_52_21 / var_52_20)

				if var_52_22 > 0 and var_52_16 < var_52_22 then
					arg_49_1.talkMaxDuration = var_52_22

					if var_52_22 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_15
					end
				end

				arg_49_1.text_.text = var_52_19
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302012", "story_v_out_317302.awb") ~= 0 then
					local var_52_23 = manager.audio:GetVoiceLength("story_v_out_317302", "317302012", "story_v_out_317302.awb") / 1000

					if var_52_23 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_15
					end

					if var_52_18.prefab_name ~= "" and arg_49_1.actors_[var_52_18.prefab_name] ~= nil then
						local var_52_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_18.prefab_name].transform, "story_v_out_317302", "317302012", "story_v_out_317302.awb")

						arg_49_1:RecordAudio("317302012", var_52_24)
						arg_49_1:RecordAudio("317302012", var_52_24)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_317302", "317302012", "story_v_out_317302.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_317302", "317302012", "story_v_out_317302.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_25 = math.max(var_52_16, arg_49_1.talkMaxDuration)

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_25 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_15) / var_52_25

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_15 + var_52_25 and arg_49_1.time_ < var_52_15 + var_52_25 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play317302013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 317302013
		arg_53_1.duration_ = 9.9

		local var_53_0 = {
			zh = 8.333,
			ja = 9.9
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
				arg_53_0:Play317302014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.025

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[479].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(317302013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 41
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302013", "story_v_out_317302.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_317302", "317302013", "story_v_out_317302.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_317302", "317302013", "story_v_out_317302.awb")

						arg_53_1:RecordAudio("317302013", var_56_9)
						arg_53_1:RecordAudio("317302013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_317302", "317302013", "story_v_out_317302.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_317302", "317302013", "story_v_out_317302.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play317302014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 317302014
		arg_57_1.duration_ = 8.53

		local var_57_0 = {
			zh = 8.533,
			ja = 4.933
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
				arg_57_0:Play317302015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.075

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[479].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(317302014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302014", "story_v_out_317302.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_317302", "317302014", "story_v_out_317302.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_317302", "317302014", "story_v_out_317302.awb")

						arg_57_1:RecordAudio("317302014", var_60_9)
						arg_57_1:RecordAudio("317302014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_317302", "317302014", "story_v_out_317302.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_317302", "317302014", "story_v_out_317302.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_10 and arg_57_1.time_ < var_60_0 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play317302015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 317302015
		arg_61_1.duration_ = 11.8

		local var_61_0 = {
			zh = 8.2,
			ja = 11.8
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
				arg_61_0:Play317302016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action6_2")
			end

			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_2 = 0
			local var_64_3 = 1.15

			if var_64_2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_4 = arg_61_1:FormatText(StoryNameCfg[479].name)

				arg_61_1.leftNameTxt_.text = var_64_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_5 = arg_61_1:GetWordFromCfg(317302015)
				local var_64_6 = arg_61_1:FormatText(var_64_5.content)

				arg_61_1.text_.text = var_64_6

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 46
				local var_64_8 = utf8.len(var_64_6)
				local var_64_9 = var_64_7 <= 0 and var_64_3 or var_64_3 * (var_64_8 / var_64_7)

				if var_64_9 > 0 and var_64_3 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_6
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302015", "story_v_out_317302.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_317302", "317302015", "story_v_out_317302.awb") / 1000

					if var_64_10 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_2
					end

					if var_64_5.prefab_name ~= "" and arg_61_1.actors_[var_64_5.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_5.prefab_name].transform, "story_v_out_317302", "317302015", "story_v_out_317302.awb")

						arg_61_1:RecordAudio("317302015", var_64_11)
						arg_61_1:RecordAudio("317302015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_317302", "317302015", "story_v_out_317302.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_317302", "317302015", "story_v_out_317302.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_12 and arg_61_1.time_ < var_64_2 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play317302016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 317302016
		arg_65_1.duration_ = 2

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play317302017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = "1158ui_story"

			if arg_65_1.actors_[var_68_0] == nil then
				local var_68_1 = Asset.Load("Char/" .. "1158ui_story")

				if not isNil(var_68_1) then
					local var_68_2 = Object.Instantiate(Asset.Load("Char/" .. "1158ui_story"), arg_65_1.stage_.transform)

					var_68_2.name = var_68_0
					var_68_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_65_1.actors_[var_68_0] = var_68_2

					local var_68_3 = var_68_2:GetComponentInChildren(typeof(CharacterEffect))

					var_68_3.enabled = true

					local var_68_4 = GameObjectTools.GetOrAddComponent(var_68_2, typeof(DynamicBoneHelper))

					if var_68_4 then
						var_68_4:EnableDynamicBone(false)
					end

					arg_65_1:ShowWeapon(var_68_3.transform, false)

					arg_65_1.var_[var_68_0 .. "Animator"] = var_68_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_65_1.var_[var_68_0 .. "Animator"].applyRootMotion = true
					arg_65_1.var_[var_68_0 .. "LipSync"] = var_68_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_68_5 = arg_65_1.actors_["1158ui_story"].transform
			local var_68_6 = 0

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.var_.moveOldPos1158ui_story = var_68_5.localPosition
			end

			local var_68_7 = 0.001

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_7 then
				local var_68_8 = (arg_65_1.time_ - var_68_6) / var_68_7
				local var_68_9 = Vector3.New(0, -0.95, -6)

				var_68_5.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1158ui_story, var_68_9, var_68_8)

				local var_68_10 = manager.ui.mainCamera.transform.position - var_68_5.position

				var_68_5.forward = Vector3.New(var_68_10.x, var_68_10.y, var_68_10.z)

				local var_68_11 = var_68_5.localEulerAngles

				var_68_11.z = 0
				var_68_11.x = 0
				var_68_5.localEulerAngles = var_68_11
			end

			if arg_65_1.time_ >= var_68_6 + var_68_7 and arg_65_1.time_ < var_68_6 + var_68_7 + arg_68_0 then
				var_68_5.localPosition = Vector3.New(0, -0.95, -6)

				local var_68_12 = manager.ui.mainCamera.transform.position - var_68_5.position

				var_68_5.forward = Vector3.New(var_68_12.x, var_68_12.y, var_68_12.z)

				local var_68_13 = var_68_5.localEulerAngles

				var_68_13.z = 0
				var_68_13.x = 0
				var_68_5.localEulerAngles = var_68_13
			end

			local var_68_14 = arg_65_1.actors_["1158ui_story"]
			local var_68_15 = 0

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 and not isNil(var_68_14) and arg_65_1.var_.characterEffect1158ui_story == nil then
				arg_65_1.var_.characterEffect1158ui_story = var_68_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_16 = 0.200000002980232

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_16 and not isNil(var_68_14) then
				local var_68_17 = (arg_65_1.time_ - var_68_15) / var_68_16

				if arg_65_1.var_.characterEffect1158ui_story and not isNil(var_68_14) then
					arg_65_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_15 + var_68_16 and arg_65_1.time_ < var_68_15 + var_68_16 + arg_68_0 and not isNil(var_68_14) and arg_65_1.var_.characterEffect1158ui_story then
				arg_65_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			local var_68_18 = 0

			if var_68_18 < arg_65_1.time_ and arg_65_1.time_ <= var_68_18 + arg_68_0 then
				arg_65_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action6_1")
			end

			local var_68_19 = 0

			if var_68_19 < arg_65_1.time_ and arg_65_1.time_ <= var_68_19 + arg_68_0 then
				arg_65_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_20 = arg_65_1.actors_["1015ui_story"].transform
			local var_68_21 = 0

			if var_68_21 < arg_65_1.time_ and arg_65_1.time_ <= var_68_21 + arg_68_0 then
				arg_65_1.var_.moveOldPos1015ui_story = var_68_20.localPosition
			end

			local var_68_22 = 0.001

			if var_68_21 <= arg_65_1.time_ and arg_65_1.time_ < var_68_21 + var_68_22 then
				local var_68_23 = (arg_65_1.time_ - var_68_21) / var_68_22
				local var_68_24 = Vector3.New(0, 100, 0)

				var_68_20.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1015ui_story, var_68_24, var_68_23)

				local var_68_25 = manager.ui.mainCamera.transform.position - var_68_20.position

				var_68_20.forward = Vector3.New(var_68_25.x, var_68_25.y, var_68_25.z)

				local var_68_26 = var_68_20.localEulerAngles

				var_68_26.z = 0
				var_68_26.x = 0
				var_68_20.localEulerAngles = var_68_26
			end

			if arg_65_1.time_ >= var_68_21 + var_68_22 and arg_65_1.time_ < var_68_21 + var_68_22 + arg_68_0 then
				var_68_20.localPosition = Vector3.New(0, 100, 0)

				local var_68_27 = manager.ui.mainCamera.transform.position - var_68_20.position

				var_68_20.forward = Vector3.New(var_68_27.x, var_68_27.y, var_68_27.z)

				local var_68_28 = var_68_20.localEulerAngles

				var_68_28.z = 0
				var_68_28.x = 0
				var_68_20.localEulerAngles = var_68_28
			end

			local var_68_29 = arg_65_1.actors_["1015ui_story"]
			local var_68_30 = 0

			if var_68_30 < arg_65_1.time_ and arg_65_1.time_ <= var_68_30 + arg_68_0 and not isNil(var_68_29) and arg_65_1.var_.characterEffect1015ui_story == nil then
				arg_65_1.var_.characterEffect1015ui_story = var_68_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_31 = 0.200000002980232

			if var_68_30 <= arg_65_1.time_ and arg_65_1.time_ < var_68_30 + var_68_31 and not isNil(var_68_29) then
				local var_68_32 = (arg_65_1.time_ - var_68_30) / var_68_31

				if arg_65_1.var_.characterEffect1015ui_story and not isNil(var_68_29) then
					local var_68_33 = Mathf.Lerp(0, 0.5, var_68_32)

					arg_65_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1015ui_story.fillRatio = var_68_33
				end
			end

			if arg_65_1.time_ >= var_68_30 + var_68_31 and arg_65_1.time_ < var_68_30 + var_68_31 + arg_68_0 and not isNil(var_68_29) and arg_65_1.var_.characterEffect1015ui_story then
				local var_68_34 = 0.5

				arg_65_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1015ui_story.fillRatio = var_68_34
			end

			local var_68_35 = 0
			local var_68_36 = 0.25

			if var_68_35 < arg_65_1.time_ and arg_65_1.time_ <= var_68_35 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_37 = arg_65_1:FormatText(StoryNameCfg[92].name)

				arg_65_1.leftNameTxt_.text = var_68_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_38 = arg_65_1:GetWordFromCfg(317302016)
				local var_68_39 = arg_65_1:FormatText(var_68_38.content)

				arg_65_1.text_.text = var_68_39

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_40 = 10
				local var_68_41 = utf8.len(var_68_39)
				local var_68_42 = var_68_40 <= 0 and var_68_36 or var_68_36 * (var_68_41 / var_68_40)

				if var_68_42 > 0 and var_68_36 < var_68_42 then
					arg_65_1.talkMaxDuration = var_68_42

					if var_68_42 + var_68_35 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_42 + var_68_35
					end
				end

				arg_65_1.text_.text = var_68_39
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302016", "story_v_out_317302.awb") ~= 0 then
					local var_68_43 = manager.audio:GetVoiceLength("story_v_out_317302", "317302016", "story_v_out_317302.awb") / 1000

					if var_68_43 + var_68_35 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_43 + var_68_35
					end

					if var_68_38.prefab_name ~= "" and arg_65_1.actors_[var_68_38.prefab_name] ~= nil then
						local var_68_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_38.prefab_name].transform, "story_v_out_317302", "317302016", "story_v_out_317302.awb")

						arg_65_1:RecordAudio("317302016", var_68_44)
						arg_65_1:RecordAudio("317302016", var_68_44)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_317302", "317302016", "story_v_out_317302.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_317302", "317302016", "story_v_out_317302.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_45 = math.max(var_68_36, arg_65_1.talkMaxDuration)

			if var_68_35 <= arg_65_1.time_ and arg_65_1.time_ < var_68_35 + var_68_45 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_35) / var_68_45

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_35 + var_68_45 and arg_65_1.time_ < var_68_35 + var_68_45 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
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

		arg_65_1:InitPlayNodeList()
	end,
	Play317302017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 317302017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play317302018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1158ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1158ui_story == nil then
				arg_69_1.var_.characterEffect1158ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1158ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1158ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1158ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1158ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 0.475

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:GetWordFromCfg(317302017)
				local var_72_9 = arg_69_1:FormatText(var_72_8.content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 19
				local var_72_11 = utf8.len(var_72_9)
				local var_72_12 = var_72_10 <= 0 and var_72_7 or var_72_7 * (var_72_11 / var_72_10)

				if var_72_12 > 0 and var_72_7 < var_72_12 then
					arg_69_1.talkMaxDuration = var_72_12

					if var_72_12 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_13 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_13 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_13

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_13 and arg_69_1.time_ < var_72_6 + var_72_13 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play317302018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 317302018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play317302019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.1

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[7].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(317302018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 4
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
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_8 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_8 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_8

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_8 and arg_73_1.time_ < var_76_0 + var_76_8 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play317302019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 317302019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play317302020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 1.2

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

				local var_80_2 = arg_77_1:GetWordFromCfg(317302019)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 48
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
	Play317302020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 317302020
		arg_81_1.duration_ = 13.73

		local var_81_0 = {
			zh = 11.1,
			ja = 13.733
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
				arg_81_0:Play317302021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1158ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1158ui_story == nil then
				arg_81_1.var_.characterEffect1158ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1158ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1158ui_story then
				arg_81_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			local var_84_4 = 0
			local var_84_5 = 1.475

			if var_84_4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_6 = arg_81_1:FormatText(StoryNameCfg[92].name)

				arg_81_1.leftNameTxt_.text = var_84_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_7 = arg_81_1:GetWordFromCfg(317302020)
				local var_84_8 = arg_81_1:FormatText(var_84_7.content)

				arg_81_1.text_.text = var_84_8

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 59
				local var_84_10 = utf8.len(var_84_8)
				local var_84_11 = var_84_9 <= 0 and var_84_5 or var_84_5 * (var_84_10 / var_84_9)

				if var_84_11 > 0 and var_84_5 < var_84_11 then
					arg_81_1.talkMaxDuration = var_84_11

					if var_84_11 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_11 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_8
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302020", "story_v_out_317302.awb") ~= 0 then
					local var_84_12 = manager.audio:GetVoiceLength("story_v_out_317302", "317302020", "story_v_out_317302.awb") / 1000

					if var_84_12 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_4
					end

					if var_84_7.prefab_name ~= "" and arg_81_1.actors_[var_84_7.prefab_name] ~= nil then
						local var_84_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_7.prefab_name].transform, "story_v_out_317302", "317302020", "story_v_out_317302.awb")

						arg_81_1:RecordAudio("317302020", var_84_13)
						arg_81_1:RecordAudio("317302020", var_84_13)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_317302", "317302020", "story_v_out_317302.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_317302", "317302020", "story_v_out_317302.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_14 and arg_81_1.time_ < var_84_4 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play317302021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 317302021
		arg_85_1.duration_ = 10.23

		local var_85_0 = {
			zh = 5.9,
			ja = 10.233
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
				arg_85_0:Play317302022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.65

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[92].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(317302021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302021", "story_v_out_317302.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_317302", "317302021", "story_v_out_317302.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_317302", "317302021", "story_v_out_317302.awb")

						arg_85_1:RecordAudio("317302021", var_88_9)
						arg_85_1:RecordAudio("317302021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_317302", "317302021", "story_v_out_317302.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_317302", "317302021", "story_v_out_317302.awb")
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
	Play317302022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 317302022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play317302023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1158ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1158ui_story == nil then
				arg_89_1.var_.characterEffect1158ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1158ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1158ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1158ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1158ui_story.fillRatio = var_92_5
			end

			local var_92_6 = 0
			local var_92_7 = 0.825

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(317302022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 33
				local var_92_11 = utf8.len(var_92_9)
				local var_92_12 = var_92_10 <= 0 and var_92_7 or var_92_7 * (var_92_11 / var_92_10)

				if var_92_12 > 0 and var_92_7 < var_92_12 then
					arg_89_1.talkMaxDuration = var_92_12

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_13 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_13 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_13

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_13 and arg_89_1.time_ < var_92_6 + var_92_13 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play317302023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 317302023
		arg_93_1.duration_ = 2

		local var_93_0 = {
			zh = 2,
			ja = 1.999999999999
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
				arg_93_0:Play317302024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1015ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1015ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, -1.15, -6.2)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1015ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["1015ui_story"]
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1015ui_story == nil then
				arg_93_1.var_.characterEffect1015ui_story = var_96_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_11 = 0.200000002980232

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 and not isNil(var_96_9) then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11

				if arg_93_1.var_.characterEffect1015ui_story and not isNil(var_96_9) then
					arg_93_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1015ui_story then
				arg_93_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_96_13 = 0

			if var_96_13 < arg_93_1.time_ and arg_93_1.time_ <= var_96_13 + arg_96_0 then
				arg_93_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_96_14 = 0

			if var_96_14 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				arg_93_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_96_15 = arg_93_1.actors_["1158ui_story"].transform
			local var_96_16 = 0

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.var_.moveOldPos1158ui_story = var_96_15.localPosition
			end

			local var_96_17 = 0.001

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_17 then
				local var_96_18 = (arg_93_1.time_ - var_96_16) / var_96_17
				local var_96_19 = Vector3.New(0, 100, 0)

				var_96_15.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1158ui_story, var_96_19, var_96_18)

				local var_96_20 = manager.ui.mainCamera.transform.position - var_96_15.position

				var_96_15.forward = Vector3.New(var_96_20.x, var_96_20.y, var_96_20.z)

				local var_96_21 = var_96_15.localEulerAngles

				var_96_21.z = 0
				var_96_21.x = 0
				var_96_15.localEulerAngles = var_96_21
			end

			if arg_93_1.time_ >= var_96_16 + var_96_17 and arg_93_1.time_ < var_96_16 + var_96_17 + arg_96_0 then
				var_96_15.localPosition = Vector3.New(0, 100, 0)

				local var_96_22 = manager.ui.mainCamera.transform.position - var_96_15.position

				var_96_15.forward = Vector3.New(var_96_22.x, var_96_22.y, var_96_22.z)

				local var_96_23 = var_96_15.localEulerAngles

				var_96_23.z = 0
				var_96_23.x = 0
				var_96_15.localEulerAngles = var_96_23
			end

			local var_96_24 = arg_93_1.actors_["1158ui_story"]
			local var_96_25 = 0

			if var_96_25 < arg_93_1.time_ and arg_93_1.time_ <= var_96_25 + arg_96_0 and not isNil(var_96_24) and arg_93_1.var_.characterEffect1158ui_story == nil then
				arg_93_1.var_.characterEffect1158ui_story = var_96_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_26 = 0.200000002980232

			if var_96_25 <= arg_93_1.time_ and arg_93_1.time_ < var_96_25 + var_96_26 and not isNil(var_96_24) then
				local var_96_27 = (arg_93_1.time_ - var_96_25) / var_96_26

				if arg_93_1.var_.characterEffect1158ui_story and not isNil(var_96_24) then
					local var_96_28 = Mathf.Lerp(0, 0.5, var_96_27)

					arg_93_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1158ui_story.fillRatio = var_96_28
				end
			end

			if arg_93_1.time_ >= var_96_25 + var_96_26 and arg_93_1.time_ < var_96_25 + var_96_26 + arg_96_0 and not isNil(var_96_24) and arg_93_1.var_.characterEffect1158ui_story then
				local var_96_29 = 0.5

				arg_93_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1158ui_story.fillRatio = var_96_29
			end

			local var_96_30 = 0
			local var_96_31 = 0.275

			if var_96_30 < arg_93_1.time_ and arg_93_1.time_ <= var_96_30 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_32 = arg_93_1:FormatText(StoryNameCfg[479].name)

				arg_93_1.leftNameTxt_.text = var_96_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_33 = arg_93_1:GetWordFromCfg(317302023)
				local var_96_34 = arg_93_1:FormatText(var_96_33.content)

				arg_93_1.text_.text = var_96_34

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_35 = 11
				local var_96_36 = utf8.len(var_96_34)
				local var_96_37 = var_96_35 <= 0 and var_96_31 or var_96_31 * (var_96_36 / var_96_35)

				if var_96_37 > 0 and var_96_31 < var_96_37 then
					arg_93_1.talkMaxDuration = var_96_37

					if var_96_37 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_37 + var_96_30
					end
				end

				arg_93_1.text_.text = var_96_34
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302023", "story_v_out_317302.awb") ~= 0 then
					local var_96_38 = manager.audio:GetVoiceLength("story_v_out_317302", "317302023", "story_v_out_317302.awb") / 1000

					if var_96_38 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_38 + var_96_30
					end

					if var_96_33.prefab_name ~= "" and arg_93_1.actors_[var_96_33.prefab_name] ~= nil then
						local var_96_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_33.prefab_name].transform, "story_v_out_317302", "317302023", "story_v_out_317302.awb")

						arg_93_1:RecordAudio("317302023", var_96_39)
						arg_93_1:RecordAudio("317302023", var_96_39)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_317302", "317302023", "story_v_out_317302.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_317302", "317302023", "story_v_out_317302.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_40 = math.max(var_96_31, arg_93_1.talkMaxDuration)

			if var_96_30 <= arg_93_1.time_ and arg_93_1.time_ < var_96_30 + var_96_40 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_30) / var_96_40

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_30 + var_96_40 and arg_93_1.time_ < var_96_30 + var_96_40 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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
				actorName = "1158ui_story",
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
	Play317302024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 317302024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play317302025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1015ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1015ui_story == nil then
				arg_97_1.var_.characterEffect1015ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1015ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1015ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1015ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1015ui_story.fillRatio = var_100_5
			end

			local var_100_6 = 0
			local var_100_7 = 0.4

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

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_9 = arg_97_1:GetWordFromCfg(317302024)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 16
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
	Play317302025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 317302025
		arg_101_1.duration_ = 8.2

		local var_101_0 = {
			zh = 6.3,
			ja = 8.2
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
				arg_101_0:Play317302026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1158ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1158ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0, -0.95, -6)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1158ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, -0.95, -6)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["1158ui_story"]
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1158ui_story == nil then
				arg_101_1.var_.characterEffect1158ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect1158ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1158ui_story then
				arg_101_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action6_2")
			end

			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_104_15 = arg_101_1.actors_["1015ui_story"].transform
			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				arg_101_1.var_.moveOldPos1015ui_story = var_104_15.localPosition
			end

			local var_104_17 = 0.001

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_17 then
				local var_104_18 = (arg_101_1.time_ - var_104_16) / var_104_17
				local var_104_19 = Vector3.New(0, 100, 0)

				var_104_15.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1015ui_story, var_104_19, var_104_18)

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

			local var_104_24 = 0
			local var_104_25 = 0.575

			if var_104_24 < arg_101_1.time_ and arg_101_1.time_ <= var_104_24 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_26 = arg_101_1:FormatText(StoryNameCfg[92].name)

				arg_101_1.leftNameTxt_.text = var_104_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_27 = arg_101_1:GetWordFromCfg(317302025)
				local var_104_28 = arg_101_1:FormatText(var_104_27.content)

				arg_101_1.text_.text = var_104_28

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_29 = 23
				local var_104_30 = utf8.len(var_104_28)
				local var_104_31 = var_104_29 <= 0 and var_104_25 or var_104_25 * (var_104_30 / var_104_29)

				if var_104_31 > 0 and var_104_25 < var_104_31 then
					arg_101_1.talkMaxDuration = var_104_31

					if var_104_31 + var_104_24 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_31 + var_104_24
					end
				end

				arg_101_1.text_.text = var_104_28
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302025", "story_v_out_317302.awb") ~= 0 then
					local var_104_32 = manager.audio:GetVoiceLength("story_v_out_317302", "317302025", "story_v_out_317302.awb") / 1000

					if var_104_32 + var_104_24 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_32 + var_104_24
					end

					if var_104_27.prefab_name ~= "" and arg_101_1.actors_[var_104_27.prefab_name] ~= nil then
						local var_104_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_27.prefab_name].transform, "story_v_out_317302", "317302025", "story_v_out_317302.awb")

						arg_101_1:RecordAudio("317302025", var_104_33)
						arg_101_1:RecordAudio("317302025", var_104_33)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_317302", "317302025", "story_v_out_317302.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_317302", "317302025", "story_v_out_317302.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_34 = math.max(var_104_25, arg_101_1.talkMaxDuration)

			if var_104_24 <= arg_101_1.time_ and arg_101_1.time_ < var_104_24 + var_104_34 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_24) / var_104_34

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_24 + var_104_34 and arg_101_1.time_ < var_104_24 + var_104_34 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
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

		arg_101_1:InitPlayNodeList()
	end,
	Play317302026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 317302026
		arg_105_1.duration_ = 13.53

		local var_105_0 = {
			zh = 13.266,
			ja = 13.533
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play317302027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 1.575

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[92].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:GetWordFromCfg(317302026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 63
				local var_108_6 = utf8.len(var_108_4)
				local var_108_7 = var_108_5 <= 0 and var_108_1 or var_108_1 * (var_108_6 / var_108_5)

				if var_108_7 > 0 and var_108_1 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302026", "story_v_out_317302.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_317302", "317302026", "story_v_out_317302.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_317302", "317302026", "story_v_out_317302.awb")

						arg_105_1:RecordAudio("317302026", var_108_9)
						arg_105_1:RecordAudio("317302026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_317302", "317302026", "story_v_out_317302.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_317302", "317302026", "story_v_out_317302.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_10 and arg_105_1.time_ < var_108_0 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play317302027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 317302027
		arg_109_1.duration_ = 5.3

		local var_109_0 = {
			zh = 4.966,
			ja = 5.3
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
				arg_109_0:Play317302028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.6

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[92].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(317302027)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 24
				local var_112_6 = utf8.len(var_112_4)
				local var_112_7 = var_112_5 <= 0 and var_112_1 or var_112_1 * (var_112_6 / var_112_5)

				if var_112_7 > 0 and var_112_1 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317302", "317302027", "story_v_out_317302.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_317302", "317302027", "story_v_out_317302.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_317302", "317302027", "story_v_out_317302.awb")

						arg_109_1:RecordAudio("317302027", var_112_9)
						arg_109_1:RecordAudio("317302027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_317302", "317302027", "story_v_out_317302.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_317302", "317302027", "story_v_out_317302.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_10 and arg_109_1.time_ < var_112_0 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play317302028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 317302028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play317302029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1158ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1158ui_story == nil then
				arg_113_1.var_.characterEffect1158ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1158ui_story and not isNil(var_116_0) then
					local var_116_4 = Mathf.Lerp(0, 0.5, var_116_3)

					arg_113_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1158ui_story.fillRatio = var_116_4
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1158ui_story then
				local var_116_5 = 0.5

				arg_113_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1158ui_story.fillRatio = var_116_5
			end

			local var_116_6 = 0
			local var_116_7 = 1.15

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_8 = arg_113_1:GetWordFromCfg(317302028)
				local var_116_9 = arg_113_1:FormatText(var_116_8.content)

				arg_113_1.text_.text = var_116_9

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_10 = 46
				local var_116_11 = utf8.len(var_116_9)
				local var_116_12 = var_116_10 <= 0 and var_116_7 or var_116_7 * (var_116_11 / var_116_10)

				if var_116_12 > 0 and var_116_7 < var_116_12 then
					arg_113_1.talkMaxDuration = var_116_12

					if var_116_12 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_9
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_13 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_13 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_13

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_13 and arg_113_1.time_ < var_116_6 + var_116_13 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play317302029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 317302029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play317302030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.375

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

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_3 = arg_117_1:GetWordFromCfg(317302029)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 15
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
	Play317302030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 317302030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
			arg_121_1.auto_ = false
		end

		function arg_121_1.playNext_(arg_123_0)
			arg_121_1.onStoryFinished_()
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.9

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_2 = arg_121_1:GetWordFromCfg(317302030)
				local var_124_3 = arg_121_1:FormatText(var_124_2.content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 36
				local var_124_5 = utf8.len(var_124_3)
				local var_124_6 = var_124_4 <= 0 and var_124_1 or var_124_1 * (var_124_5 / var_124_4)

				if var_124_6 > 0 and var_124_1 < var_124_6 then
					arg_121_1.talkMaxDuration = var_124_6

					if var_124_6 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_7 and arg_121_1.time_ < var_124_0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D999"
	},
	voices = {
		"story_v_out_317302.awb"
	}
}
