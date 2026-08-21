return {
	Play104091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104091001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play104091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_5 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
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

			local var_4_6 = 0
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "effect"

				arg_1_1:AudioAction(var_4_8, var_4_9, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_10 = "B04c"

			if arg_1_1.bgs_[var_4_10] == nil then
				local var_4_11 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_10)
				var_4_11.name = var_4_10
				var_4_11.transform.parent = arg_1_1.stage_.transform
				var_4_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_10] = var_4_11
			end

			local var_4_12 = arg_1_1.bgs_.B04c
			local var_4_13 = 0

			if var_4_13 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				local var_4_14 = var_4_12:GetComponent("SpriteRenderer")

				if var_4_14 then
					arg_1_1.var_.alphaOldValueB04c = var_4_14.color.a
					arg_1_1.var_.alphaMatValueB04c = var_4_14
				end

				arg_1_1.var_.alphaOldValueB04c = 0
			end

			local var_4_15 = 1.5

			if var_4_13 <= arg_1_1.time_ and arg_1_1.time_ < var_4_13 + var_4_15 then
				local var_4_16 = (arg_1_1.time_ - var_4_13) / var_4_15
				local var_4_17 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB04c, 1, var_4_16)

				if arg_1_1.var_.alphaMatValueB04c then
					local var_4_18 = arg_1_1.var_.alphaMatValueB04c.color

					var_4_18.a = var_4_17
					arg_1_1.var_.alphaMatValueB04c.color = var_4_18
				end
			end

			if arg_1_1.time_ >= var_4_13 + var_4_15 and arg_1_1.time_ < var_4_13 + var_4_15 + arg_4_0 and arg_1_1.var_.alphaMatValueB04c then
				local var_4_19 = arg_1_1.var_.alphaMatValueB04c
				local var_4_20 = var_4_19.color

				var_4_20.a = 1
				var_4_19.color = var_4_20
			end

			local var_4_21 = 0

			if var_4_21 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				local var_4_22 = manager.ui.mainCamera.transform.localPosition
				local var_4_23 = Vector3.New(0, 0, 10) + Vector3.New(var_4_22.x, var_4_22.y, 0)
				local var_4_24 = arg_1_1.bgs_.B04c

				var_4_24.transform.localPosition = var_4_23
				var_4_24.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_25 = var_4_24:GetComponent("SpriteRenderer")

				if var_4_25 and var_4_25.sprite then
					local var_4_26 = (var_4_24.transform.localPosition - var_4_22).z
					local var_4_27 = manager.ui.mainCameraCom_
					local var_4_28 = 2 * var_4_26 * Mathf.Tan(var_4_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_29 = var_4_28 * var_4_27.aspect
					local var_4_30 = var_4_25.sprite.bounds.size.x
					local var_4_31 = var_4_25.sprite.bounds.size.y
					local var_4_32 = var_4_29 / var_4_30
					local var_4_33 = var_4_28 / var_4_31
					local var_4_34 = var_4_33 < var_4_32 and var_4_32 or var_4_33

					var_4_24.transform.localScale = Vector3.New(var_4_34, var_4_34, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B04c" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_35 = 0

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_36 = 2

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_37 = 2
			local var_4_38 = 0.3

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_39 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_39:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_40 = arg_1_1:GetWordFromCfg(104091001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 12
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_38 or var_4_38 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_38 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_37 = var_4_37 + 0.3

					if var_4_44 + var_4_37 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_37
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_37 + 0.3
			local var_4_46 = math.max(var_4_38, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play104091002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104091002
		arg_8_1.duration_ = 3.47

		local var_8_0 = {
			ja = 3.4,
			ko = 3.466,
			zh = 3.033,
			en = 3.1
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
				arg_8_0:Play104091003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1084ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1084ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["1084ui_story"].transform
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = var_11_9.localPosition
			end

			local var_11_11 = 0.001

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11
				local var_11_13 = Vector3.New(-0.7, -0.97, -6)

				var_11_9.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, var_11_13, var_11_12)

				local var_11_14 = manager.ui.mainCamera.transform.position - var_11_9.position

				var_11_9.forward = Vector3.New(var_11_14.x, var_11_14.y, var_11_14.z)

				local var_11_15 = var_11_9.localEulerAngles

				var_11_15.z = 0
				var_11_15.x = 0
				var_11_9.localEulerAngles = var_11_15
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 then
				var_11_9.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_11_16 = manager.ui.mainCamera.transform.position - var_11_9.position

				var_11_9.forward = Vector3.New(var_11_16.x, var_11_16.y, var_11_16.z)

				local var_11_17 = var_11_9.localEulerAngles

				var_11_17.z = 0
				var_11_17.x = 0
				var_11_9.localEulerAngles = var_11_17
			end

			local var_11_18 = 0

			if var_11_18 < arg_8_1.time_ and arg_8_1.time_ <= var_11_18 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_11_19 = 0

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_11_20 = 0
			local var_11_21 = 0.325

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_22 = arg_8_1:FormatText(StoryNameCfg[6].name)

				arg_8_1.leftNameTxt_.text = var_11_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_23 = arg_8_1:GetWordFromCfg(104091002)
				local var_11_24 = arg_8_1:FormatText(var_11_23.content)

				arg_8_1.text_.text = var_11_24

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_25 = 13
				local var_11_26 = utf8.len(var_11_24)
				local var_11_27 = var_11_25 <= 0 and var_11_21 or var_11_21 * (var_11_26 / var_11_25)

				if var_11_27 > 0 and var_11_21 < var_11_27 then
					arg_8_1.talkMaxDuration = var_11_27

					if var_11_27 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_27 + var_11_20
					end
				end

				arg_8_1.text_.text = var_11_24
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104091", "104091002", "story_v_out_104091.awb") ~= 0 then
					local var_11_28 = manager.audio:GetVoiceLength("story_v_out_104091", "104091002", "story_v_out_104091.awb") / 1000

					if var_11_28 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_28 + var_11_20
					end

					if var_11_23.prefab_name ~= "" and arg_8_1.actors_[var_11_23.prefab_name] ~= nil then
						local var_11_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_23.prefab_name].transform, "story_v_out_104091", "104091002", "story_v_out_104091.awb")

						arg_8_1:RecordAudio("104091002", var_11_29)
						arg_8_1:RecordAudio("104091002", var_11_29)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_104091", "104091002", "story_v_out_104091.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_104091", "104091002", "story_v_out_104091.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_30 = math.max(var_11_21, arg_8_1.talkMaxDuration)

			if var_11_20 <= arg_8_1.time_ and arg_8_1.time_ < var_11_20 + var_11_30 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_20) / var_11_30

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_20 + var_11_30 and arg_8_1.time_ < var_11_20 + var_11_30 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play104091003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104091003
		arg_12_1.duration_ = 4.2

		local var_12_0 = {
			ja = 4.2,
			ko = 3.033,
			zh = 2.633,
			en = 2.666
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
				arg_12_0:Play104091004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1011ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["1011ui_story"]
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1011ui_story == nil then
				arg_12_1.var_.characterEffect1011ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.1

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 and not isNil(var_15_5) then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7

				if arg_12_1.var_.characterEffect1011ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1011ui_story then
				arg_12_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_15_9 = arg_12_1.actors_["1084ui_story"]
			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_11 = 0.1

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_11 and not isNil(var_15_9) then
				local var_15_12 = (arg_12_1.time_ - var_15_10) / var_15_11

				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_9) then
					local var_15_13 = Mathf.Lerp(0, 0.5, var_15_12)

					arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1084ui_story.fillRatio = var_15_13
				end
			end

			if arg_12_1.time_ >= var_15_10 + var_15_11 and arg_12_1.time_ < var_15_10 + var_15_11 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect1084ui_story then
				local var_15_14 = 0.5

				arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1084ui_story.fillRatio = var_15_14
			end

			local var_15_15 = arg_12_1.actors_["1011ui_story"].transform
			local var_15_16 = 0

			if var_15_16 < arg_12_1.time_ and arg_12_1.time_ <= var_15_16 + arg_15_0 then
				arg_12_1.var_.moveOldPos1011ui_story = var_15_15.localPosition
			end

			local var_15_17 = 0.001

			if var_15_16 <= arg_12_1.time_ and arg_12_1.time_ < var_15_16 + var_15_17 then
				local var_15_18 = (arg_12_1.time_ - var_15_16) / var_15_17
				local var_15_19 = Vector3.New(0.7, -0.71, -6)

				var_15_15.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1011ui_story, var_15_19, var_15_18)

				local var_15_20 = manager.ui.mainCamera.transform.position - var_15_15.position

				var_15_15.forward = Vector3.New(var_15_20.x, var_15_20.y, var_15_20.z)

				local var_15_21 = var_15_15.localEulerAngles

				var_15_21.z = 0
				var_15_21.x = 0
				var_15_15.localEulerAngles = var_15_21
			end

			if arg_12_1.time_ >= var_15_16 + var_15_17 and arg_12_1.time_ < var_15_16 + var_15_17 + arg_15_0 then
				var_15_15.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_15_22 = manager.ui.mainCamera.transform.position - var_15_15.position

				var_15_15.forward = Vector3.New(var_15_22.x, var_15_22.y, var_15_22.z)

				local var_15_23 = var_15_15.localEulerAngles

				var_15_23.z = 0
				var_15_23.x = 0
				var_15_15.localEulerAngles = var_15_23
			end

			local var_15_24 = 0

			if var_15_24 < arg_12_1.time_ and arg_12_1.time_ <= var_15_24 + arg_15_0 then
				arg_12_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_15_25 = 0

			if var_15_25 < arg_12_1.time_ and arg_12_1.time_ <= var_15_25 + arg_15_0 then
				arg_12_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_15_26 = 0
			local var_15_27 = 0.3

			if var_15_26 < arg_12_1.time_ and arg_12_1.time_ <= var_15_26 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_28 = arg_12_1:FormatText(StoryNameCfg[37].name)

				arg_12_1.leftNameTxt_.text = var_15_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_29 = arg_12_1:GetWordFromCfg(104091003)
				local var_15_30 = arg_12_1:FormatText(var_15_29.content)

				arg_12_1.text_.text = var_15_30

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_31 = 12
				local var_15_32 = utf8.len(var_15_30)
				local var_15_33 = var_15_31 <= 0 and var_15_27 or var_15_27 * (var_15_32 / var_15_31)

				if var_15_33 > 0 and var_15_27 < var_15_33 then
					arg_12_1.talkMaxDuration = var_15_33

					if var_15_33 + var_15_26 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_33 + var_15_26
					end
				end

				arg_12_1.text_.text = var_15_30
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104091", "104091003", "story_v_out_104091.awb") ~= 0 then
					local var_15_34 = manager.audio:GetVoiceLength("story_v_out_104091", "104091003", "story_v_out_104091.awb") / 1000

					if var_15_34 + var_15_26 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_34 + var_15_26
					end

					if var_15_29.prefab_name ~= "" and arg_12_1.actors_[var_15_29.prefab_name] ~= nil then
						local var_15_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_29.prefab_name].transform, "story_v_out_104091", "104091003", "story_v_out_104091.awb")

						arg_12_1:RecordAudio("104091003", var_15_35)
						arg_12_1:RecordAudio("104091003", var_15_35)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_104091", "104091003", "story_v_out_104091.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_104091", "104091003", "story_v_out_104091.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_36 = math.max(var_15_27, arg_12_1.talkMaxDuration)

			if var_15_26 <= arg_12_1.time_ and arg_12_1.time_ < var_15_26 + var_15_36 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_26) / var_15_36

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_26 + var_15_36 and arg_12_1.time_ < var_15_26 + var_15_36 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play104091004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104091004
		arg_16_1.duration_ = 12.5

		local var_16_0 = {
			ja = 12.5,
			ko = 6.1,
			zh = 7.866,
			en = 10.466
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
				arg_16_0:Play104091005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_19_1 = 0
			local var_19_2 = 0.575

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_3 = arg_16_1:FormatText(StoryNameCfg[37].name)

				arg_16_1.leftNameTxt_.text = var_19_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_4 = arg_16_1:GetWordFromCfg(104091004)
				local var_19_5 = arg_16_1:FormatText(var_19_4.content)

				arg_16_1.text_.text = var_19_5

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 23
				local var_19_7 = utf8.len(var_19_5)
				local var_19_8 = var_19_6 <= 0 and var_19_2 or var_19_2 * (var_19_7 / var_19_6)

				if var_19_8 > 0 and var_19_2 < var_19_8 then
					arg_16_1.talkMaxDuration = var_19_8

					if var_19_8 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_5
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104091", "104091004", "story_v_out_104091.awb") ~= 0 then
					local var_19_9 = manager.audio:GetVoiceLength("story_v_out_104091", "104091004", "story_v_out_104091.awb") / 1000

					if var_19_9 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_1
					end

					if var_19_4.prefab_name ~= "" and arg_16_1.actors_[var_19_4.prefab_name] ~= nil then
						local var_19_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_4.prefab_name].transform, "story_v_out_104091", "104091004", "story_v_out_104091.awb")

						arg_16_1:RecordAudio("104091004", var_19_10)
						arg_16_1:RecordAudio("104091004", var_19_10)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_104091", "104091004", "story_v_out_104091.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_104091", "104091004", "story_v_out_104091.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_11 = math.max(var_19_2, arg_16_1.talkMaxDuration)

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_11 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_1) / var_19_11

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_1 + var_19_11 and arg_16_1.time_ < var_19_1 + var_19_11 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play104091005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104091005
		arg_20_1.duration_ = 5.97

		local var_20_0 = {
			ja = 5.966,
			ko = 3.8,
			zh = 5.866,
			en = 2.9
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play104091006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "1019ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_20_1.stage_.transform)

					var_23_2.name = var_23_0
					var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_0] = var_23_2

					local var_23_3 = var_23_2:GetComponentInChildren(typeof(CharacterEffect))

					var_23_3.enabled = true

					local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_2, typeof(DynamicBoneHelper))

					if var_23_4 then
						var_23_4:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_3.transform, false)

					arg_20_1.var_[var_23_0 .. "Animator"] = var_23_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_0 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_0 .. "LipSync"] = var_23_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_5 = arg_20_1.actors_["1019ui_story"]
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1019ui_story == nil then
				arg_20_1.var_.characterEffect1019ui_story = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_7 = 0.1

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_7 and not isNil(var_23_5) then
				local var_23_8 = (arg_20_1.time_ - var_23_6) / var_23_7

				if arg_20_1.var_.characterEffect1019ui_story and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1019ui_story then
				arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_23_9 = arg_20_1.actors_["1011ui_story"]
			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect1011ui_story == nil then
				arg_20_1.var_.characterEffect1011ui_story = var_23_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_11 = 0.1

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_11 and not isNil(var_23_9) then
				local var_23_12 = (arg_20_1.time_ - var_23_10) / var_23_11

				if arg_20_1.var_.characterEffect1011ui_story and not isNil(var_23_9) then
					local var_23_13 = Mathf.Lerp(0, 0.5, var_23_12)

					arg_20_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1011ui_story.fillRatio = var_23_13
				end
			end

			if arg_20_1.time_ >= var_23_10 + var_23_11 and arg_20_1.time_ < var_23_10 + var_23_11 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect1011ui_story then
				local var_23_14 = 0.5

				arg_20_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1011ui_story.fillRatio = var_23_14
			end

			local var_23_15 = arg_20_1.actors_["1011ui_story"].transform
			local var_23_16 = 0

			if var_23_16 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.var_.moveOldPos1011ui_story = var_23_15.localPosition
			end

			local var_23_17 = 0.001

			if var_23_16 <= arg_20_1.time_ and arg_20_1.time_ < var_23_16 + var_23_17 then
				local var_23_18 = (arg_20_1.time_ - var_23_16) / var_23_17
				local var_23_19 = Vector3.New(0, 100, 0)

				var_23_15.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1011ui_story, var_23_19, var_23_18)

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

			local var_23_24 = arg_20_1.actors_["1084ui_story"].transform
			local var_23_25 = 0

			if var_23_25 < arg_20_1.time_ and arg_20_1.time_ <= var_23_25 + arg_23_0 then
				arg_20_1.var_.moveOldPos1084ui_story = var_23_24.localPosition
			end

			local var_23_26 = 0.001

			if var_23_25 <= arg_20_1.time_ and arg_20_1.time_ < var_23_25 + var_23_26 then
				local var_23_27 = (arg_20_1.time_ - var_23_25) / var_23_26
				local var_23_28 = Vector3.New(0, 100, 0)

				var_23_24.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1084ui_story, var_23_28, var_23_27)

				local var_23_29 = manager.ui.mainCamera.transform.position - var_23_24.position

				var_23_24.forward = Vector3.New(var_23_29.x, var_23_29.y, var_23_29.z)

				local var_23_30 = var_23_24.localEulerAngles

				var_23_30.z = 0
				var_23_30.x = 0
				var_23_24.localEulerAngles = var_23_30
			end

			if arg_20_1.time_ >= var_23_25 + var_23_26 and arg_20_1.time_ < var_23_25 + var_23_26 + arg_23_0 then
				var_23_24.localPosition = Vector3.New(0, 100, 0)

				local var_23_31 = manager.ui.mainCamera.transform.position - var_23_24.position

				var_23_24.forward = Vector3.New(var_23_31.x, var_23_31.y, var_23_31.z)

				local var_23_32 = var_23_24.localEulerAngles

				var_23_32.z = 0
				var_23_32.x = 0
				var_23_24.localEulerAngles = var_23_32
			end

			local var_23_33 = arg_20_1.actors_["1019ui_story"].transform
			local var_23_34 = 0

			if var_23_34 < arg_20_1.time_ and arg_20_1.time_ <= var_23_34 + arg_23_0 then
				arg_20_1.var_.moveOldPos1019ui_story = var_23_33.localPosition
			end

			local var_23_35 = 0.001

			if var_23_34 <= arg_20_1.time_ and arg_20_1.time_ < var_23_34 + var_23_35 then
				local var_23_36 = (arg_20_1.time_ - var_23_34) / var_23_35
				local var_23_37 = Vector3.New(-0.2, -1.08, -5.9)

				var_23_33.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1019ui_story, var_23_37, var_23_36)

				local var_23_38 = manager.ui.mainCamera.transform.position - var_23_33.position

				var_23_33.forward = Vector3.New(var_23_38.x, var_23_38.y, var_23_38.z)

				local var_23_39 = var_23_33.localEulerAngles

				var_23_39.z = 0
				var_23_39.x = 0
				var_23_33.localEulerAngles = var_23_39
			end

			if arg_20_1.time_ >= var_23_34 + var_23_35 and arg_20_1.time_ < var_23_34 + var_23_35 + arg_23_0 then
				var_23_33.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_23_40 = manager.ui.mainCamera.transform.position - var_23_33.position

				var_23_33.forward = Vector3.New(var_23_40.x, var_23_40.y, var_23_40.z)

				local var_23_41 = var_23_33.localEulerAngles

				var_23_41.z = 0
				var_23_41.x = 0
				var_23_33.localEulerAngles = var_23_41
			end

			local var_23_42 = 0

			if var_23_42 < arg_20_1.time_ and arg_20_1.time_ <= var_23_42 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_23_43 = 0

			if var_23_43 < arg_20_1.time_ and arg_20_1.time_ <= var_23_43 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_23_44 = 0
			local var_23_45 = 0.775

			if var_23_44 < arg_20_1.time_ and arg_20_1.time_ <= var_23_44 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_46 = arg_20_1:FormatText(StoryNameCfg[13].name)

				arg_20_1.leftNameTxt_.text = var_23_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_47 = arg_20_1:GetWordFromCfg(104091005)
				local var_23_48 = arg_20_1:FormatText(var_23_47.content)

				arg_20_1.text_.text = var_23_48

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_49 = 31
				local var_23_50 = utf8.len(var_23_48)
				local var_23_51 = var_23_49 <= 0 and var_23_45 or var_23_45 * (var_23_50 / var_23_49)

				if var_23_51 > 0 and var_23_45 < var_23_51 then
					arg_20_1.talkMaxDuration = var_23_51

					if var_23_51 + var_23_44 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_51 + var_23_44
					end
				end

				arg_20_1.text_.text = var_23_48
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104091", "104091005", "story_v_out_104091.awb") ~= 0 then
					local var_23_52 = manager.audio:GetVoiceLength("story_v_out_104091", "104091005", "story_v_out_104091.awb") / 1000

					if var_23_52 + var_23_44 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_52 + var_23_44
					end

					if var_23_47.prefab_name ~= "" and arg_20_1.actors_[var_23_47.prefab_name] ~= nil then
						local var_23_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_47.prefab_name].transform, "story_v_out_104091", "104091005", "story_v_out_104091.awb")

						arg_20_1:RecordAudio("104091005", var_23_53)
						arg_20_1:RecordAudio("104091005", var_23_53)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104091", "104091005", "story_v_out_104091.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104091", "104091005", "story_v_out_104091.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_54 = math.max(var_23_45, arg_20_1.talkMaxDuration)

			if var_23_44 <= arg_20_1.time_ and arg_20_1.time_ < var_23_44 + var_23_54 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_44) / var_23_54

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_44 + var_23_54 and arg_20_1.time_ < var_23_44 + var_23_54 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play104091006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104091006
		arg_24_1.duration_ = 3.77

		local var_24_0 = {
			ja = 3.566,
			ko = 2.266,
			zh = 3.766,
			en = 3.7
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
				arg_24_0:Play104091007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "1036ui_story"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_24_1.stage_.transform)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentInChildren(typeof(CharacterEffect))

					var_27_3.enabled = true

					local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_2, typeof(DynamicBoneHelper))

					if var_27_4 then
						var_27_4:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_3.transform, false)

					arg_24_1.var_[var_27_0 .. "Animator"] = var_27_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_0 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_0 .. "LipSync"] = var_27_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_5 = arg_24_1.actors_["1036ui_story"]
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect1036ui_story == nil then
				arg_24_1.var_.characterEffect1036ui_story = var_27_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_7 = 0.1

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_7 and not isNil(var_27_5) then
				local var_27_8 = (arg_24_1.time_ - var_27_6) / var_27_7

				if arg_24_1.var_.characterEffect1036ui_story and not isNil(var_27_5) then
					arg_24_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_6 + var_27_7 and arg_24_1.time_ < var_27_6 + var_27_7 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect1036ui_story then
				arg_24_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_27_9 = arg_24_1.actors_["1019ui_story"]
			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = var_27_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_11 = 0.1

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_11 and not isNil(var_27_9) then
				local var_27_12 = (arg_24_1.time_ - var_27_10) / var_27_11

				if arg_24_1.var_.characterEffect1019ui_story and not isNil(var_27_9) then
					local var_27_13 = Mathf.Lerp(0, 0.5, var_27_12)

					arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1019ui_story.fillRatio = var_27_13
				end
			end

			if arg_24_1.time_ >= var_27_10 + var_27_11 and arg_24_1.time_ < var_27_10 + var_27_11 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1019ui_story then
				local var_27_14 = 0.5

				arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1019ui_story.fillRatio = var_27_14
			end

			local var_27_15 = arg_24_1.actors_["1019ui_story"].transform
			local var_27_16 = 0

			if var_27_16 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 then
				arg_24_1.var_.moveOldPos1019ui_story = var_27_15.localPosition
			end

			local var_27_17 = 0.001

			if var_27_16 <= arg_24_1.time_ and arg_24_1.time_ < var_27_16 + var_27_17 then
				local var_27_18 = (arg_24_1.time_ - var_27_16) / var_27_17
				local var_27_19 = Vector3.New(0, 100, 0)

				var_27_15.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1019ui_story, var_27_19, var_27_18)

				local var_27_20 = manager.ui.mainCamera.transform.position - var_27_15.position

				var_27_15.forward = Vector3.New(var_27_20.x, var_27_20.y, var_27_20.z)

				local var_27_21 = var_27_15.localEulerAngles

				var_27_21.z = 0
				var_27_21.x = 0
				var_27_15.localEulerAngles = var_27_21
			end

			if arg_24_1.time_ >= var_27_16 + var_27_17 and arg_24_1.time_ < var_27_16 + var_27_17 + arg_27_0 then
				var_27_15.localPosition = Vector3.New(0, 100, 0)

				local var_27_22 = manager.ui.mainCamera.transform.position - var_27_15.position

				var_27_15.forward = Vector3.New(var_27_22.x, var_27_22.y, var_27_22.z)

				local var_27_23 = var_27_15.localEulerAngles

				var_27_23.z = 0
				var_27_23.x = 0
				var_27_15.localEulerAngles = var_27_23
			end

			local var_27_24 = 0

			if var_27_24 < arg_24_1.time_ and arg_24_1.time_ <= var_27_24 + arg_27_0 then
				arg_24_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_27_25 = arg_24_1.actors_["1036ui_story"].transform
			local var_27_26 = 0

			if var_27_26 < arg_24_1.time_ and arg_24_1.time_ <= var_27_26 + arg_27_0 then
				arg_24_1.var_.moveOldPos1036ui_story = var_27_25.localPosition
			end

			local var_27_27 = 0.001

			if var_27_26 <= arg_24_1.time_ and arg_24_1.time_ < var_27_26 + var_27_27 then
				local var_27_28 = (arg_24_1.time_ - var_27_26) / var_27_27
				local var_27_29 = Vector3.New(-0.7, -1.09, -5.78)

				var_27_25.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1036ui_story, var_27_29, var_27_28)

				local var_27_30 = manager.ui.mainCamera.transform.position - var_27_25.position

				var_27_25.forward = Vector3.New(var_27_30.x, var_27_30.y, var_27_30.z)

				local var_27_31 = var_27_25.localEulerAngles

				var_27_31.z = 0
				var_27_31.x = 0
				var_27_25.localEulerAngles = var_27_31
			end

			if arg_24_1.time_ >= var_27_26 + var_27_27 and arg_24_1.time_ < var_27_26 + var_27_27 + arg_27_0 then
				var_27_25.localPosition = Vector3.New(-0.7, -1.09, -5.78)

				local var_27_32 = manager.ui.mainCamera.transform.position - var_27_25.position

				var_27_25.forward = Vector3.New(var_27_32.x, var_27_32.y, var_27_32.z)

				local var_27_33 = var_27_25.localEulerAngles

				var_27_33.z = 0
				var_27_33.x = 0
				var_27_25.localEulerAngles = var_27_33
			end

			local var_27_34 = 0

			if var_27_34 < arg_24_1.time_ and arg_24_1.time_ <= var_27_34 + arg_27_0 then
				arg_24_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_27_35 = 0
			local var_27_36 = 0.35

			if var_27_35 < arg_24_1.time_ and arg_24_1.time_ <= var_27_35 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_37 = arg_24_1:FormatText(StoryNameCfg[5].name)

				arg_24_1.leftNameTxt_.text = var_27_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_38 = arg_24_1:GetWordFromCfg(104091006)
				local var_27_39 = arg_24_1:FormatText(var_27_38.content)

				arg_24_1.text_.text = var_27_39

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_40 = 14
				local var_27_41 = utf8.len(var_27_39)
				local var_27_42 = var_27_40 <= 0 and var_27_36 or var_27_36 * (var_27_41 / var_27_40)

				if var_27_42 > 0 and var_27_36 < var_27_42 then
					arg_24_1.talkMaxDuration = var_27_42

					if var_27_42 + var_27_35 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_42 + var_27_35
					end
				end

				arg_24_1.text_.text = var_27_39
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104091", "104091006", "story_v_out_104091.awb") ~= 0 then
					local var_27_43 = manager.audio:GetVoiceLength("story_v_out_104091", "104091006", "story_v_out_104091.awb") / 1000

					if var_27_43 + var_27_35 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_43 + var_27_35
					end

					if var_27_38.prefab_name ~= "" and arg_24_1.actors_[var_27_38.prefab_name] ~= nil then
						local var_27_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_38.prefab_name].transform, "story_v_out_104091", "104091006", "story_v_out_104091.awb")

						arg_24_1:RecordAudio("104091006", var_27_44)
						arg_24_1:RecordAudio("104091006", var_27_44)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_104091", "104091006", "story_v_out_104091.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_104091", "104091006", "story_v_out_104091.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_45 = math.max(var_27_36, arg_24_1.talkMaxDuration)

			if var_27_35 <= arg_24_1.time_ and arg_24_1.time_ < var_27_35 + var_27_45 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_35) / var_27_45

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_35 + var_27_45 and arg_24_1.time_ < var_27_35 + var_27_45 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play104091007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104091007
		arg_28_1.duration_ = 6.97

		local var_28_0 = {
			ja = 6.966,
			ko = 6.9,
			zh = 5.6,
			en = 6.333
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
				arg_28_0:Play104091008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "10001_tpose"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "10001_tpose")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_28_1.stage_.transform)

					var_31_2.name = var_31_0
					var_31_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_28_1.actors_[var_31_0] = var_31_2

					local var_31_3 = var_31_2:GetComponentInChildren(typeof(CharacterEffect))

					var_31_3.enabled = true

					local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_2, typeof(DynamicBoneHelper))

					if var_31_4 then
						var_31_4:EnableDynamicBone(false)
					end

					arg_28_1:ShowWeapon(var_31_3.transform, false)

					arg_28_1.var_[var_31_0 .. "Animator"] = var_31_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_28_1.var_[var_31_0 .. "Animator"].applyRootMotion = true
					arg_28_1.var_[var_31_0 .. "LipSync"] = var_31_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_31_5 = arg_28_1.actors_["10001_tpose"]
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect10001_tpose == nil then
				arg_28_1.var_.characterEffect10001_tpose = var_31_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_7 = 0.1

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_7 and not isNil(var_31_5) then
				local var_31_8 = (arg_28_1.time_ - var_31_6) / var_31_7

				if arg_28_1.var_.characterEffect10001_tpose and not isNil(var_31_5) then
					arg_28_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_6 + var_31_7 and arg_28_1.time_ < var_31_6 + var_31_7 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect10001_tpose then
				arg_28_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_31_9 = arg_28_1.actors_["1036ui_story"]
			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect1036ui_story == nil then
				arg_28_1.var_.characterEffect1036ui_story = var_31_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_11 = 0.1

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_11 and not isNil(var_31_9) then
				local var_31_12 = (arg_28_1.time_ - var_31_10) / var_31_11

				if arg_28_1.var_.characterEffect1036ui_story and not isNil(var_31_9) then
					local var_31_13 = Mathf.Lerp(0, 0.5, var_31_12)

					arg_28_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1036ui_story.fillRatio = var_31_13
				end
			end

			if arg_28_1.time_ >= var_31_10 + var_31_11 and arg_28_1.time_ < var_31_10 + var_31_11 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect1036ui_story then
				local var_31_14 = 0.5

				arg_28_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1036ui_story.fillRatio = var_31_14
			end

			local var_31_15 = arg_28_1.actors_["10001_tpose"].transform
			local var_31_16 = 0

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1.var_.moveOldPos10001_tpose = var_31_15.localPosition

				local var_31_17 = GameObjectTools.GetOrAddComponent(var_31_15.gameObject, typeof(DynamicBoneHelper))

				if var_31_17 then
					var_31_17:EnableDynamicBone(false)
				end
			end

			local var_31_18 = 0.001

			if var_31_16 <= arg_28_1.time_ and arg_28_1.time_ < var_31_16 + var_31_18 then
				local var_31_19 = (arg_28_1.time_ - var_31_16) / var_31_18
				local var_31_20 = Vector3.New(0.7, -1.23, -5.8)

				var_31_15.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10001_tpose, var_31_20, var_31_19)

				local var_31_21 = manager.ui.mainCamera.transform.position - var_31_15.position

				var_31_15.forward = Vector3.New(var_31_21.x, var_31_21.y, var_31_21.z)

				local var_31_22 = var_31_15.localEulerAngles

				var_31_22.z = 0
				var_31_22.x = 0
				var_31_15.localEulerAngles = var_31_22
			end

			if arg_28_1.time_ >= var_31_16 + var_31_18 and arg_28_1.time_ < var_31_16 + var_31_18 + arg_31_0 then
				var_31_15.localPosition = Vector3.New(0.7, -1.23, -5.8)

				local var_31_23 = manager.ui.mainCamera.transform.position - var_31_15.position

				var_31_15.forward = Vector3.New(var_31_23.x, var_31_23.y, var_31_23.z)

				local var_31_24 = var_31_15.localEulerAngles

				var_31_24.z = 0
				var_31_24.x = 0
				var_31_15.localEulerAngles = var_31_24

				local var_31_25 = GameObjectTools.GetOrAddComponent(var_31_15.gameObject, typeof(DynamicBoneHelper))

				if var_31_25 then
					var_31_25:EnableDynamicBone(true)
				end
			end

			local var_31_26 = 0

			if var_31_26 < arg_28_1.time_ and arg_28_1.time_ <= var_31_26 + arg_31_0 then
				arg_28_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action3_1")
			end

			local var_31_27 = 0

			if var_31_27 < arg_28_1.time_ and arg_28_1.time_ <= var_31_27 + arg_31_0 then
				arg_28_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_31_28 = 0
			local var_31_29 = 0.875

			if var_31_28 < arg_28_1.time_ and arg_28_1.time_ <= var_31_28 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_30 = arg_28_1:FormatText(StoryNameCfg[31].name)

				arg_28_1.leftNameTxt_.text = var_31_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_31 = arg_28_1:GetWordFromCfg(104091007)
				local var_31_32 = arg_28_1:FormatText(var_31_31.content)

				arg_28_1.text_.text = var_31_32

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_33 = 34
				local var_31_34 = utf8.len(var_31_32)
				local var_31_35 = var_31_33 <= 0 and var_31_29 or var_31_29 * (var_31_34 / var_31_33)

				if var_31_35 > 0 and var_31_29 < var_31_35 then
					arg_28_1.talkMaxDuration = var_31_35

					if var_31_35 + var_31_28 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_35 + var_31_28
					end
				end

				arg_28_1.text_.text = var_31_32
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104091", "104091007", "story_v_out_104091.awb") ~= 0 then
					local var_31_36 = manager.audio:GetVoiceLength("story_v_out_104091", "104091007", "story_v_out_104091.awb") / 1000

					if var_31_36 + var_31_28 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_36 + var_31_28
					end

					if var_31_31.prefab_name ~= "" and arg_28_1.actors_[var_31_31.prefab_name] ~= nil then
						local var_31_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_31.prefab_name].transform, "story_v_out_104091", "104091007", "story_v_out_104091.awb")

						arg_28_1:RecordAudio("104091007", var_31_37)
						arg_28_1:RecordAudio("104091007", var_31_37)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_104091", "104091007", "story_v_out_104091.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_104091", "104091007", "story_v_out_104091.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_38 = math.max(var_31_29, arg_28_1.talkMaxDuration)

			if var_31_28 <= arg_28_1.time_ and arg_28_1.time_ < var_31_28 + var_31_38 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_28) / var_31_38

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_28 + var_31_38 and arg_28_1.time_ < var_31_28 + var_31_38 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play104091008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104091008
		arg_32_1.duration_ = 6.17

		local var_32_0 = {
			ja = 6.166,
			ko = 3.666,
			zh = 4.766,
			en = 5.233
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
				arg_32_0:Play104091009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1019ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1019ui_story == nil then
				arg_32_1.var_.characterEffect1019ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1019ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1019ui_story then
				arg_32_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["10001_tpose"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect10001_tpose == nil then
				arg_32_1.var_.characterEffect10001_tpose = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.1

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect10001_tpose and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_32_1.var_.characterEffect10001_tpose.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect10001_tpose then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_32_1.var_.characterEffect10001_tpose.fillRatio = var_35_9
			end

			local var_35_10 = arg_32_1.actors_["1036ui_story"].transform
			local var_35_11 = 0

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1.var_.moveOldPos1036ui_story = var_35_10.localPosition
			end

			local var_35_12 = 0.001

			if var_35_11 <= arg_32_1.time_ and arg_32_1.time_ < var_35_11 + var_35_12 then
				local var_35_13 = (arg_32_1.time_ - var_35_11) / var_35_12
				local var_35_14 = Vector3.New(0, 100, 0)

				var_35_10.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1036ui_story, var_35_14, var_35_13)

				local var_35_15 = manager.ui.mainCamera.transform.position - var_35_10.position

				var_35_10.forward = Vector3.New(var_35_15.x, var_35_15.y, var_35_15.z)

				local var_35_16 = var_35_10.localEulerAngles

				var_35_16.z = 0
				var_35_16.x = 0
				var_35_10.localEulerAngles = var_35_16
			end

			if arg_32_1.time_ >= var_35_11 + var_35_12 and arg_32_1.time_ < var_35_11 + var_35_12 + arg_35_0 then
				var_35_10.localPosition = Vector3.New(0, 100, 0)

				local var_35_17 = manager.ui.mainCamera.transform.position - var_35_10.position

				var_35_10.forward = Vector3.New(var_35_17.x, var_35_17.y, var_35_17.z)

				local var_35_18 = var_35_10.localEulerAngles

				var_35_18.z = 0
				var_35_18.x = 0
				var_35_10.localEulerAngles = var_35_18
			end

			local var_35_19 = arg_32_1.actors_["1019ui_story"].transform
			local var_35_20 = 0

			if var_35_20 < arg_32_1.time_ and arg_32_1.time_ <= var_35_20 + arg_35_0 then
				arg_32_1.var_.moveOldPos1019ui_story = var_35_19.localPosition
			end

			local var_35_21 = 0.001

			if var_35_20 <= arg_32_1.time_ and arg_32_1.time_ < var_35_20 + var_35_21 then
				local var_35_22 = (arg_32_1.time_ - var_35_20) / var_35_21
				local var_35_23 = Vector3.New(-0.7, -1.08, -5.9)

				var_35_19.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1019ui_story, var_35_23, var_35_22)

				local var_35_24 = manager.ui.mainCamera.transform.position - var_35_19.position

				var_35_19.forward = Vector3.New(var_35_24.x, var_35_24.y, var_35_24.z)

				local var_35_25 = var_35_19.localEulerAngles

				var_35_25.z = 0
				var_35_25.x = 0
				var_35_19.localEulerAngles = var_35_25
			end

			if arg_32_1.time_ >= var_35_20 + var_35_21 and arg_32_1.time_ < var_35_20 + var_35_21 + arg_35_0 then
				var_35_19.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_35_26 = manager.ui.mainCamera.transform.position - var_35_19.position

				var_35_19.forward = Vector3.New(var_35_26.x, var_35_26.y, var_35_26.z)

				local var_35_27 = var_35_19.localEulerAngles

				var_35_27.z = 0
				var_35_27.x = 0
				var_35_19.localEulerAngles = var_35_27
			end

			local var_35_28 = 0

			if var_35_28 < arg_32_1.time_ and arg_32_1.time_ <= var_35_28 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_35_29 = 0

			if var_35_29 < arg_32_1.time_ and arg_32_1.time_ <= var_35_29 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_35_30 = 0
			local var_35_31 = 0.55

			if var_35_30 < arg_32_1.time_ and arg_32_1.time_ <= var_35_30 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_32 = arg_32_1:FormatText(StoryNameCfg[13].name)

				arg_32_1.leftNameTxt_.text = var_35_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_33 = arg_32_1:GetWordFromCfg(104091008)
				local var_35_34 = arg_32_1:FormatText(var_35_33.content)

				arg_32_1.text_.text = var_35_34

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_35 = 22
				local var_35_36 = utf8.len(var_35_34)
				local var_35_37 = var_35_35 <= 0 and var_35_31 or var_35_31 * (var_35_36 / var_35_35)

				if var_35_37 > 0 and var_35_31 < var_35_37 then
					arg_32_1.talkMaxDuration = var_35_37

					if var_35_37 + var_35_30 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_37 + var_35_30
					end
				end

				arg_32_1.text_.text = var_35_34
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104091", "104091008", "story_v_out_104091.awb") ~= 0 then
					local var_35_38 = manager.audio:GetVoiceLength("story_v_out_104091", "104091008", "story_v_out_104091.awb") / 1000

					if var_35_38 + var_35_30 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_38 + var_35_30
					end

					if var_35_33.prefab_name ~= "" and arg_32_1.actors_[var_35_33.prefab_name] ~= nil then
						local var_35_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_33.prefab_name].transform, "story_v_out_104091", "104091008", "story_v_out_104091.awb")

						arg_32_1:RecordAudio("104091008", var_35_39)
						arg_32_1:RecordAudio("104091008", var_35_39)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_104091", "104091008", "story_v_out_104091.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_104091", "104091008", "story_v_out_104091.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_40 = math.max(var_35_31, arg_32_1.talkMaxDuration)

			if var_35_30 <= arg_32_1.time_ and arg_32_1.time_ < var_35_30 + var_35_40 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_30) / var_35_40

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_30 + var_35_40 and arg_32_1.time_ < var_35_30 + var_35_40 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play104091009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104091009
		arg_36_1.duration_ = 19.33

		local var_36_0 = {
			ja = 19.333,
			ko = 15.066,
			zh = 14.533,
			en = 18.333
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
				arg_36_0:Play104091010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10001_tpose"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10001_tpose == nil then
				arg_36_1.var_.characterEffect10001_tpose = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect10001_tpose and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10001_tpose then
				arg_36_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["1019ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1019ui_story == nil then
				arg_36_1.var_.characterEffect1019ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.1

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect1019ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1019ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1019ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1019ui_story.fillRatio = var_39_9
			end

			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action434")
			end

			local var_39_11 = 0

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_39_12 = 0
			local var_39_13 = 1.95

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_14 = arg_36_1:FormatText(StoryNameCfg[31].name)

				arg_36_1.leftNameTxt_.text = var_39_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_15 = arg_36_1:GetWordFromCfg(104091009)
				local var_39_16 = arg_36_1:FormatText(var_39_15.content)

				arg_36_1.text_.text = var_39_16

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_17 = 74
				local var_39_18 = utf8.len(var_39_16)
				local var_39_19 = var_39_17 <= 0 and var_39_13 or var_39_13 * (var_39_18 / var_39_17)

				if var_39_19 > 0 and var_39_13 < var_39_19 then
					arg_36_1.talkMaxDuration = var_39_19

					if var_39_19 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_19 + var_39_12
					end
				end

				arg_36_1.text_.text = var_39_16
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104091", "104091009", "story_v_out_104091.awb") ~= 0 then
					local var_39_20 = manager.audio:GetVoiceLength("story_v_out_104091", "104091009", "story_v_out_104091.awb") / 1000

					if var_39_20 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_20 + var_39_12
					end

					if var_39_15.prefab_name ~= "" and arg_36_1.actors_[var_39_15.prefab_name] ~= nil then
						local var_39_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_15.prefab_name].transform, "story_v_out_104091", "104091009", "story_v_out_104091.awb")

						arg_36_1:RecordAudio("104091009", var_39_21)
						arg_36_1:RecordAudio("104091009", var_39_21)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_104091", "104091009", "story_v_out_104091.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_104091", "104091009", "story_v_out_104091.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_22 = math.max(var_39_13, arg_36_1.talkMaxDuration)

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_22 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_12) / var_39_22

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_12 + var_39_22 and arg_36_1.time_ < var_39_12 + var_39_22 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play104091010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104091010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play104091011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10001_tpose"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10001_tpose == nil then
				arg_40_1.var_.characterEffect10001_tpose = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect10001_tpose and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_40_1.var_.characterEffect10001_tpose.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10001_tpose then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_40_1.var_.characterEffect10001_tpose.fillRatio = var_43_5
			end

			local var_43_6 = arg_40_1.actors_["1019ui_story"].transform
			local var_43_7 = 0

			if var_43_7 < arg_40_1.time_ and arg_40_1.time_ <= var_43_7 + arg_43_0 then
				arg_40_1.var_.moveOldPos1019ui_story = var_43_6.localPosition
			end

			local var_43_8 = 0.001

			if var_43_7 <= arg_40_1.time_ and arg_40_1.time_ < var_43_7 + var_43_8 then
				local var_43_9 = (arg_40_1.time_ - var_43_7) / var_43_8
				local var_43_10 = Vector3.New(0, 100, 0)

				var_43_6.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1019ui_story, var_43_10, var_43_9)

				local var_43_11 = manager.ui.mainCamera.transform.position - var_43_6.position

				var_43_6.forward = Vector3.New(var_43_11.x, var_43_11.y, var_43_11.z)

				local var_43_12 = var_43_6.localEulerAngles

				var_43_12.z = 0
				var_43_12.x = 0
				var_43_6.localEulerAngles = var_43_12
			end

			if arg_40_1.time_ >= var_43_7 + var_43_8 and arg_40_1.time_ < var_43_7 + var_43_8 + arg_43_0 then
				var_43_6.localPosition = Vector3.New(0, 100, 0)

				local var_43_13 = manager.ui.mainCamera.transform.position - var_43_6.position

				var_43_6.forward = Vector3.New(var_43_13.x, var_43_13.y, var_43_13.z)

				local var_43_14 = var_43_6.localEulerAngles

				var_43_14.z = 0
				var_43_14.x = 0
				var_43_6.localEulerAngles = var_43_14
			end

			local var_43_15 = arg_40_1.actors_["10001_tpose"].transform
			local var_43_16 = 0

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 then
				arg_40_1.var_.moveOldPos10001_tpose = var_43_15.localPosition

				local var_43_17 = GameObjectTools.GetOrAddComponent(var_43_15.gameObject, typeof(DynamicBoneHelper))

				if var_43_17 then
					var_43_17:EnableDynamicBone(false)
				end
			end

			local var_43_18 = 0.001

			if var_43_16 <= arg_40_1.time_ and arg_40_1.time_ < var_43_16 + var_43_18 then
				local var_43_19 = (arg_40_1.time_ - var_43_16) / var_43_18
				local var_43_20 = Vector3.New(0, 100, 0)

				var_43_15.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10001_tpose, var_43_20, var_43_19)

				local var_43_21 = manager.ui.mainCamera.transform.position - var_43_15.position

				var_43_15.forward = Vector3.New(var_43_21.x, var_43_21.y, var_43_21.z)

				local var_43_22 = var_43_15.localEulerAngles

				var_43_22.z = 0
				var_43_22.x = 0
				var_43_15.localEulerAngles = var_43_22
			end

			if arg_40_1.time_ >= var_43_16 + var_43_18 and arg_40_1.time_ < var_43_16 + var_43_18 + arg_43_0 then
				var_43_15.localPosition = Vector3.New(0, 100, 0)

				local var_43_23 = manager.ui.mainCamera.transform.position - var_43_15.position

				var_43_15.forward = Vector3.New(var_43_23.x, var_43_23.y, var_43_23.z)

				local var_43_24 = var_43_15.localEulerAngles

				var_43_24.z = 0
				var_43_24.x = 0
				var_43_15.localEulerAngles = var_43_24

				local var_43_25 = GameObjectTools.GetOrAddComponent(var_43_15.gameObject, typeof(DynamicBoneHelper))

				if var_43_25 then
					var_43_25:EnableDynamicBone(true)
				end
			end

			local var_43_26 = 0
			local var_43_27 = 0.575

			if var_43_26 < arg_40_1.time_ and arg_40_1.time_ <= var_43_26 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_28 = arg_40_1:GetWordFromCfg(104091010)
				local var_43_29 = arg_40_1:FormatText(var_43_28.content)

				arg_40_1.text_.text = var_43_29

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_30 = 23
				local var_43_31 = utf8.len(var_43_29)
				local var_43_32 = var_43_30 <= 0 and var_43_27 or var_43_27 * (var_43_31 / var_43_30)

				if var_43_32 > 0 and var_43_27 < var_43_32 then
					arg_40_1.talkMaxDuration = var_43_32

					if var_43_32 + var_43_26 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_32 + var_43_26
					end
				end

				arg_40_1.text_.text = var_43_29
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_33 = math.max(var_43_27, arg_40_1.talkMaxDuration)

			if var_43_26 <= arg_40_1.time_ and arg_40_1.time_ < var_43_26 + var_43_33 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_26) / var_43_33

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_26 + var_43_33 and arg_40_1.time_ < var_43_26 + var_43_33 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play104091011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104091011
		arg_44_1.duration_ = 13

		local var_44_0 = {
			ja = 12.3,
			ko = 8.8,
			zh = 9.7,
			en = 13
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
				arg_44_0:Play104091012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["10001_tpose"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect10001_tpose == nil then
				arg_44_1.var_.characterEffect10001_tpose = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect10001_tpose and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect10001_tpose then
				arg_44_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["10001_tpose"].transform
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1.var_.moveOldPos10001_tpose = var_47_4.localPosition

				local var_47_6 = GameObjectTools.GetOrAddComponent(var_47_4.gameObject, typeof(DynamicBoneHelper))

				if var_47_6 then
					var_47_6:EnableDynamicBone(false)
				end
			end

			local var_47_7 = 0.001

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_7 then
				local var_47_8 = (arg_44_1.time_ - var_47_5) / var_47_7
				local var_47_9 = Vector3.New(-0.7, -1.23, -5.8)

				var_47_4.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10001_tpose, var_47_9, var_47_8)

				local var_47_10 = manager.ui.mainCamera.transform.position - var_47_4.position

				var_47_4.forward = Vector3.New(var_47_10.x, var_47_10.y, var_47_10.z)

				local var_47_11 = var_47_4.localEulerAngles

				var_47_11.z = 0
				var_47_11.x = 0
				var_47_4.localEulerAngles = var_47_11
			end

			if arg_44_1.time_ >= var_47_5 + var_47_7 and arg_44_1.time_ < var_47_5 + var_47_7 + arg_47_0 then
				var_47_4.localPosition = Vector3.New(-0.7, -1.23, -5.8)

				local var_47_12 = manager.ui.mainCamera.transform.position - var_47_4.position

				var_47_4.forward = Vector3.New(var_47_12.x, var_47_12.y, var_47_12.z)

				local var_47_13 = var_47_4.localEulerAngles

				var_47_13.z = 0
				var_47_13.x = 0
				var_47_4.localEulerAngles = var_47_13

				local var_47_14 = GameObjectTools.GetOrAddComponent(var_47_4.gameObject, typeof(DynamicBoneHelper))

				if var_47_14 then
					var_47_14:EnableDynamicBone(true)
				end
			end

			local var_47_15 = 0

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action2_1")
			end

			local var_47_16 = 0

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_47_17 = 0
			local var_47_18 = 1.175

			if var_47_17 < arg_44_1.time_ and arg_44_1.time_ <= var_47_17 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_19 = arg_44_1:FormatText(StoryNameCfg[31].name)

				arg_44_1.leftNameTxt_.text = var_47_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_20 = arg_44_1:GetWordFromCfg(104091011)
				local var_47_21 = arg_44_1:FormatText(var_47_20.content)

				arg_44_1.text_.text = var_47_21

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_22 = 47
				local var_47_23 = utf8.len(var_47_21)
				local var_47_24 = var_47_22 <= 0 and var_47_18 or var_47_18 * (var_47_23 / var_47_22)

				if var_47_24 > 0 and var_47_18 < var_47_24 then
					arg_44_1.talkMaxDuration = var_47_24

					if var_47_24 + var_47_17 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_24 + var_47_17
					end
				end

				arg_44_1.text_.text = var_47_21
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104091", "104091011", "story_v_out_104091.awb") ~= 0 then
					local var_47_25 = manager.audio:GetVoiceLength("story_v_out_104091", "104091011", "story_v_out_104091.awb") / 1000

					if var_47_25 + var_47_17 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_25 + var_47_17
					end

					if var_47_20.prefab_name ~= "" and arg_44_1.actors_[var_47_20.prefab_name] ~= nil then
						local var_47_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_20.prefab_name].transform, "story_v_out_104091", "104091011", "story_v_out_104091.awb")

						arg_44_1:RecordAudio("104091011", var_47_26)
						arg_44_1:RecordAudio("104091011", var_47_26)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_104091", "104091011", "story_v_out_104091.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_104091", "104091011", "story_v_out_104091.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_27 = math.max(var_47_18, arg_44_1.talkMaxDuration)

			if var_47_17 <= arg_44_1.time_ and arg_44_1.time_ < var_47_17 + var_47_27 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_17) / var_47_27

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_17 + var_47_27 and arg_44_1.time_ < var_47_17 + var_47_27 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play104091012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 104091012
		arg_48_1.duration_ = 10.37

		local var_48_0 = {
			ja = 10.366,
			ko = 5.866,
			zh = 9.7,
			en = 8.133
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
				arg_48_0:Play104091013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1084ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["10001_tpose"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect10001_tpose == nil then
				arg_48_1.var_.characterEffect10001_tpose = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.1

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect10001_tpose and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_48_1.var_.characterEffect10001_tpose.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect10001_tpose then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_48_1.var_.characterEffect10001_tpose.fillRatio = var_51_9
			end

			local var_51_10 = arg_48_1.actors_["1084ui_story"].transform
			local var_51_11 = 0

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1.var_.moveOldPos1084ui_story = var_51_10.localPosition
			end

			local var_51_12 = 0.001

			if var_51_11 <= arg_48_1.time_ and arg_48_1.time_ < var_51_11 + var_51_12 then
				local var_51_13 = (arg_48_1.time_ - var_51_11) / var_51_12
				local var_51_14 = Vector3.New(0.7, -0.97, -6)

				var_51_10.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, var_51_14, var_51_13)

				local var_51_15 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_15.x, var_51_15.y, var_51_15.z)

				local var_51_16 = var_51_10.localEulerAngles

				var_51_16.z = 0
				var_51_16.x = 0
				var_51_10.localEulerAngles = var_51_16
			end

			if arg_48_1.time_ >= var_51_11 + var_51_12 and arg_48_1.time_ < var_51_11 + var_51_12 + arg_51_0 then
				var_51_10.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_51_17 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_17.x, var_51_17.y, var_51_17.z)

				local var_51_18 = var_51_10.localEulerAngles

				var_51_18.z = 0
				var_51_18.x = 0
				var_51_10.localEulerAngles = var_51_18
			end

			local var_51_19 = 0

			if var_51_19 < arg_48_1.time_ and arg_48_1.time_ <= var_51_19 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_51_20 = 0

			if var_51_20 < arg_48_1.time_ and arg_48_1.time_ <= var_51_20 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_51_21 = 0
			local var_51_22 = 0.85

			if var_51_21 < arg_48_1.time_ and arg_48_1.time_ <= var_51_21 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_23 = arg_48_1:FormatText(StoryNameCfg[6].name)

				arg_48_1.leftNameTxt_.text = var_51_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_24 = arg_48_1:GetWordFromCfg(104091012)
				local var_51_25 = arg_48_1:FormatText(var_51_24.content)

				arg_48_1.text_.text = var_51_25

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_26 = 33
				local var_51_27 = utf8.len(var_51_25)
				local var_51_28 = var_51_26 <= 0 and var_51_22 or var_51_22 * (var_51_27 / var_51_26)

				if var_51_28 > 0 and var_51_22 < var_51_28 then
					arg_48_1.talkMaxDuration = var_51_28

					if var_51_28 + var_51_21 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_28 + var_51_21
					end
				end

				arg_48_1.text_.text = var_51_25
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104091", "104091012", "story_v_out_104091.awb") ~= 0 then
					local var_51_29 = manager.audio:GetVoiceLength("story_v_out_104091", "104091012", "story_v_out_104091.awb") / 1000

					if var_51_29 + var_51_21 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_29 + var_51_21
					end

					if var_51_24.prefab_name ~= "" and arg_48_1.actors_[var_51_24.prefab_name] ~= nil then
						local var_51_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_24.prefab_name].transform, "story_v_out_104091", "104091012", "story_v_out_104091.awb")

						arg_48_1:RecordAudio("104091012", var_51_30)
						arg_48_1:RecordAudio("104091012", var_51_30)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_104091", "104091012", "story_v_out_104091.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_104091", "104091012", "story_v_out_104091.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_31 = math.max(var_51_22, arg_48_1.talkMaxDuration)

			if var_51_21 <= arg_48_1.time_ and arg_48_1.time_ < var_51_21 + var_51_31 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_21) / var_51_31

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_21 + var_51_31 and arg_48_1.time_ < var_51_21 + var_51_31 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play104091013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 104091013
		arg_52_1.duration_ = 9.4

		local var_52_0 = {
			ja = 9.4,
			ko = 6,
			zh = 5.966,
			en = 6.5
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
				arg_52_0:Play104091014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10001_tpose"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10001_tpose == nil then
				arg_52_1.var_.characterEffect10001_tpose = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect10001_tpose and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10001_tpose then
				arg_52_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["1084ui_story"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.1

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect1084ui_story then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_9
			end

			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action424")
			end

			local var_55_11 = 0

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_55_12 = 0
			local var_55_13 = 0.85

			if var_55_12 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_14 = arg_52_1:FormatText(StoryNameCfg[31].name)

				arg_52_1.leftNameTxt_.text = var_55_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_15 = arg_52_1:GetWordFromCfg(104091013)
				local var_55_16 = arg_52_1:FormatText(var_55_15.content)

				arg_52_1.text_.text = var_55_16

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_17 = 33
				local var_55_18 = utf8.len(var_55_16)
				local var_55_19 = var_55_17 <= 0 and var_55_13 or var_55_13 * (var_55_18 / var_55_17)

				if var_55_19 > 0 and var_55_13 < var_55_19 then
					arg_52_1.talkMaxDuration = var_55_19

					if var_55_19 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_19 + var_55_12
					end
				end

				arg_52_1.text_.text = var_55_16
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104091", "104091013", "story_v_out_104091.awb") ~= 0 then
					local var_55_20 = manager.audio:GetVoiceLength("story_v_out_104091", "104091013", "story_v_out_104091.awb") / 1000

					if var_55_20 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_20 + var_55_12
					end

					if var_55_15.prefab_name ~= "" and arg_52_1.actors_[var_55_15.prefab_name] ~= nil then
						local var_55_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_15.prefab_name].transform, "story_v_out_104091", "104091013", "story_v_out_104091.awb")

						arg_52_1:RecordAudio("104091013", var_55_21)
						arg_52_1:RecordAudio("104091013", var_55_21)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_104091", "104091013", "story_v_out_104091.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_104091", "104091013", "story_v_out_104091.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_22 = math.max(var_55_13, arg_52_1.talkMaxDuration)

			if var_55_12 <= arg_52_1.time_ and arg_52_1.time_ < var_55_12 + var_55_22 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_12) / var_55_22

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_12 + var_55_22 and arg_52_1.time_ < var_55_12 + var_55_22 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play104091014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 104091014
		arg_56_1.duration_ = 3.83

		local var_56_0 = {
			ja = 3.833,
			ko = 3.433,
			zh = 3.1,
			en = 3.733
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play104091015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1036ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1036ui_story == nil then
				arg_56_1.var_.characterEffect1036ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1036ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1036ui_story then
				arg_56_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["10001_tpose"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect10001_tpose == nil then
				arg_56_1.var_.characterEffect10001_tpose = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.1

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect10001_tpose and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_56_1.var_.characterEffect10001_tpose.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect10001_tpose then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_56_1.var_.characterEffect10001_tpose.fillRatio = var_59_9
			end

			local var_59_10 = arg_56_1.actors_["10001_tpose"].transform
			local var_59_11 = 0

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1.var_.moveOldPos10001_tpose = var_59_10.localPosition

				local var_59_12 = GameObjectTools.GetOrAddComponent(var_59_10.gameObject, typeof(DynamicBoneHelper))

				if var_59_12 then
					var_59_12:EnableDynamicBone(false)
				end
			end

			local var_59_13 = 0.001

			if var_59_11 <= arg_56_1.time_ and arg_56_1.time_ < var_59_11 + var_59_13 then
				local var_59_14 = (arg_56_1.time_ - var_59_11) / var_59_13
				local var_59_15 = Vector3.New(0, 100, 0)

				var_59_10.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10001_tpose, var_59_15, var_59_14)

				local var_59_16 = manager.ui.mainCamera.transform.position - var_59_10.position

				var_59_10.forward = Vector3.New(var_59_16.x, var_59_16.y, var_59_16.z)

				local var_59_17 = var_59_10.localEulerAngles

				var_59_17.z = 0
				var_59_17.x = 0
				var_59_10.localEulerAngles = var_59_17
			end

			if arg_56_1.time_ >= var_59_11 + var_59_13 and arg_56_1.time_ < var_59_11 + var_59_13 + arg_59_0 then
				var_59_10.localPosition = Vector3.New(0, 100, 0)

				local var_59_18 = manager.ui.mainCamera.transform.position - var_59_10.position

				var_59_10.forward = Vector3.New(var_59_18.x, var_59_18.y, var_59_18.z)

				local var_59_19 = var_59_10.localEulerAngles

				var_59_19.z = 0
				var_59_19.x = 0
				var_59_10.localEulerAngles = var_59_19

				local var_59_20 = GameObjectTools.GetOrAddComponent(var_59_10.gameObject, typeof(DynamicBoneHelper))

				if var_59_20 then
					var_59_20:EnableDynamicBone(true)
				end
			end

			local var_59_21 = arg_56_1.actors_["1084ui_story"].transform
			local var_59_22 = 0

			if var_59_22 < arg_56_1.time_ and arg_56_1.time_ <= var_59_22 + arg_59_0 then
				arg_56_1.var_.moveOldPos1084ui_story = var_59_21.localPosition
			end

			local var_59_23 = 0.001

			if var_59_22 <= arg_56_1.time_ and arg_56_1.time_ < var_59_22 + var_59_23 then
				local var_59_24 = (arg_56_1.time_ - var_59_22) / var_59_23
				local var_59_25 = Vector3.New(0, 100, 0)

				var_59_21.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1084ui_story, var_59_25, var_59_24)

				local var_59_26 = manager.ui.mainCamera.transform.position - var_59_21.position

				var_59_21.forward = Vector3.New(var_59_26.x, var_59_26.y, var_59_26.z)

				local var_59_27 = var_59_21.localEulerAngles

				var_59_27.z = 0
				var_59_27.x = 0
				var_59_21.localEulerAngles = var_59_27
			end

			if arg_56_1.time_ >= var_59_22 + var_59_23 and arg_56_1.time_ < var_59_22 + var_59_23 + arg_59_0 then
				var_59_21.localPosition = Vector3.New(0, 100, 0)

				local var_59_28 = manager.ui.mainCamera.transform.position - var_59_21.position

				var_59_21.forward = Vector3.New(var_59_28.x, var_59_28.y, var_59_28.z)

				local var_59_29 = var_59_21.localEulerAngles

				var_59_29.z = 0
				var_59_29.x = 0
				var_59_21.localEulerAngles = var_59_29
			end

			local var_59_30 = arg_56_1.actors_["1036ui_story"].transform
			local var_59_31 = 0

			if var_59_31 < arg_56_1.time_ and arg_56_1.time_ <= var_59_31 + arg_59_0 then
				arg_56_1.var_.moveOldPos1036ui_story = var_59_30.localPosition
			end

			local var_59_32 = 0.001

			if var_59_31 <= arg_56_1.time_ and arg_56_1.time_ < var_59_31 + var_59_32 then
				local var_59_33 = (arg_56_1.time_ - var_59_31) / var_59_32
				local var_59_34 = Vector3.New(-0.7, -1.09, -5.78)

				var_59_30.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1036ui_story, var_59_34, var_59_33)

				local var_59_35 = manager.ui.mainCamera.transform.position - var_59_30.position

				var_59_30.forward = Vector3.New(var_59_35.x, var_59_35.y, var_59_35.z)

				local var_59_36 = var_59_30.localEulerAngles

				var_59_36.z = 0
				var_59_36.x = 0
				var_59_30.localEulerAngles = var_59_36
			end

			if arg_56_1.time_ >= var_59_31 + var_59_32 and arg_56_1.time_ < var_59_31 + var_59_32 + arg_59_0 then
				var_59_30.localPosition = Vector3.New(-0.7, -1.09, -5.78)

				local var_59_37 = manager.ui.mainCamera.transform.position - var_59_30.position

				var_59_30.forward = Vector3.New(var_59_37.x, var_59_37.y, var_59_37.z)

				local var_59_38 = var_59_30.localEulerAngles

				var_59_38.z = 0
				var_59_38.x = 0
				var_59_30.localEulerAngles = var_59_38
			end

			local var_59_39 = 0

			if var_59_39 < arg_56_1.time_ and arg_56_1.time_ <= var_59_39 + arg_59_0 then
				arg_56_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_59_40 = 0

			if var_59_40 < arg_56_1.time_ and arg_56_1.time_ <= var_59_40 + arg_59_0 then
				arg_56_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_59_41 = 0
			local var_59_42 = 0.325

			if var_59_41 < arg_56_1.time_ and arg_56_1.time_ <= var_59_41 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_43 = arg_56_1:FormatText(StoryNameCfg[5].name)

				arg_56_1.leftNameTxt_.text = var_59_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_44 = arg_56_1:GetWordFromCfg(104091014)
				local var_59_45 = arg_56_1:FormatText(var_59_44.content)

				arg_56_1.text_.text = var_59_45

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_46 = 13
				local var_59_47 = utf8.len(var_59_45)
				local var_59_48 = var_59_46 <= 0 and var_59_42 or var_59_42 * (var_59_47 / var_59_46)

				if var_59_48 > 0 and var_59_42 < var_59_48 then
					arg_56_1.talkMaxDuration = var_59_48

					if var_59_48 + var_59_41 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_48 + var_59_41
					end
				end

				arg_56_1.text_.text = var_59_45
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104091", "104091014", "story_v_out_104091.awb") ~= 0 then
					local var_59_49 = manager.audio:GetVoiceLength("story_v_out_104091", "104091014", "story_v_out_104091.awb") / 1000

					if var_59_49 + var_59_41 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_49 + var_59_41
					end

					if var_59_44.prefab_name ~= "" and arg_56_1.actors_[var_59_44.prefab_name] ~= nil then
						local var_59_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_44.prefab_name].transform, "story_v_out_104091", "104091014", "story_v_out_104091.awb")

						arg_56_1:RecordAudio("104091014", var_59_50)
						arg_56_1:RecordAudio("104091014", var_59_50)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_104091", "104091014", "story_v_out_104091.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_104091", "104091014", "story_v_out_104091.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_51 = math.max(var_59_42, arg_56_1.talkMaxDuration)

			if var_59_41 <= arg_56_1.time_ and arg_56_1.time_ < var_59_41 + var_59_51 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_41) / var_59_51

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_41 + var_59_51 and arg_56_1.time_ < var_59_41 + var_59_51 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play104091015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 104091015
		arg_60_1.duration_ = 10.17

		local var_60_0 = {
			ja = 10.166,
			ko = 5.433,
			zh = 6.7,
			en = 6.766
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play104091016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1019ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1019ui_story == nil then
				arg_60_1.var_.characterEffect1019ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.1

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1019ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1019ui_story then
				arg_60_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["1036ui_story"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1036ui_story == nil then
				arg_60_1.var_.characterEffect1036ui_story = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.1

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect1036ui_story and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1036ui_story.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1036ui_story then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1036ui_story.fillRatio = var_63_9
			end

			local var_63_10 = arg_60_1.actors_["1019ui_story"].transform
			local var_63_11 = 0

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1.var_.moveOldPos1019ui_story = var_63_10.localPosition
			end

			local var_63_12 = 0.001

			if var_63_11 <= arg_60_1.time_ and arg_60_1.time_ < var_63_11 + var_63_12 then
				local var_63_13 = (arg_60_1.time_ - var_63_11) / var_63_12
				local var_63_14 = Vector3.New(0.7, -1.08, -5.9)

				var_63_10.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1019ui_story, var_63_14, var_63_13)

				local var_63_15 = manager.ui.mainCamera.transform.position - var_63_10.position

				var_63_10.forward = Vector3.New(var_63_15.x, var_63_15.y, var_63_15.z)

				local var_63_16 = var_63_10.localEulerAngles

				var_63_16.z = 0
				var_63_16.x = 0
				var_63_10.localEulerAngles = var_63_16
			end

			if arg_60_1.time_ >= var_63_11 + var_63_12 and arg_60_1.time_ < var_63_11 + var_63_12 + arg_63_0 then
				var_63_10.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_63_17 = manager.ui.mainCamera.transform.position - var_63_10.position

				var_63_10.forward = Vector3.New(var_63_17.x, var_63_17.y, var_63_17.z)

				local var_63_18 = var_63_10.localEulerAngles

				var_63_18.z = 0
				var_63_18.x = 0
				var_63_10.localEulerAngles = var_63_18
			end

			local var_63_19 = 0

			if var_63_19 < arg_60_1.time_ and arg_60_1.time_ <= var_63_19 + arg_63_0 then
				arg_60_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_63_20 = 0

			if var_63_20 < arg_60_1.time_ and arg_60_1.time_ <= var_63_20 + arg_63_0 then
				arg_60_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_63_21 = 0
			local var_63_22 = 0.95

			if var_63_21 < arg_60_1.time_ and arg_60_1.time_ <= var_63_21 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_23 = arg_60_1:FormatText(StoryNameCfg[13].name)

				arg_60_1.leftNameTxt_.text = var_63_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_24 = arg_60_1:GetWordFromCfg(104091015)
				local var_63_25 = arg_60_1:FormatText(var_63_24.content)

				arg_60_1.text_.text = var_63_25

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_26 = 36
				local var_63_27 = utf8.len(var_63_25)
				local var_63_28 = var_63_26 <= 0 and var_63_22 or var_63_22 * (var_63_27 / var_63_26)

				if var_63_28 > 0 and var_63_22 < var_63_28 then
					arg_60_1.talkMaxDuration = var_63_28

					if var_63_28 + var_63_21 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_28 + var_63_21
					end
				end

				arg_60_1.text_.text = var_63_25
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104091", "104091015", "story_v_out_104091.awb") ~= 0 then
					local var_63_29 = manager.audio:GetVoiceLength("story_v_out_104091", "104091015", "story_v_out_104091.awb") / 1000

					if var_63_29 + var_63_21 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_29 + var_63_21
					end

					if var_63_24.prefab_name ~= "" and arg_60_1.actors_[var_63_24.prefab_name] ~= nil then
						local var_63_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_24.prefab_name].transform, "story_v_out_104091", "104091015", "story_v_out_104091.awb")

						arg_60_1:RecordAudio("104091015", var_63_30)
						arg_60_1:RecordAudio("104091015", var_63_30)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_104091", "104091015", "story_v_out_104091.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_104091", "104091015", "story_v_out_104091.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_31 = math.max(var_63_22, arg_60_1.talkMaxDuration)

			if var_63_21 <= arg_60_1.time_ and arg_60_1.time_ < var_63_21 + var_63_31 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_21) / var_63_31

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_21 + var_63_31 and arg_60_1.time_ < var_63_21 + var_63_31 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play104091016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 104091016
		arg_64_1.duration_ = 6.27

		local var_64_0 = {
			ja = 5.3,
			ko = 4.7,
			zh = 5.5,
			en = 6.266
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play104091017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1011ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1011ui_story == nil then
				arg_64_1.var_.characterEffect1011ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1011ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1011ui_story then
				arg_64_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["1019ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1019ui_story == nil then
				arg_64_1.var_.characterEffect1019ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.1

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect1019ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1019ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1019ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1019ui_story.fillRatio = var_67_9
			end

			local var_67_10 = arg_64_1.actors_["1036ui_story"].transform
			local var_67_11 = 0

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.var_.moveOldPos1036ui_story = var_67_10.localPosition
			end

			local var_67_12 = 0.001

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_12 then
				local var_67_13 = (arg_64_1.time_ - var_67_11) / var_67_12
				local var_67_14 = Vector3.New(0, 100, 0)

				var_67_10.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1036ui_story, var_67_14, var_67_13)

				local var_67_15 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_15.x, var_67_15.y, var_67_15.z)

				local var_67_16 = var_67_10.localEulerAngles

				var_67_16.z = 0
				var_67_16.x = 0
				var_67_10.localEulerAngles = var_67_16
			end

			if arg_64_1.time_ >= var_67_11 + var_67_12 and arg_64_1.time_ < var_67_11 + var_67_12 + arg_67_0 then
				var_67_10.localPosition = Vector3.New(0, 100, 0)

				local var_67_17 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_17.x, var_67_17.y, var_67_17.z)

				local var_67_18 = var_67_10.localEulerAngles

				var_67_18.z = 0
				var_67_18.x = 0
				var_67_10.localEulerAngles = var_67_18
			end

			local var_67_19 = arg_64_1.actors_["1011ui_story"].transform
			local var_67_20 = 0

			if var_67_20 < arg_64_1.time_ and arg_64_1.time_ <= var_67_20 + arg_67_0 then
				arg_64_1.var_.moveOldPos1011ui_story = var_67_19.localPosition
			end

			local var_67_21 = 0.001

			if var_67_20 <= arg_64_1.time_ and arg_64_1.time_ < var_67_20 + var_67_21 then
				local var_67_22 = (arg_64_1.time_ - var_67_20) / var_67_21
				local var_67_23 = Vector3.New(-0.7, -0.71, -6)

				var_67_19.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1011ui_story, var_67_23, var_67_22)

				local var_67_24 = manager.ui.mainCamera.transform.position - var_67_19.position

				var_67_19.forward = Vector3.New(var_67_24.x, var_67_24.y, var_67_24.z)

				local var_67_25 = var_67_19.localEulerAngles

				var_67_25.z = 0
				var_67_25.x = 0
				var_67_19.localEulerAngles = var_67_25
			end

			if arg_64_1.time_ >= var_67_20 + var_67_21 and arg_64_1.time_ < var_67_20 + var_67_21 + arg_67_0 then
				var_67_19.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_67_26 = manager.ui.mainCamera.transform.position - var_67_19.position

				var_67_19.forward = Vector3.New(var_67_26.x, var_67_26.y, var_67_26.z)

				local var_67_27 = var_67_19.localEulerAngles

				var_67_27.z = 0
				var_67_27.x = 0
				var_67_19.localEulerAngles = var_67_27
			end

			local var_67_28 = 0

			if var_67_28 < arg_64_1.time_ and arg_64_1.time_ <= var_67_28 + arg_67_0 then
				arg_64_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			local var_67_29 = 0

			if var_67_29 < arg_64_1.time_ and arg_64_1.time_ <= var_67_29 + arg_67_0 then
				arg_64_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_67_30 = 0
			local var_67_31 = 0.6

			if var_67_30 < arg_64_1.time_ and arg_64_1.time_ <= var_67_30 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_32 = arg_64_1:FormatText(StoryNameCfg[37].name)

				arg_64_1.leftNameTxt_.text = var_67_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_33 = arg_64_1:GetWordFromCfg(104091016)
				local var_67_34 = arg_64_1:FormatText(var_67_33.content)

				arg_64_1.text_.text = var_67_34

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_35 = 24
				local var_67_36 = utf8.len(var_67_34)
				local var_67_37 = var_67_35 <= 0 and var_67_31 or var_67_31 * (var_67_36 / var_67_35)

				if var_67_37 > 0 and var_67_31 < var_67_37 then
					arg_64_1.talkMaxDuration = var_67_37

					if var_67_37 + var_67_30 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_37 + var_67_30
					end
				end

				arg_64_1.text_.text = var_67_34
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104091", "104091016", "story_v_out_104091.awb") ~= 0 then
					local var_67_38 = manager.audio:GetVoiceLength("story_v_out_104091", "104091016", "story_v_out_104091.awb") / 1000

					if var_67_38 + var_67_30 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_38 + var_67_30
					end

					if var_67_33.prefab_name ~= "" and arg_64_1.actors_[var_67_33.prefab_name] ~= nil then
						local var_67_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_33.prefab_name].transform, "story_v_out_104091", "104091016", "story_v_out_104091.awb")

						arg_64_1:RecordAudio("104091016", var_67_39)
						arg_64_1:RecordAudio("104091016", var_67_39)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_104091", "104091016", "story_v_out_104091.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_104091", "104091016", "story_v_out_104091.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_40 = math.max(var_67_31, arg_64_1.talkMaxDuration)

			if var_67_30 <= arg_64_1.time_ and arg_64_1.time_ < var_67_30 + var_67_40 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_30) / var_67_40

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_30 + var_67_40 and arg_64_1.time_ < var_67_30 + var_67_40 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play104091017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 104091017
		arg_68_1.duration_ = 5.8

		local var_68_0 = {
			ja = 5.6,
			ko = 3.4,
			zh = 4.5,
			en = 5.8
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play104091018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10001_tpose"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10001_tpose == nil then
				arg_68_1.var_.characterEffect10001_tpose = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.1

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect10001_tpose and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10001_tpose then
				arg_68_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_71_4 = arg_68_1.actors_["1011ui_story"]
			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect1011ui_story == nil then
				arg_68_1.var_.characterEffect1011ui_story = var_71_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_6 = 0.1

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 and not isNil(var_71_4) then
				local var_71_7 = (arg_68_1.time_ - var_71_5) / var_71_6

				if arg_68_1.var_.characterEffect1011ui_story and not isNil(var_71_4) then
					local var_71_8 = Mathf.Lerp(0, 0.5, var_71_7)

					arg_68_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1011ui_story.fillRatio = var_71_8
				end
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect1011ui_story then
				local var_71_9 = 0.5

				arg_68_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1011ui_story.fillRatio = var_71_9
			end

			local var_71_10 = arg_68_1.actors_["1011ui_story"].transform
			local var_71_11 = 0

			if var_71_11 < arg_68_1.time_ and arg_68_1.time_ <= var_71_11 + arg_71_0 then
				arg_68_1.var_.moveOldPos1011ui_story = var_71_10.localPosition
			end

			local var_71_12 = 0.001

			if var_71_11 <= arg_68_1.time_ and arg_68_1.time_ < var_71_11 + var_71_12 then
				local var_71_13 = (arg_68_1.time_ - var_71_11) / var_71_12
				local var_71_14 = Vector3.New(0, 100, 0)

				var_71_10.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1011ui_story, var_71_14, var_71_13)

				local var_71_15 = manager.ui.mainCamera.transform.position - var_71_10.position

				var_71_10.forward = Vector3.New(var_71_15.x, var_71_15.y, var_71_15.z)

				local var_71_16 = var_71_10.localEulerAngles

				var_71_16.z = 0
				var_71_16.x = 0
				var_71_10.localEulerAngles = var_71_16
			end

			if arg_68_1.time_ >= var_71_11 + var_71_12 and arg_68_1.time_ < var_71_11 + var_71_12 + arg_71_0 then
				var_71_10.localPosition = Vector3.New(0, 100, 0)

				local var_71_17 = manager.ui.mainCamera.transform.position - var_71_10.position

				var_71_10.forward = Vector3.New(var_71_17.x, var_71_17.y, var_71_17.z)

				local var_71_18 = var_71_10.localEulerAngles

				var_71_18.z = 0
				var_71_18.x = 0
				var_71_10.localEulerAngles = var_71_18
			end

			local var_71_19 = arg_68_1.actors_["1019ui_story"].transform
			local var_71_20 = 0

			if var_71_20 < arg_68_1.time_ and arg_68_1.time_ <= var_71_20 + arg_71_0 then
				arg_68_1.var_.moveOldPos1019ui_story = var_71_19.localPosition
			end

			local var_71_21 = 0.001

			if var_71_20 <= arg_68_1.time_ and arg_68_1.time_ < var_71_20 + var_71_21 then
				local var_71_22 = (arg_68_1.time_ - var_71_20) / var_71_21
				local var_71_23 = Vector3.New(0, 100, 0)

				var_71_19.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1019ui_story, var_71_23, var_71_22)

				local var_71_24 = manager.ui.mainCamera.transform.position - var_71_19.position

				var_71_19.forward = Vector3.New(var_71_24.x, var_71_24.y, var_71_24.z)

				local var_71_25 = var_71_19.localEulerAngles

				var_71_25.z = 0
				var_71_25.x = 0
				var_71_19.localEulerAngles = var_71_25
			end

			if arg_68_1.time_ >= var_71_20 + var_71_21 and arg_68_1.time_ < var_71_20 + var_71_21 + arg_71_0 then
				var_71_19.localPosition = Vector3.New(0, 100, 0)

				local var_71_26 = manager.ui.mainCamera.transform.position - var_71_19.position

				var_71_19.forward = Vector3.New(var_71_26.x, var_71_26.y, var_71_26.z)

				local var_71_27 = var_71_19.localEulerAngles

				var_71_27.z = 0
				var_71_27.x = 0
				var_71_19.localEulerAngles = var_71_27
			end

			local var_71_28 = arg_68_1.actors_["10001_tpose"].transform
			local var_71_29 = 0

			if var_71_29 < arg_68_1.time_ and arg_68_1.time_ <= var_71_29 + arg_71_0 then
				arg_68_1.var_.moveOldPos10001_tpose = var_71_28.localPosition

				local var_71_30 = GameObjectTools.GetOrAddComponent(var_71_28.gameObject, typeof(DynamicBoneHelper))

				if var_71_30 then
					var_71_30:EnableDynamicBone(false)
				end
			end

			local var_71_31 = 0.001

			if var_71_29 <= arg_68_1.time_ and arg_68_1.time_ < var_71_29 + var_71_31 then
				local var_71_32 = (arg_68_1.time_ - var_71_29) / var_71_31
				local var_71_33 = Vector3.New(0, -1.23, -5.8)

				var_71_28.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10001_tpose, var_71_33, var_71_32)

				local var_71_34 = manager.ui.mainCamera.transform.position - var_71_28.position

				var_71_28.forward = Vector3.New(var_71_34.x, var_71_34.y, var_71_34.z)

				local var_71_35 = var_71_28.localEulerAngles

				var_71_35.z = 0
				var_71_35.x = 0
				var_71_28.localEulerAngles = var_71_35
			end

			if arg_68_1.time_ >= var_71_29 + var_71_31 and arg_68_1.time_ < var_71_29 + var_71_31 + arg_71_0 then
				var_71_28.localPosition = Vector3.New(0, -1.23, -5.8)

				local var_71_36 = manager.ui.mainCamera.transform.position - var_71_28.position

				var_71_28.forward = Vector3.New(var_71_36.x, var_71_36.y, var_71_36.z)

				local var_71_37 = var_71_28.localEulerAngles

				var_71_37.z = 0
				var_71_37.x = 0
				var_71_28.localEulerAngles = var_71_37

				local var_71_38 = GameObjectTools.GetOrAddComponent(var_71_28.gameObject, typeof(DynamicBoneHelper))

				if var_71_38 then
					var_71_38:EnableDynamicBone(true)
				end
			end

			local var_71_39 = 0

			if var_71_39 < arg_68_1.time_ and arg_68_1.time_ <= var_71_39 + arg_71_0 then
				arg_68_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action5_1")
			end

			local var_71_40 = 0

			if var_71_40 < arg_68_1.time_ and arg_68_1.time_ <= var_71_40 + arg_71_0 then
				arg_68_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_71_41 = 0
			local var_71_42 = 0.35

			if var_71_41 < arg_68_1.time_ and arg_68_1.time_ <= var_71_41 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_43 = arg_68_1:FormatText(StoryNameCfg[31].name)

				arg_68_1.leftNameTxt_.text = var_71_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_44 = arg_68_1:GetWordFromCfg(104091017)
				local var_71_45 = arg_68_1:FormatText(var_71_44.content)

				arg_68_1.text_.text = var_71_45

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_46 = 14
				local var_71_47 = utf8.len(var_71_45)
				local var_71_48 = var_71_46 <= 0 and var_71_42 or var_71_42 * (var_71_47 / var_71_46)

				if var_71_48 > 0 and var_71_42 < var_71_48 then
					arg_68_1.talkMaxDuration = var_71_48

					if var_71_48 + var_71_41 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_48 + var_71_41
					end
				end

				arg_68_1.text_.text = var_71_45
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104091", "104091017", "story_v_out_104091.awb") ~= 0 then
					local var_71_49 = manager.audio:GetVoiceLength("story_v_out_104091", "104091017", "story_v_out_104091.awb") / 1000

					if var_71_49 + var_71_41 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_49 + var_71_41
					end

					if var_71_44.prefab_name ~= "" and arg_68_1.actors_[var_71_44.prefab_name] ~= nil then
						local var_71_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_44.prefab_name].transform, "story_v_out_104091", "104091017", "story_v_out_104091.awb")

						arg_68_1:RecordAudio("104091017", var_71_50)
						arg_68_1:RecordAudio("104091017", var_71_50)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_104091", "104091017", "story_v_out_104091.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_104091", "104091017", "story_v_out_104091.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_51 = math.max(var_71_42, arg_68_1.talkMaxDuration)

			if var_71_41 <= arg_68_1.time_ and arg_68_1.time_ < var_71_41 + var_71_51 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_41) / var_71_51

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_41 + var_71_51 and arg_68_1.time_ < var_71_41 + var_71_51 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play104091018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 104091018
		arg_72_1.duration_ = 4.53

		local var_72_0 = {
			ja = 4.533,
			ko = 3.066,
			zh = 4.5,
			en = 2.5
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play104091019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["10001_tpose"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect10001_tpose == nil then
				arg_72_1.var_.characterEffect10001_tpose = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect10001_tpose and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_72_1.var_.characterEffect10001_tpose.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect10001_tpose then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_72_1.var_.characterEffect10001_tpose.fillRatio = var_75_5
			end

			local var_75_6 = arg_72_1.actors_["10001_tpose"].transform
			local var_75_7 = 0

			if var_75_7 < arg_72_1.time_ and arg_72_1.time_ <= var_75_7 + arg_75_0 then
				arg_72_1.var_.moveOldPos10001_tpose = var_75_6.localPosition

				local var_75_8 = GameObjectTools.GetOrAddComponent(var_75_6.gameObject, typeof(DynamicBoneHelper))

				if var_75_8 then
					var_75_8:EnableDynamicBone(false)
				end
			end

			local var_75_9 = 0.001

			if var_75_7 <= arg_72_1.time_ and arg_72_1.time_ < var_75_7 + var_75_9 then
				local var_75_10 = (arg_72_1.time_ - var_75_7) / var_75_9
				local var_75_11 = Vector3.New(0, 100, 0)

				var_75_6.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10001_tpose, var_75_11, var_75_10)

				local var_75_12 = manager.ui.mainCamera.transform.position - var_75_6.position

				var_75_6.forward = Vector3.New(var_75_12.x, var_75_12.y, var_75_12.z)

				local var_75_13 = var_75_6.localEulerAngles

				var_75_13.z = 0
				var_75_13.x = 0
				var_75_6.localEulerAngles = var_75_13
			end

			if arg_72_1.time_ >= var_75_7 + var_75_9 and arg_72_1.time_ < var_75_7 + var_75_9 + arg_75_0 then
				var_75_6.localPosition = Vector3.New(0, 100, 0)

				local var_75_14 = manager.ui.mainCamera.transform.position - var_75_6.position

				var_75_6.forward = Vector3.New(var_75_14.x, var_75_14.y, var_75_14.z)

				local var_75_15 = var_75_6.localEulerAngles

				var_75_15.z = 0
				var_75_15.x = 0
				var_75_6.localEulerAngles = var_75_15

				local var_75_16 = GameObjectTools.GetOrAddComponent(var_75_6.gameObject, typeof(DynamicBoneHelper))

				if var_75_16 then
					var_75_16:EnableDynamicBone(true)
				end
			end

			local var_75_17 = 0
			local var_75_18 = 0.325

			if var_75_17 < arg_72_1.time_ and arg_72_1.time_ <= var_75_17 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_19 = arg_72_1:FormatText(StoryNameCfg[62].name)

				arg_72_1.leftNameTxt_.text = var_75_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_20 = arg_72_1:GetWordFromCfg(104091018)
				local var_75_21 = arg_72_1:FormatText(var_75_20.content)

				arg_72_1.text_.text = var_75_21

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_22 = 12
				local var_75_23 = utf8.len(var_75_21)
				local var_75_24 = var_75_22 <= 0 and var_75_18 or var_75_18 * (var_75_23 / var_75_22)

				if var_75_24 > 0 and var_75_18 < var_75_24 then
					arg_72_1.talkMaxDuration = var_75_24

					if var_75_24 + var_75_17 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_24 + var_75_17
					end
				end

				arg_72_1.text_.text = var_75_21
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104091", "104091018", "story_v_out_104091.awb") ~= 0 then
					local var_75_25 = manager.audio:GetVoiceLength("story_v_out_104091", "104091018", "story_v_out_104091.awb") / 1000

					if var_75_25 + var_75_17 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_25 + var_75_17
					end

					if var_75_20.prefab_name ~= "" and arg_72_1.actors_[var_75_20.prefab_name] ~= nil then
						local var_75_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_20.prefab_name].transform, "story_v_out_104091", "104091018", "story_v_out_104091.awb")

						arg_72_1:RecordAudio("104091018", var_75_26)
						arg_72_1:RecordAudio("104091018", var_75_26)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_104091", "104091018", "story_v_out_104091.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_104091", "104091018", "story_v_out_104091.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_27 = math.max(var_75_18, arg_72_1.talkMaxDuration)

			if var_75_17 <= arg_72_1.time_ and arg_72_1.time_ < var_75_17 + var_75_27 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_17) / var_75_27

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_17 + var_75_27 and arg_72_1.time_ < var_75_17 + var_75_27 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play104091019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 104091019
		arg_76_1.duration_ = 2

		local var_76_0 = {
			ja = 2,
			ko = 1.1,
			zh = 1.3,
			en = 0.733
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
			arg_76_1.auto_ = false
		end

		function arg_76_1.playNext_(arg_78_0)
			arg_76_1.onStoryFinished_()
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1019ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1019ui_story == nil then
				arg_76_1.var_.characterEffect1019ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1019ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1019ui_story then
				arg_76_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_79_4 = arg_76_1.actors_["1011ui_story"]
			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1011ui_story == nil then
				arg_76_1.var_.characterEffect1011ui_story = var_79_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_6 = 0.1

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_6 and not isNil(var_79_4) then
				local var_79_7 = (arg_76_1.time_ - var_79_5) / var_79_6

				if arg_76_1.var_.characterEffect1011ui_story and not isNil(var_79_4) then
					local var_79_8 = Mathf.Lerp(0, 0.5, var_79_7)

					arg_76_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1011ui_story.fillRatio = var_79_8
				end
			end

			if arg_76_1.time_ >= var_79_5 + var_79_6 and arg_76_1.time_ < var_79_5 + var_79_6 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1011ui_story then
				local var_79_9 = 0.5

				arg_76_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1011ui_story.fillRatio = var_79_9
			end

			local var_79_10 = 0
			local var_79_11 = 0.125

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_12 = arg_76_1:FormatText(StoryNameCfg[13].name)

				arg_76_1.leftNameTxt_.text = var_79_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_13 = arg_76_1:GetWordFromCfg(104091019)
				local var_79_14 = arg_76_1:FormatText(var_79_13.content)

				arg_76_1.text_.text = var_79_14

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_15 = 5
				local var_79_16 = utf8.len(var_79_14)
				local var_79_17 = var_79_15 <= 0 and var_79_11 or var_79_11 * (var_79_16 / var_79_15)

				if var_79_17 > 0 and var_79_11 < var_79_17 then
					arg_76_1.talkMaxDuration = var_79_17

					if var_79_17 + var_79_10 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_17 + var_79_10
					end
				end

				arg_76_1.text_.text = var_79_14
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104091", "104091019", "story_v_out_104091.awb") ~= 0 then
					local var_79_18 = manager.audio:GetVoiceLength("story_v_out_104091", "104091019", "story_v_out_104091.awb") / 1000

					if var_79_18 + var_79_10 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_18 + var_79_10
					end

					if var_79_13.prefab_name ~= "" and arg_76_1.actors_[var_79_13.prefab_name] ~= nil then
						local var_79_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_13.prefab_name].transform, "story_v_out_104091", "104091019", "story_v_out_104091.awb")

						arg_76_1:RecordAudio("104091019", var_79_19)
						arg_76_1:RecordAudio("104091019", var_79_19)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_104091", "104091019", "story_v_out_104091.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_104091", "104091019", "story_v_out_104091.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_20 = math.max(var_79_11, arg_76_1.talkMaxDuration)

			if var_79_10 <= arg_76_1.time_ and arg_76_1.time_ < var_79_10 + var_79_20 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_10) / var_79_20

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_10 + var_79_20 and arg_76_1.time_ < var_79_10 + var_79_20 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B04c"
	},
	voices = {
		"story_v_out_104091.awb"
	}
}
