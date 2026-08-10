return {
	Play101111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 101111001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play101111002(arg_1_1)
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

			local var_4_6 = "B02d"

			if arg_1_1.bgs_[var_4_6] == nil then
				local var_4_7 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_6)
				var_4_7.name = var_4_6
				var_4_7.transform.parent = arg_1_1.stage_.transform
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_6] = var_4_7
			end

			local var_4_8 = arg_1_1.bgs_.B02d
			local var_4_9 = 0

			if var_4_9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				local var_4_10 = var_4_8:GetComponent("SpriteRenderer")

				if var_4_10 then
					arg_1_1.var_.alphaOldValueB02d = var_4_10.color.a
					arg_1_1.var_.alphaMatValueB02d = var_4_10
				end

				arg_1_1.var_.alphaOldValueB02d = 0
			end

			local var_4_11 = 1.5

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_11 then
				local var_4_12 = (arg_1_1.time_ - var_4_9) / var_4_11
				local var_4_13 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB02d, 1, var_4_12)

				if arg_1_1.var_.alphaMatValueB02d then
					local var_4_14 = arg_1_1.var_.alphaMatValueB02d.color

					var_4_14.a = var_4_13
					arg_1_1.var_.alphaMatValueB02d.color = var_4_14
				end
			end

			if arg_1_1.time_ >= var_4_9 + var_4_11 and arg_1_1.time_ < var_4_9 + var_4_11 + arg_4_0 and arg_1_1.var_.alphaMatValueB02d then
				local var_4_15 = arg_1_1.var_.alphaMatValueB02d
				local var_4_16 = var_4_15.color

				var_4_16.a = 1
				var_4_15.color = var_4_16
			end

			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = manager.ui.mainCamera.transform.localPosition
				local var_4_19 = Vector3.New(0, 0, 10) + Vector3.New(var_4_18.x, var_4_18.y, 0)
				local var_4_20 = arg_1_1.bgs_.B02d

				var_4_20.transform.localPosition = var_4_19
				var_4_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_21 = var_4_20:GetComponent("SpriteRenderer")

				if var_4_21 and var_4_21.sprite then
					local var_4_22 = (var_4_20.transform.localPosition - var_4_18).z
					local var_4_23 = manager.ui.mainCameraCom_
					local var_4_24 = 2 * var_4_22 * Mathf.Tan(var_4_23.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_25 = var_4_24 * var_4_23.aspect
					local var_4_26 = var_4_21.sprite.bounds.size.x
					local var_4_27 = var_4_21.sprite.bounds.size.y
					local var_4_28 = var_4_25 / var_4_26
					local var_4_29 = var_4_24 / var_4_27
					local var_4_30 = var_4_29 < var_4_28 and var_4_28 or var_4_29

					var_4_20.transform.localScale = Vector3.New(var_4_30, var_4_30, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B02d" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_31 = 0

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_32 = 2

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_33 = 2
			local var_4_34 = 0.5

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

				local var_4_36 = arg_1_1:GetWordFromCfg(101111001)
				local var_4_37 = arg_1_1:FormatText(var_4_36.content)

				arg_1_1.text_.text = var_4_37

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 20
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
	Play101111002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 101111002
		arg_8_1.duration_ = 5.43

		local var_8_0 = {
			ja = 5.433,
			ko = 3.566,
			zh = 4.366,
			en = 4.7
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
				arg_8_0:Play101111003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "effect"

				arg_8_1:AudioAction(var_11_2, var_11_3, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_11_4 = "1019ui_story"

			if arg_8_1.actors_[var_11_4] == nil then
				local var_11_5 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_11_5) then
					local var_11_6 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_8_1.stage_.transform)

					var_11_6.name = var_11_4
					var_11_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_4] = var_11_6

					local var_11_7 = var_11_6:GetComponentInChildren(typeof(CharacterEffect))

					var_11_7.enabled = true

					local var_11_8 = GameObjectTools.GetOrAddComponent(var_11_6, typeof(DynamicBoneHelper))

					if var_11_8 then
						var_11_8:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_7.transform, false)

					arg_8_1.var_[var_11_4 .. "Animator"] = var_11_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_4 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_4 .. "LipSync"] = var_11_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_9 = arg_8_1.actors_["1019ui_story"]
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.1

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 and not isNil(var_11_9) then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11

				if arg_8_1.var_.characterEffect1019ui_story and not isNil(var_11_9) then
					arg_8_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1019ui_story then
				arg_8_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_11_13 = arg_8_1.actors_["1019ui_story"].transform
			local var_11_14 = 0

			if var_11_14 < arg_8_1.time_ and arg_8_1.time_ <= var_11_14 + arg_11_0 then
				arg_8_1.var_.moveOldPos1019ui_story = var_11_13.localPosition
			end

			local var_11_15 = 0.001

			if var_11_14 <= arg_8_1.time_ and arg_8_1.time_ < var_11_14 + var_11_15 then
				local var_11_16 = (arg_8_1.time_ - var_11_14) / var_11_15
				local var_11_17 = Vector3.New(-0.7, -1.08, -5.9)

				var_11_13.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1019ui_story, var_11_17, var_11_16)

				local var_11_18 = manager.ui.mainCamera.transform.position - var_11_13.position

				var_11_13.forward = Vector3.New(var_11_18.x, var_11_18.y, var_11_18.z)

				local var_11_19 = var_11_13.localEulerAngles

				var_11_19.z = 0
				var_11_19.x = 0
				var_11_13.localEulerAngles = var_11_19
			end

			if arg_8_1.time_ >= var_11_14 + var_11_15 and arg_8_1.time_ < var_11_14 + var_11_15 + arg_11_0 then
				var_11_13.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_11_20 = manager.ui.mainCamera.transform.position - var_11_13.position

				var_11_13.forward = Vector3.New(var_11_20.x, var_11_20.y, var_11_20.z)

				local var_11_21 = var_11_13.localEulerAngles

				var_11_21.z = 0
				var_11_21.x = 0
				var_11_13.localEulerAngles = var_11_21
			end

			local var_11_22 = 0

			if var_11_22 < arg_8_1.time_ and arg_8_1.time_ <= var_11_22 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_11_23 = 0

			if var_11_23 < arg_8_1.time_ and arg_8_1.time_ <= var_11_23 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_11_24 = 0
			local var_11_25 = 0.575

			if var_11_24 < arg_8_1.time_ and arg_8_1.time_ <= var_11_24 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_26 = arg_8_1:FormatText(StoryNameCfg[13].name)

				arg_8_1.leftNameTxt_.text = var_11_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_27 = arg_8_1:GetWordFromCfg(101111002)
				local var_11_28 = arg_8_1:FormatText(var_11_27.content)

				arg_8_1.text_.text = var_11_28

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_29 = 23
				local var_11_30 = utf8.len(var_11_28)
				local var_11_31 = var_11_29 <= 0 and var_11_25 or var_11_25 * (var_11_30 / var_11_29)

				if var_11_31 > 0 and var_11_25 < var_11_31 then
					arg_8_1.talkMaxDuration = var_11_31

					if var_11_31 + var_11_24 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_31 + var_11_24
					end
				end

				arg_8_1.text_.text = var_11_28
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111002", "story_v_out_101111.awb") ~= 0 then
					local var_11_32 = manager.audio:GetVoiceLength("story_v_out_101111", "101111002", "story_v_out_101111.awb") / 1000

					if var_11_32 + var_11_24 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_32 + var_11_24
					end

					if var_11_27.prefab_name ~= "" and arg_8_1.actors_[var_11_27.prefab_name] ~= nil then
						local var_11_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_27.prefab_name].transform, "story_v_out_101111", "101111002", "story_v_out_101111.awb")

						arg_8_1:RecordAudio("101111002", var_11_33)
						arg_8_1:RecordAudio("101111002", var_11_33)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_101111", "101111002", "story_v_out_101111.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_101111", "101111002", "story_v_out_101111.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_34 = math.max(var_11_25, arg_8_1.talkMaxDuration)

			if var_11_24 <= arg_8_1.time_ and arg_8_1.time_ < var_11_24 + var_11_34 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_24) / var_11_34

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_24 + var_11_34 and arg_8_1.time_ < var_11_24 + var_11_34 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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

		arg_8_1:InitPlayNodeList()
	end,
	Play101111003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 101111003
		arg_12_1.duration_ = 7.3

		local var_12_0 = {
			ja = 5.133,
			ko = 4.633,
			zh = 5.966,
			en = 7.3
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
				arg_12_0:Play101111004(arg_12_1)
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

			local var_15_9 = arg_12_1.actors_["1019ui_story"]
			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect1019ui_story == nil then
				arg_12_1.var_.characterEffect1019ui_story = var_15_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_11 = 0.1

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_11 and not isNil(var_15_9) then
				local var_15_12 = (arg_12_1.time_ - var_15_10) / var_15_11

				if arg_12_1.var_.characterEffect1019ui_story and not isNil(var_15_9) then
					local var_15_13 = Mathf.Lerp(0, 0.5, var_15_12)

					arg_12_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1019ui_story.fillRatio = var_15_13
				end
			end

			if arg_12_1.time_ >= var_15_10 + var_15_11 and arg_12_1.time_ < var_15_10 + var_15_11 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect1019ui_story then
				local var_15_14 = 0.5

				arg_12_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1019ui_story.fillRatio = var_15_14
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
				arg_12_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_15_26 = 0
			local var_15_27 = 0.625

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

				local var_15_29 = arg_12_1:GetWordFromCfg(101111003)
				local var_15_30 = arg_12_1:FormatText(var_15_29.content)

				arg_12_1.text_.text = var_15_30

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_31 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111003", "story_v_out_101111.awb") ~= 0 then
					local var_15_34 = manager.audio:GetVoiceLength("story_v_out_101111", "101111003", "story_v_out_101111.awb") / 1000

					if var_15_34 + var_15_26 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_34 + var_15_26
					end

					if var_15_29.prefab_name ~= "" and arg_12_1.actors_[var_15_29.prefab_name] ~= nil then
						local var_15_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_29.prefab_name].transform, "story_v_out_101111", "101111003", "story_v_out_101111.awb")

						arg_12_1:RecordAudio("101111003", var_15_35)
						arg_12_1:RecordAudio("101111003", var_15_35)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_101111", "101111003", "story_v_out_101111.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_101111", "101111003", "story_v_out_101111.awb")
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
	Play101111004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 101111004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play101111005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1011ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1011ui_story == nil then
				arg_16_1.var_.characterEffect1011ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.1

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1011ui_story and not isNil(var_19_0) then
					local var_19_4 = Mathf.Lerp(0, 0.5, var_19_3)

					arg_16_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1011ui_story.fillRatio = var_19_4
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1011ui_story then
				local var_19_5 = 0.5

				arg_16_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1011ui_story.fillRatio = var_19_5
			end

			local var_19_6 = arg_16_1.actors_["1011ui_story"].transform
			local var_19_7 = 0

			if var_19_7 < arg_16_1.time_ and arg_16_1.time_ <= var_19_7 + arg_19_0 then
				arg_16_1.var_.moveOldPos1011ui_story = var_19_6.localPosition
			end

			local var_19_8 = 0.001

			if var_19_7 <= arg_16_1.time_ and arg_16_1.time_ < var_19_7 + var_19_8 then
				local var_19_9 = (arg_16_1.time_ - var_19_7) / var_19_8
				local var_19_10 = Vector3.New(0, 100, 0)

				var_19_6.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1011ui_story, var_19_10, var_19_9)

				local var_19_11 = manager.ui.mainCamera.transform.position - var_19_6.position

				var_19_6.forward = Vector3.New(var_19_11.x, var_19_11.y, var_19_11.z)

				local var_19_12 = var_19_6.localEulerAngles

				var_19_12.z = 0
				var_19_12.x = 0
				var_19_6.localEulerAngles = var_19_12
			end

			if arg_16_1.time_ >= var_19_7 + var_19_8 and arg_16_1.time_ < var_19_7 + var_19_8 + arg_19_0 then
				var_19_6.localPosition = Vector3.New(0, 100, 0)

				local var_19_13 = manager.ui.mainCamera.transform.position - var_19_6.position

				var_19_6.forward = Vector3.New(var_19_13.x, var_19_13.y, var_19_13.z)

				local var_19_14 = var_19_6.localEulerAngles

				var_19_14.z = 0
				var_19_14.x = 0
				var_19_6.localEulerAngles = var_19_14
			end

			local var_19_15 = arg_16_1.actors_["1019ui_story"].transform
			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1.var_.moveOldPos1019ui_story = var_19_15.localPosition
			end

			local var_19_17 = 0.001

			if var_19_16 <= arg_16_1.time_ and arg_16_1.time_ < var_19_16 + var_19_17 then
				local var_19_18 = (arg_16_1.time_ - var_19_16) / var_19_17
				local var_19_19 = Vector3.New(0, 100, 0)

				var_19_15.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1019ui_story, var_19_19, var_19_18)

				local var_19_20 = manager.ui.mainCamera.transform.position - var_19_15.position

				var_19_15.forward = Vector3.New(var_19_20.x, var_19_20.y, var_19_20.z)

				local var_19_21 = var_19_15.localEulerAngles

				var_19_21.z = 0
				var_19_21.x = 0
				var_19_15.localEulerAngles = var_19_21
			end

			if arg_16_1.time_ >= var_19_16 + var_19_17 and arg_16_1.time_ < var_19_16 + var_19_17 + arg_19_0 then
				var_19_15.localPosition = Vector3.New(0, 100, 0)

				local var_19_22 = manager.ui.mainCamera.transform.position - var_19_15.position

				var_19_15.forward = Vector3.New(var_19_22.x, var_19_22.y, var_19_22.z)

				local var_19_23 = var_19_15.localEulerAngles

				var_19_23.z = 0
				var_19_23.x = 0
				var_19_15.localEulerAngles = var_19_23
			end

			local var_19_24 = 0
			local var_19_25 = 1.25

			if var_19_24 < arg_16_1.time_ and arg_16_1.time_ <= var_19_24 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_26 = arg_16_1:GetWordFromCfg(101111004)
				local var_19_27 = arg_16_1:FormatText(var_19_26.content)

				arg_16_1.text_.text = var_19_27

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_28 = 50
				local var_19_29 = utf8.len(var_19_27)
				local var_19_30 = var_19_28 <= 0 and var_19_25 or var_19_25 * (var_19_29 / var_19_28)

				if var_19_30 > 0 and var_19_25 < var_19_30 then
					arg_16_1.talkMaxDuration = var_19_30

					if var_19_30 + var_19_24 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_30 + var_19_24
					end
				end

				arg_16_1.text_.text = var_19_27
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_31 = math.max(var_19_25, arg_16_1.talkMaxDuration)

			if var_19_24 <= arg_16_1.time_ and arg_16_1.time_ < var_19_24 + var_19_31 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_24) / var_19_31

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_24 + var_19_31 and arg_16_1.time_ < var_19_24 + var_19_31 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play101111005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 101111005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play101111006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.25

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_2

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

				local var_23_3 = arg_20_1:GetWordFromCfg(101111005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 10
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_8 and arg_20_1.time_ < var_23_0 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play101111006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 101111006
		arg_24_1.duration_ = 6

		local var_24_0 = {
			ja = 4.7,
			ko = 6,
			zh = 4.7,
			en = 4.966
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
				arg_24_0:Play101111007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1019ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1019ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1019ui_story then
				arg_24_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_27_4 = 0

			if var_27_4 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_27_5 = arg_24_1.actors_["1019ui_story"].transform
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.var_.moveOldPos1019ui_story = var_27_5.localPosition
			end

			local var_27_7 = 0.001

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_7 then
				local var_27_8 = (arg_24_1.time_ - var_27_6) / var_27_7
				local var_27_9 = Vector3.New(-0.2, -1.08, -5.9)

				var_27_5.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1019ui_story, var_27_9, var_27_8)

				local var_27_10 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_10.x, var_27_10.y, var_27_10.z)

				local var_27_11 = var_27_5.localEulerAngles

				var_27_11.z = 0
				var_27_11.x = 0
				var_27_5.localEulerAngles = var_27_11
			end

			if arg_24_1.time_ >= var_27_6 + var_27_7 and arg_24_1.time_ < var_27_6 + var_27_7 + arg_27_0 then
				var_27_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_27_12 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_12.x, var_27_12.y, var_27_12.z)

				local var_27_13 = var_27_5.localEulerAngles

				var_27_13.z = 0
				var_27_13.x = 0
				var_27_5.localEulerAngles = var_27_13
			end

			local var_27_14 = 0

			if var_27_14 < arg_24_1.time_ and arg_24_1.time_ <= var_27_14 + arg_27_0 then
				arg_24_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_27_15 = 0
			local var_27_16 = 0.525

			if var_27_15 < arg_24_1.time_ and arg_24_1.time_ <= var_27_15 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_17 = arg_24_1:FormatText(StoryNameCfg[13].name)

				arg_24_1.leftNameTxt_.text = var_27_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_18 = arg_24_1:GetWordFromCfg(101111006)
				local var_27_19 = arg_24_1:FormatText(var_27_18.content)

				arg_24_1.text_.text = var_27_19

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_20 = 21
				local var_27_21 = utf8.len(var_27_19)
				local var_27_22 = var_27_20 <= 0 and var_27_16 or var_27_16 * (var_27_21 / var_27_20)

				if var_27_22 > 0 and var_27_16 < var_27_22 then
					arg_24_1.talkMaxDuration = var_27_22

					if var_27_22 + var_27_15 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_22 + var_27_15
					end
				end

				arg_24_1.text_.text = var_27_19
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111006", "story_v_out_101111.awb") ~= 0 then
					local var_27_23 = manager.audio:GetVoiceLength("story_v_out_101111", "101111006", "story_v_out_101111.awb") / 1000

					if var_27_23 + var_27_15 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_23 + var_27_15
					end

					if var_27_18.prefab_name ~= "" and arg_24_1.actors_[var_27_18.prefab_name] ~= nil then
						local var_27_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_18.prefab_name].transform, "story_v_out_101111", "101111006", "story_v_out_101111.awb")

						arg_24_1:RecordAudio("101111006", var_27_24)
						arg_24_1:RecordAudio("101111006", var_27_24)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_101111", "101111006", "story_v_out_101111.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_101111", "101111006", "story_v_out_101111.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_25 = math.max(var_27_16, arg_24_1.talkMaxDuration)

			if var_27_15 <= arg_24_1.time_ and arg_24_1.time_ < var_27_15 + var_27_25 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_15) / var_27_25

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_15 + var_27_25 and arg_24_1.time_ < var_27_15 + var_27_25 + arg_27_0 then
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
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play101111007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 101111007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play101111008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1019ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1019ui_story and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1019ui_story.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1019ui_story then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1019ui_story.fillRatio = var_31_5
			end

			local var_31_6 = 0
			local var_31_7 = 0.725

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_8 = arg_28_1:GetWordFromCfg(101111007)
				local var_31_9 = arg_28_1:FormatText(var_31_8.content)

				arg_28_1.text_.text = var_31_9

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_10 = 29
				local var_31_11 = utf8.len(var_31_9)
				local var_31_12 = var_31_10 <= 0 and var_31_7 or var_31_7 * (var_31_11 / var_31_10)

				if var_31_12 > 0 and var_31_7 < var_31_12 then
					arg_28_1.talkMaxDuration = var_31_12

					if var_31_12 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_12 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_9
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_13 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_13 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_13

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_13 and arg_28_1.time_ < var_31_6 + var_31_13 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play101111008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 101111008
		arg_32_1.duration_ = 4.73

		local var_32_0 = {
			ja = 2.233,
			ko = 2.8,
			zh = 3.433,
			en = 4.733
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
				arg_32_0:Play101111009(arg_32_1)
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

			local var_35_4 = 0

			if var_35_4 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_35_6 = 0
			local var_35_7 = 0.4

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_8 = arg_32_1:FormatText(StoryNameCfg[13].name)

				arg_32_1.leftNameTxt_.text = var_35_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_9 = arg_32_1:GetWordFromCfg(101111008)
				local var_35_10 = arg_32_1:FormatText(var_35_9.content)

				arg_32_1.text_.text = var_35_10

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 16
				local var_35_12 = utf8.len(var_35_10)
				local var_35_13 = var_35_11 <= 0 and var_35_7 or var_35_7 * (var_35_12 / var_35_11)

				if var_35_13 > 0 and var_35_7 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13

					if var_35_13 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_6
					end
				end

				arg_32_1.text_.text = var_35_10
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111008", "story_v_out_101111.awb") ~= 0 then
					local var_35_14 = manager.audio:GetVoiceLength("story_v_out_101111", "101111008", "story_v_out_101111.awb") / 1000

					if var_35_14 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_14 + var_35_6
					end

					if var_35_9.prefab_name ~= "" and arg_32_1.actors_[var_35_9.prefab_name] ~= nil then
						local var_35_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_9.prefab_name].transform, "story_v_out_101111", "101111008", "story_v_out_101111.awb")

						arg_32_1:RecordAudio("101111008", var_35_15)
						arg_32_1:RecordAudio("101111008", var_35_15)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_101111", "101111008", "story_v_out_101111.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_101111", "101111008", "story_v_out_101111.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_16 = math.max(var_35_7, arg_32_1.talkMaxDuration)

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_16 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_6) / var_35_16

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_6 + var_35_16 and arg_32_1.time_ < var_35_6 + var_35_16 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play101111009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 101111009
		arg_36_1.duration_ = 9.2

		local var_36_0 = {
			ja = 9.2,
			ko = 4.966,
			zh = 5.366,
			en = 7.466
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
				arg_36_0:Play101111010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = "2020_tpose"

			if arg_36_1.actors_[var_39_0] == nil then
				local var_39_1 = Asset.Load("Char/" .. "2020_tpose")

				if not isNil(var_39_1) then
					local var_39_2 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_36_1.stage_.transform)

					var_39_2.name = var_39_0
					var_39_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_36_1.actors_[var_39_0] = var_39_2

					local var_39_3 = var_39_2:GetComponentInChildren(typeof(CharacterEffect))

					var_39_3.enabled = true

					local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_2, typeof(DynamicBoneHelper))

					if var_39_4 then
						var_39_4:EnableDynamicBone(false)
					end

					arg_36_1:ShowWeapon(var_39_3.transform, false)

					arg_36_1.var_[var_39_0 .. "Animator"] = var_39_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_36_1.var_[var_39_0 .. "Animator"].applyRootMotion = true
					arg_36_1.var_[var_39_0 .. "LipSync"] = var_39_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_39_5 = arg_36_1.actors_["2020_tpose"]
			local var_39_6 = 0

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect2020_tpose == nil then
				arg_36_1.var_.characterEffect2020_tpose = var_39_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_7 = 0.1

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_7 and not isNil(var_39_5) then
				local var_39_8 = (arg_36_1.time_ - var_39_6) / var_39_7

				if arg_36_1.var_.characterEffect2020_tpose and not isNil(var_39_5) then
					arg_36_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_6 + var_39_7 and arg_36_1.time_ < var_39_6 + var_39_7 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect2020_tpose then
				arg_36_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_39_9 = arg_36_1.actors_["1019ui_story"].transform
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.var_.moveOldPos1019ui_story = var_39_9.localPosition
			end

			local var_39_11 = 0.001

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_11 then
				local var_39_12 = (arg_36_1.time_ - var_39_10) / var_39_11
				local var_39_13 = Vector3.New(0, 100, 0)

				var_39_9.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1019ui_story, var_39_13, var_39_12)

				local var_39_14 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_14.x, var_39_14.y, var_39_14.z)

				local var_39_15 = var_39_9.localEulerAngles

				var_39_15.z = 0
				var_39_15.x = 0
				var_39_9.localEulerAngles = var_39_15
			end

			if arg_36_1.time_ >= var_39_10 + var_39_11 and arg_36_1.time_ < var_39_10 + var_39_11 + arg_39_0 then
				var_39_9.localPosition = Vector3.New(0, 100, 0)

				local var_39_16 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_16.x, var_39_16.y, var_39_16.z)

				local var_39_17 = var_39_9.localEulerAngles

				var_39_17.z = 0
				var_39_17.x = 0
				var_39_9.localEulerAngles = var_39_17
			end

			local var_39_18 = arg_36_1.actors_["2020_tpose"].transform
			local var_39_19 = 0

			if var_39_19 < arg_36_1.time_ and arg_36_1.time_ <= var_39_19 + arg_39_0 then
				arg_36_1.var_.moveOldPos2020_tpose = var_39_18.localPosition

				local var_39_20 = GameObjectTools.GetOrAddComponent(var_39_18.gameObject, typeof(DynamicBoneHelper))

				if var_39_20 then
					var_39_20:EnableDynamicBone(false)
				end
			end

			local var_39_21 = 0.001

			if var_39_19 <= arg_36_1.time_ and arg_36_1.time_ < var_39_19 + var_39_21 then
				local var_39_22 = (arg_36_1.time_ - var_39_19) / var_39_21
				local var_39_23 = Vector3.New(-0.7, -1.2, -4.1)

				var_39_18.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos2020_tpose, var_39_23, var_39_22)

				local var_39_24 = manager.ui.mainCamera.transform.position - var_39_18.position

				var_39_18.forward = Vector3.New(var_39_24.x, var_39_24.y, var_39_24.z)

				local var_39_25 = var_39_18.localEulerAngles

				var_39_25.z = 0
				var_39_25.x = 0
				var_39_18.localEulerAngles = var_39_25
			end

			if arg_36_1.time_ >= var_39_19 + var_39_21 and arg_36_1.time_ < var_39_19 + var_39_21 + arg_39_0 then
				var_39_18.localPosition = Vector3.New(-0.7, -1.2, -4.1)

				local var_39_26 = manager.ui.mainCamera.transform.position - var_39_18.position

				var_39_18.forward = Vector3.New(var_39_26.x, var_39_26.y, var_39_26.z)

				local var_39_27 = var_39_18.localEulerAngles

				var_39_27.z = 0
				var_39_27.x = 0
				var_39_18.localEulerAngles = var_39_27

				local var_39_28 = GameObjectTools.GetOrAddComponent(var_39_18.gameObject, typeof(DynamicBoneHelper))

				if var_39_28 then
					var_39_28:EnableDynamicBone(true)
				end
			end

			local var_39_29 = 0

			if var_39_29 < arg_36_1.time_ and arg_36_1.time_ <= var_39_29 + arg_39_0 then
				arg_36_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_39_30 = 0
			local var_39_31 = 0.75

			if var_39_30 < arg_36_1.time_ and arg_36_1.time_ <= var_39_30 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_32 = arg_36_1:FormatText(StoryNameCfg[19].name)

				arg_36_1.leftNameTxt_.text = var_39_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_33 = arg_36_1:GetWordFromCfg(101111009)
				local var_39_34 = arg_36_1:FormatText(var_39_33.content)

				arg_36_1.text_.text = var_39_34

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_35 = 30
				local var_39_36 = utf8.len(var_39_34)
				local var_39_37 = var_39_35 <= 0 and var_39_31 or var_39_31 * (var_39_36 / var_39_35)

				if var_39_37 > 0 and var_39_31 < var_39_37 then
					arg_36_1.talkMaxDuration = var_39_37

					if var_39_37 + var_39_30 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_37 + var_39_30
					end
				end

				arg_36_1.text_.text = var_39_34
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111009", "story_v_out_101111.awb") ~= 0 then
					local var_39_38 = manager.audio:GetVoiceLength("story_v_out_101111", "101111009", "story_v_out_101111.awb") / 1000

					if var_39_38 + var_39_30 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_38 + var_39_30
					end

					if var_39_33.prefab_name ~= "" and arg_36_1.actors_[var_39_33.prefab_name] ~= nil then
						local var_39_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_33.prefab_name].transform, "story_v_out_101111", "101111009", "story_v_out_101111.awb")

						arg_36_1:RecordAudio("101111009", var_39_39)
						arg_36_1:RecordAudio("101111009", var_39_39)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_101111", "101111009", "story_v_out_101111.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_101111", "101111009", "story_v_out_101111.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_40 = math.max(var_39_31, arg_36_1.talkMaxDuration)

			if var_39_30 <= arg_36_1.time_ and arg_36_1.time_ < var_39_30 + var_39_40 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_30) / var_39_40

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_30 + var_39_40 and arg_36_1.time_ < var_39_30 + var_39_40 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play101111010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 101111010
		arg_40_1.duration_ = 9.77

		local var_40_0 = {
			ja = 9.766,
			ko = 9.5,
			zh = 8.066,
			en = 6.8
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
				arg_40_0:Play101111011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 1

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[19].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:GetWordFromCfg(101111010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 40
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111010", "story_v_out_101111.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_101111", "101111010", "story_v_out_101111.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_101111", "101111010", "story_v_out_101111.awb")

						arg_40_1:RecordAudio("101111010", var_43_9)
						arg_40_1:RecordAudio("101111010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_101111", "101111010", "story_v_out_101111.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_101111", "101111010", "story_v_out_101111.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_10 and arg_40_1.time_ < var_43_0 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play101111011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 101111011
		arg_44_1.duration_ = 12.9

		local var_44_0 = {
			ja = 12.9,
			ko = 10.2,
			zh = 6.866,
			en = 9.166
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
				arg_44_0:Play101111012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "2030_tpose"

			if arg_44_1.actors_[var_47_0] == nil then
				local var_47_1 = Asset.Load("Char/" .. "2030_tpose")

				if not isNil(var_47_1) then
					local var_47_2 = Object.Instantiate(Asset.Load("Char/" .. "2030_tpose"), arg_44_1.stage_.transform)

					var_47_2.name = var_47_0
					var_47_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_44_1.actors_[var_47_0] = var_47_2

					local var_47_3 = var_47_2:GetComponentInChildren(typeof(CharacterEffect))

					var_47_3.enabled = true

					local var_47_4 = GameObjectTools.GetOrAddComponent(var_47_2, typeof(DynamicBoneHelper))

					if var_47_4 then
						var_47_4:EnableDynamicBone(false)
					end

					arg_44_1:ShowWeapon(var_47_3.transform, false)

					arg_44_1.var_[var_47_0 .. "Animator"] = var_47_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_44_1.var_[var_47_0 .. "Animator"].applyRootMotion = true
					arg_44_1.var_[var_47_0 .. "LipSync"] = var_47_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_47_5 = arg_44_1.actors_["2030_tpose"]
			local var_47_6 = 0

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect2030_tpose == nil then
				arg_44_1.var_.characterEffect2030_tpose = var_47_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_7 = 0.1

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_7 and not isNil(var_47_5) then
				local var_47_8 = (arg_44_1.time_ - var_47_6) / var_47_7

				if arg_44_1.var_.characterEffect2030_tpose and not isNil(var_47_5) then
					arg_44_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_6 + var_47_7 and arg_44_1.time_ < var_47_6 + var_47_7 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect2030_tpose then
				arg_44_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_47_9 = arg_44_1.actors_["2020_tpose"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect2020_tpose == nil then
				arg_44_1.var_.characterEffect2020_tpose = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.1

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect2020_tpose and not isNil(var_47_9) then
					local var_47_13 = Mathf.Lerp(0, 0.5, var_47_12)

					arg_44_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_44_1.var_.characterEffect2020_tpose.fillRatio = var_47_13
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect2020_tpose then
				local var_47_14 = 0.5

				arg_44_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_44_1.var_.characterEffect2020_tpose.fillRatio = var_47_14
			end

			local var_47_15 = arg_44_1.actors_["2030_tpose"].transform
			local var_47_16 = 0

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.var_.moveOldPos2030_tpose = var_47_15.localPosition

				local var_47_17 = GameObjectTools.GetOrAddComponent(var_47_15.gameObject, typeof(DynamicBoneHelper))

				if var_47_17 then
					var_47_17:EnableDynamicBone(false)
				end
			end

			local var_47_18 = 0.001

			if var_47_16 <= arg_44_1.time_ and arg_44_1.time_ < var_47_16 + var_47_18 then
				local var_47_19 = (arg_44_1.time_ - var_47_16) / var_47_18
				local var_47_20 = Vector3.New(0.7, -1.2, -4.2)

				var_47_15.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos2030_tpose, var_47_20, var_47_19)

				local var_47_21 = manager.ui.mainCamera.transform.position - var_47_15.position

				var_47_15.forward = Vector3.New(var_47_21.x, var_47_21.y, var_47_21.z)

				local var_47_22 = var_47_15.localEulerAngles

				var_47_22.z = 0
				var_47_22.x = 0
				var_47_15.localEulerAngles = var_47_22
			end

			if arg_44_1.time_ >= var_47_16 + var_47_18 and arg_44_1.time_ < var_47_16 + var_47_18 + arg_47_0 then
				var_47_15.localPosition = Vector3.New(0.7, -1.2, -4.2)

				local var_47_23 = manager.ui.mainCamera.transform.position - var_47_15.position

				var_47_15.forward = Vector3.New(var_47_23.x, var_47_23.y, var_47_23.z)

				local var_47_24 = var_47_15.localEulerAngles

				var_47_24.z = 0
				var_47_24.x = 0
				var_47_15.localEulerAngles = var_47_24

				local var_47_25 = GameObjectTools.GetOrAddComponent(var_47_15.gameObject, typeof(DynamicBoneHelper))

				if var_47_25 then
					var_47_25:EnableDynamicBone(true)
				end
			end

			local var_47_26 = 0

			if var_47_26 < arg_44_1.time_ and arg_44_1.time_ <= var_47_26 + arg_47_0 then
				arg_44_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_47_27 = 0
			local var_47_28 = 0.925

			if var_47_27 < arg_44_1.time_ and arg_44_1.time_ <= var_47_27 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_29 = arg_44_1:FormatText(StoryNameCfg[33].name)

				arg_44_1.leftNameTxt_.text = var_47_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_30 = arg_44_1:GetWordFromCfg(101111011)
				local var_47_31 = arg_44_1:FormatText(var_47_30.content)

				arg_44_1.text_.text = var_47_31

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_32 = 36
				local var_47_33 = utf8.len(var_47_31)
				local var_47_34 = var_47_32 <= 0 and var_47_28 or var_47_28 * (var_47_33 / var_47_32)

				if var_47_34 > 0 and var_47_28 < var_47_34 then
					arg_44_1.talkMaxDuration = var_47_34

					if var_47_34 + var_47_27 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_34 + var_47_27
					end
				end

				arg_44_1.text_.text = var_47_31
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111011", "story_v_out_101111.awb") ~= 0 then
					local var_47_35 = manager.audio:GetVoiceLength("story_v_out_101111", "101111011", "story_v_out_101111.awb") / 1000

					if var_47_35 + var_47_27 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_35 + var_47_27
					end

					if var_47_30.prefab_name ~= "" and arg_44_1.actors_[var_47_30.prefab_name] ~= nil then
						local var_47_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_30.prefab_name].transform, "story_v_out_101111", "101111011", "story_v_out_101111.awb")

						arg_44_1:RecordAudio("101111011", var_47_36)
						arg_44_1:RecordAudio("101111011", var_47_36)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_101111", "101111011", "story_v_out_101111.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_101111", "101111011", "story_v_out_101111.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_37 = math.max(var_47_28, arg_44_1.talkMaxDuration)

			if var_47_27 <= arg_44_1.time_ and arg_44_1.time_ < var_47_27 + var_47_37 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_27) / var_47_37

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_27 + var_47_37 and arg_44_1.time_ < var_47_27 + var_47_37 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
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
	Play101111012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 101111012
		arg_48_1.duration_ = 10.17

		local var_48_0 = {
			ja = 10.166,
			ko = 8.2,
			zh = 9.633,
			en = 10
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
				arg_48_0:Play101111013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.975

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[33].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:GetWordFromCfg(101111012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 39
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111012", "story_v_out_101111.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_101111", "101111012", "story_v_out_101111.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_101111", "101111012", "story_v_out_101111.awb")

						arg_48_1:RecordAudio("101111012", var_51_9)
						arg_48_1:RecordAudio("101111012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_101111", "101111012", "story_v_out_101111.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_101111", "101111012", "story_v_out_101111.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_10 and arg_48_1.time_ < var_51_0 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play101111013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 101111013
		arg_52_1.duration_ = 6.83

		local var_52_0 = {
			ja = 6.833,
			ko = 6.366,
			zh = 5.866,
			en = 6.666
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
				arg_52_0:Play101111014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["2020_tpose"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect2020_tpose == nil then
				arg_52_1.var_.characterEffect2020_tpose = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect2020_tpose and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect2020_tpose then
				arg_52_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["2030_tpose"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect2030_tpose == nil then
				arg_52_1.var_.characterEffect2030_tpose = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.1

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect2030_tpose and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_52_1.var_.characterEffect2030_tpose.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect2030_tpose then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_52_1.var_.characterEffect2030_tpose.fillRatio = var_55_9
			end

			local var_55_10 = 0
			local var_55_11 = 0.85

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_12 = arg_52_1:FormatText(StoryNameCfg[19].name)

				arg_52_1.leftNameTxt_.text = var_55_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_13 = arg_52_1:GetWordFromCfg(101111013)
				local var_55_14 = arg_52_1:FormatText(var_55_13.content)

				arg_52_1.text_.text = var_55_14

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_15 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111013", "story_v_out_101111.awb") ~= 0 then
					local var_55_18 = manager.audio:GetVoiceLength("story_v_out_101111", "101111013", "story_v_out_101111.awb") / 1000

					if var_55_18 + var_55_10 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_18 + var_55_10
					end

					if var_55_13.prefab_name ~= "" and arg_52_1.actors_[var_55_13.prefab_name] ~= nil then
						local var_55_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_13.prefab_name].transform, "story_v_out_101111", "101111013", "story_v_out_101111.awb")

						arg_52_1:RecordAudio("101111013", var_55_19)
						arg_52_1:RecordAudio("101111013", var_55_19)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_101111", "101111013", "story_v_out_101111.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_101111", "101111013", "story_v_out_101111.awb")
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
	Play101111014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 101111014
		arg_56_1.duration_ = 8.8

		local var_56_0 = {
			ja = 8.8,
			ko = 6.366,
			zh = 6.133,
			en = 4.9
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
				arg_56_0:Play101111015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["2030_tpose"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect2030_tpose == nil then
				arg_56_1.var_.characterEffect2030_tpose = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect2030_tpose and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect2030_tpose then
				arg_56_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["2020_tpose"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect2020_tpose == nil then
				arg_56_1.var_.characterEffect2020_tpose = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.1

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect2020_tpose and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_56_1.var_.characterEffect2020_tpose.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect2020_tpose then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_56_1.var_.characterEffect2020_tpose.fillRatio = var_59_9
			end

			local var_59_10 = 0
			local var_59_11 = 0.65

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_12 = arg_56_1:FormatText(StoryNameCfg[33].name)

				arg_56_1.leftNameTxt_.text = var_59_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_13 = arg_56_1:GetWordFromCfg(101111014)
				local var_59_14 = arg_56_1:FormatText(var_59_13.content)

				arg_56_1.text_.text = var_59_14

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_15 = 26
				local var_59_16 = utf8.len(var_59_14)
				local var_59_17 = var_59_15 <= 0 and var_59_11 or var_59_11 * (var_59_16 / var_59_15)

				if var_59_17 > 0 and var_59_11 < var_59_17 then
					arg_56_1.talkMaxDuration = var_59_17

					if var_59_17 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_17 + var_59_10
					end
				end

				arg_56_1.text_.text = var_59_14
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111014", "story_v_out_101111.awb") ~= 0 then
					local var_59_18 = manager.audio:GetVoiceLength("story_v_out_101111", "101111014", "story_v_out_101111.awb") / 1000

					if var_59_18 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_18 + var_59_10
					end

					if var_59_13.prefab_name ~= "" and arg_56_1.actors_[var_59_13.prefab_name] ~= nil then
						local var_59_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_13.prefab_name].transform, "story_v_out_101111", "101111014", "story_v_out_101111.awb")

						arg_56_1:RecordAudio("101111014", var_59_19)
						arg_56_1:RecordAudio("101111014", var_59_19)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_101111", "101111014", "story_v_out_101111.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_101111", "101111014", "story_v_out_101111.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_20 = math.max(var_59_11, arg_56_1.talkMaxDuration)

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_20 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_10) / var_59_20

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_10 + var_59_20 and arg_56_1.time_ < var_59_10 + var_59_20 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play101111015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 101111015
		arg_60_1.duration_ = 3.93

		local var_60_0 = {
			ja = 3.933,
			ko = 3.133,
			zh = 2.366,
			en = 1.999999999999
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
				arg_60_0:Play101111016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = "1084ui_story"

			if arg_60_1.actors_[var_63_0] == nil then
				local var_63_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_63_1) then
					local var_63_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_60_1.stage_.transform)

					var_63_2.name = var_63_0
					var_63_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_60_1.actors_[var_63_0] = var_63_2

					local var_63_3 = var_63_2:GetComponentInChildren(typeof(CharacterEffect))

					var_63_3.enabled = true

					local var_63_4 = GameObjectTools.GetOrAddComponent(var_63_2, typeof(DynamicBoneHelper))

					if var_63_4 then
						var_63_4:EnableDynamicBone(false)
					end

					arg_60_1:ShowWeapon(var_63_3.transform, false)

					arg_60_1.var_[var_63_0 .. "Animator"] = var_63_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_60_1.var_[var_63_0 .. "Animator"].applyRootMotion = true
					arg_60_1.var_[var_63_0 .. "LipSync"] = var_63_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_63_5 = arg_60_1.actors_["1084ui_story"]
			local var_63_6 = 0

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 and not isNil(var_63_5) and arg_60_1.var_.characterEffect1084ui_story == nil then
				arg_60_1.var_.characterEffect1084ui_story = var_63_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_7 = 0.1

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_7 and not isNil(var_63_5) then
				local var_63_8 = (arg_60_1.time_ - var_63_6) / var_63_7

				if arg_60_1.var_.characterEffect1084ui_story and not isNil(var_63_5) then
					arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_6 + var_63_7 and arg_60_1.time_ < var_63_6 + var_63_7 + arg_63_0 and not isNil(var_63_5) and arg_60_1.var_.characterEffect1084ui_story then
				arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_63_9 = arg_60_1.actors_["2030_tpose"].transform
			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1.var_.moveOldPos2030_tpose = var_63_9.localPosition

				local var_63_11 = GameObjectTools.GetOrAddComponent(var_63_9.gameObject, typeof(DynamicBoneHelper))

				if var_63_11 then
					var_63_11:EnableDynamicBone(false)
				end
			end

			local var_63_12 = 0.001

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_12 then
				local var_63_13 = (arg_60_1.time_ - var_63_10) / var_63_12
				local var_63_14 = Vector3.New(0, 100, 0)

				var_63_9.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos2030_tpose, var_63_14, var_63_13)

				local var_63_15 = manager.ui.mainCamera.transform.position - var_63_9.position

				var_63_9.forward = Vector3.New(var_63_15.x, var_63_15.y, var_63_15.z)

				local var_63_16 = var_63_9.localEulerAngles

				var_63_16.z = 0
				var_63_16.x = 0
				var_63_9.localEulerAngles = var_63_16
			end

			if arg_60_1.time_ >= var_63_10 + var_63_12 and arg_60_1.time_ < var_63_10 + var_63_12 + arg_63_0 then
				var_63_9.localPosition = Vector3.New(0, 100, 0)

				local var_63_17 = manager.ui.mainCamera.transform.position - var_63_9.position

				var_63_9.forward = Vector3.New(var_63_17.x, var_63_17.y, var_63_17.z)

				local var_63_18 = var_63_9.localEulerAngles

				var_63_18.z = 0
				var_63_18.x = 0
				var_63_9.localEulerAngles = var_63_18

				local var_63_19 = GameObjectTools.GetOrAddComponent(var_63_9.gameObject, typeof(DynamicBoneHelper))

				if var_63_19 then
					var_63_19:EnableDynamicBone(true)
				end
			end

			local var_63_20 = arg_60_1.actors_["2020_tpose"].transform
			local var_63_21 = 0

			if var_63_21 < arg_60_1.time_ and arg_60_1.time_ <= var_63_21 + arg_63_0 then
				arg_60_1.var_.moveOldPos2020_tpose = var_63_20.localPosition

				local var_63_22 = GameObjectTools.GetOrAddComponent(var_63_20.gameObject, typeof(DynamicBoneHelper))

				if var_63_22 then
					var_63_22:EnableDynamicBone(false)
				end
			end

			local var_63_23 = 0.001

			if var_63_21 <= arg_60_1.time_ and arg_60_1.time_ < var_63_21 + var_63_23 then
				local var_63_24 = (arg_60_1.time_ - var_63_21) / var_63_23
				local var_63_25 = Vector3.New(0, 100, 0)

				var_63_20.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos2020_tpose, var_63_25, var_63_24)

				local var_63_26 = manager.ui.mainCamera.transform.position - var_63_20.position

				var_63_20.forward = Vector3.New(var_63_26.x, var_63_26.y, var_63_26.z)

				local var_63_27 = var_63_20.localEulerAngles

				var_63_27.z = 0
				var_63_27.x = 0
				var_63_20.localEulerAngles = var_63_27
			end

			if arg_60_1.time_ >= var_63_21 + var_63_23 and arg_60_1.time_ < var_63_21 + var_63_23 + arg_63_0 then
				var_63_20.localPosition = Vector3.New(0, 100, 0)

				local var_63_28 = manager.ui.mainCamera.transform.position - var_63_20.position

				var_63_20.forward = Vector3.New(var_63_28.x, var_63_28.y, var_63_28.z)

				local var_63_29 = var_63_20.localEulerAngles

				var_63_29.z = 0
				var_63_29.x = 0
				var_63_20.localEulerAngles = var_63_29

				local var_63_30 = GameObjectTools.GetOrAddComponent(var_63_20.gameObject, typeof(DynamicBoneHelper))

				if var_63_30 then
					var_63_30:EnableDynamicBone(true)
				end
			end

			local var_63_31 = arg_60_1.actors_["1084ui_story"].transform
			local var_63_32 = 0

			if var_63_32 < arg_60_1.time_ and arg_60_1.time_ <= var_63_32 + arg_63_0 then
				arg_60_1.var_.moveOldPos1084ui_story = var_63_31.localPosition
			end

			local var_63_33 = 0.001

			if var_63_32 <= arg_60_1.time_ and arg_60_1.time_ < var_63_32 + var_63_33 then
				local var_63_34 = (arg_60_1.time_ - var_63_32) / var_63_33
				local var_63_35 = Vector3.New(-0.7, -0.97, -6)

				var_63_31.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1084ui_story, var_63_35, var_63_34)

				local var_63_36 = manager.ui.mainCamera.transform.position - var_63_31.position

				var_63_31.forward = Vector3.New(var_63_36.x, var_63_36.y, var_63_36.z)

				local var_63_37 = var_63_31.localEulerAngles

				var_63_37.z = 0
				var_63_37.x = 0
				var_63_31.localEulerAngles = var_63_37
			end

			if arg_60_1.time_ >= var_63_32 + var_63_33 and arg_60_1.time_ < var_63_32 + var_63_33 + arg_63_0 then
				var_63_31.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_63_38 = manager.ui.mainCamera.transform.position - var_63_31.position

				var_63_31.forward = Vector3.New(var_63_38.x, var_63_38.y, var_63_38.z)

				local var_63_39 = var_63_31.localEulerAngles

				var_63_39.z = 0
				var_63_39.x = 0
				var_63_31.localEulerAngles = var_63_39
			end

			local var_63_40 = 0

			if var_63_40 < arg_60_1.time_ and arg_60_1.time_ <= var_63_40 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_63_41 = 0

			if var_63_41 < arg_60_1.time_ and arg_60_1.time_ <= var_63_41 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_63_42 = 0
			local var_63_43 = 0.275

			if var_63_42 < arg_60_1.time_ and arg_60_1.time_ <= var_63_42 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_44 = arg_60_1:FormatText(StoryNameCfg[6].name)

				arg_60_1.leftNameTxt_.text = var_63_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_45 = arg_60_1:GetWordFromCfg(101111015)
				local var_63_46 = arg_60_1:FormatText(var_63_45.content)

				arg_60_1.text_.text = var_63_46

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_47 = 11
				local var_63_48 = utf8.len(var_63_46)
				local var_63_49 = var_63_47 <= 0 and var_63_43 or var_63_43 * (var_63_48 / var_63_47)

				if var_63_49 > 0 and var_63_43 < var_63_49 then
					arg_60_1.talkMaxDuration = var_63_49

					if var_63_49 + var_63_42 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_49 + var_63_42
					end
				end

				arg_60_1.text_.text = var_63_46
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111015", "story_v_out_101111.awb") ~= 0 then
					local var_63_50 = manager.audio:GetVoiceLength("story_v_out_101111", "101111015", "story_v_out_101111.awb") / 1000

					if var_63_50 + var_63_42 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_50 + var_63_42
					end

					if var_63_45.prefab_name ~= "" and arg_60_1.actors_[var_63_45.prefab_name] ~= nil then
						local var_63_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_45.prefab_name].transform, "story_v_out_101111", "101111015", "story_v_out_101111.awb")

						arg_60_1:RecordAudio("101111015", var_63_51)
						arg_60_1:RecordAudio("101111015", var_63_51)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_101111", "101111015", "story_v_out_101111.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_101111", "101111015", "story_v_out_101111.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_52 = math.max(var_63_43, arg_60_1.talkMaxDuration)

			if var_63_42 <= arg_60_1.time_ and arg_60_1.time_ < var_63_42 + var_63_52 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_42) / var_63_52

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_42 + var_63_52 and arg_60_1.time_ < var_63_42 + var_63_52 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2020_tpose",
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
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play101111016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 101111016
		arg_64_1.duration_ = 2.8

		local var_64_0 = {
			ja = 2.8,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_64_0:Play101111017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1019ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1019ui_story == nil then
				arg_64_1.var_.characterEffect1019ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1019ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1019ui_story then
				arg_64_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["1084ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.1

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect1084ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1084ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1084ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1084ui_story.fillRatio = var_67_9
			end

			local var_67_10 = arg_64_1.actors_["1019ui_story"].transform
			local var_67_11 = 0

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.var_.moveOldPos1019ui_story = var_67_10.localPosition
			end

			local var_67_12 = 0.001

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_12 then
				local var_67_13 = (arg_64_1.time_ - var_67_11) / var_67_12
				local var_67_14 = Vector3.New(0.7, -1.08, -5.9)

				var_67_10.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1019ui_story, var_67_14, var_67_13)

				local var_67_15 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_15.x, var_67_15.y, var_67_15.z)

				local var_67_16 = var_67_10.localEulerAngles

				var_67_16.z = 0
				var_67_16.x = 0
				var_67_10.localEulerAngles = var_67_16
			end

			if arg_64_1.time_ >= var_67_11 + var_67_12 and arg_64_1.time_ < var_67_11 + var_67_12 + arg_67_0 then
				var_67_10.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_67_17 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_17.x, var_67_17.y, var_67_17.z)

				local var_67_18 = var_67_10.localEulerAngles

				var_67_18.z = 0
				var_67_18.x = 0
				var_67_10.localEulerAngles = var_67_18
			end

			local var_67_19 = 0

			if var_67_19 < arg_64_1.time_ and arg_64_1.time_ <= var_67_19 + arg_67_0 then
				arg_64_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action4_1")
			end

			local var_67_20 = 0

			if var_67_20 < arg_64_1.time_ and arg_64_1.time_ <= var_67_20 + arg_67_0 then
				arg_64_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_67_21 = 0
			local var_67_22 = 0.15

			if var_67_21 < arg_64_1.time_ and arg_64_1.time_ <= var_67_21 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_23 = arg_64_1:FormatText(StoryNameCfg[13].name)

				arg_64_1.leftNameTxt_.text = var_67_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_24 = arg_64_1:GetWordFromCfg(101111016)
				local var_67_25 = arg_64_1:FormatText(var_67_24.content)

				arg_64_1.text_.text = var_67_25

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_26 = 5
				local var_67_27 = utf8.len(var_67_25)
				local var_67_28 = var_67_26 <= 0 and var_67_22 or var_67_22 * (var_67_27 / var_67_26)

				if var_67_28 > 0 and var_67_22 < var_67_28 then
					arg_64_1.talkMaxDuration = var_67_28

					if var_67_28 + var_67_21 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_28 + var_67_21
					end
				end

				arg_64_1.text_.text = var_67_25
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111016", "story_v_out_101111.awb") ~= 0 then
					local var_67_29 = manager.audio:GetVoiceLength("story_v_out_101111", "101111016", "story_v_out_101111.awb") / 1000

					if var_67_29 + var_67_21 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_29 + var_67_21
					end

					if var_67_24.prefab_name ~= "" and arg_64_1.actors_[var_67_24.prefab_name] ~= nil then
						local var_67_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_24.prefab_name].transform, "story_v_out_101111", "101111016", "story_v_out_101111.awb")

						arg_64_1:RecordAudio("101111016", var_67_30)
						arg_64_1:RecordAudio("101111016", var_67_30)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_101111", "101111016", "story_v_out_101111.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_101111", "101111016", "story_v_out_101111.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_31 = math.max(var_67_22, arg_64_1.talkMaxDuration)

			if var_67_21 <= arg_64_1.time_ and arg_64_1.time_ < var_67_21 + var_67_31 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_21) / var_67_31

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_21 + var_67_31 and arg_64_1.time_ < var_67_21 + var_67_31 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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

		arg_64_1:InitPlayNodeList()
	end,
	Play101111017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 101111017
		arg_68_1.duration_ = 8.4

		local var_68_0 = {
			ja = 8.4,
			ko = 4.4,
			zh = 3.9,
			en = 5.3
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
				arg_68_0:Play101111018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["2020_tpose"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect2020_tpose == nil then
				arg_68_1.var_.characterEffect2020_tpose = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.1

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect2020_tpose and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect2020_tpose then
				arg_68_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_71_4 = arg_68_1.actors_["1019ui_story"]
			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect1019ui_story == nil then
				arg_68_1.var_.characterEffect1019ui_story = var_71_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_6 = 0.1

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 and not isNil(var_71_4) then
				local var_71_7 = (arg_68_1.time_ - var_71_5) / var_71_6

				if arg_68_1.var_.characterEffect1019ui_story and not isNil(var_71_4) then
					local var_71_8 = Mathf.Lerp(0, 0.5, var_71_7)

					arg_68_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1019ui_story.fillRatio = var_71_8
				end
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect1019ui_story then
				local var_71_9 = 0.5

				arg_68_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1019ui_story.fillRatio = var_71_9
			end

			local var_71_10 = arg_68_1.actors_["1084ui_story"].transform
			local var_71_11 = 0

			if var_71_11 < arg_68_1.time_ and arg_68_1.time_ <= var_71_11 + arg_71_0 then
				arg_68_1.var_.moveOldPos1084ui_story = var_71_10.localPosition
			end

			local var_71_12 = 0.001

			if var_71_11 <= arg_68_1.time_ and arg_68_1.time_ < var_71_11 + var_71_12 then
				local var_71_13 = (arg_68_1.time_ - var_71_11) / var_71_12
				local var_71_14 = Vector3.New(0, 100, 0)

				var_71_10.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1084ui_story, var_71_14, var_71_13)

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

			local var_71_28 = arg_68_1.actors_["2020_tpose"].transform
			local var_71_29 = 0

			if var_71_29 < arg_68_1.time_ and arg_68_1.time_ <= var_71_29 + arg_71_0 then
				arg_68_1.var_.moveOldPos2020_tpose = var_71_28.localPosition

				local var_71_30 = GameObjectTools.GetOrAddComponent(var_71_28.gameObject, typeof(DynamicBoneHelper))

				if var_71_30 then
					var_71_30:EnableDynamicBone(false)
				end
			end

			local var_71_31 = 0.001

			if var_71_29 <= arg_68_1.time_ and arg_68_1.time_ < var_71_29 + var_71_31 then
				local var_71_32 = (arg_68_1.time_ - var_71_29) / var_71_31
				local var_71_33 = Vector3.New(-0.7, -1.2, -4.1)

				var_71_28.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos2020_tpose, var_71_33, var_71_32)

				local var_71_34 = manager.ui.mainCamera.transform.position - var_71_28.position

				var_71_28.forward = Vector3.New(var_71_34.x, var_71_34.y, var_71_34.z)

				local var_71_35 = var_71_28.localEulerAngles

				var_71_35.z = 0
				var_71_35.x = 0
				var_71_28.localEulerAngles = var_71_35
			end

			if arg_68_1.time_ >= var_71_29 + var_71_31 and arg_68_1.time_ < var_71_29 + var_71_31 + arg_71_0 then
				var_71_28.localPosition = Vector3.New(-0.7, -1.2, -4.1)

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
				arg_68_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_71_40 = 0
			local var_71_41 = 0.5

			if var_71_40 < arg_68_1.time_ and arg_68_1.time_ <= var_71_40 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_42 = arg_68_1:FormatText(StoryNameCfg[19].name)

				arg_68_1.leftNameTxt_.text = var_71_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_43 = arg_68_1:GetWordFromCfg(101111017)
				local var_71_44 = arg_68_1:FormatText(var_71_43.content)

				arg_68_1.text_.text = var_71_44

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_45 = 20
				local var_71_46 = utf8.len(var_71_44)
				local var_71_47 = var_71_45 <= 0 and var_71_41 or var_71_41 * (var_71_46 / var_71_45)

				if var_71_47 > 0 and var_71_41 < var_71_47 then
					arg_68_1.talkMaxDuration = var_71_47

					if var_71_47 + var_71_40 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_47 + var_71_40
					end
				end

				arg_68_1.text_.text = var_71_44
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111017", "story_v_out_101111.awb") ~= 0 then
					local var_71_48 = manager.audio:GetVoiceLength("story_v_out_101111", "101111017", "story_v_out_101111.awb") / 1000

					if var_71_48 + var_71_40 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_48 + var_71_40
					end

					if var_71_43.prefab_name ~= "" and arg_68_1.actors_[var_71_43.prefab_name] ~= nil then
						local var_71_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_43.prefab_name].transform, "story_v_out_101111", "101111017", "story_v_out_101111.awb")

						arg_68_1:RecordAudio("101111017", var_71_49)
						arg_68_1:RecordAudio("101111017", var_71_49)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_101111", "101111017", "story_v_out_101111.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_101111", "101111017", "story_v_out_101111.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_50 = math.max(var_71_41, arg_68_1.talkMaxDuration)

			if var_71_40 <= arg_68_1.time_ and arg_68_1.time_ < var_71_40 + var_71_50 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_40) / var_71_50

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_40 + var_71_50 and arg_68_1.time_ < var_71_40 + var_71_50 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "2020_tpose",
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
	Play101111018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 101111018
		arg_72_1.duration_ = 6.73

		local var_72_0 = {
			ja = 6.733,
			ko = 5.1,
			zh = 3.633,
			en = 6.066
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
				arg_72_0:Play101111019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["2030_tpose"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect2030_tpose == nil then
				arg_72_1.var_.characterEffect2030_tpose = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect2030_tpose and not isNil(var_75_0) then
					arg_72_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect2030_tpose then
				arg_72_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_75_4 = arg_72_1.actors_["2020_tpose"]
			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect2020_tpose == nil then
				arg_72_1.var_.characterEffect2020_tpose = var_75_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_6 = 0.1

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_6 and not isNil(var_75_4) then
				local var_75_7 = (arg_72_1.time_ - var_75_5) / var_75_6

				if arg_72_1.var_.characterEffect2020_tpose and not isNil(var_75_4) then
					local var_75_8 = Mathf.Lerp(0, 0.5, var_75_7)

					arg_72_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_72_1.var_.characterEffect2020_tpose.fillRatio = var_75_8
				end
			end

			if arg_72_1.time_ >= var_75_5 + var_75_6 and arg_72_1.time_ < var_75_5 + var_75_6 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect2020_tpose then
				local var_75_9 = 0.5

				arg_72_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_72_1.var_.characterEffect2020_tpose.fillRatio = var_75_9
			end

			local var_75_10 = arg_72_1.actors_["2030_tpose"].transform
			local var_75_11 = 0

			if var_75_11 < arg_72_1.time_ and arg_72_1.time_ <= var_75_11 + arg_75_0 then
				arg_72_1.var_.moveOldPos2030_tpose = var_75_10.localPosition

				local var_75_12 = GameObjectTools.GetOrAddComponent(var_75_10.gameObject, typeof(DynamicBoneHelper))

				if var_75_12 then
					var_75_12:EnableDynamicBone(false)
				end
			end

			local var_75_13 = 0.001

			if var_75_11 <= arg_72_1.time_ and arg_72_1.time_ < var_75_11 + var_75_13 then
				local var_75_14 = (arg_72_1.time_ - var_75_11) / var_75_13
				local var_75_15 = Vector3.New(0.7, -1.2, -4.2)

				var_75_10.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos2030_tpose, var_75_15, var_75_14)

				local var_75_16 = manager.ui.mainCamera.transform.position - var_75_10.position

				var_75_10.forward = Vector3.New(var_75_16.x, var_75_16.y, var_75_16.z)

				local var_75_17 = var_75_10.localEulerAngles

				var_75_17.z = 0
				var_75_17.x = 0
				var_75_10.localEulerAngles = var_75_17
			end

			if arg_72_1.time_ >= var_75_11 + var_75_13 and arg_72_1.time_ < var_75_11 + var_75_13 + arg_75_0 then
				var_75_10.localPosition = Vector3.New(0.7, -1.2, -4.2)

				local var_75_18 = manager.ui.mainCamera.transform.position - var_75_10.position

				var_75_10.forward = Vector3.New(var_75_18.x, var_75_18.y, var_75_18.z)

				local var_75_19 = var_75_10.localEulerAngles

				var_75_19.z = 0
				var_75_19.x = 0
				var_75_10.localEulerAngles = var_75_19

				local var_75_20 = GameObjectTools.GetOrAddComponent(var_75_10.gameObject, typeof(DynamicBoneHelper))

				if var_75_20 then
					var_75_20:EnableDynamicBone(true)
				end
			end

			local var_75_21 = 0

			if var_75_21 < arg_72_1.time_ and arg_72_1.time_ <= var_75_21 + arg_75_0 then
				arg_72_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_75_22 = 0
			local var_75_23 = 0.475

			if var_75_22 < arg_72_1.time_ and arg_72_1.time_ <= var_75_22 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_24 = arg_72_1:FormatText(StoryNameCfg[33].name)

				arg_72_1.leftNameTxt_.text = var_75_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_25 = arg_72_1:GetWordFromCfg(101111018)
				local var_75_26 = arg_72_1:FormatText(var_75_25.content)

				arg_72_1.text_.text = var_75_26

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_27 = 19
				local var_75_28 = utf8.len(var_75_26)
				local var_75_29 = var_75_27 <= 0 and var_75_23 or var_75_23 * (var_75_28 / var_75_27)

				if var_75_29 > 0 and var_75_23 < var_75_29 then
					arg_72_1.talkMaxDuration = var_75_29

					if var_75_29 + var_75_22 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_29 + var_75_22
					end
				end

				arg_72_1.text_.text = var_75_26
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111018", "story_v_out_101111.awb") ~= 0 then
					local var_75_30 = manager.audio:GetVoiceLength("story_v_out_101111", "101111018", "story_v_out_101111.awb") / 1000

					if var_75_30 + var_75_22 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_30 + var_75_22
					end

					if var_75_25.prefab_name ~= "" and arg_72_1.actors_[var_75_25.prefab_name] ~= nil then
						local var_75_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_25.prefab_name].transform, "story_v_out_101111", "101111018", "story_v_out_101111.awb")

						arg_72_1:RecordAudio("101111018", var_75_31)
						arg_72_1:RecordAudio("101111018", var_75_31)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_101111", "101111018", "story_v_out_101111.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_101111", "101111018", "story_v_out_101111.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_32 = math.max(var_75_23, arg_72_1.talkMaxDuration)

			if var_75_22 <= arg_72_1.time_ and arg_72_1.time_ < var_75_22 + var_75_32 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_22) / var_75_32

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_22 + var_75_32 and arg_72_1.time_ < var_75_22 + var_75_32 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
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
	Play101111019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 101111019
		arg_76_1.duration_ = 5.93

		local var_76_0 = {
			ja = 5.933,
			ko = 3.766,
			zh = 3.966,
			en = 3.4
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
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play101111020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["2020_tpose"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect2020_tpose == nil then
				arg_76_1.var_.characterEffect2020_tpose = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect2020_tpose and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect2020_tpose then
				arg_76_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_79_4 = arg_76_1.actors_["2030_tpose"]
			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect2030_tpose == nil then
				arg_76_1.var_.characterEffect2030_tpose = var_79_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_6 = 0.1

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_6 and not isNil(var_79_4) then
				local var_79_7 = (arg_76_1.time_ - var_79_5) / var_79_6

				if arg_76_1.var_.characterEffect2030_tpose and not isNil(var_79_4) then
					local var_79_8 = Mathf.Lerp(0, 0.5, var_79_7)

					arg_76_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_76_1.var_.characterEffect2030_tpose.fillRatio = var_79_8
				end
			end

			if arg_76_1.time_ >= var_79_5 + var_79_6 and arg_76_1.time_ < var_79_5 + var_79_6 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect2030_tpose then
				local var_79_9 = 0.5

				arg_76_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_76_1.var_.characterEffect2030_tpose.fillRatio = var_79_9
			end

			local var_79_10 = 0
			local var_79_11 = 0.35

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_12 = arg_76_1:FormatText(StoryNameCfg[19].name)

				arg_76_1.leftNameTxt_.text = var_79_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_13 = arg_76_1:GetWordFromCfg(101111019)
				local var_79_14 = arg_76_1:FormatText(var_79_13.content)

				arg_76_1.text_.text = var_79_14

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_15 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111019", "story_v_out_101111.awb") ~= 0 then
					local var_79_18 = manager.audio:GetVoiceLength("story_v_out_101111", "101111019", "story_v_out_101111.awb") / 1000

					if var_79_18 + var_79_10 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_18 + var_79_10
					end

					if var_79_13.prefab_name ~= "" and arg_76_1.actors_[var_79_13.prefab_name] ~= nil then
						local var_79_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_13.prefab_name].transform, "story_v_out_101111", "101111019", "story_v_out_101111.awb")

						arg_76_1:RecordAudio("101111019", var_79_19)
						arg_76_1:RecordAudio("101111019", var_79_19)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_101111", "101111019", "story_v_out_101111.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_101111", "101111019", "story_v_out_101111.awb")
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
	Play101111020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 101111020
		arg_80_1.duration_ = 2.57

		local var_80_0 = {
			ja = 2.2,
			ko = 2.2,
			zh = 1.999999999999,
			en = 2.566
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play101111021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1084ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1084ui_story == nil then
				arg_80_1.var_.characterEffect1084ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.1

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1084ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1084ui_story then
				arg_80_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_83_4 = arg_80_1.actors_["2020_tpose"]
			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect2020_tpose == nil then
				arg_80_1.var_.characterEffect2020_tpose = var_83_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_6 = 0.1

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_6 and not isNil(var_83_4) then
				local var_83_7 = (arg_80_1.time_ - var_83_5) / var_83_6

				if arg_80_1.var_.characterEffect2020_tpose and not isNil(var_83_4) then
					local var_83_8 = Mathf.Lerp(0, 0.5, var_83_7)

					arg_80_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_80_1.var_.characterEffect2020_tpose.fillRatio = var_83_8
				end
			end

			if arg_80_1.time_ >= var_83_5 + var_83_6 and arg_80_1.time_ < var_83_5 + var_83_6 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect2020_tpose then
				local var_83_9 = 0.5

				arg_80_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_80_1.var_.characterEffect2020_tpose.fillRatio = var_83_9
			end

			local var_83_10 = arg_80_1.actors_["2030_tpose"].transform
			local var_83_11 = 0

			if var_83_11 < arg_80_1.time_ and arg_80_1.time_ <= var_83_11 + arg_83_0 then
				arg_80_1.var_.moveOldPos2030_tpose = var_83_10.localPosition

				local var_83_12 = GameObjectTools.GetOrAddComponent(var_83_10.gameObject, typeof(DynamicBoneHelper))

				if var_83_12 then
					var_83_12:EnableDynamicBone(false)
				end
			end

			local var_83_13 = 0.001

			if var_83_11 <= arg_80_1.time_ and arg_80_1.time_ < var_83_11 + var_83_13 then
				local var_83_14 = (arg_80_1.time_ - var_83_11) / var_83_13
				local var_83_15 = Vector3.New(0, 100, 0)

				var_83_10.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos2030_tpose, var_83_15, var_83_14)

				local var_83_16 = manager.ui.mainCamera.transform.position - var_83_10.position

				var_83_10.forward = Vector3.New(var_83_16.x, var_83_16.y, var_83_16.z)

				local var_83_17 = var_83_10.localEulerAngles

				var_83_17.z = 0
				var_83_17.x = 0
				var_83_10.localEulerAngles = var_83_17
			end

			if arg_80_1.time_ >= var_83_11 + var_83_13 and arg_80_1.time_ < var_83_11 + var_83_13 + arg_83_0 then
				var_83_10.localPosition = Vector3.New(0, 100, 0)

				local var_83_18 = manager.ui.mainCamera.transform.position - var_83_10.position

				var_83_10.forward = Vector3.New(var_83_18.x, var_83_18.y, var_83_18.z)

				local var_83_19 = var_83_10.localEulerAngles

				var_83_19.z = 0
				var_83_19.x = 0
				var_83_10.localEulerAngles = var_83_19

				local var_83_20 = GameObjectTools.GetOrAddComponent(var_83_10.gameObject, typeof(DynamicBoneHelper))

				if var_83_20 then
					var_83_20:EnableDynamicBone(true)
				end
			end

			local var_83_21 = arg_80_1.actors_["2020_tpose"].transform
			local var_83_22 = 0

			if var_83_22 < arg_80_1.time_ and arg_80_1.time_ <= var_83_22 + arg_83_0 then
				arg_80_1.var_.moveOldPos2020_tpose = var_83_21.localPosition

				local var_83_23 = GameObjectTools.GetOrAddComponent(var_83_21.gameObject, typeof(DynamicBoneHelper))

				if var_83_23 then
					var_83_23:EnableDynamicBone(false)
				end
			end

			local var_83_24 = 0.001

			if var_83_22 <= arg_80_1.time_ and arg_80_1.time_ < var_83_22 + var_83_24 then
				local var_83_25 = (arg_80_1.time_ - var_83_22) / var_83_24
				local var_83_26 = Vector3.New(0, 100, 0)

				var_83_21.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos2020_tpose, var_83_26, var_83_25)

				local var_83_27 = manager.ui.mainCamera.transform.position - var_83_21.position

				var_83_21.forward = Vector3.New(var_83_27.x, var_83_27.y, var_83_27.z)

				local var_83_28 = var_83_21.localEulerAngles

				var_83_28.z = 0
				var_83_28.x = 0
				var_83_21.localEulerAngles = var_83_28
			end

			if arg_80_1.time_ >= var_83_22 + var_83_24 and arg_80_1.time_ < var_83_22 + var_83_24 + arg_83_0 then
				var_83_21.localPosition = Vector3.New(0, 100, 0)

				local var_83_29 = manager.ui.mainCamera.transform.position - var_83_21.position

				var_83_21.forward = Vector3.New(var_83_29.x, var_83_29.y, var_83_29.z)

				local var_83_30 = var_83_21.localEulerAngles

				var_83_30.z = 0
				var_83_30.x = 0
				var_83_21.localEulerAngles = var_83_30

				local var_83_31 = GameObjectTools.GetOrAddComponent(var_83_21.gameObject, typeof(DynamicBoneHelper))

				if var_83_31 then
					var_83_31:EnableDynamicBone(true)
				end
			end

			local var_83_32 = arg_80_1.actors_["1084ui_story"].transform
			local var_83_33 = 0

			if var_83_33 < arg_80_1.time_ and arg_80_1.time_ <= var_83_33 + arg_83_0 then
				arg_80_1.var_.moveOldPos1084ui_story = var_83_32.localPosition
			end

			local var_83_34 = 0.001

			if var_83_33 <= arg_80_1.time_ and arg_80_1.time_ < var_83_33 + var_83_34 then
				local var_83_35 = (arg_80_1.time_ - var_83_33) / var_83_34
				local var_83_36 = Vector3.New(0, -0.97, -6)

				var_83_32.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1084ui_story, var_83_36, var_83_35)

				local var_83_37 = manager.ui.mainCamera.transform.position - var_83_32.position

				var_83_32.forward = Vector3.New(var_83_37.x, var_83_37.y, var_83_37.z)

				local var_83_38 = var_83_32.localEulerAngles

				var_83_38.z = 0
				var_83_38.x = 0
				var_83_32.localEulerAngles = var_83_38
			end

			if arg_80_1.time_ >= var_83_33 + var_83_34 and arg_80_1.time_ < var_83_33 + var_83_34 + arg_83_0 then
				var_83_32.localPosition = Vector3.New(0, -0.97, -6)

				local var_83_39 = manager.ui.mainCamera.transform.position - var_83_32.position

				var_83_32.forward = Vector3.New(var_83_39.x, var_83_39.y, var_83_39.z)

				local var_83_40 = var_83_32.localEulerAngles

				var_83_40.z = 0
				var_83_40.x = 0
				var_83_32.localEulerAngles = var_83_40
			end

			local var_83_41 = 0

			if var_83_41 < arg_80_1.time_ and arg_80_1.time_ <= var_83_41 + arg_83_0 then
				arg_80_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			local var_83_42 = 0

			if var_83_42 < arg_80_1.time_ and arg_80_1.time_ <= var_83_42 + arg_83_0 then
				arg_80_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_83_43 = 0
			local var_83_44 = 0.175

			if var_83_43 < arg_80_1.time_ and arg_80_1.time_ <= var_83_43 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_45 = arg_80_1:FormatText(StoryNameCfg[6].name)

				arg_80_1.leftNameTxt_.text = var_83_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_46 = arg_80_1:GetWordFromCfg(101111020)
				local var_83_47 = arg_80_1:FormatText(var_83_46.content)

				arg_80_1.text_.text = var_83_47

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_48 = 7
				local var_83_49 = utf8.len(var_83_47)
				local var_83_50 = var_83_48 <= 0 and var_83_44 or var_83_44 * (var_83_49 / var_83_48)

				if var_83_50 > 0 and var_83_44 < var_83_50 then
					arg_80_1.talkMaxDuration = var_83_50

					if var_83_50 + var_83_43 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_50 + var_83_43
					end
				end

				arg_80_1.text_.text = var_83_47
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111020", "story_v_out_101111.awb") ~= 0 then
					local var_83_51 = manager.audio:GetVoiceLength("story_v_out_101111", "101111020", "story_v_out_101111.awb") / 1000

					if var_83_51 + var_83_43 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_51 + var_83_43
					end

					if var_83_46.prefab_name ~= "" and arg_80_1.actors_[var_83_46.prefab_name] ~= nil then
						local var_83_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_46.prefab_name].transform, "story_v_out_101111", "101111020", "story_v_out_101111.awb")

						arg_80_1:RecordAudio("101111020", var_83_52)
						arg_80_1:RecordAudio("101111020", var_83_52)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_101111", "101111020", "story_v_out_101111.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_101111", "101111020", "story_v_out_101111.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_53 = math.max(var_83_44, arg_80_1.talkMaxDuration)

			if var_83_43 <= arg_80_1.time_ and arg_80_1.time_ < var_83_43 + var_83_53 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_43) / var_83_53

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_43 + var_83_53 and arg_80_1.time_ < var_83_43 + var_83_53 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2020_tpose",
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
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play101111021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 101111021
		arg_84_1.duration_ = 5.1

		local var_84_0 = {
			ja = 5.1,
			ko = 1.999999999999,
			zh = 2.733,
			en = 2.666
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play101111022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_2")
			end

			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_87_2 = 0

			if var_87_2 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_87_3 = arg_84_1.actors_["1084ui_story"].transform
			local var_87_4 = 0

			if var_87_4 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1.var_.moveOldPos1084ui_story = var_87_3.localPosition
			end

			local var_87_5 = 0.001

			if var_87_4 <= arg_84_1.time_ and arg_84_1.time_ < var_87_4 + var_87_5 then
				local var_87_6 = (arg_84_1.time_ - var_87_4) / var_87_5
				local var_87_7 = Vector3.New(-0.7, -0.97, -6)

				var_87_3.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1084ui_story, var_87_7, var_87_6)

				local var_87_8 = manager.ui.mainCamera.transform.position - var_87_3.position

				var_87_3.forward = Vector3.New(var_87_8.x, var_87_8.y, var_87_8.z)

				local var_87_9 = var_87_3.localEulerAngles

				var_87_9.z = 0
				var_87_9.x = 0
				var_87_3.localEulerAngles = var_87_9
			end

			if arg_84_1.time_ >= var_87_4 + var_87_5 and arg_84_1.time_ < var_87_4 + var_87_5 + arg_87_0 then
				var_87_3.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_87_10 = manager.ui.mainCamera.transform.position - var_87_3.position

				var_87_3.forward = Vector3.New(var_87_10.x, var_87_10.y, var_87_10.z)

				local var_87_11 = var_87_3.localEulerAngles

				var_87_11.z = 0
				var_87_11.x = 0
				var_87_3.localEulerAngles = var_87_11
			end

			local var_87_12 = arg_84_1.actors_["1019ui_story"].transform
			local var_87_13 = 0

			if var_87_13 < arg_84_1.time_ and arg_84_1.time_ <= var_87_13 + arg_87_0 then
				arg_84_1.var_.moveOldPos1019ui_story = var_87_12.localPosition
			end

			local var_87_14 = 0.001

			if var_87_13 <= arg_84_1.time_ and arg_84_1.time_ < var_87_13 + var_87_14 then
				local var_87_15 = (arg_84_1.time_ - var_87_13) / var_87_14
				local var_87_16 = Vector3.New(-0.2, -1.08, -5.9)

				var_87_12.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1019ui_story, var_87_16, var_87_15)

				local var_87_17 = manager.ui.mainCamera.transform.position - var_87_12.position

				var_87_12.forward = Vector3.New(var_87_17.x, var_87_17.y, var_87_17.z)

				local var_87_18 = var_87_12.localEulerAngles

				var_87_18.z = 0
				var_87_18.x = 0
				var_87_12.localEulerAngles = var_87_18
			end

			if arg_84_1.time_ >= var_87_13 + var_87_14 and arg_84_1.time_ < var_87_13 + var_87_14 + arg_87_0 then
				var_87_12.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_87_19 = manager.ui.mainCamera.transform.position - var_87_12.position

				var_87_12.forward = Vector3.New(var_87_19.x, var_87_19.y, var_87_19.z)

				local var_87_20 = var_87_12.localEulerAngles

				var_87_20.z = 0
				var_87_20.x = 0
				var_87_12.localEulerAngles = var_87_20
			end

			local var_87_21 = arg_84_1.actors_["1011ui_story"].transform
			local var_87_22 = 0

			if var_87_22 < arg_84_1.time_ and arg_84_1.time_ <= var_87_22 + arg_87_0 then
				arg_84_1.var_.moveOldPos1011ui_story = var_87_21.localPosition
			end

			local var_87_23 = 0.001

			if var_87_22 <= arg_84_1.time_ and arg_84_1.time_ < var_87_22 + var_87_23 then
				local var_87_24 = (arg_84_1.time_ - var_87_22) / var_87_23
				local var_87_25 = Vector3.New(0.7, -0.71, -6)

				var_87_21.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1011ui_story, var_87_25, var_87_24)

				local var_87_26 = manager.ui.mainCamera.transform.position - var_87_21.position

				var_87_21.forward = Vector3.New(var_87_26.x, var_87_26.y, var_87_26.z)

				local var_87_27 = var_87_21.localEulerAngles

				var_87_27.z = 0
				var_87_27.x = 0
				var_87_21.localEulerAngles = var_87_27
			end

			if arg_84_1.time_ >= var_87_22 + var_87_23 and arg_84_1.time_ < var_87_22 + var_87_23 + arg_87_0 then
				var_87_21.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_87_28 = manager.ui.mainCamera.transform.position - var_87_21.position

				var_87_21.forward = Vector3.New(var_87_28.x, var_87_28.y, var_87_28.z)

				local var_87_29 = var_87_21.localEulerAngles

				var_87_29.z = 0
				var_87_29.x = 0
				var_87_21.localEulerAngles = var_87_29
			end

			local var_87_30 = 0
			local var_87_31 = 0.275

			if var_87_30 < arg_84_1.time_ and arg_84_1.time_ <= var_87_30 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_32 = arg_84_1:FormatText(StoryNameCfg[19].name)

				arg_84_1.leftNameTxt_.text = var_87_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_33 = arg_84_1:GetWordFromCfg(101111021)
				local var_87_34 = arg_84_1:FormatText(var_87_33.content)

				arg_84_1.text_.text = var_87_34

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_35 = 11
				local var_87_36 = utf8.len(var_87_34)
				local var_87_37 = var_87_35 <= 0 and var_87_31 or var_87_31 * (var_87_36 / var_87_35)

				if var_87_37 > 0 and var_87_31 < var_87_37 then
					arg_84_1.talkMaxDuration = var_87_37

					if var_87_37 + var_87_30 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_37 + var_87_30
					end
				end

				arg_84_1.text_.text = var_87_34
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111021", "story_v_out_101111.awb") ~= 0 then
					local var_87_38 = manager.audio:GetVoiceLength("story_v_out_101111", "101111021", "story_v_out_101111.awb") / 1000

					if var_87_38 + var_87_30 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_38 + var_87_30
					end

					if var_87_33.prefab_name ~= "" and arg_84_1.actors_[var_87_33.prefab_name] ~= nil then
						local var_87_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_33.prefab_name].transform, "story_v_out_101111", "101111021", "story_v_out_101111.awb")

						arg_84_1:RecordAudio("101111021", var_87_39)
						arg_84_1:RecordAudio("101111021", var_87_39)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_101111", "101111021", "story_v_out_101111.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_101111", "101111021", "story_v_out_101111.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_40 = math.max(var_87_31, arg_84_1.talkMaxDuration)

			if var_87_30 <= arg_84_1.time_ and arg_84_1.time_ < var_87_30 + var_87_40 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_30) / var_87_40

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_30 + var_87_40 and arg_84_1.time_ < var_87_30 + var_87_40 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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

		arg_84_1:InitPlayNodeList()
	end,
	Play101111022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 101111022
		arg_88_1.duration_ = 9.03

		local var_88_0 = {
			ja = 9.033,
			ko = 8.966,
			zh = 7.133,
			en = 7.933
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play101111023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1019ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1019ui_story == nil then
				arg_88_1.var_.characterEffect1019ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.1

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1019ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1019ui_story then
				arg_88_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_91_4 = arg_88_1.actors_["1011ui_story"]
			local var_91_5 = 0

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect1011ui_story == nil then
				arg_88_1.var_.characterEffect1011ui_story = var_91_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_6 = 0.1

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_6 and not isNil(var_91_4) then
				local var_91_7 = (arg_88_1.time_ - var_91_5) / var_91_6

				if arg_88_1.var_.characterEffect1011ui_story and not isNil(var_91_4) then
					arg_88_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_5 + var_91_6 and arg_88_1.time_ < var_91_5 + var_91_6 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect1011ui_story then
				arg_88_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_91_8 = arg_88_1.actors_["1019ui_story"].transform
			local var_91_9 = 0

			if var_91_9 < arg_88_1.time_ and arg_88_1.time_ <= var_91_9 + arg_91_0 then
				arg_88_1.var_.moveOldPos1019ui_story = var_91_8.localPosition
			end

			local var_91_10 = 0.001

			if var_91_9 <= arg_88_1.time_ and arg_88_1.time_ < var_91_9 + var_91_10 then
				local var_91_11 = (arg_88_1.time_ - var_91_9) / var_91_10
				local var_91_12 = Vector3.New(-0.2, -1.08, -5.9)

				var_91_8.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1019ui_story, var_91_12, var_91_11)

				local var_91_13 = manager.ui.mainCamera.transform.position - var_91_8.position

				var_91_8.forward = Vector3.New(var_91_13.x, var_91_13.y, var_91_13.z)

				local var_91_14 = var_91_8.localEulerAngles

				var_91_14.z = 0
				var_91_14.x = 0
				var_91_8.localEulerAngles = var_91_14
			end

			if arg_88_1.time_ >= var_91_9 + var_91_10 and arg_88_1.time_ < var_91_9 + var_91_10 + arg_91_0 then
				var_91_8.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_91_15 = manager.ui.mainCamera.transform.position - var_91_8.position

				var_91_8.forward = Vector3.New(var_91_15.x, var_91_15.y, var_91_15.z)

				local var_91_16 = var_91_8.localEulerAngles

				var_91_16.z = 0
				var_91_16.x = 0
				var_91_8.localEulerAngles = var_91_16
			end

			local var_91_17 = 0

			if var_91_17 < arg_88_1.time_ and arg_88_1.time_ <= var_91_17 + arg_91_0 then
				arg_88_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_91_18 = arg_88_1.actors_["1011ui_story"].transform
			local var_91_19 = 0

			if var_91_19 < arg_88_1.time_ and arg_88_1.time_ <= var_91_19 + arg_91_0 then
				arg_88_1.var_.moveOldPos1011ui_story = var_91_18.localPosition
			end

			local var_91_20 = 0.001

			if var_91_19 <= arg_88_1.time_ and arg_88_1.time_ < var_91_19 + var_91_20 then
				local var_91_21 = (arg_88_1.time_ - var_91_19) / var_91_20
				local var_91_22 = Vector3.New(0.7, -0.71, -6)

				var_91_18.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1011ui_story, var_91_22, var_91_21)

				local var_91_23 = manager.ui.mainCamera.transform.position - var_91_18.position

				var_91_18.forward = Vector3.New(var_91_23.x, var_91_23.y, var_91_23.z)

				local var_91_24 = var_91_18.localEulerAngles

				var_91_24.z = 0
				var_91_24.x = 0
				var_91_18.localEulerAngles = var_91_24
			end

			if arg_88_1.time_ >= var_91_19 + var_91_20 and arg_88_1.time_ < var_91_19 + var_91_20 + arg_91_0 then
				var_91_18.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_91_25 = manager.ui.mainCamera.transform.position - var_91_18.position

				var_91_18.forward = Vector3.New(var_91_25.x, var_91_25.y, var_91_25.z)

				local var_91_26 = var_91_18.localEulerAngles

				var_91_26.z = 0
				var_91_26.x = 0
				var_91_18.localEulerAngles = var_91_26
			end

			local var_91_27 = 0

			if var_91_27 < arg_88_1.time_ and arg_88_1.time_ <= var_91_27 + arg_91_0 then
				arg_88_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_91_28 = 0

			if var_91_28 < arg_88_1.time_ and arg_88_1.time_ <= var_91_28 + arg_91_0 then
				arg_88_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_91_29 = 0
			local var_91_30 = 0.775

			if var_91_29 < arg_88_1.time_ and arg_88_1.time_ <= var_91_29 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_31 = arg_88_1:FormatText(StoryNameCfg[33].name)

				arg_88_1.leftNameTxt_.text = var_91_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_32 = arg_88_1:GetWordFromCfg(101111022)
				local var_91_33 = arg_88_1:FormatText(var_91_32.content)

				arg_88_1.text_.text = var_91_33

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_34 = 29
				local var_91_35 = utf8.len(var_91_33)
				local var_91_36 = var_91_34 <= 0 and var_91_30 or var_91_30 * (var_91_35 / var_91_34)

				if var_91_36 > 0 and var_91_30 < var_91_36 then
					arg_88_1.talkMaxDuration = var_91_36

					if var_91_36 + var_91_29 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_36 + var_91_29
					end
				end

				arg_88_1.text_.text = var_91_33
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111022", "story_v_out_101111.awb") ~= 0 then
					local var_91_37 = manager.audio:GetVoiceLength("story_v_out_101111", "101111022", "story_v_out_101111.awb") / 1000

					if var_91_37 + var_91_29 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_37 + var_91_29
					end

					if var_91_32.prefab_name ~= "" and arg_88_1.actors_[var_91_32.prefab_name] ~= nil then
						local var_91_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_32.prefab_name].transform, "story_v_out_101111", "101111022", "story_v_out_101111.awb")

						arg_88_1:RecordAudio("101111022", var_91_38)
						arg_88_1:RecordAudio("101111022", var_91_38)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_101111", "101111022", "story_v_out_101111.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_101111", "101111022", "story_v_out_101111.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_39 = math.max(var_91_30, arg_88_1.talkMaxDuration)

			if var_91_29 <= arg_88_1.time_ and arg_88_1.time_ < var_91_29 + var_91_39 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_29) / var_91_39

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_29 + var_91_39 and arg_88_1.time_ < var_91_29 + var_91_39 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play101111023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 101111023
		arg_92_1.duration_ = 10.27

		local var_92_0 = {
			ja = 10.266,
			ko = 8.7,
			zh = 6.433,
			en = 8.066
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play101111024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1084ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1084ui_story == nil then
				arg_92_1.var_.characterEffect1084ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.1

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1084ui_story and not isNil(var_95_0) then
					local var_95_4 = Mathf.Lerp(0, 0.5, var_95_3)

					arg_92_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1084ui_story.fillRatio = var_95_4
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1084ui_story then
				local var_95_5 = 0.5

				arg_92_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1084ui_story.fillRatio = var_95_5
			end

			local var_95_6 = arg_92_1.actors_["1019ui_story"]
			local var_95_7 = 0

			if var_95_7 < arg_92_1.time_ and arg_92_1.time_ <= var_95_7 + arg_95_0 and not isNil(var_95_6) and arg_92_1.var_.characterEffect1019ui_story == nil then
				arg_92_1.var_.characterEffect1019ui_story = var_95_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_8 = 0.1

			if var_95_7 <= arg_92_1.time_ and arg_92_1.time_ < var_95_7 + var_95_8 and not isNil(var_95_6) then
				local var_95_9 = (arg_92_1.time_ - var_95_7) / var_95_8

				if arg_92_1.var_.characterEffect1019ui_story and not isNil(var_95_6) then
					local var_95_10 = Mathf.Lerp(0, 0.5, var_95_9)

					arg_92_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1019ui_story.fillRatio = var_95_10
				end
			end

			if arg_92_1.time_ >= var_95_7 + var_95_8 and arg_92_1.time_ < var_95_7 + var_95_8 + arg_95_0 and not isNil(var_95_6) and arg_92_1.var_.characterEffect1019ui_story then
				local var_95_11 = 0.5

				arg_92_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1019ui_story.fillRatio = var_95_11
			end

			local var_95_12 = arg_92_1.actors_["1019ui_story"].transform
			local var_95_13 = 0

			if var_95_13 < arg_92_1.time_ and arg_92_1.time_ <= var_95_13 + arg_95_0 then
				arg_92_1.var_.moveOldPos1019ui_story = var_95_12.localPosition
			end

			local var_95_14 = 0.001

			if var_95_13 <= arg_92_1.time_ and arg_92_1.time_ < var_95_13 + var_95_14 then
				local var_95_15 = (arg_92_1.time_ - var_95_13) / var_95_14
				local var_95_16 = Vector3.New(0, 100, 0)

				var_95_12.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1019ui_story, var_95_16, var_95_15)

				local var_95_17 = manager.ui.mainCamera.transform.position - var_95_12.position

				var_95_12.forward = Vector3.New(var_95_17.x, var_95_17.y, var_95_17.z)

				local var_95_18 = var_95_12.localEulerAngles

				var_95_18.z = 0
				var_95_18.x = 0
				var_95_12.localEulerAngles = var_95_18
			end

			if arg_92_1.time_ >= var_95_13 + var_95_14 and arg_92_1.time_ < var_95_13 + var_95_14 + arg_95_0 then
				var_95_12.localPosition = Vector3.New(0, 100, 0)

				local var_95_19 = manager.ui.mainCamera.transform.position - var_95_12.position

				var_95_12.forward = Vector3.New(var_95_19.x, var_95_19.y, var_95_19.z)

				local var_95_20 = var_95_12.localEulerAngles

				var_95_20.z = 0
				var_95_20.x = 0
				var_95_12.localEulerAngles = var_95_20
			end

			local var_95_21 = arg_92_1.actors_["1084ui_story"].transform
			local var_95_22 = 0

			if var_95_22 < arg_92_1.time_ and arg_92_1.time_ <= var_95_22 + arg_95_0 then
				arg_92_1.var_.moveOldPos1084ui_story = var_95_21.localPosition
			end

			local var_95_23 = 0.001

			if var_95_22 <= arg_92_1.time_ and arg_92_1.time_ < var_95_22 + var_95_23 then
				local var_95_24 = (arg_92_1.time_ - var_95_22) / var_95_23
				local var_95_25 = Vector3.New(0, 100, 0)

				var_95_21.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1084ui_story, var_95_25, var_95_24)

				local var_95_26 = manager.ui.mainCamera.transform.position - var_95_21.position

				var_95_21.forward = Vector3.New(var_95_26.x, var_95_26.y, var_95_26.z)

				local var_95_27 = var_95_21.localEulerAngles

				var_95_27.z = 0
				var_95_27.x = 0
				var_95_21.localEulerAngles = var_95_27
			end

			if arg_92_1.time_ >= var_95_22 + var_95_23 and arg_92_1.time_ < var_95_22 + var_95_23 + arg_95_0 then
				var_95_21.localPosition = Vector3.New(0, 100, 0)

				local var_95_28 = manager.ui.mainCamera.transform.position - var_95_21.position

				var_95_21.forward = Vector3.New(var_95_28.x, var_95_28.y, var_95_28.z)

				local var_95_29 = var_95_21.localEulerAngles

				var_95_29.z = 0
				var_95_29.x = 0
				var_95_21.localEulerAngles = var_95_29
			end

			local var_95_30 = arg_92_1.actors_["1011ui_story"].transform
			local var_95_31 = 0

			if var_95_31 < arg_92_1.time_ and arg_92_1.time_ <= var_95_31 + arg_95_0 then
				arg_92_1.var_.moveOldPos1011ui_story = var_95_30.localPosition
			end

			local var_95_32 = 0.001

			if var_95_31 <= arg_92_1.time_ and arg_92_1.time_ < var_95_31 + var_95_32 then
				local var_95_33 = (arg_92_1.time_ - var_95_31) / var_95_32
				local var_95_34 = Vector3.New(0, -0.71, -6)

				var_95_30.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1011ui_story, var_95_34, var_95_33)

				local var_95_35 = manager.ui.mainCamera.transform.position - var_95_30.position

				var_95_30.forward = Vector3.New(var_95_35.x, var_95_35.y, var_95_35.z)

				local var_95_36 = var_95_30.localEulerAngles

				var_95_36.z = 0
				var_95_36.x = 0
				var_95_30.localEulerAngles = var_95_36
			end

			if arg_92_1.time_ >= var_95_31 + var_95_32 and arg_92_1.time_ < var_95_31 + var_95_32 + arg_95_0 then
				var_95_30.localPosition = Vector3.New(0, -0.71, -6)

				local var_95_37 = manager.ui.mainCamera.transform.position - var_95_30.position

				var_95_30.forward = Vector3.New(var_95_37.x, var_95_37.y, var_95_37.z)

				local var_95_38 = var_95_30.localEulerAngles

				var_95_38.z = 0
				var_95_38.x = 0
				var_95_30.localEulerAngles = var_95_38
			end

			local var_95_39 = 0

			if var_95_39 < arg_92_1.time_ and arg_92_1.time_ <= var_95_39 + arg_95_0 then
				arg_92_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_95_40 = 0
			local var_95_41 = 0.75

			if var_95_40 < arg_92_1.time_ and arg_92_1.time_ <= var_95_40 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_42 = arg_92_1:FormatText(StoryNameCfg[37].name)

				arg_92_1.leftNameTxt_.text = var_95_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_43 = arg_92_1:GetWordFromCfg(101111023)
				local var_95_44 = arg_92_1:FormatText(var_95_43.content)

				arg_92_1.text_.text = var_95_44

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_45 = 28
				local var_95_46 = utf8.len(var_95_44)
				local var_95_47 = var_95_45 <= 0 and var_95_41 or var_95_41 * (var_95_46 / var_95_45)

				if var_95_47 > 0 and var_95_41 < var_95_47 then
					arg_92_1.talkMaxDuration = var_95_47

					if var_95_47 + var_95_40 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_47 + var_95_40
					end
				end

				arg_92_1.text_.text = var_95_44
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111023", "story_v_out_101111.awb") ~= 0 then
					local var_95_48 = manager.audio:GetVoiceLength("story_v_out_101111", "101111023", "story_v_out_101111.awb") / 1000

					if var_95_48 + var_95_40 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_48 + var_95_40
					end

					if var_95_43.prefab_name ~= "" and arg_92_1.actors_[var_95_43.prefab_name] ~= nil then
						local var_95_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_43.prefab_name].transform, "story_v_out_101111", "101111023", "story_v_out_101111.awb")

						arg_92_1:RecordAudio("101111023", var_95_49)
						arg_92_1:RecordAudio("101111023", var_95_49)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_101111", "101111023", "story_v_out_101111.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_101111", "101111023", "story_v_out_101111.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_50 = math.max(var_95_41, arg_92_1.talkMaxDuration)

			if var_95_40 <= arg_92_1.time_ and arg_92_1.time_ < var_95_40 + var_95_50 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_40) / var_95_50

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_40 + var_95_50 and arg_92_1.time_ < var_95_40 + var_95_50 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play101111024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 101111024
		arg_96_1.duration_ = 7.4

		local var_96_0 = {
			ja = 7.4,
			ko = 3.466,
			zh = 4.7,
			en = 4.833
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play101111025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1011ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1011ui_story == nil then
				arg_96_1.var_.characterEffect1011ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.1

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1011ui_story and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1011ui_story.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1011ui_story then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1011ui_story.fillRatio = var_99_5
			end

			local var_99_6 = 0
			local var_99_7 = 0.575

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_8 = arg_96_1:FormatText(StoryNameCfg[19].name)

				arg_96_1.leftNameTxt_.text = var_99_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_9 = arg_96_1:GetWordFromCfg(101111024)
				local var_99_10 = arg_96_1:FormatText(var_99_9.content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 21
				local var_99_12 = utf8.len(var_99_10)
				local var_99_13 = var_99_11 <= 0 and var_99_7 or var_99_7 * (var_99_12 / var_99_11)

				if var_99_13 > 0 and var_99_7 < var_99_13 then
					arg_96_1.talkMaxDuration = var_99_13

					if var_99_13 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_10
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111024", "story_v_out_101111.awb") ~= 0 then
					local var_99_14 = manager.audio:GetVoiceLength("story_v_out_101111", "101111024", "story_v_out_101111.awb") / 1000

					if var_99_14 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_14 + var_99_6
					end

					if var_99_9.prefab_name ~= "" and arg_96_1.actors_[var_99_9.prefab_name] ~= nil then
						local var_99_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_9.prefab_name].transform, "story_v_out_101111", "101111024", "story_v_out_101111.awb")

						arg_96_1:RecordAudio("101111024", var_99_15)
						arg_96_1:RecordAudio("101111024", var_99_15)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_101111", "101111024", "story_v_out_101111.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_101111", "101111024", "story_v_out_101111.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_16 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_16 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_16

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_16 and arg_96_1.time_ < var_99_6 + var_99_16 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play101111025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 101111025
		arg_100_1.duration_ = 8.07

		local var_100_0 = {
			ja = 7.866,
			ko = 5.6,
			zh = 8.066,
			en = 6.4
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play101111026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 0.775

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_2 = arg_100_1:FormatText(StoryNameCfg[19].name)

				arg_100_1.leftNameTxt_.text = var_103_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:GetWordFromCfg(101111025)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 30
				local var_103_6 = utf8.len(var_103_4)
				local var_103_7 = var_103_5 <= 0 and var_103_1 or var_103_1 * (var_103_6 / var_103_5)

				if var_103_7 > 0 and var_103_1 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111025", "story_v_out_101111.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_out_101111", "101111025", "story_v_out_101111.awb") / 1000

					if var_103_8 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_0
					end

					if var_103_3.prefab_name ~= "" and arg_100_1.actors_[var_103_3.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_3.prefab_name].transform, "story_v_out_101111", "101111025", "story_v_out_101111.awb")

						arg_100_1:RecordAudio("101111025", var_103_9)
						arg_100_1:RecordAudio("101111025", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_101111", "101111025", "story_v_out_101111.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_101111", "101111025", "story_v_out_101111.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_10 and arg_100_1.time_ < var_103_0 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play101111026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 101111026
		arg_104_1.duration_ = 3.6

		local var_104_0 = {
			ja = 3.6,
			ko = 2.033,
			zh = 2.5,
			en = 2.533
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play101111027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1011ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1011ui_story == nil then
				arg_104_1.var_.characterEffect1011ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.1

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1011ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1011ui_story then
				arg_104_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_107_4 = 0

			if var_107_4 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action426")
			end

			local var_107_5 = 0

			if var_107_5 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 then
				arg_104_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_107_6 = 0
			local var_107_7 = 0.175

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_8 = arg_104_1:FormatText(StoryNameCfg[37].name)

				arg_104_1.leftNameTxt_.text = var_107_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_9 = arg_104_1:GetWordFromCfg(101111026)
				local var_107_10 = arg_104_1:FormatText(var_107_9.content)

				arg_104_1.text_.text = var_107_10

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 7
				local var_107_12 = utf8.len(var_107_10)
				local var_107_13 = var_107_11 <= 0 and var_107_7 or var_107_7 * (var_107_12 / var_107_11)

				if var_107_13 > 0 and var_107_7 < var_107_13 then
					arg_104_1.talkMaxDuration = var_107_13

					if var_107_13 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_10
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111026", "story_v_out_101111.awb") ~= 0 then
					local var_107_14 = manager.audio:GetVoiceLength("story_v_out_101111", "101111026", "story_v_out_101111.awb") / 1000

					if var_107_14 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_14 + var_107_6
					end

					if var_107_9.prefab_name ~= "" and arg_104_1.actors_[var_107_9.prefab_name] ~= nil then
						local var_107_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_9.prefab_name].transform, "story_v_out_101111", "101111026", "story_v_out_101111.awb")

						arg_104_1:RecordAudio("101111026", var_107_15)
						arg_104_1:RecordAudio("101111026", var_107_15)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_101111", "101111026", "story_v_out_101111.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_101111", "101111026", "story_v_out_101111.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_16 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_16 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_16

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_16 and arg_104_1.time_ < var_107_6 + var_107_16 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play101111027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 101111027
		arg_108_1.duration_ = 3.9

		local var_108_0 = {
			ja = 3.166,
			ko = 2.933,
			zh = 3.9,
			en = 2.6
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play101111028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 1

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				local var_111_2 = "play"
				local var_111_3 = "effect"

				arg_108_1:AudioAction(var_111_2, var_111_3, "se_story_1", "se_story_1_gun_load", "")
			end

			local var_111_4 = arg_108_1.actors_["1011ui_story"]
			local var_111_5 = 0

			if var_111_5 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect1011ui_story == nil then
				arg_108_1.var_.characterEffect1011ui_story = var_111_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_6 = 0.1

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_6 and not isNil(var_111_4) then
				local var_111_7 = (arg_108_1.time_ - var_111_5) / var_111_6

				if arg_108_1.var_.characterEffect1011ui_story and not isNil(var_111_4) then
					local var_111_8 = Mathf.Lerp(0, 0.5, var_111_7)

					arg_108_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1011ui_story.fillRatio = var_111_8
				end
			end

			if arg_108_1.time_ >= var_111_5 + var_111_6 and arg_108_1.time_ < var_111_5 + var_111_6 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect1011ui_story then
				local var_111_9 = 0.5

				arg_108_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1011ui_story.fillRatio = var_111_9
			end

			local var_111_10 = 0
			local var_111_11 = 0.45

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_12 = arg_108_1:FormatText(StoryNameCfg[19].name)

				arg_108_1.leftNameTxt_.text = var_111_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_13 = arg_108_1:GetWordFromCfg(101111027)
				local var_111_14 = arg_108_1:FormatText(var_111_13.content)

				arg_108_1.text_.text = var_111_14

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_15 = 16
				local var_111_16 = utf8.len(var_111_14)
				local var_111_17 = var_111_15 <= 0 and var_111_11 or var_111_11 * (var_111_16 / var_111_15)

				if var_111_17 > 0 and var_111_11 < var_111_17 then
					arg_108_1.talkMaxDuration = var_111_17

					if var_111_17 + var_111_10 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_17 + var_111_10
					end
				end

				arg_108_1.text_.text = var_111_14
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111027", "story_v_out_101111.awb") ~= 0 then
					local var_111_18 = manager.audio:GetVoiceLength("story_v_out_101111", "101111027", "story_v_out_101111.awb") / 1000

					if var_111_18 + var_111_10 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_18 + var_111_10
					end

					if var_111_13.prefab_name ~= "" and arg_108_1.actors_[var_111_13.prefab_name] ~= nil then
						local var_111_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_13.prefab_name].transform, "story_v_out_101111", "101111027", "story_v_out_101111.awb")

						arg_108_1:RecordAudio("101111027", var_111_19)
						arg_108_1:RecordAudio("101111027", var_111_19)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_101111", "101111027", "story_v_out_101111.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_101111", "101111027", "story_v_out_101111.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_20 = math.max(var_111_11, arg_108_1.talkMaxDuration)

			if var_111_10 <= arg_108_1.time_ and arg_108_1.time_ < var_111_10 + var_111_20 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_10) / var_111_20

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_10 + var_111_20 and arg_108_1.time_ < var_111_10 + var_111_20 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play101111028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 101111028
		arg_112_1.duration_ = 2.77

		local var_112_0 = {
			ja = 2.766,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play101111029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_115_1 = 0
			local var_115_2 = 0.125

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_3 = arg_112_1:FormatText(StoryNameCfg[33].name)

				arg_112_1.leftNameTxt_.text = var_115_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_4 = arg_112_1:GetWordFromCfg(101111028)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_6 = 5
				local var_115_7 = utf8.len(var_115_5)
				local var_115_8 = var_115_6 <= 0 and var_115_2 or var_115_2 * (var_115_7 / var_115_6)

				if var_115_8 > 0 and var_115_2 < var_115_8 then
					arg_112_1.talkMaxDuration = var_115_8

					if var_115_8 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_1
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111028", "story_v_out_101111.awb") ~= 0 then
					local var_115_9 = manager.audio:GetVoiceLength("story_v_out_101111", "101111028", "story_v_out_101111.awb") / 1000

					if var_115_9 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_1
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_out_101111", "101111028", "story_v_out_101111.awb")

						arg_112_1:RecordAudio("101111028", var_115_10)
						arg_112_1:RecordAudio("101111028", var_115_10)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_101111", "101111028", "story_v_out_101111.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_101111", "101111028", "story_v_out_101111.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_11 = math.max(var_115_2, arg_112_1.talkMaxDuration)

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_11 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_1) / var_115_11

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_1 + var_115_11 and arg_112_1.time_ < var_115_1 + var_115_11 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play101111029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 101111029
		arg_116_1.duration_ = 9.4

		local var_116_0 = {
			ja = 9.4,
			ko = 3.866,
			zh = 3.4,
			en = 2.9
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play101111030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1019ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1019ui_story == nil then
				arg_116_1.var_.characterEffect1019ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.1

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1019ui_story and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1019ui_story then
				arg_116_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_119_4 = arg_116_1.actors_["1011ui_story"].transform
			local var_119_5 = 0

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 then
				arg_116_1.var_.moveOldPos1011ui_story = var_119_4.localPosition
			end

			local var_119_6 = 0.001

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_6 then
				local var_119_7 = (arg_116_1.time_ - var_119_5) / var_119_6
				local var_119_8 = Vector3.New(0.7, -0.71, -6)

				var_119_4.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1011ui_story, var_119_8, var_119_7)

				local var_119_9 = manager.ui.mainCamera.transform.position - var_119_4.position

				var_119_4.forward = Vector3.New(var_119_9.x, var_119_9.y, var_119_9.z)

				local var_119_10 = var_119_4.localEulerAngles

				var_119_10.z = 0
				var_119_10.x = 0
				var_119_4.localEulerAngles = var_119_10
			end

			if arg_116_1.time_ >= var_119_5 + var_119_6 and arg_116_1.time_ < var_119_5 + var_119_6 + arg_119_0 then
				var_119_4.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_119_11 = manager.ui.mainCamera.transform.position - var_119_4.position

				var_119_4.forward = Vector3.New(var_119_11.x, var_119_11.y, var_119_11.z)

				local var_119_12 = var_119_4.localEulerAngles

				var_119_12.z = 0
				var_119_12.x = 0
				var_119_4.localEulerAngles = var_119_12
			end

			local var_119_13 = arg_116_1.actors_["1019ui_story"].transform
			local var_119_14 = 0

			if var_119_14 < arg_116_1.time_ and arg_116_1.time_ <= var_119_14 + arg_119_0 then
				arg_116_1.var_.moveOldPos1019ui_story = var_119_13.localPosition
			end

			local var_119_15 = 0.001

			if var_119_14 <= arg_116_1.time_ and arg_116_1.time_ < var_119_14 + var_119_15 then
				local var_119_16 = (arg_116_1.time_ - var_119_14) / var_119_15
				local var_119_17 = Vector3.New(-0.7, -1.08, -5.9)

				var_119_13.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1019ui_story, var_119_17, var_119_16)

				local var_119_18 = manager.ui.mainCamera.transform.position - var_119_13.position

				var_119_13.forward = Vector3.New(var_119_18.x, var_119_18.y, var_119_18.z)

				local var_119_19 = var_119_13.localEulerAngles

				var_119_19.z = 0
				var_119_19.x = 0
				var_119_13.localEulerAngles = var_119_19
			end

			if arg_116_1.time_ >= var_119_14 + var_119_15 and arg_116_1.time_ < var_119_14 + var_119_15 + arg_119_0 then
				var_119_13.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_119_20 = manager.ui.mainCamera.transform.position - var_119_13.position

				var_119_13.forward = Vector3.New(var_119_20.x, var_119_20.y, var_119_20.z)

				local var_119_21 = var_119_13.localEulerAngles

				var_119_21.z = 0
				var_119_21.x = 0
				var_119_13.localEulerAngles = var_119_21
			end

			local var_119_22 = 0

			if var_119_22 < arg_116_1.time_ and arg_116_1.time_ <= var_119_22 + arg_119_0 then
				arg_116_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_119_23 = 0
			local var_119_24 = 0.45

			if var_119_23 < arg_116_1.time_ and arg_116_1.time_ <= var_119_23 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_25 = arg_116_1:FormatText(StoryNameCfg[13].name)

				arg_116_1.leftNameTxt_.text = var_119_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_26 = arg_116_1:GetWordFromCfg(101111029)
				local var_119_27 = arg_116_1:FormatText(var_119_26.content)

				arg_116_1.text_.text = var_119_27

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_28 = 16
				local var_119_29 = utf8.len(var_119_27)
				local var_119_30 = var_119_28 <= 0 and var_119_24 or var_119_24 * (var_119_29 / var_119_28)

				if var_119_30 > 0 and var_119_24 < var_119_30 then
					arg_116_1.talkMaxDuration = var_119_30

					if var_119_30 + var_119_23 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_30 + var_119_23
					end
				end

				arg_116_1.text_.text = var_119_27
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111029", "story_v_out_101111.awb") ~= 0 then
					local var_119_31 = manager.audio:GetVoiceLength("story_v_out_101111", "101111029", "story_v_out_101111.awb") / 1000

					if var_119_31 + var_119_23 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_31 + var_119_23
					end

					if var_119_26.prefab_name ~= "" and arg_116_1.actors_[var_119_26.prefab_name] ~= nil then
						local var_119_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_26.prefab_name].transform, "story_v_out_101111", "101111029", "story_v_out_101111.awb")

						arg_116_1:RecordAudio("101111029", var_119_32)
						arg_116_1:RecordAudio("101111029", var_119_32)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_101111", "101111029", "story_v_out_101111.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_101111", "101111029", "story_v_out_101111.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_33 = math.max(var_119_24, arg_116_1.talkMaxDuration)

			if var_119_23 <= arg_116_1.time_ and arg_116_1.time_ < var_119_23 + var_119_33 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_23) / var_119_33

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_23 + var_119_33 and arg_116_1.time_ < var_119_23 + var_119_33 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play101111030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 101111030
		arg_120_1.duration_ = 9

		local var_120_0 = {
			ja = 9,
			ko = 6.6,
			zh = 6.5,
			en = 5.466
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
			arg_120_1.auto_ = false
		end

		function arg_120_1.playNext_(arg_122_0)
			arg_120_1.onStoryFinished_()
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action454")
			end

			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_123_2 = 0
			local var_123_3 = 0.825

			if var_123_2 < arg_120_1.time_ and arg_120_1.time_ <= var_123_2 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_4 = arg_120_1:FormatText(StoryNameCfg[13].name)

				arg_120_1.leftNameTxt_.text = var_123_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_5 = arg_120_1:GetWordFromCfg(101111030)
				local var_123_6 = arg_120_1:FormatText(var_123_5.content)

				arg_120_1.text_.text = var_123_6

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_7 = 33
				local var_123_8 = utf8.len(var_123_6)
				local var_123_9 = var_123_7 <= 0 and var_123_3 or var_123_3 * (var_123_8 / var_123_7)

				if var_123_9 > 0 and var_123_3 < var_123_9 then
					arg_120_1.talkMaxDuration = var_123_9

					if var_123_9 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_9 + var_123_2
					end
				end

				arg_120_1.text_.text = var_123_6
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101111", "101111030", "story_v_out_101111.awb") ~= 0 then
					local var_123_10 = manager.audio:GetVoiceLength("story_v_out_101111", "101111030", "story_v_out_101111.awb") / 1000

					if var_123_10 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_2
					end

					if var_123_5.prefab_name ~= "" and arg_120_1.actors_[var_123_5.prefab_name] ~= nil then
						local var_123_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_5.prefab_name].transform, "story_v_out_101111", "101111030", "story_v_out_101111.awb")

						arg_120_1:RecordAudio("101111030", var_123_11)
						arg_120_1:RecordAudio("101111030", var_123_11)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_101111", "101111030", "story_v_out_101111.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_101111", "101111030", "story_v_out_101111.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_12 = math.max(var_123_3, arg_120_1.talkMaxDuration)

			if var_123_2 <= arg_120_1.time_ and arg_120_1.time_ < var_123_2 + var_123_12 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_2) / var_123_12

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_2 + var_123_12 and arg_120_1.time_ < var_123_2 + var_123_12 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B02d"
	},
	voices = {
		"story_v_out_101111.awb"
	}
}
