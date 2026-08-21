return {
	Play324141001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324141001
		arg_1_1.duration_ = 6.8

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324141002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J15"

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
				local var_4_5 = arg_1_1.bgs_.J15

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
					if iter_4_0 ~= "J15" then
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

			local var_4_24 = 0.1
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_150", "se_story_150_amb_painting", "")
			end

			local var_4_28 = 0
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_32 = 1
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_activity_2_2_story_ruomuhuajing", "bgm_activity_2_2_story_ruomuhuajing", "bgm_activity_2_2_story_ruomuhuajing.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_activity_2_2_story_ruomuhuajing", "bgm_activity_2_2_story_ruomuhuajing")

				if var_4_37 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_37 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_37

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_37
						arg_1_1.bgmTxt2_.text = var_4_37
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

			local var_4_38 = 1.8
			local var_4_39 = 1.15

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
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

				local var_4_41 = arg_1_1:GetWordFromCfg(324141001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 46
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
	Play324141002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324141002
		arg_8_1.duration_ = 3.7

		local var_8_0 = {
			zh = 2.266,
			ja = 3.7
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324141003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1170ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1170ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1170ui_story"), arg_8_1.stage_.transform)

					var_11_2.name = var_11_0
					var_11_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_0] = var_11_2

					local var_11_3 = var_11_2:GetComponentInChildren(typeof(CharacterEffect))

					var_11_3.enabled = true

					local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_2, typeof(DynamicBoneHelper))

					if var_11_4 then
						var_11_4:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_3.transform, false)

					arg_8_1.var_[var_11_0 .. "Animator"] = var_11_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_0 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_0 .. "LipSync"] = var_11_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_5 = arg_8_1.actors_["1170ui_story"].transform
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.var_.moveOldPos1170ui_story = var_11_5.localPosition

				local var_11_7 = GameObjectTools.GetOrAddComponent(var_11_5.gameObject, typeof(DynamicBoneHelper))

				if var_11_7 then
					var_11_7:EnableDynamicBone(false)
				end
			end

			local var_11_8 = 0.001

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_8 then
				local var_11_9 = (arg_8_1.time_ - var_11_6) / var_11_8
				local var_11_10 = Vector3.New(0.03, -0.95, -6.08)

				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1170ui_story, var_11_10, var_11_9)

				local var_11_11 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_11.x, var_11_11.y, var_11_11.z)

				local var_11_12 = var_11_5.localEulerAngles

				var_11_12.z = 0
				var_11_12.x = 0
				var_11_5.localEulerAngles = var_11_12
			end

			if arg_8_1.time_ >= var_11_6 + var_11_8 and arg_8_1.time_ < var_11_6 + var_11_8 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(0.03, -0.95, -6.08)

				local var_11_13 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_13.x, var_11_13.y, var_11_13.z)

				local var_11_14 = var_11_5.localEulerAngles

				var_11_14.z = 0
				var_11_14.x = 0
				var_11_5.localEulerAngles = var_11_14

				local var_11_15 = GameObjectTools.GetOrAddComponent(var_11_5.gameObject, typeof(DynamicBoneHelper))

				if var_11_15 then
					var_11_15:EnableDynamicBone(true)
				end
			end

			local var_11_16 = arg_8_1.actors_["1170ui_story"]
			local var_11_17 = 0

			if var_11_17 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 and not isNil(var_11_16) and arg_8_1.var_.characterEffect1170ui_story == nil then
				arg_8_1.var_.characterEffect1170ui_story = var_11_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_18 = 0.200000002980232

			if var_11_17 <= arg_8_1.time_ and arg_8_1.time_ < var_11_17 + var_11_18 and not isNil(var_11_16) then
				local var_11_19 = (arg_8_1.time_ - var_11_17) / var_11_18

				if arg_8_1.var_.characterEffect1170ui_story and not isNil(var_11_16) then
					arg_8_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_17 + var_11_18 and arg_8_1.time_ < var_11_17 + var_11_18 + arg_11_0 and not isNil(var_11_16) and arg_8_1.var_.characterEffect1170ui_story then
				arg_8_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_11_20 = 0

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action1_1")
			end

			local var_11_21 = 0

			if var_11_21 < arg_8_1.time_ and arg_8_1.time_ <= var_11_21 + arg_11_0 then
				arg_8_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_11_22 = 0
			local var_11_23 = 0.275

			if var_11_22 < arg_8_1.time_ and arg_8_1.time_ <= var_11_22 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_24 = arg_8_1:FormatText(StoryNameCfg[318].name)

				arg_8_1.leftNameTxt_.text = var_11_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_25 = arg_8_1:GetWordFromCfg(324141002)
				local var_11_26 = arg_8_1:FormatText(var_11_25.content)

				arg_8_1.text_.text = var_11_26

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_27 = 11
				local var_11_28 = utf8.len(var_11_26)
				local var_11_29 = var_11_27 <= 0 and var_11_23 or var_11_23 * (var_11_28 / var_11_27)

				if var_11_29 > 0 and var_11_23 < var_11_29 then
					arg_8_1.talkMaxDuration = var_11_29

					if var_11_29 + var_11_22 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_29 + var_11_22
					end
				end

				arg_8_1.text_.text = var_11_26
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324141", "324141002", "story_v_out_324141.awb") ~= 0 then
					local var_11_30 = manager.audio:GetVoiceLength("story_v_out_324141", "324141002", "story_v_out_324141.awb") / 1000

					if var_11_30 + var_11_22 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_30 + var_11_22
					end

					if var_11_25.prefab_name ~= "" and arg_8_1.actors_[var_11_25.prefab_name] ~= nil then
						local var_11_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_25.prefab_name].transform, "story_v_out_324141", "324141002", "story_v_out_324141.awb")

						arg_8_1:RecordAudio("324141002", var_11_31)
						arg_8_1:RecordAudio("324141002", var_11_31)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_324141", "324141002", "story_v_out_324141.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_324141", "324141002", "story_v_out_324141.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_32 = math.max(var_11_23, arg_8_1.talkMaxDuration)

			if var_11_22 <= arg_8_1.time_ and arg_8_1.time_ < var_11_22 + var_11_32 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_22) / var_11_32

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_22 + var_11_32 and arg_8_1.time_ < var_11_22 + var_11_32 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play324141003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324141003
		arg_12_1.duration_ = 7.6

		local var_12_0 = {
			zh = 4.833,
			ja = 7.6
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
				arg_12_0:Play324141004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1170ui_story"].transform
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.var_.moveOldPos1170ui_story = var_15_0.localPosition

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0.gameObject, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end
			end

			local var_15_3 = 0.001

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_3 then
				local var_15_4 = (arg_12_1.time_ - var_15_1) / var_15_3
				local var_15_5 = Vector3.New(-0.68, -0.95, -6.08)

				var_15_0.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1170ui_story, var_15_5, var_15_4)

				local var_15_6 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_6.x, var_15_6.y, var_15_6.z)

				local var_15_7 = var_15_0.localEulerAngles

				var_15_7.z = 0
				var_15_7.x = 0
				var_15_0.localEulerAngles = var_15_7
			end

			if arg_12_1.time_ >= var_15_1 + var_15_3 and arg_12_1.time_ < var_15_1 + var_15_3 + arg_15_0 then
				var_15_0.localPosition = Vector3.New(-0.68, -0.95, -6.08)

				local var_15_8 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_8.x, var_15_8.y, var_15_8.z)

				local var_15_9 = var_15_0.localEulerAngles

				var_15_9.z = 0
				var_15_9.x = 0
				var_15_0.localEulerAngles = var_15_9

				local var_15_10 = GameObjectTools.GetOrAddComponent(var_15_0.gameObject, typeof(DynamicBoneHelper))

				if var_15_10 then
					var_15_10:EnableDynamicBone(true)
				end
			end

			local var_15_11 = "1053ui_story"

			if arg_12_1.actors_[var_15_11] == nil then
				local var_15_12 = Asset.Load("Char/" .. "1053ui_story")

				if not isNil(var_15_12) then
					local var_15_13 = Object.Instantiate(Asset.Load("Char/" .. "1053ui_story"), arg_12_1.stage_.transform)

					var_15_13.name = var_15_11
					var_15_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_12_1.actors_[var_15_11] = var_15_13

					local var_15_14 = var_15_13:GetComponentInChildren(typeof(CharacterEffect))

					var_15_14.enabled = true

					local var_15_15 = GameObjectTools.GetOrAddComponent(var_15_13, typeof(DynamicBoneHelper))

					if var_15_15 then
						var_15_15:EnableDynamicBone(false)
					end

					arg_12_1:ShowWeapon(var_15_14.transform, false)

					arg_12_1.var_[var_15_11 .. "Animator"] = var_15_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_12_1.var_[var_15_11 .. "Animator"].applyRootMotion = true
					arg_12_1.var_[var_15_11 .. "LipSync"] = var_15_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_15_16 = arg_12_1.actors_["1053ui_story"].transform
			local var_15_17 = 0

			if var_15_17 < arg_12_1.time_ and arg_12_1.time_ <= var_15_17 + arg_15_0 then
				arg_12_1.var_.moveOldPos1053ui_story = var_15_16.localPosition

				local var_15_18 = GameObjectTools.GetOrAddComponent(var_15_16.gameObject, typeof(DynamicBoneHelper))

				if var_15_18 then
					var_15_18:EnableDynamicBone(false)
				end
			end

			local var_15_19 = 0.001

			if var_15_17 <= arg_12_1.time_ and arg_12_1.time_ < var_15_17 + var_15_19 then
				local var_15_20 = (arg_12_1.time_ - var_15_17) / var_15_19
				local var_15_21 = Vector3.New(0.7, -1.08, -6)

				var_15_16.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1053ui_story, var_15_21, var_15_20)

				local var_15_22 = manager.ui.mainCamera.transform.position - var_15_16.position

				var_15_16.forward = Vector3.New(var_15_22.x, var_15_22.y, var_15_22.z)

				local var_15_23 = var_15_16.localEulerAngles

				var_15_23.z = 0
				var_15_23.x = 0
				var_15_16.localEulerAngles = var_15_23
			end

			if arg_12_1.time_ >= var_15_17 + var_15_19 and arg_12_1.time_ < var_15_17 + var_15_19 + arg_15_0 then
				var_15_16.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_15_24 = manager.ui.mainCamera.transform.position - var_15_16.position

				var_15_16.forward = Vector3.New(var_15_24.x, var_15_24.y, var_15_24.z)

				local var_15_25 = var_15_16.localEulerAngles

				var_15_25.z = 0
				var_15_25.x = 0
				var_15_16.localEulerAngles = var_15_25

				local var_15_26 = GameObjectTools.GetOrAddComponent(var_15_16.gameObject, typeof(DynamicBoneHelper))

				if var_15_26 then
					var_15_26:EnableDynamicBone(true)
				end
			end

			local var_15_27 = arg_12_1.actors_["1053ui_story"]
			local var_15_28 = 0

			if var_15_28 < arg_12_1.time_ and arg_12_1.time_ <= var_15_28 + arg_15_0 and not isNil(var_15_27) and arg_12_1.var_.characterEffect1053ui_story == nil then
				arg_12_1.var_.characterEffect1053ui_story = var_15_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_29 = 0.200000002980232

			if var_15_28 <= arg_12_1.time_ and arg_12_1.time_ < var_15_28 + var_15_29 and not isNil(var_15_27) then
				local var_15_30 = (arg_12_1.time_ - var_15_28) / var_15_29

				if arg_12_1.var_.characterEffect1053ui_story and not isNil(var_15_27) then
					arg_12_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_28 + var_15_29 and arg_12_1.time_ < var_15_28 + var_15_29 + arg_15_0 and not isNil(var_15_27) and arg_12_1.var_.characterEffect1053ui_story then
				arg_12_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_15_31 = arg_12_1.actors_["1170ui_story"]
			local var_15_32 = 0

			if var_15_32 < arg_12_1.time_ and arg_12_1.time_ <= var_15_32 + arg_15_0 and not isNil(var_15_31) and arg_12_1.var_.characterEffect1170ui_story == nil then
				arg_12_1.var_.characterEffect1170ui_story = var_15_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_33 = 0.200000002980232

			if var_15_32 <= arg_12_1.time_ and arg_12_1.time_ < var_15_32 + var_15_33 and not isNil(var_15_31) then
				local var_15_34 = (arg_12_1.time_ - var_15_32) / var_15_33

				if arg_12_1.var_.characterEffect1170ui_story and not isNil(var_15_31) then
					local var_15_35 = Mathf.Lerp(0, 0.5, var_15_34)

					arg_12_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1170ui_story.fillRatio = var_15_35
				end
			end

			if arg_12_1.time_ >= var_15_32 + var_15_33 and arg_12_1.time_ < var_15_32 + var_15_33 + arg_15_0 and not isNil(var_15_31) and arg_12_1.var_.characterEffect1170ui_story then
				local var_15_36 = 0.5

				arg_12_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1170ui_story.fillRatio = var_15_36
			end

			local var_15_37 = 0

			if var_15_37 < arg_12_1.time_ and arg_12_1.time_ <= var_15_37 + arg_15_0 then
				arg_12_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			local var_15_38 = 0

			if var_15_38 < arg_12_1.time_ and arg_12_1.time_ <= var_15_38 + arg_15_0 then
				arg_12_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_15_39 = 0
			local var_15_40 = 0.475

			if var_15_39 < arg_12_1.time_ and arg_12_1.time_ <= var_15_39 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_41 = arg_12_1:FormatText(StoryNameCfg[472].name)

				arg_12_1.leftNameTxt_.text = var_15_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_42 = arg_12_1:GetWordFromCfg(324141003)
				local var_15_43 = arg_12_1:FormatText(var_15_42.content)

				arg_12_1.text_.text = var_15_43

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_44 = 19
				local var_15_45 = utf8.len(var_15_43)
				local var_15_46 = var_15_44 <= 0 and var_15_40 or var_15_40 * (var_15_45 / var_15_44)

				if var_15_46 > 0 and var_15_40 < var_15_46 then
					arg_12_1.talkMaxDuration = var_15_46

					if var_15_46 + var_15_39 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_46 + var_15_39
					end
				end

				arg_12_1.text_.text = var_15_43
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324141", "324141003", "story_v_out_324141.awb") ~= 0 then
					local var_15_47 = manager.audio:GetVoiceLength("story_v_out_324141", "324141003", "story_v_out_324141.awb") / 1000

					if var_15_47 + var_15_39 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_47 + var_15_39
					end

					if var_15_42.prefab_name ~= "" and arg_12_1.actors_[var_15_42.prefab_name] ~= nil then
						local var_15_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_42.prefab_name].transform, "story_v_out_324141", "324141003", "story_v_out_324141.awb")

						arg_12_1:RecordAudio("324141003", var_15_48)
						arg_12_1:RecordAudio("324141003", var_15_48)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_324141", "324141003", "story_v_out_324141.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_324141", "324141003", "story_v_out_324141.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_49 = math.max(var_15_40, arg_12_1.talkMaxDuration)

			if var_15_39 <= arg_12_1.time_ and arg_12_1.time_ < var_15_39 + var_15_49 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_39) / var_15_49

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_39 + var_15_49 and arg_12_1.time_ < var_15_39 + var_15_49 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play324141004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324141004
		arg_16_1.duration_ = 5.73

		local var_16_0 = {
			zh = 5.666,
			ja = 5.733
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
				arg_16_0:Play324141005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1037ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["1037ui_story"]
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1037ui_story == nil then
				arg_16_1.var_.characterEffect1037ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.200000002980232

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 and not isNil(var_19_5) then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7

				if arg_16_1.var_.characterEffect1037ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1037ui_story then
				arg_16_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_19_9 = arg_16_1.actors_["1053ui_story"]
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1053ui_story == nil then
				arg_16_1.var_.characterEffect1053ui_story = var_19_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_11 = 0.200000002980232

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 and not isNil(var_19_9) then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11

				if arg_16_1.var_.characterEffect1053ui_story and not isNil(var_19_9) then
					local var_19_13 = Mathf.Lerp(0, 0.5, var_19_12)

					arg_16_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1053ui_story.fillRatio = var_19_13
				end
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1053ui_story then
				local var_19_14 = 0.5

				arg_16_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1053ui_story.fillRatio = var_19_14
			end

			local var_19_15 = 0
			local var_19_16 = 0.325

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_17 = arg_16_1:FormatText(StoryNameCfg[36].name)

				arg_16_1.leftNameTxt_.text = var_19_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_18 = arg_16_1:GetWordFromCfg(324141004)
				local var_19_19 = arg_16_1:FormatText(var_19_18.content)

				arg_16_1.text_.text = var_19_19

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_20 = 13
				local var_19_21 = utf8.len(var_19_19)
				local var_19_22 = var_19_20 <= 0 and var_19_16 or var_19_16 * (var_19_21 / var_19_20)

				if var_19_22 > 0 and var_19_16 < var_19_22 then
					arg_16_1.talkMaxDuration = var_19_22

					if var_19_22 + var_19_15 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_22 + var_19_15
					end
				end

				arg_16_1.text_.text = var_19_19
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324141", "324141004", "story_v_out_324141.awb") ~= 0 then
					local var_19_23 = manager.audio:GetVoiceLength("story_v_out_324141", "324141004", "story_v_out_324141.awb") / 1000

					if var_19_23 + var_19_15 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_23 + var_19_15
					end

					if var_19_18.prefab_name ~= "" and arg_16_1.actors_[var_19_18.prefab_name] ~= nil then
						local var_19_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_18.prefab_name].transform, "story_v_out_324141", "324141004", "story_v_out_324141.awb")

						arg_16_1:RecordAudio("324141004", var_19_24)
						arg_16_1:RecordAudio("324141004", var_19_24)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_324141", "324141004", "story_v_out_324141.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_324141", "324141004", "story_v_out_324141.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_25 = math.max(var_19_16, arg_16_1.talkMaxDuration)

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_25 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_15) / var_19_25

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_15 + var_19_25 and arg_16_1.time_ < var_19_15 + var_19_25 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play324141005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324141005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play324141006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1170ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos1170ui_story = var_23_0.localPosition

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0.gameObject, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end
			end

			local var_23_3 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_3 then
				local var_23_4 = (arg_20_1.time_ - var_23_1) / var_23_3
				local var_23_5 = Vector3.New(0, 100, 0)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1170ui_story, var_23_5, var_23_4)

				local var_23_6 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_6.x, var_23_6.y, var_23_6.z)

				local var_23_7 = var_23_0.localEulerAngles

				var_23_7.z = 0
				var_23_7.x = 0
				var_23_0.localEulerAngles = var_23_7
			end

			if arg_20_1.time_ >= var_23_1 + var_23_3 and arg_20_1.time_ < var_23_1 + var_23_3 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0, 100, 0)

				local var_23_8 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_8.x, var_23_8.y, var_23_8.z)

				local var_23_9 = var_23_0.localEulerAngles

				var_23_9.z = 0
				var_23_9.x = 0
				var_23_0.localEulerAngles = var_23_9

				local var_23_10 = GameObjectTools.GetOrAddComponent(var_23_0.gameObject, typeof(DynamicBoneHelper))

				if var_23_10 then
					var_23_10:EnableDynamicBone(true)
				end
			end

			local var_23_11 = arg_20_1.actors_["1053ui_story"].transform
			local var_23_12 = 0

			if var_23_12 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 then
				arg_20_1.var_.moveOldPos1053ui_story = var_23_11.localPosition

				local var_23_13 = GameObjectTools.GetOrAddComponent(var_23_11.gameObject, typeof(DynamicBoneHelper))

				if var_23_13 then
					var_23_13:EnableDynamicBone(false)
				end
			end

			local var_23_14 = 0.001

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_14 then
				local var_23_15 = (arg_20_1.time_ - var_23_12) / var_23_14
				local var_23_16 = Vector3.New(0, 100, 0)

				var_23_11.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1053ui_story, var_23_16, var_23_15)

				local var_23_17 = manager.ui.mainCamera.transform.position - var_23_11.position

				var_23_11.forward = Vector3.New(var_23_17.x, var_23_17.y, var_23_17.z)

				local var_23_18 = var_23_11.localEulerAngles

				var_23_18.z = 0
				var_23_18.x = 0
				var_23_11.localEulerAngles = var_23_18
			end

			if arg_20_1.time_ >= var_23_12 + var_23_14 and arg_20_1.time_ < var_23_12 + var_23_14 + arg_23_0 then
				var_23_11.localPosition = Vector3.New(0, 100, 0)

				local var_23_19 = manager.ui.mainCamera.transform.position - var_23_11.position

				var_23_11.forward = Vector3.New(var_23_19.x, var_23_19.y, var_23_19.z)

				local var_23_20 = var_23_11.localEulerAngles

				var_23_20.z = 0
				var_23_20.x = 0
				var_23_11.localEulerAngles = var_23_20

				local var_23_21 = GameObjectTools.GetOrAddComponent(var_23_11.gameObject, typeof(DynamicBoneHelper))

				if var_23_21 then
					var_23_21:EnableDynamicBone(true)
				end
			end

			local var_23_22 = arg_20_1.actors_["1037ui_story"]
			local var_23_23 = 0

			if var_23_23 < arg_20_1.time_ and arg_20_1.time_ <= var_23_23 + arg_23_0 and not isNil(var_23_22) and arg_20_1.var_.characterEffect1037ui_story == nil then
				arg_20_1.var_.characterEffect1037ui_story = var_23_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_24 = 0.200000002980232

			if var_23_23 <= arg_20_1.time_ and arg_20_1.time_ < var_23_23 + var_23_24 and not isNil(var_23_22) then
				local var_23_25 = (arg_20_1.time_ - var_23_23) / var_23_24

				if arg_20_1.var_.characterEffect1037ui_story and not isNil(var_23_22) then
					local var_23_26 = Mathf.Lerp(0, 0.5, var_23_25)

					arg_20_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1037ui_story.fillRatio = var_23_26
				end
			end

			if arg_20_1.time_ >= var_23_23 + var_23_24 and arg_20_1.time_ < var_23_23 + var_23_24 + arg_23_0 and not isNil(var_23_22) and arg_20_1.var_.characterEffect1037ui_story then
				local var_23_27 = 0.5

				arg_20_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1037ui_story.fillRatio = var_23_27
			end

			local var_23_28 = 0
			local var_23_29 = 1.025

			if var_23_28 < arg_20_1.time_ and arg_20_1.time_ <= var_23_28 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_30 = arg_20_1:GetWordFromCfg(324141005)
				local var_23_31 = arg_20_1:FormatText(var_23_30.content)

				arg_20_1.text_.text = var_23_31

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_32 = 41
				local var_23_33 = utf8.len(var_23_31)
				local var_23_34 = var_23_32 <= 0 and var_23_29 or var_23_29 * (var_23_33 / var_23_32)

				if var_23_34 > 0 and var_23_29 < var_23_34 then
					arg_20_1.talkMaxDuration = var_23_34

					if var_23_34 + var_23_28 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_34 + var_23_28
					end
				end

				arg_20_1.text_.text = var_23_31
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_35 = math.max(var_23_29, arg_20_1.talkMaxDuration)

			if var_23_28 <= arg_20_1.time_ and arg_20_1.time_ < var_23_28 + var_23_35 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_28) / var_23_35

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_28 + var_23_35 and arg_20_1.time_ < var_23_28 + var_23_35 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play324141006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324141006
		arg_24_1.duration_ = 9

		local var_24_0 = {
			zh = 7.333,
			ja = 9
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324141007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1037ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1037ui_story == nil then
				arg_24_1.var_.characterEffect1037ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1037ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1037ui_story then
				arg_24_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_27_4 = 0
			local var_27_5 = 0.575

			if var_27_4 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_6 = arg_24_1:FormatText(StoryNameCfg[36].name)

				arg_24_1.leftNameTxt_.text = var_27_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_7 = arg_24_1:GetWordFromCfg(324141006)
				local var_27_8 = arg_24_1:FormatText(var_27_7.content)

				arg_24_1.text_.text = var_27_8

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_9 = 23
				local var_27_10 = utf8.len(var_27_8)
				local var_27_11 = var_27_9 <= 0 and var_27_5 or var_27_5 * (var_27_10 / var_27_9)

				if var_27_11 > 0 and var_27_5 < var_27_11 then
					arg_24_1.talkMaxDuration = var_27_11

					if var_27_11 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_11 + var_27_4
					end
				end

				arg_24_1.text_.text = var_27_8
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324141", "324141006", "story_v_out_324141.awb") ~= 0 then
					local var_27_12 = manager.audio:GetVoiceLength("story_v_out_324141", "324141006", "story_v_out_324141.awb") / 1000

					if var_27_12 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_12 + var_27_4
					end

					if var_27_7.prefab_name ~= "" and arg_24_1.actors_[var_27_7.prefab_name] ~= nil then
						local var_27_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_7.prefab_name].transform, "story_v_out_324141", "324141006", "story_v_out_324141.awb")

						arg_24_1:RecordAudio("324141006", var_27_13)
						arg_24_1:RecordAudio("324141006", var_27_13)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_324141", "324141006", "story_v_out_324141.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_324141", "324141006", "story_v_out_324141.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_14 = math.max(var_27_5, arg_24_1.talkMaxDuration)

			if var_27_4 <= arg_24_1.time_ and arg_24_1.time_ < var_27_4 + var_27_14 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_4) / var_27_14

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_4 + var_27_14 and arg_24_1.time_ < var_27_4 + var_27_14 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play324141007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324141007
		arg_28_1.duration_ = 5.27

		local var_28_0 = {
			zh = 3.3,
			ja = 5.266
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
				arg_28_0:Play324141008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1170ui_story"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos1170ui_story = var_31_0.localPosition

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0.gameObject, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end
			end

			local var_31_3 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_3 then
				local var_31_4 = (arg_28_1.time_ - var_31_1) / var_31_3
				local var_31_5 = Vector3.New(0.03, -0.95, -6.08)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1170ui_story, var_31_5, var_31_4)

				local var_31_6 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_6.x, var_31_6.y, var_31_6.z)

				local var_31_7 = var_31_0.localEulerAngles

				var_31_7.z = 0
				var_31_7.x = 0
				var_31_0.localEulerAngles = var_31_7
			end

			if arg_28_1.time_ >= var_31_1 + var_31_3 and arg_28_1.time_ < var_31_1 + var_31_3 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(0.03, -0.95, -6.08)

				local var_31_8 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_8.x, var_31_8.y, var_31_8.z)

				local var_31_9 = var_31_0.localEulerAngles

				var_31_9.z = 0
				var_31_9.x = 0
				var_31_0.localEulerAngles = var_31_9

				local var_31_10 = GameObjectTools.GetOrAddComponent(var_31_0.gameObject, typeof(DynamicBoneHelper))

				if var_31_10 then
					var_31_10:EnableDynamicBone(true)
				end
			end

			local var_31_11 = arg_28_1.actors_["1170ui_story"]
			local var_31_12 = 0

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 and not isNil(var_31_11) and arg_28_1.var_.characterEffect1170ui_story == nil then
				arg_28_1.var_.characterEffect1170ui_story = var_31_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_13 = 0.200000002980232

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_13 and not isNil(var_31_11) then
				local var_31_14 = (arg_28_1.time_ - var_31_12) / var_31_13

				if arg_28_1.var_.characterEffect1170ui_story and not isNil(var_31_11) then
					arg_28_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_12 + var_31_13 and arg_28_1.time_ < var_31_12 + var_31_13 + arg_31_0 and not isNil(var_31_11) and arg_28_1.var_.characterEffect1170ui_story then
				arg_28_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_31_15 = arg_28_1.actors_["1037ui_story"]
			local var_31_16 = 0

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 and not isNil(var_31_15) and arg_28_1.var_.characterEffect1037ui_story == nil then
				arg_28_1.var_.characterEffect1037ui_story = var_31_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_17 = 0.200000002980232

			if var_31_16 <= arg_28_1.time_ and arg_28_1.time_ < var_31_16 + var_31_17 and not isNil(var_31_15) then
				local var_31_18 = (arg_28_1.time_ - var_31_16) / var_31_17

				if arg_28_1.var_.characterEffect1037ui_story and not isNil(var_31_15) then
					local var_31_19 = Mathf.Lerp(0, 0.5, var_31_18)

					arg_28_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1037ui_story.fillRatio = var_31_19
				end
			end

			if arg_28_1.time_ >= var_31_16 + var_31_17 and arg_28_1.time_ < var_31_16 + var_31_17 + arg_31_0 and not isNil(var_31_15) and arg_28_1.var_.characterEffect1037ui_story then
				local var_31_20 = 0.5

				arg_28_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1037ui_story.fillRatio = var_31_20
			end

			local var_31_21 = 0

			if var_31_21 < arg_28_1.time_ and arg_28_1.time_ <= var_31_21 + arg_31_0 then
				arg_28_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action1_1")
			end

			local var_31_22 = 0

			if var_31_22 < arg_28_1.time_ and arg_28_1.time_ <= var_31_22 + arg_31_0 then
				arg_28_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_31_23 = 0
			local var_31_24 = 0.325

			if var_31_23 < arg_28_1.time_ and arg_28_1.time_ <= var_31_23 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_25 = arg_28_1:FormatText(StoryNameCfg[318].name)

				arg_28_1.leftNameTxt_.text = var_31_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_26 = arg_28_1:GetWordFromCfg(324141007)
				local var_31_27 = arg_28_1:FormatText(var_31_26.content)

				arg_28_1.text_.text = var_31_27

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_28 = 13
				local var_31_29 = utf8.len(var_31_27)
				local var_31_30 = var_31_28 <= 0 and var_31_24 or var_31_24 * (var_31_29 / var_31_28)

				if var_31_30 > 0 and var_31_24 < var_31_30 then
					arg_28_1.talkMaxDuration = var_31_30

					if var_31_30 + var_31_23 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_30 + var_31_23
					end
				end

				arg_28_1.text_.text = var_31_27
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324141", "324141007", "story_v_out_324141.awb") ~= 0 then
					local var_31_31 = manager.audio:GetVoiceLength("story_v_out_324141", "324141007", "story_v_out_324141.awb") / 1000

					if var_31_31 + var_31_23 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_31 + var_31_23
					end

					if var_31_26.prefab_name ~= "" and arg_28_1.actors_[var_31_26.prefab_name] ~= nil then
						local var_31_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_26.prefab_name].transform, "story_v_out_324141", "324141007", "story_v_out_324141.awb")

						arg_28_1:RecordAudio("324141007", var_31_32)
						arg_28_1:RecordAudio("324141007", var_31_32)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324141", "324141007", "story_v_out_324141.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324141", "324141007", "story_v_out_324141.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_33 = math.max(var_31_24, arg_28_1.talkMaxDuration)

			if var_31_23 <= arg_28_1.time_ and arg_28_1.time_ < var_31_23 + var_31_33 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_23) / var_31_33

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_23 + var_31_33 and arg_28_1.time_ < var_31_23 + var_31_33 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play324141008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324141008
		arg_32_1.duration_ = 8.87

		local var_32_0 = {
			zh = 7.866,
			ja = 8.866
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
				arg_32_0:Play324141009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1037ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1037ui_story == nil then
				arg_32_1.var_.characterEffect1037ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1037ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1037ui_story then
				arg_32_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["1170ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1170ui_story == nil then
				arg_32_1.var_.characterEffect1170ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.200000002980232

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect1170ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1170ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1170ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1170ui_story.fillRatio = var_35_9
			end

			local var_35_10 = 0
			local var_35_11 = 0.6

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_12 = arg_32_1:FormatText(StoryNameCfg[36].name)

				arg_32_1.leftNameTxt_.text = var_35_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_13 = arg_32_1:GetWordFromCfg(324141008)
				local var_35_14 = arg_32_1:FormatText(var_35_13.content)

				arg_32_1.text_.text = var_35_14

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_15 = 24
				local var_35_16 = utf8.len(var_35_14)
				local var_35_17 = var_35_15 <= 0 and var_35_11 or var_35_11 * (var_35_16 / var_35_15)

				if var_35_17 > 0 and var_35_11 < var_35_17 then
					arg_32_1.talkMaxDuration = var_35_17

					if var_35_17 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_17 + var_35_10
					end
				end

				arg_32_1.text_.text = var_35_14
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324141", "324141008", "story_v_out_324141.awb") ~= 0 then
					local var_35_18 = manager.audio:GetVoiceLength("story_v_out_324141", "324141008", "story_v_out_324141.awb") / 1000

					if var_35_18 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_10
					end

					if var_35_13.prefab_name ~= "" and arg_32_1.actors_[var_35_13.prefab_name] ~= nil then
						local var_35_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_13.prefab_name].transform, "story_v_out_324141", "324141008", "story_v_out_324141.awb")

						arg_32_1:RecordAudio("324141008", var_35_19)
						arg_32_1:RecordAudio("324141008", var_35_19)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_324141", "324141008", "story_v_out_324141.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_324141", "324141008", "story_v_out_324141.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_20 = math.max(var_35_11, arg_32_1.talkMaxDuration)

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_20 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_10) / var_35_20

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_10 + var_35_20 and arg_32_1.time_ < var_35_10 + var_35_20 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play324141009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324141009
		arg_36_1.duration_ = 6.53

		local var_36_0 = {
			zh = 3.6,
			ja = 6.533
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
				arg_36_0:Play324141010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1170ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1170ui_story == nil then
				arg_36_1.var_.characterEffect1170ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1170ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1170ui_story then
				arg_36_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["1037ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1037ui_story == nil then
				arg_36_1.var_.characterEffect1037ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.200000002980232

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect1037ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1037ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1037ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1037ui_story.fillRatio = var_39_9
			end

			local var_39_10 = 0
			local var_39_11 = 0.4

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_12 = arg_36_1:FormatText(StoryNameCfg[318].name)

				arg_36_1.leftNameTxt_.text = var_39_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_13 = arg_36_1:GetWordFromCfg(324141009)
				local var_39_14 = arg_36_1:FormatText(var_39_13.content)

				arg_36_1.text_.text = var_39_14

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_15 = 16
				local var_39_16 = utf8.len(var_39_14)
				local var_39_17 = var_39_15 <= 0 and var_39_11 or var_39_11 * (var_39_16 / var_39_15)

				if var_39_17 > 0 and var_39_11 < var_39_17 then
					arg_36_1.talkMaxDuration = var_39_17

					if var_39_17 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_17 + var_39_10
					end
				end

				arg_36_1.text_.text = var_39_14
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324141", "324141009", "story_v_out_324141.awb") ~= 0 then
					local var_39_18 = manager.audio:GetVoiceLength("story_v_out_324141", "324141009", "story_v_out_324141.awb") / 1000

					if var_39_18 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_10
					end

					if var_39_13.prefab_name ~= "" and arg_36_1.actors_[var_39_13.prefab_name] ~= nil then
						local var_39_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_13.prefab_name].transform, "story_v_out_324141", "324141009", "story_v_out_324141.awb")

						arg_36_1:RecordAudio("324141009", var_39_19)
						arg_36_1:RecordAudio("324141009", var_39_19)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_324141", "324141009", "story_v_out_324141.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_324141", "324141009", "story_v_out_324141.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_20 = math.max(var_39_11, arg_36_1.talkMaxDuration)

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_20 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_10) / var_39_20

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_10 + var_39_20 and arg_36_1.time_ < var_39_10 + var_39_20 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play324141010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324141010
		arg_40_1.duration_ = 8.93

		local var_40_0 = {
			zh = 7.966,
			ja = 8.933
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play324141011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1170ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos1170ui_story = var_43_0.localPosition

				local var_43_2 = GameObjectTools.GetOrAddComponent(var_43_0.gameObject, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(false)
				end
			end

			local var_43_3 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_3 then
				local var_43_4 = (arg_40_1.time_ - var_43_1) / var_43_3
				local var_43_5 = Vector3.New(-0.68, -0.95, -6.08)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1170ui_story, var_43_5, var_43_4)

				local var_43_6 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_6.x, var_43_6.y, var_43_6.z)

				local var_43_7 = var_43_0.localEulerAngles

				var_43_7.z = 0
				var_43_7.x = 0
				var_43_0.localEulerAngles = var_43_7
			end

			if arg_40_1.time_ >= var_43_1 + var_43_3 and arg_40_1.time_ < var_43_1 + var_43_3 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(-0.68, -0.95, -6.08)

				local var_43_8 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_8.x, var_43_8.y, var_43_8.z)

				local var_43_9 = var_43_0.localEulerAngles

				var_43_9.z = 0
				var_43_9.x = 0
				var_43_0.localEulerAngles = var_43_9

				local var_43_10 = GameObjectTools.GetOrAddComponent(var_43_0.gameObject, typeof(DynamicBoneHelper))

				if var_43_10 then
					var_43_10:EnableDynamicBone(true)
				end
			end

			local var_43_11 = arg_40_1.actors_["1053ui_story"].transform
			local var_43_12 = 0

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.var_.moveOldPos1053ui_story = var_43_11.localPosition

				local var_43_13 = GameObjectTools.GetOrAddComponent(var_43_11.gameObject, typeof(DynamicBoneHelper))

				if var_43_13 then
					var_43_13:EnableDynamicBone(false)
				end
			end

			local var_43_14 = 0.001

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_14 then
				local var_43_15 = (arg_40_1.time_ - var_43_12) / var_43_14
				local var_43_16 = Vector3.New(0.7, -1.08, -6)

				var_43_11.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1053ui_story, var_43_16, var_43_15)

				local var_43_17 = manager.ui.mainCamera.transform.position - var_43_11.position

				var_43_11.forward = Vector3.New(var_43_17.x, var_43_17.y, var_43_17.z)

				local var_43_18 = var_43_11.localEulerAngles

				var_43_18.z = 0
				var_43_18.x = 0
				var_43_11.localEulerAngles = var_43_18
			end

			if arg_40_1.time_ >= var_43_12 + var_43_14 and arg_40_1.time_ < var_43_12 + var_43_14 + arg_43_0 then
				var_43_11.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_43_19 = manager.ui.mainCamera.transform.position - var_43_11.position

				var_43_11.forward = Vector3.New(var_43_19.x, var_43_19.y, var_43_19.z)

				local var_43_20 = var_43_11.localEulerAngles

				var_43_20.z = 0
				var_43_20.x = 0
				var_43_11.localEulerAngles = var_43_20

				local var_43_21 = GameObjectTools.GetOrAddComponent(var_43_11.gameObject, typeof(DynamicBoneHelper))

				if var_43_21 then
					var_43_21:EnableDynamicBone(true)
				end
			end

			local var_43_22 = arg_40_1.actors_["1053ui_story"]
			local var_43_23 = 0

			if var_43_23 < arg_40_1.time_ and arg_40_1.time_ <= var_43_23 + arg_43_0 and not isNil(var_43_22) and arg_40_1.var_.characterEffect1053ui_story == nil then
				arg_40_1.var_.characterEffect1053ui_story = var_43_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_24 = 0.200000002980232

			if var_43_23 <= arg_40_1.time_ and arg_40_1.time_ < var_43_23 + var_43_24 and not isNil(var_43_22) then
				local var_43_25 = (arg_40_1.time_ - var_43_23) / var_43_24

				if arg_40_1.var_.characterEffect1053ui_story and not isNil(var_43_22) then
					arg_40_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_23 + var_43_24 and arg_40_1.time_ < var_43_23 + var_43_24 + arg_43_0 and not isNil(var_43_22) and arg_40_1.var_.characterEffect1053ui_story then
				arg_40_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_43_26 = arg_40_1.actors_["1170ui_story"]
			local var_43_27 = 0

			if var_43_27 < arg_40_1.time_ and arg_40_1.time_ <= var_43_27 + arg_43_0 and not isNil(var_43_26) and arg_40_1.var_.characterEffect1170ui_story == nil then
				arg_40_1.var_.characterEffect1170ui_story = var_43_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_28 = 0.200000002980232

			if var_43_27 <= arg_40_1.time_ and arg_40_1.time_ < var_43_27 + var_43_28 and not isNil(var_43_26) then
				local var_43_29 = (arg_40_1.time_ - var_43_27) / var_43_28

				if arg_40_1.var_.characterEffect1170ui_story and not isNil(var_43_26) then
					local var_43_30 = Mathf.Lerp(0, 0.5, var_43_29)

					arg_40_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1170ui_story.fillRatio = var_43_30
				end
			end

			if arg_40_1.time_ >= var_43_27 + var_43_28 and arg_40_1.time_ < var_43_27 + var_43_28 + arg_43_0 and not isNil(var_43_26) and arg_40_1.var_.characterEffect1170ui_story then
				local var_43_31 = 0.5

				arg_40_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1170ui_story.fillRatio = var_43_31
			end

			local var_43_32 = 0

			if var_43_32 < arg_40_1.time_ and arg_40_1.time_ <= var_43_32 + arg_43_0 then
				arg_40_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_1")
			end

			local var_43_33 = 0

			if var_43_33 < arg_40_1.time_ and arg_40_1.time_ <= var_43_33 + arg_43_0 then
				arg_40_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_43_34 = 0
			local var_43_35 = 0.9

			if var_43_34 < arg_40_1.time_ and arg_40_1.time_ <= var_43_34 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_36 = arg_40_1:FormatText(StoryNameCfg[472].name)

				arg_40_1.leftNameTxt_.text = var_43_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_37 = arg_40_1:GetWordFromCfg(324141010)
				local var_43_38 = arg_40_1:FormatText(var_43_37.content)

				arg_40_1.text_.text = var_43_38

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_39 = 36
				local var_43_40 = utf8.len(var_43_38)
				local var_43_41 = var_43_39 <= 0 and var_43_35 or var_43_35 * (var_43_40 / var_43_39)

				if var_43_41 > 0 and var_43_35 < var_43_41 then
					arg_40_1.talkMaxDuration = var_43_41

					if var_43_41 + var_43_34 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_41 + var_43_34
					end
				end

				arg_40_1.text_.text = var_43_38
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324141", "324141010", "story_v_out_324141.awb") ~= 0 then
					local var_43_42 = manager.audio:GetVoiceLength("story_v_out_324141", "324141010", "story_v_out_324141.awb") / 1000

					if var_43_42 + var_43_34 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_42 + var_43_34
					end

					if var_43_37.prefab_name ~= "" and arg_40_1.actors_[var_43_37.prefab_name] ~= nil then
						local var_43_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_37.prefab_name].transform, "story_v_out_324141", "324141010", "story_v_out_324141.awb")

						arg_40_1:RecordAudio("324141010", var_43_43)
						arg_40_1:RecordAudio("324141010", var_43_43)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_324141", "324141010", "story_v_out_324141.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_324141", "324141010", "story_v_out_324141.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_44 = math.max(var_43_35, arg_40_1.talkMaxDuration)

			if var_43_34 <= arg_40_1.time_ and arg_40_1.time_ < var_43_34 + var_43_44 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_34) / var_43_44

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_34 + var_43_44 and arg_40_1.time_ < var_43_34 + var_43_44 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play324141011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324141011
		arg_44_1.duration_ = 5.17

		local var_44_0 = {
			zh = 4.3,
			ja = 5.166
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play324141012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1170ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1170ui_story == nil then
				arg_44_1.var_.characterEffect1170ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1170ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1170ui_story then
				arg_44_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["1053ui_story"]
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1053ui_story == nil then
				arg_44_1.var_.characterEffect1053ui_story = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.200000002980232

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 and not isNil(var_47_4) then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6

				if arg_44_1.var_.characterEffect1053ui_story and not isNil(var_47_4) then
					local var_47_8 = Mathf.Lerp(0, 0.5, var_47_7)

					arg_44_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1053ui_story.fillRatio = var_47_8
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1053ui_story then
				local var_47_9 = 0.5

				arg_44_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1053ui_story.fillRatio = var_47_9
			end

			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action1_1")
			end

			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_47_12 = 0
			local var_47_13 = 0.325

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_14 = arg_44_1:FormatText(StoryNameCfg[318].name)

				arg_44_1.leftNameTxt_.text = var_47_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_15 = arg_44_1:GetWordFromCfg(324141011)
				local var_47_16 = arg_44_1:FormatText(var_47_15.content)

				arg_44_1.text_.text = var_47_16

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 13
				local var_47_18 = utf8.len(var_47_16)
				local var_47_19 = var_47_17 <= 0 and var_47_13 or var_47_13 * (var_47_18 / var_47_17)

				if var_47_19 > 0 and var_47_13 < var_47_19 then
					arg_44_1.talkMaxDuration = var_47_19

					if var_47_19 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_19 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_16
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324141", "324141011", "story_v_out_324141.awb") ~= 0 then
					local var_47_20 = manager.audio:GetVoiceLength("story_v_out_324141", "324141011", "story_v_out_324141.awb") / 1000

					if var_47_20 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_20 + var_47_12
					end

					if var_47_15.prefab_name ~= "" and arg_44_1.actors_[var_47_15.prefab_name] ~= nil then
						local var_47_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_15.prefab_name].transform, "story_v_out_324141", "324141011", "story_v_out_324141.awb")

						arg_44_1:RecordAudio("324141011", var_47_21)
						arg_44_1:RecordAudio("324141011", var_47_21)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_324141", "324141011", "story_v_out_324141.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_324141", "324141011", "story_v_out_324141.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_22 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_22 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_12) / var_47_22

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_12 + var_47_22 and arg_44_1.time_ < var_47_12 + var_47_22 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play324141012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324141012
		arg_48_1.duration_ = 13.73

		local var_48_0 = {
			zh = 10.366,
			ja = 13.733
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play324141013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1037ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1037ui_story == nil then
				arg_48_1.var_.characterEffect1037ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1037ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1037ui_story then
				arg_48_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1170ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1170ui_story == nil then
				arg_48_1.var_.characterEffect1170ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.200000002980232

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect1170ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1170ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1170ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1170ui_story.fillRatio = var_51_9
			end

			local var_51_10 = 0
			local var_51_11 = 0.7

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_12 = arg_48_1:FormatText(StoryNameCfg[36].name)

				arg_48_1.leftNameTxt_.text = var_51_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_13 = arg_48_1:GetWordFromCfg(324141012)
				local var_51_14 = arg_48_1:FormatText(var_51_13.content)

				arg_48_1.text_.text = var_51_14

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_15 = 28
				local var_51_16 = utf8.len(var_51_14)
				local var_51_17 = var_51_15 <= 0 and var_51_11 or var_51_11 * (var_51_16 / var_51_15)

				if var_51_17 > 0 and var_51_11 < var_51_17 then
					arg_48_1.talkMaxDuration = var_51_17

					if var_51_17 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_17 + var_51_10
					end
				end

				arg_48_1.text_.text = var_51_14
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324141", "324141012", "story_v_out_324141.awb") ~= 0 then
					local var_51_18 = manager.audio:GetVoiceLength("story_v_out_324141", "324141012", "story_v_out_324141.awb") / 1000

					if var_51_18 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_18 + var_51_10
					end

					if var_51_13.prefab_name ~= "" and arg_48_1.actors_[var_51_13.prefab_name] ~= nil then
						local var_51_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_13.prefab_name].transform, "story_v_out_324141", "324141012", "story_v_out_324141.awb")

						arg_48_1:RecordAudio("324141012", var_51_19)
						arg_48_1:RecordAudio("324141012", var_51_19)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_324141", "324141012", "story_v_out_324141.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_324141", "324141012", "story_v_out_324141.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_20 = math.max(var_51_11, arg_48_1.talkMaxDuration)

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_20 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_10) / var_51_20

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_10 + var_51_20 and arg_48_1.time_ < var_51_10 + var_51_20 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play324141013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324141013
		arg_52_1.duration_ = 4

		local var_52_0 = {
			zh = 3,
			ja = 4
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play324141014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1053ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1053ui_story == nil then
				arg_52_1.var_.characterEffect1053ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1053ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1053ui_story then
				arg_52_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["1037ui_story"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect1037ui_story == nil then
				arg_52_1.var_.characterEffect1037ui_story = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.200000002980232

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect1037ui_story and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1037ui_story.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect1037ui_story then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1037ui_story.fillRatio = var_55_9
			end

			local var_55_10 = 0
			local var_55_11 = 0.25

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_12 = arg_52_1:FormatText(StoryNameCfg[472].name)

				arg_52_1.leftNameTxt_.text = var_55_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_13 = arg_52_1:GetWordFromCfg(324141013)
				local var_55_14 = arg_52_1:FormatText(var_55_13.content)

				arg_52_1.text_.text = var_55_14

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_15 = 10
				local var_55_16 = utf8.len(var_55_14)
				local var_55_17 = var_55_15 <= 0 and var_55_11 or var_55_11 * (var_55_16 / var_55_15)

				if var_55_17 > 0 and var_55_11 < var_55_17 then
					arg_52_1.talkMaxDuration = var_55_17

					if var_55_17 + var_55_10 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_17 + var_55_10
					end
				end

				arg_52_1.text_.text = var_55_14
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324141", "324141013", "story_v_out_324141.awb") ~= 0 then
					local var_55_18 = manager.audio:GetVoiceLength("story_v_out_324141", "324141013", "story_v_out_324141.awb") / 1000

					if var_55_18 + var_55_10 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_18 + var_55_10
					end

					if var_55_13.prefab_name ~= "" and arg_52_1.actors_[var_55_13.prefab_name] ~= nil then
						local var_55_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_13.prefab_name].transform, "story_v_out_324141", "324141013", "story_v_out_324141.awb")

						arg_52_1:RecordAudio("324141013", var_55_19)
						arg_52_1:RecordAudio("324141013", var_55_19)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_324141", "324141013", "story_v_out_324141.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_324141", "324141013", "story_v_out_324141.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_20 = math.max(var_55_11, arg_52_1.talkMaxDuration)

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_20 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_10) / var_55_20

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_10 + var_55_20 and arg_52_1.time_ < var_55_10 + var_55_20 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play324141014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324141014
		arg_56_1.duration_ = 6

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play324141015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1170ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos1170ui_story = var_59_0.localPosition

				local var_59_2 = GameObjectTools.GetOrAddComponent(var_59_0.gameObject, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(false)
				end
			end

			local var_59_3 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_3 then
				local var_59_4 = (arg_56_1.time_ - var_59_1) / var_59_3
				local var_59_5 = Vector3.New(0, 100, 0)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1170ui_story, var_59_5, var_59_4)

				local var_59_6 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_6.x, var_59_6.y, var_59_6.z)

				local var_59_7 = var_59_0.localEulerAngles

				var_59_7.z = 0
				var_59_7.x = 0
				var_59_0.localEulerAngles = var_59_7
			end

			if arg_56_1.time_ >= var_59_1 + var_59_3 and arg_56_1.time_ < var_59_1 + var_59_3 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, 100, 0)

				local var_59_8 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_8.x, var_59_8.y, var_59_8.z)

				local var_59_9 = var_59_0.localEulerAngles

				var_59_9.z = 0
				var_59_9.x = 0
				var_59_0.localEulerAngles = var_59_9

				local var_59_10 = GameObjectTools.GetOrAddComponent(var_59_0.gameObject, typeof(DynamicBoneHelper))

				if var_59_10 then
					var_59_10:EnableDynamicBone(true)
				end
			end

			local var_59_11 = arg_56_1.actors_["1053ui_story"].transform
			local var_59_12 = 0

			if var_59_12 < arg_56_1.time_ and arg_56_1.time_ <= var_59_12 + arg_59_0 then
				arg_56_1.var_.moveOldPos1053ui_story = var_59_11.localPosition

				local var_59_13 = GameObjectTools.GetOrAddComponent(var_59_11.gameObject, typeof(DynamicBoneHelper))

				if var_59_13 then
					var_59_13:EnableDynamicBone(false)
				end
			end

			local var_59_14 = 0.001

			if var_59_12 <= arg_56_1.time_ and arg_56_1.time_ < var_59_12 + var_59_14 then
				local var_59_15 = (arg_56_1.time_ - var_59_12) / var_59_14
				local var_59_16 = Vector3.New(0, 100, 0)

				var_59_11.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1053ui_story, var_59_16, var_59_15)

				local var_59_17 = manager.ui.mainCamera.transform.position - var_59_11.position

				var_59_11.forward = Vector3.New(var_59_17.x, var_59_17.y, var_59_17.z)

				local var_59_18 = var_59_11.localEulerAngles

				var_59_18.z = 0
				var_59_18.x = 0
				var_59_11.localEulerAngles = var_59_18
			end

			if arg_56_1.time_ >= var_59_12 + var_59_14 and arg_56_1.time_ < var_59_12 + var_59_14 + arg_59_0 then
				var_59_11.localPosition = Vector3.New(0, 100, 0)

				local var_59_19 = manager.ui.mainCamera.transform.position - var_59_11.position

				var_59_11.forward = Vector3.New(var_59_19.x, var_59_19.y, var_59_19.z)

				local var_59_20 = var_59_11.localEulerAngles

				var_59_20.z = 0
				var_59_20.x = 0
				var_59_11.localEulerAngles = var_59_20

				local var_59_21 = GameObjectTools.GetOrAddComponent(var_59_11.gameObject, typeof(DynamicBoneHelper))

				if var_59_21 then
					var_59_21:EnableDynamicBone(true)
				end
			end

			local var_59_22 = arg_56_1.actors_["1053ui_story"]
			local var_59_23 = 0

			if var_59_23 < arg_56_1.time_ and arg_56_1.time_ <= var_59_23 + arg_59_0 and not isNil(var_59_22) and arg_56_1.var_.characterEffect1053ui_story == nil then
				arg_56_1.var_.characterEffect1053ui_story = var_59_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_24 = 0.200000002980232

			if var_59_23 <= arg_56_1.time_ and arg_56_1.time_ < var_59_23 + var_59_24 and not isNil(var_59_22) then
				local var_59_25 = (arg_56_1.time_ - var_59_23) / var_59_24

				if arg_56_1.var_.characterEffect1053ui_story and not isNil(var_59_22) then
					local var_59_26 = Mathf.Lerp(0, 0.5, var_59_25)

					arg_56_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1053ui_story.fillRatio = var_59_26
				end
			end

			if arg_56_1.time_ >= var_59_23 + var_59_24 and arg_56_1.time_ < var_59_23 + var_59_24 + arg_59_0 and not isNil(var_59_22) and arg_56_1.var_.characterEffect1053ui_story then
				local var_59_27 = 0.5

				arg_56_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1053ui_story.fillRatio = var_59_27
			end

			local var_59_28 = 0.1
			local var_59_29 = 1

			if var_59_28 < arg_56_1.time_ and arg_56_1.time_ <= var_59_28 + arg_59_0 then
				local var_59_30 = "stop"
				local var_59_31 = "effect"

				arg_56_1:AudioAction(var_59_30, var_59_31, "se_story_150", "se_story_150_amb_painting", "")
			end

			local var_59_32 = 0.1
			local var_59_33 = 1

			if var_59_32 < arg_56_1.time_ and arg_56_1.time_ <= var_59_32 + arg_59_0 then
				local var_59_34 = "play"
				local var_59_35 = "effect"

				arg_56_1:AudioAction(var_59_34, var_59_35, "se_story_150", "se_story_150_rock", "")
			end

			local var_59_36 = 0

			if var_59_36 < arg_56_1.time_ and arg_56_1.time_ <= var_59_36 + arg_59_0 then
				arg_56_1.allBtn_.enabled = false
			end

			local var_59_37 = 1.36666666666667

			if arg_56_1.time_ >= var_59_36 + var_59_37 and arg_56_1.time_ < var_59_36 + var_59_37 + arg_59_0 then
				arg_56_1.allBtn_.enabled = true
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_38 = 1
			local var_59_39 = 1.2

			if var_59_38 < arg_56_1.time_ and arg_56_1.time_ <= var_59_38 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_40 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_40:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_41 = arg_56_1:GetWordFromCfg(324141014)
				local var_59_42 = arg_56_1:FormatText(var_59_41.content)

				arg_56_1.text_.text = var_59_42

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_43 = 48
				local var_59_44 = utf8.len(var_59_42)
				local var_59_45 = var_59_43 <= 0 and var_59_39 or var_59_39 * (var_59_44 / var_59_43)

				if var_59_45 > 0 and var_59_39 < var_59_45 then
					arg_56_1.talkMaxDuration = var_59_45
					var_59_38 = var_59_38 + 0.3

					if var_59_45 + var_59_38 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_45 + var_59_38
					end
				end

				arg_56_1.text_.text = var_59_42
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_46 = var_59_38 + 0.3
			local var_59_47 = math.max(var_59_39, arg_56_1.talkMaxDuration)

			if var_59_46 <= arg_56_1.time_ and arg_56_1.time_ < var_59_46 + var_59_47 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_46) / var_59_47

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_46 + var_59_47 and arg_56_1.time_ < var_59_46 + var_59_47 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "",
				frequency = 6,
				className = "StoryShakeNode",
				duration = 0.6,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(10, 0.1, 0.1)
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play324141015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 324141015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play324141016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.1
			local var_65_1 = 1

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				local var_65_2 = "play"
				local var_65_3 = "effect"

				arg_62_1:AudioAction(var_65_2, var_65_3, "se_story_144", "se_story_144_smoke01", "")
			end

			local var_65_4 = 0
			local var_65_5 = 0.9

			if var_65_4 < arg_62_1.time_ and arg_62_1.time_ <= var_65_4 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_6 = arg_62_1:GetWordFromCfg(324141015)
				local var_65_7 = arg_62_1:FormatText(var_65_6.content)

				arg_62_1.text_.text = var_65_7

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_8 = 36
				local var_65_9 = utf8.len(var_65_7)
				local var_65_10 = var_65_8 <= 0 and var_65_5 or var_65_5 * (var_65_9 / var_65_8)

				if var_65_10 > 0 and var_65_5 < var_65_10 then
					arg_62_1.talkMaxDuration = var_65_10

					if var_65_10 + var_65_4 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_10 + var_65_4
					end
				end

				arg_62_1.text_.text = var_65_7
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_11 = math.max(var_65_5, arg_62_1.talkMaxDuration)

			if var_65_4 <= arg_62_1.time_ and arg_62_1.time_ < var_65_4 + var_65_11 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_4) / var_65_11

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_4 + var_65_11 and arg_62_1.time_ < var_65_4 + var_65_11 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play324141016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 324141016
		arg_66_1.duration_ = 5.77

		local var_66_0 = {
			zh = 4.5,
			ja = 5.766
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
			arg_66_1.auto_ = false
		end

		function arg_66_1.playNext_(arg_68_0)
			arg_66_1.onStoryFinished_()
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1053ui_story"].transform
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.var_.moveOldPos1053ui_story = var_69_0.localPosition

				local var_69_2 = GameObjectTools.GetOrAddComponent(var_69_0.gameObject, typeof(DynamicBoneHelper))

				if var_69_2 then
					var_69_2:EnableDynamicBone(false)
				end
			end

			local var_69_3 = 0.001

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_3 then
				local var_69_4 = (arg_66_1.time_ - var_69_1) / var_69_3
				local var_69_5 = Vector3.New(0, -1.08, -6)

				var_69_0.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1053ui_story, var_69_5, var_69_4)

				local var_69_6 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_6.x, var_69_6.y, var_69_6.z)

				local var_69_7 = var_69_0.localEulerAngles

				var_69_7.z = 0
				var_69_7.x = 0
				var_69_0.localEulerAngles = var_69_7
			end

			if arg_66_1.time_ >= var_69_1 + var_69_3 and arg_66_1.time_ < var_69_1 + var_69_3 + arg_69_0 then
				var_69_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_69_8 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_8.x, var_69_8.y, var_69_8.z)

				local var_69_9 = var_69_0.localEulerAngles

				var_69_9.z = 0
				var_69_9.x = 0
				var_69_0.localEulerAngles = var_69_9

				local var_69_10 = GameObjectTools.GetOrAddComponent(var_69_0.gameObject, typeof(DynamicBoneHelper))

				if var_69_10 then
					var_69_10:EnableDynamicBone(true)
				end
			end

			local var_69_11 = arg_66_1.actors_["1053ui_story"]
			local var_69_12 = 0

			if var_69_12 < arg_66_1.time_ and arg_66_1.time_ <= var_69_12 + arg_69_0 and not isNil(var_69_11) and arg_66_1.var_.characterEffect1053ui_story == nil then
				arg_66_1.var_.characterEffect1053ui_story = var_69_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_13 = 0.200000002980232

			if var_69_12 <= arg_66_1.time_ and arg_66_1.time_ < var_69_12 + var_69_13 and not isNil(var_69_11) then
				local var_69_14 = (arg_66_1.time_ - var_69_12) / var_69_13

				if arg_66_1.var_.characterEffect1053ui_story and not isNil(var_69_11) then
					arg_66_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_12 + var_69_13 and arg_66_1.time_ < var_69_12 + var_69_13 + arg_69_0 and not isNil(var_69_11) and arg_66_1.var_.characterEffect1053ui_story then
				arg_66_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_69_15 = 0

			if var_69_15 < arg_66_1.time_ and arg_66_1.time_ <= var_69_15 + arg_69_0 then
				arg_66_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_2")
			end

			local var_69_16 = 0

			if var_69_16 < arg_66_1.time_ and arg_66_1.time_ <= var_69_16 + arg_69_0 then
				arg_66_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_69_17 = 0
			local var_69_18 = 0.5

			if var_69_17 < arg_66_1.time_ and arg_66_1.time_ <= var_69_17 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_19 = arg_66_1:FormatText(StoryNameCfg[472].name)

				arg_66_1.leftNameTxt_.text = var_69_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_20 = arg_66_1:GetWordFromCfg(324141016)
				local var_69_21 = arg_66_1:FormatText(var_69_20.content)

				arg_66_1.text_.text = var_69_21

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_22 = 20
				local var_69_23 = utf8.len(var_69_21)
				local var_69_24 = var_69_22 <= 0 and var_69_18 or var_69_18 * (var_69_23 / var_69_22)

				if var_69_24 > 0 and var_69_18 < var_69_24 then
					arg_66_1.talkMaxDuration = var_69_24

					if var_69_24 + var_69_17 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_24 + var_69_17
					end
				end

				arg_66_1.text_.text = var_69_21
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324141", "324141016", "story_v_out_324141.awb") ~= 0 then
					local var_69_25 = manager.audio:GetVoiceLength("story_v_out_324141", "324141016", "story_v_out_324141.awb") / 1000

					if var_69_25 + var_69_17 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_25 + var_69_17
					end

					if var_69_20.prefab_name ~= "" and arg_66_1.actors_[var_69_20.prefab_name] ~= nil then
						local var_69_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_20.prefab_name].transform, "story_v_out_324141", "324141016", "story_v_out_324141.awb")

						arg_66_1:RecordAudio("324141016", var_69_26)
						arg_66_1:RecordAudio("324141016", var_69_26)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_324141", "324141016", "story_v_out_324141.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_324141", "324141016", "story_v_out_324141.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_27 = math.max(var_69_18, arg_66_1.talkMaxDuration)

			if var_69_17 <= arg_66_1.time_ and arg_66_1.time_ < var_69_17 + var_69_27 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_17) / var_69_27

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_17 + var_69_27 and arg_66_1.time_ < var_69_17 + var_69_27 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J15"
	},
	voices = {
		"story_v_out_324141.awb"
	}
}
