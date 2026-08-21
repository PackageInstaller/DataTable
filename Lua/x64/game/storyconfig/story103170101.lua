return {
	Play317011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317011001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "C03a"

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
				local var_4_5 = arg_1_1.bgs_.C03a

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
					if iter_4_0 ~= "C03a" then
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

			local var_4_28 = 1.56666666666667
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

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
			local var_4_35 = 1.025

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

				local var_4_37 = arg_1_1:GetWordFromCfg(317011001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 41
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
	Play317011002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 317011002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play317011003(arg_9_1)
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

				local var_12_2 = arg_9_1:GetWordFromCfg(317011002)
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
	Play317011003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 317011003
		arg_13_1.duration_ = 6

		local var_13_0 = {
			zh = 3.8,
			ja = 6
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
				arg_13_0:Play317011004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10003ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "10003ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "10003ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["10003ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos10003ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0, -1.05, -5.9)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10003ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -1.05, -5.9)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["10003ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect10003ui_story == nil then
				arg_13_1.var_.characterEffect10003ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect10003ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect10003ui_story then
				arg_13_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action1_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_20 = 0
			local var_16_21 = 0.25

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[81].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(317011003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011003", "story_v_out_317011.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_out_317011", "317011003", "story_v_out_317011.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_out_317011", "317011003", "story_v_out_317011.awb")

						arg_13_1:RecordAudio("317011003", var_16_29)
						arg_13_1:RecordAudio("317011003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_317011", "317011003", "story_v_out_317011.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_317011", "317011003", "story_v_out_317011.awb")
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
				actorName = "10003ui_story",
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
	Play317011004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 317011004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play317011005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10003ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10003ui_story == nil then
				arg_17_1.var_.characterEffect10003ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect10003ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10003ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10003ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10003ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.75

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

				local var_20_8 = arg_17_1:GetWordFromCfg(317011004)
				local var_20_9 = arg_17_1:FormatText(var_20_8.content)

				arg_17_1.text_.text = var_20_9

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 30
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
	Play317011005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 317011005
		arg_21_1.duration_ = 3.8

		local var_21_0 = {
			zh = 3.6,
			ja = 3.8
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
				arg_21_0:Play317011006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10003ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10003ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10003ui_story, var_24_4, var_24_3)

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

			local var_24_9 = arg_21_1.actors_["10003ui_story"]
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect10003ui_story == nil then
				arg_21_1.var_.characterEffect10003ui_story = var_24_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 and not isNil(var_24_9) then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11

				if arg_21_1.var_.characterEffect10003ui_story and not isNil(var_24_9) then
					local var_24_13 = Mathf.Lerp(0, 0.5, var_24_12)

					arg_21_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10003ui_story.fillRatio = var_24_13
				end
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect10003ui_story then
				local var_24_14 = 0.5

				arg_21_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10003ui_story.fillRatio = var_24_14
			end

			local var_24_15 = "10053ui_story"

			if arg_21_1.actors_[var_24_15] == nil then
				local var_24_16 = Asset.Load("Char/" .. "10053ui_story")

				if not isNil(var_24_16) then
					local var_24_17 = Object.Instantiate(Asset.Load("Char/" .. "10053ui_story"), arg_21_1.stage_.transform)

					var_24_17.name = var_24_15
					var_24_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_15] = var_24_17

					local var_24_18 = var_24_17:GetComponentInChildren(typeof(CharacterEffect))

					var_24_18.enabled = true

					local var_24_19 = GameObjectTools.GetOrAddComponent(var_24_17, typeof(DynamicBoneHelper))

					if var_24_19 then
						var_24_19:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_18.transform, false)

					arg_21_1.var_[var_24_15 .. "Animator"] = var_24_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_15 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_15 .. "LipSync"] = var_24_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_20 = arg_21_1.actors_["10053ui_story"].transform
			local var_24_21 = 0

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 then
				arg_21_1.var_.moveOldPos10053ui_story = var_24_20.localPosition
			end

			local var_24_22 = 0.001

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_22 then
				local var_24_23 = (arg_21_1.time_ - var_24_21) / var_24_22
				local var_24_24 = Vector3.New(0, -1.12, -5.99)

				var_24_20.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10053ui_story, var_24_24, var_24_23)

				local var_24_25 = manager.ui.mainCamera.transform.position - var_24_20.position

				var_24_20.forward = Vector3.New(var_24_25.x, var_24_25.y, var_24_25.z)

				local var_24_26 = var_24_20.localEulerAngles

				var_24_26.z = 0
				var_24_26.x = 0
				var_24_20.localEulerAngles = var_24_26
			end

			if arg_21_1.time_ >= var_24_21 + var_24_22 and arg_21_1.time_ < var_24_21 + var_24_22 + arg_24_0 then
				var_24_20.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_24_27 = manager.ui.mainCamera.transform.position - var_24_20.position

				var_24_20.forward = Vector3.New(var_24_27.x, var_24_27.y, var_24_27.z)

				local var_24_28 = var_24_20.localEulerAngles

				var_24_28.z = 0
				var_24_28.x = 0
				var_24_20.localEulerAngles = var_24_28
			end

			local var_24_29 = arg_21_1.actors_["10053ui_story"]
			local var_24_30 = 0

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 and not isNil(var_24_29) and arg_21_1.var_.characterEffect10053ui_story == nil then
				arg_21_1.var_.characterEffect10053ui_story = var_24_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_31 = 0.200000002980232

			if var_24_30 <= arg_21_1.time_ and arg_21_1.time_ < var_24_30 + var_24_31 and not isNil(var_24_29) then
				local var_24_32 = (arg_21_1.time_ - var_24_30) / var_24_31

				if arg_21_1.var_.characterEffect10053ui_story and not isNil(var_24_29) then
					arg_21_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_30 + var_24_31 and arg_21_1.time_ < var_24_30 + var_24_31 + arg_24_0 and not isNil(var_24_29) and arg_21_1.var_.characterEffect10053ui_story then
				arg_21_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_24_33 = 0

			if var_24_33 < arg_21_1.time_ and arg_21_1.time_ <= var_24_33 + arg_24_0 then
				arg_21_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_24_34 = 0

			if var_24_34 < arg_21_1.time_ and arg_21_1.time_ <= var_24_34 + arg_24_0 then
				arg_21_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_35 = 0
			local var_24_36 = 0.225

			if var_24_35 < arg_21_1.time_ and arg_21_1.time_ <= var_24_35 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_37 = arg_21_1:FormatText(StoryNameCfg[477].name)

				arg_21_1.leftNameTxt_.text = var_24_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_38 = arg_21_1:GetWordFromCfg(317011005)
				local var_24_39 = arg_21_1:FormatText(var_24_38.content)

				arg_21_1.text_.text = var_24_39

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_40 = 9
				local var_24_41 = utf8.len(var_24_39)
				local var_24_42 = var_24_40 <= 0 and var_24_36 or var_24_36 * (var_24_41 / var_24_40)

				if var_24_42 > 0 and var_24_36 < var_24_42 then
					arg_21_1.talkMaxDuration = var_24_42

					if var_24_42 + var_24_35 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_42 + var_24_35
					end
				end

				arg_21_1.text_.text = var_24_39
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011005", "story_v_out_317011.awb") ~= 0 then
					local var_24_43 = manager.audio:GetVoiceLength("story_v_out_317011", "317011005", "story_v_out_317011.awb") / 1000

					if var_24_43 + var_24_35 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_43 + var_24_35
					end

					if var_24_38.prefab_name ~= "" and arg_21_1.actors_[var_24_38.prefab_name] ~= nil then
						local var_24_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_38.prefab_name].transform, "story_v_out_317011", "317011005", "story_v_out_317011.awb")

						arg_21_1:RecordAudio("317011005", var_24_44)
						arg_21_1:RecordAudio("317011005", var_24_44)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_317011", "317011005", "story_v_out_317011.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_317011", "317011005", "story_v_out_317011.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_45 = math.max(var_24_36, arg_21_1.talkMaxDuration)

			if var_24_35 <= arg_21_1.time_ and arg_21_1.time_ < var_24_35 + var_24_45 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_35) / var_24_45

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_35 + var_24_45 and arg_21_1.time_ < var_24_35 + var_24_45 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play317011006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 317011006
		arg_25_1.duration_ = 5.13

		local var_25_0 = {
			zh = 4.8,
			ja = 5.133
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
				arg_25_0:Play317011007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10003ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos10003ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, -1.05, -5.9)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10003ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -1.05, -5.9)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["10003ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect10003ui_story == nil then
				arg_25_1.var_.characterEffect10003ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect10003ui_story and not isNil(var_28_9) then
					arg_25_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect10003ui_story then
				arg_25_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			local var_28_13 = 0

			if var_28_13 < arg_25_1.time_ and arg_25_1.time_ <= var_28_13 + arg_28_0 then
				arg_25_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action2_1")
			end

			local var_28_14 = 0

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_15 = arg_25_1.actors_["10053ui_story"].transform
			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.var_.moveOldPos10053ui_story = var_28_15.localPosition
			end

			local var_28_17 = 0.001

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 then
				local var_28_18 = (arg_25_1.time_ - var_28_16) / var_28_17
				local var_28_19 = Vector3.New(0, 100, 0)

				var_28_15.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10053ui_story, var_28_19, var_28_18)

				local var_28_20 = manager.ui.mainCamera.transform.position - var_28_15.position

				var_28_15.forward = Vector3.New(var_28_20.x, var_28_20.y, var_28_20.z)

				local var_28_21 = var_28_15.localEulerAngles

				var_28_21.z = 0
				var_28_21.x = 0
				var_28_15.localEulerAngles = var_28_21
			end

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 then
				var_28_15.localPosition = Vector3.New(0, 100, 0)

				local var_28_22 = manager.ui.mainCamera.transform.position - var_28_15.position

				var_28_15.forward = Vector3.New(var_28_22.x, var_28_22.y, var_28_22.z)

				local var_28_23 = var_28_15.localEulerAngles

				var_28_23.z = 0
				var_28_23.x = 0
				var_28_15.localEulerAngles = var_28_23
			end

			local var_28_24 = arg_25_1.actors_["10053ui_story"]
			local var_28_25 = 0

			if var_28_25 < arg_25_1.time_ and arg_25_1.time_ <= var_28_25 + arg_28_0 and not isNil(var_28_24) and arg_25_1.var_.characterEffect10053ui_story == nil then
				arg_25_1.var_.characterEffect10053ui_story = var_28_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_26 = 0.200000002980232

			if var_28_25 <= arg_25_1.time_ and arg_25_1.time_ < var_28_25 + var_28_26 and not isNil(var_28_24) then
				local var_28_27 = (arg_25_1.time_ - var_28_25) / var_28_26

				if arg_25_1.var_.characterEffect10053ui_story and not isNil(var_28_24) then
					local var_28_28 = Mathf.Lerp(0, 0.5, var_28_27)

					arg_25_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10053ui_story.fillRatio = var_28_28
				end
			end

			if arg_25_1.time_ >= var_28_25 + var_28_26 and arg_25_1.time_ < var_28_25 + var_28_26 + arg_28_0 and not isNil(var_28_24) and arg_25_1.var_.characterEffect10053ui_story then
				local var_28_29 = 0.5

				arg_25_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10053ui_story.fillRatio = var_28_29
			end

			local var_28_30 = 0
			local var_28_31 = 0.525

			if var_28_30 < arg_25_1.time_ and arg_25_1.time_ <= var_28_30 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_32 = arg_25_1:FormatText(StoryNameCfg[81].name)

				arg_25_1.leftNameTxt_.text = var_28_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_33 = arg_25_1:GetWordFromCfg(317011006)
				local var_28_34 = arg_25_1:FormatText(var_28_33.content)

				arg_25_1.text_.text = var_28_34

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_35 = 21
				local var_28_36 = utf8.len(var_28_34)
				local var_28_37 = var_28_35 <= 0 and var_28_31 or var_28_31 * (var_28_36 / var_28_35)

				if var_28_37 > 0 and var_28_31 < var_28_37 then
					arg_25_1.talkMaxDuration = var_28_37

					if var_28_37 + var_28_30 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_37 + var_28_30
					end
				end

				arg_25_1.text_.text = var_28_34
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011006", "story_v_out_317011.awb") ~= 0 then
					local var_28_38 = manager.audio:GetVoiceLength("story_v_out_317011", "317011006", "story_v_out_317011.awb") / 1000

					if var_28_38 + var_28_30 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_38 + var_28_30
					end

					if var_28_33.prefab_name ~= "" and arg_25_1.actors_[var_28_33.prefab_name] ~= nil then
						local var_28_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_33.prefab_name].transform, "story_v_out_317011", "317011006", "story_v_out_317011.awb")

						arg_25_1:RecordAudio("317011006", var_28_39)
						arg_25_1:RecordAudio("317011006", var_28_39)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_317011", "317011006", "story_v_out_317011.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_317011", "317011006", "story_v_out_317011.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_40 = math.max(var_28_31, arg_25_1.talkMaxDuration)

			if var_28_30 <= arg_25_1.time_ and arg_25_1.time_ < var_28_30 + var_28_40 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_30) / var_28_40

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_30 + var_28_40 and arg_25_1.time_ < var_28_30 + var_28_40 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play317011007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 317011007
		arg_29_1.duration_ = 12.47

		local var_29_0 = {
			zh = 12.466,
			ja = 11.033
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
				arg_29_0:Play317011008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10003ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos10003ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0, 100, 0)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10003ui_story, var_32_4, var_32_3)

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

			local var_32_9 = arg_29_1.actors_["10003ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect10003ui_story == nil then
				arg_29_1.var_.characterEffect10003ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect10003ui_story and not isNil(var_32_9) then
					local var_32_13 = Mathf.Lerp(0, 0.5, var_32_12)

					arg_29_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10003ui_story.fillRatio = var_32_13
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect10003ui_story then
				local var_32_14 = 0.5

				arg_29_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10003ui_story.fillRatio = var_32_14
			end

			local var_32_15 = arg_29_1.actors_["10053ui_story"].transform
			local var_32_16 = 0

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.var_.moveOldPos10053ui_story = var_32_15.localPosition
			end

			local var_32_17 = 0.001

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_17 then
				local var_32_18 = (arg_29_1.time_ - var_32_16) / var_32_17
				local var_32_19 = Vector3.New(0, -1.12, -5.99)

				var_32_15.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10053ui_story, var_32_19, var_32_18)

				local var_32_20 = manager.ui.mainCamera.transform.position - var_32_15.position

				var_32_15.forward = Vector3.New(var_32_20.x, var_32_20.y, var_32_20.z)

				local var_32_21 = var_32_15.localEulerAngles

				var_32_21.z = 0
				var_32_21.x = 0
				var_32_15.localEulerAngles = var_32_21
			end

			if arg_29_1.time_ >= var_32_16 + var_32_17 and arg_29_1.time_ < var_32_16 + var_32_17 + arg_32_0 then
				var_32_15.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_32_22 = manager.ui.mainCamera.transform.position - var_32_15.position

				var_32_15.forward = Vector3.New(var_32_22.x, var_32_22.y, var_32_22.z)

				local var_32_23 = var_32_15.localEulerAngles

				var_32_23.z = 0
				var_32_23.x = 0
				var_32_15.localEulerAngles = var_32_23
			end

			local var_32_24 = arg_29_1.actors_["10053ui_story"]
			local var_32_25 = 0

			if var_32_25 < arg_29_1.time_ and arg_29_1.time_ <= var_32_25 + arg_32_0 and not isNil(var_32_24) and arg_29_1.var_.characterEffect10053ui_story == nil then
				arg_29_1.var_.characterEffect10053ui_story = var_32_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_26 = 0.200000002980232

			if var_32_25 <= arg_29_1.time_ and arg_29_1.time_ < var_32_25 + var_32_26 and not isNil(var_32_24) then
				local var_32_27 = (arg_29_1.time_ - var_32_25) / var_32_26

				if arg_29_1.var_.characterEffect10053ui_story and not isNil(var_32_24) then
					arg_29_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_25 + var_32_26 and arg_29_1.time_ < var_32_25 + var_32_26 + arg_32_0 and not isNil(var_32_24) and arg_29_1.var_.characterEffect10053ui_story then
				arg_29_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_32_28 = 0

			if var_32_28 < arg_29_1.time_ and arg_29_1.time_ <= var_32_28 + arg_32_0 then
				arg_29_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_32_29 = 0
			local var_32_30 = 1.4

			if var_32_29 < arg_29_1.time_ and arg_29_1.time_ <= var_32_29 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_31 = arg_29_1:FormatText(StoryNameCfg[477].name)

				arg_29_1.leftNameTxt_.text = var_32_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_32 = arg_29_1:GetWordFromCfg(317011007)
				local var_32_33 = arg_29_1:FormatText(var_32_32.content)

				arg_29_1.text_.text = var_32_33

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_34 = 56
				local var_32_35 = utf8.len(var_32_33)
				local var_32_36 = var_32_34 <= 0 and var_32_30 or var_32_30 * (var_32_35 / var_32_34)

				if var_32_36 > 0 and var_32_30 < var_32_36 then
					arg_29_1.talkMaxDuration = var_32_36

					if var_32_36 + var_32_29 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_36 + var_32_29
					end
				end

				arg_29_1.text_.text = var_32_33
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011007", "story_v_out_317011.awb") ~= 0 then
					local var_32_37 = manager.audio:GetVoiceLength("story_v_out_317011", "317011007", "story_v_out_317011.awb") / 1000

					if var_32_37 + var_32_29 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_37 + var_32_29
					end

					if var_32_32.prefab_name ~= "" and arg_29_1.actors_[var_32_32.prefab_name] ~= nil then
						local var_32_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_32.prefab_name].transform, "story_v_out_317011", "317011007", "story_v_out_317011.awb")

						arg_29_1:RecordAudio("317011007", var_32_38)
						arg_29_1:RecordAudio("317011007", var_32_38)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_317011", "317011007", "story_v_out_317011.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_317011", "317011007", "story_v_out_317011.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_39 = math.max(var_32_30, arg_29_1.talkMaxDuration)

			if var_32_29 <= arg_29_1.time_ and arg_29_1.time_ < var_32_29 + var_32_39 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_29) / var_32_39

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_29 + var_32_39 and arg_29_1.time_ < var_32_29 + var_32_39 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play317011008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 317011008
		arg_33_1.duration_ = 11.53

		local var_33_0 = {
			zh = 9.666,
			ja = 11.533
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
				arg_33_0:Play317011009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10003ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10003ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0, -1.05, -5.9)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10003ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, -1.05, -5.9)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["10003ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect10003ui_story == nil then
				arg_33_1.var_.characterEffect10003ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect10003ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect10003ui_story then
				arg_33_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_36_14 = arg_33_1.actors_["10053ui_story"].transform
			local var_36_15 = 0

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.var_.moveOldPos10053ui_story = var_36_14.localPosition
			end

			local var_36_16 = 0.001

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_16 then
				local var_36_17 = (arg_33_1.time_ - var_36_15) / var_36_16
				local var_36_18 = Vector3.New(0, 100, 0)

				var_36_14.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10053ui_story, var_36_18, var_36_17)

				local var_36_19 = manager.ui.mainCamera.transform.position - var_36_14.position

				var_36_14.forward = Vector3.New(var_36_19.x, var_36_19.y, var_36_19.z)

				local var_36_20 = var_36_14.localEulerAngles

				var_36_20.z = 0
				var_36_20.x = 0
				var_36_14.localEulerAngles = var_36_20
			end

			if arg_33_1.time_ >= var_36_15 + var_36_16 and arg_33_1.time_ < var_36_15 + var_36_16 + arg_36_0 then
				var_36_14.localPosition = Vector3.New(0, 100, 0)

				local var_36_21 = manager.ui.mainCamera.transform.position - var_36_14.position

				var_36_14.forward = Vector3.New(var_36_21.x, var_36_21.y, var_36_21.z)

				local var_36_22 = var_36_14.localEulerAngles

				var_36_22.z = 0
				var_36_22.x = 0
				var_36_14.localEulerAngles = var_36_22
			end

			local var_36_23 = arg_33_1.actors_["10053ui_story"]
			local var_36_24 = 0

			if var_36_24 < arg_33_1.time_ and arg_33_1.time_ <= var_36_24 + arg_36_0 and not isNil(var_36_23) and arg_33_1.var_.characterEffect10053ui_story == nil then
				arg_33_1.var_.characterEffect10053ui_story = var_36_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_25 = 0.200000002980232

			if var_36_24 <= arg_33_1.time_ and arg_33_1.time_ < var_36_24 + var_36_25 and not isNil(var_36_23) then
				local var_36_26 = (arg_33_1.time_ - var_36_24) / var_36_25

				if arg_33_1.var_.characterEffect10053ui_story and not isNil(var_36_23) then
					local var_36_27 = Mathf.Lerp(0, 0.5, var_36_26)

					arg_33_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10053ui_story.fillRatio = var_36_27
				end
			end

			if arg_33_1.time_ >= var_36_24 + var_36_25 and arg_33_1.time_ < var_36_24 + var_36_25 + arg_36_0 and not isNil(var_36_23) and arg_33_1.var_.characterEffect10053ui_story then
				local var_36_28 = 0.5

				arg_33_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10053ui_story.fillRatio = var_36_28
			end

			local var_36_29 = 0
			local var_36_30 = 1.1

			if var_36_29 < arg_33_1.time_ and arg_33_1.time_ <= var_36_29 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_31 = arg_33_1:FormatText(StoryNameCfg[81].name)

				arg_33_1.leftNameTxt_.text = var_36_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_32 = arg_33_1:GetWordFromCfg(317011008)
				local var_36_33 = arg_33_1:FormatText(var_36_32.content)

				arg_33_1.text_.text = var_36_33

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_34 = 44
				local var_36_35 = utf8.len(var_36_33)
				local var_36_36 = var_36_34 <= 0 and var_36_30 or var_36_30 * (var_36_35 / var_36_34)

				if var_36_36 > 0 and var_36_30 < var_36_36 then
					arg_33_1.talkMaxDuration = var_36_36

					if var_36_36 + var_36_29 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_36 + var_36_29
					end
				end

				arg_33_1.text_.text = var_36_33
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011008", "story_v_out_317011.awb") ~= 0 then
					local var_36_37 = manager.audio:GetVoiceLength("story_v_out_317011", "317011008", "story_v_out_317011.awb") / 1000

					if var_36_37 + var_36_29 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_37 + var_36_29
					end

					if var_36_32.prefab_name ~= "" and arg_33_1.actors_[var_36_32.prefab_name] ~= nil then
						local var_36_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_32.prefab_name].transform, "story_v_out_317011", "317011008", "story_v_out_317011.awb")

						arg_33_1:RecordAudio("317011008", var_36_38)
						arg_33_1:RecordAudio("317011008", var_36_38)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_317011", "317011008", "story_v_out_317011.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_317011", "317011008", "story_v_out_317011.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_39 = math.max(var_36_30, arg_33_1.talkMaxDuration)

			if var_36_29 <= arg_33_1.time_ and arg_33_1.time_ < var_36_29 + var_36_39 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_29) / var_36_39

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_29 + var_36_39 and arg_33_1.time_ < var_36_29 + var_36_39 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play317011009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 317011009
		arg_37_1.duration_ = 4.5

		local var_37_0 = {
			zh = 4.3,
			ja = 4.5
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
				arg_37_0:Play317011010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10003ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos10003ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, -1.05, -5.9)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10003ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -1.05, -5.9)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_40_10 = 0
			local var_40_11 = 0.325

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_12 = arg_37_1:FormatText(StoryNameCfg[81].name)

				arg_37_1.leftNameTxt_.text = var_40_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_13 = arg_37_1:GetWordFromCfg(317011009)
				local var_40_14 = arg_37_1:FormatText(var_40_13.content)

				arg_37_1.text_.text = var_40_14

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_15 = 13
				local var_40_16 = utf8.len(var_40_14)
				local var_40_17 = var_40_15 <= 0 and var_40_11 or var_40_11 * (var_40_16 / var_40_15)

				if var_40_17 > 0 and var_40_11 < var_40_17 then
					arg_37_1.talkMaxDuration = var_40_17

					if var_40_17 + var_40_10 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_17 + var_40_10
					end
				end

				arg_37_1.text_.text = var_40_14
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011009", "story_v_out_317011.awb") ~= 0 then
					local var_40_18 = manager.audio:GetVoiceLength("story_v_out_317011", "317011009", "story_v_out_317011.awb") / 1000

					if var_40_18 + var_40_10 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_10
					end

					if var_40_13.prefab_name ~= "" and arg_37_1.actors_[var_40_13.prefab_name] ~= nil then
						local var_40_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_13.prefab_name].transform, "story_v_out_317011", "317011009", "story_v_out_317011.awb")

						arg_37_1:RecordAudio("317011009", var_40_19)
						arg_37_1:RecordAudio("317011009", var_40_19)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_317011", "317011009", "story_v_out_317011.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_317011", "317011009", "story_v_out_317011.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_20 = math.max(var_40_11, arg_37_1.talkMaxDuration)

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_20 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_10) / var_40_20

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_10 + var_40_20 and arg_37_1.time_ < var_40_10 + var_40_20 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
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
	Play317011010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 317011010
		arg_41_1.duration_ = 7.97

		local var_41_0 = {
			zh = 4.966,
			ja = 7.966
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
				arg_41_0:Play317011011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10003ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10003ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(0, 100, 0)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10003ui_story, var_44_4, var_44_3)

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

			local var_44_9 = arg_41_1.actors_["10003ui_story"]
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect10003ui_story == nil then
				arg_41_1.var_.characterEffect10003ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 and not isNil(var_44_9) then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11

				if arg_41_1.var_.characterEffect10003ui_story and not isNil(var_44_9) then
					local var_44_13 = Mathf.Lerp(0, 0.5, var_44_12)

					arg_41_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10003ui_story.fillRatio = var_44_13
				end
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect10003ui_story then
				local var_44_14 = 0.5

				arg_41_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10003ui_story.fillRatio = var_44_14
			end

			local var_44_15 = arg_41_1.actors_["10053ui_story"].transform
			local var_44_16 = 0

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				arg_41_1.var_.moveOldPos10053ui_story = var_44_15.localPosition
			end

			local var_44_17 = 0.001

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_17 then
				local var_44_18 = (arg_41_1.time_ - var_44_16) / var_44_17
				local var_44_19 = Vector3.New(0, -1.12, -5.99)

				var_44_15.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10053ui_story, var_44_19, var_44_18)

				local var_44_20 = manager.ui.mainCamera.transform.position - var_44_15.position

				var_44_15.forward = Vector3.New(var_44_20.x, var_44_20.y, var_44_20.z)

				local var_44_21 = var_44_15.localEulerAngles

				var_44_21.z = 0
				var_44_21.x = 0
				var_44_15.localEulerAngles = var_44_21
			end

			if arg_41_1.time_ >= var_44_16 + var_44_17 and arg_41_1.time_ < var_44_16 + var_44_17 + arg_44_0 then
				var_44_15.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_44_22 = manager.ui.mainCamera.transform.position - var_44_15.position

				var_44_15.forward = Vector3.New(var_44_22.x, var_44_22.y, var_44_22.z)

				local var_44_23 = var_44_15.localEulerAngles

				var_44_23.z = 0
				var_44_23.x = 0
				var_44_15.localEulerAngles = var_44_23
			end

			local var_44_24 = arg_41_1.actors_["10053ui_story"]
			local var_44_25 = 0

			if var_44_25 < arg_41_1.time_ and arg_41_1.time_ <= var_44_25 + arg_44_0 and not isNil(var_44_24) and arg_41_1.var_.characterEffect10053ui_story == nil then
				arg_41_1.var_.characterEffect10053ui_story = var_44_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_26 = 0.200000002980232

			if var_44_25 <= arg_41_1.time_ and arg_41_1.time_ < var_44_25 + var_44_26 and not isNil(var_44_24) then
				local var_44_27 = (arg_41_1.time_ - var_44_25) / var_44_26

				if arg_41_1.var_.characterEffect10053ui_story and not isNil(var_44_24) then
					arg_41_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_25 + var_44_26 and arg_41_1.time_ < var_44_25 + var_44_26 + arg_44_0 and not isNil(var_44_24) and arg_41_1.var_.characterEffect10053ui_story then
				arg_41_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_44_28 = 0

			if var_44_28 < arg_41_1.time_ and arg_41_1.time_ <= var_44_28 + arg_44_0 then
				arg_41_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_29 = 0

			if var_44_29 < arg_41_1.time_ and arg_41_1.time_ <= var_44_29 + arg_44_0 then
				arg_41_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_44_30 = 0
			local var_44_31 = 0.4

			if var_44_30 < arg_41_1.time_ and arg_41_1.time_ <= var_44_30 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_32 = arg_41_1:FormatText(StoryNameCfg[477].name)

				arg_41_1.leftNameTxt_.text = var_44_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_33 = arg_41_1:GetWordFromCfg(317011010)
				local var_44_34 = arg_41_1:FormatText(var_44_33.content)

				arg_41_1.text_.text = var_44_34

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_35 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011010", "story_v_out_317011.awb") ~= 0 then
					local var_44_38 = manager.audio:GetVoiceLength("story_v_out_317011", "317011010", "story_v_out_317011.awb") / 1000

					if var_44_38 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_38 + var_44_30
					end

					if var_44_33.prefab_name ~= "" and arg_41_1.actors_[var_44_33.prefab_name] ~= nil then
						local var_44_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_33.prefab_name].transform, "story_v_out_317011", "317011010", "story_v_out_317011.awb")

						arg_41_1:RecordAudio("317011010", var_44_39)
						arg_41_1:RecordAudio("317011010", var_44_39)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_317011", "317011010", "story_v_out_317011.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_317011", "317011010", "story_v_out_317011.awb")
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
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play317011011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 317011011
		arg_45_1.duration_ = 6.97

		local var_45_0 = {
			zh = 6.966,
			ja = 5.333
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
				arg_45_0:Play317011012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10053ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10053ui_story == nil then
				arg_45_1.var_.characterEffect10053ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect10053ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10053ui_story then
				arg_45_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_48_4 = 0

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			local var_48_6 = 0
			local var_48_7 = 0.775

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[477].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_9 = arg_45_1:GetWordFromCfg(317011011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011011", "story_v_out_317011.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_317011", "317011011", "story_v_out_317011.awb") / 1000

					if var_48_14 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_6
					end

					if var_48_9.prefab_name ~= "" and arg_45_1.actors_[var_48_9.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_9.prefab_name].transform, "story_v_out_317011", "317011011", "story_v_out_317011.awb")

						arg_45_1:RecordAudio("317011011", var_48_15)
						arg_45_1:RecordAudio("317011011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_317011", "317011011", "story_v_out_317011.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_317011", "317011011", "story_v_out_317011.awb")
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
	Play317011012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 317011012
		arg_49_1.duration_ = 13.8

		local var_49_0 = {
			zh = 7.566,
			ja = 13.8
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
				arg_49_0:Play317011013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10003ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos10003ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(0, -1.05, -5.9)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10003ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -1.05, -5.9)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["10003ui_story"]
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect10003ui_story == nil then
				arg_49_1.var_.characterEffect10003ui_story = var_52_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 and not isNil(var_52_9) then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11

				if arg_49_1.var_.characterEffect10003ui_story and not isNil(var_52_9) then
					arg_49_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect10003ui_story then
				arg_49_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			local var_52_13 = 0

			if var_52_13 < arg_49_1.time_ and arg_49_1.time_ <= var_52_13 + arg_52_0 then
				arg_49_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action2_2")
			end

			local var_52_14 = 0

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_15 = arg_49_1.actors_["10053ui_story"].transform
			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.var_.moveOldPos10053ui_story = var_52_15.localPosition
			end

			local var_52_17 = 0.001

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_17 then
				local var_52_18 = (arg_49_1.time_ - var_52_16) / var_52_17
				local var_52_19 = Vector3.New(0, 100, 0)

				var_52_15.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10053ui_story, var_52_19, var_52_18)

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

			local var_52_24 = arg_49_1.actors_["10053ui_story"]
			local var_52_25 = 0

			if var_52_25 < arg_49_1.time_ and arg_49_1.time_ <= var_52_25 + arg_52_0 and not isNil(var_52_24) and arg_49_1.var_.characterEffect10053ui_story == nil then
				arg_49_1.var_.characterEffect10053ui_story = var_52_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_26 = 0.200000002980232

			if var_52_25 <= arg_49_1.time_ and arg_49_1.time_ < var_52_25 + var_52_26 and not isNil(var_52_24) then
				local var_52_27 = (arg_49_1.time_ - var_52_25) / var_52_26

				if arg_49_1.var_.characterEffect10053ui_story and not isNil(var_52_24) then
					local var_52_28 = Mathf.Lerp(0, 0.5, var_52_27)

					arg_49_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_49_1.var_.characterEffect10053ui_story.fillRatio = var_52_28
				end
			end

			if arg_49_1.time_ >= var_52_25 + var_52_26 and arg_49_1.time_ < var_52_25 + var_52_26 + arg_52_0 and not isNil(var_52_24) and arg_49_1.var_.characterEffect10053ui_story then
				local var_52_29 = 0.5

				arg_49_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_49_1.var_.characterEffect10053ui_story.fillRatio = var_52_29
			end

			local var_52_30 = 0
			local var_52_31 = 0.825

			if var_52_30 < arg_49_1.time_ and arg_49_1.time_ <= var_52_30 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_32 = arg_49_1:FormatText(StoryNameCfg[81].name)

				arg_49_1.leftNameTxt_.text = var_52_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_33 = arg_49_1:GetWordFromCfg(317011012)
				local var_52_34 = arg_49_1:FormatText(var_52_33.content)

				arg_49_1.text_.text = var_52_34

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_35 = 33
				local var_52_36 = utf8.len(var_52_34)
				local var_52_37 = var_52_35 <= 0 and var_52_31 or var_52_31 * (var_52_36 / var_52_35)

				if var_52_37 > 0 and var_52_31 < var_52_37 then
					arg_49_1.talkMaxDuration = var_52_37

					if var_52_37 + var_52_30 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_37 + var_52_30
					end
				end

				arg_49_1.text_.text = var_52_34
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011012", "story_v_out_317011.awb") ~= 0 then
					local var_52_38 = manager.audio:GetVoiceLength("story_v_out_317011", "317011012", "story_v_out_317011.awb") / 1000

					if var_52_38 + var_52_30 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_38 + var_52_30
					end

					if var_52_33.prefab_name ~= "" and arg_49_1.actors_[var_52_33.prefab_name] ~= nil then
						local var_52_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_33.prefab_name].transform, "story_v_out_317011", "317011012", "story_v_out_317011.awb")

						arg_49_1:RecordAudio("317011012", var_52_39)
						arg_49_1:RecordAudio("317011012", var_52_39)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_317011", "317011012", "story_v_out_317011.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_317011", "317011012", "story_v_out_317011.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_40 = math.max(var_52_31, arg_49_1.talkMaxDuration)

			if var_52_30 <= arg_49_1.time_ and arg_49_1.time_ < var_52_30 + var_52_40 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_30) / var_52_40

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_30 + var_52_40 and arg_49_1.time_ < var_52_30 + var_52_40 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play317011013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 317011013
		arg_53_1.duration_ = 5.93

		local var_53_0 = {
			zh = 5.933,
			ja = 4.566
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
				arg_53_0:Play317011014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10003ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos10003ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, 100, 0)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10003ui_story, var_56_4, var_56_3)

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

			local var_56_9 = arg_53_1.actors_["10003ui_story"]
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect10003ui_story == nil then
				arg_53_1.var_.characterEffect10003ui_story = var_56_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_11 = 0.200000002980232

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 and not isNil(var_56_9) then
				local var_56_12 = (arg_53_1.time_ - var_56_10) / var_56_11

				if arg_53_1.var_.characterEffect10003ui_story and not isNil(var_56_9) then
					local var_56_13 = Mathf.Lerp(0, 0.5, var_56_12)

					arg_53_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10003ui_story.fillRatio = var_56_13
				end
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect10003ui_story then
				local var_56_14 = 0.5

				arg_53_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10003ui_story.fillRatio = var_56_14
			end

			local var_56_15 = arg_53_1.actors_["10053ui_story"].transform
			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.var_.moveOldPos10053ui_story = var_56_15.localPosition
			end

			local var_56_17 = 0.001

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_17 then
				local var_56_18 = (arg_53_1.time_ - var_56_16) / var_56_17
				local var_56_19 = Vector3.New(0, -1.12, -5.99)

				var_56_15.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10053ui_story, var_56_19, var_56_18)

				local var_56_20 = manager.ui.mainCamera.transform.position - var_56_15.position

				var_56_15.forward = Vector3.New(var_56_20.x, var_56_20.y, var_56_20.z)

				local var_56_21 = var_56_15.localEulerAngles

				var_56_21.z = 0
				var_56_21.x = 0
				var_56_15.localEulerAngles = var_56_21
			end

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 then
				var_56_15.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_56_22 = manager.ui.mainCamera.transform.position - var_56_15.position

				var_56_15.forward = Vector3.New(var_56_22.x, var_56_22.y, var_56_22.z)

				local var_56_23 = var_56_15.localEulerAngles

				var_56_23.z = 0
				var_56_23.x = 0
				var_56_15.localEulerAngles = var_56_23
			end

			local var_56_24 = arg_53_1.actors_["10053ui_story"]
			local var_56_25 = 0

			if var_56_25 < arg_53_1.time_ and arg_53_1.time_ <= var_56_25 + arg_56_0 and not isNil(var_56_24) and arg_53_1.var_.characterEffect10053ui_story == nil then
				arg_53_1.var_.characterEffect10053ui_story = var_56_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_26 = 0.200000002980232

			if var_56_25 <= arg_53_1.time_ and arg_53_1.time_ < var_56_25 + var_56_26 and not isNil(var_56_24) then
				local var_56_27 = (arg_53_1.time_ - var_56_25) / var_56_26

				if arg_53_1.var_.characterEffect10053ui_story and not isNil(var_56_24) then
					arg_53_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_25 + var_56_26 and arg_53_1.time_ < var_56_25 + var_56_26 + arg_56_0 and not isNil(var_56_24) and arg_53_1.var_.characterEffect10053ui_story then
				arg_53_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_56_28 = 0

			if var_56_28 < arg_53_1.time_ and arg_53_1.time_ <= var_56_28 + arg_56_0 then
				arg_53_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action4411")
			end

			local var_56_29 = 0

			if var_56_29 < arg_53_1.time_ and arg_53_1.time_ <= var_56_29 + arg_56_0 then
				arg_53_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_30 = 0
			local var_56_31 = 0.55

			if var_56_30 < arg_53_1.time_ and arg_53_1.time_ <= var_56_30 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_32 = arg_53_1:FormatText(StoryNameCfg[477].name)

				arg_53_1.leftNameTxt_.text = var_56_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_33 = arg_53_1:GetWordFromCfg(317011013)
				local var_56_34 = arg_53_1:FormatText(var_56_33.content)

				arg_53_1.text_.text = var_56_34

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_35 = 22
				local var_56_36 = utf8.len(var_56_34)
				local var_56_37 = var_56_35 <= 0 and var_56_31 or var_56_31 * (var_56_36 / var_56_35)

				if var_56_37 > 0 and var_56_31 < var_56_37 then
					arg_53_1.talkMaxDuration = var_56_37

					if var_56_37 + var_56_30 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_37 + var_56_30
					end
				end

				arg_53_1.text_.text = var_56_34
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011013", "story_v_out_317011.awb") ~= 0 then
					local var_56_38 = manager.audio:GetVoiceLength("story_v_out_317011", "317011013", "story_v_out_317011.awb") / 1000

					if var_56_38 + var_56_30 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_38 + var_56_30
					end

					if var_56_33.prefab_name ~= "" and arg_53_1.actors_[var_56_33.prefab_name] ~= nil then
						local var_56_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_33.prefab_name].transform, "story_v_out_317011", "317011013", "story_v_out_317011.awb")

						arg_53_1:RecordAudio("317011013", var_56_39)
						arg_53_1:RecordAudio("317011013", var_56_39)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_317011", "317011013", "story_v_out_317011.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_317011", "317011013", "story_v_out_317011.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_40 = math.max(var_56_31, arg_53_1.talkMaxDuration)

			if var_56_30 <= arg_53_1.time_ and arg_53_1.time_ < var_56_30 + var_56_40 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_30) / var_56_40

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_30 + var_56_40 and arg_53_1.time_ < var_56_30 + var_56_40 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play317011014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 317011014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play317011015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10053ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect10053ui_story == nil then
				arg_57_1.var_.characterEffect10053ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect10053ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_57_1.var_.characterEffect10053ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect10053ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_57_1.var_.characterEffect10053ui_story.fillRatio = var_60_5
			end

			local var_60_6 = 0
			local var_60_7 = 1.1

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(317011014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 44
				local var_60_11 = utf8.len(var_60_9)
				local var_60_12 = var_60_10 <= 0 and var_60_7 or var_60_7 * (var_60_11 / var_60_10)

				if var_60_12 > 0 and var_60_7 < var_60_12 then
					arg_57_1.talkMaxDuration = var_60_12

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_13 and arg_57_1.time_ < var_60_6 + var_60_13 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play317011015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 317011015
		arg_61_1.duration_ = 11.8

		local var_61_0 = {
			zh = 11.8,
			ja = 11.233
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
				arg_61_0:Play317011016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10003ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos10003ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0, -1.05, -5.9)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10003ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, -1.05, -5.9)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["10003ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect10003ui_story == nil then
				arg_61_1.var_.characterEffect10003ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect10003ui_story and not isNil(var_64_9) then
					arg_61_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect10003ui_story then
				arg_61_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			local var_64_13 = 0

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action5_1")
			end

			local var_64_14 = 0

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_15 = arg_61_1.actors_["10053ui_story"].transform
			local var_64_16 = 0

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.var_.moveOldPos10053ui_story = var_64_15.localPosition
			end

			local var_64_17 = 0.001

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_17 then
				local var_64_18 = (arg_61_1.time_ - var_64_16) / var_64_17
				local var_64_19 = Vector3.New(0, 100, 0)

				var_64_15.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10053ui_story, var_64_19, var_64_18)

				local var_64_20 = manager.ui.mainCamera.transform.position - var_64_15.position

				var_64_15.forward = Vector3.New(var_64_20.x, var_64_20.y, var_64_20.z)

				local var_64_21 = var_64_15.localEulerAngles

				var_64_21.z = 0
				var_64_21.x = 0
				var_64_15.localEulerAngles = var_64_21
			end

			if arg_61_1.time_ >= var_64_16 + var_64_17 and arg_61_1.time_ < var_64_16 + var_64_17 + arg_64_0 then
				var_64_15.localPosition = Vector3.New(0, 100, 0)

				local var_64_22 = manager.ui.mainCamera.transform.position - var_64_15.position

				var_64_15.forward = Vector3.New(var_64_22.x, var_64_22.y, var_64_22.z)

				local var_64_23 = var_64_15.localEulerAngles

				var_64_23.z = 0
				var_64_23.x = 0
				var_64_15.localEulerAngles = var_64_23
			end

			local var_64_24 = arg_61_1.actors_["10053ui_story"]
			local var_64_25 = 0

			if var_64_25 < arg_61_1.time_ and arg_61_1.time_ <= var_64_25 + arg_64_0 and not isNil(var_64_24) and arg_61_1.var_.characterEffect10053ui_story == nil then
				arg_61_1.var_.characterEffect10053ui_story = var_64_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_26 = 0.200000002980232

			if var_64_25 <= arg_61_1.time_ and arg_61_1.time_ < var_64_25 + var_64_26 and not isNil(var_64_24) then
				local var_64_27 = (arg_61_1.time_ - var_64_25) / var_64_26

				if arg_61_1.var_.characterEffect10053ui_story and not isNil(var_64_24) then
					local var_64_28 = Mathf.Lerp(0, 0.5, var_64_27)

					arg_61_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10053ui_story.fillRatio = var_64_28
				end
			end

			if arg_61_1.time_ >= var_64_25 + var_64_26 and arg_61_1.time_ < var_64_25 + var_64_26 + arg_64_0 and not isNil(var_64_24) and arg_61_1.var_.characterEffect10053ui_story then
				local var_64_29 = 0.5

				arg_61_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10053ui_story.fillRatio = var_64_29
			end

			local var_64_30 = 0
			local var_64_31 = 1.2

			if var_64_30 < arg_61_1.time_ and arg_61_1.time_ <= var_64_30 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_32 = arg_61_1:FormatText(StoryNameCfg[81].name)

				arg_61_1.leftNameTxt_.text = var_64_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_33 = arg_61_1:GetWordFromCfg(317011015)
				local var_64_34 = arg_61_1:FormatText(var_64_33.content)

				arg_61_1.text_.text = var_64_34

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_35 = 48
				local var_64_36 = utf8.len(var_64_34)
				local var_64_37 = var_64_35 <= 0 and var_64_31 or var_64_31 * (var_64_36 / var_64_35)

				if var_64_37 > 0 and var_64_31 < var_64_37 then
					arg_61_1.talkMaxDuration = var_64_37

					if var_64_37 + var_64_30 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_37 + var_64_30
					end
				end

				arg_61_1.text_.text = var_64_34
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011015", "story_v_out_317011.awb") ~= 0 then
					local var_64_38 = manager.audio:GetVoiceLength("story_v_out_317011", "317011015", "story_v_out_317011.awb") / 1000

					if var_64_38 + var_64_30 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_38 + var_64_30
					end

					if var_64_33.prefab_name ~= "" and arg_61_1.actors_[var_64_33.prefab_name] ~= nil then
						local var_64_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_33.prefab_name].transform, "story_v_out_317011", "317011015", "story_v_out_317011.awb")

						arg_61_1:RecordAudio("317011015", var_64_39)
						arg_61_1:RecordAudio("317011015", var_64_39)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_317011", "317011015", "story_v_out_317011.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_317011", "317011015", "story_v_out_317011.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_40 = math.max(var_64_31, arg_61_1.talkMaxDuration)

			if var_64_30 <= arg_61_1.time_ and arg_61_1.time_ < var_64_30 + var_64_40 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_30) / var_64_40

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_30 + var_64_40 and arg_61_1.time_ < var_64_30 + var_64_40 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play317011016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 317011016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play317011017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10003ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10003ui_story == nil then
				arg_65_1.var_.characterEffect10003ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect10003ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10003ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10003ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10003ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 0.85

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:GetWordFromCfg(317011016)
				local var_68_9 = arg_65_1:FormatText(var_68_8.content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 34
				local var_68_11 = utf8.len(var_68_9)
				local var_68_12 = var_68_10 <= 0 and var_68_7 or var_68_7 * (var_68_11 / var_68_10)

				if var_68_12 > 0 and var_68_7 < var_68_12 then
					arg_65_1.talkMaxDuration = var_68_12

					if var_68_12 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_13 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_13 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_13

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_13 and arg_65_1.time_ < var_68_6 + var_68_13 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play317011017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 317011017
		arg_69_1.duration_ = 9.53

		local var_69_0 = {
			zh = 9.533,
			ja = 7.733
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
				arg_69_0:Play317011018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10003ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10003ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(0, 100, 0)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10003ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, 100, 0)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = arg_69_1.actors_["10003ui_story"]
			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect10003ui_story == nil then
				arg_69_1.var_.characterEffect10003ui_story = var_72_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_11 = 0.200000002980232

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_11 and not isNil(var_72_9) then
				local var_72_12 = (arg_69_1.time_ - var_72_10) / var_72_11

				if arg_69_1.var_.characterEffect10003ui_story and not isNil(var_72_9) then
					local var_72_13 = Mathf.Lerp(0, 0.5, var_72_12)

					arg_69_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10003ui_story.fillRatio = var_72_13
				end
			end

			if arg_69_1.time_ >= var_72_10 + var_72_11 and arg_69_1.time_ < var_72_10 + var_72_11 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect10003ui_story then
				local var_72_14 = 0.5

				arg_69_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10003ui_story.fillRatio = var_72_14
			end

			local var_72_15 = arg_69_1.actors_["10053ui_story"].transform
			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.var_.moveOldPos10053ui_story = var_72_15.localPosition
			end

			local var_72_17 = 0.001

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_17 then
				local var_72_18 = (arg_69_1.time_ - var_72_16) / var_72_17
				local var_72_19 = Vector3.New(0, -1.12, -5.99)

				var_72_15.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10053ui_story, var_72_19, var_72_18)

				local var_72_20 = manager.ui.mainCamera.transform.position - var_72_15.position

				var_72_15.forward = Vector3.New(var_72_20.x, var_72_20.y, var_72_20.z)

				local var_72_21 = var_72_15.localEulerAngles

				var_72_21.z = 0
				var_72_21.x = 0
				var_72_15.localEulerAngles = var_72_21
			end

			if arg_69_1.time_ >= var_72_16 + var_72_17 and arg_69_1.time_ < var_72_16 + var_72_17 + arg_72_0 then
				var_72_15.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_72_22 = manager.ui.mainCamera.transform.position - var_72_15.position

				var_72_15.forward = Vector3.New(var_72_22.x, var_72_22.y, var_72_22.z)

				local var_72_23 = var_72_15.localEulerAngles

				var_72_23.z = 0
				var_72_23.x = 0
				var_72_15.localEulerAngles = var_72_23
			end

			local var_72_24 = arg_69_1.actors_["10053ui_story"]
			local var_72_25 = 0

			if var_72_25 < arg_69_1.time_ and arg_69_1.time_ <= var_72_25 + arg_72_0 and not isNil(var_72_24) and arg_69_1.var_.characterEffect10053ui_story == nil then
				arg_69_1.var_.characterEffect10053ui_story = var_72_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_26 = 0.200000002980232

			if var_72_25 <= arg_69_1.time_ and arg_69_1.time_ < var_72_25 + var_72_26 and not isNil(var_72_24) then
				local var_72_27 = (arg_69_1.time_ - var_72_25) / var_72_26

				if arg_69_1.var_.characterEffect10053ui_story and not isNil(var_72_24) then
					arg_69_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_25 + var_72_26 and arg_69_1.time_ < var_72_25 + var_72_26 + arg_72_0 and not isNil(var_72_24) and arg_69_1.var_.characterEffect10053ui_story then
				arg_69_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_72_28 = 0

			if var_72_28 < arg_69_1.time_ and arg_69_1.time_ <= var_72_28 + arg_72_0 then
				arg_69_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_72_29 = 0

			if var_72_29 < arg_69_1.time_ and arg_69_1.time_ <= var_72_29 + arg_72_0 then
				arg_69_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action11_2")
			end

			local var_72_30 = 0
			local var_72_31 = 0.575

			if var_72_30 < arg_69_1.time_ and arg_69_1.time_ <= var_72_30 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_32 = arg_69_1:FormatText(StoryNameCfg[477].name)

				arg_69_1.leftNameTxt_.text = var_72_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_33 = arg_69_1:GetWordFromCfg(317011017)
				local var_72_34 = arg_69_1:FormatText(var_72_33.content)

				arg_69_1.text_.text = var_72_34

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_35 = 23
				local var_72_36 = utf8.len(var_72_34)
				local var_72_37 = var_72_35 <= 0 and var_72_31 or var_72_31 * (var_72_36 / var_72_35)

				if var_72_37 > 0 and var_72_31 < var_72_37 then
					arg_69_1.talkMaxDuration = var_72_37

					if var_72_37 + var_72_30 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_37 + var_72_30
					end
				end

				arg_69_1.text_.text = var_72_34
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011017", "story_v_out_317011.awb") ~= 0 then
					local var_72_38 = manager.audio:GetVoiceLength("story_v_out_317011", "317011017", "story_v_out_317011.awb") / 1000

					if var_72_38 + var_72_30 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_38 + var_72_30
					end

					if var_72_33.prefab_name ~= "" and arg_69_1.actors_[var_72_33.prefab_name] ~= nil then
						local var_72_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_33.prefab_name].transform, "story_v_out_317011", "317011017", "story_v_out_317011.awb")

						arg_69_1:RecordAudio("317011017", var_72_39)
						arg_69_1:RecordAudio("317011017", var_72_39)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_317011", "317011017", "story_v_out_317011.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_317011", "317011017", "story_v_out_317011.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_40 = math.max(var_72_31, arg_69_1.talkMaxDuration)

			if var_72_30 <= arg_69_1.time_ and arg_69_1.time_ < var_72_30 + var_72_40 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_30) / var_72_40

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_30 + var_72_40 and arg_69_1.time_ < var_72_30 + var_72_40 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play317011018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 317011018
		arg_73_1.duration_ = 3.13

		local var_73_0 = {
			zh = 1.999999999999,
			ja = 3.133
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
				arg_73_0:Play317011019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10003ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10003ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0, -1.05, -5.9)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10003ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, -1.05, -5.9)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["10003ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect10003ui_story == nil then
				arg_73_1.var_.characterEffect10003ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 and not isNil(var_76_9) then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect10003ui_story and not isNil(var_76_9) then
					arg_73_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect10003ui_story then
				arg_73_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			local var_76_13 = 0

			if var_76_13 < arg_73_1.time_ and arg_73_1.time_ <= var_76_13 + arg_76_0 then
				arg_73_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action5_2")
			end

			local var_76_14 = 0

			if var_76_14 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 then
				arg_73_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_15 = arg_73_1.actors_["10053ui_story"].transform
			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.var_.moveOldPos10053ui_story = var_76_15.localPosition
			end

			local var_76_17 = 0.001

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_17 then
				local var_76_18 = (arg_73_1.time_ - var_76_16) / var_76_17
				local var_76_19 = Vector3.New(0, 100, 0)

				var_76_15.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10053ui_story, var_76_19, var_76_18)

				local var_76_20 = manager.ui.mainCamera.transform.position - var_76_15.position

				var_76_15.forward = Vector3.New(var_76_20.x, var_76_20.y, var_76_20.z)

				local var_76_21 = var_76_15.localEulerAngles

				var_76_21.z = 0
				var_76_21.x = 0
				var_76_15.localEulerAngles = var_76_21
			end

			if arg_73_1.time_ >= var_76_16 + var_76_17 and arg_73_1.time_ < var_76_16 + var_76_17 + arg_76_0 then
				var_76_15.localPosition = Vector3.New(0, 100, 0)

				local var_76_22 = manager.ui.mainCamera.transform.position - var_76_15.position

				var_76_15.forward = Vector3.New(var_76_22.x, var_76_22.y, var_76_22.z)

				local var_76_23 = var_76_15.localEulerAngles

				var_76_23.z = 0
				var_76_23.x = 0
				var_76_15.localEulerAngles = var_76_23
			end

			local var_76_24 = arg_73_1.actors_["10053ui_story"]
			local var_76_25 = 0

			if var_76_25 < arg_73_1.time_ and arg_73_1.time_ <= var_76_25 + arg_76_0 and not isNil(var_76_24) and arg_73_1.var_.characterEffect10053ui_story == nil then
				arg_73_1.var_.characterEffect10053ui_story = var_76_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_26 = 0.200000002980232

			if var_76_25 <= arg_73_1.time_ and arg_73_1.time_ < var_76_25 + var_76_26 and not isNil(var_76_24) then
				local var_76_27 = (arg_73_1.time_ - var_76_25) / var_76_26

				if arg_73_1.var_.characterEffect10053ui_story and not isNil(var_76_24) then
					local var_76_28 = Mathf.Lerp(0, 0.5, var_76_27)

					arg_73_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10053ui_story.fillRatio = var_76_28
				end
			end

			if arg_73_1.time_ >= var_76_25 + var_76_26 and arg_73_1.time_ < var_76_25 + var_76_26 + arg_76_0 and not isNil(var_76_24) and arg_73_1.var_.characterEffect10053ui_story then
				local var_76_29 = 0.5

				arg_73_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10053ui_story.fillRatio = var_76_29
			end

			local var_76_30 = 0
			local var_76_31 = 0.2

			if var_76_30 < arg_73_1.time_ and arg_73_1.time_ <= var_76_30 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_32 = arg_73_1:FormatText(StoryNameCfg[81].name)

				arg_73_1.leftNameTxt_.text = var_76_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_33 = arg_73_1:GetWordFromCfg(317011018)
				local var_76_34 = arg_73_1:FormatText(var_76_33.content)

				arg_73_1.text_.text = var_76_34

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_35 = 8
				local var_76_36 = utf8.len(var_76_34)
				local var_76_37 = var_76_35 <= 0 and var_76_31 or var_76_31 * (var_76_36 / var_76_35)

				if var_76_37 > 0 and var_76_31 < var_76_37 then
					arg_73_1.talkMaxDuration = var_76_37

					if var_76_37 + var_76_30 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_37 + var_76_30
					end
				end

				arg_73_1.text_.text = var_76_34
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011018", "story_v_out_317011.awb") ~= 0 then
					local var_76_38 = manager.audio:GetVoiceLength("story_v_out_317011", "317011018", "story_v_out_317011.awb") / 1000

					if var_76_38 + var_76_30 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_38 + var_76_30
					end

					if var_76_33.prefab_name ~= "" and arg_73_1.actors_[var_76_33.prefab_name] ~= nil then
						local var_76_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_33.prefab_name].transform, "story_v_out_317011", "317011018", "story_v_out_317011.awb")

						arg_73_1:RecordAudio("317011018", var_76_39)
						arg_73_1:RecordAudio("317011018", var_76_39)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_317011", "317011018", "story_v_out_317011.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_317011", "317011018", "story_v_out_317011.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_40 = math.max(var_76_31, arg_73_1.talkMaxDuration)

			if var_76_30 <= arg_73_1.time_ and arg_73_1.time_ < var_76_30 + var_76_40 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_30) / var_76_40

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_30 + var_76_40 and arg_73_1.time_ < var_76_30 + var_76_40 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play317011019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 317011019
		arg_77_1.duration_ = 4.53

		local var_77_0 = {
			zh = 4.533,
			ja = 2.866
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
				arg_77_0:Play317011020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10003ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos10003ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0, 100, 0)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10003ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, 100, 0)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["10003ui_story"]
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect10003ui_story == nil then
				arg_77_1.var_.characterEffect10003ui_story = var_80_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_11 = 0.200000002980232

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 and not isNil(var_80_9) then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11

				if arg_77_1.var_.characterEffect10003ui_story and not isNil(var_80_9) then
					local var_80_13 = Mathf.Lerp(0, 0.5, var_80_12)

					arg_77_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10003ui_story.fillRatio = var_80_13
				end
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect10003ui_story then
				local var_80_14 = 0.5

				arg_77_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10003ui_story.fillRatio = var_80_14
			end

			local var_80_15 = arg_77_1.actors_["10053ui_story"].transform
			local var_80_16 = 0

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 then
				arg_77_1.var_.moveOldPos10053ui_story = var_80_15.localPosition
			end

			local var_80_17 = 0.001

			if var_80_16 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_17 then
				local var_80_18 = (arg_77_1.time_ - var_80_16) / var_80_17
				local var_80_19 = Vector3.New(0, -1.12, -5.99)

				var_80_15.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10053ui_story, var_80_19, var_80_18)

				local var_80_20 = manager.ui.mainCamera.transform.position - var_80_15.position

				var_80_15.forward = Vector3.New(var_80_20.x, var_80_20.y, var_80_20.z)

				local var_80_21 = var_80_15.localEulerAngles

				var_80_21.z = 0
				var_80_21.x = 0
				var_80_15.localEulerAngles = var_80_21
			end

			if arg_77_1.time_ >= var_80_16 + var_80_17 and arg_77_1.time_ < var_80_16 + var_80_17 + arg_80_0 then
				var_80_15.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_80_22 = manager.ui.mainCamera.transform.position - var_80_15.position

				var_80_15.forward = Vector3.New(var_80_22.x, var_80_22.y, var_80_22.z)

				local var_80_23 = var_80_15.localEulerAngles

				var_80_23.z = 0
				var_80_23.x = 0
				var_80_15.localEulerAngles = var_80_23
			end

			local var_80_24 = arg_77_1.actors_["10053ui_story"]
			local var_80_25 = 0

			if var_80_25 < arg_77_1.time_ and arg_77_1.time_ <= var_80_25 + arg_80_0 and not isNil(var_80_24) and arg_77_1.var_.characterEffect10053ui_story == nil then
				arg_77_1.var_.characterEffect10053ui_story = var_80_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_26 = 0.200000002980232

			if var_80_25 <= arg_77_1.time_ and arg_77_1.time_ < var_80_25 + var_80_26 and not isNil(var_80_24) then
				local var_80_27 = (arg_77_1.time_ - var_80_25) / var_80_26

				if arg_77_1.var_.characterEffect10053ui_story and not isNil(var_80_24) then
					arg_77_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_25 + var_80_26 and arg_77_1.time_ < var_80_25 + var_80_26 + arg_80_0 and not isNil(var_80_24) and arg_77_1.var_.characterEffect10053ui_story then
				arg_77_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_80_28 = 0

			if var_80_28 < arg_77_1.time_ and arg_77_1.time_ <= var_80_28 + arg_80_0 then
				arg_77_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action11_2")
			end

			local var_80_29 = 0

			if var_80_29 < arg_77_1.time_ and arg_77_1.time_ <= var_80_29 + arg_80_0 then
				arg_77_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_80_30 = 0
			local var_80_31 = 0.325

			if var_80_30 < arg_77_1.time_ and arg_77_1.time_ <= var_80_30 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_32 = arg_77_1:FormatText(StoryNameCfg[477].name)

				arg_77_1.leftNameTxt_.text = var_80_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_33 = arg_77_1:GetWordFromCfg(317011019)
				local var_80_34 = arg_77_1:FormatText(var_80_33.content)

				arg_77_1.text_.text = var_80_34

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_35 = 13
				local var_80_36 = utf8.len(var_80_34)
				local var_80_37 = var_80_35 <= 0 and var_80_31 or var_80_31 * (var_80_36 / var_80_35)

				if var_80_37 > 0 and var_80_31 < var_80_37 then
					arg_77_1.talkMaxDuration = var_80_37

					if var_80_37 + var_80_30 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_37 + var_80_30
					end
				end

				arg_77_1.text_.text = var_80_34
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011019", "story_v_out_317011.awb") ~= 0 then
					local var_80_38 = manager.audio:GetVoiceLength("story_v_out_317011", "317011019", "story_v_out_317011.awb") / 1000

					if var_80_38 + var_80_30 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_38 + var_80_30
					end

					if var_80_33.prefab_name ~= "" and arg_77_1.actors_[var_80_33.prefab_name] ~= nil then
						local var_80_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_33.prefab_name].transform, "story_v_out_317011", "317011019", "story_v_out_317011.awb")

						arg_77_1:RecordAudio("317011019", var_80_39)
						arg_77_1:RecordAudio("317011019", var_80_39)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_317011", "317011019", "story_v_out_317011.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_317011", "317011019", "story_v_out_317011.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_40 = math.max(var_80_31, arg_77_1.talkMaxDuration)

			if var_80_30 <= arg_77_1.time_ and arg_77_1.time_ < var_80_30 + var_80_40 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_30) / var_80_40

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_30 + var_80_40 and arg_77_1.time_ < var_80_30 + var_80_40 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play317011020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 317011020
		arg_81_1.duration_ = 6.47

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play317011021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10003ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos10003ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0, 100, 0)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10003ui_story, var_84_4, var_84_3)

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

			local var_84_9 = arg_81_1.actors_["10003ui_story"]
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect10003ui_story == nil then
				arg_81_1.var_.characterEffect10003ui_story = var_84_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.034000001847744

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 and not isNil(var_84_9) then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11

				if arg_81_1.var_.characterEffect10003ui_story and not isNil(var_84_9) then
					local var_84_13 = Mathf.Lerp(0, 0.5, var_84_12)

					arg_81_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10003ui_story.fillRatio = var_84_13
				end
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect10003ui_story then
				local var_84_14 = 0.5

				arg_81_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10003ui_story.fillRatio = var_84_14
			end

			local var_84_15 = arg_81_1.actors_["10053ui_story"].transform
			local var_84_16 = 0

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 then
				arg_81_1.var_.moveOldPos10053ui_story = var_84_15.localPosition
			end

			local var_84_17 = 0.001

			if var_84_16 <= arg_81_1.time_ and arg_81_1.time_ < var_84_16 + var_84_17 then
				local var_84_18 = (arg_81_1.time_ - var_84_16) / var_84_17
				local var_84_19 = Vector3.New(0, 100, 0)

				var_84_15.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10053ui_story, var_84_19, var_84_18)

				local var_84_20 = manager.ui.mainCamera.transform.position - var_84_15.position

				var_84_15.forward = Vector3.New(var_84_20.x, var_84_20.y, var_84_20.z)

				local var_84_21 = var_84_15.localEulerAngles

				var_84_21.z = 0
				var_84_21.x = 0
				var_84_15.localEulerAngles = var_84_21
			end

			if arg_81_1.time_ >= var_84_16 + var_84_17 and arg_81_1.time_ < var_84_16 + var_84_17 + arg_84_0 then
				var_84_15.localPosition = Vector3.New(0, 100, 0)

				local var_84_22 = manager.ui.mainCamera.transform.position - var_84_15.position

				var_84_15.forward = Vector3.New(var_84_22.x, var_84_22.y, var_84_22.z)

				local var_84_23 = var_84_15.localEulerAngles

				var_84_23.z = 0
				var_84_23.x = 0
				var_84_15.localEulerAngles = var_84_23
			end

			local var_84_24 = arg_81_1.actors_["10053ui_story"]
			local var_84_25 = 0

			if var_84_25 < arg_81_1.time_ and arg_81_1.time_ <= var_84_25 + arg_84_0 and not isNil(var_84_24) and arg_81_1.var_.characterEffect10053ui_story == nil then
				arg_81_1.var_.characterEffect10053ui_story = var_84_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_26 = 0.034000001847744

			if var_84_25 <= arg_81_1.time_ and arg_81_1.time_ < var_84_25 + var_84_26 and not isNil(var_84_24) then
				local var_84_27 = (arg_81_1.time_ - var_84_25) / var_84_26

				if arg_81_1.var_.characterEffect10053ui_story and not isNil(var_84_24) then
					local var_84_28 = Mathf.Lerp(0, 0.5, var_84_27)

					arg_81_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10053ui_story.fillRatio = var_84_28
				end
			end

			if arg_81_1.time_ >= var_84_25 + var_84_26 and arg_81_1.time_ < var_84_25 + var_84_26 + arg_84_0 and not isNil(var_84_24) and arg_81_1.var_.characterEffect10053ui_story then
				local var_84_29 = 0.5

				arg_81_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10053ui_story.fillRatio = var_84_29
			end

			local var_84_30 = 0

			if var_84_30 < arg_81_1.time_ and arg_81_1.time_ <= var_84_30 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_31 = 1.7

			if var_84_30 <= arg_81_1.time_ and arg_81_1.time_ < var_84_30 + var_84_31 then
				local var_84_32 = (arg_81_1.time_ - var_84_30) / var_84_31
				local var_84_33 = Color.New(1, 1, 1)

				var_84_33.a = Mathf.Lerp(1, 0, var_84_32)
				arg_81_1.mask_.color = var_84_33
			end

			if arg_81_1.time_ >= var_84_30 + var_84_31 and arg_81_1.time_ < var_84_30 + var_84_31 + arg_84_0 then
				local var_84_34 = Color.New(1, 1, 1)
				local var_84_35 = 0

				arg_81_1.mask_.enabled = false
				var_84_34.a = var_84_35
				arg_81_1.mask_.color = var_84_34
			end

			if arg_81_1.frameCnt_ <= 1 then
				arg_81_1.dialog_:SetActive(false)
			end

			local var_84_36 = 1.46666666666667
			local var_84_37 = 0.85

			if var_84_36 < arg_81_1.time_ and arg_81_1.time_ <= var_84_36 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_38 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_38:setOnUpdate(LuaHelper.FloatAction(function(arg_85_0)
					arg_81_1.dialogCg_.alpha = arg_85_0
				end))
				var_84_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_39 = arg_81_1:GetWordFromCfg(317011020)
				local var_84_40 = arg_81_1:FormatText(var_84_39.content)

				arg_81_1.text_.text = var_84_40

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_41 = 34
				local var_84_42 = utf8.len(var_84_40)
				local var_84_43 = var_84_41 <= 0 and var_84_37 or var_84_37 * (var_84_42 / var_84_41)

				if var_84_43 > 0 and var_84_37 < var_84_43 then
					arg_81_1.talkMaxDuration = var_84_43
					var_84_36 = var_84_36 + 0.3

					if var_84_43 + var_84_36 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_43 + var_84_36
					end
				end

				arg_81_1.text_.text = var_84_40
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_44 = var_84_36 + 0.3
			local var_84_45 = math.max(var_84_37, arg_81_1.talkMaxDuration)

			if var_84_44 <= arg_81_1.time_ and arg_81_1.time_ < var_84_44 + var_84_45 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_44) / var_84_45

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_44 + var_84_45 and arg_81_1.time_ < var_84_44 + var_84_45 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play317011021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 317011021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play317011022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 1.125

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_2 = arg_87_1:GetWordFromCfg(317011021)
				local var_90_3 = arg_87_1:FormatText(var_90_2.content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 45
				local var_90_5 = utf8.len(var_90_3)
				local var_90_6 = var_90_4 <= 0 and var_90_1 or var_90_1 * (var_90_5 / var_90_4)

				if var_90_6 > 0 and var_90_1 < var_90_6 then
					arg_87_1.talkMaxDuration = var_90_6

					if var_90_6 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_6 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_7 and arg_87_1.time_ < var_90_0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play317011022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 317011022
		arg_91_1.duration_ = 4.1

		local var_91_0 = {
			zh = 4.1,
			ja = 2.666
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play317011023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.175

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[477].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10053")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:GetWordFromCfg(317011022)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 7
				local var_94_6 = utf8.len(var_94_4)
				local var_94_7 = var_94_5 <= 0 and var_94_1 or var_94_1 * (var_94_6 / var_94_5)

				if var_94_7 > 0 and var_94_1 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011022", "story_v_out_317011.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_317011", "317011022", "story_v_out_317011.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_317011", "317011022", "story_v_out_317011.awb")

						arg_91_1:RecordAudio("317011022", var_94_9)
						arg_91_1:RecordAudio("317011022", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_317011", "317011022", "story_v_out_317011.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_317011", "317011022", "story_v_out_317011.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_10 and arg_91_1.time_ < var_94_0 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play317011023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 317011023
		arg_95_1.duration_ = 2.63

		local var_95_0 = {
			zh = 1.733,
			ja = 2.633
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
				arg_95_0:Play317011024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 0.175

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[523].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_3 = arg_95_1:GetWordFromCfg(317011023)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 7
				local var_98_6 = utf8.len(var_98_4)
				local var_98_7 = var_98_5 <= 0 and var_98_1 or var_98_1 * (var_98_6 / var_98_5)

				if var_98_7 > 0 and var_98_1 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011023", "story_v_out_317011.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_317011", "317011023", "story_v_out_317011.awb") / 1000

					if var_98_8 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_0
					end

					if var_98_3.prefab_name ~= "" and arg_95_1.actors_[var_98_3.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_3.prefab_name].transform, "story_v_out_317011", "317011023", "story_v_out_317011.awb")

						arg_95_1:RecordAudio("317011023", var_98_9)
						arg_95_1:RecordAudio("317011023", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_317011", "317011023", "story_v_out_317011.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_317011", "317011023", "story_v_out_317011.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_10 and arg_95_1.time_ < var_98_0 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play317011024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 317011024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play317011025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.6

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_2 = arg_99_1:GetWordFromCfg(317011024)
				local var_102_3 = arg_99_1:FormatText(var_102_2.content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 24
				local var_102_5 = utf8.len(var_102_3)
				local var_102_6 = var_102_4 <= 0 and var_102_1 or var_102_1 * (var_102_5 / var_102_4)

				if var_102_6 > 0 and var_102_1 < var_102_6 then
					arg_99_1.talkMaxDuration = var_102_6

					if var_102_6 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_6 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_7 and arg_99_1.time_ < var_102_0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play317011025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 317011025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play317011026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 1.3

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

				local var_106_2 = arg_103_1:GetWordFromCfg(317011025)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 52
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
	Play317011026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 317011026
		arg_107_1.duration_ = 1.6

		local var_107_0 = {
			zh = 1.6,
			ja = 1.4
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
				arg_107_0:Play317011027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.175

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_2 = arg_107_1:FormatText(StoryNameCfg[524].name)

				arg_107_1.leftNameTxt_.text = var_110_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_3 = arg_107_1:GetWordFromCfg(317011026)
				local var_110_4 = arg_107_1:FormatText(var_110_3.content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 7
				local var_110_6 = utf8.len(var_110_4)
				local var_110_7 = var_110_5 <= 0 and var_110_1 or var_110_1 * (var_110_6 / var_110_5)

				if var_110_7 > 0 and var_110_1 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_4
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011026", "story_v_out_317011.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_317011", "317011026", "story_v_out_317011.awb") / 1000

					if var_110_8 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_0
					end

					if var_110_3.prefab_name ~= "" and arg_107_1.actors_[var_110_3.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_3.prefab_name].transform, "story_v_out_317011", "317011026", "story_v_out_317011.awb")

						arg_107_1:RecordAudio("317011026", var_110_9)
						arg_107_1:RecordAudio("317011026", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_317011", "317011026", "story_v_out_317011.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_317011", "317011026", "story_v_out_317011.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_10 and arg_107_1.time_ < var_110_0 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play317011027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 317011027
		arg_111_1.duration_ = 9

		local var_111_0 = {
			zh = 6.5,
			ja = 9
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
				arg_111_0:Play317011028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10003ui_story"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos10003ui_story = var_114_0.localPosition
			end

			local var_114_2 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2
				local var_114_4 = Vector3.New(0, -1.05, -5.9)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10003ui_story, var_114_4, var_114_3)

				local var_114_5 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_5.x, var_114_5.y, var_114_5.z)

				local var_114_6 = var_114_0.localEulerAngles

				var_114_6.z = 0
				var_114_6.x = 0
				var_114_0.localEulerAngles = var_114_6
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(0, -1.05, -5.9)

				local var_114_7 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_7.x, var_114_7.y, var_114_7.z)

				local var_114_8 = var_114_0.localEulerAngles

				var_114_8.z = 0
				var_114_8.x = 0
				var_114_0.localEulerAngles = var_114_8
			end

			local var_114_9 = arg_111_1.actors_["10003ui_story"]
			local var_114_10 = 0

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 and not isNil(var_114_9) and arg_111_1.var_.characterEffect10003ui_story == nil then
				arg_111_1.var_.characterEffect10003ui_story = var_114_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_11 = 0.200000002980232

			if var_114_10 <= arg_111_1.time_ and arg_111_1.time_ < var_114_10 + var_114_11 and not isNil(var_114_9) then
				local var_114_12 = (arg_111_1.time_ - var_114_10) / var_114_11

				if arg_111_1.var_.characterEffect10003ui_story and not isNil(var_114_9) then
					arg_111_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_10 + var_114_11 and arg_111_1.time_ < var_114_10 + var_114_11 + arg_114_0 and not isNil(var_114_9) and arg_111_1.var_.characterEffect10003ui_story then
				arg_111_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			local var_114_13 = 0
			local var_114_14 = 0.55

			if var_114_13 < arg_111_1.time_ and arg_111_1.time_ <= var_114_13 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_15 = arg_111_1:FormatText(StoryNameCfg[81].name)

				arg_111_1.leftNameTxt_.text = var_114_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_16 = arg_111_1:GetWordFromCfg(317011027)
				local var_114_17 = arg_111_1:FormatText(var_114_16.content)

				arg_111_1.text_.text = var_114_17

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_18 = 22
				local var_114_19 = utf8.len(var_114_17)
				local var_114_20 = var_114_18 <= 0 and var_114_14 or var_114_14 * (var_114_19 / var_114_18)

				if var_114_20 > 0 and var_114_14 < var_114_20 then
					arg_111_1.talkMaxDuration = var_114_20

					if var_114_20 + var_114_13 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_20 + var_114_13
					end
				end

				arg_111_1.text_.text = var_114_17
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011027", "story_v_out_317011.awb") ~= 0 then
					local var_114_21 = manager.audio:GetVoiceLength("story_v_out_317011", "317011027", "story_v_out_317011.awb") / 1000

					if var_114_21 + var_114_13 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_21 + var_114_13
					end

					if var_114_16.prefab_name ~= "" and arg_111_1.actors_[var_114_16.prefab_name] ~= nil then
						local var_114_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_16.prefab_name].transform, "story_v_out_317011", "317011027", "story_v_out_317011.awb")

						arg_111_1:RecordAudio("317011027", var_114_22)
						arg_111_1:RecordAudio("317011027", var_114_22)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_317011", "317011027", "story_v_out_317011.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_317011", "317011027", "story_v_out_317011.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_23 = math.max(var_114_14, arg_111_1.talkMaxDuration)

			if var_114_13 <= arg_111_1.time_ and arg_111_1.time_ < var_114_13 + var_114_23 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_13) / var_114_23

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_13 + var_114_23 and arg_111_1.time_ < var_114_13 + var_114_23 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play317011028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 317011028
		arg_115_1.duration_ = 1.07

		local var_115_0 = {
			zh = 0.999999999999,
			ja = 1.066
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
				arg_115_0:Play317011029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10003ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect10003ui_story == nil then
				arg_115_1.var_.characterEffect10003ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect10003ui_story and not isNil(var_118_0) then
					local var_118_4 = Mathf.Lerp(0, 0.5, var_118_3)

					arg_115_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_115_1.var_.characterEffect10003ui_story.fillRatio = var_118_4
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect10003ui_story then
				local var_118_5 = 0.5

				arg_115_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_115_1.var_.characterEffect10003ui_story.fillRatio = var_118_5
			end

			local var_118_6 = 0
			local var_118_7 = 0.075

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_8 = arg_115_1:FormatText(StoryNameCfg[524].name)

				arg_115_1.leftNameTxt_.text = var_118_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_9 = arg_115_1:GetWordFromCfg(317011028)
				local var_118_10 = arg_115_1:FormatText(var_118_9.content)

				arg_115_1.text_.text = var_118_10

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_11 = 3
				local var_118_12 = utf8.len(var_118_10)
				local var_118_13 = var_118_11 <= 0 and var_118_7 or var_118_7 * (var_118_12 / var_118_11)

				if var_118_13 > 0 and var_118_7 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_10
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011028", "story_v_out_317011.awb") ~= 0 then
					local var_118_14 = manager.audio:GetVoiceLength("story_v_out_317011", "317011028", "story_v_out_317011.awb") / 1000

					if var_118_14 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_14 + var_118_6
					end

					if var_118_9.prefab_name ~= "" and arg_115_1.actors_[var_118_9.prefab_name] ~= nil then
						local var_118_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_9.prefab_name].transform, "story_v_out_317011", "317011028", "story_v_out_317011.awb")

						arg_115_1:RecordAudio("317011028", var_118_15)
						arg_115_1:RecordAudio("317011028", var_118_15)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_317011", "317011028", "story_v_out_317011.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_317011", "317011028", "story_v_out_317011.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_16 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_16 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_16

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_16 and arg_115_1.time_ < var_118_6 + var_118_16 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play317011029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 317011029
		arg_119_1.duration_ = 8.88

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play317011030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = "STblack"

			if arg_119_1.bgs_[var_122_0] == nil then
				local var_122_1 = Object.Instantiate(arg_119_1.paintGo_)

				var_122_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_122_0)
				var_122_1.name = var_122_0
				var_122_1.transform.parent = arg_119_1.stage_.transform
				var_122_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.bgs_[var_122_0] = var_122_1
			end

			local var_122_2 = 2.1

			if var_122_2 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				local var_122_3 = manager.ui.mainCamera.transform.localPosition
				local var_122_4 = Vector3.New(0, 0, 10) + Vector3.New(var_122_3.x, var_122_3.y, 0)
				local var_122_5 = arg_119_1.bgs_.STblack

				var_122_5.transform.localPosition = var_122_4
				var_122_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_122_6 = var_122_5:GetComponent("SpriteRenderer")

				if var_122_6 and var_122_6.sprite then
					local var_122_7 = (var_122_5.transform.localPosition - var_122_3).z
					local var_122_8 = manager.ui.mainCameraCom_
					local var_122_9 = 2 * var_122_7 * Mathf.Tan(var_122_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_122_10 = var_122_9 * var_122_8.aspect
					local var_122_11 = var_122_6.sprite.bounds.size.x
					local var_122_12 = var_122_6.sprite.bounds.size.y
					local var_122_13 = var_122_10 / var_122_11
					local var_122_14 = var_122_9 / var_122_12
					local var_122_15 = var_122_14 < var_122_13 and var_122_13 or var_122_14

					var_122_5.transform.localScale = Vector3.New(var_122_15, var_122_15, 0)
				end

				for iter_122_0, iter_122_1 in pairs(arg_119_1.bgs_) do
					if iter_122_0 ~= "STblack" then
						iter_122_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_122_16 = 4.1

			if var_122_16 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 then
				arg_119_1.allBtn_.enabled = false
			end

			local var_122_17 = 0.3

			if arg_119_1.time_ >= var_122_16 + var_122_17 and arg_119_1.time_ < var_122_16 + var_122_17 + arg_122_0 then
				arg_119_1.allBtn_.enabled = true
			end

			local var_122_18 = 0

			if var_122_18 < arg_119_1.time_ and arg_119_1.time_ <= var_122_18 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_19 = 2

			if var_122_18 <= arg_119_1.time_ and arg_119_1.time_ < var_122_18 + var_122_19 then
				local var_122_20 = (arg_119_1.time_ - var_122_18) / var_122_19
				local var_122_21 = Color.New(0, 0, 0)

				var_122_21.a = Mathf.Lerp(0, 1, var_122_20)
				arg_119_1.mask_.color = var_122_21
			end

			if arg_119_1.time_ >= var_122_18 + var_122_19 and arg_119_1.time_ < var_122_18 + var_122_19 + arg_122_0 then
				local var_122_22 = Color.New(0, 0, 0)

				var_122_22.a = 1
				arg_119_1.mask_.color = var_122_22
			end

			local var_122_23 = 2

			if var_122_23 < arg_119_1.time_ and arg_119_1.time_ <= var_122_23 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_24 = 2

			if var_122_23 <= arg_119_1.time_ and arg_119_1.time_ < var_122_23 + var_122_24 then
				local var_122_25 = (arg_119_1.time_ - var_122_23) / var_122_24
				local var_122_26 = Color.New(0, 0, 0)

				var_122_26.a = Mathf.Lerp(1, 0, var_122_25)
				arg_119_1.mask_.color = var_122_26
			end

			if arg_119_1.time_ >= var_122_23 + var_122_24 and arg_119_1.time_ < var_122_23 + var_122_24 + arg_122_0 then
				local var_122_27 = Color.New(0, 0, 0)
				local var_122_28 = 0

				arg_119_1.mask_.enabled = false
				var_122_27.a = var_122_28
				arg_119_1.mask_.color = var_122_27
			end

			local var_122_29 = arg_119_1.actors_["10003ui_story"].transform
			local var_122_30 = 1.96599999815226

			if var_122_30 < arg_119_1.time_ and arg_119_1.time_ <= var_122_30 + arg_122_0 then
				arg_119_1.var_.moveOldPos10003ui_story = var_122_29.localPosition
			end

			local var_122_31 = 0.001

			if var_122_30 <= arg_119_1.time_ and arg_119_1.time_ < var_122_30 + var_122_31 then
				local var_122_32 = (arg_119_1.time_ - var_122_30) / var_122_31
				local var_122_33 = Vector3.New(0, 100, 0)

				var_122_29.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10003ui_story, var_122_33, var_122_32)

				local var_122_34 = manager.ui.mainCamera.transform.position - var_122_29.position

				var_122_29.forward = Vector3.New(var_122_34.x, var_122_34.y, var_122_34.z)

				local var_122_35 = var_122_29.localEulerAngles

				var_122_35.z = 0
				var_122_35.x = 0
				var_122_29.localEulerAngles = var_122_35
			end

			if arg_119_1.time_ >= var_122_30 + var_122_31 and arg_119_1.time_ < var_122_30 + var_122_31 + arg_122_0 then
				var_122_29.localPosition = Vector3.New(0, 100, 0)

				local var_122_36 = manager.ui.mainCamera.transform.position - var_122_29.position

				var_122_29.forward = Vector3.New(var_122_36.x, var_122_36.y, var_122_36.z)

				local var_122_37 = var_122_29.localEulerAngles

				var_122_37.z = 0
				var_122_37.x = 0
				var_122_29.localEulerAngles = var_122_37
			end

			if arg_119_1.frameCnt_ <= 1 then
				arg_119_1.dialog_:SetActive(false)
			end

			local var_122_38 = 3.875
			local var_122_39 = 0.525

			if var_122_38 < arg_119_1.time_ and arg_119_1.time_ <= var_122_38 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				arg_119_1.dialog_:SetActive(true)

				arg_119_1.dialogCg_.alpha = 0

				local var_122_40 = LeanTween.value(arg_119_1.dialog_, 0, 1, 0.3)

				var_122_40:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_119_1.dialogCg_.alpha = arg_123_0
				end))
				var_122_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_119_1.dialog_)
					var_122_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_119_1.duration_ = arg_119_1.duration_ + 0.3

				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_41 = arg_119_1:GetWordFromCfg(317011029)
				local var_122_42 = arg_119_1:FormatText(var_122_41.content)

				arg_119_1.text_.text = var_122_42

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_43 = 21
				local var_122_44 = utf8.len(var_122_42)
				local var_122_45 = var_122_43 <= 0 and var_122_39 or var_122_39 * (var_122_44 / var_122_43)

				if var_122_45 > 0 and var_122_39 < var_122_45 then
					arg_119_1.talkMaxDuration = var_122_45
					var_122_38 = var_122_38 + 0.3

					if var_122_45 + var_122_38 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_45 + var_122_38
					end
				end

				arg_119_1.text_.text = var_122_42
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_46 = var_122_38 + 0.3
			local var_122_47 = math.max(var_122_39, arg_119_1.talkMaxDuration)

			if var_122_46 <= arg_119_1.time_ and arg_119_1.time_ < var_122_46 + var_122_47 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_46) / var_122_47

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_46 + var_122_47 and arg_119_1.time_ < var_122_46 + var_122_47 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play317011030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 317011030
		arg_125_1.duration_ = 7

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play317011031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = "K11f"

			if arg_125_1.bgs_[var_128_0] == nil then
				local var_128_1 = Object.Instantiate(arg_125_1.paintGo_)

				var_128_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_128_0)
				var_128_1.name = var_128_0
				var_128_1.transform.parent = arg_125_1.stage_.transform
				var_128_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.bgs_[var_128_0] = var_128_1
			end

			local var_128_2 = 0

			if var_128_2 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				local var_128_3 = manager.ui.mainCamera.transform.localPosition
				local var_128_4 = Vector3.New(0, 0, 10) + Vector3.New(var_128_3.x, var_128_3.y, 0)
				local var_128_5 = arg_125_1.bgs_.K11f

				var_128_5.transform.localPosition = var_128_4
				var_128_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_128_6 = var_128_5:GetComponent("SpriteRenderer")

				if var_128_6 and var_128_6.sprite then
					local var_128_7 = (var_128_5.transform.localPosition - var_128_3).z
					local var_128_8 = manager.ui.mainCameraCom_
					local var_128_9 = 2 * var_128_7 * Mathf.Tan(var_128_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_128_10 = var_128_9 * var_128_8.aspect
					local var_128_11 = var_128_6.sprite.bounds.size.x
					local var_128_12 = var_128_6.sprite.bounds.size.y
					local var_128_13 = var_128_10 / var_128_11
					local var_128_14 = var_128_9 / var_128_12
					local var_128_15 = var_128_14 < var_128_13 and var_128_13 or var_128_14

					var_128_5.transform.localScale = Vector3.New(var_128_15, var_128_15, 0)
				end

				for iter_128_0, iter_128_1 in pairs(arg_125_1.bgs_) do
					if iter_128_0 ~= "K11f" then
						iter_128_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_128_16 = 0

			if var_128_16 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_17 = 2

			if var_128_16 <= arg_125_1.time_ and arg_125_1.time_ < var_128_16 + var_128_17 then
				local var_128_18 = (arg_125_1.time_ - var_128_16) / var_128_17
				local var_128_19 = Color.New(0, 0, 0)

				var_128_19.a = Mathf.Lerp(1, 0, var_128_18)
				arg_125_1.mask_.color = var_128_19
			end

			if arg_125_1.time_ >= var_128_16 + var_128_17 and arg_125_1.time_ < var_128_16 + var_128_17 + arg_128_0 then
				local var_128_20 = Color.New(0, 0, 0)
				local var_128_21 = 0

				arg_125_1.mask_.enabled = false
				var_128_20.a = var_128_21
				arg_125_1.mask_.color = var_128_20
			end

			if arg_125_1.frameCnt_ <= 1 then
				arg_125_1.dialog_:SetActive(false)
			end

			local var_128_22 = 2
			local var_128_23 = 0.55

			if var_128_22 < arg_125_1.time_ and arg_125_1.time_ <= var_128_22 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				arg_125_1.dialog_:SetActive(true)

				arg_125_1.dialogCg_.alpha = 0

				local var_128_24 = LeanTween.value(arg_125_1.dialog_, 0, 1, 0.3)

				var_128_24:setOnUpdate(LuaHelper.FloatAction(function(arg_129_0)
					arg_125_1.dialogCg_.alpha = arg_129_0
				end))
				var_128_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_125_1.dialog_)
					var_128_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_125_1.duration_ = arg_125_1.duration_ + 0.3

				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_25 = arg_125_1:GetWordFromCfg(317011030)
				local var_128_26 = arg_125_1:FormatText(var_128_25.content)

				arg_125_1.text_.text = var_128_26

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_27 = 22
				local var_128_28 = utf8.len(var_128_26)
				local var_128_29 = var_128_27 <= 0 and var_128_23 or var_128_23 * (var_128_28 / var_128_27)

				if var_128_29 > 0 and var_128_23 < var_128_29 then
					arg_125_1.talkMaxDuration = var_128_29
					var_128_22 = var_128_22 + 0.3

					if var_128_29 + var_128_22 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_29 + var_128_22
					end
				end

				arg_125_1.text_.text = var_128_26
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_30 = var_128_22 + 0.3
			local var_128_31 = math.max(var_128_23, arg_125_1.talkMaxDuration)

			if var_128_30 <= arg_125_1.time_ and arg_125_1.time_ < var_128_30 + var_128_31 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_30) / var_128_31

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_30 + var_128_31 and arg_125_1.time_ < var_128_30 + var_128_31 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play317011031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 317011031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play317011032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 1

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				local var_134_2 = "play"
				local var_134_3 = "effect"

				arg_131_1:AudioAction(var_134_2, var_134_3, "se_story_123_01", "se_story_123_01_hit", "")
			end

			local var_134_4 = 0
			local var_134_5 = 1.1

			if var_134_4 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(317011031)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_8 = 44
				local var_134_9 = utf8.len(var_134_7)
				local var_134_10 = var_134_8 <= 0 and var_134_5 or var_134_5 * (var_134_9 / var_134_8)

				if var_134_10 > 0 and var_134_5 < var_134_10 then
					arg_131_1.talkMaxDuration = var_134_10

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_11 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_11 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_11

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_11 and arg_131_1.time_ < var_134_4 + var_134_11 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play317011032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 317011032
		arg_135_1.duration_ = 5.8

		local var_135_0 = {
			zh = 4.8,
			ja = 5.8
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
				arg_135_0:Play317011033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.425

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[525].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(317011032)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 17
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011032", "story_v_out_317011.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_317011", "317011032", "story_v_out_317011.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_317011", "317011032", "story_v_out_317011.awb")

						arg_135_1:RecordAudio("317011032", var_138_9)
						arg_135_1:RecordAudio("317011032", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_317011", "317011032", "story_v_out_317011.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_317011", "317011032", "story_v_out_317011.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_10 and arg_135_1.time_ < var_138_0 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play317011033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 317011033
		arg_139_1.duration_ = 7.67

		local var_139_0 = {
			zh = 7.666,
			ja = 6.7
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
				arg_139_0:Play317011034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = "1199ui_story"

			if arg_139_1.actors_[var_142_0] == nil then
				local var_142_1 = Asset.Load("Char/" .. "1199ui_story")

				if not isNil(var_142_1) then
					local var_142_2 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_139_1.stage_.transform)

					var_142_2.name = var_142_0
					var_142_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_139_1.actors_[var_142_0] = var_142_2

					local var_142_3 = var_142_2:GetComponentInChildren(typeof(CharacterEffect))

					var_142_3.enabled = true

					local var_142_4 = GameObjectTools.GetOrAddComponent(var_142_2, typeof(DynamicBoneHelper))

					if var_142_4 then
						var_142_4:EnableDynamicBone(false)
					end

					arg_139_1:ShowWeapon(var_142_3.transform, false)

					arg_139_1.var_[var_142_0 .. "Animator"] = var_142_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_139_1.var_[var_142_0 .. "Animator"].applyRootMotion = true
					arg_139_1.var_[var_142_0 .. "LipSync"] = var_142_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_142_5 = arg_139_1.actors_["1199ui_story"].transform
			local var_142_6 = 0

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.var_.moveOldPos1199ui_story = var_142_5.localPosition
			end

			local var_142_7 = 0.001

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_7 then
				local var_142_8 = (arg_139_1.time_ - var_142_6) / var_142_7
				local var_142_9 = Vector3.New(0, -1.08, -5.9)

				var_142_5.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1199ui_story, var_142_9, var_142_8)

				local var_142_10 = manager.ui.mainCamera.transform.position - var_142_5.position

				var_142_5.forward = Vector3.New(var_142_10.x, var_142_10.y, var_142_10.z)

				local var_142_11 = var_142_5.localEulerAngles

				var_142_11.z = 0
				var_142_11.x = 0
				var_142_5.localEulerAngles = var_142_11
			end

			if arg_139_1.time_ >= var_142_6 + var_142_7 and arg_139_1.time_ < var_142_6 + var_142_7 + arg_142_0 then
				var_142_5.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_142_12 = manager.ui.mainCamera.transform.position - var_142_5.position

				var_142_5.forward = Vector3.New(var_142_12.x, var_142_12.y, var_142_12.z)

				local var_142_13 = var_142_5.localEulerAngles

				var_142_13.z = 0
				var_142_13.x = 0
				var_142_5.localEulerAngles = var_142_13
			end

			local var_142_14 = arg_139_1.actors_["1199ui_story"]
			local var_142_15 = 0

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 and not isNil(var_142_14) and arg_139_1.var_.characterEffect1199ui_story == nil then
				arg_139_1.var_.characterEffect1199ui_story = var_142_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_16 = 0.200000002980232

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_16 and not isNil(var_142_14) then
				local var_142_17 = (arg_139_1.time_ - var_142_15) / var_142_16

				if arg_139_1.var_.characterEffect1199ui_story and not isNil(var_142_14) then
					arg_139_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_15 + var_142_16 and arg_139_1.time_ < var_142_15 + var_142_16 + arg_142_0 and not isNil(var_142_14) and arg_139_1.var_.characterEffect1199ui_story then
				arg_139_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_142_18 = 0

			if var_142_18 < arg_139_1.time_ and arg_139_1.time_ <= var_142_18 + arg_142_0 then
				arg_139_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			local var_142_19 = 0

			if var_142_19 < arg_139_1.time_ and arg_139_1.time_ <= var_142_19 + arg_142_0 then
				arg_139_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_142_20 = 0
			local var_142_21 = 0.825

			if var_142_20 < arg_139_1.time_ and arg_139_1.time_ <= var_142_20 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_22 = arg_139_1:FormatText(StoryNameCfg[84].name)

				arg_139_1.leftNameTxt_.text = var_142_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_23 = arg_139_1:GetWordFromCfg(317011033)
				local var_142_24 = arg_139_1:FormatText(var_142_23.content)

				arg_139_1.text_.text = var_142_24

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_25 = 32
				local var_142_26 = utf8.len(var_142_24)
				local var_142_27 = var_142_25 <= 0 and var_142_21 or var_142_21 * (var_142_26 / var_142_25)

				if var_142_27 > 0 and var_142_21 < var_142_27 then
					arg_139_1.talkMaxDuration = var_142_27

					if var_142_27 + var_142_20 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_27 + var_142_20
					end
				end

				arg_139_1.text_.text = var_142_24
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011033", "story_v_out_317011.awb") ~= 0 then
					local var_142_28 = manager.audio:GetVoiceLength("story_v_out_317011", "317011033", "story_v_out_317011.awb") / 1000

					if var_142_28 + var_142_20 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_28 + var_142_20
					end

					if var_142_23.prefab_name ~= "" and arg_139_1.actors_[var_142_23.prefab_name] ~= nil then
						local var_142_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_23.prefab_name].transform, "story_v_out_317011", "317011033", "story_v_out_317011.awb")

						arg_139_1:RecordAudio("317011033", var_142_29)
						arg_139_1:RecordAudio("317011033", var_142_29)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_317011", "317011033", "story_v_out_317011.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_317011", "317011033", "story_v_out_317011.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_30 = math.max(var_142_21, arg_139_1.talkMaxDuration)

			if var_142_20 <= arg_139_1.time_ and arg_139_1.time_ < var_142_20 + var_142_30 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_20) / var_142_30

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_20 + var_142_30 and arg_139_1.time_ < var_142_20 + var_142_30 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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

		arg_139_1:InitPlayNodeList()
	end,
	Play317011034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 317011034
		arg_143_1.duration_ = 7.77

		local var_143_0 = {
			zh = 5.9,
			ja = 7.766
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
				arg_143_0:Play317011035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1199ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1199ui_story == nil then
				arg_143_1.var_.characterEffect1199ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1199ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1199ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1199ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1199ui_story.fillRatio = var_146_5
			end

			local var_146_6 = 0
			local var_146_7 = 0.625

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_8 = arg_143_1:FormatText(StoryNameCfg[525].name)

				arg_143_1.leftNameTxt_.text = var_146_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_9 = arg_143_1:GetWordFromCfg(317011034)
				local var_146_10 = arg_143_1:FormatText(var_146_9.content)

				arg_143_1.text_.text = var_146_10

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 25
				local var_146_12 = utf8.len(var_146_10)
				local var_146_13 = var_146_11 <= 0 and var_146_7 or var_146_7 * (var_146_12 / var_146_11)

				if var_146_13 > 0 and var_146_7 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_10
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011034", "story_v_out_317011.awb") ~= 0 then
					local var_146_14 = manager.audio:GetVoiceLength("story_v_out_317011", "317011034", "story_v_out_317011.awb") / 1000

					if var_146_14 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_6
					end

					if var_146_9.prefab_name ~= "" and arg_143_1.actors_[var_146_9.prefab_name] ~= nil then
						local var_146_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_9.prefab_name].transform, "story_v_out_317011", "317011034", "story_v_out_317011.awb")

						arg_143_1:RecordAudio("317011034", var_146_15)
						arg_143_1:RecordAudio("317011034", var_146_15)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_317011", "317011034", "story_v_out_317011.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_317011", "317011034", "story_v_out_317011.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_16 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_16 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_16

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_16 and arg_143_1.time_ < var_146_6 + var_146_16 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play317011035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 317011035
		arg_147_1.duration_ = 4.6

		local var_147_0 = {
			zh = 1.999999999999,
			ja = 4.6
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
				arg_147_0:Play317011036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1199ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos1199ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(0, -1.08, -5.9)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1199ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["1199ui_story"]
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1199ui_story == nil then
				arg_147_1.var_.characterEffect1199ui_story = var_150_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_11 = 0.200000002980232

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 and not isNil(var_150_9) then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11

				if arg_147_1.var_.characterEffect1199ui_story and not isNil(var_150_9) then
					arg_147_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1199ui_story then
				arg_147_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_150_13 = 0

			if var_150_13 < arg_147_1.time_ and arg_147_1.time_ <= var_150_13 + arg_150_0 then
				arg_147_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_150_14 = 0
			local var_150_15 = 0.175

			if var_150_14 < arg_147_1.time_ and arg_147_1.time_ <= var_150_14 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_16 = arg_147_1:FormatText(StoryNameCfg[84].name)

				arg_147_1.leftNameTxt_.text = var_150_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_17 = arg_147_1:GetWordFromCfg(317011035)
				local var_150_18 = arg_147_1:FormatText(var_150_17.content)

				arg_147_1.text_.text = var_150_18

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_19 = 7
				local var_150_20 = utf8.len(var_150_18)
				local var_150_21 = var_150_19 <= 0 and var_150_15 or var_150_15 * (var_150_20 / var_150_19)

				if var_150_21 > 0 and var_150_15 < var_150_21 then
					arg_147_1.talkMaxDuration = var_150_21

					if var_150_21 + var_150_14 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_21 + var_150_14
					end
				end

				arg_147_1.text_.text = var_150_18
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011035", "story_v_out_317011.awb") ~= 0 then
					local var_150_22 = manager.audio:GetVoiceLength("story_v_out_317011", "317011035", "story_v_out_317011.awb") / 1000

					if var_150_22 + var_150_14 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_22 + var_150_14
					end

					if var_150_17.prefab_name ~= "" and arg_147_1.actors_[var_150_17.prefab_name] ~= nil then
						local var_150_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_17.prefab_name].transform, "story_v_out_317011", "317011035", "story_v_out_317011.awb")

						arg_147_1:RecordAudio("317011035", var_150_23)
						arg_147_1:RecordAudio("317011035", var_150_23)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_317011", "317011035", "story_v_out_317011.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_317011", "317011035", "story_v_out_317011.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_24 = math.max(var_150_15, arg_147_1.talkMaxDuration)

			if var_150_14 <= arg_147_1.time_ and arg_147_1.time_ < var_150_14 + var_150_24 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_14) / var_150_24

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_14 + var_150_24 and arg_147_1.time_ < var_150_14 + var_150_24 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play317011036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 317011036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play317011037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1199ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1199ui_story == nil then
				arg_151_1.var_.characterEffect1199ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1199ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1199ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1199ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1199ui_story.fillRatio = var_154_5
			end

			local var_154_6 = 0
			local var_154_7 = 0.85

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_8 = arg_151_1:GetWordFromCfg(317011036)
				local var_154_9 = arg_151_1:FormatText(var_154_8.content)

				arg_151_1.text_.text = var_154_9

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_10 = 34
				local var_154_11 = utf8.len(var_154_9)
				local var_154_12 = var_154_10 <= 0 and var_154_7 or var_154_7 * (var_154_11 / var_154_10)

				if var_154_12 > 0 and var_154_7 < var_154_12 then
					arg_151_1.talkMaxDuration = var_154_12

					if var_154_12 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_12 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_9
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_13 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_13 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_13

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_13 and arg_151_1.time_ < var_154_6 + var_154_13 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play317011037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 317011037
		arg_155_1.duration_ = 14.27

		local var_155_0 = {
			zh = 13.966,
			ja = 14.266
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
				arg_155_0:Play317011038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1199ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1199ui_story == nil then
				arg_155_1.var_.characterEffect1199ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect1199ui_story and not isNil(var_158_0) then
					arg_155_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1199ui_story then
				arg_155_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_158_4 = 0

			if var_158_4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_2")
			end

			local var_158_5 = 0

			if var_158_5 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_158_6 = 0
			local var_158_7 = 1.525

			if var_158_6 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_8 = arg_155_1:FormatText(StoryNameCfg[84].name)

				arg_155_1.leftNameTxt_.text = var_158_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_9 = arg_155_1:GetWordFromCfg(317011037)
				local var_158_10 = arg_155_1:FormatText(var_158_9.content)

				arg_155_1.text_.text = var_158_10

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 61
				local var_158_12 = utf8.len(var_158_10)
				local var_158_13 = var_158_11 <= 0 and var_158_7 or var_158_7 * (var_158_12 / var_158_11)

				if var_158_13 > 0 and var_158_7 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_10
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011037", "story_v_out_317011.awb") ~= 0 then
					local var_158_14 = manager.audio:GetVoiceLength("story_v_out_317011", "317011037", "story_v_out_317011.awb") / 1000

					if var_158_14 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_14 + var_158_6
					end

					if var_158_9.prefab_name ~= "" and arg_155_1.actors_[var_158_9.prefab_name] ~= nil then
						local var_158_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_9.prefab_name].transform, "story_v_out_317011", "317011037", "story_v_out_317011.awb")

						arg_155_1:RecordAudio("317011037", var_158_15)
						arg_155_1:RecordAudio("317011037", var_158_15)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_317011", "317011037", "story_v_out_317011.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_317011", "317011037", "story_v_out_317011.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_16 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_16 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_16

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_16 and arg_155_1.time_ < var_158_6 + var_158_16 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play317011038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 317011038
		arg_159_1.duration_ = 4.27

		local var_159_0 = {
			zh = 3.9,
			ja = 4.266
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play317011039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1199ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos1199ui_story = var_162_0.localPosition
			end

			local var_162_2 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(0, -1.08, -5.9)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1199ui_story, var_162_4, var_162_3)

				local var_162_5 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_5.x, var_162_5.y, var_162_5.z)

				local var_162_6 = var_162_0.localEulerAngles

				var_162_6.z = 0
				var_162_6.x = 0
				var_162_0.localEulerAngles = var_162_6
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_162_7 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_7.x, var_162_7.y, var_162_7.z)

				local var_162_8 = var_162_0.localEulerAngles

				var_162_8.z = 0
				var_162_8.x = 0
				var_162_0.localEulerAngles = var_162_8
			end

			local var_162_9 = arg_159_1.actors_["1199ui_story"]
			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1199ui_story == nil then
				arg_159_1.var_.characterEffect1199ui_story = var_162_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_11 = 0.200000002980232

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_11 and not isNil(var_162_9) then
				local var_162_12 = (arg_159_1.time_ - var_162_10) / var_162_11

				if arg_159_1.var_.characterEffect1199ui_story and not isNil(var_162_9) then
					arg_159_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_10 + var_162_11 and arg_159_1.time_ < var_162_10 + var_162_11 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1199ui_story then
				arg_159_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_162_13 = 0

			if var_162_13 < arg_159_1.time_ and arg_159_1.time_ <= var_162_13 + arg_162_0 then
				arg_159_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			local var_162_14 = 0

			if var_162_14 < arg_159_1.time_ and arg_159_1.time_ <= var_162_14 + arg_162_0 then
				arg_159_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_162_15 = 0
			local var_162_16 = 0.525

			if var_162_15 < arg_159_1.time_ and arg_159_1.time_ <= var_162_15 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_17 = arg_159_1:FormatText(StoryNameCfg[84].name)

				arg_159_1.leftNameTxt_.text = var_162_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_18 = arg_159_1:GetWordFromCfg(317011038)
				local var_162_19 = arg_159_1:FormatText(var_162_18.content)

				arg_159_1.text_.text = var_162_19

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_20 = 21
				local var_162_21 = utf8.len(var_162_19)
				local var_162_22 = var_162_20 <= 0 and var_162_16 or var_162_16 * (var_162_21 / var_162_20)

				if var_162_22 > 0 and var_162_16 < var_162_22 then
					arg_159_1.talkMaxDuration = var_162_22

					if var_162_22 + var_162_15 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_22 + var_162_15
					end
				end

				arg_159_1.text_.text = var_162_19
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011038", "story_v_out_317011.awb") ~= 0 then
					local var_162_23 = manager.audio:GetVoiceLength("story_v_out_317011", "317011038", "story_v_out_317011.awb") / 1000

					if var_162_23 + var_162_15 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_23 + var_162_15
					end

					if var_162_18.prefab_name ~= "" and arg_159_1.actors_[var_162_18.prefab_name] ~= nil then
						local var_162_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_18.prefab_name].transform, "story_v_out_317011", "317011038", "story_v_out_317011.awb")

						arg_159_1:RecordAudio("317011038", var_162_24)
						arg_159_1:RecordAudio("317011038", var_162_24)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_317011", "317011038", "story_v_out_317011.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_317011", "317011038", "story_v_out_317011.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_25 = math.max(var_162_16, arg_159_1.talkMaxDuration)

			if var_162_15 <= arg_159_1.time_ and arg_159_1.time_ < var_162_15 + var_162_25 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_15) / var_162_25

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_15 + var_162_25 and arg_159_1.time_ < var_162_15 + var_162_25 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play317011039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 317011039
		arg_163_1.duration_ = 8.3

		local var_163_0 = {
			zh = 8.3,
			ja = 6.9
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
				arg_163_0:Play317011040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1199ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1199ui_story == nil then
				arg_163_1.var_.characterEffect1199ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1199ui_story and not isNil(var_166_0) then
					local var_166_4 = Mathf.Lerp(0, 0.5, var_166_3)

					arg_163_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1199ui_story.fillRatio = var_166_4
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1199ui_story then
				local var_166_5 = 0.5

				arg_163_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1199ui_story.fillRatio = var_166_5
			end

			local var_166_6 = 0
			local var_166_7 = 0.7

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_8 = arg_163_1:FormatText(StoryNameCfg[525].name)

				arg_163_1.leftNameTxt_.text = var_166_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_9 = arg_163_1:GetWordFromCfg(317011039)
				local var_166_10 = arg_163_1:FormatText(var_166_9.content)

				arg_163_1.text_.text = var_166_10

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011039", "story_v_out_317011.awb") ~= 0 then
					local var_166_14 = manager.audio:GetVoiceLength("story_v_out_317011", "317011039", "story_v_out_317011.awb") / 1000

					if var_166_14 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_6
					end

					if var_166_9.prefab_name ~= "" and arg_163_1.actors_[var_166_9.prefab_name] ~= nil then
						local var_166_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_9.prefab_name].transform, "story_v_out_317011", "317011039", "story_v_out_317011.awb")

						arg_163_1:RecordAudio("317011039", var_166_15)
						arg_163_1:RecordAudio("317011039", var_166_15)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_317011", "317011039", "story_v_out_317011.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_317011", "317011039", "story_v_out_317011.awb")
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
	Play317011040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 317011040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play317011041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1199ui_story"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos1199ui_story = var_170_0.localPosition
			end

			local var_170_2 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2
				local var_170_4 = Vector3.New(0, 100, 0)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1199ui_story, var_170_4, var_170_3)

				local var_170_5 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_5.x, var_170_5.y, var_170_5.z)

				local var_170_6 = var_170_0.localEulerAngles

				var_170_6.z = 0
				var_170_6.x = 0
				var_170_0.localEulerAngles = var_170_6
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(0, 100, 0)

				local var_170_7 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_7.x, var_170_7.y, var_170_7.z)

				local var_170_8 = var_170_0.localEulerAngles

				var_170_8.z = 0
				var_170_8.x = 0
				var_170_0.localEulerAngles = var_170_8
			end

			local var_170_9 = 0
			local var_170_10 = 0.45

			if var_170_9 < arg_167_1.time_ and arg_167_1.time_ <= var_170_9 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_11 = arg_167_1:GetWordFromCfg(317011040)
				local var_170_12 = arg_167_1:FormatText(var_170_11.content)

				arg_167_1.text_.text = var_170_12

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_13 = 18
				local var_170_14 = utf8.len(var_170_12)
				local var_170_15 = var_170_13 <= 0 and var_170_10 or var_170_10 * (var_170_14 / var_170_13)

				if var_170_15 > 0 and var_170_10 < var_170_15 then
					arg_167_1.talkMaxDuration = var_170_15

					if var_170_15 + var_170_9 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_15 + var_170_9
					end
				end

				arg_167_1.text_.text = var_170_12
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_16 = math.max(var_170_10, arg_167_1.talkMaxDuration)

			if var_170_9 <= arg_167_1.time_ and arg_167_1.time_ < var_170_9 + var_170_16 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_9) / var_170_16

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_9 + var_170_16 and arg_167_1.time_ < var_170_9 + var_170_16 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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

		arg_167_1:InitPlayNodeList()
	end,
	Play317011041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 317011041
		arg_171_1.duration_ = 3.07

		local var_171_0 = {
			zh = 2.266,
			ja = 3.066
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
				arg_171_0:Play317011042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1199ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1199ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(0, -1.08, -5.9)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1199ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = arg_171_1.actors_["1199ui_story"]
			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect1199ui_story == nil then
				arg_171_1.var_.characterEffect1199ui_story = var_174_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_11 = 0.200000002980232

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_11 and not isNil(var_174_9) then
				local var_174_12 = (arg_171_1.time_ - var_174_10) / var_174_11

				if arg_171_1.var_.characterEffect1199ui_story and not isNil(var_174_9) then
					arg_171_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_10 + var_174_11 and arg_171_1.time_ < var_174_10 + var_174_11 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect1199ui_story then
				arg_171_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_174_13 = 0

			if var_174_13 < arg_171_1.time_ and arg_171_1.time_ <= var_174_13 + arg_174_0 then
				arg_171_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action456")
			end

			local var_174_14 = 0

			if var_174_14 < arg_171_1.time_ and arg_171_1.time_ <= var_174_14 + arg_174_0 then
				arg_171_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_174_15 = 0
			local var_174_16 = 0.35

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_17 = arg_171_1:FormatText(StoryNameCfg[84].name)

				arg_171_1.leftNameTxt_.text = var_174_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_18 = arg_171_1:GetWordFromCfg(317011041)
				local var_174_19 = arg_171_1:FormatText(var_174_18.content)

				arg_171_1.text_.text = var_174_19

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_20 = 14
				local var_174_21 = utf8.len(var_174_19)
				local var_174_22 = var_174_20 <= 0 and var_174_16 or var_174_16 * (var_174_21 / var_174_20)

				if var_174_22 > 0 and var_174_16 < var_174_22 then
					arg_171_1.talkMaxDuration = var_174_22

					if var_174_22 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_22 + var_174_15
					end
				end

				arg_171_1.text_.text = var_174_19
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011041", "story_v_out_317011.awb") ~= 0 then
					local var_174_23 = manager.audio:GetVoiceLength("story_v_out_317011", "317011041", "story_v_out_317011.awb") / 1000

					if var_174_23 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_23 + var_174_15
					end

					if var_174_18.prefab_name ~= "" and arg_171_1.actors_[var_174_18.prefab_name] ~= nil then
						local var_174_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_18.prefab_name].transform, "story_v_out_317011", "317011041", "story_v_out_317011.awb")

						arg_171_1:RecordAudio("317011041", var_174_24)
						arg_171_1:RecordAudio("317011041", var_174_24)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_317011", "317011041", "story_v_out_317011.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_317011", "317011041", "story_v_out_317011.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_25 = math.max(var_174_16, arg_171_1.talkMaxDuration)

			if var_174_15 <= arg_171_1.time_ and arg_171_1.time_ < var_174_15 + var_174_25 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_15) / var_174_25

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_15 + var_174_25 and arg_171_1.time_ < var_174_15 + var_174_25 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play317011042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 317011042
		arg_175_1.duration_ = 9.17

		local var_175_0 = {
			zh = 3.366,
			ja = 9.166
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
				arg_175_0:Play317011043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.4

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[84].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_3 = arg_175_1:GetWordFromCfg(317011042)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 16
				local var_178_6 = utf8.len(var_178_4)
				local var_178_7 = var_178_5 <= 0 and var_178_1 or var_178_1 * (var_178_6 / var_178_5)

				if var_178_7 > 0 and var_178_1 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011042", "story_v_out_317011.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_317011", "317011042", "story_v_out_317011.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_317011", "317011042", "story_v_out_317011.awb")

						arg_175_1:RecordAudio("317011042", var_178_9)
						arg_175_1:RecordAudio("317011042", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_317011", "317011042", "story_v_out_317011.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_317011", "317011042", "story_v_out_317011.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_10 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_10 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_10

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_10 and arg_175_1.time_ < var_178_0 + var_178_10 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play317011043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 317011043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play317011044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1199ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1199ui_story == nil then
				arg_179_1.var_.characterEffect1199ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect1199ui_story and not isNil(var_182_0) then
					local var_182_4 = Mathf.Lerp(0, 0.5, var_182_3)

					arg_179_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1199ui_story.fillRatio = var_182_4
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1199ui_story then
				local var_182_5 = 0.5

				arg_179_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1199ui_story.fillRatio = var_182_5
			end

			local var_182_6 = 0
			local var_182_7 = 0.425

			if var_182_6 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_8 = arg_179_1:GetWordFromCfg(317011043)
				local var_182_9 = arg_179_1:FormatText(var_182_8.content)

				arg_179_1.text_.text = var_182_9

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_10 = 17
				local var_182_11 = utf8.len(var_182_9)
				local var_182_12 = var_182_10 <= 0 and var_182_7 or var_182_7 * (var_182_11 / var_182_10)

				if var_182_12 > 0 and var_182_7 < var_182_12 then
					arg_179_1.talkMaxDuration = var_182_12

					if var_182_12 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_12 + var_182_6
					end
				end

				arg_179_1.text_.text = var_182_9
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_13 = math.max(var_182_7, arg_179_1.talkMaxDuration)

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_13 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_13

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_13 and arg_179_1.time_ < var_182_6 + var_182_13 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play317011044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 317011044
		arg_183_1.duration_ = 11.47

		local var_183_0 = {
			zh = 8.7,
			ja = 11.466
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
				arg_183_0:Play317011045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.95

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[525].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:GetWordFromCfg(317011044)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 38
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011044", "story_v_out_317011.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_317011", "317011044", "story_v_out_317011.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_317011", "317011044", "story_v_out_317011.awb")

						arg_183_1:RecordAudio("317011044", var_186_9)
						arg_183_1:RecordAudio("317011044", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_317011", "317011044", "story_v_out_317011.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_317011", "317011044", "story_v_out_317011.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_10 and arg_183_1.time_ < var_186_0 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play317011045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 317011045
		arg_187_1.duration_ = 2

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play317011046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1199ui_story"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos1199ui_story = var_190_0.localPosition
			end

			local var_190_2 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2
				local var_190_4 = Vector3.New(0, -1.08, -5.9)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1199ui_story, var_190_4, var_190_3)

				local var_190_5 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_5.x, var_190_5.y, var_190_5.z)

				local var_190_6 = var_190_0.localEulerAngles

				var_190_6.z = 0
				var_190_6.x = 0
				var_190_0.localEulerAngles = var_190_6
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_190_7 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_7.x, var_190_7.y, var_190_7.z)

				local var_190_8 = var_190_0.localEulerAngles

				var_190_8.z = 0
				var_190_8.x = 0
				var_190_0.localEulerAngles = var_190_8
			end

			local var_190_9 = arg_187_1.actors_["1199ui_story"]
			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect1199ui_story == nil then
				arg_187_1.var_.characterEffect1199ui_story = var_190_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_11 = 0.200000002980232

			if var_190_10 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_11 and not isNil(var_190_9) then
				local var_190_12 = (arg_187_1.time_ - var_190_10) / var_190_11

				if arg_187_1.var_.characterEffect1199ui_story and not isNil(var_190_9) then
					arg_187_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_10 + var_190_11 and arg_187_1.time_ < var_190_10 + var_190_11 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect1199ui_story then
				arg_187_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_190_13 = 0

			if var_190_13 < arg_187_1.time_ and arg_187_1.time_ <= var_190_13 + arg_190_0 then
				arg_187_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action6_2")
			end

			local var_190_14 = 0

			if var_190_14 < arg_187_1.time_ and arg_187_1.time_ <= var_190_14 + arg_190_0 then
				arg_187_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_190_15 = 0
			local var_190_16 = 0.125

			if var_190_15 < arg_187_1.time_ and arg_187_1.time_ <= var_190_15 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_17 = arg_187_1:FormatText(StoryNameCfg[84].name)

				arg_187_1.leftNameTxt_.text = var_190_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_18 = arg_187_1:GetWordFromCfg(317011045)
				local var_190_19 = arg_187_1:FormatText(var_190_18.content)

				arg_187_1.text_.text = var_190_19

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_20 = 5
				local var_190_21 = utf8.len(var_190_19)
				local var_190_22 = var_190_20 <= 0 and var_190_16 or var_190_16 * (var_190_21 / var_190_20)

				if var_190_22 > 0 and var_190_16 < var_190_22 then
					arg_187_1.talkMaxDuration = var_190_22

					if var_190_22 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_22 + var_190_15
					end
				end

				arg_187_1.text_.text = var_190_19
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317011", "317011045", "story_v_out_317011.awb") ~= 0 then
					local var_190_23 = manager.audio:GetVoiceLength("story_v_out_317011", "317011045", "story_v_out_317011.awb") / 1000

					if var_190_23 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_23 + var_190_15
					end

					if var_190_18.prefab_name ~= "" and arg_187_1.actors_[var_190_18.prefab_name] ~= nil then
						local var_190_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_18.prefab_name].transform, "story_v_out_317011", "317011045", "story_v_out_317011.awb")

						arg_187_1:RecordAudio("317011045", var_190_24)
						arg_187_1:RecordAudio("317011045", var_190_24)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_317011", "317011045", "story_v_out_317011.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_317011", "317011045", "story_v_out_317011.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_25 = math.max(var_190_16, arg_187_1.talkMaxDuration)

			if var_190_15 <= arg_187_1.time_ and arg_187_1.time_ < var_190_15 + var_190_25 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_15) / var_190_25

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_15 + var_190_25 and arg_187_1.time_ < var_190_15 + var_190_25 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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

		arg_187_1:InitPlayNodeList()
	end,
	Play317011046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 317011046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
			arg_191_1.auto_ = false
		end

		function arg_191_1.playNext_(arg_193_0)
			arg_191_1.onStoryFinished_()
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1199ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos1199ui_story = var_194_0.localPosition
			end

			local var_194_2 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2
				local var_194_4 = Vector3.New(0, 100, 0)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1199ui_story, var_194_4, var_194_3)

				local var_194_5 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_5.x, var_194_5.y, var_194_5.z)

				local var_194_6 = var_194_0.localEulerAngles

				var_194_6.z = 0
				var_194_6.x = 0
				var_194_0.localEulerAngles = var_194_6
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0, 100, 0)

				local var_194_7 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_7.x, var_194_7.y, var_194_7.z)

				local var_194_8 = var_194_0.localEulerAngles

				var_194_8.z = 0
				var_194_8.x = 0
				var_194_0.localEulerAngles = var_194_8
			end

			local var_194_9 = manager.ui.mainCamera.transform
			local var_194_10 = 0

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 then
				arg_191_1.var_.shakeOldPos = var_194_9.localPosition
			end

			local var_194_11 = 0.5

			if var_194_10 <= arg_191_1.time_ and arg_191_1.time_ < var_194_10 + var_194_11 then
				local var_194_12 = (arg_191_1.time_ - var_194_10) / 0.066
				local var_194_13, var_194_14 = math.modf(var_194_12)

				var_194_9.localPosition = Vector3.New(var_194_14 * 0.13, var_194_14 * 0.13, var_194_14 * 0.13) + arg_191_1.var_.shakeOldPos
			end

			if arg_191_1.time_ >= var_194_10 + var_194_11 and arg_191_1.time_ < var_194_10 + var_194_11 + arg_194_0 then
				var_194_9.localPosition = arg_191_1.var_.shakeOldPos
			end

			local var_194_15 = manager.ui.mainCamera.transform
			local var_194_16 = 0.333333333333333

			if var_194_16 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 then
				arg_191_1.var_.shakeOldPos = var_194_15.localPosition
			end

			local var_194_17 = 0.5

			if var_194_16 <= arg_191_1.time_ and arg_191_1.time_ < var_194_16 + var_194_17 then
				local var_194_18 = (arg_191_1.time_ - var_194_16) / 0.066
				local var_194_19, var_194_20 = math.modf(var_194_18)

				var_194_15.localPosition = Vector3.New(var_194_20 * 0.13, var_194_20 * 0.13, var_194_20 * 0.13) + arg_191_1.var_.shakeOldPos
			end

			if arg_191_1.time_ >= var_194_16 + var_194_17 and arg_191_1.time_ < var_194_16 + var_194_17 + arg_194_0 then
				var_194_15.localPosition = arg_191_1.var_.shakeOldPos
			end

			local var_194_21 = manager.ui.mainCamera.transform
			local var_194_22 = 0

			if var_194_22 < arg_191_1.time_ and arg_191_1.time_ <= var_194_22 + arg_194_0 then
				local var_194_23 = arg_191_1.var_.effectyuedudaoguang1
				local var_194_24
				local var_194_25 = var_194_21

				if not var_194_23 then
					var_194_23 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_194_25)
					var_194_23.name = "yuedudaoguang1"
					arg_191_1.var_.effectyuedudaoguang1 = var_194_23
				else
					var_194_23.transform:SetParent(var_194_25)
				end

				var_194_23.transform.localPosition = Vector3.New(0, 0, 0)
				var_194_23.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_194_26 = manager.ui.mainCamera.transform
			local var_194_27 = 1

			if var_194_27 < arg_191_1.time_ and arg_191_1.time_ <= var_194_27 + arg_194_0 then
				local var_194_28 = arg_191_1.var_.effectyuedudaoguang1

				if var_194_28 then
					Object.Destroy(var_194_28)

					arg_191_1.var_.effectyuedudaoguang1 = nil
				end
			end

			local var_194_29 = manager.ui.mainCamera.transform
			local var_194_30 = 0

			if var_194_30 < arg_191_1.time_ and arg_191_1.time_ <= var_194_30 + arg_194_0 then
				local var_194_31 = arg_191_1.var_.effectyuedudaoguang1
				local var_194_32
				local var_194_33 = var_194_29

				if not var_194_31 then
					var_194_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_02"), var_194_33)
					var_194_31.name = "yuedudaoguang1"
					arg_191_1.var_.effectyuedudaoguang1 = var_194_31
				else
					var_194_31.transform:SetParent(var_194_33)
				end

				var_194_31.transform.localPosition = Vector3.New(0, 0, 0)
				var_194_31.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_194_34 = manager.ui.mainCamera.transform
			local var_194_35 = 1

			if var_194_35 < arg_191_1.time_ and arg_191_1.time_ <= var_194_35 + arg_194_0 then
				local var_194_36 = arg_191_1.var_.effectyuedudaoguang1

				if var_194_36 then
					Object.Destroy(var_194_36)

					arg_191_1.var_.effectyuedudaoguang1 = nil
				end
			end

			local var_194_37 = 0

			if var_194_37 < arg_191_1.time_ and arg_191_1.time_ <= var_194_37 + arg_194_0 then
				arg_191_1.allBtn_.enabled = false
			end

			local var_194_38 = 1

			if arg_191_1.time_ >= var_194_37 + var_194_38 and arg_191_1.time_ < var_194_37 + var_194_38 + arg_194_0 then
				arg_191_1.allBtn_.enabled = true
			end

			local var_194_39 = 0
			local var_194_40 = 1

			if var_194_39 < arg_191_1.time_ and arg_191_1.time_ <= var_194_39 + arg_194_0 then
				local var_194_41 = "play"
				local var_194_42 = "effect"

				arg_191_1:AudioAction(var_194_41, var_194_42, "se_story_123_01", "se_story_123_01_hit", "")
			end

			local var_194_43 = 0
			local var_194_44 = 0.55

			if var_194_43 < arg_191_1.time_ and arg_191_1.time_ <= var_194_43 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_45 = arg_191_1:GetWordFromCfg(317011046)
				local var_194_46 = arg_191_1:FormatText(var_194_45.content)

				arg_191_1.text_.text = var_194_46

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_47 = 22
				local var_194_48 = utf8.len(var_194_46)
				local var_194_49 = var_194_47 <= 0 and var_194_44 or var_194_44 * (var_194_48 / var_194_47)

				if var_194_49 > 0 and var_194_44 < var_194_49 then
					arg_191_1.talkMaxDuration = var_194_49

					if var_194_49 + var_194_43 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_49 + var_194_43
					end
				end

				arg_191_1.text_.text = var_194_46
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_50 = math.max(var_194_44, arg_191_1.talkMaxDuration)

			if var_194_43 <= arg_191_1.time_ and arg_191_1.time_ < var_194_43 + var_194_50 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_43) / var_194_50

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_43 + var_194_50 and arg_191_1.time_ < var_194_43 + var_194_50 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
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

		arg_191_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C03a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/K11f"
	},
	voices = {
		"story_v_out_317011.awb"
	}
}
