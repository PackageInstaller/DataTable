return {
	Play111152001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111152001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111152002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "D11"

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
				local var_4_5 = arg_1_1.bgs_.D11

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
					if iter_4_0 ~= "D11" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.D11
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueD11 = var_4_18.color.a
					arg_1_1.var_.alphaMatValueD11 = var_4_18
				end

				arg_1_1.var_.alphaOldValueD11 = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueD11, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueD11 then
					local var_4_22 = arg_1_1.var_.alphaMatValueD11.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueD11.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueD11 then
				local var_4_23 = arg_1_1.var_.alphaMatValueD11
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_26 = 2.1

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_27 = 0
			local var_4_28 = 1

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				local var_4_29 = "play"
				local var_4_30 = "music"

				arg_1_1:AudioAction(var_4_29, var_4_30, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_31 = ""
				local var_4_32 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_32 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_32 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_32

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_32
						arg_1_1.bgmTxt2_.text = var_4_32
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

			local var_4_33 = 2
			local var_4_34 = 0.8

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_35 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_35:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_36 = arg_1_1:GetWordFromCfg(111152001)
				local var_4_37 = arg_1_1:FormatText(var_4_36.content)

				arg_1_1.text_.text = var_4_37

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 32
				local var_4_39 = utf8.len(var_4_37)
				local var_4_40 = var_4_38 <= 0 and var_4_34 or var_4_34 * (var_4_39 / var_4_38)

				if var_4_40 > 0 and var_4_34 < var_4_40 then
					arg_1_1.talkMaxDuration = var_4_40
					var_4_33 = var_4_33 + 0.3

					if var_4_40 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_40 + var_4_33
					end
				end

				arg_1_1.text_.text = var_4_37
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_41 = var_4_33 + 0.3
			local var_4_42 = math.max(var_4_34, arg_1_1.talkMaxDuration)

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_41) / var_4_42

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play111152002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 111152002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play111152003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.2

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

				local var_11_2 = arg_8_1:GetWordFromCfg(111152002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 48
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
	Play111152003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 111152003
		arg_12_1.duration_ = 6

		local var_12_0 = {
			ja = 3.4,
			ko = 5.1,
			zh = 4.566,
			en = 6
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play111152004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1084ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_12_1.stage_.transform)

					var_15_2.name = var_15_0
					var_15_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_12_1.actors_[var_15_0] = var_15_2

					local var_15_3 = var_15_2:GetComponentInChildren(typeof(CharacterEffect))

					var_15_3.enabled = true

					local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_2, typeof(DynamicBoneHelper))

					if var_15_4 then
						var_15_4:EnableDynamicBone(false)
					end

					arg_12_1:ShowWeapon(var_15_3.transform, false)

					arg_12_1.var_[var_15_0 .. "Animator"] = var_15_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_12_1.var_[var_15_0 .. "Animator"].applyRootMotion = true
					arg_12_1.var_[var_15_0 .. "LipSync"] = var_15_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_15_5 = arg_12_1.actors_["1084ui_story"].transform
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_5.localPosition

				local var_15_7 = "1084ui_story"

				arg_12_1:ShowWeapon(arg_12_1.var_[var_15_7 .. "Animator"].transform, true)
			end

			local var_15_8 = 0.001

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_8 then
				local var_15_9 = (arg_12_1.time_ - var_15_6) / var_15_8
				local var_15_10 = Vector3.New(-0.7, -0.97, -6)

				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, var_15_10, var_15_9)

				local var_15_11 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_11.x, var_15_11.y, var_15_11.z)

				local var_15_12 = var_15_5.localEulerAngles

				var_15_12.z = 0
				var_15_12.x = 0
				var_15_5.localEulerAngles = var_15_12
			end

			if arg_12_1.time_ >= var_15_6 + var_15_8 and arg_12_1.time_ < var_15_6 + var_15_8 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_15_13 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_13.x, var_15_13.y, var_15_13.z)

				local var_15_14 = var_15_5.localEulerAngles

				var_15_14.z = 0
				var_15_14.x = 0
				var_15_5.localEulerAngles = var_15_14
			end

			local var_15_15 = 0

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_15_16 = 0

			if var_15_16 < arg_12_1.time_ and arg_12_1.time_ <= var_15_16 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_15_17 = arg_12_1.actors_["1084ui_story"]
			local var_15_18 = 0

			if var_15_18 < arg_12_1.time_ and arg_12_1.time_ <= var_15_18 + arg_15_0 and not isNil(var_15_17) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_19 = 0.2

			if var_15_18 <= arg_12_1.time_ and arg_12_1.time_ < var_15_18 + var_15_19 and not isNil(var_15_17) then
				local var_15_20 = (arg_12_1.time_ - var_15_18) / var_15_19

				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_17) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_18 + var_15_19 and arg_12_1.time_ < var_15_18 + var_15_19 + arg_15_0 and not isNil(var_15_17) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_15_21 = 0
			local var_15_22 = 0.4

			if var_15_21 < arg_12_1.time_ and arg_12_1.time_ <= var_15_21 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_23 = arg_12_1:FormatText(StoryNameCfg[6].name)

				arg_12_1.leftNameTxt_.text = var_15_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_24 = arg_12_1:GetWordFromCfg(111152003)
				local var_15_25 = arg_12_1:FormatText(var_15_24.content)

				arg_12_1.text_.text = var_15_25

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_26 = 16
				local var_15_27 = utf8.len(var_15_25)
				local var_15_28 = var_15_26 <= 0 and var_15_22 or var_15_22 * (var_15_27 / var_15_26)

				if var_15_28 > 0 and var_15_22 < var_15_28 then
					arg_12_1.talkMaxDuration = var_15_28

					if var_15_28 + var_15_21 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_28 + var_15_21
					end
				end

				arg_12_1.text_.text = var_15_25
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111152", "111152003", "story_v_out_111152.awb") ~= 0 then
					local var_15_29 = manager.audio:GetVoiceLength("story_v_out_111152", "111152003", "story_v_out_111152.awb") / 1000

					if var_15_29 + var_15_21 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_29 + var_15_21
					end

					if var_15_24.prefab_name ~= "" and arg_12_1.actors_[var_15_24.prefab_name] ~= nil then
						local var_15_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_24.prefab_name].transform, "story_v_out_111152", "111152003", "story_v_out_111152.awb")

						arg_12_1:RecordAudio("111152003", var_15_30)
						arg_12_1:RecordAudio("111152003", var_15_30)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_111152", "111152003", "story_v_out_111152.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_111152", "111152003", "story_v_out_111152.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_31 = math.max(var_15_22, arg_12_1.talkMaxDuration)

			if var_15_21 <= arg_12_1.time_ and arg_12_1.time_ < var_15_21 + var_15_31 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_21) / var_15_31

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_21 + var_15_31 and arg_12_1.time_ < var_15_21 + var_15_31 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play111152004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 111152004
		arg_16_1.duration_ = 5.53

		local var_16_0 = {
			ja = 5.533,
			ko = 2,
			zh = 3.433,
			en = 3.7
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
				arg_16_0:Play111152005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1048ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1048ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1048ui_story"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["1048ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos1048ui_story = var_19_5.localPosition
			end

			local var_19_7 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7
				local var_19_9 = Vector3.New(0.7, -0.8, -6.2)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1048ui_story, var_19_9, var_19_8)

				local var_19_10 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_10.x, var_19_10.y, var_19_10.z)

				local var_19_11 = var_19_5.localEulerAngles

				var_19_11.z = 0
				var_19_11.x = 0
				var_19_5.localEulerAngles = var_19_11
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_19_12 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_12.x, var_19_12.y, var_19_12.z)

				local var_19_13 = var_19_5.localEulerAngles

				var_19_13.z = 0
				var_19_13.x = 0
				var_19_5.localEulerAngles = var_19_13
			end

			local var_19_14 = 0

			if var_19_14 < arg_16_1.time_ and arg_16_1.time_ <= var_19_14 + arg_19_0 then
				arg_16_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action8_1")
			end

			local var_19_15 = 0

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_19_16 = arg_16_1.actors_["1048ui_story"]
			local var_19_17 = 0

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 and not isNil(var_19_16) and arg_16_1.var_.characterEffect1048ui_story == nil then
				arg_16_1.var_.characterEffect1048ui_story = var_19_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_18 = 0.2

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_18 and not isNil(var_19_16) then
				local var_19_19 = (arg_16_1.time_ - var_19_17) / var_19_18

				if arg_16_1.var_.characterEffect1048ui_story and not isNil(var_19_16) then
					arg_16_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_17 + var_19_18 and arg_16_1.time_ < var_19_17 + var_19_18 + arg_19_0 and not isNil(var_19_16) and arg_16_1.var_.characterEffect1048ui_story then
				arg_16_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_19_20 = arg_16_1.actors_["1084ui_story"]
			local var_19_21 = 0

			if var_19_21 < arg_16_1.time_ and arg_16_1.time_ <= var_19_21 + arg_19_0 and not isNil(var_19_20) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_22 = 0.2

			if var_19_21 <= arg_16_1.time_ and arg_16_1.time_ < var_19_21 + var_19_22 and not isNil(var_19_20) then
				local var_19_23 = (arg_16_1.time_ - var_19_21) / var_19_22

				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_20) then
					local var_19_24 = Mathf.Lerp(0, 0.5, var_19_23)

					arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1084ui_story.fillRatio = var_19_24
				end
			end

			if arg_16_1.time_ >= var_19_21 + var_19_22 and arg_16_1.time_ < var_19_21 + var_19_22 + arg_19_0 and not isNil(var_19_20) and arg_16_1.var_.characterEffect1084ui_story then
				local var_19_25 = 0.5

				arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1084ui_story.fillRatio = var_19_25
			end

			local var_19_26 = 0
			local var_19_27 = 0.35

			if var_19_26 < arg_16_1.time_ and arg_16_1.time_ <= var_19_26 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_28 = arg_16_1:FormatText(StoryNameCfg[8].name)

				arg_16_1.leftNameTxt_.text = var_19_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_29 = arg_16_1:GetWordFromCfg(111152004)
				local var_19_30 = arg_16_1:FormatText(var_19_29.content)

				arg_16_1.text_.text = var_19_30

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_31 = 14
				local var_19_32 = utf8.len(var_19_30)
				local var_19_33 = var_19_31 <= 0 and var_19_27 or var_19_27 * (var_19_32 / var_19_31)

				if var_19_33 > 0 and var_19_27 < var_19_33 then
					arg_16_1.talkMaxDuration = var_19_33

					if var_19_33 + var_19_26 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_33 + var_19_26
					end
				end

				arg_16_1.text_.text = var_19_30
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111152", "111152004", "story_v_out_111152.awb") ~= 0 then
					local var_19_34 = manager.audio:GetVoiceLength("story_v_out_111152", "111152004", "story_v_out_111152.awb") / 1000

					if var_19_34 + var_19_26 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_34 + var_19_26
					end

					if var_19_29.prefab_name ~= "" and arg_16_1.actors_[var_19_29.prefab_name] ~= nil then
						local var_19_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_29.prefab_name].transform, "story_v_out_111152", "111152004", "story_v_out_111152.awb")

						arg_16_1:RecordAudio("111152004", var_19_35)
						arg_16_1:RecordAudio("111152004", var_19_35)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_111152", "111152004", "story_v_out_111152.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_111152", "111152004", "story_v_out_111152.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_36 = math.max(var_19_27, arg_16_1.talkMaxDuration)

			if var_19_26 <= arg_16_1.time_ and arg_16_1.time_ < var_19_26 + var_19_36 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_26) / var_19_36

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_26 + var_19_36 and arg_16_1.time_ < var_19_26 + var_19_36 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play111152005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 111152005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play111152006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1048ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1048ui_story == nil then
				arg_20_1.var_.characterEffect1048ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.2

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1048ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1048ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1048ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1048ui_story.fillRatio = var_23_5
			end

			local var_23_6 = arg_20_1.actors_["1084ui_story"].transform
			local var_23_7 = 0

			if var_23_7 < arg_20_1.time_ and arg_20_1.time_ <= var_23_7 + arg_23_0 then
				arg_20_1.var_.moveOldPos1084ui_story = var_23_6.localPosition
			end

			local var_23_8 = 0.001

			if var_23_7 <= arg_20_1.time_ and arg_20_1.time_ < var_23_7 + var_23_8 then
				local var_23_9 = (arg_20_1.time_ - var_23_7) / var_23_8
				local var_23_10 = Vector3.New(0, 100, 0)

				var_23_6.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1084ui_story, var_23_10, var_23_9)

				local var_23_11 = manager.ui.mainCamera.transform.position - var_23_6.position

				var_23_6.forward = Vector3.New(var_23_11.x, var_23_11.y, var_23_11.z)

				local var_23_12 = var_23_6.localEulerAngles

				var_23_12.z = 0
				var_23_12.x = 0
				var_23_6.localEulerAngles = var_23_12
			end

			if arg_20_1.time_ >= var_23_7 + var_23_8 and arg_20_1.time_ < var_23_7 + var_23_8 + arg_23_0 then
				var_23_6.localPosition = Vector3.New(0, 100, 0)

				local var_23_13 = manager.ui.mainCamera.transform.position - var_23_6.position

				var_23_6.forward = Vector3.New(var_23_13.x, var_23_13.y, var_23_13.z)

				local var_23_14 = var_23_6.localEulerAngles

				var_23_14.z = 0
				var_23_14.x = 0
				var_23_6.localEulerAngles = var_23_14
			end

			local var_23_15 = arg_20_1.actors_["1048ui_story"].transform
			local var_23_16 = 0

			if var_23_16 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.var_.moveOldPos1048ui_story = var_23_15.localPosition
			end

			local var_23_17 = 0.001

			if var_23_16 <= arg_20_1.time_ and arg_20_1.time_ < var_23_16 + var_23_17 then
				local var_23_18 = (arg_20_1.time_ - var_23_16) / var_23_17
				local var_23_19 = Vector3.New(0, 100, 0)

				var_23_15.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1048ui_story, var_23_19, var_23_18)

				local var_23_20 = manager.ui.mainCamera.transform.position - var_23_15.position

				var_23_15.forward = Vector3.New(var_23_20.x, var_23_20.y, var_23_20.z)

				local var_23_21 = var_23_15.localEulerAngles

				var_23_21.z = 0
				var_23_21.x = 0
				var_23_15.localEulerAngles = var_23_21
			end

			if arg_20_1.time_ >= var_23_16 + var_23_17 and arg_20_1.time_ < var_23_16 + var_23_17 + arg_23_0 then
				var_23_15.localPosition = Vector3.New(0, 100, 0)

				local var_23_22 = manager.ui.mainCamera.transform.position - var_23_15.position

				var_23_15.forward = Vector3.New(var_23_22.x, var_23_22.y, var_23_22.z)

				local var_23_23 = var_23_15.localEulerAngles

				var_23_23.z = 0
				var_23_23.x = 0
				var_23_15.localEulerAngles = var_23_23
			end

			local var_23_24 = 0
			local var_23_25 = 0.925

			if var_23_24 < arg_20_1.time_ and arg_20_1.time_ <= var_23_24 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_26 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_27 = arg_20_1:GetWordFromCfg(111152005)
				local var_23_28 = arg_20_1:FormatText(var_23_27.content)

				arg_20_1.text_.text = var_23_28

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_29 = 37
				local var_23_30 = utf8.len(var_23_28)
				local var_23_31 = var_23_29 <= 0 and var_23_25 or var_23_25 * (var_23_30 / var_23_29)

				if var_23_31 > 0 and var_23_25 < var_23_31 then
					arg_20_1.talkMaxDuration = var_23_31

					if var_23_31 + var_23_24 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_31 + var_23_24
					end
				end

				arg_20_1.text_.text = var_23_28
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_32 = math.max(var_23_25, arg_20_1.talkMaxDuration)

			if var_23_24 <= arg_20_1.time_ and arg_20_1.time_ < var_23_24 + var_23_32 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_24) / var_23_32

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_24 + var_23_32 and arg_20_1.time_ < var_23_24 + var_23_32 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play111152006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 111152006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play111152007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 1.05

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_2 = arg_24_1:GetWordFromCfg(111152006)
				local var_27_3 = arg_24_1:FormatText(var_27_2.content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 42
				local var_27_5 = utf8.len(var_27_3)
				local var_27_6 = var_27_4 <= 0 and var_27_1 or var_27_1 * (var_27_5 / var_27_4)

				if var_27_6 > 0 and var_27_1 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_7 and arg_24_1.time_ < var_27_0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play111152007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 111152007
		arg_28_1.duration_ = 2.2

		local var_28_0 = {
			ja = 2.2,
			ko = 2.033,
			zh = 1.8,
			en = 2
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
				arg_28_0:Play111152008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = manager.ui.mainCamera.transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.shakeOldPos = var_31_0.localPosition
			end

			local var_31_2 = 0.6

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / 0.066
				local var_31_4, var_31_5 = math.modf(var_31_3)

				var_31_0.localPosition = Vector3.New(var_31_5 * 0.13, var_31_5 * 0.13, var_31_5 * 0.13) + arg_28_1.var_.shakeOldPos
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 then
				var_31_0.localPosition = arg_28_1.var_.shakeOldPos
			end

			local var_31_6 = 0
			local var_31_7 = 0.2

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_8 = arg_28_1:FormatText(StoryNameCfg[8].name)

				arg_28_1.leftNameTxt_.text = var_31_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1048")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_9 = arg_28_1:GetWordFromCfg(111152007)
				local var_31_10 = arg_28_1:FormatText(var_31_9.content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_111152", "111152007", "story_v_out_111152.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_out_111152", "111152007", "story_v_out_111152.awb") / 1000

					if var_31_14 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_6
					end

					if var_31_9.prefab_name ~= "" and arg_28_1.actors_[var_31_9.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_9.prefab_name].transform, "story_v_out_111152", "111152007", "story_v_out_111152.awb")

						arg_28_1:RecordAudio("111152007", var_31_15)
						arg_28_1:RecordAudio("111152007", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_111152", "111152007", "story_v_out_111152.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_111152", "111152007", "story_v_out_111152.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_16 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_16 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_16

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_16 and arg_28_1.time_ < var_31_6 + var_31_16 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play111152008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 111152008
		arg_32_1.duration_ = 1.4

		local var_32_0 = {
			ja = 1.066,
			ko = 1.033,
			zh = 0.999999999999,
			en = 1.4
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
				arg_32_0:Play111152009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.05

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[6].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:GetWordFromCfg(111152008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 2
				local var_35_6 = utf8.len(var_35_4)
				local var_35_7 = var_35_5 <= 0 and var_35_1 or var_35_1 * (var_35_6 / var_35_5)

				if var_35_7 > 0 and var_35_1 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111152", "111152008", "story_v_out_111152.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_111152", "111152008", "story_v_out_111152.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_111152", "111152008", "story_v_out_111152.awb")

						arg_32_1:RecordAudio("111152008", var_35_9)
						arg_32_1:RecordAudio("111152008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_111152", "111152008", "story_v_out_111152.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_111152", "111152008", "story_v_out_111152.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_10 and arg_32_1.time_ < var_35_0 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play111152009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 111152009
		arg_36_1.duration_ = 5.97

		local var_36_0 = {
			ja = 2.633,
			ko = 5.733,
			zh = 5.966,
			en = 5.866
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
				arg_36_0:Play111152010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.425

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[6].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:GetWordFromCfg(111152009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 17
				local var_39_6 = utf8.len(var_39_4)
				local var_39_7 = var_39_5 <= 0 and var_39_1 or var_39_1 * (var_39_6 / var_39_5)

				if var_39_7 > 0 and var_39_1 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111152", "111152009", "story_v_out_111152.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_111152", "111152009", "story_v_out_111152.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_111152", "111152009", "story_v_out_111152.awb")

						arg_36_1:RecordAudio("111152009", var_39_9)
						arg_36_1:RecordAudio("111152009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_111152", "111152009", "story_v_out_111152.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_111152", "111152009", "story_v_out_111152.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_10 and arg_36_1.time_ < var_39_0 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play111152010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 111152010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play111152011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = manager.ui.mainCamera.transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.shakeOldPos = var_43_0.localPosition
			end

			local var_43_2 = 0.6

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / 0.066
				local var_43_4, var_43_5 = math.modf(var_43_3)

				var_43_0.localPosition = Vector3.New(var_43_5 * 0.13, var_43_5 * 0.13, var_43_5 * 0.13) + arg_40_1.var_.shakeOldPos
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 then
				var_43_0.localPosition = arg_40_1.var_.shakeOldPos
			end

			local var_43_6 = 0
			local var_43_7 = 0.075

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_8 = arg_40_1:FormatText(StoryNameCfg[7].name)

				arg_40_1.leftNameTxt_.text = var_43_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_9 = arg_40_1:GetWordFromCfg(111152010)
				local var_43_10 = arg_40_1:FormatText(var_43_9.content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 3
				local var_43_12 = utf8.len(var_43_10)
				local var_43_13 = var_43_11 <= 0 and var_43_7 or var_43_7 * (var_43_12 / var_43_11)

				if var_43_13 > 0 and var_43_7 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_6
					end
				end

				arg_40_1.text_.text = var_43_10
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_14 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_14 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_14

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_14 and arg_40_1.time_ < var_43_6 + var_43_14 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play111152011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 111152011
		arg_44_1.duration_ = 6

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play111152012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = false

				arg_44_1:SetGaussion(false)
			end

			local var_47_1 = 1

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_1 then
				local var_47_2 = (arg_44_1.time_ - var_47_0) / var_47_1
				local var_47_3 = Color.New(1, 1, 1)

				var_47_3.a = Mathf.Lerp(1, 0, var_47_2)
				arg_44_1.mask_.color = var_47_3
			end

			if arg_44_1.time_ >= var_47_0 + var_47_1 and arg_44_1.time_ < var_47_0 + var_47_1 + arg_47_0 then
				local var_47_4 = Color.New(1, 1, 1)
				local var_47_5 = 0

				arg_44_1.mask_.enabled = false
				var_47_4.a = var_47_5
				arg_44_1.mask_.color = var_47_4
			end

			local var_47_6 = 0

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.allBtn_.enabled = false
			end

			local var_47_7 = 1

			if arg_44_1.time_ >= var_47_6 + var_47_7 and arg_44_1.time_ < var_47_6 + var_47_7 + arg_47_0 then
				arg_44_1.allBtn_.enabled = true
			end

			local var_47_8 = 0.733333333333333
			local var_47_9 = 1

			if var_47_8 < arg_44_1.time_ and arg_44_1.time_ <= var_47_8 + arg_47_0 then
				local var_47_10 = "play"
				local var_47_11 = "effect"

				arg_44_1:AudioAction(var_47_10, var_47_11, "se_story_activity_1_1", "se_story_activity_1_1_hel_cannon", "")
			end

			local var_47_12 = 0
			local var_47_13 = 1

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				local var_47_14 = "play"
				local var_47_15 = "music"

				arg_44_1:AudioAction(var_47_14, var_47_15, "", "", "")

				local var_47_16 = ""
				local var_47_17 = manager.audio:GetAudioName("", "")

				if var_47_17 ~= "" then
					if arg_44_1.bgmTxt_.text ~= var_47_17 and arg_44_1.bgmTxt_.text ~= "" then
						if arg_44_1.bgmTxt2_.text ~= "" then
							arg_44_1.bgmTxt_.text = arg_44_1.bgmTxt2_.text
						end

						arg_44_1.bgmTxt2_.text = var_47_17

						arg_44_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_44_1.bgmTxt_.text = var_47_17
						arg_44_1.bgmTxt2_.text = var_47_17
					end

					if arg_44_1.bgmTimer then
						arg_44_1.bgmTimer:Stop()

						arg_44_1.bgmTimer = nil
					end

					if arg_44_1.settingData.show_music_name == 1 then
						arg_44_1.musicController:SetSelectedState("show")
						arg_44_1.musicAnimator_:Play("open", 0, 0)

						if arg_44_1.settingData.music_time ~= 0 then
							arg_44_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_44_1.settingData.music_time), function()
								if arg_44_1 == nil or isNil(arg_44_1.bgmTxt_) then
									return
								end

								arg_44_1.musicController:SetSelectedState("hide")
								arg_44_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_18 = 1
			local var_47_19 = 1.05

			if var_47_18 < arg_44_1.time_ and arg_44_1.time_ <= var_47_18 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_20 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_20:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_44_1.dialogCg_.alpha = arg_49_0
				end))
				var_47_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_21 = arg_44_1:GetWordFromCfg(111152011)
				local var_47_22 = arg_44_1:FormatText(var_47_21.content)

				arg_44_1.text_.text = var_47_22

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_23 = 42
				local var_47_24 = utf8.len(var_47_22)
				local var_47_25 = var_47_23 <= 0 and var_47_19 or var_47_19 * (var_47_24 / var_47_23)

				if var_47_25 > 0 and var_47_19 < var_47_25 then
					arg_44_1.talkMaxDuration = var_47_25
					var_47_18 = var_47_18 + 0.3

					if var_47_25 + var_47_18 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_25 + var_47_18
					end
				end

				arg_44_1.text_.text = var_47_22
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_26 = var_47_18 + 0.3
			local var_47_27 = math.max(var_47_19, arg_44_1.talkMaxDuration)

			if var_47_26 <= arg_44_1.time_ and arg_44_1.time_ < var_47_26 + var_47_27 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_26) / var_47_27

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_26 + var_47_27 and arg_44_1.time_ < var_47_26 + var_47_27 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play111152012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 111152012
		arg_51_1.duration_ = 3.8

		local var_51_0 = {
			ja = 3.8,
			ko = 2.333,
			zh = 2.266,
			en = 1.866
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play111152013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.2

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[181].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:GetWordFromCfg(111152012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 8
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111152", "111152012", "story_v_out_111152.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_111152", "111152012", "story_v_out_111152.awb") / 1000

					if var_54_8 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_0
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_111152", "111152012", "story_v_out_111152.awb")

						arg_51_1:RecordAudio("111152012", var_54_9)
						arg_51_1:RecordAudio("111152012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_111152", "111152012", "story_v_out_111152.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_111152", "111152012", "story_v_out_111152.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_10 and arg_51_1.time_ < var_54_0 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play111152013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 111152013
		arg_55_1.duration_ = 2

		local var_55_0 = {
			ja = 2,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play111152014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_58_2 = arg_55_1.actors_["1084ui_story"]
			local var_58_3 = 0

			if var_58_3 < arg_55_1.time_ and arg_55_1.time_ <= var_58_3 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect1084ui_story == nil then
				arg_55_1.var_.characterEffect1084ui_story = var_58_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_4 = 0.2

			if var_58_3 <= arg_55_1.time_ and arg_55_1.time_ < var_58_3 + var_58_4 and not isNil(var_58_2) then
				local var_58_5 = (arg_55_1.time_ - var_58_3) / var_58_4

				if arg_55_1.var_.characterEffect1084ui_story and not isNil(var_58_2) then
					arg_55_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_3 + var_58_4 and arg_55_1.time_ < var_58_3 + var_58_4 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect1084ui_story then
				arg_55_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_58_6 = arg_55_1.actors_["1084ui_story"].transform
			local var_58_7 = 0

			if var_58_7 < arg_55_1.time_ and arg_55_1.time_ <= var_58_7 + arg_58_0 then
				arg_55_1.var_.moveOldPos1084ui_story = var_58_6.localPosition

				local var_58_8 = "1084ui_story"

				arg_55_1:ShowWeapon(arg_55_1.var_[var_58_8 .. "Animator"].transform, false)
			end

			local var_58_9 = 0.001

			if var_58_7 <= arg_55_1.time_ and arg_55_1.time_ < var_58_7 + var_58_9 then
				local var_58_10 = (arg_55_1.time_ - var_58_7) / var_58_9
				local var_58_11 = Vector3.New(0, -0.97, -6)

				var_58_6.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1084ui_story, var_58_11, var_58_10)

				local var_58_12 = manager.ui.mainCamera.transform.position - var_58_6.position

				var_58_6.forward = Vector3.New(var_58_12.x, var_58_12.y, var_58_12.z)

				local var_58_13 = var_58_6.localEulerAngles

				var_58_13.z = 0
				var_58_13.x = 0
				var_58_6.localEulerAngles = var_58_13
			end

			if arg_55_1.time_ >= var_58_7 + var_58_9 and arg_55_1.time_ < var_58_7 + var_58_9 + arg_58_0 then
				var_58_6.localPosition = Vector3.New(0, -0.97, -6)

				local var_58_14 = manager.ui.mainCamera.transform.position - var_58_6.position

				var_58_6.forward = Vector3.New(var_58_14.x, var_58_14.y, var_58_14.z)

				local var_58_15 = var_58_6.localEulerAngles

				var_58_15.z = 0
				var_58_15.x = 0
				var_58_6.localEulerAngles = var_58_15
			end

			local var_58_16 = 0
			local var_58_17 = 0.1

			if var_58_16 < arg_55_1.time_ and arg_55_1.time_ <= var_58_16 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_18 = arg_55_1:FormatText(StoryNameCfg[6].name)

				arg_55_1.leftNameTxt_.text = var_58_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_19 = arg_55_1:GetWordFromCfg(111152013)
				local var_58_20 = arg_55_1:FormatText(var_58_19.content)

				arg_55_1.text_.text = var_58_20

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_21 = 4
				local var_58_22 = utf8.len(var_58_20)
				local var_58_23 = var_58_21 <= 0 and var_58_17 or var_58_17 * (var_58_22 / var_58_21)

				if var_58_23 > 0 and var_58_17 < var_58_23 then
					arg_55_1.talkMaxDuration = var_58_23

					if var_58_23 + var_58_16 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_23 + var_58_16
					end
				end

				arg_55_1.text_.text = var_58_20
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111152", "111152013", "story_v_out_111152.awb") ~= 0 then
					local var_58_24 = manager.audio:GetVoiceLength("story_v_out_111152", "111152013", "story_v_out_111152.awb") / 1000

					if var_58_24 + var_58_16 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_24 + var_58_16
					end

					if var_58_19.prefab_name ~= "" and arg_55_1.actors_[var_58_19.prefab_name] ~= nil then
						local var_58_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_19.prefab_name].transform, "story_v_out_111152", "111152013", "story_v_out_111152.awb")

						arg_55_1:RecordAudio("111152013", var_58_25)
						arg_55_1:RecordAudio("111152013", var_58_25)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_111152", "111152013", "story_v_out_111152.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_111152", "111152013", "story_v_out_111152.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_26 = math.max(var_58_17, arg_55_1.talkMaxDuration)

			if var_58_16 <= arg_55_1.time_ and arg_55_1.time_ < var_58_16 + var_58_26 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_16) / var_58_26

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_16 + var_58_26 and arg_55_1.time_ < var_58_16 + var_58_26 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play111152014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 111152014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play111152015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1084ui_story"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos1084ui_story = var_62_0.localPosition
			end

			local var_62_2 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2
				local var_62_4 = Vector3.New(0, 100, 0)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1084ui_story, var_62_4, var_62_3)

				local var_62_5 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_5.x, var_62_5.y, var_62_5.z)

				local var_62_6 = var_62_0.localEulerAngles

				var_62_6.z = 0
				var_62_6.x = 0
				var_62_0.localEulerAngles = var_62_6
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, 100, 0)

				local var_62_7 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_7.x, var_62_7.y, var_62_7.z)

				local var_62_8 = var_62_0.localEulerAngles

				var_62_8.z = 0
				var_62_8.x = 0
				var_62_0.localEulerAngles = var_62_8
			end

			local var_62_9 = 0
			local var_62_10 = 0.35

			if var_62_9 < arg_59_1.time_ and arg_59_1.time_ <= var_62_9 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_11 = arg_59_1:FormatText(StoryNameCfg[7].name)

				arg_59_1.leftNameTxt_.text = var_62_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_12 = arg_59_1:GetWordFromCfg(111152014)
				local var_62_13 = arg_59_1:FormatText(var_62_12.content)

				arg_59_1.text_.text = var_62_13

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_14 = 14
				local var_62_15 = utf8.len(var_62_13)
				local var_62_16 = var_62_14 <= 0 and var_62_10 or var_62_10 * (var_62_15 / var_62_14)

				if var_62_16 > 0 and var_62_10 < var_62_16 then
					arg_59_1.talkMaxDuration = var_62_16

					if var_62_16 + var_62_9 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_16 + var_62_9
					end
				end

				arg_59_1.text_.text = var_62_13
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_17 = math.max(var_62_10, arg_59_1.talkMaxDuration)

			if var_62_9 <= arg_59_1.time_ and arg_59_1.time_ < var_62_9 + var_62_17 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_9) / var_62_17

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_9 + var_62_17 and arg_59_1.time_ < var_62_9 + var_62_17 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play111152015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 111152015
		arg_63_1.duration_ = 7.17

		local var_63_0 = {
			ja = 7.166,
			ko = 4.633,
			zh = 5.8,
			en = 4
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play111152016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = "1094ui_story"

			if arg_63_1.actors_[var_66_0] == nil then
				local var_66_1 = Asset.Load("Char/" .. "1094ui_story")

				if not isNil(var_66_1) then
					local var_66_2 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_63_1.stage_.transform)

					var_66_2.name = var_66_0
					var_66_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_63_1.actors_[var_66_0] = var_66_2

					local var_66_3 = var_66_2:GetComponentInChildren(typeof(CharacterEffect))

					var_66_3.enabled = true

					local var_66_4 = GameObjectTools.GetOrAddComponent(var_66_2, typeof(DynamicBoneHelper))

					if var_66_4 then
						var_66_4:EnableDynamicBone(false)
					end

					arg_63_1:ShowWeapon(var_66_3.transform, false)

					arg_63_1.var_[var_66_0 .. "Animator"] = var_66_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_63_1.var_[var_66_0 .. "Animator"].applyRootMotion = true
					arg_63_1.var_[var_66_0 .. "LipSync"] = var_66_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_66_5 = arg_63_1.actors_["1094ui_story"].transform
			local var_66_6 = 0

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.var_.moveOldPos1094ui_story = var_66_5.localPosition
			end

			local var_66_7 = 0.001

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_7 then
				local var_66_8 = (arg_63_1.time_ - var_66_6) / var_66_7
				local var_66_9 = Vector3.New(0, -0.84, -6.1)

				var_66_5.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1094ui_story, var_66_9, var_66_8)

				local var_66_10 = manager.ui.mainCamera.transform.position - var_66_5.position

				var_66_5.forward = Vector3.New(var_66_10.x, var_66_10.y, var_66_10.z)

				local var_66_11 = var_66_5.localEulerAngles

				var_66_11.z = 0
				var_66_11.x = 0
				var_66_5.localEulerAngles = var_66_11
			end

			if arg_63_1.time_ >= var_66_6 + var_66_7 and arg_63_1.time_ < var_66_6 + var_66_7 + arg_66_0 then
				var_66_5.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_66_12 = manager.ui.mainCamera.transform.position - var_66_5.position

				var_66_5.forward = Vector3.New(var_66_12.x, var_66_12.y, var_66_12.z)

				local var_66_13 = var_66_5.localEulerAngles

				var_66_13.z = 0
				var_66_13.x = 0
				var_66_5.localEulerAngles = var_66_13
			end

			local var_66_14 = 0

			if var_66_14 < arg_63_1.time_ and arg_63_1.time_ <= var_66_14 + arg_66_0 then
				arg_63_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_66_15 = 0

			if var_66_15 < arg_63_1.time_ and arg_63_1.time_ <= var_66_15 + arg_66_0 then
				arg_63_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_66_16 = arg_63_1.actors_["1094ui_story"]
			local var_66_17 = 0

			if var_66_17 < arg_63_1.time_ and arg_63_1.time_ <= var_66_17 + arg_66_0 and not isNil(var_66_16) and arg_63_1.var_.characterEffect1094ui_story == nil then
				arg_63_1.var_.characterEffect1094ui_story = var_66_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_18 = 0.2

			if var_66_17 <= arg_63_1.time_ and arg_63_1.time_ < var_66_17 + var_66_18 and not isNil(var_66_16) then
				local var_66_19 = (arg_63_1.time_ - var_66_17) / var_66_18

				if arg_63_1.var_.characterEffect1094ui_story and not isNil(var_66_16) then
					arg_63_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_17 + var_66_18 and arg_63_1.time_ < var_66_17 + var_66_18 + arg_66_0 and not isNil(var_66_16) and arg_63_1.var_.characterEffect1094ui_story then
				arg_63_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_66_20 = 0
			local var_66_21 = 0.475

			if var_66_20 < arg_63_1.time_ and arg_63_1.time_ <= var_66_20 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_22 = arg_63_1:FormatText(StoryNameCfg[181].name)

				arg_63_1.leftNameTxt_.text = var_66_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_23 = arg_63_1:GetWordFromCfg(111152015)
				local var_66_24 = arg_63_1:FormatText(var_66_23.content)

				arg_63_1.text_.text = var_66_24

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_25 = 19
				local var_66_26 = utf8.len(var_66_24)
				local var_66_27 = var_66_25 <= 0 and var_66_21 or var_66_21 * (var_66_26 / var_66_25)

				if var_66_27 > 0 and var_66_21 < var_66_27 then
					arg_63_1.talkMaxDuration = var_66_27

					if var_66_27 + var_66_20 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_27 + var_66_20
					end
				end

				arg_63_1.text_.text = var_66_24
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111152", "111152015", "story_v_out_111152.awb") ~= 0 then
					local var_66_28 = manager.audio:GetVoiceLength("story_v_out_111152", "111152015", "story_v_out_111152.awb") / 1000

					if var_66_28 + var_66_20 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_28 + var_66_20
					end

					if var_66_23.prefab_name ~= "" and arg_63_1.actors_[var_66_23.prefab_name] ~= nil then
						local var_66_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_23.prefab_name].transform, "story_v_out_111152", "111152015", "story_v_out_111152.awb")

						arg_63_1:RecordAudio("111152015", var_66_29)
						arg_63_1:RecordAudio("111152015", var_66_29)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_111152", "111152015", "story_v_out_111152.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_111152", "111152015", "story_v_out_111152.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_30 = math.max(var_66_21, arg_63_1.talkMaxDuration)

			if var_66_20 <= arg_63_1.time_ and arg_63_1.time_ < var_66_20 + var_66_30 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_20) / var_66_30

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_20 + var_66_30 and arg_63_1.time_ < var_66_20 + var_66_30 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play111152016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 111152016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play111152017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1094ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1094ui_story == nil then
				arg_67_1.var_.characterEffect1094ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.2

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect1094ui_story and not isNil(var_70_0) then
					local var_70_4 = Mathf.Lerp(0, 0.5, var_70_3)

					arg_67_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1094ui_story.fillRatio = var_70_4
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1094ui_story then
				local var_70_5 = 0.5

				arg_67_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1094ui_story.fillRatio = var_70_5
			end

			local var_70_6 = 0
			local var_70_7 = 0.7

			if var_70_6 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_8 = arg_67_1:FormatText(StoryNameCfg[7].name)

				arg_67_1.leftNameTxt_.text = var_70_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_9 = arg_67_1:GetWordFromCfg(111152016)
				local var_70_10 = arg_67_1:FormatText(var_70_9.content)

				arg_67_1.text_.text = var_70_10

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_11 = 28
				local var_70_12 = utf8.len(var_70_10)
				local var_70_13 = var_70_11 <= 0 and var_70_7 or var_70_7 * (var_70_12 / var_70_11)

				if var_70_13 > 0 and var_70_7 < var_70_13 then
					arg_67_1.talkMaxDuration = var_70_13

					if var_70_13 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_13 + var_70_6
					end
				end

				arg_67_1.text_.text = var_70_10
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_14 = math.max(var_70_7, arg_67_1.talkMaxDuration)

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_14 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_6) / var_70_14

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_6 + var_70_14 and arg_67_1.time_ < var_70_6 + var_70_14 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play111152017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 111152017
		arg_71_1.duration_ = 6.93

		local var_71_0 = {
			ja = 4.7,
			ko = 6.933,
			zh = 5,
			en = 4.166
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play111152018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_74_1 = arg_71_1.actors_["1094ui_story"]
			local var_74_2 = 0

			if var_74_2 < arg_71_1.time_ and arg_71_1.time_ <= var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1094ui_story == nil then
				arg_71_1.var_.characterEffect1094ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_3 = 0.2

			if var_74_2 <= arg_71_1.time_ and arg_71_1.time_ < var_74_2 + var_74_3 and not isNil(var_74_1) then
				local var_74_4 = (arg_71_1.time_ - var_74_2) / var_74_3

				if arg_71_1.var_.characterEffect1094ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_2 + var_74_3 and arg_71_1.time_ < var_74_2 + var_74_3 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1094ui_story then
				arg_71_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_74_5 = 0
			local var_74_6 = 0.75

			if var_74_5 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_7 = arg_71_1:FormatText(StoryNameCfg[181].name)

				arg_71_1.leftNameTxt_.text = var_74_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:GetWordFromCfg(111152017)
				local var_74_9 = arg_71_1:FormatText(var_74_8.content)

				arg_71_1.text_.text = var_74_9

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_10 = 16
				local var_74_11 = utf8.len(var_74_9)
				local var_74_12 = var_74_10 <= 0 and var_74_6 or var_74_6 * (var_74_11 / var_74_10)

				if var_74_12 > 0 and var_74_6 < var_74_12 then
					arg_71_1.talkMaxDuration = var_74_12

					if var_74_12 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_5
					end
				end

				arg_71_1.text_.text = var_74_9
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111152", "111152017", "story_v_out_111152.awb") ~= 0 then
					local var_74_13 = manager.audio:GetVoiceLength("story_v_out_111152", "111152017", "story_v_out_111152.awb") / 1000

					if var_74_13 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_5
					end

					if var_74_8.prefab_name ~= "" and arg_71_1.actors_[var_74_8.prefab_name] ~= nil then
						local var_74_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_8.prefab_name].transform, "story_v_out_111152", "111152017", "story_v_out_111152.awb")

						arg_71_1:RecordAudio("111152017", var_74_14)
						arg_71_1:RecordAudio("111152017", var_74_14)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_111152", "111152017", "story_v_out_111152.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_111152", "111152017", "story_v_out_111152.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_15 = math.max(var_74_6, arg_71_1.talkMaxDuration)

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_15 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_5) / var_74_15

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_5 + var_74_15 and arg_71_1.time_ < var_74_5 + var_74_15 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play111152018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 111152018
		arg_75_1.duration_ = 5.6

		local var_75_0 = {
			ja = 5.6,
			ko = 4.433,
			zh = 4.066,
			en = 5.233
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play111152019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = "1039ui_story"

			if arg_75_1.actors_[var_78_0] == nil then
				local var_78_1 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_78_1) then
					local var_78_2 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_75_1.stage_.transform)

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

			local var_78_5 = arg_75_1.actors_["1039ui_story"].transform
			local var_78_6 = 0

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.var_.moveOldPos1039ui_story = var_78_5.localPosition
			end

			local var_78_7 = 0.001

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_7 then
				local var_78_8 = (arg_75_1.time_ - var_78_6) / var_78_7
				local var_78_9 = Vector3.New(0, -1.01, -5.9)

				var_78_5.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1039ui_story, var_78_9, var_78_8)

				local var_78_10 = manager.ui.mainCamera.transform.position - var_78_5.position

				var_78_5.forward = Vector3.New(var_78_10.x, var_78_10.y, var_78_10.z)

				local var_78_11 = var_78_5.localEulerAngles

				var_78_11.z = 0
				var_78_11.x = 0
				var_78_5.localEulerAngles = var_78_11
			end

			if arg_75_1.time_ >= var_78_6 + var_78_7 and arg_75_1.time_ < var_78_6 + var_78_7 + arg_78_0 then
				var_78_5.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_78_12 = manager.ui.mainCamera.transform.position - var_78_5.position

				var_78_5.forward = Vector3.New(var_78_12.x, var_78_12.y, var_78_12.z)

				local var_78_13 = var_78_5.localEulerAngles

				var_78_13.z = 0
				var_78_13.x = 0
				var_78_5.localEulerAngles = var_78_13
			end

			local var_78_14 = 0

			if var_78_14 < arg_75_1.time_ and arg_75_1.time_ <= var_78_14 + arg_78_0 then
				arg_75_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_78_15 = 0

			if var_78_15 < arg_75_1.time_ and arg_75_1.time_ <= var_78_15 + arg_78_0 then
				arg_75_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_78_16 = arg_75_1.actors_["1039ui_story"]
			local var_78_17 = 0

			if var_78_17 < arg_75_1.time_ and arg_75_1.time_ <= var_78_17 + arg_78_0 and not isNil(var_78_16) and arg_75_1.var_.characterEffect1039ui_story == nil then
				arg_75_1.var_.characterEffect1039ui_story = var_78_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_18 = 0.2

			if var_78_17 <= arg_75_1.time_ and arg_75_1.time_ < var_78_17 + var_78_18 and not isNil(var_78_16) then
				local var_78_19 = (arg_75_1.time_ - var_78_17) / var_78_18

				if arg_75_1.var_.characterEffect1039ui_story and not isNil(var_78_16) then
					arg_75_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_17 + var_78_18 and arg_75_1.time_ < var_78_17 + var_78_18 + arg_78_0 and not isNil(var_78_16) and arg_75_1.var_.characterEffect1039ui_story then
				arg_75_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_78_20 = arg_75_1.actors_["1094ui_story"].transform
			local var_78_21 = 0

			if var_78_21 < arg_75_1.time_ and arg_75_1.time_ <= var_78_21 + arg_78_0 then
				arg_75_1.var_.moveOldPos1094ui_story = var_78_20.localPosition
			end

			local var_78_22 = 0.001

			if var_78_21 <= arg_75_1.time_ and arg_75_1.time_ < var_78_21 + var_78_22 then
				local var_78_23 = (arg_75_1.time_ - var_78_21) / var_78_22
				local var_78_24 = Vector3.New(0, 100, 0)

				var_78_20.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1094ui_story, var_78_24, var_78_23)

				local var_78_25 = manager.ui.mainCamera.transform.position - var_78_20.position

				var_78_20.forward = Vector3.New(var_78_25.x, var_78_25.y, var_78_25.z)

				local var_78_26 = var_78_20.localEulerAngles

				var_78_26.z = 0
				var_78_26.x = 0
				var_78_20.localEulerAngles = var_78_26
			end

			if arg_75_1.time_ >= var_78_21 + var_78_22 and arg_75_1.time_ < var_78_21 + var_78_22 + arg_78_0 then
				var_78_20.localPosition = Vector3.New(0, 100, 0)

				local var_78_27 = manager.ui.mainCamera.transform.position - var_78_20.position

				var_78_20.forward = Vector3.New(var_78_27.x, var_78_27.y, var_78_27.z)

				local var_78_28 = var_78_20.localEulerAngles

				var_78_28.z = 0
				var_78_28.x = 0
				var_78_20.localEulerAngles = var_78_28
			end

			local var_78_29 = 0
			local var_78_30 = 0.475

			if var_78_29 < arg_75_1.time_ and arg_75_1.time_ <= var_78_29 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_31 = arg_75_1:FormatText(StoryNameCfg[9].name)

				arg_75_1.leftNameTxt_.text = var_78_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_32 = arg_75_1:GetWordFromCfg(111152018)
				local var_78_33 = arg_75_1:FormatText(var_78_32.content)

				arg_75_1.text_.text = var_78_33

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_34 = 19
				local var_78_35 = utf8.len(var_78_33)
				local var_78_36 = var_78_34 <= 0 and var_78_30 or var_78_30 * (var_78_35 / var_78_34)

				if var_78_36 > 0 and var_78_30 < var_78_36 then
					arg_75_1.talkMaxDuration = var_78_36

					if var_78_36 + var_78_29 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_36 + var_78_29
					end
				end

				arg_75_1.text_.text = var_78_33
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111152", "111152018", "story_v_out_111152.awb") ~= 0 then
					local var_78_37 = manager.audio:GetVoiceLength("story_v_out_111152", "111152018", "story_v_out_111152.awb") / 1000

					if var_78_37 + var_78_29 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_37 + var_78_29
					end

					if var_78_32.prefab_name ~= "" and arg_75_1.actors_[var_78_32.prefab_name] ~= nil then
						local var_78_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_32.prefab_name].transform, "story_v_out_111152", "111152018", "story_v_out_111152.awb")

						arg_75_1:RecordAudio("111152018", var_78_38)
						arg_75_1:RecordAudio("111152018", var_78_38)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_111152", "111152018", "story_v_out_111152.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_111152", "111152018", "story_v_out_111152.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_39 = math.max(var_78_30, arg_75_1.talkMaxDuration)

			if var_78_29 <= arg_75_1.time_ and arg_75_1.time_ < var_78_29 + var_78_39 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_29) / var_78_39

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_29 + var_78_39 and arg_75_1.time_ < var_78_29 + var_78_39 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play111152019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 111152019
		arg_79_1.duration_ = 5.3

		local var_79_0 = {
			ja = 4.766,
			ko = 4.533,
			zh = 5.033,
			en = 5.3
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
				arg_79_0:Play111152020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action435")
			end

			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_82_2 = arg_79_1.actors_["1084ui_story"]
			local var_82_3 = 0

			if var_82_3 < arg_79_1.time_ and arg_79_1.time_ <= var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect1084ui_story == nil then
				arg_79_1.var_.characterEffect1084ui_story = var_82_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_4 = 0.2

			if var_82_3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_3 + var_82_4 and not isNil(var_82_2) then
				local var_82_5 = (arg_79_1.time_ - var_82_3) / var_82_4

				if arg_79_1.var_.characterEffect1084ui_story and not isNil(var_82_2) then
					arg_79_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_3 + var_82_4 and arg_79_1.time_ < var_82_3 + var_82_4 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect1084ui_story then
				arg_79_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_82_6 = arg_79_1.actors_["1039ui_story"]
			local var_82_7 = 0

			if var_82_7 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect1039ui_story == nil then
				arg_79_1.var_.characterEffect1039ui_story = var_82_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_8 = 0.2

			if var_82_7 <= arg_79_1.time_ and arg_79_1.time_ < var_82_7 + var_82_8 and not isNil(var_82_6) then
				local var_82_9 = (arg_79_1.time_ - var_82_7) / var_82_8

				if arg_79_1.var_.characterEffect1039ui_story and not isNil(var_82_6) then
					local var_82_10 = Mathf.Lerp(0, 0.5, var_82_9)

					arg_79_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1039ui_story.fillRatio = var_82_10
				end
			end

			if arg_79_1.time_ >= var_82_7 + var_82_8 and arg_79_1.time_ < var_82_7 + var_82_8 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect1039ui_story then
				local var_82_11 = 0.5

				arg_79_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1039ui_story.fillRatio = var_82_11
			end

			local var_82_12 = arg_79_1.actors_["1084ui_story"].transform
			local var_82_13 = 0

			if var_82_13 < arg_79_1.time_ and arg_79_1.time_ <= var_82_13 + arg_82_0 then
				arg_79_1.var_.moveOldPos1084ui_story = var_82_12.localPosition
			end

			local var_82_14 = 0.001

			if var_82_13 <= arg_79_1.time_ and arg_79_1.time_ < var_82_13 + var_82_14 then
				local var_82_15 = (arg_79_1.time_ - var_82_13) / var_82_14
				local var_82_16 = Vector3.New(0.7, -0.97, -6)

				var_82_12.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1084ui_story, var_82_16, var_82_15)

				local var_82_17 = manager.ui.mainCamera.transform.position - var_82_12.position

				var_82_12.forward = Vector3.New(var_82_17.x, var_82_17.y, var_82_17.z)

				local var_82_18 = var_82_12.localEulerAngles

				var_82_18.z = 0
				var_82_18.x = 0
				var_82_12.localEulerAngles = var_82_18
			end

			if arg_79_1.time_ >= var_82_13 + var_82_14 and arg_79_1.time_ < var_82_13 + var_82_14 + arg_82_0 then
				var_82_12.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_82_19 = manager.ui.mainCamera.transform.position - var_82_12.position

				var_82_12.forward = Vector3.New(var_82_19.x, var_82_19.y, var_82_19.z)

				local var_82_20 = var_82_12.localEulerAngles

				var_82_20.z = 0
				var_82_20.x = 0
				var_82_12.localEulerAngles = var_82_20
			end

			local var_82_21 = arg_79_1.actors_["1039ui_story"].transform
			local var_82_22 = 0

			if var_82_22 < arg_79_1.time_ and arg_79_1.time_ <= var_82_22 + arg_82_0 then
				arg_79_1.var_.moveOldPos1039ui_story = var_82_21.localPosition
			end

			local var_82_23 = 0.5

			if var_82_22 <= arg_79_1.time_ and arg_79_1.time_ < var_82_22 + var_82_23 then
				local var_82_24 = (arg_79_1.time_ - var_82_22) / var_82_23
				local var_82_25 = Vector3.New(-0.7, -1.01, -5.9)

				var_82_21.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1039ui_story, var_82_25, var_82_24)

				local var_82_26 = manager.ui.mainCamera.transform.position - var_82_21.position

				var_82_21.forward = Vector3.New(var_82_26.x, var_82_26.y, var_82_26.z)

				local var_82_27 = var_82_21.localEulerAngles

				var_82_27.z = 0
				var_82_27.x = 0
				var_82_21.localEulerAngles = var_82_27
			end

			if arg_79_1.time_ >= var_82_22 + var_82_23 and arg_79_1.time_ < var_82_22 + var_82_23 + arg_82_0 then
				var_82_21.localPosition = Vector3.New(-0.7, -1.01, -5.9)

				local var_82_28 = manager.ui.mainCamera.transform.position - var_82_21.position

				var_82_21.forward = Vector3.New(var_82_28.x, var_82_28.y, var_82_28.z)

				local var_82_29 = var_82_21.localEulerAngles

				var_82_29.z = 0
				var_82_29.x = 0
				var_82_21.localEulerAngles = var_82_29
			end

			local var_82_30 = 0
			local var_82_31 = 0.65

			if var_82_30 < arg_79_1.time_ and arg_79_1.time_ <= var_82_30 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_32 = arg_79_1:FormatText(StoryNameCfg[6].name)

				arg_79_1.leftNameTxt_.text = var_82_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_33 = arg_79_1:GetWordFromCfg(111152019)
				local var_82_34 = arg_79_1:FormatText(var_82_33.content)

				arg_79_1.text_.text = var_82_34

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_35 = 26
				local var_82_36 = utf8.len(var_82_34)
				local var_82_37 = var_82_35 <= 0 and var_82_31 or var_82_31 * (var_82_36 / var_82_35)

				if var_82_37 > 0 and var_82_31 < var_82_37 then
					arg_79_1.talkMaxDuration = var_82_37

					if var_82_37 + var_82_30 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_37 + var_82_30
					end
				end

				arg_79_1.text_.text = var_82_34
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111152", "111152019", "story_v_out_111152.awb") ~= 0 then
					local var_82_38 = manager.audio:GetVoiceLength("story_v_out_111152", "111152019", "story_v_out_111152.awb") / 1000

					if var_82_38 + var_82_30 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_38 + var_82_30
					end

					if var_82_33.prefab_name ~= "" and arg_79_1.actors_[var_82_33.prefab_name] ~= nil then
						local var_82_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_33.prefab_name].transform, "story_v_out_111152", "111152019", "story_v_out_111152.awb")

						arg_79_1:RecordAudio("111152019", var_82_39)
						arg_79_1:RecordAudio("111152019", var_82_39)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_111152", "111152019", "story_v_out_111152.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_111152", "111152019", "story_v_out_111152.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_40 = math.max(var_82_31, arg_79_1.talkMaxDuration)

			if var_82_30 <= arg_79_1.time_ and arg_79_1.time_ < var_82_30 + var_82_40 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_30) / var_82_40

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_30 + var_82_40 and arg_79_1.time_ < var_82_30 + var_82_40 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play111152020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 111152020
		arg_83_1.duration_ = 4.07

		local var_83_0 = {
			ja = 4.066,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play111152021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_86_1 = arg_83_1.actors_["1094ui_story"]
			local var_86_2 = 0

			if var_86_2 < arg_83_1.time_ and arg_83_1.time_ <= var_86_2 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1094ui_story == nil then
				arg_83_1.var_.characterEffect1094ui_story = var_86_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_3 = 0.2

			if var_86_2 <= arg_83_1.time_ and arg_83_1.time_ < var_86_2 + var_86_3 and not isNil(var_86_1) then
				local var_86_4 = (arg_83_1.time_ - var_86_2) / var_86_3

				if arg_83_1.var_.characterEffect1094ui_story and not isNil(var_86_1) then
					arg_83_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_2 + var_86_3 and arg_83_1.time_ < var_86_2 + var_86_3 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1094ui_story then
				arg_83_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_86_5 = arg_83_1.actors_["1084ui_story"].transform
			local var_86_6 = 0

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.var_.moveOldPos1084ui_story = var_86_5.localPosition
			end

			local var_86_7 = 0.001

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_7 then
				local var_86_8 = (arg_83_1.time_ - var_86_6) / var_86_7
				local var_86_9 = Vector3.New(0, 100, 0)

				var_86_5.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1084ui_story, var_86_9, var_86_8)

				local var_86_10 = manager.ui.mainCamera.transform.position - var_86_5.position

				var_86_5.forward = Vector3.New(var_86_10.x, var_86_10.y, var_86_10.z)

				local var_86_11 = var_86_5.localEulerAngles

				var_86_11.z = 0
				var_86_11.x = 0
				var_86_5.localEulerAngles = var_86_11
			end

			if arg_83_1.time_ >= var_86_6 + var_86_7 and arg_83_1.time_ < var_86_6 + var_86_7 + arg_86_0 then
				var_86_5.localPosition = Vector3.New(0, 100, 0)

				local var_86_12 = manager.ui.mainCamera.transform.position - var_86_5.position

				var_86_5.forward = Vector3.New(var_86_12.x, var_86_12.y, var_86_12.z)

				local var_86_13 = var_86_5.localEulerAngles

				var_86_13.z = 0
				var_86_13.x = 0
				var_86_5.localEulerAngles = var_86_13
			end

			local var_86_14 = arg_83_1.actors_["1039ui_story"].transform
			local var_86_15 = 0

			if var_86_15 < arg_83_1.time_ and arg_83_1.time_ <= var_86_15 + arg_86_0 then
				arg_83_1.var_.moveOldPos1039ui_story = var_86_14.localPosition
			end

			local var_86_16 = 0.001

			if var_86_15 <= arg_83_1.time_ and arg_83_1.time_ < var_86_15 + var_86_16 then
				local var_86_17 = (arg_83_1.time_ - var_86_15) / var_86_16
				local var_86_18 = Vector3.New(0, 100, 0)

				var_86_14.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1039ui_story, var_86_18, var_86_17)

				local var_86_19 = manager.ui.mainCamera.transform.position - var_86_14.position

				var_86_14.forward = Vector3.New(var_86_19.x, var_86_19.y, var_86_19.z)

				local var_86_20 = var_86_14.localEulerAngles

				var_86_20.z = 0
				var_86_20.x = 0
				var_86_14.localEulerAngles = var_86_20
			end

			if arg_83_1.time_ >= var_86_15 + var_86_16 and arg_83_1.time_ < var_86_15 + var_86_16 + arg_86_0 then
				var_86_14.localPosition = Vector3.New(0, 100, 0)

				local var_86_21 = manager.ui.mainCamera.transform.position - var_86_14.position

				var_86_14.forward = Vector3.New(var_86_21.x, var_86_21.y, var_86_21.z)

				local var_86_22 = var_86_14.localEulerAngles

				var_86_22.z = 0
				var_86_22.x = 0
				var_86_14.localEulerAngles = var_86_22
			end

			local var_86_23 = 0

			if var_86_23 < arg_83_1.time_ and arg_83_1.time_ <= var_86_23 + arg_86_0 then
				arg_83_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_86_24 = arg_83_1.actors_["1094ui_story"].transform
			local var_86_25 = 0

			if var_86_25 < arg_83_1.time_ and arg_83_1.time_ <= var_86_25 + arg_86_0 then
				arg_83_1.var_.moveOldPos1094ui_story = var_86_24.localPosition
			end

			local var_86_26 = 0.001

			if var_86_25 <= arg_83_1.time_ and arg_83_1.time_ < var_86_25 + var_86_26 then
				local var_86_27 = (arg_83_1.time_ - var_86_25) / var_86_26
				local var_86_28 = Vector3.New(0, -0.84, -6.1)

				var_86_24.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1094ui_story, var_86_28, var_86_27)

				local var_86_29 = manager.ui.mainCamera.transform.position - var_86_24.position

				var_86_24.forward = Vector3.New(var_86_29.x, var_86_29.y, var_86_29.z)

				local var_86_30 = var_86_24.localEulerAngles

				var_86_30.z = 0
				var_86_30.x = 0
				var_86_24.localEulerAngles = var_86_30
			end

			if arg_83_1.time_ >= var_86_25 + var_86_26 and arg_83_1.time_ < var_86_25 + var_86_26 + arg_86_0 then
				var_86_24.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_86_31 = manager.ui.mainCamera.transform.position - var_86_24.position

				var_86_24.forward = Vector3.New(var_86_31.x, var_86_31.y, var_86_31.z)

				local var_86_32 = var_86_24.localEulerAngles

				var_86_32.z = 0
				var_86_32.x = 0
				var_86_24.localEulerAngles = var_86_32
			end

			local var_86_33 = 0
			local var_86_34 = 0.075

			if var_86_33 < arg_83_1.time_ and arg_83_1.time_ <= var_86_33 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_35 = arg_83_1:FormatText(StoryNameCfg[181].name)

				arg_83_1.leftNameTxt_.text = var_86_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_36 = arg_83_1:GetWordFromCfg(111152020)
				local var_86_37 = arg_83_1:FormatText(var_86_36.content)

				arg_83_1.text_.text = var_86_37

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_38 = 3
				local var_86_39 = utf8.len(var_86_37)
				local var_86_40 = var_86_38 <= 0 and var_86_34 or var_86_34 * (var_86_39 / var_86_38)

				if var_86_40 > 0 and var_86_34 < var_86_40 then
					arg_83_1.talkMaxDuration = var_86_40

					if var_86_40 + var_86_33 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_40 + var_86_33
					end
				end

				arg_83_1.text_.text = var_86_37
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111152", "111152020", "story_v_out_111152.awb") ~= 0 then
					local var_86_41 = manager.audio:GetVoiceLength("story_v_out_111152", "111152020", "story_v_out_111152.awb") / 1000

					if var_86_41 + var_86_33 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_41 + var_86_33
					end

					if var_86_36.prefab_name ~= "" and arg_83_1.actors_[var_86_36.prefab_name] ~= nil then
						local var_86_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_36.prefab_name].transform, "story_v_out_111152", "111152020", "story_v_out_111152.awb")

						arg_83_1:RecordAudio("111152020", var_86_42)
						arg_83_1:RecordAudio("111152020", var_86_42)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_111152", "111152020", "story_v_out_111152.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_111152", "111152020", "story_v_out_111152.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_43 = math.max(var_86_34, arg_83_1.talkMaxDuration)

			if var_86_33 <= arg_83_1.time_ and arg_83_1.time_ < var_86_33 + var_86_43 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_33) / var_86_43

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_33 + var_86_43 and arg_83_1.time_ < var_86_33 + var_86_43 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play111152021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 111152021
		arg_87_1.duration_ = 6.3

		local var_87_0 = {
			ja = 6.3,
			ko = 5.5,
			zh = 4.3,
			en = 3.566
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
				arg_87_0:Play111152022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1094ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1094ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(0, 100, 0)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1094ui_story, var_90_4, var_90_3)

				local var_90_5 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_5.x, var_90_5.y, var_90_5.z)

				local var_90_6 = var_90_0.localEulerAngles

				var_90_6.z = 0
				var_90_6.x = 0
				var_90_0.localEulerAngles = var_90_6
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, 100, 0)

				local var_90_7 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_7.x, var_90_7.y, var_90_7.z)

				local var_90_8 = var_90_0.localEulerAngles

				var_90_8.z = 0
				var_90_8.x = 0
				var_90_0.localEulerAngles = var_90_8
			end

			local var_90_9 = arg_87_1.actors_["1048ui_story"].transform
			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 then
				arg_87_1.var_.moveOldPos1048ui_story = var_90_9.localPosition
			end

			local var_90_11 = 0.001

			if var_90_10 <= arg_87_1.time_ and arg_87_1.time_ < var_90_10 + var_90_11 then
				local var_90_12 = (arg_87_1.time_ - var_90_10) / var_90_11
				local var_90_13 = Vector3.New(0, -0.8, -6.2)

				var_90_9.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1048ui_story, var_90_13, var_90_12)

				local var_90_14 = manager.ui.mainCamera.transform.position - var_90_9.position

				var_90_9.forward = Vector3.New(var_90_14.x, var_90_14.y, var_90_14.z)

				local var_90_15 = var_90_9.localEulerAngles

				var_90_15.z = 0
				var_90_15.x = 0
				var_90_9.localEulerAngles = var_90_15
			end

			if arg_87_1.time_ >= var_90_10 + var_90_11 and arg_87_1.time_ < var_90_10 + var_90_11 + arg_90_0 then
				var_90_9.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_90_16 = manager.ui.mainCamera.transform.position - var_90_9.position

				var_90_9.forward = Vector3.New(var_90_16.x, var_90_16.y, var_90_16.z)

				local var_90_17 = var_90_9.localEulerAngles

				var_90_17.z = 0
				var_90_17.x = 0
				var_90_9.localEulerAngles = var_90_17
			end

			local var_90_18 = 0

			if var_90_18 < arg_87_1.time_ and arg_87_1.time_ <= var_90_18 + arg_90_0 then
				arg_87_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action3_1")
			end

			local var_90_19 = 0

			if var_90_19 < arg_87_1.time_ and arg_87_1.time_ <= var_90_19 + arg_90_0 then
				arg_87_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_90_20 = arg_87_1.actors_["1048ui_story"]
			local var_90_21 = 0

			if var_90_21 < arg_87_1.time_ and arg_87_1.time_ <= var_90_21 + arg_90_0 and not isNil(var_90_20) and arg_87_1.var_.characterEffect1048ui_story == nil then
				arg_87_1.var_.characterEffect1048ui_story = var_90_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_22 = 0.2

			if var_90_21 <= arg_87_1.time_ and arg_87_1.time_ < var_90_21 + var_90_22 and not isNil(var_90_20) then
				local var_90_23 = (arg_87_1.time_ - var_90_21) / var_90_22

				if arg_87_1.var_.characterEffect1048ui_story and not isNil(var_90_20) then
					arg_87_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_21 + var_90_22 and arg_87_1.time_ < var_90_21 + var_90_22 + arg_90_0 and not isNil(var_90_20) and arg_87_1.var_.characterEffect1048ui_story then
				arg_87_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_90_24 = arg_87_1.actors_["1094ui_story"]
			local var_90_25 = 0

			if var_90_25 < arg_87_1.time_ and arg_87_1.time_ <= var_90_25 + arg_90_0 and not isNil(var_90_24) and arg_87_1.var_.characterEffect1094ui_story == nil then
				arg_87_1.var_.characterEffect1094ui_story = var_90_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_26 = 0.2

			if var_90_25 <= arg_87_1.time_ and arg_87_1.time_ < var_90_25 + var_90_26 and not isNil(var_90_24) then
				local var_90_27 = (arg_87_1.time_ - var_90_25) / var_90_26

				if arg_87_1.var_.characterEffect1094ui_story and not isNil(var_90_24) then
					local var_90_28 = Mathf.Lerp(0, 0.5, var_90_27)

					arg_87_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1094ui_story.fillRatio = var_90_28
				end
			end

			if arg_87_1.time_ >= var_90_25 + var_90_26 and arg_87_1.time_ < var_90_25 + var_90_26 + arg_90_0 and not isNil(var_90_24) and arg_87_1.var_.characterEffect1094ui_story then
				local var_90_29 = 0.5

				arg_87_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1094ui_story.fillRatio = var_90_29
			end

			local var_90_30 = 0
			local var_90_31 = 0.525

			if var_90_30 < arg_87_1.time_ and arg_87_1.time_ <= var_90_30 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_32 = arg_87_1:FormatText(StoryNameCfg[8].name)

				arg_87_1.leftNameTxt_.text = var_90_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_33 = arg_87_1:GetWordFromCfg(111152021)
				local var_90_34 = arg_87_1:FormatText(var_90_33.content)

				arg_87_1.text_.text = var_90_34

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_35 = 21
				local var_90_36 = utf8.len(var_90_34)
				local var_90_37 = var_90_35 <= 0 and var_90_31 or var_90_31 * (var_90_36 / var_90_35)

				if var_90_37 > 0 and var_90_31 < var_90_37 then
					arg_87_1.talkMaxDuration = var_90_37

					if var_90_37 + var_90_30 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_37 + var_90_30
					end
				end

				arg_87_1.text_.text = var_90_34
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111152", "111152021", "story_v_out_111152.awb") ~= 0 then
					local var_90_38 = manager.audio:GetVoiceLength("story_v_out_111152", "111152021", "story_v_out_111152.awb") / 1000

					if var_90_38 + var_90_30 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_38 + var_90_30
					end

					if var_90_33.prefab_name ~= "" and arg_87_1.actors_[var_90_33.prefab_name] ~= nil then
						local var_90_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_33.prefab_name].transform, "story_v_out_111152", "111152021", "story_v_out_111152.awb")

						arg_87_1:RecordAudio("111152021", var_90_39)
						arg_87_1:RecordAudio("111152021", var_90_39)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_111152", "111152021", "story_v_out_111152.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_111152", "111152021", "story_v_out_111152.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_40 = math.max(var_90_31, arg_87_1.talkMaxDuration)

			if var_90_30 <= arg_87_1.time_ and arg_87_1.time_ < var_90_30 + var_90_40 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_30) / var_90_40

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_30 + var_90_40 and arg_87_1.time_ < var_90_30 + var_90_40 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play111152022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 111152022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play111152023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1048ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos1048ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0, 100, 0)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1048ui_story, var_94_4, var_94_3)

				local var_94_5 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_5.x, var_94_5.y, var_94_5.z)

				local var_94_6 = var_94_0.localEulerAngles

				var_94_6.z = 0
				var_94_6.x = 0
				var_94_0.localEulerAngles = var_94_6
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, 100, 0)

				local var_94_7 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_7.x, var_94_7.y, var_94_7.z)

				local var_94_8 = var_94_0.localEulerAngles

				var_94_8.z = 0
				var_94_8.x = 0
				var_94_0.localEulerAngles = var_94_8
			end

			local var_94_9 = 0
			local var_94_10 = 0.4

			if var_94_9 < arg_91_1.time_ and arg_91_1.time_ <= var_94_9 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_11 = arg_91_1:FormatText(StoryNameCfg[7].name)

				arg_91_1.leftNameTxt_.text = var_94_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_12 = arg_91_1:GetWordFromCfg(111152022)
				local var_94_13 = arg_91_1:FormatText(var_94_12.content)

				arg_91_1.text_.text = var_94_13

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_14 = 16
				local var_94_15 = utf8.len(var_94_13)
				local var_94_16 = var_94_14 <= 0 and var_94_10 or var_94_10 * (var_94_15 / var_94_14)

				if var_94_16 > 0 and var_94_10 < var_94_16 then
					arg_91_1.talkMaxDuration = var_94_16

					if var_94_16 + var_94_9 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_16 + var_94_9
					end
				end

				arg_91_1.text_.text = var_94_13
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_17 = math.max(var_94_10, arg_91_1.talkMaxDuration)

			if var_94_9 <= arg_91_1.time_ and arg_91_1.time_ < var_94_9 + var_94_17 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_9) / var_94_17

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_9 + var_94_17 and arg_91_1.time_ < var_94_9 + var_94_17 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play111152023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 111152023
		arg_95_1.duration_ = 4.83

		local var_95_0 = {
			ja = 4.833,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_95_0:Play111152024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_98_1 = arg_95_1.actors_["1094ui_story"]
			local var_98_2 = 0

			if var_98_2 < arg_95_1.time_ and arg_95_1.time_ <= var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1094ui_story == nil then
				arg_95_1.var_.characterEffect1094ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_3 = 0.2

			if var_98_2 <= arg_95_1.time_ and arg_95_1.time_ < var_98_2 + var_98_3 and not isNil(var_98_1) then
				local var_98_4 = (arg_95_1.time_ - var_98_2) / var_98_3

				if arg_95_1.var_.characterEffect1094ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_2 + var_98_3 and arg_95_1.time_ < var_98_2 + var_98_3 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1094ui_story then
				arg_95_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_98_5 = arg_95_1.actors_["1094ui_story"].transform
			local var_98_6 = 0

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.var_.moveOldPos1094ui_story = var_98_5.localPosition
			end

			local var_98_7 = 0.001

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_7 then
				local var_98_8 = (arg_95_1.time_ - var_98_6) / var_98_7
				local var_98_9 = Vector3.New(0, -0.84, -6.1)

				var_98_5.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1094ui_story, var_98_9, var_98_8)

				local var_98_10 = manager.ui.mainCamera.transform.position - var_98_5.position

				var_98_5.forward = Vector3.New(var_98_10.x, var_98_10.y, var_98_10.z)

				local var_98_11 = var_98_5.localEulerAngles

				var_98_11.z = 0
				var_98_11.x = 0
				var_98_5.localEulerAngles = var_98_11
			end

			if arg_95_1.time_ >= var_98_6 + var_98_7 and arg_95_1.time_ < var_98_6 + var_98_7 + arg_98_0 then
				var_98_5.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_98_12 = manager.ui.mainCamera.transform.position - var_98_5.position

				var_98_5.forward = Vector3.New(var_98_12.x, var_98_12.y, var_98_12.z)

				local var_98_13 = var_98_5.localEulerAngles

				var_98_13.z = 0
				var_98_13.x = 0
				var_98_5.localEulerAngles = var_98_13
			end

			local var_98_14 = 0

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_98_15 = 0
			local var_98_16 = 0.05

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_17 = arg_95_1:FormatText(StoryNameCfg[181].name)

				arg_95_1.leftNameTxt_.text = var_98_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_18 = arg_95_1:GetWordFromCfg(111152023)
				local var_98_19 = arg_95_1:FormatText(var_98_18.content)

				arg_95_1.text_.text = var_98_19

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_20 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_111152", "111152023", "story_v_out_111152.awb") ~= 0 then
					local var_98_23 = manager.audio:GetVoiceLength("story_v_out_111152", "111152023", "story_v_out_111152.awb") / 1000

					if var_98_23 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_23 + var_98_15
					end

					if var_98_18.prefab_name ~= "" and arg_95_1.actors_[var_98_18.prefab_name] ~= nil then
						local var_98_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_18.prefab_name].transform, "story_v_out_111152", "111152023", "story_v_out_111152.awb")

						arg_95_1:RecordAudio("111152023", var_98_24)
						arg_95_1:RecordAudio("111152023", var_98_24)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_111152", "111152023", "story_v_out_111152.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_111152", "111152023", "story_v_out_111152.awb")
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
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play111152024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 111152024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play111152025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1094ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos1094ui_story = var_102_0.localPosition
			end

			local var_102_2 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2
				local var_102_4 = Vector3.New(0, 100, 0)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1094ui_story, var_102_4, var_102_3)

				local var_102_5 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_5.x, var_102_5.y, var_102_5.z)

				local var_102_6 = var_102_0.localEulerAngles

				var_102_6.z = 0
				var_102_6.x = 0
				var_102_0.localEulerAngles = var_102_6
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, 100, 0)

				local var_102_7 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_7.x, var_102_7.y, var_102_7.z)

				local var_102_8 = var_102_0.localEulerAngles

				var_102_8.z = 0
				var_102_8.x = 0
				var_102_0.localEulerAngles = var_102_8
			end

			local var_102_9 = 0
			local var_102_10 = 0.925

			if var_102_9 < arg_99_1.time_ and arg_99_1.time_ <= var_102_9 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_11 = arg_99_1:GetWordFromCfg(111152024)
				local var_102_12 = arg_99_1:FormatText(var_102_11.content)

				arg_99_1.text_.text = var_102_12

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_13 = 37
				local var_102_14 = utf8.len(var_102_12)
				local var_102_15 = var_102_13 <= 0 and var_102_10 or var_102_10 * (var_102_14 / var_102_13)

				if var_102_15 > 0 and var_102_10 < var_102_15 then
					arg_99_1.talkMaxDuration = var_102_15

					if var_102_15 + var_102_9 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_15 + var_102_9
					end
				end

				arg_99_1.text_.text = var_102_12
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_16 = math.max(var_102_10, arg_99_1.talkMaxDuration)

			if var_102_9 <= arg_99_1.time_ and arg_99_1.time_ < var_102_9 + var_102_16 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_9) / var_102_16

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_9 + var_102_16 and arg_99_1.time_ < var_102_9 + var_102_16 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play111152025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 111152025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
			arg_103_1.auto_ = false
		end

		function arg_103_1.playNext_(arg_105_0)
			arg_103_1.onStoryFinished_()
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 1.05

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_2 = arg_103_1:GetWordFromCfg(111152025)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 42
				local var_106_5 = utf8.len(var_106_3)
				local var_106_6 = var_106_4 <= 0 and var_106_1 or var_106_1 * (var_106_5 / var_106_4)

				if var_106_6 > 0 and var_106_1 < var_106_6 then
					arg_103_1.talkMaxDuration = var_106_6

					if var_106_6 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_7 and arg_103_1.time_ < var_106_0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D11"
	},
	voices = {
		"story_v_out_111152.awb"
	}
}
