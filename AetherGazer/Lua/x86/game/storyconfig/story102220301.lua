return {
	Play222031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 222031001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play222031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST31a"

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
				local var_4_5 = arg_1_1.bgs_.ST31a

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
					if iter_4_0 ~= "ST31a" then
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
			local var_4_23 = 0.4

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

			local var_4_28 = 0.566666666666667
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city")

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
			local var_4_35 = 0.85

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

				local var_4_37 = arg_1_1:GetWordFromCfg(222031001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 34
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
	Play222031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 222031002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play222031003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.375

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

				local var_12_2 = arg_9_1:GetWordFromCfg(222031002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 55
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
	Play222031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 222031003
		arg_13_1.duration_ = 13.8

		local var_13_0 = {
			ja = 13.8,
			ko = 11.866,
			zh = 11.833
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
				arg_13_0:Play222031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1074ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1074ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["1074ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1074ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0, -1.055, -6.12)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1074ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["1074ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1074ui_story == nil then
				arg_13_1.var_.characterEffect1074ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect1074ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1074ui_story then
				arg_13_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_16_20 = 0
			local var_16_21 = 1.25

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[410].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(222031003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031003", "story_v_out_222031.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_out_222031", "222031003", "story_v_out_222031.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_out_222031", "222031003", "story_v_out_222031.awb")

						arg_13_1:RecordAudio("222031003", var_16_29)
						arg_13_1:RecordAudio("222031003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_222031", "222031003", "story_v_out_222031.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_222031", "222031003", "story_v_out_222031.awb")
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
				actorName = "1074ui_story",
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
	Play222031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 222031004
		arg_17_1.duration_ = 17.3

		local var_17_0 = {
			ja = 17.3,
			ko = 10.733,
			zh = 10.7
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
				arg_17_0:Play222031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.15

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[410].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:GetWordFromCfg(222031004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031004", "story_v_out_222031.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031004", "story_v_out_222031.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_222031", "222031004", "story_v_out_222031.awb")

						arg_17_1:RecordAudio("222031004", var_20_9)
						arg_17_1:RecordAudio("222031004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_222031", "222031004", "story_v_out_222031.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_222031", "222031004", "story_v_out_222031.awb")
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
	Play222031005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 222031005
		arg_21_1.duration_ = 4.03

		local var_21_0 = {
			ja = 4.033,
			ko = 2.3,
			zh = 2.2
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
				arg_21_0:Play222031006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_24_1 = 0
			local var_24_2 = 0.225

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_3 = arg_21_1:FormatText(StoryNameCfg[410].name)

				arg_21_1.leftNameTxt_.text = var_24_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(222031005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 9
				local var_24_7 = utf8.len(var_24_5)
				local var_24_8 = var_24_6 <= 0 and var_24_2 or var_24_2 * (var_24_7 / var_24_6)

				if var_24_8 > 0 and var_24_2 < var_24_8 then
					arg_21_1.talkMaxDuration = var_24_8

					if var_24_8 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031005", "story_v_out_222031.awb") ~= 0 then
					local var_24_9 = manager.audio:GetVoiceLength("story_v_out_222031", "222031005", "story_v_out_222031.awb") / 1000

					if var_24_9 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_1
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_222031", "222031005", "story_v_out_222031.awb")

						arg_21_1:RecordAudio("222031005", var_24_10)
						arg_21_1:RecordAudio("222031005", var_24_10)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_222031", "222031005", "story_v_out_222031.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_222031", "222031005", "story_v_out_222031.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_11 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_11 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_11

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_11 and arg_21_1.time_ < var_24_1 + var_24_11 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play222031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 222031006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play222031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1074ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1074ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1074ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, 100, 0)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["1074ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1074ui_story == nil then
				arg_25_1.var_.characterEffect1074ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect1074ui_story and not isNil(var_28_9) then
					local var_28_13 = Mathf.Lerp(0, 0.5, var_28_12)

					arg_25_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1074ui_story.fillRatio = var_28_13
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1074ui_story then
				local var_28_14 = 0.5

				arg_25_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1074ui_story.fillRatio = var_28_14
			end

			local var_28_15 = 0
			local var_28_16 = 0.625

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_17 = arg_25_1:GetWordFromCfg(222031006)
				local var_28_18 = arg_25_1:FormatText(var_28_17.content)

				arg_25_1.text_.text = var_28_18

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_19 = 25
				local var_28_20 = utf8.len(var_28_18)
				local var_28_21 = var_28_19 <= 0 and var_28_16 or var_28_16 * (var_28_20 / var_28_19)

				if var_28_21 > 0 and var_28_16 < var_28_21 then
					arg_25_1.talkMaxDuration = var_28_21

					if var_28_21 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_21 + var_28_15
					end
				end

				arg_25_1.text_.text = var_28_18
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_22 = math.max(var_28_16, arg_25_1.talkMaxDuration)

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_22 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_15) / var_28_22

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_15 + var_28_22 and arg_25_1.time_ < var_28_15 + var_28_22 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 222031007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play222031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1.3

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(222031007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 52
				local var_32_5 = utf8.len(var_32_3)
				local var_32_6 = var_32_4 <= 0 and var_32_1 or var_32_1 * (var_32_5 / var_32_4)

				if var_32_6 > 0 and var_32_1 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_7 and arg_29_1.time_ < var_32_0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play222031008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 222031008
		arg_33_1.duration_ = 5.2

		local var_33_0 = {
			ja = 5.2,
			ko = 4.333,
			zh = 4.433
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
				arg_33_0:Play222031009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1074ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1074ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0, -1.055, -6.12)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1074ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["1074ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1074ui_story == nil then
				arg_33_1.var_.characterEffect1074ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect1074ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1074ui_story then
				arg_33_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_15 = 0
			local var_36_16 = 0.375

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_17 = arg_33_1:FormatText(StoryNameCfg[410].name)

				arg_33_1.leftNameTxt_.text = var_36_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(222031008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 15
				local var_36_21 = utf8.len(var_36_19)
				local var_36_22 = var_36_20 <= 0 and var_36_16 or var_36_16 * (var_36_21 / var_36_20)

				if var_36_22 > 0 and var_36_16 < var_36_22 then
					arg_33_1.talkMaxDuration = var_36_22

					if var_36_22 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_22 + var_36_15
					end
				end

				arg_33_1.text_.text = var_36_19
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031008", "story_v_out_222031.awb") ~= 0 then
					local var_36_23 = manager.audio:GetVoiceLength("story_v_out_222031", "222031008", "story_v_out_222031.awb") / 1000

					if var_36_23 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_15
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_out_222031", "222031008", "story_v_out_222031.awb")

						arg_33_1:RecordAudio("222031008", var_36_24)
						arg_33_1:RecordAudio("222031008", var_36_24)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_222031", "222031008", "story_v_out_222031.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_222031", "222031008", "story_v_out_222031.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_25 = math.max(var_36_16, arg_33_1.talkMaxDuration)

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_25 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_15) / var_36_25

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_15 + var_36_25 and arg_33_1.time_ < var_36_15 + var_36_25 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222031009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 222031009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play222031010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1074ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1074ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, 100, 0)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1074ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, 100, 0)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["1074ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1074ui_story == nil then
				arg_37_1.var_.characterEffect1074ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect1074ui_story and not isNil(var_40_9) then
					local var_40_13 = Mathf.Lerp(0, 0.5, var_40_12)

					arg_37_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1074ui_story.fillRatio = var_40_13
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1074ui_story then
				local var_40_14 = 0.5

				arg_37_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1074ui_story.fillRatio = var_40_14
			end

			local var_40_15 = 0
			local var_40_16 = 1.225

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

				local var_40_17 = arg_37_1:GetWordFromCfg(222031009)
				local var_40_18 = arg_37_1:FormatText(var_40_17.content)

				arg_37_1.text_.text = var_40_18

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_19 = 49
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
				actorName = "1074ui_story",
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
	Play222031010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 222031010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play222031011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.65

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

				local var_44_2 = arg_41_1:GetWordFromCfg(222031010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 66
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
	Play222031011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 222031011
		arg_45_1.duration_ = 5.6

		local var_45_0 = {
			ja = 5,
			ko = 5.6,
			zh = 5.6
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
				arg_45_0:Play222031012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.375

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[462].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(222031011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 15
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031011", "story_v_out_222031.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031011", "story_v_out_222031.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_222031", "222031011", "story_v_out_222031.awb")

						arg_45_1:RecordAudio("222031011", var_48_9)
						arg_45_1:RecordAudio("222031011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_222031", "222031011", "story_v_out_222031.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_222031", "222031011", "story_v_out_222031.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play222031012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 222031012
		arg_49_1.duration_ = 7.83

		local var_49_0 = {
			ja = 7.833,
			ko = 5.366,
			zh = 5.3
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
				arg_49_0:Play222031013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1074ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1074ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(0, -1.055, -6.12)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1074ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["1074ui_story"]
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1074ui_story == nil then
				arg_49_1.var_.characterEffect1074ui_story = var_52_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 and not isNil(var_52_9) then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11

				if arg_49_1.var_.characterEffect1074ui_story and not isNil(var_52_9) then
					arg_49_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1074ui_story then
				arg_49_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_52_13 = 0

			if var_52_13 < arg_49_1.time_ and arg_49_1.time_ <= var_52_13 + arg_52_0 then
				arg_49_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_52_14 = 0

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_52_15 = 0
			local var_52_16 = 0.425

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_17 = arg_49_1:FormatText(StoryNameCfg[410].name)

				arg_49_1.leftNameTxt_.text = var_52_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:GetWordFromCfg(222031012)
				local var_52_19 = arg_49_1:FormatText(var_52_18.content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031012", "story_v_out_222031.awb") ~= 0 then
					local var_52_23 = manager.audio:GetVoiceLength("story_v_out_222031", "222031012", "story_v_out_222031.awb") / 1000

					if var_52_23 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_15
					end

					if var_52_18.prefab_name ~= "" and arg_49_1.actors_[var_52_18.prefab_name] ~= nil then
						local var_52_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_18.prefab_name].transform, "story_v_out_222031", "222031012", "story_v_out_222031.awb")

						arg_49_1:RecordAudio("222031012", var_52_24)
						arg_49_1:RecordAudio("222031012", var_52_24)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_222031", "222031012", "story_v_out_222031.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_222031", "222031012", "story_v_out_222031.awb")
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
				actorName = "1074ui_story",
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
	Play222031013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 222031013
		arg_53_1.duration_ = 8.8

		local var_53_0 = {
			ja = 8.8,
			ko = 7.2,
			zh = 7.233
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
				arg_53_0:Play222031014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1074ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1074ui_story == nil then
				arg_53_1.var_.characterEffect1074ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1074ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1074ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1074ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1074ui_story.fillRatio = var_56_5
			end

			local var_56_6 = 0
			local var_56_7 = 0.575

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_8 = arg_53_1:FormatText(StoryNameCfg[462].name)

				arg_53_1.leftNameTxt_.text = var_56_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_9 = arg_53_1:GetWordFromCfg(222031013)
				local var_56_10 = arg_53_1:FormatText(var_56_9.content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031013", "story_v_out_222031.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031013", "story_v_out_222031.awb") / 1000

					if var_56_14 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_6
					end

					if var_56_9.prefab_name ~= "" and arg_53_1.actors_[var_56_9.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_9.prefab_name].transform, "story_v_out_222031", "222031013", "story_v_out_222031.awb")

						arg_53_1:RecordAudio("222031013", var_56_15)
						arg_53_1:RecordAudio("222031013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_222031", "222031013", "story_v_out_222031.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_222031", "222031013", "story_v_out_222031.awb")
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
	Play222031014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 222031014
		arg_57_1.duration_ = 6

		local var_57_0 = {
			ja = 6,
			ko = 4.833,
			zh = 4.9
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
				arg_57_0:Play222031015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.375

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[462].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(222031014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031014", "story_v_out_222031.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031014", "story_v_out_222031.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_222031", "222031014", "story_v_out_222031.awb")

						arg_57_1:RecordAudio("222031014", var_60_9)
						arg_57_1:RecordAudio("222031014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_222031", "222031014", "story_v_out_222031.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_222031", "222031014", "story_v_out_222031.awb")
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
	Play222031015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 222031015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play222031016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 1.1

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(222031015)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 44
				local var_64_5 = utf8.len(var_64_3)
				local var_64_6 = var_64_4 <= 0 and var_64_1 or var_64_1 * (var_64_5 / var_64_4)

				if var_64_6 > 0 and var_64_1 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_7 and arg_61_1.time_ < var_64_0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play222031016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 222031016
		arg_65_1.duration_ = 4.97

		local var_65_0 = {
			ja = 4.966,
			ko = 4.9,
			zh = 4.9
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
				arg_65_0:Play222031017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1074ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1074ui_story == nil then
				arg_65_1.var_.characterEffect1074ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1074ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1074ui_story then
				arg_65_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_68_4 = 0

			if var_68_4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_68_5 = 0

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_6 = 0
			local var_68_7 = 0.475

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_8 = arg_65_1:FormatText(StoryNameCfg[410].name)

				arg_65_1.leftNameTxt_.text = var_68_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_9 = arg_65_1:GetWordFromCfg(222031016)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 19
				local var_68_12 = utf8.len(var_68_10)
				local var_68_13 = var_68_11 <= 0 and var_68_7 or var_68_7 * (var_68_12 / var_68_11)

				if var_68_13 > 0 and var_68_7 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_10
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031016", "story_v_out_222031.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031016", "story_v_out_222031.awb") / 1000

					if var_68_14 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_6
					end

					if var_68_9.prefab_name ~= "" and arg_65_1.actors_[var_68_9.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_9.prefab_name].transform, "story_v_out_222031", "222031016", "story_v_out_222031.awb")

						arg_65_1:RecordAudio("222031016", var_68_15)
						arg_65_1:RecordAudio("222031016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_222031", "222031016", "story_v_out_222031.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_222031", "222031016", "story_v_out_222031.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_16 and arg_65_1.time_ < var_68_6 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play222031017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 222031017
		arg_69_1.duration_ = 12.97

		local var_69_0 = {
			ja = 12.966,
			ko = 12.633,
			zh = 12.766
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
				arg_69_0:Play222031018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.075

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[410].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(222031017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031017", "story_v_out_222031.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031017", "story_v_out_222031.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_222031", "222031017", "story_v_out_222031.awb")

						arg_69_1:RecordAudio("222031017", var_72_9)
						arg_69_1:RecordAudio("222031017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_222031", "222031017", "story_v_out_222031.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_222031", "222031017", "story_v_out_222031.awb")
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
	Play222031018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 222031018
		arg_73_1.duration_ = 3.03

		local var_73_0 = {
			ja = 3.033,
			ko = 2.9,
			zh = 2.9
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
				arg_73_0:Play222031019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1074ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1074ui_story == nil then
				arg_73_1.var_.characterEffect1074ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1074ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1074ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1074ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1074ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 0.225

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[462].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_9 = arg_73_1:GetWordFromCfg(222031018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031018", "story_v_out_222031.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031018", "story_v_out_222031.awb") / 1000

					if var_76_14 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_6
					end

					if var_76_9.prefab_name ~= "" and arg_73_1.actors_[var_76_9.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_9.prefab_name].transform, "story_v_out_222031", "222031018", "story_v_out_222031.awb")

						arg_73_1:RecordAudio("222031018", var_76_15)
						arg_73_1:RecordAudio("222031018", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_222031", "222031018", "story_v_out_222031.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_222031", "222031018", "story_v_out_222031.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_16 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_16 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_16

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_16 and arg_73_1.time_ < var_76_6 + var_76_16 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play222031019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 222031019
		arg_77_1.duration_ = 12.4

		local var_77_0 = {
			ja = 10.8,
			ko = 12.366,
			zh = 12.4
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
				arg_77_0:Play222031020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 1.05

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[462].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(222031019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 42
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031019", "story_v_out_222031.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031019", "story_v_out_222031.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_222031", "222031019", "story_v_out_222031.awb")

						arg_77_1:RecordAudio("222031019", var_80_9)
						arg_77_1:RecordAudio("222031019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_222031", "222031019", "story_v_out_222031.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_222031", "222031019", "story_v_out_222031.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_10 and arg_77_1.time_ < var_80_0 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play222031020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 222031020
		arg_81_1.duration_ = 12.9

		local var_81_0 = {
			ja = 12.9,
			ko = 8.033,
			zh = 8.033
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
				arg_81_0:Play222031021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.675

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[462].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(222031020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031020", "story_v_out_222031.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031020", "story_v_out_222031.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_222031", "222031020", "story_v_out_222031.awb")

						arg_81_1:RecordAudio("222031020", var_84_9)
						arg_81_1:RecordAudio("222031020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_222031", "222031020", "story_v_out_222031.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_222031", "222031020", "story_v_out_222031.awb")
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
	Play222031021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 222031021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play222031022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1074ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1074ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(0, 100, 0)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1074ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, 100, 0)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = arg_85_1.actors_["1074ui_story"]
			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1074ui_story == nil then
				arg_85_1.var_.characterEffect1074ui_story = var_88_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_11 = 0.200000002980232

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 and not isNil(var_88_9) then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11

				if arg_85_1.var_.characterEffect1074ui_story and not isNil(var_88_9) then
					local var_88_13 = Mathf.Lerp(0, 0.5, var_88_12)

					arg_85_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1074ui_story.fillRatio = var_88_13
				end
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1074ui_story then
				local var_88_14 = 0.5

				arg_85_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1074ui_story.fillRatio = var_88_14
			end

			local var_88_15 = 0
			local var_88_16 = 0.675

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_17 = arg_85_1:GetWordFromCfg(222031021)
				local var_88_18 = arg_85_1:FormatText(var_88_17.content)

				arg_85_1.text_.text = var_88_18

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_19 = 27
				local var_88_20 = utf8.len(var_88_18)
				local var_88_21 = var_88_19 <= 0 and var_88_16 or var_88_16 * (var_88_20 / var_88_19)

				if var_88_21 > 0 and var_88_16 < var_88_21 then
					arg_85_1.talkMaxDuration = var_88_21

					if var_88_21 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_21 + var_88_15
					end
				end

				arg_85_1.text_.text = var_88_18
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_22 = math.max(var_88_16, arg_85_1.talkMaxDuration)

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_22 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_15) / var_88_22

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_15 + var_88_22 and arg_85_1.time_ < var_88_15 + var_88_22 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play222031022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 222031022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play222031023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.975

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_2 = arg_89_1:GetWordFromCfg(222031022)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 39
				local var_92_5 = utf8.len(var_92_3)
				local var_92_6 = var_92_4 <= 0 and var_92_1 or var_92_1 * (var_92_5 / var_92_4)

				if var_92_6 > 0 and var_92_1 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_7 and arg_89_1.time_ < var_92_0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play222031023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 222031023
		arg_93_1.duration_ = 19.5

		local var_93_0 = {
			ja = 19.5,
			ko = 12.666,
			zh = 12.7
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
				arg_93_0:Play222031024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.975

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[462].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(222031023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031023", "story_v_out_222031.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031023", "story_v_out_222031.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_222031", "222031023", "story_v_out_222031.awb")

						arg_93_1:RecordAudio("222031023", var_96_9)
						arg_93_1:RecordAudio("222031023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_222031", "222031023", "story_v_out_222031.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_222031", "222031023", "story_v_out_222031.awb")
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
	Play222031024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 222031024
		arg_97_1.duration_ = 16.23

		local var_97_0 = {
			ja = 16.233,
			ko = 4.833,
			zh = 4.833
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play222031025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.4

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[462].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(222031024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 16
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031024", "story_v_out_222031.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031024", "story_v_out_222031.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_222031", "222031024", "story_v_out_222031.awb")

						arg_97_1:RecordAudio("222031024", var_100_9)
						arg_97_1:RecordAudio("222031024", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_222031", "222031024", "story_v_out_222031.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_222031", "222031024", "story_v_out_222031.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_10 and arg_97_1.time_ < var_100_0 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play222031025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 222031025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play222031026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.7

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

				local var_104_2 = arg_101_1:GetWordFromCfg(222031025)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 28
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
	Play222031026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 222031026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play222031027(arg_105_1)
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

				local var_108_2 = arg_105_1:GetWordFromCfg(222031026)
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
	Play222031027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 222031027
		arg_109_1.duration_ = 4.53

		local var_109_0 = {
			ja = 4.533,
			ko = 3.8,
			zh = 3.8
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
				arg_109_0:Play222031028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1074ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1074ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0, -1.055, -6.12)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1074ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["1074ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1074ui_story == nil then
				arg_109_1.var_.characterEffect1074ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect1074ui_story and not isNil(var_112_9) then
					arg_109_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1074ui_story then
				arg_109_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_112_13 = 0

			if var_112_13 < arg_109_1.time_ and arg_109_1.time_ <= var_112_13 + arg_112_0 then
				arg_109_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_112_14 = 0

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_112_15 = 0
			local var_112_16 = 0.4

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_17 = arg_109_1:FormatText(StoryNameCfg[410].name)

				arg_109_1.leftNameTxt_.text = var_112_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_18 = arg_109_1:GetWordFromCfg(222031027)
				local var_112_19 = arg_109_1:FormatText(var_112_18.content)

				arg_109_1.text_.text = var_112_19

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_20 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031027", "story_v_out_222031.awb") ~= 0 then
					local var_112_23 = manager.audio:GetVoiceLength("story_v_out_222031", "222031027", "story_v_out_222031.awb") / 1000

					if var_112_23 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_15
					end

					if var_112_18.prefab_name ~= "" and arg_109_1.actors_[var_112_18.prefab_name] ~= nil then
						local var_112_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_18.prefab_name].transform, "story_v_out_222031", "222031027", "story_v_out_222031.awb")

						arg_109_1:RecordAudio("222031027", var_112_24)
						arg_109_1:RecordAudio("222031027", var_112_24)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_222031", "222031027", "story_v_out_222031.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_222031", "222031027", "story_v_out_222031.awb")
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
				actorName = "1074ui_story",
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
	Play222031028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 222031028
		arg_113_1.duration_ = 16.13

		local var_113_0 = {
			ja = 16.1330000029802,
			ko = 9.23300000298023,
			zh = 9.23300000298023
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
				arg_113_0:Play222031029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = "ST39a"

			if arg_113_1.bgs_[var_116_0] == nil then
				local var_116_1 = Object.Instantiate(arg_113_1.paintGo_)

				var_116_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_116_0)
				var_116_1.name = var_116_0
				var_116_1.transform.parent = arg_113_1.stage_.transform
				var_116_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.bgs_[var_116_0] = var_116_1
			end

			local var_116_2 = 2.00000000298023

			if var_116_2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				local var_116_3 = manager.ui.mainCamera.transform.localPosition
				local var_116_4 = Vector3.New(0, 0, 10) + Vector3.New(var_116_3.x, var_116_3.y, 0)
				local var_116_5 = arg_113_1.bgs_.ST39a

				var_116_5.transform.localPosition = var_116_4
				var_116_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_6 = var_116_5:GetComponent("SpriteRenderer")

				if var_116_6 and var_116_6.sprite then
					local var_116_7 = (var_116_5.transform.localPosition - var_116_3).z
					local var_116_8 = manager.ui.mainCameraCom_
					local var_116_9 = 2 * var_116_7 * Mathf.Tan(var_116_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_116_10 = var_116_9 * var_116_8.aspect
					local var_116_11 = var_116_6.sprite.bounds.size.x
					local var_116_12 = var_116_6.sprite.bounds.size.y
					local var_116_13 = var_116_10 / var_116_11
					local var_116_14 = var_116_9 / var_116_12
					local var_116_15 = var_116_14 < var_116_13 and var_116_13 or var_116_14

					var_116_5.transform.localScale = Vector3.New(var_116_15, var_116_15, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "ST39a" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_16 = 0

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_17 = 2

			if var_116_16 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_17 then
				local var_116_18 = (arg_113_1.time_ - var_116_16) / var_116_17
				local var_116_19 = Color.New(0, 0, 0)

				var_116_19.a = Mathf.Lerp(0, 1, var_116_18)
				arg_113_1.mask_.color = var_116_19
			end

			if arg_113_1.time_ >= var_116_16 + var_116_17 and arg_113_1.time_ < var_116_16 + var_116_17 + arg_116_0 then
				local var_116_20 = Color.New(0, 0, 0)

				var_116_20.a = 1
				arg_113_1.mask_.color = var_116_20
			end

			local var_116_21 = 2.00000000298023

			if var_116_21 < arg_113_1.time_ and arg_113_1.time_ <= var_116_21 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_22 = 2

			if var_116_21 <= arg_113_1.time_ and arg_113_1.time_ < var_116_21 + var_116_22 then
				local var_116_23 = (arg_113_1.time_ - var_116_21) / var_116_22
				local var_116_24 = Color.New(0, 0, 0)

				var_116_24.a = Mathf.Lerp(1, 0, var_116_23)
				arg_113_1.mask_.color = var_116_24
			end

			if arg_113_1.time_ >= var_116_21 + var_116_22 and arg_113_1.time_ < var_116_21 + var_116_22 + arg_116_0 then
				local var_116_25 = Color.New(0, 0, 0)
				local var_116_26 = 0

				arg_113_1.mask_.enabled = false
				var_116_25.a = var_116_26
				arg_113_1.mask_.color = var_116_25
			end

			local var_116_27 = arg_113_1.actors_["1074ui_story"].transform
			local var_116_28 = 1.96599999815226

			if var_116_28 < arg_113_1.time_ and arg_113_1.time_ <= var_116_28 + arg_116_0 then
				arg_113_1.var_.moveOldPos1074ui_story = var_116_27.localPosition
			end

			local var_116_29 = 0.001

			if var_116_28 <= arg_113_1.time_ and arg_113_1.time_ < var_116_28 + var_116_29 then
				local var_116_30 = (arg_113_1.time_ - var_116_28) / var_116_29
				local var_116_31 = Vector3.New(0, 100, 0)

				var_116_27.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1074ui_story, var_116_31, var_116_30)

				local var_116_32 = manager.ui.mainCamera.transform.position - var_116_27.position

				var_116_27.forward = Vector3.New(var_116_32.x, var_116_32.y, var_116_32.z)

				local var_116_33 = var_116_27.localEulerAngles

				var_116_33.z = 0
				var_116_33.x = 0
				var_116_27.localEulerAngles = var_116_33
			end

			if arg_113_1.time_ >= var_116_28 + var_116_29 and arg_113_1.time_ < var_116_28 + var_116_29 + arg_116_0 then
				var_116_27.localPosition = Vector3.New(0, 100, 0)

				local var_116_34 = manager.ui.mainCamera.transform.position - var_116_27.position

				var_116_27.forward = Vector3.New(var_116_34.x, var_116_34.y, var_116_34.z)

				local var_116_35 = var_116_27.localEulerAngles

				var_116_35.z = 0
				var_116_35.x = 0
				var_116_27.localEulerAngles = var_116_35
			end

			local var_116_36 = arg_113_1.actors_["1074ui_story"]
			local var_116_37 = 1.96599999815226

			if var_116_37 < arg_113_1.time_ and arg_113_1.time_ <= var_116_37 + arg_116_0 and not isNil(var_116_36) and arg_113_1.var_.characterEffect1074ui_story == nil then
				arg_113_1.var_.characterEffect1074ui_story = var_116_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_38 = 0.034000001847744

			if var_116_37 <= arg_113_1.time_ and arg_113_1.time_ < var_116_37 + var_116_38 and not isNil(var_116_36) then
				local var_116_39 = (arg_113_1.time_ - var_116_37) / var_116_38

				if arg_113_1.var_.characterEffect1074ui_story and not isNil(var_116_36) then
					local var_116_40 = Mathf.Lerp(0, 0.5, var_116_39)

					arg_113_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1074ui_story.fillRatio = var_116_40
				end
			end

			if arg_113_1.time_ >= var_116_37 + var_116_38 and arg_113_1.time_ < var_116_37 + var_116_38 + arg_116_0 and not isNil(var_116_36) and arg_113_1.var_.characterEffect1074ui_story then
				local var_116_41 = 0.5

				arg_113_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1074ui_story.fillRatio = var_116_41
			end

			local var_116_42 = "1070ui_story"

			if arg_113_1.actors_[var_116_42] == nil then
				local var_116_43 = Asset.Load("Char/" .. "1070ui_story")

				if not isNil(var_116_43) then
					local var_116_44 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_113_1.stage_.transform)

					var_116_44.name = var_116_42
					var_116_44.transform.localPosition = Vector3.New(0, 100, 0)
					arg_113_1.actors_[var_116_42] = var_116_44

					local var_116_45 = var_116_44:GetComponentInChildren(typeof(CharacterEffect))

					var_116_45.enabled = true

					local var_116_46 = GameObjectTools.GetOrAddComponent(var_116_44, typeof(DynamicBoneHelper))

					if var_116_46 then
						var_116_46:EnableDynamicBone(false)
					end

					arg_113_1:ShowWeapon(var_116_45.transform, false)

					arg_113_1.var_[var_116_42 .. "Animator"] = var_116_45.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_113_1.var_[var_116_42 .. "Animator"].applyRootMotion = true
					arg_113_1.var_[var_116_42 .. "LipSync"] = var_116_45.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_116_47 = arg_113_1.actors_["1070ui_story"].transform
			local var_116_48 = 3.8

			if var_116_48 < arg_113_1.time_ and arg_113_1.time_ <= var_116_48 + arg_116_0 then
				arg_113_1.var_.moveOldPos1070ui_story = var_116_47.localPosition
			end

			local var_116_49 = 0.001

			if var_116_48 <= arg_113_1.time_ and arg_113_1.time_ < var_116_48 + var_116_49 then
				local var_116_50 = (arg_113_1.time_ - var_116_48) / var_116_49
				local var_116_51 = Vector3.New(0, -0.95, -6.05)

				var_116_47.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1070ui_story, var_116_51, var_116_50)

				local var_116_52 = manager.ui.mainCamera.transform.position - var_116_47.position

				var_116_47.forward = Vector3.New(var_116_52.x, var_116_52.y, var_116_52.z)

				local var_116_53 = var_116_47.localEulerAngles

				var_116_53.z = 0
				var_116_53.x = 0
				var_116_47.localEulerAngles = var_116_53
			end

			if arg_113_1.time_ >= var_116_48 + var_116_49 and arg_113_1.time_ < var_116_48 + var_116_49 + arg_116_0 then
				var_116_47.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_116_54 = manager.ui.mainCamera.transform.position - var_116_47.position

				var_116_47.forward = Vector3.New(var_116_54.x, var_116_54.y, var_116_54.z)

				local var_116_55 = var_116_47.localEulerAngles

				var_116_55.z = 0
				var_116_55.x = 0
				var_116_47.localEulerAngles = var_116_55
			end

			local var_116_56 = arg_113_1.actors_["1070ui_story"]
			local var_116_57 = 3.8

			if var_116_57 < arg_113_1.time_ and arg_113_1.time_ <= var_116_57 + arg_116_0 and not isNil(var_116_56) and arg_113_1.var_.characterEffect1070ui_story == nil then
				arg_113_1.var_.characterEffect1070ui_story = var_116_56:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_58 = 0.200000002980232

			if var_116_57 <= arg_113_1.time_ and arg_113_1.time_ < var_116_57 + var_116_58 and not isNil(var_116_56) then
				local var_116_59 = (arg_113_1.time_ - var_116_57) / var_116_58

				if arg_113_1.var_.characterEffect1070ui_story and not isNil(var_116_56) then
					arg_113_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_57 + var_116_58 and arg_113_1.time_ < var_116_57 + var_116_58 + arg_116_0 and not isNil(var_116_56) and arg_113_1.var_.characterEffect1070ui_story then
				arg_113_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_116_60 = 3.8

			if var_116_60 < arg_113_1.time_ and arg_113_1.time_ <= var_116_60 + arg_116_0 then
				arg_113_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			local var_116_61 = 3.8

			if var_116_61 < arg_113_1.time_ and arg_113_1.time_ <= var_116_61 + arg_116_0 then
				arg_113_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_62 = 4.00000000298023
			local var_116_63 = 0.6

			if var_116_62 < arg_113_1.time_ and arg_113_1.time_ <= var_116_62 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_64 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_64:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_65 = arg_113_1:FormatText(StoryNameCfg[318].name)

				arg_113_1.leftNameTxt_.text = var_116_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_66 = arg_113_1:GetWordFromCfg(222031028)
				local var_116_67 = arg_113_1:FormatText(var_116_66.content)

				arg_113_1.text_.text = var_116_67

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_68 = 24
				local var_116_69 = utf8.len(var_116_67)
				local var_116_70 = var_116_68 <= 0 and var_116_63 or var_116_63 * (var_116_69 / var_116_68)

				if var_116_70 > 0 and var_116_63 < var_116_70 then
					arg_113_1.talkMaxDuration = var_116_70
					var_116_62 = var_116_62 + 0.3

					if var_116_70 + var_116_62 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_70 + var_116_62
					end
				end

				arg_113_1.text_.text = var_116_67
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031028", "story_v_out_222031.awb") ~= 0 then
					local var_116_71 = manager.audio:GetVoiceLength("story_v_out_222031", "222031028", "story_v_out_222031.awb") / 1000

					if var_116_71 + var_116_62 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_71 + var_116_62
					end

					if var_116_66.prefab_name ~= "" and arg_113_1.actors_[var_116_66.prefab_name] ~= nil then
						local var_116_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_66.prefab_name].transform, "story_v_out_222031", "222031028", "story_v_out_222031.awb")

						arg_113_1:RecordAudio("222031028", var_116_72)
						arg_113_1:RecordAudio("222031028", var_116_72)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_222031", "222031028", "story_v_out_222031.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_222031", "222031028", "story_v_out_222031.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_73 = var_116_62 + 0.3
			local var_116_74 = math.max(var_116_63, arg_113_1.talkMaxDuration)

			if var_116_73 <= arg_113_1.time_ and arg_113_1.time_ < var_116_73 + var_116_74 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_73) / var_116_74

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_73 + var_116_74 and arg_113_1.time_ < var_116_73 + var_116_74 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play222031029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 222031029
		arg_119_1.duration_ = 16.37

		local var_119_0 = {
			ja = 16.366,
			ko = 5.666,
			zh = 5.7
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play222031030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1070ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos1070ui_story = var_122_0.localPosition
			end

			local var_122_2 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2
				local var_122_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1070ui_story, var_122_4, var_122_3)

				local var_122_5 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_5.x, var_122_5.y, var_122_5.z)

				local var_122_6 = var_122_0.localEulerAngles

				var_122_6.z = 0
				var_122_6.x = 0
				var_122_0.localEulerAngles = var_122_6
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_122_7 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_7.x, var_122_7.y, var_122_7.z)

				local var_122_8 = var_122_0.localEulerAngles

				var_122_8.z = 0
				var_122_8.x = 0
				var_122_0.localEulerAngles = var_122_8
			end

			local var_122_9 = arg_119_1.actors_["1070ui_story"]
			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect1070ui_story == nil then
				arg_119_1.var_.characterEffect1070ui_story = var_122_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_11 = 0.200000002980232

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_11 and not isNil(var_122_9) then
				local var_122_12 = (arg_119_1.time_ - var_122_10) / var_122_11

				if arg_119_1.var_.characterEffect1070ui_story and not isNil(var_122_9) then
					local var_122_13 = Mathf.Lerp(0, 0.5, var_122_12)

					arg_119_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1070ui_story.fillRatio = var_122_13
				end
			end

			if arg_119_1.time_ >= var_122_10 + var_122_11 and arg_119_1.time_ < var_122_10 + var_122_11 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect1070ui_story then
				local var_122_14 = 0.5

				arg_119_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1070ui_story.fillRatio = var_122_14
			end

			local var_122_15 = arg_119_1.actors_["1074ui_story"].transform
			local var_122_16 = 0

			if var_122_16 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 then
				arg_119_1.var_.moveOldPos1074ui_story = var_122_15.localPosition
			end

			local var_122_17 = 0.001

			if var_122_16 <= arg_119_1.time_ and arg_119_1.time_ < var_122_16 + var_122_17 then
				local var_122_18 = (arg_119_1.time_ - var_122_16) / var_122_17
				local var_122_19 = Vector3.New(0.7, -1.055, -6.12)

				var_122_15.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1074ui_story, var_122_19, var_122_18)

				local var_122_20 = manager.ui.mainCamera.transform.position - var_122_15.position

				var_122_15.forward = Vector3.New(var_122_20.x, var_122_20.y, var_122_20.z)

				local var_122_21 = var_122_15.localEulerAngles

				var_122_21.z = 0
				var_122_21.x = 0
				var_122_15.localEulerAngles = var_122_21
			end

			if arg_119_1.time_ >= var_122_16 + var_122_17 and arg_119_1.time_ < var_122_16 + var_122_17 + arg_122_0 then
				var_122_15.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_122_22 = manager.ui.mainCamera.transform.position - var_122_15.position

				var_122_15.forward = Vector3.New(var_122_22.x, var_122_22.y, var_122_22.z)

				local var_122_23 = var_122_15.localEulerAngles

				var_122_23.z = 0
				var_122_23.x = 0
				var_122_15.localEulerAngles = var_122_23
			end

			local var_122_24 = arg_119_1.actors_["1074ui_story"]
			local var_122_25 = 0

			if var_122_25 < arg_119_1.time_ and arg_119_1.time_ <= var_122_25 + arg_122_0 and not isNil(var_122_24) and arg_119_1.var_.characterEffect1074ui_story == nil then
				arg_119_1.var_.characterEffect1074ui_story = var_122_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_26 = 0.200000002980232

			if var_122_25 <= arg_119_1.time_ and arg_119_1.time_ < var_122_25 + var_122_26 and not isNil(var_122_24) then
				local var_122_27 = (arg_119_1.time_ - var_122_25) / var_122_26

				if arg_119_1.var_.characterEffect1074ui_story and not isNil(var_122_24) then
					arg_119_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_25 + var_122_26 and arg_119_1.time_ < var_122_25 + var_122_26 + arg_122_0 and not isNil(var_122_24) and arg_119_1.var_.characterEffect1074ui_story then
				arg_119_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_122_28 = 0

			if var_122_28 < arg_119_1.time_ and arg_119_1.time_ <= var_122_28 + arg_122_0 then
				arg_119_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_122_29 = 0

			if var_122_29 < arg_119_1.time_ and arg_119_1.time_ <= var_122_29 + arg_122_0 then
				arg_119_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_122_30 = 0
			local var_122_31 = 0.675

			if var_122_30 < arg_119_1.time_ and arg_119_1.time_ <= var_122_30 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_32 = arg_119_1:FormatText(StoryNameCfg[410].name)

				arg_119_1.leftNameTxt_.text = var_122_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_33 = arg_119_1:GetWordFromCfg(222031029)
				local var_122_34 = arg_119_1:FormatText(var_122_33.content)

				arg_119_1.text_.text = var_122_34

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_35 = 27
				local var_122_36 = utf8.len(var_122_34)
				local var_122_37 = var_122_35 <= 0 and var_122_31 or var_122_31 * (var_122_36 / var_122_35)

				if var_122_37 > 0 and var_122_31 < var_122_37 then
					arg_119_1.talkMaxDuration = var_122_37

					if var_122_37 + var_122_30 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_37 + var_122_30
					end
				end

				arg_119_1.text_.text = var_122_34
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031029", "story_v_out_222031.awb") ~= 0 then
					local var_122_38 = manager.audio:GetVoiceLength("story_v_out_222031", "222031029", "story_v_out_222031.awb") / 1000

					if var_122_38 + var_122_30 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_38 + var_122_30
					end

					if var_122_33.prefab_name ~= "" and arg_119_1.actors_[var_122_33.prefab_name] ~= nil then
						local var_122_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_33.prefab_name].transform, "story_v_out_222031", "222031029", "story_v_out_222031.awb")

						arg_119_1:RecordAudio("222031029", var_122_39)
						arg_119_1:RecordAudio("222031029", var_122_39)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_222031", "222031029", "story_v_out_222031.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_222031", "222031029", "story_v_out_222031.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_40 = math.max(var_122_31, arg_119_1.talkMaxDuration)

			if var_122_30 <= arg_119_1.time_ and arg_119_1.time_ < var_122_30 + var_122_40 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_30) / var_122_40

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_30 + var_122_40 and arg_119_1.time_ < var_122_30 + var_122_40 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play222031030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 222031030
		arg_123_1.duration_ = 11.37

		local var_123_0 = {
			ja = 11.366,
			ko = 7.033,
			zh = 7.066
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
				arg_123_0:Play222031031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1070ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1070ui_story = var_126_0.localPosition
			end

			local var_126_2 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2
				local var_126_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1070ui_story, var_126_4, var_126_3)

				local var_126_5 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_5.x, var_126_5.y, var_126_5.z)

				local var_126_6 = var_126_0.localEulerAngles

				var_126_6.z = 0
				var_126_6.x = 0
				var_126_0.localEulerAngles = var_126_6
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_126_7 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_7.x, var_126_7.y, var_126_7.z)

				local var_126_8 = var_126_0.localEulerAngles

				var_126_8.z = 0
				var_126_8.x = 0
				var_126_0.localEulerAngles = var_126_8
			end

			local var_126_9 = arg_123_1.actors_["1070ui_story"]
			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect1070ui_story == nil then
				arg_123_1.var_.characterEffect1070ui_story = var_126_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_11 = 0.200000002980232

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_11 and not isNil(var_126_9) then
				local var_126_12 = (arg_123_1.time_ - var_126_10) / var_126_11

				if arg_123_1.var_.characterEffect1070ui_story and not isNil(var_126_9) then
					arg_123_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_10 + var_126_11 and arg_123_1.time_ < var_126_10 + var_126_11 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect1070ui_story then
				arg_123_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_126_13 = 0

			if var_126_13 < arg_123_1.time_ and arg_123_1.time_ <= var_126_13 + arg_126_0 then
				arg_123_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action436")
			end

			local var_126_14 = 0

			if var_126_14 < arg_123_1.time_ and arg_123_1.time_ <= var_126_14 + arg_126_0 then
				arg_123_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_15 = arg_123_1.actors_["1074ui_story"]
			local var_126_16 = 0

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 and not isNil(var_126_15) and arg_123_1.var_.characterEffect1074ui_story == nil then
				arg_123_1.var_.characterEffect1074ui_story = var_126_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_17 = 0.200000002980232

			if var_126_16 <= arg_123_1.time_ and arg_123_1.time_ < var_126_16 + var_126_17 and not isNil(var_126_15) then
				local var_126_18 = (arg_123_1.time_ - var_126_16) / var_126_17

				if arg_123_1.var_.characterEffect1074ui_story and not isNil(var_126_15) then
					local var_126_19 = Mathf.Lerp(0, 0.5, var_126_18)

					arg_123_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1074ui_story.fillRatio = var_126_19
				end
			end

			if arg_123_1.time_ >= var_126_16 + var_126_17 and arg_123_1.time_ < var_126_16 + var_126_17 + arg_126_0 and not isNil(var_126_15) and arg_123_1.var_.characterEffect1074ui_story then
				local var_126_20 = 0.5

				arg_123_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1074ui_story.fillRatio = var_126_20
			end

			local var_126_21 = 0
			local var_126_22 = 0.825

			if var_126_21 < arg_123_1.time_ and arg_123_1.time_ <= var_126_21 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_23 = arg_123_1:FormatText(StoryNameCfg[318].name)

				arg_123_1.leftNameTxt_.text = var_126_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_24 = arg_123_1:GetWordFromCfg(222031030)
				local var_126_25 = arg_123_1:FormatText(var_126_24.content)

				arg_123_1.text_.text = var_126_25

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_26 = 33
				local var_126_27 = utf8.len(var_126_25)
				local var_126_28 = var_126_26 <= 0 and var_126_22 or var_126_22 * (var_126_27 / var_126_26)

				if var_126_28 > 0 and var_126_22 < var_126_28 then
					arg_123_1.talkMaxDuration = var_126_28

					if var_126_28 + var_126_21 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_28 + var_126_21
					end
				end

				arg_123_1.text_.text = var_126_25
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031030", "story_v_out_222031.awb") ~= 0 then
					local var_126_29 = manager.audio:GetVoiceLength("story_v_out_222031", "222031030", "story_v_out_222031.awb") / 1000

					if var_126_29 + var_126_21 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_29 + var_126_21
					end

					if var_126_24.prefab_name ~= "" and arg_123_1.actors_[var_126_24.prefab_name] ~= nil then
						local var_126_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_24.prefab_name].transform, "story_v_out_222031", "222031030", "story_v_out_222031.awb")

						arg_123_1:RecordAudio("222031030", var_126_30)
						arg_123_1:RecordAudio("222031030", var_126_30)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_222031", "222031030", "story_v_out_222031.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_222031", "222031030", "story_v_out_222031.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_31 = math.max(var_126_22, arg_123_1.talkMaxDuration)

			if var_126_21 <= arg_123_1.time_ and arg_123_1.time_ < var_126_21 + var_126_31 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_21) / var_126_31

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_21 + var_126_31 and arg_123_1.time_ < var_126_21 + var_126_31 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play222031031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 222031031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play222031032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1070ui_story"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos1070ui_story = var_130_0.localPosition
			end

			local var_130_2 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2
				local var_130_4 = Vector3.New(0, 100, 0)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1070ui_story, var_130_4, var_130_3)

				local var_130_5 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_5.x, var_130_5.y, var_130_5.z)

				local var_130_6 = var_130_0.localEulerAngles

				var_130_6.z = 0
				var_130_6.x = 0
				var_130_0.localEulerAngles = var_130_6
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(0, 100, 0)

				local var_130_7 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_7.x, var_130_7.y, var_130_7.z)

				local var_130_8 = var_130_0.localEulerAngles

				var_130_8.z = 0
				var_130_8.x = 0
				var_130_0.localEulerAngles = var_130_8
			end

			local var_130_9 = arg_127_1.actors_["1070ui_story"]
			local var_130_10 = 0

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 and not isNil(var_130_9) and arg_127_1.var_.characterEffect1070ui_story == nil then
				arg_127_1.var_.characterEffect1070ui_story = var_130_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_11 = 0.200000002980232

			if var_130_10 <= arg_127_1.time_ and arg_127_1.time_ < var_130_10 + var_130_11 and not isNil(var_130_9) then
				local var_130_12 = (arg_127_1.time_ - var_130_10) / var_130_11

				if arg_127_1.var_.characterEffect1070ui_story and not isNil(var_130_9) then
					local var_130_13 = Mathf.Lerp(0, 0.5, var_130_12)

					arg_127_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1070ui_story.fillRatio = var_130_13
				end
			end

			if arg_127_1.time_ >= var_130_10 + var_130_11 and arg_127_1.time_ < var_130_10 + var_130_11 + arg_130_0 and not isNil(var_130_9) and arg_127_1.var_.characterEffect1070ui_story then
				local var_130_14 = 0.5

				arg_127_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1070ui_story.fillRatio = var_130_14
			end

			local var_130_15 = arg_127_1.actors_["1074ui_story"].transform
			local var_130_16 = 0

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				arg_127_1.var_.moveOldPos1074ui_story = var_130_15.localPosition
			end

			local var_130_17 = 0.001

			if var_130_16 <= arg_127_1.time_ and arg_127_1.time_ < var_130_16 + var_130_17 then
				local var_130_18 = (arg_127_1.time_ - var_130_16) / var_130_17
				local var_130_19 = Vector3.New(0, 100, 0)

				var_130_15.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1074ui_story, var_130_19, var_130_18)

				local var_130_20 = manager.ui.mainCamera.transform.position - var_130_15.position

				var_130_15.forward = Vector3.New(var_130_20.x, var_130_20.y, var_130_20.z)

				local var_130_21 = var_130_15.localEulerAngles

				var_130_21.z = 0
				var_130_21.x = 0
				var_130_15.localEulerAngles = var_130_21
			end

			if arg_127_1.time_ >= var_130_16 + var_130_17 and arg_127_1.time_ < var_130_16 + var_130_17 + arg_130_0 then
				var_130_15.localPosition = Vector3.New(0, 100, 0)

				local var_130_22 = manager.ui.mainCamera.transform.position - var_130_15.position

				var_130_15.forward = Vector3.New(var_130_22.x, var_130_22.y, var_130_22.z)

				local var_130_23 = var_130_15.localEulerAngles

				var_130_23.z = 0
				var_130_23.x = 0
				var_130_15.localEulerAngles = var_130_23
			end

			local var_130_24 = arg_127_1.actors_["1074ui_story"]
			local var_130_25 = 0

			if var_130_25 < arg_127_1.time_ and arg_127_1.time_ <= var_130_25 + arg_130_0 and not isNil(var_130_24) and arg_127_1.var_.characterEffect1074ui_story == nil then
				arg_127_1.var_.characterEffect1074ui_story = var_130_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_26 = 0.200000002980232

			if var_130_25 <= arg_127_1.time_ and arg_127_1.time_ < var_130_25 + var_130_26 and not isNil(var_130_24) then
				local var_130_27 = (arg_127_1.time_ - var_130_25) / var_130_26

				if arg_127_1.var_.characterEffect1074ui_story and not isNil(var_130_24) then
					local var_130_28 = Mathf.Lerp(0, 0.5, var_130_27)

					arg_127_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1074ui_story.fillRatio = var_130_28
				end
			end

			if arg_127_1.time_ >= var_130_25 + var_130_26 and arg_127_1.time_ < var_130_25 + var_130_26 + arg_130_0 and not isNil(var_130_24) and arg_127_1.var_.characterEffect1074ui_story then
				local var_130_29 = 0.5

				arg_127_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1074ui_story.fillRatio = var_130_29
			end

			local var_130_30 = 0
			local var_130_31 = 1.325

			if var_130_30 < arg_127_1.time_ and arg_127_1.time_ <= var_130_30 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_32 = arg_127_1:GetWordFromCfg(222031031)
				local var_130_33 = arg_127_1:FormatText(var_130_32.content)

				arg_127_1.text_.text = var_130_33

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_34 = 53
				local var_130_35 = utf8.len(var_130_33)
				local var_130_36 = var_130_34 <= 0 and var_130_31 or var_130_31 * (var_130_35 / var_130_34)

				if var_130_36 > 0 and var_130_31 < var_130_36 then
					arg_127_1.talkMaxDuration = var_130_36

					if var_130_36 + var_130_30 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_36 + var_130_30
					end
				end

				arg_127_1.text_.text = var_130_33
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_37 = math.max(var_130_31, arg_127_1.talkMaxDuration)

			if var_130_30 <= arg_127_1.time_ and arg_127_1.time_ < var_130_30 + var_130_37 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_30) / var_130_37

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_30 + var_130_37 and arg_127_1.time_ < var_130_30 + var_130_37 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play222031032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 222031032
		arg_131_1.duration_ = 4.8

		local var_131_0 = {
			ja = 4.7,
			ko = 4.666,
			zh = 4.8
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
				arg_131_0:Play222031033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1074ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos1074ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(0, -1.055, -6.12)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1074ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["1074ui_story"]
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect1074ui_story == nil then
				arg_131_1.var_.characterEffect1074ui_story = var_134_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 and not isNil(var_134_9) then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11

				if arg_131_1.var_.characterEffect1074ui_story and not isNil(var_134_9) then
					arg_131_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect1074ui_story then
				arg_131_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_134_13 = 0

			if var_134_13 < arg_131_1.time_ and arg_131_1.time_ <= var_134_13 + arg_134_0 then
				arg_131_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_134_14 = 0

			if var_134_14 < arg_131_1.time_ and arg_131_1.time_ <= var_134_14 + arg_134_0 then
				arg_131_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_15 = 0
			local var_134_16 = 0.4

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_17 = arg_131_1:FormatText(StoryNameCfg[410].name)

				arg_131_1.leftNameTxt_.text = var_134_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_18 = arg_131_1:GetWordFromCfg(222031032)
				local var_134_19 = arg_131_1:FormatText(var_134_18.content)

				arg_131_1.text_.text = var_134_19

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_20 = 16
				local var_134_21 = utf8.len(var_134_19)
				local var_134_22 = var_134_20 <= 0 and var_134_16 or var_134_16 * (var_134_21 / var_134_20)

				if var_134_22 > 0 and var_134_16 < var_134_22 then
					arg_131_1.talkMaxDuration = var_134_22

					if var_134_22 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_22 + var_134_15
					end
				end

				arg_131_1.text_.text = var_134_19
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031032", "story_v_out_222031.awb") ~= 0 then
					local var_134_23 = manager.audio:GetVoiceLength("story_v_out_222031", "222031032", "story_v_out_222031.awb") / 1000

					if var_134_23 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_23 + var_134_15
					end

					if var_134_18.prefab_name ~= "" and arg_131_1.actors_[var_134_18.prefab_name] ~= nil then
						local var_134_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_18.prefab_name].transform, "story_v_out_222031", "222031032", "story_v_out_222031.awb")

						arg_131_1:RecordAudio("222031032", var_134_24)
						arg_131_1:RecordAudio("222031032", var_134_24)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_222031", "222031032", "story_v_out_222031.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_222031", "222031032", "story_v_out_222031.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_25 = math.max(var_134_16, arg_131_1.talkMaxDuration)

			if var_134_15 <= arg_131_1.time_ and arg_131_1.time_ < var_134_15 + var_134_25 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_15) / var_134_25

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_15 + var_134_25 and arg_131_1.time_ < var_134_15 + var_134_25 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play222031033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 222031033
		arg_135_1.duration_ = 2.43

		local var_135_0 = {
			ja = 2.433,
			ko = 1.1,
			zh = 1.033
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play222031034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1074ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1074ui_story == nil then
				arg_135_1.var_.characterEffect1074ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1074ui_story and not isNil(var_138_0) then
					local var_138_4 = Mathf.Lerp(0, 0.5, var_138_3)

					arg_135_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1074ui_story.fillRatio = var_138_4
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1074ui_story then
				local var_138_5 = 0.5

				arg_135_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1074ui_story.fillRatio = var_138_5
			end

			local var_138_6 = 0
			local var_138_7 = 0.075

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_8 = arg_135_1:FormatText(StoryNameCfg[461].name)

				arg_135_1.leftNameTxt_.text = var_138_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_9 = arg_135_1:GetWordFromCfg(222031033)
				local var_138_10 = arg_135_1:FormatText(var_138_9.content)

				arg_135_1.text_.text = var_138_10

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_11 = 3
				local var_138_12 = utf8.len(var_138_10)
				local var_138_13 = var_138_11 <= 0 and var_138_7 or var_138_7 * (var_138_12 / var_138_11)

				if var_138_13 > 0 and var_138_7 < var_138_13 then
					arg_135_1.talkMaxDuration = var_138_13

					if var_138_13 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_6
					end
				end

				arg_135_1.text_.text = var_138_10
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031033", "story_v_out_222031.awb") ~= 0 then
					local var_138_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031033", "story_v_out_222031.awb") / 1000

					if var_138_14 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_14 + var_138_6
					end

					if var_138_9.prefab_name ~= "" and arg_135_1.actors_[var_138_9.prefab_name] ~= nil then
						local var_138_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_9.prefab_name].transform, "story_v_out_222031", "222031033", "story_v_out_222031.awb")

						arg_135_1:RecordAudio("222031033", var_138_15)
						arg_135_1:RecordAudio("222031033", var_138_15)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_222031", "222031033", "story_v_out_222031.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_222031", "222031033", "story_v_out_222031.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_16 = math.max(var_138_7, arg_135_1.talkMaxDuration)

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_16 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_6) / var_138_16

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_6 + var_138_16 and arg_135_1.time_ < var_138_6 + var_138_16 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play222031034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 222031034
		arg_139_1.duration_ = 20.8

		local var_139_0 = {
			ja = 20.8,
			ko = 11.033,
			zh = 11.066
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
				arg_139_0:Play222031035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1074ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1074ui_story == nil then
				arg_139_1.var_.characterEffect1074ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect1074ui_story and not isNil(var_142_0) then
					arg_139_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1074ui_story then
				arg_139_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_142_4 = 0

			if var_142_4 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_1")
			end

			local var_142_5 = 0

			if var_142_5 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_142_6 = 0
			local var_142_7 = 1.425

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_8 = arg_139_1:FormatText(StoryNameCfg[410].name)

				arg_139_1.leftNameTxt_.text = var_142_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_9 = arg_139_1:GetWordFromCfg(222031034)
				local var_142_10 = arg_139_1:FormatText(var_142_9.content)

				arg_139_1.text_.text = var_142_10

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 55
				local var_142_12 = utf8.len(var_142_10)
				local var_142_13 = var_142_11 <= 0 and var_142_7 or var_142_7 * (var_142_12 / var_142_11)

				if var_142_13 > 0 and var_142_7 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_10
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031034", "story_v_out_222031.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031034", "story_v_out_222031.awb") / 1000

					if var_142_14 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_6
					end

					if var_142_9.prefab_name ~= "" and arg_139_1.actors_[var_142_9.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_9.prefab_name].transform, "story_v_out_222031", "222031034", "story_v_out_222031.awb")

						arg_139_1:RecordAudio("222031034", var_142_15)
						arg_139_1:RecordAudio("222031034", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_222031", "222031034", "story_v_out_222031.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_222031", "222031034", "story_v_out_222031.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_7, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_6) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_16 and arg_139_1.time_ < var_142_6 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play222031035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 222031035
		arg_143_1.duration_ = 12.77

		local var_143_0 = {
			ja = 12.766,
			ko = 6.066,
			zh = 6.066
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
				arg_143_0:Play222031036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.775

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[410].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_3 = arg_143_1:GetWordFromCfg(222031035)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 31
				local var_146_6 = utf8.len(var_146_4)
				local var_146_7 = var_146_5 <= 0 and var_146_1 or var_146_1 * (var_146_6 / var_146_5)

				if var_146_7 > 0 and var_146_1 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031035", "story_v_out_222031.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031035", "story_v_out_222031.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_222031", "222031035", "story_v_out_222031.awb")

						arg_143_1:RecordAudio("222031035", var_146_9)
						arg_143_1:RecordAudio("222031035", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_222031", "222031035", "story_v_out_222031.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_222031", "222031035", "story_v_out_222031.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_10 and arg_143_1.time_ < var_146_0 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play222031036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 222031036
		arg_147_1.duration_ = 10.03

		local var_147_0 = {
			ja = 10.033,
			ko = 8.2,
			zh = 8.166
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play222031037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 1.025

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[410].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:GetWordFromCfg(222031036)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031036", "story_v_out_222031.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031036", "story_v_out_222031.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_222031", "222031036", "story_v_out_222031.awb")

						arg_147_1:RecordAudio("222031036", var_150_9)
						arg_147_1:RecordAudio("222031036", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_222031", "222031036", "story_v_out_222031.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_222031", "222031036", "story_v_out_222031.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_10 and arg_147_1.time_ < var_150_0 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play222031037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 222031037
		arg_151_1.duration_ = 1.7

		local var_151_0 = {
			ja = 1.7,
			ko = 1,
			zh = 1
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
				arg_151_0:Play222031038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1074ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1074ui_story == nil then
				arg_151_1.var_.characterEffect1074ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1074ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1074ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1074ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1074ui_story.fillRatio = var_154_5
			end

			local var_154_6 = 0
			local var_154_7 = 0.05

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_8 = arg_151_1:FormatText(StoryNameCfg[461].name)

				arg_151_1.leftNameTxt_.text = var_154_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_9 = arg_151_1:GetWordFromCfg(222031037)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031037", "story_v_out_222031.awb") ~= 0 then
					local var_154_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031037", "story_v_out_222031.awb") / 1000

					if var_154_14 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_6
					end

					if var_154_9.prefab_name ~= "" and arg_151_1.actors_[var_154_9.prefab_name] ~= nil then
						local var_154_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_9.prefab_name].transform, "story_v_out_222031", "222031037", "story_v_out_222031.awb")

						arg_151_1:RecordAudio("222031037", var_154_15)
						arg_151_1:RecordAudio("222031037", var_154_15)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_222031", "222031037", "story_v_out_222031.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_222031", "222031037", "story_v_out_222031.awb")
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
	Play222031038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 222031038
		arg_155_1.duration_ = 10.57

		local var_155_0 = {
			ja = 10.566,
			ko = 6.1,
			zh = 6.133
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
				arg_155_0:Play222031039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1074ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1074ui_story == nil then
				arg_155_1.var_.characterEffect1074ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect1074ui_story and not isNil(var_158_0) then
					arg_155_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1074ui_story then
				arg_155_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_158_4 = 0
			local var_158_5 = 0.575

			if var_158_4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_6 = arg_155_1:FormatText(StoryNameCfg[410].name)

				arg_155_1.leftNameTxt_.text = var_158_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_7 = arg_155_1:GetWordFromCfg(222031038)
				local var_158_8 = arg_155_1:FormatText(var_158_7.content)

				arg_155_1.text_.text = var_158_8

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_9 = 23
				local var_158_10 = utf8.len(var_158_8)
				local var_158_11 = var_158_9 <= 0 and var_158_5 or var_158_5 * (var_158_10 / var_158_9)

				if var_158_11 > 0 and var_158_5 < var_158_11 then
					arg_155_1.talkMaxDuration = var_158_11

					if var_158_11 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_8
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031038", "story_v_out_222031.awb") ~= 0 then
					local var_158_12 = manager.audio:GetVoiceLength("story_v_out_222031", "222031038", "story_v_out_222031.awb") / 1000

					if var_158_12 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_4
					end

					if var_158_7.prefab_name ~= "" and arg_155_1.actors_[var_158_7.prefab_name] ~= nil then
						local var_158_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_7.prefab_name].transform, "story_v_out_222031", "222031038", "story_v_out_222031.awb")

						arg_155_1:RecordAudio("222031038", var_158_13)
						arg_155_1:RecordAudio("222031038", var_158_13)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_222031", "222031038", "story_v_out_222031.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_222031", "222031038", "story_v_out_222031.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_5, arg_155_1.talkMaxDuration)

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_4) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_4 + var_158_14 and arg_155_1.time_ < var_158_4 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play222031039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 222031039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play222031040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1074ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1074ui_story == nil then
				arg_159_1.var_.characterEffect1074ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect1074ui_story and not isNil(var_162_0) then
					local var_162_4 = Mathf.Lerp(0, 0.5, var_162_3)

					arg_159_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1074ui_story.fillRatio = var_162_4
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1074ui_story then
				local var_162_5 = 0.5

				arg_159_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1074ui_story.fillRatio = var_162_5
			end

			local var_162_6 = 0
			local var_162_7 = 0.95

			if var_162_6 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_8 = arg_159_1:GetWordFromCfg(222031039)
				local var_162_9 = arg_159_1:FormatText(var_162_8.content)

				arg_159_1.text_.text = var_162_9

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_10 = 38
				local var_162_11 = utf8.len(var_162_9)
				local var_162_12 = var_162_10 <= 0 and var_162_7 or var_162_7 * (var_162_11 / var_162_10)

				if var_162_12 > 0 and var_162_7 < var_162_12 then
					arg_159_1.talkMaxDuration = var_162_12

					if var_162_12 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_12 + var_162_6
					end
				end

				arg_159_1.text_.text = var_162_9
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_13 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_13 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_13

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_13 and arg_159_1.time_ < var_162_6 + var_162_13 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play222031040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 222031040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play222031041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 1.025

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_2 = arg_163_1:GetWordFromCfg(222031040)
				local var_166_3 = arg_163_1:FormatText(var_166_2.content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 41
				local var_166_5 = utf8.len(var_166_3)
				local var_166_6 = var_166_4 <= 0 and var_166_1 or var_166_1 * (var_166_5 / var_166_4)

				if var_166_6 > 0 and var_166_1 < var_166_6 then
					arg_163_1.talkMaxDuration = var_166_6

					if var_166_6 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_7 and arg_163_1.time_ < var_166_0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play222031041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 222031041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play222031042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 1.025

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_2 = arg_167_1:GetWordFromCfg(222031041)
				local var_170_3 = arg_167_1:FormatText(var_170_2.content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 41
				local var_170_5 = utf8.len(var_170_3)
				local var_170_6 = var_170_4 <= 0 and var_170_1 or var_170_1 * (var_170_5 / var_170_4)

				if var_170_6 > 0 and var_170_1 < var_170_6 then
					arg_167_1.talkMaxDuration = var_170_6

					if var_170_6 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_6 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_7 and arg_167_1.time_ < var_170_0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play222031042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 222031042
		arg_171_1.duration_ = 6.2

		local var_171_0 = {
			ja = 6.2,
			ko = 2.433,
			zh = 2.433
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play222031043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1074ui_story"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1074ui_story == nil then
				arg_171_1.var_.characterEffect1074ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.characterEffect1074ui_story and not isNil(var_174_0) then
					arg_171_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1074ui_story then
				arg_171_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_174_4 = 0
			local var_174_5 = 0.325

			if var_174_4 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_6 = arg_171_1:FormatText(StoryNameCfg[410].name)

				arg_171_1.leftNameTxt_.text = var_174_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_7 = arg_171_1:GetWordFromCfg(222031042)
				local var_174_8 = arg_171_1:FormatText(var_174_7.content)

				arg_171_1.text_.text = var_174_8

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 13
				local var_174_10 = utf8.len(var_174_8)
				local var_174_11 = var_174_9 <= 0 and var_174_5 or var_174_5 * (var_174_10 / var_174_9)

				if var_174_11 > 0 and var_174_5 < var_174_11 then
					arg_171_1.talkMaxDuration = var_174_11

					if var_174_11 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_8
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031042", "story_v_out_222031.awb") ~= 0 then
					local var_174_12 = manager.audio:GetVoiceLength("story_v_out_222031", "222031042", "story_v_out_222031.awb") / 1000

					if var_174_12 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_12 + var_174_4
					end

					if var_174_7.prefab_name ~= "" and arg_171_1.actors_[var_174_7.prefab_name] ~= nil then
						local var_174_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_7.prefab_name].transform, "story_v_out_222031", "222031042", "story_v_out_222031.awb")

						arg_171_1:RecordAudio("222031042", var_174_13)
						arg_171_1:RecordAudio("222031042", var_174_13)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_222031", "222031042", "story_v_out_222031.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_222031", "222031042", "story_v_out_222031.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_14 = math.max(var_174_5, arg_171_1.talkMaxDuration)

			if var_174_4 <= arg_171_1.time_ and arg_171_1.time_ < var_174_4 + var_174_14 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_4) / var_174_14

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_4 + var_174_14 and arg_171_1.time_ < var_174_4 + var_174_14 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play222031043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 222031043
		arg_175_1.duration_ = 2.5

		local var_175_0 = {
			ja = 2.5,
			ko = 1.8,
			zh = 1.866
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play222031044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1074ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1074ui_story == nil then
				arg_175_1.var_.characterEffect1074ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect1074ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1074ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1074ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1074ui_story.fillRatio = var_178_5
			end

			local var_178_6 = 0
			local var_178_7 = 0.1

			if var_178_6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_8 = arg_175_1:FormatText(StoryNameCfg[461].name)

				arg_175_1.leftNameTxt_.text = var_178_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_9 = arg_175_1:GetWordFromCfg(222031043)
				local var_178_10 = arg_175_1:FormatText(var_178_9.content)

				arg_175_1.text_.text = var_178_10

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_11 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031043", "story_v_out_222031.awb") ~= 0 then
					local var_178_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031043", "story_v_out_222031.awb") / 1000

					if var_178_14 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_6
					end

					if var_178_9.prefab_name ~= "" and arg_175_1.actors_[var_178_9.prefab_name] ~= nil then
						local var_178_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_9.prefab_name].transform, "story_v_out_222031", "222031043", "story_v_out_222031.awb")

						arg_175_1:RecordAudio("222031043", var_178_15)
						arg_175_1:RecordAudio("222031043", var_178_15)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_222031", "222031043", "story_v_out_222031.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_222031", "222031043", "story_v_out_222031.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = math.max(var_178_7, arg_175_1.talkMaxDuration)

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_6) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_6 + var_178_16 and arg_175_1.time_ < var_178_6 + var_178_16 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play222031044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 222031044
		arg_179_1.duration_ = 12.9

		local var_179_0 = {
			ja = 12.9,
			ko = 5.566,
			zh = 5.566
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
				arg_179_0:Play222031045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.5

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[461].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:GetWordFromCfg(222031044)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 20
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031044", "story_v_out_222031.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031044", "story_v_out_222031.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_222031", "222031044", "story_v_out_222031.awb")

						arg_179_1:RecordAudio("222031044", var_182_9)
						arg_179_1:RecordAudio("222031044", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_222031", "222031044", "story_v_out_222031.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_222031", "222031044", "story_v_out_222031.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_10 and arg_179_1.time_ < var_182_0 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play222031045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 222031045
		arg_183_1.duration_ = 19.1

		local var_183_0 = {
			ja = 19.1,
			ko = 11.1,
			zh = 11.1
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
				arg_183_0:Play222031046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1074ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos1074ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(0, -1.055, -6.12)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1074ui_story, var_186_4, var_186_3)

				local var_186_5 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_5.x, var_186_5.y, var_186_5.z)

				local var_186_6 = var_186_0.localEulerAngles

				var_186_6.z = 0
				var_186_6.x = 0
				var_186_0.localEulerAngles = var_186_6
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_186_7 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_7.x, var_186_7.y, var_186_7.z)

				local var_186_8 = var_186_0.localEulerAngles

				var_186_8.z = 0
				var_186_8.x = 0
				var_186_0.localEulerAngles = var_186_8
			end

			local var_186_9 = arg_183_1.actors_["1074ui_story"]
			local var_186_10 = 0

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1074ui_story == nil then
				arg_183_1.var_.characterEffect1074ui_story = var_186_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_11 = 0.200000002980232

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_11 and not isNil(var_186_9) then
				local var_186_12 = (arg_183_1.time_ - var_186_10) / var_186_11

				if arg_183_1.var_.characterEffect1074ui_story and not isNil(var_186_9) then
					arg_183_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_10 + var_186_11 and arg_183_1.time_ < var_186_10 + var_186_11 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1074ui_story then
				arg_183_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_186_13 = 0

			if var_186_13 < arg_183_1.time_ and arg_183_1.time_ <= var_186_13 + arg_186_0 then
				arg_183_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074actionlink/1074action425")
			end

			local var_186_14 = 0

			if var_186_14 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				arg_183_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_186_15 = 0
			local var_186_16 = 1.05

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_17 = arg_183_1:FormatText(StoryNameCfg[410].name)

				arg_183_1.leftNameTxt_.text = var_186_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_18 = arg_183_1:GetWordFromCfg(222031045)
				local var_186_19 = arg_183_1:FormatText(var_186_18.content)

				arg_183_1.text_.text = var_186_19

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_20 = 42
				local var_186_21 = utf8.len(var_186_19)
				local var_186_22 = var_186_20 <= 0 and var_186_16 or var_186_16 * (var_186_21 / var_186_20)

				if var_186_22 > 0 and var_186_16 < var_186_22 then
					arg_183_1.talkMaxDuration = var_186_22

					if var_186_22 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_22 + var_186_15
					end
				end

				arg_183_1.text_.text = var_186_19
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031045", "story_v_out_222031.awb") ~= 0 then
					local var_186_23 = manager.audio:GetVoiceLength("story_v_out_222031", "222031045", "story_v_out_222031.awb") / 1000

					if var_186_23 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_23 + var_186_15
					end

					if var_186_18.prefab_name ~= "" and arg_183_1.actors_[var_186_18.prefab_name] ~= nil then
						local var_186_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_18.prefab_name].transform, "story_v_out_222031", "222031045", "story_v_out_222031.awb")

						arg_183_1:RecordAudio("222031045", var_186_24)
						arg_183_1:RecordAudio("222031045", var_186_24)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_222031", "222031045", "story_v_out_222031.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_222031", "222031045", "story_v_out_222031.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_25 = math.max(var_186_16, arg_183_1.talkMaxDuration)

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_25 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_15) / var_186_25

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_15 + var_186_25 and arg_183_1.time_ < var_186_15 + var_186_25 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play222031046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 222031046
		arg_187_1.duration_ = 14.9

		local var_187_0 = {
			ja = 14.9,
			ko = 8.9,
			zh = 8.9
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play222031047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1074ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1074ui_story == nil then
				arg_187_1.var_.characterEffect1074ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1074ui_story and not isNil(var_190_0) then
					local var_190_4 = Mathf.Lerp(0, 0.5, var_190_3)

					arg_187_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1074ui_story.fillRatio = var_190_4
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1074ui_story then
				local var_190_5 = 0.5

				arg_187_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1074ui_story.fillRatio = var_190_5
			end

			local var_190_6 = 0
			local var_190_7 = 0.85

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_8 = arg_187_1:FormatText(StoryNameCfg[461].name)

				arg_187_1.leftNameTxt_.text = var_190_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_9 = arg_187_1:GetWordFromCfg(222031046)
				local var_190_10 = arg_187_1:FormatText(var_190_9.content)

				arg_187_1.text_.text = var_190_10

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_11 = 34
				local var_190_12 = utf8.len(var_190_10)
				local var_190_13 = var_190_11 <= 0 and var_190_7 or var_190_7 * (var_190_12 / var_190_11)

				if var_190_13 > 0 and var_190_7 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_6
					end
				end

				arg_187_1.text_.text = var_190_10
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031046", "story_v_out_222031.awb") ~= 0 then
					local var_190_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031046", "story_v_out_222031.awb") / 1000

					if var_190_14 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_14 + var_190_6
					end

					if var_190_9.prefab_name ~= "" and arg_187_1.actors_[var_190_9.prefab_name] ~= nil then
						local var_190_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_9.prefab_name].transform, "story_v_out_222031", "222031046", "story_v_out_222031.awb")

						arg_187_1:RecordAudio("222031046", var_190_15)
						arg_187_1:RecordAudio("222031046", var_190_15)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_222031", "222031046", "story_v_out_222031.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_222031", "222031046", "story_v_out_222031.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_16 = math.max(var_190_7, arg_187_1.talkMaxDuration)

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_16 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_6) / var_190_16

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_6 + var_190_16 and arg_187_1.time_ < var_190_6 + var_190_16 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play222031047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 222031047
		arg_191_1.duration_ = 22.73

		local var_191_0 = {
			ja = 22.733,
			ko = 13.233,
			zh = 13.233
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
				arg_191_0:Play222031048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 1.25

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[461].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:GetWordFromCfg(222031047)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 50
				local var_194_6 = utf8.len(var_194_4)
				local var_194_7 = var_194_5 <= 0 and var_194_1 or var_194_1 * (var_194_6 / var_194_5)

				if var_194_7 > 0 and var_194_1 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_4
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031047", "story_v_out_222031.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031047", "story_v_out_222031.awb") / 1000

					if var_194_8 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_0
					end

					if var_194_3.prefab_name ~= "" and arg_191_1.actors_[var_194_3.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_3.prefab_name].transform, "story_v_out_222031", "222031047", "story_v_out_222031.awb")

						arg_191_1:RecordAudio("222031047", var_194_9)
						arg_191_1:RecordAudio("222031047", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_222031", "222031047", "story_v_out_222031.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_222031", "222031047", "story_v_out_222031.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_10 and arg_191_1.time_ < var_194_0 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play222031048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 222031048
		arg_195_1.duration_ = 16.33

		local var_195_0 = {
			ja = 16.333,
			ko = 10.333,
			zh = 10.5
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play222031049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.975

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[461].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:GetWordFromCfg(222031048)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 39
				local var_198_6 = utf8.len(var_198_4)
				local var_198_7 = var_198_5 <= 0 and var_198_1 or var_198_1 * (var_198_6 / var_198_5)

				if var_198_7 > 0 and var_198_1 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031048", "story_v_out_222031.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031048", "story_v_out_222031.awb") / 1000

					if var_198_8 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_0
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_222031", "222031048", "story_v_out_222031.awb")

						arg_195_1:RecordAudio("222031048", var_198_9)
						arg_195_1:RecordAudio("222031048", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_222031", "222031048", "story_v_out_222031.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_222031", "222031048", "story_v_out_222031.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_10 and arg_195_1.time_ < var_198_0 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play222031049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 222031049
		arg_199_1.duration_ = 9.77

		local var_199_0 = {
			ja = 9.766,
			ko = 4.566,
			zh = 4.6
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play222031050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1074ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1074ui_story == nil then
				arg_199_1.var_.characterEffect1074ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect1074ui_story and not isNil(var_202_0) then
					arg_199_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1074ui_story then
				arg_199_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_202_4 = 0
			local var_202_5 = 0.5

			if var_202_4 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_6 = arg_199_1:FormatText(StoryNameCfg[410].name)

				arg_199_1.leftNameTxt_.text = var_202_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_7 = arg_199_1:GetWordFromCfg(222031049)
				local var_202_8 = arg_199_1:FormatText(var_202_7.content)

				arg_199_1.text_.text = var_202_8

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 20
				local var_202_10 = utf8.len(var_202_8)
				local var_202_11 = var_202_9 <= 0 and var_202_5 or var_202_5 * (var_202_10 / var_202_9)

				if var_202_11 > 0 and var_202_5 < var_202_11 then
					arg_199_1.talkMaxDuration = var_202_11

					if var_202_11 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_11 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_8
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031049", "story_v_out_222031.awb") ~= 0 then
					local var_202_12 = manager.audio:GetVoiceLength("story_v_out_222031", "222031049", "story_v_out_222031.awb") / 1000

					if var_202_12 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_12 + var_202_4
					end

					if var_202_7.prefab_name ~= "" and arg_199_1.actors_[var_202_7.prefab_name] ~= nil then
						local var_202_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_7.prefab_name].transform, "story_v_out_222031", "222031049", "story_v_out_222031.awb")

						arg_199_1:RecordAudio("222031049", var_202_13)
						arg_199_1:RecordAudio("222031049", var_202_13)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_222031", "222031049", "story_v_out_222031.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_222031", "222031049", "story_v_out_222031.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_14 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_14 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_14

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_14 and arg_199_1.time_ < var_202_4 + var_202_14 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play222031050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 222031050
		arg_203_1.duration_ = 9.77

		local var_203_0 = {
			ja = 9.766,
			ko = 4.633,
			zh = 4.633
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play222031051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1074ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1074ui_story == nil then
				arg_203_1.var_.characterEffect1074ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect1074ui_story and not isNil(var_206_0) then
					local var_206_4 = Mathf.Lerp(0, 0.5, var_206_3)

					arg_203_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1074ui_story.fillRatio = var_206_4
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1074ui_story then
				local var_206_5 = 0.5

				arg_203_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1074ui_story.fillRatio = var_206_5
			end

			local var_206_6 = 0
			local var_206_7 = 0.4

			if var_206_6 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_8 = arg_203_1:FormatText(StoryNameCfg[461].name)

				arg_203_1.leftNameTxt_.text = var_206_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_9 = arg_203_1:GetWordFromCfg(222031050)
				local var_206_10 = arg_203_1:FormatText(var_206_9.content)

				arg_203_1.text_.text = var_206_10

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 16
				local var_206_12 = utf8.len(var_206_10)
				local var_206_13 = var_206_11 <= 0 and var_206_7 or var_206_7 * (var_206_12 / var_206_11)

				if var_206_13 > 0 and var_206_7 < var_206_13 then
					arg_203_1.talkMaxDuration = var_206_13

					if var_206_13 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_13 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_10
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031050", "story_v_out_222031.awb") ~= 0 then
					local var_206_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031050", "story_v_out_222031.awb") / 1000

					if var_206_14 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_14 + var_206_6
					end

					if var_206_9.prefab_name ~= "" and arg_203_1.actors_[var_206_9.prefab_name] ~= nil then
						local var_206_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_9.prefab_name].transform, "story_v_out_222031", "222031050", "story_v_out_222031.awb")

						arg_203_1:RecordAudio("222031050", var_206_15)
						arg_203_1:RecordAudio("222031050", var_206_15)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_222031", "222031050", "story_v_out_222031.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_222031", "222031050", "story_v_out_222031.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_16 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_16 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_16

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_16 and arg_203_1.time_ < var_206_6 + var_206_16 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play222031051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 222031051
		arg_207_1.duration_ = 15.2

		local var_207_0 = {
			ja = 15.2,
			ko = 13.366,
			zh = 13.3
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play222031052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 1.325

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[461].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:GetWordFromCfg(222031051)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 53
				local var_210_6 = utf8.len(var_210_4)
				local var_210_7 = var_210_5 <= 0 and var_210_1 or var_210_1 * (var_210_6 / var_210_5)

				if var_210_7 > 0 and var_210_1 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031051", "story_v_out_222031.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031051", "story_v_out_222031.awb") / 1000

					if var_210_8 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_0
					end

					if var_210_3.prefab_name ~= "" and arg_207_1.actors_[var_210_3.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_3.prefab_name].transform, "story_v_out_222031", "222031051", "story_v_out_222031.awb")

						arg_207_1:RecordAudio("222031051", var_210_9)
						arg_207_1:RecordAudio("222031051", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_222031", "222031051", "story_v_out_222031.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_222031", "222031051", "story_v_out_222031.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_10 and arg_207_1.time_ < var_210_0 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play222031052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 222031052
		arg_211_1.duration_ = 2.6

		local var_211_0 = {
			ja = 2.033,
			ko = 2.466,
			zh = 2.6
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play222031053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1074ui_story"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1074ui_story == nil then
				arg_211_1.var_.characterEffect1074ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.characterEffect1074ui_story and not isNil(var_214_0) then
					arg_211_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1074ui_story then
				arg_211_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_214_4 = 0

			if var_214_4 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_214_5 = 0
			local var_214_6 = 0.2

			if var_214_5 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_7 = arg_211_1:FormatText(StoryNameCfg[410].name)

				arg_211_1.leftNameTxt_.text = var_214_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_8 = arg_211_1:GetWordFromCfg(222031052)
				local var_214_9 = arg_211_1:FormatText(var_214_8.content)

				arg_211_1.text_.text = var_214_9

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_10 = 8
				local var_214_11 = utf8.len(var_214_9)
				local var_214_12 = var_214_10 <= 0 and var_214_6 or var_214_6 * (var_214_11 / var_214_10)

				if var_214_12 > 0 and var_214_6 < var_214_12 then
					arg_211_1.talkMaxDuration = var_214_12

					if var_214_12 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_12 + var_214_5
					end
				end

				arg_211_1.text_.text = var_214_9
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031052", "story_v_out_222031.awb") ~= 0 then
					local var_214_13 = manager.audio:GetVoiceLength("story_v_out_222031", "222031052", "story_v_out_222031.awb") / 1000

					if var_214_13 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_13 + var_214_5
					end

					if var_214_8.prefab_name ~= "" and arg_211_1.actors_[var_214_8.prefab_name] ~= nil then
						local var_214_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_8.prefab_name].transform, "story_v_out_222031", "222031052", "story_v_out_222031.awb")

						arg_211_1:RecordAudio("222031052", var_214_14)
						arg_211_1:RecordAudio("222031052", var_214_14)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_222031", "222031052", "story_v_out_222031.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_222031", "222031052", "story_v_out_222031.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_15 = math.max(var_214_6, arg_211_1.talkMaxDuration)

			if var_214_5 <= arg_211_1.time_ and arg_211_1.time_ < var_214_5 + var_214_15 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_5) / var_214_15

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_5 + var_214_15 and arg_211_1.time_ < var_214_5 + var_214_15 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play222031053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 222031053
		arg_215_1.duration_ = 12.3

		local var_215_0 = {
			ja = 10.933,
			ko = 12.3,
			zh = 12.3
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play222031054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1074ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1074ui_story == nil then
				arg_215_1.var_.characterEffect1074ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect1074ui_story and not isNil(var_218_0) then
					local var_218_4 = Mathf.Lerp(0, 0.5, var_218_3)

					arg_215_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1074ui_story.fillRatio = var_218_4
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1074ui_story then
				local var_218_5 = 0.5

				arg_215_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1074ui_story.fillRatio = var_218_5
			end

			local var_218_6 = 0
			local var_218_7 = 1.1

			if var_218_6 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_8 = arg_215_1:FormatText(StoryNameCfg[461].name)

				arg_215_1.leftNameTxt_.text = var_218_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_9 = arg_215_1:GetWordFromCfg(222031053)
				local var_218_10 = arg_215_1:FormatText(var_218_9.content)

				arg_215_1.text_.text = var_218_10

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_11 = 44
				local var_218_12 = utf8.len(var_218_10)
				local var_218_13 = var_218_11 <= 0 and var_218_7 or var_218_7 * (var_218_12 / var_218_11)

				if var_218_13 > 0 and var_218_7 < var_218_13 then
					arg_215_1.talkMaxDuration = var_218_13

					if var_218_13 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_13 + var_218_6
					end
				end

				arg_215_1.text_.text = var_218_10
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031053", "story_v_out_222031.awb") ~= 0 then
					local var_218_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031053", "story_v_out_222031.awb") / 1000

					if var_218_14 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_14 + var_218_6
					end

					if var_218_9.prefab_name ~= "" and arg_215_1.actors_[var_218_9.prefab_name] ~= nil then
						local var_218_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_9.prefab_name].transform, "story_v_out_222031", "222031053", "story_v_out_222031.awb")

						arg_215_1:RecordAudio("222031053", var_218_15)
						arg_215_1:RecordAudio("222031053", var_218_15)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_222031", "222031053", "story_v_out_222031.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_222031", "222031053", "story_v_out_222031.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_16 = math.max(var_218_7, arg_215_1.talkMaxDuration)

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_16 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_6) / var_218_16

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_6 + var_218_16 and arg_215_1.time_ < var_218_6 + var_218_16 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play222031054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 222031054
		arg_219_1.duration_ = 12.8

		local var_219_0 = {
			ja = 12.8,
			ko = 9.966,
			zh = 10
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play222031055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.725

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[461].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:GetWordFromCfg(222031054)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 29
				local var_222_6 = utf8.len(var_222_4)
				local var_222_7 = var_222_5 <= 0 and var_222_1 or var_222_1 * (var_222_6 / var_222_5)

				if var_222_7 > 0 and var_222_1 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031054", "story_v_out_222031.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031054", "story_v_out_222031.awb") / 1000

					if var_222_8 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_0
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_222031", "222031054", "story_v_out_222031.awb")

						arg_219_1:RecordAudio("222031054", var_222_9)
						arg_219_1:RecordAudio("222031054", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_222031", "222031054", "story_v_out_222031.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_222031", "222031054", "story_v_out_222031.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_10 and arg_219_1.time_ < var_222_0 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play222031055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 222031055
		arg_223_1.duration_ = 2.03

		local var_223_0 = {
			ja = 1.999999999999,
			ko = 2.033,
			zh = 2
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play222031056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1074ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1074ui_story == nil then
				arg_223_1.var_.characterEffect1074ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect1074ui_story and not isNil(var_226_0) then
					arg_223_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1074ui_story then
				arg_223_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_226_4 = 0

			if var_226_4 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			local var_226_5 = 0

			if var_226_5 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 then
				arg_223_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_226_6 = 0
			local var_226_7 = 0.225

			if var_226_6 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_8 = arg_223_1:FormatText(StoryNameCfg[410].name)

				arg_223_1.leftNameTxt_.text = var_226_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_9 = arg_223_1:GetWordFromCfg(222031055)
				local var_226_10 = arg_223_1:FormatText(var_226_9.content)

				arg_223_1.text_.text = var_226_10

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 9
				local var_226_12 = utf8.len(var_226_10)
				local var_226_13 = var_226_11 <= 0 and var_226_7 or var_226_7 * (var_226_12 / var_226_11)

				if var_226_13 > 0 and var_226_7 < var_226_13 then
					arg_223_1.talkMaxDuration = var_226_13

					if var_226_13 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_13 + var_226_6
					end
				end

				arg_223_1.text_.text = var_226_10
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031055", "story_v_out_222031.awb") ~= 0 then
					local var_226_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031055", "story_v_out_222031.awb") / 1000

					if var_226_14 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_14 + var_226_6
					end

					if var_226_9.prefab_name ~= "" and arg_223_1.actors_[var_226_9.prefab_name] ~= nil then
						local var_226_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_9.prefab_name].transform, "story_v_out_222031", "222031055", "story_v_out_222031.awb")

						arg_223_1:RecordAudio("222031055", var_226_15)
						arg_223_1:RecordAudio("222031055", var_226_15)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_222031", "222031055", "story_v_out_222031.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_222031", "222031055", "story_v_out_222031.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_16 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_16 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_16

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_16 and arg_223_1.time_ < var_226_6 + var_226_16 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play222031056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 222031056
		arg_227_1.duration_ = 18.13

		local var_227_0 = {
			ja = 18.133,
			ko = 12.333,
			zh = 12.333
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play222031057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1074ui_story"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1074ui_story == nil then
				arg_227_1.var_.characterEffect1074ui_story = var_230_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.characterEffect1074ui_story and not isNil(var_230_0) then
					local var_230_4 = Mathf.Lerp(0, 0.5, var_230_3)

					arg_227_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1074ui_story.fillRatio = var_230_4
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1074ui_story then
				local var_230_5 = 0.5

				arg_227_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1074ui_story.fillRatio = var_230_5
			end

			local var_230_6 = 0
			local var_230_7 = 1.125

			if var_230_6 < arg_227_1.time_ and arg_227_1.time_ <= var_230_6 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_8 = arg_227_1:FormatText(StoryNameCfg[461].name)

				arg_227_1.leftNameTxt_.text = var_230_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_9 = arg_227_1:GetWordFromCfg(222031056)
				local var_230_10 = arg_227_1:FormatText(var_230_9.content)

				arg_227_1.text_.text = var_230_10

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_11 = 45
				local var_230_12 = utf8.len(var_230_10)
				local var_230_13 = var_230_11 <= 0 and var_230_7 or var_230_7 * (var_230_12 / var_230_11)

				if var_230_13 > 0 and var_230_7 < var_230_13 then
					arg_227_1.talkMaxDuration = var_230_13

					if var_230_13 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_13 + var_230_6
					end
				end

				arg_227_1.text_.text = var_230_10
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031056", "story_v_out_222031.awb") ~= 0 then
					local var_230_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031056", "story_v_out_222031.awb") / 1000

					if var_230_14 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_14 + var_230_6
					end

					if var_230_9.prefab_name ~= "" and arg_227_1.actors_[var_230_9.prefab_name] ~= nil then
						local var_230_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_9.prefab_name].transform, "story_v_out_222031", "222031056", "story_v_out_222031.awb")

						arg_227_1:RecordAudio("222031056", var_230_15)
						arg_227_1:RecordAudio("222031056", var_230_15)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_222031", "222031056", "story_v_out_222031.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_222031", "222031056", "story_v_out_222031.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_16 = math.max(var_230_7, arg_227_1.talkMaxDuration)

			if var_230_6 <= arg_227_1.time_ and arg_227_1.time_ < var_230_6 + var_230_16 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_6) / var_230_16

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_6 + var_230_16 and arg_227_1.time_ < var_230_6 + var_230_16 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play222031057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 222031057
		arg_231_1.duration_ = 18.87

		local var_231_0 = {
			ja = 18.866,
			ko = 13.2,
			zh = 13.2
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play222031058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 1.2

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[461].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:GetWordFromCfg(222031057)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 48
				local var_234_6 = utf8.len(var_234_4)
				local var_234_7 = var_234_5 <= 0 and var_234_1 or var_234_1 * (var_234_6 / var_234_5)

				if var_234_7 > 0 and var_234_1 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_0
					end
				end

				arg_231_1.text_.text = var_234_4
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031057", "story_v_out_222031.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031057", "story_v_out_222031.awb") / 1000

					if var_234_8 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_0
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_out_222031", "222031057", "story_v_out_222031.awb")

						arg_231_1:RecordAudio("222031057", var_234_9)
						arg_231_1:RecordAudio("222031057", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_222031", "222031057", "story_v_out_222031.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_222031", "222031057", "story_v_out_222031.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_1, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_0) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_10 and arg_231_1.time_ < var_234_0 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play222031058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 222031058
		arg_235_1.duration_ = 14.43

		local var_235_0 = {
			ja = 14.066,
			ko = 14.4,
			zh = 14.433
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play222031059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 1.2

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_2 = arg_235_1:FormatText(StoryNameCfg[461].name)

				arg_235_1.leftNameTxt_.text = var_238_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_3 = arg_235_1:GetWordFromCfg(222031058)
				local var_238_4 = arg_235_1:FormatText(var_238_3.content)

				arg_235_1.text_.text = var_238_4

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 48
				local var_238_6 = utf8.len(var_238_4)
				local var_238_7 = var_238_5 <= 0 and var_238_1 or var_238_1 * (var_238_6 / var_238_5)

				if var_238_7 > 0 and var_238_1 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_4
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031058", "story_v_out_222031.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031058", "story_v_out_222031.awb") / 1000

					if var_238_8 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_0
					end

					if var_238_3.prefab_name ~= "" and arg_235_1.actors_[var_238_3.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_3.prefab_name].transform, "story_v_out_222031", "222031058", "story_v_out_222031.awb")

						arg_235_1:RecordAudio("222031058", var_238_9)
						arg_235_1:RecordAudio("222031058", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_222031", "222031058", "story_v_out_222031.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_222031", "222031058", "story_v_out_222031.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_10 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_10 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_10

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_10 and arg_235_1.time_ < var_238_0 + var_238_10 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play222031059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 222031059
		arg_239_1.duration_ = 3.43

		local var_239_0 = {
			ja = 3.433,
			ko = 2.833,
			zh = 2.9
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play222031060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1074ui_story"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1074ui_story == nil then
				arg_239_1.var_.characterEffect1074ui_story = var_242_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.characterEffect1074ui_story and not isNil(var_242_0) then
					arg_239_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1074ui_story then
				arg_239_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_242_4 = 0

			if var_242_4 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_242_5 = 0

			if var_242_5 < arg_239_1.time_ and arg_239_1.time_ <= var_242_5 + arg_242_0 then
				arg_239_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_242_6 = 0
			local var_242_7 = 0.25

			if var_242_6 < arg_239_1.time_ and arg_239_1.time_ <= var_242_6 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_8 = arg_239_1:FormatText(StoryNameCfg[410].name)

				arg_239_1.leftNameTxt_.text = var_242_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_9 = arg_239_1:GetWordFromCfg(222031059)
				local var_242_10 = arg_239_1:FormatText(var_242_9.content)

				arg_239_1.text_.text = var_242_10

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_11 = 10
				local var_242_12 = utf8.len(var_242_10)
				local var_242_13 = var_242_11 <= 0 and var_242_7 or var_242_7 * (var_242_12 / var_242_11)

				if var_242_13 > 0 and var_242_7 < var_242_13 then
					arg_239_1.talkMaxDuration = var_242_13

					if var_242_13 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_13 + var_242_6
					end
				end

				arg_239_1.text_.text = var_242_10
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031059", "story_v_out_222031.awb") ~= 0 then
					local var_242_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031059", "story_v_out_222031.awb") / 1000

					if var_242_14 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_14 + var_242_6
					end

					if var_242_9.prefab_name ~= "" and arg_239_1.actors_[var_242_9.prefab_name] ~= nil then
						local var_242_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_9.prefab_name].transform, "story_v_out_222031", "222031059", "story_v_out_222031.awb")

						arg_239_1:RecordAudio("222031059", var_242_15)
						arg_239_1:RecordAudio("222031059", var_242_15)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_222031", "222031059", "story_v_out_222031.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_222031", "222031059", "story_v_out_222031.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_16 = math.max(var_242_7, arg_239_1.talkMaxDuration)

			if var_242_6 <= arg_239_1.time_ and arg_239_1.time_ < var_242_6 + var_242_16 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_6) / var_242_16

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_6 + var_242_16 and arg_239_1.time_ < var_242_6 + var_242_16 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play222031060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 222031060
		arg_243_1.duration_ = 6.2

		local var_243_0 = {
			ja = 6.2,
			ko = 5.066,
			zh = 5.066
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play222031061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1074ui_story"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1074ui_story == nil then
				arg_243_1.var_.characterEffect1074ui_story = var_246_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.characterEffect1074ui_story and not isNil(var_246_0) then
					local var_246_4 = Mathf.Lerp(0, 0.5, var_246_3)

					arg_243_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1074ui_story.fillRatio = var_246_4
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1074ui_story then
				local var_246_5 = 0.5

				arg_243_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1074ui_story.fillRatio = var_246_5
			end

			local var_246_6 = 0
			local var_246_7 = 0.35

			if var_246_6 < arg_243_1.time_ and arg_243_1.time_ <= var_246_6 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_8 = arg_243_1:FormatText(StoryNameCfg[461].name)

				arg_243_1.leftNameTxt_.text = var_246_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_9 = arg_243_1:GetWordFromCfg(222031060)
				local var_246_10 = arg_243_1:FormatText(var_246_9.content)

				arg_243_1.text_.text = var_246_10

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_11 = 14
				local var_246_12 = utf8.len(var_246_10)
				local var_246_13 = var_246_11 <= 0 and var_246_7 or var_246_7 * (var_246_12 / var_246_11)

				if var_246_13 > 0 and var_246_7 < var_246_13 then
					arg_243_1.talkMaxDuration = var_246_13

					if var_246_13 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_13 + var_246_6
					end
				end

				arg_243_1.text_.text = var_246_10
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031060", "story_v_out_222031.awb") ~= 0 then
					local var_246_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031060", "story_v_out_222031.awb") / 1000

					if var_246_14 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_14 + var_246_6
					end

					if var_246_9.prefab_name ~= "" and arg_243_1.actors_[var_246_9.prefab_name] ~= nil then
						local var_246_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_9.prefab_name].transform, "story_v_out_222031", "222031060", "story_v_out_222031.awb")

						arg_243_1:RecordAudio("222031060", var_246_15)
						arg_243_1:RecordAudio("222031060", var_246_15)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_222031", "222031060", "story_v_out_222031.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_222031", "222031060", "story_v_out_222031.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_16 = math.max(var_246_7, arg_243_1.talkMaxDuration)

			if var_246_6 <= arg_243_1.time_ and arg_243_1.time_ < var_246_6 + var_246_16 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_6) / var_246_16

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_6 + var_246_16 and arg_243_1.time_ < var_246_6 + var_246_16 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play222031061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 222031061
		arg_247_1.duration_ = 2.23

		local var_247_0 = {
			ja = 2.233,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play222031062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1074ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1074ui_story == nil then
				arg_247_1.var_.characterEffect1074ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect1074ui_story and not isNil(var_250_0) then
					arg_247_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1074ui_story then
				arg_247_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_250_4 = 0

			if var_250_4 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_250_5 = 0

			if var_250_5 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 then
				arg_247_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_250_6 = 0
			local var_250_7 = 0.1

			if var_250_6 < arg_247_1.time_ and arg_247_1.time_ <= var_250_6 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_8 = arg_247_1:FormatText(StoryNameCfg[410].name)

				arg_247_1.leftNameTxt_.text = var_250_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_9 = arg_247_1:GetWordFromCfg(222031061)
				local var_250_10 = arg_247_1:FormatText(var_250_9.content)

				arg_247_1.text_.text = var_250_10

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_11 = 4
				local var_250_12 = utf8.len(var_250_10)
				local var_250_13 = var_250_11 <= 0 and var_250_7 or var_250_7 * (var_250_12 / var_250_11)

				if var_250_13 > 0 and var_250_7 < var_250_13 then
					arg_247_1.talkMaxDuration = var_250_13

					if var_250_13 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_13 + var_250_6
					end
				end

				arg_247_1.text_.text = var_250_10
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031061", "story_v_out_222031.awb") ~= 0 then
					local var_250_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031061", "story_v_out_222031.awb") / 1000

					if var_250_14 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_14 + var_250_6
					end

					if var_250_9.prefab_name ~= "" and arg_247_1.actors_[var_250_9.prefab_name] ~= nil then
						local var_250_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_9.prefab_name].transform, "story_v_out_222031", "222031061", "story_v_out_222031.awb")

						arg_247_1:RecordAudio("222031061", var_250_15)
						arg_247_1:RecordAudio("222031061", var_250_15)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_222031", "222031061", "story_v_out_222031.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_222031", "222031061", "story_v_out_222031.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_16 = math.max(var_250_7, arg_247_1.talkMaxDuration)

			if var_250_6 <= arg_247_1.time_ and arg_247_1.time_ < var_250_6 + var_250_16 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_6) / var_250_16

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_6 + var_250_16 and arg_247_1.time_ < var_250_6 + var_250_16 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play222031062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 222031062
		arg_251_1.duration_ = 10.03

		local var_251_0 = {
			ja = 9.466,
			ko = 10.033,
			zh = 10.033
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play222031063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1074ui_story"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1074ui_story == nil then
				arg_251_1.var_.characterEffect1074ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.characterEffect1074ui_story and not isNil(var_254_0) then
					local var_254_4 = Mathf.Lerp(0, 0.5, var_254_3)

					arg_251_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1074ui_story.fillRatio = var_254_4
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1074ui_story then
				local var_254_5 = 0.5

				arg_251_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1074ui_story.fillRatio = var_254_5
			end

			local var_254_6 = 0
			local var_254_7 = 0.975

			if var_254_6 < arg_251_1.time_ and arg_251_1.time_ <= var_254_6 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_8 = arg_251_1:FormatText(StoryNameCfg[461].name)

				arg_251_1.leftNameTxt_.text = var_254_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_9 = arg_251_1:GetWordFromCfg(222031062)
				local var_254_10 = arg_251_1:FormatText(var_254_9.content)

				arg_251_1.text_.text = var_254_10

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_11 = 39
				local var_254_12 = utf8.len(var_254_10)
				local var_254_13 = var_254_11 <= 0 and var_254_7 or var_254_7 * (var_254_12 / var_254_11)

				if var_254_13 > 0 and var_254_7 < var_254_13 then
					arg_251_1.talkMaxDuration = var_254_13

					if var_254_13 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_13 + var_254_6
					end
				end

				arg_251_1.text_.text = var_254_10
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031062", "story_v_out_222031.awb") ~= 0 then
					local var_254_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031062", "story_v_out_222031.awb") / 1000

					if var_254_14 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_14 + var_254_6
					end

					if var_254_9.prefab_name ~= "" and arg_251_1.actors_[var_254_9.prefab_name] ~= nil then
						local var_254_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_9.prefab_name].transform, "story_v_out_222031", "222031062", "story_v_out_222031.awb")

						arg_251_1:RecordAudio("222031062", var_254_15)
						arg_251_1:RecordAudio("222031062", var_254_15)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_222031", "222031062", "story_v_out_222031.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_222031", "222031062", "story_v_out_222031.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_16 = math.max(var_254_7, arg_251_1.talkMaxDuration)

			if var_254_6 <= arg_251_1.time_ and arg_251_1.time_ < var_254_6 + var_254_16 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_6) / var_254_16

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_6 + var_254_16 and arg_251_1.time_ < var_254_6 + var_254_16 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play222031063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 222031063
		arg_255_1.duration_ = 14.43

		local var_255_0 = {
			ja = 14.433,
			ko = 7.566,
			zh = 7.566
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play222031064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.675

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_2 = arg_255_1:FormatText(StoryNameCfg[461].name)

				arg_255_1.leftNameTxt_.text = var_258_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:GetWordFromCfg(222031063)
				local var_258_4 = arg_255_1:FormatText(var_258_3.content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 27
				local var_258_6 = utf8.len(var_258_4)
				local var_258_7 = var_258_5 <= 0 and var_258_1 or var_258_1 * (var_258_6 / var_258_5)

				if var_258_7 > 0 and var_258_1 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031063", "story_v_out_222031.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031063", "story_v_out_222031.awb") / 1000

					if var_258_8 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_0
					end

					if var_258_3.prefab_name ~= "" and arg_255_1.actors_[var_258_3.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_3.prefab_name].transform, "story_v_out_222031", "222031063", "story_v_out_222031.awb")

						arg_255_1:RecordAudio("222031063", var_258_9)
						arg_255_1:RecordAudio("222031063", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_222031", "222031063", "story_v_out_222031.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_222031", "222031063", "story_v_out_222031.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 <= arg_255_1.time_ and arg_255_1.time_ < var_258_0 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_0) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_0 + var_258_10 and arg_255_1.time_ < var_258_0 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play222031064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 222031064
		arg_259_1.duration_ = 9.07

		local var_259_0 = {
			ja = 9.066,
			ko = 7.433,
			zh = 7.433
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play222031065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1074ui_story"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1074ui_story == nil then
				arg_259_1.var_.characterEffect1074ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.characterEffect1074ui_story and not isNil(var_262_0) then
					arg_259_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1074ui_story then
				arg_259_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_262_4 = 0

			if var_262_4 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action6_1")
			end

			local var_262_5 = 0

			if var_262_5 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 then
				arg_259_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_262_6 = 0
			local var_262_7 = 0.85

			if var_262_6 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_8 = arg_259_1:FormatText(StoryNameCfg[410].name)

				arg_259_1.leftNameTxt_.text = var_262_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_9 = arg_259_1:GetWordFromCfg(222031064)
				local var_262_10 = arg_259_1:FormatText(var_262_9.content)

				arg_259_1.text_.text = var_262_10

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_11 = 34
				local var_262_12 = utf8.len(var_262_10)
				local var_262_13 = var_262_11 <= 0 and var_262_7 or var_262_7 * (var_262_12 / var_262_11)

				if var_262_13 > 0 and var_262_7 < var_262_13 then
					arg_259_1.talkMaxDuration = var_262_13

					if var_262_13 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_13 + var_262_6
					end
				end

				arg_259_1.text_.text = var_262_10
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031064", "story_v_out_222031.awb") ~= 0 then
					local var_262_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031064", "story_v_out_222031.awb") / 1000

					if var_262_14 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_14 + var_262_6
					end

					if var_262_9.prefab_name ~= "" and arg_259_1.actors_[var_262_9.prefab_name] ~= nil then
						local var_262_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_9.prefab_name].transform, "story_v_out_222031", "222031064", "story_v_out_222031.awb")

						arg_259_1:RecordAudio("222031064", var_262_15)
						arg_259_1:RecordAudio("222031064", var_262_15)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_222031", "222031064", "story_v_out_222031.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_222031", "222031064", "story_v_out_222031.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_16 = math.max(var_262_7, arg_259_1.talkMaxDuration)

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_16 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_6) / var_262_16

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_6 + var_262_16 and arg_259_1.time_ < var_262_6 + var_262_16 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play222031065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 222031065
		arg_263_1.duration_ = 10.67

		local var_263_0 = {
			ja = 10.666,
			ko = 5.8,
			zh = 6
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play222031066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0
			local var_266_1 = 0.85

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_2 = arg_263_1:FormatText(StoryNameCfg[410].name)

				arg_263_1.leftNameTxt_.text = var_266_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_3 = arg_263_1:GetWordFromCfg(222031065)
				local var_266_4 = arg_263_1:FormatText(var_266_3.content)

				arg_263_1.text_.text = var_266_4

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 34
				local var_266_6 = utf8.len(var_266_4)
				local var_266_7 = var_266_5 <= 0 and var_266_1 or var_266_1 * (var_266_6 / var_266_5)

				if var_266_7 > 0 and var_266_1 < var_266_7 then
					arg_263_1.talkMaxDuration = var_266_7

					if var_266_7 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_0
					end
				end

				arg_263_1.text_.text = var_266_4
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031065", "story_v_out_222031.awb") ~= 0 then
					local var_266_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031065", "story_v_out_222031.awb") / 1000

					if var_266_8 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_8 + var_266_0
					end

					if var_266_3.prefab_name ~= "" and arg_263_1.actors_[var_266_3.prefab_name] ~= nil then
						local var_266_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_3.prefab_name].transform, "story_v_out_222031", "222031065", "story_v_out_222031.awb")

						arg_263_1:RecordAudio("222031065", var_266_9)
						arg_263_1:RecordAudio("222031065", var_266_9)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_222031", "222031065", "story_v_out_222031.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_222031", "222031065", "story_v_out_222031.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_10 = math.max(var_266_1, arg_263_1.talkMaxDuration)

			if var_266_0 <= arg_263_1.time_ and arg_263_1.time_ < var_266_0 + var_266_10 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_0) / var_266_10

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_0 + var_266_10 and arg_263_1.time_ < var_266_0 + var_266_10 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play222031066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 222031066
		arg_267_1.duration_ = 10.73

		local var_267_0 = {
			ja = 10.733,
			ko = 7.166,
			zh = 7.2
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play222031067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 0.75

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_2 = arg_267_1:FormatText(StoryNameCfg[410].name)

				arg_267_1.leftNameTxt_.text = var_270_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_3 = arg_267_1:GetWordFromCfg(222031066)
				local var_270_4 = arg_267_1:FormatText(var_270_3.content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 30
				local var_270_6 = utf8.len(var_270_4)
				local var_270_7 = var_270_5 <= 0 and var_270_1 or var_270_1 * (var_270_6 / var_270_5)

				if var_270_7 > 0 and var_270_1 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_4
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031066", "story_v_out_222031.awb") ~= 0 then
					local var_270_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031066", "story_v_out_222031.awb") / 1000

					if var_270_8 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_8 + var_270_0
					end

					if var_270_3.prefab_name ~= "" and arg_267_1.actors_[var_270_3.prefab_name] ~= nil then
						local var_270_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_3.prefab_name].transform, "story_v_out_222031", "222031066", "story_v_out_222031.awb")

						arg_267_1:RecordAudio("222031066", var_270_9)
						arg_267_1:RecordAudio("222031066", var_270_9)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_222031", "222031066", "story_v_out_222031.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_222031", "222031066", "story_v_out_222031.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_10 and arg_267_1.time_ < var_270_0 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play222031067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 222031067
		arg_271_1.duration_ = 13.37

		local var_271_0 = {
			ja = 13.366,
			ko = 10.9,
			zh = 10.933
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play222031068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1074ui_story"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1074ui_story == nil then
				arg_271_1.var_.characterEffect1074ui_story = var_274_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.characterEffect1074ui_story and not isNil(var_274_0) then
					local var_274_4 = Mathf.Lerp(0, 0.5, var_274_3)

					arg_271_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1074ui_story.fillRatio = var_274_4
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1074ui_story then
				local var_274_5 = 0.5

				arg_271_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1074ui_story.fillRatio = var_274_5
			end

			local var_274_6 = 0
			local var_274_7 = 0.85

			if var_274_6 < arg_271_1.time_ and arg_271_1.time_ <= var_274_6 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_8 = arg_271_1:FormatText(StoryNameCfg[461].name)

				arg_271_1.leftNameTxt_.text = var_274_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_9 = arg_271_1:GetWordFromCfg(222031067)
				local var_274_10 = arg_271_1:FormatText(var_274_9.content)

				arg_271_1.text_.text = var_274_10

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_11 = 34
				local var_274_12 = utf8.len(var_274_10)
				local var_274_13 = var_274_11 <= 0 and var_274_7 or var_274_7 * (var_274_12 / var_274_11)

				if var_274_13 > 0 and var_274_7 < var_274_13 then
					arg_271_1.talkMaxDuration = var_274_13

					if var_274_13 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_13 + var_274_6
					end
				end

				arg_271_1.text_.text = var_274_10
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031067", "story_v_out_222031.awb") ~= 0 then
					local var_274_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031067", "story_v_out_222031.awb") / 1000

					if var_274_14 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_14 + var_274_6
					end

					if var_274_9.prefab_name ~= "" and arg_271_1.actors_[var_274_9.prefab_name] ~= nil then
						local var_274_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_9.prefab_name].transform, "story_v_out_222031", "222031067", "story_v_out_222031.awb")

						arg_271_1:RecordAudio("222031067", var_274_15)
						arg_271_1:RecordAudio("222031067", var_274_15)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_222031", "222031067", "story_v_out_222031.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_222031", "222031067", "story_v_out_222031.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_16 = math.max(var_274_7, arg_271_1.talkMaxDuration)

			if var_274_6 <= arg_271_1.time_ and arg_271_1.time_ < var_274_6 + var_274_16 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_6) / var_274_16

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_6 + var_274_16 and arg_271_1.time_ < var_274_6 + var_274_16 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play222031068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 222031068
		arg_275_1.duration_ = 6.13

		local var_275_0 = {
			ja = 6.133,
			ko = 5.933,
			zh = 5.933
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play222031069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0
			local var_278_1 = 0.6

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_2 = arg_275_1:FormatText(StoryNameCfg[461].name)

				arg_275_1.leftNameTxt_.text = var_278_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_3 = arg_275_1:GetWordFromCfg(222031068)
				local var_278_4 = arg_275_1:FormatText(var_278_3.content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 25
				local var_278_6 = utf8.len(var_278_4)
				local var_278_7 = var_278_5 <= 0 and var_278_1 or var_278_1 * (var_278_6 / var_278_5)

				if var_278_7 > 0 and var_278_1 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_0
					end
				end

				arg_275_1.text_.text = var_278_4
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031068", "story_v_out_222031.awb") ~= 0 then
					local var_278_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031068", "story_v_out_222031.awb") / 1000

					if var_278_8 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_0
					end

					if var_278_3.prefab_name ~= "" and arg_275_1.actors_[var_278_3.prefab_name] ~= nil then
						local var_278_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_3.prefab_name].transform, "story_v_out_222031", "222031068", "story_v_out_222031.awb")

						arg_275_1:RecordAudio("222031068", var_278_9)
						arg_275_1:RecordAudio("222031068", var_278_9)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_222031", "222031068", "story_v_out_222031.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_222031", "222031068", "story_v_out_222031.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_10 = math.max(var_278_1, arg_275_1.talkMaxDuration)

			if var_278_0 <= arg_275_1.time_ and arg_275_1.time_ < var_278_0 + var_278_10 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_0) / var_278_10

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_0 + var_278_10 and arg_275_1.time_ < var_278_0 + var_278_10 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play222031069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 222031069
		arg_279_1.duration_ = 5.53

		local var_279_0 = {
			ja = 5.533,
			ko = 3.9,
			zh = 4.066
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play222031070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1074ui_story"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1074ui_story == nil then
				arg_279_1.var_.characterEffect1074ui_story = var_282_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.characterEffect1074ui_story and not isNil(var_282_0) then
					arg_279_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1074ui_story then
				arg_279_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_282_4 = 0

			if var_282_4 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action6_2")
			end

			local var_282_5 = 0

			if var_282_5 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_282_6 = 0
			local var_282_7 = 0.425

			if var_282_6 < arg_279_1.time_ and arg_279_1.time_ <= var_282_6 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_8 = arg_279_1:FormatText(StoryNameCfg[410].name)

				arg_279_1.leftNameTxt_.text = var_282_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_9 = arg_279_1:GetWordFromCfg(222031069)
				local var_282_10 = arg_279_1:FormatText(var_282_9.content)

				arg_279_1.text_.text = var_282_10

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_11 = 17
				local var_282_12 = utf8.len(var_282_10)
				local var_282_13 = var_282_11 <= 0 and var_282_7 or var_282_7 * (var_282_12 / var_282_11)

				if var_282_13 > 0 and var_282_7 < var_282_13 then
					arg_279_1.talkMaxDuration = var_282_13

					if var_282_13 + var_282_6 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_13 + var_282_6
					end
				end

				arg_279_1.text_.text = var_282_10
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031069", "story_v_out_222031.awb") ~= 0 then
					local var_282_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031069", "story_v_out_222031.awb") / 1000

					if var_282_14 + var_282_6 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_14 + var_282_6
					end

					if var_282_9.prefab_name ~= "" and arg_279_1.actors_[var_282_9.prefab_name] ~= nil then
						local var_282_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_9.prefab_name].transform, "story_v_out_222031", "222031069", "story_v_out_222031.awb")

						arg_279_1:RecordAudio("222031069", var_282_15)
						arg_279_1:RecordAudio("222031069", var_282_15)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_222031", "222031069", "story_v_out_222031.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_222031", "222031069", "story_v_out_222031.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_16 = math.max(var_282_7, arg_279_1.talkMaxDuration)

			if var_282_6 <= arg_279_1.time_ and arg_279_1.time_ < var_282_6 + var_282_16 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_6) / var_282_16

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_6 + var_282_16 and arg_279_1.time_ < var_282_6 + var_282_16 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play222031070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 222031070
		arg_283_1.duration_ = 8.77

		local var_283_0 = {
			ja = 8.766,
			ko = 7.533,
			zh = 7.533
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play222031071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1074ui_story"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1074ui_story == nil then
				arg_283_1.var_.characterEffect1074ui_story = var_286_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.characterEffect1074ui_story and not isNil(var_286_0) then
					local var_286_4 = Mathf.Lerp(0, 0.5, var_286_3)

					arg_283_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1074ui_story.fillRatio = var_286_4
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1074ui_story then
				local var_286_5 = 0.5

				arg_283_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1074ui_story.fillRatio = var_286_5
			end

			local var_286_6 = 0
			local var_286_7 = 0.75

			if var_286_6 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_8 = arg_283_1:FormatText(StoryNameCfg[461].name)

				arg_283_1.leftNameTxt_.text = var_286_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_9 = arg_283_1:GetWordFromCfg(222031070)
				local var_286_10 = arg_283_1:FormatText(var_286_9.content)

				arg_283_1.text_.text = var_286_10

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_11 = 30
				local var_286_12 = utf8.len(var_286_10)
				local var_286_13 = var_286_11 <= 0 and var_286_7 or var_286_7 * (var_286_12 / var_286_11)

				if var_286_13 > 0 and var_286_7 < var_286_13 then
					arg_283_1.talkMaxDuration = var_286_13

					if var_286_13 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_13 + var_286_6
					end
				end

				arg_283_1.text_.text = var_286_10
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031070", "story_v_out_222031.awb") ~= 0 then
					local var_286_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031070", "story_v_out_222031.awb") / 1000

					if var_286_14 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_14 + var_286_6
					end

					if var_286_9.prefab_name ~= "" and arg_283_1.actors_[var_286_9.prefab_name] ~= nil then
						local var_286_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_9.prefab_name].transform, "story_v_out_222031", "222031070", "story_v_out_222031.awb")

						arg_283_1:RecordAudio("222031070", var_286_15)
						arg_283_1:RecordAudio("222031070", var_286_15)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_222031", "222031070", "story_v_out_222031.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_222031", "222031070", "story_v_out_222031.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_16 = math.max(var_286_7, arg_283_1.talkMaxDuration)

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_16 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_6) / var_286_16

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_6 + var_286_16 and arg_283_1.time_ < var_286_6 + var_286_16 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play222031071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 222031071
		arg_287_1.duration_ = 7.83

		local var_287_0 = {
			ja = 7.833,
			ko = 4.666,
			zh = 4.666
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
				arg_287_0:Play222031072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0
			local var_290_1 = 0.425

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_2 = arg_287_1:FormatText(StoryNameCfg[461].name)

				arg_287_1.leftNameTxt_.text = var_290_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_3 = arg_287_1:GetWordFromCfg(222031071)
				local var_290_4 = arg_287_1:FormatText(var_290_3.content)

				arg_287_1.text_.text = var_290_4

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 17
				local var_290_6 = utf8.len(var_290_4)
				local var_290_7 = var_290_5 <= 0 and var_290_1 or var_290_1 * (var_290_6 / var_290_5)

				if var_290_7 > 0 and var_290_1 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_0
					end
				end

				arg_287_1.text_.text = var_290_4
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031071", "story_v_out_222031.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031071", "story_v_out_222031.awb") / 1000

					if var_290_8 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_0
					end

					if var_290_3.prefab_name ~= "" and arg_287_1.actors_[var_290_3.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_3.prefab_name].transform, "story_v_out_222031", "222031071", "story_v_out_222031.awb")

						arg_287_1:RecordAudio("222031071", var_290_9)
						arg_287_1:RecordAudio("222031071", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_222031", "222031071", "story_v_out_222031.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_222031", "222031071", "story_v_out_222031.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_1, arg_287_1.talkMaxDuration)

			if var_290_0 <= arg_287_1.time_ and arg_287_1.time_ < var_290_0 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_0) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_0 + var_290_10 and arg_287_1.time_ < var_290_0 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play222031072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 222031072
		arg_291_1.duration_ = 14.1

		local var_291_0 = {
			ja = 14.1,
			ko = 13.333,
			zh = 13.466
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play222031073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0
			local var_294_1 = 1.25

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_2 = arg_291_1:FormatText(StoryNameCfg[461].name)

				arg_291_1.leftNameTxt_.text = var_294_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_3 = arg_291_1:GetWordFromCfg(222031072)
				local var_294_4 = arg_291_1:FormatText(var_294_3.content)

				arg_291_1.text_.text = var_294_4

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 50
				local var_294_6 = utf8.len(var_294_4)
				local var_294_7 = var_294_5 <= 0 and var_294_1 or var_294_1 * (var_294_6 / var_294_5)

				if var_294_7 > 0 and var_294_1 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_4
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031072", "story_v_out_222031.awb") ~= 0 then
					local var_294_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031072", "story_v_out_222031.awb") / 1000

					if var_294_8 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_0
					end

					if var_294_3.prefab_name ~= "" and arg_291_1.actors_[var_294_3.prefab_name] ~= nil then
						local var_294_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_3.prefab_name].transform, "story_v_out_222031", "222031072", "story_v_out_222031.awb")

						arg_291_1:RecordAudio("222031072", var_294_9)
						arg_291_1:RecordAudio("222031072", var_294_9)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_222031", "222031072", "story_v_out_222031.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_222031", "222031072", "story_v_out_222031.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_10 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_10 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_10

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_10 and arg_291_1.time_ < var_294_0 + var_294_10 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play222031073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 222031073
		arg_295_1.duration_ = 14.77

		local var_295_0 = {
			ja = 14.766,
			ko = 13.133,
			zh = 13.166
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play222031074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 1.225

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_2 = arg_295_1:FormatText(StoryNameCfg[461].name)

				arg_295_1.leftNameTxt_.text = var_298_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_3 = arg_295_1:GetWordFromCfg(222031073)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 49
				local var_298_6 = utf8.len(var_298_4)
				local var_298_7 = var_298_5 <= 0 and var_298_1 or var_298_1 * (var_298_6 / var_298_5)

				if var_298_7 > 0 and var_298_1 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031073", "story_v_out_222031.awb") ~= 0 then
					local var_298_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031073", "story_v_out_222031.awb") / 1000

					if var_298_8 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_0
					end

					if var_298_3.prefab_name ~= "" and arg_295_1.actors_[var_298_3.prefab_name] ~= nil then
						local var_298_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_3.prefab_name].transform, "story_v_out_222031", "222031073", "story_v_out_222031.awb")

						arg_295_1:RecordAudio("222031073", var_298_9)
						arg_295_1:RecordAudio("222031073", var_298_9)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_222031", "222031073", "story_v_out_222031.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_222031", "222031073", "story_v_out_222031.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_10 and arg_295_1.time_ < var_298_0 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play222031074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 222031074
		arg_299_1.duration_ = 8.3

		local var_299_0 = {
			ja = 8.3,
			ko = 3.7,
			zh = 3.733
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play222031075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1074ui_story"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1074ui_story == nil then
				arg_299_1.var_.characterEffect1074ui_story = var_302_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.characterEffect1074ui_story and not isNil(var_302_0) then
					arg_299_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1074ui_story then
				arg_299_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_302_4 = 0

			if var_302_4 < arg_299_1.time_ and arg_299_1.time_ <= var_302_4 + arg_302_0 then
				arg_299_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_302_5 = 0

			if var_302_5 < arg_299_1.time_ and arg_299_1.time_ <= var_302_5 + arg_302_0 then
				arg_299_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_302_6 = 0
			local var_302_7 = 0.4

			if var_302_6 < arg_299_1.time_ and arg_299_1.time_ <= var_302_6 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_8 = arg_299_1:FormatText(StoryNameCfg[410].name)

				arg_299_1.leftNameTxt_.text = var_302_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_9 = arg_299_1:GetWordFromCfg(222031074)
				local var_302_10 = arg_299_1:FormatText(var_302_9.content)

				arg_299_1.text_.text = var_302_10

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_11 = 16
				local var_302_12 = utf8.len(var_302_10)
				local var_302_13 = var_302_11 <= 0 and var_302_7 or var_302_7 * (var_302_12 / var_302_11)

				if var_302_13 > 0 and var_302_7 < var_302_13 then
					arg_299_1.talkMaxDuration = var_302_13

					if var_302_13 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_13 + var_302_6
					end
				end

				arg_299_1.text_.text = var_302_10
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031074", "story_v_out_222031.awb") ~= 0 then
					local var_302_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031074", "story_v_out_222031.awb") / 1000

					if var_302_14 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_14 + var_302_6
					end

					if var_302_9.prefab_name ~= "" and arg_299_1.actors_[var_302_9.prefab_name] ~= nil then
						local var_302_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_9.prefab_name].transform, "story_v_out_222031", "222031074", "story_v_out_222031.awb")

						arg_299_1:RecordAudio("222031074", var_302_15)
						arg_299_1:RecordAudio("222031074", var_302_15)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_222031", "222031074", "story_v_out_222031.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_222031", "222031074", "story_v_out_222031.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_16 = math.max(var_302_7, arg_299_1.talkMaxDuration)

			if var_302_6 <= arg_299_1.time_ and arg_299_1.time_ < var_302_6 + var_302_16 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_6) / var_302_16

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_6 + var_302_16 and arg_299_1.time_ < var_302_6 + var_302_16 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play222031075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 222031075
		arg_303_1.duration_ = 17.27

		local var_303_0 = {
			ja = 17.266,
			ko = 10.9,
			zh = 10.933
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
				arg_303_0:Play222031076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1074ui_story"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1074ui_story == nil then
				arg_303_1.var_.characterEffect1074ui_story = var_306_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.characterEffect1074ui_story and not isNil(var_306_0) then
					local var_306_4 = Mathf.Lerp(0, 0.5, var_306_3)

					arg_303_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1074ui_story.fillRatio = var_306_4
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1074ui_story then
				local var_306_5 = 0.5

				arg_303_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1074ui_story.fillRatio = var_306_5
			end

			local var_306_6 = 0
			local var_306_7 = 0.975

			if var_306_6 < arg_303_1.time_ and arg_303_1.time_ <= var_306_6 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_8 = arg_303_1:FormatText(StoryNameCfg[461].name)

				arg_303_1.leftNameTxt_.text = var_306_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_9 = arg_303_1:GetWordFromCfg(222031075)
				local var_306_10 = arg_303_1:FormatText(var_306_9.content)

				arg_303_1.text_.text = var_306_10

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_11 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031075", "story_v_out_222031.awb") ~= 0 then
					local var_306_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031075", "story_v_out_222031.awb") / 1000

					if var_306_14 + var_306_6 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_14 + var_306_6
					end

					if var_306_9.prefab_name ~= "" and arg_303_1.actors_[var_306_9.prefab_name] ~= nil then
						local var_306_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_9.prefab_name].transform, "story_v_out_222031", "222031075", "story_v_out_222031.awb")

						arg_303_1:RecordAudio("222031075", var_306_15)
						arg_303_1:RecordAudio("222031075", var_306_15)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_222031", "222031075", "story_v_out_222031.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_222031", "222031075", "story_v_out_222031.awb")
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
	Play222031076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 222031076
		arg_307_1.duration_ = 13.73

		local var_307_0 = {
			ja = 13.733,
			ko = 9.966,
			zh = 10
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
				arg_307_0:Play222031077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0
			local var_310_1 = 1

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_2 = arg_307_1:FormatText(StoryNameCfg[461].name)

				arg_307_1.leftNameTxt_.text = var_310_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_3 = arg_307_1:GetWordFromCfg(222031076)
				local var_310_4 = arg_307_1:FormatText(var_310_3.content)

				arg_307_1.text_.text = var_310_4

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 40
				local var_310_6 = utf8.len(var_310_4)
				local var_310_7 = var_310_5 <= 0 and var_310_1 or var_310_1 * (var_310_6 / var_310_5)

				if var_310_7 > 0 and var_310_1 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_0
					end
				end

				arg_307_1.text_.text = var_310_4
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031076", "story_v_out_222031.awb") ~= 0 then
					local var_310_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031076", "story_v_out_222031.awb") / 1000

					if var_310_8 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_0
					end

					if var_310_3.prefab_name ~= "" and arg_307_1.actors_[var_310_3.prefab_name] ~= nil then
						local var_310_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_3.prefab_name].transform, "story_v_out_222031", "222031076", "story_v_out_222031.awb")

						arg_307_1:RecordAudio("222031076", var_310_9)
						arg_307_1:RecordAudio("222031076", var_310_9)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_222031", "222031076", "story_v_out_222031.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_222031", "222031076", "story_v_out_222031.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_10 = math.max(var_310_1, arg_307_1.talkMaxDuration)

			if var_310_0 <= arg_307_1.time_ and arg_307_1.time_ < var_310_0 + var_310_10 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_0) / var_310_10

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_0 + var_310_10 and arg_307_1.time_ < var_310_0 + var_310_10 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play222031077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 222031077
		arg_311_1.duration_ = 11.7

		local var_311_0 = {
			ja = 11.7,
			ko = 8.1,
			zh = 8.1
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play222031078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1074ui_story"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1074ui_story == nil then
				arg_311_1.var_.characterEffect1074ui_story = var_314_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.characterEffect1074ui_story and not isNil(var_314_0) then
					arg_311_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1074ui_story then
				arg_311_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_314_4 = 0

			if var_314_4 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_314_5 = 0
			local var_314_6 = 0.65

			if var_314_5 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_7 = arg_311_1:FormatText(StoryNameCfg[410].name)

				arg_311_1.leftNameTxt_.text = var_314_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_8 = arg_311_1:GetWordFromCfg(222031077)
				local var_314_9 = arg_311_1:FormatText(var_314_8.content)

				arg_311_1.text_.text = var_314_9

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_10 = 26
				local var_314_11 = utf8.len(var_314_9)
				local var_314_12 = var_314_10 <= 0 and var_314_6 or var_314_6 * (var_314_11 / var_314_10)

				if var_314_12 > 0 and var_314_6 < var_314_12 then
					arg_311_1.talkMaxDuration = var_314_12

					if var_314_12 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_12 + var_314_5
					end
				end

				arg_311_1.text_.text = var_314_9
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031077", "story_v_out_222031.awb") ~= 0 then
					local var_314_13 = manager.audio:GetVoiceLength("story_v_out_222031", "222031077", "story_v_out_222031.awb") / 1000

					if var_314_13 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_13 + var_314_5
					end

					if var_314_8.prefab_name ~= "" and arg_311_1.actors_[var_314_8.prefab_name] ~= nil then
						local var_314_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_8.prefab_name].transform, "story_v_out_222031", "222031077", "story_v_out_222031.awb")

						arg_311_1:RecordAudio("222031077", var_314_14)
						arg_311_1:RecordAudio("222031077", var_314_14)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_222031", "222031077", "story_v_out_222031.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_222031", "222031077", "story_v_out_222031.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_15 = math.max(var_314_6, arg_311_1.talkMaxDuration)

			if var_314_5 <= arg_311_1.time_ and arg_311_1.time_ < var_314_5 + var_314_15 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_5) / var_314_15

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_5 + var_314_15 and arg_311_1.time_ < var_314_5 + var_314_15 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play222031078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 222031078
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play222031079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1074ui_story"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect1074ui_story == nil then
				arg_315_1.var_.characterEffect1074ui_story = var_318_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.characterEffect1074ui_story and not isNil(var_318_0) then
					local var_318_4 = Mathf.Lerp(0, 0.5, var_318_3)

					arg_315_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1074ui_story.fillRatio = var_318_4
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect1074ui_story then
				local var_318_5 = 0.5

				arg_315_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1074ui_story.fillRatio = var_318_5
			end

			local var_318_6 = 0
			local var_318_7 = 1.575

			if var_318_6 < arg_315_1.time_ and arg_315_1.time_ <= var_318_6 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_8 = arg_315_1:GetWordFromCfg(222031078)
				local var_318_9 = arg_315_1:FormatText(var_318_8.content)

				arg_315_1.text_.text = var_318_9

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_10 = 63
				local var_318_11 = utf8.len(var_318_9)
				local var_318_12 = var_318_10 <= 0 and var_318_7 or var_318_7 * (var_318_11 / var_318_10)

				if var_318_12 > 0 and var_318_7 < var_318_12 then
					arg_315_1.talkMaxDuration = var_318_12

					if var_318_12 + var_318_6 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_12 + var_318_6
					end
				end

				arg_315_1.text_.text = var_318_9
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_13 = math.max(var_318_7, arg_315_1.talkMaxDuration)

			if var_318_6 <= arg_315_1.time_ and arg_315_1.time_ < var_318_6 + var_318_13 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_6) / var_318_13

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_6 + var_318_13 and arg_315_1.time_ < var_318_6 + var_318_13 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play222031079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 222031079
		arg_319_1.duration_ = 4.67

		local var_319_0 = {
			ja = 4.666,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play222031080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["1074ui_story"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1074ui_story == nil then
				arg_319_1.var_.characterEffect1074ui_story = var_322_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.characterEffect1074ui_story and not isNil(var_322_0) then
					arg_319_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1074ui_story then
				arg_319_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_322_4 = 0

			if var_322_4 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_322_5 = 0

			if var_322_5 < arg_319_1.time_ and arg_319_1.time_ <= var_322_5 + arg_322_0 then
				arg_319_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_322_6 = 0
			local var_322_7 = 0.25

			if var_322_6 < arg_319_1.time_ and arg_319_1.time_ <= var_322_6 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_8 = arg_319_1:FormatText(StoryNameCfg[410].name)

				arg_319_1.leftNameTxt_.text = var_322_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_9 = arg_319_1:GetWordFromCfg(222031079)
				local var_322_10 = arg_319_1:FormatText(var_322_9.content)

				arg_319_1.text_.text = var_322_10

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_11 = 10
				local var_322_12 = utf8.len(var_322_10)
				local var_322_13 = var_322_11 <= 0 and var_322_7 or var_322_7 * (var_322_12 / var_322_11)

				if var_322_13 > 0 and var_322_7 < var_322_13 then
					arg_319_1.talkMaxDuration = var_322_13

					if var_322_13 + var_322_6 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_13 + var_322_6
					end
				end

				arg_319_1.text_.text = var_322_10
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031079", "story_v_out_222031.awb") ~= 0 then
					local var_322_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031079", "story_v_out_222031.awb") / 1000

					if var_322_14 + var_322_6 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_14 + var_322_6
					end

					if var_322_9.prefab_name ~= "" and arg_319_1.actors_[var_322_9.prefab_name] ~= nil then
						local var_322_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_9.prefab_name].transform, "story_v_out_222031", "222031079", "story_v_out_222031.awb")

						arg_319_1:RecordAudio("222031079", var_322_15)
						arg_319_1:RecordAudio("222031079", var_322_15)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_222031", "222031079", "story_v_out_222031.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_222031", "222031079", "story_v_out_222031.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_16 = math.max(var_322_7, arg_319_1.talkMaxDuration)

			if var_322_6 <= arg_319_1.time_ and arg_319_1.time_ < var_322_6 + var_322_16 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_6) / var_322_16

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_6 + var_322_16 and arg_319_1.time_ < var_322_6 + var_322_16 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play222031080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 222031080
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play222031081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1074ui_story"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1074ui_story == nil then
				arg_323_1.var_.characterEffect1074ui_story = var_326_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.characterEffect1074ui_story and not isNil(var_326_0) then
					local var_326_4 = Mathf.Lerp(0, 0.5, var_326_3)

					arg_323_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1074ui_story.fillRatio = var_326_4
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1074ui_story then
				local var_326_5 = 0.5

				arg_323_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1074ui_story.fillRatio = var_326_5
			end

			local var_326_6 = 0
			local var_326_7 = 0.85

			if var_326_6 < arg_323_1.time_ and arg_323_1.time_ <= var_326_6 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_8 = arg_323_1:GetWordFromCfg(222031080)
				local var_326_9 = arg_323_1:FormatText(var_326_8.content)

				arg_323_1.text_.text = var_326_9

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_10 = 34
				local var_326_11 = utf8.len(var_326_9)
				local var_326_12 = var_326_10 <= 0 and var_326_7 or var_326_7 * (var_326_11 / var_326_10)

				if var_326_12 > 0 and var_326_7 < var_326_12 then
					arg_323_1.talkMaxDuration = var_326_12

					if var_326_12 + var_326_6 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_12 + var_326_6
					end
				end

				arg_323_1.text_.text = var_326_9
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_13 = math.max(var_326_7, arg_323_1.talkMaxDuration)

			if var_326_6 <= arg_323_1.time_ and arg_323_1.time_ < var_326_6 + var_326_13 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_6) / var_326_13

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_6 + var_326_13 and arg_323_1.time_ < var_326_6 + var_326_13 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play222031081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 222031081
		arg_327_1.duration_ = 16.2

		local var_327_0 = {
			ja = 16.2,
			ko = 10.933,
			zh = 10.833
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
				arg_327_0:Play222031082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1074ui_story"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1074ui_story == nil then
				arg_327_1.var_.characterEffect1074ui_story = var_330_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.200000002980232

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.characterEffect1074ui_story and not isNil(var_330_0) then
					arg_327_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1074ui_story then
				arg_327_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_330_4 = 0

			if var_330_4 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_330_5 = 0
			local var_330_6 = 1.075

			if var_330_5 < arg_327_1.time_ and arg_327_1.time_ <= var_330_5 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_7 = arg_327_1:FormatText(StoryNameCfg[410].name)

				arg_327_1.leftNameTxt_.text = var_330_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_8 = arg_327_1:GetWordFromCfg(222031081)
				local var_330_9 = arg_327_1:FormatText(var_330_8.content)

				arg_327_1.text_.text = var_330_9

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_10 = 43
				local var_330_11 = utf8.len(var_330_9)
				local var_330_12 = var_330_10 <= 0 and var_330_6 or var_330_6 * (var_330_11 / var_330_10)

				if var_330_12 > 0 and var_330_6 < var_330_12 then
					arg_327_1.talkMaxDuration = var_330_12

					if var_330_12 + var_330_5 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_12 + var_330_5
					end
				end

				arg_327_1.text_.text = var_330_9
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031081", "story_v_out_222031.awb") ~= 0 then
					local var_330_13 = manager.audio:GetVoiceLength("story_v_out_222031", "222031081", "story_v_out_222031.awb") / 1000

					if var_330_13 + var_330_5 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_13 + var_330_5
					end

					if var_330_8.prefab_name ~= "" and arg_327_1.actors_[var_330_8.prefab_name] ~= nil then
						local var_330_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_8.prefab_name].transform, "story_v_out_222031", "222031081", "story_v_out_222031.awb")

						arg_327_1:RecordAudio("222031081", var_330_14)
						arg_327_1:RecordAudio("222031081", var_330_14)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_222031", "222031081", "story_v_out_222031.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_222031", "222031081", "story_v_out_222031.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_15 = math.max(var_330_6, arg_327_1.talkMaxDuration)

			if var_330_5 <= arg_327_1.time_ and arg_327_1.time_ < var_330_5 + var_330_15 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_5) / var_330_15

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_5 + var_330_15 and arg_327_1.time_ < var_330_5 + var_330_15 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play222031082 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 222031082
		arg_331_1.duration_ = 12.1

		local var_331_0 = {
			ja = 9.066,
			ko = 12.033,
			zh = 12.1
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play222031083(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				arg_331_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_334_1 = 0
			local var_334_2 = 0.525

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_3 = arg_331_1:FormatText(StoryNameCfg[410].name)

				arg_331_1.leftNameTxt_.text = var_334_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_4 = arg_331_1:GetWordFromCfg(222031082)
				local var_334_5 = arg_331_1:FormatText(var_334_4.content)

				arg_331_1.text_.text = var_334_5

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_6 = 21
				local var_334_7 = utf8.len(var_334_5)
				local var_334_8 = var_334_6 <= 0 and var_334_2 or var_334_2 * (var_334_7 / var_334_6)

				if var_334_8 > 0 and var_334_2 < var_334_8 then
					arg_331_1.talkMaxDuration = var_334_8

					if var_334_8 + var_334_1 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_8 + var_334_1
					end
				end

				arg_331_1.text_.text = var_334_5
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031082", "story_v_out_222031.awb") ~= 0 then
					local var_334_9 = manager.audio:GetVoiceLength("story_v_out_222031", "222031082", "story_v_out_222031.awb") / 1000

					if var_334_9 + var_334_1 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_9 + var_334_1
					end

					if var_334_4.prefab_name ~= "" and arg_331_1.actors_[var_334_4.prefab_name] ~= nil then
						local var_334_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_4.prefab_name].transform, "story_v_out_222031", "222031082", "story_v_out_222031.awb")

						arg_331_1:RecordAudio("222031082", var_334_10)
						arg_331_1:RecordAudio("222031082", var_334_10)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_222031", "222031082", "story_v_out_222031.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_222031", "222031082", "story_v_out_222031.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_11 = math.max(var_334_2, arg_331_1.talkMaxDuration)

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_11 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_1) / var_334_11

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_1 + var_334_11 and arg_331_1.time_ < var_334_1 + var_334_11 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play222031083 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 222031083
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play222031084(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1074ui_story"]
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.characterEffect1074ui_story == nil then
				arg_335_1.var_.characterEffect1074ui_story = var_338_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_2 = 0.200000002980232

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 and not isNil(var_338_0) then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2

				if arg_335_1.var_.characterEffect1074ui_story and not isNil(var_338_0) then
					local var_338_4 = Mathf.Lerp(0, 0.5, var_338_3)

					arg_335_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1074ui_story.fillRatio = var_338_4
				end
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.characterEffect1074ui_story then
				local var_338_5 = 0.5

				arg_335_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1074ui_story.fillRatio = var_338_5
			end

			local var_338_6 = 0
			local var_338_7 = 0.8

			if var_338_6 < arg_335_1.time_ and arg_335_1.time_ <= var_338_6 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_8 = arg_335_1:GetWordFromCfg(222031083)
				local var_338_9 = arg_335_1:FormatText(var_338_8.content)

				arg_335_1.text_.text = var_338_9

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_10 = 32
				local var_338_11 = utf8.len(var_338_9)
				local var_338_12 = var_338_10 <= 0 and var_338_7 or var_338_7 * (var_338_11 / var_338_10)

				if var_338_12 > 0 and var_338_7 < var_338_12 then
					arg_335_1.talkMaxDuration = var_338_12

					if var_338_12 + var_338_6 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_12 + var_338_6
					end
				end

				arg_335_1.text_.text = var_338_9
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_13 = math.max(var_338_7, arg_335_1.talkMaxDuration)

			if var_338_6 <= arg_335_1.time_ and arg_335_1.time_ < var_338_6 + var_338_13 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_6) / var_338_13

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_6 + var_338_13 and arg_335_1.time_ < var_338_6 + var_338_13 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play222031084 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 222031084
		arg_339_1.duration_ = 9.9

		local var_339_0 = {
			ja = 9.9,
			ko = 5.4,
			zh = 5.4
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
				arg_339_0:Play222031085(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1074ui_story"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1074ui_story == nil then
				arg_339_1.var_.characterEffect1074ui_story = var_342_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 and not isNil(var_342_0) then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.characterEffect1074ui_story and not isNil(var_342_0) then
					arg_339_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1074ui_story then
				arg_339_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_342_4 = 0

			if var_342_4 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_342_5 = 0
			local var_342_6 = 0.625

			if var_342_5 < arg_339_1.time_ and arg_339_1.time_ <= var_342_5 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_7 = arg_339_1:FormatText(StoryNameCfg[410].name)

				arg_339_1.leftNameTxt_.text = var_342_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_8 = arg_339_1:GetWordFromCfg(222031084)
				local var_342_9 = arg_339_1:FormatText(var_342_8.content)

				arg_339_1.text_.text = var_342_9

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_10 = 25
				local var_342_11 = utf8.len(var_342_9)
				local var_342_12 = var_342_10 <= 0 and var_342_6 or var_342_6 * (var_342_11 / var_342_10)

				if var_342_12 > 0 and var_342_6 < var_342_12 then
					arg_339_1.talkMaxDuration = var_342_12

					if var_342_12 + var_342_5 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_12 + var_342_5
					end
				end

				arg_339_1.text_.text = var_342_9
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031084", "story_v_out_222031.awb") ~= 0 then
					local var_342_13 = manager.audio:GetVoiceLength("story_v_out_222031", "222031084", "story_v_out_222031.awb") / 1000

					if var_342_13 + var_342_5 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_13 + var_342_5
					end

					if var_342_8.prefab_name ~= "" and arg_339_1.actors_[var_342_8.prefab_name] ~= nil then
						local var_342_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_8.prefab_name].transform, "story_v_out_222031", "222031084", "story_v_out_222031.awb")

						arg_339_1:RecordAudio("222031084", var_342_14)
						arg_339_1:RecordAudio("222031084", var_342_14)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_222031", "222031084", "story_v_out_222031.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_222031", "222031084", "story_v_out_222031.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_15 = math.max(var_342_6, arg_339_1.talkMaxDuration)

			if var_342_5 <= arg_339_1.time_ and arg_339_1.time_ < var_342_5 + var_342_15 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_5) / var_342_15

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_5 + var_342_15 and arg_339_1.time_ < var_342_5 + var_342_15 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play222031085 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 222031085
		arg_343_1.duration_ = 7.4

		local var_343_0 = {
			ja = 7.4,
			ko = 6.1,
			zh = 6.1
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
				arg_343_0:Play222031086(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["1074ui_story"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect1074ui_story == nil then
				arg_343_1.var_.characterEffect1074ui_story = var_346_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_2 = 0.200000002980232

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.characterEffect1074ui_story and not isNil(var_346_0) then
					local var_346_4 = Mathf.Lerp(0, 0.5, var_346_3)

					arg_343_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1074ui_story.fillRatio = var_346_4
				end
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect1074ui_story then
				local var_346_5 = 0.5

				arg_343_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1074ui_story.fillRatio = var_346_5
			end

			local var_346_6 = 0
			local var_346_7 = 0.65

			if var_346_6 < arg_343_1.time_ and arg_343_1.time_ <= var_346_6 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_8 = arg_343_1:FormatText(StoryNameCfg[461].name)

				arg_343_1.leftNameTxt_.text = var_346_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_9 = arg_343_1:GetWordFromCfg(222031085)
				local var_346_10 = arg_343_1:FormatText(var_346_9.content)

				arg_343_1.text_.text = var_346_10

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_11 = 26
				local var_346_12 = utf8.len(var_346_10)
				local var_346_13 = var_346_11 <= 0 and var_346_7 or var_346_7 * (var_346_12 / var_346_11)

				if var_346_13 > 0 and var_346_7 < var_346_13 then
					arg_343_1.talkMaxDuration = var_346_13

					if var_346_13 + var_346_6 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_13 + var_346_6
					end
				end

				arg_343_1.text_.text = var_346_10
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031085", "story_v_out_222031.awb") ~= 0 then
					local var_346_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031085", "story_v_out_222031.awb") / 1000

					if var_346_14 + var_346_6 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_14 + var_346_6
					end

					if var_346_9.prefab_name ~= "" and arg_343_1.actors_[var_346_9.prefab_name] ~= nil then
						local var_346_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_9.prefab_name].transform, "story_v_out_222031", "222031085", "story_v_out_222031.awb")

						arg_343_1:RecordAudio("222031085", var_346_15)
						arg_343_1:RecordAudio("222031085", var_346_15)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_222031", "222031085", "story_v_out_222031.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_222031", "222031085", "story_v_out_222031.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_16 = math.max(var_346_7, arg_343_1.talkMaxDuration)

			if var_346_6 <= arg_343_1.time_ and arg_343_1.time_ < var_346_6 + var_346_16 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_6) / var_346_16

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_6 + var_346_16 and arg_343_1.time_ < var_346_6 + var_346_16 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play222031086 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 222031086
		arg_347_1.duration_ = 10.7

		local var_347_0 = {
			ja = 10.7,
			ko = 7.6,
			zh = 7.6
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play222031087(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0
			local var_350_1 = 0.7

			if var_350_0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_2 = arg_347_1:FormatText(StoryNameCfg[461].name)

				arg_347_1.leftNameTxt_.text = var_350_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_3 = arg_347_1:GetWordFromCfg(222031086)
				local var_350_4 = arg_347_1:FormatText(var_350_3.content)

				arg_347_1.text_.text = var_350_4

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 28
				local var_350_6 = utf8.len(var_350_4)
				local var_350_7 = var_350_5 <= 0 and var_350_1 or var_350_1 * (var_350_6 / var_350_5)

				if var_350_7 > 0 and var_350_1 < var_350_7 then
					arg_347_1.talkMaxDuration = var_350_7

					if var_350_7 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_0
					end
				end

				arg_347_1.text_.text = var_350_4
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031086", "story_v_out_222031.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031086", "story_v_out_222031.awb") / 1000

					if var_350_8 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_0
					end

					if var_350_3.prefab_name ~= "" and arg_347_1.actors_[var_350_3.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_3.prefab_name].transform, "story_v_out_222031", "222031086", "story_v_out_222031.awb")

						arg_347_1:RecordAudio("222031086", var_350_9)
						arg_347_1:RecordAudio("222031086", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_222031", "222031086", "story_v_out_222031.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_222031", "222031086", "story_v_out_222031.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_10 = math.max(var_350_1, arg_347_1.talkMaxDuration)

			if var_350_0 <= arg_347_1.time_ and arg_347_1.time_ < var_350_0 + var_350_10 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_0) / var_350_10

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_0 + var_350_10 and arg_347_1.time_ < var_350_0 + var_350_10 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play222031087 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 222031087
		arg_351_1.duration_ = 14.73

		local var_351_0 = {
			ja = 14.733,
			ko = 7.366,
			zh = 7.366
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
				arg_351_0:Play222031088(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1074ui_story"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1074ui_story == nil then
				arg_351_1.var_.characterEffect1074ui_story = var_354_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.200000002980232

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.characterEffect1074ui_story and not isNil(var_354_0) then
					arg_351_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1074ui_story then
				arg_351_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_354_4 = 0

			if var_354_4 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074actionlink/1074action453")
			end

			local var_354_5 = 0

			if var_354_5 < arg_351_1.time_ and arg_351_1.time_ <= var_354_5 + arg_354_0 then
				arg_351_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_354_6 = 0
			local var_354_7 = 0.875

			if var_354_6 < arg_351_1.time_ and arg_351_1.time_ <= var_354_6 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_8 = arg_351_1:FormatText(StoryNameCfg[410].name)

				arg_351_1.leftNameTxt_.text = var_354_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_9 = arg_351_1:GetWordFromCfg(222031087)
				local var_354_10 = arg_351_1:FormatText(var_354_9.content)

				arg_351_1.text_.text = var_354_10

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_11 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031087", "story_v_out_222031.awb") ~= 0 then
					local var_354_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031087", "story_v_out_222031.awb") / 1000

					if var_354_14 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_14 + var_354_6
					end

					if var_354_9.prefab_name ~= "" and arg_351_1.actors_[var_354_9.prefab_name] ~= nil then
						local var_354_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_9.prefab_name].transform, "story_v_out_222031", "222031087", "story_v_out_222031.awb")

						arg_351_1:RecordAudio("222031087", var_354_15)
						arg_351_1:RecordAudio("222031087", var_354_15)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_222031", "222031087", "story_v_out_222031.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_222031", "222031087", "story_v_out_222031.awb")
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
	Play222031088 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 222031088
		arg_355_1.duration_ = 13.2

		local var_355_0 = {
			ja = 13.2,
			ko = 9.866,
			zh = 9.866
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play222031089(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["1074ui_story"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1074ui_story == nil then
				arg_355_1.var_.characterEffect1074ui_story = var_358_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.200000002980232

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 and not isNil(var_358_0) then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.characterEffect1074ui_story and not isNil(var_358_0) then
					local var_358_4 = Mathf.Lerp(0, 0.5, var_358_3)

					arg_355_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1074ui_story.fillRatio = var_358_4
				end
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1074ui_story then
				local var_358_5 = 0.5

				arg_355_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1074ui_story.fillRatio = var_358_5
			end

			local var_358_6 = 0
			local var_358_7 = 0.925

			if var_358_6 < arg_355_1.time_ and arg_355_1.time_ <= var_358_6 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_8 = arg_355_1:FormatText(StoryNameCfg[461].name)

				arg_355_1.leftNameTxt_.text = var_358_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_9 = arg_355_1:GetWordFromCfg(222031088)
				local var_358_10 = arg_355_1:FormatText(var_358_9.content)

				arg_355_1.text_.text = var_358_10

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_11 = 37
				local var_358_12 = utf8.len(var_358_10)
				local var_358_13 = var_358_11 <= 0 and var_358_7 or var_358_7 * (var_358_12 / var_358_11)

				if var_358_13 > 0 and var_358_7 < var_358_13 then
					arg_355_1.talkMaxDuration = var_358_13

					if var_358_13 + var_358_6 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_13 + var_358_6
					end
				end

				arg_355_1.text_.text = var_358_10
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031088", "story_v_out_222031.awb") ~= 0 then
					local var_358_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031088", "story_v_out_222031.awb") / 1000

					if var_358_14 + var_358_6 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_14 + var_358_6
					end

					if var_358_9.prefab_name ~= "" and arg_355_1.actors_[var_358_9.prefab_name] ~= nil then
						local var_358_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_9.prefab_name].transform, "story_v_out_222031", "222031088", "story_v_out_222031.awb")

						arg_355_1:RecordAudio("222031088", var_358_15)
						arg_355_1:RecordAudio("222031088", var_358_15)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_222031", "222031088", "story_v_out_222031.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_222031", "222031088", "story_v_out_222031.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_16 = math.max(var_358_7, arg_355_1.talkMaxDuration)

			if var_358_6 <= arg_355_1.time_ and arg_355_1.time_ < var_358_6 + var_358_16 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_6) / var_358_16

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_6 + var_358_16 and arg_355_1.time_ < var_358_6 + var_358_16 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play222031089 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 222031089
		arg_359_1.duration_ = 12.87

		local var_359_0 = {
			ja = 12.866,
			ko = 9,
			zh = 9
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
				arg_359_0:Play222031090(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0
			local var_362_1 = 0.925

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_2 = arg_359_1:FormatText(StoryNameCfg[461].name)

				arg_359_1.leftNameTxt_.text = var_362_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_3 = arg_359_1:GetWordFromCfg(222031089)
				local var_362_4 = arg_359_1:FormatText(var_362_3.content)

				arg_359_1.text_.text = var_362_4

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 37
				local var_362_6 = utf8.len(var_362_4)
				local var_362_7 = var_362_5 <= 0 and var_362_1 or var_362_1 * (var_362_6 / var_362_5)

				if var_362_7 > 0 and var_362_1 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_0
					end
				end

				arg_359_1.text_.text = var_362_4
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031089", "story_v_out_222031.awb") ~= 0 then
					local var_362_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031089", "story_v_out_222031.awb") / 1000

					if var_362_8 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_8 + var_362_0
					end

					if var_362_3.prefab_name ~= "" and arg_359_1.actors_[var_362_3.prefab_name] ~= nil then
						local var_362_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_3.prefab_name].transform, "story_v_out_222031", "222031089", "story_v_out_222031.awb")

						arg_359_1:RecordAudio("222031089", var_362_9)
						arg_359_1:RecordAudio("222031089", var_362_9)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_222031", "222031089", "story_v_out_222031.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_222031", "222031089", "story_v_out_222031.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_10 = math.max(var_362_1, arg_359_1.talkMaxDuration)

			if var_362_0 <= arg_359_1.time_ and arg_359_1.time_ < var_362_0 + var_362_10 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_0) / var_362_10

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_0 + var_362_10 and arg_359_1.time_ < var_362_0 + var_362_10 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play222031090 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 222031090
		arg_363_1.duration_ = 21.4

		local var_363_0 = {
			ja = 21.4,
			ko = 17.366,
			zh = 17.4
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play222031091(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0
			local var_366_1 = 1.575

			if var_366_0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_2 = arg_363_1:FormatText(StoryNameCfg[461].name)

				arg_363_1.leftNameTxt_.text = var_366_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_3 = arg_363_1:GetWordFromCfg(222031090)
				local var_366_4 = arg_363_1:FormatText(var_366_3.content)

				arg_363_1.text_.text = var_366_4

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 63
				local var_366_6 = utf8.len(var_366_4)
				local var_366_7 = var_366_5 <= 0 and var_366_1 or var_366_1 * (var_366_6 / var_366_5)

				if var_366_7 > 0 and var_366_1 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_0
					end
				end

				arg_363_1.text_.text = var_366_4
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031090", "story_v_out_222031.awb") ~= 0 then
					local var_366_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031090", "story_v_out_222031.awb") / 1000

					if var_366_8 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_8 + var_366_0
					end

					if var_366_3.prefab_name ~= "" and arg_363_1.actors_[var_366_3.prefab_name] ~= nil then
						local var_366_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_3.prefab_name].transform, "story_v_out_222031", "222031090", "story_v_out_222031.awb")

						arg_363_1:RecordAudio("222031090", var_366_9)
						arg_363_1:RecordAudio("222031090", var_366_9)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_222031", "222031090", "story_v_out_222031.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_222031", "222031090", "story_v_out_222031.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_10 = math.max(var_366_1, arg_363_1.talkMaxDuration)

			if var_366_0 <= arg_363_1.time_ and arg_363_1.time_ < var_366_0 + var_366_10 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_0) / var_366_10

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_0 + var_366_10 and arg_363_1.time_ < var_366_0 + var_366_10 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play222031091 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 222031091
		arg_367_1.duration_ = 9

		local var_367_0 = {
			ja = 8.433,
			ko = 9,
			zh = 9
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play222031092(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["1074ui_story"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect1074ui_story == nil then
				arg_367_1.var_.characterEffect1074ui_story = var_370_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 and not isNil(var_370_0) then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2

				if arg_367_1.var_.characterEffect1074ui_story and not isNil(var_370_0) then
					arg_367_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect1074ui_story then
				arg_367_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_370_4 = 0

			if var_370_4 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action3_2")
			end

			local var_370_5 = 0

			if var_370_5 < arg_367_1.time_ and arg_367_1.time_ <= var_370_5 + arg_370_0 then
				arg_367_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_370_6 = 0
			local var_370_7 = 0.75

			if var_370_6 < arg_367_1.time_ and arg_367_1.time_ <= var_370_6 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_8 = arg_367_1:FormatText(StoryNameCfg[410].name)

				arg_367_1.leftNameTxt_.text = var_370_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_9 = arg_367_1:GetWordFromCfg(222031091)
				local var_370_10 = arg_367_1:FormatText(var_370_9.content)

				arg_367_1.text_.text = var_370_10

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_11 = 30
				local var_370_12 = utf8.len(var_370_10)
				local var_370_13 = var_370_11 <= 0 and var_370_7 or var_370_7 * (var_370_12 / var_370_11)

				if var_370_13 > 0 and var_370_7 < var_370_13 then
					arg_367_1.talkMaxDuration = var_370_13

					if var_370_13 + var_370_6 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_13 + var_370_6
					end
				end

				arg_367_1.text_.text = var_370_10
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031091", "story_v_out_222031.awb") ~= 0 then
					local var_370_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031091", "story_v_out_222031.awb") / 1000

					if var_370_14 + var_370_6 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_14 + var_370_6
					end

					if var_370_9.prefab_name ~= "" and arg_367_1.actors_[var_370_9.prefab_name] ~= nil then
						local var_370_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_9.prefab_name].transform, "story_v_out_222031", "222031091", "story_v_out_222031.awb")

						arg_367_1:RecordAudio("222031091", var_370_15)
						arg_367_1:RecordAudio("222031091", var_370_15)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_222031", "222031091", "story_v_out_222031.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_222031", "222031091", "story_v_out_222031.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_16 = math.max(var_370_7, arg_367_1.talkMaxDuration)

			if var_370_6 <= arg_367_1.time_ and arg_367_1.time_ < var_370_6 + var_370_16 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_6) / var_370_16

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_6 + var_370_16 and arg_367_1.time_ < var_370_6 + var_370_16 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play222031092 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 222031092
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play222031093(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1074ui_story"].transform
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.var_.moveOldPos1074ui_story = var_374_0.localPosition
			end

			local var_374_2 = 0.001

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2
				local var_374_4 = Vector3.New(0, 100, 0)

				var_374_0.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1074ui_story, var_374_4, var_374_3)

				local var_374_5 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_5.x, var_374_5.y, var_374_5.z)

				local var_374_6 = var_374_0.localEulerAngles

				var_374_6.z = 0
				var_374_6.x = 0
				var_374_0.localEulerAngles = var_374_6
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 then
				var_374_0.localPosition = Vector3.New(0, 100, 0)

				local var_374_7 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_7.x, var_374_7.y, var_374_7.z)

				local var_374_8 = var_374_0.localEulerAngles

				var_374_8.z = 0
				var_374_8.x = 0
				var_374_0.localEulerAngles = var_374_8
			end

			local var_374_9 = arg_371_1.actors_["1074ui_story"]
			local var_374_10 = 0

			if var_374_10 < arg_371_1.time_ and arg_371_1.time_ <= var_374_10 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1074ui_story == nil then
				arg_371_1.var_.characterEffect1074ui_story = var_374_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_11 = 0.200000002980232

			if var_374_10 <= arg_371_1.time_ and arg_371_1.time_ < var_374_10 + var_374_11 and not isNil(var_374_9) then
				local var_374_12 = (arg_371_1.time_ - var_374_10) / var_374_11

				if arg_371_1.var_.characterEffect1074ui_story and not isNil(var_374_9) then
					local var_374_13 = Mathf.Lerp(0, 0.5, var_374_12)

					arg_371_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1074ui_story.fillRatio = var_374_13
				end
			end

			if arg_371_1.time_ >= var_374_10 + var_374_11 and arg_371_1.time_ < var_374_10 + var_374_11 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1074ui_story then
				local var_374_14 = 0.5

				arg_371_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1074ui_story.fillRatio = var_374_14
			end

			local var_374_15 = 0
			local var_374_16 = 0.75

			if var_374_15 < arg_371_1.time_ and arg_371_1.time_ <= var_374_15 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_17 = arg_371_1:GetWordFromCfg(222031092)
				local var_374_18 = arg_371_1:FormatText(var_374_17.content)

				arg_371_1.text_.text = var_374_18

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_19 = 30
				local var_374_20 = utf8.len(var_374_18)
				local var_374_21 = var_374_19 <= 0 and var_374_16 or var_374_16 * (var_374_20 / var_374_19)

				if var_374_21 > 0 and var_374_16 < var_374_21 then
					arg_371_1.talkMaxDuration = var_374_21

					if var_374_21 + var_374_15 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_21 + var_374_15
					end
				end

				arg_371_1.text_.text = var_374_18
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_22 = math.max(var_374_16, arg_371_1.talkMaxDuration)

			if var_374_15 <= arg_371_1.time_ and arg_371_1.time_ < var_374_15 + var_374_22 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_15) / var_374_22

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_15 + var_374_22 and arg_371_1.time_ < var_374_15 + var_374_22 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play222031093 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 222031093
		arg_375_1.duration_ = 8.2

		local var_375_0 = {
			ja = 8.2,
			ko = 3.633,
			zh = 3.633
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play222031094(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = "1072ui_story"

			if arg_375_1.actors_[var_378_0] == nil then
				local var_378_1 = Asset.Load("Char/" .. "1072ui_story")

				if not isNil(var_378_1) then
					local var_378_2 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_375_1.stage_.transform)

					var_378_2.name = var_378_0
					var_378_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_375_1.actors_[var_378_0] = var_378_2

					local var_378_3 = var_378_2:GetComponentInChildren(typeof(CharacterEffect))

					var_378_3.enabled = true

					local var_378_4 = GameObjectTools.GetOrAddComponent(var_378_2, typeof(DynamicBoneHelper))

					if var_378_4 then
						var_378_4:EnableDynamicBone(false)
					end

					arg_375_1:ShowWeapon(var_378_3.transform, false)

					arg_375_1.var_[var_378_0 .. "Animator"] = var_378_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_375_1.var_[var_378_0 .. "Animator"].applyRootMotion = true
					arg_375_1.var_[var_378_0 .. "LipSync"] = var_378_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_378_5 = arg_375_1.actors_["1072ui_story"].transform
			local var_378_6 = 0

			if var_378_6 < arg_375_1.time_ and arg_375_1.time_ <= var_378_6 + arg_378_0 then
				arg_375_1.var_.moveOldPos1072ui_story = var_378_5.localPosition
			end

			local var_378_7 = 0.001

			if var_378_6 <= arg_375_1.time_ and arg_375_1.time_ < var_378_6 + var_378_7 then
				local var_378_8 = (arg_375_1.time_ - var_378_6) / var_378_7
				local var_378_9 = Vector3.New(-0.7, -0.71, -6)

				var_378_5.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1072ui_story, var_378_9, var_378_8)

				local var_378_10 = manager.ui.mainCamera.transform.position - var_378_5.position

				var_378_5.forward = Vector3.New(var_378_10.x, var_378_10.y, var_378_10.z)

				local var_378_11 = var_378_5.localEulerAngles

				var_378_11.z = 0
				var_378_11.x = 0
				var_378_5.localEulerAngles = var_378_11
			end

			if arg_375_1.time_ >= var_378_6 + var_378_7 and arg_375_1.time_ < var_378_6 + var_378_7 + arg_378_0 then
				var_378_5.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_378_12 = manager.ui.mainCamera.transform.position - var_378_5.position

				var_378_5.forward = Vector3.New(var_378_12.x, var_378_12.y, var_378_12.z)

				local var_378_13 = var_378_5.localEulerAngles

				var_378_13.z = 0
				var_378_13.x = 0
				var_378_5.localEulerAngles = var_378_13
			end

			local var_378_14 = arg_375_1.actors_["1072ui_story"]
			local var_378_15 = 0

			if var_378_15 < arg_375_1.time_ and arg_375_1.time_ <= var_378_15 + arg_378_0 and not isNil(var_378_14) and arg_375_1.var_.characterEffect1072ui_story == nil then
				arg_375_1.var_.characterEffect1072ui_story = var_378_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_16 = 0.200000002980232

			if var_378_15 <= arg_375_1.time_ and arg_375_1.time_ < var_378_15 + var_378_16 and not isNil(var_378_14) then
				local var_378_17 = (arg_375_1.time_ - var_378_15) / var_378_16

				if arg_375_1.var_.characterEffect1072ui_story and not isNil(var_378_14) then
					arg_375_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= var_378_15 + var_378_16 and arg_375_1.time_ < var_378_15 + var_378_16 + arg_378_0 and not isNil(var_378_14) and arg_375_1.var_.characterEffect1072ui_story then
				arg_375_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_378_18 = 0

			if var_378_18 < arg_375_1.time_ and arg_375_1.time_ <= var_378_18 + arg_378_0 then
				arg_375_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_378_19 = 0

			if var_378_19 < arg_375_1.time_ and arg_375_1.time_ <= var_378_19 + arg_378_0 then
				arg_375_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_378_20 = arg_375_1.actors_["1074ui_story"].transform
			local var_378_21 = 0

			if var_378_21 < arg_375_1.time_ and arg_375_1.time_ <= var_378_21 + arg_378_0 then
				arg_375_1.var_.moveOldPos1074ui_story = var_378_20.localPosition
			end

			local var_378_22 = 0.001

			if var_378_21 <= arg_375_1.time_ and arg_375_1.time_ < var_378_21 + var_378_22 then
				local var_378_23 = (arg_375_1.time_ - var_378_21) / var_378_22
				local var_378_24 = Vector3.New(0.7, -1.055, -6.12)

				var_378_20.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1074ui_story, var_378_24, var_378_23)

				local var_378_25 = manager.ui.mainCamera.transform.position - var_378_20.position

				var_378_20.forward = Vector3.New(var_378_25.x, var_378_25.y, var_378_25.z)

				local var_378_26 = var_378_20.localEulerAngles

				var_378_26.z = 0
				var_378_26.x = 0
				var_378_20.localEulerAngles = var_378_26
			end

			if arg_375_1.time_ >= var_378_21 + var_378_22 and arg_375_1.time_ < var_378_21 + var_378_22 + arg_378_0 then
				var_378_20.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_378_27 = manager.ui.mainCamera.transform.position - var_378_20.position

				var_378_20.forward = Vector3.New(var_378_27.x, var_378_27.y, var_378_27.z)

				local var_378_28 = var_378_20.localEulerAngles

				var_378_28.z = 0
				var_378_28.x = 0
				var_378_20.localEulerAngles = var_378_28
			end

			local var_378_29 = arg_375_1.actors_["1074ui_story"]
			local var_378_30 = 0

			if var_378_30 < arg_375_1.time_ and arg_375_1.time_ <= var_378_30 + arg_378_0 and not isNil(var_378_29) and arg_375_1.var_.characterEffect1074ui_story == nil then
				arg_375_1.var_.characterEffect1074ui_story = var_378_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_31 = 0.200000002980232

			if var_378_30 <= arg_375_1.time_ and arg_375_1.time_ < var_378_30 + var_378_31 and not isNil(var_378_29) then
				local var_378_32 = (arg_375_1.time_ - var_378_30) / var_378_31

				if arg_375_1.var_.characterEffect1074ui_story and not isNil(var_378_29) then
					local var_378_33 = Mathf.Lerp(0, 0.5, var_378_32)

					arg_375_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_375_1.var_.characterEffect1074ui_story.fillRatio = var_378_33
				end
			end

			if arg_375_1.time_ >= var_378_30 + var_378_31 and arg_375_1.time_ < var_378_30 + var_378_31 + arg_378_0 and not isNil(var_378_29) and arg_375_1.var_.characterEffect1074ui_story then
				local var_378_34 = 0.5

				arg_375_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_375_1.var_.characterEffect1074ui_story.fillRatio = var_378_34
			end

			local var_378_35 = 0

			if var_378_35 < arg_375_1.time_ and arg_375_1.time_ <= var_378_35 + arg_378_0 then
				arg_375_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_378_36 = arg_375_1.actors_["1072ui_story"]
			local var_378_37 = 0
			local var_378_38 = 0.1

			if var_378_37 < arg_375_1.time_ and arg_375_1.time_ <= var_378_37 + arg_378_0 then
				if arg_375_1.var_.characterEffect1072ui_story == nil then
					arg_375_1.var_.characterEffect1072ui_story = var_378_36:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_375_1.var_.characterEffect1072ui_story.imageEffect:turnOn(false)
			end

			local var_378_39 = arg_375_1.actors_["1072ui_story"]
			local var_378_40 = 0

			if var_378_40 < arg_375_1.time_ and arg_375_1.time_ <= var_378_40 + arg_378_0 then
				if arg_375_1.var_.characterEffect1072ui_story == nil then
					arg_375_1.var_.characterEffect1072ui_story = var_378_39:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_378_41 = arg_375_1.var_.characterEffect1072ui_story

				var_378_41.imageEffect:turnOff()

				var_378_41.interferenceEffect.enabled = true
				var_378_41.interferenceEffect.noise = 0.001
				var_378_41.interferenceEffect.simTimeScale = 1
				var_378_41.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_378_42 = 0
			local var_378_43 = 0.475

			if var_378_42 < arg_375_1.time_ and arg_375_1.time_ <= var_378_42 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_44 = arg_375_1:FormatText(StoryNameCfg[379].name)

				arg_375_1.leftNameTxt_.text = var_378_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_45 = arg_375_1:GetWordFromCfg(222031093)
				local var_378_46 = arg_375_1:FormatText(var_378_45.content)

				arg_375_1.text_.text = var_378_46

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_47 = 19
				local var_378_48 = utf8.len(var_378_46)
				local var_378_49 = var_378_47 <= 0 and var_378_43 or var_378_43 * (var_378_48 / var_378_47)

				if var_378_49 > 0 and var_378_43 < var_378_49 then
					arg_375_1.talkMaxDuration = var_378_49

					if var_378_49 + var_378_42 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_49 + var_378_42
					end
				end

				arg_375_1.text_.text = var_378_46
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031093", "story_v_out_222031.awb") ~= 0 then
					local var_378_50 = manager.audio:GetVoiceLength("story_v_out_222031", "222031093", "story_v_out_222031.awb") / 1000

					if var_378_50 + var_378_42 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_50 + var_378_42
					end

					if var_378_45.prefab_name ~= "" and arg_375_1.actors_[var_378_45.prefab_name] ~= nil then
						local var_378_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_45.prefab_name].transform, "story_v_out_222031", "222031093", "story_v_out_222031.awb")

						arg_375_1:RecordAudio("222031093", var_378_51)
						arg_375_1:RecordAudio("222031093", var_378_51)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_222031", "222031093", "story_v_out_222031.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_222031", "222031093", "story_v_out_222031.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_52 = math.max(var_378_43, arg_375_1.talkMaxDuration)

			if var_378_42 <= arg_375_1.time_ and arg_375_1.time_ < var_378_42 + var_378_52 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_42) / var_378_52

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_42 + var_378_52 and arg_375_1.time_ < var_378_42 + var_378_52 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play222031094 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 222031094
		arg_379_1.duration_ = 10.8

		local var_379_0 = {
			ja = 10.8,
			ko = 6.633,
			zh = 6.633
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
				arg_379_0:Play222031095(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1074ui_story"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1074ui_story == nil then
				arg_379_1.var_.characterEffect1074ui_story = var_382_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.characterEffect1074ui_story and not isNil(var_382_0) then
					arg_379_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1074ui_story then
				arg_379_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_382_4 = 0

			if var_382_4 < arg_379_1.time_ and arg_379_1.time_ <= var_382_4 + arg_382_0 then
				arg_379_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_382_5 = 0

			if var_382_5 < arg_379_1.time_ and arg_379_1.time_ <= var_382_5 + arg_382_0 then
				arg_379_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_382_6 = arg_379_1.actors_["1072ui_story"]
			local var_382_7 = 0

			if var_382_7 < arg_379_1.time_ and arg_379_1.time_ <= var_382_7 + arg_382_0 and not isNil(var_382_6) and arg_379_1.var_.characterEffect1072ui_story == nil then
				arg_379_1.var_.characterEffect1072ui_story = var_382_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_8 = 0.200000002980232

			if var_382_7 <= arg_379_1.time_ and arg_379_1.time_ < var_382_7 + var_382_8 and not isNil(var_382_6) then
				local var_382_9 = (arg_379_1.time_ - var_382_7) / var_382_8

				if arg_379_1.var_.characterEffect1072ui_story and not isNil(var_382_6) then
					local var_382_10 = Mathf.Lerp(0, 0.5, var_382_9)

					arg_379_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1072ui_story.fillRatio = var_382_10
				end
			end

			if arg_379_1.time_ >= var_382_7 + var_382_8 and arg_379_1.time_ < var_382_7 + var_382_8 + arg_382_0 and not isNil(var_382_6) and arg_379_1.var_.characterEffect1072ui_story then
				local var_382_11 = 0.5

				arg_379_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1072ui_story.fillRatio = var_382_11
			end

			local var_382_12 = 0
			local var_382_13 = 0.775

			if var_382_12 < arg_379_1.time_ and arg_379_1.time_ <= var_382_12 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_14 = arg_379_1:FormatText(StoryNameCfg[410].name)

				arg_379_1.leftNameTxt_.text = var_382_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_15 = arg_379_1:GetWordFromCfg(222031094)
				local var_382_16 = arg_379_1:FormatText(var_382_15.content)

				arg_379_1.text_.text = var_382_16

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_17 = 31
				local var_382_18 = utf8.len(var_382_16)
				local var_382_19 = var_382_17 <= 0 and var_382_13 or var_382_13 * (var_382_18 / var_382_17)

				if var_382_19 > 0 and var_382_13 < var_382_19 then
					arg_379_1.talkMaxDuration = var_382_19

					if var_382_19 + var_382_12 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_19 + var_382_12
					end
				end

				arg_379_1.text_.text = var_382_16
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031094", "story_v_out_222031.awb") ~= 0 then
					local var_382_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031094", "story_v_out_222031.awb") / 1000

					if var_382_20 + var_382_12 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_20 + var_382_12
					end

					if var_382_15.prefab_name ~= "" and arg_379_1.actors_[var_382_15.prefab_name] ~= nil then
						local var_382_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_15.prefab_name].transform, "story_v_out_222031", "222031094", "story_v_out_222031.awb")

						arg_379_1:RecordAudio("222031094", var_382_21)
						arg_379_1:RecordAudio("222031094", var_382_21)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_222031", "222031094", "story_v_out_222031.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_222031", "222031094", "story_v_out_222031.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_22 = math.max(var_382_13, arg_379_1.talkMaxDuration)

			if var_382_12 <= arg_379_1.time_ and arg_379_1.time_ < var_382_12 + var_382_22 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_12) / var_382_22

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_12 + var_382_22 and arg_379_1.time_ < var_382_12 + var_382_22 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play222031095 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 222031095
		arg_383_1.duration_ = 8.33

		local var_383_0 = {
			ja = 8.333,
			ko = 3.566,
			zh = 3.566
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play222031096(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0
			local var_386_1 = 0.425

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_2 = arg_383_1:FormatText(StoryNameCfg[410].name)

				arg_383_1.leftNameTxt_.text = var_386_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_3 = arg_383_1:GetWordFromCfg(222031095)
				local var_386_4 = arg_383_1:FormatText(var_386_3.content)

				arg_383_1.text_.text = var_386_4

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 17
				local var_386_6 = utf8.len(var_386_4)
				local var_386_7 = var_386_5 <= 0 and var_386_1 or var_386_1 * (var_386_6 / var_386_5)

				if var_386_7 > 0 and var_386_1 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_0
					end
				end

				arg_383_1.text_.text = var_386_4
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031095", "story_v_out_222031.awb") ~= 0 then
					local var_386_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031095", "story_v_out_222031.awb") / 1000

					if var_386_8 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_8 + var_386_0
					end

					if var_386_3.prefab_name ~= "" and arg_383_1.actors_[var_386_3.prefab_name] ~= nil then
						local var_386_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_3.prefab_name].transform, "story_v_out_222031", "222031095", "story_v_out_222031.awb")

						arg_383_1:RecordAudio("222031095", var_386_9)
						arg_383_1:RecordAudio("222031095", var_386_9)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_222031", "222031095", "story_v_out_222031.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_222031", "222031095", "story_v_out_222031.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_10 = math.max(var_386_1, arg_383_1.talkMaxDuration)

			if var_386_0 <= arg_383_1.time_ and arg_383_1.time_ < var_386_0 + var_386_10 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_0) / var_386_10

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_0 + var_386_10 and arg_383_1.time_ < var_386_0 + var_386_10 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play222031096 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 222031096
		arg_387_1.duration_ = 5.13

		local var_387_0 = {
			ja = 5.133,
			ko = 3.266,
			zh = 3.266
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play222031097(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["1072ui_story"]
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 and not isNil(var_390_0) and arg_387_1.var_.characterEffect1072ui_story == nil then
				arg_387_1.var_.characterEffect1072ui_story = var_390_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_2 = 0.200000002980232

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_2 and not isNil(var_390_0) then
				local var_390_3 = (arg_387_1.time_ - var_390_1) / var_390_2

				if arg_387_1.var_.characterEffect1072ui_story and not isNil(var_390_0) then
					arg_387_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= var_390_1 + var_390_2 and arg_387_1.time_ < var_390_1 + var_390_2 + arg_390_0 and not isNil(var_390_0) and arg_387_1.var_.characterEffect1072ui_story then
				arg_387_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_390_4 = 0

			if var_390_4 < arg_387_1.time_ and arg_387_1.time_ <= var_390_4 + arg_390_0 then
				arg_387_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			local var_390_5 = 0

			if var_390_5 < arg_387_1.time_ and arg_387_1.time_ <= var_390_5 + arg_390_0 then
				arg_387_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_390_6 = arg_387_1.actors_["1074ui_story"]
			local var_390_7 = 0

			if var_390_7 < arg_387_1.time_ and arg_387_1.time_ <= var_390_7 + arg_390_0 and not isNil(var_390_6) and arg_387_1.var_.characterEffect1074ui_story == nil then
				arg_387_1.var_.characterEffect1074ui_story = var_390_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_8 = 0.200000002980232

			if var_390_7 <= arg_387_1.time_ and arg_387_1.time_ < var_390_7 + var_390_8 and not isNil(var_390_6) then
				local var_390_9 = (arg_387_1.time_ - var_390_7) / var_390_8

				if arg_387_1.var_.characterEffect1074ui_story and not isNil(var_390_6) then
					local var_390_10 = Mathf.Lerp(0, 0.5, var_390_9)

					arg_387_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_387_1.var_.characterEffect1074ui_story.fillRatio = var_390_10
				end
			end

			if arg_387_1.time_ >= var_390_7 + var_390_8 and arg_387_1.time_ < var_390_7 + var_390_8 + arg_390_0 and not isNil(var_390_6) and arg_387_1.var_.characterEffect1074ui_story then
				local var_390_11 = 0.5

				arg_387_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_387_1.var_.characterEffect1074ui_story.fillRatio = var_390_11
			end

			local var_390_12 = 0
			local var_390_13 = 0.475

			if var_390_12 < arg_387_1.time_ and arg_387_1.time_ <= var_390_12 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_14 = arg_387_1:FormatText(StoryNameCfg[379].name)

				arg_387_1.leftNameTxt_.text = var_390_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_15 = arg_387_1:GetWordFromCfg(222031096)
				local var_390_16 = arg_387_1:FormatText(var_390_15.content)

				arg_387_1.text_.text = var_390_16

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_17 = 19
				local var_390_18 = utf8.len(var_390_16)
				local var_390_19 = var_390_17 <= 0 and var_390_13 or var_390_13 * (var_390_18 / var_390_17)

				if var_390_19 > 0 and var_390_13 < var_390_19 then
					arg_387_1.talkMaxDuration = var_390_19

					if var_390_19 + var_390_12 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_19 + var_390_12
					end
				end

				arg_387_1.text_.text = var_390_16
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031096", "story_v_out_222031.awb") ~= 0 then
					local var_390_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031096", "story_v_out_222031.awb") / 1000

					if var_390_20 + var_390_12 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_20 + var_390_12
					end

					if var_390_15.prefab_name ~= "" and arg_387_1.actors_[var_390_15.prefab_name] ~= nil then
						local var_390_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_15.prefab_name].transform, "story_v_out_222031", "222031096", "story_v_out_222031.awb")

						arg_387_1:RecordAudio("222031096", var_390_21)
						arg_387_1:RecordAudio("222031096", var_390_21)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_222031", "222031096", "story_v_out_222031.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_222031", "222031096", "story_v_out_222031.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_22 = math.max(var_390_13, arg_387_1.talkMaxDuration)

			if var_390_12 <= arg_387_1.time_ and arg_387_1.time_ < var_390_12 + var_390_22 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_12) / var_390_22

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_12 + var_390_22 and arg_387_1.time_ < var_390_12 + var_390_22 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play222031097 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 222031097
		arg_391_1.duration_ = 8.77

		local var_391_0 = {
			ja = 8.766,
			ko = 2.933,
			zh = 2.933
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play222031098(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1074ui_story"]
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.characterEffect1074ui_story == nil then
				arg_391_1.var_.characterEffect1074ui_story = var_394_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_2 = 0.200000002980232

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 and not isNil(var_394_0) then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2

				if arg_391_1.var_.characterEffect1074ui_story and not isNil(var_394_0) then
					arg_391_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.characterEffect1074ui_story then
				arg_391_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_394_4 = arg_391_1.actors_["1072ui_story"]
			local var_394_5 = 0

			if var_394_5 < arg_391_1.time_ and arg_391_1.time_ <= var_394_5 + arg_394_0 and not isNil(var_394_4) and arg_391_1.var_.characterEffect1072ui_story == nil then
				arg_391_1.var_.characterEffect1072ui_story = var_394_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_6 = 0.200000002980232

			if var_394_5 <= arg_391_1.time_ and arg_391_1.time_ < var_394_5 + var_394_6 and not isNil(var_394_4) then
				local var_394_7 = (arg_391_1.time_ - var_394_5) / var_394_6

				if arg_391_1.var_.characterEffect1072ui_story and not isNil(var_394_4) then
					local var_394_8 = Mathf.Lerp(0, 0.5, var_394_7)

					arg_391_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1072ui_story.fillRatio = var_394_8
				end
			end

			if arg_391_1.time_ >= var_394_5 + var_394_6 and arg_391_1.time_ < var_394_5 + var_394_6 + arg_394_0 and not isNil(var_394_4) and arg_391_1.var_.characterEffect1072ui_story then
				local var_394_9 = 0.5

				arg_391_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1072ui_story.fillRatio = var_394_9
			end

			local var_394_10 = 0
			local var_394_11 = 0.35

			if var_394_10 < arg_391_1.time_ and arg_391_1.time_ <= var_394_10 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_12 = arg_391_1:FormatText(StoryNameCfg[410].name)

				arg_391_1.leftNameTxt_.text = var_394_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_13 = arg_391_1:GetWordFromCfg(222031097)
				local var_394_14 = arg_391_1:FormatText(var_394_13.content)

				arg_391_1.text_.text = var_394_14

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_15 = 14
				local var_394_16 = utf8.len(var_394_14)
				local var_394_17 = var_394_15 <= 0 and var_394_11 or var_394_11 * (var_394_16 / var_394_15)

				if var_394_17 > 0 and var_394_11 < var_394_17 then
					arg_391_1.talkMaxDuration = var_394_17

					if var_394_17 + var_394_10 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_17 + var_394_10
					end
				end

				arg_391_1.text_.text = var_394_14
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031097", "story_v_out_222031.awb") ~= 0 then
					local var_394_18 = manager.audio:GetVoiceLength("story_v_out_222031", "222031097", "story_v_out_222031.awb") / 1000

					if var_394_18 + var_394_10 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_18 + var_394_10
					end

					if var_394_13.prefab_name ~= "" and arg_391_1.actors_[var_394_13.prefab_name] ~= nil then
						local var_394_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_13.prefab_name].transform, "story_v_out_222031", "222031097", "story_v_out_222031.awb")

						arg_391_1:RecordAudio("222031097", var_394_19)
						arg_391_1:RecordAudio("222031097", var_394_19)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_222031", "222031097", "story_v_out_222031.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_222031", "222031097", "story_v_out_222031.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_20 = math.max(var_394_11, arg_391_1.talkMaxDuration)

			if var_394_10 <= arg_391_1.time_ and arg_391_1.time_ < var_394_10 + var_394_20 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_10) / var_394_20

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_10 + var_394_20 and arg_391_1.time_ < var_394_10 + var_394_20 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play222031098 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 222031098
		arg_395_1.duration_ = 2

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play222031099(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = arg_395_1.actors_["1072ui_story"]
			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.characterEffect1072ui_story == nil then
				arg_395_1.var_.characterEffect1072ui_story = var_398_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.200000002980232

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_2 and not isNil(var_398_0) then
				local var_398_3 = (arg_395_1.time_ - var_398_1) / var_398_2

				if arg_395_1.var_.characterEffect1072ui_story and not isNil(var_398_0) then
					arg_395_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= var_398_1 + var_398_2 and arg_395_1.time_ < var_398_1 + var_398_2 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.characterEffect1072ui_story then
				arg_395_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_398_4 = 0

			if var_398_4 < arg_395_1.time_ and arg_395_1.time_ <= var_398_4 + arg_398_0 then
				arg_395_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			local var_398_5 = 0

			if var_398_5 < arg_395_1.time_ and arg_395_1.time_ <= var_398_5 + arg_398_0 then
				arg_395_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_398_6 = arg_395_1.actors_["1074ui_story"]
			local var_398_7 = 0

			if var_398_7 < arg_395_1.time_ and arg_395_1.time_ <= var_398_7 + arg_398_0 and not isNil(var_398_6) and arg_395_1.var_.characterEffect1074ui_story == nil then
				arg_395_1.var_.characterEffect1074ui_story = var_398_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_8 = 0.200000002980232

			if var_398_7 <= arg_395_1.time_ and arg_395_1.time_ < var_398_7 + var_398_8 and not isNil(var_398_6) then
				local var_398_9 = (arg_395_1.time_ - var_398_7) / var_398_8

				if arg_395_1.var_.characterEffect1074ui_story and not isNil(var_398_6) then
					local var_398_10 = Mathf.Lerp(0, 0.5, var_398_9)

					arg_395_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_395_1.var_.characterEffect1074ui_story.fillRatio = var_398_10
				end
			end

			if arg_395_1.time_ >= var_398_7 + var_398_8 and arg_395_1.time_ < var_398_7 + var_398_8 + arg_398_0 and not isNil(var_398_6) and arg_395_1.var_.characterEffect1074ui_story then
				local var_398_11 = 0.5

				arg_395_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_395_1.var_.characterEffect1074ui_story.fillRatio = var_398_11
			end

			local var_398_12 = 0
			local var_398_13 = 0.1

			if var_398_12 < arg_395_1.time_ and arg_395_1.time_ <= var_398_12 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_14 = arg_395_1:FormatText(StoryNameCfg[379].name)

				arg_395_1.leftNameTxt_.text = var_398_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_15 = arg_395_1:GetWordFromCfg(222031098)
				local var_398_16 = arg_395_1:FormatText(var_398_15.content)

				arg_395_1.text_.text = var_398_16

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_17 = 4
				local var_398_18 = utf8.len(var_398_16)
				local var_398_19 = var_398_17 <= 0 and var_398_13 or var_398_13 * (var_398_18 / var_398_17)

				if var_398_19 > 0 and var_398_13 < var_398_19 then
					arg_395_1.talkMaxDuration = var_398_19

					if var_398_19 + var_398_12 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_19 + var_398_12
					end
				end

				arg_395_1.text_.text = var_398_16
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031098", "story_v_out_222031.awb") ~= 0 then
					local var_398_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031098", "story_v_out_222031.awb") / 1000

					if var_398_20 + var_398_12 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_20 + var_398_12
					end

					if var_398_15.prefab_name ~= "" and arg_395_1.actors_[var_398_15.prefab_name] ~= nil then
						local var_398_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_15.prefab_name].transform, "story_v_out_222031", "222031098", "story_v_out_222031.awb")

						arg_395_1:RecordAudio("222031098", var_398_21)
						arg_395_1:RecordAudio("222031098", var_398_21)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_222031", "222031098", "story_v_out_222031.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_222031", "222031098", "story_v_out_222031.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_22 = math.max(var_398_13, arg_395_1.talkMaxDuration)

			if var_398_12 <= arg_395_1.time_ and arg_395_1.time_ < var_398_12 + var_398_22 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_12) / var_398_22

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_12 + var_398_22 and arg_395_1.time_ < var_398_12 + var_398_22 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play222031099 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 222031099
		arg_399_1.duration_ = 12.9

		local var_399_0 = {
			ja = 12.9,
			ko = 5.833,
			zh = 5.966
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play222031100(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["1074ui_story"]
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1074ui_story == nil then
				arg_399_1.var_.characterEffect1074ui_story = var_402_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_2 = 0.200000002980232

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_2 and not isNil(var_402_0) then
				local var_402_3 = (arg_399_1.time_ - var_402_1) / var_402_2

				if arg_399_1.var_.characterEffect1074ui_story and not isNil(var_402_0) then
					arg_399_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= var_402_1 + var_402_2 and arg_399_1.time_ < var_402_1 + var_402_2 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1074ui_story then
				arg_399_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_402_4 = arg_399_1.actors_["1072ui_story"]
			local var_402_5 = 0

			if var_402_5 < arg_399_1.time_ and arg_399_1.time_ <= var_402_5 + arg_402_0 and not isNil(var_402_4) and arg_399_1.var_.characterEffect1072ui_story == nil then
				arg_399_1.var_.characterEffect1072ui_story = var_402_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_6 = 0.200000002980232

			if var_402_5 <= arg_399_1.time_ and arg_399_1.time_ < var_402_5 + var_402_6 and not isNil(var_402_4) then
				local var_402_7 = (arg_399_1.time_ - var_402_5) / var_402_6

				if arg_399_1.var_.characterEffect1072ui_story and not isNil(var_402_4) then
					local var_402_8 = Mathf.Lerp(0, 0.5, var_402_7)

					arg_399_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1072ui_story.fillRatio = var_402_8
				end
			end

			if arg_399_1.time_ >= var_402_5 + var_402_6 and arg_399_1.time_ < var_402_5 + var_402_6 + arg_402_0 and not isNil(var_402_4) and arg_399_1.var_.characterEffect1072ui_story then
				local var_402_9 = 0.5

				arg_399_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1072ui_story.fillRatio = var_402_9
			end

			local var_402_10 = 0
			local var_402_11 = 0.7

			if var_402_10 < arg_399_1.time_ and arg_399_1.time_ <= var_402_10 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_12 = arg_399_1:FormatText(StoryNameCfg[410].name)

				arg_399_1.leftNameTxt_.text = var_402_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_13 = arg_399_1:GetWordFromCfg(222031099)
				local var_402_14 = arg_399_1:FormatText(var_402_13.content)

				arg_399_1.text_.text = var_402_14

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_15 = 28
				local var_402_16 = utf8.len(var_402_14)
				local var_402_17 = var_402_15 <= 0 and var_402_11 or var_402_11 * (var_402_16 / var_402_15)

				if var_402_17 > 0 and var_402_11 < var_402_17 then
					arg_399_1.talkMaxDuration = var_402_17

					if var_402_17 + var_402_10 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_17 + var_402_10
					end
				end

				arg_399_1.text_.text = var_402_14
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031099", "story_v_out_222031.awb") ~= 0 then
					local var_402_18 = manager.audio:GetVoiceLength("story_v_out_222031", "222031099", "story_v_out_222031.awb") / 1000

					if var_402_18 + var_402_10 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_18 + var_402_10
					end

					if var_402_13.prefab_name ~= "" and arg_399_1.actors_[var_402_13.prefab_name] ~= nil then
						local var_402_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_13.prefab_name].transform, "story_v_out_222031", "222031099", "story_v_out_222031.awb")

						arg_399_1:RecordAudio("222031099", var_402_19)
						arg_399_1:RecordAudio("222031099", var_402_19)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_222031", "222031099", "story_v_out_222031.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_222031", "222031099", "story_v_out_222031.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_20 = math.max(var_402_11, arg_399_1.talkMaxDuration)

			if var_402_10 <= arg_399_1.time_ and arg_399_1.time_ < var_402_10 + var_402_20 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_10) / var_402_20

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_10 + var_402_20 and arg_399_1.time_ < var_402_10 + var_402_20 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play222031100 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 222031100
		arg_403_1.duration_ = 4.37

		local var_403_0 = {
			ja = 4.366,
			ko = 2.3,
			zh = 2.3
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
				arg_403_0:Play222031101(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["1072ui_story"]
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.characterEffect1072ui_story == nil then
				arg_403_1.var_.characterEffect1072ui_story = var_406_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.200000002980232

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_2 and not isNil(var_406_0) then
				local var_406_3 = (arg_403_1.time_ - var_406_1) / var_406_2

				if arg_403_1.var_.characterEffect1072ui_story and not isNil(var_406_0) then
					arg_403_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= var_406_1 + var_406_2 and arg_403_1.time_ < var_406_1 + var_406_2 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.characterEffect1072ui_story then
				arg_403_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_406_4 = 0

			if var_406_4 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_1")
			end

			local var_406_5 = 0

			if var_406_5 < arg_403_1.time_ and arg_403_1.time_ <= var_406_5 + arg_406_0 then
				arg_403_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_406_6 = arg_403_1.actors_["1074ui_story"]
			local var_406_7 = 0

			if var_406_7 < arg_403_1.time_ and arg_403_1.time_ <= var_406_7 + arg_406_0 and not isNil(var_406_6) and arg_403_1.var_.characterEffect1074ui_story == nil then
				arg_403_1.var_.characterEffect1074ui_story = var_406_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_8 = 0.200000002980232

			if var_406_7 <= arg_403_1.time_ and arg_403_1.time_ < var_406_7 + var_406_8 and not isNil(var_406_6) then
				local var_406_9 = (arg_403_1.time_ - var_406_7) / var_406_8

				if arg_403_1.var_.characterEffect1074ui_story and not isNil(var_406_6) then
					local var_406_10 = Mathf.Lerp(0, 0.5, var_406_9)

					arg_403_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1074ui_story.fillRatio = var_406_10
				end
			end

			if arg_403_1.time_ >= var_406_7 + var_406_8 and arg_403_1.time_ < var_406_7 + var_406_8 + arg_406_0 and not isNil(var_406_6) and arg_403_1.var_.characterEffect1074ui_story then
				local var_406_11 = 0.5

				arg_403_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1074ui_story.fillRatio = var_406_11
			end

			local var_406_12 = 0
			local var_406_13 = 0.225

			if var_406_12 < arg_403_1.time_ and arg_403_1.time_ <= var_406_12 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_14 = arg_403_1:FormatText(StoryNameCfg[379].name)

				arg_403_1.leftNameTxt_.text = var_406_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_15 = arg_403_1:GetWordFromCfg(222031100)
				local var_406_16 = arg_403_1:FormatText(var_406_15.content)

				arg_403_1.text_.text = var_406_16

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_17 = 9
				local var_406_18 = utf8.len(var_406_16)
				local var_406_19 = var_406_17 <= 0 and var_406_13 or var_406_13 * (var_406_18 / var_406_17)

				if var_406_19 > 0 and var_406_13 < var_406_19 then
					arg_403_1.talkMaxDuration = var_406_19

					if var_406_19 + var_406_12 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_19 + var_406_12
					end
				end

				arg_403_1.text_.text = var_406_16
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031100", "story_v_out_222031.awb") ~= 0 then
					local var_406_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031100", "story_v_out_222031.awb") / 1000

					if var_406_20 + var_406_12 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_20 + var_406_12
					end

					if var_406_15.prefab_name ~= "" and arg_403_1.actors_[var_406_15.prefab_name] ~= nil then
						local var_406_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_15.prefab_name].transform, "story_v_out_222031", "222031100", "story_v_out_222031.awb")

						arg_403_1:RecordAudio("222031100", var_406_21)
						arg_403_1:RecordAudio("222031100", var_406_21)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_222031", "222031100", "story_v_out_222031.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_222031", "222031100", "story_v_out_222031.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_22 = math.max(var_406_13, arg_403_1.talkMaxDuration)

			if var_406_12 <= arg_403_1.time_ and arg_403_1.time_ < var_406_12 + var_406_22 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_12) / var_406_22

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_12 + var_406_22 and arg_403_1.time_ < var_406_12 + var_406_22 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play222031101 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 222031101
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play222031102(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["1072ui_story"].transform
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.var_.moveOldPos1072ui_story = var_410_0.localPosition
			end

			local var_410_2 = 0.001

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_2 then
				local var_410_3 = (arg_407_1.time_ - var_410_1) / var_410_2
				local var_410_4 = Vector3.New(0, 100, 0)

				var_410_0.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1072ui_story, var_410_4, var_410_3)

				local var_410_5 = manager.ui.mainCamera.transform.position - var_410_0.position

				var_410_0.forward = Vector3.New(var_410_5.x, var_410_5.y, var_410_5.z)

				local var_410_6 = var_410_0.localEulerAngles

				var_410_6.z = 0
				var_410_6.x = 0
				var_410_0.localEulerAngles = var_410_6
			end

			if arg_407_1.time_ >= var_410_1 + var_410_2 and arg_407_1.time_ < var_410_1 + var_410_2 + arg_410_0 then
				var_410_0.localPosition = Vector3.New(0, 100, 0)

				local var_410_7 = manager.ui.mainCamera.transform.position - var_410_0.position

				var_410_0.forward = Vector3.New(var_410_7.x, var_410_7.y, var_410_7.z)

				local var_410_8 = var_410_0.localEulerAngles

				var_410_8.z = 0
				var_410_8.x = 0
				var_410_0.localEulerAngles = var_410_8
			end

			local var_410_9 = arg_407_1.actors_["1072ui_story"]
			local var_410_10 = 0

			if var_410_10 < arg_407_1.time_ and arg_407_1.time_ <= var_410_10 + arg_410_0 and not isNil(var_410_9) and arg_407_1.var_.characterEffect1072ui_story == nil then
				arg_407_1.var_.characterEffect1072ui_story = var_410_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_11 = 0.200000002980232

			if var_410_10 <= arg_407_1.time_ and arg_407_1.time_ < var_410_10 + var_410_11 and not isNil(var_410_9) then
				local var_410_12 = (arg_407_1.time_ - var_410_10) / var_410_11

				if arg_407_1.var_.characterEffect1072ui_story and not isNil(var_410_9) then
					local var_410_13 = Mathf.Lerp(0, 0.5, var_410_12)

					arg_407_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_407_1.var_.characterEffect1072ui_story.fillRatio = var_410_13
				end
			end

			if arg_407_1.time_ >= var_410_10 + var_410_11 and arg_407_1.time_ < var_410_10 + var_410_11 + arg_410_0 and not isNil(var_410_9) and arg_407_1.var_.characterEffect1072ui_story then
				local var_410_14 = 0.5

				arg_407_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_407_1.var_.characterEffect1072ui_story.fillRatio = var_410_14
			end

			local var_410_15 = 0
			local var_410_16 = 1.025

			if var_410_15 < arg_407_1.time_ and arg_407_1.time_ <= var_410_15 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_17 = arg_407_1:GetWordFromCfg(222031101)
				local var_410_18 = arg_407_1:FormatText(var_410_17.content)

				arg_407_1.text_.text = var_410_18

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_19 = 41
				local var_410_20 = utf8.len(var_410_18)
				local var_410_21 = var_410_19 <= 0 and var_410_16 or var_410_16 * (var_410_20 / var_410_19)

				if var_410_21 > 0 and var_410_16 < var_410_21 then
					arg_407_1.talkMaxDuration = var_410_21

					if var_410_21 + var_410_15 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_21 + var_410_15
					end
				end

				arg_407_1.text_.text = var_410_18
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_22 = math.max(var_410_16, arg_407_1.talkMaxDuration)

			if var_410_15 <= arg_407_1.time_ and arg_407_1.time_ < var_410_15 + var_410_22 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_15) / var_410_22

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_15 + var_410_22 and arg_407_1.time_ < var_410_15 + var_410_22 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play222031102 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 222031102
		arg_411_1.duration_ = 2.4

		local var_411_0 = {
			ja = 2.4,
			ko = 2.066,
			zh = 2.066
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play222031103(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1072ui_story"].transform
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.var_.moveOldPos1072ui_story = var_414_0.localPosition
			end

			local var_414_2 = 0.001

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2
				local var_414_4 = Vector3.New(-0.7, -0.71, -6)

				var_414_0.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1072ui_story, var_414_4, var_414_3)

				local var_414_5 = manager.ui.mainCamera.transform.position - var_414_0.position

				var_414_0.forward = Vector3.New(var_414_5.x, var_414_5.y, var_414_5.z)

				local var_414_6 = var_414_0.localEulerAngles

				var_414_6.z = 0
				var_414_6.x = 0
				var_414_0.localEulerAngles = var_414_6
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 then
				var_414_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_414_7 = manager.ui.mainCamera.transform.position - var_414_0.position

				var_414_0.forward = Vector3.New(var_414_7.x, var_414_7.y, var_414_7.z)

				local var_414_8 = var_414_0.localEulerAngles

				var_414_8.z = 0
				var_414_8.x = 0
				var_414_0.localEulerAngles = var_414_8
			end

			local var_414_9 = arg_411_1.actors_["1072ui_story"]
			local var_414_10 = 0

			if var_414_10 < arg_411_1.time_ and arg_411_1.time_ <= var_414_10 + arg_414_0 and not isNil(var_414_9) and arg_411_1.var_.characterEffect1072ui_story == nil then
				arg_411_1.var_.characterEffect1072ui_story = var_414_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_11 = 0.200000002980232

			if var_414_10 <= arg_411_1.time_ and arg_411_1.time_ < var_414_10 + var_414_11 and not isNil(var_414_9) then
				local var_414_12 = (arg_411_1.time_ - var_414_10) / var_414_11

				if arg_411_1.var_.characterEffect1072ui_story and not isNil(var_414_9) then
					arg_411_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_411_1.time_ >= var_414_10 + var_414_11 and arg_411_1.time_ < var_414_10 + var_414_11 + arg_414_0 and not isNil(var_414_9) and arg_411_1.var_.characterEffect1072ui_story then
				arg_411_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_414_13 = 0

			if var_414_13 < arg_411_1.time_ and arg_411_1.time_ <= var_414_13 + arg_414_0 then
				arg_411_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_414_14 = 0

			if var_414_14 < arg_411_1.time_ and arg_411_1.time_ <= var_414_14 + arg_414_0 then
				arg_411_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_414_15 = 0
			local var_414_16 = 0.1

			if var_414_15 < arg_411_1.time_ and arg_411_1.time_ <= var_414_15 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_17 = arg_411_1:FormatText(StoryNameCfg[379].name)

				arg_411_1.leftNameTxt_.text = var_414_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_18 = arg_411_1:GetWordFromCfg(222031102)
				local var_414_19 = arg_411_1:FormatText(var_414_18.content)

				arg_411_1.text_.text = var_414_19

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_20 = 4
				local var_414_21 = utf8.len(var_414_19)
				local var_414_22 = var_414_20 <= 0 and var_414_16 or var_414_16 * (var_414_21 / var_414_20)

				if var_414_22 > 0 and var_414_16 < var_414_22 then
					arg_411_1.talkMaxDuration = var_414_22

					if var_414_22 + var_414_15 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_22 + var_414_15
					end
				end

				arg_411_1.text_.text = var_414_19
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031102", "story_v_out_222031.awb") ~= 0 then
					local var_414_23 = manager.audio:GetVoiceLength("story_v_out_222031", "222031102", "story_v_out_222031.awb") / 1000

					if var_414_23 + var_414_15 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_23 + var_414_15
					end

					if var_414_18.prefab_name ~= "" and arg_411_1.actors_[var_414_18.prefab_name] ~= nil then
						local var_414_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_18.prefab_name].transform, "story_v_out_222031", "222031102", "story_v_out_222031.awb")

						arg_411_1:RecordAudio("222031102", var_414_24)
						arg_411_1:RecordAudio("222031102", var_414_24)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_222031", "222031102", "story_v_out_222031.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_222031", "222031102", "story_v_out_222031.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_25 = math.max(var_414_16, arg_411_1.talkMaxDuration)

			if var_414_15 <= arg_411_1.time_ and arg_411_1.time_ < var_414_15 + var_414_25 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_15) / var_414_25

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_15 + var_414_25 and arg_411_1.time_ < var_414_15 + var_414_25 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play222031103 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 222031103
		arg_415_1.duration_ = 2.6

		local var_415_0 = {
			ja = 2.6,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_415_0:Play222031104(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["1074ui_story"]
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.characterEffect1074ui_story == nil then
				arg_415_1.var_.characterEffect1074ui_story = var_418_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_2 = 0.200000002980232

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 and not isNil(var_418_0) then
				local var_418_3 = (arg_415_1.time_ - var_418_1) / var_418_2

				if arg_415_1.var_.characterEffect1074ui_story and not isNil(var_418_0) then
					arg_415_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.characterEffect1074ui_story then
				arg_415_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_418_4 = 0

			if var_418_4 < arg_415_1.time_ and arg_415_1.time_ <= var_418_4 + arg_418_0 then
				arg_415_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_418_5 = 0

			if var_418_5 < arg_415_1.time_ and arg_415_1.time_ <= var_418_5 + arg_418_0 then
				arg_415_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_418_6 = arg_415_1.actors_["1072ui_story"]
			local var_418_7 = 0

			if var_418_7 < arg_415_1.time_ and arg_415_1.time_ <= var_418_7 + arg_418_0 and not isNil(var_418_6) and arg_415_1.var_.characterEffect1072ui_story == nil then
				arg_415_1.var_.characterEffect1072ui_story = var_418_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_8 = 0.200000002980232

			if var_418_7 <= arg_415_1.time_ and arg_415_1.time_ < var_418_7 + var_418_8 and not isNil(var_418_6) then
				local var_418_9 = (arg_415_1.time_ - var_418_7) / var_418_8

				if arg_415_1.var_.characterEffect1072ui_story and not isNil(var_418_6) then
					local var_418_10 = Mathf.Lerp(0, 0.5, var_418_9)

					arg_415_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_415_1.var_.characterEffect1072ui_story.fillRatio = var_418_10
				end
			end

			if arg_415_1.time_ >= var_418_7 + var_418_8 and arg_415_1.time_ < var_418_7 + var_418_8 + arg_418_0 and not isNil(var_418_6) and arg_415_1.var_.characterEffect1072ui_story then
				local var_418_11 = 0.5

				arg_415_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_415_1.var_.characterEffect1072ui_story.fillRatio = var_418_11
			end

			local var_418_12 = 0
			local var_418_13 = 0.125

			if var_418_12 < arg_415_1.time_ and arg_415_1.time_ <= var_418_12 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_14 = arg_415_1:FormatText(StoryNameCfg[410].name)

				arg_415_1.leftNameTxt_.text = var_418_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_15 = arg_415_1:GetWordFromCfg(222031103)
				local var_418_16 = arg_415_1:FormatText(var_418_15.content)

				arg_415_1.text_.text = var_418_16

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_17 = 5
				local var_418_18 = utf8.len(var_418_16)
				local var_418_19 = var_418_17 <= 0 and var_418_13 or var_418_13 * (var_418_18 / var_418_17)

				if var_418_19 > 0 and var_418_13 < var_418_19 then
					arg_415_1.talkMaxDuration = var_418_19

					if var_418_19 + var_418_12 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_19 + var_418_12
					end
				end

				arg_415_1.text_.text = var_418_16
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031103", "story_v_out_222031.awb") ~= 0 then
					local var_418_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031103", "story_v_out_222031.awb") / 1000

					if var_418_20 + var_418_12 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_20 + var_418_12
					end

					if var_418_15.prefab_name ~= "" and arg_415_1.actors_[var_418_15.prefab_name] ~= nil then
						local var_418_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_15.prefab_name].transform, "story_v_out_222031", "222031103", "story_v_out_222031.awb")

						arg_415_1:RecordAudio("222031103", var_418_21)
						arg_415_1:RecordAudio("222031103", var_418_21)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_222031", "222031103", "story_v_out_222031.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_222031", "222031103", "story_v_out_222031.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_22 = math.max(var_418_13, arg_415_1.talkMaxDuration)

			if var_418_12 <= arg_415_1.time_ and arg_415_1.time_ < var_418_12 + var_418_22 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_12) / var_418_22

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_12 + var_418_22 and arg_415_1.time_ < var_418_12 + var_418_22 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play222031104 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 222031104
		arg_419_1.duration_ = 12.8

		local var_419_0 = {
			ja = 12.8,
			ko = 9.6,
			zh = 9.6
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play222031105(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["1072ui_story"]
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 and not isNil(var_422_0) and arg_419_1.var_.characterEffect1072ui_story == nil then
				arg_419_1.var_.characterEffect1072ui_story = var_422_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_2 = 0.200000002980232

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 and not isNil(var_422_0) then
				local var_422_3 = (arg_419_1.time_ - var_422_1) / var_422_2

				if arg_419_1.var_.characterEffect1072ui_story and not isNil(var_422_0) then
					arg_419_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 and not isNil(var_422_0) and arg_419_1.var_.characterEffect1072ui_story then
				arg_419_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_422_4 = 0

			if var_422_4 < arg_419_1.time_ and arg_419_1.time_ <= var_422_4 + arg_422_0 then
				arg_419_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_1")
			end

			local var_422_5 = 0

			if var_422_5 < arg_419_1.time_ and arg_419_1.time_ <= var_422_5 + arg_422_0 then
				arg_419_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_422_6 = arg_419_1.actors_["1074ui_story"]
			local var_422_7 = 0

			if var_422_7 < arg_419_1.time_ and arg_419_1.time_ <= var_422_7 + arg_422_0 and not isNil(var_422_6) and arg_419_1.var_.characterEffect1074ui_story == nil then
				arg_419_1.var_.characterEffect1074ui_story = var_422_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_8 = 0.200000002980232

			if var_422_7 <= arg_419_1.time_ and arg_419_1.time_ < var_422_7 + var_422_8 and not isNil(var_422_6) then
				local var_422_9 = (arg_419_1.time_ - var_422_7) / var_422_8

				if arg_419_1.var_.characterEffect1074ui_story and not isNil(var_422_6) then
					local var_422_10 = Mathf.Lerp(0, 0.5, var_422_9)

					arg_419_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_419_1.var_.characterEffect1074ui_story.fillRatio = var_422_10
				end
			end

			if arg_419_1.time_ >= var_422_7 + var_422_8 and arg_419_1.time_ < var_422_7 + var_422_8 + arg_422_0 and not isNil(var_422_6) and arg_419_1.var_.characterEffect1074ui_story then
				local var_422_11 = 0.5

				arg_419_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_419_1.var_.characterEffect1074ui_story.fillRatio = var_422_11
			end

			local var_422_12 = 0
			local var_422_13 = 1.075

			if var_422_12 < arg_419_1.time_ and arg_419_1.time_ <= var_422_12 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_14 = arg_419_1:FormatText(StoryNameCfg[379].name)

				arg_419_1.leftNameTxt_.text = var_422_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_15 = arg_419_1:GetWordFromCfg(222031104)
				local var_422_16 = arg_419_1:FormatText(var_422_15.content)

				arg_419_1.text_.text = var_422_16

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_17 = 43
				local var_422_18 = utf8.len(var_422_16)
				local var_422_19 = var_422_17 <= 0 and var_422_13 or var_422_13 * (var_422_18 / var_422_17)

				if var_422_19 > 0 and var_422_13 < var_422_19 then
					arg_419_1.talkMaxDuration = var_422_19

					if var_422_19 + var_422_12 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_19 + var_422_12
					end
				end

				arg_419_1.text_.text = var_422_16
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031104", "story_v_out_222031.awb") ~= 0 then
					local var_422_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031104", "story_v_out_222031.awb") / 1000

					if var_422_20 + var_422_12 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_20 + var_422_12
					end

					if var_422_15.prefab_name ~= "" and arg_419_1.actors_[var_422_15.prefab_name] ~= nil then
						local var_422_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_15.prefab_name].transform, "story_v_out_222031", "222031104", "story_v_out_222031.awb")

						arg_419_1:RecordAudio("222031104", var_422_21)
						arg_419_1:RecordAudio("222031104", var_422_21)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_222031", "222031104", "story_v_out_222031.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_222031", "222031104", "story_v_out_222031.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_22 = math.max(var_422_13, arg_419_1.talkMaxDuration)

			if var_422_12 <= arg_419_1.time_ and arg_419_1.time_ < var_422_12 + var_422_22 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_12) / var_422_22

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_12 + var_422_22 and arg_419_1.time_ < var_422_12 + var_422_22 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play222031105 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 222031105
		arg_423_1.duration_ = 18.8

		local var_423_0 = {
			ja = 18.8,
			ko = 10.4,
			zh = 10.4
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play222031106(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_2")
			end

			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
				arg_423_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_426_2 = 0
			local var_426_3 = 1.325

			if var_426_2 < arg_423_1.time_ and arg_423_1.time_ <= var_426_2 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_4 = arg_423_1:FormatText(StoryNameCfg[379].name)

				arg_423_1.leftNameTxt_.text = var_426_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_5 = arg_423_1:GetWordFromCfg(222031105)
				local var_426_6 = arg_423_1:FormatText(var_426_5.content)

				arg_423_1.text_.text = var_426_6

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_7 = 53
				local var_426_8 = utf8.len(var_426_6)
				local var_426_9 = var_426_7 <= 0 and var_426_3 or var_426_3 * (var_426_8 / var_426_7)

				if var_426_9 > 0 and var_426_3 < var_426_9 then
					arg_423_1.talkMaxDuration = var_426_9

					if var_426_9 + var_426_2 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_9 + var_426_2
					end
				end

				arg_423_1.text_.text = var_426_6
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031105", "story_v_out_222031.awb") ~= 0 then
					local var_426_10 = manager.audio:GetVoiceLength("story_v_out_222031", "222031105", "story_v_out_222031.awb") / 1000

					if var_426_10 + var_426_2 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_10 + var_426_2
					end

					if var_426_5.prefab_name ~= "" and arg_423_1.actors_[var_426_5.prefab_name] ~= nil then
						local var_426_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_5.prefab_name].transform, "story_v_out_222031", "222031105", "story_v_out_222031.awb")

						arg_423_1:RecordAudio("222031105", var_426_11)
						arg_423_1:RecordAudio("222031105", var_426_11)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_222031", "222031105", "story_v_out_222031.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_222031", "222031105", "story_v_out_222031.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_12 = math.max(var_426_3, arg_423_1.talkMaxDuration)

			if var_426_2 <= arg_423_1.time_ and arg_423_1.time_ < var_426_2 + var_426_12 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_2) / var_426_12

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_2 + var_426_12 and arg_423_1.time_ < var_426_2 + var_426_12 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play222031106 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 222031106
		arg_427_1.duration_ = 20.37

		local var_427_0 = {
			ja = 20.366,
			ko = 12.333,
			zh = 12.333
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
				arg_427_0:Play222031107(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0
			local var_430_1 = 1.425

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_2 = arg_427_1:FormatText(StoryNameCfg[379].name)

				arg_427_1.leftNameTxt_.text = var_430_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_3 = arg_427_1:GetWordFromCfg(222031106)
				local var_430_4 = arg_427_1:FormatText(var_430_3.content)

				arg_427_1.text_.text = var_430_4

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 57
				local var_430_6 = utf8.len(var_430_4)
				local var_430_7 = var_430_5 <= 0 and var_430_1 or var_430_1 * (var_430_6 / var_430_5)

				if var_430_7 > 0 and var_430_1 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_0
					end
				end

				arg_427_1.text_.text = var_430_4
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031106", "story_v_out_222031.awb") ~= 0 then
					local var_430_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031106", "story_v_out_222031.awb") / 1000

					if var_430_8 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_8 + var_430_0
					end

					if var_430_3.prefab_name ~= "" and arg_427_1.actors_[var_430_3.prefab_name] ~= nil then
						local var_430_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_3.prefab_name].transform, "story_v_out_222031", "222031106", "story_v_out_222031.awb")

						arg_427_1:RecordAudio("222031106", var_430_9)
						arg_427_1:RecordAudio("222031106", var_430_9)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_222031", "222031106", "story_v_out_222031.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_222031", "222031106", "story_v_out_222031.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_10 = math.max(var_430_1, arg_427_1.talkMaxDuration)

			if var_430_0 <= arg_427_1.time_ and arg_427_1.time_ < var_430_0 + var_430_10 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_0) / var_430_10

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_0 + var_430_10 and arg_427_1.time_ < var_430_0 + var_430_10 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play222031107 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 222031107
		arg_431_1.duration_ = 4.03

		local var_431_0 = {
			ja = 4.033,
			ko = 3.566,
			zh = 3.566
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play222031108(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1074ui_story"]
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1074ui_story == nil then
				arg_431_1.var_.characterEffect1074ui_story = var_434_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_2 = 0.200000002980232

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 and not isNil(var_434_0) then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2

				if arg_431_1.var_.characterEffect1074ui_story and not isNil(var_434_0) then
					arg_431_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1074ui_story then
				arg_431_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_434_4 = 0

			if var_434_4 < arg_431_1.time_ and arg_431_1.time_ <= var_434_4 + arg_434_0 then
				arg_431_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_434_5 = 0

			if var_434_5 < arg_431_1.time_ and arg_431_1.time_ <= var_434_5 + arg_434_0 then
				arg_431_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_434_6 = arg_431_1.actors_["1072ui_story"]
			local var_434_7 = 0

			if var_434_7 < arg_431_1.time_ and arg_431_1.time_ <= var_434_7 + arg_434_0 and not isNil(var_434_6) and arg_431_1.var_.characterEffect1072ui_story == nil then
				arg_431_1.var_.characterEffect1072ui_story = var_434_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_8 = 0.200000002980232

			if var_434_7 <= arg_431_1.time_ and arg_431_1.time_ < var_434_7 + var_434_8 and not isNil(var_434_6) then
				local var_434_9 = (arg_431_1.time_ - var_434_7) / var_434_8

				if arg_431_1.var_.characterEffect1072ui_story and not isNil(var_434_6) then
					local var_434_10 = Mathf.Lerp(0, 0.5, var_434_9)

					arg_431_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1072ui_story.fillRatio = var_434_10
				end
			end

			if arg_431_1.time_ >= var_434_7 + var_434_8 and arg_431_1.time_ < var_434_7 + var_434_8 + arg_434_0 and not isNil(var_434_6) and arg_431_1.var_.characterEffect1072ui_story then
				local var_434_11 = 0.5

				arg_431_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1072ui_story.fillRatio = var_434_11
			end

			local var_434_12 = 0
			local var_434_13 = 0.4

			if var_434_12 < arg_431_1.time_ and arg_431_1.time_ <= var_434_12 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_14 = arg_431_1:FormatText(StoryNameCfg[410].name)

				arg_431_1.leftNameTxt_.text = var_434_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_15 = arg_431_1:GetWordFromCfg(222031107)
				local var_434_16 = arg_431_1:FormatText(var_434_15.content)

				arg_431_1.text_.text = var_434_16

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_17 = 16
				local var_434_18 = utf8.len(var_434_16)
				local var_434_19 = var_434_17 <= 0 and var_434_13 or var_434_13 * (var_434_18 / var_434_17)

				if var_434_19 > 0 and var_434_13 < var_434_19 then
					arg_431_1.talkMaxDuration = var_434_19

					if var_434_19 + var_434_12 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_19 + var_434_12
					end
				end

				arg_431_1.text_.text = var_434_16
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031107", "story_v_out_222031.awb") ~= 0 then
					local var_434_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031107", "story_v_out_222031.awb") / 1000

					if var_434_20 + var_434_12 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_20 + var_434_12
					end

					if var_434_15.prefab_name ~= "" and arg_431_1.actors_[var_434_15.prefab_name] ~= nil then
						local var_434_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_15.prefab_name].transform, "story_v_out_222031", "222031107", "story_v_out_222031.awb")

						arg_431_1:RecordAudio("222031107", var_434_21)
						arg_431_1:RecordAudio("222031107", var_434_21)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_222031", "222031107", "story_v_out_222031.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_222031", "222031107", "story_v_out_222031.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_22 = math.max(var_434_13, arg_431_1.talkMaxDuration)

			if var_434_12 <= arg_431_1.time_ and arg_431_1.time_ < var_434_12 + var_434_22 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_12) / var_434_22

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_12 + var_434_22 and arg_431_1.time_ < var_434_12 + var_434_22 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play222031108 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 222031108
		arg_435_1.duration_ = 14.87

		local var_435_0 = {
			ja = 14.866,
			ko = 8.8,
			zh = 8.8
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
				arg_435_0:Play222031109(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1072ui_story"]
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1072ui_story == nil then
				arg_435_1.var_.characterEffect1072ui_story = var_438_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_2 = 0.200000002980232

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 and not isNil(var_438_0) then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2

				if arg_435_1.var_.characterEffect1072ui_story and not isNil(var_438_0) then
					arg_435_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1072ui_story then
				arg_435_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_438_4 = 0

			if var_438_4 < arg_435_1.time_ and arg_435_1.time_ <= var_438_4 + arg_438_0 then
				arg_435_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_438_5 = 0

			if var_438_5 < arg_435_1.time_ and arg_435_1.time_ <= var_438_5 + arg_438_0 then
				arg_435_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_438_6 = arg_435_1.actors_["1074ui_story"]
			local var_438_7 = 0

			if var_438_7 < arg_435_1.time_ and arg_435_1.time_ <= var_438_7 + arg_438_0 and not isNil(var_438_6) and arg_435_1.var_.characterEffect1074ui_story == nil then
				arg_435_1.var_.characterEffect1074ui_story = var_438_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_8 = 0.200000002980232

			if var_438_7 <= arg_435_1.time_ and arg_435_1.time_ < var_438_7 + var_438_8 and not isNil(var_438_6) then
				local var_438_9 = (arg_435_1.time_ - var_438_7) / var_438_8

				if arg_435_1.var_.characterEffect1074ui_story and not isNil(var_438_6) then
					local var_438_10 = Mathf.Lerp(0, 0.5, var_438_9)

					arg_435_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1074ui_story.fillRatio = var_438_10
				end
			end

			if arg_435_1.time_ >= var_438_7 + var_438_8 and arg_435_1.time_ < var_438_7 + var_438_8 + arg_438_0 and not isNil(var_438_6) and arg_435_1.var_.characterEffect1074ui_story then
				local var_438_11 = 0.5

				arg_435_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1074ui_story.fillRatio = var_438_11
			end

			local var_438_12 = 0
			local var_438_13 = 1.1

			if var_438_12 < arg_435_1.time_ and arg_435_1.time_ <= var_438_12 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_14 = arg_435_1:FormatText(StoryNameCfg[379].name)

				arg_435_1.leftNameTxt_.text = var_438_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_15 = arg_435_1:GetWordFromCfg(222031108)
				local var_438_16 = arg_435_1:FormatText(var_438_15.content)

				arg_435_1.text_.text = var_438_16

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_17 = 44
				local var_438_18 = utf8.len(var_438_16)
				local var_438_19 = var_438_17 <= 0 and var_438_13 or var_438_13 * (var_438_18 / var_438_17)

				if var_438_19 > 0 and var_438_13 < var_438_19 then
					arg_435_1.talkMaxDuration = var_438_19

					if var_438_19 + var_438_12 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_19 + var_438_12
					end
				end

				arg_435_1.text_.text = var_438_16
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031108", "story_v_out_222031.awb") ~= 0 then
					local var_438_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031108", "story_v_out_222031.awb") / 1000

					if var_438_20 + var_438_12 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_20 + var_438_12
					end

					if var_438_15.prefab_name ~= "" and arg_435_1.actors_[var_438_15.prefab_name] ~= nil then
						local var_438_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_15.prefab_name].transform, "story_v_out_222031", "222031108", "story_v_out_222031.awb")

						arg_435_1:RecordAudio("222031108", var_438_21)
						arg_435_1:RecordAudio("222031108", var_438_21)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_222031", "222031108", "story_v_out_222031.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_222031", "222031108", "story_v_out_222031.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_22 = math.max(var_438_13, arg_435_1.talkMaxDuration)

			if var_438_12 <= arg_435_1.time_ and arg_435_1.time_ < var_438_12 + var_438_22 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_12) / var_438_22

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_12 + var_438_22 and arg_435_1.time_ < var_438_12 + var_438_22 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play222031109 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 222031109
		arg_439_1.duration_ = 18.57

		local var_439_0 = {
			ja = 18.566,
			ko = 10.133,
			zh = 10.133
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
				arg_439_0:Play222031110(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 1.25

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_2 = arg_439_1:FormatText(StoryNameCfg[379].name)

				arg_439_1.leftNameTxt_.text = var_442_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_3 = arg_439_1:GetWordFromCfg(222031109)
				local var_442_4 = arg_439_1:FormatText(var_442_3.content)

				arg_439_1.text_.text = var_442_4

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 50
				local var_442_6 = utf8.len(var_442_4)
				local var_442_7 = var_442_5 <= 0 and var_442_1 or var_442_1 * (var_442_6 / var_442_5)

				if var_442_7 > 0 and var_442_1 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_4
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031109", "story_v_out_222031.awb") ~= 0 then
					local var_442_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031109", "story_v_out_222031.awb") / 1000

					if var_442_8 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_8 + var_442_0
					end

					if var_442_3.prefab_name ~= "" and arg_439_1.actors_[var_442_3.prefab_name] ~= nil then
						local var_442_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_3.prefab_name].transform, "story_v_out_222031", "222031109", "story_v_out_222031.awb")

						arg_439_1:RecordAudio("222031109", var_442_9)
						arg_439_1:RecordAudio("222031109", var_442_9)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_222031", "222031109", "story_v_out_222031.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_222031", "222031109", "story_v_out_222031.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_10 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_10 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_10

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_10 and arg_439_1.time_ < var_442_0 + var_442_10 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play222031110 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 222031110
		arg_443_1.duration_ = 8.37

		local var_443_0 = {
			ja = 8.366,
			ko = 7.333,
			zh = 7.3
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play222031111(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0

			if var_446_0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_0 + arg_446_0 then
				arg_443_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 then
				arg_443_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_446_2 = 0
			local var_446_3 = 0.975

			if var_446_2 < arg_443_1.time_ and arg_443_1.time_ <= var_446_2 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_4 = arg_443_1:FormatText(StoryNameCfg[379].name)

				arg_443_1.leftNameTxt_.text = var_446_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_5 = arg_443_1:GetWordFromCfg(222031110)
				local var_446_6 = arg_443_1:FormatText(var_446_5.content)

				arg_443_1.text_.text = var_446_6

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_7 = 39
				local var_446_8 = utf8.len(var_446_6)
				local var_446_9 = var_446_7 <= 0 and var_446_3 or var_446_3 * (var_446_8 / var_446_7)

				if var_446_9 > 0 and var_446_3 < var_446_9 then
					arg_443_1.talkMaxDuration = var_446_9

					if var_446_9 + var_446_2 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_9 + var_446_2
					end
				end

				arg_443_1.text_.text = var_446_6
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031110", "story_v_out_222031.awb") ~= 0 then
					local var_446_10 = manager.audio:GetVoiceLength("story_v_out_222031", "222031110", "story_v_out_222031.awb") / 1000

					if var_446_10 + var_446_2 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_10 + var_446_2
					end

					if var_446_5.prefab_name ~= "" and arg_443_1.actors_[var_446_5.prefab_name] ~= nil then
						local var_446_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_5.prefab_name].transform, "story_v_out_222031", "222031110", "story_v_out_222031.awb")

						arg_443_1:RecordAudio("222031110", var_446_11)
						arg_443_1:RecordAudio("222031110", var_446_11)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_222031", "222031110", "story_v_out_222031.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_222031", "222031110", "story_v_out_222031.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_12 = math.max(var_446_3, arg_443_1.talkMaxDuration)

			if var_446_2 <= arg_443_1.time_ and arg_443_1.time_ < var_446_2 + var_446_12 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_2) / var_446_12

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_2 + var_446_12 and arg_443_1.time_ < var_446_2 + var_446_12 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play222031111 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 222031111
		arg_447_1.duration_ = 2.9

		local var_447_0 = {
			ja = 2.4,
			ko = 2.9,
			zh = 2.9
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
				arg_447_0:Play222031112(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = arg_447_1.actors_["1074ui_story"]
			local var_450_1 = 0

			if var_450_1 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 and not isNil(var_450_0) and arg_447_1.var_.characterEffect1074ui_story == nil then
				arg_447_1.var_.characterEffect1074ui_story = var_450_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_2 = 0.200000002980232

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_2 and not isNil(var_450_0) then
				local var_450_3 = (arg_447_1.time_ - var_450_1) / var_450_2

				if arg_447_1.var_.characterEffect1074ui_story and not isNil(var_450_0) then
					arg_447_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_447_1.time_ >= var_450_1 + var_450_2 and arg_447_1.time_ < var_450_1 + var_450_2 + arg_450_0 and not isNil(var_450_0) and arg_447_1.var_.characterEffect1074ui_story then
				arg_447_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_450_4 = 0

			if var_450_4 < arg_447_1.time_ and arg_447_1.time_ <= var_450_4 + arg_450_0 then
				arg_447_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_450_5 = 0

			if var_450_5 < arg_447_1.time_ and arg_447_1.time_ <= var_450_5 + arg_450_0 then
				arg_447_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_450_6 = arg_447_1.actors_["1072ui_story"]
			local var_450_7 = 0

			if var_450_7 < arg_447_1.time_ and arg_447_1.time_ <= var_450_7 + arg_450_0 and not isNil(var_450_6) and arg_447_1.var_.characterEffect1072ui_story == nil then
				arg_447_1.var_.characterEffect1072ui_story = var_450_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_8 = 0.200000002980232

			if var_450_7 <= arg_447_1.time_ and arg_447_1.time_ < var_450_7 + var_450_8 and not isNil(var_450_6) then
				local var_450_9 = (arg_447_1.time_ - var_450_7) / var_450_8

				if arg_447_1.var_.characterEffect1072ui_story and not isNil(var_450_6) then
					local var_450_10 = Mathf.Lerp(0, 0.5, var_450_9)

					arg_447_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_447_1.var_.characterEffect1072ui_story.fillRatio = var_450_10
				end
			end

			if arg_447_1.time_ >= var_450_7 + var_450_8 and arg_447_1.time_ < var_450_7 + var_450_8 + arg_450_0 and not isNil(var_450_6) and arg_447_1.var_.characterEffect1072ui_story then
				local var_450_11 = 0.5

				arg_447_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_447_1.var_.characterEffect1072ui_story.fillRatio = var_450_11
			end

			local var_450_12 = 0
			local var_450_13 = 0.325

			if var_450_12 < arg_447_1.time_ and arg_447_1.time_ <= var_450_12 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_14 = arg_447_1:FormatText(StoryNameCfg[410].name)

				arg_447_1.leftNameTxt_.text = var_450_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_15 = arg_447_1:GetWordFromCfg(222031111)
				local var_450_16 = arg_447_1:FormatText(var_450_15.content)

				arg_447_1.text_.text = var_450_16

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_17 = 13
				local var_450_18 = utf8.len(var_450_16)
				local var_450_19 = var_450_17 <= 0 and var_450_13 or var_450_13 * (var_450_18 / var_450_17)

				if var_450_19 > 0 and var_450_13 < var_450_19 then
					arg_447_1.talkMaxDuration = var_450_19

					if var_450_19 + var_450_12 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_19 + var_450_12
					end
				end

				arg_447_1.text_.text = var_450_16
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031111", "story_v_out_222031.awb") ~= 0 then
					local var_450_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031111", "story_v_out_222031.awb") / 1000

					if var_450_20 + var_450_12 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_20 + var_450_12
					end

					if var_450_15.prefab_name ~= "" and arg_447_1.actors_[var_450_15.prefab_name] ~= nil then
						local var_450_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_15.prefab_name].transform, "story_v_out_222031", "222031111", "story_v_out_222031.awb")

						arg_447_1:RecordAudio("222031111", var_450_21)
						arg_447_1:RecordAudio("222031111", var_450_21)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_222031", "222031111", "story_v_out_222031.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_222031", "222031111", "story_v_out_222031.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_22 = math.max(var_450_13, arg_447_1.talkMaxDuration)

			if var_450_12 <= arg_447_1.time_ and arg_447_1.time_ < var_450_12 + var_450_22 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_12) / var_450_22

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_12 + var_450_22 and arg_447_1.time_ < var_450_12 + var_450_22 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play222031112 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 222031112
		arg_451_1.duration_ = 5.37

		local var_451_0 = {
			ja = 5.366,
			ko = 2.7,
			zh = 2.7
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play222031113(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["1072ui_story"]
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.characterEffect1072ui_story == nil then
				arg_451_1.var_.characterEffect1072ui_story = var_454_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_2 = 0.200000002980232

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_2 and not isNil(var_454_0) then
				local var_454_3 = (arg_451_1.time_ - var_454_1) / var_454_2

				if arg_451_1.var_.characterEffect1072ui_story and not isNil(var_454_0) then
					arg_451_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= var_454_1 + var_454_2 and arg_451_1.time_ < var_454_1 + var_454_2 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.characterEffect1072ui_story then
				arg_451_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_454_4 = 0

			if var_454_4 < arg_451_1.time_ and arg_451_1.time_ <= var_454_4 + arg_454_0 then
				arg_451_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_2")
			end

			local var_454_5 = 0

			if var_454_5 < arg_451_1.time_ and arg_451_1.time_ <= var_454_5 + arg_454_0 then
				arg_451_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_454_6 = arg_451_1.actors_["1074ui_story"]
			local var_454_7 = 0

			if var_454_7 < arg_451_1.time_ and arg_451_1.time_ <= var_454_7 + arg_454_0 and not isNil(var_454_6) and arg_451_1.var_.characterEffect1074ui_story == nil then
				arg_451_1.var_.characterEffect1074ui_story = var_454_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_8 = 0.200000002980232

			if var_454_7 <= arg_451_1.time_ and arg_451_1.time_ < var_454_7 + var_454_8 and not isNil(var_454_6) then
				local var_454_9 = (arg_451_1.time_ - var_454_7) / var_454_8

				if arg_451_1.var_.characterEffect1074ui_story and not isNil(var_454_6) then
					local var_454_10 = Mathf.Lerp(0, 0.5, var_454_9)

					arg_451_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_451_1.var_.characterEffect1074ui_story.fillRatio = var_454_10
				end
			end

			if arg_451_1.time_ >= var_454_7 + var_454_8 and arg_451_1.time_ < var_454_7 + var_454_8 + arg_454_0 and not isNil(var_454_6) and arg_451_1.var_.characterEffect1074ui_story then
				local var_454_11 = 0.5

				arg_451_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_451_1.var_.characterEffect1074ui_story.fillRatio = var_454_11
			end

			local var_454_12 = 0
			local var_454_13 = 0.275

			if var_454_12 < arg_451_1.time_ and arg_451_1.time_ <= var_454_12 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_14 = arg_451_1:FormatText(StoryNameCfg[379].name)

				arg_451_1.leftNameTxt_.text = var_454_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_15 = arg_451_1:GetWordFromCfg(222031112)
				local var_454_16 = arg_451_1:FormatText(var_454_15.content)

				arg_451_1.text_.text = var_454_16

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_17 = 11
				local var_454_18 = utf8.len(var_454_16)
				local var_454_19 = var_454_17 <= 0 and var_454_13 or var_454_13 * (var_454_18 / var_454_17)

				if var_454_19 > 0 and var_454_13 < var_454_19 then
					arg_451_1.talkMaxDuration = var_454_19

					if var_454_19 + var_454_12 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_19 + var_454_12
					end
				end

				arg_451_1.text_.text = var_454_16
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031112", "story_v_out_222031.awb") ~= 0 then
					local var_454_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031112", "story_v_out_222031.awb") / 1000

					if var_454_20 + var_454_12 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_20 + var_454_12
					end

					if var_454_15.prefab_name ~= "" and arg_451_1.actors_[var_454_15.prefab_name] ~= nil then
						local var_454_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_15.prefab_name].transform, "story_v_out_222031", "222031112", "story_v_out_222031.awb")

						arg_451_1:RecordAudio("222031112", var_454_21)
						arg_451_1:RecordAudio("222031112", var_454_21)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_222031", "222031112", "story_v_out_222031.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_222031", "222031112", "story_v_out_222031.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_22 = math.max(var_454_13, arg_451_1.talkMaxDuration)

			if var_454_12 <= arg_451_1.time_ and arg_451_1.time_ < var_454_12 + var_454_22 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_12) / var_454_22

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_12 + var_454_22 and arg_451_1.time_ < var_454_12 + var_454_22 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play222031113 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 222031113
		arg_455_1.duration_ = 21.03

		local var_455_0 = {
			ja = 21.033,
			ko = 10.533,
			zh = 10.533
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
				arg_455_0:Play222031114(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0
			local var_458_1 = 1.1

			if var_458_0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_2 = arg_455_1:FormatText(StoryNameCfg[379].name)

				arg_455_1.leftNameTxt_.text = var_458_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_3 = arg_455_1:GetWordFromCfg(222031113)
				local var_458_4 = arg_455_1:FormatText(var_458_3.content)

				arg_455_1.text_.text = var_458_4

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_5 = 44
				local var_458_6 = utf8.len(var_458_4)
				local var_458_7 = var_458_5 <= 0 and var_458_1 or var_458_1 * (var_458_6 / var_458_5)

				if var_458_7 > 0 and var_458_1 < var_458_7 then
					arg_455_1.talkMaxDuration = var_458_7

					if var_458_7 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_7 + var_458_0
					end
				end

				arg_455_1.text_.text = var_458_4
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031113", "story_v_out_222031.awb") ~= 0 then
					local var_458_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031113", "story_v_out_222031.awb") / 1000

					if var_458_8 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_8 + var_458_0
					end

					if var_458_3.prefab_name ~= "" and arg_455_1.actors_[var_458_3.prefab_name] ~= nil then
						local var_458_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_3.prefab_name].transform, "story_v_out_222031", "222031113", "story_v_out_222031.awb")

						arg_455_1:RecordAudio("222031113", var_458_9)
						arg_455_1:RecordAudio("222031113", var_458_9)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_222031", "222031113", "story_v_out_222031.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_222031", "222031113", "story_v_out_222031.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_10 = math.max(var_458_1, arg_455_1.talkMaxDuration)

			if var_458_0 <= arg_455_1.time_ and arg_455_1.time_ < var_458_0 + var_458_10 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_0) / var_458_10

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_0 + var_458_10 and arg_455_1.time_ < var_458_0 + var_458_10 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play222031114 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 222031114
		arg_459_1.duration_ = 11.53

		local var_459_0 = {
			ja = 11.533,
			ko = 5,
			zh = 5.066
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play222031115(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = arg_459_1.actors_["1074ui_story"]
			local var_462_1 = 0

			if var_462_1 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 and not isNil(var_462_0) and arg_459_1.var_.characterEffect1074ui_story == nil then
				arg_459_1.var_.characterEffect1074ui_story = var_462_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_2 = 0.200000002980232

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_2 and not isNil(var_462_0) then
				local var_462_3 = (arg_459_1.time_ - var_462_1) / var_462_2

				if arg_459_1.var_.characterEffect1074ui_story and not isNil(var_462_0) then
					arg_459_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_459_1.time_ >= var_462_1 + var_462_2 and arg_459_1.time_ < var_462_1 + var_462_2 + arg_462_0 and not isNil(var_462_0) and arg_459_1.var_.characterEffect1074ui_story then
				arg_459_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_462_4 = 0

			if var_462_4 < arg_459_1.time_ and arg_459_1.time_ <= var_462_4 + arg_462_0 then
				arg_459_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			local var_462_5 = 0

			if var_462_5 < arg_459_1.time_ and arg_459_1.time_ <= var_462_5 + arg_462_0 then
				arg_459_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_462_6 = arg_459_1.actors_["1072ui_story"]
			local var_462_7 = 0

			if var_462_7 < arg_459_1.time_ and arg_459_1.time_ <= var_462_7 + arg_462_0 and not isNil(var_462_6) and arg_459_1.var_.characterEffect1072ui_story == nil then
				arg_459_1.var_.characterEffect1072ui_story = var_462_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_8 = 0.200000002980232

			if var_462_7 <= arg_459_1.time_ and arg_459_1.time_ < var_462_7 + var_462_8 and not isNil(var_462_6) then
				local var_462_9 = (arg_459_1.time_ - var_462_7) / var_462_8

				if arg_459_1.var_.characterEffect1072ui_story and not isNil(var_462_6) then
					local var_462_10 = Mathf.Lerp(0, 0.5, var_462_9)

					arg_459_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_459_1.var_.characterEffect1072ui_story.fillRatio = var_462_10
				end
			end

			if arg_459_1.time_ >= var_462_7 + var_462_8 and arg_459_1.time_ < var_462_7 + var_462_8 + arg_462_0 and not isNil(var_462_6) and arg_459_1.var_.characterEffect1072ui_story then
				local var_462_11 = 0.5

				arg_459_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_459_1.var_.characterEffect1072ui_story.fillRatio = var_462_11
			end

			local var_462_12 = 0
			local var_462_13 = 0.675

			if var_462_12 < arg_459_1.time_ and arg_459_1.time_ <= var_462_12 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_14 = arg_459_1:FormatText(StoryNameCfg[410].name)

				arg_459_1.leftNameTxt_.text = var_462_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_15 = arg_459_1:GetWordFromCfg(222031114)
				local var_462_16 = arg_459_1:FormatText(var_462_15.content)

				arg_459_1.text_.text = var_462_16

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_17 = 27
				local var_462_18 = utf8.len(var_462_16)
				local var_462_19 = var_462_17 <= 0 and var_462_13 or var_462_13 * (var_462_18 / var_462_17)

				if var_462_19 > 0 and var_462_13 < var_462_19 then
					arg_459_1.talkMaxDuration = var_462_19

					if var_462_19 + var_462_12 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_19 + var_462_12
					end
				end

				arg_459_1.text_.text = var_462_16
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031114", "story_v_out_222031.awb") ~= 0 then
					local var_462_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031114", "story_v_out_222031.awb") / 1000

					if var_462_20 + var_462_12 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_20 + var_462_12
					end

					if var_462_15.prefab_name ~= "" and arg_459_1.actors_[var_462_15.prefab_name] ~= nil then
						local var_462_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_15.prefab_name].transform, "story_v_out_222031", "222031114", "story_v_out_222031.awb")

						arg_459_1:RecordAudio("222031114", var_462_21)
						arg_459_1:RecordAudio("222031114", var_462_21)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_222031", "222031114", "story_v_out_222031.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_222031", "222031114", "story_v_out_222031.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_22 = math.max(var_462_13, arg_459_1.talkMaxDuration)

			if var_462_12 <= arg_459_1.time_ and arg_459_1.time_ < var_462_12 + var_462_22 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_12) / var_462_22

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_12 + var_462_22 and arg_459_1.time_ < var_462_12 + var_462_22 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play222031115 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 222031115
		arg_463_1.duration_ = 11.07

		local var_463_0 = {
			ja = 11.066,
			ko = 7.5,
			zh = 7.5
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
				arg_463_0:Play222031116(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = arg_463_1.actors_["1072ui_story"]
			local var_466_1 = 0

			if var_466_1 < arg_463_1.time_ and arg_463_1.time_ <= var_466_1 + arg_466_0 and not isNil(var_466_0) and arg_463_1.var_.characterEffect1072ui_story == nil then
				arg_463_1.var_.characterEffect1072ui_story = var_466_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_2 = 0.200000002980232

			if var_466_1 <= arg_463_1.time_ and arg_463_1.time_ < var_466_1 + var_466_2 and not isNil(var_466_0) then
				local var_466_3 = (arg_463_1.time_ - var_466_1) / var_466_2

				if arg_463_1.var_.characterEffect1072ui_story and not isNil(var_466_0) then
					arg_463_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_463_1.time_ >= var_466_1 + var_466_2 and arg_463_1.time_ < var_466_1 + var_466_2 + arg_466_0 and not isNil(var_466_0) and arg_463_1.var_.characterEffect1072ui_story then
				arg_463_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_466_4 = arg_463_1.actors_["1074ui_story"]
			local var_466_5 = 0

			if var_466_5 < arg_463_1.time_ and arg_463_1.time_ <= var_466_5 + arg_466_0 and not isNil(var_466_4) and arg_463_1.var_.characterEffect1074ui_story == nil then
				arg_463_1.var_.characterEffect1074ui_story = var_466_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_6 = 0.200000002980232

			if var_466_5 <= arg_463_1.time_ and arg_463_1.time_ < var_466_5 + var_466_6 and not isNil(var_466_4) then
				local var_466_7 = (arg_463_1.time_ - var_466_5) / var_466_6

				if arg_463_1.var_.characterEffect1074ui_story and not isNil(var_466_4) then
					local var_466_8 = Mathf.Lerp(0, 0.5, var_466_7)

					arg_463_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_463_1.var_.characterEffect1074ui_story.fillRatio = var_466_8
				end
			end

			if arg_463_1.time_ >= var_466_5 + var_466_6 and arg_463_1.time_ < var_466_5 + var_466_6 + arg_466_0 and not isNil(var_466_4) and arg_463_1.var_.characterEffect1074ui_story then
				local var_466_9 = 0.5

				arg_463_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_463_1.var_.characterEffect1074ui_story.fillRatio = var_466_9
			end

			local var_466_10 = 0
			local var_466_11 = 0.825

			if var_466_10 < arg_463_1.time_ and arg_463_1.time_ <= var_466_10 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_12 = arg_463_1:FormatText(StoryNameCfg[379].name)

				arg_463_1.leftNameTxt_.text = var_466_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_13 = arg_463_1:GetWordFromCfg(222031115)
				local var_466_14 = arg_463_1:FormatText(var_466_13.content)

				arg_463_1.text_.text = var_466_14

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_15 = 33
				local var_466_16 = utf8.len(var_466_14)
				local var_466_17 = var_466_15 <= 0 and var_466_11 or var_466_11 * (var_466_16 / var_466_15)

				if var_466_17 > 0 and var_466_11 < var_466_17 then
					arg_463_1.talkMaxDuration = var_466_17

					if var_466_17 + var_466_10 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_17 + var_466_10
					end
				end

				arg_463_1.text_.text = var_466_14
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031115", "story_v_out_222031.awb") ~= 0 then
					local var_466_18 = manager.audio:GetVoiceLength("story_v_out_222031", "222031115", "story_v_out_222031.awb") / 1000

					if var_466_18 + var_466_10 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_18 + var_466_10
					end

					if var_466_13.prefab_name ~= "" and arg_463_1.actors_[var_466_13.prefab_name] ~= nil then
						local var_466_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_13.prefab_name].transform, "story_v_out_222031", "222031115", "story_v_out_222031.awb")

						arg_463_1:RecordAudio("222031115", var_466_19)
						arg_463_1:RecordAudio("222031115", var_466_19)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_222031", "222031115", "story_v_out_222031.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_222031", "222031115", "story_v_out_222031.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_20 = math.max(var_466_11, arg_463_1.talkMaxDuration)

			if var_466_10 <= arg_463_1.time_ and arg_463_1.time_ < var_466_10 + var_466_20 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_10) / var_466_20

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_10 + var_466_20 and arg_463_1.time_ < var_466_10 + var_466_20 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play222031116 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 222031116
		arg_467_1.duration_ = 6.67

		local var_467_0 = {
			ja = 6.666,
			ko = 5.1,
			zh = 5.1
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
				arg_467_0:Play222031117(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0
			local var_470_1 = 0.6

			if var_470_0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				local var_470_2 = arg_467_1:FormatText(StoryNameCfg[379].name)

				arg_467_1.leftNameTxt_.text = var_470_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_3 = arg_467_1:GetWordFromCfg(222031116)
				local var_470_4 = arg_467_1:FormatText(var_470_3.content)

				arg_467_1.text_.text = var_470_4

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_5 = 24
				local var_470_6 = utf8.len(var_470_4)
				local var_470_7 = var_470_5 <= 0 and var_470_1 or var_470_1 * (var_470_6 / var_470_5)

				if var_470_7 > 0 and var_470_1 < var_470_7 then
					arg_467_1.talkMaxDuration = var_470_7

					if var_470_7 + var_470_0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_7 + var_470_0
					end
				end

				arg_467_1.text_.text = var_470_4
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031116", "story_v_out_222031.awb") ~= 0 then
					local var_470_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031116", "story_v_out_222031.awb") / 1000

					if var_470_8 + var_470_0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_8 + var_470_0
					end

					if var_470_3.prefab_name ~= "" and arg_467_1.actors_[var_470_3.prefab_name] ~= nil then
						local var_470_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_3.prefab_name].transform, "story_v_out_222031", "222031116", "story_v_out_222031.awb")

						arg_467_1:RecordAudio("222031116", var_470_9)
						arg_467_1:RecordAudio("222031116", var_470_9)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_222031", "222031116", "story_v_out_222031.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_222031", "222031116", "story_v_out_222031.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_10 = math.max(var_470_1, arg_467_1.talkMaxDuration)

			if var_470_0 <= arg_467_1.time_ and arg_467_1.time_ < var_470_0 + var_470_10 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_0) / var_470_10

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_0 + var_470_10 and arg_467_1.time_ < var_470_0 + var_470_10 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play222031117 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 222031117
		arg_471_1.duration_ = 9.33

		local var_471_0 = {
			ja = 9.333,
			ko = 7.2,
			zh = 7.2
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play222031118(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = arg_471_1.actors_["1074ui_story"]
			local var_474_1 = 0

			if var_474_1 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 and not isNil(var_474_0) and arg_471_1.var_.characterEffect1074ui_story == nil then
				arg_471_1.var_.characterEffect1074ui_story = var_474_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_2 = 0.200000002980232

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_2 and not isNil(var_474_0) then
				local var_474_3 = (arg_471_1.time_ - var_474_1) / var_474_2

				if arg_471_1.var_.characterEffect1074ui_story and not isNil(var_474_0) then
					arg_471_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_471_1.time_ >= var_474_1 + var_474_2 and arg_471_1.time_ < var_474_1 + var_474_2 + arg_474_0 and not isNil(var_474_0) and arg_471_1.var_.characterEffect1074ui_story then
				arg_471_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_474_4 = arg_471_1.actors_["1072ui_story"]
			local var_474_5 = 0

			if var_474_5 < arg_471_1.time_ and arg_471_1.time_ <= var_474_5 + arg_474_0 and not isNil(var_474_4) and arg_471_1.var_.characterEffect1072ui_story == nil then
				arg_471_1.var_.characterEffect1072ui_story = var_474_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_6 = 0.200000002980232

			if var_474_5 <= arg_471_1.time_ and arg_471_1.time_ < var_474_5 + var_474_6 and not isNil(var_474_4) then
				local var_474_7 = (arg_471_1.time_ - var_474_5) / var_474_6

				if arg_471_1.var_.characterEffect1072ui_story and not isNil(var_474_4) then
					local var_474_8 = Mathf.Lerp(0, 0.5, var_474_7)

					arg_471_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_471_1.var_.characterEffect1072ui_story.fillRatio = var_474_8
				end
			end

			if arg_471_1.time_ >= var_474_5 + var_474_6 and arg_471_1.time_ < var_474_5 + var_474_6 + arg_474_0 and not isNil(var_474_4) and arg_471_1.var_.characterEffect1072ui_story then
				local var_474_9 = 0.5

				arg_471_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_471_1.var_.characterEffect1072ui_story.fillRatio = var_474_9
			end

			local var_474_10 = 0
			local var_474_11 = 0.8

			if var_474_10 < arg_471_1.time_ and arg_471_1.time_ <= var_474_10 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				local var_474_12 = arg_471_1:FormatText(StoryNameCfg[410].name)

				arg_471_1.leftNameTxt_.text = var_474_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_13 = arg_471_1:GetWordFromCfg(222031117)
				local var_474_14 = arg_471_1:FormatText(var_474_13.content)

				arg_471_1.text_.text = var_474_14

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_15 = 32
				local var_474_16 = utf8.len(var_474_14)
				local var_474_17 = var_474_15 <= 0 and var_474_11 or var_474_11 * (var_474_16 / var_474_15)

				if var_474_17 > 0 and var_474_11 < var_474_17 then
					arg_471_1.talkMaxDuration = var_474_17

					if var_474_17 + var_474_10 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_17 + var_474_10
					end
				end

				arg_471_1.text_.text = var_474_14
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031117", "story_v_out_222031.awb") ~= 0 then
					local var_474_18 = manager.audio:GetVoiceLength("story_v_out_222031", "222031117", "story_v_out_222031.awb") / 1000

					if var_474_18 + var_474_10 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_18 + var_474_10
					end

					if var_474_13.prefab_name ~= "" and arg_471_1.actors_[var_474_13.prefab_name] ~= nil then
						local var_474_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_13.prefab_name].transform, "story_v_out_222031", "222031117", "story_v_out_222031.awb")

						arg_471_1:RecordAudio("222031117", var_474_19)
						arg_471_1:RecordAudio("222031117", var_474_19)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_222031", "222031117", "story_v_out_222031.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_222031", "222031117", "story_v_out_222031.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_20 = math.max(var_474_11, arg_471_1.talkMaxDuration)

			if var_474_10 <= arg_471_1.time_ and arg_471_1.time_ < var_474_10 + var_474_20 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_10) / var_474_20

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_10 + var_474_20 and arg_471_1.time_ < var_474_10 + var_474_20 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play222031118 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 222031118
		arg_475_1.duration_ = 20.27

		local var_475_0 = {
			ja = 20.266,
			ko = 9.566,
			zh = 9.566
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play222031119(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = arg_475_1.actors_["1072ui_story"]
			local var_478_1 = 0

			if var_478_1 < arg_475_1.time_ and arg_475_1.time_ <= var_478_1 + arg_478_0 and not isNil(var_478_0) and arg_475_1.var_.characterEffect1072ui_story == nil then
				arg_475_1.var_.characterEffect1072ui_story = var_478_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_2 = 0.200000002980232

			if var_478_1 <= arg_475_1.time_ and arg_475_1.time_ < var_478_1 + var_478_2 and not isNil(var_478_0) then
				local var_478_3 = (arg_475_1.time_ - var_478_1) / var_478_2

				if arg_475_1.var_.characterEffect1072ui_story and not isNil(var_478_0) then
					arg_475_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_475_1.time_ >= var_478_1 + var_478_2 and arg_475_1.time_ < var_478_1 + var_478_2 + arg_478_0 and not isNil(var_478_0) and arg_475_1.var_.characterEffect1072ui_story then
				arg_475_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_478_4 = arg_475_1.actors_["1074ui_story"]
			local var_478_5 = 0

			if var_478_5 < arg_475_1.time_ and arg_475_1.time_ <= var_478_5 + arg_478_0 and not isNil(var_478_4) and arg_475_1.var_.characterEffect1074ui_story == nil then
				arg_475_1.var_.characterEffect1074ui_story = var_478_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_6 = 0.200000002980232

			if var_478_5 <= arg_475_1.time_ and arg_475_1.time_ < var_478_5 + var_478_6 and not isNil(var_478_4) then
				local var_478_7 = (arg_475_1.time_ - var_478_5) / var_478_6

				if arg_475_1.var_.characterEffect1074ui_story and not isNil(var_478_4) then
					local var_478_8 = Mathf.Lerp(0, 0.5, var_478_7)

					arg_475_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_475_1.var_.characterEffect1074ui_story.fillRatio = var_478_8
				end
			end

			if arg_475_1.time_ >= var_478_5 + var_478_6 and arg_475_1.time_ < var_478_5 + var_478_6 + arg_478_0 and not isNil(var_478_4) and arg_475_1.var_.characterEffect1074ui_story then
				local var_478_9 = 0.5

				arg_475_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_475_1.var_.characterEffect1074ui_story.fillRatio = var_478_9
			end

			local var_478_10 = 0
			local var_478_11 = 1.25

			if var_478_10 < arg_475_1.time_ and arg_475_1.time_ <= var_478_10 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_12 = arg_475_1:FormatText(StoryNameCfg[379].name)

				arg_475_1.leftNameTxt_.text = var_478_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_13 = arg_475_1:GetWordFromCfg(222031118)
				local var_478_14 = arg_475_1:FormatText(var_478_13.content)

				arg_475_1.text_.text = var_478_14

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_15 = 51
				local var_478_16 = utf8.len(var_478_14)
				local var_478_17 = var_478_15 <= 0 and var_478_11 or var_478_11 * (var_478_16 / var_478_15)

				if var_478_17 > 0 and var_478_11 < var_478_17 then
					arg_475_1.talkMaxDuration = var_478_17

					if var_478_17 + var_478_10 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_17 + var_478_10
					end
				end

				arg_475_1.text_.text = var_478_14
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031118", "story_v_out_222031.awb") ~= 0 then
					local var_478_18 = manager.audio:GetVoiceLength("story_v_out_222031", "222031118", "story_v_out_222031.awb") / 1000

					if var_478_18 + var_478_10 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_18 + var_478_10
					end

					if var_478_13.prefab_name ~= "" and arg_475_1.actors_[var_478_13.prefab_name] ~= nil then
						local var_478_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_13.prefab_name].transform, "story_v_out_222031", "222031118", "story_v_out_222031.awb")

						arg_475_1:RecordAudio("222031118", var_478_19)
						arg_475_1:RecordAudio("222031118", var_478_19)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_222031", "222031118", "story_v_out_222031.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_222031", "222031118", "story_v_out_222031.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_20 = math.max(var_478_11, arg_475_1.talkMaxDuration)

			if var_478_10 <= arg_475_1.time_ and arg_475_1.time_ < var_478_10 + var_478_20 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_10) / var_478_20

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_10 + var_478_20 and arg_475_1.time_ < var_478_10 + var_478_20 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play222031119 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 222031119
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play222031120(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = arg_479_1.actors_["1072ui_story"].transform
			local var_482_1 = 0

			if var_482_1 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 then
				arg_479_1.var_.moveOldPos1072ui_story = var_482_0.localPosition
			end

			local var_482_2 = 0.001

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_2 then
				local var_482_3 = (arg_479_1.time_ - var_482_1) / var_482_2
				local var_482_4 = Vector3.New(0, 100, 0)

				var_482_0.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos1072ui_story, var_482_4, var_482_3)

				local var_482_5 = manager.ui.mainCamera.transform.position - var_482_0.position

				var_482_0.forward = Vector3.New(var_482_5.x, var_482_5.y, var_482_5.z)

				local var_482_6 = var_482_0.localEulerAngles

				var_482_6.z = 0
				var_482_6.x = 0
				var_482_0.localEulerAngles = var_482_6
			end

			if arg_479_1.time_ >= var_482_1 + var_482_2 and arg_479_1.time_ < var_482_1 + var_482_2 + arg_482_0 then
				var_482_0.localPosition = Vector3.New(0, 100, 0)

				local var_482_7 = manager.ui.mainCamera.transform.position - var_482_0.position

				var_482_0.forward = Vector3.New(var_482_7.x, var_482_7.y, var_482_7.z)

				local var_482_8 = var_482_0.localEulerAngles

				var_482_8.z = 0
				var_482_8.x = 0
				var_482_0.localEulerAngles = var_482_8
			end

			local var_482_9 = arg_479_1.actors_["1072ui_story"]
			local var_482_10 = 0

			if var_482_10 < arg_479_1.time_ and arg_479_1.time_ <= var_482_10 + arg_482_0 and not isNil(var_482_9) and arg_479_1.var_.characterEffect1072ui_story == nil then
				arg_479_1.var_.characterEffect1072ui_story = var_482_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_11 = 0.200000002980232

			if var_482_10 <= arg_479_1.time_ and arg_479_1.time_ < var_482_10 + var_482_11 and not isNil(var_482_9) then
				local var_482_12 = (arg_479_1.time_ - var_482_10) / var_482_11

				if arg_479_1.var_.characterEffect1072ui_story and not isNil(var_482_9) then
					local var_482_13 = Mathf.Lerp(0, 0.5, var_482_12)

					arg_479_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_479_1.var_.characterEffect1072ui_story.fillRatio = var_482_13
				end
			end

			if arg_479_1.time_ >= var_482_10 + var_482_11 and arg_479_1.time_ < var_482_10 + var_482_11 + arg_482_0 and not isNil(var_482_9) and arg_479_1.var_.characterEffect1072ui_story then
				local var_482_14 = 0.5

				arg_479_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_479_1.var_.characterEffect1072ui_story.fillRatio = var_482_14
			end

			local var_482_15 = arg_479_1.actors_["1074ui_story"].transform
			local var_482_16 = 0

			if var_482_16 < arg_479_1.time_ and arg_479_1.time_ <= var_482_16 + arg_482_0 then
				arg_479_1.var_.moveOldPos1074ui_story = var_482_15.localPosition
			end

			local var_482_17 = 0.001

			if var_482_16 <= arg_479_1.time_ and arg_479_1.time_ < var_482_16 + var_482_17 then
				local var_482_18 = (arg_479_1.time_ - var_482_16) / var_482_17
				local var_482_19 = Vector3.New(0, 100, 0)

				var_482_15.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos1074ui_story, var_482_19, var_482_18)

				local var_482_20 = manager.ui.mainCamera.transform.position - var_482_15.position

				var_482_15.forward = Vector3.New(var_482_20.x, var_482_20.y, var_482_20.z)

				local var_482_21 = var_482_15.localEulerAngles

				var_482_21.z = 0
				var_482_21.x = 0
				var_482_15.localEulerAngles = var_482_21
			end

			if arg_479_1.time_ >= var_482_16 + var_482_17 and arg_479_1.time_ < var_482_16 + var_482_17 + arg_482_0 then
				var_482_15.localPosition = Vector3.New(0, 100, 0)

				local var_482_22 = manager.ui.mainCamera.transform.position - var_482_15.position

				var_482_15.forward = Vector3.New(var_482_22.x, var_482_22.y, var_482_22.z)

				local var_482_23 = var_482_15.localEulerAngles

				var_482_23.z = 0
				var_482_23.x = 0
				var_482_15.localEulerAngles = var_482_23
			end

			local var_482_24 = arg_479_1.actors_["1074ui_story"]
			local var_482_25 = 0

			if var_482_25 < arg_479_1.time_ and arg_479_1.time_ <= var_482_25 + arg_482_0 and not isNil(var_482_24) and arg_479_1.var_.characterEffect1074ui_story == nil then
				arg_479_1.var_.characterEffect1074ui_story = var_482_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_26 = 0.200000002980232

			if var_482_25 <= arg_479_1.time_ and arg_479_1.time_ < var_482_25 + var_482_26 and not isNil(var_482_24) then
				local var_482_27 = (arg_479_1.time_ - var_482_25) / var_482_26

				if arg_479_1.var_.characterEffect1074ui_story and not isNil(var_482_24) then
					local var_482_28 = Mathf.Lerp(0, 0.5, var_482_27)

					arg_479_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_479_1.var_.characterEffect1074ui_story.fillRatio = var_482_28
				end
			end

			if arg_479_1.time_ >= var_482_25 + var_482_26 and arg_479_1.time_ < var_482_25 + var_482_26 + arg_482_0 and not isNil(var_482_24) and arg_479_1.var_.characterEffect1074ui_story then
				local var_482_29 = 0.5

				arg_479_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_479_1.var_.characterEffect1074ui_story.fillRatio = var_482_29
			end

			local var_482_30 = 0
			local var_482_31 = 0.95

			if var_482_30 < arg_479_1.time_ and arg_479_1.time_ <= var_482_30 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, false)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_32 = arg_479_1:GetWordFromCfg(222031119)
				local var_482_33 = arg_479_1:FormatText(var_482_32.content)

				arg_479_1.text_.text = var_482_33

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_34 = 38
				local var_482_35 = utf8.len(var_482_33)
				local var_482_36 = var_482_34 <= 0 and var_482_31 or var_482_31 * (var_482_35 / var_482_34)

				if var_482_36 > 0 and var_482_31 < var_482_36 then
					arg_479_1.talkMaxDuration = var_482_36

					if var_482_36 + var_482_30 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_36 + var_482_30
					end
				end

				arg_479_1.text_.text = var_482_33
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_37 = math.max(var_482_31, arg_479_1.talkMaxDuration)

			if var_482_30 <= arg_479_1.time_ and arg_479_1.time_ < var_482_30 + var_482_37 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_30) / var_482_37

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_30 + var_482_37 and arg_479_1.time_ < var_482_30 + var_482_37 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_479_1:InitPlayNodeList()
	end,
	Play222031120 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 222031120
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play222031121(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0
			local var_486_1 = 1.225

			if var_486_0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_2 = arg_483_1:GetWordFromCfg(222031120)
				local var_486_3 = arg_483_1:FormatText(var_486_2.content)

				arg_483_1.text_.text = var_486_3

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_4 = 49
				local var_486_5 = utf8.len(var_486_3)
				local var_486_6 = var_486_4 <= 0 and var_486_1 or var_486_1 * (var_486_5 / var_486_4)

				if var_486_6 > 0 and var_486_1 < var_486_6 then
					arg_483_1.talkMaxDuration = var_486_6

					if var_486_6 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_6 + var_486_0
					end
				end

				arg_483_1.text_.text = var_486_3
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_7 = math.max(var_486_1, arg_483_1.talkMaxDuration)

			if var_486_0 <= arg_483_1.time_ and arg_483_1.time_ < var_486_0 + var_486_7 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_0) / var_486_7

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_0 + var_486_7 and arg_483_1.time_ < var_486_0 + var_486_7 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play222031121 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 222031121
		arg_487_1.duration_ = 23.5

		local var_487_0 = {
			ja = 23.5,
			ko = 16.666,
			zh = 16.733
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play222031122(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 2

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				local var_490_1 = manager.ui.mainCamera.transform.localPosition
				local var_490_2 = Vector3.New(0, 0, 10) + Vector3.New(var_490_1.x, var_490_1.y, 0)
				local var_490_3 = arg_487_1.bgs_.ST31a

				var_490_3.transform.localPosition = var_490_2
				var_490_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_490_4 = var_490_3:GetComponent("SpriteRenderer")

				if var_490_4 and var_490_4.sprite then
					local var_490_5 = (var_490_3.transform.localPosition - var_490_1).z
					local var_490_6 = manager.ui.mainCameraCom_
					local var_490_7 = 2 * var_490_5 * Mathf.Tan(var_490_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_490_8 = var_490_7 * var_490_6.aspect
					local var_490_9 = var_490_4.sprite.bounds.size.x
					local var_490_10 = var_490_4.sprite.bounds.size.y
					local var_490_11 = var_490_8 / var_490_9
					local var_490_12 = var_490_7 / var_490_10
					local var_490_13 = var_490_12 < var_490_11 and var_490_11 or var_490_12

					var_490_3.transform.localScale = Vector3.New(var_490_13, var_490_13, 0)
				end

				for iter_490_0, iter_490_1 in pairs(arg_487_1.bgs_) do
					if iter_490_0 ~= "ST31a" then
						iter_490_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_490_14 = 0

			if var_490_14 < arg_487_1.time_ and arg_487_1.time_ <= var_490_14 + arg_490_0 then
				arg_487_1.mask_.enabled = true
				arg_487_1.mask_.raycastTarget = true

				arg_487_1:SetGaussion(false)
			end

			local var_490_15 = 2

			if var_490_14 <= arg_487_1.time_ and arg_487_1.time_ < var_490_14 + var_490_15 then
				local var_490_16 = (arg_487_1.time_ - var_490_14) / var_490_15
				local var_490_17 = Color.New(0, 0, 0)

				var_490_17.a = Mathf.Lerp(0, 1, var_490_16)
				arg_487_1.mask_.color = var_490_17
			end

			if arg_487_1.time_ >= var_490_14 + var_490_15 and arg_487_1.time_ < var_490_14 + var_490_15 + arg_490_0 then
				local var_490_18 = Color.New(0, 0, 0)

				var_490_18.a = 1
				arg_487_1.mask_.color = var_490_18
			end

			local var_490_19 = 2

			if var_490_19 < arg_487_1.time_ and arg_487_1.time_ <= var_490_19 + arg_490_0 then
				arg_487_1.mask_.enabled = true
				arg_487_1.mask_.raycastTarget = true

				arg_487_1:SetGaussion(false)
			end

			local var_490_20 = 2

			if var_490_19 <= arg_487_1.time_ and arg_487_1.time_ < var_490_19 + var_490_20 then
				local var_490_21 = (arg_487_1.time_ - var_490_19) / var_490_20
				local var_490_22 = Color.New(0, 0, 0)

				var_490_22.a = Mathf.Lerp(1, 0, var_490_21)
				arg_487_1.mask_.color = var_490_22
			end

			if arg_487_1.time_ >= var_490_19 + var_490_20 and arg_487_1.time_ < var_490_19 + var_490_20 + arg_490_0 then
				local var_490_23 = Color.New(0, 0, 0)
				local var_490_24 = 0

				arg_487_1.mask_.enabled = false
				var_490_23.a = var_490_24
				arg_487_1.mask_.color = var_490_23
			end

			local var_490_25 = 2

			arg_487_1.isInRecall_ = false

			if var_490_25 < arg_487_1.time_ and arg_487_1.time_ <= var_490_25 + arg_490_0 then
				arg_487_1.screenFilterGo_:SetActive(true)

				arg_487_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_490_2, iter_490_3 in pairs(arg_487_1.actors_) do
					local var_490_26 = iter_490_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_490_4, iter_490_5 in ipairs(var_490_26) do
						if iter_490_5.color.r > 0.51 then
							iter_490_5.color = Color.New(1, 1, 1)
						else
							iter_490_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_490_27 = 0.1

			if var_490_25 <= arg_487_1.time_ and arg_487_1.time_ < var_490_25 + var_490_27 then
				local var_490_28 = (arg_487_1.time_ - var_490_25) / var_490_27

				arg_487_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_490_28)
			end

			if arg_487_1.time_ >= var_490_25 + var_490_27 and arg_487_1.time_ < var_490_25 + var_490_27 + arg_490_0 then
				arg_487_1.screenFilterEffect_.weight = 1
			end

			if arg_487_1.frameCnt_ <= 1 then
				arg_487_1.dialog_:SetActive(false)
			end

			local var_490_29 = 4
			local var_490_30 = 0.975

			if var_490_29 < arg_487_1.time_ and arg_487_1.time_ <= var_490_29 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0

				arg_487_1.dialog_:SetActive(true)

				arg_487_1.dialogCg_.alpha = 0

				local var_490_31 = LeanTween.value(arg_487_1.dialog_, 0, 1, 0.3)

				var_490_31:setOnUpdate(LuaHelper.FloatAction(function(arg_491_0)
					arg_487_1.dialogCg_.alpha = arg_491_0
				end))
				var_490_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_487_1.dialog_)
					var_490_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_487_1.duration_ = arg_487_1.duration_ + 0.3

				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_32 = arg_487_1:FormatText(StoryNameCfg[462].name)

				arg_487_1.leftNameTxt_.text = var_490_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_33 = arg_487_1:GetWordFromCfg(222031121)
				local var_490_34 = arg_487_1:FormatText(var_490_33.content)

				arg_487_1.text_.text = var_490_34

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_35 = 39
				local var_490_36 = utf8.len(var_490_34)
				local var_490_37 = var_490_35 <= 0 and var_490_30 or var_490_30 * (var_490_36 / var_490_35)

				if var_490_37 > 0 and var_490_30 < var_490_37 then
					arg_487_1.talkMaxDuration = var_490_37
					var_490_29 = var_490_29 + 0.3

					if var_490_37 + var_490_29 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_37 + var_490_29
					end
				end

				arg_487_1.text_.text = var_490_34
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031121", "story_v_out_222031.awb") ~= 0 then
					local var_490_38 = manager.audio:GetVoiceLength("story_v_out_222031", "222031121", "story_v_out_222031.awb") / 1000

					if var_490_38 + var_490_29 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_38 + var_490_29
					end

					if var_490_33.prefab_name ~= "" and arg_487_1.actors_[var_490_33.prefab_name] ~= nil then
						local var_490_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_33.prefab_name].transform, "story_v_out_222031", "222031121", "story_v_out_222031.awb")

						arg_487_1:RecordAudio("222031121", var_490_39)
						arg_487_1:RecordAudio("222031121", var_490_39)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_222031", "222031121", "story_v_out_222031.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_222031", "222031121", "story_v_out_222031.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_40 = var_490_29 + 0.3
			local var_490_41 = math.max(var_490_30, arg_487_1.talkMaxDuration)

			if var_490_40 <= arg_487_1.time_ and arg_487_1.time_ < var_490_40 + var_490_41 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_40) / var_490_41

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_40 + var_490_41 and arg_487_1.time_ < var_490_40 + var_490_41 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play222031122 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 222031122
		arg_493_1.duration_ = 16.23

		local var_493_0 = {
			ja = 16.233,
			ko = 4.833,
			zh = 4.833
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play222031123(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0
			local var_496_1 = 0.4

			if var_496_0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_2 = arg_493_1:FormatText(StoryNameCfg[462].name)

				arg_493_1.leftNameTxt_.text = var_496_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_3 = arg_493_1:GetWordFromCfg(222031122)
				local var_496_4 = arg_493_1:FormatText(var_496_3.content)

				arg_493_1.text_.text = var_496_4

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_5 = 16
				local var_496_6 = utf8.len(var_496_4)
				local var_496_7 = var_496_5 <= 0 and var_496_1 or var_496_1 * (var_496_6 / var_496_5)

				if var_496_7 > 0 and var_496_1 < var_496_7 then
					arg_493_1.talkMaxDuration = var_496_7

					if var_496_7 + var_496_0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_7 + var_496_0
					end
				end

				arg_493_1.text_.text = var_496_4
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031122", "story_v_out_222031.awb") ~= 0 then
					local var_496_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031122", "story_v_out_222031.awb") / 1000

					if var_496_8 + var_496_0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_8 + var_496_0
					end

					if var_496_3.prefab_name ~= "" and arg_493_1.actors_[var_496_3.prefab_name] ~= nil then
						local var_496_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_3.prefab_name].transform, "story_v_out_222031", "222031122", "story_v_out_222031.awb")

						arg_493_1:RecordAudio("222031122", var_496_9)
						arg_493_1:RecordAudio("222031122", var_496_9)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_out_222031", "222031122", "story_v_out_222031.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_out_222031", "222031122", "story_v_out_222031.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_10 = math.max(var_496_1, arg_493_1.talkMaxDuration)

			if var_496_0 <= arg_493_1.time_ and arg_493_1.time_ < var_496_0 + var_496_10 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_0) / var_496_10

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_0 + var_496_10 and arg_493_1.time_ < var_496_0 + var_496_10 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play222031123 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 222031123
		arg_497_1.duration_ = 13.7

		local var_497_0 = {
			ja = 13.7000000029802,
			ko = 12.4000000029802,
			zh = 12.4330000029802
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play222031124(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = arg_497_1.actors_["1072ui_story"]
			local var_500_1 = 3.8

			if var_500_1 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.characterEffect1072ui_story == nil then
				arg_497_1.var_.characterEffect1072ui_story = var_500_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_2 = 0.200000002980232

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_2 and not isNil(var_500_0) then
				local var_500_3 = (arg_497_1.time_ - var_500_1) / var_500_2

				if arg_497_1.var_.characterEffect1072ui_story and not isNil(var_500_0) then
					local var_500_4 = Mathf.Lerp(0, 0.5, var_500_3)

					arg_497_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_497_1.var_.characterEffect1072ui_story.fillRatio = var_500_4
				end
			end

			if arg_497_1.time_ >= var_500_1 + var_500_2 and arg_497_1.time_ < var_500_1 + var_500_2 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.characterEffect1072ui_story then
				local var_500_5 = 0.5

				arg_497_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_497_1.var_.characterEffect1072ui_story.fillRatio = var_500_5
			end

			local var_500_6 = arg_497_1.actors_["1074ui_story"]
			local var_500_7 = 3.8

			if var_500_7 < arg_497_1.time_ and arg_497_1.time_ <= var_500_7 + arg_500_0 and not isNil(var_500_6) and arg_497_1.var_.characterEffect1074ui_story == nil then
				arg_497_1.var_.characterEffect1074ui_story = var_500_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_8 = 0.200000002980232

			if var_500_7 <= arg_497_1.time_ and arg_497_1.time_ < var_500_7 + var_500_8 and not isNil(var_500_6) then
				local var_500_9 = (arg_497_1.time_ - var_500_7) / var_500_8

				if arg_497_1.var_.characterEffect1074ui_story and not isNil(var_500_6) then
					arg_497_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_497_1.time_ >= var_500_7 + var_500_8 and arg_497_1.time_ < var_500_7 + var_500_8 + arg_500_0 and not isNil(var_500_6) and arg_497_1.var_.characterEffect1074ui_story then
				arg_497_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_500_10 = 3.8

			if var_500_10 < arg_497_1.time_ and arg_497_1.time_ <= var_500_10 + arg_500_0 then
				arg_497_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_500_11 = 3.8

			if var_500_11 < arg_497_1.time_ and arg_497_1.time_ <= var_500_11 + arg_500_0 then
				arg_497_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_500_12 = 0

			if var_500_12 < arg_497_1.time_ and arg_497_1.time_ <= var_500_12 + arg_500_0 then
				arg_497_1.mask_.enabled = true
				arg_497_1.mask_.raycastTarget = true

				arg_497_1:SetGaussion(false)
			end

			local var_500_13 = 2

			if var_500_12 <= arg_497_1.time_ and arg_497_1.time_ < var_500_12 + var_500_13 then
				local var_500_14 = (arg_497_1.time_ - var_500_12) / var_500_13
				local var_500_15 = Color.New(0, 0, 0)

				var_500_15.a = Mathf.Lerp(0, 1, var_500_14)
				arg_497_1.mask_.color = var_500_15
			end

			if arg_497_1.time_ >= var_500_12 + var_500_13 and arg_497_1.time_ < var_500_12 + var_500_13 + arg_500_0 then
				local var_500_16 = Color.New(0, 0, 0)

				var_500_16.a = 1
				arg_497_1.mask_.color = var_500_16
			end

			local var_500_17 = 2

			if var_500_17 < arg_497_1.time_ and arg_497_1.time_ <= var_500_17 + arg_500_0 then
				arg_497_1.mask_.enabled = true
				arg_497_1.mask_.raycastTarget = true

				arg_497_1:SetGaussion(false)
			end

			local var_500_18 = 2

			if var_500_17 <= arg_497_1.time_ and arg_497_1.time_ < var_500_17 + var_500_18 then
				local var_500_19 = (arg_497_1.time_ - var_500_17) / var_500_18
				local var_500_20 = Color.New(0, 0, 0)

				var_500_20.a = Mathf.Lerp(1, 0, var_500_19)
				arg_497_1.mask_.color = var_500_20
			end

			if arg_497_1.time_ >= var_500_17 + var_500_18 and arg_497_1.time_ < var_500_17 + var_500_18 + arg_500_0 then
				local var_500_21 = Color.New(0, 0, 0)
				local var_500_22 = 0

				arg_497_1.mask_.enabled = false
				var_500_21.a = var_500_22
				arg_497_1.mask_.color = var_500_21
			end

			local var_500_23 = 2

			arg_497_1.isInRecall_ = false

			if var_500_23 < arg_497_1.time_ and arg_497_1.time_ <= var_500_23 + arg_500_0 then
				arg_497_1.screenFilterGo_:SetActive(false)

				for iter_500_0, iter_500_1 in pairs(arg_497_1.actors_) do
					local var_500_24 = iter_500_1:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_500_2, iter_500_3 in ipairs(var_500_24) do
						if iter_500_3.color.r > 0.51 then
							iter_500_3.color = Color.New(1, 1, 1)
						else
							iter_500_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_500_25 = 0.1

			if var_500_23 <= arg_497_1.time_ and arg_497_1.time_ < var_500_23 + var_500_25 then
				local var_500_26 = (arg_497_1.time_ - var_500_23) / var_500_25

				arg_497_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_500_26)
			end

			if arg_497_1.time_ >= var_500_23 + var_500_25 and arg_497_1.time_ < var_500_23 + var_500_25 + arg_500_0 then
				arg_497_1.screenFilterEffect_.weight = 0
			end

			local var_500_27 = 2

			if var_500_27 < arg_497_1.time_ and arg_497_1.time_ <= var_500_27 + arg_500_0 then
				local var_500_28 = manager.ui.mainCamera.transform.localPosition
				local var_500_29 = Vector3.New(0, 0, 10) + Vector3.New(var_500_28.x, var_500_28.y, 0)
				local var_500_30 = arg_497_1.bgs_.ST39a

				var_500_30.transform.localPosition = var_500_29
				var_500_30.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_500_31 = var_500_30:GetComponent("SpriteRenderer")

				if var_500_31 and var_500_31.sprite then
					local var_500_32 = (var_500_30.transform.localPosition - var_500_28).z
					local var_500_33 = manager.ui.mainCameraCom_
					local var_500_34 = 2 * var_500_32 * Mathf.Tan(var_500_33.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_500_35 = var_500_34 * var_500_33.aspect
					local var_500_36 = var_500_31.sprite.bounds.size.x
					local var_500_37 = var_500_31.sprite.bounds.size.y
					local var_500_38 = var_500_35 / var_500_36
					local var_500_39 = var_500_34 / var_500_37
					local var_500_40 = var_500_39 < var_500_38 and var_500_38 or var_500_39

					var_500_30.transform.localScale = Vector3.New(var_500_40, var_500_40, 0)
				end

				for iter_500_4, iter_500_5 in pairs(arg_497_1.bgs_) do
					if iter_500_4 ~= "ST39a" then
						iter_500_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_500_41 = arg_497_1.actors_["1074ui_story"].transform
			local var_500_42 = 3.8

			if var_500_42 < arg_497_1.time_ and arg_497_1.time_ <= var_500_42 + arg_500_0 then
				arg_497_1.var_.moveOldPos1074ui_story = var_500_41.localPosition
			end

			local var_500_43 = 0.001

			if var_500_42 <= arg_497_1.time_ and arg_497_1.time_ < var_500_42 + var_500_43 then
				local var_500_44 = (arg_497_1.time_ - var_500_42) / var_500_43
				local var_500_45 = Vector3.New(0.7, -1.055, -6.12)

				var_500_41.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos1074ui_story, var_500_45, var_500_44)

				local var_500_46 = manager.ui.mainCamera.transform.position - var_500_41.position

				var_500_41.forward = Vector3.New(var_500_46.x, var_500_46.y, var_500_46.z)

				local var_500_47 = var_500_41.localEulerAngles

				var_500_47.z = 0
				var_500_47.x = 0
				var_500_41.localEulerAngles = var_500_47
			end

			if arg_497_1.time_ >= var_500_42 + var_500_43 and arg_497_1.time_ < var_500_42 + var_500_43 + arg_500_0 then
				var_500_41.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_500_48 = manager.ui.mainCamera.transform.position - var_500_41.position

				var_500_41.forward = Vector3.New(var_500_48.x, var_500_48.y, var_500_48.z)

				local var_500_49 = var_500_41.localEulerAngles

				var_500_49.z = 0
				var_500_49.x = 0
				var_500_41.localEulerAngles = var_500_49
			end

			local var_500_50 = arg_497_1.actors_["1072ui_story"].transform
			local var_500_51 = 3.8

			if var_500_51 < arg_497_1.time_ and arg_497_1.time_ <= var_500_51 + arg_500_0 then
				arg_497_1.var_.moveOldPos1072ui_story = var_500_50.localPosition
			end

			local var_500_52 = 0.001

			if var_500_51 <= arg_497_1.time_ and arg_497_1.time_ < var_500_51 + var_500_52 then
				local var_500_53 = (arg_497_1.time_ - var_500_51) / var_500_52
				local var_500_54 = Vector3.New(-0.7, -0.71, -6)

				var_500_50.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos1072ui_story, var_500_54, var_500_53)

				local var_500_55 = manager.ui.mainCamera.transform.position - var_500_50.position

				var_500_50.forward = Vector3.New(var_500_55.x, var_500_55.y, var_500_55.z)

				local var_500_56 = var_500_50.localEulerAngles

				var_500_56.z = 0
				var_500_56.x = 0
				var_500_50.localEulerAngles = var_500_56
			end

			if arg_497_1.time_ >= var_500_51 + var_500_52 and arg_497_1.time_ < var_500_51 + var_500_52 + arg_500_0 then
				var_500_50.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_500_57 = manager.ui.mainCamera.transform.position - var_500_50.position

				var_500_50.forward = Vector3.New(var_500_57.x, var_500_57.y, var_500_57.z)

				local var_500_58 = var_500_50.localEulerAngles

				var_500_58.z = 0
				var_500_58.x = 0
				var_500_50.localEulerAngles = var_500_58
			end

			if arg_497_1.frameCnt_ <= 1 then
				arg_497_1.dialog_:SetActive(false)
			end

			local var_500_59 = 4.00000000298023
			local var_500_60 = 1

			if var_500_59 < arg_497_1.time_ and arg_497_1.time_ <= var_500_59 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0

				arg_497_1.dialog_:SetActive(true)

				arg_497_1.dialogCg_.alpha = 0

				local var_500_61 = LeanTween.value(arg_497_1.dialog_, 0, 1, 0.3)

				var_500_61:setOnUpdate(LuaHelper.FloatAction(function(arg_501_0)
					arg_497_1.dialogCg_.alpha = arg_501_0
				end))
				var_500_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_497_1.dialog_)
					var_500_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_497_1.duration_ = arg_497_1.duration_ + 0.3

				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_62 = arg_497_1:FormatText(StoryNameCfg[410].name)

				arg_497_1.leftNameTxt_.text = var_500_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_63 = arg_497_1:GetWordFromCfg(222031123)
				local var_500_64 = arg_497_1:FormatText(var_500_63.content)

				arg_497_1.text_.text = var_500_64

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_65 = 40
				local var_500_66 = utf8.len(var_500_64)
				local var_500_67 = var_500_65 <= 0 and var_500_60 or var_500_60 * (var_500_66 / var_500_65)

				if var_500_67 > 0 and var_500_60 < var_500_67 then
					arg_497_1.talkMaxDuration = var_500_67
					var_500_59 = var_500_59 + 0.3

					if var_500_67 + var_500_59 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_67 + var_500_59
					end
				end

				arg_497_1.text_.text = var_500_64
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031123", "story_v_out_222031.awb") ~= 0 then
					local var_500_68 = manager.audio:GetVoiceLength("story_v_out_222031", "222031123", "story_v_out_222031.awb") / 1000

					if var_500_68 + var_500_59 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_68 + var_500_59
					end

					if var_500_63.prefab_name ~= "" and arg_497_1.actors_[var_500_63.prefab_name] ~= nil then
						local var_500_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_63.prefab_name].transform, "story_v_out_222031", "222031123", "story_v_out_222031.awb")

						arg_497_1:RecordAudio("222031123", var_500_69)
						arg_497_1:RecordAudio("222031123", var_500_69)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_222031", "222031123", "story_v_out_222031.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_222031", "222031123", "story_v_out_222031.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_70 = var_500_59 + 0.3
			local var_500_71 = math.max(var_500_60, arg_497_1.talkMaxDuration)

			if var_500_70 <= arg_497_1.time_ and arg_497_1.time_ < var_500_70 + var_500_71 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_70) / var_500_71

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_70 + var_500_71 and arg_497_1.time_ < var_500_70 + var_500_71 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_497_1:InitPlayNodeList()
	end,
	Play222031124 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 222031124
		arg_503_1.duration_ = 6.47

		local var_503_0 = {
			ja = 6.466,
			ko = 4.833,
			zh = 4.9
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play222031125(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0

			if var_506_0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action3_1")
			end

			local var_506_1 = 0

			if var_506_1 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 then
				arg_503_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_506_2 = 0
			local var_506_3 = 0.625

			if var_506_2 < arg_503_1.time_ and arg_503_1.time_ <= var_506_2 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_4 = arg_503_1:FormatText(StoryNameCfg[410].name)

				arg_503_1.leftNameTxt_.text = var_506_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_5 = arg_503_1:GetWordFromCfg(222031124)
				local var_506_6 = arg_503_1:FormatText(var_506_5.content)

				arg_503_1.text_.text = var_506_6

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_7 = 25
				local var_506_8 = utf8.len(var_506_6)
				local var_506_9 = var_506_7 <= 0 and var_506_3 or var_506_3 * (var_506_8 / var_506_7)

				if var_506_9 > 0 and var_506_3 < var_506_9 then
					arg_503_1.talkMaxDuration = var_506_9

					if var_506_9 + var_506_2 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_9 + var_506_2
					end
				end

				arg_503_1.text_.text = var_506_6
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031124", "story_v_out_222031.awb") ~= 0 then
					local var_506_10 = manager.audio:GetVoiceLength("story_v_out_222031", "222031124", "story_v_out_222031.awb") / 1000

					if var_506_10 + var_506_2 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_10 + var_506_2
					end

					if var_506_5.prefab_name ~= "" and arg_503_1.actors_[var_506_5.prefab_name] ~= nil then
						local var_506_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_5.prefab_name].transform, "story_v_out_222031", "222031124", "story_v_out_222031.awb")

						arg_503_1:RecordAudio("222031124", var_506_11)
						arg_503_1:RecordAudio("222031124", var_506_11)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_222031", "222031124", "story_v_out_222031.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_222031", "222031124", "story_v_out_222031.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_12 = math.max(var_506_3, arg_503_1.talkMaxDuration)

			if var_506_2 <= arg_503_1.time_ and arg_503_1.time_ < var_506_2 + var_506_12 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_2) / var_506_12

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_2 + var_506_12 and arg_503_1.time_ < var_506_2 + var_506_12 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play222031125 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 222031125
		arg_507_1.duration_ = 16.7

		local var_507_0 = {
			ja = 16.7,
			ko = 10.3,
			zh = 10.266
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play222031126(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				arg_507_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action3_2")
			end

			local var_510_1 = 0

			if var_510_1 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 then
				arg_507_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_510_2 = 0
			local var_510_3 = 1.05

			if var_510_2 < arg_507_1.time_ and arg_507_1.time_ <= var_510_2 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_4 = arg_507_1:FormatText(StoryNameCfg[410].name)

				arg_507_1.leftNameTxt_.text = var_510_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_5 = arg_507_1:GetWordFromCfg(222031125)
				local var_510_6 = arg_507_1:FormatText(var_510_5.content)

				arg_507_1.text_.text = var_510_6

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_7 = 42
				local var_510_8 = utf8.len(var_510_6)
				local var_510_9 = var_510_7 <= 0 and var_510_3 or var_510_3 * (var_510_8 / var_510_7)

				if var_510_9 > 0 and var_510_3 < var_510_9 then
					arg_507_1.talkMaxDuration = var_510_9

					if var_510_9 + var_510_2 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_9 + var_510_2
					end
				end

				arg_507_1.text_.text = var_510_6
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031125", "story_v_out_222031.awb") ~= 0 then
					local var_510_10 = manager.audio:GetVoiceLength("story_v_out_222031", "222031125", "story_v_out_222031.awb") / 1000

					if var_510_10 + var_510_2 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_10 + var_510_2
					end

					if var_510_5.prefab_name ~= "" and arg_507_1.actors_[var_510_5.prefab_name] ~= nil then
						local var_510_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_5.prefab_name].transform, "story_v_out_222031", "222031125", "story_v_out_222031.awb")

						arg_507_1:RecordAudio("222031125", var_510_11)
						arg_507_1:RecordAudio("222031125", var_510_11)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_222031", "222031125", "story_v_out_222031.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_222031", "222031125", "story_v_out_222031.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_12 = math.max(var_510_3, arg_507_1.talkMaxDuration)

			if var_510_2 <= arg_507_1.time_ and arg_507_1.time_ < var_510_2 + var_510_12 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_2) / var_510_12

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_2 + var_510_12 and arg_507_1.time_ < var_510_2 + var_510_12 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play222031126 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 222031126
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play222031127(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["1072ui_story"].transform
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				arg_511_1.var_.moveOldPos1072ui_story = var_514_0.localPosition
			end

			local var_514_2 = 0.001

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_2 then
				local var_514_3 = (arg_511_1.time_ - var_514_1) / var_514_2
				local var_514_4 = Vector3.New(0, 100, 0)

				var_514_0.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos1072ui_story, var_514_4, var_514_3)

				local var_514_5 = manager.ui.mainCamera.transform.position - var_514_0.position

				var_514_0.forward = Vector3.New(var_514_5.x, var_514_5.y, var_514_5.z)

				local var_514_6 = var_514_0.localEulerAngles

				var_514_6.z = 0
				var_514_6.x = 0
				var_514_0.localEulerAngles = var_514_6
			end

			if arg_511_1.time_ >= var_514_1 + var_514_2 and arg_511_1.time_ < var_514_1 + var_514_2 + arg_514_0 then
				var_514_0.localPosition = Vector3.New(0, 100, 0)

				local var_514_7 = manager.ui.mainCamera.transform.position - var_514_0.position

				var_514_0.forward = Vector3.New(var_514_7.x, var_514_7.y, var_514_7.z)

				local var_514_8 = var_514_0.localEulerAngles

				var_514_8.z = 0
				var_514_8.x = 0
				var_514_0.localEulerAngles = var_514_8
			end

			local var_514_9 = arg_511_1.actors_["1074ui_story"]
			local var_514_10 = 0

			if var_514_10 < arg_511_1.time_ and arg_511_1.time_ <= var_514_10 + arg_514_0 and not isNil(var_514_9) and arg_511_1.var_.characterEffect1074ui_story == nil then
				arg_511_1.var_.characterEffect1074ui_story = var_514_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_11 = 0.200000002980232

			if var_514_10 <= arg_511_1.time_ and arg_511_1.time_ < var_514_10 + var_514_11 and not isNil(var_514_9) then
				local var_514_12 = (arg_511_1.time_ - var_514_10) / var_514_11

				if arg_511_1.var_.characterEffect1074ui_story and not isNil(var_514_9) then
					local var_514_13 = Mathf.Lerp(0, 0.5, var_514_12)

					arg_511_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_511_1.var_.characterEffect1074ui_story.fillRatio = var_514_13
				end
			end

			if arg_511_1.time_ >= var_514_10 + var_514_11 and arg_511_1.time_ < var_514_10 + var_514_11 + arg_514_0 and not isNil(var_514_9) and arg_511_1.var_.characterEffect1074ui_story then
				local var_514_14 = 0.5

				arg_511_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_511_1.var_.characterEffect1074ui_story.fillRatio = var_514_14
			end

			local var_514_15 = arg_511_1.actors_["1074ui_story"].transform
			local var_514_16 = 0

			if var_514_16 < arg_511_1.time_ and arg_511_1.time_ <= var_514_16 + arg_514_0 then
				arg_511_1.var_.moveOldPos1074ui_story = var_514_15.localPosition
			end

			local var_514_17 = 0.001

			if var_514_16 <= arg_511_1.time_ and arg_511_1.time_ < var_514_16 + var_514_17 then
				local var_514_18 = (arg_511_1.time_ - var_514_16) / var_514_17
				local var_514_19 = Vector3.New(0, 100, 0)

				var_514_15.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos1074ui_story, var_514_19, var_514_18)

				local var_514_20 = manager.ui.mainCamera.transform.position - var_514_15.position

				var_514_15.forward = Vector3.New(var_514_20.x, var_514_20.y, var_514_20.z)

				local var_514_21 = var_514_15.localEulerAngles

				var_514_21.z = 0
				var_514_21.x = 0
				var_514_15.localEulerAngles = var_514_21
			end

			if arg_511_1.time_ >= var_514_16 + var_514_17 and arg_511_1.time_ < var_514_16 + var_514_17 + arg_514_0 then
				var_514_15.localPosition = Vector3.New(0, 100, 0)

				local var_514_22 = manager.ui.mainCamera.transform.position - var_514_15.position

				var_514_15.forward = Vector3.New(var_514_22.x, var_514_22.y, var_514_22.z)

				local var_514_23 = var_514_15.localEulerAngles

				var_514_23.z = 0
				var_514_23.x = 0
				var_514_15.localEulerAngles = var_514_23
			end

			local var_514_24 = arg_511_1.actors_["1074ui_story"]
			local var_514_25 = 0

			if var_514_25 < arg_511_1.time_ and arg_511_1.time_ <= var_514_25 + arg_514_0 and not isNil(var_514_24) and arg_511_1.var_.characterEffect1074ui_story == nil then
				arg_511_1.var_.characterEffect1074ui_story = var_514_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_26 = 0.200000002980232

			if var_514_25 <= arg_511_1.time_ and arg_511_1.time_ < var_514_25 + var_514_26 and not isNil(var_514_24) then
				local var_514_27 = (arg_511_1.time_ - var_514_25) / var_514_26

				if arg_511_1.var_.characterEffect1074ui_story and not isNil(var_514_24) then
					local var_514_28 = Mathf.Lerp(0, 0.5, var_514_27)

					arg_511_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_511_1.var_.characterEffect1074ui_story.fillRatio = var_514_28
				end
			end

			if arg_511_1.time_ >= var_514_25 + var_514_26 and arg_511_1.time_ < var_514_25 + var_514_26 + arg_514_0 and not isNil(var_514_24) and arg_511_1.var_.characterEffect1074ui_story then
				local var_514_29 = 0.5

				arg_511_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_511_1.var_.characterEffect1074ui_story.fillRatio = var_514_29
			end

			local var_514_30 = 0
			local var_514_31 = 0.7

			if var_514_30 < arg_511_1.time_ and arg_511_1.time_ <= var_514_30 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_32 = arg_511_1:GetWordFromCfg(222031126)
				local var_514_33 = arg_511_1:FormatText(var_514_32.content)

				arg_511_1.text_.text = var_514_33

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_34 = 28
				local var_514_35 = utf8.len(var_514_33)
				local var_514_36 = var_514_34 <= 0 and var_514_31 or var_514_31 * (var_514_35 / var_514_34)

				if var_514_36 > 0 and var_514_31 < var_514_36 then
					arg_511_1.talkMaxDuration = var_514_36

					if var_514_36 + var_514_30 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_36 + var_514_30
					end
				end

				arg_511_1.text_.text = var_514_33
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_37 = math.max(var_514_31, arg_511_1.talkMaxDuration)

			if var_514_30 <= arg_511_1.time_ and arg_511_1.time_ < var_514_30 + var_514_37 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_30) / var_514_37

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_30 + var_514_37 and arg_511_1.time_ < var_514_30 + var_514_37 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play222031127 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 222031127
		arg_515_1.duration_ = 13.1

		local var_515_0 = {
			ja = 13.1,
			ko = 6.066,
			zh = 6.1
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play222031128(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["1074ui_story"].transform
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 then
				arg_515_1.var_.moveOldPos1074ui_story = var_518_0.localPosition
			end

			local var_518_2 = 0.001

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_2 then
				local var_518_3 = (arg_515_1.time_ - var_518_1) / var_518_2
				local var_518_4 = Vector3.New(0, -1.055, -6.12)

				var_518_0.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos1074ui_story, var_518_4, var_518_3)

				local var_518_5 = manager.ui.mainCamera.transform.position - var_518_0.position

				var_518_0.forward = Vector3.New(var_518_5.x, var_518_5.y, var_518_5.z)

				local var_518_6 = var_518_0.localEulerAngles

				var_518_6.z = 0
				var_518_6.x = 0
				var_518_0.localEulerAngles = var_518_6
			end

			if arg_515_1.time_ >= var_518_1 + var_518_2 and arg_515_1.time_ < var_518_1 + var_518_2 + arg_518_0 then
				var_518_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_518_7 = manager.ui.mainCamera.transform.position - var_518_0.position

				var_518_0.forward = Vector3.New(var_518_7.x, var_518_7.y, var_518_7.z)

				local var_518_8 = var_518_0.localEulerAngles

				var_518_8.z = 0
				var_518_8.x = 0
				var_518_0.localEulerAngles = var_518_8
			end

			local var_518_9 = arg_515_1.actors_["1074ui_story"]
			local var_518_10 = 0

			if var_518_10 < arg_515_1.time_ and arg_515_1.time_ <= var_518_10 + arg_518_0 and not isNil(var_518_9) and arg_515_1.var_.characterEffect1074ui_story == nil then
				arg_515_1.var_.characterEffect1074ui_story = var_518_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_11 = 0.200000002980232

			if var_518_10 <= arg_515_1.time_ and arg_515_1.time_ < var_518_10 + var_518_11 and not isNil(var_518_9) then
				local var_518_12 = (arg_515_1.time_ - var_518_10) / var_518_11

				if arg_515_1.var_.characterEffect1074ui_story and not isNil(var_518_9) then
					arg_515_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_515_1.time_ >= var_518_10 + var_518_11 and arg_515_1.time_ < var_518_10 + var_518_11 + arg_518_0 and not isNil(var_518_9) and arg_515_1.var_.characterEffect1074ui_story then
				arg_515_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_518_13 = 0

			if var_518_13 < arg_515_1.time_ and arg_515_1.time_ <= var_518_13 + arg_518_0 then
				arg_515_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_518_14 = 0

			if var_518_14 < arg_515_1.time_ and arg_515_1.time_ <= var_518_14 + arg_518_0 then
				arg_515_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_518_15 = 0
			local var_518_16 = 0.625

			if var_518_15 < arg_515_1.time_ and arg_515_1.time_ <= var_518_15 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_17 = arg_515_1:FormatText(StoryNameCfg[410].name)

				arg_515_1.leftNameTxt_.text = var_518_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_18 = arg_515_1:GetWordFromCfg(222031127)
				local var_518_19 = arg_515_1:FormatText(var_518_18.content)

				arg_515_1.text_.text = var_518_19

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_20 = 25
				local var_518_21 = utf8.len(var_518_19)
				local var_518_22 = var_518_20 <= 0 and var_518_16 or var_518_16 * (var_518_21 / var_518_20)

				if var_518_22 > 0 and var_518_16 < var_518_22 then
					arg_515_1.talkMaxDuration = var_518_22

					if var_518_22 + var_518_15 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_22 + var_518_15
					end
				end

				arg_515_1.text_.text = var_518_19
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031127", "story_v_out_222031.awb") ~= 0 then
					local var_518_23 = manager.audio:GetVoiceLength("story_v_out_222031", "222031127", "story_v_out_222031.awb") / 1000

					if var_518_23 + var_518_15 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_23 + var_518_15
					end

					if var_518_18.prefab_name ~= "" and arg_515_1.actors_[var_518_18.prefab_name] ~= nil then
						local var_518_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_18.prefab_name].transform, "story_v_out_222031", "222031127", "story_v_out_222031.awb")

						arg_515_1:RecordAudio("222031127", var_518_24)
						arg_515_1:RecordAudio("222031127", var_518_24)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_222031", "222031127", "story_v_out_222031.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_222031", "222031127", "story_v_out_222031.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_25 = math.max(var_518_16, arg_515_1.talkMaxDuration)

			if var_518_15 <= arg_515_1.time_ and arg_515_1.time_ < var_518_15 + var_518_25 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_15) / var_518_25

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_15 + var_518_25 and arg_515_1.time_ < var_518_15 + var_518_25 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_515_1:InitPlayNodeList()
	end,
	Play222031128 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 222031128
		arg_519_1.duration_ = 7.07

		local var_519_0 = {
			ja = 6.366,
			ko = 7.033,
			zh = 7.066
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play222031129(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = arg_519_1.actors_["1074ui_story"]
			local var_522_1 = 0

			if var_522_1 < arg_519_1.time_ and arg_519_1.time_ <= var_522_1 + arg_522_0 and not isNil(var_522_0) and arg_519_1.var_.characterEffect1074ui_story == nil then
				arg_519_1.var_.characterEffect1074ui_story = var_522_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_2 = 0.200000002980232

			if var_522_1 <= arg_519_1.time_ and arg_519_1.time_ < var_522_1 + var_522_2 and not isNil(var_522_0) then
				local var_522_3 = (arg_519_1.time_ - var_522_1) / var_522_2

				if arg_519_1.var_.characterEffect1074ui_story and not isNil(var_522_0) then
					local var_522_4 = Mathf.Lerp(0, 0.5, var_522_3)

					arg_519_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_519_1.var_.characterEffect1074ui_story.fillRatio = var_522_4
				end
			end

			if arg_519_1.time_ >= var_522_1 + var_522_2 and arg_519_1.time_ < var_522_1 + var_522_2 + arg_522_0 and not isNil(var_522_0) and arg_519_1.var_.characterEffect1074ui_story then
				local var_522_5 = 0.5

				arg_519_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_519_1.var_.characterEffect1074ui_story.fillRatio = var_522_5
			end

			local var_522_6 = 0
			local var_522_7 = 0.7

			if var_522_6 < arg_519_1.time_ and arg_519_1.time_ <= var_522_6 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_8 = arg_519_1:FormatText(StoryNameCfg[461].name)

				arg_519_1.leftNameTxt_.text = var_522_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, true)
				arg_519_1.iconController_:SetSelectedState("hero")

				arg_519_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_519_1.callingController_:SetSelectedState("normal")

				arg_519_1.keyicon_.color = Color.New(1, 1, 1)
				arg_519_1.icon_.color = Color.New(1, 1, 1)

				local var_522_9 = arg_519_1:GetWordFromCfg(222031128)
				local var_522_10 = arg_519_1:FormatText(var_522_9.content)

				arg_519_1.text_.text = var_522_10

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_11 = 28
				local var_522_12 = utf8.len(var_522_10)
				local var_522_13 = var_522_11 <= 0 and var_522_7 or var_522_7 * (var_522_12 / var_522_11)

				if var_522_13 > 0 and var_522_7 < var_522_13 then
					arg_519_1.talkMaxDuration = var_522_13

					if var_522_13 + var_522_6 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_13 + var_522_6
					end
				end

				arg_519_1.text_.text = var_522_10
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031128", "story_v_out_222031.awb") ~= 0 then
					local var_522_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031128", "story_v_out_222031.awb") / 1000

					if var_522_14 + var_522_6 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_14 + var_522_6
					end

					if var_522_9.prefab_name ~= "" and arg_519_1.actors_[var_522_9.prefab_name] ~= nil then
						local var_522_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_9.prefab_name].transform, "story_v_out_222031", "222031128", "story_v_out_222031.awb")

						arg_519_1:RecordAudio("222031128", var_522_15)
						arg_519_1:RecordAudio("222031128", var_522_15)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_222031", "222031128", "story_v_out_222031.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_222031", "222031128", "story_v_out_222031.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_16 = math.max(var_522_7, arg_519_1.talkMaxDuration)

			if var_522_6 <= arg_519_1.time_ and arg_519_1.time_ < var_522_6 + var_522_16 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_6) / var_522_16

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_6 + var_522_16 and arg_519_1.time_ < var_522_6 + var_522_16 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play222031129 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 222031129
		arg_523_1.duration_ = 17.03

		local var_523_0 = {
			ja = 17.033,
			ko = 13.866,
			zh = 13.9
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play222031130(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0
			local var_526_1 = 1.325

			if var_526_0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_2 = arg_523_1:FormatText(StoryNameCfg[461].name)

				arg_523_1.leftNameTxt_.text = var_526_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_3 = arg_523_1:GetWordFromCfg(222031129)
				local var_526_4 = arg_523_1:FormatText(var_526_3.content)

				arg_523_1.text_.text = var_526_4

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 53
				local var_526_6 = utf8.len(var_526_4)
				local var_526_7 = var_526_5 <= 0 and var_526_1 or var_526_1 * (var_526_6 / var_526_5)

				if var_526_7 > 0 and var_526_1 < var_526_7 then
					arg_523_1.talkMaxDuration = var_526_7

					if var_526_7 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_7 + var_526_0
					end
				end

				arg_523_1.text_.text = var_526_4
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031129", "story_v_out_222031.awb") ~= 0 then
					local var_526_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031129", "story_v_out_222031.awb") / 1000

					if var_526_8 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_8 + var_526_0
					end

					if var_526_3.prefab_name ~= "" and arg_523_1.actors_[var_526_3.prefab_name] ~= nil then
						local var_526_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_3.prefab_name].transform, "story_v_out_222031", "222031129", "story_v_out_222031.awb")

						arg_523_1:RecordAudio("222031129", var_526_9)
						arg_523_1:RecordAudio("222031129", var_526_9)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_222031", "222031129", "story_v_out_222031.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_222031", "222031129", "story_v_out_222031.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_10 = math.max(var_526_1, arg_523_1.talkMaxDuration)

			if var_526_0 <= arg_523_1.time_ and arg_523_1.time_ < var_526_0 + var_526_10 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_0) / var_526_10

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_0 + var_526_10 and arg_523_1.time_ < var_526_0 + var_526_10 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play222031130 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 222031130
		arg_527_1.duration_ = 13.77

		local var_527_0 = {
			ja = 13.766,
			ko = 10.266,
			zh = 10.266
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play222031131(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = arg_527_1.actors_["1074ui_story"]
			local var_530_1 = 0

			if var_530_1 < arg_527_1.time_ and arg_527_1.time_ <= var_530_1 + arg_530_0 and not isNil(var_530_0) and arg_527_1.var_.characterEffect1074ui_story == nil then
				arg_527_1.var_.characterEffect1074ui_story = var_530_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_2 = 0.200000002980232

			if var_530_1 <= arg_527_1.time_ and arg_527_1.time_ < var_530_1 + var_530_2 and not isNil(var_530_0) then
				local var_530_3 = (arg_527_1.time_ - var_530_1) / var_530_2

				if arg_527_1.var_.characterEffect1074ui_story and not isNil(var_530_0) then
					arg_527_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= var_530_1 + var_530_2 and arg_527_1.time_ < var_530_1 + var_530_2 + arg_530_0 and not isNil(var_530_0) and arg_527_1.var_.characterEffect1074ui_story then
				arg_527_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_530_4 = 0
			local var_530_5 = 1.275

			if var_530_4 < arg_527_1.time_ and arg_527_1.time_ <= var_530_4 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_6 = arg_527_1:FormatText(StoryNameCfg[410].name)

				arg_527_1.leftNameTxt_.text = var_530_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_7 = arg_527_1:GetWordFromCfg(222031130)
				local var_530_8 = arg_527_1:FormatText(var_530_7.content)

				arg_527_1.text_.text = var_530_8

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_9 = 51
				local var_530_10 = utf8.len(var_530_8)
				local var_530_11 = var_530_9 <= 0 and var_530_5 or var_530_5 * (var_530_10 / var_530_9)

				if var_530_11 > 0 and var_530_5 < var_530_11 then
					arg_527_1.talkMaxDuration = var_530_11

					if var_530_11 + var_530_4 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_11 + var_530_4
					end
				end

				arg_527_1.text_.text = var_530_8
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031130", "story_v_out_222031.awb") ~= 0 then
					local var_530_12 = manager.audio:GetVoiceLength("story_v_out_222031", "222031130", "story_v_out_222031.awb") / 1000

					if var_530_12 + var_530_4 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_12 + var_530_4
					end

					if var_530_7.prefab_name ~= "" and arg_527_1.actors_[var_530_7.prefab_name] ~= nil then
						local var_530_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_7.prefab_name].transform, "story_v_out_222031", "222031130", "story_v_out_222031.awb")

						arg_527_1:RecordAudio("222031130", var_530_13)
						arg_527_1:RecordAudio("222031130", var_530_13)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_222031", "222031130", "story_v_out_222031.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_222031", "222031130", "story_v_out_222031.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_14 = math.max(var_530_5, arg_527_1.talkMaxDuration)

			if var_530_4 <= arg_527_1.time_ and arg_527_1.time_ < var_530_4 + var_530_14 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_4) / var_530_14

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_4 + var_530_14 and arg_527_1.time_ < var_530_4 + var_530_14 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play222031131 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 222031131
		arg_531_1.duration_ = 17.2

		local var_531_0 = {
			ja = 17.2,
			ko = 12.7,
			zh = 12.666
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play222031132(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0

			if var_534_0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_0 + arg_534_0 then
				arg_531_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_534_1 = 0
			local var_534_2 = 1.375

			if var_534_1 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_3 = arg_531_1:FormatText(StoryNameCfg[410].name)

				arg_531_1.leftNameTxt_.text = var_534_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_4 = arg_531_1:GetWordFromCfg(222031131)
				local var_534_5 = arg_531_1:FormatText(var_534_4.content)

				arg_531_1.text_.text = var_534_5

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_6 = 55
				local var_534_7 = utf8.len(var_534_5)
				local var_534_8 = var_534_6 <= 0 and var_534_2 or var_534_2 * (var_534_7 / var_534_6)

				if var_534_8 > 0 and var_534_2 < var_534_8 then
					arg_531_1.talkMaxDuration = var_534_8

					if var_534_8 + var_534_1 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_8 + var_534_1
					end
				end

				arg_531_1.text_.text = var_534_5
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031131", "story_v_out_222031.awb") ~= 0 then
					local var_534_9 = manager.audio:GetVoiceLength("story_v_out_222031", "222031131", "story_v_out_222031.awb") / 1000

					if var_534_9 + var_534_1 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_9 + var_534_1
					end

					if var_534_4.prefab_name ~= "" and arg_531_1.actors_[var_534_4.prefab_name] ~= nil then
						local var_534_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_4.prefab_name].transform, "story_v_out_222031", "222031131", "story_v_out_222031.awb")

						arg_531_1:RecordAudio("222031131", var_534_10)
						arg_531_1:RecordAudio("222031131", var_534_10)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_222031", "222031131", "story_v_out_222031.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_222031", "222031131", "story_v_out_222031.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_11 = math.max(var_534_2, arg_531_1.talkMaxDuration)

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_11 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_1) / var_534_11

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_1 + var_534_11 and arg_531_1.time_ < var_534_1 + var_534_11 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play222031132 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 222031132
		arg_535_1.duration_ = 5.8

		local var_535_0 = {
			ja = 5.8,
			ko = 4.133,
			zh = 4.133
		}
		local var_535_1 = manager.audio:GetLocalizationFlag()

		if var_535_0[var_535_1] ~= nil then
			arg_535_1.duration_ = var_535_0[var_535_1]
		end

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play222031133(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = arg_535_1.actors_["1074ui_story"]
			local var_538_1 = 0

			if var_538_1 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 and not isNil(var_538_0) and arg_535_1.var_.characterEffect1074ui_story == nil then
				arg_535_1.var_.characterEffect1074ui_story = var_538_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_2 = 0.200000002980232

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_2 and not isNil(var_538_0) then
				local var_538_3 = (arg_535_1.time_ - var_538_1) / var_538_2

				if arg_535_1.var_.characterEffect1074ui_story and not isNil(var_538_0) then
					local var_538_4 = Mathf.Lerp(0, 0.5, var_538_3)

					arg_535_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_535_1.var_.characterEffect1074ui_story.fillRatio = var_538_4
				end
			end

			if arg_535_1.time_ >= var_538_1 + var_538_2 and arg_535_1.time_ < var_538_1 + var_538_2 + arg_538_0 and not isNil(var_538_0) and arg_535_1.var_.characterEffect1074ui_story then
				local var_538_5 = 0.5

				arg_535_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_535_1.var_.characterEffect1074ui_story.fillRatio = var_538_5
			end

			local var_538_6 = 0
			local var_538_7 = 0.4

			if var_538_6 < arg_535_1.time_ and arg_535_1.time_ <= var_538_6 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				local var_538_8 = arg_535_1:FormatText(StoryNameCfg[461].name)

				arg_535_1.leftNameTxt_.text = var_538_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, true)
				arg_535_1.iconController_:SetSelectedState("hero")

				arg_535_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_535_1.callingController_:SetSelectedState("normal")

				arg_535_1.keyicon_.color = Color.New(1, 1, 1)
				arg_535_1.icon_.color = Color.New(1, 1, 1)

				local var_538_9 = arg_535_1:GetWordFromCfg(222031132)
				local var_538_10 = arg_535_1:FormatText(var_538_9.content)

				arg_535_1.text_.text = var_538_10

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_11 = 16
				local var_538_12 = utf8.len(var_538_10)
				local var_538_13 = var_538_11 <= 0 and var_538_7 or var_538_7 * (var_538_12 / var_538_11)

				if var_538_13 > 0 and var_538_7 < var_538_13 then
					arg_535_1.talkMaxDuration = var_538_13

					if var_538_13 + var_538_6 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_13 + var_538_6
					end
				end

				arg_535_1.text_.text = var_538_10
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031132", "story_v_out_222031.awb") ~= 0 then
					local var_538_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031132", "story_v_out_222031.awb") / 1000

					if var_538_14 + var_538_6 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_14 + var_538_6
					end

					if var_538_9.prefab_name ~= "" and arg_535_1.actors_[var_538_9.prefab_name] ~= nil then
						local var_538_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_9.prefab_name].transform, "story_v_out_222031", "222031132", "story_v_out_222031.awb")

						arg_535_1:RecordAudio("222031132", var_538_15)
						arg_535_1:RecordAudio("222031132", var_538_15)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_222031", "222031132", "story_v_out_222031.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_222031", "222031132", "story_v_out_222031.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_16 = math.max(var_538_7, arg_535_1.talkMaxDuration)

			if var_538_6 <= arg_535_1.time_ and arg_535_1.time_ < var_538_6 + var_538_16 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_6) / var_538_16

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_6 + var_538_16 and arg_535_1.time_ < var_538_6 + var_538_16 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play222031133 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 222031133
		arg_539_1.duration_ = 16.93

		local var_539_0 = {
			ja = 16.933,
			ko = 7.733,
			zh = 7.733
		}
		local var_539_1 = manager.audio:GetLocalizationFlag()

		if var_539_0[var_539_1] ~= nil then
			arg_539_1.duration_ = var_539_0[var_539_1]
		end

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play222031134(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = arg_539_1.actors_["1074ui_story"]
			local var_542_1 = 0

			if var_542_1 < arg_539_1.time_ and arg_539_1.time_ <= var_542_1 + arg_542_0 and not isNil(var_542_0) and arg_539_1.var_.characterEffect1074ui_story == nil then
				arg_539_1.var_.characterEffect1074ui_story = var_542_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_2 = 0.200000002980232

			if var_542_1 <= arg_539_1.time_ and arg_539_1.time_ < var_542_1 + var_542_2 and not isNil(var_542_0) then
				local var_542_3 = (arg_539_1.time_ - var_542_1) / var_542_2

				if arg_539_1.var_.characterEffect1074ui_story and not isNil(var_542_0) then
					arg_539_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_539_1.time_ >= var_542_1 + var_542_2 and arg_539_1.time_ < var_542_1 + var_542_2 + arg_542_0 and not isNil(var_542_0) and arg_539_1.var_.characterEffect1074ui_story then
				arg_539_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_542_4 = 0
			local var_542_5 = 1.025

			if var_542_4 < arg_539_1.time_ and arg_539_1.time_ <= var_542_4 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				local var_542_6 = arg_539_1:FormatText(StoryNameCfg[410].name)

				arg_539_1.leftNameTxt_.text = var_542_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_7 = arg_539_1:GetWordFromCfg(222031133)
				local var_542_8 = arg_539_1:FormatText(var_542_7.content)

				arg_539_1.text_.text = var_542_8

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_9 = 41
				local var_542_10 = utf8.len(var_542_8)
				local var_542_11 = var_542_9 <= 0 and var_542_5 or var_542_5 * (var_542_10 / var_542_9)

				if var_542_11 > 0 and var_542_5 < var_542_11 then
					arg_539_1.talkMaxDuration = var_542_11

					if var_542_11 + var_542_4 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_11 + var_542_4
					end
				end

				arg_539_1.text_.text = var_542_8
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031133", "story_v_out_222031.awb") ~= 0 then
					local var_542_12 = manager.audio:GetVoiceLength("story_v_out_222031", "222031133", "story_v_out_222031.awb") / 1000

					if var_542_12 + var_542_4 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_12 + var_542_4
					end

					if var_542_7.prefab_name ~= "" and arg_539_1.actors_[var_542_7.prefab_name] ~= nil then
						local var_542_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_7.prefab_name].transform, "story_v_out_222031", "222031133", "story_v_out_222031.awb")

						arg_539_1:RecordAudio("222031133", var_542_13)
						arg_539_1:RecordAudio("222031133", var_542_13)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_out_222031", "222031133", "story_v_out_222031.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_out_222031", "222031133", "story_v_out_222031.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_14 = math.max(var_542_5, arg_539_1.talkMaxDuration)

			if var_542_4 <= arg_539_1.time_ and arg_539_1.time_ < var_542_4 + var_542_14 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_4) / var_542_14

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_4 + var_542_14 and arg_539_1.time_ < var_542_4 + var_542_14 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play222031134 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 222031134
		arg_543_1.duration_ = 14.5

		local var_543_0 = {
			ja = 14.5,
			ko = 7.766,
			zh = 7.733
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play222031135(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0
			local var_546_1 = 1.025

			if var_546_0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_0 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				local var_546_2 = arg_543_1:FormatText(StoryNameCfg[410].name)

				arg_543_1.leftNameTxt_.text = var_546_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_3 = arg_543_1:GetWordFromCfg(222031134)
				local var_546_4 = arg_543_1:FormatText(var_546_3.content)

				arg_543_1.text_.text = var_546_4

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_5 = 41
				local var_546_6 = utf8.len(var_546_4)
				local var_546_7 = var_546_5 <= 0 and var_546_1 or var_546_1 * (var_546_6 / var_546_5)

				if var_546_7 > 0 and var_546_1 < var_546_7 then
					arg_543_1.talkMaxDuration = var_546_7

					if var_546_7 + var_546_0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_7 + var_546_0
					end
				end

				arg_543_1.text_.text = var_546_4
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031134", "story_v_out_222031.awb") ~= 0 then
					local var_546_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031134", "story_v_out_222031.awb") / 1000

					if var_546_8 + var_546_0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_8 + var_546_0
					end

					if var_546_3.prefab_name ~= "" and arg_543_1.actors_[var_546_3.prefab_name] ~= nil then
						local var_546_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_3.prefab_name].transform, "story_v_out_222031", "222031134", "story_v_out_222031.awb")

						arg_543_1:RecordAudio("222031134", var_546_9)
						arg_543_1:RecordAudio("222031134", var_546_9)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_222031", "222031134", "story_v_out_222031.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_222031", "222031134", "story_v_out_222031.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_10 = math.max(var_546_1, arg_543_1.talkMaxDuration)

			if var_546_0 <= arg_543_1.time_ and arg_543_1.time_ < var_546_0 + var_546_10 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_0) / var_546_10

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_0 + var_546_10 and arg_543_1.time_ < var_546_0 + var_546_10 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play222031135 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 222031135
		arg_547_1.duration_ = 17.6

		local var_547_0 = {
			ja = 17.6,
			ko = 12.366,
			zh = 12.366
		}
		local var_547_1 = manager.audio:GetLocalizationFlag()

		if var_547_0[var_547_1] ~= nil then
			arg_547_1.duration_ = var_547_0[var_547_1]
		end

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play222031136(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = 0
			local var_550_1 = 1.4

			if var_550_0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_0 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				local var_550_2 = arg_547_1:FormatText(StoryNameCfg[410].name)

				arg_547_1.leftNameTxt_.text = var_550_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_3 = arg_547_1:GetWordFromCfg(222031135)
				local var_550_4 = arg_547_1:FormatText(var_550_3.content)

				arg_547_1.text_.text = var_550_4

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_5 = 56
				local var_550_6 = utf8.len(var_550_4)
				local var_550_7 = var_550_5 <= 0 and var_550_1 or var_550_1 * (var_550_6 / var_550_5)

				if var_550_7 > 0 and var_550_1 < var_550_7 then
					arg_547_1.talkMaxDuration = var_550_7

					if var_550_7 + var_550_0 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_7 + var_550_0
					end
				end

				arg_547_1.text_.text = var_550_4
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031135", "story_v_out_222031.awb") ~= 0 then
					local var_550_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031135", "story_v_out_222031.awb") / 1000

					if var_550_8 + var_550_0 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_8 + var_550_0
					end

					if var_550_3.prefab_name ~= "" and arg_547_1.actors_[var_550_3.prefab_name] ~= nil then
						local var_550_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_3.prefab_name].transform, "story_v_out_222031", "222031135", "story_v_out_222031.awb")

						arg_547_1:RecordAudio("222031135", var_550_9)
						arg_547_1:RecordAudio("222031135", var_550_9)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_out_222031", "222031135", "story_v_out_222031.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_out_222031", "222031135", "story_v_out_222031.awb")
				end

				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_10 = math.max(var_550_1, arg_547_1.talkMaxDuration)

			if var_550_0 <= arg_547_1.time_ and arg_547_1.time_ < var_550_0 + var_550_10 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_0) / var_550_10

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_0 + var_550_10 and arg_547_1.time_ < var_550_0 + var_550_10 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play222031136 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 222031136
		arg_551_1.duration_ = 22.07

		local var_551_0 = {
			ja = 22.066,
			ko = 15.5,
			zh = 15.5
		}
		local var_551_1 = manager.audio:GetLocalizationFlag()

		if var_551_0[var_551_1] ~= nil then
			arg_551_1.duration_ = var_551_0[var_551_1]
		end

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play222031137(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = arg_551_1.actors_["1074ui_story"]
			local var_554_1 = 0

			if var_554_1 < arg_551_1.time_ and arg_551_1.time_ <= var_554_1 + arg_554_0 and not isNil(var_554_0) and arg_551_1.var_.characterEffect1074ui_story == nil then
				arg_551_1.var_.characterEffect1074ui_story = var_554_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_2 = 0.200000002980232

			if var_554_1 <= arg_551_1.time_ and arg_551_1.time_ < var_554_1 + var_554_2 and not isNil(var_554_0) then
				local var_554_3 = (arg_551_1.time_ - var_554_1) / var_554_2

				if arg_551_1.var_.characterEffect1074ui_story and not isNil(var_554_0) then
					local var_554_4 = Mathf.Lerp(0, 0.5, var_554_3)

					arg_551_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_551_1.var_.characterEffect1074ui_story.fillRatio = var_554_4
				end
			end

			if arg_551_1.time_ >= var_554_1 + var_554_2 and arg_551_1.time_ < var_554_1 + var_554_2 + arg_554_0 and not isNil(var_554_0) and arg_551_1.var_.characterEffect1074ui_story then
				local var_554_5 = 0.5

				arg_551_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_551_1.var_.characterEffect1074ui_story.fillRatio = var_554_5
			end

			local var_554_6 = 0
			local var_554_7 = 1.075

			if var_554_6 < arg_551_1.time_ and arg_551_1.time_ <= var_554_6 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				local var_554_8 = arg_551_1:FormatText(StoryNameCfg[461].name)

				arg_551_1.leftNameTxt_.text = var_554_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, true)
				arg_551_1.iconController_:SetSelectedState("hero")

				arg_551_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_551_1.callingController_:SetSelectedState("normal")

				arg_551_1.keyicon_.color = Color.New(1, 1, 1)
				arg_551_1.icon_.color = Color.New(1, 1, 1)

				local var_554_9 = arg_551_1:GetWordFromCfg(222031136)
				local var_554_10 = arg_551_1:FormatText(var_554_9.content)

				arg_551_1.text_.text = var_554_10

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_11 = 43
				local var_554_12 = utf8.len(var_554_10)
				local var_554_13 = var_554_11 <= 0 and var_554_7 or var_554_7 * (var_554_12 / var_554_11)

				if var_554_13 > 0 and var_554_7 < var_554_13 then
					arg_551_1.talkMaxDuration = var_554_13

					if var_554_13 + var_554_6 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_13 + var_554_6
					end
				end

				arg_551_1.text_.text = var_554_10
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031136", "story_v_out_222031.awb") ~= 0 then
					local var_554_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031136", "story_v_out_222031.awb") / 1000

					if var_554_14 + var_554_6 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_14 + var_554_6
					end

					if var_554_9.prefab_name ~= "" and arg_551_1.actors_[var_554_9.prefab_name] ~= nil then
						local var_554_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_9.prefab_name].transform, "story_v_out_222031", "222031136", "story_v_out_222031.awb")

						arg_551_1:RecordAudio("222031136", var_554_15)
						arg_551_1:RecordAudio("222031136", var_554_15)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_out_222031", "222031136", "story_v_out_222031.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_out_222031", "222031136", "story_v_out_222031.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_16 = math.max(var_554_7, arg_551_1.talkMaxDuration)

			if var_554_6 <= arg_551_1.time_ and arg_551_1.time_ < var_554_6 + var_554_16 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_6) / var_554_16

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_6 + var_554_16 and arg_551_1.time_ < var_554_6 + var_554_16 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play222031137 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 222031137
		arg_555_1.duration_ = 9.13

		local var_555_0 = {
			ja = 9.133,
			ko = 9.066,
			zh = 9.066
		}
		local var_555_1 = manager.audio:GetLocalizationFlag()

		if var_555_0[var_555_1] ~= nil then
			arg_555_1.duration_ = var_555_0[var_555_1]
		end

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play222031138(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = arg_555_1.actors_["1074ui_story"]
			local var_558_1 = 0

			if var_558_1 < arg_555_1.time_ and arg_555_1.time_ <= var_558_1 + arg_558_0 and not isNil(var_558_0) and arg_555_1.var_.characterEffect1074ui_story == nil then
				arg_555_1.var_.characterEffect1074ui_story = var_558_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_2 = 0.200000002980232

			if var_558_1 <= arg_555_1.time_ and arg_555_1.time_ < var_558_1 + var_558_2 and not isNil(var_558_0) then
				local var_558_3 = (arg_555_1.time_ - var_558_1) / var_558_2

				if arg_555_1.var_.characterEffect1074ui_story and not isNil(var_558_0) then
					arg_555_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_555_1.time_ >= var_558_1 + var_558_2 and arg_555_1.time_ < var_558_1 + var_558_2 + arg_558_0 and not isNil(var_558_0) and arg_555_1.var_.characterEffect1074ui_story then
				arg_555_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_558_4 = 0
			local var_558_5 = 0.95

			if var_558_4 < arg_555_1.time_ and arg_555_1.time_ <= var_558_4 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				local var_558_6 = arg_555_1:FormatText(StoryNameCfg[410].name)

				arg_555_1.leftNameTxt_.text = var_558_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_7 = arg_555_1:GetWordFromCfg(222031137)
				local var_558_8 = arg_555_1:FormatText(var_558_7.content)

				arg_555_1.text_.text = var_558_8

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_9 = 38
				local var_558_10 = utf8.len(var_558_8)
				local var_558_11 = var_558_9 <= 0 and var_558_5 or var_558_5 * (var_558_10 / var_558_9)

				if var_558_11 > 0 and var_558_5 < var_558_11 then
					arg_555_1.talkMaxDuration = var_558_11

					if var_558_11 + var_558_4 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_11 + var_558_4
					end
				end

				arg_555_1.text_.text = var_558_8
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031137", "story_v_out_222031.awb") ~= 0 then
					local var_558_12 = manager.audio:GetVoiceLength("story_v_out_222031", "222031137", "story_v_out_222031.awb") / 1000

					if var_558_12 + var_558_4 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_12 + var_558_4
					end

					if var_558_7.prefab_name ~= "" and arg_555_1.actors_[var_558_7.prefab_name] ~= nil then
						local var_558_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_7.prefab_name].transform, "story_v_out_222031", "222031137", "story_v_out_222031.awb")

						arg_555_1:RecordAudio("222031137", var_558_13)
						arg_555_1:RecordAudio("222031137", var_558_13)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_out_222031", "222031137", "story_v_out_222031.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_out_222031", "222031137", "story_v_out_222031.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_14 = math.max(var_558_5, arg_555_1.talkMaxDuration)

			if var_558_4 <= arg_555_1.time_ and arg_555_1.time_ < var_558_4 + var_558_14 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_4) / var_558_14

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_4 + var_558_14 and arg_555_1.time_ < var_558_4 + var_558_14 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play222031138 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 222031138
		arg_559_1.duration_ = 5.7

		local var_559_0 = {
			ja = 5.7,
			ko = 3.933,
			zh = 4.033
		}
		local var_559_1 = manager.audio:GetLocalizationFlag()

		if var_559_0[var_559_1] ~= nil then
			arg_559_1.duration_ = var_559_0[var_559_1]
		end

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play222031139(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0
			local var_562_1 = 0.5

			if var_562_0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				local var_562_2 = arg_559_1:FormatText(StoryNameCfg[410].name)

				arg_559_1.leftNameTxt_.text = var_562_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_3 = arg_559_1:GetWordFromCfg(222031138)
				local var_562_4 = arg_559_1:FormatText(var_562_3.content)

				arg_559_1.text_.text = var_562_4

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_5 = 20
				local var_562_6 = utf8.len(var_562_4)
				local var_562_7 = var_562_5 <= 0 and var_562_1 or var_562_1 * (var_562_6 / var_562_5)

				if var_562_7 > 0 and var_562_1 < var_562_7 then
					arg_559_1.talkMaxDuration = var_562_7

					if var_562_7 + var_562_0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_7 + var_562_0
					end
				end

				arg_559_1.text_.text = var_562_4
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031138", "story_v_out_222031.awb") ~= 0 then
					local var_562_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031138", "story_v_out_222031.awb") / 1000

					if var_562_8 + var_562_0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_8 + var_562_0
					end

					if var_562_3.prefab_name ~= "" and arg_559_1.actors_[var_562_3.prefab_name] ~= nil then
						local var_562_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_3.prefab_name].transform, "story_v_out_222031", "222031138", "story_v_out_222031.awb")

						arg_559_1:RecordAudio("222031138", var_562_9)
						arg_559_1:RecordAudio("222031138", var_562_9)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_out_222031", "222031138", "story_v_out_222031.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_out_222031", "222031138", "story_v_out_222031.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_10 = math.max(var_562_1, arg_559_1.talkMaxDuration)

			if var_562_0 <= arg_559_1.time_ and arg_559_1.time_ < var_562_0 + var_562_10 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_0) / var_562_10

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_0 + var_562_10 and arg_559_1.time_ < var_562_0 + var_562_10 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play222031139 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 222031139
		arg_563_1.duration_ = 16.13

		local var_563_0 = {
			ja = 16.133,
			ko = 14.266,
			zh = 14.266
		}
		local var_563_1 = manager.audio:GetLocalizationFlag()

		if var_563_0[var_563_1] ~= nil then
			arg_563_1.duration_ = var_563_0[var_563_1]
		end

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play222031140(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = arg_563_1.actors_["1074ui_story"]
			local var_566_1 = 0

			if var_566_1 < arg_563_1.time_ and arg_563_1.time_ <= var_566_1 + arg_566_0 and not isNil(var_566_0) and arg_563_1.var_.characterEffect1074ui_story == nil then
				arg_563_1.var_.characterEffect1074ui_story = var_566_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_2 = 0.200000002980232

			if var_566_1 <= arg_563_1.time_ and arg_563_1.time_ < var_566_1 + var_566_2 and not isNil(var_566_0) then
				local var_566_3 = (arg_563_1.time_ - var_566_1) / var_566_2

				if arg_563_1.var_.characterEffect1074ui_story and not isNil(var_566_0) then
					local var_566_4 = Mathf.Lerp(0, 0.5, var_566_3)

					arg_563_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_563_1.var_.characterEffect1074ui_story.fillRatio = var_566_4
				end
			end

			if arg_563_1.time_ >= var_566_1 + var_566_2 and arg_563_1.time_ < var_566_1 + var_566_2 + arg_566_0 and not isNil(var_566_0) and arg_563_1.var_.characterEffect1074ui_story then
				local var_566_5 = 0.5

				arg_563_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_563_1.var_.characterEffect1074ui_story.fillRatio = var_566_5
			end

			local var_566_6 = 0
			local var_566_7 = 1.25

			if var_566_6 < arg_563_1.time_ and arg_563_1.time_ <= var_566_6 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				local var_566_8 = arg_563_1:FormatText(StoryNameCfg[461].name)

				arg_563_1.leftNameTxt_.text = var_566_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, true)
				arg_563_1.iconController_:SetSelectedState("hero")

				arg_563_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_563_1.callingController_:SetSelectedState("normal")

				arg_563_1.keyicon_.color = Color.New(1, 1, 1)
				arg_563_1.icon_.color = Color.New(1, 1, 1)

				local var_566_9 = arg_563_1:GetWordFromCfg(222031139)
				local var_566_10 = arg_563_1:FormatText(var_566_9.content)

				arg_563_1.text_.text = var_566_10

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_11 = 50
				local var_566_12 = utf8.len(var_566_10)
				local var_566_13 = var_566_11 <= 0 and var_566_7 or var_566_7 * (var_566_12 / var_566_11)

				if var_566_13 > 0 and var_566_7 < var_566_13 then
					arg_563_1.talkMaxDuration = var_566_13

					if var_566_13 + var_566_6 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_13 + var_566_6
					end
				end

				arg_563_1.text_.text = var_566_10
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031139", "story_v_out_222031.awb") ~= 0 then
					local var_566_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031139", "story_v_out_222031.awb") / 1000

					if var_566_14 + var_566_6 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_14 + var_566_6
					end

					if var_566_9.prefab_name ~= "" and arg_563_1.actors_[var_566_9.prefab_name] ~= nil then
						local var_566_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_9.prefab_name].transform, "story_v_out_222031", "222031139", "story_v_out_222031.awb")

						arg_563_1:RecordAudio("222031139", var_566_15)
						arg_563_1:RecordAudio("222031139", var_566_15)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_out_222031", "222031139", "story_v_out_222031.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_out_222031", "222031139", "story_v_out_222031.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_16 = math.max(var_566_7, arg_563_1.talkMaxDuration)

			if var_566_6 <= arg_563_1.time_ and arg_563_1.time_ < var_566_6 + var_566_16 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_6) / var_566_16

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_6 + var_566_16 and arg_563_1.time_ < var_566_6 + var_566_16 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play222031140 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 222031140
		arg_567_1.duration_ = 10.93

		local var_567_0 = {
			ja = 10.933,
			ko = 8.466,
			zh = 8.466
		}
		local var_567_1 = manager.audio:GetLocalizationFlag()

		if var_567_0[var_567_1] ~= nil then
			arg_567_1.duration_ = var_567_0[var_567_1]
		end

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play222031141(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 0
			local var_570_1 = 0.825

			if var_570_0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_0 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				local var_570_2 = arg_567_1:FormatText(StoryNameCfg[461].name)

				arg_567_1.leftNameTxt_.text = var_570_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, true)
				arg_567_1.iconController_:SetSelectedState("hero")

				arg_567_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_567_1.callingController_:SetSelectedState("normal")

				arg_567_1.keyicon_.color = Color.New(1, 1, 1)
				arg_567_1.icon_.color = Color.New(1, 1, 1)

				local var_570_3 = arg_567_1:GetWordFromCfg(222031140)
				local var_570_4 = arg_567_1:FormatText(var_570_3.content)

				arg_567_1.text_.text = var_570_4

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_5 = 33
				local var_570_6 = utf8.len(var_570_4)
				local var_570_7 = var_570_5 <= 0 and var_570_1 or var_570_1 * (var_570_6 / var_570_5)

				if var_570_7 > 0 and var_570_1 < var_570_7 then
					arg_567_1.talkMaxDuration = var_570_7

					if var_570_7 + var_570_0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_7 + var_570_0
					end
				end

				arg_567_1.text_.text = var_570_4
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031140", "story_v_out_222031.awb") ~= 0 then
					local var_570_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031140", "story_v_out_222031.awb") / 1000

					if var_570_8 + var_570_0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_8 + var_570_0
					end

					if var_570_3.prefab_name ~= "" and arg_567_1.actors_[var_570_3.prefab_name] ~= nil then
						local var_570_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_3.prefab_name].transform, "story_v_out_222031", "222031140", "story_v_out_222031.awb")

						arg_567_1:RecordAudio("222031140", var_570_9)
						arg_567_1:RecordAudio("222031140", var_570_9)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_out_222031", "222031140", "story_v_out_222031.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_out_222031", "222031140", "story_v_out_222031.awb")
				end

				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_10 = math.max(var_570_1, arg_567_1.talkMaxDuration)

			if var_570_0 <= arg_567_1.time_ and arg_567_1.time_ < var_570_0 + var_570_10 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_0) / var_570_10

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_0 + var_570_10 and arg_567_1.time_ < var_570_0 + var_570_10 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play222031141 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 222031141
		arg_571_1.duration_ = 16.23

		local var_571_0 = {
			ja = 16.233,
			ko = 14.166,
			zh = 14.2
		}
		local var_571_1 = manager.audio:GetLocalizationFlag()

		if var_571_0[var_571_1] ~= nil then
			arg_571_1.duration_ = var_571_0[var_571_1]
		end

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play222031142(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = 0
			local var_574_1 = 1.225

			if var_574_0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_0 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				local var_574_2 = arg_571_1:FormatText(StoryNameCfg[461].name)

				arg_571_1.leftNameTxt_.text = var_574_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, true)
				arg_571_1.iconController_:SetSelectedState("hero")

				arg_571_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_571_1.callingController_:SetSelectedState("normal")

				arg_571_1.keyicon_.color = Color.New(1, 1, 1)
				arg_571_1.icon_.color = Color.New(1, 1, 1)

				local var_574_3 = arg_571_1:GetWordFromCfg(222031141)
				local var_574_4 = arg_571_1:FormatText(var_574_3.content)

				arg_571_1.text_.text = var_574_4

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_5 = 50
				local var_574_6 = utf8.len(var_574_4)
				local var_574_7 = var_574_5 <= 0 and var_574_1 or var_574_1 * (var_574_6 / var_574_5)

				if var_574_7 > 0 and var_574_1 < var_574_7 then
					arg_571_1.talkMaxDuration = var_574_7

					if var_574_7 + var_574_0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_7 + var_574_0
					end
				end

				arg_571_1.text_.text = var_574_4
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031141", "story_v_out_222031.awb") ~= 0 then
					local var_574_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031141", "story_v_out_222031.awb") / 1000

					if var_574_8 + var_574_0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_8 + var_574_0
					end

					if var_574_3.prefab_name ~= "" and arg_571_1.actors_[var_574_3.prefab_name] ~= nil then
						local var_574_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_3.prefab_name].transform, "story_v_out_222031", "222031141", "story_v_out_222031.awb")

						arg_571_1:RecordAudio("222031141", var_574_9)
						arg_571_1:RecordAudio("222031141", var_574_9)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_out_222031", "222031141", "story_v_out_222031.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_out_222031", "222031141", "story_v_out_222031.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_10 = math.max(var_574_1, arg_571_1.talkMaxDuration)

			if var_574_0 <= arg_571_1.time_ and arg_571_1.time_ < var_574_0 + var_574_10 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_0) / var_574_10

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_0 + var_574_10 and arg_571_1.time_ < var_574_0 + var_574_10 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play222031142 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 222031142
		arg_575_1.duration_ = 6.8

		local var_575_0 = {
			ja = 6.8,
			ko = 4.9,
			zh = 4.9
		}
		local var_575_1 = manager.audio:GetLocalizationFlag()

		if var_575_0[var_575_1] ~= nil then
			arg_575_1.duration_ = var_575_0[var_575_1]
		end

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play222031143(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = arg_575_1.actors_["1074ui_story"]
			local var_578_1 = 0

			if var_578_1 < arg_575_1.time_ and arg_575_1.time_ <= var_578_1 + arg_578_0 and not isNil(var_578_0) and arg_575_1.var_.characterEffect1074ui_story == nil then
				arg_575_1.var_.characterEffect1074ui_story = var_578_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_2 = 0.200000002980232

			if var_578_1 <= arg_575_1.time_ and arg_575_1.time_ < var_578_1 + var_578_2 and not isNil(var_578_0) then
				local var_578_3 = (arg_575_1.time_ - var_578_1) / var_578_2

				if arg_575_1.var_.characterEffect1074ui_story and not isNil(var_578_0) then
					arg_575_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_575_1.time_ >= var_578_1 + var_578_2 and arg_575_1.time_ < var_578_1 + var_578_2 + arg_578_0 and not isNil(var_578_0) and arg_575_1.var_.characterEffect1074ui_story then
				arg_575_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_578_4 = 0

			if var_578_4 < arg_575_1.time_ and arg_575_1.time_ <= var_578_4 + arg_578_0 then
				arg_575_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			local var_578_5 = 0
			local var_578_6 = 0.475

			if var_578_5 < arg_575_1.time_ and arg_575_1.time_ <= var_578_5 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				local var_578_7 = arg_575_1:FormatText(StoryNameCfg[410].name)

				arg_575_1.leftNameTxt_.text = var_578_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_8 = arg_575_1:GetWordFromCfg(222031142)
				local var_578_9 = arg_575_1:FormatText(var_578_8.content)

				arg_575_1.text_.text = var_578_9

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_10 = 19
				local var_578_11 = utf8.len(var_578_9)
				local var_578_12 = var_578_10 <= 0 and var_578_6 or var_578_6 * (var_578_11 / var_578_10)

				if var_578_12 > 0 and var_578_6 < var_578_12 then
					arg_575_1.talkMaxDuration = var_578_12

					if var_578_12 + var_578_5 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_12 + var_578_5
					end
				end

				arg_575_1.text_.text = var_578_9
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031142", "story_v_out_222031.awb") ~= 0 then
					local var_578_13 = manager.audio:GetVoiceLength("story_v_out_222031", "222031142", "story_v_out_222031.awb") / 1000

					if var_578_13 + var_578_5 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_13 + var_578_5
					end

					if var_578_8.prefab_name ~= "" and arg_575_1.actors_[var_578_8.prefab_name] ~= nil then
						local var_578_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_8.prefab_name].transform, "story_v_out_222031", "222031142", "story_v_out_222031.awb")

						arg_575_1:RecordAudio("222031142", var_578_14)
						arg_575_1:RecordAudio("222031142", var_578_14)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_out_222031", "222031142", "story_v_out_222031.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_out_222031", "222031142", "story_v_out_222031.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_15 = math.max(var_578_6, arg_575_1.talkMaxDuration)

			if var_578_5 <= arg_575_1.time_ and arg_575_1.time_ < var_578_5 + var_578_15 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_5) / var_578_15

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_5 + var_578_15 and arg_575_1.time_ < var_578_5 + var_578_15 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play222031143 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 222031143
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play222031144(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = arg_579_1.actors_["1074ui_story"].transform
			local var_582_1 = 0

			if var_582_1 < arg_579_1.time_ and arg_579_1.time_ <= var_582_1 + arg_582_0 then
				arg_579_1.var_.moveOldPos1074ui_story = var_582_0.localPosition
			end

			local var_582_2 = 0.001

			if var_582_1 <= arg_579_1.time_ and arg_579_1.time_ < var_582_1 + var_582_2 then
				local var_582_3 = (arg_579_1.time_ - var_582_1) / var_582_2
				local var_582_4 = Vector3.New(0, 100, 0)

				var_582_0.localPosition = Vector3.Lerp(arg_579_1.var_.moveOldPos1074ui_story, var_582_4, var_582_3)

				local var_582_5 = manager.ui.mainCamera.transform.position - var_582_0.position

				var_582_0.forward = Vector3.New(var_582_5.x, var_582_5.y, var_582_5.z)

				local var_582_6 = var_582_0.localEulerAngles

				var_582_6.z = 0
				var_582_6.x = 0
				var_582_0.localEulerAngles = var_582_6
			end

			if arg_579_1.time_ >= var_582_1 + var_582_2 and arg_579_1.time_ < var_582_1 + var_582_2 + arg_582_0 then
				var_582_0.localPosition = Vector3.New(0, 100, 0)

				local var_582_7 = manager.ui.mainCamera.transform.position - var_582_0.position

				var_582_0.forward = Vector3.New(var_582_7.x, var_582_7.y, var_582_7.z)

				local var_582_8 = var_582_0.localEulerAngles

				var_582_8.z = 0
				var_582_8.x = 0
				var_582_0.localEulerAngles = var_582_8
			end

			local var_582_9 = arg_579_1.actors_["1074ui_story"]
			local var_582_10 = 0

			if var_582_10 < arg_579_1.time_ and arg_579_1.time_ <= var_582_10 + arg_582_0 and not isNil(var_582_9) and arg_579_1.var_.characterEffect1074ui_story == nil then
				arg_579_1.var_.characterEffect1074ui_story = var_582_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_582_11 = 0.200000002980232

			if var_582_10 <= arg_579_1.time_ and arg_579_1.time_ < var_582_10 + var_582_11 and not isNil(var_582_9) then
				local var_582_12 = (arg_579_1.time_ - var_582_10) / var_582_11

				if arg_579_1.var_.characterEffect1074ui_story and not isNil(var_582_9) then
					local var_582_13 = Mathf.Lerp(0, 0.5, var_582_12)

					arg_579_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_579_1.var_.characterEffect1074ui_story.fillRatio = var_582_13
				end
			end

			if arg_579_1.time_ >= var_582_10 + var_582_11 and arg_579_1.time_ < var_582_10 + var_582_11 + arg_582_0 and not isNil(var_582_9) and arg_579_1.var_.characterEffect1074ui_story then
				local var_582_14 = 0.5

				arg_579_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_579_1.var_.characterEffect1074ui_story.fillRatio = var_582_14
			end

			local var_582_15 = 0
			local var_582_16 = 1.075

			if var_582_15 < arg_579_1.time_ and arg_579_1.time_ <= var_582_15 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, false)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_17 = arg_579_1:GetWordFromCfg(222031143)
				local var_582_18 = arg_579_1:FormatText(var_582_17.content)

				arg_579_1.text_.text = var_582_18

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_19 = 43
				local var_582_20 = utf8.len(var_582_18)
				local var_582_21 = var_582_19 <= 0 and var_582_16 or var_582_16 * (var_582_20 / var_582_19)

				if var_582_21 > 0 and var_582_16 < var_582_21 then
					arg_579_1.talkMaxDuration = var_582_21

					if var_582_21 + var_582_15 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_21 + var_582_15
					end
				end

				arg_579_1.text_.text = var_582_18
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_22 = math.max(var_582_16, arg_579_1.talkMaxDuration)

			if var_582_15 <= arg_579_1.time_ and arg_579_1.time_ < var_582_15 + var_582_22 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_15) / var_582_22

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_15 + var_582_22 and arg_579_1.time_ < var_582_15 + var_582_22 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_579_1:InitPlayNodeList()
	end,
	Play222031144 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 222031144
		arg_583_1.duration_ = 4.87

		local var_583_0 = {
			ja = 4.866,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_583_1 = manager.audio:GetLocalizationFlag()

		if var_583_0[var_583_1] ~= nil then
			arg_583_1.duration_ = var_583_0[var_583_1]
		end

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play222031145(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = arg_583_1.actors_["1070ui_story"].transform
			local var_586_1 = 0

			if var_586_1 < arg_583_1.time_ and arg_583_1.time_ <= var_586_1 + arg_586_0 then
				arg_583_1.var_.moveOldPos1070ui_story = var_586_0.localPosition
			end

			local var_586_2 = 0.001

			if var_586_1 <= arg_583_1.time_ and arg_583_1.time_ < var_586_1 + var_586_2 then
				local var_586_3 = (arg_583_1.time_ - var_586_1) / var_586_2
				local var_586_4 = Vector3.New(0, -0.95, -6.05)

				var_586_0.localPosition = Vector3.Lerp(arg_583_1.var_.moveOldPos1070ui_story, var_586_4, var_586_3)

				local var_586_5 = manager.ui.mainCamera.transform.position - var_586_0.position

				var_586_0.forward = Vector3.New(var_586_5.x, var_586_5.y, var_586_5.z)

				local var_586_6 = var_586_0.localEulerAngles

				var_586_6.z = 0
				var_586_6.x = 0
				var_586_0.localEulerAngles = var_586_6
			end

			if arg_583_1.time_ >= var_586_1 + var_586_2 and arg_583_1.time_ < var_586_1 + var_586_2 + arg_586_0 then
				var_586_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_586_7 = manager.ui.mainCamera.transform.position - var_586_0.position

				var_586_0.forward = Vector3.New(var_586_7.x, var_586_7.y, var_586_7.z)

				local var_586_8 = var_586_0.localEulerAngles

				var_586_8.z = 0
				var_586_8.x = 0
				var_586_0.localEulerAngles = var_586_8
			end

			local var_586_9 = arg_583_1.actors_["1070ui_story"]
			local var_586_10 = 0

			if var_586_10 < arg_583_1.time_ and arg_583_1.time_ <= var_586_10 + arg_586_0 and not isNil(var_586_9) and arg_583_1.var_.characterEffect1070ui_story == nil then
				arg_583_1.var_.characterEffect1070ui_story = var_586_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_586_11 = 0.200000002980232

			if var_586_10 <= arg_583_1.time_ and arg_583_1.time_ < var_586_10 + var_586_11 and not isNil(var_586_9) then
				local var_586_12 = (arg_583_1.time_ - var_586_10) / var_586_11

				if arg_583_1.var_.characterEffect1070ui_story and not isNil(var_586_9) then
					arg_583_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_583_1.time_ >= var_586_10 + var_586_11 and arg_583_1.time_ < var_586_10 + var_586_11 + arg_586_0 and not isNil(var_586_9) and arg_583_1.var_.characterEffect1070ui_story then
				arg_583_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_586_13 = 0

			if var_586_13 < arg_583_1.time_ and arg_583_1.time_ <= var_586_13 + arg_586_0 then
				arg_583_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_586_14 = 0

			if var_586_14 < arg_583_1.time_ and arg_583_1.time_ <= var_586_14 + arg_586_0 then
				arg_583_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_586_15 = 0
			local var_586_16 = 0.25

			if var_586_15 < arg_583_1.time_ and arg_583_1.time_ <= var_586_15 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				local var_586_17 = arg_583_1:FormatText(StoryNameCfg[318].name)

				arg_583_1.leftNameTxt_.text = var_586_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_18 = arg_583_1:GetWordFromCfg(222031144)
				local var_586_19 = arg_583_1:FormatText(var_586_18.content)

				arg_583_1.text_.text = var_586_19

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_20 = 10
				local var_586_21 = utf8.len(var_586_19)
				local var_586_22 = var_586_20 <= 0 and var_586_16 or var_586_16 * (var_586_21 / var_586_20)

				if var_586_22 > 0 and var_586_16 < var_586_22 then
					arg_583_1.talkMaxDuration = var_586_22

					if var_586_22 + var_586_15 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_22 + var_586_15
					end
				end

				arg_583_1.text_.text = var_586_19
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031144", "story_v_out_222031.awb") ~= 0 then
					local var_586_23 = manager.audio:GetVoiceLength("story_v_out_222031", "222031144", "story_v_out_222031.awb") / 1000

					if var_586_23 + var_586_15 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_23 + var_586_15
					end

					if var_586_18.prefab_name ~= "" and arg_583_1.actors_[var_586_18.prefab_name] ~= nil then
						local var_586_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_18.prefab_name].transform, "story_v_out_222031", "222031144", "story_v_out_222031.awb")

						arg_583_1:RecordAudio("222031144", var_586_24)
						arg_583_1:RecordAudio("222031144", var_586_24)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_out_222031", "222031144", "story_v_out_222031.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_out_222031", "222031144", "story_v_out_222031.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_25 = math.max(var_586_16, arg_583_1.talkMaxDuration)

			if var_586_15 <= arg_583_1.time_ and arg_583_1.time_ < var_586_15 + var_586_25 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_15) / var_586_25

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_15 + var_586_25 and arg_583_1.time_ < var_586_15 + var_586_25 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_583_1:InitPlayNodeList()
	end,
	Play222031145 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 222031145
		arg_587_1.duration_ = 8.97

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play222031146(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = "ST37a"

			if arg_587_1.bgs_[var_590_0] == nil then
				local var_590_1 = Object.Instantiate(arg_587_1.paintGo_)

				var_590_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_590_0)
				var_590_1.name = var_590_0
				var_590_1.transform.parent = arg_587_1.stage_.transform
				var_590_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_587_1.bgs_[var_590_0] = var_590_1
			end

			local var_590_2 = 2

			if var_590_2 < arg_587_1.time_ and arg_587_1.time_ <= var_590_2 + arg_590_0 then
				local var_590_3 = manager.ui.mainCamera.transform.localPosition
				local var_590_4 = Vector3.New(0, 0, 10) + Vector3.New(var_590_3.x, var_590_3.y, 0)
				local var_590_5 = arg_587_1.bgs_.ST37a

				var_590_5.transform.localPosition = var_590_4
				var_590_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_590_6 = var_590_5:GetComponent("SpriteRenderer")

				if var_590_6 and var_590_6.sprite then
					local var_590_7 = (var_590_5.transform.localPosition - var_590_3).z
					local var_590_8 = manager.ui.mainCameraCom_
					local var_590_9 = 2 * var_590_7 * Mathf.Tan(var_590_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_590_10 = var_590_9 * var_590_8.aspect
					local var_590_11 = var_590_6.sprite.bounds.size.x
					local var_590_12 = var_590_6.sprite.bounds.size.y
					local var_590_13 = var_590_10 / var_590_11
					local var_590_14 = var_590_9 / var_590_12
					local var_590_15 = var_590_14 < var_590_13 and var_590_13 or var_590_14

					var_590_5.transform.localScale = Vector3.New(var_590_15, var_590_15, 0)
				end

				for iter_590_0, iter_590_1 in pairs(arg_587_1.bgs_) do
					if iter_590_0 ~= "ST37a" then
						iter_590_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_590_16 = 0

			if var_590_16 < arg_587_1.time_ and arg_587_1.time_ <= var_590_16 + arg_590_0 then
				arg_587_1.mask_.enabled = true
				arg_587_1.mask_.raycastTarget = true

				arg_587_1:SetGaussion(false)
			end

			local var_590_17 = 2

			if var_590_16 <= arg_587_1.time_ and arg_587_1.time_ < var_590_16 + var_590_17 then
				local var_590_18 = (arg_587_1.time_ - var_590_16) / var_590_17
				local var_590_19 = Color.New(0, 0, 0)

				var_590_19.a = Mathf.Lerp(0, 1, var_590_18)
				arg_587_1.mask_.color = var_590_19
			end

			if arg_587_1.time_ >= var_590_16 + var_590_17 and arg_587_1.time_ < var_590_16 + var_590_17 + arg_590_0 then
				local var_590_20 = Color.New(0, 0, 0)

				var_590_20.a = 1
				arg_587_1.mask_.color = var_590_20
			end

			local var_590_21 = 2

			if var_590_21 < arg_587_1.time_ and arg_587_1.time_ <= var_590_21 + arg_590_0 then
				arg_587_1.mask_.enabled = true
				arg_587_1.mask_.raycastTarget = true

				arg_587_1:SetGaussion(false)
			end

			local var_590_22 = 2

			if var_590_21 <= arg_587_1.time_ and arg_587_1.time_ < var_590_21 + var_590_22 then
				local var_590_23 = (arg_587_1.time_ - var_590_21) / var_590_22
				local var_590_24 = Color.New(0, 0, 0)

				var_590_24.a = Mathf.Lerp(1, 0, var_590_23)
				arg_587_1.mask_.color = var_590_24
			end

			if arg_587_1.time_ >= var_590_21 + var_590_22 and arg_587_1.time_ < var_590_21 + var_590_22 + arg_590_0 then
				local var_590_25 = Color.New(0, 0, 0)
				local var_590_26 = 0

				arg_587_1.mask_.enabled = false
				var_590_25.a = var_590_26
				arg_587_1.mask_.color = var_590_25
			end

			local var_590_27 = arg_587_1.actors_["1070ui_story"].transform
			local var_590_28 = 1.96599999815226

			if var_590_28 < arg_587_1.time_ and arg_587_1.time_ <= var_590_28 + arg_590_0 then
				arg_587_1.var_.moveOldPos1070ui_story = var_590_27.localPosition
			end

			local var_590_29 = 0.001

			if var_590_28 <= arg_587_1.time_ and arg_587_1.time_ < var_590_28 + var_590_29 then
				local var_590_30 = (arg_587_1.time_ - var_590_28) / var_590_29
				local var_590_31 = Vector3.New(0, 100, 0)

				var_590_27.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPos1070ui_story, var_590_31, var_590_30)

				local var_590_32 = manager.ui.mainCamera.transform.position - var_590_27.position

				var_590_27.forward = Vector3.New(var_590_32.x, var_590_32.y, var_590_32.z)

				local var_590_33 = var_590_27.localEulerAngles

				var_590_33.z = 0
				var_590_33.x = 0
				var_590_27.localEulerAngles = var_590_33
			end

			if arg_587_1.time_ >= var_590_28 + var_590_29 and arg_587_1.time_ < var_590_28 + var_590_29 + arg_590_0 then
				var_590_27.localPosition = Vector3.New(0, 100, 0)

				local var_590_34 = manager.ui.mainCamera.transform.position - var_590_27.position

				var_590_27.forward = Vector3.New(var_590_34.x, var_590_34.y, var_590_34.z)

				local var_590_35 = var_590_27.localEulerAngles

				var_590_35.z = 0
				var_590_35.x = 0
				var_590_27.localEulerAngles = var_590_35
			end

			local var_590_36 = arg_587_1.actors_["1070ui_story"]
			local var_590_37 = 1.96599999815226

			if var_590_37 < arg_587_1.time_ and arg_587_1.time_ <= var_590_37 + arg_590_0 and not isNil(var_590_36) and arg_587_1.var_.characterEffect1070ui_story == nil then
				arg_587_1.var_.characterEffect1070ui_story = var_590_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_590_38 = 0.034000001847744

			if var_590_37 <= arg_587_1.time_ and arg_587_1.time_ < var_590_37 + var_590_38 and not isNil(var_590_36) then
				local var_590_39 = (arg_587_1.time_ - var_590_37) / var_590_38

				if arg_587_1.var_.characterEffect1070ui_story and not isNil(var_590_36) then
					local var_590_40 = Mathf.Lerp(0, 0.5, var_590_39)

					arg_587_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_587_1.var_.characterEffect1070ui_story.fillRatio = var_590_40
				end
			end

			if arg_587_1.time_ >= var_590_37 + var_590_38 and arg_587_1.time_ < var_590_37 + var_590_38 + arg_590_0 and not isNil(var_590_36) and arg_587_1.var_.characterEffect1070ui_story then
				local var_590_41 = 0.5

				arg_587_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_587_1.var_.characterEffect1070ui_story.fillRatio = var_590_41
			end

			if arg_587_1.frameCnt_ <= 1 then
				arg_587_1.dialog_:SetActive(false)
			end

			local var_590_42 = 3.96599999815226
			local var_590_43 = 0.575

			if var_590_42 < arg_587_1.time_ and arg_587_1.time_ <= var_590_42 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0

				arg_587_1.dialog_:SetActive(true)

				arg_587_1.dialogCg_.alpha = 0

				local var_590_44 = LeanTween.value(arg_587_1.dialog_, 0, 1, 0.3)

				var_590_44:setOnUpdate(LuaHelper.FloatAction(function(arg_591_0)
					arg_587_1.dialogCg_.alpha = arg_591_0
				end))
				var_590_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_587_1.dialog_)
					var_590_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_587_1.duration_ = arg_587_1.duration_ + 0.3

				SetActive(arg_587_1.leftNameGo_, false)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_45 = arg_587_1:GetWordFromCfg(222031145)
				local var_590_46 = arg_587_1:FormatText(var_590_45.content)

				arg_587_1.text_.text = var_590_46

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_47 = 23
				local var_590_48 = utf8.len(var_590_46)
				local var_590_49 = var_590_47 <= 0 and var_590_43 or var_590_43 * (var_590_48 / var_590_47)

				if var_590_49 > 0 and var_590_43 < var_590_49 then
					arg_587_1.talkMaxDuration = var_590_49
					var_590_42 = var_590_42 + 0.3

					if var_590_49 + var_590_42 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_49 + var_590_42
					end
				end

				arg_587_1.text_.text = var_590_46
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_50 = var_590_42 + 0.3
			local var_590_51 = math.max(var_590_43, arg_587_1.talkMaxDuration)

			if var_590_50 <= arg_587_1.time_ and arg_587_1.time_ < var_590_50 + var_590_51 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_50) / var_590_51

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_50 + var_590_51 and arg_587_1.time_ < var_590_50 + var_590_51 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_587_1:InitPlayNodeList()
	end,
	Play222031146 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 222031146
		arg_593_1.duration_ = 5.5

		local var_593_0 = {
			ja = 5.5,
			ko = 3.766,
			zh = 3.8
		}
		local var_593_1 = manager.audio:GetLocalizationFlag()

		if var_593_0[var_593_1] ~= nil then
			arg_593_1.duration_ = var_593_0[var_593_1]
		end

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play222031147(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = "10044ui_story"

			if arg_593_1.actors_[var_596_0] == nil then
				local var_596_1 = Asset.Load("Char/" .. "10044ui_story")

				if not isNil(var_596_1) then
					local var_596_2 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_593_1.stage_.transform)

					var_596_2.name = var_596_0
					var_596_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_593_1.actors_[var_596_0] = var_596_2

					local var_596_3 = var_596_2:GetComponentInChildren(typeof(CharacterEffect))

					var_596_3.enabled = true

					local var_596_4 = GameObjectTools.GetOrAddComponent(var_596_2, typeof(DynamicBoneHelper))

					if var_596_4 then
						var_596_4:EnableDynamicBone(false)
					end

					arg_593_1:ShowWeapon(var_596_3.transform, false)

					arg_593_1.var_[var_596_0 .. "Animator"] = var_596_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_593_1.var_[var_596_0 .. "Animator"].applyRootMotion = true
					arg_593_1.var_[var_596_0 .. "LipSync"] = var_596_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_596_5 = arg_593_1.actors_["10044ui_story"].transform
			local var_596_6 = 0

			if var_596_6 < arg_593_1.time_ and arg_593_1.time_ <= var_596_6 + arg_596_0 then
				arg_593_1.var_.moveOldPos10044ui_story = var_596_5.localPosition
			end

			local var_596_7 = 0.001

			if var_596_6 <= arg_593_1.time_ and arg_593_1.time_ < var_596_6 + var_596_7 then
				local var_596_8 = (arg_593_1.time_ - var_596_6) / var_596_7
				local var_596_9 = Vector3.New(-0.7, -0.72, -6.3)

				var_596_5.localPosition = Vector3.Lerp(arg_593_1.var_.moveOldPos10044ui_story, var_596_9, var_596_8)

				local var_596_10 = manager.ui.mainCamera.transform.position - var_596_5.position

				var_596_5.forward = Vector3.New(var_596_10.x, var_596_10.y, var_596_10.z)

				local var_596_11 = var_596_5.localEulerAngles

				var_596_11.z = 0
				var_596_11.x = 0
				var_596_5.localEulerAngles = var_596_11
			end

			if arg_593_1.time_ >= var_596_6 + var_596_7 and arg_593_1.time_ < var_596_6 + var_596_7 + arg_596_0 then
				var_596_5.localPosition = Vector3.New(-0.7, -0.72, -6.3)

				local var_596_12 = manager.ui.mainCamera.transform.position - var_596_5.position

				var_596_5.forward = Vector3.New(var_596_12.x, var_596_12.y, var_596_12.z)

				local var_596_13 = var_596_5.localEulerAngles

				var_596_13.z = 0
				var_596_13.x = 0
				var_596_5.localEulerAngles = var_596_13
			end

			local var_596_14 = arg_593_1.actors_["10044ui_story"]
			local var_596_15 = 0

			if var_596_15 < arg_593_1.time_ and arg_593_1.time_ <= var_596_15 + arg_596_0 and not isNil(var_596_14) and arg_593_1.var_.characterEffect10044ui_story == nil then
				arg_593_1.var_.characterEffect10044ui_story = var_596_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_16 = 0.200000002980232

			if var_596_15 <= arg_593_1.time_ and arg_593_1.time_ < var_596_15 + var_596_16 and not isNil(var_596_14) then
				local var_596_17 = (arg_593_1.time_ - var_596_15) / var_596_16

				if arg_593_1.var_.characterEffect10044ui_story and not isNil(var_596_14) then
					arg_593_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_593_1.time_ >= var_596_15 + var_596_16 and arg_593_1.time_ < var_596_15 + var_596_16 + arg_596_0 and not isNil(var_596_14) and arg_593_1.var_.characterEffect10044ui_story then
				arg_593_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_596_18 = 0

			if var_596_18 < arg_593_1.time_ and arg_593_1.time_ <= var_596_18 + arg_596_0 then
				arg_593_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_596_19 = 0

			if var_596_19 < arg_593_1.time_ and arg_593_1.time_ <= var_596_19 + arg_596_0 then
				arg_593_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_596_20 = arg_593_1.actors_["1074ui_story"].transform
			local var_596_21 = 0

			if var_596_21 < arg_593_1.time_ and arg_593_1.time_ <= var_596_21 + arg_596_0 then
				arg_593_1.var_.moveOldPos1074ui_story = var_596_20.localPosition
			end

			local var_596_22 = 0.001

			if var_596_21 <= arg_593_1.time_ and arg_593_1.time_ < var_596_21 + var_596_22 then
				local var_596_23 = (arg_593_1.time_ - var_596_21) / var_596_22
				local var_596_24 = Vector3.New(0.7, -1.055, -6.12)

				var_596_20.localPosition = Vector3.Lerp(arg_593_1.var_.moveOldPos1074ui_story, var_596_24, var_596_23)

				local var_596_25 = manager.ui.mainCamera.transform.position - var_596_20.position

				var_596_20.forward = Vector3.New(var_596_25.x, var_596_25.y, var_596_25.z)

				local var_596_26 = var_596_20.localEulerAngles

				var_596_26.z = 0
				var_596_26.x = 0
				var_596_20.localEulerAngles = var_596_26
			end

			if arg_593_1.time_ >= var_596_21 + var_596_22 and arg_593_1.time_ < var_596_21 + var_596_22 + arg_596_0 then
				var_596_20.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_596_27 = manager.ui.mainCamera.transform.position - var_596_20.position

				var_596_20.forward = Vector3.New(var_596_27.x, var_596_27.y, var_596_27.z)

				local var_596_28 = var_596_20.localEulerAngles

				var_596_28.z = 0
				var_596_28.x = 0
				var_596_20.localEulerAngles = var_596_28
			end

			local var_596_29 = arg_593_1.actors_["1074ui_story"]
			local var_596_30 = 0

			if var_596_30 < arg_593_1.time_ and arg_593_1.time_ <= var_596_30 + arg_596_0 and not isNil(var_596_29) and arg_593_1.var_.characterEffect1074ui_story == nil then
				arg_593_1.var_.characterEffect1074ui_story = var_596_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_31 = 0.200000002980232

			if var_596_30 <= arg_593_1.time_ and arg_593_1.time_ < var_596_30 + var_596_31 and not isNil(var_596_29) then
				local var_596_32 = (arg_593_1.time_ - var_596_30) / var_596_31

				if arg_593_1.var_.characterEffect1074ui_story and not isNil(var_596_29) then
					local var_596_33 = Mathf.Lerp(0, 0.5, var_596_32)

					arg_593_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_593_1.var_.characterEffect1074ui_story.fillRatio = var_596_33
				end
			end

			if arg_593_1.time_ >= var_596_30 + var_596_31 and arg_593_1.time_ < var_596_30 + var_596_31 + arg_596_0 and not isNil(var_596_29) and arg_593_1.var_.characterEffect1074ui_story then
				local var_596_34 = 0.5

				arg_593_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_593_1.var_.characterEffect1074ui_story.fillRatio = var_596_34
			end

			local var_596_35 = 0
			local var_596_36 = 0.275

			if var_596_35 < arg_593_1.time_ and arg_593_1.time_ <= var_596_35 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				local var_596_37 = arg_593_1:FormatText(StoryNameCfg[380].name)

				arg_593_1.leftNameTxt_.text = var_596_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_38 = arg_593_1:GetWordFromCfg(222031146)
				local var_596_39 = arg_593_1:FormatText(var_596_38.content)

				arg_593_1.text_.text = var_596_39

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_40 = 11
				local var_596_41 = utf8.len(var_596_39)
				local var_596_42 = var_596_40 <= 0 and var_596_36 or var_596_36 * (var_596_41 / var_596_40)

				if var_596_42 > 0 and var_596_36 < var_596_42 then
					arg_593_1.talkMaxDuration = var_596_42

					if var_596_42 + var_596_35 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_42 + var_596_35
					end
				end

				arg_593_1.text_.text = var_596_39
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031146", "story_v_out_222031.awb") ~= 0 then
					local var_596_43 = manager.audio:GetVoiceLength("story_v_out_222031", "222031146", "story_v_out_222031.awb") / 1000

					if var_596_43 + var_596_35 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_43 + var_596_35
					end

					if var_596_38.prefab_name ~= "" and arg_593_1.actors_[var_596_38.prefab_name] ~= nil then
						local var_596_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_38.prefab_name].transform, "story_v_out_222031", "222031146", "story_v_out_222031.awb")

						arg_593_1:RecordAudio("222031146", var_596_44)
						arg_593_1:RecordAudio("222031146", var_596_44)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_out_222031", "222031146", "story_v_out_222031.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_out_222031", "222031146", "story_v_out_222031.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_45 = math.max(var_596_36, arg_593_1.talkMaxDuration)

			if var_596_35 <= arg_593_1.time_ and arg_593_1.time_ < var_596_35 + var_596_45 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_35) / var_596_45

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_35 + var_596_45 and arg_593_1.time_ < var_596_35 + var_596_45 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_593_1:InitPlayNodeList()
	end,
	Play222031147 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 222031147
		arg_597_1.duration_ = 12.9

		local var_597_0 = {
			ja = 12.9,
			ko = 5.433,
			zh = 5.466
		}
		local var_597_1 = manager.audio:GetLocalizationFlag()

		if var_597_0[var_597_1] ~= nil then
			arg_597_1.duration_ = var_597_0[var_597_1]
		end

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play222031148(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = arg_597_1.actors_["1074ui_story"]
			local var_600_1 = 0

			if var_600_1 < arg_597_1.time_ and arg_597_1.time_ <= var_600_1 + arg_600_0 and not isNil(var_600_0) and arg_597_1.var_.characterEffect1074ui_story == nil then
				arg_597_1.var_.characterEffect1074ui_story = var_600_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_600_2 = 0.200000002980232

			if var_600_1 <= arg_597_1.time_ and arg_597_1.time_ < var_600_1 + var_600_2 and not isNil(var_600_0) then
				local var_600_3 = (arg_597_1.time_ - var_600_1) / var_600_2

				if arg_597_1.var_.characterEffect1074ui_story and not isNil(var_600_0) then
					arg_597_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_597_1.time_ >= var_600_1 + var_600_2 and arg_597_1.time_ < var_600_1 + var_600_2 + arg_600_0 and not isNil(var_600_0) and arg_597_1.var_.characterEffect1074ui_story then
				arg_597_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_600_4 = 0

			if var_600_4 < arg_597_1.time_ and arg_597_1.time_ <= var_600_4 + arg_600_0 then
				arg_597_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_600_5 = 0

			if var_600_5 < arg_597_1.time_ and arg_597_1.time_ <= var_600_5 + arg_600_0 then
				arg_597_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_600_6 = arg_597_1.actors_["10044ui_story"]
			local var_600_7 = 0

			if var_600_7 < arg_597_1.time_ and arg_597_1.time_ <= var_600_7 + arg_600_0 and not isNil(var_600_6) and arg_597_1.var_.characterEffect10044ui_story == nil then
				arg_597_1.var_.characterEffect10044ui_story = var_600_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_600_8 = 0.200000002980232

			if var_600_7 <= arg_597_1.time_ and arg_597_1.time_ < var_600_7 + var_600_8 and not isNil(var_600_6) then
				local var_600_9 = (arg_597_1.time_ - var_600_7) / var_600_8

				if arg_597_1.var_.characterEffect10044ui_story and not isNil(var_600_6) then
					local var_600_10 = Mathf.Lerp(0, 0.5, var_600_9)

					arg_597_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_597_1.var_.characterEffect10044ui_story.fillRatio = var_600_10
				end
			end

			if arg_597_1.time_ >= var_600_7 + var_600_8 and arg_597_1.time_ < var_600_7 + var_600_8 + arg_600_0 and not isNil(var_600_6) and arg_597_1.var_.characterEffect10044ui_story then
				local var_600_11 = 0.5

				arg_597_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_597_1.var_.characterEffect10044ui_story.fillRatio = var_600_11
			end

			local var_600_12 = 0
			local var_600_13 = 0.575

			if var_600_12 < arg_597_1.time_ and arg_597_1.time_ <= var_600_12 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				local var_600_14 = arg_597_1:FormatText(StoryNameCfg[410].name)

				arg_597_1.leftNameTxt_.text = var_600_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_15 = arg_597_1:GetWordFromCfg(222031147)
				local var_600_16 = arg_597_1:FormatText(var_600_15.content)

				arg_597_1.text_.text = var_600_16

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_17 = 23
				local var_600_18 = utf8.len(var_600_16)
				local var_600_19 = var_600_17 <= 0 and var_600_13 or var_600_13 * (var_600_18 / var_600_17)

				if var_600_19 > 0 and var_600_13 < var_600_19 then
					arg_597_1.talkMaxDuration = var_600_19

					if var_600_19 + var_600_12 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_19 + var_600_12
					end
				end

				arg_597_1.text_.text = var_600_16
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031147", "story_v_out_222031.awb") ~= 0 then
					local var_600_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031147", "story_v_out_222031.awb") / 1000

					if var_600_20 + var_600_12 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_20 + var_600_12
					end

					if var_600_15.prefab_name ~= "" and arg_597_1.actors_[var_600_15.prefab_name] ~= nil then
						local var_600_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_15.prefab_name].transform, "story_v_out_222031", "222031147", "story_v_out_222031.awb")

						arg_597_1:RecordAudio("222031147", var_600_21)
						arg_597_1:RecordAudio("222031147", var_600_21)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_out_222031", "222031147", "story_v_out_222031.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_out_222031", "222031147", "story_v_out_222031.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_22 = math.max(var_600_13, arg_597_1.talkMaxDuration)

			if var_600_12 <= arg_597_1.time_ and arg_597_1.time_ < var_600_12 + var_600_22 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_12) / var_600_22

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_12 + var_600_22 and arg_597_1.time_ < var_600_12 + var_600_22 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play222031148 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 222031148
		arg_601_1.duration_ = 7.3

		local var_601_0 = {
			ja = 7.3,
			ko = 2.9,
			zh = 2.9
		}
		local var_601_1 = manager.audio:GetLocalizationFlag()

		if var_601_0[var_601_1] ~= nil then
			arg_601_1.duration_ = var_601_0[var_601_1]
		end

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play222031149(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = arg_601_1.actors_["10044ui_story"]
			local var_604_1 = 0

			if var_604_1 < arg_601_1.time_ and arg_601_1.time_ <= var_604_1 + arg_604_0 and not isNil(var_604_0) and arg_601_1.var_.characterEffect10044ui_story == nil then
				arg_601_1.var_.characterEffect10044ui_story = var_604_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_604_2 = 0.200000002980232

			if var_604_1 <= arg_601_1.time_ and arg_601_1.time_ < var_604_1 + var_604_2 and not isNil(var_604_0) then
				local var_604_3 = (arg_601_1.time_ - var_604_1) / var_604_2

				if arg_601_1.var_.characterEffect10044ui_story and not isNil(var_604_0) then
					arg_601_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_601_1.time_ >= var_604_1 + var_604_2 and arg_601_1.time_ < var_604_1 + var_604_2 + arg_604_0 and not isNil(var_604_0) and arg_601_1.var_.characterEffect10044ui_story then
				arg_601_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_604_4 = 0

			if var_604_4 < arg_601_1.time_ and arg_601_1.time_ <= var_604_4 + arg_604_0 then
				arg_601_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_604_5 = 0

			if var_604_5 < arg_601_1.time_ and arg_601_1.time_ <= var_604_5 + arg_604_0 then
				arg_601_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_604_6 = arg_601_1.actors_["1074ui_story"]
			local var_604_7 = 0

			if var_604_7 < arg_601_1.time_ and arg_601_1.time_ <= var_604_7 + arg_604_0 and not isNil(var_604_6) and arg_601_1.var_.characterEffect1074ui_story == nil then
				arg_601_1.var_.characterEffect1074ui_story = var_604_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_604_8 = 0.200000002980232

			if var_604_7 <= arg_601_1.time_ and arg_601_1.time_ < var_604_7 + var_604_8 and not isNil(var_604_6) then
				local var_604_9 = (arg_601_1.time_ - var_604_7) / var_604_8

				if arg_601_1.var_.characterEffect1074ui_story and not isNil(var_604_6) then
					local var_604_10 = Mathf.Lerp(0, 0.5, var_604_9)

					arg_601_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_601_1.var_.characterEffect1074ui_story.fillRatio = var_604_10
				end
			end

			if arg_601_1.time_ >= var_604_7 + var_604_8 and arg_601_1.time_ < var_604_7 + var_604_8 + arg_604_0 and not isNil(var_604_6) and arg_601_1.var_.characterEffect1074ui_story then
				local var_604_11 = 0.5

				arg_601_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_601_1.var_.characterEffect1074ui_story.fillRatio = var_604_11
			end

			local var_604_12 = 0
			local var_604_13 = 0.375

			if var_604_12 < arg_601_1.time_ and arg_601_1.time_ <= var_604_12 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				local var_604_14 = arg_601_1:FormatText(StoryNameCfg[380].name)

				arg_601_1.leftNameTxt_.text = var_604_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_15 = arg_601_1:GetWordFromCfg(222031148)
				local var_604_16 = arg_601_1:FormatText(var_604_15.content)

				arg_601_1.text_.text = var_604_16

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_17 = 15
				local var_604_18 = utf8.len(var_604_16)
				local var_604_19 = var_604_17 <= 0 and var_604_13 or var_604_13 * (var_604_18 / var_604_17)

				if var_604_19 > 0 and var_604_13 < var_604_19 then
					arg_601_1.talkMaxDuration = var_604_19

					if var_604_19 + var_604_12 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_19 + var_604_12
					end
				end

				arg_601_1.text_.text = var_604_16
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031148", "story_v_out_222031.awb") ~= 0 then
					local var_604_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031148", "story_v_out_222031.awb") / 1000

					if var_604_20 + var_604_12 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_20 + var_604_12
					end

					if var_604_15.prefab_name ~= "" and arg_601_1.actors_[var_604_15.prefab_name] ~= nil then
						local var_604_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_601_1.actors_[var_604_15.prefab_name].transform, "story_v_out_222031", "222031148", "story_v_out_222031.awb")

						arg_601_1:RecordAudio("222031148", var_604_21)
						arg_601_1:RecordAudio("222031148", var_604_21)
					else
						arg_601_1:AudioAction("play", "voice", "story_v_out_222031", "222031148", "story_v_out_222031.awb")
					end

					arg_601_1:RecordHistoryTalkVoice("story_v_out_222031", "222031148", "story_v_out_222031.awb")
				end

				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_22 = math.max(var_604_13, arg_601_1.talkMaxDuration)

			if var_604_12 <= arg_601_1.time_ and arg_601_1.time_ < var_604_12 + var_604_22 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_12) / var_604_22

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_12 + var_604_22 and arg_601_1.time_ < var_604_12 + var_604_22 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play222031149 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 222031149
		arg_605_1.duration_ = 5

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play222031150(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = arg_605_1.actors_["10044ui_story"]
			local var_608_1 = 0

			if var_608_1 < arg_605_1.time_ and arg_605_1.time_ <= var_608_1 + arg_608_0 and not isNil(var_608_0) and arg_605_1.var_.characterEffect10044ui_story == nil then
				arg_605_1.var_.characterEffect10044ui_story = var_608_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_608_2 = 0.200000002980232

			if var_608_1 <= arg_605_1.time_ and arg_605_1.time_ < var_608_1 + var_608_2 and not isNil(var_608_0) then
				local var_608_3 = (arg_605_1.time_ - var_608_1) / var_608_2

				if arg_605_1.var_.characterEffect10044ui_story and not isNil(var_608_0) then
					local var_608_4 = Mathf.Lerp(0, 0.5, var_608_3)

					arg_605_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_605_1.var_.characterEffect10044ui_story.fillRatio = var_608_4
				end
			end

			if arg_605_1.time_ >= var_608_1 + var_608_2 and arg_605_1.time_ < var_608_1 + var_608_2 + arg_608_0 and not isNil(var_608_0) and arg_605_1.var_.characterEffect10044ui_story then
				local var_608_5 = 0.5

				arg_605_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_605_1.var_.characterEffect10044ui_story.fillRatio = var_608_5
			end

			local var_608_6 = 0
			local var_608_7 = 0.725

			if var_608_6 < arg_605_1.time_ and arg_605_1.time_ <= var_608_6 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, false)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_8 = arg_605_1:GetWordFromCfg(222031149)
				local var_608_9 = arg_605_1:FormatText(var_608_8.content)

				arg_605_1.text_.text = var_608_9

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_10 = 29
				local var_608_11 = utf8.len(var_608_9)
				local var_608_12 = var_608_10 <= 0 and var_608_7 or var_608_7 * (var_608_11 / var_608_10)

				if var_608_12 > 0 and var_608_7 < var_608_12 then
					arg_605_1.talkMaxDuration = var_608_12

					if var_608_12 + var_608_6 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_12 + var_608_6
					end
				end

				arg_605_1.text_.text = var_608_9
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)
				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_13 = math.max(var_608_7, arg_605_1.talkMaxDuration)

			if var_608_6 <= arg_605_1.time_ and arg_605_1.time_ < var_608_6 + var_608_13 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_6) / var_608_13

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_6 + var_608_13 and arg_605_1.time_ < var_608_6 + var_608_13 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play222031150 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 222031150
		arg_609_1.duration_ = 5.5

		local var_609_0 = {
			ja = 5.5,
			ko = 3.5,
			zh = 3.5
		}
		local var_609_1 = manager.audio:GetLocalizationFlag()

		if var_609_0[var_609_1] ~= nil then
			arg_609_1.duration_ = var_609_0[var_609_1]
		end

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play222031151(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = arg_609_1.actors_["1074ui_story"].transform
			local var_612_1 = 0

			if var_612_1 < arg_609_1.time_ and arg_609_1.time_ <= var_612_1 + arg_612_0 then
				arg_609_1.var_.moveOldPos1074ui_story = var_612_0.localPosition
			end

			local var_612_2 = 0.001

			if var_612_1 <= arg_609_1.time_ and arg_609_1.time_ < var_612_1 + var_612_2 then
				local var_612_3 = (arg_609_1.time_ - var_612_1) / var_612_2
				local var_612_4 = Vector3.New(0, 100, 0)

				var_612_0.localPosition = Vector3.Lerp(arg_609_1.var_.moveOldPos1074ui_story, var_612_4, var_612_3)

				local var_612_5 = manager.ui.mainCamera.transform.position - var_612_0.position

				var_612_0.forward = Vector3.New(var_612_5.x, var_612_5.y, var_612_5.z)

				local var_612_6 = var_612_0.localEulerAngles

				var_612_6.z = 0
				var_612_6.x = 0
				var_612_0.localEulerAngles = var_612_6
			end

			if arg_609_1.time_ >= var_612_1 + var_612_2 and arg_609_1.time_ < var_612_1 + var_612_2 + arg_612_0 then
				var_612_0.localPosition = Vector3.New(0, 100, 0)

				local var_612_7 = manager.ui.mainCamera.transform.position - var_612_0.position

				var_612_0.forward = Vector3.New(var_612_7.x, var_612_7.y, var_612_7.z)

				local var_612_8 = var_612_0.localEulerAngles

				var_612_8.z = 0
				var_612_8.x = 0
				var_612_0.localEulerAngles = var_612_8
			end

			local var_612_9 = arg_609_1.actors_["1074ui_story"]
			local var_612_10 = 0

			if var_612_10 < arg_609_1.time_ and arg_609_1.time_ <= var_612_10 + arg_612_0 and not isNil(var_612_9) and arg_609_1.var_.characterEffect1074ui_story == nil then
				arg_609_1.var_.characterEffect1074ui_story = var_612_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_612_11 = 0.200000002980232

			if var_612_10 <= arg_609_1.time_ and arg_609_1.time_ < var_612_10 + var_612_11 and not isNil(var_612_9) then
				local var_612_12 = (arg_609_1.time_ - var_612_10) / var_612_11

				if arg_609_1.var_.characterEffect1074ui_story and not isNil(var_612_9) then
					local var_612_13 = Mathf.Lerp(0, 0.5, var_612_12)

					arg_609_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_609_1.var_.characterEffect1074ui_story.fillRatio = var_612_13
				end
			end

			if arg_609_1.time_ >= var_612_10 + var_612_11 and arg_609_1.time_ < var_612_10 + var_612_11 + arg_612_0 and not isNil(var_612_9) and arg_609_1.var_.characterEffect1074ui_story then
				local var_612_14 = 0.5

				arg_609_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_609_1.var_.characterEffect1074ui_story.fillRatio = var_612_14
			end

			local var_612_15 = arg_609_1.actors_["1070ui_story"].transform
			local var_612_16 = 0

			if var_612_16 < arg_609_1.time_ and arg_609_1.time_ <= var_612_16 + arg_612_0 then
				arg_609_1.var_.moveOldPos1070ui_story = var_612_15.localPosition
			end

			local var_612_17 = 0.001

			if var_612_16 <= arg_609_1.time_ and arg_609_1.time_ < var_612_16 + var_612_17 then
				local var_612_18 = (arg_609_1.time_ - var_612_16) / var_612_17
				local var_612_19 = Vector3.New(0.7, -0.95, -6.05)

				var_612_15.localPosition = Vector3.Lerp(arg_609_1.var_.moveOldPos1070ui_story, var_612_19, var_612_18)

				local var_612_20 = manager.ui.mainCamera.transform.position - var_612_15.position

				var_612_15.forward = Vector3.New(var_612_20.x, var_612_20.y, var_612_20.z)

				local var_612_21 = var_612_15.localEulerAngles

				var_612_21.z = 0
				var_612_21.x = 0
				var_612_15.localEulerAngles = var_612_21
			end

			if arg_609_1.time_ >= var_612_16 + var_612_17 and arg_609_1.time_ < var_612_16 + var_612_17 + arg_612_0 then
				var_612_15.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_612_22 = manager.ui.mainCamera.transform.position - var_612_15.position

				var_612_15.forward = Vector3.New(var_612_22.x, var_612_22.y, var_612_22.z)

				local var_612_23 = var_612_15.localEulerAngles

				var_612_23.z = 0
				var_612_23.x = 0
				var_612_15.localEulerAngles = var_612_23
			end

			local var_612_24 = arg_609_1.actors_["1070ui_story"]
			local var_612_25 = 0

			if var_612_25 < arg_609_1.time_ and arg_609_1.time_ <= var_612_25 + arg_612_0 and not isNil(var_612_24) and arg_609_1.var_.characterEffect1070ui_story == nil then
				arg_609_1.var_.characterEffect1070ui_story = var_612_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_612_26 = 0.200000002980232

			if var_612_25 <= arg_609_1.time_ and arg_609_1.time_ < var_612_25 + var_612_26 and not isNil(var_612_24) then
				local var_612_27 = (arg_609_1.time_ - var_612_25) / var_612_26

				if arg_609_1.var_.characterEffect1070ui_story and not isNil(var_612_24) then
					arg_609_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_609_1.time_ >= var_612_25 + var_612_26 and arg_609_1.time_ < var_612_25 + var_612_26 + arg_612_0 and not isNil(var_612_24) and arg_609_1.var_.characterEffect1070ui_story then
				arg_609_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_612_28 = 0

			if var_612_28 < arg_609_1.time_ and arg_609_1.time_ <= var_612_28 + arg_612_0 then
				arg_609_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			local var_612_29 = 0

			if var_612_29 < arg_609_1.time_ and arg_609_1.time_ <= var_612_29 + arg_612_0 then
				arg_609_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_612_30 = 0
			local var_612_31 = 0.5

			if var_612_30 < arg_609_1.time_ and arg_609_1.time_ <= var_612_30 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				local var_612_32 = arg_609_1:FormatText(StoryNameCfg[318].name)

				arg_609_1.leftNameTxt_.text = var_612_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_33 = arg_609_1:GetWordFromCfg(222031150)
				local var_612_34 = arg_609_1:FormatText(var_612_33.content)

				arg_609_1.text_.text = var_612_34

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_35 = 20
				local var_612_36 = utf8.len(var_612_34)
				local var_612_37 = var_612_35 <= 0 and var_612_31 or var_612_31 * (var_612_36 / var_612_35)

				if var_612_37 > 0 and var_612_31 < var_612_37 then
					arg_609_1.talkMaxDuration = var_612_37

					if var_612_37 + var_612_30 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_37 + var_612_30
					end
				end

				arg_609_1.text_.text = var_612_34
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031150", "story_v_out_222031.awb") ~= 0 then
					local var_612_38 = manager.audio:GetVoiceLength("story_v_out_222031", "222031150", "story_v_out_222031.awb") / 1000

					if var_612_38 + var_612_30 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_38 + var_612_30
					end

					if var_612_33.prefab_name ~= "" and arg_609_1.actors_[var_612_33.prefab_name] ~= nil then
						local var_612_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_609_1.actors_[var_612_33.prefab_name].transform, "story_v_out_222031", "222031150", "story_v_out_222031.awb")

						arg_609_1:RecordAudio("222031150", var_612_39)
						arg_609_1:RecordAudio("222031150", var_612_39)
					else
						arg_609_1:AudioAction("play", "voice", "story_v_out_222031", "222031150", "story_v_out_222031.awb")
					end

					arg_609_1:RecordHistoryTalkVoice("story_v_out_222031", "222031150", "story_v_out_222031.awb")
				end

				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_40 = math.max(var_612_31, arg_609_1.talkMaxDuration)

			if var_612_30 <= arg_609_1.time_ and arg_609_1.time_ < var_612_30 + var_612_40 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_30) / var_612_40

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_30 + var_612_40 and arg_609_1.time_ < var_612_30 + var_612_40 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_609_1:InitPlayNodeList()
	end,
	Play222031151 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 222031151
		arg_613_1.duration_ = 9.2

		local var_613_0 = {
			ja = 9.2,
			ko = 4.666,
			zh = 4.666
		}
		local var_613_1 = manager.audio:GetLocalizationFlag()

		if var_613_0[var_613_1] ~= nil then
			arg_613_1.duration_ = var_613_0[var_613_1]
		end

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play222031152(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = 0

			if var_616_0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_0 + arg_616_0 then
				arg_613_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_2")
			end

			local var_616_1 = 0

			if var_616_1 < arg_613_1.time_ and arg_613_1.time_ <= var_616_1 + arg_616_0 then
				arg_613_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_616_2 = 0
			local var_616_3 = 0.7

			if var_616_2 < arg_613_1.time_ and arg_613_1.time_ <= var_616_2 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				local var_616_4 = arg_613_1:FormatText(StoryNameCfg[318].name)

				arg_613_1.leftNameTxt_.text = var_616_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, false)
				arg_613_1.callingController_:SetSelectedState("normal")

				local var_616_5 = arg_613_1:GetWordFromCfg(222031151)
				local var_616_6 = arg_613_1:FormatText(var_616_5.content)

				arg_613_1.text_.text = var_616_6

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_7 = 28
				local var_616_8 = utf8.len(var_616_6)
				local var_616_9 = var_616_7 <= 0 and var_616_3 or var_616_3 * (var_616_8 / var_616_7)

				if var_616_9 > 0 and var_616_3 < var_616_9 then
					arg_613_1.talkMaxDuration = var_616_9

					if var_616_9 + var_616_2 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_9 + var_616_2
					end
				end

				arg_613_1.text_.text = var_616_6
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031151", "story_v_out_222031.awb") ~= 0 then
					local var_616_10 = manager.audio:GetVoiceLength("story_v_out_222031", "222031151", "story_v_out_222031.awb") / 1000

					if var_616_10 + var_616_2 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_10 + var_616_2
					end

					if var_616_5.prefab_name ~= "" and arg_613_1.actors_[var_616_5.prefab_name] ~= nil then
						local var_616_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_613_1.actors_[var_616_5.prefab_name].transform, "story_v_out_222031", "222031151", "story_v_out_222031.awb")

						arg_613_1:RecordAudio("222031151", var_616_11)
						arg_613_1:RecordAudio("222031151", var_616_11)
					else
						arg_613_1:AudioAction("play", "voice", "story_v_out_222031", "222031151", "story_v_out_222031.awb")
					end

					arg_613_1:RecordHistoryTalkVoice("story_v_out_222031", "222031151", "story_v_out_222031.awb")
				end

				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_12 = math.max(var_616_3, arg_613_1.talkMaxDuration)

			if var_616_2 <= arg_613_1.time_ and arg_613_1.time_ < var_616_2 + var_616_12 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_2) / var_616_12

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_2 + var_616_12 and arg_613_1.time_ < var_616_2 + var_616_12 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play222031152 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 222031152
		arg_617_1.duration_ = 3.3

		local var_617_0 = {
			ja = 3.3,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_617_1 = manager.audio:GetLocalizationFlag()

		if var_617_0[var_617_1] ~= nil then
			arg_617_1.duration_ = var_617_0[var_617_1]
		end

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play222031153(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = arg_617_1.actors_["10044ui_story"]
			local var_620_1 = 0

			if var_620_1 < arg_617_1.time_ and arg_617_1.time_ <= var_620_1 + arg_620_0 and not isNil(var_620_0) and arg_617_1.var_.characterEffect10044ui_story == nil then
				arg_617_1.var_.characterEffect10044ui_story = var_620_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_620_2 = 0.200000002980232

			if var_620_1 <= arg_617_1.time_ and arg_617_1.time_ < var_620_1 + var_620_2 and not isNil(var_620_0) then
				local var_620_3 = (arg_617_1.time_ - var_620_1) / var_620_2

				if arg_617_1.var_.characterEffect10044ui_story and not isNil(var_620_0) then
					arg_617_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_617_1.time_ >= var_620_1 + var_620_2 and arg_617_1.time_ < var_620_1 + var_620_2 + arg_620_0 and not isNil(var_620_0) and arg_617_1.var_.characterEffect10044ui_story then
				arg_617_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_620_4 = 0

			if var_620_4 < arg_617_1.time_ and arg_617_1.time_ <= var_620_4 + arg_620_0 then
				arg_617_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_620_5 = 0

			if var_620_5 < arg_617_1.time_ and arg_617_1.time_ <= var_620_5 + arg_620_0 then
				arg_617_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_620_6 = arg_617_1.actors_["1070ui_story"]
			local var_620_7 = 0

			if var_620_7 < arg_617_1.time_ and arg_617_1.time_ <= var_620_7 + arg_620_0 and not isNil(var_620_6) and arg_617_1.var_.characterEffect1070ui_story == nil then
				arg_617_1.var_.characterEffect1070ui_story = var_620_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_620_8 = 0.200000002980232

			if var_620_7 <= arg_617_1.time_ and arg_617_1.time_ < var_620_7 + var_620_8 and not isNil(var_620_6) then
				local var_620_9 = (arg_617_1.time_ - var_620_7) / var_620_8

				if arg_617_1.var_.characterEffect1070ui_story and not isNil(var_620_6) then
					local var_620_10 = Mathf.Lerp(0, 0.5, var_620_9)

					arg_617_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_617_1.var_.characterEffect1070ui_story.fillRatio = var_620_10
				end
			end

			if arg_617_1.time_ >= var_620_7 + var_620_8 and arg_617_1.time_ < var_620_7 + var_620_8 + arg_620_0 and not isNil(var_620_6) and arg_617_1.var_.characterEffect1070ui_story then
				local var_620_11 = 0.5

				arg_617_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_617_1.var_.characterEffect1070ui_story.fillRatio = var_620_11
			end

			local var_620_12 = 0
			local var_620_13 = 0.125

			if var_620_12 < arg_617_1.time_ and arg_617_1.time_ <= var_620_12 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				local var_620_14 = arg_617_1:FormatText(StoryNameCfg[380].name)

				arg_617_1.leftNameTxt_.text = var_620_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_15 = arg_617_1:GetWordFromCfg(222031152)
				local var_620_16 = arg_617_1:FormatText(var_620_15.content)

				arg_617_1.text_.text = var_620_16

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_17 = 5
				local var_620_18 = utf8.len(var_620_16)
				local var_620_19 = var_620_17 <= 0 and var_620_13 or var_620_13 * (var_620_18 / var_620_17)

				if var_620_19 > 0 and var_620_13 < var_620_19 then
					arg_617_1.talkMaxDuration = var_620_19

					if var_620_19 + var_620_12 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_19 + var_620_12
					end
				end

				arg_617_1.text_.text = var_620_16
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031152", "story_v_out_222031.awb") ~= 0 then
					local var_620_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031152", "story_v_out_222031.awb") / 1000

					if var_620_20 + var_620_12 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_20 + var_620_12
					end

					if var_620_15.prefab_name ~= "" and arg_617_1.actors_[var_620_15.prefab_name] ~= nil then
						local var_620_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_15.prefab_name].transform, "story_v_out_222031", "222031152", "story_v_out_222031.awb")

						arg_617_1:RecordAudio("222031152", var_620_21)
						arg_617_1:RecordAudio("222031152", var_620_21)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_out_222031", "222031152", "story_v_out_222031.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_out_222031", "222031152", "story_v_out_222031.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_22 = math.max(var_620_13, arg_617_1.talkMaxDuration)

			if var_620_12 <= arg_617_1.time_ and arg_617_1.time_ < var_620_12 + var_620_22 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_12) / var_620_22

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_12 + var_620_22 and arg_617_1.time_ < var_620_12 + var_620_22 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play222031153 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 222031153
		arg_621_1.duration_ = 5

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play222031154(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = arg_621_1.actors_["10044ui_story"]
			local var_624_1 = 0

			if var_624_1 < arg_621_1.time_ and arg_621_1.time_ <= var_624_1 + arg_624_0 and not isNil(var_624_0) and arg_621_1.var_.characterEffect10044ui_story == nil then
				arg_621_1.var_.characterEffect10044ui_story = var_624_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_624_2 = 0.200000002980232

			if var_624_1 <= arg_621_1.time_ and arg_621_1.time_ < var_624_1 + var_624_2 and not isNil(var_624_0) then
				local var_624_3 = (arg_621_1.time_ - var_624_1) / var_624_2

				if arg_621_1.var_.characterEffect10044ui_story and not isNil(var_624_0) then
					local var_624_4 = Mathf.Lerp(0, 0.5, var_624_3)

					arg_621_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_621_1.var_.characterEffect10044ui_story.fillRatio = var_624_4
				end
			end

			if arg_621_1.time_ >= var_624_1 + var_624_2 and arg_621_1.time_ < var_624_1 + var_624_2 + arg_624_0 and not isNil(var_624_0) and arg_621_1.var_.characterEffect10044ui_story then
				local var_624_5 = 0.5

				arg_621_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_621_1.var_.characterEffect10044ui_story.fillRatio = var_624_5
			end

			local var_624_6 = 0
			local var_624_7 = 1.175

			if var_624_6 < arg_621_1.time_ and arg_621_1.time_ <= var_624_6 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, false)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_8 = arg_621_1:GetWordFromCfg(222031153)
				local var_624_9 = arg_621_1:FormatText(var_624_8.content)

				arg_621_1.text_.text = var_624_9

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_10 = 47
				local var_624_11 = utf8.len(var_624_9)
				local var_624_12 = var_624_10 <= 0 and var_624_7 or var_624_7 * (var_624_11 / var_624_10)

				if var_624_12 > 0 and var_624_7 < var_624_12 then
					arg_621_1.talkMaxDuration = var_624_12

					if var_624_12 + var_624_6 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_12 + var_624_6
					end
				end

				arg_621_1.text_.text = var_624_9
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)
				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_13 = math.max(var_624_7, arg_621_1.talkMaxDuration)

			if var_624_6 <= arg_621_1.time_ and arg_621_1.time_ < var_624_6 + var_624_13 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_6) / var_624_13

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_6 + var_624_13 and arg_621_1.time_ < var_624_6 + var_624_13 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play222031154 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 222031154
		arg_625_1.duration_ = 2.8

		local var_625_0 = {
			ja = 2.8,
			ko = 2.766,
			zh = 2.766
		}
		local var_625_1 = manager.audio:GetLocalizationFlag()

		if var_625_0[var_625_1] ~= nil then
			arg_625_1.duration_ = var_625_0[var_625_1]
		end

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play222031155(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = arg_625_1.actors_["10044ui_story"]
			local var_628_1 = 0

			if var_628_1 < arg_625_1.time_ and arg_625_1.time_ <= var_628_1 + arg_628_0 and not isNil(var_628_0) and arg_625_1.var_.characterEffect10044ui_story == nil then
				arg_625_1.var_.characterEffect10044ui_story = var_628_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_628_2 = 0.200000002980232

			if var_628_1 <= arg_625_1.time_ and arg_625_1.time_ < var_628_1 + var_628_2 and not isNil(var_628_0) then
				local var_628_3 = (arg_625_1.time_ - var_628_1) / var_628_2

				if arg_625_1.var_.characterEffect10044ui_story and not isNil(var_628_0) then
					arg_625_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_625_1.time_ >= var_628_1 + var_628_2 and arg_625_1.time_ < var_628_1 + var_628_2 + arg_628_0 and not isNil(var_628_0) and arg_625_1.var_.characterEffect10044ui_story then
				arg_625_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_628_4 = 0

			if var_628_4 < arg_625_1.time_ and arg_625_1.time_ <= var_628_4 + arg_628_0 then
				arg_625_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_628_5 = 0

			if var_628_5 < arg_625_1.time_ and arg_625_1.time_ <= var_628_5 + arg_628_0 then
				arg_625_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_628_6 = 0
			local var_628_7 = 0.2

			if var_628_6 < arg_625_1.time_ and arg_625_1.time_ <= var_628_6 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				local var_628_8 = arg_625_1:FormatText(StoryNameCfg[380].name)

				arg_625_1.leftNameTxt_.text = var_628_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_9 = arg_625_1:GetWordFromCfg(222031154)
				local var_628_10 = arg_625_1:FormatText(var_628_9.content)

				arg_625_1.text_.text = var_628_10

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_11 = 8
				local var_628_12 = utf8.len(var_628_10)
				local var_628_13 = var_628_11 <= 0 and var_628_7 or var_628_7 * (var_628_12 / var_628_11)

				if var_628_13 > 0 and var_628_7 < var_628_13 then
					arg_625_1.talkMaxDuration = var_628_13

					if var_628_13 + var_628_6 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_13 + var_628_6
					end
				end

				arg_625_1.text_.text = var_628_10
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031154", "story_v_out_222031.awb") ~= 0 then
					local var_628_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031154", "story_v_out_222031.awb") / 1000

					if var_628_14 + var_628_6 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_14 + var_628_6
					end

					if var_628_9.prefab_name ~= "" and arg_625_1.actors_[var_628_9.prefab_name] ~= nil then
						local var_628_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_625_1.actors_[var_628_9.prefab_name].transform, "story_v_out_222031", "222031154", "story_v_out_222031.awb")

						arg_625_1:RecordAudio("222031154", var_628_15)
						arg_625_1:RecordAudio("222031154", var_628_15)
					else
						arg_625_1:AudioAction("play", "voice", "story_v_out_222031", "222031154", "story_v_out_222031.awb")
					end

					arg_625_1:RecordHistoryTalkVoice("story_v_out_222031", "222031154", "story_v_out_222031.awb")
				end

				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_16 = math.max(var_628_7, arg_625_1.talkMaxDuration)

			if var_628_6 <= arg_625_1.time_ and arg_625_1.time_ < var_628_6 + var_628_16 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_6) / var_628_16

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_6 + var_628_16 and arg_625_1.time_ < var_628_6 + var_628_16 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play222031155 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 222031155
		arg_629_1.duration_ = 11.9

		local var_629_0 = {
			ja = 11.9,
			ko = 7.833,
			zh = 7.833
		}
		local var_629_1 = manager.audio:GetLocalizationFlag()

		if var_629_0[var_629_1] ~= nil then
			arg_629_1.duration_ = var_629_0[var_629_1]
		end

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play222031156(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = arg_629_1.actors_["1070ui_story"].transform
			local var_632_1 = 0

			if var_632_1 < arg_629_1.time_ and arg_629_1.time_ <= var_632_1 + arg_632_0 then
				arg_629_1.var_.moveOldPos1070ui_story = var_632_0.localPosition
			end

			local var_632_2 = 0.001

			if var_632_1 <= arg_629_1.time_ and arg_629_1.time_ < var_632_1 + var_632_2 then
				local var_632_3 = (arg_629_1.time_ - var_632_1) / var_632_2
				local var_632_4 = Vector3.New(0.7, -0.95, -6.05)

				var_632_0.localPosition = Vector3.Lerp(arg_629_1.var_.moveOldPos1070ui_story, var_632_4, var_632_3)

				local var_632_5 = manager.ui.mainCamera.transform.position - var_632_0.position

				var_632_0.forward = Vector3.New(var_632_5.x, var_632_5.y, var_632_5.z)

				local var_632_6 = var_632_0.localEulerAngles

				var_632_6.z = 0
				var_632_6.x = 0
				var_632_0.localEulerAngles = var_632_6
			end

			if arg_629_1.time_ >= var_632_1 + var_632_2 and arg_629_1.time_ < var_632_1 + var_632_2 + arg_632_0 then
				var_632_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_632_7 = manager.ui.mainCamera.transform.position - var_632_0.position

				var_632_0.forward = Vector3.New(var_632_7.x, var_632_7.y, var_632_7.z)

				local var_632_8 = var_632_0.localEulerAngles

				var_632_8.z = 0
				var_632_8.x = 0
				var_632_0.localEulerAngles = var_632_8
			end

			local var_632_9 = arg_629_1.actors_["1070ui_story"]
			local var_632_10 = 0

			if var_632_10 < arg_629_1.time_ and arg_629_1.time_ <= var_632_10 + arg_632_0 and not isNil(var_632_9) and arg_629_1.var_.characterEffect1070ui_story == nil then
				arg_629_1.var_.characterEffect1070ui_story = var_632_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_632_11 = 0.200000002980232

			if var_632_10 <= arg_629_1.time_ and arg_629_1.time_ < var_632_10 + var_632_11 and not isNil(var_632_9) then
				local var_632_12 = (arg_629_1.time_ - var_632_10) / var_632_11

				if arg_629_1.var_.characterEffect1070ui_story and not isNil(var_632_9) then
					arg_629_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_629_1.time_ >= var_632_10 + var_632_11 and arg_629_1.time_ < var_632_10 + var_632_11 + arg_632_0 and not isNil(var_632_9) and arg_629_1.var_.characterEffect1070ui_story then
				arg_629_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_632_13 = 0

			if var_632_13 < arg_629_1.time_ and arg_629_1.time_ <= var_632_13 + arg_632_0 then
				arg_629_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			local var_632_14 = 0

			if var_632_14 < arg_629_1.time_ and arg_629_1.time_ <= var_632_14 + arg_632_0 then
				arg_629_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_632_15 = arg_629_1.actors_["10044ui_story"]
			local var_632_16 = 0

			if var_632_16 < arg_629_1.time_ and arg_629_1.time_ <= var_632_16 + arg_632_0 and not isNil(var_632_15) and arg_629_1.var_.characterEffect10044ui_story == nil then
				arg_629_1.var_.characterEffect10044ui_story = var_632_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_632_17 = 0.200000002980232

			if var_632_16 <= arg_629_1.time_ and arg_629_1.time_ < var_632_16 + var_632_17 and not isNil(var_632_15) then
				local var_632_18 = (arg_629_1.time_ - var_632_16) / var_632_17

				if arg_629_1.var_.characterEffect10044ui_story and not isNil(var_632_15) then
					local var_632_19 = Mathf.Lerp(0, 0.5, var_632_18)

					arg_629_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_629_1.var_.characterEffect10044ui_story.fillRatio = var_632_19
				end
			end

			if arg_629_1.time_ >= var_632_16 + var_632_17 and arg_629_1.time_ < var_632_16 + var_632_17 + arg_632_0 and not isNil(var_632_15) and arg_629_1.var_.characterEffect10044ui_story then
				local var_632_20 = 0.5

				arg_629_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_629_1.var_.characterEffect10044ui_story.fillRatio = var_632_20
			end

			local var_632_21 = 0
			local var_632_22 = 0.825

			if var_632_21 < arg_629_1.time_ and arg_629_1.time_ <= var_632_21 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, true)

				local var_632_23 = arg_629_1:FormatText(StoryNameCfg[318].name)

				arg_629_1.leftNameTxt_.text = var_632_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_629_1.leftNameTxt_.transform)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1.leftNameTxt_.text)
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_24 = arg_629_1:GetWordFromCfg(222031155)
				local var_632_25 = arg_629_1:FormatText(var_632_24.content)

				arg_629_1.text_.text = var_632_25

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_26 = 33
				local var_632_27 = utf8.len(var_632_25)
				local var_632_28 = var_632_26 <= 0 and var_632_22 or var_632_22 * (var_632_27 / var_632_26)

				if var_632_28 > 0 and var_632_22 < var_632_28 then
					arg_629_1.talkMaxDuration = var_632_28

					if var_632_28 + var_632_21 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_28 + var_632_21
					end
				end

				arg_629_1.text_.text = var_632_25
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031155", "story_v_out_222031.awb") ~= 0 then
					local var_632_29 = manager.audio:GetVoiceLength("story_v_out_222031", "222031155", "story_v_out_222031.awb") / 1000

					if var_632_29 + var_632_21 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_29 + var_632_21
					end

					if var_632_24.prefab_name ~= "" and arg_629_1.actors_[var_632_24.prefab_name] ~= nil then
						local var_632_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_629_1.actors_[var_632_24.prefab_name].transform, "story_v_out_222031", "222031155", "story_v_out_222031.awb")

						arg_629_1:RecordAudio("222031155", var_632_30)
						arg_629_1:RecordAudio("222031155", var_632_30)
					else
						arg_629_1:AudioAction("play", "voice", "story_v_out_222031", "222031155", "story_v_out_222031.awb")
					end

					arg_629_1:RecordHistoryTalkVoice("story_v_out_222031", "222031155", "story_v_out_222031.awb")
				end

				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_31 = math.max(var_632_22, arg_629_1.talkMaxDuration)

			if var_632_21 <= arg_629_1.time_ and arg_629_1.time_ < var_632_21 + var_632_31 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_21) / var_632_31

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_21 + var_632_31 and arg_629_1.time_ < var_632_21 + var_632_31 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_629_1:InitPlayNodeList()
	end,
	Play222031156 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 222031156
		arg_633_1.duration_ = 5.7

		local var_633_0 = {
			ja = 5.7,
			ko = 4.333,
			zh = 4.333
		}
		local var_633_1 = manager.audio:GetLocalizationFlag()

		if var_633_0[var_633_1] ~= nil then
			arg_633_1.duration_ = var_633_0[var_633_1]
		end

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play222031157(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			local var_636_0 = arg_633_1.actors_["1070ui_story"].transform
			local var_636_1 = 0

			if var_636_1 < arg_633_1.time_ and arg_633_1.time_ <= var_636_1 + arg_636_0 then
				arg_633_1.var_.moveOldPos1070ui_story = var_636_0.localPosition
			end

			local var_636_2 = 0.001

			if var_636_1 <= arg_633_1.time_ and arg_633_1.time_ < var_636_1 + var_636_2 then
				local var_636_3 = (arg_633_1.time_ - var_636_1) / var_636_2
				local var_636_4 = Vector3.New(0.7, -0.95, -6.05)

				var_636_0.localPosition = Vector3.Lerp(arg_633_1.var_.moveOldPos1070ui_story, var_636_4, var_636_3)

				local var_636_5 = manager.ui.mainCamera.transform.position - var_636_0.position

				var_636_0.forward = Vector3.New(var_636_5.x, var_636_5.y, var_636_5.z)

				local var_636_6 = var_636_0.localEulerAngles

				var_636_6.z = 0
				var_636_6.x = 0
				var_636_0.localEulerAngles = var_636_6
			end

			if arg_633_1.time_ >= var_636_1 + var_636_2 and arg_633_1.time_ < var_636_1 + var_636_2 + arg_636_0 then
				var_636_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_636_7 = manager.ui.mainCamera.transform.position - var_636_0.position

				var_636_0.forward = Vector3.New(var_636_7.x, var_636_7.y, var_636_7.z)

				local var_636_8 = var_636_0.localEulerAngles

				var_636_8.z = 0
				var_636_8.x = 0
				var_636_0.localEulerAngles = var_636_8
			end

			local var_636_9 = arg_633_1.actors_["1070ui_story"]
			local var_636_10 = 0

			if var_636_10 < arg_633_1.time_ and arg_633_1.time_ <= var_636_10 + arg_636_0 and not isNil(var_636_9) and arg_633_1.var_.characterEffect1070ui_story == nil then
				arg_633_1.var_.characterEffect1070ui_story = var_636_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_636_11 = 0.200000002980232

			if var_636_10 <= arg_633_1.time_ and arg_633_1.time_ < var_636_10 + var_636_11 and not isNil(var_636_9) then
				local var_636_12 = (arg_633_1.time_ - var_636_10) / var_636_11

				if arg_633_1.var_.characterEffect1070ui_story and not isNil(var_636_9) then
					arg_633_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_633_1.time_ >= var_636_10 + var_636_11 and arg_633_1.time_ < var_636_10 + var_636_11 + arg_636_0 and not isNil(var_636_9) and arg_633_1.var_.characterEffect1070ui_story then
				arg_633_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_636_13 = 0

			if var_636_13 < arg_633_1.time_ and arg_633_1.time_ <= var_636_13 + arg_636_0 then
				arg_633_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action467")
			end

			local var_636_14 = 0

			if var_636_14 < arg_633_1.time_ and arg_633_1.time_ <= var_636_14 + arg_636_0 then
				arg_633_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_636_15 = 0
			local var_636_16 = 0.525

			if var_636_15 < arg_633_1.time_ and arg_633_1.time_ <= var_636_15 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				local var_636_17 = arg_633_1:FormatText(StoryNameCfg[318].name)

				arg_633_1.leftNameTxt_.text = var_636_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, false)
				arg_633_1.callingController_:SetSelectedState("normal")

				local var_636_18 = arg_633_1:GetWordFromCfg(222031156)
				local var_636_19 = arg_633_1:FormatText(var_636_18.content)

				arg_633_1.text_.text = var_636_19

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_20 = 21
				local var_636_21 = utf8.len(var_636_19)
				local var_636_22 = var_636_20 <= 0 and var_636_16 or var_636_16 * (var_636_21 / var_636_20)

				if var_636_22 > 0 and var_636_16 < var_636_22 then
					arg_633_1.talkMaxDuration = var_636_22

					if var_636_22 + var_636_15 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_22 + var_636_15
					end
				end

				arg_633_1.text_.text = var_636_19
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031156", "story_v_out_222031.awb") ~= 0 then
					local var_636_23 = manager.audio:GetVoiceLength("story_v_out_222031", "222031156", "story_v_out_222031.awb") / 1000

					if var_636_23 + var_636_15 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_23 + var_636_15
					end

					if var_636_18.prefab_name ~= "" and arg_633_1.actors_[var_636_18.prefab_name] ~= nil then
						local var_636_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_633_1.actors_[var_636_18.prefab_name].transform, "story_v_out_222031", "222031156", "story_v_out_222031.awb")

						arg_633_1:RecordAudio("222031156", var_636_24)
						arg_633_1:RecordAudio("222031156", var_636_24)
					else
						arg_633_1:AudioAction("play", "voice", "story_v_out_222031", "222031156", "story_v_out_222031.awb")
					end

					arg_633_1:RecordHistoryTalkVoice("story_v_out_222031", "222031156", "story_v_out_222031.awb")
				end

				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_25 = math.max(var_636_16, arg_633_1.talkMaxDuration)

			if var_636_15 <= arg_633_1.time_ and arg_633_1.time_ < var_636_15 + var_636_25 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_15) / var_636_25

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_15 + var_636_25 and arg_633_1.time_ < var_636_15 + var_636_25 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_633_1:InitPlayNodeList()
	end,
	Play222031157 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 222031157
		arg_637_1.duration_ = 9.33

		local var_637_0 = {
			ja = 9.333,
			ko = 4.133,
			zh = 4.133
		}
		local var_637_1 = manager.audio:GetLocalizationFlag()

		if var_637_0[var_637_1] ~= nil then
			arg_637_1.duration_ = var_637_0[var_637_1]
		end

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play222031158(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = arg_637_1.actors_["1070ui_story"].transform
			local var_640_1 = 0

			if var_640_1 < arg_637_1.time_ and arg_637_1.time_ <= var_640_1 + arg_640_0 then
				arg_637_1.var_.moveOldPos1070ui_story = var_640_0.localPosition
			end

			local var_640_2 = 0.001

			if var_640_1 <= arg_637_1.time_ and arg_637_1.time_ < var_640_1 + var_640_2 then
				local var_640_3 = (arg_637_1.time_ - var_640_1) / var_640_2
				local var_640_4 = Vector3.New(0, 100, 0)

				var_640_0.localPosition = Vector3.Lerp(arg_637_1.var_.moveOldPos1070ui_story, var_640_4, var_640_3)

				local var_640_5 = manager.ui.mainCamera.transform.position - var_640_0.position

				var_640_0.forward = Vector3.New(var_640_5.x, var_640_5.y, var_640_5.z)

				local var_640_6 = var_640_0.localEulerAngles

				var_640_6.z = 0
				var_640_6.x = 0
				var_640_0.localEulerAngles = var_640_6
			end

			if arg_637_1.time_ >= var_640_1 + var_640_2 and arg_637_1.time_ < var_640_1 + var_640_2 + arg_640_0 then
				var_640_0.localPosition = Vector3.New(0, 100, 0)

				local var_640_7 = manager.ui.mainCamera.transform.position - var_640_0.position

				var_640_0.forward = Vector3.New(var_640_7.x, var_640_7.y, var_640_7.z)

				local var_640_8 = var_640_0.localEulerAngles

				var_640_8.z = 0
				var_640_8.x = 0
				var_640_0.localEulerAngles = var_640_8
			end

			local var_640_9 = arg_637_1.actors_["1070ui_story"]
			local var_640_10 = 0

			if var_640_10 < arg_637_1.time_ and arg_637_1.time_ <= var_640_10 + arg_640_0 and not isNil(var_640_9) and arg_637_1.var_.characterEffect1070ui_story == nil then
				arg_637_1.var_.characterEffect1070ui_story = var_640_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_640_11 = 0.200000002980232

			if var_640_10 <= arg_637_1.time_ and arg_637_1.time_ < var_640_10 + var_640_11 and not isNil(var_640_9) then
				local var_640_12 = (arg_637_1.time_ - var_640_10) / var_640_11

				if arg_637_1.var_.characterEffect1070ui_story and not isNil(var_640_9) then
					local var_640_13 = Mathf.Lerp(0, 0.5, var_640_12)

					arg_637_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_637_1.var_.characterEffect1070ui_story.fillRatio = var_640_13
				end
			end

			if arg_637_1.time_ >= var_640_10 + var_640_11 and arg_637_1.time_ < var_640_10 + var_640_11 + arg_640_0 and not isNil(var_640_9) and arg_637_1.var_.characterEffect1070ui_story then
				local var_640_14 = 0.5

				arg_637_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_637_1.var_.characterEffect1070ui_story.fillRatio = var_640_14
			end

			local var_640_15 = arg_637_1.actors_["1074ui_story"].transform
			local var_640_16 = 0

			if var_640_16 < arg_637_1.time_ and arg_637_1.time_ <= var_640_16 + arg_640_0 then
				arg_637_1.var_.moveOldPos1074ui_story = var_640_15.localPosition
			end

			local var_640_17 = 0.001

			if var_640_16 <= arg_637_1.time_ and arg_637_1.time_ < var_640_16 + var_640_17 then
				local var_640_18 = (arg_637_1.time_ - var_640_16) / var_640_17
				local var_640_19 = Vector3.New(0.7, -1.055, -6.12)

				var_640_15.localPosition = Vector3.Lerp(arg_637_1.var_.moveOldPos1074ui_story, var_640_19, var_640_18)

				local var_640_20 = manager.ui.mainCamera.transform.position - var_640_15.position

				var_640_15.forward = Vector3.New(var_640_20.x, var_640_20.y, var_640_20.z)

				local var_640_21 = var_640_15.localEulerAngles

				var_640_21.z = 0
				var_640_21.x = 0
				var_640_15.localEulerAngles = var_640_21
			end

			if arg_637_1.time_ >= var_640_16 + var_640_17 and arg_637_1.time_ < var_640_16 + var_640_17 + arg_640_0 then
				var_640_15.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_640_22 = manager.ui.mainCamera.transform.position - var_640_15.position

				var_640_15.forward = Vector3.New(var_640_22.x, var_640_22.y, var_640_22.z)

				local var_640_23 = var_640_15.localEulerAngles

				var_640_23.z = 0
				var_640_23.x = 0
				var_640_15.localEulerAngles = var_640_23
			end

			local var_640_24 = arg_637_1.actors_["1074ui_story"]
			local var_640_25 = 0

			if var_640_25 < arg_637_1.time_ and arg_637_1.time_ <= var_640_25 + arg_640_0 and not isNil(var_640_24) and arg_637_1.var_.characterEffect1074ui_story == nil then
				arg_637_1.var_.characterEffect1074ui_story = var_640_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_640_26 = 0.200000002980232

			if var_640_25 <= arg_637_1.time_ and arg_637_1.time_ < var_640_25 + var_640_26 and not isNil(var_640_24) then
				local var_640_27 = (arg_637_1.time_ - var_640_25) / var_640_26

				if arg_637_1.var_.characterEffect1074ui_story and not isNil(var_640_24) then
					arg_637_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_637_1.time_ >= var_640_25 + var_640_26 and arg_637_1.time_ < var_640_25 + var_640_26 + arg_640_0 and not isNil(var_640_24) and arg_637_1.var_.characterEffect1074ui_story then
				arg_637_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_640_28 = 0

			if var_640_28 < arg_637_1.time_ and arg_637_1.time_ <= var_640_28 + arg_640_0 then
				arg_637_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_640_29 = 0

			if var_640_29 < arg_637_1.time_ and arg_637_1.time_ <= var_640_29 + arg_640_0 then
				arg_637_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_640_30 = 0
			local var_640_31 = 0.525

			if var_640_30 < arg_637_1.time_ and arg_637_1.time_ <= var_640_30 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				local var_640_32 = arg_637_1:FormatText(StoryNameCfg[410].name)

				arg_637_1.leftNameTxt_.text = var_640_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, false)
				arg_637_1.callingController_:SetSelectedState("normal")

				local var_640_33 = arg_637_1:GetWordFromCfg(222031157)
				local var_640_34 = arg_637_1:FormatText(var_640_33.content)

				arg_637_1.text_.text = var_640_34

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_35 = 21
				local var_640_36 = utf8.len(var_640_34)
				local var_640_37 = var_640_35 <= 0 and var_640_31 or var_640_31 * (var_640_36 / var_640_35)

				if var_640_37 > 0 and var_640_31 < var_640_37 then
					arg_637_1.talkMaxDuration = var_640_37

					if var_640_37 + var_640_30 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_37 + var_640_30
					end
				end

				arg_637_1.text_.text = var_640_34
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031157", "story_v_out_222031.awb") ~= 0 then
					local var_640_38 = manager.audio:GetVoiceLength("story_v_out_222031", "222031157", "story_v_out_222031.awb") / 1000

					if var_640_38 + var_640_30 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_38 + var_640_30
					end

					if var_640_33.prefab_name ~= "" and arg_637_1.actors_[var_640_33.prefab_name] ~= nil then
						local var_640_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_637_1.actors_[var_640_33.prefab_name].transform, "story_v_out_222031", "222031157", "story_v_out_222031.awb")

						arg_637_1:RecordAudio("222031157", var_640_39)
						arg_637_1:RecordAudio("222031157", var_640_39)
					else
						arg_637_1:AudioAction("play", "voice", "story_v_out_222031", "222031157", "story_v_out_222031.awb")
					end

					arg_637_1:RecordHistoryTalkVoice("story_v_out_222031", "222031157", "story_v_out_222031.awb")
				end

				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_40 = math.max(var_640_31, arg_637_1.talkMaxDuration)

			if var_640_30 <= arg_637_1.time_ and arg_637_1.time_ < var_640_30 + var_640_40 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_30) / var_640_40

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_30 + var_640_40 and arg_637_1.time_ < var_640_30 + var_640_40 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_637_1:InitPlayNodeList()
	end,
	Play222031158 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 222031158
		arg_641_1.duration_ = 4.1

		local var_641_0 = {
			ja = 3.3,
			ko = 4.1,
			zh = 4.1
		}
		local var_641_1 = manager.audio:GetLocalizationFlag()

		if var_641_0[var_641_1] ~= nil then
			arg_641_1.duration_ = var_641_0[var_641_1]
		end

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play222031159(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = arg_641_1.actors_["10044ui_story"].transform
			local var_644_1 = 0

			if var_644_1 < arg_641_1.time_ and arg_641_1.time_ <= var_644_1 + arg_644_0 then
				arg_641_1.var_.moveOldPos10044ui_story = var_644_0.localPosition
			end

			local var_644_2 = 0.001

			if var_644_1 <= arg_641_1.time_ and arg_641_1.time_ < var_644_1 + var_644_2 then
				local var_644_3 = (arg_641_1.time_ - var_644_1) / var_644_2
				local var_644_4 = Vector3.New(-0.7, -0.72, -6.3)

				var_644_0.localPosition = Vector3.Lerp(arg_641_1.var_.moveOldPos10044ui_story, var_644_4, var_644_3)

				local var_644_5 = manager.ui.mainCamera.transform.position - var_644_0.position

				var_644_0.forward = Vector3.New(var_644_5.x, var_644_5.y, var_644_5.z)

				local var_644_6 = var_644_0.localEulerAngles

				var_644_6.z = 0
				var_644_6.x = 0
				var_644_0.localEulerAngles = var_644_6
			end

			if arg_641_1.time_ >= var_644_1 + var_644_2 and arg_641_1.time_ < var_644_1 + var_644_2 + arg_644_0 then
				var_644_0.localPosition = Vector3.New(-0.7, -0.72, -6.3)

				local var_644_7 = manager.ui.mainCamera.transform.position - var_644_0.position

				var_644_0.forward = Vector3.New(var_644_7.x, var_644_7.y, var_644_7.z)

				local var_644_8 = var_644_0.localEulerAngles

				var_644_8.z = 0
				var_644_8.x = 0
				var_644_0.localEulerAngles = var_644_8
			end

			local var_644_9 = arg_641_1.actors_["10044ui_story"]
			local var_644_10 = 0

			if var_644_10 < arg_641_1.time_ and arg_641_1.time_ <= var_644_10 + arg_644_0 and not isNil(var_644_9) and arg_641_1.var_.characterEffect10044ui_story == nil then
				arg_641_1.var_.characterEffect10044ui_story = var_644_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_644_11 = 0.200000002980232

			if var_644_10 <= arg_641_1.time_ and arg_641_1.time_ < var_644_10 + var_644_11 and not isNil(var_644_9) then
				local var_644_12 = (arg_641_1.time_ - var_644_10) / var_644_11

				if arg_641_1.var_.characterEffect10044ui_story and not isNil(var_644_9) then
					arg_641_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_641_1.time_ >= var_644_10 + var_644_11 and arg_641_1.time_ < var_644_10 + var_644_11 + arg_644_0 and not isNil(var_644_9) and arg_641_1.var_.characterEffect10044ui_story then
				arg_641_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_644_13 = 0

			if var_644_13 < arg_641_1.time_ and arg_641_1.time_ <= var_644_13 + arg_644_0 then
				arg_641_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_2")
			end

			local var_644_14 = 0

			if var_644_14 < arg_641_1.time_ and arg_641_1.time_ <= var_644_14 + arg_644_0 then
				arg_641_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_644_15 = arg_641_1.actors_["1074ui_story"]
			local var_644_16 = 0

			if var_644_16 < arg_641_1.time_ and arg_641_1.time_ <= var_644_16 + arg_644_0 and not isNil(var_644_15) and arg_641_1.var_.characterEffect1074ui_story == nil then
				arg_641_1.var_.characterEffect1074ui_story = var_644_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_644_17 = 0.200000002980232

			if var_644_16 <= arg_641_1.time_ and arg_641_1.time_ < var_644_16 + var_644_17 and not isNil(var_644_15) then
				local var_644_18 = (arg_641_1.time_ - var_644_16) / var_644_17

				if arg_641_1.var_.characterEffect1074ui_story and not isNil(var_644_15) then
					local var_644_19 = Mathf.Lerp(0, 0.5, var_644_18)

					arg_641_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_641_1.var_.characterEffect1074ui_story.fillRatio = var_644_19
				end
			end

			if arg_641_1.time_ >= var_644_16 + var_644_17 and arg_641_1.time_ < var_644_16 + var_644_17 + arg_644_0 and not isNil(var_644_15) and arg_641_1.var_.characterEffect1074ui_story then
				local var_644_20 = 0.5

				arg_641_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_641_1.var_.characterEffect1074ui_story.fillRatio = var_644_20
			end

			local var_644_21 = 0
			local var_644_22 = 0.325

			if var_644_21 < arg_641_1.time_ and arg_641_1.time_ <= var_644_21 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				local var_644_23 = arg_641_1:FormatText(StoryNameCfg[380].name)

				arg_641_1.leftNameTxt_.text = var_644_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_24 = arg_641_1:GetWordFromCfg(222031158)
				local var_644_25 = arg_641_1:FormatText(var_644_24.content)

				arg_641_1.text_.text = var_644_25

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_26 = 13
				local var_644_27 = utf8.len(var_644_25)
				local var_644_28 = var_644_26 <= 0 and var_644_22 or var_644_22 * (var_644_27 / var_644_26)

				if var_644_28 > 0 and var_644_22 < var_644_28 then
					arg_641_1.talkMaxDuration = var_644_28

					if var_644_28 + var_644_21 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_28 + var_644_21
					end
				end

				arg_641_1.text_.text = var_644_25
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031158", "story_v_out_222031.awb") ~= 0 then
					local var_644_29 = manager.audio:GetVoiceLength("story_v_out_222031", "222031158", "story_v_out_222031.awb") / 1000

					if var_644_29 + var_644_21 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_29 + var_644_21
					end

					if var_644_24.prefab_name ~= "" and arg_641_1.actors_[var_644_24.prefab_name] ~= nil then
						local var_644_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_24.prefab_name].transform, "story_v_out_222031", "222031158", "story_v_out_222031.awb")

						arg_641_1:RecordAudio("222031158", var_644_30)
						arg_641_1:RecordAudio("222031158", var_644_30)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_out_222031", "222031158", "story_v_out_222031.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_out_222031", "222031158", "story_v_out_222031.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_31 = math.max(var_644_22, arg_641_1.talkMaxDuration)

			if var_644_21 <= arg_641_1.time_ and arg_641_1.time_ < var_644_21 + var_644_31 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_21) / var_644_31

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_21 + var_644_31 and arg_641_1.time_ < var_644_21 + var_644_31 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_641_1:InitPlayNodeList()
	end,
	Play222031159 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 222031159
		arg_645_1.duration_ = 4.23

		local var_645_0 = {
			ja = 3.866,
			ko = 4.233,
			zh = 4.233
		}
		local var_645_1 = manager.audio:GetLocalizationFlag()

		if var_645_0[var_645_1] ~= nil then
			arg_645_1.duration_ = var_645_0[var_645_1]
		end

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play222031160(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = arg_645_1.actors_["10044ui_story"].transform
			local var_648_1 = 0

			if var_648_1 < arg_645_1.time_ and arg_645_1.time_ <= var_648_1 + arg_648_0 then
				arg_645_1.var_.moveOldPos10044ui_story = var_648_0.localPosition
			end

			local var_648_2 = 0.001

			if var_648_1 <= arg_645_1.time_ and arg_645_1.time_ < var_648_1 + var_648_2 then
				local var_648_3 = (arg_645_1.time_ - var_648_1) / var_648_2
				local var_648_4 = Vector3.New(0, 100, 0)

				var_648_0.localPosition = Vector3.Lerp(arg_645_1.var_.moveOldPos10044ui_story, var_648_4, var_648_3)

				local var_648_5 = manager.ui.mainCamera.transform.position - var_648_0.position

				var_648_0.forward = Vector3.New(var_648_5.x, var_648_5.y, var_648_5.z)

				local var_648_6 = var_648_0.localEulerAngles

				var_648_6.z = 0
				var_648_6.x = 0
				var_648_0.localEulerAngles = var_648_6
			end

			if arg_645_1.time_ >= var_648_1 + var_648_2 and arg_645_1.time_ < var_648_1 + var_648_2 + arg_648_0 then
				var_648_0.localPosition = Vector3.New(0, 100, 0)

				local var_648_7 = manager.ui.mainCamera.transform.position - var_648_0.position

				var_648_0.forward = Vector3.New(var_648_7.x, var_648_7.y, var_648_7.z)

				local var_648_8 = var_648_0.localEulerAngles

				var_648_8.z = 0
				var_648_8.x = 0
				var_648_0.localEulerAngles = var_648_8
			end

			local var_648_9 = arg_645_1.actors_["10044ui_story"]
			local var_648_10 = 0

			if var_648_10 < arg_645_1.time_ and arg_645_1.time_ <= var_648_10 + arg_648_0 and not isNil(var_648_9) and arg_645_1.var_.characterEffect10044ui_story == nil then
				arg_645_1.var_.characterEffect10044ui_story = var_648_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_648_11 = 0.200000002980232

			if var_648_10 <= arg_645_1.time_ and arg_645_1.time_ < var_648_10 + var_648_11 and not isNil(var_648_9) then
				local var_648_12 = (arg_645_1.time_ - var_648_10) / var_648_11

				if arg_645_1.var_.characterEffect10044ui_story and not isNil(var_648_9) then
					local var_648_13 = Mathf.Lerp(0, 0.5, var_648_12)

					arg_645_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_645_1.var_.characterEffect10044ui_story.fillRatio = var_648_13
				end
			end

			if arg_645_1.time_ >= var_648_10 + var_648_11 and arg_645_1.time_ < var_648_10 + var_648_11 + arg_648_0 and not isNil(var_648_9) and arg_645_1.var_.characterEffect10044ui_story then
				local var_648_14 = 0.5

				arg_645_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_645_1.var_.characterEffect10044ui_story.fillRatio = var_648_14
			end

			local var_648_15 = arg_645_1.actors_["1070ui_story"].transform
			local var_648_16 = 0

			if var_648_16 < arg_645_1.time_ and arg_645_1.time_ <= var_648_16 + arg_648_0 then
				arg_645_1.var_.moveOldPos1070ui_story = var_648_15.localPosition
			end

			local var_648_17 = 0.001

			if var_648_16 <= arg_645_1.time_ and arg_645_1.time_ < var_648_16 + var_648_17 then
				local var_648_18 = (arg_645_1.time_ - var_648_16) / var_648_17
				local var_648_19 = Vector3.New(-0.7, -0.95, -6.05)

				var_648_15.localPosition = Vector3.Lerp(arg_645_1.var_.moveOldPos1070ui_story, var_648_19, var_648_18)

				local var_648_20 = manager.ui.mainCamera.transform.position - var_648_15.position

				var_648_15.forward = Vector3.New(var_648_20.x, var_648_20.y, var_648_20.z)

				local var_648_21 = var_648_15.localEulerAngles

				var_648_21.z = 0
				var_648_21.x = 0
				var_648_15.localEulerAngles = var_648_21
			end

			if arg_645_1.time_ >= var_648_16 + var_648_17 and arg_645_1.time_ < var_648_16 + var_648_17 + arg_648_0 then
				var_648_15.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_648_22 = manager.ui.mainCamera.transform.position - var_648_15.position

				var_648_15.forward = Vector3.New(var_648_22.x, var_648_22.y, var_648_22.z)

				local var_648_23 = var_648_15.localEulerAngles

				var_648_23.z = 0
				var_648_23.x = 0
				var_648_15.localEulerAngles = var_648_23
			end

			local var_648_24 = arg_645_1.actors_["1070ui_story"]
			local var_648_25 = 0

			if var_648_25 < arg_645_1.time_ and arg_645_1.time_ <= var_648_25 + arg_648_0 and not isNil(var_648_24) and arg_645_1.var_.characterEffect1070ui_story == nil then
				arg_645_1.var_.characterEffect1070ui_story = var_648_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_648_26 = 0.200000002980232

			if var_648_25 <= arg_645_1.time_ and arg_645_1.time_ < var_648_25 + var_648_26 and not isNil(var_648_24) then
				local var_648_27 = (arg_645_1.time_ - var_648_25) / var_648_26

				if arg_645_1.var_.characterEffect1070ui_story and not isNil(var_648_24) then
					arg_645_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_645_1.time_ >= var_648_25 + var_648_26 and arg_645_1.time_ < var_648_25 + var_648_26 + arg_648_0 and not isNil(var_648_24) and arg_645_1.var_.characterEffect1070ui_story then
				arg_645_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_648_28 = 0

			if var_648_28 < arg_645_1.time_ and arg_645_1.time_ <= var_648_28 + arg_648_0 then
				arg_645_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_648_29 = 0

			if var_648_29 < arg_645_1.time_ and arg_645_1.time_ <= var_648_29 + arg_648_0 then
				arg_645_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_648_30 = 0
			local var_648_31 = 0.5

			if var_648_30 < arg_645_1.time_ and arg_645_1.time_ <= var_648_30 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				local var_648_32 = arg_645_1:FormatText(StoryNameCfg[318].name)

				arg_645_1.leftNameTxt_.text = var_648_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_33 = arg_645_1:GetWordFromCfg(222031159)
				local var_648_34 = arg_645_1:FormatText(var_648_33.content)

				arg_645_1.text_.text = var_648_34

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_35 = 20
				local var_648_36 = utf8.len(var_648_34)
				local var_648_37 = var_648_35 <= 0 and var_648_31 or var_648_31 * (var_648_36 / var_648_35)

				if var_648_37 > 0 and var_648_31 < var_648_37 then
					arg_645_1.talkMaxDuration = var_648_37

					if var_648_37 + var_648_30 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_37 + var_648_30
					end
				end

				arg_645_1.text_.text = var_648_34
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031159", "story_v_out_222031.awb") ~= 0 then
					local var_648_38 = manager.audio:GetVoiceLength("story_v_out_222031", "222031159", "story_v_out_222031.awb") / 1000

					if var_648_38 + var_648_30 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_38 + var_648_30
					end

					if var_648_33.prefab_name ~= "" and arg_645_1.actors_[var_648_33.prefab_name] ~= nil then
						local var_648_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_645_1.actors_[var_648_33.prefab_name].transform, "story_v_out_222031", "222031159", "story_v_out_222031.awb")

						arg_645_1:RecordAudio("222031159", var_648_39)
						arg_645_1:RecordAudio("222031159", var_648_39)
					else
						arg_645_1:AudioAction("play", "voice", "story_v_out_222031", "222031159", "story_v_out_222031.awb")
					end

					arg_645_1:RecordHistoryTalkVoice("story_v_out_222031", "222031159", "story_v_out_222031.awb")
				end

				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_40 = math.max(var_648_31, arg_645_1.talkMaxDuration)

			if var_648_30 <= arg_645_1.time_ and arg_645_1.time_ < var_648_30 + var_648_40 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_30) / var_648_40

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_30 + var_648_40 and arg_645_1.time_ < var_648_30 + var_648_40 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_645_1:InitPlayNodeList()
	end,
	Play222031160 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 222031160
		arg_649_1.duration_ = 5.3

		local var_649_0 = {
			ja = 5.3,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_649_1 = manager.audio:GetLocalizationFlag()

		if var_649_0[var_649_1] ~= nil then
			arg_649_1.duration_ = var_649_0[var_649_1]
		end

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play222031161(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = arg_649_1.actors_["1074ui_story"]
			local var_652_1 = 0

			if var_652_1 < arg_649_1.time_ and arg_649_1.time_ <= var_652_1 + arg_652_0 and not isNil(var_652_0) and arg_649_1.var_.characterEffect1074ui_story == nil then
				arg_649_1.var_.characterEffect1074ui_story = var_652_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_652_2 = 0.200000002980232

			if var_652_1 <= arg_649_1.time_ and arg_649_1.time_ < var_652_1 + var_652_2 and not isNil(var_652_0) then
				local var_652_3 = (arg_649_1.time_ - var_652_1) / var_652_2

				if arg_649_1.var_.characterEffect1074ui_story and not isNil(var_652_0) then
					arg_649_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_649_1.time_ >= var_652_1 + var_652_2 and arg_649_1.time_ < var_652_1 + var_652_2 + arg_652_0 and not isNil(var_652_0) and arg_649_1.var_.characterEffect1074ui_story then
				arg_649_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_652_4 = 0

			if var_652_4 < arg_649_1.time_ and arg_649_1.time_ <= var_652_4 + arg_652_0 then
				arg_649_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_1")
			end

			local var_652_5 = 0

			if var_652_5 < arg_649_1.time_ and arg_649_1.time_ <= var_652_5 + arg_652_0 then
				arg_649_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_652_6 = arg_649_1.actors_["1070ui_story"]
			local var_652_7 = 0

			if var_652_7 < arg_649_1.time_ and arg_649_1.time_ <= var_652_7 + arg_652_0 and not isNil(var_652_6) and arg_649_1.var_.characterEffect1070ui_story == nil then
				arg_649_1.var_.characterEffect1070ui_story = var_652_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_652_8 = 0.200000002980232

			if var_652_7 <= arg_649_1.time_ and arg_649_1.time_ < var_652_7 + var_652_8 and not isNil(var_652_6) then
				local var_652_9 = (arg_649_1.time_ - var_652_7) / var_652_8

				if arg_649_1.var_.characterEffect1070ui_story and not isNil(var_652_6) then
					local var_652_10 = Mathf.Lerp(0, 0.5, var_652_9)

					arg_649_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_649_1.var_.characterEffect1070ui_story.fillRatio = var_652_10
				end
			end

			if arg_649_1.time_ >= var_652_7 + var_652_8 and arg_649_1.time_ < var_652_7 + var_652_8 + arg_652_0 and not isNil(var_652_6) and arg_649_1.var_.characterEffect1070ui_story then
				local var_652_11 = 0.5

				arg_649_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_649_1.var_.characterEffect1070ui_story.fillRatio = var_652_11
			end

			local var_652_12 = 0
			local var_652_13 = 0.225

			if var_652_12 < arg_649_1.time_ and arg_649_1.time_ <= var_652_12 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				local var_652_14 = arg_649_1:FormatText(StoryNameCfg[410].name)

				arg_649_1.leftNameTxt_.text = var_652_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_15 = arg_649_1:GetWordFromCfg(222031160)
				local var_652_16 = arg_649_1:FormatText(var_652_15.content)

				arg_649_1.text_.text = var_652_16

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_17 = 9
				local var_652_18 = utf8.len(var_652_16)
				local var_652_19 = var_652_17 <= 0 and var_652_13 or var_652_13 * (var_652_18 / var_652_17)

				if var_652_19 > 0 and var_652_13 < var_652_19 then
					arg_649_1.talkMaxDuration = var_652_19

					if var_652_19 + var_652_12 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_19 + var_652_12
					end
				end

				arg_649_1.text_.text = var_652_16
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031160", "story_v_out_222031.awb") ~= 0 then
					local var_652_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031160", "story_v_out_222031.awb") / 1000

					if var_652_20 + var_652_12 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_20 + var_652_12
					end

					if var_652_15.prefab_name ~= "" and arg_649_1.actors_[var_652_15.prefab_name] ~= nil then
						local var_652_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_649_1.actors_[var_652_15.prefab_name].transform, "story_v_out_222031", "222031160", "story_v_out_222031.awb")

						arg_649_1:RecordAudio("222031160", var_652_21)
						arg_649_1:RecordAudio("222031160", var_652_21)
					else
						arg_649_1:AudioAction("play", "voice", "story_v_out_222031", "222031160", "story_v_out_222031.awb")
					end

					arg_649_1:RecordHistoryTalkVoice("story_v_out_222031", "222031160", "story_v_out_222031.awb")
				end

				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_22 = math.max(var_652_13, arg_649_1.talkMaxDuration)

			if var_652_12 <= arg_649_1.time_ and arg_649_1.time_ < var_652_12 + var_652_22 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_12) / var_652_22

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_12 + var_652_22 and arg_649_1.time_ < var_652_12 + var_652_22 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play222031161 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 222031161
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play222031162(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = arg_653_1.actors_["1074ui_story"]
			local var_656_1 = 0

			if var_656_1 < arg_653_1.time_ and arg_653_1.time_ <= var_656_1 + arg_656_0 and not isNil(var_656_0) and arg_653_1.var_.characterEffect1074ui_story == nil then
				arg_653_1.var_.characterEffect1074ui_story = var_656_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_656_2 = 0.200000002980232

			if var_656_1 <= arg_653_1.time_ and arg_653_1.time_ < var_656_1 + var_656_2 and not isNil(var_656_0) then
				local var_656_3 = (arg_653_1.time_ - var_656_1) / var_656_2

				if arg_653_1.var_.characterEffect1074ui_story and not isNil(var_656_0) then
					local var_656_4 = Mathf.Lerp(0, 0.5, var_656_3)

					arg_653_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_653_1.var_.characterEffect1074ui_story.fillRatio = var_656_4
				end
			end

			if arg_653_1.time_ >= var_656_1 + var_656_2 and arg_653_1.time_ < var_656_1 + var_656_2 + arg_656_0 and not isNil(var_656_0) and arg_653_1.var_.characterEffect1074ui_story then
				local var_656_5 = 0.5

				arg_653_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_653_1.var_.characterEffect1074ui_story.fillRatio = var_656_5
			end

			local var_656_6 = 0
			local var_656_7 = 0.525

			if var_656_6 < arg_653_1.time_ and arg_653_1.time_ <= var_656_6 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, false)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_8 = arg_653_1:GetWordFromCfg(222031161)
				local var_656_9 = arg_653_1:FormatText(var_656_8.content)

				arg_653_1.text_.text = var_656_9

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_10 = 21
				local var_656_11 = utf8.len(var_656_9)
				local var_656_12 = var_656_10 <= 0 and var_656_7 or var_656_7 * (var_656_11 / var_656_10)

				if var_656_12 > 0 and var_656_7 < var_656_12 then
					arg_653_1.talkMaxDuration = var_656_12

					if var_656_12 + var_656_6 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_12 + var_656_6
					end
				end

				arg_653_1.text_.text = var_656_9
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_13 = math.max(var_656_7, arg_653_1.talkMaxDuration)

			if var_656_6 <= arg_653_1.time_ and arg_653_1.time_ < var_656_6 + var_656_13 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_6) / var_656_13

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_6 + var_656_13 and arg_653_1.time_ < var_656_6 + var_656_13 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play222031162 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 222031162
		arg_657_1.duration_ = 2

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play222031163(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = arg_657_1.actors_["1074ui_story"]
			local var_660_1 = 0

			if var_660_1 < arg_657_1.time_ and arg_657_1.time_ <= var_660_1 + arg_660_0 and not isNil(var_660_0) and arg_657_1.var_.characterEffect1074ui_story == nil then
				arg_657_1.var_.characterEffect1074ui_story = var_660_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_2 = 0.200000002980232

			if var_660_1 <= arg_657_1.time_ and arg_657_1.time_ < var_660_1 + var_660_2 and not isNil(var_660_0) then
				local var_660_3 = (arg_657_1.time_ - var_660_1) / var_660_2

				if arg_657_1.var_.characterEffect1074ui_story and not isNil(var_660_0) then
					arg_657_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_657_1.time_ >= var_660_1 + var_660_2 and arg_657_1.time_ < var_660_1 + var_660_2 + arg_660_0 and not isNil(var_660_0) and arg_657_1.var_.characterEffect1074ui_story then
				arg_657_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_660_4 = 0

			if var_660_4 < arg_657_1.time_ and arg_657_1.time_ <= var_660_4 + arg_660_0 then
				arg_657_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_2")
			end

			local var_660_5 = 0

			if var_660_5 < arg_657_1.time_ and arg_657_1.time_ <= var_660_5 + arg_660_0 then
				arg_657_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_660_6 = 0
			local var_660_7 = 0.2

			if var_660_6 < arg_657_1.time_ and arg_657_1.time_ <= var_660_6 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				local var_660_8 = arg_657_1:FormatText(StoryNameCfg[410].name)

				arg_657_1.leftNameTxt_.text = var_660_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_9 = arg_657_1:GetWordFromCfg(222031162)
				local var_660_10 = arg_657_1:FormatText(var_660_9.content)

				arg_657_1.text_.text = var_660_10

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_11 = 8
				local var_660_12 = utf8.len(var_660_10)
				local var_660_13 = var_660_11 <= 0 and var_660_7 or var_660_7 * (var_660_12 / var_660_11)

				if var_660_13 > 0 and var_660_7 < var_660_13 then
					arg_657_1.talkMaxDuration = var_660_13

					if var_660_13 + var_660_6 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_13 + var_660_6
					end
				end

				arg_657_1.text_.text = var_660_10
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031162", "story_v_out_222031.awb") ~= 0 then
					local var_660_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031162", "story_v_out_222031.awb") / 1000

					if var_660_14 + var_660_6 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_14 + var_660_6
					end

					if var_660_9.prefab_name ~= "" and arg_657_1.actors_[var_660_9.prefab_name] ~= nil then
						local var_660_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_9.prefab_name].transform, "story_v_out_222031", "222031162", "story_v_out_222031.awb")

						arg_657_1:RecordAudio("222031162", var_660_15)
						arg_657_1:RecordAudio("222031162", var_660_15)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_out_222031", "222031162", "story_v_out_222031.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_out_222031", "222031162", "story_v_out_222031.awb")
				end

				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_16 = math.max(var_660_7, arg_657_1.talkMaxDuration)

			if var_660_6 <= arg_657_1.time_ and arg_657_1.time_ < var_660_6 + var_660_16 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_6) / var_660_16

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_6 + var_660_16 and arg_657_1.time_ < var_660_6 + var_660_16 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play222031163 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 222031163
		arg_661_1.duration_ = 11.5

		local var_661_0 = {
			ja = 11.5,
			ko = 7,
			zh = 7
		}
		local var_661_1 = manager.audio:GetLocalizationFlag()

		if var_661_0[var_661_1] ~= nil then
			arg_661_1.duration_ = var_661_0[var_661_1]
		end

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play222031164(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			local var_664_0 = arg_661_1.actors_["1070ui_story"].transform
			local var_664_1 = 0

			if var_664_1 < arg_661_1.time_ and arg_661_1.time_ <= var_664_1 + arg_664_0 then
				arg_661_1.var_.moveOldPos1070ui_story = var_664_0.localPosition
			end

			local var_664_2 = 0.001

			if var_664_1 <= arg_661_1.time_ and arg_661_1.time_ < var_664_1 + var_664_2 then
				local var_664_3 = (arg_661_1.time_ - var_664_1) / var_664_2
				local var_664_4 = Vector3.New(0, 100, 0)

				var_664_0.localPosition = Vector3.Lerp(arg_661_1.var_.moveOldPos1070ui_story, var_664_4, var_664_3)

				local var_664_5 = manager.ui.mainCamera.transform.position - var_664_0.position

				var_664_0.forward = Vector3.New(var_664_5.x, var_664_5.y, var_664_5.z)

				local var_664_6 = var_664_0.localEulerAngles

				var_664_6.z = 0
				var_664_6.x = 0
				var_664_0.localEulerAngles = var_664_6
			end

			if arg_661_1.time_ >= var_664_1 + var_664_2 and arg_661_1.time_ < var_664_1 + var_664_2 + arg_664_0 then
				var_664_0.localPosition = Vector3.New(0, 100, 0)

				local var_664_7 = manager.ui.mainCamera.transform.position - var_664_0.position

				var_664_0.forward = Vector3.New(var_664_7.x, var_664_7.y, var_664_7.z)

				local var_664_8 = var_664_0.localEulerAngles

				var_664_8.z = 0
				var_664_8.x = 0
				var_664_0.localEulerAngles = var_664_8
			end

			local var_664_9 = arg_661_1.actors_["1070ui_story"]
			local var_664_10 = 0

			if var_664_10 < arg_661_1.time_ and arg_661_1.time_ <= var_664_10 + arg_664_0 and not isNil(var_664_9) and arg_661_1.var_.characterEffect1070ui_story == nil then
				arg_661_1.var_.characterEffect1070ui_story = var_664_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_664_11 = 0.200000002980232

			if var_664_10 <= arg_661_1.time_ and arg_661_1.time_ < var_664_10 + var_664_11 and not isNil(var_664_9) then
				local var_664_12 = (arg_661_1.time_ - var_664_10) / var_664_11

				if arg_661_1.var_.characterEffect1070ui_story and not isNil(var_664_9) then
					local var_664_13 = Mathf.Lerp(0, 0.5, var_664_12)

					arg_661_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_661_1.var_.characterEffect1070ui_story.fillRatio = var_664_13
				end
			end

			if arg_661_1.time_ >= var_664_10 + var_664_11 and arg_661_1.time_ < var_664_10 + var_664_11 + arg_664_0 and not isNil(var_664_9) and arg_661_1.var_.characterEffect1070ui_story then
				local var_664_14 = 0.5

				arg_661_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_661_1.var_.characterEffect1070ui_story.fillRatio = var_664_14
			end

			local var_664_15 = arg_661_1.actors_["10044ui_story"].transform
			local var_664_16 = 0

			if var_664_16 < arg_661_1.time_ and arg_661_1.time_ <= var_664_16 + arg_664_0 then
				arg_661_1.var_.moveOldPos10044ui_story = var_664_15.localPosition
			end

			local var_664_17 = 0.001

			if var_664_16 <= arg_661_1.time_ and arg_661_1.time_ < var_664_16 + var_664_17 then
				local var_664_18 = (arg_661_1.time_ - var_664_16) / var_664_17
				local var_664_19 = Vector3.New(-0.7, -0.72, -6.3)

				var_664_15.localPosition = Vector3.Lerp(arg_661_1.var_.moveOldPos10044ui_story, var_664_19, var_664_18)

				local var_664_20 = manager.ui.mainCamera.transform.position - var_664_15.position

				var_664_15.forward = Vector3.New(var_664_20.x, var_664_20.y, var_664_20.z)

				local var_664_21 = var_664_15.localEulerAngles

				var_664_21.z = 0
				var_664_21.x = 0
				var_664_15.localEulerAngles = var_664_21
			end

			if arg_661_1.time_ >= var_664_16 + var_664_17 and arg_661_1.time_ < var_664_16 + var_664_17 + arg_664_0 then
				var_664_15.localPosition = Vector3.New(-0.7, -0.72, -6.3)

				local var_664_22 = manager.ui.mainCamera.transform.position - var_664_15.position

				var_664_15.forward = Vector3.New(var_664_22.x, var_664_22.y, var_664_22.z)

				local var_664_23 = var_664_15.localEulerAngles

				var_664_23.z = 0
				var_664_23.x = 0
				var_664_15.localEulerAngles = var_664_23
			end

			local var_664_24 = arg_661_1.actors_["10044ui_story"]
			local var_664_25 = 0

			if var_664_25 < arg_661_1.time_ and arg_661_1.time_ <= var_664_25 + arg_664_0 and not isNil(var_664_24) and arg_661_1.var_.characterEffect10044ui_story == nil then
				arg_661_1.var_.characterEffect10044ui_story = var_664_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_664_26 = 0.200000002980232

			if var_664_25 <= arg_661_1.time_ and arg_661_1.time_ < var_664_25 + var_664_26 and not isNil(var_664_24) then
				local var_664_27 = (arg_661_1.time_ - var_664_25) / var_664_26

				if arg_661_1.var_.characterEffect10044ui_story and not isNil(var_664_24) then
					arg_661_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_661_1.time_ >= var_664_25 + var_664_26 and arg_661_1.time_ < var_664_25 + var_664_26 + arg_664_0 and not isNil(var_664_24) and arg_661_1.var_.characterEffect10044ui_story then
				arg_661_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_664_28 = 0

			if var_664_28 < arg_661_1.time_ and arg_661_1.time_ <= var_664_28 + arg_664_0 then
				arg_661_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_664_29 = 0

			if var_664_29 < arg_661_1.time_ and arg_661_1.time_ <= var_664_29 + arg_664_0 then
				arg_661_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_664_30 = arg_661_1.actors_["1074ui_story"]
			local var_664_31 = 0

			if var_664_31 < arg_661_1.time_ and arg_661_1.time_ <= var_664_31 + arg_664_0 and not isNil(var_664_30) and arg_661_1.var_.characterEffect1074ui_story == nil then
				arg_661_1.var_.characterEffect1074ui_story = var_664_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_664_32 = 0.200000002980232

			if var_664_31 <= arg_661_1.time_ and arg_661_1.time_ < var_664_31 + var_664_32 and not isNil(var_664_30) then
				local var_664_33 = (arg_661_1.time_ - var_664_31) / var_664_32

				if arg_661_1.var_.characterEffect1074ui_story and not isNil(var_664_30) then
					local var_664_34 = Mathf.Lerp(0, 0.5, var_664_33)

					arg_661_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_661_1.var_.characterEffect1074ui_story.fillRatio = var_664_34
				end
			end

			if arg_661_1.time_ >= var_664_31 + var_664_32 and arg_661_1.time_ < var_664_31 + var_664_32 + arg_664_0 and not isNil(var_664_30) and arg_661_1.var_.characterEffect1074ui_story then
				local var_664_35 = 0.5

				arg_661_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_661_1.var_.characterEffect1074ui_story.fillRatio = var_664_35
			end

			local var_664_36 = 0
			local var_664_37 = 0.55

			if var_664_36 < arg_661_1.time_ and arg_661_1.time_ <= var_664_36 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				local var_664_38 = arg_661_1:FormatText(StoryNameCfg[380].name)

				arg_661_1.leftNameTxt_.text = var_664_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, false)
				arg_661_1.callingController_:SetSelectedState("normal")

				local var_664_39 = arg_661_1:GetWordFromCfg(222031163)
				local var_664_40 = arg_661_1:FormatText(var_664_39.content)

				arg_661_1.text_.text = var_664_40

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_41 = 22
				local var_664_42 = utf8.len(var_664_40)
				local var_664_43 = var_664_41 <= 0 and var_664_37 or var_664_37 * (var_664_42 / var_664_41)

				if var_664_43 > 0 and var_664_37 < var_664_43 then
					arg_661_1.talkMaxDuration = var_664_43

					if var_664_43 + var_664_36 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_43 + var_664_36
					end
				end

				arg_661_1.text_.text = var_664_40
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031163", "story_v_out_222031.awb") ~= 0 then
					local var_664_44 = manager.audio:GetVoiceLength("story_v_out_222031", "222031163", "story_v_out_222031.awb") / 1000

					if var_664_44 + var_664_36 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_44 + var_664_36
					end

					if var_664_39.prefab_name ~= "" and arg_661_1.actors_[var_664_39.prefab_name] ~= nil then
						local var_664_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_661_1.actors_[var_664_39.prefab_name].transform, "story_v_out_222031", "222031163", "story_v_out_222031.awb")

						arg_661_1:RecordAudio("222031163", var_664_45)
						arg_661_1:RecordAudio("222031163", var_664_45)
					else
						arg_661_1:AudioAction("play", "voice", "story_v_out_222031", "222031163", "story_v_out_222031.awb")
					end

					arg_661_1:RecordHistoryTalkVoice("story_v_out_222031", "222031163", "story_v_out_222031.awb")
				end

				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_46 = math.max(var_664_37, arg_661_1.talkMaxDuration)

			if var_664_36 <= arg_661_1.time_ and arg_661_1.time_ < var_664_36 + var_664_46 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_36) / var_664_46

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_36 + var_664_46 and arg_661_1.time_ < var_664_36 + var_664_46 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_661_1:InitPlayNodeList()
	end,
	Play222031164 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 222031164
		arg_665_1.duration_ = 2

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play222031165(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			local var_668_0 = arg_665_1.actors_["1074ui_story"]
			local var_668_1 = 0

			if var_668_1 < arg_665_1.time_ and arg_665_1.time_ <= var_668_1 + arg_668_0 and not isNil(var_668_0) and arg_665_1.var_.characterEffect1074ui_story == nil then
				arg_665_1.var_.characterEffect1074ui_story = var_668_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_668_2 = 0.200000002980232

			if var_668_1 <= arg_665_1.time_ and arg_665_1.time_ < var_668_1 + var_668_2 and not isNil(var_668_0) then
				local var_668_3 = (arg_665_1.time_ - var_668_1) / var_668_2

				if arg_665_1.var_.characterEffect1074ui_story and not isNil(var_668_0) then
					arg_665_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_665_1.time_ >= var_668_1 + var_668_2 and arg_665_1.time_ < var_668_1 + var_668_2 + arg_668_0 and not isNil(var_668_0) and arg_665_1.var_.characterEffect1074ui_story then
				arg_665_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_668_4 = 0

			if var_668_4 < arg_665_1.time_ and arg_665_1.time_ <= var_668_4 + arg_668_0 then
				arg_665_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_668_5 = 0

			if var_668_5 < arg_665_1.time_ and arg_665_1.time_ <= var_668_5 + arg_668_0 then
				arg_665_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_668_6 = arg_665_1.actors_["10044ui_story"]
			local var_668_7 = 0

			if var_668_7 < arg_665_1.time_ and arg_665_1.time_ <= var_668_7 + arg_668_0 and not isNil(var_668_6) and arg_665_1.var_.characterEffect10044ui_story == nil then
				arg_665_1.var_.characterEffect10044ui_story = var_668_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_668_8 = 0.200000002980232

			if var_668_7 <= arg_665_1.time_ and arg_665_1.time_ < var_668_7 + var_668_8 and not isNil(var_668_6) then
				local var_668_9 = (arg_665_1.time_ - var_668_7) / var_668_8

				if arg_665_1.var_.characterEffect10044ui_story and not isNil(var_668_6) then
					local var_668_10 = Mathf.Lerp(0, 0.5, var_668_9)

					arg_665_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_665_1.var_.characterEffect10044ui_story.fillRatio = var_668_10
				end
			end

			if arg_665_1.time_ >= var_668_7 + var_668_8 and arg_665_1.time_ < var_668_7 + var_668_8 + arg_668_0 and not isNil(var_668_6) and arg_665_1.var_.characterEffect10044ui_story then
				local var_668_11 = 0.5

				arg_665_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_665_1.var_.characterEffect10044ui_story.fillRatio = var_668_11
			end

			local var_668_12 = 0
			local var_668_13 = 0.075

			if var_668_12 < arg_665_1.time_ and arg_665_1.time_ <= var_668_12 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, true)

				local var_668_14 = arg_665_1:FormatText(StoryNameCfg[410].name)

				arg_665_1.leftNameTxt_.text = var_668_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_665_1.leftNameTxt_.transform)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1.leftNameTxt_.text)
				SetActive(arg_665_1.iconTrs_.gameObject, false)
				arg_665_1.callingController_:SetSelectedState("normal")

				local var_668_15 = arg_665_1:GetWordFromCfg(222031164)
				local var_668_16 = arg_665_1:FormatText(var_668_15.content)

				arg_665_1.text_.text = var_668_16

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_17 = 3
				local var_668_18 = utf8.len(var_668_16)
				local var_668_19 = var_668_17 <= 0 and var_668_13 or var_668_13 * (var_668_18 / var_668_17)

				if var_668_19 > 0 and var_668_13 < var_668_19 then
					arg_665_1.talkMaxDuration = var_668_19

					if var_668_19 + var_668_12 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_19 + var_668_12
					end
				end

				arg_665_1.text_.text = var_668_16
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031164", "story_v_out_222031.awb") ~= 0 then
					local var_668_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031164", "story_v_out_222031.awb") / 1000

					if var_668_20 + var_668_12 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_20 + var_668_12
					end

					if var_668_15.prefab_name ~= "" and arg_665_1.actors_[var_668_15.prefab_name] ~= nil then
						local var_668_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_665_1.actors_[var_668_15.prefab_name].transform, "story_v_out_222031", "222031164", "story_v_out_222031.awb")

						arg_665_1:RecordAudio("222031164", var_668_21)
						arg_665_1:RecordAudio("222031164", var_668_21)
					else
						arg_665_1:AudioAction("play", "voice", "story_v_out_222031", "222031164", "story_v_out_222031.awb")
					end

					arg_665_1:RecordHistoryTalkVoice("story_v_out_222031", "222031164", "story_v_out_222031.awb")
				end

				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_22 = math.max(var_668_13, arg_665_1.talkMaxDuration)

			if var_668_12 <= arg_665_1.time_ and arg_665_1.time_ < var_668_12 + var_668_22 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_12) / var_668_22

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_12 + var_668_22 and arg_665_1.time_ < var_668_12 + var_668_22 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	Play222031165 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 222031165
		arg_669_1.duration_ = 14.33

		local var_669_0 = {
			ja = 14.333,
			ko = 9.5,
			zh = 9.5
		}
		local var_669_1 = manager.audio:GetLocalizationFlag()

		if var_669_0[var_669_1] ~= nil then
			arg_669_1.duration_ = var_669_0[var_669_1]
		end

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play222031166(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			local var_672_0 = arg_669_1.actors_["10044ui_story"]
			local var_672_1 = 0

			if var_672_1 < arg_669_1.time_ and arg_669_1.time_ <= var_672_1 + arg_672_0 and not isNil(var_672_0) and arg_669_1.var_.characterEffect10044ui_story == nil then
				arg_669_1.var_.characterEffect10044ui_story = var_672_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_672_2 = 0.200000002980232

			if var_672_1 <= arg_669_1.time_ and arg_669_1.time_ < var_672_1 + var_672_2 and not isNil(var_672_0) then
				local var_672_3 = (arg_669_1.time_ - var_672_1) / var_672_2

				if arg_669_1.var_.characterEffect10044ui_story and not isNil(var_672_0) then
					arg_669_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_669_1.time_ >= var_672_1 + var_672_2 and arg_669_1.time_ < var_672_1 + var_672_2 + arg_672_0 and not isNil(var_672_0) and arg_669_1.var_.characterEffect10044ui_story then
				arg_669_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_672_4 = 0

			if var_672_4 < arg_669_1.time_ and arg_669_1.time_ <= var_672_4 + arg_672_0 then
				arg_669_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_672_5 = 0

			if var_672_5 < arg_669_1.time_ and arg_669_1.time_ <= var_672_5 + arg_672_0 then
				arg_669_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_672_6 = arg_669_1.actors_["1074ui_story"]
			local var_672_7 = 0

			if var_672_7 < arg_669_1.time_ and arg_669_1.time_ <= var_672_7 + arg_672_0 and not isNil(var_672_6) and arg_669_1.var_.characterEffect1074ui_story == nil then
				arg_669_1.var_.characterEffect1074ui_story = var_672_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_672_8 = 0.200000002980232

			if var_672_7 <= arg_669_1.time_ and arg_669_1.time_ < var_672_7 + var_672_8 and not isNil(var_672_6) then
				local var_672_9 = (arg_669_1.time_ - var_672_7) / var_672_8

				if arg_669_1.var_.characterEffect1074ui_story and not isNil(var_672_6) then
					local var_672_10 = Mathf.Lerp(0, 0.5, var_672_9)

					arg_669_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_669_1.var_.characterEffect1074ui_story.fillRatio = var_672_10
				end
			end

			if arg_669_1.time_ >= var_672_7 + var_672_8 and arg_669_1.time_ < var_672_7 + var_672_8 + arg_672_0 and not isNil(var_672_6) and arg_669_1.var_.characterEffect1074ui_story then
				local var_672_11 = 0.5

				arg_669_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_669_1.var_.characterEffect1074ui_story.fillRatio = var_672_11
			end

			local var_672_12 = 0
			local var_672_13 = 1.075

			if var_672_12 < arg_669_1.time_ and arg_669_1.time_ <= var_672_12 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				local var_672_14 = arg_669_1:FormatText(StoryNameCfg[380].name)

				arg_669_1.leftNameTxt_.text = var_672_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, false)
				arg_669_1.callingController_:SetSelectedState("normal")

				local var_672_15 = arg_669_1:GetWordFromCfg(222031165)
				local var_672_16 = arg_669_1:FormatText(var_672_15.content)

				arg_669_1.text_.text = var_672_16

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_17 = 43
				local var_672_18 = utf8.len(var_672_16)
				local var_672_19 = var_672_17 <= 0 and var_672_13 or var_672_13 * (var_672_18 / var_672_17)

				if var_672_19 > 0 and var_672_13 < var_672_19 then
					arg_669_1.talkMaxDuration = var_672_19

					if var_672_19 + var_672_12 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_19 + var_672_12
					end
				end

				arg_669_1.text_.text = var_672_16
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031165", "story_v_out_222031.awb") ~= 0 then
					local var_672_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031165", "story_v_out_222031.awb") / 1000

					if var_672_20 + var_672_12 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_20 + var_672_12
					end

					if var_672_15.prefab_name ~= "" and arg_669_1.actors_[var_672_15.prefab_name] ~= nil then
						local var_672_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_669_1.actors_[var_672_15.prefab_name].transform, "story_v_out_222031", "222031165", "story_v_out_222031.awb")

						arg_669_1:RecordAudio("222031165", var_672_21)
						arg_669_1:RecordAudio("222031165", var_672_21)
					else
						arg_669_1:AudioAction("play", "voice", "story_v_out_222031", "222031165", "story_v_out_222031.awb")
					end

					arg_669_1:RecordHistoryTalkVoice("story_v_out_222031", "222031165", "story_v_out_222031.awb")
				end

				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_22 = math.max(var_672_13, arg_669_1.talkMaxDuration)

			if var_672_12 <= arg_669_1.time_ and arg_669_1.time_ < var_672_12 + var_672_22 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_12) / var_672_22

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_12 + var_672_22 and arg_669_1.time_ < var_672_12 + var_672_22 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play222031166 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 222031166
		arg_673_1.duration_ = 10.2

		local var_673_0 = {
			ja = 10.2,
			ko = 6.633,
			zh = 6.633
		}
		local var_673_1 = manager.audio:GetLocalizationFlag()

		if var_673_0[var_673_1] ~= nil then
			arg_673_1.duration_ = var_673_0[var_673_1]
		end

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play222031167(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			local var_676_0 = arg_673_1.actors_["1074ui_story"]
			local var_676_1 = 0

			if var_676_1 < arg_673_1.time_ and arg_673_1.time_ <= var_676_1 + arg_676_0 and not isNil(var_676_0) and arg_673_1.var_.characterEffect1074ui_story == nil then
				arg_673_1.var_.characterEffect1074ui_story = var_676_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_676_2 = 0.200000002980232

			if var_676_1 <= arg_673_1.time_ and arg_673_1.time_ < var_676_1 + var_676_2 and not isNil(var_676_0) then
				local var_676_3 = (arg_673_1.time_ - var_676_1) / var_676_2

				if arg_673_1.var_.characterEffect1074ui_story and not isNil(var_676_0) then
					arg_673_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_673_1.time_ >= var_676_1 + var_676_2 and arg_673_1.time_ < var_676_1 + var_676_2 + arg_676_0 and not isNil(var_676_0) and arg_673_1.var_.characterEffect1074ui_story then
				arg_673_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_676_4 = 0

			if var_676_4 < arg_673_1.time_ and arg_673_1.time_ <= var_676_4 + arg_676_0 then
				arg_673_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_676_5 = 0

			if var_676_5 < arg_673_1.time_ and arg_673_1.time_ <= var_676_5 + arg_676_0 then
				arg_673_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_676_6 = arg_673_1.actors_["10044ui_story"]
			local var_676_7 = 0

			if var_676_7 < arg_673_1.time_ and arg_673_1.time_ <= var_676_7 + arg_676_0 and not isNil(var_676_6) and arg_673_1.var_.characterEffect10044ui_story == nil then
				arg_673_1.var_.characterEffect10044ui_story = var_676_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_676_8 = 0.200000002980232

			if var_676_7 <= arg_673_1.time_ and arg_673_1.time_ < var_676_7 + var_676_8 and not isNil(var_676_6) then
				local var_676_9 = (arg_673_1.time_ - var_676_7) / var_676_8

				if arg_673_1.var_.characterEffect10044ui_story and not isNil(var_676_6) then
					local var_676_10 = Mathf.Lerp(0, 0.5, var_676_9)

					arg_673_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_673_1.var_.characterEffect10044ui_story.fillRatio = var_676_10
				end
			end

			if arg_673_1.time_ >= var_676_7 + var_676_8 and arg_673_1.time_ < var_676_7 + var_676_8 + arg_676_0 and not isNil(var_676_6) and arg_673_1.var_.characterEffect10044ui_story then
				local var_676_11 = 0.5

				arg_673_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_673_1.var_.characterEffect10044ui_story.fillRatio = var_676_11
			end

			local var_676_12 = 0
			local var_676_13 = 0.85

			if var_676_12 < arg_673_1.time_ and arg_673_1.time_ <= var_676_12 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, true)

				local var_676_14 = arg_673_1:FormatText(StoryNameCfg[410].name)

				arg_673_1.leftNameTxt_.text = var_676_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_673_1.leftNameTxt_.transform)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1.leftNameTxt_.text)
				SetActive(arg_673_1.iconTrs_.gameObject, false)
				arg_673_1.callingController_:SetSelectedState("normal")

				local var_676_15 = arg_673_1:GetWordFromCfg(222031166)
				local var_676_16 = arg_673_1:FormatText(var_676_15.content)

				arg_673_1.text_.text = var_676_16

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_17 = 34
				local var_676_18 = utf8.len(var_676_16)
				local var_676_19 = var_676_17 <= 0 and var_676_13 or var_676_13 * (var_676_18 / var_676_17)

				if var_676_19 > 0 and var_676_13 < var_676_19 then
					arg_673_1.talkMaxDuration = var_676_19

					if var_676_19 + var_676_12 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_19 + var_676_12
					end
				end

				arg_673_1.text_.text = var_676_16
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031166", "story_v_out_222031.awb") ~= 0 then
					local var_676_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031166", "story_v_out_222031.awb") / 1000

					if var_676_20 + var_676_12 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_20 + var_676_12
					end

					if var_676_15.prefab_name ~= "" and arg_673_1.actors_[var_676_15.prefab_name] ~= nil then
						local var_676_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_673_1.actors_[var_676_15.prefab_name].transform, "story_v_out_222031", "222031166", "story_v_out_222031.awb")

						arg_673_1:RecordAudio("222031166", var_676_21)
						arg_673_1:RecordAudio("222031166", var_676_21)
					else
						arg_673_1:AudioAction("play", "voice", "story_v_out_222031", "222031166", "story_v_out_222031.awb")
					end

					arg_673_1:RecordHistoryTalkVoice("story_v_out_222031", "222031166", "story_v_out_222031.awb")
				end

				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_22 = math.max(var_676_13, arg_673_1.talkMaxDuration)

			if var_676_12 <= arg_673_1.time_ and arg_673_1.time_ < var_676_12 + var_676_22 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_12) / var_676_22

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_12 + var_676_22 and arg_673_1.time_ < var_676_12 + var_676_22 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {}

		arg_673_1:InitPlayNodeList()
	end,
	Play222031167 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 222031167
		arg_677_1.duration_ = 15.73

		local var_677_0 = {
			ja = 15.733,
			ko = 11.266,
			zh = 11.266
		}
		local var_677_1 = manager.audio:GetLocalizationFlag()

		if var_677_0[var_677_1] ~= nil then
			arg_677_1.duration_ = var_677_0[var_677_1]
		end

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play222031168(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			local var_680_0 = arg_677_1.actors_["10044ui_story"]
			local var_680_1 = 0

			if var_680_1 < arg_677_1.time_ and arg_677_1.time_ <= var_680_1 + arg_680_0 and not isNil(var_680_0) and arg_677_1.var_.characterEffect10044ui_story == nil then
				arg_677_1.var_.characterEffect10044ui_story = var_680_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_680_2 = 0.200000002980232

			if var_680_1 <= arg_677_1.time_ and arg_677_1.time_ < var_680_1 + var_680_2 and not isNil(var_680_0) then
				local var_680_3 = (arg_677_1.time_ - var_680_1) / var_680_2

				if arg_677_1.var_.characterEffect10044ui_story and not isNil(var_680_0) then
					arg_677_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_677_1.time_ >= var_680_1 + var_680_2 and arg_677_1.time_ < var_680_1 + var_680_2 + arg_680_0 and not isNil(var_680_0) and arg_677_1.var_.characterEffect10044ui_story then
				arg_677_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_680_4 = 0

			if var_680_4 < arg_677_1.time_ and arg_677_1.time_ <= var_680_4 + arg_680_0 then
				arg_677_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_680_5 = 0

			if var_680_5 < arg_677_1.time_ and arg_677_1.time_ <= var_680_5 + arg_680_0 then
				arg_677_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_680_6 = arg_677_1.actors_["1074ui_story"]
			local var_680_7 = 0

			if var_680_7 < arg_677_1.time_ and arg_677_1.time_ <= var_680_7 + arg_680_0 and not isNil(var_680_6) and arg_677_1.var_.characterEffect1074ui_story == nil then
				arg_677_1.var_.characterEffect1074ui_story = var_680_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_680_8 = 0.200000002980232

			if var_680_7 <= arg_677_1.time_ and arg_677_1.time_ < var_680_7 + var_680_8 and not isNil(var_680_6) then
				local var_680_9 = (arg_677_1.time_ - var_680_7) / var_680_8

				if arg_677_1.var_.characterEffect1074ui_story and not isNil(var_680_6) then
					local var_680_10 = Mathf.Lerp(0, 0.5, var_680_9)

					arg_677_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_677_1.var_.characterEffect1074ui_story.fillRatio = var_680_10
				end
			end

			if arg_677_1.time_ >= var_680_7 + var_680_8 and arg_677_1.time_ < var_680_7 + var_680_8 + arg_680_0 and not isNil(var_680_6) and arg_677_1.var_.characterEffect1074ui_story then
				local var_680_11 = 0.5

				arg_677_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_677_1.var_.characterEffect1074ui_story.fillRatio = var_680_11
			end

			local var_680_12 = 0
			local var_680_13 = 1.25

			if var_680_12 < arg_677_1.time_ and arg_677_1.time_ <= var_680_12 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				local var_680_14 = arg_677_1:FormatText(StoryNameCfg[380].name)

				arg_677_1.leftNameTxt_.text = var_680_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, false)
				arg_677_1.callingController_:SetSelectedState("normal")

				local var_680_15 = arg_677_1:GetWordFromCfg(222031167)
				local var_680_16 = arg_677_1:FormatText(var_680_15.content)

				arg_677_1.text_.text = var_680_16

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_17 = 50
				local var_680_18 = utf8.len(var_680_16)
				local var_680_19 = var_680_17 <= 0 and var_680_13 or var_680_13 * (var_680_18 / var_680_17)

				if var_680_19 > 0 and var_680_13 < var_680_19 then
					arg_677_1.talkMaxDuration = var_680_19

					if var_680_19 + var_680_12 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_19 + var_680_12
					end
				end

				arg_677_1.text_.text = var_680_16
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031167", "story_v_out_222031.awb") ~= 0 then
					local var_680_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031167", "story_v_out_222031.awb") / 1000

					if var_680_20 + var_680_12 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_20 + var_680_12
					end

					if var_680_15.prefab_name ~= "" and arg_677_1.actors_[var_680_15.prefab_name] ~= nil then
						local var_680_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_677_1.actors_[var_680_15.prefab_name].transform, "story_v_out_222031", "222031167", "story_v_out_222031.awb")

						arg_677_1:RecordAudio("222031167", var_680_21)
						arg_677_1:RecordAudio("222031167", var_680_21)
					else
						arg_677_1:AudioAction("play", "voice", "story_v_out_222031", "222031167", "story_v_out_222031.awb")
					end

					arg_677_1:RecordHistoryTalkVoice("story_v_out_222031", "222031167", "story_v_out_222031.awb")
				end

				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_22 = math.max(var_680_13, arg_677_1.talkMaxDuration)

			if var_680_12 <= arg_677_1.time_ and arg_677_1.time_ < var_680_12 + var_680_22 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - var_680_12) / var_680_22

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= var_680_12 + var_680_22 and arg_677_1.time_ < var_680_12 + var_680_22 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {}

		arg_677_1:InitPlayNodeList()
	end,
	Play222031168 = function(arg_681_0, arg_681_1)
		arg_681_1.time_ = 0
		arg_681_1.frameCnt_ = 0
		arg_681_1.state_ = "playing"
		arg_681_1.curTalkId_ = 222031168
		arg_681_1.duration_ = 6.63

		local var_681_0 = {
			ja = 6.633,
			ko = 4.966,
			zh = 4.966
		}
		local var_681_1 = manager.audio:GetLocalizationFlag()

		if var_681_0[var_681_1] ~= nil then
			arg_681_1.duration_ = var_681_0[var_681_1]
		end

		SetActive(arg_681_1.tipsGo_, false)

		function arg_681_1.onSingleLineFinish_()
			arg_681_1.onSingleLineUpdate_ = nil
			arg_681_1.onSingleLineFinish_ = nil
			arg_681_1.state_ = "waiting"
		end

		function arg_681_1.playNext_(arg_683_0)
			if arg_683_0 == 1 then
				arg_681_0:Play222031169(arg_681_1)
			end
		end

		function arg_681_1.onSingleLineUpdate_(arg_684_0)
			local var_684_0 = 0
			local var_684_1 = 0.575

			if var_684_0 < arg_681_1.time_ and arg_681_1.time_ <= var_684_0 + arg_684_0 then
				arg_681_1.talkMaxDuration = 0
				arg_681_1.dialogCg_.alpha = 1

				arg_681_1.dialog_:SetActive(true)
				SetActive(arg_681_1.leftNameGo_, true)

				local var_684_2 = arg_681_1:FormatText(StoryNameCfg[380].name)

				arg_681_1.leftNameTxt_.text = var_684_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_681_1.leftNameTxt_.transform)

				arg_681_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_681_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_681_1:RecordName(arg_681_1.leftNameTxt_.text)
				SetActive(arg_681_1.iconTrs_.gameObject, false)
				arg_681_1.callingController_:SetSelectedState("normal")

				local var_684_3 = arg_681_1:GetWordFromCfg(222031168)
				local var_684_4 = arg_681_1:FormatText(var_684_3.content)

				arg_681_1.text_.text = var_684_4

				LuaForUtil.ClearLinePrefixSymbol(arg_681_1.text_)

				local var_684_5 = 23
				local var_684_6 = utf8.len(var_684_4)
				local var_684_7 = var_684_5 <= 0 and var_684_1 or var_684_1 * (var_684_6 / var_684_5)

				if var_684_7 > 0 and var_684_1 < var_684_7 then
					arg_681_1.talkMaxDuration = var_684_7

					if var_684_7 + var_684_0 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_7 + var_684_0
					end
				end

				arg_681_1.text_.text = var_684_4
				arg_681_1.typewritter.percent = 0

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031168", "story_v_out_222031.awb") ~= 0 then
					local var_684_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031168", "story_v_out_222031.awb") / 1000

					if var_684_8 + var_684_0 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_8 + var_684_0
					end

					if var_684_3.prefab_name ~= "" and arg_681_1.actors_[var_684_3.prefab_name] ~= nil then
						local var_684_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_681_1.actors_[var_684_3.prefab_name].transform, "story_v_out_222031", "222031168", "story_v_out_222031.awb")

						arg_681_1:RecordAudio("222031168", var_684_9)
						arg_681_1:RecordAudio("222031168", var_684_9)
					else
						arg_681_1:AudioAction("play", "voice", "story_v_out_222031", "222031168", "story_v_out_222031.awb")
					end

					arg_681_1:RecordHistoryTalkVoice("story_v_out_222031", "222031168", "story_v_out_222031.awb")
				end

				arg_681_1:RecordContent(arg_681_1.text_.text)
			end

			local var_684_10 = math.max(var_684_1, arg_681_1.talkMaxDuration)

			if var_684_0 <= arg_681_1.time_ and arg_681_1.time_ < var_684_0 + var_684_10 then
				arg_681_1.typewritter.percent = (arg_681_1.time_ - var_684_0) / var_684_10

				arg_681_1.typewritter:SetDirty()
			end

			if arg_681_1.time_ >= var_684_0 + var_684_10 and arg_681_1.time_ < var_684_0 + var_684_10 + arg_684_0 then
				arg_681_1.typewritter.percent = 1

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(true)
			end
		end

		arg_681_1.nodeConfigList_ = {}

		arg_681_1:InitPlayNodeList()
	end,
	Play222031169 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 222031169
		arg_685_1.duration_ = 5.77

		local var_685_0 = {
			ja = 5.766,
			ko = 4.9,
			zh = 4.9
		}
		local var_685_1 = manager.audio:GetLocalizationFlag()

		if var_685_0[var_685_1] ~= nil then
			arg_685_1.duration_ = var_685_0[var_685_1]
		end

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play222031170(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			local var_688_0 = arg_685_1.actors_["1074ui_story"]
			local var_688_1 = 0

			if var_688_1 < arg_685_1.time_ and arg_685_1.time_ <= var_688_1 + arg_688_0 and not isNil(var_688_0) and arg_685_1.var_.characterEffect1074ui_story == nil then
				arg_685_1.var_.characterEffect1074ui_story = var_688_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_688_2 = 0.200000002980232

			if var_688_1 <= arg_685_1.time_ and arg_685_1.time_ < var_688_1 + var_688_2 and not isNil(var_688_0) then
				local var_688_3 = (arg_685_1.time_ - var_688_1) / var_688_2

				if arg_685_1.var_.characterEffect1074ui_story and not isNil(var_688_0) then
					arg_685_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_685_1.time_ >= var_688_1 + var_688_2 and arg_685_1.time_ < var_688_1 + var_688_2 + arg_688_0 and not isNil(var_688_0) and arg_685_1.var_.characterEffect1074ui_story then
				arg_685_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_688_4 = 0

			if var_688_4 < arg_685_1.time_ and arg_685_1.time_ <= var_688_4 + arg_688_0 then
				arg_685_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_688_5 = 0

			if var_688_5 < arg_685_1.time_ and arg_685_1.time_ <= var_688_5 + arg_688_0 then
				arg_685_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_688_6 = arg_685_1.actors_["10044ui_story"]
			local var_688_7 = 0

			if var_688_7 < arg_685_1.time_ and arg_685_1.time_ <= var_688_7 + arg_688_0 and not isNil(var_688_6) and arg_685_1.var_.characterEffect10044ui_story == nil then
				arg_685_1.var_.characterEffect10044ui_story = var_688_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_688_8 = 0.200000002980232

			if var_688_7 <= arg_685_1.time_ and arg_685_1.time_ < var_688_7 + var_688_8 and not isNil(var_688_6) then
				local var_688_9 = (arg_685_1.time_ - var_688_7) / var_688_8

				if arg_685_1.var_.characterEffect10044ui_story and not isNil(var_688_6) then
					local var_688_10 = Mathf.Lerp(0, 0.5, var_688_9)

					arg_685_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_685_1.var_.characterEffect10044ui_story.fillRatio = var_688_10
				end
			end

			if arg_685_1.time_ >= var_688_7 + var_688_8 and arg_685_1.time_ < var_688_7 + var_688_8 + arg_688_0 and not isNil(var_688_6) and arg_685_1.var_.characterEffect10044ui_story then
				local var_688_11 = 0.5

				arg_685_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_685_1.var_.characterEffect10044ui_story.fillRatio = var_688_11
			end

			local var_688_12 = 0
			local var_688_13 = 0.425

			if var_688_12 < arg_685_1.time_ and arg_685_1.time_ <= var_688_12 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0
				arg_685_1.dialogCg_.alpha = 1

				arg_685_1.dialog_:SetActive(true)
				SetActive(arg_685_1.leftNameGo_, true)

				local var_688_14 = arg_685_1:FormatText(StoryNameCfg[410].name)

				arg_685_1.leftNameTxt_.text = var_688_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_685_1.leftNameTxt_.transform)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1.leftNameTxt_.text)
				SetActive(arg_685_1.iconTrs_.gameObject, false)
				arg_685_1.callingController_:SetSelectedState("normal")

				local var_688_15 = arg_685_1:GetWordFromCfg(222031169)
				local var_688_16 = arg_685_1:FormatText(var_688_15.content)

				arg_685_1.text_.text = var_688_16

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_17 = 17
				local var_688_18 = utf8.len(var_688_16)
				local var_688_19 = var_688_17 <= 0 and var_688_13 or var_688_13 * (var_688_18 / var_688_17)

				if var_688_19 > 0 and var_688_13 < var_688_19 then
					arg_685_1.talkMaxDuration = var_688_19

					if var_688_19 + var_688_12 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_19 + var_688_12
					end
				end

				arg_685_1.text_.text = var_688_16
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031169", "story_v_out_222031.awb") ~= 0 then
					local var_688_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031169", "story_v_out_222031.awb") / 1000

					if var_688_20 + var_688_12 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_20 + var_688_12
					end

					if var_688_15.prefab_name ~= "" and arg_685_1.actors_[var_688_15.prefab_name] ~= nil then
						local var_688_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_685_1.actors_[var_688_15.prefab_name].transform, "story_v_out_222031", "222031169", "story_v_out_222031.awb")

						arg_685_1:RecordAudio("222031169", var_688_21)
						arg_685_1:RecordAudio("222031169", var_688_21)
					else
						arg_685_1:AudioAction("play", "voice", "story_v_out_222031", "222031169", "story_v_out_222031.awb")
					end

					arg_685_1:RecordHistoryTalkVoice("story_v_out_222031", "222031169", "story_v_out_222031.awb")
				end

				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_22 = math.max(var_688_13, arg_685_1.talkMaxDuration)

			if var_688_12 <= arg_685_1.time_ and arg_685_1.time_ < var_688_12 + var_688_22 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - var_688_12) / var_688_22

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= var_688_12 + var_688_22 and arg_685_1.time_ < var_688_12 + var_688_22 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {}

		arg_685_1:InitPlayNodeList()
	end,
	Play222031170 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 222031170
		arg_689_1.duration_ = 5

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play222031171(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			local var_692_0 = arg_689_1.actors_["1074ui_story"]
			local var_692_1 = 0

			if var_692_1 < arg_689_1.time_ and arg_689_1.time_ <= var_692_1 + arg_692_0 and not isNil(var_692_0) and arg_689_1.var_.characterEffect1074ui_story == nil then
				arg_689_1.var_.characterEffect1074ui_story = var_692_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_692_2 = 0.200000002980232

			if var_692_1 <= arg_689_1.time_ and arg_689_1.time_ < var_692_1 + var_692_2 and not isNil(var_692_0) then
				local var_692_3 = (arg_689_1.time_ - var_692_1) / var_692_2

				if arg_689_1.var_.characterEffect1074ui_story and not isNil(var_692_0) then
					local var_692_4 = Mathf.Lerp(0, 0.5, var_692_3)

					arg_689_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_689_1.var_.characterEffect1074ui_story.fillRatio = var_692_4
				end
			end

			if arg_689_1.time_ >= var_692_1 + var_692_2 and arg_689_1.time_ < var_692_1 + var_692_2 + arg_692_0 and not isNil(var_692_0) and arg_689_1.var_.characterEffect1074ui_story then
				local var_692_5 = 0.5

				arg_689_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_689_1.var_.characterEffect1074ui_story.fillRatio = var_692_5
			end

			local var_692_6 = 0
			local var_692_7 = 0.8

			if var_692_6 < arg_689_1.time_ and arg_689_1.time_ <= var_692_6 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0
				arg_689_1.dialogCg_.alpha = 1

				arg_689_1.dialog_:SetActive(true)
				SetActive(arg_689_1.leftNameGo_, false)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_689_1.iconTrs_.gameObject, false)
				arg_689_1.callingController_:SetSelectedState("normal")

				local var_692_8 = arg_689_1:GetWordFromCfg(222031170)
				local var_692_9 = arg_689_1:FormatText(var_692_8.content)

				arg_689_1.text_.text = var_692_9

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_10 = 32
				local var_692_11 = utf8.len(var_692_9)
				local var_692_12 = var_692_10 <= 0 and var_692_7 or var_692_7 * (var_692_11 / var_692_10)

				if var_692_12 > 0 and var_692_7 < var_692_12 then
					arg_689_1.talkMaxDuration = var_692_12

					if var_692_12 + var_692_6 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_12 + var_692_6
					end
				end

				arg_689_1.text_.text = var_692_9
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)
				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_13 = math.max(var_692_7, arg_689_1.talkMaxDuration)

			if var_692_6 <= arg_689_1.time_ and arg_689_1.time_ < var_692_6 + var_692_13 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - var_692_6) / var_692_13

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= var_692_6 + var_692_13 and arg_689_1.time_ < var_692_6 + var_692_13 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {}

		arg_689_1:InitPlayNodeList()
	end,
	Play222031171 = function(arg_693_0, arg_693_1)
		arg_693_1.time_ = 0
		arg_693_1.frameCnt_ = 0
		arg_693_1.state_ = "playing"
		arg_693_1.curTalkId_ = 222031171
		arg_693_1.duration_ = 13.4

		local var_693_0 = {
			ja = 13.4,
			ko = 12.6,
			zh = 12.6
		}
		local var_693_1 = manager.audio:GetLocalizationFlag()

		if var_693_0[var_693_1] ~= nil then
			arg_693_1.duration_ = var_693_0[var_693_1]
		end

		SetActive(arg_693_1.tipsGo_, false)

		function arg_693_1.onSingleLineFinish_()
			arg_693_1.onSingleLineUpdate_ = nil
			arg_693_1.onSingleLineFinish_ = nil
			arg_693_1.state_ = "waiting"
		end

		function arg_693_1.playNext_(arg_695_0)
			if arg_695_0 == 1 then
				arg_693_0:Play222031172(arg_693_1)
			end
		end

		function arg_693_1.onSingleLineUpdate_(arg_696_0)
			local var_696_0 = arg_693_1.actors_["10044ui_story"]
			local var_696_1 = 0

			if var_696_1 < arg_693_1.time_ and arg_693_1.time_ <= var_696_1 + arg_696_0 and not isNil(var_696_0) and arg_693_1.var_.characterEffect10044ui_story == nil then
				arg_693_1.var_.characterEffect10044ui_story = var_696_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_696_2 = 0.200000002980232

			if var_696_1 <= arg_693_1.time_ and arg_693_1.time_ < var_696_1 + var_696_2 and not isNil(var_696_0) then
				local var_696_3 = (arg_693_1.time_ - var_696_1) / var_696_2

				if arg_693_1.var_.characterEffect10044ui_story and not isNil(var_696_0) then
					arg_693_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_693_1.time_ >= var_696_1 + var_696_2 and arg_693_1.time_ < var_696_1 + var_696_2 + arg_696_0 and not isNil(var_696_0) and arg_693_1.var_.characterEffect10044ui_story then
				arg_693_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_696_4 = 0

			if var_696_4 < arg_693_1.time_ and arg_693_1.time_ <= var_696_4 + arg_696_0 then
				arg_693_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_2")
			end

			local var_696_5 = 0

			if var_696_5 < arg_693_1.time_ and arg_693_1.time_ <= var_696_5 + arg_696_0 then
				arg_693_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_696_6 = 0
			local var_696_7 = 1.175

			if var_696_6 < arg_693_1.time_ and arg_693_1.time_ <= var_696_6 + arg_696_0 then
				arg_693_1.talkMaxDuration = 0
				arg_693_1.dialogCg_.alpha = 1

				arg_693_1.dialog_:SetActive(true)
				SetActive(arg_693_1.leftNameGo_, true)

				local var_696_8 = arg_693_1:FormatText(StoryNameCfg[380].name)

				arg_693_1.leftNameTxt_.text = var_696_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_693_1.leftNameTxt_.transform)

				arg_693_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_693_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_693_1:RecordName(arg_693_1.leftNameTxt_.text)
				SetActive(arg_693_1.iconTrs_.gameObject, false)
				arg_693_1.callingController_:SetSelectedState("normal")

				local var_696_9 = arg_693_1:GetWordFromCfg(222031171)
				local var_696_10 = arg_693_1:FormatText(var_696_9.content)

				arg_693_1.text_.text = var_696_10

				LuaForUtil.ClearLinePrefixSymbol(arg_693_1.text_)

				local var_696_11 = 47
				local var_696_12 = utf8.len(var_696_10)
				local var_696_13 = var_696_11 <= 0 and var_696_7 or var_696_7 * (var_696_12 / var_696_11)

				if var_696_13 > 0 and var_696_7 < var_696_13 then
					arg_693_1.talkMaxDuration = var_696_13

					if var_696_13 + var_696_6 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_13 + var_696_6
					end
				end

				arg_693_1.text_.text = var_696_10
				arg_693_1.typewritter.percent = 0

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031171", "story_v_out_222031.awb") ~= 0 then
					local var_696_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031171", "story_v_out_222031.awb") / 1000

					if var_696_14 + var_696_6 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_14 + var_696_6
					end

					if var_696_9.prefab_name ~= "" and arg_693_1.actors_[var_696_9.prefab_name] ~= nil then
						local var_696_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_693_1.actors_[var_696_9.prefab_name].transform, "story_v_out_222031", "222031171", "story_v_out_222031.awb")

						arg_693_1:RecordAudio("222031171", var_696_15)
						arg_693_1:RecordAudio("222031171", var_696_15)
					else
						arg_693_1:AudioAction("play", "voice", "story_v_out_222031", "222031171", "story_v_out_222031.awb")
					end

					arg_693_1:RecordHistoryTalkVoice("story_v_out_222031", "222031171", "story_v_out_222031.awb")
				end

				arg_693_1:RecordContent(arg_693_1.text_.text)
			end

			local var_696_16 = math.max(var_696_7, arg_693_1.talkMaxDuration)

			if var_696_6 <= arg_693_1.time_ and arg_693_1.time_ < var_696_6 + var_696_16 then
				arg_693_1.typewritter.percent = (arg_693_1.time_ - var_696_6) / var_696_16

				arg_693_1.typewritter:SetDirty()
			end

			if arg_693_1.time_ >= var_696_6 + var_696_16 and arg_693_1.time_ < var_696_6 + var_696_16 + arg_696_0 then
				arg_693_1.typewritter.percent = 1

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(true)
			end
		end

		arg_693_1.nodeConfigList_ = {}

		arg_693_1:InitPlayNodeList()
	end,
	Play222031172 = function(arg_697_0, arg_697_1)
		arg_697_1.time_ = 0
		arg_697_1.frameCnt_ = 0
		arg_697_1.state_ = "playing"
		arg_697_1.curTalkId_ = 222031172
		arg_697_1.duration_ = 2

		local var_697_0 = {
			ja = 2,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_697_1 = manager.audio:GetLocalizationFlag()

		if var_697_0[var_697_1] ~= nil then
			arg_697_1.duration_ = var_697_0[var_697_1]
		end

		SetActive(arg_697_1.tipsGo_, false)

		function arg_697_1.onSingleLineFinish_()
			arg_697_1.onSingleLineUpdate_ = nil
			arg_697_1.onSingleLineFinish_ = nil
			arg_697_1.state_ = "waiting"
		end

		function arg_697_1.playNext_(arg_699_0)
			if arg_699_0 == 1 then
				arg_697_0:Play222031173(arg_697_1)
			end
		end

		function arg_697_1.onSingleLineUpdate_(arg_700_0)
			local var_700_0 = arg_697_1.actors_["1074ui_story"]
			local var_700_1 = 0

			if var_700_1 < arg_697_1.time_ and arg_697_1.time_ <= var_700_1 + arg_700_0 and not isNil(var_700_0) and arg_697_1.var_.characterEffect1074ui_story == nil then
				arg_697_1.var_.characterEffect1074ui_story = var_700_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_700_2 = 0.200000002980232

			if var_700_1 <= arg_697_1.time_ and arg_697_1.time_ < var_700_1 + var_700_2 and not isNil(var_700_0) then
				local var_700_3 = (arg_697_1.time_ - var_700_1) / var_700_2

				if arg_697_1.var_.characterEffect1074ui_story and not isNil(var_700_0) then
					arg_697_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_697_1.time_ >= var_700_1 + var_700_2 and arg_697_1.time_ < var_700_1 + var_700_2 + arg_700_0 and not isNil(var_700_0) and arg_697_1.var_.characterEffect1074ui_story then
				arg_697_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_700_4 = 0

			if var_700_4 < arg_697_1.time_ and arg_697_1.time_ <= var_700_4 + arg_700_0 then
				arg_697_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_700_5 = 0

			if var_700_5 < arg_697_1.time_ and arg_697_1.time_ <= var_700_5 + arg_700_0 then
				arg_697_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_700_6 = arg_697_1.actors_["10044ui_story"]
			local var_700_7 = 0

			if var_700_7 < arg_697_1.time_ and arg_697_1.time_ <= var_700_7 + arg_700_0 and not isNil(var_700_6) and arg_697_1.var_.characterEffect10044ui_story == nil then
				arg_697_1.var_.characterEffect10044ui_story = var_700_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_700_8 = 0.200000002980232

			if var_700_7 <= arg_697_1.time_ and arg_697_1.time_ < var_700_7 + var_700_8 and not isNil(var_700_6) then
				local var_700_9 = (arg_697_1.time_ - var_700_7) / var_700_8

				if arg_697_1.var_.characterEffect10044ui_story and not isNil(var_700_6) then
					local var_700_10 = Mathf.Lerp(0, 0.5, var_700_9)

					arg_697_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_697_1.var_.characterEffect10044ui_story.fillRatio = var_700_10
				end
			end

			if arg_697_1.time_ >= var_700_7 + var_700_8 and arg_697_1.time_ < var_700_7 + var_700_8 + arg_700_0 and not isNil(var_700_6) and arg_697_1.var_.characterEffect10044ui_story then
				local var_700_11 = 0.5

				arg_697_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_697_1.var_.characterEffect10044ui_story.fillRatio = var_700_11
			end

			local var_700_12 = 0
			local var_700_13 = 0.075

			if var_700_12 < arg_697_1.time_ and arg_697_1.time_ <= var_700_12 + arg_700_0 then
				arg_697_1.talkMaxDuration = 0
				arg_697_1.dialogCg_.alpha = 1

				arg_697_1.dialog_:SetActive(true)
				SetActive(arg_697_1.leftNameGo_, true)

				local var_700_14 = arg_697_1:FormatText(StoryNameCfg[410].name)

				arg_697_1.leftNameTxt_.text = var_700_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_697_1.leftNameTxt_.transform)

				arg_697_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_697_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_697_1:RecordName(arg_697_1.leftNameTxt_.text)
				SetActive(arg_697_1.iconTrs_.gameObject, false)
				arg_697_1.callingController_:SetSelectedState("normal")

				local var_700_15 = arg_697_1:GetWordFromCfg(222031172)
				local var_700_16 = arg_697_1:FormatText(var_700_15.content)

				arg_697_1.text_.text = var_700_16

				LuaForUtil.ClearLinePrefixSymbol(arg_697_1.text_)

				local var_700_17 = 3
				local var_700_18 = utf8.len(var_700_16)
				local var_700_19 = var_700_17 <= 0 and var_700_13 or var_700_13 * (var_700_18 / var_700_17)

				if var_700_19 > 0 and var_700_13 < var_700_19 then
					arg_697_1.talkMaxDuration = var_700_19

					if var_700_19 + var_700_12 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_19 + var_700_12
					end
				end

				arg_697_1.text_.text = var_700_16
				arg_697_1.typewritter.percent = 0

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031172", "story_v_out_222031.awb") ~= 0 then
					local var_700_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031172", "story_v_out_222031.awb") / 1000

					if var_700_20 + var_700_12 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_20 + var_700_12
					end

					if var_700_15.prefab_name ~= "" and arg_697_1.actors_[var_700_15.prefab_name] ~= nil then
						local var_700_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_697_1.actors_[var_700_15.prefab_name].transform, "story_v_out_222031", "222031172", "story_v_out_222031.awb")

						arg_697_1:RecordAudio("222031172", var_700_21)
						arg_697_1:RecordAudio("222031172", var_700_21)
					else
						arg_697_1:AudioAction("play", "voice", "story_v_out_222031", "222031172", "story_v_out_222031.awb")
					end

					arg_697_1:RecordHistoryTalkVoice("story_v_out_222031", "222031172", "story_v_out_222031.awb")
				end

				arg_697_1:RecordContent(arg_697_1.text_.text)
			end

			local var_700_22 = math.max(var_700_13, arg_697_1.talkMaxDuration)

			if var_700_12 <= arg_697_1.time_ and arg_697_1.time_ < var_700_12 + var_700_22 then
				arg_697_1.typewritter.percent = (arg_697_1.time_ - var_700_12) / var_700_22

				arg_697_1.typewritter:SetDirty()
			end

			if arg_697_1.time_ >= var_700_12 + var_700_22 and arg_697_1.time_ < var_700_12 + var_700_22 + arg_700_0 then
				arg_697_1.typewritter.percent = 1

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(true)
			end
		end

		arg_697_1.nodeConfigList_ = {}

		arg_697_1:InitPlayNodeList()
	end,
	Play222031173 = function(arg_701_0, arg_701_1)
		arg_701_1.time_ = 0
		arg_701_1.frameCnt_ = 0
		arg_701_1.state_ = "playing"
		arg_701_1.curTalkId_ = 222031173
		arg_701_1.duration_ = 6.7

		local var_701_0 = {
			ja = 6.7,
			ko = 4.8,
			zh = 4.8
		}
		local var_701_1 = manager.audio:GetLocalizationFlag()

		if var_701_0[var_701_1] ~= nil then
			arg_701_1.duration_ = var_701_0[var_701_1]
		end

		SetActive(arg_701_1.tipsGo_, false)

		function arg_701_1.onSingleLineFinish_()
			arg_701_1.onSingleLineUpdate_ = nil
			arg_701_1.onSingleLineFinish_ = nil
			arg_701_1.state_ = "waiting"
		end

		function arg_701_1.playNext_(arg_703_0)
			if arg_703_0 == 1 then
				arg_701_0:Play222031174(arg_701_1)
			end
		end

		function arg_701_1.onSingleLineUpdate_(arg_704_0)
			local var_704_0 = arg_701_1.actors_["10044ui_story"].transform
			local var_704_1 = 0

			if var_704_1 < arg_701_1.time_ and arg_701_1.time_ <= var_704_1 + arg_704_0 then
				arg_701_1.var_.moveOldPos10044ui_story = var_704_0.localPosition
			end

			local var_704_2 = 0.001

			if var_704_1 <= arg_701_1.time_ and arg_701_1.time_ < var_704_1 + var_704_2 then
				local var_704_3 = (arg_701_1.time_ - var_704_1) / var_704_2
				local var_704_4 = Vector3.New(0, 100, 0)

				var_704_0.localPosition = Vector3.Lerp(arg_701_1.var_.moveOldPos10044ui_story, var_704_4, var_704_3)

				local var_704_5 = manager.ui.mainCamera.transform.position - var_704_0.position

				var_704_0.forward = Vector3.New(var_704_5.x, var_704_5.y, var_704_5.z)

				local var_704_6 = var_704_0.localEulerAngles

				var_704_6.z = 0
				var_704_6.x = 0
				var_704_0.localEulerAngles = var_704_6
			end

			if arg_701_1.time_ >= var_704_1 + var_704_2 and arg_701_1.time_ < var_704_1 + var_704_2 + arg_704_0 then
				var_704_0.localPosition = Vector3.New(0, 100, 0)

				local var_704_7 = manager.ui.mainCamera.transform.position - var_704_0.position

				var_704_0.forward = Vector3.New(var_704_7.x, var_704_7.y, var_704_7.z)

				local var_704_8 = var_704_0.localEulerAngles

				var_704_8.z = 0
				var_704_8.x = 0
				var_704_0.localEulerAngles = var_704_8
			end

			local var_704_9 = arg_701_1.actors_["10044ui_story"]
			local var_704_10 = 0

			if var_704_10 < arg_701_1.time_ and arg_701_1.time_ <= var_704_10 + arg_704_0 and not isNil(var_704_9) and arg_701_1.var_.characterEffect10044ui_story == nil then
				arg_701_1.var_.characterEffect10044ui_story = var_704_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_704_11 = 0.200000002980232

			if var_704_10 <= arg_701_1.time_ and arg_701_1.time_ < var_704_10 + var_704_11 and not isNil(var_704_9) then
				local var_704_12 = (arg_701_1.time_ - var_704_10) / var_704_11

				if arg_701_1.var_.characterEffect10044ui_story and not isNil(var_704_9) then
					local var_704_13 = Mathf.Lerp(0, 0.5, var_704_12)

					arg_701_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_701_1.var_.characterEffect10044ui_story.fillRatio = var_704_13
				end
			end

			if arg_701_1.time_ >= var_704_10 + var_704_11 and arg_701_1.time_ < var_704_10 + var_704_11 + arg_704_0 and not isNil(var_704_9) and arg_701_1.var_.characterEffect10044ui_story then
				local var_704_14 = 0.5

				arg_701_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_701_1.var_.characterEffect10044ui_story.fillRatio = var_704_14
			end

			local var_704_15 = arg_701_1.actors_["1070ui_story"].transform
			local var_704_16 = 0

			if var_704_16 < arg_701_1.time_ and arg_701_1.time_ <= var_704_16 + arg_704_0 then
				arg_701_1.var_.moveOldPos1070ui_story = var_704_15.localPosition
			end

			local var_704_17 = 0.001

			if var_704_16 <= arg_701_1.time_ and arg_701_1.time_ < var_704_16 + var_704_17 then
				local var_704_18 = (arg_701_1.time_ - var_704_16) / var_704_17
				local var_704_19 = Vector3.New(-0.7, -0.95, -6.05)

				var_704_15.localPosition = Vector3.Lerp(arg_701_1.var_.moveOldPos1070ui_story, var_704_19, var_704_18)

				local var_704_20 = manager.ui.mainCamera.transform.position - var_704_15.position

				var_704_15.forward = Vector3.New(var_704_20.x, var_704_20.y, var_704_20.z)

				local var_704_21 = var_704_15.localEulerAngles

				var_704_21.z = 0
				var_704_21.x = 0
				var_704_15.localEulerAngles = var_704_21
			end

			if arg_701_1.time_ >= var_704_16 + var_704_17 and arg_701_1.time_ < var_704_16 + var_704_17 + arg_704_0 then
				var_704_15.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_704_22 = manager.ui.mainCamera.transform.position - var_704_15.position

				var_704_15.forward = Vector3.New(var_704_22.x, var_704_22.y, var_704_22.z)

				local var_704_23 = var_704_15.localEulerAngles

				var_704_23.z = 0
				var_704_23.x = 0
				var_704_15.localEulerAngles = var_704_23
			end

			local var_704_24 = arg_701_1.actors_["1070ui_story"]
			local var_704_25 = 0

			if var_704_25 < arg_701_1.time_ and arg_701_1.time_ <= var_704_25 + arg_704_0 and not isNil(var_704_24) and arg_701_1.var_.characterEffect1070ui_story == nil then
				arg_701_1.var_.characterEffect1070ui_story = var_704_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_704_26 = 0.200000002980232

			if var_704_25 <= arg_701_1.time_ and arg_701_1.time_ < var_704_25 + var_704_26 and not isNil(var_704_24) then
				local var_704_27 = (arg_701_1.time_ - var_704_25) / var_704_26

				if arg_701_1.var_.characterEffect1070ui_story and not isNil(var_704_24) then
					arg_701_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_701_1.time_ >= var_704_25 + var_704_26 and arg_701_1.time_ < var_704_25 + var_704_26 + arg_704_0 and not isNil(var_704_24) and arg_701_1.var_.characterEffect1070ui_story then
				arg_701_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_704_28 = 0

			if var_704_28 < arg_701_1.time_ and arg_701_1.time_ <= var_704_28 + arg_704_0 then
				arg_701_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_704_29 = 0

			if var_704_29 < arg_701_1.time_ and arg_701_1.time_ <= var_704_29 + arg_704_0 then
				arg_701_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_704_30 = arg_701_1.actors_["1074ui_story"]
			local var_704_31 = 0

			if var_704_31 < arg_701_1.time_ and arg_701_1.time_ <= var_704_31 + arg_704_0 and not isNil(var_704_30) and arg_701_1.var_.characterEffect1074ui_story == nil then
				arg_701_1.var_.characterEffect1074ui_story = var_704_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_704_32 = 0.200000002980232

			if var_704_31 <= arg_701_1.time_ and arg_701_1.time_ < var_704_31 + var_704_32 and not isNil(var_704_30) then
				local var_704_33 = (arg_701_1.time_ - var_704_31) / var_704_32

				if arg_701_1.var_.characterEffect1074ui_story and not isNil(var_704_30) then
					local var_704_34 = Mathf.Lerp(0, 0.5, var_704_33)

					arg_701_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_701_1.var_.characterEffect1074ui_story.fillRatio = var_704_34
				end
			end

			if arg_701_1.time_ >= var_704_31 + var_704_32 and arg_701_1.time_ < var_704_31 + var_704_32 + arg_704_0 and not isNil(var_704_30) and arg_701_1.var_.characterEffect1074ui_story then
				local var_704_35 = 0.5

				arg_701_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_701_1.var_.characterEffect1074ui_story.fillRatio = var_704_35
			end

			local var_704_36 = 0
			local var_704_37 = 0.625

			if var_704_36 < arg_701_1.time_ and arg_701_1.time_ <= var_704_36 + arg_704_0 then
				arg_701_1.talkMaxDuration = 0
				arg_701_1.dialogCg_.alpha = 1

				arg_701_1.dialog_:SetActive(true)
				SetActive(arg_701_1.leftNameGo_, true)

				local var_704_38 = arg_701_1:FormatText(StoryNameCfg[318].name)

				arg_701_1.leftNameTxt_.text = var_704_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_701_1.leftNameTxt_.transform)

				arg_701_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_701_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_701_1:RecordName(arg_701_1.leftNameTxt_.text)
				SetActive(arg_701_1.iconTrs_.gameObject, false)
				arg_701_1.callingController_:SetSelectedState("normal")

				local var_704_39 = arg_701_1:GetWordFromCfg(222031173)
				local var_704_40 = arg_701_1:FormatText(var_704_39.content)

				arg_701_1.text_.text = var_704_40

				LuaForUtil.ClearLinePrefixSymbol(arg_701_1.text_)

				local var_704_41 = 25
				local var_704_42 = utf8.len(var_704_40)
				local var_704_43 = var_704_41 <= 0 and var_704_37 or var_704_37 * (var_704_42 / var_704_41)

				if var_704_43 > 0 and var_704_37 < var_704_43 then
					arg_701_1.talkMaxDuration = var_704_43

					if var_704_43 + var_704_36 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_43 + var_704_36
					end
				end

				arg_701_1.text_.text = var_704_40
				arg_701_1.typewritter.percent = 0

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031173", "story_v_out_222031.awb") ~= 0 then
					local var_704_44 = manager.audio:GetVoiceLength("story_v_out_222031", "222031173", "story_v_out_222031.awb") / 1000

					if var_704_44 + var_704_36 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_44 + var_704_36
					end

					if var_704_39.prefab_name ~= "" and arg_701_1.actors_[var_704_39.prefab_name] ~= nil then
						local var_704_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_701_1.actors_[var_704_39.prefab_name].transform, "story_v_out_222031", "222031173", "story_v_out_222031.awb")

						arg_701_1:RecordAudio("222031173", var_704_45)
						arg_701_1:RecordAudio("222031173", var_704_45)
					else
						arg_701_1:AudioAction("play", "voice", "story_v_out_222031", "222031173", "story_v_out_222031.awb")
					end

					arg_701_1:RecordHistoryTalkVoice("story_v_out_222031", "222031173", "story_v_out_222031.awb")
				end

				arg_701_1:RecordContent(arg_701_1.text_.text)
			end

			local var_704_46 = math.max(var_704_37, arg_701_1.talkMaxDuration)

			if var_704_36 <= arg_701_1.time_ and arg_701_1.time_ < var_704_36 + var_704_46 then
				arg_701_1.typewritter.percent = (arg_701_1.time_ - var_704_36) / var_704_46

				arg_701_1.typewritter:SetDirty()
			end

			if arg_701_1.time_ >= var_704_36 + var_704_46 and arg_701_1.time_ < var_704_36 + var_704_46 + arg_704_0 then
				arg_701_1.typewritter.percent = 1

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(true)
			end
		end

		arg_701_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_701_1:InitPlayNodeList()
	end,
	Play222031174 = function(arg_705_0, arg_705_1)
		arg_705_1.time_ = 0
		arg_705_1.frameCnt_ = 0
		arg_705_1.state_ = "playing"
		arg_705_1.curTalkId_ = 222031174
		arg_705_1.duration_ = 6

		local var_705_0 = {
			ja = 6,
			ko = 5.3,
			zh = 5.3
		}
		local var_705_1 = manager.audio:GetLocalizationFlag()

		if var_705_0[var_705_1] ~= nil then
			arg_705_1.duration_ = var_705_0[var_705_1]
		end

		SetActive(arg_705_1.tipsGo_, false)

		function arg_705_1.onSingleLineFinish_()
			arg_705_1.onSingleLineUpdate_ = nil
			arg_705_1.onSingleLineFinish_ = nil
			arg_705_1.state_ = "waiting"
		end

		function arg_705_1.playNext_(arg_707_0)
			if arg_707_0 == 1 then
				arg_705_0:Play222031175(arg_705_1)
			end
		end

		function arg_705_1.onSingleLineUpdate_(arg_708_0)
			local var_708_0 = arg_705_1.actors_["1074ui_story"]
			local var_708_1 = 0

			if var_708_1 < arg_705_1.time_ and arg_705_1.time_ <= var_708_1 + arg_708_0 and not isNil(var_708_0) and arg_705_1.var_.characterEffect1074ui_story == nil then
				arg_705_1.var_.characterEffect1074ui_story = var_708_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_708_2 = 0.200000002980232

			if var_708_1 <= arg_705_1.time_ and arg_705_1.time_ < var_708_1 + var_708_2 and not isNil(var_708_0) then
				local var_708_3 = (arg_705_1.time_ - var_708_1) / var_708_2

				if arg_705_1.var_.characterEffect1074ui_story and not isNil(var_708_0) then
					arg_705_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_705_1.time_ >= var_708_1 + var_708_2 and arg_705_1.time_ < var_708_1 + var_708_2 + arg_708_0 and not isNil(var_708_0) and arg_705_1.var_.characterEffect1074ui_story then
				arg_705_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_708_4 = 0

			if var_708_4 < arg_705_1.time_ and arg_705_1.time_ <= var_708_4 + arg_708_0 then
				arg_705_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_708_5 = 0

			if var_708_5 < arg_705_1.time_ and arg_705_1.time_ <= var_708_5 + arg_708_0 then
				arg_705_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_708_6 = arg_705_1.actors_["1070ui_story"]
			local var_708_7 = 0

			if var_708_7 < arg_705_1.time_ and arg_705_1.time_ <= var_708_7 + arg_708_0 and not isNil(var_708_6) and arg_705_1.var_.characterEffect1070ui_story == nil then
				arg_705_1.var_.characterEffect1070ui_story = var_708_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_708_8 = 0.200000002980232

			if var_708_7 <= arg_705_1.time_ and arg_705_1.time_ < var_708_7 + var_708_8 and not isNil(var_708_6) then
				local var_708_9 = (arg_705_1.time_ - var_708_7) / var_708_8

				if arg_705_1.var_.characterEffect1070ui_story and not isNil(var_708_6) then
					local var_708_10 = Mathf.Lerp(0, 0.5, var_708_9)

					arg_705_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_705_1.var_.characterEffect1070ui_story.fillRatio = var_708_10
				end
			end

			if arg_705_1.time_ >= var_708_7 + var_708_8 and arg_705_1.time_ < var_708_7 + var_708_8 + arg_708_0 and not isNil(var_708_6) and arg_705_1.var_.characterEffect1070ui_story then
				local var_708_11 = 0.5

				arg_705_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_705_1.var_.characterEffect1070ui_story.fillRatio = var_708_11
			end

			local var_708_12 = 0
			local var_708_13 = 0.6

			if var_708_12 < arg_705_1.time_ and arg_705_1.time_ <= var_708_12 + arg_708_0 then
				arg_705_1.talkMaxDuration = 0
				arg_705_1.dialogCg_.alpha = 1

				arg_705_1.dialog_:SetActive(true)
				SetActive(arg_705_1.leftNameGo_, true)

				local var_708_14 = arg_705_1:FormatText(StoryNameCfg[410].name)

				arg_705_1.leftNameTxt_.text = var_708_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_705_1.leftNameTxt_.transform)

				arg_705_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_705_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_705_1:RecordName(arg_705_1.leftNameTxt_.text)
				SetActive(arg_705_1.iconTrs_.gameObject, false)
				arg_705_1.callingController_:SetSelectedState("normal")

				local var_708_15 = arg_705_1:GetWordFromCfg(222031174)
				local var_708_16 = arg_705_1:FormatText(var_708_15.content)

				arg_705_1.text_.text = var_708_16

				LuaForUtil.ClearLinePrefixSymbol(arg_705_1.text_)

				local var_708_17 = 24
				local var_708_18 = utf8.len(var_708_16)
				local var_708_19 = var_708_17 <= 0 and var_708_13 or var_708_13 * (var_708_18 / var_708_17)

				if var_708_19 > 0 and var_708_13 < var_708_19 then
					arg_705_1.talkMaxDuration = var_708_19

					if var_708_19 + var_708_12 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_19 + var_708_12
					end
				end

				arg_705_1.text_.text = var_708_16
				arg_705_1.typewritter.percent = 0

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031174", "story_v_out_222031.awb") ~= 0 then
					local var_708_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031174", "story_v_out_222031.awb") / 1000

					if var_708_20 + var_708_12 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_20 + var_708_12
					end

					if var_708_15.prefab_name ~= "" and arg_705_1.actors_[var_708_15.prefab_name] ~= nil then
						local var_708_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_705_1.actors_[var_708_15.prefab_name].transform, "story_v_out_222031", "222031174", "story_v_out_222031.awb")

						arg_705_1:RecordAudio("222031174", var_708_21)
						arg_705_1:RecordAudio("222031174", var_708_21)
					else
						arg_705_1:AudioAction("play", "voice", "story_v_out_222031", "222031174", "story_v_out_222031.awb")
					end

					arg_705_1:RecordHistoryTalkVoice("story_v_out_222031", "222031174", "story_v_out_222031.awb")
				end

				arg_705_1:RecordContent(arg_705_1.text_.text)
			end

			local var_708_22 = math.max(var_708_13, arg_705_1.talkMaxDuration)

			if var_708_12 <= arg_705_1.time_ and arg_705_1.time_ < var_708_12 + var_708_22 then
				arg_705_1.typewritter.percent = (arg_705_1.time_ - var_708_12) / var_708_22

				arg_705_1.typewritter:SetDirty()
			end

			if arg_705_1.time_ >= var_708_12 + var_708_22 and arg_705_1.time_ < var_708_12 + var_708_22 + arg_708_0 then
				arg_705_1.typewritter.percent = 1

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(true)
			end
		end

		arg_705_1.nodeConfigList_ = {}

		arg_705_1:InitPlayNodeList()
	end,
	Play222031175 = function(arg_709_0, arg_709_1)
		arg_709_1.time_ = 0
		arg_709_1.frameCnt_ = 0
		arg_709_1.state_ = "playing"
		arg_709_1.curTalkId_ = 222031175
		arg_709_1.duration_ = 7.43

		local var_709_0 = {
			ja = 7.433,
			ko = 7.2,
			zh = 7.2
		}
		local var_709_1 = manager.audio:GetLocalizationFlag()

		if var_709_0[var_709_1] ~= nil then
			arg_709_1.duration_ = var_709_0[var_709_1]
		end

		SetActive(arg_709_1.tipsGo_, false)

		function arg_709_1.onSingleLineFinish_()
			arg_709_1.onSingleLineUpdate_ = nil
			arg_709_1.onSingleLineFinish_ = nil
			arg_709_1.state_ = "waiting"
		end

		function arg_709_1.playNext_(arg_711_0)
			if arg_711_0 == 1 then
				arg_709_0:Play222031176(arg_709_1)
			end
		end

		function arg_709_1.onSingleLineUpdate_(arg_712_0)
			local var_712_0 = 0
			local var_712_1 = 0.95

			if var_712_0 < arg_709_1.time_ and arg_709_1.time_ <= var_712_0 + arg_712_0 then
				arg_709_1.talkMaxDuration = 0
				arg_709_1.dialogCg_.alpha = 1

				arg_709_1.dialog_:SetActive(true)
				SetActive(arg_709_1.leftNameGo_, true)

				local var_712_2 = arg_709_1:FormatText(StoryNameCfg[410].name)

				arg_709_1.leftNameTxt_.text = var_712_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_709_1.leftNameTxt_.transform)

				arg_709_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_709_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_709_1:RecordName(arg_709_1.leftNameTxt_.text)
				SetActive(arg_709_1.iconTrs_.gameObject, false)
				arg_709_1.callingController_:SetSelectedState("normal")

				local var_712_3 = arg_709_1:GetWordFromCfg(222031175)
				local var_712_4 = arg_709_1:FormatText(var_712_3.content)

				arg_709_1.text_.text = var_712_4

				LuaForUtil.ClearLinePrefixSymbol(arg_709_1.text_)

				local var_712_5 = 38
				local var_712_6 = utf8.len(var_712_4)
				local var_712_7 = var_712_5 <= 0 and var_712_1 or var_712_1 * (var_712_6 / var_712_5)

				if var_712_7 > 0 and var_712_1 < var_712_7 then
					arg_709_1.talkMaxDuration = var_712_7

					if var_712_7 + var_712_0 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_7 + var_712_0
					end
				end

				arg_709_1.text_.text = var_712_4
				arg_709_1.typewritter.percent = 0

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031175", "story_v_out_222031.awb") ~= 0 then
					local var_712_8 = manager.audio:GetVoiceLength("story_v_out_222031", "222031175", "story_v_out_222031.awb") / 1000

					if var_712_8 + var_712_0 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_8 + var_712_0
					end

					if var_712_3.prefab_name ~= "" and arg_709_1.actors_[var_712_3.prefab_name] ~= nil then
						local var_712_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_709_1.actors_[var_712_3.prefab_name].transform, "story_v_out_222031", "222031175", "story_v_out_222031.awb")

						arg_709_1:RecordAudio("222031175", var_712_9)
						arg_709_1:RecordAudio("222031175", var_712_9)
					else
						arg_709_1:AudioAction("play", "voice", "story_v_out_222031", "222031175", "story_v_out_222031.awb")
					end

					arg_709_1:RecordHistoryTalkVoice("story_v_out_222031", "222031175", "story_v_out_222031.awb")
				end

				arg_709_1:RecordContent(arg_709_1.text_.text)
			end

			local var_712_10 = math.max(var_712_1, arg_709_1.talkMaxDuration)

			if var_712_0 <= arg_709_1.time_ and arg_709_1.time_ < var_712_0 + var_712_10 then
				arg_709_1.typewritter.percent = (arg_709_1.time_ - var_712_0) / var_712_10

				arg_709_1.typewritter:SetDirty()
			end

			if arg_709_1.time_ >= var_712_0 + var_712_10 and arg_709_1.time_ < var_712_0 + var_712_10 + arg_712_0 then
				arg_709_1.typewritter.percent = 1

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(true)
			end
		end

		arg_709_1.nodeConfigList_ = {}

		arg_709_1:InitPlayNodeList()
	end,
	Play222031176 = function(arg_713_0, arg_713_1)
		arg_713_1.time_ = 0
		arg_713_1.frameCnt_ = 0
		arg_713_1.state_ = "playing"
		arg_713_1.curTalkId_ = 222031176
		arg_713_1.duration_ = 9.2

		local var_713_0 = {
			ja = 9.2,
			ko = 4.266,
			zh = 4.266
		}
		local var_713_1 = manager.audio:GetLocalizationFlag()

		if var_713_0[var_713_1] ~= nil then
			arg_713_1.duration_ = var_713_0[var_713_1]
		end

		SetActive(arg_713_1.tipsGo_, false)

		function arg_713_1.onSingleLineFinish_()
			arg_713_1.onSingleLineUpdate_ = nil
			arg_713_1.onSingleLineFinish_ = nil
			arg_713_1.state_ = "waiting"
		end

		function arg_713_1.playNext_(arg_715_0)
			if arg_715_0 == 1 then
				arg_713_0:Play222031177(arg_713_1)
			end
		end

		function arg_713_1.onSingleLineUpdate_(arg_716_0)
			local var_716_0 = arg_713_1.actors_["1070ui_story"]
			local var_716_1 = 0

			if var_716_1 < arg_713_1.time_ and arg_713_1.time_ <= var_716_1 + arg_716_0 and not isNil(var_716_0) and arg_713_1.var_.characterEffect1070ui_story == nil then
				arg_713_1.var_.characterEffect1070ui_story = var_716_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_716_2 = 0.200000002980232

			if var_716_1 <= arg_713_1.time_ and arg_713_1.time_ < var_716_1 + var_716_2 and not isNil(var_716_0) then
				local var_716_3 = (arg_713_1.time_ - var_716_1) / var_716_2

				if arg_713_1.var_.characterEffect1070ui_story and not isNil(var_716_0) then
					arg_713_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_713_1.time_ >= var_716_1 + var_716_2 and arg_713_1.time_ < var_716_1 + var_716_2 + arg_716_0 and not isNil(var_716_0) and arg_713_1.var_.characterEffect1070ui_story then
				arg_713_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_716_4 = 0

			if var_716_4 < arg_713_1.time_ and arg_713_1.time_ <= var_716_4 + arg_716_0 then
				arg_713_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			local var_716_5 = 0

			if var_716_5 < arg_713_1.time_ and arg_713_1.time_ <= var_716_5 + arg_716_0 then
				arg_713_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_716_6 = arg_713_1.actors_["1074ui_story"]
			local var_716_7 = 0

			if var_716_7 < arg_713_1.time_ and arg_713_1.time_ <= var_716_7 + arg_716_0 and not isNil(var_716_6) and arg_713_1.var_.characterEffect1074ui_story == nil then
				arg_713_1.var_.characterEffect1074ui_story = var_716_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_716_8 = 0.200000002980232

			if var_716_7 <= arg_713_1.time_ and arg_713_1.time_ < var_716_7 + var_716_8 and not isNil(var_716_6) then
				local var_716_9 = (arg_713_1.time_ - var_716_7) / var_716_8

				if arg_713_1.var_.characterEffect1074ui_story and not isNil(var_716_6) then
					local var_716_10 = Mathf.Lerp(0, 0.5, var_716_9)

					arg_713_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_713_1.var_.characterEffect1074ui_story.fillRatio = var_716_10
				end
			end

			if arg_713_1.time_ >= var_716_7 + var_716_8 and arg_713_1.time_ < var_716_7 + var_716_8 + arg_716_0 and not isNil(var_716_6) and arg_713_1.var_.characterEffect1074ui_story then
				local var_716_11 = 0.5

				arg_713_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_713_1.var_.characterEffect1074ui_story.fillRatio = var_716_11
			end

			local var_716_12 = 0
			local var_716_13 = 0.4

			if var_716_12 < arg_713_1.time_ and arg_713_1.time_ <= var_716_12 + arg_716_0 then
				arg_713_1.talkMaxDuration = 0
				arg_713_1.dialogCg_.alpha = 1

				arg_713_1.dialog_:SetActive(true)
				SetActive(arg_713_1.leftNameGo_, true)

				local var_716_14 = arg_713_1:FormatText(StoryNameCfg[318].name)

				arg_713_1.leftNameTxt_.text = var_716_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_713_1.leftNameTxt_.transform)

				arg_713_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_713_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_713_1:RecordName(arg_713_1.leftNameTxt_.text)
				SetActive(arg_713_1.iconTrs_.gameObject, false)
				arg_713_1.callingController_:SetSelectedState("normal")

				local var_716_15 = arg_713_1:GetWordFromCfg(222031176)
				local var_716_16 = arg_713_1:FormatText(var_716_15.content)

				arg_713_1.text_.text = var_716_16

				LuaForUtil.ClearLinePrefixSymbol(arg_713_1.text_)

				local var_716_17 = 16
				local var_716_18 = utf8.len(var_716_16)
				local var_716_19 = var_716_17 <= 0 and var_716_13 or var_716_13 * (var_716_18 / var_716_17)

				if var_716_19 > 0 and var_716_13 < var_716_19 then
					arg_713_1.talkMaxDuration = var_716_19

					if var_716_19 + var_716_12 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_19 + var_716_12
					end
				end

				arg_713_1.text_.text = var_716_16
				arg_713_1.typewritter.percent = 0

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031176", "story_v_out_222031.awb") ~= 0 then
					local var_716_20 = manager.audio:GetVoiceLength("story_v_out_222031", "222031176", "story_v_out_222031.awb") / 1000

					if var_716_20 + var_716_12 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_20 + var_716_12
					end

					if var_716_15.prefab_name ~= "" and arg_713_1.actors_[var_716_15.prefab_name] ~= nil then
						local var_716_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_713_1.actors_[var_716_15.prefab_name].transform, "story_v_out_222031", "222031176", "story_v_out_222031.awb")

						arg_713_1:RecordAudio("222031176", var_716_21)
						arg_713_1:RecordAudio("222031176", var_716_21)
					else
						arg_713_1:AudioAction("play", "voice", "story_v_out_222031", "222031176", "story_v_out_222031.awb")
					end

					arg_713_1:RecordHistoryTalkVoice("story_v_out_222031", "222031176", "story_v_out_222031.awb")
				end

				arg_713_1:RecordContent(arg_713_1.text_.text)
			end

			local var_716_22 = math.max(var_716_13, arg_713_1.talkMaxDuration)

			if var_716_12 <= arg_713_1.time_ and arg_713_1.time_ < var_716_12 + var_716_22 then
				arg_713_1.typewritter.percent = (arg_713_1.time_ - var_716_12) / var_716_22

				arg_713_1.typewritter:SetDirty()
			end

			if arg_713_1.time_ >= var_716_12 + var_716_22 and arg_713_1.time_ < var_716_12 + var_716_22 + arg_716_0 then
				arg_713_1.typewritter.percent = 1

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(true)
			end
		end

		arg_713_1.nodeConfigList_ = {}

		arg_713_1:InitPlayNodeList()
	end,
	Play222031177 = function(arg_717_0, arg_717_1)
		arg_717_1.time_ = 0
		arg_717_1.frameCnt_ = 0
		arg_717_1.state_ = "playing"
		arg_717_1.curTalkId_ = 222031177
		arg_717_1.duration_ = 5

		SetActive(arg_717_1.tipsGo_, false)

		function arg_717_1.onSingleLineFinish_()
			arg_717_1.onSingleLineUpdate_ = nil
			arg_717_1.onSingleLineFinish_ = nil
			arg_717_1.state_ = "waiting"
		end

		function arg_717_1.playNext_(arg_719_0)
			if arg_719_0 == 1 then
				arg_717_0:Play222031178(arg_717_1)
			end
		end

		function arg_717_1.onSingleLineUpdate_(arg_720_0)
			local var_720_0 = arg_717_1.actors_["1070ui_story"]
			local var_720_1 = 0

			if var_720_1 < arg_717_1.time_ and arg_717_1.time_ <= var_720_1 + arg_720_0 and not isNil(var_720_0) and arg_717_1.var_.characterEffect1070ui_story == nil then
				arg_717_1.var_.characterEffect1070ui_story = var_720_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_720_2 = 0.200000002980232

			if var_720_1 <= arg_717_1.time_ and arg_717_1.time_ < var_720_1 + var_720_2 and not isNil(var_720_0) then
				local var_720_3 = (arg_717_1.time_ - var_720_1) / var_720_2

				if arg_717_1.var_.characterEffect1070ui_story and not isNil(var_720_0) then
					local var_720_4 = Mathf.Lerp(0, 0.5, var_720_3)

					arg_717_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_717_1.var_.characterEffect1070ui_story.fillRatio = var_720_4
				end
			end

			if arg_717_1.time_ >= var_720_1 + var_720_2 and arg_717_1.time_ < var_720_1 + var_720_2 + arg_720_0 and not isNil(var_720_0) and arg_717_1.var_.characterEffect1070ui_story then
				local var_720_5 = 0.5

				arg_717_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_717_1.var_.characterEffect1070ui_story.fillRatio = var_720_5
			end

			local var_720_6 = 0
			local var_720_7 = 1.225

			if var_720_6 < arg_717_1.time_ and arg_717_1.time_ <= var_720_6 + arg_720_0 then
				arg_717_1.talkMaxDuration = 0
				arg_717_1.dialogCg_.alpha = 1

				arg_717_1.dialog_:SetActive(true)
				SetActive(arg_717_1.leftNameGo_, false)

				arg_717_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_717_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_717_1:RecordName(arg_717_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_717_1.iconTrs_.gameObject, false)
				arg_717_1.callingController_:SetSelectedState("normal")

				local var_720_8 = arg_717_1:GetWordFromCfg(222031177)
				local var_720_9 = arg_717_1:FormatText(var_720_8.content)

				arg_717_1.text_.text = var_720_9

				LuaForUtil.ClearLinePrefixSymbol(arg_717_1.text_)

				local var_720_10 = 49
				local var_720_11 = utf8.len(var_720_9)
				local var_720_12 = var_720_10 <= 0 and var_720_7 or var_720_7 * (var_720_11 / var_720_10)

				if var_720_12 > 0 and var_720_7 < var_720_12 then
					arg_717_1.talkMaxDuration = var_720_12

					if var_720_12 + var_720_6 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_12 + var_720_6
					end
				end

				arg_717_1.text_.text = var_720_9
				arg_717_1.typewritter.percent = 0

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(false)
				arg_717_1:RecordContent(arg_717_1.text_.text)
			end

			local var_720_13 = math.max(var_720_7, arg_717_1.talkMaxDuration)

			if var_720_6 <= arg_717_1.time_ and arg_717_1.time_ < var_720_6 + var_720_13 then
				arg_717_1.typewritter.percent = (arg_717_1.time_ - var_720_6) / var_720_13

				arg_717_1.typewritter:SetDirty()
			end

			if arg_717_1.time_ >= var_720_6 + var_720_13 and arg_717_1.time_ < var_720_6 + var_720_13 + arg_720_0 then
				arg_717_1.typewritter.percent = 1

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(true)
			end
		end

		arg_717_1.nodeConfigList_ = {}

		arg_717_1:InitPlayNodeList()
	end,
	Play222031178 = function(arg_721_0, arg_721_1)
		arg_721_1.time_ = 0
		arg_721_1.frameCnt_ = 0
		arg_721_1.state_ = "playing"
		arg_721_1.curTalkId_ = 222031178
		arg_721_1.duration_ = 2.5

		local var_721_0 = {
			ja = 2.5,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_721_1 = manager.audio:GetLocalizationFlag()

		if var_721_0[var_721_1] ~= nil then
			arg_721_1.duration_ = var_721_0[var_721_1]
		end

		SetActive(arg_721_1.tipsGo_, false)

		function arg_721_1.onSingleLineFinish_()
			arg_721_1.onSingleLineUpdate_ = nil
			arg_721_1.onSingleLineFinish_ = nil
			arg_721_1.state_ = "waiting"
			arg_721_1.auto_ = false
		end

		function arg_721_1.playNext_(arg_723_0)
			arg_721_1.onStoryFinished_()
		end

		function arg_721_1.onSingleLineUpdate_(arg_724_0)
			local var_724_0 = arg_721_1.actors_["1070ui_story"]
			local var_724_1 = 0

			if var_724_1 < arg_721_1.time_ and arg_721_1.time_ <= var_724_1 + arg_724_0 and not isNil(var_724_0) and arg_721_1.var_.characterEffect1070ui_story == nil then
				arg_721_1.var_.characterEffect1070ui_story = var_724_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_724_2 = 0.200000002980232

			if var_724_1 <= arg_721_1.time_ and arg_721_1.time_ < var_724_1 + var_724_2 and not isNil(var_724_0) then
				local var_724_3 = (arg_721_1.time_ - var_724_1) / var_724_2

				if arg_721_1.var_.characterEffect1070ui_story and not isNil(var_724_0) then
					arg_721_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_721_1.time_ >= var_724_1 + var_724_2 and arg_721_1.time_ < var_724_1 + var_724_2 + arg_724_0 and not isNil(var_724_0) and arg_721_1.var_.characterEffect1070ui_story then
				arg_721_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_724_4 = 0

			if var_724_4 < arg_721_1.time_ and arg_721_1.time_ <= var_724_4 + arg_724_0 then
				arg_721_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			local var_724_5 = 0

			if var_724_5 < arg_721_1.time_ and arg_721_1.time_ <= var_724_5 + arg_724_0 then
				arg_721_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_724_6 = 0
			local var_724_7 = 0.2

			if var_724_6 < arg_721_1.time_ and arg_721_1.time_ <= var_724_6 + arg_724_0 then
				arg_721_1.talkMaxDuration = 0
				arg_721_1.dialogCg_.alpha = 1

				arg_721_1.dialog_:SetActive(true)
				SetActive(arg_721_1.leftNameGo_, true)

				local var_724_8 = arg_721_1:FormatText(StoryNameCfg[318].name)

				arg_721_1.leftNameTxt_.text = var_724_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_721_1.leftNameTxt_.transform)

				arg_721_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_721_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_721_1:RecordName(arg_721_1.leftNameTxt_.text)
				SetActive(arg_721_1.iconTrs_.gameObject, false)
				arg_721_1.callingController_:SetSelectedState("normal")

				local var_724_9 = arg_721_1:GetWordFromCfg(222031178)
				local var_724_10 = arg_721_1:FormatText(var_724_9.content)

				arg_721_1.text_.text = var_724_10

				LuaForUtil.ClearLinePrefixSymbol(arg_721_1.text_)

				local var_724_11 = 8
				local var_724_12 = utf8.len(var_724_10)
				local var_724_13 = var_724_11 <= 0 and var_724_7 or var_724_7 * (var_724_12 / var_724_11)

				if var_724_13 > 0 and var_724_7 < var_724_13 then
					arg_721_1.talkMaxDuration = var_724_13

					if var_724_13 + var_724_6 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_13 + var_724_6
					end
				end

				arg_721_1.text_.text = var_724_10
				arg_721_1.typewritter.percent = 0

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222031", "222031178", "story_v_out_222031.awb") ~= 0 then
					local var_724_14 = manager.audio:GetVoiceLength("story_v_out_222031", "222031178", "story_v_out_222031.awb") / 1000

					if var_724_14 + var_724_6 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_14 + var_724_6
					end

					if var_724_9.prefab_name ~= "" and arg_721_1.actors_[var_724_9.prefab_name] ~= nil then
						local var_724_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_721_1.actors_[var_724_9.prefab_name].transform, "story_v_out_222031", "222031178", "story_v_out_222031.awb")

						arg_721_1:RecordAudio("222031178", var_724_15)
						arg_721_1:RecordAudio("222031178", var_724_15)
					else
						arg_721_1:AudioAction("play", "voice", "story_v_out_222031", "222031178", "story_v_out_222031.awb")
					end

					arg_721_1:RecordHistoryTalkVoice("story_v_out_222031", "222031178", "story_v_out_222031.awb")
				end

				arg_721_1:RecordContent(arg_721_1.text_.text)
			end

			local var_724_16 = math.max(var_724_7, arg_721_1.talkMaxDuration)

			if var_724_6 <= arg_721_1.time_ and arg_721_1.time_ < var_724_6 + var_724_16 then
				arg_721_1.typewritter.percent = (arg_721_1.time_ - var_724_6) / var_724_16

				arg_721_1.typewritter:SetDirty()
			end

			if arg_721_1.time_ >= var_724_6 + var_724_16 and arg_721_1.time_ < var_724_6 + var_724_16 + arg_724_0 then
				arg_721_1.typewritter.percent = 1

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(true)
			end
		end

		arg_721_1.nodeConfigList_ = {}

		arg_721_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST31a",
		"TextureConfig/Background/ST39a",
		"TextureConfig/Background/ST37a"
	},
	voices = {
		"story_v_out_222031.awb"
	}
}
