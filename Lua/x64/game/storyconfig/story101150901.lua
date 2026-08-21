return {
	Play115091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115091001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play115091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "G01"

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
				local var_4_5 = arg_1_1.bgs_.G01

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
					if iter_4_0 ~= "G01" then
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

			local var_4_28 = 1.43333333333333
			local var_4_29 = 1.59999999999867

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
			local var_4_35 = 0.7

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

				local var_4_37 = arg_1_1:GetWordFromCfg(115091001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 28
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
	Play115091002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 115091002
		arg_9_1.duration_ = 2.37

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play115091003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1024ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1024ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1024ui_story"), arg_9_1.stage_.transform)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentInChildren(typeof(CharacterEffect))

					var_12_3.enabled = true

					local var_12_4 = GameObjectTools.GetOrAddComponent(var_12_2, typeof(DynamicBoneHelper))

					if var_12_4 then
						var_12_4:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_3.transform, false)

					arg_9_1.var_[var_12_0 .. "Animator"] = var_12_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_0 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_0 .. "LipSync"] = var_12_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_5 = arg_9_1.actors_["1024ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1024ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(-0.7, -1, -6.05)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1024ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(-0.7, -1, -6.05)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = 0

			if var_12_14 < arg_9_1.time_ and arg_9_1.time_ <= var_12_14 + arg_12_0 then
				arg_9_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_12_16 = arg_9_1.actors_["1024ui_story"]
			local var_12_17 = 0

			if var_12_17 < arg_9_1.time_ and arg_9_1.time_ <= var_12_17 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.characterEffect1024ui_story == nil then
				arg_9_1.var_.characterEffect1024ui_story = var_12_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_18 = 0.2

			if var_12_17 <= arg_9_1.time_ and arg_9_1.time_ < var_12_17 + var_12_18 and not isNil(var_12_16) then
				local var_12_19 = (arg_9_1.time_ - var_12_17) / var_12_18

				if arg_9_1.var_.characterEffect1024ui_story and not isNil(var_12_16) then
					arg_9_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_17 + var_12_18 and arg_9_1.time_ < var_12_17 + var_12_18 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.characterEffect1024ui_story then
				arg_9_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_12_20 = 0
			local var_12_21 = 0.05

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[265].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(115091002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 2
				local var_12_26 = utf8.len(var_12_24)
				local var_12_27 = var_12_25 <= 0 and var_12_21 or var_12_21 * (var_12_26 / var_12_25)

				if var_12_27 > 0 and var_12_21 < var_12_27 then
					arg_9_1.talkMaxDuration = var_12_27

					if var_12_27 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_27 + var_12_20
					end
				end

				arg_9_1.text_.text = var_12_24
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091002", "story_v_out_115091.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_115091", "115091002", "story_v_out_115091.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_115091", "115091002", "story_v_out_115091.awb")

						arg_9_1:RecordAudio("115091002", var_12_29)
						arg_9_1:RecordAudio("115091002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_115091", "115091002", "story_v_out_115091.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_115091", "115091002", "story_v_out_115091.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_30 = math.max(var_12_21, arg_9_1.talkMaxDuration)

			if var_12_20 <= arg_9_1.time_ and arg_9_1.time_ < var_12_20 + var_12_30 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_20) / var_12_30

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_20 + var_12_30 and arg_9_1.time_ < var_12_20 + var_12_30 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play115091003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 115091003
		arg_13_1.duration_ = 2.13

		local var_13_0 = {
			ja = 2.133,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_13_0:Play115091004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_16_1 = 0
			local var_16_2 = 0.075

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_3 = arg_13_1:FormatText(StoryNameCfg[265].name)

				arg_13_1.leftNameTxt_.text = var_16_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_4 = arg_13_1:GetWordFromCfg(115091003)
				local var_16_5 = arg_13_1:FormatText(var_16_4.content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 3
				local var_16_7 = utf8.len(var_16_5)
				local var_16_8 = var_16_6 <= 0 and var_16_2 or var_16_2 * (var_16_7 / var_16_6)

				if var_16_8 > 0 and var_16_2 < var_16_8 then
					arg_13_1.talkMaxDuration = var_16_8

					if var_16_8 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091003", "story_v_out_115091.awb") ~= 0 then
					local var_16_9 = manager.audio:GetVoiceLength("story_v_out_115091", "115091003", "story_v_out_115091.awb") / 1000

					if var_16_9 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_1
					end

					if var_16_4.prefab_name ~= "" and arg_13_1.actors_[var_16_4.prefab_name] ~= nil then
						local var_16_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_4.prefab_name].transform, "story_v_out_115091", "115091003", "story_v_out_115091.awb")

						arg_13_1:RecordAudio("115091003", var_16_10)
						arg_13_1:RecordAudio("115091003", var_16_10)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_115091", "115091003", "story_v_out_115091.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_115091", "115091003", "story_v_out_115091.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_11 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_11 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_11

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_11 and arg_13_1.time_ < var_16_1 + var_16_11 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play115091004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 115091004
		arg_17_1.duration_ = 6.23

		local var_17_0 = {
			ja = 4.433,
			ko = 6.233,
			zh = 5.633,
			en = 5.9
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
				arg_17_0:Play115091005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1017ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1017ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1017ui_story"), arg_17_1.stage_.transform)

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

			local var_20_5 = arg_17_1.actors_["1017ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos1017ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(0.7, -1.01, -6.05)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1017ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0.7, -1.01, -6.05)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = 0

			if var_20_14 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action6_1")
			end

			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_20_16 = arg_17_1.actors_["1017ui_story"]
			local var_20_17 = 0

			if var_20_17 < arg_17_1.time_ and arg_17_1.time_ <= var_20_17 + arg_20_0 and not isNil(var_20_16) and arg_17_1.var_.characterEffect1017ui_story == nil then
				arg_17_1.var_.characterEffect1017ui_story = var_20_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_18 = 0.2

			if var_20_17 <= arg_17_1.time_ and arg_17_1.time_ < var_20_17 + var_20_18 and not isNil(var_20_16) then
				local var_20_19 = (arg_17_1.time_ - var_20_17) / var_20_18

				if arg_17_1.var_.characterEffect1017ui_story and not isNil(var_20_16) then
					arg_17_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_17 + var_20_18 and arg_17_1.time_ < var_20_17 + var_20_18 + arg_20_0 and not isNil(var_20_16) and arg_17_1.var_.characterEffect1017ui_story then
				arg_17_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_20_20 = arg_17_1.actors_["1024ui_story"]
			local var_20_21 = 0

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 and not isNil(var_20_20) and arg_17_1.var_.characterEffect1024ui_story == nil then
				arg_17_1.var_.characterEffect1024ui_story = var_20_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_22 = 0.2

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_22 and not isNil(var_20_20) then
				local var_20_23 = (arg_17_1.time_ - var_20_21) / var_20_22

				if arg_17_1.var_.characterEffect1024ui_story and not isNil(var_20_20) then
					local var_20_24 = Mathf.Lerp(0, 0.5, var_20_23)

					arg_17_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1024ui_story.fillRatio = var_20_24
				end
			end

			if arg_17_1.time_ >= var_20_21 + var_20_22 and arg_17_1.time_ < var_20_21 + var_20_22 + arg_20_0 and not isNil(var_20_20) and arg_17_1.var_.characterEffect1024ui_story then
				local var_20_25 = 0.5

				arg_17_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1024ui_story.fillRatio = var_20_25
			end

			local var_20_26 = 0
			local var_20_27 = 0.725

			if var_20_26 < arg_17_1.time_ and arg_17_1.time_ <= var_20_26 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_28 = arg_17_1:FormatText(StoryNameCfg[273].name)

				arg_17_1.leftNameTxt_.text = var_20_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_29 = arg_17_1:GetWordFromCfg(115091004)
				local var_20_30 = arg_17_1:FormatText(var_20_29.content)

				arg_17_1.text_.text = var_20_30

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_31 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091004", "story_v_out_115091.awb") ~= 0 then
					local var_20_34 = manager.audio:GetVoiceLength("story_v_out_115091", "115091004", "story_v_out_115091.awb") / 1000

					if var_20_34 + var_20_26 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_34 + var_20_26
					end

					if var_20_29.prefab_name ~= "" and arg_17_1.actors_[var_20_29.prefab_name] ~= nil then
						local var_20_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_29.prefab_name].transform, "story_v_out_115091", "115091004", "story_v_out_115091.awb")

						arg_17_1:RecordAudio("115091004", var_20_35)
						arg_17_1:RecordAudio("115091004", var_20_35)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_115091", "115091004", "story_v_out_115091.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_115091", "115091004", "story_v_out_115091.awb")
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
				actorName = "1017ui_story",
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
	Play115091005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 115091005
		arg_21_1.duration_ = 9.8

		local var_21_0 = {
			ja = 9.233,
			ko = 9.8,
			zh = 9.633,
			en = 9.766
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
				arg_21_0:Play115091006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_24_1 = 0
			local var_24_2 = 1.125

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_3 = arg_21_1:FormatText(StoryNameCfg[273].name)

				arg_21_1.leftNameTxt_.text = var_24_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(115091005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091005", "story_v_out_115091.awb") ~= 0 then
					local var_24_9 = manager.audio:GetVoiceLength("story_v_out_115091", "115091005", "story_v_out_115091.awb") / 1000

					if var_24_9 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_1
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_115091", "115091005", "story_v_out_115091.awb")

						arg_21_1:RecordAudio("115091005", var_24_10)
						arg_21_1:RecordAudio("115091005", var_24_10)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_115091", "115091005", "story_v_out_115091.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_115091", "115091005", "story_v_out_115091.awb")
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
	Play115091006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 115091006
		arg_25_1.duration_ = 10.33

		local var_25_0 = {
			ja = 10.333,
			ko = 7.466,
			zh = 7.333,
			en = 5.7
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
				arg_25_0:Play115091007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_28_1 = 0
			local var_28_2 = 0.85

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_3 = arg_25_1:FormatText(StoryNameCfg[273].name)

				arg_25_1.leftNameTxt_.text = var_28_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:GetWordFromCfg(115091006)
				local var_28_5 = arg_25_1:FormatText(var_28_4.content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 34
				local var_28_7 = utf8.len(var_28_5)
				local var_28_8 = var_28_6 <= 0 and var_28_2 or var_28_2 * (var_28_7 / var_28_6)

				if var_28_8 > 0 and var_28_2 < var_28_8 then
					arg_25_1.talkMaxDuration = var_28_8

					if var_28_8 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091006", "story_v_out_115091.awb") ~= 0 then
					local var_28_9 = manager.audio:GetVoiceLength("story_v_out_115091", "115091006", "story_v_out_115091.awb") / 1000

					if var_28_9 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_1
					end

					if var_28_4.prefab_name ~= "" and arg_25_1.actors_[var_28_4.prefab_name] ~= nil then
						local var_28_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_4.prefab_name].transform, "story_v_out_115091", "115091006", "story_v_out_115091.awb")

						arg_25_1:RecordAudio("115091006", var_28_10)
						arg_25_1:RecordAudio("115091006", var_28_10)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_115091", "115091006", "story_v_out_115091.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_115091", "115091006", "story_v_out_115091.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_11 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_11 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_11

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_11 and arg_25_1.time_ < var_28_1 + var_28_11 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play115091007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 115091007
		arg_29_1.duration_ = 3.2

		local var_29_0 = {
			ja = 3,
			ko = 2.466,
			zh = 2.5,
			en = 3.2
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
				arg_29_0:Play115091008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1024ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1024ui_story == nil then
				arg_29_1.var_.characterEffect1024ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1024ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1024ui_story then
				arg_29_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_32_4 = 0

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_32_5 = arg_29_1.actors_["1017ui_story"]
			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1017ui_story == nil then
				arg_29_1.var_.characterEffect1017ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_7 = 0.2

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_7 and not isNil(var_32_5) then
				local var_32_8 = (arg_29_1.time_ - var_32_6) / var_32_7

				if arg_29_1.var_.characterEffect1017ui_story and not isNil(var_32_5) then
					local var_32_9 = Mathf.Lerp(0, 0.5, var_32_8)

					arg_29_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1017ui_story.fillRatio = var_32_9
				end
			end

			if arg_29_1.time_ >= var_32_6 + var_32_7 and arg_29_1.time_ < var_32_6 + var_32_7 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1017ui_story then
				local var_32_10 = 0.5

				arg_29_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1017ui_story.fillRatio = var_32_10
			end

			local var_32_11 = 0
			local var_32_12 = 0.25

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_13 = arg_29_1:FormatText(StoryNameCfg[265].name)

				arg_29_1.leftNameTxt_.text = var_32_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_14 = arg_29_1:GetWordFromCfg(115091007)
				local var_32_15 = arg_29_1:FormatText(var_32_14.content)

				arg_29_1.text_.text = var_32_15

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_16 = 10
				local var_32_17 = utf8.len(var_32_15)
				local var_32_18 = var_32_16 <= 0 and var_32_12 or var_32_12 * (var_32_17 / var_32_16)

				if var_32_18 > 0 and var_32_12 < var_32_18 then
					arg_29_1.talkMaxDuration = var_32_18

					if var_32_18 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_11
					end
				end

				arg_29_1.text_.text = var_32_15
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091007", "story_v_out_115091.awb") ~= 0 then
					local var_32_19 = manager.audio:GetVoiceLength("story_v_out_115091", "115091007", "story_v_out_115091.awb") / 1000

					if var_32_19 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_11
					end

					if var_32_14.prefab_name ~= "" and arg_29_1.actors_[var_32_14.prefab_name] ~= nil then
						local var_32_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_14.prefab_name].transform, "story_v_out_115091", "115091007", "story_v_out_115091.awb")

						arg_29_1:RecordAudio("115091007", var_32_20)
						arg_29_1:RecordAudio("115091007", var_32_20)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_115091", "115091007", "story_v_out_115091.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_115091", "115091007", "story_v_out_115091.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_21 = math.max(var_32_12, arg_29_1.talkMaxDuration)

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_21 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_11) / var_32_21

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_11 + var_32_21 and arg_29_1.time_ < var_32_11 + var_32_21 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play115091008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 115091008
		arg_33_1.duration_ = 5.07

		local var_33_0 = {
			ja = 4,
			ko = 5.066,
			zh = 4.066,
			en = 3.033
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
				arg_33_0:Play115091009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action6_2")
			end

			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_36_2 = arg_33_1.actors_["1017ui_story"]
			local var_36_3 = 0

			if var_36_3 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1017ui_story == nil then
				arg_33_1.var_.characterEffect1017ui_story = var_36_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_4 = 0.2

			if var_36_3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_3 + var_36_4 and not isNil(var_36_2) then
				local var_36_5 = (arg_33_1.time_ - var_36_3) / var_36_4

				if arg_33_1.var_.characterEffect1017ui_story and not isNil(var_36_2) then
					arg_33_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_3 + var_36_4 and arg_33_1.time_ < var_36_3 + var_36_4 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1017ui_story then
				arg_33_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_36_6 = arg_33_1.actors_["1024ui_story"]
			local var_36_7 = 0

			if var_36_7 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect1024ui_story == nil then
				arg_33_1.var_.characterEffect1024ui_story = var_36_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_8 = 0.2

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_8 and not isNil(var_36_6) then
				local var_36_9 = (arg_33_1.time_ - var_36_7) / var_36_8

				if arg_33_1.var_.characterEffect1024ui_story and not isNil(var_36_6) then
					local var_36_10 = Mathf.Lerp(0, 0.5, var_36_9)

					arg_33_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1024ui_story.fillRatio = var_36_10
				end
			end

			if arg_33_1.time_ >= var_36_7 + var_36_8 and arg_33_1.time_ < var_36_7 + var_36_8 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect1024ui_story then
				local var_36_11 = 0.5

				arg_33_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1024ui_story.fillRatio = var_36_11
			end

			local var_36_12 = 0
			local var_36_13 = 0.425

			if var_36_12 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_14 = arg_33_1:FormatText(StoryNameCfg[273].name)

				arg_33_1.leftNameTxt_.text = var_36_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_15 = arg_33_1:GetWordFromCfg(115091008)
				local var_36_16 = arg_33_1:FormatText(var_36_15.content)

				arg_33_1.text_.text = var_36_16

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_17 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091008", "story_v_out_115091.awb") ~= 0 then
					local var_36_20 = manager.audio:GetVoiceLength("story_v_out_115091", "115091008", "story_v_out_115091.awb") / 1000

					if var_36_20 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_20 + var_36_12
					end

					if var_36_15.prefab_name ~= "" and arg_33_1.actors_[var_36_15.prefab_name] ~= nil then
						local var_36_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_15.prefab_name].transform, "story_v_out_115091", "115091008", "story_v_out_115091.awb")

						arg_33_1:RecordAudio("115091008", var_36_21)
						arg_33_1:RecordAudio("115091008", var_36_21)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_115091", "115091008", "story_v_out_115091.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_115091", "115091008", "story_v_out_115091.awb")
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
	Play115091009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 115091009
		arg_37_1.duration_ = 9.97

		local var_37_0 = {
			ja = 9.966,
			ko = 4.233,
			zh = 4.733,
			en = 5.233
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
				arg_37_0:Play115091010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_40_1 = 0
			local var_40_2 = 0.6

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_3 = arg_37_1:FormatText(StoryNameCfg[273].name)

				arg_37_1.leftNameTxt_.text = var_40_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(115091009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 24
				local var_40_7 = utf8.len(var_40_5)
				local var_40_8 = var_40_6 <= 0 and var_40_2 or var_40_2 * (var_40_7 / var_40_6)

				if var_40_8 > 0 and var_40_2 < var_40_8 then
					arg_37_1.talkMaxDuration = var_40_8

					if var_40_8 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091009", "story_v_out_115091.awb") ~= 0 then
					local var_40_9 = manager.audio:GetVoiceLength("story_v_out_115091", "115091009", "story_v_out_115091.awb") / 1000

					if var_40_9 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_1
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_out_115091", "115091009", "story_v_out_115091.awb")

						arg_37_1:RecordAudio("115091009", var_40_10)
						arg_37_1:RecordAudio("115091009", var_40_10)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_115091", "115091009", "story_v_out_115091.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_115091", "115091009", "story_v_out_115091.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_11 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_11 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_11

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_11 and arg_37_1.time_ < var_40_1 + var_40_11 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play115091010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 115091010
		arg_41_1.duration_ = 10.03

		local var_41_0 = {
			ja = 10.033,
			ko = 7.933,
			zh = 7.066,
			en = 9.9
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
				arg_41_0:Play115091011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_44_1 = 0
			local var_44_2 = 0.9

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_3 = arg_41_1:FormatText(StoryNameCfg[273].name)

				arg_41_1.leftNameTxt_.text = var_44_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(115091010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_6 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091010", "story_v_out_115091.awb") ~= 0 then
					local var_44_9 = manager.audio:GetVoiceLength("story_v_out_115091", "115091010", "story_v_out_115091.awb") / 1000

					if var_44_9 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_1
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_115091", "115091010", "story_v_out_115091.awb")

						arg_41_1:RecordAudio("115091010", var_44_10)
						arg_41_1:RecordAudio("115091010", var_44_10)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_115091", "115091010", "story_v_out_115091.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_115091", "115091010", "story_v_out_115091.awb")
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
	Play115091011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 115091011
		arg_45_1.duration_ = 5.07

		local var_45_0 = {
			ja = 5.066,
			ko = 3.9,
			zh = 1.999999999999,
			en = 2.133
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
				arg_45_0:Play115091012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1024ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1024ui_story == nil then
				arg_45_1.var_.characterEffect1024ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1024ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1024ui_story then
				arg_45_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_48_4 = 0

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_48_5 = arg_45_1.actors_["1017ui_story"]
			local var_48_6 = 0

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.characterEffect1017ui_story == nil then
				arg_45_1.var_.characterEffect1017ui_story = var_48_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_7 = 0.2

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_7 and not isNil(var_48_5) then
				local var_48_8 = (arg_45_1.time_ - var_48_6) / var_48_7

				if arg_45_1.var_.characterEffect1017ui_story and not isNil(var_48_5) then
					local var_48_9 = Mathf.Lerp(0, 0.5, var_48_8)

					arg_45_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1017ui_story.fillRatio = var_48_9
				end
			end

			if arg_45_1.time_ >= var_48_6 + var_48_7 and arg_45_1.time_ < var_48_6 + var_48_7 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.characterEffect1017ui_story then
				local var_48_10 = 0.5

				arg_45_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1017ui_story.fillRatio = var_48_10
			end

			local var_48_11 = 0
			local var_48_12 = 0.2

			if var_48_11 < arg_45_1.time_ and arg_45_1.time_ <= var_48_11 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_13 = arg_45_1:FormatText(StoryNameCfg[265].name)

				arg_45_1.leftNameTxt_.text = var_48_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_14 = arg_45_1:GetWordFromCfg(115091011)
				local var_48_15 = arg_45_1:FormatText(var_48_14.content)

				arg_45_1.text_.text = var_48_15

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_16 = 8
				local var_48_17 = utf8.len(var_48_15)
				local var_48_18 = var_48_16 <= 0 and var_48_12 or var_48_12 * (var_48_17 / var_48_16)

				if var_48_18 > 0 and var_48_12 < var_48_18 then
					arg_45_1.talkMaxDuration = var_48_18

					if var_48_18 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_11
					end
				end

				arg_45_1.text_.text = var_48_15
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091011", "story_v_out_115091.awb") ~= 0 then
					local var_48_19 = manager.audio:GetVoiceLength("story_v_out_115091", "115091011", "story_v_out_115091.awb") / 1000

					if var_48_19 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_19 + var_48_11
					end

					if var_48_14.prefab_name ~= "" and arg_45_1.actors_[var_48_14.prefab_name] ~= nil then
						local var_48_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_14.prefab_name].transform, "story_v_out_115091", "115091011", "story_v_out_115091.awb")

						arg_45_1:RecordAudio("115091011", var_48_20)
						arg_45_1:RecordAudio("115091011", var_48_20)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_115091", "115091011", "story_v_out_115091.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_115091", "115091011", "story_v_out_115091.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_21 = math.max(var_48_12, arg_45_1.talkMaxDuration)

			if var_48_11 <= arg_45_1.time_ and arg_45_1.time_ < var_48_11 + var_48_21 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_11) / var_48_21

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_11 + var_48_21 and arg_45_1.time_ < var_48_11 + var_48_21 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play115091012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 115091012
		arg_49_1.duration_ = 4.53

		local var_49_0 = {
			ja = 3.466,
			ko = 3.933,
			zh = 4.533,
			en = 3.033
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
				arg_49_0:Play115091013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action4_1")
			end

			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_52_2 = arg_49_1.actors_["1017ui_story"]
			local var_52_3 = 0

			if var_52_3 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1017ui_story == nil then
				arg_49_1.var_.characterEffect1017ui_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_4 = 0.2

			if var_52_3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_3 + var_52_4 and not isNil(var_52_2) then
				local var_52_5 = (arg_49_1.time_ - var_52_3) / var_52_4

				if arg_49_1.var_.characterEffect1017ui_story and not isNil(var_52_2) then
					arg_49_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_3 + var_52_4 and arg_49_1.time_ < var_52_3 + var_52_4 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1017ui_story then
				arg_49_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_52_6 = arg_49_1.actors_["1024ui_story"]
			local var_52_7 = 0

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1024ui_story == nil then
				arg_49_1.var_.characterEffect1024ui_story = var_52_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_8 = 0.2

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_8 and not isNil(var_52_6) then
				local var_52_9 = (arg_49_1.time_ - var_52_7) / var_52_8

				if arg_49_1.var_.characterEffect1024ui_story and not isNil(var_52_6) then
					local var_52_10 = Mathf.Lerp(0, 0.5, var_52_9)

					arg_49_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1024ui_story.fillRatio = var_52_10
				end
			end

			if arg_49_1.time_ >= var_52_7 + var_52_8 and arg_49_1.time_ < var_52_7 + var_52_8 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1024ui_story then
				local var_52_11 = 0.5

				arg_49_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1024ui_story.fillRatio = var_52_11
			end

			local var_52_12 = 0
			local var_52_13 = 0.4

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_14 = arg_49_1:FormatText(StoryNameCfg[273].name)

				arg_49_1.leftNameTxt_.text = var_52_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_15 = arg_49_1:GetWordFromCfg(115091012)
				local var_52_16 = arg_49_1:FormatText(var_52_15.content)

				arg_49_1.text_.text = var_52_16

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_17 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091012", "story_v_out_115091.awb") ~= 0 then
					local var_52_20 = manager.audio:GetVoiceLength("story_v_out_115091", "115091012", "story_v_out_115091.awb") / 1000

					if var_52_20 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_20 + var_52_12
					end

					if var_52_15.prefab_name ~= "" and arg_49_1.actors_[var_52_15.prefab_name] ~= nil then
						local var_52_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_15.prefab_name].transform, "story_v_out_115091", "115091012", "story_v_out_115091.awb")

						arg_49_1:RecordAudio("115091012", var_52_21)
						arg_49_1:RecordAudio("115091012", var_52_21)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_115091", "115091012", "story_v_out_115091.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_115091", "115091012", "story_v_out_115091.awb")
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
	Play115091013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 115091013
		arg_53_1.duration_ = 2

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play115091014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1017ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1017ui_story == nil then
				arg_53_1.var_.characterEffect1017ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1017ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1017ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1017ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1017ui_story.fillRatio = var_56_5
			end

			local var_56_6 = arg_53_1.actors_["1024ui_story"]
			local var_56_7 = 0

			if var_56_7 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect1024ui_story == nil then
				arg_53_1.var_.characterEffect1024ui_story = var_56_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_8 = 0.2

			if var_56_7 <= arg_53_1.time_ and arg_53_1.time_ < var_56_7 + var_56_8 and not isNil(var_56_6) then
				local var_56_9 = (arg_53_1.time_ - var_56_7) / var_56_8

				if arg_53_1.var_.characterEffect1024ui_story and not isNil(var_56_6) then
					arg_53_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_7 + var_56_8 and arg_53_1.time_ < var_56_7 + var_56_8 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect1024ui_story then
				arg_53_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_11 = 0
			local var_56_12 = 0.075

			if var_56_11 < arg_53_1.time_ and arg_53_1.time_ <= var_56_11 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_13 = arg_53_1:FormatText(StoryNameCfg[265].name)

				arg_53_1.leftNameTxt_.text = var_56_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_14 = arg_53_1:GetWordFromCfg(115091013)
				local var_56_15 = arg_53_1:FormatText(var_56_14.content)

				arg_53_1.text_.text = var_56_15

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_16 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091013", "story_v_out_115091.awb") ~= 0 then
					local var_56_19 = manager.audio:GetVoiceLength("story_v_out_115091", "115091013", "story_v_out_115091.awb") / 1000

					if var_56_19 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_19 + var_56_11
					end

					if var_56_14.prefab_name ~= "" and arg_53_1.actors_[var_56_14.prefab_name] ~= nil then
						local var_56_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_14.prefab_name].transform, "story_v_out_115091", "115091013", "story_v_out_115091.awb")

						arg_53_1:RecordAudio("115091013", var_56_20)
						arg_53_1:RecordAudio("115091013", var_56_20)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_115091", "115091013", "story_v_out_115091.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_115091", "115091013", "story_v_out_115091.awb")
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
	Play115091014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 115091014
		arg_57_1.duration_ = 8.2

		local var_57_0 = {
			ja = 8.2,
			ko = 7.633,
			zh = 6.066,
			en = 5
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
				arg_57_0:Play115091015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action4_2")
			end

			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_60_2 = arg_57_1.actors_["1017ui_story"]
			local var_60_3 = 0

			if var_60_3 < arg_57_1.time_ and arg_57_1.time_ <= var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1017ui_story == nil then
				arg_57_1.var_.characterEffect1017ui_story = var_60_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_4 = 0.2

			if var_60_3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_3 + var_60_4 and not isNil(var_60_2) then
				local var_60_5 = (arg_57_1.time_ - var_60_3) / var_60_4

				if arg_57_1.var_.characterEffect1017ui_story and not isNil(var_60_2) then
					arg_57_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_3 + var_60_4 and arg_57_1.time_ < var_60_3 + var_60_4 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1017ui_story then
				arg_57_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_60_6 = arg_57_1.actors_["1024ui_story"]
			local var_60_7 = 0

			if var_60_7 < arg_57_1.time_ and arg_57_1.time_ <= var_60_7 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1024ui_story == nil then
				arg_57_1.var_.characterEffect1024ui_story = var_60_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_8 = 0.2

			if var_60_7 <= arg_57_1.time_ and arg_57_1.time_ < var_60_7 + var_60_8 and not isNil(var_60_6) then
				local var_60_9 = (arg_57_1.time_ - var_60_7) / var_60_8

				if arg_57_1.var_.characterEffect1024ui_story and not isNil(var_60_6) then
					local var_60_10 = Mathf.Lerp(0, 0.5, var_60_9)

					arg_57_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1024ui_story.fillRatio = var_60_10
				end
			end

			if arg_57_1.time_ >= var_60_7 + var_60_8 and arg_57_1.time_ < var_60_7 + var_60_8 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1024ui_story then
				local var_60_11 = 0.5

				arg_57_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1024ui_story.fillRatio = var_60_11
			end

			local var_60_12 = 0
			local var_60_13 = 0.55

			if var_60_12 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_14 = arg_57_1:FormatText(StoryNameCfg[273].name)

				arg_57_1.leftNameTxt_.text = var_60_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_15 = arg_57_1:GetWordFromCfg(115091014)
				local var_60_16 = arg_57_1:FormatText(var_60_15.content)

				arg_57_1.text_.text = var_60_16

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_17 = 22
				local var_60_18 = utf8.len(var_60_16)
				local var_60_19 = var_60_17 <= 0 and var_60_13 or var_60_13 * (var_60_18 / var_60_17)

				if var_60_19 > 0 and var_60_13 < var_60_19 then
					arg_57_1.talkMaxDuration = var_60_19

					if var_60_19 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_19 + var_60_12
					end
				end

				arg_57_1.text_.text = var_60_16
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091014", "story_v_out_115091.awb") ~= 0 then
					local var_60_20 = manager.audio:GetVoiceLength("story_v_out_115091", "115091014", "story_v_out_115091.awb") / 1000

					if var_60_20 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_20 + var_60_12
					end

					if var_60_15.prefab_name ~= "" and arg_57_1.actors_[var_60_15.prefab_name] ~= nil then
						local var_60_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_15.prefab_name].transform, "story_v_out_115091", "115091014", "story_v_out_115091.awb")

						arg_57_1:RecordAudio("115091014", var_60_21)
						arg_57_1:RecordAudio("115091014", var_60_21)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_115091", "115091014", "story_v_out_115091.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_115091", "115091014", "story_v_out_115091.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_22 = math.max(var_60_13, arg_57_1.talkMaxDuration)

			if var_60_12 <= arg_57_1.time_ and arg_57_1.time_ < var_60_12 + var_60_22 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_12) / var_60_22

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_12 + var_60_22 and arg_57_1.time_ < var_60_12 + var_60_22 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play115091015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 115091015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play115091016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1017ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1017ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0, 100, 0)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1017ui_story, var_64_4, var_64_3)

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

			local var_64_9 = arg_61_1.actors_["1024ui_story"].transform
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 then
				arg_61_1.var_.moveOldPos1024ui_story = var_64_9.localPosition
			end

			local var_64_11 = 0.001

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11
				local var_64_13 = Vector3.New(0, 100, 0)

				var_64_9.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1024ui_story, var_64_13, var_64_12)

				local var_64_14 = manager.ui.mainCamera.transform.position - var_64_9.position

				var_64_9.forward = Vector3.New(var_64_14.x, var_64_14.y, var_64_14.z)

				local var_64_15 = var_64_9.localEulerAngles

				var_64_15.z = 0
				var_64_15.x = 0
				var_64_9.localEulerAngles = var_64_15
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 then
				var_64_9.localPosition = Vector3.New(0, 100, 0)

				local var_64_16 = manager.ui.mainCamera.transform.position - var_64_9.position

				var_64_9.forward = Vector3.New(var_64_16.x, var_64_16.y, var_64_16.z)

				local var_64_17 = var_64_9.localEulerAngles

				var_64_17.z = 0
				var_64_17.x = 0
				var_64_9.localEulerAngles = var_64_17
			end

			local var_64_18 = 0
			local var_64_19 = 0.725

			if var_64_18 < arg_61_1.time_ and arg_61_1.time_ <= var_64_18 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_20 = arg_61_1:GetWordFromCfg(115091015)
				local var_64_21 = arg_61_1:FormatText(var_64_20.content)

				arg_61_1.text_.text = var_64_21

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_22 = 29
				local var_64_23 = utf8.len(var_64_21)
				local var_64_24 = var_64_22 <= 0 and var_64_19 or var_64_19 * (var_64_23 / var_64_22)

				if var_64_24 > 0 and var_64_19 < var_64_24 then
					arg_61_1.talkMaxDuration = var_64_24

					if var_64_24 + var_64_18 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_24 + var_64_18
					end
				end

				arg_61_1.text_.text = var_64_21
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_25 = math.max(var_64_19, arg_61_1.talkMaxDuration)

			if var_64_18 <= arg_61_1.time_ and arg_61_1.time_ < var_64_18 + var_64_25 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_18) / var_64_25

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_18 + var_64_25 and arg_61_1.time_ < var_64_18 + var_64_25 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
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
	Play115091016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 115091016
		arg_65_1.duration_ = 6.8

		local var_65_0 = {
			ja = 5.866,
			ko = 6.566,
			zh = 6.8,
			en = 5.933
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
				arg_65_0:Play115091017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1017ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1017ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(-0.7, -1.01, -6.05)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1017ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(-0.7, -1.01, -6.05)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 then
				arg_65_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action4_1")
			end

			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_68_11 = arg_65_1.actors_["1017ui_story"]
			local var_68_12 = 0

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 and not isNil(var_68_11) and arg_65_1.var_.characterEffect1017ui_story == nil then
				arg_65_1.var_.characterEffect1017ui_story = var_68_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_13 = 0.2

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_13 and not isNil(var_68_11) then
				local var_68_14 = (arg_65_1.time_ - var_68_12) / var_68_13

				if arg_65_1.var_.characterEffect1017ui_story and not isNil(var_68_11) then
					arg_65_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_12 + var_68_13 and arg_65_1.time_ < var_68_12 + var_68_13 + arg_68_0 and not isNil(var_68_11) and arg_65_1.var_.characterEffect1017ui_story then
				arg_65_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_68_15 = 0
			local var_68_16 = 0.6

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_17 = arg_65_1:FormatText(StoryNameCfg[273].name)

				arg_65_1.leftNameTxt_.text = var_68_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_18 = arg_65_1:GetWordFromCfg(115091016)
				local var_68_19 = arg_65_1:FormatText(var_68_18.content)

				arg_65_1.text_.text = var_68_19

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_20 = 24
				local var_68_21 = utf8.len(var_68_19)
				local var_68_22 = var_68_20 <= 0 and var_68_16 or var_68_16 * (var_68_21 / var_68_20)

				if var_68_22 > 0 and var_68_16 < var_68_22 then
					arg_65_1.talkMaxDuration = var_68_22

					if var_68_22 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_22 + var_68_15
					end
				end

				arg_65_1.text_.text = var_68_19
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091016", "story_v_out_115091.awb") ~= 0 then
					local var_68_23 = manager.audio:GetVoiceLength("story_v_out_115091", "115091016", "story_v_out_115091.awb") / 1000

					if var_68_23 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_15
					end

					if var_68_18.prefab_name ~= "" and arg_65_1.actors_[var_68_18.prefab_name] ~= nil then
						local var_68_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_18.prefab_name].transform, "story_v_out_115091", "115091016", "story_v_out_115091.awb")

						arg_65_1:RecordAudio("115091016", var_68_24)
						arg_65_1:RecordAudio("115091016", var_68_24)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_115091", "115091016", "story_v_out_115091.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_115091", "115091016", "story_v_out_115091.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_25 = math.max(var_68_16, arg_65_1.talkMaxDuration)

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_25 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_15) / var_68_25

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_15 + var_68_25 and arg_65_1.time_ < var_68_15 + var_68_25 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play115091017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 115091017
		arg_69_1.duration_ = 2

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play115091018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1024ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1024ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(0.7, -1, -6.05)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1024ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = 0

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 then
				arg_69_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_72_11 = arg_69_1.actors_["1024ui_story"]
			local var_72_12 = 0

			if var_72_12 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 and not isNil(var_72_11) and arg_69_1.var_.characterEffect1024ui_story == nil then
				arg_69_1.var_.characterEffect1024ui_story = var_72_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_13 = 0.2

			if var_72_12 <= arg_69_1.time_ and arg_69_1.time_ < var_72_12 + var_72_13 and not isNil(var_72_11) then
				local var_72_14 = (arg_69_1.time_ - var_72_12) / var_72_13

				if arg_69_1.var_.characterEffect1024ui_story and not isNil(var_72_11) then
					arg_69_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_12 + var_72_13 and arg_69_1.time_ < var_72_12 + var_72_13 + arg_72_0 and not isNil(var_72_11) and arg_69_1.var_.characterEffect1024ui_story then
				arg_69_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_72_15 = arg_69_1.actors_["1017ui_story"]
			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 and not isNil(var_72_15) and arg_69_1.var_.characterEffect1017ui_story == nil then
				arg_69_1.var_.characterEffect1017ui_story = var_72_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_17 = 0.2

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_17 and not isNil(var_72_15) then
				local var_72_18 = (arg_69_1.time_ - var_72_16) / var_72_17

				if arg_69_1.var_.characterEffect1017ui_story and not isNil(var_72_15) then
					local var_72_19 = Mathf.Lerp(0, 0.5, var_72_18)

					arg_69_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1017ui_story.fillRatio = var_72_19
				end
			end

			if arg_69_1.time_ >= var_72_16 + var_72_17 and arg_69_1.time_ < var_72_16 + var_72_17 + arg_72_0 and not isNil(var_72_15) and arg_69_1.var_.characterEffect1017ui_story then
				local var_72_20 = 0.5

				arg_69_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1017ui_story.fillRatio = var_72_20
			end

			local var_72_21 = 0
			local var_72_22 = 0.075

			if var_72_21 < arg_69_1.time_ and arg_69_1.time_ <= var_72_21 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_23 = arg_69_1:FormatText(StoryNameCfg[265].name)

				arg_69_1.leftNameTxt_.text = var_72_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_24 = arg_69_1:GetWordFromCfg(115091017)
				local var_72_25 = arg_69_1:FormatText(var_72_24.content)

				arg_69_1.text_.text = var_72_25

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_26 = 3
				local var_72_27 = utf8.len(var_72_25)
				local var_72_28 = var_72_26 <= 0 and var_72_22 or var_72_22 * (var_72_27 / var_72_26)

				if var_72_28 > 0 and var_72_22 < var_72_28 then
					arg_69_1.talkMaxDuration = var_72_28

					if var_72_28 + var_72_21 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_28 + var_72_21
					end
				end

				arg_69_1.text_.text = var_72_25
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091017", "story_v_out_115091.awb") ~= 0 then
					local var_72_29 = manager.audio:GetVoiceLength("story_v_out_115091", "115091017", "story_v_out_115091.awb") / 1000

					if var_72_29 + var_72_21 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_29 + var_72_21
					end

					if var_72_24.prefab_name ~= "" and arg_69_1.actors_[var_72_24.prefab_name] ~= nil then
						local var_72_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_24.prefab_name].transform, "story_v_out_115091", "115091017", "story_v_out_115091.awb")

						arg_69_1:RecordAudio("115091017", var_72_30)
						arg_69_1:RecordAudio("115091017", var_72_30)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_115091", "115091017", "story_v_out_115091.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_115091", "115091017", "story_v_out_115091.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_31 = math.max(var_72_22, arg_69_1.talkMaxDuration)

			if var_72_21 <= arg_69_1.time_ and arg_69_1.time_ < var_72_21 + var_72_31 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_21) / var_72_31

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_21 + var_72_31 and arg_69_1.time_ < var_72_21 + var_72_31 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play115091018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 115091018
		arg_73_1.duration_ = 3.1

		local var_73_0 = {
			ja = 2.366,
			ko = 3.1,
			zh = 2.3,
			en = 2.8
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
				arg_73_0:Play115091019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_76_1 = arg_73_1.actors_["1017ui_story"]
			local var_76_2 = 0

			if var_76_2 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1017ui_story == nil then
				arg_73_1.var_.characterEffect1017ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_3 = 0.2

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_3 and not isNil(var_76_1) then
				local var_76_4 = (arg_73_1.time_ - var_76_2) / var_76_3

				if arg_73_1.var_.characterEffect1017ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_2 + var_76_3 and arg_73_1.time_ < var_76_2 + var_76_3 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1017ui_story then
				arg_73_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_76_5 = 0

			if var_76_5 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action4_2")
			end

			local var_76_6 = arg_73_1.actors_["1024ui_story"]
			local var_76_7 = 0

			if var_76_7 < arg_73_1.time_ and arg_73_1.time_ <= var_76_7 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect1024ui_story == nil then
				arg_73_1.var_.characterEffect1024ui_story = var_76_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_8 = 0.2

			if var_76_7 <= arg_73_1.time_ and arg_73_1.time_ < var_76_7 + var_76_8 and not isNil(var_76_6) then
				local var_76_9 = (arg_73_1.time_ - var_76_7) / var_76_8

				if arg_73_1.var_.characterEffect1024ui_story and not isNil(var_76_6) then
					local var_76_10 = Mathf.Lerp(0, 0.5, var_76_9)

					arg_73_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1024ui_story.fillRatio = var_76_10
				end
			end

			if arg_73_1.time_ >= var_76_7 + var_76_8 and arg_73_1.time_ < var_76_7 + var_76_8 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect1024ui_story then
				local var_76_11 = 0.5

				arg_73_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1024ui_story.fillRatio = var_76_11
			end

			local var_76_12 = 0
			local var_76_13 = 0.2

			if var_76_12 < arg_73_1.time_ and arg_73_1.time_ <= var_76_12 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_14 = arg_73_1:FormatText(StoryNameCfg[273].name)

				arg_73_1.leftNameTxt_.text = var_76_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_15 = arg_73_1:GetWordFromCfg(115091018)
				local var_76_16 = arg_73_1:FormatText(var_76_15.content)

				arg_73_1.text_.text = var_76_16

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_17 = 8
				local var_76_18 = utf8.len(var_76_16)
				local var_76_19 = var_76_17 <= 0 and var_76_13 or var_76_13 * (var_76_18 / var_76_17)

				if var_76_19 > 0 and var_76_13 < var_76_19 then
					arg_73_1.talkMaxDuration = var_76_19

					if var_76_19 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_19 + var_76_12
					end
				end

				arg_73_1.text_.text = var_76_16
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091018", "story_v_out_115091.awb") ~= 0 then
					local var_76_20 = manager.audio:GetVoiceLength("story_v_out_115091", "115091018", "story_v_out_115091.awb") / 1000

					if var_76_20 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_20 + var_76_12
					end

					if var_76_15.prefab_name ~= "" and arg_73_1.actors_[var_76_15.prefab_name] ~= nil then
						local var_76_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_15.prefab_name].transform, "story_v_out_115091", "115091018", "story_v_out_115091.awb")

						arg_73_1:RecordAudio("115091018", var_76_21)
						arg_73_1:RecordAudio("115091018", var_76_21)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_115091", "115091018", "story_v_out_115091.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_115091", "115091018", "story_v_out_115091.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_22 = math.max(var_76_13, arg_73_1.talkMaxDuration)

			if var_76_12 <= arg_73_1.time_ and arg_73_1.time_ < var_76_12 + var_76_22 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_12) / var_76_22

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_12 + var_76_22 and arg_73_1.time_ < var_76_12 + var_76_22 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play115091019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 115091019
		arg_77_1.duration_ = 2.17

		local var_77_0 = {
			ja = 2.166,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_77_0:Play115091020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_80_1 = arg_77_1.actors_["1024ui_story"]
			local var_80_2 = 0

			if var_80_2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1024ui_story == nil then
				arg_77_1.var_.characterEffect1024ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_3 = 0.2

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_3 and not isNil(var_80_1) then
				local var_80_4 = (arg_77_1.time_ - var_80_2) / var_80_3

				if arg_77_1.var_.characterEffect1024ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_2 + var_80_3 and arg_77_1.time_ < var_80_2 + var_80_3 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1024ui_story then
				arg_77_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_80_5 = arg_77_1.actors_["1017ui_story"]
			local var_80_6 = 0

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.characterEffect1017ui_story == nil then
				arg_77_1.var_.characterEffect1017ui_story = var_80_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_7 = 0.2

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_7 and not isNil(var_80_5) then
				local var_80_8 = (arg_77_1.time_ - var_80_6) / var_80_7

				if arg_77_1.var_.characterEffect1017ui_story and not isNil(var_80_5) then
					local var_80_9 = Mathf.Lerp(0, 0.5, var_80_8)

					arg_77_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1017ui_story.fillRatio = var_80_9
				end
			end

			if arg_77_1.time_ >= var_80_6 + var_80_7 and arg_77_1.time_ < var_80_6 + var_80_7 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.characterEffect1017ui_story then
				local var_80_10 = 0.5

				arg_77_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1017ui_story.fillRatio = var_80_10
			end

			local var_80_11 = 0
			local var_80_12 = 0.125

			if var_80_11 < arg_77_1.time_ and arg_77_1.time_ <= var_80_11 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_13 = arg_77_1:FormatText(StoryNameCfg[265].name)

				arg_77_1.leftNameTxt_.text = var_80_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_14 = arg_77_1:GetWordFromCfg(115091019)
				local var_80_15 = arg_77_1:FormatText(var_80_14.content)

				arg_77_1.text_.text = var_80_15

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_16 = 5
				local var_80_17 = utf8.len(var_80_15)
				local var_80_18 = var_80_16 <= 0 and var_80_12 or var_80_12 * (var_80_17 / var_80_16)

				if var_80_18 > 0 and var_80_12 < var_80_18 then
					arg_77_1.talkMaxDuration = var_80_18

					if var_80_18 + var_80_11 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_18 + var_80_11
					end
				end

				arg_77_1.text_.text = var_80_15
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091019", "story_v_out_115091.awb") ~= 0 then
					local var_80_19 = manager.audio:GetVoiceLength("story_v_out_115091", "115091019", "story_v_out_115091.awb") / 1000

					if var_80_19 + var_80_11 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_19 + var_80_11
					end

					if var_80_14.prefab_name ~= "" and arg_77_1.actors_[var_80_14.prefab_name] ~= nil then
						local var_80_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_14.prefab_name].transform, "story_v_out_115091", "115091019", "story_v_out_115091.awb")

						arg_77_1:RecordAudio("115091019", var_80_20)
						arg_77_1:RecordAudio("115091019", var_80_20)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_115091", "115091019", "story_v_out_115091.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_115091", "115091019", "story_v_out_115091.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_21 = math.max(var_80_12, arg_77_1.talkMaxDuration)

			if var_80_11 <= arg_77_1.time_ and arg_77_1.time_ < var_80_11 + var_80_21 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_11) / var_80_21

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_11 + var_80_21 and arg_77_1.time_ < var_80_11 + var_80_21 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play115091020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 115091020
		arg_81_1.duration_ = 4.57

		local var_81_0 = {
			ja = 4.566,
			ko = 2.433,
			zh = 3.166,
			en = 2.9
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
				arg_81_0:Play115091021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_84_1 = arg_81_1.actors_["1017ui_story"]
			local var_84_2 = 0

			if var_84_2 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1017ui_story == nil then
				arg_81_1.var_.characterEffect1017ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_3 = 0.2

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_3 and not isNil(var_84_1) then
				local var_84_4 = (arg_81_1.time_ - var_84_2) / var_84_3

				if arg_81_1.var_.characterEffect1017ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_2 + var_84_3 and arg_81_1.time_ < var_84_2 + var_84_3 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1017ui_story then
				arg_81_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_84_5 = arg_81_1.actors_["1024ui_story"]
			local var_84_6 = 0

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.characterEffect1024ui_story == nil then
				arg_81_1.var_.characterEffect1024ui_story = var_84_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_7 = 0.2

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_7 and not isNil(var_84_5) then
				local var_84_8 = (arg_81_1.time_ - var_84_6) / var_84_7

				if arg_81_1.var_.characterEffect1024ui_story and not isNil(var_84_5) then
					local var_84_9 = Mathf.Lerp(0, 0.5, var_84_8)

					arg_81_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1024ui_story.fillRatio = var_84_9
				end
			end

			if arg_81_1.time_ >= var_84_6 + var_84_7 and arg_81_1.time_ < var_84_6 + var_84_7 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.characterEffect1024ui_story then
				local var_84_10 = 0.5

				arg_81_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1024ui_story.fillRatio = var_84_10
			end

			local var_84_11 = 0
			local var_84_12 = 0.3

			if var_84_11 < arg_81_1.time_ and arg_81_1.time_ <= var_84_11 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_13 = arg_81_1:FormatText(StoryNameCfg[273].name)

				arg_81_1.leftNameTxt_.text = var_84_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_14 = arg_81_1:GetWordFromCfg(115091020)
				local var_84_15 = arg_81_1:FormatText(var_84_14.content)

				arg_81_1.text_.text = var_84_15

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_16 = 12
				local var_84_17 = utf8.len(var_84_15)
				local var_84_18 = var_84_16 <= 0 and var_84_12 or var_84_12 * (var_84_17 / var_84_16)

				if var_84_18 > 0 and var_84_12 < var_84_18 then
					arg_81_1.talkMaxDuration = var_84_18

					if var_84_18 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_18 + var_84_11
					end
				end

				arg_81_1.text_.text = var_84_15
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091020", "story_v_out_115091.awb") ~= 0 then
					local var_84_19 = manager.audio:GetVoiceLength("story_v_out_115091", "115091020", "story_v_out_115091.awb") / 1000

					if var_84_19 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_19 + var_84_11
					end

					if var_84_14.prefab_name ~= "" and arg_81_1.actors_[var_84_14.prefab_name] ~= nil then
						local var_84_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_14.prefab_name].transform, "story_v_out_115091", "115091020", "story_v_out_115091.awb")

						arg_81_1:RecordAudio("115091020", var_84_20)
						arg_81_1:RecordAudio("115091020", var_84_20)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_115091", "115091020", "story_v_out_115091.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_115091", "115091020", "story_v_out_115091.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_21 = math.max(var_84_12, arg_81_1.talkMaxDuration)

			if var_84_11 <= arg_81_1.time_ and arg_81_1.time_ < var_84_11 + var_84_21 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_11) / var_84_21

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_11 + var_84_21 and arg_81_1.time_ < var_84_11 + var_84_21 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play115091021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 115091021
		arg_85_1.duration_ = 3.57

		local var_85_0 = {
			ja = 3.066,
			ko = 3.133,
			zh = 2.8,
			en = 3.566
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
				arg_85_0:Play115091022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_88_1 = arg_85_1.actors_["1024ui_story"]
			local var_88_2 = 0

			if var_88_2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1024ui_story == nil then
				arg_85_1.var_.characterEffect1024ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_3 = 0.2

			if var_88_2 <= arg_85_1.time_ and arg_85_1.time_ < var_88_2 + var_88_3 and not isNil(var_88_1) then
				local var_88_4 = (arg_85_1.time_ - var_88_2) / var_88_3

				if arg_85_1.var_.characterEffect1024ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_2 + var_88_3 and arg_85_1.time_ < var_88_2 + var_88_3 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1024ui_story then
				arg_85_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_88_5 = arg_85_1.actors_["1017ui_story"]
			local var_88_6 = 0

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.characterEffect1017ui_story == nil then
				arg_85_1.var_.characterEffect1017ui_story = var_88_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_7 = 0.2

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_7 and not isNil(var_88_5) then
				local var_88_8 = (arg_85_1.time_ - var_88_6) / var_88_7

				if arg_85_1.var_.characterEffect1017ui_story and not isNil(var_88_5) then
					local var_88_9 = Mathf.Lerp(0, 0.5, var_88_8)

					arg_85_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1017ui_story.fillRatio = var_88_9
				end
			end

			if arg_85_1.time_ >= var_88_6 + var_88_7 and arg_85_1.time_ < var_88_6 + var_88_7 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.characterEffect1017ui_story then
				local var_88_10 = 0.5

				arg_85_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1017ui_story.fillRatio = var_88_10
			end

			local var_88_11 = 0
			local var_88_12 = 0.35

			if var_88_11 < arg_85_1.time_ and arg_85_1.time_ <= var_88_11 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_13 = arg_85_1:FormatText(StoryNameCfg[265].name)

				arg_85_1.leftNameTxt_.text = var_88_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_14 = arg_85_1:GetWordFromCfg(115091021)
				local var_88_15 = arg_85_1:FormatText(var_88_14.content)

				arg_85_1.text_.text = var_88_15

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_16 = 14
				local var_88_17 = utf8.len(var_88_15)
				local var_88_18 = var_88_16 <= 0 and var_88_12 or var_88_12 * (var_88_17 / var_88_16)

				if var_88_18 > 0 and var_88_12 < var_88_18 then
					arg_85_1.talkMaxDuration = var_88_18

					if var_88_18 + var_88_11 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_18 + var_88_11
					end
				end

				arg_85_1.text_.text = var_88_15
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091021", "story_v_out_115091.awb") ~= 0 then
					local var_88_19 = manager.audio:GetVoiceLength("story_v_out_115091", "115091021", "story_v_out_115091.awb") / 1000

					if var_88_19 + var_88_11 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_19 + var_88_11
					end

					if var_88_14.prefab_name ~= "" and arg_85_1.actors_[var_88_14.prefab_name] ~= nil then
						local var_88_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_14.prefab_name].transform, "story_v_out_115091", "115091021", "story_v_out_115091.awb")

						arg_85_1:RecordAudio("115091021", var_88_20)
						arg_85_1:RecordAudio("115091021", var_88_20)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_115091", "115091021", "story_v_out_115091.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_115091", "115091021", "story_v_out_115091.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_21 = math.max(var_88_12, arg_85_1.talkMaxDuration)

			if var_88_11 <= arg_85_1.time_ and arg_85_1.time_ < var_88_11 + var_88_21 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_11) / var_88_21

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_11 + var_88_21 and arg_85_1.time_ < var_88_11 + var_88_21 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play115091022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 115091022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play115091023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_1")
			end

			local var_92_1 = 0
			local var_92_2 = 0.425

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(115091022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 17
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_2 or var_92_2 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_2 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_8 and arg_89_1.time_ < var_92_1 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play115091023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 115091023
		arg_93_1.duration_ = 5.9

		local var_93_0 = {
			ja = 3.666,
			ko = 5.9,
			zh = 4.466,
			en = 3.566
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
				arg_93_0:Play115091024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_96_1 = arg_93_1.actors_["1017ui_story"]
			local var_96_2 = 0

			if var_96_2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1017ui_story == nil then
				arg_93_1.var_.characterEffect1017ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_3 = 0.2

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_3 and not isNil(var_96_1) then
				local var_96_4 = (arg_93_1.time_ - var_96_2) / var_96_3

				if arg_93_1.var_.characterEffect1017ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_2 + var_96_3 and arg_93_1.time_ < var_96_2 + var_96_3 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1017ui_story then
				arg_93_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_96_5 = arg_93_1.actors_["1024ui_story"]
			local var_96_6 = 0

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.characterEffect1024ui_story == nil then
				arg_93_1.var_.characterEffect1024ui_story = var_96_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_7 = 0.2

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_7 and not isNil(var_96_5) then
				local var_96_8 = (arg_93_1.time_ - var_96_6) / var_96_7

				if arg_93_1.var_.characterEffect1024ui_story and not isNil(var_96_5) then
					local var_96_9 = Mathf.Lerp(0, 0.5, var_96_8)

					arg_93_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1024ui_story.fillRatio = var_96_9
				end
			end

			if arg_93_1.time_ >= var_96_6 + var_96_7 and arg_93_1.time_ < var_96_6 + var_96_7 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.characterEffect1024ui_story then
				local var_96_10 = 0.5

				arg_93_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1024ui_story.fillRatio = var_96_10
			end

			local var_96_11 = 0

			if var_96_11 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 then
				arg_93_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action3_1")
			end

			local var_96_12 = 0
			local var_96_13 = 0.375

			if var_96_12 < arg_93_1.time_ and arg_93_1.time_ <= var_96_12 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_14 = arg_93_1:FormatText(StoryNameCfg[273].name)

				arg_93_1.leftNameTxt_.text = var_96_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_15 = arg_93_1:GetWordFromCfg(115091023)
				local var_96_16 = arg_93_1:FormatText(var_96_15.content)

				arg_93_1.text_.text = var_96_16

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_17 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091023", "story_v_out_115091.awb") ~= 0 then
					local var_96_20 = manager.audio:GetVoiceLength("story_v_out_115091", "115091023", "story_v_out_115091.awb") / 1000

					if var_96_20 + var_96_12 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_20 + var_96_12
					end

					if var_96_15.prefab_name ~= "" and arg_93_1.actors_[var_96_15.prefab_name] ~= nil then
						local var_96_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_15.prefab_name].transform, "story_v_out_115091", "115091023", "story_v_out_115091.awb")

						arg_93_1:RecordAudio("115091023", var_96_21)
						arg_93_1:RecordAudio("115091023", var_96_21)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_115091", "115091023", "story_v_out_115091.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_115091", "115091023", "story_v_out_115091.awb")
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
	Play115091024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 115091024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play115091025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1017ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos1017ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0, 100, 0)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1017ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, 100, 0)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["1024ui_story"].transform
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 then
				arg_97_1.var_.moveOldPos1024ui_story = var_100_9.localPosition
			end

			local var_100_11 = 0.001

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11
				local var_100_13 = Vector3.New(0, 100, 0)

				var_100_9.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1024ui_story, var_100_13, var_100_12)

				local var_100_14 = manager.ui.mainCamera.transform.position - var_100_9.position

				var_100_9.forward = Vector3.New(var_100_14.x, var_100_14.y, var_100_14.z)

				local var_100_15 = var_100_9.localEulerAngles

				var_100_15.z = 0
				var_100_15.x = 0
				var_100_9.localEulerAngles = var_100_15
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 then
				var_100_9.localPosition = Vector3.New(0, 100, 0)

				local var_100_16 = manager.ui.mainCamera.transform.position - var_100_9.position

				var_100_9.forward = Vector3.New(var_100_16.x, var_100_16.y, var_100_16.z)

				local var_100_17 = var_100_9.localEulerAngles

				var_100_17.z = 0
				var_100_17.x = 0
				var_100_9.localEulerAngles = var_100_17
			end

			local var_100_18 = 0
			local var_100_19 = 1

			if var_100_18 < arg_97_1.time_ and arg_97_1.time_ <= var_100_18 + arg_100_0 then
				local var_100_20 = "play"
				local var_100_21 = "effect"

				arg_97_1:AudioAction(var_100_20, var_100_21, "se_story_15", "se_story_15_bell", "")
			end

			local var_100_22 = 0
			local var_100_23 = 0.775

			if var_100_22 < arg_97_1.time_ and arg_97_1.time_ <= var_100_22 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_24 = arg_97_1:GetWordFromCfg(115091024)
				local var_100_25 = arg_97_1:FormatText(var_100_24.content)

				arg_97_1.text_.text = var_100_25

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_26 = 31
				local var_100_27 = utf8.len(var_100_25)
				local var_100_28 = var_100_26 <= 0 and var_100_23 or var_100_23 * (var_100_27 / var_100_26)

				if var_100_28 > 0 and var_100_23 < var_100_28 then
					arg_97_1.talkMaxDuration = var_100_28

					if var_100_28 + var_100_22 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_28 + var_100_22
					end
				end

				arg_97_1.text_.text = var_100_25
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_29 = math.max(var_100_23, arg_97_1.talkMaxDuration)

			if var_100_22 <= arg_97_1.time_ and arg_97_1.time_ < var_100_22 + var_100_29 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_22) / var_100_29

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_22 + var_100_29 and arg_97_1.time_ < var_100_22 + var_100_29 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play115091025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 115091025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play115091026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 1.275

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

				local var_104_2 = arg_101_1:GetWordFromCfg(115091025)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 51
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
	Play115091026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 115091026
		arg_105_1.duration_ = 12.77

		local var_105_0 = {
			ja = 10.733333333332,
			ko = 11.466,
			zh = 11.333,
			en = 12.766
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
				arg_105_0:Play115091027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = "RO0301"

			if arg_105_1.bgs_[var_108_0] == nil then
				local var_108_1 = Object.Instantiate(arg_105_1.paintGo_)

				var_108_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_108_0)
				var_108_1.name = var_108_0
				var_108_1.transform.parent = arg_105_1.stage_.transform
				var_108_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.bgs_[var_108_0] = var_108_1
			end

			local var_108_2 = 2

			if var_108_2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				local var_108_3 = manager.ui.mainCamera.transform.localPosition
				local var_108_4 = Vector3.New(0, 0, 10) + Vector3.New(var_108_3.x, var_108_3.y, 0)
				local var_108_5 = arg_105_1.bgs_.RO0301

				var_108_5.transform.localPosition = var_108_4
				var_108_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_6 = var_108_5:GetComponent("SpriteRenderer")

				if var_108_6 and var_108_6.sprite then
					local var_108_7 = (var_108_5.transform.localPosition - var_108_3).z
					local var_108_8 = manager.ui.mainCameraCom_
					local var_108_9 = 2 * var_108_7 * Mathf.Tan(var_108_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_108_10 = var_108_9 * var_108_8.aspect
					local var_108_11 = var_108_6.sprite.bounds.size.x
					local var_108_12 = var_108_6.sprite.bounds.size.y
					local var_108_13 = var_108_10 / var_108_11
					local var_108_14 = var_108_9 / var_108_12
					local var_108_15 = var_108_14 < var_108_13 and var_108_13 or var_108_14

					var_108_5.transform.localScale = Vector3.New(var_108_15, var_108_15, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "RO0301" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_16 = 0

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_17 = 2

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_17 then
				local var_108_18 = (arg_105_1.time_ - var_108_16) / var_108_17
				local var_108_19 = Color.New(0, 0, 0)

				var_108_19.a = Mathf.Lerp(0, 1, var_108_18)
				arg_105_1.mask_.color = var_108_19
			end

			if arg_105_1.time_ >= var_108_16 + var_108_17 and arg_105_1.time_ < var_108_16 + var_108_17 + arg_108_0 then
				local var_108_20 = Color.New(0, 0, 0)

				var_108_20.a = 1
				arg_105_1.mask_.color = var_108_20
			end

			local var_108_21 = 2

			if var_108_21 < arg_105_1.time_ and arg_105_1.time_ <= var_108_21 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_22 = 2

			if var_108_21 <= arg_105_1.time_ and arg_105_1.time_ < var_108_21 + var_108_22 then
				local var_108_23 = (arg_105_1.time_ - var_108_21) / var_108_22
				local var_108_24 = Color.New(0, 0, 0)

				var_108_24.a = Mathf.Lerp(1, 0, var_108_23)
				arg_105_1.mask_.color = var_108_24
			end

			if arg_105_1.time_ >= var_108_21 + var_108_22 and arg_105_1.time_ < var_108_21 + var_108_22 + arg_108_0 then
				local var_108_25 = Color.New(0, 0, 0)
				local var_108_26 = 0

				arg_105_1.mask_.enabled = false
				var_108_25.a = var_108_26
				arg_105_1.mask_.color = var_108_25
			end

			local var_108_27 = arg_105_1.bgs_.RO0301.transform
			local var_108_28 = 2

			if var_108_28 < arg_105_1.time_ and arg_105_1.time_ <= var_108_28 + arg_108_0 then
				arg_105_1.var_.moveOldPosRO0301 = var_108_27.localPosition
			end

			local var_108_29 = 0.001

			if var_108_28 <= arg_105_1.time_ and arg_105_1.time_ < var_108_28 + var_108_29 then
				local var_108_30 = (arg_105_1.time_ - var_108_28) / var_108_29
				local var_108_31 = Vector3.New(5, 0, -0.5)

				var_108_27.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPosRO0301, var_108_31, var_108_30)
			end

			if arg_105_1.time_ >= var_108_28 + var_108_29 and arg_105_1.time_ < var_108_28 + var_108_29 + arg_108_0 then
				var_108_27.localPosition = Vector3.New(5, 0, -0.5)
			end

			local var_108_32 = arg_105_1.bgs_.RO0301.transform
			local var_108_33 = 2.01666666666667

			if var_108_33 < arg_105_1.time_ and arg_105_1.time_ <= var_108_33 + arg_108_0 then
				arg_105_1.var_.moveOldPosRO0301 = var_108_32.localPosition
			end

			local var_108_34 = 7

			if var_108_33 <= arg_105_1.time_ and arg_105_1.time_ < var_108_33 + var_108_34 then
				local var_108_35 = (arg_105_1.time_ - var_108_33) / var_108_34
				local var_108_36 = Vector3.New(5, -0.5, -0.5)

				var_108_32.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPosRO0301, var_108_36, var_108_35)
			end

			if arg_105_1.time_ >= var_108_33 + var_108_34 and arg_105_1.time_ < var_108_33 + var_108_34 + arg_108_0 then
				var_108_32.localPosition = Vector3.New(5, -0.5, -0.5)
			end

			local var_108_37 = 4

			if var_108_37 < arg_105_1.time_ and arg_105_1.time_ <= var_108_37 + arg_108_0 then
				arg_105_1.allBtn_.enabled = false
			end

			local var_108_38 = 5.01666666666667

			if arg_105_1.time_ >= var_108_37 + var_108_38 and arg_105_1.time_ < var_108_37 + var_108_38 + arg_108_0 then
				arg_105_1.allBtn_.enabled = true
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_39 = 4
			local var_108_40 = 0.525

			if var_108_39 < arg_105_1.time_ and arg_105_1.time_ <= var_108_39 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_41 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_41:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_42 = arg_105_1:FormatText(StoryNameCfg[280].name)

				arg_105_1.leftNameTxt_.text = var_108_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_43 = arg_105_1:GetWordFromCfg(115091026)
				local var_108_44 = arg_105_1:FormatText(var_108_43.content)

				arg_105_1.text_.text = var_108_44

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_45 = 21
				local var_108_46 = utf8.len(var_108_44)
				local var_108_47 = var_108_45 <= 0 and var_108_40 or var_108_40 * (var_108_46 / var_108_45)

				if var_108_47 > 0 and var_108_40 < var_108_47 then
					arg_105_1.talkMaxDuration = var_108_47
					var_108_39 = var_108_39 + 0.3

					if var_108_47 + var_108_39 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_47 + var_108_39
					end
				end

				arg_105_1.text_.text = var_108_44
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091026", "story_v_out_115091.awb") ~= 0 then
					local var_108_48 = manager.audio:GetVoiceLength("story_v_out_115091", "115091026", "story_v_out_115091.awb") / 1000

					if var_108_48 + var_108_39 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_48 + var_108_39
					end

					if var_108_43.prefab_name ~= "" and arg_105_1.actors_[var_108_43.prefab_name] ~= nil then
						local var_108_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_43.prefab_name].transform, "story_v_out_115091", "115091026", "story_v_out_115091.awb")

						arg_105_1:RecordAudio("115091026", var_108_49)
						arg_105_1:RecordAudio("115091026", var_108_49)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_115091", "115091026", "story_v_out_115091.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_115091", "115091026", "story_v_out_115091.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_50 = var_108_39 + 0.3
			local var_108_51 = math.max(var_108_40, arg_105_1.talkMaxDuration)

			if var_108_50 <= arg_105_1.time_ and arg_105_1.time_ < var_108_50 + var_108_51 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_50) / var_108_51

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_50 + var_108_51 and arg_105_1.time_ < var_108_50 + var_108_51 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "RO0301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "RO0301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 7,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play115091027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 115091027
		arg_111_1.duration_ = 2.9

		local var_111_0 = {
			ja = 2.9,
			ko = 2.166,
			zh = 2.2,
			en = 1.8
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
				arg_111_0:Play115091028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.175

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[273].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:GetWordFromCfg(115091027)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 7
				local var_114_6 = utf8.len(var_114_4)
				local var_114_7 = var_114_5 <= 0 and var_114_1 or var_114_1 * (var_114_6 / var_114_5)

				if var_114_7 > 0 and var_114_1 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091027", "story_v_out_115091.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_115091", "115091027", "story_v_out_115091.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_115091", "115091027", "story_v_out_115091.awb")

						arg_111_1:RecordAudio("115091027", var_114_9)
						arg_111_1:RecordAudio("115091027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_115091", "115091027", "story_v_out_115091.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_115091", "115091027", "story_v_out_115091.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_10 and arg_111_1.time_ < var_114_0 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play115091028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 115091028
		arg_115_1.duration_ = 9.77

		local var_115_0 = {
			ja = 7.333,
			ko = 8.5,
			zh = 9.766,
			en = 7.633
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
				arg_115_0:Play115091029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_1 = 2

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_1 then
				local var_118_2 = (arg_115_1.time_ - var_118_0) / var_118_1
				local var_118_3 = Color.New(0, 0, 0)

				var_118_3.a = Mathf.Lerp(0, 1, var_118_2)
				arg_115_1.mask_.color = var_118_3
			end

			if arg_115_1.time_ >= var_118_0 + var_118_1 and arg_115_1.time_ < var_118_0 + var_118_1 + arg_118_0 then
				local var_118_4 = Color.New(0, 0, 0)

				var_118_4.a = 1
				arg_115_1.mask_.color = var_118_4
			end

			local var_118_5 = 2

			if var_118_5 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_6 = 2

			if var_118_5 <= arg_115_1.time_ and arg_115_1.time_ < var_118_5 + var_118_6 then
				local var_118_7 = (arg_115_1.time_ - var_118_5) / var_118_6
				local var_118_8 = Color.New(0, 0, 0)

				var_118_8.a = Mathf.Lerp(1, 0, var_118_7)
				arg_115_1.mask_.color = var_118_8
			end

			if arg_115_1.time_ >= var_118_5 + var_118_6 and arg_115_1.time_ < var_118_5 + var_118_6 + arg_118_0 then
				local var_118_9 = Color.New(0, 0, 0)
				local var_118_10 = 0

				arg_115_1.mask_.enabled = false
				var_118_9.a = var_118_10
				arg_115_1.mask_.color = var_118_9
			end

			local var_118_11 = arg_115_1.bgs_.RO0301.transform
			local var_118_12 = 2

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.var_.moveOldPosRO0301 = var_118_11.localPosition
			end

			local var_118_13 = 0.001

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_13 then
				local var_118_14 = (arg_115_1.time_ - var_118_12) / var_118_13
				local var_118_15 = Vector3.New(0, 1, 9.5)

				var_118_11.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPosRO0301, var_118_15, var_118_14)
			end

			if arg_115_1.time_ >= var_118_12 + var_118_13 and arg_115_1.time_ < var_118_12 + var_118_13 + arg_118_0 then
				var_118_11.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_118_16 = arg_115_1.bgs_.RO0301.transform
			local var_118_17 = 2.01666666666667

			if var_118_17 < arg_115_1.time_ and arg_115_1.time_ <= var_118_17 + arg_118_0 then
				arg_115_1.var_.moveOldPosRO0301 = var_118_16.localPosition
			end

			local var_118_18 = 3

			if var_118_17 <= arg_115_1.time_ and arg_115_1.time_ < var_118_17 + var_118_18 then
				local var_118_19 = (arg_115_1.time_ - var_118_17) / var_118_18
				local var_118_20 = Vector3.New(0, 1, 10)

				var_118_16.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPosRO0301, var_118_20, var_118_19)
			end

			if arg_115_1.time_ >= var_118_17 + var_118_18 and arg_115_1.time_ < var_118_17 + var_118_18 + arg_118_0 then
				var_118_16.localPosition = Vector3.New(0, 1, 10)
			end

			local var_118_21 = 4

			if var_118_21 < arg_115_1.time_ and arg_115_1.time_ <= var_118_21 + arg_118_0 then
				arg_115_1.allBtn_.enabled = false
			end

			local var_118_22 = 1.01666666666667

			if arg_115_1.time_ >= var_118_21 + var_118_22 and arg_115_1.time_ < var_118_21 + var_118_22 + arg_118_0 then
				arg_115_1.allBtn_.enabled = true
			end

			if arg_115_1.frameCnt_ <= 1 then
				arg_115_1.dialog_:SetActive(false)
			end

			local var_118_23 = 4
			local var_118_24 = 0.275

			if var_118_23 < arg_115_1.time_ and arg_115_1.time_ <= var_118_23 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				arg_115_1.dialog_:SetActive(true)

				arg_115_1.dialogCg_.alpha = 0

				local var_118_25 = LeanTween.value(arg_115_1.dialog_, 0, 1, 0.3)

				var_118_25:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_115_1.dialogCg_.alpha = arg_119_0
				end))
				var_118_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_115_1.dialog_)
					var_118_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_115_1.duration_ = arg_115_1.duration_ + 0.3

				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_26 = arg_115_1:FormatText(StoryNameCfg[280].name)

				arg_115_1.leftNameTxt_.text = var_118_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_27 = arg_115_1:GetWordFromCfg(115091028)
				local var_118_28 = arg_115_1:FormatText(var_118_27.content)

				arg_115_1.text_.text = var_118_28

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_29 = 11
				local var_118_30 = utf8.len(var_118_28)
				local var_118_31 = var_118_29 <= 0 and var_118_24 or var_118_24 * (var_118_30 / var_118_29)

				if var_118_31 > 0 and var_118_24 < var_118_31 then
					arg_115_1.talkMaxDuration = var_118_31
					var_118_23 = var_118_23 + 0.3

					if var_118_31 + var_118_23 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_31 + var_118_23
					end
				end

				arg_115_1.text_.text = var_118_28
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091028", "story_v_out_115091.awb") ~= 0 then
					local var_118_32 = manager.audio:GetVoiceLength("story_v_out_115091", "115091028", "story_v_out_115091.awb") / 1000

					if var_118_32 + var_118_23 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_32 + var_118_23
					end

					if var_118_27.prefab_name ~= "" and arg_115_1.actors_[var_118_27.prefab_name] ~= nil then
						local var_118_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_27.prefab_name].transform, "story_v_out_115091", "115091028", "story_v_out_115091.awb")

						arg_115_1:RecordAudio("115091028", var_118_33)
						arg_115_1:RecordAudio("115091028", var_118_33)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_115091", "115091028", "story_v_out_115091.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_115091", "115091028", "story_v_out_115091.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_34 = var_118_23 + 0.3
			local var_118_35 = math.max(var_118_24, arg_115_1.talkMaxDuration)

			if var_118_34 <= arg_115_1.time_ and arg_115_1.time_ < var_118_34 + var_118_35 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_34) / var_118_35

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_34 + var_118_35 and arg_115_1.time_ < var_118_34 + var_118_35 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "RO0301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "RO0301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play115091029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 115091029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play115091030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 1.45

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

				local var_124_2 = arg_121_1:GetWordFromCfg(115091029)
				local var_124_3 = arg_121_1:FormatText(var_124_2.content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 58
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
	Play115091030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 115091030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play115091031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.85

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(115091030)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 34
				local var_128_5 = utf8.len(var_128_3)
				local var_128_6 = var_128_4 <= 0 and var_128_1 or var_128_1 * (var_128_5 / var_128_4)

				if var_128_6 > 0 and var_128_1 < var_128_6 then
					arg_125_1.talkMaxDuration = var_128_6

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_7 and arg_125_1.time_ < var_128_0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play115091031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 115091031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play115091032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.95

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_2 = arg_129_1:GetWordFromCfg(115091031)
				local var_132_3 = arg_129_1:FormatText(var_132_2.content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 38
				local var_132_5 = utf8.len(var_132_3)
				local var_132_6 = var_132_4 <= 0 and var_132_1 or var_132_1 * (var_132_5 / var_132_4)

				if var_132_6 > 0 and var_132_1 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_7 and arg_129_1.time_ < var_132_0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play115091032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 115091032
		arg_133_1.duration_ = 7.77

		local var_133_0 = {
			ja = 3.1,
			ko = 6.866,
			zh = 7.266,
			en = 7.766
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
				arg_133_0:Play115091033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.65

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[273].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(115091032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 26
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091032", "story_v_out_115091.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_115091", "115091032", "story_v_out_115091.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_115091", "115091032", "story_v_out_115091.awb")

						arg_133_1:RecordAudio("115091032", var_136_9)
						arg_133_1:RecordAudio("115091032", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_115091", "115091032", "story_v_out_115091.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_115091", "115091032", "story_v_out_115091.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_10 and arg_133_1.time_ < var_136_0 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play115091033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 115091033
		arg_137_1.duration_ = 7.77

		local var_137_0 = {
			ja = 7.766,
			ko = 2.666,
			zh = 1.833,
			en = 1.966
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
				arg_137_0:Play115091034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.175

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[273].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:GetWordFromCfg(115091033)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 7
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091033", "story_v_out_115091.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_115091", "115091033", "story_v_out_115091.awb") / 1000

					if var_140_8 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_0
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_115091", "115091033", "story_v_out_115091.awb")

						arg_137_1:RecordAudio("115091033", var_140_9)
						arg_137_1:RecordAudio("115091033", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_115091", "115091033", "story_v_out_115091.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_115091", "115091033", "story_v_out_115091.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_10 and arg_137_1.time_ < var_140_0 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play115091034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 115091034
		arg_141_1.duration_ = 4.73

		local var_141_0 = {
			ja = 3.9,
			ko = 4.733,
			zh = 3.466,
			en = 3.466
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
				arg_141_0:Play115091035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.175

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[280].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:GetWordFromCfg(115091034)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 7
				local var_144_6 = utf8.len(var_144_4)
				local var_144_7 = var_144_5 <= 0 and var_144_1 or var_144_1 * (var_144_6 / var_144_5)

				if var_144_7 > 0 and var_144_1 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091034", "story_v_out_115091.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_115091", "115091034", "story_v_out_115091.awb") / 1000

					if var_144_8 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_0
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_115091", "115091034", "story_v_out_115091.awb")

						arg_141_1:RecordAudio("115091034", var_144_9)
						arg_141_1:RecordAudio("115091034", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_115091", "115091034", "story_v_out_115091.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_115091", "115091034", "story_v_out_115091.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_10 and arg_141_1.time_ < var_144_0 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play115091035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 115091035
		arg_145_1.duration_ = 6.43

		local var_145_0 = {
			ja = 5.533,
			ko = 6.433,
			zh = 5.6,
			en = 5.033
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play115091036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.6

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[280].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:GetWordFromCfg(115091035)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 24
				local var_148_6 = utf8.len(var_148_4)
				local var_148_7 = var_148_5 <= 0 and var_148_1 or var_148_1 * (var_148_6 / var_148_5)

				if var_148_7 > 0 and var_148_1 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091035", "story_v_out_115091.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_115091", "115091035", "story_v_out_115091.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_115091", "115091035", "story_v_out_115091.awb")

						arg_145_1:RecordAudio("115091035", var_148_9)
						arg_145_1:RecordAudio("115091035", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_115091", "115091035", "story_v_out_115091.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_115091", "115091035", "story_v_out_115091.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_10 and arg_145_1.time_ < var_148_0 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play115091036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 115091036
		arg_149_1.duration_ = 2.6

		local var_149_0 = {
			ja = 2.033,
			ko = 2.1,
			zh = 2.6,
			en = 1.466
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play115091037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.2

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[273].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:GetWordFromCfg(115091036)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 8
				local var_152_6 = utf8.len(var_152_4)
				local var_152_7 = var_152_5 <= 0 and var_152_1 or var_152_1 * (var_152_6 / var_152_5)

				if var_152_7 > 0 and var_152_1 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091036", "story_v_out_115091.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_115091", "115091036", "story_v_out_115091.awb") / 1000

					if var_152_8 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_0
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_115091", "115091036", "story_v_out_115091.awb")

						arg_149_1:RecordAudio("115091036", var_152_9)
						arg_149_1:RecordAudio("115091036", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_115091", "115091036", "story_v_out_115091.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_115091", "115091036", "story_v_out_115091.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_10 and arg_149_1.time_ < var_152_0 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play115091037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 115091037
		arg_153_1.duration_ = 9

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play115091038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 2

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				local var_156_1 = manager.ui.mainCamera.transform.localPosition
				local var_156_2 = Vector3.New(0, 0, 10) + Vector3.New(var_156_1.x, var_156_1.y, 0)
				local var_156_3 = arg_153_1.bgs_.G01

				var_156_3.transform.localPosition = var_156_2
				var_156_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_156_4 = var_156_3:GetComponent("SpriteRenderer")

				if var_156_4 and var_156_4.sprite then
					local var_156_5 = (var_156_3.transform.localPosition - var_156_1).z
					local var_156_6 = manager.ui.mainCameraCom_
					local var_156_7 = 2 * var_156_5 * Mathf.Tan(var_156_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_156_8 = var_156_7 * var_156_6.aspect
					local var_156_9 = var_156_4.sprite.bounds.size.x
					local var_156_10 = var_156_4.sprite.bounds.size.y
					local var_156_11 = var_156_8 / var_156_9
					local var_156_12 = var_156_7 / var_156_10
					local var_156_13 = var_156_12 < var_156_11 and var_156_11 or var_156_12

					var_156_3.transform.localScale = Vector3.New(var_156_13, var_156_13, 0)
				end

				for iter_156_0, iter_156_1 in pairs(arg_153_1.bgs_) do
					if iter_156_0 ~= "G01" then
						iter_156_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_156_14 = 0

			if var_156_14 < arg_153_1.time_ and arg_153_1.time_ <= var_156_14 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_15 = 2

			if var_156_14 <= arg_153_1.time_ and arg_153_1.time_ < var_156_14 + var_156_15 then
				local var_156_16 = (arg_153_1.time_ - var_156_14) / var_156_15
				local var_156_17 = Color.New(0, 0, 0)

				var_156_17.a = Mathf.Lerp(0, 1, var_156_16)
				arg_153_1.mask_.color = var_156_17
			end

			if arg_153_1.time_ >= var_156_14 + var_156_15 and arg_153_1.time_ < var_156_14 + var_156_15 + arg_156_0 then
				local var_156_18 = Color.New(0, 0, 0)

				var_156_18.a = 1
				arg_153_1.mask_.color = var_156_18
			end

			local var_156_19 = 2

			if var_156_19 < arg_153_1.time_ and arg_153_1.time_ <= var_156_19 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_20 = 2

			if var_156_19 <= arg_153_1.time_ and arg_153_1.time_ < var_156_19 + var_156_20 then
				local var_156_21 = (arg_153_1.time_ - var_156_19) / var_156_20
				local var_156_22 = Color.New(0, 0, 0)

				var_156_22.a = Mathf.Lerp(1, 0, var_156_21)
				arg_153_1.mask_.color = var_156_22
			end

			if arg_153_1.time_ >= var_156_19 + var_156_20 and arg_153_1.time_ < var_156_19 + var_156_20 + arg_156_0 then
				local var_156_23 = Color.New(0, 0, 0)
				local var_156_24 = 0

				arg_153_1.mask_.enabled = false
				var_156_23.a = var_156_24
				arg_153_1.mask_.color = var_156_23
			end

			if arg_153_1.frameCnt_ <= 1 then
				arg_153_1.dialog_:SetActive(false)
			end

			local var_156_25 = 4
			local var_156_26 = 0.575

			if var_156_25 < arg_153_1.time_ and arg_153_1.time_ <= var_156_25 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				arg_153_1.dialog_:SetActive(true)

				arg_153_1.dialogCg_.alpha = 0

				local var_156_27 = LeanTween.value(arg_153_1.dialog_, 0, 1, 0.3)

				var_156_27:setOnUpdate(LuaHelper.FloatAction(function(arg_157_0)
					arg_153_1.dialogCg_.alpha = arg_157_0
				end))
				var_156_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_153_1.dialog_)
					var_156_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_153_1.duration_ = arg_153_1.duration_ + 0.3

				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_28 = arg_153_1:GetWordFromCfg(115091037)
				local var_156_29 = arg_153_1:FormatText(var_156_28.content)

				arg_153_1.text_.text = var_156_29

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_30 = 23
				local var_156_31 = utf8.len(var_156_29)
				local var_156_32 = var_156_30 <= 0 and var_156_26 or var_156_26 * (var_156_31 / var_156_30)

				if var_156_32 > 0 and var_156_26 < var_156_32 then
					arg_153_1.talkMaxDuration = var_156_32
					var_156_25 = var_156_25 + 0.3

					if var_156_32 + var_156_25 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_32 + var_156_25
					end
				end

				arg_153_1.text_.text = var_156_29
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_33 = var_156_25 + 0.3
			local var_156_34 = math.max(var_156_26, arg_153_1.talkMaxDuration)

			if var_156_33 <= arg_153_1.time_ and arg_153_1.time_ < var_156_33 + var_156_34 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_33) / var_156_34

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_33 + var_156_34 and arg_153_1.time_ < var_156_33 + var_156_34 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play115091038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 115091038
		arg_159_1.duration_ = 13

		local var_159_0 = {
			ja = 4.5,
			ko = 13,
			zh = 11.7,
			en = 10
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
				arg_159_0:Play115091039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 1.025

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[280].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:GetWordFromCfg(115091038)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 41
				local var_162_6 = utf8.len(var_162_4)
				local var_162_7 = var_162_5 <= 0 and var_162_1 or var_162_1 * (var_162_6 / var_162_5)

				if var_162_7 > 0 and var_162_1 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091038", "story_v_out_115091.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_115091", "115091038", "story_v_out_115091.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_115091", "115091038", "story_v_out_115091.awb")

						arg_159_1:RecordAudio("115091038", var_162_9)
						arg_159_1:RecordAudio("115091038", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_115091", "115091038", "story_v_out_115091.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_115091", "115091038", "story_v_out_115091.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_10 and arg_159_1.time_ < var_162_0 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play115091039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 115091039
		arg_163_1.duration_ = 2.23

		local var_163_0 = {
			ja = 1.999999999999,
			ko = 2.233,
			zh = 1.999999999999,
			en = 2.133
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
				arg_163_0:Play115091040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1017ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos1017ui_story = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(0, -1.01, -6.05)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1017ui_story, var_166_4, var_166_3)

				local var_166_5 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_5.x, var_166_5.y, var_166_5.z)

				local var_166_6 = var_166_0.localEulerAngles

				var_166_6.z = 0
				var_166_6.x = 0
				var_166_0.localEulerAngles = var_166_6
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, -1.01, -6.05)

				local var_166_7 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_7.x, var_166_7.y, var_166_7.z)

				local var_166_8 = var_166_0.localEulerAngles

				var_166_8.z = 0
				var_166_8.x = 0
				var_166_0.localEulerAngles = var_166_8
			end

			local var_166_9 = 0

			if var_166_9 < arg_163_1.time_ and arg_163_1.time_ <= var_166_9 + arg_166_0 then
				arg_163_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action6_1")
			end

			local var_166_10 = 0

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 then
				arg_163_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_166_11 = arg_163_1.actors_["1017ui_story"]
			local var_166_12 = 0

			if var_166_12 < arg_163_1.time_ and arg_163_1.time_ <= var_166_12 + arg_166_0 and not isNil(var_166_11) and arg_163_1.var_.characterEffect1017ui_story == nil then
				arg_163_1.var_.characterEffect1017ui_story = var_166_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_13 = 0.2

			if var_166_12 <= arg_163_1.time_ and arg_163_1.time_ < var_166_12 + var_166_13 and not isNil(var_166_11) then
				local var_166_14 = (arg_163_1.time_ - var_166_12) / var_166_13

				if arg_163_1.var_.characterEffect1017ui_story and not isNil(var_166_11) then
					arg_163_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_12 + var_166_13 and arg_163_1.time_ < var_166_12 + var_166_13 + arg_166_0 and not isNil(var_166_11) and arg_163_1.var_.characterEffect1017ui_story then
				arg_163_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_166_15 = 0
			local var_166_16 = 0.15

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_17 = arg_163_1:FormatText(StoryNameCfg[273].name)

				arg_163_1.leftNameTxt_.text = var_166_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_18 = arg_163_1:GetWordFromCfg(115091039)
				local var_166_19 = arg_163_1:FormatText(var_166_18.content)

				arg_163_1.text_.text = var_166_19

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_20 = 6
				local var_166_21 = utf8.len(var_166_19)
				local var_166_22 = var_166_20 <= 0 and var_166_16 or var_166_16 * (var_166_21 / var_166_20)

				if var_166_22 > 0 and var_166_16 < var_166_22 then
					arg_163_1.talkMaxDuration = var_166_22

					if var_166_22 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_22 + var_166_15
					end
				end

				arg_163_1.text_.text = var_166_19
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091039", "story_v_out_115091.awb") ~= 0 then
					local var_166_23 = manager.audio:GetVoiceLength("story_v_out_115091", "115091039", "story_v_out_115091.awb") / 1000

					if var_166_23 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_23 + var_166_15
					end

					if var_166_18.prefab_name ~= "" and arg_163_1.actors_[var_166_18.prefab_name] ~= nil then
						local var_166_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_18.prefab_name].transform, "story_v_out_115091", "115091039", "story_v_out_115091.awb")

						arg_163_1:RecordAudio("115091039", var_166_24)
						arg_163_1:RecordAudio("115091039", var_166_24)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_115091", "115091039", "story_v_out_115091.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_115091", "115091039", "story_v_out_115091.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_25 = math.max(var_166_16, arg_163_1.talkMaxDuration)

			if var_166_15 <= arg_163_1.time_ and arg_163_1.time_ < var_166_15 + var_166_25 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_15) / var_166_25

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_15 + var_166_25 and arg_163_1.time_ < var_166_15 + var_166_25 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play115091040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 115091040
		arg_167_1.duration_ = 9

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play115091041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.mask_.enabled = true
				arg_167_1.mask_.raycastTarget = true

				arg_167_1:SetGaussion(false)
			end

			local var_170_1 = 2

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_1 then
				local var_170_2 = (arg_167_1.time_ - var_170_0) / var_170_1
				local var_170_3 = Color.New(0, 0, 0)

				var_170_3.a = Mathf.Lerp(0, 1, var_170_2)
				arg_167_1.mask_.color = var_170_3
			end

			if arg_167_1.time_ >= var_170_0 + var_170_1 and arg_167_1.time_ < var_170_0 + var_170_1 + arg_170_0 then
				local var_170_4 = Color.New(0, 0, 0)

				var_170_4.a = 1
				arg_167_1.mask_.color = var_170_4
			end

			local var_170_5 = 2

			if var_170_5 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 then
				arg_167_1.mask_.enabled = true
				arg_167_1.mask_.raycastTarget = true

				arg_167_1:SetGaussion(false)
			end

			local var_170_6 = 2

			if var_170_5 <= arg_167_1.time_ and arg_167_1.time_ < var_170_5 + var_170_6 then
				local var_170_7 = (arg_167_1.time_ - var_170_5) / var_170_6
				local var_170_8 = Color.New(0, 0, 0)

				var_170_8.a = Mathf.Lerp(1, 0, var_170_7)
				arg_167_1.mask_.color = var_170_8
			end

			if arg_167_1.time_ >= var_170_5 + var_170_6 and arg_167_1.time_ < var_170_5 + var_170_6 + arg_170_0 then
				local var_170_9 = Color.New(0, 0, 0)
				local var_170_10 = 0

				arg_167_1.mask_.enabled = false
				var_170_9.a = var_170_10
				arg_167_1.mask_.color = var_170_9
			end

			local var_170_11 = "G03a"

			if arg_167_1.bgs_[var_170_11] == nil then
				local var_170_12 = Object.Instantiate(arg_167_1.paintGo_)

				var_170_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_170_11)
				var_170_12.name = var_170_11
				var_170_12.transform.parent = arg_167_1.stage_.transform
				var_170_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_167_1.bgs_[var_170_11] = var_170_12
			end

			local var_170_13 = 2

			if var_170_13 < arg_167_1.time_ and arg_167_1.time_ <= var_170_13 + arg_170_0 then
				local var_170_14 = manager.ui.mainCamera.transform.localPosition
				local var_170_15 = Vector3.New(0, 0, 10) + Vector3.New(var_170_14.x, var_170_14.y, 0)
				local var_170_16 = arg_167_1.bgs_.G03a

				var_170_16.transform.localPosition = var_170_15
				var_170_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_170_17 = var_170_16:GetComponent("SpriteRenderer")

				if var_170_17 and var_170_17.sprite then
					local var_170_18 = (var_170_16.transform.localPosition - var_170_14).z
					local var_170_19 = manager.ui.mainCameraCom_
					local var_170_20 = 2 * var_170_18 * Mathf.Tan(var_170_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_170_21 = var_170_20 * var_170_19.aspect
					local var_170_22 = var_170_17.sprite.bounds.size.x
					local var_170_23 = var_170_17.sprite.bounds.size.y
					local var_170_24 = var_170_21 / var_170_22
					local var_170_25 = var_170_20 / var_170_23
					local var_170_26 = var_170_25 < var_170_24 and var_170_24 or var_170_25

					var_170_16.transform.localScale = Vector3.New(var_170_26, var_170_26, 0)
				end

				for iter_170_0, iter_170_1 in pairs(arg_167_1.bgs_) do
					if iter_170_0 ~= "G03a" then
						iter_170_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_170_27 = arg_167_1.actors_["1017ui_story"].transform
			local var_170_28 = 1.966

			if var_170_28 < arg_167_1.time_ and arg_167_1.time_ <= var_170_28 + arg_170_0 then
				arg_167_1.var_.moveOldPos1017ui_story = var_170_27.localPosition
			end

			local var_170_29 = 0.001

			if var_170_28 <= arg_167_1.time_ and arg_167_1.time_ < var_170_28 + var_170_29 then
				local var_170_30 = (arg_167_1.time_ - var_170_28) / var_170_29
				local var_170_31 = Vector3.New(0, 100, 0)

				var_170_27.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1017ui_story, var_170_31, var_170_30)

				local var_170_32 = manager.ui.mainCamera.transform.position - var_170_27.position

				var_170_27.forward = Vector3.New(var_170_32.x, var_170_32.y, var_170_32.z)

				local var_170_33 = var_170_27.localEulerAngles

				var_170_33.z = 0
				var_170_33.x = 0
				var_170_27.localEulerAngles = var_170_33
			end

			if arg_167_1.time_ >= var_170_28 + var_170_29 and arg_167_1.time_ < var_170_28 + var_170_29 + arg_170_0 then
				var_170_27.localPosition = Vector3.New(0, 100, 0)

				local var_170_34 = manager.ui.mainCamera.transform.position - var_170_27.position

				var_170_27.forward = Vector3.New(var_170_34.x, var_170_34.y, var_170_34.z)

				local var_170_35 = var_170_27.localEulerAngles

				var_170_35.z = 0
				var_170_35.x = 0
				var_170_27.localEulerAngles = var_170_35
			end

			if arg_167_1.frameCnt_ <= 1 then
				arg_167_1.dialog_:SetActive(false)
			end

			local var_170_36 = 4
			local var_170_37 = 0.85

			if var_170_36 < arg_167_1.time_ and arg_167_1.time_ <= var_170_36 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0

				arg_167_1.dialog_:SetActive(true)

				arg_167_1.dialogCg_.alpha = 0

				local var_170_38 = LeanTween.value(arg_167_1.dialog_, 0, 1, 0.3)

				var_170_38:setOnUpdate(LuaHelper.FloatAction(function(arg_171_0)
					arg_167_1.dialogCg_.alpha = arg_171_0
				end))
				var_170_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_167_1.dialog_)
					var_170_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_167_1.duration_ = arg_167_1.duration_ + 0.3

				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_39 = arg_167_1:GetWordFromCfg(115091040)
				local var_170_40 = arg_167_1:FormatText(var_170_39.content)

				arg_167_1.text_.text = var_170_40

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_41 = 34
				local var_170_42 = utf8.len(var_170_40)
				local var_170_43 = var_170_41 <= 0 and var_170_37 or var_170_37 * (var_170_42 / var_170_41)

				if var_170_43 > 0 and var_170_37 < var_170_43 then
					arg_167_1.talkMaxDuration = var_170_43
					var_170_36 = var_170_36 + 0.3

					if var_170_43 + var_170_36 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_43 + var_170_36
					end
				end

				arg_167_1.text_.text = var_170_40
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_44 = var_170_36 + 0.3
			local var_170_45 = math.max(var_170_37, arg_167_1.talkMaxDuration)

			if var_170_44 <= arg_167_1.time_ and arg_167_1.time_ < var_170_44 + var_170_45 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_44) / var_170_45

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_44 + var_170_45 and arg_167_1.time_ < var_170_44 + var_170_45 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play115091041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 115091041
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play115091042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 1.075

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_2 = arg_173_1:GetWordFromCfg(115091041)
				local var_176_3 = arg_173_1:FormatText(var_176_2.content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 43
				local var_176_5 = utf8.len(var_176_3)
				local var_176_6 = var_176_4 <= 0 and var_176_1 or var_176_1 * (var_176_5 / var_176_4)

				if var_176_6 > 0 and var_176_1 < var_176_6 then
					arg_173_1.talkMaxDuration = var_176_6

					if var_176_6 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_6 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_7 and arg_173_1.time_ < var_176_0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play115091042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 115091042
		arg_177_1.duration_ = 4.8

		local var_177_0 = {
			ja = 4.666,
			ko = 4.066,
			zh = 4.8,
			en = 3.933
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play115091043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = "2074ui_story"

			if arg_177_1.actors_[var_180_0] == nil then
				local var_180_1 = Asset.Load("Char/" .. "2074ui_story")

				if not isNil(var_180_1) then
					local var_180_2 = Object.Instantiate(Asset.Load("Char/" .. "2074ui_story"), arg_177_1.stage_.transform)

					var_180_2.name = var_180_0
					var_180_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_177_1.actors_[var_180_0] = var_180_2

					local var_180_3 = var_180_2:GetComponentInChildren(typeof(CharacterEffect))

					var_180_3.enabled = true

					local var_180_4 = GameObjectTools.GetOrAddComponent(var_180_2, typeof(DynamicBoneHelper))

					if var_180_4 then
						var_180_4:EnableDynamicBone(false)
					end

					arg_177_1:ShowWeapon(var_180_3.transform, false)

					arg_177_1.var_[var_180_0 .. "Animator"] = var_180_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_177_1.var_[var_180_0 .. "Animator"].applyRootMotion = true
					arg_177_1.var_[var_180_0 .. "LipSync"] = var_180_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_180_5 = arg_177_1.actors_["2074ui_story"].transform
			local var_180_6 = 0

			if var_180_6 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.var_.moveOldPos2074ui_story = var_180_5.localPosition
			end

			local var_180_7 = 0.001

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_7 then
				local var_180_8 = (arg_177_1.time_ - var_180_6) / var_180_7
				local var_180_9 = Vector3.New(-0.7, -1.18, -4.93)

				var_180_5.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos2074ui_story, var_180_9, var_180_8)

				local var_180_10 = manager.ui.mainCamera.transform.position - var_180_5.position

				var_180_5.forward = Vector3.New(var_180_10.x, var_180_10.y, var_180_10.z)

				local var_180_11 = var_180_5.localEulerAngles

				var_180_11.z = 0
				var_180_11.x = 0
				var_180_5.localEulerAngles = var_180_11
			end

			if arg_177_1.time_ >= var_180_6 + var_180_7 and arg_177_1.time_ < var_180_6 + var_180_7 + arg_180_0 then
				var_180_5.localPosition = Vector3.New(-0.7, -1.18, -4.93)

				local var_180_12 = manager.ui.mainCamera.transform.position - var_180_5.position

				var_180_5.forward = Vector3.New(var_180_12.x, var_180_12.y, var_180_12.z)

				local var_180_13 = var_180_5.localEulerAngles

				var_180_13.z = 0
				var_180_13.x = 0
				var_180_5.localEulerAngles = var_180_13
			end

			local var_180_14 = 0

			if var_180_14 < arg_177_1.time_ and arg_177_1.time_ <= var_180_14 + arg_180_0 then
				arg_177_1:PlayTimeline("2074ui_story", "StoryTimeline/CharAction/story2074/story2074action/2074action1_1")
			end

			local var_180_15 = arg_177_1.actors_["2074ui_story"]
			local var_180_16 = 0

			if var_180_16 < arg_177_1.time_ and arg_177_1.time_ <= var_180_16 + arg_180_0 and not isNil(var_180_15) and arg_177_1.var_.characterEffect2074ui_story == nil then
				arg_177_1.var_.characterEffect2074ui_story = var_180_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_17 = 0.2

			if var_180_16 <= arg_177_1.time_ and arg_177_1.time_ < var_180_16 + var_180_17 and not isNil(var_180_15) then
				local var_180_18 = (arg_177_1.time_ - var_180_16) / var_180_17

				if arg_177_1.var_.characterEffect2074ui_story and not isNil(var_180_15) then
					arg_177_1.var_.characterEffect2074ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_16 + var_180_17 and arg_177_1.time_ < var_180_16 + var_180_17 + arg_180_0 and not isNil(var_180_15) and arg_177_1.var_.characterEffect2074ui_story then
				arg_177_1.var_.characterEffect2074ui_story.fillFlat = false
			end

			local var_180_19 = 0
			local var_180_20 = 0.475

			if var_180_19 < arg_177_1.time_ and arg_177_1.time_ <= var_180_19 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_21 = arg_177_1:FormatText(StoryNameCfg[280].name)

				arg_177_1.leftNameTxt_.text = var_180_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_22 = arg_177_1:GetWordFromCfg(115091042)
				local var_180_23 = arg_177_1:FormatText(var_180_22.content)

				arg_177_1.text_.text = var_180_23

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_24 = 19
				local var_180_25 = utf8.len(var_180_23)
				local var_180_26 = var_180_24 <= 0 and var_180_20 or var_180_20 * (var_180_25 / var_180_24)

				if var_180_26 > 0 and var_180_20 < var_180_26 then
					arg_177_1.talkMaxDuration = var_180_26

					if var_180_26 + var_180_19 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_26 + var_180_19
					end
				end

				arg_177_1.text_.text = var_180_23
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091042", "story_v_out_115091.awb") ~= 0 then
					local var_180_27 = manager.audio:GetVoiceLength("story_v_out_115091", "115091042", "story_v_out_115091.awb") / 1000

					if var_180_27 + var_180_19 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_27 + var_180_19
					end

					if var_180_22.prefab_name ~= "" and arg_177_1.actors_[var_180_22.prefab_name] ~= nil then
						local var_180_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_22.prefab_name].transform, "story_v_out_115091", "115091042", "story_v_out_115091.awb")

						arg_177_1:RecordAudio("115091042", var_180_28)
						arg_177_1:RecordAudio("115091042", var_180_28)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_115091", "115091042", "story_v_out_115091.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_115091", "115091042", "story_v_out_115091.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_29 = math.max(var_180_20, arg_177_1.talkMaxDuration)

			if var_180_19 <= arg_177_1.time_ and arg_177_1.time_ < var_180_19 + var_180_29 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_19) / var_180_29

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_19 + var_180_29 and arg_177_1.time_ < var_180_19 + var_180_29 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play115091043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 115091043
		arg_181_1.duration_ = 7.57

		local var_181_0 = {
			ja = 7.566,
			ko = 7.566,
			zh = 5.8,
			en = 5.6
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play115091044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1017ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1017ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0.7, -1.01, -6.05)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1017ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0.7, -1.01, -6.05)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = 0

			if var_184_9 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 then
				arg_181_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action1_1")
			end

			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 then
				arg_181_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_184_11 = arg_181_1.actors_["1017ui_story"]
			local var_184_12 = 0

			if var_184_12 < arg_181_1.time_ and arg_181_1.time_ <= var_184_12 + arg_184_0 and not isNil(var_184_11) and arg_181_1.var_.characterEffect1017ui_story == nil then
				arg_181_1.var_.characterEffect1017ui_story = var_184_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_13 = 0.2

			if var_184_12 <= arg_181_1.time_ and arg_181_1.time_ < var_184_12 + var_184_13 and not isNil(var_184_11) then
				local var_184_14 = (arg_181_1.time_ - var_184_12) / var_184_13

				if arg_181_1.var_.characterEffect1017ui_story and not isNil(var_184_11) then
					arg_181_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_12 + var_184_13 and arg_181_1.time_ < var_184_12 + var_184_13 + arg_184_0 and not isNil(var_184_11) and arg_181_1.var_.characterEffect1017ui_story then
				arg_181_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_184_15 = arg_181_1.actors_["2074ui_story"]
			local var_184_16 = 0

			if var_184_16 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 and not isNil(var_184_15) and arg_181_1.var_.characterEffect2074ui_story == nil then
				arg_181_1.var_.characterEffect2074ui_story = var_184_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_17 = 0.2

			if var_184_16 <= arg_181_1.time_ and arg_181_1.time_ < var_184_16 + var_184_17 and not isNil(var_184_15) then
				local var_184_18 = (arg_181_1.time_ - var_184_16) / var_184_17

				if arg_181_1.var_.characterEffect2074ui_story and not isNil(var_184_15) then
					local var_184_19 = Mathf.Lerp(0, 0.5, var_184_18)

					arg_181_1.var_.characterEffect2074ui_story.fillFlat = true
					arg_181_1.var_.characterEffect2074ui_story.fillRatio = var_184_19
				end
			end

			if arg_181_1.time_ >= var_184_16 + var_184_17 and arg_181_1.time_ < var_184_16 + var_184_17 + arg_184_0 and not isNil(var_184_15) and arg_181_1.var_.characterEffect2074ui_story then
				local var_184_20 = 0.5

				arg_181_1.var_.characterEffect2074ui_story.fillFlat = true
				arg_181_1.var_.characterEffect2074ui_story.fillRatio = var_184_20
			end

			local var_184_21 = 0
			local var_184_22 = 0.675

			if var_184_21 < arg_181_1.time_ and arg_181_1.time_ <= var_184_21 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_23 = arg_181_1:FormatText(StoryNameCfg[273].name)

				arg_181_1.leftNameTxt_.text = var_184_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_24 = arg_181_1:GetWordFromCfg(115091043)
				local var_184_25 = arg_181_1:FormatText(var_184_24.content)

				arg_181_1.text_.text = var_184_25

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_26 = 27
				local var_184_27 = utf8.len(var_184_25)
				local var_184_28 = var_184_26 <= 0 and var_184_22 or var_184_22 * (var_184_27 / var_184_26)

				if var_184_28 > 0 and var_184_22 < var_184_28 then
					arg_181_1.talkMaxDuration = var_184_28

					if var_184_28 + var_184_21 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_28 + var_184_21
					end
				end

				arg_181_1.text_.text = var_184_25
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091043", "story_v_out_115091.awb") ~= 0 then
					local var_184_29 = manager.audio:GetVoiceLength("story_v_out_115091", "115091043", "story_v_out_115091.awb") / 1000

					if var_184_29 + var_184_21 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_29 + var_184_21
					end

					if var_184_24.prefab_name ~= "" and arg_181_1.actors_[var_184_24.prefab_name] ~= nil then
						local var_184_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_24.prefab_name].transform, "story_v_out_115091", "115091043", "story_v_out_115091.awb")

						arg_181_1:RecordAudio("115091043", var_184_30)
						arg_181_1:RecordAudio("115091043", var_184_30)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_115091", "115091043", "story_v_out_115091.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_115091", "115091043", "story_v_out_115091.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_31 = math.max(var_184_22, arg_181_1.talkMaxDuration)

			if var_184_21 <= arg_181_1.time_ and arg_181_1.time_ < var_184_21 + var_184_31 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_21) / var_184_31

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_21 + var_184_31 and arg_181_1.time_ < var_184_21 + var_184_31 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play115091044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 115091044
		arg_185_1.duration_ = 13.4

		local var_185_0 = {
			ja = 6.666,
			ko = 11,
			zh = 10.266,
			en = 13.4
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play115091045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1017ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1017ui_story == nil then
				arg_185_1.var_.characterEffect1017ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.2

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect1017ui_story and not isNil(var_188_0) then
					local var_188_4 = Mathf.Lerp(0, 0.5, var_188_3)

					arg_185_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1017ui_story.fillRatio = var_188_4
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1017ui_story then
				local var_188_5 = 0.5

				arg_185_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1017ui_story.fillRatio = var_188_5
			end

			local var_188_6 = arg_185_1.actors_["2074ui_story"]
			local var_188_7 = 0

			if var_188_7 < arg_185_1.time_ and arg_185_1.time_ <= var_188_7 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect2074ui_story == nil then
				arg_185_1.var_.characterEffect2074ui_story = var_188_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_8 = 0.2

			if var_188_7 <= arg_185_1.time_ and arg_185_1.time_ < var_188_7 + var_188_8 and not isNil(var_188_6) then
				local var_188_9 = (arg_185_1.time_ - var_188_7) / var_188_8

				if arg_185_1.var_.characterEffect2074ui_story and not isNil(var_188_6) then
					arg_185_1.var_.characterEffect2074ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_7 + var_188_8 and arg_185_1.time_ < var_188_7 + var_188_8 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect2074ui_story then
				arg_185_1.var_.characterEffect2074ui_story.fillFlat = false
			end

			local var_188_10 = 0

			if var_188_10 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 then
				arg_185_1:PlayTimeline("2074ui_story", "StoryTimeline/CharAction/story2074/story2074action/2074action1_1")
			end

			local var_188_11 = 0
			local var_188_12 = 1.05

			if var_188_11 < arg_185_1.time_ and arg_185_1.time_ <= var_188_11 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_13 = arg_185_1:FormatText(StoryNameCfg[280].name)

				arg_185_1.leftNameTxt_.text = var_188_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_14 = arg_185_1:GetWordFromCfg(115091044)
				local var_188_15 = arg_185_1:FormatText(var_188_14.content)

				arg_185_1.text_.text = var_188_15

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_16 = 42
				local var_188_17 = utf8.len(var_188_15)
				local var_188_18 = var_188_16 <= 0 and var_188_12 or var_188_12 * (var_188_17 / var_188_16)

				if var_188_18 > 0 and var_188_12 < var_188_18 then
					arg_185_1.talkMaxDuration = var_188_18

					if var_188_18 + var_188_11 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_18 + var_188_11
					end
				end

				arg_185_1.text_.text = var_188_15
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091044", "story_v_out_115091.awb") ~= 0 then
					local var_188_19 = manager.audio:GetVoiceLength("story_v_out_115091", "115091044", "story_v_out_115091.awb") / 1000

					if var_188_19 + var_188_11 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_19 + var_188_11
					end

					if var_188_14.prefab_name ~= "" and arg_185_1.actors_[var_188_14.prefab_name] ~= nil then
						local var_188_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_14.prefab_name].transform, "story_v_out_115091", "115091044", "story_v_out_115091.awb")

						arg_185_1:RecordAudio("115091044", var_188_20)
						arg_185_1:RecordAudio("115091044", var_188_20)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_115091", "115091044", "story_v_out_115091.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_115091", "115091044", "story_v_out_115091.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_21 = math.max(var_188_12, arg_185_1.talkMaxDuration)

			if var_188_11 <= arg_185_1.time_ and arg_185_1.time_ < var_188_11 + var_188_21 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_11) / var_188_21

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_11 + var_188_21 and arg_185_1.time_ < var_188_11 + var_188_21 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play115091045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 115091045
		arg_189_1.duration_ = 7.57

		local var_189_0 = {
			ja = 5.133,
			ko = 7.566,
			zh = 5.4,
			en = 5.933
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play115091046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action6_1")
			end

			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_192_2 = arg_189_1.actors_["1017ui_story"]
			local var_192_3 = 0

			if var_192_3 < arg_189_1.time_ and arg_189_1.time_ <= var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect1017ui_story == nil then
				arg_189_1.var_.characterEffect1017ui_story = var_192_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_4 = 0.2

			if var_192_3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_3 + var_192_4 and not isNil(var_192_2) then
				local var_192_5 = (arg_189_1.time_ - var_192_3) / var_192_4

				if arg_189_1.var_.characterEffect1017ui_story and not isNil(var_192_2) then
					arg_189_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_3 + var_192_4 and arg_189_1.time_ < var_192_3 + var_192_4 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect1017ui_story then
				arg_189_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_192_6 = arg_189_1.actors_["2074ui_story"]
			local var_192_7 = 0

			if var_192_7 < arg_189_1.time_ and arg_189_1.time_ <= var_192_7 + arg_192_0 and not isNil(var_192_6) and arg_189_1.var_.characterEffect2074ui_story == nil then
				arg_189_1.var_.characterEffect2074ui_story = var_192_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_8 = 0.2

			if var_192_7 <= arg_189_1.time_ and arg_189_1.time_ < var_192_7 + var_192_8 and not isNil(var_192_6) then
				local var_192_9 = (arg_189_1.time_ - var_192_7) / var_192_8

				if arg_189_1.var_.characterEffect2074ui_story and not isNil(var_192_6) then
					local var_192_10 = Mathf.Lerp(0, 0.5, var_192_9)

					arg_189_1.var_.characterEffect2074ui_story.fillFlat = true
					arg_189_1.var_.characterEffect2074ui_story.fillRatio = var_192_10
				end
			end

			if arg_189_1.time_ >= var_192_7 + var_192_8 and arg_189_1.time_ < var_192_7 + var_192_8 + arg_192_0 and not isNil(var_192_6) and arg_189_1.var_.characterEffect2074ui_story then
				local var_192_11 = 0.5

				arg_189_1.var_.characterEffect2074ui_story.fillFlat = true
				arg_189_1.var_.characterEffect2074ui_story.fillRatio = var_192_11
			end

			local var_192_12 = 0
			local var_192_13 = 0.575

			if var_192_12 < arg_189_1.time_ and arg_189_1.time_ <= var_192_12 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_14 = arg_189_1:FormatText(StoryNameCfg[273].name)

				arg_189_1.leftNameTxt_.text = var_192_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_15 = arg_189_1:GetWordFromCfg(115091045)
				local var_192_16 = arg_189_1:FormatText(var_192_15.content)

				arg_189_1.text_.text = var_192_16

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_17 = 23
				local var_192_18 = utf8.len(var_192_16)
				local var_192_19 = var_192_17 <= 0 and var_192_13 or var_192_13 * (var_192_18 / var_192_17)

				if var_192_19 > 0 and var_192_13 < var_192_19 then
					arg_189_1.talkMaxDuration = var_192_19

					if var_192_19 + var_192_12 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_19 + var_192_12
					end
				end

				arg_189_1.text_.text = var_192_16
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091045", "story_v_out_115091.awb") ~= 0 then
					local var_192_20 = manager.audio:GetVoiceLength("story_v_out_115091", "115091045", "story_v_out_115091.awb") / 1000

					if var_192_20 + var_192_12 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_20 + var_192_12
					end

					if var_192_15.prefab_name ~= "" and arg_189_1.actors_[var_192_15.prefab_name] ~= nil then
						local var_192_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_15.prefab_name].transform, "story_v_out_115091", "115091045", "story_v_out_115091.awb")

						arg_189_1:RecordAudio("115091045", var_192_21)
						arg_189_1:RecordAudio("115091045", var_192_21)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_115091", "115091045", "story_v_out_115091.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_115091", "115091045", "story_v_out_115091.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_22 = math.max(var_192_13, arg_189_1.talkMaxDuration)

			if var_192_12 <= arg_189_1.time_ and arg_189_1.time_ < var_192_12 + var_192_22 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_12) / var_192_22

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_12 + var_192_22 and arg_189_1.time_ < var_192_12 + var_192_22 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play115091046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 115091046
		arg_193_1.duration_ = 3.4

		local var_193_0 = {
			ja = 3.4,
			ko = 2.1,
			zh = 1.999999999999,
			en = 3.4
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play115091047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1017ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1017ui_story == nil then
				arg_193_1.var_.characterEffect1017ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.2

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect1017ui_story and not isNil(var_196_0) then
					local var_196_4 = Mathf.Lerp(0, 0.5, var_196_3)

					arg_193_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1017ui_story.fillRatio = var_196_4
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1017ui_story then
				local var_196_5 = 0.5

				arg_193_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1017ui_story.fillRatio = var_196_5
			end

			local var_196_6 = arg_193_1.actors_["2074ui_story"]
			local var_196_7 = 0

			if var_196_7 < arg_193_1.time_ and arg_193_1.time_ <= var_196_7 + arg_196_0 and not isNil(var_196_6) and arg_193_1.var_.characterEffect2074ui_story == nil then
				arg_193_1.var_.characterEffect2074ui_story = var_196_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_8 = 0.2

			if var_196_7 <= arg_193_1.time_ and arg_193_1.time_ < var_196_7 + var_196_8 and not isNil(var_196_6) then
				local var_196_9 = (arg_193_1.time_ - var_196_7) / var_196_8

				if arg_193_1.var_.characterEffect2074ui_story and not isNil(var_196_6) then
					arg_193_1.var_.characterEffect2074ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_7 + var_196_8 and arg_193_1.time_ < var_196_7 + var_196_8 + arg_196_0 and not isNil(var_196_6) and arg_193_1.var_.characterEffect2074ui_story then
				arg_193_1.var_.characterEffect2074ui_story.fillFlat = false
			end

			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 then
				arg_193_1:PlayTimeline("2074ui_story", "StoryTimeline/CharAction/story2074/story2074action/2074action1_1")
			end

			local var_196_11 = 0
			local var_196_12 = 0.2

			if var_196_11 < arg_193_1.time_ and arg_193_1.time_ <= var_196_11 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_13 = arg_193_1:FormatText(StoryNameCfg[280].name)

				arg_193_1.leftNameTxt_.text = var_196_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_14 = arg_193_1:GetWordFromCfg(115091046)
				local var_196_15 = arg_193_1:FormatText(var_196_14.content)

				arg_193_1.text_.text = var_196_15

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_16 = 8
				local var_196_17 = utf8.len(var_196_15)
				local var_196_18 = var_196_16 <= 0 and var_196_12 or var_196_12 * (var_196_17 / var_196_16)

				if var_196_18 > 0 and var_196_12 < var_196_18 then
					arg_193_1.talkMaxDuration = var_196_18

					if var_196_18 + var_196_11 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_18 + var_196_11
					end
				end

				arg_193_1.text_.text = var_196_15
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091046", "story_v_out_115091.awb") ~= 0 then
					local var_196_19 = manager.audio:GetVoiceLength("story_v_out_115091", "115091046", "story_v_out_115091.awb") / 1000

					if var_196_19 + var_196_11 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_19 + var_196_11
					end

					if var_196_14.prefab_name ~= "" and arg_193_1.actors_[var_196_14.prefab_name] ~= nil then
						local var_196_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_14.prefab_name].transform, "story_v_out_115091", "115091046", "story_v_out_115091.awb")

						arg_193_1:RecordAudio("115091046", var_196_20)
						arg_193_1:RecordAudio("115091046", var_196_20)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_115091", "115091046", "story_v_out_115091.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_115091", "115091046", "story_v_out_115091.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_21 = math.max(var_196_12, arg_193_1.talkMaxDuration)

			if var_196_11 <= arg_193_1.time_ and arg_193_1.time_ < var_196_11 + var_196_21 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_11) / var_196_21

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_11 + var_196_21 and arg_193_1.time_ < var_196_11 + var_196_21 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play115091047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 115091047
		arg_197_1.duration_ = 3.3

		local var_197_0 = {
			ja = 2.033,
			ko = 3.066,
			zh = 3.3,
			en = 2.066
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play115091048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_200_1 = arg_197_1.actors_["1017ui_story"]
			local var_200_2 = 0

			if var_200_2 < arg_197_1.time_ and arg_197_1.time_ <= var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1017ui_story == nil then
				arg_197_1.var_.characterEffect1017ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_3 = 0.2

			if var_200_2 <= arg_197_1.time_ and arg_197_1.time_ < var_200_2 + var_200_3 and not isNil(var_200_1) then
				local var_200_4 = (arg_197_1.time_ - var_200_2) / var_200_3

				if arg_197_1.var_.characterEffect1017ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_2 + var_200_3 and arg_197_1.time_ < var_200_2 + var_200_3 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1017ui_story then
				arg_197_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_200_5 = arg_197_1.actors_["2074ui_story"]
			local var_200_6 = 0

			if var_200_6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.characterEffect2074ui_story == nil then
				arg_197_1.var_.characterEffect2074ui_story = var_200_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_7 = 0.2

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_7 and not isNil(var_200_5) then
				local var_200_8 = (arg_197_1.time_ - var_200_6) / var_200_7

				if arg_197_1.var_.characterEffect2074ui_story and not isNil(var_200_5) then
					local var_200_9 = Mathf.Lerp(0, 0.5, var_200_8)

					arg_197_1.var_.characterEffect2074ui_story.fillFlat = true
					arg_197_1.var_.characterEffect2074ui_story.fillRatio = var_200_9
				end
			end

			if arg_197_1.time_ >= var_200_6 + var_200_7 and arg_197_1.time_ < var_200_6 + var_200_7 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.characterEffect2074ui_story then
				local var_200_10 = 0.5

				arg_197_1.var_.characterEffect2074ui_story.fillFlat = true
				arg_197_1.var_.characterEffect2074ui_story.fillRatio = var_200_10
			end

			local var_200_11 = 0
			local var_200_12 = 0.375

			if var_200_11 < arg_197_1.time_ and arg_197_1.time_ <= var_200_11 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_13 = arg_197_1:FormatText(StoryNameCfg[273].name)

				arg_197_1.leftNameTxt_.text = var_200_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_14 = arg_197_1:GetWordFromCfg(115091047)
				local var_200_15 = arg_197_1:FormatText(var_200_14.content)

				arg_197_1.text_.text = var_200_15

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_16 = 15
				local var_200_17 = utf8.len(var_200_15)
				local var_200_18 = var_200_16 <= 0 and var_200_12 or var_200_12 * (var_200_17 / var_200_16)

				if var_200_18 > 0 and var_200_12 < var_200_18 then
					arg_197_1.talkMaxDuration = var_200_18

					if var_200_18 + var_200_11 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_18 + var_200_11
					end
				end

				arg_197_1.text_.text = var_200_15
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091047", "story_v_out_115091.awb") ~= 0 then
					local var_200_19 = manager.audio:GetVoiceLength("story_v_out_115091", "115091047", "story_v_out_115091.awb") / 1000

					if var_200_19 + var_200_11 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_19 + var_200_11
					end

					if var_200_14.prefab_name ~= "" and arg_197_1.actors_[var_200_14.prefab_name] ~= nil then
						local var_200_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_14.prefab_name].transform, "story_v_out_115091", "115091047", "story_v_out_115091.awb")

						arg_197_1:RecordAudio("115091047", var_200_20)
						arg_197_1:RecordAudio("115091047", var_200_20)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_115091", "115091047", "story_v_out_115091.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_115091", "115091047", "story_v_out_115091.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_21 = math.max(var_200_12, arg_197_1.talkMaxDuration)

			if var_200_11 <= arg_197_1.time_ and arg_197_1.time_ < var_200_11 + var_200_21 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_11) / var_200_21

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_11 + var_200_21 and arg_197_1.time_ < var_200_11 + var_200_21 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play115091048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 115091048
		arg_201_1.duration_ = 14.97

		local var_201_0 = {
			ja = 12,
			ko = 14.966,
			zh = 10.7,
			en = 12.633
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play115091049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1017ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1017ui_story == nil then
				arg_201_1.var_.characterEffect1017ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.2

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect1017ui_story and not isNil(var_204_0) then
					local var_204_4 = Mathf.Lerp(0, 0.5, var_204_3)

					arg_201_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1017ui_story.fillRatio = var_204_4
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1017ui_story then
				local var_204_5 = 0.5

				arg_201_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1017ui_story.fillRatio = var_204_5
			end

			local var_204_6 = arg_201_1.actors_["2074ui_story"]
			local var_204_7 = 0

			if var_204_7 < arg_201_1.time_ and arg_201_1.time_ <= var_204_7 + arg_204_0 and not isNil(var_204_6) and arg_201_1.var_.characterEffect2074ui_story == nil then
				arg_201_1.var_.characterEffect2074ui_story = var_204_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_8 = 0.2

			if var_204_7 <= arg_201_1.time_ and arg_201_1.time_ < var_204_7 + var_204_8 and not isNil(var_204_6) then
				local var_204_9 = (arg_201_1.time_ - var_204_7) / var_204_8

				if arg_201_1.var_.characterEffect2074ui_story and not isNil(var_204_6) then
					arg_201_1.var_.characterEffect2074ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_7 + var_204_8 and arg_201_1.time_ < var_204_7 + var_204_8 + arg_204_0 and not isNil(var_204_6) and arg_201_1.var_.characterEffect2074ui_story then
				arg_201_1.var_.characterEffect2074ui_story.fillFlat = false
			end

			local var_204_10 = 0
			local var_204_11 = 1.175

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_12 = arg_201_1:FormatText(StoryNameCfg[280].name)

				arg_201_1.leftNameTxt_.text = var_204_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_13 = arg_201_1:GetWordFromCfg(115091048)
				local var_204_14 = arg_201_1:FormatText(var_204_13.content)

				arg_201_1.text_.text = var_204_14

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_15 = 47
				local var_204_16 = utf8.len(var_204_14)
				local var_204_17 = var_204_15 <= 0 and var_204_11 or var_204_11 * (var_204_16 / var_204_15)

				if var_204_17 > 0 and var_204_11 < var_204_17 then
					arg_201_1.talkMaxDuration = var_204_17

					if var_204_17 + var_204_10 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_17 + var_204_10
					end
				end

				arg_201_1.text_.text = var_204_14
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091048", "story_v_out_115091.awb") ~= 0 then
					local var_204_18 = manager.audio:GetVoiceLength("story_v_out_115091", "115091048", "story_v_out_115091.awb") / 1000

					if var_204_18 + var_204_10 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_18 + var_204_10
					end

					if var_204_13.prefab_name ~= "" and arg_201_1.actors_[var_204_13.prefab_name] ~= nil then
						local var_204_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_13.prefab_name].transform, "story_v_out_115091", "115091048", "story_v_out_115091.awb")

						arg_201_1:RecordAudio("115091048", var_204_19)
						arg_201_1:RecordAudio("115091048", var_204_19)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_115091", "115091048", "story_v_out_115091.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_115091", "115091048", "story_v_out_115091.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_20 = math.max(var_204_11, arg_201_1.talkMaxDuration)

			if var_204_10 <= arg_201_1.time_ and arg_201_1.time_ < var_204_10 + var_204_20 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_10) / var_204_20

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_10 + var_204_20 and arg_201_1.time_ < var_204_10 + var_204_20 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play115091049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 115091049
		arg_205_1.duration_ = 4.07

		local var_205_0 = {
			ja = 4.066,
			ko = 2.533,
			zh = 1.999999999999,
			en = 3.566
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
				arg_205_0:Play115091050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_208_1 = arg_205_1.actors_["1017ui_story"]
			local var_208_2 = 0

			if var_208_2 < arg_205_1.time_ and arg_205_1.time_ <= var_208_2 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1017ui_story == nil then
				arg_205_1.var_.characterEffect1017ui_story = var_208_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_3 = 0.2

			if var_208_2 <= arg_205_1.time_ and arg_205_1.time_ < var_208_2 + var_208_3 and not isNil(var_208_1) then
				local var_208_4 = (arg_205_1.time_ - var_208_2) / var_208_3

				if arg_205_1.var_.characterEffect1017ui_story and not isNil(var_208_1) then
					arg_205_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_2 + var_208_3 and arg_205_1.time_ < var_208_2 + var_208_3 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1017ui_story then
				arg_205_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_208_5 = arg_205_1.actors_["2074ui_story"]
			local var_208_6 = 0

			if var_208_6 < arg_205_1.time_ and arg_205_1.time_ <= var_208_6 + arg_208_0 and not isNil(var_208_5) and arg_205_1.var_.characterEffect2074ui_story == nil then
				arg_205_1.var_.characterEffect2074ui_story = var_208_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_7 = 0.2

			if var_208_6 <= arg_205_1.time_ and arg_205_1.time_ < var_208_6 + var_208_7 and not isNil(var_208_5) then
				local var_208_8 = (arg_205_1.time_ - var_208_6) / var_208_7

				if arg_205_1.var_.characterEffect2074ui_story and not isNil(var_208_5) then
					local var_208_9 = Mathf.Lerp(0, 0.5, var_208_8)

					arg_205_1.var_.characterEffect2074ui_story.fillFlat = true
					arg_205_1.var_.characterEffect2074ui_story.fillRatio = var_208_9
				end
			end

			if arg_205_1.time_ >= var_208_6 + var_208_7 and arg_205_1.time_ < var_208_6 + var_208_7 + arg_208_0 and not isNil(var_208_5) and arg_205_1.var_.characterEffect2074ui_story then
				local var_208_10 = 0.5

				arg_205_1.var_.characterEffect2074ui_story.fillFlat = true
				arg_205_1.var_.characterEffect2074ui_story.fillRatio = var_208_10
			end

			local var_208_11 = 0

			if var_208_11 < arg_205_1.time_ and arg_205_1.time_ <= var_208_11 + arg_208_0 then
				arg_205_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action6_2")
			end

			local var_208_12 = 0
			local var_208_13 = 0.125

			if var_208_12 < arg_205_1.time_ and arg_205_1.time_ <= var_208_12 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_14 = arg_205_1:FormatText(StoryNameCfg[273].name)

				arg_205_1.leftNameTxt_.text = var_208_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_15 = arg_205_1:GetWordFromCfg(115091049)
				local var_208_16 = arg_205_1:FormatText(var_208_15.content)

				arg_205_1.text_.text = var_208_16

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_17 = 5
				local var_208_18 = utf8.len(var_208_16)
				local var_208_19 = var_208_17 <= 0 and var_208_13 or var_208_13 * (var_208_18 / var_208_17)

				if var_208_19 > 0 and var_208_13 < var_208_19 then
					arg_205_1.talkMaxDuration = var_208_19

					if var_208_19 + var_208_12 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_19 + var_208_12
					end
				end

				arg_205_1.text_.text = var_208_16
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091049", "story_v_out_115091.awb") ~= 0 then
					local var_208_20 = manager.audio:GetVoiceLength("story_v_out_115091", "115091049", "story_v_out_115091.awb") / 1000

					if var_208_20 + var_208_12 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_20 + var_208_12
					end

					if var_208_15.prefab_name ~= "" and arg_205_1.actors_[var_208_15.prefab_name] ~= nil then
						local var_208_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_15.prefab_name].transform, "story_v_out_115091", "115091049", "story_v_out_115091.awb")

						arg_205_1:RecordAudio("115091049", var_208_21)
						arg_205_1:RecordAudio("115091049", var_208_21)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_115091", "115091049", "story_v_out_115091.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_115091", "115091049", "story_v_out_115091.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_22 = math.max(var_208_13, arg_205_1.talkMaxDuration)

			if var_208_12 <= arg_205_1.time_ and arg_205_1.time_ < var_208_12 + var_208_22 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_12) / var_208_22

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_12 + var_208_22 and arg_205_1.time_ < var_208_12 + var_208_22 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play115091050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 115091050
		arg_209_1.duration_ = 10.87

		local var_209_0 = {
			ja = 9.966,
			ko = 10.866,
			zh = 10.3,
			en = 8.566
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play115091051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_212_1 = 0
			local var_212_2 = 1.4

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_3 = arg_209_1:FormatText(StoryNameCfg[273].name)

				arg_209_1.leftNameTxt_.text = var_212_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_4 = arg_209_1:GetWordFromCfg(115091050)
				local var_212_5 = arg_209_1:FormatText(var_212_4.content)

				arg_209_1.text_.text = var_212_5

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_6 = 50
				local var_212_7 = utf8.len(var_212_5)
				local var_212_8 = var_212_6 <= 0 and var_212_2 or var_212_2 * (var_212_7 / var_212_6)

				if var_212_8 > 0 and var_212_2 < var_212_8 then
					arg_209_1.talkMaxDuration = var_212_8

					if var_212_8 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_1
					end
				end

				arg_209_1.text_.text = var_212_5
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091050", "story_v_out_115091.awb") ~= 0 then
					local var_212_9 = manager.audio:GetVoiceLength("story_v_out_115091", "115091050", "story_v_out_115091.awb") / 1000

					if var_212_9 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_1
					end

					if var_212_4.prefab_name ~= "" and arg_209_1.actors_[var_212_4.prefab_name] ~= nil then
						local var_212_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_4.prefab_name].transform, "story_v_out_115091", "115091050", "story_v_out_115091.awb")

						arg_209_1:RecordAudio("115091050", var_212_10)
						arg_209_1:RecordAudio("115091050", var_212_10)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_115091", "115091050", "story_v_out_115091.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_115091", "115091050", "story_v_out_115091.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_11 = math.max(var_212_2, arg_209_1.talkMaxDuration)

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_11 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_1) / var_212_11

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_1 + var_212_11 and arg_209_1.time_ < var_212_1 + var_212_11 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play115091051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 115091051
		arg_213_1.duration_ = 6.4

		local var_213_0 = {
			ja = 5.533,
			ko = 6.266,
			zh = 6.4,
			en = 3.733
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
				arg_213_0:Play115091052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["2074ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect2074ui_story == nil then
				arg_213_1.var_.characterEffect2074ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.2

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect2074ui_story and not isNil(var_216_0) then
					arg_213_1.var_.characterEffect2074ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect2074ui_story then
				arg_213_1.var_.characterEffect2074ui_story.fillFlat = false
			end

			local var_216_4 = arg_213_1.actors_["1017ui_story"]
			local var_216_5 = 0

			if var_216_5 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 and not isNil(var_216_4) and arg_213_1.var_.characterEffect1017ui_story == nil then
				arg_213_1.var_.characterEffect1017ui_story = var_216_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_6 = 0.2

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_6 and not isNil(var_216_4) then
				local var_216_7 = (arg_213_1.time_ - var_216_5) / var_216_6

				if arg_213_1.var_.characterEffect1017ui_story and not isNil(var_216_4) then
					local var_216_8 = Mathf.Lerp(0, 0.5, var_216_7)

					arg_213_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1017ui_story.fillRatio = var_216_8
				end
			end

			if arg_213_1.time_ >= var_216_5 + var_216_6 and arg_213_1.time_ < var_216_5 + var_216_6 + arg_216_0 and not isNil(var_216_4) and arg_213_1.var_.characterEffect1017ui_story then
				local var_216_9 = 0.5

				arg_213_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1017ui_story.fillRatio = var_216_9
			end

			local var_216_10 = 0
			local var_216_11 = 0.7

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_12 = arg_213_1:FormatText(StoryNameCfg[280].name)

				arg_213_1.leftNameTxt_.text = var_216_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_13 = arg_213_1:GetWordFromCfg(115091051)
				local var_216_14 = arg_213_1:FormatText(var_216_13.content)

				arg_213_1.text_.text = var_216_14

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_15 = 28
				local var_216_16 = utf8.len(var_216_14)
				local var_216_17 = var_216_15 <= 0 and var_216_11 or var_216_11 * (var_216_16 / var_216_15)

				if var_216_17 > 0 and var_216_11 < var_216_17 then
					arg_213_1.talkMaxDuration = var_216_17

					if var_216_17 + var_216_10 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_17 + var_216_10
					end
				end

				arg_213_1.text_.text = var_216_14
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115091", "115091051", "story_v_out_115091.awb") ~= 0 then
					local var_216_18 = manager.audio:GetVoiceLength("story_v_out_115091", "115091051", "story_v_out_115091.awb") / 1000

					if var_216_18 + var_216_10 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_18 + var_216_10
					end

					if var_216_13.prefab_name ~= "" and arg_213_1.actors_[var_216_13.prefab_name] ~= nil then
						local var_216_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_13.prefab_name].transform, "story_v_out_115091", "115091051", "story_v_out_115091.awb")

						arg_213_1:RecordAudio("115091051", var_216_19)
						arg_213_1:RecordAudio("115091051", var_216_19)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_115091", "115091051", "story_v_out_115091.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_115091", "115091051", "story_v_out_115091.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_20 = math.max(var_216_11, arg_213_1.talkMaxDuration)

			if var_216_10 <= arg_213_1.time_ and arg_213_1.time_ < var_216_10 + var_216_20 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_10) / var_216_20

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_10 + var_216_20 and arg_213_1.time_ < var_216_10 + var_216_20 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play115091052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 115091052
		arg_217_1.duration_ = 7

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
			arg_217_1.auto_ = false
		end

		function arg_217_1.playNext_(arg_219_0)
			arg_217_1.onStoryFinished_()
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1017ui_story"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos1017ui_story = var_220_0.localPosition
			end

			local var_220_2 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2
				local var_220_4 = Vector3.New(0, 100, 0)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1017ui_story, var_220_4, var_220_3)

				local var_220_5 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_5.x, var_220_5.y, var_220_5.z)

				local var_220_6 = var_220_0.localEulerAngles

				var_220_6.z = 0
				var_220_6.x = 0
				var_220_0.localEulerAngles = var_220_6
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(0, 100, 0)

				local var_220_7 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_7.x, var_220_7.y, var_220_7.z)

				local var_220_8 = var_220_0.localEulerAngles

				var_220_8.z = 0
				var_220_8.x = 0
				var_220_0.localEulerAngles = var_220_8
			end

			local var_220_9 = arg_217_1.actors_["2074ui_story"].transform
			local var_220_10 = 0

			if var_220_10 < arg_217_1.time_ and arg_217_1.time_ <= var_220_10 + arg_220_0 then
				arg_217_1.var_.moveOldPos2074ui_story = var_220_9.localPosition
			end

			local var_220_11 = 0.001

			if var_220_10 <= arg_217_1.time_ and arg_217_1.time_ < var_220_10 + var_220_11 then
				local var_220_12 = (arg_217_1.time_ - var_220_10) / var_220_11
				local var_220_13 = Vector3.New(0, 100, 0)

				var_220_9.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos2074ui_story, var_220_13, var_220_12)

				local var_220_14 = manager.ui.mainCamera.transform.position - var_220_9.position

				var_220_9.forward = Vector3.New(var_220_14.x, var_220_14.y, var_220_14.z)

				local var_220_15 = var_220_9.localEulerAngles

				var_220_15.z = 0
				var_220_15.x = 0
				var_220_9.localEulerAngles = var_220_15
			end

			if arg_217_1.time_ >= var_220_10 + var_220_11 and arg_217_1.time_ < var_220_10 + var_220_11 + arg_220_0 then
				var_220_9.localPosition = Vector3.New(0, 100, 0)

				local var_220_16 = manager.ui.mainCamera.transform.position - var_220_9.position

				var_220_9.forward = Vector3.New(var_220_16.x, var_220_16.y, var_220_16.z)

				local var_220_17 = var_220_9.localEulerAngles

				var_220_17.z = 0
				var_220_17.x = 0
				var_220_9.localEulerAngles = var_220_17
			end

			local var_220_18 = 0.5

			if var_220_18 < arg_217_1.time_ and arg_217_1.time_ <= var_220_18 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_19 = 2

			if var_220_18 <= arg_217_1.time_ and arg_217_1.time_ < var_220_18 + var_220_19 then
				local var_220_20 = (arg_217_1.time_ - var_220_18) / var_220_19
				local var_220_21 = Color.New(1, 1, 1)

				var_220_21.a = Mathf.Lerp(1, 0, var_220_20)
				arg_217_1.mask_.color = var_220_21
			end

			if arg_217_1.time_ >= var_220_18 + var_220_19 and arg_217_1.time_ < var_220_18 + var_220_19 + arg_220_0 then
				local var_220_22 = Color.New(1, 1, 1)
				local var_220_23 = 0

				arg_217_1.mask_.enabled = false
				var_220_22.a = var_220_23
				arg_217_1.mask_.color = var_220_22
			end

			local var_220_24 = 0

			if var_220_24 < arg_217_1.time_ and arg_217_1.time_ <= var_220_24 + arg_220_0 then
				arg_217_1.allBtn_.enabled = false
			end

			local var_220_25 = 0.5

			if arg_217_1.time_ >= var_220_24 + var_220_25 and arg_217_1.time_ < var_220_24 + var_220_25 + arg_220_0 then
				arg_217_1.allBtn_.enabled = true
			end

			if arg_217_1.frameCnt_ <= 1 then
				arg_217_1.dialog_:SetActive(false)
			end

			local var_220_26 = 2
			local var_220_27 = 0.75

			if var_220_26 < arg_217_1.time_ and arg_217_1.time_ <= var_220_26 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0

				arg_217_1.dialog_:SetActive(true)

				arg_217_1.dialogCg_.alpha = 0

				local var_220_28 = LeanTween.value(arg_217_1.dialog_, 0, 1, 0.3)

				var_220_28:setOnUpdate(LuaHelper.FloatAction(function(arg_221_0)
					arg_217_1.dialogCg_.alpha = arg_221_0
				end))
				var_220_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_217_1.dialog_)
					var_220_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_217_1.duration_ = arg_217_1.duration_ + 0.3

				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_29 = arg_217_1:GetWordFromCfg(115091052)
				local var_220_30 = arg_217_1:FormatText(var_220_29.content)

				arg_217_1.text_.text = var_220_30

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_31 = 30
				local var_220_32 = utf8.len(var_220_30)
				local var_220_33 = var_220_31 <= 0 and var_220_27 or var_220_27 * (var_220_32 / var_220_31)

				if var_220_33 > 0 and var_220_27 < var_220_33 then
					arg_217_1.talkMaxDuration = var_220_33
					var_220_26 = var_220_26 + 0.3

					if var_220_33 + var_220_26 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_33 + var_220_26
					end
				end

				arg_217_1.text_.text = var_220_30
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_34 = var_220_26 + 0.3
			local var_220_35 = math.max(var_220_27, arg_217_1.talkMaxDuration)

			if var_220_34 <= arg_217_1.time_ and arg_217_1.time_ < var_220_34 + var_220_35 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_34) / var_220_35

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_34 + var_220_35 and arg_217_1.time_ < var_220_34 + var_220_35 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/G01",
		"TextureConfig/Background/RO0301",
		"TextureConfig/Background/G03a"
	},
	voices = {
		"story_v_out_115091.awb"
	}
}
