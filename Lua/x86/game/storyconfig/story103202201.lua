return {
	Play320221001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320221001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play320221002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST61"

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
				local var_4_5 = arg_1_1.bgs_.ST61

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
					if iter_4_0 ~= "ST61" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = 0
			local var_4_25 = 0.2

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 0.333333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 0.333333333333333
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_121_04", "se_story_121_04_wind_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_40 = 2
			local var_4_41 = 1.3

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_43 = arg_1_1:GetWordFromCfg(320221001)
				local var_4_44 = arg_1_1:FormatText(var_4_43.content)

				arg_1_1.text_.text = var_4_44

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_45 = 52
				local var_4_46 = utf8.len(var_4_44)
				local var_4_47 = var_4_45 <= 0 and var_4_41 or var_4_41 * (var_4_46 / var_4_45)

				if var_4_47 > 0 and var_4_41 < var_4_47 then
					arg_1_1.talkMaxDuration = var_4_47
					var_4_40 = var_4_40 + 0.3

					if var_4_47 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_40
					end
				end

				arg_1_1.text_.text = var_4_44
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_48 = var_4_40 + 0.3
			local var_4_49 = math.max(var_4_41, arg_1_1.talkMaxDuration)

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_49 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_48) / var_4_49

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play320221002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 320221002
		arg_9_1.duration_ = 5.2

		local var_9_0 = {
			zh = 3.966,
			ja = 5.2
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
				arg_9_0:Play320221003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1011ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1011ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1011ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -0.71, -6)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1011ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -0.71, -6)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["1011ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1011ui_story == nil then
				arg_9_1.var_.characterEffect1011ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect1011ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1011ui_story then
				arg_9_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_12_20 = 0
			local var_12_21 = 0.4

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[37].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(320221002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221002", "story_v_out_320221.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_320221", "320221002", "story_v_out_320221.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_320221", "320221002", "story_v_out_320221.awb")

						arg_9_1:RecordAudio("320221002", var_12_29)
						arg_9_1:RecordAudio("320221002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_320221", "320221002", "story_v_out_320221.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_320221", "320221002", "story_v_out_320221.awb")
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
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play320221003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 320221003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play320221004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1011ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1011ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, 100, 0)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1011ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, 100, 0)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = arg_13_1.actors_["1011ui_story"]
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1011ui_story == nil then
				arg_13_1.var_.characterEffect1011ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 and not isNil(var_16_9) then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / var_16_11

				if arg_13_1.var_.characterEffect1011ui_story and not isNil(var_16_9) then
					local var_16_13 = Mathf.Lerp(0, 0.5, var_16_12)

					arg_13_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1011ui_story.fillRatio = var_16_13
				end
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1011ui_story then
				local var_16_14 = 0.5

				arg_13_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1011ui_story.fillRatio = var_16_14
			end

			local var_16_15 = 0
			local var_16_16 = 1.625

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_17 = arg_13_1:GetWordFromCfg(320221003)
				local var_16_18 = arg_13_1:FormatText(var_16_17.content)

				arg_13_1.text_.text = var_16_18

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_19 = 65
				local var_16_20 = utf8.len(var_16_18)
				local var_16_21 = var_16_19 <= 0 and var_16_16 or var_16_16 * (var_16_20 / var_16_19)

				if var_16_21 > 0 and var_16_16 < var_16_21 then
					arg_13_1.talkMaxDuration = var_16_21

					if var_16_21 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_21 + var_16_15
					end
				end

				arg_13_1.text_.text = var_16_18
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_22 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_22 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_22

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_22 and arg_13_1.time_ < var_16_15 + var_16_22 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play320221004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 320221004
		arg_17_1.duration_ = 4.93

		local var_17_0 = {
			zh = 4.566,
			ja = 4.933
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
				arg_17_0:Play320221005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1011ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1011ui_story == nil then
				arg_17_1.var_.characterEffect1011ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1011ui_story and not isNil(var_20_0) then
					arg_17_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1011ui_story then
				arg_17_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_20_4 = arg_17_1.actors_["1011ui_story"].transform
			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.var_.moveOldPos1011ui_story = var_20_4.localPosition
			end

			local var_20_6 = 0.001

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_6 then
				local var_20_7 = (arg_17_1.time_ - var_20_5) / var_20_6
				local var_20_8 = Vector3.New(0, -0.71, -6)

				var_20_4.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1011ui_story, var_20_8, var_20_7)

				local var_20_9 = manager.ui.mainCamera.transform.position - var_20_4.position

				var_20_4.forward = Vector3.New(var_20_9.x, var_20_9.y, var_20_9.z)

				local var_20_10 = var_20_4.localEulerAngles

				var_20_10.z = 0
				var_20_10.x = 0
				var_20_4.localEulerAngles = var_20_10
			end

			if arg_17_1.time_ >= var_20_5 + var_20_6 and arg_17_1.time_ < var_20_5 + var_20_6 + arg_20_0 then
				var_20_4.localPosition = Vector3.New(0, -0.71, -6)

				local var_20_11 = manager.ui.mainCamera.transform.position - var_20_4.position

				var_20_4.forward = Vector3.New(var_20_11.x, var_20_11.y, var_20_11.z)

				local var_20_12 = var_20_4.localEulerAngles

				var_20_12.z = 0
				var_20_12.x = 0
				var_20_4.localEulerAngles = var_20_12
			end

			local var_20_13 = 0
			local var_20_14 = 0.4

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_15 = arg_17_1:FormatText(StoryNameCfg[37].name)

				arg_17_1.leftNameTxt_.text = var_20_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_16 = arg_17_1:GetWordFromCfg(320221004)
				local var_20_17 = arg_17_1:FormatText(var_20_16.content)

				arg_17_1.text_.text = var_20_17

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_18 = 16
				local var_20_19 = utf8.len(var_20_17)
				local var_20_20 = var_20_18 <= 0 and var_20_14 or var_20_14 * (var_20_19 / var_20_18)

				if var_20_20 > 0 and var_20_14 < var_20_20 then
					arg_17_1.talkMaxDuration = var_20_20

					if var_20_20 + var_20_13 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_20 + var_20_13
					end
				end

				arg_17_1.text_.text = var_20_17
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221004", "story_v_out_320221.awb") ~= 0 then
					local var_20_21 = manager.audio:GetVoiceLength("story_v_out_320221", "320221004", "story_v_out_320221.awb") / 1000

					if var_20_21 + var_20_13 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_21 + var_20_13
					end

					if var_20_16.prefab_name ~= "" and arg_17_1.actors_[var_20_16.prefab_name] ~= nil then
						local var_20_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_16.prefab_name].transform, "story_v_out_320221", "320221004", "story_v_out_320221.awb")

						arg_17_1:RecordAudio("320221004", var_20_22)
						arg_17_1:RecordAudio("320221004", var_20_22)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_320221", "320221004", "story_v_out_320221.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_320221", "320221004", "story_v_out_320221.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_23 = math.max(var_20_14, arg_17_1.talkMaxDuration)

			if var_20_13 <= arg_17_1.time_ and arg_17_1.time_ < var_20_13 + var_20_23 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_13) / var_20_23

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_13 + var_20_23 and arg_17_1.time_ < var_20_13 + var_20_23 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play320221005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 320221005
		arg_21_1.duration_ = 6.73

		local var_21_0 = {
			zh = 6.4,
			ja = 6.733
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
				arg_21_0:Play320221006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action435")
			end

			local var_24_1 = 0
			local var_24_2 = 0.55

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_3 = arg_21_1:FormatText(StoryNameCfg[37].name)

				arg_21_1.leftNameTxt_.text = var_24_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(320221005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221005", "story_v_out_320221.awb") ~= 0 then
					local var_24_9 = manager.audio:GetVoiceLength("story_v_out_320221", "320221005", "story_v_out_320221.awb") / 1000

					if var_24_9 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_1
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_320221", "320221005", "story_v_out_320221.awb")

						arg_21_1:RecordAudio("320221005", var_24_10)
						arg_21_1:RecordAudio("320221005", var_24_10)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_320221", "320221005", "story_v_out_320221.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_320221", "320221005", "story_v_out_320221.awb")
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
	Play320221006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 320221006
		arg_25_1.duration_ = 11.2

		local var_25_0 = {
			zh = 4.766,
			ja = 11.2
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
				arg_25_0:Play320221007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1011ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1011ui_story == nil then
				arg_25_1.var_.characterEffect1011ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1011ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1011ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1011ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1011ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 0.625

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[67].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_9 = arg_25_1:GetWordFromCfg(320221006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 25
				local var_28_12 = utf8.len(var_28_10)
				local var_28_13 = var_28_11 <= 0 and var_28_7 or var_28_7 * (var_28_12 / var_28_11)

				if var_28_13 > 0 and var_28_7 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221006", "story_v_out_320221.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_320221", "320221006", "story_v_out_320221.awb") / 1000

					if var_28_14 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_6
					end

					if var_28_9.prefab_name ~= "" and arg_25_1.actors_[var_28_9.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_9.prefab_name].transform, "story_v_out_320221", "320221006", "story_v_out_320221.awb")

						arg_25_1:RecordAudio("320221006", var_28_15)
						arg_25_1:RecordAudio("320221006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_320221", "320221006", "story_v_out_320221.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_320221", "320221006", "story_v_out_320221.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_16 and arg_25_1.time_ < var_28_6 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play320221007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 320221007
		arg_29_1.duration_ = 10.37

		local var_29_0 = {
			zh = 7.733,
			ja = 10.366
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
				arg_29_0:Play320221008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1.025

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[67].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(320221007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 41
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221007", "story_v_out_320221.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221007", "story_v_out_320221.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_320221", "320221007", "story_v_out_320221.awb")

						arg_29_1:RecordAudio("320221007", var_32_9)
						arg_29_1:RecordAudio("320221007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_320221", "320221007", "story_v_out_320221.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_320221", "320221007", "story_v_out_320221.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play320221008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 320221008
		arg_33_1.duration_ = 8.33

		local var_33_0 = {
			zh = 6.433,
			ja = 8.333
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
				arg_33_0:Play320221009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1011ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1011ui_story == nil then
				arg_33_1.var_.characterEffect1011ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1011ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1011ui_story then
				arg_33_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_36_4 = 0

			if var_36_4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_2")
			end

			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_6 = 0
			local var_36_7 = 0.775

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[37].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_9 = arg_33_1:GetWordFromCfg(320221008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 31
				local var_36_12 = utf8.len(var_36_10)
				local var_36_13 = var_36_11 <= 0 and var_36_7 or var_36_7 * (var_36_12 / var_36_11)

				if var_36_13 > 0 and var_36_7 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221008", "story_v_out_320221.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_320221", "320221008", "story_v_out_320221.awb") / 1000

					if var_36_14 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_6
					end

					if var_36_9.prefab_name ~= "" and arg_33_1.actors_[var_36_9.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_9.prefab_name].transform, "story_v_out_320221", "320221008", "story_v_out_320221.awb")

						arg_33_1:RecordAudio("320221008", var_36_15)
						arg_33_1:RecordAudio("320221008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_320221", "320221008", "story_v_out_320221.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_320221", "320221008", "story_v_out_320221.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_16 and arg_33_1.time_ < var_36_6 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play320221009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 320221009
		arg_37_1.duration_ = 8.2

		local var_37_0 = {
			zh = 5.133,
			ja = 8.2
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
				arg_37_0:Play320221010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1011ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1011ui_story == nil then
				arg_37_1.var_.characterEffect1011ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1011ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1011ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1011ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1011ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 0.6

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_8 = arg_37_1:FormatText(StoryNameCfg[67].name)

				arg_37_1.leftNameTxt_.text = var_40_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_9 = arg_37_1:GetWordFromCfg(320221009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 24
				local var_40_12 = utf8.len(var_40_10)
				local var_40_13 = var_40_11 <= 0 and var_40_7 or var_40_7 * (var_40_12 / var_40_11)

				if var_40_13 > 0 and var_40_7 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_10
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221009", "story_v_out_320221.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_320221", "320221009", "story_v_out_320221.awb") / 1000

					if var_40_14 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_6
					end

					if var_40_9.prefab_name ~= "" and arg_37_1.actors_[var_40_9.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_9.prefab_name].transform, "story_v_out_320221", "320221009", "story_v_out_320221.awb")

						arg_37_1:RecordAudio("320221009", var_40_15)
						arg_37_1:RecordAudio("320221009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_320221", "320221009", "story_v_out_320221.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_320221", "320221009", "story_v_out_320221.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_16 and arg_37_1.time_ < var_40_6 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play320221010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 320221010
		arg_41_1.duration_ = 9.1

		local var_41_0 = {
			zh = 8.766,
			ja = 9.1
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
				arg_41_0:Play320221011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.15

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[67].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(320221010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221010", "story_v_out_320221.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221010", "story_v_out_320221.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_320221", "320221010", "story_v_out_320221.awb")

						arg_41_1:RecordAudio("320221010", var_44_9)
						arg_41_1:RecordAudio("320221010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_320221", "320221010", "story_v_out_320221.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_320221", "320221010", "story_v_out_320221.awb")
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
	Play320221011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 320221011
		arg_45_1.duration_ = 6.15

		local var_45_0 = {
			zh = 3.616,
			ja = 6.15
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
				arg_45_0:Play320221012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1011ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1011ui_story == nil then
				arg_45_1.var_.characterEffect1011ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1011ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1011ui_story then
				arg_45_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_48_4 = 0

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_6 = 0.55
			local var_48_7 = 0.45

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_8 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_8:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_9 = arg_45_1:FormatText(StoryNameCfg[37].name)

				arg_45_1.leftNameTxt_.text = var_48_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(320221011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_12 = 18
				local var_48_13 = utf8.len(var_48_11)
				local var_48_14 = var_48_12 <= 0 and var_48_7 or var_48_7 * (var_48_13 / var_48_12)

				if var_48_14 > 0 and var_48_7 < var_48_14 then
					arg_45_1.talkMaxDuration = var_48_14
					var_48_6 = var_48_6 + 0.3

					if var_48_14 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221011", "story_v_out_320221.awb") ~= 0 then
					local var_48_15 = manager.audio:GetVoiceLength("story_v_out_320221", "320221011", "story_v_out_320221.awb") / 1000

					if var_48_15 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_6
					end

					if var_48_10.prefab_name ~= "" and arg_45_1.actors_[var_48_10.prefab_name] ~= nil then
						local var_48_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_10.prefab_name].transform, "story_v_out_320221", "320221011", "story_v_out_320221.awb")

						arg_45_1:RecordAudio("320221011", var_48_16)
						arg_45_1:RecordAudio("320221011", var_48_16)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_320221", "320221011", "story_v_out_320221.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_320221", "320221011", "story_v_out_320221.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_17 = var_48_6 + 0.3
			local var_48_18 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_17 <= arg_45_1.time_ and arg_45_1.time_ < var_48_17 + var_48_18 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_17) / var_48_18

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_17 + var_48_18 and arg_45_1.time_ < var_48_17 + var_48_18 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play320221012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 320221012
		arg_51_1.duration_ = 11.6

		local var_51_0 = {
			zh = 8.766,
			ja = 11.6
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
				arg_51_0:Play320221013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1011ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1011ui_story == nil then
				arg_51_1.var_.characterEffect1011ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect1011ui_story and not isNil(var_54_0) then
					local var_54_4 = Mathf.Lerp(0, 0.5, var_54_3)

					arg_51_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1011ui_story.fillRatio = var_54_4
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1011ui_story then
				local var_54_5 = 0.5

				arg_51_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1011ui_story.fillRatio = var_54_5
			end

			local var_54_6 = 0
			local var_54_7 = 1.15

			if var_54_6 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_8 = arg_51_1:FormatText(StoryNameCfg[67].name)

				arg_51_1.leftNameTxt_.text = var_54_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_9 = arg_51_1:GetWordFromCfg(320221012)
				local var_54_10 = arg_51_1:FormatText(var_54_9.content)

				arg_51_1.text_.text = var_54_10

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_11 = 46
				local var_54_12 = utf8.len(var_54_10)
				local var_54_13 = var_54_11 <= 0 and var_54_7 or var_54_7 * (var_54_12 / var_54_11)

				if var_54_13 > 0 and var_54_7 < var_54_13 then
					arg_51_1.talkMaxDuration = var_54_13

					if var_54_13 + var_54_6 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_6
					end
				end

				arg_51_1.text_.text = var_54_10
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221012", "story_v_out_320221.awb") ~= 0 then
					local var_54_14 = manager.audio:GetVoiceLength("story_v_out_320221", "320221012", "story_v_out_320221.awb") / 1000

					if var_54_14 + var_54_6 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_14 + var_54_6
					end

					if var_54_9.prefab_name ~= "" and arg_51_1.actors_[var_54_9.prefab_name] ~= nil then
						local var_54_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_9.prefab_name].transform, "story_v_out_320221", "320221012", "story_v_out_320221.awb")

						arg_51_1:RecordAudio("320221012", var_54_15)
						arg_51_1:RecordAudio("320221012", var_54_15)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_320221", "320221012", "story_v_out_320221.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_320221", "320221012", "story_v_out_320221.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_16 = math.max(var_54_7, arg_51_1.talkMaxDuration)

			if var_54_6 <= arg_51_1.time_ and arg_51_1.time_ < var_54_6 + var_54_16 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_6) / var_54_16

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_6 + var_54_16 and arg_51_1.time_ < var_54_6 + var_54_16 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play320221013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 320221013
		arg_55_1.duration_ = 8

		local var_55_0 = {
			zh = 5.266,
			ja = 8
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
				arg_55_0:Play320221014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.625

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[67].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:GetWordFromCfg(320221013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 25
				local var_58_6 = utf8.len(var_58_4)
				local var_58_7 = var_58_5 <= 0 and var_58_1 or var_58_1 * (var_58_6 / var_58_5)

				if var_58_7 > 0 and var_58_1 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221013", "story_v_out_320221.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221013", "story_v_out_320221.awb") / 1000

					if var_58_8 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_0
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_320221", "320221013", "story_v_out_320221.awb")

						arg_55_1:RecordAudio("320221013", var_58_9)
						arg_55_1:RecordAudio("320221013", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_320221", "320221013", "story_v_out_320221.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_320221", "320221013", "story_v_out_320221.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_10 and arg_55_1.time_ < var_58_0 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play320221014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 320221014
		arg_59_1.duration_ = 3.4

		local var_59_0 = {
			zh = 2.233,
			ja = 3.4
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play320221015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1011ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1011ui_story == nil then
				arg_59_1.var_.characterEffect1011ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect1011ui_story and not isNil(var_62_0) then
					arg_59_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1011ui_story then
				arg_59_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_62_4 = 0

			if var_62_4 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action428")
			end

			local var_62_5 = 0

			if var_62_5 < arg_59_1.time_ and arg_59_1.time_ <= var_62_5 + arg_62_0 then
				arg_59_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_62_6 = 0
			local var_62_7 = 0.175

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_8 = arg_59_1:FormatText(StoryNameCfg[37].name)

				arg_59_1.leftNameTxt_.text = var_62_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_9 = arg_59_1:GetWordFromCfg(320221014)
				local var_62_10 = arg_59_1:FormatText(var_62_9.content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_11 = 7
				local var_62_12 = utf8.len(var_62_10)
				local var_62_13 = var_62_11 <= 0 and var_62_7 or var_62_7 * (var_62_12 / var_62_11)

				if var_62_13 > 0 and var_62_7 < var_62_13 then
					arg_59_1.talkMaxDuration = var_62_13

					if var_62_13 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_6
					end
				end

				arg_59_1.text_.text = var_62_10
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221014", "story_v_out_320221.awb") ~= 0 then
					local var_62_14 = manager.audio:GetVoiceLength("story_v_out_320221", "320221014", "story_v_out_320221.awb") / 1000

					if var_62_14 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_14 + var_62_6
					end

					if var_62_9.prefab_name ~= "" and arg_59_1.actors_[var_62_9.prefab_name] ~= nil then
						local var_62_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_9.prefab_name].transform, "story_v_out_320221", "320221014", "story_v_out_320221.awb")

						arg_59_1:RecordAudio("320221014", var_62_15)
						arg_59_1:RecordAudio("320221014", var_62_15)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_320221", "320221014", "story_v_out_320221.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_320221", "320221014", "story_v_out_320221.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_16 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_16 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_16

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_16 and arg_59_1.time_ < var_62_6 + var_62_16 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play320221015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 320221015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play320221016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1011ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1011ui_story == nil then
				arg_63_1.var_.characterEffect1011ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect1011ui_story and not isNil(var_66_0) then
					local var_66_4 = Mathf.Lerp(0, 0.5, var_66_3)

					arg_63_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1011ui_story.fillRatio = var_66_4
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1011ui_story then
				local var_66_5 = 0.5

				arg_63_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1011ui_story.fillRatio = var_66_5
			end

			local var_66_6 = 0
			local var_66_7 = 0.65

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_8 = arg_63_1:FormatText(StoryNameCfg[7].name)

				arg_63_1.leftNameTxt_.text = var_66_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_9 = arg_63_1:GetWordFromCfg(320221015)
				local var_66_10 = arg_63_1:FormatText(var_66_9.content)

				arg_63_1.text_.text = var_66_10

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_11 = 26
				local var_66_12 = utf8.len(var_66_10)
				local var_66_13 = var_66_11 <= 0 and var_66_7 or var_66_7 * (var_66_12 / var_66_11)

				if var_66_13 > 0 and var_66_7 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_10
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_14 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_14 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_14

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_14 and arg_63_1.time_ < var_66_6 + var_66_14 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play320221016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 320221016
		arg_67_1.duration_ = 3.03

		local var_67_0 = {
			zh = 2.433,
			ja = 3.033
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play320221017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1011ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1011ui_story == nil then
				arg_67_1.var_.characterEffect1011ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect1011ui_story and not isNil(var_70_0) then
					arg_67_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1011ui_story then
				arg_67_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_70_4 = 0
			local var_70_5 = 0.125

			if var_70_4 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_6 = arg_67_1:FormatText(StoryNameCfg[37].name)

				arg_67_1.leftNameTxt_.text = var_70_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_7 = arg_67_1:GetWordFromCfg(320221016)
				local var_70_8 = arg_67_1:FormatText(var_70_7.content)

				arg_67_1.text_.text = var_70_8

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_9 = 5
				local var_70_10 = utf8.len(var_70_8)
				local var_70_11 = var_70_9 <= 0 and var_70_5 or var_70_5 * (var_70_10 / var_70_9)

				if var_70_11 > 0 and var_70_5 < var_70_11 then
					arg_67_1.talkMaxDuration = var_70_11

					if var_70_11 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_11 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_8
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221016", "story_v_out_320221.awb") ~= 0 then
					local var_70_12 = manager.audio:GetVoiceLength("story_v_out_320221", "320221016", "story_v_out_320221.awb") / 1000

					if var_70_12 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_12 + var_70_4
					end

					if var_70_7.prefab_name ~= "" and arg_67_1.actors_[var_70_7.prefab_name] ~= nil then
						local var_70_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_7.prefab_name].transform, "story_v_out_320221", "320221016", "story_v_out_320221.awb")

						arg_67_1:RecordAudio("320221016", var_70_13)
						arg_67_1:RecordAudio("320221016", var_70_13)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_320221", "320221016", "story_v_out_320221.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_320221", "320221016", "story_v_out_320221.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_14 = math.max(var_70_5, arg_67_1.talkMaxDuration)

			if var_70_4 <= arg_67_1.time_ and arg_67_1.time_ < var_70_4 + var_70_14 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_4) / var_70_14

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_4 + var_70_14 and arg_67_1.time_ < var_70_4 + var_70_14 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play320221017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 320221017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play320221018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1011ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1011ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, 100, 0)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1011ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, 100, 0)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = 0
			local var_74_10 = 1.175

			if var_74_9 < arg_71_1.time_ and arg_71_1.time_ <= var_74_9 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_11 = arg_71_1:GetWordFromCfg(320221017)
				local var_74_12 = arg_71_1:FormatText(var_74_11.content)

				arg_71_1.text_.text = var_74_12

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_13 = 47
				local var_74_14 = utf8.len(var_74_12)
				local var_74_15 = var_74_13 <= 0 and var_74_10 or var_74_10 * (var_74_14 / var_74_13)

				if var_74_15 > 0 and var_74_10 < var_74_15 then
					arg_71_1.talkMaxDuration = var_74_15

					if var_74_15 + var_74_9 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_15 + var_74_9
					end
				end

				arg_71_1.text_.text = var_74_12
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_16 = math.max(var_74_10, arg_71_1.talkMaxDuration)

			if var_74_9 <= arg_71_1.time_ and arg_71_1.time_ < var_74_9 + var_74_16 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_9) / var_74_16

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_9 + var_74_16 and arg_71_1.time_ < var_74_9 + var_74_16 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play320221018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 320221018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play320221019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.55

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[7].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_3 = arg_75_1:GetWordFromCfg(320221018)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 22
				local var_78_6 = utf8.len(var_78_4)
				local var_78_7 = var_78_5 <= 0 and var_78_1 or var_78_1 * (var_78_6 / var_78_5)

				if var_78_7 > 0 and var_78_1 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_8 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_8 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_8

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_8 and arg_75_1.time_ < var_78_0 + var_78_8 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play320221019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 320221019
		arg_79_1.duration_ = 5.5

		local var_79_0 = {
			zh = 5.5,
			ja = 4.466
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
				arg_79_0:Play320221020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1011ui_story"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos1011ui_story = var_82_0.localPosition
			end

			local var_82_2 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2
				local var_82_4 = Vector3.New(0, -0.71, -6)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1011ui_story, var_82_4, var_82_3)

				local var_82_5 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_5.x, var_82_5.y, var_82_5.z)

				local var_82_6 = var_82_0.localEulerAngles

				var_82_6.z = 0
				var_82_6.x = 0
				var_82_0.localEulerAngles = var_82_6
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_82_7 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_7.x, var_82_7.y, var_82_7.z)

				local var_82_8 = var_82_0.localEulerAngles

				var_82_8.z = 0
				var_82_8.x = 0
				var_82_0.localEulerAngles = var_82_8
			end

			local var_82_9 = arg_79_1.actors_["1011ui_story"]
			local var_82_10 = 0

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 and not isNil(var_82_9) and arg_79_1.var_.characterEffect1011ui_story == nil then
				arg_79_1.var_.characterEffect1011ui_story = var_82_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_11 = 0.200000002980232

			if var_82_10 <= arg_79_1.time_ and arg_79_1.time_ < var_82_10 + var_82_11 and not isNil(var_82_9) then
				local var_82_12 = (arg_79_1.time_ - var_82_10) / var_82_11

				if arg_79_1.var_.characterEffect1011ui_story and not isNil(var_82_9) then
					arg_79_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_10 + var_82_11 and arg_79_1.time_ < var_82_10 + var_82_11 + arg_82_0 and not isNil(var_82_9) and arg_79_1.var_.characterEffect1011ui_story then
				arg_79_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_82_13 = 0

			if var_82_13 < arg_79_1.time_ and arg_79_1.time_ <= var_82_13 + arg_82_0 then
				arg_79_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action8_2")
			end

			local var_82_14 = 0

			if var_82_14 < arg_79_1.time_ and arg_79_1.time_ <= var_82_14 + arg_82_0 then
				arg_79_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_82_15 = 0
			local var_82_16 = 0.4

			if var_82_15 < arg_79_1.time_ and arg_79_1.time_ <= var_82_15 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_17 = arg_79_1:FormatText(StoryNameCfg[37].name)

				arg_79_1.leftNameTxt_.text = var_82_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_18 = arg_79_1:GetWordFromCfg(320221019)
				local var_82_19 = arg_79_1:FormatText(var_82_18.content)

				arg_79_1.text_.text = var_82_19

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_20 = 16
				local var_82_21 = utf8.len(var_82_19)
				local var_82_22 = var_82_20 <= 0 and var_82_16 or var_82_16 * (var_82_21 / var_82_20)

				if var_82_22 > 0 and var_82_16 < var_82_22 then
					arg_79_1.talkMaxDuration = var_82_22

					if var_82_22 + var_82_15 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_22 + var_82_15
					end
				end

				arg_79_1.text_.text = var_82_19
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221019", "story_v_out_320221.awb") ~= 0 then
					local var_82_23 = manager.audio:GetVoiceLength("story_v_out_320221", "320221019", "story_v_out_320221.awb") / 1000

					if var_82_23 + var_82_15 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_23 + var_82_15
					end

					if var_82_18.prefab_name ~= "" and arg_79_1.actors_[var_82_18.prefab_name] ~= nil then
						local var_82_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_18.prefab_name].transform, "story_v_out_320221", "320221019", "story_v_out_320221.awb")

						arg_79_1:RecordAudio("320221019", var_82_24)
						arg_79_1:RecordAudio("320221019", var_82_24)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_320221", "320221019", "story_v_out_320221.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_320221", "320221019", "story_v_out_320221.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_25 = math.max(var_82_16, arg_79_1.talkMaxDuration)

			if var_82_15 <= arg_79_1.time_ and arg_79_1.time_ < var_82_15 + var_82_25 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_15) / var_82_25

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_15 + var_82_25 and arg_79_1.time_ < var_82_15 + var_82_25 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play320221020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 320221020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play320221021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1011ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1011ui_story == nil then
				arg_83_1.var_.characterEffect1011ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect1011ui_story and not isNil(var_86_0) then
					local var_86_4 = Mathf.Lerp(0, 0.5, var_86_3)

					arg_83_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1011ui_story.fillRatio = var_86_4
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1011ui_story then
				local var_86_5 = 0.5

				arg_83_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1011ui_story.fillRatio = var_86_5
			end

			local var_86_6 = 0
			local var_86_7 = 0.575

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

				local var_86_9 = arg_83_1:GetWordFromCfg(320221020)
				local var_86_10 = arg_83_1:FormatText(var_86_9.content)

				arg_83_1.text_.text = var_86_10

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_11 = 23
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
	Play320221021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 320221021
		arg_87_1.duration_ = 9.2

		local var_87_0 = {
			zh = 9.2,
			ja = 6.4
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
				arg_87_0:Play320221022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = "10102ui_story"

			if arg_87_1.actors_[var_90_0] == nil then
				local var_90_1 = Asset.Load("Char/" .. "10102ui_story")

				if not isNil(var_90_1) then
					local var_90_2 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_87_1.stage_.transform)

					var_90_2.name = var_90_0
					var_90_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_87_1.actors_[var_90_0] = var_90_2

					local var_90_3 = var_90_2:GetComponentInChildren(typeof(CharacterEffect))

					var_90_3.enabled = true

					local var_90_4 = GameObjectTools.GetOrAddComponent(var_90_2, typeof(DynamicBoneHelper))

					if var_90_4 then
						var_90_4:EnableDynamicBone(false)
					end

					arg_87_1:ShowWeapon(var_90_3.transform, false)

					arg_87_1.var_[var_90_0 .. "Animator"] = var_90_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_87_1.var_[var_90_0 .. "Animator"].applyRootMotion = true
					arg_87_1.var_[var_90_0 .. "LipSync"] = var_90_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_90_5 = arg_87_1.actors_["10102ui_story"].transform
			local var_90_6 = 0

			if var_90_6 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 then
				arg_87_1.var_.moveOldPos10102ui_story = var_90_5.localPosition
			end

			local var_90_7 = 0.001

			if var_90_6 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_7 then
				local var_90_8 = (arg_87_1.time_ - var_90_6) / var_90_7
				local var_90_9 = Vector3.New(0, -0.985, -6.275)

				var_90_5.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10102ui_story, var_90_9, var_90_8)

				local var_90_10 = manager.ui.mainCamera.transform.position - var_90_5.position

				var_90_5.forward = Vector3.New(var_90_10.x, var_90_10.y, var_90_10.z)

				local var_90_11 = var_90_5.localEulerAngles

				var_90_11.z = 0
				var_90_11.x = 0
				var_90_5.localEulerAngles = var_90_11
			end

			if arg_87_1.time_ >= var_90_6 + var_90_7 and arg_87_1.time_ < var_90_6 + var_90_7 + arg_90_0 then
				var_90_5.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_90_12 = manager.ui.mainCamera.transform.position - var_90_5.position

				var_90_5.forward = Vector3.New(var_90_12.x, var_90_12.y, var_90_12.z)

				local var_90_13 = var_90_5.localEulerAngles

				var_90_13.z = 0
				var_90_13.x = 0
				var_90_5.localEulerAngles = var_90_13
			end

			local var_90_14 = arg_87_1.actors_["10102ui_story"]
			local var_90_15 = 0

			if var_90_15 < arg_87_1.time_ and arg_87_1.time_ <= var_90_15 + arg_90_0 and not isNil(var_90_14) and arg_87_1.var_.characterEffect10102ui_story == nil then
				arg_87_1.var_.characterEffect10102ui_story = var_90_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_16 = 0.200000002980232

			if var_90_15 <= arg_87_1.time_ and arg_87_1.time_ < var_90_15 + var_90_16 and not isNil(var_90_14) then
				local var_90_17 = (arg_87_1.time_ - var_90_15) / var_90_16

				if arg_87_1.var_.characterEffect10102ui_story and not isNil(var_90_14) then
					arg_87_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_15 + var_90_16 and arg_87_1.time_ < var_90_15 + var_90_16 + arg_90_0 and not isNil(var_90_14) and arg_87_1.var_.characterEffect10102ui_story then
				arg_87_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_90_18 = 0

			if var_90_18 < arg_87_1.time_ and arg_87_1.time_ <= var_90_18 + arg_90_0 then
				arg_87_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			local var_90_19 = 0

			if var_90_19 < arg_87_1.time_ and arg_87_1.time_ <= var_90_19 + arg_90_0 then
				arg_87_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
			end

			local var_90_20 = arg_87_1.actors_["1011ui_story"].transform
			local var_90_21 = 0

			if var_90_21 < arg_87_1.time_ and arg_87_1.time_ <= var_90_21 + arg_90_0 then
				arg_87_1.var_.moveOldPos1011ui_story = var_90_20.localPosition
			end

			local var_90_22 = 0.001

			if var_90_21 <= arg_87_1.time_ and arg_87_1.time_ < var_90_21 + var_90_22 then
				local var_90_23 = (arg_87_1.time_ - var_90_21) / var_90_22
				local var_90_24 = Vector3.New(0, 100, 0)

				var_90_20.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1011ui_story, var_90_24, var_90_23)

				local var_90_25 = manager.ui.mainCamera.transform.position - var_90_20.position

				var_90_20.forward = Vector3.New(var_90_25.x, var_90_25.y, var_90_25.z)

				local var_90_26 = var_90_20.localEulerAngles

				var_90_26.z = 0
				var_90_26.x = 0
				var_90_20.localEulerAngles = var_90_26
			end

			if arg_87_1.time_ >= var_90_21 + var_90_22 and arg_87_1.time_ < var_90_21 + var_90_22 + arg_90_0 then
				var_90_20.localPosition = Vector3.New(0, 100, 0)

				local var_90_27 = manager.ui.mainCamera.transform.position - var_90_20.position

				var_90_20.forward = Vector3.New(var_90_27.x, var_90_27.y, var_90_27.z)

				local var_90_28 = var_90_20.localEulerAngles

				var_90_28.z = 0
				var_90_28.x = 0
				var_90_20.localEulerAngles = var_90_28
			end

			local var_90_29 = arg_87_1.actors_["1011ui_story"]
			local var_90_30 = 0

			if var_90_30 < arg_87_1.time_ and arg_87_1.time_ <= var_90_30 + arg_90_0 and not isNil(var_90_29) and arg_87_1.var_.characterEffect1011ui_story == nil then
				arg_87_1.var_.characterEffect1011ui_story = var_90_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_31 = 0.200000002980232

			if var_90_30 <= arg_87_1.time_ and arg_87_1.time_ < var_90_30 + var_90_31 and not isNil(var_90_29) then
				local var_90_32 = (arg_87_1.time_ - var_90_30) / var_90_31

				if arg_87_1.var_.characterEffect1011ui_story and not isNil(var_90_29) then
					local var_90_33 = Mathf.Lerp(0, 0.5, var_90_32)

					arg_87_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1011ui_story.fillRatio = var_90_33
				end
			end

			if arg_87_1.time_ >= var_90_30 + var_90_31 and arg_87_1.time_ < var_90_30 + var_90_31 + arg_90_0 and not isNil(var_90_29) and arg_87_1.var_.characterEffect1011ui_story then
				local var_90_34 = 0.5

				arg_87_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1011ui_story.fillRatio = var_90_34
			end

			local var_90_35 = 0
			local var_90_36 = 0.725

			if var_90_35 < arg_87_1.time_ and arg_87_1.time_ <= var_90_35 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_37 = arg_87_1:FormatText(StoryNameCfg[6].name)

				arg_87_1.leftNameTxt_.text = var_90_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_38 = arg_87_1:GetWordFromCfg(320221021)
				local var_90_39 = arg_87_1:FormatText(var_90_38.content)

				arg_87_1.text_.text = var_90_39

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_40 = 29
				local var_90_41 = utf8.len(var_90_39)
				local var_90_42 = var_90_40 <= 0 and var_90_36 or var_90_36 * (var_90_41 / var_90_40)

				if var_90_42 > 0 and var_90_36 < var_90_42 then
					arg_87_1.talkMaxDuration = var_90_42

					if var_90_42 + var_90_35 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_42 + var_90_35
					end
				end

				arg_87_1.text_.text = var_90_39
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221021", "story_v_out_320221.awb") ~= 0 then
					local var_90_43 = manager.audio:GetVoiceLength("story_v_out_320221", "320221021", "story_v_out_320221.awb") / 1000

					if var_90_43 + var_90_35 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_43 + var_90_35
					end

					if var_90_38.prefab_name ~= "" and arg_87_1.actors_[var_90_38.prefab_name] ~= nil then
						local var_90_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_38.prefab_name].transform, "story_v_out_320221", "320221021", "story_v_out_320221.awb")

						arg_87_1:RecordAudio("320221021", var_90_44)
						arg_87_1:RecordAudio("320221021", var_90_44)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_320221", "320221021", "story_v_out_320221.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_320221", "320221021", "story_v_out_320221.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_45 = math.max(var_90_36, arg_87_1.talkMaxDuration)

			if var_90_35 <= arg_87_1.time_ and arg_87_1.time_ < var_90_35 + var_90_45 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_35) / var_90_45

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_35 + var_90_45 and arg_87_1.time_ < var_90_35 + var_90_45 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play320221022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 320221022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play320221023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10102ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos10102ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0, 100, 0)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10102ui_story, var_94_4, var_94_3)

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

			local var_94_9 = arg_91_1.actors_["10102ui_story"]
			local var_94_10 = 0

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect10102ui_story == nil then
				arg_91_1.var_.characterEffect10102ui_story = var_94_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_11 = 0.200000002980232

			if var_94_10 <= arg_91_1.time_ and arg_91_1.time_ < var_94_10 + var_94_11 and not isNil(var_94_9) then
				local var_94_12 = (arg_91_1.time_ - var_94_10) / var_94_11

				if arg_91_1.var_.characterEffect10102ui_story and not isNil(var_94_9) then
					local var_94_13 = Mathf.Lerp(0, 0.5, var_94_12)

					arg_91_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_91_1.var_.characterEffect10102ui_story.fillRatio = var_94_13
				end
			end

			if arg_91_1.time_ >= var_94_10 + var_94_11 and arg_91_1.time_ < var_94_10 + var_94_11 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect10102ui_story then
				local var_94_14 = 0.5

				arg_91_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_91_1.var_.characterEffect10102ui_story.fillRatio = var_94_14
			end

			local var_94_15 = 0
			local var_94_16 = 0.825

			if var_94_15 < arg_91_1.time_ and arg_91_1.time_ <= var_94_15 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_17 = arg_91_1:GetWordFromCfg(320221022)
				local var_94_18 = arg_91_1:FormatText(var_94_17.content)

				arg_91_1.text_.text = var_94_18

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_19 = 33
				local var_94_20 = utf8.len(var_94_18)
				local var_94_21 = var_94_19 <= 0 and var_94_16 or var_94_16 * (var_94_20 / var_94_19)

				if var_94_21 > 0 and var_94_16 < var_94_21 then
					arg_91_1.talkMaxDuration = var_94_21

					if var_94_21 + var_94_15 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_21 + var_94_15
					end
				end

				arg_91_1.text_.text = var_94_18
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_22 = math.max(var_94_16, arg_91_1.talkMaxDuration)

			if var_94_15 <= arg_91_1.time_ and arg_91_1.time_ < var_94_15 + var_94_22 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_15) / var_94_22

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_15 + var_94_22 and arg_91_1.time_ < var_94_15 + var_94_22 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play320221023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 320221023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play320221024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 0.45

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[7].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_3 = arg_95_1:GetWordFromCfg(320221023)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 18
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
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_8 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_8 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_8

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_8 and arg_95_1.time_ < var_98_0 + var_98_8 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play320221024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 320221024
		arg_99_1.duration_ = 5.97

		local var_99_0 = {
			zh = 5.966,
			ja = 5.166
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
				arg_99_0:Play320221025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["10102ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos10102ui_story = var_102_0.localPosition
			end

			local var_102_2 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2
				local var_102_4 = Vector3.New(0, -0.985, -6.275)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10102ui_story, var_102_4, var_102_3)

				local var_102_5 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_5.x, var_102_5.y, var_102_5.z)

				local var_102_6 = var_102_0.localEulerAngles

				var_102_6.z = 0
				var_102_6.x = 0
				var_102_0.localEulerAngles = var_102_6
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_102_7 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_7.x, var_102_7.y, var_102_7.z)

				local var_102_8 = var_102_0.localEulerAngles

				var_102_8.z = 0
				var_102_8.x = 0
				var_102_0.localEulerAngles = var_102_8
			end

			local var_102_9 = arg_99_1.actors_["10102ui_story"]
			local var_102_10 = 0

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect10102ui_story == nil then
				arg_99_1.var_.characterEffect10102ui_story = var_102_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_11 = 0.200000002980232

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_11 and not isNil(var_102_9) then
				local var_102_12 = (arg_99_1.time_ - var_102_10) / var_102_11

				if arg_99_1.var_.characterEffect10102ui_story and not isNil(var_102_9) then
					arg_99_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_10 + var_102_11 and arg_99_1.time_ < var_102_10 + var_102_11 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect10102ui_story then
				arg_99_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_102_13 = 0

			if var_102_13 < arg_99_1.time_ and arg_99_1.time_ <= var_102_13 + arg_102_0 then
				arg_99_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_2")
			end

			local var_102_14 = 0

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 then
				arg_99_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_102_15 = 0
			local var_102_16 = 0.6

			if var_102_15 < arg_99_1.time_ and arg_99_1.time_ <= var_102_15 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_17 = arg_99_1:FormatText(StoryNameCfg[6].name)

				arg_99_1.leftNameTxt_.text = var_102_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_18 = arg_99_1:GetWordFromCfg(320221024)
				local var_102_19 = arg_99_1:FormatText(var_102_18.content)

				arg_99_1.text_.text = var_102_19

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_20 = 24
				local var_102_21 = utf8.len(var_102_19)
				local var_102_22 = var_102_20 <= 0 and var_102_16 or var_102_16 * (var_102_21 / var_102_20)

				if var_102_22 > 0 and var_102_16 < var_102_22 then
					arg_99_1.talkMaxDuration = var_102_22

					if var_102_22 + var_102_15 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_22 + var_102_15
					end
				end

				arg_99_1.text_.text = var_102_19
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221024", "story_v_out_320221.awb") ~= 0 then
					local var_102_23 = manager.audio:GetVoiceLength("story_v_out_320221", "320221024", "story_v_out_320221.awb") / 1000

					if var_102_23 + var_102_15 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_23 + var_102_15
					end

					if var_102_18.prefab_name ~= "" and arg_99_1.actors_[var_102_18.prefab_name] ~= nil then
						local var_102_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_18.prefab_name].transform, "story_v_out_320221", "320221024", "story_v_out_320221.awb")

						arg_99_1:RecordAudio("320221024", var_102_24)
						arg_99_1:RecordAudio("320221024", var_102_24)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_320221", "320221024", "story_v_out_320221.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_320221", "320221024", "story_v_out_320221.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_25 = math.max(var_102_16, arg_99_1.talkMaxDuration)

			if var_102_15 <= arg_99_1.time_ and arg_99_1.time_ < var_102_15 + var_102_25 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_15) / var_102_25

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_15 + var_102_25 and arg_99_1.time_ < var_102_15 + var_102_25 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play320221025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 320221025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play320221026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["10102ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect10102ui_story == nil then
				arg_103_1.var_.characterEffect10102ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect10102ui_story and not isNil(var_106_0) then
					local var_106_4 = Mathf.Lerp(0, 0.5, var_106_3)

					arg_103_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_103_1.var_.characterEffect10102ui_story.fillRatio = var_106_4
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect10102ui_story then
				local var_106_5 = 0.5

				arg_103_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_103_1.var_.characterEffect10102ui_story.fillRatio = var_106_5
			end

			local var_106_6 = 0
			local var_106_7 = 0.6

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_8 = arg_103_1:FormatText(StoryNameCfg[7].name)

				arg_103_1.leftNameTxt_.text = var_106_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_9 = arg_103_1:GetWordFromCfg(320221025)
				local var_106_10 = arg_103_1:FormatText(var_106_9.content)

				arg_103_1.text_.text = var_106_10

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_11 = 24
				local var_106_12 = utf8.len(var_106_10)
				local var_106_13 = var_106_11 <= 0 and var_106_7 or var_106_7 * (var_106_12 / var_106_11)

				if var_106_13 > 0 and var_106_7 < var_106_13 then
					arg_103_1.talkMaxDuration = var_106_13

					if var_106_13 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_13 + var_106_6
					end
				end

				arg_103_1.text_.text = var_106_10
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_14 = math.max(var_106_7, arg_103_1.talkMaxDuration)

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_14 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_6) / var_106_14

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_6 + var_106_14 and arg_103_1.time_ < var_106_6 + var_106_14 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play320221026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 320221026
		arg_107_1.duration_ = 3.17

		local var_107_0 = {
			zh = 2.5,
			ja = 3.166
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
				arg_107_0:Play320221027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10102ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect10102ui_story == nil then
				arg_107_1.var_.characterEffect10102ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect10102ui_story and not isNil(var_110_0) then
					arg_107_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect10102ui_story then
				arg_107_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_110_4 = 0

			if var_110_4 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_110_5 = 0

			if var_110_5 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 then
				arg_107_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_110_6 = 0
			local var_110_7 = 0.175

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_8 = arg_107_1:FormatText(StoryNameCfg[6].name)

				arg_107_1.leftNameTxt_.text = var_110_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_9 = arg_107_1:GetWordFromCfg(320221026)
				local var_110_10 = arg_107_1:FormatText(var_110_9.content)

				arg_107_1.text_.text = var_110_10

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_11 = 7
				local var_110_12 = utf8.len(var_110_10)
				local var_110_13 = var_110_11 <= 0 and var_110_7 or var_110_7 * (var_110_12 / var_110_11)

				if var_110_13 > 0 and var_110_7 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13

					if var_110_13 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_6
					end
				end

				arg_107_1.text_.text = var_110_10
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221026", "story_v_out_320221.awb") ~= 0 then
					local var_110_14 = manager.audio:GetVoiceLength("story_v_out_320221", "320221026", "story_v_out_320221.awb") / 1000

					if var_110_14 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_6
					end

					if var_110_9.prefab_name ~= "" and arg_107_1.actors_[var_110_9.prefab_name] ~= nil then
						local var_110_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_9.prefab_name].transform, "story_v_out_320221", "320221026", "story_v_out_320221.awb")

						arg_107_1:RecordAudio("320221026", var_110_15)
						arg_107_1:RecordAudio("320221026", var_110_15)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_320221", "320221026", "story_v_out_320221.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_320221", "320221026", "story_v_out_320221.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_16 = math.max(var_110_7, arg_107_1.talkMaxDuration)

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_16 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_6) / var_110_16

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_6 + var_110_16 and arg_107_1.time_ < var_110_6 + var_110_16 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play320221027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 320221027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play320221028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10102ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect10102ui_story == nil then
				arg_111_1.var_.characterEffect10102ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect10102ui_story and not isNil(var_114_0) then
					local var_114_4 = Mathf.Lerp(0, 0.5, var_114_3)

					arg_111_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10102ui_story.fillRatio = var_114_4
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect10102ui_story then
				local var_114_5 = 0.5

				arg_111_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10102ui_story.fillRatio = var_114_5
			end

			local var_114_6 = 0
			local var_114_7 = 0.55

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_8 = arg_111_1:FormatText(StoryNameCfg[7].name)

				arg_111_1.leftNameTxt_.text = var_114_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_9 = arg_111_1:GetWordFromCfg(320221027)
				local var_114_10 = arg_111_1:FormatText(var_114_9.content)

				arg_111_1.text_.text = var_114_10

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 22
				local var_114_12 = utf8.len(var_114_10)
				local var_114_13 = var_114_11 <= 0 and var_114_7 or var_114_7 * (var_114_12 / var_114_11)

				if var_114_13 > 0 and var_114_7 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_10
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_14 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_14 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_14

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_14 and arg_111_1.time_ < var_114_6 + var_114_14 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play320221028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 320221028
		arg_115_1.duration_ = 11.97

		local var_115_0 = {
			zh = 6.73333333333333,
			ja = 11.9663333333333
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
				arg_115_0:Play320221029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = "ST02"

			if arg_115_1.bgs_[var_118_0] == nil then
				local var_118_1 = Object.Instantiate(arg_115_1.paintGo_)

				var_118_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_118_0)
				var_118_1.name = var_118_0
				var_118_1.transform.parent = arg_115_1.stage_.transform
				var_118_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.bgs_[var_118_0] = var_118_1
			end

			local var_118_2 = 1.96666666666667

			if var_118_2 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				local var_118_3 = manager.ui.mainCamera.transform.localPosition
				local var_118_4 = Vector3.New(0, 0, 10) + Vector3.New(var_118_3.x, var_118_3.y, 0)
				local var_118_5 = arg_115_1.bgs_.ST02

				var_118_5.transform.localPosition = var_118_4
				var_118_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_118_6 = var_118_5:GetComponent("SpriteRenderer")

				if var_118_6 and var_118_6.sprite then
					local var_118_7 = (var_118_5.transform.localPosition - var_118_3).z
					local var_118_8 = manager.ui.mainCameraCom_
					local var_118_9 = 2 * var_118_7 * Mathf.Tan(var_118_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_118_10 = var_118_9 * var_118_8.aspect
					local var_118_11 = var_118_6.sprite.bounds.size.x
					local var_118_12 = var_118_6.sprite.bounds.size.y
					local var_118_13 = var_118_10 / var_118_11
					local var_118_14 = var_118_9 / var_118_12
					local var_118_15 = var_118_14 < var_118_13 and var_118_13 or var_118_14

					var_118_5.transform.localScale = Vector3.New(var_118_15, var_118_15, 0)
				end

				for iter_118_0, iter_118_1 in pairs(arg_115_1.bgs_) do
					if iter_118_0 ~= "ST02" then
						iter_118_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_118_16 = 0

			if var_118_16 < arg_115_1.time_ and arg_115_1.time_ <= var_118_16 + arg_118_0 then
				arg_115_1.allBtn_.enabled = false
			end

			local var_118_17 = 0.3

			if arg_115_1.time_ >= var_118_16 + var_118_17 and arg_115_1.time_ < var_118_16 + var_118_17 + arg_118_0 then
				arg_115_1.allBtn_.enabled = true
			end

			local var_118_18 = 0

			if var_118_18 < arg_115_1.time_ and arg_115_1.time_ <= var_118_18 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_19 = 2

			if var_118_18 <= arg_115_1.time_ and arg_115_1.time_ < var_118_18 + var_118_19 then
				local var_118_20 = (arg_115_1.time_ - var_118_18) / var_118_19
				local var_118_21 = Color.New(0, 0, 0)

				var_118_21.a = Mathf.Lerp(0, 1, var_118_20)
				arg_115_1.mask_.color = var_118_21
			end

			if arg_115_1.time_ >= var_118_18 + var_118_19 and arg_115_1.time_ < var_118_18 + var_118_19 + arg_118_0 then
				local var_118_22 = Color.New(0, 0, 0)

				var_118_22.a = 1
				arg_115_1.mask_.color = var_118_22
			end

			local var_118_23 = 2

			if var_118_23 < arg_115_1.time_ and arg_115_1.time_ <= var_118_23 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_24 = 1.5

			if var_118_23 <= arg_115_1.time_ and arg_115_1.time_ < var_118_23 + var_118_24 then
				local var_118_25 = (arg_115_1.time_ - var_118_23) / var_118_24
				local var_118_26 = Color.New(0, 0, 0)

				var_118_26.a = Mathf.Lerp(1, 0, var_118_25)
				arg_115_1.mask_.color = var_118_26
			end

			if arg_115_1.time_ >= var_118_23 + var_118_24 and arg_115_1.time_ < var_118_23 + var_118_24 + arg_118_0 then
				local var_118_27 = Color.New(0, 0, 0)
				local var_118_28 = 0

				arg_115_1.mask_.enabled = false
				var_118_27.a = var_118_28
				arg_115_1.mask_.color = var_118_27
			end

			local var_118_29 = arg_115_1.actors_["10102ui_story"].transform
			local var_118_30 = 1.96666666666667

			if var_118_30 < arg_115_1.time_ and arg_115_1.time_ <= var_118_30 + arg_118_0 then
				arg_115_1.var_.moveOldPos10102ui_story = var_118_29.localPosition
			end

			local var_118_31 = 0.001

			if var_118_30 <= arg_115_1.time_ and arg_115_1.time_ < var_118_30 + var_118_31 then
				local var_118_32 = (arg_115_1.time_ - var_118_30) / var_118_31
				local var_118_33 = Vector3.New(0, 100, 0)

				var_118_29.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10102ui_story, var_118_33, var_118_32)

				local var_118_34 = manager.ui.mainCamera.transform.position - var_118_29.position

				var_118_29.forward = Vector3.New(var_118_34.x, var_118_34.y, var_118_34.z)

				local var_118_35 = var_118_29.localEulerAngles

				var_118_35.z = 0
				var_118_35.x = 0
				var_118_29.localEulerAngles = var_118_35
			end

			if arg_115_1.time_ >= var_118_30 + var_118_31 and arg_115_1.time_ < var_118_30 + var_118_31 + arg_118_0 then
				var_118_29.localPosition = Vector3.New(0, 100, 0)

				local var_118_36 = manager.ui.mainCamera.transform.position - var_118_29.position

				var_118_29.forward = Vector3.New(var_118_36.x, var_118_36.y, var_118_36.z)

				local var_118_37 = var_118_29.localEulerAngles

				var_118_37.z = 0
				var_118_37.x = 0
				var_118_29.localEulerAngles = var_118_37
			end

			local var_118_38 = arg_115_1.actors_["10102ui_story"]
			local var_118_39 = 1.96666666666667

			if var_118_39 < arg_115_1.time_ and arg_115_1.time_ <= var_118_39 + arg_118_0 and not isNil(var_118_38) and arg_115_1.var_.characterEffect10102ui_story == nil then
				arg_115_1.var_.characterEffect10102ui_story = var_118_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_40 = 0.200000002980232

			if var_118_39 <= arg_115_1.time_ and arg_115_1.time_ < var_118_39 + var_118_40 and not isNil(var_118_38) then
				local var_118_41 = (arg_115_1.time_ - var_118_39) / var_118_40

				if arg_115_1.var_.characterEffect10102ui_story and not isNil(var_118_38) then
					local var_118_42 = Mathf.Lerp(0, 0.5, var_118_41)

					arg_115_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_115_1.var_.characterEffect10102ui_story.fillRatio = var_118_42
				end
			end

			if arg_115_1.time_ >= var_118_39 + var_118_40 and arg_115_1.time_ < var_118_39 + var_118_40 + arg_118_0 and not isNil(var_118_38) and arg_115_1.var_.characterEffect10102ui_story then
				local var_118_43 = 0.5

				arg_115_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_115_1.var_.characterEffect10102ui_story.fillRatio = var_118_43
			end

			local var_118_44 = 0
			local var_118_45 = 0.2

			if var_118_44 < arg_115_1.time_ and arg_115_1.time_ <= var_118_44 + arg_118_0 then
				local var_118_46 = "play"
				local var_118_47 = "music"

				arg_115_1:AudioAction(var_118_46, var_118_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_118_48 = ""
				local var_118_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_118_49 ~= "" then
					if arg_115_1.bgmTxt_.text ~= var_118_49 and arg_115_1.bgmTxt_.text ~= "" then
						if arg_115_1.bgmTxt2_.text ~= "" then
							arg_115_1.bgmTxt_.text = arg_115_1.bgmTxt2_.text
						end

						arg_115_1.bgmTxt2_.text = var_118_49

						arg_115_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_115_1.bgmTxt_.text = var_118_49
						arg_115_1.bgmTxt2_.text = var_118_49
					end

					if arg_115_1.bgmTimer then
						arg_115_1.bgmTimer:Stop()

						arg_115_1.bgmTimer = nil
					end

					if arg_115_1.settingData.show_music_name == 1 then
						arg_115_1.musicController:SetSelectedState("show")
						arg_115_1.musicAnimator_:Play("open", 0, 0)

						if arg_115_1.settingData.music_time ~= 0 then
							arg_115_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_115_1.settingData.music_time), function()
								if arg_115_1 == nil or isNil(arg_115_1.bgmTxt_) then
									return
								end

								arg_115_1.musicController:SetSelectedState("hide")
								arg_115_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_118_50 = 0.333333333333333
			local var_118_51 = 1

			if var_118_50 < arg_115_1.time_ and arg_115_1.time_ <= var_118_50 + arg_118_0 then
				local var_118_52 = "play"
				local var_118_53 = "music"

				arg_115_1:AudioAction(var_118_52, var_118_53, "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_118_54 = ""
				local var_118_55 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if var_118_55 ~= "" then
					if arg_115_1.bgmTxt_.text ~= var_118_55 and arg_115_1.bgmTxt_.text ~= "" then
						if arg_115_1.bgmTxt2_.text ~= "" then
							arg_115_1.bgmTxt_.text = arg_115_1.bgmTxt2_.text
						end

						arg_115_1.bgmTxt2_.text = var_118_55

						arg_115_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_115_1.bgmTxt_.text = var_118_55
						arg_115_1.bgmTxt2_.text = var_118_55
					end

					if arg_115_1.bgmTimer then
						arg_115_1.bgmTimer:Stop()

						arg_115_1.bgmTimer = nil
					end

					if arg_115_1.settingData.show_music_name == 1 then
						arg_115_1.musicController:SetSelectedState("show")
						arg_115_1.musicAnimator_:Play("open", 0, 0)

						if arg_115_1.settingData.music_time ~= 0 then
							arg_115_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_115_1.settingData.music_time), function()
								if arg_115_1 == nil or isNil(arg_115_1.bgmTxt_) then
									return
								end

								arg_115_1.musicController:SetSelectedState("hide")
								arg_115_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_118_56 = 0.333333333333333
			local var_118_57 = 1

			if var_118_56 < arg_115_1.time_ and arg_115_1.time_ <= var_118_56 + arg_118_0 then
				local var_118_58 = "play"
				local var_118_59 = "effect"

				arg_115_1:AudioAction(var_118_58, var_118_59, "se_story_221_00", "se_story_221_00_canteen_loop", "")
			end

			if arg_115_1.frameCnt_ <= 1 then
				arg_115_1.dialog_:SetActive(false)
			end

			local var_118_60 = 3.73333333333333
			local var_118_61 = 0.525

			if var_118_60 < arg_115_1.time_ and arg_115_1.time_ <= var_118_60 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				arg_115_1.dialog_:SetActive(true)

				arg_115_1.dialogCg_.alpha = 0

				local var_118_62 = LeanTween.value(arg_115_1.dialog_, 0, 1, 0.3)

				var_118_62:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_115_1.dialogCg_.alpha = arg_121_0
				end))
				var_118_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_115_1.dialog_)
					var_118_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_115_1.duration_ = arg_115_1.duration_ + 0.3

				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_63 = arg_115_1:FormatText(StoryNameCfg[144].name)

				arg_115_1.leftNameTxt_.text = var_118_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_64 = arg_115_1:GetWordFromCfg(320221028)
				local var_118_65 = arg_115_1:FormatText(var_118_64.content)

				arg_115_1.text_.text = var_118_65

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_66 = 21
				local var_118_67 = utf8.len(var_118_65)
				local var_118_68 = var_118_66 <= 0 and var_118_61 or var_118_61 * (var_118_67 / var_118_66)

				if var_118_68 > 0 and var_118_61 < var_118_68 then
					arg_115_1.talkMaxDuration = var_118_68
					var_118_60 = var_118_60 + 0.3

					if var_118_68 + var_118_60 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_68 + var_118_60
					end
				end

				arg_115_1.text_.text = var_118_65
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221028", "story_v_out_320221.awb") ~= 0 then
					local var_118_69 = manager.audio:GetVoiceLength("story_v_out_320221", "320221028", "story_v_out_320221.awb") / 1000

					if var_118_69 + var_118_60 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_69 + var_118_60
					end

					if var_118_64.prefab_name ~= "" and arg_115_1.actors_[var_118_64.prefab_name] ~= nil then
						local var_118_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_64.prefab_name].transform, "story_v_out_320221", "320221028", "story_v_out_320221.awb")

						arg_115_1:RecordAudio("320221028", var_118_70)
						arg_115_1:RecordAudio("320221028", var_118_70)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_320221", "320221028", "story_v_out_320221.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_320221", "320221028", "story_v_out_320221.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_71 = var_118_60 + 0.3
			local var_118_72 = math.max(var_118_61, arg_115_1.talkMaxDuration)

			if var_118_71 <= arg_115_1.time_ and arg_115_1.time_ < var_118_71 + var_118_72 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_71) / var_118_72

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_71 + var_118_72 and arg_115_1.time_ < var_118_71 + var_118_72 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play320221029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 320221029
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play320221030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.775

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[7].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_3 = arg_123_1:GetWordFromCfg(320221029)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 31
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
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_8 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_8 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_8

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_8 and arg_123_1.time_ < var_126_0 + var_126_8 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play320221030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 320221030
		arg_127_1.duration_ = 5.9

		local var_127_0 = {
			zh = 3.3,
			ja = 5.9
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play320221031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.4

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[144].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:GetWordFromCfg(320221030)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 16
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221030", "story_v_out_320221.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221030", "story_v_out_320221.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_320221", "320221030", "story_v_out_320221.awb")

						arg_127_1:RecordAudio("320221030", var_130_9)
						arg_127_1:RecordAudio("320221030", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_320221", "320221030", "story_v_out_320221.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_320221", "320221030", "story_v_out_320221.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_10 and arg_127_1.time_ < var_130_0 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play320221031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 320221031
		arg_131_1.duration_ = 7.57

		local var_131_0 = {
			zh = 7.566,
			ja = 6.433
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
				arg_131_0:Play320221032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 1.075

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[144].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(320221031)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221031", "story_v_out_320221.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221031", "story_v_out_320221.awb") / 1000

					if var_134_8 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_0
					end

					if var_134_3.prefab_name ~= "" and arg_131_1.actors_[var_134_3.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_3.prefab_name].transform, "story_v_out_320221", "320221031", "story_v_out_320221.awb")

						arg_131_1:RecordAudio("320221031", var_134_9)
						arg_131_1:RecordAudio("320221031", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_320221", "320221031", "story_v_out_320221.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_320221", "320221031", "story_v_out_320221.awb")
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
	Play320221032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 320221032
		arg_135_1.duration_ = 12.83

		local var_135_0 = {
			zh = 9.066,
			ja = 12.833
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
				arg_135_0:Play320221033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 1.15

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[144].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(320221032)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221032", "story_v_out_320221.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221032", "story_v_out_320221.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_320221", "320221032", "story_v_out_320221.awb")

						arg_135_1:RecordAudio("320221032", var_138_9)
						arg_135_1:RecordAudio("320221032", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_320221", "320221032", "story_v_out_320221.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_320221", "320221032", "story_v_out_320221.awb")
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
	Play320221033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 320221033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play320221034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 1

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_2 = arg_139_1:GetWordFromCfg(320221033)
				local var_142_3 = arg_139_1:FormatText(var_142_2.content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_4 = 40
				local var_142_5 = utf8.len(var_142_3)
				local var_142_6 = var_142_4 <= 0 and var_142_1 or var_142_1 * (var_142_5 / var_142_4)

				if var_142_6 > 0 and var_142_1 < var_142_6 then
					arg_139_1.talkMaxDuration = var_142_6

					if var_142_6 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_7 and arg_139_1.time_ < var_142_0 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play320221034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 320221034
		arg_143_1.duration_ = 10.13

		local var_143_0 = {
			zh = 7.5,
			ja = 10.133
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
				arg_143_0:Play320221035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.875

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[144].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(320221034)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221034", "story_v_out_320221.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221034", "story_v_out_320221.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_320221", "320221034", "story_v_out_320221.awb")

						arg_143_1:RecordAudio("320221034", var_146_9)
						arg_143_1:RecordAudio("320221034", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_320221", "320221034", "story_v_out_320221.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_320221", "320221034", "story_v_out_320221.awb")
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
	Play320221035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 320221035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play320221036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 1.425

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_2 = arg_147_1:GetWordFromCfg(320221035)
				local var_150_3 = arg_147_1:FormatText(var_150_2.content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 57
				local var_150_5 = utf8.len(var_150_3)
				local var_150_6 = var_150_4 <= 0 and var_150_1 or var_150_1 * (var_150_5 / var_150_4)

				if var_150_6 > 0 and var_150_1 < var_150_6 then
					arg_147_1.talkMaxDuration = var_150_6

					if var_150_6 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_7 and arg_147_1.time_ < var_150_0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play320221036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 320221036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play320221037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.875

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[7].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:GetWordFromCfg(320221036)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 35
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
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_8 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_8 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_8

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_8 and arg_151_1.time_ < var_154_0 + var_154_8 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play320221037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 320221037
		arg_155_1.duration_ = 7.4

		local var_155_0 = {
			zh = 2.766,
			ja = 7.4
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
				arg_155_0:Play320221038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.25

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[144].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:GetWordFromCfg(320221037)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221037", "story_v_out_320221.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221037", "story_v_out_320221.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_320221", "320221037", "story_v_out_320221.awb")

						arg_155_1:RecordAudio("320221037", var_158_9)
						arg_155_1:RecordAudio("320221037", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_320221", "320221037", "story_v_out_320221.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_320221", "320221037", "story_v_out_320221.awb")
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
	Play320221038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 320221038
		arg_159_1.duration_ = 5

		local var_159_0 = {
			zh = 4.7,
			ja = 5
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
				arg_159_0:Play320221039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.55

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[144].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:GetWordFromCfg(320221038)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221038", "story_v_out_320221.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221038", "story_v_out_320221.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_320221", "320221038", "story_v_out_320221.awb")

						arg_159_1:RecordAudio("320221038", var_162_9)
						arg_159_1:RecordAudio("320221038", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_320221", "320221038", "story_v_out_320221.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_320221", "320221038", "story_v_out_320221.awb")
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
	Play320221039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 320221039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play320221040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 1.2

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[7].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:GetWordFromCfg(320221039)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 48
				local var_166_6 = utf8.len(var_166_4)
				local var_166_7 = var_166_5 <= 0 and var_166_1 or var_166_1 * (var_166_6 / var_166_5)

				if var_166_7 > 0 and var_166_1 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_8 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_8 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_8

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_8 and arg_163_1.time_ < var_166_0 + var_166_8 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play320221040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 320221040
		arg_167_1.duration_ = 11.97

		local var_167_0 = {
			zh = 11.966,
			ja = 4.2
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
				arg_167_0:Play320221041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 1

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[144].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:GetWordFromCfg(320221040)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221040", "story_v_out_320221.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221040", "story_v_out_320221.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_320221", "320221040", "story_v_out_320221.awb")

						arg_167_1:RecordAudio("320221040", var_170_9)
						arg_167_1:RecordAudio("320221040", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_320221", "320221040", "story_v_out_320221.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_320221", "320221040", "story_v_out_320221.awb")
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
	Play320221041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 320221041
		arg_171_1.duration_ = 14.47

		local var_171_0 = {
			zh = 9.5,
			ja = 14.466
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
				arg_171_0:Play320221042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 1.2

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[144].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:GetWordFromCfg(320221041)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221041", "story_v_out_320221.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221041", "story_v_out_320221.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_320221", "320221041", "story_v_out_320221.awb")

						arg_171_1:RecordAudio("320221041", var_174_9)
						arg_171_1:RecordAudio("320221041", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_320221", "320221041", "story_v_out_320221.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_320221", "320221041", "story_v_out_320221.awb")
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
	Play320221042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 320221042
		arg_175_1.duration_ = 10.5

		local var_175_0 = {
			zh = 9.1,
			ja = 10.5
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
				arg_175_0:Play320221043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 1

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[144].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(320221042)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221042", "story_v_out_320221.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221042", "story_v_out_320221.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_320221", "320221042", "story_v_out_320221.awb")

						arg_175_1:RecordAudio("320221042", var_178_9)
						arg_175_1:RecordAudio("320221042", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_320221", "320221042", "story_v_out_320221.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_320221", "320221042", "story_v_out_320221.awb")
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
	Play320221043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 320221043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play320221044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 1.075

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[7].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:GetWordFromCfg(320221043)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 43
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
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_8 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_8 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_8

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_8 and arg_179_1.time_ < var_182_0 + var_182_8 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play320221044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 320221044
		arg_183_1.duration_ = 9.1

		local var_183_0 = {
			zh = 5.166,
			ja = 9.1
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
				arg_183_0:Play320221045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.65

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[144].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:GetWordFromCfg(320221044)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221044", "story_v_out_320221.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221044", "story_v_out_320221.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_320221", "320221044", "story_v_out_320221.awb")

						arg_183_1:RecordAudio("320221044", var_186_9)
						arg_183_1:RecordAudio("320221044", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_320221", "320221044", "story_v_out_320221.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_320221", "320221044", "story_v_out_320221.awb")
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
	Play320221045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 320221045
		arg_187_1.duration_ = 11.1

		local var_187_0 = {
			zh = 11.1,
			ja = 8.366
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
				arg_187_0:Play320221046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 1.175

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[144].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:GetWordFromCfg(320221045)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 47
				local var_190_6 = utf8.len(var_190_4)
				local var_190_7 = var_190_5 <= 0 and var_190_1 or var_190_1 * (var_190_6 / var_190_5)

				if var_190_7 > 0 and var_190_1 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_4
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221045", "story_v_out_320221.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221045", "story_v_out_320221.awb") / 1000

					if var_190_8 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_0
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_out_320221", "320221045", "story_v_out_320221.awb")

						arg_187_1:RecordAudio("320221045", var_190_9)
						arg_187_1:RecordAudio("320221045", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_320221", "320221045", "story_v_out_320221.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_320221", "320221045", "story_v_out_320221.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_10 and arg_187_1.time_ < var_190_0 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play320221046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 320221046
		arg_191_1.duration_ = 14.13

		local var_191_0 = {
			zh = 14.133,
			ja = 13.4
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
				arg_191_0:Play320221047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 1.6

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[144].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:GetWordFromCfg(320221046)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 64
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

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221046", "story_v_out_320221.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221046", "story_v_out_320221.awb") / 1000

					if var_194_8 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_0
					end

					if var_194_3.prefab_name ~= "" and arg_191_1.actors_[var_194_3.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_3.prefab_name].transform, "story_v_out_320221", "320221046", "story_v_out_320221.awb")

						arg_191_1:RecordAudio("320221046", var_194_9)
						arg_191_1:RecordAudio("320221046", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_320221", "320221046", "story_v_out_320221.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_320221", "320221046", "story_v_out_320221.awb")
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
	Play320221047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 320221047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play320221048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.675

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[7].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:GetWordFromCfg(320221047)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 27
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
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_8 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_8 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_8

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_8 and arg_195_1.time_ < var_198_0 + var_198_8 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play320221048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 320221048
		arg_199_1.duration_ = 12.5

		local var_199_0 = {
			zh = 12.1,
			ja = 12.5
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
				arg_199_0:Play320221049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 1.3

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[144].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(320221048)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 52
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

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221048", "story_v_out_320221.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221048", "story_v_out_320221.awb") / 1000

					if var_202_8 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_0
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_out_320221", "320221048", "story_v_out_320221.awb")

						arg_199_1:RecordAudio("320221048", var_202_9)
						arg_199_1:RecordAudio("320221048", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_320221", "320221048", "story_v_out_320221.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_320221", "320221048", "story_v_out_320221.awb")
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
	Play320221049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 320221049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play320221050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.075

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[7].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_3 = arg_203_1:GetWordFromCfg(320221049)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 3
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
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_8 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_8 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_8

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_8 and arg_203_1.time_ < var_206_0 + var_206_8 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play320221050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 320221050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play320221051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.8

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_2 = arg_207_1:GetWordFromCfg(320221050)
				local var_210_3 = arg_207_1:FormatText(var_210_2.content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 32
				local var_210_5 = utf8.len(var_210_3)
				local var_210_6 = var_210_4 <= 0 and var_210_1 or var_210_1 * (var_210_5 / var_210_4)

				if var_210_6 > 0 and var_210_1 < var_210_6 then
					arg_207_1.talkMaxDuration = var_210_6

					if var_210_6 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_7 and arg_207_1.time_ < var_210_0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play320221051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 320221051
		arg_211_1.duration_ = 4.17

		local var_211_0 = {
			zh = 3.333,
			ja = 4.166
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
				arg_211_0:Play320221052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 0.3

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_2 = arg_211_1:FormatText(StoryNameCfg[144].name)

				arg_211_1.leftNameTxt_.text = var_214_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_3 = arg_211_1:GetWordFromCfg(320221051)
				local var_214_4 = arg_211_1:FormatText(var_214_3.content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221051", "story_v_out_320221.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221051", "story_v_out_320221.awb") / 1000

					if var_214_8 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_0
					end

					if var_214_3.prefab_name ~= "" and arg_211_1.actors_[var_214_3.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_3.prefab_name].transform, "story_v_out_320221", "320221051", "story_v_out_320221.awb")

						arg_211_1:RecordAudio("320221051", var_214_9)
						arg_211_1:RecordAudio("320221051", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_320221", "320221051", "story_v_out_320221.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_320221", "320221051", "story_v_out_320221.awb")
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
	Play320221052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 320221052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play320221053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 0.475

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_2 = arg_215_1:FormatText(StoryNameCfg[7].name)

				arg_215_1.leftNameTxt_.text = var_218_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:GetWordFromCfg(320221052)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 19
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
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_8 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_8 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_8

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_8 and arg_215_1.time_ < var_218_0 + var_218_8 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play320221053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 320221053
		arg_219_1.duration_ = 15.27

		local var_219_0 = {
			zh = 15.266,
			ja = 13.966
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
				arg_219_0:Play320221054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 1.45

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[144].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:GetWordFromCfg(320221053)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 58
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

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221053", "story_v_out_320221.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221053", "story_v_out_320221.awb") / 1000

					if var_222_8 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_0
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_320221", "320221053", "story_v_out_320221.awb")

						arg_219_1:RecordAudio("320221053", var_222_9)
						arg_219_1:RecordAudio("320221053", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_320221", "320221053", "story_v_out_320221.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_320221", "320221053", "story_v_out_320221.awb")
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
	Play320221054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 320221054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play320221055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.45

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_2 = arg_223_1:FormatText(StoryNameCfg[7].name)

				arg_223_1.leftNameTxt_.text = var_226_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:GetWordFromCfg(320221054)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 18
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
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_8 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_8 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_8

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_8 and arg_223_1.time_ < var_226_0 + var_226_8 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play320221055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 320221055
		arg_227_1.duration_ = 10.83

		local var_227_0 = {
			zh = 10.833,
			ja = 6.833
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
				arg_227_0:Play320221056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 1.325

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[144].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:GetWordFromCfg(320221055)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 53
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

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221055", "story_v_out_320221.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221055", "story_v_out_320221.awb") / 1000

					if var_230_8 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_0
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_out_320221", "320221055", "story_v_out_320221.awb")

						arg_227_1:RecordAudio("320221055", var_230_9)
						arg_227_1:RecordAudio("320221055", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_320221", "320221055", "story_v_out_320221.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_320221", "320221055", "story_v_out_320221.awb")
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
	Play320221056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 320221056
		arg_231_1.duration_ = 13.47

		local var_231_0 = {
			zh = 13.466,
			ja = 12.766
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
				arg_231_0:Play320221057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 1.425

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[144].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:GetWordFromCfg(320221056)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 57
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

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221056", "story_v_out_320221.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221056", "story_v_out_320221.awb") / 1000

					if var_234_8 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_0
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_out_320221", "320221056", "story_v_out_320221.awb")

						arg_231_1:RecordAudio("320221056", var_234_9)
						arg_231_1:RecordAudio("320221056", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_320221", "320221056", "story_v_out_320221.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_320221", "320221056", "story_v_out_320221.awb")
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
	Play320221057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 320221057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play320221058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 0.15

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_2 = arg_235_1:FormatText(StoryNameCfg[7].name)

				arg_235_1.leftNameTxt_.text = var_238_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_3 = arg_235_1:GetWordFromCfg(320221057)
				local var_238_4 = arg_235_1:FormatText(var_238_3.content)

				arg_235_1.text_.text = var_238_4

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 6
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
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_8 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_8 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_8

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_8 and arg_235_1.time_ < var_238_0 + var_238_8 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play320221058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 320221058
		arg_239_1.duration_ = 7.27

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play320221059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 1.16666666666667

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				local var_242_1 = manager.ui.mainCamera.transform.localPosition
				local var_242_2 = Vector3.New(0, 0, 10) + Vector3.New(var_242_1.x, var_242_1.y, 0)
				local var_242_3 = arg_239_1.bgs_.ST02

				var_242_3.transform.localPosition = var_242_2
				var_242_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_242_4 = var_242_3:GetComponent("SpriteRenderer")

				if var_242_4 and var_242_4.sprite then
					local var_242_5 = (var_242_3.transform.localPosition - var_242_1).z
					local var_242_6 = manager.ui.mainCameraCom_
					local var_242_7 = 2 * var_242_5 * Mathf.Tan(var_242_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_242_8 = var_242_7 * var_242_6.aspect
					local var_242_9 = var_242_4.sprite.bounds.size.x
					local var_242_10 = var_242_4.sprite.bounds.size.y
					local var_242_11 = var_242_8 / var_242_9
					local var_242_12 = var_242_7 / var_242_10
					local var_242_13 = var_242_12 < var_242_11 and var_242_11 or var_242_12

					var_242_3.transform.localScale = Vector3.New(var_242_13, var_242_13, 0)
				end

				for iter_242_0, iter_242_1 in pairs(arg_239_1.bgs_) do
					if iter_242_0 ~= "ST02" then
						iter_242_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_242_14 = 0

			if var_242_14 < arg_239_1.time_ and arg_239_1.time_ <= var_242_14 + arg_242_0 then
				arg_239_1.allBtn_.enabled = false
			end

			local var_242_15 = 0.3

			if arg_239_1.time_ >= var_242_14 + var_242_15 and arg_239_1.time_ < var_242_14 + var_242_15 + arg_242_0 then
				arg_239_1.allBtn_.enabled = true
			end

			local var_242_16 = 0

			if var_242_16 < arg_239_1.time_ and arg_239_1.time_ <= var_242_16 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_17 = 1.3

			if var_242_16 <= arg_239_1.time_ and arg_239_1.time_ < var_242_16 + var_242_17 then
				local var_242_18 = (arg_239_1.time_ - var_242_16) / var_242_17
				local var_242_19 = Color.New(0, 0, 0)

				var_242_19.a = Mathf.Lerp(0, 1, var_242_18)
				arg_239_1.mask_.color = var_242_19
			end

			if arg_239_1.time_ >= var_242_16 + var_242_17 and arg_239_1.time_ < var_242_16 + var_242_17 + arg_242_0 then
				local var_242_20 = Color.New(0, 0, 0)

				var_242_20.a = 1
				arg_239_1.mask_.color = var_242_20
			end

			local var_242_21 = 1.3

			if var_242_21 < arg_239_1.time_ and arg_239_1.time_ <= var_242_21 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_22 = 1.36666666666667

			if var_242_21 <= arg_239_1.time_ and arg_239_1.time_ < var_242_21 + var_242_22 then
				local var_242_23 = (arg_239_1.time_ - var_242_21) / var_242_22
				local var_242_24 = Color.New(0, 0, 0)

				var_242_24.a = Mathf.Lerp(1, 0, var_242_23)
				arg_239_1.mask_.color = var_242_24
			end

			if arg_239_1.time_ >= var_242_21 + var_242_22 and arg_239_1.time_ < var_242_21 + var_242_22 + arg_242_0 then
				local var_242_25 = Color.New(0, 0, 0)
				local var_242_26 = 0

				arg_239_1.mask_.enabled = false
				var_242_25.a = var_242_26
				arg_239_1.mask_.color = var_242_25
			end

			if arg_239_1.frameCnt_ <= 1 then
				arg_239_1.dialog_:SetActive(false)
			end

			local var_242_27 = 2.26666666666667
			local var_242_28 = 1.45

			if var_242_27 < arg_239_1.time_ and arg_239_1.time_ <= var_242_27 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0

				arg_239_1.dialog_:SetActive(true)

				arg_239_1.dialogCg_.alpha = 0

				local var_242_29 = LeanTween.value(arg_239_1.dialog_, 0, 1, 0.3)

				var_242_29:setOnUpdate(LuaHelper.FloatAction(function(arg_243_0)
					arg_239_1.dialogCg_.alpha = arg_243_0
				end))
				var_242_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_239_1.dialog_)
					var_242_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_239_1.duration_ = arg_239_1.duration_ + 0.3

				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_30 = arg_239_1:GetWordFromCfg(320221058)
				local var_242_31 = arg_239_1:FormatText(var_242_30.content)

				arg_239_1.text_.text = var_242_31

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_32 = 58
				local var_242_33 = utf8.len(var_242_31)
				local var_242_34 = var_242_32 <= 0 and var_242_28 or var_242_28 * (var_242_33 / var_242_32)

				if var_242_34 > 0 and var_242_28 < var_242_34 then
					arg_239_1.talkMaxDuration = var_242_34
					var_242_27 = var_242_27 + 0.3

					if var_242_34 + var_242_27 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_34 + var_242_27
					end
				end

				arg_239_1.text_.text = var_242_31
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_35 = var_242_27 + 0.3
			local var_242_36 = math.max(var_242_28, arg_239_1.talkMaxDuration)

			if var_242_35 <= arg_239_1.time_ and arg_239_1.time_ < var_242_35 + var_242_36 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_35) / var_242_36

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_35 + var_242_36 and arg_239_1.time_ < var_242_35 + var_242_36 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play320221059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 320221059
		arg_245_1.duration_ = 8.73

		local var_245_0 = {
			zh = 7.9,
			ja = 8.733
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
				arg_245_0:Play320221060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.975

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[144].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:GetWordFromCfg(320221059)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 39
				local var_248_6 = utf8.len(var_248_4)
				local var_248_7 = var_248_5 <= 0 and var_248_1 or var_248_1 * (var_248_6 / var_248_5)

				if var_248_7 > 0 and var_248_1 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221059", "story_v_out_320221.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221059", "story_v_out_320221.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_320221", "320221059", "story_v_out_320221.awb")

						arg_245_1:RecordAudio("320221059", var_248_9)
						arg_245_1:RecordAudio("320221059", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_320221", "320221059", "story_v_out_320221.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_320221", "320221059", "story_v_out_320221.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_10 and arg_245_1.time_ < var_248_0 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play320221060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 320221060
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play320221061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 1.275

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_2 = arg_249_1:FormatText(StoryNameCfg[7].name)

				arg_249_1.leftNameTxt_.text = var_252_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:GetWordFromCfg(320221060)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 51
				local var_252_6 = utf8.len(var_252_4)
				local var_252_7 = var_252_5 <= 0 and var_252_1 or var_252_1 * (var_252_6 / var_252_5)

				if var_252_7 > 0 and var_252_1 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_8 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_8 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_8

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_8 and arg_249_1.time_ < var_252_0 + var_252_8 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play320221061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 320221061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play320221062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.95

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_2 = arg_253_1:GetWordFromCfg(320221061)
				local var_256_3 = arg_253_1:FormatText(var_256_2.content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 38
				local var_256_5 = utf8.len(var_256_3)
				local var_256_6 = var_256_4 <= 0 and var_256_1 or var_256_1 * (var_256_5 / var_256_4)

				if var_256_6 > 0 and var_256_1 < var_256_6 then
					arg_253_1.talkMaxDuration = var_256_6

					if var_256_6 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_6 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_7 and arg_253_1.time_ < var_256_0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play320221062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 320221062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play320221063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.35

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[7].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(320221062)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 14
				local var_260_6 = utf8.len(var_260_4)
				local var_260_7 = var_260_5 <= 0 and var_260_1 or var_260_1 * (var_260_6 / var_260_5)

				if var_260_7 > 0 and var_260_1 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_8 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_8 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_8

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_8 and arg_257_1.time_ < var_260_0 + var_260_8 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play320221063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 320221063
		arg_261_1.duration_ = 5.13

		local var_261_0 = {
			zh = 4.933,
			ja = 5.133
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
				arg_261_0:Play320221064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.45

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[144].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:GetWordFromCfg(320221063)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 18
				local var_264_6 = utf8.len(var_264_4)
				local var_264_7 = var_264_5 <= 0 and var_264_1 or var_264_1 * (var_264_6 / var_264_5)

				if var_264_7 > 0 and var_264_1 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221063", "story_v_out_320221.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221063", "story_v_out_320221.awb") / 1000

					if var_264_8 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_0
					end

					if var_264_3.prefab_name ~= "" and arg_261_1.actors_[var_264_3.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_3.prefab_name].transform, "story_v_out_320221", "320221063", "story_v_out_320221.awb")

						arg_261_1:RecordAudio("320221063", var_264_9)
						arg_261_1:RecordAudio("320221063", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_320221", "320221063", "story_v_out_320221.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_320221", "320221063", "story_v_out_320221.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_10 and arg_261_1.time_ < var_264_0 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play320221064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 320221064
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play320221065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.75

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[7].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_3 = arg_265_1:GetWordFromCfg(320221064)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 30
				local var_268_6 = utf8.len(var_268_4)
				local var_268_7 = var_268_5 <= 0 and var_268_1 or var_268_1 * (var_268_6 / var_268_5)

				if var_268_7 > 0 and var_268_1 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_8 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_8 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_8

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_8 and arg_265_1.time_ < var_268_0 + var_268_8 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play320221065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 320221065
		arg_269_1.duration_ = 7.3

		local var_269_0 = {
			zh = 3.333,
			ja = 7.3
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
				arg_269_0:Play320221066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 0.4

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_2 = arg_269_1:FormatText(StoryNameCfg[144].name)

				arg_269_1.leftNameTxt_.text = var_272_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_3 = arg_269_1:GetWordFromCfg(320221065)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 16
				local var_272_6 = utf8.len(var_272_4)
				local var_272_7 = var_272_5 <= 0 and var_272_1 or var_272_1 * (var_272_6 / var_272_5)

				if var_272_7 > 0 and var_272_1 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221065", "story_v_out_320221.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221065", "story_v_out_320221.awb") / 1000

					if var_272_8 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_0
					end

					if var_272_3.prefab_name ~= "" and arg_269_1.actors_[var_272_3.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_3.prefab_name].transform, "story_v_out_320221", "320221065", "story_v_out_320221.awb")

						arg_269_1:RecordAudio("320221065", var_272_9)
						arg_269_1:RecordAudio("320221065", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_320221", "320221065", "story_v_out_320221.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_320221", "320221065", "story_v_out_320221.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_10 and arg_269_1.time_ < var_272_0 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play320221066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 320221066
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play320221067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 0.375

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_2 = arg_273_1:FormatText(StoryNameCfg[7].name)

				arg_273_1.leftNameTxt_.text = var_276_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_3 = arg_273_1:GetWordFromCfg(320221066)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 15
				local var_276_6 = utf8.len(var_276_4)
				local var_276_7 = var_276_5 <= 0 and var_276_1 or var_276_1 * (var_276_6 / var_276_5)

				if var_276_7 > 0 and var_276_1 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_8 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_8 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_8

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_8 and arg_273_1.time_ < var_276_0 + var_276_8 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play320221067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 320221067
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play320221068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 1.275

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_2 = arg_277_1:GetWordFromCfg(320221067)
				local var_280_3 = arg_277_1:FormatText(var_280_2.content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 51
				local var_280_5 = utf8.len(var_280_3)
				local var_280_6 = var_280_4 <= 0 and var_280_1 or var_280_1 * (var_280_5 / var_280_4)

				if var_280_6 > 0 and var_280_1 < var_280_6 then
					arg_277_1.talkMaxDuration = var_280_6

					if var_280_6 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_6 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_7 and arg_277_1.time_ < var_280_0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play320221068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 320221068
		arg_281_1.duration_ = 4.27

		local var_281_0 = {
			zh = 2.6,
			ja = 4.266
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play320221069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 0.25

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_2 = arg_281_1:FormatText(StoryNameCfg[144].name)

				arg_281_1.leftNameTxt_.text = var_284_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_3 = arg_281_1:GetWordFromCfg(320221068)
				local var_284_4 = arg_281_1:FormatText(var_284_3.content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 10
				local var_284_6 = utf8.len(var_284_4)
				local var_284_7 = var_284_5 <= 0 and var_284_1 or var_284_1 * (var_284_6 / var_284_5)

				if var_284_7 > 0 and var_284_1 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_4
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320221", "320221068", "story_v_out_320221.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_out_320221", "320221068", "story_v_out_320221.awb") / 1000

					if var_284_8 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_0
					end

					if var_284_3.prefab_name ~= "" and arg_281_1.actors_[var_284_3.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_3.prefab_name].transform, "story_v_out_320221", "320221068", "story_v_out_320221.awb")

						arg_281_1:RecordAudio("320221068", var_284_9)
						arg_281_1:RecordAudio("320221068", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_320221", "320221068", "story_v_out_320221.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_320221", "320221068", "story_v_out_320221.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_10 and arg_281_1.time_ < var_284_0 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play320221069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 320221069
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
			arg_285_1.auto_ = false
		end

		function arg_285_1.playNext_(arg_287_0)
			arg_285_1.onStoryFinished_()
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.55

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_2 = arg_285_1:FormatText(StoryNameCfg[7].name)

				arg_285_1.leftNameTxt_.text = var_288_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_3 = arg_285_1:GetWordFromCfg(320221069)
				local var_288_4 = arg_285_1:FormatText(var_288_3.content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 22
				local var_288_6 = utf8.len(var_288_4)
				local var_288_7 = var_288_5 <= 0 and var_288_1 or var_288_1 * (var_288_6 / var_288_5)

				if var_288_7 > 0 and var_288_1 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_8 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_8 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_8

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_8 and arg_285_1.time_ < var_288_0 + var_288_8 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/ST02"
	},
	voices = {
		"story_v_out_320221.awb"
	}
}
