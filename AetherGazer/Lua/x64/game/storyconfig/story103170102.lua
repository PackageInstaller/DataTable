return {
	Play317012001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317012001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317012002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "K11f"

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
				local var_4_5 = arg_1_1.bgs_.K11f

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
					if iter_4_0 ~= "K11f" then
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

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo")

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

			local var_4_34 = 1.75
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_123_01", "se_story_123_01_crake", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 2
			local var_4_39 = 0.75

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_41 = arg_1_1:GetWordFromCfg(317012001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 30
				local var_4_44 = utf8.len(var_4_42)
				local var_4_45 = var_4_43 <= 0 and var_4_39 or var_4_39 * (var_4_44 / var_4_43)

				if var_4_45 > 0 and var_4_39 < var_4_45 then
					arg_1_1.talkMaxDuration = var_4_45
					var_4_38 = var_4_38 + 0.3

					if var_4_45 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_42
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_46 = var_4_38 + 0.3
			local var_4_47 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_46) / var_4_47

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play317012002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 317012002
		arg_9_1.duration_ = 3.67

		local var_9_0 = {
			zh = 2.4,
			ja = 3.666
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
				arg_9_0:Play317012003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1199ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1199ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1199ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1199ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -1.08, -5.9)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1199ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = 0

			if var_12_14 < arg_9_1.time_ and arg_9_1.time_ <= var_12_14 + arg_12_0 then
				arg_9_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_12_16 = arg_9_1.actors_["1199ui_story"]
			local var_12_17 = 0

			if var_12_17 < arg_9_1.time_ and arg_9_1.time_ <= var_12_17 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.characterEffect1199ui_story == nil then
				arg_9_1.var_.characterEffect1199ui_story = var_12_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_18 = 0.2

			if var_12_17 <= arg_9_1.time_ and arg_9_1.time_ < var_12_17 + var_12_18 and not isNil(var_12_16) then
				local var_12_19 = (arg_9_1.time_ - var_12_17) / var_12_18

				if arg_9_1.var_.characterEffect1199ui_story and not isNil(var_12_16) then
					arg_9_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_17 + var_12_18 and arg_9_1.time_ < var_12_17 + var_12_18 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.characterEffect1199ui_story then
				arg_9_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_12_20 = 0
			local var_12_21 = 0.2

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[84].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(317012002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012002", "story_v_out_317012.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_317012", "317012002", "story_v_out_317012.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_317012", "317012002", "story_v_out_317012.awb")

						arg_9_1:RecordAudio("317012002", var_12_29)
						arg_9_1:RecordAudio("317012002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_317012", "317012002", "story_v_out_317012.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_317012", "317012002", "story_v_out_317012.awb")
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
				actorName = "1199ui_story",
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
	Play317012003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 317012003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play317012004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1199ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1199ui_story == nil then
				arg_13_1.var_.characterEffect1199ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1199ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1199ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1199ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1199ui_story.fillRatio = var_16_5
			end

			local var_16_6 = 0
			local var_16_7 = 1.025

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_8 = arg_13_1:GetWordFromCfg(317012003)
				local var_16_9 = arg_13_1:FormatText(var_16_8.content)

				arg_13_1.text_.text = var_16_9

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 41
				local var_16_11 = utf8.len(var_16_9)
				local var_16_12 = var_16_10 <= 0 and var_16_7 or var_16_7 * (var_16_11 / var_16_10)

				if var_16_12 > 0 and var_16_7 < var_16_12 then
					arg_13_1.talkMaxDuration = var_16_12

					if var_16_12 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_9
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_13 and arg_13_1.time_ < var_16_6 + var_16_13 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play317012004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 317012004
		arg_17_1.duration_ = 11.63

		local var_17_0 = {
			zh = 9.633,
			ja = 11.633
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
				arg_17_0:Play317012005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1199ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1199ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, -1.08, -5.9)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1199ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = 0

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 then
				arg_17_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_20_11 = arg_17_1.actors_["1199ui_story"]
			local var_20_12 = 0

			if var_20_12 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 and not isNil(var_20_11) and arg_17_1.var_.characterEffect1199ui_story == nil then
				arg_17_1.var_.characterEffect1199ui_story = var_20_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_13 = 0.2

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_13 and not isNil(var_20_11) then
				local var_20_14 = (arg_17_1.time_ - var_20_12) / var_20_13

				if arg_17_1.var_.characterEffect1199ui_story and not isNil(var_20_11) then
					arg_17_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_12 + var_20_13 and arg_17_1.time_ < var_20_12 + var_20_13 + arg_20_0 and not isNil(var_20_11) and arg_17_1.var_.characterEffect1199ui_story then
				arg_17_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_20_15 = 0
			local var_20_16 = 1.225

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_17 = arg_17_1:FormatText(StoryNameCfg[84].name)

				arg_17_1.leftNameTxt_.text = var_20_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_18 = arg_17_1:GetWordFromCfg(317012004)
				local var_20_19 = arg_17_1:FormatText(var_20_18.content)

				arg_17_1.text_.text = var_20_19

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_20 = 49
				local var_20_21 = utf8.len(var_20_19)
				local var_20_22 = var_20_20 <= 0 and var_20_16 or var_20_16 * (var_20_21 / var_20_20)

				if var_20_22 > 0 and var_20_16 < var_20_22 then
					arg_17_1.talkMaxDuration = var_20_22

					if var_20_22 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_22 + var_20_15
					end
				end

				arg_17_1.text_.text = var_20_19
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012004", "story_v_out_317012.awb") ~= 0 then
					local var_20_23 = manager.audio:GetVoiceLength("story_v_out_317012", "317012004", "story_v_out_317012.awb") / 1000

					if var_20_23 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_15
					end

					if var_20_18.prefab_name ~= "" and arg_17_1.actors_[var_20_18.prefab_name] ~= nil then
						local var_20_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_18.prefab_name].transform, "story_v_out_317012", "317012004", "story_v_out_317012.awb")

						arg_17_1:RecordAudio("317012004", var_20_24)
						arg_17_1:RecordAudio("317012004", var_20_24)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_317012", "317012004", "story_v_out_317012.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_317012", "317012004", "story_v_out_317012.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_25 = math.max(var_20_16, arg_17_1.talkMaxDuration)

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_25 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_15) / var_20_25

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_15 + var_20_25 and arg_17_1.time_ < var_20_15 + var_20_25 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play317012005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 317012005
		arg_21_1.duration_ = 3.67

		local var_21_0 = {
			zh = 1.999999999999,
			ja = 3.666
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
				arg_21_0:Play317012006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1199ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1199ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, -1.08, -5.9)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1199ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_24_11 = 0
			local var_24_12 = 0.1

			if var_24_11 < arg_21_1.time_ and arg_21_1.time_ <= var_24_11 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_13 = arg_21_1:FormatText(StoryNameCfg[84].name)

				arg_21_1.leftNameTxt_.text = var_24_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_14 = arg_21_1:GetWordFromCfg(317012005)
				local var_24_15 = arg_21_1:FormatText(var_24_14.content)

				arg_21_1.text_.text = var_24_15

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_16 = 4
				local var_24_17 = utf8.len(var_24_15)
				local var_24_18 = var_24_16 <= 0 and var_24_12 or var_24_12 * (var_24_17 / var_24_16)

				if var_24_18 > 0 and var_24_12 < var_24_18 then
					arg_21_1.talkMaxDuration = var_24_18

					if var_24_18 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_18 + var_24_11
					end
				end

				arg_21_1.text_.text = var_24_15
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012005", "story_v_out_317012.awb") ~= 0 then
					local var_24_19 = manager.audio:GetVoiceLength("story_v_out_317012", "317012005", "story_v_out_317012.awb") / 1000

					if var_24_19 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_19 + var_24_11
					end

					if var_24_14.prefab_name ~= "" and arg_21_1.actors_[var_24_14.prefab_name] ~= nil then
						local var_24_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_14.prefab_name].transform, "story_v_out_317012", "317012005", "story_v_out_317012.awb")

						arg_21_1:RecordAudio("317012005", var_24_20)
						arg_21_1:RecordAudio("317012005", var_24_20)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_317012", "317012005", "story_v_out_317012.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_317012", "317012005", "story_v_out_317012.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_21 = math.max(var_24_12, arg_21_1.talkMaxDuration)

			if var_24_11 <= arg_21_1.time_ and arg_21_1.time_ < var_24_11 + var_24_21 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_11) / var_24_21

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_11 + var_24_21 and arg_21_1.time_ < var_24_11 + var_24_21 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play317012006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 317012006
		arg_25_1.duration_ = 9

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play317012007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "K09g"

			if arg_25_1.bgs_[var_28_0] == nil then
				local var_28_1 = Object.Instantiate(arg_25_1.paintGo_)

				var_28_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_28_0)
				var_28_1.name = var_28_0
				var_28_1.transform.parent = arg_25_1.stage_.transform
				var_28_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_[var_28_0] = var_28_1
			end

			local var_28_2 = 2

			if var_28_2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				local var_28_3 = manager.ui.mainCamera.transform.localPosition
				local var_28_4 = Vector3.New(0, 0, 10) + Vector3.New(var_28_3.x, var_28_3.y, 0)
				local var_28_5 = arg_25_1.bgs_.K09g

				var_28_5.transform.localPosition = var_28_4
				var_28_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_6 = var_28_5:GetComponent("SpriteRenderer")

				if var_28_6 and var_28_6.sprite then
					local var_28_7 = (var_28_5.transform.localPosition - var_28_3).z
					local var_28_8 = manager.ui.mainCameraCom_
					local var_28_9 = 2 * var_28_7 * Mathf.Tan(var_28_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_28_10 = var_28_9 * var_28_8.aspect
					local var_28_11 = var_28_6.sprite.bounds.size.x
					local var_28_12 = var_28_6.sprite.bounds.size.y
					local var_28_13 = var_28_10 / var_28_11
					local var_28_14 = var_28_9 / var_28_12
					local var_28_15 = var_28_14 < var_28_13 and var_28_13 or var_28_14

					var_28_5.transform.localScale = Vector3.New(var_28_15, var_28_15, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "K09g" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_17 = 2

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 then
				local var_28_18 = (arg_25_1.time_ - var_28_16) / var_28_17
				local var_28_19 = Color.New(0, 0, 0)

				var_28_19.a = Mathf.Lerp(0, 1, var_28_18)
				arg_25_1.mask_.color = var_28_19
			end

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 then
				local var_28_20 = Color.New(0, 0, 0)

				var_28_20.a = 1
				arg_25_1.mask_.color = var_28_20
			end

			local var_28_21 = 2

			if var_28_21 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_22 = 2

			if var_28_21 <= arg_25_1.time_ and arg_25_1.time_ < var_28_21 + var_28_22 then
				local var_28_23 = (arg_25_1.time_ - var_28_21) / var_28_22
				local var_28_24 = Color.New(0, 0, 0)

				var_28_24.a = Mathf.Lerp(1, 0, var_28_23)
				arg_25_1.mask_.color = var_28_24
			end

			if arg_25_1.time_ >= var_28_21 + var_28_22 and arg_25_1.time_ < var_28_21 + var_28_22 + arg_28_0 then
				local var_28_25 = Color.New(0, 0, 0)
				local var_28_26 = 0

				arg_25_1.mask_.enabled = false
				var_28_25.a = var_28_26
				arg_25_1.mask_.color = var_28_25
			end

			local var_28_27 = arg_25_1.actors_["1199ui_story"].transform
			local var_28_28 = 2

			if var_28_28 < arg_25_1.time_ and arg_25_1.time_ <= var_28_28 + arg_28_0 then
				arg_25_1.var_.moveOldPos1199ui_story = var_28_27.localPosition
			end

			local var_28_29 = 0.001

			if var_28_28 <= arg_25_1.time_ and arg_25_1.time_ < var_28_28 + var_28_29 then
				local var_28_30 = (arg_25_1.time_ - var_28_28) / var_28_29
				local var_28_31 = Vector3.New(0, 100, 0)

				var_28_27.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1199ui_story, var_28_31, var_28_30)

				local var_28_32 = manager.ui.mainCamera.transform.position - var_28_27.position

				var_28_27.forward = Vector3.New(var_28_32.x, var_28_32.y, var_28_32.z)

				local var_28_33 = var_28_27.localEulerAngles

				var_28_33.z = 0
				var_28_33.x = 0
				var_28_27.localEulerAngles = var_28_33
			end

			if arg_25_1.time_ >= var_28_28 + var_28_29 and arg_25_1.time_ < var_28_28 + var_28_29 + arg_28_0 then
				var_28_27.localPosition = Vector3.New(0, 100, 0)

				local var_28_34 = manager.ui.mainCamera.transform.position - var_28_27.position

				var_28_27.forward = Vector3.New(var_28_34.x, var_28_34.y, var_28_34.z)

				local var_28_35 = var_28_27.localEulerAngles

				var_28_35.z = 0
				var_28_35.x = 0
				var_28_27.localEulerAngles = var_28_35
			end

			local var_28_36 = manager.ui.mainCamera.transform
			local var_28_37 = 4

			if var_28_37 < arg_25_1.time_ and arg_25_1.time_ <= var_28_37 + arg_28_0 then
				local var_28_38 = arg_25_1.var_.effectposui1
				local var_28_39
				local var_28_40 = var_28_36

				if not var_28_38 then
					var_28_38 = Object.Instantiate(Asset.Load("Effect/Scene/fx_scence_pingmu_niuqu"), var_28_40)
					var_28_38.name = "posui1"
					arg_25_1.var_.effectposui1 = var_28_38
				else
					var_28_38.transform:SetParent(var_28_40)
				end

				var_28_38.transform.localPosition = Vector3.New(0, 0, 0)
				var_28_38.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_41 = 4
			local var_28_42 = 1.425

			if var_28_41 < arg_25_1.time_ and arg_25_1.time_ <= var_28_41 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_43 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_43:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_44 = arg_25_1:GetWordFromCfg(317012006)
				local var_28_45 = arg_25_1:FormatText(var_28_44.content)

				arg_25_1.text_.text = var_28_45

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_46 = 57
				local var_28_47 = utf8.len(var_28_45)
				local var_28_48 = var_28_46 <= 0 and var_28_42 or var_28_42 * (var_28_47 / var_28_46)

				if var_28_48 > 0 and var_28_42 < var_28_48 then
					arg_25_1.talkMaxDuration = var_28_48
					var_28_41 = var_28_41 + 0.3

					if var_28_48 + var_28_41 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_48 + var_28_41
					end
				end

				arg_25_1.text_.text = var_28_45
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_49 = var_28_41 + 0.3
			local var_28_50 = math.max(var_28_42, arg_25_1.talkMaxDuration)

			if var_28_49 <= arg_25_1.time_ and arg_25_1.time_ < var_28_49 + var_28_50 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_49) / var_28_50

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_49 + var_28_50 and arg_25_1.time_ < var_28_49 + var_28_50 + arg_28_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play317012007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 317012007
		arg_31_1.duration_ = 10

		local var_31_0 = {
			zh = 9.366,
			ja = 10
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play317012008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = "K09h"

			if arg_31_1.bgs_[var_34_0] == nil then
				local var_34_1 = Object.Instantiate(arg_31_1.paintGo_)

				var_34_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_34_0)
				var_34_1.name = var_34_0
				var_34_1.transform.parent = arg_31_1.stage_.transform
				var_34_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.bgs_[var_34_0] = var_34_1
			end

			local var_34_2 = 2

			if var_34_2 < arg_31_1.time_ and arg_31_1.time_ <= var_34_2 + arg_34_0 then
				local var_34_3 = manager.ui.mainCamera.transform.localPosition
				local var_34_4 = Vector3.New(0, 0, 10) + Vector3.New(var_34_3.x, var_34_3.y, 0)
				local var_34_5 = arg_31_1.bgs_.K09h

				var_34_5.transform.localPosition = var_34_4
				var_34_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_34_6 = var_34_5:GetComponent("SpriteRenderer")

				if var_34_6 and var_34_6.sprite then
					local var_34_7 = (var_34_5.transform.localPosition - var_34_3).z
					local var_34_8 = manager.ui.mainCameraCom_
					local var_34_9 = 2 * var_34_7 * Mathf.Tan(var_34_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_34_10 = var_34_9 * var_34_8.aspect
					local var_34_11 = var_34_6.sprite.bounds.size.x
					local var_34_12 = var_34_6.sprite.bounds.size.y
					local var_34_13 = var_34_10 / var_34_11
					local var_34_14 = var_34_9 / var_34_12
					local var_34_15 = var_34_14 < var_34_13 and var_34_13 or var_34_14

					var_34_5.transform.localScale = Vector3.New(var_34_15, var_34_15, 0)
				end

				for iter_34_0, iter_34_1 in pairs(arg_31_1.bgs_) do
					if iter_34_0 ~= "K09h" then
						iter_34_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_34_16 = 0

			if var_34_16 < arg_31_1.time_ and arg_31_1.time_ <= var_34_16 + arg_34_0 then
				arg_31_1.mask_.enabled = true
				arg_31_1.mask_.raycastTarget = true

				arg_31_1:SetGaussion(false)
			end

			local var_34_17 = 2

			if var_34_16 <= arg_31_1.time_ and arg_31_1.time_ < var_34_16 + var_34_17 then
				local var_34_18 = (arg_31_1.time_ - var_34_16) / var_34_17
				local var_34_19 = Color.New(0, 0, 0)

				var_34_19.a = Mathf.Lerp(0, 1, var_34_18)
				arg_31_1.mask_.color = var_34_19
			end

			if arg_31_1.time_ >= var_34_16 + var_34_17 and arg_31_1.time_ < var_34_16 + var_34_17 + arg_34_0 then
				local var_34_20 = Color.New(0, 0, 0)

				var_34_20.a = 1
				arg_31_1.mask_.color = var_34_20
			end

			local var_34_21 = 2

			if var_34_21 < arg_31_1.time_ and arg_31_1.time_ <= var_34_21 + arg_34_0 then
				arg_31_1.mask_.enabled = true
				arg_31_1.mask_.raycastTarget = true

				arg_31_1:SetGaussion(false)
			end

			local var_34_22 = 2

			if var_34_21 <= arg_31_1.time_ and arg_31_1.time_ < var_34_21 + var_34_22 then
				local var_34_23 = (arg_31_1.time_ - var_34_21) / var_34_22
				local var_34_24 = Color.New(0, 0, 0)

				var_34_24.a = Mathf.Lerp(1, 0, var_34_23)
				arg_31_1.mask_.color = var_34_24
			end

			if arg_31_1.time_ >= var_34_21 + var_34_22 and arg_31_1.time_ < var_34_21 + var_34_22 + arg_34_0 then
				local var_34_25 = Color.New(0, 0, 0)
				local var_34_26 = 0

				arg_31_1.mask_.enabled = false
				var_34_25.a = var_34_26
				arg_31_1.mask_.color = var_34_25
			end

			local var_34_27 = manager.ui.mainCamera.transform
			local var_34_28 = 2

			if var_34_28 < arg_31_1.time_ and arg_31_1.time_ <= var_34_28 + arg_34_0 then
				local var_34_29 = arg_31_1.var_.effectposui1

				if var_34_29 then
					Object.Destroy(var_34_29)

					arg_31_1.var_.effectposui1 = nil
				end
			end

			if arg_31_1.frameCnt_ <= 1 then
				arg_31_1.dialog_:SetActive(false)
			end

			local var_34_30 = 4
			local var_34_31 = 0.525

			if var_34_30 < arg_31_1.time_ and arg_31_1.time_ <= var_34_30 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				arg_31_1.dialog_:SetActive(true)

				arg_31_1.dialogCg_.alpha = 0

				local var_34_32 = LeanTween.value(arg_31_1.dialog_, 0, 1, 0.3)

				var_34_32:setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
					arg_31_1.dialogCg_.alpha = arg_35_0
				end))
				var_34_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_31_1.dialog_)
					var_34_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_31_1.duration_ = arg_31_1.duration_ + 0.3

				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_33 = arg_31_1:FormatText(StoryNameCfg[477].name)

				arg_31_1.leftNameTxt_.text = var_34_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10053")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_34 = arg_31_1:GetWordFromCfg(317012007)
				local var_34_35 = arg_31_1:FormatText(var_34_34.content)

				arg_31_1.text_.text = var_34_35

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_36 = 21
				local var_34_37 = utf8.len(var_34_35)
				local var_34_38 = var_34_36 <= 0 and var_34_31 or var_34_31 * (var_34_37 / var_34_36)

				if var_34_38 > 0 and var_34_31 < var_34_38 then
					arg_31_1.talkMaxDuration = var_34_38
					var_34_30 = var_34_30 + 0.3

					if var_34_38 + var_34_30 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_38 + var_34_30
					end
				end

				arg_31_1.text_.text = var_34_35
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012007", "story_v_out_317012.awb") ~= 0 then
					local var_34_39 = manager.audio:GetVoiceLength("story_v_out_317012", "317012007", "story_v_out_317012.awb") / 1000

					if var_34_39 + var_34_30 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_39 + var_34_30
					end

					if var_34_34.prefab_name ~= "" and arg_31_1.actors_[var_34_34.prefab_name] ~= nil then
						local var_34_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_34.prefab_name].transform, "story_v_out_317012", "317012007", "story_v_out_317012.awb")

						arg_31_1:RecordAudio("317012007", var_34_40)
						arg_31_1:RecordAudio("317012007", var_34_40)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_317012", "317012007", "story_v_out_317012.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_317012", "317012007", "story_v_out_317012.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_41 = var_34_30 + 0.3
			local var_34_42 = math.max(var_34_31, arg_31_1.talkMaxDuration)

			if var_34_41 <= arg_31_1.time_ and arg_31_1.time_ < var_34_41 + var_34_42 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_41) / var_34_42

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_41 + var_34_42 and arg_31_1.time_ < var_34_41 + var_34_42 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play317012008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 317012008
		arg_37_1.duration_ = 4.3

		local var_37_0 = {
			zh = 1.366,
			ja = 4.3
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
				arg_37_0:Play317012009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.125

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[526].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(317012008)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012008", "story_v_out_317012.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012008", "story_v_out_317012.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_317012", "317012008", "story_v_out_317012.awb")

						arg_37_1:RecordAudio("317012008", var_40_9)
						arg_37_1:RecordAudio("317012008", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_317012", "317012008", "story_v_out_317012.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_317012", "317012008", "story_v_out_317012.awb")
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
	Play317012009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 317012009
		arg_41_1.duration_ = 2.6

		local var_41_0 = {
			zh = 2.6,
			ja = 2.5
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
				arg_41_0:Play317012010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.3

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[477].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10053")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(317012009)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 12
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012009", "story_v_out_317012.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012009", "story_v_out_317012.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_317012", "317012009", "story_v_out_317012.awb")

						arg_41_1:RecordAudio("317012009", var_44_9)
						arg_41_1:RecordAudio("317012009", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_317012", "317012009", "story_v_out_317012.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_317012", "317012009", "story_v_out_317012.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_10 and arg_41_1.time_ < var_44_0 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play317012010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 317012010
		arg_45_1.duration_ = 9.5

		local var_45_0 = {
			zh = 3.633,
			ja = 9.5
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
				arg_45_0:Play317012011(arg_45_1)
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

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[526].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(317012010)
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012010", "story_v_out_317012.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012010", "story_v_out_317012.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_317012", "317012010", "story_v_out_317012.awb")

						arg_45_1:RecordAudio("317012010", var_48_9)
						arg_45_1:RecordAudio("317012010", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_317012", "317012010", "story_v_out_317012.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_317012", "317012010", "story_v_out_317012.awb")
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
	Play317012011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 317012011
		arg_49_1.duration_ = 5.7

		local var_49_0 = {
			zh = 3.866,
			ja = 5.7
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
				arg_49_0:Play317012012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.275

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[477].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10053")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(317012011)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012011", "story_v_out_317012.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012011", "story_v_out_317012.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_317012", "317012011", "story_v_out_317012.awb")

						arg_49_1:RecordAudio("317012011", var_52_9)
						arg_49_1:RecordAudio("317012011", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_317012", "317012011", "story_v_out_317012.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_317012", "317012011", "story_v_out_317012.awb")
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
	Play317012012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 317012012
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play317012013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.125

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

				local var_56_2 = arg_53_1:GetWordFromCfg(317012012)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 45
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
	Play317012013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 317012013
		arg_57_1.duration_ = 4.33

		local var_57_0 = {
			zh = 2.1,
			ja = 4.333
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
				arg_57_0:Play317012014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.175

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[526].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(317012013)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012013", "story_v_out_317012.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012013", "story_v_out_317012.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_317012", "317012013", "story_v_out_317012.awb")

						arg_57_1:RecordAudio("317012013", var_60_9)
						arg_57_1:RecordAudio("317012013", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_317012", "317012013", "story_v_out_317012.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_317012", "317012013", "story_v_out_317012.awb")
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
	Play317012014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 317012014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play317012015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.95

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

				local var_64_2 = arg_61_1:GetWordFromCfg(317012014)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 38
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
	Play317012015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 317012015
		arg_65_1.duration_ = 7.7

		local var_65_0 = {
			zh = 4.1,
			ja = 7.7
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
				arg_65_0:Play317012016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.35

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[526].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(317012015)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 14
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_1 or var_68_1 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_1 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012015", "story_v_out_317012.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012015", "story_v_out_317012.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_317012", "317012015", "story_v_out_317012.awb")

						arg_65_1:RecordAudio("317012015", var_68_9)
						arg_65_1:RecordAudio("317012015", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_317012", "317012015", "story_v_out_317012.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_317012", "317012015", "story_v_out_317012.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_10 and arg_65_1.time_ < var_68_0 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play317012016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 317012016
		arg_69_1.duration_ = 2.67

		local var_69_0 = {
			zh = 2.666,
			ja = 2.233
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
				arg_69_0:Play317012017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.1

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[477].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10053")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(317012016)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012016", "story_v_out_317012.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012016", "story_v_out_317012.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_317012", "317012016", "story_v_out_317012.awb")

						arg_69_1:RecordAudio("317012016", var_72_9)
						arg_69_1:RecordAudio("317012016", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_317012", "317012016", "story_v_out_317012.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_317012", "317012016", "story_v_out_317012.awb")
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
	Play317012017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 317012017
		arg_73_1.duration_ = 9

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play317012018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = "YA0101"

			if arg_73_1.bgs_[var_76_0] == nil then
				local var_76_1 = Object.Instantiate(arg_73_1.paintGo_)

				var_76_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_76_0)
				var_76_1.name = var_76_0
				var_76_1.transform.parent = arg_73_1.stage_.transform
				var_76_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.bgs_[var_76_0] = var_76_1
			end

			local var_76_2 = 2

			if var_76_2 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				local var_76_3 = manager.ui.mainCamera.transform.localPosition
				local var_76_4 = Vector3.New(0, 0, 10) + Vector3.New(var_76_3.x, var_76_3.y, 0)
				local var_76_5 = arg_73_1.bgs_.YA0101

				var_76_5.transform.localPosition = var_76_4
				var_76_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_76_6 = var_76_5:GetComponent("SpriteRenderer")

				if var_76_6 and var_76_6.sprite then
					local var_76_7 = (var_76_5.transform.localPosition - var_76_3).z
					local var_76_8 = manager.ui.mainCameraCom_
					local var_76_9 = 2 * var_76_7 * Mathf.Tan(var_76_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_76_10 = var_76_9 * var_76_8.aspect
					local var_76_11 = var_76_6.sprite.bounds.size.x
					local var_76_12 = var_76_6.sprite.bounds.size.y
					local var_76_13 = var_76_10 / var_76_11
					local var_76_14 = var_76_9 / var_76_12
					local var_76_15 = var_76_14 < var_76_13 and var_76_13 or var_76_14

					var_76_5.transform.localScale = Vector3.New(var_76_15, var_76_15, 0)
				end

				for iter_76_0, iter_76_1 in pairs(arg_73_1.bgs_) do
					if iter_76_0 ~= "YA0101" then
						iter_76_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_17 = 2

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_17 then
				local var_76_18 = (arg_73_1.time_ - var_76_16) / var_76_17
				local var_76_19 = Color.New(0, 0, 0)

				var_76_19.a = Mathf.Lerp(0, 1, var_76_18)
				arg_73_1.mask_.color = var_76_19
			end

			if arg_73_1.time_ >= var_76_16 + var_76_17 and arg_73_1.time_ < var_76_16 + var_76_17 + arg_76_0 then
				local var_76_20 = Color.New(0, 0, 0)

				var_76_20.a = 1
				arg_73_1.mask_.color = var_76_20
			end

			local var_76_21 = 2

			if var_76_21 < arg_73_1.time_ and arg_73_1.time_ <= var_76_21 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_22 = 2

			if var_76_21 <= arg_73_1.time_ and arg_73_1.time_ < var_76_21 + var_76_22 then
				local var_76_23 = (arg_73_1.time_ - var_76_21) / var_76_22
				local var_76_24 = Color.New(0, 0, 0)

				var_76_24.a = Mathf.Lerp(1, 0, var_76_23)
				arg_73_1.mask_.color = var_76_24
			end

			if arg_73_1.time_ >= var_76_21 + var_76_22 and arg_73_1.time_ < var_76_21 + var_76_22 + arg_76_0 then
				local var_76_25 = Color.New(0, 0, 0)
				local var_76_26 = 0

				arg_73_1.mask_.enabled = false
				var_76_25.a = var_76_26
				arg_73_1.mask_.color = var_76_25
			end

			local var_76_27 = arg_73_1.bgs_.YA0101.transform
			local var_76_28 = 2

			if var_76_28 < arg_73_1.time_ and arg_73_1.time_ <= var_76_28 + arg_76_0 then
				arg_73_1.var_.moveOldPosYA0101 = var_76_27.localPosition
			end

			local var_76_29 = 0.001

			if var_76_28 <= arg_73_1.time_ and arg_73_1.time_ < var_76_28 + var_76_29 then
				local var_76_30 = (arg_73_1.time_ - var_76_28) / var_76_29
				local var_76_31 = Vector3.New(0, 1, 10)

				var_76_27.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPosYA0101, var_76_31, var_76_30)
			end

			if arg_73_1.time_ >= var_76_28 + var_76_29 and arg_73_1.time_ < var_76_28 + var_76_29 + arg_76_0 then
				var_76_27.localPosition = Vector3.New(0, 1, 10)
			end

			local var_76_32 = arg_73_1.bgs_.YA0101.transform
			local var_76_33 = 2.034

			if var_76_33 < arg_73_1.time_ and arg_73_1.time_ <= var_76_33 + arg_76_0 then
				arg_73_1.var_.moveOldPosYA0101 = var_76_32.localPosition
			end

			local var_76_34 = 4

			if var_76_33 <= arg_73_1.time_ and arg_73_1.time_ < var_76_33 + var_76_34 then
				local var_76_35 = (arg_73_1.time_ - var_76_33) / var_76_34
				local var_76_36 = Vector3.New(0, 1, 9)

				var_76_32.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPosYA0101, var_76_36, var_76_35)
			end

			if arg_73_1.time_ >= var_76_33 + var_76_34 and arg_73_1.time_ < var_76_33 + var_76_34 + arg_76_0 then
				var_76_32.localPosition = Vector3.New(0, 1, 9)
			end

			if arg_73_1.frameCnt_ <= 1 then
				arg_73_1.dialog_:SetActive(false)
			end

			local var_76_37 = 4
			local var_76_38 = 2

			if var_76_37 < arg_73_1.time_ and arg_73_1.time_ <= var_76_37 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_39 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_39:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_40 = arg_73_1:GetWordFromCfg(317012017)
				local var_76_41 = arg_73_1:FormatText(var_76_40.content)

				arg_73_1.text_.text = var_76_41

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_42 = 80
				local var_76_43 = utf8.len(var_76_41)
				local var_76_44 = var_76_42 <= 0 and var_76_38 or var_76_38 * (var_76_43 / var_76_42)

				if var_76_44 > 0 and var_76_38 < var_76_44 then
					arg_73_1.talkMaxDuration = var_76_44
					var_76_37 = var_76_37 + 0.3

					if var_76_44 + var_76_37 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_44 + var_76_37
					end
				end

				arg_73_1.text_.text = var_76_41
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_45 = var_76_37 + 0.3
			local var_76_46 = math.max(var_76_38, arg_73_1.talkMaxDuration)

			if var_76_45 <= arg_73_1.time_ and arg_73_1.time_ < var_76_45 + var_76_46 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_45) / var_76_46

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_45 + var_76_46 and arg_73_1.time_ < var_76_45 + var_76_46 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "YA0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "YA0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play317012018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 317012018
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play317012019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.7

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_2 = arg_79_1:GetWordFromCfg(317012018)
				local var_82_3 = arg_79_1:FormatText(var_82_2.content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 28
				local var_82_5 = utf8.len(var_82_3)
				local var_82_6 = var_82_4 <= 0 and var_82_1 or var_82_1 * (var_82_5 / var_82_4)

				if var_82_6 > 0 and var_82_1 < var_82_6 then
					arg_79_1.talkMaxDuration = var_82_6

					if var_82_6 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_7 and arg_79_1.time_ < var_82_0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play317012019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 317012019
		arg_83_1.duration_ = 11.27

		local var_83_0 = {
			zh = 7.2,
			ja = 11.266
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
				arg_83_0:Play317012020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 0.55

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[36].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:GetWordFromCfg(317012019)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 22
				local var_86_6 = utf8.len(var_86_4)
				local var_86_7 = var_86_5 <= 0 and var_86_1 or var_86_1 * (var_86_6 / var_86_5)

				if var_86_7 > 0 and var_86_1 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012019", "story_v_out_317012.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012019", "story_v_out_317012.awb") / 1000

					if var_86_8 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_0
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_317012", "317012019", "story_v_out_317012.awb")

						arg_83_1:RecordAudio("317012019", var_86_9)
						arg_83_1:RecordAudio("317012019", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_317012", "317012019", "story_v_out_317012.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_317012", "317012019", "story_v_out_317012.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_10 and arg_83_1.time_ < var_86_0 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play317012020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 317012020
		arg_87_1.duration_ = 17.77

		local var_87_0 = {
			zh = 12.133,
			ja = 17.766
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
				arg_87_0:Play317012021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 1.1

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[36].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:GetWordFromCfg(317012020)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 44
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_1 or var_90_1 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_1 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012020", "story_v_out_317012.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012020", "story_v_out_317012.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_out_317012", "317012020", "story_v_out_317012.awb")

						arg_87_1:RecordAudio("317012020", var_90_9)
						arg_87_1:RecordAudio("317012020", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_317012", "317012020", "story_v_out_317012.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_317012", "317012020", "story_v_out_317012.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_10 and arg_87_1.time_ < var_90_0 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play317012021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 317012021
		arg_91_1.duration_ = 4.63

		local var_91_0 = {
			zh = 3.8,
			ja = 4.633
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
				arg_91_0:Play317012022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.4

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[526].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:GetWordFromCfg(317012021)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012021", "story_v_out_317012.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012021", "story_v_out_317012.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_317012", "317012021", "story_v_out_317012.awb")

						arg_91_1:RecordAudio("317012021", var_94_9)
						arg_91_1:RecordAudio("317012021", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_317012", "317012021", "story_v_out_317012.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_317012", "317012021", "story_v_out_317012.awb")
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
	Play317012022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 317012022
		arg_95_1.duration_ = 22.2

		local var_95_0 = {
			zh = 16.1,
			ja = 22.2
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
				arg_95_0:Play317012023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 1.4

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[36].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:GetWordFromCfg(317012022)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 56
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012022", "story_v_out_317012.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012022", "story_v_out_317012.awb") / 1000

					if var_98_8 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_0
					end

					if var_98_3.prefab_name ~= "" and arg_95_1.actors_[var_98_3.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_3.prefab_name].transform, "story_v_out_317012", "317012022", "story_v_out_317012.awb")

						arg_95_1:RecordAudio("317012022", var_98_9)
						arg_95_1:RecordAudio("317012022", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_317012", "317012022", "story_v_out_317012.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_317012", "317012022", "story_v_out_317012.awb")
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
	Play317012023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 317012023
		arg_99_1.duration_ = 5.13

		local var_99_0 = {
			zh = 1.666,
			ja = 5.133
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
				arg_99_0:Play317012024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.15

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[526].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:GetWordFromCfg(317012023)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 6
				local var_102_6 = utf8.len(var_102_4)
				local var_102_7 = var_102_5 <= 0 and var_102_1 or var_102_1 * (var_102_6 / var_102_5)

				if var_102_7 > 0 and var_102_1 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_4
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012023", "story_v_out_317012.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012023", "story_v_out_317012.awb") / 1000

					if var_102_8 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_0
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_317012", "317012023", "story_v_out_317012.awb")

						arg_99_1:RecordAudio("317012023", var_102_9)
						arg_99_1:RecordAudio("317012023", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_317012", "317012023", "story_v_out_317012.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_317012", "317012023", "story_v_out_317012.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_10 and arg_99_1.time_ < var_102_0 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play317012024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 317012024
		arg_103_1.duration_ = 21.37

		local var_103_0 = {
			zh = 10.6,
			ja = 21.366
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
				arg_103_0:Play317012025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 1.025

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[36].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:GetWordFromCfg(317012024)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 40
				local var_106_6 = utf8.len(var_106_4)
				local var_106_7 = var_106_5 <= 0 and var_106_1 or var_106_1 * (var_106_6 / var_106_5)

				if var_106_7 > 0 and var_106_1 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012024", "story_v_out_317012.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012024", "story_v_out_317012.awb") / 1000

					if var_106_8 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_0
					end

					if var_106_3.prefab_name ~= "" and arg_103_1.actors_[var_106_3.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_3.prefab_name].transform, "story_v_out_317012", "317012024", "story_v_out_317012.awb")

						arg_103_1:RecordAudio("317012024", var_106_9)
						arg_103_1:RecordAudio("317012024", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_317012", "317012024", "story_v_out_317012.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_317012", "317012024", "story_v_out_317012.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_10 and arg_103_1.time_ < var_106_0 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play317012025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 317012025
		arg_107_1.duration_ = 2.03

		local var_107_0 = {
			zh = 0.999999999999,
			ja = 2.033
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
				arg_107_0:Play317012026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.05

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_2 = arg_107_1:FormatText(StoryNameCfg[526].name)

				arg_107_1.leftNameTxt_.text = var_110_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:GetWordFromCfg(317012025)
				local var_110_4 = arg_107_1:FormatText(var_110_3.content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012025", "story_v_out_317012.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012025", "story_v_out_317012.awb") / 1000

					if var_110_8 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_0
					end

					if var_110_3.prefab_name ~= "" and arg_107_1.actors_[var_110_3.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_3.prefab_name].transform, "story_v_out_317012", "317012025", "story_v_out_317012.awb")

						arg_107_1:RecordAudio("317012025", var_110_9)
						arg_107_1:RecordAudio("317012025", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_317012", "317012025", "story_v_out_317012.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_317012", "317012025", "story_v_out_317012.awb")
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
	Play317012026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 317012026
		arg_111_1.duration_ = 22.9

		local var_111_0 = {
			zh = 18.7,
			ja = 22.9
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
				arg_111_0:Play317012027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 1.375

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[36].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:GetWordFromCfg(317012026)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 55
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012026", "story_v_out_317012.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012026", "story_v_out_317012.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_317012", "317012026", "story_v_out_317012.awb")

						arg_111_1:RecordAudio("317012026", var_114_9)
						arg_111_1:RecordAudio("317012026", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_317012", "317012026", "story_v_out_317012.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_317012", "317012026", "story_v_out_317012.awb")
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
	Play317012027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 317012027
		arg_115_1.duration_ = 21.33

		local var_115_0 = {
			zh = 17.666,
			ja = 21.333
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
				arg_115_0:Play317012028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 1.375

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[36].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_3 = arg_115_1:GetWordFromCfg(317012027)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 55
				local var_118_6 = utf8.len(var_118_4)
				local var_118_7 = var_118_5 <= 0 and var_118_1 or var_118_1 * (var_118_6 / var_118_5)

				if var_118_7 > 0 and var_118_1 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_4
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012027", "story_v_out_317012.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012027", "story_v_out_317012.awb") / 1000

					if var_118_8 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_0
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_out_317012", "317012027", "story_v_out_317012.awb")

						arg_115_1:RecordAudio("317012027", var_118_9)
						arg_115_1:RecordAudio("317012027", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_317012", "317012027", "story_v_out_317012.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_317012", "317012027", "story_v_out_317012.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_10 and arg_115_1.time_ < var_118_0 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play317012028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 317012028
		arg_119_1.duration_ = 22.67

		local var_119_0 = {
			zh = 15.4,
			ja = 22.666
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
				arg_119_0:Play317012029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 1.35

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_2 = arg_119_1:FormatText(StoryNameCfg[36].name)

				arg_119_1.leftNameTxt_.text = var_122_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_3 = arg_119_1:GetWordFromCfg(317012028)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 54
				local var_122_6 = utf8.len(var_122_4)
				local var_122_7 = var_122_5 <= 0 and var_122_1 or var_122_1 * (var_122_6 / var_122_5)

				if var_122_7 > 0 and var_122_1 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_4
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012028", "story_v_out_317012.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012028", "story_v_out_317012.awb") / 1000

					if var_122_8 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_0
					end

					if var_122_3.prefab_name ~= "" and arg_119_1.actors_[var_122_3.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_3.prefab_name].transform, "story_v_out_317012", "317012028", "story_v_out_317012.awb")

						arg_119_1:RecordAudio("317012028", var_122_9)
						arg_119_1:RecordAudio("317012028", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_317012", "317012028", "story_v_out_317012.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_317012", "317012028", "story_v_out_317012.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_10 and arg_119_1.time_ < var_122_0 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play317012029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 317012029
		arg_123_1.duration_ = 9.1

		local var_123_0 = {
			zh = 4.633,
			ja = 9.1
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
				arg_123_0:Play317012030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.375

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[36].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:GetWordFromCfg(317012029)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 15
				local var_126_6 = utf8.len(var_126_4)
				local var_126_7 = var_126_5 <= 0 and var_126_1 or var_126_1 * (var_126_6 / var_126_5)

				if var_126_7 > 0 and var_126_1 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012029", "story_v_out_317012.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012029", "story_v_out_317012.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_317012", "317012029", "story_v_out_317012.awb")

						arg_123_1:RecordAudio("317012029", var_126_9)
						arg_123_1:RecordAudio("317012029", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_317012", "317012029", "story_v_out_317012.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_317012", "317012029", "story_v_out_317012.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_10 and arg_123_1.time_ < var_126_0 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play317012030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 317012030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play317012031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.725

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_2 = arg_127_1:GetWordFromCfg(317012030)
				local var_130_3 = arg_127_1:FormatText(var_130_2.content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 29
				local var_130_5 = utf8.len(var_130_3)
				local var_130_6 = var_130_4 <= 0 and var_130_1 or var_130_1 * (var_130_5 / var_130_4)

				if var_130_6 > 0 and var_130_1 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_7 and arg_127_1.time_ < var_130_0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play317012031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 317012031
		arg_131_1.duration_ = 4.97

		local var_131_0 = {
			zh = 3.566,
			ja = 4.966
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
				arg_131_0:Play317012032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.3

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[36].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:GetWordFromCfg(317012031)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 12
				local var_134_6 = utf8.len(var_134_4)
				local var_134_7 = var_134_5 <= 0 and var_134_1 or var_134_1 * (var_134_6 / var_134_5)

				if var_134_7 > 0 and var_134_1 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012031", "story_v_out_317012.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012031", "story_v_out_317012.awb") / 1000

					if var_134_8 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_0
					end

					if var_134_3.prefab_name ~= "" and arg_131_1.actors_[var_134_3.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_3.prefab_name].transform, "story_v_out_317012", "317012031", "story_v_out_317012.awb")

						arg_131_1:RecordAudio("317012031", var_134_9)
						arg_131_1:RecordAudio("317012031", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_317012", "317012031", "story_v_out_317012.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_317012", "317012031", "story_v_out_317012.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_10 and arg_131_1.time_ < var_134_0 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play317012032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 317012032
		arg_135_1.duration_ = 9.7

		local var_135_0 = {
			zh = 8.933,
			ja = 9.7
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
				arg_135_0:Play317012033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.75

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[526].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_3 = arg_135_1:GetWordFromCfg(317012032)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012032", "story_v_out_317012.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012032", "story_v_out_317012.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_317012", "317012032", "story_v_out_317012.awb")

						arg_135_1:RecordAudio("317012032", var_138_9)
						arg_135_1:RecordAudio("317012032", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_317012", "317012032", "story_v_out_317012.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_317012", "317012032", "story_v_out_317012.awb")
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
	Play317012033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 317012033
		arg_139_1.duration_ = 5.7

		local var_139_0 = {
			zh = 4.3,
			ja = 5.7
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
				arg_139_0:Play317012034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.375

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[36].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_3 = arg_139_1:GetWordFromCfg(317012033)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 15
				local var_142_6 = utf8.len(var_142_4)
				local var_142_7 = var_142_5 <= 0 and var_142_1 or var_142_1 * (var_142_6 / var_142_5)

				if var_142_7 > 0 and var_142_1 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012033", "story_v_out_317012.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012033", "story_v_out_317012.awb") / 1000

					if var_142_8 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_0
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_317012", "317012033", "story_v_out_317012.awb")

						arg_139_1:RecordAudio("317012033", var_142_9)
						arg_139_1:RecordAudio("317012033", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_317012", "317012033", "story_v_out_317012.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_317012", "317012033", "story_v_out_317012.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_10 and arg_139_1.time_ < var_142_0 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play317012034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 317012034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play317012035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.9

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_2 = arg_143_1:GetWordFromCfg(317012034)
				local var_146_3 = arg_143_1:FormatText(var_146_2.content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 36
				local var_146_5 = utf8.len(var_146_3)
				local var_146_6 = var_146_4 <= 0 and var_146_1 or var_146_1 * (var_146_5 / var_146_4)

				if var_146_6 > 0 and var_146_1 < var_146_6 then
					arg_143_1.talkMaxDuration = var_146_6

					if var_146_6 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_7 and arg_143_1.time_ < var_146_0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play317012035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 317012035
		arg_147_1.duration_ = 7

		local var_147_0 = {
			zh = 2.5,
			ja = 7
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
				arg_147_0:Play317012036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.125

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[36].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:GetWordFromCfg(317012035)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012035", "story_v_out_317012.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012035", "story_v_out_317012.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_317012", "317012035", "story_v_out_317012.awb")

						arg_147_1:RecordAudio("317012035", var_150_9)
						arg_147_1:RecordAudio("317012035", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_317012", "317012035", "story_v_out_317012.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_317012", "317012035", "story_v_out_317012.awb")
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
	Play317012036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 317012036
		arg_151_1.duration_ = 3.8

		local var_151_0 = {
			zh = 2.466,
			ja = 3.8
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
				arg_151_0:Play317012037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.325

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[526].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_3 = arg_151_1:GetWordFromCfg(317012036)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 12
				local var_154_6 = utf8.len(var_154_4)
				local var_154_7 = var_154_5 <= 0 and var_154_1 or var_154_1 * (var_154_6 / var_154_5)

				if var_154_7 > 0 and var_154_1 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012036", "story_v_out_317012.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012036", "story_v_out_317012.awb") / 1000

					if var_154_8 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_0
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_317012", "317012036", "story_v_out_317012.awb")

						arg_151_1:RecordAudio("317012036", var_154_9)
						arg_151_1:RecordAudio("317012036", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_317012", "317012036", "story_v_out_317012.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_317012", "317012036", "story_v_out_317012.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_10 and arg_151_1.time_ < var_154_0 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play317012037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 317012037
		arg_155_1.duration_ = 5.93

		local var_155_0 = {
			zh = 1.5,
			ja = 5.933
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
				arg_155_0:Play317012038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.175

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[526].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:GetWordFromCfg(317012037)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012037", "story_v_out_317012.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012037", "story_v_out_317012.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_317012", "317012037", "story_v_out_317012.awb")

						arg_155_1:RecordAudio("317012037", var_158_9)
						arg_155_1:RecordAudio("317012037", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_317012", "317012037", "story_v_out_317012.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_317012", "317012037", "story_v_out_317012.awb")
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
	Play317012038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 317012038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play317012039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 1.175

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_2 = arg_159_1:GetWordFromCfg(317012038)
				local var_162_3 = arg_159_1:FormatText(var_162_2.content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 47
				local var_162_5 = utf8.len(var_162_3)
				local var_162_6 = var_162_4 <= 0 and var_162_1 or var_162_1 * (var_162_5 / var_162_4)

				if var_162_6 > 0 and var_162_1 < var_162_6 then
					arg_159_1.talkMaxDuration = var_162_6

					if var_162_6 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_7 and arg_159_1.time_ < var_162_0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play317012039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 317012039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play317012040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.375

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

				local var_166_2 = arg_163_1:GetWordFromCfg(317012039)
				local var_166_3 = arg_163_1:FormatText(var_166_2.content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 15
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
	Play317012040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 317012040
		arg_167_1.duration_ = 13

		local var_167_0 = {
			zh = 5.7,
			ja = 13
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
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play317012041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.475

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[36].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:GetWordFromCfg(317012040)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012040", "story_v_out_317012.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012040", "story_v_out_317012.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_317012", "317012040", "story_v_out_317012.awb")

						arg_167_1:RecordAudio("317012040", var_170_9)
						arg_167_1:RecordAudio("317012040", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_317012", "317012040", "story_v_out_317012.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_317012", "317012040", "story_v_out_317012.awb")
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
	Play317012041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 317012041
		arg_171_1.duration_ = 8.73

		local var_171_0 = {
			zh = 2.8,
			ja = 8.733
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
				arg_171_0:Play317012042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.325

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[526].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:GetWordFromCfg(317012041)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 13
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012041", "story_v_out_317012.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012041", "story_v_out_317012.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_317012", "317012041", "story_v_out_317012.awb")

						arg_171_1:RecordAudio("317012041", var_174_9)
						arg_171_1:RecordAudio("317012041", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_317012", "317012041", "story_v_out_317012.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_317012", "317012041", "story_v_out_317012.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_10 and arg_171_1.time_ < var_174_0 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play317012042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 317012042
		arg_175_1.duration_ = 10.1

		local var_175_0 = {
			zh = 6.166,
			ja = 10.1
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
				arg_175_0:Play317012043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.35

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[36].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_3 = arg_175_1:GetWordFromCfg(317012042)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012042", "story_v_out_317012.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012042", "story_v_out_317012.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_317012", "317012042", "story_v_out_317012.awb")

						arg_175_1:RecordAudio("317012042", var_178_9)
						arg_175_1:RecordAudio("317012042", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_317012", "317012042", "story_v_out_317012.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_317012", "317012042", "story_v_out_317012.awb")
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
	Play317012043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 317012043
		arg_179_1.duration_ = 7

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play317012044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = "STblack"

			if arg_179_1.bgs_[var_182_0] == nil then
				local var_182_1 = Object.Instantiate(arg_179_1.paintGo_)

				var_182_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_182_0)
				var_182_1.name = var_182_0
				var_182_1.transform.parent = arg_179_1.stage_.transform
				var_182_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_179_1.bgs_[var_182_0] = var_182_1
			end

			local var_182_2 = 0

			if var_182_2 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				local var_182_3 = manager.ui.mainCamera.transform.localPosition
				local var_182_4 = Vector3.New(0, 0, 10) + Vector3.New(var_182_3.x, var_182_3.y, 0)
				local var_182_5 = arg_179_1.bgs_.STblack

				var_182_5.transform.localPosition = var_182_4
				var_182_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_182_6 = var_182_5:GetComponent("SpriteRenderer")

				if var_182_6 and var_182_6.sprite then
					local var_182_7 = (var_182_5.transform.localPosition - var_182_3).z
					local var_182_8 = manager.ui.mainCameraCom_
					local var_182_9 = 2 * var_182_7 * Mathf.Tan(var_182_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_182_10 = var_182_9 * var_182_8.aspect
					local var_182_11 = var_182_6.sprite.bounds.size.x
					local var_182_12 = var_182_6.sprite.bounds.size.y
					local var_182_13 = var_182_10 / var_182_11
					local var_182_14 = var_182_9 / var_182_12
					local var_182_15 = var_182_14 < var_182_13 and var_182_13 or var_182_14

					var_182_5.transform.localScale = Vector3.New(var_182_15, var_182_15, 0)
				end

				for iter_182_0, iter_182_1 in pairs(arg_179_1.bgs_) do
					if iter_182_0 ~= "STblack" then
						iter_182_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_182_16 = 0

			if var_182_16 < arg_179_1.time_ and arg_179_1.time_ <= var_182_16 + arg_182_0 then
				arg_179_1.mask_.enabled = true
				arg_179_1.mask_.raycastTarget = true

				arg_179_1:SetGaussion(false)
			end

			local var_182_17 = 2

			if var_182_16 <= arg_179_1.time_ and arg_179_1.time_ < var_182_16 + var_182_17 then
				local var_182_18 = (arg_179_1.time_ - var_182_16) / var_182_17
				local var_182_19 = Color.New(0, 0, 0)

				var_182_19.a = Mathf.Lerp(1, 0, var_182_18)
				arg_179_1.mask_.color = var_182_19
			end

			if arg_179_1.time_ >= var_182_16 + var_182_17 and arg_179_1.time_ < var_182_16 + var_182_17 + arg_182_0 then
				local var_182_20 = Color.New(0, 0, 0)
				local var_182_21 = 0

				arg_179_1.mask_.enabled = false
				var_182_20.a = var_182_21
				arg_179_1.mask_.color = var_182_20
			end

			if arg_179_1.frameCnt_ <= 1 then
				arg_179_1.dialog_:SetActive(false)
			end

			local var_182_22 = 2
			local var_182_23 = 0.9

			if var_182_22 < arg_179_1.time_ and arg_179_1.time_ <= var_182_22 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0

				arg_179_1.dialog_:SetActive(true)

				arg_179_1.dialogCg_.alpha = 0

				local var_182_24 = LeanTween.value(arg_179_1.dialog_, 0, 1, 0.3)

				var_182_24:setOnUpdate(LuaHelper.FloatAction(function(arg_183_0)
					arg_179_1.dialogCg_.alpha = arg_183_0
				end))
				var_182_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_179_1.dialog_)
					var_182_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_179_1.duration_ = arg_179_1.duration_ + 0.3

				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_25 = arg_179_1:GetWordFromCfg(317012043)
				local var_182_26 = arg_179_1:FormatText(var_182_25.content)

				arg_179_1.text_.text = var_182_26

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_27 = 36
				local var_182_28 = utf8.len(var_182_26)
				local var_182_29 = var_182_27 <= 0 and var_182_23 or var_182_23 * (var_182_28 / var_182_27)

				if var_182_29 > 0 and var_182_23 < var_182_29 then
					arg_179_1.talkMaxDuration = var_182_29
					var_182_22 = var_182_22 + 0.3

					if var_182_29 + var_182_22 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_29 + var_182_22
					end
				end

				arg_179_1.text_.text = var_182_26
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_30 = var_182_22 + 0.3
			local var_182_31 = math.max(var_182_23, arg_179_1.talkMaxDuration)

			if var_182_30 <= arg_179_1.time_ and arg_179_1.time_ < var_182_30 + var_182_31 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_30) / var_182_31

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_30 + var_182_31 and arg_179_1.time_ < var_182_30 + var_182_31 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play317012044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 317012044
		arg_185_1.duration_ = 4.83

		local var_185_0 = {
			zh = 3.233,
			ja = 4.833
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
				arg_185_0:Play317012045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = "K02f"

			if arg_185_1.bgs_[var_188_0] == nil then
				local var_188_1 = Object.Instantiate(arg_185_1.paintGo_)

				var_188_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_188_0)
				var_188_1.name = var_188_0
				var_188_1.transform.parent = arg_185_1.stage_.transform
				var_188_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.bgs_[var_188_0] = var_188_1
			end

			local var_188_2 = 0

			if var_188_2 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				local var_188_3 = manager.ui.mainCamera.transform.localPosition
				local var_188_4 = Vector3.New(0, 0, 10) + Vector3.New(var_188_3.x, var_188_3.y, 0)
				local var_188_5 = arg_185_1.bgs_.K02f

				var_188_5.transform.localPosition = var_188_4
				var_188_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_188_6 = var_188_5:GetComponent("SpriteRenderer")

				if var_188_6 and var_188_6.sprite then
					local var_188_7 = (var_188_5.transform.localPosition - var_188_3).z
					local var_188_8 = manager.ui.mainCameraCom_
					local var_188_9 = 2 * var_188_7 * Mathf.Tan(var_188_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_188_10 = var_188_9 * var_188_8.aspect
					local var_188_11 = var_188_6.sprite.bounds.size.x
					local var_188_12 = var_188_6.sprite.bounds.size.y
					local var_188_13 = var_188_10 / var_188_11
					local var_188_14 = var_188_9 / var_188_12
					local var_188_15 = var_188_14 < var_188_13 and var_188_13 or var_188_14

					var_188_5.transform.localScale = Vector3.New(var_188_15, var_188_15, 0)
				end

				for iter_188_0, iter_188_1 in pairs(arg_185_1.bgs_) do
					if iter_188_0 ~= "K02f" then
						iter_188_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_17 = 2

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_17 then
				local var_188_18 = (arg_185_1.time_ - var_188_16) / var_188_17
				local var_188_19 = Color.New(0, 0, 0)

				var_188_19.a = Mathf.Lerp(1, 0, var_188_18)
				arg_185_1.mask_.color = var_188_19
			end

			if arg_185_1.time_ >= var_188_16 + var_188_17 and arg_185_1.time_ < var_188_16 + var_188_17 + arg_188_0 then
				local var_188_20 = Color.New(0, 0, 0)
				local var_188_21 = 0

				arg_185_1.mask_.enabled = false
				var_188_20.a = var_188_21
				arg_185_1.mask_.color = var_188_20
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_22 = 2
			local var_188_23 = 0.125

			if var_188_22 < arg_185_1.time_ and arg_185_1.time_ <= var_188_22 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_24 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_24:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_185_1.dialogCg_.alpha = arg_189_0
				end))
				var_188_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_25 = arg_185_1:FormatText(StoryNameCfg[527].name)

				arg_185_1.leftNameTxt_.text = var_188_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_26 = arg_185_1:GetWordFromCfg(317012044)
				local var_188_27 = arg_185_1:FormatText(var_188_26.content)

				arg_185_1.text_.text = var_188_27

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_28 = 5
				local var_188_29 = utf8.len(var_188_27)
				local var_188_30 = var_188_28 <= 0 and var_188_23 or var_188_23 * (var_188_29 / var_188_28)

				if var_188_30 > 0 and var_188_23 < var_188_30 then
					arg_185_1.talkMaxDuration = var_188_30
					var_188_22 = var_188_22 + 0.3

					if var_188_30 + var_188_22 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_30 + var_188_22
					end
				end

				arg_185_1.text_.text = var_188_27
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012044", "story_v_out_317012.awb") ~= 0 then
					local var_188_31 = manager.audio:GetVoiceLength("story_v_out_317012", "317012044", "story_v_out_317012.awb") / 1000

					if var_188_31 + var_188_22 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_31 + var_188_22
					end

					if var_188_26.prefab_name ~= "" and arg_185_1.actors_[var_188_26.prefab_name] ~= nil then
						local var_188_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_26.prefab_name].transform, "story_v_out_317012", "317012044", "story_v_out_317012.awb")

						arg_185_1:RecordAudio("317012044", var_188_32)
						arg_185_1:RecordAudio("317012044", var_188_32)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_317012", "317012044", "story_v_out_317012.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_317012", "317012044", "story_v_out_317012.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_33 = var_188_22 + 0.3
			local var_188_34 = math.max(var_188_23, arg_185_1.talkMaxDuration)

			if var_188_33 <= arg_185_1.time_ and arg_185_1.time_ < var_188_33 + var_188_34 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_33) / var_188_34

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_33 + var_188_34 and arg_185_1.time_ < var_188_33 + var_188_34 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play317012045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 317012045
		arg_191_1.duration_ = 7.7

		local var_191_0 = {
			zh = 7.7,
			ja = 7.433
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
				arg_191_0:Play317012046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.875

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[490].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:GetWordFromCfg(317012045)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012045", "story_v_out_317012.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012045", "story_v_out_317012.awb") / 1000

					if var_194_8 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_0
					end

					if var_194_3.prefab_name ~= "" and arg_191_1.actors_[var_194_3.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_3.prefab_name].transform, "story_v_out_317012", "317012045", "story_v_out_317012.awb")

						arg_191_1:RecordAudio("317012045", var_194_9)
						arg_191_1:RecordAudio("317012045", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_317012", "317012045", "story_v_out_317012.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_317012", "317012045", "story_v_out_317012.awb")
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
	Play317012046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 317012046
		arg_195_1.duration_ = 11

		local var_195_0 = {
			zh = 10.966,
			ja = 11
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
				arg_195_0:Play317012047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 1.225

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[527].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:GetWordFromCfg(317012046)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 49
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012046", "story_v_out_317012.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012046", "story_v_out_317012.awb") / 1000

					if var_198_8 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_0
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_317012", "317012046", "story_v_out_317012.awb")

						arg_195_1:RecordAudio("317012046", var_198_9)
						arg_195_1:RecordAudio("317012046", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_317012", "317012046", "story_v_out_317012.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_317012", "317012046", "story_v_out_317012.awb")
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
	Play317012047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 317012047
		arg_199_1.duration_ = 2.97

		local var_199_0 = {
			zh = 2.966,
			ja = 2.5
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
				arg_199_0:Play317012048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.2

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[490].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(317012047)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 8
				local var_202_6 = utf8.len(var_202_4)
				local var_202_7 = var_202_5 <= 0 and var_202_1 or var_202_1 * (var_202_6 / var_202_5)

				if var_202_7 > 0 and var_202_1 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012047", "story_v_out_317012.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012047", "story_v_out_317012.awb") / 1000

					if var_202_8 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_0
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_out_317012", "317012047", "story_v_out_317012.awb")

						arg_199_1:RecordAudio("317012047", var_202_9)
						arg_199_1:RecordAudio("317012047", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_317012", "317012047", "story_v_out_317012.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_317012", "317012047", "story_v_out_317012.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_10 and arg_199_1.time_ < var_202_0 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play317012048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 317012048
		arg_203_1.duration_ = 2.97

		local var_203_0 = {
			zh = 2.366,
			ja = 2.966
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
				arg_203_0:Play317012049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.15

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[527].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_3 = arg_203_1:GetWordFromCfg(317012048)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 6
				local var_206_6 = utf8.len(var_206_4)
				local var_206_7 = var_206_5 <= 0 and var_206_1 or var_206_1 * (var_206_6 / var_206_5)

				if var_206_7 > 0 and var_206_1 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012048", "story_v_out_317012.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012048", "story_v_out_317012.awb") / 1000

					if var_206_8 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_0
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_317012", "317012048", "story_v_out_317012.awb")

						arg_203_1:RecordAudio("317012048", var_206_9)
						arg_203_1:RecordAudio("317012048", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_317012", "317012048", "story_v_out_317012.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_317012", "317012048", "story_v_out_317012.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_10 and arg_203_1.time_ < var_206_0 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play317012049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 317012049
		arg_207_1.duration_ = 7.2

		local var_207_0 = {
			zh = 4.1,
			ja = 7.2
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
				arg_207_0:Play317012050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.425

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[490].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:GetWordFromCfg(317012049)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012049", "story_v_out_317012.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012049", "story_v_out_317012.awb") / 1000

					if var_210_8 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_0
					end

					if var_210_3.prefab_name ~= "" and arg_207_1.actors_[var_210_3.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_3.prefab_name].transform, "story_v_out_317012", "317012049", "story_v_out_317012.awb")

						arg_207_1:RecordAudio("317012049", var_210_9)
						arg_207_1:RecordAudio("317012049", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_317012", "317012049", "story_v_out_317012.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_317012", "317012049", "story_v_out_317012.awb")
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
	Play317012050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 317012050
		arg_211_1.duration_ = 2.9

		local var_211_0 = {
			zh = 1.533,
			ja = 2.9
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
				arg_211_0:Play317012051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 0.175

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_2 = arg_211_1:FormatText(StoryNameCfg[527].name)

				arg_211_1.leftNameTxt_.text = var_214_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_3 = arg_211_1:GetWordFromCfg(317012050)
				local var_214_4 = arg_211_1:FormatText(var_214_3.content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 7
				local var_214_6 = utf8.len(var_214_4)
				local var_214_7 = var_214_5 <= 0 and var_214_1 or var_214_1 * (var_214_6 / var_214_5)

				if var_214_7 > 0 and var_214_1 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_4
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012050", "story_v_out_317012.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012050", "story_v_out_317012.awb") / 1000

					if var_214_8 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_0
					end

					if var_214_3.prefab_name ~= "" and arg_211_1.actors_[var_214_3.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_3.prefab_name].transform, "story_v_out_317012", "317012050", "story_v_out_317012.awb")

						arg_211_1:RecordAudio("317012050", var_214_9)
						arg_211_1:RecordAudio("317012050", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_317012", "317012050", "story_v_out_317012.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_317012", "317012050", "story_v_out_317012.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_10 and arg_211_1.time_ < var_214_0 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play317012051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 317012051
		arg_215_1.duration_ = 13.97

		local var_215_0 = {
			zh = 10.233,
			ja = 13.966
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
				arg_215_0:Play317012052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 1.075

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_2 = arg_215_1:FormatText(StoryNameCfg[490].name)

				arg_215_1.leftNameTxt_.text = var_218_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:GetWordFromCfg(317012051)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 43
				local var_218_6 = utf8.len(var_218_4)
				local var_218_7 = var_218_5 <= 0 and var_218_1 or var_218_1 * (var_218_6 / var_218_5)

				if var_218_7 > 0 and var_218_1 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_4
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012051", "story_v_out_317012.awb") ~= 0 then
					local var_218_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012051", "story_v_out_317012.awb") / 1000

					if var_218_8 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_0
					end

					if var_218_3.prefab_name ~= "" and arg_215_1.actors_[var_218_3.prefab_name] ~= nil then
						local var_218_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_3.prefab_name].transform, "story_v_out_317012", "317012051", "story_v_out_317012.awb")

						arg_215_1:RecordAudio("317012051", var_218_9)
						arg_215_1:RecordAudio("317012051", var_218_9)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_317012", "317012051", "story_v_out_317012.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_317012", "317012051", "story_v_out_317012.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_10 and arg_215_1.time_ < var_218_0 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play317012052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 317012052
		arg_219_1.duration_ = 4.97

		local var_219_0 = {
			zh = 4.633,
			ja = 4.966
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
				arg_219_0:Play317012053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.45

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[490].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:GetWordFromCfg(317012052)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012052", "story_v_out_317012.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012052", "story_v_out_317012.awb") / 1000

					if var_222_8 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_0
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_317012", "317012052", "story_v_out_317012.awb")

						arg_219_1:RecordAudio("317012052", var_222_9)
						arg_219_1:RecordAudio("317012052", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_317012", "317012052", "story_v_out_317012.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_317012", "317012052", "story_v_out_317012.awb")
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
	Play317012053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 317012053
		arg_223_1.duration_ = 6.93

		local var_223_0 = {
			zh = 5.366,
			ja = 6.933
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
				arg_223_0:Play317012054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.725

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_2 = arg_223_1:FormatText(StoryNameCfg[527].name)

				arg_223_1.leftNameTxt_.text = var_226_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:GetWordFromCfg(317012053)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 29
				local var_226_6 = utf8.len(var_226_4)
				local var_226_7 = var_226_5 <= 0 and var_226_1 or var_226_1 * (var_226_6 / var_226_5)

				if var_226_7 > 0 and var_226_1 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012053", "story_v_out_317012.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012053", "story_v_out_317012.awb") / 1000

					if var_226_8 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_0
					end

					if var_226_3.prefab_name ~= "" and arg_223_1.actors_[var_226_3.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_3.prefab_name].transform, "story_v_out_317012", "317012053", "story_v_out_317012.awb")

						arg_223_1:RecordAudio("317012053", var_226_9)
						arg_223_1:RecordAudio("317012053", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_317012", "317012053", "story_v_out_317012.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_317012", "317012053", "story_v_out_317012.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_10 and arg_223_1.time_ < var_226_0 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play317012054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 317012054
		arg_227_1.duration_ = 4.5

		local var_227_0 = {
			zh = 4.5,
			ja = 3.6
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
				arg_227_0:Play317012055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.35

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[490].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:GetWordFromCfg(317012054)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 14
				local var_230_6 = utf8.len(var_230_4)
				local var_230_7 = var_230_5 <= 0 and var_230_1 or var_230_1 * (var_230_6 / var_230_5)

				if var_230_7 > 0 and var_230_1 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_4
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012054", "story_v_out_317012.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012054", "story_v_out_317012.awb") / 1000

					if var_230_8 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_0
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_out_317012", "317012054", "story_v_out_317012.awb")

						arg_227_1:RecordAudio("317012054", var_230_9)
						arg_227_1:RecordAudio("317012054", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_317012", "317012054", "story_v_out_317012.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_317012", "317012054", "story_v_out_317012.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_10 and arg_227_1.time_ < var_230_0 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play317012055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 317012055
		arg_231_1.duration_ = 5.1

		local var_231_0 = {
			zh = 5.1,
			ja = 4.633
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
				arg_231_0:Play317012056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 0.275

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[527].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:GetWordFromCfg(317012055)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012055", "story_v_out_317012.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012055", "story_v_out_317012.awb") / 1000

					if var_234_8 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_0
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_out_317012", "317012055", "story_v_out_317012.awb")

						arg_231_1:RecordAudio("317012055", var_234_9)
						arg_231_1:RecordAudio("317012055", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_317012", "317012055", "story_v_out_317012.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_317012", "317012055", "story_v_out_317012.awb")
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
	Play317012056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 317012056
		arg_235_1.duration_ = 7

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play317012057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = "STwhite"

			if arg_235_1.bgs_[var_238_0] == nil then
				local var_238_1 = Object.Instantiate(arg_235_1.paintGo_)

				var_238_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_238_0)
				var_238_1.name = var_238_0
				var_238_1.transform.parent = arg_235_1.stage_.transform
				var_238_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_235_1.bgs_[var_238_0] = var_238_1
			end

			local var_238_2 = 0

			if var_238_2 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 then
				local var_238_3 = manager.ui.mainCamera.transform.localPosition
				local var_238_4 = Vector3.New(0, 0, 10) + Vector3.New(var_238_3.x, var_238_3.y, 0)
				local var_238_5 = arg_235_1.bgs_.STwhite

				var_238_5.transform.localPosition = var_238_4
				var_238_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_238_6 = var_238_5:GetComponent("SpriteRenderer")

				if var_238_6 and var_238_6.sprite then
					local var_238_7 = (var_238_5.transform.localPosition - var_238_3).z
					local var_238_8 = manager.ui.mainCameraCom_
					local var_238_9 = 2 * var_238_7 * Mathf.Tan(var_238_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_238_10 = var_238_9 * var_238_8.aspect
					local var_238_11 = var_238_6.sprite.bounds.size.x
					local var_238_12 = var_238_6.sprite.bounds.size.y
					local var_238_13 = var_238_10 / var_238_11
					local var_238_14 = var_238_9 / var_238_12
					local var_238_15 = var_238_14 < var_238_13 and var_238_13 or var_238_14

					var_238_5.transform.localScale = Vector3.New(var_238_15, var_238_15, 0)
				end

				for iter_238_0, iter_238_1 in pairs(arg_235_1.bgs_) do
					if iter_238_0 ~= "STwhite" then
						iter_238_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_238_16 = 0

			if var_238_16 < arg_235_1.time_ and arg_235_1.time_ <= var_238_16 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_17 = 2

			if var_238_16 <= arg_235_1.time_ and arg_235_1.time_ < var_238_16 + var_238_17 then
				local var_238_18 = (arg_235_1.time_ - var_238_16) / var_238_17
				local var_238_19 = Color.New(0, 0, 0)

				var_238_19.a = Mathf.Lerp(1, 0, var_238_18)
				arg_235_1.mask_.color = var_238_19
			end

			if arg_235_1.time_ >= var_238_16 + var_238_17 and arg_235_1.time_ < var_238_16 + var_238_17 + arg_238_0 then
				local var_238_20 = Color.New(0, 0, 0)
				local var_238_21 = 0

				arg_235_1.mask_.enabled = false
				var_238_20.a = var_238_21
				arg_235_1.mask_.color = var_238_20
			end

			local var_238_22 = 0
			local var_238_23 = 1

			if var_238_22 < arg_235_1.time_ and arg_235_1.time_ <= var_238_22 + arg_238_0 then
				local var_238_24 = "play"
				local var_238_25 = "music"

				arg_235_1:AudioAction(var_238_24, var_238_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_238_26 = ""
				local var_238_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_238_27 ~= "" then
					if arg_235_1.bgmTxt_.text ~= var_238_27 and arg_235_1.bgmTxt_.text ~= "" then
						if arg_235_1.bgmTxt2_.text ~= "" then
							arg_235_1.bgmTxt_.text = arg_235_1.bgmTxt2_.text
						end

						arg_235_1.bgmTxt2_.text = var_238_27

						arg_235_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_235_1.bgmTxt_.text = var_238_27
						arg_235_1.bgmTxt2_.text = var_238_27
					end

					if arg_235_1.bgmTimer then
						arg_235_1.bgmTimer:Stop()

						arg_235_1.bgmTimer = nil
					end

					if arg_235_1.settingData.show_music_name == 1 then
						arg_235_1.musicController:SetSelectedState("show")
						arg_235_1.musicAnimator_:Play("open", 0, 0)

						if arg_235_1.settingData.music_time ~= 0 then
							arg_235_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_235_1.settingData.music_time), function()
								if arg_235_1 == nil or isNil(arg_235_1.bgmTxt_) then
									return
								end

								arg_235_1.musicController:SetSelectedState("hide")
								arg_235_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_235_1.frameCnt_ <= 1 then
				arg_235_1.dialog_:SetActive(false)
			end

			local var_238_28 = 2
			local var_238_29 = 1.2

			if var_238_28 < arg_235_1.time_ and arg_235_1.time_ <= var_238_28 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0

				arg_235_1.dialog_:SetActive(true)

				arg_235_1.dialogCg_.alpha = 0

				local var_238_30 = LeanTween.value(arg_235_1.dialog_, 0, 1, 0.3)

				var_238_30:setOnUpdate(LuaHelper.FloatAction(function(arg_240_0)
					arg_235_1.dialogCg_.alpha = arg_240_0
				end))
				var_238_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_235_1.dialog_)
					var_238_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_235_1.duration_ = arg_235_1.duration_ + 0.3

				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_31 = arg_235_1:GetWordFromCfg(317012056)
				local var_238_32 = arg_235_1:FormatText(var_238_31.content)

				arg_235_1.text_.text = var_238_32

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_33 = 48
				local var_238_34 = utf8.len(var_238_32)
				local var_238_35 = var_238_33 <= 0 and var_238_29 or var_238_29 * (var_238_34 / var_238_33)

				if var_238_35 > 0 and var_238_29 < var_238_35 then
					arg_235_1.talkMaxDuration = var_238_35
					var_238_28 = var_238_28 + 0.3

					if var_238_35 + var_238_28 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_35 + var_238_28
					end
				end

				arg_235_1.text_.text = var_238_32
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_36 = var_238_28 + 0.3
			local var_238_37 = math.max(var_238_29, arg_235_1.talkMaxDuration)

			if var_238_36 <= arg_235_1.time_ and arg_235_1.time_ < var_238_36 + var_238_37 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_36) / var_238_37

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_36 + var_238_37 and arg_235_1.time_ < var_238_36 + var_238_37 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play317012057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 317012057
		arg_242_1.duration_ = 7

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play317012058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = "K06f"

			if arg_242_1.bgs_[var_245_0] == nil then
				local var_245_1 = Object.Instantiate(arg_242_1.paintGo_)

				var_245_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_245_0)
				var_245_1.name = var_245_0
				var_245_1.transform.parent = arg_242_1.stage_.transform
				var_245_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_242_1.bgs_[var_245_0] = var_245_1
			end

			local var_245_2 = 0

			if var_245_2 < arg_242_1.time_ and arg_242_1.time_ <= var_245_2 + arg_245_0 then
				local var_245_3 = manager.ui.mainCamera.transform.localPosition
				local var_245_4 = Vector3.New(0, 0, 10) + Vector3.New(var_245_3.x, var_245_3.y, 0)
				local var_245_5 = arg_242_1.bgs_.K06f

				var_245_5.transform.localPosition = var_245_4
				var_245_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_245_6 = var_245_5:GetComponent("SpriteRenderer")

				if var_245_6 and var_245_6.sprite then
					local var_245_7 = (var_245_5.transform.localPosition - var_245_3).z
					local var_245_8 = manager.ui.mainCameraCom_
					local var_245_9 = 2 * var_245_7 * Mathf.Tan(var_245_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_245_10 = var_245_9 * var_245_8.aspect
					local var_245_11 = var_245_6.sprite.bounds.size.x
					local var_245_12 = var_245_6.sprite.bounds.size.y
					local var_245_13 = var_245_10 / var_245_11
					local var_245_14 = var_245_9 / var_245_12
					local var_245_15 = var_245_14 < var_245_13 and var_245_13 or var_245_14

					var_245_5.transform.localScale = Vector3.New(var_245_15, var_245_15, 0)
				end

				for iter_245_0, iter_245_1 in pairs(arg_242_1.bgs_) do
					if iter_245_0 ~= "K06f" then
						iter_245_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_245_16 = 0

			if var_245_16 < arg_242_1.time_ and arg_242_1.time_ <= var_245_16 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_17 = 2

			if var_245_16 <= arg_242_1.time_ and arg_242_1.time_ < var_245_16 + var_245_17 then
				local var_245_18 = (arg_242_1.time_ - var_245_16) / var_245_17
				local var_245_19 = Color.New(0, 0, 0)

				var_245_19.a = Mathf.Lerp(1, 0, var_245_18)
				arg_242_1.mask_.color = var_245_19
			end

			if arg_242_1.time_ >= var_245_16 + var_245_17 and arg_242_1.time_ < var_245_16 + var_245_17 + arg_245_0 then
				local var_245_20 = Color.New(0, 0, 0)
				local var_245_21 = 0

				arg_242_1.mask_.enabled = false
				var_245_20.a = var_245_21
				arg_242_1.mask_.color = var_245_20
			end

			local var_245_22 = 0
			local var_245_23 = 1

			if var_245_22 < arg_242_1.time_ and arg_242_1.time_ <= var_245_22 + arg_245_0 then
				local var_245_24 = "play"
				local var_245_25 = "music"

				arg_242_1:AudioAction(var_245_24, var_245_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_245_26 = ""
				local var_245_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_245_27 ~= "" then
					if arg_242_1.bgmTxt_.text ~= var_245_27 and arg_242_1.bgmTxt_.text ~= "" then
						if arg_242_1.bgmTxt2_.text ~= "" then
							arg_242_1.bgmTxt_.text = arg_242_1.bgmTxt2_.text
						end

						arg_242_1.bgmTxt2_.text = var_245_27

						arg_242_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_242_1.bgmTxt_.text = var_245_27
						arg_242_1.bgmTxt2_.text = var_245_27
					end

					if arg_242_1.bgmTimer then
						arg_242_1.bgmTimer:Stop()

						arg_242_1.bgmTimer = nil
					end

					if arg_242_1.settingData.show_music_name == 1 then
						arg_242_1.musicController:SetSelectedState("show")
						arg_242_1.musicAnimator_:Play("open", 0, 0)

						if arg_242_1.settingData.music_time ~= 0 then
							arg_242_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_242_1.settingData.music_time), function()
								if arg_242_1 == nil or isNil(arg_242_1.bgmTxt_) then
									return
								end

								arg_242_1.musicController:SetSelectedState("hide")
								arg_242_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_245_28 = 1.56666666666667
			local var_245_29 = 1

			if var_245_28 < arg_242_1.time_ and arg_242_1.time_ <= var_245_28 + arg_245_0 then
				local var_245_30 = "play"
				local var_245_31 = "music"

				arg_242_1:AudioAction(var_245_30, var_245_31, "bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu.awb")

				local var_245_32 = ""
				local var_245_33 = manager.audio:GetAudioName("bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu")

				if var_245_33 ~= "" then
					if arg_242_1.bgmTxt_.text ~= var_245_33 and arg_242_1.bgmTxt_.text ~= "" then
						if arg_242_1.bgmTxt2_.text ~= "" then
							arg_242_1.bgmTxt_.text = arg_242_1.bgmTxt2_.text
						end

						arg_242_1.bgmTxt2_.text = var_245_33

						arg_242_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_242_1.bgmTxt_.text = var_245_33
						arg_242_1.bgmTxt2_.text = var_245_33
					end

					if arg_242_1.bgmTimer then
						arg_242_1.bgmTimer:Stop()

						arg_242_1.bgmTimer = nil
					end

					if arg_242_1.settingData.show_music_name == 1 then
						arg_242_1.musicController:SetSelectedState("show")
						arg_242_1.musicAnimator_:Play("open", 0, 0)

						if arg_242_1.settingData.music_time ~= 0 then
							arg_242_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_242_1.settingData.music_time), function()
								if arg_242_1 == nil or isNil(arg_242_1.bgmTxt_) then
									return
								end

								arg_242_1.musicController:SetSelectedState("hide")
								arg_242_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_242_1.frameCnt_ <= 1 then
				arg_242_1.dialog_:SetActive(false)
			end

			local var_245_34 = 2
			local var_245_35 = 1.425

			if var_245_34 < arg_242_1.time_ and arg_242_1.time_ <= var_245_34 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0

				arg_242_1.dialog_:SetActive(true)

				arg_242_1.dialogCg_.alpha = 0

				local var_245_36 = LeanTween.value(arg_242_1.dialog_, 0, 1, 0.3)

				var_245_36:setOnUpdate(LuaHelper.FloatAction(function(arg_248_0)
					arg_242_1.dialogCg_.alpha = arg_248_0
				end))
				var_245_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_242_1.dialog_)
					var_245_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_242_1.duration_ = arg_242_1.duration_ + 0.3

				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_37 = arg_242_1:GetWordFromCfg(317012057)
				local var_245_38 = arg_242_1:FormatText(var_245_37.content)

				arg_242_1.text_.text = var_245_38

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_39 = 57
				local var_245_40 = utf8.len(var_245_38)
				local var_245_41 = var_245_39 <= 0 and var_245_35 or var_245_35 * (var_245_40 / var_245_39)

				if var_245_41 > 0 and var_245_35 < var_245_41 then
					arg_242_1.talkMaxDuration = var_245_41
					var_245_34 = var_245_34 + 0.3

					if var_245_41 + var_245_34 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_41 + var_245_34
					end
				end

				arg_242_1.text_.text = var_245_38
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_42 = var_245_34 + 0.3
			local var_245_43 = math.max(var_245_35, arg_242_1.talkMaxDuration)

			if var_245_42 <= arg_242_1.time_ and arg_242_1.time_ < var_245_42 + var_245_43 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_42) / var_245_43

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_42 + var_245_43 and arg_242_1.time_ < var_245_42 + var_245_43 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play317012058 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 317012058
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play317012059(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 1.725

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_2 = arg_250_1:GetWordFromCfg(317012058)
				local var_253_3 = arg_250_1:FormatText(var_253_2.content)

				arg_250_1.text_.text = var_253_3

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 69
				local var_253_5 = utf8.len(var_253_3)
				local var_253_6 = var_253_4 <= 0 and var_253_1 or var_253_1 * (var_253_5 / var_253_4)

				if var_253_6 > 0 and var_253_1 < var_253_6 then
					arg_250_1.talkMaxDuration = var_253_6

					if var_253_6 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_6 + var_253_0
					end
				end

				arg_250_1.text_.text = var_253_3
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_7 and arg_250_1.time_ < var_253_0 + var_253_7 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play317012059 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 317012059
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play317012060(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0
			local var_257_1 = 0.7

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_2 = arg_254_1:GetWordFromCfg(317012059)
				local var_257_3 = arg_254_1:FormatText(var_257_2.content)

				arg_254_1.text_.text = var_257_3

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_4 = 28
				local var_257_5 = utf8.len(var_257_3)
				local var_257_6 = var_257_4 <= 0 and var_257_1 or var_257_1 * (var_257_5 / var_257_4)

				if var_257_6 > 0 and var_257_1 < var_257_6 then
					arg_254_1.talkMaxDuration = var_257_6

					if var_257_6 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_6 + var_257_0
					end
				end

				arg_254_1.text_.text = var_257_3
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_7 = math.max(var_257_1, arg_254_1.talkMaxDuration)

			if var_257_0 <= arg_254_1.time_ and arg_254_1.time_ < var_257_0 + var_257_7 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_0) / var_257_7

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_0 + var_257_7 and arg_254_1.time_ < var_257_0 + var_257_7 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play317012060 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 317012060
		arg_258_1.duration_ = 4

		local var_258_0 = {
			zh = 3.8,
			ja = 4
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play317012061(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0
			local var_261_1 = 0.45

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_2 = arg_258_1:FormatText(StoryNameCfg[101].name)

				arg_258_1.leftNameTxt_.text = var_261_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_3 = arg_258_1:GetWordFromCfg(317012060)
				local var_261_4 = arg_258_1:FormatText(var_261_3.content)

				arg_258_1.text_.text = var_261_4

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 18
				local var_261_6 = utf8.len(var_261_4)
				local var_261_7 = var_261_5 <= 0 and var_261_1 or var_261_1 * (var_261_6 / var_261_5)

				if var_261_7 > 0 and var_261_1 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_0
					end
				end

				arg_258_1.text_.text = var_261_4
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012060", "story_v_out_317012.awb") ~= 0 then
					local var_261_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012060", "story_v_out_317012.awb") / 1000

					if var_261_8 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_8 + var_261_0
					end

					if var_261_3.prefab_name ~= "" and arg_258_1.actors_[var_261_3.prefab_name] ~= nil then
						local var_261_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_3.prefab_name].transform, "story_v_out_317012", "317012060", "story_v_out_317012.awb")

						arg_258_1:RecordAudio("317012060", var_261_9)
						arg_258_1:RecordAudio("317012060", var_261_9)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_317012", "317012060", "story_v_out_317012.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_317012", "317012060", "story_v_out_317012.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_10 = math.max(var_261_1, arg_258_1.talkMaxDuration)

			if var_261_0 <= arg_258_1.time_ and arg_258_1.time_ < var_261_0 + var_261_10 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_0) / var_261_10

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_0 + var_261_10 and arg_258_1.time_ < var_261_0 + var_261_10 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play317012061 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 317012061
		arg_262_1.duration_ = 5.6

		local var_262_0 = {
			zh = 4.666,
			ja = 5.6
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play317012062(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0
			local var_265_1 = 0.525

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_2 = arg_262_1:FormatText(StoryNameCfg[394].name)

				arg_262_1.leftNameTxt_.text = var_265_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_3 = arg_262_1:GetWordFromCfg(317012061)
				local var_265_4 = arg_262_1:FormatText(var_265_3.content)

				arg_262_1.text_.text = var_265_4

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_5 = 21
				local var_265_6 = utf8.len(var_265_4)
				local var_265_7 = var_265_5 <= 0 and var_265_1 or var_265_1 * (var_265_6 / var_265_5)

				if var_265_7 > 0 and var_265_1 < var_265_7 then
					arg_262_1.talkMaxDuration = var_265_7

					if var_265_7 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_0
					end
				end

				arg_262_1.text_.text = var_265_4
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012061", "story_v_out_317012.awb") ~= 0 then
					local var_265_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012061", "story_v_out_317012.awb") / 1000

					if var_265_8 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_8 + var_265_0
					end

					if var_265_3.prefab_name ~= "" and arg_262_1.actors_[var_265_3.prefab_name] ~= nil then
						local var_265_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_3.prefab_name].transform, "story_v_out_317012", "317012061", "story_v_out_317012.awb")

						arg_262_1:RecordAudio("317012061", var_265_9)
						arg_262_1:RecordAudio("317012061", var_265_9)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_317012", "317012061", "story_v_out_317012.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_317012", "317012061", "story_v_out_317012.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_10 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_10 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_10

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_10 and arg_262_1.time_ < var_265_0 + var_265_10 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play317012062 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 317012062
		arg_266_1.duration_ = 8.63

		local var_266_0 = {
			zh = 5.8,
			ja = 8.633
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play317012063(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 0.4

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_2 = arg_266_1:FormatText(StoryNameCfg[101].name)

				arg_266_1.leftNameTxt_.text = var_269_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_3 = arg_266_1:GetWordFromCfg(317012062)
				local var_269_4 = arg_266_1:FormatText(var_269_3.content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 16
				local var_269_6 = utf8.len(var_269_4)
				local var_269_7 = var_269_5 <= 0 and var_269_1 or var_269_1 * (var_269_6 / var_269_5)

				if var_269_7 > 0 and var_269_1 < var_269_7 then
					arg_266_1.talkMaxDuration = var_269_7

					if var_269_7 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_7 + var_269_0
					end
				end

				arg_266_1.text_.text = var_269_4
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012062", "story_v_out_317012.awb") ~= 0 then
					local var_269_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012062", "story_v_out_317012.awb") / 1000

					if var_269_8 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_8 + var_269_0
					end

					if var_269_3.prefab_name ~= "" and arg_266_1.actors_[var_269_3.prefab_name] ~= nil then
						local var_269_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_3.prefab_name].transform, "story_v_out_317012", "317012062", "story_v_out_317012.awb")

						arg_266_1:RecordAudio("317012062", var_269_9)
						arg_266_1:RecordAudio("317012062", var_269_9)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_317012", "317012062", "story_v_out_317012.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_317012", "317012062", "story_v_out_317012.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_10 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_10 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_10

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_10 and arg_266_1.time_ < var_269_0 + var_269_10 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play317012063 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 317012063
		arg_270_1.duration_ = 9.8

		local var_270_0 = {
			zh = 5.3,
			ja = 9.8
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play317012064(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 0.525

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[394].name)

				arg_270_1.leftNameTxt_.text = var_273_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_3 = arg_270_1:GetWordFromCfg(317012063)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 21
				local var_273_6 = utf8.len(var_273_4)
				local var_273_7 = var_273_5 <= 0 and var_273_1 or var_273_1 * (var_273_6 / var_273_5)

				if var_273_7 > 0 and var_273_1 < var_273_7 then
					arg_270_1.talkMaxDuration = var_273_7

					if var_273_7 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_4
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012063", "story_v_out_317012.awb") ~= 0 then
					local var_273_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012063", "story_v_out_317012.awb") / 1000

					if var_273_8 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_8 + var_273_0
					end

					if var_273_3.prefab_name ~= "" and arg_270_1.actors_[var_273_3.prefab_name] ~= nil then
						local var_273_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_3.prefab_name].transform, "story_v_out_317012", "317012063", "story_v_out_317012.awb")

						arg_270_1:RecordAudio("317012063", var_273_9)
						arg_270_1:RecordAudio("317012063", var_273_9)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_317012", "317012063", "story_v_out_317012.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_317012", "317012063", "story_v_out_317012.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_10 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_10 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_10

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_10 and arg_270_1.time_ < var_273_0 + var_273_10 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play317012064 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 317012064
		arg_274_1.duration_ = 14.03

		local var_274_0 = {
			zh = 5.1,
			ja = 14.033
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play317012065(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 0.575

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_2 = arg_274_1:FormatText(StoryNameCfg[101].name)

				arg_274_1.leftNameTxt_.text = var_277_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_3 = arg_274_1:GetWordFromCfg(317012064)
				local var_277_4 = arg_274_1:FormatText(var_277_3.content)

				arg_274_1.text_.text = var_277_4

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 23
				local var_277_6 = utf8.len(var_277_4)
				local var_277_7 = var_277_5 <= 0 and var_277_1 or var_277_1 * (var_277_6 / var_277_5)

				if var_277_7 > 0 and var_277_1 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_4
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012064", "story_v_out_317012.awb") ~= 0 then
					local var_277_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012064", "story_v_out_317012.awb") / 1000

					if var_277_8 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_0
					end

					if var_277_3.prefab_name ~= "" and arg_274_1.actors_[var_277_3.prefab_name] ~= nil then
						local var_277_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_3.prefab_name].transform, "story_v_out_317012", "317012064", "story_v_out_317012.awb")

						arg_274_1:RecordAudio("317012064", var_277_9)
						arg_274_1:RecordAudio("317012064", var_277_9)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_317012", "317012064", "story_v_out_317012.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_317012", "317012064", "story_v_out_317012.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_10 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_10 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_10

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_10 and arg_274_1.time_ < var_277_0 + var_277_10 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play317012065 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 317012065
		arg_278_1.duration_ = 4.23

		local var_278_0 = {
			zh = 2.533,
			ja = 4.233
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play317012066(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 0.225

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_2 = arg_278_1:FormatText(StoryNameCfg[394].name)

				arg_278_1.leftNameTxt_.text = var_281_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_3 = arg_278_1:GetWordFromCfg(317012065)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 9
				local var_281_6 = utf8.len(var_281_4)
				local var_281_7 = var_281_5 <= 0 and var_281_1 or var_281_1 * (var_281_6 / var_281_5)

				if var_281_7 > 0 and var_281_1 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7

					if var_281_7 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_4
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012065", "story_v_out_317012.awb") ~= 0 then
					local var_281_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012065", "story_v_out_317012.awb") / 1000

					if var_281_8 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_8 + var_281_0
					end

					if var_281_3.prefab_name ~= "" and arg_278_1.actors_[var_281_3.prefab_name] ~= nil then
						local var_281_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_3.prefab_name].transform, "story_v_out_317012", "317012065", "story_v_out_317012.awb")

						arg_278_1:RecordAudio("317012065", var_281_9)
						arg_278_1:RecordAudio("317012065", var_281_9)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_317012", "317012065", "story_v_out_317012.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_317012", "317012065", "story_v_out_317012.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_10 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_10 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_10

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_10 and arg_278_1.time_ < var_281_0 + var_281_10 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play317012066 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 317012066
		arg_282_1.duration_ = 17

		local var_282_0 = {
			zh = 17,
			ja = 14.066
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play317012067(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0
			local var_285_1 = 1.675

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_2 = arg_282_1:FormatText(StoryNameCfg[101].name)

				arg_282_1.leftNameTxt_.text = var_285_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_3 = arg_282_1:GetWordFromCfg(317012066)
				local var_285_4 = arg_282_1:FormatText(var_285_3.content)

				arg_282_1.text_.text = var_285_4

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 68
				local var_285_6 = utf8.len(var_285_4)
				local var_285_7 = var_285_5 <= 0 and var_285_1 or var_285_1 * (var_285_6 / var_285_5)

				if var_285_7 > 0 and var_285_1 < var_285_7 then
					arg_282_1.talkMaxDuration = var_285_7

					if var_285_7 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_7 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_4
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012066", "story_v_out_317012.awb") ~= 0 then
					local var_285_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012066", "story_v_out_317012.awb") / 1000

					if var_285_8 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_8 + var_285_0
					end

					if var_285_3.prefab_name ~= "" and arg_282_1.actors_[var_285_3.prefab_name] ~= nil then
						local var_285_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_3.prefab_name].transform, "story_v_out_317012", "317012066", "story_v_out_317012.awb")

						arg_282_1:RecordAudio("317012066", var_285_9)
						arg_282_1:RecordAudio("317012066", var_285_9)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_317012", "317012066", "story_v_out_317012.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_317012", "317012066", "story_v_out_317012.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_10 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_10 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_10

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_10 and arg_282_1.time_ < var_285_0 + var_285_10 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play317012067 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 317012067
		arg_286_1.duration_ = 5.6

		local var_286_0 = {
			zh = 3.666,
			ja = 5.6
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play317012068(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.425

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_2 = arg_286_1:FormatText(StoryNameCfg[394].name)

				arg_286_1.leftNameTxt_.text = var_289_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_3 = arg_286_1:GetWordFromCfg(317012067)
				local var_289_4 = arg_286_1:FormatText(var_289_3.content)

				arg_286_1.text_.text = var_289_4

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 17
				local var_289_6 = utf8.len(var_289_4)
				local var_289_7 = var_289_5 <= 0 and var_289_1 or var_289_1 * (var_289_6 / var_289_5)

				if var_289_7 > 0 and var_289_1 < var_289_7 then
					arg_286_1.talkMaxDuration = var_289_7

					if var_289_7 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_4
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012067", "story_v_out_317012.awb") ~= 0 then
					local var_289_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012067", "story_v_out_317012.awb") / 1000

					if var_289_8 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_8 + var_289_0
					end

					if var_289_3.prefab_name ~= "" and arg_286_1.actors_[var_289_3.prefab_name] ~= nil then
						local var_289_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_3.prefab_name].transform, "story_v_out_317012", "317012067", "story_v_out_317012.awb")

						arg_286_1:RecordAudio("317012067", var_289_9)
						arg_286_1:RecordAudio("317012067", var_289_9)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_317012", "317012067", "story_v_out_317012.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_317012", "317012067", "story_v_out_317012.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_10 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_10 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_10

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_10 and arg_286_1.time_ < var_289_0 + var_289_10 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play317012068 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 317012068
		arg_290_1.duration_ = 8.7

		local var_290_0 = {
			zh = 8.7,
			ja = 7.733
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play317012069(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 0.975

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_2 = arg_290_1:FormatText(StoryNameCfg[101].name)

				arg_290_1.leftNameTxt_.text = var_293_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:GetWordFromCfg(317012068)
				local var_293_4 = arg_290_1:FormatText(var_293_3.content)

				arg_290_1.text_.text = var_293_4

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 39
				local var_293_6 = utf8.len(var_293_4)
				local var_293_7 = var_293_5 <= 0 and var_293_1 or var_293_1 * (var_293_6 / var_293_5)

				if var_293_7 > 0 and var_293_1 < var_293_7 then
					arg_290_1.talkMaxDuration = var_293_7

					if var_293_7 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_7 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_4
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012068", "story_v_out_317012.awb") ~= 0 then
					local var_293_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012068", "story_v_out_317012.awb") / 1000

					if var_293_8 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_8 + var_293_0
					end

					if var_293_3.prefab_name ~= "" and arg_290_1.actors_[var_293_3.prefab_name] ~= nil then
						local var_293_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_3.prefab_name].transform, "story_v_out_317012", "317012068", "story_v_out_317012.awb")

						arg_290_1:RecordAudio("317012068", var_293_9)
						arg_290_1:RecordAudio("317012068", var_293_9)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_317012", "317012068", "story_v_out_317012.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_317012", "317012068", "story_v_out_317012.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_10 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_10 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_10

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_10 and arg_290_1.time_ < var_293_0 + var_293_10 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play317012069 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 317012069
		arg_294_1.duration_ = 7.8

		local var_294_0 = {
			zh = 1.8,
			ja = 7.8
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play317012070(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 0.175

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_2 = arg_294_1:FormatText(StoryNameCfg[394].name)

				arg_294_1.leftNameTxt_.text = var_297_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_3 = arg_294_1:GetWordFromCfg(317012069)
				local var_297_4 = arg_294_1:FormatText(var_297_3.content)

				arg_294_1.text_.text = var_297_4

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 7
				local var_297_6 = utf8.len(var_297_4)
				local var_297_7 = var_297_5 <= 0 and var_297_1 or var_297_1 * (var_297_6 / var_297_5)

				if var_297_7 > 0 and var_297_1 < var_297_7 then
					arg_294_1.talkMaxDuration = var_297_7

					if var_297_7 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_7 + var_297_0
					end
				end

				arg_294_1.text_.text = var_297_4
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012069", "story_v_out_317012.awb") ~= 0 then
					local var_297_8 = manager.audio:GetVoiceLength("story_v_out_317012", "317012069", "story_v_out_317012.awb") / 1000

					if var_297_8 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_8 + var_297_0
					end

					if var_297_3.prefab_name ~= "" and arg_294_1.actors_[var_297_3.prefab_name] ~= nil then
						local var_297_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_3.prefab_name].transform, "story_v_out_317012", "317012069", "story_v_out_317012.awb")

						arg_294_1:RecordAudio("317012069", var_297_9)
						arg_294_1:RecordAudio("317012069", var_297_9)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_317012", "317012069", "story_v_out_317012.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_317012", "317012069", "story_v_out_317012.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_10 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_10 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_10

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_10 and arg_294_1.time_ < var_297_0 + var_297_10 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play317012070 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 317012070
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play317012071(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 1.7

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_2 = arg_298_1:GetWordFromCfg(317012070)
				local var_301_3 = arg_298_1:FormatText(var_301_2.content)

				arg_298_1.text_.text = var_301_3

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_4 = 68
				local var_301_5 = utf8.len(var_301_3)
				local var_301_6 = var_301_4 <= 0 and var_301_1 or var_301_1 * (var_301_5 / var_301_4)

				if var_301_6 > 0 and var_301_1 < var_301_6 then
					arg_298_1.talkMaxDuration = var_301_6

					if var_301_6 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_6 + var_301_0
					end
				end

				arg_298_1.text_.text = var_301_3
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_7 = math.max(var_301_1, arg_298_1.talkMaxDuration)

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_7 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_0) / var_301_7

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_0 + var_301_7 and arg_298_1.time_ < var_301_0 + var_301_7 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play317012071 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 317012071
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play317012072(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0
			local var_305_1 = 0.8

			if var_305_0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_2 = arg_302_1:GetWordFromCfg(317012071)
				local var_305_3 = arg_302_1:FormatText(var_305_2.content)

				arg_302_1.text_.text = var_305_3

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_4 = 32
				local var_305_5 = utf8.len(var_305_3)
				local var_305_6 = var_305_4 <= 0 and var_305_1 or var_305_1 * (var_305_5 / var_305_4)

				if var_305_6 > 0 and var_305_1 < var_305_6 then
					arg_302_1.talkMaxDuration = var_305_6

					if var_305_6 + var_305_0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_6 + var_305_0
					end
				end

				arg_302_1.text_.text = var_305_3
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_7 = math.max(var_305_1, arg_302_1.talkMaxDuration)

			if var_305_0 <= arg_302_1.time_ and arg_302_1.time_ < var_305_0 + var_305_7 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_0) / var_305_7

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_0 + var_305_7 and arg_302_1.time_ < var_305_0 + var_305_7 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play317012072 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 317012072
		arg_306_1.duration_ = 7.03

		local var_306_0 = {
			zh = 6.466,
			ja = 7.033
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play317012073(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = "2078ui_story"

			if arg_306_1.actors_[var_309_0] == nil then
				local var_309_1 = Asset.Load("Char/" .. "2078ui_story")

				if not isNil(var_309_1) then
					local var_309_2 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_306_1.stage_.transform)

					var_309_2.name = var_309_0
					var_309_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_306_1.actors_[var_309_0] = var_309_2

					local var_309_3 = var_309_2:GetComponentInChildren(typeof(CharacterEffect))

					var_309_3.enabled = true

					local var_309_4 = GameObjectTools.GetOrAddComponent(var_309_2, typeof(DynamicBoneHelper))

					if var_309_4 then
						var_309_4:EnableDynamicBone(false)
					end

					arg_306_1:ShowWeapon(var_309_3.transform, false)

					arg_306_1.var_[var_309_0 .. "Animator"] = var_309_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_306_1.var_[var_309_0 .. "Animator"].applyRootMotion = true
					arg_306_1.var_[var_309_0 .. "LipSync"] = var_309_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_309_5 = arg_306_1.actors_["2078ui_story"].transform
			local var_309_6 = 0

			if var_309_6 < arg_306_1.time_ and arg_306_1.time_ <= var_309_6 + arg_309_0 then
				arg_306_1.var_.moveOldPos2078ui_story = var_309_5.localPosition
			end

			local var_309_7 = 0.001

			if var_309_6 <= arg_306_1.time_ and arg_306_1.time_ < var_309_6 + var_309_7 then
				local var_309_8 = (arg_306_1.time_ - var_309_6) / var_309_7
				local var_309_9 = Vector3.New(-0.7, -1.28, -5.6)

				var_309_5.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos2078ui_story, var_309_9, var_309_8)

				local var_309_10 = manager.ui.mainCamera.transform.position - var_309_5.position

				var_309_5.forward = Vector3.New(var_309_10.x, var_309_10.y, var_309_10.z)

				local var_309_11 = var_309_5.localEulerAngles

				var_309_11.z = 0
				var_309_11.x = 0
				var_309_5.localEulerAngles = var_309_11
			end

			if arg_306_1.time_ >= var_309_6 + var_309_7 and arg_306_1.time_ < var_309_6 + var_309_7 + arg_309_0 then
				var_309_5.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_309_12 = manager.ui.mainCamera.transform.position - var_309_5.position

				var_309_5.forward = Vector3.New(var_309_12.x, var_309_12.y, var_309_12.z)

				local var_309_13 = var_309_5.localEulerAngles

				var_309_13.z = 0
				var_309_13.x = 0
				var_309_5.localEulerAngles = var_309_13
			end

			local var_309_14 = arg_306_1.actors_["2078ui_story"]
			local var_309_15 = 0

			if var_309_15 < arg_306_1.time_ and arg_306_1.time_ <= var_309_15 + arg_309_0 and not isNil(var_309_14) and arg_306_1.var_.characterEffect2078ui_story == nil then
				arg_306_1.var_.characterEffect2078ui_story = var_309_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_16 = 0.200000002980232

			if var_309_15 <= arg_306_1.time_ and arg_306_1.time_ < var_309_15 + var_309_16 and not isNil(var_309_14) then
				local var_309_17 = (arg_306_1.time_ - var_309_15) / var_309_16

				if arg_306_1.var_.characterEffect2078ui_story and not isNil(var_309_14) then
					arg_306_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= var_309_15 + var_309_16 and arg_306_1.time_ < var_309_15 + var_309_16 + arg_309_0 and not isNil(var_309_14) and arg_306_1.var_.characterEffect2078ui_story then
				arg_306_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_309_18 = 0

			if var_309_18 < arg_306_1.time_ and arg_306_1.time_ <= var_309_18 + arg_309_0 then
				arg_306_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_309_19 = "1015ui_story"

			if arg_306_1.actors_[var_309_19] == nil then
				local var_309_20 = Asset.Load("Char/" .. "1015ui_story")

				if not isNil(var_309_20) then
					local var_309_21 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_306_1.stage_.transform)

					var_309_21.name = var_309_19
					var_309_21.transform.localPosition = Vector3.New(0, 100, 0)
					arg_306_1.actors_[var_309_19] = var_309_21

					local var_309_22 = var_309_21:GetComponentInChildren(typeof(CharacterEffect))

					var_309_22.enabled = true

					local var_309_23 = GameObjectTools.GetOrAddComponent(var_309_21, typeof(DynamicBoneHelper))

					if var_309_23 then
						var_309_23:EnableDynamicBone(false)
					end

					arg_306_1:ShowWeapon(var_309_22.transform, false)

					arg_306_1.var_[var_309_19 .. "Animator"] = var_309_22.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_306_1.var_[var_309_19 .. "Animator"].applyRootMotion = true
					arg_306_1.var_[var_309_19 .. "LipSync"] = var_309_22.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_309_24 = arg_306_1.actors_["1015ui_story"].transform
			local var_309_25 = 0

			if var_309_25 < arg_306_1.time_ and arg_306_1.time_ <= var_309_25 + arg_309_0 then
				arg_306_1.var_.moveOldPos1015ui_story = var_309_24.localPosition
			end

			local var_309_26 = 0.001

			if var_309_25 <= arg_306_1.time_ and arg_306_1.time_ < var_309_25 + var_309_26 then
				local var_309_27 = (arg_306_1.time_ - var_309_25) / var_309_26
				local var_309_28 = Vector3.New(0.7, -1.15, -6.2)

				var_309_24.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1015ui_story, var_309_28, var_309_27)

				local var_309_29 = manager.ui.mainCamera.transform.position - var_309_24.position

				var_309_24.forward = Vector3.New(var_309_29.x, var_309_29.y, var_309_29.z)

				local var_309_30 = var_309_24.localEulerAngles

				var_309_30.z = 0
				var_309_30.x = 0
				var_309_24.localEulerAngles = var_309_30
			end

			if arg_306_1.time_ >= var_309_25 + var_309_26 and arg_306_1.time_ < var_309_25 + var_309_26 + arg_309_0 then
				var_309_24.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_309_31 = manager.ui.mainCamera.transform.position - var_309_24.position

				var_309_24.forward = Vector3.New(var_309_31.x, var_309_31.y, var_309_31.z)

				local var_309_32 = var_309_24.localEulerAngles

				var_309_32.z = 0
				var_309_32.x = 0
				var_309_24.localEulerAngles = var_309_32
			end

			local var_309_33 = arg_306_1.actors_["1015ui_story"]
			local var_309_34 = 0

			if var_309_34 < arg_306_1.time_ and arg_306_1.time_ <= var_309_34 + arg_309_0 and not isNil(var_309_33) and arg_306_1.var_.characterEffect1015ui_story == nil then
				arg_306_1.var_.characterEffect1015ui_story = var_309_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_35 = 0.200000002980232

			if var_309_34 <= arg_306_1.time_ and arg_306_1.time_ < var_309_34 + var_309_35 and not isNil(var_309_33) then
				local var_309_36 = (arg_306_1.time_ - var_309_34) / var_309_35

				if arg_306_1.var_.characterEffect1015ui_story and not isNil(var_309_33) then
					local var_309_37 = Mathf.Lerp(0, 0.5, var_309_36)

					arg_306_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1015ui_story.fillRatio = var_309_37
				end
			end

			if arg_306_1.time_ >= var_309_34 + var_309_35 and arg_306_1.time_ < var_309_34 + var_309_35 + arg_309_0 and not isNil(var_309_33) and arg_306_1.var_.characterEffect1015ui_story then
				local var_309_38 = 0.5

				arg_306_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1015ui_story.fillRatio = var_309_38
			end

			local var_309_39 = 0

			if var_309_39 < arg_306_1.time_ and arg_306_1.time_ <= var_309_39 + arg_309_0 then
				arg_306_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_309_40 = 0
			local var_309_41 = 0.85

			if var_309_40 < arg_306_1.time_ and arg_306_1.time_ <= var_309_40 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_42 = arg_306_1:FormatText(StoryNameCfg[528].name)

				arg_306_1.leftNameTxt_.text = var_309_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_43 = arg_306_1:GetWordFromCfg(317012072)
				local var_309_44 = arg_306_1:FormatText(var_309_43.content)

				arg_306_1.text_.text = var_309_44

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_45 = 34
				local var_309_46 = utf8.len(var_309_44)
				local var_309_47 = var_309_45 <= 0 and var_309_41 or var_309_41 * (var_309_46 / var_309_45)

				if var_309_47 > 0 and var_309_41 < var_309_47 then
					arg_306_1.talkMaxDuration = var_309_47

					if var_309_47 + var_309_40 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_47 + var_309_40
					end
				end

				arg_306_1.text_.text = var_309_44
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012072", "story_v_out_317012.awb") ~= 0 then
					local var_309_48 = manager.audio:GetVoiceLength("story_v_out_317012", "317012072", "story_v_out_317012.awb") / 1000

					if var_309_48 + var_309_40 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_48 + var_309_40
					end

					if var_309_43.prefab_name ~= "" and arg_306_1.actors_[var_309_43.prefab_name] ~= nil then
						local var_309_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_43.prefab_name].transform, "story_v_out_317012", "317012072", "story_v_out_317012.awb")

						arg_306_1:RecordAudio("317012072", var_309_49)
						arg_306_1:RecordAudio("317012072", var_309_49)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_317012", "317012072", "story_v_out_317012.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_317012", "317012072", "story_v_out_317012.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_50 = math.max(var_309_41, arg_306_1.talkMaxDuration)

			if var_309_40 <= arg_306_1.time_ and arg_306_1.time_ < var_309_40 + var_309_50 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_40) / var_309_50

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_40 + var_309_50 and arg_306_1.time_ < var_309_40 + var_309_50 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_306_1:InitPlayNodeList()
	end,
	Play317012073 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 317012073
		arg_310_1.duration_ = 4.27

		local var_310_0 = {
			zh = 3.566,
			ja = 4.266
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play317012074(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["2078ui_story"].transform
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 then
				arg_310_1.var_.moveOldPos2078ui_story = var_313_0.localPosition
			end

			local var_313_2 = 0.001

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2
				local var_313_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_313_0.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos2078ui_story, var_313_4, var_313_3)

				local var_313_5 = manager.ui.mainCamera.transform.position - var_313_0.position

				var_313_0.forward = Vector3.New(var_313_5.x, var_313_5.y, var_313_5.z)

				local var_313_6 = var_313_0.localEulerAngles

				var_313_6.z = 0
				var_313_6.x = 0
				var_313_0.localEulerAngles = var_313_6
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 then
				var_313_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_313_7 = manager.ui.mainCamera.transform.position - var_313_0.position

				var_313_0.forward = Vector3.New(var_313_7.x, var_313_7.y, var_313_7.z)

				local var_313_8 = var_313_0.localEulerAngles

				var_313_8.z = 0
				var_313_8.x = 0
				var_313_0.localEulerAngles = var_313_8
			end

			local var_313_9 = arg_310_1.actors_["2078ui_story"]
			local var_313_10 = 0

			if var_313_10 < arg_310_1.time_ and arg_310_1.time_ <= var_313_10 + arg_313_0 and not isNil(var_313_9) and arg_310_1.var_.characterEffect2078ui_story == nil then
				arg_310_1.var_.characterEffect2078ui_story = var_313_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_11 = 0.200000002980232

			if var_313_10 <= arg_310_1.time_ and arg_310_1.time_ < var_313_10 + var_313_11 and not isNil(var_313_9) then
				local var_313_12 = (arg_310_1.time_ - var_313_10) / var_313_11

				if arg_310_1.var_.characterEffect2078ui_story and not isNil(var_313_9) then
					local var_313_13 = Mathf.Lerp(0, 0.5, var_313_12)

					arg_310_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_310_1.var_.characterEffect2078ui_story.fillRatio = var_313_13
				end
			end

			if arg_310_1.time_ >= var_313_10 + var_313_11 and arg_310_1.time_ < var_313_10 + var_313_11 + arg_313_0 and not isNil(var_313_9) and arg_310_1.var_.characterEffect2078ui_story then
				local var_313_14 = 0.5

				arg_310_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_310_1.var_.characterEffect2078ui_story.fillRatio = var_313_14
			end

			local var_313_15 = arg_310_1.actors_["1015ui_story"].transform
			local var_313_16 = 0

			if var_313_16 < arg_310_1.time_ and arg_310_1.time_ <= var_313_16 + arg_313_0 then
				arg_310_1.var_.moveOldPos1015ui_story = var_313_15.localPosition
			end

			local var_313_17 = 0.001

			if var_313_16 <= arg_310_1.time_ and arg_310_1.time_ < var_313_16 + var_313_17 then
				local var_313_18 = (arg_310_1.time_ - var_313_16) / var_313_17
				local var_313_19 = Vector3.New(0.7, -1.15, -6.2)

				var_313_15.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos1015ui_story, var_313_19, var_313_18)

				local var_313_20 = manager.ui.mainCamera.transform.position - var_313_15.position

				var_313_15.forward = Vector3.New(var_313_20.x, var_313_20.y, var_313_20.z)

				local var_313_21 = var_313_15.localEulerAngles

				var_313_21.z = 0
				var_313_21.x = 0
				var_313_15.localEulerAngles = var_313_21
			end

			if arg_310_1.time_ >= var_313_16 + var_313_17 and arg_310_1.time_ < var_313_16 + var_313_17 + arg_313_0 then
				var_313_15.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_313_22 = manager.ui.mainCamera.transform.position - var_313_15.position

				var_313_15.forward = Vector3.New(var_313_22.x, var_313_22.y, var_313_22.z)

				local var_313_23 = var_313_15.localEulerAngles

				var_313_23.z = 0
				var_313_23.x = 0
				var_313_15.localEulerAngles = var_313_23
			end

			local var_313_24 = arg_310_1.actors_["1015ui_story"]
			local var_313_25 = 0

			if var_313_25 < arg_310_1.time_ and arg_310_1.time_ <= var_313_25 + arg_313_0 and not isNil(var_313_24) and arg_310_1.var_.characterEffect1015ui_story == nil then
				arg_310_1.var_.characterEffect1015ui_story = var_313_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_26 = 0.200000002980232

			if var_313_25 <= arg_310_1.time_ and arg_310_1.time_ < var_313_25 + var_313_26 and not isNil(var_313_24) then
				local var_313_27 = (arg_310_1.time_ - var_313_25) / var_313_26

				if arg_310_1.var_.characterEffect1015ui_story and not isNil(var_313_24) then
					arg_310_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= var_313_25 + var_313_26 and arg_310_1.time_ < var_313_25 + var_313_26 + arg_313_0 and not isNil(var_313_24) and arg_310_1.var_.characterEffect1015ui_story then
				arg_310_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_313_28 = 0

			if var_313_28 < arg_310_1.time_ and arg_310_1.time_ <= var_313_28 + arg_313_0 then
				arg_310_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			local var_313_29 = 0

			if var_313_29 < arg_310_1.time_ and arg_310_1.time_ <= var_313_29 + arg_313_0 then
				arg_310_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_313_30 = 0
			local var_313_31 = 0.425

			if var_313_30 < arg_310_1.time_ and arg_310_1.time_ <= var_313_30 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_32 = arg_310_1:FormatText(StoryNameCfg[479].name)

				arg_310_1.leftNameTxt_.text = var_313_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_33 = arg_310_1:GetWordFromCfg(317012073)
				local var_313_34 = arg_310_1:FormatText(var_313_33.content)

				arg_310_1.text_.text = var_313_34

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_35 = 17
				local var_313_36 = utf8.len(var_313_34)
				local var_313_37 = var_313_35 <= 0 and var_313_31 or var_313_31 * (var_313_36 / var_313_35)

				if var_313_37 > 0 and var_313_31 < var_313_37 then
					arg_310_1.talkMaxDuration = var_313_37

					if var_313_37 + var_313_30 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_37 + var_313_30
					end
				end

				arg_310_1.text_.text = var_313_34
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012073", "story_v_out_317012.awb") ~= 0 then
					local var_313_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012073", "story_v_out_317012.awb") / 1000

					if var_313_38 + var_313_30 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_38 + var_313_30
					end

					if var_313_33.prefab_name ~= "" and arg_310_1.actors_[var_313_33.prefab_name] ~= nil then
						local var_313_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_33.prefab_name].transform, "story_v_out_317012", "317012073", "story_v_out_317012.awb")

						arg_310_1:RecordAudio("317012073", var_313_39)
						arg_310_1:RecordAudio("317012073", var_313_39)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_317012", "317012073", "story_v_out_317012.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_317012", "317012073", "story_v_out_317012.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_40 = math.max(var_313_31, arg_310_1.talkMaxDuration)

			if var_313_30 <= arg_310_1.time_ and arg_310_1.time_ < var_313_30 + var_313_40 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_30) / var_313_40

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_30 + var_313_40 and arg_310_1.time_ < var_313_30 + var_313_40 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_310_1:InitPlayNodeList()
	end,
	Play317012074 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 317012074
		arg_314_1.duration_ = 10.47

		local var_314_0 = {
			zh = 9.533,
			ja = 10.466
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play317012075(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0

			if var_317_0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_317_1 = 0
			local var_317_2 = 1.15

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_3 = arg_314_1:FormatText(StoryNameCfg[479].name)

				arg_314_1.leftNameTxt_.text = var_317_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_4 = arg_314_1:GetWordFromCfg(317012074)
				local var_317_5 = arg_314_1:FormatText(var_317_4.content)

				arg_314_1.text_.text = var_317_5

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_6 = 46
				local var_317_7 = utf8.len(var_317_5)
				local var_317_8 = var_317_6 <= 0 and var_317_2 or var_317_2 * (var_317_7 / var_317_6)

				if var_317_8 > 0 and var_317_2 < var_317_8 then
					arg_314_1.talkMaxDuration = var_317_8

					if var_317_8 + var_317_1 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_8 + var_317_1
					end
				end

				arg_314_1.text_.text = var_317_5
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012074", "story_v_out_317012.awb") ~= 0 then
					local var_317_9 = manager.audio:GetVoiceLength("story_v_out_317012", "317012074", "story_v_out_317012.awb") / 1000

					if var_317_9 + var_317_1 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_9 + var_317_1
					end

					if var_317_4.prefab_name ~= "" and arg_314_1.actors_[var_317_4.prefab_name] ~= nil then
						local var_317_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_4.prefab_name].transform, "story_v_out_317012", "317012074", "story_v_out_317012.awb")

						arg_314_1:RecordAudio("317012074", var_317_10)
						arg_314_1:RecordAudio("317012074", var_317_10)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_317012", "317012074", "story_v_out_317012.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_317012", "317012074", "story_v_out_317012.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_11 = math.max(var_317_2, arg_314_1.talkMaxDuration)

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_11 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_1) / var_317_11

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_1 + var_317_11 and arg_314_1.time_ < var_317_1 + var_317_11 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play317012075 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 317012075
		arg_318_1.duration_ = 1

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play317012076(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["2078ui_story"]
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect2078ui_story == nil then
				arg_318_1.var_.characterEffect2078ui_story = var_321_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_2 = 0.200000002980232

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 and not isNil(var_321_0) then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2

				if arg_318_1.var_.characterEffect2078ui_story and not isNil(var_321_0) then
					arg_318_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect2078ui_story then
				arg_318_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_321_4 = arg_318_1.actors_["1015ui_story"]
			local var_321_5 = 0

			if var_321_5 < arg_318_1.time_ and arg_318_1.time_ <= var_321_5 + arg_321_0 and not isNil(var_321_4) and arg_318_1.var_.characterEffect1015ui_story == nil then
				arg_318_1.var_.characterEffect1015ui_story = var_321_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_6 = 0.200000002980232

			if var_321_5 <= arg_318_1.time_ and arg_318_1.time_ < var_321_5 + var_321_6 and not isNil(var_321_4) then
				local var_321_7 = (arg_318_1.time_ - var_321_5) / var_321_6

				if arg_318_1.var_.characterEffect1015ui_story and not isNil(var_321_4) then
					local var_321_8 = Mathf.Lerp(0, 0.5, var_321_7)

					arg_318_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_318_1.var_.characterEffect1015ui_story.fillRatio = var_321_8
				end
			end

			if arg_318_1.time_ >= var_321_5 + var_321_6 and arg_318_1.time_ < var_321_5 + var_321_6 + arg_321_0 and not isNil(var_321_4) and arg_318_1.var_.characterEffect1015ui_story then
				local var_321_9 = 0.5

				arg_318_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_318_1.var_.characterEffect1015ui_story.fillRatio = var_321_9
			end

			local var_321_10 = 0
			local var_321_11 = 0.075

			if var_321_10 < arg_318_1.time_ and arg_318_1.time_ <= var_321_10 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_12 = arg_318_1:FormatText(StoryNameCfg[528].name)

				arg_318_1.leftNameTxt_.text = var_321_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_13 = arg_318_1:GetWordFromCfg(317012075)
				local var_321_14 = arg_318_1:FormatText(var_321_13.content)

				arg_318_1.text_.text = var_321_14

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_15 = 3
				local var_321_16 = utf8.len(var_321_14)
				local var_321_17 = var_321_15 <= 0 and var_321_11 or var_321_11 * (var_321_16 / var_321_15)

				if var_321_17 > 0 and var_321_11 < var_321_17 then
					arg_318_1.talkMaxDuration = var_321_17

					if var_321_17 + var_321_10 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_17 + var_321_10
					end
				end

				arg_318_1.text_.text = var_321_14
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012075", "story_v_out_317012.awb") ~= 0 then
					local var_321_18 = manager.audio:GetVoiceLength("story_v_out_317012", "317012075", "story_v_out_317012.awb") / 1000

					if var_321_18 + var_321_10 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_18 + var_321_10
					end

					if var_321_13.prefab_name ~= "" and arg_318_1.actors_[var_321_13.prefab_name] ~= nil then
						local var_321_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_13.prefab_name].transform, "story_v_out_317012", "317012075", "story_v_out_317012.awb")

						arg_318_1:RecordAudio("317012075", var_321_19)
						arg_318_1:RecordAudio("317012075", var_321_19)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_317012", "317012075", "story_v_out_317012.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_317012", "317012075", "story_v_out_317012.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_20 = math.max(var_321_11, arg_318_1.talkMaxDuration)

			if var_321_10 <= arg_318_1.time_ and arg_318_1.time_ < var_321_10 + var_321_20 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_10) / var_321_20

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_10 + var_321_20 and arg_318_1.time_ < var_321_10 + var_321_20 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play317012076 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 317012076
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play317012077(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["2078ui_story"]
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect2078ui_story == nil then
				arg_322_1.var_.characterEffect2078ui_story = var_325_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_2 = 0.200000002980232

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 and not isNil(var_325_0) then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2

				if arg_322_1.var_.characterEffect2078ui_story and not isNil(var_325_0) then
					local var_325_4 = Mathf.Lerp(0, 0.5, var_325_3)

					arg_322_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_322_1.var_.characterEffect2078ui_story.fillRatio = var_325_4
				end
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect2078ui_story then
				local var_325_5 = 0.5

				arg_322_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_322_1.var_.characterEffect2078ui_story.fillRatio = var_325_5
			end

			local var_325_6 = 0
			local var_325_7 = 1.175

			if var_325_6 < arg_322_1.time_ and arg_322_1.time_ <= var_325_6 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_8 = arg_322_1:GetWordFromCfg(317012076)
				local var_325_9 = arg_322_1:FormatText(var_325_8.content)

				arg_322_1.text_.text = var_325_9

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_10 = 47
				local var_325_11 = utf8.len(var_325_9)
				local var_325_12 = var_325_10 <= 0 and var_325_7 or var_325_7 * (var_325_11 / var_325_10)

				if var_325_12 > 0 and var_325_7 < var_325_12 then
					arg_322_1.talkMaxDuration = var_325_12

					if var_325_12 + var_325_6 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_12 + var_325_6
					end
				end

				arg_322_1.text_.text = var_325_9
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_13 = math.max(var_325_7, arg_322_1.talkMaxDuration)

			if var_325_6 <= arg_322_1.time_ and arg_322_1.time_ < var_325_6 + var_325_13 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_6) / var_325_13

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_6 + var_325_13 and arg_322_1.time_ < var_325_6 + var_325_13 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play317012077 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 317012077
		arg_326_1.duration_ = 12.33

		local var_326_0 = {
			zh = 12.333,
			ja = 9.4
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play317012078(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["2078ui_story"].transform
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 then
				arg_326_1.var_.moveOldPos2078ui_story = var_329_0.localPosition
			end

			local var_329_2 = 0.001

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2
				local var_329_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_329_0.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos2078ui_story, var_329_4, var_329_3)

				local var_329_5 = manager.ui.mainCamera.transform.position - var_329_0.position

				var_329_0.forward = Vector3.New(var_329_5.x, var_329_5.y, var_329_5.z)

				local var_329_6 = var_329_0.localEulerAngles

				var_329_6.z = 0
				var_329_6.x = 0
				var_329_0.localEulerAngles = var_329_6
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 then
				var_329_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_329_7 = manager.ui.mainCamera.transform.position - var_329_0.position

				var_329_0.forward = Vector3.New(var_329_7.x, var_329_7.y, var_329_7.z)

				local var_329_8 = var_329_0.localEulerAngles

				var_329_8.z = 0
				var_329_8.x = 0
				var_329_0.localEulerAngles = var_329_8
			end

			local var_329_9 = arg_326_1.actors_["2078ui_story"]
			local var_329_10 = 0

			if var_329_10 < arg_326_1.time_ and arg_326_1.time_ <= var_329_10 + arg_329_0 and not isNil(var_329_9) and arg_326_1.var_.characterEffect2078ui_story == nil then
				arg_326_1.var_.characterEffect2078ui_story = var_329_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_11 = 0.200000002980232

			if var_329_10 <= arg_326_1.time_ and arg_326_1.time_ < var_329_10 + var_329_11 and not isNil(var_329_9) then
				local var_329_12 = (arg_326_1.time_ - var_329_10) / var_329_11

				if arg_326_1.var_.characterEffect2078ui_story and not isNil(var_329_9) then
					local var_329_13 = Mathf.Lerp(0, 0.5, var_329_12)

					arg_326_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_326_1.var_.characterEffect2078ui_story.fillRatio = var_329_13
				end
			end

			if arg_326_1.time_ >= var_329_10 + var_329_11 and arg_326_1.time_ < var_329_10 + var_329_11 + arg_329_0 and not isNil(var_329_9) and arg_326_1.var_.characterEffect2078ui_story then
				local var_329_14 = 0.5

				arg_326_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_326_1.var_.characterEffect2078ui_story.fillRatio = var_329_14
			end

			local var_329_15 = arg_326_1.actors_["1015ui_story"].transform
			local var_329_16 = 0

			if var_329_16 < arg_326_1.time_ and arg_326_1.time_ <= var_329_16 + arg_329_0 then
				arg_326_1.var_.moveOldPos1015ui_story = var_329_15.localPosition
			end

			local var_329_17 = 0.001

			if var_329_16 <= arg_326_1.time_ and arg_326_1.time_ < var_329_16 + var_329_17 then
				local var_329_18 = (arg_326_1.time_ - var_329_16) / var_329_17
				local var_329_19 = Vector3.New(0.7, -1.15, -6.2)

				var_329_15.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1015ui_story, var_329_19, var_329_18)

				local var_329_20 = manager.ui.mainCamera.transform.position - var_329_15.position

				var_329_15.forward = Vector3.New(var_329_20.x, var_329_20.y, var_329_20.z)

				local var_329_21 = var_329_15.localEulerAngles

				var_329_21.z = 0
				var_329_21.x = 0
				var_329_15.localEulerAngles = var_329_21
			end

			if arg_326_1.time_ >= var_329_16 + var_329_17 and arg_326_1.time_ < var_329_16 + var_329_17 + arg_329_0 then
				var_329_15.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_329_22 = manager.ui.mainCamera.transform.position - var_329_15.position

				var_329_15.forward = Vector3.New(var_329_22.x, var_329_22.y, var_329_22.z)

				local var_329_23 = var_329_15.localEulerAngles

				var_329_23.z = 0
				var_329_23.x = 0
				var_329_15.localEulerAngles = var_329_23
			end

			local var_329_24 = arg_326_1.actors_["1015ui_story"]
			local var_329_25 = 0

			if var_329_25 < arg_326_1.time_ and arg_326_1.time_ <= var_329_25 + arg_329_0 and not isNil(var_329_24) and arg_326_1.var_.characterEffect1015ui_story == nil then
				arg_326_1.var_.characterEffect1015ui_story = var_329_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_26 = 0.200000002980232

			if var_329_25 <= arg_326_1.time_ and arg_326_1.time_ < var_329_25 + var_329_26 and not isNil(var_329_24) then
				local var_329_27 = (arg_326_1.time_ - var_329_25) / var_329_26

				if arg_326_1.var_.characterEffect1015ui_story and not isNil(var_329_24) then
					arg_326_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= var_329_25 + var_329_26 and arg_326_1.time_ < var_329_25 + var_329_26 + arg_329_0 and not isNil(var_329_24) and arg_326_1.var_.characterEffect1015ui_story then
				arg_326_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_329_28 = 0

			if var_329_28 < arg_326_1.time_ and arg_326_1.time_ <= var_329_28 + arg_329_0 then
				arg_326_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			local var_329_29 = 0

			if var_329_29 < arg_326_1.time_ and arg_326_1.time_ <= var_329_29 + arg_329_0 then
				arg_326_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_329_30 = 0
			local var_329_31 = 1.425

			if var_329_30 < arg_326_1.time_ and arg_326_1.time_ <= var_329_30 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_32 = arg_326_1:FormatText(StoryNameCfg[479].name)

				arg_326_1.leftNameTxt_.text = var_329_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_33 = arg_326_1:GetWordFromCfg(317012077)
				local var_329_34 = arg_326_1:FormatText(var_329_33.content)

				arg_326_1.text_.text = var_329_34

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_35 = 57
				local var_329_36 = utf8.len(var_329_34)
				local var_329_37 = var_329_35 <= 0 and var_329_31 or var_329_31 * (var_329_36 / var_329_35)

				if var_329_37 > 0 and var_329_31 < var_329_37 then
					arg_326_1.talkMaxDuration = var_329_37

					if var_329_37 + var_329_30 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_37 + var_329_30
					end
				end

				arg_326_1.text_.text = var_329_34
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012077", "story_v_out_317012.awb") ~= 0 then
					local var_329_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012077", "story_v_out_317012.awb") / 1000

					if var_329_38 + var_329_30 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_38 + var_329_30
					end

					if var_329_33.prefab_name ~= "" and arg_326_1.actors_[var_329_33.prefab_name] ~= nil then
						local var_329_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_33.prefab_name].transform, "story_v_out_317012", "317012077", "story_v_out_317012.awb")

						arg_326_1:RecordAudio("317012077", var_329_39)
						arg_326_1:RecordAudio("317012077", var_329_39)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_317012", "317012077", "story_v_out_317012.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_317012", "317012077", "story_v_out_317012.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_40 = math.max(var_329_31, arg_326_1.talkMaxDuration)

			if var_329_30 <= arg_326_1.time_ and arg_326_1.time_ < var_329_30 + var_329_40 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_30) / var_329_40

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_30 + var_329_40 and arg_326_1.time_ < var_329_30 + var_329_40 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_326_1:InitPlayNodeList()
	end,
	Play317012078 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 317012078
		arg_330_1.duration_ = 6.37

		local var_330_0 = {
			zh = 3.8,
			ja = 6.366
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play317012079(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["1015ui_story"].transform
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.var_.moveOldPos1015ui_story = var_333_0.localPosition
			end

			local var_333_2 = 0.001

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2
				local var_333_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_333_0.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos1015ui_story, var_333_4, var_333_3)

				local var_333_5 = manager.ui.mainCamera.transform.position - var_333_0.position

				var_333_0.forward = Vector3.New(var_333_5.x, var_333_5.y, var_333_5.z)

				local var_333_6 = var_333_0.localEulerAngles

				var_333_6.z = 0
				var_333_6.x = 0
				var_333_0.localEulerAngles = var_333_6
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 then
				var_333_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_333_7 = manager.ui.mainCamera.transform.position - var_333_0.position

				var_333_0.forward = Vector3.New(var_333_7.x, var_333_7.y, var_333_7.z)

				local var_333_8 = var_333_0.localEulerAngles

				var_333_8.z = 0
				var_333_8.x = 0
				var_333_0.localEulerAngles = var_333_8
			end

			local var_333_9 = arg_330_1.actors_["1015ui_story"]
			local var_333_10 = 0

			if var_333_10 < arg_330_1.time_ and arg_330_1.time_ <= var_333_10 + arg_333_0 and not isNil(var_333_9) and arg_330_1.var_.characterEffect1015ui_story == nil then
				arg_330_1.var_.characterEffect1015ui_story = var_333_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_11 = 0.200000002980232

			if var_333_10 <= arg_330_1.time_ and arg_330_1.time_ < var_333_10 + var_333_11 and not isNil(var_333_9) then
				local var_333_12 = (arg_330_1.time_ - var_333_10) / var_333_11

				if arg_330_1.var_.characterEffect1015ui_story and not isNil(var_333_9) then
					local var_333_13 = Mathf.Lerp(0, 0.5, var_333_12)

					arg_330_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_330_1.var_.characterEffect1015ui_story.fillRatio = var_333_13
				end
			end

			if arg_330_1.time_ >= var_333_10 + var_333_11 and arg_330_1.time_ < var_333_10 + var_333_11 + arg_333_0 and not isNil(var_333_9) and arg_330_1.var_.characterEffect1015ui_story then
				local var_333_14 = 0.5

				arg_330_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_330_1.var_.characterEffect1015ui_story.fillRatio = var_333_14
			end

			local var_333_15 = "2079ui_story"

			if arg_330_1.actors_[var_333_15] == nil then
				local var_333_16 = Asset.Load("Char/" .. "2079ui_story")

				if not isNil(var_333_16) then
					local var_333_17 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_330_1.stage_.transform)

					var_333_17.name = var_333_15
					var_333_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_330_1.actors_[var_333_15] = var_333_17

					local var_333_18 = var_333_17:GetComponentInChildren(typeof(CharacterEffect))

					var_333_18.enabled = true

					local var_333_19 = GameObjectTools.GetOrAddComponent(var_333_17, typeof(DynamicBoneHelper))

					if var_333_19 then
						var_333_19:EnableDynamicBone(false)
					end

					arg_330_1:ShowWeapon(var_333_18.transform, false)

					arg_330_1.var_[var_333_15 .. "Animator"] = var_333_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_330_1.var_[var_333_15 .. "Animator"].applyRootMotion = true
					arg_330_1.var_[var_333_15 .. "LipSync"] = var_333_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_333_20 = arg_330_1.actors_["2079ui_story"]
			local var_333_21 = 0

			if var_333_21 < arg_330_1.time_ and arg_330_1.time_ <= var_333_21 + arg_333_0 and not isNil(var_333_20) and arg_330_1.var_.characterEffect2079ui_story == nil then
				arg_330_1.var_.characterEffect2079ui_story = var_333_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_22 = 0.200000002980232

			if var_333_21 <= arg_330_1.time_ and arg_330_1.time_ < var_333_21 + var_333_22 and not isNil(var_333_20) then
				local var_333_23 = (arg_330_1.time_ - var_333_21) / var_333_22

				if arg_330_1.var_.characterEffect2079ui_story and not isNil(var_333_20) then
					arg_330_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= var_333_21 + var_333_22 and arg_330_1.time_ < var_333_21 + var_333_22 + arg_333_0 and not isNil(var_333_20) and arg_330_1.var_.characterEffect2079ui_story then
				arg_330_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_333_24 = 0

			if var_333_24 < arg_330_1.time_ and arg_330_1.time_ <= var_333_24 + arg_333_0 then
				arg_330_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_333_25 = arg_330_1.actors_["2078ui_story"].transform
			local var_333_26 = 0

			if var_333_26 < arg_330_1.time_ and arg_330_1.time_ <= var_333_26 + arg_333_0 then
				arg_330_1.var_.moveOldPos2078ui_story = var_333_25.localPosition
			end

			local var_333_27 = 0.001

			if var_333_26 <= arg_330_1.time_ and arg_330_1.time_ < var_333_26 + var_333_27 then
				local var_333_28 = (arg_330_1.time_ - var_333_26) / var_333_27
				local var_333_29 = Vector3.New(0, 100, 0)

				var_333_25.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos2078ui_story, var_333_29, var_333_28)

				local var_333_30 = manager.ui.mainCamera.transform.position - var_333_25.position

				var_333_25.forward = Vector3.New(var_333_30.x, var_333_30.y, var_333_30.z)

				local var_333_31 = var_333_25.localEulerAngles

				var_333_31.z = 0
				var_333_31.x = 0
				var_333_25.localEulerAngles = var_333_31
			end

			if arg_330_1.time_ >= var_333_26 + var_333_27 and arg_330_1.time_ < var_333_26 + var_333_27 + arg_333_0 then
				var_333_25.localPosition = Vector3.New(0, 100, 0)

				local var_333_32 = manager.ui.mainCamera.transform.position - var_333_25.position

				var_333_25.forward = Vector3.New(var_333_32.x, var_333_32.y, var_333_32.z)

				local var_333_33 = var_333_25.localEulerAngles

				var_333_33.z = 0
				var_333_33.x = 0
				var_333_25.localEulerAngles = var_333_33
			end

			local var_333_34 = arg_330_1.actors_["2078ui_story"]
			local var_333_35 = 0

			if var_333_35 < arg_330_1.time_ and arg_330_1.time_ <= var_333_35 + arg_333_0 and not isNil(var_333_34) and arg_330_1.var_.characterEffect2078ui_story == nil then
				arg_330_1.var_.characterEffect2078ui_story = var_333_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_36 = 0.200000002980232

			if var_333_35 <= arg_330_1.time_ and arg_330_1.time_ < var_333_35 + var_333_36 and not isNil(var_333_34) then
				local var_333_37 = (arg_330_1.time_ - var_333_35) / var_333_36

				if arg_330_1.var_.characterEffect2078ui_story and not isNil(var_333_34) then
					local var_333_38 = Mathf.Lerp(0, 0.5, var_333_37)

					arg_330_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_330_1.var_.characterEffect2078ui_story.fillRatio = var_333_38
				end
			end

			if arg_330_1.time_ >= var_333_35 + var_333_36 and arg_330_1.time_ < var_333_35 + var_333_36 + arg_333_0 and not isNil(var_333_34) and arg_330_1.var_.characterEffect2078ui_story then
				local var_333_39 = 0.5

				arg_330_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_330_1.var_.characterEffect2078ui_story.fillRatio = var_333_39
			end

			local var_333_40 = 0

			if var_333_40 < arg_330_1.time_ and arg_330_1.time_ <= var_333_40 + arg_333_0 then
				arg_330_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_333_41 = arg_330_1.actors_["2079ui_story"].transform
			local var_333_42 = 0

			if var_333_42 < arg_330_1.time_ and arg_330_1.time_ <= var_333_42 + arg_333_0 then
				arg_330_1.var_.moveOldPos2079ui_story = var_333_41.localPosition
			end

			local var_333_43 = 0.001

			if var_333_42 <= arg_330_1.time_ and arg_330_1.time_ < var_333_42 + var_333_43 then
				local var_333_44 = (arg_330_1.time_ - var_333_42) / var_333_43
				local var_333_45 = Vector3.New(0.7, -1.28, -5.6)

				var_333_41.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos2079ui_story, var_333_45, var_333_44)

				local var_333_46 = manager.ui.mainCamera.transform.position - var_333_41.position

				var_333_41.forward = Vector3.New(var_333_46.x, var_333_46.y, var_333_46.z)

				local var_333_47 = var_333_41.localEulerAngles

				var_333_47.z = 0
				var_333_47.x = 0
				var_333_41.localEulerAngles = var_333_47
			end

			if arg_330_1.time_ >= var_333_42 + var_333_43 and arg_330_1.time_ < var_333_42 + var_333_43 + arg_333_0 then
				var_333_41.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_333_48 = manager.ui.mainCamera.transform.position - var_333_41.position

				var_333_41.forward = Vector3.New(var_333_48.x, var_333_48.y, var_333_48.z)

				local var_333_49 = var_333_41.localEulerAngles

				var_333_49.z = 0
				var_333_49.x = 0
				var_333_41.localEulerAngles = var_333_49
			end

			local var_333_50 = 0
			local var_333_51 = 0.475

			if var_333_50 < arg_330_1.time_ and arg_330_1.time_ <= var_333_50 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_52 = arg_330_1:FormatText(StoryNameCfg[529].name)

				arg_330_1.leftNameTxt_.text = var_333_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_53 = arg_330_1:GetWordFromCfg(317012078)
				local var_333_54 = arg_330_1:FormatText(var_333_53.content)

				arg_330_1.text_.text = var_333_54

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_55 = 19
				local var_333_56 = utf8.len(var_333_54)
				local var_333_57 = var_333_55 <= 0 and var_333_51 or var_333_51 * (var_333_56 / var_333_55)

				if var_333_57 > 0 and var_333_51 < var_333_57 then
					arg_330_1.talkMaxDuration = var_333_57

					if var_333_57 + var_333_50 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_57 + var_333_50
					end
				end

				arg_330_1.text_.text = var_333_54
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012078", "story_v_out_317012.awb") ~= 0 then
					local var_333_58 = manager.audio:GetVoiceLength("story_v_out_317012", "317012078", "story_v_out_317012.awb") / 1000

					if var_333_58 + var_333_50 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_58 + var_333_50
					end

					if var_333_53.prefab_name ~= "" and arg_330_1.actors_[var_333_53.prefab_name] ~= nil then
						local var_333_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_53.prefab_name].transform, "story_v_out_317012", "317012078", "story_v_out_317012.awb")

						arg_330_1:RecordAudio("317012078", var_333_59)
						arg_330_1:RecordAudio("317012078", var_333_59)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_317012", "317012078", "story_v_out_317012.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_317012", "317012078", "story_v_out_317012.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_60 = math.max(var_333_51, arg_330_1.talkMaxDuration)

			if var_333_50 <= arg_330_1.time_ and arg_330_1.time_ < var_333_50 + var_333_60 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_50) / var_333_60

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_50 + var_333_60 and arg_330_1.time_ < var_333_50 + var_333_60 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
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
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play317012079 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 317012079
		arg_334_1.duration_ = 2.5

		local var_334_0 = {
			zh = 1.999999999999,
			ja = 2.5
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play317012080(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["1015ui_story"].transform
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.var_.moveOldPos1015ui_story = var_337_0.localPosition
			end

			local var_337_2 = 0.001

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2
				local var_337_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_337_0.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1015ui_story, var_337_4, var_337_3)

				local var_337_5 = manager.ui.mainCamera.transform.position - var_337_0.position

				var_337_0.forward = Vector3.New(var_337_5.x, var_337_5.y, var_337_5.z)

				local var_337_6 = var_337_0.localEulerAngles

				var_337_6.z = 0
				var_337_6.x = 0
				var_337_0.localEulerAngles = var_337_6
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 then
				var_337_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_337_7 = manager.ui.mainCamera.transform.position - var_337_0.position

				var_337_0.forward = Vector3.New(var_337_7.x, var_337_7.y, var_337_7.z)

				local var_337_8 = var_337_0.localEulerAngles

				var_337_8.z = 0
				var_337_8.x = 0
				var_337_0.localEulerAngles = var_337_8
			end

			local var_337_9 = arg_334_1.actors_["1015ui_story"]
			local var_337_10 = 0

			if var_337_10 < arg_334_1.time_ and arg_334_1.time_ <= var_337_10 + arg_337_0 and not isNil(var_337_9) and arg_334_1.var_.characterEffect1015ui_story == nil then
				arg_334_1.var_.characterEffect1015ui_story = var_337_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_11 = 0.200000002980232

			if var_337_10 <= arg_334_1.time_ and arg_334_1.time_ < var_337_10 + var_337_11 and not isNil(var_337_9) then
				local var_337_12 = (arg_334_1.time_ - var_337_10) / var_337_11

				if arg_334_1.var_.characterEffect1015ui_story and not isNil(var_337_9) then
					arg_334_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= var_337_10 + var_337_11 and arg_334_1.time_ < var_337_10 + var_337_11 + arg_337_0 and not isNil(var_337_9) and arg_334_1.var_.characterEffect1015ui_story then
				arg_334_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_337_13 = 0

			if var_337_13 < arg_334_1.time_ and arg_334_1.time_ <= var_337_13 + arg_337_0 then
				arg_334_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action5_1")
			end

			local var_337_14 = 0

			if var_337_14 < arg_334_1.time_ and arg_334_1.time_ <= var_337_14 + arg_337_0 then
				arg_334_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_337_15 = arg_334_1.actors_["2079ui_story"].transform
			local var_337_16 = 0

			if var_337_16 < arg_334_1.time_ and arg_334_1.time_ <= var_337_16 + arg_337_0 then
				arg_334_1.var_.moveOldPos2079ui_story = var_337_15.localPosition
			end

			local var_337_17 = 0.001

			if var_337_16 <= arg_334_1.time_ and arg_334_1.time_ < var_337_16 + var_337_17 then
				local var_337_18 = (arg_334_1.time_ - var_337_16) / var_337_17
				local var_337_19 = Vector3.New(0.7, -1.28, -5.6)

				var_337_15.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos2079ui_story, var_337_19, var_337_18)

				local var_337_20 = manager.ui.mainCamera.transform.position - var_337_15.position

				var_337_15.forward = Vector3.New(var_337_20.x, var_337_20.y, var_337_20.z)

				local var_337_21 = var_337_15.localEulerAngles

				var_337_21.z = 0
				var_337_21.x = 0
				var_337_15.localEulerAngles = var_337_21
			end

			if arg_334_1.time_ >= var_337_16 + var_337_17 and arg_334_1.time_ < var_337_16 + var_337_17 + arg_337_0 then
				var_337_15.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_337_22 = manager.ui.mainCamera.transform.position - var_337_15.position

				var_337_15.forward = Vector3.New(var_337_22.x, var_337_22.y, var_337_22.z)

				local var_337_23 = var_337_15.localEulerAngles

				var_337_23.z = 0
				var_337_23.x = 0
				var_337_15.localEulerAngles = var_337_23
			end

			local var_337_24 = arg_334_1.actors_["2079ui_story"]
			local var_337_25 = 0

			if var_337_25 < arg_334_1.time_ and arg_334_1.time_ <= var_337_25 + arg_337_0 and not isNil(var_337_24) and arg_334_1.var_.characterEffect2079ui_story == nil then
				arg_334_1.var_.characterEffect2079ui_story = var_337_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_26 = 0.200000002980232

			if var_337_25 <= arg_334_1.time_ and arg_334_1.time_ < var_337_25 + var_337_26 and not isNil(var_337_24) then
				local var_337_27 = (arg_334_1.time_ - var_337_25) / var_337_26

				if arg_334_1.var_.characterEffect2079ui_story and not isNil(var_337_24) then
					local var_337_28 = Mathf.Lerp(0, 0.5, var_337_27)

					arg_334_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_334_1.var_.characterEffect2079ui_story.fillRatio = var_337_28
				end
			end

			if arg_334_1.time_ >= var_337_25 + var_337_26 and arg_334_1.time_ < var_337_25 + var_337_26 + arg_337_0 and not isNil(var_337_24) and arg_334_1.var_.characterEffect2079ui_story then
				local var_337_29 = 0.5

				arg_334_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_334_1.var_.characterEffect2079ui_story.fillRatio = var_337_29
			end

			local var_337_30 = 0
			local var_337_31 = 0.1

			if var_337_30 < arg_334_1.time_ and arg_334_1.time_ <= var_337_30 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_32 = arg_334_1:FormatText(StoryNameCfg[479].name)

				arg_334_1.leftNameTxt_.text = var_337_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_33 = arg_334_1:GetWordFromCfg(317012079)
				local var_337_34 = arg_334_1:FormatText(var_337_33.content)

				arg_334_1.text_.text = var_337_34

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_35 = 4
				local var_337_36 = utf8.len(var_337_34)
				local var_337_37 = var_337_35 <= 0 and var_337_31 or var_337_31 * (var_337_36 / var_337_35)

				if var_337_37 > 0 and var_337_31 < var_337_37 then
					arg_334_1.talkMaxDuration = var_337_37

					if var_337_37 + var_337_30 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_37 + var_337_30
					end
				end

				arg_334_1.text_.text = var_337_34
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012079", "story_v_out_317012.awb") ~= 0 then
					local var_337_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012079", "story_v_out_317012.awb") / 1000

					if var_337_38 + var_337_30 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_38 + var_337_30
					end

					if var_337_33.prefab_name ~= "" and arg_334_1.actors_[var_337_33.prefab_name] ~= nil then
						local var_337_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_33.prefab_name].transform, "story_v_out_317012", "317012079", "story_v_out_317012.awb")

						arg_334_1:RecordAudio("317012079", var_337_39)
						arg_334_1:RecordAudio("317012079", var_337_39)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_317012", "317012079", "story_v_out_317012.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_317012", "317012079", "story_v_out_317012.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_40 = math.max(var_337_31, arg_334_1.talkMaxDuration)

			if var_337_30 <= arg_334_1.time_ and arg_334_1.time_ < var_337_30 + var_337_40 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_30) / var_337_40

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_30 + var_337_40 and arg_334_1.time_ < var_337_30 + var_337_40 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
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
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play317012080 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 317012080
		arg_338_1.duration_ = 9.87

		local var_338_0 = {
			zh = 6.733,
			ja = 9.866
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play317012081(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["2078ui_story"].transform
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 then
				arg_338_1.var_.moveOldPos2078ui_story = var_341_0.localPosition
			end

			local var_341_2 = 0.001

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2
				local var_341_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_341_0.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos2078ui_story, var_341_4, var_341_3)

				local var_341_5 = manager.ui.mainCamera.transform.position - var_341_0.position

				var_341_0.forward = Vector3.New(var_341_5.x, var_341_5.y, var_341_5.z)

				local var_341_6 = var_341_0.localEulerAngles

				var_341_6.z = 0
				var_341_6.x = 0
				var_341_0.localEulerAngles = var_341_6
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 then
				var_341_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_341_7 = manager.ui.mainCamera.transform.position - var_341_0.position

				var_341_0.forward = Vector3.New(var_341_7.x, var_341_7.y, var_341_7.z)

				local var_341_8 = var_341_0.localEulerAngles

				var_341_8.z = 0
				var_341_8.x = 0
				var_341_0.localEulerAngles = var_341_8
			end

			local var_341_9 = arg_338_1.actors_["2078ui_story"]
			local var_341_10 = 0

			if var_341_10 < arg_338_1.time_ and arg_338_1.time_ <= var_341_10 + arg_341_0 and not isNil(var_341_9) and arg_338_1.var_.characterEffect2078ui_story == nil then
				arg_338_1.var_.characterEffect2078ui_story = var_341_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_11 = 0.200000002980232

			if var_341_10 <= arg_338_1.time_ and arg_338_1.time_ < var_341_10 + var_341_11 and not isNil(var_341_9) then
				local var_341_12 = (arg_338_1.time_ - var_341_10) / var_341_11

				if arg_338_1.var_.characterEffect2078ui_story and not isNil(var_341_9) then
					arg_338_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= var_341_10 + var_341_11 and arg_338_1.time_ < var_341_10 + var_341_11 + arg_341_0 and not isNil(var_341_9) and arg_338_1.var_.characterEffect2078ui_story then
				arg_338_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_341_13 = 0

			if var_341_13 < arg_338_1.time_ and arg_338_1.time_ <= var_341_13 + arg_341_0 then
				arg_338_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_341_14 = 0

			if var_341_14 < arg_338_1.time_ and arg_338_1.time_ <= var_341_14 + arg_341_0 then
				arg_338_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_341_15 = arg_338_1.actors_["1015ui_story"].transform
			local var_341_16 = 0

			if var_341_16 < arg_338_1.time_ and arg_338_1.time_ <= var_341_16 + arg_341_0 then
				arg_338_1.var_.moveOldPos1015ui_story = var_341_15.localPosition
			end

			local var_341_17 = 0.001

			if var_341_16 <= arg_338_1.time_ and arg_338_1.time_ < var_341_16 + var_341_17 then
				local var_341_18 = (arg_338_1.time_ - var_341_16) / var_341_17
				local var_341_19 = Vector3.New(0.7, -1.15, -6.2)

				var_341_15.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1015ui_story, var_341_19, var_341_18)

				local var_341_20 = manager.ui.mainCamera.transform.position - var_341_15.position

				var_341_15.forward = Vector3.New(var_341_20.x, var_341_20.y, var_341_20.z)

				local var_341_21 = var_341_15.localEulerAngles

				var_341_21.z = 0
				var_341_21.x = 0
				var_341_15.localEulerAngles = var_341_21
			end

			if arg_338_1.time_ >= var_341_16 + var_341_17 and arg_338_1.time_ < var_341_16 + var_341_17 + arg_341_0 then
				var_341_15.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_341_22 = manager.ui.mainCamera.transform.position - var_341_15.position

				var_341_15.forward = Vector3.New(var_341_22.x, var_341_22.y, var_341_22.z)

				local var_341_23 = var_341_15.localEulerAngles

				var_341_23.z = 0
				var_341_23.x = 0
				var_341_15.localEulerAngles = var_341_23
			end

			local var_341_24 = arg_338_1.actors_["1015ui_story"]
			local var_341_25 = 0

			if var_341_25 < arg_338_1.time_ and arg_338_1.time_ <= var_341_25 + arg_341_0 and not isNil(var_341_24) and arg_338_1.var_.characterEffect1015ui_story == nil then
				arg_338_1.var_.characterEffect1015ui_story = var_341_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_26 = 0.200000002980232

			if var_341_25 <= arg_338_1.time_ and arg_338_1.time_ < var_341_25 + var_341_26 and not isNil(var_341_24) then
				local var_341_27 = (arg_338_1.time_ - var_341_25) / var_341_26

				if arg_338_1.var_.characterEffect1015ui_story and not isNil(var_341_24) then
					local var_341_28 = Mathf.Lerp(0, 0.5, var_341_27)

					arg_338_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_338_1.var_.characterEffect1015ui_story.fillRatio = var_341_28
				end
			end

			if arg_338_1.time_ >= var_341_25 + var_341_26 and arg_338_1.time_ < var_341_25 + var_341_26 + arg_341_0 and not isNil(var_341_24) and arg_338_1.var_.characterEffect1015ui_story then
				local var_341_29 = 0.5

				arg_338_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_338_1.var_.characterEffect1015ui_story.fillRatio = var_341_29
			end

			local var_341_30 = arg_338_1.actors_["2079ui_story"].transform
			local var_341_31 = 0

			if var_341_31 < arg_338_1.time_ and arg_338_1.time_ <= var_341_31 + arg_341_0 then
				arg_338_1.var_.moveOldPos2079ui_story = var_341_30.localPosition
			end

			local var_341_32 = 0.001

			if var_341_31 <= arg_338_1.time_ and arg_338_1.time_ < var_341_31 + var_341_32 then
				local var_341_33 = (arg_338_1.time_ - var_341_31) / var_341_32
				local var_341_34 = Vector3.New(0, 100, 0)

				var_341_30.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos2079ui_story, var_341_34, var_341_33)

				local var_341_35 = manager.ui.mainCamera.transform.position - var_341_30.position

				var_341_30.forward = Vector3.New(var_341_35.x, var_341_35.y, var_341_35.z)

				local var_341_36 = var_341_30.localEulerAngles

				var_341_36.z = 0
				var_341_36.x = 0
				var_341_30.localEulerAngles = var_341_36
			end

			if arg_338_1.time_ >= var_341_31 + var_341_32 and arg_338_1.time_ < var_341_31 + var_341_32 + arg_341_0 then
				var_341_30.localPosition = Vector3.New(0, 100, 0)

				local var_341_37 = manager.ui.mainCamera.transform.position - var_341_30.position

				var_341_30.forward = Vector3.New(var_341_37.x, var_341_37.y, var_341_37.z)

				local var_341_38 = var_341_30.localEulerAngles

				var_341_38.z = 0
				var_341_38.x = 0
				var_341_30.localEulerAngles = var_341_38
			end

			local var_341_39 = arg_338_1.actors_["2079ui_story"]
			local var_341_40 = 0

			if var_341_40 < arg_338_1.time_ and arg_338_1.time_ <= var_341_40 + arg_341_0 and not isNil(var_341_39) and arg_338_1.var_.characterEffect2079ui_story == nil then
				arg_338_1.var_.characterEffect2079ui_story = var_341_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_41 = 0.200000002980232

			if var_341_40 <= arg_338_1.time_ and arg_338_1.time_ < var_341_40 + var_341_41 and not isNil(var_341_39) then
				local var_341_42 = (arg_338_1.time_ - var_341_40) / var_341_41

				if arg_338_1.var_.characterEffect2079ui_story and not isNil(var_341_39) then
					local var_341_43 = Mathf.Lerp(0, 0.5, var_341_42)

					arg_338_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_338_1.var_.characterEffect2079ui_story.fillRatio = var_341_43
				end
			end

			if arg_338_1.time_ >= var_341_40 + var_341_41 and arg_338_1.time_ < var_341_40 + var_341_41 + arg_341_0 and not isNil(var_341_39) and arg_338_1.var_.characterEffect2079ui_story then
				local var_341_44 = 0.5

				arg_338_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_338_1.var_.characterEffect2079ui_story.fillRatio = var_341_44
			end

			local var_341_45 = 0
			local var_341_46 = 0.925

			if var_341_45 < arg_338_1.time_ and arg_338_1.time_ <= var_341_45 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_47 = arg_338_1:FormatText(StoryNameCfg[530].name)

				arg_338_1.leftNameTxt_.text = var_341_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_48 = arg_338_1:GetWordFromCfg(317012080)
				local var_341_49 = arg_338_1:FormatText(var_341_48.content)

				arg_338_1.text_.text = var_341_49

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_50 = 37
				local var_341_51 = utf8.len(var_341_49)
				local var_341_52 = var_341_50 <= 0 and var_341_46 or var_341_46 * (var_341_51 / var_341_50)

				if var_341_52 > 0 and var_341_46 < var_341_52 then
					arg_338_1.talkMaxDuration = var_341_52

					if var_341_52 + var_341_45 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_52 + var_341_45
					end
				end

				arg_338_1.text_.text = var_341_49
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012080", "story_v_out_317012.awb") ~= 0 then
					local var_341_53 = manager.audio:GetVoiceLength("story_v_out_317012", "317012080", "story_v_out_317012.awb") / 1000

					if var_341_53 + var_341_45 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_53 + var_341_45
					end

					if var_341_48.prefab_name ~= "" and arg_338_1.actors_[var_341_48.prefab_name] ~= nil then
						local var_341_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_48.prefab_name].transform, "story_v_out_317012", "317012080", "story_v_out_317012.awb")

						arg_338_1:RecordAudio("317012080", var_341_54)
						arg_338_1:RecordAudio("317012080", var_341_54)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_317012", "317012080", "story_v_out_317012.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_317012", "317012080", "story_v_out_317012.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_55 = math.max(var_341_46, arg_338_1.talkMaxDuration)

			if var_341_45 <= arg_338_1.time_ and arg_338_1.time_ < var_341_45 + var_341_55 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_45) / var_341_55

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_45 + var_341_55 and arg_338_1.time_ < var_341_45 + var_341_55 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play317012081 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 317012081
		arg_342_1.duration_ = 2.53

		local var_342_0 = {
			zh = 1.999999999999,
			ja = 2.533
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play317012082(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["2078ui_story"].transform
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1.var_.moveOldPos2078ui_story = var_345_0.localPosition
			end

			local var_345_2 = 0.001

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2
				local var_345_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_345_0.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos2078ui_story, var_345_4, var_345_3)

				local var_345_5 = manager.ui.mainCamera.transform.position - var_345_0.position

				var_345_0.forward = Vector3.New(var_345_5.x, var_345_5.y, var_345_5.z)

				local var_345_6 = var_345_0.localEulerAngles

				var_345_6.z = 0
				var_345_6.x = 0
				var_345_0.localEulerAngles = var_345_6
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 then
				var_345_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_345_7 = manager.ui.mainCamera.transform.position - var_345_0.position

				var_345_0.forward = Vector3.New(var_345_7.x, var_345_7.y, var_345_7.z)

				local var_345_8 = var_345_0.localEulerAngles

				var_345_8.z = 0
				var_345_8.x = 0
				var_345_0.localEulerAngles = var_345_8
			end

			local var_345_9 = arg_342_1.actors_["2078ui_story"]
			local var_345_10 = 0

			if var_345_10 < arg_342_1.time_ and arg_342_1.time_ <= var_345_10 + arg_345_0 and not isNil(var_345_9) and arg_342_1.var_.characterEffect2078ui_story == nil then
				arg_342_1.var_.characterEffect2078ui_story = var_345_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_11 = 0.200000002980232

			if var_345_10 <= arg_342_1.time_ and arg_342_1.time_ < var_345_10 + var_345_11 and not isNil(var_345_9) then
				local var_345_12 = (arg_342_1.time_ - var_345_10) / var_345_11

				if arg_342_1.var_.characterEffect2078ui_story and not isNil(var_345_9) then
					local var_345_13 = Mathf.Lerp(0, 0.5, var_345_12)

					arg_342_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_342_1.var_.characterEffect2078ui_story.fillRatio = var_345_13
				end
			end

			if arg_342_1.time_ >= var_345_10 + var_345_11 and arg_342_1.time_ < var_345_10 + var_345_11 + arg_345_0 and not isNil(var_345_9) and arg_342_1.var_.characterEffect2078ui_story then
				local var_345_14 = 0.5

				arg_342_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_342_1.var_.characterEffect2078ui_story.fillRatio = var_345_14
			end

			local var_345_15 = arg_342_1.actors_["1015ui_story"].transform
			local var_345_16 = 0

			if var_345_16 < arg_342_1.time_ and arg_342_1.time_ <= var_345_16 + arg_345_0 then
				arg_342_1.var_.moveOldPos1015ui_story = var_345_15.localPosition
			end

			local var_345_17 = 0.001

			if var_345_16 <= arg_342_1.time_ and arg_342_1.time_ < var_345_16 + var_345_17 then
				local var_345_18 = (arg_342_1.time_ - var_345_16) / var_345_17
				local var_345_19 = Vector3.New(0.7, -1.15, -6.2)

				var_345_15.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1015ui_story, var_345_19, var_345_18)

				local var_345_20 = manager.ui.mainCamera.transform.position - var_345_15.position

				var_345_15.forward = Vector3.New(var_345_20.x, var_345_20.y, var_345_20.z)

				local var_345_21 = var_345_15.localEulerAngles

				var_345_21.z = 0
				var_345_21.x = 0
				var_345_15.localEulerAngles = var_345_21
			end

			if arg_342_1.time_ >= var_345_16 + var_345_17 and arg_342_1.time_ < var_345_16 + var_345_17 + arg_345_0 then
				var_345_15.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_345_22 = manager.ui.mainCamera.transform.position - var_345_15.position

				var_345_15.forward = Vector3.New(var_345_22.x, var_345_22.y, var_345_22.z)

				local var_345_23 = var_345_15.localEulerAngles

				var_345_23.z = 0
				var_345_23.x = 0
				var_345_15.localEulerAngles = var_345_23
			end

			local var_345_24 = arg_342_1.actors_["1015ui_story"]
			local var_345_25 = 0

			if var_345_25 < arg_342_1.time_ and arg_342_1.time_ <= var_345_25 + arg_345_0 and not isNil(var_345_24) and arg_342_1.var_.characterEffect1015ui_story == nil then
				arg_342_1.var_.characterEffect1015ui_story = var_345_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_26 = 0.200000002980232

			if var_345_25 <= arg_342_1.time_ and arg_342_1.time_ < var_345_25 + var_345_26 and not isNil(var_345_24) then
				local var_345_27 = (arg_342_1.time_ - var_345_25) / var_345_26

				if arg_342_1.var_.characterEffect1015ui_story and not isNil(var_345_24) then
					arg_342_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= var_345_25 + var_345_26 and arg_342_1.time_ < var_345_25 + var_345_26 + arg_345_0 and not isNil(var_345_24) and arg_342_1.var_.characterEffect1015ui_story then
				arg_342_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_345_28 = 0

			if var_345_28 < arg_342_1.time_ and arg_342_1.time_ <= var_345_28 + arg_345_0 then
				arg_342_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_345_29 = 0
			local var_345_30 = 0.1

			if var_345_29 < arg_342_1.time_ and arg_342_1.time_ <= var_345_29 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_31 = arg_342_1:FormatText(StoryNameCfg[479].name)

				arg_342_1.leftNameTxt_.text = var_345_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_32 = arg_342_1:GetWordFromCfg(317012081)
				local var_345_33 = arg_342_1:FormatText(var_345_32.content)

				arg_342_1.text_.text = var_345_33

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_34 = 4
				local var_345_35 = utf8.len(var_345_33)
				local var_345_36 = var_345_34 <= 0 and var_345_30 or var_345_30 * (var_345_35 / var_345_34)

				if var_345_36 > 0 and var_345_30 < var_345_36 then
					arg_342_1.talkMaxDuration = var_345_36

					if var_345_36 + var_345_29 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_36 + var_345_29
					end
				end

				arg_342_1.text_.text = var_345_33
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012081", "story_v_out_317012.awb") ~= 0 then
					local var_345_37 = manager.audio:GetVoiceLength("story_v_out_317012", "317012081", "story_v_out_317012.awb") / 1000

					if var_345_37 + var_345_29 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_37 + var_345_29
					end

					if var_345_32.prefab_name ~= "" and arg_342_1.actors_[var_345_32.prefab_name] ~= nil then
						local var_345_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_32.prefab_name].transform, "story_v_out_317012", "317012081", "story_v_out_317012.awb")

						arg_342_1:RecordAudio("317012081", var_345_38)
						arg_342_1:RecordAudio("317012081", var_345_38)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_317012", "317012081", "story_v_out_317012.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_317012", "317012081", "story_v_out_317012.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_39 = math.max(var_345_30, arg_342_1.talkMaxDuration)

			if var_345_29 <= arg_342_1.time_ and arg_342_1.time_ < var_345_29 + var_345_39 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_29) / var_345_39

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_29 + var_345_39 and arg_342_1.time_ < var_345_29 + var_345_39 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_342_1:InitPlayNodeList()
	end,
	Play317012082 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 317012082
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play317012083(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["1015ui_story"]
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect1015ui_story == nil then
				arg_346_1.var_.characterEffect1015ui_story = var_349_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_2 = 0.200000002980232

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 and not isNil(var_349_0) then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2

				if arg_346_1.var_.characterEffect1015ui_story and not isNil(var_349_0) then
					local var_349_4 = Mathf.Lerp(0, 0.5, var_349_3)

					arg_346_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_346_1.var_.characterEffect1015ui_story.fillRatio = var_349_4
				end
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect1015ui_story then
				local var_349_5 = 0.5

				arg_346_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_346_1.var_.characterEffect1015ui_story.fillRatio = var_349_5
			end

			local var_349_6 = 0
			local var_349_7 = 0.35

			if var_349_6 < arg_346_1.time_ and arg_346_1.time_ <= var_349_6 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_8 = arg_346_1:GetWordFromCfg(317012082)
				local var_349_9 = arg_346_1:FormatText(var_349_8.content)

				arg_346_1.text_.text = var_349_9

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_10 = 14
				local var_349_11 = utf8.len(var_349_9)
				local var_349_12 = var_349_10 <= 0 and var_349_7 or var_349_7 * (var_349_11 / var_349_10)

				if var_349_12 > 0 and var_349_7 < var_349_12 then
					arg_346_1.talkMaxDuration = var_349_12

					if var_349_12 + var_349_6 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_12 + var_349_6
					end
				end

				arg_346_1.text_.text = var_349_9
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_13 = math.max(var_349_7, arg_346_1.talkMaxDuration)

			if var_349_6 <= arg_346_1.time_ and arg_346_1.time_ < var_349_6 + var_349_13 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_6) / var_349_13

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_6 + var_349_13 and arg_346_1.time_ < var_349_6 + var_349_13 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play317012083 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 317012083
		arg_350_1.duration_ = 3.13

		local var_350_0 = {
			zh = 3.133,
			ja = 2.9
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play317012084(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["2078ui_story"].transform
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 then
				arg_350_1.var_.moveOldPos2078ui_story = var_353_0.localPosition
			end

			local var_353_2 = 0.001

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2
				local var_353_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_353_0.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos2078ui_story, var_353_4, var_353_3)

				local var_353_5 = manager.ui.mainCamera.transform.position - var_353_0.position

				var_353_0.forward = Vector3.New(var_353_5.x, var_353_5.y, var_353_5.z)

				local var_353_6 = var_353_0.localEulerAngles

				var_353_6.z = 0
				var_353_6.x = 0
				var_353_0.localEulerAngles = var_353_6
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 then
				var_353_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_353_7 = manager.ui.mainCamera.transform.position - var_353_0.position

				var_353_0.forward = Vector3.New(var_353_7.x, var_353_7.y, var_353_7.z)

				local var_353_8 = var_353_0.localEulerAngles

				var_353_8.z = 0
				var_353_8.x = 0
				var_353_0.localEulerAngles = var_353_8
			end

			local var_353_9 = arg_350_1.actors_["2078ui_story"]
			local var_353_10 = 0

			if var_353_10 < arg_350_1.time_ and arg_350_1.time_ <= var_353_10 + arg_353_0 and not isNil(var_353_9) and arg_350_1.var_.characterEffect2078ui_story == nil then
				arg_350_1.var_.characterEffect2078ui_story = var_353_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_11 = 0.200000002980232

			if var_353_10 <= arg_350_1.time_ and arg_350_1.time_ < var_353_10 + var_353_11 and not isNil(var_353_9) then
				local var_353_12 = (arg_350_1.time_ - var_353_10) / var_353_11

				if arg_350_1.var_.characterEffect2078ui_story and not isNil(var_353_9) then
					local var_353_13 = Mathf.Lerp(0, 0.5, var_353_12)

					arg_350_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_350_1.var_.characterEffect2078ui_story.fillRatio = var_353_13
				end
			end

			if arg_350_1.time_ >= var_353_10 + var_353_11 and arg_350_1.time_ < var_353_10 + var_353_11 + arg_353_0 and not isNil(var_353_9) and arg_350_1.var_.characterEffect2078ui_story then
				local var_353_14 = 0.5

				arg_350_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_350_1.var_.characterEffect2078ui_story.fillRatio = var_353_14
			end

			local var_353_15 = arg_350_1.actors_["1015ui_story"].transform
			local var_353_16 = 0

			if var_353_16 < arg_350_1.time_ and arg_350_1.time_ <= var_353_16 + arg_353_0 then
				arg_350_1.var_.moveOldPos1015ui_story = var_353_15.localPosition
			end

			local var_353_17 = 0.001

			if var_353_16 <= arg_350_1.time_ and arg_350_1.time_ < var_353_16 + var_353_17 then
				local var_353_18 = (arg_350_1.time_ - var_353_16) / var_353_17
				local var_353_19 = Vector3.New(0.7, -1.15, -6.2)

				var_353_15.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1015ui_story, var_353_19, var_353_18)

				local var_353_20 = manager.ui.mainCamera.transform.position - var_353_15.position

				var_353_15.forward = Vector3.New(var_353_20.x, var_353_20.y, var_353_20.z)

				local var_353_21 = var_353_15.localEulerAngles

				var_353_21.z = 0
				var_353_21.x = 0
				var_353_15.localEulerAngles = var_353_21
			end

			if arg_350_1.time_ >= var_353_16 + var_353_17 and arg_350_1.time_ < var_353_16 + var_353_17 + arg_353_0 then
				var_353_15.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_353_22 = manager.ui.mainCamera.transform.position - var_353_15.position

				var_353_15.forward = Vector3.New(var_353_22.x, var_353_22.y, var_353_22.z)

				local var_353_23 = var_353_15.localEulerAngles

				var_353_23.z = 0
				var_353_23.x = 0
				var_353_15.localEulerAngles = var_353_23
			end

			local var_353_24 = arg_350_1.actors_["1015ui_story"]
			local var_353_25 = 0

			if var_353_25 < arg_350_1.time_ and arg_350_1.time_ <= var_353_25 + arg_353_0 and not isNil(var_353_24) and arg_350_1.var_.characterEffect1015ui_story == nil then
				arg_350_1.var_.characterEffect1015ui_story = var_353_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_26 = 0.200000002980232

			if var_353_25 <= arg_350_1.time_ and arg_350_1.time_ < var_353_25 + var_353_26 and not isNil(var_353_24) then
				local var_353_27 = (arg_350_1.time_ - var_353_25) / var_353_26

				if arg_350_1.var_.characterEffect1015ui_story and not isNil(var_353_24) then
					arg_350_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= var_353_25 + var_353_26 and arg_350_1.time_ < var_353_25 + var_353_26 + arg_353_0 and not isNil(var_353_24) and arg_350_1.var_.characterEffect1015ui_story then
				arg_350_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_353_28 = 0

			if var_353_28 < arg_350_1.time_ and arg_350_1.time_ <= var_353_28 + arg_353_0 then
				arg_350_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action5_2")
			end

			local var_353_29 = 0

			if var_353_29 < arg_350_1.time_ and arg_350_1.time_ <= var_353_29 + arg_353_0 then
				arg_350_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_353_30 = 0
			local var_353_31 = 0.325

			if var_353_30 < arg_350_1.time_ and arg_350_1.time_ <= var_353_30 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_32 = arg_350_1:FormatText(StoryNameCfg[479].name)

				arg_350_1.leftNameTxt_.text = var_353_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_33 = arg_350_1:GetWordFromCfg(317012083)
				local var_353_34 = arg_350_1:FormatText(var_353_33.content)

				arg_350_1.text_.text = var_353_34

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_35 = 13
				local var_353_36 = utf8.len(var_353_34)
				local var_353_37 = var_353_35 <= 0 and var_353_31 or var_353_31 * (var_353_36 / var_353_35)

				if var_353_37 > 0 and var_353_31 < var_353_37 then
					arg_350_1.talkMaxDuration = var_353_37

					if var_353_37 + var_353_30 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_37 + var_353_30
					end
				end

				arg_350_1.text_.text = var_353_34
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012083", "story_v_out_317012.awb") ~= 0 then
					local var_353_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012083", "story_v_out_317012.awb") / 1000

					if var_353_38 + var_353_30 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_38 + var_353_30
					end

					if var_353_33.prefab_name ~= "" and arg_350_1.actors_[var_353_33.prefab_name] ~= nil then
						local var_353_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_33.prefab_name].transform, "story_v_out_317012", "317012083", "story_v_out_317012.awb")

						arg_350_1:RecordAudio("317012083", var_353_39)
						arg_350_1:RecordAudio("317012083", var_353_39)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_317012", "317012083", "story_v_out_317012.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_317012", "317012083", "story_v_out_317012.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_40 = math.max(var_353_31, arg_350_1.talkMaxDuration)

			if var_353_30 <= arg_350_1.time_ and arg_350_1.time_ < var_353_30 + var_353_40 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_30) / var_353_40

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_30 + var_353_40 and arg_350_1.time_ < var_353_30 + var_353_40 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_350_1:InitPlayNodeList()
	end,
	Play317012084 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 317012084
		arg_354_1.duration_ = 2.87

		local var_354_0 = {
			zh = 2.866,
			ja = 2
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play317012085(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["2078ui_story"].transform
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
				arg_354_1.var_.moveOldPos2078ui_story = var_357_0.localPosition
			end

			local var_357_2 = 0.001

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2
				local var_357_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_357_0.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos2078ui_story, var_357_4, var_357_3)

				local var_357_5 = manager.ui.mainCamera.transform.position - var_357_0.position

				var_357_0.forward = Vector3.New(var_357_5.x, var_357_5.y, var_357_5.z)

				local var_357_6 = var_357_0.localEulerAngles

				var_357_6.z = 0
				var_357_6.x = 0
				var_357_0.localEulerAngles = var_357_6
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 then
				var_357_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_357_7 = manager.ui.mainCamera.transform.position - var_357_0.position

				var_357_0.forward = Vector3.New(var_357_7.x, var_357_7.y, var_357_7.z)

				local var_357_8 = var_357_0.localEulerAngles

				var_357_8.z = 0
				var_357_8.x = 0
				var_357_0.localEulerAngles = var_357_8
			end

			local var_357_9 = arg_354_1.actors_["2078ui_story"]
			local var_357_10 = 0

			if var_357_10 < arg_354_1.time_ and arg_354_1.time_ <= var_357_10 + arg_357_0 and not isNil(var_357_9) and arg_354_1.var_.characterEffect2078ui_story == nil then
				arg_354_1.var_.characterEffect2078ui_story = var_357_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_11 = 0.200000002980232

			if var_357_10 <= arg_354_1.time_ and arg_354_1.time_ < var_357_10 + var_357_11 and not isNil(var_357_9) then
				local var_357_12 = (arg_354_1.time_ - var_357_10) / var_357_11

				if arg_354_1.var_.characterEffect2078ui_story and not isNil(var_357_9) then
					arg_354_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= var_357_10 + var_357_11 and arg_354_1.time_ < var_357_10 + var_357_11 + arg_357_0 and not isNil(var_357_9) and arg_354_1.var_.characterEffect2078ui_story then
				arg_354_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_357_13 = 0

			if var_357_13 < arg_354_1.time_ and arg_354_1.time_ <= var_357_13 + arg_357_0 then
				arg_354_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_357_14 = 0

			if var_357_14 < arg_354_1.time_ and arg_354_1.time_ <= var_357_14 + arg_357_0 then
				arg_354_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_357_15 = arg_354_1.actors_["1015ui_story"].transform
			local var_357_16 = 0

			if var_357_16 < arg_354_1.time_ and arg_354_1.time_ <= var_357_16 + arg_357_0 then
				arg_354_1.var_.moveOldPos1015ui_story = var_357_15.localPosition
			end

			local var_357_17 = 0.001

			if var_357_16 <= arg_354_1.time_ and arg_354_1.time_ < var_357_16 + var_357_17 then
				local var_357_18 = (arg_354_1.time_ - var_357_16) / var_357_17
				local var_357_19 = Vector3.New(0.7, -1.15, -6.2)

				var_357_15.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1015ui_story, var_357_19, var_357_18)

				local var_357_20 = manager.ui.mainCamera.transform.position - var_357_15.position

				var_357_15.forward = Vector3.New(var_357_20.x, var_357_20.y, var_357_20.z)

				local var_357_21 = var_357_15.localEulerAngles

				var_357_21.z = 0
				var_357_21.x = 0
				var_357_15.localEulerAngles = var_357_21
			end

			if arg_354_1.time_ >= var_357_16 + var_357_17 and arg_354_1.time_ < var_357_16 + var_357_17 + arg_357_0 then
				var_357_15.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_357_22 = manager.ui.mainCamera.transform.position - var_357_15.position

				var_357_15.forward = Vector3.New(var_357_22.x, var_357_22.y, var_357_22.z)

				local var_357_23 = var_357_15.localEulerAngles

				var_357_23.z = 0
				var_357_23.x = 0
				var_357_15.localEulerAngles = var_357_23
			end

			local var_357_24 = arg_354_1.actors_["1015ui_story"]
			local var_357_25 = 0

			if var_357_25 < arg_354_1.time_ and arg_354_1.time_ <= var_357_25 + arg_357_0 and not isNil(var_357_24) and arg_354_1.var_.characterEffect1015ui_story == nil then
				arg_354_1.var_.characterEffect1015ui_story = var_357_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_26 = 0.200000002980232

			if var_357_25 <= arg_354_1.time_ and arg_354_1.time_ < var_357_25 + var_357_26 and not isNil(var_357_24) then
				local var_357_27 = (arg_354_1.time_ - var_357_25) / var_357_26

				if arg_354_1.var_.characterEffect1015ui_story and not isNil(var_357_24) then
					local var_357_28 = Mathf.Lerp(0, 0.5, var_357_27)

					arg_354_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_354_1.var_.characterEffect1015ui_story.fillRatio = var_357_28
				end
			end

			if arg_354_1.time_ >= var_357_25 + var_357_26 and arg_354_1.time_ < var_357_25 + var_357_26 + arg_357_0 and not isNil(var_357_24) and arg_354_1.var_.characterEffect1015ui_story then
				local var_357_29 = 0.5

				arg_354_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_354_1.var_.characterEffect1015ui_story.fillRatio = var_357_29
			end

			local var_357_30 = 0
			local var_357_31 = 0.3

			if var_357_30 < arg_354_1.time_ and arg_354_1.time_ <= var_357_30 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_32 = arg_354_1:FormatText(StoryNameCfg[528].name)

				arg_354_1.leftNameTxt_.text = var_357_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_33 = arg_354_1:GetWordFromCfg(317012084)
				local var_357_34 = arg_354_1:FormatText(var_357_33.content)

				arg_354_1.text_.text = var_357_34

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_35 = 12
				local var_357_36 = utf8.len(var_357_34)
				local var_357_37 = var_357_35 <= 0 and var_357_31 or var_357_31 * (var_357_36 / var_357_35)

				if var_357_37 > 0 and var_357_31 < var_357_37 then
					arg_354_1.talkMaxDuration = var_357_37

					if var_357_37 + var_357_30 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_37 + var_357_30
					end
				end

				arg_354_1.text_.text = var_357_34
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012084", "story_v_out_317012.awb") ~= 0 then
					local var_357_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012084", "story_v_out_317012.awb") / 1000

					if var_357_38 + var_357_30 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_38 + var_357_30
					end

					if var_357_33.prefab_name ~= "" and arg_354_1.actors_[var_357_33.prefab_name] ~= nil then
						local var_357_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_33.prefab_name].transform, "story_v_out_317012", "317012084", "story_v_out_317012.awb")

						arg_354_1:RecordAudio("317012084", var_357_39)
						arg_354_1:RecordAudio("317012084", var_357_39)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_317012", "317012084", "story_v_out_317012.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_317012", "317012084", "story_v_out_317012.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_40 = math.max(var_357_31, arg_354_1.talkMaxDuration)

			if var_357_30 <= arg_354_1.time_ and arg_354_1.time_ < var_357_30 + var_357_40 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_30) / var_357_40

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_30 + var_357_40 and arg_354_1.time_ < var_357_30 + var_357_40 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_354_1:InitPlayNodeList()
	end,
	Play317012085 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 317012085
		arg_358_1.duration_ = 12.7

		local var_358_0 = {
			zh = 12.266,
			ja = 12.7
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play317012086(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["2078ui_story"].transform
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 then
				arg_358_1.var_.moveOldPos2078ui_story = var_361_0.localPosition
			end

			local var_361_2 = 0.001

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2
				local var_361_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_361_0.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos2078ui_story, var_361_4, var_361_3)

				local var_361_5 = manager.ui.mainCamera.transform.position - var_361_0.position

				var_361_0.forward = Vector3.New(var_361_5.x, var_361_5.y, var_361_5.z)

				local var_361_6 = var_361_0.localEulerAngles

				var_361_6.z = 0
				var_361_6.x = 0
				var_361_0.localEulerAngles = var_361_6
			end

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 then
				var_361_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_361_7 = manager.ui.mainCamera.transform.position - var_361_0.position

				var_361_0.forward = Vector3.New(var_361_7.x, var_361_7.y, var_361_7.z)

				local var_361_8 = var_361_0.localEulerAngles

				var_361_8.z = 0
				var_361_8.x = 0
				var_361_0.localEulerAngles = var_361_8
			end

			local var_361_9 = arg_358_1.actors_["2078ui_story"]
			local var_361_10 = 0

			if var_361_10 < arg_358_1.time_ and arg_358_1.time_ <= var_361_10 + arg_361_0 and not isNil(var_361_9) and arg_358_1.var_.characterEffect2078ui_story == nil then
				arg_358_1.var_.characterEffect2078ui_story = var_361_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_11 = 0.200000002980232

			if var_361_10 <= arg_358_1.time_ and arg_358_1.time_ < var_361_10 + var_361_11 and not isNil(var_361_9) then
				local var_361_12 = (arg_358_1.time_ - var_361_10) / var_361_11

				if arg_358_1.var_.characterEffect2078ui_story and not isNil(var_361_9) then
					local var_361_13 = Mathf.Lerp(0, 0.5, var_361_12)

					arg_358_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_358_1.var_.characterEffect2078ui_story.fillRatio = var_361_13
				end
			end

			if arg_358_1.time_ >= var_361_10 + var_361_11 and arg_358_1.time_ < var_361_10 + var_361_11 + arg_361_0 and not isNil(var_361_9) and arg_358_1.var_.characterEffect2078ui_story then
				local var_361_14 = 0.5

				arg_358_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_358_1.var_.characterEffect2078ui_story.fillRatio = var_361_14
			end

			local var_361_15 = arg_358_1.actors_["1015ui_story"].transform
			local var_361_16 = 0

			if var_361_16 < arg_358_1.time_ and arg_358_1.time_ <= var_361_16 + arg_361_0 then
				arg_358_1.var_.moveOldPos1015ui_story = var_361_15.localPosition
			end

			local var_361_17 = 0.001

			if var_361_16 <= arg_358_1.time_ and arg_358_1.time_ < var_361_16 + var_361_17 then
				local var_361_18 = (arg_358_1.time_ - var_361_16) / var_361_17
				local var_361_19 = Vector3.New(0.7, -1.15, -6.2)

				var_361_15.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1015ui_story, var_361_19, var_361_18)

				local var_361_20 = manager.ui.mainCamera.transform.position - var_361_15.position

				var_361_15.forward = Vector3.New(var_361_20.x, var_361_20.y, var_361_20.z)

				local var_361_21 = var_361_15.localEulerAngles

				var_361_21.z = 0
				var_361_21.x = 0
				var_361_15.localEulerAngles = var_361_21
			end

			if arg_358_1.time_ >= var_361_16 + var_361_17 and arg_358_1.time_ < var_361_16 + var_361_17 + arg_361_0 then
				var_361_15.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_361_22 = manager.ui.mainCamera.transform.position - var_361_15.position

				var_361_15.forward = Vector3.New(var_361_22.x, var_361_22.y, var_361_22.z)

				local var_361_23 = var_361_15.localEulerAngles

				var_361_23.z = 0
				var_361_23.x = 0
				var_361_15.localEulerAngles = var_361_23
			end

			local var_361_24 = arg_358_1.actors_["1015ui_story"]
			local var_361_25 = 0

			if var_361_25 < arg_358_1.time_ and arg_358_1.time_ <= var_361_25 + arg_361_0 and not isNil(var_361_24) and arg_358_1.var_.characterEffect1015ui_story == nil then
				arg_358_1.var_.characterEffect1015ui_story = var_361_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_26 = 0.200000002980232

			if var_361_25 <= arg_358_1.time_ and arg_358_1.time_ < var_361_25 + var_361_26 and not isNil(var_361_24) then
				local var_361_27 = (arg_358_1.time_ - var_361_25) / var_361_26

				if arg_358_1.var_.characterEffect1015ui_story and not isNil(var_361_24) then
					arg_358_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_358_1.time_ >= var_361_25 + var_361_26 and arg_358_1.time_ < var_361_25 + var_361_26 + arg_361_0 and not isNil(var_361_24) and arg_358_1.var_.characterEffect1015ui_story then
				arg_358_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_361_28 = 0

			if var_361_28 < arg_358_1.time_ and arg_358_1.time_ <= var_361_28 + arg_361_0 then
				arg_358_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_361_29 = 0

			if var_361_29 < arg_358_1.time_ and arg_358_1.time_ <= var_361_29 + arg_361_0 then
				arg_358_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_361_30 = 0
			local var_361_31 = 1.1

			if var_361_30 < arg_358_1.time_ and arg_358_1.time_ <= var_361_30 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_32 = arg_358_1:FormatText(StoryNameCfg[479].name)

				arg_358_1.leftNameTxt_.text = var_361_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_33 = arg_358_1:GetWordFromCfg(317012085)
				local var_361_34 = arg_358_1:FormatText(var_361_33.content)

				arg_358_1.text_.text = var_361_34

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_35 = 44
				local var_361_36 = utf8.len(var_361_34)
				local var_361_37 = var_361_35 <= 0 and var_361_31 or var_361_31 * (var_361_36 / var_361_35)

				if var_361_37 > 0 and var_361_31 < var_361_37 then
					arg_358_1.talkMaxDuration = var_361_37

					if var_361_37 + var_361_30 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_37 + var_361_30
					end
				end

				arg_358_1.text_.text = var_361_34
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012085", "story_v_out_317012.awb") ~= 0 then
					local var_361_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012085", "story_v_out_317012.awb") / 1000

					if var_361_38 + var_361_30 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_38 + var_361_30
					end

					if var_361_33.prefab_name ~= "" and arg_358_1.actors_[var_361_33.prefab_name] ~= nil then
						local var_361_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_33.prefab_name].transform, "story_v_out_317012", "317012085", "story_v_out_317012.awb")

						arg_358_1:RecordAudio("317012085", var_361_39)
						arg_358_1:RecordAudio("317012085", var_361_39)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_317012", "317012085", "story_v_out_317012.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_317012", "317012085", "story_v_out_317012.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_40 = math.max(var_361_31, arg_358_1.talkMaxDuration)

			if var_361_30 <= arg_358_1.time_ and arg_358_1.time_ < var_361_30 + var_361_40 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_30) / var_361_40

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_30 + var_361_40 and arg_358_1.time_ < var_361_30 + var_361_40 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_358_1:InitPlayNodeList()
	end,
	Play317012086 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 317012086
		arg_362_1.duration_ = 2.07

		local var_362_0 = {
			zh = 1.999999999999,
			ja = 2.066
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play317012087(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["2078ui_story"].transform
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 then
				arg_362_1.var_.moveOldPos2078ui_story = var_365_0.localPosition
			end

			local var_365_2 = 0.001

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_2 then
				local var_365_3 = (arg_362_1.time_ - var_365_1) / var_365_2
				local var_365_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_365_0.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos2078ui_story, var_365_4, var_365_3)

				local var_365_5 = manager.ui.mainCamera.transform.position - var_365_0.position

				var_365_0.forward = Vector3.New(var_365_5.x, var_365_5.y, var_365_5.z)

				local var_365_6 = var_365_0.localEulerAngles

				var_365_6.z = 0
				var_365_6.x = 0
				var_365_0.localEulerAngles = var_365_6
			end

			if arg_362_1.time_ >= var_365_1 + var_365_2 and arg_362_1.time_ < var_365_1 + var_365_2 + arg_365_0 then
				var_365_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_365_7 = manager.ui.mainCamera.transform.position - var_365_0.position

				var_365_0.forward = Vector3.New(var_365_7.x, var_365_7.y, var_365_7.z)

				local var_365_8 = var_365_0.localEulerAngles

				var_365_8.z = 0
				var_365_8.x = 0
				var_365_0.localEulerAngles = var_365_8
			end

			local var_365_9 = arg_362_1.actors_["2078ui_story"]
			local var_365_10 = 0

			if var_365_10 < arg_362_1.time_ and arg_362_1.time_ <= var_365_10 + arg_365_0 and not isNil(var_365_9) and arg_362_1.var_.characterEffect2078ui_story == nil then
				arg_362_1.var_.characterEffect2078ui_story = var_365_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_11 = 0.200000002980232

			if var_365_10 <= arg_362_1.time_ and arg_362_1.time_ < var_365_10 + var_365_11 and not isNil(var_365_9) then
				local var_365_12 = (arg_362_1.time_ - var_365_10) / var_365_11

				if arg_362_1.var_.characterEffect2078ui_story and not isNil(var_365_9) then
					arg_362_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= var_365_10 + var_365_11 and arg_362_1.time_ < var_365_10 + var_365_11 + arg_365_0 and not isNil(var_365_9) and arg_362_1.var_.characterEffect2078ui_story then
				arg_362_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_365_13 = 0

			if var_365_13 < arg_362_1.time_ and arg_362_1.time_ <= var_365_13 + arg_365_0 then
				arg_362_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_365_14 = 0

			if var_365_14 < arg_362_1.time_ and arg_362_1.time_ <= var_365_14 + arg_365_0 then
				arg_362_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_365_15 = arg_362_1.actors_["1015ui_story"].transform
			local var_365_16 = 0

			if var_365_16 < arg_362_1.time_ and arg_362_1.time_ <= var_365_16 + arg_365_0 then
				arg_362_1.var_.moveOldPos1015ui_story = var_365_15.localPosition
			end

			local var_365_17 = 0.001

			if var_365_16 <= arg_362_1.time_ and arg_362_1.time_ < var_365_16 + var_365_17 then
				local var_365_18 = (arg_362_1.time_ - var_365_16) / var_365_17
				local var_365_19 = Vector3.New(0, 100, 0)

				var_365_15.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1015ui_story, var_365_19, var_365_18)

				local var_365_20 = manager.ui.mainCamera.transform.position - var_365_15.position

				var_365_15.forward = Vector3.New(var_365_20.x, var_365_20.y, var_365_20.z)

				local var_365_21 = var_365_15.localEulerAngles

				var_365_21.z = 0
				var_365_21.x = 0
				var_365_15.localEulerAngles = var_365_21
			end

			if arg_362_1.time_ >= var_365_16 + var_365_17 and arg_362_1.time_ < var_365_16 + var_365_17 + arg_365_0 then
				var_365_15.localPosition = Vector3.New(0, 100, 0)

				local var_365_22 = manager.ui.mainCamera.transform.position - var_365_15.position

				var_365_15.forward = Vector3.New(var_365_22.x, var_365_22.y, var_365_22.z)

				local var_365_23 = var_365_15.localEulerAngles

				var_365_23.z = 0
				var_365_23.x = 0
				var_365_15.localEulerAngles = var_365_23
			end

			local var_365_24 = arg_362_1.actors_["1015ui_story"]
			local var_365_25 = 0

			if var_365_25 < arg_362_1.time_ and arg_362_1.time_ <= var_365_25 + arg_365_0 and not isNil(var_365_24) and arg_362_1.var_.characterEffect1015ui_story == nil then
				arg_362_1.var_.characterEffect1015ui_story = var_365_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_26 = 0.200000002980232

			if var_365_25 <= arg_362_1.time_ and arg_362_1.time_ < var_365_25 + var_365_26 and not isNil(var_365_24) then
				local var_365_27 = (arg_362_1.time_ - var_365_25) / var_365_26

				if arg_362_1.var_.characterEffect1015ui_story and not isNil(var_365_24) then
					local var_365_28 = Mathf.Lerp(0, 0.5, var_365_27)

					arg_362_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_362_1.var_.characterEffect1015ui_story.fillRatio = var_365_28
				end
			end

			if arg_362_1.time_ >= var_365_25 + var_365_26 and arg_362_1.time_ < var_365_25 + var_365_26 + arg_365_0 and not isNil(var_365_24) and arg_362_1.var_.characterEffect1015ui_story then
				local var_365_29 = 0.5

				arg_362_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_362_1.var_.characterEffect1015ui_story.fillRatio = var_365_29
			end

			local var_365_30 = arg_362_1.actors_["2079ui_story"].transform
			local var_365_31 = 0

			if var_365_31 < arg_362_1.time_ and arg_362_1.time_ <= var_365_31 + arg_365_0 then
				arg_362_1.var_.moveOldPos2079ui_story = var_365_30.localPosition
			end

			local var_365_32 = 0.001

			if var_365_31 <= arg_362_1.time_ and arg_362_1.time_ < var_365_31 + var_365_32 then
				local var_365_33 = (arg_362_1.time_ - var_365_31) / var_365_32
				local var_365_34 = Vector3.New(0.7, -1.28, -5.6)

				var_365_30.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos2079ui_story, var_365_34, var_365_33)

				local var_365_35 = manager.ui.mainCamera.transform.position - var_365_30.position

				var_365_30.forward = Vector3.New(var_365_35.x, var_365_35.y, var_365_35.z)

				local var_365_36 = var_365_30.localEulerAngles

				var_365_36.z = 0
				var_365_36.x = 0
				var_365_30.localEulerAngles = var_365_36
			end

			if arg_362_1.time_ >= var_365_31 + var_365_32 and arg_362_1.time_ < var_365_31 + var_365_32 + arg_365_0 then
				var_365_30.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_365_37 = manager.ui.mainCamera.transform.position - var_365_30.position

				var_365_30.forward = Vector3.New(var_365_37.x, var_365_37.y, var_365_37.z)

				local var_365_38 = var_365_30.localEulerAngles

				var_365_38.z = 0
				var_365_38.x = 0
				var_365_30.localEulerAngles = var_365_38
			end

			local var_365_39 = 0
			local var_365_40 = 0.075

			if var_365_39 < arg_362_1.time_ and arg_362_1.time_ <= var_365_39 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_41 = arg_362_1:FormatText(StoryNameCfg[528].name)

				arg_362_1.leftNameTxt_.text = var_365_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_42 = arg_362_1:GetWordFromCfg(317012086)
				local var_365_43 = arg_362_1:FormatText(var_365_42.content)

				arg_362_1.text_.text = var_365_43

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_44 = 3
				local var_365_45 = utf8.len(var_365_43)
				local var_365_46 = var_365_44 <= 0 and var_365_40 or var_365_40 * (var_365_45 / var_365_44)

				if var_365_46 > 0 and var_365_40 < var_365_46 then
					arg_362_1.talkMaxDuration = var_365_46

					if var_365_46 + var_365_39 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_46 + var_365_39
					end
				end

				arg_362_1.text_.text = var_365_43
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012086", "story_v_out_317012.awb") ~= 0 then
					local var_365_47 = manager.audio:GetVoiceLength("story_v_out_317012", "317012086", "story_v_out_317012.awb") / 1000

					if var_365_47 + var_365_39 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_47 + var_365_39
					end

					if var_365_42.prefab_name ~= "" and arg_362_1.actors_[var_365_42.prefab_name] ~= nil then
						local var_365_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_42.prefab_name].transform, "story_v_out_317012", "317012086", "story_v_out_317012.awb")

						arg_362_1:RecordAudio("317012086", var_365_48)
						arg_362_1:RecordAudio("317012086", var_365_48)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_317012", "317012086", "story_v_out_317012.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_317012", "317012086", "story_v_out_317012.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_49 = math.max(var_365_40, arg_362_1.talkMaxDuration)

			if var_365_39 <= arg_362_1.time_ and arg_362_1.time_ < var_365_39 + var_365_49 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_39) / var_365_49

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_39 + var_365_49 and arg_362_1.time_ < var_365_39 + var_365_49 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play317012087 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 317012087
		arg_366_1.duration_ = 2.3

		local var_366_0 = {
			zh = 2.3,
			ja = 1.999999999999
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play317012088(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["2079ui_story"].transform
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
				arg_366_1.var_.moveOldPos2079ui_story = var_369_0.localPosition
			end

			local var_369_2 = 0.001

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2
				local var_369_4 = Vector3.New(0.7, -1.28, -5.6)

				var_369_0.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos2079ui_story, var_369_4, var_369_3)

				local var_369_5 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_5.x, var_369_5.y, var_369_5.z)

				local var_369_6 = var_369_0.localEulerAngles

				var_369_6.z = 0
				var_369_6.x = 0
				var_369_0.localEulerAngles = var_369_6
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 then
				var_369_0.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_369_7 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_7.x, var_369_7.y, var_369_7.z)

				local var_369_8 = var_369_0.localEulerAngles

				var_369_8.z = 0
				var_369_8.x = 0
				var_369_0.localEulerAngles = var_369_8
			end

			local var_369_9 = arg_366_1.actors_["2079ui_story"]
			local var_369_10 = 0

			if var_369_10 < arg_366_1.time_ and arg_366_1.time_ <= var_369_10 + arg_369_0 and not isNil(var_369_9) and arg_366_1.var_.characterEffect2079ui_story == nil then
				arg_366_1.var_.characterEffect2079ui_story = var_369_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_11 = 0.200000002980232

			if var_369_10 <= arg_366_1.time_ and arg_366_1.time_ < var_369_10 + var_369_11 and not isNil(var_369_9) then
				local var_369_12 = (arg_366_1.time_ - var_369_10) / var_369_11

				if arg_366_1.var_.characterEffect2079ui_story and not isNil(var_369_9) then
					arg_366_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= var_369_10 + var_369_11 and arg_366_1.time_ < var_369_10 + var_369_11 + arg_369_0 and not isNil(var_369_9) and arg_366_1.var_.characterEffect2079ui_story then
				arg_366_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_369_13 = 0

			if var_369_13 < arg_366_1.time_ and arg_366_1.time_ <= var_369_13 + arg_369_0 then
				arg_366_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_369_14 = 0

			if var_369_14 < arg_366_1.time_ and arg_366_1.time_ <= var_369_14 + arg_369_0 then
				arg_366_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_369_15 = arg_366_1.actors_["2078ui_story"].transform
			local var_369_16 = 0

			if var_369_16 < arg_366_1.time_ and arg_366_1.time_ <= var_369_16 + arg_369_0 then
				arg_366_1.var_.moveOldPos2078ui_story = var_369_15.localPosition
			end

			local var_369_17 = 0.001

			if var_369_16 <= arg_366_1.time_ and arg_366_1.time_ < var_369_16 + var_369_17 then
				local var_369_18 = (arg_366_1.time_ - var_369_16) / var_369_17
				local var_369_19 = Vector3.New(-0.7, -1.28, -5.6)

				var_369_15.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos2078ui_story, var_369_19, var_369_18)

				local var_369_20 = manager.ui.mainCamera.transform.position - var_369_15.position

				var_369_15.forward = Vector3.New(var_369_20.x, var_369_20.y, var_369_20.z)

				local var_369_21 = var_369_15.localEulerAngles

				var_369_21.z = 0
				var_369_21.x = 0
				var_369_15.localEulerAngles = var_369_21
			end

			if arg_366_1.time_ >= var_369_16 + var_369_17 and arg_366_1.time_ < var_369_16 + var_369_17 + arg_369_0 then
				var_369_15.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_369_22 = manager.ui.mainCamera.transform.position - var_369_15.position

				var_369_15.forward = Vector3.New(var_369_22.x, var_369_22.y, var_369_22.z)

				local var_369_23 = var_369_15.localEulerAngles

				var_369_23.z = 0
				var_369_23.x = 0
				var_369_15.localEulerAngles = var_369_23
			end

			local var_369_24 = arg_366_1.actors_["2078ui_story"]
			local var_369_25 = 0

			if var_369_25 < arg_366_1.time_ and arg_366_1.time_ <= var_369_25 + arg_369_0 and not isNil(var_369_24) and arg_366_1.var_.characterEffect2078ui_story == nil then
				arg_366_1.var_.characterEffect2078ui_story = var_369_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_26 = 0.200000002980232

			if var_369_25 <= arg_366_1.time_ and arg_366_1.time_ < var_369_25 + var_369_26 and not isNil(var_369_24) then
				local var_369_27 = (arg_366_1.time_ - var_369_25) / var_369_26

				if arg_366_1.var_.characterEffect2078ui_story and not isNil(var_369_24) then
					local var_369_28 = Mathf.Lerp(0, 0.5, var_369_27)

					arg_366_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_366_1.var_.characterEffect2078ui_story.fillRatio = var_369_28
				end
			end

			if arg_366_1.time_ >= var_369_25 + var_369_26 and arg_366_1.time_ < var_369_25 + var_369_26 + arg_369_0 and not isNil(var_369_24) and arg_366_1.var_.characterEffect2078ui_story then
				local var_369_29 = 0.5

				arg_366_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_366_1.var_.characterEffect2078ui_story.fillRatio = var_369_29
			end

			local var_369_30 = 0
			local var_369_31 = 0.075

			if var_369_30 < arg_366_1.time_ and arg_366_1.time_ <= var_369_30 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_32 = arg_366_1:FormatText(StoryNameCfg[529].name)

				arg_366_1.leftNameTxt_.text = var_369_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_33 = arg_366_1:GetWordFromCfg(317012087)
				local var_369_34 = arg_366_1:FormatText(var_369_33.content)

				arg_366_1.text_.text = var_369_34

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_35 = 3
				local var_369_36 = utf8.len(var_369_34)
				local var_369_37 = var_369_35 <= 0 and var_369_31 or var_369_31 * (var_369_36 / var_369_35)

				if var_369_37 > 0 and var_369_31 < var_369_37 then
					arg_366_1.talkMaxDuration = var_369_37

					if var_369_37 + var_369_30 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_37 + var_369_30
					end
				end

				arg_366_1.text_.text = var_369_34
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012087", "story_v_out_317012.awb") ~= 0 then
					local var_369_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012087", "story_v_out_317012.awb") / 1000

					if var_369_38 + var_369_30 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_38 + var_369_30
					end

					if var_369_33.prefab_name ~= "" and arg_366_1.actors_[var_369_33.prefab_name] ~= nil then
						local var_369_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_33.prefab_name].transform, "story_v_out_317012", "317012087", "story_v_out_317012.awb")

						arg_366_1:RecordAudio("317012087", var_369_39)
						arg_366_1:RecordAudio("317012087", var_369_39)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_317012", "317012087", "story_v_out_317012.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_317012", "317012087", "story_v_out_317012.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_40 = math.max(var_369_31, arg_366_1.talkMaxDuration)

			if var_369_30 <= arg_366_1.time_ and arg_366_1.time_ < var_369_30 + var_369_40 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_30) / var_369_40

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_30 + var_369_40 and arg_366_1.time_ < var_369_30 + var_369_40 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play317012088 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 317012088
		arg_370_1.duration_ = 1.6

		local var_370_0 = {
			zh = 1.4,
			ja = 1.6
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play317012089(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["2078ui_story"].transform
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
				arg_370_1.var_.moveOldPos2078ui_story = var_373_0.localPosition
			end

			local var_373_2 = 0.001

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2
				local var_373_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_373_0.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos2078ui_story, var_373_4, var_373_3)

				local var_373_5 = manager.ui.mainCamera.transform.position - var_373_0.position

				var_373_0.forward = Vector3.New(var_373_5.x, var_373_5.y, var_373_5.z)

				local var_373_6 = var_373_0.localEulerAngles

				var_373_6.z = 0
				var_373_6.x = 0
				var_373_0.localEulerAngles = var_373_6
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 then
				var_373_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_373_7 = manager.ui.mainCamera.transform.position - var_373_0.position

				var_373_0.forward = Vector3.New(var_373_7.x, var_373_7.y, var_373_7.z)

				local var_373_8 = var_373_0.localEulerAngles

				var_373_8.z = 0
				var_373_8.x = 0
				var_373_0.localEulerAngles = var_373_8
			end

			local var_373_9 = arg_370_1.actors_["2078ui_story"]
			local var_373_10 = 0

			if var_373_10 < arg_370_1.time_ and arg_370_1.time_ <= var_373_10 + arg_373_0 and not isNil(var_373_9) and arg_370_1.var_.characterEffect2078ui_story == nil then
				arg_370_1.var_.characterEffect2078ui_story = var_373_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_11 = 0.200000002980232

			if var_373_10 <= arg_370_1.time_ and arg_370_1.time_ < var_373_10 + var_373_11 and not isNil(var_373_9) then
				local var_373_12 = (arg_370_1.time_ - var_373_10) / var_373_11

				if arg_370_1.var_.characterEffect2078ui_story and not isNil(var_373_9) then
					arg_370_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_370_1.time_ >= var_373_10 + var_373_11 and arg_370_1.time_ < var_373_10 + var_373_11 + arg_373_0 and not isNil(var_373_9) and arg_370_1.var_.characterEffect2078ui_story then
				arg_370_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_373_13 = 0

			if var_373_13 < arg_370_1.time_ and arg_370_1.time_ <= var_373_13 + arg_373_0 then
				arg_370_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_373_14 = 0

			if var_373_14 < arg_370_1.time_ and arg_370_1.time_ <= var_373_14 + arg_373_0 then
				arg_370_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_373_15 = arg_370_1.actors_["1015ui_story"].transform
			local var_373_16 = 0

			if var_373_16 < arg_370_1.time_ and arg_370_1.time_ <= var_373_16 + arg_373_0 then
				arg_370_1.var_.moveOldPos1015ui_story = var_373_15.localPosition
			end

			local var_373_17 = 0.001

			if var_373_16 <= arg_370_1.time_ and arg_370_1.time_ < var_373_16 + var_373_17 then
				local var_373_18 = (arg_370_1.time_ - var_373_16) / var_373_17
				local var_373_19 = Vector3.New(0.7, -1.15, -6.2)

				var_373_15.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1015ui_story, var_373_19, var_373_18)

				local var_373_20 = manager.ui.mainCamera.transform.position - var_373_15.position

				var_373_15.forward = Vector3.New(var_373_20.x, var_373_20.y, var_373_20.z)

				local var_373_21 = var_373_15.localEulerAngles

				var_373_21.z = 0
				var_373_21.x = 0
				var_373_15.localEulerAngles = var_373_21
			end

			if arg_370_1.time_ >= var_373_16 + var_373_17 and arg_370_1.time_ < var_373_16 + var_373_17 + arg_373_0 then
				var_373_15.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_373_22 = manager.ui.mainCamera.transform.position - var_373_15.position

				var_373_15.forward = Vector3.New(var_373_22.x, var_373_22.y, var_373_22.z)

				local var_373_23 = var_373_15.localEulerAngles

				var_373_23.z = 0
				var_373_23.x = 0
				var_373_15.localEulerAngles = var_373_23
			end

			local var_373_24 = arg_370_1.actors_["1015ui_story"]
			local var_373_25 = 0

			if var_373_25 < arg_370_1.time_ and arg_370_1.time_ <= var_373_25 + arg_373_0 and not isNil(var_373_24) and arg_370_1.var_.characterEffect1015ui_story == nil then
				arg_370_1.var_.characterEffect1015ui_story = var_373_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_26 = 0.200000002980232

			if var_373_25 <= arg_370_1.time_ and arg_370_1.time_ < var_373_25 + var_373_26 and not isNil(var_373_24) then
				local var_373_27 = (arg_370_1.time_ - var_373_25) / var_373_26

				if arg_370_1.var_.characterEffect1015ui_story and not isNil(var_373_24) then
					local var_373_28 = Mathf.Lerp(0, 0.5, var_373_27)

					arg_370_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_370_1.var_.characterEffect1015ui_story.fillRatio = var_373_28
				end
			end

			if arg_370_1.time_ >= var_373_25 + var_373_26 and arg_370_1.time_ < var_373_25 + var_373_26 + arg_373_0 and not isNil(var_373_24) and arg_370_1.var_.characterEffect1015ui_story then
				local var_373_29 = 0.5

				arg_370_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_370_1.var_.characterEffect1015ui_story.fillRatio = var_373_29
			end

			local var_373_30 = arg_370_1.actors_["2079ui_story"].transform
			local var_373_31 = 0

			if var_373_31 < arg_370_1.time_ and arg_370_1.time_ <= var_373_31 + arg_373_0 then
				arg_370_1.var_.moveOldPos2079ui_story = var_373_30.localPosition
			end

			local var_373_32 = 0.001

			if var_373_31 <= arg_370_1.time_ and arg_370_1.time_ < var_373_31 + var_373_32 then
				local var_373_33 = (arg_370_1.time_ - var_373_31) / var_373_32
				local var_373_34 = Vector3.New(0, 100, 0)

				var_373_30.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos2079ui_story, var_373_34, var_373_33)

				local var_373_35 = manager.ui.mainCamera.transform.position - var_373_30.position

				var_373_30.forward = Vector3.New(var_373_35.x, var_373_35.y, var_373_35.z)

				local var_373_36 = var_373_30.localEulerAngles

				var_373_36.z = 0
				var_373_36.x = 0
				var_373_30.localEulerAngles = var_373_36
			end

			if arg_370_1.time_ >= var_373_31 + var_373_32 and arg_370_1.time_ < var_373_31 + var_373_32 + arg_373_0 then
				var_373_30.localPosition = Vector3.New(0, 100, 0)

				local var_373_37 = manager.ui.mainCamera.transform.position - var_373_30.position

				var_373_30.forward = Vector3.New(var_373_37.x, var_373_37.y, var_373_37.z)

				local var_373_38 = var_373_30.localEulerAngles

				var_373_38.z = 0
				var_373_38.x = 0
				var_373_30.localEulerAngles = var_373_38
			end

			local var_373_39 = arg_370_1.actors_["2079ui_story"]
			local var_373_40 = 0

			if var_373_40 < arg_370_1.time_ and arg_370_1.time_ <= var_373_40 + arg_373_0 and not isNil(var_373_39) and arg_370_1.var_.characterEffect2079ui_story == nil then
				arg_370_1.var_.characterEffect2079ui_story = var_373_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_41 = 0.200000002980232

			if var_373_40 <= arg_370_1.time_ and arg_370_1.time_ < var_373_40 + var_373_41 and not isNil(var_373_39) then
				local var_373_42 = (arg_370_1.time_ - var_373_40) / var_373_41

				if arg_370_1.var_.characterEffect2079ui_story and not isNil(var_373_39) then
					local var_373_43 = Mathf.Lerp(0, 0.5, var_373_42)

					arg_370_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_370_1.var_.characterEffect2079ui_story.fillRatio = var_373_43
				end
			end

			if arg_370_1.time_ >= var_373_40 + var_373_41 and arg_370_1.time_ < var_373_40 + var_373_41 + arg_373_0 and not isNil(var_373_39) and arg_370_1.var_.characterEffect2079ui_story then
				local var_373_44 = 0.5

				arg_370_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_370_1.var_.characterEffect2079ui_story.fillRatio = var_373_44
			end

			local var_373_45 = 0
			local var_373_46 = 0.075

			if var_373_45 < arg_370_1.time_ and arg_370_1.time_ <= var_373_45 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_47 = arg_370_1:FormatText(StoryNameCfg[530].name)

				arg_370_1.leftNameTxt_.text = var_373_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_48 = arg_370_1:GetWordFromCfg(317012088)
				local var_373_49 = arg_370_1:FormatText(var_373_48.content)

				arg_370_1.text_.text = var_373_49

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_50 = 3
				local var_373_51 = utf8.len(var_373_49)
				local var_373_52 = var_373_50 <= 0 and var_373_46 or var_373_46 * (var_373_51 / var_373_50)

				if var_373_52 > 0 and var_373_46 < var_373_52 then
					arg_370_1.talkMaxDuration = var_373_52

					if var_373_52 + var_373_45 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_52 + var_373_45
					end
				end

				arg_370_1.text_.text = var_373_49
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012088", "story_v_out_317012.awb") ~= 0 then
					local var_373_53 = manager.audio:GetVoiceLength("story_v_out_317012", "317012088", "story_v_out_317012.awb") / 1000

					if var_373_53 + var_373_45 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_53 + var_373_45
					end

					if var_373_48.prefab_name ~= "" and arg_370_1.actors_[var_373_48.prefab_name] ~= nil then
						local var_373_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_48.prefab_name].transform, "story_v_out_317012", "317012088", "story_v_out_317012.awb")

						arg_370_1:RecordAudio("317012088", var_373_54)
						arg_370_1:RecordAudio("317012088", var_373_54)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_317012", "317012088", "story_v_out_317012.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_317012", "317012088", "story_v_out_317012.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_55 = math.max(var_373_46, arg_370_1.talkMaxDuration)

			if var_373_45 <= arg_370_1.time_ and arg_370_1.time_ < var_373_45 + var_373_55 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_45) / var_373_55

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_45 + var_373_55 and arg_370_1.time_ < var_373_45 + var_373_55 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play317012089 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 317012089
		arg_374_1.duration_ = 9.9

		local var_374_0 = {
			zh = 9.9,
			ja = 6
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play317012090(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0

			if var_377_0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				arg_374_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 then
				arg_374_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_377_2 = arg_374_1.actors_["1015ui_story"]
			local var_377_3 = 0

			if var_377_3 < arg_374_1.time_ and arg_374_1.time_ <= var_377_3 + arg_377_0 and not isNil(var_377_2) and arg_374_1.var_.characterEffect1015ui_story == nil then
				arg_374_1.var_.characterEffect1015ui_story = var_377_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_4 = 0.200000002980232

			if var_377_3 <= arg_374_1.time_ and arg_374_1.time_ < var_377_3 + var_377_4 and not isNil(var_377_2) then
				local var_377_5 = (arg_374_1.time_ - var_377_3) / var_377_4

				if arg_374_1.var_.characterEffect1015ui_story and not isNil(var_377_2) then
					arg_374_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= var_377_3 + var_377_4 and arg_374_1.time_ < var_377_3 + var_377_4 + arg_377_0 and not isNil(var_377_2) and arg_374_1.var_.characterEffect1015ui_story then
				arg_374_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_377_6 = arg_374_1.actors_["2078ui_story"]
			local var_377_7 = 0

			if var_377_7 < arg_374_1.time_ and arg_374_1.time_ <= var_377_7 + arg_377_0 and not isNil(var_377_6) and arg_374_1.var_.characterEffect2078ui_story == nil then
				arg_374_1.var_.characterEffect2078ui_story = var_377_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_8 = 0.200000002980232

			if var_377_7 <= arg_374_1.time_ and arg_374_1.time_ < var_377_7 + var_377_8 and not isNil(var_377_6) then
				local var_377_9 = (arg_374_1.time_ - var_377_7) / var_377_8

				if arg_374_1.var_.characterEffect2078ui_story and not isNil(var_377_6) then
					local var_377_10 = Mathf.Lerp(0, 0.5, var_377_9)

					arg_374_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_374_1.var_.characterEffect2078ui_story.fillRatio = var_377_10
				end
			end

			if arg_374_1.time_ >= var_377_7 + var_377_8 and arg_374_1.time_ < var_377_7 + var_377_8 + arg_377_0 and not isNil(var_377_6) and arg_374_1.var_.characterEffect2078ui_story then
				local var_377_11 = 0.5

				arg_374_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_374_1.var_.characterEffect2078ui_story.fillRatio = var_377_11
			end

			local var_377_12 = 0
			local var_377_13 = 1.175

			if var_377_12 < arg_374_1.time_ and arg_374_1.time_ <= var_377_12 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_14 = arg_374_1:FormatText(StoryNameCfg[479].name)

				arg_374_1.leftNameTxt_.text = var_377_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_15 = arg_374_1:GetWordFromCfg(317012089)
				local var_377_16 = arg_374_1:FormatText(var_377_15.content)

				arg_374_1.text_.text = var_377_16

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_17 = 47
				local var_377_18 = utf8.len(var_377_16)
				local var_377_19 = var_377_17 <= 0 and var_377_13 or var_377_13 * (var_377_18 / var_377_17)

				if var_377_19 > 0 and var_377_13 < var_377_19 then
					arg_374_1.talkMaxDuration = var_377_19

					if var_377_19 + var_377_12 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_19 + var_377_12
					end
				end

				arg_374_1.text_.text = var_377_16
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012089", "story_v_out_317012.awb") ~= 0 then
					local var_377_20 = manager.audio:GetVoiceLength("story_v_out_317012", "317012089", "story_v_out_317012.awb") / 1000

					if var_377_20 + var_377_12 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_20 + var_377_12
					end

					if var_377_15.prefab_name ~= "" and arg_374_1.actors_[var_377_15.prefab_name] ~= nil then
						local var_377_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_15.prefab_name].transform, "story_v_out_317012", "317012089", "story_v_out_317012.awb")

						arg_374_1:RecordAudio("317012089", var_377_21)
						arg_374_1:RecordAudio("317012089", var_377_21)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_317012", "317012089", "story_v_out_317012.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_317012", "317012089", "story_v_out_317012.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_22 = math.max(var_377_13, arg_374_1.talkMaxDuration)

			if var_377_12 <= arg_374_1.time_ and arg_374_1.time_ < var_377_12 + var_377_22 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_12) / var_377_22

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_12 + var_377_22 and arg_374_1.time_ < var_377_12 + var_377_22 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play317012090 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 317012090
		arg_378_1.duration_ = 6.9

		local var_378_0 = {
			zh = 5.466,
			ja = 6.9
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play317012091(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["1015ui_story"].transform
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.var_.moveOldPos1015ui_story = var_381_0.localPosition
			end

			local var_381_2 = 0.001

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2
				local var_381_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_381_0.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1015ui_story, var_381_4, var_381_3)

				local var_381_5 = manager.ui.mainCamera.transform.position - var_381_0.position

				var_381_0.forward = Vector3.New(var_381_5.x, var_381_5.y, var_381_5.z)

				local var_381_6 = var_381_0.localEulerAngles

				var_381_6.z = 0
				var_381_6.x = 0
				var_381_0.localEulerAngles = var_381_6
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 then
				var_381_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_381_7 = manager.ui.mainCamera.transform.position - var_381_0.position

				var_381_0.forward = Vector3.New(var_381_7.x, var_381_7.y, var_381_7.z)

				local var_381_8 = var_381_0.localEulerAngles

				var_381_8.z = 0
				var_381_8.x = 0
				var_381_0.localEulerAngles = var_381_8
			end

			local var_381_9 = arg_378_1.actors_["1015ui_story"]
			local var_381_10 = 0

			if var_381_10 < arg_378_1.time_ and arg_378_1.time_ <= var_381_10 + arg_381_0 and not isNil(var_381_9) and arg_378_1.var_.characterEffect1015ui_story == nil then
				arg_378_1.var_.characterEffect1015ui_story = var_381_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_11 = 0.200000002980232

			if var_381_10 <= arg_378_1.time_ and arg_378_1.time_ < var_381_10 + var_381_11 and not isNil(var_381_9) then
				local var_381_12 = (arg_378_1.time_ - var_381_10) / var_381_11

				if arg_378_1.var_.characterEffect1015ui_story and not isNil(var_381_9) then
					local var_381_13 = Mathf.Lerp(0, 0.5, var_381_12)

					arg_378_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1015ui_story.fillRatio = var_381_13
				end
			end

			if arg_378_1.time_ >= var_381_10 + var_381_11 and arg_378_1.time_ < var_381_10 + var_381_11 + arg_381_0 and not isNil(var_381_9) and arg_378_1.var_.characterEffect1015ui_story then
				local var_381_14 = 0.5

				arg_378_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1015ui_story.fillRatio = var_381_14
			end

			local var_381_15 = arg_378_1.actors_["2079ui_story"].transform
			local var_381_16 = 0

			if var_381_16 < arg_378_1.time_ and arg_378_1.time_ <= var_381_16 + arg_381_0 then
				arg_378_1.var_.moveOldPos2079ui_story = var_381_15.localPosition
			end

			local var_381_17 = 0.001

			if var_381_16 <= arg_378_1.time_ and arg_378_1.time_ < var_381_16 + var_381_17 then
				local var_381_18 = (arg_378_1.time_ - var_381_16) / var_381_17
				local var_381_19 = Vector3.New(0.7, -1.28, -5.6)

				var_381_15.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos2079ui_story, var_381_19, var_381_18)

				local var_381_20 = manager.ui.mainCamera.transform.position - var_381_15.position

				var_381_15.forward = Vector3.New(var_381_20.x, var_381_20.y, var_381_20.z)

				local var_381_21 = var_381_15.localEulerAngles

				var_381_21.z = 0
				var_381_21.x = 0
				var_381_15.localEulerAngles = var_381_21
			end

			if arg_378_1.time_ >= var_381_16 + var_381_17 and arg_378_1.time_ < var_381_16 + var_381_17 + arg_381_0 then
				var_381_15.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_381_22 = manager.ui.mainCamera.transform.position - var_381_15.position

				var_381_15.forward = Vector3.New(var_381_22.x, var_381_22.y, var_381_22.z)

				local var_381_23 = var_381_15.localEulerAngles

				var_381_23.z = 0
				var_381_23.x = 0
				var_381_15.localEulerAngles = var_381_23
			end

			local var_381_24 = arg_378_1.actors_["2079ui_story"]
			local var_381_25 = 0

			if var_381_25 < arg_378_1.time_ and arg_378_1.time_ <= var_381_25 + arg_381_0 and not isNil(var_381_24) and arg_378_1.var_.characterEffect2079ui_story == nil then
				arg_378_1.var_.characterEffect2079ui_story = var_381_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_26 = 0.200000002980232

			if var_381_25 <= arg_378_1.time_ and arg_378_1.time_ < var_381_25 + var_381_26 and not isNil(var_381_24) then
				local var_381_27 = (arg_378_1.time_ - var_381_25) / var_381_26

				if arg_378_1.var_.characterEffect2079ui_story and not isNil(var_381_24) then
					arg_378_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= var_381_25 + var_381_26 and arg_378_1.time_ < var_381_25 + var_381_26 + arg_381_0 and not isNil(var_381_24) and arg_378_1.var_.characterEffect2079ui_story then
				arg_378_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_381_28 = 0

			if var_381_28 < arg_378_1.time_ and arg_378_1.time_ <= var_381_28 + arg_381_0 then
				arg_378_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_381_29 = 0

			if var_381_29 < arg_378_1.time_ and arg_378_1.time_ <= var_381_29 + arg_381_0 then
				arg_378_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_381_30 = arg_378_1.actors_["2078ui_story"].transform
			local var_381_31 = 0

			if var_381_31 < arg_378_1.time_ and arg_378_1.time_ <= var_381_31 + arg_381_0 then
				arg_378_1.var_.moveOldPos2078ui_story = var_381_30.localPosition
			end

			local var_381_32 = 0.001

			if var_381_31 <= arg_378_1.time_ and arg_378_1.time_ < var_381_31 + var_381_32 then
				local var_381_33 = (arg_378_1.time_ - var_381_31) / var_381_32
				local var_381_34 = Vector3.New(0, 100, 0)

				var_381_30.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos2078ui_story, var_381_34, var_381_33)

				local var_381_35 = manager.ui.mainCamera.transform.position - var_381_30.position

				var_381_30.forward = Vector3.New(var_381_35.x, var_381_35.y, var_381_35.z)

				local var_381_36 = var_381_30.localEulerAngles

				var_381_36.z = 0
				var_381_36.x = 0
				var_381_30.localEulerAngles = var_381_36
			end

			if arg_378_1.time_ >= var_381_31 + var_381_32 and arg_378_1.time_ < var_381_31 + var_381_32 + arg_381_0 then
				var_381_30.localPosition = Vector3.New(0, 100, 0)

				local var_381_37 = manager.ui.mainCamera.transform.position - var_381_30.position

				var_381_30.forward = Vector3.New(var_381_37.x, var_381_37.y, var_381_37.z)

				local var_381_38 = var_381_30.localEulerAngles

				var_381_38.z = 0
				var_381_38.x = 0
				var_381_30.localEulerAngles = var_381_38
			end

			local var_381_39 = 0
			local var_381_40 = 0.5

			if var_381_39 < arg_378_1.time_ and arg_378_1.time_ <= var_381_39 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_41 = arg_378_1:FormatText(StoryNameCfg[529].name)

				arg_378_1.leftNameTxt_.text = var_381_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_42 = arg_378_1:GetWordFromCfg(317012090)
				local var_381_43 = arg_378_1:FormatText(var_381_42.content)

				arg_378_1.text_.text = var_381_43

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_44 = 20
				local var_381_45 = utf8.len(var_381_43)
				local var_381_46 = var_381_44 <= 0 and var_381_40 or var_381_40 * (var_381_45 / var_381_44)

				if var_381_46 > 0 and var_381_40 < var_381_46 then
					arg_378_1.talkMaxDuration = var_381_46

					if var_381_46 + var_381_39 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_46 + var_381_39
					end
				end

				arg_378_1.text_.text = var_381_43
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012090", "story_v_out_317012.awb") ~= 0 then
					local var_381_47 = manager.audio:GetVoiceLength("story_v_out_317012", "317012090", "story_v_out_317012.awb") / 1000

					if var_381_47 + var_381_39 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_47 + var_381_39
					end

					if var_381_42.prefab_name ~= "" and arg_378_1.actors_[var_381_42.prefab_name] ~= nil then
						local var_381_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_42.prefab_name].transform, "story_v_out_317012", "317012090", "story_v_out_317012.awb")

						arg_378_1:RecordAudio("317012090", var_381_48)
						arg_378_1:RecordAudio("317012090", var_381_48)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_317012", "317012090", "story_v_out_317012.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_317012", "317012090", "story_v_out_317012.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_49 = math.max(var_381_40, arg_378_1.talkMaxDuration)

			if var_381_39 <= arg_378_1.time_ and arg_378_1.time_ < var_381_39 + var_381_49 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_39) / var_381_49

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_39 + var_381_49 and arg_378_1.time_ < var_381_39 + var_381_49 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
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
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play317012091 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 317012091
		arg_382_1.duration_ = 12.13

		local var_382_0 = {
			zh = 12.133,
			ja = 10.5
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play317012092(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["2078ui_story"].transform
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.var_.moveOldPos2078ui_story = var_385_0.localPosition
			end

			local var_385_2 = 0.001

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2
				local var_385_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_385_0.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos2078ui_story, var_385_4, var_385_3)

				local var_385_5 = manager.ui.mainCamera.transform.position - var_385_0.position

				var_385_0.forward = Vector3.New(var_385_5.x, var_385_5.y, var_385_5.z)

				local var_385_6 = var_385_0.localEulerAngles

				var_385_6.z = 0
				var_385_6.x = 0
				var_385_0.localEulerAngles = var_385_6
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 then
				var_385_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_385_7 = manager.ui.mainCamera.transform.position - var_385_0.position

				var_385_0.forward = Vector3.New(var_385_7.x, var_385_7.y, var_385_7.z)

				local var_385_8 = var_385_0.localEulerAngles

				var_385_8.z = 0
				var_385_8.x = 0
				var_385_0.localEulerAngles = var_385_8
			end

			local var_385_9 = arg_382_1.actors_["2078ui_story"]
			local var_385_10 = 0

			if var_385_10 < arg_382_1.time_ and arg_382_1.time_ <= var_385_10 + arg_385_0 and not isNil(var_385_9) and arg_382_1.var_.characterEffect2078ui_story == nil then
				arg_382_1.var_.characterEffect2078ui_story = var_385_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_11 = 0.200000002980232

			if var_385_10 <= arg_382_1.time_ and arg_382_1.time_ < var_385_10 + var_385_11 and not isNil(var_385_9) then
				local var_385_12 = (arg_382_1.time_ - var_385_10) / var_385_11

				if arg_382_1.var_.characterEffect2078ui_story and not isNil(var_385_9) then
					arg_382_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_382_1.time_ >= var_385_10 + var_385_11 and arg_382_1.time_ < var_385_10 + var_385_11 + arg_385_0 and not isNil(var_385_9) and arg_382_1.var_.characterEffect2078ui_story then
				arg_382_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_385_13 = 0

			if var_385_13 < arg_382_1.time_ and arg_382_1.time_ <= var_385_13 + arg_385_0 then
				arg_382_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_385_14 = 0

			if var_385_14 < arg_382_1.time_ and arg_382_1.time_ <= var_385_14 + arg_385_0 then
				arg_382_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_385_15 = arg_382_1.actors_["1015ui_story"].transform
			local var_385_16 = 0

			if var_385_16 < arg_382_1.time_ and arg_382_1.time_ <= var_385_16 + arg_385_0 then
				arg_382_1.var_.moveOldPos1015ui_story = var_385_15.localPosition
			end

			local var_385_17 = 0.001

			if var_385_16 <= arg_382_1.time_ and arg_382_1.time_ < var_385_16 + var_385_17 then
				local var_385_18 = (arg_382_1.time_ - var_385_16) / var_385_17
				local var_385_19 = Vector3.New(0.7, -1.15, -6.2)

				var_385_15.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1015ui_story, var_385_19, var_385_18)

				local var_385_20 = manager.ui.mainCamera.transform.position - var_385_15.position

				var_385_15.forward = Vector3.New(var_385_20.x, var_385_20.y, var_385_20.z)

				local var_385_21 = var_385_15.localEulerAngles

				var_385_21.z = 0
				var_385_21.x = 0
				var_385_15.localEulerAngles = var_385_21
			end

			if arg_382_1.time_ >= var_385_16 + var_385_17 and arg_382_1.time_ < var_385_16 + var_385_17 + arg_385_0 then
				var_385_15.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_385_22 = manager.ui.mainCamera.transform.position - var_385_15.position

				var_385_15.forward = Vector3.New(var_385_22.x, var_385_22.y, var_385_22.z)

				local var_385_23 = var_385_15.localEulerAngles

				var_385_23.z = 0
				var_385_23.x = 0
				var_385_15.localEulerAngles = var_385_23
			end

			local var_385_24 = arg_382_1.actors_["1015ui_story"]
			local var_385_25 = 0

			if var_385_25 < arg_382_1.time_ and arg_382_1.time_ <= var_385_25 + arg_385_0 and not isNil(var_385_24) and arg_382_1.var_.characterEffect1015ui_story == nil then
				arg_382_1.var_.characterEffect1015ui_story = var_385_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_26 = 0.200000002980232

			if var_385_25 <= arg_382_1.time_ and arg_382_1.time_ < var_385_25 + var_385_26 and not isNil(var_385_24) then
				local var_385_27 = (arg_382_1.time_ - var_385_25) / var_385_26

				if arg_382_1.var_.characterEffect1015ui_story and not isNil(var_385_24) then
					local var_385_28 = Mathf.Lerp(0, 0.5, var_385_27)

					arg_382_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1015ui_story.fillRatio = var_385_28
				end
			end

			if arg_382_1.time_ >= var_385_25 + var_385_26 and arg_382_1.time_ < var_385_25 + var_385_26 + arg_385_0 and not isNil(var_385_24) and arg_382_1.var_.characterEffect1015ui_story then
				local var_385_29 = 0.5

				arg_382_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1015ui_story.fillRatio = var_385_29
			end

			local var_385_30 = arg_382_1.actors_["2079ui_story"].transform
			local var_385_31 = 0

			if var_385_31 < arg_382_1.time_ and arg_382_1.time_ <= var_385_31 + arg_385_0 then
				arg_382_1.var_.moveOldPos2079ui_story = var_385_30.localPosition
			end

			local var_385_32 = 0.001

			if var_385_31 <= arg_382_1.time_ and arg_382_1.time_ < var_385_31 + var_385_32 then
				local var_385_33 = (arg_382_1.time_ - var_385_31) / var_385_32
				local var_385_34 = Vector3.New(0, 100, 0)

				var_385_30.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos2079ui_story, var_385_34, var_385_33)

				local var_385_35 = manager.ui.mainCamera.transform.position - var_385_30.position

				var_385_30.forward = Vector3.New(var_385_35.x, var_385_35.y, var_385_35.z)

				local var_385_36 = var_385_30.localEulerAngles

				var_385_36.z = 0
				var_385_36.x = 0
				var_385_30.localEulerAngles = var_385_36
			end

			if arg_382_1.time_ >= var_385_31 + var_385_32 and arg_382_1.time_ < var_385_31 + var_385_32 + arg_385_0 then
				var_385_30.localPosition = Vector3.New(0, 100, 0)

				local var_385_37 = manager.ui.mainCamera.transform.position - var_385_30.position

				var_385_30.forward = Vector3.New(var_385_37.x, var_385_37.y, var_385_37.z)

				local var_385_38 = var_385_30.localEulerAngles

				var_385_38.z = 0
				var_385_38.x = 0
				var_385_30.localEulerAngles = var_385_38
			end

			local var_385_39 = arg_382_1.actors_["2079ui_story"]
			local var_385_40 = 0

			if var_385_40 < arg_382_1.time_ and arg_382_1.time_ <= var_385_40 + arg_385_0 and not isNil(var_385_39) and arg_382_1.var_.characterEffect2079ui_story == nil then
				arg_382_1.var_.characterEffect2079ui_story = var_385_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_41 = 0.200000002980232

			if var_385_40 <= arg_382_1.time_ and arg_382_1.time_ < var_385_40 + var_385_41 and not isNil(var_385_39) then
				local var_385_42 = (arg_382_1.time_ - var_385_40) / var_385_41

				if arg_382_1.var_.characterEffect2079ui_story and not isNil(var_385_39) then
					local var_385_43 = Mathf.Lerp(0, 0.5, var_385_42)

					arg_382_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_382_1.var_.characterEffect2079ui_story.fillRatio = var_385_43
				end
			end

			if arg_382_1.time_ >= var_385_40 + var_385_41 and arg_382_1.time_ < var_385_40 + var_385_41 + arg_385_0 and not isNil(var_385_39) and arg_382_1.var_.characterEffect2079ui_story then
				local var_385_44 = 0.5

				arg_382_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_382_1.var_.characterEffect2079ui_story.fillRatio = var_385_44
			end

			local var_385_45 = 0
			local var_385_46 = 1.425

			if var_385_45 < arg_382_1.time_ and arg_382_1.time_ <= var_385_45 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_47 = arg_382_1:FormatText(StoryNameCfg[530].name)

				arg_382_1.leftNameTxt_.text = var_385_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_48 = arg_382_1:GetWordFromCfg(317012091)
				local var_385_49 = arg_382_1:FormatText(var_385_48.content)

				arg_382_1.text_.text = var_385_49

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_50 = 57
				local var_385_51 = utf8.len(var_385_49)
				local var_385_52 = var_385_50 <= 0 and var_385_46 or var_385_46 * (var_385_51 / var_385_50)

				if var_385_52 > 0 and var_385_46 < var_385_52 then
					arg_382_1.talkMaxDuration = var_385_52

					if var_385_52 + var_385_45 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_52 + var_385_45
					end
				end

				arg_382_1.text_.text = var_385_49
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012091", "story_v_out_317012.awb") ~= 0 then
					local var_385_53 = manager.audio:GetVoiceLength("story_v_out_317012", "317012091", "story_v_out_317012.awb") / 1000

					if var_385_53 + var_385_45 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_53 + var_385_45
					end

					if var_385_48.prefab_name ~= "" and arg_382_1.actors_[var_385_48.prefab_name] ~= nil then
						local var_385_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_48.prefab_name].transform, "story_v_out_317012", "317012091", "story_v_out_317012.awb")

						arg_382_1:RecordAudio("317012091", var_385_54)
						arg_382_1:RecordAudio("317012091", var_385_54)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_317012", "317012091", "story_v_out_317012.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_317012", "317012091", "story_v_out_317012.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_55 = math.max(var_385_46, arg_382_1.talkMaxDuration)

			if var_385_45 <= arg_382_1.time_ and arg_382_1.time_ < var_385_45 + var_385_55 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_45) / var_385_55

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_45 + var_385_55 and arg_382_1.time_ < var_385_45 + var_385_55 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play317012092 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 317012092
		arg_386_1.duration_ = 1.87

		local var_386_0 = {
			zh = 1.866,
			ja = 1.733
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play317012093(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["2078ui_story"].transform
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.var_.moveOldPos2078ui_story = var_389_0.localPosition
			end

			local var_389_2 = 0.001

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2
				local var_389_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_389_0.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos2078ui_story, var_389_4, var_389_3)

				local var_389_5 = manager.ui.mainCamera.transform.position - var_389_0.position

				var_389_0.forward = Vector3.New(var_389_5.x, var_389_5.y, var_389_5.z)

				local var_389_6 = var_389_0.localEulerAngles

				var_389_6.z = 0
				var_389_6.x = 0
				var_389_0.localEulerAngles = var_389_6
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 then
				var_389_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_389_7 = manager.ui.mainCamera.transform.position - var_389_0.position

				var_389_0.forward = Vector3.New(var_389_7.x, var_389_7.y, var_389_7.z)

				local var_389_8 = var_389_0.localEulerAngles

				var_389_8.z = 0
				var_389_8.x = 0
				var_389_0.localEulerAngles = var_389_8
			end

			local var_389_9 = arg_386_1.actors_["2078ui_story"]
			local var_389_10 = 0

			if var_389_10 < arg_386_1.time_ and arg_386_1.time_ <= var_389_10 + arg_389_0 and not isNil(var_389_9) and arg_386_1.var_.characterEffect2078ui_story == nil then
				arg_386_1.var_.characterEffect2078ui_story = var_389_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_11 = 0.200000002980232

			if var_389_10 <= arg_386_1.time_ and arg_386_1.time_ < var_389_10 + var_389_11 and not isNil(var_389_9) then
				local var_389_12 = (arg_386_1.time_ - var_389_10) / var_389_11

				if arg_386_1.var_.characterEffect2078ui_story and not isNil(var_389_9) then
					local var_389_13 = Mathf.Lerp(0, 0.5, var_389_12)

					arg_386_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_386_1.var_.characterEffect2078ui_story.fillRatio = var_389_13
				end
			end

			if arg_386_1.time_ >= var_389_10 + var_389_11 and arg_386_1.time_ < var_389_10 + var_389_11 + arg_389_0 and not isNil(var_389_9) and arg_386_1.var_.characterEffect2078ui_story then
				local var_389_14 = 0.5

				arg_386_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_386_1.var_.characterEffect2078ui_story.fillRatio = var_389_14
			end

			local var_389_15 = arg_386_1.actors_["1015ui_story"].transform
			local var_389_16 = 0

			if var_389_16 < arg_386_1.time_ and arg_386_1.time_ <= var_389_16 + arg_389_0 then
				arg_386_1.var_.moveOldPos1015ui_story = var_389_15.localPosition
			end

			local var_389_17 = 0.001

			if var_389_16 <= arg_386_1.time_ and arg_386_1.time_ < var_389_16 + var_389_17 then
				local var_389_18 = (arg_386_1.time_ - var_389_16) / var_389_17
				local var_389_19 = Vector3.New(0.7, -1.15, -6.2)

				var_389_15.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos1015ui_story, var_389_19, var_389_18)

				local var_389_20 = manager.ui.mainCamera.transform.position - var_389_15.position

				var_389_15.forward = Vector3.New(var_389_20.x, var_389_20.y, var_389_20.z)

				local var_389_21 = var_389_15.localEulerAngles

				var_389_21.z = 0
				var_389_21.x = 0
				var_389_15.localEulerAngles = var_389_21
			end

			if arg_386_1.time_ >= var_389_16 + var_389_17 and arg_386_1.time_ < var_389_16 + var_389_17 + arg_389_0 then
				var_389_15.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_389_22 = manager.ui.mainCamera.transform.position - var_389_15.position

				var_389_15.forward = Vector3.New(var_389_22.x, var_389_22.y, var_389_22.z)

				local var_389_23 = var_389_15.localEulerAngles

				var_389_23.z = 0
				var_389_23.x = 0
				var_389_15.localEulerAngles = var_389_23
			end

			local var_389_24 = arg_386_1.actors_["1015ui_story"]
			local var_389_25 = 0

			if var_389_25 < arg_386_1.time_ and arg_386_1.time_ <= var_389_25 + arg_389_0 and not isNil(var_389_24) and arg_386_1.var_.characterEffect1015ui_story == nil then
				arg_386_1.var_.characterEffect1015ui_story = var_389_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_26 = 0.200000002980232

			if var_389_25 <= arg_386_1.time_ and arg_386_1.time_ < var_389_25 + var_389_26 and not isNil(var_389_24) then
				local var_389_27 = (arg_386_1.time_ - var_389_25) / var_389_26

				if arg_386_1.var_.characterEffect1015ui_story and not isNil(var_389_24) then
					arg_386_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= var_389_25 + var_389_26 and arg_386_1.time_ < var_389_25 + var_389_26 + arg_389_0 and not isNil(var_389_24) and arg_386_1.var_.characterEffect1015ui_story then
				arg_386_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_389_28 = 0

			if var_389_28 < arg_386_1.time_ and arg_386_1.time_ <= var_389_28 + arg_389_0 then
				arg_386_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_389_29 = 0

			if var_389_29 < arg_386_1.time_ and arg_386_1.time_ <= var_389_29 + arg_389_0 then
				arg_386_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_389_30 = 0
			local var_389_31 = 0.25

			if var_389_30 < arg_386_1.time_ and arg_386_1.time_ <= var_389_30 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_32 = arg_386_1:FormatText(StoryNameCfg[479].name)

				arg_386_1.leftNameTxt_.text = var_389_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_33 = arg_386_1:GetWordFromCfg(317012092)
				local var_389_34 = arg_386_1:FormatText(var_389_33.content)

				arg_386_1.text_.text = var_389_34

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_35 = 10
				local var_389_36 = utf8.len(var_389_34)
				local var_389_37 = var_389_35 <= 0 and var_389_31 or var_389_31 * (var_389_36 / var_389_35)

				if var_389_37 > 0 and var_389_31 < var_389_37 then
					arg_386_1.talkMaxDuration = var_389_37

					if var_389_37 + var_389_30 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_37 + var_389_30
					end
				end

				arg_386_1.text_.text = var_389_34
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012092", "story_v_out_317012.awb") ~= 0 then
					local var_389_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012092", "story_v_out_317012.awb") / 1000

					if var_389_38 + var_389_30 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_38 + var_389_30
					end

					if var_389_33.prefab_name ~= "" and arg_386_1.actors_[var_389_33.prefab_name] ~= nil then
						local var_389_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_33.prefab_name].transform, "story_v_out_317012", "317012092", "story_v_out_317012.awb")

						arg_386_1:RecordAudio("317012092", var_389_39)
						arg_386_1:RecordAudio("317012092", var_389_39)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_317012", "317012092", "story_v_out_317012.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_317012", "317012092", "story_v_out_317012.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_40 = math.max(var_389_31, arg_386_1.talkMaxDuration)

			if var_389_30 <= arg_386_1.time_ and arg_386_1.time_ < var_389_30 + var_389_40 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_30) / var_389_40

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_30 + var_389_40 and arg_386_1.time_ < var_389_30 + var_389_40 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_386_1:InitPlayNodeList()
	end,
	Play317012093 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 317012093
		arg_390_1.duration_ = 2.9

		local var_390_0 = {
			zh = 1.866,
			ja = 2.9
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play317012094(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["2078ui_story"].transform
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.var_.moveOldPos2078ui_story = var_393_0.localPosition
			end

			local var_393_2 = 0.001

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2
				local var_393_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_393_0.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos2078ui_story, var_393_4, var_393_3)

				local var_393_5 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_5.x, var_393_5.y, var_393_5.z)

				local var_393_6 = var_393_0.localEulerAngles

				var_393_6.z = 0
				var_393_6.x = 0
				var_393_0.localEulerAngles = var_393_6
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 then
				var_393_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_393_7 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_7.x, var_393_7.y, var_393_7.z)

				local var_393_8 = var_393_0.localEulerAngles

				var_393_8.z = 0
				var_393_8.x = 0
				var_393_0.localEulerAngles = var_393_8
			end

			local var_393_9 = arg_390_1.actors_["2078ui_story"]
			local var_393_10 = 0

			if var_393_10 < arg_390_1.time_ and arg_390_1.time_ <= var_393_10 + arg_393_0 and not isNil(var_393_9) and arg_390_1.var_.characterEffect2078ui_story == nil then
				arg_390_1.var_.characterEffect2078ui_story = var_393_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_11 = 0.200000002980232

			if var_393_10 <= arg_390_1.time_ and arg_390_1.time_ < var_393_10 + var_393_11 and not isNil(var_393_9) then
				local var_393_12 = (arg_390_1.time_ - var_393_10) / var_393_11

				if arg_390_1.var_.characterEffect2078ui_story and not isNil(var_393_9) then
					arg_390_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= var_393_10 + var_393_11 and arg_390_1.time_ < var_393_10 + var_393_11 + arg_393_0 and not isNil(var_393_9) and arg_390_1.var_.characterEffect2078ui_story then
				arg_390_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_393_13 = 0

			if var_393_13 < arg_390_1.time_ and arg_390_1.time_ <= var_393_13 + arg_393_0 then
				arg_390_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_393_14 = 0

			if var_393_14 < arg_390_1.time_ and arg_390_1.time_ <= var_393_14 + arg_393_0 then
				arg_390_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_393_15 = arg_390_1.actors_["1015ui_story"].transform
			local var_393_16 = 0

			if var_393_16 < arg_390_1.time_ and arg_390_1.time_ <= var_393_16 + arg_393_0 then
				arg_390_1.var_.moveOldPos1015ui_story = var_393_15.localPosition
			end

			local var_393_17 = 0.001

			if var_393_16 <= arg_390_1.time_ and arg_390_1.time_ < var_393_16 + var_393_17 then
				local var_393_18 = (arg_390_1.time_ - var_393_16) / var_393_17
				local var_393_19 = Vector3.New(0.7, -1.15, -6.2)

				var_393_15.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1015ui_story, var_393_19, var_393_18)

				local var_393_20 = manager.ui.mainCamera.transform.position - var_393_15.position

				var_393_15.forward = Vector3.New(var_393_20.x, var_393_20.y, var_393_20.z)

				local var_393_21 = var_393_15.localEulerAngles

				var_393_21.z = 0
				var_393_21.x = 0
				var_393_15.localEulerAngles = var_393_21
			end

			if arg_390_1.time_ >= var_393_16 + var_393_17 and arg_390_1.time_ < var_393_16 + var_393_17 + arg_393_0 then
				var_393_15.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_393_22 = manager.ui.mainCamera.transform.position - var_393_15.position

				var_393_15.forward = Vector3.New(var_393_22.x, var_393_22.y, var_393_22.z)

				local var_393_23 = var_393_15.localEulerAngles

				var_393_23.z = 0
				var_393_23.x = 0
				var_393_15.localEulerAngles = var_393_23
			end

			local var_393_24 = arg_390_1.actors_["1015ui_story"]
			local var_393_25 = 0

			if var_393_25 < arg_390_1.time_ and arg_390_1.time_ <= var_393_25 + arg_393_0 and not isNil(var_393_24) and arg_390_1.var_.characterEffect1015ui_story == nil then
				arg_390_1.var_.characterEffect1015ui_story = var_393_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_26 = 0.200000002980232

			if var_393_25 <= arg_390_1.time_ and arg_390_1.time_ < var_393_25 + var_393_26 and not isNil(var_393_24) then
				local var_393_27 = (arg_390_1.time_ - var_393_25) / var_393_26

				if arg_390_1.var_.characterEffect1015ui_story and not isNil(var_393_24) then
					local var_393_28 = Mathf.Lerp(0, 0.5, var_393_27)

					arg_390_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_390_1.var_.characterEffect1015ui_story.fillRatio = var_393_28
				end
			end

			if arg_390_1.time_ >= var_393_25 + var_393_26 and arg_390_1.time_ < var_393_25 + var_393_26 + arg_393_0 and not isNil(var_393_24) and arg_390_1.var_.characterEffect1015ui_story then
				local var_393_29 = 0.5

				arg_390_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_390_1.var_.characterEffect1015ui_story.fillRatio = var_393_29
			end

			local var_393_30 = 0
			local var_393_31 = 0.25

			if var_393_30 < arg_390_1.time_ and arg_390_1.time_ <= var_393_30 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_32 = arg_390_1:FormatText(StoryNameCfg[528].name)

				arg_390_1.leftNameTxt_.text = var_393_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_33 = arg_390_1:GetWordFromCfg(317012093)
				local var_393_34 = arg_390_1:FormatText(var_393_33.content)

				arg_390_1.text_.text = var_393_34

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_35 = 10
				local var_393_36 = utf8.len(var_393_34)
				local var_393_37 = var_393_35 <= 0 and var_393_31 or var_393_31 * (var_393_36 / var_393_35)

				if var_393_37 > 0 and var_393_31 < var_393_37 then
					arg_390_1.talkMaxDuration = var_393_37

					if var_393_37 + var_393_30 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_37 + var_393_30
					end
				end

				arg_390_1.text_.text = var_393_34
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012093", "story_v_out_317012.awb") ~= 0 then
					local var_393_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012093", "story_v_out_317012.awb") / 1000

					if var_393_38 + var_393_30 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_38 + var_393_30
					end

					if var_393_33.prefab_name ~= "" and arg_390_1.actors_[var_393_33.prefab_name] ~= nil then
						local var_393_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_33.prefab_name].transform, "story_v_out_317012", "317012093", "story_v_out_317012.awb")

						arg_390_1:RecordAudio("317012093", var_393_39)
						arg_390_1:RecordAudio("317012093", var_393_39)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_317012", "317012093", "story_v_out_317012.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_317012", "317012093", "story_v_out_317012.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_40 = math.max(var_393_31, arg_390_1.talkMaxDuration)

			if var_393_30 <= arg_390_1.time_ and arg_390_1.time_ < var_393_30 + var_393_40 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_30) / var_393_40

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_30 + var_393_40 and arg_390_1.time_ < var_393_30 + var_393_40 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_390_1:InitPlayNodeList()
	end,
	Play317012094 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 317012094
		arg_394_1.duration_ = 16.37

		local var_394_0 = {
			zh = 16.366,
			ja = 9.7
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play317012095(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["2078ui_story"].transform
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 then
				arg_394_1.var_.moveOldPos2078ui_story = var_397_0.localPosition
			end

			local var_397_2 = 0.001

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2
				local var_397_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_397_0.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos2078ui_story, var_397_4, var_397_3)

				local var_397_5 = manager.ui.mainCamera.transform.position - var_397_0.position

				var_397_0.forward = Vector3.New(var_397_5.x, var_397_5.y, var_397_5.z)

				local var_397_6 = var_397_0.localEulerAngles

				var_397_6.z = 0
				var_397_6.x = 0
				var_397_0.localEulerAngles = var_397_6
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 then
				var_397_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_397_7 = manager.ui.mainCamera.transform.position - var_397_0.position

				var_397_0.forward = Vector3.New(var_397_7.x, var_397_7.y, var_397_7.z)

				local var_397_8 = var_397_0.localEulerAngles

				var_397_8.z = 0
				var_397_8.x = 0
				var_397_0.localEulerAngles = var_397_8
			end

			local var_397_9 = arg_394_1.actors_["2078ui_story"]
			local var_397_10 = 0

			if var_397_10 < arg_394_1.time_ and arg_394_1.time_ <= var_397_10 + arg_397_0 and not isNil(var_397_9) and arg_394_1.var_.characterEffect2078ui_story == nil then
				arg_394_1.var_.characterEffect2078ui_story = var_397_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_11 = 0.200000002980232

			if var_397_10 <= arg_394_1.time_ and arg_394_1.time_ < var_397_10 + var_397_11 and not isNil(var_397_9) then
				local var_397_12 = (arg_394_1.time_ - var_397_10) / var_397_11

				if arg_394_1.var_.characterEffect2078ui_story and not isNil(var_397_9) then
					local var_397_13 = Mathf.Lerp(0, 0.5, var_397_12)

					arg_394_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_394_1.var_.characterEffect2078ui_story.fillRatio = var_397_13
				end
			end

			if arg_394_1.time_ >= var_397_10 + var_397_11 and arg_394_1.time_ < var_397_10 + var_397_11 + arg_397_0 and not isNil(var_397_9) and arg_394_1.var_.characterEffect2078ui_story then
				local var_397_14 = 0.5

				arg_394_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_394_1.var_.characterEffect2078ui_story.fillRatio = var_397_14
			end

			local var_397_15 = arg_394_1.actors_["1015ui_story"].transform
			local var_397_16 = 0

			if var_397_16 < arg_394_1.time_ and arg_394_1.time_ <= var_397_16 + arg_397_0 then
				arg_394_1.var_.moveOldPos1015ui_story = var_397_15.localPosition
			end

			local var_397_17 = 0.001

			if var_397_16 <= arg_394_1.time_ and arg_394_1.time_ < var_397_16 + var_397_17 then
				local var_397_18 = (arg_394_1.time_ - var_397_16) / var_397_17
				local var_397_19 = Vector3.New(0.7, -1.15, -6.2)

				var_397_15.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos1015ui_story, var_397_19, var_397_18)

				local var_397_20 = manager.ui.mainCamera.transform.position - var_397_15.position

				var_397_15.forward = Vector3.New(var_397_20.x, var_397_20.y, var_397_20.z)

				local var_397_21 = var_397_15.localEulerAngles

				var_397_21.z = 0
				var_397_21.x = 0
				var_397_15.localEulerAngles = var_397_21
			end

			if arg_394_1.time_ >= var_397_16 + var_397_17 and arg_394_1.time_ < var_397_16 + var_397_17 + arg_397_0 then
				var_397_15.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_397_22 = manager.ui.mainCamera.transform.position - var_397_15.position

				var_397_15.forward = Vector3.New(var_397_22.x, var_397_22.y, var_397_22.z)

				local var_397_23 = var_397_15.localEulerAngles

				var_397_23.z = 0
				var_397_23.x = 0
				var_397_15.localEulerAngles = var_397_23
			end

			local var_397_24 = arg_394_1.actors_["1015ui_story"]
			local var_397_25 = 0

			if var_397_25 < arg_394_1.time_ and arg_394_1.time_ <= var_397_25 + arg_397_0 and not isNil(var_397_24) and arg_394_1.var_.characterEffect1015ui_story == nil then
				arg_394_1.var_.characterEffect1015ui_story = var_397_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_26 = 0.200000002980232

			if var_397_25 <= arg_394_1.time_ and arg_394_1.time_ < var_397_25 + var_397_26 and not isNil(var_397_24) then
				local var_397_27 = (arg_394_1.time_ - var_397_25) / var_397_26

				if arg_394_1.var_.characterEffect1015ui_story and not isNil(var_397_24) then
					arg_394_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_394_1.time_ >= var_397_25 + var_397_26 and arg_394_1.time_ < var_397_25 + var_397_26 + arg_397_0 and not isNil(var_397_24) and arg_394_1.var_.characterEffect1015ui_story then
				arg_394_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_397_28 = 0

			if var_397_28 < arg_394_1.time_ and arg_394_1.time_ <= var_397_28 + arg_397_0 then
				arg_394_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			local var_397_29 = 0

			if var_397_29 < arg_394_1.time_ and arg_394_1.time_ <= var_397_29 + arg_397_0 then
				arg_394_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_397_30 = 0
			local var_397_31 = 1.75

			if var_397_30 < arg_394_1.time_ and arg_394_1.time_ <= var_397_30 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_32 = arg_394_1:FormatText(StoryNameCfg[479].name)

				arg_394_1.leftNameTxt_.text = var_397_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_33 = arg_394_1:GetWordFromCfg(317012094)
				local var_397_34 = arg_394_1:FormatText(var_397_33.content)

				arg_394_1.text_.text = var_397_34

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_35 = 70
				local var_397_36 = utf8.len(var_397_34)
				local var_397_37 = var_397_35 <= 0 and var_397_31 or var_397_31 * (var_397_36 / var_397_35)

				if var_397_37 > 0 and var_397_31 < var_397_37 then
					arg_394_1.talkMaxDuration = var_397_37

					if var_397_37 + var_397_30 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_37 + var_397_30
					end
				end

				arg_394_1.text_.text = var_397_34
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012094", "story_v_out_317012.awb") ~= 0 then
					local var_397_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012094", "story_v_out_317012.awb") / 1000

					if var_397_38 + var_397_30 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_38 + var_397_30
					end

					if var_397_33.prefab_name ~= "" and arg_394_1.actors_[var_397_33.prefab_name] ~= nil then
						local var_397_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_33.prefab_name].transform, "story_v_out_317012", "317012094", "story_v_out_317012.awb")

						arg_394_1:RecordAudio("317012094", var_397_39)
						arg_394_1:RecordAudio("317012094", var_397_39)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_317012", "317012094", "story_v_out_317012.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_317012", "317012094", "story_v_out_317012.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_40 = math.max(var_397_31, arg_394_1.talkMaxDuration)

			if var_397_30 <= arg_394_1.time_ and arg_394_1.time_ < var_397_30 + var_397_40 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_30) / var_397_40

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_30 + var_397_40 and arg_394_1.time_ < var_397_30 + var_397_40 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_394_1:InitPlayNodeList()
	end,
	Play317012095 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 317012095
		arg_398_1.duration_ = 10.77

		local var_398_0 = {
			zh = 10.766,
			ja = 9.6
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play317012096(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 then
				arg_398_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_401_2 = 0
			local var_401_3 = 1.375

			if var_401_2 < arg_398_1.time_ and arg_398_1.time_ <= var_401_2 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_4 = arg_398_1:FormatText(StoryNameCfg[479].name)

				arg_398_1.leftNameTxt_.text = var_401_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_5 = arg_398_1:GetWordFromCfg(317012095)
				local var_401_6 = arg_398_1:FormatText(var_401_5.content)

				arg_398_1.text_.text = var_401_6

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_7 = 55
				local var_401_8 = utf8.len(var_401_6)
				local var_401_9 = var_401_7 <= 0 and var_401_3 or var_401_3 * (var_401_8 / var_401_7)

				if var_401_9 > 0 and var_401_3 < var_401_9 then
					arg_398_1.talkMaxDuration = var_401_9

					if var_401_9 + var_401_2 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_9 + var_401_2
					end
				end

				arg_398_1.text_.text = var_401_6
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012095", "story_v_out_317012.awb") ~= 0 then
					local var_401_10 = manager.audio:GetVoiceLength("story_v_out_317012", "317012095", "story_v_out_317012.awb") / 1000

					if var_401_10 + var_401_2 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_10 + var_401_2
					end

					if var_401_5.prefab_name ~= "" and arg_398_1.actors_[var_401_5.prefab_name] ~= nil then
						local var_401_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_5.prefab_name].transform, "story_v_out_317012", "317012095", "story_v_out_317012.awb")

						arg_398_1:RecordAudio("317012095", var_401_11)
						arg_398_1:RecordAudio("317012095", var_401_11)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_317012", "317012095", "story_v_out_317012.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_317012", "317012095", "story_v_out_317012.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_12 = math.max(var_401_3, arg_398_1.talkMaxDuration)

			if var_401_2 <= arg_398_1.time_ and arg_398_1.time_ < var_401_2 + var_401_12 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_2) / var_401_12

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_2 + var_401_12 and arg_398_1.time_ < var_401_2 + var_401_12 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play317012096 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 317012096
		arg_402_1.duration_ = 12.23

		local var_402_0 = {
			zh = 9.566,
			ja = 12.233
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play317012097(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0

			if var_405_0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 then
				arg_402_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_405_2 = 0
			local var_405_3 = 1.275

			if var_405_2 < arg_402_1.time_ and arg_402_1.time_ <= var_405_2 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_4 = arg_402_1:FormatText(StoryNameCfg[479].name)

				arg_402_1.leftNameTxt_.text = var_405_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_5 = arg_402_1:GetWordFromCfg(317012096)
				local var_405_6 = arg_402_1:FormatText(var_405_5.content)

				arg_402_1.text_.text = var_405_6

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_7 = 51
				local var_405_8 = utf8.len(var_405_6)
				local var_405_9 = var_405_7 <= 0 and var_405_3 or var_405_3 * (var_405_8 / var_405_7)

				if var_405_9 > 0 and var_405_3 < var_405_9 then
					arg_402_1.talkMaxDuration = var_405_9

					if var_405_9 + var_405_2 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_9 + var_405_2
					end
				end

				arg_402_1.text_.text = var_405_6
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012096", "story_v_out_317012.awb") ~= 0 then
					local var_405_10 = manager.audio:GetVoiceLength("story_v_out_317012", "317012096", "story_v_out_317012.awb") / 1000

					if var_405_10 + var_405_2 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_10 + var_405_2
					end

					if var_405_5.prefab_name ~= "" and arg_402_1.actors_[var_405_5.prefab_name] ~= nil then
						local var_405_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_5.prefab_name].transform, "story_v_out_317012", "317012096", "story_v_out_317012.awb")

						arg_402_1:RecordAudio("317012096", var_405_11)
						arg_402_1:RecordAudio("317012096", var_405_11)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_317012", "317012096", "story_v_out_317012.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_317012", "317012096", "story_v_out_317012.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_12 = math.max(var_405_3, arg_402_1.talkMaxDuration)

			if var_405_2 <= arg_402_1.time_ and arg_402_1.time_ < var_405_2 + var_405_12 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_2) / var_405_12

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_2 + var_405_12 and arg_402_1.time_ < var_405_2 + var_405_12 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play317012097 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 317012097
		arg_406_1.duration_ = 4.3

		local var_406_0 = {
			zh = 4.3,
			ja = 3
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play317012098(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["1015ui_story"].transform
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 then
				arg_406_1.var_.moveOldPos1015ui_story = var_409_0.localPosition
			end

			local var_409_2 = 0.001

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2
				local var_409_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_409_0.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1015ui_story, var_409_4, var_409_3)

				local var_409_5 = manager.ui.mainCamera.transform.position - var_409_0.position

				var_409_0.forward = Vector3.New(var_409_5.x, var_409_5.y, var_409_5.z)

				local var_409_6 = var_409_0.localEulerAngles

				var_409_6.z = 0
				var_409_6.x = 0
				var_409_0.localEulerAngles = var_409_6
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 then
				var_409_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_409_7 = manager.ui.mainCamera.transform.position - var_409_0.position

				var_409_0.forward = Vector3.New(var_409_7.x, var_409_7.y, var_409_7.z)

				local var_409_8 = var_409_0.localEulerAngles

				var_409_8.z = 0
				var_409_8.x = 0
				var_409_0.localEulerAngles = var_409_8
			end

			local var_409_9 = arg_406_1.actors_["1015ui_story"]
			local var_409_10 = 0

			if var_409_10 < arg_406_1.time_ and arg_406_1.time_ <= var_409_10 + arg_409_0 and not isNil(var_409_9) and arg_406_1.var_.characterEffect1015ui_story == nil then
				arg_406_1.var_.characterEffect1015ui_story = var_409_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_11 = 0.200000002980232

			if var_409_10 <= arg_406_1.time_ and arg_406_1.time_ < var_409_10 + var_409_11 and not isNil(var_409_9) then
				local var_409_12 = (arg_406_1.time_ - var_409_10) / var_409_11

				if arg_406_1.var_.characterEffect1015ui_story and not isNil(var_409_9) then
					local var_409_13 = Mathf.Lerp(0, 0.5, var_409_12)

					arg_406_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_406_1.var_.characterEffect1015ui_story.fillRatio = var_409_13
				end
			end

			if arg_406_1.time_ >= var_409_10 + var_409_11 and arg_406_1.time_ < var_409_10 + var_409_11 + arg_409_0 and not isNil(var_409_9) and arg_406_1.var_.characterEffect1015ui_story then
				local var_409_14 = 0.5

				arg_406_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_406_1.var_.characterEffect1015ui_story.fillRatio = var_409_14
			end

			local var_409_15 = arg_406_1.actors_["2079ui_story"].transform
			local var_409_16 = 0

			if var_409_16 < arg_406_1.time_ and arg_406_1.time_ <= var_409_16 + arg_409_0 then
				arg_406_1.var_.moveOldPos2079ui_story = var_409_15.localPosition
			end

			local var_409_17 = 0.001

			if var_409_16 <= arg_406_1.time_ and arg_406_1.time_ < var_409_16 + var_409_17 then
				local var_409_18 = (arg_406_1.time_ - var_409_16) / var_409_17
				local var_409_19 = Vector3.New(0.7, -1.28, -5.6)

				var_409_15.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos2079ui_story, var_409_19, var_409_18)

				local var_409_20 = manager.ui.mainCamera.transform.position - var_409_15.position

				var_409_15.forward = Vector3.New(var_409_20.x, var_409_20.y, var_409_20.z)

				local var_409_21 = var_409_15.localEulerAngles

				var_409_21.z = 0
				var_409_21.x = 0
				var_409_15.localEulerAngles = var_409_21
			end

			if arg_406_1.time_ >= var_409_16 + var_409_17 and arg_406_1.time_ < var_409_16 + var_409_17 + arg_409_0 then
				var_409_15.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_409_22 = manager.ui.mainCamera.transform.position - var_409_15.position

				var_409_15.forward = Vector3.New(var_409_22.x, var_409_22.y, var_409_22.z)

				local var_409_23 = var_409_15.localEulerAngles

				var_409_23.z = 0
				var_409_23.x = 0
				var_409_15.localEulerAngles = var_409_23
			end

			local var_409_24 = arg_406_1.actors_["2079ui_story"]
			local var_409_25 = 0

			if var_409_25 < arg_406_1.time_ and arg_406_1.time_ <= var_409_25 + arg_409_0 and not isNil(var_409_24) and arg_406_1.var_.characterEffect2079ui_story == nil then
				arg_406_1.var_.characterEffect2079ui_story = var_409_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_26 = 0.200000002980232

			if var_409_25 <= arg_406_1.time_ and arg_406_1.time_ < var_409_25 + var_409_26 and not isNil(var_409_24) then
				local var_409_27 = (arg_406_1.time_ - var_409_25) / var_409_26

				if arg_406_1.var_.characterEffect2079ui_story and not isNil(var_409_24) then
					arg_406_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= var_409_25 + var_409_26 and arg_406_1.time_ < var_409_25 + var_409_26 + arg_409_0 and not isNil(var_409_24) and arg_406_1.var_.characterEffect2079ui_story then
				arg_406_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_409_28 = 0

			if var_409_28 < arg_406_1.time_ and arg_406_1.time_ <= var_409_28 + arg_409_0 then
				arg_406_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_409_29 = 0

			if var_409_29 < arg_406_1.time_ and arg_406_1.time_ <= var_409_29 + arg_409_0 then
				arg_406_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_409_30 = arg_406_1.actors_["2078ui_story"].transform
			local var_409_31 = 0

			if var_409_31 < arg_406_1.time_ and arg_406_1.time_ <= var_409_31 + arg_409_0 then
				arg_406_1.var_.moveOldPos2078ui_story = var_409_30.localPosition
			end

			local var_409_32 = 0.001

			if var_409_31 <= arg_406_1.time_ and arg_406_1.time_ < var_409_31 + var_409_32 then
				local var_409_33 = (arg_406_1.time_ - var_409_31) / var_409_32
				local var_409_34 = Vector3.New(0, 100, 0)

				var_409_30.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos2078ui_story, var_409_34, var_409_33)

				local var_409_35 = manager.ui.mainCamera.transform.position - var_409_30.position

				var_409_30.forward = Vector3.New(var_409_35.x, var_409_35.y, var_409_35.z)

				local var_409_36 = var_409_30.localEulerAngles

				var_409_36.z = 0
				var_409_36.x = 0
				var_409_30.localEulerAngles = var_409_36
			end

			if arg_406_1.time_ >= var_409_31 + var_409_32 and arg_406_1.time_ < var_409_31 + var_409_32 + arg_409_0 then
				var_409_30.localPosition = Vector3.New(0, 100, 0)

				local var_409_37 = manager.ui.mainCamera.transform.position - var_409_30.position

				var_409_30.forward = Vector3.New(var_409_37.x, var_409_37.y, var_409_37.z)

				local var_409_38 = var_409_30.localEulerAngles

				var_409_38.z = 0
				var_409_38.x = 0
				var_409_30.localEulerAngles = var_409_38
			end

			local var_409_39 = arg_406_1.actors_["2078ui_story"]
			local var_409_40 = 0

			if var_409_40 < arg_406_1.time_ and arg_406_1.time_ <= var_409_40 + arg_409_0 and not isNil(var_409_39) and arg_406_1.var_.characterEffect2078ui_story == nil then
				arg_406_1.var_.characterEffect2078ui_story = var_409_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_41 = 0.200000002980232

			if var_409_40 <= arg_406_1.time_ and arg_406_1.time_ < var_409_40 + var_409_41 and not isNil(var_409_39) then
				local var_409_42 = (arg_406_1.time_ - var_409_40) / var_409_41

				if arg_406_1.var_.characterEffect2078ui_story and not isNil(var_409_39) then
					local var_409_43 = Mathf.Lerp(0, 0.5, var_409_42)

					arg_406_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_406_1.var_.characterEffect2078ui_story.fillRatio = var_409_43
				end
			end

			if arg_406_1.time_ >= var_409_40 + var_409_41 and arg_406_1.time_ < var_409_40 + var_409_41 + arg_409_0 and not isNil(var_409_39) and arg_406_1.var_.characterEffect2078ui_story then
				local var_409_44 = 0.5

				arg_406_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_406_1.var_.characterEffect2078ui_story.fillRatio = var_409_44
			end

			local var_409_45 = 0
			local var_409_46 = 0.275

			if var_409_45 < arg_406_1.time_ and arg_406_1.time_ <= var_409_45 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_47 = arg_406_1:FormatText(StoryNameCfg[529].name)

				arg_406_1.leftNameTxt_.text = var_409_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_48 = arg_406_1:GetWordFromCfg(317012097)
				local var_409_49 = arg_406_1:FormatText(var_409_48.content)

				arg_406_1.text_.text = var_409_49

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_50 = 11
				local var_409_51 = utf8.len(var_409_49)
				local var_409_52 = var_409_50 <= 0 and var_409_46 or var_409_46 * (var_409_51 / var_409_50)

				if var_409_52 > 0 and var_409_46 < var_409_52 then
					arg_406_1.talkMaxDuration = var_409_52

					if var_409_52 + var_409_45 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_52 + var_409_45
					end
				end

				arg_406_1.text_.text = var_409_49
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012097", "story_v_out_317012.awb") ~= 0 then
					local var_409_53 = manager.audio:GetVoiceLength("story_v_out_317012", "317012097", "story_v_out_317012.awb") / 1000

					if var_409_53 + var_409_45 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_53 + var_409_45
					end

					if var_409_48.prefab_name ~= "" and arg_406_1.actors_[var_409_48.prefab_name] ~= nil then
						local var_409_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_48.prefab_name].transform, "story_v_out_317012", "317012097", "story_v_out_317012.awb")

						arg_406_1:RecordAudio("317012097", var_409_54)
						arg_406_1:RecordAudio("317012097", var_409_54)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_317012", "317012097", "story_v_out_317012.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_317012", "317012097", "story_v_out_317012.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_55 = math.max(var_409_46, arg_406_1.talkMaxDuration)

			if var_409_45 <= arg_406_1.time_ and arg_406_1.time_ < var_409_45 + var_409_55 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_45) / var_409_55

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_45 + var_409_55 and arg_406_1.time_ < var_409_45 + var_409_55 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
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
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play317012098 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 317012098
		arg_410_1.duration_ = 4.93

		local var_410_0 = {
			zh = 4.166,
			ja = 4.933
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play317012099(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = arg_410_1.actors_["1015ui_story"].transform
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.var_.moveOldPos1015ui_story = var_413_0.localPosition
			end

			local var_413_2 = 0.001

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_2 then
				local var_413_3 = (arg_410_1.time_ - var_413_1) / var_413_2
				local var_413_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_413_0.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1015ui_story, var_413_4, var_413_3)

				local var_413_5 = manager.ui.mainCamera.transform.position - var_413_0.position

				var_413_0.forward = Vector3.New(var_413_5.x, var_413_5.y, var_413_5.z)

				local var_413_6 = var_413_0.localEulerAngles

				var_413_6.z = 0
				var_413_6.x = 0
				var_413_0.localEulerAngles = var_413_6
			end

			if arg_410_1.time_ >= var_413_1 + var_413_2 and arg_410_1.time_ < var_413_1 + var_413_2 + arg_413_0 then
				var_413_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_413_7 = manager.ui.mainCamera.transform.position - var_413_0.position

				var_413_0.forward = Vector3.New(var_413_7.x, var_413_7.y, var_413_7.z)

				local var_413_8 = var_413_0.localEulerAngles

				var_413_8.z = 0
				var_413_8.x = 0
				var_413_0.localEulerAngles = var_413_8
			end

			local var_413_9 = arg_410_1.actors_["1015ui_story"]
			local var_413_10 = 0

			if var_413_10 < arg_410_1.time_ and arg_410_1.time_ <= var_413_10 + arg_413_0 and not isNil(var_413_9) and arg_410_1.var_.characterEffect1015ui_story == nil then
				arg_410_1.var_.characterEffect1015ui_story = var_413_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_11 = 0.200000002980232

			if var_413_10 <= arg_410_1.time_ and arg_410_1.time_ < var_413_10 + var_413_11 and not isNil(var_413_9) then
				local var_413_12 = (arg_410_1.time_ - var_413_10) / var_413_11

				if arg_410_1.var_.characterEffect1015ui_story and not isNil(var_413_9) then
					arg_410_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_410_1.time_ >= var_413_10 + var_413_11 and arg_410_1.time_ < var_413_10 + var_413_11 + arg_413_0 and not isNil(var_413_9) and arg_410_1.var_.characterEffect1015ui_story then
				arg_410_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_413_13 = 0

			if var_413_13 < arg_410_1.time_ and arg_410_1.time_ <= var_413_13 + arg_413_0 then
				arg_410_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_413_14 = 0

			if var_413_14 < arg_410_1.time_ and arg_410_1.time_ <= var_413_14 + arg_413_0 then
				arg_410_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_413_15 = arg_410_1.actors_["2079ui_story"].transform
			local var_413_16 = 0

			if var_413_16 < arg_410_1.time_ and arg_410_1.time_ <= var_413_16 + arg_413_0 then
				arg_410_1.var_.moveOldPos2079ui_story = var_413_15.localPosition
			end

			local var_413_17 = 0.001

			if var_413_16 <= arg_410_1.time_ and arg_410_1.time_ < var_413_16 + var_413_17 then
				local var_413_18 = (arg_410_1.time_ - var_413_16) / var_413_17
				local var_413_19 = Vector3.New(0.7, -1.28, -5.6)

				var_413_15.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos2079ui_story, var_413_19, var_413_18)

				local var_413_20 = manager.ui.mainCamera.transform.position - var_413_15.position

				var_413_15.forward = Vector3.New(var_413_20.x, var_413_20.y, var_413_20.z)

				local var_413_21 = var_413_15.localEulerAngles

				var_413_21.z = 0
				var_413_21.x = 0
				var_413_15.localEulerAngles = var_413_21
			end

			if arg_410_1.time_ >= var_413_16 + var_413_17 and arg_410_1.time_ < var_413_16 + var_413_17 + arg_413_0 then
				var_413_15.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_413_22 = manager.ui.mainCamera.transform.position - var_413_15.position

				var_413_15.forward = Vector3.New(var_413_22.x, var_413_22.y, var_413_22.z)

				local var_413_23 = var_413_15.localEulerAngles

				var_413_23.z = 0
				var_413_23.x = 0
				var_413_15.localEulerAngles = var_413_23
			end

			local var_413_24 = arg_410_1.actors_["2079ui_story"]
			local var_413_25 = 0

			if var_413_25 < arg_410_1.time_ and arg_410_1.time_ <= var_413_25 + arg_413_0 and not isNil(var_413_24) and arg_410_1.var_.characterEffect2079ui_story == nil then
				arg_410_1.var_.characterEffect2079ui_story = var_413_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_26 = 0.200000002980232

			if var_413_25 <= arg_410_1.time_ and arg_410_1.time_ < var_413_25 + var_413_26 and not isNil(var_413_24) then
				local var_413_27 = (arg_410_1.time_ - var_413_25) / var_413_26

				if arg_410_1.var_.characterEffect2079ui_story and not isNil(var_413_24) then
					local var_413_28 = Mathf.Lerp(0, 0.5, var_413_27)

					arg_410_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_410_1.var_.characterEffect2079ui_story.fillRatio = var_413_28
				end
			end

			if arg_410_1.time_ >= var_413_25 + var_413_26 and arg_410_1.time_ < var_413_25 + var_413_26 + arg_413_0 and not isNil(var_413_24) and arg_410_1.var_.characterEffect2079ui_story then
				local var_413_29 = 0.5

				arg_410_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_410_1.var_.characterEffect2079ui_story.fillRatio = var_413_29
			end

			local var_413_30 = 0
			local var_413_31 = 0.525

			if var_413_30 < arg_410_1.time_ and arg_410_1.time_ <= var_413_30 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_32 = arg_410_1:FormatText(StoryNameCfg[479].name)

				arg_410_1.leftNameTxt_.text = var_413_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_33 = arg_410_1:GetWordFromCfg(317012098)
				local var_413_34 = arg_410_1:FormatText(var_413_33.content)

				arg_410_1.text_.text = var_413_34

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_35 = 21
				local var_413_36 = utf8.len(var_413_34)
				local var_413_37 = var_413_35 <= 0 and var_413_31 or var_413_31 * (var_413_36 / var_413_35)

				if var_413_37 > 0 and var_413_31 < var_413_37 then
					arg_410_1.talkMaxDuration = var_413_37

					if var_413_37 + var_413_30 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_37 + var_413_30
					end
				end

				arg_410_1.text_.text = var_413_34
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012098", "story_v_out_317012.awb") ~= 0 then
					local var_413_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012098", "story_v_out_317012.awb") / 1000

					if var_413_38 + var_413_30 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_38 + var_413_30
					end

					if var_413_33.prefab_name ~= "" and arg_410_1.actors_[var_413_33.prefab_name] ~= nil then
						local var_413_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_33.prefab_name].transform, "story_v_out_317012", "317012098", "story_v_out_317012.awb")

						arg_410_1:RecordAudio("317012098", var_413_39)
						arg_410_1:RecordAudio("317012098", var_413_39)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_317012", "317012098", "story_v_out_317012.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_317012", "317012098", "story_v_out_317012.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_40 = math.max(var_413_31, arg_410_1.talkMaxDuration)

			if var_413_30 <= arg_410_1.time_ and arg_410_1.time_ < var_413_30 + var_413_40 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_30) / var_413_40

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_30 + var_413_40 and arg_410_1.time_ < var_413_30 + var_413_40 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
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
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play317012099 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 317012099
		arg_414_1.duration_ = 1.8

		local var_414_0 = {
			zh = 1.533,
			ja = 1.8
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play317012100(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = arg_414_1.actors_["1015ui_story"].transform
			local var_417_1 = 0

			if var_417_1 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 then
				arg_414_1.var_.moveOldPos1015ui_story = var_417_0.localPosition
			end

			local var_417_2 = 0.001

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_2 then
				local var_417_3 = (arg_414_1.time_ - var_417_1) / var_417_2
				local var_417_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_417_0.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1015ui_story, var_417_4, var_417_3)

				local var_417_5 = manager.ui.mainCamera.transform.position - var_417_0.position

				var_417_0.forward = Vector3.New(var_417_5.x, var_417_5.y, var_417_5.z)

				local var_417_6 = var_417_0.localEulerAngles

				var_417_6.z = 0
				var_417_6.x = 0
				var_417_0.localEulerAngles = var_417_6
			end

			if arg_414_1.time_ >= var_417_1 + var_417_2 and arg_414_1.time_ < var_417_1 + var_417_2 + arg_417_0 then
				var_417_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_417_7 = manager.ui.mainCamera.transform.position - var_417_0.position

				var_417_0.forward = Vector3.New(var_417_7.x, var_417_7.y, var_417_7.z)

				local var_417_8 = var_417_0.localEulerAngles

				var_417_8.z = 0
				var_417_8.x = 0
				var_417_0.localEulerAngles = var_417_8
			end

			local var_417_9 = arg_414_1.actors_["1015ui_story"]
			local var_417_10 = 0

			if var_417_10 < arg_414_1.time_ and arg_414_1.time_ <= var_417_10 + arg_417_0 and not isNil(var_417_9) and arg_414_1.var_.characterEffect1015ui_story == nil then
				arg_414_1.var_.characterEffect1015ui_story = var_417_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_11 = 0.200000002980232

			if var_417_10 <= arg_414_1.time_ and arg_414_1.time_ < var_417_10 + var_417_11 and not isNil(var_417_9) then
				local var_417_12 = (arg_414_1.time_ - var_417_10) / var_417_11

				if arg_414_1.var_.characterEffect1015ui_story and not isNil(var_417_9) then
					local var_417_13 = Mathf.Lerp(0, 0.5, var_417_12)

					arg_414_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_414_1.var_.characterEffect1015ui_story.fillRatio = var_417_13
				end
			end

			if arg_414_1.time_ >= var_417_10 + var_417_11 and arg_414_1.time_ < var_417_10 + var_417_11 + arg_417_0 and not isNil(var_417_9) and arg_414_1.var_.characterEffect1015ui_story then
				local var_417_14 = 0.5

				arg_414_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_414_1.var_.characterEffect1015ui_story.fillRatio = var_417_14
			end

			local var_417_15 = arg_414_1.actors_["2079ui_story"].transform
			local var_417_16 = 0

			if var_417_16 < arg_414_1.time_ and arg_414_1.time_ <= var_417_16 + arg_417_0 then
				arg_414_1.var_.moveOldPos2079ui_story = var_417_15.localPosition
			end

			local var_417_17 = 0.001

			if var_417_16 <= arg_414_1.time_ and arg_414_1.time_ < var_417_16 + var_417_17 then
				local var_417_18 = (arg_414_1.time_ - var_417_16) / var_417_17
				local var_417_19 = Vector3.New(0.7, -1.28, -5.6)

				var_417_15.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos2079ui_story, var_417_19, var_417_18)

				local var_417_20 = manager.ui.mainCamera.transform.position - var_417_15.position

				var_417_15.forward = Vector3.New(var_417_20.x, var_417_20.y, var_417_20.z)

				local var_417_21 = var_417_15.localEulerAngles

				var_417_21.z = 0
				var_417_21.x = 0
				var_417_15.localEulerAngles = var_417_21
			end

			if arg_414_1.time_ >= var_417_16 + var_417_17 and arg_414_1.time_ < var_417_16 + var_417_17 + arg_417_0 then
				var_417_15.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_417_22 = manager.ui.mainCamera.transform.position - var_417_15.position

				var_417_15.forward = Vector3.New(var_417_22.x, var_417_22.y, var_417_22.z)

				local var_417_23 = var_417_15.localEulerAngles

				var_417_23.z = 0
				var_417_23.x = 0
				var_417_15.localEulerAngles = var_417_23
			end

			local var_417_24 = arg_414_1.actors_["2079ui_story"]
			local var_417_25 = 0

			if var_417_25 < arg_414_1.time_ and arg_414_1.time_ <= var_417_25 + arg_417_0 and not isNil(var_417_24) and arg_414_1.var_.characterEffect2079ui_story == nil then
				arg_414_1.var_.characterEffect2079ui_story = var_417_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_26 = 0.200000002980232

			if var_417_25 <= arg_414_1.time_ and arg_414_1.time_ < var_417_25 + var_417_26 and not isNil(var_417_24) then
				local var_417_27 = (arg_414_1.time_ - var_417_25) / var_417_26

				if arg_414_1.var_.characterEffect2079ui_story and not isNil(var_417_24) then
					arg_414_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_414_1.time_ >= var_417_25 + var_417_26 and arg_414_1.time_ < var_417_25 + var_417_26 + arg_417_0 and not isNil(var_417_24) and arg_414_1.var_.characterEffect2079ui_story then
				arg_414_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_417_28 = 0

			if var_417_28 < arg_414_1.time_ and arg_414_1.time_ <= var_417_28 + arg_417_0 then
				arg_414_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_417_29 = 0

			if var_417_29 < arg_414_1.time_ and arg_414_1.time_ <= var_417_29 + arg_417_0 then
				arg_414_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_417_30 = 0
			local var_417_31 = 0.075

			if var_417_30 < arg_414_1.time_ and arg_414_1.time_ <= var_417_30 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_32 = arg_414_1:FormatText(StoryNameCfg[529].name)

				arg_414_1.leftNameTxt_.text = var_417_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_33 = arg_414_1:GetWordFromCfg(317012099)
				local var_417_34 = arg_414_1:FormatText(var_417_33.content)

				arg_414_1.text_.text = var_417_34

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_35 = 3
				local var_417_36 = utf8.len(var_417_34)
				local var_417_37 = var_417_35 <= 0 and var_417_31 or var_417_31 * (var_417_36 / var_417_35)

				if var_417_37 > 0 and var_417_31 < var_417_37 then
					arg_414_1.talkMaxDuration = var_417_37

					if var_417_37 + var_417_30 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_37 + var_417_30
					end
				end

				arg_414_1.text_.text = var_417_34
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012099", "story_v_out_317012.awb") ~= 0 then
					local var_417_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012099", "story_v_out_317012.awb") / 1000

					if var_417_38 + var_417_30 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_38 + var_417_30
					end

					if var_417_33.prefab_name ~= "" and arg_414_1.actors_[var_417_33.prefab_name] ~= nil then
						local var_417_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_33.prefab_name].transform, "story_v_out_317012", "317012099", "story_v_out_317012.awb")

						arg_414_1:RecordAudio("317012099", var_417_39)
						arg_414_1:RecordAudio("317012099", var_417_39)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_317012", "317012099", "story_v_out_317012.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_317012", "317012099", "story_v_out_317012.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_40 = math.max(var_417_31, arg_414_1.talkMaxDuration)

			if var_417_30 <= arg_414_1.time_ and arg_414_1.time_ < var_417_30 + var_417_40 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_30) / var_417_40

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_30 + var_417_40 and arg_414_1.time_ < var_417_30 + var_417_40 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
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
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_414_1:InitPlayNodeList()
	end,
	Play317012100 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 317012100
		arg_418_1.duration_ = 5.43

		local var_418_0 = {
			zh = 5.433,
			ja = 4.366
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play317012101(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = arg_418_1.actors_["1015ui_story"].transform
			local var_421_1 = 0

			if var_421_1 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 then
				arg_418_1.var_.moveOldPos1015ui_story = var_421_0.localPosition
			end

			local var_421_2 = 0.001

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_2 then
				local var_421_3 = (arg_418_1.time_ - var_421_1) / var_421_2
				local var_421_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_421_0.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos1015ui_story, var_421_4, var_421_3)

				local var_421_5 = manager.ui.mainCamera.transform.position - var_421_0.position

				var_421_0.forward = Vector3.New(var_421_5.x, var_421_5.y, var_421_5.z)

				local var_421_6 = var_421_0.localEulerAngles

				var_421_6.z = 0
				var_421_6.x = 0
				var_421_0.localEulerAngles = var_421_6
			end

			if arg_418_1.time_ >= var_421_1 + var_421_2 and arg_418_1.time_ < var_421_1 + var_421_2 + arg_421_0 then
				var_421_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_421_7 = manager.ui.mainCamera.transform.position - var_421_0.position

				var_421_0.forward = Vector3.New(var_421_7.x, var_421_7.y, var_421_7.z)

				local var_421_8 = var_421_0.localEulerAngles

				var_421_8.z = 0
				var_421_8.x = 0
				var_421_0.localEulerAngles = var_421_8
			end

			local var_421_9 = arg_418_1.actors_["1015ui_story"]
			local var_421_10 = 0

			if var_421_10 < arg_418_1.time_ and arg_418_1.time_ <= var_421_10 + arg_421_0 and not isNil(var_421_9) and arg_418_1.var_.characterEffect1015ui_story == nil then
				arg_418_1.var_.characterEffect1015ui_story = var_421_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_11 = 0.200000002980232

			if var_421_10 <= arg_418_1.time_ and arg_418_1.time_ < var_421_10 + var_421_11 and not isNil(var_421_9) then
				local var_421_12 = (arg_418_1.time_ - var_421_10) / var_421_11

				if arg_418_1.var_.characterEffect1015ui_story and not isNil(var_421_9) then
					arg_418_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= var_421_10 + var_421_11 and arg_418_1.time_ < var_421_10 + var_421_11 + arg_421_0 and not isNil(var_421_9) and arg_418_1.var_.characterEffect1015ui_story then
				arg_418_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_421_13 = 0

			if var_421_13 < arg_418_1.time_ and arg_418_1.time_ <= var_421_13 + arg_421_0 then
				arg_418_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_421_14 = 0

			if var_421_14 < arg_418_1.time_ and arg_418_1.time_ <= var_421_14 + arg_421_0 then
				arg_418_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_421_15 = arg_418_1.actors_["2079ui_story"].transform
			local var_421_16 = 0

			if var_421_16 < arg_418_1.time_ and arg_418_1.time_ <= var_421_16 + arg_421_0 then
				arg_418_1.var_.moveOldPos2079ui_story = var_421_15.localPosition
			end

			local var_421_17 = 0.001

			if var_421_16 <= arg_418_1.time_ and arg_418_1.time_ < var_421_16 + var_421_17 then
				local var_421_18 = (arg_418_1.time_ - var_421_16) / var_421_17
				local var_421_19 = Vector3.New(0.7, -1.28, -5.6)

				var_421_15.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos2079ui_story, var_421_19, var_421_18)

				local var_421_20 = manager.ui.mainCamera.transform.position - var_421_15.position

				var_421_15.forward = Vector3.New(var_421_20.x, var_421_20.y, var_421_20.z)

				local var_421_21 = var_421_15.localEulerAngles

				var_421_21.z = 0
				var_421_21.x = 0
				var_421_15.localEulerAngles = var_421_21
			end

			if arg_418_1.time_ >= var_421_16 + var_421_17 and arg_418_1.time_ < var_421_16 + var_421_17 + arg_421_0 then
				var_421_15.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_421_22 = manager.ui.mainCamera.transform.position - var_421_15.position

				var_421_15.forward = Vector3.New(var_421_22.x, var_421_22.y, var_421_22.z)

				local var_421_23 = var_421_15.localEulerAngles

				var_421_23.z = 0
				var_421_23.x = 0
				var_421_15.localEulerAngles = var_421_23
			end

			local var_421_24 = arg_418_1.actors_["2079ui_story"]
			local var_421_25 = 0

			if var_421_25 < arg_418_1.time_ and arg_418_1.time_ <= var_421_25 + arg_421_0 and not isNil(var_421_24) and arg_418_1.var_.characterEffect2079ui_story == nil then
				arg_418_1.var_.characterEffect2079ui_story = var_421_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_26 = 0.200000002980232

			if var_421_25 <= arg_418_1.time_ and arg_418_1.time_ < var_421_25 + var_421_26 and not isNil(var_421_24) then
				local var_421_27 = (arg_418_1.time_ - var_421_25) / var_421_26

				if arg_418_1.var_.characterEffect2079ui_story and not isNil(var_421_24) then
					local var_421_28 = Mathf.Lerp(0, 0.5, var_421_27)

					arg_418_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_418_1.var_.characterEffect2079ui_story.fillRatio = var_421_28
				end
			end

			if arg_418_1.time_ >= var_421_25 + var_421_26 and arg_418_1.time_ < var_421_25 + var_421_26 + arg_421_0 and not isNil(var_421_24) and arg_418_1.var_.characterEffect2079ui_story then
				local var_421_29 = 0.5

				arg_418_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_418_1.var_.characterEffect2079ui_story.fillRatio = var_421_29
			end

			local var_421_30 = 0
			local var_421_31 = 0.75

			if var_421_30 < arg_418_1.time_ and arg_418_1.time_ <= var_421_30 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_32 = arg_418_1:FormatText(StoryNameCfg[479].name)

				arg_418_1.leftNameTxt_.text = var_421_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_33 = arg_418_1:GetWordFromCfg(317012100)
				local var_421_34 = arg_418_1:FormatText(var_421_33.content)

				arg_418_1.text_.text = var_421_34

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_35 = 30
				local var_421_36 = utf8.len(var_421_34)
				local var_421_37 = var_421_35 <= 0 and var_421_31 or var_421_31 * (var_421_36 / var_421_35)

				if var_421_37 > 0 and var_421_31 < var_421_37 then
					arg_418_1.talkMaxDuration = var_421_37

					if var_421_37 + var_421_30 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_37 + var_421_30
					end
				end

				arg_418_1.text_.text = var_421_34
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012100", "story_v_out_317012.awb") ~= 0 then
					local var_421_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012100", "story_v_out_317012.awb") / 1000

					if var_421_38 + var_421_30 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_38 + var_421_30
					end

					if var_421_33.prefab_name ~= "" and arg_418_1.actors_[var_421_33.prefab_name] ~= nil then
						local var_421_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_33.prefab_name].transform, "story_v_out_317012", "317012100", "story_v_out_317012.awb")

						arg_418_1:RecordAudio("317012100", var_421_39)
						arg_418_1:RecordAudio("317012100", var_421_39)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_317012", "317012100", "story_v_out_317012.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_317012", "317012100", "story_v_out_317012.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_40 = math.max(var_421_31, arg_418_1.talkMaxDuration)

			if var_421_30 <= arg_418_1.time_ and arg_418_1.time_ < var_421_30 + var_421_40 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_30) / var_421_40

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_30 + var_421_40 and arg_418_1.time_ < var_421_30 + var_421_40 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {
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
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_418_1:InitPlayNodeList()
	end,
	Play317012101 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 317012101
		arg_422_1.duration_ = 10.9

		local var_422_0 = {
			zh = 9.366,
			ja = 10.9
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play317012102(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0

			if var_425_0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_0 + arg_425_0 then
				arg_422_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_425_1 = 0
			local var_425_2 = 1.325

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_3 = arg_422_1:FormatText(StoryNameCfg[479].name)

				arg_422_1.leftNameTxt_.text = var_425_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_4 = arg_422_1:GetWordFromCfg(317012101)
				local var_425_5 = arg_422_1:FormatText(var_425_4.content)

				arg_422_1.text_.text = var_425_5

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_6 = 53
				local var_425_7 = utf8.len(var_425_5)
				local var_425_8 = var_425_6 <= 0 and var_425_2 or var_425_2 * (var_425_7 / var_425_6)

				if var_425_8 > 0 and var_425_2 < var_425_8 then
					arg_422_1.talkMaxDuration = var_425_8

					if var_425_8 + var_425_1 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_8 + var_425_1
					end
				end

				arg_422_1.text_.text = var_425_5
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012101", "story_v_out_317012.awb") ~= 0 then
					local var_425_9 = manager.audio:GetVoiceLength("story_v_out_317012", "317012101", "story_v_out_317012.awb") / 1000

					if var_425_9 + var_425_1 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_9 + var_425_1
					end

					if var_425_4.prefab_name ~= "" and arg_422_1.actors_[var_425_4.prefab_name] ~= nil then
						local var_425_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_4.prefab_name].transform, "story_v_out_317012", "317012101", "story_v_out_317012.awb")

						arg_422_1:RecordAudio("317012101", var_425_10)
						arg_422_1:RecordAudio("317012101", var_425_10)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_317012", "317012101", "story_v_out_317012.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_317012", "317012101", "story_v_out_317012.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_11 = math.max(var_425_2, arg_422_1.talkMaxDuration)

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_11 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_1) / var_425_11

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_1 + var_425_11 and arg_422_1.time_ < var_425_1 + var_425_11 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play317012102 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 317012102
		arg_426_1.duration_ = 5.4

		local var_426_0 = {
			zh = 3.633,
			ja = 5.4
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play317012103(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = arg_426_1.actors_["2078ui_story"].transform
			local var_429_1 = 0

			if var_429_1 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 then
				arg_426_1.var_.moveOldPos2078ui_story = var_429_0.localPosition
			end

			local var_429_2 = 0.001

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_2 then
				local var_429_3 = (arg_426_1.time_ - var_429_1) / var_429_2
				local var_429_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_429_0.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos2078ui_story, var_429_4, var_429_3)

				local var_429_5 = manager.ui.mainCamera.transform.position - var_429_0.position

				var_429_0.forward = Vector3.New(var_429_5.x, var_429_5.y, var_429_5.z)

				local var_429_6 = var_429_0.localEulerAngles

				var_429_6.z = 0
				var_429_6.x = 0
				var_429_0.localEulerAngles = var_429_6
			end

			if arg_426_1.time_ >= var_429_1 + var_429_2 and arg_426_1.time_ < var_429_1 + var_429_2 + arg_429_0 then
				var_429_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_429_7 = manager.ui.mainCamera.transform.position - var_429_0.position

				var_429_0.forward = Vector3.New(var_429_7.x, var_429_7.y, var_429_7.z)

				local var_429_8 = var_429_0.localEulerAngles

				var_429_8.z = 0
				var_429_8.x = 0
				var_429_0.localEulerAngles = var_429_8
			end

			local var_429_9 = arg_426_1.actors_["2078ui_story"]
			local var_429_10 = 0

			if var_429_10 < arg_426_1.time_ and arg_426_1.time_ <= var_429_10 + arg_429_0 and not isNil(var_429_9) and arg_426_1.var_.characterEffect2078ui_story == nil then
				arg_426_1.var_.characterEffect2078ui_story = var_429_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_11 = 0.200000002980232

			if var_429_10 <= arg_426_1.time_ and arg_426_1.time_ < var_429_10 + var_429_11 and not isNil(var_429_9) then
				local var_429_12 = (arg_426_1.time_ - var_429_10) / var_429_11

				if arg_426_1.var_.characterEffect2078ui_story and not isNil(var_429_9) then
					arg_426_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_426_1.time_ >= var_429_10 + var_429_11 and arg_426_1.time_ < var_429_10 + var_429_11 + arg_429_0 and not isNil(var_429_9) and arg_426_1.var_.characterEffect2078ui_story then
				arg_426_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_429_13 = 0

			if var_429_13 < arg_426_1.time_ and arg_426_1.time_ <= var_429_13 + arg_429_0 then
				arg_426_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_429_14 = 0

			if var_429_14 < arg_426_1.time_ and arg_426_1.time_ <= var_429_14 + arg_429_0 then
				arg_426_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_429_15 = arg_426_1.actors_["1015ui_story"].transform
			local var_429_16 = 0

			if var_429_16 < arg_426_1.time_ and arg_426_1.time_ <= var_429_16 + arg_429_0 then
				arg_426_1.var_.moveOldPos1015ui_story = var_429_15.localPosition
			end

			local var_429_17 = 0.001

			if var_429_16 <= arg_426_1.time_ and arg_426_1.time_ < var_429_16 + var_429_17 then
				local var_429_18 = (arg_426_1.time_ - var_429_16) / var_429_17
				local var_429_19 = Vector3.New(0.7, -1.15, -6.2)

				var_429_15.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos1015ui_story, var_429_19, var_429_18)

				local var_429_20 = manager.ui.mainCamera.transform.position - var_429_15.position

				var_429_15.forward = Vector3.New(var_429_20.x, var_429_20.y, var_429_20.z)

				local var_429_21 = var_429_15.localEulerAngles

				var_429_21.z = 0
				var_429_21.x = 0
				var_429_15.localEulerAngles = var_429_21
			end

			if arg_426_1.time_ >= var_429_16 + var_429_17 and arg_426_1.time_ < var_429_16 + var_429_17 + arg_429_0 then
				var_429_15.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_429_22 = manager.ui.mainCamera.transform.position - var_429_15.position

				var_429_15.forward = Vector3.New(var_429_22.x, var_429_22.y, var_429_22.z)

				local var_429_23 = var_429_15.localEulerAngles

				var_429_23.z = 0
				var_429_23.x = 0
				var_429_15.localEulerAngles = var_429_23
			end

			local var_429_24 = arg_426_1.actors_["1015ui_story"]
			local var_429_25 = 0

			if var_429_25 < arg_426_1.time_ and arg_426_1.time_ <= var_429_25 + arg_429_0 and not isNil(var_429_24) and arg_426_1.var_.characterEffect1015ui_story == nil then
				arg_426_1.var_.characterEffect1015ui_story = var_429_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_26 = 0.200000002980232

			if var_429_25 <= arg_426_1.time_ and arg_426_1.time_ < var_429_25 + var_429_26 and not isNil(var_429_24) then
				local var_429_27 = (arg_426_1.time_ - var_429_25) / var_429_26

				if arg_426_1.var_.characterEffect1015ui_story and not isNil(var_429_24) then
					local var_429_28 = Mathf.Lerp(0, 0.5, var_429_27)

					arg_426_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_426_1.var_.characterEffect1015ui_story.fillRatio = var_429_28
				end
			end

			if arg_426_1.time_ >= var_429_25 + var_429_26 and arg_426_1.time_ < var_429_25 + var_429_26 + arg_429_0 and not isNil(var_429_24) and arg_426_1.var_.characterEffect1015ui_story then
				local var_429_29 = 0.5

				arg_426_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_426_1.var_.characterEffect1015ui_story.fillRatio = var_429_29
			end

			local var_429_30 = arg_426_1.actors_["2079ui_story"].transform
			local var_429_31 = 0

			if var_429_31 < arg_426_1.time_ and arg_426_1.time_ <= var_429_31 + arg_429_0 then
				arg_426_1.var_.moveOldPos2079ui_story = var_429_30.localPosition
			end

			local var_429_32 = 0.001

			if var_429_31 <= arg_426_1.time_ and arg_426_1.time_ < var_429_31 + var_429_32 then
				local var_429_33 = (arg_426_1.time_ - var_429_31) / var_429_32
				local var_429_34 = Vector3.New(0, 100, 0)

				var_429_30.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos2079ui_story, var_429_34, var_429_33)

				local var_429_35 = manager.ui.mainCamera.transform.position - var_429_30.position

				var_429_30.forward = Vector3.New(var_429_35.x, var_429_35.y, var_429_35.z)

				local var_429_36 = var_429_30.localEulerAngles

				var_429_36.z = 0
				var_429_36.x = 0
				var_429_30.localEulerAngles = var_429_36
			end

			if arg_426_1.time_ >= var_429_31 + var_429_32 and arg_426_1.time_ < var_429_31 + var_429_32 + arg_429_0 then
				var_429_30.localPosition = Vector3.New(0, 100, 0)

				local var_429_37 = manager.ui.mainCamera.transform.position - var_429_30.position

				var_429_30.forward = Vector3.New(var_429_37.x, var_429_37.y, var_429_37.z)

				local var_429_38 = var_429_30.localEulerAngles

				var_429_38.z = 0
				var_429_38.x = 0
				var_429_30.localEulerAngles = var_429_38
			end

			local var_429_39 = arg_426_1.actors_["2079ui_story"]
			local var_429_40 = 0

			if var_429_40 < arg_426_1.time_ and arg_426_1.time_ <= var_429_40 + arg_429_0 and not isNil(var_429_39) and arg_426_1.var_.characterEffect2079ui_story == nil then
				arg_426_1.var_.characterEffect2079ui_story = var_429_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_41 = 0.200000002980232

			if var_429_40 <= arg_426_1.time_ and arg_426_1.time_ < var_429_40 + var_429_41 and not isNil(var_429_39) then
				local var_429_42 = (arg_426_1.time_ - var_429_40) / var_429_41

				if arg_426_1.var_.characterEffect2079ui_story and not isNil(var_429_39) then
					local var_429_43 = Mathf.Lerp(0, 0.5, var_429_42)

					arg_426_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_426_1.var_.characterEffect2079ui_story.fillRatio = var_429_43
				end
			end

			if arg_426_1.time_ >= var_429_40 + var_429_41 and arg_426_1.time_ < var_429_40 + var_429_41 + arg_429_0 and not isNil(var_429_39) and arg_426_1.var_.characterEffect2079ui_story then
				local var_429_44 = 0.5

				arg_426_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_426_1.var_.characterEffect2079ui_story.fillRatio = var_429_44
			end

			local var_429_45 = 0
			local var_429_46 = 0.375

			if var_429_45 < arg_426_1.time_ and arg_426_1.time_ <= var_429_45 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_47 = arg_426_1:FormatText(StoryNameCfg[528].name)

				arg_426_1.leftNameTxt_.text = var_429_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_48 = arg_426_1:GetWordFromCfg(317012102)
				local var_429_49 = arg_426_1:FormatText(var_429_48.content)

				arg_426_1.text_.text = var_429_49

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_50 = 15
				local var_429_51 = utf8.len(var_429_49)
				local var_429_52 = var_429_50 <= 0 and var_429_46 or var_429_46 * (var_429_51 / var_429_50)

				if var_429_52 > 0 and var_429_46 < var_429_52 then
					arg_426_1.talkMaxDuration = var_429_52

					if var_429_52 + var_429_45 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_52 + var_429_45
					end
				end

				arg_426_1.text_.text = var_429_49
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012102", "story_v_out_317012.awb") ~= 0 then
					local var_429_53 = manager.audio:GetVoiceLength("story_v_out_317012", "317012102", "story_v_out_317012.awb") / 1000

					if var_429_53 + var_429_45 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_53 + var_429_45
					end

					if var_429_48.prefab_name ~= "" and arg_426_1.actors_[var_429_48.prefab_name] ~= nil then
						local var_429_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_48.prefab_name].transform, "story_v_out_317012", "317012102", "story_v_out_317012.awb")

						arg_426_1:RecordAudio("317012102", var_429_54)
						arg_426_1:RecordAudio("317012102", var_429_54)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_317012", "317012102", "story_v_out_317012.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_317012", "317012102", "story_v_out_317012.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_55 = math.max(var_429_46, arg_426_1.talkMaxDuration)

			if var_429_45 <= arg_426_1.time_ and arg_426_1.time_ < var_429_45 + var_429_55 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_45) / var_429_55

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_45 + var_429_55 and arg_426_1.time_ < var_429_45 + var_429_55 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play317012103 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 317012103
		arg_430_1.duration_ = 11.43

		local var_430_0 = {
			zh = 11.433,
			ja = 8.333
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play317012104(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["2078ui_story"].transform
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 then
				arg_430_1.var_.moveOldPos2078ui_story = var_433_0.localPosition
			end

			local var_433_2 = 0.001

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2
				local var_433_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_433_0.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos2078ui_story, var_433_4, var_433_3)

				local var_433_5 = manager.ui.mainCamera.transform.position - var_433_0.position

				var_433_0.forward = Vector3.New(var_433_5.x, var_433_5.y, var_433_5.z)

				local var_433_6 = var_433_0.localEulerAngles

				var_433_6.z = 0
				var_433_6.x = 0
				var_433_0.localEulerAngles = var_433_6
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 then
				var_433_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_433_7 = manager.ui.mainCamera.transform.position - var_433_0.position

				var_433_0.forward = Vector3.New(var_433_7.x, var_433_7.y, var_433_7.z)

				local var_433_8 = var_433_0.localEulerAngles

				var_433_8.z = 0
				var_433_8.x = 0
				var_433_0.localEulerAngles = var_433_8
			end

			local var_433_9 = arg_430_1.actors_["2078ui_story"]
			local var_433_10 = 0

			if var_433_10 < arg_430_1.time_ and arg_430_1.time_ <= var_433_10 + arg_433_0 and not isNil(var_433_9) and arg_430_1.var_.characterEffect2078ui_story == nil then
				arg_430_1.var_.characterEffect2078ui_story = var_433_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_11 = 0.200000002980232

			if var_433_10 <= arg_430_1.time_ and arg_430_1.time_ < var_433_10 + var_433_11 and not isNil(var_433_9) then
				local var_433_12 = (arg_430_1.time_ - var_433_10) / var_433_11

				if arg_430_1.var_.characterEffect2078ui_story and not isNil(var_433_9) then
					local var_433_13 = Mathf.Lerp(0, 0.5, var_433_12)

					arg_430_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_430_1.var_.characterEffect2078ui_story.fillRatio = var_433_13
				end
			end

			if arg_430_1.time_ >= var_433_10 + var_433_11 and arg_430_1.time_ < var_433_10 + var_433_11 + arg_433_0 and not isNil(var_433_9) and arg_430_1.var_.characterEffect2078ui_story then
				local var_433_14 = 0.5

				arg_430_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_430_1.var_.characterEffect2078ui_story.fillRatio = var_433_14
			end

			local var_433_15 = arg_430_1.actors_["1015ui_story"].transform
			local var_433_16 = 0

			if var_433_16 < arg_430_1.time_ and arg_430_1.time_ <= var_433_16 + arg_433_0 then
				arg_430_1.var_.moveOldPos1015ui_story = var_433_15.localPosition
			end

			local var_433_17 = 0.001

			if var_433_16 <= arg_430_1.time_ and arg_430_1.time_ < var_433_16 + var_433_17 then
				local var_433_18 = (arg_430_1.time_ - var_433_16) / var_433_17
				local var_433_19 = Vector3.New(0.7, -1.15, -6.2)

				var_433_15.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1015ui_story, var_433_19, var_433_18)

				local var_433_20 = manager.ui.mainCamera.transform.position - var_433_15.position

				var_433_15.forward = Vector3.New(var_433_20.x, var_433_20.y, var_433_20.z)

				local var_433_21 = var_433_15.localEulerAngles

				var_433_21.z = 0
				var_433_21.x = 0
				var_433_15.localEulerAngles = var_433_21
			end

			if arg_430_1.time_ >= var_433_16 + var_433_17 and arg_430_1.time_ < var_433_16 + var_433_17 + arg_433_0 then
				var_433_15.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_433_22 = manager.ui.mainCamera.transform.position - var_433_15.position

				var_433_15.forward = Vector3.New(var_433_22.x, var_433_22.y, var_433_22.z)

				local var_433_23 = var_433_15.localEulerAngles

				var_433_23.z = 0
				var_433_23.x = 0
				var_433_15.localEulerAngles = var_433_23
			end

			local var_433_24 = arg_430_1.actors_["1015ui_story"]
			local var_433_25 = 0

			if var_433_25 < arg_430_1.time_ and arg_430_1.time_ <= var_433_25 + arg_433_0 and not isNil(var_433_24) and arg_430_1.var_.characterEffect1015ui_story == nil then
				arg_430_1.var_.characterEffect1015ui_story = var_433_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_26 = 0.200000002980232

			if var_433_25 <= arg_430_1.time_ and arg_430_1.time_ < var_433_25 + var_433_26 and not isNil(var_433_24) then
				local var_433_27 = (arg_430_1.time_ - var_433_25) / var_433_26

				if arg_430_1.var_.characterEffect1015ui_story and not isNil(var_433_24) then
					arg_430_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= var_433_25 + var_433_26 and arg_430_1.time_ < var_433_25 + var_433_26 + arg_433_0 and not isNil(var_433_24) and arg_430_1.var_.characterEffect1015ui_story then
				arg_430_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_433_28 = 0

			if var_433_28 < arg_430_1.time_ and arg_430_1.time_ <= var_433_28 + arg_433_0 then
				arg_430_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_433_29 = 0

			if var_433_29 < arg_430_1.time_ and arg_430_1.time_ <= var_433_29 + arg_433_0 then
				arg_430_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_433_30 = 0
			local var_433_31 = 1.275

			if var_433_30 < arg_430_1.time_ and arg_430_1.time_ <= var_433_30 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_32 = arg_430_1:FormatText(StoryNameCfg[479].name)

				arg_430_1.leftNameTxt_.text = var_433_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_33 = arg_430_1:GetWordFromCfg(317012103)
				local var_433_34 = arg_430_1:FormatText(var_433_33.content)

				arg_430_1.text_.text = var_433_34

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_35 = 51
				local var_433_36 = utf8.len(var_433_34)
				local var_433_37 = var_433_35 <= 0 and var_433_31 or var_433_31 * (var_433_36 / var_433_35)

				if var_433_37 > 0 and var_433_31 < var_433_37 then
					arg_430_1.talkMaxDuration = var_433_37

					if var_433_37 + var_433_30 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_37 + var_433_30
					end
				end

				arg_430_1.text_.text = var_433_34
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012103", "story_v_out_317012.awb") ~= 0 then
					local var_433_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012103", "story_v_out_317012.awb") / 1000

					if var_433_38 + var_433_30 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_38 + var_433_30
					end

					if var_433_33.prefab_name ~= "" and arg_430_1.actors_[var_433_33.prefab_name] ~= nil then
						local var_433_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_33.prefab_name].transform, "story_v_out_317012", "317012103", "story_v_out_317012.awb")

						arg_430_1:RecordAudio("317012103", var_433_39)
						arg_430_1:RecordAudio("317012103", var_433_39)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_317012", "317012103", "story_v_out_317012.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_317012", "317012103", "story_v_out_317012.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_40 = math.max(var_433_31, arg_430_1.talkMaxDuration)

			if var_433_30 <= arg_430_1.time_ and arg_430_1.time_ < var_433_30 + var_433_40 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_30) / var_433_40

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_30 + var_433_40 and arg_430_1.time_ < var_433_30 + var_433_40 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_430_1:InitPlayNodeList()
	end,
	Play317012104 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 317012104
		arg_434_1.duration_ = 5.1

		local var_434_0 = {
			zh = 5.1,
			ja = 4.666
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play317012105(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["2078ui_story"].transform
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 then
				arg_434_1.var_.moveOldPos2078ui_story = var_437_0.localPosition
			end

			local var_437_2 = 0.001

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2
				local var_437_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_437_0.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos2078ui_story, var_437_4, var_437_3)

				local var_437_5 = manager.ui.mainCamera.transform.position - var_437_0.position

				var_437_0.forward = Vector3.New(var_437_5.x, var_437_5.y, var_437_5.z)

				local var_437_6 = var_437_0.localEulerAngles

				var_437_6.z = 0
				var_437_6.x = 0
				var_437_0.localEulerAngles = var_437_6
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 then
				var_437_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_437_7 = manager.ui.mainCamera.transform.position - var_437_0.position

				var_437_0.forward = Vector3.New(var_437_7.x, var_437_7.y, var_437_7.z)

				local var_437_8 = var_437_0.localEulerAngles

				var_437_8.z = 0
				var_437_8.x = 0
				var_437_0.localEulerAngles = var_437_8
			end

			local var_437_9 = arg_434_1.actors_["2078ui_story"]
			local var_437_10 = 0

			if var_437_10 < arg_434_1.time_ and arg_434_1.time_ <= var_437_10 + arg_437_0 and not isNil(var_437_9) and arg_434_1.var_.characterEffect2078ui_story == nil then
				arg_434_1.var_.characterEffect2078ui_story = var_437_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_11 = 0.200000002980232

			if var_437_10 <= arg_434_1.time_ and arg_434_1.time_ < var_437_10 + var_437_11 and not isNil(var_437_9) then
				local var_437_12 = (arg_434_1.time_ - var_437_10) / var_437_11

				if arg_434_1.var_.characterEffect2078ui_story and not isNil(var_437_9) then
					arg_434_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= var_437_10 + var_437_11 and arg_434_1.time_ < var_437_10 + var_437_11 + arg_437_0 and not isNil(var_437_9) and arg_434_1.var_.characterEffect2078ui_story then
				arg_434_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_437_13 = 0

			if var_437_13 < arg_434_1.time_ and arg_434_1.time_ <= var_437_13 + arg_437_0 then
				arg_434_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_437_14 = 0

			if var_437_14 < arg_434_1.time_ and arg_434_1.time_ <= var_437_14 + arg_437_0 then
				arg_434_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_437_15 = arg_434_1.actors_["1015ui_story"].transform
			local var_437_16 = 0

			if var_437_16 < arg_434_1.time_ and arg_434_1.time_ <= var_437_16 + arg_437_0 then
				arg_434_1.var_.moveOldPos1015ui_story = var_437_15.localPosition
			end

			local var_437_17 = 0.001

			if var_437_16 <= arg_434_1.time_ and arg_434_1.time_ < var_437_16 + var_437_17 then
				local var_437_18 = (arg_434_1.time_ - var_437_16) / var_437_17
				local var_437_19 = Vector3.New(0.7, -1.15, -6.2)

				var_437_15.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1015ui_story, var_437_19, var_437_18)

				local var_437_20 = manager.ui.mainCamera.transform.position - var_437_15.position

				var_437_15.forward = Vector3.New(var_437_20.x, var_437_20.y, var_437_20.z)

				local var_437_21 = var_437_15.localEulerAngles

				var_437_21.z = 0
				var_437_21.x = 0
				var_437_15.localEulerAngles = var_437_21
			end

			if arg_434_1.time_ >= var_437_16 + var_437_17 and arg_434_1.time_ < var_437_16 + var_437_17 + arg_437_0 then
				var_437_15.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_437_22 = manager.ui.mainCamera.transform.position - var_437_15.position

				var_437_15.forward = Vector3.New(var_437_22.x, var_437_22.y, var_437_22.z)

				local var_437_23 = var_437_15.localEulerAngles

				var_437_23.z = 0
				var_437_23.x = 0
				var_437_15.localEulerAngles = var_437_23
			end

			local var_437_24 = arg_434_1.actors_["1015ui_story"]
			local var_437_25 = 0

			if var_437_25 < arg_434_1.time_ and arg_434_1.time_ <= var_437_25 + arg_437_0 and not isNil(var_437_24) and arg_434_1.var_.characterEffect1015ui_story == nil then
				arg_434_1.var_.characterEffect1015ui_story = var_437_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_26 = 0.200000002980232

			if var_437_25 <= arg_434_1.time_ and arg_434_1.time_ < var_437_25 + var_437_26 and not isNil(var_437_24) then
				local var_437_27 = (arg_434_1.time_ - var_437_25) / var_437_26

				if arg_434_1.var_.characterEffect1015ui_story and not isNil(var_437_24) then
					local var_437_28 = Mathf.Lerp(0, 0.5, var_437_27)

					arg_434_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_434_1.var_.characterEffect1015ui_story.fillRatio = var_437_28
				end
			end

			if arg_434_1.time_ >= var_437_25 + var_437_26 and arg_434_1.time_ < var_437_25 + var_437_26 + arg_437_0 and not isNil(var_437_24) and arg_434_1.var_.characterEffect1015ui_story then
				local var_437_29 = 0.5

				arg_434_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_434_1.var_.characterEffect1015ui_story.fillRatio = var_437_29
			end

			local var_437_30 = 0
			local var_437_31 = 0.55

			if var_437_30 < arg_434_1.time_ and arg_434_1.time_ <= var_437_30 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_32 = arg_434_1:FormatText(StoryNameCfg[530].name)

				arg_434_1.leftNameTxt_.text = var_437_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_33 = arg_434_1:GetWordFromCfg(317012104)
				local var_437_34 = arg_434_1:FormatText(var_437_33.content)

				arg_434_1.text_.text = var_437_34

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_35 = 22
				local var_437_36 = utf8.len(var_437_34)
				local var_437_37 = var_437_35 <= 0 and var_437_31 or var_437_31 * (var_437_36 / var_437_35)

				if var_437_37 > 0 and var_437_31 < var_437_37 then
					arg_434_1.talkMaxDuration = var_437_37

					if var_437_37 + var_437_30 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_37 + var_437_30
					end
				end

				arg_434_1.text_.text = var_437_34
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012104", "story_v_out_317012.awb") ~= 0 then
					local var_437_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012104", "story_v_out_317012.awb") / 1000

					if var_437_38 + var_437_30 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_38 + var_437_30
					end

					if var_437_33.prefab_name ~= "" and arg_434_1.actors_[var_437_33.prefab_name] ~= nil then
						local var_437_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_33.prefab_name].transform, "story_v_out_317012", "317012104", "story_v_out_317012.awb")

						arg_434_1:RecordAudio("317012104", var_437_39)
						arg_434_1:RecordAudio("317012104", var_437_39)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_317012", "317012104", "story_v_out_317012.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_317012", "317012104", "story_v_out_317012.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_40 = math.max(var_437_31, arg_434_1.talkMaxDuration)

			if var_437_30 <= arg_434_1.time_ and arg_434_1.time_ < var_437_30 + var_437_40 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_30) / var_437_40

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_30 + var_437_40 and arg_434_1.time_ < var_437_30 + var_437_40 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_434_1:InitPlayNodeList()
	end,
	Play317012105 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 317012105
		arg_438_1.duration_ = 11.3

		local var_438_0 = {
			zh = 11.3,
			ja = 11
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play317012106(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["2078ui_story"].transform
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 then
				arg_438_1.var_.moveOldPos2078ui_story = var_441_0.localPosition
			end

			local var_441_2 = 0.001

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / var_441_2
				local var_441_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_441_0.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos2078ui_story, var_441_4, var_441_3)

				local var_441_5 = manager.ui.mainCamera.transform.position - var_441_0.position

				var_441_0.forward = Vector3.New(var_441_5.x, var_441_5.y, var_441_5.z)

				local var_441_6 = var_441_0.localEulerAngles

				var_441_6.z = 0
				var_441_6.x = 0
				var_441_0.localEulerAngles = var_441_6
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 then
				var_441_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_441_7 = manager.ui.mainCamera.transform.position - var_441_0.position

				var_441_0.forward = Vector3.New(var_441_7.x, var_441_7.y, var_441_7.z)

				local var_441_8 = var_441_0.localEulerAngles

				var_441_8.z = 0
				var_441_8.x = 0
				var_441_0.localEulerAngles = var_441_8
			end

			local var_441_9 = arg_438_1.actors_["2078ui_story"]
			local var_441_10 = 0

			if var_441_10 < arg_438_1.time_ and arg_438_1.time_ <= var_441_10 + arg_441_0 and not isNil(var_441_9) and arg_438_1.var_.characterEffect2078ui_story == nil then
				arg_438_1.var_.characterEffect2078ui_story = var_441_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_11 = 0.200000002980232

			if var_441_10 <= arg_438_1.time_ and arg_438_1.time_ < var_441_10 + var_441_11 and not isNil(var_441_9) then
				local var_441_12 = (arg_438_1.time_ - var_441_10) / var_441_11

				if arg_438_1.var_.characterEffect2078ui_story and not isNil(var_441_9) then
					local var_441_13 = Mathf.Lerp(0, 0.5, var_441_12)

					arg_438_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_438_1.var_.characterEffect2078ui_story.fillRatio = var_441_13
				end
			end

			if arg_438_1.time_ >= var_441_10 + var_441_11 and arg_438_1.time_ < var_441_10 + var_441_11 + arg_441_0 and not isNil(var_441_9) and arg_438_1.var_.characterEffect2078ui_story then
				local var_441_14 = 0.5

				arg_438_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_438_1.var_.characterEffect2078ui_story.fillRatio = var_441_14
			end

			local var_441_15 = arg_438_1.actors_["1015ui_story"].transform
			local var_441_16 = 0

			if var_441_16 < arg_438_1.time_ and arg_438_1.time_ <= var_441_16 + arg_441_0 then
				arg_438_1.var_.moveOldPos1015ui_story = var_441_15.localPosition
			end

			local var_441_17 = 0.001

			if var_441_16 <= arg_438_1.time_ and arg_438_1.time_ < var_441_16 + var_441_17 then
				local var_441_18 = (arg_438_1.time_ - var_441_16) / var_441_17
				local var_441_19 = Vector3.New(0.7, -1.15, -6.2)

				var_441_15.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos1015ui_story, var_441_19, var_441_18)

				local var_441_20 = manager.ui.mainCamera.transform.position - var_441_15.position

				var_441_15.forward = Vector3.New(var_441_20.x, var_441_20.y, var_441_20.z)

				local var_441_21 = var_441_15.localEulerAngles

				var_441_21.z = 0
				var_441_21.x = 0
				var_441_15.localEulerAngles = var_441_21
			end

			if arg_438_1.time_ >= var_441_16 + var_441_17 and arg_438_1.time_ < var_441_16 + var_441_17 + arg_441_0 then
				var_441_15.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_441_22 = manager.ui.mainCamera.transform.position - var_441_15.position

				var_441_15.forward = Vector3.New(var_441_22.x, var_441_22.y, var_441_22.z)

				local var_441_23 = var_441_15.localEulerAngles

				var_441_23.z = 0
				var_441_23.x = 0
				var_441_15.localEulerAngles = var_441_23
			end

			local var_441_24 = arg_438_1.actors_["1015ui_story"]
			local var_441_25 = 0

			if var_441_25 < arg_438_1.time_ and arg_438_1.time_ <= var_441_25 + arg_441_0 and not isNil(var_441_24) and arg_438_1.var_.characterEffect1015ui_story == nil then
				arg_438_1.var_.characterEffect1015ui_story = var_441_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_26 = 0.200000002980232

			if var_441_25 <= arg_438_1.time_ and arg_438_1.time_ < var_441_25 + var_441_26 and not isNil(var_441_24) then
				local var_441_27 = (arg_438_1.time_ - var_441_25) / var_441_26

				if arg_438_1.var_.characterEffect1015ui_story and not isNil(var_441_24) then
					arg_438_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_438_1.time_ >= var_441_25 + var_441_26 and arg_438_1.time_ < var_441_25 + var_441_26 + arg_441_0 and not isNil(var_441_24) and arg_438_1.var_.characterEffect1015ui_story then
				arg_438_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_441_28 = 0

			if var_441_28 < arg_438_1.time_ and arg_438_1.time_ <= var_441_28 + arg_441_0 then
				arg_438_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_441_29 = 0

			if var_441_29 < arg_438_1.time_ and arg_438_1.time_ <= var_441_29 + arg_441_0 then
				arg_438_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_441_30 = 0
			local var_441_31 = 1.325

			if var_441_30 < arg_438_1.time_ and arg_438_1.time_ <= var_441_30 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_32 = arg_438_1:FormatText(StoryNameCfg[479].name)

				arg_438_1.leftNameTxt_.text = var_441_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_33 = arg_438_1:GetWordFromCfg(317012105)
				local var_441_34 = arg_438_1:FormatText(var_441_33.content)

				arg_438_1.text_.text = var_441_34

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_35 = 53
				local var_441_36 = utf8.len(var_441_34)
				local var_441_37 = var_441_35 <= 0 and var_441_31 or var_441_31 * (var_441_36 / var_441_35)

				if var_441_37 > 0 and var_441_31 < var_441_37 then
					arg_438_1.talkMaxDuration = var_441_37

					if var_441_37 + var_441_30 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_37 + var_441_30
					end
				end

				arg_438_1.text_.text = var_441_34
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012105", "story_v_out_317012.awb") ~= 0 then
					local var_441_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012105", "story_v_out_317012.awb") / 1000

					if var_441_38 + var_441_30 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_38 + var_441_30
					end

					if var_441_33.prefab_name ~= "" and arg_438_1.actors_[var_441_33.prefab_name] ~= nil then
						local var_441_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_33.prefab_name].transform, "story_v_out_317012", "317012105", "story_v_out_317012.awb")

						arg_438_1:RecordAudio("317012105", var_441_39)
						arg_438_1:RecordAudio("317012105", var_441_39)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_317012", "317012105", "story_v_out_317012.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_317012", "317012105", "story_v_out_317012.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_40 = math.max(var_441_31, arg_438_1.talkMaxDuration)

			if var_441_30 <= arg_438_1.time_ and arg_438_1.time_ < var_441_30 + var_441_40 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_30) / var_441_40

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_30 + var_441_40 and arg_438_1.time_ < var_441_30 + var_441_40 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_438_1:InitPlayNodeList()
	end,
	Play317012106 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 317012106
		arg_442_1.duration_ = 1.9

		local var_442_0 = {
			zh = 1.3,
			ja = 1.9
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play317012107(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = arg_442_1.actors_["2078ui_story"].transform
			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 then
				arg_442_1.var_.moveOldPos2078ui_story = var_445_0.localPosition
			end

			local var_445_2 = 0.001

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_2 then
				local var_445_3 = (arg_442_1.time_ - var_445_1) / var_445_2
				local var_445_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_445_0.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos2078ui_story, var_445_4, var_445_3)

				local var_445_5 = manager.ui.mainCamera.transform.position - var_445_0.position

				var_445_0.forward = Vector3.New(var_445_5.x, var_445_5.y, var_445_5.z)

				local var_445_6 = var_445_0.localEulerAngles

				var_445_6.z = 0
				var_445_6.x = 0
				var_445_0.localEulerAngles = var_445_6
			end

			if arg_442_1.time_ >= var_445_1 + var_445_2 and arg_442_1.time_ < var_445_1 + var_445_2 + arg_445_0 then
				var_445_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_445_7 = manager.ui.mainCamera.transform.position - var_445_0.position

				var_445_0.forward = Vector3.New(var_445_7.x, var_445_7.y, var_445_7.z)

				local var_445_8 = var_445_0.localEulerAngles

				var_445_8.z = 0
				var_445_8.x = 0
				var_445_0.localEulerAngles = var_445_8
			end

			local var_445_9 = arg_442_1.actors_["2078ui_story"]
			local var_445_10 = 0

			if var_445_10 < arg_442_1.time_ and arg_442_1.time_ <= var_445_10 + arg_445_0 and not isNil(var_445_9) and arg_442_1.var_.characterEffect2078ui_story == nil then
				arg_442_1.var_.characterEffect2078ui_story = var_445_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_11 = 0.200000002980232

			if var_445_10 <= arg_442_1.time_ and arg_442_1.time_ < var_445_10 + var_445_11 and not isNil(var_445_9) then
				local var_445_12 = (arg_442_1.time_ - var_445_10) / var_445_11

				if arg_442_1.var_.characterEffect2078ui_story and not isNil(var_445_9) then
					arg_442_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_442_1.time_ >= var_445_10 + var_445_11 and arg_442_1.time_ < var_445_10 + var_445_11 + arg_445_0 and not isNil(var_445_9) and arg_442_1.var_.characterEffect2078ui_story then
				arg_442_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_445_13 = 0

			if var_445_13 < arg_442_1.time_ and arg_442_1.time_ <= var_445_13 + arg_445_0 then
				arg_442_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_445_14 = 0

			if var_445_14 < arg_442_1.time_ and arg_442_1.time_ <= var_445_14 + arg_445_0 then
				arg_442_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_445_15 = arg_442_1.actors_["1015ui_story"].transform
			local var_445_16 = 0

			if var_445_16 < arg_442_1.time_ and arg_442_1.time_ <= var_445_16 + arg_445_0 then
				arg_442_1.var_.moveOldPos1015ui_story = var_445_15.localPosition
			end

			local var_445_17 = 0.001

			if var_445_16 <= arg_442_1.time_ and arg_442_1.time_ < var_445_16 + var_445_17 then
				local var_445_18 = (arg_442_1.time_ - var_445_16) / var_445_17
				local var_445_19 = Vector3.New(0.7, -1.15, -6.2)

				var_445_15.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos1015ui_story, var_445_19, var_445_18)

				local var_445_20 = manager.ui.mainCamera.transform.position - var_445_15.position

				var_445_15.forward = Vector3.New(var_445_20.x, var_445_20.y, var_445_20.z)

				local var_445_21 = var_445_15.localEulerAngles

				var_445_21.z = 0
				var_445_21.x = 0
				var_445_15.localEulerAngles = var_445_21
			end

			if arg_442_1.time_ >= var_445_16 + var_445_17 and arg_442_1.time_ < var_445_16 + var_445_17 + arg_445_0 then
				var_445_15.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_445_22 = manager.ui.mainCamera.transform.position - var_445_15.position

				var_445_15.forward = Vector3.New(var_445_22.x, var_445_22.y, var_445_22.z)

				local var_445_23 = var_445_15.localEulerAngles

				var_445_23.z = 0
				var_445_23.x = 0
				var_445_15.localEulerAngles = var_445_23
			end

			local var_445_24 = arg_442_1.actors_["1015ui_story"]
			local var_445_25 = 0

			if var_445_25 < arg_442_1.time_ and arg_442_1.time_ <= var_445_25 + arg_445_0 and not isNil(var_445_24) and arg_442_1.var_.characterEffect1015ui_story == nil then
				arg_442_1.var_.characterEffect1015ui_story = var_445_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_26 = 0.200000002980232

			if var_445_25 <= arg_442_1.time_ and arg_442_1.time_ < var_445_25 + var_445_26 and not isNil(var_445_24) then
				local var_445_27 = (arg_442_1.time_ - var_445_25) / var_445_26

				if arg_442_1.var_.characterEffect1015ui_story and not isNil(var_445_24) then
					local var_445_28 = Mathf.Lerp(0, 0.5, var_445_27)

					arg_442_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_442_1.var_.characterEffect1015ui_story.fillRatio = var_445_28
				end
			end

			if arg_442_1.time_ >= var_445_25 + var_445_26 and arg_442_1.time_ < var_445_25 + var_445_26 + arg_445_0 and not isNil(var_445_24) and arg_442_1.var_.characterEffect1015ui_story then
				local var_445_29 = 0.5

				arg_442_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_442_1.var_.characterEffect1015ui_story.fillRatio = var_445_29
			end

			local var_445_30 = 0
			local var_445_31 = 0.075

			if var_445_30 < arg_442_1.time_ and arg_442_1.time_ <= var_445_30 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_32 = arg_442_1:FormatText(StoryNameCfg[530].name)

				arg_442_1.leftNameTxt_.text = var_445_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_33 = arg_442_1:GetWordFromCfg(317012106)
				local var_445_34 = arg_442_1:FormatText(var_445_33.content)

				arg_442_1.text_.text = var_445_34

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_35 = 3
				local var_445_36 = utf8.len(var_445_34)
				local var_445_37 = var_445_35 <= 0 and var_445_31 or var_445_31 * (var_445_36 / var_445_35)

				if var_445_37 > 0 and var_445_31 < var_445_37 then
					arg_442_1.talkMaxDuration = var_445_37

					if var_445_37 + var_445_30 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_37 + var_445_30
					end
				end

				arg_442_1.text_.text = var_445_34
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012106", "story_v_out_317012.awb") ~= 0 then
					local var_445_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012106", "story_v_out_317012.awb") / 1000

					if var_445_38 + var_445_30 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_38 + var_445_30
					end

					if var_445_33.prefab_name ~= "" and arg_442_1.actors_[var_445_33.prefab_name] ~= nil then
						local var_445_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_33.prefab_name].transform, "story_v_out_317012", "317012106", "story_v_out_317012.awb")

						arg_442_1:RecordAudio("317012106", var_445_39)
						arg_442_1:RecordAudio("317012106", var_445_39)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_317012", "317012106", "story_v_out_317012.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_317012", "317012106", "story_v_out_317012.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_40 = math.max(var_445_31, arg_442_1.talkMaxDuration)

			if var_445_30 <= arg_442_1.time_ and arg_442_1.time_ < var_445_30 + var_445_40 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_30) / var_445_40

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_30 + var_445_40 and arg_442_1.time_ < var_445_30 + var_445_40 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_442_1:InitPlayNodeList()
	end,
	Play317012107 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 317012107
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play317012108(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = arg_446_1.actors_["2078ui_story"]
			local var_449_1 = 0

			if var_449_1 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.characterEffect2078ui_story == nil then
				arg_446_1.var_.characterEffect2078ui_story = var_449_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_2 = 0.200000002980232

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_2 and not isNil(var_449_0) then
				local var_449_3 = (arg_446_1.time_ - var_449_1) / var_449_2

				if arg_446_1.var_.characterEffect2078ui_story and not isNil(var_449_0) then
					local var_449_4 = Mathf.Lerp(0, 0.5, var_449_3)

					arg_446_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_446_1.var_.characterEffect2078ui_story.fillRatio = var_449_4
				end
			end

			if arg_446_1.time_ >= var_449_1 + var_449_2 and arg_446_1.time_ < var_449_1 + var_449_2 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.characterEffect2078ui_story then
				local var_449_5 = 0.5

				arg_446_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_446_1.var_.characterEffect2078ui_story.fillRatio = var_449_5
			end

			local var_449_6 = 0
			local var_449_7 = 0.9

			if var_449_6 < arg_446_1.time_ and arg_446_1.time_ <= var_449_6 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_8 = arg_446_1:GetWordFromCfg(317012107)
				local var_449_9 = arg_446_1:FormatText(var_449_8.content)

				arg_446_1.text_.text = var_449_9

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_10 = 36
				local var_449_11 = utf8.len(var_449_9)
				local var_449_12 = var_449_10 <= 0 and var_449_7 or var_449_7 * (var_449_11 / var_449_10)

				if var_449_12 > 0 and var_449_7 < var_449_12 then
					arg_446_1.talkMaxDuration = var_449_12

					if var_449_12 + var_449_6 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_12 + var_449_6
					end
				end

				arg_446_1.text_.text = var_449_9
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_13 = math.max(var_449_7, arg_446_1.talkMaxDuration)

			if var_449_6 <= arg_446_1.time_ and arg_446_1.time_ < var_449_6 + var_449_13 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_6) / var_449_13

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_6 + var_449_13 and arg_446_1.time_ < var_449_6 + var_449_13 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play317012108 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 317012108
		arg_450_1.duration_ = 8.83

		local var_450_0 = {
			zh = 7.533,
			ja = 8.833
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play317012109(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = arg_450_1.actors_["2078ui_story"].transform
			local var_453_1 = 0

			if var_453_1 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 then
				arg_450_1.var_.moveOldPos2078ui_story = var_453_0.localPosition
			end

			local var_453_2 = 0.001

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_2 then
				local var_453_3 = (arg_450_1.time_ - var_453_1) / var_453_2
				local var_453_4 = Vector3.New(0, 100, 0)

				var_453_0.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos2078ui_story, var_453_4, var_453_3)

				local var_453_5 = manager.ui.mainCamera.transform.position - var_453_0.position

				var_453_0.forward = Vector3.New(var_453_5.x, var_453_5.y, var_453_5.z)

				local var_453_6 = var_453_0.localEulerAngles

				var_453_6.z = 0
				var_453_6.x = 0
				var_453_0.localEulerAngles = var_453_6
			end

			if arg_450_1.time_ >= var_453_1 + var_453_2 and arg_450_1.time_ < var_453_1 + var_453_2 + arg_453_0 then
				var_453_0.localPosition = Vector3.New(0, 100, 0)

				local var_453_7 = manager.ui.mainCamera.transform.position - var_453_0.position

				var_453_0.forward = Vector3.New(var_453_7.x, var_453_7.y, var_453_7.z)

				local var_453_8 = var_453_0.localEulerAngles

				var_453_8.z = 0
				var_453_8.x = 0
				var_453_0.localEulerAngles = var_453_8
			end

			local var_453_9 = arg_450_1.actors_["2078ui_story"]
			local var_453_10 = 0

			if var_453_10 < arg_450_1.time_ and arg_450_1.time_ <= var_453_10 + arg_453_0 and not isNil(var_453_9) and arg_450_1.var_.characterEffect2078ui_story == nil then
				arg_450_1.var_.characterEffect2078ui_story = var_453_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_11 = 0.200000002980232

			if var_453_10 <= arg_450_1.time_ and arg_450_1.time_ < var_453_10 + var_453_11 and not isNil(var_453_9) then
				local var_453_12 = (arg_450_1.time_ - var_453_10) / var_453_11

				if arg_450_1.var_.characterEffect2078ui_story and not isNil(var_453_9) then
					local var_453_13 = Mathf.Lerp(0, 0.5, var_453_12)

					arg_450_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_450_1.var_.characterEffect2078ui_story.fillRatio = var_453_13
				end
			end

			if arg_450_1.time_ >= var_453_10 + var_453_11 and arg_450_1.time_ < var_453_10 + var_453_11 + arg_453_0 and not isNil(var_453_9) and arg_450_1.var_.characterEffect2078ui_story then
				local var_453_14 = 0.5

				arg_450_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_450_1.var_.characterEffect2078ui_story.fillRatio = var_453_14
			end

			local var_453_15 = arg_450_1.actors_["1015ui_story"].transform
			local var_453_16 = 0

			if var_453_16 < arg_450_1.time_ and arg_450_1.time_ <= var_453_16 + arg_453_0 then
				arg_450_1.var_.moveOldPos1015ui_story = var_453_15.localPosition
			end

			local var_453_17 = 0.001

			if var_453_16 <= arg_450_1.time_ and arg_450_1.time_ < var_453_16 + var_453_17 then
				local var_453_18 = (arg_450_1.time_ - var_453_16) / var_453_17
				local var_453_19 = Vector3.New(0, -1.15, -6.2)

				var_453_15.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos1015ui_story, var_453_19, var_453_18)

				local var_453_20 = manager.ui.mainCamera.transform.position - var_453_15.position

				var_453_15.forward = Vector3.New(var_453_20.x, var_453_20.y, var_453_20.z)

				local var_453_21 = var_453_15.localEulerAngles

				var_453_21.z = 0
				var_453_21.x = 0
				var_453_15.localEulerAngles = var_453_21
			end

			if arg_450_1.time_ >= var_453_16 + var_453_17 and arg_450_1.time_ < var_453_16 + var_453_17 + arg_453_0 then
				var_453_15.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_453_22 = manager.ui.mainCamera.transform.position - var_453_15.position

				var_453_15.forward = Vector3.New(var_453_22.x, var_453_22.y, var_453_22.z)

				local var_453_23 = var_453_15.localEulerAngles

				var_453_23.z = 0
				var_453_23.x = 0
				var_453_15.localEulerAngles = var_453_23
			end

			local var_453_24 = arg_450_1.actors_["1015ui_story"]
			local var_453_25 = 0

			if var_453_25 < arg_450_1.time_ and arg_450_1.time_ <= var_453_25 + arg_453_0 and not isNil(var_453_24) and arg_450_1.var_.characterEffect1015ui_story == nil then
				arg_450_1.var_.characterEffect1015ui_story = var_453_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_26 = 0.200000002980232

			if var_453_25 <= arg_450_1.time_ and arg_450_1.time_ < var_453_25 + var_453_26 and not isNil(var_453_24) then
				local var_453_27 = (arg_450_1.time_ - var_453_25) / var_453_26

				if arg_450_1.var_.characterEffect1015ui_story and not isNil(var_453_24) then
					arg_450_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_450_1.time_ >= var_453_25 + var_453_26 and arg_450_1.time_ < var_453_25 + var_453_26 + arg_453_0 and not isNil(var_453_24) and arg_450_1.var_.characterEffect1015ui_story then
				arg_450_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_453_28 = 0

			if var_453_28 < arg_450_1.time_ and arg_450_1.time_ <= var_453_28 + arg_453_0 then
				arg_450_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_453_29 = 0

			if var_453_29 < arg_450_1.time_ and arg_450_1.time_ <= var_453_29 + arg_453_0 then
				arg_450_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_453_30 = 0
			local var_453_31 = 0.975

			if var_453_30 < arg_450_1.time_ and arg_450_1.time_ <= var_453_30 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_32 = arg_450_1:FormatText(StoryNameCfg[479].name)

				arg_450_1.leftNameTxt_.text = var_453_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_33 = arg_450_1:GetWordFromCfg(317012108)
				local var_453_34 = arg_450_1:FormatText(var_453_33.content)

				arg_450_1.text_.text = var_453_34

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_35 = 39
				local var_453_36 = utf8.len(var_453_34)
				local var_453_37 = var_453_35 <= 0 and var_453_31 or var_453_31 * (var_453_36 / var_453_35)

				if var_453_37 > 0 and var_453_31 < var_453_37 then
					arg_450_1.talkMaxDuration = var_453_37

					if var_453_37 + var_453_30 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_37 + var_453_30
					end
				end

				arg_450_1.text_.text = var_453_34
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012108", "story_v_out_317012.awb") ~= 0 then
					local var_453_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012108", "story_v_out_317012.awb") / 1000

					if var_453_38 + var_453_30 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_38 + var_453_30
					end

					if var_453_33.prefab_name ~= "" and arg_450_1.actors_[var_453_33.prefab_name] ~= nil then
						local var_453_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_33.prefab_name].transform, "story_v_out_317012", "317012108", "story_v_out_317012.awb")

						arg_450_1:RecordAudio("317012108", var_453_39)
						arg_450_1:RecordAudio("317012108", var_453_39)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_317012", "317012108", "story_v_out_317012.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_317012", "317012108", "story_v_out_317012.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_40 = math.max(var_453_31, arg_450_1.talkMaxDuration)

			if var_453_30 <= arg_450_1.time_ and arg_450_1.time_ < var_453_30 + var_453_40 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_30) / var_453_40

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_30 + var_453_40 and arg_450_1.time_ < var_453_30 + var_453_40 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_450_1:InitPlayNodeList()
	end,
	Play317012109 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 317012109
		arg_454_1.duration_ = 1

		local var_454_0 = {
			zh = 1,
			ja = 0.999999999999
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play317012110(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = arg_454_1.actors_["1015ui_story"].transform
			local var_457_1 = 0

			if var_457_1 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 then
				arg_454_1.var_.moveOldPos1015ui_story = var_457_0.localPosition
			end

			local var_457_2 = 0.001

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_2 then
				local var_457_3 = (arg_454_1.time_ - var_457_1) / var_457_2
				local var_457_4 = Vector3.New(0, 100, 0)

				var_457_0.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos1015ui_story, var_457_4, var_457_3)

				local var_457_5 = manager.ui.mainCamera.transform.position - var_457_0.position

				var_457_0.forward = Vector3.New(var_457_5.x, var_457_5.y, var_457_5.z)

				local var_457_6 = var_457_0.localEulerAngles

				var_457_6.z = 0
				var_457_6.x = 0
				var_457_0.localEulerAngles = var_457_6
			end

			if arg_454_1.time_ >= var_457_1 + var_457_2 and arg_454_1.time_ < var_457_1 + var_457_2 + arg_457_0 then
				var_457_0.localPosition = Vector3.New(0, 100, 0)

				local var_457_7 = manager.ui.mainCamera.transform.position - var_457_0.position

				var_457_0.forward = Vector3.New(var_457_7.x, var_457_7.y, var_457_7.z)

				local var_457_8 = var_457_0.localEulerAngles

				var_457_8.z = 0
				var_457_8.x = 0
				var_457_0.localEulerAngles = var_457_8
			end

			local var_457_9 = arg_454_1.actors_["1015ui_story"]
			local var_457_10 = 0

			if var_457_10 < arg_454_1.time_ and arg_454_1.time_ <= var_457_10 + arg_457_0 and not isNil(var_457_9) and arg_454_1.var_.characterEffect1015ui_story == nil then
				arg_454_1.var_.characterEffect1015ui_story = var_457_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_11 = 0.200000002980232

			if var_457_10 <= arg_454_1.time_ and arg_454_1.time_ < var_457_10 + var_457_11 and not isNil(var_457_9) then
				local var_457_12 = (arg_454_1.time_ - var_457_10) / var_457_11

				if arg_454_1.var_.characterEffect1015ui_story and not isNil(var_457_9) then
					local var_457_13 = Mathf.Lerp(0, 0.5, var_457_12)

					arg_454_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_454_1.var_.characterEffect1015ui_story.fillRatio = var_457_13
				end
			end

			if arg_454_1.time_ >= var_457_10 + var_457_11 and arg_454_1.time_ < var_457_10 + var_457_11 + arg_457_0 and not isNil(var_457_9) and arg_454_1.var_.characterEffect1015ui_story then
				local var_457_14 = 0.5

				arg_454_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_454_1.var_.characterEffect1015ui_story.fillRatio = var_457_14
			end

			local var_457_15 = arg_454_1.actors_["2078ui_story"].transform
			local var_457_16 = 0

			if var_457_16 < arg_454_1.time_ and arg_454_1.time_ <= var_457_16 + arg_457_0 then
				arg_454_1.var_.moveOldPos2078ui_story = var_457_15.localPosition
			end

			local var_457_17 = 0.001

			if var_457_16 <= arg_454_1.time_ and arg_454_1.time_ < var_457_16 + var_457_17 then
				local var_457_18 = (arg_454_1.time_ - var_457_16) / var_457_17
				local var_457_19 = Vector3.New(0, -1.28, -5.6)

				var_457_15.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos2078ui_story, var_457_19, var_457_18)

				local var_457_20 = manager.ui.mainCamera.transform.position - var_457_15.position

				var_457_15.forward = Vector3.New(var_457_20.x, var_457_20.y, var_457_20.z)

				local var_457_21 = var_457_15.localEulerAngles

				var_457_21.z = 0
				var_457_21.x = 0
				var_457_15.localEulerAngles = var_457_21
			end

			if arg_454_1.time_ >= var_457_16 + var_457_17 and arg_454_1.time_ < var_457_16 + var_457_17 + arg_457_0 then
				var_457_15.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_457_22 = manager.ui.mainCamera.transform.position - var_457_15.position

				var_457_15.forward = Vector3.New(var_457_22.x, var_457_22.y, var_457_22.z)

				local var_457_23 = var_457_15.localEulerAngles

				var_457_23.z = 0
				var_457_23.x = 0
				var_457_15.localEulerAngles = var_457_23
			end

			local var_457_24 = arg_454_1.actors_["2078ui_story"]
			local var_457_25 = 0

			if var_457_25 < arg_454_1.time_ and arg_454_1.time_ <= var_457_25 + arg_457_0 and not isNil(var_457_24) and arg_454_1.var_.characterEffect2078ui_story == nil then
				arg_454_1.var_.characterEffect2078ui_story = var_457_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_26 = 0.200000002980232

			if var_457_25 <= arg_454_1.time_ and arg_454_1.time_ < var_457_25 + var_457_26 and not isNil(var_457_24) then
				local var_457_27 = (arg_454_1.time_ - var_457_25) / var_457_26

				if arg_454_1.var_.characterEffect2078ui_story and not isNil(var_457_24) then
					arg_454_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_454_1.time_ >= var_457_25 + var_457_26 and arg_454_1.time_ < var_457_25 + var_457_26 + arg_457_0 and not isNil(var_457_24) and arg_454_1.var_.characterEffect2078ui_story then
				arg_454_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_457_28 = 0

			if var_457_28 < arg_454_1.time_ and arg_454_1.time_ <= var_457_28 + arg_457_0 then
				arg_454_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_457_29 = 0

			if var_457_29 < arg_454_1.time_ and arg_454_1.time_ <= var_457_29 + arg_457_0 then
				arg_454_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_457_30 = 0
			local var_457_31 = 0.075

			if var_457_30 < arg_454_1.time_ and arg_454_1.time_ <= var_457_30 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_32 = arg_454_1:FormatText(StoryNameCfg[528].name)

				arg_454_1.leftNameTxt_.text = var_457_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_33 = arg_454_1:GetWordFromCfg(317012109)
				local var_457_34 = arg_454_1:FormatText(var_457_33.content)

				arg_454_1.text_.text = var_457_34

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_35 = 3
				local var_457_36 = utf8.len(var_457_34)
				local var_457_37 = var_457_35 <= 0 and var_457_31 or var_457_31 * (var_457_36 / var_457_35)

				if var_457_37 > 0 and var_457_31 < var_457_37 then
					arg_454_1.talkMaxDuration = var_457_37

					if var_457_37 + var_457_30 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_37 + var_457_30
					end
				end

				arg_454_1.text_.text = var_457_34
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012109", "story_v_out_317012.awb") ~= 0 then
					local var_457_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012109", "story_v_out_317012.awb") / 1000

					if var_457_38 + var_457_30 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_38 + var_457_30
					end

					if var_457_33.prefab_name ~= "" and arg_454_1.actors_[var_457_33.prefab_name] ~= nil then
						local var_457_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_33.prefab_name].transform, "story_v_out_317012", "317012109", "story_v_out_317012.awb")

						arg_454_1:RecordAudio("317012109", var_457_39)
						arg_454_1:RecordAudio("317012109", var_457_39)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_317012", "317012109", "story_v_out_317012.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_317012", "317012109", "story_v_out_317012.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_40 = math.max(var_457_31, arg_454_1.talkMaxDuration)

			if var_457_30 <= arg_454_1.time_ and arg_454_1.time_ < var_457_30 + var_457_40 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_30) / var_457_40

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_30 + var_457_40 and arg_454_1.time_ < var_457_30 + var_457_40 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {
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
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_454_1:InitPlayNodeList()
	end,
	Play317012110 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 317012110
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play317012111(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["2078ui_story"]
			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect2078ui_story == nil then
				arg_458_1.var_.characterEffect2078ui_story = var_461_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_2 = 0.200000002980232

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_2 and not isNil(var_461_0) then
				local var_461_3 = (arg_458_1.time_ - var_461_1) / var_461_2

				if arg_458_1.var_.characterEffect2078ui_story and not isNil(var_461_0) then
					local var_461_4 = Mathf.Lerp(0, 0.5, var_461_3)

					arg_458_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_458_1.var_.characterEffect2078ui_story.fillRatio = var_461_4
				end
			end

			if arg_458_1.time_ >= var_461_1 + var_461_2 and arg_458_1.time_ < var_461_1 + var_461_2 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect2078ui_story then
				local var_461_5 = 0.5

				arg_458_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_458_1.var_.characterEffect2078ui_story.fillRatio = var_461_5
			end

			local var_461_6 = 0
			local var_461_7 = 0.625

			if var_461_6 < arg_458_1.time_ and arg_458_1.time_ <= var_461_6 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_8 = arg_458_1:GetWordFromCfg(317012110)
				local var_461_9 = arg_458_1:FormatText(var_461_8.content)

				arg_458_1.text_.text = var_461_9

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_10 = 25
				local var_461_11 = utf8.len(var_461_9)
				local var_461_12 = var_461_10 <= 0 and var_461_7 or var_461_7 * (var_461_11 / var_461_10)

				if var_461_12 > 0 and var_461_7 < var_461_12 then
					arg_458_1.talkMaxDuration = var_461_12

					if var_461_12 + var_461_6 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_12 + var_461_6
					end
				end

				arg_458_1.text_.text = var_461_9
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_13 = math.max(var_461_7, arg_458_1.talkMaxDuration)

			if var_461_6 <= arg_458_1.time_ and arg_458_1.time_ < var_461_6 + var_461_13 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_6) / var_461_13

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_6 + var_461_13 and arg_458_1.time_ < var_461_6 + var_461_13 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play317012111 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 317012111
		arg_462_1.duration_ = 5.3

		local var_462_0 = {
			zh = 1.333,
			ja = 5.3
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play317012112(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["2078ui_story"].transform
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 then
				arg_462_1.var_.moveOldPos2078ui_story = var_465_0.localPosition
			end

			local var_465_2 = 0.001

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_2 then
				local var_465_3 = (arg_462_1.time_ - var_465_1) / var_465_2
				local var_465_4 = Vector3.New(0, 100, 0)

				var_465_0.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos2078ui_story, var_465_4, var_465_3)

				local var_465_5 = manager.ui.mainCamera.transform.position - var_465_0.position

				var_465_0.forward = Vector3.New(var_465_5.x, var_465_5.y, var_465_5.z)

				local var_465_6 = var_465_0.localEulerAngles

				var_465_6.z = 0
				var_465_6.x = 0
				var_465_0.localEulerAngles = var_465_6
			end

			if arg_462_1.time_ >= var_465_1 + var_465_2 and arg_462_1.time_ < var_465_1 + var_465_2 + arg_465_0 then
				var_465_0.localPosition = Vector3.New(0, 100, 0)

				local var_465_7 = manager.ui.mainCamera.transform.position - var_465_0.position

				var_465_0.forward = Vector3.New(var_465_7.x, var_465_7.y, var_465_7.z)

				local var_465_8 = var_465_0.localEulerAngles

				var_465_8.z = 0
				var_465_8.x = 0
				var_465_0.localEulerAngles = var_465_8
			end

			local var_465_9 = arg_462_1.actors_["2078ui_story"]
			local var_465_10 = 0

			if var_465_10 < arg_462_1.time_ and arg_462_1.time_ <= var_465_10 + arg_465_0 and not isNil(var_465_9) and arg_462_1.var_.characterEffect2078ui_story == nil then
				arg_462_1.var_.characterEffect2078ui_story = var_465_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_11 = 0.200000002980232

			if var_465_10 <= arg_462_1.time_ and arg_462_1.time_ < var_465_10 + var_465_11 and not isNil(var_465_9) then
				local var_465_12 = (arg_462_1.time_ - var_465_10) / var_465_11

				if arg_462_1.var_.characterEffect2078ui_story and not isNil(var_465_9) then
					local var_465_13 = Mathf.Lerp(0, 0.5, var_465_12)

					arg_462_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_462_1.var_.characterEffect2078ui_story.fillRatio = var_465_13
				end
			end

			if arg_462_1.time_ >= var_465_10 + var_465_11 and arg_462_1.time_ < var_465_10 + var_465_11 + arg_465_0 and not isNil(var_465_9) and arg_462_1.var_.characterEffect2078ui_story then
				local var_465_14 = 0.5

				arg_462_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_462_1.var_.characterEffect2078ui_story.fillRatio = var_465_14
			end

			local var_465_15 = arg_462_1.actors_["1015ui_story"].transform
			local var_465_16 = 0

			if var_465_16 < arg_462_1.time_ and arg_462_1.time_ <= var_465_16 + arg_465_0 then
				arg_462_1.var_.moveOldPos1015ui_story = var_465_15.localPosition
			end

			local var_465_17 = 0.001

			if var_465_16 <= arg_462_1.time_ and arg_462_1.time_ < var_465_16 + var_465_17 then
				local var_465_18 = (arg_462_1.time_ - var_465_16) / var_465_17
				local var_465_19 = Vector3.New(0, -1.15, -6.2)

				var_465_15.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos1015ui_story, var_465_19, var_465_18)

				local var_465_20 = manager.ui.mainCamera.transform.position - var_465_15.position

				var_465_15.forward = Vector3.New(var_465_20.x, var_465_20.y, var_465_20.z)

				local var_465_21 = var_465_15.localEulerAngles

				var_465_21.z = 0
				var_465_21.x = 0
				var_465_15.localEulerAngles = var_465_21
			end

			if arg_462_1.time_ >= var_465_16 + var_465_17 and arg_462_1.time_ < var_465_16 + var_465_17 + arg_465_0 then
				var_465_15.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_465_22 = manager.ui.mainCamera.transform.position - var_465_15.position

				var_465_15.forward = Vector3.New(var_465_22.x, var_465_22.y, var_465_22.z)

				local var_465_23 = var_465_15.localEulerAngles

				var_465_23.z = 0
				var_465_23.x = 0
				var_465_15.localEulerAngles = var_465_23
			end

			local var_465_24 = arg_462_1.actors_["1015ui_story"]
			local var_465_25 = 0

			if var_465_25 < arg_462_1.time_ and arg_462_1.time_ <= var_465_25 + arg_465_0 and not isNil(var_465_24) and arg_462_1.var_.characterEffect1015ui_story == nil then
				arg_462_1.var_.characterEffect1015ui_story = var_465_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_26 = 0.200000002980232

			if var_465_25 <= arg_462_1.time_ and arg_462_1.time_ < var_465_25 + var_465_26 and not isNil(var_465_24) then
				local var_465_27 = (arg_462_1.time_ - var_465_25) / var_465_26

				if arg_462_1.var_.characterEffect1015ui_story and not isNil(var_465_24) then
					arg_462_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= var_465_25 + var_465_26 and arg_462_1.time_ < var_465_25 + var_465_26 + arg_465_0 and not isNil(var_465_24) and arg_462_1.var_.characterEffect1015ui_story then
				arg_462_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_465_28 = 0

			if var_465_28 < arg_462_1.time_ and arg_462_1.time_ <= var_465_28 + arg_465_0 then
				arg_462_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_465_29 = 0

			if var_465_29 < arg_462_1.time_ and arg_462_1.time_ <= var_465_29 + arg_465_0 then
				arg_462_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_465_30 = 0
			local var_465_31 = 0.125

			if var_465_30 < arg_462_1.time_ and arg_462_1.time_ <= var_465_30 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_32 = arg_462_1:FormatText(StoryNameCfg[479].name)

				arg_462_1.leftNameTxt_.text = var_465_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_33 = arg_462_1:GetWordFromCfg(317012111)
				local var_465_34 = arg_462_1:FormatText(var_465_33.content)

				arg_462_1.text_.text = var_465_34

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_35 = 5
				local var_465_36 = utf8.len(var_465_34)
				local var_465_37 = var_465_35 <= 0 and var_465_31 or var_465_31 * (var_465_36 / var_465_35)

				if var_465_37 > 0 and var_465_31 < var_465_37 then
					arg_462_1.talkMaxDuration = var_465_37

					if var_465_37 + var_465_30 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_37 + var_465_30
					end
				end

				arg_462_1.text_.text = var_465_34
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012111", "story_v_out_317012.awb") ~= 0 then
					local var_465_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012111", "story_v_out_317012.awb") / 1000

					if var_465_38 + var_465_30 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_38 + var_465_30
					end

					if var_465_33.prefab_name ~= "" and arg_462_1.actors_[var_465_33.prefab_name] ~= nil then
						local var_465_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_33.prefab_name].transform, "story_v_out_317012", "317012111", "story_v_out_317012.awb")

						arg_462_1:RecordAudio("317012111", var_465_39)
						arg_462_1:RecordAudio("317012111", var_465_39)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_317012", "317012111", "story_v_out_317012.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_317012", "317012111", "story_v_out_317012.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_40 = math.max(var_465_31, arg_462_1.talkMaxDuration)

			if var_465_30 <= arg_462_1.time_ and arg_462_1.time_ < var_465_30 + var_465_40 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_30) / var_465_40

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_30 + var_465_40 and arg_462_1.time_ < var_465_30 + var_465_40 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_462_1:InitPlayNodeList()
	end,
	Play317012112 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 317012112
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play317012113(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["1015ui_story"]
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect1015ui_story == nil then
				arg_466_1.var_.characterEffect1015ui_story = var_469_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_2 = 0.200000002980232

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 and not isNil(var_469_0) then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2

				if arg_466_1.var_.characterEffect1015ui_story and not isNil(var_469_0) then
					local var_469_4 = Mathf.Lerp(0, 0.5, var_469_3)

					arg_466_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_466_1.var_.characterEffect1015ui_story.fillRatio = var_469_4
				end
			end

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect1015ui_story then
				local var_469_5 = 0.5

				arg_466_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_466_1.var_.characterEffect1015ui_story.fillRatio = var_469_5
			end

			local var_469_6 = 0
			local var_469_7 = 1.175

			if var_469_6 < arg_466_1.time_ and arg_466_1.time_ <= var_469_6 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, false)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_8 = arg_466_1:GetWordFromCfg(317012112)
				local var_469_9 = arg_466_1:FormatText(var_469_8.content)

				arg_466_1.text_.text = var_469_9

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_10 = 47
				local var_469_11 = utf8.len(var_469_9)
				local var_469_12 = var_469_10 <= 0 and var_469_7 or var_469_7 * (var_469_11 / var_469_10)

				if var_469_12 > 0 and var_469_7 < var_469_12 then
					arg_466_1.talkMaxDuration = var_469_12

					if var_469_12 + var_469_6 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_12 + var_469_6
					end
				end

				arg_466_1.text_.text = var_469_9
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_13 = math.max(var_469_7, arg_466_1.talkMaxDuration)

			if var_469_6 <= arg_466_1.time_ and arg_466_1.time_ < var_469_6 + var_469_13 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_6) / var_469_13

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_6 + var_469_13 and arg_466_1.time_ < var_469_6 + var_469_13 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play317012113 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 317012113
		arg_470_1.duration_ = 11.67

		local var_470_0 = {
			zh = 11.666,
			ja = 3.466
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play317012114(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["2078ui_story"].transform
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 then
				arg_470_1.var_.moveOldPos2078ui_story = var_473_0.localPosition
			end

			local var_473_2 = 0.001

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_2 then
				local var_473_3 = (arg_470_1.time_ - var_473_1) / var_473_2
				local var_473_4 = Vector3.New(0, -1.28, -5.6)

				var_473_0.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos2078ui_story, var_473_4, var_473_3)

				local var_473_5 = manager.ui.mainCamera.transform.position - var_473_0.position

				var_473_0.forward = Vector3.New(var_473_5.x, var_473_5.y, var_473_5.z)

				local var_473_6 = var_473_0.localEulerAngles

				var_473_6.z = 0
				var_473_6.x = 0
				var_473_0.localEulerAngles = var_473_6
			end

			if arg_470_1.time_ >= var_473_1 + var_473_2 and arg_470_1.time_ < var_473_1 + var_473_2 + arg_473_0 then
				var_473_0.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_473_7 = manager.ui.mainCamera.transform.position - var_473_0.position

				var_473_0.forward = Vector3.New(var_473_7.x, var_473_7.y, var_473_7.z)

				local var_473_8 = var_473_0.localEulerAngles

				var_473_8.z = 0
				var_473_8.x = 0
				var_473_0.localEulerAngles = var_473_8
			end

			local var_473_9 = arg_470_1.actors_["2078ui_story"]
			local var_473_10 = 0

			if var_473_10 < arg_470_1.time_ and arg_470_1.time_ <= var_473_10 + arg_473_0 and not isNil(var_473_9) and arg_470_1.var_.characterEffect2078ui_story == nil then
				arg_470_1.var_.characterEffect2078ui_story = var_473_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_11 = 0.200000002980232

			if var_473_10 <= arg_470_1.time_ and arg_470_1.time_ < var_473_10 + var_473_11 and not isNil(var_473_9) then
				local var_473_12 = (arg_470_1.time_ - var_473_10) / var_473_11

				if arg_470_1.var_.characterEffect2078ui_story and not isNil(var_473_9) then
					arg_470_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_470_1.time_ >= var_473_10 + var_473_11 and arg_470_1.time_ < var_473_10 + var_473_11 + arg_473_0 and not isNil(var_473_9) and arg_470_1.var_.characterEffect2078ui_story then
				arg_470_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_473_13 = 0

			if var_473_13 < arg_470_1.time_ and arg_470_1.time_ <= var_473_13 + arg_473_0 then
				arg_470_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_473_14 = 0

			if var_473_14 < arg_470_1.time_ and arg_470_1.time_ <= var_473_14 + arg_473_0 then
				arg_470_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_473_15 = arg_470_1.actors_["1015ui_story"].transform
			local var_473_16 = 0

			if var_473_16 < arg_470_1.time_ and arg_470_1.time_ <= var_473_16 + arg_473_0 then
				arg_470_1.var_.moveOldPos1015ui_story = var_473_15.localPosition
			end

			local var_473_17 = 0.001

			if var_473_16 <= arg_470_1.time_ and arg_470_1.time_ < var_473_16 + var_473_17 then
				local var_473_18 = (arg_470_1.time_ - var_473_16) / var_473_17
				local var_473_19 = Vector3.New(0, 100, 0)

				var_473_15.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1015ui_story, var_473_19, var_473_18)

				local var_473_20 = manager.ui.mainCamera.transform.position - var_473_15.position

				var_473_15.forward = Vector3.New(var_473_20.x, var_473_20.y, var_473_20.z)

				local var_473_21 = var_473_15.localEulerAngles

				var_473_21.z = 0
				var_473_21.x = 0
				var_473_15.localEulerAngles = var_473_21
			end

			if arg_470_1.time_ >= var_473_16 + var_473_17 and arg_470_1.time_ < var_473_16 + var_473_17 + arg_473_0 then
				var_473_15.localPosition = Vector3.New(0, 100, 0)

				local var_473_22 = manager.ui.mainCamera.transform.position - var_473_15.position

				var_473_15.forward = Vector3.New(var_473_22.x, var_473_22.y, var_473_22.z)

				local var_473_23 = var_473_15.localEulerAngles

				var_473_23.z = 0
				var_473_23.x = 0
				var_473_15.localEulerAngles = var_473_23
			end

			local var_473_24 = arg_470_1.actors_["1015ui_story"]
			local var_473_25 = 0

			if var_473_25 < arg_470_1.time_ and arg_470_1.time_ <= var_473_25 + arg_473_0 and not isNil(var_473_24) and arg_470_1.var_.characterEffect1015ui_story == nil then
				arg_470_1.var_.characterEffect1015ui_story = var_473_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_26 = 0.200000002980232

			if var_473_25 <= arg_470_1.time_ and arg_470_1.time_ < var_473_25 + var_473_26 and not isNil(var_473_24) then
				local var_473_27 = (arg_470_1.time_ - var_473_25) / var_473_26

				if arg_470_1.var_.characterEffect1015ui_story and not isNil(var_473_24) then
					local var_473_28 = Mathf.Lerp(0, 0.5, var_473_27)

					arg_470_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_470_1.var_.characterEffect1015ui_story.fillRatio = var_473_28
				end
			end

			if arg_470_1.time_ >= var_473_25 + var_473_26 and arg_470_1.time_ < var_473_25 + var_473_26 + arg_473_0 and not isNil(var_473_24) and arg_470_1.var_.characterEffect1015ui_story then
				local var_473_29 = 0.5

				arg_470_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_470_1.var_.characterEffect1015ui_story.fillRatio = var_473_29
			end

			local var_473_30 = 0
			local var_473_31 = 1.475

			if var_473_30 < arg_470_1.time_ and arg_470_1.time_ <= var_473_30 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_32 = arg_470_1:FormatText(StoryNameCfg[528].name)

				arg_470_1.leftNameTxt_.text = var_473_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_33 = arg_470_1:GetWordFromCfg(317012113)
				local var_473_34 = arg_470_1:FormatText(var_473_33.content)

				arg_470_1.text_.text = var_473_34

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_35 = 59
				local var_473_36 = utf8.len(var_473_34)
				local var_473_37 = var_473_35 <= 0 and var_473_31 or var_473_31 * (var_473_36 / var_473_35)

				if var_473_37 > 0 and var_473_31 < var_473_37 then
					arg_470_1.talkMaxDuration = var_473_37

					if var_473_37 + var_473_30 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_37 + var_473_30
					end
				end

				arg_470_1.text_.text = var_473_34
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012113", "story_v_out_317012.awb") ~= 0 then
					local var_473_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012113", "story_v_out_317012.awb") / 1000

					if var_473_38 + var_473_30 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_38 + var_473_30
					end

					if var_473_33.prefab_name ~= "" and arg_470_1.actors_[var_473_33.prefab_name] ~= nil then
						local var_473_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_33.prefab_name].transform, "story_v_out_317012", "317012113", "story_v_out_317012.awb")

						arg_470_1:RecordAudio("317012113", var_473_39)
						arg_470_1:RecordAudio("317012113", var_473_39)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_317012", "317012113", "story_v_out_317012.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_317012", "317012113", "story_v_out_317012.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_40 = math.max(var_473_31, arg_470_1.talkMaxDuration)

			if var_473_30 <= arg_470_1.time_ and arg_470_1.time_ < var_473_30 + var_473_40 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_30) / var_473_40

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_30 + var_473_40 and arg_470_1.time_ < var_473_30 + var_473_40 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_470_1:InitPlayNodeList()
	end,
	Play317012114 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 317012114
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play317012115(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["2078ui_story"]
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 and not isNil(var_477_0) and arg_474_1.var_.characterEffect2078ui_story == nil then
				arg_474_1.var_.characterEffect2078ui_story = var_477_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_2 = 0.200000002980232

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_2 and not isNil(var_477_0) then
				local var_477_3 = (arg_474_1.time_ - var_477_1) / var_477_2

				if arg_474_1.var_.characterEffect2078ui_story and not isNil(var_477_0) then
					local var_477_4 = Mathf.Lerp(0, 0.5, var_477_3)

					arg_474_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_474_1.var_.characterEffect2078ui_story.fillRatio = var_477_4
				end
			end

			if arg_474_1.time_ >= var_477_1 + var_477_2 and arg_474_1.time_ < var_477_1 + var_477_2 + arg_477_0 and not isNil(var_477_0) and arg_474_1.var_.characterEffect2078ui_story then
				local var_477_5 = 0.5

				arg_474_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_474_1.var_.characterEffect2078ui_story.fillRatio = var_477_5
			end

			local var_477_6 = 0
			local var_477_7 = 0.625

			if var_477_6 < arg_474_1.time_ and arg_474_1.time_ <= var_477_6 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, false)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_8 = arg_474_1:GetWordFromCfg(317012114)
				local var_477_9 = arg_474_1:FormatText(var_477_8.content)

				arg_474_1.text_.text = var_477_9

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_10 = 25
				local var_477_11 = utf8.len(var_477_9)
				local var_477_12 = var_477_10 <= 0 and var_477_7 or var_477_7 * (var_477_11 / var_477_10)

				if var_477_12 > 0 and var_477_7 < var_477_12 then
					arg_474_1.talkMaxDuration = var_477_12

					if var_477_12 + var_477_6 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_12 + var_477_6
					end
				end

				arg_474_1.text_.text = var_477_9
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_13 = math.max(var_477_7, arg_474_1.talkMaxDuration)

			if var_477_6 <= arg_474_1.time_ and arg_474_1.time_ < var_477_6 + var_477_13 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_6) / var_477_13

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_6 + var_477_13 and arg_474_1.time_ < var_477_6 + var_477_13 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play317012115 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 317012115
		arg_478_1.duration_ = 4.07

		local var_478_0 = {
			zh = 3.866,
			ja = 4.066
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play317012116(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = arg_478_1.actors_["2078ui_story"].transform
			local var_481_1 = 0

			if var_481_1 < arg_478_1.time_ and arg_478_1.time_ <= var_481_1 + arg_481_0 then
				arg_478_1.var_.moveOldPos2078ui_story = var_481_0.localPosition
			end

			local var_481_2 = 0.001

			if var_481_1 <= arg_478_1.time_ and arg_478_1.time_ < var_481_1 + var_481_2 then
				local var_481_3 = (arg_478_1.time_ - var_481_1) / var_481_2
				local var_481_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_481_0.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos2078ui_story, var_481_4, var_481_3)

				local var_481_5 = manager.ui.mainCamera.transform.position - var_481_0.position

				var_481_0.forward = Vector3.New(var_481_5.x, var_481_5.y, var_481_5.z)

				local var_481_6 = var_481_0.localEulerAngles

				var_481_6.z = 0
				var_481_6.x = 0
				var_481_0.localEulerAngles = var_481_6
			end

			if arg_478_1.time_ >= var_481_1 + var_481_2 and arg_478_1.time_ < var_481_1 + var_481_2 + arg_481_0 then
				var_481_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_481_7 = manager.ui.mainCamera.transform.position - var_481_0.position

				var_481_0.forward = Vector3.New(var_481_7.x, var_481_7.y, var_481_7.z)

				local var_481_8 = var_481_0.localEulerAngles

				var_481_8.z = 0
				var_481_8.x = 0
				var_481_0.localEulerAngles = var_481_8
			end

			local var_481_9 = arg_478_1.actors_["2078ui_story"]
			local var_481_10 = 0

			if var_481_10 < arg_478_1.time_ and arg_478_1.time_ <= var_481_10 + arg_481_0 and not isNil(var_481_9) and arg_478_1.var_.characterEffect2078ui_story == nil then
				arg_478_1.var_.characterEffect2078ui_story = var_481_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_11 = 0.200000002980232

			if var_481_10 <= arg_478_1.time_ and arg_478_1.time_ < var_481_10 + var_481_11 and not isNil(var_481_9) then
				local var_481_12 = (arg_478_1.time_ - var_481_10) / var_481_11

				if arg_478_1.var_.characterEffect2078ui_story and not isNil(var_481_9) then
					local var_481_13 = Mathf.Lerp(0, 0.5, var_481_12)

					arg_478_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_478_1.var_.characterEffect2078ui_story.fillRatio = var_481_13
				end
			end

			if arg_478_1.time_ >= var_481_10 + var_481_11 and arg_478_1.time_ < var_481_10 + var_481_11 + arg_481_0 and not isNil(var_481_9) and arg_478_1.var_.characterEffect2078ui_story then
				local var_481_14 = 0.5

				arg_478_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_478_1.var_.characterEffect2078ui_story.fillRatio = var_481_14
			end

			local var_481_15 = arg_478_1.actors_["2079ui_story"].transform
			local var_481_16 = 0

			if var_481_16 < arg_478_1.time_ and arg_478_1.time_ <= var_481_16 + arg_481_0 then
				arg_478_1.var_.moveOldPos2079ui_story = var_481_15.localPosition
			end

			local var_481_17 = 0.001

			if var_481_16 <= arg_478_1.time_ and arg_478_1.time_ < var_481_16 + var_481_17 then
				local var_481_18 = (arg_478_1.time_ - var_481_16) / var_481_17
				local var_481_19 = Vector3.New(0.7, -1.28, -5.6)

				var_481_15.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos2079ui_story, var_481_19, var_481_18)

				local var_481_20 = manager.ui.mainCamera.transform.position - var_481_15.position

				var_481_15.forward = Vector3.New(var_481_20.x, var_481_20.y, var_481_20.z)

				local var_481_21 = var_481_15.localEulerAngles

				var_481_21.z = 0
				var_481_21.x = 0
				var_481_15.localEulerAngles = var_481_21
			end

			if arg_478_1.time_ >= var_481_16 + var_481_17 and arg_478_1.time_ < var_481_16 + var_481_17 + arg_481_0 then
				var_481_15.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_481_22 = manager.ui.mainCamera.transform.position - var_481_15.position

				var_481_15.forward = Vector3.New(var_481_22.x, var_481_22.y, var_481_22.z)

				local var_481_23 = var_481_15.localEulerAngles

				var_481_23.z = 0
				var_481_23.x = 0
				var_481_15.localEulerAngles = var_481_23
			end

			local var_481_24 = arg_478_1.actors_["2079ui_story"]
			local var_481_25 = 0

			if var_481_25 < arg_478_1.time_ and arg_478_1.time_ <= var_481_25 + arg_481_0 and not isNil(var_481_24) and arg_478_1.var_.characterEffect2079ui_story == nil then
				arg_478_1.var_.characterEffect2079ui_story = var_481_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_26 = 0.200000002980232

			if var_481_25 <= arg_478_1.time_ and arg_478_1.time_ < var_481_25 + var_481_26 and not isNil(var_481_24) then
				local var_481_27 = (arg_478_1.time_ - var_481_25) / var_481_26

				if arg_478_1.var_.characterEffect2079ui_story and not isNil(var_481_24) then
					arg_478_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_478_1.time_ >= var_481_25 + var_481_26 and arg_478_1.time_ < var_481_25 + var_481_26 + arg_481_0 and not isNil(var_481_24) and arg_478_1.var_.characterEffect2079ui_story then
				arg_478_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_481_28 = 0

			if var_481_28 < arg_478_1.time_ and arg_478_1.time_ <= var_481_28 + arg_481_0 then
				arg_478_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_481_29 = 0

			if var_481_29 < arg_478_1.time_ and arg_478_1.time_ <= var_481_29 + arg_481_0 then
				arg_478_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_481_30 = 0
			local var_481_31 = 0.375

			if var_481_30 < arg_478_1.time_ and arg_478_1.time_ <= var_481_30 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_32 = arg_478_1:FormatText(StoryNameCfg[529].name)

				arg_478_1.leftNameTxt_.text = var_481_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_33 = arg_478_1:GetWordFromCfg(317012115)
				local var_481_34 = arg_478_1:FormatText(var_481_33.content)

				arg_478_1.text_.text = var_481_34

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_35 = 15
				local var_481_36 = utf8.len(var_481_34)
				local var_481_37 = var_481_35 <= 0 and var_481_31 or var_481_31 * (var_481_36 / var_481_35)

				if var_481_37 > 0 and var_481_31 < var_481_37 then
					arg_478_1.talkMaxDuration = var_481_37

					if var_481_37 + var_481_30 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_37 + var_481_30
					end
				end

				arg_478_1.text_.text = var_481_34
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012115", "story_v_out_317012.awb") ~= 0 then
					local var_481_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012115", "story_v_out_317012.awb") / 1000

					if var_481_38 + var_481_30 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_38 + var_481_30
					end

					if var_481_33.prefab_name ~= "" and arg_478_1.actors_[var_481_33.prefab_name] ~= nil then
						local var_481_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_33.prefab_name].transform, "story_v_out_317012", "317012115", "story_v_out_317012.awb")

						arg_478_1:RecordAudio("317012115", var_481_39)
						arg_478_1:RecordAudio("317012115", var_481_39)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_317012", "317012115", "story_v_out_317012.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_317012", "317012115", "story_v_out_317012.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_40 = math.max(var_481_31, arg_478_1.talkMaxDuration)

			if var_481_30 <= arg_478_1.time_ and arg_478_1.time_ < var_481_30 + var_481_40 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_30) / var_481_40

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_30 + var_481_40 and arg_478_1.time_ < var_481_30 + var_481_40 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_478_1:InitPlayNodeList()
	end,
	Play317012116 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 317012116
		arg_482_1.duration_ = 9.37

		local var_482_0 = {
			zh = 8.133,
			ja = 9.366
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play317012117(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = arg_482_1.actors_["2078ui_story"].transform
			local var_485_1 = 0

			if var_485_1 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 then
				arg_482_1.var_.moveOldPos2078ui_story = var_485_0.localPosition
			end

			local var_485_2 = 0.001

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_2 then
				local var_485_3 = (arg_482_1.time_ - var_485_1) / var_485_2
				local var_485_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_485_0.localPosition = Vector3.Lerp(arg_482_1.var_.moveOldPos2078ui_story, var_485_4, var_485_3)

				local var_485_5 = manager.ui.mainCamera.transform.position - var_485_0.position

				var_485_0.forward = Vector3.New(var_485_5.x, var_485_5.y, var_485_5.z)

				local var_485_6 = var_485_0.localEulerAngles

				var_485_6.z = 0
				var_485_6.x = 0
				var_485_0.localEulerAngles = var_485_6
			end

			if arg_482_1.time_ >= var_485_1 + var_485_2 and arg_482_1.time_ < var_485_1 + var_485_2 + arg_485_0 then
				var_485_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_485_7 = manager.ui.mainCamera.transform.position - var_485_0.position

				var_485_0.forward = Vector3.New(var_485_7.x, var_485_7.y, var_485_7.z)

				local var_485_8 = var_485_0.localEulerAngles

				var_485_8.z = 0
				var_485_8.x = 0
				var_485_0.localEulerAngles = var_485_8
			end

			local var_485_9 = arg_482_1.actors_["2078ui_story"]
			local var_485_10 = 0

			if var_485_10 < arg_482_1.time_ and arg_482_1.time_ <= var_485_10 + arg_485_0 and not isNil(var_485_9) and arg_482_1.var_.characterEffect2078ui_story == nil then
				arg_482_1.var_.characterEffect2078ui_story = var_485_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_11 = 0.200000002980232

			if var_485_10 <= arg_482_1.time_ and arg_482_1.time_ < var_485_10 + var_485_11 and not isNil(var_485_9) then
				local var_485_12 = (arg_482_1.time_ - var_485_10) / var_485_11

				if arg_482_1.var_.characterEffect2078ui_story and not isNil(var_485_9) then
					arg_482_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_482_1.time_ >= var_485_10 + var_485_11 and arg_482_1.time_ < var_485_10 + var_485_11 + arg_485_0 and not isNil(var_485_9) and arg_482_1.var_.characterEffect2078ui_story then
				arg_482_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_485_13 = 0

			if var_485_13 < arg_482_1.time_ and arg_482_1.time_ <= var_485_13 + arg_485_0 then
				arg_482_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_485_14 = 0

			if var_485_14 < arg_482_1.time_ and arg_482_1.time_ <= var_485_14 + arg_485_0 then
				arg_482_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_485_15 = arg_482_1.actors_["2079ui_story"].transform
			local var_485_16 = 0

			if var_485_16 < arg_482_1.time_ and arg_482_1.time_ <= var_485_16 + arg_485_0 then
				arg_482_1.var_.moveOldPos2079ui_story = var_485_15.localPosition
			end

			local var_485_17 = 0.001

			if var_485_16 <= arg_482_1.time_ and arg_482_1.time_ < var_485_16 + var_485_17 then
				local var_485_18 = (arg_482_1.time_ - var_485_16) / var_485_17
				local var_485_19 = Vector3.New(0.7, -1.28, -5.6)

				var_485_15.localPosition = Vector3.Lerp(arg_482_1.var_.moveOldPos2079ui_story, var_485_19, var_485_18)

				local var_485_20 = manager.ui.mainCamera.transform.position - var_485_15.position

				var_485_15.forward = Vector3.New(var_485_20.x, var_485_20.y, var_485_20.z)

				local var_485_21 = var_485_15.localEulerAngles

				var_485_21.z = 0
				var_485_21.x = 0
				var_485_15.localEulerAngles = var_485_21
			end

			if arg_482_1.time_ >= var_485_16 + var_485_17 and arg_482_1.time_ < var_485_16 + var_485_17 + arg_485_0 then
				var_485_15.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_485_22 = manager.ui.mainCamera.transform.position - var_485_15.position

				var_485_15.forward = Vector3.New(var_485_22.x, var_485_22.y, var_485_22.z)

				local var_485_23 = var_485_15.localEulerAngles

				var_485_23.z = 0
				var_485_23.x = 0
				var_485_15.localEulerAngles = var_485_23
			end

			local var_485_24 = arg_482_1.actors_["2079ui_story"]
			local var_485_25 = 0

			if var_485_25 < arg_482_1.time_ and arg_482_1.time_ <= var_485_25 + arg_485_0 and not isNil(var_485_24) and arg_482_1.var_.characterEffect2079ui_story == nil then
				arg_482_1.var_.characterEffect2079ui_story = var_485_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_26 = 0.200000002980232

			if var_485_25 <= arg_482_1.time_ and arg_482_1.time_ < var_485_25 + var_485_26 and not isNil(var_485_24) then
				local var_485_27 = (arg_482_1.time_ - var_485_25) / var_485_26

				if arg_482_1.var_.characterEffect2079ui_story and not isNil(var_485_24) then
					local var_485_28 = Mathf.Lerp(0, 0.5, var_485_27)

					arg_482_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_482_1.var_.characterEffect2079ui_story.fillRatio = var_485_28
				end
			end

			if arg_482_1.time_ >= var_485_25 + var_485_26 and arg_482_1.time_ < var_485_25 + var_485_26 + arg_485_0 and not isNil(var_485_24) and arg_482_1.var_.characterEffect2079ui_story then
				local var_485_29 = 0.5

				arg_482_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_482_1.var_.characterEffect2079ui_story.fillRatio = var_485_29
			end

			local var_485_30 = 0
			local var_485_31 = 0.9

			if var_485_30 < arg_482_1.time_ and arg_482_1.time_ <= var_485_30 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_32 = arg_482_1:FormatText(StoryNameCfg[530].name)

				arg_482_1.leftNameTxt_.text = var_485_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_33 = arg_482_1:GetWordFromCfg(317012116)
				local var_485_34 = arg_482_1:FormatText(var_485_33.content)

				arg_482_1.text_.text = var_485_34

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_35 = 36
				local var_485_36 = utf8.len(var_485_34)
				local var_485_37 = var_485_35 <= 0 and var_485_31 or var_485_31 * (var_485_36 / var_485_35)

				if var_485_37 > 0 and var_485_31 < var_485_37 then
					arg_482_1.talkMaxDuration = var_485_37

					if var_485_37 + var_485_30 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_37 + var_485_30
					end
				end

				arg_482_1.text_.text = var_485_34
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012116", "story_v_out_317012.awb") ~= 0 then
					local var_485_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012116", "story_v_out_317012.awb") / 1000

					if var_485_38 + var_485_30 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_38 + var_485_30
					end

					if var_485_33.prefab_name ~= "" and arg_482_1.actors_[var_485_33.prefab_name] ~= nil then
						local var_485_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_33.prefab_name].transform, "story_v_out_317012", "317012116", "story_v_out_317012.awb")

						arg_482_1:RecordAudio("317012116", var_485_39)
						arg_482_1:RecordAudio("317012116", var_485_39)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_317012", "317012116", "story_v_out_317012.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_317012", "317012116", "story_v_out_317012.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_40 = math.max(var_485_31, arg_482_1.talkMaxDuration)

			if var_485_30 <= arg_482_1.time_ and arg_482_1.time_ < var_485_30 + var_485_40 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_30) / var_485_40

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_30 + var_485_40 and arg_482_1.time_ < var_485_30 + var_485_40 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_482_1:InitPlayNodeList()
	end,
	Play317012117 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 317012117
		arg_486_1.duration_ = 7.53

		local var_486_0 = {
			zh = 3.866,
			ja = 7.533
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play317012118(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = arg_486_1.actors_["2078ui_story"].transform
			local var_489_1 = 0

			if var_489_1 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 then
				arg_486_1.var_.moveOldPos2078ui_story = var_489_0.localPosition
			end

			local var_489_2 = 0.001

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_2 then
				local var_489_3 = (arg_486_1.time_ - var_489_1) / var_489_2
				local var_489_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_489_0.localPosition = Vector3.Lerp(arg_486_1.var_.moveOldPos2078ui_story, var_489_4, var_489_3)

				local var_489_5 = manager.ui.mainCamera.transform.position - var_489_0.position

				var_489_0.forward = Vector3.New(var_489_5.x, var_489_5.y, var_489_5.z)

				local var_489_6 = var_489_0.localEulerAngles

				var_489_6.z = 0
				var_489_6.x = 0
				var_489_0.localEulerAngles = var_489_6
			end

			if arg_486_1.time_ >= var_489_1 + var_489_2 and arg_486_1.time_ < var_489_1 + var_489_2 + arg_489_0 then
				var_489_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_489_7 = manager.ui.mainCamera.transform.position - var_489_0.position

				var_489_0.forward = Vector3.New(var_489_7.x, var_489_7.y, var_489_7.z)

				local var_489_8 = var_489_0.localEulerAngles

				var_489_8.z = 0
				var_489_8.x = 0
				var_489_0.localEulerAngles = var_489_8
			end

			local var_489_9 = arg_486_1.actors_["2078ui_story"]
			local var_489_10 = 0

			if var_489_10 < arg_486_1.time_ and arg_486_1.time_ <= var_489_10 + arg_489_0 and not isNil(var_489_9) and arg_486_1.var_.characterEffect2078ui_story == nil then
				arg_486_1.var_.characterEffect2078ui_story = var_489_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_11 = 0.200000002980232

			if var_489_10 <= arg_486_1.time_ and arg_486_1.time_ < var_489_10 + var_489_11 and not isNil(var_489_9) then
				local var_489_12 = (arg_486_1.time_ - var_489_10) / var_489_11

				if arg_486_1.var_.characterEffect2078ui_story and not isNil(var_489_9) then
					local var_489_13 = Mathf.Lerp(0, 0.5, var_489_12)

					arg_486_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_486_1.var_.characterEffect2078ui_story.fillRatio = var_489_13
				end
			end

			if arg_486_1.time_ >= var_489_10 + var_489_11 and arg_486_1.time_ < var_489_10 + var_489_11 + arg_489_0 and not isNil(var_489_9) and arg_486_1.var_.characterEffect2078ui_story then
				local var_489_14 = 0.5

				arg_486_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_486_1.var_.characterEffect2078ui_story.fillRatio = var_489_14
			end

			local var_489_15 = arg_486_1.actors_["2079ui_story"].transform
			local var_489_16 = 0

			if var_489_16 < arg_486_1.time_ and arg_486_1.time_ <= var_489_16 + arg_489_0 then
				arg_486_1.var_.moveOldPos2079ui_story = var_489_15.localPosition
			end

			local var_489_17 = 0.001

			if var_489_16 <= arg_486_1.time_ and arg_486_1.time_ < var_489_16 + var_489_17 then
				local var_489_18 = (arg_486_1.time_ - var_489_16) / var_489_17
				local var_489_19 = Vector3.New(0.7, -1.28, -5.6)

				var_489_15.localPosition = Vector3.Lerp(arg_486_1.var_.moveOldPos2079ui_story, var_489_19, var_489_18)

				local var_489_20 = manager.ui.mainCamera.transform.position - var_489_15.position

				var_489_15.forward = Vector3.New(var_489_20.x, var_489_20.y, var_489_20.z)

				local var_489_21 = var_489_15.localEulerAngles

				var_489_21.z = 0
				var_489_21.x = 0
				var_489_15.localEulerAngles = var_489_21
			end

			if arg_486_1.time_ >= var_489_16 + var_489_17 and arg_486_1.time_ < var_489_16 + var_489_17 + arg_489_0 then
				var_489_15.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_489_22 = manager.ui.mainCamera.transform.position - var_489_15.position

				var_489_15.forward = Vector3.New(var_489_22.x, var_489_22.y, var_489_22.z)

				local var_489_23 = var_489_15.localEulerAngles

				var_489_23.z = 0
				var_489_23.x = 0
				var_489_15.localEulerAngles = var_489_23
			end

			local var_489_24 = arg_486_1.actors_["2079ui_story"]
			local var_489_25 = 0

			if var_489_25 < arg_486_1.time_ and arg_486_1.time_ <= var_489_25 + arg_489_0 and not isNil(var_489_24) and arg_486_1.var_.characterEffect2079ui_story == nil then
				arg_486_1.var_.characterEffect2079ui_story = var_489_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_26 = 0.200000002980232

			if var_489_25 <= arg_486_1.time_ and arg_486_1.time_ < var_489_25 + var_489_26 and not isNil(var_489_24) then
				local var_489_27 = (arg_486_1.time_ - var_489_25) / var_489_26

				if arg_486_1.var_.characterEffect2079ui_story and not isNil(var_489_24) then
					arg_486_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_486_1.time_ >= var_489_25 + var_489_26 and arg_486_1.time_ < var_489_25 + var_489_26 + arg_489_0 and not isNil(var_489_24) and arg_486_1.var_.characterEffect2079ui_story then
				arg_486_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_489_28 = 0

			if var_489_28 < arg_486_1.time_ and arg_486_1.time_ <= var_489_28 + arg_489_0 then
				arg_486_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_489_29 = 0

			if var_489_29 < arg_486_1.time_ and arg_486_1.time_ <= var_489_29 + arg_489_0 then
				arg_486_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_489_30 = 0
			local var_489_31 = 0.35

			if var_489_30 < arg_486_1.time_ and arg_486_1.time_ <= var_489_30 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_32 = arg_486_1:FormatText(StoryNameCfg[529].name)

				arg_486_1.leftNameTxt_.text = var_489_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_33 = arg_486_1:GetWordFromCfg(317012117)
				local var_489_34 = arg_486_1:FormatText(var_489_33.content)

				arg_486_1.text_.text = var_489_34

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_35 = 14
				local var_489_36 = utf8.len(var_489_34)
				local var_489_37 = var_489_35 <= 0 and var_489_31 or var_489_31 * (var_489_36 / var_489_35)

				if var_489_37 > 0 and var_489_31 < var_489_37 then
					arg_486_1.talkMaxDuration = var_489_37

					if var_489_37 + var_489_30 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_37 + var_489_30
					end
				end

				arg_486_1.text_.text = var_489_34
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012117", "story_v_out_317012.awb") ~= 0 then
					local var_489_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012117", "story_v_out_317012.awb") / 1000

					if var_489_38 + var_489_30 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_38 + var_489_30
					end

					if var_489_33.prefab_name ~= "" and arg_486_1.actors_[var_489_33.prefab_name] ~= nil then
						local var_489_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_33.prefab_name].transform, "story_v_out_317012", "317012117", "story_v_out_317012.awb")

						arg_486_1:RecordAudio("317012117", var_489_39)
						arg_486_1:RecordAudio("317012117", var_489_39)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_out_317012", "317012117", "story_v_out_317012.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_out_317012", "317012117", "story_v_out_317012.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_40 = math.max(var_489_31, arg_486_1.talkMaxDuration)

			if var_489_30 <= arg_486_1.time_ and arg_486_1.time_ < var_489_30 + var_489_40 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_30) / var_489_40

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_30 + var_489_40 and arg_486_1.time_ < var_489_30 + var_489_40 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_486_1:InitPlayNodeList()
	end,
	Play317012118 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 317012118
		arg_490_1.duration_ = 5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play317012119(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = arg_490_1.actors_["2079ui_story"]
			local var_493_1 = 0

			if var_493_1 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.characterEffect2079ui_story == nil then
				arg_490_1.var_.characterEffect2079ui_story = var_493_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_2 = 0.200000002980232

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_2 and not isNil(var_493_0) then
				local var_493_3 = (arg_490_1.time_ - var_493_1) / var_493_2

				if arg_490_1.var_.characterEffect2079ui_story and not isNil(var_493_0) then
					local var_493_4 = Mathf.Lerp(0, 0.5, var_493_3)

					arg_490_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_490_1.var_.characterEffect2079ui_story.fillRatio = var_493_4
				end
			end

			if arg_490_1.time_ >= var_493_1 + var_493_2 and arg_490_1.time_ < var_493_1 + var_493_2 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.characterEffect2079ui_story then
				local var_493_5 = 0.5

				arg_490_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_490_1.var_.characterEffect2079ui_story.fillRatio = var_493_5
			end

			local var_493_6 = 0
			local var_493_7 = 0.5

			if var_493_6 < arg_490_1.time_ and arg_490_1.time_ <= var_493_6 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, false)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_8 = arg_490_1:GetWordFromCfg(317012118)
				local var_493_9 = arg_490_1:FormatText(var_493_8.content)

				arg_490_1.text_.text = var_493_9

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_10 = 20
				local var_493_11 = utf8.len(var_493_9)
				local var_493_12 = var_493_10 <= 0 and var_493_7 or var_493_7 * (var_493_11 / var_493_10)

				if var_493_12 > 0 and var_493_7 < var_493_12 then
					arg_490_1.talkMaxDuration = var_493_12

					if var_493_12 + var_493_6 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_12 + var_493_6
					end
				end

				arg_490_1.text_.text = var_493_9
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)
				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_13 = math.max(var_493_7, arg_490_1.talkMaxDuration)

			if var_493_6 <= arg_490_1.time_ and arg_490_1.time_ < var_493_6 + var_493_13 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_6) / var_493_13

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_6 + var_493_13 and arg_490_1.time_ < var_493_6 + var_493_13 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play317012119 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 317012119
		arg_494_1.duration_ = 12.43

		local var_494_0 = {
			zh = 10.4,
			ja = 12.433
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play317012120(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = arg_494_1.actors_["2078ui_story"].transform
			local var_497_1 = 0

			if var_497_1 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 then
				arg_494_1.var_.moveOldPos2078ui_story = var_497_0.localPosition
			end

			local var_497_2 = 0.001

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_2 then
				local var_497_3 = (arg_494_1.time_ - var_497_1) / var_497_2
				local var_497_4 = Vector3.New(0, 100, 0)

				var_497_0.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos2078ui_story, var_497_4, var_497_3)

				local var_497_5 = manager.ui.mainCamera.transform.position - var_497_0.position

				var_497_0.forward = Vector3.New(var_497_5.x, var_497_5.y, var_497_5.z)

				local var_497_6 = var_497_0.localEulerAngles

				var_497_6.z = 0
				var_497_6.x = 0
				var_497_0.localEulerAngles = var_497_6
			end

			if arg_494_1.time_ >= var_497_1 + var_497_2 and arg_494_1.time_ < var_497_1 + var_497_2 + arg_497_0 then
				var_497_0.localPosition = Vector3.New(0, 100, 0)

				local var_497_7 = manager.ui.mainCamera.transform.position - var_497_0.position

				var_497_0.forward = Vector3.New(var_497_7.x, var_497_7.y, var_497_7.z)

				local var_497_8 = var_497_0.localEulerAngles

				var_497_8.z = 0
				var_497_8.x = 0
				var_497_0.localEulerAngles = var_497_8
			end

			local var_497_9 = arg_494_1.actors_["2078ui_story"]
			local var_497_10 = 0

			if var_497_10 < arg_494_1.time_ and arg_494_1.time_ <= var_497_10 + arg_497_0 and not isNil(var_497_9) and arg_494_1.var_.characterEffect2078ui_story == nil then
				arg_494_1.var_.characterEffect2078ui_story = var_497_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_11 = 0.200000002980232

			if var_497_10 <= arg_494_1.time_ and arg_494_1.time_ < var_497_10 + var_497_11 and not isNil(var_497_9) then
				local var_497_12 = (arg_494_1.time_ - var_497_10) / var_497_11

				if arg_494_1.var_.characterEffect2078ui_story and not isNil(var_497_9) then
					local var_497_13 = Mathf.Lerp(0, 0.5, var_497_12)

					arg_494_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_494_1.var_.characterEffect2078ui_story.fillRatio = var_497_13
				end
			end

			if arg_494_1.time_ >= var_497_10 + var_497_11 and arg_494_1.time_ < var_497_10 + var_497_11 + arg_497_0 and not isNil(var_497_9) and arg_494_1.var_.characterEffect2078ui_story then
				local var_497_14 = 0.5

				arg_494_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_494_1.var_.characterEffect2078ui_story.fillRatio = var_497_14
			end

			local var_497_15 = arg_494_1.actors_["2079ui_story"].transform
			local var_497_16 = 0

			if var_497_16 < arg_494_1.time_ and arg_494_1.time_ <= var_497_16 + arg_497_0 then
				arg_494_1.var_.moveOldPos2079ui_story = var_497_15.localPosition
			end

			local var_497_17 = 0.001

			if var_497_16 <= arg_494_1.time_ and arg_494_1.time_ < var_497_16 + var_497_17 then
				local var_497_18 = (arg_494_1.time_ - var_497_16) / var_497_17
				local var_497_19 = Vector3.New(0, 100, 0)

				var_497_15.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos2079ui_story, var_497_19, var_497_18)

				local var_497_20 = manager.ui.mainCamera.transform.position - var_497_15.position

				var_497_15.forward = Vector3.New(var_497_20.x, var_497_20.y, var_497_20.z)

				local var_497_21 = var_497_15.localEulerAngles

				var_497_21.z = 0
				var_497_21.x = 0
				var_497_15.localEulerAngles = var_497_21
			end

			if arg_494_1.time_ >= var_497_16 + var_497_17 and arg_494_1.time_ < var_497_16 + var_497_17 + arg_497_0 then
				var_497_15.localPosition = Vector3.New(0, 100, 0)

				local var_497_22 = manager.ui.mainCamera.transform.position - var_497_15.position

				var_497_15.forward = Vector3.New(var_497_22.x, var_497_22.y, var_497_22.z)

				local var_497_23 = var_497_15.localEulerAngles

				var_497_23.z = 0
				var_497_23.x = 0
				var_497_15.localEulerAngles = var_497_23
			end

			local var_497_24 = arg_494_1.actors_["2079ui_story"]
			local var_497_25 = 0

			if var_497_25 < arg_494_1.time_ and arg_494_1.time_ <= var_497_25 + arg_497_0 and not isNil(var_497_24) and arg_494_1.var_.characterEffect2079ui_story == nil then
				arg_494_1.var_.characterEffect2079ui_story = var_497_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_26 = 0.200000002980232

			if var_497_25 <= arg_494_1.time_ and arg_494_1.time_ < var_497_25 + var_497_26 and not isNil(var_497_24) then
				local var_497_27 = (arg_494_1.time_ - var_497_25) / var_497_26

				if arg_494_1.var_.characterEffect2079ui_story and not isNil(var_497_24) then
					local var_497_28 = Mathf.Lerp(0, 0.5, var_497_27)

					arg_494_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_494_1.var_.characterEffect2079ui_story.fillRatio = var_497_28
				end
			end

			if arg_494_1.time_ >= var_497_25 + var_497_26 and arg_494_1.time_ < var_497_25 + var_497_26 + arg_497_0 and not isNil(var_497_24) and arg_494_1.var_.characterEffect2079ui_story then
				local var_497_29 = 0.5

				arg_494_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_494_1.var_.characterEffect2079ui_story.fillRatio = var_497_29
			end

			local var_497_30 = arg_494_1.actors_["1015ui_story"].transform
			local var_497_31 = 0

			if var_497_31 < arg_494_1.time_ and arg_494_1.time_ <= var_497_31 + arg_497_0 then
				arg_494_1.var_.moveOldPos1015ui_story = var_497_30.localPosition
			end

			local var_497_32 = 0.001

			if var_497_31 <= arg_494_1.time_ and arg_494_1.time_ < var_497_31 + var_497_32 then
				local var_497_33 = (arg_494_1.time_ - var_497_31) / var_497_32
				local var_497_34 = Vector3.New(0, -1.15, -6.2)

				var_497_30.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos1015ui_story, var_497_34, var_497_33)

				local var_497_35 = manager.ui.mainCamera.transform.position - var_497_30.position

				var_497_30.forward = Vector3.New(var_497_35.x, var_497_35.y, var_497_35.z)

				local var_497_36 = var_497_30.localEulerAngles

				var_497_36.z = 0
				var_497_36.x = 0
				var_497_30.localEulerAngles = var_497_36
			end

			if arg_494_1.time_ >= var_497_31 + var_497_32 and arg_494_1.time_ < var_497_31 + var_497_32 + arg_497_0 then
				var_497_30.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_497_37 = manager.ui.mainCamera.transform.position - var_497_30.position

				var_497_30.forward = Vector3.New(var_497_37.x, var_497_37.y, var_497_37.z)

				local var_497_38 = var_497_30.localEulerAngles

				var_497_38.z = 0
				var_497_38.x = 0
				var_497_30.localEulerAngles = var_497_38
			end

			local var_497_39 = arg_494_1.actors_["1015ui_story"]
			local var_497_40 = 0

			if var_497_40 < arg_494_1.time_ and arg_494_1.time_ <= var_497_40 + arg_497_0 and not isNil(var_497_39) and arg_494_1.var_.characterEffect1015ui_story == nil then
				arg_494_1.var_.characterEffect1015ui_story = var_497_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_41 = 0.200000002980232

			if var_497_40 <= arg_494_1.time_ and arg_494_1.time_ < var_497_40 + var_497_41 and not isNil(var_497_39) then
				local var_497_42 = (arg_494_1.time_ - var_497_40) / var_497_41

				if arg_494_1.var_.characterEffect1015ui_story and not isNil(var_497_39) then
					arg_494_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_494_1.time_ >= var_497_40 + var_497_41 and arg_494_1.time_ < var_497_40 + var_497_41 + arg_497_0 and not isNil(var_497_39) and arg_494_1.var_.characterEffect1015ui_story then
				arg_494_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_497_43 = 0

			if var_497_43 < arg_494_1.time_ and arg_494_1.time_ <= var_497_43 + arg_497_0 then
				arg_494_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_497_44 = 0

			if var_497_44 < arg_494_1.time_ and arg_494_1.time_ <= var_497_44 + arg_497_0 then
				arg_494_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_497_45 = 0
			local var_497_46 = 1.1

			if var_497_45 < arg_494_1.time_ and arg_494_1.time_ <= var_497_45 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_47 = arg_494_1:FormatText(StoryNameCfg[479].name)

				arg_494_1.leftNameTxt_.text = var_497_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_48 = arg_494_1:GetWordFromCfg(317012119)
				local var_497_49 = arg_494_1:FormatText(var_497_48.content)

				arg_494_1.text_.text = var_497_49

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_50 = 44
				local var_497_51 = utf8.len(var_497_49)
				local var_497_52 = var_497_50 <= 0 and var_497_46 or var_497_46 * (var_497_51 / var_497_50)

				if var_497_52 > 0 and var_497_46 < var_497_52 then
					arg_494_1.talkMaxDuration = var_497_52

					if var_497_52 + var_497_45 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_52 + var_497_45
					end
				end

				arg_494_1.text_.text = var_497_49
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012119", "story_v_out_317012.awb") ~= 0 then
					local var_497_53 = manager.audio:GetVoiceLength("story_v_out_317012", "317012119", "story_v_out_317012.awb") / 1000

					if var_497_53 + var_497_45 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_53 + var_497_45
					end

					if var_497_48.prefab_name ~= "" and arg_494_1.actors_[var_497_48.prefab_name] ~= nil then
						local var_497_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_48.prefab_name].transform, "story_v_out_317012", "317012119", "story_v_out_317012.awb")

						arg_494_1:RecordAudio("317012119", var_497_54)
						arg_494_1:RecordAudio("317012119", var_497_54)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_out_317012", "317012119", "story_v_out_317012.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_out_317012", "317012119", "story_v_out_317012.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_55 = math.max(var_497_46, arg_494_1.talkMaxDuration)

			if var_497_45 <= arg_494_1.time_ and arg_494_1.time_ < var_497_45 + var_497_55 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_45) / var_497_55

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_45 + var_497_55 and arg_494_1.time_ < var_497_45 + var_497_55 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
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

		arg_494_1:InitPlayNodeList()
	end,
	Play317012120 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 317012120
		arg_498_1.duration_ = 5

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play317012121(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = arg_498_1.actors_["1015ui_story"]
			local var_501_1 = 0

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect1015ui_story == nil then
				arg_498_1.var_.characterEffect1015ui_story = var_501_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_2 = 0.200000002980232

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 and not isNil(var_501_0) then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / var_501_2

				if arg_498_1.var_.characterEffect1015ui_story and not isNil(var_501_0) then
					local var_501_4 = Mathf.Lerp(0, 0.5, var_501_3)

					arg_498_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_498_1.var_.characterEffect1015ui_story.fillRatio = var_501_4
				end
			end

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect1015ui_story then
				local var_501_5 = 0.5

				arg_498_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_498_1.var_.characterEffect1015ui_story.fillRatio = var_501_5
			end

			local var_501_6 = 0
			local var_501_7 = 0.3

			if var_501_6 < arg_498_1.time_ and arg_498_1.time_ <= var_501_6 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, false)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_8 = arg_498_1:GetWordFromCfg(317012120)
				local var_501_9 = arg_498_1:FormatText(var_501_8.content)

				arg_498_1.text_.text = var_501_9

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_10 = 12
				local var_501_11 = utf8.len(var_501_9)
				local var_501_12 = var_501_10 <= 0 and var_501_7 or var_501_7 * (var_501_11 / var_501_10)

				if var_501_12 > 0 and var_501_7 < var_501_12 then
					arg_498_1.talkMaxDuration = var_501_12

					if var_501_12 + var_501_6 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_12 + var_501_6
					end
				end

				arg_498_1.text_.text = var_501_9
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)
				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_13 = math.max(var_501_7, arg_498_1.talkMaxDuration)

			if var_501_6 <= arg_498_1.time_ and arg_498_1.time_ < var_501_6 + var_501_13 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_6) / var_501_13

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_6 + var_501_13 and arg_498_1.time_ < var_501_6 + var_501_13 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play317012121 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 317012121
		arg_502_1.duration_ = 8.9

		local var_502_0 = {
			zh = 7.7,
			ja = 8.9
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play317012122(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = arg_502_1.actors_["1015ui_story"].transform
			local var_505_1 = 0

			if var_505_1 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 then
				arg_502_1.var_.moveOldPos1015ui_story = var_505_0.localPosition
			end

			local var_505_2 = 0.001

			if var_505_1 <= arg_502_1.time_ and arg_502_1.time_ < var_505_1 + var_505_2 then
				local var_505_3 = (arg_502_1.time_ - var_505_1) / var_505_2
				local var_505_4 = Vector3.New(0, -1.15, -6.2)

				var_505_0.localPosition = Vector3.Lerp(arg_502_1.var_.moveOldPos1015ui_story, var_505_4, var_505_3)

				local var_505_5 = manager.ui.mainCamera.transform.position - var_505_0.position

				var_505_0.forward = Vector3.New(var_505_5.x, var_505_5.y, var_505_5.z)

				local var_505_6 = var_505_0.localEulerAngles

				var_505_6.z = 0
				var_505_6.x = 0
				var_505_0.localEulerAngles = var_505_6
			end

			if arg_502_1.time_ >= var_505_1 + var_505_2 and arg_502_1.time_ < var_505_1 + var_505_2 + arg_505_0 then
				var_505_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_505_7 = manager.ui.mainCamera.transform.position - var_505_0.position

				var_505_0.forward = Vector3.New(var_505_7.x, var_505_7.y, var_505_7.z)

				local var_505_8 = var_505_0.localEulerAngles

				var_505_8.z = 0
				var_505_8.x = 0
				var_505_0.localEulerAngles = var_505_8
			end

			local var_505_9 = arg_502_1.actors_["1015ui_story"]
			local var_505_10 = 0

			if var_505_10 < arg_502_1.time_ and arg_502_1.time_ <= var_505_10 + arg_505_0 and not isNil(var_505_9) and arg_502_1.var_.characterEffect1015ui_story == nil then
				arg_502_1.var_.characterEffect1015ui_story = var_505_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_11 = 0.200000002980232

			if var_505_10 <= arg_502_1.time_ and arg_502_1.time_ < var_505_10 + var_505_11 and not isNil(var_505_9) then
				local var_505_12 = (arg_502_1.time_ - var_505_10) / var_505_11

				if arg_502_1.var_.characterEffect1015ui_story and not isNil(var_505_9) then
					arg_502_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_502_1.time_ >= var_505_10 + var_505_11 and arg_502_1.time_ < var_505_10 + var_505_11 + arg_505_0 and not isNil(var_505_9) and arg_502_1.var_.characterEffect1015ui_story then
				arg_502_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_505_13 = 0

			if var_505_13 < arg_502_1.time_ and arg_502_1.time_ <= var_505_13 + arg_505_0 then
				arg_502_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_505_14 = 0

			if var_505_14 < arg_502_1.time_ and arg_502_1.time_ <= var_505_14 + arg_505_0 then
				arg_502_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_505_15 = 0
			local var_505_16 = 0.8

			if var_505_15 < arg_502_1.time_ and arg_502_1.time_ <= var_505_15 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				local var_505_17 = arg_502_1:FormatText(StoryNameCfg[479].name)

				arg_502_1.leftNameTxt_.text = var_505_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_18 = arg_502_1:GetWordFromCfg(317012121)
				local var_505_19 = arg_502_1:FormatText(var_505_18.content)

				arg_502_1.text_.text = var_505_19

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_20 = 32
				local var_505_21 = utf8.len(var_505_19)
				local var_505_22 = var_505_20 <= 0 and var_505_16 or var_505_16 * (var_505_21 / var_505_20)

				if var_505_22 > 0 and var_505_16 < var_505_22 then
					arg_502_1.talkMaxDuration = var_505_22

					if var_505_22 + var_505_15 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_22 + var_505_15
					end
				end

				arg_502_1.text_.text = var_505_19
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012121", "story_v_out_317012.awb") ~= 0 then
					local var_505_23 = manager.audio:GetVoiceLength("story_v_out_317012", "317012121", "story_v_out_317012.awb") / 1000

					if var_505_23 + var_505_15 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_23 + var_505_15
					end

					if var_505_18.prefab_name ~= "" and arg_502_1.actors_[var_505_18.prefab_name] ~= nil then
						local var_505_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_18.prefab_name].transform, "story_v_out_317012", "317012121", "story_v_out_317012.awb")

						arg_502_1:RecordAudio("317012121", var_505_24)
						arg_502_1:RecordAudio("317012121", var_505_24)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_out_317012", "317012121", "story_v_out_317012.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_out_317012", "317012121", "story_v_out_317012.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_25 = math.max(var_505_16, arg_502_1.talkMaxDuration)

			if var_505_15 <= arg_502_1.time_ and arg_502_1.time_ < var_505_15 + var_505_25 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_15) / var_505_25

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_15 + var_505_25 and arg_502_1.time_ < var_505_15 + var_505_25 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {
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

		arg_502_1:InitPlayNodeList()
	end,
	Play317012122 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 317012122
		arg_506_1.duration_ = 4.47

		local var_506_0 = {
			zh = 2,
			ja = 4.466
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play317012123(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = arg_506_1.actors_["2078ui_story"].transform
			local var_509_1 = 0

			if var_509_1 < arg_506_1.time_ and arg_506_1.time_ <= var_509_1 + arg_509_0 then
				arg_506_1.var_.moveOldPos2078ui_story = var_509_0.localPosition
			end

			local var_509_2 = 0.001

			if var_509_1 <= arg_506_1.time_ and arg_506_1.time_ < var_509_1 + var_509_2 then
				local var_509_3 = (arg_506_1.time_ - var_509_1) / var_509_2
				local var_509_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_509_0.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos2078ui_story, var_509_4, var_509_3)

				local var_509_5 = manager.ui.mainCamera.transform.position - var_509_0.position

				var_509_0.forward = Vector3.New(var_509_5.x, var_509_5.y, var_509_5.z)

				local var_509_6 = var_509_0.localEulerAngles

				var_509_6.z = 0
				var_509_6.x = 0
				var_509_0.localEulerAngles = var_509_6
			end

			if arg_506_1.time_ >= var_509_1 + var_509_2 and arg_506_1.time_ < var_509_1 + var_509_2 + arg_509_0 then
				var_509_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_509_7 = manager.ui.mainCamera.transform.position - var_509_0.position

				var_509_0.forward = Vector3.New(var_509_7.x, var_509_7.y, var_509_7.z)

				local var_509_8 = var_509_0.localEulerAngles

				var_509_8.z = 0
				var_509_8.x = 0
				var_509_0.localEulerAngles = var_509_8
			end

			local var_509_9 = arg_506_1.actors_["2078ui_story"]
			local var_509_10 = 0

			if var_509_10 < arg_506_1.time_ and arg_506_1.time_ <= var_509_10 + arg_509_0 and not isNil(var_509_9) and arg_506_1.var_.characterEffect2078ui_story == nil then
				arg_506_1.var_.characterEffect2078ui_story = var_509_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_11 = 0.200000002980232

			if var_509_10 <= arg_506_1.time_ and arg_506_1.time_ < var_509_10 + var_509_11 and not isNil(var_509_9) then
				local var_509_12 = (arg_506_1.time_ - var_509_10) / var_509_11

				if arg_506_1.var_.characterEffect2078ui_story and not isNil(var_509_9) then
					local var_509_13 = Mathf.Lerp(0, 0.5, var_509_12)

					arg_506_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_506_1.var_.characterEffect2078ui_story.fillRatio = var_509_13
				end
			end

			if arg_506_1.time_ >= var_509_10 + var_509_11 and arg_506_1.time_ < var_509_10 + var_509_11 + arg_509_0 and not isNil(var_509_9) and arg_506_1.var_.characterEffect2078ui_story then
				local var_509_14 = 0.5

				arg_506_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_506_1.var_.characterEffect2078ui_story.fillRatio = var_509_14
			end

			local var_509_15 = arg_506_1.actors_["2079ui_story"].transform
			local var_509_16 = 0

			if var_509_16 < arg_506_1.time_ and arg_506_1.time_ <= var_509_16 + arg_509_0 then
				arg_506_1.var_.moveOldPos2079ui_story = var_509_15.localPosition
			end

			local var_509_17 = 0.001

			if var_509_16 <= arg_506_1.time_ and arg_506_1.time_ < var_509_16 + var_509_17 then
				local var_509_18 = (arg_506_1.time_ - var_509_16) / var_509_17
				local var_509_19 = Vector3.New(0.7, -1.28, -5.6)

				var_509_15.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos2079ui_story, var_509_19, var_509_18)

				local var_509_20 = manager.ui.mainCamera.transform.position - var_509_15.position

				var_509_15.forward = Vector3.New(var_509_20.x, var_509_20.y, var_509_20.z)

				local var_509_21 = var_509_15.localEulerAngles

				var_509_21.z = 0
				var_509_21.x = 0
				var_509_15.localEulerAngles = var_509_21
			end

			if arg_506_1.time_ >= var_509_16 + var_509_17 and arg_506_1.time_ < var_509_16 + var_509_17 + arg_509_0 then
				var_509_15.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_509_22 = manager.ui.mainCamera.transform.position - var_509_15.position

				var_509_15.forward = Vector3.New(var_509_22.x, var_509_22.y, var_509_22.z)

				local var_509_23 = var_509_15.localEulerAngles

				var_509_23.z = 0
				var_509_23.x = 0
				var_509_15.localEulerAngles = var_509_23
			end

			local var_509_24 = arg_506_1.actors_["2079ui_story"]
			local var_509_25 = 0

			if var_509_25 < arg_506_1.time_ and arg_506_1.time_ <= var_509_25 + arg_509_0 and not isNil(var_509_24) and arg_506_1.var_.characterEffect2079ui_story == nil then
				arg_506_1.var_.characterEffect2079ui_story = var_509_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_26 = 0.200000002980232

			if var_509_25 <= arg_506_1.time_ and arg_506_1.time_ < var_509_25 + var_509_26 and not isNil(var_509_24) then
				local var_509_27 = (arg_506_1.time_ - var_509_25) / var_509_26

				if arg_506_1.var_.characterEffect2079ui_story and not isNil(var_509_24) then
					arg_506_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_506_1.time_ >= var_509_25 + var_509_26 and arg_506_1.time_ < var_509_25 + var_509_26 + arg_509_0 and not isNil(var_509_24) and arg_506_1.var_.characterEffect2079ui_story then
				arg_506_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_509_28 = 0

			if var_509_28 < arg_506_1.time_ and arg_506_1.time_ <= var_509_28 + arg_509_0 then
				arg_506_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_509_29 = 0

			if var_509_29 < arg_506_1.time_ and arg_506_1.time_ <= var_509_29 + arg_509_0 then
				arg_506_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_509_30 = arg_506_1.actors_["1015ui_story"].transform
			local var_509_31 = 0

			if var_509_31 < arg_506_1.time_ and arg_506_1.time_ <= var_509_31 + arg_509_0 then
				arg_506_1.var_.moveOldPos1015ui_story = var_509_30.localPosition
			end

			local var_509_32 = 0.001

			if var_509_31 <= arg_506_1.time_ and arg_506_1.time_ < var_509_31 + var_509_32 then
				local var_509_33 = (arg_506_1.time_ - var_509_31) / var_509_32
				local var_509_34 = Vector3.New(0, 100, 0)

				var_509_30.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos1015ui_story, var_509_34, var_509_33)

				local var_509_35 = manager.ui.mainCamera.transform.position - var_509_30.position

				var_509_30.forward = Vector3.New(var_509_35.x, var_509_35.y, var_509_35.z)

				local var_509_36 = var_509_30.localEulerAngles

				var_509_36.z = 0
				var_509_36.x = 0
				var_509_30.localEulerAngles = var_509_36
			end

			if arg_506_1.time_ >= var_509_31 + var_509_32 and arg_506_1.time_ < var_509_31 + var_509_32 + arg_509_0 then
				var_509_30.localPosition = Vector3.New(0, 100, 0)

				local var_509_37 = manager.ui.mainCamera.transform.position - var_509_30.position

				var_509_30.forward = Vector3.New(var_509_37.x, var_509_37.y, var_509_37.z)

				local var_509_38 = var_509_30.localEulerAngles

				var_509_38.z = 0
				var_509_38.x = 0
				var_509_30.localEulerAngles = var_509_38
			end

			local var_509_39 = arg_506_1.actors_["1015ui_story"]
			local var_509_40 = 0

			if var_509_40 < arg_506_1.time_ and arg_506_1.time_ <= var_509_40 + arg_509_0 and not isNil(var_509_39) and arg_506_1.var_.characterEffect1015ui_story == nil then
				arg_506_1.var_.characterEffect1015ui_story = var_509_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_41 = 0.200000002980232

			if var_509_40 <= arg_506_1.time_ and arg_506_1.time_ < var_509_40 + var_509_41 and not isNil(var_509_39) then
				local var_509_42 = (arg_506_1.time_ - var_509_40) / var_509_41

				if arg_506_1.var_.characterEffect1015ui_story and not isNil(var_509_39) then
					local var_509_43 = Mathf.Lerp(0, 0.5, var_509_42)

					arg_506_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_506_1.var_.characterEffect1015ui_story.fillRatio = var_509_43
				end
			end

			if arg_506_1.time_ >= var_509_40 + var_509_41 and arg_506_1.time_ < var_509_40 + var_509_41 + arg_509_0 and not isNil(var_509_39) and arg_506_1.var_.characterEffect1015ui_story then
				local var_509_44 = 0.5

				arg_506_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_506_1.var_.characterEffect1015ui_story.fillRatio = var_509_44
			end

			local var_509_45 = 0
			local var_509_46 = 0.25

			if var_509_45 < arg_506_1.time_ and arg_506_1.time_ <= var_509_45 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_47 = arg_506_1:FormatText(StoryNameCfg[529].name)

				arg_506_1.leftNameTxt_.text = var_509_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_48 = arg_506_1:GetWordFromCfg(317012122)
				local var_509_49 = arg_506_1:FormatText(var_509_48.content)

				arg_506_1.text_.text = var_509_49

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_50 = 10
				local var_509_51 = utf8.len(var_509_49)
				local var_509_52 = var_509_50 <= 0 and var_509_46 or var_509_46 * (var_509_51 / var_509_50)

				if var_509_52 > 0 and var_509_46 < var_509_52 then
					arg_506_1.talkMaxDuration = var_509_52

					if var_509_52 + var_509_45 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_52 + var_509_45
					end
				end

				arg_506_1.text_.text = var_509_49
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012122", "story_v_out_317012.awb") ~= 0 then
					local var_509_53 = manager.audio:GetVoiceLength("story_v_out_317012", "317012122", "story_v_out_317012.awb") / 1000

					if var_509_53 + var_509_45 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_53 + var_509_45
					end

					if var_509_48.prefab_name ~= "" and arg_506_1.actors_[var_509_48.prefab_name] ~= nil then
						local var_509_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_48.prefab_name].transform, "story_v_out_317012", "317012122", "story_v_out_317012.awb")

						arg_506_1:RecordAudio("317012122", var_509_54)
						arg_506_1:RecordAudio("317012122", var_509_54)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_317012", "317012122", "story_v_out_317012.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_317012", "317012122", "story_v_out_317012.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_55 = math.max(var_509_46, arg_506_1.talkMaxDuration)

			if var_509_45 <= arg_506_1.time_ and arg_506_1.time_ < var_509_45 + var_509_55 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_45) / var_509_55

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_45 + var_509_55 and arg_506_1.time_ < var_509_45 + var_509_55 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
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

		arg_506_1:InitPlayNodeList()
	end,
	Play317012123 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 317012123
		arg_510_1.duration_ = 5.6

		local var_510_0 = {
			zh = 5.6,
			ja = 5.066
		}
		local var_510_1 = manager.audio:GetLocalizationFlag()

		if var_510_0[var_510_1] ~= nil then
			arg_510_1.duration_ = var_510_0[var_510_1]
		end

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play317012124(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = arg_510_1.actors_["2078ui_story"].transform
			local var_513_1 = 0

			if var_513_1 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 then
				arg_510_1.var_.moveOldPos2078ui_story = var_513_0.localPosition
			end

			local var_513_2 = 0.001

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_2 then
				local var_513_3 = (arg_510_1.time_ - var_513_1) / var_513_2
				local var_513_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_513_0.localPosition = Vector3.Lerp(arg_510_1.var_.moveOldPos2078ui_story, var_513_4, var_513_3)

				local var_513_5 = manager.ui.mainCamera.transform.position - var_513_0.position

				var_513_0.forward = Vector3.New(var_513_5.x, var_513_5.y, var_513_5.z)

				local var_513_6 = var_513_0.localEulerAngles

				var_513_6.z = 0
				var_513_6.x = 0
				var_513_0.localEulerAngles = var_513_6
			end

			if arg_510_1.time_ >= var_513_1 + var_513_2 and arg_510_1.time_ < var_513_1 + var_513_2 + arg_513_0 then
				var_513_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_513_7 = manager.ui.mainCamera.transform.position - var_513_0.position

				var_513_0.forward = Vector3.New(var_513_7.x, var_513_7.y, var_513_7.z)

				local var_513_8 = var_513_0.localEulerAngles

				var_513_8.z = 0
				var_513_8.x = 0
				var_513_0.localEulerAngles = var_513_8
			end

			local var_513_9 = arg_510_1.actors_["2078ui_story"]
			local var_513_10 = 0

			if var_513_10 < arg_510_1.time_ and arg_510_1.time_ <= var_513_10 + arg_513_0 and not isNil(var_513_9) and arg_510_1.var_.characterEffect2078ui_story == nil then
				arg_510_1.var_.characterEffect2078ui_story = var_513_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_11 = 0.200000002980232

			if var_513_10 <= arg_510_1.time_ and arg_510_1.time_ < var_513_10 + var_513_11 and not isNil(var_513_9) then
				local var_513_12 = (arg_510_1.time_ - var_513_10) / var_513_11

				if arg_510_1.var_.characterEffect2078ui_story and not isNil(var_513_9) then
					arg_510_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_510_1.time_ >= var_513_10 + var_513_11 and arg_510_1.time_ < var_513_10 + var_513_11 + arg_513_0 and not isNil(var_513_9) and arg_510_1.var_.characterEffect2078ui_story then
				arg_510_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_513_13 = 0

			if var_513_13 < arg_510_1.time_ and arg_510_1.time_ <= var_513_13 + arg_513_0 then
				arg_510_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_513_14 = 0

			if var_513_14 < arg_510_1.time_ and arg_510_1.time_ <= var_513_14 + arg_513_0 then
				arg_510_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_513_15 = arg_510_1.actors_["2079ui_story"].transform
			local var_513_16 = 0

			if var_513_16 < arg_510_1.time_ and arg_510_1.time_ <= var_513_16 + arg_513_0 then
				arg_510_1.var_.moveOldPos2079ui_story = var_513_15.localPosition
			end

			local var_513_17 = 0.001

			if var_513_16 <= arg_510_1.time_ and arg_510_1.time_ < var_513_16 + var_513_17 then
				local var_513_18 = (arg_510_1.time_ - var_513_16) / var_513_17
				local var_513_19 = Vector3.New(0.7, -1.28, -5.6)

				var_513_15.localPosition = Vector3.Lerp(arg_510_1.var_.moveOldPos2079ui_story, var_513_19, var_513_18)

				local var_513_20 = manager.ui.mainCamera.transform.position - var_513_15.position

				var_513_15.forward = Vector3.New(var_513_20.x, var_513_20.y, var_513_20.z)

				local var_513_21 = var_513_15.localEulerAngles

				var_513_21.z = 0
				var_513_21.x = 0
				var_513_15.localEulerAngles = var_513_21
			end

			if arg_510_1.time_ >= var_513_16 + var_513_17 and arg_510_1.time_ < var_513_16 + var_513_17 + arg_513_0 then
				var_513_15.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_513_22 = manager.ui.mainCamera.transform.position - var_513_15.position

				var_513_15.forward = Vector3.New(var_513_22.x, var_513_22.y, var_513_22.z)

				local var_513_23 = var_513_15.localEulerAngles

				var_513_23.z = 0
				var_513_23.x = 0
				var_513_15.localEulerAngles = var_513_23
			end

			local var_513_24 = arg_510_1.actors_["2079ui_story"]
			local var_513_25 = 0

			if var_513_25 < arg_510_1.time_ and arg_510_1.time_ <= var_513_25 + arg_513_0 and not isNil(var_513_24) and arg_510_1.var_.characterEffect2079ui_story == nil then
				arg_510_1.var_.characterEffect2079ui_story = var_513_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_26 = 0.200000002980232

			if var_513_25 <= arg_510_1.time_ and arg_510_1.time_ < var_513_25 + var_513_26 and not isNil(var_513_24) then
				local var_513_27 = (arg_510_1.time_ - var_513_25) / var_513_26

				if arg_510_1.var_.characterEffect2079ui_story and not isNil(var_513_24) then
					local var_513_28 = Mathf.Lerp(0, 0.5, var_513_27)

					arg_510_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_510_1.var_.characterEffect2079ui_story.fillRatio = var_513_28
				end
			end

			if arg_510_1.time_ >= var_513_25 + var_513_26 and arg_510_1.time_ < var_513_25 + var_513_26 + arg_513_0 and not isNil(var_513_24) and arg_510_1.var_.characterEffect2079ui_story then
				local var_513_29 = 0.5

				arg_510_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_510_1.var_.characterEffect2079ui_story.fillRatio = var_513_29
			end

			local var_513_30 = 0
			local var_513_31 = 0.675

			if var_513_30 < arg_510_1.time_ and arg_510_1.time_ <= var_513_30 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				local var_513_32 = arg_510_1:FormatText(StoryNameCfg[530].name)

				arg_510_1.leftNameTxt_.text = var_513_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_33 = arg_510_1:GetWordFromCfg(317012123)
				local var_513_34 = arg_510_1:FormatText(var_513_33.content)

				arg_510_1.text_.text = var_513_34

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_35 = 27
				local var_513_36 = utf8.len(var_513_34)
				local var_513_37 = var_513_35 <= 0 and var_513_31 or var_513_31 * (var_513_36 / var_513_35)

				if var_513_37 > 0 and var_513_31 < var_513_37 then
					arg_510_1.talkMaxDuration = var_513_37

					if var_513_37 + var_513_30 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_37 + var_513_30
					end
				end

				arg_510_1.text_.text = var_513_34
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012123", "story_v_out_317012.awb") ~= 0 then
					local var_513_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012123", "story_v_out_317012.awb") / 1000

					if var_513_38 + var_513_30 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_38 + var_513_30
					end

					if var_513_33.prefab_name ~= "" and arg_510_1.actors_[var_513_33.prefab_name] ~= nil then
						local var_513_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_33.prefab_name].transform, "story_v_out_317012", "317012123", "story_v_out_317012.awb")

						arg_510_1:RecordAudio("317012123", var_513_39)
						arg_510_1:RecordAudio("317012123", var_513_39)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_out_317012", "317012123", "story_v_out_317012.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_out_317012", "317012123", "story_v_out_317012.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_40 = math.max(var_513_31, arg_510_1.talkMaxDuration)

			if var_513_30 <= arg_510_1.time_ and arg_510_1.time_ < var_513_30 + var_513_40 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_30) / var_513_40

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_30 + var_513_40 and arg_510_1.time_ < var_513_30 + var_513_40 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_510_1:InitPlayNodeList()
	end,
	Play317012124 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 317012124
		arg_514_1.duration_ = 4.1

		local var_514_0 = {
			zh = 2.766,
			ja = 4.1
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play317012125(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = arg_514_1.actors_["2078ui_story"].transform
			local var_517_1 = 0

			if var_517_1 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 then
				arg_514_1.var_.moveOldPos2078ui_story = var_517_0.localPosition
			end

			local var_517_2 = 0.001

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_2 then
				local var_517_3 = (arg_514_1.time_ - var_517_1) / var_517_2
				local var_517_4 = Vector3.New(0, 100, 0)

				var_517_0.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos2078ui_story, var_517_4, var_517_3)

				local var_517_5 = manager.ui.mainCamera.transform.position - var_517_0.position

				var_517_0.forward = Vector3.New(var_517_5.x, var_517_5.y, var_517_5.z)

				local var_517_6 = var_517_0.localEulerAngles

				var_517_6.z = 0
				var_517_6.x = 0
				var_517_0.localEulerAngles = var_517_6
			end

			if arg_514_1.time_ >= var_517_1 + var_517_2 and arg_514_1.time_ < var_517_1 + var_517_2 + arg_517_0 then
				var_517_0.localPosition = Vector3.New(0, 100, 0)

				local var_517_7 = manager.ui.mainCamera.transform.position - var_517_0.position

				var_517_0.forward = Vector3.New(var_517_7.x, var_517_7.y, var_517_7.z)

				local var_517_8 = var_517_0.localEulerAngles

				var_517_8.z = 0
				var_517_8.x = 0
				var_517_0.localEulerAngles = var_517_8
			end

			local var_517_9 = arg_514_1.actors_["2078ui_story"]
			local var_517_10 = 0

			if var_517_10 < arg_514_1.time_ and arg_514_1.time_ <= var_517_10 + arg_517_0 and not isNil(var_517_9) and arg_514_1.var_.characterEffect2078ui_story == nil then
				arg_514_1.var_.characterEffect2078ui_story = var_517_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_11 = 0.200000002980232

			if var_517_10 <= arg_514_1.time_ and arg_514_1.time_ < var_517_10 + var_517_11 and not isNil(var_517_9) then
				local var_517_12 = (arg_514_1.time_ - var_517_10) / var_517_11

				if arg_514_1.var_.characterEffect2078ui_story and not isNil(var_517_9) then
					local var_517_13 = Mathf.Lerp(0, 0.5, var_517_12)

					arg_514_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_514_1.var_.characterEffect2078ui_story.fillRatio = var_517_13
				end
			end

			if arg_514_1.time_ >= var_517_10 + var_517_11 and arg_514_1.time_ < var_517_10 + var_517_11 + arg_517_0 and not isNil(var_517_9) and arg_514_1.var_.characterEffect2078ui_story then
				local var_517_14 = 0.5

				arg_514_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_514_1.var_.characterEffect2078ui_story.fillRatio = var_517_14
			end

			local var_517_15 = arg_514_1.actors_["2079ui_story"].transform
			local var_517_16 = 0

			if var_517_16 < arg_514_1.time_ and arg_514_1.time_ <= var_517_16 + arg_517_0 then
				arg_514_1.var_.moveOldPos2079ui_story = var_517_15.localPosition
			end

			local var_517_17 = 0.001

			if var_517_16 <= arg_514_1.time_ and arg_514_1.time_ < var_517_16 + var_517_17 then
				local var_517_18 = (arg_514_1.time_ - var_517_16) / var_517_17
				local var_517_19 = Vector3.New(0, 100, 0)

				var_517_15.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos2079ui_story, var_517_19, var_517_18)

				local var_517_20 = manager.ui.mainCamera.transform.position - var_517_15.position

				var_517_15.forward = Vector3.New(var_517_20.x, var_517_20.y, var_517_20.z)

				local var_517_21 = var_517_15.localEulerAngles

				var_517_21.z = 0
				var_517_21.x = 0
				var_517_15.localEulerAngles = var_517_21
			end

			if arg_514_1.time_ >= var_517_16 + var_517_17 and arg_514_1.time_ < var_517_16 + var_517_17 + arg_517_0 then
				var_517_15.localPosition = Vector3.New(0, 100, 0)

				local var_517_22 = manager.ui.mainCamera.transform.position - var_517_15.position

				var_517_15.forward = Vector3.New(var_517_22.x, var_517_22.y, var_517_22.z)

				local var_517_23 = var_517_15.localEulerAngles

				var_517_23.z = 0
				var_517_23.x = 0
				var_517_15.localEulerAngles = var_517_23
			end

			local var_517_24 = arg_514_1.actors_["2079ui_story"]
			local var_517_25 = 0

			if var_517_25 < arg_514_1.time_ and arg_514_1.time_ <= var_517_25 + arg_517_0 and not isNil(var_517_24) and arg_514_1.var_.characterEffect2079ui_story == nil then
				arg_514_1.var_.characterEffect2079ui_story = var_517_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_26 = 0.200000002980232

			if var_517_25 <= arg_514_1.time_ and arg_514_1.time_ < var_517_25 + var_517_26 and not isNil(var_517_24) then
				local var_517_27 = (arg_514_1.time_ - var_517_25) / var_517_26

				if arg_514_1.var_.characterEffect2079ui_story and not isNil(var_517_24) then
					local var_517_28 = Mathf.Lerp(0, 0.5, var_517_27)

					arg_514_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_514_1.var_.characterEffect2079ui_story.fillRatio = var_517_28
				end
			end

			if arg_514_1.time_ >= var_517_25 + var_517_26 and arg_514_1.time_ < var_517_25 + var_517_26 + arg_517_0 and not isNil(var_517_24) and arg_514_1.var_.characterEffect2079ui_story then
				local var_517_29 = 0.5

				arg_514_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_514_1.var_.characterEffect2079ui_story.fillRatio = var_517_29
			end

			local var_517_30 = arg_514_1.actors_["1015ui_story"].transform
			local var_517_31 = 0

			if var_517_31 < arg_514_1.time_ and arg_514_1.time_ <= var_517_31 + arg_517_0 then
				arg_514_1.var_.moveOldPos1015ui_story = var_517_30.localPosition
			end

			local var_517_32 = 0.001

			if var_517_31 <= arg_514_1.time_ and arg_514_1.time_ < var_517_31 + var_517_32 then
				local var_517_33 = (arg_514_1.time_ - var_517_31) / var_517_32
				local var_517_34 = Vector3.New(0, -1.15, -6.2)

				var_517_30.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1015ui_story, var_517_34, var_517_33)

				local var_517_35 = manager.ui.mainCamera.transform.position - var_517_30.position

				var_517_30.forward = Vector3.New(var_517_35.x, var_517_35.y, var_517_35.z)

				local var_517_36 = var_517_30.localEulerAngles

				var_517_36.z = 0
				var_517_36.x = 0
				var_517_30.localEulerAngles = var_517_36
			end

			if arg_514_1.time_ >= var_517_31 + var_517_32 and arg_514_1.time_ < var_517_31 + var_517_32 + arg_517_0 then
				var_517_30.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_517_37 = manager.ui.mainCamera.transform.position - var_517_30.position

				var_517_30.forward = Vector3.New(var_517_37.x, var_517_37.y, var_517_37.z)

				local var_517_38 = var_517_30.localEulerAngles

				var_517_38.z = 0
				var_517_38.x = 0
				var_517_30.localEulerAngles = var_517_38
			end

			local var_517_39 = arg_514_1.actors_["1015ui_story"]
			local var_517_40 = 0

			if var_517_40 < arg_514_1.time_ and arg_514_1.time_ <= var_517_40 + arg_517_0 and not isNil(var_517_39) and arg_514_1.var_.characterEffect1015ui_story == nil then
				arg_514_1.var_.characterEffect1015ui_story = var_517_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_41 = 0.200000002980232

			if var_517_40 <= arg_514_1.time_ and arg_514_1.time_ < var_517_40 + var_517_41 and not isNil(var_517_39) then
				local var_517_42 = (arg_514_1.time_ - var_517_40) / var_517_41

				if arg_514_1.var_.characterEffect1015ui_story and not isNil(var_517_39) then
					arg_514_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= var_517_40 + var_517_41 and arg_514_1.time_ < var_517_40 + var_517_41 + arg_517_0 and not isNil(var_517_39) and arg_514_1.var_.characterEffect1015ui_story then
				arg_514_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_517_43 = 0

			if var_517_43 < arg_514_1.time_ and arg_514_1.time_ <= var_517_43 + arg_517_0 then
				arg_514_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_517_44 = 0

			if var_517_44 < arg_514_1.time_ and arg_514_1.time_ <= var_517_44 + arg_517_0 then
				arg_514_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_517_45 = 0
			local var_517_46 = 0.35

			if var_517_45 < arg_514_1.time_ and arg_514_1.time_ <= var_517_45 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				local var_517_47 = arg_514_1:FormatText(StoryNameCfg[479].name)

				arg_514_1.leftNameTxt_.text = var_517_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_48 = arg_514_1:GetWordFromCfg(317012124)
				local var_517_49 = arg_514_1:FormatText(var_517_48.content)

				arg_514_1.text_.text = var_517_49

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_50 = 14
				local var_517_51 = utf8.len(var_517_49)
				local var_517_52 = var_517_50 <= 0 and var_517_46 or var_517_46 * (var_517_51 / var_517_50)

				if var_517_52 > 0 and var_517_46 < var_517_52 then
					arg_514_1.talkMaxDuration = var_517_52

					if var_517_52 + var_517_45 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_52 + var_517_45
					end
				end

				arg_514_1.text_.text = var_517_49
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012124", "story_v_out_317012.awb") ~= 0 then
					local var_517_53 = manager.audio:GetVoiceLength("story_v_out_317012", "317012124", "story_v_out_317012.awb") / 1000

					if var_517_53 + var_517_45 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_53 + var_517_45
					end

					if var_517_48.prefab_name ~= "" and arg_514_1.actors_[var_517_48.prefab_name] ~= nil then
						local var_517_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_48.prefab_name].transform, "story_v_out_317012", "317012124", "story_v_out_317012.awb")

						arg_514_1:RecordAudio("317012124", var_517_54)
						arg_514_1:RecordAudio("317012124", var_517_54)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_317012", "317012124", "story_v_out_317012.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_317012", "317012124", "story_v_out_317012.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_55 = math.max(var_517_46, arg_514_1.talkMaxDuration)

			if var_517_45 <= arg_514_1.time_ and arg_514_1.time_ < var_517_45 + var_517_55 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_45) / var_517_55

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_45 + var_517_55 and arg_514_1.time_ < var_517_45 + var_517_55 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
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

		arg_514_1:InitPlayNodeList()
	end,
	Play317012125 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 317012125
		arg_518_1.duration_ = 5

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play317012126(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = arg_518_1.actors_["2078ui_story"].transform
			local var_521_1 = 0

			if var_521_1 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 then
				arg_518_1.var_.moveOldPos2078ui_story = var_521_0.localPosition
			end

			local var_521_2 = 0.001

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_2 then
				local var_521_3 = (arg_518_1.time_ - var_521_1) / var_521_2
				local var_521_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_521_0.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos2078ui_story, var_521_4, var_521_3)

				local var_521_5 = manager.ui.mainCamera.transform.position - var_521_0.position

				var_521_0.forward = Vector3.New(var_521_5.x, var_521_5.y, var_521_5.z)

				local var_521_6 = var_521_0.localEulerAngles

				var_521_6.z = 0
				var_521_6.x = 0
				var_521_0.localEulerAngles = var_521_6
			end

			if arg_518_1.time_ >= var_521_1 + var_521_2 and arg_518_1.time_ < var_521_1 + var_521_2 + arg_521_0 then
				var_521_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_521_7 = manager.ui.mainCamera.transform.position - var_521_0.position

				var_521_0.forward = Vector3.New(var_521_7.x, var_521_7.y, var_521_7.z)

				local var_521_8 = var_521_0.localEulerAngles

				var_521_8.z = 0
				var_521_8.x = 0
				var_521_0.localEulerAngles = var_521_8
			end

			local var_521_9 = arg_518_1.actors_["2078ui_story"]
			local var_521_10 = 0

			if var_521_10 < arg_518_1.time_ and arg_518_1.time_ <= var_521_10 + arg_521_0 and not isNil(var_521_9) and arg_518_1.var_.characterEffect2078ui_story == nil then
				arg_518_1.var_.characterEffect2078ui_story = var_521_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_11 = 0.200000002980232

			if var_521_10 <= arg_518_1.time_ and arg_518_1.time_ < var_521_10 + var_521_11 and not isNil(var_521_9) then
				local var_521_12 = (arg_518_1.time_ - var_521_10) / var_521_11

				if arg_518_1.var_.characterEffect2078ui_story and not isNil(var_521_9) then
					local var_521_13 = Mathf.Lerp(0, 0.5, var_521_12)

					arg_518_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_518_1.var_.characterEffect2078ui_story.fillRatio = var_521_13
				end
			end

			if arg_518_1.time_ >= var_521_10 + var_521_11 and arg_518_1.time_ < var_521_10 + var_521_11 + arg_521_0 and not isNil(var_521_9) and arg_518_1.var_.characterEffect2078ui_story then
				local var_521_14 = 0.5

				arg_518_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_518_1.var_.characterEffect2078ui_story.fillRatio = var_521_14
			end

			local var_521_15 = arg_518_1.actors_["2079ui_story"].transform
			local var_521_16 = 0

			if var_521_16 < arg_518_1.time_ and arg_518_1.time_ <= var_521_16 + arg_521_0 then
				arg_518_1.var_.moveOldPos2079ui_story = var_521_15.localPosition
			end

			local var_521_17 = 0.001

			if var_521_16 <= arg_518_1.time_ and arg_518_1.time_ < var_521_16 + var_521_17 then
				local var_521_18 = (arg_518_1.time_ - var_521_16) / var_521_17
				local var_521_19 = Vector3.New(0.7, -1.28, -5.6)

				var_521_15.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos2079ui_story, var_521_19, var_521_18)

				local var_521_20 = manager.ui.mainCamera.transform.position - var_521_15.position

				var_521_15.forward = Vector3.New(var_521_20.x, var_521_20.y, var_521_20.z)

				local var_521_21 = var_521_15.localEulerAngles

				var_521_21.z = 0
				var_521_21.x = 0
				var_521_15.localEulerAngles = var_521_21
			end

			if arg_518_1.time_ >= var_521_16 + var_521_17 and arg_518_1.time_ < var_521_16 + var_521_17 + arg_521_0 then
				var_521_15.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_521_22 = manager.ui.mainCamera.transform.position - var_521_15.position

				var_521_15.forward = Vector3.New(var_521_22.x, var_521_22.y, var_521_22.z)

				local var_521_23 = var_521_15.localEulerAngles

				var_521_23.z = 0
				var_521_23.x = 0
				var_521_15.localEulerAngles = var_521_23
			end

			local var_521_24 = arg_518_1.actors_["2079ui_story"]
			local var_521_25 = 0

			if var_521_25 < arg_518_1.time_ and arg_518_1.time_ <= var_521_25 + arg_521_0 and not isNil(var_521_24) and arg_518_1.var_.characterEffect2079ui_story == nil then
				arg_518_1.var_.characterEffect2079ui_story = var_521_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_26 = 0.200000002980232

			if var_521_25 <= arg_518_1.time_ and arg_518_1.time_ < var_521_25 + var_521_26 and not isNil(var_521_24) then
				local var_521_27 = (arg_518_1.time_ - var_521_25) / var_521_26

				if arg_518_1.var_.characterEffect2079ui_story and not isNil(var_521_24) then
					local var_521_28 = Mathf.Lerp(0, 0.5, var_521_27)

					arg_518_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_518_1.var_.characterEffect2079ui_story.fillRatio = var_521_28
				end
			end

			if arg_518_1.time_ >= var_521_25 + var_521_26 and arg_518_1.time_ < var_521_25 + var_521_26 + arg_521_0 and not isNil(var_521_24) and arg_518_1.var_.characterEffect2079ui_story then
				local var_521_29 = 0.5

				arg_518_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_518_1.var_.characterEffect2079ui_story.fillRatio = var_521_29
			end

			local var_521_30 = arg_518_1.actors_["1015ui_story"].transform
			local var_521_31 = 0

			if var_521_31 < arg_518_1.time_ and arg_518_1.time_ <= var_521_31 + arg_521_0 then
				arg_518_1.var_.moveOldPos1015ui_story = var_521_30.localPosition
			end

			local var_521_32 = 0.001

			if var_521_31 <= arg_518_1.time_ and arg_518_1.time_ < var_521_31 + var_521_32 then
				local var_521_33 = (arg_518_1.time_ - var_521_31) / var_521_32
				local var_521_34 = Vector3.New(0, 100, 0)

				var_521_30.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos1015ui_story, var_521_34, var_521_33)

				local var_521_35 = manager.ui.mainCamera.transform.position - var_521_30.position

				var_521_30.forward = Vector3.New(var_521_35.x, var_521_35.y, var_521_35.z)

				local var_521_36 = var_521_30.localEulerAngles

				var_521_36.z = 0
				var_521_36.x = 0
				var_521_30.localEulerAngles = var_521_36
			end

			if arg_518_1.time_ >= var_521_31 + var_521_32 and arg_518_1.time_ < var_521_31 + var_521_32 + arg_521_0 then
				var_521_30.localPosition = Vector3.New(0, 100, 0)

				local var_521_37 = manager.ui.mainCamera.transform.position - var_521_30.position

				var_521_30.forward = Vector3.New(var_521_37.x, var_521_37.y, var_521_37.z)

				local var_521_38 = var_521_30.localEulerAngles

				var_521_38.z = 0
				var_521_38.x = 0
				var_521_30.localEulerAngles = var_521_38
			end

			local var_521_39 = arg_518_1.actors_["1015ui_story"]
			local var_521_40 = 0

			if var_521_40 < arg_518_1.time_ and arg_518_1.time_ <= var_521_40 + arg_521_0 and not isNil(var_521_39) and arg_518_1.var_.characterEffect1015ui_story == nil then
				arg_518_1.var_.characterEffect1015ui_story = var_521_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_41 = 0.200000002980232

			if var_521_40 <= arg_518_1.time_ and arg_518_1.time_ < var_521_40 + var_521_41 and not isNil(var_521_39) then
				local var_521_42 = (arg_518_1.time_ - var_521_40) / var_521_41

				if arg_518_1.var_.characterEffect1015ui_story and not isNil(var_521_39) then
					local var_521_43 = Mathf.Lerp(0, 0.5, var_521_42)

					arg_518_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_518_1.var_.characterEffect1015ui_story.fillRatio = var_521_43
				end
			end

			if arg_518_1.time_ >= var_521_40 + var_521_41 and arg_518_1.time_ < var_521_40 + var_521_41 + arg_521_0 and not isNil(var_521_39) and arg_518_1.var_.characterEffect1015ui_story then
				local var_521_44 = 0.5

				arg_518_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_518_1.var_.characterEffect1015ui_story.fillRatio = var_521_44
			end

			local var_521_45 = 0
			local var_521_46 = 1.475

			if var_521_45 < arg_518_1.time_ and arg_518_1.time_ <= var_521_45 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, false)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_47 = arg_518_1:GetWordFromCfg(317012125)
				local var_521_48 = arg_518_1:FormatText(var_521_47.content)

				arg_518_1.text_.text = var_521_48

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_49 = 59
				local var_521_50 = utf8.len(var_521_48)
				local var_521_51 = var_521_49 <= 0 and var_521_46 or var_521_46 * (var_521_50 / var_521_49)

				if var_521_51 > 0 and var_521_46 < var_521_51 then
					arg_518_1.talkMaxDuration = var_521_51

					if var_521_51 + var_521_45 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_51 + var_521_45
					end
				end

				arg_518_1.text_.text = var_521_48
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)
				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_52 = math.max(var_521_46, arg_518_1.talkMaxDuration)

			if var_521_45 <= arg_518_1.time_ and arg_518_1.time_ < var_521_45 + var_521_52 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_45) / var_521_52

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_45 + var_521_52 and arg_518_1.time_ < var_521_45 + var_521_52 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
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

		arg_518_1:InitPlayNodeList()
	end,
	Play317012126 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 317012126
		arg_522_1.duration_ = 9.53

		local var_522_0 = {
			zh = 9.533,
			ja = 9.366
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play317012127(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = arg_522_1.actors_["2078ui_story"].transform
			local var_525_1 = 0

			if var_525_1 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 then
				arg_522_1.var_.moveOldPos2078ui_story = var_525_0.localPosition
			end

			local var_525_2 = 0.001

			if var_525_1 <= arg_522_1.time_ and arg_522_1.time_ < var_525_1 + var_525_2 then
				local var_525_3 = (arg_522_1.time_ - var_525_1) / var_525_2
				local var_525_4 = Vector3.New(0, 100, 0)

				var_525_0.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPos2078ui_story, var_525_4, var_525_3)

				local var_525_5 = manager.ui.mainCamera.transform.position - var_525_0.position

				var_525_0.forward = Vector3.New(var_525_5.x, var_525_5.y, var_525_5.z)

				local var_525_6 = var_525_0.localEulerAngles

				var_525_6.z = 0
				var_525_6.x = 0
				var_525_0.localEulerAngles = var_525_6
			end

			if arg_522_1.time_ >= var_525_1 + var_525_2 and arg_522_1.time_ < var_525_1 + var_525_2 + arg_525_0 then
				var_525_0.localPosition = Vector3.New(0, 100, 0)

				local var_525_7 = manager.ui.mainCamera.transform.position - var_525_0.position

				var_525_0.forward = Vector3.New(var_525_7.x, var_525_7.y, var_525_7.z)

				local var_525_8 = var_525_0.localEulerAngles

				var_525_8.z = 0
				var_525_8.x = 0
				var_525_0.localEulerAngles = var_525_8
			end

			local var_525_9 = arg_522_1.actors_["2078ui_story"]
			local var_525_10 = 0

			if var_525_10 < arg_522_1.time_ and arg_522_1.time_ <= var_525_10 + arg_525_0 and not isNil(var_525_9) and arg_522_1.var_.characterEffect2078ui_story == nil then
				arg_522_1.var_.characterEffect2078ui_story = var_525_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_11 = 0.200000002980232

			if var_525_10 <= arg_522_1.time_ and arg_522_1.time_ < var_525_10 + var_525_11 and not isNil(var_525_9) then
				local var_525_12 = (arg_522_1.time_ - var_525_10) / var_525_11

				if arg_522_1.var_.characterEffect2078ui_story and not isNil(var_525_9) then
					local var_525_13 = Mathf.Lerp(0, 0.5, var_525_12)

					arg_522_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_522_1.var_.characterEffect2078ui_story.fillRatio = var_525_13
				end
			end

			if arg_522_1.time_ >= var_525_10 + var_525_11 and arg_522_1.time_ < var_525_10 + var_525_11 + arg_525_0 and not isNil(var_525_9) and arg_522_1.var_.characterEffect2078ui_story then
				local var_525_14 = 0.5

				arg_522_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_522_1.var_.characterEffect2078ui_story.fillRatio = var_525_14
			end

			local var_525_15 = arg_522_1.actors_["2079ui_story"].transform
			local var_525_16 = 0

			if var_525_16 < arg_522_1.time_ and arg_522_1.time_ <= var_525_16 + arg_525_0 then
				arg_522_1.var_.moveOldPos2079ui_story = var_525_15.localPosition
			end

			local var_525_17 = 0.001

			if var_525_16 <= arg_522_1.time_ and arg_522_1.time_ < var_525_16 + var_525_17 then
				local var_525_18 = (arg_522_1.time_ - var_525_16) / var_525_17
				local var_525_19 = Vector3.New(0, 100, 0)

				var_525_15.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPos2079ui_story, var_525_19, var_525_18)

				local var_525_20 = manager.ui.mainCamera.transform.position - var_525_15.position

				var_525_15.forward = Vector3.New(var_525_20.x, var_525_20.y, var_525_20.z)

				local var_525_21 = var_525_15.localEulerAngles

				var_525_21.z = 0
				var_525_21.x = 0
				var_525_15.localEulerAngles = var_525_21
			end

			if arg_522_1.time_ >= var_525_16 + var_525_17 and arg_522_1.time_ < var_525_16 + var_525_17 + arg_525_0 then
				var_525_15.localPosition = Vector3.New(0, 100, 0)

				local var_525_22 = manager.ui.mainCamera.transform.position - var_525_15.position

				var_525_15.forward = Vector3.New(var_525_22.x, var_525_22.y, var_525_22.z)

				local var_525_23 = var_525_15.localEulerAngles

				var_525_23.z = 0
				var_525_23.x = 0
				var_525_15.localEulerAngles = var_525_23
			end

			local var_525_24 = arg_522_1.actors_["2079ui_story"]
			local var_525_25 = 0

			if var_525_25 < arg_522_1.time_ and arg_522_1.time_ <= var_525_25 + arg_525_0 and not isNil(var_525_24) and arg_522_1.var_.characterEffect2079ui_story == nil then
				arg_522_1.var_.characterEffect2079ui_story = var_525_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_26 = 0.200000002980232

			if var_525_25 <= arg_522_1.time_ and arg_522_1.time_ < var_525_25 + var_525_26 and not isNil(var_525_24) then
				local var_525_27 = (arg_522_1.time_ - var_525_25) / var_525_26

				if arg_522_1.var_.characterEffect2079ui_story and not isNil(var_525_24) then
					local var_525_28 = Mathf.Lerp(0, 0.5, var_525_27)

					arg_522_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_522_1.var_.characterEffect2079ui_story.fillRatio = var_525_28
				end
			end

			if arg_522_1.time_ >= var_525_25 + var_525_26 and arg_522_1.time_ < var_525_25 + var_525_26 + arg_525_0 and not isNil(var_525_24) and arg_522_1.var_.characterEffect2079ui_story then
				local var_525_29 = 0.5

				arg_522_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_522_1.var_.characterEffect2079ui_story.fillRatio = var_525_29
			end

			local var_525_30 = arg_522_1.actors_["1015ui_story"].transform
			local var_525_31 = 0

			if var_525_31 < arg_522_1.time_ and arg_522_1.time_ <= var_525_31 + arg_525_0 then
				arg_522_1.var_.moveOldPos1015ui_story = var_525_30.localPosition
			end

			local var_525_32 = 0.001

			if var_525_31 <= arg_522_1.time_ and arg_522_1.time_ < var_525_31 + var_525_32 then
				local var_525_33 = (arg_522_1.time_ - var_525_31) / var_525_32
				local var_525_34 = Vector3.New(0, -1.15, -6.2)

				var_525_30.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPos1015ui_story, var_525_34, var_525_33)

				local var_525_35 = manager.ui.mainCamera.transform.position - var_525_30.position

				var_525_30.forward = Vector3.New(var_525_35.x, var_525_35.y, var_525_35.z)

				local var_525_36 = var_525_30.localEulerAngles

				var_525_36.z = 0
				var_525_36.x = 0
				var_525_30.localEulerAngles = var_525_36
			end

			if arg_522_1.time_ >= var_525_31 + var_525_32 and arg_522_1.time_ < var_525_31 + var_525_32 + arg_525_0 then
				var_525_30.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_525_37 = manager.ui.mainCamera.transform.position - var_525_30.position

				var_525_30.forward = Vector3.New(var_525_37.x, var_525_37.y, var_525_37.z)

				local var_525_38 = var_525_30.localEulerAngles

				var_525_38.z = 0
				var_525_38.x = 0
				var_525_30.localEulerAngles = var_525_38
			end

			local var_525_39 = arg_522_1.actors_["1015ui_story"]
			local var_525_40 = 0

			if var_525_40 < arg_522_1.time_ and arg_522_1.time_ <= var_525_40 + arg_525_0 and not isNil(var_525_39) and arg_522_1.var_.characterEffect1015ui_story == nil then
				arg_522_1.var_.characterEffect1015ui_story = var_525_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_41 = 0.200000002980232

			if var_525_40 <= arg_522_1.time_ and arg_522_1.time_ < var_525_40 + var_525_41 and not isNil(var_525_39) then
				local var_525_42 = (arg_522_1.time_ - var_525_40) / var_525_41

				if arg_522_1.var_.characterEffect1015ui_story and not isNil(var_525_39) then
					arg_522_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_522_1.time_ >= var_525_40 + var_525_41 and arg_522_1.time_ < var_525_40 + var_525_41 + arg_525_0 and not isNil(var_525_39) and arg_522_1.var_.characterEffect1015ui_story then
				arg_522_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_525_43 = 0

			if var_525_43 < arg_522_1.time_ and arg_522_1.time_ <= var_525_43 + arg_525_0 then
				arg_522_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_525_44 = 0

			if var_525_44 < arg_522_1.time_ and arg_522_1.time_ <= var_525_44 + arg_525_0 then
				arg_522_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_525_45 = 0
			local var_525_46 = 1.05

			if var_525_45 < arg_522_1.time_ and arg_522_1.time_ <= var_525_45 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_47 = arg_522_1:FormatText(StoryNameCfg[479].name)

				arg_522_1.leftNameTxt_.text = var_525_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_48 = arg_522_1:GetWordFromCfg(317012126)
				local var_525_49 = arg_522_1:FormatText(var_525_48.content)

				arg_522_1.text_.text = var_525_49

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_50 = 42
				local var_525_51 = utf8.len(var_525_49)
				local var_525_52 = var_525_50 <= 0 and var_525_46 or var_525_46 * (var_525_51 / var_525_50)

				if var_525_52 > 0 and var_525_46 < var_525_52 then
					arg_522_1.talkMaxDuration = var_525_52

					if var_525_52 + var_525_45 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_52 + var_525_45
					end
				end

				arg_522_1.text_.text = var_525_49
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012126", "story_v_out_317012.awb") ~= 0 then
					local var_525_53 = manager.audio:GetVoiceLength("story_v_out_317012", "317012126", "story_v_out_317012.awb") / 1000

					if var_525_53 + var_525_45 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_53 + var_525_45
					end

					if var_525_48.prefab_name ~= "" and arg_522_1.actors_[var_525_48.prefab_name] ~= nil then
						local var_525_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_48.prefab_name].transform, "story_v_out_317012", "317012126", "story_v_out_317012.awb")

						arg_522_1:RecordAudio("317012126", var_525_54)
						arg_522_1:RecordAudio("317012126", var_525_54)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_317012", "317012126", "story_v_out_317012.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_317012", "317012126", "story_v_out_317012.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_55 = math.max(var_525_46, arg_522_1.talkMaxDuration)

			if var_525_45 <= arg_522_1.time_ and arg_522_1.time_ < var_525_45 + var_525_55 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_45) / var_525_55

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_45 + var_525_55 and arg_522_1.time_ < var_525_45 + var_525_55 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
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

		arg_522_1:InitPlayNodeList()
	end,
	Play317012127 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 317012127
		arg_526_1.duration_ = 1.3

		local var_526_0 = {
			zh = 1.133,
			ja = 1.3
		}
		local var_526_1 = manager.audio:GetLocalizationFlag()

		if var_526_0[var_526_1] ~= nil then
			arg_526_1.duration_ = var_526_0[var_526_1]
		end

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
			arg_526_1.auto_ = false
		end

		function arg_526_1.playNext_(arg_528_0)
			arg_526_1.onStoryFinished_()
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = arg_526_1.actors_["2078ui_story"].transform
			local var_529_1 = 0

			if var_529_1 < arg_526_1.time_ and arg_526_1.time_ <= var_529_1 + arg_529_0 then
				arg_526_1.var_.moveOldPos2078ui_story = var_529_0.localPosition
			end

			local var_529_2 = 0.001

			if var_529_1 <= arg_526_1.time_ and arg_526_1.time_ < var_529_1 + var_529_2 then
				local var_529_3 = (arg_526_1.time_ - var_529_1) / var_529_2
				local var_529_4 = Vector3.New(0, -1.28, -5.6)

				var_529_0.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos2078ui_story, var_529_4, var_529_3)

				local var_529_5 = manager.ui.mainCamera.transform.position - var_529_0.position

				var_529_0.forward = Vector3.New(var_529_5.x, var_529_5.y, var_529_5.z)

				local var_529_6 = var_529_0.localEulerAngles

				var_529_6.z = 0
				var_529_6.x = 0
				var_529_0.localEulerAngles = var_529_6
			end

			if arg_526_1.time_ >= var_529_1 + var_529_2 and arg_526_1.time_ < var_529_1 + var_529_2 + arg_529_0 then
				var_529_0.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_529_7 = manager.ui.mainCamera.transform.position - var_529_0.position

				var_529_0.forward = Vector3.New(var_529_7.x, var_529_7.y, var_529_7.z)

				local var_529_8 = var_529_0.localEulerAngles

				var_529_8.z = 0
				var_529_8.x = 0
				var_529_0.localEulerAngles = var_529_8
			end

			local var_529_9 = arg_526_1.actors_["2078ui_story"]
			local var_529_10 = 0

			if var_529_10 < arg_526_1.time_ and arg_526_1.time_ <= var_529_10 + arg_529_0 and not isNil(var_529_9) and arg_526_1.var_.characterEffect2078ui_story == nil then
				arg_526_1.var_.characterEffect2078ui_story = var_529_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_11 = 0.200000002980232

			if var_529_10 <= arg_526_1.time_ and arg_526_1.time_ < var_529_10 + var_529_11 and not isNil(var_529_9) then
				local var_529_12 = (arg_526_1.time_ - var_529_10) / var_529_11

				if arg_526_1.var_.characterEffect2078ui_story and not isNil(var_529_9) then
					arg_526_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_526_1.time_ >= var_529_10 + var_529_11 and arg_526_1.time_ < var_529_10 + var_529_11 + arg_529_0 and not isNil(var_529_9) and arg_526_1.var_.characterEffect2078ui_story then
				arg_526_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_529_13 = 0

			if var_529_13 < arg_526_1.time_ and arg_526_1.time_ <= var_529_13 + arg_529_0 then
				arg_526_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_529_14 = 0

			if var_529_14 < arg_526_1.time_ and arg_526_1.time_ <= var_529_14 + arg_529_0 then
				arg_526_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_529_15 = arg_526_1.actors_["1015ui_story"].transform
			local var_529_16 = 0

			if var_529_16 < arg_526_1.time_ and arg_526_1.time_ <= var_529_16 + arg_529_0 then
				arg_526_1.var_.moveOldPos1015ui_story = var_529_15.localPosition
			end

			local var_529_17 = 0.001

			if var_529_16 <= arg_526_1.time_ and arg_526_1.time_ < var_529_16 + var_529_17 then
				local var_529_18 = (arg_526_1.time_ - var_529_16) / var_529_17
				local var_529_19 = Vector3.New(0, 100, 0)

				var_529_15.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos1015ui_story, var_529_19, var_529_18)

				local var_529_20 = manager.ui.mainCamera.transform.position - var_529_15.position

				var_529_15.forward = Vector3.New(var_529_20.x, var_529_20.y, var_529_20.z)

				local var_529_21 = var_529_15.localEulerAngles

				var_529_21.z = 0
				var_529_21.x = 0
				var_529_15.localEulerAngles = var_529_21
			end

			if arg_526_1.time_ >= var_529_16 + var_529_17 and arg_526_1.time_ < var_529_16 + var_529_17 + arg_529_0 then
				var_529_15.localPosition = Vector3.New(0, 100, 0)

				local var_529_22 = manager.ui.mainCamera.transform.position - var_529_15.position

				var_529_15.forward = Vector3.New(var_529_22.x, var_529_22.y, var_529_22.z)

				local var_529_23 = var_529_15.localEulerAngles

				var_529_23.z = 0
				var_529_23.x = 0
				var_529_15.localEulerAngles = var_529_23
			end

			local var_529_24 = arg_526_1.actors_["1015ui_story"]
			local var_529_25 = 0

			if var_529_25 < arg_526_1.time_ and arg_526_1.time_ <= var_529_25 + arg_529_0 and not isNil(var_529_24) and arg_526_1.var_.characterEffect1015ui_story == nil then
				arg_526_1.var_.characterEffect1015ui_story = var_529_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_26 = 0.200000002980232

			if var_529_25 <= arg_526_1.time_ and arg_526_1.time_ < var_529_25 + var_529_26 and not isNil(var_529_24) then
				local var_529_27 = (arg_526_1.time_ - var_529_25) / var_529_26

				if arg_526_1.var_.characterEffect1015ui_story and not isNil(var_529_24) then
					local var_529_28 = Mathf.Lerp(0, 0.5, var_529_27)

					arg_526_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_526_1.var_.characterEffect1015ui_story.fillRatio = var_529_28
				end
			end

			if arg_526_1.time_ >= var_529_25 + var_529_26 and arg_526_1.time_ < var_529_25 + var_529_26 + arg_529_0 and not isNil(var_529_24) and arg_526_1.var_.characterEffect1015ui_story then
				local var_529_29 = 0.5

				arg_526_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_526_1.var_.characterEffect1015ui_story.fillRatio = var_529_29
			end

			local var_529_30 = 0
			local var_529_31 = 0.1

			if var_529_30 < arg_526_1.time_ and arg_526_1.time_ <= var_529_30 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				local var_529_32 = arg_526_1:FormatText(StoryNameCfg[528].name)

				arg_526_1.leftNameTxt_.text = var_529_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_33 = arg_526_1:GetWordFromCfg(317012127)
				local var_529_34 = arg_526_1:FormatText(var_529_33.content)

				arg_526_1.text_.text = var_529_34

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_35 = 4
				local var_529_36 = utf8.len(var_529_34)
				local var_529_37 = var_529_35 <= 0 and var_529_31 or var_529_31 * (var_529_36 / var_529_35)

				if var_529_37 > 0 and var_529_31 < var_529_37 then
					arg_526_1.talkMaxDuration = var_529_37

					if var_529_37 + var_529_30 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_37 + var_529_30
					end
				end

				arg_526_1.text_.text = var_529_34
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317012", "317012127", "story_v_out_317012.awb") ~= 0 then
					local var_529_38 = manager.audio:GetVoiceLength("story_v_out_317012", "317012127", "story_v_out_317012.awb") / 1000

					if var_529_38 + var_529_30 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_38 + var_529_30
					end

					if var_529_33.prefab_name ~= "" and arg_526_1.actors_[var_529_33.prefab_name] ~= nil then
						local var_529_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_33.prefab_name].transform, "story_v_out_317012", "317012127", "story_v_out_317012.awb")

						arg_526_1:RecordAudio("317012127", var_529_39)
						arg_526_1:RecordAudio("317012127", var_529_39)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_out_317012", "317012127", "story_v_out_317012.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_out_317012", "317012127", "story_v_out_317012.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_40 = math.max(var_529_31, arg_526_1.talkMaxDuration)

			if var_529_30 <= arg_526_1.time_ and arg_526_1.time_ < var_529_30 + var_529_40 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_30) / var_529_40

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_30 + var_529_40 and arg_526_1.time_ < var_529_30 + var_529_40 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_526_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K11f",
		"TextureConfig/Background/K09g",
		"TextureConfig/Background/K09h",
		"TextureConfig/Background/YA0101",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/K02f",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/K06f"
	},
	voices = {
		"story_v_out_317012.awb"
	}
}
