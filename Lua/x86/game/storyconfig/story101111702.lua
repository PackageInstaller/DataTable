return {
	Play111172001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111172001
		arg_1_1.duration_ = 10.43

		local var_1_0 = {
			ja = 5.566,
			ko = 8.866,
			zh = 10.433,
			en = 8.766
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111172002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "D06"

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
				local var_4_5 = arg_1_1.bgs_.D06

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
					if iter_4_0 ~= "D06" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.D06
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueD06 = var_4_18.color.a
					arg_1_1.var_.alphaMatValueD06 = var_4_18
				end

				arg_1_1.var_.alphaOldValueD06 = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueD06, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueD06 then
					local var_4_22 = arg_1_1.var_.alphaMatValueD06.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueD06.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueD06 then
				local var_4_23 = arg_1_1.var_.alphaMatValueD06
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_26 = 2

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_27 = 0
			local var_4_28 = 1

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				local var_4_29 = "play"
				local var_4_30 = "music"

				arg_1_1:AudioAction(var_4_29, var_4_30, "bgm_victory_count", "bgm_count", "bgm_victory_count.awb")

				local var_4_31 = ""
				local var_4_32 = manager.audio:GetAudioName("bgm_victory_count", "bgm_count")

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
			local var_4_34 = 1.075

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_36 = arg_1_1:FormatText(StoryNameCfg[167].name)

				arg_1_1.leftNameTxt_.text = var_4_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedc")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_37 = arg_1_1:GetWordFromCfg(111172001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 38
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_34 or var_4_34 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_34 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_33 = var_4_33 + 0.3

					if var_4_41 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_33
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172001", "story_v_out_111172.awb") ~= 0 then
					local var_4_42 = manager.audio:GetVoiceLength("story_v_out_111172", "111172001", "story_v_out_111172.awb") / 1000

					if var_4_42 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_33
					end

					if var_4_37.prefab_name ~= "" and arg_1_1.actors_[var_4_37.prefab_name] ~= nil then
						local var_4_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_37.prefab_name].transform, "story_v_out_111172", "111172001", "story_v_out_111172.awb")

						arg_1_1:RecordAudio("111172001", var_4_43)
						arg_1_1:RecordAudio("111172001", var_4_43)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_111172", "111172001", "story_v_out_111172.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_111172", "111172001", "story_v_out_111172.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_44 = var_4_33 + 0.3
			local var_4_45 = math.max(var_4_34, arg_1_1.talkMaxDuration)

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_45 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_44) / var_4_45

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_44 + var_4_45 and arg_1_1.time_ < var_4_44 + var_4_45 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play111172002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 111172002
		arg_8_1.duration_ = 7.63

		local var_8_0 = {
			ja = 7.633,
			ko = 7.1,
			zh = 6.8,
			en = 5.166
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
				arg_8_0:Play111172003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1096ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1096ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1096ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1096ui_story"].transform
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.var_.moveOldPos1096ui_story = var_11_5.localPosition
			end

			local var_11_7 = 0.001

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7
				local var_11_9 = Vector3.New(0, -1.13, -5.6)

				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1096ui_story, var_11_9, var_11_8)

				local var_11_10 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_10.x, var_11_10.y, var_11_10.z)

				local var_11_11 = var_11_5.localEulerAngles

				var_11_11.z = 0
				var_11_11.x = 0
				var_11_5.localEulerAngles = var_11_11
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(0, -1.13, -5.6)

				local var_11_12 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_12.x, var_11_12.y, var_11_12.z)

				local var_11_13 = var_11_5.localEulerAngles

				var_11_13.z = 0
				var_11_13.x = 0
				var_11_5.localEulerAngles = var_11_13
			end

			local var_11_14 = 0

			if var_11_14 < arg_8_1.time_ and arg_8_1.time_ <= var_11_14 + arg_11_0 then
				arg_8_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action1_1")
			end

			local var_11_15 = 0

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 then
				arg_8_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_11_16 = arg_8_1.actors_["1096ui_story"]
			local var_11_17 = 0

			if var_11_17 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 and not isNil(var_11_16) and arg_8_1.var_.characterEffect1096ui_story == nil then
				arg_8_1.var_.characterEffect1096ui_story = var_11_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_18 = 0.2

			if var_11_17 <= arg_8_1.time_ and arg_8_1.time_ < var_11_17 + var_11_18 and not isNil(var_11_16) then
				local var_11_19 = (arg_8_1.time_ - var_11_17) / var_11_18

				if arg_8_1.var_.characterEffect1096ui_story and not isNil(var_11_16) then
					arg_8_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_17 + var_11_18 and arg_8_1.time_ < var_11_17 + var_11_18 + arg_11_0 and not isNil(var_11_16) and arg_8_1.var_.characterEffect1096ui_story then
				arg_8_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_11_20 = 0
			local var_11_21 = 0.775

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_22 = arg_8_1:FormatText(StoryNameCfg[36].name)

				arg_8_1.leftNameTxt_.text = var_11_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_23 = arg_8_1:GetWordFromCfg(111172002)
				local var_11_24 = arg_8_1:FormatText(var_11_23.content)

				arg_8_1.text_.text = var_11_24

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_25 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172002", "story_v_out_111172.awb") ~= 0 then
					local var_11_28 = manager.audio:GetVoiceLength("story_v_out_111172", "111172002", "story_v_out_111172.awb") / 1000

					if var_11_28 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_28 + var_11_20
					end

					if var_11_23.prefab_name ~= "" and arg_8_1.actors_[var_11_23.prefab_name] ~= nil then
						local var_11_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_23.prefab_name].transform, "story_v_out_111172", "111172002", "story_v_out_111172.awb")

						arg_8_1:RecordAudio("111172002", var_11_29)
						arg_8_1:RecordAudio("111172002", var_11_29)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_111172", "111172002", "story_v_out_111172.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_111172", "111172002", "story_v_out_111172.awb")
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
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play111172003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 111172003
		arg_12_1.duration_ = 10.87

		local var_12_0 = {
			ja = 10.866,
			ko = 6.7,
			zh = 6.666,
			en = 6.566
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
				arg_12_0:Play111172004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action4_1")
			end

			local var_15_2 = 0
			local var_15_3 = 0.75

			if var_15_2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_4 = arg_12_1:FormatText(StoryNameCfg[36].name)

				arg_12_1.leftNameTxt_.text = var_15_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_5 = arg_12_1:GetWordFromCfg(111172003)
				local var_15_6 = arg_12_1:FormatText(var_15_5.content)

				arg_12_1.text_.text = var_15_6

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_7 = 30
				local var_15_8 = utf8.len(var_15_6)
				local var_15_9 = var_15_7 <= 0 and var_15_3 or var_15_3 * (var_15_8 / var_15_7)

				if var_15_9 > 0 and var_15_3 < var_15_9 then
					arg_12_1.talkMaxDuration = var_15_9

					if var_15_9 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_9 + var_15_2
					end
				end

				arg_12_1.text_.text = var_15_6
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172003", "story_v_out_111172.awb") ~= 0 then
					local var_15_10 = manager.audio:GetVoiceLength("story_v_out_111172", "111172003", "story_v_out_111172.awb") / 1000

					if var_15_10 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_10 + var_15_2
					end

					if var_15_5.prefab_name ~= "" and arg_12_1.actors_[var_15_5.prefab_name] ~= nil then
						local var_15_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_5.prefab_name].transform, "story_v_out_111172", "111172003", "story_v_out_111172.awb")

						arg_12_1:RecordAudio("111172003", var_15_11)
						arg_12_1:RecordAudio("111172003", var_15_11)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_111172", "111172003", "story_v_out_111172.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_111172", "111172003", "story_v_out_111172.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_12 = math.max(var_15_3, arg_12_1.talkMaxDuration)

			if var_15_2 <= arg_12_1.time_ and arg_12_1.time_ < var_15_2 + var_15_12 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_2) / var_15_12

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_2 + var_15_12 and arg_12_1.time_ < var_15_2 + var_15_12 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play111172004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 111172004
		arg_16_1.duration_ = 11.57

		local var_16_0 = {
			ja = 9.966,
			ko = 11.566,
			zh = 8.466,
			en = 10.2
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
				arg_16_0:Play111172005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action4_2")
			end

			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_19_2 = 0
			local var_19_3 = 1.25

			if var_19_2 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_4 = arg_16_1:FormatText(StoryNameCfg[36].name)

				arg_16_1.leftNameTxt_.text = var_19_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_5 = arg_16_1:GetWordFromCfg(111172004)
				local var_19_6 = arg_16_1:FormatText(var_19_5.content)

				arg_16_1.text_.text = var_19_6

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_7 = 50
				local var_19_8 = utf8.len(var_19_6)
				local var_19_9 = var_19_7 <= 0 and var_19_3 or var_19_3 * (var_19_8 / var_19_7)

				if var_19_9 > 0 and var_19_3 < var_19_9 then
					arg_16_1.talkMaxDuration = var_19_9

					if var_19_9 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_2
					end
				end

				arg_16_1.text_.text = var_19_6
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172004", "story_v_out_111172.awb") ~= 0 then
					local var_19_10 = manager.audio:GetVoiceLength("story_v_out_111172", "111172004", "story_v_out_111172.awb") / 1000

					if var_19_10 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_2
					end

					if var_19_5.prefab_name ~= "" and arg_16_1.actors_[var_19_5.prefab_name] ~= nil then
						local var_19_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_5.prefab_name].transform, "story_v_out_111172", "111172004", "story_v_out_111172.awb")

						arg_16_1:RecordAudio("111172004", var_19_11)
						arg_16_1:RecordAudio("111172004", var_19_11)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_111172", "111172004", "story_v_out_111172.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_111172", "111172004", "story_v_out_111172.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_12 = math.max(var_19_3, arg_16_1.talkMaxDuration)

			if var_19_2 <= arg_16_1.time_ and arg_16_1.time_ < var_19_2 + var_19_12 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_2) / var_19_12

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_2 + var_19_12 and arg_16_1.time_ < var_19_2 + var_19_12 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play111172005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 111172005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play111172006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1096ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos1096ui_story = var_23_0.localPosition
			end

			local var_23_2 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2
				local var_23_4 = Vector3.New(0, 100, 0)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1096ui_story, var_23_4, var_23_3)

				local var_23_5 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_5.x, var_23_5.y, var_23_5.z)

				local var_23_6 = var_23_0.localEulerAngles

				var_23_6.z = 0
				var_23_6.x = 0
				var_23_0.localEulerAngles = var_23_6
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0, 100, 0)

				local var_23_7 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_7.x, var_23_7.y, var_23_7.z)

				local var_23_8 = var_23_0.localEulerAngles

				var_23_8.z = 0
				var_23_8.x = 0
				var_23_0.localEulerAngles = var_23_8
			end

			local var_23_9 = 0
			local var_23_10 = 1.15

			if var_23_9 < arg_20_1.time_ and arg_20_1.time_ <= var_23_9 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_11 = arg_20_1:GetWordFromCfg(111172005)
				local var_23_12 = arg_20_1:FormatText(var_23_11.content)

				arg_20_1.text_.text = var_23_12

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_13 = 46
				local var_23_14 = utf8.len(var_23_12)
				local var_23_15 = var_23_13 <= 0 and var_23_10 or var_23_10 * (var_23_14 / var_23_13)

				if var_23_15 > 0 and var_23_10 < var_23_15 then
					arg_20_1.talkMaxDuration = var_23_15

					if var_23_15 + var_23_9 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_15 + var_23_9
					end
				end

				arg_20_1.text_.text = var_23_12
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_10, arg_20_1.talkMaxDuration)

			if var_23_9 <= arg_20_1.time_ and arg_20_1.time_ < var_23_9 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_9) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_9 + var_23_16 and arg_20_1.time_ < var_23_9 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
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
	Play111172006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 111172006
		arg_24_1.duration_ = 6.07

		local var_24_0 = {
			ja = 3.2,
			ko = 4.3,
			zh = 6.066,
			en = 3.966
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
				arg_24_0:Play111172007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.2

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				local var_27_2 = "play"
				local var_27_3 = "music"

				arg_24_1:AudioAction(var_27_2, var_27_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_27_4 = ""
				local var_27_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_27_5 ~= "" then
					if arg_24_1.bgmTxt_.text ~= var_27_5 and arg_24_1.bgmTxt_.text ~= "" then
						if arg_24_1.bgmTxt2_.text ~= "" then
							arg_24_1.bgmTxt_.text = arg_24_1.bgmTxt2_.text
						end

						arg_24_1.bgmTxt2_.text = var_27_5

						arg_24_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_24_1.bgmTxt_.text = var_27_5
						arg_24_1.bgmTxt2_.text = var_27_5
					end

					if arg_24_1.bgmTimer then
						arg_24_1.bgmTimer:Stop()

						arg_24_1.bgmTimer = nil
					end

					if arg_24_1.settingData.show_music_name == 1 then
						arg_24_1.musicController:SetSelectedState("show")
						arg_24_1.musicAnimator_:Play("open", 0, 0)

						if arg_24_1.settingData.music_time ~= 0 then
							arg_24_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_24_1.settingData.music_time), function()
								if arg_24_1 == nil or isNil(arg_24_1.bgmTxt_) then
									return
								end

								arg_24_1.musicController:SetSelectedState("hide")
								arg_24_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_27_6 = 0.233333333333333
			local var_27_7 = 1

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				local var_27_8 = "play"
				local var_27_9 = "music"

				arg_24_1:AudioAction(var_27_8, var_27_9, "bgm_activity_1_1_1_hermes_story", "bgm_activity_1_1_1_hermes_story", "bgm_activity_1_1_1_hermes_story.awb")

				local var_27_10 = ""
				local var_27_11 = manager.audio:GetAudioName("bgm_activity_1_1_1_hermes_story", "bgm_activity_1_1_1_hermes_story")

				if var_27_11 ~= "" then
					if arg_24_1.bgmTxt_.text ~= var_27_11 and arg_24_1.bgmTxt_.text ~= "" then
						if arg_24_1.bgmTxt2_.text ~= "" then
							arg_24_1.bgmTxt_.text = arg_24_1.bgmTxt2_.text
						end

						arg_24_1.bgmTxt2_.text = var_27_11

						arg_24_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_24_1.bgmTxt_.text = var_27_11
						arg_24_1.bgmTxt2_.text = var_27_11
					end

					if arg_24_1.bgmTimer then
						arg_24_1.bgmTimer:Stop()

						arg_24_1.bgmTimer = nil
					end

					if arg_24_1.settingData.show_music_name == 1 then
						arg_24_1.musicController:SetSelectedState("show")
						arg_24_1.musicAnimator_:Play("open", 0, 0)

						if arg_24_1.settingData.music_time ~= 0 then
							arg_24_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_24_1.settingData.music_time), function()
								if arg_24_1 == nil or isNil(arg_24_1.bgmTxt_) then
									return
								end

								arg_24_1.musicController:SetSelectedState("hide")
								arg_24_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_27_12 = 0
			local var_27_13 = 0.5

			if var_27_12 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_14 = arg_24_1:FormatText(StoryNameCfg[167].name)

				arg_24_1.leftNameTxt_.text = var_27_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedc")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_15 = arg_24_1:GetWordFromCfg(111172006)
				local var_27_16 = arg_24_1:FormatText(var_27_15.content)

				arg_24_1.text_.text = var_27_16

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_17 = 16
				local var_27_18 = utf8.len(var_27_16)
				local var_27_19 = var_27_17 <= 0 and var_27_13 or var_27_13 * (var_27_18 / var_27_17)

				if var_27_19 > 0 and var_27_13 < var_27_19 then
					arg_24_1.talkMaxDuration = var_27_19

					if var_27_19 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_19 + var_27_12
					end
				end

				arg_24_1.text_.text = var_27_16
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172006", "story_v_out_111172.awb") ~= 0 then
					local var_27_20 = manager.audio:GetVoiceLength("story_v_out_111172", "111172006", "story_v_out_111172.awb") / 1000

					if var_27_20 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_20 + var_27_12
					end

					if var_27_15.prefab_name ~= "" and arg_24_1.actors_[var_27_15.prefab_name] ~= nil then
						local var_27_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_15.prefab_name].transform, "story_v_out_111172", "111172006", "story_v_out_111172.awb")

						arg_24_1:RecordAudio("111172006", var_27_21)
						arg_24_1:RecordAudio("111172006", var_27_21)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_111172", "111172006", "story_v_out_111172.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_111172", "111172006", "story_v_out_111172.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_22 = math.max(var_27_13, arg_24_1.talkMaxDuration)

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_22 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_12) / var_27_22

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_12 + var_27_22 and arg_24_1.time_ < var_27_12 + var_27_22 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play111172007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 111172007
		arg_30_1.duration_ = 7.57

		local var_30_0 = {
			ja = 7.566,
			ko = 7.5,
			zh = 7.166,
			en = 6.633
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play111172008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.bgs_.D06
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 then
				local var_33_2 = var_33_0:GetComponent("SpriteRenderer")

				if var_33_2 then
					arg_30_1.var_.alphaOldValueD06 = var_33_2.color.a
					arg_30_1.var_.alphaMatValueD06 = var_33_2
				end

				arg_30_1.var_.alphaOldValueD06 = 1
			end

			local var_33_3 = 1

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_3 then
				local var_33_4 = (arg_30_1.time_ - var_33_1) / var_33_3
				local var_33_5 = Mathf.Lerp(arg_30_1.var_.alphaOldValueD06, 0, var_33_4)

				if arg_30_1.var_.alphaMatValueD06 then
					local var_33_6 = arg_30_1.var_.alphaMatValueD06.color

					var_33_6.a = var_33_5
					arg_30_1.var_.alphaMatValueD06.color = var_33_6
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_3 and arg_30_1.time_ < var_33_1 + var_33_3 + arg_33_0 and arg_30_1.var_.alphaMatValueD06 then
				local var_33_7 = arg_30_1.var_.alphaMatValueD06
				local var_33_8 = var_33_7.color

				var_33_8.a = 0
				var_33_7.color = var_33_8
			end

			local var_33_9 = arg_30_1.bgs_.D06
			local var_33_10 = 1

			if var_33_10 < arg_30_1.time_ and arg_30_1.time_ <= var_33_10 + arg_33_0 then
				local var_33_11 = var_33_9:GetComponent("SpriteRenderer")

				if var_33_11 then
					arg_30_1.var_.alphaOldValueD06 = var_33_11.color.a
					arg_30_1.var_.alphaMatValueD06 = var_33_11
				end

				arg_30_1.var_.alphaOldValueD06 = 0
			end

			local var_33_12 = 1

			if var_33_10 <= arg_30_1.time_ and arg_30_1.time_ < var_33_10 + var_33_12 then
				local var_33_13 = (arg_30_1.time_ - var_33_10) / var_33_12
				local var_33_14 = Mathf.Lerp(arg_30_1.var_.alphaOldValueD06, 1, var_33_13)

				if arg_30_1.var_.alphaMatValueD06 then
					local var_33_15 = arg_30_1.var_.alphaMatValueD06.color

					var_33_15.a = var_33_14
					arg_30_1.var_.alphaMatValueD06.color = var_33_15
				end
			end

			if arg_30_1.time_ >= var_33_10 + var_33_12 and arg_30_1.time_ < var_33_10 + var_33_12 + arg_33_0 and arg_30_1.var_.alphaMatValueD06 then
				local var_33_16 = arg_30_1.var_.alphaMatValueD06
				local var_33_17 = var_33_16.color

				var_33_17.a = 1
				var_33_16.color = var_33_17
			end

			local var_33_18 = 0

			if var_33_18 < arg_30_1.time_ and arg_30_1.time_ <= var_33_18 + arg_33_0 then
				arg_30_1.allBtn_.enabled = false
			end

			local var_33_19 = 2

			if arg_30_1.time_ >= var_33_18 + var_33_19 and arg_30_1.time_ < var_33_18 + var_33_19 + arg_33_0 then
				arg_30_1.allBtn_.enabled = true
			end

			if arg_30_1.frameCnt_ <= 1 then
				arg_30_1.dialog_:SetActive(false)
			end

			local var_33_20 = 2
			local var_33_21 = 0.5

			if var_33_20 < arg_30_1.time_ and arg_30_1.time_ <= var_33_20 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				arg_30_1.dialog_:SetActive(true)

				arg_30_1.dialogCg_.alpha = 0

				local var_33_22 = LeanTween.value(arg_30_1.dialog_, 0, 1, 0.3)

				var_33_22:setOnUpdate(LuaHelper.FloatAction(function(arg_34_0)
					arg_30_1.dialogCg_.alpha = arg_34_0
				end))
				var_33_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_30_1.dialog_)
					var_33_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_30_1.duration_ = arg_30_1.duration_ + 0.3

				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_23 = arg_30_1:FormatText(StoryNameCfg[168].name)

				arg_30_1.leftNameTxt_.text = var_33_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_iris")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_24 = arg_30_1:GetWordFromCfg(111172007)
				local var_33_25 = arg_30_1:FormatText(var_33_24.content)

				arg_30_1.text_.text = var_33_25

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_26 = 20
				local var_33_27 = utf8.len(var_33_25)
				local var_33_28 = var_33_26 <= 0 and var_33_21 or var_33_21 * (var_33_27 / var_33_26)

				if var_33_28 > 0 and var_33_21 < var_33_28 then
					arg_30_1.talkMaxDuration = var_33_28
					var_33_20 = var_33_20 + 0.3

					if var_33_28 + var_33_20 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_28 + var_33_20
					end
				end

				arg_30_1.text_.text = var_33_25
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172007", "story_v_out_111172.awb") ~= 0 then
					local var_33_29 = manager.audio:GetVoiceLength("story_v_out_111172", "111172007", "story_v_out_111172.awb") / 1000

					if var_33_29 + var_33_20 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_29 + var_33_20
					end

					if var_33_24.prefab_name ~= "" and arg_30_1.actors_[var_33_24.prefab_name] ~= nil then
						local var_33_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_24.prefab_name].transform, "story_v_out_111172", "111172007", "story_v_out_111172.awb")

						arg_30_1:RecordAudio("111172007", var_33_30)
						arg_30_1:RecordAudio("111172007", var_33_30)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_111172", "111172007", "story_v_out_111172.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_111172", "111172007", "story_v_out_111172.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_31 = var_33_20 + 0.3
			local var_33_32 = math.max(var_33_21, arg_30_1.talkMaxDuration)

			if var_33_31 <= arg_30_1.time_ and arg_30_1.time_ < var_33_31 + var_33_32 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_31) / var_33_32

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_31 + var_33_32 and arg_30_1.time_ < var_33_31 + var_33_32 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play111172008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 111172008
		arg_36_1.duration_ = 9.2

		local var_36_0 = {
			ja = 9.2,
			ko = 6.366,
			zh = 6.3,
			en = 5.5
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
				arg_36_0:Play111172009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action1_1")
			end

			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_39_2 = arg_36_1.actors_["1096ui_story"]
			local var_39_3 = 0

			if var_39_3 < arg_36_1.time_ and arg_36_1.time_ <= var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1096ui_story == nil then
				arg_36_1.var_.characterEffect1096ui_story = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_4 = 0.2

			if var_39_3 <= arg_36_1.time_ and arg_36_1.time_ < var_39_3 + var_39_4 and not isNil(var_39_2) then
				local var_39_5 = (arg_36_1.time_ - var_39_3) / var_39_4

				if arg_36_1.var_.characterEffect1096ui_story and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_3 + var_39_4 and arg_36_1.time_ < var_39_3 + var_39_4 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1096ui_story then
				arg_36_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_39_6 = arg_36_1.actors_["1096ui_story"].transform
			local var_39_7 = 0

			if var_39_7 < arg_36_1.time_ and arg_36_1.time_ <= var_39_7 + arg_39_0 then
				arg_36_1.var_.moveOldPos1096ui_story = var_39_6.localPosition
			end

			local var_39_8 = 0.001

			if var_39_7 <= arg_36_1.time_ and arg_36_1.time_ < var_39_7 + var_39_8 then
				local var_39_9 = (arg_36_1.time_ - var_39_7) / var_39_8
				local var_39_10 = Vector3.New(0, -1.13, -5.6)

				var_39_6.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1096ui_story, var_39_10, var_39_9)

				local var_39_11 = manager.ui.mainCamera.transform.position - var_39_6.position

				var_39_6.forward = Vector3.New(var_39_11.x, var_39_11.y, var_39_11.z)

				local var_39_12 = var_39_6.localEulerAngles

				var_39_12.z = 0
				var_39_12.x = 0
				var_39_6.localEulerAngles = var_39_12
			end

			if arg_36_1.time_ >= var_39_7 + var_39_8 and arg_36_1.time_ < var_39_7 + var_39_8 + arg_39_0 then
				var_39_6.localPosition = Vector3.New(0, -1.13, -5.6)

				local var_39_13 = manager.ui.mainCamera.transform.position - var_39_6.position

				var_39_6.forward = Vector3.New(var_39_13.x, var_39_13.y, var_39_13.z)

				local var_39_14 = var_39_6.localEulerAngles

				var_39_14.z = 0
				var_39_14.x = 0
				var_39_6.localEulerAngles = var_39_14
			end

			local var_39_15 = 0
			local var_39_16 = 0.8

			if var_39_15 < arg_36_1.time_ and arg_36_1.time_ <= var_39_15 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_17 = arg_36_1:FormatText(StoryNameCfg[169].name)

				arg_36_1.leftNameTxt_.text = var_39_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_18 = arg_36_1:GetWordFromCfg(111172008)
				local var_39_19 = arg_36_1:FormatText(var_39_18.content)

				arg_36_1.text_.text = var_39_19

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_20 = 32
				local var_39_21 = utf8.len(var_39_19)
				local var_39_22 = var_39_20 <= 0 and var_39_16 or var_39_16 * (var_39_21 / var_39_20)

				if var_39_22 > 0 and var_39_16 < var_39_22 then
					arg_36_1.talkMaxDuration = var_39_22

					if var_39_22 + var_39_15 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_22 + var_39_15
					end
				end

				arg_36_1.text_.text = var_39_19
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172008", "story_v_out_111172.awb") ~= 0 then
					local var_39_23 = manager.audio:GetVoiceLength("story_v_out_111172", "111172008", "story_v_out_111172.awb") / 1000

					if var_39_23 + var_39_15 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_23 + var_39_15
					end

					if var_39_18.prefab_name ~= "" and arg_36_1.actors_[var_39_18.prefab_name] ~= nil then
						local var_39_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_18.prefab_name].transform, "story_v_out_111172", "111172008", "story_v_out_111172.awb")

						arg_36_1:RecordAudio("111172008", var_39_24)
						arg_36_1:RecordAudio("111172008", var_39_24)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_111172", "111172008", "story_v_out_111172.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_111172", "111172008", "story_v_out_111172.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_25 = math.max(var_39_16, arg_36_1.talkMaxDuration)

			if var_39_15 <= arg_36_1.time_ and arg_36_1.time_ < var_39_15 + var_39_25 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_15) / var_39_25

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_15 + var_39_25 and arg_36_1.time_ < var_39_15 + var_39_25 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play111172009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 111172009
		arg_40_1.duration_ = 16

		local var_40_0 = {
			ja = 16,
			ko = 11.733,
			zh = 11.3,
			en = 9.766
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
				arg_40_0:Play111172010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1096ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1096ui_story == nil then
				arg_40_1.var_.characterEffect1096ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1096ui_story and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1096ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1096ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1096ui_story.fillRatio = var_43_5
			end

			local var_43_6 = 0
			local var_43_7 = 1.325

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_8 = arg_40_1:FormatText(StoryNameCfg[168].name)

				arg_40_1.leftNameTxt_.text = var_43_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_iris")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_9 = arg_40_1:GetWordFromCfg(111172009)
				local var_43_10 = arg_40_1:FormatText(var_43_9.content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172009", "story_v_out_111172.awb") ~= 0 then
					local var_43_14 = manager.audio:GetVoiceLength("story_v_out_111172", "111172009", "story_v_out_111172.awb") / 1000

					if var_43_14 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_14 + var_43_6
					end

					if var_43_9.prefab_name ~= "" and arg_40_1.actors_[var_43_9.prefab_name] ~= nil then
						local var_43_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_9.prefab_name].transform, "story_v_out_111172", "111172009", "story_v_out_111172.awb")

						arg_40_1:RecordAudio("111172009", var_43_15)
						arg_40_1:RecordAudio("111172009", var_43_15)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_111172", "111172009", "story_v_out_111172.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_111172", "111172009", "story_v_out_111172.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_16 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_16 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_16

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_16 and arg_40_1.time_ < var_43_6 + var_43_16 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play111172010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 111172010
		arg_44_1.duration_ = 10.07

		local var_44_0 = {
			ja = 10.066,
			ko = 6.633,
			zh = 6.966,
			en = 6.3
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
				arg_44_0:Play111172011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_47_1 = arg_44_1.actors_["1096ui_story"]
			local var_47_2 = 0

			if var_47_2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1096ui_story == nil then
				arg_44_1.var_.characterEffect1096ui_story = var_47_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.2

			if var_47_2 <= arg_44_1.time_ and arg_44_1.time_ < var_47_2 + var_47_3 and not isNil(var_47_1) then
				local var_47_4 = (arg_44_1.time_ - var_47_2) / var_47_3

				if arg_44_1.var_.characterEffect1096ui_story and not isNil(var_47_1) then
					arg_44_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_2 + var_47_3 and arg_44_1.time_ < var_47_2 + var_47_3 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1096ui_story then
				arg_44_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_47_5 = 0
			local var_47_6 = 0.775

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_7 = arg_44_1:FormatText(StoryNameCfg[169].name)

				arg_44_1.leftNameTxt_.text = var_47_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_8 = arg_44_1:GetWordFromCfg(111172010)
				local var_47_9 = arg_44_1:FormatText(var_47_8.content)

				arg_44_1.text_.text = var_47_9

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_10 = 26
				local var_47_11 = utf8.len(var_47_9)
				local var_47_12 = var_47_10 <= 0 and var_47_6 or var_47_6 * (var_47_11 / var_47_10)

				if var_47_12 > 0 and var_47_6 < var_47_12 then
					arg_44_1.talkMaxDuration = var_47_12

					if var_47_12 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_12 + var_47_5
					end
				end

				arg_44_1.text_.text = var_47_9
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172010", "story_v_out_111172.awb") ~= 0 then
					local var_47_13 = manager.audio:GetVoiceLength("story_v_out_111172", "111172010", "story_v_out_111172.awb") / 1000

					if var_47_13 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_5
					end

					if var_47_8.prefab_name ~= "" and arg_44_1.actors_[var_47_8.prefab_name] ~= nil then
						local var_47_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_8.prefab_name].transform, "story_v_out_111172", "111172010", "story_v_out_111172.awb")

						arg_44_1:RecordAudio("111172010", var_47_14)
						arg_44_1:RecordAudio("111172010", var_47_14)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_111172", "111172010", "story_v_out_111172.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_111172", "111172010", "story_v_out_111172.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_15 = math.max(var_47_6, arg_44_1.talkMaxDuration)

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_15 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_5) / var_47_15

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_5 + var_47_15 and arg_44_1.time_ < var_47_5 + var_47_15 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play111172011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 111172011
		arg_48_1.duration_ = 4.77

		local var_48_0 = {
			ja = 3.933,
			ko = 3.566,
			zh = 4.766,
			en = 3.766
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
				arg_48_0:Play111172012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1096ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1096ui_story == nil then
				arg_48_1.var_.characterEffect1096ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.2

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1096ui_story and not isNil(var_51_0) then
					local var_51_4 = Mathf.Lerp(0, 0.5, var_51_3)

					arg_48_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1096ui_story.fillRatio = var_51_4
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1096ui_story then
				local var_51_5 = 0.5

				arg_48_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1096ui_story.fillRatio = var_51_5
			end

			local var_51_6 = 0
			local var_51_7 = 0.4

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_8 = arg_48_1:FormatText(StoryNameCfg[168].name)

				arg_48_1.leftNameTxt_.text = var_51_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_iris")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_9 = arg_48_1:GetWordFromCfg(111172011)
				local var_51_10 = arg_48_1:FormatText(var_51_9.content)

				arg_48_1.text_.text = var_51_10

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 16
				local var_51_12 = utf8.len(var_51_10)
				local var_51_13 = var_51_11 <= 0 and var_51_7 or var_51_7 * (var_51_12 / var_51_11)

				if var_51_13 > 0 and var_51_7 < var_51_13 then
					arg_48_1.talkMaxDuration = var_51_13

					if var_51_13 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_10
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172011", "story_v_out_111172.awb") ~= 0 then
					local var_51_14 = manager.audio:GetVoiceLength("story_v_out_111172", "111172011", "story_v_out_111172.awb") / 1000

					if var_51_14 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_14 + var_51_6
					end

					if var_51_9.prefab_name ~= "" and arg_48_1.actors_[var_51_9.prefab_name] ~= nil then
						local var_51_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_9.prefab_name].transform, "story_v_out_111172", "111172011", "story_v_out_111172.awb")

						arg_48_1:RecordAudio("111172011", var_51_15)
						arg_48_1:RecordAudio("111172011", var_51_15)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_111172", "111172011", "story_v_out_111172.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_111172", "111172011", "story_v_out_111172.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_16 = math.max(var_51_7, arg_48_1.talkMaxDuration)

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_16 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_6) / var_51_16

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_6 + var_51_16 and arg_48_1.time_ < var_51_6 + var_51_16 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play111172012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 111172012
		arg_52_1.duration_ = 3.73

		local var_52_0 = {
			ja = 3.733,
			ko = 1.999999999999,
			zh = 2.4,
			en = 1.999999999999
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
				arg_52_0:Play111172013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_55_1 = arg_52_1.actors_["1096ui_story"]
			local var_55_2 = 0

			if var_55_2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1096ui_story == nil then
				arg_52_1.var_.characterEffect1096ui_story = var_55_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.2

			if var_55_2 <= arg_52_1.time_ and arg_52_1.time_ < var_55_2 + var_55_3 and not isNil(var_55_1) then
				local var_55_4 = (arg_52_1.time_ - var_55_2) / var_55_3

				if arg_52_1.var_.characterEffect1096ui_story and not isNil(var_55_1) then
					arg_52_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_2 + var_55_3 and arg_52_1.time_ < var_55_2 + var_55_3 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1096ui_story then
				arg_52_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action5_1")
			end

			local var_55_6 = 0
			local var_55_7 = 0.175

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_8 = arg_52_1:FormatText(StoryNameCfg[169].name)

				arg_52_1.leftNameTxt_.text = var_55_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_9 = arg_52_1:GetWordFromCfg(111172012)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 3
				local var_55_12 = utf8.len(var_55_10)
				local var_55_13 = var_55_11 <= 0 and var_55_7 or var_55_7 * (var_55_12 / var_55_11)

				if var_55_13 > 0 and var_55_7 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_6
					end
				end

				arg_52_1.text_.text = var_55_10
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172012", "story_v_out_111172.awb") ~= 0 then
					local var_55_14 = manager.audio:GetVoiceLength("story_v_out_111172", "111172012", "story_v_out_111172.awb") / 1000

					if var_55_14 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_6
					end

					if var_55_9.prefab_name ~= "" and arg_52_1.actors_[var_55_9.prefab_name] ~= nil then
						local var_55_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_9.prefab_name].transform, "story_v_out_111172", "111172012", "story_v_out_111172.awb")

						arg_52_1:RecordAudio("111172012", var_55_15)
						arg_52_1:RecordAudio("111172012", var_55_15)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_111172", "111172012", "story_v_out_111172.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_111172", "111172012", "story_v_out_111172.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_16 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_16 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_16

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_16 and arg_52_1.time_ < var_55_6 + var_55_16 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play111172013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 111172013
		arg_56_1.duration_ = 11.1

		local var_56_0 = {
			ja = 9.7,
			ko = 7.566,
			zh = 11.1,
			en = 9.3
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
				arg_56_0:Play111172014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1096ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1096ui_story == nil then
				arg_56_1.var_.characterEffect1096ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.2

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1096ui_story and not isNil(var_59_0) then
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1096ui_story.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1096ui_story then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1096ui_story.fillRatio = var_59_5
			end

			local var_59_6 = 0
			local var_59_7 = 1.025

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_8 = arg_56_1:FormatText(StoryNameCfg[168].name)

				arg_56_1.leftNameTxt_.text = var_59_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_iris")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_9 = arg_56_1:GetWordFromCfg(111172013)
				local var_59_10 = arg_56_1:FormatText(var_59_9.content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 37
				local var_59_12 = utf8.len(var_59_10)
				local var_59_13 = var_59_11 <= 0 and var_59_7 or var_59_7 * (var_59_12 / var_59_11)

				if var_59_13 > 0 and var_59_7 < var_59_13 then
					arg_56_1.talkMaxDuration = var_59_13

					if var_59_13 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172013", "story_v_out_111172.awb") ~= 0 then
					local var_59_14 = manager.audio:GetVoiceLength("story_v_out_111172", "111172013", "story_v_out_111172.awb") / 1000

					if var_59_14 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_14 + var_59_6
					end

					if var_59_9.prefab_name ~= "" and arg_56_1.actors_[var_59_9.prefab_name] ~= nil then
						local var_59_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_9.prefab_name].transform, "story_v_out_111172", "111172013", "story_v_out_111172.awb")

						arg_56_1:RecordAudio("111172013", var_59_15)
						arg_56_1:RecordAudio("111172013", var_59_15)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_111172", "111172013", "story_v_out_111172.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_111172", "111172013", "story_v_out_111172.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_16 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_16 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_16

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_16 and arg_56_1.time_ < var_59_6 + var_59_16 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play111172014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 111172014
		arg_60_1.duration_ = 12.93

		local var_60_0 = {
			ja = 12.933,
			ko = 9.4,
			zh = 7.9,
			en = 8.966
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
				arg_60_0:Play111172015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action5_2")
			end

			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_63_2 = arg_60_1.actors_["1096ui_story"]
			local var_63_3 = 0

			if var_63_3 < arg_60_1.time_ and arg_60_1.time_ <= var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1096ui_story == nil then
				arg_60_1.var_.characterEffect1096ui_story = var_63_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_4 = 0.2

			if var_63_3 <= arg_60_1.time_ and arg_60_1.time_ < var_63_3 + var_63_4 and not isNil(var_63_2) then
				local var_63_5 = (arg_60_1.time_ - var_63_3) / var_63_4

				if arg_60_1.var_.characterEffect1096ui_story and not isNil(var_63_2) then
					arg_60_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_3 + var_63_4 and arg_60_1.time_ < var_63_3 + var_63_4 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1096ui_story then
				arg_60_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_63_6 = 0
			local var_63_7 = 1.05

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_8 = arg_60_1:FormatText(StoryNameCfg[169].name)

				arg_60_1.leftNameTxt_.text = var_63_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_9 = arg_60_1:GetWordFromCfg(111172014)
				local var_63_10 = arg_60_1:FormatText(var_63_9.content)

				arg_60_1.text_.text = var_63_10

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_11 = 42
				local var_63_12 = utf8.len(var_63_10)
				local var_63_13 = var_63_11 <= 0 and var_63_7 or var_63_7 * (var_63_12 / var_63_11)

				if var_63_13 > 0 and var_63_7 < var_63_13 then
					arg_60_1.talkMaxDuration = var_63_13

					if var_63_13 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_13 + var_63_6
					end
				end

				arg_60_1.text_.text = var_63_10
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172014", "story_v_out_111172.awb") ~= 0 then
					local var_63_14 = manager.audio:GetVoiceLength("story_v_out_111172", "111172014", "story_v_out_111172.awb") / 1000

					if var_63_14 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_14 + var_63_6
					end

					if var_63_9.prefab_name ~= "" and arg_60_1.actors_[var_63_9.prefab_name] ~= nil then
						local var_63_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_9.prefab_name].transform, "story_v_out_111172", "111172014", "story_v_out_111172.awb")

						arg_60_1:RecordAudio("111172014", var_63_15)
						arg_60_1:RecordAudio("111172014", var_63_15)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_111172", "111172014", "story_v_out_111172.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_111172", "111172014", "story_v_out_111172.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_16 = math.max(var_63_7, arg_60_1.talkMaxDuration)

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_16 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_6) / var_63_16

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_6 + var_63_16 and arg_60_1.time_ < var_63_6 + var_63_16 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play111172015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 111172015
		arg_64_1.duration_ = 13.8

		local var_64_0 = {
			ja = 13.8,
			ko = 9,
			zh = 8.8,
			en = 10.066
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
				arg_64_0:Play111172016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1096ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1096ui_story == nil then
				arg_64_1.var_.characterEffect1096ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1096ui_story and not isNil(var_67_0) then
					local var_67_4 = Mathf.Lerp(0, 0.5, var_67_3)

					arg_64_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1096ui_story.fillRatio = var_67_4
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1096ui_story then
				local var_67_5 = 0.5

				arg_64_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1096ui_story.fillRatio = var_67_5
			end

			local var_67_6 = 0
			local var_67_7 = 1.125

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_8 = arg_64_1:FormatText(StoryNameCfg[168].name)

				arg_64_1.leftNameTxt_.text = var_67_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_iris")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_9 = arg_64_1:GetWordFromCfg(111172015)
				local var_67_10 = arg_64_1:FormatText(var_67_9.content)

				arg_64_1.text_.text = var_67_10

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_11 = 45
				local var_67_12 = utf8.len(var_67_10)
				local var_67_13 = var_67_11 <= 0 and var_67_7 or var_67_7 * (var_67_12 / var_67_11)

				if var_67_13 > 0 and var_67_7 < var_67_13 then
					arg_64_1.talkMaxDuration = var_67_13

					if var_67_13 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_13 + var_67_6
					end
				end

				arg_64_1.text_.text = var_67_10
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172015", "story_v_out_111172.awb") ~= 0 then
					local var_67_14 = manager.audio:GetVoiceLength("story_v_out_111172", "111172015", "story_v_out_111172.awb") / 1000

					if var_67_14 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_14 + var_67_6
					end

					if var_67_9.prefab_name ~= "" and arg_64_1.actors_[var_67_9.prefab_name] ~= nil then
						local var_67_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_9.prefab_name].transform, "story_v_out_111172", "111172015", "story_v_out_111172.awb")

						arg_64_1:RecordAudio("111172015", var_67_15)
						arg_64_1:RecordAudio("111172015", var_67_15)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_111172", "111172015", "story_v_out_111172.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_111172", "111172015", "story_v_out_111172.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_16 = math.max(var_67_7, arg_64_1.talkMaxDuration)

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_16 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_6) / var_67_16

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_6 + var_67_16 and arg_64_1.time_ < var_67_6 + var_67_16 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play111172016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 111172016
		arg_68_1.duration_ = 3.23

		local var_68_0 = {
			ja = 2.9,
			ko = 3.233,
			zh = 2.9,
			en = 2.833
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
				arg_68_0:Play111172017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1096ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1096ui_story == nil then
				arg_68_1.var_.characterEffect1096ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1096ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1096ui_story then
				arg_68_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_71_4 = 0

			if var_71_4 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_71_5 = 0
			local var_71_6 = 0.25

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_7 = arg_68_1:FormatText(StoryNameCfg[169].name)

				arg_68_1.leftNameTxt_.text = var_71_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_8 = arg_68_1:GetWordFromCfg(111172016)
				local var_71_9 = arg_68_1:FormatText(var_71_8.content)

				arg_68_1.text_.text = var_71_9

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_10 = 10
				local var_71_11 = utf8.len(var_71_9)
				local var_71_12 = var_71_10 <= 0 and var_71_6 or var_71_6 * (var_71_11 / var_71_10)

				if var_71_12 > 0 and var_71_6 < var_71_12 then
					arg_68_1.talkMaxDuration = var_71_12

					if var_71_12 + var_71_5 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_12 + var_71_5
					end
				end

				arg_68_1.text_.text = var_71_9
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172016", "story_v_out_111172.awb") ~= 0 then
					local var_71_13 = manager.audio:GetVoiceLength("story_v_out_111172", "111172016", "story_v_out_111172.awb") / 1000

					if var_71_13 + var_71_5 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_13 + var_71_5
					end

					if var_71_8.prefab_name ~= "" and arg_68_1.actors_[var_71_8.prefab_name] ~= nil then
						local var_71_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_8.prefab_name].transform, "story_v_out_111172", "111172016", "story_v_out_111172.awb")

						arg_68_1:RecordAudio("111172016", var_71_14)
						arg_68_1:RecordAudio("111172016", var_71_14)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_111172", "111172016", "story_v_out_111172.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_111172", "111172016", "story_v_out_111172.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_15 = math.max(var_71_6, arg_68_1.talkMaxDuration)

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_15 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_5) / var_71_15

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_5 + var_71_15 and arg_68_1.time_ < var_71_5 + var_71_15 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play111172017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 111172017
		arg_72_1.duration_ = 5.5

		local var_72_0 = {
			ja = 5.5,
			ko = 4.466,
			zh = 5.2,
			en = 4.733
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
				arg_72_0:Play111172018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1096ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1096ui_story == nil then
				arg_72_1.var_.characterEffect1096ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.2

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1096ui_story and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1096ui_story.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1096ui_story then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1096ui_story.fillRatio = var_75_5
			end

			if arg_72_1.frameCnt_ <= 1 then
				arg_72_1.dialog_:SetActive(false)
			end

			local var_75_6 = 1
			local var_75_7 = 0.45

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				arg_72_1.dialog_:SetActive(true)

				arg_72_1.dialogCg_.alpha = 0

				local var_75_8 = LeanTween.value(arg_72_1.dialog_, 0, 1, 0.3)

				var_75_8:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_72_1.dialogCg_.alpha = arg_76_0
				end))
				var_75_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_72_1.dialog_)
					var_75_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_72_1.duration_ = arg_72_1.duration_ + 0.3

				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_9 = arg_72_1:FormatText(StoryNameCfg[13].name)

				arg_72_1.leftNameTxt_.text = var_75_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_10 = arg_72_1:GetWordFromCfg(111172017)
				local var_75_11 = arg_72_1:FormatText(var_75_10.content)

				arg_72_1.text_.text = var_75_11

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_12 = 18
				local var_75_13 = utf8.len(var_75_11)
				local var_75_14 = var_75_12 <= 0 and var_75_7 or var_75_7 * (var_75_13 / var_75_12)

				if var_75_14 > 0 and var_75_7 < var_75_14 then
					arg_72_1.talkMaxDuration = var_75_14
					var_75_6 = var_75_6 + 0.3

					if var_75_14 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_14 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_11
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172017", "story_v_out_111172.awb") ~= 0 then
					local var_75_15 = manager.audio:GetVoiceLength("story_v_out_111172", "111172017", "story_v_out_111172.awb") / 1000

					if var_75_15 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_15 + var_75_6
					end

					if var_75_10.prefab_name ~= "" and arg_72_1.actors_[var_75_10.prefab_name] ~= nil then
						local var_75_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_10.prefab_name].transform, "story_v_out_111172", "111172017", "story_v_out_111172.awb")

						arg_72_1:RecordAudio("111172017", var_75_16)
						arg_72_1:RecordAudio("111172017", var_75_16)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_111172", "111172017", "story_v_out_111172.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_111172", "111172017", "story_v_out_111172.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_17 = var_75_6 + 0.3
			local var_75_18 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_17 <= arg_72_1.time_ and arg_72_1.time_ < var_75_17 + var_75_18 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_17) / var_75_18

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_17 + var_75_18 and arg_72_1.time_ < var_75_17 + var_75_18 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play111172018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 111172018
		arg_78_1.duration_ = 3.83

		local var_78_0 = {
			ja = 3.733,
			ko = 3.833,
			zh = 3.266,
			en = 3.466
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play111172019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_81_1 = arg_78_1.actors_["1096ui_story"]
			local var_81_2 = 0

			if var_81_2 < arg_78_1.time_ and arg_78_1.time_ <= var_81_2 + arg_81_0 and not isNil(var_81_1) and arg_78_1.var_.characterEffect1096ui_story == nil then
				arg_78_1.var_.characterEffect1096ui_story = var_81_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_3 = 0.2

			if var_81_2 <= arg_78_1.time_ and arg_78_1.time_ < var_81_2 + var_81_3 and not isNil(var_81_1) then
				local var_81_4 = (arg_78_1.time_ - var_81_2) / var_81_3

				if arg_78_1.var_.characterEffect1096ui_story and not isNil(var_81_1) then
					arg_78_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_2 + var_81_3 and arg_78_1.time_ < var_81_2 + var_81_3 + arg_81_0 and not isNil(var_81_1) and arg_78_1.var_.characterEffect1096ui_story then
				arg_78_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_81_5 = 0

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action4_1")
			end

			local var_81_6 = 0
			local var_81_7 = 0.475

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_8 = arg_78_1:FormatText(StoryNameCfg[169].name)

				arg_78_1.leftNameTxt_.text = var_81_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_9 = arg_78_1:GetWordFromCfg(111172018)
				local var_81_10 = arg_78_1:FormatText(var_81_9.content)

				arg_78_1.text_.text = var_81_10

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_11 = 15
				local var_81_12 = utf8.len(var_81_10)
				local var_81_13 = var_81_11 <= 0 and var_81_7 or var_81_7 * (var_81_12 / var_81_11)

				if var_81_13 > 0 and var_81_7 < var_81_13 then
					arg_78_1.talkMaxDuration = var_81_13

					if var_81_13 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_13 + var_81_6
					end
				end

				arg_78_1.text_.text = var_81_10
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172018", "story_v_out_111172.awb") ~= 0 then
					local var_81_14 = manager.audio:GetVoiceLength("story_v_out_111172", "111172018", "story_v_out_111172.awb") / 1000

					if var_81_14 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_14 + var_81_6
					end

					if var_81_9.prefab_name ~= "" and arg_78_1.actors_[var_81_9.prefab_name] ~= nil then
						local var_81_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_9.prefab_name].transform, "story_v_out_111172", "111172018", "story_v_out_111172.awb")

						arg_78_1:RecordAudio("111172018", var_81_15)
						arg_78_1:RecordAudio("111172018", var_81_15)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_111172", "111172018", "story_v_out_111172.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_111172", "111172018", "story_v_out_111172.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_16 = math.max(var_81_7, arg_78_1.talkMaxDuration)

			if var_81_6 <= arg_78_1.time_ and arg_78_1.time_ < var_81_6 + var_81_16 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_6) / var_81_16

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_6 + var_81_16 and arg_78_1.time_ < var_81_6 + var_81_16 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play111172019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 111172019
		arg_82_1.duration_ = 4.63

		local var_82_0 = {
			ja = 4.5,
			ko = 3.4,
			zh = 4.633,
			en = 4.466
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play111172020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1096ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1096ui_story == nil then
				arg_82_1.var_.characterEffect1096ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.2

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect1096ui_story and not isNil(var_85_0) then
					local var_85_4 = Mathf.Lerp(0, 0.5, var_85_3)

					arg_82_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1096ui_story.fillRatio = var_85_4
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1096ui_story then
				local var_85_5 = 0.5

				arg_82_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1096ui_story.fillRatio = var_85_5
			end

			local var_85_6 = 0
			local var_85_7 = 0.375

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_8 = arg_82_1:FormatText(StoryNameCfg[13].name)

				arg_82_1.leftNameTxt_.text = var_85_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_9 = arg_82_1:GetWordFromCfg(111172019)
				local var_85_10 = arg_82_1:FormatText(var_85_9.content)

				arg_82_1.text_.text = var_85_10

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_11 = 15
				local var_85_12 = utf8.len(var_85_10)
				local var_85_13 = var_85_11 <= 0 and var_85_7 or var_85_7 * (var_85_12 / var_85_11)

				if var_85_13 > 0 and var_85_7 < var_85_13 then
					arg_82_1.talkMaxDuration = var_85_13

					if var_85_13 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_13 + var_85_6
					end
				end

				arg_82_1.text_.text = var_85_10
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172019", "story_v_out_111172.awb") ~= 0 then
					local var_85_14 = manager.audio:GetVoiceLength("story_v_out_111172", "111172019", "story_v_out_111172.awb") / 1000

					if var_85_14 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_14 + var_85_6
					end

					if var_85_9.prefab_name ~= "" and arg_82_1.actors_[var_85_9.prefab_name] ~= nil then
						local var_85_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_9.prefab_name].transform, "story_v_out_111172", "111172019", "story_v_out_111172.awb")

						arg_82_1:RecordAudio("111172019", var_85_15)
						arg_82_1:RecordAudio("111172019", var_85_15)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_111172", "111172019", "story_v_out_111172.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_111172", "111172019", "story_v_out_111172.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_16 = math.max(var_85_7, arg_82_1.talkMaxDuration)

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_16 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_6) / var_85_16

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_6 + var_85_16 and arg_82_1.time_ < var_85_6 + var_85_16 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play111172020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 111172020
		arg_86_1.duration_ = 7.23

		local var_86_0 = {
			ja = 7.233,
			ko = 5.233,
			zh = 5.4,
			en = 5.8
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play111172021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1096ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1096ui_story == nil then
				arg_86_1.var_.characterEffect1096ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.2

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect1096ui_story and not isNil(var_89_0) then
					arg_86_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1096ui_story then
				arg_86_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_89_4 = 0

			if var_89_4 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_89_5 = 0

			if var_89_5 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 then
				arg_86_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action4_2")
			end

			local var_89_6 = 0
			local var_89_7 = 0.575

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_8 = arg_86_1:FormatText(StoryNameCfg[169].name)

				arg_86_1.leftNameTxt_.text = var_89_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_9 = arg_86_1:GetWordFromCfg(111172020)
				local var_89_10 = arg_86_1:FormatText(var_89_9.content)

				arg_86_1.text_.text = var_89_10

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_11 = 24
				local var_89_12 = utf8.len(var_89_10)
				local var_89_13 = var_89_11 <= 0 and var_89_7 or var_89_7 * (var_89_12 / var_89_11)

				if var_89_13 > 0 and var_89_7 < var_89_13 then
					arg_86_1.talkMaxDuration = var_89_13

					if var_89_13 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_13 + var_89_6
					end
				end

				arg_86_1.text_.text = var_89_10
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172020", "story_v_out_111172.awb") ~= 0 then
					local var_89_14 = manager.audio:GetVoiceLength("story_v_out_111172", "111172020", "story_v_out_111172.awb") / 1000

					if var_89_14 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_14 + var_89_6
					end

					if var_89_9.prefab_name ~= "" and arg_86_1.actors_[var_89_9.prefab_name] ~= nil then
						local var_89_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_9.prefab_name].transform, "story_v_out_111172", "111172020", "story_v_out_111172.awb")

						arg_86_1:RecordAudio("111172020", var_89_15)
						arg_86_1:RecordAudio("111172020", var_89_15)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_111172", "111172020", "story_v_out_111172.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_111172", "111172020", "story_v_out_111172.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_16 = math.max(var_89_7, arg_86_1.talkMaxDuration)

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_16 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_6) / var_89_16

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_6 + var_89_16 and arg_86_1.time_ < var_89_6 + var_89_16 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play111172021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 111172021
		arg_90_1.duration_ = 6.93

		local var_90_0 = {
			ja = 4.466,
			ko = 6.933,
			zh = 6.1,
			en = 4.966
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
			arg_90_1.auto_ = false
		end

		function arg_90_1.playNext_(arg_92_0)
			arg_90_1.onStoryFinished_()
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1096ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1096ui_story == nil then
				arg_90_1.var_.characterEffect1096ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.2

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1096ui_story and not isNil(var_93_0) then
					local var_93_4 = Mathf.Lerp(0, 0.5, var_93_3)

					arg_90_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1096ui_story.fillRatio = var_93_4
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1096ui_story then
				local var_93_5 = 0.5

				arg_90_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1096ui_story.fillRatio = var_93_5
			end

			local var_93_6 = 0
			local var_93_7 = 0.8

			if var_93_6 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_8 = arg_90_1:FormatText(StoryNameCfg[32].name)

				arg_90_1.leftNameTxt_.text = var_93_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_9 = arg_90_1:GetWordFromCfg(111172021)
				local var_93_10 = arg_90_1:FormatText(var_93_9.content)

				arg_90_1.text_.text = var_93_10

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_11 = 32
				local var_93_12 = utf8.len(var_93_10)
				local var_93_13 = var_93_11 <= 0 and var_93_7 or var_93_7 * (var_93_12 / var_93_11)

				if var_93_13 > 0 and var_93_7 < var_93_13 then
					arg_90_1.talkMaxDuration = var_93_13

					if var_93_13 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_6
					end
				end

				arg_90_1.text_.text = var_93_10
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111172", "111172021", "story_v_out_111172.awb") ~= 0 then
					local var_93_14 = manager.audio:GetVoiceLength("story_v_out_111172", "111172021", "story_v_out_111172.awb") / 1000

					if var_93_14 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_14 + var_93_6
					end

					if var_93_9.prefab_name ~= "" and arg_90_1.actors_[var_93_9.prefab_name] ~= nil then
						local var_93_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_9.prefab_name].transform, "story_v_out_111172", "111172021", "story_v_out_111172.awb")

						arg_90_1:RecordAudio("111172021", var_93_15)
						arg_90_1:RecordAudio("111172021", var_93_15)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_111172", "111172021", "story_v_out_111172.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_111172", "111172021", "story_v_out_111172.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_16 = math.max(var_93_7, arg_90_1.talkMaxDuration)

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_16 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_6) / var_93_16

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_6 + var_93_16 and arg_90_1.time_ < var_93_6 + var_93_16 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D06"
	},
	voices = {
		"story_v_out_111172.awb"
	}
}
