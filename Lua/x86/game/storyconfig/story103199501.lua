return {
	Play319951001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319951001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319951002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I11i"

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
				local var_4_5 = arg_1_1.bgs_.I11i

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
					if iter_4_0 ~= "I11i" then
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

			local var_4_28 = 0.233333333333333
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet")

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
			local var_4_35 = 0.875

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

				local var_4_37 = arg_1_1:GetWordFromCfg(319951001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 35
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
	Play319951002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319951002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play319951003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.275

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

				local var_12_2 = arg_9_1:GetWordFromCfg(319951002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 51
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
	Play319951003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319951003
		arg_13_1.duration_ = 3.3

		local var_13_0 = {
			zh = 2.333,
			ja = 3.3
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
				arg_13_0:Play319951004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "4040ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "4040ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["4040ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos4040ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0, -1.55, -5.5)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos4040ui_story, var_16_9, var_16_8)

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

			local var_16_14 = arg_13_1.actors_["4040ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect4040ui_story == nil then
				arg_13_1.var_.characterEffect4040ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect4040ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect4040ui_story then
				arg_13_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_20 = 0
			local var_16_21 = 0.15

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

				local var_16_23 = arg_13_1:GetWordFromCfg(319951003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951003", "story_v_out_319951.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_out_319951", "319951003", "story_v_out_319951.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_out_319951", "319951003", "story_v_out_319951.awb")

						arg_13_1:RecordAudio("319951003", var_16_29)
						arg_13_1:RecordAudio("319951003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319951", "319951003", "story_v_out_319951.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319951", "319951003", "story_v_out_319951.awb")
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
				actorName = "4040ui_story",
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
	Play319951004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319951004
		arg_17_1.duration_ = 4.57

		local var_17_0 = {
			zh = 1.733,
			ja = 4.566
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
				arg_17_0:Play319951005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1095ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_17_1.stage_.transform)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

					var_20_3.enabled = true

					local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

					if var_20_4 then
						var_20_4:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_3.transform, false)

					arg_17_1.var_[var_20_0 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_0 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_0 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_5 = arg_17_1.actors_["1095ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos1095ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(0.7, -0.98, -6.1)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1095ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["1095ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1095ui_story == nil then
				arg_17_1.var_.characterEffect1095ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.200000002980232

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect1095ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1095ui_story then
				arg_17_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_20 = arg_17_1.actors_["4040ui_story"].transform
			local var_20_21 = 0

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.var_.moveOldPos4040ui_story = var_20_20.localPosition
			end

			local var_20_22 = 0.001

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_22 then
				local var_20_23 = (arg_17_1.time_ - var_20_21) / var_20_22
				local var_20_24 = Vector3.New(-0.7, -1.55, -5.5)

				var_20_20.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos4040ui_story, var_20_24, var_20_23)

				local var_20_25 = manager.ui.mainCamera.transform.position - var_20_20.position

				var_20_20.forward = Vector3.New(var_20_25.x, var_20_25.y, var_20_25.z)

				local var_20_26 = var_20_20.localEulerAngles

				var_20_26.z = 0
				var_20_26.x = 0
				var_20_20.localEulerAngles = var_20_26
			end

			if arg_17_1.time_ >= var_20_21 + var_20_22 and arg_17_1.time_ < var_20_21 + var_20_22 + arg_20_0 then
				var_20_20.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_20_27 = manager.ui.mainCamera.transform.position - var_20_20.position

				var_20_20.forward = Vector3.New(var_20_27.x, var_20_27.y, var_20_27.z)

				local var_20_28 = var_20_20.localEulerAngles

				var_20_28.z = 0
				var_20_28.x = 0
				var_20_20.localEulerAngles = var_20_28
			end

			local var_20_29 = arg_17_1.actors_["4040ui_story"]
			local var_20_30 = 0

			if var_20_30 < arg_17_1.time_ and arg_17_1.time_ <= var_20_30 + arg_20_0 and not isNil(var_20_29) and arg_17_1.var_.characterEffect4040ui_story == nil then
				arg_17_1.var_.characterEffect4040ui_story = var_20_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_31 = 0.200000002980232

			if var_20_30 <= arg_17_1.time_ and arg_17_1.time_ < var_20_30 + var_20_31 and not isNil(var_20_29) then
				local var_20_32 = (arg_17_1.time_ - var_20_30) / var_20_31

				if arg_17_1.var_.characterEffect4040ui_story and not isNil(var_20_29) then
					local var_20_33 = Mathf.Lerp(0, 0.5, var_20_32)

					arg_17_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_17_1.var_.characterEffect4040ui_story.fillRatio = var_20_33
				end
			end

			if arg_17_1.time_ >= var_20_30 + var_20_31 and arg_17_1.time_ < var_20_30 + var_20_31 + arg_20_0 and not isNil(var_20_29) and arg_17_1.var_.characterEffect4040ui_story then
				local var_20_34 = 0.5

				arg_17_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_17_1.var_.characterEffect4040ui_story.fillRatio = var_20_34
			end

			local var_20_35 = 0
			local var_20_36 = 0.225

			if var_20_35 < arg_17_1.time_ and arg_17_1.time_ <= var_20_35 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_37 = arg_17_1:FormatText(StoryNameCfg[471].name)

				arg_17_1.leftNameTxt_.text = var_20_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_38 = arg_17_1:GetWordFromCfg(319951004)
				local var_20_39 = arg_17_1:FormatText(var_20_38.content)

				arg_17_1.text_.text = var_20_39

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_40 = 9
				local var_20_41 = utf8.len(var_20_39)
				local var_20_42 = var_20_40 <= 0 and var_20_36 or var_20_36 * (var_20_41 / var_20_40)

				if var_20_42 > 0 and var_20_36 < var_20_42 then
					arg_17_1.talkMaxDuration = var_20_42

					if var_20_42 + var_20_35 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_42 + var_20_35
					end
				end

				arg_17_1.text_.text = var_20_39
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951004", "story_v_out_319951.awb") ~= 0 then
					local var_20_43 = manager.audio:GetVoiceLength("story_v_out_319951", "319951004", "story_v_out_319951.awb") / 1000

					if var_20_43 + var_20_35 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_43 + var_20_35
					end

					if var_20_38.prefab_name ~= "" and arg_17_1.actors_[var_20_38.prefab_name] ~= nil then
						local var_20_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_38.prefab_name].transform, "story_v_out_319951", "319951004", "story_v_out_319951.awb")

						arg_17_1:RecordAudio("319951004", var_20_44)
						arg_17_1:RecordAudio("319951004", var_20_44)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319951", "319951004", "story_v_out_319951.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319951", "319951004", "story_v_out_319951.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_45 = math.max(var_20_36, arg_17_1.talkMaxDuration)

			if var_20_35 <= arg_17_1.time_ and arg_17_1.time_ < var_20_35 + var_20_45 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_35) / var_20_45

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_35 + var_20_45 and arg_17_1.time_ < var_20_35 + var_20_45 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_17_1:InitPlayNodeList()
	end,
	Play319951005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319951005
		arg_21_1.duration_ = 4.53

		local var_21_0 = {
			zh = 4.533,
			ja = 2.9
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
				arg_21_0:Play319951006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1095ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1095ui_story == nil then
				arg_21_1.var_.characterEffect1095ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1095ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1095ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1095ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1095ui_story.fillRatio = var_24_5
			end

			local var_24_6 = arg_21_1.actors_["4040ui_story"]
			local var_24_7 = 0

			if var_24_7 < arg_21_1.time_ and arg_21_1.time_ <= var_24_7 + arg_24_0 and not isNil(var_24_6) and arg_21_1.var_.characterEffect4040ui_story == nil then
				arg_21_1.var_.characterEffect4040ui_story = var_24_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_8 = 0.200000002980232

			if var_24_7 <= arg_21_1.time_ and arg_21_1.time_ < var_24_7 + var_24_8 and not isNil(var_24_6) then
				local var_24_9 = (arg_21_1.time_ - var_24_7) / var_24_8

				if arg_21_1.var_.characterEffect4040ui_story and not isNil(var_24_6) then
					arg_21_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_7 + var_24_8 and arg_21_1.time_ < var_24_7 + var_24_8 + arg_24_0 and not isNil(var_24_6) and arg_21_1.var_.characterEffect4040ui_story then
				arg_21_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_24_10 = 0
			local var_24_11 = 0.525

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_12 = arg_21_1:FormatText(StoryNameCfg[668].name)

				arg_21_1.leftNameTxt_.text = var_24_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_13 = arg_21_1:GetWordFromCfg(319951005)
				local var_24_14 = arg_21_1:FormatText(var_24_13.content)

				arg_21_1.text_.text = var_24_14

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_15 = 21
				local var_24_16 = utf8.len(var_24_14)
				local var_24_17 = var_24_15 <= 0 and var_24_11 or var_24_11 * (var_24_16 / var_24_15)

				if var_24_17 > 0 and var_24_11 < var_24_17 then
					arg_21_1.talkMaxDuration = var_24_17

					if var_24_17 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_17 + var_24_10
					end
				end

				arg_21_1.text_.text = var_24_14
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951005", "story_v_out_319951.awb") ~= 0 then
					local var_24_18 = manager.audio:GetVoiceLength("story_v_out_319951", "319951005", "story_v_out_319951.awb") / 1000

					if var_24_18 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_18 + var_24_10
					end

					if var_24_13.prefab_name ~= "" and arg_21_1.actors_[var_24_13.prefab_name] ~= nil then
						local var_24_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_13.prefab_name].transform, "story_v_out_319951", "319951005", "story_v_out_319951.awb")

						arg_21_1:RecordAudio("319951005", var_24_19)
						arg_21_1:RecordAudio("319951005", var_24_19)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319951", "319951005", "story_v_out_319951.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319951", "319951005", "story_v_out_319951.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_20 = math.max(var_24_11, arg_21_1.talkMaxDuration)

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_20 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_10) / var_24_20

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_10 + var_24_20 and arg_21_1.time_ < var_24_10 + var_24_20 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play319951006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319951006
		arg_25_1.duration_ = 4

		local var_25_0 = {
			zh = 2.4,
			ja = 4
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
				arg_25_0:Play319951007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.325

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[668].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(319951006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 13
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951006", "story_v_out_319951.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_319951", "319951006", "story_v_out_319951.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_319951", "319951006", "story_v_out_319951.awb")

						arg_25_1:RecordAudio("319951006", var_28_9)
						arg_25_1:RecordAudio("319951006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319951", "319951006", "story_v_out_319951.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319951", "319951006", "story_v_out_319951.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play319951007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319951007
		arg_29_1.duration_ = 2.13

		local var_29_0 = {
			zh = 1.999999999999,
			ja = 2.133
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
				arg_29_0:Play319951008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "10079ui_story"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Char/" .. "10079ui_story")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_29_1.stage_.transform)

					var_32_2.name = var_32_0
					var_32_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_29_1.actors_[var_32_0] = var_32_2

					local var_32_3 = var_32_2:GetComponentInChildren(typeof(CharacterEffect))

					var_32_3.enabled = true

					local var_32_4 = GameObjectTools.GetOrAddComponent(var_32_2, typeof(DynamicBoneHelper))

					if var_32_4 then
						var_32_4:EnableDynamicBone(false)
					end

					arg_29_1:ShowWeapon(var_32_3.transform, false)

					arg_29_1.var_[var_32_0 .. "Animator"] = var_32_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_29_1.var_[var_32_0 .. "Animator"].applyRootMotion = true
					arg_29_1.var_[var_32_0 .. "LipSync"] = var_32_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_32_5 = arg_29_1.actors_["10079ui_story"].transform
			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.var_.moveOldPos10079ui_story = var_32_5.localPosition
			end

			local var_32_7 = 0.001

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_7 then
				local var_32_8 = (arg_29_1.time_ - var_32_6) / var_32_7
				local var_32_9 = Vector3.New(0, -0.95, -6.05)

				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10079ui_story, var_32_9, var_32_8)

				local var_32_10 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_10.x, var_32_10.y, var_32_10.z)

				local var_32_11 = var_32_5.localEulerAngles

				var_32_11.z = 0
				var_32_11.x = 0
				var_32_5.localEulerAngles = var_32_11
			end

			if arg_29_1.time_ >= var_32_6 + var_32_7 and arg_29_1.time_ < var_32_6 + var_32_7 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_32_12 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_12.x, var_32_12.y, var_32_12.z)

				local var_32_13 = var_32_5.localEulerAngles

				var_32_13.z = 0
				var_32_13.x = 0
				var_32_5.localEulerAngles = var_32_13
			end

			local var_32_14 = arg_29_1.actors_["10079ui_story"]
			local var_32_15 = 0

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.characterEffect10079ui_story == nil then
				arg_29_1.var_.characterEffect10079ui_story = var_32_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_16 = 0.200000002980232

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_16 and not isNil(var_32_14) then
				local var_32_17 = (arg_29_1.time_ - var_32_15) / var_32_16

				if arg_29_1.var_.characterEffect10079ui_story and not isNil(var_32_14) then
					arg_29_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_15 + var_32_16 and arg_29_1.time_ < var_32_15 + var_32_16 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.characterEffect10079ui_story then
				arg_29_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_32_18 = 0

			if var_32_18 < arg_29_1.time_ and arg_29_1.time_ <= var_32_18 + arg_32_0 then
				arg_29_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_32_19 = 0

			if var_32_19 < arg_29_1.time_ and arg_29_1.time_ <= var_32_19 + arg_32_0 then
				arg_29_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_20 = arg_29_1.actors_["1095ui_story"].transform
			local var_32_21 = 0

			if var_32_21 < arg_29_1.time_ and arg_29_1.time_ <= var_32_21 + arg_32_0 then
				arg_29_1.var_.moveOldPos1095ui_story = var_32_20.localPosition
			end

			local var_32_22 = 0.001

			if var_32_21 <= arg_29_1.time_ and arg_29_1.time_ < var_32_21 + var_32_22 then
				local var_32_23 = (arg_29_1.time_ - var_32_21) / var_32_22
				local var_32_24 = Vector3.New(0, 100, 0)

				var_32_20.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1095ui_story, var_32_24, var_32_23)

				local var_32_25 = manager.ui.mainCamera.transform.position - var_32_20.position

				var_32_20.forward = Vector3.New(var_32_25.x, var_32_25.y, var_32_25.z)

				local var_32_26 = var_32_20.localEulerAngles

				var_32_26.z = 0
				var_32_26.x = 0
				var_32_20.localEulerAngles = var_32_26
			end

			if arg_29_1.time_ >= var_32_21 + var_32_22 and arg_29_1.time_ < var_32_21 + var_32_22 + arg_32_0 then
				var_32_20.localPosition = Vector3.New(0, 100, 0)

				local var_32_27 = manager.ui.mainCamera.transform.position - var_32_20.position

				var_32_20.forward = Vector3.New(var_32_27.x, var_32_27.y, var_32_27.z)

				local var_32_28 = var_32_20.localEulerAngles

				var_32_28.z = 0
				var_32_28.x = 0
				var_32_20.localEulerAngles = var_32_28
			end

			local var_32_29 = arg_29_1.actors_["1095ui_story"]
			local var_32_30 = 0

			if var_32_30 < arg_29_1.time_ and arg_29_1.time_ <= var_32_30 + arg_32_0 and not isNil(var_32_29) and arg_29_1.var_.characterEffect1095ui_story == nil then
				arg_29_1.var_.characterEffect1095ui_story = var_32_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_31 = 0.200000002980232

			if var_32_30 <= arg_29_1.time_ and arg_29_1.time_ < var_32_30 + var_32_31 and not isNil(var_32_29) then
				local var_32_32 = (arg_29_1.time_ - var_32_30) / var_32_31

				if arg_29_1.var_.characterEffect1095ui_story and not isNil(var_32_29) then
					local var_32_33 = Mathf.Lerp(0, 0.5, var_32_32)

					arg_29_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1095ui_story.fillRatio = var_32_33
				end
			end

			if arg_29_1.time_ >= var_32_30 + var_32_31 and arg_29_1.time_ < var_32_30 + var_32_31 + arg_32_0 and not isNil(var_32_29) and arg_29_1.var_.characterEffect1095ui_story then
				local var_32_34 = 0.5

				arg_29_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1095ui_story.fillRatio = var_32_34
			end

			local var_32_35 = arg_29_1.actors_["4040ui_story"].transform
			local var_32_36 = 0

			if var_32_36 < arg_29_1.time_ and arg_29_1.time_ <= var_32_36 + arg_32_0 then
				arg_29_1.var_.moveOldPos4040ui_story = var_32_35.localPosition
			end

			local var_32_37 = 0.001

			if var_32_36 <= arg_29_1.time_ and arg_29_1.time_ < var_32_36 + var_32_37 then
				local var_32_38 = (arg_29_1.time_ - var_32_36) / var_32_37
				local var_32_39 = Vector3.New(0, 100, 0)

				var_32_35.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos4040ui_story, var_32_39, var_32_38)

				local var_32_40 = manager.ui.mainCamera.transform.position - var_32_35.position

				var_32_35.forward = Vector3.New(var_32_40.x, var_32_40.y, var_32_40.z)

				local var_32_41 = var_32_35.localEulerAngles

				var_32_41.z = 0
				var_32_41.x = 0
				var_32_35.localEulerAngles = var_32_41
			end

			if arg_29_1.time_ >= var_32_36 + var_32_37 and arg_29_1.time_ < var_32_36 + var_32_37 + arg_32_0 then
				var_32_35.localPosition = Vector3.New(0, 100, 0)

				local var_32_42 = manager.ui.mainCamera.transform.position - var_32_35.position

				var_32_35.forward = Vector3.New(var_32_42.x, var_32_42.y, var_32_42.z)

				local var_32_43 = var_32_35.localEulerAngles

				var_32_43.z = 0
				var_32_43.x = 0
				var_32_35.localEulerAngles = var_32_43
			end

			local var_32_44 = arg_29_1.actors_["4040ui_story"]
			local var_32_45 = 0

			if var_32_45 < arg_29_1.time_ and arg_29_1.time_ <= var_32_45 + arg_32_0 and not isNil(var_32_44) and arg_29_1.var_.characterEffect4040ui_story == nil then
				arg_29_1.var_.characterEffect4040ui_story = var_32_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_46 = 0.200000002980232

			if var_32_45 <= arg_29_1.time_ and arg_29_1.time_ < var_32_45 + var_32_46 and not isNil(var_32_44) then
				local var_32_47 = (arg_29_1.time_ - var_32_45) / var_32_46

				if arg_29_1.var_.characterEffect4040ui_story and not isNil(var_32_44) then
					local var_32_48 = Mathf.Lerp(0, 0.5, var_32_47)

					arg_29_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_29_1.var_.characterEffect4040ui_story.fillRatio = var_32_48
				end
			end

			if arg_29_1.time_ >= var_32_45 + var_32_46 and arg_29_1.time_ < var_32_45 + var_32_46 + arg_32_0 and not isNil(var_32_44) and arg_29_1.var_.characterEffect4040ui_story then
				local var_32_49 = 0.5

				arg_29_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_29_1.var_.characterEffect4040ui_story.fillRatio = var_32_49
			end

			local var_32_50 = 0
			local var_32_51 = 0.175

			if var_32_50 < arg_29_1.time_ and arg_29_1.time_ <= var_32_50 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_52 = arg_29_1:FormatText(StoryNameCfg[6].name)

				arg_29_1.leftNameTxt_.text = var_32_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_53 = arg_29_1:GetWordFromCfg(319951007)
				local var_32_54 = arg_29_1:FormatText(var_32_53.content)

				arg_29_1.text_.text = var_32_54

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_55 = 7
				local var_32_56 = utf8.len(var_32_54)
				local var_32_57 = var_32_55 <= 0 and var_32_51 or var_32_51 * (var_32_56 / var_32_55)

				if var_32_57 > 0 and var_32_51 < var_32_57 then
					arg_29_1.talkMaxDuration = var_32_57

					if var_32_57 + var_32_50 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_57 + var_32_50
					end
				end

				arg_29_1.text_.text = var_32_54
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951007", "story_v_out_319951.awb") ~= 0 then
					local var_32_58 = manager.audio:GetVoiceLength("story_v_out_319951", "319951007", "story_v_out_319951.awb") / 1000

					if var_32_58 + var_32_50 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_58 + var_32_50
					end

					if var_32_53.prefab_name ~= "" and arg_29_1.actors_[var_32_53.prefab_name] ~= nil then
						local var_32_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_53.prefab_name].transform, "story_v_out_319951", "319951007", "story_v_out_319951.awb")

						arg_29_1:RecordAudio("319951007", var_32_59)
						arg_29_1:RecordAudio("319951007", var_32_59)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319951", "319951007", "story_v_out_319951.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319951", "319951007", "story_v_out_319951.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_60 = math.max(var_32_51, arg_29_1.talkMaxDuration)

			if var_32_50 <= arg_29_1.time_ and arg_29_1.time_ < var_32_50 + var_32_60 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_50) / var_32_60

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_50 + var_32_60 and arg_29_1.time_ < var_32_50 + var_32_60 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_29_1:InitPlayNodeList()
	end,
	Play319951008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319951008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play319951009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10079ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10079ui_story == nil then
				arg_33_1.var_.characterEffect10079ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect10079ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10079ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10079ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10079ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.875

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

				local var_36_8 = arg_33_1:GetWordFromCfg(319951008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 35
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
	Play319951009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319951009
		arg_37_1.duration_ = 5.5

		local var_37_0 = {
			zh = 3.866,
			ja = 5.5
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
				arg_37_0:Play319951010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["4040ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos4040ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, -1.55, -5.5)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos4040ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["4040ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect4040ui_story == nil then
				arg_37_1.var_.characterEffect4040ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect4040ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect4040ui_story then
				arg_37_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_40_13 = 0

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_40_14 = 0

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_15 = arg_37_1.actors_["10079ui_story"].transform
			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.var_.moveOldPos10079ui_story = var_40_15.localPosition
			end

			local var_40_17 = 0.001

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_17 then
				local var_40_18 = (arg_37_1.time_ - var_40_16) / var_40_17
				local var_40_19 = Vector3.New(0, 100, 0)

				var_40_15.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10079ui_story, var_40_19, var_40_18)

				local var_40_20 = manager.ui.mainCamera.transform.position - var_40_15.position

				var_40_15.forward = Vector3.New(var_40_20.x, var_40_20.y, var_40_20.z)

				local var_40_21 = var_40_15.localEulerAngles

				var_40_21.z = 0
				var_40_21.x = 0
				var_40_15.localEulerAngles = var_40_21
			end

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 then
				var_40_15.localPosition = Vector3.New(0, 100, 0)

				local var_40_22 = manager.ui.mainCamera.transform.position - var_40_15.position

				var_40_15.forward = Vector3.New(var_40_22.x, var_40_22.y, var_40_22.z)

				local var_40_23 = var_40_15.localEulerAngles

				var_40_23.z = 0
				var_40_23.x = 0
				var_40_15.localEulerAngles = var_40_23
			end

			local var_40_24 = arg_37_1.actors_["10079ui_story"]
			local var_40_25 = 0

			if var_40_25 < arg_37_1.time_ and arg_37_1.time_ <= var_40_25 + arg_40_0 and not isNil(var_40_24) and arg_37_1.var_.characterEffect10079ui_story == nil then
				arg_37_1.var_.characterEffect10079ui_story = var_40_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_26 = 0.200000002980232

			if var_40_25 <= arg_37_1.time_ and arg_37_1.time_ < var_40_25 + var_40_26 and not isNil(var_40_24) then
				local var_40_27 = (arg_37_1.time_ - var_40_25) / var_40_26

				if arg_37_1.var_.characterEffect10079ui_story and not isNil(var_40_24) then
					local var_40_28 = Mathf.Lerp(0, 0.5, var_40_27)

					arg_37_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10079ui_story.fillRatio = var_40_28
				end
			end

			if arg_37_1.time_ >= var_40_25 + var_40_26 and arg_37_1.time_ < var_40_25 + var_40_26 + arg_40_0 and not isNil(var_40_24) and arg_37_1.var_.characterEffect10079ui_story then
				local var_40_29 = 0.5

				arg_37_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10079ui_story.fillRatio = var_40_29
			end

			local var_40_30 = 0
			local var_40_31 = 0.275

			if var_40_30 < arg_37_1.time_ and arg_37_1.time_ <= var_40_30 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_32 = arg_37_1:FormatText(StoryNameCfg[668].name)

				arg_37_1.leftNameTxt_.text = var_40_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_33 = arg_37_1:GetWordFromCfg(319951009)
				local var_40_34 = arg_37_1:FormatText(var_40_33.content)

				arg_37_1.text_.text = var_40_34

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_35 = 11
				local var_40_36 = utf8.len(var_40_34)
				local var_40_37 = var_40_35 <= 0 and var_40_31 or var_40_31 * (var_40_36 / var_40_35)

				if var_40_37 > 0 and var_40_31 < var_40_37 then
					arg_37_1.talkMaxDuration = var_40_37

					if var_40_37 + var_40_30 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_37 + var_40_30
					end
				end

				arg_37_1.text_.text = var_40_34
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951009", "story_v_out_319951.awb") ~= 0 then
					local var_40_38 = manager.audio:GetVoiceLength("story_v_out_319951", "319951009", "story_v_out_319951.awb") / 1000

					if var_40_38 + var_40_30 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_38 + var_40_30
					end

					if var_40_33.prefab_name ~= "" and arg_37_1.actors_[var_40_33.prefab_name] ~= nil then
						local var_40_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_33.prefab_name].transform, "story_v_out_319951", "319951009", "story_v_out_319951.awb")

						arg_37_1:RecordAudio("319951009", var_40_39)
						arg_37_1:RecordAudio("319951009", var_40_39)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319951", "319951009", "story_v_out_319951.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319951", "319951009", "story_v_out_319951.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_40 = math.max(var_40_31, arg_37_1.talkMaxDuration)

			if var_40_30 <= arg_37_1.time_ and arg_37_1.time_ < var_40_30 + var_40_40 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_30) / var_40_40

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_30 + var_40_40 and arg_37_1.time_ < var_40_30 + var_40_40 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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
				actorName = "10079ui_story",
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
	Play319951010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319951010
		arg_41_1.duration_ = 6.43

		local var_41_0 = {
			zh = 4.633,
			ja = 6.433
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
				arg_41_0:Play319951011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1095ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1095ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(0.7, -0.98, -6.1)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1095ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["1095ui_story"]
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1095ui_story == nil then
				arg_41_1.var_.characterEffect1095ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 and not isNil(var_44_9) then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11

				if arg_41_1.var_.characterEffect1095ui_story and not isNil(var_44_9) then
					arg_41_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1095ui_story then
				arg_41_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_44_13 = 0

			if var_44_13 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 then
				arg_41_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_44_14 = 0

			if var_44_14 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 then
				arg_41_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_15 = arg_41_1.actors_["4040ui_story"].transform
			local var_44_16 = 0

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				arg_41_1.var_.moveOldPos4040ui_story = var_44_15.localPosition
			end

			local var_44_17 = 0.001

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_17 then
				local var_44_18 = (arg_41_1.time_ - var_44_16) / var_44_17
				local var_44_19 = Vector3.New(-0.7, -1.55, -5.5)

				var_44_15.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos4040ui_story, var_44_19, var_44_18)

				local var_44_20 = manager.ui.mainCamera.transform.position - var_44_15.position

				var_44_15.forward = Vector3.New(var_44_20.x, var_44_20.y, var_44_20.z)

				local var_44_21 = var_44_15.localEulerAngles

				var_44_21.z = 0
				var_44_21.x = 0
				var_44_15.localEulerAngles = var_44_21
			end

			if arg_41_1.time_ >= var_44_16 + var_44_17 and arg_41_1.time_ < var_44_16 + var_44_17 + arg_44_0 then
				var_44_15.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_44_22 = manager.ui.mainCamera.transform.position - var_44_15.position

				var_44_15.forward = Vector3.New(var_44_22.x, var_44_22.y, var_44_22.z)

				local var_44_23 = var_44_15.localEulerAngles

				var_44_23.z = 0
				var_44_23.x = 0
				var_44_15.localEulerAngles = var_44_23
			end

			local var_44_24 = arg_41_1.actors_["4040ui_story"]
			local var_44_25 = 0

			if var_44_25 < arg_41_1.time_ and arg_41_1.time_ <= var_44_25 + arg_44_0 and not isNil(var_44_24) and arg_41_1.var_.characterEffect4040ui_story == nil then
				arg_41_1.var_.characterEffect4040ui_story = var_44_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_26 = 0.200000002980232

			if var_44_25 <= arg_41_1.time_ and arg_41_1.time_ < var_44_25 + var_44_26 and not isNil(var_44_24) then
				local var_44_27 = (arg_41_1.time_ - var_44_25) / var_44_26

				if arg_41_1.var_.characterEffect4040ui_story and not isNil(var_44_24) then
					local var_44_28 = Mathf.Lerp(0, 0.5, var_44_27)

					arg_41_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_41_1.var_.characterEffect4040ui_story.fillRatio = var_44_28
				end
			end

			if arg_41_1.time_ >= var_44_25 + var_44_26 and arg_41_1.time_ < var_44_25 + var_44_26 + arg_44_0 and not isNil(var_44_24) and arg_41_1.var_.characterEffect4040ui_story then
				local var_44_29 = 0.5

				arg_41_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_41_1.var_.characterEffect4040ui_story.fillRatio = var_44_29
			end

			local var_44_30 = 0
			local var_44_31 = 0.625

			if var_44_30 < arg_41_1.time_ and arg_41_1.time_ <= var_44_30 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_32 = arg_41_1:FormatText(StoryNameCfg[471].name)

				arg_41_1.leftNameTxt_.text = var_44_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_33 = arg_41_1:GetWordFromCfg(319951010)
				local var_44_34 = arg_41_1:FormatText(var_44_33.content)

				arg_41_1.text_.text = var_44_34

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_35 = 25
				local var_44_36 = utf8.len(var_44_34)
				local var_44_37 = var_44_35 <= 0 and var_44_31 or var_44_31 * (var_44_36 / var_44_35)

				if var_44_37 > 0 and var_44_31 < var_44_37 then
					arg_41_1.talkMaxDuration = var_44_37

					if var_44_37 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_37 + var_44_30
					end
				end

				arg_41_1.text_.text = var_44_34
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951010", "story_v_out_319951.awb") ~= 0 then
					local var_44_38 = manager.audio:GetVoiceLength("story_v_out_319951", "319951010", "story_v_out_319951.awb") / 1000

					if var_44_38 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_38 + var_44_30
					end

					if var_44_33.prefab_name ~= "" and arg_41_1.actors_[var_44_33.prefab_name] ~= nil then
						local var_44_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_33.prefab_name].transform, "story_v_out_319951", "319951010", "story_v_out_319951.awb")

						arg_41_1:RecordAudio("319951010", var_44_39)
						arg_41_1:RecordAudio("319951010", var_44_39)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319951", "319951010", "story_v_out_319951.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319951", "319951010", "story_v_out_319951.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_40 = math.max(var_44_31, arg_41_1.talkMaxDuration)

			if var_44_30 <= arg_41_1.time_ and arg_41_1.time_ < var_44_30 + var_44_40 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_30) / var_44_40

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_30 + var_44_40 and arg_41_1.time_ < var_44_30 + var_44_40 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_41_1:InitPlayNodeList()
	end,
	Play319951011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319951011
		arg_45_1.duration_ = 4.9

		local var_45_0 = {
			zh = 4.9,
			ja = 3.9
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
				arg_45_0:Play319951012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1095ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1095ui_story == nil then
				arg_45_1.var_.characterEffect1095ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1095ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1095ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1095ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1095ui_story.fillRatio = var_48_5
			end

			local var_48_6 = arg_45_1.actors_["4040ui_story"]
			local var_48_7 = 0

			if var_48_7 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect4040ui_story == nil then
				arg_45_1.var_.characterEffect4040ui_story = var_48_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_8 = 0.200000002980232

			if var_48_7 <= arg_45_1.time_ and arg_45_1.time_ < var_48_7 + var_48_8 and not isNil(var_48_6) then
				local var_48_9 = (arg_45_1.time_ - var_48_7) / var_48_8

				if arg_45_1.var_.characterEffect4040ui_story and not isNil(var_48_6) then
					arg_45_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_7 + var_48_8 and arg_45_1.time_ < var_48_7 + var_48_8 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect4040ui_story then
				arg_45_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_48_10 = 0
			local var_48_11 = 0.45

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_12 = arg_45_1:FormatText(StoryNameCfg[668].name)

				arg_45_1.leftNameTxt_.text = var_48_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_13 = arg_45_1:GetWordFromCfg(319951011)
				local var_48_14 = arg_45_1:FormatText(var_48_13.content)

				arg_45_1.text_.text = var_48_14

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_15 = 18
				local var_48_16 = utf8.len(var_48_14)
				local var_48_17 = var_48_15 <= 0 and var_48_11 or var_48_11 * (var_48_16 / var_48_15)

				if var_48_17 > 0 and var_48_11 < var_48_17 then
					arg_45_1.talkMaxDuration = var_48_17

					if var_48_17 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_17 + var_48_10
					end
				end

				arg_45_1.text_.text = var_48_14
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951011", "story_v_out_319951.awb") ~= 0 then
					local var_48_18 = manager.audio:GetVoiceLength("story_v_out_319951", "319951011", "story_v_out_319951.awb") / 1000

					if var_48_18 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_10
					end

					if var_48_13.prefab_name ~= "" and arg_45_1.actors_[var_48_13.prefab_name] ~= nil then
						local var_48_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_13.prefab_name].transform, "story_v_out_319951", "319951011", "story_v_out_319951.awb")

						arg_45_1:RecordAudio("319951011", var_48_19)
						arg_45_1:RecordAudio("319951011", var_48_19)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319951", "319951011", "story_v_out_319951.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319951", "319951011", "story_v_out_319951.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_20 = math.max(var_48_11, arg_45_1.talkMaxDuration)

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_20 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_10) / var_48_20

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_10 + var_48_20 and arg_45_1.time_ < var_48_10 + var_48_20 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play319951012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319951012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play319951013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1095ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1095ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(0, 100, 0)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1095ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, 100, 0)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["1095ui_story"]
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1095ui_story == nil then
				arg_49_1.var_.characterEffect1095ui_story = var_52_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 and not isNil(var_52_9) then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11

				if arg_49_1.var_.characterEffect1095ui_story and not isNil(var_52_9) then
					local var_52_13 = Mathf.Lerp(0, 0.5, var_52_12)

					arg_49_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1095ui_story.fillRatio = var_52_13
				end
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1095ui_story then
				local var_52_14 = 0.5

				arg_49_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1095ui_story.fillRatio = var_52_14
			end

			local var_52_15 = arg_49_1.actors_["4040ui_story"].transform
			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.var_.moveOldPos4040ui_story = var_52_15.localPosition
			end

			local var_52_17 = 0.001

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_17 then
				local var_52_18 = (arg_49_1.time_ - var_52_16) / var_52_17
				local var_52_19 = Vector3.New(0, 100, 0)

				var_52_15.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos4040ui_story, var_52_19, var_52_18)

				local var_52_20 = manager.ui.mainCamera.transform.position - var_52_15.position

				var_52_15.forward = Vector3.New(var_52_20.x, var_52_20.y, var_52_20.z)

				local var_52_21 = var_52_15.localEulerAngles

				var_52_21.z = 0
				var_52_21.x = 0
				var_52_15.localEulerAngles = var_52_21
			end

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 then
				var_52_15.localPosition = Vector3.New(0, 100, 0)

				local var_52_22 = manager.ui.mainCamera.transform.position - var_52_15.position

				var_52_15.forward = Vector3.New(var_52_22.x, var_52_22.y, var_52_22.z)

				local var_52_23 = var_52_15.localEulerAngles

				var_52_23.z = 0
				var_52_23.x = 0
				var_52_15.localEulerAngles = var_52_23
			end

			local var_52_24 = arg_49_1.actors_["4040ui_story"]
			local var_52_25 = 0

			if var_52_25 < arg_49_1.time_ and arg_49_1.time_ <= var_52_25 + arg_52_0 and not isNil(var_52_24) and arg_49_1.var_.characterEffect4040ui_story == nil then
				arg_49_1.var_.characterEffect4040ui_story = var_52_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_26 = 0.200000002980232

			if var_52_25 <= arg_49_1.time_ and arg_49_1.time_ < var_52_25 + var_52_26 and not isNil(var_52_24) then
				local var_52_27 = (arg_49_1.time_ - var_52_25) / var_52_26

				if arg_49_1.var_.characterEffect4040ui_story and not isNil(var_52_24) then
					local var_52_28 = Mathf.Lerp(0, 0.5, var_52_27)

					arg_49_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_49_1.var_.characterEffect4040ui_story.fillRatio = var_52_28
				end
			end

			if arg_49_1.time_ >= var_52_25 + var_52_26 and arg_49_1.time_ < var_52_25 + var_52_26 + arg_52_0 and not isNil(var_52_24) and arg_49_1.var_.characterEffect4040ui_story then
				local var_52_29 = 0.5

				arg_49_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_49_1.var_.characterEffect4040ui_story.fillRatio = var_52_29
			end

			local var_52_30 = 0
			local var_52_31 = 1.175

			if var_52_30 < arg_49_1.time_ and arg_49_1.time_ <= var_52_30 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_32 = arg_49_1:GetWordFromCfg(319951012)
				local var_52_33 = arg_49_1:FormatText(var_52_32.content)

				arg_49_1.text_.text = var_52_33

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_34 = 47
				local var_52_35 = utf8.len(var_52_33)
				local var_52_36 = var_52_34 <= 0 and var_52_31 or var_52_31 * (var_52_35 / var_52_34)

				if var_52_36 > 0 and var_52_31 < var_52_36 then
					arg_49_1.talkMaxDuration = var_52_36

					if var_52_36 + var_52_30 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_36 + var_52_30
					end
				end

				arg_49_1.text_.text = var_52_33
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_37 = math.max(var_52_31, arg_49_1.talkMaxDuration)

			if var_52_30 <= arg_49_1.time_ and arg_49_1.time_ < var_52_30 + var_52_37 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_30) / var_52_37

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_30 + var_52_37 and arg_49_1.time_ < var_52_30 + var_52_37 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_49_1:InitPlayNodeList()
	end,
	Play319951013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319951013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play319951014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.25

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(319951013)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 50
				local var_56_5 = utf8.len(var_56_3)
				local var_56_6 = var_56_4 <= 0 and var_56_1 or var_56_1 * (var_56_5 / var_56_4)

				if var_56_6 > 0 and var_56_1 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_7 and arg_53_1.time_ < var_56_0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play319951014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319951014
		arg_57_1.duration_ = 4.8

		local var_57_0 = {
			zh = 2.366,
			ja = 4.8
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
				arg_57_0:Play319951015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10079ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos10079ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(0, -0.95, -6.05)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10079ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = arg_57_1.actors_["10079ui_story"]
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect10079ui_story == nil then
				arg_57_1.var_.characterEffect10079ui_story = var_60_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_11 = 0.200000002980232

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 and not isNil(var_60_9) then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11

				if arg_57_1.var_.characterEffect10079ui_story and not isNil(var_60_9) then
					arg_57_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect10079ui_story then
				arg_57_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_60_13 = 0

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				arg_57_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_60_15 = 0
			local var_60_16 = 0.275

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_17 = arg_57_1:FormatText(StoryNameCfg[6].name)

				arg_57_1.leftNameTxt_.text = var_60_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_18 = arg_57_1:GetWordFromCfg(319951014)
				local var_60_19 = arg_57_1:FormatText(var_60_18.content)

				arg_57_1.text_.text = var_60_19

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_20 = 11
				local var_60_21 = utf8.len(var_60_19)
				local var_60_22 = var_60_20 <= 0 and var_60_16 or var_60_16 * (var_60_21 / var_60_20)

				if var_60_22 > 0 and var_60_16 < var_60_22 then
					arg_57_1.talkMaxDuration = var_60_22

					if var_60_22 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_22 + var_60_15
					end
				end

				arg_57_1.text_.text = var_60_19
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951014", "story_v_out_319951.awb") ~= 0 then
					local var_60_23 = manager.audio:GetVoiceLength("story_v_out_319951", "319951014", "story_v_out_319951.awb") / 1000

					if var_60_23 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_23 + var_60_15
					end

					if var_60_18.prefab_name ~= "" and arg_57_1.actors_[var_60_18.prefab_name] ~= nil then
						local var_60_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_18.prefab_name].transform, "story_v_out_319951", "319951014", "story_v_out_319951.awb")

						arg_57_1:RecordAudio("319951014", var_60_24)
						arg_57_1:RecordAudio("319951014", var_60_24)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319951", "319951014", "story_v_out_319951.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319951", "319951014", "story_v_out_319951.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_25 = math.max(var_60_16, arg_57_1.talkMaxDuration)

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_25 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_15) / var_60_25

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_15 + var_60_25 and arg_57_1.time_ < var_60_15 + var_60_25 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play319951015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319951015
		arg_61_1.duration_ = 12.4

		local var_61_0 = {
			zh = 7.966,
			ja = 12.4
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
				arg_61_0:Play319951016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10079ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect10079ui_story == nil then
				arg_61_1.var_.characterEffect10079ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect10079ui_story and not isNil(var_64_0) then
					local var_64_4 = Mathf.Lerp(0, 0.5, var_64_3)

					arg_61_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10079ui_story.fillRatio = var_64_4
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect10079ui_story then
				local var_64_5 = 0.5

				arg_61_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10079ui_story.fillRatio = var_64_5
			end

			local var_64_6 = 0
			local var_64_7 = 0.725

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_8 = arg_61_1:FormatText(StoryNameCfg[699].name)

				arg_61_1.leftNameTxt_.text = var_64_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_9 = arg_61_1:GetWordFromCfg(319951015)
				local var_64_10 = arg_61_1:FormatText(var_64_9.content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951015", "story_v_out_319951.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_319951", "319951015", "story_v_out_319951.awb") / 1000

					if var_64_14 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_6
					end

					if var_64_9.prefab_name ~= "" and arg_61_1.actors_[var_64_9.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_9.prefab_name].transform, "story_v_out_319951", "319951015", "story_v_out_319951.awb")

						arg_61_1:RecordAudio("319951015", var_64_15)
						arg_61_1:RecordAudio("319951015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319951", "319951015", "story_v_out_319951.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319951", "319951015", "story_v_out_319951.awb")
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
	Play319951016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319951016
		arg_65_1.duration_ = 8.8

		local var_65_0 = {
			zh = 4.266,
			ja = 8.8
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
				arg_65_0:Play319951017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10079ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10079ui_story == nil then
				arg_65_1.var_.characterEffect10079ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect10079ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10079ui_story then
				arg_65_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_68_4 = 0
			local var_68_5 = 0.375

			if var_68_4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_6 = arg_65_1:FormatText(StoryNameCfg[6].name)

				arg_65_1.leftNameTxt_.text = var_68_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:GetWordFromCfg(319951016)
				local var_68_8 = arg_65_1:FormatText(var_68_7.content)

				arg_65_1.text_.text = var_68_8

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 15
				local var_68_10 = utf8.len(var_68_8)
				local var_68_11 = var_68_9 <= 0 and var_68_5 or var_68_5 * (var_68_10 / var_68_9)

				if var_68_11 > 0 and var_68_5 < var_68_11 then
					arg_65_1.talkMaxDuration = var_68_11

					if var_68_11 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_8
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951016", "story_v_out_319951.awb") ~= 0 then
					local var_68_12 = manager.audio:GetVoiceLength("story_v_out_319951", "319951016", "story_v_out_319951.awb") / 1000

					if var_68_12 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_4
					end

					if var_68_7.prefab_name ~= "" and arg_65_1.actors_[var_68_7.prefab_name] ~= nil then
						local var_68_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_7.prefab_name].transform, "story_v_out_319951", "319951016", "story_v_out_319951.awb")

						arg_65_1:RecordAudio("319951016", var_68_13)
						arg_65_1:RecordAudio("319951016", var_68_13)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319951", "319951016", "story_v_out_319951.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319951", "319951016", "story_v_out_319951.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_14 and arg_65_1.time_ < var_68_4 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play319951017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319951017
		arg_69_1.duration_ = 19.37

		local var_69_0 = {
			zh = 5.466,
			ja = 19.366
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
				arg_69_0:Play319951018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10079ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10079ui_story == nil then
				arg_69_1.var_.characterEffect10079ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect10079ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10079ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10079ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10079ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 0.6

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[699].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_9 = arg_69_1:GetWordFromCfg(319951017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 24
				local var_72_12 = utf8.len(var_72_10)
				local var_72_13 = var_72_11 <= 0 and var_72_7 or var_72_7 * (var_72_12 / var_72_11)

				if var_72_13 > 0 and var_72_7 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_10
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951017", "story_v_out_319951.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_319951", "319951017", "story_v_out_319951.awb") / 1000

					if var_72_14 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_6
					end

					if var_72_9.prefab_name ~= "" and arg_69_1.actors_[var_72_9.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_9.prefab_name].transform, "story_v_out_319951", "319951017", "story_v_out_319951.awb")

						arg_69_1:RecordAudio("319951017", var_72_15)
						arg_69_1:RecordAudio("319951017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319951", "319951017", "story_v_out_319951.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319951", "319951017", "story_v_out_319951.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_16 and arg_69_1.time_ < var_72_6 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play319951018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319951018
		arg_73_1.duration_ = 15

		local var_73_0 = {
			zh = 8.8,
			ja = 15
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
				arg_73_0:Play319951019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.975

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[699].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(319951018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951018", "story_v_out_319951.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_319951", "319951018", "story_v_out_319951.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_319951", "319951018", "story_v_out_319951.awb")

						arg_73_1:RecordAudio("319951018", var_76_9)
						arg_73_1:RecordAudio("319951018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_319951", "319951018", "story_v_out_319951.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_319951", "319951018", "story_v_out_319951.awb")
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
	Play319951019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319951019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play319951020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_80_1 = 0
			local var_80_2 = 1.1

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:GetWordFromCfg(319951019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 44
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_2 or var_80_2 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_2 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_8 and arg_77_1.time_ < var_80_1 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play319951020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319951020
		arg_81_1.duration_ = 10.5

		local var_81_0 = {
			zh = 6.566,
			ja = 10.5
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
				arg_81_0:Play319951021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10079ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos10079ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0, -0.95, -6.05)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10079ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = arg_81_1.actors_["10079ui_story"]
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect10079ui_story == nil then
				arg_81_1.var_.characterEffect10079ui_story = var_84_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.200000002980232

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 and not isNil(var_84_9) then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11

				if arg_81_1.var_.characterEffect10079ui_story and not isNil(var_84_9) then
					arg_81_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect10079ui_story then
				arg_81_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_84_13 = 0

			if var_84_13 < arg_81_1.time_ and arg_81_1.time_ <= var_84_13 + arg_84_0 then
				arg_81_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_84_14 = 0

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_15 = 0
			local var_84_16 = 0.85

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_17 = arg_81_1:FormatText(StoryNameCfg[6].name)

				arg_81_1.leftNameTxt_.text = var_84_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_18 = arg_81_1:GetWordFromCfg(319951020)
				local var_84_19 = arg_81_1:FormatText(var_84_18.content)

				arg_81_1.text_.text = var_84_19

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_20 = 34
				local var_84_21 = utf8.len(var_84_19)
				local var_84_22 = var_84_20 <= 0 and var_84_16 or var_84_16 * (var_84_21 / var_84_20)

				if var_84_22 > 0 and var_84_16 < var_84_22 then
					arg_81_1.talkMaxDuration = var_84_22

					if var_84_22 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_22 + var_84_15
					end
				end

				arg_81_1.text_.text = var_84_19
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951020", "story_v_out_319951.awb") ~= 0 then
					local var_84_23 = manager.audio:GetVoiceLength("story_v_out_319951", "319951020", "story_v_out_319951.awb") / 1000

					if var_84_23 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_23 + var_84_15
					end

					if var_84_18.prefab_name ~= "" and arg_81_1.actors_[var_84_18.prefab_name] ~= nil then
						local var_84_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_18.prefab_name].transform, "story_v_out_319951", "319951020", "story_v_out_319951.awb")

						arg_81_1:RecordAudio("319951020", var_84_24)
						arg_81_1:RecordAudio("319951020", var_84_24)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_319951", "319951020", "story_v_out_319951.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_319951", "319951020", "story_v_out_319951.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_25 = math.max(var_84_16, arg_81_1.talkMaxDuration)

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_25 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_15) / var_84_25

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_15 + var_84_25 and arg_81_1.time_ < var_84_15 + var_84_25 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319951021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319951021
		arg_85_1.duration_ = 6.6

		local var_85_0 = {
			zh = 5.066,
			ja = 6.6
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
				arg_85_0:Play319951022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10079ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10079ui_story == nil then
				arg_85_1.var_.characterEffect10079ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect10079ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10079ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10079ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10079ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.325

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[699].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_9 = arg_85_1:GetWordFromCfg(319951021)
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

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951021", "story_v_out_319951.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_319951", "319951021", "story_v_out_319951.awb") / 1000

					if var_88_14 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_6
					end

					if var_88_9.prefab_name ~= "" and arg_85_1.actors_[var_88_9.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_9.prefab_name].transform, "story_v_out_319951", "319951021", "story_v_out_319951.awb")

						arg_85_1:RecordAudio("319951021", var_88_15)
						arg_85_1:RecordAudio("319951021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319951", "319951021", "story_v_out_319951.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319951", "319951021", "story_v_out_319951.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_16 and arg_85_1.time_ < var_88_6 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play319951022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319951022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play319951023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10079ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10079ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, 100, 0)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10079ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, 100, 0)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = 0
			local var_92_10 = 0.675

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_11 = arg_89_1:GetWordFromCfg(319951022)
				local var_92_12 = arg_89_1:FormatText(var_92_11.content)

				arg_89_1.text_.text = var_92_12

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_13 = 27
				local var_92_14 = utf8.len(var_92_12)
				local var_92_15 = var_92_13 <= 0 and var_92_10 or var_92_10 * (var_92_14 / var_92_13)

				if var_92_15 > 0 and var_92_10 < var_92_15 then
					arg_89_1.talkMaxDuration = var_92_15

					if var_92_15 + var_92_9 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_15 + var_92_9
					end
				end

				arg_89_1.text_.text = var_92_12
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_16 = math.max(var_92_10, arg_89_1.talkMaxDuration)

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_16 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_9) / var_92_16

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_9 + var_92_16 and arg_89_1.time_ < var_92_9 + var_92_16 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play319951023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319951023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play319951024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 1.1

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:GetWordFromCfg(319951023)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 44
				local var_96_5 = utf8.len(var_96_3)
				local var_96_6 = var_96_4 <= 0 and var_96_1 or var_96_1 * (var_96_5 / var_96_4)

				if var_96_6 > 0 and var_96_1 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_7 and arg_93_1.time_ < var_96_0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319951024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319951024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play319951025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 1.1

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_2 = arg_97_1:GetWordFromCfg(319951024)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 44
				local var_100_5 = utf8.len(var_100_3)
				local var_100_6 = var_100_4 <= 0 and var_100_1 or var_100_1 * (var_100_5 / var_100_4)

				if var_100_6 > 0 and var_100_1 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_7 and arg_97_1.time_ < var_100_0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play319951025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319951025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play319951026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.55

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_2 = arg_101_1:GetWordFromCfg(319951025)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 22
				local var_104_5 = utf8.len(var_104_3)
				local var_104_6 = var_104_4 <= 0 and var_104_1 or var_104_1 * (var_104_5 / var_104_4)

				if var_104_6 > 0 and var_104_1 < var_104_6 then
					arg_101_1.talkMaxDuration = var_104_6

					if var_104_6 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_7 and arg_101_1.time_ < var_104_0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play319951026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319951026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play319951027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 1.2

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_2 = arg_105_1:GetWordFromCfg(319951026)
				local var_108_3 = arg_105_1:FormatText(var_108_2.content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 48
				local var_108_5 = utf8.len(var_108_3)
				local var_108_6 = var_108_4 <= 0 and var_108_1 or var_108_1 * (var_108_5 / var_108_4)

				if var_108_6 > 0 and var_108_1 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_7 and arg_105_1.time_ < var_108_0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play319951027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319951027
		arg_109_1.duration_ = 4.73

		local var_109_0 = {
			zh = 2.2,
			ja = 4.733
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
				arg_109_0:Play319951028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10079ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos10079ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0, -0.95, -6.05)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10079ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["10079ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect10079ui_story == nil then
				arg_109_1.var_.characterEffect10079ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect10079ui_story and not isNil(var_112_9) then
					arg_109_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect10079ui_story then
				arg_109_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_112_13 = 0

			if var_112_13 < arg_109_1.time_ and arg_109_1.time_ <= var_112_13 + arg_112_0 then
				arg_109_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_112_14 = 0

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_112_15 = 0
			local var_112_16 = 0.35

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_17 = arg_109_1:FormatText(StoryNameCfg[6].name)

				arg_109_1.leftNameTxt_.text = var_112_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_18 = arg_109_1:GetWordFromCfg(319951027)
				local var_112_19 = arg_109_1:FormatText(var_112_18.content)

				arg_109_1.text_.text = var_112_19

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_20 = 14
				local var_112_21 = utf8.len(var_112_19)
				local var_112_22 = var_112_20 <= 0 and var_112_16 or var_112_16 * (var_112_21 / var_112_20)

				if var_112_22 > 0 and var_112_16 < var_112_22 then
					arg_109_1.talkMaxDuration = var_112_22

					if var_112_22 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_22 + var_112_15
					end
				end

				arg_109_1.text_.text = var_112_19
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951027", "story_v_out_319951.awb") ~= 0 then
					local var_112_23 = manager.audio:GetVoiceLength("story_v_out_319951", "319951027", "story_v_out_319951.awb") / 1000

					if var_112_23 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_15
					end

					if var_112_18.prefab_name ~= "" and arg_109_1.actors_[var_112_18.prefab_name] ~= nil then
						local var_112_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_18.prefab_name].transform, "story_v_out_319951", "319951027", "story_v_out_319951.awb")

						arg_109_1:RecordAudio("319951027", var_112_24)
						arg_109_1:RecordAudio("319951027", var_112_24)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_319951", "319951027", "story_v_out_319951.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_319951", "319951027", "story_v_out_319951.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_25 = math.max(var_112_16, arg_109_1.talkMaxDuration)

			if var_112_15 <= arg_109_1.time_ and arg_109_1.time_ < var_112_15 + var_112_25 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_15) / var_112_25

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_15 + var_112_25 and arg_109_1.time_ < var_112_15 + var_112_25 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play319951028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319951028
		arg_113_1.duration_ = 7.6

		local var_113_0 = {
			zh = 7.6,
			ja = 3.366
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
				arg_113_0:Play319951029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1095ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1095ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0.7, -0.98, -6.1)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1095ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["1095ui_story"]
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1095ui_story == nil then
				arg_113_1.var_.characterEffect1095ui_story = var_116_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.200000002980232

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 and not isNil(var_116_9) then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11

				if arg_113_1.var_.characterEffect1095ui_story and not isNil(var_116_9) then
					arg_113_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1095ui_story then
				arg_113_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_116_13 = 0

			if var_116_13 < arg_113_1.time_ and arg_113_1.time_ <= var_116_13 + arg_116_0 then
				arg_113_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_116_14 = 0

			if var_116_14 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_15 = arg_113_1.actors_["10079ui_story"].transform
			local var_116_16 = 0

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 then
				arg_113_1.var_.moveOldPos10079ui_story = var_116_15.localPosition
			end

			local var_116_17 = 0.001

			if var_116_16 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_17 then
				local var_116_18 = (arg_113_1.time_ - var_116_16) / var_116_17
				local var_116_19 = Vector3.New(-0.7, -0.95, -6.05)

				var_116_15.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10079ui_story, var_116_19, var_116_18)

				local var_116_20 = manager.ui.mainCamera.transform.position - var_116_15.position

				var_116_15.forward = Vector3.New(var_116_20.x, var_116_20.y, var_116_20.z)

				local var_116_21 = var_116_15.localEulerAngles

				var_116_21.z = 0
				var_116_21.x = 0
				var_116_15.localEulerAngles = var_116_21
			end

			if arg_113_1.time_ >= var_116_16 + var_116_17 and arg_113_1.time_ < var_116_16 + var_116_17 + arg_116_0 then
				var_116_15.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_116_22 = manager.ui.mainCamera.transform.position - var_116_15.position

				var_116_15.forward = Vector3.New(var_116_22.x, var_116_22.y, var_116_22.z)

				local var_116_23 = var_116_15.localEulerAngles

				var_116_23.z = 0
				var_116_23.x = 0
				var_116_15.localEulerAngles = var_116_23
			end

			local var_116_24 = arg_113_1.actors_["10079ui_story"]
			local var_116_25 = 0

			if var_116_25 < arg_113_1.time_ and arg_113_1.time_ <= var_116_25 + arg_116_0 and not isNil(var_116_24) and arg_113_1.var_.characterEffect10079ui_story == nil then
				arg_113_1.var_.characterEffect10079ui_story = var_116_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_26 = 0.200000002980232

			if var_116_25 <= arg_113_1.time_ and arg_113_1.time_ < var_116_25 + var_116_26 and not isNil(var_116_24) then
				local var_116_27 = (arg_113_1.time_ - var_116_25) / var_116_26

				if arg_113_1.var_.characterEffect10079ui_story and not isNil(var_116_24) then
					local var_116_28 = Mathf.Lerp(0, 0.5, var_116_27)

					arg_113_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10079ui_story.fillRatio = var_116_28
				end
			end

			if arg_113_1.time_ >= var_116_25 + var_116_26 and arg_113_1.time_ < var_116_25 + var_116_26 + arg_116_0 and not isNil(var_116_24) and arg_113_1.var_.characterEffect10079ui_story then
				local var_116_29 = 0.5

				arg_113_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10079ui_story.fillRatio = var_116_29
			end

			local var_116_30 = 0
			local var_116_31 = 0.775

			if var_116_30 < arg_113_1.time_ and arg_113_1.time_ <= var_116_30 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_32 = arg_113_1:FormatText(StoryNameCfg[471].name)

				arg_113_1.leftNameTxt_.text = var_116_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_33 = arg_113_1:GetWordFromCfg(319951028)
				local var_116_34 = arg_113_1:FormatText(var_116_33.content)

				arg_113_1.text_.text = var_116_34

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_35 = 31
				local var_116_36 = utf8.len(var_116_34)
				local var_116_37 = var_116_35 <= 0 and var_116_31 or var_116_31 * (var_116_36 / var_116_35)

				if var_116_37 > 0 and var_116_31 < var_116_37 then
					arg_113_1.talkMaxDuration = var_116_37

					if var_116_37 + var_116_30 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_37 + var_116_30
					end
				end

				arg_113_1.text_.text = var_116_34
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951028", "story_v_out_319951.awb") ~= 0 then
					local var_116_38 = manager.audio:GetVoiceLength("story_v_out_319951", "319951028", "story_v_out_319951.awb") / 1000

					if var_116_38 + var_116_30 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_38 + var_116_30
					end

					if var_116_33.prefab_name ~= "" and arg_113_1.actors_[var_116_33.prefab_name] ~= nil then
						local var_116_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_33.prefab_name].transform, "story_v_out_319951", "319951028", "story_v_out_319951.awb")

						arg_113_1:RecordAudio("319951028", var_116_39)
						arg_113_1:RecordAudio("319951028", var_116_39)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_319951", "319951028", "story_v_out_319951.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_319951", "319951028", "story_v_out_319951.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_40 = math.max(var_116_31, arg_113_1.talkMaxDuration)

			if var_116_30 <= arg_113_1.time_ and arg_113_1.time_ < var_116_30 + var_116_40 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_30) / var_116_40

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_30 + var_116_40 and arg_113_1.time_ < var_116_30 + var_116_40 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play319951029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319951029
		arg_117_1.duration_ = 2

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play319951030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10079ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos10079ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10079ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = arg_117_1.actors_["10079ui_story"]
			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect10079ui_story == nil then
				arg_117_1.var_.characterEffect10079ui_story = var_120_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_11 = 0.200000002980232

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 and not isNil(var_120_9) then
				local var_120_12 = (arg_117_1.time_ - var_120_10) / var_120_11

				if arg_117_1.var_.characterEffect10079ui_story and not isNil(var_120_9) then
					arg_117_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect10079ui_story then
				arg_117_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_120_13 = 0

			if var_120_13 < arg_117_1.time_ and arg_117_1.time_ <= var_120_13 + arg_120_0 then
				arg_117_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_14 = arg_117_1.actors_["1095ui_story"]
			local var_120_15 = 0

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 and not isNil(var_120_14) and arg_117_1.var_.characterEffect1095ui_story == nil then
				arg_117_1.var_.characterEffect1095ui_story = var_120_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_16 = 0.200000002980232

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_16 and not isNil(var_120_14) then
				local var_120_17 = (arg_117_1.time_ - var_120_15) / var_120_16

				if arg_117_1.var_.characterEffect1095ui_story and not isNil(var_120_14) then
					local var_120_18 = Mathf.Lerp(0, 0.5, var_120_17)

					arg_117_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1095ui_story.fillRatio = var_120_18
				end
			end

			if arg_117_1.time_ >= var_120_15 + var_120_16 and arg_117_1.time_ < var_120_15 + var_120_16 + arg_120_0 and not isNil(var_120_14) and arg_117_1.var_.characterEffect1095ui_story then
				local var_120_19 = 0.5

				arg_117_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1095ui_story.fillRatio = var_120_19
			end

			local var_120_20 = 0
			local var_120_21 = 0.1

			if var_120_20 < arg_117_1.time_ and arg_117_1.time_ <= var_120_20 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_22 = arg_117_1:FormatText(StoryNameCfg[6].name)

				arg_117_1.leftNameTxt_.text = var_120_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_23 = arg_117_1:GetWordFromCfg(319951029)
				local var_120_24 = arg_117_1:FormatText(var_120_23.content)

				arg_117_1.text_.text = var_120_24

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_25 = 4
				local var_120_26 = utf8.len(var_120_24)
				local var_120_27 = var_120_25 <= 0 and var_120_21 or var_120_21 * (var_120_26 / var_120_25)

				if var_120_27 > 0 and var_120_21 < var_120_27 then
					arg_117_1.talkMaxDuration = var_120_27

					if var_120_27 + var_120_20 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_27 + var_120_20
					end
				end

				arg_117_1.text_.text = var_120_24
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951029", "story_v_out_319951.awb") ~= 0 then
					local var_120_28 = manager.audio:GetVoiceLength("story_v_out_319951", "319951029", "story_v_out_319951.awb") / 1000

					if var_120_28 + var_120_20 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_28 + var_120_20
					end

					if var_120_23.prefab_name ~= "" and arg_117_1.actors_[var_120_23.prefab_name] ~= nil then
						local var_120_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_23.prefab_name].transform, "story_v_out_319951", "319951029", "story_v_out_319951.awb")

						arg_117_1:RecordAudio("319951029", var_120_29)
						arg_117_1:RecordAudio("319951029", var_120_29)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_319951", "319951029", "story_v_out_319951.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_319951", "319951029", "story_v_out_319951.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_30 = math.max(var_120_21, arg_117_1.talkMaxDuration)

			if var_120_20 <= arg_117_1.time_ and arg_117_1.time_ < var_120_20 + var_120_30 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_20) / var_120_30

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_20 + var_120_30 and arg_117_1.time_ < var_120_20 + var_120_30 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play319951030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 319951030
		arg_121_1.duration_ = 3.27

		local var_121_0 = {
			zh = 2.5,
			ja = 3.266
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play319951031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10079ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect10079ui_story == nil then
				arg_121_1.var_.characterEffect10079ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect10079ui_story and not isNil(var_124_0) then
					local var_124_4 = Mathf.Lerp(0, 0.5, var_124_3)

					arg_121_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10079ui_story.fillRatio = var_124_4
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect10079ui_story then
				local var_124_5 = 0.5

				arg_121_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10079ui_story.fillRatio = var_124_5
			end

			local var_124_6 = arg_121_1.actors_["1095ui_story"]
			local var_124_7 = 0

			if var_124_7 < arg_121_1.time_ and arg_121_1.time_ <= var_124_7 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect1095ui_story == nil then
				arg_121_1.var_.characterEffect1095ui_story = var_124_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_8 = 0.200000002980232

			if var_124_7 <= arg_121_1.time_ and arg_121_1.time_ < var_124_7 + var_124_8 and not isNil(var_124_6) then
				local var_124_9 = (arg_121_1.time_ - var_124_7) / var_124_8

				if arg_121_1.var_.characterEffect1095ui_story and not isNil(var_124_6) then
					arg_121_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_7 + var_124_8 and arg_121_1.time_ < var_124_7 + var_124_8 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect1095ui_story then
				arg_121_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_124_10 = 0
			local var_124_11 = 0.25

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_12 = arg_121_1:FormatText(StoryNameCfg[471].name)

				arg_121_1.leftNameTxt_.text = var_124_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_13 = arg_121_1:GetWordFromCfg(319951030)
				local var_124_14 = arg_121_1:FormatText(var_124_13.content)

				arg_121_1.text_.text = var_124_14

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_15 = 10
				local var_124_16 = utf8.len(var_124_14)
				local var_124_17 = var_124_15 <= 0 and var_124_11 or var_124_11 * (var_124_16 / var_124_15)

				if var_124_17 > 0 and var_124_11 < var_124_17 then
					arg_121_1.talkMaxDuration = var_124_17

					if var_124_17 + var_124_10 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_17 + var_124_10
					end
				end

				arg_121_1.text_.text = var_124_14
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951030", "story_v_out_319951.awb") ~= 0 then
					local var_124_18 = manager.audio:GetVoiceLength("story_v_out_319951", "319951030", "story_v_out_319951.awb") / 1000

					if var_124_18 + var_124_10 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_18 + var_124_10
					end

					if var_124_13.prefab_name ~= "" and arg_121_1.actors_[var_124_13.prefab_name] ~= nil then
						local var_124_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_13.prefab_name].transform, "story_v_out_319951", "319951030", "story_v_out_319951.awb")

						arg_121_1:RecordAudio("319951030", var_124_19)
						arg_121_1:RecordAudio("319951030", var_124_19)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319951", "319951030", "story_v_out_319951.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319951", "319951030", "story_v_out_319951.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_20 = math.max(var_124_11, arg_121_1.talkMaxDuration)

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_20 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_10) / var_124_20

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_10 + var_124_20 and arg_121_1.time_ < var_124_10 + var_124_20 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play319951031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319951031
		arg_125_1.duration_ = 9.5

		local var_125_0 = {
			zh = 8.066,
			ja = 9.5
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
				arg_125_0:Play319951032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_128_2 = 0
			local var_128_3 = 0.95

			if var_128_2 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_4 = arg_125_1:FormatText(StoryNameCfg[471].name)

				arg_125_1.leftNameTxt_.text = var_128_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_5 = arg_125_1:GetWordFromCfg(319951031)
				local var_128_6 = arg_125_1:FormatText(var_128_5.content)

				arg_125_1.text_.text = var_128_6

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_7 = 38
				local var_128_8 = utf8.len(var_128_6)
				local var_128_9 = var_128_7 <= 0 and var_128_3 or var_128_3 * (var_128_8 / var_128_7)

				if var_128_9 > 0 and var_128_3 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_2
					end
				end

				arg_125_1.text_.text = var_128_6
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951031", "story_v_out_319951.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_319951", "319951031", "story_v_out_319951.awb") / 1000

					if var_128_10 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_2
					end

					if var_128_5.prefab_name ~= "" and arg_125_1.actors_[var_128_5.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_5.prefab_name].transform, "story_v_out_319951", "319951031", "story_v_out_319951.awb")

						arg_125_1:RecordAudio("319951031", var_128_11)
						arg_125_1:RecordAudio("319951031", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_319951", "319951031", "story_v_out_319951.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_319951", "319951031", "story_v_out_319951.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_3, arg_125_1.talkMaxDuration)

			if var_128_2 <= arg_125_1.time_ and arg_125_1.time_ < var_128_2 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_2) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_2 + var_128_12 and arg_125_1.time_ < var_128_2 + var_128_12 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play319951032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 319951032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play319951033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1095ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos1095ui_story = var_132_0.localPosition
			end

			local var_132_2 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2
				local var_132_4 = Vector3.New(0, 100, 0)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1095ui_story, var_132_4, var_132_3)

				local var_132_5 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_5.x, var_132_5.y, var_132_5.z)

				local var_132_6 = var_132_0.localEulerAngles

				var_132_6.z = 0
				var_132_6.x = 0
				var_132_0.localEulerAngles = var_132_6
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(0, 100, 0)

				local var_132_7 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_7.x, var_132_7.y, var_132_7.z)

				local var_132_8 = var_132_0.localEulerAngles

				var_132_8.z = 0
				var_132_8.x = 0
				var_132_0.localEulerAngles = var_132_8
			end

			local var_132_9 = arg_129_1.actors_["10079ui_story"].transform
			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 then
				arg_129_1.var_.moveOldPos10079ui_story = var_132_9.localPosition
			end

			local var_132_11 = 0.001

			if var_132_10 <= arg_129_1.time_ and arg_129_1.time_ < var_132_10 + var_132_11 then
				local var_132_12 = (arg_129_1.time_ - var_132_10) / var_132_11
				local var_132_13 = Vector3.New(0, 100, 0)

				var_132_9.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10079ui_story, var_132_13, var_132_12)

				local var_132_14 = manager.ui.mainCamera.transform.position - var_132_9.position

				var_132_9.forward = Vector3.New(var_132_14.x, var_132_14.y, var_132_14.z)

				local var_132_15 = var_132_9.localEulerAngles

				var_132_15.z = 0
				var_132_15.x = 0
				var_132_9.localEulerAngles = var_132_15
			end

			if arg_129_1.time_ >= var_132_10 + var_132_11 and arg_129_1.time_ < var_132_10 + var_132_11 + arg_132_0 then
				var_132_9.localPosition = Vector3.New(0, 100, 0)

				local var_132_16 = manager.ui.mainCamera.transform.position - var_132_9.position

				var_132_9.forward = Vector3.New(var_132_16.x, var_132_16.y, var_132_16.z)

				local var_132_17 = var_132_9.localEulerAngles

				var_132_17.z = 0
				var_132_17.x = 0
				var_132_9.localEulerAngles = var_132_17
			end

			local var_132_18 = 0
			local var_132_19 = 0.2

			if var_132_18 < arg_129_1.time_ and arg_129_1.time_ <= var_132_18 + arg_132_0 then
				local var_132_20 = "play"
				local var_132_21 = "music"

				arg_129_1:AudioAction(var_132_20, var_132_21, "ui_battle", "ui_battle_stopbgm", "")

				local var_132_22 = ""
				local var_132_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_132_23 ~= "" then
					if arg_129_1.bgmTxt_.text ~= var_132_23 and arg_129_1.bgmTxt_.text ~= "" then
						if arg_129_1.bgmTxt2_.text ~= "" then
							arg_129_1.bgmTxt_.text = arg_129_1.bgmTxt2_.text
						end

						arg_129_1.bgmTxt2_.text = var_132_23

						arg_129_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_129_1.bgmTxt_.text = var_132_23
						arg_129_1.bgmTxt2_.text = var_132_23
					end

					if arg_129_1.bgmTimer then
						arg_129_1.bgmTimer:Stop()

						arg_129_1.bgmTimer = nil
					end

					if arg_129_1.settingData.show_music_name == 1 then
						arg_129_1.musicController:SetSelectedState("show")
						arg_129_1.musicAnimator_:Play("open", 0, 0)

						if arg_129_1.settingData.music_time ~= 0 then
							arg_129_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_129_1.settingData.music_time), function()
								if arg_129_1 == nil or isNil(arg_129_1.bgmTxt_) then
									return
								end

								arg_129_1.musicController:SetSelectedState("hide")
								arg_129_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_132_24 = 0
			local var_132_25 = 1.175

			if var_132_24 < arg_129_1.time_ and arg_129_1.time_ <= var_132_24 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_26 = arg_129_1:GetWordFromCfg(319951032)
				local var_132_27 = arg_129_1:FormatText(var_132_26.content)

				arg_129_1.text_.text = var_132_27

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_28 = 47
				local var_132_29 = utf8.len(var_132_27)
				local var_132_30 = var_132_28 <= 0 and var_132_25 or var_132_25 * (var_132_29 / var_132_28)

				if var_132_30 > 0 and var_132_25 < var_132_30 then
					arg_129_1.talkMaxDuration = var_132_30

					if var_132_30 + var_132_24 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_30 + var_132_24
					end
				end

				arg_129_1.text_.text = var_132_27
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_31 = math.max(var_132_25, arg_129_1.talkMaxDuration)

			if var_132_24 <= arg_129_1.time_ and arg_129_1.time_ < var_132_24 + var_132_31 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_24) / var_132_31

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_24 + var_132_31 and arg_129_1.time_ < var_132_24 + var_132_31 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play319951033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 319951033
		arg_134_1.duration_ = 1.17

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play319951034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = "STblack"

			if arg_134_1.bgs_[var_137_0] == nil then
				local var_137_1 = Object.Instantiate(arg_134_1.paintGo_)

				var_137_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_137_0)
				var_137_1.name = var_137_0
				var_137_1.transform.parent = arg_134_1.stage_.transform
				var_137_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_134_1.bgs_[var_137_0] = var_137_1
			end

			local var_137_2 = 0

			if var_137_2 < arg_134_1.time_ and arg_134_1.time_ <= var_137_2 + arg_137_0 then
				local var_137_3 = manager.ui.mainCamera.transform.localPosition
				local var_137_4 = Vector3.New(0, 0, 10) + Vector3.New(var_137_3.x, var_137_3.y, 0)
				local var_137_5 = arg_134_1.bgs_.STblack

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
					if iter_137_0 ~= "STblack" then
						iter_137_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_137_16 = 0

			if var_137_16 < arg_134_1.time_ and arg_134_1.time_ <= var_137_16 + arg_137_0 then
				arg_134_1.fswbg_:SetActive(true)
				arg_134_1.dialog_:SetActive(false)

				arg_134_1.fswtw_.percent = 0

				local var_137_17 = arg_134_1:GetWordFromCfg(319951033)
				local var_137_18 = arg_134_1:FormatText(var_137_17.content)

				arg_134_1.fswt_.text = var_137_18

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.fswt_)

				arg_134_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_134_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_134_1.fswtw_:SetDirty()

				arg_134_1.typewritterCharCountI18N = 0

				SetActive(arg_134_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_134_1:ShowNextGo(false)
			end

			local var_137_19 = 0.0166666666666667

			if var_137_19 < arg_134_1.time_ and arg_134_1.time_ <= var_137_19 + arg_137_0 then
				arg_134_1.var_.oldValueTypewriter = arg_134_1.fswtw_.percent

				SetActive(arg_134_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_134_1:ShowNextGo(false)
			end

			local var_137_20 = 2
			local var_137_21 = 0.133333333333333
			local var_137_22 = arg_134_1:GetWordFromCfg(319951033)
			local var_137_23 = arg_134_1:FormatText(var_137_22.content)
			local var_137_24, var_137_25 = arg_134_1:GetPercentByPara(var_137_23, 1)

			if var_137_19 < arg_134_1.time_ and arg_134_1.time_ <= var_137_19 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0

				local var_137_26 = var_137_20 <= 0 and var_137_21 or var_137_21 * ((var_137_25 - arg_134_1.typewritterCharCountI18N) / var_137_20)

				if var_137_26 > 0 and var_137_21 < var_137_26 then
					arg_134_1.talkMaxDuration = var_137_26

					if var_137_26 + var_137_19 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_26 + var_137_19
					end
				end
			end

			local var_137_27 = 0.133333333333333
			local var_137_28 = math.max(var_137_27, arg_134_1.talkMaxDuration)

			if var_137_19 <= arg_134_1.time_ and arg_134_1.time_ < var_137_19 + var_137_28 then
				local var_137_29 = (arg_134_1.time_ - var_137_19) / var_137_28

				arg_134_1.fswtw_.percent = Mathf.Lerp(arg_134_1.var_.oldValueTypewriter, var_137_24, var_137_29)
				arg_134_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_134_1.fswtw_:SetDirty()
			end

			if arg_134_1.time_ >= var_137_19 + var_137_28 and arg_134_1.time_ < var_137_19 + var_137_28 + arg_137_0 then
				arg_134_1.fswtw_.percent = var_137_24

				arg_134_1.fswtw_:SetDirty()
				arg_134_1:ShowNextGo(true)

				arg_134_1.typewritterCharCountI18N = var_137_25
			end

			local var_137_30 = 0.1

			if var_137_30 < arg_134_1.time_ and arg_134_1.time_ <= var_137_30 + arg_137_0 then
				arg_134_1.var_.oldValueTypewriter = arg_134_1.fswtw_.percent

				SetActive(arg_134_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_134_1:ShowNextGo(false)
			end

			local var_137_31 = 0
			local var_137_32 = 0
			local var_137_33 = arg_134_1:GetWordFromCfg(319951033)
			local var_137_34 = arg_134_1:FormatText(var_137_33.content)
			local var_137_35, var_137_36 = arg_134_1:GetPercentByPara(var_137_34, 1)

			if var_137_30 < arg_134_1.time_ and arg_134_1.time_ <= var_137_30 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0

				local var_137_37 = var_137_31 <= 0 and var_137_32 or var_137_32 * ((var_137_36 - arg_134_1.typewritterCharCountI18N) / var_137_31)

				if var_137_37 > 0 and var_137_32 < var_137_37 then
					arg_134_1.talkMaxDuration = var_137_37

					if var_137_37 + var_137_30 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_37 + var_137_30
					end
				end
			end

			local var_137_38 = 0
			local var_137_39 = math.max(var_137_38, arg_134_1.talkMaxDuration)

			if var_137_30 <= arg_134_1.time_ and arg_134_1.time_ < var_137_30 + var_137_39 then
				local var_137_40 = (arg_134_1.time_ - var_137_30) / var_137_39

				arg_134_1.fswtw_.percent = Mathf.Lerp(arg_134_1.var_.oldValueTypewriter, var_137_35, var_137_40)
				arg_134_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_134_1.fswtw_:SetDirty()
			end

			if arg_134_1.time_ >= var_137_30 + var_137_39 and arg_134_1.time_ < var_137_30 + var_137_39 + arg_137_0 then
				arg_134_1.fswtw_.percent = var_137_35

				arg_134_1.fswtw_:SetDirty()
				arg_134_1:ShowNextGo(true)

				arg_134_1.typewritterCharCountI18N = var_137_36
			end

			local var_137_41 = 0

			if var_137_41 < arg_134_1.time_ and arg_134_1.time_ <= var_137_41 + arg_137_0 then
				arg_134_1.cswbg_:SetActive(true)

				local var_137_42 = arg_134_1.cswt_:GetComponent("RectTransform")

				arg_134_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_137_42.offsetMin = Vector2.New(410, 330)
				var_137_42.offsetMax = Vector2.New(-400, -180)

				local var_137_43 = arg_134_1:GetWordFromCfg(419082)
				local var_137_44 = arg_134_1:FormatText(var_137_43.content)

				arg_134_1.cswt_.text = var_137_44

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.cswt_)

				arg_134_1.cswt_.fontSize = 172
				arg_134_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_134_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_134_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_137_45 = 0

			if var_137_45 < arg_134_1.time_ and arg_134_1.time_ <= var_137_45 + arg_137_0 then
				local var_137_46 = arg_134_1.fswbg_.transform:Find("textbox/adapt/content") or arg_134_1.fswbg_.transform:Find("textbox/content")
				local var_137_47 = arg_134_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_137_48 = var_137_46:GetComponent("Text")
				local var_137_49 = var_137_46:GetComponent("RectTransform")

				var_137_48.alignment = UnityEngine.TextAnchor.LowerCenter
				var_137_49.offsetMin = Vector2.New(0, 0)
				var_137_49.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play319951034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 319951034
		arg_138_1.duration_ = 1

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play319951035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.cswbg_:SetActive(true)

				local var_141_1 = arg_138_1.cswt_:GetComponent("RectTransform")

				arg_138_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_141_1.offsetMin = Vector2.New(410, 330)
				var_141_1.offsetMax = Vector2.New(-400, -175)

				local var_141_2 = arg_138_1:GetWordFromCfg(419083)
				local var_141_3 = arg_138_1:FormatText(var_141_2.content)

				arg_138_1.cswt_.text = var_141_3

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.cswt_)

				arg_138_1.cswt_.fontSize = 180
				arg_138_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_138_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_138_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play319951035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 319951035
		arg_142_1.duration_ = 1

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play319951036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.cswbg_:SetActive(true)

				local var_145_1 = arg_142_1.cswt_:GetComponent("RectTransform")

				arg_142_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_145_1.offsetMin = Vector2.New(410, 330)
				var_145_1.offsetMax = Vector2.New(-400, -175)

				local var_145_2 = arg_142_1:GetWordFromCfg(419084)
				local var_145_3 = arg_142_1:FormatText(var_145_2.content)

				arg_142_1.cswt_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.cswt_)

				arg_142_1.cswt_.fontSize = 185
				arg_142_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_142_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_142_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play319951036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 319951036
		arg_146_1.duration_ = 1

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play319951037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.cswbg_:SetActive(true)

				local var_149_1 = arg_146_1.cswt_:GetComponent("RectTransform")

				arg_146_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_149_1.offsetMin = Vector2.New(410, 330)
				var_149_1.offsetMax = Vector2.New(-400, -175)

				local var_149_2 = arg_146_1:GetWordFromCfg(419085)
				local var_149_3 = arg_146_1:FormatText(var_149_2.content)

				arg_146_1.cswt_.text = var_149_3

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.cswt_)

				arg_146_1.cswt_.fontSize = 188
				arg_146_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_146_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_146_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play319951037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 319951037
		arg_150_1.duration_ = 6.4

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play319951038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				local var_153_1 = manager.ui.mainCamera.transform.localPosition
				local var_153_2 = Vector3.New(0, 0, 10) + Vector3.New(var_153_1.x, var_153_1.y, 0)
				local var_153_3 = arg_150_1.bgs_.I11i

				var_153_3.transform.localPosition = var_153_2
				var_153_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_153_4 = var_153_3:GetComponent("SpriteRenderer")

				if var_153_4 and var_153_4.sprite then
					local var_153_5 = (var_153_3.transform.localPosition - var_153_1).z
					local var_153_6 = manager.ui.mainCameraCom_
					local var_153_7 = 2 * var_153_5 * Mathf.Tan(var_153_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_153_8 = var_153_7 * var_153_6.aspect
					local var_153_9 = var_153_4.sprite.bounds.size.x
					local var_153_10 = var_153_4.sprite.bounds.size.y
					local var_153_11 = var_153_8 / var_153_9
					local var_153_12 = var_153_7 / var_153_10
					local var_153_13 = var_153_12 < var_153_11 and var_153_11 or var_153_12

					var_153_3.transform.localScale = Vector3.New(var_153_13, var_153_13, 0)
				end

				for iter_153_0, iter_153_1 in pairs(arg_150_1.bgs_) do
					if iter_153_0 ~= "I11i" then
						iter_153_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_153_14 = 0

			if var_153_14 < arg_150_1.time_ and arg_150_1.time_ <= var_153_14 + arg_153_0 then
				arg_150_1.mask_.enabled = true
				arg_150_1.mask_.raycastTarget = true

				arg_150_1:SetGaussion(false)
			end

			local var_153_15 = 2

			if var_153_14 <= arg_150_1.time_ and arg_150_1.time_ < var_153_14 + var_153_15 then
				local var_153_16 = (arg_150_1.time_ - var_153_14) / var_153_15
				local var_153_17 = Color.New(0, 0, 0)

				var_153_17.a = Mathf.Lerp(1, 0, var_153_16)
				arg_150_1.mask_.color = var_153_17
			end

			if arg_150_1.time_ >= var_153_14 + var_153_15 and arg_150_1.time_ < var_153_14 + var_153_15 + arg_153_0 then
				local var_153_18 = Color.New(0, 0, 0)
				local var_153_19 = 0

				arg_150_1.mask_.enabled = false
				var_153_18.a = var_153_19
				arg_150_1.mask_.color = var_153_18
			end

			local var_153_20 = 0

			if var_153_20 < arg_150_1.time_ and arg_150_1.time_ <= var_153_20 + arg_153_0 then
				arg_150_1.fswbg_:SetActive(false)
				arg_150_1.dialog_:SetActive(false)
				SetActive(arg_150_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_150_1:ShowNextGo(false)
			end

			local var_153_21 = 0

			if var_153_21 < arg_150_1.time_ and arg_150_1.time_ <= var_153_21 + arg_153_0 then
				arg_150_1.cswbg_:SetActive(false)
			end

			if arg_150_1.frameCnt_ <= 1 then
				arg_150_1.dialog_:SetActive(false)
			end

			local var_153_22 = 1.4
			local var_153_23 = 0.95

			if var_153_22 < arg_150_1.time_ and arg_150_1.time_ <= var_153_22 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0

				arg_150_1.dialog_:SetActive(true)

				arg_150_1.dialogCg_.alpha = 0

				local var_153_24 = LeanTween.value(arg_150_1.dialog_, 0, 1, 0.3)

				var_153_24:setOnUpdate(LuaHelper.FloatAction(function(arg_154_0)
					arg_150_1.dialogCg_.alpha = arg_154_0
				end))
				var_153_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_150_1.dialog_)
					var_153_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_150_1.duration_ = arg_150_1.duration_ + 0.3

				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_25 = arg_150_1:GetWordFromCfg(319951037)
				local var_153_26 = arg_150_1:FormatText(var_153_25.content)

				arg_150_1.text_.text = var_153_26

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_27 = 38
				local var_153_28 = utf8.len(var_153_26)
				local var_153_29 = var_153_27 <= 0 and var_153_23 or var_153_23 * (var_153_28 / var_153_27)

				if var_153_29 > 0 and var_153_23 < var_153_29 then
					arg_150_1.talkMaxDuration = var_153_29
					var_153_22 = var_153_22 + 0.3

					if var_153_29 + var_153_22 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_29 + var_153_22
					end
				end

				arg_150_1.text_.text = var_153_26
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_30 = var_153_22 + 0.3
			local var_153_31 = math.max(var_153_23, arg_150_1.talkMaxDuration)

			if var_153_30 <= arg_150_1.time_ and arg_150_1.time_ < var_153_30 + var_153_31 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_30) / var_153_31

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_30 + var_153_31 and arg_150_1.time_ < var_153_30 + var_153_31 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play319951038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 319951038
		arg_156_1.duration_ = 10.87

		local var_156_0 = {
			zh = 7.666,
			ja = 10.866
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
				arg_156_0:Play319951039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 0.7

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_2 = arg_156_1:FormatText(StoryNameCfg[696].name)

				arg_156_1.leftNameTxt_.text = var_159_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_3 = arg_156_1:GetWordFromCfg(319951038)
				local var_159_4 = arg_156_1:FormatText(var_159_3.content)

				arg_156_1.text_.text = var_159_4

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 28
				local var_159_6 = utf8.len(var_159_4)
				local var_159_7 = var_159_5 <= 0 and var_159_1 or var_159_1 * (var_159_6 / var_159_5)

				if var_159_7 > 0 and var_159_1 < var_159_7 then
					arg_156_1.talkMaxDuration = var_159_7

					if var_159_7 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_4
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951038", "story_v_out_319951.awb") ~= 0 then
					local var_159_8 = manager.audio:GetVoiceLength("story_v_out_319951", "319951038", "story_v_out_319951.awb") / 1000

					if var_159_8 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_8 + var_159_0
					end

					if var_159_3.prefab_name ~= "" and arg_156_1.actors_[var_159_3.prefab_name] ~= nil then
						local var_159_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_3.prefab_name].transform, "story_v_out_319951", "319951038", "story_v_out_319951.awb")

						arg_156_1:RecordAudio("319951038", var_159_9)
						arg_156_1:RecordAudio("319951038", var_159_9)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_319951", "319951038", "story_v_out_319951.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_319951", "319951038", "story_v_out_319951.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_10 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_10 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_10

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_10 and arg_156_1.time_ < var_159_0 + var_159_10 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play319951039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 319951039
		arg_160_1.duration_ = 3.67

		local var_160_0 = {
			zh = 1.999999999999,
			ja = 3.666
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
				arg_160_0:Play319951040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1095ui_story"].transform
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.var_.moveOldPos1095ui_story = var_163_0.localPosition
			end

			local var_163_2 = 0.001

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2
				local var_163_4 = Vector3.New(0, -0.98, -6.1)

				var_163_0.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1095ui_story, var_163_4, var_163_3)

				local var_163_5 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_5.x, var_163_5.y, var_163_5.z)

				local var_163_6 = var_163_0.localEulerAngles

				var_163_6.z = 0
				var_163_6.x = 0
				var_163_0.localEulerAngles = var_163_6
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 then
				var_163_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_163_7 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_7.x, var_163_7.y, var_163_7.z)

				local var_163_8 = var_163_0.localEulerAngles

				var_163_8.z = 0
				var_163_8.x = 0
				var_163_0.localEulerAngles = var_163_8
			end

			local var_163_9 = arg_160_1.actors_["1095ui_story"]
			local var_163_10 = 0

			if var_163_10 < arg_160_1.time_ and arg_160_1.time_ <= var_163_10 + arg_163_0 and not isNil(var_163_9) and arg_160_1.var_.characterEffect1095ui_story == nil then
				arg_160_1.var_.characterEffect1095ui_story = var_163_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_11 = 0.200000002980232

			if var_163_10 <= arg_160_1.time_ and arg_160_1.time_ < var_163_10 + var_163_11 and not isNil(var_163_9) then
				local var_163_12 = (arg_160_1.time_ - var_163_10) / var_163_11

				if arg_160_1.var_.characterEffect1095ui_story and not isNil(var_163_9) then
					arg_160_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_10 + var_163_11 and arg_160_1.time_ < var_163_10 + var_163_11 + arg_163_0 and not isNil(var_163_9) and arg_160_1.var_.characterEffect1095ui_story then
				arg_160_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_163_13 = 0

			if var_163_13 < arg_160_1.time_ and arg_160_1.time_ <= var_163_13 + arg_163_0 then
				arg_160_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_163_14 = 0

			if var_163_14 < arg_160_1.time_ and arg_160_1.time_ <= var_163_14 + arg_163_0 then
				arg_160_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_163_15 = 0
			local var_163_16 = 0.25

			if var_163_15 < arg_160_1.time_ and arg_160_1.time_ <= var_163_15 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_17 = arg_160_1:FormatText(StoryNameCfg[471].name)

				arg_160_1.leftNameTxt_.text = var_163_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_18 = arg_160_1:GetWordFromCfg(319951039)
				local var_163_19 = arg_160_1:FormatText(var_163_18.content)

				arg_160_1.text_.text = var_163_19

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_20 = 10
				local var_163_21 = utf8.len(var_163_19)
				local var_163_22 = var_163_20 <= 0 and var_163_16 or var_163_16 * (var_163_21 / var_163_20)

				if var_163_22 > 0 and var_163_16 < var_163_22 then
					arg_160_1.talkMaxDuration = var_163_22

					if var_163_22 + var_163_15 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_22 + var_163_15
					end
				end

				arg_160_1.text_.text = var_163_19
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951039", "story_v_out_319951.awb") ~= 0 then
					local var_163_23 = manager.audio:GetVoiceLength("story_v_out_319951", "319951039", "story_v_out_319951.awb") / 1000

					if var_163_23 + var_163_15 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_23 + var_163_15
					end

					if var_163_18.prefab_name ~= "" and arg_160_1.actors_[var_163_18.prefab_name] ~= nil then
						local var_163_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_18.prefab_name].transform, "story_v_out_319951", "319951039", "story_v_out_319951.awb")

						arg_160_1:RecordAudio("319951039", var_163_24)
						arg_160_1:RecordAudio("319951039", var_163_24)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_319951", "319951039", "story_v_out_319951.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_319951", "319951039", "story_v_out_319951.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_25 = math.max(var_163_16, arg_160_1.talkMaxDuration)

			if var_163_15 <= arg_160_1.time_ and arg_160_1.time_ < var_163_15 + var_163_25 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_15) / var_163_25

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_15 + var_163_25 and arg_160_1.time_ < var_163_15 + var_163_25 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319951040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 319951040
		arg_164_1.duration_ = 5.6

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play319951041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1095ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1095ui_story == nil then
				arg_164_1.var_.characterEffect1095ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect1095ui_story and not isNil(var_167_0) then
					local var_167_4 = Mathf.Lerp(0, 0.5, var_167_3)

					arg_164_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1095ui_story.fillRatio = var_167_4
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1095ui_story then
				local var_167_5 = 0.5

				arg_164_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1095ui_story.fillRatio = var_167_5
			end

			local var_167_6 = 0
			local var_167_7 = 1

			if var_167_6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				local var_167_8 = "play"
				local var_167_9 = "effect"

				arg_164_1:AudioAction(var_167_8, var_167_9, "se_story_130", "se_story_130_shot2", "")
			end

			local var_167_10 = arg_164_1.actors_["1095ui_story"].transform
			local var_167_11 = 0

			if var_167_11 < arg_164_1.time_ and arg_164_1.time_ <= var_167_11 + arg_167_0 then
				arg_164_1.var_.moveOldPos1095ui_story = var_167_10.localPosition
			end

			local var_167_12 = 0.001

			if var_167_11 <= arg_164_1.time_ and arg_164_1.time_ < var_167_11 + var_167_12 then
				local var_167_13 = (arg_164_1.time_ - var_167_11) / var_167_12
				local var_167_14 = Vector3.New(0, 100, 0)

				var_167_10.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1095ui_story, var_167_14, var_167_13)

				local var_167_15 = manager.ui.mainCamera.transform.position - var_167_10.position

				var_167_10.forward = Vector3.New(var_167_15.x, var_167_15.y, var_167_15.z)

				local var_167_16 = var_167_10.localEulerAngles

				var_167_16.z = 0
				var_167_16.x = 0
				var_167_10.localEulerAngles = var_167_16
			end

			if arg_164_1.time_ >= var_167_11 + var_167_12 and arg_164_1.time_ < var_167_11 + var_167_12 + arg_167_0 then
				var_167_10.localPosition = Vector3.New(0, 100, 0)

				local var_167_17 = manager.ui.mainCamera.transform.position - var_167_10.position

				var_167_10.forward = Vector3.New(var_167_17.x, var_167_17.y, var_167_17.z)

				local var_167_18 = var_167_10.localEulerAngles

				var_167_18.z = 0
				var_167_18.x = 0
				var_167_10.localEulerAngles = var_167_18
			end

			local var_167_19 = 0

			if var_167_19 < arg_164_1.time_ and arg_164_1.time_ <= var_167_19 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_20 = 0.5

			if var_167_19 <= arg_164_1.time_ and arg_164_1.time_ < var_167_19 + var_167_20 then
				local var_167_21 = (arg_164_1.time_ - var_167_19) / var_167_20
				local var_167_22 = Color.New(1, 1, 1)

				var_167_22.a = Mathf.Lerp(1, 0, var_167_21)
				arg_164_1.mask_.color = var_167_22
			end

			if arg_164_1.time_ >= var_167_19 + var_167_20 and arg_164_1.time_ < var_167_19 + var_167_20 + arg_167_0 then
				local var_167_23 = Color.New(1, 1, 1)
				local var_167_24 = 0

				arg_164_1.mask_.enabled = false
				var_167_23.a = var_167_24
				arg_164_1.mask_.color = var_167_23
			end

			local var_167_25 = manager.ui.mainCamera.transform
			local var_167_26 = 0

			if var_167_26 < arg_164_1.time_ and arg_164_1.time_ <= var_167_26 + arg_167_0 then
				local var_167_27 = arg_164_1.var_.effectqiege1
				local var_167_28
				local var_167_29 = var_167_25

				if not var_167_27 then
					var_167_27 = Object.Instantiate(Asset.Load("Effect/Scene/fx_scence_pingmu_niuqu"), var_167_29)
					var_167_27.name = "qiege1"
					arg_164_1.var_.effectqiege1 = var_167_27
				else
					var_167_27.transform:SetParent(var_167_29)
				end

				var_167_27.transform.localPosition = Vector3.New(0, 0, 0)
				var_167_27.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_167_30 = manager.ui.mainCamera.transform
			local var_167_31 = 0.5

			if var_167_31 < arg_164_1.time_ and arg_164_1.time_ <= var_167_31 + arg_167_0 then
				local var_167_32 = arg_164_1.var_.effectqiege1

				if var_167_32 then
					Object.Destroy(var_167_32)

					arg_164_1.var_.effectqiege1 = nil
				end
			end

			if arg_164_1.frameCnt_ <= 1 then
				arg_164_1.dialog_:SetActive(false)
			end

			local var_167_33 = 0.6
			local var_167_34 = 1.5

			if var_167_33 < arg_164_1.time_ and arg_164_1.time_ <= var_167_33 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				arg_164_1.dialog_:SetActive(true)

				arg_164_1.dialogCg_.alpha = 0

				local var_167_35 = LeanTween.value(arg_164_1.dialog_, 0, 1, 0.3)

				var_167_35:setOnUpdate(LuaHelper.FloatAction(function(arg_168_0)
					arg_164_1.dialogCg_.alpha = arg_168_0
				end))
				var_167_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_164_1.dialog_)
					var_167_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_164_1.duration_ = arg_164_1.duration_ + 0.3

				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_36 = arg_164_1:GetWordFromCfg(319951040)
				local var_167_37 = arg_164_1:FormatText(var_167_36.content)

				arg_164_1.text_.text = var_167_37

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_38 = 60
				local var_167_39 = utf8.len(var_167_37)
				local var_167_40 = var_167_38 <= 0 and var_167_34 or var_167_34 * (var_167_39 / var_167_38)

				if var_167_40 > 0 and var_167_34 < var_167_40 then
					arg_164_1.talkMaxDuration = var_167_40
					var_167_33 = var_167_33 + 0.3

					if var_167_40 + var_167_33 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_40 + var_167_33
					end
				end

				arg_164_1.text_.text = var_167_37
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_41 = var_167_33 + 0.3
			local var_167_42 = math.max(var_167_34, arg_164_1.talkMaxDuration)

			if var_167_41 <= arg_164_1.time_ and arg_164_1.time_ < var_167_41 + var_167_42 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_41) / var_167_42

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_41 + var_167_42 and arg_164_1.time_ < var_167_41 + var_167_42 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play319951041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 319951041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play319951042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 0.825

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_2 = arg_170_1:GetWordFromCfg(319951041)
				local var_173_3 = arg_170_1:FormatText(var_173_2.content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_4 = 33
				local var_173_5 = utf8.len(var_173_3)
				local var_173_6 = var_173_4 <= 0 and var_173_1 or var_173_1 * (var_173_5 / var_173_4)

				if var_173_6 > 0 and var_173_1 < var_173_6 then
					arg_170_1.talkMaxDuration = var_173_6

					if var_173_6 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_6 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_3
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_7 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_7 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_7

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_7 and arg_170_1.time_ < var_173_0 + var_173_7 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play319951042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 319951042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play319951043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0
			local var_177_1 = 1.6

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_2 = arg_174_1:GetWordFromCfg(319951042)
				local var_177_3 = arg_174_1:FormatText(var_177_2.content)

				arg_174_1.text_.text = var_177_3

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_4 = 64
				local var_177_5 = utf8.len(var_177_3)
				local var_177_6 = var_177_4 <= 0 and var_177_1 or var_177_1 * (var_177_5 / var_177_4)

				if var_177_6 > 0 and var_177_1 < var_177_6 then
					arg_174_1.talkMaxDuration = var_177_6

					if var_177_6 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_6 + var_177_0
					end
				end

				arg_174_1.text_.text = var_177_3
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_7 = math.max(var_177_1, arg_174_1.talkMaxDuration)

			if var_177_0 <= arg_174_1.time_ and arg_174_1.time_ < var_177_0 + var_177_7 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_0) / var_177_7

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_0 + var_177_7 and arg_174_1.time_ < var_177_0 + var_177_7 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play319951043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 319951043
		arg_178_1.duration_ = 2.23

		local var_178_0 = {
			zh = 1.366,
			ja = 2.233
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
				arg_178_0:Play319951044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1095ui_story"].transform
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.var_.moveOldPos1095ui_story = var_181_0.localPosition
			end

			local var_181_2 = 0.001

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2
				local var_181_4 = Vector3.New(0, -0.98, -6.1)

				var_181_0.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1095ui_story, var_181_4, var_181_3)

				local var_181_5 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_5.x, var_181_5.y, var_181_5.z)

				local var_181_6 = var_181_0.localEulerAngles

				var_181_6.z = 0
				var_181_6.x = 0
				var_181_0.localEulerAngles = var_181_6
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 then
				var_181_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_181_7 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_7.x, var_181_7.y, var_181_7.z)

				local var_181_8 = var_181_0.localEulerAngles

				var_181_8.z = 0
				var_181_8.x = 0
				var_181_0.localEulerAngles = var_181_8
			end

			local var_181_9 = arg_178_1.actors_["1095ui_story"]
			local var_181_10 = 0

			if var_181_10 < arg_178_1.time_ and arg_178_1.time_ <= var_181_10 + arg_181_0 and not isNil(var_181_9) and arg_178_1.var_.characterEffect1095ui_story == nil then
				arg_178_1.var_.characterEffect1095ui_story = var_181_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_11 = 0.200000002980232

			if var_181_10 <= arg_178_1.time_ and arg_178_1.time_ < var_181_10 + var_181_11 and not isNil(var_181_9) then
				local var_181_12 = (arg_178_1.time_ - var_181_10) / var_181_11

				if arg_178_1.var_.characterEffect1095ui_story and not isNil(var_181_9) then
					arg_178_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_10 + var_181_11 and arg_178_1.time_ < var_181_10 + var_181_11 + arg_181_0 and not isNil(var_181_9) and arg_178_1.var_.characterEffect1095ui_story then
				arg_178_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_181_13 = 0

			if var_181_13 < arg_178_1.time_ and arg_178_1.time_ <= var_181_13 + arg_181_0 then
				arg_178_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_181_14 = 0

			if var_181_14 < arg_178_1.time_ and arg_178_1.time_ <= var_181_14 + arg_181_0 then
				arg_178_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_181_15 = 0
			local var_181_16 = 0.15

			if var_181_15 < arg_178_1.time_ and arg_178_1.time_ <= var_181_15 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_17 = arg_178_1:FormatText(StoryNameCfg[471].name)

				arg_178_1.leftNameTxt_.text = var_181_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_18 = arg_178_1:GetWordFromCfg(319951043)
				local var_181_19 = arg_178_1:FormatText(var_181_18.content)

				arg_178_1.text_.text = var_181_19

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_20 = 6
				local var_181_21 = utf8.len(var_181_19)
				local var_181_22 = var_181_20 <= 0 and var_181_16 or var_181_16 * (var_181_21 / var_181_20)

				if var_181_22 > 0 and var_181_16 < var_181_22 then
					arg_178_1.talkMaxDuration = var_181_22

					if var_181_22 + var_181_15 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_22 + var_181_15
					end
				end

				arg_178_1.text_.text = var_181_19
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951043", "story_v_out_319951.awb") ~= 0 then
					local var_181_23 = manager.audio:GetVoiceLength("story_v_out_319951", "319951043", "story_v_out_319951.awb") / 1000

					if var_181_23 + var_181_15 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_23 + var_181_15
					end

					if var_181_18.prefab_name ~= "" and arg_178_1.actors_[var_181_18.prefab_name] ~= nil then
						local var_181_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_18.prefab_name].transform, "story_v_out_319951", "319951043", "story_v_out_319951.awb")

						arg_178_1:RecordAudio("319951043", var_181_24)
						arg_178_1:RecordAudio("319951043", var_181_24)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_319951", "319951043", "story_v_out_319951.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_319951", "319951043", "story_v_out_319951.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_25 = math.max(var_181_16, arg_178_1.talkMaxDuration)

			if var_181_15 <= arg_178_1.time_ and arg_178_1.time_ < var_181_15 + var_181_25 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_15) / var_181_25

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_15 + var_181_25 and arg_178_1.time_ < var_181_15 + var_181_25 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319951044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 319951044
		arg_182_1.duration_ = 2.4

		local var_182_0 = {
			zh = 1.999999999999,
			ja = 2.4
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
			arg_182_1.auto_ = false
		end

		function arg_182_1.playNext_(arg_184_0)
			arg_182_1.onStoryFinished_()
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["10079ui_story"].transform
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.var_.moveOldPos10079ui_story = var_185_0.localPosition
			end

			local var_185_2 = 0.001

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2
				local var_185_4 = Vector3.New(0, -0.95, -6.05)

				var_185_0.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10079ui_story, var_185_4, var_185_3)

				local var_185_5 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_5.x, var_185_5.y, var_185_5.z)

				local var_185_6 = var_185_0.localEulerAngles

				var_185_6.z = 0
				var_185_6.x = 0
				var_185_0.localEulerAngles = var_185_6
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 then
				var_185_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_185_7 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_7.x, var_185_7.y, var_185_7.z)

				local var_185_8 = var_185_0.localEulerAngles

				var_185_8.z = 0
				var_185_8.x = 0
				var_185_0.localEulerAngles = var_185_8
			end

			local var_185_9 = arg_182_1.actors_["10079ui_story"]
			local var_185_10 = 0

			if var_185_10 < arg_182_1.time_ and arg_182_1.time_ <= var_185_10 + arg_185_0 and not isNil(var_185_9) and arg_182_1.var_.characterEffect10079ui_story == nil then
				arg_182_1.var_.characterEffect10079ui_story = var_185_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_11 = 0.200000002980232

			if var_185_10 <= arg_182_1.time_ and arg_182_1.time_ < var_185_10 + var_185_11 and not isNil(var_185_9) then
				local var_185_12 = (arg_182_1.time_ - var_185_10) / var_185_11

				if arg_182_1.var_.characterEffect10079ui_story and not isNil(var_185_9) then
					arg_182_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= var_185_10 + var_185_11 and arg_182_1.time_ < var_185_10 + var_185_11 + arg_185_0 and not isNil(var_185_9) and arg_182_1.var_.characterEffect10079ui_story then
				arg_182_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_185_13 = 0

			if var_185_13 < arg_182_1.time_ and arg_182_1.time_ <= var_185_13 + arg_185_0 then
				arg_182_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_185_14 = 0

			if var_185_14 < arg_182_1.time_ and arg_182_1.time_ <= var_185_14 + arg_185_0 then
				arg_182_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_185_15 = arg_182_1.actors_["1095ui_story"].transform
			local var_185_16 = 0

			if var_185_16 < arg_182_1.time_ and arg_182_1.time_ <= var_185_16 + arg_185_0 then
				arg_182_1.var_.moveOldPos1095ui_story = var_185_15.localPosition
			end

			local var_185_17 = 0.001

			if var_185_16 <= arg_182_1.time_ and arg_182_1.time_ < var_185_16 + var_185_17 then
				local var_185_18 = (arg_182_1.time_ - var_185_16) / var_185_17
				local var_185_19 = Vector3.New(0, 100, 0)

				var_185_15.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1095ui_story, var_185_19, var_185_18)

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

			local var_185_24 = arg_182_1.actors_["1095ui_story"]
			local var_185_25 = 0

			if var_185_25 < arg_182_1.time_ and arg_182_1.time_ <= var_185_25 + arg_185_0 and not isNil(var_185_24) and arg_182_1.var_.characterEffect1095ui_story == nil then
				arg_182_1.var_.characterEffect1095ui_story = var_185_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_26 = 0.200000002980232

			if var_185_25 <= arg_182_1.time_ and arg_182_1.time_ < var_185_25 + var_185_26 and not isNil(var_185_24) then
				local var_185_27 = (arg_182_1.time_ - var_185_25) / var_185_26

				if arg_182_1.var_.characterEffect1095ui_story and not isNil(var_185_24) then
					local var_185_28 = Mathf.Lerp(0, 0.5, var_185_27)

					arg_182_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1095ui_story.fillRatio = var_185_28
				end
			end

			if arg_182_1.time_ >= var_185_25 + var_185_26 and arg_182_1.time_ < var_185_25 + var_185_26 + arg_185_0 and not isNil(var_185_24) and arg_182_1.var_.characterEffect1095ui_story then
				local var_185_29 = 0.5

				arg_182_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1095ui_story.fillRatio = var_185_29
			end

			local var_185_30 = 0
			local var_185_31 = 0.175

			if var_185_30 < arg_182_1.time_ and arg_182_1.time_ <= var_185_30 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_32 = arg_182_1:FormatText(StoryNameCfg[6].name)

				arg_182_1.leftNameTxt_.text = var_185_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_33 = arg_182_1:GetWordFromCfg(319951044)
				local var_185_34 = arg_182_1:FormatText(var_185_33.content)

				arg_182_1.text_.text = var_185_34

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_35 = 7
				local var_185_36 = utf8.len(var_185_34)
				local var_185_37 = var_185_35 <= 0 and var_185_31 or var_185_31 * (var_185_36 / var_185_35)

				if var_185_37 > 0 and var_185_31 < var_185_37 then
					arg_182_1.talkMaxDuration = var_185_37

					if var_185_37 + var_185_30 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_37 + var_185_30
					end
				end

				arg_182_1.text_.text = var_185_34
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951044", "story_v_out_319951.awb") ~= 0 then
					local var_185_38 = manager.audio:GetVoiceLength("story_v_out_319951", "319951044", "story_v_out_319951.awb") / 1000

					if var_185_38 + var_185_30 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_38 + var_185_30
					end

					if var_185_33.prefab_name ~= "" and arg_182_1.actors_[var_185_33.prefab_name] ~= nil then
						local var_185_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_33.prefab_name].transform, "story_v_out_319951", "319951044", "story_v_out_319951.awb")

						arg_182_1:RecordAudio("319951044", var_185_39)
						arg_182_1:RecordAudio("319951044", var_185_39)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_319951", "319951044", "story_v_out_319951.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_319951", "319951044", "story_v_out_319951.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_40 = math.max(var_185_31, arg_182_1.talkMaxDuration)

			if var_185_30 <= arg_182_1.time_ and arg_182_1.time_ < var_185_30 + var_185_40 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_30) / var_185_40

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_30 + var_185_40 and arg_182_1.time_ < var_185_30 + var_185_40 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	assets = {
		"TextureConfig/Background/I11i",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319951.awb"
	}
}
