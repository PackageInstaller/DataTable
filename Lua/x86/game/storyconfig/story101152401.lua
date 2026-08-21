return {
	Play115241001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115241001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play115241002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "G03b"

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
				local var_4_5 = arg_1_1.bgs_.G03b

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
					if iter_4_0 ~= "G03b" then
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
			local var_4_23 = 0.333333333333333

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

			local var_4_28 = 0.466666666666667
			local var_4_29 = 0.533333333333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_5_story_2", "bgm_activity_1_5_story_2", "bgm_activity_1_5_story_2.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_5_story_2", "bgm_activity_1_5_story_2")

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

				local var_4_37 = arg_1_1:GetWordFromCfg(115241001)
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
	Play115241002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 115241002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play115241003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.5

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

				local var_12_2 = arg_9_1:GetWordFromCfg(115241002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 20
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
	Play115241003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 115241003
		arg_13_1.duration_ = 17.97

		local var_13_0 = {
			ja = 13.233,
			ko = 11.833,
			zh = 11.333,
			en = 17.966
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
				arg_13_0:Play115241004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "4010ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "4010ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["4010ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos4010ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(-0.7, -1.59, -5.2)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos4010ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(-0.7, -1.59, -5.2)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = 0

			if var_16_14 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				arg_13_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_1")
			end

			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_16_16 = arg_13_1.actors_["4010ui_story"]
			local var_16_17 = 0

			if var_16_17 < arg_13_1.time_ and arg_13_1.time_ <= var_16_17 + arg_16_0 and not isNil(var_16_16) and arg_13_1.var_.characterEffect4010ui_story == nil then
				arg_13_1.var_.characterEffect4010ui_story = var_16_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_18 = 0.2

			if var_16_17 <= arg_13_1.time_ and arg_13_1.time_ < var_16_17 + var_16_18 and not isNil(var_16_16) then
				local var_16_19 = (arg_13_1.time_ - var_16_17) / var_16_18

				if arg_13_1.var_.characterEffect4010ui_story and not isNil(var_16_16) then
					arg_13_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_17 + var_16_18 and arg_13_1.time_ < var_16_17 + var_16_18 + arg_16_0 and not isNil(var_16_16) and arg_13_1.var_.characterEffect4010ui_story then
				arg_13_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_16_20 = 0
			local var_16_21 = 1.325

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[42].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(115241003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 53
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

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241003", "story_v_out_115241.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_out_115241", "115241003", "story_v_out_115241.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_out_115241", "115241003", "story_v_out_115241.awb")

						arg_13_1:RecordAudio("115241003", var_16_29)
						arg_13_1:RecordAudio("115241003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_115241", "115241003", "story_v_out_115241.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_115241", "115241003", "story_v_out_115241.awb")
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
				actorName = "4010ui_story",
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
	Play115241004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 115241004
		arg_17_1.duration_ = 3.7

		local var_17_0 = {
			ja = 3.7,
			ko = 1.999999999999,
			zh = 2.1,
			en = 1.999999999999
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
				arg_17_0:Play115241005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["4010ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect4010ui_story == nil then
				arg_17_1.var_.characterEffect4010ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect4010ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_17_1.var_.characterEffect4010ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect4010ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_17_1.var_.characterEffect4010ui_story.fillRatio = var_20_5
			end

			local var_20_6 = "3008ui_story"

			if arg_17_1.actors_[var_20_6] == nil then
				local var_20_7 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_20_7) then
					local var_20_8 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_17_1.stage_.transform)

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

			local var_20_11 = 0

			if var_20_11 < arg_17_1.time_ and arg_17_1.time_ <= var_20_11 + arg_20_0 then
				arg_17_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action1_1")
			end

			local var_20_12 = 0

			if var_20_12 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_20_13 = arg_17_1.actors_["3008ui_story"]
			local var_20_14 = 0

			if var_20_14 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 and not isNil(var_20_13) and arg_17_1.var_.characterEffect3008ui_story == nil then
				arg_17_1.var_.characterEffect3008ui_story = var_20_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_15 = 0.2

			if var_20_14 <= arg_17_1.time_ and arg_17_1.time_ < var_20_14 + var_20_15 and not isNil(var_20_13) then
				local var_20_16 = (arg_17_1.time_ - var_20_14) / var_20_15

				if arg_17_1.var_.characterEffect3008ui_story and not isNil(var_20_13) then
					arg_17_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_14 + var_20_15 and arg_17_1.time_ < var_20_14 + var_20_15 + arg_20_0 and not isNil(var_20_13) and arg_17_1.var_.characterEffect3008ui_story then
				arg_17_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_20_17 = arg_17_1.actors_["3008ui_story"].transform
			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1.var_.moveOldPos3008ui_story = var_20_17.localPosition
			end

			local var_20_19 = 0.001

			if var_20_18 <= arg_17_1.time_ and arg_17_1.time_ < var_20_18 + var_20_19 then
				local var_20_20 = (arg_17_1.time_ - var_20_18) / var_20_19
				local var_20_21 = Vector3.New(0.7, -1.51, -4.3)

				var_20_17.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos3008ui_story, var_20_21, var_20_20)

				local var_20_22 = manager.ui.mainCamera.transform.position - var_20_17.position

				var_20_17.forward = Vector3.New(var_20_22.x, var_20_22.y, var_20_22.z)

				local var_20_23 = var_20_17.localEulerAngles

				var_20_23.z = 0
				var_20_23.x = 0
				var_20_17.localEulerAngles = var_20_23
			end

			if arg_17_1.time_ >= var_20_18 + var_20_19 and arg_17_1.time_ < var_20_18 + var_20_19 + arg_20_0 then
				var_20_17.localPosition = Vector3.New(0.7, -1.51, -4.3)

				local var_20_24 = manager.ui.mainCamera.transform.position - var_20_17.position

				var_20_17.forward = Vector3.New(var_20_24.x, var_20_24.y, var_20_24.z)

				local var_20_25 = var_20_17.localEulerAngles

				var_20_25.z = 0
				var_20_25.x = 0
				var_20_17.localEulerAngles = var_20_25
			end

			local var_20_26 = 0
			local var_20_27 = 0.075

			if var_20_26 < arg_17_1.time_ and arg_17_1.time_ <= var_20_26 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_28 = arg_17_1:FormatText(StoryNameCfg[20].name)

				arg_17_1.leftNameTxt_.text = var_20_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_29 = arg_17_1:GetWordFromCfg(115241004)
				local var_20_30 = arg_17_1:FormatText(var_20_29.content)

				arg_17_1.text_.text = var_20_30

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_31 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241004", "story_v_out_115241.awb") ~= 0 then
					local var_20_34 = manager.audio:GetVoiceLength("story_v_out_115241", "115241004", "story_v_out_115241.awb") / 1000

					if var_20_34 + var_20_26 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_34 + var_20_26
					end

					if var_20_29.prefab_name ~= "" and arg_17_1.actors_[var_20_29.prefab_name] ~= nil then
						local var_20_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_29.prefab_name].transform, "story_v_out_115241", "115241004", "story_v_out_115241.awb")

						arg_17_1:RecordAudio("115241004", var_20_35)
						arg_17_1:RecordAudio("115241004", var_20_35)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_115241", "115241004", "story_v_out_115241.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_115241", "115241004", "story_v_out_115241.awb")
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
				actorName = "3008ui_story",
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
	Play115241005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 115241005
		arg_21_1.duration_ = 6.47

		local var_21_0 = {
			ja = 5.7,
			ko = 4.9,
			zh = 5.633,
			en = 6.466
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
				arg_21_0:Play115241006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010actionlink/4010action426")
			end

			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_24_2 = arg_21_1.actors_["4010ui_story"]
			local var_24_3 = 0

			if var_24_3 < arg_21_1.time_ and arg_21_1.time_ <= var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect4010ui_story == nil then
				arg_21_1.var_.characterEffect4010ui_story = var_24_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_4 = 0.2

			if var_24_3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_3 + var_24_4 and not isNil(var_24_2) then
				local var_24_5 = (arg_21_1.time_ - var_24_3) / var_24_4

				if arg_21_1.var_.characterEffect4010ui_story and not isNil(var_24_2) then
					arg_21_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_3 + var_24_4 and arg_21_1.time_ < var_24_3 + var_24_4 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect4010ui_story then
				arg_21_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_24_6 = arg_21_1.actors_["3008ui_story"]
			local var_24_7 = 0

			if var_24_7 < arg_21_1.time_ and arg_21_1.time_ <= var_24_7 + arg_24_0 and not isNil(var_24_6) and arg_21_1.var_.characterEffect3008ui_story == nil then
				arg_21_1.var_.characterEffect3008ui_story = var_24_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_8 = 0.2

			if var_24_7 <= arg_21_1.time_ and arg_21_1.time_ < var_24_7 + var_24_8 and not isNil(var_24_6) then
				local var_24_9 = (arg_21_1.time_ - var_24_7) / var_24_8

				if arg_21_1.var_.characterEffect3008ui_story and not isNil(var_24_6) then
					local var_24_10 = Mathf.Lerp(0, 0.5, var_24_9)

					arg_21_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_21_1.var_.characterEffect3008ui_story.fillRatio = var_24_10
				end
			end

			if arg_21_1.time_ >= var_24_7 + var_24_8 and arg_21_1.time_ < var_24_7 + var_24_8 + arg_24_0 and not isNil(var_24_6) and arg_21_1.var_.characterEffect3008ui_story then
				local var_24_11 = 0.5

				arg_21_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_21_1.var_.characterEffect3008ui_story.fillRatio = var_24_11
			end

			local var_24_12 = 0
			local var_24_13 = 0.675

			if var_24_12 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_14 = arg_21_1:FormatText(StoryNameCfg[42].name)

				arg_21_1.leftNameTxt_.text = var_24_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_15 = arg_21_1:GetWordFromCfg(115241005)
				local var_24_16 = arg_21_1:FormatText(var_24_15.content)

				arg_21_1.text_.text = var_24_16

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_17 = 27
				local var_24_18 = utf8.len(var_24_16)
				local var_24_19 = var_24_17 <= 0 and var_24_13 or var_24_13 * (var_24_18 / var_24_17)

				if var_24_19 > 0 and var_24_13 < var_24_19 then
					arg_21_1.talkMaxDuration = var_24_19

					if var_24_19 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_19 + var_24_12
					end
				end

				arg_21_1.text_.text = var_24_16
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241005", "story_v_out_115241.awb") ~= 0 then
					local var_24_20 = manager.audio:GetVoiceLength("story_v_out_115241", "115241005", "story_v_out_115241.awb") / 1000

					if var_24_20 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_20 + var_24_12
					end

					if var_24_15.prefab_name ~= "" and arg_21_1.actors_[var_24_15.prefab_name] ~= nil then
						local var_24_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_15.prefab_name].transform, "story_v_out_115241", "115241005", "story_v_out_115241.awb")

						arg_21_1:RecordAudio("115241005", var_24_21)
						arg_21_1:RecordAudio("115241005", var_24_21)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_115241", "115241005", "story_v_out_115241.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_115241", "115241005", "story_v_out_115241.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_22 = math.max(var_24_13, arg_21_1.talkMaxDuration)

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_22 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_12) / var_24_22

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_12 + var_24_22 and arg_21_1.time_ < var_24_12 + var_24_22 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play115241006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 115241006
		arg_25_1.duration_ = 3.2

		local var_25_0 = {
			ja = 3.2,
			ko = 2.333,
			zh = 2.766,
			en = 2.933
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
				arg_25_0:Play115241007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_28_1 = arg_25_1.actors_["3008ui_story"]
			local var_28_2 = 0

			if var_28_2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect3008ui_story == nil then
				arg_25_1.var_.characterEffect3008ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_3 = 0.2

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_3 and not isNil(var_28_1) then
				local var_28_4 = (arg_25_1.time_ - var_28_2) / var_28_3

				if arg_25_1.var_.characterEffect3008ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_2 + var_28_3 and arg_25_1.time_ < var_28_2 + var_28_3 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect3008ui_story then
				arg_25_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_28_5 = arg_25_1.actors_["4010ui_story"]
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect4010ui_story == nil then
				arg_25_1.var_.characterEffect4010ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_7 = 0.2

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_7 and not isNil(var_28_5) then
				local var_28_8 = (arg_25_1.time_ - var_28_6) / var_28_7

				if arg_25_1.var_.characterEffect4010ui_story and not isNil(var_28_5) then
					local var_28_9 = Mathf.Lerp(0, 0.5, var_28_8)

					arg_25_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_25_1.var_.characterEffect4010ui_story.fillRatio = var_28_9
				end
			end

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect4010ui_story then
				local var_28_10 = 0.5

				arg_25_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_25_1.var_.characterEffect4010ui_story.fillRatio = var_28_10
			end

			local var_28_11 = 0
			local var_28_12 = 0.275

			if var_28_11 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_13 = arg_25_1:FormatText(StoryNameCfg[20].name)

				arg_25_1.leftNameTxt_.text = var_28_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_14 = arg_25_1:GetWordFromCfg(115241006)
				local var_28_15 = arg_25_1:FormatText(var_28_14.content)

				arg_25_1.text_.text = var_28_15

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_16 = 11
				local var_28_17 = utf8.len(var_28_15)
				local var_28_18 = var_28_16 <= 0 and var_28_12 or var_28_12 * (var_28_17 / var_28_16)

				if var_28_18 > 0 and var_28_12 < var_28_18 then
					arg_25_1.talkMaxDuration = var_28_18

					if var_28_18 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_18 + var_28_11
					end
				end

				arg_25_1.text_.text = var_28_15
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241006", "story_v_out_115241.awb") ~= 0 then
					local var_28_19 = manager.audio:GetVoiceLength("story_v_out_115241", "115241006", "story_v_out_115241.awb") / 1000

					if var_28_19 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_19 + var_28_11
					end

					if var_28_14.prefab_name ~= "" and arg_25_1.actors_[var_28_14.prefab_name] ~= nil then
						local var_28_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_14.prefab_name].transform, "story_v_out_115241", "115241006", "story_v_out_115241.awb")

						arg_25_1:RecordAudio("115241006", var_28_20)
						arg_25_1:RecordAudio("115241006", var_28_20)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_115241", "115241006", "story_v_out_115241.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_115241", "115241006", "story_v_out_115241.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_21 = math.max(var_28_12, arg_25_1.talkMaxDuration)

			if var_28_11 <= arg_25_1.time_ and arg_25_1.time_ < var_28_11 + var_28_21 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_11) / var_28_21

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_11 + var_28_21 and arg_25_1.time_ < var_28_11 + var_28_21 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play115241007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 115241007
		arg_29_1.duration_ = 8.4

		local var_29_0 = {
			ja = 8.4,
			ko = 6.4,
			zh = 4.8,
			en = 5.566
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
				arg_29_0:Play115241008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_2")
			end

			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_32_2 = arg_29_1.actors_["4010ui_story"]
			local var_32_3 = 0

			if var_32_3 < arg_29_1.time_ and arg_29_1.time_ <= var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect4010ui_story == nil then
				arg_29_1.var_.characterEffect4010ui_story = var_32_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_4 = 0.2

			if var_32_3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_3 + var_32_4 and not isNil(var_32_2) then
				local var_32_5 = (arg_29_1.time_ - var_32_3) / var_32_4

				if arg_29_1.var_.characterEffect4010ui_story and not isNil(var_32_2) then
					arg_29_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_3 + var_32_4 and arg_29_1.time_ < var_32_3 + var_32_4 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect4010ui_story then
				arg_29_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_32_6 = arg_29_1.actors_["3008ui_story"]
			local var_32_7 = 0

			if var_32_7 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect3008ui_story == nil then
				arg_29_1.var_.characterEffect3008ui_story = var_32_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_8 = 0.2

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_8 and not isNil(var_32_6) then
				local var_32_9 = (arg_29_1.time_ - var_32_7) / var_32_8

				if arg_29_1.var_.characterEffect3008ui_story and not isNil(var_32_6) then
					local var_32_10 = Mathf.Lerp(0, 0.5, var_32_9)

					arg_29_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_29_1.var_.characterEffect3008ui_story.fillRatio = var_32_10
				end
			end

			if arg_29_1.time_ >= var_32_7 + var_32_8 and arg_29_1.time_ < var_32_7 + var_32_8 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect3008ui_story then
				local var_32_11 = 0.5

				arg_29_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_29_1.var_.characterEffect3008ui_story.fillRatio = var_32_11
			end

			local var_32_12 = 0
			local var_32_13 = 0.625

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_14 = arg_29_1:FormatText(StoryNameCfg[42].name)

				arg_29_1.leftNameTxt_.text = var_32_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_15 = arg_29_1:GetWordFromCfg(115241007)
				local var_32_16 = arg_29_1:FormatText(var_32_15.content)

				arg_29_1.text_.text = var_32_16

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_17 = 25
				local var_32_18 = utf8.len(var_32_16)
				local var_32_19 = var_32_17 <= 0 and var_32_13 or var_32_13 * (var_32_18 / var_32_17)

				if var_32_19 > 0 and var_32_13 < var_32_19 then
					arg_29_1.talkMaxDuration = var_32_19

					if var_32_19 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_12
					end
				end

				arg_29_1.text_.text = var_32_16
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241007", "story_v_out_115241.awb") ~= 0 then
					local var_32_20 = manager.audio:GetVoiceLength("story_v_out_115241", "115241007", "story_v_out_115241.awb") / 1000

					if var_32_20 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_20 + var_32_12
					end

					if var_32_15.prefab_name ~= "" and arg_29_1.actors_[var_32_15.prefab_name] ~= nil then
						local var_32_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_15.prefab_name].transform, "story_v_out_115241", "115241007", "story_v_out_115241.awb")

						arg_29_1:RecordAudio("115241007", var_32_21)
						arg_29_1:RecordAudio("115241007", var_32_21)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_115241", "115241007", "story_v_out_115241.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_115241", "115241007", "story_v_out_115241.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_22 = math.max(var_32_13, arg_29_1.talkMaxDuration)

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_22 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_12) / var_32_22

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_12 + var_32_22 and arg_29_1.time_ < var_32_12 + var_32_22 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play115241008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 115241008
		arg_33_1.duration_ = 7.33

		local var_33_0 = {
			ja = 7.333,
			ko = 2.733,
			zh = 2.766,
			en = 3
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
				arg_33_0:Play115241009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_36_1 = arg_33_1.actors_["3008ui_story"]
			local var_36_2 = 0

			if var_36_2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect3008ui_story == nil then
				arg_33_1.var_.characterEffect3008ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_3 = 0.2

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_3 and not isNil(var_36_1) then
				local var_36_4 = (arg_33_1.time_ - var_36_2) / var_36_3

				if arg_33_1.var_.characterEffect3008ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_2 + var_36_3 and arg_33_1.time_ < var_36_2 + var_36_3 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect3008ui_story then
				arg_33_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_36_5 = arg_33_1.actors_["4010ui_story"]
			local var_36_6 = 0

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect4010ui_story == nil then
				arg_33_1.var_.characterEffect4010ui_story = var_36_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_7 = 0.2

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_7 and not isNil(var_36_5) then
				local var_36_8 = (arg_33_1.time_ - var_36_6) / var_36_7

				if arg_33_1.var_.characterEffect4010ui_story and not isNil(var_36_5) then
					local var_36_9 = Mathf.Lerp(0, 0.5, var_36_8)

					arg_33_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_33_1.var_.characterEffect4010ui_story.fillRatio = var_36_9
				end
			end

			if arg_33_1.time_ >= var_36_6 + var_36_7 and arg_33_1.time_ < var_36_6 + var_36_7 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect4010ui_story then
				local var_36_10 = 0.5

				arg_33_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_33_1.var_.characterEffect4010ui_story.fillRatio = var_36_10
			end

			local var_36_11 = 0

			if var_36_11 < arg_33_1.time_ and arg_33_1.time_ <= var_36_11 + arg_36_0 then
				arg_33_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action4_1")
			end

			local var_36_12 = 0
			local var_36_13 = 0.3

			if var_36_12 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_14 = arg_33_1:FormatText(StoryNameCfg[20].name)

				arg_33_1.leftNameTxt_.text = var_36_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_15 = arg_33_1:GetWordFromCfg(115241008)
				local var_36_16 = arg_33_1:FormatText(var_36_15.content)

				arg_33_1.text_.text = var_36_16

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_17 = 11
				local var_36_18 = utf8.len(var_36_16)
				local var_36_19 = var_36_17 <= 0 and var_36_13 or var_36_13 * (var_36_18 / var_36_17)

				if var_36_19 > 0 and var_36_13 < var_36_19 then
					arg_33_1.talkMaxDuration = var_36_19

					if var_36_19 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_19 + var_36_12
					end
				end

				arg_33_1.text_.text = var_36_16
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241008", "story_v_out_115241.awb") ~= 0 then
					local var_36_20 = manager.audio:GetVoiceLength("story_v_out_115241", "115241008", "story_v_out_115241.awb") / 1000

					if var_36_20 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_20 + var_36_12
					end

					if var_36_15.prefab_name ~= "" and arg_33_1.actors_[var_36_15.prefab_name] ~= nil then
						local var_36_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_15.prefab_name].transform, "story_v_out_115241", "115241008", "story_v_out_115241.awb")

						arg_33_1:RecordAudio("115241008", var_36_21)
						arg_33_1:RecordAudio("115241008", var_36_21)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_115241", "115241008", "story_v_out_115241.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_115241", "115241008", "story_v_out_115241.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_22 = math.max(var_36_13, arg_33_1.talkMaxDuration)

			if var_36_12 <= arg_33_1.time_ and arg_33_1.time_ < var_36_12 + var_36_22 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_12) / var_36_22

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_12 + var_36_22 and arg_33_1.time_ < var_36_12 + var_36_22 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play115241009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 115241009
		arg_37_1.duration_ = 19.07

		local var_37_0 = {
			ja = 19.066,
			ko = 9.333,
			zh = 10.066,
			en = 13.533
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
				arg_37_0:Play115241010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_40_1 = arg_37_1.actors_["4010ui_story"]
			local var_40_2 = 0

			if var_40_2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect4010ui_story == nil then
				arg_37_1.var_.characterEffect4010ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_3 = 0.2

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_3 and not isNil(var_40_1) then
				local var_40_4 = (arg_37_1.time_ - var_40_2) / var_40_3

				if arg_37_1.var_.characterEffect4010ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_2 + var_40_3 and arg_37_1.time_ < var_40_2 + var_40_3 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect4010ui_story then
				arg_37_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_40_5 = arg_37_1.actors_["3008ui_story"]
			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect3008ui_story == nil then
				arg_37_1.var_.characterEffect3008ui_story = var_40_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_7 = 0.2

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_7 and not isNil(var_40_5) then
				local var_40_8 = (arg_37_1.time_ - var_40_6) / var_40_7

				if arg_37_1.var_.characterEffect3008ui_story and not isNil(var_40_5) then
					local var_40_9 = Mathf.Lerp(0, 0.5, var_40_8)

					arg_37_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_37_1.var_.characterEffect3008ui_story.fillRatio = var_40_9
				end
			end

			if arg_37_1.time_ >= var_40_6 + var_40_7 and arg_37_1.time_ < var_40_6 + var_40_7 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect3008ui_story then
				local var_40_10 = 0.5

				arg_37_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_37_1.var_.characterEffect3008ui_story.fillRatio = var_40_10
			end

			local var_40_11 = 0

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action4_2")
			end

			local var_40_12 = 0
			local var_40_13 = 1.125

			if var_40_12 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_14 = arg_37_1:FormatText(StoryNameCfg[42].name)

				arg_37_1.leftNameTxt_.text = var_40_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_15 = arg_37_1:GetWordFromCfg(115241009)
				local var_40_16 = arg_37_1:FormatText(var_40_15.content)

				arg_37_1.text_.text = var_40_16

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_17 = 45
				local var_40_18 = utf8.len(var_40_16)
				local var_40_19 = var_40_17 <= 0 and var_40_13 or var_40_13 * (var_40_18 / var_40_17)

				if var_40_19 > 0 and var_40_13 < var_40_19 then
					arg_37_1.talkMaxDuration = var_40_19

					if var_40_19 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_12
					end
				end

				arg_37_1.text_.text = var_40_16
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241009", "story_v_out_115241.awb") ~= 0 then
					local var_40_20 = manager.audio:GetVoiceLength("story_v_out_115241", "115241009", "story_v_out_115241.awb") / 1000

					if var_40_20 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_20 + var_40_12
					end

					if var_40_15.prefab_name ~= "" and arg_37_1.actors_[var_40_15.prefab_name] ~= nil then
						local var_40_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_15.prefab_name].transform, "story_v_out_115241", "115241009", "story_v_out_115241.awb")

						arg_37_1:RecordAudio("115241009", var_40_21)
						arg_37_1:RecordAudio("115241009", var_40_21)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_115241", "115241009", "story_v_out_115241.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_115241", "115241009", "story_v_out_115241.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_22 = math.max(var_40_13, arg_37_1.talkMaxDuration)

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_22 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_12) / var_40_22

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_12 + var_40_22 and arg_37_1.time_ < var_40_12 + var_40_22 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play115241010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 115241010
		arg_41_1.duration_ = 17.93

		local var_41_0 = {
			ja = 16.933,
			ko = 16.766,
			zh = 13.766,
			en = 17.933
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
				arg_41_0:Play115241011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_44_1 = 0
			local var_44_2 = 1.5

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_3 = arg_41_1:FormatText(StoryNameCfg[42].name)

				arg_41_1.leftNameTxt_.text = var_44_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(115241010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_6 = 60
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

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241010", "story_v_out_115241.awb") ~= 0 then
					local var_44_9 = manager.audio:GetVoiceLength("story_v_out_115241", "115241010", "story_v_out_115241.awb") / 1000

					if var_44_9 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_1
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_115241", "115241010", "story_v_out_115241.awb")

						arg_41_1:RecordAudio("115241010", var_44_10)
						arg_41_1:RecordAudio("115241010", var_44_10)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_115241", "115241010", "story_v_out_115241.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_115241", "115241010", "story_v_out_115241.awb")
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
	Play115241011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 115241011
		arg_45_1.duration_ = 10.33

		local var_45_0 = {
			ja = 10.333,
			ko = 7.966,
			zh = 7.866,
			en = 7.866
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
				arg_45_0:Play115241012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_48_1 = 0
			local var_48_2 = 1.125

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_3 = arg_45_1:FormatText(StoryNameCfg[42].name)

				arg_45_1.leftNameTxt_.text = var_48_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:GetWordFromCfg(115241011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 45
				local var_48_7 = utf8.len(var_48_5)
				local var_48_8 = var_48_6 <= 0 and var_48_2 or var_48_2 * (var_48_7 / var_48_6)

				if var_48_8 > 0 and var_48_2 < var_48_8 then
					arg_45_1.talkMaxDuration = var_48_8

					if var_48_8 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241011", "story_v_out_115241.awb") ~= 0 then
					local var_48_9 = manager.audio:GetVoiceLength("story_v_out_115241", "115241011", "story_v_out_115241.awb") / 1000

					if var_48_9 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_1
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_115241", "115241011", "story_v_out_115241.awb")

						arg_45_1:RecordAudio("115241011", var_48_10)
						arg_45_1:RecordAudio("115241011", var_48_10)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_115241", "115241011", "story_v_out_115241.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_115241", "115241011", "story_v_out_115241.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_11 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_11 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_11

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_11 and arg_45_1.time_ < var_48_1 + var_48_11 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play115241012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 115241012
		arg_49_1.duration_ = 4.9

		local var_49_0 = {
			ja = 4.9,
			ko = 4.433,
			zh = 4.9,
			en = 4.7
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
				arg_49_0:Play115241013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_52_1 = arg_49_1.actors_["3008ui_story"]
			local var_52_2 = 0

			if var_52_2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect3008ui_story == nil then
				arg_49_1.var_.characterEffect3008ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_3 = 0.2

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_3 and not isNil(var_52_1) then
				local var_52_4 = (arg_49_1.time_ - var_52_2) / var_52_3

				if arg_49_1.var_.characterEffect3008ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_2 + var_52_3 and arg_49_1.time_ < var_52_2 + var_52_3 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect3008ui_story then
				arg_49_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_52_5 = arg_49_1.actors_["4010ui_story"]
			local var_52_6 = 0

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.characterEffect4010ui_story == nil then
				arg_49_1.var_.characterEffect4010ui_story = var_52_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_7 = 0.2

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_7 and not isNil(var_52_5) then
				local var_52_8 = (arg_49_1.time_ - var_52_6) / var_52_7

				if arg_49_1.var_.characterEffect4010ui_story and not isNil(var_52_5) then
					local var_52_9 = Mathf.Lerp(0, 0.5, var_52_8)

					arg_49_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_49_1.var_.characterEffect4010ui_story.fillRatio = var_52_9
				end
			end

			if arg_49_1.time_ >= var_52_6 + var_52_7 and arg_49_1.time_ < var_52_6 + var_52_7 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.characterEffect4010ui_story then
				local var_52_10 = 0.5

				arg_49_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_49_1.var_.characterEffect4010ui_story.fillRatio = var_52_10
			end

			local var_52_11 = 0

			if var_52_11 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				arg_49_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action6_1")
			end

			local var_52_12 = 0
			local var_52_13 = 0.575

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_14 = arg_49_1:FormatText(StoryNameCfg[20].name)

				arg_49_1.leftNameTxt_.text = var_52_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_15 = arg_49_1:GetWordFromCfg(115241012)
				local var_52_16 = arg_49_1:FormatText(var_52_15.content)

				arg_49_1.text_.text = var_52_16

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_17 = 23
				local var_52_18 = utf8.len(var_52_16)
				local var_52_19 = var_52_17 <= 0 and var_52_13 or var_52_13 * (var_52_18 / var_52_17)

				if var_52_19 > 0 and var_52_13 < var_52_19 then
					arg_49_1.talkMaxDuration = var_52_19

					if var_52_19 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_19 + var_52_12
					end
				end

				arg_49_1.text_.text = var_52_16
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241012", "story_v_out_115241.awb") ~= 0 then
					local var_52_20 = manager.audio:GetVoiceLength("story_v_out_115241", "115241012", "story_v_out_115241.awb") / 1000

					if var_52_20 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_20 + var_52_12
					end

					if var_52_15.prefab_name ~= "" and arg_49_1.actors_[var_52_15.prefab_name] ~= nil then
						local var_52_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_15.prefab_name].transform, "story_v_out_115241", "115241012", "story_v_out_115241.awb")

						arg_49_1:RecordAudio("115241012", var_52_21)
						arg_49_1:RecordAudio("115241012", var_52_21)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_115241", "115241012", "story_v_out_115241.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_115241", "115241012", "story_v_out_115241.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_22 = math.max(var_52_13, arg_49_1.talkMaxDuration)

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_22 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_12) / var_52_22

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_12 + var_52_22 and arg_49_1.time_ < var_52_12 + var_52_22 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play115241013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 115241013
		arg_53_1.duration_ = 6.67

		local var_53_0 = {
			ja = 6.666,
			ko = 4.966,
			zh = 4.766,
			en = 4.4
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
				arg_53_0:Play115241014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_56_1 = arg_53_1.actors_["4010ui_story"]
			local var_56_2 = 0

			if var_56_2 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect4010ui_story == nil then
				arg_53_1.var_.characterEffect4010ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_3 = 0.2

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_3 and not isNil(var_56_1) then
				local var_56_4 = (arg_53_1.time_ - var_56_2) / var_56_3

				if arg_53_1.var_.characterEffect4010ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_2 + var_56_3 and arg_53_1.time_ < var_56_2 + var_56_3 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect4010ui_story then
				arg_53_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_56_5 = arg_53_1.actors_["3008ui_story"]
			local var_56_6 = 0

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.characterEffect3008ui_story == nil then
				arg_53_1.var_.characterEffect3008ui_story = var_56_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_7 = 0.2

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_7 and not isNil(var_56_5) then
				local var_56_8 = (arg_53_1.time_ - var_56_6) / var_56_7

				if arg_53_1.var_.characterEffect3008ui_story and not isNil(var_56_5) then
					local var_56_9 = Mathf.Lerp(0, 0.5, var_56_8)

					arg_53_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_53_1.var_.characterEffect3008ui_story.fillRatio = var_56_9
				end
			end

			if arg_53_1.time_ >= var_56_6 + var_56_7 and arg_53_1.time_ < var_56_6 + var_56_7 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.characterEffect3008ui_story then
				local var_56_10 = 0.5

				arg_53_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_53_1.var_.characterEffect3008ui_story.fillRatio = var_56_10
			end

			local var_56_11 = 0
			local var_56_12 = 0.55

			if var_56_11 < arg_53_1.time_ and arg_53_1.time_ <= var_56_11 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_13 = arg_53_1:FormatText(StoryNameCfg[42].name)

				arg_53_1.leftNameTxt_.text = var_56_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_14 = arg_53_1:GetWordFromCfg(115241013)
				local var_56_15 = arg_53_1:FormatText(var_56_14.content)

				arg_53_1.text_.text = var_56_15

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_16 = 22
				local var_56_17 = utf8.len(var_56_15)
				local var_56_18 = var_56_16 <= 0 and var_56_12 or var_56_12 * (var_56_17 / var_56_16)

				if var_56_18 > 0 and var_56_12 < var_56_18 then
					arg_53_1.talkMaxDuration = var_56_18

					if var_56_18 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_18 + var_56_11
					end
				end

				arg_53_1.text_.text = var_56_15
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241013", "story_v_out_115241.awb") ~= 0 then
					local var_56_19 = manager.audio:GetVoiceLength("story_v_out_115241", "115241013", "story_v_out_115241.awb") / 1000

					if var_56_19 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_19 + var_56_11
					end

					if var_56_14.prefab_name ~= "" and arg_53_1.actors_[var_56_14.prefab_name] ~= nil then
						local var_56_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_14.prefab_name].transform, "story_v_out_115241", "115241013", "story_v_out_115241.awb")

						arg_53_1:RecordAudio("115241013", var_56_20)
						arg_53_1:RecordAudio("115241013", var_56_20)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_115241", "115241013", "story_v_out_115241.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_115241", "115241013", "story_v_out_115241.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_21 = math.max(var_56_12, arg_53_1.talkMaxDuration)

			if var_56_11 <= arg_53_1.time_ and arg_53_1.time_ < var_56_11 + var_56_21 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_11) / var_56_21

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_11 + var_56_21 and arg_53_1.time_ < var_56_11 + var_56_21 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play115241014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 115241014
		arg_57_1.duration_ = 8.63

		local var_57_0 = {
			ja = 8.633,
			ko = 5.6,
			zh = 5.266,
			en = 6.5
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
				arg_57_0:Play115241015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_60_1 = arg_57_1.actors_["3008ui_story"]
			local var_60_2 = 0

			if var_60_2 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect3008ui_story == nil then
				arg_57_1.var_.characterEffect3008ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.2

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_3 and not isNil(var_60_1) then
				local var_60_4 = (arg_57_1.time_ - var_60_2) / var_60_3

				if arg_57_1.var_.characterEffect3008ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_2 + var_60_3 and arg_57_1.time_ < var_60_2 + var_60_3 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect3008ui_story then
				arg_57_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_60_5 = arg_57_1.actors_["4010ui_story"]
			local var_60_6 = 0

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.characterEffect4010ui_story == nil then
				arg_57_1.var_.characterEffect4010ui_story = var_60_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_7 = 0.2

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_7 and not isNil(var_60_5) then
				local var_60_8 = (arg_57_1.time_ - var_60_6) / var_60_7

				if arg_57_1.var_.characterEffect4010ui_story and not isNil(var_60_5) then
					local var_60_9 = Mathf.Lerp(0, 0.5, var_60_8)

					arg_57_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_57_1.var_.characterEffect4010ui_story.fillRatio = var_60_9
				end
			end

			if arg_57_1.time_ >= var_60_6 + var_60_7 and arg_57_1.time_ < var_60_6 + var_60_7 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.characterEffect4010ui_story then
				local var_60_10 = 0.5

				arg_57_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_57_1.var_.characterEffect4010ui_story.fillRatio = var_60_10
			end

			local var_60_11 = 0
			local var_60_12 = 0.475

			if var_60_11 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_13 = arg_57_1:FormatText(StoryNameCfg[20].name)

				arg_57_1.leftNameTxt_.text = var_60_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_14 = arg_57_1:GetWordFromCfg(115241014)
				local var_60_15 = arg_57_1:FormatText(var_60_14.content)

				arg_57_1.text_.text = var_60_15

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_16 = 19
				local var_60_17 = utf8.len(var_60_15)
				local var_60_18 = var_60_16 <= 0 and var_60_12 or var_60_12 * (var_60_17 / var_60_16)

				if var_60_18 > 0 and var_60_12 < var_60_18 then
					arg_57_1.talkMaxDuration = var_60_18

					if var_60_18 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_18 + var_60_11
					end
				end

				arg_57_1.text_.text = var_60_15
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241014", "story_v_out_115241.awb") ~= 0 then
					local var_60_19 = manager.audio:GetVoiceLength("story_v_out_115241", "115241014", "story_v_out_115241.awb") / 1000

					if var_60_19 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_19 + var_60_11
					end

					if var_60_14.prefab_name ~= "" and arg_57_1.actors_[var_60_14.prefab_name] ~= nil then
						local var_60_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_14.prefab_name].transform, "story_v_out_115241", "115241014", "story_v_out_115241.awb")

						arg_57_1:RecordAudio("115241014", var_60_20)
						arg_57_1:RecordAudio("115241014", var_60_20)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_115241", "115241014", "story_v_out_115241.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_115241", "115241014", "story_v_out_115241.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_21 = math.max(var_60_12, arg_57_1.talkMaxDuration)

			if var_60_11 <= arg_57_1.time_ and arg_57_1.time_ < var_60_11 + var_60_21 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_11) / var_60_21

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_11 + var_60_21 and arg_57_1.time_ < var_60_11 + var_60_21 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play115241015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 115241015
		arg_61_1.duration_ = 22.17

		local var_61_0 = {
			ja = 22.166,
			ko = 10.833,
			zh = 9.5,
			en = 13.5
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
				arg_61_0:Play115241016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_64_1 = arg_61_1.actors_["4010ui_story"]
			local var_64_2 = 0

			if var_64_2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect4010ui_story == nil then
				arg_61_1.var_.characterEffect4010ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_3 = 0.2

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_3 and not isNil(var_64_1) then
				local var_64_4 = (arg_61_1.time_ - var_64_2) / var_64_3

				if arg_61_1.var_.characterEffect4010ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_2 + var_64_3 and arg_61_1.time_ < var_64_2 + var_64_3 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect4010ui_story then
				arg_61_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_64_5 = arg_61_1.actors_["3008ui_story"]
			local var_64_6 = 0

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect3008ui_story == nil then
				arg_61_1.var_.characterEffect3008ui_story = var_64_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_7 = 0.2

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_7 and not isNil(var_64_5) then
				local var_64_8 = (arg_61_1.time_ - var_64_6) / var_64_7

				if arg_61_1.var_.characterEffect3008ui_story and not isNil(var_64_5) then
					local var_64_9 = Mathf.Lerp(0, 0.5, var_64_8)

					arg_61_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_61_1.var_.characterEffect3008ui_story.fillRatio = var_64_9
				end
			end

			if arg_61_1.time_ >= var_64_6 + var_64_7 and arg_61_1.time_ < var_64_6 + var_64_7 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect3008ui_story then
				local var_64_10 = 0.5

				arg_61_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_61_1.var_.characterEffect3008ui_story.fillRatio = var_64_10
			end

			local var_64_11 = 0

			if var_64_11 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 then
				arg_61_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_1")
			end

			local var_64_12 = 0
			local var_64_13 = 1.125

			if var_64_12 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_14 = arg_61_1:FormatText(StoryNameCfg[42].name)

				arg_61_1.leftNameTxt_.text = var_64_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_15 = arg_61_1:GetWordFromCfg(115241015)
				local var_64_16 = arg_61_1:FormatText(var_64_15.content)

				arg_61_1.text_.text = var_64_16

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_17 = 45
				local var_64_18 = utf8.len(var_64_16)
				local var_64_19 = var_64_17 <= 0 and var_64_13 or var_64_13 * (var_64_18 / var_64_17)

				if var_64_19 > 0 and var_64_13 < var_64_19 then
					arg_61_1.talkMaxDuration = var_64_19

					if var_64_19 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_19 + var_64_12
					end
				end

				arg_61_1.text_.text = var_64_16
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241015", "story_v_out_115241.awb") ~= 0 then
					local var_64_20 = manager.audio:GetVoiceLength("story_v_out_115241", "115241015", "story_v_out_115241.awb") / 1000

					if var_64_20 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_20 + var_64_12
					end

					if var_64_15.prefab_name ~= "" and arg_61_1.actors_[var_64_15.prefab_name] ~= nil then
						local var_64_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_15.prefab_name].transform, "story_v_out_115241", "115241015", "story_v_out_115241.awb")

						arg_61_1:RecordAudio("115241015", var_64_21)
						arg_61_1:RecordAudio("115241015", var_64_21)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_115241", "115241015", "story_v_out_115241.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_115241", "115241015", "story_v_out_115241.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_22 = math.max(var_64_13, arg_61_1.talkMaxDuration)

			if var_64_12 <= arg_61_1.time_ and arg_61_1.time_ < var_64_12 + var_64_22 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_12) / var_64_22

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_12 + var_64_22 and arg_61_1.time_ < var_64_12 + var_64_22 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play115241016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 115241016
		arg_65_1.duration_ = 13.7

		local var_65_0 = {
			ja = 13.7,
			ko = 9.066,
			zh = 7.033,
			en = 8.533
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
				arg_65_0:Play115241017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_68_1 = 0
			local var_68_2 = 1

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_3 = arg_65_1:FormatText(StoryNameCfg[42].name)

				arg_65_1.leftNameTxt_.text = var_68_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_4 = arg_65_1:GetWordFromCfg(115241016)
				local var_68_5 = arg_65_1:FormatText(var_68_4.content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_6 = 39
				local var_68_7 = utf8.len(var_68_5)
				local var_68_8 = var_68_6 <= 0 and var_68_2 or var_68_2 * (var_68_7 / var_68_6)

				if var_68_8 > 0 and var_68_2 < var_68_8 then
					arg_65_1.talkMaxDuration = var_68_8

					if var_68_8 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241016", "story_v_out_115241.awb") ~= 0 then
					local var_68_9 = manager.audio:GetVoiceLength("story_v_out_115241", "115241016", "story_v_out_115241.awb") / 1000

					if var_68_9 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_1
					end

					if var_68_4.prefab_name ~= "" and arg_65_1.actors_[var_68_4.prefab_name] ~= nil then
						local var_68_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_4.prefab_name].transform, "story_v_out_115241", "115241016", "story_v_out_115241.awb")

						arg_65_1:RecordAudio("115241016", var_68_10)
						arg_65_1:RecordAudio("115241016", var_68_10)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_115241", "115241016", "story_v_out_115241.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_115241", "115241016", "story_v_out_115241.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_11 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_11 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_11

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_11 and arg_65_1.time_ < var_68_1 + var_68_11 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play115241017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 115241017
		arg_69_1.duration_ = 15

		local var_69_0 = {
			ja = 15,
			ko = 13.3,
			zh = 12.766,
			en = 11.033
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
				arg_69_0:Play115241018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_72_1 = 0
			local var_72_2 = 1.5

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_3 = arg_69_1:FormatText(StoryNameCfg[42].name)

				arg_69_1.leftNameTxt_.text = var_72_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:GetWordFromCfg(115241017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 60
				local var_72_7 = utf8.len(var_72_5)
				local var_72_8 = var_72_6 <= 0 and var_72_2 or var_72_2 * (var_72_7 / var_72_6)

				if var_72_8 > 0 and var_72_2 < var_72_8 then
					arg_69_1.talkMaxDuration = var_72_8

					if var_72_8 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241017", "story_v_out_115241.awb") ~= 0 then
					local var_72_9 = manager.audio:GetVoiceLength("story_v_out_115241", "115241017", "story_v_out_115241.awb") / 1000

					if var_72_9 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_1
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_115241", "115241017", "story_v_out_115241.awb")

						arg_69_1:RecordAudio("115241017", var_72_10)
						arg_69_1:RecordAudio("115241017", var_72_10)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_115241", "115241017", "story_v_out_115241.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_115241", "115241017", "story_v_out_115241.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_11 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_11 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_11

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_11 and arg_69_1.time_ < var_72_1 + var_72_11 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play115241018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 115241018
		arg_73_1.duration_ = 10.3

		local var_73_0 = {
			ja = 9.8,
			ko = 10.3,
			zh = 10,
			en = 4.633
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
				arg_73_0:Play115241019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_76_1 = 0
			local var_76_2 = 1.1

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_3 = arg_73_1:FormatText(StoryNameCfg[42].name)

				arg_73_1.leftNameTxt_.text = var_76_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(115241018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 44
				local var_76_7 = utf8.len(var_76_5)
				local var_76_8 = var_76_6 <= 0 and var_76_2 or var_76_2 * (var_76_7 / var_76_6)

				if var_76_8 > 0 and var_76_2 < var_76_8 then
					arg_73_1.talkMaxDuration = var_76_8

					if var_76_8 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241018", "story_v_out_115241.awb") ~= 0 then
					local var_76_9 = manager.audio:GetVoiceLength("story_v_out_115241", "115241018", "story_v_out_115241.awb") / 1000

					if var_76_9 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_1
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_out_115241", "115241018", "story_v_out_115241.awb")

						arg_73_1:RecordAudio("115241018", var_76_10)
						arg_73_1:RecordAudio("115241018", var_76_10)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_115241", "115241018", "story_v_out_115241.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_115241", "115241018", "story_v_out_115241.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_11 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_11 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_11

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_11 and arg_73_1.time_ < var_76_1 + var_76_11 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play115241019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 115241019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play115241020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["4010ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect4010ui_story == nil then
				arg_77_1.var_.characterEffect4010ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect4010ui_story and not isNil(var_80_0) then
					local var_80_4 = Mathf.Lerp(0, 0.5, var_80_3)

					arg_77_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_77_1.var_.characterEffect4010ui_story.fillRatio = var_80_4
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect4010ui_story then
				local var_80_5 = 0.5

				arg_77_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_77_1.var_.characterEffect4010ui_story.fillRatio = var_80_5
			end

			local var_80_6 = 0
			local var_80_7 = 0.425

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:GetWordFromCfg(115241019)
				local var_80_9 = arg_77_1:FormatText(var_80_8.content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 17
				local var_80_11 = utf8.len(var_80_9)
				local var_80_12 = var_80_10 <= 0 and var_80_7 or var_80_7 * (var_80_11 / var_80_10)

				if var_80_12 > 0 and var_80_7 < var_80_12 then
					arg_77_1.talkMaxDuration = var_80_12

					if var_80_12 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_9
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_13 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_13 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_13

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_13 and arg_77_1.time_ < var_80_6 + var_80_13 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play115241020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 115241020
		arg_81_1.duration_ = 8.7

		local var_81_0 = {
			ja = 8.7,
			ko = 6.566,
			zh = 6.166,
			en = 8.233
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
				arg_81_0:Play115241021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["4010ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect4010ui_story == nil then
				arg_81_1.var_.characterEffect4010ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect4010ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect4010ui_story then
				arg_81_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_84_4 = 0

			if var_84_4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_84_5 = 0
			local var_84_6 = 0.75

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_7 = arg_81_1:FormatText(StoryNameCfg[42].name)

				arg_81_1.leftNameTxt_.text = var_84_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_8 = arg_81_1:GetWordFromCfg(115241020)
				local var_84_9 = arg_81_1:FormatText(var_84_8.content)

				arg_81_1.text_.text = var_84_9

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_10 = 30
				local var_84_11 = utf8.len(var_84_9)
				local var_84_12 = var_84_10 <= 0 and var_84_6 or var_84_6 * (var_84_11 / var_84_10)

				if var_84_12 > 0 and var_84_6 < var_84_12 then
					arg_81_1.talkMaxDuration = var_84_12

					if var_84_12 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_5
					end
				end

				arg_81_1.text_.text = var_84_9
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241020", "story_v_out_115241.awb") ~= 0 then
					local var_84_13 = manager.audio:GetVoiceLength("story_v_out_115241", "115241020", "story_v_out_115241.awb") / 1000

					if var_84_13 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_5
					end

					if var_84_8.prefab_name ~= "" and arg_81_1.actors_[var_84_8.prefab_name] ~= nil then
						local var_84_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_8.prefab_name].transform, "story_v_out_115241", "115241020", "story_v_out_115241.awb")

						arg_81_1:RecordAudio("115241020", var_84_14)
						arg_81_1:RecordAudio("115241020", var_84_14)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_115241", "115241020", "story_v_out_115241.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_115241", "115241020", "story_v_out_115241.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_15 = math.max(var_84_6, arg_81_1.talkMaxDuration)

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_15 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_5) / var_84_15

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_5 + var_84_15 and arg_81_1.time_ < var_84_5 + var_84_15 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play115241021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 115241021
		arg_85_1.duration_ = 12.7

		local var_85_0 = {
			ja = 8,
			ko = 8.866,
			zh = 8.1,
			en = 12.7
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
				arg_85_0:Play115241022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["4010ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect4010ui_story == nil then
				arg_85_1.var_.characterEffect4010ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect4010ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_85_1.var_.characterEffect4010ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect4010ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_85_1.var_.characterEffect4010ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.875

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[21].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1035")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_9 = arg_85_1:GetWordFromCfg(115241021)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241021", "story_v_out_115241.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_115241", "115241021", "story_v_out_115241.awb") / 1000

					if var_88_14 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_6
					end

					if var_88_9.prefab_name ~= "" and arg_85_1.actors_[var_88_9.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_9.prefab_name].transform, "story_v_out_115241", "115241021", "story_v_out_115241.awb")

						arg_85_1:RecordAudio("115241021", var_88_15)
						arg_85_1:RecordAudio("115241021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_115241", "115241021", "story_v_out_115241.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_115241", "115241021", "story_v_out_115241.awb")
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
	Play115241022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 115241022
		arg_89_1.duration_ = 9.37

		local var_89_0 = {
			ja = 5.233,
			ko = 8.033,
			zh = 6.433,
			en = 9.366
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
				arg_89_0:Play115241023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_92_1 = arg_89_1.actors_["3008ui_story"]
			local var_92_2 = 0

			if var_92_2 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect3008ui_story == nil then
				arg_89_1.var_.characterEffect3008ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_3 = 0.2

			if var_92_2 <= arg_89_1.time_ and arg_89_1.time_ < var_92_2 + var_92_3 and not isNil(var_92_1) then
				local var_92_4 = (arg_89_1.time_ - var_92_2) / var_92_3

				if arg_89_1.var_.characterEffect3008ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_2 + var_92_3 and arg_89_1.time_ < var_92_2 + var_92_3 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect3008ui_story then
				arg_89_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_92_5 = 0

			if var_92_5 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008actionlink/3008action464")
			end

			local var_92_6 = 0
			local var_92_7 = 0.95

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_8 = arg_89_1:FormatText(StoryNameCfg[20].name)

				arg_89_1.leftNameTxt_.text = var_92_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_9 = arg_89_1:GetWordFromCfg(115241022)
				local var_92_10 = arg_89_1:FormatText(var_92_9.content)

				arg_89_1.text_.text = var_92_10

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 38
				local var_92_12 = utf8.len(var_92_10)
				local var_92_13 = var_92_11 <= 0 and var_92_7 or var_92_7 * (var_92_12 / var_92_11)

				if var_92_13 > 0 and var_92_7 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_10
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241022", "story_v_out_115241.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_out_115241", "115241022", "story_v_out_115241.awb") / 1000

					if var_92_14 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_6
					end

					if var_92_9.prefab_name ~= "" and arg_89_1.actors_[var_92_9.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_9.prefab_name].transform, "story_v_out_115241", "115241022", "story_v_out_115241.awb")

						arg_89_1:RecordAudio("115241022", var_92_15)
						arg_89_1:RecordAudio("115241022", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_115241", "115241022", "story_v_out_115241.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_115241", "115241022", "story_v_out_115241.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_16 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_16 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_16

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_16 and arg_89_1.time_ < var_92_6 + var_92_16 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play115241023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 115241023
		arg_93_1.duration_ = 11.6

		local var_93_0 = {
			ja = 11.6,
			ko = 6.566,
			zh = 4.366,
			en = 5.066
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
				arg_93_0:Play115241024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_96_1 = arg_93_1.actors_["4010ui_story"]
			local var_96_2 = 0

			if var_96_2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect4010ui_story == nil then
				arg_93_1.var_.characterEffect4010ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_3 = 0.2

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_3 and not isNil(var_96_1) then
				local var_96_4 = (arg_93_1.time_ - var_96_2) / var_96_3

				if arg_93_1.var_.characterEffect4010ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_2 + var_96_3 and arg_93_1.time_ < var_96_2 + var_96_3 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect4010ui_story then
				arg_93_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_96_5 = arg_93_1.actors_["3008ui_story"]
			local var_96_6 = 0

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.characterEffect3008ui_story == nil then
				arg_93_1.var_.characterEffect3008ui_story = var_96_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_7 = 0.2

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_7 and not isNil(var_96_5) then
				local var_96_8 = (arg_93_1.time_ - var_96_6) / var_96_7

				if arg_93_1.var_.characterEffect3008ui_story and not isNil(var_96_5) then
					local var_96_9 = Mathf.Lerp(0, 0.5, var_96_8)

					arg_93_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_93_1.var_.characterEffect3008ui_story.fillRatio = var_96_9
				end
			end

			if arg_93_1.time_ >= var_96_6 + var_96_7 and arg_93_1.time_ < var_96_6 + var_96_7 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.characterEffect3008ui_story then
				local var_96_10 = 0.5

				arg_93_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_93_1.var_.characterEffect3008ui_story.fillRatio = var_96_10
			end

			local var_96_11 = 0

			if var_96_11 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 then
				arg_93_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_2")
			end

			local var_96_12 = 0
			local var_96_13 = 0.525

			if var_96_12 < arg_93_1.time_ and arg_93_1.time_ <= var_96_12 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_14 = arg_93_1:FormatText(StoryNameCfg[42].name)

				arg_93_1.leftNameTxt_.text = var_96_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_15 = arg_93_1:GetWordFromCfg(115241023)
				local var_96_16 = arg_93_1:FormatText(var_96_15.content)

				arg_93_1.text_.text = var_96_16

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_17 = 21
				local var_96_18 = utf8.len(var_96_16)
				local var_96_19 = var_96_17 <= 0 and var_96_13 or var_96_13 * (var_96_18 / var_96_17)

				if var_96_19 > 0 and var_96_13 < var_96_19 then
					arg_93_1.talkMaxDuration = var_96_19

					if var_96_19 + var_96_12 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_19 + var_96_12
					end
				end

				arg_93_1.text_.text = var_96_16
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241023", "story_v_out_115241.awb") ~= 0 then
					local var_96_20 = manager.audio:GetVoiceLength("story_v_out_115241", "115241023", "story_v_out_115241.awb") / 1000

					if var_96_20 + var_96_12 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_20 + var_96_12
					end

					if var_96_15.prefab_name ~= "" and arg_93_1.actors_[var_96_15.prefab_name] ~= nil then
						local var_96_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_15.prefab_name].transform, "story_v_out_115241", "115241023", "story_v_out_115241.awb")

						arg_93_1:RecordAudio("115241023", var_96_21)
						arg_93_1:RecordAudio("115241023", var_96_21)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_115241", "115241023", "story_v_out_115241.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_115241", "115241023", "story_v_out_115241.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_22 = math.max(var_96_13, arg_93_1.talkMaxDuration)

			if var_96_12 <= arg_93_1.time_ and arg_93_1.time_ < var_96_12 + var_96_22 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_12) / var_96_22

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_12 + var_96_22 and arg_93_1.time_ < var_96_12 + var_96_22 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play115241024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 115241024
		arg_97_1.duration_ = 7.47

		local var_97_0 = {
			ja = 7.466,
			ko = 6.166,
			zh = 6.3,
			en = 6.8
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
				arg_97_0:Play115241025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_100_1 = 0
			local var_100_2 = 0.8

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_3 = arg_97_1:FormatText(StoryNameCfg[42].name)

				arg_97_1.leftNameTxt_.text = var_100_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_4 = arg_97_1:GetWordFromCfg(115241024)
				local var_100_5 = arg_97_1:FormatText(var_100_4.content)

				arg_97_1.text_.text = var_100_5

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_6 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241024", "story_v_out_115241.awb") ~= 0 then
					local var_100_9 = manager.audio:GetVoiceLength("story_v_out_115241", "115241024", "story_v_out_115241.awb") / 1000

					if var_100_9 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_1
					end

					if var_100_4.prefab_name ~= "" and arg_97_1.actors_[var_100_4.prefab_name] ~= nil then
						local var_100_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_4.prefab_name].transform, "story_v_out_115241", "115241024", "story_v_out_115241.awb")

						arg_97_1:RecordAudio("115241024", var_100_10)
						arg_97_1:RecordAudio("115241024", var_100_10)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_115241", "115241024", "story_v_out_115241.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_115241", "115241024", "story_v_out_115241.awb")
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
	Play115241025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 115241025
		arg_101_1.duration_ = 13.87

		local var_101_0 = {
			ja = 6.3,
			ko = 10.9,
			zh = 7.833,
			en = 13.866
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
				arg_101_0:Play115241026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_104_1 = arg_101_1.actors_["3008ui_story"]
			local var_104_2 = 0

			if var_104_2 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect3008ui_story == nil then
				arg_101_1.var_.characterEffect3008ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_3 = 0.2

			if var_104_2 <= arg_101_1.time_ and arg_101_1.time_ < var_104_2 + var_104_3 and not isNil(var_104_1) then
				local var_104_4 = (arg_101_1.time_ - var_104_2) / var_104_3

				if arg_101_1.var_.characterEffect3008ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_2 + var_104_3 and arg_101_1.time_ < var_104_2 + var_104_3 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect3008ui_story then
				arg_101_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_104_5 = arg_101_1.actors_["4010ui_story"]
			local var_104_6 = 0

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.characterEffect4010ui_story == nil then
				arg_101_1.var_.characterEffect4010ui_story = var_104_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_7 = 0.2

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_7 and not isNil(var_104_5) then
				local var_104_8 = (arg_101_1.time_ - var_104_6) / var_104_7

				if arg_101_1.var_.characterEffect4010ui_story and not isNil(var_104_5) then
					local var_104_9 = Mathf.Lerp(0, 0.5, var_104_8)

					arg_101_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_101_1.var_.characterEffect4010ui_story.fillRatio = var_104_9
				end
			end

			if arg_101_1.time_ >= var_104_6 + var_104_7 and arg_101_1.time_ < var_104_6 + var_104_7 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.characterEffect4010ui_story then
				local var_104_10 = 0.5

				arg_101_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_101_1.var_.characterEffect4010ui_story.fillRatio = var_104_10
			end

			local var_104_11 = 0

			if var_104_11 < arg_101_1.time_ and arg_101_1.time_ <= var_104_11 + arg_104_0 then
				arg_101_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action4_2")
			end

			local var_104_12 = 0
			local var_104_13 = 0.85

			if var_104_12 < arg_101_1.time_ and arg_101_1.time_ <= var_104_12 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_14 = arg_101_1:FormatText(StoryNameCfg[20].name)

				arg_101_1.leftNameTxt_.text = var_104_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_15 = arg_101_1:GetWordFromCfg(115241025)
				local var_104_16 = arg_101_1:FormatText(var_104_15.content)

				arg_101_1.text_.text = var_104_16

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_17 = 34
				local var_104_18 = utf8.len(var_104_16)
				local var_104_19 = var_104_17 <= 0 and var_104_13 or var_104_13 * (var_104_18 / var_104_17)

				if var_104_19 > 0 and var_104_13 < var_104_19 then
					arg_101_1.talkMaxDuration = var_104_19

					if var_104_19 + var_104_12 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_19 + var_104_12
					end
				end

				arg_101_1.text_.text = var_104_16
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241025", "story_v_out_115241.awb") ~= 0 then
					local var_104_20 = manager.audio:GetVoiceLength("story_v_out_115241", "115241025", "story_v_out_115241.awb") / 1000

					if var_104_20 + var_104_12 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_20 + var_104_12
					end

					if var_104_15.prefab_name ~= "" and arg_101_1.actors_[var_104_15.prefab_name] ~= nil then
						local var_104_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_15.prefab_name].transform, "story_v_out_115241", "115241025", "story_v_out_115241.awb")

						arg_101_1:RecordAudio("115241025", var_104_21)
						arg_101_1:RecordAudio("115241025", var_104_21)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_115241", "115241025", "story_v_out_115241.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_115241", "115241025", "story_v_out_115241.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_22 = math.max(var_104_13, arg_101_1.talkMaxDuration)

			if var_104_12 <= arg_101_1.time_ and arg_101_1.time_ < var_104_12 + var_104_22 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_12) / var_104_22

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_12 + var_104_22 and arg_101_1.time_ < var_104_12 + var_104_22 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play115241026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 115241026
		arg_105_1.duration_ = 18.37

		local var_105_0 = {
			ja = 18.366,
			ko = 12.8,
			zh = 12.466,
			en = 13.8
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
				arg_105_0:Play115241027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_108_1 = arg_105_1.actors_["4010ui_story"]
			local var_108_2 = 0

			if var_108_2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect4010ui_story == nil then
				arg_105_1.var_.characterEffect4010ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_3 = 0.2

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_3 and not isNil(var_108_1) then
				local var_108_4 = (arg_105_1.time_ - var_108_2) / var_108_3

				if arg_105_1.var_.characterEffect4010ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_2 + var_108_3 and arg_105_1.time_ < var_108_2 + var_108_3 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect4010ui_story then
				arg_105_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_108_5 = arg_105_1.actors_["3008ui_story"]
			local var_108_6 = 0

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect3008ui_story == nil then
				arg_105_1.var_.characterEffect3008ui_story = var_108_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_7 = 0.2

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_7 and not isNil(var_108_5) then
				local var_108_8 = (arg_105_1.time_ - var_108_6) / var_108_7

				if arg_105_1.var_.characterEffect3008ui_story and not isNil(var_108_5) then
					local var_108_9 = Mathf.Lerp(0, 0.5, var_108_8)

					arg_105_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_105_1.var_.characterEffect3008ui_story.fillRatio = var_108_9
				end
			end

			if arg_105_1.time_ >= var_108_6 + var_108_7 and arg_105_1.time_ < var_108_6 + var_108_7 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect3008ui_story then
				local var_108_10 = 0.5

				arg_105_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_105_1.var_.characterEffect3008ui_story.fillRatio = var_108_10
			end

			local var_108_11 = 0

			if var_108_11 < arg_105_1.time_ and arg_105_1.time_ <= var_108_11 + arg_108_0 then
				arg_105_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_1")
			end

			local var_108_12 = 0
			local var_108_13 = 1.475

			if var_108_12 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_14 = arg_105_1:FormatText(StoryNameCfg[42].name)

				arg_105_1.leftNameTxt_.text = var_108_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_15 = arg_105_1:GetWordFromCfg(115241026)
				local var_108_16 = arg_105_1:FormatText(var_108_15.content)

				arg_105_1.text_.text = var_108_16

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_17 = 59
				local var_108_18 = utf8.len(var_108_16)
				local var_108_19 = var_108_17 <= 0 and var_108_13 or var_108_13 * (var_108_18 / var_108_17)

				if var_108_19 > 0 and var_108_13 < var_108_19 then
					arg_105_1.talkMaxDuration = var_108_19

					if var_108_19 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_19 + var_108_12
					end
				end

				arg_105_1.text_.text = var_108_16
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241026", "story_v_out_115241.awb") ~= 0 then
					local var_108_20 = manager.audio:GetVoiceLength("story_v_out_115241", "115241026", "story_v_out_115241.awb") / 1000

					if var_108_20 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_20 + var_108_12
					end

					if var_108_15.prefab_name ~= "" and arg_105_1.actors_[var_108_15.prefab_name] ~= nil then
						local var_108_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_15.prefab_name].transform, "story_v_out_115241", "115241026", "story_v_out_115241.awb")

						arg_105_1:RecordAudio("115241026", var_108_21)
						arg_105_1:RecordAudio("115241026", var_108_21)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_115241", "115241026", "story_v_out_115241.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_115241", "115241026", "story_v_out_115241.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_22 = math.max(var_108_13, arg_105_1.talkMaxDuration)

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_22 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_12) / var_108_22

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_12 + var_108_22 and arg_105_1.time_ < var_108_12 + var_108_22 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play115241027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 115241027
		arg_109_1.duration_ = 2.97

		local var_109_0 = {
			ja = 2.966,
			ko = 2.2,
			zh = 2.266,
			en = 2.4
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
				arg_109_0:Play115241028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["3008ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect3008ui_story == nil then
				arg_109_1.var_.characterEffect3008ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.2

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect3008ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_109_1.var_.characterEffect3008ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect3008ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_109_1.var_.characterEffect3008ui_story.fillRatio = var_112_5
			end

			local var_112_6 = arg_109_1.actors_["4010ui_story"]
			local var_112_7 = 0

			if var_112_7 < arg_109_1.time_ and arg_109_1.time_ <= var_112_7 + arg_112_0 and not isNil(var_112_6) and arg_109_1.var_.characterEffect4010ui_story == nil then
				arg_109_1.var_.characterEffect4010ui_story = var_112_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_8 = 0.2

			if var_112_7 <= arg_109_1.time_ and arg_109_1.time_ < var_112_7 + var_112_8 and not isNil(var_112_6) then
				local var_112_9 = (arg_109_1.time_ - var_112_7) / var_112_8

				if arg_109_1.var_.characterEffect4010ui_story and not isNil(var_112_6) then
					arg_109_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_7 + var_112_8 and arg_109_1.time_ < var_112_7 + var_112_8 + arg_112_0 and not isNil(var_112_6) and arg_109_1.var_.characterEffect4010ui_story then
				arg_109_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_112_10 = 0
			local var_112_11 = 0.125

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_12 = arg_109_1:FormatText(StoryNameCfg[20].name)

				arg_109_1.leftNameTxt_.text = var_112_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_13 = arg_109_1:GetWordFromCfg(115241027)
				local var_112_14 = arg_109_1:FormatText(var_112_13.content)

				arg_109_1.text_.text = var_112_14

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_15 = 5
				local var_112_16 = utf8.len(var_112_14)
				local var_112_17 = var_112_15 <= 0 and var_112_11 or var_112_11 * (var_112_16 / var_112_15)

				if var_112_17 > 0 and var_112_11 < var_112_17 then
					arg_109_1.talkMaxDuration = var_112_17

					if var_112_17 + var_112_10 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_17 + var_112_10
					end
				end

				arg_109_1.text_.text = var_112_14
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241027", "story_v_out_115241.awb") ~= 0 then
					local var_112_18 = manager.audio:GetVoiceLength("story_v_out_115241", "115241027", "story_v_out_115241.awb") / 1000

					if var_112_18 + var_112_10 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_18 + var_112_10
					end

					if var_112_13.prefab_name ~= "" and arg_109_1.actors_[var_112_13.prefab_name] ~= nil then
						local var_112_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_13.prefab_name].transform, "story_v_out_115241", "115241027", "story_v_out_115241.awb")

						arg_109_1:RecordAudio("115241027", var_112_19)
						arg_109_1:RecordAudio("115241027", var_112_19)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_115241", "115241027", "story_v_out_115241.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_115241", "115241027", "story_v_out_115241.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_20 = math.max(var_112_11, arg_109_1.talkMaxDuration)

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_20 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_10) / var_112_20

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_10 + var_112_20 and arg_109_1.time_ < var_112_10 + var_112_20 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play115241028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 115241028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play115241029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["4010ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos4010ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0, 100, 0)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos4010ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, 100, 0)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["3008ui_story"].transform
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 then
				arg_113_1.var_.moveOldPos3008ui_story = var_116_9.localPosition
			end

			local var_116_11 = 0.001

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11
				local var_116_13 = Vector3.New(0, 100, 0)

				var_116_9.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos3008ui_story, var_116_13, var_116_12)

				local var_116_14 = manager.ui.mainCamera.transform.position - var_116_9.position

				var_116_9.forward = Vector3.New(var_116_14.x, var_116_14.y, var_116_14.z)

				local var_116_15 = var_116_9.localEulerAngles

				var_116_15.z = 0
				var_116_15.x = 0
				var_116_9.localEulerAngles = var_116_15
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 then
				var_116_9.localPosition = Vector3.New(0, 100, 0)

				local var_116_16 = manager.ui.mainCamera.transform.position - var_116_9.position

				var_116_9.forward = Vector3.New(var_116_16.x, var_116_16.y, var_116_16.z)

				local var_116_17 = var_116_9.localEulerAngles

				var_116_17.z = 0
				var_116_17.x = 0
				var_116_9.localEulerAngles = var_116_17
			end

			local var_116_18 = 0
			local var_116_19 = 1

			if var_116_18 < arg_113_1.time_ and arg_113_1.time_ <= var_116_18 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_20 = arg_113_1:GetWordFromCfg(115241028)
				local var_116_21 = arg_113_1:FormatText(var_116_20.content)

				arg_113_1.text_.text = var_116_21

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_22 = 40
				local var_116_23 = utf8.len(var_116_21)
				local var_116_24 = var_116_22 <= 0 and var_116_19 or var_116_19 * (var_116_23 / var_116_22)

				if var_116_24 > 0 and var_116_19 < var_116_24 then
					arg_113_1.talkMaxDuration = var_116_24

					if var_116_24 + var_116_18 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_24 + var_116_18
					end
				end

				arg_113_1.text_.text = var_116_21
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_25 = math.max(var_116_19, arg_113_1.talkMaxDuration)

			if var_116_18 <= arg_113_1.time_ and arg_113_1.time_ < var_116_18 + var_116_25 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_18) / var_116_25

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_18 + var_116_25 and arg_113_1.time_ < var_116_18 + var_116_25 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play115241029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 115241029
		arg_117_1.duration_ = 5.97

		local var_117_0 = {
			ja = 5.833,
			ko = 4.566,
			zh = 5.466,
			en = 5.966
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
			arg_117_1.auto_ = false
		end

		function arg_117_1.playNext_(arg_119_0)
			arg_117_1.onStoryFinished_()
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["4010ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos4010ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(0, -1.59, -5.2)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos4010ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = 0

			if var_120_9 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 then
				arg_117_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_1")
			end

			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 then
				arg_117_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_120_11 = arg_117_1.actors_["4010ui_story"]
			local var_120_12 = 0

			if var_120_12 < arg_117_1.time_ and arg_117_1.time_ <= var_120_12 + arg_120_0 and not isNil(var_120_11) and arg_117_1.var_.characterEffect4010ui_story == nil then
				arg_117_1.var_.characterEffect4010ui_story = var_120_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_13 = 0.2

			if var_120_12 <= arg_117_1.time_ and arg_117_1.time_ < var_120_12 + var_120_13 and not isNil(var_120_11) then
				local var_120_14 = (arg_117_1.time_ - var_120_12) / var_120_13

				if arg_117_1.var_.characterEffect4010ui_story and not isNil(var_120_11) then
					arg_117_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_12 + var_120_13 and arg_117_1.time_ < var_120_12 + var_120_13 + arg_120_0 and not isNil(var_120_11) and arg_117_1.var_.characterEffect4010ui_story then
				arg_117_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_120_15 = 0
			local var_120_16 = 0.4

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_17 = arg_117_1:FormatText(StoryNameCfg[42].name)

				arg_117_1.leftNameTxt_.text = var_120_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_18 = arg_117_1:GetWordFromCfg(115241029)
				local var_120_19 = arg_117_1:FormatText(var_120_18.content)

				arg_117_1.text_.text = var_120_19

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_20 = 16
				local var_120_21 = utf8.len(var_120_19)
				local var_120_22 = var_120_20 <= 0 and var_120_16 or var_120_16 * (var_120_21 / var_120_20)

				if var_120_22 > 0 and var_120_16 < var_120_22 then
					arg_117_1.talkMaxDuration = var_120_22

					if var_120_22 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_22 + var_120_15
					end
				end

				arg_117_1.text_.text = var_120_19
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115241", "115241029", "story_v_out_115241.awb") ~= 0 then
					local var_120_23 = manager.audio:GetVoiceLength("story_v_out_115241", "115241029", "story_v_out_115241.awb") / 1000

					if var_120_23 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_23 + var_120_15
					end

					if var_120_18.prefab_name ~= "" and arg_117_1.actors_[var_120_18.prefab_name] ~= nil then
						local var_120_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_18.prefab_name].transform, "story_v_out_115241", "115241029", "story_v_out_115241.awb")

						arg_117_1:RecordAudio("115241029", var_120_24)
						arg_117_1:RecordAudio("115241029", var_120_24)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_115241", "115241029", "story_v_out_115241.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_115241", "115241029", "story_v_out_115241.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_25 = math.max(var_120_16, arg_117_1.talkMaxDuration)

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_25 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_15) / var_120_25

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_15 + var_120_25 and arg_117_1.time_ < var_120_15 + var_120_25 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	assets = {
		"TextureConfig/Background/G03b"
	},
	voices = {
		"story_v_out_115241.awb"
	}
}
