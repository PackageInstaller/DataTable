return {
	Play114171001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114171001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play114171002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F07"

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
				local var_4_5 = arg_1_1.bgs_.F07

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
					if iter_4_0 ~= "F07" then
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

			local var_4_28 = 2
			local var_4_29 = 1.6

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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
			local var_4_35 = 1.25

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

				local var_4_37 = arg_1_1:GetWordFromCfg(114171001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 50
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
	Play114171002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114171002
		arg_9_1.duration_ = 11.23

		local var_9_0 = {
			ja = 9.333,
			ko = 7.2,
			zh = 9.933,
			en = 11.233
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play114171003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.025

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[225].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(114171002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171002", "story_v_out_114171.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_114171", "114171002", "story_v_out_114171.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_114171", "114171002", "story_v_out_114171.awb")

						arg_9_1:RecordAudio("114171002", var_12_9)
						arg_9_1:RecordAudio("114171002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_114171", "114171002", "story_v_out_114171.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_114171", "114171002", "story_v_out_114171.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_10 and arg_9_1.time_ < var_12_0 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play114171003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114171003
		arg_13_1.duration_ = 2

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play114171004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1041ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1041ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["1041ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1041ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(-0.7, -1.11, -5.9)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1041ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = 0

			if var_16_14 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				arg_13_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_16_16 = arg_13_1.actors_["1041ui_story"]
			local var_16_17 = 0

			if var_16_17 < arg_13_1.time_ and arg_13_1.time_ <= var_16_17 + arg_16_0 and not isNil(var_16_16) and arg_13_1.var_.characterEffect1041ui_story == nil then
				arg_13_1.var_.characterEffect1041ui_story = var_16_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_18 = 0.2

			if var_16_17 <= arg_13_1.time_ and arg_13_1.time_ < var_16_17 + var_16_18 and not isNil(var_16_16) then
				local var_16_19 = (arg_13_1.time_ - var_16_17) / var_16_18

				if arg_13_1.var_.characterEffect1041ui_story and not isNil(var_16_16) then
					arg_13_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_17 + var_16_18 and arg_13_1.time_ < var_16_17 + var_16_18 + arg_16_0 and not isNil(var_16_16) and arg_13_1.var_.characterEffect1041ui_story then
				arg_13_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_16_20 = 0
			local var_16_21 = 0.1

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[208].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(114171003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171003", "story_v_out_114171.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_out_114171", "114171003", "story_v_out_114171.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_out_114171", "114171003", "story_v_out_114171.awb")

						arg_13_1:RecordAudio("114171003", var_16_29)
						arg_13_1:RecordAudio("114171003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_114171", "114171003", "story_v_out_114171.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_114171", "114171003", "story_v_out_114171.awb")
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
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play114171004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114171004
		arg_17_1.duration_ = 10.43

		local var_17_0 = {
			ja = 8.7,
			ko = 10.433,
			zh = 9.966,
			en = 10.233
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
				arg_17_0:Play114171005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1041ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1041ui_story == nil then
				arg_17_1.var_.characterEffect1041ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1041ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1041ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1041ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1041ui_story.fillRatio = var_20_5
			end

			local var_20_6 = "1038ui_story"

			if arg_17_1.actors_[var_20_6] == nil then
				local var_20_7 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_20_7) then
					local var_20_8 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_17_1.stage_.transform)

					var_20_8.name = var_20_6
					var_20_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_6] = var_20_8

					local var_20_9 = var_20_8:GetComponentInChildren(typeof(CharacterEffect))

					var_20_9.enabled = true

					local var_20_10 = GameObjectTools.GetOrAddComponent(var_20_8, typeof(DynamicBoneHelper))

					if var_20_10 then
						var_20_10:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_9.transform, false)

					arg_17_1.var_[var_20_6 .. "Animator"] = var_20_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_6 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_6 .. "LipSync"] = var_20_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_11 = arg_17_1.actors_["1038ui_story"].transform
			local var_20_12 = 0

			if var_20_12 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.var_.moveOldPos1038ui_story = var_20_11.localPosition
			end

			local var_20_13 = 0.001

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_13 then
				local var_20_14 = (arg_17_1.time_ - var_20_12) / var_20_13
				local var_20_15 = Vector3.New(0.7, -1.11, -5.9)

				var_20_11.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1038ui_story, var_20_15, var_20_14)

				local var_20_16 = manager.ui.mainCamera.transform.position - var_20_11.position

				var_20_11.forward = Vector3.New(var_20_16.x, var_20_16.y, var_20_16.z)

				local var_20_17 = var_20_11.localEulerAngles

				var_20_17.z = 0
				var_20_17.x = 0
				var_20_11.localEulerAngles = var_20_17
			end

			if arg_17_1.time_ >= var_20_12 + var_20_13 and arg_17_1.time_ < var_20_12 + var_20_13 + arg_20_0 then
				var_20_11.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_20_18 = manager.ui.mainCamera.transform.position - var_20_11.position

				var_20_11.forward = Vector3.New(var_20_18.x, var_20_18.y, var_20_18.z)

				local var_20_19 = var_20_11.localEulerAngles

				var_20_19.z = 0
				var_20_19.x = 0
				var_20_11.localEulerAngles = var_20_19
			end

			local var_20_20 = 0

			if var_20_20 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				arg_17_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action7_1")
			end

			local var_20_21 = 0

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_20_22 = arg_17_1.actors_["1038ui_story"]
			local var_20_23 = 0

			if var_20_23 < arg_17_1.time_ and arg_17_1.time_ <= var_20_23 + arg_20_0 and not isNil(var_20_22) and arg_17_1.var_.characterEffect1038ui_story == nil then
				arg_17_1.var_.characterEffect1038ui_story = var_20_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_24 = 0.2

			if var_20_23 <= arg_17_1.time_ and arg_17_1.time_ < var_20_23 + var_20_24 and not isNil(var_20_22) then
				local var_20_25 = (arg_17_1.time_ - var_20_23) / var_20_24

				if arg_17_1.var_.characterEffect1038ui_story and not isNil(var_20_22) then
					arg_17_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_23 + var_20_24 and arg_17_1.time_ < var_20_23 + var_20_24 + arg_20_0 and not isNil(var_20_22) and arg_17_1.var_.characterEffect1038ui_story then
				arg_17_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_20_26 = 0
			local var_20_27 = 1

			if var_20_26 < arg_17_1.time_ and arg_17_1.time_ <= var_20_26 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_28 = arg_17_1:FormatText(StoryNameCfg[94].name)

				arg_17_1.leftNameTxt_.text = var_20_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_29 = arg_17_1:GetWordFromCfg(114171004)
				local var_20_30 = arg_17_1:FormatText(var_20_29.content)

				arg_17_1.text_.text = var_20_30

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_31 = 40
				local var_20_32 = utf8.len(var_20_30)
				local var_20_33 = var_20_31 <= 0 and var_20_27 or var_20_27 * (var_20_32 / var_20_31)

				if var_20_33 > 0 and var_20_27 < var_20_33 then
					arg_17_1.talkMaxDuration = var_20_33

					if var_20_33 + var_20_26 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_33 + var_20_26
					end
				end

				arg_17_1.text_.text = var_20_30
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171004", "story_v_out_114171.awb") ~= 0 then
					local var_20_34 = manager.audio:GetVoiceLength("story_v_out_114171", "114171004", "story_v_out_114171.awb") / 1000

					if var_20_34 + var_20_26 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_34 + var_20_26
					end

					if var_20_29.prefab_name ~= "" and arg_17_1.actors_[var_20_29.prefab_name] ~= nil then
						local var_20_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_29.prefab_name].transform, "story_v_out_114171", "114171004", "story_v_out_114171.awb")

						arg_17_1:RecordAudio("114171004", var_20_35)
						arg_17_1:RecordAudio("114171004", var_20_35)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_114171", "114171004", "story_v_out_114171.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_114171", "114171004", "story_v_out_114171.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_36 = math.max(var_20_27, arg_17_1.talkMaxDuration)

			if var_20_26 <= arg_17_1.time_ and arg_17_1.time_ < var_20_26 + var_20_36 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_26) / var_20_36

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_26 + var_20_36 and arg_17_1.time_ < var_20_26 + var_20_36 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play114171005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114171005
		arg_21_1.duration_ = 12.37

		local var_21_0 = {
			ja = 10.333,
			ko = 11.733,
			zh = 12.366,
			en = 12.133
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
				arg_21_0:Play114171006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1038ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1038ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1038ui_story, var_24_4, var_24_3)

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

			local var_24_9 = arg_21_1.actors_["1041ui_story"].transform
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.var_.moveOldPos1041ui_story = var_24_9.localPosition
			end

			local var_24_11 = 0.001

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11
				local var_24_13 = Vector3.New(0, 100, 0)

				var_24_9.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1041ui_story, var_24_13, var_24_12)

				local var_24_14 = manager.ui.mainCamera.transform.position - var_24_9.position

				var_24_9.forward = Vector3.New(var_24_14.x, var_24_14.y, var_24_14.z)

				local var_24_15 = var_24_9.localEulerAngles

				var_24_15.z = 0
				var_24_15.x = 0
				var_24_9.localEulerAngles = var_24_15
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 then
				var_24_9.localPosition = Vector3.New(0, 100, 0)

				local var_24_16 = manager.ui.mainCamera.transform.position - var_24_9.position

				var_24_9.forward = Vector3.New(var_24_16.x, var_24_16.y, var_24_16.z)

				local var_24_17 = var_24_9.localEulerAngles

				var_24_17.z = 0
				var_24_17.x = 0
				var_24_9.localEulerAngles = var_24_17
			end

			local var_24_18 = 0
			local var_24_19 = 1.275

			if var_24_18 < arg_21_1.time_ and arg_21_1.time_ <= var_24_18 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_20 = arg_21_1:FormatText(StoryNameCfg[225].name)

				arg_21_1.leftNameTxt_.text = var_24_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_21 = arg_21_1:GetWordFromCfg(114171005)
				local var_24_22 = arg_21_1:FormatText(var_24_21.content)

				arg_21_1.text_.text = var_24_22

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_23 = 51
				local var_24_24 = utf8.len(var_24_22)
				local var_24_25 = var_24_23 <= 0 and var_24_19 or var_24_19 * (var_24_24 / var_24_23)

				if var_24_25 > 0 and var_24_19 < var_24_25 then
					arg_21_1.talkMaxDuration = var_24_25

					if var_24_25 + var_24_18 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_25 + var_24_18
					end
				end

				arg_21_1.text_.text = var_24_22
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171005", "story_v_out_114171.awb") ~= 0 then
					local var_24_26 = manager.audio:GetVoiceLength("story_v_out_114171", "114171005", "story_v_out_114171.awb") / 1000

					if var_24_26 + var_24_18 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_26 + var_24_18
					end

					if var_24_21.prefab_name ~= "" and arg_21_1.actors_[var_24_21.prefab_name] ~= nil then
						local var_24_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_21.prefab_name].transform, "story_v_out_114171", "114171005", "story_v_out_114171.awb")

						arg_21_1:RecordAudio("114171005", var_24_27)
						arg_21_1:RecordAudio("114171005", var_24_27)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_114171", "114171005", "story_v_out_114171.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_114171", "114171005", "story_v_out_114171.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_28 = math.max(var_24_19, arg_21_1.talkMaxDuration)

			if var_24_18 <= arg_21_1.time_ and arg_21_1.time_ < var_24_18 + var_24_28 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_18) / var_24_28

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_18 + var_24_28 and arg_21_1.time_ < var_24_18 + var_24_28 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play114171006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114171006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play114171007(arg_25_1)
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

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_2

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

				local var_28_3 = arg_25_1:GetWordFromCfg(114171006)
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
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play114171007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114171007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play114171008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.475

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

				local var_32_2 = arg_29_1:GetWordFromCfg(114171007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 19
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
	Play114171008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114171008
		arg_33_1.duration_ = 10.87

		local var_33_0 = {
			ja = 10.866,
			ko = 6.966,
			zh = 9.066,
			en = 8.1
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
				arg_33_0:Play114171009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = "10005ui_story"

			if arg_33_1.actors_[var_36_0] == nil then
				local var_36_1 = Asset.Load("Char/" .. "10005ui_story")

				if not isNil(var_36_1) then
					local var_36_2 = Object.Instantiate(Asset.Load("Char/" .. "10005ui_story"), arg_33_1.stage_.transform)

					var_36_2.name = var_36_0
					var_36_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_33_1.actors_[var_36_0] = var_36_2

					local var_36_3 = var_36_2:GetComponentInChildren(typeof(CharacterEffect))

					var_36_3.enabled = true

					local var_36_4 = GameObjectTools.GetOrAddComponent(var_36_2, typeof(DynamicBoneHelper))

					if var_36_4 then
						var_36_4:EnableDynamicBone(false)
					end

					arg_33_1:ShowWeapon(var_36_3.transform, false)

					arg_33_1.var_[var_36_0 .. "Animator"] = var_36_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_33_1.var_[var_36_0 .. "Animator"].applyRootMotion = true
					arg_33_1.var_[var_36_0 .. "LipSync"] = var_36_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_36_5 = arg_33_1.actors_["10005ui_story"].transform
			local var_36_6 = 0

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.var_.moveOldPos10005ui_story = var_36_5.localPosition
			end

			local var_36_7 = 0.001

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_7 then
				local var_36_8 = (arg_33_1.time_ - var_36_6) / var_36_7
				local var_36_9 = Vector3.New(0, -0.95, -5.88)

				var_36_5.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10005ui_story, var_36_9, var_36_8)

				local var_36_10 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_10.x, var_36_10.y, var_36_10.z)

				local var_36_11 = var_36_5.localEulerAngles

				var_36_11.z = 0
				var_36_11.x = 0
				var_36_5.localEulerAngles = var_36_11
			end

			if arg_33_1.time_ >= var_36_6 + var_36_7 and arg_33_1.time_ < var_36_6 + var_36_7 + arg_36_0 then
				var_36_5.localPosition = Vector3.New(0, -0.95, -5.88)

				local var_36_12 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_12.x, var_36_12.y, var_36_12.z)

				local var_36_13 = var_36_5.localEulerAngles

				var_36_13.z = 0
				var_36_13.x = 0
				var_36_5.localEulerAngles = var_36_13
			end

			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action5_1")
			end

			local var_36_15 = 0

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_36_16 = "10005_tpose"

			if arg_33_1.actors_[var_36_16] == nil then
				local var_36_17 = Asset.Load("Char/" .. "10005_tpose")

				if not isNil(var_36_17) then
					local var_36_18 = Object.Instantiate(Asset.Load("Char/" .. "10005_tpose"), arg_33_1.stage_.transform)

					var_36_18.name = var_36_16
					var_36_18.transform.localPosition = Vector3.New(0, 100, 0)
					arg_33_1.actors_[var_36_16] = var_36_18

					local var_36_19 = var_36_18:GetComponentInChildren(typeof(CharacterEffect))

					var_36_19.enabled = true

					local var_36_20 = GameObjectTools.GetOrAddComponent(var_36_18, typeof(DynamicBoneHelper))

					if var_36_20 then
						var_36_20:EnableDynamicBone(false)
					end

					arg_33_1:ShowWeapon(var_36_19.transform, false)

					arg_33_1.var_[var_36_16 .. "Animator"] = var_36_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_33_1.var_[var_36_16 .. "Animator"].applyRootMotion = true
					arg_33_1.var_[var_36_16 .. "LipSync"] = var_36_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_36_21 = arg_33_1.actors_["10005_tpose"]
			local var_36_22 = 0

			if var_36_22 < arg_33_1.time_ and arg_33_1.time_ <= var_36_22 + arg_36_0 and not isNil(var_36_21) and arg_33_1.var_.characterEffect10005_tpose == nil then
				arg_33_1.var_.characterEffect10005_tpose = var_36_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_23 = 0.2

			if var_36_22 <= arg_33_1.time_ and arg_33_1.time_ < var_36_22 + var_36_23 and not isNil(var_36_21) then
				local var_36_24 = (arg_33_1.time_ - var_36_22) / var_36_23

				if arg_33_1.var_.characterEffect10005_tpose and not isNil(var_36_21) then
					arg_33_1.var_.characterEffect10005_tpose.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_22 + var_36_23 and arg_33_1.time_ < var_36_22 + var_36_23 + arg_36_0 and not isNil(var_36_21) and arg_33_1.var_.characterEffect10005_tpose then
				arg_33_1.var_.characterEffect10005_tpose.fillFlat = false
			end

			local var_36_25 = 0
			local var_36_26 = 0.9

			if var_36_25 < arg_33_1.time_ and arg_33_1.time_ <= var_36_25 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_27 = arg_33_1:FormatText(StoryNameCfg[225].name)

				arg_33_1.leftNameTxt_.text = var_36_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_28 = arg_33_1:GetWordFromCfg(114171008)
				local var_36_29 = arg_33_1:FormatText(var_36_28.content)

				arg_33_1.text_.text = var_36_29

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_30 = 36
				local var_36_31 = utf8.len(var_36_29)
				local var_36_32 = var_36_30 <= 0 and var_36_26 or var_36_26 * (var_36_31 / var_36_30)

				if var_36_32 > 0 and var_36_26 < var_36_32 then
					arg_33_1.talkMaxDuration = var_36_32

					if var_36_32 + var_36_25 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_32 + var_36_25
					end
				end

				arg_33_1.text_.text = var_36_29
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171008", "story_v_out_114171.awb") ~= 0 then
					local var_36_33 = manager.audio:GetVoiceLength("story_v_out_114171", "114171008", "story_v_out_114171.awb") / 1000

					if var_36_33 + var_36_25 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_33 + var_36_25
					end

					if var_36_28.prefab_name ~= "" and arg_33_1.actors_[var_36_28.prefab_name] ~= nil then
						local var_36_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_28.prefab_name].transform, "story_v_out_114171", "114171008", "story_v_out_114171.awb")

						arg_33_1:RecordAudio("114171008", var_36_34)
						arg_33_1:RecordAudio("114171008", var_36_34)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_114171", "114171008", "story_v_out_114171.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_114171", "114171008", "story_v_out_114171.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_35 = math.max(var_36_26, arg_33_1.talkMaxDuration)

			if var_36_25 <= arg_33_1.time_ and arg_33_1.time_ < var_36_25 + var_36_35 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_25) / var_36_35

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_25 + var_36_35 and arg_33_1.time_ < var_36_25 + var_36_35 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play114171009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114171009
		arg_37_1.duration_ = 6.97

		local var_37_0 = {
			ja = 5.9,
			ko = 6.966,
			zh = 6.733,
			en = 5.433
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
				arg_37_0:Play114171010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action5_2")
			end

			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_40_2 = 0
			local var_40_3 = 0.775

			if var_40_2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_4 = arg_37_1:FormatText(StoryNameCfg[225].name)

				arg_37_1.leftNameTxt_.text = var_40_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_5 = arg_37_1:GetWordFromCfg(114171009)
				local var_40_6 = arg_37_1:FormatText(var_40_5.content)

				arg_37_1.text_.text = var_40_6

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171009", "story_v_out_114171.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_114171", "114171009", "story_v_out_114171.awb") / 1000

					if var_40_10 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_2
					end

					if var_40_5.prefab_name ~= "" and arg_37_1.actors_[var_40_5.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_5.prefab_name].transform, "story_v_out_114171", "114171009", "story_v_out_114171.awb")

						arg_37_1:RecordAudio("114171009", var_40_11)
						arg_37_1:RecordAudio("114171009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_114171", "114171009", "story_v_out_114171.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_114171", "114171009", "story_v_out_114171.awb")
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
	Play114171010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114171010
		arg_41_1.duration_ = 3.37

		local var_41_0 = {
			ja = 2.366,
			ko = 3.333,
			zh = 3.366,
			en = 2.4
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
				arg_41_0:Play114171011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10005ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10005ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(0, 100, 0)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10005ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0, 100, 0)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = "10006ui_story"

			if arg_41_1.actors_[var_44_9] == nil then
				local var_44_10 = Asset.Load("Char/" .. "10006ui_story")

				if not isNil(var_44_10) then
					local var_44_11 = Object.Instantiate(Asset.Load("Char/" .. "10006ui_story"), arg_41_1.stage_.transform)

					var_44_11.name = var_44_9
					var_44_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_41_1.actors_[var_44_9] = var_44_11

					local var_44_12 = var_44_11:GetComponentInChildren(typeof(CharacterEffect))

					var_44_12.enabled = true

					local var_44_13 = GameObjectTools.GetOrAddComponent(var_44_11, typeof(DynamicBoneHelper))

					if var_44_13 then
						var_44_13:EnableDynamicBone(false)
					end

					arg_41_1:ShowWeapon(var_44_12.transform, false)

					arg_41_1.var_[var_44_9 .. "Animator"] = var_44_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_41_1.var_[var_44_9 .. "Animator"].applyRootMotion = true
					arg_41_1.var_[var_44_9 .. "LipSync"] = var_44_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_44_14 = arg_41_1.actors_["10006ui_story"].transform
			local var_44_15 = 0

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.var_.moveOldPos10006ui_story = var_44_14.localPosition
			end

			local var_44_16 = 0.001

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_16 then
				local var_44_17 = (arg_41_1.time_ - var_44_15) / var_44_16
				local var_44_18 = Vector3.New(0, -0.98, -5.65)

				var_44_14.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10006ui_story, var_44_18, var_44_17)

				local var_44_19 = manager.ui.mainCamera.transform.position - var_44_14.position

				var_44_14.forward = Vector3.New(var_44_19.x, var_44_19.y, var_44_19.z)

				local var_44_20 = var_44_14.localEulerAngles

				var_44_20.z = 0
				var_44_20.x = 0
				var_44_14.localEulerAngles = var_44_20
			end

			if arg_41_1.time_ >= var_44_15 + var_44_16 and arg_41_1.time_ < var_44_15 + var_44_16 + arg_44_0 then
				var_44_14.localPosition = Vector3.New(0, -0.98, -5.65)

				local var_44_21 = manager.ui.mainCamera.transform.position - var_44_14.position

				var_44_14.forward = Vector3.New(var_44_21.x, var_44_21.y, var_44_21.z)

				local var_44_22 = var_44_14.localEulerAngles

				var_44_22.z = 0
				var_44_22.x = 0
				var_44_14.localEulerAngles = var_44_22
			end

			local var_44_23 = 0

			if var_44_23 < arg_41_1.time_ and arg_41_1.time_ <= var_44_23 + arg_44_0 then
				arg_41_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action1_1")
			end

			local var_44_24 = 0

			if var_44_24 < arg_41_1.time_ and arg_41_1.time_ <= var_44_24 + arg_44_0 then
				arg_41_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_44_25 = arg_41_1.actors_["10006ui_story"]
			local var_44_26 = 0

			if var_44_26 < arg_41_1.time_ and arg_41_1.time_ <= var_44_26 + arg_44_0 and not isNil(var_44_25) and arg_41_1.var_.characterEffect10006ui_story == nil then
				arg_41_1.var_.characterEffect10006ui_story = var_44_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_27 = 0.2

			if var_44_26 <= arg_41_1.time_ and arg_41_1.time_ < var_44_26 + var_44_27 and not isNil(var_44_25) then
				local var_44_28 = (arg_41_1.time_ - var_44_26) / var_44_27

				if arg_41_1.var_.characterEffect10006ui_story and not isNil(var_44_25) then
					arg_41_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_26 + var_44_27 and arg_41_1.time_ < var_44_26 + var_44_27 + arg_44_0 and not isNil(var_44_25) and arg_41_1.var_.characterEffect10006ui_story then
				arg_41_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_44_29 = 0
			local var_44_30 = 0.25

			if var_44_29 < arg_41_1.time_ and arg_41_1.time_ <= var_44_29 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_31 = arg_41_1:FormatText(StoryNameCfg[212].name)

				arg_41_1.leftNameTxt_.text = var_44_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_32 = arg_41_1:GetWordFromCfg(114171010)
				local var_44_33 = arg_41_1:FormatText(var_44_32.content)

				arg_41_1.text_.text = var_44_33

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_34 = 10
				local var_44_35 = utf8.len(var_44_33)
				local var_44_36 = var_44_34 <= 0 and var_44_30 or var_44_30 * (var_44_35 / var_44_34)

				if var_44_36 > 0 and var_44_30 < var_44_36 then
					arg_41_1.talkMaxDuration = var_44_36

					if var_44_36 + var_44_29 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_36 + var_44_29
					end
				end

				arg_41_1.text_.text = var_44_33
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171010", "story_v_out_114171.awb") ~= 0 then
					local var_44_37 = manager.audio:GetVoiceLength("story_v_out_114171", "114171010", "story_v_out_114171.awb") / 1000

					if var_44_37 + var_44_29 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_37 + var_44_29
					end

					if var_44_32.prefab_name ~= "" and arg_41_1.actors_[var_44_32.prefab_name] ~= nil then
						local var_44_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_32.prefab_name].transform, "story_v_out_114171", "114171010", "story_v_out_114171.awb")

						arg_41_1:RecordAudio("114171010", var_44_38)
						arg_41_1:RecordAudio("114171010", var_44_38)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_114171", "114171010", "story_v_out_114171.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_114171", "114171010", "story_v_out_114171.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_39 = math.max(var_44_30, arg_41_1.talkMaxDuration)

			if var_44_29 <= arg_41_1.time_ and arg_41_1.time_ < var_44_29 + var_44_39 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_29) / var_44_39

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_29 + var_44_39 and arg_41_1.time_ < var_44_29 + var_44_39 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play114171011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114171011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play114171012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10006ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10006ui_story == nil then
				arg_45_1.var_.characterEffect10006ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect10006ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10006ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10006ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10006ui_story.fillRatio = var_48_5
			end

			local var_48_6 = 0
			local var_48_7 = 0.925

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:GetWordFromCfg(114171011)
				local var_48_9 = arg_45_1:FormatText(var_48_8.content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 37
				local var_48_11 = utf8.len(var_48_9)
				local var_48_12 = var_48_10 <= 0 and var_48_7 or var_48_7 * (var_48_11 / var_48_10)

				if var_48_12 > 0 and var_48_7 < var_48_12 then
					arg_45_1.talkMaxDuration = var_48_12

					if var_48_12 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_9
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_13 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_13 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_13

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_13 and arg_45_1.time_ < var_48_6 + var_48_13 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play114171012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114171012
		arg_49_1.duration_ = 4.43

		local var_49_0 = {
			ja = 3.833,
			ko = 4.433,
			zh = 3.733,
			en = 3.1
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
				arg_49_0:Play114171013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action6_1")
			end

			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_52_2 = arg_49_1.actors_["10006ui_story"]
			local var_52_3 = 0

			if var_52_3 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect10006ui_story == nil then
				arg_49_1.var_.characterEffect10006ui_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_4 = 0.2

			if var_52_3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_3 + var_52_4 and not isNil(var_52_2) then
				local var_52_5 = (arg_49_1.time_ - var_52_3) / var_52_4

				if arg_49_1.var_.characterEffect10006ui_story and not isNil(var_52_2) then
					arg_49_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_3 + var_52_4 and arg_49_1.time_ < var_52_3 + var_52_4 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect10006ui_story then
				arg_49_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_52_6 = 0
			local var_52_7 = 0.325

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[212].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_9 = arg_49_1:GetWordFromCfg(114171012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 13
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_7 or var_52_7 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_7 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171012", "story_v_out_114171.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_114171", "114171012", "story_v_out_114171.awb") / 1000

					if var_52_14 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_6
					end

					if var_52_9.prefab_name ~= "" and arg_49_1.actors_[var_52_9.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_9.prefab_name].transform, "story_v_out_114171", "114171012", "story_v_out_114171.awb")

						arg_49_1:RecordAudio("114171012", var_52_15)
						arg_49_1:RecordAudio("114171012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_114171", "114171012", "story_v_out_114171.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_114171", "114171012", "story_v_out_114171.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_16 and arg_49_1.time_ < var_52_6 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play114171013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114171013
		arg_53_1.duration_ = 2.8

		local var_53_0 = {
			ja = 2.8,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_53_0:Play114171014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10006ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos10006ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, 100, 0)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10006ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, 100, 0)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = arg_53_1.actors_["10005ui_story"].transform
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1.var_.moveOldPos10005ui_story = var_56_9.localPosition
			end

			local var_56_11 = 0.001

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 then
				local var_56_12 = (arg_53_1.time_ - var_56_10) / var_56_11
				local var_56_13 = Vector3.New(0, -0.95, -5.88)

				var_56_9.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10005ui_story, var_56_13, var_56_12)

				local var_56_14 = manager.ui.mainCamera.transform.position - var_56_9.position

				var_56_9.forward = Vector3.New(var_56_14.x, var_56_14.y, var_56_14.z)

				local var_56_15 = var_56_9.localEulerAngles

				var_56_15.z = 0
				var_56_15.x = 0
				var_56_9.localEulerAngles = var_56_15
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 then
				var_56_9.localPosition = Vector3.New(0, -0.95, -5.88)

				local var_56_16 = manager.ui.mainCamera.transform.position - var_56_9.position

				var_56_9.forward = Vector3.New(var_56_16.x, var_56_16.y, var_56_16.z)

				local var_56_17 = var_56_9.localEulerAngles

				var_56_17.z = 0
				var_56_17.x = 0
				var_56_9.localEulerAngles = var_56_17
			end

			local var_56_18 = 0

			if var_56_18 < arg_53_1.time_ and arg_53_1.time_ <= var_56_18 + arg_56_0 then
				arg_53_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action1_1")
			end

			local var_56_19 = arg_53_1.actors_["10005_tpose"]
			local var_56_20 = 0

			if var_56_20 < arg_53_1.time_ and arg_53_1.time_ <= var_56_20 + arg_56_0 and not isNil(var_56_19) and arg_53_1.var_.characterEffect10005_tpose == nil then
				arg_53_1.var_.characterEffect10005_tpose = var_56_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_21 = 0.2

			if var_56_20 <= arg_53_1.time_ and arg_53_1.time_ < var_56_20 + var_56_21 and not isNil(var_56_19) then
				local var_56_22 = (arg_53_1.time_ - var_56_20) / var_56_21

				if arg_53_1.var_.characterEffect10005_tpose and not isNil(var_56_19) then
					arg_53_1.var_.characterEffect10005_tpose.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_20 + var_56_21 and arg_53_1.time_ < var_56_20 + var_56_21 + arg_56_0 and not isNil(var_56_19) and arg_53_1.var_.characterEffect10005_tpose then
				arg_53_1.var_.characterEffect10005_tpose.fillFlat = false
			end

			local var_56_23 = 0

			if var_56_23 < arg_53_1.time_ and arg_53_1.time_ <= var_56_23 + arg_56_0 then
				arg_53_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_56_24 = 0
			local var_56_25 = 0.125

			if var_56_24 < arg_53_1.time_ and arg_53_1.time_ <= var_56_24 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_26 = arg_53_1:FormatText(StoryNameCfg[225].name)

				arg_53_1.leftNameTxt_.text = var_56_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_27 = arg_53_1:GetWordFromCfg(114171013)
				local var_56_28 = arg_53_1:FormatText(var_56_27.content)

				arg_53_1.text_.text = var_56_28

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_29 = 5
				local var_56_30 = utf8.len(var_56_28)
				local var_56_31 = var_56_29 <= 0 and var_56_25 or var_56_25 * (var_56_30 / var_56_29)

				if var_56_31 > 0 and var_56_25 < var_56_31 then
					arg_53_1.talkMaxDuration = var_56_31

					if var_56_31 + var_56_24 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_31 + var_56_24
					end
				end

				arg_53_1.text_.text = var_56_28
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171013", "story_v_out_114171.awb") ~= 0 then
					local var_56_32 = manager.audio:GetVoiceLength("story_v_out_114171", "114171013", "story_v_out_114171.awb") / 1000

					if var_56_32 + var_56_24 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_32 + var_56_24
					end

					if var_56_27.prefab_name ~= "" and arg_53_1.actors_[var_56_27.prefab_name] ~= nil then
						local var_56_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_27.prefab_name].transform, "story_v_out_114171", "114171013", "story_v_out_114171.awb")

						arg_53_1:RecordAudio("114171013", var_56_33)
						arg_53_1:RecordAudio("114171013", var_56_33)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_114171", "114171013", "story_v_out_114171.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_114171", "114171013", "story_v_out_114171.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_34 = math.max(var_56_25, arg_53_1.talkMaxDuration)

			if var_56_24 <= arg_53_1.time_ and arg_53_1.time_ < var_56_24 + var_56_34 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_24) / var_56_34

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_24 + var_56_34 and arg_53_1.time_ < var_56_24 + var_56_34 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play114171014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114171014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play114171015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10005ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos10005ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(0, 100, 0)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10005ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, 100, 0)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = 0
			local var_60_10 = 1.025

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_11 = arg_57_1:GetWordFromCfg(114171014)
				local var_60_12 = arg_57_1:FormatText(var_60_11.content)

				arg_57_1.text_.text = var_60_12

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 41
				local var_60_14 = utf8.len(var_60_12)
				local var_60_15 = var_60_13 <= 0 and var_60_10 or var_60_10 * (var_60_14 / var_60_13)

				if var_60_15 > 0 and var_60_10 < var_60_15 then
					arg_57_1.talkMaxDuration = var_60_15

					if var_60_15 + var_60_9 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_15 + var_60_9
					end
				end

				arg_57_1.text_.text = var_60_12
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_10, arg_57_1.talkMaxDuration)

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_9) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_9 + var_60_16 and arg_57_1.time_ < var_60_9 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play114171015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114171015
		arg_61_1.duration_ = 5.77

		local var_61_0 = {
			ja = 5.766,
			ko = 3.233,
			zh = 5.3,
			en = 4.5
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
				arg_61_0:Play114171016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10005ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos10005ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0, -0.95, -5.88)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10005ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, -0.95, -5.88)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["10005_tpose"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect10005_tpose == nil then
				arg_61_1.var_.characterEffect10005_tpose = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.2

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect10005_tpose and not isNil(var_64_9) then
					arg_61_1.var_.characterEffect10005_tpose.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect10005_tpose then
				arg_61_1.var_.characterEffect10005_tpose.fillFlat = false
			end

			local var_64_13 = 0

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_64_14 = 0
			local var_64_15 = 0.4

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_16 = arg_61_1:FormatText(StoryNameCfg[225].name)

				arg_61_1.leftNameTxt_.text = var_64_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_17 = arg_61_1:GetWordFromCfg(114171015)
				local var_64_18 = arg_61_1:FormatText(var_64_17.content)

				arg_61_1.text_.text = var_64_18

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_19 = 16
				local var_64_20 = utf8.len(var_64_18)
				local var_64_21 = var_64_19 <= 0 and var_64_15 or var_64_15 * (var_64_20 / var_64_19)

				if var_64_21 > 0 and var_64_15 < var_64_21 then
					arg_61_1.talkMaxDuration = var_64_21

					if var_64_21 + var_64_14 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_21 + var_64_14
					end
				end

				arg_61_1.text_.text = var_64_18
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171015", "story_v_out_114171.awb") ~= 0 then
					local var_64_22 = manager.audio:GetVoiceLength("story_v_out_114171", "114171015", "story_v_out_114171.awb") / 1000

					if var_64_22 + var_64_14 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_22 + var_64_14
					end

					if var_64_17.prefab_name ~= "" and arg_61_1.actors_[var_64_17.prefab_name] ~= nil then
						local var_64_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_17.prefab_name].transform, "story_v_out_114171", "114171015", "story_v_out_114171.awb")

						arg_61_1:RecordAudio("114171015", var_64_23)
						arg_61_1:RecordAudio("114171015", var_64_23)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_114171", "114171015", "story_v_out_114171.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_114171", "114171015", "story_v_out_114171.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_24 = math.max(var_64_15, arg_61_1.talkMaxDuration)

			if var_64_14 <= arg_61_1.time_ and arg_61_1.time_ < var_64_14 + var_64_24 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_14) / var_64_24

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_14 + var_64_24 and arg_61_1.time_ < var_64_14 + var_64_24 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play114171016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114171016
		arg_65_1.duration_ = 10.93

		local var_65_0 = {
			ja = 9.833,
			ko = 8.6,
			zh = 8.466,
			en = 10.933
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
				arg_65_0:Play114171017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action4_1")
			end

			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_68_2 = 0
			local var_68_3 = 0.95

			if var_68_2 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_4 = arg_65_1:FormatText(StoryNameCfg[225].name)

				arg_65_1.leftNameTxt_.text = var_68_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_5 = arg_65_1:GetWordFromCfg(114171016)
				local var_68_6 = arg_65_1:FormatText(var_68_5.content)

				arg_65_1.text_.text = var_68_6

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 38
				local var_68_8 = utf8.len(var_68_6)
				local var_68_9 = var_68_7 <= 0 and var_68_3 or var_68_3 * (var_68_8 / var_68_7)

				if var_68_9 > 0 and var_68_3 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_6
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171016", "story_v_out_114171.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_114171", "114171016", "story_v_out_114171.awb") / 1000

					if var_68_10 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_2
					end

					if var_68_5.prefab_name ~= "" and arg_65_1.actors_[var_68_5.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_5.prefab_name].transform, "story_v_out_114171", "114171016", "story_v_out_114171.awb")

						arg_65_1:RecordAudio("114171016", var_68_11)
						arg_65_1:RecordAudio("114171016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_114171", "114171016", "story_v_out_114171.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_114171", "114171016", "story_v_out_114171.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_3, arg_65_1.talkMaxDuration)

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_2) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_2 + var_68_12 and arg_65_1.time_ < var_68_2 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play114171017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114171017
		arg_69_1.duration_ = 17.47

		local var_69_0 = {
			ja = 17.466,
			ko = 16.3,
			zh = 13.833,
			en = 15.3
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
				arg_69_0:Play114171018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005actionlink/10005action445")
			end

			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_72_2 = 0
			local var_72_3 = 1.625

			if var_72_2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_4 = arg_69_1:FormatText(StoryNameCfg[225].name)

				arg_69_1.leftNameTxt_.text = var_72_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_5 = arg_69_1:GetWordFromCfg(114171017)
				local var_72_6 = arg_69_1:FormatText(var_72_5.content)

				arg_69_1.text_.text = var_72_6

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 65
				local var_72_8 = utf8.len(var_72_6)
				local var_72_9 = var_72_7 <= 0 and var_72_3 or var_72_3 * (var_72_8 / var_72_7)

				if var_72_9 > 0 and var_72_3 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_6
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171017", "story_v_out_114171.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_114171", "114171017", "story_v_out_114171.awb") / 1000

					if var_72_10 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_2
					end

					if var_72_5.prefab_name ~= "" and arg_69_1.actors_[var_72_5.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_5.prefab_name].transform, "story_v_out_114171", "114171017", "story_v_out_114171.awb")

						arg_69_1:RecordAudio("114171017", var_72_11)
						arg_69_1:RecordAudio("114171017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_114171", "114171017", "story_v_out_114171.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_114171", "114171017", "story_v_out_114171.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_3, arg_69_1.talkMaxDuration)

			if var_72_2 <= arg_69_1.time_ and arg_69_1.time_ < var_72_2 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_2) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_2 + var_72_12 and arg_69_1.time_ < var_72_2 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play114171018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114171018
		arg_73_1.duration_ = 19.73

		local var_73_0 = {
			ja = 14.4,
			ko = 15.166,
			zh = 19.633,
			en = 19.733
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
				arg_73_0:Play114171019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005actionlink/10005action457")
			end

			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_76_2 = 0
			local var_76_3 = 1.375

			if var_76_2 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_4 = arg_73_1:FormatText(StoryNameCfg[225].name)

				arg_73_1.leftNameTxt_.text = var_76_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_5 = arg_73_1:GetWordFromCfg(114171018)
				local var_76_6 = arg_73_1:FormatText(var_76_5.content)

				arg_73_1.text_.text = var_76_6

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 55
				local var_76_8 = utf8.len(var_76_6)
				local var_76_9 = var_76_7 <= 0 and var_76_3 or var_76_3 * (var_76_8 / var_76_7)

				if var_76_9 > 0 and var_76_3 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_6
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171018", "story_v_out_114171.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_114171", "114171018", "story_v_out_114171.awb") / 1000

					if var_76_10 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_2
					end

					if var_76_5.prefab_name ~= "" and arg_73_1.actors_[var_76_5.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_5.prefab_name].transform, "story_v_out_114171", "114171018", "story_v_out_114171.awb")

						arg_73_1:RecordAudio("114171018", var_76_11)
						arg_73_1:RecordAudio("114171018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_114171", "114171018", "story_v_out_114171.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_114171", "114171018", "story_v_out_114171.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_12 and arg_73_1.time_ < var_76_2 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play114171019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114171019
		arg_77_1.duration_ = 8.03

		local var_77_0 = {
			ja = 8.033,
			ko = 6.466,
			zh = 5.066,
			en = 5.9
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
				arg_77_0:Play114171020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10005_tpose"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect10005_tpose == nil then
				arg_77_1.var_.characterEffect10005_tpose = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect10005_tpose and not isNil(var_80_0) then
					local var_80_4 = Mathf.Lerp(0, 0.5, var_80_3)

					arg_77_1.var_.characterEffect10005_tpose.fillFlat = true
					arg_77_1.var_.characterEffect10005_tpose.fillRatio = var_80_4
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect10005_tpose then
				local var_80_5 = 0.5

				arg_77_1.var_.characterEffect10005_tpose.fillFlat = true
				arg_77_1.var_.characterEffect10005_tpose.fillRatio = var_80_5
			end

			local var_80_6 = 0
			local var_80_7 = 0.7

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_8 = arg_77_1:FormatText(StoryNameCfg[6].name)

				arg_77_1.leftNameTxt_.text = var_80_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_9 = arg_77_1:GetWordFromCfg(114171019)
				local var_80_10 = arg_77_1:FormatText(var_80_9.content)

				arg_77_1.text_.text = var_80_10

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171019", "story_v_out_114171.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_114171", "114171019", "story_v_out_114171.awb") / 1000

					if var_80_14 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_6
					end

					if var_80_9.prefab_name ~= "" and arg_77_1.actors_[var_80_9.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_9.prefab_name].transform, "story_v_out_114171", "114171019", "story_v_out_114171.awb")

						arg_77_1:RecordAudio("114171019", var_80_15)
						arg_77_1:RecordAudio("114171019", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_114171", "114171019", "story_v_out_114171.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_114171", "114171019", "story_v_out_114171.awb")
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
	Play114171020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114171020
		arg_81_1.duration_ = 7.23

		local var_81_0 = {
			ja = 3.766,
			ko = 5.266,
			zh = 7.233,
			en = 4.9
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
				arg_81_0:Play114171021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action7_2")
			end

			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_84_2 = 0
			local var_84_3 = 0.525

			if var_84_2 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_4 = arg_81_1:FormatText(StoryNameCfg[225].name)

				arg_81_1.leftNameTxt_.text = var_84_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_5 = arg_81_1:GetWordFromCfg(114171020)
				local var_84_6 = arg_81_1:FormatText(var_84_5.content)

				arg_81_1.text_.text = var_84_6

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 21
				local var_84_8 = utf8.len(var_84_6)
				local var_84_9 = var_84_7 <= 0 and var_84_3 or var_84_3 * (var_84_8 / var_84_7)

				if var_84_9 > 0 and var_84_3 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_6
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171020", "story_v_out_114171.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_114171", "114171020", "story_v_out_114171.awb") / 1000

					if var_84_10 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_2
					end

					if var_84_5.prefab_name ~= "" and arg_81_1.actors_[var_84_5.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_5.prefab_name].transform, "story_v_out_114171", "114171020", "story_v_out_114171.awb")

						arg_81_1:RecordAudio("114171020", var_84_11)
						arg_81_1:RecordAudio("114171020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_114171", "114171020", "story_v_out_114171.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_114171", "114171020", "story_v_out_114171.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_12 and arg_81_1.time_ < var_84_2 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play114171021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114171021
		arg_85_1.duration_ = 4.63

		local var_85_0 = {
			ja = 3.366,
			ko = 3.3,
			zh = 3.666,
			en = 4.633
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
				arg_85_0:Play114171022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10005ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos10005ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(0, 100, 0)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10005ui_story, var_88_4, var_88_3)

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

			local var_88_9 = arg_85_1.actors_["1038ui_story"].transform
			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 then
				arg_85_1.var_.moveOldPos1038ui_story = var_88_9.localPosition
			end

			local var_88_11 = 0.001

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11
				local var_88_13 = Vector3.New(0, -1.11, -5.9)

				var_88_9.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1038ui_story, var_88_13, var_88_12)

				local var_88_14 = manager.ui.mainCamera.transform.position - var_88_9.position

				var_88_9.forward = Vector3.New(var_88_14.x, var_88_14.y, var_88_14.z)

				local var_88_15 = var_88_9.localEulerAngles

				var_88_15.z = 0
				var_88_15.x = 0
				var_88_9.localEulerAngles = var_88_15
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 then
				var_88_9.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_88_16 = manager.ui.mainCamera.transform.position - var_88_9.position

				var_88_9.forward = Vector3.New(var_88_16.x, var_88_16.y, var_88_16.z)

				local var_88_17 = var_88_9.localEulerAngles

				var_88_17.z = 0
				var_88_17.x = 0
				var_88_9.localEulerAngles = var_88_17
			end

			local var_88_18 = 0

			if var_88_18 < arg_85_1.time_ and arg_85_1.time_ <= var_88_18 + arg_88_0 then
				arg_85_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_88_19 = 0

			if var_88_19 < arg_85_1.time_ and arg_85_1.time_ <= var_88_19 + arg_88_0 then
				arg_85_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_88_20 = arg_85_1.actors_["1038ui_story"]
			local var_88_21 = 0

			if var_88_21 < arg_85_1.time_ and arg_85_1.time_ <= var_88_21 + arg_88_0 and not isNil(var_88_20) and arg_85_1.var_.characterEffect1038ui_story == nil then
				arg_85_1.var_.characterEffect1038ui_story = var_88_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_22 = 0.2

			if var_88_21 <= arg_85_1.time_ and arg_85_1.time_ < var_88_21 + var_88_22 and not isNil(var_88_20) then
				local var_88_23 = (arg_85_1.time_ - var_88_21) / var_88_22

				if arg_85_1.var_.characterEffect1038ui_story and not isNil(var_88_20) then
					arg_85_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_21 + var_88_22 and arg_85_1.time_ < var_88_21 + var_88_22 + arg_88_0 and not isNil(var_88_20) and arg_85_1.var_.characterEffect1038ui_story then
				arg_85_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_88_24 = 0
			local var_88_25 = 0.35

			if var_88_24 < arg_85_1.time_ and arg_85_1.time_ <= var_88_24 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_26 = arg_85_1:FormatText(StoryNameCfg[94].name)

				arg_85_1.leftNameTxt_.text = var_88_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_27 = arg_85_1:GetWordFromCfg(114171021)
				local var_88_28 = arg_85_1:FormatText(var_88_27.content)

				arg_85_1.text_.text = var_88_28

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_29 = 14
				local var_88_30 = utf8.len(var_88_28)
				local var_88_31 = var_88_29 <= 0 and var_88_25 or var_88_25 * (var_88_30 / var_88_29)

				if var_88_31 > 0 and var_88_25 < var_88_31 then
					arg_85_1.talkMaxDuration = var_88_31

					if var_88_31 + var_88_24 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_31 + var_88_24
					end
				end

				arg_85_1.text_.text = var_88_28
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171021", "story_v_out_114171.awb") ~= 0 then
					local var_88_32 = manager.audio:GetVoiceLength("story_v_out_114171", "114171021", "story_v_out_114171.awb") / 1000

					if var_88_32 + var_88_24 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_32 + var_88_24
					end

					if var_88_27.prefab_name ~= "" and arg_85_1.actors_[var_88_27.prefab_name] ~= nil then
						local var_88_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_27.prefab_name].transform, "story_v_out_114171", "114171021", "story_v_out_114171.awb")

						arg_85_1:RecordAudio("114171021", var_88_33)
						arg_85_1:RecordAudio("114171021", var_88_33)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_114171", "114171021", "story_v_out_114171.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_114171", "114171021", "story_v_out_114171.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_34 = math.max(var_88_25, arg_85_1.talkMaxDuration)

			if var_88_24 <= arg_85_1.time_ and arg_85_1.time_ < var_88_24 + var_88_34 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_24) / var_88_34

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_24 + var_88_34 and arg_85_1.time_ < var_88_24 + var_88_34 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play114171022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 114171022
		arg_89_1.duration_ = 12.63

		local var_89_0 = {
			ja = 9.333,
			ko = 12.633,
			zh = 9.866,
			en = 9.3
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play114171023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_92_1 = 0
			local var_92_2 = 1.225

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_3 = arg_89_1:FormatText(StoryNameCfg[94].name)

				arg_89_1.leftNameTxt_.text = var_92_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_4 = arg_89_1:GetWordFromCfg(114171022)
				local var_92_5 = arg_89_1:FormatText(var_92_4.content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_6 = 49
				local var_92_7 = utf8.len(var_92_5)
				local var_92_8 = var_92_6 <= 0 and var_92_2 or var_92_2 * (var_92_7 / var_92_6)

				if var_92_8 > 0 and var_92_2 < var_92_8 then
					arg_89_1.talkMaxDuration = var_92_8

					if var_92_8 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_5
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171022", "story_v_out_114171.awb") ~= 0 then
					local var_92_9 = manager.audio:GetVoiceLength("story_v_out_114171", "114171022", "story_v_out_114171.awb") / 1000

					if var_92_9 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_1
					end

					if var_92_4.prefab_name ~= "" and arg_89_1.actors_[var_92_4.prefab_name] ~= nil then
						local var_92_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_4.prefab_name].transform, "story_v_out_114171", "114171022", "story_v_out_114171.awb")

						arg_89_1:RecordAudio("114171022", var_92_10)
						arg_89_1:RecordAudio("114171022", var_92_10)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_114171", "114171022", "story_v_out_114171.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_114171", "114171022", "story_v_out_114171.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_11 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_11 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_11

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_11 and arg_89_1.time_ < var_92_1 + var_92_11 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play114171023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 114171023
		arg_93_1.duration_ = 11.03

		local var_93_0 = {
			ja = 7.966,
			ko = 8.4,
			zh = 11.033,
			en = 8.366
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
				arg_93_0:Play114171024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1038ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1038ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, 100, 0)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1038ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, 100, 0)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["10005ui_story"].transform
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 then
				arg_93_1.var_.moveOldPos10005ui_story = var_96_9.localPosition
			end

			local var_96_11 = 0.001

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11
				local var_96_13 = Vector3.New(0, -0.95, -5.88)

				var_96_9.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10005ui_story, var_96_13, var_96_12)

				local var_96_14 = manager.ui.mainCamera.transform.position - var_96_9.position

				var_96_9.forward = Vector3.New(var_96_14.x, var_96_14.y, var_96_14.z)

				local var_96_15 = var_96_9.localEulerAngles

				var_96_15.z = 0
				var_96_15.x = 0
				var_96_9.localEulerAngles = var_96_15
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 then
				var_96_9.localPosition = Vector3.New(0, -0.95, -5.88)

				local var_96_16 = manager.ui.mainCamera.transform.position - var_96_9.position

				var_96_9.forward = Vector3.New(var_96_16.x, var_96_16.y, var_96_16.z)

				local var_96_17 = var_96_9.localEulerAngles

				var_96_17.z = 0
				var_96_17.x = 0
				var_96_9.localEulerAngles = var_96_17
			end

			local var_96_18 = 0

			if var_96_18 < arg_93_1.time_ and arg_93_1.time_ <= var_96_18 + arg_96_0 then
				arg_93_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action4_1")
			end

			local var_96_19 = 0

			if var_96_19 < arg_93_1.time_ and arg_93_1.time_ <= var_96_19 + arg_96_0 then
				arg_93_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_96_20 = arg_93_1.actors_["10005_tpose"]
			local var_96_21 = 0

			if var_96_21 < arg_93_1.time_ and arg_93_1.time_ <= var_96_21 + arg_96_0 and not isNil(var_96_20) and arg_93_1.var_.characterEffect10005_tpose == nil then
				arg_93_1.var_.characterEffect10005_tpose = var_96_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_22 = 0.2

			if var_96_21 <= arg_93_1.time_ and arg_93_1.time_ < var_96_21 + var_96_22 and not isNil(var_96_20) then
				local var_96_23 = (arg_93_1.time_ - var_96_21) / var_96_22

				if arg_93_1.var_.characterEffect10005_tpose and not isNil(var_96_20) then
					arg_93_1.var_.characterEffect10005_tpose.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_21 + var_96_22 and arg_93_1.time_ < var_96_21 + var_96_22 + arg_96_0 and not isNil(var_96_20) and arg_93_1.var_.characterEffect10005_tpose then
				arg_93_1.var_.characterEffect10005_tpose.fillFlat = false
			end

			local var_96_24 = 0
			local var_96_25 = 0.775

			if var_96_24 < arg_93_1.time_ and arg_93_1.time_ <= var_96_24 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_26 = arg_93_1:FormatText(StoryNameCfg[225].name)

				arg_93_1.leftNameTxt_.text = var_96_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_27 = arg_93_1:GetWordFromCfg(114171023)
				local var_96_28 = arg_93_1:FormatText(var_96_27.content)

				arg_93_1.text_.text = var_96_28

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_29 = 31
				local var_96_30 = utf8.len(var_96_28)
				local var_96_31 = var_96_29 <= 0 and var_96_25 or var_96_25 * (var_96_30 / var_96_29)

				if var_96_31 > 0 and var_96_25 < var_96_31 then
					arg_93_1.talkMaxDuration = var_96_31

					if var_96_31 + var_96_24 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_31 + var_96_24
					end
				end

				arg_93_1.text_.text = var_96_28
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171023", "story_v_out_114171.awb") ~= 0 then
					local var_96_32 = manager.audio:GetVoiceLength("story_v_out_114171", "114171023", "story_v_out_114171.awb") / 1000

					if var_96_32 + var_96_24 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_32 + var_96_24
					end

					if var_96_27.prefab_name ~= "" and arg_93_1.actors_[var_96_27.prefab_name] ~= nil then
						local var_96_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_27.prefab_name].transform, "story_v_out_114171", "114171023", "story_v_out_114171.awb")

						arg_93_1:RecordAudio("114171023", var_96_33)
						arg_93_1:RecordAudio("114171023", var_96_33)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_114171", "114171023", "story_v_out_114171.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_114171", "114171023", "story_v_out_114171.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_34 = math.max(var_96_25, arg_93_1.talkMaxDuration)

			if var_96_24 <= arg_93_1.time_ and arg_93_1.time_ < var_96_24 + var_96_34 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_24) / var_96_34

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_24 + var_96_34 and arg_93_1.time_ < var_96_24 + var_96_34 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play114171024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 114171024
		arg_97_1.duration_ = 15.37

		local var_97_0 = {
			ja = 9.933,
			ko = 13.266,
			zh = 14.166,
			en = 15.366
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
				arg_97_0:Play114171025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_100_1 = 0
			local var_100_2 = 1.375

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_3 = arg_97_1:FormatText(StoryNameCfg[225].name)

				arg_97_1.leftNameTxt_.text = var_100_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_4 = arg_97_1:GetWordFromCfg(114171024)
				local var_100_5 = arg_97_1:FormatText(var_100_4.content)

				arg_97_1.text_.text = var_100_5

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_6 = 55
				local var_100_7 = utf8.len(var_100_5)
				local var_100_8 = var_100_6 <= 0 and var_100_2 or var_100_2 * (var_100_7 / var_100_6)

				if var_100_8 > 0 and var_100_2 < var_100_8 then
					arg_97_1.talkMaxDuration = var_100_8

					if var_100_8 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_5
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171024", "story_v_out_114171.awb") ~= 0 then
					local var_100_9 = manager.audio:GetVoiceLength("story_v_out_114171", "114171024", "story_v_out_114171.awb") / 1000

					if var_100_9 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_1
					end

					if var_100_4.prefab_name ~= "" and arg_97_1.actors_[var_100_4.prefab_name] ~= nil then
						local var_100_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_4.prefab_name].transform, "story_v_out_114171", "114171024", "story_v_out_114171.awb")

						arg_97_1:RecordAudio("114171024", var_100_10)
						arg_97_1:RecordAudio("114171024", var_100_10)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_114171", "114171024", "story_v_out_114171.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_114171", "114171024", "story_v_out_114171.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_11 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_11 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_11

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_11 and arg_97_1.time_ < var_100_1 + var_100_11 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play114171025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 114171025
		arg_101_1.duration_ = 9.77

		local var_101_0 = {
			ja = 9.766,
			ko = 4.833,
			zh = 5.866,
			en = 5.8
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
				arg_101_0:Play114171026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_104_1 = 0
			local var_104_2 = 0.575

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_3 = arg_101_1:FormatText(StoryNameCfg[225].name)

				arg_101_1.leftNameTxt_.text = var_104_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_4 = arg_101_1:GetWordFromCfg(114171025)
				local var_104_5 = arg_101_1:FormatText(var_104_4.content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_6 = 23
				local var_104_7 = utf8.len(var_104_5)
				local var_104_8 = var_104_6 <= 0 and var_104_2 or var_104_2 * (var_104_7 / var_104_6)

				if var_104_8 > 0 and var_104_2 < var_104_8 then
					arg_101_1.talkMaxDuration = var_104_8

					if var_104_8 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171025", "story_v_out_114171.awb") ~= 0 then
					local var_104_9 = manager.audio:GetVoiceLength("story_v_out_114171", "114171025", "story_v_out_114171.awb") / 1000

					if var_104_9 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_1
					end

					if var_104_4.prefab_name ~= "" and arg_101_1.actors_[var_104_4.prefab_name] ~= nil then
						local var_104_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_4.prefab_name].transform, "story_v_out_114171", "114171025", "story_v_out_114171.awb")

						arg_101_1:RecordAudio("114171025", var_104_10)
						arg_101_1:RecordAudio("114171025", var_104_10)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_114171", "114171025", "story_v_out_114171.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_114171", "114171025", "story_v_out_114171.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_11 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_11 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_11

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_11 and arg_101_1.time_ < var_104_1 + var_104_11 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play114171026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 114171026
		arg_105_1.duration_ = 8.87

		local var_105_0 = {
			ja = 6.733,
			ko = 8.866,
			zh = 6.733,
			en = 6.4
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
				arg_105_0:Play114171027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10005ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos10005ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0, 100, 0)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10005ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, 100, 0)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = arg_105_1.actors_["10006ui_story"].transform
			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 then
				arg_105_1.var_.moveOldPos10006ui_story = var_108_9.localPosition
			end

			local var_108_11 = 0.001

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_11 then
				local var_108_12 = (arg_105_1.time_ - var_108_10) / var_108_11
				local var_108_13 = Vector3.New(0, -0.98, -5.65)

				var_108_9.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10006ui_story, var_108_13, var_108_12)

				local var_108_14 = manager.ui.mainCamera.transform.position - var_108_9.position

				var_108_9.forward = Vector3.New(var_108_14.x, var_108_14.y, var_108_14.z)

				local var_108_15 = var_108_9.localEulerAngles

				var_108_15.z = 0
				var_108_15.x = 0
				var_108_9.localEulerAngles = var_108_15
			end

			if arg_105_1.time_ >= var_108_10 + var_108_11 and arg_105_1.time_ < var_108_10 + var_108_11 + arg_108_0 then
				var_108_9.localPosition = Vector3.New(0, -0.98, -5.65)

				local var_108_16 = manager.ui.mainCamera.transform.position - var_108_9.position

				var_108_9.forward = Vector3.New(var_108_16.x, var_108_16.y, var_108_16.z)

				local var_108_17 = var_108_9.localEulerAngles

				var_108_17.z = 0
				var_108_17.x = 0
				var_108_9.localEulerAngles = var_108_17
			end

			local var_108_18 = 0

			if var_108_18 < arg_105_1.time_ and arg_105_1.time_ <= var_108_18 + arg_108_0 then
				arg_105_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action1_1")
			end

			local var_108_19 = 0

			if var_108_19 < arg_105_1.time_ and arg_105_1.time_ <= var_108_19 + arg_108_0 then
				arg_105_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_108_20 = arg_105_1.actors_["10006ui_story"]
			local var_108_21 = 0

			if var_108_21 < arg_105_1.time_ and arg_105_1.time_ <= var_108_21 + arg_108_0 and not isNil(var_108_20) and arg_105_1.var_.characterEffect10006ui_story == nil then
				arg_105_1.var_.characterEffect10006ui_story = var_108_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_22 = 0.2

			if var_108_21 <= arg_105_1.time_ and arg_105_1.time_ < var_108_21 + var_108_22 and not isNil(var_108_20) then
				local var_108_23 = (arg_105_1.time_ - var_108_21) / var_108_22

				if arg_105_1.var_.characterEffect10006ui_story and not isNil(var_108_20) then
					arg_105_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_21 + var_108_22 and arg_105_1.time_ < var_108_21 + var_108_22 + arg_108_0 and not isNil(var_108_20) and arg_105_1.var_.characterEffect10006ui_story then
				arg_105_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_108_24 = 0
			local var_108_25 = 0.7

			if var_108_24 < arg_105_1.time_ and arg_105_1.time_ <= var_108_24 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_26 = arg_105_1:FormatText(StoryNameCfg[212].name)

				arg_105_1.leftNameTxt_.text = var_108_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_27 = arg_105_1:GetWordFromCfg(114171026)
				local var_108_28 = arg_105_1:FormatText(var_108_27.content)

				arg_105_1.text_.text = var_108_28

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_29 = 28
				local var_108_30 = utf8.len(var_108_28)
				local var_108_31 = var_108_29 <= 0 and var_108_25 or var_108_25 * (var_108_30 / var_108_29)

				if var_108_31 > 0 and var_108_25 < var_108_31 then
					arg_105_1.talkMaxDuration = var_108_31

					if var_108_31 + var_108_24 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_31 + var_108_24
					end
				end

				arg_105_1.text_.text = var_108_28
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171026", "story_v_out_114171.awb") ~= 0 then
					local var_108_32 = manager.audio:GetVoiceLength("story_v_out_114171", "114171026", "story_v_out_114171.awb") / 1000

					if var_108_32 + var_108_24 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_32 + var_108_24
					end

					if var_108_27.prefab_name ~= "" and arg_105_1.actors_[var_108_27.prefab_name] ~= nil then
						local var_108_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_27.prefab_name].transform, "story_v_out_114171", "114171026", "story_v_out_114171.awb")

						arg_105_1:RecordAudio("114171026", var_108_33)
						arg_105_1:RecordAudio("114171026", var_108_33)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_114171", "114171026", "story_v_out_114171.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_114171", "114171026", "story_v_out_114171.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_34 = math.max(var_108_25, arg_105_1.talkMaxDuration)

			if var_108_24 <= arg_105_1.time_ and arg_105_1.time_ < var_108_24 + var_108_34 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_24) / var_108_34

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_24 + var_108_34 and arg_105_1.time_ < var_108_24 + var_108_34 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play114171027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 114171027
		arg_109_1.duration_ = 2.2

		local var_109_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.2
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
				arg_109_0:Play114171028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10006ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos10006ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0, 100, 0)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10006ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, 100, 0)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["10005ui_story"].transform
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 then
				arg_109_1.var_.moveOldPos10005ui_story = var_112_9.localPosition
			end

			local var_112_11 = 0.001

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11
				local var_112_13 = Vector3.New(0, -0.95, -5.88)

				var_112_9.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10005ui_story, var_112_13, var_112_12)

				local var_112_14 = manager.ui.mainCamera.transform.position - var_112_9.position

				var_112_9.forward = Vector3.New(var_112_14.x, var_112_14.y, var_112_14.z)

				local var_112_15 = var_112_9.localEulerAngles

				var_112_15.z = 0
				var_112_15.x = 0
				var_112_9.localEulerAngles = var_112_15
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 then
				var_112_9.localPosition = Vector3.New(0, -0.95, -5.88)

				local var_112_16 = manager.ui.mainCamera.transform.position - var_112_9.position

				var_112_9.forward = Vector3.New(var_112_16.x, var_112_16.y, var_112_16.z)

				local var_112_17 = var_112_9.localEulerAngles

				var_112_17.z = 0
				var_112_17.x = 0
				var_112_9.localEulerAngles = var_112_17
			end

			local var_112_18 = 0

			if var_112_18 < arg_109_1.time_ and arg_109_1.time_ <= var_112_18 + arg_112_0 then
				arg_109_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action4_2")
			end

			local var_112_19 = arg_109_1.actors_["10005_tpose"]
			local var_112_20 = 0

			if var_112_20 < arg_109_1.time_ and arg_109_1.time_ <= var_112_20 + arg_112_0 and not isNil(var_112_19) and arg_109_1.var_.characterEffect10005_tpose == nil then
				arg_109_1.var_.characterEffect10005_tpose = var_112_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_21 = 0.2

			if var_112_20 <= arg_109_1.time_ and arg_109_1.time_ < var_112_20 + var_112_21 and not isNil(var_112_19) then
				local var_112_22 = (arg_109_1.time_ - var_112_20) / var_112_21

				if arg_109_1.var_.characterEffect10005_tpose and not isNil(var_112_19) then
					arg_109_1.var_.characterEffect10005_tpose.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_20 + var_112_21 and arg_109_1.time_ < var_112_20 + var_112_21 + arg_112_0 and not isNil(var_112_19) and arg_109_1.var_.characterEffect10005_tpose then
				arg_109_1.var_.characterEffect10005_tpose.fillFlat = false
			end

			local var_112_23 = 0

			if var_112_23 < arg_109_1.time_ and arg_109_1.time_ <= var_112_23 + arg_112_0 then
				arg_109_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_112_24 = 0
			local var_112_25 = 0.125

			if var_112_24 < arg_109_1.time_ and arg_109_1.time_ <= var_112_24 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_26 = arg_109_1:FormatText(StoryNameCfg[225].name)

				arg_109_1.leftNameTxt_.text = var_112_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_27 = arg_109_1:GetWordFromCfg(114171027)
				local var_112_28 = arg_109_1:FormatText(var_112_27.content)

				arg_109_1.text_.text = var_112_28

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_29 = 5
				local var_112_30 = utf8.len(var_112_28)
				local var_112_31 = var_112_29 <= 0 and var_112_25 or var_112_25 * (var_112_30 / var_112_29)

				if var_112_31 > 0 and var_112_25 < var_112_31 then
					arg_109_1.talkMaxDuration = var_112_31

					if var_112_31 + var_112_24 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_31 + var_112_24
					end
				end

				arg_109_1.text_.text = var_112_28
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171027", "story_v_out_114171.awb") ~= 0 then
					local var_112_32 = manager.audio:GetVoiceLength("story_v_out_114171", "114171027", "story_v_out_114171.awb") / 1000

					if var_112_32 + var_112_24 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_32 + var_112_24
					end

					if var_112_27.prefab_name ~= "" and arg_109_1.actors_[var_112_27.prefab_name] ~= nil then
						local var_112_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_27.prefab_name].transform, "story_v_out_114171", "114171027", "story_v_out_114171.awb")

						arg_109_1:RecordAudio("114171027", var_112_33)
						arg_109_1:RecordAudio("114171027", var_112_33)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_114171", "114171027", "story_v_out_114171.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_114171", "114171027", "story_v_out_114171.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_34 = math.max(var_112_25, arg_109_1.talkMaxDuration)

			if var_112_24 <= arg_109_1.time_ and arg_109_1.time_ < var_112_24 + var_112_34 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_24) / var_112_34

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_24 + var_112_34 and arg_109_1.time_ < var_112_24 + var_112_34 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play114171028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 114171028
		arg_113_1.duration_ = 8.83

		local var_113_0 = {
			ja = 8.833,
			ko = 7.766,
			zh = 6.033,
			en = 8.5
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
				arg_113_0:Play114171029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action5_1")
			end

			local var_116_2 = 0
			local var_116_3 = 0.675

			if var_116_2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_4 = arg_113_1:FormatText(StoryNameCfg[225].name)

				arg_113_1.leftNameTxt_.text = var_116_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_5 = arg_113_1:GetWordFromCfg(114171028)
				local var_116_6 = arg_113_1:FormatText(var_116_5.content)

				arg_113_1.text_.text = var_116_6

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 27
				local var_116_8 = utf8.len(var_116_6)
				local var_116_9 = var_116_7 <= 0 and var_116_3 or var_116_3 * (var_116_8 / var_116_7)

				if var_116_9 > 0 and var_116_3 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_2
					end
				end

				arg_113_1.text_.text = var_116_6
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171028", "story_v_out_114171.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_114171", "114171028", "story_v_out_114171.awb") / 1000

					if var_116_10 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_2
					end

					if var_116_5.prefab_name ~= "" and arg_113_1.actors_[var_116_5.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_5.prefab_name].transform, "story_v_out_114171", "114171028", "story_v_out_114171.awb")

						arg_113_1:RecordAudio("114171028", var_116_11)
						arg_113_1:RecordAudio("114171028", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_114171", "114171028", "story_v_out_114171.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_114171", "114171028", "story_v_out_114171.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_3, arg_113_1.talkMaxDuration)

			if var_116_2 <= arg_113_1.time_ and arg_113_1.time_ < var_116_2 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_2) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_2 + var_116_12 and arg_113_1.time_ < var_116_2 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play114171029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 114171029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play114171030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10005ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos10005ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(0, 100, 0)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10005ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0, 100, 0)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = 0
			local var_120_10 = 1.125

			if var_120_9 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_11 = arg_117_1:GetWordFromCfg(114171029)
				local var_120_12 = arg_117_1:FormatText(var_120_11.content)

				arg_117_1.text_.text = var_120_12

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_13 = 45
				local var_120_14 = utf8.len(var_120_12)
				local var_120_15 = var_120_13 <= 0 and var_120_10 or var_120_10 * (var_120_14 / var_120_13)

				if var_120_15 > 0 and var_120_10 < var_120_15 then
					arg_117_1.talkMaxDuration = var_120_15

					if var_120_15 + var_120_9 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_15 + var_120_9
					end
				end

				arg_117_1.text_.text = var_120_12
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_16 = math.max(var_120_10, arg_117_1.talkMaxDuration)

			if var_120_9 <= arg_117_1.time_ and arg_117_1.time_ < var_120_9 + var_120_16 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_9) / var_120_16

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_9 + var_120_16 and arg_117_1.time_ < var_120_9 + var_120_16 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play114171030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 114171030
		arg_121_1.duration_ = 13.3

		local var_121_0 = {
			ja = 13.3,
			ko = 6.6,
			zh = 5.466,
			en = 5.133
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
				arg_121_0:Play114171031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10005ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos10005ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0, -0.95, -5.88)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10005ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, -0.95, -5.88)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = 0

			if var_124_9 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 then
				arg_121_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action1_1")
			end

			local var_124_10 = arg_121_1.actors_["10005_tpose"]
			local var_124_11 = 0

			if var_124_11 < arg_121_1.time_ and arg_121_1.time_ <= var_124_11 + arg_124_0 and not isNil(var_124_10) and arg_121_1.var_.characterEffect10005_tpose == nil then
				arg_121_1.var_.characterEffect10005_tpose = var_124_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_12 = 0.2

			if var_124_11 <= arg_121_1.time_ and arg_121_1.time_ < var_124_11 + var_124_12 and not isNil(var_124_10) then
				local var_124_13 = (arg_121_1.time_ - var_124_11) / var_124_12

				if arg_121_1.var_.characterEffect10005_tpose and not isNil(var_124_10) then
					arg_121_1.var_.characterEffect10005_tpose.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_11 + var_124_12 and arg_121_1.time_ < var_124_11 + var_124_12 + arg_124_0 and not isNil(var_124_10) and arg_121_1.var_.characterEffect10005_tpose then
				arg_121_1.var_.characterEffect10005_tpose.fillFlat = false
			end

			local var_124_14 = 0

			if var_124_14 < arg_121_1.time_ and arg_121_1.time_ <= var_124_14 + arg_124_0 then
				arg_121_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_124_15 = 0
			local var_124_16 = 0.65

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_17 = arg_121_1:FormatText(StoryNameCfg[225].name)

				arg_121_1.leftNameTxt_.text = var_124_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_18 = arg_121_1:GetWordFromCfg(114171030)
				local var_124_19 = arg_121_1:FormatText(var_124_18.content)

				arg_121_1.text_.text = var_124_19

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_20 = 26
				local var_124_21 = utf8.len(var_124_19)
				local var_124_22 = var_124_20 <= 0 and var_124_16 or var_124_16 * (var_124_21 / var_124_20)

				if var_124_22 > 0 and var_124_16 < var_124_22 then
					arg_121_1.talkMaxDuration = var_124_22

					if var_124_22 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_22 + var_124_15
					end
				end

				arg_121_1.text_.text = var_124_19
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171030", "story_v_out_114171.awb") ~= 0 then
					local var_124_23 = manager.audio:GetVoiceLength("story_v_out_114171", "114171030", "story_v_out_114171.awb") / 1000

					if var_124_23 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_23 + var_124_15
					end

					if var_124_18.prefab_name ~= "" and arg_121_1.actors_[var_124_18.prefab_name] ~= nil then
						local var_124_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_18.prefab_name].transform, "story_v_out_114171", "114171030", "story_v_out_114171.awb")

						arg_121_1:RecordAudio("114171030", var_124_24)
						arg_121_1:RecordAudio("114171030", var_124_24)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_114171", "114171030", "story_v_out_114171.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_114171", "114171030", "story_v_out_114171.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_25 = math.max(var_124_16, arg_121_1.talkMaxDuration)

			if var_124_15 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_25 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_15) / var_124_25

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_15 + var_124_25 and arg_121_1.time_ < var_124_15 + var_124_25 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play114171031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 114171031
		arg_125_1.duration_ = 9.03

		local var_125_0 = {
			ja = 7.1,
			ko = 9.033,
			zh = 6.8,
			en = 8.133
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
				arg_125_0:Play114171032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action5_1")
			end

			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_128_2 = 0
			local var_128_3 = 0.9

			if var_128_2 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_4 = arg_125_1:FormatText(StoryNameCfg[225].name)

				arg_125_1.leftNameTxt_.text = var_128_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_5 = arg_125_1:GetWordFromCfg(114171031)
				local var_128_6 = arg_125_1:FormatText(var_128_5.content)

				arg_125_1.text_.text = var_128_6

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_7 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171031", "story_v_out_114171.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_114171", "114171031", "story_v_out_114171.awb") / 1000

					if var_128_10 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_2
					end

					if var_128_5.prefab_name ~= "" and arg_125_1.actors_[var_128_5.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_5.prefab_name].transform, "story_v_out_114171", "114171031", "story_v_out_114171.awb")

						arg_125_1:RecordAudio("114171031", var_128_11)
						arg_125_1:RecordAudio("114171031", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_114171", "114171031", "story_v_out_114171.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_114171", "114171031", "story_v_out_114171.awb")
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
	Play114171032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 114171032
		arg_129_1.duration_ = 6.3

		local var_129_0 = {
			ja = 6.3,
			ko = 6.066,
			zh = 3.366,
			en = 4.7
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play114171033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10005ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos10005ui_story = var_132_0.localPosition
			end

			local var_132_2 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2
				local var_132_4 = Vector3.New(0, 100, 0)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10005ui_story, var_132_4, var_132_3)

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

			local var_132_9 = arg_129_1.actors_["1038ui_story"].transform
			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 then
				arg_129_1.var_.moveOldPos1038ui_story = var_132_9.localPosition
			end

			local var_132_11 = 0.001

			if var_132_10 <= arg_129_1.time_ and arg_129_1.time_ < var_132_10 + var_132_11 then
				local var_132_12 = (arg_129_1.time_ - var_132_10) / var_132_11
				local var_132_13 = Vector3.New(0, -1.11, -5.9)

				var_132_9.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1038ui_story, var_132_13, var_132_12)

				local var_132_14 = manager.ui.mainCamera.transform.position - var_132_9.position

				var_132_9.forward = Vector3.New(var_132_14.x, var_132_14.y, var_132_14.z)

				local var_132_15 = var_132_9.localEulerAngles

				var_132_15.z = 0
				var_132_15.x = 0
				var_132_9.localEulerAngles = var_132_15
			end

			if arg_129_1.time_ >= var_132_10 + var_132_11 and arg_129_1.time_ < var_132_10 + var_132_11 + arg_132_0 then
				var_132_9.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_132_16 = manager.ui.mainCamera.transform.position - var_132_9.position

				var_132_9.forward = Vector3.New(var_132_16.x, var_132_16.y, var_132_16.z)

				local var_132_17 = var_132_9.localEulerAngles

				var_132_17.z = 0
				var_132_17.x = 0
				var_132_9.localEulerAngles = var_132_17
			end

			local var_132_18 = 0

			if var_132_18 < arg_129_1.time_ and arg_129_1.time_ <= var_132_18 + arg_132_0 then
				arg_129_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_132_19 = 0

			if var_132_19 < arg_129_1.time_ and arg_129_1.time_ <= var_132_19 + arg_132_0 then
				arg_129_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_132_20 = arg_129_1.actors_["1038ui_story"]
			local var_132_21 = 0

			if var_132_21 < arg_129_1.time_ and arg_129_1.time_ <= var_132_21 + arg_132_0 and not isNil(var_132_20) and arg_129_1.var_.characterEffect1038ui_story == nil then
				arg_129_1.var_.characterEffect1038ui_story = var_132_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_22 = 0.2

			if var_132_21 <= arg_129_1.time_ and arg_129_1.time_ < var_132_21 + var_132_22 and not isNil(var_132_20) then
				local var_132_23 = (arg_129_1.time_ - var_132_21) / var_132_22

				if arg_129_1.var_.characterEffect1038ui_story and not isNil(var_132_20) then
					arg_129_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_21 + var_132_22 and arg_129_1.time_ < var_132_21 + var_132_22 + arg_132_0 and not isNil(var_132_20) and arg_129_1.var_.characterEffect1038ui_story then
				arg_129_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_132_24 = 0
			local var_132_25 = 0.375

			if var_132_24 < arg_129_1.time_ and arg_129_1.time_ <= var_132_24 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_26 = arg_129_1:FormatText(StoryNameCfg[94].name)

				arg_129_1.leftNameTxt_.text = var_132_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_27 = arg_129_1:GetWordFromCfg(114171032)
				local var_132_28 = arg_129_1:FormatText(var_132_27.content)

				arg_129_1.text_.text = var_132_28

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_29 = 15
				local var_132_30 = utf8.len(var_132_28)
				local var_132_31 = var_132_29 <= 0 and var_132_25 or var_132_25 * (var_132_30 / var_132_29)

				if var_132_31 > 0 and var_132_25 < var_132_31 then
					arg_129_1.talkMaxDuration = var_132_31

					if var_132_31 + var_132_24 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_31 + var_132_24
					end
				end

				arg_129_1.text_.text = var_132_28
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171032", "story_v_out_114171.awb") ~= 0 then
					local var_132_32 = manager.audio:GetVoiceLength("story_v_out_114171", "114171032", "story_v_out_114171.awb") / 1000

					if var_132_32 + var_132_24 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_32 + var_132_24
					end

					if var_132_27.prefab_name ~= "" and arg_129_1.actors_[var_132_27.prefab_name] ~= nil then
						local var_132_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_27.prefab_name].transform, "story_v_out_114171", "114171032", "story_v_out_114171.awb")

						arg_129_1:RecordAudio("114171032", var_132_33)
						arg_129_1:RecordAudio("114171032", var_132_33)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_114171", "114171032", "story_v_out_114171.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_114171", "114171032", "story_v_out_114171.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_34 = math.max(var_132_25, arg_129_1.talkMaxDuration)

			if var_132_24 <= arg_129_1.time_ and arg_129_1.time_ < var_132_24 + var_132_34 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_24) / var_132_34

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_24 + var_132_34 and arg_129_1.time_ < var_132_24 + var_132_34 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play114171033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 114171033
		arg_133_1.duration_ = 11.27

		local var_133_0 = {
			ja = 6.733,
			ko = 5.433,
			zh = 8.533,
			en = 11.266
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
				arg_133_0:Play114171034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1038ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos1038ui_story = var_136_0.localPosition
			end

			local var_136_2 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2
				local var_136_4 = Vector3.New(0, 100, 0)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1038ui_story, var_136_4, var_136_3)

				local var_136_5 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_5.x, var_136_5.y, var_136_5.z)

				local var_136_6 = var_136_0.localEulerAngles

				var_136_6.z = 0
				var_136_6.x = 0
				var_136_0.localEulerAngles = var_136_6
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0, 100, 0)

				local var_136_7 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_7.x, var_136_7.y, var_136_7.z)

				local var_136_8 = var_136_0.localEulerAngles

				var_136_8.z = 0
				var_136_8.x = 0
				var_136_0.localEulerAngles = var_136_8
			end

			local var_136_9 = arg_133_1.actors_["10005ui_story"].transform
			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 then
				arg_133_1.var_.moveOldPos10005ui_story = var_136_9.localPosition
			end

			local var_136_11 = 0.001

			if var_136_10 <= arg_133_1.time_ and arg_133_1.time_ < var_136_10 + var_136_11 then
				local var_136_12 = (arg_133_1.time_ - var_136_10) / var_136_11
				local var_136_13 = Vector3.New(0, -0.95, -5.88)

				var_136_9.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10005ui_story, var_136_13, var_136_12)

				local var_136_14 = manager.ui.mainCamera.transform.position - var_136_9.position

				var_136_9.forward = Vector3.New(var_136_14.x, var_136_14.y, var_136_14.z)

				local var_136_15 = var_136_9.localEulerAngles

				var_136_15.z = 0
				var_136_15.x = 0
				var_136_9.localEulerAngles = var_136_15
			end

			if arg_133_1.time_ >= var_136_10 + var_136_11 and arg_133_1.time_ < var_136_10 + var_136_11 + arg_136_0 then
				var_136_9.localPosition = Vector3.New(0, -0.95, -5.88)

				local var_136_16 = manager.ui.mainCamera.transform.position - var_136_9.position

				var_136_9.forward = Vector3.New(var_136_16.x, var_136_16.y, var_136_16.z)

				local var_136_17 = var_136_9.localEulerAngles

				var_136_17.z = 0
				var_136_17.x = 0
				var_136_9.localEulerAngles = var_136_17
			end

			local var_136_18 = 0

			if var_136_18 < arg_133_1.time_ and arg_133_1.time_ <= var_136_18 + arg_136_0 then
				arg_133_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action5_2")
			end

			local var_136_19 = 0

			if var_136_19 < arg_133_1.time_ and arg_133_1.time_ <= var_136_19 + arg_136_0 then
				arg_133_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_136_20 = arg_133_1.actors_["10005_tpose"]
			local var_136_21 = 0

			if var_136_21 < arg_133_1.time_ and arg_133_1.time_ <= var_136_21 + arg_136_0 and not isNil(var_136_20) and arg_133_1.var_.characterEffect10005_tpose == nil then
				arg_133_1.var_.characterEffect10005_tpose = var_136_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_22 = 0.2

			if var_136_21 <= arg_133_1.time_ and arg_133_1.time_ < var_136_21 + var_136_22 and not isNil(var_136_20) then
				local var_136_23 = (arg_133_1.time_ - var_136_21) / var_136_22

				if arg_133_1.var_.characterEffect10005_tpose and not isNil(var_136_20) then
					arg_133_1.var_.characterEffect10005_tpose.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_21 + var_136_22 and arg_133_1.time_ < var_136_21 + var_136_22 + arg_136_0 and not isNil(var_136_20) and arg_133_1.var_.characterEffect10005_tpose then
				arg_133_1.var_.characterEffect10005_tpose.fillFlat = false
			end

			local var_136_24 = 0
			local var_136_25 = 0.675

			if var_136_24 < arg_133_1.time_ and arg_133_1.time_ <= var_136_24 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_26 = arg_133_1:FormatText(StoryNameCfg[225].name)

				arg_133_1.leftNameTxt_.text = var_136_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_27 = arg_133_1:GetWordFromCfg(114171033)
				local var_136_28 = arg_133_1:FormatText(var_136_27.content)

				arg_133_1.text_.text = var_136_28

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_29 = 27
				local var_136_30 = utf8.len(var_136_28)
				local var_136_31 = var_136_29 <= 0 and var_136_25 or var_136_25 * (var_136_30 / var_136_29)

				if var_136_31 > 0 and var_136_25 < var_136_31 then
					arg_133_1.talkMaxDuration = var_136_31

					if var_136_31 + var_136_24 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_31 + var_136_24
					end
				end

				arg_133_1.text_.text = var_136_28
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171033", "story_v_out_114171.awb") ~= 0 then
					local var_136_32 = manager.audio:GetVoiceLength("story_v_out_114171", "114171033", "story_v_out_114171.awb") / 1000

					if var_136_32 + var_136_24 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_32 + var_136_24
					end

					if var_136_27.prefab_name ~= "" and arg_133_1.actors_[var_136_27.prefab_name] ~= nil then
						local var_136_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_27.prefab_name].transform, "story_v_out_114171", "114171033", "story_v_out_114171.awb")

						arg_133_1:RecordAudio("114171033", var_136_33)
						arg_133_1:RecordAudio("114171033", var_136_33)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_114171", "114171033", "story_v_out_114171.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_114171", "114171033", "story_v_out_114171.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_34 = math.max(var_136_25, arg_133_1.talkMaxDuration)

			if var_136_24 <= arg_133_1.time_ and arg_133_1.time_ < var_136_24 + var_136_34 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_24) / var_136_34

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_24 + var_136_34 and arg_133_1.time_ < var_136_24 + var_136_34 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play114171034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 114171034
		arg_137_1.duration_ = 7.37

		local var_137_0 = {
			ja = 5.2,
			ko = 5.8,
			zh = 5.5,
			en = 7.366
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play114171035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action4_1")
			end

			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_140_2 = 0
			local var_140_3 = 0.525

			if var_140_2 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_4 = arg_137_1:FormatText(StoryNameCfg[225].name)

				arg_137_1.leftNameTxt_.text = var_140_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_5 = arg_137_1:GetWordFromCfg(114171034)
				local var_140_6 = arg_137_1:FormatText(var_140_5.content)

				arg_137_1.text_.text = var_140_6

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_7 = 21
				local var_140_8 = utf8.len(var_140_6)
				local var_140_9 = var_140_7 <= 0 and var_140_3 or var_140_3 * (var_140_8 / var_140_7)

				if var_140_9 > 0 and var_140_3 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_6
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171034", "story_v_out_114171.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_out_114171", "114171034", "story_v_out_114171.awb") / 1000

					if var_140_10 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_2
					end

					if var_140_5.prefab_name ~= "" and arg_137_1.actors_[var_140_5.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_5.prefab_name].transform, "story_v_out_114171", "114171034", "story_v_out_114171.awb")

						arg_137_1:RecordAudio("114171034", var_140_11)
						arg_137_1:RecordAudio("114171034", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_114171", "114171034", "story_v_out_114171.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_114171", "114171034", "story_v_out_114171.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_12 and arg_137_1.time_ < var_140_2 + var_140_12 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play114171035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 114171035
		arg_141_1.duration_ = 10.2

		local var_141_0 = {
			ja = 8.9,
			ko = 8.9,
			zh = 8.333,
			en = 10.2
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play114171036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_144_1 = 0
			local var_144_2 = 0.85

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_3 = arg_141_1:FormatText(StoryNameCfg[225].name)

				arg_141_1.leftNameTxt_.text = var_144_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_4 = arg_141_1:GetWordFromCfg(114171035)
				local var_144_5 = arg_141_1:FormatText(var_144_4.content)

				arg_141_1.text_.text = var_144_5

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_6 = 34
				local var_144_7 = utf8.len(var_144_5)
				local var_144_8 = var_144_6 <= 0 and var_144_2 or var_144_2 * (var_144_7 / var_144_6)

				if var_144_8 > 0 and var_144_2 < var_144_8 then
					arg_141_1.talkMaxDuration = var_144_8

					if var_144_8 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_5
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171035", "story_v_out_114171.awb") ~= 0 then
					local var_144_9 = manager.audio:GetVoiceLength("story_v_out_114171", "114171035", "story_v_out_114171.awb") / 1000

					if var_144_9 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_1
					end

					if var_144_4.prefab_name ~= "" and arg_141_1.actors_[var_144_4.prefab_name] ~= nil then
						local var_144_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_4.prefab_name].transform, "story_v_out_114171", "114171035", "story_v_out_114171.awb")

						arg_141_1:RecordAudio("114171035", var_144_10)
						arg_141_1:RecordAudio("114171035", var_144_10)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_114171", "114171035", "story_v_out_114171.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_114171", "114171035", "story_v_out_114171.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_11 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_11 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_11

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_11 and arg_141_1.time_ < var_144_1 + var_144_11 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play114171036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 114171036
		arg_145_1.duration_ = 9

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play114171037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = "OM0214"

			if arg_145_1.bgs_[var_148_0] == nil then
				local var_148_1 = Object.Instantiate(arg_145_1.paintGo_)

				var_148_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_148_0)
				var_148_1.name = var_148_0
				var_148_1.transform.parent = arg_145_1.stage_.transform
				var_148_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.bgs_[var_148_0] = var_148_1
			end

			local var_148_2 = 2

			if var_148_2 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				local var_148_3 = manager.ui.mainCamera.transform.localPosition
				local var_148_4 = Vector3.New(0, 0, 10) + Vector3.New(var_148_3.x, var_148_3.y, 0)
				local var_148_5 = arg_145_1.bgs_.OM0214

				var_148_5.transform.localPosition = var_148_4
				var_148_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_148_6 = var_148_5:GetComponent("SpriteRenderer")

				if var_148_6 and var_148_6.sprite then
					local var_148_7 = (var_148_5.transform.localPosition - var_148_3).z
					local var_148_8 = manager.ui.mainCameraCom_
					local var_148_9 = 2 * var_148_7 * Mathf.Tan(var_148_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_148_10 = var_148_9 * var_148_8.aspect
					local var_148_11 = var_148_6.sprite.bounds.size.x
					local var_148_12 = var_148_6.sprite.bounds.size.y
					local var_148_13 = var_148_10 / var_148_11
					local var_148_14 = var_148_9 / var_148_12
					local var_148_15 = var_148_14 < var_148_13 and var_148_13 or var_148_14

					var_148_5.transform.localScale = Vector3.New(var_148_15, var_148_15, 0)
				end

				for iter_148_0, iter_148_1 in pairs(arg_145_1.bgs_) do
					if iter_148_0 ~= "OM0214" then
						iter_148_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_148_16 = 0

			if var_148_16 < arg_145_1.time_ and arg_145_1.time_ <= var_148_16 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_17 = 2

			if var_148_16 <= arg_145_1.time_ and arg_145_1.time_ < var_148_16 + var_148_17 then
				local var_148_18 = (arg_145_1.time_ - var_148_16) / var_148_17
				local var_148_19 = Color.New(0, 0, 0)

				var_148_19.a = Mathf.Lerp(0, 1, var_148_18)
				arg_145_1.mask_.color = var_148_19
			end

			if arg_145_1.time_ >= var_148_16 + var_148_17 and arg_145_1.time_ < var_148_16 + var_148_17 + arg_148_0 then
				local var_148_20 = Color.New(0, 0, 0)

				var_148_20.a = 1
				arg_145_1.mask_.color = var_148_20
			end

			local var_148_21 = 2

			if var_148_21 < arg_145_1.time_ and arg_145_1.time_ <= var_148_21 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_22 = 2

			if var_148_21 <= arg_145_1.time_ and arg_145_1.time_ < var_148_21 + var_148_22 then
				local var_148_23 = (arg_145_1.time_ - var_148_21) / var_148_22
				local var_148_24 = Color.New(0, 0, 0)

				var_148_24.a = Mathf.Lerp(1, 0, var_148_23)
				arg_145_1.mask_.color = var_148_24
			end

			if arg_145_1.time_ >= var_148_21 + var_148_22 and arg_145_1.time_ < var_148_21 + var_148_22 + arg_148_0 then
				local var_148_25 = Color.New(0, 0, 0)
				local var_148_26 = 0

				arg_145_1.mask_.enabled = false
				var_148_25.a = var_148_26
				arg_145_1.mask_.color = var_148_25
			end

			local var_148_27 = arg_145_1.actors_["10005ui_story"].transform
			local var_148_28 = 1.966

			if var_148_28 < arg_145_1.time_ and arg_145_1.time_ <= var_148_28 + arg_148_0 then
				arg_145_1.var_.moveOldPos10005ui_story = var_148_27.localPosition
			end

			local var_148_29 = 0.001

			if var_148_28 <= arg_145_1.time_ and arg_145_1.time_ < var_148_28 + var_148_29 then
				local var_148_30 = (arg_145_1.time_ - var_148_28) / var_148_29
				local var_148_31 = Vector3.New(0, 100, 0)

				var_148_27.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10005ui_story, var_148_31, var_148_30)

				local var_148_32 = manager.ui.mainCamera.transform.position - var_148_27.position

				var_148_27.forward = Vector3.New(var_148_32.x, var_148_32.y, var_148_32.z)

				local var_148_33 = var_148_27.localEulerAngles

				var_148_33.z = 0
				var_148_33.x = 0
				var_148_27.localEulerAngles = var_148_33
			end

			if arg_145_1.time_ >= var_148_28 + var_148_29 and arg_145_1.time_ < var_148_28 + var_148_29 + arg_148_0 then
				var_148_27.localPosition = Vector3.New(0, 100, 0)

				local var_148_34 = manager.ui.mainCamera.transform.position - var_148_27.position

				var_148_27.forward = Vector3.New(var_148_34.x, var_148_34.y, var_148_34.z)

				local var_148_35 = var_148_27.localEulerAngles

				var_148_35.z = 0
				var_148_35.x = 0
				var_148_27.localEulerAngles = var_148_35
			end

			local var_148_36 = arg_145_1.bgs_.OM0214.transform
			local var_148_37 = 2

			if var_148_37 < arg_145_1.time_ and arg_145_1.time_ <= var_148_37 + arg_148_0 then
				arg_145_1.var_.moveOldPosOM0214 = var_148_36.localPosition
			end

			local var_148_38 = 0.001

			if var_148_37 <= arg_145_1.time_ and arg_145_1.time_ < var_148_37 + var_148_38 then
				local var_148_39 = (arg_145_1.time_ - var_148_37) / var_148_38
				local var_148_40 = Vector3.New(0, 1, 10)

				var_148_36.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPosOM0214, var_148_40, var_148_39)
			end

			if arg_145_1.time_ >= var_148_37 + var_148_38 and arg_145_1.time_ < var_148_37 + var_148_38 + arg_148_0 then
				var_148_36.localPosition = Vector3.New(0, 1, 10)
			end

			local var_148_41 = arg_145_1.bgs_.OM0214.transform
			local var_148_42 = 2.034

			if var_148_42 < arg_145_1.time_ and arg_145_1.time_ <= var_148_42 + arg_148_0 then
				arg_145_1.var_.moveOldPosOM0214 = var_148_41.localPosition
			end

			local var_148_43 = 2.5

			if var_148_42 <= arg_145_1.time_ and arg_145_1.time_ < var_148_42 + var_148_43 then
				local var_148_44 = (arg_145_1.time_ - var_148_42) / var_148_43
				local var_148_45 = Vector3.New(0, 1, 9.5)

				var_148_41.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPosOM0214, var_148_45, var_148_44)
			end

			if arg_145_1.time_ >= var_148_42 + var_148_43 and arg_145_1.time_ < var_148_42 + var_148_43 + arg_148_0 then
				var_148_41.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_148_46 = 4

			if var_148_46 < arg_145_1.time_ and arg_145_1.time_ <= var_148_46 + arg_148_0 then
				arg_145_1.allBtn_.enabled = false
			end

			local var_148_47 = 0.534000000000001

			if arg_145_1.time_ >= var_148_46 + var_148_47 and arg_145_1.time_ < var_148_46 + var_148_47 + arg_148_0 then
				arg_145_1.allBtn_.enabled = true
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_48 = 4
			local var_148_49 = 1.45

			if var_148_48 < arg_145_1.time_ and arg_145_1.time_ <= var_148_48 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_50 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_50:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_51 = arg_145_1:GetWordFromCfg(114171036)
				local var_148_52 = arg_145_1:FormatText(var_148_51.content)

				arg_145_1.text_.text = var_148_52

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_53 = 58
				local var_148_54 = utf8.len(var_148_52)
				local var_148_55 = var_148_53 <= 0 and var_148_49 or var_148_49 * (var_148_54 / var_148_53)

				if var_148_55 > 0 and var_148_49 < var_148_55 then
					arg_145_1.talkMaxDuration = var_148_55
					var_148_48 = var_148_48 + 0.3

					if var_148_55 + var_148_48 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_55 + var_148_48
					end
				end

				arg_145_1.text_.text = var_148_52
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_56 = var_148_48 + 0.3
			local var_148_57 = math.max(var_148_49, arg_145_1.talkMaxDuration)

			if var_148_56 <= arg_145_1.time_ and arg_145_1.time_ < var_148_56 + var_148_57 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_56) / var_148_57

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_56 + var_148_57 and arg_145_1.time_ < var_148_56 + var_148_57 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "OM0214",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0214",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.5,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play114171037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 114171037
		arg_151_1.duration_ = 5.93

		local var_151_0 = {
			ja = 5.933,
			ko = 3.9,
			zh = 3.733,
			en = 3.233
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
				arg_151_0:Play114171038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = manager.ui.mainCamera.transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.shakeOldPos = var_154_0.localPosition
			end

			local var_154_2 = 0.6

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / 0.066
				local var_154_4, var_154_5 = math.modf(var_154_3)

				var_154_0.localPosition = Vector3.New(var_154_5 * 0.13, var_154_5 * 0.13, var_154_5 * 0.13) + arg_151_1.var_.shakeOldPos
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 then
				var_154_0.localPosition = arg_151_1.var_.shakeOldPos
			end

			local var_154_6 = 0

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			local var_154_7 = 0.6

			if arg_151_1.time_ >= var_154_6 + var_154_7 and arg_151_1.time_ < var_154_6 + var_154_7 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end

			local var_154_8 = 0
			local var_154_9 = 0.325

			if var_154_8 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_10 = arg_151_1:FormatText(StoryNameCfg[10].name)

				arg_151_1.leftNameTxt_.text = var_154_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_11 = arg_151_1:GetWordFromCfg(114171037)
				local var_154_12 = arg_151_1:FormatText(var_154_11.content)

				arg_151_1.text_.text = var_154_12

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_13 = 13
				local var_154_14 = utf8.len(var_154_12)
				local var_154_15 = var_154_13 <= 0 and var_154_9 or var_154_9 * (var_154_14 / var_154_13)

				if var_154_15 > 0 and var_154_9 < var_154_15 then
					arg_151_1.talkMaxDuration = var_154_15

					if var_154_15 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_15 + var_154_8
					end
				end

				arg_151_1.text_.text = var_154_12
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171037", "story_v_out_114171.awb") ~= 0 then
					local var_154_16 = manager.audio:GetVoiceLength("story_v_out_114171", "114171037", "story_v_out_114171.awb") / 1000

					if var_154_16 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_16 + var_154_8
					end

					if var_154_11.prefab_name ~= "" and arg_151_1.actors_[var_154_11.prefab_name] ~= nil then
						local var_154_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_11.prefab_name].transform, "story_v_out_114171", "114171037", "story_v_out_114171.awb")

						arg_151_1:RecordAudio("114171037", var_154_17)
						arg_151_1:RecordAudio("114171037", var_154_17)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_114171", "114171037", "story_v_out_114171.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_114171", "114171037", "story_v_out_114171.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_18 = math.max(var_154_9, arg_151_1.talkMaxDuration)

			if var_154_8 <= arg_151_1.time_ and arg_151_1.time_ < var_154_8 + var_154_18 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_8) / var_154_18

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_8 + var_154_18 and arg_151_1.time_ < var_154_8 + var_154_18 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play114171038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 114171038
		arg_155_1.duration_ = 7.57

		local var_155_0 = {
			ja = 7.566,
			ko = 5.333,
			zh = 5.433,
			en = 5.7
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
				arg_155_0:Play114171039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.425

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[225].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:GetWordFromCfg(114171038)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 17
				local var_158_6 = utf8.len(var_158_4)
				local var_158_7 = var_158_5 <= 0 and var_158_1 or var_158_1 * (var_158_6 / var_158_5)

				if var_158_7 > 0 and var_158_1 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171038", "story_v_out_114171.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_114171", "114171038", "story_v_out_114171.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_114171", "114171038", "story_v_out_114171.awb")

						arg_155_1:RecordAudio("114171038", var_158_9)
						arg_155_1:RecordAudio("114171038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_114171", "114171038", "story_v_out_114171.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_114171", "114171038", "story_v_out_114171.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_10 and arg_155_1.time_ < var_158_0 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play114171039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 114171039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play114171040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.bgs_.OM0214.transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPosOM0214 = var_162_0.localPosition
			end

			local var_162_2 = 2

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(0, 1, 9)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPosOM0214, var_162_4, var_162_3)
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, 1, 9)
			end

			local var_162_5 = 0

			if var_162_5 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1.allBtn_.enabled = false
			end

			local var_162_6 = 2

			if arg_159_1.time_ >= var_162_5 + var_162_6 and arg_159_1.time_ < var_162_5 + var_162_6 + arg_162_0 then
				arg_159_1.allBtn_.enabled = true
			end

			local var_162_7 = 0
			local var_162_8 = 0.75

			if var_162_7 < arg_159_1.time_ and arg_159_1.time_ <= var_162_7 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_9 = arg_159_1:GetWordFromCfg(114171039)
				local var_162_10 = arg_159_1:FormatText(var_162_9.content)

				arg_159_1.text_.text = var_162_10

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 30
				local var_162_12 = utf8.len(var_162_10)
				local var_162_13 = var_162_11 <= 0 and var_162_8 or var_162_8 * (var_162_12 / var_162_11)

				if var_162_13 > 0 and var_162_8 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_7 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_7
					end
				end

				arg_159_1.text_.text = var_162_10
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_8, arg_159_1.talkMaxDuration)

			if var_162_7 <= arg_159_1.time_ and arg_159_1.time_ < var_162_7 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_7) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_7 + var_162_14 and arg_159_1.time_ < var_162_7 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0214",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play114171040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 114171040
		arg_163_1.duration_ = 6.17

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play114171041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = manager.ui.mainCamera.transform
			local var_166_1 = 2.14166666666667

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.shakeOldPos = var_166_0.localPosition
			end

			local var_166_2 = 0.5

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / 0.066
				local var_166_4, var_166_5 = math.modf(var_166_3)

				var_166_0.localPosition = Vector3.New(var_166_5 * 0.13, var_166_5 * 0.13, var_166_5 * 0.13) + arg_163_1.var_.shakeOldPos
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = arg_163_1.var_.shakeOldPos
			end

			local var_166_6 = 2.14166666666667

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.allBtn_.enabled = false
			end

			local var_166_7 = 0.5

			if arg_163_1.time_ >= var_166_6 + var_166_7 and arg_163_1.time_ < var_166_6 + var_166_7 + arg_166_0 then
				arg_163_1.allBtn_.enabled = true
			end

			local var_166_8 = 1.16666666666667
			local var_166_9 = 0.975

			if var_166_8 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_10 = arg_163_1:GetWordFromCfg(114171040)
				local var_166_11 = arg_163_1:FormatText(var_166_10.content)

				arg_163_1.text_.text = var_166_11

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_12 = 39
				local var_166_13 = utf8.len(var_166_11)
				local var_166_14 = var_166_12 <= 0 and var_166_9 or var_166_9 * (var_166_13 / var_166_12)

				if var_166_14 > 0 and var_166_9 < var_166_14 then
					arg_163_1.talkMaxDuration = var_166_14

					if var_166_14 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_8
					end
				end

				arg_163_1.text_.text = var_166_11
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_15 = math.max(var_166_9, arg_163_1.talkMaxDuration)

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_15 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_8) / var_166_15

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_8 + var_166_15 and arg_163_1.time_ < var_166_8 + var_166_15 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play114171041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 114171041
		arg_167_1.duration_ = 11.5

		local var_167_0 = {
			ja = 10.333,
			ko = 4.8,
			zh = 11.5,
			en = 8.133
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
			arg_167_1.auto_ = false
		end

		function arg_167_1.playNext_(arg_169_0)
			arg_167_1.onStoryFinished_()
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.575

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[225].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:GetWordFromCfg(114171041)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 23
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171041", "story_v_out_114171.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_114171", "114171041", "story_v_out_114171.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_114171", "114171041", "story_v_out_114171.awb")

						arg_167_1:RecordAudio("114171041", var_170_9)
						arg_167_1:RecordAudio("114171041", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_114171", "114171041", "story_v_out_114171.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_114171", "114171041", "story_v_out_114171.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_10 and arg_167_1.time_ < var_170_0 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F07",
		"TextureConfig/Background/OM0214"
	},
	voices = {
		"story_v_out_114171.awb"
	}
}
